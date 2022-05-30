/*
 * Copyright (c) 2005-2022 Imperas Software Ltd., www.imperas.com
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
#include "riscvCLINT.h"
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


////////////////////////////////////////////////////////////////////////////////
// UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Return privilege name for the given privilege
//
static const char *privName(Uns32 priv) {

    static const char *map[] = {
        "---", "r--", "-w-", "rw-", "--x", "r-x", "-wx", "rwx"
    };

    // return name ignoring alignment and user-defined constraints
    return map[priv&MEM_PRIV_RWX];
}

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
// Return current program counter
//
inline static Uns64 getPC(riscvP riscv) {
    return vmirtGetPC((vmiProcessorP)riscv);
}

//
// Return the number of implemented PMP regions
//
inline static Uns32 getNumPMPs(riscvP riscv) {
    return riscv->configInfo.PMP_registers;
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
// Is code domain required for the passed privilege?
//
inline static Bool isFetch(memPriv priv) {
    return (priv & MEM_PRIV_X) && True;
}

//
// Return the physical memory domain to use for the passed code/data access
//
static memDomainP getPhysDomainCorD(riscvP riscv, riscvMode mode, Bool isCode) {
    return riscv->physDomains[mode][isCode];
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
static Bool pmpLocked(riscvP riscv, Uns8 index) {
    return (
        !riscv->artifactAccess &&
        !RD_CSR_FIELDC(riscv, mseccfg, RLB) &&
        getPMPCFGElem(riscv,index).L
    );
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
        // is not on an 8-byte boundary
        if((update&PMPU_LO) && (lo>loMin) && (unalignedOK || (lo&7))) {
            vmirtProtectMemory(domain, lo-1, lo-1, MEM_PRIV_NONE, MEM_PRIV_SET);
        }

        // protect adjacent high byte if unaligned accesses are allowed or it
        // is not on an 8-byte boundary
        if((update&PMPU_HI) && (hi<hiMax) && (unalignedOK || ((hi+1)&7))) {
            vmirtProtectMemory(domain, hi+1, hi+1, MEM_PRIV_NONE, MEM_PRIV_SET);
        }
    }
}

//
// Set privileges for the given range in PMP domain for the given mode, or, if
// update does not include PMPU_SET_PRIV, only remove permissions on adjacent
// regions
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
            privName(priv), low, high, riscvGetModeName(getBaseMode(mode))
        );
    }

    if(dataDomain==codeDomain) {

        // set permissions in unified domain
        pmpProtect(riscv, dataDomain, low, high, priv, update);

    } else {

        // get privileges for data and code domains (NOTE: include RW
        // permissions in code domain to allow application load)
        memPriv privRW = priv&MEM_PRIV_RW ? priv&~MEM_PRIV_X : MEM_PRIV_NONE;
        memPriv privX  = priv&MEM_PRIV_X  ? priv             : MEM_PRIV_NONE;

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
// Set privileges for a single byte in PMP domain for the given mode, or, if
// update does not include PMPU_SET_PRIV, only remove permissions on adjacent
// regions
//
inline static void setPMPPrivB(
    riscvP    riscv,
    riscvMode mode,
    Uns64     addr,
    memPriv   priv,
    pmpUpdate update
) {
    setPMPPriv(riscv, mode, addr, addr, priv, update);
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
    }

    // assign results
    *lowP  = low;
    *highP = high;
}

//
// Is the PMP entry used in M mode?
//
static Bool usePMPEntryMMode(riscvP riscv, pmpcfgElem e) {
    return RD_CSR_FIELDC(riscv, mseccfg, MML) || e.L;
}

//
// mseccfg.MML=1 privilege table, M-mode, pmpcfg.L=0
//
static const memPriv mapMML1ML0[] = {
    [MEM_PRIV_NONE] = MEM_PRIV_NONE,
    [MEM_PRIV_R]    = MEM_PRIV_NONE,
    [MEM_PRIV_RW]   = MEM_PRIV_NONE,
    [MEM_PRIV_RX]   = MEM_PRIV_NONE,
    [MEM_PRIV_X]    = MEM_PRIV_NONE,
    [MEM_PRIV_RWX]  = MEM_PRIV_NONE,
    [MEM_PRIV_W]    = MEM_PRIV_RW,
    [MEM_PRIV_WX]   = MEM_PRIV_RW,
};

//
// mseccfg.MML=1 privilege table, M-mode, pmpcfg.L=1
//
static const memPriv mapMML1ML1[] = {
    [MEM_PRIV_NONE] = MEM_PRIV_NONE,
    [MEM_PRIV_R]    = MEM_PRIV_R,
    [MEM_PRIV_RW]   = MEM_PRIV_RW,
    [MEM_PRIV_RX]   = MEM_PRIV_RX,
    [MEM_PRIV_X]    = MEM_PRIV_X,
    [MEM_PRIV_RWX]  = MEM_PRIV_R,
    [MEM_PRIV_W]    = MEM_PRIV_X,
    [MEM_PRIV_WX]   = MEM_PRIV_RX,
};

//
// mseccfg.MML=1 privilege table, S-mode, pmpcfg.L=0
//
static const memPriv mapMML1SL0[] = {
    [MEM_PRIV_NONE] = MEM_PRIV_NONE,
    [MEM_PRIV_R]    = MEM_PRIV_R,
    [MEM_PRIV_RW]   = MEM_PRIV_RW,
    [MEM_PRIV_RX]   = MEM_PRIV_RX,
    [MEM_PRIV_X]    = MEM_PRIV_X,
    [MEM_PRIV_RWX]  = MEM_PRIV_RWX,
    [MEM_PRIV_W]    = MEM_PRIV_R,
    [MEM_PRIV_WX]   = MEM_PRIV_RW,
};

//
// mseccfg.MML=1 privilege table, S-mode, pmpcfg.L=1
//
static const memPriv mapMML1SL1[] = {
    [MEM_PRIV_NONE] = MEM_PRIV_NONE,
    [MEM_PRIV_R]    = MEM_PRIV_NONE,
    [MEM_PRIV_RW]   = MEM_PRIV_NONE,
    [MEM_PRIV_RX]   = MEM_PRIV_NONE,
    [MEM_PRIV_X]    = MEM_PRIV_NONE,
    [MEM_PRIV_RWX]  = MEM_PRIV_R,
    [MEM_PRIV_W]    = MEM_PRIV_X,
    [MEM_PRIV_WX]   = MEM_PRIV_X,
};

//
// Return the access privilege of the PMP entry in the given mode
//
static memPriv getPMPEntryPriv(riscvP riscv, riscvMode mode, pmpcfgElem e) {

    Bool    isM = (mode==RISCV_MODE_M);
    memPriv priv;

    if(!RD_CSR_FIELDC(riscv, mseccfg, MML)) {

        // restrict privilege using PMP region constraints if required
        priv = (!isM || e.L) ? e.priv : MEM_PRIV_RWX;

        // combination R=0 and W=1 is reserved for future use
        if(!(priv&MEM_PRIV_R)) {
            priv &= ~MEM_PRIV_W;
        }

    } else if(isM && !e.L) {

        // Machine mode access, pmpcfg.L=0
        priv = mapMML1ML0[e.priv];

    } else if(isM) {

        // Machine mode access, pmpcfg.L=1
        priv = mapMML1ML1[e.priv];

    } else if(!e.L) {

        // User/Supervisor mode access, pmpcfg.L=0
        priv = mapMML1SL0[e.priv];

    } else {

        // User/Supervisor mode access, pmpcfg.L=1
        priv = mapMML1SL1[e.priv];
    }

    return priv;
}

//
// Are any lower-priority PMP entries than the indexed entry used in M mode?
//
static Bool useLowerPriorityPMPEntryMMode(riscvP riscv, Uns32 index) {

    Uns32 numRegs = getNumPMPs(riscv);
    Uns32 i;

    for(i=index+1; i<numRegs; i++) {

        pmpcfgElem e = getPMPCFGElem(riscv, i);

        if((e.mode!=PMPM_OFF) && usePMPEntryMMode(riscv, e)) {
            return True;
        }
    }

    return False;
}

//
// Does any extension implement a function that can override privileges for a
// PMP region?
//
static Bool hasPMPPrivCB(riscvP riscv) {

    riscvPMPPrivFn result = 0;

    ITER_EXT_CB_WHILE(riscv, extCB, PMPPriv, !result, result=extCB->PMPPriv)

    return result;
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

            pmpUpdate updateS = PMPU_SET_PRIV;
            pmpUpdate updateM = PMPU_LO|PMPU_HI;

            // remove access in Supervisor address space
            setPMPPriv(riscv, RISCV_MODE_S, low, high, MEM_PRIV_NONE, updateS);

            // default behavior in Machine mode is to remove access on adjacent
            // regions only, but access is instead removed for this region if
            // the entry is used in Machine mode or if any lower-priority entry
            // is used in Machine mode (enabling or disabling this region may
            // reveal or conceal that region) or a derived model can refine PMP
            // region privileges
            if(
                usePMPEntryMMode(riscv, e) ||
                useLowerPriorityPMPEntryMMode(riscv, index) ||
                hasPMPPrivCB(riscv)
            ) {
                updateM = PMPU_SET_PRIV;
            }

            // remove access in Machine address space
            setPMPPriv(riscv, RISCV_MODE_M, low, high, MEM_PRIV_NONE, updateM);
        }
    }
}

//
// If the PMP entry is a TOR entry, invalidate it
//
static void invalidatePMPEntryTOR(riscvP riscv, Uns32 index) {

    if(index==getNumPMPs(riscv)) {
        // index out of range
    } else if(getPMPCFGElem(riscv, index).mode==PMPM_TOR) {
        invalidatePMPEntry(riscv, index);
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
// Return romask for the pmpaddr register
//
static Uns64 getPMPAddrROMask(riscvP riscv, Uns32 index) {
    CSR_REG_TYPE(romask_pmpaddr) *romasks = &riscv->configInfo.csrMask.romask_pmpaddr0;
    return romasks[index].u64.bits;
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
        union {Uns64 u64; Uns8 u8[8];} src    = {u64 : newValue&WM64_pmpcfg&mask};

        // invalidate any modified entries in lowest-to-highest priority order
        // (required so that useLowerPriorityPMPEntryMMode always returns valid
        // results)
        for(i=entriesPerCFG-1; i>=0; i--) {

            Uns32 cfgIndex = (index*4)+i;
            Uns8 *dstP     = &riscv->pmpcfg.u8[cfgIndex];
            Uns8  romask   = riscv->romask_pmpcfg.u8[cfgIndex];
            Bool  resR0W1  = False;

            // get old (dst) and new (src) values and read only bit mask
            pmpcfgElem srcCFG = {u8:src.u8[i]};
            pmpcfgElem dstCFG = {u8:*dstP};

            // retain existing values for read-only bits
            srcCFG.u8 = (srcCFG.u8 & ~romask) | (dstCFG.u8 & romask);

            if(!RISCV_SMEPMP_VERSION(riscv)) {

                // combination R=0 and W=1 is reserved for future use if Smepmp
                // is not implemented
                resR0W1 = True;

            } else if(riscv->artifactAccess) {

                // allow all pmpcfg values to be written

            } else if(!RD_CSR_FIELDC(riscv, mseccfg, MML)) {

                // combination R=0 and W=1 is reserved for future use if
                // mseccfg.MML=0
                resR0W1 = True;

            } else if(srcCFG.L && !RD_CSR_FIELDC(riscv, mseccfg, RLB)) {

                // no new locked rules with executable privileges may be added
                // unless mseccfg.RLB is set
                memPriv priv = mapMML1ML1[srcCFG.priv];

                // if executable, write is ignored, leaving pmpcfg unchanged
                if(priv&MEM_PRIV_X) {
                    srcCFG = dstCFG;
                }
            }

            // reserved combination masks W bit if R bit is clear
            if(resR0W1 && !(srcCFG.priv&MEM_PRIV_R)) {
                srcCFG.priv &= ~MEM_PRIV_W;
            }

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

    Uns64 result   = 0;
    Uns32 G        = riscv->configInfo.PMP_grain;

    // mask writable bits to implemented external bits
    newValue &= (getAddressMask(riscv->extBits) >> 2);

    // also mask writable bits if grain is set
    if(G) {
        newValue &= (-1ULL << (G-1));
    }

    if(validPMPAddr(riscv, index)) {

        Uns64 oldValue = riscv->pmpaddr[index];
        Uns64 romask   = getPMPAddrROMask(riscv, index);

        // retain existing values for read-only bits
        newValue = (newValue & ~romask) | (oldValue & romask);

        if (riscv->pmpaddr[index]!=newValue) {

            if(pmpLocked(riscv, index)) {

                // entry index is locked

            } else if(pmpLockedTOR(riscv, index+1)) {

                // next entry is a locked TOR entry

            } else {

                // invalidate entry using its original specification
                invalidatePMPEntry(riscv, index);
                invalidatePMPEntryTOR(riscv, index+1);

                // set new value
                riscv->pmpaddr[index] = newValue;

                // invalidate entry using its new specification
                invalidatePMPEntry(riscv, index);
                invalidatePMPEntryTOR(riscv, index+1);
            }

            result = getEffectivePMPAddr(riscv, index);
        }
    }

    return result;
}

//
// Are any PMP entries locked?
//
Bool riscvVMAnyPMPLocked(riscvP riscv) {

    Uns32 numRegs = getNumPMPs(riscv);
    Uns32 i;

    for(i=0; i<numRegs; i++) {
        if(pmpLocked(riscv, i)) {
            return True;
        }
    }

    return False;
}

//
// Unmap all PMP entries
//
void riscvVMUnmapAllPMP(riscvP riscv) {
    setPMPPriv(riscv, RISCV_MODE_M, 0, -1, MEM_PRIV_NONE, PMPU_SET_PRIV);
    setPMPPriv(riscv, RISCV_MODE_S, 0, -1, MEM_PRIV_NONE, PMPU_SET_PRIV);
}

//
// Reset PMP unit
//
void riscvVMResetPMP(riscvP riscv) {

    Uns32                  numRegs    = getNumPMPs(riscv);
    Uns32                  numCfgRegs = ((numRegs + 3) / 4);
    CSR_REG_TYPE(pmpaddr) *cfgPmpaddr = &riscv->configInfo.csr.pmpaddr0;
    CSR_REG_TYPE(pmpcfg)  *cfgPmpcfg  = &riscv->configInfo.csr.pmpcfg0;
    CSR_REG_TYPE(pmpcfg)  *cfgRomask  = &riscv->configInfo.csrMask.romask_pmpcfg0;
    Uns32                  i;

    for(i=0; i<numRegs; i++) {

        if(riscv->pmpaddr[i] || riscv->pmpcfg.u8[i]) {

            // invalidate entry using its current specification
            invalidatePMPEntry(riscv, i);

        }

        // reset pmpaddr to reset values from configInfo
        riscv->pmpaddr[i] = cfgPmpaddr[i].u64.bits;
    }

    // reset pmpcfg to reset values from configInfo
    if (isPMP64(riscv)) {
        for (i = 0; i < numCfgRegs; i += 2) {
            riscv->pmpcfg.u64[i/2]        = cfgPmpcfg[i].u64.bits;
            riscv->romask_pmpcfg.u64[i/2] = cfgRomask[i].u64.bits;
        }
    } else {
        for (i = 0; i < numCfgRegs; i++) {
            riscv->pmpcfg.u32[i] = cfgPmpcfg[i].u32.bits;
            riscv->romask_pmpcfg.u32[i] = cfgRomask[i].u32.bits;
        }
    }
}

//
// Unmap PMP region with the given index
//
void riscvVMUnmapPMPRegion(riscvP riscv, Uns32 regionIndex) {
    invalidatePMPEntry(riscv, regionIndex);
}

//
// Structure holding range and privilege information for a PMP-mapped address
//
typedef struct PMPMapS {
    Uns64   lowPA;
    Uns64   highPA;
    memPriv priv;
} PMPMap, *PMPMapP;

//
// Update the bounds in lowPAP/highPAP and privilege to reflect the effect of
// region i
//
static void refinePMPRegionRange(
    riscvP    riscv,
    riscvMode mode,
    PMPMapP   map,
    Uns64     PA,
    Uns32     index
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
            map->lowPA  = lowPAEntry;
            map->highPA = highPAEntry;

            // get standard access privilege
            memPriv priv = getPMPEntryPriv(riscv, mode, e);

            // refine privilege using derived model constraints if required
            ITER_EXT_CB(
                riscv, extCB, PMPPriv,
                priv = extCB->PMPPriv(riscv, priv, index, extCB->clientData);
            )

            map->priv = priv;

        } else if((lowPAEntry>PA) && (lowPAEntry<map->highPA)) {

            // remove part of region ABOVE matching address
            map->highPA = lowPAEntry-1;

        } else if((highPAEntry<PA) && (highPAEntry>map->lowPA)) {

            // remove part of region BELOW matching address
            map->lowPA = highPAEntry+1;
        }
    }
}

//
// This defines the maximum number of PMP regions that can be straddled by a
// single access
//
#define MAX_PMP_STRADDLE_NUM 3

//
// Return PMP privileges for regions with no match
//
static memPriv getPMPUnmatchedPriv(riscvP riscv, riscvMode mode) {

    memPriv priv;

    if(mode!=RISCV_MODE_M) {
        priv = MEM_PRIV_NONE;
    } else if(RD_CSR_FIELDC(riscv, mseccfg, MMWP)) {
        priv = MEM_PRIV_NONE;
    } else if(RD_CSR_FIELDC(riscv, mseccfg, MML)) {
        priv = MEM_PRIV_RW;
    } else {
        priv = MEM_PRIV_RWX;
    }

    return priv;
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

        Uns64   thisPA  = lowPA;
        Uns64   maxPA   = getAddressMask(riscv->extBits);
        memPriv priv    = getPMPUnmatchedPriv(riscv, mode);
        Bool    aligned = !(lowPA & (highPA-lowPA));
        Uns32   mapNum  = 0;
        Bool    mapDone = False;
        Bool    mapBad  = False;
        PMPMap  maps[MAX_PMP_STRADDLE_NUM];

        // continue while regions remain unprocessed and no PMP fault pending
        while(!mapDone && !mapBad) {

            // get next PMP region
            PMPMapP map = &maps[mapNum++];
            Int32   i;

            // sanity check the number of PMP regions strddled
            VMI_ASSERT(
                mapNum<=MAX_PMP_STRADDLE_NUM,
                "access 0x"FMT_Ax":0x"FMT_Ax" straddling too many PMP regions",
                lowPA, highPA
            );

            // fill PMP region constraints
            map->lowPA  = 0;
            map->highPA = maxPA;
            map->priv   = priv;

            // handle all regions in lowest-to-highest priority order
            for(i=numRegs-1; i>=0; i--) {
                refinePMPRegionRange(riscv, mode, map, thisPA, i);
            }

            // validate region bounds and access privileges
            mapBad = (
                (thisPA < map->lowPA) ||
                (thisPA > map->highPA) ||
                ((map->priv&requiredPriv) != requiredPriv)
            );

            // prepare for next iteration if required
            mapDone = (map->highPA>=highPA);
            thisPA  = map->highPA+1;
        }

        // handle accesses that straddle multiple regions
        if(mapNum==1) {

            // no action if a single region matches

        } else if(aligned) {

            // aligned accesses may not straddle PMP regions
            mapBad = True;

        } else if(!riscv->configInfo.PMP_decompose) {

            // unaligned accesses are not decomposed
            mapBad = True;
        }

        if(mapBad) {

            // invalid permissions or access straddling multiple regions
            riscv->AFErrorIn = riscv_AFault_PMP;

        } else {

            Uns32 i;

            // install region mappings
            for(i=0; i<mapNum; i++) {

                PMPMapP   map       = &maps[i];
                pmpUpdate update    = PMPU_SET_PRIV;
                Uns64     lowClamp  = map->lowPA;
                Uns64     highClamp = map->highPA;

                // clamp physical range to maximum page size
                riscvClampPage(riscv, lowPA, highPA, &lowClamp, &highClamp);

                // determine whether region straddle alignment check is required
                // at low and high region bound (only if bounds have *not* been
                // clamped for regions at the limits of the access)
                if((i==0) && (lowClamp==map->lowPA)) {
                    update |= PMPU_LO;
                }
                if((i==(mapNum-1)) && (highClamp==map->highPA)) {
                    update |= PMPU_HI;
                }

                // update PMP privileges
                setPMPPriv(riscv, mode, lowClamp, highClamp, map->priv, update);
            }

            // for unaligned accesses that straddle regions, protect adjacent
            // bytes so that subsequent aligned 8-byte accesses will still fail
            if(mapNum>1) {

                pmpUpdate update = PMPU_SET_PRIV;
                Uns64     r0High = maps[0].highPA;
                Uns64     rNLow  = maps[mapNum-1].lowPA;

                // handle access less than 4 bytes in first region
                if((r0High-lowPA)<3) {
                    setPMPPrivB(riscv, mode, r0High-3, MEM_PRIV_NONE, update);
                }

                // handle access less than 4 bytes in last region
                if((highPA-rNLow)<3) {
                    setPMPPrivB(riscv, mode, rNLow+3, MEM_PRIV_NONE, update);
                }
            }
        }
    }
}

//
// Allocate PMP structures
//
void riscvVMNewPMP(riscvP riscv) {

    Uns32 numRegs = getNumPMPs(riscv);

    if(numRegs) {
        Uns32 numUns64Regs = (numRegs+7)/8;
        riscv->pmpcfg.u64        = STYPE_CALLOC_N(Uns64, numUns64Regs);
        riscv->romask_pmpcfg.u64 = STYPE_CALLOC_N(Uns64, numUns64Regs);
        riscv->pmpaddr           = STYPE_CALLOC_N(Uns64, numRegs);
    }
}

//
// Free PMP structures
//
void riscvVMFreePMP(riscvP riscv) {

    if(riscv->pmpcfg.u64) {
        STYPE_FREE(riscv->pmpcfg.u64);
    }
    if(riscv->romask_pmpcfg.u64) {
        STYPE_FREE(riscv->romask_pmpcfg.u64);
    }
    if(riscv->pmpaddr) {
        STYPE_FREE(riscv->pmpaddr);
    }
}


////////////////////////////////////////////////////////////////////////////////
// PMP SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

#define PMP_CFG    "PMP_CFG"
#define PMP_CFG_RO "PMP_CFG_RO"
#define PMP_ADDR   "PMP_ADDR"

//
// Save PMP structures
//
void savePMP(riscvP riscv, vmiSaveContextP cxt) {

    Uns32 numRegs = getNumPMPs(riscv);
    Uns32 i;

    for(i=0; i<numRegs; i++) {
        VMIRT_SAVE_REG(cxt, PMP_CFG,    &riscv->pmpcfg.u8[i]);
        VMIRT_SAVE_REG(cxt, PMP_CFG_RO, &riscv->romask_pmpcfg.u8[i]);
        VMIRT_SAVE_REG(cxt, PMP_ADDR,   &riscv->pmpaddr[i]);
    }
}

//
// Resrore PMP structures
//
void restorePMP(riscvP riscv, vmiRestoreContextP cxt) {

    Uns32 numRegs = getNumPMPs(riscv);
    Uns32 i;

    for(i=0; i<numRegs; i++) {
        invalidatePMPEntry(riscv, i);
        VMIRT_RESTORE_REG(cxt, PMP_CFG,    &riscv->pmpcfg.u8[i]);
        VMIRT_RESTORE_REG(cxt, PMP_CFG_RO, &riscv->romask_pmpcfg.u8[i]);
        VMIRT_RESTORE_REG(cxt, PMP_ADDR,   &riscv->pmpaddr[i]);
    }
}


////////////////////////////////////////////////////////////////////////////////
// MEMORY PROTECTION UNIT
////////////////////////////////////////////////////////////////////////////////

//
// Is MPU present?
//
static Bool mpuPresent(riscvP riscv) {
#if(ENABLE_SSMPU)
    return riscv->configInfo.MPU_registers;
#else
    return False;
#endif
}

#if(ENABLE_SSMPU)

//
// This enumerates MPU entry errors
//
typedef enum mpuErrorE {
    MPUE_DONE,          // entry is valid
    MPUE_PRIV,          // MPU does not allow access
    MPUE_A_STRADDLE,    // aligned access may not straddle MPU entries
    MPUE_U_STRADDLE,    // unaligned accesses may not straddle MPU entries
} mpuError;

//
// Get a specific exception arising during an MPU lookup
//
static riscvException getMPUException(
    riscvP   riscv,
    memPriv  requiredPriv,
    Uns64    faultPA,
    mpuError error
) {
    if(!riscv->artifactAccess && RISCV_DEBUG_MMU(riscv)) {

        // cause descriptions
        static const char *map[] = {
            [MPUE_PRIV]       = "MPU access denied",
            [MPUE_A_STRADDLE] = "aligned access straddles MPU entries",
            [MPUE_U_STRADDLE] = "unaligned access straddles MPU entries",
        };

        // report MPU error
        vmiMessage("W", CPU_PREFIX "_MPUE",
            NO_SRCREF_FMT "%s "
            "[address=0x"FMT_Ax" access=%c]",
            NO_SRCREF_ARGS(riscv),
            map[error],
            faultPA,
            getAccessChar(requiredPriv)
        );
    }

    // return appropriate exception
    if(requiredPriv==MEM_PRIV_R) {
        return riscv_E_LoadMPUFault;
    } else if(requiredPriv==MEM_PRIV_W) {
        return riscv_E_StoreAMOMPUFault;
    } else {
        return riscv_E_InstructionMPUFault;
    }
}

//
// Return the number of implemented MPU regions
//
inline static Uns32 getNumMPUs(riscvP riscv) {
    return riscv->configInfo.MPU_registers;
}

//
// Is MPU managed by 64-bit CSRs?
//
inline static Bool isMPU64(riscvP riscv) {
    return RISCV_XLEN_IS_64M(riscv, RISCV_MODE_S);
}

//
// MPU configuration entry mode
//
typedef enum mpucfgModeE {
    MPUM_OFF,
    MPUM_TOR,
    MPUM_NA4,
    MPUM_NAPOT,
} mpucfgMode;

//
// MPU configuration entry structure
//
typedef union mpucfgElemU {
    Uns8 u8;
    struct {
        Uns8       priv : 3;
        mpucfgMode mode : 2;
        Uns8       _u1  : 2;
        Bool       S    : 1;
    };
} mpucfgElem;

//
// Read the indexed MPU configuration register (internal routine)
//
inline static Uns64 readMPUCFGInt(riscvP riscv, Uns32 index) {

    // return either 32-bit or 64-bit view
    if(isMPU64(riscv)) {
        return riscv->mpucfg.u64[index/2];
    } else {
        return riscv->mpucfg.u32[index];
    }
}

//
// Return the indexed MPU configuration register
//
inline static mpucfgElem getMPUCFGElem(riscvP riscv, Uns8 index) {
    return (mpucfgElem){u8:riscv->mpucfg.u8[index]};
}

//
// Return the effective value of an MPU address register, taking into account
// grain size
//
static Uns64 getEffectiveMPUAddr(riscvP riscv, Uns8 index) {

    mpucfgElem e      = getMPUCFGElem(riscv, index);
    Uns32      G      = riscv->configInfo.MPU_grain;
    Uns64      result = riscv->mpuaddr[index];

    if((G>=2) && (e.mode==MPUM_NAPOT)) {

        // when G>=2 and mpucfgi.A[1] is set, i.e. the mode is NAPOT, then bits
        // mpuaddri[G-2:0] read as all ones
        result |= ((1ULL << (G-1)) - 1);

    } else if((G>=1) && (e.mode!=MPUM_NAPOT)) {

        // when G>=1 and mpucfgi.A[1] is clear, i.e. the mode is OFF or TOR,
        // then bits mpuaddri[G-1:0] read as all zeros
        result &= (-1ULL << G);
    }

    return result;
}

//
// Is the indexed MPU region active?
//
static Bool getMPURegionActive(riscvP riscv, mpucfgElem e, Uns8 index) {

    if(e.mode==MPUM_OFF) {

        // region is disabled
        return False;

    } else if(e.mode!=MPUM_TOR) {

        // region is enabled with no range constraint
        return True;

    } else {

        // TOR region is effectively enabled only if the associated address is
        // non-zero (a zero address will always fail the bounds check)
        return getEffectiveMPUAddr(riscv, index);
    }
}

//
// This controls protections applied by mpuProtect
//
typedef enum mpuUpdateE {
    MPUU_SET_PRIV = 0x1,  // whether privilege is being set
    MPUU_LO       = 0x2,  // whether alignment check is required at low bound
    MPUU_HI       = 0x4,  // whether alignment check is required at high bound
} mpuUpdate;

//
// If updatePriv is True, set privileges in MPU domain, removing privileges on
// adjacent regions if required to detect accesses that straddle MPU boundaries;
// if updatePriv is False, update adjacent regions without modifying main region
// privileges
//
static void mpuProtect(
    riscvP     riscv,
    memDomainP domain,
    Uns64      lo,
    Uns64      hi,
    memPriv    priv,
    mpuUpdate  update
) {
    Bool unalignedOK = riscv->configInfo.unaligned;
    Bool updatePriv  = update & MPUU_SET_PRIV;

    // set the required permissions on the MPU region if required
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
        // is not on an 8-byte boundary
        if((update&MPUU_LO) && (lo>loMin) && (unalignedOK || (lo&7))) {
            vmirtProtectMemory(domain, lo-1, lo-1, MEM_PRIV_NONE, MEM_PRIV_SET);
        }

        // protect adjacent high byte if unaligned accesses are allowed or it
        // is not on an 8-byte boundary
        if((update&MPUU_HI) && (hi<hiMax) && (unalignedOK || ((hi+1)&7))) {
            vmirtProtectMemory(domain, hi+1, hi+1, MEM_PRIV_NONE, MEM_PRIV_SET);
        }
    }
}

//
// Set privileges for the given range in MPU domain for the given mode, or, if
// update does not include MPUU_SET_PRIV, only remove permissions on adjacent
// regions
//
static void setMPUPriv(
    riscvP    riscv,
    riscvMode mode,
    Uns64     low,
    Uns64     high,
    memPriv   priv,
    mpuUpdate update
) {
    memDomainP dataDomain = getPhysDomainCorD(riscv, mode, False);
    memDomainP codeDomain = getPhysDomainCorD(riscv, mode, True);
    Bool       updatePriv = update & MPUU_SET_PRIV;

    // emit debug if required
    if(updatePriv && RISCV_DEBUG_MMU(riscv)) {
        vmiPrintf(
            "MPU PRIV=%s 0x"FMT_6408x":0x"FMT_6408x" (mode %s)\n",
            privName(priv), low, high, riscvGetModeName(mode)
        );
    }

    if(dataDomain==codeDomain) {

        // set permissions in unified domain
        mpuProtect(riscv, dataDomain, low, high, priv, update);

    } else {

        // get privileges for data and code domains (NOTE: include RW
        // permissions in code domain to allow application load)
        memPriv privRW = priv&MEM_PRIV_RW;
        memPriv privX  = priv&MEM_PRIV_X ? MEM_PRIV_RWX : MEM_PRIV_NONE;

        // set permissions in data domain if required
        if(!updatePriv || (priv==MEM_PRIV_NONE) || privRW) {
            mpuProtect(riscv, dataDomain, low, high, privRW, update);
        }

        // set permissions in code domain if required
        if(!updatePriv || (priv==MEM_PRIV_NONE) || privX) {
            mpuProtect(riscv, codeDomain, low, high, privX, update);
        }
    }
}

//
// Set privileges for a single byte in MPU domain for the given mode, or, if
// update does not include MPUU_SET_PRIV, only remove permissions on adjacent
// regions
//
inline static void setMPUPrivB(
    riscvP    riscv,
    riscvMode mode,
    Uns64     addr,
    memPriv   priv,
    mpuUpdate update
) {
    setMPUPriv(riscv, mode, addr, addr, priv, update);
}

//
// Return the bounds of the indexed MPU entry
//
static void getMPUEntryBounds(
    riscvP riscv,
    Uns32  index,
    Uns64 *lowP,
    Uns64 *highP
) {
    mpucfgElem e   = getMPUCFGElem(riscv, index);
    Uns64      low = getEffectiveMPUAddr(riscv, index)<<2;
    Uns64      high;

    if(e.mode==MPUM_NA4) {

        // 4-byte range
        high = low + 3;

    } else if(e.mode==MPUM_NAPOT) {

        // naturally-aligned power of two range
        Uns64 notLow = ~(low+3);
        Uns64 mask   = ((notLow & -notLow) << 1) - 1;

        low  = low & ~mask;
        high = low |  mask;

    } else {

        // top-of-range
        high = low-1;
        low  = index ? riscv->mpuaddr[index-1]<<2 : 0;

        // mask low address to implemented grain size
        low &= (-4ULL << riscv->configInfo.MPU_grain);
    }

    // assign results
    *lowP  = low;
    *highP = high;
}

//
// Return the access privilege of the MPU entry in the given mode
//
static memPriv getMPUEntryPriv(riscvP riscv, riscvMode mode, mpucfgElem e) {

    Bool    isS = (mode==RISCV_MODE_S);
    memPriv priv;

    if(isS && !e.S) {

        // Supervisor mode access, mpucfg.L=0
        priv = mapMML1ML0[e.priv];

    } else if(isS) {

        // Supervisor mode access, mpucfg.L=1
        priv = mapMML1ML1[e.priv];

    } else if(!e.S) {

        // User mode access, mpucfg.L=0
        priv = mapMML1SL0[e.priv];

    } else {

        // User mode access, mpucfg.L=1
        priv = mapMML1SL1[e.priv];
    }

    return priv;
}

//
// Invalidate MPU entry 'index'
//
static void invalidateMPUEntry(riscvP riscv, Uns32 index) {

    mpucfgElem e = getMPUCFGElem(riscv, index);

    if(getMPURegionActive(riscv, e, index)) {

        Uns64 low;
        Uns64 high;

        // get the entry bounds
        getMPUEntryBounds(riscv, index, &low, &high);

        // ignore TOR entries with low>high
        if(low<=high) {

            mpuUpdate updateU = MPUU_SET_PRIV;
            mpuUpdate updateS = MPUU_SET_PRIV;

            // remove access in User address space
            setMPUPriv(riscv, RISCV_MODE_U, low, high, MEM_PRIV_NONE, updateU);

            // remove access in Supervisor address space
            setMPUPriv(riscv, RISCV_MODE_S, low, high, MEM_PRIV_NONE, updateS);
        }
    }
}

//
// If the MPU entry is a TOR entry, invalidate it
//
static void invalidateMPUEntryTOR(riscvP riscv, Uns32 index) {

    if(index==getNumMPUs(riscv)) {
        // index out of range
    } else if(getMPUCFGElem(riscv, index).mode==MPUM_TOR) {
        invalidateMPUEntry(riscv, index);
    }
}

//
// Return offset into MPU bank allowing for the fact that when in 64-bit mode
// the second set of MPU registers are controlled by mpucfg2 (not mpucfg1,
// which is unimplemented)
//
static Uns32 getMPUCFGOffset(riscvP riscv, Uns32 index) {
    return isMPU64(riscv) ? index/2 : index;
}

//
// Is the given MPU configuration register index valid?
//
static Bool validMPUCFG(riscvP riscv, Uns32 index) {

    Uns32 entriesPerCFG = isMPU64(riscv) ? 8 : 4;
    Uns32 numMPU        = getNumMPUs(riscv);
    Uns32 numCFG        = ((numMPU+entriesPerCFG-1)/entriesPerCFG);

    return (getMPUCFGOffset(riscv, index) < numCFG);
}

//
// Read the indexed MPU configuration register
//
Uns64 riscvVMReadMPUCFG(riscvP riscv, Uns32 index) {
    return validMPUCFG(riscv, index) ? readMPUCFGInt(riscv, index) : 0;
}

//
// Write the indexed MPU configuration register with the new value and return
// the new effective value
//
Uns64 riscvVMWriteMPUCFG(riscvP riscv, Uns32 index, Uns64 newValue) {

    Uns64 result = 0;

    if(validMPUCFG(riscv, index)) {

        Uns32 entriesPerCFG = isMPU64(riscv) ? 8 : 4;
        Uns32 offset        = getMPUCFGOffset(riscv, index);
        Uns32 G             = riscv->configInfo.MPU_grain;
        Uns32 numMPU        = getNumMPUs(riscv);
        Uns32 numBytes      = numMPU-(offset*entriesPerCFG);
        Uns64 mask          = (numBytes>=8) ? -1 : (1ULL<<(numBytes*8))-1;
        Int32 i;

        // get byte-accessible source value
        union {Uns64 u64; Uns8 u8[8];} src = {u64 : newValue&WM64_mpucfg&mask};

        // invalidate any modified entries in lowest-to-highest priority order
        for(i=entriesPerCFG-1; i>=0; i--) {

            Uns32 cfgIndex = (index*4)+i;
            Uns8 *dstP     = &riscv->mpucfg.u8[cfgIndex];

            // get old and new values
            mpucfgElem srcCFG = {u8:src.u8[i]};
            mpucfgElem dstCFG = {u8:*dstP};

            // handle reserved encoding
            if(srcCFG.S && (srcCFG.priv==MEM_PRIV_NONE)) {
                srcCFG = dstCFG;
            }

            // when G>=1, the NA4 mode is not selectable
            if(G && (srcCFG.mode==MPUM_NA4)) {
                srcCFG.mode = dstCFG.mode;
            }

            if(*dstP!=srcCFG.u8) {

                // invalidate entry using its original specification
                invalidateMPUEntry(riscv, cfgIndex);

                // set new value
                *dstP = srcCFG.u8;

                // invalidate entry using its new specification
                invalidateMPUEntry(riscv, cfgIndex);
            }
        }

        // return updated value
        result = readMPUCFGInt(riscv, index);
    }

    return result;
}

//
// Is the given MPU address register index valid?
//
inline static Bool validMPUAddr(riscvP riscv, Uns32 index) {
    return index<getNumMPUs(riscv);
}

//
// Read the indexed MPU address register
//
Uns64 riscvVMReadMPUAddr(riscvP riscv, Uns32 index) {
    return validMPUAddr(riscv, index) ? getEffectiveMPUAddr(riscv, index) : 0;
}

//
// Write the indexed MPU address register with the new value and return
// the new effective value
//
Uns64 riscvVMWriteMPUAddr(riscvP riscv, Uns32 index, Uns64 newValue) {

    Uns64 result = 0;
    Uns32 G      = riscv->configInfo.MPU_grain;

    // mask writable bits to implemented external bits
    newValue &= (getAddressMask(riscv->extBits) >> 2);

    // also mask writable bits if grain is set
    if(G) {
        newValue &= (-1ULL << (G-1));
    }

    if(validMPUAddr(riscv, index) && (riscv->mpuaddr[index]!=newValue)) {

        // invalidate entry using its original specification
        invalidateMPUEntry(riscv, index);
        invalidateMPUEntryTOR(riscv, index+1);

        // set new value
        riscv->mpuaddr[index] = newValue;

        // invalidate entry using its new specification
        invalidateMPUEntry(riscv, index);
        invalidateMPUEntryTOR(riscv, index+1);

        result = getEffectiveMPUAddr(riscv, index);
    }

    return result;
}

//
// Reset MPU unit
//
void riscvVMResetMPU(riscvP riscv) {

    Uns32 numRegs = getNumMPUs(riscv);
    Uns32 i;

    for(i=0; i<numRegs; i++) {

        if(riscv->mpuaddr[i] || riscv->mpucfg.u8[i]) {

            // invalidate entry using its current specification
            invalidateMPUEntry(riscv, i);

            // reset entry fields
            riscv->mpuaddr[i]   = 0;
            riscv->mpucfg.u8[i] = 0;
        }
    }
}

//
// Structure holding range and privilege information for an MPU-mapped address
//
typedef struct MPUMapS {
    Uns64   lowPA;
    Uns64   highPA;
    memPriv priv;
} MPUMap, *MPUMapP;

//
// Update the bounds in lowPAP/highPAP and privilege to reflect the effect of
// region i
//
static void refineMPURegionRange(
    riscvP    riscv,
    riscvMode mode,
    MPUMapP   map,
    Uns64     PA,
    Uns32     index
) {
    mpucfgElem e = getMPUCFGElem(riscv, index);

    // only handle active regions
    if(getMPURegionActive(riscv, e, index)) {

        Uns64 lowPAEntry;
        Uns64 highPAEntry;

        // get bounds of the entry
        getMPUEntryBounds(riscv, index, &lowPAEntry, &highPAEntry);

        if(lowPAEntry>highPAEntry) {

            // ignore TOR region with low bound > high bound

        } else if((lowPAEntry<=PA) && (PA<=highPAEntry)) {

            // match in this region
            map->lowPA  = lowPAEntry;
            map->highPA = highPAEntry;

            // get standard access privilege
            map->priv = getMPUEntryPriv(riscv, mode, e);

        } else if((lowPAEntry>PA) && (lowPAEntry<map->highPA)) {

            // remove part of region ABOVE matching address
            map->highPA = lowPAEntry-1;

        } else if((highPAEntry<PA) && (highPAEntry>map->lowPA)) {

            // remove part of region BELOW matching address
            map->lowPA = highPAEntry+1;
        }
    }
}

//
// This defines the maximum number of MPU regions that can be straddled by a
// single access
//
#define MAX_MPU_STRADDLE_NUM 3

//
// Return MPU privileges for regions with no match
//
static memPriv getMPUUnmatchedPriv(riscvP riscv, riscvMode mode) {

    memPriv priv;

    if((mode==RISCV_MODE_S) || (mode==RISCV_MODE_VS)) {
        priv = MEM_PRIV_RWX;
    } else {
        priv = MEM_PRIV_NONE;
    }

    return priv;
}

//
// Refresh physical mappings for the given physical address range and mode
//
static Bool mapMPU(
    riscvP    riscv,
    riscvMode mode,
    memPriv   requiredPriv,
    Uns64     lowPA,
    Uns64     highPA
) {
    Uns32    numRegs = getNumMPUs(riscv);
    mpuError error   = MPUE_DONE;

    if(numRegs && (mode!=RISCV_MODE_M)) {

        Uns64   thisPA  = lowPA;
        Uns64   faultPA = 0;
        Uns64   maxPA   = getAddressMask(riscv->extBits);
        memPriv priv    = getMPUUnmatchedPriv(riscv, mode);
        Bool    aligned = !(lowPA & (highPA-lowPA));
        Uns32   mapNum  = 0;
        Bool    mapDone = False;
        MPUMap  maps[MAX_MPU_STRADDLE_NUM];

        // continue while regions remain unprocessed
        while(!mapDone) {

            // get next MPU region
            MPUMapP map = &maps[mapNum++];
            Int32   i;

            // sanity check the number of MPU regions straddled
            VMI_ASSERT(
                mapNum<=MAX_MPU_STRADDLE_NUM,
                "access 0x"FMT_Ax":0x"FMT_Ax" straddling too many MPU regions",
                lowPA, highPA
            );

            // fill MPU region constraints
            map->lowPA  = 0;
            map->highPA = maxPA;
            map->priv   = priv;

            // handle all regions in lowest-to-highest priority order
            for(i=numRegs-1; i>=0; i--) {
                refineMPURegionRange(riscv, mode, map, thisPA, i);
            }

            // validate region bounds and access privileges unless fault has
            // already been detected
            if(
                !error &&
                (
                    (thisPA < map->lowPA) ||
                    (thisPA > map->highPA) ||
                    ((map->priv&requiredPriv) != requiredPriv)
                )
            ) {
                error   = MPUE_PRIV;
                faultPA = thisPA;
            }

            // prepare for next iteration if required
            mapDone = (map->highPA>=highPA);
            thisPA  = map->highPA+1;
        }

        // handle accesses that straddle multiple regions
        if(mapNum==1) {

            // no action if a single region matches

        } else if(aligned) {

            // aligned accesses may not straddle MPU regions
            error   = MPUE_A_STRADDLE;
            faultPA = lowPA;

        } else if(!riscv->configInfo.MPU_decompose) {

            // unaligned accesses are not decomposed
            error   = MPUE_U_STRADDLE;
            faultPA = lowPA;
        }

        if(error) {

            // invalid access - get exception type
            riscvException exception = getMPUException(
                riscv, requiredPriv, faultPA, error
            );

            // generate exception
            if(!riscv->artifactAccess) {
                riscvTakeMemoryException(riscv, exception, faultPA);
            }

        } else {

            Uns32 i;

            // install region mappings
            for(i=0; i<mapNum; i++) {

                MPUMapP   map       = &maps[i];
                mpuUpdate update    = MPUU_SET_PRIV;
                Uns64     lowClamp  = map->lowPA;
                Uns64     highClamp = map->highPA;

                // clamp physical range to maximum page size
                riscvClampPage(riscv, lowPA, highPA, &lowClamp, &highClamp);

                // determine whether region straddle alignment check is required
                // at low and high region bound (only if bounds have *not* been
                // clamped for regions at the limits of the access)
                if((i==0) && (lowClamp==map->lowPA)) {
                    update |= MPUU_LO;
                }
                if((i==(mapNum-1)) && (highClamp==map->highPA)) {
                    update |= MPUU_HI;
                }

                // update MPU privileges
                setMPUPriv(riscv, mode, lowClamp, highClamp, map->priv, update);
            }

            // for unaligned accesses that straddle regions, protect adjacent
            // bytes so that subsequent aligned 8-byte accesses will still fail
            if(mapNum>1) {

                mpuUpdate update = MPUU_SET_PRIV;
                Uns64     r0High = maps[0].highPA;
                Uns64     rNLow  = maps[mapNum-1].lowPA;

                // handle access less than 4 bytes in first region
                if((r0High-lowPA)<3) {
                    setMPUPrivB(riscv, mode, r0High-3, MEM_PRIV_NONE, update);
                }

                // handle access less than 4 bytes in last region
                if((highPA-rNLow)<3) {
                    setMPUPrivB(riscv, mode, rNLow+3, MEM_PRIV_NONE, update);
                }
            }
        }
    }

    return error;
}

//
// Allocate MPU structures
//
void riscvVMNewMPU(riscvP riscv) {

    Uns32 numRegs = getNumMPUs(riscv);

    if(numRegs) {
        riscv->mpucfg.u64 = STYPE_CALLOC_N(Uns64, (numRegs+7)/8);
        riscv->mpuaddr    = STYPE_CALLOC_N(Uns64, numRegs);
    }
}

//
// Free MPU structures
//
void riscvVMFreeMPU(riscvP riscv) {

    if(riscv->mpucfg.u64) {
        STYPE_FREE(riscv->mpucfg.u64);
    }
    if(riscv->mpuaddr) {
        STYPE_FREE(riscv->mpuaddr);
    }
}


////////////////////////////////////////////////////////////////////////////////
// MPU SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

#define MPU_CFG  "MPU_CFG"
#define MPU_ADDR "MPU_ADDR"

//
// Save MPU structures
//
void saveMPU(riscvP riscv, vmiSaveContextP cxt) {

    Uns32 numRegs = getNumMPUs(riscv);
    Uns32 i;

    for(i=0; i<numRegs; i++) {
        VMIRT_SAVE_REG(cxt, MPU_CFG,  &riscv->mpucfg.u8[i]);
        VMIRT_SAVE_REG(cxt, MPU_ADDR, &riscv->mpuaddr[i]);
    }
}

//
// Restore MPU structures
//
void restoreMPU(riscvP riscv, vmiRestoreContextP cxt) {

    Uns32 numRegs = getNumMPUs(riscv);
    Uns32 i;

    for(i=0; i<numRegs; i++) {
        invalidateMPUEntry(riscv, i);
        VMIRT_RESTORE_REG(cxt, MPU_CFG,  &riscv->mpucfg.u8[i]);
        VMIRT_RESTORE_REG(cxt, MPU_ADDR, &riscv->mpuaddr[i]);
    }
}

#endif


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
// TLB TYPES
////////////////////////////////////////////////////////////////////////////////

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


////////////////////////////////////////////////////////////////////////////////
// PAGE TABLE WALK UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Is stage 2 address lookup required for the active translation domain?
//
inline static Bool doStage2(riscvP riscv, riscvTLBId id) {
    return ((id==RISCV_TLB_VS1) && RD_CSR_FIELD_S(riscv, hgatp, MODE));
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
    Uns8  PTWLevel;
    Uns64 tinst;
} ptwCxt;

//
// Enter PTW context
//
static ptwCxt enterPTWContext(
    riscvP  riscv,
    Uns32   size,
    memPriv priv,
    Uns32   level
) {
    ptwCxt result = {
        PTWActive : riscv->PTWActive,
        PTWLevel  : riscv->PTWLevel,
        tinst     : riscv->tinst
    };

    riscv->PTWActive  = True;
    riscv->PTWLevel   = level;
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
    riscv->PTWLevel  = oldCxt.PTWLevel;
    riscv->tinst     = oldCxt.tinst;
}

//
// Read an entry from a page table (returning invalid all-zero entry if the
// lookup fails)
//
static Uns64 readPageTableEntry(
    riscvP    riscv,
    riscvMode mode,
    Uns64     PTEAddr,
    Uns32     size,
    Uns32     level
) {
    memDomainP domain = getPTWDomain(riscv);
    memEndian  endian = riscvGetDataEndian(riscv, getSMode(mode));
    ptwCxt     oldCxt = enterPTWContext(riscv, size, MEM_PRIV_R, level);
    Uns64      result = 0;

    // read 4-byte or 8-byte entry
    if(size==4) {
        result = vmirtRead4ByteDomain(domain, PTEAddr, endian, MEM_AA_TRUE);
    } else {
        result = vmirtRead8ByteDomain(domain, PTEAddr, endian, MEM_AA_TRUE);
    }

    // exit PTW context
    leavePTWContext(riscv, oldCxt);

    return result;
}

//
// Write an entry in a page table
//
static void writePageTableEntry(
    riscvP    riscv,
    riscvMode mode,
    Uns64     PTEAddr,
    Uns32     size,
    Uns64     value,
    Uns32     level
) {
    memDomainP domain = getPTWDomain(riscv);
    memEndian  endian = riscvGetDataEndian(riscv, getSMode(mode));
    ptwCxt     oldCxt = enterPTWContext(riscv, size, MEM_PRIV_W, level);

    // write 4-byte or 8-byte entry
    if(riscv->artifactAccess) {
        // no action if an artifact access (e.g. page table walk initiated by
        // pseudo-register write)
    } else if(size==4) {
        vmirtWrite4ByteDomain(domain, PTEAddr, endian, value, MEM_AA_TRUE);
    } else {
        vmirtWrite8ByteDomain(domain, PTEAddr, endian, value, MEM_AA_TRUE);
    }

    // exit PTW context
    leavePTWContext(riscv, oldCxt);
}


////////////////////////////////////////////////////////////////////////////////
// PAGE TABLE TYPES
////////////////////////////////////////////////////////////////////////////////

//
// This enumerates page table walk errors
//
typedef enum pteErrorE {
    PTEE_DONE,              // entry is valid, walk complete
    PTEE_VAEXTEND,          // VA has invalid extension
    PTEE_GPAEXTEND,         // GPA has invalid extension
    PTEE_READ,              // page table entry load failed
    PTEE_WRITE,             // page table entry store failed
    PTEE_V0,                // page table entry V=0
    PTEE_R0W1,              // page table entry R=0 W=1
    PTEE_LEAF,              // page table entry must be leaf level
    PTEE_ALIGN,             // page table entry is a misaligned superpage
    PTEE_PRIV,              // page table entry does not allow access
    PTEE_A0,                // page table entry A=0
    PTEE_D0,                // page table entry D=0
    PTEE_RES0,              // page table entry reserved bits not zero
    PTEE_D_NL,              // page table entry non-leaf and D!=0
    PTEE_A_NL,              // page table entry non-leaf and A!=0
    PTEE_U_NL,              // page table entry non-leaf and U!=0
    PTEE_SVNAPOT,           // page table entry Svnapot invalid
    PTEE_SVPBMT,            // page table entry Svpbmt invalid
    PTEE_CUSTOM,            // page table entry custom failure
} pteError;

//
// Common page table entry type
//
typedef union SvPTEU {
    Uns64 raw;
    struct {
        Uns64 V    :  1;
        Uns64 priv :  3;
        Uns64 U    :  1;
        Uns64 G    :  1;
        Uns64 A    :  1;
        Uns64 D    :  1;
        Uns64 RSW  :  2;
        Uns64 PPN  : 44;
        Uns64 res0 :  7;
        Uns64 PBMT :  2;
        Uns64 N    :  1;
    } fields;
} SvPTE;

//
// Common physical address type
//
typedef union SvPAU {
    Uns64 raw;
    struct {
        Uns64 pageOffset : 12;
        Uns64 PPN        : 52;
    } fields;
} SvPA;

//
// Common virtual address type
//
typedef union SvVAU {
    Uns64 raw;
    struct {
        Uns32 pageOffset : 12;
        Uns64 VPN        : 52;
    } fields;
} SvVA;

//
// Sizes of VPN fields for Sv32 and Sv39/Sv48/Sv57
//
#define VPN_SHIFT_SV32 10
#define VPN_SHIFT_SV64  9


////////////////////////////////////////////////////////////////////////////////
// PAGE TABLE WALK
////////////////////////////////////////////////////////////////////////////////

//
// Forward reference
//
static memPriv checkEntryPermission(
    riscvP    riscv,
    riscvMode mode,
    tlbEntryP entry,
    memPriv   requiredPriv
);

//
// Is a virtual TLB active?
//
inline static Bool activeTLBIsVirtual(riscvP riscv) {
    return (riscv->activeTLB!=RISCV_TLB_HS);
}

//
// Is the VS stage 1 TLB active?
//
inline static Bool activeTLBIsVS1(riscvP riscv) {
    return (riscv->activeTLB==RISCV_TLB_VS1);
}

//
// Is the VS stage 2 TLB active?
//
inline static Bool activeTLBIsVS2(riscvP riscv) {
    return (riscv->activeTLB==RISCV_TLB_VS2);
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
// Return number of virtual address bits for the given mode
//
static Uns32 getVABits(riscvVAMode vaMode) {

    static const Uns8 map[16] = {
        [VAM_Sv32] = 32,
        [VAM_Sv39] = 39,
        [VAM_Sv48] = 48,
        [VAM_Sv57] = 57,
        [VAM_Sv64] = 64,
    };

    Uns32 result = map[vaMode];

    VMI_ASSERT(result, "Invalid VA mode %u", vaMode);

    return result;
}

//
// Return number of levels for the given mode
//
static Uns32 getVAlevels(riscvVAMode vaMode) {

    static const Uns8 map[16] = {
        [VAM_Sv32] = 2,
        [VAM_Sv39] = 3,
        [VAM_Sv48] = 4,
        [VAM_Sv57] = 5,
        [VAM_Sv64] = 6,
    };

    Uns32 result = map[vaMode];

    VMI_ASSERT(result, "Invalid VA mode %u", vaMode);

    return result;
}

//
// If the PTE is a Svnapot entry, return the encoded size
//
static Uns64 getSvnapotEntrySize(SvPTE PTE) {

    Uns64 PPN    = PTE.fields.PPN;
    Uns64 PPNlsb = PPN & -PPN;

    return PPNlsb<<13;
}

//
// Is the Svnapot entry size encoded in the PTE valid?
//
static Bool validSvnapotEntry(riscvP riscv, SvPTE PTE) {

    Bool result = False;

    // only allow leaf-level Svnapot entries currently
    if(PTE.fields.priv) {

        Uns64 bytes = getSvnapotEntrySize(PTE);

        result = riscv->configInfo.Svnapot_page_mask & bytes;
    }

    return result;
}

//
// Is the Svpbmt entry encoded in the PTE valid?
//
static Bool validSvpbmtEntry(riscvP riscv, SvPTE PTE) {

    if(!riscv->configInfo.Svpbmt) {
        return False;
    } else if(PTE.fields.PBMT==3) {
        return False;
    } else if(!RD_CSR_FIELDC(riscv, menvcfg, PBMTE)) {
        return False;
    } else if(!activeTLBIsVS1(riscv)) {
        return True;
    } else {
        return RD_CSR_FIELDC(riscv, henvcfg, PBMTE);
    }

    return riscv->configInfo.Svpbmt && (PTE.fields.PBMT!=3);
}

//
// Check page table entry for validity
//
static pteError checkTableEntry(riscvP riscv, SvPTE PTE) {

    pteError result = PTEE_LEAF;

    if(riscv->PTWBadAddr) {
        result = PTEE_READ;
    } else if(PTE.fields.res0) {
        result = PTEE_RES0;
    } else if(PTE.fields.N && !validSvnapotEntry(riscv, PTE)) {
        result = PTEE_SVNAPOT;
    } else if(PTE.fields.PBMT && !validSvpbmtEntry(riscv, PTE)) {
        result = PTEE_SVPBMT;
    } else if(!PTE.fields.V) {
        result = PTEE_V0;
    } else if((PTE.fields.priv&MEM_PRIV_RW) == MEM_PRIV_W) {
        result = PTEE_R0W1;
    } else if(PTE.fields.priv) {
        result = PTEE_DONE;
    } else if(PTE.fields.D) {
        result = PTEE_D_NL;
    } else if(PTE.fields.A) {
        result = PTEE_A_NL;
    } else if(PTE.fields.U) {
        result = PTEE_U_NL;
    }

    return result;
}

//
// Do custom validity check on page table entry
//
static pteError checkEntryCustom(riscvP riscv, SvPTE PTE, riscvVAMode vaMode) {

    Bool result = True;

    ITER_EXT_CB_WHILE(
        riscv, extCB, validPTE, result,
        result = extCB->validPTE(
            riscv, riscv->activeTLB, vaMode, PTE.raw, extCB->clientData
        );
    )

    return result ? PTEE_DONE : PTEE_CUSTOM;
}

//
// Fill TLB entry using details in page table entry
//
static pteError fillTLBEntry(
    riscvP    riscv,
    riscvMode mode,
    tlbEntryP entry,
    memPriv   requiredPriv,
    SvPTE     PTE,
    Int32     i,
    Uns32     vpnShift
) {
    Uns64 size;

    if(PTE.fields.N) {

        // Svnapot entry - get entry size
        size = getSvnapotEntrySize(PTE);

        // mask PA to Svnapot entry size
        entry->PA &= -size;

    } else {

        // normal entry - calculate entry size
        size = 1ULL << ((i*vpnShift) + RISCV_PAGE_SHIFT);

        // return with page-fault exception if invalid page alignment
        if(entry->PA & (size-1)) {
            return PTEE_ALIGN;
        }
    }

    // fill TLB entry virtual address range
    entry->lowVA &= -size;
    entry->highVA = entry->lowVA + size - 1;

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
        return PTEE_PRIV;
    }

    if(entry->A) {
        // A bit is already set
    } else if(!updatePTEA(riscv)) {
        // A bit not yet set, no hardware support
        return PTEE_A0;
    } else {
        // A bit is set on any access
        entry->A = 1;
    }

    // D bit is set on any write
    if(entry->D || !(requiredPriv & MEM_PRIV_W)) {
        // D bit is already set or not required
    } else if(!updatePTED(riscv)) {
        // D bit not yet set, no hardware support
        return PTEE_D0;
    } else {
        entry->D = 1;
    }

    return PTEE_DONE;
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
// Get a specific exception arising during a page table walk
//
static riscvException getPTWException(
    riscvP    riscv,
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
        [PTEE_VAEXTEND]  = {1, PTX_PAGE,         "VA has invalid extension" },
        [PTEE_GPAEXTEND] = {1, PTX_PAGE,         "GPA has invalid extension"},
        [PTEE_READ]      = {1, PTX_LOAD_ACCESS,  "load failed"              },
        [PTEE_WRITE]     = {1, PTX_STORE_ACCESS, "store failed"             },
        [PTEE_V0]        = {0, PTX_PAGE,         "V=0"                      },
        [PTEE_R0W1]      = {1, PTX_PAGE,         "R=0 and W=1"              },
        [PTEE_LEAF]      = {1, PTX_PAGE,         "must be leaf level"       },
        [PTEE_ALIGN]     = {1, PTX_PAGE,         "is a misaligned superpage"},
        [PTEE_PRIV]      = {0, PTX_PAGE,         "does not allow access"    },
        [PTEE_A0]        = {0, PTX_PAGE,         "A=0"                      },
        [PTEE_D0]        = {0, PTX_PAGE,         "D=0"                      },
        [PTEE_RES0]      = {1, PTX_PAGE,         "reserved bits not zero"   },
        [PTEE_D_NL]      = {1, PTX_PAGE,         "non-leaf and D!=0"        },
        [PTEE_A_NL]      = {1, PTX_PAGE,         "non-leaf and A!=0"        },
        [PTEE_U_NL]      = {1, PTX_PAGE,         "non-leaf and U!=0"        },
        [PTEE_SVNAPOT]   = {1, PTX_PAGE,         "illegal Svnapot entry"    },
        [PTEE_SVPBMT]    = {1, PTX_PAGE,         "illegal Svpbmt entry"     },
        [PTEE_CUSTOM]    = {1, PTX_PAGE,         "custom entry check failed"},
    };

    // get description for this error
    const pteErrorDesc *desc     = &map[error];
    const char         *severity = 0;

    // determine whether PTW exception should be reported, and with what
    // severity
    if(riscv->artifactAccess) {
        // don't report exceptions for artifact accesses
    } else if(desc->warn) {
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
            "[address=0x"FMT_Ax" PTEAddress=0x"FMT_Ax" access=%c]",
            NO_SRCREF_ARGS(riscv),
            desc->desc,
            entry->lowVA,
            PTEAddr,
            getAccessChar(requiredPriv)
        );
    } else {
        vmiMessage(severity, CPU_PREFIX "_PTWE",
            NO_SRCREF_FMT "%s "
            "[address=0x"FMT_Ax" access=%c]",
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
#define PTE_ERROR(_CODE) return getPTWException( \
    riscv, entry, requiredPriv, PTEAddr, PTEE_##_CODE \
)

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
// Do page table walk for VA given by 'entry->lowVA' and either fill byref
// argument 'entry' or trigger exception
//
static riscvException doPageTableWalkVA(
    riscvP      riscv,
    riscvMode   mode,
    tlbEntryP   entry,
    memPriv     requiredPriv,
    riscvVAMode vaMode
) {
    Uns32    entryBytes = (vaMode==VAM_Sv32) ? 4 : 8;
    Uns32    vpnShift   = (vaMode==VAM_Sv32) ? VPN_SHIFT_SV32 : VPN_SHIFT_SV64;
    Uns32    vpnMask    = ((1<<vpnShift)-1);
    SvVA     VA         = {raw : entry->lowVA};
    Addr     PTEAddr    = 0;
    pteError error      = 0;
    SvPA     PA;
    SvPTE    PTE;
    Addr     a;
    Int32    i;

    // clear page offset bits (not relevant for entry creation)
    VA.fields.pageOffset = 0;

    // do table walk to find ultimate PTE
    for(
        i=getVAlevels(vaMode)-1, a=getRootTableAddress(riscv);
        i>=0;
        i--, a=getPTETableAddress(PTE.fields.PPN)
    ) {
        Uns32 offset = (VA.fields.VPN >> (i*vpnShift)) & vpnMask;

        // get next page table entry address
        PTEAddr = a + (offset*entryBytes);

        // read entry from memory
        PTE.raw = readPageTableEntry(riscv, mode, PTEAddr, entryBytes, i);

        // validate PTE entry
        error = checkTableEntry(riscv, PTE);

        // terminate unless next level lookup required
        if(error!=PTEE_LEAF) {
            break;
        }
    }

    if(!error) {

        // construct entry low PA
        PA.fields.PPN        = PTE.fields.PPN;
        PA.fields.pageOffset = 0;

        // fill TLB entry low physical address
        entry->PA = PA.raw;

        error = fillTLBEntry(riscv, mode, entry, requiredPriv, PTE, i, vpnShift);
    }

    if(error) {

        // no action

    } else if((error=checkEntryCustom(riscv, PTE, vaMode))) {

        // return with page-fault exception if custom entry check fails

    } else if((PTE.fields.A != entry->A) || (PTE.fields.D != entry->D)) {

        // write PTE if it has changed
        PTE.fields.A = entry->A;
        PTE.fields.D = entry->D;

        writePageTableEntry(riscv, mode, PTEAddr, entryBytes, PTE.raw, i);

        // error if entry is not writable
        if(riscv->PTWBadAddr) {
            error = PTEE_WRITE;
        }
    }

    // handle result
    if(error) {
        return getPTWException(riscv, entry, requiredPriv, PTEAddr, error);
    } else {
        return 0;
    }
}

//
// Do page table walk for GPA given by 'entry->lowVA' and either fill byref
// argument 'entry' or trigger exception
//
static riscvException doPageTableWalkGPA(
    riscvP      riscv,
    riscvMode   mode,
    tlbEntryP   entry,
    memPriv     requiredPriv,
    riscvVAMode vaMode
) {
    Uns32 vaBits    = getVABits(vaMode);
    Uns64 extraBits = entry->lowVA >> vaBits;
    Uns32 shiftUp   = (vaMode==VAM_Sv32) ? 0 : (64-vaBits);

    // record additional stage 2 page offset
    riscv->s2Offset = extraBits;

    // get ignored bits
    extraBits <<= vaBits;

    // remove ignored bits from virtual address by sign-extending remainder
    Int64 extendVA = entry->lowVA << shiftUp;
    entry->lowVA = extendVA >> shiftUp;

    // use stage 1 entry lookup logic
    riscvException exception = doPageTableWalkVA(
        riscv, mode, entry, requiredPriv, vaMode
    );

    // include additional offset if lookup succeeded
    if(!exception) {
        entry->lowVA  = ((entry->lowVA<<shiftUp)>>shiftUp) + extraBits;
        entry->highVA = ((entry->highVA<<shiftUp)>>shiftUp) + extraBits;
    }

    return exception;
}

//
// Handle trap of page table walk
//
static riscvException trapDerived(
    riscvP     riscv,
    tlbEntryP  entry,
    memPriv    requiredPriv,
    riscvTLBId id
) {
    riscvException result = 0;

    ITER_EXT_CB_WHILE(
        riscv, extCB, VMTrap, !result,
        result = extCB->VMTrap(
            riscv, id, requiredPriv, entry->lowVA, extCB->clientData
        );
    )

    return result;
}

//
// Is the stage 1 virtual address valid for the given mode?
//
static Bool validS1VA(Uns64 VA, riscvVAMode vaMode) {

    Uns32 topBits = 64-getVABits(vaMode);

    // address must be sign-extended unless Sv32 is active
    return (vaMode==VAM_Sv32) || ((((Int64)(VA<<topBits))>>topBits) == VA);
}

//
// Is the stage 2 guest physical address valid for the given mode?
//
static Bool validS2GPA(Uns64 GPA, riscvVAMode vaMode) {

    Uns32 GPABits = getVABits(vaMode)+2;

    // physical address must be zero-extended
    return !(GPA >> GPABits);
}

//
// Return page fault exception code
//
static riscvException getPageFault(
    riscvP    riscv,
    tlbEntryP entry,
    memPriv   requiredPriv,
    pteError  error
) {
    return getPTWException(riscv, entry, requiredPriv, -1, error);
}

//
// Do page table lookup for VA given by 'entry->lowVA' and either fill byref
// argument 'entry' or trigger exception
//
static riscvException doPageTableLookupVA(
    riscvP    riscv,
    riscvMode mode,
    tlbEntryP entry,
    memPriv   requiredPriv
) {
    riscvTLBId     id     = riscv->activeTLB;
    Bool           V      = (id==RISCV_TLB_VS1);
    riscvVAMode    vaMode = RD_CSR_FIELD_V(riscv, satp, V, MODE);
    riscvException result = 0;

    if(!validS1VA(entry->lowVA, vaMode)) {
        result = getPageFault(riscv, entry, requiredPriv, PTEE_VAEXTEND);
    } else if((result = trapDerived(riscv, entry, requiredPriv, id))) {
        // no further action if derived model lookup traps
    } else {
        result = doPageTableWalkVA(riscv, mode, entry, requiredPriv, vaMode);
    }

    return result;
}

//
// Do page table lookup for GPA given by 'entry->lowVA' and either fill byref
// argument 'entry' or trigger exception
//
static riscvException doPageTableLookupGPA(
    riscvP    riscv,
    riscvMode mode,
    tlbEntryP entry,
    memPriv   requiredPriv
) {
    riscvTLBId     id     = RISCV_TLB_VS2;
    riscvVAMode    vaMode = RD_CSR_FIELD_S(riscv, hgatp, MODE);
    riscvException result = 0;

    if(!validS2GPA(entry->lowVA, vaMode)) {
        result = getPageFault(riscv, entry, requiredPriv, PTEE_GPAEXTEND);
    } else if((result = trapDerived(riscv, entry, requiredPriv, id))) {
        // no further action if derived model lookup traps
    } else {
        result = doPageTableWalkGPA(riscv, mode, entry, requiredPriv, vaMode);
    }

    return result;
}

//
// Do page table lookup for address given by 'entry->lowVA' and either fill
// byref argument 'entry' or trigger exception
//
static riscvException doPageTableLookup(
    riscvP    riscv,
    riscvMode mode,
    tlbEntryP entry,
    memPriv   requiredPriv
) {
    riscvException result;

    if(activeTLBIsVS2(riscv)) {
        result = doPageTableLookupGPA(riscv, mode, entry, requiredPriv);
    } else {
        result = doPageTableLookupVA(riscv, mode, entry, requiredPriv);
    }

    return result;
}


////////////////////////////////////////////////////////////////////////////////
// TLB UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Forward reference
//
static void deleteTLBEntry(riscvP riscv, riscvTLBP tlb, tlbEntryP entry);

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
// If this is a stage 2 TLB entry, return the Guest PTW domain
//
inline static memDomainP getGPTWDomain(riscvP riscv, tlbEntryP entry) {
    return (entry->tlb==RISCV_TLB_VS2) ? riscv->guestPTWDomain : 0;
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
        memDomainP gptwDomain = getGPTWDomain(riscv, entry);
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

        if(gptwDomain) {
            vmirtUnaliasMemoryVM(gptwDomain, lowVA, highVA, ASIDMask, fullASID);
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
static tlbEntryP allocateTLBEntry(riscvP riscv, riscvTLBP tlb, tlbEntryP base) {

    // get new entry structure
    tlbEntryP entry = newTLBEntry(tlb);

    // artifact load/store accesses must be marked as such
    base->artifact = riscv->artifactLdSt;

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

    // delete entries in the indicated TLB
    ITER_TLB_ENTRY_RANGE(
        riscv, tlb, lowVA, highVA, entry,
        deleteTLBEntryMask(riscv, tlb, entry, mask, match)
    );

    // if G-stage operation, also delete all VS entries with matching VMID
    if((id==RISCV_TLB_VS2) && !riscv->configInfo.fence_g_preserves_vs) {

        riscvTLBP tlb = riscv->tlb[RISCV_TLB_VS1];

        ITER_TLB_ENTRY_RANGE(
            riscv, tlb, 0, -1, entry,
            deleteTLBEntryMask(riscv, tlb, entry, mask, match)
        );
    }
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
// Take exception on invalid access
//
static void handleInvalidAccess(
    riscvP         riscv,
    Uns64          VA,
    riscvException exception
) {
    // take exception only if not an artifact access
    if(!riscv->artifactAccess) {

        // if failure is at stage 2, record failing VA as guest physical address
        if(activeTLBIsVS2(riscv)) {
            riscv->GPA = VA>>2;
        }

        // take exception, indicating guest virtual address if required
        Bool GVA = activeTLBIsVirtual(riscv);
        riscvTakeMemoryExceptionGVA(riscv, exception, riscv->s1VA, GVA);
    }
}

//
// Take page fault exception for an invalid access
//
static void handlePageFault(
    riscvP    riscv,
    tlbEntryP entry,
    Uns64     VA,
    memPriv   requiredPriv,
    pteError  error
) {
    riscvException exception = getPageFault(riscv, entry, requiredPriv, error);

    // take exception
    handleInvalidAccess(riscv, VA, exception);
}

//
// Macro encapsulating PTW error generation
//
#define PAGE_FAULT(_CODE) \
    handlePageFault(riscv, entry, VA, requiredPriv, PTEE_##_CODE); \
    return 0;

//
// Find or create a TLB entry for the passed VA
//
static tlbEntryP findOrCreateTLBEntry(
    riscvP      riscv,
    riscvMode   mode,
    tlbMapInfoP miP
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

        // entry is invalid (custom TLB only, if that creates invalid entries)
        VMI_ASSERT(entry->custom, "not custom TLB entry");  // LCOV_EXCL_LINE
        PAGE_FAULT(V0);                                     // LCOV_EXCL_LINE

    } else if((entry->priv&MEM_PRIV_RW) == MEM_PRIV_W) {

        // illegal permission combination (custom TLB only)
        VMI_ASSERT(entry->custom, "not custom TLB entry");
        PAGE_FAULT(R0W1);

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
        riscvException exception = doPageTableLookup(
            riscv, mode, &tmp, requiredPriv
        );

        // do lookup, handling any exception that is signalled
        if(riscv->exception) {
            // ignore first stage exception if second stage PTW already taken
        } else if(!exception) {
            entry = allocateTLBEntry(riscv, tlb, &tmp);
            priv  = checkEntryPermission(riscv, mode, entry, requiredPriv);
        } else {
            handleInvalidAccess(riscv, VA, exception);
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
        memDomainP dataDomain = getPMPDomainPriv(riscv, mode, MEM_PRIV_R);

        vmirtAliasMemoryVM(
            dataDomain, hlvxDomain, lowPA, highPA, lowVA, 0, MEM_PRIV_R,
            ASIDMask, ASID
        );

        // HLVX is a load for the purposes of PMP/PMA that follow
        requiredPriv = MEM_PRIV_R;
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
    riscvP      riscv,
    riscvTLBId  id,
    riscvMode   mode,
    tlbMapInfoP miP
) {
    // activate the indicated TLB
    riscvTLBId oldTLB = activateTLB(riscv, id);

    // do TLB mapping
    tlbEntryP entry = findOrCreateTLBEntry(riscv, mode, miP);

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
    riscvP      riscv,
    Uns64       VA,
    Uns64       GPA,
    riscvMode   mode,
    memPriv     requiredPriv,
    tlbMapInfoP miP
) {
    tlbMapInfo mi2 = {lowVA:GPA, priv:requiredPriv};

    // map second stage TLB entry
    tlbEntryP entry = getTLBStageEntry(riscv, RISCV_TLB_VS2, mode, &mi2);

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

    if(!old) {
        riscv->s1VA = 0;
    }
}

//
// Try mapping memory at the passed address for the specified access type and
// return a status code indicating whether the mapping succeeded
//
static Bool tlbMiss(
    riscvP      riscv,
    memDomainP  domain,
    riscvMode   mode,
    tlbMapInfoP miP
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
    tlbEntryP entry1 = getTLBStageEntry(riscv, id, mode, miP);
    tlbEntryP entry2 = 0;

    // map second stage TLB entry if required
    if(entry1 && doStage2(riscv, id)) {

        // determine guest physical address
        GPA = VA + entry1->PA - entry1->lowVA;

        // do stage 2 lookup
        entry2 = lookupStage2(riscv, VA, GPA, mode, requiredPriv, miP);

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
static Bool tlbMissGPTW(riscvP riscv, memDomainP domain, tlbMapInfoP miP) {

    riscvException exception    = riscv->exception;
    riscvMode      mode         = RISCV_MODE_VS;
    memPriv        requiredPriv = miP->priv;
    Uns64          GPA          = miP->lowVA;

    // set original access privilege if required
    memPriv oldPriv = pushOriginalVAPriv(riscv, GPA, requiredPriv);

    // clear current exception state
    riscv->exception = 0;

    // map the stage 2 TLB entry
    tlbEntryP entry = lookupStage2(riscv, GPA, GPA, mode, requiredPriv, miP);

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


////////////////////////////////////////////////////////////////////////////////
// MEMORY DOMAIN MANAGEMENT
////////////////////////////////////////////////////////////////////////////////

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
static Bool createPMADomain(
    riscvP    riscv,
    riscvMode mode,
    Bool      isCode,
    Bool      separate
) {
    memDomainP extDomain   = riscv->extDomains[isCode];
    memDomainP otherDomain = riscv->extDomains[!isCode];
    Bool       unified     = !separate && (extDomain==otherDomain);
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
static Bool createPMPDomain(
    riscvP    riscv,
    riscvMode mode,
    Bool      isCode,
    Bool      separate
) {
    memDomainP pmaDomain   = getPMADomainCorD(riscv, mode,  isCode);
    memDomainP otherDomain = getPMADomainCorD(riscv, mode, !isCode);
    Bool       unified     = !separate && (pmaDomain==otherDomain);
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
static Bool createPhysicalDomain(
    riscvP    riscv,
    riscvMode mode,
    Bool      isCode,
    Bool      separate
) {
    memDomainP pmpDomain   = getPMPDomainCorD(riscv, mode,  isCode);
    memDomainP otherDomain = getPMPDomainCorD(riscv, mode, !isCode);
    Bool       unified     = !separate && (pmpDomain==otherDomain);
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
static Bool createVirtualDomain(
    riscvP      riscv,
    riscvVMMode vmMode,
    Bool        isCode,
    Bool        separate
) {
    riscvMode  mode     = vmmodeToMode(vmMode);
    memDomainP pmpCode  = getPMPDomainCorD(riscv, mode, True);
    memDomainP pmpData  = getPMPDomainCorD(riscv, mode, False);
    Bool       unified  = !separate && (pmpCode==pmpData);
    Uns32      xlenBits = riscvGetXlenArch(riscv);

    // create virtual domain if not already done (if XLEN is writable)
    if(!riscv->vmDomains[vmMode][isCode]) {
        riscv->vmDomains[vmMode][isCode] = createDomain(
            mode, "Virtual", xlenBits, isCode, unified
        );
    }

    return unified;
}

//
// Create new HLVX domain for the given mode
//
static void createHLVXDomain(riscvP riscv, riscvVMMode vmMode) {

    riscvMode mode     = vmmodeToMode(vmMode);
    riscvMode baseMode = getBaseMode(mode);
    Uns32     xlenBits = riscvGetXlenArch(riscv);

    // create HLVX domain if not already done (if XLEN is writable)
    if(!riscv->hlvxDomains[baseMode]) {
        riscv->hlvxDomains[baseMode] = createDomain(
            mode, "HLVX", xlenBits, True, False
        );
    }
}

//
// Create new CLIC domain at cluster root level
//
static memDomainP createCLICDomain(riscvP riscv, memDomainP dataDomain) {

    riscvP root = riscv->clusterRoot;

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

        // create CLINT memory-mapped block if required
        if(CLINTInternal(riscv)) {
            riscvMapCLINTDomain(riscv, CLICDomain);
        }

        // create CLIC memory-mapped block if required
        if(CLICInternal(riscv)) {
            riscvMapCLICDomain(riscv, CLICDomain);
        }

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
// Does any extension require distinct physical memory domains?
//
static Bool requireDistinctPhysMem(riscvP riscv) {

    Bool distinctPhysMem = False;

    ITER_EXT_CB_WHILE(
        riscv, extCB, distinctPhysMem, !distinctPhysMem,
        distinctPhysMem = extCB->distinctPhysMem(riscv, extCB->clientData)
    )

    return distinctPhysMem;
}

//
// Create PMA, PMP and physical domains
//
static void createPhysicalDomains(riscvP riscv, riscvMode mode) {

    // if an extension implements custom physical memory extensions (e.g.
    // local memory blocks) then separate PMA/PMP code/data domains must be
    // created in case these are modified in different ways
    Bool distinctPhysMem = requireDistinctPhysMem(riscv);

    // create PMA data and code domains for this mode
    if(createPMADomain(riscv, mode, False, distinctPhysMem)) {
        riscv->pmaDomains[mode][1] = riscv->pmaDomains[mode][0];
    } else {
        createPMADomain(riscv, mode, True, distinctPhysMem);
    }

    // create PMP data and code domains for this mode
    if(createPMPDomain(riscv, mode, False, distinctPhysMem)) {
        riscv->pmpDomains[mode][1] = riscv->pmpDomains[mode][0];
    } else {
        createPMPDomain(riscv, mode, True, distinctPhysMem);
    }

    // create physical data and code domains for this mode
    if(createPhysicalDomain(riscv, mode, False, distinctPhysMem)) {
        riscv->physDomains[mode][1] = riscv->physDomains[mode][0];
    } else {
        createPhysicalDomain(riscv, mode, True, distinctPhysMem);
    }
}

//
// Create virtual domains
//
static void createVirtualDomains(riscvP riscv, riscvVMMode vmMode) {

    // if an extension implements custom physical memory extensions (e.g.
    // local memory blocks) then separate PMA/PMP code/data domains must be
    // created in case these are modified in different ways
    Bool distinctPhysMem = requireDistinctPhysMem(riscv);

    if(createVirtualDomain(riscv, vmMode, False, distinctPhysMem)) {
        riscv->vmDomains[vmMode][1] = riscv->vmDomains[vmMode][0];
    } else {
        createVirtualDomain(riscv, vmMode, True, distinctPhysMem);
    }
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
    if(CLINTInternal(riscv) || CLICInternal(riscv)) {
        dataDomain = createCLICDomain(riscv, dataDomain);
    }

    // set internal code and data domains
    vmirtSetProcessorInternalCodeDomain(processor, codeDomain);
    vmirtSetProcessorInternalDataDomain(processor, dataDomain);

    // save external domains (including CLIC block) for lazy PMA mapping
    riscv->extDomains[0] = dataDomain;
    riscv->extDomains[1] = codeDomain;

    // create M/S mode PMA, PMP and physical domains if required
    createPhysicalDomains(riscv, RISCV_MODE_S);
    createPhysicalDomains(riscv, RISCV_MODE_M);

    // use S mode PMA and PMP domains for U mode
    riscv->pmaDomains[RISCV_MODE_U][0] = riscv->pmaDomains[RISCV_MODE_S][0];
    riscv->pmaDomains[RISCV_MODE_U][1] = riscv->pmaDomains[RISCV_MODE_S][1];
    riscv->pmpDomains[RISCV_MODE_U][0] = riscv->pmpDomains[RISCV_MODE_S][0];
    riscv->pmpDomains[RISCV_MODE_U][1] = riscv->pmpDomains[RISCV_MODE_S][1];

    if(mpuPresent(riscv)) {
#if(ENABLE_SSMPU)
        // create unique U mode physical domains
        createPhysicalDomains(riscv, RISCV_MODE_U);
        setMPUPriv(riscv, RISCV_MODE_U, 0, -1, MEM_PRIV_NONE, True);

        // create unique VS and VU mode physical domains if required
        if(riscvHasMode(riscv, RISCV_MODE_VU)) {
            createPhysicalDomains(riscv, RISCV_MODE_VS);
            createPhysicalDomains(riscv, RISCV_MODE_VU);
            setMPUPriv(riscv, RISCV_MODE_VU, 0, -1, MEM_PRIV_NONE, True);
        }
#endif
    } else {

        // use S mode physical domain for U, VS and VU modes
        memDomainP dataDomainS = riscv->physDomains[RISCV_MODE_S][0];
        memDomainP codeDomainS = riscv->physDomains[RISCV_MODE_S][1];

        riscv->physDomains[RISCV_MODE_U][0]  = dataDomainS;
        riscv->physDomains[RISCV_MODE_U][1]  = codeDomainS;
        riscv->physDomains[RISCV_MODE_VS][0] = dataDomainS;
        riscv->physDomains[RISCV_MODE_VS][1] = codeDomainS;
        riscv->physDomains[RISCV_MODE_VU][0] = dataDomainS;
        riscv->physDomains[RISCV_MODE_VU][1] = codeDomainS;
    }

    // allow derived model to update physical domains
    ITER_EXT_CB(
        riscv, extCB, installPhysMem,
        extCB->installPhysMem(riscv, extCB->clientData);
    )

    // create guest physical domain if required
    if(hypervisorPresent(riscv)) {
        riscv->guestPTWDomain = createDomain(
            RISCV_MODE_H, "Guest PTW", 64, False, True
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
                createVirtualDomains(riscv, vmMode);

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
// Return the class, mode and code/data indication for the given domain, or
// class DT_NONE if the domain is not a known processor domain
//
static domainType getDomainType(
    riscvP     riscv,
    memDomainP domain,
    riscvMode *modeP,
    Bool      *isCodeP
) {
    domainType dt = DT_NONE;
    Int32      mode;
    Uns32      isCode;

    for(isCode=0; !dt && (isCode<2); isCode++) {

        for(mode=RISCV_MODE_LAST-1; !dt && (mode>=0); mode--) {

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

            // return by-ref results
            if(dt) {
                *modeP   = mode;
                *isCodeP = isCode;
            }
        }
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
    Uns64     oldVA   = riscv->originalVA;
    Bool      oldHVLX = riscv->hlvxActive;
    Bool      oldAA   = riscv->artifactAccess;
    Bool      oldALS  = riscv->artifactLdSt;
    Bool      miss    = False;
    riscvMode mode    = 0;
    Bool      isCode  = False;

    // artifact accesses should cause no exceptions
    if(MEM_AA_IS_ARTIFACT_ACCESS(attrs)) {
        riscv->artifactAccess = True;
        riscv->artifactLdSt  |= ((requiredPriv&MEM_PRIV_RW) && True);
    }

    // record original VA that might initiate a fault (for syndrome address
    // offset calculation)
    riscv->originalVA = address;

    // start HLVX access if required
    riscv->hlvxActive |= startHLVX(riscv, &domain, &requiredPriv);

    // assume any Access Fault error generated here will be a Bus Error
    riscv->AFErrorIn = riscv_AFault_Bus;

    // identify access to a mapped domain
    domainType dt = getDomainType(riscv, domain, &mode, &isCode);

    if(dt==DT_VIRT) {

        // access to virtually-mapped domain
        Uns64      lastVA = address+bytes-1;
        tlbMapInfo mi     = {highVA:address-1};

        // iterate while unprocessed regions remain
        do {

            mi.lowVA  = mi.highVA+1;
            mi.highVA = lastVA;
            mi.priv   = requiredPriv;

            miss = tlbMiss(riscv, domain, mode, &mi);

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

            miss = tlbMissGPTW(riscv, domain, &mi);

        } while(!miss && ((lastVA<mi.lowVA) || (lastVA>mi.highVA)));

    } else if(dt) {

        // direct physical access or a page table walk using the PMP domain
        Uns64 lowPA  = address;
        Uns64 highPA = address+bytes-1;

        // update MPU mapping if required
#if(ENABLE_SSMPU)
        if(!miss) {
            miss = mapMPU(riscv, mode, requiredPriv, lowPA, highPA);
        }
#endif

        // update PMP mapping if required
        if(!miss) {
            mapPMP(riscv, mode, requiredPriv, lowPA, highPA);
        }

        // update PMA mapping if required
        if(!miss) {
            mapPMA(riscv, mode, requiredPriv, lowPA, highPA);
        }
    }

    // restore hlvxActive and artifactAccess
    riscv->originalVA     = oldVA;
    riscv->hlvxActive     = oldHVLX;
    riscv->artifactAccess = oldAA;
    riscv->artifactLdSt   = oldALS;

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

    // record data access mode (affects endianness and xstatus.GVA on fault)
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

        // include previous virtual mode setting if required
        if((modeMPP!=RISCV_MODE_M) && RD_CSR_FIELD64(riscv, mstatus, MPV)) {
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
        allocateTLBEntry(riscv, tlb, &tmp);
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

    savePMP(riscv, cxt);
#if(ENABLE_SSMPU)
    saveMPU(riscv, cxt);
#endif

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

    restorePMP(riscv, cxt);
#if(ENABLE_SSMPU)
    restoreMPU(riscv, cxt);
#endif

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


