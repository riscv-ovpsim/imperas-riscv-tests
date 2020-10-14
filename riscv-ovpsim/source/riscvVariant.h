/*
 * Copyright (c) 2005-2020 Imperas Software Ltd., www.imperas.com
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
#define RM_INVALID_CHAR         ('Z'+3)
#define MSTATUS_FS_CHAR         ('Z'+4)
#define MSTATUS_BE_CHAR         ('Z'+5)
#define HSTATUS_SPVP_CHAR       ('Z'+6)
#define HSTATUS_VSBE_CHAR       ('Z'+7)
#define VSSTATUS_UBE_CHAR       ('Z'+8)
#define HSTATUS_HU_CHAR         ('Z'+9)
#define VIRTUAL_VM_CHAR         ('Z'+10)
#define MXL64_CHAR              ('Z'+11)
#define SXL64_CHAR              ('Z'+12)
#define UXL64_CHAR              ('Z'+13)
#define VSXL64_CHAR             ('Z'+14)
#define VUXL64_CHAR             ('Z'+15)
#define TM_LA_CHAR              ('Z'+16)
#define TM_LV_CHAR              ('Z'+17)
#define TM_S_CHAR               ('Z'+18)
#define TM_X_CHAR               ('Z'+19)
#define RISCV_FAND_CHAR         ('Z'+20)
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
    ISA_XLEN_ANY = (ISA_XLEN_32|ISA_XLEN_64),

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
    ISA_S      = RISCV_FEATURE_BIT('S'),    // supervisor mode implemented
    ISA_U      = RISCV_FEATURE_BIT('U'),    // user mode implemented
    ISA_V      = RISCV_FEATURE_BIT('V'),    // vector extension implemented
    ISA_X      = RISCV_FEATURE_BIT('X'),    // non-standard extensions present
    ISA_DF     = (ISA_D|ISA_F),             // either single or double precision
    ISA_DFV    = (ISA_D|ISA_F|ISA_V),       // either floating point or vector
    ISA_SorN   = (ISA_S|ISA_N),             // either supervisor or user interrupts
    ISA_SandN  = (ISA_S|ISA_N|ISA_and),     // both supervisor and user interrupts
    ISA_FSandV = (ISA_FS|ISA_V|ISA_and),    // both FS and vector extension
    ISA_VU     = (ISA_U|ISA_H),             // virtual user mode
    ISA_VS     = (ISA_S|ISA_H),             // virtual supervisor mode

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
    RV32F    = ISA_XLEN_32  |                                         ISA_F,
    RV32D    = ISA_XLEN_32  |                                                 ISA_D,
    RV32B    = ISA_XLEN_32  |                                                                         ISA_B,
    RV32H    = ISA_XLEN_32  |                                                                                 ISA_H,
    RV32K    = ISA_XLEN_32  |                                                                                         ISA_K,
    RV32IM   = ISA_XLEN_32  | ISA_I | ISA_M,
    RV32IMA  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A,
    RV32IMC  = ISA_XLEN_32  | ISA_I | ISA_M |         ISA_C,
    RV32IMAC = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C,
    RV32G    = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A |                 ISA_F | ISA_D,
    RV32GC   = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D,
    RV32GCB  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                 ISA_B,
    RV32GCH  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                         ISA_H,
    RV32GCN  = ISA_XLEN_32  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D | ISA_N,
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
    RV64H    = ISA_XLEN_64  |                                                                                 ISA_H,
    RV64K    = ISA_XLEN_64  |                                                                                         ISA_K,
    RV64IM   = ISA_XLEN_64  | ISA_I | ISA_M,
    RV64IMA  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A,
    RV64IMC  = ISA_XLEN_64  | ISA_I | ISA_M |         ISA_C,
    RV64IMAC = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C,
    RV64G    = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A |                 ISA_F | ISA_D,
    RV64GC   = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D,
    RV64GCB  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                 ISA_B,
    RV64GCH  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D |                         ISA_H,
    RV64GCN  = ISA_XLEN_64  | ISA_I | ISA_M | ISA_A | ISA_C |         ISA_F | ISA_D | ISA_N,
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

    RVANYCD  = RVANYC|RVANYD|ISA_and,
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
    RVUV_DEFAULT = RVUV_20190305,       // default version
} riscvUserVer;

//
// Supported Privileged Architecture versions
//
typedef enum riscvPrivVerE {
    RVPV_1_10,                          // version 1.10
    RVPV_1_11,                          // version 1.11 (legacy naming)
    RVPV_20190405,                      // version 20190405
    RVPV_1_12,                          // version 1.12 (placeholder)
    RVPV_MASTER  = RVPV_1_12,           // master branch
    RVPV_DEFAULT = RVPV_20190405,       // default version
} riscvPrivVer;

//
// Date and tag of master version
//
#define RVVV_MASTER_DATE    "22 July 2020"
#define RVVV_MASTER_TAG     "b8cd98b"

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
    RVVV_MASTER,                        // master branch
    RVVV_LAST,                          // for sizing
    RVVV_DEFAULT = RVVV_0_9,            // default version
} riscvVectVer;

//
// Supported Bit Manipulation Architecture versions
//
typedef enum riscvBitManipVerE {
    RVBV_0_90,                          // version 0.90
    RVBV_0_91,                          // version 0.91
    RVBV_0_92,                          // version 0.92
    RVBV_0_93,                          // version 0.93
    RVBV_LAST,                          // for sizing
    RVBV_DEFAULT = RVBV_0_92,           // default version
} riscvBitManipVer;

//
// Bit Manipulation Architecture subsets
//
typedef enum riscvBitManipSetE {
    RVBS_Zba  = (1<<0),                 // address calculation
    RVBS_Zbb  = (1<<1),                 // base set
    RVBS_Zbc  = (1<<2),                 // carryless operations
    RVBS_Zbe  = (1<<3),                 // bit deposit/extract
    RVBS_Zbf  = (1<<4),                 // bit field place
    RVBS_Zbm  = (1<<5),                 // bit matrix operations
    RVBS_Zbp  = (1<<6),                 // permutation instructions
    RVBS_Zbr  = (1<<7),                 // CSR32 operations
    RVBS_Zbs  = (1<<8),                 // single bit instructions
    RVBS_Zbt  = (1<<9),                 // ternary instructions
    RVBS_Zbbp = RVBS_Zbb|RVBS_Zbp,      // base or permutation
} riscvBitManipSet;

//
// Supported Cryptographic Architecture versions
//
typedef enum riscvCryptoVerE {
    RVKV_0_5_0,                         // version 0.5.0
    RVKV_LAST,                          // for sizing
    RVKV_DEFAULT = RVKV_0_5_0,          // default version
} riscvCryptoVer;

//
// Cryptographic Architecture subsets
//
typedef enum riscvCryptoSetE {
    RVKS_S1   = (1<<0),                     // scalar profile #1
    RVKS_S2   = (1<<1),                     // scalar profile #2
    RVKS_S3   = (1<<2),                     // scalar profile #3
    RVKS_V1   = (1<<3),                     // vector profile #1
    RVKS_V2   = (1<<4),                     // vector profile #2
    RVKS_V3   = (1<<5),                     // vector profile #3
    RVKS_S13  = RVKS_S1|RVKS_S3,            // scalar profiles #1 and #3
    RVKS_S23  = RVKS_S2|RVKS_S3,            // scalar profiles #2 and #3
    RVKS_S123 = RVKS_S1|RVKS_S2|RVKS_S3,    // all scalar profiles
    RVKS_V13  = RVKS_V1|RVKS_V3,            // vector profiles #1 and #3
    RVKS_V23  = RVKS_V2|RVKS_V3,            // vector profiles #2 and #3
    RVKS_V123 = RVKS_V1|RVKS_V2|RVKS_V3,    // all vector profiles
    RVKS_ALL  = RVKS_S123|RVKS_V123,        // all profiles
} riscvCryptoSet;

//
// Supported Hypervisor Architecture versions
//
typedef enum riscvHypVerE {
    RVHV_0_6_1,                         // version 0.93
    RVHV_LAST,                          // for sizing
    RVHV_DEFAULT = RVHV_0_6_1,          // default version
} riscvHypVer;

//
// Supported debug version
//
typedef enum riscvDebugVerE {
    RVDBG_0_13_2,                       // 0.13.2-DRAFT
    RVDBG_0_14_0,                       // 0.14.0-DRAFT
    RVDBG_DEFAULT = RVDBG_0_14_0,       // default version
} riscvDebugVer;

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
} riscvFSMode;

//
// Supported interrupt configuration
//
typedef enum riscvIntCfgE {
    RVCP_ORIG,                          // original (CLIC absent)
    RVCP_CLIC,                          // CLIC present
    RVCP_BOTH                           // both originl and CLIC present
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

// macro returning User Architecture version
#define RISCV_USER_VERSION(_P)      ((_P)->configInfo.user_version)

// macro returning Privileged Architecture version
#define RISCV_PRIV_VERSION(_P)      ((_P)->configInfo.priv_version)

// macro returning Vector Architecture version
#define RISCV_VECT_VERSION(_P)      ((_P)->configInfo.vect_version)

// macro returning Bit Manipulation Architecture version
#define RISCV_BITMANIP_VERSION(_P)  ((_P)->configInfo.bitmanip_version)

// macro returning Hypervisor Architecture version
#define RISCV_HYP_VERSION(_P)       ((_P)->configInfo.hyp_version)

// macro returning Debug Architecture version
#define RISCV_DBG_VERSION(_P)       ((_P)->configInfo.dbg_version)

// macro returning 16-bit floating point version
#define RISCV_FP16_VERSION(_P)      ((_P)->configInfo.fp16_version)

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
    RVVF_FP_RESTRICT_WHOLE, // whole register load/store/move restricted?
    RVVF_FRACT_LMUL,        // is fractional LMUL implemented?
    RVVF_AGNOSTIC,          // are agnostic bits implemented?
    RVVF_MLEN1,             // is MLEN always 1?
    RVVF_EEW_OVERLAP,       // use relaxed EEW overlap rules?
    RVVF_SLEN_IS_VLEN,      // is SLEN==VLEN?
    RVVF_ELEN_GT_VLEN,      // is ELEN>VLEN legal?
    RVVF_VLR_HINT,          // do VLR instructions encode hints?
    RVVF_VTYPE_10,          // is vtype in 1.0 format?
    RVVF_LAST,              // for sizing
} riscvVFeature;

//
// Is the indicated feature supported?
//
Bool riscvVFSupport(riscvP riscv, riscvVFeature feature);
