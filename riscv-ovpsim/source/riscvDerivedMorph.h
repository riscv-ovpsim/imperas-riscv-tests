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
#include "riscvTypes.h"
#include "riscvTypeRefs.h"

//
// Code generation actions
//
#define RISCV_DERIVED_MORPH_FN(_NAME) void _NAME( \
    riscvP riscv,       \
    void  *clientData,  \
    Uns64  thisPC       \
)
typedef RISCV_DERIVED_MORPH_FN((*riscvDerivedMorphFn));

//
// Emit code to perform custom check for CSR access instructions
//
#define RISCV_EMIT_CSR_CHECK_FN(_NAME) void _NAME( \
    riscvP        riscv,        \
    void         *clientData,   \
    Uns32         csr,          \
    riscvCSRUDesc csrUpdate,    \
    Bool          isRead,       \
    Bool          isWrite,      \
    Bool          useRS1,       \
    Bool          useC,         \
    Uns32         c             \
)
typedef RISCV_EMIT_CSR_CHECK_FN((*riscvEmitCSRCheckFn));

//
// Emit code to perform custom check for otherwise-legal vector unit-stride
// load/store operations
//
#define RISCV_UNIT_STRIDE_CHECK_FN(_NAME) void _NAME( \
    riscvP riscv,       \
    void  *clientData,  \
    vmiReg baseAddr,    \
    Uns32  memBits,     \
    Bool   isLoad       \
)
typedef RISCV_UNIT_STRIDE_CHECK_FN((*riscvUnitStrideCheckFn));

//
// Emit code to perform custom implementation of vector floating point reduction
// instructions. 'vdAcc' is the result accumulator, already seeded with vs1[0].
// 'vs2' is a pointer to the second vector source. 'vm' is NULL for an unmasked
// operation, and otherwise a pointer to the mask register. 'SEW' is the
// current SEW.
//
#define RISCV_VFREDSUM_MORPH_FN(_NAME) void _NAME( \
    riscvP riscv,       \
    void  *clientData,  \
    vmiReg vdAcc,       \
    void  *vs2,         \
    void  *vm,          \
    Uns32  SEW          \
)
typedef RISCV_VFREDSUM_MORPH_FN((*riscvVFREDSUMMorphFn));




