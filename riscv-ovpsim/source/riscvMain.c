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
#include "riscvCLINT.h"
#include "riscvCluster.h"
#include "riscvBus.h"
#include "riscvConfig.h"
#include "riscvCSR.h"
#include "riscvDebug.h"
#include "riscvDecode.h"
#include "riscvDisassemble.h"
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


#define DEBUG_FLAGS_NAME "debugflags"

//
// Handle print or update of processor debug flags
//
static VMIRT_COMMAND_PARSE_FN(debugFlags) {

    riscvP       riscv  = (riscvP)processor;
    vmiArgValueP argSet = vmirtFindArgValue(argc, argv, "set");
    vmiArgValueP argGet = vmirtFindArgValue(argc, argv, "get");
    vmiArgValueP argMsk = vmirtFindArgValue(argc, argv, "mask");
    Bool         found  = False;

    // handle "set" argument
    if(argSet && argSet->isSet) {

        Uns32 newFlags = argSet->u.int32 &= RISCV_DEBUG_UPDATE_MASK;

        riscv->flags |= newFlags;                               // set flags
        riscv->flags &= (newFlags | ~RISCV_DEBUG_UPDATE_MASK);  // cleared flags

        vmiPrintf(
            "%s: Debug flags are now 0x%08x on '%s'\n",
            DEBUG_FLAGS_NAME, riscv->flags, vmirtProcessorName(processor)
        );

        found = True;
    }

    // handle "get" argument
    if(argGet && argGet->isSet) {

        vmiPrintf(
             "%s: Current debug flags 0x%08x on '%s'\n",
             DEBUG_FLAGS_NAME, riscv->flags, vmirtProcessorName(processor)
        );

        found = True;
    }

    // handle "mask" argument
    if(argMsk && argMsk->isSet) {

        vmiPrintf(
            "%s: Debug flags valid bits 0x%08x\n",
            DEBUG_FLAGS_NAME, RISCV_DEBUG_UPDATE_MASK
        );

        found = True;
    }

    if(!found) {

        vmiPrintf(
            "%s: -set <new value> -get -mask   : "
            "Note only flags 0x%08x can be modified\n",
            DEBUG_FLAGS_NAME, RISCV_DEBUG_UPDATE_MASK
        );

        // error status
        return NULL;
    }

    return "1";
}

//
// Add command for debug flag update
//
static void addDebugCommand(riscvP riscv) {

    // add debugflags command to the command interpreter
    vmiCommandP cmd = vmirtAddCommandParse(
        (vmiProcessorP)riscv,
        DEBUG_FLAGS_NAME,
        "show or modify the processor debug flags",
        debugFlags,
        VMI_CT_DEFAULT|VMI_CO_DIAG|VMI_CA_REPORT
    );

    // define help strings
    char        setHelp[256];
    const char *getHelp = "print current processor flags value";
    const char *mskHelp = "print valid debug flag bits";

    sprintf(
        setHelp,
        "new processor flags (only flags 0x%08x can be modified)",
        RISCV_DEBUG_UPDATE_MASK
    );

    // add arguments
    vmirtAddArg(cmd, "set",  setHelp, VMI_CA_INT32, VMI_CAA_MENU,    False, 0);
    vmirtAddArg(cmd, "get",  getHelp, VMI_CA_BOOL,  VMI_CAA_DEFAULT, False, 0);
    vmirtAddArg(cmd, "mask", mskHelp, VMI_CA_BOOL,  VMI_CAA_DEFAULT, False, 0);
}

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
    riscv->cb.block              = riscvBlock;
    riscv->cb.restart            = riscvRestart;
    riscv->cb.updateInterrupt    = riscvUpdateInterrupt;
    riscv->cb.updateDisable      = riscvUpdateInterruptDisable;
    riscv->cb.testInterrupt      = riscvUpdatePending;
    riscv->cb.resumeFromWFI      = riscvResumeFromWFI;
    riscv->cb.illegalInstruction = riscvIllegalInstruction;
    riscv->cb.illegalVerbose     = riscvIllegalInstructionMessage;
    riscv->cb.virtualInstruction = riscvVirtualInstruction;
    riscv->cb.virtualVerbose     = riscvVirtualInstructionMessage;
    riscv->cb.illegalCustom      = riscvIllegalCustom;
    riscv->cb.takeException      = riscvTakeAsynchonousException;
    riscv->cb.pendFetchException = riscvPendFetchException;
    riscv->cb.takeReset          = riscvReset;

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
    riscv->cb.loadMt             = riscvEmitLoad;
    riscv->cb.storeMt            = riscvEmitStore;
    riscv->cb.requireModeMt      = riscvEmitRequireMode;
    riscv->cb.requireNotVMt      = riscvEmitRequireNotV;
    riscv->cb.checkLegalRMMt     = riscvEmitCheckLegalRM;
    riscv->cb.morphTrapTVM       = riscvEmitTrapTVM;
    riscv->cb.morphVOp           = riscvMorphVOp;

    // from riscvCSR.h
    riscv->cb.newCSR             = riscvNewCSR;
    riscv->cb.hpmAccessValid     = riscvHPMAccessValid;

    // from riscvVM.h
    riscv->cb.mapAddress         = riscvVMMiss;
    riscv->cb.unmapPMPRegion     = riscvVMUnmapPMPRegion;
    riscv->cb.updateLdStDomain   = riscvVMRefreshMPRVDomain;
    riscv->cb.newTLBEntry        = riscvVMNewTLBEntry;
    riscv->cb.freeTLBEntry       = riscvVMFreeTLBEntry;

    // from riscvDebug.h
    riscv->cb.newExtReg          = riscvNewExtReg;
}

//
// Return processor configuration using variant argument
//
static riscvConfigCP getConfigVariantArg(riscvP riscv, riscvParamValuesP params) {

    riscvConfigCP cfgList = riscvGetConfigList(riscv);
    riscvConfigCP match;

    if(riscvIsClusterMember(riscv)) {

        match = riscvGetNamedConfig(cfgList, riscvGetMemberVariant(riscv));

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
// Get the first child of a processor
//
inline static riscvP getChild(riscvP riscv) {
    return (riscvP)vmirtGetSMPChild((vmiProcessorP)riscv);
}

//
// Return the number of child processors of the given processor
//
inline static riscvP getParent(riscvP riscv) {
    return (riscvP)vmirtGetSMPParent((vmiProcessorP)riscv);
}

//
// Is the processor a leaf processor?
//
inline static Bool isLeaf(riscvP riscv) {
    return !getChild(riscv);
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
    Uns32         index;

    if(!riscvIsCluster(rvParent)) {
        sprintf(name, "%s_%s%u", baseName, cfg->leaf_hart_prefix, smpIndex);
    } else if((index=rvParent->uniqueIndices[smpIndex])) {
        sprintf(name, "%s_%s_%u", baseName, cfg->members[smpIndex], index-1);
    } else {
        sprintf(name, "%s_%s", baseName, cfg->members[smpIndex]);
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
// Handle absent legacy compressed subsets
//
#define ADD_CLEG_SET(_PROC, _CFG, _PARAMS, _NAME) { \
    if(_CFG->_NAME##_version) {                             \
        _CFG->compress_present |= RVCS_##_NAME;             \
    }                                                       \
    REQUIRE_COMMERCIAL(_PROC, _PARAMS, _NAME##_version);    \
}

//
// Handle absent new compressed subsets
//
#define ADD_CNEW_SET(_PROC, _CFG, _PARAMS, _NAME) { \
    if(_PARAMS->_NAME) {                                    \
        _CFG->compress_present |= RVCS_##_NAME;             \
    }                                                       \
    REQUIRE_COMMERCIAL(_PROC, _PARAMS, _NAME);              \
}

//
// Handle absent DSP subsets
//
#define ADD_P_SET(_PROC, _CFG, _PARAMS, _NAME) { \
    if(!_PARAMS->_NAME) {                       \
        _CFG->dsp_absent |= RVPS_##_NAME;       \
    }                                           \
    REQUIRE_COMMERCIAL(_PROC, _PARAMS, _NAME);  \
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
    [RVVS_Zve64x] ="Zve64x",
    [RVVS_Zve64f] ="Zve64f",
    [RVVS_Zve64d] ="Zve64d",
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

    // include half-precision vector instructions if required
    if((cfg->Zvfh || cfg->Zvfhmin) && (V&RVVS_F)) {
        V |= RVVS_H;
    }

    cfg->vect_profile = V;
}

//
// Apply parameters applicable at root level
//
static void applyParamsRoot(riscvP riscv, riscvParamValuesP params) {

    riscvConfigP cfg = &riscv->configInfo;

    // get uninterpreted architectural configuration parameters
    cfg->CLIC_version        = params->CLIC_version;
    cfg->CLICLEVELS          = params->CLICLEVELS;
    cfg->CLICANDBASIC        = params->CLICANDBASIC;
    cfg->CLICVERSION         = params->CLICVERSION;
    cfg->CLICINTCTLBITS      = params->CLICINTCTLBITS;
    cfg->CLICCFGMBITS        = params->CLICCFGMBITS;
    cfg->CLICCFGLBITS        = params->CLICCFGLBITS;
    cfg->CLICSELHVEC         = params->CLICSELHVEC;
    cfg->CLICXNXTI           = params->CLICXNXTI;
    cfg->CLICXCSW            = params->CLICXCSW;
    cfg->INTTHRESHBITS       = params->INTTHRESHBITS;
    cfg->externalCLIC        = params->externalCLIC;
    cfg->tvt_undefined       = params->tvt_undefined;
    cfg->intthresh_undefined = params->intthresh_undefined;
    cfg->mclicbase_undefined = mclicbaseAbsent(riscv) || params->mclicbase_undefined;
    cfg->CSIP_present        = params->CSIP_present;
    cfg->nlbits_valid        = params->nlbits_valid;
    cfg->posedge_0_63        = params->posedge_0_63;
    cfg->poslevel_0_63       = params->poslevel_0_63;
    cfg->posedge_other       = params->posedge_other;
    cfg->poslevel_other      = params->poslevel_other;
    cfg->CLINT_address       = params->CLINT_address;
    cfg->mtime_Hz            = params->mtime_Hz;
    cfg->AIA_version         = params->AIA_version;

    // get uninterpreted CLIC configuration parameters
    cfg->mclicbase = params->mclicbase & ~0xfffULL;
    cfg->sclicbase = params->sclicbase & ~0xfffULL;
    cfg->uclicbase = params->uclicbase & ~0xfffULL;

    // get uninterpreted CSR mask configuration parameters
    cfg->csrMask.mtvt.u64.bits = params->mtvt_mask;
    cfg->csrMask.stvt.u64.bits = params->stvt_mask;
    cfg->csrMask.utvt.u64.bits = params->utvt_mask;
    cfg->csrMask.jvt.u64.bits  = params->jvt_mask;

    // get implied CSR sign extension configuration parameters
    cfg->mtvec_sext = params->mtvec_sext;
    cfg->stvec_sext = params->stvec_sext;
    cfg->utvec_sext = params->utvec_sext;
    cfg->mtvt_sext  = params->mtvt_sext;
    cfg->stvt_sext  = params->stvt_sext;
    cfg->utvt_sext  = params->utvt_sext;

    // if CSIP is present, force it to be positive-edge-triggered
    if(useCSIP12(riscv)) {
        cfg->posedge_0_63 |= (1<<12);
    } else if(useCSIP16(riscv)) {
        cfg->posedge_0_63 |= (1<<16);
    }
}

//
// Copy root configuration options from parent
//
static void copyParentConfig(riscvP riscv) {

    riscvConfigP dst = &riscv->configInfo;
    riscvConfigP src = &riscv->parent->configInfo;

    // get uninterpreted architectural configuration parameters
    dst->CLIC_version        = src->CLIC_version;
    dst->CLICLEVELS          = src->CLICLEVELS;
    dst->CLICANDBASIC        = src->CLICANDBASIC;
    dst->CLICVERSION         = src->CLICVERSION;
    dst->CLICINTCTLBITS      = src->CLICINTCTLBITS;
    dst->CLICCFGMBITS        = src->CLICCFGMBITS;
    dst->CLICCFGLBITS        = src->CLICCFGLBITS;
    dst->CLICSELHVEC         = src->CLICSELHVEC;
    dst->CLICXNXTI           = src->CLICXNXTI;
    dst->CLICXCSW            = src->CLICXCSW;
    dst->INTTHRESHBITS       = src->INTTHRESHBITS;
    dst->externalCLIC        = src->externalCLIC;
    dst->tvt_undefined       = src->tvt_undefined;
    dst->intthresh_undefined = src->intthresh_undefined;
    dst->mclicbase_undefined = src->mclicbase_undefined;
    dst->CSIP_present        = src->CSIP_present;
    dst->nlbits_valid        = src->nlbits_valid;
    dst->posedge_0_63        = src->posedge_0_63;
    dst->poslevel_0_63       = src->poslevel_0_63;
    dst->posedge_other       = src->posedge_other;
    dst->poslevel_other      = src->poslevel_other;
    dst->CLINT_address       = src->CLINT_address;
    dst->mtime_Hz            = src->mtime_Hz;
    dst->AIA_version         = src->AIA_version;

    // get uninterpreted CLIC configuration parameters
    dst->mclicbase = src->mclicbase;
    dst->sclicbase = src->sclicbase;
    dst->uclicbase = src->uclicbase;

    // get uninterpreted CSR mask configuration parameters
    dst->csrMask.mtvt.u64.bits = src->csrMask.mtvt.u64.bits;
    dst->csrMask.stvt.u64.bits = src->csrMask.stvt.u64.bits;
    dst->csrMask.utvt.u64.bits = src->csrMask.utvt.u64.bits;

    // get implied CSR sign extension configuration parameters
    dst->mtvec_sext = src->mtvec_sext;
    dst->stvec_sext = src->stvec_sext;
    dst->utvec_sext = src->utvec_sext;
    dst->mtvt_sext  = src->mtvt_sext;
    dst->stvt_sext  = src->stvt_sext;
    dst->utvt_sext  = src->utvt_sext;
}

#define PARAMS_APPLY(_C, _P,_CN, _PN, _I) _C._CN##_I.u64.bits = _P->_PN##_I
#define PARAMS_APPLY_X0_X3(_C, _P,_CN, _PN, _X) \
   PARAMS_APPLY(_C, _P,_CN, _PN, _X##0);        \
   PARAMS_APPLY(_C, _P,_CN, _PN, _X##1);        \
   PARAMS_APPLY(_C, _P,_CN, _PN, _X##2);        \
   PARAMS_APPLY(_C, _P,_CN, _PN, _X##3)
#define PARAMS_APPLY_X0_X5(_C, _P,_CN, _PN, _X) \
   PARAMS_APPLY_X0_X3(_C, _P,_CN, _PN, _X);     \
   PARAMS_APPLY(_C, _P,_CN, _PN, _X##4);        \
   PARAMS_APPLY(_C, _P,_CN, _PN, _X##5)
#define PARAMS_APPLY_X0_X9(_C, _P,_CN, _PN, _X) \
   PARAMS_APPLY_X0_X5(_C, _P,_CN, _PN, _X);     \
   PARAMS_APPLY(_C, _P,_CN, _PN, _X##6);        \
   PARAMS_APPLY(_C, _P,_CN, _PN, _X##7);        \
   PARAMS_APPLY(_C, _P,_CN, _PN, _X##8);        \
   PARAMS_APPLY(_C, _P,_CN, _PN, _X##9)
#define PARAMS_APPLY_0_9(_C, _P,_CN, _PN)       \
   PARAMS_APPLY(_C, _P,_CN, _PN, 0);            \
   PARAMS_APPLY(_C, _P,_CN, _PN, 1);            \
   PARAMS_APPLY(_C, _P,_CN, _PN, 2);            \
   PARAMS_APPLY(_C, _P,_CN, _PN, 3);            \
   PARAMS_APPLY(_C, _P,_CN, _PN, 4);            \
   PARAMS_APPLY(_C, _P,_CN, _PN, 5);            \
   PARAMS_APPLY(_C, _P,_CN, _PN, 6);            \
   PARAMS_APPLY(_C, _P,_CN, _PN, 7);            \
   PARAMS_APPLY(_C, _P,_CN, _PN, 8);            \
   PARAMS_APPLY(_C, _P,_CN, _PN, 9)
#define PARAMS_APPLY_0_15(_C, _P,_CN, _PN)      \
   PARAMS_APPLY_0_9(_C, _P,_CN, _PN);           \
   PARAMS_APPLY_X0_X5(_C, _P,_CN, _PN, 1)
#define PARAMS_APPLY_0_63(_C, _P,_CN, _PN)      \
   PARAMS_APPLY_0_9(_C, _P,_CN, _PN);           \
   PARAMS_APPLY_X0_X9(_C, _P,_CN, _PN, 1);      \
   PARAMS_APPLY_X0_X9(_C, _P,_CN, _PN, 2);      \
   PARAMS_APPLY_X0_X9(_C, _P,_CN, _PN, 3);      \
   PARAMS_APPLY_X0_X9(_C, _P,_CN, _PN, 4);      \
   PARAMS_APPLY_X0_X9(_C, _P,_CN, _PN, 5);      \
   PARAMS_APPLY_X0_X3(_C, _P,_CN, _PN, 6)

//
// Return mask of enabled extensions in the submask
//
static riscvArchitecture extensionsPresent(
    riscvConfigP      cfg,
    riscvArchitecture override,
    riscvArchitecture extensions
) {
    riscvArchitecture src1 = cfg->arch &  cfg->archFixed;
    riscvArchitecture src2 = override  & ~cfg->archFixed;

    return (src1|src2) & extensions;
}

//
// Apply parameters applicable to SMP member
//
static void applyParamsSMP(
    riscvP            riscv,
    riscvParamValuesP params,
    Uns64             mhartid
) {
    riscvConfigP cfg = &riscv->configInfo;

    // either apply parameters applicable at root level or copy root-level
    // parameter values from parent
    if(!riscv->parent) {
        applyParamsRoot(riscv, params);
    } else {
        copyParentConfig(riscv);
    }

    // set simulation controls
    riscv->verbose       = params->verbose;
    riscv->traceVolatile = params->traceVolatile;

    // set data endian (instruction fetch is always little-endian)
    riscv->dendian = params->endian;

    // get architectural configuration parameters
    Int32 lr_sc_grain = params->lr_sc_grain;

    // use specified hartid
    cfg->csr.mhartid.u64.bits = mhartid;

    // get uninterpreted CSR configuration parameters
    cfg->csr.mvendorid.u64.bits    = params->mvendorid;
    cfg->csr.marchid.u64.bits      = params->marchid;
    cfg->csr.mimpid.u64.bits       = params->mimpid;
    cfg->csr.mconfigptr.u64.bits   = params->mconfigptr;
    cfg->csr.mtvec.u64.bits        = params->mtvec;
    cfg->csr.mstatus.u32.fields.FS = params->mstatus_FS;
    cfg->csr.mseccfg.u64.bits      = params->mseccfg;

    // get uninterpreted CSR mask configuration parameters
    cfg->csrMask.mtvec.u64.bits  = params->mtvec_mask;
    cfg->csrMask.stvec.u64.bits  = params->stvec_mask;
    cfg->csrMask.utvec.u64.bits  = params->utvec_mask;
    cfg->csrMask.tdata1.u64.bits = params->tdata1_mask;
    cfg->csrMask.mip.u64.bits    = params->mip_mask;
    cfg->csrMask.sip.u64.bits    = params->sip_mask;
    cfg->csrMask.uip.u64.bits    = params->uip_mask;
    cfg->csrMask.hip.u64.bits    = params->hip_mask;
    cfg->csrMask.hvip.u64.bits   = params->hvip_mask;
    cfg->csrMask.mvien.u64.bits  = params->mvien_mask;
    cfg->csrMask.hvien.u64.bits  = params->hvien_mask;
    cfg->csrMask.mvip.u64.bits   = params->mvip_mask;
    cfg->csrMask.envcfg.u64.bits = params->envcfg_mask;

    // get implied CSR sign extension configuration parameters
    cfg->mtvec_sext = getSExtendBits(params->mtvec_sext, cfg->csrMask.mtvec.u64.bits);
    cfg->stvec_sext = getSExtendBits(params->stvec_sext, cfg->csrMask.stvec.u64.bits);
    cfg->utvec_sext = getSExtendBits(params->utvec_sext, cfg->csrMask.utvec.u64.bits);
    cfg->mtvt_sext  = getSExtendBits(params->mtvt_sext,  cfg->csrMask.mtvt.u64.bits);
    cfg->stvt_sext  = getSExtendBits(params->stvt_sext,  cfg->csrMask.stvt.u64.bits);
    cfg->utvt_sext  = getSExtendBits(params->utvt_sext,  cfg->csrMask.utvt.u64.bits);

    // handle parameters that are overridden only if explicitly set (affects
    // disassembly of instructions for extensions that are not configured)
    EXPLICIT_PARAM(cfg, params, vect_version,     vector_version);
    EXPLICIT_PARAM(cfg, params, bitmanip_version, bitmanip_version);
    EXPLICIT_PARAM(cfg, params, crypto_version,   crypto_version);

    // handle specification of half-precision format
    if(params->SETBIT(fp16_version)) {
        cfg->fp16_version = params->fp16_version;
    } else if(cfg->fp16_version) {
        // floating point version is specified
    } else if(params->Zfh || params->Zfhmin || params->Zvfh || params->Zvfhmin) {
        cfg->fp16_version = RVFP16_IEEE754;
    }

    // get uninterpreted architectural configuration parameters
    cfg->enable_expanded      = params->enable_expanded;
    cfg->endianFixed          = params->endianFixed;
    cfg->leaf_hart_prefix     = params->leaf_hart_prefix;
    cfg->use_hw_reg_names     = params->use_hw_reg_names;
    cfg->no_pseudo_inst       = params->no_pseudo_inst;
    cfg->show_c_prefix        = params->show_c_prefix;
    cfg->ABI_d                = params->ABI_d;
    cfg->user_version         = params->user_version;
    cfg->priv_version         = params->priv_version;
    cfg->vcrypto_version      = params->vcrypto_version;
    cfg->compress_version     = params->compress_version;
    cfg->hyp_version          = params->hypervisor_version;
    cfg->dsp_version          = params->dsp_version;
    cfg->dbg_version          = params->debug_version;
    cfg->rnmi_version         = params->rnmi_version;
    cfg->Smepmp_version       = params->Smepmp_version;
    cfg->Zfinx_version        = params->Zfinx_version;
    cfg->Zcea_version         = params->Zcea_version;
    cfg->Zceb_version         = params->Zceb_version;
    cfg->Zcee_version         = params->Zcee_version;
    cfg->mstatus_fs_mode      = params->mstatus_fs_mode;
    cfg->agnostic_ones        = params->agnostic_ones;
    cfg->MXL_writable         = params->MXL_writable;
    cfg->SXL_writable         = params->SXL_writable;
    cfg->UXL_writable         = params->UXL_writable;
    cfg->VSXL_writable        = params->VSXL_writable;
    cfg->reset_address        = params->reset_address;
    cfg->nmi_address          = params->nmi_address;
    cfg->nmiexc_address       = params->nmiexc_address;
    cfg->ASID_cache_size      = params->ASID_cache_size;
    cfg->ASID_bits            = params->ASID_bits;
    cfg->VMID_bits            = params->VMID_bits;
    cfg->trigger_num          = params->trigger_num;
    cfg->tinfo                = params->tinfo;
    cfg->trigger_match        = params->trigger_match;
    cfg->mcontext_bits        = params->mcontext_bits;
    cfg->scontext_bits        = params->scontext_bits;
    cfg->mvalue_bits          = params->mvalue_bits;
    cfg->svalue_bits          = params->svalue_bits;
    cfg->mcontrol_maskmax     = params->mcontrol_maskmax;
    cfg->chain_tval           = params->chain_tval;
    cfg->dcsr_ebreak_mask     = params->dcsr_ebreak_mask;
#if(ENABLE_SSMPU)
    cfg->MPU_grain            = params->MPU_grain;
    cfg->MPU_registers        = params->MPU_registers;
    cfg->MPU_decompose        = params->MPU_decompose;
#endif
    cfg->PMP_grain            = params->PMP_grain;
    cfg->PMP_registers        = params->PMP_registers;
    cfg->PMP_max_page         = powerOfTwo(params->PMP_max_page, "PMP_max_page");
    cfg->PMP_decompose        = params->PMP_decompose;
    cfg->PMP_undefined        = params->PMP_undefined;

    cfg->PMP_maskparams       = params->PMP_maskparams;
    if (cfg->PMP_maskparams) {
        PARAMS_APPLY_0_15(cfg->csrMask, ~params, romask_pmpcfg,  mask_pmpcfg);
        PARAMS_APPLY_0_63(cfg->csrMask, ~params, romask_pmpaddr, mask_pmpaddr);
    }

    cfg->PMP_initialparams    = params->PMP_initialparams;
    if (cfg->PMP_initialparams) {
        PARAMS_APPLY_0_15(cfg->csr, params, pmpcfg,  pmpcfg);
        PARAMS_APPLY_0_63(cfg->csr, params, pmpaddr, pmpaddr);
    }

    cfg->cmomp_bytes          = powerOfTwo(params->cmomp_bytes, "cmomp_bytes");
    cfg->cmoz_bytes           = powerOfTwo(params->cmoz_bytes,  "cmoz_bytes");
    cfg->Sv_modes             = params->Sv_modes | RISCV_VMM_BARE;
    cfg->Smstateen            = params->Smstateen && (RISCV_PRIV_VERSION(riscv)>=RVPV_1_12);
    cfg->Sstc                 = params->Sstc;
    cfg->Svpbmt               = params->Svpbmt;
    cfg->Svinval              = params->Svinval;
    cfg->Smaia                = params->Smaia;
    cfg->IMSIC_present        = params->IMSIC_present;
    cfg->local_int_num        = params->local_int_num;
    cfg->unimp_int_mask       = params->unimp_int_mask;
    cfg->ecode_mask           = params->ecode_mask;
    cfg->ecode_nmi_mask       = params->ecode_nmi_mask;
    cfg->ecode_nmi            = params->ecode_nmi;
    cfg->nmi_is_latched       = params->nmi_is_latched;
    cfg->external_int_id      = params->external_int_id;
    cfg->force_mideleg        = params->force_mideleg;
    cfg->force_sideleg        = params->force_sideleg;
    cfg->no_ideleg            = params->no_ideleg;
    cfg->no_edeleg            = params->no_edeleg;
    cfg->lr_sc_grain          = powerOfTwo(lr_sc_grain, "lr_sc_grain");
    cfg->lr_sc_match_size     = params->lr_sc_match_size;
    cfg->ignore_non_leaf_DAU  = params->ignore_non_leaf_DAU;
    cfg->debug_mode           = params->debug_mode;
    cfg->debug_address        = params->debug_address;
    cfg->dexc_address         = params->dexc_address;
    cfg->debug_eret_mode      = params->debug_eret_mode;
    cfg->debug_priority       = params->debug_priority;
    cfg->no_resethaltreq      = params->no_resethaltreq;
    cfg->updatePTEA           = params->updatePTEA;
    cfg->updatePTED           = params->updatePTED;
    cfg->unaligned_low_pri    = params->unaligned_low_pri;
    cfg->unaligned            = params->unaligned;
    cfg->unalignedAMO         = params->Zam;
    cfg->unalignedV           = params->unalignedV;
    cfg->wfi_is_nop           = params->wfi_is_nop;
    cfg->wfi_resume_not_trap  = params->wfi_resume_not_trap;
    cfg->TW_time_limit        = params->TW_time_limit;
    cfg->STO_time_limit       = params->STO_time_limit;
    cfg->mtvec_is_ro          = params->mtvec_is_ro;
    cfg->counteren_mask       = params->counteren_mask;
    cfg->scounteren_zero_mask = params->scounteren_zero_mask;
    cfg->hcounteren_zero_mask = params->hcounteren_zero_mask;
    cfg->noinhibit_mask       = params->noinhibit_mask;
    cfg->tvec_align           = params->tvec_align;
    cfg->tval_zero            = params->tval_zero;
    cfg->tval_zero_ebreak     = params->tval_zero_ebreak;
    cfg->tval_ii_code         = params->tval_ii_code;
    cfg->cycle_undefined      = params->cycle_undefined;
    cfg->mcycle_undefined     = params->mcycle_undefined;
    cfg->time_undefined       = params->time_undefined;
    cfg->instret_undefined    = params->instret_undefined;
    cfg->minstret_undefined   = params->minstret_undefined;
    cfg->hpmcounter_undefined = params->hpmcounter_undefined;
    cfg->mhpmcounter_undefined= params->mhpmcounter_undefined;
    cfg->tdata2_undefined     = params->tdata2_undefined;
    cfg->tdata3_undefined     = params->tdata3_undefined;
    cfg->tinfo_undefined      = params->tinfo_undefined;
    cfg->tcontrol_undefined   = params->tcontrol_undefined;
    cfg->mcontext_undefined   = params->mcontext_undefined;
    cfg->scontext_undefined   = params->scontext_undefined;
    cfg->mscontext_undefined  = params->mscontext_undefined;
    cfg->hcontext_undefined   = params->hcontext_undefined;
    cfg->mnoise_undefined     = params->mnoise_undefined;
    cfg->dscratch0_undefined  = params->dscratch0_undefined;
    cfg->dscratch1_undefined  = params->dscratch1_undefined;
    cfg->amo_trigger          = params->amo_trigger;
    cfg->amo_aborts_lr_sc     = params->amo_aborts_lr_sc;
    cfg->no_hit               = params->no_hit;
    cfg->no_sselect_2         = params->no_sselect_2;
    cfg->enable_CSR_bus       = params->enable_CSR_bus;
    cfg->d_requires_f         = params->d_requires_f;
    cfg->enable_fflags_i      = params->enable_fflags_i;
    cfg->trap_preserves_lr    = params->trap_preserves_lr;
    cfg->xret_preserves_lr    = params->xret_preserves_lr;
    cfg->fence_g_preserves_vs = params->fence_g_preserves_vs;
    cfg->vstart0_non_ld_st    = params->vstart0_non_ld_st;
    cfg->vstart0_ld_st        = params->vstart0_ld_st;
    cfg->align_whole          = params->align_whole;
    cfg->vill_trap            = params->vill_trap;
    cfg->mstatus_FS_zero      = params->mstatus_FS_zero;
    cfg->ELEN                 = powerOfTwo(params->ELEN,      "ELEN");
    cfg->VLEN = cfg->SLEN     = powerOfTwo(params->VLEN,      "VLEN");
    cfg->EEW_index            = powerOfTwo(params->EEW_index, "EEW_index");
    cfg->SEW_min              = powerOfTwo(params->SEW_min,   "SEW_min");
    cfg->Zawrs                = params->Zawrs;
    cfg->Zmmul                = params->Zmmul;
    cfg->Zfa                  = params->Zfa;
    cfg->Zfhmin               = params->Zfhmin && !params->Zfh;
    cfg->Zfbfmin              = params->Zfbfmin;
    cfg->Zvfh                 = params->Zvfh;
    cfg->Zvfhmin              = params->Zvfhmin && !params->Zvfh;
    cfg->Zvlsseg              = params->Zvlsseg;
    cfg->Zvamo                = params->Zvamo;
    cfg->Zvediv               = params->Zvediv;
    cfg->GEILEN               = params->GEILEN;
    cfg->xtinst_basic         = params->xtinst_basic;
    cfg->noZicsr              = !params->Zicsr;
    cfg->noZifencei           = !params->Zifencei;
    cfg->Zihintntl            = params->Zihintntl;
    cfg->Zicond               = params->Zicond;
    cfg->Zicbom               = params->Zicbom;
    cfg->Zicbop               = params->Zicbop;
    cfg->Zicboz               = params->Zicboz;
    cfg->Svnapot_page_mask    = params->Svnapot_page_mask;
    cfg->miprio_mask          = params->miprio_mask & ~WM64_meip;
    cfg->siprio_mask          = params->siprio_mask & ~WM64_seip;
    cfg->hviprio_mask         = params->hviprio_mask;
    cfg->hvictl_IID_bits      = params->hvictl_IID_bits;
    cfg->IPRIOLEN             = params->IPRIOLEN;
    cfg->HIPRIOLEN            = params->HIPRIOLEN;
    cfg->amo_constraint       = params->amo_constraint;
    cfg->lr_sc_constraint     = params->lr_sc_constraint;
    cfg->push_pop_constraint  = params->push_pop_constraint;
    cfg->vector_constraint    = params->vector_constraint;

    // cycle_undefined and instret_undefined depend on mcycle_undefined and
    // minstret_undefined
    cfg->cycle_undefined      |= cfg->mcycle_undefined;
    cfg->instret_undefined    |= cfg->minstret_undefined;
    cfg->hpmcounter_undefined |= cfg->mhpmcounter_undefined;

    ////////////////////////////////////////////////////////////////////////////
    // FUNDAMENTAL CONFIGURATION
    ////////////////////////////////////////////////////////////////////////////

    Uns32 memberNumHarts;

    // set number of children
    if(riscv->parent && !riscvIsCluster(riscv->parent)) {

        // SMP member has no children
        cfg->numHarts = 0;

    } else if(params->SETBIT(numHarts) || !riscvIsClusterMember(riscv)) {

        // if numHarts is set or not a cluster member, use parameter numHarts
        cfg->numHarts = params->numHarts;

    } else if((memberNumHarts=riscvGetMemberNumHarts(riscv))) {

        // implied numHarts in member name
        cfg->numHarts = memberNumHarts;
    }

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
        cfg->Sv_modes &= RISCV_VMM_64 | RISCV_VMM_SV64;
    }

    // get explicit extensions and extension mask
    riscvArchitecture misa_Extensions      = params->misa_Extensions;
    riscvArchitecture misa_Extensions_mask = params->misa_Extensions_mask;
    riscvArchitecture implicit_Extensions  = cfg->archImplicit;

    // exclude/include extensions specified by letter
    misa_Extensions      &= ~riscvParseExtensions(params->sub_Extensions);
    misa_Extensions_mask &= ~riscvParseExtensions(params->sub_Extensions_mask);
    implicit_Extensions  &= ~riscvParseExtensions(params->sub_implicit_Extensions);
    misa_Extensions      |=  riscvParseExtensions(params->add_Extensions);
    misa_Extensions_mask |=  riscvParseExtensions(params->add_Extensions_mask);
    implicit_Extensions  |=  riscvParseExtensions(params->add_implicit_Extensions);

    // from Zfinx version 0.41, misa.[FDQ] are implicit extensions
    if(cfg->Zfinx_version>=RVZFINX_0_41) {
        implicit_Extensions |= extensionsPresent(cfg, misa_Extensions, ISA_DFQ);
    }

    // from B extension 1.0.0, misa.B is implicit
    if(cfg->bitmanip_version>=RVBV_1_0_0) {
        implicit_Extensions |= extensionsPresent(cfg, misa_Extensions, ISA_B);
    }

    // from K extension 1.0.0, misa.K is implicit
    if(cfg->crypto_version>=RVKV_1_0_0_RC1) {
        implicit_Extensions |= extensionsPresent(cfg, misa_Extensions, ISA_K);
    }

    // compose full extensions list
    riscvArchitecture allExtensions = misa_Extensions | implicit_Extensions;

    // if the H extension is implemented then S and U must also be present
    if(allExtensions & ISA_H) {
        allExtensions |= (ISA_S|ISA_U);
    }

    // exactly one of I and E base ISA features must be present and initially
    // enabled; if the E bit is initially enabled, the I bit must be read-only
    // and zero
    if(allExtensions & ISA_E) {
        allExtensions &= ~ISA_I;
    } else {
        allExtensions |= ISA_I;
    }

    // get extensions before masking for fixed
    riscvArchitecture rawExtensions = allExtensions;

    // features in the fixed mask may not be modified by parameters
    allExtensions = (
        (cfg->arch     &  cfg->archFixed) |
        (allExtensions & ~cfg->archFixed)
    );

    // report extensions that may not be modified by parameters
    riscvArchitecture fixed = (rawExtensions^allExtensions) & ((1<<26)-1);
    if(fixed && !getNumChildren(riscv)) {
        reportFixed(fixed, cfg);
    }

    // only present extensions can be members of implicit_Extensions
    implicit_Extensions &= allExtensions;

    // implicit extension bits are not writable
    misa_Extensions_mask &= ~implicit_Extensions;

    // the E bit is always read only (it is a complement of the I bit)
    misa_Extensions_mask &= ~ISA_E;

    // only present extensions can be members of misa_Extensions_mask
    misa_Extensions_mask &= allExtensions;

    // define architecture and writable bits
    Uns32 misa_MXL_mask = cfg->MXL_writable ? 3 : 0;
    cfg->arch         = allExtensions        | (misa_MXL<<XLEN_SHIFT);
    cfg->archMask     = misa_Extensions_mask | (misa_MXL_mask<<XLEN_SHIFT);
    cfg->archImplicit = implicit_Extensions;

    // enable_fflags_i can only be set if floating point is present
    cfg->enable_fflags_i = cfg->enable_fflags_i && (cfg->arch&ISA_DF);

    // initialize ISA_XLEN in currentArch
    riscv->currentArch = misa_MXL<<XLEN_SHIFT;

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
    REQUIRE_COMMERCIAL(riscv, params, Zvqmac);
    REQUIRE_COMMERCIAL(riscv, params, Zvfh);
    REQUIRE_COMMERCIAL(riscv, params, Zvfhmin);
    REQUIRE_COMMERCIAL(riscv, params, Zvfbfmin);
    REQUIRE_COMMERCIAL(riscv, params, Zvfbfwma);

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

    // Zvfbfmin extension is only available from version RVVV_1_0
    cfg->Zvfbfmin = params->Zvfbfmin && (params->vector_version>=RVVV_1_0);

    // Zvfbfwma extension is only available from version RVVV_1_0
    cfg->Zvfbfwma = params->Zvfbfwma && (params->vector_version>=RVVV_1_0);

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
        cfg->bitmanip_absent |= ~RVBS_1_0_0;
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
    ADD_K_SET2(riscv, cfg, params, Zvbb, Zvkb);
    ADD_K_SET(riscv, cfg, params, Zvbc);
    ADD_K_SET(riscv, cfg, params, Zvkg);
    ADD_K_SET(riscv, cfg, params, Zvknha);
    ADD_K_SET(riscv, cfg, params, Zvknhb);
    ADD_K_SET(riscv, cfg, params, Zvkned);
    ADD_K_SET(riscv, cfg, params, Zvksed);
    ADD_K_SET(riscv, cfg, params, Zvksh);

    // Zvknhb implies Zvknha for feature presence
    if(!(cfg->crypto_absent & RVKS_Zvknhb)) {
        cfg->crypto_absent &= ~RVKS_Zvknha;
    }

    // when vector cryptographic extension is present, force misa.K to be
    // implicit if there are no scalar cryptographic subsets present (this field
    // is implicit from scalar K extension 1.0.0, but if all subsets are absent
    // the user might not specify scalar version)
    if((cfg->arch&ISA_VK)==ISA_VK) {

        static const riscvCryptoSet scalarK =
            RVKS_Zbkb  |
            RVKS_Zbkc  |
            RVKS_Zbkx  |
            RVKS_Zkr   |
            RVKS_Zknd  |
            RVKS_Zkne  |
            RVKS_Zknh  |
            RVKS_Zksed |
            RVKS_Zksh;

        if((cfg->crypto_absent & scalarK) == scalarK) {
            cfg->archMask     &= ~ISA_K;
            cfg->archImplicit |=  ISA_K;
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // COMPRESSED EXTENSION CONFIGURATION
    ////////////////////////////////////////////////////////////////////////////

    Bool addZcd = (cfg->arch&ISA_D) && !Zfinx(riscv);

    cfg->compress_present = 0;

    if(!cfg->compress_version) {

        // legacy instructions: force Zcb and Zcf to be present
        cfg->compress_present |= RVCS_Zca;
        cfg->compress_present |= RVCS_Zcf;

        // force Zcd to be present if Zceb is absent or D is present and Zfinx
        // absent
        if(!Zceb(riscv) || addZcd) {
            cfg->compress_present |= RVCS_Zcd;
        }

        // Zceb is incompatible with D extension unless Zfinx is also specified
        if(Zceb(riscv) && addZcd) {
            vmiMessage("W", CPU_PREFIX"_ZCEBNA",
                "Zceb cannot be used with D extension - ignored"
            );
            cfg->Zceb_version = RVZCEB_NA;
        }

        // handle legacy compressed profile parameters
        ADD_CLEG_SET(riscv, cfg, params, Zcea);
        ADD_CLEG_SET(riscv, cfg, params, Zceb);
        ADD_CLEG_SET(riscv, cfg, params, Zcee);

    } else {

        // handle new compressed profile parameters
        ADD_CNEW_SET(riscv, cfg, params, Zca);
        ADD_CNEW_SET(riscv, cfg, params, Zcb);
        ADD_CNEW_SET(riscv, cfg, params, Zcf);
        ADD_CNEW_SET(riscv, cfg, params, Zcmb);
        ADD_CNEW_SET(riscv, cfg, params, Zcmp);
        ADD_CNEW_SET(riscv, cfg, params, Zcmpe);
        ADD_CNEW_SET(riscv, cfg, params, Zcmt);

        // notional Zcd is incompatible with Zcm* extensions (note that Zcd is
        // really part of Zca if implemented)
        if(!cfg->compress_present) {
            cfg->compress_present |= (RVCS_Zca|RVCS_Zcd|RVCS_Zcf);
        } else if(!(cfg->compress_present & RVCS_Zca)) {
            // notional Zcd absent if Zca not implemented
        } else if(!(cfg->compress_present & RVCS_ZcNotD)) {
            cfg->compress_present |= RVCS_Zcd;
        } else if(!addZcd) {
            // use conflicting Zcm* extensions
        } else {
            vmiMessage("W", CPU_PREFIX"_ZCFNA",
                "Zcd cannot be used with Zcm* extensions - ignored"
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // DSP EXTENSION CONFIGURATION
    ////////////////////////////////////////////////////////////////////////////

    // handle DSP profile parameters
    cfg->dsp_absent = 0;
    ADD_P_SET(riscv, cfg, params, Zpsfoperand);

    ////////////////////////////////////////////////////////////////////////////
    // CLIC CONFIGURATION
    ////////////////////////////////////////////////////////////////////////////

    // seed mask of hardwired-to-1 bits in xintthresh CSRs
    if(cfg->INTTHRESHBITS<8) {
        riscv->threshOnes = (1<<(8-cfg->INTTHRESHBITS))-1;
    }

    ////////////////////////////////////////////////////////////////////////////
    // AIA CONFIGURATION
    ////////////////////////////////////////////////////////////////////////////

    // HIPRIOLEN must be at least as large as IPRIOLEN
    if(cfg->HIPRIOLEN<cfg->IPRIOLEN) {
        vmiMessage("W", CPU_PREFIX"_IHIPRIOLEN",
            "'IPRIOLEN' (%u) exceeds 'HIPRIOLEN' (%u) - forcing HIPRIOLEN=%u",
            cfg->IPRIOLEN, cfg->HIPRIOLEN, cfg->IPRIOLEN
        );
        cfg->HIPRIOLEN = cfg->IPRIOLEN;
    }

    ////////////////////////////////////////////////////////////////////////////
    // PMP CONFIGURATION
    ////////////////////////////////////////////////////////////////////////////

    riscv->pmpStraddle = (
        // unaligned accesses could straddle any boundary
        cfg->unaligned ||
        // 64-bit F registers could straddle any 32-bit boundary
        (riscvGetFlenArch(riscv) > 32) ||
        // 64-bit X registers could straddle any 32-bit boundary
        (riscvGetXlenArch(riscv) > 32) ||
        // CMO extension generates accesses wider than 32 bits
        cfg->Zicbom ||
        cfg->Zicbop ||
        cfg->Zicboz
    );
}

//
// Apply parameters applicable at root level
//
static void applyParams(
    riscvP            riscv,
    riscvParamValuesP params,
    Uns32             smpIndex
) {
    riscvConfigP cfg    = &riscv->configInfo;
    riscvP       parent = riscv->parent;
    Uns64        mhartid;

    if(riscvIsCluster(riscv)) {

        // cluster usage - allocate cluster variant string table
        riscvNewClusterVariants(riscv, params->clusterVariants);

        // apply parameters applicable at root level
        applyParamsRoot(riscv, params);

    } else if(parent && !riscvIsCluster(parent)) {

        // SMP member usage - copy parent configuration and apply parameters
        *cfg = parent->configInfo;

        // use container mhartid, plus SMP index
        mhartid = cfg->csr.mhartid.u64.bits + smpIndex;

        // apply parameters
        applyParamsSMP(riscv, params, mhartid);

    } else if(parent || riscv->parameters) {

        // hart or SMP container usage - copy configuration
        *cfg = *getConfigVariantArg(riscv, params);

        // use mhartnum parameter if set, otherwise any non-zero mhartid in the
        // configuration, otherwise the incrementing hart index
        if(params->SETBIT(mhartid)) {
            mhartid = params->mhartid;
        } else if(!(mhartid=cfg->csr.mhartid.u64.bits)) {
            mhartid = riscv->clusterRoot->numHarts;
        }

        // apply parameters
        applyParamsSMP(riscv, params, mhartid);

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

    // initialize enhanced model support callbacks that apply at all levels
    initAllModelCBs(riscv);

    // set hierarchical properties
    if(!parent) {
        riscv->clusterRoot = riscv;
        riscv->smpRoot     = riscv;
        riscv->flags       = vmirtProcessorFlags(processor);
    } else {
        riscv->parent      = parent;
        riscv->clusterRoot = parent->clusterRoot;
        riscv->smpRoot     = riscvIsCluster(parent) ? riscv : parent;
        riscv->flags       = parent->flags;
    }

    // use parameters from parent if that is an SMP container
    if(parent && !riscvIsCluster(parent)) {
        paramValues = parent->paramValues;
    }

    // apply parameters
    applyParams(riscv, paramValues, smpContext->index);

    // if this is a container, get the number of children
    Uns32 numChildren = getNumChildren(riscv);

    // is this a multicore processor container?
    if(numChildren) {

        // supply basic SMP configuration properties
        smpContext->isContainer = True;
        smpContext->numChildren = numChildren;

        // save parameters for use in child
        riscv->paramValues = paramValues;

    } else {

        // initialize enhanced model support callbacks that apply at leaf levels
        initLeafModelCBs(riscv);

        // indicate no interrupts are pending and enabled initially
        riscv->pendEnab.id  = RV_NO_INT;
        riscv->clicState.id = RV_NO_INT;
        riscv->clic.sel.id  = RV_NO_INT;

        // indicate no LR/SC is active initially
        clearEA(riscv);

        // initialize mask of implemented exceptions
        riscvSetExceptionMask(riscv);

        // allocate PMP structures
        riscvVMNewPMP(riscv);

        // allocate MPU structures
#if(ENABLE_SSMPU)
        riscvVMNewMPU(riscv);
#endif
        // initialize CSR state
        riscvCSRInit(riscv);

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

        // add CSR commands
        if(!isPSE(riscv)) {
            addDebugCommand(riscv);
            riscvAddCSRCommands(riscv);
        }

        // set hart index number within cluster
        riscv->hartNum = riscv->clusterRoot->numHarts++;

        // set hart index number within SMP group
        if(riscv->smpRoot != riscv->clusterRoot) {
            riscv->smpRoot->numHarts++;
        }
    }
}

//
// Initialize cluster state for a hart
//
static VMI_SMP_ITER_FN(initializeCluster) {

    riscvP riscv = (riscvP)processor;

    if(isLeaf(riscv)) {

        // fill CLINT entry if required
        riscvFillCLINT(riscv);

        // fill CLIC entry if required
        riscvFillCLIC(riscv);
    }
}

//
// Do initial reset for a hart
//
static VMI_SMP_ITER_FN(initialReset) {

    riscvP riscv = (riscvP)processor;

    if(isLeaf(riscv)) {
        riscvReset(riscv);
    }
}

//
// RISCV processor post-constructor
//
VMI_POST_CONSTRUCTOR_FN(riscvPostConstructor) {

    riscvP root = (riscvP)processor;

    if(!isPSE(root)) {

        // allocate CLINT data structures if required
        riscvNewCLINT(root);

        // allocate CLIC data structures if required
        riscvNewCLIC(root);

        // initialize cluster state for each hart
        vmirtIterAllProcessors(processor, initializeCluster, 0);

        // do initial reset of each hart
        vmirtIterAllProcessors(processor, initialReset, 0);

    } else {

        // do initial reset
        riscvReset(root);
    }

    // create root level bus port specifications for root level ports
    riscvNewRootBusPorts(root);
}

//
// Processor destructor (all levels)
//
static VMI_SMP_ITER_FN(perProcessorDestructor) {

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

    // free MPU structures
#if(ENABLE_SSMPU)
    riscvVMFreeMPU(riscv);
#endif

    // free cluster variant structures
    riscvFreeClusterVariants(riscv);
}

//
// Processor destructor
//
VMI_DESTRUCTOR_FN(riscvDestructor) {

    riscvP root = (riscvP)processor;

    // free CLINT data structures
    riscvFreeCLINT(root);

    // do initial reset of each hart
    vmirtIterAllProcessors(processor, perProcessorDestructor, 0);
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


