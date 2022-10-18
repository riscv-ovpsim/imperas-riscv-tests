/*
 * Copyright (c) 2005-2022 Imperas Software Ltd., www.imperas.com
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

// Imperas header files
#include "hostapi/impTypes.h"

// model header files
#include "riscvTypeRefs.h"

//
// Map from feature character to feature mask
//
#define XLEN32_CHAR             ('Z'+1)
#define XLEN64_CHAR             ('Z'+2)
#define XLEN128_CHAR            ('Z'+3)
#define RM_INVALID_CHAR         ('Z'+4)
#define MSTATUS_FS_CHAR         ('Z'+5)
#define MSTATUS_BE_CHAR         ('Z'+6)
#define HSTATUS_SPVP_CHAR       ('Z'+7)
#define HSTATUS_VSBE_CHAR       ('Z'+8)
#define VSSTATUS_UBE_CHAR       ('Z'+9)
#define HSTATUS_HU_CHAR         ('Z'+10)
#define VIRTUAL_VM_CHAR         ('Z'+11)
#define MXL64_CHAR              ('Z'+12)
#define SXL64_CHAR              ('Z'+13)
#define UXL64_CHAR              ('Z'+14)
#define VSXL64_CHAR             ('Z'+15)
#define VUXL64_CHAR             ('Z'+16)
#define TM_LA_CHAR              ('Z'+17)
#define TM_LV_CHAR              ('Z'+18)
#define TM_S_CHAR               ('Z'+19)
#define TM_X_CHAR               ('Z'+20)
#define RISCV_FAND_CHAR         ('Z'+21)
#define RISCV_FEATURE_INDEX(_C) ((_C)-'A')
#define RISCV_FEATURE_BIT(_C)   (1ULL<<RISCV_FEATURE_INDEX(_C))
#define XLEN_SHIFT              RISCV_FEATURE_INDEX(XLEN32_CHAR)
#define MSTATUS_FS_SHIFT        RISCV_FEATURE_INDEX(MSTATUS_FS_CHAR)
#define RISCV_FEATURE_MASK      ((1<<(RISCV_FEATURE_INDEX('Z')+1))-1)

//
// This enumerates architecture features in a format compatible with the MISA
// register, plus extra bits indicating XLEN
//
typedef enum riscvArchitectureE {

    // CURRENT REGISTER SIZE
    ISA_XLEN_32  = RISCV_FEATURE_BIT(XLEN32_CHAR),  // supported for XLEN=32
    ISA_XLEN_64  = RISCV_FEATURE_BIT(XLEN64_CHAR),  // supported for XLEN=64
    ISA_XLEN_128 = RISCV_FEATURE_BIT(XLEN128_CHAR), // supported for XLEN=128
    ISA_XLEN_ANY = (ISA_XLEN_32|ISA_XLEN_64|ISA_XLEN_128),

    // ROUNDING MODE INVALID
    ISA_RM_INVALID = RISCV_FEATURE_BIT(RM_INVALID_CHAR),

    // MSTATUS FIELDS
    ISA_FS     = RISCV_FEATURE_BIT(MSTATUS_FS_CHAR),
    ISA_BE     = RISCV_FEATURE_BIT(MSTATUS_BE_CHAR),
    ISA_SPVP   = RISCV_FEATURE_BIT(HSTATUS_SPVP_CHAR),
    ISA_VSBE   = RISCV_FEATURE_BIT(HSTATUS_VSBE_CHAR),
    ISA_VUBE   = RISCV_FEATURE_BIT(VSSTATUS_UBE_CHAR),
    ISA_HU     = RISCV_FEATURE_BIT(HSTATUS_HU_CHAR),
    ISA_VVM    = RISCV_FEATURE_BIT(VIRTUAL_VM_CHAR),

    // XLEN FIELDS
    ISA_MXL64  = RISCV_FEATURE_BIT(MXL64_CHAR),
    ISA_SXL64  = RISCV_FEATURE_BIT(SXL64_CHAR),
    ISA_UXL64  = RISCV_FEATURE_BIT(UXL64_CHAR),
    ISA_VSXL64 = RISCV_FEATURE_BIT(VSXL64_CHAR),
    ISA_VUXL64 = RISCV_FEATURE_BIT(VUXL64_CHAR),
    ISA_XL64   = (ISA_MXL64|ISA_SXL64|ISA_UXL64|ISA_VSXL64|ISA_VUXL64),

    // TRIGGER SENSITIVITY
    ISA_TM_LA  = RISCV_FEATURE_BIT(TM_LA_CHAR),
    ISA_TM_LV  = RISCV_FEATURE_BIT(TM_LV_CHAR),
    ISA_TM_S   = RISCV_FEATURE_BIT(TM_S_CHAR),
    ISA_TM_X   = RISCV_FEATURE_BIT(TM_X_CHAR),

    // FEATURES A AND B
    ISA_and    = RISCV_FEATURE_BIT(RISCV_FAND_CHAR), // (CSR artifact)

    // BASE ISA FEATURES
    ISA_A      = RISCV_FEATURE_BIT('A'),    // atomic instructions
    ISA_B      = RISCV_FEATURE_BIT('B'),    // bit manipulation instructions
    ISA_C      = RISCV_FEATURE_BIT('C'),    // compressed instructions
    ISA_E      = RISCV_FEATURE_BIT('E'),    // embedded instructions
    ISA_D      = RISCV_FEATURE_BIT('D'),    // double-precision floating point
    ISA_F      = RISCV_FEATURE_BIT('F'),    // single-precision floating point
    ISA_H      = RISCV_FEATURE_BIT('H'),    // hypervisor extension
    ISA_I      = RISCV_FEATURE_BIT('I'),    // RV32I/64I/128I base ISA
    ISA_K      = RISCV_FEATURE_BIT('K'),    // cryptographic ISA
    ISA_M      = RISCV_FEATURE_BIT('M'),    // integer multiply/divide instructions
    ISA_N      = RISCV_FEATURE_BIT('N'),    // user-mode interrupts
    ISA_P      = RISCV_FEATURE_BIT('P'),    // DSP instructions
    ISA_Q      = RISCV_FEATURE_BIT('Q'),    // quad-precision floating point
    ISA_S      = RISCV_FEATURE_BIT('S'),    // supervisor mode implemented
    ISA_U      = RISCV_FEATURE_BIT('U'),    // user mode implemented
    ISA_V      = RISCV_FEATURE_BIT('V'),    // vector extension implemented
    ISA_X      = RISCV_FEATURE_BIT('X'),    // non-standard extensions present
    ISA_DF     = (ISA_D|ISA_F),             // floating point
    ISA_DFQ    = (ISA_D|ISA_F|ISA_Q),       // floating point including Q
    ISA_DFS    = (ISA_D|ISA_F|ISA_S),       // either floating point or S-mode
    ISA_DFV    = (ISA_D|ISA_F|ISA_V),       // either floating point or vector
    ISA_SandK  = (ISA_S|ISA_K|ISA_and),     // both supervisor and cryptographic
    ISA_SorN   = (ISA_S|ISA_N),             // either supervisor or user interrupts
    ISA_SandN  = (ISA_S|ISA_N|ISA_and),     // both supervisor and user interrupts
    ISA_FSandV = (ISA_FS|ISA_V|ISA_and),    // both FS and vector extension
    ISA_VU     = (ISA_U|ISA_H),             // virtual user mode
    ISA_VS     = (ISA_S|ISA_H),             // virtual supervisor mode
    ISA_BK     = (ISA_B|ISA_K),             // either B or K extension
    ISA_VP     = (ISA_V|ISA_P),             // either V or P extension
    ISA_32     = ISA_XLEN_32,               // supported for XLEN=32
    ISA_64     = ISA_XLEN_64,               // supported for XLEN=64
    ISA_Sand32 = (ISA_S|ISA_32|ISA_and),    // 32-bit S mode
    ISA_Hand32 = (ISA_H|ISA_32|ISA_and),    // 32-bit H mode
    ISA_Uand32 = (ISA_U|ISA_32|ISA_and),    // 32-bit U mode

    // FEATURES THAT VARY DYNAMICALLY (note that D, F and V features can be
    // enabled or disabled by mstatus.FS or mstatus.VS, so are included here
    // even if the misa configuration bits are read-only)
    ISA_DYNAMIC = (ISA_DFV|ISA_FS|ISA_SPVP|ISA_VSBE|ISA_VUBE|ISA_HU|ISA_VVM|ISA_XL64),

    RV32     = ISA_XLEN_32,
    RV32I    = ISA_XLEN_32  | ISA_I,
    RV32M    = ISA_XLEN_32  |         ISA_M,
    RV32A    = ISA_XLEN_32  |                 ISA_A,
    RV32C    = ISA_XLEN_32  |                         ISA_C,
    RV32E    = ISA_XLEN_32  |                                 ISA_E,
    RV32EM   = ISA_XLEN_32  |         ISA_M |                 ISA_E,
    RV32F    = ISA_XLEN_32  |                                         ISA_F,
    RV32D    = ISA_XLEN_32  |                                                 ISA_D,
    RV32B    = ISA_XLEN_32  |                                                                         ISA_B,
    RV32BK   = ISA_XLEN_32  |                                                                         ISA_B |         ISA_K,
    RV32H    = ISA_XLEN_32  |                                                                                 ISA_H,
    RV32K    = ISA_XLEN_32  |                                                                                         ISA_K,
    RV32P    = ISA_XLEN_32  |                                                                                                 ISA_P,
    RV32IM   = ISA_XLEN_32  | ISA_I | ISA_M,
    RV32IMA  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A,
    RV32IMC  = ISA_XLEN_32  | ISA_I | ISA_M |         ISA_C,
    RV32IMAC = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C,
    RV32G    = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A |                 ISA_F | ISA_D,
    RV32GC   = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D,
    RV32GCB  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                 ISA_B,
    RV32GCH  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                         ISA_H,
    RV32GCK  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                                 ISA_K,
    RV32GCN  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D | ISA_N,
    RV32GCP  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                                         ISA_P,
    RV32GCV  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |         ISA_V,
    RV32EC   = ISA_XLEN_32  |                         ISA_C | ISA_E,

    RV32CF   = RV32F|RV32C|ISA_and,

    RV64     = ISA_XLEN_64,
    RV64I    = ISA_XLEN_64  | ISA_I,
    RV64M    = ISA_XLEN_64  |         ISA_M,
    RV64A    = ISA_XLEN_64  |                 ISA_A,
    RV64C    = ISA_XLEN_64  |                         ISA_C,
    RV64E    = ISA_XLEN_64  |                                 ISA_E,
    RV64F    = ISA_XLEN_64  |                                         ISA_F,
    RV64D    = ISA_XLEN_64  |                                                 ISA_D,
    RV64B    = ISA_XLEN_64  |                                                                         ISA_B,
    RV64BK   = ISA_XLEN_64  |                                                                         ISA_B |         ISA_K,
    RV64H    = ISA_XLEN_64  |                                                                                 ISA_H,
    RV64K    = ISA_XLEN_64  |                                                                                         ISA_K,
    RV64P    = ISA_XLEN_64  |                                                                                                 ISA_P,
    RV64IM   = ISA_XLEN_64  | ISA_I | ISA_M,
    RV64IMA  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A,
    RV64IMC  = ISA_XLEN_64  | ISA_I | ISA_M |         ISA_C,
    RV64IMAC = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C,
    RV64G    = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A |                 ISA_F | ISA_D,
    RV64GC   = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D,
    RV64GCB  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                 ISA_B,
    RV64GCH  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                         ISA_H,
    RV64GCK  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                                 ISA_K,
    RV64GCN  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D | ISA_N,
    RV64GCP  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                                         ISA_P,
    RV64GCV  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |         ISA_V,

    RVANY    = ISA_XLEN_ANY,
    RVANYI   = ISA_XLEN_ANY | ISA_I,
    RVANYM   = ISA_XLEN_ANY |         ISA_M,
    RVANYA   = ISA_XLEN_ANY |                 ISA_A,
    RVANYC   = ISA_XLEN_ANY |                         ISA_C,
    RVANYE   = ISA_XLEN_ANY |                                 ISA_E,
    RVANYF   = ISA_XLEN_ANY |                                         ISA_F,
    RVANYD   = ISA_XLEN_ANY |                                                 ISA_D,
    RVANYN   = ISA_XLEN_ANY |                                                         ISA_N,
    RVANYV   = ISA_XLEN_ANY |                                                                 ISA_V,
    RVANYB   = ISA_XLEN_ANY |                                                                         ISA_B,
    RVANYH   = ISA_XLEN_ANY |                                                                                 ISA_H,
    RVANYK   = ISA_XLEN_ANY |                                                                                         ISA_K,
    RVANYP   = ISA_XLEN_ANY |                                                                                                 ISA_P,

    RVANYCD  = RVANYC|RVANYD|ISA_and,
    RVANYCI  = RVANYC|RVANYI|ISA_and,
    RVANYCM  = RVANYC|RVANYM|ISA_and,
    RVANYVA  = RVANYV|RVANYA|ISA_and,
    RVANYBK  = RVANYB|RVANYK,

} riscvArchitecture;

// macro indicating if current XLEN is 32
#define RISCV_XLEN_IS_32(_CPU) ((_CPU)->currentArch & ISA_XLEN_32)

// macro indicating if current XLEN is 64
#define RISCV_XLEN_IS_64(_CPU) ((_CPU)->currentArch & ISA_XLEN_64)

// macro returning XLEN in bytes
#define RISCV_XLEN_BYTES(_CPU) (RISCV_XLEN_IS_32(_CPU) ? 4 : 8)

//
// Supported User Architecture versions
//
typedef enum riscvUserVerE {
    RVUV_2_2,                           // version 2.2
    RVUV_2_3,                           // version 2.3 (legacy naming)
    RVUV_20190305,                      // version 20190305
    RVUV_20191213,                      // version 20191213
    RVUV_DEFAULT = RVUV_20191213,       // default version
} riscvUserVer;

//
// Date and tag of Privileged Architecture master version
//
#define RVPV_MASTER_DATE    "10 January 2022"
#define RVPV_MASTER_TAG     "6bdeb58"

//
// Supported Privileged Architecture versions
//
typedef enum riscvPrivVerE {
    RVPV_1_10,                          // version 1.10
    RVPV_1_11,                          // version 1.11 (legacy naming)
    RVPV_20190405,                      // version 20190405
    RVPV_20190608,                      // version 20190608
    RVPV_20211203,                      // version 20211203 (identical to 1.12)
    RVPV_1_12,                          // version 1.12
    RVPV_MASTER,                        // master branch
    RVPV_DEFAULT = RVPV_1_12,           // default version
} riscvPrivVer;

//
// Date and tag of Vector Architecture master version
//
#define RVVV_MASTER_DATE    "22 December 2021"
#define RVVV_MASTER_TAG     "8cdce6c"

//
// Supported Vector Architecture versions
//
typedef enum riscvVectVerE {
    RVVV_0_7_1,                         // version 0.7.1-draft-20190605
    RVVV_0_7_1_P,                       // version 0.7.1 with some 0.8 features
    RVVV_0_8_20190906,                  // version 0.8-draft-20190906
    RVVV_0_8_20191004,                  // version 0.8-draft-20191004
    RVVV_0_8_20191117,                  // version 0.8-draft-20191117
    RVVV_0_8_20191118,                  // version 0.8-draft-20191118
    RVVV_0_8,                           // version 0.8
    RVVV_0_9,                           // version 0.9
    RVVV_1_0_20210130,                  // version 1.0-draft-20210130
    RVVV_1_0_20210608,                  // version 1.0-rc1-20210608
    RVVV_1_0,                           // version 1.0
    RVVV_MASTER,                        // master branch
    RVVV_LAST,                          // for sizing
    RVVV_DEFAULT = RVVV_1_0,            // default version
} riscvVectVer;

//
// Vector Architecture extension subsets
//
typedef enum riscvVectorSetE {

    // individual features
    RVVS_Application = 0,               // application processor profile
    RVVS_Embedded    = (1<<0),          // embedded processor profile
    RVVS_EEW64       = (1<<1),          // EEW=64 supported
    RVVS_H           = (1<<2),          // FP32 supported
    RVVS_F           = (1<<3),          // FP32 supported
    RVVS_D           = (1<<4),          // FP64 supported

    // embedded profiles
    RVVS_Zve32x = RVVS_Embedded,
    RVVS_Zve32f = RVVS_Embedded           |RVVS_F,
    RVVS_Zve64x = RVVS_Embedded|RVVS_EEW64,
    RVVS_Zve64f = RVVS_Embedded|RVVS_EEW64|RVVS_F,
    RVVS_Zve64d = RVVS_Embedded|RVVS_EEW64|RVVS_F|RVVS_D,

} riscvVectorSet;

//
// Date and tag of Bit Manipulation Architecture master version
//
#define RVBV_MASTER_DATE    "30 July 2021"
#define RVBV_MASTER_TAG     "1f56afe"

//
// Supported Bit Manipulation Architecture versions
//
typedef enum riscvBitManipVerE {
    RVBV_0_90,                          // version 0.90
    RVBV_0_91,                          // version 0.91
    RVBV_0_92,                          // version 0.92
    RVBV_0_93_DRAFT,                    // version 0.93 (intermediate draft)
    RVBV_0_93,                          // version 0.93
    RVBV_0_94,                          // version 0.94
    RVBV_1_0_0,                         // version 1.0.0
    RVBV_MASTER,                        // master branch
    RVBV_LAST,                          // for sizing
    RVBV_DEFAULT = RVBV_1_0_0,          // default version
} riscvBitManipVer;

//
// Bit Manipulation Architecture subsets
//
typedef enum riscvBitManipSetE {

    // INDIVIDUAL SETS
    RVBS_Zb_     = 0,                   // absent for all sets
    RVBS_Zba     = (1<<0),              // address calculation
    RVBS_Zbb     = (1<<1),              // base set
    RVBS_Zbc     = (1<<2),              // carryless operations
    RVBS_Zbe     = (1<<3),              // bit deposit/extract
    RVBS_Zbf     = (1<<4),              // bit field place
    RVBS_Zbm     = (1<<5),              // bit matrix operations
    RVBS_Zbp     = (1<<6),              // permutation instructions
    RVBS_Zbr     = (1<<7),              // CSR32 operations
    RVBS_Zbs     = (1<<8),              // single bit instructions
    RVBS_Zbt     = (1<<9),              // ternary instructions

    // COMPOSITE SETS
    RVBS_Zbbp    = RVBS_Zbb|RVBS_Zbp,
    RVBS_Zbmp    = RVBS_Zbm|RVBS_Zbp,
    RVBS_Zbefmp  = RVBS_Zbe|RVBS_Zbf|RVBS_Zbm|RVBS_Zbp,
    RVBS_Zbefp   = RVBS_Zbe|RVBS_Zbf|RVBS_Zbp,
    RVBS_Zbbefmp = RVBS_Zbb|RVBS_Zbe|RVBS_Zbf|RVBS_Zbm|RVBS_Zbp,
    RVBS_Zbbefp  = RVBS_Zbb|RVBS_Zbe|RVBS_Zbf|RVBS_Zbp,

    // VERSION 1.0.0 COMBINATION
    RVBS_1_0_0   = RVBS_Zba|RVBS_Zbb|RVBS_Zbc|RVBS_Zbs,

} riscvBitManipSet;

//
// Supported Zcea versions (legacy only)
//
typedef enum riscvZceaVerE {
    RVZCEA_NA,                          // Zcea absent
    RVZCEA_0_50_1,                      // Zcea 0.50.1
    RVZCEA_LAST,                        // for sizing
    RVZCEA_DEFAULT = RVZCEA_0_50_1,     // default version
} riscvZceaVer;

//
// Supported Zceb versions (legacy only)
//
typedef enum riscvZcebVerE {
    RVZCEB_NA,                          // Zceb absent
    RVZCEB_0_50_1,                      // Zceb 0.50.1
    RVZCEB_LAST,                        // for sizing
    RVZCEB_DEFAULT = RVZCEB_0_50_1,     // default version
} riscvZcebVer;

//
// Supported Zcee versions (legacy only)
//
typedef enum riscvZceeVerE {
    RVZCEE_NA,                          // Zcee absent
    RVZCEE_1_0_0_RC,                    // Zcee 1.0.0-rc
    RVZCEE_LAST,                        // for sizing
    RVZCEE_DEFAULT = RVZCEE_1_0_0_RC,   // default version
} riscvZceeVer;

//
// Supported Compressed Architecture versions
//
typedef enum riscvCompressVerE {
    RVCV_NA_LEGACY,                     // Zc absent or legacy (see above)
    RVCV_0_70_1,                        // Zc version 0.70.1
    RVCV_0_70_5,                        // Zc version 0.70.5
    RVCV_1_0_0_RC57,                    // Zc version 1.0.0-RC5.7
    RVCV_DEFAULT = RVCV_1_0_0_RC57,     // default version
} riscvCompressVer;

//
// Compressed extension subsets
//
typedef enum riscvCompressSetE {
    // legacy values
    RVCS_Zcea      = (1<<0),            // Zcea subset
    RVCS_Zceb      = (1<<1),            // Zceb subset
    RVCS_Zcee      = (1<<2),            // Zcee subset
    // new values
    RVCS_Zca       = (1<<3),            // Zca subset
    RVCS_Zcb       = (1<<4),            // Zcb subset
    RVCS_Zcd       = (1<<5),            // Zcd subset (implicit)
    RVCS_Zcf       = (1<<6),            // Zcf subset
    RVCS_Zcmb      = (1<<7),            // Zcmb subset
    RVCS_Zcmp      = (1<<8),            // Zcmp subset
    RVCS_Zcmpe     = (1<<9),            // Zcmpe subset
    RVCS_Zcmt      = (1<<10),           // Zcmt subset
    // composite values
    RVCS_ZceaZcb   = RVCS_Zcea|RVCS_Zcb,
    RVCS_ZcebZcmb  = RVCS_Zceb|RVCS_Zcmb,
    RVCS_ZceeZcb   = RVCS_Zcee|RVCS_Zcb,
    RVCS_ZcmpZcmpe = RVCS_Zcmp|RVCS_Zcmpe,
    RVCS_ZcNotD    = RVCS_Zcmb|RVCS_Zcmp|RVCS_Zcmpe|RVCS_Zcmt
} riscvCompressSet;

//
// Supported Cryptographic Architecture versions
//
typedef enum riscvCryptoVerE {
    RVKV_0_7_2,                         // version 0.7.2
    RVKV_0_8_1,                         // version 0.8.1
    RVKV_0_9_0,                         // version 0.9.0
    RVKV_0_9_2,                         // version 0.9.2
    RVKV_1_0_0_RC1,                     // version 1.0.0-rc1
    RVKV_1_0_0_RC5,                     // version 1.0.0-rc5
    RVKV_LAST,                          // for sizing
    RVKV_DEFAULT = RVKV_1_0_0_RC5,      // default version
} riscvCryptoVer;

//
// Cryptographic Architecture subsets
//
typedef enum riscvCryptoSetE {
    RVKS_Zk_   = 0,                     // absent for all sets
    RVKS_Zbkb  = (1<<0),                // bitmanip subset not in Zbkc or Zbkx
    RVKS_Zbkc  = (1<<1),                // bitmanip carry-less multiply
    RVKS_Zbkx  = (1<<2),                // bitmanip crossbar permutation
    RVKS_Zkr   = (1<<3),                // entropy source
    RVKS_Zknd  = (1<<4),                // NIST AES decryption instructions
    RVKS_Zkne  = (1<<5),                // NIST AES encryption instructions
    RVKS_Zknh  = (1<<6),                // NIST SHA2 hash function instructions
    RVKS_Zksed = (1<<7),                // SM4 instructions
    RVKS_Zksh  = (1<<8),                // SM3 hash function instructions
    RVKS_Zkb   = RVKS_Zbkb,             // (deprecated alias for Zbkb)
    RVKS_Zkg   = RVKS_Zbkc,             // (deprecated alias for Zbkc)
} riscvCryptoSet;

//
// Supported DSP instruction versions
//
typedef enum riscvDSPVerE {
    RVDSPV_0_5_2,                       // version 0.5.2
    RVDSPV_0_9_6,                       // version 0.9.6
    RVDSPV_LAST,                        // for sizing
    RVDSPV_DEFAULT = RVDSPV_0_5_2,      // default version
} riscvDSPVer;

//
// DSP Architecture subsets
//
typedef enum riscvDSPSetE {
    RVPS_Zp_         = 0,               // absent for all sets
    RVPS_Zpsfoperand = (1<<0),          // 64-bit operands using RV32 pairs
} riscvDSPSet;

//
// Supported Hypervisor Architecture versions
//
typedef enum riscvHypVerE {
    RVHV_0_6_1,                         // version 0.6.1
    RVHV_LAST,                          // for sizing
    RVHV_DEFAULT = RVHV_0_6_1,          // default version
} riscvHypVer;

//
// Supported debug version
//
typedef enum riscvDebugVerE {
    RVDBG_0_13_2,                       // 0.13.2-DRAFT
    RVDBG_0_14_0,                       // 0.14.0-DRAFT
    RVDBG_1_0_0,                        // 1.0.0-STABLE
    RVDBG_LAST,                         // for sizing
    RVDBG_DEFAULT = RVDBG_1_0_0,        // default version
} riscvDebugVer;

//
// Date and tag of master version
//
#define RVCLC_MASTER_DATE    "27 September 2022"
#define RVCLC_MASTER_TAG     "5301345"

//
// Supported CLIC version
//
typedef enum riscvCLICVerE {
    RVCLC_20180831,                     // 20180831
    RVCLC_0_9_20191208,                 // 0.9-draft-20191208
    RVCLC_0_9_20220315,                 // 0.9-draft-20220315
    RVCLC_MASTER,                       // master branch
    RVCLC_DEFAULT = RVCLC_0_9_20220315, // default version
} riscvCLICVer;

//
// Supported Zfinx versions
//
typedef enum riscvZfinxVerE {
    RVZFINX_NA,                         // Zfinx not implemented (default)
    RVZFINX_0_4,                        // Zfinx version 0.4
    RVZFINX_0_41,                       // Zfinx version 0.41
    RVZFINX_LAST,                       // for sizing
    RVZFINX_DEFAULT = RVZFINX_0_41,     // default version
} riscvZfinxVer;

//
// Supported 16-bit floating point version
//
typedef enum riscvFP16VerE {
    RVFP16_NA,                          // no 16-bit floating point (default)
    RVFP16_IEEE754,                     // IEEE 754 half precision
    RVFP16_BFLOAT16,                    // BFLOAT16
} riscvFP16Ver;

//
// Supported mstatus.FS update behavior
//
typedef enum riscvFSModeE {
    RVFS_WRITE_NZ,                      // dirty set if exception only (default)
    RVFS_WRITE_ANY,                     // any fflags write sets dirty
    RVFS_ALWAYS_DIRTY,                  // mstatus.FS is always off or dirty
    RVFS_FORCE_DIRTY,                   // mstatus.FS is always dirty
} riscvFSMode;

//
// Supported interrupt configuration
//
typedef enum riscvIntCfgE {
    RVCP_ORIG,                          // original (CLIC absent)
    RVCP_CLIC,                          // CLIC present
    RVCP_BOTH                           // both original and CLIC present
} riscvIntCfg;

//
// Supported Debug mode implementation options
//
typedef enum riscvDMModeE {
    RVDM_NONE,                          // Debug mode not implemented
    RVDM_VECTOR,                        // Debug mode causes execution at vector
    RVDM_INTERRUPT,                     // Debug mode implemented as interrupt
    RVDM_HALT,                          // Debug mode implemented as halt
} riscvDMMode;

//
// How MRET, SRET or URET is handled in Debug mode
//
typedef enum riscvDERETModeE {
    RVDRM_NOP,                          // treat as NOP
    RVDRM_JUMP,                         // jump to dexc_address
    RVDRM_TRAP,                         // trap to dexc_address
} riscvDERETMode;

//
// How debug event priorities are ordered
//
typedef enum riscvDPriorityE {
    RVDP_ORIG,                          // original priority ordering
    RVDP_693,                           // priority ordering as in PR #693
    RVDP_HALT_NOT_STEP,                 // haltreq preferred to step
} riscvDPriority;

//
// Supported RNMI versions
//
typedef enum riscvRNMIVerE {
    RNMI_NONE,                          // RNMI not implemented
    RNMI_0_2_1,                         // RNMI version 0.2.1
    RNMI_0_4,                           // RNMI version 0.4
} riscvRNMIVer;

//
// Supported Smepmp versions
//
typedef enum riscvSmepmpVerE {
    RVSP_NONE,                          // Smepmp not implemented
    RVSP_0_9_5,                         // version 0.9.5
    RVSP_1_0,                           // version 1.0
    RVSP_DEFAULT = RVSP_1_0,            // default version
} riscvSmepmpVer;

//
// Tags for memory accesses
//
typedef enum riscvMConstraint {
    RVMC_NONE,                          // unconstrained
    RVMC_USER1,                         // constrained with MEM_CONSTRAINT_USER1
    RVMC_USER2,                         // constrained with MEM_CONSTRAINT_USER2
} riscvMConstraint;

// macro returning User Architecture version
#define RISCV_USER_VERSION(_P)      ((_P)->configInfo.user_version)

// macro returning Privileged Architecture version
#define RISCV_PRIV_VERSION(_P)      ((_P)->configInfo.priv_version)

// macro returning Vector Architecture version
#define RISCV_VECT_VERSION(_P)      ((_P)->configInfo.vect_version)

// macro returning Compressed Architecture version
#define RISCV_COMPRESS_VERSION(_P)  ((_P)->configInfo.compress_version)

// macro returning Bit Manipulation Architecture version
#define RISCV_BITMANIP_VERSION(_P)  ((_P)->configInfo.bitmanip_version)

// macro returning Hypervisor Architecture version
#define RISCV_HYP_VERSION(_P)       ((_P)->configInfo.hyp_version)

// macro returning Cryptographic Architecture version
#define RISCV_CRYPTO_VERSION(_P)    ((_P)->configInfo.crypto_version)

// macro returning DSP Architecture version
#define RISCV_DSP_VERSION(_P)       ((_P)->configInfo.dsp_version)

// macro returning Debug Architecture version
#define RISCV_DBG_VERSION(_P)       ((_P)->configInfo.dbg_version)

// macro returning RNMI Architecture version
#define RISCV_RNMI_VERSION(_P)      ((_P)->configInfo.rnmi_version)

// macro returning CLIC version
#define RISCV_CLIC_VERSION(_P)      ((_P)->configInfo.CLIC_version)

// macro returning Zfinx version
#define RISCV_ZFINX_VERSION(_P)     ((_P)->configInfo.Zfinx_version)

// macro returning Zcea version
#define RISCV_ZCEA_VERSION(_P)      ((_P)->configInfo.Zcea_version)

// macro returning Zceb version
#define RISCV_ZCEB_VERSION(_P)      ((_P)->configInfo.Zceb_version)

// macro returning Zcee version
#define RISCV_ZCEE_VERSION(_P)      ((_P)->configInfo.Zcee_version)

// macro returning 16-bit floating point version
#define RISCV_FP16_VERSION(_P)      ((_P)->configInfo.fp16_version)

// macro returning Smepmp version
#define RISCV_SMEPMP_VERSION(_P)    ((_P)->configInfo.Smepmp_version)

// macro returning 16-bit floating point version
#define RISCV_FS_MODE(_P)           ((_P)->configInfo.mstatus_fs_mode)

//
// Supported version-dependent architectural features
//
typedef enum riscvVFeatureE {
    RVVF_W_SYNTAX,          // use .w syntax in disassembly (not .v)
    RVVF_ZERO_TAIL,         // is zeroing of tail elements required?
    RVVF_STRICT_OVERLAP,    // strict source/destination overlap?
    RVVF_SEXT_IOFFSET,      // sign-extend indexed load/store offset?
    RVVF_SEXT_VMV_X_S,      // sign-extend vmv.x.s and vmv.s.x?
    RVVF_SETVLZ_MAX,        // setvl* with rs1=zero: set vl to maximum
    RVVF_SETVLZ_PRESERVE,   // setvl* with rs1=zero: preserve vl
    RVVF_VAMO_SEW,          // use SEW AMO size (not 64-bit size)
    RVVF_ADC_SBC_MASK,      // vadc/vmadc/vsbc/vmsbc use standard mask bit
    RVVF_SEXT_SLIDE1_SRC,   // sign-extend slide1* ssource value?
    RVVF_FP_REQUIRES_FSNZ,  // VFP instructions require mstatus.FS!=0?
    RVVF_VLENB_PRESENT,     // is vlenb register present?
    RVVF_VCSR_PRESENT,      // is vcsr register present?
    RVVF_VS_STATUS_8,       // is [ms]status.VS field in version 0.8 location?
    RVVF_VS_STATUS_9,       // is [ms]status.VS field in version 0.9 location?
    RVVF_RESTRICT_VMVR,     // whole register move restricted?
    RVVF_RESTRICT_VLSR1,    // whole register load/store restricted to 1?
    RVVF_RESTRICT_VLSRP2,   // whole register load/store restricted to power of 2?
    RVVF_VMVR_VLSR_EEW,     // whole register instructions use encoded EEW?
    RVVF_FRACT_LMUL,        // is fractional LMUL implemented?
    RVVF_AGNOSTIC,          // are agnostic bits implemented?
    RVVF_MLEN1,             // is MLEN always 1?
    RVVF_EEW_OVERLAP,       // use relaxed EEW overlap rules?
    RVVF_EEW_SAME_SRC,      // one EEW per source register?
    RVVF_SLEN_IS_VLEN,      // is SLEN==VLEN?
    RVVF_ELEN_GT_VLEN,      // is ELEN>VLEN legal?
    RVVF_VLR_HINT,          // do VLR instructions encode hints?
    RVVF_VTYPE_10,          // is vtype in 1.0 format?
    RVVF_SETVLZ_ILLEGAL,    // setvl* preserving vl illegal if preserve fails
    RVVF_NO_VMSF_OVERLAP,   // no overlap with any source for vmfif/vmsbf/mvsof
    RVVF_VLM_VSM,           // use vlm/vsm syntax?
    RVVF_LAST,              // for sizing
} riscvVFeature;

//
// Get any configuration with the given variant name
//
riscvConfigCP riscvGetNamedConfig(riscvConfigCP list, const char *variant);

//
// Is the indicated feature supported?
//
Bool riscvVFSupport(riscvP riscv, riscvVFeature feature);
