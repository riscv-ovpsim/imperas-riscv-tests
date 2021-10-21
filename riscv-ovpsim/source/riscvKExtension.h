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

#pragma once

// basic types
#include "hostapi/impTypes.h"

// VMI header files
#include "vmi/vmiTypes.h"

// model header files
#include "riscvTypeRefs.h"

//
// This enumerates K-extension operations with special behavior
//
typedef enum riscvKExtOpE {

    RVKOP_NONE,         // not a K-extension operation

    // operation subsets (if not callbacks)
    RVKOP_Zkr,          // entropy source
    RVKOP_Zknd,         // NIST AES decryption instructions
    RVKOP_Zkne,         // NIST AES encryption instructions
    RVKOP_Zknh,         // NIST SHA2 hash function instructions
    RVKOP_Zksed,        // SM4 instructions
    RVKOP_Zksh,         // SM3 hash function instructions

    // operations implemented as callbacks or version-specific
    RVKOP_LUT4LO,       // lut4lo
    RVKOP_LUT4HI,       // lut4hi
    RVKOP_LUT4,         // lut4
    RVKOP_SAES32_ENCS,  // aes32esi
    RVKOP_SAES32_ENCSM, // aes32esmi
    RVKOP_SAES32_DECS,  // aes32dsi
    RVKOP_SAES32_DECSM, // aes32dsmi
    RVKOP_SAES64_KS1,   // aes64ks1i
    RVKOP_SAES64_KS2,   // aes64ks2
    RVKOP_SAES64_IMIX,  // aes64im
    RVKOP_SAES64_ENCSM, // aes64es
    RVKOP_SAES64_ENCS,  // aes64esm
    RVKOP_SAES64_DECSM, // aes64ds
    RVKOP_SAES64_DECS,  // aes64dsm
    RVKOP_SSM3_P0,      // sm3p0
    RVKOP_SSM3_P1,      // sm3p1
    RVKOP_SSM4_ED,      // sm4ed
    RVKOP_SSM4_KS,      // sm4ks
    RVKOP_SSHA256_SIG0, // sha256sig0
    RVKOP_SSHA256_SIG1, // sha256sig1
    RVKOP_SSHA256_SUM0, // sha256sum0
    RVKOP_SSHA256_SUM1, // sha256sum1
    RVKOP_SSHA512_SIG0L,// sha512sig0l
    RVKOP_SSHA512_SIG0H,// sha512sig0h
    RVKOP_SSHA512_SIG1L,// sha512sig1l
    RVKOP_SSHA512_SIG1H,// sha512sig1h
    RVKOP_SSHA512_SUM0R,// sha512sum0r
    RVKOP_SSHA512_SUM1R,// sha512sum1r
    RVKOP_SSHA512_SIG0, // sha512sig0
    RVKOP_SSHA512_SIG1, // sha512sig1
    RVKOP_SSHA512_SUM0, // sha512sum0
    RVKOP_SSHA512_SUM1, // sha512sum1

    RVKOP_LAST,         // KEEP LAST: for sizing

} riscvKExtOp;

//
// Do PollEntropy (NOTE: unlike hardware, this is designed to produce a
// deterministic, not-particularly-random sequence, always returning ES16
// status)
//
Uns32 riscvPollEntropy(riscvP riscv);

//
// Return implementation callback for K-extension operation and bits
//
vmiCallFn riscvGetKOpCB(riscvP riscv, riscvKExtOp op, Uns32 bits);

//
// Validate that the instruction subset is supported and enabled and take an
// Illegal Instruction exception if not
//
Bool riscvValidateKExtSubset(riscvP riscv, riscvKExtOp op);

//
// Save K-extension state not covered by register read/write API
//
void riscvCryptoSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
);

//
// Restore K-extension state not covered by register read/write API
//
void riscvCryptoRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
);

