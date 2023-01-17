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

#pragma once

// model header files
#include "riscvBlockState.h"
#include "riscvModelCallbackTypes.h"
#include "riscvRegisterTypes.h"
#include "riscvTypeRefs.h"
#include "riscvTypes.h"
#include "riscvVectorTypes.h"
#include "riscvVariant.h"


////////////////////////////////////////////////////////////////////////////////
// MESSAGES
////////////////////////////////////////////////////////////////////////////////

//
// This holds an Illegal Instruction description
//
typedef struct illegalDescS {
    const char *id;     // message ID
    const char *detail; // detailed description
} illegalDesc, *illegalDescP;

//
// Macro used to define illegalDesc structure and emit an Illegal Instruction
// using it
//
#define ILLEGAL_INSTRUCTION_MESSAGE(_RISCV, _ID, _DETAIL) { \
    static illegalDesc _DESC = { .id=CPU_PREFIX"_"_ID, .detail=_DETAIL};    \
    riscvEmitIllegalInstructionMessageDesc(_RISCV, &_DESC);                 \
}

//
// Macro used to define illegalDesc structure and emit an Virtual Instruction
// using it
//
#define VIRTUAL_INSTRUCTION_MESSAGE(_RISCV, _ID, _DETAIL) { \
    static illegalDesc _DESC = { .id=CPU_PREFIX"_"_ID, .detail=_DETAIL};    \
    riscvEmitVirtualInstructionMessageDesc(_RISCV, &_DESC);                 \
}

//
// Macro used to define illegalDesc structure and emit an Illegal Instruction
// using it (operand check)
//
#define ILLEGAL_OPERAND_MESSAGE(_RISCV, _ID, _DETAIL, _OPERAND) { \
    static illegalDesc _DESC = { .id=CPU_PREFIX"_"_ID, .detail=_DETAIL};    \
    riscvEmitIllegalOperandMessageDesc(_RISCV, &_DESC, _OPERAND);           \
}

//
// Emit Illegal Instruction because the current mode has insufficient
// privilege
//
void riscvEmitIllegalInstructionMode(riscvP riscv);

//
// Emit Illegal Instruction because the current virtual mode has insufficient
// privilege
//
void riscvEmitVirtualInstructionMode(riscvP riscv);

//
// Emit code to take an Illegal Instruction exception for the given reason
//
void riscvEmitIllegalInstructionMessage(riscvP riscv, const char *reason);

//
// Emit code to take a Virtual Instruction exception for the given reason
//
void riscvEmitVirtualInstructionMessage(riscvP riscv, const char *reason);

//
// Emit Illegal Instruction message and take Illegal Instruction exception
//
void riscvEmitIllegalInstructionMessageDesc(riscvP riscv, illegalDescP desc);

//
// Emit Illegal Instruction message and take Virtual Instruction exception
//
void riscvEmitVirtualInstructionMessageDesc(riscvP riscv, illegalDescP desc);

//
// Emit Illegal Operand message and take Illegal Instruction exception
//
void riscvEmitIllegalOperandMessageDesc(
    riscvP       riscv,
    illegalDescP desc,
    Uns32        operand
);

//
// Emit code to take Illegal Instruction exception when a feature subset is
// absent
//
void riscvEmitIllegalInstructionAbsentSubset(const char *name);

//
// Emit code to take Illegal Instruction exception when a feature subset is
// present
//
void riscvEmitIllegalInstructionPresentSubset(const char *name);

//
// Validate that the given required feature is present and enabled (using
// blockMask if necessary)
//
Bool riscvRequireArchPresentMT(riscvP riscv, riscvArchitecture feature);

//
// Emit blockMask check for the given feature set
//
void riscvEmitBlockMask(riscvP riscv, riscvArchitecture features);


////////////////////////////////////////////////////////////////////////////////
// EXTENSION LIBRARY CALLBACKS
////////////////////////////////////////////////////////////////////////////////

//
// Validate that the instruction is supported and enabled and take an Illegal
// Instruction exception if not
//
Bool riscvInstructionEnabled(riscvP riscv, riscvArchitecture requiredVariant);

//
// Return VMI register for the given abstract register
//
vmiReg riscvGetVMIReg(riscvP riscv, riscvRegDesc r);

//
// Return VMI register for the given abstract register which may require a NaN
// box test if it is floating point
//
vmiReg riscvGetVMIRegFS(riscvP riscv, riscvRegDesc r, vmiReg tmp);

//
// Do actions when a register is written (extending or NaN boxing, if
// required)
//
void riscvWriteRegSize(
    riscvP       riscv,
    riscvRegDesc r,
    Uns32        srcBits,
    Bool         signExtend
);

//
// Do actions when a register is written (extending or NaN boxing, if
// required) using the derived register size
//
void riscvWriteReg(riscvP riscv, riscvRegDesc r, Bool signExtend);

//
// Return morph-time endianness for data accesses in the current mode
//
memEndian riscvGetCurrentDataEndianMT(riscvP riscv);


////////////////////////////////////////////////////////////////////////////////
// FPU
////////////////////////////////////////////////////////////////////////////////

//
// Configure FPU
//
void riscvConfigureFPU(riscvP riscv);

//
// Adjust JIT code generator state after write of floating point CSR
//
void riscvWFS(riscvMorphStateP state, Bool useRS1);

//
// Adjust JIT code generator state after write of vcsr CSR, which will set
// vector state dirty and floating point state dirty (if floating point is
// enabled)
//
void riscvWVCSR(riscvMorphStateP state, Bool useRS1);

//
// Adjust JIT code generator state after write of vector CSR that affects
// floating point state (behavior clearly defined only after version 20191118)
//
void riscvWFSVS(riscvMorphStateP state, Bool useRS1);

//
// Reset JIT code generator state after possible write of mstatus.FS
//
void riscvRstFS(riscvMorphStateP state, Bool useRS1);

//
// Return VMI register for floating point status flags when written (NOTE:
// mstatus.FS might need to be updated as well)
//
vmiReg riscvGetFPFlagsMT(riscvP riscv);


////////////////////////////////////////////////////////////////////////////////
// LOAD/STORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Validate the given rounding mode is legal and emit an Illegal Instruction
// exception call if not
//
Bool riscvEmitCheckLegalRM(riscvP riscv, riscvRMDesc rm);

//
// Fundamental load operation
//
void riscvEmitLoad(
    riscvP            riscv,
    vmiReg            rd,
    Uns32             rdBits,
    vmiReg            ra,
    Uns32             memBits,
    Uns64             offset,
    riscvExtLdStAttrs attrs
);

//
// Fundamental store operation
//
void riscvEmitStore(
    riscvP            riscv,
    vmiReg            rs,
    vmiReg            ra,
    Uns32             memBits,
    Uns64             offset,
    riscvExtLdStAttrs attrs
);


////////////////////////////////////////////////////////////////////////////////
// MODE VALIDATION
////////////////////////////////////////////////////////////////////////////////

//
// Validate the hart operation mode is at least the specified mode and emit an
// Illegal Instruction or Virtual Instruction exception if not
//
Bool riscvEmitRequireMode(riscvP riscv, riscvMode mode);

//
// Validate the hart is not in virtual mode and emit a Virtual Instruction
// exception if not
//
Bool riscvEmitRequireNotV(riscvP riscv);

//
// Emit trap when mstatus.TVM=1 in Supervisor mode
//
void riscvEmitTrapTVM(riscvP riscv);

//
// Emit trap when mstatus.TSR=1 in Supervisor mode
//
void riscvEmitTrapTSR(riscvP riscv);

//
// Emit trap when hvictl.VTI=1 in Virtual Supervisor mode
//
void riscvEmitTrapVTI(riscvP riscv);


////////////////////////////////////////////////////////////////////////////////
// VECTOR EXTENSION
////////////////////////////////////////////////////////////////////////////////

//
// Configure vector extension
//
void riscvConfigureVector(riscvP riscv);

//
// Free vector extension data structures
//
void riscvFreeVector(riscvP riscv);

//
// Adjust JIT code generator state after write of vstart CSR
//
void riscvWVStart(riscvMorphStateP state, Bool useRS1);

//
// Get effective SEW
//
riscvSEWMt riscvGetSEWMt(riscvP riscv);

//
// Return maximum vector length for the given vector type settings
//
Uns32 riscvGetMaxVL(riscvP riscv, riscvVType vtype);

//
// If the specified vtype is valid, return the SEW, otherwise return
// SEWMT_UNKNOWN
//
riscvSEWMt riscvValidVType(riscvP riscv, riscvVType vtype);

//
// Translate externally-implemented instruction
//
void riscvMorphExternal(
    riscvExtMorphStateP state,
    const char         *disableReason,
    Bool               *opaque
);

//
// Emit externally-implemented vector operation
//
void riscvMorphVOp(
    riscvP           riscv,
    Uns64            thisPC,
    riscvRegDesc     r0,
    riscvRegDesc     r1,
    riscvRegDesc     r2,
    riscvRegDesc     mask,
    riscvVShape      shape,
    riscvVExternalFn externalCB,
    void            *userData
);

