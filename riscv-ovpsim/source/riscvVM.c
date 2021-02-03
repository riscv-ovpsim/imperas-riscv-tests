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

// Standard header files
#include <stdio.h>      // for sprintf

// Imperas header files
#include "hostapi/impAlloc.h"
#include "hostapi/typeMacros.h"

// VMI header files
#include "vmi/vmiAttrs.h"
#include "vmi/vmiMessage.h"
#include "vmi/vmiRt.h"
#include "vmi/vmiTypes.h"

// Model header files
#include "riscvCLIC.h"
#include "riscvDecode.h"
#include "riscvDecodeTypes.h"
#include "riscvExceptions.h"
#include "riscvFunctions.h"
#include "riscvMessage.h"
#include "riscvStructure.h"
#include "riscvUtils.h"
#include "riscvVM.h"
#include "riscvVMConstants.h"
#include "riscvVMUtils.h"

//
// This is the highest possible address
//
#define RISCV_MAX_ADDR (-1)

//
// tlbEntry opaque type pointer
//
DEFINE_S(tlbEntry);

//
// Union representing simulated ASID (including bits depending on xstatus
// register settings and VMID if required)
//
typedef union riscvSimASIDU {

    // field view
    struct {
        Uns16 ASID_HS : 16; // HS-mode ASID
        Uns16 ASID_VS : 16; // VS-mode ASID
        Uns16 VMID    : 16; // VMID
        Bool  MXR_HS  :  1; // HS-mode make-executable-readable
        Bool  SUM_HS  :  1; // HS-mode supervisor-user-access
        Bool  MXR_VS  :  1; // VS-mode make-executable-readable
        Bool  SUM_VS  :  1; // VS-mode supervisor-user-access
        Bool  S1      :  1; // is virtual stage 1 enabled?
        Bool  S2      :  1; // is virtual stage 2 enabled?
        Uns32 _u1     : 10; // padding bits
    } f;

    // full simulated ASID view
    Uns64 u64;

} riscvSimASID;

//
// Structure representing a single TLB entry
//
typedef struct tlbEntryS {

    // entry virtual address range
    Uns64 lowVA;        // entry low virtual address
    Uns64 highVA;       // entry high virtual address

    // entry low physical address
    Uns64 PA;

    // simulated ASID when mapped (including xstatus bits that affect it)
    riscvSimASID simASID;

    // entry attributes
    riscvTLBId tlb      :  2;   // containing TLB
    Uns8       mapped   :  2;   // TLB entry mapped (per base mode)
    Uns32      priv     :  3;   // access privilege
    Bool       V        :  1;   // valid bit
    Uns32      U        :  1;   // user accessible?
    Uns32      G        :  1;   // global bit
    Uns32      A        :  1;   // accessed bit (read or written)
    Uns32      D        :  1;   // dirty bit (written)
    Bool       artifact :  1;   // entry created by artifact lookup
    Uns32      _u1      :  2;   // spare bits
    // custom entry attributes
    Bool       custom   :  1;   // is this a custom TLB entry?
    Uns32      entryId  : 16;   // entry id

    // range LUT entry (for fast lookup by address)
    union {
        struct tlbEntryS *nextFree; // when in free list
        vmiRangeEntryP    lutEntry; // equivalent range entry when mapped
        Uns64             _size;    // for 32/64-bit host compatibility
    };

} tlbEntry;

//
// This type records simulated ASIDs that been recently used
//
typedef struct riscvASIDCacheS {
    Uns16 VMID;                     // recently-used VMID
    Uns16 ASID;                     // recently-used ASID
    Bool  valid;                    // is entry valid?
} riscvASIDCache, *riscvASIDCacheP;

//
// Structure representing a TLB
//
typedef struct riscvTLBS {
    vmiRangeTableP  lut;            // range LUT entry (for fast lookup)
    tlbEntryP       free;           // list of free entries available for reuse
    Uns32           ASIDCacheSize;  // active ASID cache size
    riscvASIDCacheP ASIDCache;      // cache of active ASIDs
    Uns64           ASIDICount;     // monitor base instruction count
    Uns64           ASIDEjectNum;   // count of ASID cache ejections
} riscvTLB;

//
// Structure describing mapping constraints for TLB entry
//
typedef struct tlbMapInfoS {
    Uns64   lowVA;          // low virtual address mapped
    Uns64   highVA;         // high virtual address mapped
    memPriv priv;           // effective privilege
} tlbMapInfo, *tlbMapInfoP;

//
// Enumeration of supported translation modes
//
typedef enum VAModeE {
    VAM_Sv32 = 1,   // Sv32 translation (32-bit VA)
    VAM_Sv39 = 8,   // Sv39 translation (39-bit VA)
    VAM_Sv48 = 9,   // Sv48 translation (48-bit VA)
} VAMode;


////////////////////////////////////////////////////////////////////////////////
// UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// This macro implements an iterator to traverse all TLB entries in a range
//
#define ITER_TLB_ENTRY_RANGE(_RISCV, _TLB, _LOWVA, _HIGHVA, _ENTRY, _B) { \
                                                                    \
    tlbEntryP _ENTRY;                                               \
    Uns64     _lowVA  = _LOWVA;                                     \
    Uns64     _highVA = _HIGHVA;                                    \
                                                                    \
    for(                                                            \
        _ENTRY = firstTLBEntryRange(_RISCV, _TLB, _lowVA, _highVA); \
        _ENTRY;                                                     \
        _ENTRY = nextTLBEntryRange(_RISCV, _TLB, _lowVA, _highVA)   \
    ) {                                                             \
        _B;                                                         \
    }                                                               \
}

//
// Return the effective stage 1 TLB
//
inline static riscvTLBId getS1TLBId(riscvP riscv) {
    return inVMode(riscv) ? RISCV_TLB_VS1 : RISCV_TLB_HS;
}

//
// Determine the currently-active TLB
//
static riscvTLBId getCurrentTLBId(riscvP riscv, riscvMode mode) {

    riscvTLBId result = RISCV_TLB_LAST;

    if(!modeIsVirtual(mode)) {

        if(RD_CSR_FIELD_S(riscv, satp, MODE)) {
            result = RISCV_TLB_HS;
        }

    } else {

        if(RD_CSR_FIELD_VS(riscv, vsatp, MODE)) {
            result = RISCV_TLB_VS1;
        } else if(RD_CSR_FIELD_S(riscv, hgatp, MODE)) {
            result = RISCV_TLB_VS2;
        }
    }

    VMI_ASSERT(result!=RISCV_TLB_LAST, "no active TLB");

    return result;
}

//
// Is stage 2 address lookup required for the active translation domain?
//
inline static Bool doStage2(riscvP riscv, riscvTLBId id) {
    return ((id==RISCV_TLB_VS1) && RD_CSR_FIELD_S(riscv, hgatp, MODE));
}

//
// Return id of the given TLB
//
static riscvTLBId getTLBId(riscvP riscv, riscvTLBP tlb) {

    riscvTLBId id;

    // scan to get index of matching TLB
    for(id=0; id<RISCV_TLB_LAST; id++) {
        if(riscv->tlb[id]==tlb) {
            break;
        }
    }

    // sanoty check index was found
    VMI_ASSERT(id!=RISCV_TLB_LAST, "TLB id lookup failed");

    return id;
}

//
// Return TLB name for an id
//
static const char *getTLBName(riscvP riscv, riscvTLBId id) {

    static const char *map[RISCV_TLB_LAST] = {
        [RISCV_TLB_HS]  = "HS",
        [RISCV_TLB_VS1] = "VS1",
        [RISCV_TLB_VS2] = "VS2",
    };

    return hypervisorPresent(riscv) ? map[id] : "TLB";
}

//
// Return the currently-activated TLB
//
static riscvTLBP getActiveTLB(riscvP riscv) {
    return riscv->tlb[riscv->activeTLB];
}

//
// Activate the given TLB (and return the previous active TLB)
//
inline static riscvTLBId activateTLB(riscvP riscv, riscvTLBId id) {

    riscvTLBId old = riscv->activeTLB;

    riscv->activeTLB = id;

    return old;
}

//
// Deactivate the given TLB, restoring previous active state
//
inline static void deactivateTLB(riscvP riscv, riscvTLBId old) {
    riscv->activeTLB = old;
}

//
// Is a virtual TLB active?
//
inline static Bool activeTLBIsVirtual(riscvP riscv) {
    return (riscv->activeTLB!=RISCV_TLB_HS);
}

//
// Is the VS stage 2 TLB active?
//
inline static Bool activeTLBIsVS2(riscvP riscv) {
    return (riscv->activeTLB==RISCV_TLB_VS2);
}

//
// Return current program counter
//
inline static Uns64 getPC(riscvP riscv) {
    return vmirtGetPC((vmiProcessorP)riscv);
}

//
// Return the number of implemented PMP registers
//
inline static Uns32 getNumPMPs(riscvP riscv) {
    return riscv->configInfo.PMP_registers;
}

//
// Return table entry implied global state
//
inline static Bool getG(riscvP riscv, Bool G) {
    return G || activeTLBIsVS2(riscv) || !getASIDMask(riscv);
}

//
// Is hardware update of PTE A bit supported?
//
inline static Bool updatePTEA(riscvP riscv) {
    return riscv->configInfo.updatePTEA;
}

//
// Is hardware update of PTE D bit supported?
//
inline static Bool updatePTED(riscvP riscv) {
    return riscv->configInfo.updatePTED;
}

//
// Does the TLB entry have a VMID?
//
inline static Bool entryHasVMID(tlbEntryP entry) {
    return (entry->tlb==RISCV_TLB_VS1) || (entry->tlb==RISCV_TLB_VS2);
}

//
// Return TLB entry ASID
//
static Uns32 getEntryASID(tlbEntryP entry) {

    Uns32 result = 0;

    if(entry->tlb==RISCV_TLB_HS) {
        result = entry->simASID.f.ASID_HS;
    } else if(entry->tlb==RISCV_TLB_VS1) {
        result = entry->simASID.f.ASID_VS;
    }

    return result;
}

//
// Return TLB entry VMID
//
static Uns32 getEntryVMID(tlbEntryP entry) {

    Uns32 result = 0;

    if((entry->tlb==RISCV_TLB_VS1) || (entry->tlb==RISCV_TLB_VS2)) {
        result = entry->simASID.f.VMID;
    }

    return result;
}

//
// Given a TLB entry, return the corresponding simulated ASID including xstatus
// bits that affect whether entries are used that were in force when the entry
// was created
//
inline static Uns64 getEntrySimASID(tlbEntryP entry) {
    return entry->simASID.u64;
}

//
// Return TLB entry low VA
//
inline static Uns64 getEntryLowVA(tlbEntryP entry) {
    return entry->lowVA;
}

//
// Return TLB entry high VA
//
inline static Uns64 getEntryHighVA(tlbEntryP entry) {
    return entry->highVA;
}

//
// Return TLB entry size
//
inline static Uns64 getEntrySize(tlbEntryP entry) {
    return entry->highVA - entry->lowVA + 1;
}

//
// Return TLB entry low PA
//
inline static Uns64 getEntryLowPA(tlbEntryP entry) {
    return entry->PA;
}

//
// Return TLB entry high PA
//
inline static Uns64 getEntryHighPA(tlbEntryP entry) {
    return entry->PA + entry->highVA - entry->lowVA;
}

//
// Return TLB entry VA-to-PA offset
//
inline static Uns64 getEntryVAtoPA(tlbEntryP entry) {
    return entry->PA - entry->lowVA;
}

//
// Return TLB entry ASID mask
//
inline static Uns64 getEntryASIDMask(tlbEntryP entry, riscvMode mode) {

    Bool         V        = modeIsVirtual(mode);
    riscvSimASID ASIDMask = {f:{MXR_HS:1}};

    // include ASID field only if this entry is not global
    if(entry->G) {
        // no action
    } else if(V) {
        ASIDMask.f.ASID_VS = -1;
    } else {
        ASIDMask.f.ASID_HS = -1;
    }

    // include U field only if this entry is user-accessible and in Supervisor
    // mode
    if(entry->tlb==RISCV_TLB_VS2) {
        // stage 2 entries are always treated as user mode, so SUM is ignored
    } else if(entry->U && (getBaseMode(mode)==RISCV_MODE_S)) {
        ASIDMask.f.SUM_HS = !V;
        ASIDMask.f.SUM_VS =  V;
    }

    // include fields required only when V=1
    if(V) {
        ASIDMask.f.VMID   = -1;
        ASIDMask.f.MXR_VS = -1;
        ASIDMask.f.S1     = -1;
        ASIDMask.f.S2     = -1;
    }

    return ASIDMask.u64;
}

//
// Get effective value of xstatus.MPRV
//
static Bool getMPRV(riscvP riscv) {

    Bool MPRV = RD_CSR_FIELDC(riscv, mstatus, MPRV);

    // in debug mode, MPRV requires dcsr.mprven to be set
    if(inDebugMode(riscv)) {
        MPRV &= RD_CSR_FIELDC(riscv, dcsr, mprven);
    }

    return MPRV;
}

//
// Get effective value of xstatus.MPP
//
inline static riscvMode getMPP(riscvP riscv) {
    return RD_CSR_FIELDC(riscv, mstatus, MPP);
}

//
// Get ASID for the currently-active TLB
//
static Uns32 getActiveASID(riscvP riscv) {
    switch(riscv->activeTLB) {
        case RISCV_TLB_HS:
            return RD_CSR_FIELD_S(riscv, satp, ASID);
        case RISCV_TLB_VS1:
            return RD_CSR_FIELD_VS(riscv, vsatp, ASID);
        default:
            return 0;
    }
}

//
// Get VMID for the currently-active TLB
//
static Uns32 getActiveVMID(riscvP riscv) {
    switch(riscv->activeTLB) {
        case RISCV_TLB_VS1:
        case RISCV_TLB_VS2:
            return RD_CSR_FIELD_S(riscv, hgatp, VMID);
        default:
            return 0;
    }
}

//
// Is code domain required for the passed privilege?
//
inline static Bool isFetch(memPriv priv) {
    return (priv & MEM_PRIV_X) && True;
}

//
// Does the entry ASID match the given TLB VMID?
//
inline static Bool matchVMID(Uns32 VMID, tlbEntryP entry) {
    return !entryHasVMID(entry) || (VMID==getEntryVMID(entry));
}

//
// Does the entry ASID match the given TLB ASID? (always true for global
// entries)
//
inline static Bool matchASID(Uns32 ASID, tlbEntryP entry) {
    return (entry->G || (ASID==getEntryASID(entry)));
}

//
// Return the current simulated ASID, taking into account xstatus bits that
// affect whether entries are used
//
static riscvSimASID getSimASID(riscvP riscv) {

    return (riscvSimASID){
        f: {
            ASID_HS : RD_CSR_FIELD_S(riscv, satp, ASID),
            ASID_VS : RD_CSR_FIELD_VS(riscv, vsatp, ASID),
            VMID    : RD_CSR_FIELD_S(riscv, hgatp, VMID),
            MXR_HS  : RD_CSR_FIELDC(riscv, mstatus, MXR),
            SUM_HS  : RD_CSR_FIELDC(riscv, mstatus, SUM),
            MXR_VS  : RD_CSR_FIELDC(riscv, vsstatus, MXR),
            SUM_VS  : RD_CSR_FIELDC(riscv, vsstatus, SUM),
            S1      : RD_CSR_FIELD_VS(riscv, vsatp, MODE),
            S2      : RD_CSR_FIELD_S(riscv, hgatp, MODE)
        }
    };
}

//
// Get root page table address
//
inline static Uns64 getPTETableAddress(Uns64 PPN) {
    return PPN << RISCV_PAGE_SHIFT;
}

//
// Get root page table address
//
static Uns64 getRootTableAddress(riscvP riscv) {

    Uns64 result = 0;

    switch(riscv->activeTLB) {

        case RISCV_TLB_HS:
            result = getPTETableAddress(RD_CSR_FIELD_S(riscv, satp, PPN));
            break;

        case RISCV_TLB_VS1:
            result = getPTETableAddress(RD_CSR_FIELD_VS(riscv, vsatp, PPN));
            break;

        case RISCV_TLB_VS2:
            result = getPTETableAddress(RD_CSR_FIELD_S(riscv, hgatp, PPN));
            result += (riscv->s2Offset * 4096);
            break;

        default:
            VMI_ABORT("Invalid TLB %u", riscv->activeTLB); // LCOV_EXCL_LINE
            break;
    }

    return result;
}

//
// Validate entry access permissions
//
static memPriv checkEntryPermission(
    riscvP    riscv,
    riscvMode mode,
    tlbEntryP entry,
    memPriv   requiredPriv
) {
    memPriv priv = entry->priv;
    Bool    MXR  = RD_CSR_FIELDC(riscv, mstatus, MXR);
    Bool    SUM  = RD_CSR_FIELDC(riscv, mstatus, SUM);

    if(riscv->activeTLB==RISCV_TLB_VS1) {

        // modify MXR and SUM if this is a stage 1 virtual access
        MXR |= RD_CSR_FIELDC(riscv, vsstatus, MXR);
        SUM  = RD_CSR_FIELDC(riscv, vsstatus, SUM);

    } else if(riscv->activeTLB==RISCV_TLB_VS2) {

        // stage 2 accesses are always taken to be U mode
        mode = RISCV_MODE_U;
    }

    // add read permission if executable and xstatus.MXR=1 (must be done
    // *before* mode-specific check below to correctly handle version-specific
    // SUM behavior)
    if((priv&MEM_PRIV_X) && MXR) {
        priv |= MEM_PRIV_R;
    }

    if(getBaseMode(mode)==RISCV_MODE_U) {

        // no access in user mode unless U=1
        if(!entry->U) {
            priv = MEM_PRIV_NONE;
        }

    } else if(entry->U) {

        // no access in supervisor mode if U=1 unless xstatus.SUM=1
        if(!SUM) {
            priv = MEM_PRIV_NONE;
        } else if(RISCV_PRIV_VERSION(riscv) >= RVPV_1_11) {
            // behavior from privileged architecture 1.11 only - never
            // executable in Supervisor mode if U=1
            priv &= ~MEM_PRIV_X;
        }
    }

    // indicate whether permission is allowed
    return ((priv & requiredPriv) == requiredPriv) ? priv : MEM_PRIV_NONE;
}

//
// Is the VA valid? (VPNextend must extend VPN)
//
static Bool validVA(Int64 VPN, Int32 VPNextend) {
    return (VPN>=0) ? (VPNextend==0) : (VPNextend==-1);
}

//
// Return the physical memory domain to use for the passed code/data access
//
static memDomainP getPhysDomainCorD(riscvP riscv, riscvMode mode, Bool isCode) {
    return riscv->physDomains[getBaseMode(mode)][isCode];
}

//
// Return the PMA memory domain to use for the passed code/data access
//
static memDomainP getPMADomainCorD(riscvP riscv, riscvMode mode, Bool isCode) {
    return riscv->pmaDomains[getBaseMode(mode)][isCode];
}

//
// Return the PMP memory domain to use for the passed code/data access
//
static memDomainP getPMPDomainCorD(riscvP riscv, riscvMode mode, Bool isCode) {
    return riscv->pmpDomains[getBaseMode(mode)][isCode];
}

//
// Return the virtual memory domain to use for the passed code/data access
//
static memDomainP getVirtDomainCorD(riscvP riscv, riscvMode mode, Bool isCode) {
    riscvVMMode vmMode = modeToVMMode(mode);
    return (vmMode==RISCV_VMMODE_LAST) ? 0 : riscv->vmDomains[vmMode][isCode];
}

//
// Return the PMP memory domain to use for the passed memory access type
//
static memDomainP getPMPDomainPriv(riscvP riscv, riscvMode mode, memPriv priv) {
    return getPMPDomainCorD(riscv, mode, isFetch(priv));
}

//
// Return the memory domain to use for page table walk accesses
//
static memDomainP getPTWDomain(riscvP riscv) {
    if(doStage2(riscv, riscv->activeTLB)) {
        return riscv->guestPTWDomain;
    } else {
        return getPMPDomainPriv(riscv, RISCV_MODE_S, MEM_PRIV_RW);
    }
}

//
// saved page table walk context
//
typedef struct ptwCxtS {
    Bool  PTWActive;
    Uns64 tinst;
} ptwCxt;

//
// Enter PTW context
//
static ptwCxt enterPTWContext(riscvP riscv, Uns32 size, memPriv priv) {

    ptwCxt result = {PTWActive:riscv->PTWActive, tinst:riscv->tinst};

    riscv->PTWActive  = True;
    riscv->PTWBadAddr = False;

    // set pseudo-instruction reported on stage 2 fault if required
    if(doStage2(riscv, riscv->activeTLB)) {
        riscv->tinst = (
            ((size==4)          ? 0x2000 : 0x3000) +
            ((priv==MEM_PRIV_W) ? 0x0020 : 0x0000)
        );
    }

    return result;
}

//
// Leave PTW context
//
inline static void leavePTWContext(riscvP riscv, ptwCxt oldCxt) {

    riscv->PTWActive = oldCxt.PTWActive;
    riscv->tinst     = oldCxt.tinst;
}

//
// Read an entry from a page table (returning invalid all-zero entry if the
// lookup fails)
//
static Uns64 readPageTableEntry(
    riscvP         riscv,
    riscvMode      mode,
    Uns64          PTEAddr,
    Uns32          size,
    memAccessAttrs attrs
) {
    memDomainP domain = getPTWDomain(riscv);
    memEndian  endian = riscvGetDataEndian(riscv, getSMode(mode));
    ptwCxt     oldCxt = enterPTWContext(riscv, size, MEM_PRIV_R);
    Uns64      result = 0;

    // read 4-byte or 8-byte entry
    if(size==4) {
        result = vmirtRead4ByteDomain(domain, PTEAddr, endian, attrs);
    } else {
        result = vmirtRead8ByteDomain(domain, PTEAddr, endian, attrs);
    }

    // exit PTW context
    leavePTWContext(riscv, oldCxt);

    return result;
}

//
// Write an entry in a page table
//
static void writePageTableEntry(
    riscvP         riscv,
    riscvMode      mode,
    Uns64          PTEAddr,
    Uns32          size,
    memAccessAttrs attrs,
    Uns64          value
) {
    memDomainP domain = getPTWDomain(riscv);
    memEndian  endian = riscvGetDataEndian(riscv, getSMode(mode));
    ptwCxt     oldCxt = enterPTWContext(riscv, size, MEM_PRIV_W);

    // write 4-byte or 8-byte entry
    if(riscv->artifactAccess) {
        // no action if an artifact access (e.g. page table walk initiated by
        // pseudo-register write)
    } else if(size==4) {
        vmirtWrite4ByteDomain(domain, PTEAddr, endian, value, attrs);
    } else {
        vmirtWrite8ByteDomain(domain, PTEAddr, endian, value, attrs);
    }

    // exit PTW context
    leavePTWContext(riscv, oldCxt);
}


////////////////////////////////////////////////////////////////////////////////
// PAGE TABLE WALK ERROR HANDLING AND REPORTING
////////////////////////////////////////////////////////////////////////////////

//
// This enumerates page table walk errors
//
typedef enum pteErrorE {
    PTEE_VAEXTEND,          // page table entry VA has invalid extension
    PTEE_READ,              // page table entry load failed
    PTEE_WRITE,             // page table entry store failed
    PTEE_V0,                // page table entry V=0
    PTEE_R0W1,              // page table entry R=0 W=1
    PTEE_LEAF,              // page table entry must be leaf level
    PTEE_ALIGN,             // page table entry is a misaligned superpage
    PTEE_PRIV,              // page table entry does not allow access
    PTEE_A0,                // page table entry A=0
    PTEE_D0,                // page table entry D=0
} pteError;

//
// Return character corresponding to privilege
//
static char getAccessChar(memPriv requiredPriv) {

    char result = 0;

    switch(requiredPriv) {
        case MEM_PRIV_R:
            result = 'R';
            break;
        case MEM_PRIV_W:
            result = 'W';
            break;
        case MEM_PRIV_X:
            result = 'X';
            break;
        default:
            VMI_ABORT("Invalid privilege %u", requiredPriv); // LCOV_EXCL_LINE
            break;
    }

    return result;
}

//
// Return load page fault for the currently-active translation stage
//
static riscvException loadPageFault(riscvP riscv) {

    // is this a stage 2 fault?
    Bool S2 = (riscv->activeTLB==RISCV_TLB_VS2);

    return S2 ? riscv_E_LoadGuestPageFault : riscv_E_LoadPageFault;
}

//
// Return store/AMO page fault for the currently-active translation stage
//
static riscvException storeAMOPageFault(riscvP riscv) {

    // is this a stage 2 fault?
    Bool S2 = (riscv->activeTLB==RISCV_TLB_VS2);

    return S2 ? riscv_E_StoreAMOGuestPageFault : riscv_E_StoreAMOPageFault;
}

//
// Return instruction page fault for the currently-active translation stage
//
static riscvException instructionPageFault(riscvP riscv) {

    // is this a stage 2 fault?
    Bool S2 = (riscv->activeTLB==RISCV_TLB_VS2);

    return S2 ? riscv_E_InstructionGuestPageFault : riscv_E_InstructionPageFault;
}

//
// Return fault type based on the original access on a page table walk
//
static riscvException originalAccessFault(riscvP riscv) {

    memPriv        origPriv = riscv->origPriv;
    riscvException result   = 0;

    switch(riscv->origPriv) {
        case MEM_PRIV_R:
            result = riscv_E_LoadAccessFault;
            break;
        case MEM_PRIV_W:
            result = riscv_E_StoreAMOAccessFault;
            break;
        case MEM_PRIV_X:
            result = riscv_E_InstructionAccessFault;
            break;
        default:
            VMI_ABORT("Invalid privilege %u", origPriv); // LCOV_EXCL_LINE
            break;
    }

    return result;
}

//
// Handle a specific error arising during a page table walk
//
static riscvException handlePTWException(
    riscvP    riscv,
    riscvMode mode,
    tlbEntryP entry,
    memPriv   requiredPriv,
    Uns64     PTEAddr,
    pteError  error
) {
    // this enumerates generated exceptions
    typedef enum pteExceptionE {
        PTX_LOAD_ACCESS,        // load access fault
        PTX_STORE_ACCESS,       // store access fault
        PTX_PAGE,               // page fault
    } pteException;

    // structure holding information about a specific error
    typedef struct pteErrorDescS {
        Bool         warn;      // whether to generate warning (otherwise, info)
        pteException exception; // exception description
        const char  *desc;      // description
    } pteErrorDesc;

    // exception table
    static const pteErrorDesc map[] = {
        [PTEE_VAEXTEND] = {1, PTX_PAGE,         "VA has invalid extension" },
        [PTEE_READ]     = {1, PTX_LOAD_ACCESS,  "load failed"              },
        [PTEE_WRITE]    = {1, PTX_STORE_ACCESS, "store failed"             },
        [PTEE_V0]       = {0, PTX_PAGE,         "V=0"                      },
        [PTEE_R0W1]     = {1, PTX_PAGE,         "R=0 and W=1"              },
        [PTEE_LEAF]     = {1, PTX_PAGE,         "must be leaf level"       },
        [PTEE_ALIGN]    = {1, PTX_PAGE,         "is a misaligned superpage"},
        [PTEE_PRIV]     = {0, PTX_PAGE,         "does not allow access"    },
        [PTEE_A0]       = {0, PTX_PAGE,         "A=0"                      },
        [PTEE_D0]       = {0, PTX_PAGE,         "D=0"                      },
    };

    // get description for this error
    const pteErrorDesc *desc     = &map[error];
    const char         *severity = 0;

    // determine whether PTW exception should be reported, and with what
    // severity
    if(desc->warn) {
        severity = "W";
    } else if(RISCV_DEBUG_MMU(riscv)) {
        severity = "I";
    }

    // generate message for error if required
    if(!severity) {
        // no action
    } else if(PTEAddr!=-1) {
        vmiMessage(severity, CPU_PREFIX "_PTWE",
            NO_SRCREF_FMT "Page table entry %s "
            "[VA=0x"FMT_Ax" PTEAddress=0x"FMT_Ax" access=%c]",
            NO_SRCREF_ARGS(riscv),
            desc->desc,
            entry->lowVA,
            PTEAddr,
            getAccessChar(requiredPriv)
        );
    } else {
        vmiMessage(severity, CPU_PREFIX "_PTWE",
            NO_SRCREF_FMT "Page table entry %s "
            "[VA=0x"FMT_Ax" access=%c]",
            NO_SRCREF_ARGS(riscv),
            desc->desc,
            entry->lowVA,
            getAccessChar(requiredPriv)
        );
    }

    // return appropriate exception
    if(desc->exception==PTX_LOAD_ACCESS) {
        return originalAccessFault(riscv);
    } else if(desc->exception==PTX_STORE_ACCESS) {
        return originalAccessFault(riscv);
    } else if(riscv->origPriv==MEM_PRIV_W) {
        return storeAMOPageFault(riscv);
    } else if(riscv->hlvxActive || (riscv->origPriv==MEM_PRIV_R)) {
        return loadPageFault(riscv);
    } else {
        return instructionPageFault(riscv);
    }
}

//
// Macro encapsulating PTW error generation
//
#define PTE_ERROR(_CODE) return handlePTWException( \
    riscv, mode, entry, requiredPriv, PTEAddr, PTEE_##_CODE \
)


////////////////////////////////////////////////////////////////////////////////
// Sv32 PAGE TABLE WALK
////////////////////////////////////////////////////////////////////////////////

//
// This is the VPN page size in bits
//
#define SV32_VPN_SHIFT 10

//
// This is the VPN page mask
//
#define SV32_VPN_MASK ((1<<SV32_VPN_SHIFT)-1)

//
// Sv32 VA
//
typedef union Sv32VAU {
    Uns32 raw;
    struct {
        Uns32 pageOffset : 12;
        Uns32 VPN        : 20;
    } fields;
} Sv32VA;

//
// Sv32 PA
//
typedef union Sv32PAU {
    Uns64 raw;
    struct {
        Uns64 pageOffset : 12;
        Uns64 PPN        : 52;
    } fields;
} Sv32PA;

//
// Sv32 entry
//
typedef union Sv32EntryU {
    Uns32 raw;
    struct {
        Uns32 V    :  1;
        Uns32 priv :  3;
        Uns32 U    :  1;
        Uns32 G    :  1;
        Uns32 A    :  1;
        Uns32 D    :  1;
        Uns32 RSW  :  2;
        Uns32 PPN  : 22;
    } fields;
} Sv32Entry;

//
// Return Sv32 VPN[level]
//
static Uns32 getSv32VPNi(Sv32VA VA, Uns32 level) {
    return (VA.fields.VPN >> (level*SV32_VPN_SHIFT)) & SV32_VPN_MASK;
}

//
// Look up any TLB entry for the passed address using Sv32 mode and fill byref
// argument 'entry' with the details.
//
static riscvException tlbLookupSv32(
    riscvP         riscv,
    riscvMode      mode,
    tlbEntryP      entry,
    memPriv        requiredPriv,
    memAccessAttrs attrs
) {
    Sv32VA    VA = {raw : entry->lowVA};
    Sv32PA    PA;
    Sv32Entry PTE;
    Addr      PTEAddr;
    Addr      a;
    Int32     i;

    // clear page offset bits (not relevant for entry creation)
    VA.fields.pageOffset = 0;

    // do table walk to find ultimate PTE
    for(
        i=1, a=getRootTableAddress(riscv);
        i>=0;
        i--, a=getPTETableAddress(PTE.fields.PPN)
    ) {
        // get next page table entry address
        PTEAddr = a + getSv32VPNi(VA, i)*4;

        // read entry from memory
        PTE.raw = readPageTableEntry(riscv, mode, PTEAddr, 4, attrs);

        // return with page-fault exception if an invalid entry or entry with
        // permission combination that is reserved, or break from the loop if
        // a leaf entry is found
        if(riscv->PTWBadAddr) {
            PTE_ERROR(READ);
        } else if(!PTE.fields.V) {
            PTE_ERROR(V0);
        } else if((PTE.fields.priv&MEM_PRIV_RW) == MEM_PRIV_W) {
            PTE_ERROR(R0W1);
        } else if(PTE.fields.priv) {
            break;
        }
    }

    // return with page-fault exception if leaf entry was not found
    if(i<0) {
        PTE_ERROR(LEAF);
    }

    // construct entry low PA
    PA.fields.PPN        = PTE.fields.PPN;
    PA.fields.pageOffset = 0;

    // calculate entry size
    Uns32 size = 1 << ((i*SV32_VPN_SHIFT) + RISCV_PAGE_SHIFT);

    // return with page-fault exception if invalid page alignment
    if(PA.raw & (size-1)) {
        PTE_ERROR(ALIGN);
    }

    // fill TLB entry virtual address range
    entry->lowVA  = VA.raw & -size;
    entry->highVA = entry->lowVA + size - 1;

    // fill TLB entry low physical address
    entry->PA = PA.raw;

    // fill TLB entry attributes
    entry->tlb  = riscv->activeTLB;
    entry->priv = PTE.fields.priv;
    entry->V    = PTE.fields.V;
    entry->U    = PTE.fields.U;
    entry->G    = getG(riscv, PTE.fields.G);
    entry->A    = PTE.fields.A;
    entry->D    = PTE.fields.D;

    // return with page-fault exception if permissions are invalid
    if(!checkEntryPermission(riscv, mode, entry, requiredPriv)) {
        PTE_ERROR(PRIV);
    }

    // update entry A/D bits if required
    Bool doWrite = False;

    if(entry->A) {
        // A bit is already set
    } else if(!updatePTEA(riscv)) {
        // A bit not yet set, no hardware support
        PTE_ERROR(A0);
    } else {
        // A bit is set on any access
        entry->A = PTE.fields.A = 1;
        doWrite  = True;
    }

    // D bit is set on any write
    if(entry->D || !(requiredPriv & MEM_PRIV_W)) {
        // D bit is already set or not required
    } else if(!updatePTED(riscv)) {
        // D bit not yet set, no hardware support
        PTE_ERROR(D0);
    } else {
        entry->D = PTE.fields.D = 1;
        doWrite  = True;
    }

    // write PTE if it has changed
    if(doWrite) {

        writePageTableEntry(riscv, mode, PTEAddr, 4, attrs, PTE.raw);

        // error if entry is not writable
        if(riscv->PTWBadAddr) {
            PTE_ERROR(WRITE);
        }
    }

    // entry is valid
    return 0;
}


////////////////////////////////////////////////////////////////////////////////
// Sv32x4 PAGE TABLE WALK
////////////////////////////////////////////////////////////////////////////////

//
// This shift extracts the two extra bits for Sv32x4 mapping
//
#define SV32x4_SHIFT 32

//
// Look up any TLB entry for the passed address using Sv32x4 mode and fill byref
// argument 'entry' with the details.
//
static riscvException tlbLookupSv32x4(
    riscvP         riscv,
    riscvMode      mode,
    tlbEntryP      entry,
    memPriv        requiredPriv,
    memAccessAttrs attrs
) {
    Uns64 extraBits = entry->lowVA >> SV32x4_SHIFT;

    // record additional stage 2 page offset
    riscv->s2Offset = extraBits;

    // get ignored bits for Sv32 translation
    extraBits <<= SV32x4_SHIFT;

    // use Sv32 lookup logic
    riscvException exception = tlbLookupSv32(
        riscv, mode, entry, requiredPriv, attrs
    );

    // include additional Sv32x4 offset if lookup succeeded
    if(!exception) {
        entry->lowVA  += extraBits;
        entry->highVA += extraBits;
    }

    return exception;
}


////////////////////////////////////////////////////////////////////////////////
// Sv39 PAGE TABLE WALK
////////////////////////////////////////////////////////////////////////////////

//
// This is the VPN page size in bits
//
#define SV39_VPN_SHIFT 9

//
// This is the VPN page mask
//
#define SV39_VPN_MASK ((1<<SV39_VPN_SHIFT)-1)

//
// Sv39 VA
//
typedef union Sv39VAU {
    Uns64 raw;
    struct {
        Uns32 pageOffset : 12;
        Int64 VPN        : 27;
        Int32 VPNextend  : 25;
    } fields;
} Sv39VA;

//
// Sv39 PA
//
typedef union Sv39PAU {
    Uns64 raw;
    struct {
        Uns64 pageOffset : 12;
        Uns64 PPN        : 52;
    } fields;
} Sv39PA;

//
// Sv39 entry
//
typedef union Sv39EntryU {
    Uns64 raw;
    struct {
        Uns32 V    :  1;
        Uns32 priv :  3;
        Uns32 U    :  1;
        Uns32 G    :  1;
        Uns32 A    :  1;
        Uns32 D    :  1;
        Uns32 RSW  :  2;
        Uns64 PPN  : 44;
        Uns32 _u1  : 10;
    } fields;
} Sv39Entry;

//
// Return Sv39 VPN[level]
//
static Uns32 getSv39VPNi(Sv39VA VA, Uns32 level) {
    return (VA.fields.VPN >> (level*SV39_VPN_SHIFT)) & SV39_VPN_MASK;
}

//
// Look up any TLB entry for the passed address using Sv39 mode and fill byref
// argument 'entry' with the details.
//
static riscvException tlbLookupSv39(
    riscvP         riscv,
    riscvMode      mode,
    tlbEntryP      entry,
    memPriv        requiredPriv,
    memAccessAttrs attrs
) {
    Sv39VA    VA      = {raw : entry->lowVA};
    Addr      PTEAddr = 0;
    Sv39PA    PA;
    Sv39Entry PTE;
    Addr      a;
    Int32     i;

    // validate VPNextend correctly extends VPN
    if(!validVA(VA.fields.VPN, VA.fields.VPNextend)) {
        PTE_ERROR(VAEXTEND);
    }

    // clear page offset bits (not relevant for entry creation)
    VA.fields.pageOffset = 0;

    // do table walk to find ultimate PTE
    for(
        i=2, a=getRootTableAddress(riscv);
        i>=0;
        i--, a=getPTETableAddress(PTE.fields.PPN)
    ) {
        // get next page table entry address
        PTEAddr = a + getSv39VPNi(VA, i)*8;

        // read entry from memory
        PTE.raw = readPageTableEntry(riscv, mode, PTEAddr, 8, attrs);

        // return with page-fault exception if an invalid entry or entry with
        // permission combination that is reserved, or break from the loop if
        // a leaf entry is found
        if(riscv->PTWBadAddr) {
            PTE_ERROR(READ);
        } else if(!PTE.fields.V) {
            PTE_ERROR(V0);
        } else if((PTE.fields.priv&MEM_PRIV_RW) == MEM_PRIV_W) {
            PTE_ERROR(R0W1);
        } else if(PTE.fields.priv) {
            break;
        }
    }

    // return with page-fault exception if leaf entry was not found
    if(i<0) {
        PTE_ERROR(LEAF);
    }

    // construct entry low PA
    PA.fields.PPN        = PTE.fields.PPN;
    PA.fields.pageOffset = 0;

    // calculate entry size
    Uns64 size = 1ULL << ((i*SV39_VPN_SHIFT) + RISCV_PAGE_SHIFT);

    // return with page-fault exception if invalid page alignment
    if(PA.raw & (size-1)) {
        PTE_ERROR(ALIGN);
    }

    // fill TLB entry virtual address range
    entry->lowVA  = VA.raw & -size;
    entry->highVA = entry->lowVA + size - 1;

    // fill TLB entry low physical address
    entry->PA = PA.raw;

    // fill TLB entry attributes
    entry->tlb  = riscv->activeTLB;
    entry->priv = PTE.fields.priv;
    entry->V    = PTE.fields.V;
    entry->U    = PTE.fields.U;
    entry->G    = getG(riscv, PTE.fields.G);
    entry->A    = PTE.fields.A;
    entry->D    = PTE.fields.D;

    // return with page-fault exception if permissions are invalid
    if(!checkEntryPermission(riscv, mode, entry, requiredPriv)) {
        PTE_ERROR(PRIV);
    }

    // update entry A/D bits if required
    Bool doWrite = False;

    if(entry->A) {
        // A bit is already set
    } else if(!updatePTEA(riscv)) {
        // A bit not yet set, no hardware support
        PTE_ERROR(A0);
    } else {
        // A bit is set on any access
        entry->A = PTE.fields.A = 1;
        doWrite  = True;
    }

    // D bit is set on any write
    if(entry->D || !(requiredPriv & MEM_PRIV_W)) {
        // D bit is already set or not required
    } else if(!updatePTED(riscv)) {
        // D bit not yet set, no hardware support
        PTE_ERROR(D0);
    } else {
        entry->D = PTE.fields.D = 1;
        doWrite  = True;
    }

    // write PTE if it has changed
    if(doWrite) {

        writePageTableEntry(riscv, mode, PTEAddr, 8, attrs, PTE.raw);

        // error if entry is not writable
        if(riscv->PTWBadAddr) {
            PTE_ERROR(WRITE);
        }
    }

    // entry is valid
    return 0;
}


////////////////////////////////////////////////////////////////////////////////
// Sv39x4 PAGE TABLE WALK
////////////////////////////////////////////////////////////////////////////////

//
// This shift extracts the two extra bits for Sv39x4 mapping
//
#define SV39x4_SHIFT 39

//
// Look up any TLB entry for the passed address using Sv39x4 mode and fill byref
// argument 'entry' with the details.
//
static riscvException tlbLookupSv39x4(
    riscvP         riscv,
    riscvMode      mode,
    tlbEntryP      entry,
    memPriv        requiredPriv,
    memAccessAttrs attrs
) {
    Uns64 extraBits = entry->lowVA >> SV39x4_SHIFT;
    Uns32 shiftUp   = 64-SV39x4_SHIFT;

    // validate VPNextend correctly extends VPN
    if(extraBits>3) {
        Addr PTEAddr = 0;
        PTE_ERROR(VAEXTEND);
    }

    // record additional stage 2 page offset
    riscv->s2Offset = extraBits;

    // get ignored bits for Sv48 translation
    extraBits <<= SV39x4_SHIFT;

    // remove ignored bits from Sv39 virtual address by sign-extending remainder
    Int64 extendVA = entry->lowVA << shiftUp;
    entry->lowVA = extendVA >> shiftUp;

    // use Sv39 lookup logic
    riscvException exception = tlbLookupSv39(
        riscv, mode, entry, requiredPriv, attrs
    );

    // include additional Sv39x4 offset if lookup succeeded
    if(!exception) {
        entry->lowVA  = ((entry->lowVA<<shiftUp)>>shiftUp) + extraBits;
        entry->highVA = ((entry->highVA<<shiftUp)>>shiftUp) + extraBits;
    }

    return exception;
}


////////////////////////////////////////////////////////////////////////////////
// Sv48 PAGE TABLE WALK
////////////////////////////////////////////////////////////////////////////////

//
// This is the VPN page size in bits
//
#define SV48_VPN_SHIFT 9

//
// This is the VPN page mask
//
#define SV48_VPN_MASK ((1<<SV48_VPN_SHIFT)-1)

//
// Sv48 VA
//
typedef union Sv48VAU {
    Uns64 raw;
    struct {
        Uns32 pageOffset : 12;
        Int64 VPN        : 36;
        Int32 VPNextend  : 16;
    } fields;
} Sv48VA;

//
// Sv48 PA
//
typedef union Sv48PAU {
    Uns64 raw;
    struct {
        Uns64 pageOffset : 12;
        Uns64 PPN        : 52;
    } fields;
} Sv48PA;

//
// Sv48 entry
//
typedef union Sv48EntryU {
    Uns64 raw;
    struct {
        Uns32 V    :  1;
        Uns32 priv :  3;
        Uns32 U    :  1;
        Uns32 G    :  1;
        Uns32 A    :  1;
        Uns32 D    :  1;
        Uns32 RSW  :  2;
        Uns64 PPN  : 44;
        Uns32 _u1  : 10;
    } fields;
} Sv48Entry;

//
// Return Sv48 VPN[level]
//
static Uns32 getSv48VPNi(Sv48VA VA, Uns32 level) {
    return (VA.fields.VPN >> (level*SV48_VPN_SHIFT)) & SV48_VPN_MASK;
}

//
// Look up any TLB entry for the passed address using Sv48 mode and fill byref
// argument 'entry' with the details.
//
static riscvException tlbLookupSv48(
    riscvP         riscv,
    riscvMode      mode,
    tlbEntryP      entry,
    memPriv        requiredPriv,
    memAccessAttrs attrs
) {
    Sv48VA    VA      = {raw : entry->lowVA};
    Addr      PTEAddr = 0;
    Sv48PA    PA;
    Sv48Entry PTE;
    Addr      a;
    Int32     i;

    // validate VPNextend correctly extends VPN
    if(!validVA(VA.fields.VPN, VA.fields.VPNextend)) {
        PTE_ERROR(VAEXTEND);
    }

    // clear page offset bits (not relevant for entry creation)
    VA.fields.pageOffset = 0;

    // do table walk to find ultimate PTE
    for(
        i=3, a=getRootTableAddress(riscv);
        i>=0;
        i--, a=getPTETableAddress(PTE.fields.PPN)
    ) {
        // get next page table entry address
        PTEAddr = a + getSv48VPNi(VA, i)*8;

        // read entry from memory
        PTE.raw = readPageTableEntry(riscv, mode, PTEAddr, 8, attrs);

        // return with page-fault exception if an invalid entry or entry with
        // permission combination that is reserved, or break from the loop if
        // a leaf entry is found
        if(riscv->PTWBadAddr) {
            PTE_ERROR(READ);
        } else if(!PTE.fields.V) {
            PTE_ERROR(V0);
        } else if((PTE.fields.priv&MEM_PRIV_RW) == MEM_PRIV_W) {
            PTE_ERROR(R0W1);
        } else if(PTE.fields.priv) {
            break;
        }
    }

    // return with page-fault exception if leaf entry was not found
    if(i<0) {
        PTE_ERROR(LEAF);
    }

    // construct entry low PA
    PA.fields.PPN        = PTE.fields.PPN;
    PA.fields.pageOffset = 0;

    // calculate entry size
    Uns64 size = 1ULL << ((i*SV48_VPN_SHIFT) + RISCV_PAGE_SHIFT);

    // return with page-fault exception if invalid page alignment
    if(PA.raw & (size-1)) {
        PTE_ERROR(ALIGN);
    }

    // fill TLB entry virtual address range
    entry->lowVA  = VA.raw & -size;
    entry->highVA = entry->lowVA + size - 1;

    // fill TLB entry low physical address
    entry->PA = PA.raw;

    // fill TLB entry attributes
    entry->tlb  = riscv->activeTLB;
    entry->priv = PTE.fields.priv;
    entry->V    = PTE.fields.V;
    entry->U    = PTE.fields.U;
    entry->G    = getG(riscv, PTE.fields.G);
    entry->A    = PTE.fields.A;
    entry->D    = PTE.fields.D;

    // return with page-fault exception if permissions are invalid
    if(!checkEntryPermission(riscv, mode, entry, requiredPriv)) {
        PTE_ERROR(PRIV);
    }

    // update entry A/D bits if required
    Bool doWrite = False;

    if(entry->A) {
        // A bit is already set
    } else if(!updatePTEA(riscv)) {
        // A bit not yet set, no hardware support
        PTE_ERROR(A0);
    } else {
        // A bit is set on any access
        entry->A = PTE.fields.A = 1;
        doWrite  = True;
    }

    // D bit is set on any write
    if(entry->D || !(requiredPriv & MEM_PRIV_W)) {
        // D bit is already set or not required
    } else if(!updatePTED(riscv)) {
        // D bit not yet set, no hardware support
        PTE_ERROR(D0);
    } else {
        entry->D = PTE.fields.D = 1;
        doWrite  = True;
    }

    // write PTE if it has changed
    if(doWrite) {

        writePageTableEntry(riscv, mode, PTEAddr, 8, attrs, PTE.raw);

        // error if entry is not writable
        if(riscv->PTWBadAddr) {
            PTE_ERROR(WRITE);
        }
    }

    // entry is valid
    return 0;
}


////////////////////////////////////////////////////////////////////////////////
// Sv48x4 PAGE TABLE WALK
////////////////////////////////////////////////////////////////////////////////

//
// This shift extracts the two extra bits for Sv48x4 mapping
//
#define SV48x4_SHIFT 48

//
// Look up any TLB entry for the passed address using Sv48x4 mode and fill byref
// argument 'entry' with the details.
//
static riscvException tlbLookupSv48x4(
    riscvP         riscv,
    riscvMode      mode,
    tlbEntryP      entry,
    memPriv        requiredPriv,
    memAccessAttrs attrs
) {
    Uns64 extraBits = entry->lowVA >> SV48x4_SHIFT;
    Uns32 shiftUp   = 64-SV48x4_SHIFT;

    // validate VPNextend correctly extends VPN
    if(extraBits>3) {
        Addr PTEAddr = 0;
        PTE_ERROR(VAEXTEND);
    }

    // record additional stage 2 page offset
    riscv->s2Offset = extraBits;

    // get ignored bits for Sv48 translation
    extraBits <<= SV48x4_SHIFT;

    // remove ignored bits from Sv48 virtual address by sign-extending remainder
    Int64 extendVA = entry->lowVA << shiftUp;
    entry->lowVA = extendVA >> shiftUp;

    // use Sv48 lookup logic
    riscvException exception = tlbLookupSv48(
        riscv, mode, entry, requiredPriv, attrs
    );

    // include additional Sv48x4 offset if lookup succeeded
    if(!exception) {
        entry->lowVA  = ((entry->lowVA<<shiftUp)>>shiftUp) + extraBits;
        entry->highVA = ((entry->highVA<<shiftUp)>>shiftUp) + extraBits;
    }

    return exception;
}


////////////////////////////////////////////////////////////////////////////////
// HLVX SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// If the given code domain is the VS or VU code domain, return the equivalent
// HLVX domain
//
static memDomainP getHLVXDomain(riscvP riscv, memDomainP codeDomain) {

    memDomainP result = 0;

    if(!codeDomain) {
        // no action
    } else if(codeDomain==riscv->vmDomains[RISCV_VMMODE_VU][True]) {
        result = riscv->hlvxDomains[0];
    } else if(codeDomain==riscv->vmDomains[RISCV_VMMODE_VS][True]) {
        result = riscv->hlvxDomains[1];
    }

    return result;
}

//
// If the given domain is an HLVX domain, update the access characteristics
// to indicate an execute access in the equivalent virtual domain
//
static Bool startHLVX(riscvP riscv, memDomainPP domainP, memPriv *privP) {

    memDomainP domain = *domainP;
    memDomainP result = 0;

    // get true virtual domain for HLVX domain
    if(domain==riscv->hlvxDomains[0]) {
        result = riscv->vmDomains[RISCV_VMMODE_VU][True];
    } else if(domain==riscv->hlvxDomains[1]) {
        result = riscv->vmDomains[RISCV_VMMODE_VS][True];
    }

    // update access domain and privilege
    if(result) {
        *domainP = result;
        *privP   = MEM_PRIV_X;
    }

    // indicate whether HLVX domain was found
    return result;
}


////////////////////////////////////////////////////////////////////////////////
// GENERAL TLB MANAGEMENT
////////////////////////////////////////////////////////////////////////////////

//
// Forward reference
//
static void deleteTLBEntry(riscvP riscv, riscvTLBP tlb, tlbEntryP entry);

//
// Return mask for current base mode
//
inline static Uns32 getModeMask(riscvMode mode) {
    return 1<<getBaseMode(mode);
}

//
// Mask given VMID to implemented VMID bits
//
static Uns32 maskVMID(riscvP riscv, Uns32 VMID) {

    CSR_REG_DECL(hgatp);

    // mask VMID to current XLEN width
    if(riscvGetXlenArch(riscv)==32) {
        hgatp.u32.fields.VMID = VMID;
        VMID = hgatp.u32.fields.VMID;
    } else {
        hgatp.u64.fields.VMID = VMID;
        VMID = hgatp.u64.fields.VMID;
    }

    // mask VMID to implemented width (may be bigger or smaller than current
    // width above)
    return VMID & getVMIDMask(riscv);
}

//
// Mask given ASID to implemented ASID bits
//
static Uns32 maskASID(riscvP riscv, Uns32 ASID) {

    CSR_REG_DECL(satp);

    // mask ASID to current XLEN width
    if(riscvGetXlenArch(riscv)==32) {
        satp.u32.fields.ASID = ASID;
        ASID = satp.u32.fields.ASID;
    } else {
        satp.u64.fields.ASID = ASID;
        ASID = satp.u64.fields.ASID;
    }

    // mask ASID to implemented width (may be bigger or smaller than current
    // width above)
    return ASID & getASIDMask(riscv);
}

//
// Return TLB entry for vmiRangeEntryP object (note that any entries created by
// artifact accesses are deleted and ignored, so that these do not perturb
// simulation state)
//
static tlbEntryP getTLBEntryForRange(
    riscvP         riscv,
    riscvTLBP      tlb,
    Uns64          lowVA,
    Uns64          highVA,
    vmiRangeEntryP lutEntry
) {
    while(lutEntry) {

        union {Uns64 u64; tlbEntryP entry;} u = {
            vmirtGetRangeEntryUserData(lutEntry)
        };

        if(!u.entry->artifact) {
            return u.entry;
        }

        deleteTLBEntry(riscv, tlb, u.entry);

        lutEntry = vmirtGetNextRangeEntry(&tlb->lut, lowVA, highVA);
    }

    return 0;
}

//
// Return the first TLB entry overlapping the passed range, ignoring ASID
//
static tlbEntryP firstTLBEntryRange(
    riscvP    riscv,
    riscvTLBP tlb,
    Uns64     lowVA,
    Uns64     highVA
) {
    vmiRangeEntryP lutEntry = vmirtGetFirstRangeEntry(&tlb->lut, lowVA, highVA);

    return getTLBEntryForRange(riscv, tlb, lowVA, highVA, lutEntry);
}

//
// Return the next TLB entry overlapping the passed range, ignoring ASID
//
static tlbEntryP nextTLBEntryRange(
    riscvP    riscv,
    riscvTLBP tlb,
    Uns64     lowVA,
    Uns64     highVA
) {
    vmiRangeEntryP lutEntry = vmirtGetNextRangeEntry(&tlb->lut, lowVA, highVA);

    return getTLBEntryForRange(riscv, tlb, lowVA, highVA, lutEntry);
}

//
// Remove memory mappings for a TLB entry in the given mode
//
static void deleteTLBEntryMappingsMode(
    riscvP    riscv,
    tlbEntryP entry,
    riscvMode mode
) {
    Uns32 modeMask = getModeMask(mode);

    // action is only needed if the TLB entry is mapped in this mode
    if(entry->mapped & modeMask) {

        memDomainP dataDomain = getVirtDomainCorD(riscv, mode, False);
        memDomainP codeDomain = getVirtDomainCorD(riscv, mode, True);
        memDomainP hlvxDomain = getHLVXDomain(riscv, codeDomain);
        Uns64      lowVA      = getEntryLowVA(entry);
        Uns64      highVA     = getEntryHighVA(entry);
        Uns64      fullASID   = getEntrySimASID(entry);
        Uns64      ASIDMask   = getEntryASIDMask(entry, mode);

        if(dataDomain) {
            vmirtUnaliasMemoryVM(dataDomain, lowVA, highVA, ASIDMask, fullASID);
        }

        if(codeDomain && (codeDomain!=dataDomain)) {
            vmirtUnaliasMemoryVM(codeDomain, lowVA, highVA, ASIDMask, fullASID);
        }

        if(hlvxDomain) {
            vmirtUnaliasMemoryVM(hlvxDomain, lowVA, highVA, ASIDMask, fullASID);
        }

        // indicate entry is no longer mapped in this mode
        entry->mapped &= ~modeMask;
    }
}

//
// Remove memory mappings for a TLB entry in the given mode if the simulated
// ASID does not match
//
static void deleteTLBEntryMappingsModeASID(
    riscvP       riscv,
    tlbEntryP    entry,
    riscvMode    mode,
    riscvSimASID newASID
) {
    Uns64 ASIDMask   = getEntryASIDMask(entry, mode);
    Uns64 oldASIDU64 = ASIDMask & getEntrySimASID(entry);
    Uns64 newASIDU64 = ASIDMask & newASID.u64;

    // action is only needed if effective ASID in the given mode changes
    if(oldASIDU64 != newASIDU64) {
        deleteTLBEntryMappingsMode(riscv, entry, mode);
    }
}

//
// Unmap a TLB entry
//
static void unmapTLBEntry(riscvP riscv, tlbEntryP entry) {

    switch(entry->tlb) {

        case RISCV_TLB_HS:
            deleteTLBEntryMappingsMode(riscv, entry, RISCV_MODE_U);
            deleteTLBEntryMappingsMode(riscv, entry, RISCV_MODE_S);
            break;

        case RISCV_TLB_VS1:
        case RISCV_TLB_VS2:
            deleteTLBEntryMappingsMode(riscv, entry, RISCV_MODE_VU);
            deleteTLBEntryMappingsMode(riscv, entry, RISCV_MODE_VS);
            break;

        default:
            VMI_ABORT("Invalid tlb %u", entry->tlb); // LCOV_EXCL_LINE
            break;
    }
}

//
// Unmap a TLB entry when the simulated ASID changes in domains affected by
// that change
//
static void unmapTLBEntryNewASID(
    riscvP       riscv,
    tlbEntryP    entry,
    riscvSimASID newASID
) {
    switch(entry->tlb) {

        case RISCV_TLB_HS:
            deleteTLBEntryMappingsModeASID(riscv, entry, RISCV_MODE_U, newASID);
            deleteTLBEntryMappingsModeASID(riscv, entry, RISCV_MODE_S, newASID);
            break;

        case RISCV_TLB_VS1:
        case RISCV_TLB_VS2:
            deleteTLBEntryMappingsModeASID(riscv, entry, RISCV_MODE_VU, newASID);
            deleteTLBEntryMappingsModeASID(riscv, entry, RISCV_MODE_VS, newASID);
            break;

        default:
            VMI_ABORT("Invalid tlb %u", entry->tlb); // LCOV_EXCL_LINE
            break;
    }

}

//
// Unmap stage 1 TLB entry that uses stage 2, optionally matching VMID or
// GPA address range
//
static void unmapS1EntryForS2Entry(
    riscvP    riscv,
    tlbEntryP entryS1,
    tlbEntryP entryS2
) {
    // action is only required for entries that use stage 2
    if(entryS1->simASID.f.S2) {

        Uns64 lowGPA  = getEntryLowVA(entryS2);
        Uns64 highGPA = getEntryHighVA(entryS2);
        Uns64 lowPA   = getEntryLowPA(entryS1);
        Uns64 highPA  = getEntryHighPA(entryS1);

        if((highGPA<lowPA) || (highPA<lowGPA)) {
            // no action if GPA is not in PA range for this entry
        } else if(getEntryVMID(entryS1)!=getEntryVMID(entryS2)) {
            // no action if VMID does not match
        } else {
            unmapTLBEntry(riscv, entryS1);
        }
    }
}

//
// Unmap stage 1 TLB entries that use the given stage 2 entry
//
static void unmapS1EntriesForS2Entry(riscvP riscv, tlbEntryP entryS2) {

    riscvTLBP tlb = riscv->tlb[RISCV_TLB_VS1];

    // tlb may be null during deletion
    if(tlb) {
        ITER_TLB_ENTRY_RANGE(
            riscv, tlb, 0, RISCV_MAX_ADDR, entryS1,
            unmapS1EntryForS2Entry(riscv, entryS1, entryS2)
        );
    }
}

//
// Return privilege name for the given privilege
//
static const char *privName(Uns32 priv) {

    static const char *map[] = {
        "---", "r--", "-w-", "rw-", "--x", "r-x", "-wx", "rwx"
    };

    // sanity check given privilege
    VMI_ASSERT(priv<8, "unexpected privilege %u", priv);

    return map[priv];
}

//
// Dump contents of the TLB entry
//
static void dumpTLBEntry(riscvP riscv, tlbEntryP entry) {

    // get entry bounds
    Uns64 entryLowVA     = getEntryLowVA(entry);
    Uns64 entryHighVA    = getEntryHighVA(entry);
    Uns64 entryLowPA     = getEntryLowPA(entry);
    Uns64 entryHighPA    = getEntryHighPA(entry);
    char  vmidString[32] = {0};
    char  asidString[32] = {0};

    // construct VMID string for virtual machine entries
    if(entryHasVMID(entry)) {
        sprintf(vmidString, " VMID=%u", getEntryVMID(entry));
    }

    // construct ASID string for non-global entries
    if(!entry->G) {
        sprintf(asidString, " ASID=%u", getEntryASID(entry));
    }

    vmiPrintf(
        "VA 0x"FMT_6408x":0x"FMT_6408x" PA 0x"FMT_6408x":0x"FMT_6408x
        " %s U=%u G=%u A=%u D=%u%s%s\n",
        entryLowVA, entryHighVA, entryLowPA, entryHighPA,
        privName(entry->priv), entry->U, entry->G, entry->A, entry->D,
        vmidString, asidString
    );
}

//
// Report TLB entry deletion
//
static void reportDeleteTLBEntry(riscvP riscv, tlbEntryP entry) {
    if(!entry->artifact && RISCV_DEBUG_MMU(riscv)) {
        vmiPrintf("DELETE %s ENTRY:\n", getTLBName(riscv, entry->tlb));
        dumpTLBEntry(riscv, entry);
    }
}

//
// Delete a TLB entry
//
static void deleteTLBEntry(riscvP riscv, riscvTLBP tlb, tlbEntryP entry) {

    // remove entry mappings if required
    unmapTLBEntry(riscv, entry);

    // if a stage 2 entry, remove mappings for any stage 1 entry using it
    if(entry->tlb==RISCV_TLB_VS2) {
        unmapS1EntriesForS2Entry(riscv, entry);
    }

    // emit debug if required
    reportDeleteTLBEntry(riscv, entry);

    // notify dependent model of custom entry deletion
    if(entry->custom) {
        ITER_EXT_CB(
            riscv, extCB, freeEntryNotifier,
            extCB->freeEntryNotifier(
                riscv, entry->tlb, entry->entryId, extCB->clientData
            );
        )
    }

    // remove the TLB entry from the range LUT
    vmirtRemoveRangeEntry(&tlb->lut, entry->lutEntry);
    entry->lutEntry = 0;

    // add the TLB entry to the free list
    entry->nextFree = tlb->free;
    tlb->free       = entry;
}

//
// Allocate a new TLB entry
//
static tlbEntryP newTLBEntry(riscvTLBP tlb) {

    tlbEntryP entry;

    if((entry=tlb->free)) {
        tlb->free = entry->nextFree;
    } else {
        entry = STYPE_ALLOC(tlbEntry);
    }

    return entry;
}

//
// Allocate ASID cache for the given TLB
//
static riscvASIDCacheP newASIDCache(Uns32 cacheSize) {

    riscvASIDCacheP result = 0;

    if(cacheSize) {
        result = STYPE_CALLOC_N(riscvASIDCache, cacheSize);
    }

    return result;
}

//
// Free ASID cache for the given TLB
//
static void freeASIDCache(riscvTLBP tlb) {
    if(tlb->ASIDCache) {
        STYPE_FREE(tlb->ASIDCache);
    }
}

//
// Return the index of the given ASID entry in the ASID cache (or cacheSize if
// absent)
//
static Uns32 getASIDCacheIndex(
    riscvASIDCacheP list,
    Uns32           cacheSize,
    riscvASIDCache  new
) {
    Uns32 i;

    for(i=0; i<cacheSize; i++) {

        riscvASIDCacheP try = &list[i];

        if(try->valid && (try->ASID==new.ASID) && (try->VMID==new.VMID)) {
            break;
        }
    }

    return i;
}

//
// Insert entry new in the MRU position of the given ASID cache
//
static riscvASIDCache insertMRU(
    riscvASIDCacheP list,
    Uns32           cacheSize,
    riscvASIDCache  new
) {
    riscvASIDCache eject = {valid:False};
    Uns32          i     = getASIDCacheIndex(list, cacheSize, new);

    // action is only required if not already in the MRU slot
    if(i) {

        // if no match in any slot: get LRU ASID to eject
        if(i==cacheSize) {
            eject = list[--i];
        }

        // demote older entries
        do {
            list[i] = list[i-1];
            i--;
        } while(i>0);

        // set MRU entry
        list[0] = new;
    }

    // return identifier of any entries to eject
    return eject;
}

//
// Promote the entry ASID to the MRU slot if required
//
static void monitorASIDCacheEjectRate(riscvP riscv, riscvTLBP tlb) {

    vmiProcessorP processor = (vmiProcessorP)riscv;
    Uns64         iCount    = vmirtGetExecutedICount(processor);
    Uns64         iDelta    = iCount - tlb->ASIDICount;

    // enable monitoring when sufficient instructions have elapsed
    if(iDelta>=10000000) {

        Uns64 rate      = iDelta/tlb->ASIDEjectNum;
        Uns32 cacheSize = tlb->ASIDCacheSize;

        // assume more than 1 ejection in 100,000 instructions indicates cache
        // is too small
        if((rate<100000) && (cacheSize<256)) {

            // allocate larger cache
            riscvASIDCacheP newCache = newASIDCache(cacheSize*2);
            Uns32           i;

            // copy current cache contents
            for(i=0; i<cacheSize; i++) {
                newCache[i] = tlb->ASIDCache[i];
            }

            // free old cache
            freeASIDCache(tlb);

            // update cache details
            tlb->ASIDCacheSize = cacheSize*2;
            tlb->ASIDCache     = newCache;

            // reset accounting
            tlb->ASIDICount   = iCount;
            tlb->ASIDEjectNum = 0;
        }
    }
}

//
// Promote the entry ASID to the MRU slot if required
//
static void promoteASIDMRU(riscvP riscv, riscvTLBP tlb, tlbEntryP entry) {

    if(tlb->ASIDCache && !entry->artifact && !entry->custom) {

        // declare ASID cache entry
        riscvASIDCache new = {
            VMID  : getEntryVMID(entry),
            ASID  : getEntryASID(entry),
            valid : True
        };

        // insert into ASID cache
        riscvASIDCache eject = insertMRU(tlb->ASIDCache, tlb->ASIDCacheSize, new);

        // if entry was ejected, remove its mappings
        if(eject.valid) {

            // periodically monitor ejection rate and increase cache size
            if(!(++tlb->ASIDEjectNum & 0x3ff)) {
                monitorASIDCacheEjectRate(riscv, tlb);
            }

            ITER_TLB_ENTRY_RANGE(
                riscv, tlb, 0, RISCV_MAX_ADDR, entry,
                if(
                    (eject.ASID==getEntryASID(entry)) &&
                    (eject.VMID==getEntryVMID(entry))
                ) {
                    deleteTLBEntry(riscv, tlb, entry);
                }
            );
        }
    }
}

//
// Insert the TLB entry into the processor range table
//
static void insertTLBEntry(riscvP riscv, riscvTLBP tlb, tlbEntryP entry) {

    // promote the entry ASID to the MRU slot if required
    promoteASIDMRU(riscv, tlb, entry);

    entry->lutEntry = vmirtInsertRangeEntry(
        &tlb->lut, entry->lowVA, entry->highVA, (UnsPS)entry
    );
}

//
// Allocate a new TLB entry, filling it from the base object
//
static tlbEntryP allocateTLBEntry(
    riscvP         riscv,
    riscvTLBP      tlb,
    tlbEntryP      base,
    memAccessAttrs attrs
) {
    // get new entry structure
    tlbEntryP entry = newTLBEntry(tlb);

    // artifact accesses must be marked as such
    base->artifact = riscv->artifactAccess;

    // fill entry from base object
    *entry = *base;

    // set simulated ASID (for MRU entry management)
    entry->simASID = getSimASID(riscv);

    // insert it into the processor TLB table
    insertTLBEntry(riscv, tlb, entry);

    // emit debug if required
    if(!entry->artifact && RISCV_DEBUG_MMU(riscv)) {
        vmiPrintf("CREATE %s ENTRY:\n", getTLBName(riscv, getTLBId(riscv, tlb)));
        dumpTLBEntry(riscv, entry);
    }

    // return the new entry
    return entry;
}

//
// Delete all entries in the given TLB
//
static void invalidateTLB(riscvP riscv, riscvTLBId id) {

    riscvTLBP tlb = riscv->tlb[id];

    if(tlb) {
        ITER_TLB_ENTRY_RANGE(
            riscv, tlb, 0, RISCV_MAX_ADDR, entry,
            deleteTLBEntry(riscv, tlb, entry)
        );
    }
}

//
// Delete TLB entry if its simulated ASID masked using the given mask matches
// the given result
//
static void deleteTLBEntryMask(
    riscvP       riscv,
    riscvTLBP    tlb,
    tlbEntryP    entry,
    riscvSimASID mask,
    riscvSimASID match
) {
    // global entries do not require an ASID match
    if(entry->G) {
        mask.f.ASID_HS = 0;
        mask.f.ASID_VS = 0;
    }

    // delete if masked values match
    if((match.u64&mask.u64)==(entry->simASID.u64&mask.u64)) {
        deleteTLBEntry(riscv, tlb, entry);
    }
}

//
// Delete TLB entries in the passed range if entry simulated ASID masked using
// the given mask matches the given VMID and ASID
//
static void deleteTLBEntriesMask(
    riscvP       riscv,
    riscvTLBId   id,
    Uns64        lowVA,
    Uns64        highVA,
    riscvSimASID mask,
    Uns32        VMID,
    Uns32        ASID
) {
    riscvTLBP    tlb   = riscv->tlb[id];
    riscvSimASID match = {{0}};

    // mask VMID and ASID to valid values
    VMID = maskVMID(riscv, VMID);
    ASID = maskASID(riscv, ASID);

    if(id==RISCV_TLB_HS) {

        // match ASID_HS, ignore VMID and ASID_VS
        mask. f.VMID    = 0;
        match.f.ASID_HS = ASID;
        mask. f.ASID_VS = 0;

    } else if(id==RISCV_TLB_VS1) {

        // match VMID and ASID_VS, ignore ASID_HS
        match.f.VMID    = VMID;
        mask .f.ASID_HS = 0;
        match.f.ASID_VS = ASID;

    } else if(id==RISCV_TLB_VS2) {

        // match VMID, ignore ASID_HS and ASID_VS
        match.f.VMID    = VMID;
        mask .f.ASID_HS = 0;
        mask .f.ASID_VS = 0;
    }

    ITER_TLB_ENTRY_RANGE(
        riscv, tlb, lowVA, highVA, entry,
        deleteTLBEntryMask(riscv, tlb, entry, mask, match)
    );
}

//
// Delete TLB entries in the passed range if entry simulated ASID masked using
// the given mask matches the active VMID and given ASID
//
static void deleteTLBEntriesMaskActiveVMID(
    riscvP       riscv,
    riscvTLBId   id,
    Uns64        lowVA,
    Uns64        highVA,
    riscvSimASID mask,
    Uns32        ASID
) {
    Uns32 VMID = RD_CSR_FIELD_S(riscv, hgatp, VMID);

    mask.f.VMID = -1;

    deleteTLBEntriesMask(riscv, id, lowVA, highVA, mask, VMID, ASID);
}

//
// Allocate TLB structure
//
static riscvTLBP newTLB(riscvP riscv) {

    riscvTLBP tlb       = STYPE_CALLOC(riscvTLB);
    Uns32     cacheSize = riscv->configInfo.ASID_cache_size;

    // allocate ASID cache if required
    tlb->ASIDCacheSize = cacheSize;
    tlb->ASIDCache     = newASIDCache(cacheSize);

    // allocate range table for fast TLB entry search
    vmirtNewRangeTable(&tlb->lut);

    return tlb;
}

//
// Free TLB structure
//
static void freeTLB(riscvP riscv, riscvTLBId id) {

    riscvTLBP tlb = riscv->tlb[id];

    if(tlb) {

        tlbEntryP entry;

        // delete all entries in the TLB (puts them in the free list)
        invalidateTLB(riscv, id);

        // release entries in the free list
        while((entry=tlb->free)) {
            tlb->free = entry->nextFree;
            STYPE_FREE(entry);
        }

        // free ASID cache if required
        freeASIDCache(tlb);

        // free the range table
        vmirtFreeRangeTable(&tlb->lut);

        // free the TLB structure
        STYPE_FREE(tlb);

        // clear TLB pointer
        riscv->tlb[id] = 0;
    }
}

//
// Dump contents of the TLB
//
static void dumpTLB(riscvP riscv, riscvTLBP tlb) {

    if(tlb) {

        vmiPrintf("%s CONTENTS:\n", getTLBName(riscv, getTLBId(riscv, tlb)));

        ITER_TLB_ENTRY_RANGE(
            riscv, tlb, 0, RISCV_MAX_ADDR, entry,
            dumpTLBEntry(riscv, entry)
        );
    }
}

//
// Fill domain name for mode and type
//
static void getDomainName(
    char       *result,
    riscvMode   mode,
    const char *type,
    Uns32       bits,
    Bool        isCode,
    Bool        unified
) {
    sprintf(
        result,
        "%u-bit %s %s %s",
        bits,
        riscvGetModeName(mode),
        type,
        unified ? "unified" : isCode ? "code" : "data"
    );
}

//
// Create new domain
//
static memDomainP createDomain(
    riscvMode   mode,
    const char *type,
    Uns32       bits,
    Bool        isCode,
    Bool        unified
) {
    char name[64];

    // fill domain name
    getDomainName(name, mode, type, bits, isCode, unified);

    // create the domain
    return vmirtNewDomain(name, bits);
}

//
// Create new PMA domain for the given mode
//
static Bool createPMADomain(riscvP riscv, riscvMode mode, Bool isCode) {

    memDomainP extDomain   = riscv->extDomains[isCode];
    memDomainP otherDomain = riscv->extDomains[!isCode];
    Bool       unified     = (extDomain==otherDomain);
    Uns32      pmaBits     = 64;
    Uns64      extMask     = getAddressMask(riscv->extBits);

    // create domain of width pmaBits
    memDomainP pmaDomain = createDomain(mode, "PMA", pmaBits, isCode, unified);

    // create mapping to external domain unless this is done lazily
    if(!riscv->configInfo.PMP_max_page) {
        vmirtAliasMemory(extDomain, pmaDomain, 0, extMask, 0, 0);
    }

    // save domain
    riscv->pmaDomains[mode][isCode] = pmaDomain;

    return unified;
}

//
// Create new PMP domain for the given mode
//
static Bool createPMPDomain(riscvP riscv, riscvMode mode, Bool isCode) {

    memDomainP pmaDomain   = getPMADomainCorD(riscv, mode,  isCode);
    memDomainP otherDomain = getPMADomainCorD(riscv, mode, !isCode);
    Bool       unified     = (pmaDomain==otherDomain);
    memDomainP pmpDomain   = pmaDomain;

    // create PMP domain only if PMP registers are implemented
    if(getNumPMPs(riscv)) {

        Uns32 pmpBits = 64;
        Uns64 extMask = getAddressMask(riscv->extBits);

        // create domain of width pmpBits
        pmpDomain = createDomain(mode, "PMP", pmpBits, isCode, unified);

        // create mapping to external domain with no access privileges
        vmirtAliasMemoryPriv(pmaDomain, pmpDomain, 0, extMask, 0, MEM_PRIV_NONE);
    }

    // save domain
    riscv->pmpDomains[mode][isCode] = pmpDomain;

    return unified;
}

//
// Create new physical domain for the given mode
//
static Bool createPhysicalDomain(riscvP riscv, riscvMode mode, Bool isCode) {

    memDomainP pmpDomain   = getPMPDomainCorD(riscv, mode,  isCode);
    memDomainP otherDomain = getPMPDomainCorD(riscv, mode, !isCode);
    Bool       unified     = (pmpDomain==otherDomain);
    Uns32      physBits    = riscvGetXlenArch(riscv);
    Uns64      physMask    = getAddressMask(physBits);

    // create domain of width physBits
    memDomainP physDomain = createDomain(
        mode, "Physical", physBits, isCode, unified
    );

    // create mapping to PMP domain
    vmirtAliasMemory(pmpDomain, physDomain, 0, physMask, 0, 0);

    // save domain
    riscv->physDomains[mode][isCode] = physDomain;

    return unified;
}

//
// Create new virtual domain for the given mode
//
static Bool createVirtualDomain(riscvP riscv, riscvVMMode vmMode, Bool isCode) {

    riscvMode  mode     = vmmodeToMode(vmMode);
    memDomainP pmpCode  = getPMPDomainCorD(riscv, mode, True);
    memDomainP pmpData  = getPMPDomainCorD(riscv, mode, False);
    Bool       unified  = (pmpCode==pmpData);
    Uns32      xlenBits = riscvGetXlenArch(riscv);

    riscv->vmDomains[vmMode][isCode] = createDomain(
        mode, "Virtual", xlenBits, isCode, unified
    );

    return unified;
}

//
// Create new HLVX domain for the given mode
//
static void createHLVXDomain(riscvP riscv, riscvVMMode vmMode) {

    riscvMode mode     = vmmodeToMode(vmMode);
    Uns32     xlenBits = riscvGetXlenArch(riscv);

    riscv->hlvxDomains[getBaseMode(mode)] = createDomain(
        mode, "HLVX", xlenBits, True, False
    );
}

//
// Create new CLIC domain at cluster root level
//
static memDomainP createCLICDomain(riscvP riscv, memDomainP dataDomain) {

    riscvP root = riscv->smpRoot;

    // CLIC memory map is shared by all harts in a cluster
    if(!root->CLICDomain) {

        Uns32 bits = vmirtGetDomainAddressBits(dataDomain);
        Uns64 mask = getAddressMask(bits);

        // create domain of width bits
        memDomainP CLICDomain = createDomain(
            RISCV_MODE_M, "CLIC", bits, False, False
        );

        // create mapping to data domain
        vmirtAliasMemory(dataDomain, CLICDomain, 0, mask, 0, 0);

        // create CLIC memory-mapped block
        riscvMapCLICDomain(root, CLICDomain);

        // save CLIC domain on cluster root
        root->CLICDomain = CLICDomain;
    }

    return root->CLICDomain;
}

//
// Do transaction load
//
static VMI_MEM_READ_FN(doLoadTMode) {

    riscvP riscv = (riscvP)processor;

    // call derived model transaction load functions
    ITER_EXT_CB(
        riscv, extCB, tLoad,
        extCB->tLoad(riscv, value, VA, bytes, extCB->clientData);
    )
}

//
// Do transaction store
//
static VMI_MEM_WRITE_FN(doStoreTMode) {

    riscvP riscv = (riscvP)processor;

    // call derived model transaction store functions
    ITER_EXT_CB(
        riscv, extCB, tStore,
        extCB->tStore(riscv, value, VA, bytes, extCB->clientData);
    )
}

//
// Create transaction mode domain
//
static void createTMDomain(riscvP riscv) {

    riscv->tmDomain = vmirtNewDomain("Transaction", riscvGetXlenArch(riscv));

    vmirtMapCallbacks(riscv->tmDomain, 0, -1, doLoadTMode, doStoreTMode, 0);
}

//
// Common utility for command to dump a TLB
//
static const char *dumpTLBCommon(vmiProcessorP processor, riscvTLBId id) {

    riscvP riscv = (riscvP)processor;

    dumpTLB(riscv, riscv->tlb[id]);

    return "1";
}

//
// Dump the contents of the HS TLB
//
static VMIRT_COMMAND_PARSE_FN(dumpHSTLBCommand) {
    return dumpTLBCommon(processor, RISCV_TLB_HS);
}

//
// Dump the contents of the virtual stage 1 TLB
//
static VMIRT_COMMAND_PARSE_FN(dumpVS1TLBCommand) {
    return dumpTLBCommon(processor, RISCV_TLB_VS1);
}

//
// Dump the contents of the virtual stage 2 TLB
//
static VMIRT_COMMAND_PARSE_FN(dumpVS2TLBCommand) {
    return dumpTLBCommon(processor, RISCV_TLB_VS2);
}

//
// Create a TLB and associated command to dump it
//
static void createTLB(riscvP riscv, riscvTLBId id) {

    typedef struct tlbInfoS {
        vmirtCommandParseFn commandCB;
        const char         *name;
        const char         *desc;
    } tlbInfo;

    static const tlbInfo info[] = {
        [RISCV_TLB_HS]  = {dumpHSTLBCommand,  "dumpTLB",    "show TLB contents"},
        [RISCV_TLB_VS1] = {dumpVS1TLBCommand, "dumpVS1TLB", "show VS1 TLB contents"},
        [RISCV_TLB_VS2] = {dumpVS2TLBCommand, "dumpVS2TLB", "show VS2 TLB contents"},
    };

    // initialize TLB
    riscv->tlb[id] = newTLB(riscv);

    // dumpTLB command
    vmirtAddCommandParse(
        (vmiProcessorP)riscv,
        info[id].name,
        info[id].desc,
        info[id].commandCB,
        VMI_CT_QUERY|VMI_CO_TLB|VMI_CA_QUERY
    );
}

//
// Virtual memory initialization
//
VMI_VMINIT_FN(riscvVMInit) {

    riscvP     riscv      = (riscvP)processor;
    memDomainP codeDomain = codeDomains[0];
    memDomainP dataDomain = dataDomains[0];
    Uns32      codeBits   = vmirtGetDomainAddressBits(codeDomain);
    Uns32      dataBits   = vmirtGetDomainAddressBits(dataDomain);
    riscvMode  mode;
    riscvDMode dMode;

    // use core context for domain creation
    vmirtSetCreateDomainContext(processor);

    // save size of physical domain
    riscv->extBits = (codeBits<dataBits) ? codeBits : dataBits;

    // install memory-mapped CLIC control register block if required
    if(CLICInternal(riscv)) {
        dataDomain = createCLICDomain(riscv, dataDomain);
    }

    // save external domains (including CLIC block) for lazy PMA mapping
    riscv->extDomains[0] = dataDomain;
    riscv->extDomains[1] = codeDomain;

    // create per-base-mode domains
    for(mode=RISCV_MODE_S; mode<RISCV_MODE_LAST_BASE; mode++) {

        if(mode==RISCV_MODE_H) {

            // ignore artifact H mode

        } else {

            // create PMA data and code domains for this mode
            if(createPMADomain(riscv, mode, False)) {
                riscv->pmaDomains[mode][1] = riscv->pmaDomains[mode][0];
            } else {
                createPMADomain(riscv, mode, True);
            }

            // create PMP data and code domains for this mode
            if(createPMPDomain(riscv, mode, False)) {
                riscv->pmpDomains[mode][1] = riscv->pmpDomains[mode][0];
            } else {
                createPMPDomain(riscv, mode, True);
            }

            // create physical data and code domains for this mode
            if(createPhysicalDomain(riscv, mode, False)) {
                riscv->physDomains[mode][1] = riscv->physDomains[mode][0];
            } else {
                createPhysicalDomain(riscv, mode, True);
            }
        }
    }

    // use Supervisor-mode PMA, PMP and physical domains for User mode
    riscv->pmaDomains [RISCV_MODE_U][0] = riscv->pmaDomains [RISCV_MODE_S][0];
    riscv->pmaDomains [RISCV_MODE_U][1] = riscv->pmaDomains [RISCV_MODE_S][1];
    riscv->pmpDomains [RISCV_MODE_U][0] = riscv->pmpDomains [RISCV_MODE_S][0];
    riscv->pmpDomains [RISCV_MODE_U][1] = riscv->pmpDomains [RISCV_MODE_S][1];
    riscv->physDomains[RISCV_MODE_U][0] = riscv->physDomains[RISCV_MODE_S][0];
    riscv->physDomains[RISCV_MODE_U][1] = riscv->physDomains[RISCV_MODE_S][1];

    // create guest physical domain if required
    if(hypervisorPresent(riscv)) {
        riscv->guestPTWDomain = createDomain(
            RISCV_MODE_H, "Guest PTW", dataBits, False, True
        );
    }

    for(dMode=0; dMode<RISCV_DMODE_LAST; dMode++) {

        if(riscvHasDMode(riscv, dMode)) {

            mode = dmodeToMode5(dMode);

            // initialize physical domains
            dataDomains[dMode] = getPhysDomainCorD(riscv, mode, False);
            codeDomains[dMode] = getPhysDomainCorD(riscv, mode, True);

            if(dmodeIsVM(dMode)) {

                riscvVMMode vmMode = dmodeToVMMode(dMode);

                // create virtual data and code domains for this mode
                if(createVirtualDomain(riscv, vmMode, False)) {
                    riscv->vmDomains[vmMode][1] = riscv->vmDomains[vmMode][0];
                } else {
                    createVirtualDomain(riscv, vmMode, True);
                }

                // create HLVX domain if required
                if(dmodeIsVirtual(dMode)) {
                    createHLVXDomain(riscv, vmMode);
                }

                // initialize virtual domains
                dataDomains[dMode] = riscv->vmDomains[vmMode][0];
                codeDomains[dMode] = riscv->vmDomains[vmMode][1];
            }
        }
    }

    // create transaction mode domain
    createTMDomain(riscv);

    // initialize HS TLB if required
    if(riscvHasMode(riscv, RISCV_MODE_S)) {
        createTLB(riscv, RISCV_TLB_HS);
    }

    // initialize VS TLB if required
    if(riscvHasMode(riscv, RISCV_MODE_VS)) {
        createTLB(riscv, RISCV_TLB_VS1);
        createTLB(riscv, RISCV_TLB_VS2);
    }
}

//
// Return any TLB entry for the passed address which matches the current ASID
// and VMID
//
static tlbEntryP findTLBEntry(riscvP riscv, riscvTLBP tlb, Uns64 VA) {

    Uns32 ASID = getActiveASID(riscv);
    Uns32 VMID = getActiveVMID(riscv);

    // return any entry with matching MVA, ASID and VMID
    ITER_TLB_ENTRY_RANGE(
        riscv, tlb, VA, VA, entry,
        if(matchVMID(VMID, entry) && matchASID(ASID, entry)) {
            return entry;
        }
    );

    // here if there is no match
    return 0;
}

//
// Look up any TLB entry for the passed address and fill byref argument 'entry'
// with the details (stage 1 TLB)
//
static riscvException tlbLookupS1(
    riscvP         riscv,
    riscvMode      mode,
    tlbEntryP      entry,
    memPriv        requiredPriv,
    memAccessAttrs attrs,
    Bool           V
) {
    VAMode         vaMode = RD_CSR_FIELD_V(riscv, satp, V, MODE);
    riscvException result = 0;

    if(vaMode==VAM_Sv32) {
        result = tlbLookupSv32(riscv, mode, entry, requiredPriv, attrs);
    } else if(vaMode==VAM_Sv39) {
        result = tlbLookupSv39(riscv, mode, entry, requiredPriv, attrs);
    } else if(vaMode==VAM_Sv48) {
        result = tlbLookupSv48(riscv, mode, entry, requiredPriv, attrs);
    } else {
        VMI_ABORT("Invalid VA mode"); // LCOV_EXCL_LINE
    }

    return result;
}

//
// Look up any TLB entry for the passed address and fill byref argument 'entry'
// with the details (stage 2 TLB)
//
static riscvException tlbLookupS2(
    riscvP         riscv,
    riscvMode      mode,
    tlbEntryP      entry,
    memPriv        requiredPriv,
    memAccessAttrs attrs
) {
    VAMode         vaMode = RD_CSR_FIELD_S(riscv, hgatp, MODE);
    riscvException result = 0;

    if(vaMode==VAM_Sv32) {
        result = tlbLookupSv32x4(riscv, mode, entry, requiredPriv, attrs);
    } else if(vaMode==VAM_Sv39) {
        result = tlbLookupSv39x4(riscv, mode, entry, requiredPriv, attrs);
    } else if(vaMode==VAM_Sv48) {
        result = tlbLookupSv48x4(riscv, mode, entry, requiredPriv, attrs);
    } else {
        VMI_ABORT("Invalid VA mode"); // LCOV_EXCL_LINE
    }

    return result;
}

//
// Handle trap of page table walk
//
static riscvException trapDerived(
    riscvP         riscv,
    tlbEntryP      entry,
    memPriv        requiredPriv,
    memAccessAttrs attrs,
    Bool           S2,
    Bool           V
) {
    riscvException result = 0;

    ITER_EXT_CB_WHILE(
        riscv, extCB, VMTrap, !result,
        result = extCB->VMTrap(
            riscv,
            S2 ? RISCV_TLB_VS2 : V ? RISCV_TLB_VS1 : RISCV_TLB_HS,
            requiredPriv,
            entry->lowVA,
            extCB->clientData
        );
    )

    return result;
}

//
// Look up any TLB entry for the passed address and fill byref argument 'entry'
// with the details.
//
static riscvException tlbLookup(
    riscvP         riscv,
    riscvMode      mode,
    tlbEntryP      entry,
    memPriv        requiredPriv,
    memAccessAttrs attrs
) {
    Bool           S2 = activeTLBIsVS2(riscv);
    Bool           V  = !S2 && activeTLBIsVirtual(riscv);
    riscvException result;

    if((result = trapDerived(riscv, entry, requiredPriv, attrs, S2, V))) {
        // no further action if derived model lookup traps
    } else if(!S2) {
        result = tlbLookupS1(riscv, mode, entry, requiredPriv, attrs, V);
    } else {
        result = tlbLookupS2(riscv, mode, entry, requiredPriv, attrs);
    }

    return result;
}

//
// is the fault a load/store/AMO fault requiring a syndrome?
//
static Bool isLoadStoreAMOFault(riscvException exception) {

    switch(exception) {
        case riscv_E_LoadAddressMisaligned:
        case riscv_E_LoadAccessFault:
        case riscv_E_StoreAMOAddressMisaligned:
        case riscv_E_StoreAMOAccessFault:
        case riscv_E_LoadPageFault:
        case riscv_E_StoreAMOPageFault:
        case riscv_E_LoadGuestPageFault:
        case riscv_E_StoreAMOGuestPageFault:
            return True;
        default:
            return False;
    }
}

//
// Map load size in bits to decode value
//
static Uns32 mapMemBits(Uns32 memBits) {

    Uns32 result = 0;

    while(memBits>8) {
        result++;
        memBits >>= 1;
    }

    return result;
}

//
// Fill syndrome for load exception
//
static Uns32 fillSyndromeLoad(riscvInstrInfoP info, Uns32 offset) {

    // union for load instruction composition
    typedef union ldSyndromeU {
        struct {
            Uns32 opcode :  7;
            Uns32 rd     :  5;
            Uns32 funct3 :  3;
            Uns32 offset :  5;
            Uns32 _u1    : 12;
        } f;
        Uns32 u32;
    } ldSyndrome;

    ldSyndrome   u1  = {{0}};
    riscvRegDesc rd  = info->r[0];
    Bool         isF = isFReg(rd);

    // fill instruction fields
    u1.f.opcode = (isF ? 0x06 : 0x02) + (info->bytes==4);
    u1.f.rd     = getRIndex(rd);
    u1.f.funct3 = mapMemBits(info->memBits) + (info->unsExt*4);
    u1.f.offset = offset;

    // extract result
    Uns32 result = u1.u32;

    // sanity check composed result if a 32-bit instruction
    if(info->bytes==4) {

        ldSyndrome u2 = {u32:info->instruction};

        // clear offset fields that will not match
        u1.f._u1    = 0;
        u2.f._u1    = 0;
        u1.f.offset = 0;
        u2.f.offset = 0;

        VMI_ASSERT(
            u2.u32==u1.u32,
            "incorrect load syndrome: expected 0x%08x, actual 0x%08x",
            u2.u32, u1.u32
        );
    }

    // return composed value
    return result;
}

//
// Fill syndrome for store exception
//
static Uns32 fillSyndromeStore(riscvInstrInfoP info, Uns32 offset) {

    // union for store instruction composition
    typedef union stSyndromeU {
        struct {
            Uns32 opcode : 7;
            Uns32 _u1    : 5;
            Uns32 funct3 : 3;
            Uns32 offset : 5;
            Uns32 rs2    : 5;
            Uns32 _u2    : 7;
        } f;
        Uns32 u32;
    } stSyndrome;

    stSyndrome   u1  = {{0}};
    riscvRegDesc rs2 = info->r[0];
    Bool         isF = isFReg(rs2);

    // fill instruction fields
    u1.f.opcode = (isF ? 0x26 : 0x22) + (info->bytes==4);
    u1.f.rs2    = getRIndex(rs2);
    u1.f.funct3 = mapMemBits(info->memBits);
    u1.f.offset = offset;

    // extract result
    Uns32 result = u1.u32;

    // sanity check composed result if a 32-bit instruction
    if(info->bytes==4) {

        stSyndrome u2 = {u32:info->instruction};

        // clear offset fields that will not match
        u1.f._u1    = 0;
        u2.f._u1    = 0;
        u1.f._u2    = 0;
        u2.f._u2    = 0;
        u1.f.offset = 0;
        u2.f.offset = 0;

        VMI_ASSERT(
            u2.u32==u1.u32,
            "incorrect store syndrome: expected 0x%08x, actual 0x%08x",
            u2.u32, u1.u32
        );
    }

    // return composed value
    return result;
}

//
// Fill syndrome for generic 32-bit instruction that is reported unmodified,
// except for offset in fields 19:15
//
static Uns32 fillSyndrome32Offset_19_15(riscvInstrInfoP info, Uns32 offset) {

    // union for instruction composition
    typedef union i32SyndromeU {
        struct {
            Uns32 _u1    : 15;
            Uns32 offset :  5;
            Uns32 _u2    : 12;
        } f;
        Uns32 u32;
    } i32Syndrome;

    // sanity check only 4-byte instructions are encountered
    VMI_ASSERT(info->bytes==4, "unexpected instruction bytes %u", info->bytes);

    // use raw 32-bit instruction pattern without modification
    i32Syndrome u = {u32:info->instruction};

    // update offset field
    u.f.offset = offset;

    // return composed value
    return u.u32;
}

//
// Fill syndrome for load/store/AMO exception if required
//
static Uns64 fillSyndrome(riscvP riscv, riscvException exception, Uns64 VA) {

    Uns32 result = 0;

    // create syndrome for load/store/AMO exception if required
    if(!xtinstBasic(riscv) && isLoadStoreAMOFault(exception)) {

        riscvInstrInfo info;

        // decode the faulting instruction
        riscvDecode(riscv, getPC(riscv), &info);

        // calculate offset between faulting address and original virtual
        // address (non-zero only for misaligned memory accesses)
        Uns32 offset = VA-riscv->originalVA;

        if(info.type==RV_IT_L_I) {
            result = fillSyndromeLoad(&info, offset);
        } else if(info.type==RV_IT_S_I) {
            result = fillSyndromeStore(&info, offset);
        } else if((info.type>=RV_IT_AMOADD_R) && (info.type<=RV_IT_SC_R)) {
            result = fillSyndrome32Offset_19_15(&info, offset);
        } else if((info.type>=RV_IT_HLV_R) && (info.type<=RV_IT_HSV_R)) {
            result = fillSyndrome32Offset_19_15(&info, offset);
        }
    }

    return result;
}

//
// Take exception on invalid access
//
static void handleInvalidAccess(
    riscvP         riscv,
    Uns64          VA,
    memAccessAttrs attrs,
    riscvException exception
) {
    // take exception only if not an artifact access
    if(!MEM_AA_IS_ARTIFACT_ACCESS(attrs)) {

        // if failure is at stage 2, record failing VA as guest physical address
        if(activeTLBIsVS2(riscv)) {
            riscv->GPA = VA>>2;
        }

        // report original failing VA
        VA = riscv->s1VA;

        // fill syndrome for load/store/AMO exception if required
        if(!riscv->tinst && hypervisorPresent(riscv)) {
            riscv->tinst = fillSyndrome(riscv, exception, VA);
        }

        // take exception, indicating guest virtual address if required
        riscv->GVA = activeTLBIsVirtual(riscv);
        riscvTakeMemoryException(riscv, exception, VA);
        riscv->GVA = False;

        // clear down pending exception GPA and tinst
        riscv->GPA   = 0;
        riscv->tinst = 0;
    }
}

//
// Take page fault exception for an invalid access
//
static void handlePageFault(
    riscvP         riscv,
    riscvMode      mode,
    tlbEntryP      entry,
    Uns64          VA,
    memPriv        requiredPriv,
    memAccessAttrs attrs,
    pteError       error
) {
    riscvException exception = handlePTWException(
        riscv, mode, entry, requiredPriv, -1, error
    );

    // take exception
    handleInvalidAccess(riscv, VA, attrs, exception);
}

//
// Macro encapsulating PTW error generation
//
#define PAGE_FAULT(_CODE) \
    handlePageFault(riscv, mode, entry, VA, requiredPriv, attrs, PTEE_##_CODE); \
    return 0;

//
// Find or create a TLB entry for the passed VA
//
static tlbEntryP findOrCreateTLBEntry(
    riscvP         riscv,
    riscvMode      mode,
    memAccessAttrs attrs,
    tlbMapInfoP    miP
) {
    riscvTLBP tlb          = getActiveTLB(riscv);
    Uns64     VA           = miP->lowVA;
    tlbEntryP entry        = findTLBEntry(riscv, tlb, VA);
    memPriv   requiredPriv = miP->priv;
    memPriv   priv;

    ////////////////////////////////////////////////////////////////////////////
    // ACCESS CACHED TLB ENTRY
    ////////////////////////////////////////////////////////////////////////////

    if(!entry) {

        // no existing entry found for this VA

    } else if(!entry->V) {

        // entry is invalid (custom TLB only)
        VMI_ASSERT(entry->custom, "not custom TLB entry");
        PAGE_FAULT(V0);

    } else if(!(priv=checkEntryPermission(riscv, mode, entry, requiredPriv))) {

        // access permissions are insufficient
        PAGE_FAULT(PRIV);

    } else if(!entry->A) {

        // access flag not set (custom TLB only)
        VMI_ASSERT(entry->custom, "not custom TLB entry");
        PAGE_FAULT(A0);

    } else if((requiredPriv&MEM_PRIV_W) && !entry->D) {

        // dirty flag not set
        if(entry->custom || !updatePTED(riscv)) {
            PAGE_FAULT(D0);
        } else {
            deleteTLBEntry(riscv, getActiveTLB(riscv), entry);
            entry = 0;
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // DO HARDWARE TABLE WALK OR TAKE CUSTOM TRAP
    ////////////////////////////////////////////////////////////////////////////

    if(!entry) {

        tlbEntry tmp = {lowVA:VA};

        // do table walk
        riscvException exception = tlbLookup(
            riscv, mode, &tmp, requiredPriv, attrs
        );

        // do lookup, handling any exception that is signalled
        if(riscv->exception) {
            // ignore first stage exception if second stage PTW already taken
        } else if(!exception) {
            entry = allocateTLBEntry(riscv, tlb, &tmp, attrs);
            priv  = checkEntryPermission(riscv, mode, entry, requiredPriv);
        } else {
            handleInvalidAccess(riscv, VA, attrs, exception);
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // REFINE ENTRY PERMISSIONS
    ////////////////////////////////////////////////////////////////////////////

    if(entry) {

        // record privilege with which entry should be mapped, discarding write
        // privilege if the entry is not dirty
        if(!entry->D) {
            priv &= ~MEM_PRIV_W;
        }

        miP->priv = priv;
    }

    return entry;
}


////////////////////////////////////////////////////////////////////////////////
// PHYSICAL MEMORY MANAGEMENT
////////////////////////////////////////////////////////////////////////////////

//
// Is PMP managed by 64-bit CSRs?
//
inline static Bool isPMP64(riscvP riscv) {
    return RISCV_XLEN_IS_64M(riscv, RISCV_MODE_M);
}

//
// PMP configuration entry mode
//
typedef enum pmpcfgModeE {
    PMPM_OFF,
    PMPM_TOR,
    PMPM_NA4,
    PMPM_NAPOT,
} pmpcfgMode;

//
// PMP configuration entry structure
//
typedef union pmpcfgElemU {
    Uns8 u8;
    struct {
        Uns8       priv : 3;
        pmpcfgMode mode : 2;
        Uns8       _u1  : 2;
        Bool       L    : 1;
    };
} pmpcfgElem;

//
// Read the indexed PMP configuration register (internal routine)
//
inline static Uns64 readPMPCFGInt(riscvP riscv, Uns32 index) {

    // return either 32-bit or 64-bit view
    if(isPMP64(riscv)) {
        return riscv->pmpcfg.u64[index/2];
    } else {
        return riscv->pmpcfg.u32[index];
    }
}

//
// Return the indexed PMP configuration register
//
inline static pmpcfgElem getPMPCFGElem(riscvP riscv, Uns8 index) {
    return (pmpcfgElem){u8:riscv->pmpcfg.u8[index]};
}

//
// Is a PMP entry controlled by the given element locked?
//
inline static Bool pmpLocked(riscvP riscv, Uns8 index) {
    return !riscv->artifactAccess && getPMPCFGElem(riscv,index).L;
}

//
// Return the effective value of a PMP address register, taking into account
// grain size
//
static Uns64 getEffectivePMPAddr(riscvP riscv, Uns8 index) {

    pmpcfgElem e      = getPMPCFGElem(riscv, index);
    Uns32      G      = riscv->configInfo.PMP_grain;
    Uns64      result = riscv->pmpaddr[index];

    if((G>=2) && (e.mode==PMPM_NAPOT)) {

        // when G>=2 and pmpcfgi.A[1] is set, i.e. the mode is NAPOT, then bits
        // pmpaddri[G-2:0] read as all ones
        result |= ((1ULL << (G-1)) - 1);

    } else if((G>=1) && (e.mode!=PMPM_NAPOT)) {

        // when G>=1 and pmpcfgi.A[1] is clear, i.e. the mode is OFF or TOR,
        // then bits pmpaddri[G-1:0] read as all zeros
        result &= (-1ULL << G);
    }

    return result;
}

//
// Is the indexed PMP region active?
//
static Bool getPMPRegionActive(riscvP riscv, pmpcfgElem e, Uns8 index) {

    if(e.mode==PMPM_OFF) {

        // region is disabled
        return False;

    } else if(e.mode!=PMPM_TOR) {

        // region is enabled with no range constraint
        return True;

    } else {

        // TOR region is effectively enabled only if the associated address is
        // non-zero (a zero address will always fail the bounds check)
        return getEffectivePMPAddr(riscv, index);
    }
}

//
// Is a PMP entry controlled by the given element a locked TOR entry?
//
static Bool pmpLockedTOR(riscvP riscv, Uns8 index) {

    Bool locked = False;

    if(index<getNumPMPs(riscv)) {

        pmpcfgElem e = getPMPCFGElem(riscv, index);

        locked = (e.mode==PMPM_TOR) && pmpLocked(riscv, index);
    }

    return locked;
}

//
// This controls protections applied by pmpProtect
//
typedef enum pmpUpdateE {
    PMPU_SET_PRIV = 0x1,  // whether privilege is being set
    PMPU_LO       = 0x2,  // whether alignment check is required at low bound
    PMPU_HI       = 0x4,  // whether alignment check is required at high bound
    PMPU_LO_HI    = PMPU_LO|PMPU_HI
} pmpUpdate;

//
// If updatePriv is True, set privileges in PMP domain, removing privileges on
// adjacent regions if required to detect accesses that straddle PMP boundaries;
// if updatePriv is False, update adjacent regions without modifying main region
// privileges
//
static void pmpProtect(
    riscvP     riscv,
    memDomainP domain,
    Uns64      lo,
    Uns64      hi,
    memPriv    priv,
    pmpUpdate  update
) {
    Bool unalignedOK = riscv->configInfo.unaligned;
    Bool updatePriv  = update & PMPU_SET_PRIV;

    // set the required permissions on the PMP region if required
    if(updatePriv) {
        vmirtProtectMemory(domain, lo, hi, priv, MEM_PRIV_SET);
    }

    // remove permissions on adjacent region bytes if accesses could possibly
    // straddle region boundaries
    if(
        (priv || !updatePriv) &&
        (
            // unaligned accesses could straddle any boundary
            unalignedOK ||
            // 64-bit F registers could straddle any 32-bit boundary
            (riscvGetFlenArch(riscv) > 32) ||
            // 64-bit X registers could straddle any 32-bit boundary
            (riscvGetXlenArch(riscv) > 32)
        )
    ) {
        Uns64 loMin = 0;
        Uns64 hiMax = getAddressMask(riscv->extBits);

        // protect adjacent low byte if unaligned accesses are allowed or it
        // is on a 4-byte boundary
        if((update&PMPU_LO) && (lo>loMin) && (unalignedOK || (lo&4))) {
            vmirtProtectMemory(domain, lo-1, lo-1, MEM_PRIV_NONE, MEM_PRIV_SET);
        }

        // protect adjacent high byte if unaligned accesses are allowed or it
        // is on a 4-byte boundary
        if((update&PMPU_HI) && (hi<hiMax) && (unalignedOK || ((hi+1)&4))) {
            vmirtProtectMemory(domain, hi+1, hi+1, MEM_PRIV_NONE, MEM_PRIV_SET);
        }
    }
}

//
// Set privileges in PMP domain for the given mode, or, if update does not
// include PMPU_SET_PRIV, only remove permissions on adjacent regions
//
static void setPMPPriv(
    riscvP    riscv,
    riscvMode mode,
    Uns64     low,
    Uns64     high,
    memPriv   priv,
    pmpUpdate update
) {
    memDomainP dataDomain = getPMPDomainCorD(riscv, mode, False);
    memDomainP codeDomain = getPMPDomainCorD(riscv, mode, True);
    Bool       updatePriv = update & PMPU_SET_PRIV;

    // emit debug if required
    if(updatePriv && RISCV_DEBUG_MMU(riscv)) {
        vmiPrintf(
            "PMP PRIV=%s 0x"FMT_6408x":0x"FMT_6408x" (mode %s)\n",
            privName(priv), low, high, riscvGetModeName(mode)
        );
    }

    if(dataDomain==codeDomain) {

        // set permissions in unified domain
        pmpProtect(riscv, dataDomain, low, high, priv, update);

    } else {

        // get privileges for data and code domains (NOTE: include RW
        // permissions in code domain to allow application load)
        memPriv privRW = priv&MEM_PRIV_RW;
        memPriv privX  = priv&MEM_PRIV_X ? MEM_PRIV_RWX : MEM_PRIV_NONE;

        // set permissions in data domain if required
        if(!updatePriv || (priv==MEM_PRIV_NONE) || privRW) {
            pmpProtect(riscv, dataDomain, low, high, privRW, update);
        }

        // set permissions in code domain if required
        if(!updatePriv || (priv==MEM_PRIV_NONE) || privX) {
            pmpProtect(riscv, codeDomain, low, high, privX, update);
        }
    }
}

//
// Return the bounds of the indexed PMP entry
//
static void getPMPEntryBounds(
    riscvP riscv,
    Uns32  index,
    Uns64 *lowP,
    Uns64 *highP
) {
    pmpcfgElem e   = getPMPCFGElem(riscv, index);
    Uns64      low = getEffectivePMPAddr(riscv, index)<<2;
    Uns64      high;

    if(e.mode==PMPM_NA4) {

        // 4-byte range
        high = low + 3;

    } else if(e.mode==PMPM_NAPOT) {

        // naturally-aligned power of two range
        Uns64 notLow = ~(low+3);
        Uns64 mask   = ((notLow & -notLow) << 1) - 1;

        low  = low & ~mask;
        high = low |  mask;

    } else {

        // top-of-range
        high = low-1;
        low  = index ? riscv->pmpaddr[index-1]<<2 : 0;

        // mask low address to implemented grain size
        low &= (-4ULL << riscv->configInfo.PMP_grain);
    }

    // assign results
    *lowP  = low;
    *highP = high;
}

//
// Are any lower-priority PMP entries than the indexed entry locked?
//
static Bool lowerPriorityPMPEntryLocked(riscvP riscv, Uns32 index) {

    Uns32 numRegs = getNumPMPs(riscv);
    Uns32 i;

    for(i=index+1; i<numRegs; i++) {

        pmpcfgElem e = getPMPCFGElem(riscv, i);

        if(e.L && (e.mode!=PMPM_OFF)) {
            return True;
        }
    }

    return False;
}

//
// Remove all privileges for PMP region
//
static void removePMPPriv(
    riscvP    riscv,
    riscvMode mode,
    Uns64     low,
    Uns64     high,
    memPriv   priv,
    Bool      updatePriv
) {
    pmpUpdate update = PMPU_LO_HI | (updatePriv ? PMPU_SET_PRIV : 0);

    setPMPPriv(riscv, mode, low, high, priv, update);
}

//
// Invalidate PMP entry 'index'
//
static void invalidatePMPEntry(riscvP riscv, Uns32 index) {

    pmpcfgElem e = getPMPCFGElem(riscv, index);

    if(getPMPRegionActive(riscv, e, index)) {

        Uns64 low;
        Uns64 high;

        // get the entry bounds
        getPMPEntryBounds(riscv, index, &low, &high);

        // ignore TOR entries with low>high
        if(low<=high) {

            // remove access in Supervisor address space
            removePMPPriv(riscv, RISCV_MODE_S, low, high, MEM_PRIV_NONE, True);

            // remove access in Machine address space if the entry is locked
            // or if any lower-priority entry is locked (enabling or disabling
            // this region may reveal or conceal that region)
            Bool updateM = (e.L || lowerPriorityPMPEntryLocked(riscv, index));
            removePMPPriv(riscv, RISCV_MODE_M, low, high, MEM_PRIV_NONE, updateM);
        }
    }
}

//
// Return offset into PMP bank allowing for the fact that when in 64-bit mode
// the second set of PMP registers are controlled by pmpcfg2 (not pmpcfg1,
// which is unimplemented)
//
static Uns32 getPMPCFGOffset(riscvP riscv, Uns32 index) {
    return isPMP64(riscv) ? index/2 : index;
}

//
// Is the given PMP configuration register index valid?
//
static Bool validPMPCFG(riscvP riscv, Uns32 index) {

    Uns32 entriesPerCFG = isPMP64(riscv) ? 8 : 4;
    Uns32 numPMP        = getNumPMPs(riscv);
    Uns32 numCFG        = ((numPMP+entriesPerCFG-1)/entriesPerCFG);

    return (getPMPCFGOffset(riscv, index) < numCFG);
}

//
// Read the indexed PMP configuration register
//
Uns64 riscvVMReadPMPCFG(riscvP riscv, Uns32 index) {
    return validPMPCFG(riscv, index) ? readPMPCFGInt(riscv, index) : 0;
}

//
// Write the indexed PMP configuration register with the new value and return
// the new effective value
//
Uns64 riscvVMWritePMPCFG(riscvP riscv, Uns32 index, Uns64 newValue) {

    Uns64 result = 0;

    if(validPMPCFG(riscv, index)) {

        Uns32 entriesPerCFG = isPMP64(riscv) ? 8 : 4;
        Uns32 offset        = getPMPCFGOffset(riscv, index);
        Uns32 G             = riscv->configInfo.PMP_grain;
        Uns32 numPMP        = getNumPMPs(riscv);
        Uns32 numBytes      = numPMP-(offset*entriesPerCFG);
        Uns64 mask          = (numBytes>=8) ? -1 : (1ULL<<(numBytes*8))-1;
        Int32 i;

        // get byte-accessible source value
        union {Uns64 u64; Uns8 u8[8];} src = {u64 : newValue&WM64_pmpcfg&mask};

        // invalidate any modified entries in lowest-to-highest priority order
        // (required so that lowerPriorityPMPEntryLocked always returns valid
        // results)
        for(i=entriesPerCFG-1; i>=0; i--) {

            Uns32 cfgIndex = (index*4)+i;
            Uns8 *dstP     = &riscv->pmpcfg.u8[cfgIndex];

            // get old and new values
            pmpcfgElem srcCFG = {u8:src.u8[i]};
            pmpcfgElem dstCFG = {u8:*dstP};

            // when G>=1, the NA4 mode is not selectable
            if(G && (srcCFG.mode==PMPM_NA4)) {
                srcCFG.mode = dstCFG.mode;
            }

            if((*dstP!=srcCFG.u8) && !pmpLocked(riscv, cfgIndex)) {

                // invalidate entry using its original specification
                invalidatePMPEntry(riscv, cfgIndex);

                // set new value
                *dstP = srcCFG.u8;

                // invalidate entry using its new specification
                invalidatePMPEntry(riscv, cfgIndex);
            }
        }

        // return updated value
        result = readPMPCFGInt(riscv, index);
    }

    return result;
}

//
// Is the given PMP address register index valid?
//
inline static Bool validPMPAddr(riscvP riscv, Uns32 index) {
    return index<getNumPMPs(riscv);
}

//
// Read the indexed PMP address register
//
Uns64 riscvVMReadPMPAddr(riscvP riscv, Uns32 index) {
    return validPMPAddr(riscv, index) ? getEffectivePMPAddr(riscv, index) : 0;
}

//
// Write the indexed PMP address register with the new value and return
// the new effective value
//
Uns64 riscvVMWritePMPAddr(riscvP riscv, Uns32 index, Uns64 newValue) {

    Uns64 result = 0;
    Uns32 G      = riscv->configInfo.PMP_grain;

    // mask writable bits to implemented external bits
    newValue &= (getAddressMask(riscv->extBits) >> 2);

    // also mask writable bits if grain is set
    if(G) {
        newValue &= (-1ULL << (G-1));
    }

    if(validPMPAddr(riscv, index) && (riscv->pmpaddr[index]!=newValue)) {

        if(pmpLocked(riscv, index)) {

            // entry index is locked

        } else if(pmpLockedTOR(riscv, index+1)) {

            // next entry is a locked TOR entry

        } else {

            // invalidate entry using its original specification
            invalidatePMPEntry(riscv, index);

            // set new value
            riscv->pmpaddr[index] = newValue;

            // invalidate entry using its new specification
            invalidatePMPEntry(riscv, index);
        }

        result = getEffectivePMPAddr(riscv, index);
    }

    return result;
}

//
// Reset PMP unit
//
void riscvVMResetPMP(riscvP riscv) {

    Uns32 numRegs = getNumPMPs(riscv);
    Uns32 i;

    for(i=0; i<numRegs; i++) {

        if(riscv->pmpaddr[i] || riscv->pmpcfg.u8[i]) {

            // invalidate entry using its current specification
            invalidatePMPEntry(riscv, i);

            // reset entry fields
            riscv->pmpaddr[i]   = 0;
            riscv->pmpcfg.u8[i] = 0;
        }
    }
}

//
// Update the bounds in lowPAP/highPAP and privilege to reflect the effect of
// region i
//
static void refinePMPRegionRange(
    riscvP    riscv,
    riscvMode mode,
    Uns64    *lowPAP,
    Uns64    *highPAP,
    Uns64     PA,
    Uns32     index,
    memPriv  *privP
) {
    pmpcfgElem e = getPMPCFGElem(riscv, index);

    // only handle active regions
    if(getPMPRegionActive(riscv, e, index)) {

        Uns64 lowPAEntry;
        Uns64 highPAEntry;

        // get bounds of the entry
        getPMPEntryBounds(riscv, index, &lowPAEntry, &highPAEntry);

        if(lowPAEntry>highPAEntry) {

            // ignore TOR region with low bound > high bound

        } else if((lowPAEntry<=PA) && (PA<=highPAEntry)) {

            // match in this region
            *lowPAP  = lowPAEntry;
            *highPAP = highPAEntry;

            // refine privilege
            if((mode!=RISCV_MODE_M) || e.L) {
                *privP = e.priv;
            } else {
                *privP = MEM_PRIV_RWX;
            }

        } else if((lowPAEntry>PA) && (lowPAEntry<*highPAP)) {

            // remove part of region ABOVE matching address
            *highPAP = lowPAEntry-1;

        } else if((highPAEntry<PA) && (highPAEntry>*lowPAP)) {

            // remove part of region BELOW matching address
            *lowPAP = highPAEntry+1;
        }
    }
}

//
// Refresh physical mappings for the given physical address range and mode
//
static void mapPMP(
    riscvP    riscv,
    riscvMode mode,
    memPriv   requiredPriv,
    Uns64     lowPA,
    Uns64     highPA
) {
    Uns32 numRegs = getNumPMPs(riscv);

    if(numRegs) {

        memPriv priv    = (mode==RISCV_MODE_M) ? MEM_PRIV_RWX : MEM_PRIV_NONE;
        Uns64   lowMap  = 0;
        Uns64   highMap = getAddressMask(riscv->extBits);
        Int32   i;

        // handle all regions in lowest-to-highest priority order
        for(i=numRegs-1; i>=0; i--) {
            refinePMPRegionRange(riscv, mode, &lowMap, &highMap, lowPA, i, &priv);
        }

        // update PMP mapping if there are sufficient privileges and the
        // required addresses are in a single range
        if(((priv&requiredPriv) != requiredPriv) || (highMap<highPA)) {

            riscv->AFErrorIn = riscv_AFault_PMP;

        } else {

            pmpUpdate update    = PMPU_SET_PRIV;
            Uns64     lowClamp  = lowMap;
            Uns64     highClamp = highMap;

            // clamp physical range to maximum page size
            riscvClampPage(riscv, lowPA, highPA, &lowClamp, &highClamp);

            // determine whether region straddle alignment check is required
            // at low and high bound (only if bounds have *not* been clamped)
            if(lowClamp==lowMap) {
                update |= PMPU_LO;
            }
            if(highClamp==highMap) {
                update |= PMPU_HI;
            }

            // update PMP privileges
            setPMPPriv(riscv, mode, lowClamp, highClamp, priv, update);
        }
    }
}

//
// Allocate PMP structures
//
void riscvVMNewPMP(riscvP riscv) {

    Uns32 numRegs = getNumPMPs(riscv);

    if(numRegs) {
        riscv->pmpcfg.u64 = STYPE_CALLOC_N(Uns64, (numRegs+7)/8);
        riscv->pmpaddr    = STYPE_CALLOC_N(Uns64, numRegs);
    }
}

//
// Free PMP structures
//
void riscvVMFreePMP(riscvP riscv) {

    if(riscv->pmpcfg.u64) {
        STYPE_FREE(riscv->pmpcfg.u64);
    }
    if(riscv->pmpaddr) {
        STYPE_FREE(riscv->pmpaddr);
    }
}


////////////////////////////////////////////////////////////////////////////////
// PMA UPDATE
////////////////////////////////////////////////////////////////////////////////

//
// Establish PMA alias if required
//
static void aliasPMA(
    riscvP     riscv,
    memDomainP extDomain,
    memDomainP pmaDomain,
    Uns64      lowPA,
    Uns64      highPA,
    Bool       removePriv
) {
    memPriv priv = removePriv ? MEM_PRIV_NONE : MEM_PRIV_RWX;

    // emit debug if required
    if(RISCV_DEBUG_MMU(riscv)) {
        vmiPrintf("PMA ALIAS 0x"FMT_6408x":0x"FMT_6408x"\n", lowPA, highPA);
    }

    // establish page alias
    vmirtAliasMemoryPriv(extDomain, pmaDomain, lowPA, highPA, lowPA, priv);
}

//
// Refresh physical mapping attributes for the given physical address range and
// mode
//
static void mapPMA(
    riscvP    riscv,
    riscvMode mode,
    memPriv   requiredPriv,
    Uns64     lowPA,
    Uns64     highPA
) {
    Uns64 clamp = riscv->configInfo.PMP_max_page;

    // handle lazy PMA region mapping if required
    if(clamp) {

        memDomainP extD    = riscv->extDomains[False];
        memDomainP extC    = riscv->extDomains[True];
        memDomainP pmaD    = getPMADomainCorD(riscv, mode, False);
        memDomainP pmaC    = getPMADomainCorD(riscv, mode, True);
        Uns64      extMask = getAddressMask(riscv->extBits);
        Uns64      mask    = clamp-1;
        Uns64      startPA = (lowPA  & ~mask);
        Uns64      endPA   = (highPA & ~mask) + clamp;
        Bool       doPMA   = False;
        Uns64      PA;

        // determine whether any extension implements PMA
        ITER_EXT_CB(
            riscv, extCB, PMAEnable,
            doPMA = extCB->PMAEnable(riscv, extCB->clientData) || doPMA;
        )

        for(PA=startPA; (PA<extMask) && (PA!=endPA); PA+=clamp) {

            // map PMA data page if required
            if(!vmirtIsAlias(pmaD, PA)) {
                aliasPMA(riscv, extD, pmaD, PA, PA+mask, doPMA);
            }

            // map PMA code page if required
            if((pmaD!=pmaC) && !vmirtIsAlias(pmaC, PA)) {
                aliasPMA(riscv, extC, pmaC, PA, PA+mask, doPMA);
            }
        }
    }

    // call derived model PMA validation functions
    ITER_EXT_CB(
        riscv, extCB, PMACheck,
        extCB->PMACheck(
            riscv, mode, requiredPriv, lowPA, highPA, extCB->clientData
        );
    )
}


////////////////////////////////////////////////////////////////////////////////
// TLB / PMP UPDATE
////////////////////////////////////////////////////////////////////////////////

//
// Map memory virtual addresses in virtual domain to the specified range in the
// corresponding PMP domain
//
static void mapTLBEntry(
    riscvP      riscv,
    Uns64       VA,
    Uns64       GPA,
    tlbEntryP   entry1,
    tlbEntryP   entry2,
    memDomainP  domainV,
    riscvMode   mode,
    memPriv     requiredPriv,
    tlbMapInfoP miP
) {
    memDomainP domainP    = getPMPDomainPriv(riscv, mode, requiredPriv);
    memPriv    priv       = miP->priv;
    Uns64      vmiPageMax = 0x100000000ULL;

    // get stage 1 entry details
    Uns64 lowVA    = getEntryLowVA(entry1);
    Uns64 highVA   = getEntryHighVA(entry1);
    Uns64 ASIDMask = getEntryASIDMask(entry1, mode);
    Uns64 ASID     = getEntrySimASID(entry1);
    Uns64 VAtoPA   = getEntryVAtoPA(entry1);

    // restrict mapping size to VMI maximum (4Gb)
    if(getEntrySize(entry1)>vmiPageMax) {
        lowVA  = miP->lowVA & -vmiPageMax;
        highVA = lowVA + vmiPageMax - 1;
    }

    // combine information from stage 2 if required
    if(entry2) {

        // get stage 2 entry details
        Uns64 lowVA2    = getEntryLowVA(entry2);
        Uns64 highVA2   = getEntryHighVA(entry2);
        Uns64 ASIDMask2 = getEntryASIDMask(entry2, mode);
        Uns64 VAtoPA2   = getEntryVAtoPA(entry2);

        // calculate offsets of translated address from the low and high bounds
        // of stage 1 and stage 2 entries
        Uns64 loDelta1 = VA  - lowVA;
        Uns64 loDelta2 = GPA - lowVA2;
        Uns64 hiDelta1 = highVA  - VA;
        Uns64 hiDelta2 = highVA2 - GPA;

        // adjust lower region bound upwards if stage 2 entry has higher low
        // bound
        if(loDelta1>loDelta2) {
            lowVA += (loDelta1 - loDelta2);
        }

        // adjust upper region bound downwards if stage 2 entry has lower high
        // bound
        if(hiDelta1>hiDelta2) {
            highVA -= (hiDelta1 - hiDelta2);
        }

        // include stage 2 shift to true physical address
        VAtoPA += VAtoPA2;

        // merge ASID masks
        ASIDMask |= ASIDMask2;
    }

    // determine physical bounds of mapped region
    Uns64 lowPA  = lowVA  + VAtoPA;
    Uns64 highPA = highVA + VAtoPA;

    // create virtual mapping
    vmirtAliasMemoryVM(
        domainP, domainV, lowPA, highPA, lowVA, 0, priv, ASIDMask, ASID
    );

    // create mapping for read in HLVX domain if required
    if(riscv->hlvxActive && (priv&MEM_PRIV_X)) {

        memDomainP hlvxDomain = getHLVXDomain(riscv, domainV);

        vmirtAliasMemoryVM(
            domainP, hlvxDomain, lowPA, highPA, lowVA, 0, MEM_PRIV_R,
            ASIDMask, ASID
        );
    }

    // determine physical bounds of original access
    lowPA  = miP->lowVA  + VAtoPA;
    highPA = miP->highVA + VAtoPA;

    // update PMP mapping if required
    mapPMP(riscv, mode, requiredPriv, lowPA, highPA);

    // update PMA mapping if required
    mapPMA(riscv, mode, requiredPriv, lowPA, highPA);

    // indicate entry is mapped in this mode
    entry1->mapped |= getModeMask(mode);

    // indicate mapped range
    miP->lowVA  = lowVA;
    miP->highVA = highVA;
}

//
// Attempt to map a TLB entry for the given stage
//
static tlbEntryP getTLBStageEntry(
    riscvP         riscv,
    riscvTLBId     id,
    riscvMode      mode,
    tlbMapInfoP    miP,
    memAccessAttrs attrs
) {
    // activate the indicated TLB
    riscvTLBId oldTLB = activateTLB(riscv, id);

    // do TLB mapping
    tlbEntryP entry = findOrCreateTLBEntry(riscv, mode, attrs, miP);

    if(entry) {

        // create full simulated ASID (including xstatus bits)
        riscvSimASID simASID = getSimASID(riscv);

        // if the entry was previously mapped with a different simulated ASID,
        // unmap it in affected domains (handles changes in xstatus bits)
        unmapTLBEntryNewASID(riscv, entry, simASID);

        // save full simulated ASID for use when the entry is unmapped
        entry->simASID = simASID;
    }

    // restore previously-active TLB
    deactivateTLB(riscv, oldTLB);

    return entry;
}

//
// Do stage 2 address lookup
//
static tlbEntryP lookupStage2(
    riscvP         riscv,
    Uns64          VA,
    Uns64          GPA,
    riscvMode      mode,
    memPriv        requiredPriv,
    tlbMapInfoP    miP,
    memAccessAttrs attrs
) {
    tlbMapInfo mi2 = {lowVA:GPA, priv:requiredPriv};

    // map second stage TLB entry
    tlbEntryP entry = getTLBStageEntry(riscv, RISCV_TLB_VS2, mode, &mi2, attrs);

    // merge first and second stage access permissions
    if(entry) {
        miP->priv &= (mi2.priv | (MEM_PRIV_USER|MEM_PRIV_ALIGN));
        miP->priv |= (mi2.priv & (MEM_PRIV_USER|MEM_PRIV_ALIGN));
    }

    return entry;
}

//
// Push original privilege and VA if no address translation is active
//
inline static memPriv pushOriginalVAPriv(riscvP riscv, Uns64 VA, memPriv new) {

    memPriv old = riscv->origPriv;

    if(!old) {
        riscv->origPriv = new;
        riscv->s1VA     = VA;
    }

    return old;
}

//
// Pop original privilege state
//
inline static void popOriginalPriv(riscvP riscv, memPriv old) {
    riscv->origPriv = old;
}

//
// Try mapping memory at the passed address for the specified access type and
// return a status code indicating whether the mapping succeeded
//
static Bool tlbMiss(
    riscvP         riscv,
    memDomainP     domain,
    riscvMode      mode,
    tlbMapInfoP    miP,
    memAccessAttrs attrs
) {
    riscvException exception    = riscv->exception;
    riscvTLBId     id           = getCurrentTLBId(riscv, mode);
    memPriv        requiredPriv = miP->priv;
    Uns64          VA           = miP->lowVA;
    Uns64          GPA          = VA;

    // set original access privilege if required
    memPriv oldPriv = pushOriginalVAPriv(riscv, VA, requiredPriv);

    // clear current exception state
    riscv->exception = 0;

    // map the current stage TLB entry
    tlbEntryP entry1 = getTLBStageEntry(riscv, id, mode, miP, attrs);
    tlbEntryP entry2 = 0;

    // map second stage TLB entry if required
    if(entry1 && doStage2(riscv, id)) {

        // determine guest physical address
        GPA = VA + entry1->PA - entry1->lowVA;

        // do stage 2 lookup
        entry2 = lookupStage2(riscv, VA, GPA, mode, requiredPriv, miP, attrs);

        // disable mapping if second stage fails
        if(!entry2) {
            entry1 = 0;
        }
    }

    // create entry mapping if required
    if(entry1) {
        mapTLBEntry(
            riscv, VA, GPA, entry1, entry2, domain, mode, requiredPriv, miP
        );
    }

    // restore previous exception if no exception was generated by the miss
    if(!riscv->exception) {
        riscv->exception = exception;
    }

    // restore original access privilege
    popOriginalPriv(riscv, oldPriv);

    return !entry1;
}

//
// Try mapping memory at the passed address for a guest page table walk and
// return a status code indicating whether the mapping succeeded
//
static Bool tlbMissGPTW(
    riscvP         riscv,
    memDomainP     domain,
    tlbMapInfoP    miP,
    memAccessAttrs attrs
) {
    riscvException exception    = riscv->exception;
    riscvMode      mode         = RISCV_MODE_VS;
    memPriv        requiredPriv = miP->priv;
    Uns64          GPA          = miP->lowVA;

    // set original access privilege if required
    memPriv oldPriv = pushOriginalVAPriv(riscv, GPA, requiredPriv);

    // clear current exception state
    riscv->exception = 0;

    // map the stage 2 TLB entry
    tlbEntryP entry = lookupStage2(
        riscv, GPA, GPA, mode, requiredPriv, miP, attrs
    );

    // create entry mapping if required
    if(entry) {
        mapTLBEntry(riscv, GPA, GPA, entry, 0, domain, mode, requiredPriv, miP);
    }

    // restore previous exception if no exception was generated by the miss
    if(!riscv->exception) {
        riscv->exception = exception;
    }

    // restore original access privilege
    popOriginalPriv(riscv, oldPriv);

    return !entry;
}


////////////////////////////////////////////////////////////////////////////////
// PUBLIC FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// this identifies the domain type that is being accessed
//
typedef enum domainTypeE {
    DT_NONE,    // not a match
    DT_PHYS,    // physical domain
    DT_VIRT,    // virtual domain
    DT_PMP,     // PMP domain
    DT_GPTW     // guest page table walk domain
} domainType;

//
// If the domain is one for the given mode and code/data type, return its class
//
static domainType getDomainType(
    riscvP     riscv,
    memDomainP domain,
    riscvMode  mode,
    Bool       isCode
) {
    domainType dt = DT_NONE;

    if(modeIsVirtual(mode) && !hypervisorPresent(riscv)) {
        // virtualized mode and hypervisor absent
    } else if(domain==getPhysDomainCorD(riscv, mode, isCode)) {
        dt = DT_PHYS;
    } else if(domain==getVirtDomainCorD(riscv, mode, isCode)) {
        dt = DT_VIRT;
    } else if(domain==getPMPDomainCorD(riscv, mode, isCode)) {
        dt = DT_PMP;
    } else if(!isCode && (domain==riscv->guestPTWDomain)) {
        dt = DT_GPTW;
    }

    return dt;
}

//
// Try mapping memory at the passed address for the specified access type and
// return a status code indicating if virtual mapping failed
//
Bool riscvVMMiss(
    riscvP         riscv,
    memDomainP     domain,
    memPriv        requiredPriv,
    Uns64          address,
    Uns32          bytes,
    memAccessAttrs attrs
) {
    Bool       oldHVLX = riscv->hlvxActive;
    Bool       miss    = False;
    domainType dt      = DT_NONE;
    Int32      mode;
    Uns32      isCode;

    // record original VA that might initiate a fault (for syndrome address
    // offset calculation)
    riscv->originalVA = address;

    // start HLVX access if required
    riscv->hlvxActive = startHLVX(riscv, &domain, &requiredPriv);

    // assume any Access Fault error generated here will be a Bus Error
    riscv->AFErrorIn = riscv_AFault_Bus;

    // identify access to a mapped domain
    for(isCode=0; !dt && (isCode<2); isCode++) {

        for(mode=RISCV_MODE_LAST-1; !dt && (mode>=0); mode--) {

            dt = getDomainType(riscv, domain, mode, isCode);

            if(dt==DT_VIRT) {

                // access to virtually-mapped domain
                Uns64      lastVA = address+bytes-1;
                tlbMapInfo mi     = {highVA:address-1};

                // iterate while unprocessed regions remain
                do {

                    mi.lowVA  = mi.highVA+1;
                    mi.highVA = lastVA;
                    mi.priv   = requiredPriv;

                    miss = tlbMiss(riscv, domain, mode, &mi, attrs);

                } while(!miss && ((lastVA<mi.lowVA) || (lastVA>mi.highVA)));

            } else if(dt==DT_GPTW) {

                // access to guest page table walk domain
                Uns64      lastVA = address+bytes-1;
                tlbMapInfo mi     = {highVA:address-1};

                // iterate while unprocessed regions remain
                do {

                    mi.lowVA  = mi.highVA+1;
                    mi.highVA = lastVA;
                    mi.priv   = requiredPriv;

                    miss = tlbMissGPTW(riscv, domain, &mi, attrs);

                } while(!miss && ((lastVA<mi.lowVA) || (lastVA>mi.highVA)));

            } else if(dt) {

                Uns64 lowPA  = address;
                Uns64 highPA = address+bytes-1;

                // update PMP mapping if required (either a physical access or
                // a page table walk using the PMP domain directly)
                mapPMP(riscv, mode, requiredPriv, lowPA, highPA);

                // update PMA mapping if required
                mapPMA(riscv, mode, requiredPriv, lowPA, highPA);
            }
        }
    }

    // indicate HLVX access is inactive
    riscv->hlvxActive = oldHVLX;

    // return value indicates whether this was a TLB miss that has now been
    // resolved
    return miss;
}

//
// Free structures used for virtual memory management
//
void riscvVMFree(riscvP riscv) {

    riscvTLBId id;

    for(id=0; id<RISCV_TLB_LAST; id++) {
        freeTLB(riscv, id);
    }
}

//
// Perform any required memory mapping updates on an ASID change
//
void riscvVMSetASID(riscvP riscv) {
    vmirtSetProcessorASID((vmiProcessorP)riscv, getSimASID(riscv).u64);
}

//
// ASID masks used when deleting entries
//
static const riscvSimASID mskAny  = {{0}};
static const riscvSimASID mskVMID = {f:{VMID:-1}};
static const riscvSimASID mskASID = {f:{ASID_HS:-1,ASID_VS:-1}};

//
// Invalidate entries, VMID=*, ASID=*, address=*
//
static void invalidate_VMx_ASx_ADx(riscvP riscv, riscvTLBId id) {
    deleteTLBEntriesMask(riscv, id, 0, RISCV_MAX_ADDR, mskAny, 0, 0);
}

//
// Invalidate entries, VMID=*, ASID=*, address=AD
//
static void invalidate_VMx_ASx_AD1(riscvP riscv, Uns64 AD, riscvTLBId id) {
    deleteTLBEntriesMask(riscv, id, AD, AD, mskAny, 0, 0);
}

//
// Invalidate entries, VMID=VMID, ASID=*, address=*
//
static void invalidate_VM1_ASx_ADx(riscvP riscv, Uns32 VMID, riscvTLBId id) {
    deleteTLBEntriesMask(riscv, id, 0, RISCV_MAX_ADDR, mskVMID, VMID, 0);
}

//
// Invalidate entries, VMID=VMID, ASID=*, address=AD
//
static void invalidate_VM1_ASx_AD1(riscvP riscv, Uns32 VMID, Uns64 AD, riscvTLBId id) {
    deleteTLBEntriesMask(riscv, id, AD, AD, mskVMID, VMID, 0);
}

//
// Invalidate entries, VMID=active, ASID=*, address=*
//
static void invalidate_VMC_ASx_ADx(riscvP riscv, riscvTLBId id) {
    deleteTLBEntriesMaskActiveVMID(riscv, id, 0, RISCV_MAX_ADDR, mskAny, 0);
}

//
// Invalidate entries, VMID=active, ASID=ASID, address=*
//
static void invalidate_VMC_AS1_ADx(riscvP riscv, Uns32 ASID, riscvTLBId id) {
    deleteTLBEntriesMaskActiveVMID(riscv, id, 0, RISCV_MAX_ADDR, mskASID, ASID);
}

//
// Invalidate entries, VMID=active, ASID=*, address=AD
//
static void invalidate_VMC_ASx_AD1(riscvP riscv, Uns64 AD, riscvTLBId id) {
    deleteTLBEntriesMaskActiveVMID(riscv, id, AD, AD, mskAny, 0);
}

//
// Invalidate entries, VMID=active, ASID=ASID, address=AD
//
static void invalidate_VMC_AS1_AD1(riscvP riscv, Uns32 ASID, Uns64 AD, riscvTLBId id) {
    deleteTLBEntriesMaskActiveVMID(riscv, id, AD, AD, mskASID, ASID);
}

//
// Invalidate entire TLB
//
void riscvVMInvalidateAll(riscvP riscv) {
    invalidate_VMC_ASx_ADx(riscv, getS1TLBId(riscv));
}

//
// Invalidate entire TLB with matching ASID
//
void riscvVMInvalidateAllASID(riscvP riscv, Uns32 ASID) {
    invalidate_VMC_AS1_ADx(riscv, ASID, getS1TLBId(riscv));
}

//
// Invalidate TLB entries for the given address
//
void riscvVMInvalidateVA(riscvP riscv, Uns64 VA) {
    invalidate_VMC_ASx_AD1(riscv, VA, getS1TLBId(riscv));
}

//
// Invalidate TLB entries with matching address and ASID
//
void riscvVMInvalidateVAASID(riscvP riscv, Uns64 VA, Uns32 ASID) {
    invalidate_VMC_AS1_AD1(riscv, ASID, VA, getS1TLBId(riscv));
}

//
// Invalidate entire virtual stage 1 TLB
//
void riscvVMInvalidateAllV(riscvP riscv) {
    invalidate_VMC_ASx_ADx(riscv, RISCV_TLB_VS1);
}

//
// Invalidate entire virtual stage 1 TLB with matching ASID
//
void riscvVMInvalidateAllASIDV(riscvP riscv, Uns32 ASID) {
    invalidate_VMC_AS1_ADx(riscv, ASID, RISCV_TLB_VS1);
}

//
// Invalidate virtual stage 1 TLB entries for the given address
//
void riscvVMInvalidateVAV(riscvP riscv, Uns64 VA) {
    invalidate_VMC_ASx_AD1(riscv, VA, RISCV_TLB_VS1);
}

//
// Invalidate virtual stage 1 TLB entries with matching address and ASID
//
void riscvVMInvalidateVAASIDV(riscvP riscv, Uns64 VA, Uns32 ASID) {
    invalidate_VMC_AS1_AD1(riscv, ASID, VA, RISCV_TLB_VS1);
}

//
// Invalidate entire virtual stage 2 TLB
//
void riscvVMInvalidateAllG(riscvP riscv) {
    invalidate_VMx_ASx_ADx(riscv, RISCV_TLB_VS2);
}

//
// Invalidate entire virtual stage 2 TLB with matching VMID
//
void riscvVMInvalidateAllVMIDG(riscvP riscv, Uns32 VMID) {
    invalidate_VM1_ASx_ADx(riscv, VMID, RISCV_TLB_VS2);
}

//
// Invalidate virtual stage 2 TLB entries for the given address
//
void riscvVMInvalidateVAG(riscvP riscv, Uns64 GPAsh2) {
    invalidate_VMx_ASx_AD1(riscv, GPAsh2<<2, RISCV_TLB_VS2);
}

//
// Invalidate virtual stage 2 TLB entries with matching address and VMID
//
void riscvVMInvalidateVAVMIDG(riscvP riscv, Uns64 GPAsh2, Uns32 VMID) {
    invalidate_VM1_ASx_AD1(riscv, VMID, GPAsh2<<2, RISCV_TLB_VS2);
}

//
// Update load/store domain so that accesses are performed as if in the given
// mode
//
static void updateLdStDomainMode(riscvP riscv, riscvMode mode) {

    memDomainP domain = 0;
    Bool       V      = modeIsVirtual(mode);
    Bool       VM     = False;

    // determine whether virtual memory is enabled in the target mode
    if(mode==RISCV_MODE_M) {
        // no action
    } else if(RD_CSR_FIELD_V(riscv, satp, V, MODE)) {
        VM = True;
    } else if(V && RD_CSR_FIELD_S(riscv, hgatp, MODE)) {
        VM = True;
    }

    // record data access mode (affects endianness)
    riscv->dataMode = mode;

    // look for virtual domain for this mode if required
    if(VM) {
        domain = getVirtDomainCorD(riscv, mode, False);
    }

    // look for physical domain for this mode if MMU is not enabled or the
    // domain is not VM-managed
    if(!domain) {
        domain = getPhysDomainCorD(riscv, mode, False);
    }

    // allow derived model to update data domain
    ITER_EXT_CB(
        riscv, extCB, setDomainNotifier,
        extCB->setDomainNotifier(riscv, &domain, extCB->clientData)
    )

    // switch to the indicated domain if it is not current
    if(domain && (domain!=vmirtGetProcessorDataDomain((vmiProcessorP)riscv))) {
        vmirtSetProcessorDataDomain((vmiProcessorP)riscv, domain);
    }
}

//
// Refresh the current data domain to reflect current mstatus.MPRV setting
//
void riscvVMRefreshMPRVDomain(riscvP riscv) {

    riscvMode mode = getCurrentMode5(riscv);

    // if mstatus.MPRV is set, use that mode
    if(getMPRV(riscv)) {

        // get raw value of mstatus.MPP
        riscvMode modeMPP = getMPP(riscv);

        // clamp to implemented mode
        if(!riscvHasMode(riscv, modeMPP)) {
            modeMPP = riscvGetMinMode(riscv);
        }

        // if modeMPP > mode, this is suspicious
        if(modeMPP > mode) {
            vmiMessage("W", CPU_PREFIX "_SMPPM",
                SRCREF_FMT "Suspicious execution in %s mode with mstatus.MPRV=1 "
                "and mstatus.MPP=%u (indicating %s mode)",
                SRCREF_ARGS(riscv, getPC(riscv)),
                riscvGetModeName(mode),
                modeMPP,
                riscvGetModeName(modeMPP)
            );
        }

        // include previous virtual mode setting
        if(modeMPP==RISCV_MODE_M) {
            // no action
        } else if(RD_CSR_FIELD64(riscv, mstatus, MPV)) {
            modeMPP |= RISCV_MODE_V;
        }

        mode = modeMPP;
    }

    // update load/store domain so that accesses are performed as if in the
    // given mode
    updateLdStDomainMode(riscv, mode);
}


////////////////////////////////////////////////////////////////////////////////
// LINKED MODEL TLB SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Create a new TLB entry
//
RISCV_NEW_TLB_ENTRY_FN(riscvVMNewTLBEntry) {

    // get TLB to modify
    riscvTLBP tlb = riscv->tlb[tlbId];

    if(tlb) {

        // prepare template entry
        tlbEntry tmp = {
            tlb     : tlbId,
            custom  : True,
            entryId : mapping.entryId,
            lowVA   : mapping.lowVA,
            highVA  : mapping.highVA,
            PA      : mapping.PA,
            priv    : mapping.priv,
            V       : mapping.V,
            U       : mapping.U,
            G       : mapping.G,
            A       : mapping.A,
            D       : mapping.D
        };

        // allocate true entry
        allocateTLBEntry(riscv, tlb, &tmp, MEM_AA_TRUE);
    }
}

//
// Free an old TLB entry
//
RISCV_FREE_TLB_ENTRY_FN(riscvVMFreeTLBEntry) {

    riscvTLBP tlb = riscv->tlb[tlbId];

    if(tlb) {
        ITER_TLB_ENTRY_RANGE(
            riscv, tlb, 0, RISCV_MAX_ADDR, entry,
            if(entry->entryId==entryId) {
                deleteTLBEntry(riscv, tlb, entry);
            }
        );
    }
}


////////////////////////////////////////////////////////////////////////////////
// TLB SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

#define RISCV_TLB_ENTRY  "TLB_ENTRY"
#define RISCV_TLB_END    "TLB_END"
#define RISCV_ASID_CACHE "ASIDCache"

//
// Save contents of one TLB entry
//
static void saveTLBEntry(vmiSaveContextP cxt, tlbEntryP entry) {

    // save entry
    tlbEntry entryS = *entry;

    // clear down properties used to manage mapping
    entryS.mapped   = 0;
    entryS.lutEntry = 0;

    vmirtSaveElement(
        cxt, RISCV_TLB_ENTRY, RISCV_TLB_END, &entryS, sizeof(entryS)
    );
}

//
// Restore contents of one TLB entry
//
static void restoreTLBEntry(riscvP riscv, riscvTLBP tlb, tlbEntryP new) {

    tlbEntryP entry = newTLBEntry(tlb);

    // copy entry contents
    *entry = *new;

    // insert it into the processor TLB table
    insertTLBEntry(riscv, tlb, entry);
}

//
// Return the size in bytes ofthe ASID cache
//
inline static Uns32 ASIDCacheBytes(riscvTLBP tlb) {
    return tlb->ASIDCacheSize*sizeof(tlb->ASIDCache[0]);
}

//
// Save contents of the TLB
//
static void saveTLB(riscvP riscv, riscvTLBP tlb, vmiSaveContextP cxt) {

    // save all non-artifact TLB entries
    ITER_TLB_ENTRY_RANGE(
        riscv, tlb, 0, RISCV_MAX_ADDR, entry,
        if(!entry->artifact) {
            saveTLBEntry(cxt, entry);
        }
    );

    // save terminator
    vmirtSaveElement(cxt, RISCV_TLB_ENTRY, RISCV_TLB_END, 0, 0);

    // save ASID cache
    VMIRT_SAVE_FIELD(cxt, tlb, ASIDCacheSize);
    vmirtSave(cxt, RISCV_ASID_CACHE, tlb->ASIDCache, ASIDCacheBytes(tlb));
    VMIRT_SAVE_FIELD(cxt, tlb, ASIDICount);
    VMIRT_SAVE_FIELD(cxt, tlb, ASIDEjectNum);
}

//
// Restore contents of the TLB
//
static void restoreTLB(riscvP riscv, riscvTLBP tlb, vmiRestoreContextP cxt) {

    tlbEntry new;

    // restore all TLB entries
    while(
        vmirtRestoreElement(
            cxt, RISCV_TLB_ENTRY, RISCV_TLB_END, &new, sizeof(new)
        ) == SRS_OK
    ) {
        restoreTLBEntry(riscv, tlb, &new);
    }

    // restore ASID cache
    freeASIDCache(tlb);
    VMIRT_RESTORE_FIELD(cxt, tlb, ASIDCacheSize);
    tlb->ASIDCache = newASIDCache(tlb->ASIDCacheSize);
    vmirtRestore(cxt, RISCV_ASID_CACHE, tlb->ASIDCache, ASIDCacheBytes(tlb));
    VMIRT_RESTORE_FIELD(cxt, tlb, ASIDICount);
    VMIRT_RESTORE_FIELD(cxt, tlb, ASIDEjectNum);
}

//
// Save VM state
//
static void saveVM(riscvP riscv, vmiSaveContextP cxt) {

    riscvTLBId id;

    for(id=0; id<RISCV_TLB_LAST; id++) {

        riscvTLBP tlb = riscv->tlb[id];

        if(tlb) {
            saveTLB(riscv, tlb, cxt);
        }
    }
}

//
// Restore VM state
//
static void restoreVM(riscvP riscv, vmiRestoreContextP cxt) {

    riscvTLBId id;

    for(id=0; id<RISCV_TLB_LAST; id++) {

        riscvTLBP tlb = riscv->tlb[id];

        if(tlb) {
            invalidateTLB(riscv, id);
            restoreTLB(riscv, tlb, cxt);
        }
    }
}

//
// Save VM state not covered by register read/write API
//
void riscvVMSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
) {
    if(phase==SRT_END_CORE) {
        saveVM(riscv, cxt);
    }
}

//
// Restore VM state not covered by register read/write API
//
void riscvVMRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
) {
    if(phase==SRT_END_CORE) {
        restoreVM(riscv, cxt);
    }
}


