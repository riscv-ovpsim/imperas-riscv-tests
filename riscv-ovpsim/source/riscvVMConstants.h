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

//
// This is the minimum page shift
//
#define RISCV_PAGE_SHIFT 12

//
// This is the minimum page size
//
#define RISCV_PAGE_SIZE (1<<RISCV_PAGE_SHIFT)

//
// This is the assumed cache line size
//
#define RISCV_CBYTES 32

//
// Enumeration of supported translation modes
//
typedef enum riscvVAModeE {
    VAM_Bare =  0,  // bare mode
    VAM_Sv32 =  1,  // Sv32 translation (32-bit VA)
    VAM_Sv39 =  8,  // Sv39 translation (39-bit VA)
    VAM_Sv48 =  9,  // Sv48 translation (48-bit VA)
    VAM_Sv57 = 10,  // Sv57 translation (57-bit VA)
    VAM_Sv64 = 11,  // Sv64 translation (64-bit VA)
} riscvVAMode;

//
// Enumeration of supported translation modes as bitmask
//
typedef enum riscvVAModeBitE {

    // basic entries
    RISCV_VMM_BARE = (1<<VAM_Bare),
    RISCV_VMM_SV32 = (1<<VAM_Sv32),
    RISCV_VMM_SV39 = (1<<VAM_Sv39),
    RISCV_VMM_SV48 = (1<<VAM_Sv48),
    RISCV_VMM_SV57 = (1<<VAM_Sv57),
    RISCV_VMM_SV64 = (1<<VAM_Sv64),

    // composite entries
    RISCV_VMM_32 = (RISCV_VMM_BARE|RISCV_VMM_SV32),
    RISCV_VMM_64 = (RISCV_VMM_BARE|RISCV_VMM_SV39|RISCV_VMM_SV48|RISCV_VMM_SV57)

} riscvVAModeBit;

