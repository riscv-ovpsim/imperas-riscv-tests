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
// Coverage point identifiers
//
typedef enum rvCoverTypeE {

    //////////////////////////////// PTW ///////////////////////////////////////

                            // PAGE TABLE WALK START/END INDICATORS
    RVC_PTE_START,          // start walk
    RVC_PTE_END,            // end walk

                            // PAGE TABLE WALK MODES
    RVC_PTE_U,              // U-mode
    RVC_PTE_S,              // S-mode

                            // PAGE TABLE WALK STAGES
    RVC_PTE_HS,             // HS
    RVC_PTE_VS1,            // virtual stage 1
    RVC_PTE_VS2,            // virtual stage 2

                            // PAGE TABLE WALK CASES
    RVC_PTE_OK,             // successful walk
    RVC_PTE_VAEXTEND,       // VA has invalid extension
    RVC_PTE_GPAEXTEND,      // GPA has invalid extension
    RVC_PTE_READ,           // page table entry load failed
    RVC_PTE_WRITE,          // page table entry store failed
    RVC_PTE_V0,             // page table entry V=0
    RVC_PTE_R0W1,           // page table entry R=0 W=1
    RVC_PTE_LEAF,           // page table entry must be leaf level
    RVC_PTE_ALIGN,          // page table entry is a misaligned superpage
    RVC_PTE_PRIV,           // page table entry does not allow access
    RVC_PTE_A0,             // page table entry A=0
    RVC_PTE_D0,             // page table entry D=0
    RVC_PTE_RES0,           // page table entry reserved bits not zero
    RVC_PTE_D_NL,           // page table entry non-leaf and D!=0
    RVC_PTE_A_NL,           // page table entry non-leaf and A!=0
    RVC_PTE_U_NL,           // page table entry non-leaf and U!=0
    RVC_PTE_SVNAPOT,        // page table entry Svnapot invalid
    RVC_PTE_SVPBMT,         // page table entry Svpbmt invalid
    RVC_PTE_CUSTOM,         // custom entry check failed

                            // PAGE TABLE WALK LEVELS
    RVC_PTE_L0,             // level 0
    RVC_PTE_L1,             // level 1
    RVC_PTE_L2,             // level 2
    RVC_PTE_L3,             // level 3
    RVC_PTE_L4,             // level 4
    RVC_PTE_L5,             // level 5

    //////////////////////////////// PMP ///////////////////////////////////////

                            // PMP START INDICATORS
    RVC_PMP_START_R,        // start lookup for read permission
    RVC_PMP_START_W,        // start lookup for write permission
    RVC_PMP_START_X,        // start lookup for execute permission

                            // PMP UNMATCHED MODE INDICATORS
    RVC_PMP_UM_M_BASE,      // base specification M-mode
    RVC_PMP_UM_M_MMWP,      // mseccfg.MMWP=1, M-mode
    RVC_PMP_UM_MML,         // mseccfg.MML=1, M-mode
    RVC_PMP_UM_SU,          // S/U-mode

                            // PMP REGION TYPES
    RVC_PMP_NA4,            // NA4 region
    RVC_PMP_NAPOT,          // NAPOT region
    RVC_PMP_TOR,            // TOR region

                            // PMP COVERAGE, mseccfg.MML=0, M-MODE, L=0
    RVC_PMP_M_L0_P0,        // rwx=0
    RVC_PMP_M_L0_P1,        // rwx=1
    RVC_PMP_M_L0_P2,        // rwx=2
    RVC_PMP_M_L0_P3,        // rwx=3
    RVC_PMP_M_L0_P4,        // rwx=4
    RVC_PMP_M_L0_P5,        // rwx=5
    RVC_PMP_M_L0_P6,        // rwx=6
    RVC_PMP_M_L0_P7,        // rwx=7

                            // PMP COVERAGE, mseccfg.MML=0, M-MODE, L=1
    RVC_PMP_M_L1_P0,        // rwx=0
    RVC_PMP_M_L1_P1,        // rwx=1
    RVC_PMP_M_L1_P2,        // rwx=2
    RVC_PMP_M_L1_P3,        // rwx=3
    RVC_PMP_M_L1_P4,        // rwx=4
    RVC_PMP_M_L1_P5,        // rwx=5
    RVC_PMP_M_L1_P6,        // rwx=6
    RVC_PMP_M_L1_P7,        // rwx=7

                            // PMP COVERAGE, mseccfg.MML=0, S/U-MODE
    RVC_PMP_SU_P0,          // rwx=0
    RVC_PMP_SU_P1,          // rwx=1
    RVC_PMP_SU_P2,          // rwx=2
    RVC_PMP_SU_P3,          // rwx=3
    RVC_PMP_SU_P4,          // rwx=4
    RVC_PMP_SU_P5,          // rwx=5
    RVC_PMP_SU_P6,          // rwx=6
    RVC_PMP_SU_P7,          // rwx=7

                            // PMP COVERAGE, mseccfg.MML=1, M-MODE, L=0
    RVC_PMP_MML1_M_L0_P0,   // rwx=0
    RVC_PMP_MML1_M_L0_P1,   // rwx=1
    RVC_PMP_MML1_M_L0_P2,   // rwx=2
    RVC_PMP_MML1_M_L0_P3,   // rwx=3
    RVC_PMP_MML1_M_L0_P4,   // rwx=4
    RVC_PMP_MML1_M_L0_P5,   // rwx=5
    RVC_PMP_MML1_M_L0_P6,   // rwx=6
    RVC_PMP_MML1_M_L0_P7,   // rwx=7

                            // PMP COVERAGE, mseccfg.MML=1, M-MODE, L=1
    RVC_PMP_MML1_M_L1_P0,   // rwx=0
    RVC_PMP_MML1_M_L1_P1,   // rwx=1
    RVC_PMP_MML1_M_L1_P2,   // rwx=2
    RVC_PMP_MML1_M_L1_P3,   // rwx=3
    RVC_PMP_MML1_M_L1_P4,   // rwx=4
    RVC_PMP_MML1_M_L1_P5,   // rwx=5
    RVC_PMP_MML1_M_L1_P6,   // rwx=6
    RVC_PMP_MML1_M_L1_P7,   // rwx=7

                            // PMP COVERAGE, mseccfg.MML=1, S/U-MODE, L=0
    RVC_PMP_MML1_SU_L0_P0,  // rwx=0
    RVC_PMP_MML1_SU_L0_P1,  // rwx=1
    RVC_PMP_MML1_SU_L0_P2,  // rwx=2
    RVC_PMP_MML1_SU_L0_P3,  // rwx=3
    RVC_PMP_MML1_SU_L0_P4,  // rwx=4
    RVC_PMP_MML1_SU_L0_P5,  // rwx=5
    RVC_PMP_MML1_SU_L0_P6,  // rwx=6
    RVC_PMP_MML1_SU_L0_P7,  // rwx=7

                            // PMP COVERAGE, mseccfg.MML=1, S/U-MODE, L=1
    RVC_PMP_MML1_SU_L1_P0,  // rwx=0
    RVC_PMP_MML1_SU_L1_P1,  // rwx=1
    RVC_PMP_MML1_SU_L1_P2,  // rwx=2
    RVC_PMP_MML1_SU_L1_P3,  // rwx=3
    RVC_PMP_MML1_SU_L1_P4,  // rwx=4
    RVC_PMP_MML1_SU_L1_P5,  // rwx=5
    RVC_PMP_MML1_SU_L1_P6,  // rwx=6
    RVC_PMP_MML1_SU_L1_P7,  // rwx=7

                            // PMP MAP ACTION
    RVC_PMP_MAPPED,         // PMP region was mapped
    RVC_PMP_BOUNDS,         // PMP failure, bad region bounds
    RVC_PMP_PRIV,           // PMP failure, access permissions
    RVC_PMP_STRADDLE,       // PMP failure, aligned access not in single region
    RVC_PMP_UNALIGNED,      // PMP failure, unaligned access not decomposed

} rvCoverType;
