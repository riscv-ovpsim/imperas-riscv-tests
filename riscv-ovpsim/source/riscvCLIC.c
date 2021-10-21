/*
 * Copyright (c) 2005-2021 Imperas Software Ltd., www.imperas.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

// Imperas header files
#include "hostapi/impAlloc.h"

// VMI header files
#include "vmi/vmiMessage.h"
#include "vmi/vmiRt.h"

// model header files
#include "riscvCLIC.h"
#include "riscvCLICTypes.h"
#include "riscvCluster.h"
#include "riscvExceptions.h"
#include "riscvMessage.h"
#include "riscvStructure.h"
#include "riscvTypeRefs.h"


//
// Type of CLIC page being accessed
//
typedef enum CLICPageTypeE {
    CPT_C,  // control page
    CPT_M,  // Machine mode page
    CPT_S,  // Supervisor mode page
    CPT_U,  // User mode page
} CLICPageType;

//
// This enumerates byte-sized CLIC interrupt control fields
//
typedef enum CLICIntFieldTypeE {
    CIT_clicintip   = 0,
    CIT_clicintie   = 1,
    CIT_clicintattr = 2,
    CIT_clicintctl  = 3,
    CIT_LAST
} CLICIntFieldType;

//
// State for a single interrupt
//
typedef union riscvCLICIntStateU {
    Uns8  fields[CIT_LAST];
    Uns32 value32;
} riscvCLICIntState;

//
// Return page type name
//
static const char *mapCLICPageTypeName(CLICPageType type) {

    static const char *map[] = {
        [CPT_C] = "Control",
        [CPT_M] = "Machine",
        [CPT_S] = "Supervisor",
        [CPT_U] = "User",
    };

    return map[type];
}

//
// Return the number of hart contexts in a cluster
//
inline static Uns32 getNumHarts(riscvP root) {
    return root->numHarts;
}

//
// Return CLIC scope object
//
inline static riscvP getCLICRoot(riscvP riscv) {
    return riscv->clusterRoot;
}

//
// Return the base address of the cluster CLIC block
//
inline static Uns64 getCLICLow(riscvP root) {
    return root->configInfo.csr.mclicbase.u64.bits;
}

//
// Indicate whether software may set a level-sensitive interrupt pending
//
inline static Bool mayPendLevel(riscvP hart) {
    return hart->configInfo.CLIC_version==RVCLC_0_9_20191208;
}

//
// Return the page index of the given offset
//
inline static Uns32 getCLICPage(Uns32 offset) {
    return offset/4096;
}

//
// Return the word index of the offset within a page
//
inline static Uns32 getCLICPageWord(Uns32 offset) {
    return (offset%4096)/4;
}

//
// Return the word index of the offset within a page
//
inline static Uns32 getCLICIntIndex(Uns32 offset) {
    return ((offset-4096)/4)%4096;
}

//
// Return the byte index of the offset within a word
//
inline static Uns32 getCLICWordByte(Uns32 offset) {
    return offset%4;
}

//
// Return type of an interrupt field accessed at the given offset
//
inline static CLICIntFieldType getCLICIntFieldType(Uns32 offset) {
    return getCLICWordByte(offset);
}

//
// Convert from 1k CLIC page index to 4k interrupt page index
//
inline static Uns32 get4kIntPage(Uns32 page) {
    return (page-1)/4;
}

//
// Return the CLIC page type being accessed at the given offset
//
static CLICPageType getCLICPageType(riscvP root, Uns32 offset) {

    Uns32        page = getCLICPage(offset);
    CLICPageType type = CPT_C;

    if(page) {

        // calculate page type from offset
        type = CPT_M + get4kIntPage(page)/getNumHarts(root);

        // sanity check result
        VMI_ASSERT((type>=CPT_M) && (type<=CPT_U), "illegal page type %u", type);
    }

    return type;
}

//
// Return the CLIC page mode being accessed at the given offset
//
static riscvMode getCLICPageMode(riscvP root, Uns32 offset) {

    CLICPageType type = getCLICPageType(root, offset);

    VMI_ASSERT(type!=CPT_C, "expected interrupt page");

    static const riscvMode map[] = {
        [CPT_M] = RISCV_MODE_MACHINE,
        [CPT_S] = RISCV_MODE_SUPERVISOR,
        [CPT_U] = RISCV_MODE_USER
    };

    return map[type];
}

//
// Return the CLIC hart index being accessed at the given offset
//
static Int32 getCLICHartIndex(riscvP root, Uns32 offset) {

    Uns32 page  = getCLICPage(offset);
    Int32 index = -1;

    if(page) {
        index = get4kIntPage(page)%getNumHarts(root);
    }

    return index;
}

//
// Return the hart being accessed at the given offset
//
static riscvP getCLICHart(riscvP root, Uns32 offset) {

    Int32 index = getCLICHartIndex(root, offset);

    VMI_ASSERT(index>=0, "illegal hart index");

    return root->clic.harts[index];
}

//
// Emit debug for CLIC region access
//
static void debugCLICAccess(
    riscvP      root,
    Uns32       raw,
    Uns32       offset,
    const char *access
) {
    CLICPageType type = getCLICPageType(root, offset);
    Int32        hart = getCLICHartIndex(root, offset);
    const char  *name = mapCLICPageTypeName(type);

    if(type==CPT_C) {

        // control page access
        vmiMessage("I", CPU_PREFIX"_CLIC",
            "%s offset=0x%x %s\n",
            access, raw, name
        );

    } else {

        // interrupt page access
        vmiMessage("I", CPU_PREFIX"_CLIC",
            "%s offset=0x%x %s (hart %d)\n",
            access, raw, name, hart
        );
    }
}

//
// Return the number of CLIC interrupts
//
inline static Uns32 getIntNum(riscvP hart) {
    return getCLICRoot(hart)->clic.clicinfo.fields.num_interrupt;
}

//
// Return mask of always-1 bits in clicintctl
//
static Uns32 getCLICIntCtl1Bits(riscvP hart) {

    riscvP root           = getCLICRoot(hart);
    Uns32  CLICINTCTLBITS = root->clic.clicinfo.fields.CLICINTCTLBITS;

    return ((1<<(8-CLICINTCTLBITS))-1);
}

//
// Return the composed value for the indexed interrupt
//
inline static Uns32 getCLICInterruptValue(riscvP hart, Uns32 index) {
    return hart->clic.intState[index].value32;
}

//
// Return the indicated field for the indexed interrupt
//
inline static Uns8 getCLICInterruptField(
    riscvP           hart,
    Uns32            intIndex,
    CLICIntFieldType type
) {
    return hart->clic.intState[intIndex].fields[type];
}

//
// Set the indicated field for the indexed interrupt
//
inline static void setCLICInterruptField(
    riscvP           hart,
    Uns32            intIndex,
    CLICIntFieldType type,
    Uns8             newValue
) {
    hart->clic.intState[intIndex].fields[type] = newValue;
}

//
// Update the indicated field for the indexed interrupt and refresh interrupt
// stte f it has changed
//
static void updateCLICInterruptField(
    riscvP           hart,
    Uns32            intIndex,
    CLICIntFieldType type,
    Uns8             newValue
) {
    if(getCLICInterruptField(hart, intIndex, type) != newValue) {
        setCLICInterruptField(hart, intIndex, type, newValue);
        riscvTestInterrupt(hart);
    }
}

//
// Return clicintattr for the indexed interrupt
//
static CLIC_REG_TYPE(clicintattr) getCLICInterruptAttr(riscvP hart, Uns32 intIndex) {

    CLIC_REG_DECL(clicintattr) = {
        bits:getCLICInterruptField(hart, intIndex, CIT_clicintattr)
    };

    return clicintattr;
}

//
// Is the indexed interrupt edge triggered?
//
inline static Bool isCLICInterruptEdge(riscvP hart, Uns32 intIndex) {

    CLIC_REG_DECL(clicintattr) = getCLICInterruptAttr(hart, intIndex);

    return clicintattr.fields.trig&1;
}

//
// Is the indexed interrupt active low?
//
inline static Bool isCLICInterruptActiveLow(riscvP hart, Uns32 intIndex) {

    CLIC_REG_DECL(clicintattr) = getCLICInterruptAttr(hart, intIndex);

    return clicintattr.fields.trig&2;
}

//
// Return pending for the indexed interrupt
//
static Bool getCLICInterruptPending(riscvP hart, Uns32 intIndex) {

    // get latched pending bit
    Bool IP = getCLICInterruptField(hart, intIndex, CIT_clicintip);

    // for level-triggered interrupts, include the unlatched external source
    if(!isCLICInterruptEdge(hart, intIndex)) {

        Uns32 wordIndex  = intIndex/64;
        Uns64 mask       = (1ULL<<(intIndex%64));
        Bool  externalIP = hart->ip[wordIndex] & mask;

        IP |= externalIP;
    }

    return IP;
}

//
// Set pending for the indexed interrupt
//
inline static void setCLICInterruptPending(
    riscvP hart,
    Uns32  intIndex,
    Bool   newValue,
    Bool   mayPendAny
) {
    // level-triggered pending values are not latched
    if(mayPendAny || isCLICInterruptEdge(hart, intIndex)) {
        setCLICInterruptField(hart, intIndex, CIT_clicintip, newValue);
    }
}

//
// Return enable for the indexed interrupt
//
inline static Bool getCLICInterruptEnable(riscvP hart, Uns32 intIndex) {
    return getCLICInterruptField(hart, intIndex, CIT_clicintie);
}

//
// Set enable for the indexed interrupt
//
inline static void setCLICInterruptEnable(
    riscvP hart,
    Uns32  intIndex,
    Bool   newValue
) {
    setCLICInterruptField(hart, intIndex, CIT_clicintie, newValue);
}

//
// Extrect double word index and mask for interrupt
//
#define INT_TO_INDEX_MASK(_INT, _WORD, _MASK) \
    Uns32 _WORD = (_INT)/64;            \
    Uns64 _MASK = (1ULL<<((_INT)%64))

//
// Return CLIC pending+enabled state for the given interrupt
//
static Bool getCLICPendingEnable(riscvP hart, Uns32 intIndex) {

    INT_TO_INDEX_MASK(intIndex, word, mask);

    return hart->clic.ipe[word] & mask;
}

//
// Update state when CLIC pending+enabled state changes for the given interrupt
//
static void updateCLICPendingEnable(riscvP hart, Uns32 intIndex, Bool newIPE) {

    INT_TO_INDEX_MASK(intIndex, word, mask);

    if(newIPE) {
        hart->clic.ipe[word] |= mask;
    } else {
        hart->clic.ipe[word] &= ~mask;
    }

    riscvTestInterrupt(hart);
}

//
// Write clicintip for the indexed interrupt
//
static void writeCLICInterruptPending(
    riscvP hart,
    Uns32  intIndex,
    Uns8   newValue,
    Bool   mayPendAny
) {
    Bool oldIE = getCLICInterruptEnable(hart, intIndex);
    Bool newIP = newValue&1;

    // update field, detecting change in pending+enabled
    Bool oldIPE = getCLICPendingEnable(hart, intIndex);
    setCLICInterruptPending(hart, intIndex, newIP, mayPendAny);
    Bool newIPE = oldIE && newIP;

    // update state if pending+enabled has changed
    if(oldIPE!=newIPE) {
        updateCLICPendingEnable(hart, intIndex, newIPE);
    }
}

//
// Write clicintie for the indexed interrupt
//
static void writeCLICInterruptEnable(
    riscvP hart,
    Uns32  intIndex,
    Uns8   newValue
) {
    Bool oldIP = getCLICInterruptPending(hart, intIndex);
    Bool newIE = newValue&1;

    // update field, detecting change in pending+enabled
    Bool oldIPE = getCLICPendingEnable(hart, intIndex);
    setCLICInterruptEnable(hart, intIndex, newIE);
    Bool newIPE = oldIP && newIE;

    // update state if pending+enabled has changed
    if(oldIPE!=newIPE) {
        updateCLICPendingEnable(hart, intIndex, newIPE);
    }
}

//
// Write clicintattr for the indexed interrupt
//
static void writeCLICInterruptAttr(
    riscvP    hart,
    Uns32     intIndex,
    Uns8      newValue,
    riscvMode pageMode
) {
    CLIC_REG_DECL(clicintattr) = {bits:newValue};
    riscvP    root             = getCLICRoot(hart);
    Uns32     CLICCFGMBITS     = root->configInfo.CLICCFGMBITS;
    riscvMode intMode          = clicintattr.fields.mode;

    // clear WPRI field
    clicintattr.fields._u1 = 0;

    // preserve current value of trig field if required
    INT_TO_INDEX_MASK(intIndex, word, mask);
    if(hart->clic.trigFixed[word] & mask) {
        clicintattr.fields.trig = getCLICInterruptAttr(hart, intIndex).fields.trig;
    }

    // clear shv field if Selective Hardware Vectoring is not implemented
    if(!root->clic.cliccfg.fields.nvbits) {
        clicintattr.fields.shv = 0;
    }

    // clamp mode to legal values
    if(
        // do not allow mode to be greater than page mode
        (intMode>pageMode) ||
        // if CLICCFGMBITS is zero do not allow mode change from Machine
        (CLICCFGMBITS==0) ||
        // do not allow mode change to illegal H mode
        (intMode==RISCV_MODE_HYPERVISOR) ||
        // do not allow mode change to S mode if only M and U supported
        ((CLICCFGMBITS<2) && (intMode==RISCV_MODE_SUPERVISOR)) ||
        // do not allow mode change to U mode if N extension is absent
        ((intMode==RISCV_MODE_USER) && !(hart->configInfo.arch&ISA_N))
    ) {
        intMode = pageMode;
    }

    // set mode field
    clicintattr.fields.mode = intMode;

    // update field with corrected attributes
    updateCLICInterruptField(hart, intIndex, CIT_clicintattr, clicintattr.bits);
}

//
// Write clicintctl for the indexed interrupt
//
static void writeCLICInterruptCtl(
    riscvP hart,
    Uns32  intIndex,
    Uns8   newValue
) {
    newValue |= getCLICIntCtl1Bits(hart);

    // update field with corrected value
    updateCLICInterruptField(hart, intIndex, CIT_clicintctl, newValue);
}

//
// Return the privilege mode for the interrupt with the given index
//
static riscvMode getCLICInterruptMode(riscvP hart, Uns32 intIndex) {

    CLIC_REG_DECL(clicintattr) = getCLICInterruptAttr(hart, intIndex);
    riscvP    root             = getCLICRoot(hart);
    Uns8      attr_mode        = clicintattr.fields.mode;
    Uns32     nmbits           = root->clic.cliccfg.fields.nmbits;
    riscvMode intMode          = RISCV_MODE_MACHINE;

    if(nmbits == 0) {

        // priv-modes nmbits clicintattr[i].mode  Interpretation
        //      ---      0       xx               M-mode interrupt

    } else if(root->configInfo.CLICCFGMBITS == 1) {

        // priv-modes nmbits clicintattr[i].mode  Interpretation
        //      M/U      1       0x               U-mode interrupt
        //      M/U      1       1x               M-mode interrupt
        intMode = (attr_mode&2) ? RISCV_MODE_MACHINE : RISCV_MODE_USER;

    } else {

        // priv-modes nmbits clicintattr[i].mode  Interpretation
        //    M/S/U      1       0x               S-mode interrupt
        //    M/S/U      1       1x               M-mode interrupt
        //    M/S/U      2       00               U-mode interrupt
        //    M/S/U      2       01               S-mode interrupt
        //    M/S/U      2       10               Reserved (or extended S-mode)
        //    M/S/U      2       11               M-mode interrupt
        intMode = attr_mode | (nmbits==1);
    }

    return intMode;
}

//
// Is the interrupt accessed at the given offset visible?
//
static Bool accessCLICInterrupt(riscvP root, Uns32 offset) {

    riscvP         hart     = getCLICHart(root, offset);
    Uns32          intIndex = getCLICIntIndex(offset);
    riscvException intCode  = intToException(intIndex);
    Bool           ok       = False;

    if((intIndex<riscv_E_Local) && !riscvHasStandardException(hart, intCode)) {

        // absent standard interrupt

    } else if(intIndex<getIntNum(hart)) {

        riscvMode pageMode = getCLICPageMode(root, offset);
        riscvMode intMode  = getCLICInterruptMode(hart, intIndex);

        ok = (intMode<=pageMode);
    }

    return ok;
}

//
// Return the visible state of an interrupt when accessed using the given
// offset
//
static Uns32 readCLICInterrupt(riscvP root, Uns32 offset) {

    Uns32 result = 0;

    if(accessCLICInterrupt(root, offset)) {

        riscvP hart     = getCLICHart(root, offset);
        Uns32  intIndex = getCLICIntIndex(offset);

        switch(getCLICIntFieldType(offset)) {

            case CIT_clicintip:
                result = getCLICInterruptPending(hart, intIndex);
                break;

            default:
                result = getCLICInterruptValue(hart, intIndex);
                break;
        }
    }

    return result;
}

//
// Update the visible state of an interrupt when accessed using the given
// offset
//
static void writeCLICInterrupt(riscvP root, Uns32 offset, Uns8 newValue) {

    if(accessCLICInterrupt(root, offset)) {

        riscvP hart     = getCLICHart(root, offset);
        Uns32  intIndex = getCLICIntIndex(offset);

        switch(getCLICIntFieldType(offset)) {

            case CIT_clicintip: {
                Bool mayPendAny = mayPendLevel(hart);
                writeCLICInterruptPending(hart, intIndex, newValue, mayPendAny);
                break;
            }

            case CIT_clicintie:
                writeCLICInterruptEnable(hart, intIndex, newValue);
                break;

            case CIT_clicintattr: {
                riscvMode pageMode = getCLICPageMode(root, offset);
                writeCLICInterruptAttr(hart, intIndex, newValue, pageMode);
                break;
            }

            case CIT_clicintctl:
                writeCLICInterruptCtl(hart, intIndex, newValue);
                break;

            default:
                VMI_ABORT("unimplemented case"); // LCOV_EXCL_LINE
                break;
        }
    }
}

//
// Refresh state when CLIC is internally implemented
//
void riscvRefreshPendingAndEnabledInternalCLIC(riscvP hart) {

    riscvP root    = getCLICRoot(hart);
    Uns32  maxRank = 0;
    Int32  id      = RV_NO_INT;
    Uns32  wordIndex;

    // reset presented interrupt details
    hart->clic.sel.priv  = 0;
    hart->clic.sel.id    = id;
    hart->clic.sel.level = 0;
    hart->clic.sel.shv   = False;

    // scan for pending+enabled interrupts
    for(wordIndex=0; wordIndex<hart->ipDWords; wordIndex++) {

        Uns64 pendingEnabled = hart->clic.ipe[wordIndex];

        // select highest-priority pending-and-enabled interrupt
        if(pendingEnabled) {

            Uns32 i = 0;

            do {

                if(pendingEnabled&1) {

                    Uns32 intIndex = wordIndex*64+i;

                    // get control fields for the indexed interrupt
                    Uns8 clicintctl = getCLICInterruptField(
                        hart, intIndex, CIT_clicintctl
                    );

                    // get target mode for the indexed interrupt
                    riscvMode mode = getCLICInterruptMode(hart, intIndex);

                    // construct rank (where target mode is most-significant
                    // part)
                    Uns32 rank = (mode<<8) | clicintctl;

                    // select highest-priority interrupt (highest-numbered
                    // interrupt wins in a tie)
                    if(maxRank<=rank) {
                        maxRank = rank;
                        id      = intIndex;
                    }
                }

                // step to next potential pending-and-enabled interrupt
                pendingEnabled >>= 1;
                i++;

            } while(pendingEnabled);
        }
    }

    // update selected CLIC interrupt state
    if(id != RV_NO_INT) {

        // get control fields for highest-priority pending interrupt
        CLIC_REG_DECL(clicintattr) = getCLICInterruptAttr(hart, id);
        Uns8 clicintctl = getCLICInterruptField(hart, id, CIT_clicintctl);

        // get mask of bits in clicintctl representing level
        Uns32 nlbits     = root->clic.cliccfg.fields.nlbits;
        Uns8  nlbitsMask = ~((1<<(8-nlbits)) - 1);

        // get interrupt target mode
        riscvMode priv = getCLICInterruptMode(hart, id);

        // get interrupt level with least-significant bits set to 1
        Uns8 level = (clicintctl & nlbitsMask) | ~nlbitsMask;

        // update presented interrupt
        hart->clic.sel.priv  = priv;
        hart->clic.sel.id    = id;
        hart->clic.sel.level = level;
        hart->clic.sel.shv   = clicintattr.fields.shv;
    }
}

//
// Refresh CLIC pending+enable mask (after restore)
//
static void refreshCLICIPE(riscvP hart) {

    Uns32 intNum = getIntNum(hart);
    Uns32 i;

    // clear current pending+enabled state
    for(i=0; i<hart->ipDWords; i++) {
        hart->clic.ipe[i] = 0;
    }

    // reinstate pending+enabled state from interrupt state
    for(i=0; i<intNum; i++) {

        if(
            getCLICInterruptPending(hart, i) &&
            getCLICInterruptEnable(hart, i)
        ) {
            INT_TO_INDEX_MASK(i, word, mask);
            hart->clic.ipe[word] |= mask;
        }
    }
}

//
// Acknowledge CLIC-sourced interrupt
//
void riscvAcknowledgeCLICInt(riscvP hart, Uns32 intIndex) {

    // deassert interrupt if edge triggered, or refresh pending state if not
    if(CLICInternal(hart) && isCLICInterruptEdge(hart, intIndex)) {
        writeCLICInterruptPending(hart, intIndex, 0, False);
    } else {
        riscvRefreshPendingAndEnabled(hart);
    }
}

//
// Update CLIC state on input signal change
//
void riscvUpdateCLICInput(riscvP hart, Uns32 intIndex, Bool newValue) {

    // determine interrupt configuration
    Bool isEdge    = isCLICInterruptEdge(hart, intIndex);
    Bool activeLow = isCLICInterruptActiveLow(hart, intIndex);

    // handle active low inputs
    newValue ^= activeLow;

    // apply new value if either level triggered or edge triggered and asserted
    if(!isEdge || newValue) {
        writeCLICInterruptPending(hart, intIndex, newValue, False);
    }
}

//
// Update CLIC pending interrupt state for a leaf processor
//
static VMI_SMP_ITER_FN(refreshCCLICInterruptAllCB) {
    if(vmirtGetSMPCpuType(processor)==SMP_TYPE_LEAF) {
        riscvTestInterrupt((riscvP)processor);
    }
}

//
// Refresh CLIC pending interrupt state for all processors
//
static void refreshCCLICInterruptAll(riscvP riscv) {
    vmirtIterAllProcessors(
        (vmiProcessorP)getCLICRoot(riscv),
        refreshCCLICInterruptAllCB,
        0
    );
}

//
// Update the value of cliccfg
//
static void cliccfgW(riscvP root, Uns8 newValue) {

    CLIC_REG_DECL(cliccfg) = {bits:newValue};

    // clear WPRI bits in the new value
    cliccfg.fields._u1 = 0;

    // clamp nmbits in the new value to legal maximum
    if(cliccfg.fields.nmbits>root->configInfo.CLICCFGMBITS) {
        cliccfg.fields.nmbits = root->configInfo.CLICCFGMBITS;
    }

    // clamp nlbits in the new value to legal maximum
    if(cliccfg.fields.nlbits>8) {
        cliccfg.fields.nlbits = 8;
    }

    // preserve read-only nvbits field
    cliccfg.fields.nvbits = root->configInfo.CLICSELHVEC;

    // update register and refresh interrupt state if changed
    if(root->clic.cliccfg.bits!=cliccfg.bits) {
        root->clic.cliccfg.bits = cliccfg.bits;
        refreshCCLICInterruptAll(root);
    }
}

//
// Read one byte from the CLIC
//
static Uns8 readCLICInt(riscvP root, Uns32 raw, Uns32 offset) {

    Uns32 result = 0;
    Uns32 word   = getCLICPageWord(offset);
    Uns32 byte   = getCLICWordByte(offset);

    // debug access if required
    if(RISCV_DEBUG_EXCEPT(root)) {
        debugCLICAccess(root, raw, offset, "READ");
    }

    // direct access either to interrupt or control page
    if(getCLICPage(offset)) {
        result = readCLICInterrupt(root, offset);
    } else if(word==0) {
        result = root->clic.cliccfg.bits;
    } else if(word==1) {
        result = root->clic.clicinfo.bits;
    }

    // extract byte from result
    return result >> (byte*8);
}

//
// Write one byte to the CLIC
//
static void writeCLICInt(riscvP root, Uns32 raw, Uns32 offset, Uns8 newValue) {

    // debug access if required
    if(RISCV_DEBUG_EXCEPT(root)) {
        debugCLICAccess(root, raw, offset, "WRITE");
    }

    // direct access either to interrupt or control page
    if(getCLICPage(offset)) {
        writeCLICInterrupt(root, offset, newValue);
    } else if(offset==0) {
        cliccfgW(root, newValue);
    }
}


////////////////////////////////////////////////////////////////////////////////
// MEMORY-MAPPED CALLBACKS, CLIC LEGACY VERSION BEFORE 0.9
////////////////////////////////////////////////////////////////////////////////

#define CLIC_OLD_SIZE       0x800000
#define CLIC_OLD_MODE_MASK  0x1fffff
#define CLIC_OLD_AP_SIZE    0x001000
#define CLIC_OLD_INDEX_MASK 0x0003ff

//
// Return offset of CLIC access within memory-mapped block
//
inline static Uns32 getCLICOldOffset(riscvP root, Uns64 addr) {
    return addr-getCLICLow(root);
}

//
// Return hart index implied by memory-mapped CLIC access
//
inline static Uns32 getCLICOldHart(Uns32 offset) {
    return (offset & CLIC_OLD_MODE_MASK) / CLIC_OLD_AP_SIZE;
}

//
// Return interrupt index implied by memory-mapped CLIC access
//
inline static Uns32 getCLICOldIntId(Uns32 offset) {
    return offset & CLIC_OLD_INDEX_MASK;
}

//
// Map from address of CLIC access to the presumed aperture mode
//
static riscvMode getCLICOldMode(Uns32 offset) {

   switch(offset/(CLIC_OLD_SIZE/4)) {
       case 0:
           return RISCV_MODE_M;
       case 1:
           return RISCV_MODE_S;
       case 2:
           return RISCV_MODE_S;
       default:
           return RISCV_MODE_U;
   }
}

//
// Map from address of CLIC access to the operation type
//
static CLICIntFieldType getCLICOldType(Uns32 offset) {

    switch((offset & (CLIC_OLD_AP_SIZE-1))/(CLIC_OLD_AP_SIZE/4)) {
        case 0:
            return CIT_clicintip;
        case 1:
            return CIT_clicintie;
        case 2:
            return CIT_clicintctl;
        default:
            return CIT_clicintattr;
    }
}

//
// Given an old CLIC address, return the equivalent byte address using 0.9
// mappings.
//
static Uns32 mapCLICOldOffset(riscvP root, Uns32 offset) {

    Uns32            numHarts = getNumHarts(root);
    Uns32            hartId   = getCLICOldHart(offset);
    riscvMode        mode     = getCLICOldMode(offset);
    CLICIntFieldType type     = getCLICOldType(offset);
    Uns32            id       = getCLICOldIntId(offset);
    Uns32            newIndex = -1;

    if(type==CIT_clicintattr) {

        if(mode!=RISCV_MODE_M) {
            // only M-mode can access cliccfg region
        } else if(id) {
            // only cliccfg is present
        } else {
            newIndex = 0;
        }

    } else {

        // get number of 4k pages for M/S/U blocks (4x4k pages per hart)
        Uns32 msuPages = numHarts*4;

        // get hart offset within M/S/U block (4x4k pages per hart, skip initial
        // 4k configuration page)
        Uns32 pageOffset = (hartId*4) + 1;

        // add page offset of correct M/S/U block
        if(mode==RISCV_MODE_S) {
            pageOffset += msuPages;
        } else if(mode==RISCV_MODE_U) {
            pageOffset += msuPages*2;
        }

        // get offset to indexed interrupt
        newIndex = (pageOffset*4096) + (id*4);

        // include clicintip/clicintie/clicintctl offset
        newIndex += type;
    }

    return newIndex;
}

//
// Mask clicintctl by region type
//
static Uns8 maskCLICOldIntCfg(riscvP root, Uns32 offset, Uns8 clicintctl) {

    riscvMode mode = getCLICOldMode(offset);

    if(mode!=RISCV_MODE_M) {

        Uns32  hartId = getCLICOldHart(offset);
        riscvP riscv  = root->clic.harts[hartId];

        if((mode==RISCV_MODE_S) || !supervisorPresent(riscv)) {
            clicintctl &= 0x7f;
        } else {
            clicintctl &= 0x3f;
        }
    }

    return clicintctl;
}

//
// Write inferred value of clicintattr when clicintctl is written
//
static void writeCLICOldIntAttr(
    riscvP root,
    Uns32  offsetOld,
    Uns32  offsetNew,
    Uns8   clicintctl
) {
    Uns32 CLICINTCTLBITS = root->clic.clicinfo.fields.CLICINTCTLBITS;

    CLIC_REG_DECL(clicintattr) = {0};

    // shv is the least-significant writable bit of clicintctl
    clicintattr.fields.shv = (clicintctl & (1<<(8-CLICINTCTLBITS))) && True;

    // mode is the most-significant two bits of clicintctl
    clicintattr.fields.mode = clicintctl>>6;

    // update implied clicintattr
    writeCLICInt(root, offsetOld, offsetNew-1, clicintattr.bits);
}

//
// Read CLIC register (pre-0.9)
//
static VMI_MEM_READ_FN(readCLICOld) {

    riscvP root     = userData;
    Uns32  numHarts = getNumHarts(root);
    Uns8  *value8   = value;
    Uns32  i;

    for(i=0; i<bytes; i++) {

        Uns32 offsetOld = getCLICOldOffset(root, address+i);

        if(getCLICOldHart(offsetOld)<numHarts) {

            Uns32 offsetNew = mapCLICOldOffset(root, offsetOld);

            if(offsetNew != -1) {
                value8[i] = readCLICInt(root, offsetOld, offsetNew);
            } else {
                value8[i] = 0;
            }
        }
    }
}

//
// Write CLIC register (pre-0.9)
//
static VMI_MEM_WRITE_FN(writeCLICOld) {

    riscvP      root     = userData;
    Uns32       numHarts = getNumHarts(root);
    const Uns8 *value8   = value;
    Uns32       i;

    for(i=0; i<bytes; i++) {

        Uns32 offsetOld = getCLICOldOffset(root, address+i);

        if(getCLICOldHart(offsetOld)<numHarts) {

            Uns32 offsetNew = mapCLICOldOffset(root, offsetOld);

            if(offsetNew != -1) {

                Uns8 value = value8[i];

                if(getCLICOldType(offsetOld)==CIT_clicintctl) {

                    // pre-0.9 clicintctl is masked by region type
                    value = maskCLICOldIntCfg(root, offsetOld, value);

                    // pre-0.9 clicintattr must be inferred from clicintctl
                    writeCLICOldIntAttr(root, offsetOld, offsetNew, value);
                }

                writeCLICInt(root, offsetOld, offsetNew, value);
            }
        }
    }
}

//
// Create CLIC memory-mapped block and data structures (pre-0.9)
//
static void mapCLICDomainOld(riscvP root, memDomainP CLICDomain) {

    Uns64 lowAddr  = getCLICLow(root);
    Uns64 highAddr = lowAddr+CLIC_OLD_SIZE-1;

    // install callbacks to implement the CLIC
    vmirtMapCallbacks(
        CLICDomain, lowAddr, highAddr, readCLICOld, writeCLICOld, root
    );

    // force aligned access
    vmirtProtectMemory(
        CLICDomain, lowAddr, highAddr, MEM_PRIV_ALIGN, MEM_PRIV_ADD
    );
}


////////////////////////////////////////////////////////////////////////////////
// MEMORY-MAPPED CALLBACKS, CLIC VERSION 0.9 OR LATER
////////////////////////////////////////////////////////////////////////////////

//
// Read CLIC register (version 0.9 or later)
//
static VMI_MEM_READ_FN(readCLIC_0_9) {

    riscvP root    = userData;
    Uns8  *value8  = value;
    Uns64  lowAddr = getCLICLow(root);
    Uns32  i;

    for(i=0; i<bytes; i++) {
        Uns32 offset = address+i-lowAddr;
        value8[i] = readCLICInt(root, offset, offset);
    }
}

//
// Write CLIC register (version 0.9 or later)
//
static VMI_MEM_WRITE_FN(writeCLIC_0_9) {

    riscvP      root    = userData;
    const Uns8 *value8  = value;
    Uns64       lowAddr = getCLICLow(root);
    Uns32       i;

    for(i=0; i<bytes; i++) {
        Uns32 offset = address+i-lowAddr;
        writeCLICInt(root, offset, offset, value8[i]);
    }
}

//
// Create CLIC memory-mapped block and data structures (version 0.9 or later)
//
static void mapCLICDomain_0_9(riscvP root, memDomainP CLICDomain) {

    Uns32 numHarts = getNumHarts(root);
    Uns32 numPages = 1 + (numHarts*3)*4;
    Uns32 numBytes = numPages*4096;
    Uns64 lowAddr  = getCLICLow(root);
    Uns64 highAddr = lowAddr+numBytes-1;

    // install callbacks to implement the CLIC
    vmirtMapCallbacks(
        CLICDomain, lowAddr, highAddr, readCLIC_0_9, writeCLIC_0_9, root
    );

    // force aligned access
    vmirtProtectMemory(
        CLICDomain, lowAddr, highAddr, MEM_PRIV_ALIGN, MEM_PRIV_ADD
    );
}


////////////////////////////////////////////////////////////////////////////////
// PUBLIC FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Create CLIC memory-mapped block and data structures
//
void riscvMapCLICDomain(riscvP riscv, memDomainP CLICDomain) {

    riscvP root = getCLICRoot(riscv);

    if(riscv->configInfo.CLIC_version>=RVCLC_0_9_20191208) {
        mapCLICDomain_0_9(root, CLICDomain);
    } else {
        mapCLICDomainOld(root, CLICDomain);
    }
}

//
// Copy CLIC configuration setting
//
#define COPY_CLIC_CFG(_DST, _SRC, _NAME) \
    (_DST)->configInfo._NAME = (_SRC)->configInfo._NAME

//
// Allocate CLIC data structures if implemented internally
//
void riscvNewCLIC(riscvP root) {

    // if this is an AMP cluster, copy CLIC configuration from the first child
    if(riscvIsCluster(root)) {

        riscvP child = (riscvP)vmirtGetSMPChild((vmiProcessorP)root);

        COPY_CLIC_CFG(root, child, CLIC_version);
        COPY_CLIC_CFG(root, child, posedge_0_63);
        COPY_CLIC_CFG(root, child, poslevel_0_63);
        COPY_CLIC_CFG(root, child, CLICLEVELS);
        COPY_CLIC_CFG(root, child, externalCLIC);
        COPY_CLIC_CFG(root, child, CLICANDBASIC);
        COPY_CLIC_CFG(root, child, CLICVERSION);
        COPY_CLIC_CFG(root, child, CLICINTCTLBITS);
        COPY_CLIC_CFG(root, child, CLICCFGMBITS);
        COPY_CLIC_CFG(root, child, CLICCFGLBITS);
        COPY_CLIC_CFG(root, child, CLICSELHVEC);
        COPY_CLIC_CFG(root, child, CLICXNXTI);
        COPY_CLIC_CFG(root, child, CLICXCSW);
        COPY_CLIC_CFG(root, child, tvt_undefined);
        COPY_CLIC_CFG(root, child, intthresh_undefined);
        COPY_CLIC_CFG(root, child, mclicbase_undefined);
        COPY_CLIC_CFG(root, child, posedge_other);
        COPY_CLIC_CFG(root, child, poslevel_other);
        COPY_CLIC_CFG(root, child, local_int_num);
    }

    // allocate CLIC data structures if required
    if(CLICInternal(root)) {

        Uns32 numHarts = getNumHarts(root);
        Uns32 intNum   = riscvGetIntNum(root);

        // initialise read-only fields in cliccfg using configuration options
        root->clic.cliccfg.fields.nvbits = root->configInfo.CLICSELHVEC;

        // initialise read-only fields in clicinfo using configuration options
        root->clic.clicinfo.fields.num_interrupt  = intNum;
        root->clic.clicinfo.fields.version        = root->configInfo.CLICVERSION;
        root->clic.clicinfo.fields.CLICINTCTLBITS = root->configInfo.CLICINTCTLBITS;

        // allocate hart table
        root->clic.harts = STYPE_CALLOC_N(riscvP, numHarts);
    }
}

//
// Fill CLIC entry if required
//
void riscvFillCLIC(riscvP riscv) {

    riscvP  root  = getCLICRoot(riscv);
    riscvPP table = root->clic.harts;
    
    if(table) {

        Uns32 numHarts = getNumHarts(root);
        Uns32 intNum   = riscvGetIntNum(root);
        Uns32 index    = riscv->hartNum;
        Uns32 i;

        // sanity check hart index and table
        VMI_ASSERT(
            index<numHarts,
            "illegal hart index %u (maximum %u)",
            index, numHarts
        );
        VMI_ASSERT(
            !table[index],
            "table entry %u already filled",
            index
        );

        // insert this hart in the lookup table
        table[index] = riscv;

        // indicate internal CLIC is always enabled
        riscv->netValue.enableCLIC = True;

        // allocate control state for interrupts
        riscv->clic.intState  = STYPE_CALLOC_N(riscvCLICIntState, intNum);
        riscv->clic.ipe       = STYPE_CALLOC_N(Uns64, riscv->ipDWords);
        riscv->clic.trigFixed = STYPE_CALLOC_N(Uns64, riscv->ipDWords);

        // define default value for interrupt control state
        Uns32 clicintctl = getCLICIntCtl1Bits(riscv);

        // get definitions of fixed trigger CLIC interrupts
        Uns64 posedge_0_63   = riscv->configInfo.posedge_0_63;
        Uns64 poslevel_0_63  = riscv->configInfo.poslevel_0_63;
        Bool  posedge_other  = riscv->configInfo.posedge_other;
        Bool  poslevel_other = riscv->configInfo.poslevel_other;

        // initialise control state for interrupts
        for(i=0; i<intNum; i++) {

            INT_TO_INDEX_MASK(i, word, mask);

            // get default value for clicintattr
            CLIC_REG_DECL(clicintattr) = {fields:{mode:RISCV_MODE_MACHINE}};

            // handle fixed positive edge/level triggered interrupts
            if(word ? posedge_other : (mask&posedge_0_63)) {
                riscv->clic.trigFixed[word] |= mask;
                clicintattr.fields.trig = 1;
            } else if(word ? poslevel_other : (mask&poslevel_0_63)) {
                riscv->clic.trigFixed[word] |= mask;
            }

            // set initial clicintattr and clicintctl for this interruipt
            setCLICInterruptField(riscv, i, CIT_clicintattr, clicintattr.bits);
            setCLICInterruptField(riscv, i, CIT_clicintctl, clicintctl);
        }
    }
}

//
// Free field in CLIC structure if required
//
#define CLIC_FREE(_P, _F) if(_P->clic._F) { \
    STYPE_FREE(_P->clic._F);    \
    _P->clic._F = 0;            \
}

//
// Free CLIC data structures
//
void riscvFreeCLIC(riscvP riscv) {
    CLIC_FREE(riscv, harts);
    CLIC_FREE(riscv, intState);
    CLIC_FREE(riscv, ipe);
    CLIC_FREE(riscv, trigFixed);
}

//
// Reset CLIC
//
void riscvResetCLIC(riscvP riscv) {

    if(riscv->clic.intState) {

        // force all interrupts to M-mode at level 255
        cliccfgW(riscv, 0);

        // indicate exception handler is inactive
        WR_CSRC(riscv, mintstatus, 0);
    }
}


////////////////////////////////////////////////////////////////////////////////
// SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Save/restore field keys
//
#define RV_CLIC_INTSTATE    "clic.intState"

//
// Save CLIC state not covered by register read/write API
//
void riscvSaveCLIC(riscvP riscv, vmiSaveContextP cxt) {

    // save CLIC configuration (root level)
    VMIRT_SAVE_FIELD(cxt, getCLICRoot(riscv), clic.cliccfg);

    // save CLIC interrupt state
    vmirtSave(
        cxt,
        RV_CLIC_INTSTATE,
        riscv->clic.intState,
        sizeof(*riscv->clic.intState)*getIntNum(riscv)
    );
}

//
// Restore net state not covered by register read/write API
//
void riscvRestoreCLIC(riscvP riscv, vmiRestoreContextP cxt) {

    // restore CLIC configuration (root level)
    VMIRT_RESTORE_FIELD(cxt, getCLICRoot(riscv), clic.cliccfg);

    // restore CLIC interrupt state
    vmirtRestore(
        cxt,
        RV_CLIC_INTSTATE,
        riscv->clic.intState,
        sizeof(*riscv->clic.intState)*getIntNum(riscv)
    );

    // refresh CLIC pending+enable mask
    refreshCLICIPE(riscv);
}

