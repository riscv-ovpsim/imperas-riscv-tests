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

// VMI header files
#include "vmi/vmiAttrs.h"
#include "vmi/vmiPSETypes.h"

// model header files
#include "riscvBlockState.h"
#include "riscvFunctions.h"
#include "riscvStructure.h"


static const char *dictNames[] = {

    // 32-bit VM-disabled modes
    [RISCV_DMODE32_U]     = "32-BIT USER",
    [RISCV_DMODE32_S]     = "32-BIT SUPERVISOR",
    [RISCV_DMODE32_VU]    = "32-BIT VIRTUAL USER",
    [RISCV_DMODE32_VS]    = "32-BIT VIRTUAL SUPERVISOR",

    // 64-bit VM-disabled modes
    [RISCV_DMODE64_U]     = "64-BIT USER",
    [RISCV_DMODE64_S]     = "64-BIT SUPERVISOR",
    [RISCV_DMODE64_VU]    = "64-BIT VIRTUAL USER",
    [RISCV_DMODE64_VS]    = "64-BIT VIRTUAL SUPERVISOR",

    // 32-bit VM-enabled modes
    [RISCV_DMODE32_U_VM]  = "32-BIT USER (VM)",
    [RISCV_DMODE32_S_VM]  = "32-BIT SUPERVISOR (VM)",
    [RISCV_DMODE32_VU_VM] = "32-BIT VIRTUAL USER (VM)",
    [RISCV_DMODE32_VS_VM] = "32-BIT VIRTUAL SUPERVISOR (VM)",

    // VM-enabled modes
    [RISCV_DMODE64_U_VM]  = "64-BIT USER (VM)",
    [RISCV_DMODE64_S_VM]  = "64-BIT SUPERVISOR (VM)",
    [RISCV_DMODE64_VU_VM] = "64-BIT VIRTUAL USER (VM)",
    [RISCV_DMODE64_VS_VM] = "64-BIT VIRTUAL SUPERVISOR (VM)",

    // 32-bit Machine mode
    [RISCV_DMODE32_M]     = "32-BIT MACHINE",

    // Machine mode
    [RISCV_DMODE64_M]     = "64-BIT MACHINE",

    // terminator
    [RISCV_DMODE_LAST]  = 0
};

const vmiIASAttr modelAttrs = {

    ////////////////////////////////////////////////////////////////////////
    // VERSION & SIZE ATTRIBUTES
    ////////////////////////////////////////////////////////////////////////

    .versionString      = VMI_VERSION,
    .modelType          = VMI_PROCESSOR_MODEL,
    .dictNames          = dictNames,
    .cpuSize            = sizeof(riscv),
    .blockStateSize     = sizeof(riscvBlockState),

    ////////////////////////////////////////////////////////////////////////
    // MODEL STATUS
    ////////////////////////////////////////////////////////////////////////

    .visibility         = VMI_VISIBLE,
    .releaseStatus      = VMI_OVP,

    ////////////////////////////////////////////////////////////////////////
    // SAVE/RESTORE ROUTINES
    ////////////////////////////////////////////////////////////////////////

    .saveCB             = riscvSaveState,
    .restoreCB          = riscvRestoreState,
    .srVersion          = 0,

    ////////////////////////////////////////////////////////////////////////
    // CONSTRUCTOR/DESTRUCTOR ROUTINES
    ////////////////////////////////////////////////////////////////////////

    .smpNameCB          = riscvGetSMPName,
    .constructorCB      = riscvConstructor,
    .postConstructorCB  = riscvPostConstructor,
    .vmInitCB           = riscvVMInit,
    .destructorCB       = riscvDestructor,

    ////////////////////////////////////////////////////////////////////////
    // MORPHER CORE ROUTINES
    ////////////////////////////////////////////////////////////////////////

    .startBlockCB       = riscvStartBlock,
    .endBlockCB         = riscvEndBlock,
    .preMorphCB         = riscvPreMorph,
    .morphCB            = riscvMorph,
    .postMorphCB        = riscvPostMorph,
    .fetchSnapCB        = riscvFetchSnap,
    .rdSnapCB           = riscvRdSnap,
    .wrSnapCB           = riscvWrSnap,

    ////////////////////////////////////////////////////////////////////////
    // SIMULATION SUPPORT ROUTINES
    ////////////////////////////////////////////////////////////////////////

    .getEndianCB        = riscvGetEndian,
    .nextPCCB           = riscvNextPC,
    .fetchCB            = riscvFetch,
    .disCB              = riscvDisassemble,
    .switchCB           = riscvContextSwitchCB,

    ////////////////////////////////////////////////////////////////////////
    // EXCEPTION ROUTINES
    ////////////////////////////////////////////////////////////////////////

    .rdPrivExceptCB     = riscvRdPrivExcept,
    .wrPrivExceptCB     = riscvWrPrivExcept,
    .rdAlignExceptCB    = riscvRdAlignExcept,
    .wrAlignExceptCB    = riscvWrAlignExcept,
    .rdAbortExceptCB    = riscvRdAbortExcept,
    .wrAbortExceptCB    = riscvWrAbortExcept,
    .rdDeviceExceptCB   = riscvRdDeviceExcept,
    .wrDeviceExceptCB   = riscvWrDeviceExcept,
    .ifetchExceptCB     = riscvIFetchExcept,
    .arithResultCB      = riscvArithResult,

    ////////////////////////////////////////////////////////////////////////
    // PARAMETER SUPPORT ROUTINES
    ////////////////////////////////////////////////////////////////////////

    .preParamSpecsCB    = riscvGetPreParamSpec,
    .preParamValuesCB   = riscvGetPreParamValues,
    .paramSpecsCB       = riscvGetParamSpec,
    .paramValueSizeCB   = riscvParamValueSize,

    ////////////////////////////////////////////////////////////////////////
    // PORT ROUTINES
    ////////////////////////////////////////////////////////////////////////

    .busPortSpecsCB     = riscvBusPortSpecs,
    .netPortSpecsCB     = riscvNetPortSpecs,

    ////////////////////////////////////////////////////////////////////////
    // DEBUGGER INTEGRATION SUPPORT ROUTINES
    ////////////////////////////////////////////////////////////////////////

    .regGroupCB         = riscvRegGroup,
    .regInfoCB          = riscvRegInfo,
    .regImplCB          = riscvRegImpl,
    .exceptionInfoCB    = riscvExceptionInfo,
    .modeInfoCB         = riscvModeInfo,
    .getExceptionCB     = riscvGetException,
    .getModeCB          = riscvGetMode,
#if(ENABLE_MEM_TRACE_ATTRS)
    .traceMemAttrsCB    = riscvTraceMemAttrs,
#endif
    .procDescCB         = riscvProcessorDescription,

    ////////////////////////////////////////////////////////////////////////
    // IMPERAS INTERCEPTED FUNCTION SUPPORT ROUTINES
    ////////////////////////////////////////////////////////////////////////

    .intReturnCB        = riscvIntReturn,
    .intResultCB        = riscvIntResult,
    .intParCB           = riscvIntParCB,

    ////////////////////////////////////////////////////////////////////////
    // PROCESSOR INFO ROUTINE
    ////////////////////////////////////////////////////////////////////////

    .procInfoCB         = riscvProcInfo,

    ////////////////////////////////////////////////////////////////////////////
    // DOCUMENTATION CALLBACKS
    ////////////////////////////////////////////////////////////////////////////

    .docCB              = riscvDoc
};
