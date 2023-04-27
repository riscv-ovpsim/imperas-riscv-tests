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

// VMI header files
#include "vmi/vmiCxt.h"
#include "vmi/vmiMessage.h"
#include "vmi/vmiMt.h"
#include "vmi/vmiRt.h"

// model header files
#include "riscvBlockState.h"
#include "riscvCSR.h"
#include "riscvDecode.h"
#include "riscvDecodeTypes.h"
#include "riscvExceptions.h"
#include "riscvFunctions.h"
#include "riscvMessage.h"
#include "riscvMode.h"
#include "riscvStructure.h"
#include "riscvTrigger.h"
#include "riscvUtils.h"
#include "riscvVariant.h"
#include "riscvVM.h"


//
// Is the RISC-V object a Hart (not a container)
//
inline static Bool isHart(riscvP riscv) {
    return !vmirtGetSMPChild((vmiProcessorP)riscv);
}

//
// Write a net port
//
inline static void writeNet(riscvP riscv, Uns32 handle, Uns32 value) {
    if(handle) {
        vmirtWriteNetPort((vmiProcessorP)riscv, handle, value);
    }
}

//
// Does the processor mode use XLEN=64?
//
inline static Bool modeIsXLEN64(riscvP riscv, riscvMode mode) {
    return riscv->xlenMask & (1<<mode);
}

//
// Does the processor mode use XLEN=64?
//
Bool riscvModeIsXLEN64(riscvP riscv, riscvMode mode) {
    return modeIsXLEN64(riscv, mode);
}

//
// Is Zfinx enabled in the current processor mode?
//
static Bool enableZfinx(riscvP riscv) {

    return (
        Zfinx(riscv) &&
        (
            !(RD_CSR_MASK64(riscv, mstateen[0]) & WM64_stateen_Zfinx) ||
            riscvStateenFeatureEnabled(riscv, bit_stateen_Zfinx, False)
        )
    );
}

//
// Update the currently-enabled architecture settings
//
void riscvSetCurrentArch(riscvP riscv) {

    riscvMode mode  = getCurrentMode5(riscv);
    Uns32     XL    = modeIsXLEN64(riscv, mode) ? 2 : 1;
    Bool      V     = inVMode(riscv);
    Bool      FS_HS = RD_CSR_FIELDC(riscv, mstatus,  FS);
    Bool      FS_VS = RD_CSR_FIELDC(riscv, vsstatus, FS) || !V;
    Bool      FS    = (FS_HS && FS_VS) || enableZfinx(riscv);

    // derive new architecture value based on misa value, preserving rounding
    // mode invalid setting
    riscvArchitecture arch = (
        (riscv->currentArch & ISA_RM_INVALID)  |
        RD_CSR_FIELDC(riscv, misa, Extensions) |
        (XL << XLEN_SHIFT)                     |
        (FS << MSTATUS_FS_SHIFT)
    );

    // mstatus.FS=0 disables floating point extensions
    if(!FS) {
        arch &= ~ISA_DF;
    }

    // mstatus.VS=0 disables vector extensions (if implemented)
    if(arch & ISA_V) {

        Uns32 WM_mstatus_VS = 0;

        // get mask of dirty bits for mstatus.VS in either 0.8 or 0.9 location
        if(riscvVFSupport(riscv, RVVF_VS_STATUS_8)) {
            WM_mstatus_VS = WM_mstatus_VS_8;
        } else if(riscvVFSupport(riscv, RVVF_VS_STATUS_9)) {
            WM_mstatus_VS = WM_mstatus_VS_9;
        }

        if(!WM_mstatus_VS) {
            // no action
        } else if(!(RD_CSRC(riscv, mstatus) & WM_mstatus_VS)) {
            arch &= ~ISA_V;
        } else if(!V) {
            // no action
        } else if(!(RD_CSRC(riscv, vsstatus) & WM_mstatus_VS)) {
            arch &= ~ISA_V;
        }
    }

    // handle big endian access if required
    if(riscvGetCurrentDataEndian(riscv)) {
        arch |= ISA_BE;
    }

    // handle SPVP if required (for HLV, HLVX and HSV instructions)
    if(RD_CSR_FIELDC(riscv, hstatus, SPVP)) {
        arch |= ISA_SPVP;
    }

    // handle hstatus.VSBE if required (for HLV, HLVX and HSV instructions)
    if(RD_CSR_FIELDC(riscv, hstatus, VSBE)) {
        arch |= ISA_VSBE;
    }

    // handle vsstatus.UBE if required (for HLV, HLVX and HSV instructions)
    if(RD_CSR_FIELDC(riscv, vsstatus, UBE)) {
        arch |= ISA_VUBE;
    }

    // handle hstatus.HU if required (for HLV, HLVX and HSV instructions)
    if(RD_CSR_FIELDC(riscv, hstatus, HU)) {
        arch |= ISA_HU;
    }

    // indicate whether virtual machine virtual memory is enabled (for HLV,
    // HLVX and HSV instructions)
    if(RD_CSR_FIELD_VS(riscv, vsatp, MODE) || RD_CSR_FIELD_S(riscv, hgatp, MODE)) {
        arch |= ISA_VVM;
    }

    // handle MXLEN state
    if(modeIsXLEN64(riscv, RISCV_MODE_M)) {
        arch |= ISA_MXL64;
    }

    // handle SXLEN state
    if(modeIsXLEN64(riscv, RISCV_MODE_S)) {
        arch |= ISA_SXL64;
    }

    // handle UXLEN state
    if(modeIsXLEN64(riscv, RISCV_MODE_U)) {
        arch |= ISA_UXL64;
    }

    // handle VSXLEN state
    if(modeIsXLEN64(riscv, RISCV_MODE_VS)) {
        arch |= ISA_VSXL64;
    }

    // handle VUXLEN state
    if(modeIsXLEN64(riscv, RISCV_MODE_VU)) {
        arch |= ISA_VUXL64;
    }

    // handle trigger state
    arch |= riscvGetCurrentTriggers(riscv);

    // handle dynamic BFLOAT16 state
    if(riscv->usingBF16) {
        arch |= ISA_BF16;
    }

    if(riscv->currentArch != arch) {

        vmiProcessorP processor = (vmiProcessorP)riscv;

        // update current block mask to match architecture
        vmirtSetBlockMask64(processor, &riscv->currentArch, arch);
    }
}

//
// Update dynamic BFLOAT16 state
//
void riscvUpdateDynamicBF16(riscvP riscv, Bool newBF16) {

    if(riscv->usingBF16 != newBF16) {

        // update dynamic BF16 state
        riscv->usingBF16 = newBF16;

        // flush dictionaries if dynamic BF16 check is required
        if(!riscv->dynamicBF16) {
            riscv->dynamicBF16 = True;
            vmirtFlushAllDicts((vmiProcessorP)riscv);
        }
    }
}

//
// Return XLEN for the given riscvArchitecture
//
inline static Uns32 archToXLEN(riscvArchitecture arch) {

    Uns32 result = 0;

    if(arch & ISA_XLEN_64) {
        result = 64;
    } else if(arch & ISA_XLEN_32) {
        result = 32;
    } else {
        VMI_ABORT("invalid XLEN"); // LCOV_EXCL_LINE
    }

    return result;
}

//
// Return FLEN for the given riscvArchitecture
//
inline static Uns32 archToFLEN(riscvArchitecture arch) {

    Uns32 result = 0;

    if(arch & ISA_D) {
        result = 64;
    } else if(arch & ISA_F) {
        result = 32;
    }

    return result;
}

//
// Return the current XLEN
//
Uns32 riscvGetXlenMode(riscvP riscv) {
    return archToXLEN(riscv->currentArch);
}

//
// Return the current FLEN
//
Uns32 riscvGetFlenMode(riscvP riscv) {
    return archToFLEN(riscv->currentArch);
}

//
// Return the configured XLEN (may not be the current XLEN if dynamic update
// of XLEN is allowed)
//
Uns32 riscvGetXlenArch(riscvP riscv) {
    return archToXLEN(riscv->configInfo.arch);
}

//
// Return the configured FLEN (may not be the current FLEN if dynamic update
// of FLEN is allowed)
//
Uns32 riscvGetFlenArch(riscvP riscv) {
    return archToFLEN(riscv->configInfo.arch);
}

//
// Register extension callback block for the id with the base model
//
void riscvRegisterExtCB(riscvP riscv, riscvExtCBP extCB, Uns32 id) {

    riscvExtCBPP tail = &riscv->extCBs;
    riscvExtCBP  this;

    while((this=*tail)) {
        tail = &this->next;
    }

    *tail = extCB;
    extCB->next = 0;
    extCB->id   = id;
}

//
// Return the indexed extension's extCB clientData
//
void *riscvGetExtClientData(riscvP riscv, Uns32 id) {

    riscvExtCBP this = riscv->extCBs;

    while(this && (this->id!=id)) {
        this = this->next;
    }

    return this ? this->clientData : 0;
}

//
// Return extension configuration with the given id
//
riscvExtConfigCP riscvGetExtConfig(riscvP riscv, Uns32 id) {

    riscvExtConfigCPP extCfgs = riscv->configInfo.extensionConfigs;
    riscvExtConfigCP  extCfg  = 0;

    if(extCfgs) {
        while((extCfg=*extCfgs) && (extCfg->id!=id)) {
            extCfgs++;
        }
    }

    return extCfg;
}

//
// Does the processor support configurable endianness?
//
Bool riscvSupportEndian(riscvP riscv) {
    return (RISCV_PRIV_VERSION(riscv)>=RVPV_1_12);
}

//
// Return endianness for data access in the given mode
//
memEndian riscvGetDataEndian(riscvP riscv, riscvMode mode) {

    memEndian result = riscv->dendian;

    if(!riscvSupportEndian(riscv)) {
        // no action
    } else if(mode==RISCV_MODE_U) {
        result = RD_CSR_FIELDC(riscv, mstatus, UBE);
    } else if(mode==RISCV_MODE_S) {
        result = RD_CSR_FIELD64(riscv, mstatus, SBE);
    } else if(mode==RISCV_MODE_M) {
        result = RD_CSR_FIELD64(riscv, mstatus, MBE);
    } else if(mode==RISCV_MODE_VU) {
        result = RD_CSR_FIELDC(riscv, vsstatus, UBE);
    } else if(mode==RISCV_MODE_VS) {
        result = RD_CSR_FIELDC(riscv, hstatus, VSBE);
    } else {
        VMI_ABORT("invalid mode"); // LCOV_EXCL_LINE
    }

    return result;
}

//
// Return endianness for data access in the current mode
//
memEndian riscvGetCurrentDataEndian(riscvP riscv) {
    return riscvGetDataEndian(riscv, riscv->dataMode);
}

//
// Return endianness of access
//
VMI_ENDIAN_FN(riscvGetEndian) {

    riscvP riscv = (riscvP)processor;

    if(isFetch) {
        return MEM_ENDIAN_LITTLE;
    } else {
        return riscvGetCurrentDataEndian(riscv);
    }
}

//
// Return next PC after the given PC
//
VMI_NEXT_PC_FN(riscvNextPC) {

    // calculate nextPC ignoring wrapping
    riscvP riscv  = (riscvP)processor;
    Uns64  nextPC = thisPC + riscvGetInstructionSize(riscv, thisPC);

    // allow for wrapping if XLEN is 32
    if(riscvGetXlenMode(riscv)==32) {
        nextPC &= 0xffffffff;
    }

    return nextPC;
}

//
// Does the processor implement the given mode?
//
Bool riscvHasMode(riscvP riscv, riscvMode mode) {

    switch(mode) {
        case RISCV_MODE_U:
            return riscv->configInfo.arch & ISA_U;
        case RISCV_MODE_S:
            return riscv->configInfo.arch & ISA_S;
        case RISCV_MODE_VU:
        case RISCV_MODE_VS:
            return riscv->configInfo.arch & ISA_H;
        case RISCV_MODE_M:
            return True;
        case RISCV_MODE_D:
            return riscv->configInfo.debug_mode;
        default:
            return False;
    }
}

//
// Macros used to determine whether 64-bit XLEN is in use
//
#define USE_XLEN_64C(_P, _R, _F) (RD_CSR_FIELDC(_P, _R, _F) ==2)
#define USE_XLEN_64(_P, _R, _F)  (RD_CSR_FIELD64(_P, _R, _F)==2)

//
// Macros used to determine whether 64-bit XLEN is variable
//
#define VAR_XLENC(_P, _R, _F)  (RD_CSR_MASK_FIELDC(_P, _R, _F) ==3)
#define VAR_XLEN64(_P, _R, _F) (RD_CSR_MASK_FIELD64(_P, _R, _F)==3)

//
// Macros used to determine whether 32-bit XLEN is present
//
#define HAS_XLEN_32C(_P, _RV, _RM, _F) \
    !USE_XLEN_64C(_P, _RV, _F) || (VAR_XLENC(_P, _RM, _F))
#define HAS_XLEN_32(_P, _RV, _RM, _F) \
    !USE_XLEN_64(_P, _RV, _F)  || (VAR_XLEN64(_P, _RM, _F))

//
// Macros used to determine whether 64-bit XLEN is present
//
#define HAS_XLEN_64C(_P, _RV, _RM, _F) \
    USE_XLEN_64C(_P, _RV, _F) || (VAR_XLENC(_P, _RM, _F))
#define HAS_XLEN_64(_P, _RV, _RM, _F) \
    USE_XLEN_64(_P, _RV, _F)  || (VAR_XLEN64(_P, _RM, _F))

//
// Does the given mode have variable XLEN?
//
Bool riscvHasVariableXLEN(riscvP riscv, riscvMode mode) {

    switch(mode) {
        case RISCV_MODE_U:
            return VAR_XLEN64(riscv, mstatus, UXL);
        case RISCV_MODE_H:
        case RISCV_MODE_S:
            return VAR_XLEN64(riscv, mstatus, SXL);
        case RISCV_MODE_VU:
            return VAR_XLEN64(riscv, mstatus, UXL);
        case RISCV_MODE_VS:
            return VAR_XLENC(riscv, hstatus, VSXL);
        case RISCV_MODE_M:
        case RISCV_MODE_D:
            return VAR_XLEN64(riscv, misa, MXL);
        default:
            VMI_ABORT("invalid mode");  // LCOV_EXCL_LINE
            return False;               // LCOV_EXCL_LINE
    }
}

//
// Does the processor implement the given mode for 32-bit XLEN?
//
Bool riscvHasXLEN32(riscvP riscv, riscvMode mode) {

    switch(mode) {
        case RISCV_MODE_U:
            return HAS_XLEN_32(riscv, mstatus, mstatus, UXL);
        case RISCV_MODE_H:
        case RISCV_MODE_S:
            return HAS_XLEN_32(riscv, mstatus, mstatus, SXL);
        case RISCV_MODE_VU:
            return HAS_XLEN_32(riscv, vsstatus, mstatus, UXL);
        case RISCV_MODE_VS:
            return HAS_XLEN_32C(riscv, hstatus, hstatus, VSXL);
        case RISCV_MODE_M:
        case RISCV_MODE_D:
            return HAS_XLEN_32(riscv, misa, misa, MXL);
        default:
            VMI_ABORT("invalid mode");  // LCOV_EXCL_LINE
            return False;               // LCOV_EXCL_LINE
    }
}

//
// Does the processor implement the given mode for 64-bit XLEN?
//
Bool riscvHasXLEN64(riscvP riscv, riscvMode mode) {

    switch(mode) {
        case RISCV_MODE_U:
            return HAS_XLEN_64(riscv, mstatus, mstatus, UXL);
        case RISCV_MODE_H:
        case RISCV_MODE_S:
            return HAS_XLEN_64(riscv, mstatus, mstatus, SXL);
        case RISCV_MODE_VU:
            return HAS_XLEN_64(riscv, vsstatus, mstatus, UXL);
        case RISCV_MODE_VS:
            return HAS_XLEN_64C(riscv, hstatus, hstatus, VSXL);
        case RISCV_MODE_M:
        case RISCV_MODE_D:
            return HAS_XLEN_64(riscv, misa, misa, MXL);
        default:
            VMI_ABORT("invalid mode");  // LCOV_EXCL_LINE
            return False;               // LCOV_EXCL_LINE
    }
}

//
// Does the processor implement the given dictionary mode?
//
Bool riscvHasDMode(riscvP riscv, riscvDMode dMode) {

    riscvMode mode = dmodeToMode5(dMode);

    if(!riscvHasMode(riscv, mode))  {
        return False;
    } else if(dmodeIsXLEN64(dMode)) {
        return riscvHasXLEN64(riscv, mode);
    } else {
        return riscvHasXLEN32(riscv, mode);
    }
}

//
// Table of processor mode descriptions
//
// NOTE: The CPU Helper depends on the low order 2 bits of the code
//       matching the privilege level encoding for the mstatus.MPP field
//       defined in table 1.1 of RISC-V Privileged Architectures V1.10
//
static const vmiModeInfo modes[] = {

    [RISCV_MODE_U] = {
        .name        = "User",
        .code        = RISCV_MODE_U,
        .description = "User mode"
    },

    [RISCV_MODE_S] = {
        .name        = "Supervisor",
        .code        = RISCV_MODE_S,
        .description = "Supervisor mode"
    },

    [RISCV_MODE_H] = {
        .name        = "Hypervisor",
        .code        = RISCV_MODE_H,
        .description = "Hypervisor mode"
    },

    [RISCV_MODE_M] = {
        .name        = "Machine",
        .code        = RISCV_MODE_M,
        .description = "Machine mode"
    },

    [RISCV_MODE_VU] = {
        .name        = "Virtual-User",
        .code        = RISCV_MODE_VU,
        .description = "Virtual User mode"
    },

    [RISCV_MODE_VS] = {
        .name        = "Virtual-Supervisor",
        .code        = RISCV_MODE_VS,
        .description = "Virtual Supervisor mode"
    },

    [RISCV_MODE_D] = {
        .name        = "Debug",
        .code        = RISCV_MODE_D,
        .description = "Debug mode"
    },

    // terminator
    {0}
};

//
// Get mode name for the indexed mode
//
const char *riscvGetModeName(riscvMode mode) {
    return modes[mode].name;
}

//
// Get current mode
//
VMI_GET_MODE_FN(riscvGetMode) {

    riscvP riscv = (riscvP)processor;

    return &modes[inDebugMode(riscv) ? RISCV_MODE_D : getCurrentMode5(riscv)];
}

//
// Change processor mode
//
void riscvSetMode(riscvP riscv, riscvMode mode) {

    Bool       xlen64 = modeIsXLEN64(riscv, mode);
    riscvDMode dMode  = modeToDMode(mode, xlen64);
    Bool       V      = modeIsVirtual(mode);

    // consolidate floating point flags on CSR view (in case of switch between
    // normal and virtual modes)
    riscvConsolidateFPFlags(riscv);

    // if executing in supervisor or user mode, include VM-enabled indication
    if(mode==RISCV_MODE_M) {
        // no action
    } else if(RD_CSR_FIELD_V(riscv, satp, V, MODE)) {
        dMode |= RISCV_DMODE_VM;
    } else if(V && RD_CSR_FIELD_S(riscv, hgatp, MODE)) {
        dMode |= RISCV_DMODE_VM;
    }

    // update mode if it has changed
    if(riscv->mode != dMode) {
        riscv->mode = dMode;
        vmirtSetMode((vmiProcessorP)riscv, dMode);
    }

    // refresh current data domain (may be modified by mstatus.MPRV, and may
    // have changed while taking an exception even if mode has not changed)
    riscvVMRefreshMPRVDomain(riscv);

    // update current architecture to take into account changes from
    // riscvVMRefreshMPRVDomain
    riscvSetCurrentArch(riscv);

    // update active mode output signal (external CLIC)
    writeNet(riscv, riscv->sec_lvl_Handle, mode);
}

//
// Return derived XLEN mask
//
static Uns32 getXLENMask(riscvP riscv) {

    Uns8 xlenMask = 0;

    // derive new XLEN-per-mode mask
    if(USE_XLEN_64(riscv, mstatus, UXL)) {
        xlenMask |= (1<<RISCV_MODE_U);
    }
    if(USE_XLEN_64(riscv, mstatus, SXL)) {
        xlenMask |= (1<<RISCV_MODE_H);
        xlenMask |= (1<<RISCV_MODE_S);
    }
    if(USE_XLEN_64(riscv, vsstatus, UXL)) {
        xlenMask |= (1<<RISCV_MODE_VU);
    }
    if(USE_XLEN_64C(riscv, hstatus, VSXL)) {
        xlenMask |= (1<<RISCV_MODE_VS);
    }
    if(USE_XLEN_64(riscv, misa, MXL)) {
        xlenMask |= (1<<RISCV_MODE_M);
    }

    return xlenMask;
}

//
// Refresh XLEN mask and current mode when required
//
void riscvRefreshXLEN(riscvP riscv) {

    Uns8 xlenMask = getXLENMask(riscv);

    // handle change to mask unless in save/restore mode (in which case all
    // registers are saved and restored with architectural width to avoid
    // information loss)
    if(!riscv->inSaveRestore && (riscv->xlenMask != xlenMask)) {

        riscvMode mode = getCurrentMode5(riscv);

        // determine if current mode XLEN has changed
        Bool xlen64Old = modeIsXLEN64(riscv, mode);
        riscv->xlenMask = xlenMask;
        Bool xlen64New = modeIsXLEN64(riscv, mode);

        // refresh mode if required
        if(xlen64Old!=xlen64New) {
            riscvSetMode(riscv, mode);
        }
    }
}

//
// Return the minimum supported processor mode
//
riscvMode riscvGetMinMode(riscvP riscv) {

    if(riscv->configInfo.arch & ISA_U) {
        return RISCV_MODE_U;
    } else if(riscv->configInfo.arch & ISA_S) {
        return RISCV_MODE_S;
    } else {
        return RISCV_MODE_M;
    }
}

//
// Iterate processor modes
//
VMI_MODE_INFO_FN(riscvModeInfo) {

    riscvP        riscv = (riscvP)processor;
    vmiModeInfoCP this  = 0;

    if(isHart(riscv)) {

        // on the first call, start with the first member of the table
        if(!prev) {
            prev = modes-1;
        }

        // get the next member
        this = prev+1;

        // skip to the next implemented mode
        while((this->name) && !riscvHasMode(riscv, this->code)) {
            this++;
        }

        // return the next member, or NULL if at the end of the list
        this = (this->name) ? this : 0;
    }

    return this;
}

//
// Return number of members of an array
//
#define NUM_MEMBERS(_A) (sizeof(_A)/sizeof((_A)[0]))

//
// Return the indexed X register name
//
const char *riscvGetXRegName(riscvP riscv, Uns32 index) {

    static const char *mapABI[] = {
        "zero", "ra",   "sp",   "gp",   "tp",   "t0",   "t1",   "t2",
        "s0",   "s1",   "a0",   "a1",   "a2",   "a3",   "a4",   "a5",
        "a6",   "a7",   "s2",   "s3",   "s4",   "s5",   "s6",   "s7",
        "s8",   "s9",   "s10",  "s11",  "t3",   "t4",   "t5",   "t6",
    };

    static const char *mapABIE[] = {
        "zero", "ra",   "sp",   "gp",   "tp",   "t0",   "s3",   "s4",
        "s0",   "s1",   "a0",   "a1",   "a2",   "a3",   "s2",   "t1",
        // these are illegal when embedded extension is active
        "x16",  "x17",  "x18",  "x19",  "x20",  "x21",  "x22",  "x23",
        "x24",  "x25",  "x26",  "x27",  "x28",  "x29",  "x30",  "x31",
    };

    static const char *mapHW[] = {
        "x0",   "x1",   "x2",   "x3",   "x4",   "x5",   "x6",   "x7",
        "x8",   "x9",   "x10",  "x11",  "x12",  "x13",  "x14",  "x15",
        "x16",  "x17",  "x18",  "x19",  "x20",  "x21",  "x22",  "x23",
        "x24",  "x25",  "x26",  "x27",  "x28",  "x29",  "x30",  "x31",
    };

    // sanity check index is in range
    VMI_ASSERT(index<NUM_MEMBERS(mapABI), "Illegal index %u", index);

    if(riscv->configInfo.use_hw_reg_names) {
        return mapHW[index];
    } else if(riscv->currentArch & ISA_E) {
        return mapABIE[index];
    } else {
        return mapABI[index];
    }
}

//
// Return the indexed F register name
//
const char *riscvGetFRegName(riscvP riscv, Uns32 index) {

    static const char *mapABI[] = {
        "ft0",  "ft1",  "ft2",  "ft3",  "ft4",  "ft5",  "ft6",  "ft7",
        "fs0",  "fs1",  "fa0",  "fa1",  "fa2",  "fa3",  "fa4",  "fa5",
        "fa6",  "fa7",  "fs2",  "fs3",  "fs4",  "fs5",  "fs6",  "fs7",
        "fs8",  "fs9",  "fs10", "fs11", "ft8",  "ft9",  "ft10", "ft11",
    };

    static const char *mapHW[] = {
        "f0",   "f1",   "f2",   "f3",   "f4",   "f5",   "f6",   "f7",
        "f8",   "f9",   "f10",  "f11",  "f12",  "f13",  "f14",  "f15",
        "f16",  "f17",  "f18",  "f19",  "f20",  "f21",  "f22",  "f23",
        "f24",  "f25",  "f26",  "f27",  "f28",  "f29",  "f30",  "f31",
    };

    // sanity check index is in range
    VMI_ASSERT(index<NUM_MEMBERS(mapABI), "Illegal index %u", index);

    return riscv->configInfo.use_hw_reg_names ? mapHW[index] : mapABI[index];
}

//
// Return the indexed V register name
//
const char *riscvGetVRegName(riscvP riscv, Uns32 index) {

    static const char *map[] = {
        "v0",   "v1",   "v2",   "v3",   "v4",   "v5",   "v6",   "v7",
        "v8",   "v9",   "v10",  "v11",  "v12",  "v13",  "v14",  "v15",
        "v16",  "v17",  "v18",  "v19",  "v20",  "v21",  "v22",  "v23",
        "v24",  "v25",  "v26",  "v27",  "v28",  "v29",  "v30",  "v31",
    };

    // sanity check index is in range
    VMI_ASSERT(index<NUM_MEMBERS(map), "Illegal index %u", index);

    return map[index];
}

//
// Utility function returning a vmiReg object to access the indexed vector
// register
//
vmiReg riscvGetVReg(riscvP riscv, Uns32 index) {

    void *value = &riscv->v[index*riscv->configInfo.VLEN/32];

    return vmimtGetExtReg((vmiProcessorP)riscv, value);
}

//
// Return index for the first feature identified by the given feature id
//
static Uns32 getFeatureIndex(riscvArchitecture feature) {

    Uns32 index = -1;

    // select first indicated feature
    feature = feature & -feature;

    // convert to index
    while(feature) {
        feature >>= 1;
        index++;
    }

    return index;
}

//
// Get description for the first feature identified by the given feature id
//
const char *riscvGetFeatureName(riscvArchitecture feature, Bool nullOK) {

    // table mapping to feature descriptions
    static const char *featureDescs[32] = {
        [RISCV_FEATURE_INDEX(XLEN32_CHAR)]  = "32-bit XLEN",
        [RISCV_FEATURE_INDEX(XLEN64_CHAR)]  = "64-bit XLEN",
        [RISCV_FEATURE_INDEX(XLEN128_CHAR)] = "128-bit XLEN",
        [RISCV_FEATURE_INDEX('A')]          = "extension A (atomic instructions)",
        [RISCV_FEATURE_INDEX('B')]          = "extension B (bit manipulation extension)",
        [RISCV_FEATURE_INDEX('C')]          = "extension C (compressed instructions)",
        [RISCV_FEATURE_INDEX('D')]          = "extension D (double-precision floating point)",
        [RISCV_FEATURE_INDEX('E')]          = "RV32E base integer instruction set (embedded)",
        [RISCV_FEATURE_INDEX('F')]          = "extension F (single-precision floating point)",
        [RISCV_FEATURE_INDEX('H')]          = "extension H (hypervisor)",
        [RISCV_FEATURE_INDEX('I')]          = "RV32I/RV64I/RV128I base integer instruction set",
        [RISCV_FEATURE_INDEX('K')]          = "extension K (cryptographic)",
        [RISCV_FEATURE_INDEX('M')]          = "extension M (integer multiply/divide instructions)",
        [RISCV_FEATURE_INDEX('N')]          = "extension N (user-level interrupts)",
        [RISCV_FEATURE_INDEX('P')]          = "extension P (DSP instructions)",
        [RISCV_FEATURE_INDEX('S')]          = "extension S (Supervisor mode)",
        [RISCV_FEATURE_INDEX('U')]          = "extension U (User mode)",
        [RISCV_FEATURE_INDEX('V')]          = "extension V (vector extension)",
        [RISCV_FEATURE_INDEX('X')]          = "extension X (non-standard extensions present)"
    };

    Uns32       index  = getFeatureIndex(feature);
    const char *result = featureDescs[index];

    // sanity check description is valid
    VMI_ASSERT(
        result || nullOK,
        "require non-zero feature name (feature %c)",
        index+'A'
    );

    // get feature description
    return result;
}

//
// Parse the extensions string
//
riscvArchitecture riscvParseExtensions(const char *extensions) {

    riscvArchitecture result = 0;

    if(extensions) {

        const char *tail = extensions;
        Bool        ok   = True;
        char        extension;

        while(ok && (extension=*tail++)) {

            ok = (extension>='A') && (extension<='Z');

            if(!ok) {
                vmiMessage("E", CPU_PREFIX"_ILLEXT",
                    "Illegal extension string \"%s\" - letters A-Z required",
                    extensions
                );
            } else {
                result |= (1<<(extension-'A'));
            }
        }
    }

    return result;
}


////////////////////////////////////////////////////////////////////////////////
// PROCESSOR RUN STATE TRANSITION HANDLING
////////////////////////////////////////////////////////////////////////////////

//
// If this memory access callback is triggered, abort any active load linked
//
static VMI_MEM_WATCH_FN(abortEA) {

    // ignore try-writes
    if(value) {
        riscvAbortExclusiveAccess(userData);
    }
}

//
// Install or remove the exclusive access monitor callback
//
static void updateExclusiveAccessCallback(riscvP riscv, Bool install) {

    memDomainP domain  = vmirtGetProcessorDataDomain((vmiProcessorP)riscv);
    Uns32      bits    = vmirtGetDomainAddressBits(domain);
    Uns64      mask    = (bits==64) ? -1 : ((1ULL<<bits)-1);
    Uns64      simLow  = mask & riscv->exclusiveTag;
    Uns64      simHigh = mask & (simLow + ~riscv->exclusiveTagMask);

    // install or remove a watchpoint on the current exclusive access address
    if(install) {
        vmirtAddWriteCallback(domain, 0, simLow, simHigh, abortEA, riscv);
    } else {
        vmirtRemoveWriteCallback(domain, 0, simLow, simHigh, abortEA, riscv);
    }
}

//
// Abort any active exclusive access
//
void riscvAbortExclusiveAccess(riscvP riscv) {

    if(riscv->exclusiveTag != RISCV_NO_TAG) {

        // remove callback on exclusive access monitor region
        updateExclusiveAccessCallback(riscv, False);

        // clear exclusive tag (AFTER updateExclusiveAccessCallback)
        riscv->exclusiveTag = RISCV_NO_TAG;

        // notify derived model of LR/SC abort
        ITER_EXT_CB(
            riscv, extCB, LRSCAbortFn,
            extCB->LRSCAbortFn(riscv, extCB->clientData);
        )

        // restart from wait state if waiting for reservation set
        if(riscv->disable & RVD_WRS) {
            riscvRestart(riscv, RVD_RESTART_WFI);
        }
    }
}

//
// Install or remove the exclusive access monitor callback if required
//
void riscvUpdateExclusiveAccessCallback(riscvP riscv, Bool install) {
    if(riscv->exclusiveTag != RISCV_NO_TAG) {
        updateExclusiveAccessCallback(riscv, install);
    }
}

//
// This is called on simulator context switch (when this processor is either
// about to start or about to stop simulation)
//
VMI_IASSWITCH_FN(riscvContextSwitchCB) {

    riscvP riscv = (riscvP)processor;

    riscvUpdateExclusiveAccessCallback(riscv, state==RS_SUSPEND);

    // call derived model context switch function if required
    ITER_EXT_CB(
        riscv, extCB, switchCB,
        extCB->switchCB(riscv, state, extCB->clientData)
    )
}


////////////////////////////////////////////////////////////////////////////////
// TRANSACTION MODE
////////////////////////////////////////////////////////////////////////////////

//
// Enable or disable transaction mode
//
RISCV_SET_TMODE_FN(riscvSetTMode) {

    // flush dictionaries the first time transaction mode is enabled
    if(enable && !riscv->useTMode) {

        riscv->useTMode = True;

        vmirtFlushAllDicts((vmiProcessorP)riscv);
    }

    // enable mode using polymorphic key
    if(enable) {
        riscv->pmKey |= PMK_TRANSACTION;
    } else {
        riscv->pmKey &= ~PMK_TRANSACTION;
    }
}

//
// Return true if in transaction mode
//
RISCV_GET_TMODE_FN(riscvGetTMode) {
    return (riscv->pmKey & PMK_TRANSACTION) != 0;
}

