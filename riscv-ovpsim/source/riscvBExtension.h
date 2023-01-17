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

// basic types
#include "hostapi/impTypes.h"

// VMI header files
#include "vmi/vmiTypes.h"

// model header files
#include "riscvTypeRefs.h"

//
// This enumerates B-extension operations with special behavior
//
typedef enum riscvBExtOpE {

    RVBOP_NONE,         // not a B-extension operation

    // B extension operation subsets (if not callbacks)
    RVBOP_Zba,          // address calculation
    RVBOP_Zbb,          // base set
    RVBOP_Zbc,          // carryless operations
    RVBOP_Zbe,          // bit deposit/extract
    RVBOP_Zbf,          // bit field place
    RVBOP_Zbm,          // bit matrix operations
    RVBOP_Zbp,          // permutation instructions
    RVBOP_Zbr,          // CSR32 operations
    RVBOP_Zbs,          // single bit instructions
    RVBOP_Zbt,          // ternary instructions
    RVBOP_Zbbp,         // Zbb and Zbp
    RVBOP_Zbmp,         // Zbm and Zbp
    RVBOP_Zbefmp,       // Zbe, Zbf, Zbm and Zbp
    RVBOP_Zbefp,        // Zbe, Zbf and Zbp

    // K extension operation subsets
    RVBOP_Zbkb,         // cryptography subset
    RVBOP_Zbkc,         // carryless multiply subset
    RVBOP_Zbkx,         // crossbar multiply subset
    RVBOP_GORCI,        // gorci subset
    RVBOP_REV8W,        // rev8w subset

    // operations implemented as callbacks or version-specific
    RVBOP_GORC,         // gorc/gorci
    RVBOP_ORCB,         // orcb
    RVBOP_ORC16,        // orc16
    RVBOP_GREV,         // grev/grevi
    RVBOP_REV8,         // rev8
    RVBOP_REV,          // rev
    RVBOP_CRC32,        // crc32/crc32c
    RVBOP_SHFL,         // shfl/shfli
    RVBOP_UNSHFL,       // unshfl/unshfli
    RVBOP_BMATFLIP,     // bmatflip
    RVBOP_BMATOR,       // bmator
    RVBOP_BMATXOR,      // bmatxor
    RVBOP_BEXT,         // bext
    RVBOP_BDEP,         // bdep
    RVBOP_PACK,         // pack
    RVBOP_PACKU,        // packu
    RVBOP_PACKH,        // packh
    RVBOP_PACKW,        // packw
    RVBOP_PACKUW,       // packuw
    RVBOP_ZEXT32_H,     // zext.h (RV32)
    RVBOP_ZEXT64_H,     // zext.h (RV64)
    RVBOP_FSL,          // fsl
    RVBOP_FSR,          // fsr/fsri
    RVBOP_BFP,          // bfp
    RVBOP_ADD_UW,       // add.uw
    RVBOP_SLLI_UW,      // slli.uw
    RVBOP_SLO_SRO,      // slo/sloi/sro/sroi in Zbb or Zbp set
    RVBOP_XPERM,        // xperm

    RVBOP_LAST,         // KEEP LAST: for sizing

} riscvBExtOp;

//
// This specifies subset requirements for B, K and P extensions
//
typedef struct riscvBExtOpSetS {
    riscvBExtOp B : 8;  // B extension subsets
    riscvBExtOp K : 8;  // K extension shared operation subsets
    riscvBExtOp P : 8;  // P extension shared operation subsets
} riscvBExtOpSet;

//
// Return implementation callback for B-extension operation and bits
//
vmiCallFn riscvGetBOpCB(riscvP riscv, riscvBExtOp op, Uns32 bits);

//
// Validate that the instruction subset is supported and enabled and take an
// Illegal Instruction exception if not
//
Bool riscvValidateBExtSubset(riscvP riscv, riscvBExtOpSet op);

