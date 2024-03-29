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

// standard header files
#include <string.h>
#include <stdio.h>

// Imperas header files
#include "hostapi/impAlloc.h"
#include "hostapi/typeMacros.h"

// VMI header files
#include "vmi/vmiCommand.h"
#include "vmi/vmiMessage.h"
#include "vmi/vmiMt.h"
#include "vmi/vmiRt.h"

// model header files
#include "riscvAIATypes.h"
#include "riscvBus.h"
#include "riscvCLIC.h"
#include "riscvCSR.h"
#include "riscvCSRTypes.h"
#include "riscvExceptions.h"
#include "riscvFeatures.h"
#include "riscvKExtension.h"
#include "riscvMessage.h"
#include "riscvMode.h"
#include "riscvMorph.h"
#include "riscvRegisters.h"
#include "riscvStructure.h"
#include "riscvTrigger.h"
#include "riscvVariant.h"
#include "riscvUtils.h"
#include "riscvVM.h"
#include "riscvVMConstants.h"


////////////////////////////////////////////////////////////////////////////////
// UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Union used to decompose CSR index fields
//
typedef union CSRFieldsU {
    Uns32 u32;
    struct {
        Uns32 index  : 8;   // index within group
        Uns32 mode   : 2;   // lowest mode for which access is possible
        Uns32 access : 2;   // read/write or read-only access encoding
    };
} CSRFields;

//
// Return current program counter
//
inline static Uns64 getPC(riscvP riscv) {
    return vmirtGetPC((vmiProcessorP)riscv);
}

//
// Return riscvCSRId for riscvCSRAttrsCP (forward reference)
//
static riscvCSRId getCSRId(riscvCSRAttrsCP attrs);

//
// Return the 4-state processor mode with which the CSR should be associated
// (before any adjustment for absent modes)
//
inline static riscvMode getCSRMode4Raw(riscvCSRAttrsCP attrs) {

    CSRFields fields = {attrs->csrNum};

    return (attrs->access==ISA_S) ? RISCV_MODE_S : fields.mode;
}

//
// Return the 4-state processor mode with which the CSR should be associated
//
static riscvMode getCSRMode4(riscvCSRAttrsCP attrs, riscvP riscv) {

    riscvArchitecture arch = riscv->configInfo.arch;
    riscvMode         mode = getCSRMode4Raw(attrs);

    // promote User-accessible registers to Supervisor mode if User mode is
    // absent
    if((mode==RISCV_MODE_U) && !(arch&ISA_U)) {
        mode = RISCV_MODE_S;
    }

    // promote Supervisor-accessible registers to Machine mode if Supervisor
    // mode is absent
    if((mode==RISCV_MODE_S) && !(arch&ISA_S)) {
        mode = RISCV_MODE_M;
    }

    return mode;
}

//
// Return the 5-state processor mode with which the CSR should be associated
//
static riscvMode getCSRMode5(riscvCSRAttrsCP attrs, riscvP riscv) {

    riscvMode mode = getCSRMode4(attrs, riscv);

    if(mode==RISCV_MODE_H) {

        // Hypervisor mode CSRs are associated either with HS or VS modes; those
        // with addresses 0x2xx are VS-mode, others are HS-mode
        CSRFields fields = {attrs->csrNum};

        mode = fields.access ? RISCV_MODE_S : RISCV_MODE_VS;

    } else if(inVMode(riscv)) {

        mode = (mode==RISCV_MODE_S) ? RISCV_MODE_VS : RISCV_MODE_VU;
    }

    return mode;
}

//
// Return MXLEN register mask
//
inline static Uns64 maskModeXLEN(riscvP riscv, riscvMode mode) {
    return RISCV_XLEN_IS_32M(riscv, mode) ? 0xffffffff : -1ULL;
}

//
// Return MXLEN register mask
//
inline static Uns64 maskMXLEN(riscvP riscv) {
    return maskModeXLEN(riscv, RISCV_MODE_M);
}

//
// Return SXLEN register mask
//
inline static Uns64 maskSXLEN(riscvP riscv) {
    return maskModeXLEN(riscv, RISCV_MODE_S);
}

//
// Return UXLEN register mask
//
inline static Uns64 maskUXLEN(riscvP riscv) {
    return maskModeXLEN(riscv, RISCV_MODE_U);
}

//
// Return VSXLEN register mask
//
inline static Uns64 maskVSXLEN(riscvP riscv) {
    return maskModeXLEN(riscv, RISCV_MODE_VS);
}

//
// Mask for top half of 64-bit value
//
#define TOP32_MASK (-1ULL << 32)

//
// Trigger Illegal Instruction or Virtual Instruction exception depending on
// whether the processor is currently in a virtual mode and whether the register
// being accessed is reserved or inaccessible
//
static void virtualOrIllegalMessage(
    riscvP      riscv,
    const char *reason,
    Bool        reserved
) {
    if(!reserved && inVMode(riscv)) {
        riscvVirtualInstructionMessage(riscv, reason);
    } else {
        riscvIllegalInstructionMessage(riscv, reason);
    }
}


////////////////////////////////////////////////////////////////////////////////
// ISA REGISTER
////////////////////////////////////////////////////////////////////////////////

//
// Set MXL field, allowing for the fact that this field might move
//
static void setMXL(riscvP riscv, Uns8 oldMXL, Uns8 newMXL) {

    // replicate MXL in new location if required (or revert it if illegal)
    if(oldMXL==newMXL) {
        // misa.MXL unchanged at old location
    } else if((newMXL==1) || (newMXL==2)) {
        WR_CSR_FIELD32(riscv, misa, MXL, newMXL);
        WR_CSR_FIELD64(riscv, misa, MXL, newMXL);
    } else {
        WR_CSR_FIELD_M(riscv, misa, MXL, oldMXL);
        newMXL = oldMXL;
    }

    if(oldMXL!=newMXL) {

        // any change of misa.MXL from 32 to a wider width also forces
        // mstatus.SXL and mstatus.UXL to that wider width
        if((oldMXL==1) && !riscv->artifactAccess) {
            WR_CSR_FIELD64(riscv, mstatus, SXL, newMXL);
            WR_CSR_FIELD64(riscv, mstatus, UXL, newMXL);
        }

        // refresh XLEN mask and current mode when required
        riscvRefreshXLEN(riscv);
    }

    // update current architecture if required
    riscvSetCurrentArch(riscv);

    // complete change to MXL
    if(oldMXL==newMXL) {
        // misa.MXL unchanged at old location
    } else if(newMXL==1) {
        MV_CSR_FIELD_MASK_64_32(riscv, misa, MXL);
    } else {
        MV_CSR_FIELD_MASK_32_64(riscv, misa, MXL);
    }
}

//
// Read misa
//
static RISCV_CSR_READFN(misaR) {
    return RD_CSR_M(riscv, misa) & ~(Uns64)riscv->configInfo.archImplicit;
}

//
// Write misa
//
static RISCV_CSR_WRITEFN(misaW) {

    riscvArchitecture arch     = riscv->configInfo.arch;
    riscvArchitecture archMask = riscv->configInfo.archMask;
    Uns64             oldValue = RD_CSR_M(riscv, misa);
    Uns64             mask     = RD_CSR_MASK_M(riscv, misa);
    Uns64             pc;

    // get new value using writable bit mask
    newValue = ((newValue & mask) | (oldValue & ~mask));

    // disallow any update when clearing C bit if the current instruction
    // is not 4-byte aligned
    if(
        !riscv->artifactAccess &&
        (oldValue&ISA_C) &&
        !(newValue&ISA_C) &&
        ((pc=getPC(riscv))&3)
    ) {
        vmiMessage("W", CPU_PREFIX "_IN4BA",
            SRCREF_FMT "Write ignored (attempt to clear C bit when instruction "
            "not 4-byte aligned)",
            SRCREF_ARGS(riscv, pc)
        );

        newValue = oldValue;
    }

    // read-only E bit is always a complement of the I bit
    if(newValue&ISA_I) {
        newValue &= ~ISA_E;
    } else {
        newValue |= ISA_E;
    }

    if((arch&ISA_DF)!=ISA_DF) {

        // no action unless both D and F implemented

    } else if((archMask&ISA_DF)==ISA_DF) {

        // handle case where D feature requires F feature
        if(!riscv->configInfo.d_requires_f) {
            // no action
        } else if(!(newValue&ISA_F)) {
            newValue &= ~ISA_D;
        }

    } else if((archMask&ISA_DF)==ISA_D) {

        // F feature tracks D feature if both are implemented but F is read-only
        if(newValue&ISA_D) {
            newValue |= ISA_F;
        } else {
            newValue &= ~ISA_F;
        }

    } else if((archMask&ISA_DF)==ISA_F) {

        // D feature tracks F feature if both are implemented but D is read-only
        if(newValue&ISA_F) {
            newValue |= ISA_D;
        } else {
            newValue &= ~ISA_D;
        }
    }

    if(!(newValue&ISA_V)) {

        // no action unless V extension is enabled

    } else if(!riscvVFSupport(riscv, RVVF_V_REQUIRES_FD)) {

        // no dependency on F and D extensions

    } else if((riscv->configInfo.vect_profile&RVVS_F) && !(newValue&ISA_F)) {

        // V feature depends upon F feature
        newValue &= ~ISA_V;

    } else if((riscv->configInfo.vect_profile&RVVS_D) && !(newValue&ISA_D)) {

        // V feature depends upon D feature
        newValue &= ~ISA_V;
    }

    // update the CSR
    Uns32 oldMXL = RD_CSR_FIELD_M(riscv, misa, MXL);
    WR_CSR64(riscv, misa, newValue);
    Uns32 newMXL = RD_CSR_FIELD_M(riscv, misa, MXL);

    // handle change to MXL
    setMXL(riscv, oldMXL, newMXL);

    // return composed value
    return RD_CSR_M(riscv, misa);
}


////////////////////////////////////////////////////////////////////////////////
// FLOATING POINT REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Do vx CSRs require mstatus.FS!=0?
//
inline static Bool vxRequiresFS(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_VS_STATUS_8);
}

//
// Are vxsat and vxrm visible in fcsr? (Vector Version 0.8 only)
//
inline static Bool vxFieldsInFCSR(riscvP riscv) {
    return !riscvVFSupport(riscv, RVVF_VCSR_PRESENT);
}

//
// Return floating point rounding mode master value
//
inline static Uns8 getMasterFRM(riscvP riscv) {
    return RD_CSR_FIELDC(riscv, fcsr, frm);
}

//
// Return floating point rounding mode master value
//
inline static void setMasterFRM(riscvP riscv, Uns8 frm) {
    WR_CSR_FIELDC(riscv, fcsr, frm, frm);
}

//
// Return rounding control for rounding mode in FPSR
//
inline static vmiFPRC mapFRMToRC(Uns8 frm) {

    static const vmiFPRC map[] = {
        [0] = vmi_FPR_NEAREST,
        [1] = vmi_FPR_ZERO,
        [2] = vmi_FPR_NEG_INF,
        [3] = vmi_FPR_POS_INF,
        [4] = vmi_FPR_AWAY,
        [5] = -1,
        [6] = -1,
        [7] = -1
    };

    return map[frm];
}

//
// Update polymorphic key to indicate whether current rounding mode is valid
//
static vmiFPRC updateCurrentRMValid(riscvP riscv) {

    vmiFPRC rc         = mapFRMToRC(getMasterFRM(riscv));
    Bool    oldInvalid = (riscv->currentArch & ISA_RM_INVALID);
    Bool    newInvalid = (rc==-1);

    if(oldInvalid != newInvalid) {

        vmiProcessorP     processor = (vmiProcessorP)riscv;
        riscvArchitecture arch      = riscv->currentArch;

        // enable rounding mode valid state check if required
        if(!riscv->rmCheckValid) {
            riscv->rmCheckValid = True;
            vmirtFlushAllDicts(processor);
        }

        // update state to reflect invalid RM change
        if(newInvalid) {
            arch |= ISA_RM_INVALID;
        } else {
            arch &= ~ISA_RM_INVALID;
        }
        
        // update block mask to reflect invalid RM change
        vmirtSetBlockMask64(processor, &riscv->currentArch, arch);
    }

    return rc;
}

//
// Return effective floating point flags from CSR and JIT flags
//
inline static vmiFPFlags getFPFlags(riscvP riscv) {

    vmiFPFlags vmiFlags = {bits:riscv->fpFlagsCSR|riscv->fpFlagsMT};

    return vmiFlags;
}

//
// Set floating point CSR flags (and clear JIT flags)
//
inline static void setFPFlags(riscvP riscv, vmiFPFlags vmiFlags) {

    riscv->fpFlagsCSR = riscv->fpFlagsI = vmiFlags.bits;
    riscv->fpFlagsMT  = 0;
}

//
// Return effective fixed point flags from CSR and JIT flags
//
inline static Uns8 getSatFlags(riscvP riscv) {

    return riscv->SFCSR|riscv->SFMT;
}

//
// Set fixed point CSR flags (and clear JIT flags)
//
inline static void setSatFlags(riscvP riscv, Uns8 vxsat) {

    riscv->SFCSR = vxsat;
    riscv->SFMT  = 0;
}

//
// Read fflags
//
static RISCV_CSR_READFN(fflagsR) {

    CSR_REG_DECL(fflags) = {u32 : {bits:0}};

    // construct effective flags from CSR and JIT flags
    vmiFPFlags vmiFlags = getFPFlags(riscv);

    // compose register value
    fflags.u32.fields.NX = vmiFlags.f.P;
    fflags.u32.fields.UF = vmiFlags.f.U;
    fflags.u32.fields.OF = vmiFlags.f.O;
    fflags.u32.fields.DZ = vmiFlags.f.Z;
    fflags.u32.fields.NV = vmiFlags.f.I;

    // return composed value
    return fflags.u32.bits;
}

//
// Write fflags
//
static RISCV_CSR_WRITEFN(fflagsW) {

    CSR_REG_DECL(fflags) = {u32 : {bits : newValue & WM32_fflags}};
    vmiFPFlags vmiFlags  = {bits: 0};

    // extract flags
    vmiFlags.f.P = fflags.u32.fields.NX;
    vmiFlags.f.U = fflags.u32.fields.UF;
    vmiFlags.f.O = fflags.u32.fields.OF;
    vmiFlags.f.Z = fflags.u32.fields.DZ;
    vmiFlags.f.I = fflags.u32.fields.NV;

    // assign CSR flags and clear JIT flags
    setFPFlags(riscv, vmiFlags);

    // return written value
    return fflags.u32.bits;
}

//
// Read frm
//
static RISCV_CSR_READFN(frmR) {

    CSR_REG_DECL(frm) = {u32 : {bits:0}};

    // compose register value
    frm.u32.fields.frm = getMasterFRM(riscv);

    // return composed value
    return frm.u32.bits;
}

//
// Update model rounding mode controls
//
static void setFPRoundingMode(riscvP riscv, Uns8 oldRM, Uns8 newRM) {

    // update floating point rounding mode
    if(oldRM!=newRM) {

        setMasterFRM(riscv, newRM);

        vmiFPRC rc = updateCurrentRMValid(riscv);

        if(rc!=-1) {

            vmiFPControlWord cw = {
                .IM = 1, .DM = 1, .ZM = 1, .OM = 1, .UM = 1, .PM = 1, .RC = rc
            };

            vmirtSetFPControlWord((vmiProcessorP)riscv, cw);
        }
    }
}

//
// Write frm
//
static RISCV_CSR_WRITEFN(frmW) {

    Uns8 oldRM = getMasterFRM(riscv);

    CSR_REG_DECL(frm) = {u32 : {bits : newValue & WM32_frm}};

    // handle change to rounding mode
    setFPRoundingMode(riscv, oldRM, frm.u32.fields.frm);

    // return written value
    return frm.u32.bits;
}

//
// Read fcsr
//
static RISCV_CSR_READFN(fcsrR) {

    // construct effective flags from CSR and JIT flags
    vmiFPFlags vmiFlags = getFPFlags(riscv);

    // compose flags in register value
    WR_CSR_FIELDC(riscv, fcsr, NX, vmiFlags.f.P);
    WR_CSR_FIELDC(riscv, fcsr, UF, vmiFlags.f.U);
    WR_CSR_FIELDC(riscv, fcsr, OF, vmiFlags.f.O);
    WR_CSR_FIELDC(riscv, fcsr, DZ, vmiFlags.f.Z);
    WR_CSR_FIELDC(riscv, fcsr, NV, vmiFlags.f.I);

    // handle  vxsat and vxrm if these are visible in fcsr (Vector Version 0.8
    // only)
    if(vxFieldsInFCSR(riscv)) {

        // get fixed point saturation alias
        WR_CSR_FIELDC(riscv, fcsr, vxsat, getSatFlags(riscv));

        // get fixed point rounding mode alias
        WR_CSR_FIELDC(riscv, fcsr, vxrm, RD_CSR_FIELDC(riscv, vxrm, rm));
    }

    // return composed value
    return RD_CSRC(riscv, fcsr);
}

//
// Write fcsr
//
static RISCV_CSR_WRITEFN(fcsrW) {

    Uns32      mask     = RD_CSR_MASKC(riscv, fcsr);
    Uns8       oldRM    = getMasterFRM(riscv);
    vmiFPFlags vmiFlags = {bits: 0};

    // update the CSR
    WR_CSRC(riscv, fcsr, newValue & mask);

    // extract flags from register value
    vmiFlags.f.P = RD_CSR_FIELDC(riscv, fcsr, NX);
    vmiFlags.f.U = RD_CSR_FIELDC(riscv, fcsr, UF);
    vmiFlags.f.O = RD_CSR_FIELDC(riscv, fcsr, OF);
    vmiFlags.f.Z = RD_CSR_FIELDC(riscv, fcsr, DZ);
    vmiFlags.f.I = RD_CSR_FIELDC(riscv, fcsr, NV);

    // assign CSR flags and clear JIT flags (floating point)
    setFPFlags(riscv, vmiFlags);

    // handle change to rounding modes
    setFPRoundingMode(riscv, oldRM, RD_CSR_FIELDC(riscv, fcsr, frm));

    // handle updates to vxsat and vxrm if these are visible in fcsr (Vector
    // Version 0.8 only)
    if(vxFieldsInFCSR(riscv)) {

        // assign CSR flags and clear JIT flags (fixed point)
        setSatFlags(riscv, RD_CSR_FIELDC(riscv, fcsr, vxsat));

        // update fixed point rounding mode alias
        WR_CSR_FIELDC(riscv, vxrm, rm, RD_CSR_FIELDC(riscv, fcsr, vxrm));
    }

    // return written value
    return RD_CSRC(riscv, fcsr);
}


////////////////////////////////////////////////////////////////////////////////
// STATUS REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// This encodes possible extension states
//
typedef enum extStatusE {
    ES_OFF     = 0,
    ES_INITIAL = 1,
    ES_CLEAN   = 2,
    ES_DIRTY   = 3
} extStatus;

//
// Is mstatus.VS in Vector Version 0.8 location (bits 24:23)?
//
inline static Bool statusVS8(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_VS_STATUS_8);
}

//
// Is mstatus.VS in Vector Version 0.9 location (bits 10:9)?
//
inline static Bool statusVS9(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_VS_STATUS_9);
}

//
// Return current value of mstatus.VS
//
static Uns8 getStatusVS(
    riscvP               riscv,
    CSR_REG_TYPE(status) status
) {
    if(statusVS8(riscv)) {
        return RD_RAW_FIELDC(status, VS_8);
    } else {
        return RD_RAW_FIELDC(status, VS_9);
    }
}

//
// Set current value of mstatus.VS
//
static CSR_REG_TYPE(status) setStatusVS(
    riscvP               riscv,
    CSR_REG_TYPE(status) status,
    Uns8                 VS
) {
    if(statusVS8(riscv)) {
        WR_RAW_FIELDC(status, VS_8, VS);
    } else {
        WR_RAW_FIELDC(status, VS_9, VS);
    }

    return status;
}

//
// Common routine to refresh FS, VS, XS and SD state in a status register
//
static CSR_REG_TYPE(status) refreshDirty(
    riscvP               riscv,
    riscvMode            mode,
    CSR_REG_TYPE(status) status
) {
    riscvFSMode mstatus_fs_mode = riscv->configInfo.mstatus_fs_mode;

    // get FS, VS and XS fields
    Uns8 FS = RD_RAW_FIELDC(status, FS);
    Uns8 VS = getStatusVS(riscv, status);
    Uns8 XS = RD_RAW_FIELDC(status, XS);

    // if fs_always_dirty is set, force status.FS and status.VS to be either
    // 0 or 3 (so if enabled, they are always seen as dirty), and if force_dirty
    // is set, force status.FS to 3 (always dirty)
    if(mstatus_fs_mode>=RVFS_ALWAYS_DIRTY) {

        // handle status.FS
        if(FS || (mstatus_fs_mode==RVFS_FORCE_DIRTY)) {
            FS = ES_DIRTY;
            WR_RAW_FIELDC(status, FS, FS);
        }

        // handle status.VS
        if(VS) {
            VS = ES_DIRTY;
            status = setStatusVS(riscv, status, VS);
        }
    }

    // overall state is dirty if any of FS, VS or XS indicates dirty
    Bool SD = ((FS==ES_DIRTY) || (VS==ES_DIRTY) || (XS==ES_DIRTY));

    // clear derived SD aliases (inconveniently changes location)
    WR_RAW_FIELD32(status, SD, 0);
    WR_RAW_FIELD64(status, SD, 0);

    // compose read-only SD dirty field
    WR_RAW_FIELD_MODE(riscv, mode, status, SD, SD);

    // return composed value
    return status;
}

//
// Consolidate floating point and fixed point flags on CSR view
//
void riscvConsolidateFPFlags(riscvP riscv) {

    Uns8 fpFlagsMT = riscv->fpFlagsMT;
    Uns8 SFMT      = riscv->SFMT;

    // consolidate floating point and fixed point flags on CSR view
    riscv->fpFlagsCSR |= fpFlagsMT;
    riscv->fpFlagsMT   = 0;
    riscv->SFCSR      |= SFMT;
    riscv->SFMT        = 0;

    // indicate floating point extension status is dirty if required
    if(!Zfinx(riscv) && (fpFlagsMT || (SFMT && vxRequiresFS(riscv)))) {

        // always update mstatus.FS
        WR_CSR_FIELDC(riscv, mstatus, FS, ES_DIRTY);

        // update vsstatus.FS if in a virtual mode
        if(inVMode(riscv)) {
            WR_CSR_FIELDC(riscv, vsstatus, FS, ES_DIRTY);
        }
    }
}

//
// This function is called when configurable endianness has changed
//
static void updateEndian(riscvP riscv) {

    vmiProcessorP processor = (vmiProcessorP)riscv;

    // if this is the first time endianness has been changed, flush all
    // dictionaries (endianness checking is required)
    if(!riscv->checkEndian) {
        riscv->checkEndian = True;
        vmirtFlushAllDicts(processor);
    }
}

//
// Common routine to perform actions after a status register has been written
// (including vsstatus)
//
static void postStatusW(riscvP riscv, Uns64 oldValue, Uns64 newValue) {

    // detect any change in IE and BE bits
    Uns32 oldIE     = oldValue & WM_mstatus_IE;
    Uns32 newIE     = newValue & WM_mstatus_IE;
    Uns64 changed   = oldValue ^ newValue;
    Bool  changedBE = changed & WM_mstatus_BE;
    Bool  changedXL = changed & WM_mstatus_XL;

    // refresh XLEN mask and current mode when required
    if(!riscv->xlenMask || changedXL) {
        riscvRefreshXLEN(riscv);
    }

    // handle update of endianness if required
    if(changedBE) {
        updateEndian(riscv);
    }

    // changes in status.SUM or status.MXR affect effective ASID
    riscvVMSetASID(riscv);

    // changes in status.MPRV affect current data domain
    riscvVMRefreshMPRVDomain(riscv);

    // update current architecture to take into account changes from
    // riscvRefreshXLEN and riscvVMRefreshMPRVDomain
    riscvSetCurrentArch(riscv);

    // handle any exceptions that have been enabled
    if(newIE & ~oldIE) {
        riscvTestInterrupt(riscv);
    }
}

//
// Common routine to read status using mstatus, sstatus or ustatus alias
//
static Uns64 statusR(riscvP riscv, riscvMode mode) {

    // consolidate floating point flags on CSR view
    riscvConsolidateFPFlags(riscv);

    // update Dirty settings in mstatus (after consolidation)
    riscv->csr.mstatus = refreshDirty(riscv, mode, riscv->csr.mstatus);

    // return composed value
    return RD_CSR_MODE(riscv, mode, mstatus);
}

//
// Common routine to write status using mstatus, mstatush, sstatus or ustatus
// alias
//
static void statusW(riscvP riscv, Uns64 newValue, Uns64 mask) {

    // consolidate floating point flags on CSR view
    riscvConsolidateFPFlags(riscv);

    // get old value (after consolidation)
    Uns64 oldValue = RD_CSR64(riscv, mstatus);

    // get new value using writable bit mask
    newValue = ((newValue & mask) | (oldValue & ~mask));

    // update the CSR
    Uns8 oldMPP = RD_CSR_FIELDC(riscv, mstatus, MPP);
    WR_CSR64(riscv, mstatus, newValue);
    Uns8 newMPP = RD_CSR_FIELDC(riscv, mstatus, MPP);

    // revert mstatus.MPP if target mode is not implemented (this field changes
    // from WLRL to WARL in privileged Specification version 1.11)
    if(!riscvHasMode(riscv, newMPP)) {
        WR_CSR_FIELDC(riscv, mstatus, MPP, oldMPP);
    }

    // do common actions after status register update
    postStatusW(riscv, oldValue, newValue);
}

//
// Read mstatus
//
static RISCV_CSR_READFN(mstatusR) {

    // return composed value
    return statusR(riscv, RISCV_MODE_M);
}

//
// Write mstatus
//
static RISCV_CSR_WRITEFN(mstatusW) {

    Uns64 mask = RD_CSR_MASK_M(riscv, mstatus);

    // update the CSR
    statusW(riscv, newValue, mask);

    // return written value
    return RD_CSR_M(riscv, mstatus);
}

//
// Read mstatush
//
static RISCV_CSR_READFN(mstatushR) {

    // clear Dirty setting in MSW
    WR_CSR_FIELD64(riscv, mstatus, SD, 0);

    // return composed value
    return RD_CSR64(riscv, mstatus) >> 32;
}

//
// Write mstatush
//
static RISCV_CSR_WRITEFN(mstatushW) {

    Uns64 mask = RD_CSR_MASK64(riscv, mstatus) & TOP32_MASK;

    // update the CSR
    statusW(riscv, newValue<<32, mask);

    // return written value
    return RD_CSR64(riscv, mstatus) >> 32;
}

//
// Read sstatus
//
static RISCV_CSR_READFN(sstatusR) {

    // return composed value
    return statusR(riscv, RISCV_MODE_S) & sstatus_AMASK;
}

//
// Write sstatus
//
static RISCV_CSR_WRITEFN(sstatusW) {

    Uns64 mask = RD_CSR_MASK_S(riscv, mstatus) & sstatus_AMASK;

    // update the CSR
    statusW(riscv, newValue, mask);

    // return written value
    return RD_CSR_S(riscv, mstatus) & sstatus_AMASK;
}

//
// Read ustatus
//
static RISCV_CSR_READFN(ustatusR) {

    // return composed value
    return statusR(riscv, RISCV_MODE_U) & ustatus_AMASK;
}

//
// Write ustatus
//
static RISCV_CSR_WRITEFN(ustatusW) {

    Uns64 mask = RD_CSR_MASK_U(riscv, mstatus) & ustatus_AMASK;

    // update the CSR
    statusW(riscv, newValue, mask);

    // return written value
    return RD_CSR_U(riscv, mstatus) & ustatus_AMASK;
}

//
// Write hstatus
//
static RISCV_CSR_WRITEFN(hstatusW) {

    Uns64 oldValue = RD_CSR_S(riscv, hstatus);
    Uns64 mask     = RD_CSR_MASK_S(riscv, hstatus);

    // get new value using writable bit mask
    newValue = ((newValue & mask) | (oldValue & ~mask));

    // update the CSR
    Uns32 oldVGEIN = RD_CSR_FIELDC(riscv, hstatus, VGEIN);
    Bool  oldBE    = RD_CSR_FIELDC(riscv, hstatus, VSBE);
    Uns32 oldXL    = RD_CSR_FIELDC(riscv, hstatus, VSXL);
    Bool  oldSPVP  = RD_CSR_FIELDC(riscv, hstatus, SPVP);
    Bool  oldHU    = RD_CSR_FIELDC(riscv, hstatus, HU);
    WR_CSR_S(riscv, hstatus, newValue);
    Uns32 newVGEIN = RD_CSR_FIELDC(riscv, hstatus, VGEIN);
    Bool  newBE    = RD_CSR_FIELDC(riscv, hstatus, VSBE);
    Uns32 newXL    = RD_CSR_FIELDC(riscv, hstatus, VSXL);
    Bool  newSPVP  = RD_CSR_FIELDC(riscv, hstatus, SPVP);
    Bool  newHU    = RD_CSR_FIELDC(riscv, hstatus, HU);

    // refresh XLEN mask and current mode when required
    if(oldXL!=newXL) {
        riscvRefreshXLEN(riscv);
    }

    // handle update of endianness if required
    if(oldBE!=newBE) {
        updateEndian(riscv);
    }

    // update current architecture block mask if required
    if((oldBE!=newBE) || (oldSPVP!=newSPVP) || (oldHU!=newHU) || (oldXL!=newXL)) {
        riscvSetCurrentArch(riscv);
    }

    // handle change to VGEIN
    if(oldVGEIN==newVGEIN) {
        // no action
    } else if(newVGEIN>getGEILEN(riscv)) {
        WR_CSR_FIELDC(riscv, hstatus, VGEIN, oldVGEIN);
    } else {
        riscvUpdatePending(riscv);
    }

    return newValue;
}

//
// Read ustatus
//
static RISCV_CSR_READFN(vsstatusR) {

    riscvMode mode = RISCV_MODE_VS;

    // consolidate floating point flags on CSR view
    riscvConsolidateFPFlags(riscv);

    // update Dirty settings in vsstatus (after consolidation)
    riscv->csr.vsstatus = refreshDirty(riscv, mode, riscv->csr.vsstatus);

    // return composed value
    return RD_CSR_MODE(riscv, mode, vsstatus);
}

//
// Write vsstatus
//
static RISCV_CSR_WRITEFN(vsstatusW) {

    Uns64 mask = RD_CSR_MASK_VS(riscv, mstatus) & sstatus_AMASK;

    // consolidate floating point flags on CSR view
    riscvConsolidateFPFlags(riscv);

    // get old value (after consolidation)
    Uns64 oldValue = RD_CSR_VS(riscv, vsstatus);

    // get new value using writable bit mask
    newValue = ((newValue & mask) | (oldValue & ~mask));

    // update the CSR
    WR_CSR_VS(riscv, vsstatus, newValue);

    // do common actions after status register update
    postStatusW(riscv, oldValue, newValue);

    // return written value
    return newValue;
}


////////////////////////////////////////////////////////////////////////////////
// EXCEPTION PROGRAM COUNTER REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Return apparent value of mepc/sepc/uepc allowing for whether compressed
// instructions are enabled (NOTE: this does not affect whether bit 1 is
// writable)
//
inline static Uns64 epcR(riscvP riscv, Uns64 epc) {

    if(riscv->artifactAccess) {
        // no action for artifact accesses
    } else if(!(riscv->currentArch & ISA_C)) {
        epc &= -4;
    }

    return epc;
}

//
// Read mepc
//
static RISCV_CSR_READFN(mepcR) {
    return epcR(riscv, RD_CSR_M(riscv, mepc));
}

//
// Read vsepc
//
static RISCV_CSR_READFN(vsepcR) {
    return epcR(riscv, RD_CSR_VS(riscv, vsepc));
}

//
// Read sepc
//
static RISCV_CSR_READFN(sepcR) {
    return epcR(riscv, RD_CSR_S(riscv, sepc));
}

//
// Read uepc
//
static RISCV_CSR_READFN(uepcR) {
    return epcR(riscv, RD_CSR_U(riscv, uepc));
}

//
// Read mnepc
//
static RISCV_CSR_READFN(mnepcR) {
    return epcR(riscv, RD_CSR_M(riscv, mnepc));
}

//
// Read dpc
//
static RISCV_CSR_READFN(dpcR) {
    return epcR(riscv, RD_CSR_M(riscv, dpc));
}


////////////////////////////////////////////////////////////////////////////////
// RESUMABLE NMI CONTROL REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Are RNMI registers present at version 0.2.1 locations?
//
inline static RISCV_CSR_PRESENTFN(rnmi021P) {
    return RISCV_RNMI_VERSION(riscv)==RNMI_0_2_1;
}

//
// Are RNMI registers present at version 0.4 locations?
//
inline static RISCV_CSR_PRESENTFN(rnmi04P) {
    return RISCV_RNMI_VERSION(riscv)>=RNMI_0_4;
}

//
// return interrupt bit mask in mncause
//
inline static Uns64 mncauseInterrupt(riscvP riscv) {
    return 1ULL << (RISCV_XLEN_IS_64M(riscv, RISCV_MODE_M) ? 63 : 31);
}

//
// Read mncause
//
static RISCV_CSR_READFN(mncauseR) {
    return RD_CSR(riscv, mncause) | mncauseInterrupt(riscv);
}

//
// Write mncause
//
static RISCV_CSR_WRITEFN(mncauseW) {

    WR_CSR(riscv, mncause, newValue & riscv->configInfo.ecode_nmi_mask);

    return mncauseR(attrs, riscv);
}

//
// Write mnstatus
//
static RISCV_CSR_WRITEFN(mnstatusW) {

    // select only implemented MPP/MPV fields from new value
    newValue &= RD_CSR_MASK64(riscv, mnstatus);

    // update the CSR
    Uns8 oldMPP = RD_CSR_FIELDC(riscv, mnstatus, MNPP);
    Bool oldMIE = RD_CSR_FIELDC(riscv, mnstatus, NMIE);
    WR_CSR(riscv, mnstatus, newValue);
    Uns8 newMPP = RD_CSR_FIELDC(riscv, mnstatus, MNPP);
    Bool newMIE = RD_CSR_FIELDC(riscv, mnstatus, NMIE);

    // revert mnstatus.MPP if target mode is not implemented
    if(!riscvHasMode(riscv, newMPP)) {
        WR_CSR_FIELDC(riscv, mnstatus, MNPP, oldMPP);
    }

    // mnstatus.MIE may only be set by software (not cleared)
    if(oldMIE && !newMIE && !riscv->artifactAccess) {
        WR_CSR_FIELDC(riscv, mnstatus, NMIE, oldMIE);
    }

    // handle interrupts that may have been blocked
    if(!oldMIE && newMIE) {
        riscvTestInterrupt(riscv);
    }

    return RD_CSR(riscv, mnstatus);
}

//
// Read mnstatus (version 0.2.1 only, masking NMIE unless artifact)
//
static RISCV_CSR_READFN(mnstatus021R) {

    Uns32 result = RD_CSR(riscv, mnstatus);

    if(!riscv->artifactAccess) {
        result &= ~WM_mnstatus_NMIE;
    }

    return result;
}


////////////////////////////////////////////////////////////////////////////////
// CODE SIZE REDUCTION REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Is Zcea extension present?
//
inline static RISCV_CSR_PRESENTFN(ZceaP) {
    return Zcea(riscv);
}

//
// Is Zcmt extension present with version 0.70.1 or earlier?
//
inline static RISCV_CSR_PRESENTFN(ZcmtLE701P) {
    return Zcmt(riscv) && (RISCV_COMPRESS_VERSION(riscv)<=RVCV_0_70_1);
}

//
// Is Zcmt extension present with version later than 0.70.1?
//
inline static RISCV_CSR_PRESENTFN(ZcmtGT701P) {
    return Zcmt(riscv) && (RISCV_COMPRESS_VERSION(riscv)>RVCV_0_70_1);
}


////////////////////////////////////////////////////////////////////////////////
// DSP EXTENSION REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Is ucode CSR present?
//
inline static RISCV_CSR_PRESENTFN(ucodeP) {
    return RISCV_DSP_VERSION(riscv)==RVDSPV_0_5_2;
}


////////////////////////////////////////////////////////////////////////////////
// INTERRUPT UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Are CLIC xintstatus registers present in read/write locations?
//
inline static RISCV_CSR_PRESENTFN(clicRWP) {
    return CLICPresent(riscv) && xintstatusRW(riscv);
}

//
// Are CLIC xintstatus registers present in read-only locations, in first
// position?
//
inline static RISCV_CSR_PRESENTFN(clicR1P) {
    return CLICPresent(riscv) && xintstatusRO1(riscv);
}

//
// Are CLIC xintstatus registers present in read-only locations, in second
// position?
//
inline static RISCV_CSR_PRESENTFN(clicR2P) {
    return CLICPresent(riscv) && xintstatusRO2(riscv);
}

//
// Are CLIC *tvt registers present?
//
inline static RISCV_CSR_PRESENTFN(clicTVTP) {
    return CLICPresent(riscv) && !riscv->configInfo.tvt_undefined;
}

//
// Are CLIC *intthresh registers present?
//
inline static RISCV_CSR_PRESENTFN(clicITP) {
    return CLICPresent(riscv) && !riscv->configInfo.intthresh_undefined;
}

//
// Is CLIC mclicbase register present?
//
inline static RISCV_CSR_PRESENTFN(clicMCBP) {
    return CLICPresent(riscv) && !riscv->configInfo.mclicbase_undefined;
}

//
// Are CLIC *nxti registers present?
//
inline static RISCV_CSR_PRESENTFN(clicNXTP) {
    return CLICPresent(riscv) && riscv->configInfo.CLICXNXTI;
}

//
// Are CLIC scratch swap registers present?
//
inline static RISCV_CSR_PRESENTFN(clicSWP) {
    return CLICPresent(riscv) && riscv->configInfo.CLICXCSW;
}

//
// Return effective mideleg
//
inline static Uns64 midelegEffective(riscvP riscv) {
    return riscv->inSaveRestore ? -1 : RD_CSR64(riscv, mideleg);
}

//
// Return effective medeleg
//
inline static Uns64 medelegEffective(riscvP riscv) {
    return riscv->inSaveRestore ? -1 : RD_CSR64(riscv, medeleg);
}

//
// Get hideleg write mask (only bits delegated by mideleg or mvien are
// writable)
//
static Uns64 hidelegWMask(riscvP riscv) {
    Uns64 mask = midelegEffective(riscv) | RD_CSR64(riscv, mvien);
    return RD_CSR_MASK64(riscv, hideleg) & mask;
}

//
// Get sideleg write mask (only bits delegated by mideleg are writable)
//
static Uns64 sidelegWMask(riscvP riscv) {
    return RD_CSR_MASK64(riscv, sideleg) & midelegEffective(riscv);
}

//
// Get sedeleg write mask (only bits delegated by medeleg are writable)
//
static Uns64 sedelegWMask(riscvP riscv) {
    return RD_CSR_MASK64(riscv, sedeleg) & medelegEffective(riscv);
}

//
// Read hideleg (internal interface)
//
static Uns64 hidelegRInt(riscvP riscv) {
    return RD_CSR64(riscv, hideleg) & hidelegWMask(riscv);
}

//
// Read sideleg (internal interface)
//
static Uns64 sidelegRInt(riscvP riscv) {
    return RD_CSR64(riscv, sideleg) & midelegEffective(riscv);
}

//
// Read sedeleg (internal interface)
//
static Uns64 sedelegRInt(riscvP riscv) {
    return RD_CSR64(riscv, sedeleg) & medelegEffective(riscv);
}

//
// Return virtual interrupt mask (virtual interrupts are not connected to nets
// and are not represented in sip/sie)
//
inline static Uns64 getVIMask(riscvP riscv) {
    return WM32_hie;
}

//
// Return mask of non-virtual interrupts visible in Supervisor mode
//
inline static Uns64 getSIRMask(riscvP riscv) {
    return RD_CSR64(riscv, mideleg) & ~getVIMask(riscv);
}

//
// Return mask of virtual interrupts visible in Hypervisor mode
//
inline static Uns64 getHIRMask(riscvP riscv) {
    return RD_CSR64(riscv, mideleg) & getVIMask(riscv);
}

//
// Return mask of interrupts visible in Virtual Supervisor mode
//
inline static Uns64 getVSIRMask(riscvP riscv) {
    return hidelegRInt(riscv);
}

//
// Return mask of interrupts visible in User mode
//
inline static Uns64 getUIRMask(riscvP riscv) {
    return sidelegRInt(riscv);
}

//
// Return mask of interrupts writable in vsip (with SSIP relocated to VSSIP
// location)
//
static Uns64 getVSIPWMask(riscvP riscv) {
    Uns64 wMask = RD_CSR_MASK64(riscv, mip) & (WM64_mvip|(WM32_vsip<<1));
    return hidelegRInt(riscv) & wMask;
}


////////////////////////////////////////////////////////////////////////////////
// AIA REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Are Smaia registers present?
//
inline static RISCV_CSR_PRESENTFN(SmaiaP) {
    return Smaia(riscv);
}

//
// Are Smaia IMSIC registers present?
//
inline static RISCV_CSR_PRESENTFN(SmaiaIMSICP) {
    return SmaiaP(attrs, riscv) && riscv->configInfo.IMSIC_present;
}

//
// Indicate CSR bus implementation is required
//
static void requireCSRBus(riscvP riscv) {
    if(!riscv->artifactAccess) {
        vmiMessage("W", CPU_PREFIX"_RCSRB",
            SRCREF_FMT
            "Require implementation using CSR bus",
            SRCREF_ARGS(riscv, getPC(riscv))
        );
    }
}

//
// Report untrapped write of register that must be implemented via CSR bus
//
static RISCV_CSR_WRITEFN(CSRBusW) {
    requireCSRBus(riscv);
    return 0;
}

//
// Common routine to write virtual interrupt pending/enable alias bits
//
static Uns64 xvipexW(
    riscvP riscv,
    Uns64 *valueP,
    Uns64  newValue,
    Uns64  wMask,
    Bool   useCLIC
) {
    if(riscv->inSaveRestore || !useCLIC) {

        Uns64 oldValue = *valueP;

        // get new value using writable bit mask
        newValue = ((newValue & wMask) | (oldValue & ~wMask));

        // update interrupt enable alias bits
        *valueP = newValue;

        // handle any interrupts that are now pending and enabled
        if(oldValue!=newValue) {
            riscvUpdatePending(riscv);
        }
    }

    // return readable bits
    return useCLIC ? 0 : (newValue&wMask);
}

//
// Return mask of active bits in svip (not disabled by mvien)
//
inline static Uns64 activeSwipMask(riscvP riscv) {
    return ~(WM64_mip_mvip & RD_CSR64(riscv, mvien));
}

//
// Return mask of bits in mvip that are aliased to software-writable bits
//
inline static Uns64 mvipSwipMask(riscvP riscv) {
    return WM64_mip_mvip & ~RD_CSR64(riscv, mvien);
}

//
// Common routine to read mvip using mvip or mviph alias
//
static Uns64 mvipIntR(riscvP riscv) {

    Uns64 result = RD_CSR64(riscv, mvip);

    if(riscv->inSaveRestore) {

        // return raw value

    } else if(useCLICM(riscv)) {

        // RAZ/WI in CLIC mode
        result = 0;

    } else {

        // get mask of bits mastered in swip
        Uns64 swipMask = mvipSwipMask(riscv);

        // return raw value merged with bits mastered in swip
        result &= ~swipMask;
        result |= (riscv->swip & swipMask);
    }

    return result;
}

//
// Common routine to write mvip using mvip or mviph alias
//
static Uns64 mvipIntW(riscvP riscv, Uns64 newValue, Uns64 halfMask) {

    Uns64 mask = RD_CSR_MASK64(riscv, mvip) & halfMask;

    if(riscv->inSaveRestore) {

        Uns64 oldValue = RD_CSR64(riscv, mvip);

        // update value using writable bit mask
        newValue = ((newValue & mask) | (oldValue & ~mask));

        // set raw value
        WR_CSR64(riscv, mvip, newValue);

    } else if(useCLICM(riscv)) {

        // RAZ/WI in CLIC mode
        newValue = 0;

    } else {

        Uns64 oldValue = mvipIntR(riscv);

        // update value using writable bit mask
        newValue = ((newValue & mask) | (oldValue & ~mask));

        if(oldValue!=newValue) {

            Uns64 swipMask = mvipSwipMask(riscv);
            Uns64 mvipMask = mask & ~swipMask;

            // update bits mastered in mvip
            Uns64 mvip = ((newValue & mvipMask) | (oldValue & ~mvipMask));
            WR_CSR64(riscv, mvip, mvip);

            // update bits mastered in swip (NOTE: only writable bits in mip
            // may be updated)
            swipMask &= RD_CSR_MASK64(riscv, mip);
            riscv->swip = ((newValue & swipMask) | (oldValue & ~swipMask));

            // handle any interrupts that are now pending and enabled
            riscvUpdatePending(riscv);
        }
    }

    // return readable bits
    return newValue;
}

//
// Read mvip
//
static RISCV_CSR_READFN(mvipR) {
    return mvipIntR(riscv);
}

//
// Read mviph
//
static RISCV_CSR_READFN(mviphR) {
    return mvipIntR(riscv) >> 32;
}

//
// Write mvip
//
static RISCV_CSR_WRITEFN(mvipW) {
    Uns64 wMask = maskMXLEN(riscv);
    return mvipIntW(riscv, newValue, wMask);
}

//
// Write mviph
//
static RISCV_CSR_WRITEFN(mviphW) {
    Uns64 wMask = TOP32_MASK;
    return mvipIntW(riscv, newValue<<32, wMask) >> 32;
}

//
// Common routine to read virtual interrupt enable alias bits
//
static Uns64 xvienIntR(riscvP riscv, Uns64 *valueP, Bool useCLIC) {

    Uns64 result = 0;

    if(riscv->inSaveRestore || !useCLIC) {
        result = *valueP;
    }

    return result;
}

//
// Common routine to read mvien using mvien or mvienh alias
//
static Uns64 mvienIntR(riscvP riscv) {
    return xvienIntR(riscv, &RD_CSR64(riscv, mvien), useCLICM(riscv));
}

//
// Common routine to write mvien using mvien or mvienh alias
//
static Uns64 mvienIntW(riscvP riscv, Uns64 newValue, Uns64 wMask) {
    Uns64 *valueP = &RD_CSR64(riscv, mvien);
    return xvipexW(riscv, valueP, newValue, wMask, useCLICM(riscv));
}

//
// Read mvien
//
static RISCV_CSR_READFN(mvienR) {
    return mvienIntR(riscv);
}

//
// Read mvienh
//
static RISCV_CSR_READFN(mvienhR) {
    return mvienIntR(riscv) >> 32;
}

//
// Write mvien
//
static RISCV_CSR_WRITEFN(mvienW) {
    Uns64 wMask = RD_CSR_MASK_M(riscv, mvien);
    return mvienIntW(riscv, newValue, wMask);
}

//
// Write mvienh
//
static RISCV_CSR_WRITEFN(mvienhW) {
    Uns64 wMask = RD_CSR_MASK64(riscv, mvien) & TOP32_MASK;
    return mvienIntW(riscv, newValue<<32, wMask) >> 32;
}

//
// Common routine to read hvien using hvien or hvienh alias
//
static Uns64 hvienIntR(riscvP riscv) {
    return xvienIntR(riscv, &RD_CSR64(riscv, hvien), useCLICS(riscv));
}

//
// Common routine to write hvien using hvien or hvienh alias
//
static Uns64 hvienIntW(riscvP riscv, Uns64 newValue, Uns64 wMask) {
    Uns64 *valueP = &RD_CSR64(riscv, hvien);
    return xvipexW(riscv, valueP, newValue, wMask, useCLICS(riscv));
}

//
// Read hvien
//
static RISCV_CSR_READFN(hvienR) {
    return hvienIntR(riscv);
}

//
// Read hvienh
//
static RISCV_CSR_READFN(hvienhR) {
    return hvienIntR(riscv) >> 32;
}

//
// Write hvien
//
static RISCV_CSR_WRITEFN(hvienW) {
    Uns64 wMask = RD_CSR_MASK_S(riscv, hvien);
    return hvienIntW(riscv, newValue, wMask);
}

//
// Write hvienh
//
static RISCV_CSR_WRITEFN(hvienhW) {
    Uns64 wMask = RD_CSR_MASK64(riscv, hvien) & TOP32_MASK;
    return hvienIntW(riscv, newValue<<32, wMask) >> 32;
}

//
// Write hvictl
//
static RISCV_CSR_WRITEFN(hvictlW) {

    Uns32 oldValue = RD_CSR_S(riscv, hvictl);
    Uns64 wMask    = RD_CSR_MASK_S(riscv, hvictl);

    newValue &= wMask;

    // update the CSR
    WR_CSR_S(riscv, hvictl, newValue);

    // test for pending interrupts
    if(oldValue!=newValue) {
        riscvUpdatePending(riscv);
    }

    // return written value
    return newValue;
}

//
// Is xiselect value an IPRIO address?
//
inline static Bool xiselectIsIPRIO(Uns64 xiselect) {
    return (xiselect>=0x30) && (xiselect<=0x3f);
}

//
// Is xiselect value an IMSIC address?
//
inline static Bool xiselectIsIMSIC(Uns64 xiselect) {
    return (xiselect>=0x70) && (xiselect<=0xff);
}

//
// Validate access to AIA registers
//
static Bool checkAIAAccess(riscvP riscv, riscvCSRStateenBit bit) {

    Bool valid = True;

    if(riscv->artifactAccess) {
        // ignore artifact access
    } else if(RD_CSR_MASK64(riscv, mstateen[0]) & (1ULL<<bit)) {
        valid = riscvStateenFeatureEnabled(riscv, bit, True);
    }

    return valid;
}

//
// Is access to the HS-mode interrupt file legal?
//
inline static const char *accessHSModeInterruptFile(riscvP riscv) {
    return (
        (getCurrentMode3(riscv)==RISCV_MODE_M) ||
        !RD_CSR_FIELDC(riscv, mvien, SEIP)
    ) ? 0 : "mvien.SEIP=1";
}

//
// Is access to the VS-mode interrupt file legal?
//
inline static const char *accessVSModeInterruptFile(riscvP riscv) {
    return RD_CSR_FIELDC(riscv, hstatus, VGEIN) ? 0 : "hstatus.VGEIN=0";
}

//
// Is xiselect value valid?
//
static Bool xiselectValid(
    riscvP      riscv,
    Uns64       xiselect,
    riscvMode   mode,
    const char *badReason
) {
    Bool V        = modeIsVirtual(mode);
    Bool valid    = False;
    Bool reserved = False;

    if(xiselectIsIPRIO(xiselect)) {

        if(V) {
            // invalid virtual access
            badReason = "illegal virtual access to IPRIO array";
        } else if(RISCV_XLEN_IS_64M(riscv, mode) && (xiselect&1)) {
            // illegal odd index for RV64
            badReason = "illegal odd index";
        } else {
            // validate Smstateen access constraints
            valid     = checkAIAAccess(riscv, bit_stateen_AIA);
            badReason = 0;
        }

    } else if(xiselectIsIMSIC(xiselect)) {

        if(!riscv->configInfo.IMSIC_present) {
            // invalid if IMSIC absent
            badReason = "IMSIC is absent";
        } else if(V && (badReason=accessVSModeInterruptFile(riscv))) {
            // invalid if virtual and hstatus.VGEIN=0
        } else if(!V && (badReason=accessHSModeInterruptFile(riscv))) {
            // invalid if not virtual and mvien.SEIP=1
        } else {
            // validate Smstateen access constraints
            valid     = checkAIAAccess(riscv, bit_stateen_IMSIC);
            badReason = 0;
        }

    } else if(RISCV_AIA_VERSION(riscv)>=RVAIA_1_0_RC5) {

        // from RC5, when vsiselect has a reserved value, attempts to access
        // sireg from VS mode or VU mode raise an Illegal Instruction exception
        // instead of a Virtual Instruction exception
        reserved = True;
    }

    // take trap if required
    if(badReason && !riscv->artifactAccess) {
        virtualOrIllegalMessage(riscv, badReason, reserved);
    }

    return valid;
}

//
// Write miselect
//
static RISCV_CSR_WRITEFN(miselectW) {

    if(newValue>=0x100) {
        // reserved value
    } else if((newValue>=0x40) && !riscv->configInfo.IMSIC_present) {
        // reserved value
    } else {
        WR_CSR64(riscv, miselect, newValue);
    }

    return RD_CSR64(riscv, miselect);
}

//
// Read siselect
//
static RISCV_CSR_READFN(siselectR) {

    return RD_CSR64(riscv, siselect);
}

//
// Write siselect
//
static RISCV_CSR_WRITEFN(siselectW) {

    if(newValue>=0x200) {
        // reserved value
    } else {
        WR_CSR64(riscv, siselect, newValue);
    }

    return RD_CSR64(riscv, siselect);
}

//
// Read vsiselect
//
static RISCV_CSR_READFN(vsiselectR) {

    return RD_CSR64(riscv, vsiselect);
}

//
// Write vsiselect
//
static RISCV_CSR_WRITEFN(vsiselectW) {

    if(newValue>=0x200) {
        // reserved value
    } else {
        WR_CSR64(riscv, vsiselect, newValue);
    }

    return RD_CSR64(riscv, vsiselect);
}

//
// Context for mireg read/write operation
//
typedef struct xiregCxtS {
    Bool  isIMSIC;      // whether an IMSIC range access
    Uns64 xiprioMask;   // mask of accessible 8-bit fields if xiprio access
    Uns32 base;         // base for access
    Uns32 elements;     // elements for access
    Uns32 IPRIOLEN;     // configured IPRIOLEN
} xiregCxt, *xiregCxtP;

//
// Validate access to xireg and fill context
//
static Bool xiregValidate(
    riscvP      riscv,
    xiregCxtP   cxt,
    Uns64       xieNZ,
    Uns64       xiselect,
    Uns64       xiprio_mask,
    riscvMode   mode,
    const char *badReason
) {
    riscvConfigCP cfg     = &riscv->configInfo;
    Bool          isIMSIC = xiselectIsIMSIC(xiselect);
    Bool          valid   = xiselectValid(riscv, xiselect, mode, badReason);

    // fill context
    cxt->isIMSIC    = isIMSIC;
    cxt->xiprioMask = xieNZ & xiprio_mask;
    cxt->base       = isIMSIC ? xiselect : (xiselect-0x30)*4;
    cxt->elements   = RISCV_XLEN_IS_32M(riscv, mode) ? 4 : 8;
    cxt->IPRIOLEN   = modeIsVirtual(mode) ? cfg->HIPRIOLEN : cfg->IPRIOLEN;

    return valid;
}

//
// Return IMSIC bus access address
//
inline static memDomainP getIMSICBusDomain(riscvP riscv) {
    return riscvGetExternalIMSICDomain(riscv);
}

//
// Return IMSIC bus access address
//
inline static memAccessAttrs getIMSICBusAccessAttrs(riscvP riscv) {
    return riscv->artifactAccess ? MEM_AA_TRUE : MEM_AA_FALSE;
}

//
// Return IMSIC bus access address
//
static Uns32 getIMSICBusAddress(xiregCxtP cxt, riscvMode mode) {

    if(modeIsVirtual(mode)) {
        mode = RISCV_MODE_H;
    }

    return (cxt->base<<4) | (mode<<12);
}

//
// Read externally-implemented IMSIC register
//
static Uns64 IMSICR(riscvP riscv, xiregCxtP cxt, riscvMode mode) {

    memDomainP     domain   = getIMSICBusDomain(riscv);
    memAccessAttrs memAttrs = getIMSICBusAccessAttrs(riscv);
    Uns32          address  = getIMSICBusAddress(cxt, mode);
    Uns64          result   = 0;

    // do read from IMSIC domain
    vmirtReadNByteDomain(
        domain, address, &result, cxt->elements, 0, memAttrs
    );

    // return new value
    return result;
}

//
// Write externally-implemented IMSIC register
//
static Uns64 IMSICW(riscvP riscv, xiregCxtP cxt, riscvMode mode, Uns64 newValue) {

    memDomainP     domain   = getIMSICBusDomain(riscv);
    memAccessAttrs memAttrs = getIMSICBusAccessAttrs(riscv);
    Uns32          address  = getIMSICBusAddress(cxt, mode);

    // do write to IMSIC domain
    vmirtWriteNByteDomain(
        domain, address, &newValue, cxt->elements, 0, memAttrs
    );

    // return new value
    return newValue;
}

//
// Is xiprio array entry selected?
//
inline static Bool xiprioSelect(xiregCxtP cxt, Uns32 index) {
    return (cxt->xiprioMask & (1ULL<<index));
}

//
// Read mireg corresponding to xiprio array address
//
static Uns64 xiprioR(xiregCxtP cxt, Uns8 *xiprio) {

    Uns32 i;

    union {Uns64 u64; Uns8 u8[8];} u = {0};

    for(i=0; i<cxt->elements; i++) {

        Uns32 index = cxt->base+i;

        if(xiprioSelect(cxt, index)) {
            u.u8[i] = xiprio[index];
        }
    }

    return u.u64;
}

//
// Write mireg corresponding to xiprio array address
//
static Uns64 xiprioW(xiregCxtP cxt, Uns8 *xiprio, Uns64 newValue) {

    Uns32 i;

    union {Uns64 u64; Uns8 u8[8];} u = {newValue};

    for(i=0; i<cxt->elements; i++) {

        Uns32 index = cxt->base+i;

        if(xiprioSelect(cxt, index)) {
            u.u8[i] &= ((1<<cxt->IPRIOLEN)-1);
            xiprio[index] = u.u8[i];
        } else {
            u.u8[i] = 0;
        }
    }

    return u.u64;
}

//
// Validate access to mireg and fill context
//
static Bool miregValidate(riscvP riscv, xiregCxtP cxt) {

    Uns64     xieNZ       = RD_CSR64(riscv, mie) | RD_CSR_MASK64(riscv, mie);
    Uns64     xiselect    = RD_CSR_M(riscv, miselect);
    Uns64     xiprio_mask = riscv->configInfo.miprio_mask;
    riscvMode mode        = RISCV_MODE_M;

    return xiregValidate(
        riscv, cxt, xieNZ, xiselect, xiprio_mask, mode, "illegal miselect"
    );
}

//
// Read mireg
//
static RISCV_CSR_READFN(miregR) {

    xiregCxt cxt;

    if(!miregValidate(riscv, &cxt)) {
        return 0;
    } else if(cxt.isIMSIC) {
        return IMSICR(riscv, &cxt, RISCV_MODE_M);
    } else {
        return xiprioR(&cxt, riscv->aia->miprio);
    }
}

//
// Write mireg
//
static RISCV_CSR_WRITEFN(miregW) {

    xiregCxt cxt;

    if(!miregValidate(riscv, &cxt)) {
        return 0;
    } else if(cxt.isIMSIC) {
        return IMSICW(riscv, &cxt, RISCV_MODE_M, newValue);
    } else {
        return xiprioW(&cxt, riscv->aia->miprio, newValue);
    }
}

//
// Validate access to sireg and fill context
//
static Bool siregValidate(riscvP riscv, xiregCxtP cxt) {

    Uns64     xieNZ       = getSIRMask(riscv) | RD_CSR64(riscv, mvien);
    Uns64     xiselect    = RD_CSR_S(riscv, siselect);
    Uns64     xiprio_mask = riscv->configInfo.siprio_mask;
    riscvMode mode        = RISCV_MODE_S;

    return xiregValidate(
        riscv, cxt, xieNZ, xiselect, xiprio_mask, mode, "illegal siselect"
    );
}

//
// Read sireg
//
static RISCV_CSR_READFN(siregR) {

    xiregCxt cxt;

    if(!siregValidate(riscv, &cxt)) {
        return 0;
    } else if(cxt.isIMSIC) {
        return IMSICR(riscv, &cxt, RISCV_MODE_S);
    } else {
        return xiprioR(&cxt, riscv->aia->siprio);
    }
}

//
// Write sireg
//
static RISCV_CSR_WRITEFN(siregW) {

    xiregCxt cxt;

    if(!siregValidate(riscv, &cxt)) {
        return 0;
    } else if(cxt.isIMSIC) {
        return IMSICW(riscv, &cxt, RISCV_MODE_S, newValue);
    } else {
        return xiprioW(&cxt, riscv->aia->siprio, newValue);
    }
}

//
// Validate access to vsireg and fill context
//
static Bool vsiregValidate(riscvP riscv, xiregCxtP cxt) {

    Uns64     xiselect = RD_CSR_VS(riscv, vsiselect);
    riscvMode mode     = RISCV_MODE_VS;

    return xiregValidate(
        riscv, cxt, 0, xiselect, 0, mode, "illegal vsiselect"
    );
}

//
// Read vsireg
//
static RISCV_CSR_READFN(vsiregR) {

    xiregCxt cxt;

    if(!vsiregValidate(riscv, &cxt)) {
        return 0;
    } else {
        return IMSICR(riscv, &cxt, RISCV_MODE_VS);
    }
}

//
// Write vsireg
//
static RISCV_CSR_WRITEFN(vsiregW) {

    xiregCxt cxt;

    if(!vsiregValidate(riscv, &cxt)) {
        return 0;
    } else {
        return IMSICW(riscv, &cxt, RISCV_MODE_VS, newValue);
    }
}

//
// Read mtopi
//
static RISCV_CSR_READFN(mtopiR) {
    return riscvGetMTOPI(riscv);
}

//
// Read stopi
//
static RISCV_CSR_READFN(stopiR) {
    return riscvGetSTOPI(riscv);
}

//
// Read vstopi
//
static RISCV_CSR_READFN(vstopiR) {
    return riscvGetVSTOPI(riscv);
}

//
// Return xtopei value filled from priority
//
static Uns32 xtopeiR(Uns32 xeiprio) {

    CSR_REG_DECL(topei) = {
        u32 : {
            fields : {
                identity : xeiprio, priority : xeiprio
            }
        }
    };

    return topei.u32.bits;
}

//
// Read mtopei
//
static RISCV_CSR_READFN(mtopeiR) {
    return xtopeiR(riscv->aia->meiprio);
}

//
// Read stopei
//
static RISCV_CSR_READFN(stopeiR) {

    Uns32       result = 0;
    const char *error;

    if(riscv->artifactAccess || !(error=accessHSModeInterruptFile(riscv))) {
        result = xtopeiR(riscv->aia->seiprio);
    } else {
        riscvIllegalInstructionMessage(riscv, error);
    }

    return result;
}

//
// Read vstopei
//
static RISCV_CSR_READFN(vstopeiR) {

    Uns32       result = 0;
    const char *error;

    if(riscv->artifactAccess || !(error=accessVSModeInterruptFile(riscv))) {
        result = xtopeiR(riscv->aia->vseiprio);
    } else {
        virtualOrIllegalMessage(riscv, error, False);
    }

    return result;
}

//
// Common routine to read hvipriox using hvipriox or hviprioxh alias
//
static Uns64 hviprioxIntR(riscvP riscv, const Uns8 *map) {

    Uns64 result = 0;
    Uns32 i;

    for(i=0; i<8; i++) {

        Uns32 shift = i*8;
        Uns64 iprio = riscv->aia->vsiprio[map[i]];

        result |= (iprio<<shift);
    }

    return result;
}

//
// Common routine to write hvipriox using hvipriox or hviprioxh alias
//
static Uns64 hviprioxIntW(
    riscvP      riscv,
    Uns64       newValue,
    const Uns8 *map,
    Uns32       lo,
    Uns32       hi
) {
    Uns64 xiprio_mask = riscv->configInfo.hviprio_mask;
    Uns32 i;

    for(i=lo; i<=hi; i++) {

        Uns32 index = map[i];
        Uns32 shift = (i-lo)*8;

        if(xiprio_mask & (1ULL<<index)) {
            riscv->aia->vsiprio[index] = newValue >> shift;
        } else {
            newValue &= ~(0xffULL<<shift);
        }
    }

    // return masked value
    return newValue;
}

//
// Return high bound for hvipriox update
//
inline static Uns32 hviprioxHi(riscvP riscv) {
    return RISCV_XLEN_IS_32M(riscv, RISCV_MODE_VS) ? 3 : 7;
}

//
// Element map for hviprio1
//
static const Uns8 hviprio1Map[] = {0, 1, 4, 5, 8, 13, 14, 15};

//
// Common routine to read hviprio1 using hviprio1 or hviprio1h alias
//
inline static Uns64 hviprio1IntR(riscvP riscv) {
    return hviprioxIntR(riscv, hviprio1Map);
}

//
// Common routine to write hviprio1 using hviprio1 or hviprio1h alias
//
inline static Uns64 hviprio1IntW(
    riscvP riscv,
    Uns64  newValue,
    Uns32  lo,
    Uns32  hi
) {
    return hviprioxIntW(riscv, newValue, hviprio1Map, lo, hi);
}

//
// Read hviprio1
//
static RISCV_CSR_READFN(hviprio1R) {
    return hviprio1IntR(riscv);
}

//
// Write hviprio1
//
static RISCV_CSR_WRITEFN(hviprio1W) {
    return hviprio1IntW(riscv, newValue, 0, hviprioxHi(riscv));
}

//
// Read hviprio1h
//
static RISCV_CSR_READFN(hviprio1hR) {
    return hviprio1IntR(riscv) >> 32;
}

//
// Write hviprio1h
//
static RISCV_CSR_WRITEFN(hviprio1hW) {
    return hviprio1IntW(riscv, newValue, 4, 7);
}

//
// Element map for hviprio2
//
static const Uns8 hviprio2Map[] = {16, 17, 18, 19, 20, 21, 22, 23};

//
// Common routine to read hviprio2 using hviprio2 or hviprio2h alias
//
inline static Uns64 hviprio2IntR(riscvP riscv) {
    return hviprioxIntR(riscv, hviprio2Map);
}

//
// Common routine to write hviprio2 using hviprio2 or hviprio2h alias
//
inline static Uns64 hviprio2IntW(
    riscvP riscv,
    Uns64  newValue,
    Uns32  lo,
    Uns32  hi
) {
    return hviprioxIntW(riscv, newValue, hviprio2Map, lo, hi);
}

//
// Read hviprio2
//
static RISCV_CSR_READFN(hviprio2R) {
    return hviprio2IntR(riscv);
}

//
// Write hviprio2
//
static RISCV_CSR_WRITEFN(hviprio2W) {
    return hviprio2IntW(riscv, newValue, 0, hviprioxHi(riscv));
}

//
// Read hviprio2h
//
static RISCV_CSR_READFN(hviprio2hR) {
    return hviprio2IntR(riscv) >> 32;
}

//
// Write hviprio2h
//
static RISCV_CSR_WRITEFN(hviprio2hW) {
    return hviprio2IntW(riscv, newValue, 4, 7);
}


////////////////////////////////////////////////////////////////////////////////
// INTERRUPT CONTROL REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Common routine to read ip using mip, sip or uip alias
//
static Uns64 ipR(riscvP riscv, Uns64 rMask, Bool useCLIC) {

    Uns64 result = 0;

    if(riscv->inSaveRestore) {

        // in save/restore mode, return raw software-writable value
        result = riscv->swip;

    } else if(!useCLIC) {

        // return composed value including external inputs if a read
        result = RD_CSR64(riscv, mip) & rMask;
    }

    return result;
}

//
// Common routine to read ip using mip, sip or uip alias in a read/write
// context
//
static Uns64 ipRW(riscvP riscv, Uns64 rMask, Uns64 wMask, Bool useCLIC) {

    Uns64 result = 0;

    if(!useCLIC) {

        // take account of mvien effect on writable bits
        wMask &= activeSwipMask(riscv);

        // if a read/write, return software-writable bits only in writable
        // positions (otherwise external inputs get propagated to sticky
        // software-writable bits by csrrs instructions)
        Uns64 composed = RD_CSR64(riscv, mip) & ~wMask;
        Uns64 swOnly   = riscv->swip          &  wMask;

        result = (composed|swOnly) & rMask;
    }

    return result;
}

//
// Common routine to write ip using mip, sip or uip alias
//
static Uns64 ipW(riscvP riscv, Uns64 newValue, Uns64 rMask, Bool useCLIC) {

    if(riscv->inSaveRestore || !useCLIC) {

        Uns64 oldValue = riscv->swip;
        Uns64 wMask    = RD_CSR_MASK64(riscv, mie) & rMask;

        // take account of mvien effect on writable bits
        wMask &= activeSwipMask(riscv);

        // update value using writable bit mask
        newValue = ((newValue & wMask) | (oldValue & ~wMask));

        riscv->swip = newValue;

        // handle any interrupts that are now pending and enabled
        if(oldValue!=newValue) {
            riscvUpdatePending(riscv);
        }
    }

    // return readable bits
    return ipR(riscv, rMask, useCLIC);
}

//
// Get write mask for mip register, allowing for Sstc extension stimecmp CSR
// (which makes mip.STIP appear read-only)
//
static Uns64 mipMaskW(riscvP riscv) {

    Uns64 mask = RD_CSR_MASK_M(riscv, mip);

    if(!riscv->inSaveRestore && stimecmpEnabled(riscv)) {
        mask &= ~(1ULL<<exceptionToInt(riscv_E_STimerInterrupt));
    }

    return mask;
}

//
// Read mip
//
static RISCV_CSR_READFN(mipR) {
    return ipR(riscv, -1, useCLICM(riscv));
}

//
// Read miph
//
static RISCV_CSR_READFN(miphR) {
    return ipR(riscv, -1, useCLICM(riscv)) >> 32;
}

//
// Read mip (read/write context)
//
static RISCV_CSR_READFN(mipRW) {
    Uns64 wMask = mipMaskW(riscv);
    return ipRW(riscv, -1, wMask, useCLICM(riscv));
}

//
// Read miph (read/write context)
//
static RISCV_CSR_READFN(miphRW) {
    Uns64 wMask = RD_CSR_MASK64(riscv, mip);
    return ipRW(riscv, -1, wMask, useCLICM(riscv)) >> 32;
}

//
// Write mip
//
static RISCV_CSR_WRITEFN(mipW) {
    Uns64 wMask = mipMaskW(riscv);
    return ipW(riscv, newValue, wMask, useCLICM(riscv));
}

//
// Write miph
//
static RISCV_CSR_WRITEFN(miphW) {
    Uns64 wMask = RD_CSR_MASK64(riscv, mip) & TOP32_MASK;
    return ipW(riscv, newValue<<32, wMask, useCLICM(riscv)) >> 32;
}

//
// Read hip
//
static RISCV_CSR_READFN(hipR) {
    return ipR(riscv, getHIRMask(riscv), useCLICH(riscv));
}

//
// Read hip (read/write context)
//
static RISCV_CSR_READFN(hipRW) {
    Uns64 wMask = RD_CSR_MASK64(riscv, hip);
    return ipRW(riscv, getHIRMask(riscv), wMask, useCLICH(riscv));
}

//
// Write hip
//
static RISCV_CSR_WRITEFN(hipW) {
    Uns64 wMask = getHIRMask(riscv) & RD_CSR_MASK_S(riscv, hip);
    return ipW(riscv, newValue, wMask, useCLICH(riscv));
}

//
// Common routine to read hvip CSR using either hvip or vsip alias
//
inline static Uns64 hvipCSRR(riscvP riscv, Bool useCLIC) {
    return useCLIC ? 0 : RD_CSR64(riscv, hvip);
}

//
// Common routine to write hvip CSR using either hvip or vsip alias
//
static Uns64 hvipCSRW(riscvP riscv, Uns64 newValue, Uns64 wMask) {
    Uns64 *valueP = &RD_CSR64(riscv, hvip);
    return xvipexW(riscv, valueP, newValue, wMask, useCLICS(riscv));
}

//
// Common routine to read hvip using hvip or hviph alias
//
static Uns64 hvipIntR(riscvP riscv) {

    // handle standard interrupt sources
    Bool  useCLIC = useCLICS(riscv);
    Uns64 rMask   = WM64_hvip;
    Uns64 ip      = ipR(riscv, rMask, useCLIC);

    // handle hvip sources
    ip |= hvipCSRR(riscv, useCLIC);

    return ip;
}

//
// Common routine to read hvip using hvip or hviph alias (read/write context)
//
static Uns64 hvipIntRW(riscvP riscv) {

    // handle standard interrupt sources
    Bool  useCLIC = useCLICS(riscv);
    Uns64 wMask   = WM64_hvip;
    Uns64 ip      = ipRW(riscv, wMask, wMask, useCLIC);

    // handle hvip sources
    ip |= hvipCSRR(riscv, useCLIC);

    return ip;
}

//
// Common routine to write hvip using hvip or hviph alias
//
static Uns64 hvipIntW(riscvP riscv, Uns64 newValue, Uns64 hvipMask) {

    // handle standard interrupt sources
    Uns64 wMask = WM64_hvip & hvipMask;
    Uns64 ip    = ipW(riscv, newValue, wMask, useCLICS(riscv));

    // handle hvip sources
    ip |= hvipCSRW(riscv, newValue, RD_CSR_MASK64(riscv, hvip) & hvipMask);

    return ip;
}

//
// Read hvip
//
static RISCV_CSR_READFN(hvipR) {
    return hvipIntR(riscv);
}

//
// Read hviph
//
static RISCV_CSR_READFN(hviphR) {
    return hvipIntR(riscv) >> 32;
}

//
// Read hvip (read/write context)
//
static RISCV_CSR_READFN(hvipRW) {
    return hvipIntRW(riscv);
}

//
// Write hvip
//
static RISCV_CSR_WRITEFN(hvipW) {
    Uns64 wMask = maskSXLEN(riscv);
    return hvipIntW(riscv, newValue, wMask);
}

//
// Write hviph
//
static RISCV_CSR_WRITEFN(hviphW) {
    Uns64 wMask = TOP32_MASK;
    return hvipIntW(riscv, newValue<<32, wMask) >> 32;
}

//
// Relocate SEIP, STIP and SSIE in VSEIP, VSTIP and VSSIE locations
//
static Uns64 relocateStoVS(Uns64 ip) {

    ip &= ~WM64_hvip<<1;
    ip |= (ip<<1) & WM64_hvip;

    return ip;
}

//
// Relocate VSEIP, VSTIP and VSSIE to SEIP, STIP and SSIE locations in the
// given value
//
static Uns64 relocateVStoS(Uns64 ip) {

    ip &= ~(WM64_hvip>>1);
    ip |= (ip&WM64_hvip)>>1;
    ip &= ~WM64_hvip;

    return ip;
}

//
// Common routine to read vsip using vsip or vsiph alias
//
static Uns64 vsipIntR(riscvP riscv) {

    // get mask of sources that should use hvip
    Uns64 hvien = getEffectiveHvien(riscv);

    // handle standard interrupt sources
    Bool  useCLIC = useCLICVS(riscv);
    Uns64 rMask   = getVSIRMask(riscv) & ~hvien;
    Uns64 ip      = ipR(riscv, rMask, useCLIC);

    // handle hvip sources
    ip |= (hvipCSRR(riscv, useCLIC) & hvien);

    // relocate VSEIP, VSTIP and VSSIE in SEIP, STIP and SSIE locations
    return relocateVStoS(ip);
}

//
// Common routine to read vsip using vsip or vsiph alias (read/write context)
//
static Uns64 vsipIntRW(riscvP riscv) {

    // get mask of sources that should use hvip
    Uns64 hvien = getEffectiveHvien(riscv);

    // handle standard interrupt sources
    Bool  useCLIC = useCLICVS(riscv);
    Uns64 wMask   = getVSIPWMask(riscv) & ~hvien;
    Uns64 ip      = ipRW(riscv, wMask, wMask, useCLIC);

    // handle hvip sources
    ip |= (hvipCSRR(riscv, useCLIC) & hvien);

    // relocate VSEIP, VSTIP and VSSIE in SEIP, STIP and SSIE locations
    return relocateVStoS(ip);
}

//
// Common routine to write vsip using vsip or vsiph alias
//
static Uns64 vsipIntW(riscvP riscv, Uns64 newValue, Uns64 vsipMask) {

    // get mask of sources that should use hvip
    Uns64 hvien = getEffectiveHvien(riscv);

    // relocate SEIP, STIP and SSIP in VSEIP, VSTIP and VSSIP locations
    newValue = relocateStoVS(newValue);

    // handle standard interrupt sources
    Bool  useCLIC = useCLICVS(riscv);
    Uns64 wMask   = getVSIPWMask(riscv) & ~hvien;
    Uns64 ip      = ipW(riscv, newValue, wMask, useCLIC);

    // handle hvip sources
    hvipCSRW(riscv, newValue, vsipMask & hvien);
    ip |= (hvipCSRR(riscv, useCLIC) & hvien);

    // relocate VSEIP, VSTIP and VSSIP in SEIP, STIP and SSIP locations
    return relocateVStoS(ip);
}

//
// Read vsip
//
static RISCV_CSR_READFN(vsipR) {
    return vsipIntR(riscv);
}

//
// Read vsiph
//
static RISCV_CSR_READFN(vsiphR) {
    return vsipIntR(riscv) >> 32;
}

//
// Read vsip (read/write context)
//
static RISCV_CSR_READFN(vsipRW) {
    return vsipIntRW(riscv);
}

//
// Read vsiph (read/write context)
//
static RISCV_CSR_READFN(vsiphRW) {
    return vsipIntRW(riscv) >> 32;
}

//
// Write vsip
//
static RISCV_CSR_WRITEFN(vsipW) {
    Uns64 wMask = maskVSXLEN(riscv);
    return vsipIntW(riscv, newValue, wMask);
}

//
// Write vsiph
//
static RISCV_CSR_WRITEFN(vsiphW) {
    Uns64 wMask = TOP32_MASK;
    return vsipIntW(riscv, newValue<<32, wMask) >> 32;
}

//
// Common routine to read sip using sip or siph alias
//
static Uns64 sipIntR(riscvP riscv) {

    // get mask of sources that should use mvip
    Uns64 mvien = getEffectiveMvien(riscv);

    // handle standard interrupt sources
    Uns64 rMask = getSIRMask(riscv) & ~mvien;
    Uns64 ip    = ipR(riscv, rMask, useCLICS(riscv));

    // handle mvip sources
    ip |= (mvipIntR(riscv) & mvien);

    return ip;
}

//
// Common routine to read sip using sip or siph alias (read/write context)
//
static Uns64 sipIntRW(riscvP riscv) {

    // get mask of sources that should use mvip
    Uns64 mvien = getEffectiveMvien(riscv);

    // handle standard interrupt sources
    Uns64 wMask = RD_CSR_MASK64(riscv, sip) & ~mvien;
    Uns64 rMask = getSIRMask(riscv)         & ~mvien;
    Uns64 ip    = ipRW(riscv, rMask, wMask, useCLICS(riscv));

    // handle mvip sources
    ip |= (mvipIntR(riscv) & mvien);

    return ip;
}

//
// Common routine to write sip using sip or siph alias
//
static Uns64 sipIntW(riscvP riscv, Uns64 newValue, Uns64 halfMask) {

    // get mask of sources that should use mvip
    Uns64 sipMask = RD_CSR_MASK64(riscv, sip) & halfMask;
    Uns64 mvien   = getEffectiveMvien(riscv);

    // handle standard interrupt sources
    Uns64 wMask = getSIRMask(riscv) & sipMask & ~mvien;
    Uns64 ip    = ipW(riscv, newValue, wMask, useCLICS(riscv));

    // handle mvip sources
    ip |= (mvipIntW(riscv, newValue, halfMask & mvien) & mvien);

    return ip;
}

//
// Read sip
//
static RISCV_CSR_READFN(sipR) {
    return sipIntR(riscv);
}

//
// Read siph
//
static RISCV_CSR_READFN(siphR) {
    return sipIntR(riscv) >> 32;
}

//
// Read sip (read/write context)
//
static RISCV_CSR_READFN(sipRW) {
    return sipIntRW(riscv);
}

//
// Read siph (read/write context)
//
static RISCV_CSR_READFN(siphRW) {
    return sipIntRW(riscv) >> 32;
}

//
// Write sip
//
static RISCV_CSR_WRITEFN(sipW) {
    Uns64 wMask = maskSXLEN(riscv);
    return sipIntW(riscv, newValue, wMask);
}

//
// Write siph
//
static RISCV_CSR_WRITEFN(siphW) {
    Uns64 wMask = TOP32_MASK;
    return sipIntW(riscv, newValue<<32, wMask) >> 32;
}

//
// Read uip
//
static RISCV_CSR_READFN(uipR) {
    return ipR(riscv, getUIRMask(riscv), useCLICU(riscv));
}

//
// Read uip (read/write context)
//
static RISCV_CSR_READFN(uipRW) {
    Uns64 wMask = RD_CSR_MASK64(riscv, uip);
    return ipRW(riscv, getUIRMask(riscv), wMask, useCLICU(riscv));
}

//
// Write uip
//
static RISCV_CSR_WRITEFN(uipW) {
    Uns64 wMask = getUIRMask(riscv) & RD_CSR_MASK_U(riscv, uip);
    return ipW(riscv, newValue, wMask, useCLICU(riscv));
}

//
// Common routine to read ie using mie, sie or uie alias
//
static Uns64 ieR(riscvP riscv, Uns64 rMask, Bool useCLIC) {

    Uns64 result = RD_CSR64(riscv, mie);

    if(riscv->inSaveRestore) {
        // no action
    } else if(!useCLIC) {
        result &= rMask;
    } else {
        result = 0;
    }

    return result;
}

//
// Common routine to write ie using mie, sie or uie alias
//
static Uns64 ieW(riscvP riscv, Uns64 newValue, Uns64 rMask, Bool useCLIC) {

    if(riscv->inSaveRestore || !useCLIC) {

        Uns64 oldValue = RD_CSR64(riscv, mie);
        Uns64 wMask    = RD_CSR_MASK64(riscv, mie) & rMask;

        // get new value using writable bit mask
        newValue = ((newValue & wMask) | (oldValue & ~wMask));

        // update the CSR
        WR_CSR64(riscv, mie, newValue);

        // handle any interrupts that are now pending and enabled
        if(oldValue!=newValue) {
            riscvTestInterrupt(riscv);
        }
    }

    // return readable bits
    return ieR(riscv, rMask, useCLIC);
}

//
// Read mie
//
static RISCV_CSR_READFN(mieR) {
    return ieR(riscv, -1, useCLICM(riscv));
}

//
// Read mieh
//
static RISCV_CSR_READFN(miehR) {
    return ieR(riscv, -1, useCLICM(riscv)) >> 32;
}

//
// Write mie
//
static RISCV_CSR_WRITEFN(mieW) {
    Uns64 wMask = maskMXLEN(riscv);
    return ieW(riscv, newValue, wMask, useCLICM(riscv));
}

//
// Write mieh
//
static RISCV_CSR_WRITEFN(miehW) {
    Uns64 wMask = TOP32_MASK;
    return ieW(riscv, newValue<<32, wMask, useCLICM(riscv)) >> 32;
}

//
// Common routine to read vsie using vsie or vsieh alias
//
static Uns64 vsieIntR(riscvP riscv) {

    // get mask of sources that should use hvip
    Uns64 hvien = getEffectiveHvien(riscv);

    // handle standard interrupt sources
    Uns64 rMask = getVSIRMask(riscv) & ~hvien;
    Uns64 ip    = ieR(riscv, rMask, useCLICVS(riscv));

    // handle hvie sources
    ip |= (RD_CSR64(riscv, vsie) & hvien);

    // relocate VSEIE, VSTIE and VSSIE in SEIE, STIE and SSIE locations
    return relocateVStoS(ip);
}

//
// Common routine to write vsie using vsie or vsieh alias
//
static Uns64 vsieIntW(riscvP riscv, Uns64 newValue, Uns64 vsieMask) {

    // get mask of sources that should use hvip
    Uns64 hvien = getEffectiveHvien(riscv);

    // relocate SEIE, STIE and SSIE in VSEIE, VSTIE and VSSIE locations
    newValue = relocateStoVS(newValue);

    // handle standard interrupt sources
    Bool  useCLIC = useCLICVS(riscv);
    Uns64 wMask   = getVSIRMask(riscv) & vsieMask & ~hvien;
    Uns64 ie      = ieW(riscv, newValue, wMask, useCLIC);

    // handle vsie sources
    Uns64 *valueP = &RD_CSR64(riscv, vsie);
    ie |= xvipexW(riscv, valueP, newValue, hvien & vsieMask, useCLIC);

    // relocate VSEIE, VSTIE and VSSIE in SEIE, STIE and SSIE locations
    return relocateVStoS(ie);
}

//
// Read vsie
//
static RISCV_CSR_READFN(vsieR) {
    return vsieIntR(riscv);
}

//
// Read vsieh
//
static RISCV_CSR_READFN(vsiehR) {
    return vsieIntR(riscv) >> 32;
}

//
// Write vsie
//
static RISCV_CSR_WRITEFN(vsieW) {
    Uns64 wMask = maskVSXLEN(riscv);
    return vsieIntW(riscv, newValue, wMask);
}

//
// Write vsieh
//
static RISCV_CSR_WRITEFN(vsiehW) {
    Uns64 wMask = TOP32_MASK;
    return vsieIntW(riscv, newValue<<32, wMask) >> 32;
}

//
// Return value of software-writeable bits in sie enabled by mvien
//
inline static Uns64 svieIntR(riscvP riscv, Bool useCLIC) {
    return useCLIC ? 0 : riscv->svie;
}

//
// Common routine to read sie using sie or sieh alias
//
static Uns64 sieIntR(riscvP riscv) {

    // get mask of sources that should use mvip (svie)
    Uns64 mvien = getEffectiveMvien(riscv);

    // handle standard interrupt sources
    Bool  useCLIC = useCLICS(riscv);
    Uns64 rMask   = getSIRMask(riscv) & ~mvien;
    Uns64 ie      = ieR(riscv, rMask, useCLIC);

    // handle mvip sources
    ie |= (svieIntR(riscv, useCLIC) & mvien);

    return ie;
}

//
// Common routine to write sie using sie or sieh alias
//
static Uns64 sieIntW(riscvP riscv, Uns64 newValue, Uns64 sieMask) {

    // get mask of sources that should use mvip (svie)
    Uns64 mvien = getEffectiveMvien(riscv);

    // handle standard interrupt sources
    Bool  useCLIC = useCLICS(riscv);
    Uns64 wMask   = getSIRMask(riscv) & sieMask & ~mvien;
    Uns64 ie      = ieW(riscv, newValue, wMask, useCLIC);

    // handle mvip sources
    Uns64 *valueP = &riscv->svie;
    ie |= xvipexW(riscv, valueP, newValue, mvien & sieMask, useCLIC);

    return ie;
}

//
// Read sie
//
static RISCV_CSR_READFN(sieR) {
    return sieIntR(riscv);
}

//
// Read sieh
//
static RISCV_CSR_READFN(siehR) {
    return sieIntR(riscv) >> 32;
}

//
// Write sie
//
static RISCV_CSR_WRITEFN(sieW) {
    Uns64 wMask = maskSXLEN(riscv);
    return sieIntW(riscv, newValue, wMask);
}

//
// Write sieh
//
static RISCV_CSR_WRITEFN(siehW) {
    Uns64 wMask = TOP32_MASK;
    return sieIntW(riscv, newValue<<32, wMask) >> 32;
}

//
// Read uie
//
static RISCV_CSR_READFN(uieR) {
    return ieR(riscv, getUIRMask(riscv), useCLICU(riscv));
}

//
// Write uie
//
static RISCV_CSR_WRITEFN(uieW) {
    Uns64 wMask = getUIRMask(riscv) & maskUXLEN(riscv);
    return ieW(riscv, newValue, wMask, useCLICU(riscv));
}

//
// Read hie
//
static RISCV_CSR_READFN(hieR) {
    return ieR(riscv, getHIRMask(riscv), useCLICH(riscv));
}

//
// Write hie
//
static RISCV_CSR_WRITEFN(hieW) {
    Uns64 wMask = getHIRMask(riscv) & maskSXLEN(riscv);
    return ieW(riscv, newValue, wMask, useCLICH(riscv));
}

//
// Write hgeie
//
static RISCV_CSR_WRITEFN(hgeieW) {

    Uns64 oldValue = RD_CSR64(riscv, hgeie);
    Uns64 mask     = ((1ULL<<getGEILEN(riscv))-1)<<1;

    // get new value using writable bit mask
    newValue = (newValue & mask);

    // update the CSR
    WR_CSR64(riscv, hgeie, newValue);

    // update interrupt state
    if(oldValue!=newValue) {
        riscvUpdatePending(riscv);
    }

    // return written value
    return newValue;
}

//
// Common routine to write mideleg
//
static Uns64 midelegWInt(riscvP riscv, Uns64 newValue, Uns64 mask) {

    Uns64 oldValue = RD_CSR64(riscv, mideleg);

    // get new value using writable bit mask
    newValue = ((newValue & mask) | (oldValue & ~mask));

    // update the CSR
    WR_CSR64(riscv, mideleg, newValue);

    // handle any interrupts that are now pending and enabled
    if(oldValue!=newValue) {
        riscvTestInterrupt(riscv);
    }

    // return written value
    return newValue;
}

//
// Read midelegh
//
static RISCV_CSR_READFN(mideleghR) {
    return RD_CSR64(riscv, mideleg) >> 32;
}

//
// Write mideleg
//
static RISCV_CSR_WRITEFN(midelegW) {
    Uns64 wMask = RD_CSR_MASK_M(riscv, mideleg);
    return midelegWInt(riscv, newValue, wMask);
}

//
// Write midelegh
//
static RISCV_CSR_WRITEFN(mideleghW) {
    Uns64 wMask = RD_CSR_MASK64(riscv, mideleg) & TOP32_MASK;
    return midelegWInt(riscv, newValue<<32, wMask) >> 32;
}

//
// Common routine to write hideleg
//
static Uns64 hidelegWInt(riscvP riscv, Uns64 newValue, Uns64 mask) {

    Uns64 oldValue = RD_CSR64(riscv, hideleg);
    Uns64 wMask    = hidelegWMask(riscv) & mask;

    // get new value using writable bit mask
    newValue = ((newValue & wMask) | (oldValue & ~wMask));

    // update the CSR
    WR_CSR64(riscv, hideleg, newValue);

    // handle any interrupts that are now pending and enabled
    if(oldValue!=newValue) {
        riscvTestInterrupt(riscv);
    }

    // return written value
    return newValue;
}

//
// Read hideleg
//
static RISCV_CSR_READFN(hidelegR) {
    return hidelegRInt(riscv);
}

//
// Read hidelegh
//
static RISCV_CSR_READFN(hideleghR) {
    return hidelegRInt(riscv) >> 32;
}

//
// Write hideleg
//
static RISCV_CSR_WRITEFN(hidelegW) {
    Uns64 wMask = maskSXLEN(riscv);
    return hidelegWInt(riscv, newValue, wMask);
}

//
// Write hidelegh
//
static RISCV_CSR_WRITEFN(hideleghW) {
    Uns64 wMask = TOP32_MASK;
    return hidelegWInt(riscv, newValue<<32, wMask) >> 32;
}

//
// Read sedeleg
//
static RISCV_CSR_READFN(sedelegR) {
    return sedelegRInt(riscv);
}

//
// Write sideleg
//
static RISCV_CSR_WRITEFN(sedelegW) {

    Uns64 oldValue = RD_CSR64(riscv, sedeleg);
    Uns64 mask     = sedelegWMask(riscv) & maskSXLEN(riscv);

    // get new value using writable bit mask
    newValue = ((newValue & mask) | (oldValue & ~mask));

    // update the CSR
    WR_CSR64(riscv, sedeleg, newValue);

    // return written value
    return newValue;
}

//
// Read sideleg
//
static RISCV_CSR_READFN(sidelegR) {
    return sidelegRInt(riscv);
}

//
// Write sideleg
//
static RISCV_CSR_WRITEFN(sidelegW) {

    Uns64 oldValue = RD_CSR64(riscv, sideleg);
    Uns64 mask     = sidelegWMask(riscv) & maskSXLEN(riscv);

    // get new value using writable bit mask
    newValue = ((newValue & mask) | (oldValue & ~mask));

    // update the CSR
    WR_CSR64(riscv, sideleg, newValue);

    // handle any interrupts that are now pending and enabled
    if(oldValue!=newValue) {
        riscvTestInterrupt(riscv);
    }

    // return written value
    return newValue;
}

//
// Read mcause
//
static RISCV_CSR_READFN(mcauseR) {

    if(!CLICPresent(riscv)) {
        // no further action
    } else if(useCLICM(riscv)) {
        // mirror mcause.pp and mcause.pie from masters in mstatus
        WR_CSR_FIELDC(riscv, mcause, pp,  RD_CSR_FIELDC(riscv, mstatus, MPP));
        WR_CSR_FIELDC(riscv, mcause, pie, RD_CSR_FIELDC(riscv, mstatus, MPIE));
    } else {
        // clear mcause.pp and mcause.pie
        WR_CSR_FIELDC(riscv, mcause, pp,  0);
        WR_CSR_FIELDC(riscv, mcause, pie, 0);
    }

    // return value
    return RD_CSR_M(riscv, mcause);
}

//
// Write mcause
//
static RISCV_CSR_WRITEFN(mcauseW) {

    // update the CSR
    WR_CSR64(riscv, mcause, newValue & RD_CSR_MASK64(riscv, mcause));

    if(!CLICPresent(riscv)) {

        // no further action

    } else if(useCLICM(riscv)) {

        // get old and new values of PP field
        Uns32 PPMask = RD_CSR_MASK_FIELDC(riscv, mstatus, MPP);
        Uns32 oldPP  = RD_CSR_FIELDC(riscv, mstatus, MPP);
        Uns32 newPP  = RD_CSR_FIELDC(riscv, mcause, pp);

        // get new PP value using writable bit mask
        newPP = ((newPP & PPMask) | (oldPP & ~PPMask));

        // mirror PP and IE fields to masters in mstatus
        WR_CSR_FIELDC(riscv, mstatus, MPP,  newPP);
        WR_CSR_FIELDC(riscv, mstatus, MPIE, RD_CSR_FIELDC(riscv, mcause, pie));

        // adjust cause alias to match status master
        WR_CSR_FIELDC(riscv, mcause, pp, newPP);

    } else if(!riscv->inSaveRestore) {

        // clear fields that appear hard-wired to zero in basic mode
        WR_CSR_FIELDC(riscv, mcause, inhv, 0);
        WR_CSR_FIELDC(riscv, mcause, pp,   0);
        WR_CSR_FIELDC(riscv, mcause, pie,  0);
        WR_CSR_FIELDC(riscv, mcause, pil,  0);
    }

    // return written value
    return RD_CSR_M(riscv, mcause);
}

//
// Read scause
//
static RISCV_CSR_READFN(scauseR) {

    if(!CLICPresent(riscv)) {
        // no further action
    } else if(useCLICS(riscv)) {
        // mirror scause.pp and scause.pie from masters in mstatus
        WR_CSR_FIELDC(riscv, scause, pp,  RD_CSR_FIELDC(riscv, mstatus, SPP));
        WR_CSR_FIELDC(riscv, scause, pie, RD_CSR_FIELDC(riscv, mstatus, SPIE));
    } else {
        // clear scause.pp and scause.pie
        WR_CSR_FIELDC(riscv, scause, pp,  0);
        WR_CSR_FIELDC(riscv, scause, pie, 0);
    }

    // return value
    return RD_CSR_S(riscv, scause);
}

//
// Write scause
//
static RISCV_CSR_WRITEFN(scauseW) {

    // update the CSR
    WR_CSR64(riscv, scause, newValue & RD_CSR_MASK64(riscv, scause));

    if(!CLICPresent(riscv)) {

        // no further action

    } else if(useCLICS(riscv)) {

        // get old and new values of PP field
        Uns32 PPMask = RD_CSR_MASK_FIELDC(riscv, mstatus, SPP);
        Uns32 oldPP  = RD_CSR_FIELDC(riscv, mstatus, SPP);
        Uns32 newPP  = RD_CSR_FIELDC(riscv, scause, pp);

        // get new PP value using writable bit mask
        newPP = ((newPP & PPMask) | (oldPP & ~PPMask));

        // mirror PP and IE fields to masters in mstatus
        WR_CSR_FIELDC(riscv, mstatus, SPP,  newPP);
        WR_CSR_FIELDC(riscv, mstatus, SPIE, RD_CSR_FIELDC(riscv, scause, pie));

        // adjust cause alias to match status master
        WR_CSR_FIELDC(riscv, scause, pp, newPP);

    } else if(!riscv->inSaveRestore) {

        // clear fields that appear hard-wired to zero in basic mode
        WR_CSR_FIELDC(riscv, scause, inhv, 0);
        WR_CSR_FIELDC(riscv, scause, pp,   0);
        WR_CSR_FIELDC(riscv, scause, pie,  0);
        WR_CSR_FIELDC(riscv, scause, pil,  0);
    }

    // return written value
    return RD_CSR_S(riscv, scause);
}

//
// Read ucause
//
static RISCV_CSR_READFN(ucauseR) {

    if(!CLICPresent(riscv)) {
        // no further action
    } else if(useCLICU(riscv)) {
        // mirror ucause.pie from master in mstatus
        WR_CSR_FIELDC(riscv, ucause, pie, RD_CSR_FIELDC(riscv, mstatus, UPIE));
    } else {
        // clear ucause.pie
        WR_CSR_FIELDC(riscv, ucause, pie, 0);
    }

    // return value
    return RD_CSR_U(riscv, ucause);
}

//
// Write ucause
//
static RISCV_CSR_WRITEFN(ucauseW) {

    // update the CSR
    WR_CSR64(riscv, ucause, newValue & RD_CSR_MASK64(riscv, ucause));

    if(!CLICPresent(riscv)) {
        // no further action
    } else if(useCLICU(riscv)) {
        // mirror ucause.pie to master in mstatus
        WR_CSR_FIELDC(riscv, mstatus, UPIE, RD_CSR_FIELDC(riscv, ucause, pie));
    } else if(!riscv->inSaveRestore) {
        // clear fields that appear hard-wired to zero in basic mode
        WR_CSR_FIELDC(riscv, ucause, inhv, 0);
        WR_CSR_FIELDC(riscv, ucause, pie,  0);
        WR_CSR_FIELDC(riscv, ucause, pil,  0);
    }

    // return written value
    return RD_CSR_U(riscv, ucause);
}

//
// Perform actions when reading xnxti CSR
//
#define READ_NXTI(_RESULT, _P, _x, _MODE) \
                                                                            \
    /* initially assume no horizontal interrupt */                          \
    _RESULT = 0;                                                            \
                                                                            \
    if(                                                                     \
        (_P->clic.sel.priv==_MODE) &&                                       \
        (_P->clic.sel.level > RD_CSR_FIELDC(riscv, _x##cause, pil)) &&      \
        (_P->clic.sel.level > RD_CSR_FIELDC(riscv, _x##intthresh, th)) &&   \
        (!_P->clic.sel.shv)                                                 \
    ) {                                                                     \
        /* get horizontal interrupt address */                              \
        Uns32 bytes = RISCV_XLEN_BYTESM(_P, _MODE);                         \
        _RESULT = (                                                         \
            RD_CSR_MODE(_P, _MODE, _x##tvt) +                               \
            (bytes*_P->clic.sel.id)                                         \
        );                                                                  \
    }

//
// Perform actions when writing xnxti CSR
//
#define WRITE_NXTI(_RESULT, _NEWVALUE, _P, _x, _MODE) \
                                                                            \
    /* update status register regardless of interrupt readiness */          \
    _x##statusW(0, _P, _NEWVALUE);                                          \
                                                                            \
    /* read xntxi CSR */                                                    \
    READ_NXTI(_RESULT, _P, _x, _MODE);                                      \
                                                                            \
    /* update state if horizontal interrupt requires service */             \
    if(_RESULT) {                                                           \
        WR_CSR_FIELDC(_P, mintstatus, _x##il, _P->clic.sel.level);          \
        WR_CSR_FIELDC(_P, _x##cause, ExceptionCode, _P->clic.sel.id);       \
        WR_CSR_FIELD_MODE(_P, _MODE, _x##cause, Interrupt, 1);              \
        riscvAcknowledgeCLICInt(_P, _P->clic.sel.id);                       \
    }

//
// Read mnxti
//
static RISCV_CSR_READFN(mnxtiR) {

    Uns64 result;

    READ_NXTI(result, riscv, m, RISCV_MODE_M);

    return result;
}

//
// Write mnxti
//
static RISCV_CSR_WRITEFN(mnxtiW) {

    Uns64 result;

    WRITE_NXTI(result, newValue, riscv, m, RISCV_MODE_M);

    return result;
}

//
// Read snxti
//
static RISCV_CSR_READFN(snxtiR) {

    Uns64 result;

    READ_NXTI(result, riscv, s, RISCV_MODE_S);

    return result;
}

//
// Write snxti
//
static RISCV_CSR_WRITEFN(snxtiW) {

    Uns64 result;

    WRITE_NXTI(result, newValue, riscv, s, RISCV_MODE_S);

    return result;
}

//
// Read unxti
//
static RISCV_CSR_READFN(unxtiR) {

    Uns64 result;

    READ_NXTI(result, riscv, u, RISCV_MODE_U);

    return result;
}

//
// Write unxti
//
static RISCV_CSR_WRITEFN(unxtiW) {

    Uns64 result;

    WRITE_NXTI(result, newValue, riscv, u, RISCV_MODE_U);

    return result;
}

//
// Read sintstatus
//
static RISCV_CSR_READFN(sintstatusR) {
    return RD_CSRC(riscv, mintstatus) & RM32_sintstatus;
}

//
// Read uintstatus
//
static RISCV_CSR_READFN(uintstatusR) {
    return RD_CSRC(riscv, mintstatus) & RM32_uintstatus;
}

//
// Does the current processor mode match the mode in xstatus.xpp?
//
static Bool xppIsCurrent(riscvP riscv) {

    riscvMode mode  = getCurrentMode5(riscv);
    Bool      match = False;

    if(riscv->artifactAccess) {
        // no action
    } else if(mode==RISCV_MODE_M) {
        match = RD_CSR_FIELDC(riscv, mstatus, MPP)==RISCV_MODE_M;
    } else if(mode==RISCV_MODE_S) {
        match = RD_CSR_FIELDC(riscv, mstatus, SPP)==RISCV_MODE_S;
    } else if(mode==RISCV_MODE_VS) {
        match = RD_CSR_FIELDC(riscv, vsstatus, SPP)==RISCV_MODE_S;
    }

    return match;
}

//
// Perform actions when reading scratchcsw CSR
//
#define READ_SCRATCHCSW(_P, _x, _MODE) { \
                                                                        \
    Uns64 result = 0;                                                   \
                                                                        \
    /* return scratch register unless mstatus.xpp is current mode */    \
    if(!xppIsCurrent(riscv)) {                                          \
        result = RD_CSR_MODE(riscv, _MODE, _x##scratch);                \
    }                                                                   \
                                                                        \
    return result;                                                      \
}

//
// Perform actions when writing scratchcsw CSR
//
#define WRITE_SCRATCHCSW(_NEWVALUE, _P, _x, _MODE) { \
                                                                        \
    Uns64 result = _NEWVALUE;                                           \
                                                                        \
    /* update scratch register unless mstatus.xpp is current mode */    \
    if(!xppIsCurrent(riscv)) {                                          \
        result = RD_CSR_MODE(riscv, _MODE, _x##scratch);                \
        WR_CSR_MODE(riscv, _MODE, _x##scratch, _NEWVALUE);              \
    }                                                                   \
                                                                        \
    return result;                                                      \
}

//
// Read mscratchcsw
//
static RISCV_CSR_READFN(mscratchcswR) {
    READ_SCRATCHCSW(riscv, m, RISCV_MODE_M);
}

//
// Write mscratchcsw
//
static RISCV_CSR_WRITEFN(mscratchcswW) {
    WRITE_SCRATCHCSW(newValue, riscv, m, RISCV_MODE_M);
}

//
// Read sscratchcsw
//
static RISCV_CSR_READFN(sscratchcswR) {
    READ_SCRATCHCSW(riscv, s, RISCV_MODE_S);
}

//
// Write sscratchcsw
//
static RISCV_CSR_WRITEFN(sscratchcswW) {
    WRITE_SCRATCHCSW(newValue, riscv, s, RISCV_MODE_S);
}

//
// Read vsscratchcsw (assumed, if CLIC+H supported)
//
static RISCV_CSR_READFN(vsscratchcswR) {
    READ_SCRATCHCSW(riscv, vs, RISCV_MODE_VS);
}

//
// Write vsscratchcsw (assumed, if CLIC+H supported)
//
static RISCV_CSR_WRITEFN(vsscratchcswW) {
    WRITE_SCRATCHCSW(newValue, riscv, vs, RISCV_MODE_VS);
}

//
// Perform actions when reading scratchcswl CSR
//
#define READ_SCRATCHCSWL(_P, _x, _MODE) { \
                                                                        \
    Uns64 result = 0;                                                   \
                                                                        \
    /* return scratch register if interrupter and interruptee not */    \
    /* both application tasks or interrupt handlers */                  \
    if(                                                                 \
        (RD_CSR_FIELDC(_P, _x##cause, pil)==0) !=                       \
        (RD_CSR_FIELDC(_P, mintstatus, _x##il)==0)                      \
    ) {                                                                 \
        result = RD_CSR_MODE(riscv, _MODE, _x##scratch);                \
    }                                                                   \
                                                                        \
    return result;                                                      \
}

//
// Perform actions when writing scratchcswl CSR
//
#define WRITE_SCRATCHCSWL(_NEWVALUE, _P, _x, _MODE) { \
                                                                        \
    Uns64 result = _NEWVALUE;                                           \
                                                                        \
    /* update scratch register if interrupter and interruptee not */    \
    /* both application tasks or interrupt handlers */                  \
    if(                                                                 \
        (RD_CSR_FIELDC(_P, _x##cause, pil)==0) !=                       \
        (RD_CSR_FIELDC(_P, mintstatus, _x##il)==0)                      \
    ) {                                                                 \
        result = RD_CSR_MODE(riscv, _MODE, _x##scratch);                \
        WR_CSR_MODE(riscv, _MODE, _x##scratch, _NEWVALUE);              \
    }                                                                   \
                                                                        \
    return result;                                                      \
}

//
// Read mscratchcswl
//
static RISCV_CSR_READFN(mscratchcswlR) {
    READ_SCRATCHCSWL(riscv, m, RISCV_MODE_M);
}

//
// Write mscratchcswl
//
static RISCV_CSR_WRITEFN(mscratchcswlW) {
    WRITE_SCRATCHCSWL(newValue, riscv, m, RISCV_MODE_M);
}

//
// Read sscratchcswl
//
static RISCV_CSR_READFN(sscratchcswlR) {
    READ_SCRATCHCSWL(riscv, s, RISCV_MODE_S);
}

//
// Write sscratchcswl
//
static RISCV_CSR_WRITEFN(sscratchcswlW) {
    WRITE_SCRATCHCSWL(newValue, riscv, s, RISCV_MODE_S);
}

//
// Read vsscratchcswl (assumed, if CLIC+H supported)
//
static RISCV_CSR_READFN(vsscratchcswlR) {
    READ_SCRATCHCSWL(riscv, vs, RISCV_MODE_VS);
}

//
// Write vsscratchcswl (assumed, if CLIC+H supported)
//
static RISCV_CSR_WRITEFN(vsscratchcswlW) {
    WRITE_SCRATCHCSWL(newValue, riscv, vs, RISCV_MODE_VS);
}

//
// Read uscratchcswl
//
static RISCV_CSR_READFN(uscratchcswlR) {
    READ_SCRATCHCSWL(riscv, u, RISCV_MODE_U);
}

//
// Write uscratchcswl
//
static RISCV_CSR_WRITEFN(uscratchcswlW) {
    WRITE_SCRATCHCSWL(newValue, riscv, u, RISCV_MODE_U);
}

//
// Perform actions when writing intthresh CSR
//
#define WRITE_INTTHRESH(_NEWVALUE, _P, _x) { \
                                                                        \
    /* force hardwired-to-1 bits */                                     \
    newValue |= (_P)->threshOnes;                                       \
                                                                        \
    /* update threshold level */                                        \
    Uns32 oldLevel = RD_CSR_FIELDC(_P, _x##intthresh, th);              \
    WR_CSR_FIELDC(_P, _x##intthresh, th, newValue);                     \
    Uns32 newLevel = RD_CSR_FIELDC(_P, _x##intthresh, th);              \
                                                                        \
    /* check for pending interrupts if threshold level drops */         \
    if(newLevel<oldLevel) {                                             \
        riscvTestInterrupt(_P);                                         \
    }                                                                   \
                                                                        \
    /* return new value */                                              \
    return RD_CSRC(riscv, _x##intthresh);                               \
}

//
// Write mintthresh
//
static RISCV_CSR_WRITEFN(mintthreshW) {
    WRITE_INTTHRESH(newValue, riscv, m);
}

//
// Write sintthresh
//
static RISCV_CSR_WRITEFN(sintthreshW) {
    WRITE_INTTHRESH(newValue, riscv, s);
}

//
// Write uintthresh
//
static RISCV_CSR_WRITEFN(uintthreshW) {
    WRITE_INTTHRESH(newValue, riscv, u);
}

//
// Read mclicbase
//
static RISCV_CSR_READFN(mclicbaseR) {
    return riscv->configInfo.mclicbase;
}

//
// Write mclicbase
//
// NOTE: the specification states that this register is read-only, but it is
// located in the read/write CSR index space. If it is relocated to a read-only
// location, this code can be removed.
//
static RISCV_CSR_WRITEFN(mclicbaseW) {
    return riscv->configInfo.mclicbase;
}


////////////////////////////////////////////////////////////////////////////////
// TRAP VECTOR REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Derive new value for xtvec register based on given value, rounding to
// configured alignment if vectored or CLIC mode is specified
//
static Uns64 tvecR(Uns64 tvec, riscvICMode mode) {

    // apply fixed alignment constraint in CLIC mode
    if(mode&riscv_int_CLIC) {
        tvec &= -0x40;
    }

    // insert mode
    tvec &= -4;
    tvec |= mode;

    // return effective value
    return tvec;
}

//
// Derive new value for xtvec register based on given value, rounding to
// configured alignment if vectored or CLIC mode is specified
//
static Uns64 tvecW(
    riscvP riscv,
    Int64  newValue,
    Uns64  oldValue,
    Uns64  mask,
    Uns8   sext
) {
    // mask new value
    riscvICMode oldMode = oldValue&3;
    newValue = ((newValue & mask) | (oldValue & ~mask));
    riscvICMode newMode = newValue&3;

    // handle sign extension from most-significant bit
    newValue = (newValue<<sext) >> sext;

    // constrain newMode to legal value
    if(!basicICPresent(riscv) && !(newMode&riscv_int_CLIC)) {
        newMode = oldMode;
    } else if(newMode!=riscv_int_CLIC_Direct) {
        // no action
    } else if(riscv->configInfo.CLIC_version>=RVCLC_0_9_20191208) {
        newMode = oldMode;
    }

    // apply any additional alignment constraint in vectored or CLIC mode
    Int32 tvec_align = riscv->configInfo.tvec_align;
    if(tvec_align && (newMode!=riscv_int_Direct)) {
        newValue &= -tvec_align;
    }

    // return value with fields adjusted for CLIC mode
    return tvecR(newValue, newMode);
}

//
// Perform common actions when updating *tvec CSR
//
#define UPDATE_TVEC(_P, _x, _VALUE, _MODE) { \
                                                                        \
    /* update the CSR, observing mode change */                         \
    riscvMode   priv    = RISCV_MODE_##_MODE;                           \
    riscvICMode oldMode = riscvGetIntMode##_MODE(_P);                   \
    WR_CSR_MODE(_P, priv, _x##tvec, _VALUE);                            \
    riscvICMode newMode = riscvGetIntMode##_MODE(_P);                   \
                                                                        \
    /* get old and new CLIC mode */                                     \
    Bool oldCLIC = (oldMode&riscv_int_CLIC);                            \
    Bool newCLIC = (newMode&riscv_int_CLIC);                            \
                                                                        \
    /* handle possible CLIC mode change */                              \
    if(!riscv->inSaveRestore && (oldCLIC!=newCLIC)) {                   \
                                                                        \
        /* zero xinhv and xpil if disabling CLIC mode */                \
        if(newCLIC) {                                                   \
                                                                        \
            /* no action for switch to CLIC mode */                     \
                                                                        \
        } else if(!mtvecDeterminesCLICMode(_P)) {                       \
                                                                        \
            /* CLIC mode specifiable per privilege level */             \
            WR_CSR_FIELDC(_P, _x##cause, inhv, 0);                      \
            WR_CSR_FIELDC(_P, _x##cause, pil,  0);                      \
                                                                        \
        } else if(priv==RISCV_MODE_M) {                                 \
                                                                        \
            /* CLIC mode specifiable only at M-mode */                  \
            WR_CSR_FIELDC(_P, mcause, inhv, 0);                         \
            WR_CSR_FIELDC(_P, scause, inhv, 0);                         \
            WR_CSR_FIELDC(_P, ucause, inhv, 0);                         \
            WR_CSR_FIELDC(_P, mcause, pil,  0);                         \
            WR_CSR_FIELDC(_P, scause, pil,  0);                         \
            WR_CSR_FIELDC(_P, ucause, pil,  0);                         \
        }                                                               \
                                                                        \
        /* handle interrupts that are now pending */                    \
        riscvTestInterrupt(_P);                                         \
    }                                                                   \
}

//
// Write mtvec
//
static RISCV_CSR_WRITEFN(mtvecW) {

    Uns64 oldValue = RD_CSR_M(riscv, mtvec);
    Uns64 mask     = RD_CSR_MASK_M(riscv, mtvec);
    Uns8  sext     = riscv->configInfo.mtvec_sext;

    newValue = tvecW(riscv, newValue, oldValue, mask, sext);

    // update the CSR
    UPDATE_TVEC(riscv, m, newValue, M);

    // return written value
    return newValue;
}

//
// Read vstvec
//
static RISCV_CSR_READFN(vstvecR) {
    return tvecR(RD_CSR_VS(riscv, vstvec), riscvGetIntModeVS(riscv));
}

//
// Write vstvec
//
static RISCV_CSR_WRITEFN(vstvecW) {

    Uns64 oldValue = RD_CSR_VS(riscv, vstvec);
    Uns64 mask     = RD_CSR_MASK_VS(riscv, vstvec);
    Uns8  sext     = riscv->configInfo.stvec_sext;

    newValue = tvecW(riscv, newValue, oldValue, mask, sext);

    // update the CSR
    WR_CSR_VS(riscv, vstvec, newValue);

    // return written value
    return newValue;
}

//
// Read stvec
//
static RISCV_CSR_READFN(stvecR) {
    return tvecR(RD_CSR_S(riscv, stvec), riscvGetIntModeS(riscv));
}

//
// Write stvec
//
static RISCV_CSR_WRITEFN(stvecW) {

    Uns64 oldValue = RD_CSR_S(riscv, stvec);
    Uns64 mask     = RD_CSR_MASK_S(riscv, stvec);
    Uns8  sext     = riscv->configInfo.stvec_sext;

    newValue = tvecW(riscv, newValue, oldValue, mask, sext);

    // update the CSR
    UPDATE_TVEC(riscv, s, newValue, S);

    // return written value
    return newValue;
}

//
// Read utvec
//
static RISCV_CSR_READFN(utvecR) {
    return tvecR(RD_CSR_U(riscv, utvec), riscvGetIntModeU(riscv));
}

//
// Write utvec
//
static RISCV_CSR_WRITEFN(utvecW) {

    Uns64 oldValue = RD_CSR_U(riscv, utvec);
    Uns64 mask     = RD_CSR_MASK_U(riscv, utvec);
    Uns8  sext     = riscv->configInfo.utvec_sext;

    newValue = tvecW(riscv, newValue, oldValue, mask, sext);

    // update the CSR
    UPDATE_TVEC(riscv, u, newValue, U);

    // return written value
    return newValue;
}

//
// Derive new value for xtvt register based on given value
//
static Uns64 tvtW(Int64 newValue, Uns64 oldValue, Uns64 mask, Uns8 sext) {

    // mask new value
    newValue = ((newValue & mask) | (oldValue & ~mask));

    // handle sign extension from most-significant bit
    return (newValue<<sext) >> sext;
}

//
// Write mtvt
//
static RISCV_CSR_WRITEFN(mtvtW) {

    Uns64 oldValue = RD_CSR_M(riscv, mtvt);
    Uns64 mask     = RD_CSR_MASK_M(riscv, mtvt);
    Uns8  sext     = riscv->configInfo.mtvt_sext;

    newValue = tvtW(newValue, oldValue, mask, sext);

    // update the CSR
    WR_CSR_M(riscv, mtvt, newValue);

    // return written value
    return newValue;
}

//
// Write stvt
//
static RISCV_CSR_WRITEFN(stvtW) {

    Uns64 oldValue = RD_CSR_S(riscv, stvt);
    Uns64 mask     = RD_CSR_MASK_S(riscv, stvt);
    Uns8  sext     = riscv->configInfo.stvt_sext;

    newValue = tvtW(newValue, oldValue, mask, sext);

    // update the CSR
    WR_CSR_S(riscv, stvt, newValue);

    // return written value
    return newValue;
}

//
// Write utvt
//
static RISCV_CSR_WRITEFN(utvtW) {

    Uns64 oldValue = RD_CSR_U(riscv, utvt);
    Uns64 mask     = RD_CSR_MASK_U(riscv, utvt);
    Uns8  sext     = riscv->configInfo.utvt_sext;

    newValue = tvtW(newValue, oldValue, mask, sext);

    // update the CSR
    WR_CSR_U(riscv, utvt, newValue);

    // return written value
    return newValue;
}


////////////////////////////////////////////////////////////////////////////////
// PERFORMANCE MONITOR REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Is time CSR present?
//
inline static RISCV_CSR_PRESENTFN(timeP) {
    return !riscv->configInfo.time_undefined;
}

//
// Is cycle CSR present?
//
inline static RISCV_CSR_PRESENTFN(cycleP) {
    return !riscv->configInfo.cycle_undefined;
}

//
// Is mcycle CSR present?
//
inline static RISCV_CSR_PRESENTFN(mcycleP) {
    return !riscv->configInfo.mcycle_undefined;
}

//
// Is instret CSR present?
//
inline static RISCV_CSR_PRESENTFN(instretP) {
    return !riscv->configInfo.instret_undefined;
}

//
// Is minstret CSR present?
//
inline static RISCV_CSR_PRESENTFN(minstretP) {
    return !riscv->configInfo.minstret_undefined;
}

//
// Are hpmcounter CSRs present?
//
inline static RISCV_CSR_PRESENTFN(hpmcounterP) {
    return !riscv->configInfo.hpmcounter_undefined;
}

//
// Are mhpmcounter CSRs present?
//
inline static RISCV_CSR_PRESENTFN(mhpmcounterP) {
    return !riscv->configInfo.mhpmcounter_undefined;
}

//
// Is mcounteren present?
//
inline static RISCV_CSR_PRESENTFN(mcounterenP) {
    riscvArchitecture arch = riscv->configInfo.arch;
    return riscv->configInfo.mcounteren_present || (arch&ISA_U);
}

//
// Return a Boolean indicating if the indicated bit in xcounteren is set (and
// take an Undefined Instruction or Virtual Instruction trap if not)
//
static Bool xcounterenSet(riscvP riscv, Uns32 mask) {

    riscvMode mode = getCurrentMode3(riscv);
    Bool      ok   = False;

    if(riscv->artifactAccess) {

        // all artifact accesses are allowed
        ok = True;

    } else if((mode<RISCV_MODE_M) && !(mask & RD_CSRC(riscv, mcounteren))) {

        // counter is disabled by mcounteren
        riscvIllegalInstructionMessage(riscv, "access disabled by mcounteren");

    } else if(inVMode(riscv) && !(mask & RD_CSRC(riscv, hcounteren))) {

        // counter is disabled by hcounteren
        riscvVirtualInstructionMessage(riscv, "access disabled by hcounteren");

    } else if((mode<RISCV_MODE_S) && !(mask & RD_CSRC(riscv, scounteren))) {

        // counter is disabled by scounteren
        riscvIllegalInstructionMessage(riscv, "access disabled by scounteren");

    } else {

        // access is valid
        ok = True;
    }

    return ok;
}

//
// Return a Boolean indicating if an access to the indicated Performance
// Monitor register is valid (and take an Undefined Instruction or Virtual
// Instruction trap if not)
//
Bool riscvHPMAccessValid(riscvCSRAttrsCP attrs, riscvP riscv) {
    return xcounterenSet(riscv, 1<<(attrs->csrNum&31));
}

//
// Return value created by modifying indexed half of oldValue with newValue
//
inline static Uns64 setHalf(Uns32 newValue, Uns64 oldValue, Uns32 index) {

    union {Uns64 u64; Uns32 u32[2];} u = {oldValue};

    u.u32[index] = newValue;

    return u.u64;
}

//
// Return value created by modifying lower half of oldValue with newValue
//
inline static Uns64 setLower(Uns32 newValue, Uns64 oldValue) {
    return setHalf(newValue, oldValue, 0);
}

//
// Return value created by modifying upper half of oldValue with newValue
//
inline static Uns64 setUpper(Uns32 newValue, Uns64 oldValue) {
    return setHalf(newValue, oldValue, 1);
}

//
// Return value masked to XLEN of the mode for the CSR
//
inline static Uns64 getXLENValue(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    Uns64           result
) {
    if(RISCV_XLEN_IS_32M(riscv, getCSRMode5(attrs, riscv))) {
        result = (Uns32)result;
    }

    return result;
}

//
// Return current cycle count
//
static Uns64 getCycles(riscvP riscv) {

    Uns64 result = vmirtGetICount((vmiProcessorP)riscv);

    // exclude the current instruction if this is a true access
    if(!riscv->artifactAccess) {
        result--;
    }

    return result;
}

//
// Return current instruction count
//
static Uns64 getInstructions(riscvP riscv) {

    Uns64 result = vmirtGetExecutedICount((vmiProcessorP)riscv);

    // exclude the current instruction if this is a true access
    if(!riscv->artifactAccess) {
        result--;
    }

    return result;
}

//
// Should a counter be inhibited because dcsr.stopcount=1?
//
static Bool stopCount(riscvP riscv, Bool singleOnly) {
    return (
        inDebugMode(riscv) &&
        RD_CSR_FIELDC(riscv, dcsr, stopcount) &&
        (!singleOnly || !riscv->parent)
    );
}

//
// Is cycle count inhibited?
//
Bool riscvInhibitCycle(riscvP riscv) {
    return RD_CSR_FIELDC(riscv, mcountinhibit, CY) || stopCount(riscv, True);
}

//
// Is retired instruction count inhibited?
//
Bool riscvInhibitInstret(riscvP riscv) {
    return RD_CSR_FIELDC(riscv, mcountinhibit, IR) || stopCount(riscv, False);
}

//
// Common routine to read cycle counter
//
static Uns64 cycleR(riscvP riscv) {

    Uns64 result = riscv->baseCycles;

    if(!riscvInhibitCycle(riscv)) {
        result = getCycles(riscv) - result;
    }

    return result;
}

//
// Common routine to write cycle counter (NOTE: count is notionally incremented
// *before* the write if this is the result of a CSR write)
//
static void cycleW(riscvP riscv, Uns64 newValue, Bool preIncrement) {

    if(!riscvInhibitCycle(riscv)) {
        newValue = getCycles(riscv) - newValue;
    }

    if(preIncrement && !riscv->artifactAccess) {
        newValue++;
    }

    riscv->baseCycles = newValue;
}

//
// Read mcycle or an alias of it
//
static RISCV_CSR_READFN(mcycleR) {

    Uns64 result = 0;

    if(riscvHPMAccessValid(attrs, riscv)) {
        result = getXLENValue(attrs, riscv, cycleR(riscv));
    }

    return result;
}

//
// Write mcycle
//
static RISCV_CSR_WRITEFN(mcycleW) {

    if(riscvHPMAccessValid(attrs, riscv)) {

        Bool preIncrement = !riscvInhibitCycle(riscv);

        if(RISCV_XLEN_IS_32M(riscv, getCSRMode5(attrs, riscv))) {
            cycleW(riscv, setLower(newValue, cycleR(riscv)), preIncrement);
        } else {
            cycleW(riscv, newValue, preIncrement);
        }
    }

    return newValue;
}

//
// Read mcycleh or an alias of it
//
static RISCV_CSR_READFN(mcyclehR) {

    Uns64 result = 0;

    if(riscvHPMAccessValid(attrs, riscv)) {
        result = cycleR(riscv) >> 32;
    }

    return result;
}

//
// Write mcycleh
//
static RISCV_CSR_WRITEFN(mcyclehW) {

    if(riscvHPMAccessValid(attrs, riscv)) {
        Bool preIncrement = !riscvInhibitCycle(riscv);
        cycleW(riscv, setUpper(newValue, cycleR(riscv)), preIncrement);
    }

    return newValue;
}

//
// Common routine to read time
//
static Uns64 timeRInt(riscvP riscv) {

    Uns64 result = riscvReadMTIME(riscv);

    // apply time delta in virtual mode (NOTE: use 64-bit CSR view because when
    // RV32 state, htimedeltah is mapped to top half of this)
    if(inVMode(riscv)) {
        result += RD_CSR64(riscv, htimedelta);
    }

    return result;
}


//
// Read time or an alias of it
//
static RISCV_CSR_READFN(timeR) {

    Uns64 result = 0;

    if(riscvHPMAccessValid(attrs, riscv)) {
        result = getXLENValue(attrs, riscv, timeRInt(riscv));
    }

    return result;
}

//
// Read timeh or an alias of it
//
static RISCV_CSR_READFN(timehR) {

    Uns64 result = 0;

    if(riscvHPMAccessValid(attrs, riscv)) {
        result = timeRInt(riscv) >> 32;
    }

    return result;
}

//
// Indicate that any executing instruction will not retire
//
void riscvNoRetire(riscvP riscv) {

    if(!riscv->isFetch && !riscvInhibitInstret(riscv)) {
        riscv->baseInstructions++;
    }
}

//
// Common routine to read instret counter
//
static Uns64 instretR(riscvP riscv) {

    Uns64 result = riscv->baseInstructions;

    if(!riscvInhibitInstret(riscv)) {
        result = getInstructions(riscv) - result;
    }

    return result;
}

//
// Common routine to write instret counter (NOTE: count is notionally
// incremented *before* the write if this is the result of a CSR write)
//
static void instretW(riscvP riscv, Uns64 newValue, Bool preIncrement) {

    if(!riscvInhibitInstret(riscv)) {
        newValue = getInstructions(riscv) - newValue;
    }

    if(preIncrement && !riscv->artifactAccess) {
        newValue++;
    }

    riscv->baseInstructions = newValue;
}

//
// Read minstret or an alias of it
//
static RISCV_CSR_READFN(minstretR) {

    Uns64 result = 0;

    if(riscvHPMAccessValid(attrs, riscv)) {
        result = getXLENValue(attrs, riscv, instretR(riscv));
    }

    return result;
}

//
// Write minstret
//
static RISCV_CSR_WRITEFN(minstretW) {

    if(riscvHPMAccessValid(attrs, riscv)) {

        Bool preIncrement = !riscvInhibitInstret(riscv);

        if(RISCV_XLEN_IS_32M(riscv, getCSRMode5(attrs, riscv))) {
            instretW(riscv, setLower(newValue, instretR(riscv)), preIncrement);
        } else {
            instretW(riscv, newValue, preIncrement);
        }
    }

    return newValue;
}

//
// Read minstreth or an alias of it
//
static RISCV_CSR_READFN(minstrethR) {

    Uns64 result = 0;

    if(riscvHPMAccessValid(attrs, riscv)) {
        result = instretR(riscv) >> 32;
    }

    return result;
}

//
// Write minstreth
//
static RISCV_CSR_WRITEFN(minstrethW) {

    if(riscvHPMAccessValid(attrs, riscv)) {
        Bool preIncrement = !riscvInhibitInstret(riscv);
        instretW(riscv, setUpper(newValue, instretR(riscv)), preIncrement);
    }

    return newValue;
}
//
// Write htimedelta (internal interface)
//
static void htimedeltaIntW(riscvP riscv, Uns64 newValue) {

    if(RD_CSR64(riscv, htimedelta) != newValue) {
        RD_CSR64(riscv, htimedelta) = newValue;
        riscvUpdateTimer(riscv);
    }
}

//
// Write htimedelta
//
static RISCV_CSR_WRITEFN(htimedeltaW) {

    if(RISCV_XLEN_IS_32M(riscv, getCSRMode5(attrs, riscv))) {
        htimedeltaIntW(riscv, setLower(newValue, RD_CSR64(riscv, htimedelta)));
    } else {
        htimedeltaIntW(riscv, newValue);
    }

    return newValue;
}

//
// Write htimedeltah
//
static RISCV_CSR_WRITEFN(htimedeltahW) {

    htimedeltaIntW(riscv, setUpper(newValue, RD_CSR64(riscv, htimedelta)));

    return newValue;
}

//
// Get state before possible inhibit update
//
void riscvPreInhibit(riscvP riscv, riscvCountStateP state) {

    state->inhibitCycle   = riscvInhibitCycle(riscv);
    state->inhibitInstret = riscvInhibitInstret(riscv);
    state->cycle          = cycleR(riscv);
    state->instret        = instretR(riscv);
}

//
// Update state after possible inhibit update
//
void riscvPostInhibit(riscvP riscv, riscvCountStateP state, Bool preIncrement) {

    // set cycle counter *after* mcountinhibit update
    if(state->inhibitCycle != riscvInhibitCycle(riscv)) {

        // exclude current cycle if count is being enabled
        if(preIncrement && state->inhibitCycle && !riscv->artifactAccess) {
            state->cycle--;
        }

        cycleW(riscv, state->cycle, preIncrement && !state->inhibitCycle);
    }

    // set instret counter *after* mcountinhibit update
    if(state->inhibitInstret != riscvInhibitInstret(riscv)) {

        // exclude current instruction if count is being enabled
        if(preIncrement && state->inhibitInstret && !riscv->artifactAccess) {
            state->instret--;
        }

        instretW(riscv, state->instret, preIncrement && !state->inhibitInstret);
    }
}

//
// Write mcountinhibit
//
static RISCV_CSR_WRITEFN(mcountinhibitW) {

    riscvCountState state;

    // get state before possible inhibit update
    riscvPreInhibit(riscv, &state);

    // update the CSR
    WR_CSRC(riscv, mcountinhibit, newValue & RD_CSR_MASKC(riscv, mcountinhibit));

    // refresh state after possible inhibit update
    riscvPostInhibit(riscv, &state, True);

    return newValue;
}

//
// Read unimplemented performance monitor register
//
static RISCV_CSR_READFN(mhpmR) {

    if(riscvHPMAccessValid(attrs, riscv)) {
        // no action
    }

    return 0;
}

//
// Write unimplemented performance monitor register
//
static RISCV_CSR_WRITEFN(mhpmW) {

    if(riscvHPMAccessValid(attrs, riscv)) {
        // no action
    }

    return 0;
}


////////////////////////////////////////////////////////////////////////////////
// SSTC EXTENSION
////////////////////////////////////////////////////////////////////////////////

//
// Are Sstc registers present?
//
inline static RISCV_CSR_PRESENTFN(SstcP) {
    return Sstc(riscv);
}

//
// Return a Boolean indicating if an access to stimecmp is valid (and take an
// Undefined Instruction or Virtual Instruction trap if not)
//
static Bool stimecmpAccessValid(riscvP riscv) {

    riscvMode mode = getCurrentMode3(riscv);
    Bool      ok   = False;

    if(riscv->artifactAccess) {

        // all artifact accesses are allowed
        ok = True;

    } else if((mode<RISCV_MODE_M) && !stimecmpEnabled(riscv)) {

        // counter is disabled by menvcfg.STCE
        riscvIllegalInstructionMessage(riscv, "access disabled by menvcfg.STCE");

    } else if(!xcounterenSet(riscv, WM32_counteren_TM)) {

        // no action if access denied by xcounteren.TM

    } else if(inVMode(riscv) && !vstimecmpEnabled(riscv)) {

        // counter is disabled by henvcfg.STCE
        riscvVirtualInstructionMessage(riscv, "access disabled by henvcfg.STCE");

    } else {

        // access is valid
        ok = True;
    }

    return ok;
}

//
// Read stimecmp (internal interface)
//
static Uns64 stimecmpRInt(riscvP riscv) {
    return RD_CSR64(riscv, stimecmp);
}

//
// Update stimecmp (internal interface)
//
static void stimecmpWInt(riscvP riscv, Uns64 newValue) {

    // update raw value
    WR_CSR64(riscv, stimecmp, newValue);

    // schedule timer interrupt
    riscvUpdateTimer(riscv);
}

//
// Read stimecmp
//
static RISCV_CSR_READFN(stimecmpR) {

    Uns64 result = 0;

    if(stimecmpAccessValid(riscv)) {
        result = stimecmpRInt(riscv);
    }

    return result;
}

//
// Write stimecmp
//
static RISCV_CSR_WRITEFN(stimecmpW) {

    if(!stimecmpAccessValid(riscv)) {
        // no action
    } else if(RISCV_XLEN_IS_32M(riscv, getCSRMode5(attrs, riscv))) {
        stimecmpWInt(riscv, setLower(newValue, stimecmpRInt(riscv)));
    } else {
        stimecmpWInt(riscv, newValue);
    }

    return newValue;
}

//
// Read stimecmph
//
static RISCV_CSR_READFN(stimecmphR) {

    Uns64 result = 0;

    if(stimecmpAccessValid(riscv)) {
        result = stimecmpRInt(riscv) >> 32;
    }

    return result;
}

//
// Write stimecmph
//
static RISCV_CSR_WRITEFN(stimecmphW) {

    if(stimecmpAccessValid(riscv)) {
        stimecmpWInt(riscv, setUpper(newValue, stimecmpRInt(riscv)));
    }

    return newValue;
}

//
// Read vstimecmp (internal interface)
//
static Uns64 vstimecmpRInt(riscvP riscv) {
    return RD_CSR64(riscv, vstimecmp);
}

//
// Update vstimecmp (internal interface)
//
static void vstimecmpWInt(riscvP riscv, Uns64 newValue) {

    // update raw value
    WR_CSR64(riscv, vstimecmp, newValue);

    // schedule timer interrupt
    riscvUpdateTimer(riscv);
}

//
// Read vstimecmp
//
static RISCV_CSR_READFN(vstimecmpR) {

    Uns64 result = 0;

    if(stimecmpAccessValid(riscv)) {
        result = vstimecmpRInt(riscv);
    }

    return result;
}

//
// Write vstimecmp
//
static RISCV_CSR_WRITEFN(vstimecmpW) {

    if(!stimecmpAccessValid(riscv)) {
        // no action
    } else if(RISCV_XLEN_IS_32M(riscv, getCSRMode5(attrs, riscv))) {
        vstimecmpWInt(riscv, setLower(newValue, vstimecmpRInt(riscv)));
    } else {
        vstimecmpWInt(riscv, newValue);
    }

    return newValue;
}

//
// Read vstimecmph
//
static RISCV_CSR_READFN(vstimecmphR) {

    Uns64 result = 0;

    if(stimecmpAccessValid(riscv)) {
        result = vstimecmpRInt(riscv) >> 32;
    }

    return result;
}

//
// Write vstimecmph
//
static RISCV_CSR_WRITEFN(vstimecmphW) {

    if(stimecmpAccessValid(riscv)) {
        vstimecmpWInt(riscv, setUpper(newValue, vstimecmpRInt(riscv)));
    }

    return newValue;
}


////////////////////////////////////////////////////////////////////////////////
// VIRTUAL MEMORY MANAGEMENT REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Is the given Sv_mode index valid?
//
static Bool validSVMode(riscvP riscv, Uns32 Sv_mode, Uns32 XL) {

    Uns32 mask = (XL==2) ? (RISCV_VMM_64|RISCV_VMM_SV64) : RISCV_VMM_32;

    return (1<<Sv_mode) & riscv->configInfo.Sv_modes & mask;
}

//
// Write satp or vsatp
//
static Uns64 atpW(
    riscvCSRAttrsCP    attrs,
    riscvP             riscv,
    Uns64              newValue,
    CSR_REG_TYPE(atp) *atpP,
    riscvMode          mode,
    Bool               isWARL
) {
    Uns64 old = RD_RAW_MODE(riscv, mode, *atpP);

    // write value
    WR_RAW_MODE(riscv, mode, *atpP, newValue);

    // mask ASID value to implemented width
    Uns32 ASIDmask = getASIDMask(riscv);
    Uns32 ASID     = RD_RAW_FIELD_MODE(riscv, mode, *atpP, ASID) & ASIDmask;
    WR_RAW_FIELD_MODE(riscv, mode, *atpP, ASID, ASID);

    // mask PPN value to implemented width
    Uns64 PPNMask = getAddressMask(riscv->extBits) >> RISCV_PAGE_SHIFT;
    Uns64 PPN     = RD_RAW_FIELD_MODE(riscv, mode, *atpP, PPN) & PPNMask;
    WR_RAW_FIELD_MODE(riscv, mode, *atpP, PPN, PPN);

    // get requested mode
    Uns32 targetMode = RD_RAW_FIELD_MODE(riscv, mode, *atpP, MODE);

    if(validSVMode(riscv, targetMode, RD_CSR_FIELD64(riscv, mstatus, SXL))) {

        // valid mode specified

    } else if(isWARL) {

        // use bare mode if invalid mode was specified (in which case all other
        // fields read as zero)
        if(riscv->verbose) {
            vmiMessage("W", CPU_PREFIX"_ISBM",
                SRCREF_FMT
                "%s invalid mode %u specified - use bare mode",
                SRCREF_ARGS(riscv, getPC(riscv)),
                attrs->name, targetMode
            );
        }

        // select bare mode
        WR_RAW_MODE(riscv, mode, *atpP, 0);

    } else {

        // discard write if invalid mode was specified
        if(riscv->verbose) {
            vmiMessage("W", CPU_PREFIX"_ISPV",
                SRCREF_FMT
                "%s write with 0x"FMT_Ax" ignored (invalid mode %u)",
                SRCREF_ARGS(riscv, getPC(riscv)),
                attrs->name, newValue, targetMode
            );
        }

        // revert value
        WR_RAW_MODE(riscv, mode, *atpP, old);
    }

    if(old!=RD_RAW_MODE(riscv, mode, *atpP)) {

        // change in *satp.MODE enables/disables VM
        riscvSetMode(riscv, getCurrentMode5(riscv));

        // change in *satp.ASID affects effective ASID
        riscvVMSetASID(riscv);
    }

    return RD_RAW_MODE(riscv, mode, *atpP);
}

//
// Write satp
//
static RISCV_CSR_WRITEFN(satpW) {

    // do actions on base update
    riscvVMUpdateTableBase(riscv, RISCV_TLB_HS);

    return atpW(attrs, riscv, newValue, &riscv->csr.satp, RISCV_MODE_S, False);
}

//
// Write vsatp
//
static RISCV_CSR_WRITEFN(vsatpW) {

    Bool isWARL = !inVMode(riscv);

    // do actions on base update
    riscvVMUpdateTableBase(riscv, RISCV_TLB_VS1);

    return atpW(attrs, riscv, newValue, &riscv->csr.vsatp, RISCV_MODE_VS, isWARL);
}

//
// Write hgatp
//
static RISCV_CSR_WRITEFN(hgatpW) {

    Uns64 old = RD_CSR_S(riscv, hgatp);

    // write value
    WR_CSR_S(riscv, hgatp, newValue);
    WR_CSR_FIELD_S(riscv, hgatp, _u1, 0);

    // mask VMID value to implemented width
    Uns32 VMIDmask = getVMIDMask(riscv);
    Uns32 VMID     = RD_CSR_FIELD_S(riscv, hgatp, VMID) & VMIDmask;
    WR_CSR_FIELD_S(riscv, hgatp, VMID, VMID);

    // mask PPN value to implemented width, aligning further to 16Kb boundary
    Uns64 PPNMask = (getAddressMask(riscv->extBits) >> RISCV_PAGE_SHIFT) & -4;
    Uns64 PPN     = RD_CSR_FIELD_S(riscv, hgatp, PPN) & PPNMask;
    WR_CSR_FIELD_S(riscv, hgatp, PPN, PPN);

    // get requested mode
    Uns32 targetMode = RD_CSR_FIELD_S(riscv, hgatp, MODE);

    if(validSVMode(riscv, targetMode, RD_CSR_FIELDC(riscv, hstatus, VSXL))) {

        // valid mode specified

    } else {

        // use bare mode if invalid mode was specified (in which case all other
        // fields read as zero)
        if(riscv->verbose) {
            vmiMessage("W", CPU_PREFIX"_ISBM",
                SRCREF_FMT
                "%s invalid mode %u specified - use bare mode",
                SRCREF_ARGS(riscv, getPC(riscv)),
                attrs->name, targetMode
            );
        }

        // select bare mode
        WR_CSR_S(riscv, hgatp, 0);
    }

    if(old!=RD_CSR_S(riscv, hgatp)) {

        // change in hgatp.MODE enables/disables VM
        riscvSetMode(riscv, getCurrentMode5(riscv));

        // change in hgatp.VMID affects effective VMID
        riscvVMSetASID(riscv);
    }

    // do actions on base update
    riscvVMUpdateTableBase(riscv, RISCV_TLB_VS1);
    riscvVMUpdateTableBase(riscv, RISCV_TLB_VS2);

    return RD_CSR_S(riscv, hgatp);
}


////////////////////////////////////////////////////////////////////////////////
// PHYSICAL MEMORY MANAGEMENT REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Return the maximum number of PMP registers
//
static Uns32 getMaxPMPRegs(riscvP riscv) {

    Uns32 result;

    if(riscv->configInfo.PMP_undefined) {
        result = riscv->configInfo.PMP_registers;
    } else {
        result = (riscv->configInfo.priv_version>=RVPV_1_12) ? 64 : 16;
    }

    return result;
}

//
// Return index number of pmpcfg register
//
inline static Uns32 pmpcfgIndex(riscvCSRAttrsCP attrs) {
    return getCSRId(attrs)-CSR_ID(pmpcfg0);
}

//
// Return index number of pmpaddr register
//
inline static Uns32 pmpaddrIndex(riscvCSRAttrsCP attrs) {
    return getCSRId(attrs)-CSR_ID(pmpaddr0);
}

//
// Is pmpcfg register present?
//
inline static RISCV_CSR_PRESENTFN(pmpcfgP) {
    return pmpcfgIndex(attrs) < (getMaxPMPRegs(riscv)/4);
}

//
// Is pmpaddr register present?
//
inline static RISCV_CSR_PRESENTFN(pmpaddrP) {
    return pmpaddrIndex(attrs) < getMaxPMPRegs(riscv);
}

//
// Read pmpcfg0-pmpcfg15
//
static RISCV_CSR_READFN(pmpcfgR) {
    return riscvVMReadPMPCFG(riscv, pmpcfgIndex(attrs));
}

//
// Write pmpcfg0-pmpcfg15
//
static RISCV_CSR_WRITEFN(pmpcfgW) {
    return riscvVMWritePMPCFG(riscv, pmpcfgIndex(attrs), newValue);
}

//
// Read pmpaddr0-pmpaddr63
//
static RISCV_CSR_READFN(pmpaddrR) {
    return riscvVMReadPMPAddr(riscv, pmpaddrIndex(attrs));
}

//
// Write pmpaddr0-pmpaddr63
//
static RISCV_CSR_WRITEFN(pmpaddrW) {
    return riscvVMWritePMPAddr(riscv, pmpaddrIndex(attrs), newValue);
}


////////////////////////////////////////////////////////////////////////////////
// MEMORY PROTECTION UNIT REGISTERS
////////////////////////////////////////////////////////////////////////////////

#if(ENABLE_SSMPU)

//
// Return the maximum number of MPU registers
//
static Uns32 getMaxMPURegs(riscvP riscv) {
    return riscv->configInfo.MPU_registers;
}

//
// Return index number of mpucfg register
//
inline static Uns32 mpucfgIndex(riscvCSRAttrsCP attrs) {
    return getCSRId(attrs)-CSR_ID(mpucfg0);
}

//
// Return index number of mpuaddr register
//
inline static Uns32 mpuaddrIndex(riscvCSRAttrsCP attrs) {
    return getCSRId(attrs)-CSR_ID(mpuaddr0);
}

//
// Is mpucfg register present?
//
inline static RISCV_CSR_PRESENTFN(mpucfgP) {
    return mpucfgIndex(attrs) < (getMaxMPURegs(riscv)/4);
}

//
// Is mpuaddr register present?
//
inline static RISCV_CSR_PRESENTFN(mpuaddrP) {
    return mpuaddrIndex(attrs) < getMaxMPURegs(riscv);
}

//
// Read mpucfg0-mpucfg15
//
static RISCV_CSR_READFN(mpucfgR) {
    return riscvVMReadMPUCFG(riscv, mpucfgIndex(attrs));
}

//
// Write mpucfg0-mpucfg15
//
static RISCV_CSR_WRITEFN(mpucfgW) {
    return riscvVMWriteMPUCFG(riscv, mpucfgIndex(attrs), newValue);
}

//
// Read mpuaddr0-mpuaddr63
//
static RISCV_CSR_READFN(mpuaddrR) {
    return riscvVMReadMPUAddr(riscv, mpuaddrIndex(attrs));
}

//
// Write mpuaddr0-mpuaddr63
//
static RISCV_CSR_WRITEFN(mpuaddrW) {
    return riscvVMWriteMPUAddr(riscv, mpuaddrIndex(attrs), newValue);
}

#endif


////////////////////////////////////////////////////////////////////////////////
// VECTOR EXTENSION REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Is vlenb register present?
//
inline static RISCV_CSR_PRESENTFN(vlenbP) {
    return riscvVFSupport(riscv, RVVF_VLENB_PRESENT);
}

//
// Is vxsat register present?
//
inline static RISCV_CSR_PRESENTFN(vxsatP) {
    return (
        vectorPresent(riscv) ||
        (DSPPresent(riscv) && (RISCV_DSP_VERSION(riscv)>RVDSPV_0_5_2))
    );
}

//
// Is cvsr register present?
//
inline static RISCV_CSR_PRESENTFN(vcsrP) {
    return riscvVFSupport(riscv, RVVF_VCSR_PRESENT);
}

//
// Return maximum vector length for the current vector type settings
//
inline static Uns32 getMaxVL(riscvP riscv) {
    return riscvGetMaxVL(riscv, getCurrentVType(riscv));
}

//
// Return current vtype.vta
//
inline static Bool getVTA(riscvP riscv) {
    return getVTypeVTA(getCurrentVType(riscv));
}

//
// Return current vtype.vma
//
inline static Bool getVMA(riscvP riscv) {
    return getVTypeVMA(getCurrentVType(riscv));
}

//
// Write vxrm register
//
static RISCV_CSR_WRITEFN(vxrmW) {

    // update alias in fcsr if required
    if(vxFieldsInFCSR(riscv)) {
        WR_CSR_FIELDC(riscv, fcsr, vxrm, newValue);
    }

    // update alias in vcsr
    WR_CSR_FIELDC(riscv, vcsr, vxrm, newValue);

    // update fixed point rounding mode alias
    WR_CSR_FIELDC(riscv, vxrm, rm, newValue);

    return newValue;
}

//
// Read vxsat
//
static RISCV_CSR_READFN(vxsatR) {

    // construct effective flags from CSR and JIT flags
    return getSatFlags(riscv);
}

//
// Write vxsat
//
static RISCV_CSR_WRITEFN(vxsatW) {

    Uns8 vxsat = newValue & WM32_vxsat;

    // assign CSR flags and clear JIT flags
    setSatFlags(riscv, vxsat);

    // return written value
    return vxsat;
}

//
// Read vcsr
//
static RISCV_CSR_READFN(vcsrR) {

    // initially clear register
    WR_CSRC(riscv, vcsr, 0);

    // get fixed point saturation alias
    WR_CSR_FIELDC(riscv, vcsr, vxsat, getSatFlags(riscv));

    // get fixed point rounding mode alias
    WR_CSR_FIELDC(riscv, vcsr, vxrm, RD_CSR_FIELDC(riscv, vxrm, rm));

    // return composed value
    return RD_CSRC(riscv, vcsr);
}

//
// Write vcsr
//
static RISCV_CSR_WRITEFN(vcsrW) {

    // update the CSR
    WR_CSRC(riscv, vcsr, newValue & WM32_vcsr);

    // assign CSR flags and clear JIT flags (fixed point)
    setSatFlags(riscv, RD_CSR_FIELDC(riscv, vcsr, vxsat));

    // update fixed point rounding mode alias
    WR_CSR_FIELDC(riscv, vxrm, rm, RD_CSR_FIELDC(riscv, vcsr, vxrm));

    // return written value
    return RD_CSRC(riscv, vcsr);
}

//
// Refresh the vector polymorphic block key
//
void riscvRefreshVectorPMKey(riscvP riscv) {

    Uns32 vl       = RD_CSRC(riscv, vl);
    Uns32 vtypeKey = RD_CSRC(riscv, vtype)<<2;
    Uns32 villKey  = RD_CSR_FIELD_U(riscv, vtype, vill)<<2;
    Uns32 pmKey;

    if(villKey) {

        // handle illegal setting
        pmKey = VLCLASSMT_UNKNOWN | villKey;

    } else {

        // handle legal settings
        if(!vl) {
            pmKey = VLCLASSMT_ZERO;
        } else if(vl==getMaxVL(riscv)) {
            pmKey = VLCLASSMT_MAX;
        } else {
            pmKey = VLCLASSMT_NONZERO;
        }

        // handle agnostic elements
        if(riscv->configInfo.agnostic_ones) {

            // handle tail agnostic setting
            if(getVTA(riscv)) {
                pmKey |= PMK_VECTOR_VTA1;
            }

            // handle mask agnostic setting
            if(getVMA(riscv)) {
                pmKey |= PMK_VECTOR_VMA1;
            }
        }

        // include vtypeKey
        pmKey |= vtypeKey;
    }

    // update polymorphic key
    riscv->pmKey = (riscv->pmKey & ~PMK_VECTOR) | pmKey;
}

//
// Update vtype CSR
//
void riscvSetVType(riscvP riscv, Bool vill, riscvVType vtype) {

    WR_CSRC(riscv, vtype, vtype.u.u32);
    WR_CSR_FIELD_U(riscv, vtype, vill, vill);
}

//
// Refresh effective VL used when when EEW=1
//
inline static void refreshVLEEW1(riscvP riscv) {
    riscv->vlEEW1 = BITS_TO_BYTES(RD_CSRC(riscv, vl));
}

//
// Update VL and aliases of it for the given vtype
//
static Bool setVL(riscvP riscv, Uns64 vl, riscvVType vtype) {

    Uns32 maxVL = riscvGetMaxVL(riscv, vtype);
    Bool  ok    = True;

    if(vl<=maxVL) {

        // no action

    } else if(!(riscv->vPreserve && riscvVFSupport(riscv, RVVF_SETVLZ_ILLEGAL))) {

        // clamp vl to maximum supported number of elements
        vl = maxVL;

    } else {

        ok = False;

        // take Illegal Instruction exception
        riscvIllegalInstructionMessage(riscv, "Illegal attempt to preserve vl");
    }

    // update vl CSR
    if(ok) {
        WR_CSRC(riscv, vl, vl);
        refreshVLEEW1(riscv);
    }

    return ok;
}

//
// Update VL and aliases of it for the given vtype
//
Bool riscvSetVLForVType(riscvP riscv, Uns64 vl, riscvVType vtype) {
    return setVL(riscv, vl, vtype);
}

//
// Update vl CSR and aliases of it for the current vtype
//
void riscvSetVL(riscvP riscv, Uns64 vl) {
    setVL(riscv, vl, getCurrentVType(riscv));
}

//
// Reset vector state
//
static void resetVLVType(riscvP riscv) {

    if(vectorPresent(riscv)) {

        // reset vtype CSR
        riscvVType vtype = {0};
        riscvSetVType(riscv, !riscvValidVType(riscv, vtype), vtype);

        // reset VL CSR
        riscvSetVL(riscv, 0);

        // set vector polymorphic key
        riscvRefreshVectorPMKey(riscv);
    }
}


////////////////////////////////////////////////////////////////////////////////
// TRIGGER REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Return modes masked to those implemented on the processor
//
static Uns32 composeModes(riscvP riscv, Uns32 modes, Bool vu, Bool vs) {

    riscvArchitecture arch = riscv->configInfo.arch;
    Uns32             mask = 0;

    if(arch&ISA_M) {mask |= 1<<RISCV_MODE_M;}
    if(arch&ISA_S) {mask |= 1<<RISCV_MODE_S;}
    if(arch&ISA_U) {mask |= 1<<RISCV_MODE_U;}

    modes &= mask;

    if(arch&ISA_H) {
        if(vu) {modes |= 1<<RISCV_MODE_VU;}
        if(vs) {modes |= 1<<RISCV_MODE_VS;}
    }

    return modes;
}

//
// Return currently-enabled trigger structure
//
inline static riscvTriggerP getIndexedTrigger(riscvP riscv, Int32 i) {
    return (i>=0) ? &riscv->triggers[i] : 0;
}

//
// Return currently-enabled trigger structure
//
inline static riscvTriggerP getCurrentTrigger(riscvP riscv) {
    return getIndexedTrigger(riscv, RD_CSRC(riscv, tselect));
}

//
// Return preceding trigger structure
//
inline static riscvTriggerP getPreviousTrigger(riscvP riscv) {
    return getIndexedTrigger(riscv, RD_CSRC(riscv, tselect)-1);
}

//
// Is access to the given trigger allowed in the current mode?
//
static Bool mayWriteTrigger(riscvP riscv, riscvTriggerP trigger) {

    Bool ok = (
        // access always allowed by an artifact write
        riscv->artifactAccess ||
        // access always allowed in debug mode
        inDebugMode(riscv) ||
        // access allowed only if dmode is 0
        !trigger->tdata1UP.dmode
    );

    // report illegal accesses if required
    if(!ok && riscv->verbose) {
        vmiMessage("W", CPU_PREFIX"_ITRA",
            SRCREF_FMT
            "Illegal trigger register access (dmode=0 for current trigger)",
            SRCREF_ARGS(riscv, getPC(riscv))
        );
    }

    return ok;
}

//
// Is assignment of tdata1.dmode allowed?
//
static Bool mayWriteDMode(riscvP riscv, Bool dmode) {

    Bool ok = (
        // access always allowed by an artifact write
        riscv->artifactAccess ||
        // not attempting to set tdata1.dmode
        !dmode ||
        // access always allowed in debug mode
        inDebugMode(riscv)
    );

    // report illegal accesses if required
    if(!ok && riscv->verbose) {
        vmiMessage("W", CPU_PREFIX"_IDMU",
            SRCREF_FMT
            "Illegal attempt to update tdata1.dmode in Machine mode",
            SRCREF_ARGS(riscv, getPC(riscv))
        );
    }

    return ok;
}

//
// Is this write legal in a chain?
//
static Bool mayWriteChain(riscvP riscv, Bool dmode, riscvTriggerP prev) {

    Bool ok = (
        // access always allowed by an artifact write
        riscv->artifactAccess ||
        // not attempting to set tdata1.dmode
        !dmode ||
        // no previous trigger
        !prev ||
        // previous trigger has dmode of 1
        prev->tdata1UP.dmode ||
        // previous trigger is not chained to this
        !prev->tdata1UP.chain
    );

    // report illegal accesses if required
    if(!ok && riscv->verbose) {
        vmiMessage("W", CPU_PREFIX"_IDM1",
            SRCREF_FMT
            "Illegal attempt to update tdata1.dmode=1 when previous trigger "
            "has dmode=0 and chain=1",
            SRCREF_ARGS(riscv, getPC(riscv))
        );
    }

    return ok;
}

//
// Is trigger type encoded in the given value supported?
//
static Bool validateTriggerType(
    riscvP        riscv,
    riscvTriggerP trigger,
    Uns64         value
) {
    // assign raw value to structure
    CSR_REG_DECL(tdata1) = {value};

    // get selected trigger type
    triggerType type = RD_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, type);
    Bool        ok   = RD_REG_TRIGGER(trigger, tinfo) & (1<<type);

    // report illegal trigger type if required
    if(!ok && riscv->verbose) {
        vmiMessage("W", CPU_PREFIX"_ITT",
            SRCREF_FMT
            "Illegal attempt to use unsupported trigger type %u",
            SRCREF_ARGS(riscv, getPC(riscv)),
            type
        );
    }

    return ok;
}

//
// Is trigger address match of the given value supported?
//
static Uns32 validateMatch(
    riscvP        riscv,
    riscvTriggerP trigger,
    Uns32         match
) {
    if(!(riscv->configInfo.trigger_match & (1<<match))) {

        // report illegal trigger type if required
        if(riscv->verbose) {
            vmiMessage("W", CPU_PREFIX"_IMT",
                SRCREF_FMT
                "Illegal attempt to use unsupported address match type %u",
                SRCREF_ARGS(riscv, getPC(riscv)),
                match
            );
        }

        // revert to legal match type
        match = trigger->tdata1UP.match;
    }

    return match;
}

//
// Unpack tdata1 value into common format
//
static riscvTData1UP unpackTData1(
    riscvP        riscv,
    riscvTriggerP trigger,
    Uns64         newValue
) {
    CSR_REG_DECL(tdata1) = {newValue};

    // some behavior is tinfo-version-dependent
    Uns32 tinfo_version = RD_REG_FIELD_TRIGGER(trigger, tinfo, version);

    // information required to compose mode
    Uns32 modes = 0;
    Bool  vu    = False;
    Bool  vs    = False;
    Uns32 match;

    // initialize common fields
    riscvTData1UP tdata1UP = {
        type  : RD_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, type),
        dmode : RD_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, dmode)
    };

    // validate illegal attempt to update dmode
    if(!mayWriteDMode(riscv, tdata1UP.dmode)) {
        tdata1UP.dmode = 0;
    }

    // unpack type-specific fields
    switch(tdata1UP.type) {

        case TT_NONE:

            // all fields are zero if type is TT_NONE
            tdata1UP.dmode = 0;

            break;

        case TT_ADMATCH:

            // extract mode and fields
            modes = RD_RAW_FIELDC(tdata1, mcontrol.modes);
            match = RD_RAW_FIELDC(tdata1, mcontrol.match);

            // compose other fields
            tdata1UP.match  = validateMatch(riscv, trigger, match);
            tdata1UP.action = RD_RAW_FIELDC(tdata1, mcontrol.action);
            tdata1UP.size   = RD_RAW_FIELDC(tdata1, mcontrol.sizelo);
            tdata1UP.priv   = RD_RAW_FIELDC(tdata1, mcontrol.priv);
            tdata1UP.chain  = RD_RAW_FIELDC(tdata1, mcontrol.chain);
            tdata1UP.timing = RD_RAW_FIELDC(tdata1, mcontrol.timing);
            tdata1UP.select = RD_RAW_FIELDC(tdata1, mcontrol.select);
            tdata1UP.hit0   = RD_RAW_FIELDC(tdata1, mcontrol.hit);

            // include 64-bit size component
            if(!TRIGGER_IS_32M(riscv)) {
                tdata1UP.size += RD_RAW_FIELD64(tdata1, mcontrol.sizehi)*4;
            }

            break;

        case TT_ICOUNT:

            // extract mode fields
            modes = RD_RAW_FIELDC(tdata1, icount.modes);
            vu    = RD_RAW_FIELDC(tdata1, icount.vu);
            vs    = RD_RAW_FIELDC(tdata1, icount.vs);

            // compose other fields
            tdata1UP.action = RD_RAW_FIELDC(tdata1, icount.action);
            tdata1UP.timing = 1;
            tdata1UP.hit0   = RD_RAW_FIELDC(tdata1, icount.hit);

            // from version 0.14.0, pending field indicates whether ICOUNT
            // breakpoint has fired
            if(RISCV_DBG_VERSION(riscv)>=RVDBG_0_14_0) {
                tdata1UP.pending = (modes&(1<<RISCV_MODE_H)) && True;
            }

            // assign read-only count field (single-step only)
            tdata1UP.count  = 1;

            break;

        case TT_INTERRUPT:

            // extract mode fields
            modes = RD_RAW_FIELDC(tdata1, itrigger.modes);
            vu    = RD_RAW_FIELDC(tdata1, itrigger.vu);
            vs    = RD_RAW_FIELDC(tdata1, itrigger.vs);

            // compose other fields
            tdata1UP.action = RD_RAW_FIELDC(tdata1, itrigger.action);
            tdata1UP.timing = 1;

            // nmi field moves to itrigger in later 1.0-STABLE specification
            if(RISCV_DBG_VERSION(riscv)>=RVDBG_1_0) {
                tdata1UP.nmi = RD_RAW_FIELDC(tdata1, itrigger.nmi);
            }

            // hit field is at XLEN-specific location
            tdata1UP.hit0 = RD_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, itrigger.hit);

            break;

        case TT_EXCEPTION:

            // extract mode fields
            modes = RD_RAW_FIELDC(tdata1, etrigger.modes);
            vu    = RD_RAW_FIELDC(tdata1, etrigger.vu);
            vs    = RD_RAW_FIELDC(tdata1, etrigger.vs);

            // compose other fields
            tdata1UP.action = RD_RAW_FIELDC(tdata1, etrigger.action);
            tdata1UP.timing = 1;

            // nmi field moves to itrigger in later 1.0-STABLE specification
            if(RISCV_DBG_VERSION(riscv)<RVDBG_1_0) {
                tdata1UP.nmi = RD_RAW_FIELDC(tdata1, etrigger.nmi);
            }

            // hit field is at XLEN-specific location
            tdata1UP.hit0 = RD_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, etrigger.hit);

            break;

        case TT_MCONTROL6:

            // extract mode and match fields
            modes = RD_RAW_FIELDC(tdata1, mcontrol6.modes);
            vu    = RD_RAW_FIELDC(tdata1, mcontrol6.vu);
            vs    = RD_RAW_FIELDC(tdata1, mcontrol6.vs);
            match = RD_RAW_FIELDC(tdata1, mcontrol6.match);

            // compose other fields
            tdata1UP.match  = validateMatch(riscv, trigger, match);
            tdata1UP.action = RD_RAW_FIELDC(tdata1, mcontrol6.action);
            tdata1UP.size   = RD_RAW_FIELDC(tdata1, mcontrol6.size);
            tdata1UP.priv   = RD_RAW_FIELDC(tdata1, mcontrol6.priv);
            tdata1UP.chain  = RD_RAW_FIELDC(tdata1, mcontrol6.chain);
            tdata1UP.select = RD_RAW_FIELDC(tdata1, mcontrol6.select);
            tdata1UP.hit0   = RD_RAW_FIELDC(tdata1, mcontrol6.hit0);

            if(tinfo_version) {

                // from tinfo version 1, hit1, uncertain and uncertainen fields
                // are present and size is restricted
                tdata1UP.hit1        = RD_RAW_FIELDC(tdata1, mcontrol6.hit1);
                tdata1UP.uncertain   = RD_RAW_FIELDC(tdata1, mcontrol6.uncertain);
                tdata1UP.uncertainen = (modes&(1<<RISCV_MODE_H)) && True;
                tdata1UP.size       &= 7;

            } else {

                // before tinfo version 1, timing field is present
                tdata1UP.timing = RD_RAW_FIELDC(tdata1, mcontrol6.timing);
            }

            break;

        default:

            // no action for other trigger types (e.g. TT_UNAVAILABLE)
            break;
    }

    // mask effective modes
    tdata1UP.modes = composeModes(riscv, modes, vu, vs);

    // mask out hit fields if required
    if(riscv->configInfo.no_hit) {
        tdata1UP.hit0 = 0;
        tdata1UP.hit1 = 0;
    }

    // dmode=0 requires action=0, and action must not exceed 1
    if(!tdata1UP.dmode || ((tdata1UP.action)>1)) {
        tdata1UP.action = 0;
    }

    return tdata1UP;
}

//
// Pack tdata1 value from common format
//
static Uns64 packTData1(
    riscvP        riscv,
    riscvTriggerP trigger,
    riscvTData1UP tdata1UP
) {
    CSR_REG_DECL(tdata1) = {0};

    // some behavior is tinfo-version-dependent
    Uns32 tinfo_version = RD_REG_FIELD_TRIGGER(trigger, tinfo, version);

    // extract vu and vs from mode mask
    Uns32 modes = tdata1UP.modes;
    Bool  vu    = modes & (1<<RISCV_MODE_VU);
    Bool  vs    = modes & (1<<RISCV_MODE_VS);

    // pack common fields
    WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, type,  tdata1UP.type);
    WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, dmode, tdata1UP.dmode);

    // pack type-specific fields
    switch(tdata1UP.type) {

        case TT_ADMATCH:

            WR_RAW_FIELDC(tdata1, mcontrol.modes,  modes);
            WR_RAW_FIELDC(tdata1, mcontrol.match,  tdata1UP.match);
            WR_RAW_FIELDC(tdata1, mcontrol.action, tdata1UP.action);
            WR_RAW_FIELDC(tdata1, mcontrol.sizelo, tdata1UP.size);
            WR_RAW_FIELDC(tdata1, mcontrol.priv,   tdata1UP.priv);
            WR_RAW_FIELDC(tdata1, mcontrol.chain,  tdata1UP.chain);
            WR_RAW_FIELDC(tdata1, mcontrol.timing, tdata1UP.timing);
            WR_RAW_FIELDC(tdata1, mcontrol.select, tdata1UP.select);
            WR_RAW_FIELDC(tdata1, mcontrol.hit,    tdata1UP.hit0);

            // include 64-bit size component
            if(!TRIGGER_IS_32M(riscv)) {
                WR_RAW_FIELD64(tdata1, mcontrol.sizehi, tdata1UP.size/4);
            }

            // include constant maskmax
            Uns32 maskmax = riscv->configInfo.mcontrol_maskmax;
            WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, mcontrol.maskmax, maskmax);

            break;

        case TT_ICOUNT:

            // from version 0.14.0, pending field indicates whether ICOUNT
            // breakpoint has fired
            if((RISCV_DBG_VERSION(riscv)>=RVDBG_0_14_0) && tdata1UP.pending) {
                modes |= (1<<RISCV_MODE_H);
            }

            WR_RAW_FIELDC(tdata1, icount.modes,  modes);
            WR_RAW_FIELDC(tdata1, icount.action, tdata1UP.action);
            WR_RAW_FIELDC(tdata1, icount.hit,    tdata1UP.hit0);
            WR_RAW_FIELDC(tdata1, icount.vu,     vu);
            WR_RAW_FIELDC(tdata1, icount.vs,     vs);
            WR_RAW_FIELDC(tdata1, icount.count,  tdata1UP.count);

            break;

        case TT_INTERRUPT:

            WR_RAW_FIELDC(tdata1, itrigger.modes,  modes);
            WR_RAW_FIELDC(tdata1, itrigger.action, tdata1UP.action);
            WR_RAW_FIELDC(tdata1, itrigger.vu,     vu);
            WR_RAW_FIELDC(tdata1, itrigger.vs,     vs);

            // nmi field moves to itrigger in later 1.0-STABLE specification
            if(RISCV_DBG_VERSION(riscv)>=RVDBG_1_0) {
                WR_RAW_FIELDC(tdata1, itrigger.nmi, tdata1UP.nmi);
            }

            // hit field is at XLEN-specific location
            WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, itrigger.hit, tdata1UP.hit0);

            break;

        case TT_EXCEPTION:

            WR_RAW_FIELDC(tdata1, etrigger.modes,  modes);
            WR_RAW_FIELDC(tdata1, etrigger.action, tdata1UP.action);
            WR_RAW_FIELDC(tdata1, etrigger.vu,     vu);
            WR_RAW_FIELDC(tdata1, etrigger.vs,     vs);

            // nmi field moves to itrigger in later 1.0-STABLE specification
            if(RISCV_DBG_VERSION(riscv)<RVDBG_1_0) {
                WR_RAW_FIELDC(tdata1, etrigger.nmi, tdata1UP.nmi);
            }

            // hit field is at XLEN-specific location
            WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, etrigger.hit, tdata1UP.hit0);

            break;

        case TT_MCONTROL6:

            // from tinfo version 1, uncertainen field is also present
            if(tinfo_version && tdata1UP.uncertainen) {
                modes |= (1<<RISCV_MODE_H);
            }

            // from tinfo version 1, timing field is absent
            if(!tinfo_version) {
                WR_RAW_FIELDC(tdata1, mcontrol6.timing, tdata1UP.timing);
            }

            WR_RAW_FIELDC(tdata1, mcontrol6.modes,     modes);
            WR_RAW_FIELDC(tdata1, mcontrol6.match,     tdata1UP.match);
            WR_RAW_FIELDC(tdata1, mcontrol6.action,    tdata1UP.action);
            WR_RAW_FIELDC(tdata1, mcontrol6.size,      tdata1UP.size);
            WR_RAW_FIELDC(tdata1, mcontrol6.priv,      tdata1UP.priv);
            WR_RAW_FIELDC(tdata1, mcontrol6.chain,     tdata1UP.chain);
            WR_RAW_FIELDC(tdata1, mcontrol6.select,    tdata1UP.select);
            WR_RAW_FIELDC(tdata1, mcontrol6.hit0,      tdata1UP.hit0);
            WR_RAW_FIELDC(tdata1, mcontrol6.hit1,      tdata1UP.hit1);
            WR_RAW_FIELDC(tdata1, mcontrol6.uncertain, tdata1UP.uncertain);
            WR_RAW_FIELDC(tdata1, mcontrol6.vu,        vu);
            WR_RAW_FIELDC(tdata1, mcontrol6.vs,        vs);

            break;

        default:

            // no action for other trigger types (e.g. TT_NONE, TT_UNAVAILABLE)
            break;
    }

    return RD_RAW64(tdata1);
}

//
// Unpack tdata3 value into common format
//
static riscvTData3UP unpackTData3(riscvP riscv, Uns64 newValue) {

    CSR_REG_DECL(tdata3) = {newValue};

    // initialize fields
    riscvTData3UP tdata3UP = {
        sselect   : RD_RAW_FIELD_TRIGGER_MODE(riscv, tdata3, sselect),
        svalue    : RD_RAW_FIELD_TRIGGER_MODE(riscv, tdata3, svalue),
        mhselect  : RD_RAW_FIELD_TRIGGER_MODE(riscv, tdata3, mhselect),
        mhvalue   : RD_RAW_FIELD_TRIGGER_MODE(riscv, tdata3, mhvalue),
        sbytemask : RD_RAW_FIELD_TRIGGER_MODE(riscv, tdata3, sbytemask),
    };

    // get configuration parameters for mvalue_bits and svalue_bits
    Bool  S           = riscv->configInfo.arch&ISA_S;
    Uns32 mvalue_bits = riscv->configInfo.mvalue_bits;
    Uns32 svalue_bits = S ? riscv->configInfo.svalue_bits : 0;

    // sbytemask is implemented only from version 1.0.0 when sselect can be 1
    if(!svalue_bits || (RISCV_DBG_VERSION(riscv)<RVDBG_1_0_0)) {
        tdata3UP.sbytemask = 0;
    }

    // mask value fields
    tdata3UP.mhvalue &= getAddressMask(mvalue_bits);
    tdata3UP.svalue  &= getAddressMask(svalue_bits);

    // handle M-mode field select
    if(!mvalue_bits) {
        tdata3UP.mhselect = 0;
    } else if(!(riscv->configInfo.arch&ISA_H)) {
        tdata3UP.mhselect &= 4;
    } else if((tdata3UP.mhselect&3)==3) {
        tdata3UP.mhselect = 0;
    }

    // handle S-mode field select
    if(
        !svalue_bits ||
        ((tdata3UP.sselect==1) && !riscv->configInfo.scontext_bits) ||
        ((tdata3UP.sselect==2) && riscv->configInfo.no_sselect_2)   ||
        (tdata3UP.sselect==3)
    ) {
        tdata3UP.sselect = 0;
    }

    return tdata3UP;
}

//
// Pack tdata3 value from common format
//
static Uns64 packTData3(riscvP riscv, riscvTData3UP tdata3UP) {

    CSR_REG_DECL(tdata3) = {0};

    WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata3, sselect,   tdata3UP.sselect);
    WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata3, svalue,    tdata3UP.svalue);
    WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata3, mhselect,  tdata3UP.mhselect);
    WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata3, mhvalue,   tdata3UP.mhvalue);
    WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata3, sbytemask, tdata3UP.sbytemask);

    return RD_RAW64(tdata3);
}

//
// Are trigger registers present?
//
inline static RISCV_CSR_PRESENTFN(triggerP) {
    return getTriggerNum(riscv);
}

//
// Is tdata2 register present?
//
inline static RISCV_CSR_PRESENTFN(tdata2P) {
    return getTriggerNum(riscv) && !riscv->configInfo.tdata2_undefined;
}

//
// Is tdata3 register present?
//
inline static RISCV_CSR_PRESENTFN(tdata3P) {
    return getTriggerNum(riscv) && !riscv->configInfo.tdata3_undefined;
}

//
// Is tinfo register present?
//
inline static RISCV_CSR_PRESENTFN(tinfoP) {
    return getTriggerNum(riscv) && !riscv->configInfo.tinfo_undefined;
}

//
// Is tcontrol register present?
//
inline static RISCV_CSR_PRESENTFN(tcontrolP) {
    return getTriggerNum(riscv) && !riscv->configInfo.tcontrol_undefined;
}

//
// Is mcontext register present?
//
inline static RISCV_CSR_PRESENTFN(mcontextP) {
    return getTriggerNum(riscv) && !riscv->configInfo.mcontext_undefined;
}

//
// Is scontext register present?
//
inline static Bool scontextP(riscvP riscv) {
    return getTriggerNum(riscv) && !riscv->configInfo.scontext_undefined;
}

//
// Is scontext register at address 0x5A8? (always the case from version 0.14.0,
// but configurable for earlier versions using scontext_0x5A8)
//
inline static Bool scontext0x5A8(riscvP riscv) {
    return (
        riscv->configInfo.scontext_0x5A8 ||
        (RISCV_DBG_VERSION(riscv)>=RVDBG_0_14_0)
    );
}

//
// Is scontext register present (prior to version 0.14.0)?
//
inline static RISCV_CSR_PRESENTFN(scontext13P) {
    return !scontext0x5A8(riscv) && scontextP(riscv);
}

//
// Is scontext register present (from version 0.14.0)?
//
inline static RISCV_CSR_PRESENTFN(scontext14P) {
    return scontext0x5A8(riscv) && scontextP(riscv);
}

//
// Is mscontext register present (from version 0.14.0)?
//
inline static RISCV_CSR_PRESENTFN(mscontextP) {
    return scontext14P(attrs, riscv) && !riscv->configInfo.mscontext_undefined;
}

//
// Is hcontext register present?
//
inline static RISCV_CSR_PRESENTFN(hcontextP) {
    return getTriggerNum(riscv) && !riscv->configInfo.hcontext_undefined;
}

//
// Is access to the given xcontext register enabled by Smstateen?
//
inline static Bool xcontextAccessValid(riscvP riscv, riscvCSRAttrsCP attrs) {
    return riscv->configInfo.Smstateen && attrs->Smstateen;
}

//
// Return effective value of tcontrol.scxe
//
inline static Bool getSCXE(riscvP riscv, riscvCSRAttrsCP attrs) {
    return (
        riscv->artifactAccess ||
        (RISCV_DBG_VERSION(riscv)<RVDBG_0_14_0) ||
        RD_CSR_FIELDC(riscv, tcontrol, scxe) ||
        xcontextAccessValid(riscv, attrs)
    );
}

//
// Return effective value of tcontrol.hcxe
//
inline static Bool getHCXE(riscvP riscv, riscvCSRAttrsCP attrs) {
    return (
        riscv->artifactAccess ||
        (RISCV_DBG_VERSION(riscv)<RVDBG_0_14_0) ||
        RD_CSR_FIELDC(riscv, tcontrol, hcxe) ||
        xcontextAccessValid(riscv, attrs)
    );
}

//
// Write tselect
//
static RISCV_CSR_WRITEFN(tselectW) {

    // clamp to implemented triggers
    if(newValue<riscv->configInfo.trigger_num) {
        WR_CSRC(riscv, tselect, newValue);
    }

    // return written value
    return RD_CSRC(riscv, tselect);
}

//
// Read tdata1
//
static RISCV_CSR_READFN(tdata1R) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    // return composed value
    return packTData1(riscv, trigger, trigger->tdata1UP);
}

//
// Write tdata1
//
static RISCV_CSR_WRITEFN(tdata1W) {

    riscvTriggerP trigger  = getCurrentTrigger(riscv);
    Uns64         oldValue = packTData1(riscv, trigger, trigger->tdata1UP);

    if(!mayWriteTrigger(riscv, trigger)) {

        // retain original value
        newValue = oldValue;

    } else {

        Uns64 mask = RD_CSR_MASK_M(riscv, tdata1);

        // get new value using writable bit mask
        newValue = ((newValue & mask) | (oldValue & ~mask));

        if(validateTriggerType(riscv, trigger, newValue)) {

            // unpack value into common format
            riscvTData1UP tdata1UP = unpackTData1(riscv, trigger, newValue);

            // handle type-specific updates
            if(mayWriteChain(riscv, tdata1UP.dmode, getPreviousTrigger(riscv))) {

                // pack unpacked value
                newValue = packTData1(riscv, trigger, tdata1UP);

                // handle value change
                if(newValue != oldValue) {
                    trigger->tdata1UP = tdata1UP;
                    riscvSetCurrentArch(riscv);
                }
            }
        }
    }

    // return composed value
    return newValue;
}

//
// Read tdata2
//
static RISCV_CSR_READFN(tdata2R) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);
    Uns64         result  = RD_REG_TRIGGER_MODE(riscv, trigger, tdata2);

    if(riscv->artifactAccess) {

        // return unmodified value

    } else if(trigger->tdata1UP.type==TT_INTERRUPT) {

        // bits that do not correspond to implemented interrupts are RAZ/WI
        result &= riscv->interruptMask;

    } else if(trigger->tdata1UP.type==TT_EXCEPTION) {

        // bits that do not correspond to implemented exceptions are RAZ/WI
        result &= riscv->exceptionMask;
    }

    return result;
}

//
// Write tdata2
//
static RISCV_CSR_WRITEFN(tdata2W) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    if(mayWriteTrigger(riscv, trigger)) {

        Uns64 allOnes  = TRIGGER_IS_32M(riscv) ? (Uns32)-1 : (Uns64)-1;
        Uns64 oldValue = RD_REG_TRIGGER_MODE(riscv, trigger, tdata2);
        Uns64 mask     = allOnes;

        if(riscv->artifactAccess) {

            // update value unmasked

        } else if(trigger->tdata1UP.type==TT_MCONTROL6) {

            // limit value to mcontrol_maskmax
            if(newValue==allOnes) {
                newValue = -1ULL << riscv->configInfo.mcontrol_maskmax;
            }

        } else if(trigger->tdata1UP.type==TT_INTERRUPT) {

            // bits that do not correspond to implemented interrupts are RAZ/WI
            mask &= riscv->interruptMask;

        } else if(trigger->tdata1UP.type==TT_EXCEPTION) {

            // bits that do not correspond to implemented exceptions are RAZ/WI
            mask &= riscv->exceptionMask;
        }

        // get new value using writable bit mask
        WR_RAW64(trigger->tdata2, ((newValue & mask) | (oldValue & ~mask)));
    }

    // return written value
    return RD_REG_TRIGGER_MODE(riscv, trigger, tdata2);
}

//
// Read tdata3
//
static RISCV_CSR_READFN(tdata3R) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    // return composed value
    return packTData3(riscv, trigger->tdata3UP);
}

//
// Write tdata3
//
static RISCV_CSR_WRITEFN(tdata3W) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    if(mayWriteTrigger(riscv, trigger)) {
        trigger->tdata3UP = unpackTData3(riscv, newValue);
    }

    // return composed value
    return packTData3(riscv, trigger->tdata3UP);
}

//
// Read tinfo
//
static RISCV_CSR_READFN(tinfoR) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    return RD_REG_TRIGGER_MODE(riscv, trigger, tinfo);
}

//
// Read mcontext
//
static RISCV_CSR_READFN(mcontextR) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    return RD_REG_TRIGGER_MODE(riscv, trigger, mcontext);
}

//
// Write mcontext
//
static RISCV_CSR_WRITEFN(mcontextW) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    // mask to implemented bits
    newValue &= RD_CSR_MASK64(riscv, mcontext);

    if(mayWriteTrigger(riscv, trigger)) {
        WR_REG_TRIGGER_MODE(riscv, trigger, mcontext, newValue);
    }

    // return written value
    return RD_REG_TRIGGER_MODE(riscv, trigger, mcontext);
}

//
// Read hcontext
//
static RISCV_CSR_READFN(hcontextR) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    return getHCXE(riscv, attrs) ? RD_REG_TRIGGER_MODE(riscv, trigger, mcontext) : 0;
}

//
// Write hcontext
//
static RISCV_CSR_WRITEFN(hcontextW) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    if(getHCXE(riscv, attrs)) {

        // mask to implemented bits
        newValue &= RD_CSR_MASK64(riscv, mcontext);

        if(mayWriteTrigger(riscv, trigger)) {
            WR_REG_TRIGGER_MODE(riscv, trigger, mcontext, newValue);
        }
    }

    // return written value
    return RD_REG_TRIGGER_MODE(riscv, trigger, mcontext);
}

//
// Read scontext
//
static RISCV_CSR_READFN(scontextR) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    return getSCXE(riscv, attrs) ? RD_REG_TRIGGER_MODE(riscv, trigger, scontext) : 0;
}

//
// Write scontext
//
static RISCV_CSR_WRITEFN(scontextW) {

    riscvTriggerP trigger = getCurrentTrigger(riscv);

    if(getSCXE(riscv, attrs)) {

        // mask to implemented bits
        newValue &= RD_CSR_MASK64(riscv, scontext);

        if(mayWriteTrigger(riscv, trigger)) {
            WR_REG_TRIGGER_MODE(riscv, trigger, scontext, newValue);
        }
    }

    // return written value
    return RD_REG_TRIGGER_MODE(riscv, trigger, scontext);
}

//
// Get the trigger type at reset
//
static triggerType getTriggerResetType(riscvP riscv, riscvTriggerP trigger) {

    Uns32       types = RD_REG_FIELD_TRIGGER(trigger, tinfo, info);
    triggerType type  = 0;

    // determine type for trigger at reset
    while(types && !(types&1)) {
        type++;
        types >>= 1;
    }

    return type;
}

//
// Configure trigger state
//
static void configureTriggers(riscvP riscv) {

    CSR_REG_DECL(tinfo) = {riscv->configInfo.tinfo};

    Uns32 i;

    for(i=0; i<riscv->configInfo.trigger_num; i++) {

        riscvTriggerP trigger = &riscv->triggers[i];

        // initialize tinfo and version
        WR_REG_FIELD_TRIGGER(trigger, tinfo, info,    tinfo.u32.fields.info);
        WR_REG_FIELD_TRIGGER(trigger, tinfo, version, tinfo.u32.fields.version);

        // initialize tdata1 (depends on tinfo)
        trigger->tdata1UP.type = getTriggerResetType(riscv, trigger);
    }
}

//
// Reset trigger state
//
static void resetTriggers(riscvP riscv) {

    Uns32 i;

    // force artifact access mode to allow clearing debug mode state
    riscv->artifactAccess = True;

    // reset all triggers
    for(i=0; i<riscv->configInfo.trigger_num; i++) {

        riscvTriggerP trigger = &riscv->triggers[i];

        // clear trigger match count and tvalValid
        trigger->matchICount = -1;
        trigger->tvalValid   = False;

        // select this trigger
        tselectW(0, riscv, i);

        // construct tdata1 reset value
        triggerType type = getTriggerResetType(riscv, trigger);
        CSR_REG_DECL(tdata1) = {0};
        WR_RAW_FIELD_TRIGGER_MODE(riscv, tdata1, type, type);

        // apply reset value
        tdata1W(0, riscv, RD_RAW64(tdata1));
    }

    // terminate artifact access mode
    riscv->artifactAccess = False;

    // reset trigger select
    tselectW(0, riscv, 0);
}


////////////////////////////////////////////////////////////////////////////////
// DEBUG MODE REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Are Debug Mode registers present?
//
inline static RISCV_CSR_PRESENTFN(debugP) {
    return riscv->configInfo.debug_mode;
}

//
// Is dscratch0 register present?
//
inline static RISCV_CSR_PRESENTFN(dscratch0P) {
    return debugP(attrs, riscv) && !riscv->configInfo.dscratch0_undefined;
}

//
// Is dscratch1 register present?
//
inline static RISCV_CSR_PRESENTFN(dscratch1P) {
    return debugP(attrs, riscv) && !riscv->configInfo.dscratch1_undefined;
}

//
// Return the mode encoded in DCSR
//
riscvMode riscvGetDCSRMode(riscvP riscv) {

    riscvMode prv = RD_CSR_FIELDC(riscv, dcsr, prv);

    if(!RD_CSR_FIELDC(riscv, dcsr, v)) {
        // no action
    } else if(prv<=RISCV_MODE_S) {
        prv |= RISCV_MODE_V;
    } else {
        // invalid mode
        prv = RISCV_MODE_H;
    }

    return prv;
}

//
// Set the mode encoded in DCSR
//
void riscvSetDCSRMode(riscvP riscv, riscvMode mode) {

    WR_CSR_FIELDC(riscv, dcsr, prv, mode);
    WR_CSR_FIELDC(riscv, dcsr, v,   modeIsVirtual(mode));
}

//
// Internal interface for dcsr write
//
static void dcsrWInt(riscvP riscv, Uns32 newValue, Uns32 roMask) {

    Uns32           oldValue = RD_CSRC(riscv, dcsr);
    Uns32           mask     = RD_CSR_MASKC(riscv, dcsr) | roMask;
    riscvCountState state;

    // get state before possible inhibit update
    riscvPreInhibit(riscv, &state);

    // update value
    riscvMode oldMode = riscvGetDCSRMode(riscv);
    WR_CSRC(riscv, dcsr, ((newValue & mask) | (oldValue & ~mask)));
    riscvMode newMode = riscvGetDCSRMode(riscv);

    // revert dcsr.prv and dcsr.v if target mode is not implemented from
    // version 0.14.0
    if(RISCV_DBG_VERSION(riscv)<RVDBG_0_14_0) {
        // no reversion
    } else if(!riscvHasMode(riscv, newMode)) {
        riscvSetDCSRMode(riscv, oldMode);
    }

    // set step breakpoint if required
    riscvSetStepBreakpoint(riscv);

    // refresh state after possible inhibit update
    riscvPostInhibit(riscv, &state, True);
}

//
// Write dcsr
//
static RISCV_CSR_WRITEFN(dcsrW) {

    Uns32 roMask = 0;

    // if an artifact access, allow fields that are normally not writable but
    // which potentially have non-zero values to be written
    if(riscv->artifactAccess) {

        static const CSR_REG_DECL(dcsr) = {
            u32 : {
                fields : {
                    xdebugver : -1,
                    stopcount : -1,
                    stoptime  : -1,
                    cause     : -1,
                    mprven    : -1,
                    nmip      : -1,
                }
            }
        };

        roMask = dcsr.u32.bits;
    }

    // call internal interface
    dcsrWInt(riscv, newValue, roMask);

    // return written value
    return RD_CSRC(riscv, dcsr);
}


////////////////////////////////////////////////////////////////////////////////
// CRYPTOGRAPHIC EXTENSION REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Get cryptographic extension version
//
inline static riscvCryptoVer getCryptoVersion(riscvP riscv) {
    return riscv->configInfo.crypto_version;
}

//
// Are cryptographic entropy source CSRs present?
//
inline static Bool cryptoEntropyP(riscvP riscv) {
    return !(RVKS_Zkr & riscv->configInfo.crypto_absent);
}

//
// Is mentropy register present?
//
inline static RISCV_CSR_PRESENTFN(mentropyP) {
    return cryptoEntropyP(riscv) && (getCryptoVersion(riscv)<RVKV_0_9_2);
}

//
// Is sentropy register present at original location (0xDBF)?
//
inline static RISCV_CSR_PRESENTFN(sentropyAP) {
    return cryptoEntropyP(riscv) && (getCryptoVersion(riscv)==RVKV_0_9_2);
}

//
// Is sentropy register present at new location (0x546)?
//
inline static RISCV_CSR_PRESENTFN(sentropyBP) {
    return cryptoEntropyP(riscv) && (getCryptoVersion(riscv)==RVKV_1_0_0_RC1);
}

//
// Is seed register present?
//
inline static RISCV_CSR_PRESENTFN(seedP) {
    return cryptoEntropyP(riscv) && (getCryptoVersion(riscv)>=RVKV_1_0_0_RC5);
}

//
// Is mnoise register present?
//
inline static RISCV_CSR_PRESENTFN(mnoiseP) {
    return cryptoEntropyP(riscv) && !riscv->configInfo.mnoise_undefined;
}

//
// Read mentropy
//
static RISCV_CSR_READFN(mentropyR) {
    return riscvPollEntropy(riscv);
}

//
// This defined required behavior of entropy-reading instructions
//
typedef enum entropyActionE {
    EA_VALID,   // entropy access valid
    EA_ILLEGAL, // take Illegal Instruction exception
    EA_VIRTUAL, // take Virtual Instruction exception
} entropyAction;

//
// Take an appropriate exception if entropy is inaccessible
//
static Bool entropyAccessFault(
    riscvP        riscv,
    entropyAction action,
    const char   *reason
) {
    if(action==EA_ILLEGAL) {
        riscvIllegalInstructionMessage(riscv, reason);
    } else if(action==EA_VIRTUAL) {
        riscvVirtualInstructionMessage(riscv, reason);
    }

    return (action==EA_VALID);
}

//
// Is access to entropy CSR legal in the current mode?
//
static Bool accessEntropy(riscvP riscv) {

    riscvMode     mode   = getCurrentMode5(riscv);
    entropyAction action = EA_VALID;
    const char   *reason = 0;
    Bool          SKES   = RD_CSR_FIELDC(riscv, mseccfg, USEED_SKES);

    if(riscv->artifactAccess) {
        // allow artifact access
    } else if(mode==RISCV_MODE_M) {
        // access always allowed
    } else if(inVMode(riscv)) {
        reason = "illegal in Virtual mode";
        action = EA_VIRTUAL;
    } else if(!SKES)  {
        reason = "access disabled by mseccfg.SKES";
        action = EA_ILLEGAL;
    }

    return entropyAccessFault(riscv, action, reason);
}

//
// Is access to seed CSR legal in the current mode?
//
static Bool accessSeed(riscvP riscv) {

    riscvMode     mode   = getCurrentMode5(riscv);
    entropyAction action = EA_VALID;
    const char   *reason = 0;
    Bool          SSEED  = RD_CSR_FIELDC(riscv, mseccfg, SSEED);
    Bool          USEED  = RD_CSR_FIELDC(riscv, mseccfg, USEED_SKES);

    if(riscv->artifactAccess) {
        // ignore value for artifact access
    } else if(mode==RISCV_MODE_M) {
        // access always allowed
    } else if(inVMode(riscv)) {
        reason = "illegal in Virtual mode";
        action = SSEED ? EA_VIRTUAL : EA_ILLEGAL;
    } else if((mode==RISCV_MODE_S) && !SSEED) {
        reason = "access disabled by mseccfg.SSEED";
        action = EA_ILLEGAL;
    } else if((mode==RISCV_MODE_U) && !USEED) {
        reason = "access disabled by mseccfg.USEED";
        action = EA_ILLEGAL;
    }

    return entropyAccessFault(riscv, action, reason);
}

//
// Read sentropy
//
static RISCV_CSR_READFN(sentropyR) {

    Uns32 result = 0;

    if(accessEntropy(riscv)) {
        result = riscvPollEntropy(riscv);
    }

    return result;
}

//
// Write sentropy (ignored, apart from access check)
//
static RISCV_CSR_WRITEFN(sentropyW) {

    accessEntropy(riscv);

    return 0;
}

//
// Read seed
//
static RISCV_CSR_READFN(seedR) {

    Uns32 result = 0;

    if(accessSeed(riscv)) {
        result = riscvPollEntropy(riscv);
    }

    return result;
}

//
// Write seed (ignored, apart from access check)
//
static RISCV_CSR_WRITEFN(seedW) {

    accessSeed(riscv);

    return 0;
}

//
// Read sentropy when not also written (invalid)
//
static RISCV_CSR_READFN(sentropyRInv) {

    if(!riscv->artifactAccess) {
        riscvIllegalInstructionMessage(riscv, "write required");
    }

    return 0;
}


////////////////////////////////////////////////////////////////////////////////
// SECURITY CONTROL REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Are Smepmp related fields present in mseccfg?
//
inline static Bool mseccfg_pmpP(riscvP riscv) {
    return RISCV_SMEPMP_VERSION(riscv);
}

//
// Are Crypto related fields present in mseccfg?
//
inline static Bool mseccfg_cryptoP(riscvP riscv) {
    return cryptoEntropyP(riscv) && (getCryptoVersion(riscv)>=RVKV_0_9_2);
}

//
// Is mseccfg register present?
//
inline static RISCV_CSR_PRESENTFN(mseccfgP) {
    return mseccfg_pmpP(riscv) || mseccfg_cryptoP(riscv);
}

//
// Write mseccfg
//
static RISCV_CSR_WRITEFN(mseccfgW) {

    Uns64 oldValue = RD_CSR(riscv, mseccfg);
    Uns64 wMask    = RD_CSR_MASK(riscv, mseccfg);

    // some non-artifact updates are restricted
    if(!riscv->artifactAccess) {

        // disallow clearing sticky mseccfg.MML
        if(RD_CSR_FIELDC(riscv, mseccfg, MML)) {
            wMask &= ~WM_mseccfg_MML;
        }

        // disallow clearing sticky mseccfg.MMWP
        if(RD_CSR_FIELDC(riscv, mseccfg, MMWP)) {
            wMask &= ~WM_mseccfg_MMWP;
        }

        // mseccfg.RLB may not be set if there are locked PMP entries
        if(
            !RD_CSR_FIELDC(riscv, mseccfg, RLB) &&
            (newValue & wMask & WM_mseccfg_RLB) &&
            riscvVMAnyPMPLocked(riscv)
        ) {
            wMask &= ~WM_mseccfg_RLB;
        }
    }

    // get new value using writable bit mask
    newValue = ((newValue & wMask) | (oldValue & ~wMask));

    // if PMP security controls have changed, unmap all PMP entries
    if((oldValue&WM_mseccfg_MML_MMWP) != (newValue&WM_mseccfg_MML_MMWP)) {
        riscvVMUnmapAllPMP(riscv);
    }

    // update the CSR
    WR_CSR(riscv, mseccfg, newValue);

    return RD_CSR(riscv, mseccfg);
}



////////////////////////////////////////////////////////////////////////////////
// STATE ENABLE REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Are *stateen* registers present?
//
inline static RISCV_CSR_PRESENTFN(stateenP) {
    return riscv->configInfo.Smstateen;
}

//
// Return index number of mstateen register
//
inline static Uns32 mstateenIndex(riscvCSRAttrsCP attrs) {
    return getCSRId(attrs)-CSR_ID(mstateen0);
}

//
// Return index number of mstateenh register
//
inline static Uns32 mstateenhIndex(riscvCSRAttrsCP attrs) {
    return getCSRId(attrs)-CSR_ID(mstateen0h);
}

//
// Return index number of hstateen register
//
inline static Uns32 hstateenIndex(riscvCSRAttrsCP attrs) {
    return getCSRId(attrs)-CSR_ID(hstateen0);
}

//
// Return index number of hstateenh register
//
inline static Uns32 hstateenhIndex(riscvCSRAttrsCP attrs) {
    return getCSRId(attrs)-CSR_ID(hstateen0h);
}

//
// Return index number of sstateenh register
//
inline static Uns32 sstateenIndex(riscvCSRAttrsCP attrs) {
    return getCSRId(attrs)-CSR_ID(sstateen0);
}

//
// Return write mask for register update
//
static Uns64 getCSRModeMask(riscvP riscv, riscvCSRAttrsCP attrs) {
    return maskModeXLEN(riscv, getCSRMode5(attrs, riscv));
}

//
// Return mask of writable and potentially non-zero bits in mstateen
//
static Uns64 mstateenMask(riscvP riscv, Uns32 index) {
    return RD_CSR_MASK64(riscv, mstateen[index]);
}

//
// Read mstateen register (internal interface)
//
static Uns64 mstateenRInt(riscvP riscv, Uns32 index) {
    return RD_CSR64(riscv, mstateen[index]) & mstateenMask(riscv, index);
}

//
// Write mstateen register (internal interface)
//
static Uns64 mstateenWInt(riscvP riscv, Uns64 newValue, Uns64 mask, Uns32 index) {

    Uns64 oldValue = RD_CSR64(riscv, mstateen[index]);
    Uns64 wMask    = mstateenMask(riscv, index) & mask;

    // get new value using writable bit mask
    newValue = ((newValue & wMask) | (oldValue & ~wMask));

    // update the CSR
    WR_CSR64(riscv, mstateen[index], newValue);

    // return visible bits
    return newValue & wMask;
}

//
// Return mask of writable and potentially non-zero bits in hstateen
//
static Uns64 hstateenMask(riscvP riscv, Uns32 index) {

    Uns64 maskh = RD_CSR_MASK64(riscv, hstateen[index]);

    if(!riscv->artifactAccess) {

        Uns64 maskm = mstateenRInt(riscv, index);

        // only bits delegated from mstateen are visible
        if(maskm & WM64_stateen_xstateen) {
            maskh &= maskm;
        } else {
            maskh = 0;
        }
    }

    return maskh;
}

//
// Read hstateen register (internal interface)
//
static Uns64 hstateenRInt(riscvP riscv, Uns32 index) {
    return RD_CSR64(riscv, hstateen[index]) & hstateenMask(riscv, index);
}

//
// Write hstateen register (internal interface)
//
static Uns64 hstateenWInt(riscvP riscv, Uns64 newValue, Uns64 mask, Uns32 index) {

    Uns64 oldValue = RD_CSR64(riscv, hstateen[index]);
    Uns64 wMask    = hstateenMask(riscv, index) & mask;

    // get new value using writable bit mask
    newValue = ((newValue & wMask) | (oldValue & ~wMask));

    // update the CSR
    WR_CSR64(riscv, hstateen[index], newValue);

    // return visible bits
    return newValue & wMask;
}

//
// Return mask of writable and potentially non-zero bits in sstateen
//
static Uns64 sstateenMask(riscvP riscv, Uns32 index) {

    Uns64 masks = RD_CSR_MASK64(riscv, sstateen[index]);

    if(riscv->artifactAccess) {

        // no action for artifact access

    } else if(!inVMode(riscv)) {

        Uns64 maskm = mstateenRInt(riscv, index);

        // only bits delegated from mstateen are visible
        if(maskm & WM64_stateen_xstateen) {
            masks &= maskm;
        } else {
            masks = 0;
        }

    } else {

        // this branch can only be reached by a VS-mode access, in which case
        // xstateen enable check has already been done
        masks &= hstateenRInt(riscv, index);
    }

    return masks;
}

//
// Read sstateen register (internal interface)
//
static Uns64 sstateenRInt(riscvP riscv, Uns32 index) {
    return RD_CSR64(riscv, sstateen[index]) & sstateenMask(riscv, index);
}

//
// Write hstateen register (internal interface)
//
static Uns64 sstateenWInt(riscvP riscv, Uns64 newValue, Uns64 mask, Uns32 index) {

    Uns64 oldValue = RD_CSR64(riscv, sstateen[index]);
    Uns64 wMask    = sstateenMask(riscv, index) & mask;

    // get new value using writable bit mask
    newValue = ((newValue & wMask) | (oldValue & ~wMask));

    // update the CSR
    WR_CSR64(riscv, sstateen[index], newValue);

    // return visible bits
    return newValue & wMask;
}

//
// Return a Boolean indicating if an access in the current mode to a feature
// enabled by the given xstateen bit is valid (and optionally take an Undefined
// Instruction or Virtual Instruction trap if not)
//
Bool riscvStateenFeatureEnabled(riscvP riscv, Uns32 bit, Bool trap) {

    riscvMode mode  = getCurrentMode3(riscv);
    Uns64     mask  = 1ULL << (bit&63);
    Uns32     index = bit/64;
    Bool      ok    = False;

    if(mode==RISCV_MODE_M) {

        // access is valid
        ok = True;

    } else if(!(mask & mstateenRInt(riscv, index))) {

        // access is disabled by mstateen
        if(trap) {
            riscvIllegalInstructionMessage(riscv, "access disabled by mstateen");
        }

    } else if(inVMode(riscv) && !(mask & hstateenRInt(riscv, index))) {

        // access is disabled by hstateen
        if(trap) {
            riscvVirtualInstructionMessage(riscv, "access disabled by hstateen");
        }

    } else if((mode!=RISCV_MODE_U) || !supervisorPresent(riscv)) {

        // access is valid
        ok = True;

    } else if(!(mask & sstateenRInt(riscv, index))) {

        // access is disabled by sstateen
        if(trap) {
            riscvIllegalInstructionMessage(riscv, "access disabled by sstateen");
        }

    } else {

        // access is valid
        ok = True;
    }

    return ok;
}

//
// Return a Boolean indicating if an access in the current mode to a feature
// enabled by the given xstateen bit is permitted by mstateen and take an
// Undefined Instruction trap if not
//
static void riscvStateenFeatureEnabledM(riscvP riscv, Uns32 bit) {

    Uns64 mask  = 1ULL << (bit&63);
    Uns32 index = bit/64;

    if(!(mask & mstateenRInt(riscv, index))) {
        riscvIllegalInstructionMessage(riscv, "access disabled by mstateen");
    }
}

//
// Register Sstateen bit if required
//
static void registerStateenBit(riscvP riscv, riscvCSRAttrsCP attrs) {

    riscvCSRStateenBit bit = attrs->Smstateen;

    if(bit && riscv->configInfo.Smstateen && userPresent(riscv)) {

        Uns64 mask  = 1ULL << (bit&63);
        Uns32 index = bit/64;

        // add to mstateen and hstateen masks if Supervisor mode is present
        if(supervisorPresent(riscv)) {
            OR_CSR_MASKC(riscv, mstateen[index], mask);
            OR_CSR_MASKC(riscv, hstateen[index], mask);
        }

        // add to mstateen and sstateen masks if a User-mode CSR
        if(getCSRMode4(attrs, riscv)==RISCV_MODE_U) {
            OR_CSR_MASKC(riscv, mstateen[index], mask);
            OR_CSR_MASKC(riscv, sstateen[index], mask);
        }
    }
}

//
// Read mstateen register
//
static RISCV_CSR_READFN(mstateenR) {

    Uns32 index = mstateenIndex(attrs);
    Uns64 mask  = getCSRModeMask(riscv, attrs);

    return mstateenRInt(riscv, index) & mask;
}

//
// Write mstateen register
//
static RISCV_CSR_WRITEFN(mstateenW) {

    Uns32 index = mstateenIndex(attrs);
    Uns64 mask  = getCSRModeMask(riscv, attrs);

    return mstateenWInt(riscv, newValue, mask, index);
}

//
// Read mstateenh register
//
static RISCV_CSR_READFN(mstateenhR) {

    Uns32 index = mstateenhIndex(attrs);

    return mstateenRInt(riscv, index)>>32;
}

//
// Write mstateenh register
//
static RISCV_CSR_WRITEFN(mstateenhW) {

    Uns32 index = mstateenhIndex(attrs);
    Uns64 mask  = -1;

    return mstateenWInt(riscv, newValue<<32, mask<<32, index) >> 32;
}

//
// Read hstateen register
//
static RISCV_CSR_READFN(hstateenR) {

    Uns32 index  = hstateenIndex(attrs);
    Uns64 mask   = getCSRModeMask(riscv, attrs);

    return hstateenRInt(riscv, index) & mask;
}

//
// Write hstateen register
//
static RISCV_CSR_WRITEFN(hstateenW) {

    Uns32 index  = hstateenIndex(attrs);
    Uns64 mask   = getCSRModeMask(riscv, attrs);

    return hstateenWInt(riscv, newValue, mask, index);
}

//
// Read hstateenh register
//
static RISCV_CSR_READFN(hstateenhR) {

    Uns32 index = hstateenhIndex(attrs);

    return hstateenRInt(riscv, index)>>32;
}

//
// Write hstateenh register
//
static RISCV_CSR_WRITEFN(hstateenhW) {

    Uns32 index  = hstateenhIndex(attrs);
    Uns64 mask   = -1;

    return hstateenWInt(riscv, newValue<<32, mask<<32, index) >> 32;
}

//
// Read sstateen register
//
static RISCV_CSR_READFN(sstateenR) {

    Uns32 index  = sstateenIndex(attrs);
    Uns64 mask   = getCSRModeMask(riscv, attrs);

    return sstateenRInt(riscv, index) & mask;
}

//
// Write sstateen register
//
static RISCV_CSR_WRITEFN(sstateenW) {

    Uns32 index  = sstateenIndex(attrs);
    Uns64 mask   = getCSRModeMask(riscv, attrs);

    return sstateenWInt(riscv, newValue, mask, index);
}


////////////////////////////////////////////////////////////////////////////////
// ENVIRONMENT CONFIGURATION REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// Write menvcfg (internal interface)
//
static Uns64 menvcfgWInt(riscvP riscv, Uns64 newValue) {

    Bool  oldSTCE  = stimecmpEnabled(riscv);
    Uns64 oldValue = RD_CSR64(riscv, menvcfg);
    Uns32 oldCBIE  = RD_CSR_FIELD(riscv, menvcfg, CBIE);
    Uns64 wMask    = RD_CSR_MASK64(riscv, menvcfg);

    // get new value using writable bit mask
    newValue = ((newValue & wMask) | (oldValue & ~wMask));

    // update the CSR
    WR_CSR64(riscv, menvcfg, newValue);

    // handle reserved CBIE field by value reversion
    if(RD_CSR_FIELD(riscv, menvcfg, CBIE)==2) {
        WR_CSR_FIELD(riscv, menvcfg, CBIE, oldCBIE);
    }

    // update apparent mip if stimecmp is enabled or disabled
    if(oldSTCE!=stimecmpEnabled(riscv)) {
        riscvUpdatePending(riscv);
    }

    return RD_CSR64(riscv, menvcfg);
}

//
// Write menvcfg
//
static RISCV_CSR_WRITEFN(menvcfgW) {

    if(RISCV_XLEN_IS_32M(riscv, getCSRMode5(attrs, riscv))) {
        newValue = setLower(newValue, RD_CSR64(riscv, menvcfg));
    }

    return menvcfgWInt(riscv, newValue);
}

//
// Write menvcfgh
//
static RISCV_CSR_WRITEFN(menvcfghW) {

    newValue = setUpper(newValue, RD_CSR64(riscv, menvcfg));

    return menvcfgWInt(riscv, newValue) >> 32;
}

//
// Return mask of visible bits in henvcfg
//
static Uns64 henvcfgVisMask(riscvP riscv) {

     Uns64 invisible = 0;

     if(!riscv->artifactAccess) {

         if(!RD_CSR_FIELD(riscv, menvcfg, PBMTE)) {
             invisible |= (1ULL<<shift_envcfg_PBMTE);
         }
         if(!stimecmpEnabled(riscv)) {
             invisible |= (1ULL<<shift_envcfg_STCE);
         }
     }

     return ~invisible;
}

//
// Read henvcfg (internal interface)
//
inline static Uns64 henvcfgRInt(riscvP riscv) {
    return RD_CSR64(riscv, henvcfg) & henvcfgVisMask(riscv);
}

//
// Write henvcfg (internal interface)
//
static Uns64 henvcfgWInt(riscvP riscv, Uns64 newValue) {

    Bool  oldSTCE  = vstimecmpEnabled(riscv);
    Uns64 oldValue = RD_CSR64(riscv, henvcfg);
    Uns32 oldCBIE  = RD_CSR_FIELD(riscv, henvcfg, CBIE);
    Uns64 wMask    = RD_CSR_MASK64(riscv, henvcfg) & henvcfgVisMask(riscv);

    // get new value using writable bit mask
    newValue = ((newValue & wMask) | (oldValue & ~wMask));

    // update the CSR
    WR_CSR64(riscv, henvcfg, newValue);

    // handle reserved CBIE field by value reversion
    if(RD_CSR_FIELD(riscv, henvcfg, CBIE)==2) {
        WR_CSR_FIELD(riscv, henvcfg, CBIE, oldCBIE);
    }

    // update apparent mip if vstimecmp is enabled or disabled
    if(oldSTCE!=vstimecmpEnabled(riscv)) {
        riscvUpdatePending(riscv);
    }

    return henvcfgRInt(riscv);
}

//
// Read henvcfg
//
static RISCV_CSR_READFN(henvcfgR) {
    return henvcfgRInt(riscv);
}

//
// Write henvcfg
//
static RISCV_CSR_WRITEFN(henvcfgW) {

    if(RISCV_XLEN_IS_32M(riscv, getCSRMode5(attrs, riscv))) {
        newValue = setLower(newValue, RD_CSR64(riscv, henvcfg));
    }

    return henvcfgWInt(riscv, newValue);
}

//
// Read henvcfgh
//
static RISCV_CSR_READFN(henvcfghR) {
    return henvcfgRInt(riscv) >> 32;
}

//
// Write henvcfgh
//
static RISCV_CSR_WRITEFN(henvcfghW) {

    newValue = setUpper(newValue, RD_CSR64(riscv, henvcfg));

    return henvcfgWInt(riscv, newValue) >> 32;
}

//
// Write senvcfg
//
static RISCV_CSR_WRITEFN(senvcfgW) {

    Uns64 oldValue = RD_CSR(riscv, senvcfg);
    Uns32 oldCBIE  = RD_CSR_FIELD(riscv, senvcfg, CBIE);
    Uns64 wMask    = RD_CSR_MASK(riscv, senvcfg);

    // get new value using writable bit mask
    newValue = ((newValue & wMask) | (oldValue & ~wMask));

    // update the CSR
    WR_CSR(riscv, senvcfg, newValue);

    // handle reserved CBIE field by value reversion
    if(RD_CSR_FIELD(riscv, senvcfg, CBIE)==2) {
        WR_CSR_FIELD(riscv, senvcfg, CBIE, oldCBIE);
    }

    return RD_CSR(riscv, senvcfg);
}


////////////////////////////////////////////////////////////////////////////////
// MACROS FOR CSRS
////////////////////////////////////////////////////////////////////////////////

//
// Unimplemented (ignore reads and writes)
//
#define CSR_ATTR_NIP( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT                                 \
) [CSR_ID(_ID)] = {                                 \
    name          : #_ID,                           \
    desc          : _DESC" (not implemented)",      \
    csrNum        : _NUM,                           \
    arch          : _ARCH,                          \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
}

//
// Implemented using vmiReg and optional callbacks, no mask
//
#define CSR_ATTR_T__( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB     \
) [CSR_ID(_ID)] = { \
    name          : #_ID,                           \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH,                          \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : _RCB,                           \
    readWriteCB   : _RWCB,                          \
    writeCB       : _WCB,                           \
    wstateCB      : _WSTATE,                        \
    reg           : CSR_REG_MT(_ID),                \
    writeMaskC32  : -1,                             \
    writeMaskC64  : -1                              \
}

//
// Implemented using vmiReg and optional callbacks, no mask, register is suffixed
//
#define CSR_ATTR_TS_( \
    _ID, _SUFFIX, _NUM, _ARCH, _ACCESS, _VERSION,   \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB     \
) [CSR_ID(_ID##_SUFFIX)] = { \
    name          : #_ID,                           \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH,                          \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : _RCB,                           \
    readWriteCB   : _RWCB,                          \
    writeCB       : _WCB,                           \
    wstateCB      : _WSTATE,                        \
    reg           : CSR_REG_MT(_ID),                \
    writeMaskC32  : -1,                             \
    writeMaskC64  : -1                              \
}

//
// Implemented using vmiReg and optional callbacks, no mask, high half
//
#define CSR_ATTR_TH_( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB   \
) [CSR_ID(_ID##h)] = { \
    name          : #_ID"h",                        \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH|ISA_XLEN_32|ISA_and,      \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : _RCB,                           \
    readWriteCB   : _RWCB,                          \
    writeCB       : _WCB,                           \
    wstateCB      : _WSTATE,                        \
    reg           : CSR_REGH_MT(_ID),               \
    writeMaskC32  : -1,                             \
    writeMaskC64  : -1                              \
}

//
// Implemented using vmiReg and optional callbacks, constant write mask
//
#define CSR_ATTR_TC_( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB     \
) [CSR_ID(_ID)] = { \
    name          : #_ID,                           \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH,                          \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : _RCB,                           \
    readWriteCB   : _RWCB,                          \
    writeCB       : _WCB,                           \
    wstateCB      : _WSTATE,                        \
    reg           : CSR_REG_MT(_ID),                \
    writeMaskC32  : WM32_##_ID,                     \
    writeMaskC64  : WM64_##_ID                      \
}

//
// Implemented using vmiReg and optional callbacks, constant write mask
//
#define CSR_ATTR_TCS( \
    _ID, _SUFFIX, _NUM, _ARCH, _ACCESS, _VERSION,            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB     \
) [CSR_ID(_ID##_SUFFIX)] = { \
    name          : #_ID,                           \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH,                          \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : _RCB,                           \
    readWriteCB   : _RWCB,                          \
    writeCB       : _WCB,                           \
    wstateCB      : _WSTATE,                        \
    reg           : CSR_REG_MT(_ID),                \
    writeMaskC32  : WM32_##_ID,                     \
    writeMaskC64  : WM64_##_ID                      \
}

//
// Implemented using vmiReg, constant write mask, high half
//
#define CSR_ATTR_TCH( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT                                 \
) [CSR_ID(_ID##h)] = { \
    name          : #_ID"h",                        \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH|ISA_XLEN_32|ISA_and,      \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : 0,                              \
    readWriteCB   : 0,                              \
    writeCB       : 0,                              \
    wstateCB      : 0,                              \
    reg           : CSR_REGH_MT(_ID),               \
    writeMaskC32  : (WM64_##_ID>>32)                \
}

//
// Implemented using vmiReg and optional callbacks, variable write mask
//
#define CSR_ATTR_TV_( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB     \
) [CSR_ID(_ID)] = { \
    name          : #_ID,                           \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH,                          \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : _RCB,                           \
    readWriteCB   : _RWCB,                          \
    writeCB       : _WCB,                           \
    wstateCB      : _WSTATE,                        \
    reg           : CSR_REG_MT(_ID),                \
    writeMaskV    : CSR_MASK_MT(_ID)                \
}

//
// Implemented using vmiReg and optional callbacks, variable write mask,
// register is suffixed
//
#define CSR_ATTR_TVS( \
    _ID, _SUFFIX, _NUM, _ARCH, _ACCESS, _VERSION,   \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB     \
) [CSR_ID(_ID##_SUFFIX)] = { \
    name          : #_ID,                           \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH,                          \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : _RCB,                           \
    readWriteCB   : _RWCB,                          \
    writeCB       : _WCB,                           \
    wstateCB      : _WSTATE,                        \
    reg           : CSR_REG_MT(_ID),                \
    writeMaskV    : CSR_MASK_MT(_ID)                \
}

//
// Implemented using vmiReg, variable write mask, high half
//
#define CSR_ATTR_TVH( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT                                 \
) [CSR_ID(_ID##h)] = { \
    name          : #_ID"h",                        \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH|ISA_XLEN_32|ISA_and,      \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : 0,                              \
    readWriteCB   : 0,                              \
    writeCB       : 0,                              \
    wstateCB      : 0,                              \
    reg           : CSR_REGH_MT(_ID),               \
    writeMaskV    : CSR_MASKH_MT(_ID)               \
}

//
// Implemented using callbacks only
//
#define CSR_ATTR_P__( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB     \
) [CSR_ID(_ID)] = { \
    name          : #_ID,                           \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH,                          \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : _RCB,                           \
    readWriteCB   : _RWCB,                          \
    writeCB       : _WCB,                           \
    wstateCB      : _WSTATE,                        \
    writeMaskC32  : -1,                             \
    writeMaskC64  : -1                              \
}

//
// Implemented using callbacks only, high half
//
#define CSR_ATTR_PH_( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB     \
) [CSR_ID(_ID##h)] = { \
    name          : #_ID"h",                        \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH|ISA_XLEN_32|ISA_and,      \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : _RCB,                           \
    readWriteCB   : _RWCB,                          \
    writeCB       : _WCB,                           \
    wstateCB      : _WSTATE,                        \
    writeMaskC32  : -1,                             \
    writeMaskC64  : -1                              \
}

//
// Implemented using callbacks only, register is suffixed
//
#define CSR_ATTR_PS_( \
    _ID, _SUFFIX, _NUM, _ARCH, _ACCESS, _VERSION,   \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,      \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB     \
) [CSR_ID(_ID##_SUFFIX)] = { \
    name          : #_ID,                           \
    desc          : _DESC,                          \
    csrNum        : _NUM,                           \
    arch          : _ARCH,                          \
    access        : _ACCESS,                        \
    version       : RVPV_##_VERSION,                \
    wEndBlock     : _ENDB,                          \
    noSaveRestore : _NOSR,                          \
    noTraceChange : _TMODE,                         \
    trap          : _TRAP,                          \
    aliasV        : _V,                             \
    Smstateen     : _STATEEN,                       \
    writeRd       : _WRD,                           \
    presentCB     : _PRESENT,                       \
    readCB        : _RCB,                           \
    readWriteCB   : _RWCB,                          \
    writeCB       : _WCB,                           \
    wstateCB      : _WSTATE,                        \
    writeMaskC32  : -1,                             \
    writeMaskC64  : -1                              \
}

//
// Implemented using callbacks only, append number
//
#define CSR_ATTR_P__NUM( \
    _ID, _NUM, _I, _ARCH, _ACCESS, _VERSION,                            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_P__( \
        _ID##_I, _NUM+_I, _ARCH, _ACCESS, _VERSION,                     \
        _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                      \
        _DESC#_I, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                  \
    )

//
// Implemented using callbacks only, numbers 0..3
//
#define CSR_ATTR_P__0_3( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,                                \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_P__NUM(_ID, _NUM, 0, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 1, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 2, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 3, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB)

//
// Implemented using callbacks only, numbers 0..3, Smstaten control
//
#define CSR_ATTR_PS_0_3( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,                                \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_P__NUM(_ID, _NUM, 0, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,(0*64)+_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 1, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,(1*64)+_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 2, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,(2*64)+_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 3, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,(3*64)+_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB)

//
// Implemented using callbacks only, numbers 0..9
//
#define CSR_ATTR_P__0_9( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,                                \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_P__NUM(_ID, _NUM, 0, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 1, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 2, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 3, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 4, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 5, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 6, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 7, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 8, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 9, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB)

//
// Implemented using callbacks only, even numbers in range 0..15
//
#define CSR_ATTR_P__0_15E( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,                                \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_P__NUM(_ID, _NUM,  0, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM,  2, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM,  4, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM,  6, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM,  8, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 10, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 12, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 14, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB)

//
// Implemented using callbacks only, odd numbers in range 0..15
//
#define CSR_ATTR_P__0_15O( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,                                \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_P__NUM(_ID, _NUM,  1, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM,  3, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM,  5, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM,  7, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM,  9, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 11, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 13, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID, _NUM, 15, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB)

//
// Implemented using callbacks only, numbers 0..63
//
#define CSR_ATTR_P__0_63( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,                                \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_P__0_9(_ID,    _NUM,    _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__0_9(_ID##1, _NUM+10, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC"1", _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__0_9(_ID##2, _NUM+20, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC"2", _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__0_9(_ID##3, _NUM+30, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC"3", _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__0_9(_ID##4, _NUM+40, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC"4", _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__0_9(_ID##5, _NUM+50, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC"5", _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM,60, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM,61, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM,62, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM,63, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB)

//
// Implemented using callbacks only, numbers 3..31
//
#define CSR_ATTR_P__3_31( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,                                \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_P__NUM(_ID,    _NUM, 3, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM, 4, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM, 5, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM, 6, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM, 7, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM, 8, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM, 9, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__0_9(_ID##1, _NUM+10, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC"1", _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__0_9(_ID##2, _NUM+20, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC"2", _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM,30, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_P__NUM(_ID,    _NUM,31, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC,    _PRESENT, _WSTATE, _RCB, _RWCB, _WCB)

//
// Implemented using callbacks only, high half only, append number
//
#define CSR_ATTR_PH_NUM( \
    _ID, _NUM, _I, _ARCH, _ACCESS, _VERSION,                            \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_PH_( \
        _ID##_I, _NUM+_I, _ARCH, _ACCESS, _VERSION,                     \
        _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                      \
        _DESC#_I, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                  \
    )

//
// Implemented using callbacks only, high half, numbers 0..3
//
#define CSR_ATTR_PH_0_3( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,                                \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_PH_NUM(_ID, _NUM, 0, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_PH_NUM(_ID, _NUM, 1, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_PH_NUM(_ID, _NUM, 2, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_PH_NUM(_ID, _NUM, 3, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB)

//
// Implemented using callbacks only, high half, numbers 0..3, Smstaten control
//
#define CSR_ATTR_PHS_0_3( \
    _ID, _NUM, _ARCH, _ACCESS, _VERSION,                                \
    _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,_STATEEN,                          \
    _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB                         \
) \
    CSR_ATTR_PH_NUM(_ID, _NUM, 0, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,(0*64)+_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_PH_NUM(_ID, _NUM, 1, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,(1*64)+_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_PH_NUM(_ID, _NUM, 2, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,(2*64)+_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB), \
    CSR_ATTR_PH_NUM(_ID, _NUM, 3, _ARCH, _ACCESS, _VERSION, _ENDB,_TMODE,_TRAP,_WRD,_NOSR,_V,(3*64)+_STATEEN, _DESC, _PRESENT, _WSTATE, _RCB, _RWCB, _WCB)


//
// CSR table
//
static const riscvCSRAttrs csrs[CSR_ID(LAST)] = {

    //                name          num    arch         access      version     attrs    Smstateen             description                                              present      wState       rCB            rwCB      wCB
    CSR_ATTR_P__     (ustatus,      0x000, ISA_N,       0,          1_10,   0,0,0,0,1,0, 0,                    "User Status",                                           0,           0,           ustatusR,      0,        ustatusW      ),
    CSR_ATTR_P__     (fflags,       0x001, ISA_DF,      0,          1_10,   0,0,0,0,0,0, 0,                    "Floating-Point Flags",                                  0,           riscvWFS,    fflagsR,       0,        fflagsW       ),
    CSR_ATTR_P__     (frm,          0x002, ISA_DF,      0,          1_10,   1,0,0,0,0,0, 0,                    "Floating-Point Rounding Mode",                          0,           riscvWFS,    frmR,          0,        frmW          ),
    CSR_ATTR_P__     (fcsr,         0x003, ISA_DFV,     ISA_FS,     1_10,   1,0,0,0,0,0, 0,                    "Floating-Point Control and Status",                     0,           riscvWFS,    fcsrR,         0,        fcsrW         ),
    CSR_ATTR_P__     (uie,          0x004, ISA_N,       0,          1_10,   1,0,0,0,1,0, 0,                    "User Interrupt Enable",                                 0,           0,           uieR,          0,        uieW          ),
    CSR_ATTR_T__     (utvec,        0x005, ISA_N,       0,          1_10,   0,0,0,0,0,0, 0,                    "User Trap-Vector Base-Address",                         0,           0,           utvecR,        0,        utvecW        ),
    CSR_ATTR_TV_     (utvt,         0x007, ISA_N,       0,          1_10,   0,0,0,0,0,0, 0,                    "User CLIC Trap-Vector Base-Address",                    clicTVTP,    0,           0,             0,        utvtW         ),
    CSR_ATTR_TV_     (vstart,       0x008, ISA_V,       0,          1_10,   0,0,0,0,0,0, 0,                    "Vector Start Index",                                    0,           riscvWVStart,0,             0,        0             ),
    CSR_ATTR_TC_     (vxsat,        0x009, ISA_VP,      ISA_FSandV, 1_10,   0,0,0,0,0,0, 0,                    "Fixed-Point Saturate Flag",                             vxsatP,      riscvWFSVS,  vxsatR,        0,        vxsatW        ),
    CSR_ATTR_TC_     (vxrm,         0x00A, ISA_V,       ISA_FSandV, 1_10,   0,0,0,0,0,0, 0,                    "Fixed-Point Rounding Mode",                             0,           riscvWFSVS,  0,             0,        vxrmW         ),
    CSR_ATTR_T__     (vcsr,         0x00F, ISA_V,       0,          1_10,   1,0,0,0,0,0, 0,                    "Vector Control and Status",                             vcsrP,       riscvWVCSR,  vcsrR,         0,        vcsrW         ),
    CSR_ATTR_P__     (seed,         0x015, ISA_K,       0,          1_10,   0,1,0,0,1,0, 0,                    "Poll Entropy",                                          seedP,       0,           sentropyRInv,  seedR,    seedW         ),
    CSR_ATTR_TVS     (jvt,701,      0x017, ISA_C,       0,          1_10,   0,0,0,0,0,0, 0,                    "Table Jump Base and Control",                           ZcmtLE701P,  0,           0,             0,        0             ),
    CSR_ATTR_TVS     (jvt,705,      0x017, ISA_C,       0,          1_10,   0,0,0,0,0,0, bit_stateen_Zcmt,     "Table Jump Base and Control",                           ZcmtGT701P,  0,           0,             0,        0             ),
    CSR_ATTR_T__     (uscratch,     0x040, ISA_N,       0,          1_10,   0,0,0,0,0,0, 0,                    "User Scratch",                                          0,           0,           0,             0,        0             ),
    CSR_ATTR_TV_     (uepc,         0x041, ISA_N,       0,          1_10,   0,0,0,0,0,0, 0,                    "User Exception Program Counter",                        0,           0,           uepcR,         0,        0             ),
    CSR_ATTR_T__     (ucause,       0x042, ISA_N,       0,          1_10,   0,0,0,0,0,0, 0,                    "User Cause",                                            0,           0,           ucauseR,       0,        ucauseW       ),
    CSR_ATTR_TV_     (utval,        0x043, ISA_N,       0,          1_10,   0,0,0,0,0,0, 0,                    "User Trap Value",                                       0,           0,           0,             0,        0             ),
    CSR_ATTR_P__     (uip,          0x044, ISA_N,       0,          1_10,   1,0,0,0,1,0, 0,                    "User Interrupt Pending",                                0,           0,           uipR,          uipRW,    uipW          ),
    CSR_ATTR_P__     (unxti,        0x045, ISA_N,       0,          1_10,   0,0,0,1,1,0, 0,                    "User Interrupt Handler Address/Enable",                 clicNXTP,    0,           unxtiR,        ustatusR, unxtiW        ),
    CSR_ATTR_PS_     (uintstatus,RW,0x046, ISA_N,       0,          1_10,   0,0,0,0,0,0, 0,                    "User Interrupt Status",                                 clicRWP,     0,           uintstatusR,   0,        0             ),
    CSR_ATTR_PS_     (uintstatus,R1,0xC46, ISA_N,       0,          1_10,   0,0,0,0,0,0, 0,                    "User Interrupt Status",                                 clicR1P,     0,           uintstatusR,   0,        0             ),
    CSR_ATTR_PS_     (uintstatus,R2,0xCB1, ISA_N,       0,          1_10,   0,0,0,0,0,0, 0,                    "User Interrupt Status",                                 clicR2P,     0,           uintstatusR,   0,        0             ),
    CSR_ATTR_T__     (uintthresh,   0x047, ISA_N,       0,          1_10,   0,0,0,0,0,0, 0,                    "User Interrupt Level Threshold",                        clicITP,     0,           0,             0,        uintthreshW   ),
    CSR_ATTR_P__     (uscratchcswl, 0x049, ISA_N,       0,          1_10,   0,0,0,1,1,0, 0,                    "User Conditional Scratch Swap, Level",                  clicSWP,     0,           uscratchcswlR, 0,        uscratchcswlW ),
    CSR_ATTR_TC_     (tbljalvec,    0x800, ISA_C,       0,          1_10,   0,0,0,0,0,0, 0,                    "Table Jump Base",                                       ZceaP,       0,           0,             0,        0             ),
    CSR_ATTR_TC_     (ucode,        0x801, ISA_P,       0,          1_10,   0,0,0,0,0,0, 0,                    "Code",                                                  ucodeP,      0,           0,             0,        0             ),
    CSR_ATTR_P__     (cycle,        0xC00, 0,           0,          1_10,   0,2,0,0,0,0, 0,                    "Cycle Counter",                                         cycleP,      0,           mcycleR,       0,        0             ),
    CSR_ATTR_P__     (time,         0xC01, 0,           0,          1_10,   0,2,0,0,0,0, 0,                    "Timer",                                                 timeP,       0,           timeR,         0,        0             ),
    CSR_ATTR_P__     (instret,      0xC02, 0,           0,          1_10,   0,2,0,0,0,0, 0,                    "Instructions Retired",                                  instretP,    0,           minstretR,     0,        0             ),
    CSR_ATTR_P__3_31 (hpmcounter,   0xC00, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Performance Monitor Counter ",                          hpmcounterP, 0,           mhpmR,         0,        0             ),
    CSR_ATTR_T__     (vl,           0xC20, ISA_V,       0,          1_10,   0,0,0,0,0,0, 0,                    "Vector Length",                                         0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (vtype,        0xC21, ISA_V,       0,          1_10,   0,0,0,0,0,0, 0,                    "Vector Type",                                           0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (vlenb,        0xC22, ISA_V,       0,          1_10,   0,0,0,0,0,0, 0,                    "Vector Length in Bytes",                                vlenbP,      0,           0,             0,        0             ),
    CSR_ATTR_P__     (cycleh,       0xC80, ISA_32,      0,          1_10,   0,2,0,0,0,0, 0,                    "Cycle Counter High",                                    cycleP,      0,           mcyclehR,      0,        0             ),
    CSR_ATTR_P__     (timeh,        0xC81, ISA_32,      0,          1_10,   0,2,0,0,0,0, 0,                    "Timer High",                                            timeP,       0,           timehR,        0,        0             ),
    CSR_ATTR_P__     (instreth,     0xC82, ISA_32,      0,          1_10,   0,2,0,0,0,0, 0,                    "Instructions Retired High",                             instretP,    0,           minstrethR,    0,        0             ),
    CSR_ATTR_P__3_31 (hpmcounterh,  0xC80, ISA_32,      0,          1_10,   0,0,0,0,0,0, 0,                    "Performance Monitor High ",                             hpmcounterP, 0,           mhpmR,         0,        0             ),

    //                name          num    arch         access      version     attrs    Smstateen             description                                              present      wState       rCB            rwCB      wCB
    CSR_ATTR_P__     (sstatus,      0x100, ISA_S,       0,          1_10,   0,0,0,0,1,1, 0,                    "Supervisor Status",                                     0,           riscvRstFS,  sstatusR,      0,        sstatusW      ),
    CSR_ATTR_TV_     (sedeleg,      0x102, ISA_SandN,   0,          1_10,   0,0,0,0,0,0, 0,                    "Supervisor Exception Delegation",                       0,           0,           sedelegR,      0,        sedelegW      ),
    CSR_ATTR_T__     (sideleg,      0x103, ISA_SandN,   0,          1_10,   1,0,0,0,0,0, 0,                    "Supervisor Interrupt Delegation",                       0,           0,           sidelegR,      0,        sidelegW      ),
    CSR_ATTR_P__     (sie,          0x104, ISA_S,       0,          1_10,   1,0,0,0,1,1, 0,                    "Supervisor Interrupt Enable",                           0,           0,           sieR,          0,        sieW          ),
    CSR_ATTR_T__     (stvec,        0x105, ISA_S,       0,          1_10,   0,0,0,0,0,1, 0,                    "Supervisor Trap-Vector Base-Address",                   0,           0,           stvecR,        0,        stvecW        ),
    CSR_ATTR_TV_     (scounteren,   0x106, ISA_S,       0,          1_10,   0,0,0,0,0,0, 0,                    "Supervisor Counter Enable",                             0,           0,           0,             0,        0             ),
    CSR_ATTR_TV_     (stvt,         0x107, ISA_S,       0,          1_10,   0,0,0,0,0,0, 0,                    "Supervisor CLIC Trap-Vector Base-Address",              clicTVTP,    0,           0,             0,        stvtW         ),
    CSR_ATTR_TV_     (senvcfg,      0x10A, ISA_S,       0,          1_12,   0,0,0,0,0,0, bit_stateen_xenvcfg,  "Supervisor Environment Configuration",                  0,           0,           0,             0,        senvcfgW      ),
    CSR_ATTR_PS_0_3  (sstateen,     0x10C, ISA_S,       0,          1_12,   0,0,0,0,0,0, bit_stateen_xstateen, "Supervisor State Enable ",                              stateenP,    0,           sstateenR,     0,        sstateenW     ),
    CSR_ATTR_P__     (sieh,         0x114, ISA_Sand32,  0,          1_10,   1,0,0,0,1,1, bit_stateen_AIA,      "Supervisor Interrupt Enable High",                      SmaiaP,      0,           siehR,         0,        siehW         ),
    CSR_ATTR_T__     (sscratch,     0x140, ISA_S,       0,          1_10,   0,0,0,0,0,1, 0,                    "Supervisor Scratch",                                    0,           0,           0,             0,        0             ),
    CSR_ATTR_TV_     (sepc,         0x141, ISA_S,       0,          1_10,   0,0,0,0,0,1, 0,                    "Supervisor Exception Program Counter",                  0,           0,           sepcR,         0,        0             ),
    CSR_ATTR_T__     (scause,       0x142, ISA_S,       0,          1_10,   0,0,0,0,0,1, 0,                    "Supervisor Cause",                                      0,           0,           scauseR,       0,        scauseW       ),
    CSR_ATTR_TV_     (stval,        0x143, ISA_S,       0,          1_10,   0,0,0,0,0,1, 0,                    "Supervisor Trap Value",                                 0,           0,           0,             0,        0             ),
    CSR_ATTR_P__     (sip,          0x144, ISA_S,       0,          1_10,   1,0,0,0,1,1, 0,                    "Supervisor Interrupt Pending",                          0,           0,           sipR,          sipRW,    sipW          ),
    CSR_ATTR_P__     (snxti,        0x145, ISA_S,       0,          1_10,   0,0,0,1,1,0, 0,                    "Supervisor Interrupt Handler Address/Enable",           clicNXTP,    0,           snxtiR,        sstatusR, snxtiW        ),
    CSR_ATTR_PS_     (sintstatus,RW,0x146, ISA_S,       0,          1_10,   0,0,0,0,0,0, 0,                    "Supervisor Interrupt Status",                           clicRWP,     0,           sintstatusR,   0,        0             ),
    CSR_ATTR_PS_     (sintstatus,R1,0xD46, ISA_S,       0,          1_10,   0,0,0,0,0,0, 0,                    "Supervisor Interrupt Status",                           clicR1P,     0,           sintstatusR,   0,        0             ),
    CSR_ATTR_PS_     (sintstatus,R2,0xDB1, ISA_S,       0,          1_10,   0,0,0,0,0,0, 0,                    "Supervisor Interrupt Status",                           clicR2P,     0,           sintstatusR,   0,        0             ),
    CSR_ATTR_T__     (sintthresh,   0x147, ISA_S,       0,          1_10,   0,0,0,0,0,0, 0,                    "Supervisor Interrupt Level Threshold",                  clicITP,     0,           0,             0,        sintthreshW   ),
    CSR_ATTR_P__     (sscratchcsw,  0x148, ISA_S,       0,          1_10,   0,0,0,1,1,1, 0,                    "Supervisor Conditional Scratch Swap, Priv",             clicSWP,     0,           sscratchcswR,  0,        sscratchcswW  ),
    CSR_ATTR_P__     (sscratchcswl, 0x149, ISA_S,       0,          1_10,   0,0,0,1,1,1, 0,                    "Supervisor Conditional Scratch Swap, Level",            clicSWP,     0,           sscratchcswlR, 0,        sscratchcswlW ),
    CSR_ATTR_P__     (stimecmp,     0x14D, ISA_S,       0,          1_10,   1,0,0,0,0,1, 0,                    "Supervisor Timer",                                      SstcP,       0,           stimecmpR,     0,        stimecmpW     ),
    CSR_ATTR_T__     (siselect,     0x150, ISA_S,       0,          1_10,   0,0,0,0,0,1, bit_stateen_sireg,    "Supervisor Indirect Register Select",                   SmaiaP,      0,           siselectR,     0,        siselectW     ),
    CSR_ATTR_P__     (sireg,        0x151, ISA_S,       0,          1_10,   0,0,0,0,1,1, bit_stateen_sireg,    "Supervisor Indirect Register Alias",                    SmaiaP,      0,           siregR,        0,        siregW        ),
    CSR_ATTR_P__     (siph,         0x154, ISA_Sand32,  0,          1_10,   1,0,0,0,1,1, bit_stateen_AIA,      "Supervisor Interrupt Pending High",                     SmaiaP,      0,           siphR,         siphRW,   siphW         ),
    CSR_ATTR_P__     (stopei,       0x15C, ISA_S,       0,          1_10,   0,0,0,0,1,1, bit_stateen_IMSIC,    "Supervisor Top External Interrupt",                     SmaiaIMSICP, 0,           stopeiR,       0,        CSRBusW       ),
    CSR_ATTR_PH_     (stimecmp,     0x15D, ISA_S,       0,          1_10,   1,0,0,0,0,1, 0,                    "Supervisor Timer High",                                 SstcP,       0,           stimecmphR,    0,        stimecmphW    ),
    CSR_ATTR_P__     (stopi,        0xDB0, ISA_S,       0,          1_10,   0,0,0,0,0,1, bit_stateen_AIA,      "Supervisor Top Interrupt",                              SmaiaP,      0,           stopiR,        0,        0             ),
    CSR_ATTR_T__     (satp,         0x180, ISA_S,       0,          1_10,   0,0,1,0,0,1, 0,                    "Supervisor Address Translation and Protection",         0,           0,           0,             0,        satpW         ),
#if(ENABLE_SSMPU)
    CSR_ATTR_P__0_15E(mpucfg,       0x1A0, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Memory Protection Unit Configuration ",                 mpucfgP,     0,           mpucfgR,       0,        mpucfgW       ),
    CSR_ATTR_P__0_15O(mpucfg,       0x1A0, ISA_Sand32,  0,          1_10,   0,0,0,0,1,0, 0,                    "Memory Protection Unit Configuration ",                 mpucfgP,     0,           mpucfgR,       0,        mpucfgW       ),
    CSR_ATTR_P__0_63 (mpuaddr,      0x1B0, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Memory Protection Unit Address ",                       mpuaddrP,    0,           mpuaddrR,      0,        mpuaddrW      ),
#endif
    CSR_ATTR_PS_     (sentropy,A,   0xDBF, ISA_SandK,   0,          1_10,   0,1,0,0,1,0, 0,                    "Poll Entropy",                                          sentropyAP,  0,           sentropyR,     0,        0             ),
    CSR_ATTR_PS_     (sentropy,B,   0x546, ISA_SandK,   0,          1_10,   0,1,0,0,1,0, 0,                    "Poll Entropy",                                          sentropyBP,  0,           sentropyRInv,  sentropyR,sentropyW     ),

    //                name          num    arch         access      version     attrs    Smstateen             description                                              present      wState       rCB            rwCB      wCB
    CSR_ATTR_T__     (hstatus,      0x600, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Hypervisor Status",                                     0,           0,           0,             0,        hstatusW      ),
    CSR_ATTR_TV_     (hedeleg,      0x602, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Hypervisor Exception Delegation",                       0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (hideleg,      0x603, ISA_H,       0,          1_10,   1,0,0,0,0,0, 0,                    "Hypervisor Interrupt Delegation",                       0,           0,           hidelegR,      0,        hidelegW      ),
    CSR_ATTR_P__     (hie,          0x604, ISA_H,       0,          1_10,   1,0,0,0,1,0, 0,                    "Hypervisor Interrupt Enable",                           0,           0,           hieR,          0,        hieW          ),
    CSR_ATTR_T__     (htimedelta,   0x605, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Hypervisor Time Delta",                                 0,           0,           0,             0,        htimedeltaW   ),
    CSR_ATTR_TV_     (hcounteren,   0x606, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Hypervisor Counter Enable",                             0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (hgeie,        0x607, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Hypervisor Guest External Interrupt Enable",            0,           0,           0,             0,        hgeieW        ),
    CSR_ATTR_P__     (hvien,        0x608, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_AIA,      "Hypervisor Virtual Interrupt Enable",                   SmaiaP,      0,           hvienR,        0,        hvienW        ),
    CSR_ATTR_TC_     (hvictl,       0x609, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_AIA,      "Hypervisor Virtual Interrupt Control",                  SmaiaP,      0,           0,             0,        hvictlW       ),
    CSR_ATTR_TV_     (henvcfg,      0x60A, ISA_H,       0,          1_12,   0,0,0,0,0,0, bit_stateen_xenvcfg,  "Hypervisor Environment Configuration",                  0,           0,           henvcfgR,      0,        henvcfgW      ),
    CSR_ATTR_PS_0_3  (hstateen,     0x60C, ISA_H,       0,          1_12,   0,0,0,0,0,0, bit_stateen_xstateen, "Hypervisor State Enable ",                              stateenP,    0,           hstateenR,     0,        hstateenW     ),
    CSR_ATTR_P__     (hidelegh,     0x613, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_AIA,      "Hypervisor Interrupt Delegation High",                  SmaiaP,      0,           hideleghR,     0,        hideleghW     ),
    CSR_ATTR_P__     (hvienh,       0x618, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_AIA,      "Hypervisor Virtual Interrupt Enable High",              SmaiaP,      0,           hvienhR,       0,        hvienhW       ),
    CSR_ATTR_PH_     (henvcfg,      0x61A, ISA_H,       0,          1_12,   0,0,0,0,0,0, bit_stateen_xenvcfg,  "Hypervisor Environment Configuration High",             0,           0,           henvcfghR,     0,        henvcfghW     ),
    CSR_ATTR_PHS_0_3 (hstateen,     0x61C, ISA_H,       0,          1_12,   0,0,0,0,0,0, bit_stateen_xstateen, "Hypervisor State Enable High ",                         stateenP,    0,           hstateenhR,    0,        hstateenhW    ),
    CSR_ATTR_TH_     (htimedelta,   0x615, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Hypervisor Time Delta High",                            0,           0,           0,             0,        htimedeltahW  ),
    CSR_ATTR_T__     (htval,        0x643, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Hypervisor Trap Value",                                 0,           0,           0,             0,        0             ),
    CSR_ATTR_P__     (hip,          0x644, ISA_H,       0,          1_10,   0,0,0,0,1,0, 0,                    "Hypervisor Interrupt Pending",                          0,           0,           hipR,          hipRW,    hipW          ),
    CSR_ATTR_P__     (hvip,         0x645, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Hypervisor Virtual Interrupt Pending",                  0,           0,           hvipR,         hvipRW,   hvipW         ),
    CSR_ATTR_P__     (hviprio1,     0x646, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_AIA,      "Hypervisor VS-level Interrupt Priorities 1",            SmaiaP,      0,           hviprio1R,     0,        hviprio1W     ),
    CSR_ATTR_P__     (hviprio2,     0x647, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_AIA,      "Hypervisor VS-level Interrupt Priorities 2",            SmaiaP,      0,           hviprio2R,     0,        hviprio2W     ),
    CSR_ATTR_TV_     (htinst,       0x64A, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Hypervisor Trap Instruction",                           0,           0,           0,             0,        0             ),
    CSR_ATTR_P__     (hviph,        0x655, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_AIA,      "Hypervisor Virtual Interrupt Pending High",             SmaiaP,      0,           hviphR,        0,        hviphW        ),
    CSR_ATTR_P__     (hviprio1h,    0x656, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_AIA,      "Hypervisor VS-level Interrupt Priorities 1 High",       SmaiaP,      0,           hviprio1hR,    0,        hviprio1hW    ),
    CSR_ATTR_P__     (hviprio2h,    0x657, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_AIA,      "Hypervisor VS-level Interrupt Priorities 2 High",       SmaiaP,      0,           hviprio2hR,    0,        hviprio2hW    ),
    CSR_ATTR_T__     (hgatp,        0x680, ISA_H,       0,          1_10,   0,0,1,0,0,0, 0,                    "Hypervisor Guest Address Translation and Protection",   0,           0,           0,             0,        hgatpW        ),
    CSR_ATTR_T__     (hgeip,        0xE12, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Hypervisor Guest External Interrupt Pending",           0,           0,           0,             0,        0             ),
                                                                                           
    //                name          num    arch         access      version     attrs    Smstateen             description                                              present      wState       rCB            rwCB      wCB
    CSR_ATTR_P__     (vsstatus,     0x200, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Virtual Supervisor Status",                             0,           riscvRstFS,  vsstatusR,     0,        vsstatusW     ),
    CSR_ATTR_P__     (vsie,         0x204, ISA_H,       0,          1_10,   1,0,2,0,1,0, 0,                    "Virtual Supervisor Interrupt Enable",                   0,           0,           vsieR,         0,        vsieW         ),
    CSR_ATTR_T__     (vstvec,       0x205, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Virtual Supervisor Trap-Vector Base-Address",           0,           0,           vstvecR,       0,        vstvecW       ),
    CSR_ATTR_P__     (vsieh,        0x214, ISA_H,       0,          1_10,   1,0,2,0,1,0, bit_stateen_AIA,      "Virtual Supervisor Interrupt Enable High",              SmaiaP,      0,           vsiehR,        0,        vsiehW        ),
    CSR_ATTR_T__     (vsscratch,    0x240, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Virtual Supervisor Scratch",                            0,           0,           0,             0,        0             ),
    CSR_ATTR_TV_     (vsepc,        0x241, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Virtual Supervisor Exception Program Counter",          0,           0,           vsepcR,        0,        0             ),
    CSR_ATTR_T__     (vscause,      0x242, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Virtual Supervisor Cause",                              0,           0,           0,             0,        0             ),
    CSR_ATTR_TV_     (vstval,       0x243, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Virtual Supervisor Trap Value",                         0,           0,           0,             0,        0             ),
    CSR_ATTR_P__     (vsip,         0x244, ISA_H,       0,          1_10,   1,0,2,0,1,0, 0,                    "Virtual Supervisor Interrupt Pending",                  0,           0,           vsipR,         vsipRW,   vsipW         ),
    CSR_ATTR_P__     (vsscratchcsw, 0x248, ISA_H,       0,          1_10,   0,0,0,1,1,0, 0,                    "Virtual Supervisor Conditional Scratch Swap, Priv",     clicSWP,     0,           vsscratchcswR, 0,        vsscratchcswW ),
    CSR_ATTR_P__     (vsscratchcswl,0x249, ISA_H,       0,          1_10,   0,0,0,1,1,0, 0,                    "Virtual Supervisor Conditional Scratch Swap, Level",    clicSWP,     0,           vsscratchcswlR,0,        vsscratchcswlW),
    CSR_ATTR_P__     (vstimecmp,    0x24D, ISA_H,       0,          1_10,   1,0,0,0,0,0, 0,                    "Virtual Supervisor Timer",                              SstcP,       0,           vstimecmpR,    0,        vstimecmpW    ),
    CSR_ATTR_T__     (vsiselect,    0x250, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_sireg,    "Virtual Supervisor Indirect Register Select",           SmaiaP,      0,           vsiselectR,    0,        vsiselectW    ),
    CSR_ATTR_P__     (vsireg,       0x251, ISA_H,       0,          1_10,   0,0,0,0,1,0, bit_stateen_sireg,    "Virtual Supervisor Indirect Register Alias",            SmaiaP,      0,           vsiregR,       0,        vsiregW       ),
    CSR_ATTR_P__     (vsiph,        0x254, ISA_H,       0,          1_10,   1,0,2,0,1,0, bit_stateen_AIA,      "Virtual Supervisor Interrupt Enable High",              SmaiaP,      0,           vsiphR,        vsiphRW,  vsiphW        ),
    CSR_ATTR_P__     (vstopei,      0x25C, ISA_H,       0,          1_10,   0,0,0,0,1,0, bit_stateen_IMSIC,    "Virtual Supervisor Top External Interrupt",             SmaiaIMSICP, 0,           vstopeiR,      0,        CSRBusW       ),
    CSR_ATTR_PH_     (vstimecmp,    0x25D, ISA_H,       0,          1_10,   1,0,0,0,0,0, 0,                    "Virtual Supervisor Timer High",                         SstcP,       0,           vstimecmphR,   0,        vstimecmphW   ),
    CSR_ATTR_P__     (vstopi,       0xEB0, ISA_H,       0,          1_10,   0,0,0,0,0,0, bit_stateen_AIA,      "Virtual Supervisor Top Interrupt",                      SmaiaP,      0,           vstopiR,       0,        0             ),
    CSR_ATTR_T__     (vsatp,        0x280, ISA_H,       0,          1_10,   0,0,1,0,0,0, 0,                    "Virtual Supervisor Address Translation and Protection", 0,           0,           0,             0,        vsatpW        ),
                                                                                           
    //                name          num    arch         access      version     attrs    Smstateen             description                                              present      wState       rCB            rwCB      wCB
    CSR_ATTR_T__     (mvendorid,    0xF11, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Vendor ID",                                             0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (marchid,      0xF12, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Architecture ID",                                       0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (mimpid,       0xF13, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Implementation ID",                                     0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (mhartid,      0xF14, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Hardware Thread ID",                                    0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (mconfigptr,   0xF15, 0,           0,          1_12,   0,0,0,0,0,0, 0,                    "Configuration Data Structure",                          0,           0,           0,             0,        0             ),
    CSR_ATTR_P__     (mentropy,     0xF15, ISA_K,       0,          1_10,   0,1,0,0,1,0, 0,                    "Poll Entropy",                                          mentropyP,   0,           mentropyR,     0,        0             ),
    CSR_ATTR_TV_     (mstatus,      0x300, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Status",                                        0,           riscvRstFS,  mstatusR,      0,        mstatusW      ),
    CSR_ATTR_T__     (misa,         0x301, 0,           0,          1_10,   1,0,0,0,0,0, 0,                    "ISA and Extensions",                                    0,           0,           misaR,         0,        misaW         ),
    CSR_ATTR_TV_     (medeleg,      0x302, ISA_SorN,    0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Exception Delegation",                          0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (mideleg,      0x303, ISA_SorN,    0,          1_10,   1,0,0,0,0,0, 0,                    "Machine Interrupt Delegation",                          0,           0,           0,             0,        midelegW      ),
    CSR_ATTR_T__     (mie,          0x304, 0,           0,          1_10,   1,0,0,0,0,0, 0,                    "Machine Interrupt Enable",                              0,           0,           mieR,          0,        mieW          ),
    CSR_ATTR_T__     (mtvec,        0x305, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Trap-Vector Base-Address",                      0,           0,           0,             0,        mtvecW        ),
    CSR_ATTR_TV_     (mcounteren,   0x306, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Counter Enable",                                mcounterenP, 0,           0,             0,        0             ),
    CSR_ATTR_TV_     (mtvt,         0x307, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine CLIC Trap-Vector Base-Address",                 clicTVTP,    0,           0,             0,        mtvtW         ),
    CSR_ATTR_P__     (mvien,        0x308, ISA_S,       0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Virtual Interrupt Enable",                      SmaiaP,      0,           mvienR,        0,        mvienW        ),
    CSR_ATTR_P__     (mvip,         0x309, ISA_S,       0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Virtual Interrupt Pending",                     SmaiaP,      0,           mvipR,         0,        mvipW         ),
    CSR_ATTR_TV_     (menvcfg,      0x30A, ISA_U,       0,          1_12,   0,0,0,0,0,0, 0,                    "Machine Environment Configuration",                     0,           0,           0,             0,        menvcfgW      ),
    CSR_ATTR_P__0_3  (mstateen,     0x30C, ISA_U,       0,          1_12,   0,0,0,0,0,0, 0,                    "Machine State Enable ",                                 stateenP,    0,           mstateenR,     0,        mstateenW     ),
    CSR_ATTR_P__     (mstatush,     0x310, ISA_32,      0,          1_12,   0,0,0,0,0,0, 0,                    "Machine Status High",                                   0,           0,           mstatushR,     0,        mstatushW     ),
    CSR_ATTR_P__     (midelegh,     0x313, ISA_Sand32,  0,          1_10,   1,0,0,0,0,0, 0,                    "Machine Interrupt Delegation High",                     SmaiaP,      0,           mideleghR,     0,        mideleghW     ),
    CSR_ATTR_P__     (mieh,         0x314, ISA_32,      0,          1_10,   1,0,0,0,0,0, 0,                    "Machine Interrupt Enable High",                         SmaiaP,      0,           miehR,         0,        miehW         ),
    CSR_ATTR_P__     (mvienh,       0x318, ISA_Sand32,  0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Virtual Interrupt Enable High",                 SmaiaP,      0,           mvienhR,       0,        mvienhW       ),
    CSR_ATTR_P__     (mviph,        0x319, ISA_Sand32,  0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Virtual Interrupt Pending High",                SmaiaP,      0,           mviphR,        0,        mviphW        ),
    CSR_ATTR_TH_     (menvcfg,      0x31A, ISA_U,       0,          1_12,   0,0,0,0,0,0, 0,                    "Machine Environment Configuration High",                0,           0,           0,             0,        menvcfghW    ),
    CSR_ATTR_PH_0_3  (mstateen,     0x31C, ISA_U,       0,          1_12,   0,0,0,0,0,0, 0,                    "Machine State Enable High ",                            stateenP,    0,           mstateenhR,    0,        mstateenhW    ),
    CSR_ATTR_TV_     (mcountinhibit,0x320, 0,           0,          1_11,   0,0,0,0,0,0, 0,                    "Machine Counter Inhibit",                               0,           0,           0,             0,        mcountinhibitW),
    CSR_ATTR_T__     (mscratch,     0x340, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Scratch",                                       0,           0,           0,             0,        0             ),
    CSR_ATTR_TV_     (mepc,         0x341, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Exception Program Counter",                     0,           0,           mepcR,         0,        0             ),
    CSR_ATTR_T__     (mcause,       0x342, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Cause",                                         0,           0,           mcauseR,       0,        mcauseW       ),
    CSR_ATTR_TV_     (mtval,        0x343, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Trap Value",                                    0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (mip,          0x344, 0,           0,          1_10,   1,0,0,0,0,0, 0,                    "Machine Interrupt Pending",                             0,           0,           mipR,          mipRW,    mipW          ),
    CSR_ATTR_P__     (mnxti,        0x345, 0,           0,          1_10,   0,0,0,1,1,0, 0,                    "Machine Interrupt Handler Address/Enable",              clicNXTP,    0,           mnxtiR,        mstatusR, mnxtiW        ),
    CSR_ATTR_TCS     (mintstatus,RW,0x346, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Interrupt Status",                              clicRWP,     0,           0,             0,        0             ),
    CSR_ATTR_TCS     (mintstatus,R1,0xF46, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Interrupt Status",                              clicR1P,     0,           0,             0,        0             ),
    CSR_ATTR_TCS     (mintstatus,R2,0xFB1, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Interrupt Status",                              clicR2P,     0,           0,             0,        0             ),
    CSR_ATTR_T__     (mintthresh,   0x347, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Interrupt Level Threshold",                     clicITP,     0,           0,             0,        mintthreshW   ),
    CSR_ATTR_P__     (mscratchcsw,  0x348, ISA_U,       0,          1_10,   0,0,0,1,1,0, 0,                    "Machine Conditional Scratch Swap, Priv",                clicSWP,     0,           mscratchcswR,  0,        mscratchcswW  ),
    CSR_ATTR_P__     (mscratchcswl, 0x349, 0,           0,          1_10,   0,0,0,1,1,0, 0,                    "Machine Conditional Scratch Swap, Level",               clicSWP,     0,           mscratchcswlR, 0,        mscratchcswlW ),
    CSR_ATTR_TV_     (mtinst,       0x34A, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Trap Instruction",                              0,           0,           0,             0,        0             ),
    CSR_ATTR_P__     (mclicbase,    0x34B, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine CLIC Base Address",                             clicMCBP,    0,           mclicbaseR,    0,        mclicbaseW    ),
    CSR_ATTR_T__     (mtval2,       0x34B, ISA_H,       0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Second Trap Value",                             0,           0,           0,             0,        0             ),
    CSR_ATTR_T__     (miselect,     0x350, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Indirect Register Select",                      SmaiaP,      0,           0,             0,        miselectW     ),
    CSR_ATTR_TS_     (mnscratch,21, 0x350, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine RNMI Scratch",                                  rnmi021P,    0,           0,             0,        0             ),
    CSR_ATTR_P__     (mireg,        0x351, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Machine Indirect Register Alias",                       SmaiaP,      0,           miregR,        0,        miregW        ),
    CSR_ATTR_TVS     (mnepc,21,     0x351, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine RNMI Program Counter",                          rnmi021P,    0,           mnepcR,        0,        0             ),
    CSR_ATTR_TS_     (mncause,21,   0x352, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine RNMI Cause",                                    rnmi021P,    0,           mncauseR,      0,        mncauseW      ),
    CSR_ATTR_TS_     (mnstatus,21,  0x353, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine RNMI Status",                                   rnmi021P,    0,           mnstatus021R,  0,        mnstatusW     ),
    CSR_ATTR_P__     (miph,         0x354, ISA_32,      0,          1_10,   1,0,0,0,0,0, 0,                    "Machine Interrupt Pending High",                        SmaiaP,      0,           miphR,         miphRW,   miphW         ),
    CSR_ATTR_P__     (mtopei,       0x35C, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Machine Top External Interrupt",                        SmaiaIMSICP, 0,           mtopeiR,       0,        CSRBusW       ),
    CSR_ATTR_P__     (mtopi,        0xFB0, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Top Interrupt",                                 SmaiaP,      0,           mtopiR,        0,        0             ),
    CSR_ATTR_TS_     (mnscratch,4,  0x740, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine RNMI Scratch",                                  rnmi04P,     0,           0,             0,        0             ),
    CSR_ATTR_TVS     (mnepc,4,      0x741, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine RNMI Program Counter",                          rnmi04P,     0,           mnepcR,        0,        0             ),
    CSR_ATTR_TS_     (mncause,4,    0x742, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine RNMI Cause",                                    rnmi04P,     0,           mncauseR,      0,        mncauseW      ),
    CSR_ATTR_TS_     (mnstatus,4,   0x744, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine RNMI Status",                                   rnmi04P,     0,           0,             0,        mnstatusW     ),
    CSR_ATTR_TV_     (mseccfg,      0x747, 0,           0,          1_12,   0,0,0,0,0,0, 0,                    "Machine Secure Configuration",                          mseccfgP,    0,           0,             0,        mseccfgW      ),
    CSR_ATTR_TVH     (mseccfg,      0x757, 0,           0,          1_12,   0,0,0,0,0,0, 0,                    "Machine Secure Configuration High",                     mseccfgP                                                         ),
    CSR_ATTR_TC_     (mnoise,       0x7A9, ISA_K,       0,          1_10,   0,0,0,0,0,0, 0,                    "GetNoise Test Interface",                               mnoiseP,     0,           0,             0,        0             ),

    //                name          num    arch         access      version     attrs    Smstateen             description                                              present      wState       rCB            rwCB      wCB
    CSR_ATTR_P__0_15E(pmpcfg,       0x3A0, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Physical Memory Protection Configuration ",             pmpcfgP,     0,           pmpcfgR,       0,        pmpcfgW       ),
    CSR_ATTR_P__0_15O(pmpcfg,       0x3A0, ISA_32,      0,          1_10,   0,0,0,0,1,0, 0,                    "Physical Memory Protection Configuration ",             pmpcfgP,     0,           pmpcfgR,       0,        pmpcfgW       ),
    CSR_ATTR_P__0_63 (pmpaddr,      0x3B0, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Physical Memory Protection Address ",                   pmpaddrP,    0,           pmpaddrR,      0,        pmpaddrW      ),
                                                                                           
    //                name          num    arch         access      version     attrs    Smstateen             description                                              present      wState       rCB            rwCB      wCB
    CSR_ATTR_P__     (mcycle,       0xB00, 0,           0,          1_10,   0,2,0,0,0,0, 0,                    "Machine Cycle Counter",                                 mcycleP,     0,           mcycleR,       0,        mcycleW       ),
    CSR_ATTR_P__     (minstret,     0xB02, 0,           0,          1_10,   0,2,0,0,0,0, 0,                    "Machine Instructions Retired",                          minstretP,   0,           minstretR,     0,        minstretW     ),
    CSR_ATTR_P__3_31 (mhpmcounter,  0xB00, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Performance Monitor Counter ",                  mhpmcounterP,0,           mhpmR,         0,        mhpmW         ),
    CSR_ATTR_P__     (mcycleh,      0xB80, ISA_32,      0,          1_10,   0,2,0,0,0,0, 0,                    "Machine Cycle Counter High",                            mcycleP,     0,           mcyclehR,      0,        mcyclehW      ),
    CSR_ATTR_P__     (minstreth,    0xB82, ISA_32,      0,          1_10,   0,2,0,0,0,0, 0,                    "Machine Instructions Retired High",                     minstretP,   0,           minstrethR,    0,        minstrethW    ),
    CSR_ATTR_P__3_31 (mhpmcounterh, 0xB80, ISA_32,      0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Performance Monitor Counter High ",             mhpmcounterP,0,           mhpmR,         0,        mhpmW         ),
    CSR_ATTR_P__3_31 (mhpmevent,    0x320, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Machine Performance Monitor Event Select ",             mhpmcounterP,0,           mhpmR,         0,        mhpmW         ),
                                                                                           
    //                name          num    arch         access      version     attrs    Smstateen             description                                              present      wState       rCB            rwCB      wCB
    CSR_ATTR_T__     (tselect,      0x7A0, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Trigger Register Select",                               triggerP,    0,           0,             0,        tselectW      ),
    CSR_ATTR_P__     (tdata1,       0x7A1, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Trigger Data 1",                                        triggerP,    0,           tdata1R,       0,        tdata1W       ),
    CSR_ATTR_P__     (tdata2,       0x7A2, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Trigger Data 2",                                        tdata2P,     0,           tdata2R,       0,        tdata2W       ),
    CSR_ATTR_P__     (tdata3,       0x7A3, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Trigger Data 3",                                        tdata3P,     0,           tdata3R,       0,        tdata3W       ),
    CSR_ATTR_P__     (tinfo,        0x7A4, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Trigger Info",                                          tinfoP,      0,           tinfoR,        0,        0             ),
    CSR_ATTR_TV_     (tcontrol,     0x7A5, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Trigger Control",                                       tcontrolP,   0,           0,             0,        0             ),
    CSR_ATTR_P__     (mcontext,     0x7A8, 0,           0,          1_10,   0,0,0,0,1,0, 0,                    "Trigger Machine Context",                               mcontextP,   0,           mcontextR,     0,        mcontextW     ),
    CSR_ATTR_P__     (mscontext,    0x7AA, 0,           ISA_S,      1_10,   0,0,0,0,1,0, 0,                    "Trigger Machine Context Alias",                         mscontextP,  0,           scontextR,     0,        scontextW     ),
    CSR_ATTR_PS_     (scontext,13,  0x7AA, 0,           ISA_S,      1_10,   0,0,0,0,1,0, 0,                    "Trigger Supervisor Context",                            scontext13P, 0,           scontextR,     0,        scontextW     ),
    CSR_ATTR_PS_     (scontext,14,  0x5A8, 0,           0,          1_10,   0,0,0,0,1,0, bit_stateen_xcse,     "Trigger Supervisor Context",                            scontext14P, 0,           scontextR,     0,        scontextW     ),
    CSR_ATTR_P__     (hcontext,     0x6A8, ISA_H,       0,          1_10,   0,0,0,0,1,0, bit_stateen_xcse,     "Trigger Hypervisor Context",                            hcontextP,   0,           hcontextR,     0,        hcontextW     ),

    //                name          num    arch         access      version     attrs    Smstateen             description                                              present      wState       rCB            rwCB      wCB
    CSR_ATTR_TV_     (dcsr,         0x7B0, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Debug Control and Status",                              debugP,      0,           0,             0,        dcsrW         ),
    CSR_ATTR_TV_     (dpc,          0x7B1, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Debug PC",                                              debugP,      0,           dpcR,          0,        0             ),
    CSR_ATTR_T__     (dscratch0,    0x7B2, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Debug Scratch 0",                                       dscratch0P,  0,           0,             0,        0             ),
    CSR_ATTR_T__     (dscratch1,    0x7B3, 0,           0,          1_10,   0,0,0,0,0,0, 0,                    "Debug Scratch 1",                                       dscratch1P,  0,           0,             0,        0             ),
};


////////////////////////////////////////////////////////////////////////////////
// CSR ALIAS SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Specify alias address for CSR
//
typedef struct riscvCSRRemapS {
    riscvCSRRemapP next;        // next in list
    const char    *name;        // CSR name
    Uns32          csrNum : 12; // index number
} riscvCSRRemap;

//
// Return register number for CSR, perhaps modified by remap
//
static Uns32 getCSRNum(riscvP riscv, riscvCSRAttrsCP attrs) {

    Uns32          result = attrs->csrNum;
    riscvCSRRemapP remap;

    for(remap=riscv->csrRemap; remap; remap=remap->next) {
        if(!strcmp(attrs->name, remap->name)) {
            result = remap->csrNum;
        }
    }

    return result;
}

//
// Allocate CSR remap list
//
void riscvNewCSRRemaps(riscvP riscv, const char *remaps) {

    if(remaps && remaps[0]) {

        Uns32 numRemaps = 0;
        Uns32 i, j;
        char  ch;
        char  tmp[strlen(remaps)+1];

        // copy given aliases to temporary buffer, stripping whitespace
        // characters and replacing commas with zeros (to tokenize the string)
        for(i=0, j=0; (ch=remaps[i]); i++) {

            switch(ch) {

                case ' ':
                case '\t':
                    // strip whitespace
                    break;

                case ',':
                    // replace ',' with zero, suppressing null entries
                    if(j && tmp[j-1]) {
                        tmp[j++] = 0;
                        numRemaps++;
                    }
                    break;

                default:
                    // copy character to result string
                    tmp[j++] = ch;
                    break;
            }
        }

        // terminate last token
        if(j && tmp[j-1]) {
            tmp[j++] = 0;
            numRemaps++;
        }

        char           *buffer = tmp;
        riscvCSRRemapPP tail   = &riscv->csrRemap;

        // handle each remap
        for(i=0; i<numRemaps; i++) {

            Uns32 remapLen = strlen(buffer)+1;
            char  csrName[remapLen];

            // copy name to temporary buffer
            for(j=0; (ch=buffer[j]) && (ch!='='); j++) {
                csrName[j] = ch;
            }

            // terminate string
            csrName[j] = 0;

            if(ch) {

                // terminate string
                Uns32 csrNum = strtol(buffer+j+1, 0, 0);

                riscvCSRRemapP remap = STYPE_CALLOC(riscvCSRRemap);

                remap->name   = strdup(csrName);
                remap->csrNum = csrNum;

                *tail = remap;
                tail = &remap->next;
            }

            buffer += remapLen;
        }
    }
}

//
// Free CSR alias list
//
static void freeCSRRemap(riscvP riscv) {

    riscvCSRRemapP alias;

    while((alias=riscv->csrRemap)) {
        riscv->csrRemap = alias->next;
        STYPE_FREE(alias->name);
        STYPE_FREE(alias);
    }
}


////////////////////////////////////////////////////////////////////////////////
// REGISTER ACCESS UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Return riscvCSRId for riscvCSRAttrsCP
//
static riscvCSRId getCSRId(riscvCSRAttrsCP attrs) {

    return attrs - csrs;
}

//
// Return read/write access constraints for the register (determined by address
// in the base model, but also allow write access if a write callback is
// specified for a register in a normally read-only location by a custom
// extension)
//
static vmiRegAccess getAccess(riscvCSRAttrsCP attrs) {

    CSRFields fields = {attrs->csrNum};

    return (fields.access==3) && !attrs->writeCB ? vmi_RA_R : vmi_RA_RW;
}

//
// Validate the CSR is implemented if a CSR-specific presence callback is given
//
static Bool checkCSRImplemented(riscvCSRAttrsCP attrs, riscvP riscv) {

    return !attrs->presentCB || attrs->presentCB(attrs, riscv);
}

//
// Return the features required for access to the given CSR
//
static riscvArchitecture getRequiredCSRFeatures(
    riscvCSRAttrsCP attrs,
    riscvP          riscv
) {
    riscvArchitecture required = attrs->arch;

    if((required==ISA_DFV) && !vxFieldsInFCSR(riscv)) {
        required &= ~ISA_V;
    }

    return required;
}

//
// If the CSR is not supported, return a bitmask of required-but-absent features
//
static riscvArchitecture getMissingCSRFeatures(
    riscvCSRAttrsCP   attrs,
    riscvP            riscv,
    riscvArchitecture required,
    riscvArchitecture actual
) {
    if(required & ISA_and) {

        // all specified features are required
        riscvArchitecture missing = required & ~(actual|ISA_and);
        return missing ?  (missing|ISA_and) : 0;

    } else {

        // one or more of the specified features is required
        return !(actual & required) ? required : 0;
    }
}

//
// Do full check for CSR presence
//
static Bool checkCSRPresent(riscvCSRAttrsCP attrs, riscvP riscv) {

    riscvArchitecture required = getRequiredCSRFeatures(attrs, riscv);
    riscvArchitecture actual   = riscv->configInfo.arch & ~ISA_XLEN_ANY;
    riscvMode         mode     = getCSRMode4(attrs, riscv);

    // include XLEN indication for CSR mode
    if(riscvHasXLEN32(riscv, mode)) {
        actual |= ISA_XLEN_32;
    }
    if(riscvHasXLEN64(riscv, mode)) {
        actual |= ISA_XLEN_64;
    }

    return (
        (!getMissingCSRFeatures(attrs, riscv, required, actual)) &&
        checkCSRImplemented(attrs, riscv)
    );
}

//
// Return raw register to be used for value access
//
inline static vmiReg getRawArch(riscvCSRAttrsCP attrs, riscvArchitecture arch) {
    return attrs->reg;
}

//
// Return constant write mask for the register
//
inline static Uns64 getWriteMaskCArch(riscvCSRAttrsCP attrs, riscvArchitecture arch) {
    return (arch&ISA_XLEN_64) ? attrs->writeMaskC64 : attrs->writeMaskC32;
}

//
// Return configurable write mask for the register
//
inline static vmiReg getWriteMaskVArch(riscvCSRAttrsCP attrs, riscvArchitecture arch) {
    return attrs->writeMaskV;
}

//
// Get pointer to plain register value in processor structure
//
inline static void *getVMIRegValue(vmiReg reg, riscvP riscv) {
    return VMI_ISNOREG(reg) ? 0 : ((Uns8 *)riscv) + reg.index;
}

//
// Get pointer to Uns32 plain register value in processor structure
//
inline static Uns32 *getVMIRegValue32(vmiReg reg, riscvP riscv) {
    return getVMIRegValue(reg, riscv);
}

//
// Get pointer to Uns64 plain register value in processor structure
//
inline static Uns64 *getVMIRegValue64(vmiReg reg, riscvP riscv) {
    return getVMIRegValue(reg, riscv);
}

//
// Get pointer to plain CSR value in processor structure
//
static void *getCSRRegValue(riscvCSRAttrsCP attrs, riscvP riscv) {

    riscvArchitecture arch = riscv->configInfo.arch;
    vmiReg            reg  = getRawArch(attrs, arch);

    return getVMIRegValue(reg, riscv);
}

//
// Return 32-bit CSR write mask
//
static Uns32 getCSRWriteMask32(riscvCSRAttrsCP attrs, riscvP riscv) {

    vmiReg writeMaskV = attrs->writeMaskV;

    if(VMI_ISNOREG(writeMaskV)) {
        return attrs->writeMaskC32;
    } else {
        return *getVMIRegValue32(writeMaskV, riscv);
    }
}

//
// Return 64-bit CSR write mask
//
static Uns64 getCSRWriteMask64(riscvCSRAttrsCP attrs, riscvP riscv) {

    vmiReg writeMaskV = attrs->writeMaskV;

    if(VMI_ISNOREG(writeMaskV)) {
        return attrs->writeMaskC64;
    } else {
        return *getVMIRegValue64(writeMaskV, riscv);
    }
}

//
// Return Uns64 CSR write mask for the current processor state
//
static Uns64 getCSRWriteMask(riscvCSRAttrsCP attrs, riscvP riscv) {

    if(RISCV_XLEN_IS_32M(riscv, getCSRMode5(attrs, riscv))) {
        return getCSRWriteMask32(attrs, riscv);
    } else {
        return getCSRWriteMask64(attrs, riscv);
    }
}

//
// Return riscvCSRAttrsCP got table entry
//
inline static riscvCSRAttrsCP getEntryCSRAttrs(vmiRangeEntryP entry) {

    riscvCSRAttrsCP result = 0;

    if(entry) {
        result = (riscvCSRAttrsCP)(UnsPS)vmirtGetRangeEntryUserData(entry);
    }

    return result;
}

//
// Register new CSR
//
static void newCSR(riscvCSRAttrsCP attrs, riscvP riscv, Bool replace) {

    if(!riscv->configInfo.noZicsr) {

        Uns32           csrNum  = getCSRNum(riscv, attrs);
        vmiRangeTablePP tableP  = &riscv->csrTable;
        vmiRangeEntryP  entry   = vmirtGetFirstRangeEntry(tableP, csrNum, csrNum);
        Bool            present = checkCSRPresent(attrs, riscv);

        // if entries conflict, either replace with the new entry or select the
        // last configured entry
        if(!entry) {
            entry = vmirtInsertRangeEntry(tableP, csrNum, csrNum, 0);
        } else if(replace) {
            // replace any conflicting entry
        } else if(!present) {
            return;
        }

        // register Sstateen bit if required
        if(present) {
            registerStateenBit(riscv, attrs);
        }

        // register attributes and entry
        vmirtSetRangeEntryUserData(entry, (UnsPS)attrs);
    }
}

//
// Undefine CSR in derived model
//
static void undefineCSR(riscvCSRAttrsCP attrs, riscvP riscv) {

    Uns32           csrNum = getCSRNum(riscv, attrs);
    vmiRangeTablePP tableP = &riscv->csrTable;
    vmiRangeEntryP  entry  = vmirtGetFirstRangeEntry(tableP, csrNum, csrNum);

    if(entry) {
        vmirtRemoveRangeEntry(tableP, entry);
    }
}

//
// Adjust the given vmiReg for a register in the extension object so that it
// can be accessed from the processor
//
static vmiReg getObjectReg(riscvP riscv, vmiosObjectP object, vmiReg reg) {

    UnsPS delta = (UnsPS)object - (UnsPS)riscv;

    return VMI_REG_DELTA(reg, delta);
}

//
// Register new externally-implemented CSR
//
void riscvNewCSR(
    riscvCSRAttrsP  attrs,
    riscvCSRAttrsCP src,
    riscvP          riscv,
    vmiosObjectP    object
) {
    if(!src || !src->name) {

        // no action

    } else if(src->undefined) {

        // remove CSR defined in base model
        undefineCSR(src, riscv);

    } else {

        // fill attributes from template
        *attrs = *src;

        // save client object
        attrs->object = object;

        // adjust any vmiReg offsets to include object offset
        attrs->reg        = getObjectReg(riscv, object, attrs->reg);
        attrs->writeMaskV = getObjectReg(riscv, object, attrs->writeMaskV);

        newCSR(attrs, riscv, True);
    }
}

//
// Return CSR attributes for the given CSR index
//
static riscvCSRAttrsCP getCSRAttrs(riscvP riscv, Uns32 csrNum) {

    vmiRangeTablePP tableP = &riscv->csrTable;
    vmiRangeEntryP  entry  = vmirtGetFirstRangeEntry(tableP, csrNum, csrNum);

    return getEntryCSRAttrs(entry);
}

//
// Return the next CSR in index order given the previous one
//
static riscvCSRAttrsCP getNextCSR(riscvP riscv, Uns32 *csrNumP) {

    Uns32           csrNum = *csrNumP;
    vmiRangeTablePP tableP = &riscv->csrTable;
    vmiRangeEntryP  entry  = vmirtGetFirstRangeEntry(tableP, csrNum, -1);

    // seed next CSR index to try
    *csrNumP = (entry ? vmirtGetRangeEntryLow(entry) : csrNum) + 1;

    return getEntryCSRAttrs(entry);
}


////////////////////////////////////////////////////////////////////////////////
// IMPLEMENTING CSR REGISTERS USING ARTIFACT BUS
////////////////////////////////////////////////////////////////////////////////

//
// Return memory attributes for artifact CSR bus access
//
inline static memAccessAttrs getCSRMemAttrs(riscvP riscv) {
    return riscv->artifactAccess ? MEM_AA_FALSE : MEM_AA_TRUE;
}

//
// Return address for artifact CSR bus access
//
inline static Uns32 getCSRBusAddress(riscvCSRAttrsCP attrs) {
    return attrs->csrNum << 4;
}

//
// Do externally-implemented 32-bit CSR read
//
static RISCV_CSR_READFN(csrExternalRead32) {

    memDomainP     domain   = riscvGetExternalCSRDomain(riscv);
    memEndian      endian   = MEM_ENDIAN_LITTLE;
    memAccessAttrs memAttrs = getCSRMemAttrs(riscv);
    Uns32          address  = getCSRBusAddress(attrs);

    riscv->externalActive = True;

    // do read from external system domain
    Uns32 result = vmirtRead4ByteDomain(domain, address, endian, memAttrs);

    riscv->externalActive = False;

    // return new value
    return result;
}

//
// Do externally-implemented 32-bit CSR write
//
static RISCV_CSR_WRITEFN(csrExternalWrite32) {

    memDomainP     domain   = riscvGetExternalCSRDomain(riscv);
    memEndian      endian   = MEM_ENDIAN_LITTLE;
    memAccessAttrs memAttrs = getCSRMemAttrs(riscv);
    Uns32          address  = getCSRBusAddress(attrs);

    riscv->externalActive = True;

    // do write to external system domain
    vmirtWrite4ByteDomain(domain, address, endian, newValue, memAttrs);

    // get new value
    Uns32 result = vmirtRead4ByteDomain(domain, address, endian, MEM_AA_FALSE);

    riscv->externalActive = False;

    // return new value
    return result;
}

//
// Do externally-implemented 64-bit CSR read
//
static RISCV_CSR_READFN(csrExternalRead64) {

    memDomainP     domain   = riscvGetExternalCSRDomain(riscv);
    memEndian      endian   = MEM_ENDIAN_LITTLE;
    memAccessAttrs memAttrs = getCSRMemAttrs(riscv);
    Uns32          address  = getCSRBusAddress(attrs);

    riscv->externalActive = True;

    // do read from external system domain
    Uns64 result = vmirtRead8ByteDomain(domain, address, endian, memAttrs);

    riscv->externalActive = False;

    // return new value
    return result;
}

//
// Do externally-implemented 64-bit CSR write
//
static RISCV_CSR_WRITEFN(csrExternalWrite64) {

    memDomainP     domain   = riscvGetExternalCSRDomain(riscv);
    memEndian      endian   = MEM_ENDIAN_LITTLE;
    memAccessAttrs memAttrs = getCSRMemAttrs(riscv);
    Uns32          address  = getCSRBusAddress(attrs);

    riscv->externalActive = True;

    // do write to external system domain
    vmirtWrite8ByteDomain(domain, address, endian, newValue, memAttrs);

    // get new value
    Uns64 result = vmirtRead8ByteDomain(domain, address, endian, MEM_AA_FALSE);

    riscv->externalActive = False;

    // return new value
    return result;
}

//
// Is the CSR implemented externally for the required access type?
//
static Bool csrImplementExternal(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    memPriv         priv
) {
    memDomainP domain = riscvGetExternalCSRDomain(riscv);

    if(riscv->externalActive) {

        // don't nest external access calls (assume that a nested read or write
        // should instead access the register inside the model)
        return False;

    } else if(domain) {

        Uns32 address = getCSRBusAddress(attrs);

        if(!vmirtGetDomainMapped(domain, address, address)) {
            return False;
        } else {
            return (vmirtGetDomainPrivileges(domain, address) & priv) && True;
        }

    } else {

        return False;
    }
}

//
// Is the CSR implemented externally for read?
//
// NOTE: if this is a CSR with read/write semantics but only *read* access is
// externally implemented then:
//
// 1. For true accesses (csrr) the *external* CSR value should be returned;
// 2. For artifact accesses (trace, debug interface read/write) the *internal*
//    CSR value should be returned.
//
// This allows a test harness to inject a volatile apparent value for a CSR when
// it is read without affecting the underlying model behavior in any other way.
//
// Parameter 'rwOnly' indicates whether the external callback should be used
// only if both read and write callbacks are specified
//
Bool riscvCSRImplementExternalRead(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    Bool            rwOnly
) {
    if(!csrImplementExternal(attrs, riscv, MEM_PRIV_R)) {
        return False;
    } else if(!rwOnly || (getAccess(attrs)==vmi_RA_R)) {
        return True;
    } else {
        return csrImplementExternal(attrs, riscv, MEM_PRIV_W);
    }
}

//
// Is the CSR implemented externally for write?
//
Bool riscvCSRImplementExternalWrite(riscvCSRAttrsCP attrs, riscvP riscv) {
    return csrImplementExternal(attrs, riscv, MEM_PRIV_W);
}

//
// Return callback for read of externally-implemented CSR
//
inline static riscvCSRReadFn getCSRExternalReadCB(Uns32 bits) {
    return (bits==32) ? csrExternalRead32 : csrExternalRead64;
}

//
// Return callback for write of externally-implemented CSR
//
inline static riscvCSRWriteFn getCSRExternalWriteCB(Uns32 bits) {
    return (bits==32) ? csrExternalWrite32 : csrExternalWrite64;
}

//
// Return any callback implementing a read of the CSR externally
//
static riscvCSRReadFn getCSRReadCB(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    Uns32           bits,
    Bool            isWrite,
    Bool            rwOnly
) {
    if(riscvCSRImplementExternalRead(attrs, riscv, rwOnly)) {
        return getCSRExternalReadCB(bits);
    } else if(isWrite && attrs->readWriteCB) {
        return attrs->readWriteCB;
    } else {
        return attrs->readCB;
    }
}

//
// Return any callback implementing a write of the CSR externally
//
static riscvCSRWriteFn getCSRWriteCB(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    Uns32           bits
) {
    if(riscvCSRImplementExternalWrite(attrs, riscv)) {
        return getCSRExternalWriteCB(bits);
    } else {
        return attrs->writeCB;
    }
}


////////////////////////////////////////////////////////////////////////////////
// INITIALIZATION
////////////////////////////////////////////////////////////////////////////////

//
// Return configured MXL
//
inline static Uns32 getDefaultMXL(riscvP riscv) {
    return riscv->configInfo.arch>>XLEN_SHIFT;
}

//
// Perform fundamental reset
//
static void resetMisaMStatus(riscvP riscv) {

    riscvConfigP cfg = &riscv->configInfo;
    Uns8         MXL = getDefaultMXL(riscv);
    Uns64        mstatusMask;

    // force evaluation of xlenMask (because of XL changes below)
    riscv->xlenMask = 0;

    // reset misa extensions
    WR_CSR_FIELDC(riscv, misa, Extensions, cfg->arch);

    if(MXL==2) {

        // update 64-bit mstatus
        mstatusMask = WM64_mstatus_reset;

        // reset misa MXL, allowing for the fact that this field might move
        WR_CSR_FIELD32(riscv, misa, MXL, 0);
        WR_CSR_FIELD64(riscv, misa, MXL, MXL);

    } else {

        // update 32-bit mstatus
        mstatusMask = WM32_mstatus_reset;

        // reset misa MXL, allowing for the fact that this field might move
        WR_CSR_FIELD32(riscv, misa, MXL, MXL);
        WR_CSR_FIELD64(riscv, misa, MXL, 0);
    }

    // reset mstatus
    statusW(riscv, cfg->csr.mstatus.u64.bits, mstatusMask);
}

//
// Reset CSR state
//
void riscvCSRReset(riscvP riscv) {

    Uns32 i;

    // reset PMP unit
    riscvVMResetPMP(riscv);

    // reset MPU unit
#if(ENABLE_SSMPU)
    riscvVMResetMPU(riscv);
#endif

    // reset Smstateen state
    for(i=0; i<4; i++) {
        mstateenWInt(riscv, 0, -1, i);
        hstateenWInt(riscv, 0, -1, i);
        sstateenWInt(riscv, 0, -1, i);
    }

    // reset mcause register
    WR_CSR64(riscv, mcause, 0);

    // reset vector state
    resetVLVType(riscv);

    // do fundamental reset of misa and mstatus
    resetMisaMStatus(riscv);

    // perform trigger reset
    resetTriggers(riscv);

    // get dcsr reset value
    Uns32 ebreak_mask = riscv->configInfo.dcsr_ebreak_mask << DCSR_EBREAK_SHIFT;
    Uns32 dcsr_reset  = RISCV_MODE_M + ebreak_mask;

    // reset dcsr (including dcsr.cause and dcsr.nmip)
    static const CSR_REG_DECL(dcsr) = {u32:{fields:{cause:-1, nmip:-1}}};
    dcsrWInt(riscv, dcsr_reset, dcsr.u32.bits);

    // clear exclusive tag
    clearEA(riscv);

    // reset all iprio array priorities if required
    if(riscv->aia) {
        for(i=0; i<64; i++) {
            riscv->aia->miprio[i]  = 0;
            riscv->aia->siprio[i]  = 0;
            riscv->aia->vsiprio[i] = 0;
        }
    }
}

//
// Perform initial CSR reset
//
static void riscvCSRInitialReset(riscvP riscv) {

    riscvConfigP      cfg     = &riscv->configInfo;
    riscvArchitecture arch    = cfg->arch;
    Uns32             MXL     = arch>>XLEN_SHIFT;
    riscvMode         minMode = riscvGetMinMode(riscv);

    // set reset value of mstatus.MPP
    if(RD_RAW_FIELDC(cfg->csr.mstatus, MPP) < minMode) {
        WR_RAW_FIELDC(cfg->csr.mstatus, MPP, minMode);
    }

    // set reset value of mstatus.SPP
    if(!(arch&ISA_S)) {
        WR_RAW_FIELDC(cfg->csr.mstatus, SPP, 0);
    } else if(RD_RAW_FIELDC(cfg->csr.mstatus, SPP) < minMode) {
        WR_RAW_FIELDC(cfg->csr.mstatus, SPP, minMode);
    }

    // reset value of mstatus.UXL, mstatus.SXL, hstatus.VSXL and vsstatus.UXL
    // mirror misa.MXL
    if(arch&ISA_U) {
        WR_RAW_FIELD64(cfg->csr.mstatus, UXL, MXL);
    }
    if(arch&ISA_S) {
        WR_RAW_FIELD64(cfg->csr.mstatus, SXL, MXL);
    }
    if(arch&ISA_H) {
        WR_CSR_FIELD64(riscv, vsstatus, UXL, MXL);
        WR_CSR_FIELD64(riscv, hstatus, VSXL, MXL);
    }

    // do fundamental reset of misa and mstatus
    resetMisaMStatus(riscv);
}

//
// Return mask bit for an exception
//
static Uns64 getExceptionMask(riscvException code) {

    VMI_ASSERT(!isInterrupt(code), "bad exception id %u", code);

    return 1ULL << code;
}

//
// Return mask bit for an interrupt
//
static Uns64 getInterruptMask(riscvException code) {

    VMI_ASSERT(isInterrupt(code), "bad interrupt id %u", code);

    return 1ULL << exceptionToInt(code);
}

//
// Initialize CSR state
//
void riscvCSRInit(riscvP riscv) {

    riscvConfigP      cfg         = &riscv->configInfo;
    riscvArchitecture arch        = cfg->arch;
    riscvArchitecture archMask    = cfg->archMask;
    Bool              haveBasicIC = basicICPresent(riscv);
    riscvCSRId        id;

    //--------------------------------------------------------------------------
    // CSR table support
    //--------------------------------------------------------------------------

    // allocate CSR lookup table
    vmirtNewRangeTable(&riscv->csrTable);

    // allocate CSR message range table
    vmirtNewRangeTable(&riscv->csrUIMessage);

    // insert all standard CSRs into CSR lookup table
    for(id=0; id<CSR_ID(LAST); id++) {
        if(csrs[id].name && (RISCV_PRIV_VERSION(riscv) >= csrs[id].version)) {
            newCSR(&csrs[id], riscv, False);
        }
    }

    //--------------------------------------------------------------------------
    // do initial CSR reset
    //--------------------------------------------------------------------------

    riscvCSRInitialReset(riscv);

    //--------------------------------------------------------------------------
    // mvendorid, marchid, mimpid, mhartid, mconfigptr values
    //--------------------------------------------------------------------------

    WR_CSR_M(riscv, mvendorid,  cfg->csr.mvendorid.u64.bits);
    WR_CSR_M(riscv, marchid,    cfg->csr.marchid.u64.bits);
    WR_CSR_M(riscv, mimpid,     cfg->csr.mimpid.u64.bits);
    WR_CSR_M(riscv, mhartid,    cfg->csr.mhartid.u64.bits);
    WR_CSR_M(riscv, mconfigptr, cfg->csr.mconfigptr.u64.bits);

    //--------------------------------------------------------------------------
    // misa mask
    //--------------------------------------------------------------------------

    WR_CSR_MASK_FIELD_M(riscv, misa, Extensions, archMask);
    WR_CSR_MASK_FIELD_M(riscv, misa, MXL,        archMask>>XLEN_SHIFT);

    //--------------------------------------------------------------------------
    // mstatus mask
    //--------------------------------------------------------------------------

    // initialize mstatus write mask (Machine mode)
    WR_CSR_MASK_FIELDC_1(riscv, mstatus, MIE);
    WR_CSR_MASK_FIELDC_1(riscv, mstatus, MPIE);

    // mstatus.MPP is only writable if there is some lower-level mode
    if(arch&(ISA_U|ISA_S)) {
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, MPP);
    }

    if(arch&ISA_S) {

        // initialize mstatus write mask (Supervisor mode)
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, SIE);
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, SPIE);
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, SUM);
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, MXR);
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, TVM);
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, TW);
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, TSR);
        WR_CSR_MASK_FIELD64(riscv, mstatus, SXL, -cfg->SXL_writable);

        // mstatus.SPP is only writable if there is some lower-level mode
        if(arch&ISA_U) {
            WR_CSR_MASK_FIELDC_1(riscv, mstatus, SPP);
        }
    }

    if(arch&ISA_U) {

        // initialize mstatus write mask (User mode)
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, MPRV);
        WR_CSR_MASK_FIELD64(riscv, mstatus, UXL, -cfg->UXL_writable);

        // from version 1.11, mstatus.TW is writable if any lower-level
        // privilege mode is implemented (previously, it was just if Supervisor
        // mode was implemented)
        if(RISCV_PRIV_VERSION(riscv) >= RVPV_1_11) {
            WR_CSR_MASK_FIELDC_1(riscv, mstatus, TW);
        }
    }

    // initialize N-extension write masks
    if(arch&ISA_N) {
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, UIE);
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, UPIE);
    }

    // FS is writable if Zfinx is absent and either D or F extension is present,
    // or S-mode is implemented and mstatus_FS_zero is not specified
    if(Zfinx(riscv)) {
        WR_CSR_FIELDC(riscv, mstatus, FS, 0);
    } else if((arch&ISA_DF) || (!cfg->mstatus_FS_zero && (arch&ISA_S))) {
        WR_CSR_MASK_FIELDC_1(riscv, mstatus, FS);
    }

    // initialize V-extension write masks
    if(arch&ISA_V) {

        // enable FS field if required (NOTE: Vector Extension 0.8 requires
        // mstatus.FS to enable access to vxsat and vxrm and their aliases in
        // fcsr)
        if(vxRequiresFS(riscv)) {
            WR_CSR_MASK_FIELDC_1(riscv, mstatus, FS);
        }

        // enable mstatus.VS write mask in either 0.8 or 0.9 version location
        // if required
        if(statusVS8(riscv)) {
            WR_CSR_MASK_FIELDC_1(riscv, mstatus, VS_8);
        } else if(statusVS9(riscv)) {
            WR_CSR_MASK_FIELDC_1(riscv, mstatus, VS_9);
        }
    }

    // initialize endian values and write masks
    if(riscvSupportEndian(riscv)) {

        Bool BE    = riscv->dendian;
        Bool fixed = cfg->endianFixed;

        // enable and initialize MBE field defaults in mstatus or mstatush
        WR_CSR_MASK_FIELDC(riscv, mstatus, MBE, !fixed);
        cfg->csr.mstatus.u64.fields.MBE = BE;

        // enable and initialize SBE field defaults in mstatus or mstatush
        if(arch&ISA_S) {
            WR_CSR_MASK_FIELDC(riscv, mstatus, SBE, !fixed);
            cfg->csr.mstatus.u64.fields.SBE = BE;
        }

        // enable and initialize UBE field defaults in mstatus
        if(arch&ISA_U) {
            WR_CSR_MASK_FIELDC(riscv, mstatus, UBE, !fixed);
            cfg->csr.mstatus.u64.fields.UBE = BE;
        }
    }

    // initialize H-mode write masks in mstatus or mstatush
    if(arch&ISA_H) {
        WR_CSR_MASK_FIELD64_1(riscv, mstatus, MPV);
        WR_CSR_MASK_FIELD64_1(riscv, mstatus, GVA);
    }

    //--------------------------------------------------------------------------
    // mnstatus mask
    //--------------------------------------------------------------------------

    // initialize mnstatus write mask (Machine mode)
    WR_CSR_MASK_FIELDC_1(riscv, mnstatus, NMIE);

    // mnstatus.MPP is only writable if there is some lower-level mode
    if(arch&(ISA_U|ISA_S)) {
        WR_CSR_MASK_FIELDC_1(riscv, mnstatus, MNPP);
    }

    // initialize H-mode write masks in mnstatus
    if(arch&ISA_H) {
        WR_CSR_MASK_FIELD64_1(riscv, mnstatus, MNPV);
    }

    //--------------------------------------------------------------------------
    // hstatus mask
    //--------------------------------------------------------------------------

    WR_CSR_MASK_S(riscv, hstatus, WM_hstatus);

    // use configured hstatus.VSXL mask
    WR_CSR_MASK_FIELDC(riscv, hstatus, VSXL, -cfg->VSXL_writable);

    // enable hstatus.VGEIN if guest external interrupts are enabled
    if(getGEILEN(riscv)) {
        WR_CSR_MASK_FIELDC_1(riscv, hstatus, VGEIN);
    }

    // initialize endian values and write masks
    if(riscvSupportEndian(riscv)) {

        Bool BE    = riscv->dendian;
        Bool fixed = cfg->endianFixed;

        // enable and initialize VSBE field in hstatus
        WR_CSR_MASK_FIELDC(riscv, hstatus, VSBE, !fixed);
        WR_CSR_FIELDC(riscv, hstatus, VSBE, BE);

        // initialize UBE field in vsstatus
        WR_CSR_FIELDC(riscv, vsstatus, UBE, BE);
    }

    //--------------------------------------------------------------------------
    // htinst/mtinst masks
    //--------------------------------------------------------------------------

    Uns64 xtinstMask = -1;

    // restrict htinst/mtinst writable bits if only pseudo-instructions are
    // reported
    if(xtinstBasic(riscv)) {
        xtinstMask = (arch&ISA_XLEN_64) ? 0x3020 : 0x2020;
    }

    WR_CSR_MASK_S(riscv, htinst, xtinstMask);
    WR_CSR_MASK_M(riscv, mtinst, xtinstMask);

    //--------------------------------------------------------------------------
    // uepc, sepc, vsepc, mepc, mnepc, dpc masks
    //--------------------------------------------------------------------------

    // initialize uepc, sepc, vsepc, mepc, mnepc and dpc write masks (dependent
    // on whether compressed instructions are present)
    Uns64 maskEPC = (arch&ISA_C) ? -2 : -4;
    WR_CSR_MASK_U (riscv, uepc,  maskEPC);
    WR_CSR_MASK_S (riscv, sepc,  maskEPC);
    WR_CSR_MASK_VS(riscv, vsepc, maskEPC);
    WR_CSR_MASK_M (riscv, mepc,  maskEPC);
    WR_CSR_MASK_M (riscv, mnepc, maskEPC);
    WR_CSR_MASK_M (riscv, dpc,   maskEPC);

    //--------------------------------------------------------------------------
    // exception masks
    //--------------------------------------------------------------------------

    // get mask of implemented exceptions visible in M mode
    Uns64 mExceptions = riscv->exceptionMask;

    // get mask of implemented exceptions that can be delegated to HS mode
    Uns64 sExceptions = (
        mExceptions &
        ~(
            getExceptionMask(riscv_E_EnvironmentCallFromMMode)
        )
    );

    // get mask of implemented exceptions that can be delegated to U mode (if N
    // extension is implemented)
    Uns64 uExceptions = (
        sExceptions &
        ~(
            getExceptionMask(riscv_E_EnvironmentCallFromSMode)  |
            getExceptionMask(riscv_E_EnvironmentCallFromVSMode) |
            getExceptionMask(riscv_E_InstructionGuestPageFault) |
            getExceptionMask(riscv_E_LoadGuestPageFault)        |
            getExceptionMask(riscv_E_VirtualInstruction)        |
            getExceptionMask(riscv_E_StoreAMOGuestPageFault)
        )
    );

    // get initial mask of implemented exceptions that can be delegated to VS
    // mode (see see table "Bits of hedeleg that must be writable or must be
    // hardwired to zero" in Privileged Specification)
    Uns64 vExceptions = (
         uExceptions |
         (
            getExceptionMask(riscv_E_InstructionAccessFault)    |
            getExceptionMask(riscv_E_IllegalInstruction)        |
            getExceptionMask(riscv_E_Breakpoint)                |
            getExceptionMask(riscv_E_LoadAddressMisaligned)     |
            getExceptionMask(riscv_E_LoadAccessFault)           |
            getExceptionMask(riscv_E_StoreAMOAddressMisaligned) |
            getExceptionMask(riscv_E_StoreAMOAccessFault)       |
            getExceptionMask(riscv_E_EnvironmentCallFromUMode)  |
            getExceptionMask(riscv_E_InstructionPageFault)      |
            getExceptionMask(riscv_E_LoadPageFault)             |
            getExceptionMask(riscv_E_StoreAMOPageFault)
        )
    );

    //--------------------------------------------------------------------------
    // medeleg, sedeleg, hedeleg masks
    //--------------------------------------------------------------------------

    // override hedeleg delegation mask (ignore no_edeleg override)
    WR_CSR_MASK_S(riscv, hedeleg, vExceptions);

    // override medeleg and sedeleg delegation masks
    WR_CSR_MASK_M(riscv, medeleg, sExceptions & ~cfg->no_edeleg);
    WR_CSR_MASK_S(riscv, sedeleg, uExceptions & ~cfg->no_edeleg);

    //--------------------------------------------------------------------------
    // interrupt masks
    //--------------------------------------------------------------------------

    // get mask of implemented interrupts visible in M mode
    Uns64 mInterrupts = riscv->interruptMask;

    // get mask of implemented standard VS-level interrupts
    Uns64 standardVSInterrupts = (
        mInterrupts &
        (
            getInterruptMask(riscv_E_VSSWInterrupt)       |
            getInterruptMask(riscv_E_VSTimerInterrupt)    |
            getInterruptMask(riscv_E_VSExternalInterrupt) |
            getInterruptMask(riscv_E_SGEIInterrupt)
        )
    );

    // get mask of implemented interrupts visible in HS mode in sip/sie - note
    // that standard VS-level interrupts are excluded from this list and
    // instead visible in hip/hie
    Uns64 sInterrupts = (
        mInterrupts &
        ~(
            getInterruptMask(riscv_E_MSWInterrupt)       |
            getInterruptMask(riscv_E_MTimerInterrupt)    |
            getInterruptMask(riscv_E_MExternalInterrupt) |
            standardVSInterrupts
        )
    );

    // get mask of implemented interrupts visible in HS mode in hip/hie
    Uns64 hInterrupts = (
        mInterrupts &
        ~(
            getInterruptMask(riscv_E_MSWInterrupt)       |
            getInterruptMask(riscv_E_MTimerInterrupt)    |
            getInterruptMask(riscv_E_MExternalInterrupt) |
            getInterruptMask(riscv_E_SSWInterrupt)       |
            getInterruptMask(riscv_E_STimerInterrupt)    |
            getInterruptMask(riscv_E_SExternalInterrupt) |
            getInterruptMask(riscv_E_USWInterrupt)       |
            getInterruptMask(riscv_E_UTimerInterrupt)    |
            getInterruptMask(riscv_E_UExternalInterrupt) |
            getInterruptMask(riscv_E_SGEIInterrupt)
        )
    );

    // get mask of implemented interrupts visible in User mode
    Uns64 uInterrupts = (
        sInterrupts &
        ~(
            getInterruptMask(riscv_E_SSWInterrupt)       |
            getInterruptMask(riscv_E_STimerInterrupt)    |
            getInterruptMask(riscv_E_SExternalInterrupt)
        )
    );

    //--------------------------------------------------------------------------
    // mie, mideleg, sideleg, hideleg masks
    //--------------------------------------------------------------------------

    // override enable masks
    WR_CSR_MASK64(riscv, mie, mInterrupts);

    // override interrupt delegation masks
    if(haveBasicIC) {

        // get interrupts that are always delegated to lower levels
        Uns64 force_mideleg = sInterrupts & cfg->force_mideleg;
        Uns64 force_sideleg = uInterrupts & cfg->force_sideleg;

        // standard VS-level interrupts are always delegated to HS mode and
        // visible in hie/hip (not sie/sip)
        force_mideleg |= standardVSInterrupts;

        // create delegation masks
        Uns64 midelegMask = ~(cfg->no_ideleg | force_mideleg);
        Uns64 sidelegMask = ~(cfg->no_ideleg | force_sideleg);

        // set delegation masks
        WR_CSR_MASK64(riscv, mideleg, sInterrupts & midelegMask);
        WR_CSR_MASK64(riscv, hideleg, hInterrupts & sidelegMask);
        WR_CSR_MASK64(riscv, sideleg, uInterrupts & sidelegMask);

        // set forced delegation values
        WR_CSR64(riscv, mideleg, force_mideleg);
        WR_CSR64(riscv, sideleg, force_sideleg);

        // interrupts with forced delegation are also not configurable in xiprio
        // arrays
        riscv->configInfo.miprio_mask &= ~force_mideleg;
        riscv->configInfo.siprio_mask &= ~force_sideleg;
    }

    //--------------------------------------------------------------------------
    // sedeleg, sideleg initial values (N extension and no Supervisor mode)
    //--------------------------------------------------------------------------

    if((arch&ISA_SorN) == ISA_N) {
        WR_CSR64(riscv, sedeleg, -1);
        WR_CSR64(riscv, sideleg, -1);
    }

    //--------------------------------------------------------------------------
    // mtvec, stvec, utvec masks and initial value
    //--------------------------------------------------------------------------

    Uns64 WM64_tvec = 0;

    // write masks for xtvec registers depend on whether original mode, clic
    // mode or both are supported
    if(haveBasicIC) {
        WM64_tvec |= WM64_tvec_orig;
    }
    if(CLICPresent(riscv)) {
        WM64_tvec |= WM64_tvec_clic;
    }

    // use defined masks from configuration
    Uns64 mtvecMask = (cfg->csrMask.mtvec.u64.bits ? : -1) & WM64_tvec;
    Uns64 stvecMask = (cfg->csrMask.stvec.u64.bits ? : -1) & WM64_tvec;
    Uns64 utvecMask = (cfg->csrMask.utvec.u64.bits ? : -1) & WM64_tvec;

    // mtvec may be read only, if mtvec_is_ro parameter is set
    if(cfg->mtvec_is_ro) {mtvecMask = 0;}

    // set mtvec, vstvec, stvec, utvec masks
    WR_CSR_MASK_M (riscv, mtvec,  mtvecMask);
    WR_CSR_MASK_VS(riscv, vstvec, stvecMask);
    WR_CSR_MASK_S (riscv, stvec,  stvecMask);
    WR_CSR_MASK_U (riscv, utvec,  utvecMask);

    // set mtvec initial value
    WR_CSR_M(riscv, mtvec, cfg->csr.mtvec.u64.bits);

    // force exception mode if only CLIC is present
    if(!haveBasicIC) {
        WR_CSR_FIELD_M(riscv, mtvec, MODE, riscv_int_CLIC_Vectored);
        WR_CSR_FIELD_S(riscv, stvec, MODE, riscv_int_CLIC_Vectored);
        WR_CSR_FIELD_U(riscv, utvec, MODE, riscv_int_CLIC_Vectored);
    }

    //--------------------------------------------------------------------------
    // mtval, stval, utval masks
    //--------------------------------------------------------------------------

    if(!cfg->tval_zero) {
        WR_CSR_MASK_M (riscv, mtval,  -1);
        WR_CSR_MASK_VS(riscv, vstval, -1);
        WR_CSR_MASK_S (riscv, stval,  -1);
        WR_CSR_MASK_U (riscv, utval,  -1);
    }

    //--------------------------------------------------------------------------
    // mtvt, stvt, utvt masks
    //--------------------------------------------------------------------------

    // use defined masks from configuration
    Uns64 mtvtMask = (cfg->csrMask.mtvt.u64.bits ? : -1) & WM64_tvt;
    Uns64 stvtMask = (cfg->csrMask.stvt.u64.bits ? : -1) & WM64_tvt;
    Uns64 utvtMask = (cfg->csrMask.utvt.u64.bits ? : -1) & WM64_tvt;

    // set mtvt, stvt, utvt masks
    WR_CSR_MASK_M(riscv, mtvt, mtvtMask);
    WR_CSR_MASK_S(riscv, stvt, stvtMask);
    WR_CSR_MASK_U(riscv, utvt, utvtMask);

    //--------------------------------------------------------------------------
    // jvt mask
    //--------------------------------------------------------------------------

    // use defined mask from configuration
    Uns64 jvtMask = (cfg->csrMask.jvt.u64.bits ? : -1) & WM64_jvt;

    // set jvt mask
    WR_CSR_MASK_M(riscv, jvt, jvtMask);

    //--------------------------------------------------------------------------
    // mcause, scause, ucause masks
    //--------------------------------------------------------------------------

    // enable writable bits (either all bits or restricted ExceptionCode bits)
    if(!CLICPresent(riscv)) {
        WR_CSR_MASK_M(riscv, mcause, -1);
        WR_CSR_MASK_S(riscv, scause, -1);
        WR_CSR_MASK_U(riscv, ucause, -1);
    } else {
        WR_CSR_MASK_FIELDC(riscv, mcause, ExceptionCode, -1);
        WR_CSR_MASK_FIELDC(riscv, scause, ExceptionCode, -1);
        WR_CSR_MASK_FIELDC(riscv, ucause, ExceptionCode, -1);
    }

    // bitwise-and mcause, scause, ucause masks (per instruction length)
    AND_CSR_MASK_M(riscv, mcause, cfg->ecode_mask);
    AND_CSR_MASK_S(riscv, scause, cfg->ecode_mask);
    AND_CSR_MASK_U(riscv, ucause, cfg->ecode_mask);

    // enable interrupt bits irrespective of mask
    WR_CSR_MASK_FIELD_M(riscv, mcause, Interrupt, -1);
    WR_CSR_MASK_FIELD_S(riscv, scause, Interrupt, -1);
    WR_CSR_MASK_FIELD_U(riscv, ucause, Interrupt, -1);

    // enable CLIC-specific bits irrespective of mask
    if(CLICPresent(riscv)) {

        // initialize xintthresh hardwired-to-1 bits
        WR_CSR_FIELDC(riscv, mintthresh, th, riscv->threshOnes);
        WR_CSR_FIELDC(riscv, sintthresh, th, riscv->threshOnes);
        WR_CSR_FIELDC(riscv, uintthresh, th, riscv->threshOnes);

        // enable pil bits
        WR_CSR_MASK_FIELDC(riscv, mcause, pil, -1);
        WR_CSR_MASK_FIELDC(riscv, scause, pil, -1);
        WR_CSR_MASK_FIELDC(riscv, ucause, pil, -1);

        // enable pie bits
        WR_CSR_MASK_FIELDC(riscv, mcause, pie, -1);
        WR_CSR_MASK_FIELDC(riscv, scause, pie, -1);
        WR_CSR_MASK_FIELDC(riscv, ucause, pie, -1);

        // enable inhv bits (if selective hardware vectoring implemented)
        if(cfg->CLICSELHVEC) {
            WR_CSR_MASK_FIELDC(riscv, mcause, inhv, -1);
            WR_CSR_MASK_FIELDC(riscv, scause, inhv, -1);
            WR_CSR_MASK_FIELDC(riscv, ucause, inhv, -1);
        }

        // enable pp bits
        WR_CSR_MASK_FIELDC(riscv, mcause, pp, 3);
        WR_CSR_MASK_FIELDC(riscv, scause, pp, 1);
    }

    //--------------------------------------------------------------------------
    // mcounteren, hcounteren, scounteren masks
    //--------------------------------------------------------------------------

    Uns32 counterImpMask = cfg->counteren_mask & WM32_counteren_HPM;
    Uns32 mcounterenMask  = 0;

    // CY, TM, IR and HPM bits are writable only if the cycle, time, instret
    // and hpmcounter registers are defined
    if(!cfg->cycle_undefined) {
        mcounterenMask |= WM32_counteren_CY;
    }
    if(!cfg->time_undefined) {
        mcounterenMask |= WM32_counteren_TM;
    }
    if(!cfg->instret_undefined) {
        mcounterenMask |= WM32_counteren_IR;
    }
    if(!cfg->hpmcounter_undefined) {
        mcounterenMask |= counterImpMask;
    }

    // derive scounterenMask and hcounterenMask
    Uns32 scounterenMask = mcounterenMask & ~cfg->scounteren_zero_mask;
    Uns32 hcounterenMask = mcounterenMask & ~cfg->hcounteren_zero_mask;

    // set mcounteren and scounteren masks if User mode is present
    if(arch&ISA_U) {
        WR_CSR_MASKC(riscv, mcounteren, mcounterenMask);
        WR_CSR_MASKC(riscv, scounteren, scounterenMask);
    }

    // set hcounteren mask if Hypervisor mode is present
    if(arch&ISA_H) {
        WR_CSR_MASKC(riscv, hcounteren, hcounterenMask);
    }

    //--------------------------------------------------------------------------
    // scounteren implied value
    //--------------------------------------------------------------------------

    // if User mode is present but not Supervisor mode, scounteren has an
    // implied value allowing User mode access to any timer that is permitted
    // by mcounteren
    if((arch&ISA_U) && !(arch&ISA_S)) {
        WR_CSRC(riscv, scounteren, -1);
    }

    //--------------------------------------------------------------------------
    // mcountinhibit mask
    //--------------------------------------------------------------------------

    Uns32 countinhibitMask = 0;

    // CY, IR and HPM bits are writable only if the mcycle, minstret and
    // mhpmcounter registers are defined
    if(!cfg->mcycle_undefined) {
        countinhibitMask |= WM32_counteren_CY;
    }
    if(!cfg->minstret_undefined) {
        countinhibitMask |= WM32_counteren_IR;
    }
    if(!cfg->mhpmcounter_undefined) {
        countinhibitMask |= counterImpMask;
    }

    countinhibitMask &= ~cfg->noinhibit_mask;

    // set mcountinhibit mask
    WR_CSR_MASKC(riscv, mcountinhibit, countinhibitMask);

    //--------------------------------------------------------------------------
    // fcsr masks
    //--------------------------------------------------------------------------

    Uns32 fcsrMask = 0;

    // enable floating point fields if required
    if(arch&ISA_DF) {
        fcsrMask |= WM32_fcsr_f;
    }

    // enable fixed point fields if vcsr is not present
    if((arch&ISA_V) && !riscvVFSupport(riscv, RVVF_VCSR_PRESENT)) {
        fcsrMask |= WM32_fcsr_v;
    }

    WR_CSR_MASKC(riscv, fcsr, fcsrMask);

    // set initial rounding-mode-valid state
    updateCurrentRMValid(riscv);

    //--------------------------------------------------------------------------
    // vlenb
    //--------------------------------------------------------------------------

    WR_CSRC(riscv, vlenb, cfg->VLEN/8);

    //--------------------------------------------------------------------------
    // vstart mask and polymorphic key
    //--------------------------------------------------------------------------

    WR_CSR_MASKC(riscv, vstart, cfg->VLEN-1);

    // set initial vector polymorphic key
    riscvRefreshVectorPMKey(riscv);

    //--------------------------------------------------------------------------
    // tselect
    //--------------------------------------------------------------------------

    // allocate trigger structures if required
    if(cfg->trigger_num) {

        riscv->triggers = STYPE_CALLOC_N(riscvTrigger, cfg->trigger_num);

        // configure triggers
        configureTriggers(riscv);

        // perform trigger reset
        resetTriggers(riscv);
    }

    //--------------------------------------------------------------------------
    // tcontrol write mask
    //--------------------------------------------------------------------------

    WR_CSR_MASKC(riscv, tcontrol, WM32_tcontrol);

    if((RISCV_DBG_VERSION(riscv)>=RVDBG_0_14_0) && !cfg->Smstateen) {

        if((arch&ISA_S) && !cfg->scontext_undefined) {
            WR_CSR_MASK_FIELDC_1(riscv, tcontrol, scxe);
        }

        if((arch&ISA_H) && !cfg->hcontext_undefined) {
            WR_CSR_MASK_FIELDC_1(riscv, tcontrol, hcxe);
        }
    }

    //--------------------------------------------------------------------------
    // tdata1 write mask
    //--------------------------------------------------------------------------

    WR_CSR_MASKC(riscv, tdata1, cfg->csrMask.tdata1.u64.bits);

    //--------------------------------------------------------------------------
    // mip, sip, uip and hip write masks
    //--------------------------------------------------------------------------

    WR_CSR_MASKC(riscv, mip, cfg->csrMask.mip.u64.bits);
    WR_CSR_MASKC(riscv, sip, cfg->csrMask.sip.u64.bits);
    WR_CSR_MASKC(riscv, uip, cfg->csrMask.uip.u64.bits);
    WR_CSR_MASKC(riscv, hip, cfg->csrMask.hip.u64.bits);

    //--------------------------------------------------------------------------
    // mvien, mvip write masks and mvien initial value (any bit that may be set
    // pending but is not in the enable mask is hard-wired to 1 in the enable
    // mask)
    //--------------------------------------------------------------------------

    // get original mvien mask
    Uns64 mvienMask = WM64_mvien;

    // SEIP and SSIP are also writable from version RC3
    if((arch&ISA_S) && (RISCV_AIA_VERSION(riscv)>=RVAIA_1_0_RC3)) {
        mvienMask |= (WM64_seip|WM64_ssip);
    }

    Uns64 mvien = cfg->csrMask.mvien.u64.bits & mvienMask;
    Uns64 mvip  = cfg->csrMask.mvip.u64.bits  & WM64_mvip;

    // bits writeable in mvien must also be writeable in mvip
    mvip |= mvien;

    // bits in the range 63:13 that are writable in mvip but not writable in
    // mvien are permanently enabled in mvien
    if(Smaia(riscv)) {
        WR_CSR64(riscv, mvien, mvip & ~mvien);
    }

    // bits 1, 5 and 9 in mvip are aliases of the same bits in mip, and are
    // writeable if those bits are writeable
    mvip |= (cfg->csrMask.mip.u64.bits & WM64_mip_mvip);

    // set masks for mvien and mvip
    WR_CSR_MASKC(riscv, mvien, mvien);
    WR_CSR_MASKC(riscv, mvip,  mvip);

    //--------------------------------------------------------------------------
    // hvien, hvip write masks and hvien initial value (any bit that may be set
    // pending but is not in the enable mask is hard-wired to 1 in the enable
    // mask)
    //--------------------------------------------------------------------------

    // exclude standard portion from hvien/hvip masks
    Uns64 hvien = cfg->csrMask.hvien.u64.bits & WM64_hvien;
    Uns64 hvip  = cfg->csrMask.hvip.u64.bits  & WM64_hvien;

    // bits writeable in hvien must also be writeable in hvip
    hvip |= hvien;

    // bits in the range 63:13 that are writable in hvip but not writable in
    // hvien are permanently enabled in hvien
    if(Smaia(riscv)) {
        WR_CSR64(riscv, hvien, hvip & ~hvien);
    }

    // set masks for mvien and mvip
    WR_CSR_MASKC(riscv, hvien, hvien);
    WR_CSR_MASKC(riscv, hvip,  hvip);

    //--------------------------------------------------------------------------
    // hvictl write mask
    //--------------------------------------------------------------------------

    WR_CSR_MASKC(riscv, hvictl, WM64_hvictl);
    WR_CSR_MASK_FIELDC(riscv, hvictl, IID, getAddressMask(cfg->hvictl_IID_bits));

    //--------------------------------------------------------------------------
    // mcontext and scontext write masks
    //--------------------------------------------------------------------------

    WR_CSR_MASKC(riscv, mcontext, getAddressMask(cfg->mcontext_bits));
    WR_CSR_MASKC(riscv, scontext, getAddressMask(cfg->scontext_bits));

    //--------------------------------------------------------------------------
    // menvcfg, senvcfg and henvcfg write masks
    //--------------------------------------------------------------------------

    // handle writable fields in envcfg masks when Zicbom is implemented
    if(cfg->Zicbom) {
        cfg->csrMask.envcfg.u64.fields.CBIE  = -1;
        cfg->csrMask.envcfg.u64.fields.CBCFE = -1;
    }

    // handle writable fields in envcfg masks when Zicboz is implemented
    if(cfg->Zicboz) {
        cfg->csrMask.envcfg.u64.fields.CBZE = -1;
    }

    // handle writable fields in envcfg masks when Svpbmt is implemented
    if(cfg->Svpbmt) {
        cfg->csrMask.envcfg.u64.fields.PBMTE = -1;
    }

    // handle writable fields in envcfg masks when Sstc is implemented
    if(cfg->Sstc) {
        cfg->csrMask.envcfg.u64.fields.STCE = -1;
    }

    WR_CSR_MASKC(riscv, menvcfg, cfg->csrMask.envcfg.u64.bits);
    WR_CSR_MASKC(riscv, senvcfg, cfg->csrMask.envcfg.u64.bits);
    WR_CSR_MASKC(riscv, henvcfg, cfg->csrMask.envcfg.u64.bits);

    // senvcfg.STCE and PBMTE are always zero
    WR_CSR_MASK_FIELDC(riscv, senvcfg, STCE,  0);
    WR_CSR_MASK_FIELDC(riscv, senvcfg, PBMTE, 0);

    //--------------------------------------------------------------------------
    // dcsr mask and read-only fields
    //--------------------------------------------------------------------------

    // initialize dcsr writable fields
    WR_CSR_MASK_FIELDC_1(riscv, dcsr, ebreakm);
    WR_CSR_MASK_FIELDC_1(riscv, dcsr, stepie);
    WR_CSR_MASK_FIELDC_1(riscv, dcsr, stopcount);
    WR_CSR_MASK_FIELDC_1(riscv, dcsr, stoptime);
    WR_CSR_MASK_FIELDC_1(riscv, dcsr, mprven);
    WR_CSR_MASK_FIELDC_1(riscv, dcsr, step);

    // initialize dcsr mask writable fields if Supervisor mode present
    if(arch&ISA_S) {
        WR_CSR_MASK_FIELDC_1(riscv, dcsr, ebreaks);
    }

    // initialize dcsr mask writable fields if User mode present - note that
    // dcsr.prv is writeable by software only if User mode present but is
    // otherwise hardwired to 3 (indicating Machine mode)
    if(arch&ISA_U) {
        WR_CSR_MASK_FIELDC_1(riscv, dcsr, ebreaku);
        WR_CSR_MASK_FIELDC_1(riscv, dcsr, prv);
    } else {
        WR_CSR_FIELDC(riscv, dcsr, prv, RISCV_MODE_M);
    }

    // initialize dcsr mask writable fields if Hypervisor mode present
    if(arch&ISA_H) {
        WR_CSR_MASK_FIELDC_1(riscv, dcsr, ebreakvu);
        WR_CSR_MASK_FIELDC_1(riscv, dcsr, ebreakvs);
        WR_CSR_MASK_FIELDC_1(riscv, dcsr, v);
    }

    // initialize dcsr read-only fields
    WR_CSR_FIELDC(riscv, dcsr, xdebugver, 4);

    //--------------------------------------------------------------------------
    // mseccfg write mask
    //--------------------------------------------------------------------------

    if(!mseccfg_cryptoP(riscv)) {

        // no action

    } else if(RISCV_CRYPTO_VERSION(riscv)<RVKV_1_0_0_RC5) {

        // mseccfg contains SKES if Supervisor mode present
        if(arch&ISA_S) {
            WR_CSR_MASK_FIELDC_1(riscv, mseccfg, USEED_SKES);
        }

    } else {

        // mseccfg contains USEED if User mode present
        if(arch&ISA_U) {
            WR_CSR_MASK_FIELDC_1(riscv, mseccfg, USEED_SKES);
        }

        // mseccfg contains SSEED if Supervisor mode present
        if(arch&ISA_S) {
            WR_CSR_MASK_FIELDC_1(riscv, mseccfg, SSEED);
        }
    }

    // mseccfg contains MML, MMWP and RLB if User mode and PMP present
    if(RISCV_SMEPMP_VERSION(riscv) && (arch&ISA_U) && cfg->PMP_registers) {
        WR_CSR_MASK_FIELDC_1(riscv, mseccfg, MML);
        WR_CSR_MASK_FIELDC_1(riscv, mseccfg, MMWP);
        WR_CSR_MASK_FIELDC_1(riscv, mseccfg, RLB);
    }

    //--------------------------------------------------------------------------
    // *stateen write masks not defined by CSRs
    //--------------------------------------------------------------------------

    if(arch&ISA_U) {

        // handle Zfinx
        if(Zfinx(riscv)) {
            OR_CSR_MASKC(riscv, mstateen[0], WM64_stateen_Zfinx);
            OR_CSR_MASKC(riscv, hstateen[0], WM64_stateen_Zfinx);
            OR_CSR_MASKC(riscv, sstateen[0], WM64_stateen_Zfinx);
        }
    }

    //--------------------------------------------------------------------------
    // allocate AIA structures if required
    //--------------------------------------------------------------------------

    if(Smaia(riscv)) {
        riscv->aia = STYPE_CALLOC(riscvAIA);
    }
}

//
// Free CSR state
//
void riscvCSRFree(riscvP riscv) {

    // free CSR lookup table
    if(riscv->csrTable) {
        vmirtFreeRangeTable(&riscv->csrTable);
    }

    // free CSR message range table
    if(riscv->csrUIMessage) {
        vmirtFreeRangeTable(&riscv->csrUIMessage);
    }

    // free CSR aliases
    freeCSRRemap(riscv);

    // free trigger structures if required
    if(riscv->triggers) {
        STYPE_FREE(riscv->triggers);
        riscv->triggers = 0;
    }

    // free AIA structures if required
    if(riscv->aia) {
        STYPE_FREE(riscv->aia);
        riscv->aia = 0;
    }
}


////////////////////////////////////////////////////////////////////////////////
// DISASSEMBLER INTERFACE ACCESS FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Return CSR name for the given index number (or NULL if undefined)
//
const char *riscvGetCSRName(riscvP riscv, Uns32 csrNum) {

    riscvCSRAttrsCP attrs = getCSRAttrs(riscv, csrNum);

    return attrs ? attrs->name : 0;
}


////////////////////////////////////////////////////////////////////////////////
// DEBUG INTERFACE ACCESS FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Is the CSR 64-bit width (ignoring variable XLEN)
//
static Bool isCSR64Bit(riscvCSRAttrsCP attrs, riscvP riscv) {
    return (getDefaultMXL(riscv)==2) && !(attrs->arch&ISA_XLEN_32);
}

//
// Return the effective CSR size in bits
//
static Uns32 getCSREffectiveBits(riscvCSRAttrsCP attrs, riscvP riscv) {

    Uns32 result = 32;

    if(!isCSR64Bit(attrs, riscv)) {

        // CSR always 32-bit

    } else if(riscvModeIsXLEN64(riscv, getCSRMode5(attrs, riscv))) {

        // CSR is 64-bit if the associated mode is 64-bit
        result = 64;
    }

    return result;
}

//
// Read a CSR given its attributes object
//
Bool riscvReadCSR(riscvCSRAttrsCP attrs, riscvP riscv, void *buffer) {

    Bool  ok    = checkCSRPresent(attrs, riscv);
    Uns64 value = 0;

    if(ok) {

        Uns32 bits     = getCSREffectiveBits(attrs, riscv);
        Bool  is64Bit  = (bits==64);
        void *rawValue = getCSRRegValue(attrs, riscv);

        // get read callback function
        riscvCSRReadFn readCB = getCSRReadCB(attrs, riscv, bits, False, True);

        // read value using callback or raw
        if(readCB) {
            value = readCB(attrs, riscv);
        } else if (!rawValue) {
            // always-zero register
        } else if(is64Bit) {
            value = *(Uns64*)rawValue;
        } else {
            value = *(Uns32*)rawValue;
        }
    }

    // assign to buffer of correct configured size
    if(isCSR64Bit(attrs, riscv)) {
        *(Uns64*)buffer = value;
    } else {
        *(Uns32*)buffer = value;
    }

    return ok;
}

//
// Write a CSR given its attributes object
//
Bool riscvWriteCSR(riscvCSRAttrsCP attrs, riscvP riscv, const void *buffer) {

    Bool ok = checkCSRPresent(attrs, riscv);

    if(ok) {

        Uns32 bits     = getCSREffectiveBits(attrs, riscv);
        Bool  is64Bit  = (bits==64);
        void *rawValue = getCSRRegValue(attrs, riscv);
        Uns64 newValue;

        // get new value to be written
        if(is64Bit) {
            newValue = *(const Uns64 *)buffer;
        } else {
            newValue = *(const Uns32 *)buffer;
        }

        // get any write callback function
        riscvCSRWriteFn writeCB = getCSRWriteCB(attrs, riscv, bits);

        if(writeCB) {

            // write value using callback
            writeCB(attrs, riscv, newValue);

            // update raw value if register is implemented externally
            if(!rawValue) {
                // no action
            } else if(!riscvCSRImplementExternalWrite(attrs, riscv)) {
                // no action
            } else if(is64Bit) {
                *(Uns64*)rawValue = newValue;
            } else {
                *(Uns32*)rawValue = newValue;
            }

        } else if(rawValue) {

            // write value directly
            Uns64 writeMask = getCSRWriteMask(attrs, riscv);
            Uns64 oldValue;

            if(is64Bit) {
                oldValue = *(Uns64*)rawValue;
            } else {
                oldValue = *(Uns32*)rawValue;
            }

            newValue = (newValue & writeMask) | (oldValue & ~writeMask);

            if(is64Bit) {
                *(Uns64*)rawValue = newValue;
            } else {
                *(Uns32*)rawValue = newValue;
            }
        }
    }

    return ok;
}


////////////////////////////////////////////////////////////////////////////////
// LINKED MODEL ACCESS FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Read a CSR in the model given its number
//
Uns64 riscvReadCSRNum(riscvP riscv, Uns32 csrNum) {

    riscvCSRAttrsCP attrs  = getCSRAttrs(riscv, csrNum);
    Uns64           result = 0;

    if(attrs) {
        riscvReadCSR(attrs, riscv, &result);
    }

    return result;
}

//
// Write a CSR in the model given its number
//
Uns64 riscvWriteCSRNum(riscvP riscv, riscvCSRId csrNum, Uns64 newValue) {

    riscvCSRAttrsCP attrs = getCSRAttrs(riscv, csrNum);

    if(attrs) {
        riscvWriteCSR(attrs, riscv, &newValue);
    }

    return newValue;
}

//
// Read a CSR in the base model given its id
//
Uns64 riscvReadBaseCSR(riscvP riscv, riscvCSRId id) {

    Uns64 result = 0;

    riscvReadCSR(&csrs[id], riscv, &result);

    return result;
}

//
// Write a CSR in the base model given its id
//
Uns64 riscvWriteBaseCSR(riscvP riscv, riscvCSRId id, Uns64 newValue) {

    riscvWriteCSR(&csrs[id], riscv, &newValue);

    return newValue;
}


////////////////////////////////////////////////////////////////////////////////
// MORPH-TIME INTERFACE ACCESS FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Emit warning on first access to an unimplemented CSR
//
static void warnUnimplementedCSR(riscvCSRAttrsCP attrs, riscvP riscv) {

    Uns32 csrNum = attrs->csrNum;

    if(!vmirtGetFirstRangeEntry(&riscv->csrUIMessage, csrNum, csrNum)) {

        vmirtInsertRangeEntry(&riscv->csrUIMessage, csrNum, csrNum, 0);

        vmiMessage("W", CPU_PREFIX"_UICSR",
            SRCREF_FMT
            "Unimplemented CSR (hardwired to zero)",
            SRCREF_ARGS(riscv, getPC(riscv))
        );
    }
}

//
// Emit warning on any access to an inaccessible CSR
//
static void warnInaccessibleCSR(riscvP riscv) {
    vmiMessage("W", CPU_PREFIX"_AICSR",
        SRCREF_FMT
        "Access ignored",
        SRCREF_ARGS(riscv, getPC(riscv))
    );
}

//
// Emit warning on first access to an inaccessible or unimplemented CSR
//
static void emitWarnInaccessibleCSR(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    Bool            implemented
) {
    if(!riscv->verbose) {
        // no action
    } else if(!implemented) {
        vmimtArgNatAddress(attrs);
        vmimtArgProcessor();
        vmimtCall((vmiCallFn)warnUnimplementedCSR);
    } else {
        vmimtArgProcessor();
        vmimtCall((vmiCallFn)warnInaccessibleCSR);
    }
}

//
// If a CSR is inaccessible because required architectural features are absent
// or disabled, return a bitmask of those features
//
static riscvArchitecture getInaccessibleCSRFeaturesMT(
    riscvP          riscv,
    riscvCSRAttrsCP attrs
) {
    riscvArchitecture required = getRequiredCSRFeatures(attrs, riscv);
    riscvArchitecture current  = riscv->currentArch & ~ISA_XLEN_ANY;
    riscvArchitecture access   = attrs->access;
    riscvMode         mode     = getCSRMode5(attrs, riscv);

    // switch to access requirements if required
    if((access&ISA_FS) && vxRequiresFS(riscv)) {
        required = access;
    }

    // add CSR width requirement
    current |= riscvModeIsXLEN64(riscv, mode) ? ISA_XLEN_64 : ISA_XLEN_32;

    // add block mask constraint for variable other-mode XLEN if required
    if((mode!=getCurrentMode5(riscv)) && riscvHasVariableXLEN(riscv, mode)) {

        static riscvArchitecture map[] = {
            [RISCV_MODE_M]  = ISA_MXL64,
            [RISCV_MODE_S]  = ISA_SXL64,
            [RISCV_MODE_U]  = ISA_UXL64,
            [RISCV_MODE_VS] = ISA_VSXL64,
            [RISCV_MODE_VU] = ISA_VUXL64
        };

        // validate other-mode XLEN
        riscvEmitBlockMask(riscv, map[mode]);
    }

    // validate required feature presence
    riscvEmitBlockMask(riscv, required & ~(riscvArchitecture)ISA_and);

    // return any missing features
    return getMissingCSRFeatures(attrs, riscv, required, current);
}

//
// Is this an illegal Debug CSR access in Machine mode?
//
static Bool invalidDebugCSRAccess(riscvP riscv, Uns32 csrNum) {
    return IS_DEBUG_CSR(csrNum) && !inDebugMode(riscv);
}

//
// Function type to perform Stateen check
//
#define STATEEN_CHECK_FN(_NAME) void _NAME(riscvP riscv, Uns32 xstateen)
typedef STATEEN_CHECK_FN((*statenCheckFn));

//
// Emit code to validate Smstateen access constraint
//
static STATEEN_CHECK_FN(validStateen) {
    riscvStateenFeatureEnabled(riscv, xstateen, True);
}

//
// Emit code to perform Stateen check if required
//
static Bool emitStateenCheck(
    riscvP          riscv,
    riscvCSRAttrsCP attrs,
    statenCheckFn   checkCB
) {
    riscvCSRStateenBit xstateen = attrs->Smstateen;
    riscvMode          mode     = getCurrentMode5(riscv);
    Bool               doCheck  = False;

    if(!xstateen) {
        // no Smstateen check for this CSR
    } else if(!riscv->configInfo.Smstateen) {
        // Smstateen not configured
    } else if(mode==RISCV_MODE_M) {
        // no check for M-mode access
    } else {

        // emit call to validate access constraints
        vmimtArgProcessor();
        vmimtArgUns32(xstateen);
        vmimtCall((vmiCallFn)checkCB);

        // terminate this block
        vmimtEndBlock();

        doCheck = True;
    }

    return doCheck;
}

//
// Validate CSR with the given index can be accessed for read or write in the
// current processor mode, and return either a true CSR id or an error code id
//
riscvCSRAttrsCP riscvValidateCSRAccess(
    riscvP riscv,
    Uns32  csrNum,
    Bool   read,
    Bool   write
) {
    riscvCSRAttrsCP   attrs = getCSRAttrs(riscv, csrNum);
    riscvMode         mode  = attrs ? getCSRMode4Raw(attrs) : 0;
    riscvArchitecture missing;

    if(riscv->configInfo.noZicsr) {

        // no CSRs implemented
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "CSR_NI", "Zicsr absent");
        return 0;

    } else if(invalidDebugCSRAccess(riscv, csrNum)) {

        // CSR is not implemented
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "CSR_NA", "Debug CSR not accessible");
        return 0;

    } else if(!attrs || !checkCSRImplemented(attrs, riscv)) {

        // CSR is not implemented
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "CSR_UNIMP", "Unimplemented CSR");
        return 0;

    } else if((missing=getInaccessibleCSRFeaturesMT(riscv, attrs))) {

        // CSR requires missing or disabled features
        riscvRequireArchPresentMT(riscv, missing | ISA_and);
        return 0;

    } else if(write && !(getAccess(attrs) & vmi_RA_W)) {

        // CSR does not have write access
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "CSR_NWA", "CSR has no write access");
        return 0;

    } else if(getCurrentMode4(riscv)>=mode) {

        // CSR access ok - return either CSR or its virtual alias
        if(inVMode(riscv) && attrs->aliasV) {
            attrs = getCSRAttrs(riscv, csrNum+0x100);
        }

        // perform xstateen check for potentially-valid access
        emitStateenCheck(riscv, attrs, validStateen);
        return attrs;

    } else if((mode==RISCV_MODE_M) || !inVMode(riscv)) {

        // attempt to access any CSR from lower-privilege non-virtual mode, or
        // attempt to access M-mode CSR from virtual mode
        riscvEmitIllegalInstructionMode(riscv);
        return 0;

    } else {

        // attempt to access an implemented hypervisor CSR or VS CSR in VS-mode
        // or VU-mode, or attempt to access an implemented supervisor CSR in
        // VU-mode

        // take Illegal Instruction trap if access is denied by mstateen
        emitStateenCheck(riscv, attrs, riscvStateenFeatureEnabledM);

        // otherwise take Virtual Instruction trap
        riscvEmitVirtualInstructionMode(riscv);
        return 0;
    }
}

//
// Return vmiReg for CSR in the current processor mode
//
inline static vmiReg getRawCurrent(riscvCSRAttrsCP attrs, riscvP riscv) {
     return getRawArch(attrs, riscv->currentArch);
}

//
// Return name for CSR in the current processor mode
//
inline static const char *getNameCurrent(riscvCSRAttrsCP attrs, riscvP riscv) {
    return attrs->name;
}

//
// If masking can be implemented by an extending write, return the destination
// bits
//
static Uns32 getCSRMaskExtendBits(Uns64 mask) {

    Uns64 try = -1;
    Uns32 bytes;

    for(bytes=8; bytes && (mask!=try); bytes = bytes/2) {
        try >>= (bytes*4);
    }

    return bytes*8;
}

//
// Emit code to read a CSR
//
void riscvEmitCSRRead(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    vmiReg          rd,
    Bool            isWrite
) {
    Uns32          rdBits  = riscvGetXlenMode(riscv);
    Uns32          csrBits = getCSREffectiveBits(attrs, riscv);
    Uns32          minBits = (rdBits<csrBits) ? rdBits : csrBits;
    riscvCSRReadFn readCB  = getCSRReadCB(attrs, riscv, csrBits, isWrite, False);
    vmiReg         raw     = getRawCurrent(attrs, riscv);
    const char    *name    = getNameCurrent(attrs, riscv);

    // indicate that this register has been read
    vmimtRegReadImpl(name);

    if(readCB) {

        // if CSR is fully implemented externally, mirror the result into any
        // raw register in the model (otherwise discard the result)
        if(!riscvCSRImplementExternalRead(attrs, riscv, True)) {
            raw = VMI_NOREG;
        }

        // emit code to call the write function
        vmimtArgNatAddress(attrs);
        vmimtArgProcessor();
        vmimtCallResult((vmiCallFn)readCB, minBits, rd);
        vmimtMoveExtendRR(rdBits, rd, minBits, rd, False);
        vmimtMoveRR(rdBits, raw, rd);

    } else if(VMI_ISNOREG(raw)) {

        // emit warning for unimplemented CSR
        Bool implemented = getCSRWriteCB(attrs, riscv, csrBits);
        emitWarnInaccessibleCSR(attrs, riscv, implemented);
        vmimtMoveRC(rdBits, rd, 0);

    } else {

        // simple register read
        vmimtMoveExtendRR(rdBits, rd, minBits, raw, False);
    }
}

//
// Emit code to write a CSR
//
void riscvEmitCSRWrite(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    vmiReg          rd,
    vmiReg          rs,
    vmiReg          tmp
) {
    Uns32           rsBits  = riscvGetXlenMode(riscv);
    Uns32           csrBits = getCSREffectiveBits(attrs, riscv);
    Uns32           minBits = (rsBits<csrBits) ? rsBits : csrBits;
    riscvCSRWriteFn writeCB = getCSRWriteCB(attrs, riscv, csrBits);
    vmiReg          raw     = getRawCurrent(attrs, riscv);
    Uns64           mask    = getCSRWriteMask(attrs, riscv);
    const char     *name    = getNameCurrent(attrs, riscv);
    Uns32           extBits;

    // indicate that this register has been written
    vmimtRegWriteImpl(name);

    if(writeCB) {

        // if CSR is implemented externally, mirror the result into any raw
        // register in the model (otherwise discard the result)
        if(!riscvCSRImplementExternalWrite(attrs, riscv)) {
            raw = attrs->writeRd ? rd : VMI_NOREG;
        }

        // emit code to call the write function (NOTE: argument is always 64
        // bits, irrespective of the architecture size)
        vmimtArgNatAddress(attrs);
        vmimtArgProcessor();
        vmimtArgRegSimAddress(rsBits, rs);
        vmimtCallResult((vmiCallFn)writeCB, rsBits, raw);

        // terminate the current block if required
        if(attrs->wEndBlock) {
            vmimtEndBlock();
        }

    } else if(VMI_ISNOREG(raw)) {

        // emit warning for unimplemented CSR
        Bool implemented = getCSRReadCB(attrs, riscv, csrBits, False, False);
        emitWarnInaccessibleCSR(attrs, riscv, implemented);

    } else if((extBits=getCSRMaskExtendBits(mask))) {

        // get size of source for extend
        Uns32 srcBits = (minBits<extBits) ? minBits : extBits;

        // new value is written unmasked
        vmimtMoveExtendRR(extBits, raw, srcBits, rs, False);

    } else if(mask) {

        // apparent reads of register below are artifacts only
        vmimtRegNotReadR(minBits, raw);

        // new value is written masked
        vmimtBinopRC(minBits, vmi_ANDN, raw, mask, 0);
        vmimtBinopRRC(minBits, vmi_AND, tmp, rs, mask, 0);
        vmimtBinopRR(minBits, vmi_OR, raw, tmp, 0);

        // extend value to CSR bits
        vmimtMoveExtendRR(csrBits, raw, minBits, raw, False);
    }
}


////////////////////////////////////////////////////////////////////////////////
// CSR ITERATOR
////////////////////////////////////////////////////////////////////////////////

//
// Iterator filling 'details' with the next CSR register details. The value
// pointed to by 'csrNumP' should be initialized to zero prior to the first call
// and is used by this function to manage the iteration.
//
Bool riscvGetCSRDetails(
    riscvP           riscv,
    riscvCSRDetailsP details,
    Uns32           *csrNumP
) {
    riscvArchitecture arch = riscv->configInfo.arch;
    riscvCSRAttrsCP   attrs;

    while((attrs=getNextCSR(riscv, csrNumP))) {

        if(checkCSRPresent(attrs, riscv)) {

            Uns32 bits = getCSREffectiveBits(attrs, riscv);

            // fill basic details
            details->attrs  = attrs;
            details->mode   = getCSRMode4(attrs, riscv);
            details->bits   = bits;
            details->raw    = getRawArch(attrs, arch);
            details->access = getAccess(attrs);

            // indicate whether raw read access is possible
            details->rdRaw = (
                (details->access & vmi_RA_R) &&
                !getCSRReadCB(attrs, riscv, bits, False, True)
            );

            // indicate whether raw write access is possible
            details->wrRaw = (
                (details->access & vmi_RA_W) &&
                !getCSRWriteCB(attrs, riscv, bits) &&
                !getWriteMaskCArch(attrs, arch) &&
                VMI_ISNOREG(getWriteMaskVArch(attrs, arch))
            );

            // indicate whether this is an extension library register
            details->extension = attrs->object;

            return True;
        }
    }

    return False;
}


////////////////////////////////////////////////////////////////////////////////
// CSR COMMANDS
////////////////////////////////////////////////////////////////////////////////

//
// Callback for individual register query command
//
static VMIRT_COMMAND_PARSE_FN(getCSRIndex) {

    riscvP          riscv  = (riscvP)processor;
    const char     *name   = argv[0].u.string;
    Uns32           csrNum = 0;
    Bool            match  = False;
    riscvCSRAttrsCP attrs;

    // scan for first CSR with matching name
    while(!match && (attrs=getNextCSR(riscv, &csrNum))) {
        if(checkCSRPresent(attrs, riscv) && attrs->name) {
            match = !strcmp(name, attrs->name);
        }
    }

    // return CSR number or -1 if no match
    if(!match) {
        return "-1";
    } else {
        sprintf(riscv->tmpString, "0x%03x", attrs->csrNum);
        return riscv->tmpString;
    }
}

//
// Callback for all registers query command
//
static VMIRT_COMMAND_PARSE_FN(listCSRs) {

    riscvP          riscv  = (riscvP)processor;
    Uns32           bits   = riscvGetXlenMode(riscv);
    Uns32           csrNum = 0;
    Uns32           count  = 0;
    riscvCSRAttrsCP attrs;

    // scan for first CSR with matching name
    while((attrs=getNextCSR(riscv, &csrNum))) {

        Uns64 value = 0;

        if(riscvReadCSR(attrs, riscv, &value)) {

            char valueString[32];

            if(bits==32) {
                sprintf(valueString, FMT_6408x, value);
            } else {
                sprintf(valueString, FMT_640Nx, value);
            }

            vmiPrintf(
                "0x%03x %-16s 0x%s\n", attrs->csrNum, attrs->name, valueString
            );

            count++;
        }
    }

    // return number of CSRs
    sprintf(riscv->tmpString, "%u", count);
    return riscv->tmpString;
}

//
// Add CSR commands
//
void riscvAddCSRCommands(riscvP riscv) {

    vmiProcessorP processor = (vmiProcessorP)riscv;

    ////////////////////////////////////////////////////////////////////////////
    // Command to get index of a named CSR
    ////////////////////////////////////////////////////////////////////////////

    vmiCommandP regIndex = vmirtAddCommandParse(
        processor,
        "getCSRIndex",
        "Return index for a named CSR (or -1 if no matching CSR)",
        getCSRIndex,
        VMI_CT_QUERY|VMI_CA_QUERY
    );

    vmirtAddArg(
        regIndex,
        "name",
        "CSR name",
        VMI_CA_STRING,
        VMI_CAA_MENU,
        True,
        0
    );

    ////////////////////////////////////////////////////////////////////////////
    // Command to list all CSRs
    ////////////////////////////////////////////////////////////////////////////

    vmirtAddCommandParse(
        processor,
        "listCSRs",
        "List all CSRs in index order",
        listCSRs,
        VMI_CT_QUERY|VMI_CA_QUERY
    );
}


////////////////////////////////////////////////////////////////////////////////
// SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Switch CSR state to the configured XLEN (save/restore)
//
static void toConfiguredXLSR(riscvP riscv) {

    Uns8 oldMXL = RD_CSR_FIELD_M(riscv, misa, MXL);
    Uns8 newMXL = riscv->configInfo.arch>>XLEN_SHIFT;

    // change from active MXL to configured MXL
    setMXL(riscv, oldMXL, newMXL);

    riscv->xlenMask = (newMXL==2) ? -1 : 0;
}

//
// Switch CSR state from the configured XLEN (save/restore)
//
static void fromConfiguredXLSR(riscvP riscv) {

    Uns8 oldMXL = RD_CSR_FIELD_M(riscv, misa, MXL);
    Uns8 newMXL = (riscv->xlenMaskSR & (1<<RISCV_MODE_M)) ? 2 : 1;

    // change from active MXL to configured MXL
    setMXL(riscv, oldMXL, newMXL);

    // restore active XLEN
    riscv->xlenMask = riscv->xlenMaskSR;
}

//
// Save CSR state not covered by register read/write API
//
void riscvCSRSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
) {
    switch(phase) {

        case SRT_BEGIN:
            // start of SMP cluster
            break;

        case SRT_BEGIN_CORE:

            // start of individual core - save active xlenMask
            riscv->xlenMaskSR = riscv->xlenMask;

            // switch CSR state to the configured XLEN
            toConfiguredXLSR(riscv);

            // force into XLEN=64 mode if required
            VMIRT_SAVE_FIELD(cxt, riscv, xlenMaskSR);

            break;

        case SRT_END_CORE:

            // end of individual core
            VMIRT_SAVE_FIELD(cxt, riscv, baseCycles);
            VMIRT_SAVE_FIELD(cxt, riscv, baseInstructions);

            // read-only vector register state requires explicit save
            if(vectorPresent(riscv)) {
                VMIRT_SAVE_FIELD(cxt, riscv, csr.vl);
                VMIRT_SAVE_FIELD(cxt, riscv, csr.vtype);
            }

            // read-only CLIC register state requires explicit save
            if(CLICPresent(riscv)) {
                VMIRT_SAVE_FIELD(cxt, riscv, csr.mintstatus);
            }

            // switch CSR state from the configured XLEN
            fromConfiguredXLSR(riscv);

            break;

        case SRT_END:
            // end of SMP cluster
            break;

        default:
            // not reached
            VMI_ABORT("unimplemented case"); // LCOV_EXCL_LINE
            break;
    }
}

//
// Restore CSR state not covered by register read/write API
//
void riscvCSRRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
) {
    switch(phase) {

        case SRT_BEGIN:
            // start of SMP cluster
            break;

        case SRT_BEGIN_CORE:

            // start of individual core - switch CSR state to the configured XLEN
            toConfiguredXLSR(riscv);

            // restore active XLEN
            VMIRT_RESTORE_FIELD(cxt, riscv, xlenMaskSR);

            break;

        case SRT_END_CORE:

            // end of individual core
            VMIRT_RESTORE_FIELD(cxt, riscv, baseCycles);
            VMIRT_RESTORE_FIELD(cxt, riscv, baseInstructions);

            // read-only vector register state requires explicit restore
            if(vectorPresent(riscv)) {
                VMIRT_RESTORE_FIELD(cxt, riscv, csr.vl);
                VMIRT_RESTORE_FIELD(cxt, riscv, csr.vtype);
                refreshVLEEW1(riscv);
                riscvRefreshVectorPMKey(riscv);
            }

            // read-only CLIC register state requires explicit restore
            if(CLICPresent(riscv)) {
                VMIRT_RESTORE_FIELD(cxt, riscv, csr.mintstatus);
            }

            // switch CSR state from the configured XLEN
            fromConfiguredXLSR(riscv);

            // update mode to take account of active XL
            riscvSetMode(riscv, getCurrentMode5(riscv));

            break;

        case SRT_END:
            // end of SMP cluster
            break;

        default:
            // not reached
            VMI_ABORT("unimplemented case"); // LCOV_EXCL_LINE
            break;
    }
}

