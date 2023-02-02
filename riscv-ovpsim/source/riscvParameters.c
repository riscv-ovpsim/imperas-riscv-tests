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

// standard header files
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <string.h>
#include <stdio.h>

// Imperas header files
#include "hostapi/impAlloc.h"

// VMI header files
#include "vmi/vmiAttrs.h"
#include "vmi/vmiParameters.h"
#include "vmi/vmiMessage.h"

// model header files
#include "riscvCluster.h"
#include "riscvCSR.h"
#include "riscvFunctions.h"
#include "riscvMessage.h"
#include "riscvParameters.h"
#include "riscvStructure.h"
#include "riscvUtils.h"
#include "riscvVariant.h"
#include "riscvVMConstants.h"


//
// Restrictions on parameters
//
typedef enum riscvParamVariantE {

    RVPV_ALL       = 0,             // present for all variants

                                    // PARAMETER IDENTIFIERS
    RVPV_PRE       = (1ULL<<0),     // identifies pre-parameter
    RVPV_VARIANT   = (1ULL<<1),     // identifies variant parameter
    RVPV_FP        = (1ULL<<2),     // requires floating point unit
    RVPV_C         = (1ULL<<3),     // requires compressed extension
    RVPV_D         = (1ULL<<4),     // requires double floating point unit
    RVPV_A         = (1ULL<<5),     // requires atomic instructions
    RVPV_K         = (1ULL<<6),     // requires crypto extension
    RVPV_BK        = (1ULL<<7),     // requires bitmanip or crypto extension
    RVPV_32        = (1ULL<<8),     // present if XLEN=32
    RVPV_64        = (1ULL<<9),     // present if XLEN=64
    RVPV_S         = (1ULL<<10),    // requires Supervisor mode
    RVPV_SnotFP    = (1ULL<<11),    // requires Supervisor mode and no floating point
    RVPV_U         = (1ULL<<12),    // requires Supervisor mode
    RVPV_H         = (1ULL<<13),    // requires Hypervisor mode
    RVPV_N         = (1ULL<<14),    // requires User mode interrupts
    RVPV_M         = (1ULL<<15),    // requires M extension
    RVPV_V         = (1ULL<<16),    // requires Vector extension
    RVPV_P         = (1ULL<<17),    // requires DSP extension
    RVPV_MPCORE    = (1ULL<<18),    // present for multicore variants
    RVPV_NMBITS    = (1ULL<<19),    // present if CLICCFGMBITS can be > 0
    RVPV_DEBUG     = (1ULL<<20),    // present if debug mode implemented
    RVPV_TRIG      = (1ULL<<21),    // present if triggers implemented
    RVPV_DBGT      = (1ULL<<22),    // present if debug mode or triggers implemented
    RVPV_RNMI      = (1ULL<<23),    // present if RNMI implemented
    RVPV_CLIC      = (1ULL<<24),    // present if CLIC enabled
    RVPV_CLUSTER   = (1ULL<<25),    // present if a cluster
    RVPV_ROOTINT   = (1ULL<<26),    // present at root level only
    RVPV_CMOMP     = (1ULL<<27),    // present if Zicbom/Zicbop implemented
    RVPV_CMOZ      = (1ULL<<28),    // present if Zicboz implemented
    RVPV_PMPINIT   = (1ULL<<29),    // present if PMP_initialparams is true
    RVPV_PMPMASK   = (1ULL<<30),    // present if PMP_romaskparams is true
    RVPV_CLEG      = (1ULL<<31),    // present if legacy C extension
    RVPV_CNEW      = (1ULL<<32),    // present if new C extension
    RVPV_CV07      = (1ULL<<33),    // present if C extension 0.70.x
    RVPV_WFI       = (1ULL<<34),    // requires true WFI (not NOP)
    RVPV_SMAIA     = (1ULL<<35),    // requires Smaia extension
    RVPV_ZAWRS     = (1ULL<<36),    // requires Zarws extension
    RVPV_TIMER     = (1ULL<<37),    // requires built-in timer

                                    // COMPOSITE PARAMETER IDENTIFIERS
    RVPV_ROOT      = RVPV_ROOTINT|RVPV_CLIC,
    RVPV_ROOTPRE   = RVPV_ROOTINT|RVPV_PRE,
    RVPV_CLIC_NM   = RVPV_CLIC|RVPV_NMBITS,
    RVPV_CLIC_S    = RVPV_CLIC|RVPV_S,
    RVPV_CLIC_N    = RVPV_CLIC|RVPV_N,
    RVPV_KV        = RVPV_K|RVPV_V,
    RVPV_FV        = RVPV_FP|RVPV_V,
    RVPV_64A       = RVPV_64|RVPV_A,
    RVPV_64S       = RVPV_64|RVPV_S,
    RVPV_64U       = RVPV_64|RVPV_U,
    RVPV_64H       = RVPV_64|RVPV_H,
    RVPV_TRIG_S    = RVPV_TRIG|RVPV_S,
    RVPV_TRIG_H    = RVPV_TRIG|RVPV_H,
    RVPV_32P       = RVPV_32|RVPV_P,
    RVPV_PMPINIT32 = RVPV_32|RVPV_PMPINIT,
    RVPV_PMPMASK32 = RVPV_32|RVPV_PMPMASK,
    RVPV_C_CLEG    = RVPV_C|RVPV_CLEG,
    RVPV_C_CNEW    = RVPV_C|RVPV_CNEW,
    RVPV_C_CCV07   = RVPV_C_CNEW|RVPV_CV07,
    RVPV_SMAIA_S   = RVPV_SMAIA|RVPV_S,
    RVPV_SMAIA_H   = RVPV_SMAIA|RVPV_H,

} riscvParamVariant;

//
// Supported Privileged Architecture variants
//
static vmiEnumParameter privVariants[] = {
    {
        .name        = "1.10",
        .value       = RVPV_1_10,
        .description = "Privileged Architecture Version 1.10",
    },
    {
        .name        = "1.11",
        .value       = RVPV_20190608,
        .description = "Privileged Architecture Version 1.11, equivalent to 20190608",
    },
    {
        .name        = "20190405",
        .value       = RVPV_20190608,
        .description = "Deprecated and equivalent to 20190608",
    },
    {
        .name        = "20190608",
        .value       = RVPV_20190608,
        .description = "Privileged Architecture Version Ratified-IMFDQC-and-Priv-v1.11",
    },
    {
        .name        = "20211203",
        .value       = RVPV_1_12,
        .description = "Privileged Architecture Version 20211203",
    },
    {
        .name        = "1.12",
        .value       = RVPV_1_12,
        .description = "Privileged Architecture Version 1.12, equivalent to 20211203",
    },
    {
        .name        = "master",
        .value       = RVPV_MASTER,
        .description = "Privileged Architecture Master Branch as of commit "
                       RVPV_MASTER_TAG" (this is subject to change)",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported User Architecture variants
//
static vmiEnumParameter userVariants[] = {
    {
        .name        = "2.2",
        .value       = RVUV_2_2,
        .description = "User Architecture Version 2.2",
    },
    {
        .name        = "2.3",
        .value       = RVUV_20191213,
        .description = "Deprecated and equivalent to 20191213",
    },
    {
        .name        = "20190305",
        .value       = RVUV_20191213,
        .description = "Deprecated and equivalent to 20191213",
    },
    {
        .name        = "20191213",
        .value       = RVUV_20191213,
        .description = "User Architecture Version 20191213",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Vector Architecture variants
//
static vmiEnumParameter vectorVariants[] = {
    {
        .name        = "0.7.1-draft-20190605",
        .value       = RVVV_0_7_1,
        .description = "Vector Architecture Version 0.7.1-draft-20190605",
    },
    {
        .name        = "0.7.1-draft-20190605+",
        .value       = RVVV_0_7_1_P,
        .description = "Vector Architecture Version 0.7.1-draft-20190605 "
                       "with custom features (not for general use)",
    },
    {
        .name        = "0.8-draft-20190906",
        .value       = RVVV_0_8_20190906,
        .description = "Vector Architecture Version 0.8-draft-20190906",
    },
    {
        .name        = "0.8-draft-20191004",
        .value       = RVVV_0_8_20191004,
        .description = "Vector Architecture Version 0.8-draft-20191004",
    },
    {
        .name        = "0.8-draft-20191117",
        .value       = RVVV_0_8_20191117,
        .description = "Vector Architecture Version 0.8-draft-20191117",
    },
    {
        .name        = "0.8-draft-20191118",
        .value       = RVVV_0_8_20191118,
        .description = "Vector Architecture Version 0.8-draft-20191118",
    },
    {
        .name        = "0.8",
        .value       = RVVV_0_8,
        .description = "Vector Architecture Version 0.8",
    },
    {
        .name        = "0.9",
        .value       = RVVV_0_9,
        .description = "Vector Architecture Version 0.9",
    },
    {
        .name        = "1.0-draft-20210130",
        .value       = RVVV_1_0_20210130,
        .description = "Vector Architecture Version 1.0-draft-20210130",
    },
    {
        .name        = "1.0-rc1-20210608",
        .value       = RVVV_1_0_20210608,
        .description = "Vector Architecture Version 1.0-rc1-20210608",
    },
    {
        .name        = "1.0",
        .value       = RVVV_1_0,
        .description = "Vector Architecture Version 1.0 (frozen for public review)",
    },
    {
        .name        = "master",
        .value       = RVVV_MASTER,
        .description = "Vector Architecture Master Branch as of commit "
                       RVVV_MASTER_TAG" (this is subject to change)",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Compressed Architecture variants
//
static vmiEnumParameter compressedVariants[] = {
    {
        .name        = "legacy",
        .value       = RVCV_NA_LEGACY,
        .description = "Compressed Architecture absent or legacy version",
    },
    {
        .name        = "0.70.1",
        .value       = RVCV_0_70_1,
        .description = "Compressed Architecture Version 0.70.1",
    },
    {
        .name        = "0.70.5",
        .value       = RVCV_0_70_5,
        .description = "Compressed Architecture Version 0.70.5",
    },
    {
        .name        = "1.0.0-RC5.7",
        .value       = RVCV_1_0_0_RC57,
        .description = "Compressed Architecture Version 1.0.0-RC5.7",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Bit Manipulation Architecture variants
//
static vmiEnumParameter bitmanipVariants[] = {
    {
        .name        = "0.90",
        .value       = RVBV_0_90,
        .description = "Bit Manipulation Architecture Version v0.90-20190610",
    },
    {
        .name        = "0.91",
        .value       = RVBV_0_91,
        .description = "Bit Manipulation Architecture Version v0.91-20190829",
    },
    {
        .name        = "0.92",
        .value       = RVBV_0_92,
        .description = "Bit Manipulation Architecture Version v0.92-20191108",
    },
    {
        .name        = "0.93-draft",
        .value       = RVBV_0_93_DRAFT,
        .description = "Bit Manipulation Architecture Version 0.93-draft-20200129",
    },
    {
        .name        = "0.93",
        .value       = RVBV_0_93,
        .description = "Bit Manipulation Architecture Version v0.93-20210110",
    },
    {
        .name        = "0.94",
        .value       = RVBV_0_94,
        .description = "Bit Manipulation Architecture Version v0.94-20210120",
    },
    {
        .name        = "1.0.0",
        .value       = RVBV_1_0_0,
        .description = "Bit Manipulation Architecture Version 1.0.0",
    },
    {
        .name        = "master",
        .value       = RVBV_MASTER,
        .description = "Bit Manipulation Master Branch as of commit "
                       RVBV_MASTER_TAG" (this is subject to change)",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Hypervisor Architecture variants
//
static vmiEnumParameter hypervisorVariants[] = {
    {
        .name        = "0.6.1",
        .value       = RVHV_0_6_1,
        .description = "Hypervisor Architecture Version 0.6.1",
    },
    {
        .name        = "1.0",
        .value       = RVHV_1_0,
        .description = "Hypervisor Architecture Version 1.0",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Cryptographic Architecture variants
//
static vmiEnumParameter cryptoVariants[] = {
    {
        .name        = "0.7.2",
        .value       = RVKV_0_7_2,
        .description = "Cryptographic Architecture Version 0.7.2",
    },
    {
        .name        = "0.8.1",
        .value       = RVKV_0_8_1,
        .description = "Cryptographic Architecture Version 0.8.1",
    },
    {
        .name        = "0.9.0",
        .value       = RVKV_0_9_0,
        .description = "Cryptographic Architecture Version 0.9.0",
    },
    {
        .name        = "0.9.2",
        .value       = RVKV_0_9_2,
        .description = "Cryptographic Architecture Version 0.9.2",
    },
    {
        .name        = "1.0.0-rc1",
        .value       = RVKV_1_0_0_RC1,
        .description = "Cryptographic Architecture Version 1.0.0-rc1",
    },
    {
        .name        = "1.0.0-rc5",
        .value       = RVKV_1_0_0_RC5,
        .description = "Cryptographic Architecture Version 1.0.0-rc5",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Vector Cryptographic Architecture variants
//
static vmiEnumParameter vcryptoVariants[] = {
    {
        .name        = "master",
        .value       = RVKVV_MASTER,
        .description = "Vector Cryptographic Architecture Master Branch as of commit "
                       RVKVV_MASTER_TAG" (this is subject to change)",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported DSP Architecture variants
//
static vmiEnumParameter DSPVariants[] = {
    {
        .name        = "0.5.2",
        .value       = RVDSPV_0_5_2,
        .description = "DSP Architecture Version 0.5.2",
    },
    {
        .name        = "0.9.6",
        .value       = RVDSPV_0_9_6,
        .description = "DSP Architecture Version 0.9.6",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported debug mode variants
//
static vmiEnumParameter debugVariants[] = {
    {
        .name        = "0.13.2-DRAFT",
        .value       = RVDBG_0_13_2,
        .description = "RISC-V External Debug Support Version 0.13.2-DRAFT",
    },
    {
        .name        = "0.14.0-DRAFT",
        .value       = RVDBG_0_14_0,
        .description = "RISC-V External Debug Support Version 0.14.0-DRAFT",
    },
    {
        .name        = "1.0.0-STABLE",
        .value       = RVDBG_1_0_0,
        .description = "RISC-V External Debug Support Version 1.0.0-STABLE",
    },
    {
        .name        = "1.0-STABLE",
        .value       = RVDBG_1_0,
        .description = "RISC-V External Debug Support Version 1.0-STABLE",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported RNMI variants
//
static vmiEnumParameter rnmiVariants[] = {
    {
        .name        = "none",
        .value       = RNMI_NONE,
        .description = "RNMI not implemented",
    },
    {
        .name        = "0.2.1",
        .value       = RNMI_0_2_1,
        .description = "RNMI version 0.2.1",
    },
    {
        .name        = "0.4",
        .value       = RNMI_0_4,
        .description = "RNMI version 0.4",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported CLIC variants
//
static vmiEnumParameter CLICVariants[] = {
    {
        .name        = "20180831",
        .value       = RVCLC_20180831,
        .description = "CLIC Version 20180831",
    },
    {
        .name        = "0.9-draft-20191208",
        .value       = RVCLC_0_9_20191208,
        .description = "CLIC Version 0.9-draft-20191208",
    },
    {
        .name        = "0.9-draft-20220315",
        .value       = RVCLC_0_9_20220315,
        .description = "CLIC Version 0.9-draft-20220315",
    },
    {
        .name        = "master",
        .value       = RVCLC_MASTER,
        .description = "CLIC Master Branch as of commit "
                       RVCLC_MASTER_TAG" (this is subject to change)",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported AIA variants
//
static vmiEnumParameter AIAVariants[] = {
    {
        .name        = "1.0-RC1",
        .value       = RVAIA_1_0_RC1,
        .description = "AIA Version 1.0-RC1",
    },
    {
        .name        = "master",
        .value       = RVAIA_MASTER,
        .description = "AIA Master Branch as of commit "
                       RVAIA_MASTER_TAG" (this is subject to change)",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Xfinx variants
//
static vmiEnumParameter ZfinxVariants[] = {
    {
        .name        = "none",
        .value       = RVZFINX_NA,
        .description = "Zfinx not implemented",
    },
    {
        .name        = "0.4",
        .value       = RVZFINX_0_4,
        .description = "Zfinx version 0.4",
    },
    {
        .name        = "0.41",
        .value       = RVZFINX_0_41,
        .description = "Zfinx version 0.41",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Zcea variants
//
static vmiEnumParameter ZceaVariants[] = {
    {
        .name        = "none",
        .value       = RVZCEA_NA,
        .description = "Zcea not implemented",
    },
    {
        .name        = "0.50.1",
        .value       = RVZCEA_0_50_1,
        .description = "Zcea version 0.50.1",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Zceb variants
//
static vmiEnumParameter ZcebVariants[] = {
    {
        .name        = "none",
        .value       = RVZCEB_NA,
        .description = "Zceb not implemented",
    },
    {
        .name        = "0.50.1",
        .value       = RVZCEB_0_50_1,
        .description = "Zceb version 0.50.1",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Zcee variants
//
static vmiEnumParameter ZceeVariants[] = {
    {
        .name        = "none",
        .value       = RVZCEE_NA,
        .description = "Zcee not implemented",
    },
    {
        .name        = "1.0.0-rc",
        .value       = RVZCEE_1_0_0_RC,
        .description = "Zcee version 1.0.0-rc",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported 16-bit floating point variants
//
static vmiEnumParameter fp16Variants[] = {
    {
        .name        = "none",
        .value       = RVFP16_NA,
        .description = "No 16-bit floating point implemented",
    },
    {
        .name        = "IEEE754",
        .value       = RVFP16_IEEE754,
        .description = "IEEE 754 half precision implemented",
    },
    {
        .name        = "BFLOAT16",
        .value       = RVFP16_BFLOAT16,
        .description = "BFLOAT16 implemented",
    },
    {
        .name        = "dynamic",
        .value       = RVFP16_DYNAMIC,
        .description = "Dynamic 16-bit floating point implemented",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Specify effect of flag writes on FS
//
static vmiEnumParameter FSModes[] = {
    {
        .name        = "write_1",
        .value       = RVFS_WRITE_NZ,
        .description = "Any non-zero flag result sets mstatus.fs dirty",
    },
    {
        .name        = "write_any",
        .value       = RVFS_WRITE_ANY,
        .description = "Any write of flags sets mstatus.fs dirty",
    },
    {
        .name        = "always_dirty",
        .value       = RVFS_ALWAYS_DIRTY,
        .description = "mstatus.fs is either off or dirty",
    },
    {
        .name        = "force_dirty",
        .value       = RVFS_FORCE_DIRTY,
        .description = "mstatus.fs is forced to dirty",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Specify Debug mode operation
//
static vmiEnumParameter DMModes[] = {
    {
        .name        = "none",
        .value       = RVDM_NONE,
        .description = "Debug mode not implemented",
    },
    {
        .name        = "vector",
        .value       = RVDM_VECTOR,
        .description = "Debug mode implemented by execution at vector",
    },
    {
        .name        = "interrupt",
        .value       = RVDM_INTERRUPT,
        .description = "Debug mode implemented by interrupt",
    },
    {
        .name        = "halt",
        .value       = RVDM_HALT,
        .description = "Debug mode implemented by halt",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Specify behavior of MRET, SRET or URET in Debug mode
//
static vmiEnumParameter DERETModes[] = {
    {
        .name        = "nop",
        .value       = RVDRM_NOP,
        .description = "MRET, SRET or URET in Debug mode is a nop",
    },
    {
        .name        = "jump_to_dexc_address",
        .value       = RVDRM_JUMP,
        .description = "MRET, SRET or URET in Debug mode jumps to dexc_address",
    },
    {
        .name        = "trap_to_dexc_address",
        .value       = RVDRM_TRAP,
        .description = "MRET, SRET or URET in Debug mode traps to dexc_address",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Specify relative priorities of simultaneous debug events
//
static vmiEnumParameter DebugPriorities[] = {
    {
        .name        = "asxh",
        .value       = RVDP_A_S_X_H,
        .description = "after trigger -> step -> execute address -> haltreq",
    },
    {
        .name        = "ashx",
        .value       = RVDP_A_S_H_X,
        .description = "after trigger -> step -> haltreq -> execute address",
    },
    {
        .name        = "ahsx",
        .value       = RVDP_A_H_S_X,
        .description = "after trigger -> haltreq -> step -> execute address",
    },
    {
        .name        = "hasx",
        .value       = RVDP_H_A_S_X,
        .description = "haltreq -> after trigger -> step -> execute address",
    },
    {
        .name        = "original",
        .value       = RVDP_ORIG,
        .description = "legacy alias of asxh",
    },
    {
        .name        = "PR693",
        .value       = RVDP_693,
        .description = "legacy alias of ashx",
    },
    {
        .name        = "halt_not_step",
        .value       = RVDP_HALT_NOT_STEP,
        .description = "legacy alias of ahsx",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Supported Smepmp variants
//
static vmiEnumParameter SmepmpVariants[] = {
    {
        .name        = "none",
        .value       = RVSP_NONE,
        .description = "Smepmp not implemented",
    },
    {
        .name        = "0.9.5",
        .value       = RVSP_0_9_5,
        .description = "Smepmp version 0.9.5 (deprecated and identical to 1.0)",
    },
    {
        .name        = "1.0",
        .value       = RVSP_1_0,
        .description = "Smepmp version 1.0",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Memory constraints
//
static vmiEnumParameter memoryConstraints[] = {
    {
        .name        = "none",
        .value       = RVMC_NONE,
        .description = "Memory access not constrained",
    },
    {
        .name        = "user1",
        .value       = RVMC_USER1,
        .description = "Memory access constrained by MEM_CONSTRAINT_USER1",
    },
    {
        .name        = "user2",
        .value       = RVMC_USER2,
        .description = "Memory access constrained by MEM_CONSTRAINT_USER2",
    },
    // KEEP LAST: terminator
    {0}
};

//
// Return the maximum number of bits that can be specified for CLICCFGMBITS
//
static Uns32 getCLICCFGMBITSMax(riscvConfigCP cfg) {
    riscvArchitecture arch = cfg->arch ? : -1;
    return (arch&ISA_S) ? 2 : (arch&ISA_N) ? 1 : 0;
}

//
// Return the maximum number of bits that can be specified for CLICCFGLBITS,
// ceil(lg2(CLICLEVELS))
//
static Uns32 getCLICCFGLBITSMax(riscvConfigCP cfg) {

    Uns32 max = 0;
    Uns32 try = 1;

    while(try<cfg->CLICLEVELS) {
        try *= 2;
        max++;
    }

    return max;
}

//
// This function type is used to specify the default value for a parameter
//
#define RISCV_PDEFAULT_FN(_NAME) void _NAME(riscvConfigCP cfg, vmiParameterP param)
typedef RISCV_PDEFAULT_FN((*riscvPDefaultFn));

//
// Parameter list including variant information
//
typedef struct riscvParameterS {
    riscvParamVariant variant;
    riscvPrivVer      minPV;
    riscvPDefaultFn   defaultCB;
    vmiParameter      parameter;
} riscvParameter, *riscvParameterP;

//
// Validate parameter type
//
#define CHECK_PARAM_TYPE(_P, _T, _NAME) VMI_ASSERT( \
    _P->type==_T,                                   \
    "parameter %s is not of "_NAME" type",          \
    _P->name                                        \
)

//
// Set enum parameter default
//
static void setEnumParamDefault(vmiParameterP param, Uns32 value) {
    CHECK_PARAM_TYPE(param, vmi_PT_ENUM, "Enum");
    param->u.enumParam.defaultValue = &param->u.enumParam.legalValues[value];
}

//
// Set Bool parameter default
//
static void setBoolParamDefault(vmiParameterP param, Bool value) {
    CHECK_PARAM_TYPE(param, vmi_PT_BOOL, "Bool");
    param->u.boolParam.defaultValue = value;
}

//
// Set Uns32 parameter default
//
static void setUns32ParamDefault(vmiParameterP param, Uns32 value) {
    CHECK_PARAM_TYPE(param, vmi_PT_UNS32, "Uns32");
    param->u.uns32Param.defaultValue = value;
}

//
// Set Uns64 parameter default
//
static void setUns64ParamDefault(vmiParameterP param, Uns64 value) {
    CHECK_PARAM_TYPE(param, vmi_PT_UNS64, "Uns64");
    param->u.uns64Param.defaultValue = value;
}

//
// Set Uns32 parameter maximum value
//
static void setUns32ParamMax(vmiParameterP param, Uns32 value) {
    CHECK_PARAM_TYPE(param, vmi_PT_UNS32, "Uns32");
    param->u.uns32Param.max = value;
}

//
// Set Flt64 parameter default
//
static void setFlt64ParamDefault(vmiParameterP param, Flt64 value) {
    CHECK_PARAM_TYPE(param, vmi_PT_DOUBLE, "Flt64");
    param->u.doubleParam.defaultValue = value;
}

//
// Macro to define a function to set a raw enum parameter value from the
// configuration
//
#define RISCV_ENUM_PDEFAULT_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setEnumParamDefault(param, cfg->_NAME);  \
}

//
// Macro to define a function to set a raw Bool parameter value from the
// configuration
//
#define RISCV_BOOL_PDEFAULT_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setBoolParamDefault(param, cfg->_NAME);  \
}

//
// Macro to define a function to set a raw Bool parameter value from the
// negation of a "no" prefixed equivalent in the configuration
//
#define RISCV_NOT_PDEFAULT_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setBoolParamDefault(param, !cfg->no##_NAME);  \
}

//
// Macro to define a function to set a raw Uns32 parameter value from the
// configuration
//
#define RISCV_UNS32_PDEFAULT_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setUns32ParamDefault(param, cfg->_NAME);  \
}

//
// Macro to define a function to set a raw Uns64 parameter value from the
// configuration
//
#define RISCV_UNS64_PDEFAULT_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setUns64ParamDefault(param, cfg->_NAME);  \
}

//
// Set default value of raw enum parameters
//
static RISCV_ENUM_PDEFAULT_CFG_FN(user_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(priv_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(vect_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(bitmanip_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(compress_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(hyp_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(crypto_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(vcrypto_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(dsp_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(dbg_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(rnmi_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(Smepmp_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(CLIC_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(AIA_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(Zfinx_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(Zcea_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(Zceb_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(Zcee_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(fp16_version);
static RISCV_ENUM_PDEFAULT_CFG_FN(mstatus_fs_mode);
static RISCV_ENUM_PDEFAULT_CFG_FN(debug_mode);
static RISCV_ENUM_PDEFAULT_CFG_FN(debug_eret_mode);
static RISCV_ENUM_PDEFAULT_CFG_FN(debug_priority);
static RISCV_ENUM_PDEFAULT_CFG_FN(lr_sc_constraint);
static RISCV_ENUM_PDEFAULT_CFG_FN(amo_constraint);
static RISCV_ENUM_PDEFAULT_CFG_FN(push_pop_constraint);
static RISCV_ENUM_PDEFAULT_CFG_FN(vector_constraint);

//
// Set default value of raw Bool parameters
//
static RISCV_BOOL_PDEFAULT_CFG_FN(enable_expanded);
static RISCV_BOOL_PDEFAULT_CFG_FN(endianFixed);
static RISCV_BOOL_PDEFAULT_CFG_FN(updatePTEA);
static RISCV_BOOL_PDEFAULT_CFG_FN(updatePTED);
static RISCV_BOOL_PDEFAULT_CFG_FN(unaligned_low_pri);
static RISCV_BOOL_PDEFAULT_CFG_FN(unaligned);
static RISCV_BOOL_PDEFAULT_CFG_FN(unalignedAMO);
static RISCV_BOOL_PDEFAULT_CFG_FN(unalignedV);
static RISCV_BOOL_PDEFAULT_CFG_FN(wfi_is_nop);
static RISCV_BOOL_PDEFAULT_CFG_FN(wfi_resume_not_trap);
static RISCV_BOOL_PDEFAULT_CFG_FN(mtvec_is_ro);
static RISCV_BOOL_PDEFAULT_CFG_FN(tval_zero);
static RISCV_BOOL_PDEFAULT_CFG_FN(nmi_is_latched);
static RISCV_BOOL_PDEFAULT_CFG_FN(tval_ii_code);
static RISCV_BOOL_PDEFAULT_CFG_FN(cycle_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(mcycle_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(time_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(instret_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(minstret_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(hpmcounter_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(mhpmcounter_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(tinfo_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(tcontrol_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(mcontext_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(scontext_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(mscontext_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(hcontext_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(mnoise_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(amo_trigger);
static RISCV_BOOL_PDEFAULT_CFG_FN(amo_aborts_lr_sc);
static RISCV_BOOL_PDEFAULT_CFG_FN(no_hit);
static RISCV_BOOL_PDEFAULT_CFG_FN(no_sselect_2);
static RISCV_BOOL_PDEFAULT_CFG_FN(enable_CSR_bus);
static RISCV_BOOL_PDEFAULT_CFG_FN(d_requires_f);
static RISCV_BOOL_PDEFAULT_CFG_FN(enable_fflags_i);
static RISCV_BOOL_PDEFAULT_CFG_FN(trap_preserves_lr);
static RISCV_BOOL_PDEFAULT_CFG_FN(xret_preserves_lr);
static RISCV_BOOL_PDEFAULT_CFG_FN(fence_g_preserves_vs);
static RISCV_BOOL_PDEFAULT_CFG_FN(require_vstart0);
static RISCV_BOOL_PDEFAULT_CFG_FN(align_whole);
static RISCV_BOOL_PDEFAULT_CFG_FN(vill_trap);
static RISCV_BOOL_PDEFAULT_CFG_FN(external_int_id);
static RISCV_BOOL_PDEFAULT_CFG_FN(CLICANDBASIC);
static RISCV_BOOL_PDEFAULT_CFG_FN(CLICSELHVEC);
static RISCV_BOOL_PDEFAULT_CFG_FN(CLICXNXTI);
static RISCV_BOOL_PDEFAULT_CFG_FN(CLICXCSW);
static RISCV_BOOL_PDEFAULT_CFG_FN(externalCLIC);
static RISCV_BOOL_PDEFAULT_CFG_FN(tvt_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(intthresh_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(mclicbase_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(CSIP_present);
static RISCV_BOOL_PDEFAULT_CFG_FN(mstatus_FS_zero);
static RISCV_BOOL_PDEFAULT_CFG_FN(MXL_writable);
static RISCV_BOOL_PDEFAULT_CFG_FN(SXL_writable);
static RISCV_BOOL_PDEFAULT_CFG_FN(UXL_writable);
static RISCV_BOOL_PDEFAULT_CFG_FN(VSXL_writable);
#if(ENABLE_SSMPU)
static RISCV_BOOL_PDEFAULT_CFG_FN(MPU_decompose);
#endif
static RISCV_BOOL_PDEFAULT_CFG_FN(PMP_decompose);
static RISCV_BOOL_PDEFAULT_CFG_FN(PMP_undefined);
static RISCV_BOOL_PDEFAULT_CFG_FN(PMP_maskparams);
static RISCV_BOOL_PDEFAULT_CFG_FN(PMP_initialparams);
static RISCV_BOOL_PDEFAULT_CFG_FN(posedge_other);
static RISCV_BOOL_PDEFAULT_CFG_FN(poslevel_other);
static RISCV_BOOL_PDEFAULT_CFG_FN(tval_zero_ebreak);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zawrs);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zmmul);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zfa);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zfhmin);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zihintntl);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zicond);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zicbom);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zicbop);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zicboz);
static RISCV_BOOL_PDEFAULT_CFG_FN(Smstateen);
static RISCV_BOOL_PDEFAULT_CFG_FN(Sstc);
static RISCV_BOOL_PDEFAULT_CFG_FN(Svpbmt);
static RISCV_BOOL_PDEFAULT_CFG_FN(Svinval);
static RISCV_BOOL_PDEFAULT_CFG_FN(Smaia);
static RISCV_BOOL_PDEFAULT_CFG_FN(IMSIC_present);
static RISCV_BOOL_PDEFAULT_CFG_FN(use_hw_reg_names);
static RISCV_BOOL_PDEFAULT_CFG_FN(no_pseudo_inst);
static RISCV_BOOL_PDEFAULT_CFG_FN(show_c_prefix);
static RISCV_BOOL_PDEFAULT_CFG_FN(lr_sc_match_size);
static RISCV_BOOL_PDEFAULT_CFG_FN(ignore_non_leaf_DAU);

//
// Set default value of raw negated Bool parameters
//
static RISCV_NOT_PDEFAULT_CFG_FN(Zicsr);
static RISCV_NOT_PDEFAULT_CFG_FN(Zifencei);

//
// Set default value of raw Uns32 parameters
//
static RISCV_UNS32_PDEFAULT_CFG_FN(dcsr_ebreak_mask);
static RISCV_UNS32_PDEFAULT_CFG_FN(trigger_num);
static RISCV_UNS32_PDEFAULT_CFG_FN(mcontrol_maskmax);
static RISCV_UNS32_PDEFAULT_CFG_FN(tinfo);
static RISCV_UNS32_PDEFAULT_CFG_FN(tvec_align);
static RISCV_UNS32_PDEFAULT_CFG_FN(counteren_mask);
static RISCV_UNS32_PDEFAULT_CFG_FN(scounteren_zero_mask);
static RISCV_UNS32_PDEFAULT_CFG_FN(hcounteren_zero_mask);
static RISCV_UNS32_PDEFAULT_CFG_FN(noinhibit_mask);
#if(ENABLE_SSMPU)
static RISCV_UNS32_PDEFAULT_CFG_FN(MPU_grain)
static RISCV_UNS32_PDEFAULT_CFG_FN(MPU_registers)
#endif
static RISCV_UNS32_PDEFAULT_CFG_FN(PMP_grain)
static RISCV_UNS32_PDEFAULT_CFG_FN(PMP_max_page)
static RISCV_UNS32_PDEFAULT_CFG_FN(CLICLEVELS);
static RISCV_UNS32_PDEFAULT_CFG_FN(TW_time_limit);
static RISCV_UNS32_PDEFAULT_CFG_FN(STO_time_limit);

//
// Set default value of raw Uns64 parameters
//
static RISCV_UNS64_PDEFAULT_CFG_FN(reset_address)
static RISCV_UNS64_PDEFAULT_CFG_FN(nmi_address)
static RISCV_UNS64_PDEFAULT_CFG_FN(nmiexc_address)
static RISCV_UNS64_PDEFAULT_CFG_FN(CLINT_address)
static RISCV_UNS64_PDEFAULT_CFG_FN(debug_address)
static RISCV_UNS64_PDEFAULT_CFG_FN(dexc_address)
static RISCV_UNS64_PDEFAULT_CFG_FN(unimp_int_mask)
static RISCV_UNS64_PDEFAULT_CFG_FN(force_mideleg)
static RISCV_UNS64_PDEFAULT_CFG_FN(force_sideleg)
static RISCV_UNS64_PDEFAULT_CFG_FN(no_ideleg)
static RISCV_UNS64_PDEFAULT_CFG_FN(no_edeleg)
static RISCV_UNS64_PDEFAULT_CFG_FN(posedge_0_63)
static RISCV_UNS64_PDEFAULT_CFG_FN(poslevel_0_63)
static RISCV_UNS64_PDEFAULT_CFG_FN(Svnapot_page_mask)
static RISCV_UNS64_PDEFAULT_CFG_FN(miprio_mask)
static RISCV_UNS64_PDEFAULT_CFG_FN(siprio_mask)
static RISCV_UNS64_PDEFAULT_CFG_FN(hviprio_mask)

//
// Specify whether full half-precision scalar floating point is implemented
//
static RISCV_PDEFAULT_FN(default_Zfh) {
    Bool Zfh = (cfg->fp16_version==RVFP16_IEEE754) && !cfg->Zfhmin;
    setBoolParamDefault(param, Zfh);
}

//
// Specify whether D registers are used for parameter passing (ABI semihosting)
//
static RISCV_PDEFAULT_FN(default_ABI_d) {
    setBoolParamDefault(param, cfg->arch & ISA_D);
}

//
// max number of PMPs for the architecture
//
static Uns32 max_PMP_registers(riscvConfigCP cfg) {
    return (cfg->priv_version>=RVPV_1_12) ? 64 : 16;
}

//
// Set default number of PMP registers
//
static RISCV_PDEFAULT_FN(default_PMP_registers) {

    setUns32ParamDefault(param, cfg->PMP_registers);
    setUns32ParamMax(param, max_PMP_registers(cfg));
}

//
// Set default value of numHarts
//
static RISCV_PDEFAULT_FN(default_numHarts) {

    Uns32 numHarts = cfg->numHarts;

    setUns32ParamDefault(param, numHarts==RV_NUMHARTS_0 ? 0 : numHarts);
}

//
// Set default value of numHarts
//
static RISCV_PDEFAULT_FN(default_trigger_match) {

    Uns32 trigger_match = cfg->trigger_match;

    setUns32ParamDefault(param, trigger_match ? trigger_match : 0xffff);
}

//
// Set default value of Sv_modes
//
static RISCV_PDEFAULT_FN(default_Sv_modes) {

    Uns32 Sv_modes = cfg->Sv_modes;

    if(cfg->Sv_modes) {
        // no action
    } else if(cfg->arch & ISA_XLEN_64) {
        Sv_modes = RISCV_VMM_64;
    } else {
        Sv_modes = RISCV_VMM_32;
    }

    setUns32ParamDefault(param, Sv_modes);
}

//
// Set default value of lr_sc_grain
//
static RISCV_PDEFAULT_FN(default_lr_sc_grain) {

    setUns32ParamDefault(param, cfg->lr_sc_grain ? : 1);
}

//
// Set default value of misa_MXL
//
static RISCV_PDEFAULT_FN(default_misa_MXL) {

    setUns32ParamDefault(param, (cfg->arch & ISA_XLEN_64) ? 2 : 1);
}

//
// Set default value of misa_Extensions
//
static RISCV_PDEFAULT_FN(default_misa_Extensions) {

    setUns32ParamDefault(param, cfg->arch & ~cfg->archImplicit & ~ISA_XLEN_ANY);
}

//
// Set default value of misa_Extensions_mask
//
static RISCV_PDEFAULT_FN(default_misa_Extensions_mask) {

    // only bits that are non-zero in arch and not in archZero are writable
    setUns32ParamDefault(param, cfg->archMask & cfg->arch & ~cfg->archImplicit);
}

//
// Set default and maximum value of local_int_num
//
static RISCV_PDEFAULT_FN(default_local_int_num) {

    Uns32 maxLocal;

    if(cfg->CLICLEVELS) {
        maxLocal = 4096-16;
    } else if((cfg->arch & ISA_XLEN_64) || cfg->Smaia) {
        maxLocal = 48;
    } else {
        maxLocal = 16;
    }

    setUns32ParamDefault(param, cfg->local_int_num);
    setUns32ParamMax(param, maxLocal);
}

//
// Return XLEN all-ones right shifted by one
//
static Uns64 getXLMaskShr1(riscvConfigCP cfg) {
    return ((cfg->arch & ISA_XLEN_64) ? -1ULL : (Uns32)-1) >> 1;
}

//
// Set default value of ecode_mask
//
static RISCV_PDEFAULT_FN(default_ecode_mask) {

    Uns64 ecode_mask = cfg->ecode_mask;

    if(ecode_mask) {
        // use specified mask
    } else if(cfg->CLICLEVELS) {
        ecode_mask = 0xfff;
    } else {
        ecode_mask = getXLMaskShr1(cfg);
    }

    setUns64ParamDefault(param, ecode_mask);
}

//
// Set default value of ecode_nmi
//
static RISCV_PDEFAULT_FN(default_ecode_nmi) {

    Uns64 ecode_nmi = cfg->ecode_nmi;

    if(ecode_nmi) {
        // use specified mask
    } else if(cfg->CLICLEVELS) {
        ecode_nmi = 0xfff;
    }

    setUns64ParamDefault(param, ecode_nmi);
}

//
// Set default value of ecode_nmi_mask
//
static RISCV_PDEFAULT_FN(default_ecode_nmi_mask) {

    setUns64ParamDefault(param, cfg->ecode_nmi_mask ? : getXLMaskShr1(cfg));
}

//
// Set default and maximum value of mcontext_bits
//
static RISCV_PDEFAULT_FN(default_mcontext_bits) {

    setUns32ParamDefault(param, cfg->mcontext_bits);
    setUns32ParamMax(param, (cfg->arch&ISA_XLEN_64) ? 64 : 32);
}

//
// Set default and maximum value of scontext_bits
//
static RISCV_PDEFAULT_FN(default_scontext_bits) {

    setUns32ParamDefault(param, cfg->scontext_bits);
    setUns32ParamMax(param, (cfg->arch&ISA_XLEN_64) ? 64 : 32);
}

//
// Set default and maximum value of mvalue_bits
//
static RISCV_PDEFAULT_FN(default_mvalue_bits) {

    setUns32ParamDefault(param, cfg->mvalue_bits);
    setUns32ParamMax(param, (cfg->arch&ISA_XLEN_64) ? 13 : 6);
}

//
// Set default and maximum value of svalue_bits
//
static RISCV_PDEFAULT_FN(default_svalue_bits) {

    setUns32ParamDefault(param, cfg->svalue_bits);
    setUns32ParamMax(param, (cfg->arch&ISA_XLEN_64) ? 34 : 16);
}

//
// Set default and maximum value of ASID_bits
//
static RISCV_PDEFAULT_FN(default_ASID_bits) {

    setUns32ParamDefault(param, cfg->ASID_bits);
    setUns32ParamMax(param, (cfg->arch&ISA_XLEN_64) ? 16 : 9);
}

//
// Set default and maximum value of VMID_bits
//
static RISCV_PDEFAULT_FN(default_VMID_bits) {

    setUns32ParamDefault(param, cfg->VMID_bits);
    setUns32ParamMax(param, (cfg->arch&ISA_XLEN_64) ? 14 : 7);
}

//
// Set default value of CLICINTCTLBITS
//
static RISCV_PDEFAULT_FN(default_CLICINTCTLBITS) {

    setUns32ParamDefault(param, cfg->CLICINTCTLBITS ? : 2);
}

//
// Set default value of CLICVERSION
//
static RISCV_PDEFAULT_FN(default_CLICVERSION) {

    setUns32ParamDefault(param, cfg->CLICVERSION ? : 0x11);
}

//
// Set default and maximum value of CLICCFGMBITS
//
static RISCV_PDEFAULT_FN(default_CLICCFGMBITS) {

    Uns32 max   = getCLICCFGMBITSMax(cfg);
    Uns32 value = cfg->CLICCFGMBITS;

    setUns32ParamDefault(param, value<=max ? value : max);
    setUns32ParamMax(param, max);
}

//
// Set default and maximum value of CLICCFGLBITS
//
static RISCV_PDEFAULT_FN(default_CLICCFGLBITS) {

    Uns32 max   = getCLICCFGLBITSMax(cfg);
    Uns32 value = cfg->CLICCFGLBITS;

    setUns32ParamDefault(param, value<=max ? value : max);
    setUns32ParamMax(param, max);
}

//
// Set default and maximum value of nlbits_valid
//
static RISCV_PDEFAULT_FN(default_nlbits_valid) {

    Uns32 mask  = (2<<getCLICCFGLBITSMax(cfg))-1;
    Uns32 value = cfg->nlbits_valid & mask;

    setUns32ParamDefault(param, value ? value : mask);
    setUns32ParamMax(param, mask);
}

//
// Set default value of INTTHRESHBITS
//
static RISCV_PDEFAULT_FN(default_INTTHRESHBITS) {

    setUns32ParamDefault(param, cfg->INTTHRESHBITS ? : 8);
}

//
// Set default value for time CSR counter frequency
//
static RISCV_PDEFAULT_FN(default_mtime_Hz) {
    setFlt64ParamDefault(param, cfg->mtime_Hz ? : 1e6);
}

//
// Set default value for AIA IPRIOLEN
//
static RISCV_PDEFAULT_FN(default_IPRIOLEN) {
    setUns32ParamDefault(param, cfg->IPRIOLEN ? : 8);
}

//
// Set default value for AIA HIPRIOLEN
//
static RISCV_PDEFAULT_FN(default_HIPRIOLEN) {
    setUns32ParamDefault(param, cfg->HIPRIOLEN ? : 8);
}

//
// Specify implemented bits for AIA hvictl.IID
//
static RISCV_PDEFAULT_FN(default_hvictl_IID_bits) {
    setUns32ParamDefault(param, cfg->hvictl_IID_bits ? : 12);
}

//
// Macro to define a function to set an Uns32 CSR parameter value from the
// configuration
//
#define RISCV_CSR_PDEFAULT_32_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setUns32ParamDefault(param, cfg->csr._NAME._pad);  \
}

//
// Macro to define a function to set an Uns64 CSR parameter value from the
// configuration
//
#define RISCV_CSR_PDEFAULT_64_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setUns64ParamDefault(param, cfg->csr._NAME._pad);  \
}

//
// Set default value of CSR parameters
//
static RISCV_CSR_PDEFAULT_64_CFG_FN(mvendorid)
static RISCV_CSR_PDEFAULT_64_CFG_FN(marchid)
static RISCV_CSR_PDEFAULT_64_CFG_FN(mimpid)
static RISCV_CSR_PDEFAULT_64_CFG_FN(mhartid)
static RISCV_CSR_PDEFAULT_64_CFG_FN(mconfigptr)
static RISCV_CSR_PDEFAULT_64_CFG_FN(mtvec)
static RISCV_CSR_PDEFAULT_64_CFG_FN(mclicbase)
static RISCV_CSR_PDEFAULT_64_CFG_FN(mseccfg)

// Set default value of PMP Configuration parameters
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpcfg0)
static RISCV_CSR_PDEFAULT_32_CFG_FN(pmpcfg1)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpcfg2)
static RISCV_CSR_PDEFAULT_32_CFG_FN(pmpcfg3)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpcfg4)
static RISCV_CSR_PDEFAULT_32_CFG_FN(pmpcfg5)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpcfg6)
static RISCV_CSR_PDEFAULT_32_CFG_FN(pmpcfg7)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpcfg8)
static RISCV_CSR_PDEFAULT_32_CFG_FN(pmpcfg9)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpcfg10)
static RISCV_CSR_PDEFAULT_32_CFG_FN(pmpcfg11)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpcfg12)
static RISCV_CSR_PDEFAULT_32_CFG_FN(pmpcfg13)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpcfg14)
static RISCV_CSR_PDEFAULT_32_CFG_FN(pmpcfg15)

#define RISCV_PMP_ADDR_PDEFAULT_CFG_FN_0_9(_I) \
    static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr##_I##0) \
    static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr##_I##1) \
    static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr##_I##2) \
    static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr##_I##3) \
    static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr##_I##4) \
    static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr##_I##5) \
    static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr##_I##6) \
    static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr##_I##7) \
    static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr##_I##8) \
    static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr##_I##9)

static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr0)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr1)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr2)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr3)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr4)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr5)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr6)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr7)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr8)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr9)
RISCV_PMP_ADDR_PDEFAULT_CFG_FN_0_9(1)
RISCV_PMP_ADDR_PDEFAULT_CFG_FN_0_9(2)
RISCV_PMP_ADDR_PDEFAULT_CFG_FN_0_9(3)
RISCV_PMP_ADDR_PDEFAULT_CFG_FN_0_9(4)
RISCV_PMP_ADDR_PDEFAULT_CFG_FN_0_9(5)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr60)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr61)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr62)
static RISCV_CSR_PDEFAULT_64_CFG_FN(pmpaddr63)

//
// Macro to define a function to set an Uns64 CSR mask value from the
// configuration
//
#define RISCV_CSR_PMDEFAULT_CFG_FN(_NAME, _ZERO_VAL) RISCV_PDEFAULT_FN(default_##_NAME##_mask) { \
    setUns64ParamDefault(param, cfg->csrMask._NAME._pad ? : _ZERO_VAL);  \
}

//
// Set default value of CSR mask parameters
//
static RISCV_CSR_PMDEFAULT_CFG_FN(mtvec, 0)
static RISCV_CSR_PMDEFAULT_CFG_FN(stvec, 0)
static RISCV_CSR_PMDEFAULT_CFG_FN(utvec, 0)
static RISCV_CSR_PMDEFAULT_CFG_FN(mtvt,  WM64_tvt)
static RISCV_CSR_PMDEFAULT_CFG_FN(stvt,  WM64_tvt)
static RISCV_CSR_PMDEFAULT_CFG_FN(utvt,  WM64_tvt)
static RISCV_CSR_PMDEFAULT_CFG_FN(jvt,   WM64_jvt)

//
// Set default value of tdata1_mask
//
static RISCV_PDEFAULT_FN(default_tdata1_mask) {
    setUns64ParamDefault(param, cfg->csrMask.tdata1.u64.bits ? : -1);
}

//
// Set default values of mip_mask, sip_mask, uip_mask and hip_mask
//
static RISCV_PDEFAULT_FN(default_mip_mask) {
    setUns64ParamDefault(param, cfg->csrMask.mip.u64.bits ? : WM32_mip);
}
static RISCV_PDEFAULT_FN(default_sip_mask) {
    setUns64ParamDefault(param, cfg->csrMask.sip.u64.bits ? : WM32_sip);
}
static RISCV_PDEFAULT_FN(default_uip_mask) {
    setUns64ParamDefault(param, cfg->csrMask.uip.u64.bits ? : WM32_uip);
}
static RISCV_PDEFAULT_FN(default_hip_mask) {
    setUns64ParamDefault(param, cfg->csrMask.hip.u64.bits ? : WM32_hip);
}
static RISCV_PDEFAULT_FN(default_mvien_mask) {
    setUns64ParamDefault(param, cfg->csrMask.mvien.u64.bits);
}
static RISCV_PDEFAULT_FN(default_mvip_mask) {
    setUns64ParamDefault(param, cfg->csrMask.mvip.u64.bits);
}
static RISCV_PDEFAULT_FN(default_hvip_mask) {
    setUns64ParamDefault(param, cfg->csrMask.hvip.u64.bits ? : WM64_hvip);
}
static RISCV_PDEFAULT_FN(default_hvien_mask) {
    setUns64ParamDefault(param, cfg->csrMask.hvien.u64.bits);
}

//
// Set default value of envcfg_mask
//
static RISCV_PDEFAULT_FN(default_envcfg_mask) {
    setUns64ParamDefault(param, cfg->csrMask.envcfg.u64.bits);
}

//
// Set default value of CSR sign-extend parameters
//
static RISCV_BOOL_PDEFAULT_CFG_FN(mtvec_sext);
static RISCV_BOOL_PDEFAULT_CFG_FN(stvec_sext);
static RISCV_BOOL_PDEFAULT_CFG_FN(utvec_sext);
static RISCV_BOOL_PDEFAULT_CFG_FN(mtvt_sext);
static RISCV_BOOL_PDEFAULT_CFG_FN(stvt_sext);
static RISCV_BOOL_PDEFAULT_CFG_FN(utvt_sext);

//
// Set default values of ELEN, SLEN, VLEN and SEW_min (Vector Extension)
//
static RISCV_PDEFAULT_FN(default_ELEN) {
    setUns32ParamDefault(param, cfg->ELEN ? : ELEN_DEFAULT);
}
static RISCV_PDEFAULT_FN(default_SLEN) {
    setUns32ParamDefault(param, cfg->SLEN ? : SLEN_DEFAULT);
}
static RISCV_PDEFAULT_FN(default_VLEN) {
    setUns32ParamDefault(param, cfg->VLEN ? : VLEN_DEFAULT);
}
static RISCV_PDEFAULT_FN(default_EEW_index) {
    setUns32ParamDefault(param, cfg->EEW_index);
}
static RISCV_PDEFAULT_FN(default_SEW_min) {
    setUns32ParamDefault(param, cfg->SEW_min ? cfg->SEW_min : SEW_MIN);
}

//
// Set default values of agnostic_ones, Zvlsseg, Zvamo and Zvediv (Vector
// Extension)
//
static RISCV_BOOL_PDEFAULT_CFG_FN(agnostic_ones);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zvlsseg);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zvamo);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zvediv);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zvqmac);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zvfh);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zvfhmin);
static RISCV_BOOL_PDEFAULT_CFG_FN(Zvfbfmin);

//
// Set vector extension embedded profile parameter default
//
static void setVProfileParamDefault(
    riscvConfigCP  cfg,
    vmiParameterP  param,
    riscvVectorSet option
) {
    CHECK_PARAM_TYPE(param, vmi_PT_BOOL, "Bool");
    param->u.boolParam.defaultValue = (cfg->vect_profile == option);
}

//
// Macro to define a function to set a raw Bool vector extension embedded
// profile parameter value from the configuration
//
#define RISCV_VPROF_PDEFAULT_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setVProfileParamDefault(cfg, param, RVVS_##_NAME); \
}

//
// Set default values of vector extension embedded profile options
//
static RISCV_VPROF_PDEFAULT_CFG_FN(Zve32x);
static RISCV_VPROF_PDEFAULT_CFG_FN(Zve32f);
static RISCV_VPROF_PDEFAULT_CFG_FN(Zve64x);
static RISCV_VPROF_PDEFAULT_CFG_FN(Zve64f);
static RISCV_VPROF_PDEFAULT_CFG_FN(Zve64d);

//
// Set compressed extension subset option parameter default
//
static void setCSetParamDefault(
    riscvConfigCP    cfg,
    vmiParameterP    param,
    riscvCompressSet option
) {
    CHECK_PARAM_TYPE(param, vmi_PT_BOOL, "Bool");

    riscvCompressSet compress_present = cfg->compress_present;

    // Zcmb and Zcmpe are removed from version 1.0.0
    if(cfg->compress_version>=RVCV_1_0_0_RC57) {
        compress_present &= ~(RVCS_Zcmb|RVCS_Zcmpe);
    }

    // enable base C extensions if unspecified
    if(!compress_present) {
        compress_present = (RVCS_Zca|RVCS_Zcd|RVCS_Zcf);
    }

    param->u.boolParam.defaultValue = (compress_present & option);
}

//
// Macro to define a function to set a raw Bool compressed subset parameter
// value from the configuration
//
#define RISCV_CSET_PDEFAULT_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setCSetParamDefault(cfg, param, RVCS_##_NAME); \
}

//
// Set default values of compressed extension subset options
//
static RISCV_CSET_PDEFAULT_CFG_FN(Zca);
static RISCV_CSET_PDEFAULT_CFG_FN(Zcb);
static RISCV_CSET_PDEFAULT_CFG_FN(Zcf);
static RISCV_CSET_PDEFAULT_CFG_FN(Zcmb);
static RISCV_CSET_PDEFAULT_CFG_FN(Zcmp);
static RISCV_CSET_PDEFAULT_CFG_FN(Zcmpe);
static RISCV_CSET_PDEFAULT_CFG_FN(Zcmt);

//
// Set bit manipulation extension subset option parameter default
//
static void setBMSetParamDefault(
    riscvConfigCP    cfg,
    vmiParameterP    param,
    riscvBitManipSet option
) {
    CHECK_PARAM_TYPE(param, vmi_PT_BOOL, "Bool");
    param->u.boolParam.defaultValue = !(cfg->bitmanip_absent & option);
}

//
// Macro to define a function to set a raw Bool bit manipulation subset
// parameter value from the configuration
//
#define RISCV_BMSET_PDEFAULT_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setBMSetParamDefault(cfg, param, RVBS_##_NAME); \
}

//
// Set default values of bit manipulation extension subset options
//
static RISCV_BMSET_PDEFAULT_CFG_FN(Zba);
static RISCV_BMSET_PDEFAULT_CFG_FN(Zbb);
static RISCV_BMSET_PDEFAULT_CFG_FN(Zbc);
static RISCV_BMSET_PDEFAULT_CFG_FN(Zbe);
static RISCV_BMSET_PDEFAULT_CFG_FN(Zbf);
static RISCV_BMSET_PDEFAULT_CFG_FN(Zbm);
static RISCV_BMSET_PDEFAULT_CFG_FN(Zbp);
static RISCV_BMSET_PDEFAULT_CFG_FN(Zbr);
static RISCV_BMSET_PDEFAULT_CFG_FN(Zbs);
static RISCV_BMSET_PDEFAULT_CFG_FN(Zbt);

//
// Set cryptographic extension subset option parameter default
//
static void setKSetParamDefault(
    riscvConfigCP  cfg,
    vmiParameterP  param,
    riscvCryptoSet option
) {
    CHECK_PARAM_TYPE(param, vmi_PT_BOOL, "Bool");
    param->u.boolParam.defaultValue = !(cfg->crypto_absent & option);
}

//
// Macro to define a function to set a raw Bool cryptographic subset parameter
// value from the configuration
//
#define RISCV_KSET_PDEFAULT_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setKSetParamDefault(cfg, param, RVKS_##_NAME); \
}

//
// Set default values of cryptographic extension subset options
//
static RISCV_KSET_PDEFAULT_CFG_FN(Zbkb);
static RISCV_KSET_PDEFAULT_CFG_FN(Zbkc);
static RISCV_KSET_PDEFAULT_CFG_FN(Zbkx);
static RISCV_KSET_PDEFAULT_CFG_FN(Zkr);
static RISCV_KSET_PDEFAULT_CFG_FN(Zknd);
static RISCV_KSET_PDEFAULT_CFG_FN(Zkne);
static RISCV_KSET_PDEFAULT_CFG_FN(Zknh);
static RISCV_KSET_PDEFAULT_CFG_FN(Zksed);
static RISCV_KSET_PDEFAULT_CFG_FN(Zksh);
static RISCV_KSET_PDEFAULT_CFG_FN(Zkb);
static RISCV_KSET_PDEFAULT_CFG_FN(Zkg);
static RISCV_KSET_PDEFAULT_CFG_FN(Zvkb);
static RISCV_KSET_PDEFAULT_CFG_FN(Zvkg);
static RISCV_KSET_PDEFAULT_CFG_FN(Zvknha);
static RISCV_KSET_PDEFAULT_CFG_FN(Zvknhb);
static RISCV_KSET_PDEFAULT_CFG_FN(Zvkns);
static RISCV_KSET_PDEFAULT_CFG_FN(Zvksed);
static RISCV_KSET_PDEFAULT_CFG_FN(Zvksh);

//
// Set DSP extension subset option parameter default
//
static void setPSetParamDefault(
    riscvConfigCP cfg,
    vmiParameterP param,
    riscvDSPSet   option
) {
    CHECK_PARAM_TYPE(param, vmi_PT_BOOL, "Bool");
    param->u.boolParam.defaultValue = !(cfg->dsp_absent & option);
}

//
// Macro to define a function to set a raw Bool cryptographic subset parameter
// value from the configuration
//
#define RISCV_PSET_PDEFAULT_CFG_FN(_NAME) RISCV_PDEFAULT_FN(default_##_NAME) { \
    setPSetParamDefault(cfg, param, RVPS_##_NAME); \
}

//
// Set default values of cryptographic extension subset options
//
static RISCV_PSET_PDEFAULT_CFG_FN(Zpsfoperand);

//
// Set default values of hypervisor extension subset options
//
static RISCV_BOOL_PDEFAULT_CFG_FN(xtinst_basic);

//
// Set default value and range of GEILEN
//
static RISCV_PDEFAULT_FN(default_GEILEN) {
    setUns32ParamDefault(param, cfg->GEILEN);
    setUns32ParamMax(param, (cfg->arch&ISA_XLEN_64)?63:31);
}

//
// Set default value of cmomp_bytes
//
static RISCV_PDEFAULT_FN(default_cmomp_bytes) {
    Uns32 cmomp_bytes = cfg->cmomp_bytes;
    setUns32ParamDefault(param, cmomp_bytes ? cmomp_bytes : RISCV_CBYTES);
}

//
// Set default value of cmoz_bytes
//
static RISCV_PDEFAULT_FN(default_cmoz_bytes) {
    Uns32 cmoz_bytes = cfg->cmoz_bytes;
    setUns32ParamDefault(param, cmoz_bytes ? cmoz_bytes : RISCV_CBYTES);
}

//
// This describes the parameter groups in the processor
//
typedef enum riscvParamGroupIdE {
    RV_PG_FUND,         // fundamental group
    RV_PG_ARTIF,        // simulation artifacts
    RV_PG_INTXC,        // interrupts and exceptions
    RV_PG_ICSRB,        // instruction and CSR behavior
    RV_PG_CSRDV,        // CSR defaults
    RV_PG_CSRMK,        // CSR masks
    RV_PG_MEM,          // memory
    RV_PG_FP,           // floating point
    RV_PG_B,            // bit manipulation extension
    RV_PG_C,            // compressed extension
    RV_PG_H,            // hypervisor extension
    RV_PG_K,            // cryptographic extension
    RV_PG_N,            // user-level interrupts extension
    RV_PG_P,            // DSP extension
    RV_PG_V,            // vector extension
    RV_PG_CLIC,         // fast interrupts
    RV_PG_AIA,          // AIA interrupts
    RV_PG_DBG,          // debug extension
    RV_PG_TRIG,         // trigger module
    RV_PG_EXT,          // other extensions
    RV_PG_PMP,          // PMP configuration
    RV_PG_LAST          // KEEP LAST: for sizing
} riscvParamGroupId;

//
// This provides information about each group
//
static const vmiParameterGroup groups[RV_PG_LAST+1] = {
    [RV_PG_FUND]  = {name: "Fundamental"},
    [RV_PG_ARTIF] = {name: "Simulation_Artifact"},
    [RV_PG_INTXC] = {name: "Interrupts_Exceptions"},
    [RV_PG_ICSRB] = {name: "Instruction_CSR_Behavior"},
    [RV_PG_CSRDV] = {name: "CSR_Defaults"},
    [RV_PG_CSRMK] = {name: "CSR_Masks"},
    [RV_PG_MEM]   = {name: "Memory"},
    [RV_PG_FP]    = {name: "Floating_Point"},
    [RV_PG_B]     = {name: "Bit_Manipulation_Extension"},
    [RV_PG_C]     = {name: "Compressed_Extension"},
    [RV_PG_H]     = {name: "Hypervisor_Extension"},
    [RV_PG_K]     = {name: "Cryptographic_Extension"},
    [RV_PG_N]     = {name: "User_Level_Interrupts"},
    [RV_PG_P]     = {name: "DSP_Extension"},
    [RV_PG_V]     = {name: "Vector_Extension"},
    [RV_PG_CLIC]  = {name: "Fast_Interrupt"},
    [RV_PG_AIA]   = {name: "AIA_Interrupts"},
    [RV_PG_DBG]   = {name: "Debug_Extension"},
    [RV_PG_TRIG]  = {name: "Trigger"},
    [RV_PG_EXT]   = {name: "Other_Extensions"},
    [RV_PG_PMP]   = {name: "PMP Configuration"},
};

//
// Macro to specify a the group for a register
//
#define RV_GROUP(_G) &groups[RV_PG_##_G]

//
// Macros for PMP configuration parameter "arrays"
//
#define PMP_CFG_EVEN(_I) \
    {  RVPV_PMPMASK,     0,         0,          VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mask_pmpcfg##_I, -1, 0, -1, RV_GROUP(PMP), "Specify hardware-enforced mask of writable bits in pmpcfg"#_I" (upper 32 bits ignored in RV32)")}, \
    {  RVPV_PMPINIT,     0, default_pmpcfg##_I, VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues,      pmpcfg##_I,  0, 0, -1, RV_GROUP(PMP), "Specify reset value of pmpcfg"#_I" (upper 32 bits ignored in RV32)")}

#define PMP_CFG_ODD(_I) \
    {  RVPV_PMPMASK32,   0,         0,          VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, mask_pmpcfg##_I, -1, 0, -1, RV_GROUP(PMP), "Specify hardware-enforced mask of writable bits in pmpcfg"#_I)}, \
    {  RVPV_PMPINIT32,   0, default_pmpcfg##_I, VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues,      pmpcfg##_I,  0, 0, -1, RV_GROUP(PMP), "Specify reset value of pmpcfg"#_I)}

#define PMP_CFG_0_15 \
    PMP_CFG_EVEN(0), \
    PMP_CFG_ODD(1), \
    PMP_CFG_EVEN(2), \
    PMP_CFG_ODD(3), \
    PMP_CFG_EVEN(4), \
    PMP_CFG_ODD(5), \
    PMP_CFG_EVEN(6), \
    PMP_CFG_ODD(7), \
    PMP_CFG_EVEN(8), \
    PMP_CFG_ODD(9), \
    PMP_CFG_EVEN(10), \
    PMP_CFG_ODD(11), \
    PMP_CFG_EVEN(12), \
    PMP_CFG_ODD(13), \
    PMP_CFG_EVEN(14), \
    PMP_CFG_ODD(15)

#define PMP_ADDR(_I) \
    {  RVPV_PMPMASK,     0,         0,           VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mask_pmpaddr##_I, -1, 0, -1, RV_GROUP(PMP),"Specify hardware-enforced mask of writable bits in mask_pmpaddr"#_I)}, \
    {  RVPV_PMPINIT,     0, default_pmpaddr##_I, VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues,      pmpaddr##_I,  0, 0, -1, RV_GROUP(PMP),"Specify reset value of pmpaddr"#_I)}

#define PMP_ADDR_0_9(_X) \
    PMP_ADDR(_X##0), \
    PMP_ADDR(_X##1), \
    PMP_ADDR(_X##2), \
    PMP_ADDR(_X##3), \
    PMP_ADDR(_X##4), \
    PMP_ADDR(_X##5), \
    PMP_ADDR(_X##6), \
    PMP_ADDR(_X##7), \
    PMP_ADDR(_X##8), \
    PMP_ADDR(_X##9)

#define PMP_ADDR_0_63 \
    PMP_ADDR(0), \
    PMP_ADDR(1), \
    PMP_ADDR(2), \
    PMP_ADDR(3), \
    PMP_ADDR(4), \
    PMP_ADDR(5), \
    PMP_ADDR(6), \
    PMP_ADDR(7), \
    PMP_ADDR(8), \
    PMP_ADDR(9), \
    PMP_ADDR_0_9(1), \
    PMP_ADDR_0_9(2), \
    PMP_ADDR_0_9(3), \
    PMP_ADDR_0_9(4), \
    PMP_ADDR_0_9(5), \
    PMP_ADDR(60), \
    PMP_ADDR(61), \
    PMP_ADDR(62), \
    PMP_ADDR(63)

//
// Table of formal parameter specifications
//
static riscvParameter parameters[] = {

    // simulation controls
    {  RVPV_VARIANT, 0,         0,                            VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, variant,                 0,                         RV_GROUP(FUND),  "Selects variant (either a generic UISA or a specific model)")},
    {  RVPV_CLUSTER, 0,         0,                            VMI_STRING_GROUP_PARAM_SPEC(riscvParamValues, clusterVariants,         0,                         RV_GROUP(FUND),  "Specify a comma-separated list of variant names in this cluster")},
    {  RVPV_PRE,     0,         default_user_version,         VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, user_version,            userVariants,              RV_GROUP(FUND),  "Specify required User Architecture version")},
    {  RVPV_PRE,     0,         default_priv_version,         VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, priv_version,            privVariants,              RV_GROUP(FUND),  "Specify required Privileged Architecture version")},
    {  RVPV_V,       0,         default_vect_version,         VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, vector_version,          vectorVariants,            RV_GROUP(V),     "Specify required Vector Architecture version")},
    {  RVPV_BK,      0,         default_bitmanip_version,     VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, bitmanip_version,        bitmanipVariants,          RV_GROUP(B),     "Specify required Bit Manipulation Architecture version")},
    {  RVPV_PRE,     0,         default_compress_version,     VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, compress_version,        compressedVariants,        RV_GROUP(C),     "Specify required Compressed Architecture version")},
    {  RVPV_H,       0,         default_hyp_version,          VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, hypervisor_version,      hypervisorVariants,        RV_GROUP(H),     "Specify required Hypervisor Architecture version")},
    {  RVPV_K,       0,         default_crypto_version,       VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, crypto_version,          cryptoVariants,            RV_GROUP(K),     "Specify required Cryptographic Architecture version")},
    {  RVPV_KV,      0,         default_vcrypto_version,      VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, vcrypto_version,         vcryptoVariants,           RV_GROUP(K),     "Specify required Vector Cryptographic Architecture version")},
    {  RVPV_P,       0,         default_dsp_version,          VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, dsp_version,             DSPVariants,               RV_GROUP(P),     "Specify required DSP Architecture version")},
    {  RVPV_DBGT,    0,         default_dbg_version,          VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, debug_version,           debugVariants,             RV_GROUP(DBG),   "Specify required Debug Architecture version")},
    {  RVPV_PRE,     0,         default_rnmi_version,         VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, rnmi_version,            rnmiVariants,              RV_GROUP(INTXC), "Specify required RNMI Architecture version")},
    {  RVPV_ALL,     RVPV_1_12, default_Smepmp_version,       VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, Smepmp_version,          SmepmpVariants,            RV_GROUP(FUND),  "Specify required Smepmp Architecture version")},
    {  RVPV_CLIC,    0,         default_CLIC_version,         VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, CLIC_version,            CLICVariants,              RV_GROUP(CLIC),  "Specify required CLIC version")},
    {  RVPV_SMAIA,   0,         default_AIA_version,          VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, AIA_version,             AIAVariants,               RV_GROUP(AIA),   "Specify required AIA version")},
    {  RVPV_FP,      0,         default_fp16_version,         VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, fp16_version,            fp16Variants,              RV_GROUP(FP),    "Specify required 16-bit floating point format")},
    {  RVPV_FP,      0,         default_mstatus_fs_mode,      VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, mstatus_fs_mode,         FSModes,                   RV_GROUP(FP),    "Specify conditions causing update of mstatus.FS to dirty")},
    {  RVPV_PRE,     0,         default_debug_mode,           VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, debug_mode,              DMModes,                   RV_GROUP(DBG),   "Specify how Debug mode is implemented")},
    {  RVPV_DEBUG,   0,         default_debug_address,        VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, debug_address,           0, 0,          -1,         RV_GROUP(DBG),   "Specify address to which to jump to enter debug in vectored mode")},
    {  RVPV_DEBUG,   0,         default_dexc_address,         VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, dexc_address,            0, 0,          -1,         RV_GROUP(DBG),   "Specify address to which to jump on debug exception in vectored mode")},
    {  RVPV_DEBUG,   0,         default_debug_eret_mode,      VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, debug_eret_mode,         DERETModes,                RV_GROUP(DBG),   "Specify behavior for MRET, SRET or URET in Debug mode (nop, jump to dexc_address or trap to dexc_address)")},
    {  RVPV_DEBUG,   0,         default_debug_priority,       VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, debug_priority,          DebugPriorities,           RV_GROUP(DBG),   "Specify relative priorities of simultaneous debug events")},
    {  RVPV_DEBUG,   0,         default_dcsr_ebreak_mask,     VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, dcsr_ebreak_mask,        0, 0,          63,         RV_GROUP(DBG),   "Specify mask of dcsr.ebreak fields that reset to 1 (ebreak instructions enter Debug mode)")},
    {  RVPV_A,       0,         default_lr_sc_constraint,     VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, lr_sc_constraint,        memoryConstraints,         RV_GROUP(MEM),   "Specify memory constraint for LR/SC instructions")},
    {  RVPV_A,       0,         default_amo_constraint,       VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, amo_constraint,          memoryConstraints,         RV_GROUP(MEM),   "Specify memory constraint for AMO instructions")},
    {  RVPV_C_CNEW,  0,         default_push_pop_constraint,  VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, push_pop_constraint,     memoryConstraints,         RV_GROUP(MEM),   "Specify memory constraint for PUSH/POP instructions")},
    {  RVPV_V,       0,         default_vector_constraint,    VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, vector_constraint,       memoryConstraints,         RV_GROUP(MEM),   "Specify memory constraint for vector load/store instructions")},
    {  RVPV_ALL,     0,         default_use_hw_reg_names,     VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, use_hw_reg_names,        False,                     RV_GROUP(ARTIF), "Specify whether to use hardware register names x0-x31 and f0-f31 instead of ABI register names")},
    {  RVPV_ALL,     0,         default_no_pseudo_inst,       VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, no_pseudo_inst,          False,                     RV_GROUP(ARTIF), "Specify whether pseudo-instructions should not be reported in trace and disassembly")},
    {  RVPV_C,       0,         default_show_c_prefix,        VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, show_c_prefix,           False,                     RV_GROUP(ARTIF), "Specify whether compressed instruction prefix should be reported in trace and disassembly")},
    {  RVPV_D,       0,         default_ABI_d,                VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, ABI_d,                   False,                     RV_GROUP(ARTIF), "Specify whether D registers are used for parameters (ABI SemiHosting)")},
    {  RVPV_ALL,     0,         0,                            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, verbose,                 False,                     RV_GROUP(ARTIF), "Specify verbose output messages")},
    {  RVPV_ALL,     0,         0,                            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, traceVolatile,           False,                     RV_GROUP(ARTIF), "Specify whether volatile registers (e.g. minstret) should be shown in change trace")},
    {  RVPV_MPCORE,  0,         default_numHarts,             VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, numHarts,                0, 0,          32,         RV_GROUP(FUND),  "Specify the number of hart contexts in a multiprocessor")},
    {  RVPV_S,       0,         default_updatePTEA,           VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, updatePTEA,              False,                     RV_GROUP(MEM),   "Specify whether hardware update of PTE A bit is supported")},
    {  RVPV_S,       0,         default_updatePTED,           VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, updatePTED,              False,                     RV_GROUP(MEM),   "Specify whether hardware update of PTE D bit is supported")},
    {  RVPV_ALL,     0,         default_unaligned_low_pri,    VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, unaligned_low_pri,       False,                     RV_GROUP(MEM),   "Specify whether address misaligned exceptions are lower priority than page or access fault exceptions")},
    {  RVPV_ALL,     0,         default_unaligned,            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, unaligned,               False,                     RV_GROUP(MEM),   "Specify whether the processor supports unaligned memory accesses")},
    {  RVPV_A,       0,         default_unalignedAMO,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zam,                     False,                     RV_GROUP(MEM),   "Specify whether the processor supports unaligned memory accesses for AMO instructions")},
    {  RVPV_V,       0,         default_unalignedV,           VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, unalignedV,              False,                     RV_GROUP(V),     "Specify whether the processor supports unaligned memory accesses for vector instructions")},
    {  RVPV_PRE,     0,         default_wfi_is_nop,           VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, wfi_is_nop,              False,                     RV_GROUP(ICSRB), "Specify whether WFI should be treated as a NOP (if not, halt while waiting for interrupts)")},
    {  RVPV_ALL,     0,         default_wfi_resume_not_trap,  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, wfi_resume_not_trap,     False,                     RV_GROUP(ICSRB), "Specify whether pending wakeup events should cause WFI to be treated as a NOP instead of taking a trap")},
    {  RVPV_WFI,     0,         default_TW_time_limit,        VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, TW_time_limit,           0, 0,          -1,         RV_GROUP(ICSRB), "Specify nominal cycle timeout for instructions controlled by mstatus.TW")},
    {  RVPV_ZAWRS,   0,         default_STO_time_limit,       VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, STO_time_limit,          0, 0,          -1,         RV_GROUP(ICSRB), "Specify nominal short cycle timeout for WRS.STO")},
    {  RVPV_ALL,     0,         default_mtvec_is_ro,          VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, mtvec_is_ro,             False,                     RV_GROUP(INTXC), "Specify whether mtvec CSR is read-only")},
    {  RVPV_ALL,     0,         default_tvec_align,           VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, tvec_align,              0, 0,          (1<<16),    RV_GROUP(INTXC), "Specify hardware-enforced alignment of mtvec/stvec/utvec when Vectored interrupt mode enabled")},
    {  RVPV_ALL,     0,         default_counteren_mask,       VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, counteren_mask,          0, 0,          -1,         RV_GROUP(ICSRB), "Specify hardware-enforced mask of writable bits in mcounteren/scounteren registers")},
    {  RVPV_S,       0,         default_scounteren_zero_mask, VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, scounteren_zero_mask,    0, 0,          -1,         RV_GROUP(ICSRB), "Specify hardware-enforced mask of always-zero bits in scounteren register")},
    {  RVPV_H,       0,         default_hcounteren_zero_mask, VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, hcounteren_zero_mask,    0, 0,          -1,         RV_GROUP(ICSRB), "Specify hardware-enforced mask of always-zero bits in hcounteren register")},
    {  RVPV_ALL,     0,         default_noinhibit_mask,       VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, noinhibit_mask,          0, 0,          -1,         RV_GROUP(ICSRB), "Specify hardware-enforced mask of always-zero bits in mcountinhibit register")},
    {  RVPV_ALL,     0,         default_mtvec_mask,           VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mtvec_mask,              0, 0,          -1,         RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in mtvec register")},
    {  RVPV_S,       0,         default_stvec_mask,           VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, stvec_mask,              0, 0,          -1,         RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in stvec register")},
    {  RVPV_N,       0,         default_utvec_mask,           VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, utvec_mask,              0, 0,          -1,         RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in utvec register")},
    {  RVPV_CLIC,    0,         default_mtvt_mask,            VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mtvt_mask,               0, 0,          -1,         RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in CLIC mtvt register")},
    {  RVPV_CLIC_S,  0,         default_stvt_mask,            VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, stvt_mask,               0, 0,          -1,         RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in CLIC stvt register")},
    {  RVPV_CLIC_N,  0,         default_utvt_mask,            VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, utvt_mask,               0, 0,          -1,         RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in CLIC utvt register")},
    {  RVPV_C_CNEW,  0,         default_jvt_mask,             VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, jvt_mask,                0, 0,          -1,         RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in Zcmt jvt register")},
    {  RVPV_TRIG,    0,         default_tdata1_mask,          VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, tdata1_mask,             0, 0,          -1,         RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in Trigger Module tdata1 register")},
    {  RVPV_ALL,     0,         default_mip_mask,             VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mip_mask,                WM32_mip,    0, -1,        RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in mip register")},
    {  RVPV_S,       0,         default_sip_mask,             VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, sip_mask,                WM32_sip,    0, -1,        RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in sip register")},
    {  RVPV_N,       0,         default_uip_mask,             VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, uip_mask,                WM32_uip,    0, -1,        RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in uip register")},
    {  RVPV_H,       0,         default_hip_mask,             VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, hip_mask,                WM32_hip,    0, -1,        RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in hip register")},
    {  RVPV_H,       0,         default_hvip_mask,            VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, hvip_mask,               0,           0, -1,        RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in hvip register")},
    {  RVPV_ALL,     RVPV_1_12, default_envcfg_mask,          VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, envcfg_mask,             0,           0, -1,        RV_GROUP(CSRMK), "Specify hardware-enforced mask of writable bits in envcfg registers")},
    {  RVPV_ALL,     0,         default_mtvec_sext,           VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, mtvec_sext,              False,                     RV_GROUP(CSRMK), "Specify whether mtvec is sign-extended from most-significant bit")},
    {  RVPV_S,       0,         default_stvec_sext,           VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, stvec_sext,              False,                     RV_GROUP(CSRMK), "Specify whether stvec is sign-extended from most-significant bit")},
    {  RVPV_N,       0,         default_utvec_sext,           VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, utvec_sext,              False,                     RV_GROUP(CSRMK), "Specify whether utvec is sign-extended from most-significant bit")},
    {  RVPV_CLIC,    0,         default_mtvt_sext,            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, mtvt_sext,               False,                     RV_GROUP(CSRMK), "Specify whether mtvt is sign-extended from most-significant bit")},
    {  RVPV_CLIC_S,  0,         default_stvt_sext,            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, stvt_sext,               False,                     RV_GROUP(CSRMK), "Specify whether stvt is sign-extended from most-significant bit")},
    {  RVPV_CLIC_N,  0,         default_utvt_sext,            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, utvt_sext,               False,                     RV_GROUP(CSRMK), "Specify whether utvt is sign-extended from most-significant bit")},
    {  RVPV_ALL,     0,         default_ecode_mask,           VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, ecode_mask,              0, 0,          -1,         RV_GROUP(INTXC), "Specify hardware-enforced mask of writable bits in xcause.ExceptionCode")},
    {  RVPV_ALL,     0,         default_ecode_nmi,            VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, ecode_nmi,               0, 0,          -1,         RV_GROUP(INTXC), "Specify xcause.ExceptionCode for NMI")},
    {  RVPV_RNMI,    0,         default_ecode_nmi_mask,       VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, ecode_nmi_mask,          0, 0,          -1,         RV_GROUP(INTXC), "Specify hardware-enforced mask of writable bits in mncause.ExceptionCode")},
    {  RVPV_ALL,     0,         default_nmi_is_latched,       VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, nmi_is_latched,          False,                     RV_GROUP(INTXC), "Specify whether NMI input is latched on rising edge (if False, it is level-sensitive)")},
    {  RVPV_ALL,     0,         default_tval_zero,            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, tval_zero,               False,                     RV_GROUP(INTXC), "Specify whether mtval/stval/utval are hard wired to zero")},
    {  RVPV_ALL,     0,         default_tval_zero_ebreak,     VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, tval_zero_ebreak,        False,                     RV_GROUP(INTXC), "Specify whether mtval/stval/utval are set to zero by an ebreak")},
    {  RVPV_ALL,     0,         default_tval_ii_code,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, tval_ii_code,            False,                     RV_GROUP(INTXC), "Specify whether mtval/stval contain faulting instruction bits on illegal instruction exception")},
    {  RVPV_U,       0,         default_cycle_undefined,      VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, cycle_undefined,         False,                     RV_GROUP(ICSRB), "Specify that the cycle CSR is undefined")},
    {  RVPV_ALL,     0,         default_mcycle_undefined,     VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, mcycle_undefined,        False,                     RV_GROUP(ICSRB), "Specify that the mcycle CSR is undefined")},
    {  RVPV_PRE,     0,         default_time_undefined,       VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, time_undefined,          False,                     RV_GROUP(ICSRB), "Specify that the time CSR is undefined")},
    {  RVPV_U,       0,         default_instret_undefined,    VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, instret_undefined,       False,                     RV_GROUP(ICSRB), "Specify that the instret CSR is undefined")},
    {  RVPV_ALL,     0,         default_minstret_undefined,   VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, minstret_undefined,      False,                     RV_GROUP(ICSRB), "Specify that the minstret CSR is undefined")},
    {  RVPV_U,       0,         default_hpmcounter_undefined, VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, hpmcounter_undefined,    False,                     RV_GROUP(ICSRB), "Specify that the hpmcounter CSRs are undefined")},
    {  RVPV_ALL,     0,         default_mhpmcounter_undefined,VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, mhpmcounter_undefined,   False,                     RV_GROUP(ICSRB), "Specify that the mhpmcounter CSRs are undefined")},
    {  RVPV_TRIG,    0,         default_tinfo_undefined,      VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, tinfo_undefined,         False,                     RV_GROUP(TRIG),  "Specify that the tinfo CSR is undefined")},
    {  RVPV_TRIG,    0,         default_tcontrol_undefined,   VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, tcontrol_undefined,      False,                     RV_GROUP(TRIG),  "Specify that the tcontrol CSR is undefined")},
    {  RVPV_TRIG,    0,         default_mcontext_undefined,   VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, mcontext_undefined,      False,                     RV_GROUP(TRIG),  "Specify that the mcontext CSR is undefined")},
    {  RVPV_TRIG,    0,         default_scontext_undefined,   VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, scontext_undefined,      False,                     RV_GROUP(TRIG),  "Specify that the scontext CSR is undefined")},
    {  RVPV_TRIG,    0,         default_mscontext_undefined,  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, mscontext_undefined,     False,                     RV_GROUP(TRIG),  "Specify that the mscontext CSR is undefined (Debug Version 0.14.0 and later)")},
    {  RVPV_TRIG_H,  0,         default_hcontext_undefined,   VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, hcontext_undefined,      False,                     RV_GROUP(TRIG),  "Specify that the hcontext CSR is undefined")},
    {  RVPV_K,       0,         default_mnoise_undefined,     VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, mnoise_undefined,        False,                     RV_GROUP(K),     "Specify that the mnoise CSR is undefined")},
    {  RVPV_TRIG,    0,         default_amo_trigger,          VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, amo_trigger,             False,                     RV_GROUP(TRIG),  "Specify whether AMO load/store operations activate triggers")},
    {  RVPV_A,       0,         default_amo_aborts_lr_sc,     VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, amo_aborts_lr_sc,        False,                     RV_GROUP(MEM),   "Specify whether AMO operations abort any active LR/SC pair")},
    {  RVPV_TRIG,    0,         default_no_hit,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, no_hit,                  False,                     RV_GROUP(TRIG),  "Specify that tdata1.hit is unimplemented")},
    {  RVPV_TRIG_S,  0,         default_no_sselect_2,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, no_sselect_2,            False,                     RV_GROUP(TRIG),  "Specify that textra.sselect=2 is not supported (no trigger match by ASID)")},
    {  RVPV_ALL,     0,         default_enable_CSR_bus,       VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, enable_CSR_bus,          False,                     RV_GROUP(ARTIF), "Add artifact CSR bus port, allowing CSR registers to be externally implemented")},
    {  RVPV_ALL,     0,         0,                            VMI_STRING_GROUP_PARAM_SPEC(riscvParamValues, CSR_remap,               "",                        RV_GROUP(ARTIF), "Comma-separated list of CSR number mappings, each of the form <csrName>=<number>")},
    {  RVPV_FP,      0,         default_d_requires_f,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, d_requires_f,            False,                     RV_GROUP(FP),    "If D and F extensions are separately enabled in the misa CSR, whether D is enabled only if F is enabled")},
    {  RVPV_FP,      0,         default_enable_fflags_i,      VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, enable_fflags_i,         False,                     RV_GROUP(FP),    "Whether fflags_i artifact register present (shows per-instruction floating point flags)")},
    {  RVPV_A,       0,         default_trap_preserves_lr,    VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, trap_preserves_lr,       False,                     RV_GROUP(INTXC), "Whether a trap preserves active LR/SC state")},
    {  RVPV_A,       0,         default_xret_preserves_lr,    VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, xret_preserves_lr,       False,                     RV_GROUP(INTXC), "Whether an xret instruction preserves active LR/SC state")},
    {  RVPV_H,       0,         default_fence_g_preserves_vs, VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, fence_g_preserves_vs,    False,                     RV_GROUP(H),     "Whether G-stage fence instruction HFENCE.GVMA preserves VS-stage TLB mappings")},
    {  RVPV_V,       0,         default_require_vstart0,      VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, require_vstart0,         False,                     RV_GROUP(V),     "Whether CSR vstart must be 0 for non-interruptible vector instructions")},
    {  RVPV_V,       0,         default_align_whole,          VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, align_whole,             False,                     RV_GROUP(V),     "Whether whole-register load addresses must be aligned using the encoded EEW")},
    {  RVPV_V,       0,         default_vill_trap,            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, vill_trap,               False,                     RV_GROUP(V),     "Whether illegal vtype values cause trap instead of setting vtype.vill")},
    {  RVPV_S,       0,         0,                            VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, ASID_cache_size,         8, 0,          256,        RV_GROUP(ARTIF), "Specify the number of different ASIDs for which TLB entries are cached; a value of 0 implies no limit")},
    {  RVPV_PRE,     0,         default_trigger_num,          VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, trigger_num,             0, 0,          255,        RV_GROUP(TRIG),  "Specify the number of implemented hardware triggers")},
    {  RVPV_TRIG,    0,         default_tinfo,                VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, tinfo,                   0, 0,          0xffff,     RV_GROUP(TRIG),  "Override tinfo register (for all triggers)")},
    {  RVPV_TRIG,    0,         default_trigger_match,        VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, trigger_match,           0, 1,          0xffff,     RV_GROUP(TRIG),  "Specify legal \"match\" values for triggers of type 2 and 6 (bitmask)")},
    {  RVPV_TRIG,    0,         default_mcontext_bits,        VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, mcontext_bits,           0, 0,          0,          RV_GROUP(TRIG),  "Specify the number of implemented bits in mcontext")},
    {  RVPV_TRIG_S,  0,         default_scontext_bits,        VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, scontext_bits,           0, 0,          0,          RV_GROUP(TRIG),  "Specify the number of implemented bits in scontext")},
    {  RVPV_TRIG,    0,         default_mvalue_bits,          VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, mvalue_bits,             0, 0,          0,          RV_GROUP(TRIG),  "Specify the number of implemented bits in textra.mvalue (if zero, textra.mselect is tied to zero)")},
    {  RVPV_TRIG_S,  0,         default_svalue_bits,          VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, svalue_bits,             0, 0,          0,          RV_GROUP(TRIG),  "Specify the number of implemented bits in textra.svalue (if zero, textra.sselect is tied to zero)")},
    {  RVPV_TRIG,    0,         default_mcontrol_maskmax,     VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, mcontrol_maskmax,        0, 0,          63,         RV_GROUP(TRIG),  "Specify mcontrol.maskmax value")},
    {  RVPV_S,       0,         default_ASID_bits,            VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, ASID_bits,               0, 0,          0,          RV_GROUP(MEM),   "Specify the number of implemented ASID bits")},
    {  RVPV_H,       0,         default_VMID_bits,            VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, VMID_bits,               0, 0,          0,          RV_GROUP(H),     "Specify the number of implemented VMID bits")},
    {  RVPV_A,       0,         default_lr_sc_grain,          VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, lr_sc_grain,             1, 1,          (1<<16),    RV_GROUP(MEM),   "Specify byte granularity of LR/SC lock region (constrained to a power of two)")},
    {  RVPV_64A,     0,         default_lr_sc_match_size,     VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, lr_sc_match_size,        False,                     RV_GROUP(MEM),   "Whether LR/SC access sizes must match")},
    {  RVPV_S,       0,         default_ignore_non_leaf_DAU,  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, ignore_non_leaf_DAU,     False,                     RV_GROUP(MEM),   "Whether non-zero D, A and U bits in non-leaf PTEs are ignored (if False, a trap is taken)")},
    {  RVPV_ALL,     0,         default_reset_address,        VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, reset_address,           0, 0,          -1,         RV_GROUP(INTXC), "Override reset vector address")},
    {  RVPV_ALL,     0,         default_nmi_address,          VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, nmi_address,             0, 0,          -1,         RV_GROUP(INTXC), "Override NMI vector address")},
    {  RVPV_RNMI,    0,         default_nmiexc_address,       VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, nmiexc_address,          0, 0,          -1,         RV_GROUP(INTXC), "Override RNMI exception vector address")},
    {  RVPV_ROOTPRE, 0,         default_CLINT_address,        VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, CLINT_address,           0, 0,          -1,         RV_GROUP(INTXC), "Specify base address of internal CLINT model (or 0 for no CLINT)")},
    {  RVPV_TIMER,   0,         default_mtime_Hz,             VMI_DBL_GROUP_PARAM_SPEC   (riscvParamValues, mtime_Hz,                0, 0,          1e9,        RV_GROUP(INTXC), "Specify clock frequency of time CSR")},
#if(ENABLE_SSMPU)
    {  RVPV_S,       0,         default_MPU_grain,            VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, MPU_grain,               0, 0,          29,         RV_GROUP(MEM),   "Specify Ssmpu region granularity, G (0 => 4 bytes, 1 => 8 bytes, etc)")},
    {  RVPV_S,       0,         default_MPU_registers,        VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, MPU_registers,           0, 0,          64,         RV_GROUP(MEM),   "Specify the number of implemented Ssmpu address registers")},
    {  RVPV_S,       0,         default_MPU_decompose,        VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, MPU_decompose,           False,                     RV_GROUP(MEM),   "Whether unaligned Ssmpu accesses are decomposed into separate aligned accesses")},
#endif

    {  RVPV_ALL,     0,         default_PMP_grain,            VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, PMP_grain,               0, 0,          29,         RV_GROUP(PMP),   "Specify PMP region granularity, G (0 => 4 bytes, 1 => 8 bytes, etc)")},
    {  RVPV_ALL,     0,         default_PMP_registers,        VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, PMP_registers,           0, 0,          0,          RV_GROUP(PMP),   "Specify the number of implemented PMP address registers")},
    {  RVPV_ALL,     0,         default_PMP_max_page,         VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, PMP_max_page,            0, 0,          -1,         RV_GROUP(PMP),   "Specify the maximum size of PMP region to map if non-zero (may improve performance; constrained to a power of two)")},
    {  RVPV_ALL,     0,         default_PMP_decompose,        VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, PMP_decompose,           False,                     RV_GROUP(PMP),   "Whether unaligned PMP accesses are decomposed into separate aligned accesses")},
    {  RVPV_ALL,     0,         default_PMP_undefined,        VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, PMP_undefined,           False,                     RV_GROUP(PMP),   "Whether accesses to unimplemented PMP registers are undefined (if True) or write ignored and zero (if False)")},
    {  RVPV_PRE,     0,         default_PMP_maskparams,       VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, PMP_maskparams,          False,                     RV_GROUP(PMP),   "Enable parameters to change the read-only masks for PMP CSRs")},
    {  RVPV_PRE,     0,         default_PMP_initialparams,    VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, PMP_initialparams,       False,                     RV_GROUP(PMP),   "Enable parameters to change the reset values for PMP CSRs")},
    PMP_CFG_0_15,
    PMP_ADDR_0_63,

    {  RVPV_CMOMP,   0,         default_cmomp_bytes,          VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, cmomp_bytes,             0, 4,          32678,      RV_GROUP(EXT),   "Specify size of cache block for CMO management/prefetch instructions")},
    {  RVPV_CMOZ,    0,         default_cmoz_bytes,           VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, cmoz_bytes,              0, 4,          32678,      RV_GROUP(EXT),   "Specify size of cache block for CMO zero instructions")},
    {  RVPV_S,       0,         default_Sv_modes,             VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, Sv_modes,                0, 0,          (1<<16)-1,  RV_GROUP(MEM),   "Specify bit mask of implemented address translation modes (e.g. (1<<0)+(1<<8) indicates \"bare\" and \"Sv39\" modes may be selected in satp.MODE)")},
    {  RVPV_S,       0,         default_Svnapot_page_mask,    VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, Svnapot_page_mask,       0, 0,          -1,         RV_GROUP(EXT),   "Specify mask of implemented Svnapot intermediate page sizes (e.g. 1<<16 means 64KiB contiguous regions are supported)")},
    {  RVPV_ALL,     0,         default_Smstateen,            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Smstateen,               False,                     RV_GROUP(EXT),   "Specify that Smstateen is implemented")},
    {  RVPV_S,       0,         default_Sstc,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Sstc,                    False,                     RV_GROUP(EXT),   "Specify that Sstc is implemented")},
    {  RVPV_S,       0,         default_Svpbmt,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Svpbmt,                  False,                     RV_GROUP(EXT),   "Specify that Svpbmt is implemented")},
    {  RVPV_S,       0,         default_Svinval,              VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Svinval,                 False,                     RV_GROUP(EXT),   "Specify that Svinval is implemented")},
    {  RVPV_ALL,     0,         default_local_int_num,        VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, local_int_num,           0, 0,          0,          RV_GROUP(INTXC), "Specify number of supplemental local interrupts")},
    {  RVPV_ALL,     0,         default_unimp_int_mask,       VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, unimp_int_mask,          0, 0,          -1,         RV_GROUP(INTXC), "Specify mask of unimplemented interrupts (e.g. 1<<9 indicates Supervisor external interrupt unimplemented)")},
    {  RVPV_ALL,     0,         default_force_mideleg,        VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, force_mideleg,           0, 0,          -1,         RV_GROUP(INTXC), "Specify mask of interrupts always delegated to lower-priority execution level from Machine execution level")},
    {  RVPV_S,       0,         default_force_sideleg,        VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, force_sideleg,           0, 0,          -1,         RV_GROUP(INTXC), "Specify mask of interrupts always delegated to User execution level from Supervisor execution level")},
    {  RVPV_ALL,     0,         default_no_ideleg,            VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, no_ideleg,               0, 0,          -1,         RV_GROUP(INTXC), "Specify mask of interrupts that cannot be delegated to lower-priority execution levels")},
    {  RVPV_ALL,     0,         default_no_edeleg,            VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, no_edeleg,               0, 0,          -1,         RV_GROUP(INTXC), "Specify mask of exceptions that cannot be delegated to lower-priority execution levels")},
    {  RVPV_ALL,     0,         default_external_int_id,      VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, external_int_id,         False,                     RV_GROUP(INTXC), "Whether to add nets allowing External Interrupt ID codes to be forced")},

    // fundamental configuration
    {  RVPV_ALL,     0,         0,                            VMI_ENDIAN_GROUP_PARAM_SPEC(riscvParamValues, endian,                                             RV_GROUP(FUND),  "Model endian")},
    {  RVPV_ALL,     0,         default_enable_expanded,      VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, enable_expanded,         False,                     RV_GROUP(FUND),  "Specify that 48-bit and 64-bit expanded instructions are supported")},
    {  RVPV_ALL,     0,         default_endianFixed,          VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, endianFixed,             False,                     RV_GROUP(FUND),  "Specify that data endianness is fixed (mstatus.{MBE,SBE,UBE} fields are read-only)")},

    // ISA configuration
    {  RVPV_PRE,     0,         default_misa_MXL,             VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, misa_MXL,                1, 1,          2,          RV_GROUP(FUND),  "Override default value of misa.MXL")},
    {  RVPV_PRE,     0,         default_misa_Extensions,      VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, misa_Extensions,         0, 0,          (1<<26)-1,  RV_GROUP(FUND),  "Override default value of misa.Extensions")},
    {  RVPV_PRE,     0,         0,                            VMI_STRING_GROUP_PARAM_SPEC(riscvParamValues, add_Extensions,          "",                        RV_GROUP(FUND),  "Add extensions specified by letters to misa.Extensions (for example, specify \"VD\" to add V and D features)")},
    {  RVPV_PRE,     0,         0,                            VMI_STRING_GROUP_PARAM_SPEC(riscvParamValues, sub_Extensions,          "",                        RV_GROUP(FUND),  "Remove extensions specified by letters from misa.Extensions (for example, specify \"VD\" to remove V and D features)")},
    {  RVPV_ALL,     0,         default_misa_Extensions_mask, VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, misa_Extensions_mask,    0, 0,          (1<<26)-1,  RV_GROUP(FUND),  "Override mask of writable bits in misa.Extensions")},
    {  RVPV_ALL,     0,         0,                            VMI_STRING_GROUP_PARAM_SPEC(riscvParamValues, add_Extensions_mask,     "",                        RV_GROUP(FUND),  "Add extensions specified by letters to mask of writable bits in misa.Extensions (for example, specify \"VD\" to add V and D features)")},
    {  RVPV_ALL,     0,         0,                            VMI_STRING_GROUP_PARAM_SPEC(riscvParamValues, sub_Extensions_mask,     "",                        RV_GROUP(FUND),  "Remove extensions specified by letters from mask of writable bits in misa.Extensions (for example, specify \"VD\" to remove V and D features)")},
    {  RVPV_PRE,     0,         0,                            VMI_STRING_GROUP_PARAM_SPEC(riscvParamValues, add_implicit_Extensions, "",                        RV_GROUP(FUND),  "Add extensions specified by letters to implicitly-present extensions not visible in misa.Extensions")},
    {  RVPV_PRE,     0,         0,                            VMI_STRING_GROUP_PARAM_SPEC(riscvParamValues, sub_implicit_Extensions, "",                        RV_GROUP(FUND),  "Remove extensions specified by letters from implicitly-present extensions not visible in misa.Extensions")},
    {  RVPV_ALL,     0,         default_Zihintntl,            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zihintntl,               False,                     RV_GROUP(EXT),   "Specify that Zihintntl is implemented (instruction decode only, implemented as NOP)")},
    {  RVPV_ALL,     0,         default_Zicond,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zicond,                  False,                     RV_GROUP(EXT),   "Specify that Zicond is implemented")},
    {  RVPV_ALL,     0,         default_Zicsr,                VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zicsr,                   False,                     RV_GROUP(EXT),   "Specify that Zicsr is implemented")},
    {  RVPV_ALL,     0,         default_Zifencei,             VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zifencei,                False,                     RV_GROUP(EXT),   "Specify that Zifencei is implemented")},
    {  RVPV_PRE,     0,         default_Zicbom,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zicbom,                  False,                     RV_GROUP(EXT),   "Specify that Zicbom is implemented")},
    {  RVPV_PRE,     0,         default_Zicbop,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zicbop,                  False,                     RV_GROUP(EXT),   "Specify that Zicbop is implemented")},
    {  RVPV_PRE,     0,         default_Zicboz,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zicboz,                  False,                     RV_GROUP(EXT),   "Specify that Zicboz is implemented")},
    {  RVPV_PRE,     0,         default_Zawrs,                VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zawrs,                   False,                     RV_GROUP(EXT),   "Specify that Zawrs is implemented")},
    {  RVPV_M,       0,         default_Zmmul,                VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zmmul,                   False,                     RV_GROUP(EXT),   "Specify that Zmmul is implemented")},
    {  RVPV_ALL,     0,         default_mvendorid,            VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mvendorid,               0, 0,          -1,         RV_GROUP(CSRDV), "Override mvendorid register")},
    {  RVPV_ALL,     0,         default_marchid,              VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, marchid,                 0, 0,          -1,         RV_GROUP(CSRDV), "Override marchid register")},
    {  RVPV_ALL,     0,         default_mimpid,               VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mimpid,                  0, 0,          -1,         RV_GROUP(CSRDV), "Override mimpid register")},
    {  RVPV_ALL,     0,         default_mhartid,              VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mhartid,                 0, 0,          -1,         RV_GROUP(CSRDV), "Override mhartid register (or first mhartid of an incrementing sequence if this is an SMP variant)")},
    {  RVPV_ALL,     RVPV_1_12, default_mconfigptr,           VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mconfigptr,              0, 0,          -1,         RV_GROUP(CSRDV), "Override mconfigptr register")},
    {  RVPV_ALL,     0,         default_mtvec,                VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mtvec,                   0, 0,          -1,         RV_GROUP(CSRDV), "Override mtvec register")},
    {  RVPV_CLIC,    0,         default_mclicbase,            VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mclicbase,               0, 0,          -1,         RV_GROUP(CLIC),  "Override mclicbase register")},
    {  RVPV_ALL,     RVPV_1_12, default_mseccfg,              VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mseccfg,                 0, 0,          -1,         RV_GROUP(CSRDV), "Override mseccfg register")},
    {  RVPV_FP,      0,         0,                            VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, mstatus_FS,              0, 0,          3,          RV_GROUP(FP),    "Override default value of mstatus.FS (initial state of floating point unit)")},
    {  RVPV_V,       0,         0,                            VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, mstatus_VS,              0, 0,          3,          RV_GROUP(V),     "Override default value of mstatus.VS (initial state of vector unit)")},
    {  RVPV_SnotFP,  0,         default_mstatus_FS_zero,      VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, mstatus_FS_zero,         False,                     RV_GROUP(FP),    "Specify that mstatus.FS is hard-wired to zero")},
    {  RVPV_64,      0,         default_MXL_writable,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, MXL_writable,            False,                     RV_GROUP(CSRMK), "Specify that misa.MXL is writable (feature under development)")},
    {  RVPV_64S,     0,         default_SXL_writable,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, SXL_writable,            False,                     RV_GROUP(CSRMK), "Specify that mstatus.SXL is writable (feature under development)")},
    {  RVPV_64U,     0,         default_UXL_writable,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, UXL_writable,            False,                     RV_GROUP(CSRMK), "Specify that mstatus.UXL is writable (feature under development)")},
    {  RVPV_64H,     0,         default_VSXL_writable,        VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, VSXL_writable,           False,                     RV_GROUP(CSRMK), "Specify that hstatus.VSXL is writable (feature under development)")},
    {  RVPV_V,       0,         default_ELEN,                 VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, ELEN,                    0, ELEN_MIN,   ELEN_MAX,   RV_GROUP(V),     "Override ELEN")},
    {  RVPV_V,       0,         default_SLEN,                 VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, SLEN,                    0, SLEN_MIN,   VLEN_MAX,   RV_GROUP(V),     "Override SLEN (before version 1.0 only)")},
    {  RVPV_V,       0,         default_VLEN,                 VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, VLEN,                    0, SLEN_MIN,   VLEN_MAX,   RV_GROUP(V),     "Override VLEN")},
    {  RVPV_V,       0,         default_EEW_index,            VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, EEW_index,               0, 0,          ELEN_MAX,   RV_GROUP(V),     "Override maximum supported index EEW (use ELEN if zero)")},
    {  RVPV_V,       0,         default_SEW_min,              VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, SEW_min,                 0, SEW_MIN,    ELEN_MAX,   RV_GROUP(V),     "Override minimum supported SEW")},
    {  RVPV_V,       0,         default_agnostic_ones,        VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, agnostic_ones,           False,                     RV_GROUP(V),     "Specify that vector agnostic elements are set to 1")},
    {  RVPV_V,       0,         default_Zvlsseg,              VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvlsseg,                 False,                     RV_GROUP(V),     "Specify that Zvlsseg is implemented")},
    {  RVPV_V,       0,         default_Zvamo,                VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvamo,                   False,                     RV_GROUP(V),     "Specify that Zvamo is implemented")},
    {  RVPV_V,       0,         default_Zvediv,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvediv,                  False,                     RV_GROUP(V),     "Specify that Zvediv is implemented")},
    {  RVPV_V,       0,         default_Zvqmac,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvqmac,                  False,                     RV_GROUP(V),     "Specify that Zvqmac is implemented")},
    {  RVPV_V,       0,         default_Zve32x,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zve32x,                  False,                     RV_GROUP(V),     "Specify that Zve32x is implemented")},
    {  RVPV_V,       0,         default_Zve32f,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zve32f,                  False,                     RV_GROUP(V),     "Specify that Zve32f is implemented")},
    {  RVPV_V,       0,         default_Zve64x,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zve64x,                  False,                     RV_GROUP(V),     "Specify that Zve64x is implemented")},
    {  RVPV_V,       0,         default_Zve64f,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zve64f,                  False,                     RV_GROUP(V),     "Specify that Zve64f is implemented")},
    {  RVPV_V,       0,         default_Zve64d,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zve64d,                  False,                     RV_GROUP(V),     "Specify that Zve64d is implemented")},
    {  RVPV_FV,      0,         default_Zvfh,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvfh,                    False,                     RV_GROUP(V),     "Specify that Zvfh is implemented")},
    {  RVPV_FV,      0,         default_Zvfhmin,              VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvfhmin,                 False,                     RV_GROUP(V),     "Specify that Zvfhfmin is implemented")},
    {  RVPV_FV,      0,         default_Zvfbfmin,             VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvfbfmin,                False,                     RV_GROUP(V),     "Specify that Zvfbfmin is implemented")},
    {  RVPV_BK,      0,         default_Zba,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zba,                     False,                     RV_GROUP(B),     "Specify that Zba is implemented")},
    {  RVPV_BK,      0,         default_Zbb,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbb,                     False,                     RV_GROUP(B),     "Specify that Zbb is implemented")},
    {  RVPV_BK,      0,         default_Zbc,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbc,                     False,                     RV_GROUP(B),     "Specify that Zbc is implemented")},
    {  RVPV_BK,      0,         default_Zbe,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbe,                     False,                     RV_GROUP(B),     "Specify that Zbe is implemented (ignored if version 1.0.0)")},
    {  RVPV_BK,      0,         default_Zbf,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbf,                     False,                     RV_GROUP(B),     "Specify that Zbf is implemented (ignored if version 1.0.0)")},
    {  RVPV_BK,      0,         default_Zbm,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbm,                     False,                     RV_GROUP(B),     "Specify that Zbm is implemented (ignored if version 1.0.0)")},
    {  RVPV_BK,      0,         default_Zbp,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbp,                     False,                     RV_GROUP(B),     "Specify that Zbp is implemented (ignored if version 1.0.0)")},
    {  RVPV_BK,      0,         default_Zbr,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbr,                     False,                     RV_GROUP(B),     "Specify that Zbr is implemented (ignored if version 1.0.0)")},
    {  RVPV_BK,      0,         default_Zbs,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbs,                     False,                     RV_GROUP(B),     "Specify that Zbs is implemented")},
    {  RVPV_BK,      0,         default_Zbt,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbt,                     False,                     RV_GROUP(B),     "Specify that Zbt is implemented (ignored if version 1.0.0)")},
    {  RVPV_K,       0,         default_Zbkb,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbkb,                    False,                     RV_GROUP(K),     "Specify that Zbkb is implemented")},
    {  RVPV_K,       0,         default_Zbkc,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbkc,                    False,                     RV_GROUP(K),     "Specify that Zbkc is implemented")},
    {  RVPV_K,       0,         default_Zbkx,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zbkx,                    False,                     RV_GROUP(K),     "Specify that Zbkx is implemented")},
    {  RVPV_K,       0,         default_Zkr,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zkr,                     False,                     RV_GROUP(K),     "Specify that Zkr is implemented")},
    {  RVPV_K,       0,         default_Zknd,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zknd,                    False,                     RV_GROUP(K),     "Specify that Zknd is implemented")},
    {  RVPV_K,       0,         default_Zkne,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zkne,                    False,                     RV_GROUP(K),     "Specify that Zkne is implemented")},
    {  RVPV_K,       0,         default_Zknh,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zknh,                    False,                     RV_GROUP(K),     "Specify that Zknh is implemented")},
    {  RVPV_K,       0,         default_Zksed,                VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zksed,                   False,                     RV_GROUP(K),     "Specify that Zksed is implemented")},
    {  RVPV_K,       0,         default_Zksh,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zksh,                    False,                     RV_GROUP(K),     "Specify that Zksh is implemented")},
    {  RVPV_KV,      0,         default_Zvkb,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvkb,                    False,                     RV_GROUP(K),     "Specify that Zvkb is implemented")},
    {  RVPV_KV,      0,         default_Zvkg,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvkg,                    False,                     RV_GROUP(K),     "Specify that Zvkg is implemented")},
    {  RVPV_KV,      0,         default_Zvknha,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvknha,                  False,                     RV_GROUP(K),     "Specify that Zvknha is implemented")},
    {  RVPV_KV,      0,         default_Zvknhb,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvknhb,                  False,                     RV_GROUP(K),     "Specify that Zvknhb is implemented")},
    {  RVPV_KV,      0,         default_Zvkns,                VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvkns,                   False,                     RV_GROUP(K),     "Specify that Zvkns is implemented")},
    {  RVPV_KV,      0,         default_Zvksed,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvksed,                  False,                     RV_GROUP(K),     "Specify that Zvksed is implemented")},
    {  RVPV_KV,      0,         default_Zvksh,                VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zvksh,                   False,                     RV_GROUP(K),     "Specify that Zvksh is implemented")},
    {  RVPV_FP,      0,         default_Zfa,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zfa,                     False,                     RV_GROUP(FP),    "Specify that Zfa is implemented (additional floating point instructions)")},
    {  RVPV_FP,      0,         default_Zfh,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zfh,                     False,                     RV_GROUP(FP),    "Specify that Zfh is implemented (IEEE half-precision floating point is supported)")},
    {  RVPV_FP,      0,         default_Zfhmin,               VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zfhmin,                  False,                     RV_GROUP(FP),    "Specify that Zfhmin is implemented (restricted IEEE half-precision floating point is supported)")},
    {  RVPV_K,       0,         default_Zkb,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zkb,                     False,                     RV_GROUP(K),     "Specify that Zkb is implemented (deprecated alias of Zbkb)")},
    {  RVPV_K,       0,         default_Zkg,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zkg,                     False,                     RV_GROUP(K),     "Specify that Zkg is implemented (deprecated alias of Zbkc)")},
    {  RVPV_32P,     0,         default_Zpsfoperand,          VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zpsfoperand,             False,                     RV_GROUP(P),     "Specify that Zpsfoperand is implemented")},
    {  RVPV_FP,      0,         default_Zfinx_version,        VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, Zfinx_version,           ZfinxVariants,             RV_GROUP(FP),    "Specify version of Zfinx implemented (use integer register file for floating point instructions)")},
    {  RVPV_C_CLEG,  0,         default_Zcea_version,         VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, Zcea_version,            ZceaVariants,              RV_GROUP(C),     "Specify version of Zcea implemented (legacy only)")},
    {  RVPV_C_CLEG,  0,         default_Zceb_version,         VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, Zceb_version,            ZcebVariants,              RV_GROUP(C),     "Specify version of Zceb implemented (legacy only)")},
    {  RVPV_C_CLEG,  0,         default_Zcee_version,         VMI_ENUM_GROUP_PARAM_SPEC  (riscvParamValues, Zcee_version,            ZceeVariants,              RV_GROUP(C),     "Specify version of Zcee implemented (legacy only)")},
    {  RVPV_C_CNEW,  0,         default_Zca,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zca,                     False,                     RV_GROUP(C),     "Specify that Zca is implemented")},
    {  RVPV_C_CNEW,  0,         default_Zcb,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zcb,                     False,                     RV_GROUP(C),     "Specify that Zcb is implemented")},
    {  RVPV_C_CNEW,  0,         default_Zcf,                  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zcf,                     False,                     RV_GROUP(C),     "Specify that Zcf is implemented")},
    {  RVPV_C_CCV07, 0,         default_Zcmb,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zcmb,                    False,                     RV_GROUP(C),     "Specify that Zcmb is implemented")},
    {  RVPV_C_CNEW,  0,         default_Zcmp,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zcmp,                    False,                     RV_GROUP(C),     "Specify that Zcmp is implemented")},
    {  RVPV_C_CCV07, 0,         default_Zcmpe,                VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zcmpe,                   False,                     RV_GROUP(C),     "Specify that Zcmpe is implemented")},
    {  RVPV_C_CNEW,  0,         default_Zcmt,                 VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Zcmt,                    False,                     RV_GROUP(C),     "Specify that Zcmt is implemented")},

    // CLIC configuration
    {  RVPV_ROOTPRE, 0,         default_CLICLEVELS,           VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, CLICLEVELS,              0, 0,          256,        RV_GROUP(CLIC),  "Specify number of interrupt levels implemented by CLIC, or 0 if CLIC absent")},
    {  RVPV_CLIC,    0,         default_CLICANDBASIC,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, CLICANDBASIC,            False,                     RV_GROUP(CLIC),  "Whether original basic mode is also implemented")},
    {  RVPV_CLIC,    0,         default_CLICVERSION,          VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, CLICVERSION,             0, 0,          255,        RV_GROUP(CLIC),  "Specify CLIC version")},
    {  RVPV_CLIC,    0,         default_CLICINTCTLBITS,       VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, CLICINTCTLBITS,          2, 2,          8,          RV_GROUP(CLIC),  "Specify number of bits implemented in clicintctl[i]")},
    {  RVPV_CLIC_NM, 0,         default_CLICCFGMBITS,         VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, CLICCFGMBITS,            0, 0,          0,          RV_GROUP(CLIC),  "Specify number of bits implemented for cliccfg.nmbits (also defines CLICPRIVMODES)")},
    {  RVPV_CLIC,    0,         default_CLICCFGLBITS,         VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, CLICCFGLBITS,            0, 0,          8,          RV_GROUP(CLIC),  "Specify number of bits implemented for cliccfg.nlbits")},
    {  RVPV_CLIC,    0,         default_CLICSELHVEC,          VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, CLICSELHVEC,             False,                     RV_GROUP(CLIC),  "Whether selective hardware vectoring supported")},
    {  RVPV_CLIC,    0,         default_CLICXNXTI,            VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, CLICXNXTI,               False,                     RV_GROUP(CLIC),  "Whether xnxti CSRs implemented")},
    {  RVPV_CLIC,    0,         default_CLICXCSW,             VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, CLICXCSW,                False,                     RV_GROUP(CLIC),  "Whether xscratchcsw/xscratchcswl CSRs implemented")},
    {  RVPV_CLIC,    0,         default_INTTHRESHBITS,        VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, INTTHRESHBITS,           1, 8,          8,          RV_GROUP(CLIC),  "Specify number of bits implemented in xintthresh.th")},
    {  RVPV_CLIC,    0,         default_externalCLIC,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, externalCLIC,            False,                     RV_GROUP(CLIC),  "Whether CLIC is implemented externally (if False, then use implementation in this model)")},
    {  RVPV_CLIC,    0,         default_tvt_undefined,        VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, tvt_undefined,           False,                     RV_GROUP(CLIC),  "Specify that mtvt, stvt and utvt CSRs are undefined")},
    {  RVPV_CLIC,    0,         default_intthresh_undefined,  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, intthresh_undefined,     False,                     RV_GROUP(CLIC),  "Specify that mintthreash, sintthresh and uintthresh CSRs are undefined")},
    {  RVPV_CLIC,    0,         default_mclicbase_undefined,  VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, mclicbase_undefined,     False,                     RV_GROUP(CLIC),  "Specify that mclicbase CSR is undefined")},
    {  RVPV_CLIC,    0,         default_CSIP_present,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, CSIP_present,            False,                     RV_GROUP(CLIC),  "Specify that edge-triggered CSIP interrupt is present")},
    {  RVPV_CLIC,    0,         default_nlbits_valid,         VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, nlbits_valid,            0, 0,          0,          RV_GROUP(CLIC),  "Mask of valid cliccfg.nlbits values (for example, 0x101 implies cliccfg.nlbits may be 0 or 8 only)")},
    {  RVPV_CLIC,    0,         default_posedge_0_63,         VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, posedge_0_63,            0, 0,          0,          RV_GROUP(CLIC),  "Mask of interrupts 0 to 63 that are fixed positive edge triggered")},
    {  RVPV_CLIC,    0,         default_poslevel_0_63,        VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, poslevel_0_63,           0, 0,          0,          RV_GROUP(CLIC),  "Mask of interrupts 0 to 63 that are fixed positive level triggered")},
    {  RVPV_CLIC,    0,         default_posedge_other,        VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, posedge_other,           False,                     RV_GROUP(CLIC),  "Whether interrupts 64 and above are fixed positive edge triggered")},
    {  RVPV_CLIC,    0,         default_poslevel_other,       VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, poslevel_other,          False,                     RV_GROUP(CLIC),  "Whether interrupts 64 and above are fixed positive level triggered")},

    // AIA configuration
    {  RVPV_PRE,     0,         default_Smaia,                VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, Smaia,                   False,                     RV_GROUP(AIA),   "Specify that Smaia CSRs are present")},
    {  RVPV_SMAIA,   0,         default_IPRIOLEN,             VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, IPRIOLEN,                0,           1, 8,         RV_GROUP(AIA),   "Specify AIA IPRIOLEN")},
    {  RVPV_SMAIA_H, 0,         default_HIPRIOLEN,            VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, HIPRIOLEN,               0,           6, 8,         RV_GROUP(AIA),   "Specify AIA HIPRIOLEN")},
    {  RVPV_SMAIA,   0,         default_IMSIC_present,        VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, IMSIC_present,           False,                     RV_GROUP(AIA),   "Specify that IMSIC CSRs are present (must be implemented externally using CSR bus)")},
    {  RVPV_SMAIA,   0,         default_mvip_mask,            VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mvip_mask,               0,           0, -1,        RV_GROUP(AIA),   "Specify hardware-enforced mask of writable bits in mvip register")},
    {  RVPV_SMAIA,   0,         default_mvien_mask,           VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, mvien_mask,              0,           0, -1,        RV_GROUP(AIA),   "Specify hardware-enforced mask of writable bits in mvien register")},
    {  RVPV_SMAIA_H, 0,         default_hvien_mask,           VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, hvien_mask,              0,           0, -1,        RV_GROUP(AIA),   "Specify hardware-enforced mask of writable bits in hvien register")},
    {  RVPV_SMAIA,   0,         default_miprio_mask,          VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, miprio_mask,             0,           0, -1,        RV_GROUP(AIA),   "Specify mask of writable entries in AIA M-mode iprio array")},
    {  RVPV_SMAIA_S, 0,         default_siprio_mask,          VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, siprio_mask,             0,           0, -1,        RV_GROUP(AIA),   "Specify mask of writable entries in AIA S-mode iprio array")},
    {  RVPV_SMAIA_H, 0,         default_hviprio_mask,         VMI_UNS64_GROUP_PARAM_SPEC (riscvParamValues, hviprio_mask,            0,           0, -1,        RV_GROUP(AIA),   "Specify mask of writable entries in emulated AIA VS-mode iprio array (accessed via hviprio CSRs")},
    {  RVPV_SMAIA_H, 0,         default_hvictl_IID_bits,      VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, hvictl_IID_bits,         0,           6, 12,        RV_GROUP(AIA),   "Specify implemented bits in hvictl.IID")},

    // Hypervisor configuration
    {  RVPV_H,       0,         default_GEILEN,               VMI_UNS32_GROUP_PARAM_SPEC (riscvParamValues, GEILEN,                  0, 0,          0,          RV_GROUP(H),     "Specify number of guest external interrupts")},
    {  RVPV_H,       0,         default_xtinst_basic,         VMI_BOOL_GROUP_PARAM_SPEC  (riscvParamValues, xtinst_basic,            False,                     RV_GROUP(H),     "Specify that only pseudo-instructions are reported by htinst/mtinst")},

    // KEEP LAST
    {  RVPV_ALL,     0,         0,                            VMI_END_PARAM}
};

//
// Return any parent of the passed processor
//
inline static riscvP getParent(riscvP riscv) {
    return riscv ? (riscvP)vmirtGetSMPParent((vmiProcessorP)riscv) : 0;
}

//
// Is the processor a member of an SMP?
//
static Bool isSMPMember(riscvP riscv) {

    riscvP parent = getParent(riscv);

    return (parent && !riscvIsCluster(parent));
}

//
// Should this configuration be presented as a public one?
//
inline static Bool selectConfig(riscvConfigCP cfg) {
    return True;
}

//
// Should this parameter be presented as a pre-parameter?
//
static Bool selectPreParameter(riscvP riscv, riscvParameterP param) {

    // ignore all parameters except variant and explicit pre-parameters
    if(!(param->variant & (RVPV_VARIANT|RVPV_PRE))) {
        return False;
    }

    // handle parameters present at root level only
    if((param->variant & RVPV_ROOT) && getParent(riscv)) {
        return False;
    }

    return True;
}

//
// Parse the index from the PMP parameter name. Expected names are:
//   pmpaddr<n>
//   pmpcfg<n>
//   mask_pmpcfg<n>
//   mask_pmpaddr<n>
// Note: the pmpcfg registers each contain four entries, so the register
//       index is adjusted to return the first element's index
//
static Uns32 pmpIndex(riscvParameterP param) {
    Uns32       index = 0;
    const char *pmpstr = strstr(param->parameter.name, "pmp");

    if (pmpstr) {
        if (sscanf(pmpstr, "pmpaddr%d", &index) != 1) {
            if (sscanf(pmpstr, "pmpcfg%d", &index) == 1) {
                index *= 4;
            }
        }
    }

    return index;
}

//
// Should this parameter be presented as a public one for the selected variant?
//
static Bool selectParameter(
    riscvP          riscv,
    riscvConfigCP   cfg,
    riscvParameterP param
) {
    if(cfg) {

        // use architecture from configuration (or assume all features are
        // present if this is a cluster)
        riscvArchitecture arch = cfg->arch ? : -1;

        // ignore parameters specific to later privileged versions
        if(param->minPV>cfg->priv_version) {
            return False;
        }

        // cluster-specific parameters are only used by clusters
        if(param->variant & RVPV_CLUSTER) {
            return cfg->members;
        }

        // handle parameters present at root level only
        if((param->variant & RVPV_ROOT) && getParent(riscv)) {
            return False;
        }

        // cluster exposes only variant and root parameters
        if(!(param->variant & (RVPV_VARIANT|RVPV_ROOT)) && cfg->members) {
            return False;
        }

        // include parameters that are only required for multicore variants
        if(param->variant & RVPV_MPCORE) {
            return cfg->numHarts;
        }

        // include parameters that are only required when floating-point is
        // present
        if((param->variant & RVPV_FP) && !(arch&ISA_DF)) {
            return False;
        }

        // include parameters that are only required when compressed
        // instructions are present
        if((param->variant & RVPV_C) && !(arch&ISA_C)) {
            return False;
        }

        // include parameters that are only required when double floating-point
        // is present
        if((param->variant & RVPV_D) && !(arch&ISA_D)) {
            return False;
        }

        // include parameters that are only required when atomic extension is
        // present
        if((param->variant & RVPV_A) && !(arch&ISA_A)) {
            return False;
        }

        // include parameters that are only required when crypto extension is
        // present
        if((param->variant & RVPV_K) && !(arch&ISA_K)) {
            return False;
        }

        // include parameters that are only required when DSP extension is
        // present
        if((param->variant & RVPV_P) && !(arch&ISA_P)) {
            return False;
        }

        // include parameters that are only required when bitmanip or crypto
        // extension is present
        if((param->variant & RVPV_BK) && !(arch&(ISA_B|ISA_K))) {
            return False;
        }

        // include parameters that are only required for 32-bit architecture
        if((param->variant & RVPV_32) && !(arch&ISA_XLEN_32)) {
            return False;
        }

        // include parameters that are only required for 64-bit architecture
        if((param->variant & RVPV_64) && !(arch&ISA_XLEN_64)) {
            return False;
        }

        // include parameters that are only required when Supervisor mode is
        // present
        if((param->variant & RVPV_S) && !(arch&ISA_S)) {
            return False;
        }

        // include parameters that are only required when Supervisor mode is
        // present and floating-point is absent
        if((param->variant & RVPV_SnotFP) && ((arch&ISA_DFS)!=ISA_S)) {
            return False;
        }

        // include parameters that are only required when User mode is
        // present
        if((param->variant & RVPV_U) && !(arch&ISA_U)) {
            return False;
        }

        // include parameters that are only required when Hypervisor mode is
        // present
        if((param->variant & RVPV_H) && !(arch&ISA_H)) {
            return False;
        }

        // include parameters that are only required when User mode interrupts
        // are implemented
        if((param->variant & RVPV_N) && !(arch&ISA_N)) {
            return False;
        }

        // include parameters that are only required when M extension is
        // implemented
        if((param->variant & RVPV_M) && !(arch&ISA_M)) {
            return False;
        }

        // include parameters that are only required when Vector extension is
        // implemented
        if((param->variant & RVPV_V) && !(arch&ISA_V)) {
            return False;
        }

        // include parameters that are only required when CLICCFGMBITS can be
        // non-zero
        if((param->variant & RVPV_NMBITS) && !getCLICCFGMBITSMax(cfg)) {
            return False;
        }

        if(param->variant & RVPV_DBGT) {

            // include parameters that are only required when debug mode or
            // triggers are implemented
            if(!(cfg->debug_mode || cfg->trigger_num)) {
                return False;
            }

        } else {

            // include parameters that are only required when debug mode is
            // implemented
            if((param->variant & RVPV_DEBUG) && !cfg->debug_mode) {
                return False;
            }

            // include parameters that are only required when triggers are
            // implemented
            if((param->variant & RVPV_TRIG) && !cfg->trigger_num) {
                return False;
            }
        }

        // include parameters that are only required when RNMI is implemented
        if((param->variant & RVPV_RNMI) && !cfg->rnmi_version) {
            return False;
        }

        // include parameters that are only required when CLIC is implemented
        if((param->variant & RVPV_CLIC) && !cfg->CLICLEVELS) {
            return False;
        }

        // include parameters that are only required when CLINT or time CSR are
        // implemented
        if((param->variant & RVPV_TIMER) && !cfg->CLINT_address && cfg->time_undefined) {
            return False;
        }

        // include parameters that are only required for Zicbom/Zicbop
        if((param->variant & RVPV_CMOMP) && !(cfg->Zicbom || cfg->Zicbop)) {
            return False;
        }

        // include parameters that are only required for Zicboz
        if((param->variant & RVPV_CMOZ) && !cfg->Zicboz) {
            return False;
        }

        // include parameters that are only required for legacy C extension
        if((param->variant & RVPV_CLEG) && cfg->compress_version) {
            return False;
        }

        // include parameters that are only required for new C extension
        if((param->variant & RVPV_CNEW) && !cfg->compress_version) {
            return False;
        }

        // include parameters that are only required for C extension versions
        // 0.70.x
        if((param->variant & RVPV_CV07) && (cfg->compress_version>=RVCV_1_0_0_RC57)) {
            return False;
        }

        // include parameters that are only required for Smaia extension
        if((param->variant & RVPV_SMAIA) && !cfg->Smaia) {
            return False;
        }

        // include parameters that are only required when WFI is not a NOP
        if((param->variant & RVPV_WFI) && cfg->wfi_is_nop) {
            return False;
        }

        // include parameters that are only required for Zawrs extension
        if((param->variant & RVPV_ZAWRS) && !cfg->Zawrs) {
            return False;
        }

        // include parameters that are enabled by PMP_xxxparams parameter
        // if the index is in range of the configured number of PMP entries
        // NOTE: cfg->PMP_registers cannot be a pre-param, so instead use the
        //       max registers allowed based on the pre-param priv_version
        if((param->variant & RVPV_PMPINIT) &&
           (!cfg->PMP_initialparams || pmpIndex(param) >= max_PMP_registers(cfg))) {
                return False;
        }
        if((param->variant & RVPV_PMPMASK) &&
            (!cfg->PMP_maskparams || pmpIndex(param) >= max_PMP_registers(cfg))) {
            return False;
        }
    }

    return True;
}

//
// Count the number of visible variants
//
static Uns32 countVariants(riscvConfigCP cfg) {

    Uns32 i = 0;

    while(cfg->name) {
        i++;
        cfg++;
    }

    return i;
}

//
// Count the number of visible pre-parameters
//
static Uns32 countPreParameters(riscvP riscv, riscvParameterP param) {

    Uns32 i = 0;

    while(param->parameter.name) {

        if(selectPreParameter(riscv, param)) {
            i++;
        }

        param++;
    }

    return i;
}

//
// Count the number of visible parameters
//
static Uns32 countParameters(
    riscvP          riscv,
    riscvConfigCP   cfg,
    riscvParameterP param
) {
    Uns32 i = 0;

    while(param->parameter.name) {

        if(selectParameter(riscv, cfg, param)) {
            i++;
        }

        param++;
    }

    return i;
}

//
// Create configuration list applicable to the indicated variant, or a superset
// configuration list of no variant is specified
//
static vmiEnumParameterP createVariantList(riscvP riscv) {

    riscvConfigCP     cfgList = riscvGetConfigList(riscv);
    riscvConfigCP     cfg;
    vmiEnumParameterP result;
    vmiEnumParameterP prm;
    Uns32             i;

    // count the number of entries in the variant list
    Uns32 entries = countVariants(cfgList);

    // allocate the variant list, including NULL terminator
    result = STYPE_CALLOC_N(vmiEnumParameter, entries+1);

    // fill visible entries in the variant list
    for(i=0, prm=result, cfg=cfgList; cfg->name; i++, cfg++) {

        if(selectConfig(cfg)) {

            prm->name  = cfg->name;
            prm->value = i;

            prm++;
        }
    }

    // return resulting list
    return result;
}

//
// Create pre-parameter list
//
static vmiParameterP createPreParameterList(riscvP riscv, riscvConfigCP first) {

    riscvParameterP src = parameters;
    vmiParameterP   dst;
    vmiParameterP   result;
    Uns32           i;

    // count the number of entries in the parameter list
    Uns32 entries = countPreParameters(riscv, src);

    // allocate the pre-parameter list, including NULL terminator
    result = STYPE_CALLOC_N(vmiParameter, entries+1);

    for(i=0, dst=result; src->parameter.name; i++, src++) {

        if(selectPreParameter(riscv, src)) {

            *dst = src->parameter;

            // fill variant list
            if(src->variant & RVPV_VARIANT) {
                dst->u.enumParam.legalValues = riscv->variantList;
            }

            // override default if required
            if(src->defaultCB) {
                src->defaultCB(first, dst);
            }

            dst++;
        }
    }

    // return resulting list
    return result;
}

//
// Create parameter list applicable to the indicated variant
//
static vmiParameterP createParameterList(riscvP riscv, riscvConfigCP cfg) {

    riscvParameterP src = parameters;
    vmiParameterP   dst;
    vmiParameterP   result;
    Uns32           i;

    // create default cluster variants string
    riscv->clusterVariants = riscvNewClusterVariantString(riscv);

    // count the number of entries in the parameter list
    Uns32 entries = countParameters(riscv, cfg, src);

    // allocate the parameter list, including NULL terminator
    result = STYPE_CALLOC_N(vmiParameter, entries+1);

    for(i=0, dst=result; src->parameter.name; i++, src++) {

        if(selectParameter(riscv, cfg, src)) {

            *dst = src->parameter;

            // fill variant list
            if(src->variant & RVPV_VARIANT) {
                dst->u.enumParam.legalValues = riscv->variantList;
            }

            // fill member variants if required
            if(src->variant & RVPV_CLUSTER) {
                dst->u.stringParam.defaultValue = riscv->clusterVariants;
            }

            // override default if required
            if(src->defaultCB) {
                src->defaultCB(cfg, dst);
            }

            dst++;
        }
    }

    // return resulting list
    return result;
}

//
// Refine variant if this is a cluster member
//
static const char *refineVariant(riscvP riscv, const char *variant) {

    if(riscv && riscvIsClusterMember(riscv)) {
        variant = riscvGetMemberVariant(riscv);
    }

    return variant;
}

//
// Function to iterate the pre-parameter specifications
//
VMI_PROC_PARAM_SPECS_FN(riscvGetPreParamSpec) {

    riscvP riscv = (riscvP)processor;

    if(isSMPMember(riscv)) {

        // allow parameterization of clusters and root level objects only
        return 0;

    } else if(!prev) {

        riscvConfigCP cfgList = riscvGetConfigList(riscv);

        // if this is a cluster member, use the member configuration to fill
        // parameters
        if(riscvIsClusterMember(riscv)) {
            cfgList = riscvGetNamedConfig(cfgList, riscvGetMemberVariant(riscv));
        }

        // fill variants and create pre-parameter list
        riscv->variantList = createVariantList(riscv);
        riscv->parameters  = createPreParameterList(riscv, cfgList);

        // return first pre-parameter
        return riscv->parameters;

    } else {

        // return next pre-parameter
        vmiParameterP this = prev+1;
        return this && this->name ? this : 0;
    }
}

//
// Append extensions in the given list to the name, prefixed by the operation
// character
//
static void appendExtensions(char *name, riscvArchitecture arch, char op) {

    if(arch) {

        char *tail = name + strlen(name);
        char  extension;

        // append operation
        *tail++ = op;

        // append modified architectural settings
        for(extension='A'; arch; arch>>=1, extension++) {
            if(arch&1) {
                *tail++ = extension;
            }
        }

        // terminate string
        *tail++ = 0;
    }
}

//
// Apply pre-parameter value if it has been set (if not, leave as per-variant
// default)
//
#define APPLY_PREPARAM_IF_SET(_PROC, _PARAMS, _NAME) { \
    if(_PARAMS->SETBIT(_NAME)) {                    \
        _PROC->configInfo._NAME = params->_NAME;    \
    }                                               \
}

//
// Apply pre-parameter value if it has been set (if not, leave as per-variant
// default) and then handle any deprecated version remappings
//
#define APPLY_PREPARAM_IF_SET_REMAP(_PROC, _PARAMS, _NAME, _REMAP) { \
    APPLY_PREPARAM_IF_SET(_PROC, _PARAMS, _NAME);                       \
    _PROC->configInfo._NAME = _REMAP[_PROC->configInfo._NAME].value;    \
}

//
// Return arch modified so that it is self-consistent
//
inline static riscvArchitecture fixArch(riscvArchitecture arch) {

    // S extension implies U extension, and N extension requires U extension
    if(arch&ISA_S) {
        arch |= ISA_U;
    } else if(!(arch&ISA_U)) {
        arch &= ~ISA_N;
    }

    return arch;
}

//
// Function to apply pre-parameter values
//
VMI_SET_PARAM_VALUES_FN(riscvGetPreParamValues) {

    riscvP        riscv   = (riscvP)processor;
    riscvConfigCP cfgList = riscvGetConfigList(riscv);

    if(isSMPMember(riscv)) {

        // no action - all parameters for SMP processors are specified at the
        // SMP level, and the hart-specific mhartid parameter specifies the
        // *first* index of an incrementing sequence in this case

    } else {

        // get raw variant
        riscvParamValuesP params  = (riscvParamValuesP)parameterValues;
        riscvConfigCP     match   = cfgList + params->variant;

        // delete pre-parameter definitions
        STYPE_FREE(riscv->parameters);

        // refine variant in cluster if required
        const char *variant = refineVariant(riscv, match->name);
        riscv->configInfo = *riscvGetNamedConfig(cfgList, variant);

        // override architecture versions if required
        APPLY_PREPARAM_IF_SET_REMAP(riscv, params, user_version, userVariants);
        APPLY_PREPARAM_IF_SET_REMAP(riscv, params, priv_version, privVariants);

        // old and new misa architecture
        riscvArchitecture archExplicit = riscv->configInfo.arch;
        riscvArchitecture archImplicit = riscv->configInfo.archImplicit;
        riscvArchitecture oldArch      = fixArch(archExplicit|archImplicit);
        riscvArchitecture newArch      = oldArch;

        // apply misa_Extensions override if required
        if(SETBIT(params->misa_Extensions)) {
            newArch = params->misa_Extensions | (newArch & (-1 << XLEN_SHIFT));
        }

        // apply sub_Extensions and add_Extensions overrides if required
        newArch &= ~riscvParseExtensions(params->sub_Extensions);
        newArch |=  riscvParseExtensions(params->add_Extensions);

        // apply sub_implicit_Extensions and add_implicit_Extensions overrides
        archImplicit &= ~riscvParseExtensions(params->sub_implicit_Extensions);
        archImplicit |=  riscvParseExtensions(params->add_implicit_Extensions);

        // include implicit features in full list
        newArch |= archImplicit;

        // ensure result is self-consistent
        newArch = fixArch(newArch);

        // update variant to show modified extensions if required
        if(oldArch!=newArch) {

            char tmp[strlen(variant)+32];

            // seed new name
            strcpy(tmp, variant);

            // append removed and added extensions
            appendExtensions(tmp, oldArch&~newArch, '-');
            appendExtensions(tmp, newArch&~oldArch, '+');

            // set variant name
            vmirtSetProcessorVariant(processor, tmp);
        }

        // apply updated architecture
        riscv->configInfo.arch         = newArch;
        riscv->configInfo.archImplicit = archImplicit;

        // H extension requires privileged version 1.12 or later (for mstatush)
        if((newArch&ISA_H) && (riscv->configInfo.priv_version<RVPV_1_12)) {
            riscv->configInfo.priv_version = RVPV_1_12;
        }

        // force CLICLEVELS to valid value
        if(params->CLICLEVELS==1) {
            vmiMessage("W", CPU_PREFIX"_ICL",
                "Illegal CLICLEVELS=1 specified; using CLICLEVELS=2"
            );
            params->CLICLEVELS = 2;
        }

        // apply CLICLEVELS override if required
        APPLY_PREPARAM_IF_SET(riscv, params, CLICLEVELS);

        // apply debug_mode override if required
        APPLY_PREPARAM_IF_SET_REMAP(riscv, params, debug_mode, DMModes);

        // apply trigger_num override if required
        APPLY_PREPARAM_IF_SET(riscv, params, trigger_num);

        // apply rnmi_version override if required
        APPLY_PREPARAM_IF_SET_REMAP(riscv, params, rnmi_version, rnmiVariants);

        // apply CLINT_address override if required
        APPLY_PREPARAM_IF_SET(riscv, params, CLINT_address);

        // apply Zicbom/Zicbop/Zicboz overrides if required
        APPLY_PREPARAM_IF_SET(riscv, params, Zicbom);
        APPLY_PREPARAM_IF_SET(riscv, params, Zicbop);
        APPLY_PREPARAM_IF_SET(riscv, params, Zicboz);

        // apply PMP_*params/registers overrides if required
        APPLY_PREPARAM_IF_SET(riscv, params, PMP_maskparams);
        APPLY_PREPARAM_IF_SET(riscv, params, PMP_initialparams);
        APPLY_PREPARAM_IF_SET(riscv, params, PMP_registers);

        // apply compress_version override if required
        APPLY_PREPARAM_IF_SET(riscv, params, compress_version);

        // apply wfi_is_nop override if required
        APPLY_PREPARAM_IF_SET(riscv, params, wfi_is_nop);

        // apply Zawrs override if required
        APPLY_PREPARAM_IF_SET(riscv, params, Zawrs);

        // apply AIA Smaia override if required
        APPLY_PREPARAM_IF_SET(riscv, params, Smaia);

        // apply time_undefined override if required
        APPLY_PREPARAM_IF_SET(riscv, params, time_undefined);

        // create full parameter list
        riscv->parameters = createParameterList(riscv, &riscv->configInfo);
    }
}

//
// Get the size of the parameter values table
//
VMI_PROC_PARAM_TABLE_SIZE_FN(riscvParamValueSize) {

    return sizeof(riscvParamValues);
}

//
// Function to iterate the parameter specifications
//
VMI_PROC_PARAM_SPECS_FN(riscvGetParamSpec) {

    riscvP        riscv = (riscvP)processor;
    vmiParameterP this  = prev ? prev+1 : riscv->parameters;

    return this && this->name ? this : 0;
}

//
// Free parameter definitions
//
void riscvFreeParameters(riscvP riscv) {

    if(riscv->variantList) {
        STYPE_FREE(riscv->variantList);
    }

    if(riscv->parameters) {
        STYPE_FREE(riscv->parameters);
    }
}

//
// Return Privileged Architecture description
//
const char *riscvGetPrivVersionDesc(riscvP riscv) {
    return privVariants[RISCV_PRIV_VERSION(riscv)].description;
}

//
// Return User Architecture description
//
const char *riscvGetUserVersionDesc(riscvP riscv) {
    return userVariants[RISCV_USER_VERSION(riscv)].description;
}

//
// Return Vector Architecture description
//
const char *riscvGetVectorVersionDesc(riscvP riscv) {
    return vectorVariants[RISCV_VECT_VERSION(riscv)].description;
}

//
// Return Compressed Architecture description
//
const char *riscvGetCompressedVersionDesc(riscvP riscv) {
    return compressedVariants[RISCV_COMPRESS_VERSION(riscv)].description;
}

//
// Return Bit Manipulation Architecture description
//
const char *riscvGetBitManipVersionDesc(riscvP riscv) {
    return bitmanipVariants[RISCV_BITMANIP_VERSION(riscv)].description;
}

//
// Return Hypervisor Architecture description
//
const char *riscvGetHypervisorVersionDesc(riscvP riscv) {
    return hypervisorVariants[RISCV_HYP_VERSION(riscv)].description;
}

//
// Return Cryptographic Architecture description
//
const char *riscvGetCryptographicVersionDesc(riscvP riscv) {
    return cryptoVariants[RISCV_CRYPTO_VERSION(riscv)].description;
}

//
// Return Vector Cryptographic Architecture description
//
const char *riscvGetVCryptographicVersionDesc(riscvP riscv) {
    return vcryptoVariants[RISCV_VCRYPTO_VERSION(riscv)].description;
}

//
// Return DSP Architecture description
//
const char *riscvGetDSPVersionDesc(riscvP riscv) {
    return DSPVariants[RISCV_DSP_VERSION(riscv)].description;
}

//
// Return Debug Architecture description
//
const char *riscvGetDebugVersionDesc(riscvP riscv) {
    return debugVariants[RISCV_DBG_VERSION(riscv)].description;
}

//
// Return RNMI Architecture name
//
const char *riscvGetRNMIVersionName(riscvP riscv) {
    return rnmiVariants[RISCV_RNMI_VERSION(riscv)].name;
}

//
// Return Smepmp Architecture name
//
const char *riscvGetSmepmpVersionName(riscvP riscv) {
    return SmepmpVariants[RISCV_SMEPMP_VERSION(riscv)].name;
}

//
// Return CLIC description
//
const char *riscvGetCLICVersionDesc(riscvP riscv) {
    return CLICVariants[RISCV_CLIC_VERSION(riscv)].description;
}

//
// Return AIA description
//
const char *riscvGetAIAVersionDesc(riscvP riscv) {
    return AIAVariants[RISCV_AIA_VERSION(riscv)].description;
}

//
// Return Zfinx version description
//
const char *riscvGetZfinxVersionDesc(riscvP riscv) {
    return ZfinxVariants[Zfinx(riscv)].description;
}

//
// Return Zcea version name
//
const char *riscvGetZceaVersionName(riscvP riscv) {
    return ZceaVariants[Zcea(riscv)].name;
}

//
// Return Zceb version name
//
const char *riscvGetZcebVersionName(riscvP riscv) {
    return ZcebVariants[Zceb(riscv)].name;
}

//
// Return Zcee version name
//
const char *riscvGetZceeVersionName(riscvP riscv) {
    return ZceeVariants[Zcee(riscv)].name;
}

//
// Return 16-bit floating point description
//
const char *riscvGetFP16VersionDesc(riscvP riscv) {
    return fp16Variants[RISCV_FP16_VERSION(riscv)].description;
}

//
// Return mstatus.FS mode name
//
const char *riscvGetFSModeName(riscvP riscv) {
    return FSModes[RISCV_FS_MODE(riscv)].name;
}

