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
#include <stdio.h>
#include <string.h>

// VMI header files
#include "vmi/vmiAttrs.h"
#include "vmi/vmiCommand.h"
#include "vmi/vmiMessage.h"
#include "vmi/vmiRt.h"

// Model header files
#include "riscvCLIC.h"
#include "riscvCluster.h"
#include "riscvBus.h"
#include "riscvConfig.h"
#include "riscvCSR.h"
#include "riscvDebug.h"
#include "riscvDecode.h"
#include "riscvDisassemble.h"
#include "riscvDoc.h"
#include "riscvExceptions.h"
#include "riscvFunctions.h"
#include "riscvKExtension.h"
#include "riscvMessage.h"
#include "riscvMorph.h"
#include "riscvParameters.h"
#include "riscvStructure.h"
#include "riscvTrigger.h"
#include "riscvUtils.h"
#include "riscvVM.h"
#include "riscvVMConstants.h"


//
// Initialize enhanced model support callbacks that apply at all levels
//
static void initAllModelCBs(riscvP riscv) {

    // from riscvUtils.h
    riscv->cb.registerExtCB    = riscvRegisterExtCB;
    riscv->cb.getExtClientData = riscvGetExtClientData;
    riscv->cb.getExtConfig     = riscvGetExtConfig;
}

//
// Initialize enhanced model support callbacks that apply at leaf levels
//
static void initLeafModelCBs(riscvP riscv) {

    // from riscvUtils.h
    riscv->cb.getXlenMode        = riscvGetXlenMode;
    riscv->cb.getXlenArch        = riscvGetXlenArch;
    riscv->cb.getXRegName        = riscvGetXRegName;
    riscv->cb.getFRegName        = riscvGetFRegName;
    riscv->cb.getVRegName        = riscvGetVRegName;
    riscv->cb.setTMode           = riscvSetTMode;
    riscv->cb.getTMode           = riscvGetTMode;
    riscv->cb.getDataEndian      = riscvGetDataEndian;
    riscv->cb.readCSR            = riscvReadCSRNum;
    riscv->cb.writeCSR           = riscvWriteCSRNum;
    riscv->cb.readBaseCSR        = riscvReadBaseCSR;
    riscv->cb.writeBaseCSR       = riscvWriteBaseCSR;

    // from riscvExceptions.h
    riscv->cb.halt               = riscvHalt;
    riscv->cb.restart            = riscvRestart;
    riscv->cb.updateInterrupt    = riscvUpdateInterrupt;
    riscv->cb.updateDisable      = riscvUpdateInterruptDisable;
    riscv->cb.testInterrupt      = riscvUpdatePending;
    riscv->cb.illegalInstruction = riscvIllegalInstruction;
    riscv->cb.illegalVerbose     = riscvIllegalInstructionMessage;
    riscv->cb.virtualInstruction = riscvVirtualInstruction;
    riscv->cb.virtualVerbose     = riscvVirtualInstructionMessage;
    riscv->cb.takeException      = riscvTakeAsynchonousException;
    riscv->cb.takeReset          = riscvReset,

    // from riscvDecode.h
    riscv->cb.fetchInstruction   = riscvExtFetchInstruction;

    // from riscvDisassemble.h
    riscv->cb.disassInstruction  = riscvDisassembleInstruction;

    // from riscvMorph.h
    riscv->cb.instructionEnabled = riscvInstructionEnabled;
    riscv->cb.morphExternal      = riscvMorphExternal;
    riscv->cb.morphIllegal       = riscvEmitIllegalInstructionMessage;
    riscv->cb.morphVirtual       = riscvEmitVirtualInstructionMessage;
    riscv->cb.getVMIReg          = riscvGetVMIReg;
    riscv->cb.getVMIRegFS        = riscvGetVMIRegFS;
    riscv->cb.writeRegSize       = riscvWriteRegSize;
    riscv->cb.writeReg           = riscvWriteReg;
    riscv->cb.getFPFlagsMt       = riscvGetFPFlagsMT;
    riscv->cb.getDataEndianMt    = riscvGetCurrentDataEndianMT;
    riscv->cb.requireModeMt      = riscvEmitRequireMode;
    riscv->cb.requireNotVMt      = riscvEmitRequireNotV;
    riscv->cb.checkLegalRMMt     = riscvEmitCheckLegalRM;
    riscv->cb.morphTrapTVM       = riscvEmitTrapTVM;
    riscv->cb.morphVOp           = riscvMorphVOp;

    // from riscvCSR.h
    riscv->cb.newCSR             = riscvNewCSR;

    // from riscvVM.h
    riscv->cb.mapAddress         = riscvVMMiss;
    riscv->cb.unmapPMPRegion     = riscvVMUnmapPMPRegion;
    riscv->cb.updateLdStDomain   = riscvVMRefreshMPRVDomain;
    riscv->cb.newTLBEntry        = riscvVMNewTLBEntry;
    riscv->cb.freeTLBEntry       = riscvVMFreeTLBEntry;
}

//
// Return processor configuration using variant argument
//
static riscvConfigCP getConfigVariantArg(riscvP riscv, riscvParamValuesP params) {

    riscvConfigCP cfgList = riscvGetConfigList(riscv);
    riscvConfigCP match;

    if(riscvIsClusterMember(riscv)) {

        match = riscvGetNamedConfig(cfgList, riscvGetClusterVariant(riscv));

    } else {

        match = cfgList + params->variant;

        // report the value specified for an option in verbose mode
        if(!params->SETBIT(variant)) {
            vmiMessage("I", CPU_PREFIX"_ANS1",
                "Attribute '%s' not specified; defaulting to '%s'",
                "variant",
                match->name
            );
        }
    }

    // return matching configuration
    return match;
}

//
// Return the number of child processors of the given processor
//
inline static riscvP getParent(riscvP riscv) {
    return (riscvP)vmirtGetSMPParent((vmiProcessorP)riscv);
}

//
// Return the number of child processors of the given processor
//
inline static Uns32 getNumChildren(riscvP riscv) {
    return riscv->configInfo.numHarts;
}

//
// Give each sub-processor a unique name
//
VMI_SMP_NAME_FN(riscvGetSMPName) {

    const char   *baseName = vmirtProcessorName(parent);
    riscvP        rvParent = (riscvP)parent;
    riscvConfigCP cfg      = &rvParent->configInfo;

    if(riscvIsCluster(rvParent)) {
        sprintf(name, "%s_%s", baseName, cfg->members[smpIndex]);
    } else {
        sprintf(name, "%s_hart%u", baseName, cfg->csr.mhartid.u32.bits+smpIndex);
    }
}

//
// Return value adjusted to a power of two
//
static Uns64 powerOfTwo(Uns64 oldValue, const char *name) {

    Uns64 newValue = oldValue;

    // adjust newValue to a power of 2
    while(newValue & ~(newValue&-newValue)) {
        newValue &= ~(newValue&-newValue);
    }

    // warn if given oldValue was not a power of 2
    if(oldValue != newValue) {
        vmiMessage("W", CPU_PREFIX"_GNP2",
            "'%s' ("FMT_Au") is not a power of 2 - using "FMT_Au,
            name, oldValue, newValue
        );
    }

    return newValue;
}

//
// Report extensions that are fixed
//
static void reportFixed(riscvArchitecture fixed, riscvConfigP cfg) {

    char  fixedString[32] = {0};
    Uns32 dst             = 0;
    Uns32 src;

    for(src=0; fixed; src++) {

        Uns32 mask = 1<<src;

        if(fixed & mask) {
            fixed &= ~mask;
            fixedString[dst++] = 'A'+src;
        }
    }

    vmiMessage("W", CPU_PREFIX"_IEXT",
        "Extension%s %s may not be enabled or disabled on %s variant",
        (dst==1) ? "" : "s",
        fixedString,
        cfg->name
    );
}

//
// Handle parameters that are overridden only if explicitly set
//
#define EXPLICIT_PARAM(_CFG, _PARAMS, _CNAME, _PNAME) \
    if(_PARAMS->SETBIT(_PNAME)) {               \
        _CFG->_CNAME = _PARAMS->_PNAME;         \
    }

//
// Handle parameters that require a commercial product
//
#define REQUIRE_COMMERCIAL(_PROC, _PARAMS, _NAME) \
    if(_PARAMS->SETBIT(_NAME)) {                \
        _PROC->commercial = True;               \
    }

//
// Handle absent bit manipulation subsets
//
#define ADD_BM_SET(_PROC, _CFG, _PARAMS, _NAME) { \
    if(!_PARAMS->_NAME) {                       \
        _CFG->bitmanip_absent |= RVBS_##_NAME;  \
    }                                           \
    REQUIRE_COMMERCIAL(_PROC, _PARAMS, _NAME);  \
}

//
// Handle absent cryptographic subsets
//
#define ADD_K_SET(_PROC, _CFG, _PARAMS, _NAME) { \
    if(!_PARAMS->_NAME) {                       \
        _CFG->crypto_absent |= RVKS_##_NAME;    \
    }                                           \
    REQUIRE_COMMERCIAL(_PROC, _PARAMS, _NAME);  \
}

//
// Handle absent cryptographic subsets, alternative parameter names
//
#define ADD_K_SET2(_PROC, _CFG, _PARAMS, _NAME1, _NAME2) { \
    if(_PARAMS->SETBIT(_NAME1)) {                   \
        ADD_K_SET(_PROC, _CFG, _PARAMS, _NAME1);    \
    } else {                                        \
        ADD_K_SET(_PROC, _CFG, _PARAMS, _NAME2);    \
    }                                               \
}

//
// If sext is True, return the number of zero bits at the top of the mask
//
static Uns32 getSExtendBits(Bool sext, Int64 mask) {

    Uns32 result = 0;

    if(!sext) {
        // no action
    } else while(mask>0) {
        mask <<= 1;
        result++;
    }

    return result;
}

//
// Names for embedded profiles
//
static const char *VNames[] = {
    [RVVS_Zve32x] ="Zve32x",
    [RVVS_Zve32f] ="Zve32f",
    [RVVS_Zve64x] ="Zve32x",
    [RVVS_Zve64f] ="Zve32f",
    [RVVS_Zve64d] ="Zve32d",
};

//
// Return selected Vector Extension embedded profile (one only)
//
static riscvVectorSet selectVProfile(riscvVectorSet old, riscvVectorSet new) {

    if(old) {
        vmiMessage("W", CPU_PREFIX"_IDVP",
            "'%s' parameter ignored because '%s' already set",
            VNames[new], VNames[old]
        );
    }

    return old ? old : new;
}

//
// Macro selecting at most one Vector Extension embedded profile
//
#define SELECT_V_PROFILE(_PARAMS, _CUR, _NEW) \
    if(_PARAMS->_NEW) {                             \
        _CUR = selectVProfile(_CUR, RVVS_##_NEW);   \
    }

//
// Set implied vector extension profile
//
static void setVProfile(riscvP riscv, riscvParamValuesP params) {

    riscvConfigP   cfg = &riscv->configInfo;
    Bool           F   = cfg->arch & ISA_F;
    Bool           D   = cfg->arch & ISA_D;
    riscvVectorSet V   = RVVS_Application;

    // get selected embedded profile
    SELECT_V_PROFILE(params, V, Zve32x);
    SELECT_V_PROFILE(params, V, Zve32f);
    SELECT_V_PROFILE(params, V, Zve64x);
    SELECT_V_PROFILE(params, V, Zve64f);
    SELECT_V_PROFILE(params, V, Zve64d);

    if(V==RVVS_Application) {

        // application profile: enable F and D extensions if enabled in the base
        if(F) {V |= RVVS_F;}
        if(D) {V |= RVVS_D;}

    } else {

        // embedded profile
        cfg->ELEN = ((V&RVVS_EEW64) ? 64 : 32);

        riscvVectorSet new = V;

        if((V&RVVS_F) && !F) {
            new = V & ~(RVVS_F|RVVS_D);
            vmiMessage("W", CPU_PREFIX"_IDVF",
                "'%s' disabled because F extension absent - using %s",
                VNames[V], VNames[new]
            );
        } else if((V&RVVS_D) && !D) {
            new = V & ~RVVS_D;
            vmiMessage("W", CPU_PREFIX"_IDVD",
                "'%s' disabled because D extension absent - using %s",
                VNames[V], VNames[new]
            );
        }

        V = new;
    }

    cfg->vect_profile = V;
}

//
// Apply parameters applicable to SMP member
//
static void applyParamsSMP(riscvP riscv, riscvParamValuesP params) {

    riscvConfigP cfg = &riscv->configInfo;

    // set simulation controls
    riscv->verbose       = params->verbose;
    riscv->traceVolatile = params->traceVolatile;

    // set data endian (instruction fetch is always little-endian)
    riscv->dendian = params->endian;

    // get architectural configuration parameters
    Int32 lr_sc_grain = params->lr_sc_grain;

    // get uninterpreted CSR configuration parameters
    cfg->csr.mvendorid.u64.bits    = params->mvendorid;
    cfg->csr.marchid.u64.bits      = params->marchid;
    cfg->csr.mimpid.u64.bits       = params->mimpid;
    cfg->csr.mhartid.u64.bits      = params->mhartid;
    cfg->csr.mtvec.u64.bits        = params->mtvec;
    cfg->csr.mstatus.u32.fields.FS = params->mstatus_FS;
    cfg->csr.mclicbase.u64.bits    = params->mclicbase;

    // get uninterpreted CSR mask configuration parameters
    cfg->csrMask.mtvec.u64.bits = params->mtvec_mask;
    cfg->csrMask.stvec.u64.bits = params->stvec_mask;
    cfg->csrMask.utvec.u64.bits = params->utvec_mask;
    cfg->csrMask.mtvt.u64.bits  = params->mtvt_mask;
    cfg->csrMask.stvt.u64.bits  = params->stvt_mask;
    cfg->csrMask.utvt.u64.bits  = params->utvt_mask;

    // get implied CSR sign extension configuration parameters
    cfg->mtvec_sext = getSExtendBits(params->mtvec_sext, params->mtvec_mask);
    cfg->stvec_sext = getSExtendBits(params->stvec_sext, params->stvec_mask);
    cfg->utvec_sext = getSExtendBits(params->utvec_sext, params->utvec_mask);
    cfg->mtvt_sext  = getSExtendBits(params->mtvt_sext,  params->mtvt_mask);
    cfg->stvt_sext  = getSExtendBits(params->stvt_sext,  params->stvt_mask);
    cfg->utvt_sext  = getSExtendBits(params->utvt_sext,  params->utvt_mask);

    // handle parameters that are overridden only if explicitly set (affects
    // disassembly of instructions for extensions that are not configured)
    EXPLICIT_PARAM(cfg, params, vect_version,     vector_version);
    EXPLICIT_PARAM(cfg, params, bitmanip_version, bitmanip_version);
    EXPLICIT_PARAM(cfg, params, crypto_version,   crypto_version);

    // handle alias parameters fp16_version and Zfh
    EXPLICIT_PARAM(cfg, params, fp16_version, Zfh);
    EXPLICIT_PARAM(cfg, params, fp16_version, fp16_version);

    // get uninterpreted architectural configuration parameters
    cfg->endianFixed         = params->endianFixed;
    cfg->ABI_d               = params->ABI_d;
    cfg->user_version        = params->user_version;
    cfg->priv_version        = params->priv_version;
    cfg->hyp_version         = params->hypervisor_version;
    cfg->dbg_version         = params->debug_version;
    cfg->rnmi_version        = params->rnmi_version;
    cfg->CLIC_version        = params->CLIC_version;
    cfg->Zfinx_version       = params->Zfinx_version;
    cfg->mstatus_fs_mode     = params->mstatus_fs_mode;
    cfg->agnostic_ones       = params->agnostic_ones;
    cfg->MXL_writable        = params->MXL_writable;
    cfg->SXL_writable        = params->SXL_writable;
    cfg->UXL_writable        = params->UXL_writable;
    cfg->VSXL_writable       = params->VSXL_writable;
    cfg->reset_address       = params->reset_address;
    cfg->nmi_address         = params->nmi_address;
    cfg->nmiexc_address      = params->nmiexc_address;
    cfg->ASID_cache_size     = params->ASID_cache_size;
    cfg->ASID_bits           = params->ASID_bits;
    cfg->VMID_bits           = params->VMID_bits;
    cfg->trigger_num         = params->trigger_num;
    cfg->tinfo               = params->tinfo;
    cfg->mcontext_bits       = params->mcontext_bits;
    cfg->scontext_bits       = params->scontext_bits;
    cfg->mvalue_bits         = params->mvalue_bits;
    cfg->svalue_bits         = params->svalue_bits;
    cfg->mcontrol_maskmax    = params->mcontrol_maskmax;
    cfg->dcsr_ebreak_mask    = params->dcsr_ebreak_mask;
    cfg->PMP_grain           = params->PMP_grain;
    cfg->PMP_registers       = params->PMP_registers;
    cfg->PMP_max_page        = powerOfTwo(params->PMP_max_page, "PMP_max_page");
    cfg->PMP_decompose       = params->PMP_decompose;
    cfg->Sv_modes            = params->Sv_modes | RISCV_VMM_BARE;
    cfg->local_int_num       = params->local_int_num;
    cfg->unimp_int_mask      = params->unimp_int_mask;
    cfg->ecode_mask          = params->ecode_mask;
    cfg->ecode_nmi_mask      = params->ecode_nmi_mask;
    cfg->ecode_nmi           = params->ecode_nmi;
    cfg->external_int_id     = params->external_int_id;
    cfg->force_mideleg       = params->force_mideleg;
    cfg->force_sideleg       = params->force_sideleg;
    cfg->no_ideleg           = params->no_ideleg;
    cfg->no_edeleg           = params->no_edeleg;
    cfg->lr_sc_grain         = powerOfTwo(lr_sc_grain, "lr_sc_grain");
    cfg->debug_mode          = params->debug_mode;
    cfg->debug_address       = params->debug_address;
    cfg->dexc_address        = params->dexc_address;
    cfg->debug_eret_mode     = params->debug_eret_mode;
    cfg->updatePTEA          = params->updatePTEA;
    cfg->updatePTED          = params->updatePTED;
    cfg->unaligned           = params->unaligned;
    cfg->unalignedAMO        = params->unalignedAMO;
    cfg->wfi_is_nop          = params->wfi_is_nop;
    cfg->mtvec_is_ro         = params->mtvec_is_ro;
    cfg->counteren_mask      = params->counteren_mask;
    cfg->noinhibit_mask      = params->noinhibit_mask;
    cfg->tvec_align          = params->tvec_align;
    cfg->tval_zero           = params->tval_zero;
    cfg->tval_zero_ebreak    = params->tval_zero_ebreak;
    cfg->tval_ii_code        = params->tval_ii_code;
    cfg->cycle_undefined     = params->cycle_undefined;
    cfg->time_undefined      = params->time_undefined;
    cfg->instret_undefined   = params->instret_undefined;
    cfg->tinfo_undefined     = params->tinfo_undefined;
    cfg->tcontrol_undefined  = params->tcontrol_undefined;
    cfg->mcontext_undefined  = params->mcontext_undefined;
    cfg->scontext_undefined  = params->scontext_undefined;
    cfg->mscontext_undefined = params->mscontext_undefined;
    cfg->hcontext_undefined  = params->hcontext_undefined;
    cfg->amo_trigger         = params->amo_trigger;
    cfg->no_hit              = params->no_hit;
    cfg->no_sselect_2        = params->no_sselect_2;
    cfg->enable_CSR_bus      = params->enable_CSR_bus;
    cfg->d_requires_f        = params->d_requires_f;
    cfg->enable_fflags_i     = params->enable_fflags_i;
    cfg->xret_preserves_lr   = params->xret_preserves_lr;
    cfg->require_vstart0     = params->require_vstart0;
    cfg->align_whole         = params->align_whole;
    cfg->vill_trap           = params->vill_trap;
    cfg->mstatus_FS_zero     = params->mstatus_FS_zero;
    cfg->ELEN                = powerOfTwo(params->ELEN,      "ELEN");
    cfg->VLEN = cfg->SLEN    = powerOfTwo(params->VLEN,      "VLEN");
    cfg->EEW_index           = powerOfTwo(params->EEW_index, "EEW_index");
    cfg->SEW_min             = powerOfTwo(params->SEW_min,   "SEW_min");
    cfg->Zvlsseg             = params->Zvlsseg;
    cfg->Zvamo               = params->Zvamo;
    cfg->Zvediv              = params->Zvediv;
    cfg->CLICLEVELS          = params->CLICLEVELS;
    cfg->CLICANDBASIC        = params->CLICANDBASIC;
    cfg->CLICVERSION         = params->CLICVERSION;
    cfg->CLICINTCTLBITS      = params->CLICINTCTLBITS;
    cfg->CLICCFGMBITS        = params->CLICCFGMBITS;
    cfg->CLICCFGLBITS        = params->CLICCFGLBITS;
    cfg->CLICSELHVEC         = params->CLICSELHVEC;
    cfg->CLICXNXTI           = params->CLICXNXTI;
    cfg->CLICXCSW            = params->CLICXCSW;
    cfg->externalCLIC        = params->externalCLIC;
    cfg->tvt_undefined       = params->tvt_undefined;
    cfg->intthresh_undefined = params->intthresh_undefined;
    cfg->mclicbase_undefined = params->mclicbase_undefined;
    cfg->posedge_0_63        = params->posedge_0_63;
    cfg->poslevel_0_63       = params->poslevel_0_63;
    cfg->posedge_other       = params->posedge_other;
    cfg->poslevel_other      = params->poslevel_other;
    cfg->GEILEN              = params->GEILEN;
    cfg->xtinst_basic        = params->xtinst_basic;
    cfg->noZicsr             = !params->Zicsr;
    cfg->noZifencei          = !params->Zifencei;

    ////////////////////////////////////////////////////////////////////////////
    // FUNDAMENTAL CONFIGURATION
    ////////////////////////////////////////////////////////////////////////////

    // set number of children
    Bool isSMPMember = riscv->parent && !riscvIsCluster(riscv->parent);
    cfg->numHarts = isSMPMember ? 0 : params->numHarts;

    // get specified MXL
    Uns32 misa_MXL = params->misa_MXL;

    if(misa_MXL==1) {

        // modify configuration for 32-bit cores - MXL/SXL/UXL/VSXL not writable
        cfg->MXL_writable  = False;
        cfg->SXL_writable  = False;
        cfg->UXL_writable  = False;
        cfg->VSXL_writable = False;

        // mask valid VM modes
        cfg->Sv_modes &= RISCV_VMM_32;

    } else if(!(cfg->SXL_writable || cfg->VSXL_writable)) {

        // modify configuration for 64-bit cores

        // mask valid VM modes
        cfg->Sv_modes &= RISCV_VMM_64;
    }

    // get explicit extensions and extension mask
    riscvArchitecture misa_Extensions      = params->misa_Extensions;
    riscvArchitecture misa_Extensions_mask = params->misa_Extensions_mask;

    // exclude/include extensions specified by letter
    misa_Extensions      &= ~riscvParseExtensions(params->sub_Extensions);
    misa_Extensions_mask &= ~riscvParseExtensions(params->sub_Extensions_mask);
    misa_Extensions      |=  riscvParseExtensions(params->add_Extensions);
    misa_Extensions_mask |=  riscvParseExtensions(params->add_Extensions_mask);

    // if the H extension is implemented then S and U must also be present
    if(misa_Extensions & ISA_H) {
        misa_Extensions |= (ISA_S|ISA_U);
    }

    // exactly one of I and E base ISA features must be present and initially
    // enabled; if the E bit is initially enabled, the I bit must be read-only
    // and zero
    if(misa_Extensions & ISA_E) {
        misa_Extensions &= ~ISA_I;
    } else {
        misa_Extensions |= ISA_I;
    }

    // get extensions before masking for fixed
    riscvArchitecture rawExtensions = misa_Extensions;

    // bits in the misa fixed mask may not be updated
    misa_Extensions = (
        (cfg->arch       &  cfg->archFixed) |
        (misa_Extensions & ~cfg->archFixed)
    );

    // report extensions that are fixed and may not be modified
    riscvArchitecture fixed = (rawExtensions^misa_Extensions) & ((1<<26)-1);
    if(fixed && !getNumChildren(riscv)) {
        reportFixed(fixed, cfg);
    }

    // the E bit is always read only (it is a complement of the I bit)
    misa_Extensions_mask &= ~ISA_E;

    // only bits that are initially non-zero in misa_Extensions are writable
    misa_Extensions_mask &= misa_Extensions;

    // from Zfinx version 0.41, misa.[FDQ] are read-only
    if(cfg->Zfinx_version>=RVZFINX_0_41) {
        misa_Extensions_mask &= ~(ISA_F|ISA_D|ISA_Q);
    }

    // define architecture and writable bits
    Uns32 misa_MXL_mask = cfg->MXL_writable ? 3 : 0;
    cfg->arch     = misa_Extensions      | (misa_MXL<<XLEN_SHIFT);
    cfg->archMask = misa_Extensions_mask | (misa_MXL_mask<<XLEN_SHIFT);

    // enable_fflags_i can only be set if floating point is present
    cfg->enable_fflags_i = cfg->enable_fflags_i && (cfg->arch&ISA_DF);

    // initialize ISA_XLEN in currentArch and matching xlenMask (required so
    // WR_CSR_FIELD etc work correctly)
    riscv->currentArch = misa_MXL<<XLEN_SHIFT;
    riscv->xlenMask    = (misa_MXL==2) ? -1 : 0;

    // set tag mask
    riscv->exclusiveTagMask = -lr_sc_grain;

    // allocate CSR remap list
    riscvNewCSRRemaps(riscv, params->CSR_remap);

    ////////////////////////////////////////////////////////////////////////////
    // VALIDATE COMMERCIAL FEATURES
    ////////////////////////////////////////////////////////////////////////////

    // some F-extension parameters require a commercial product
    REQUIRE_COMMERCIAL(riscv, params, Zfinx_version);

    // some V-extension parameters require a commercial product
    REQUIRE_COMMERCIAL(riscv, params, Zvlsseg);
    REQUIRE_COMMERCIAL(riscv, params, Zvamo);
    REQUIRE_COMMERCIAL(riscv, params, Zvqmac);
    REQUIRE_COMMERCIAL(riscv, params, Zvediv);
    REQUIRE_COMMERCIAL(riscv, params, Zve32x);
    REQUIRE_COMMERCIAL(riscv, params, Zve32f);
    REQUIRE_COMMERCIAL(riscv, params, Zve64x);
    REQUIRE_COMMERCIAL(riscv, params, Zve64f);
    REQUIRE_COMMERCIAL(riscv, params, Zve64d);

    // trigger module parameters require a commercial product
    REQUIRE_COMMERCIAL(riscv, params, tinfo_undefined);
    REQUIRE_COMMERCIAL(riscv, params, tcontrol_undefined);
    REQUIRE_COMMERCIAL(riscv, params, mcontext_undefined);
    REQUIRE_COMMERCIAL(riscv, params, scontext_undefined);
    REQUIRE_COMMERCIAL(riscv, params, amo_trigger);
    REQUIRE_COMMERCIAL(riscv, params, no_hit);
    REQUIRE_COMMERCIAL(riscv, params, no_sselect_2);
    REQUIRE_COMMERCIAL(riscv, params, trigger_num);
    REQUIRE_COMMERCIAL(riscv, params, tinfo);
    REQUIRE_COMMERCIAL(riscv, params, mcontext_bits);
    REQUIRE_COMMERCIAL(riscv, params, scontext_bits);
    REQUIRE_COMMERCIAL(riscv, params, mvalue_bits);
    REQUIRE_COMMERCIAL(riscv, params, svalue_bits);
    REQUIRE_COMMERCIAL(riscv, params, mcontrol_maskmax);

    ////////////////////////////////////////////////////////////////////////////
    // VECTOR EXTENSION CONFIGURATION
    ////////////////////////////////////////////////////////////////////////////

    // set the interpreted Vector Extension profile
    setVProfile(riscv, params);

    // handle SLEN (always the same as VLEN from version 1.0)
    if(!riscvVFSupport(riscv, RVVF_SLEN_IS_VLEN)) {
        cfg->SLEN = powerOfTwo(params->SLEN, "SLEN");
    } else if((params->VLEN!=params->SLEN) && params->SETBIT(SLEN)) {
        vmiMessage("W", CPU_PREFIX"_ISLEN",
            "'SLEN' parameter now ignored - using VLEN (%u)",
            cfg->SLEN
        );
    }

    // initialise vector-version-dependent mstatus.VS
    if(riscvVFSupport(riscv, RVVF_VS_STATUS_9)) {
        cfg->csr.mstatus.u32.fields.VS_9 = params->mstatus_VS;
    } else {
        cfg->csr.mstatus.u32.fields.VS_8 = params->mstatus_VS;
    }

    // initialise vector-version-dependent vtype format
    if(riscvVFSupport(riscv, RVVF_VTYPE_10)) {
        riscv->vtypeFormat = RV_VTF_1_0;
    } else {
        riscv->vtypeFormat = RV_VTF_0_9;
    }

    // Zvqmac extension is only available after version RVVV_0_8_20191004
    cfg->Zvqmac = params->Zvqmac && (params->vector_version>RVVV_0_8_20191004);

    // force VLEN >= ELEN unless explicitly supported
    if((cfg->VLEN<cfg->ELEN) && !riscvVFSupport(riscv, RVVF_ELEN_GT_VLEN)) {
        vmiMessage("W", CPU_PREFIX"_IVLEN",
            "'VLEN' (%u) less than 'ELEN' (%u) - forcing VLEN=%u",
            cfg->VLEN, cfg->ELEN, cfg->ELEN
        );
        cfg->VLEN = cfg->ELEN;
    }

    // force SLEN <= VLEN
    if(cfg->SLEN>cfg->VLEN) {
        vmiMessage("W", CPU_PREFIX"_ISLEN",
            "'SLEN' (%u) exceeds 'VLEN' (%u) - forcing SLEN=%u",
            cfg->SLEN, cfg->VLEN, cfg->VLEN
        );
        cfg->SLEN = cfg->VLEN;
    }

    // force EEW_index <= ELEN
    if(!cfg->EEW_index) {
        cfg->EEW_index = cfg->ELEN;
    } else if(cfg->EEW_index>cfg->ELEN) {
        vmiMessage("W", CPU_PREFIX"_IEEWI",
            "'EEW_index' (%u) exceeds 'ELEN' (%u) - forcing EEW_index=%u",
            cfg->EEW_index, cfg->ELEN, cfg->ELEN
        );
        cfg->EEW_index = cfg->ELEN;
    }

    // force SEW_min <= ELEN
    if(cfg->SEW_min>cfg->ELEN) {
        vmiMessage("W", CPU_PREFIX"_ISEW",
            "'SEW_min' (%u) exceeds 'ELEN' (%u) - forcing SEW_min=%u",
            cfg->SEW_min, cfg->ELEN, cfg->ELEN
        );
        cfg->SEW_min = cfg->ELEN;
    }

    // disable agnostic_ones if not supported
    if(cfg->agnostic_ones && !riscvVFSupport(riscv, RVVF_AGNOSTIC)) {
        if(params->SETBIT(agnostic_ones)) {
            vmiMessage("W", CPU_PREFIX"_A1NA",
                "agnostic_ones not applicable for %s - ignored",
                riscvGetVectorVersionDesc(riscv)
            );
        }
        cfg->agnostic_ones = False;
    }

    ////////////////////////////////////////////////////////////////////////////
    // BIT MANIPULATION EXTENSION CONFIGURATION
    ////////////////////////////////////////////////////////////////////////////

    // handle bit manipulation subset parameters
    cfg->bitmanip_absent = 0;
    ADD_BM_SET(riscv, cfg, params, Zba);
    ADD_BM_SET(riscv, cfg, params, Zbb);
    ADD_BM_SET(riscv, cfg, params, Zbc);
    ADD_BM_SET(riscv, cfg, params, Zbe);
    ADD_BM_SET(riscv, cfg, params, Zbf);
    ADD_BM_SET(riscv, cfg, params, Zbm);
    ADD_BM_SET(riscv, cfg, params, Zbp);
    ADD_BM_SET(riscv, cfg, params, Zbr);
    ADD_BM_SET(riscv, cfg, params, Zbs);
    ADD_BM_SET(riscv, cfg, params, Zbt);

    // for version 1.0.0, only Zba, Zbb, Zbc and Zbs may be configured
    if(cfg->bitmanip_version==RVBV_1_0_0) {
        cfg->bitmanip_absent |= ~(RVBS_Zba|RVBS_Zbb|RVBS_Zbc|RVBS_Zbs);
    }

    ////////////////////////////////////////////////////////////////////////////
    // CRYPTOGRAPHIC EXTENSION CONFIGURATION
    ////////////////////////////////////////////////////////////////////////////

    // handle cryptographic profile parameters
    cfg->crypto_absent = 0;
    ADD_K_SET2(riscv, cfg, params, Zbkb, Zkb);
    ADD_K_SET2(riscv, cfg, params, Zbkc, Zkg);
    ADD_K_SET(riscv, cfg, params, Zbkx);
    ADD_K_SET(riscv, cfg, params, Zkr);
    ADD_K_SET(riscv, cfg, params, Zknd);
    ADD_K_SET(riscv, cfg, params, Zkne);
    ADD_K_SET(riscv, cfg, params, Zknh);
    ADD_K_SET(riscv, cfg, params, Zksed);
    ADD_K_SET(riscv, cfg, params, Zksh);
}

//
// Apply parameters applicable at root level
//
static void applyParams(riscvP riscv, riscvParamValuesP params) {

    if(riscv->parent || riscv->parameters) {

        // normal usage - copy configuration
        riscv->configInfo = *getConfigVariantArg(riscv, params);

        if(!riscvIsCluster(riscv)) {
            applyParamsSMP(riscv, params);
        }

    } else {

        // PSE usage
        riscv->configInfo = *riscvGetConfigList(riscv);
    }
}

//
// RISCV processor constructor
//
VMI_CONSTRUCTOR_FN(riscvConstructor) {

    riscvP            riscv       = (riscvP)processor;
    riscvP            parent      = getParent(riscv);
    riscvParamValuesP paramValues = parameterValues;

    // indicate no interrupts are pending and enabled initially
    riscv->pendEnab.id  = RV_NO_INT;
    riscv->clicState.id = RV_NO_INT;
    riscv->clic.sel.id  = RV_NO_INT;

    // initialize enhanced model support callbacks that apply at all levels
    initAllModelCBs(riscv);

    // set hierarchical properties
    riscv->parent  = parent;
    riscv->smpRoot = parent ? parent->smpRoot : riscv;
    riscv->flags   = parent ? parent->flags : vmirtProcessorFlags(processor);

    // use parameters from parent if that is an SMP container
    if(parent && !riscvIsCluster(parent)) {
        paramValues = parent->paramValues;
    }

    // apply parameters
    applyParams(riscv, paramValues);

    // if this is a container, get the number of children
    Uns32 numChildren = getNumChildren(riscv);

    // is this a multicore processor container?
    if(numChildren) {

        // supply basic SMP configuration properties
        smpContext->isContainer = True;
        smpContext->numChildren = numChildren;

        // save parameters for use in child
        riscv->paramValues = paramValues;

        // save the number of child harts
        riscv->numHarts = numChildren;

    } else {

        // initialize enhanced model support callbacks that apply at leaf levels
        initLeafModelCBs(riscv);

        // indicate no LR/SC is active initially
        riscv->exclusiveTag = RISCV_NO_TAG;

        // initialize mask of implemented exceptions
        riscvSetExceptionMask(riscv);

        // allocate PMP structures
        riscvVMNewPMP(riscv);

        // initialize CSR state
        riscvCSRInit(riscv, smpContext->index);

        // initialize FPU
        riscvConfigureFPU(riscv);

        // initialize vector unit
        riscvConfigureVector(riscv);

        // allocate net port descriptions
        riscvNewNetPorts(riscv);

        // create root level bus port specifications for leaf level ports
        riscvNewLeafBusPorts(riscv);

        // allocate timers
        riscvNewTimers(riscv);

        // allocate CLIC data structures if required
        if(CLICInternal(riscv)) {
            riscvNewCLIC(riscv, smpContext->index);
        }

        // add CSR commands
        if(!isPSE(riscv)) {
            riscvAddCSRCommands(riscv);
        }

        // do initial reset
        riscvReset(riscv);
    }
}

//
// RISCV processor post-constructor
//
VMI_POST_CONSTRUCTOR_FN(riscvPostConstructor) {

    riscvP riscv = (riscvP)processor;

    // install documentation after processor is initialized
    if(!isPSE(riscv)) {
        riscvDoc(riscv);
    }

    // create root level bus port specifications for root level ports
    riscvNewRootBusPorts(riscv);
}

//
// Processor destructor
//
VMI_DESTRUCTOR_FN(riscvDestructor) {

    riscvP riscv = (riscvP)processor;

    // free register descriptions
    riscvFreeRegInfo(riscv);

    // free virtual memory structures
    riscvVMFree(riscv);

    // free parameter specifications
    riscvFreeParameters(riscv);

    // free net port descriptions
    riscvFreeNetPorts(riscv);

    // free bus port specifications
    riscvFreeBusPorts(riscv);

    // free CSR state
    riscvCSRFree(riscv);

    // free exception state
    riscvExceptFree(riscv);

    // free vector extension data structures
    riscvFreeVector(riscv);

    // free timers
    riscvFreeTimers(riscv);

    // free CLIC data structures
    riscvFreeCLIC(riscv);

    // free PMP structures
    riscvVMFreePMP(riscv);
}


////////////////////////////////////////////////////////////////////////////////
// SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Called at start of save
//
static VMI_SMP_ITER_FN(startSave) {

    riscvP riscv = (riscvP)processor;

    // indicate save/restore is active
    riscv->inSaveRestore = True;
}

//
// Called at end of save
//
static VMI_SMP_ITER_FN(endSave) {

    riscvP riscv = (riscvP)processor;

    // indicate save/restore is inactive
    riscv->inSaveRestore = False;
}

//
// Called at start of restore
//
static VMI_SMP_ITER_FN(startRestore) {

    riscvP riscv = (riscvP)processor;

    // indicate save/restore is active
    riscv->inSaveRestore = True;

    // disable debug flags on this processor
    riscv->flagsRestore = riscv->flags;
    riscv->flags       &= ~RISCV_DEBUG_UPDATE_MASK;
}

//
// Called at end of restore
//
static VMI_SMP_ITER_FN(endRestore) {

    riscvP riscv = (riscvP)processor;

    // indicate save/restore is inactive
    riscv->inSaveRestore = False;

    // enable debug flags on this processor
    riscv->flags = riscv->flagsRestore;
}

//
// Refresh mode on a restore (ensuring that apparent dictionary mode always
// changes)
//
static void refreshModeRestore(riscvP riscv) {

    riscvMode mode = getCurrentMode5(riscv);

    riscv->mode = -1;

    riscvSetMode(riscv, mode);
}

//
// Called when processor is being saved
//
VMI_SAVE_STATE_FN(riscvSaveState) {

    riscvP riscv = (riscvP)processor;

    switch(phase) {

        case SRT_BEGIN:
            // start of SMP cluster
            vmirtIterAllProcessors(processor, startSave, 0);
            break;

        case SRT_BEGIN_CORE:
            // start of individual core
            break;

        case SRT_END_CORE:
            // end of individual core
            VMIRT_SAVE_FIELD(cxt, riscv, mode);
            VMIRT_SAVE_FIELD(cxt, riscv, disable);
            VMIRT_SAVE_FIELD(cxt, riscv, exclusiveTag);
            VMIRT_SAVE_FIELD(cxt, riscv, disableMask);
            break;

        case SRT_END:
            // end of SMP cluster (see below)
            break;

        default:
            // not reached
            VMI_ABORT("unimplemented case"); // LCOV_EXCL_LINE
            break;
    }

    // save CSR state not covered by register read/write API
    riscvCSRSave(riscv, cxt, phase);

    // save VM register state not covered by register read/write API
    riscvVMSave(riscv, cxt, phase);

    // save net state not covered by register read/write API
    riscvNetSave(riscv, cxt, phase);

    // save timer state not covered by register read/write API
    riscvTimerSave(riscv, cxt, phase);

    // save K-extension state not covered by register read/write API
    riscvCryptoSave(riscv, cxt, phase);

    // save Trigger Module state not covered by register read/write API
    riscvTriggerSave(riscv, cxt, phase);

    // end of SMP cluster
    if(phase==SRT_END) {
        vmirtIterAllProcessors(processor, endSave, 0);
    }
}

//
// Called when processor is being restored
//
VMI_RESTORE_STATE_FN(riscvRestoreState) {

    riscvP riscv = (riscvP)processor;

    switch(phase) {

        case SRT_BEGIN:
            // start of SMP cluster
            vmirtIterAllProcessors(processor, startRestore, 0);
            break;

        case SRT_BEGIN_CORE:
            // start of individual core
            riscvUpdateExclusiveAccessCallback(riscv, False);
            break;

        case SRT_END_CORE:
            // end of individual core
            VMIRT_RESTORE_FIELD(cxt, riscv, mode);
            VMIRT_RESTORE_FIELD(cxt, riscv, disable);
            VMIRT_RESTORE_FIELD(cxt, riscv, exclusiveTag);
            VMIRT_RESTORE_FIELD(cxt, riscv, disableMask);
            refreshModeRestore(riscv);
            riscvUpdateExclusiveAccessCallback(riscv, True);
            break;

        case SRT_END:
            // end of SMP cluster (see below)
            break;

        default:
            // not reached
            VMI_ABORT("unimplemented case"); // LCOV_EXCL_LINE
            break;
    }

    // restore CSR state not covered by register read/write API
    riscvCSRRestore(riscv, cxt, phase);

    // restore VM register state not covered by register read/write API
    riscvVMRestore(riscv, cxt, phase);

    // restore net state not covered by register read/write API
    riscvNetRestore(riscv, cxt, phase);

    // restore timer state not covered by register read/write API
    riscvTimerRestore(riscv, cxt, phase);

    // restore K-extension state not covered by register read/write API
    riscvCryptoRestore(riscv, cxt, phase);

    // restore Trigger Module state not covered by register read/write API
    riscvTriggerRestore(riscv, cxt, phase);

    // end of SMP cluster
    if(phase==SRT_END) {
        vmirtIterAllProcessors(processor, endRestore, 0);
    }
}


