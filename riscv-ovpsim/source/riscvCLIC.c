/*
 * Copyright (c) 2005-2023 Imperas Software Ltd., www.imperas.com
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
#include "riscvMode.h"
#include "riscvStructure.h"
#include "riscvTypeRefs.h"
#include "riscvUtils.h"


//
// This enumerates byte-sized CLIC interrupt control fields
//
typedef enum CLICIntFieldTypeE {
    CIT_clicintip   = 0,
    CIT_clicintie   = 1,
    CIT_clicintattr = 2,
    CIT_clicintctl  = 3,
    CIT_clicconfig  = 4,    // configuration page access
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
// This describes access to a CLIC field in an abstract form
//
typedef struct CLICIntDescS {
    Int32            hartIndex;     // selected hart
    Uns32            rawIndex;      // raw field index (for debug)
    Uns32            intIndex : 16; // interrupt index
    riscvMode        mode     :  8; // page mode
    CLICIntFieldType fType    :  8; // interrupt control field type
} CLICIntDesc, *CLICIntDescP;

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
// Indicate whether software may set a level-sensitive interrupt pending
//
inline static Bool mayPendLevel(riscvP hart) {
    return hart->configInfo.CLIC_version==RVCLC_0_9_20191208;
}

//
// Return nmbits
//
inline static Uns8 nmbitsR(riscvP root) {
    return root->clic.cliccfg.nmbits;
}

//
// Return nlbits for the given mode
//
inline static Uns8 nlbitsR(riscvP root, riscvMode mode) {
    return root->clic.cliccfg.nlbits[mode];
}

//
// Return the hart being accessed at the given offset
//
static riscvP getCLICHart(riscvP root, Uns32 index) {

    VMI_ASSERT(index>=0, "illegal hart index");

    return root->clic.harts[index];
}

//
// Emit debug for CLIC region access
//
static void debugCLICAccess(
    riscvP       root,
    CLICIntDescP desc,
    const char  *access
) {
    const char *modeText = riscvGetModeName(desc->mode);

    if(desc->fType==CIT_clicconfig) {

        // configuration page access
        vmiMessage("I", CPU_PREFIX"_CLIC",
            "%s offset=0x%x %s Control\n",
            access, desc->rawIndex, modeText
        );

    } else {

        // interrupt page access
        vmiMessage("I", CPU_PREFIX"_CLIC",
            "%s offset=0x%x %s (hart %d)\n",
            access, desc->rawIndex, modeText, desc->hartIndex
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
    if(!root->configInfo.CLICSELHVEC) {
        clicintattr.fields.shv = 0;
    }

    // clamp mode to legal values
    if(
        // do not allow mode to be greater than page mode
        (intMode>pageMode) ||
        // if CLICCFGMBITS is zero do not allow mode change from Machine
        (CLICCFGMBITS==0) ||
        // do not allow mode change to illegal H mode
        (intMode==RISCV_MODE_H) ||
        // do not allow mode change to S mode if only M and U supported
        ((CLICCFGMBITS<2) && (intMode==RISCV_MODE_S)) ||
        // do not allow mode change to U mode if N extension is absent
        ((intMode==RISCV_MODE_U) && !userIntPresent(hart))
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
    Uns32     nmbits           = nmbitsR(root);
    riscvMode intMode          = RISCV_MODE_M;

    if(nmbits == 0) {

        // priv-modes nmbits clicintattr[i].mode  Interpretation
        //      ---      0       xx               M-mode interrupt

    } else if(root->configInfo.CLICCFGMBITS == 1) {

        // priv-modes nmbits clicintattr[i].mode  Interpretation
        //      M/U      1       0x               U-mode interrupt
        //      M/U      1       1x               M-mode interrupt
        intMode = (attr_mode&2) ? RISCV_MODE_M : RISCV_MODE_U;

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
static Bool accessCLICInterrupt(riscvP root, CLICIntDescP desc) {

    riscvP         hart     = getCLICHart(root, desc->hartIndex);
    Uns32          intIndex = desc->intIndex;
    riscvException intCode  = intToException(intIndex);
    Bool           ok       = False;

    if((intIndex<riscv_E_Local) && !riscvHasStandardException(hart, intCode)) {

        // absent standard interrupt

    } else if(intIndex<getIntNum(hart)) {

        riscvMode pageMode = desc->mode;
        riscvMode intMode  = getCLICInterruptMode(hart, intIndex);

        ok = (intMode<=pageMode);
    }

    return ok;
}

//
// Return the visible state of an interrupt when accessed using the given
// offset
//
static Uns32 readCLICInterrupt(riscvP root, CLICIntDescP desc) {

    Uns32 result = 0;

    if(accessCLICInterrupt(root, desc)) {

        riscvP hart     = getCLICHart(root, desc->hartIndex);
        Uns32  intIndex = desc->intIndex;

        switch(desc->fType) {

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
static void writeCLICInterrupt(riscvP root, CLICIntDescP desc, Uns8 newValue) {

    if(accessCLICInterrupt(root, desc)) {

        riscvP hart     = getCLICHart(root, desc->hartIndex);
        Uns32  intIndex = desc->intIndex;

        switch(desc->fType) {

            case CIT_clicintip: {
                Bool mayPendAny = mayPendLevel(hart);
                writeCLICInterruptPending(hart, intIndex, newValue, mayPendAny);
                break;
            }

            case CIT_clicintie:
                writeCLICInterruptEnable(hart, intIndex, newValue);
                break;

            case CIT_clicintattr: {
                writeCLICInterruptAttr(hart, intIndex, newValue, desc->mode);
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

    riscvP    root    = getCLICRoot(hart);
    Uns32     maxRank = 0;
    Int32     id      = RV_NO_INT;
    riscvMode priv    = 0;
    Uns32     wordIndex;

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
                        priv    = mode;
                    }
                }

                // step to next potential pending-and-enabled interrupt
                pendingEnabled >>= 1;
                i++;

            } while(pendingEnabled);
        }
    }

    // update selected CLIC interrupt state
    if(id == RV_NO_INT) {

        // reset presented interrupt details
        hart->clic.sel.priv  = 0;
        hart->clic.sel.id    = id;
        hart->clic.sel.level = 0;
        hart->clic.sel.shv   = False;

    } else {

        // get control fields for highest-priority pending interrupt
        CLIC_REG_DECL(clicintattr) = getCLICInterruptAttr(hart, id);
        Uns8 clicintctl = getCLICInterruptField(hart, id, CIT_clicintctl);

        // get mask of bits in clicintctl representing level
        Uns32 nlbits     = root->clic.cliccfg.nlbits[priv];
        Uns8  nlbitsMask = ~((1<<(8-nlbits)) - 1);

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
// Is the given cliccfg.nlbits value valid?
//
inline static Bool nlbitsValid(riscvP root, Uns32 nlbits) {
    return root->configInfo.nlbits_valid & (1<<nlbits);
}

//
// Update nlbits for the given mode
//
static Bool nlbitsW(riscvP root, riscvMode mode, Uns32 nlbits) {

    Bool refresh = False;

    // clamp nlbits in the new value to legal maximum, or retain old value if
    // new value is not in nlbits_valid mask
    if(nlbits>root->configInfo.CLICCFGLBITS) {
        nlbits = root->configInfo.CLICCFGLBITS;
    } else if(!nlbitsValid(root, nlbits)) {
        nlbits = nlbitsR(root, mode);
    }

    // update nlbits if required
    if(nlbitsR(root, mode) != nlbits) {
        root->clic.cliccfg.nlbits[mode] = nlbits;
        refresh = True;
    }

    return refresh;
}

//
// Update nmbits
//
static Bool nmbitsW(riscvP root, Uns32 nmbits) {

    Bool refresh = False;

    // clamp nmbits in the new value to legal maximum
    if(nmbits>root->configInfo.CLICCFGMBITS) {
        nmbits = root->configInfo.CLICCFGMBITS;
    }

    // update nmbits if required
    if(nmbitsR(root) != nmbits) {
        root->clic.cliccfg.nmbits = nmbits;
        refresh = True;
    }

    return refresh;
}

//
// Read cliccfg
//
static Uns8 cliccfgR(riscvP root, riscvMode mode) {

    CLIC_REG_DECL(cliccfg) = {bits:0};

    // select nlbits for this page mode
    cliccfg.fields.nlbits = nlbitsR(root, mode);

    // M-mode page also reports nmbits
    cliccfg.fields.nmbits = (mode==RISCV_MODE_M) ? nmbitsR(root) : 0;

    // preserve read-only nvbits field
    cliccfg.fields.nvbits = haveNVbits(root) && root->configInfo.CLICSELHVEC;

    // return composed value
    return cliccfg.bits;
}

//
// Write cliccfg
//
static void cliccfgW(riscvP root, Uns8 newValue) {

    CLIC_REG_DECL(cliccfg) = {bits:newValue};

    Bool refresh = False;

    // update nlbits if required
    refresh = nlbitsW(root, RISCV_MODE_M, cliccfg.fields.nlbits) || refresh;

    // update nmbits if required
    refresh = nmbitsW(root, cliccfg.fields.nmbits) || refresh;

    // use M-mode nlbits for S and U modes
    Uns8 nlbits = nlbitsR(root, RISCV_MODE_M);
    root->clic.cliccfg.nlbits[RISCV_MODE_U] = nlbits;
    root->clic.cliccfg.nlbits[RISCV_MODE_S] = nlbits;

    // refresh interrupt state if changed
    if(refresh) {
        refreshCCLICInterruptAll(root);
    }
}

//
// Read mcliccfg byte (bits 7:0 of mcliccfg)
//
static Uns8 mcliccfgR(riscvP root) {

    CLIC_REG_DECL(mcliccfg) = {
        fields : {
            nlbits : nlbitsR(root, RISCV_MODE_M),
            nmbits : nmbitsR(root)
        }
    };

    // return composed value
    return mcliccfg.bits;
}

//
// Write mcliccfg byte (bits 7:0 of mcliccfg)
//
static void mcliccfgW(riscvP root, Uns8 newValue) {

    CLIC_REG_DECL(mcliccfg) = {bits:newValue};

    Bool refresh = False;

    // update nlbits if required
    refresh = nlbitsW(root, RISCV_MODE_M, mcliccfg.fields.nlbits) || refresh;

    // update nmbits if required
    refresh = nmbitsW(root, mcliccfg.fields.nmbits) || refresh;

    // refresh interrupt state if changed
    if(refresh) {
        refreshCCLICInterruptAll(root);
    }
}

//
// Read scliccfg byte (bits 23:16 of mcliccfg or scliccfg)
//
static Uns8 scliccfgR(riscvP root) {

    CLIC_REG_DECL(scliccfg) = {
        fields : {
            nlbits : nlbitsR(root, RISCV_MODE_S)
        }
    };

    // return composed value
    return scliccfg.bits;
}

//
// Write scliccfg byte (bits 23:16 of mcliccfg or scliccfg)
//
static void scliccfgW(riscvP root, Uns8 newValue) {

    CLIC_REG_DECL(scliccfg) = {bits:newValue};

    Bool refresh = False;

    // update nlbits if required
    refresh = nlbitsW(root, RISCV_MODE_S, scliccfg.fields.nlbits) || refresh;

    // refresh interrupt state if changed
    if(refresh) {
        refreshCCLICInterruptAll(root);
    }
}

//
// Read ucliccfg byte (bits 31:24 of mcliccfg, scliccfg or ucliccfg)
//
static Uns8 ucliccfgR(riscvP root) {

    CLIC_REG_DECL(ucliccfg) = {
        fields : {
            nlbits : nlbitsR(root, RISCV_MODE_U)
        }
    };

    // return composed value
    return ucliccfg.bits;
}

//
// Write ucliccfg byte (bits 31:24 of mcliccfg, scliccfg or ucliccfg)
//
static void ucliccfgW(riscvP root, Uns8 newValue) {

    CLIC_REG_DECL(ucliccfg) = {bits:newValue};

    Bool refresh = False;

    // update nlbits if required
    refresh = nlbitsW(root, RISCV_MODE_U, ucliccfg.fields.nlbits) || refresh;

    // refresh interrupt state if changed
    if(refresh) {
        refreshCCLICInterruptAll(root);
    }
}

//
// Is this an access to mcliccfg byte?
//
inline static Bool mcliccfgAccess(riscvP root, CLICIntDescP desc) {
    return (desc->intIndex==0) && (desc->mode>=RISCV_MODE_M);
}

//
// Is this an access to scliccfg byte?
//
inline static Bool scliccfgAccess(riscvP root, CLICIntDescP desc) {
    return (desc->intIndex==2) && (desc->mode>=RISCV_MODE_S) && root->ssclic;
}

//
// Is this an access to ucliccfg byte?
//
inline static Bool ucliccfgAccess(riscvP root, CLICIntDescP desc) {
    return (desc->intIndex==3) && root->suclic;
}

//
// Read one byte from the CLIC
//
static Uns8 readCLICInt(riscvP root, CLICIntDescP desc) {

    Bool onecliccfg = !xcliccfgPerMode(root);
    Uns8 result     = 0;

    // debug access if required
    if(RISCV_DEBUG_EXCEPT(root)) {
        debugCLICAccess(root, desc, "READ");
    }

    // direct access either to interrupt or control page
    if(desc->fType!=CIT_clicconfig) {
        result = readCLICInterrupt(root, desc) >> (desc->fType*8);
    } else if(((desc->intIndex/4)==1) && !clicinfoAbsent(root)) {
        result = root->clic.clicinfo.bits >> ((desc->rawIndex&3)*8);
    } else if(onecliccfg && (desc->intIndex==0)) {
        result = cliccfgR(root, desc->mode);
    } else if(onecliccfg) {
        // no action
    } else if(mcliccfgAccess(root, desc)) {
        result = mcliccfgR(root);
    } else if(scliccfgAccess(root, desc)) {
        result = scliccfgR(root);
    } else if(ucliccfgAccess(root, desc)) {
        result = ucliccfgR(root);
    }

    return result;
}

//
// Write one byte to the CLIC
//
static void writeCLICInt(riscvP root, CLICIntDescP desc, Uns8 newValue) {

    Bool onecliccfg = !xcliccfgPerMode(root);

    // debug access if required
    if(RISCV_DEBUG_EXCEPT(root)) {
        debugCLICAccess(root, desc, "WRITE");
    }

    // direct access either to interrupt or control page
    if(desc->fType!=CIT_clicconfig) {
        writeCLICInterrupt(root, desc, newValue);
    } else if(onecliccfg && (desc->intIndex==0)) {
        cliccfgW(root, newValue);
    } else if(onecliccfg) {
        // no action
    } else if(mcliccfgAccess(root, desc)) {
        mcliccfgW(root, newValue);
    } else if(scliccfgAccess(root, desc)) {
        scliccfgW(root, newValue);
    } else if(ucliccfgAccess(root, desc)) {
        ucliccfgW(root, newValue);
    }
}


////////////////////////////////////////////////////////////////////////////////
// COMMON CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Map CLIC region and force aligned access to it
//
static void mapCLIC(
    riscvP        root,
    Addr          lowAddr,
    Uns32         size,
    vmiMemReadFn  readCB,
    vmiMemWriteFn writeCB
) {
    memDomainP domain   = root->CLICDomain;
    Addr       highAddr = lowAddr + size - 1;

    vmirtMapCallbacks(domain, lowAddr, highAddr, readCB, writeCB, root);
    vmirtProtectMemory(domain, lowAddr, highAddr, MEM_PRIV_ALIGN, MEM_PRIV_ADD);
}


////////////////////////////////////////////////////////////////////////////////
// MEMORY-MAPPED CALLBACKS, CLIC LEGACY VERSION BEFORE 0.9
//
// This memory map is specific to SiFive legacy CLIC.
//
// APERTURE LAYOUT
// ---------------
//
// 0x0280_0000   M-mode aperture for CLIC 0
// 0x0280_1000   M-mode aperture for CLIC 1
// ...
// 0x02A0_0000   HS-mode aperture for CLIC 0
// 0x02A0_1000   HS-mode aperture for CLIC 1
// ...
// 0x02C0_0000   S-mode aperture for CLIC 0
// 0x02C0_1000   S-mode aperture for CLIC 1
// ...
// 0x02E0_0000   U-mode aperture for CLIC 0
// 0x02E0_1000   U-mode aperture for CLIC 1
//
// CLIC REGION LAYOUT (WITHIN APERTURE)
// -----------------------------------
// 0x000+i   1B/input    R or RW       clicintip[i]
// 0x400+i   1B/input    RW            clicintie[i]
// 0x800+i   1B/input    RW            clicintcfg[i]
// 0xc00     1B          RW            cliccfg (*** M-mode only ***)
//
////////////////////////////////////////////////////////////////////////////////

#define CLIC_OLD_SIZE       0x800000
#define CLIC_OLD_MODE_MASK  0x1fffff
#define CLIC_OLD_AP_SIZE    0x001000
#define CLIC_OLD_INDEX_MASK 0x0003ff

//
// Return the base address of the cluster CLIC block
//
inline static Uns64 getCLICLow(riscvP root) {
    return root->configInfo.mclicbase;
}

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
// Return the CLIC page type being accessed at the given offset
//
static riscvMode getCLICOldPMode(Uns32 offset) {

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
static CLICIntFieldType getCLICOldFType(Uns32 offset) {

    switch((offset & (CLIC_OLD_AP_SIZE-1))/(CLIC_OLD_AP_SIZE/4)) {
        case 0:
            return CIT_clicintip;
        case 1:
            return CIT_clicintie;
        case 2:
            return CIT_clicintctl;
        default:
            return CIT_clicconfig;
    }
}

//
// Given original CLIC offset, fill abstract description of the field access
//
static CLICIntDesc fillCLICDescOld(riscvP root, Uns32 offset) {

    CLICIntDesc result = {
        rawIndex  : offset,
        hartIndex : getCLICOldHart(offset),
        mode      : getCLICOldPMode(offset),
        fType     : getCLICOldFType(offset),
        intIndex  : getCLICOldIntId(offset)
    };

    if(result.fType!=CIT_clicconfig) {

        // no action

    } else if(result.mode!=RISCV_MODE_M) {

        // only M-mode can access clicconfig region
        result.fType = CIT_LAST;

    } else if(result.intIndex) {

        // only cliccfg is present
        result.fType = CIT_LAST;
    }

    return result;
}

//
// Mask clicintctl by region type
//
static Uns8 maskCLICOldIntCfg(riscvP root, CLICIntDescP desc, Uns8 clicintctl) {

    if(desc->mode!=RISCV_MODE_M) {

        Uns32  hartId = desc->hartIndex;
        riscvP riscv  = root->clic.harts[hartId];

        if((desc->mode==RISCV_MODE_S) || !supervisorPresent(riscv)) {
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
    riscvP      root,
    CLICIntDesc desc,
    Uns8        clicintctl
) {
    Uns32 CLICINTCTLBITS = root->clic.clicinfo.fields.CLICINTCTLBITS;

    CLIC_REG_DECL(clicintattr) = {0};

    // shv is the least-significant writable bit of clicintctl
    clicintattr.fields.shv = (clicintctl & (1<<(8-CLICINTCTLBITS))) && True;

    // mode is the most-significant two bits of clicintctl
    clicintattr.fields.mode = clicintctl>>6;

    // update implied clicintattr
    desc.fType = CIT_clicintattr;
    writeCLICInt(root, &desc, clicintattr.bits);
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

        Uns32       offset = getCLICOldOffset(root, address+i);
        CLICIntDesc desc   = fillCLICDescOld(root, offset);

        if(desc.hartIndex<numHarts) {

            if(desc.fType!=CIT_LAST) {
                value8[i] = readCLICInt(root, &desc);
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

        Uns32       offset = getCLICOldOffset(root, address+i);
        CLICIntDesc desc   = fillCLICDescOld(root, offset);

        if(desc.hartIndex<numHarts) {

            if(desc.fType!=CIT_LAST) {

                Uns8 value = value8[i];

                if(desc.fType==CIT_clicintctl) {

                    // pre-0.9 clicintctl is masked by region type
                    value = maskCLICOldIntCfg(root, &desc, value);

                    // pre-0.9 clicintattr must be inferred from clicintctl
                    writeCLICOldIntAttr(root, desc, value);
                }

                writeCLICInt(root, &desc, value);
            }
        }
    }
}

//
// Create CLIC memory-mapped block and data structures (pre-0.9)
//
static void mapCLICDomainOld(riscvP root) {
    mapCLIC(root, getCLICLow(root), CLIC_OLD_SIZE, readCLICOld, writeCLICOld);
}


////////////////////////////////////////////////////////////////////////////////
// MEMORY-MAPPED CALLBACKS, CLIC VERSION 0.9 OR LATER
//
// M-MODE CLIC REGION (at mclicbase)
// -----------------------------------------------------------------------------
//
// 0x0000       1B          RW        mcliccfg
//
// 0x0040       4B          RW        clicinttrig[0]  (optional, unimplemented)
// 0x0044       4B          RW        clicinttrig[1]  (optional, unimplemented)
// 0x0048       4B          RW        clicinttrig[2]  (optional, unimplemented)
// ...
// 0x00B4       4B          RW        clicinttrig[29] (optional, unimplemented)
// 0x00B8       4B          RW        clicinttrig[30] (optional, unimplemented)
// 0x00BC       4B          RW        clicinttrig[31] (optional, unimplemented)
//
// 0x1000+4*i   1B/input    R or RW   clicintip[i]
// 0x1001+4*i   1B/input    RW        clicintie[i]
// 0x1002+4*i   1B/input    RW        clicintattr[i]
// 0x1003+4*i   1B/input    RW        clicintctl[i]
// ...
// 0x4FFC       1B/input    R or RW   clicintip[4095]
// 0x4FFD       1B/input    RW        clicintie[4095]
// 0x4FFE       1B/input    RW        clicintattr[4095]
// 0x4FFF       1B/input    RW        clicintctl[4095]
//
// S-MODE CLIC REGION (at sclicbase)
// -----------------------------------------------------------------------------
//
// *BEFORE* RVCLC_0_9_20221108:
// 0x000+4*i    1B/input    R or RW   clicintip[i]
// 0x001+4*i    1B/input    RW        clicintie[i]
// 0x002+4*i    1B/input    RW        clicintattr[i]
// 0x003+4*i    1B/input    RW        clicintctl[i]
//
// *FROM* RVCLC_0_9_20221108:
// 0x0000       1B          RW        scliccfg
// 0x1000+4*i   1B/input    R or RW   clicintip[i]
// 0x1001+4*i   1B/input    RW        clicintie[i]
// 0x1002+4*i   1B/input    RW        clicintattr[i]
// 0x1003+4*i   1B/input    RW        clicintctl[i]
//
// U-MODE CLIC REGION (at uclicbase)
// -----------------------------------------------------------------------------
//
// *BEFORE* RVCLC_0_9_20221108:
// 0x000+4*i    1B/input    R or RW   clicintip[i]
// 0x001+4*i    1B/input    RW        clicintie[i]
// 0x002+4*i    1B/input    RW        clicintattr[i]
// 0x003+4*i    1B/input    RW        clicintctl[i]
//
// *FROM* RVCLC_0_9_20221108:
// 0x0000       1B          RW        ucliccfg
// 0x1000+4*i   1B/input    R or RW   clicintip[i]
// 0x1001+4*i   1B/input    RW        clicintie[i]
// 0x1002+4*i   1B/input    RW        clicintattr[i]
// 0x1003+4*i   1B/input    RW        clicintctl[i]
//
////////////////////////////////////////////////////////////////////////////////

//
// Return the base address of the cluster M-mode CLIC block
//
inline static Uns64 getBaseM(riscvP root) {
    return root->configInfo.mclicbase;
}

//
// Return the base address of the cluster S-mode CLIC block
//
inline static Uns64 getBaseS(riscvP root) {
    return root->configInfo.sclicbase;
}

//
// Return the base address of the cluster U-mode CLIC block
//
inline static Uns64 getBaseU(riscvP root) {
    return root->configInfo.uclicbase;
}

//
// Convert from pages to bytes
//
inline static Uns32 pagesToBytes4k(Uns32 pages) {
    return pages*4096;
}

//
// Return the page index of the given offset
//
inline static Uns32 get4kPage(Uns32 offset) {
    return offset/4096;
}

//
// Return the byte index of the offset within a word
//
inline static Uns32 getCLICWordByte(Uns32 offset) {
    return offset%4;
}

//
// Return number of configuration pages required for S and U mode
//
inline static Uns32 configPagesSU(riscvP root) {
    return xcliccfgPerMode(root) ? 1 : 0;
}

//
// Return size of M-mode CLIC block
//
static Uns64 getSizeM(riscvP root) {
    return pagesToBytes4k(1 + getNumHarts(root)*4);
}

//
// Return size of S-mode CLIC block
//
static Uns64 getSizeS(riscvP root) {
    return pagesToBytes4k(configPagesSU(root) + getNumHarts(root)*4);
}

//
// Return size of U-mode CLIC block
//
static Uns64 getSizeU(riscvP root) {
    return pagesToBytes4k(configPagesSU(root) + getNumHarts(root)*4);
}

//
// Is the given feature present on any CLIC hart?
//
static Bool featurePresent(riscvP root, riscvArchitecture feature) {

    Uns32 numHarts = getNumHarts(root);
    Bool  present  = False;
    Uns32 i;

    for(i=0; !present && (i<numHarts); i++) {
        present = getCLICHart(root, i)->configInfo.arch & feature;
    }

    return present;
}

//
// Is ssclic implemented?
//
inline static Bool ssclic(riscvP root) {
    return featurePresent(root, ISA_S);
}

//
// Is suclic implemented?
//
inline static Bool suclic(riscvP root) {
    return featurePresent(root, ISA_N);
}

//
// Fill abstract description of control page access
//
static CLICIntDesc fillCLICDescCtrl(
    riscvMode mode,
    Uns32     rawOffset,
    Uns32     intOffset
) {
    CLICIntDesc result = {
        rawIndex  : rawOffset,
        hartIndex : -1,
        intIndex  : intOffset,
        mode      : mode,
        fType     : CIT_clicconfig
    };

    return result;
}

//
// Fill abstract description of interrupt page access
//
static CLICIntDesc fillCLICDescInt(
    riscvMode mode,
    Uns32     rawOffset,
    Uns32     intOffset
) {
    Uns32 intPage4k = get4kPage(intOffset);

    CLICIntDesc result = {
        rawIndex  : rawOffset,
        hartIndex : intPage4k/4,
        intIndex  : (intOffset/4)%4096,
        mode      : mode,
        fType     : getCLICWordByte(intOffset)
    };

    return result;
}

//
// Fill abstract description of M-mode CLIC field access
//
static CLICIntDesc getCLICDescM(riscvP root, Uns64 address) {

    Uns32 offset = address-getBaseM(root);

    if(offset<4096) {
        return fillCLICDescCtrl(RISCV_MODE_M, offset, offset);
    } else {
        return fillCLICDescInt(RISCV_MODE_M, offset, offset-4096);
    }
}

//
// Fill abstract description of S-mode or U-mode CLIC field access
//
static CLICIntDesc CLICIntDescSU(
    riscvP    root,
    riscvMode mode,
    Uns32     rawOffset,
    Uns32     intOffset
) {
    if(!xcliccfgPerMode(root)) {
        return fillCLICDescInt(mode, rawOffset, intOffset);
    } else if(intOffset<4096) {
        return fillCLICDescCtrl(mode, rawOffset, intOffset);
    } else {
        return fillCLICDescInt(mode, rawOffset, intOffset-4096);
    }
}

//
// Fill abstract description of S-mode CLIC field access
//
static CLICIntDesc getCLICDescS(riscvP root, Uns64 address) {

    Uns32 intOffset = address-getBaseS(root);
    Uns32 rawOffset = root->impSCB ? address-getBaseM(root) : intOffset;

    return CLICIntDescSU(root, RISCV_MODE_S, rawOffset, intOffset);
}

//
// Fill abstract description of U-mode CLIC field access
//
static CLICIntDesc getCLICDescU(riscvP root, Uns64 address) {

    Uns32 intOffset = address-getBaseU(root);
    Uns32 rawOffset = root->impUCB ? address-getBaseM(root) : intOffset;

    return CLICIntDescSU(root, RISCV_MODE_U, rawOffset, intOffset);
}

//
// Function type returning abstract description of interrupt page access
//
#define CLIC_INT_DESC_FN(_NAME) CLICIntDesc _NAME(riscvP root, Uns64 address)
typedef CLIC_INT_DESC_FN((*clicIntDescFn));

//
// Read CLIC register
//
static void readCLIC(
    riscvP        root,
    Uns8         *value8,
    Addr          address,
    Uns32         bytes,
    clicIntDescFn intDescCB
) {
    Uns32 i;

    for(i=0; i<bytes; i++) {
        CLICIntDesc desc = intDescCB(root, address+i);
        value8[i] = readCLICInt(root, &desc);
    }
}

//
// Write CLIC register
//
static void writeCLIC(
    riscvP        root,
    const Uns8   *value8,
    Addr          address,
    Uns32         bytes,
    clicIntDescFn intDescCB
) {
    Uns32 i;

    for(i=0; i<bytes; i++) {
        CLICIntDesc desc = intDescCB(root, address+i);
        writeCLICInt(root, &desc, value8[i]);
    }
}

//
// Read CLIC M-mode register
//
static VMI_MEM_READ_FN(readCLICM) {
    readCLIC(userData, value, address, bytes, getCLICDescM);
}

//
// Write CLIC M-mode register
//
static VMI_MEM_WRITE_FN(writeCLICM) {
    writeCLIC(userData, value, address, bytes, getCLICDescM);
}

//
// Read CLIC S-mode register
//
static VMI_MEM_READ_FN(readCLICS) {
    readCLIC(userData, value, address, bytes, getCLICDescS);
}

//
// Write CLIC S-mode register
//
static VMI_MEM_WRITE_FN(writeCLICS) {
    writeCLIC(userData, value, address, bytes, getCLICDescS);
}

//
// Read CLIC U-mode register
//
static VMI_MEM_READ_FN(readCLICU) {
    readCLIC(userData, value, address, bytes, getCLICDescU);
}

//
// Write CLIC U-mode register
//
static VMI_MEM_WRITE_FN(writeCLICU) {
    writeCLIC(userData, value, address, bytes, getCLICDescU);
}

//
// Create CLIC memory-mapped block and data structures (version 0.9 or later)
//
static void mapCLICDomain_0_9(riscvP root) {

    // get M, S and U region sizes
    Uns64 baseM = getBaseM(root);
    Uns64 baseS = getBaseS(root);
    Uns64 baseU = getBaseU(root);
    Uns32 sizeM = getSizeM(root);
    Uns32 sizeS = getSizeS(root);
    Uns32 sizeU = getSizeU(root);

    // derive sclicbase if it is unset
    if(!baseS) {
        root->impSCB = True;
        baseS = root->configInfo.sclicbase = baseM + sizeM;
    }

    // derive uclicbase if it is unset
    if(!baseU) {
        root->impUCB = True;
        baseU = root->configInfo.uclicbase = baseS + sizeS;
    }

    // map M-mode region
    mapCLIC(root, baseM, sizeM, readCLICM, writeCLICM);

    // map S-mode region if required
    if(root->ssclic) {
        mapCLIC(root, baseS, sizeS, readCLICS, writeCLICS);
    }

    // map U-mode region if required
    if(root->suclic) {
        mapCLIC(root, baseU, sizeU, readCLICU, writeCLICU);
    }
}


////////////////////////////////////////////////////////////////////////////////
// PUBLIC FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Create CLIC memory-mapped block and data structures
//
void riscvMapCLICDomain(riscvP riscv) {

    riscvP root = getCLICRoot(riscv);

    // record whether CLIC implements S and U modes
    root->ssclic = ssclic(root);
    root->suclic = suclic(root);

    if(riscv->configInfo.CLIC_version>=RVCLC_0_9_20191208) {
        mapCLICDomain_0_9(root);
    } else {
        mapCLICDomainOld(root);
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
        COPY_CLIC_CFG(root, child, nlbits_valid);
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
        COPY_CLIC_CFG(root, child, INTTHRESHBITS);
        COPY_CLIC_CFG(root, child, tvt_undefined);
        COPY_CLIC_CFG(root, child, intthresh_undefined);
        COPY_CLIC_CFG(root, child, mclicbase_undefined);
        COPY_CLIC_CFG(root, child, CSIP_present);
        COPY_CLIC_CFG(root, child, posedge_other);
        COPY_CLIC_CFG(root, child, poslevel_other);
        COPY_CLIC_CFG(root, child, local_int_num);
    }

    // allocate CLIC data structures if required
    if(CLICInternal(root)) {

        Uns32 numHarts = getNumHarts(root);
        Uns32 intNum   = riscvGetIntNum(root);
        Uns32 nlbits   = 0;

        // initialise nlbits in cliccfg to smallest legal value using
        // configuration option
        while(!nlbitsValid(root, nlbits)) {
            nlbits++;
        }

        // use smallest legal value in all modes
        root->clic.cliccfg.nlbits[0] = nlbits;
        root->clic.cliccfg.nlbits[1] = nlbits;
        root->clic.cliccfg.nlbits[2] = nlbits;
        root->clic.cliccfg.nlbits[3] = nlbits;

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
            CLIC_REG_DECL(clicintattr) = {fields:{mode:RISCV_MODE_M}};

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
        if(!xcliccfgPerMode(riscv)) {
            cliccfgW(riscv, 0);
        } else {
            mcliccfgW(riscv, 0);
            scliccfgW(riscv, 0);
            ucliccfgW(riscv, 0);
        }

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

