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

// model header files
#include "riscvConfig.h"
#include "riscvVariant.h"


//
// Specify named variant
//
#define RISC_VARIANT(_NAME, _PMP_REGS, _Zfinx, _Zcea, _Zceb, _Zcee, _ARCH) { \
    .name                = _NAME,                                   \
    .arch                = _ARCH,                                   \
    .archMask            = RV_ARCH_MASK_DEFAULT,                    \
    .counteren_mask      = -1,                                      \
    .user_version        = RVUV_DEFAULT,                            \
    .priv_version        = RVPV_DEFAULT,                            \
    .bitmanip_version    = RVBV_DEFAULT,                            \
    .compress_version    = RVCV_DEFAULT,                            \
    .crypto_version      = RVKV_DEFAULT,                            \
    .vcrypto_version     = RVKVV_DEFAULT,                           \
    .hyp_version         = RVHV_DEFAULT,                            \
    .vect_version        = RVVV_DEFAULT,                            \
    .dbg_version         = RVDBG_DEFAULT,                           \
    .CLIC_version        = RVCLC_DEFAULT,                           \
    .AIA_version         = RVAIA_DEFAULT,                           \
    .debug_priority      = RVDP_DEFAULT,                            \
    .CLICSELHVEC         = True,                                    \
    .CSIP_present        = True,                                    \
    .Zvlsseg             = 1,                                       \
    .Zvamo               = 1,                                       \
    .Zvediv              = 0,                                       \
    .Zvqmac              = 1,                                       \
    .Zfinx_version       = _Zfinx ? RVZFINX_DEFAULT : RVZFINX_NA,   \
    .Zcea_version        = _Zcea  ? RVZCEA_DEFAULT  : RVZCEA_NA,    \
    .Zceb_version        = _Zceb  ? RVZCEB_DEFAULT  : RVZCEB_NA,    \
    .Zcee_version        = _Zcee  ? RVZCEE_DEFAULT  : RVZCEE_NA,    \
    .PMP_registers       = _PMP_REGS,                               \
    .tval_ii_code        = True,                                    \
    .ASID_bits           = ((_ARCH)&RV64) ? 16 : 9,                 \
    .VMID_bits           = ((_ARCH)&RV64) ? 14 : 7,                 \
    .numHarts            = RV_NUMHARTS_0,                           \
    .trigger_num         = 4,                                       \
    .tinfo               = 0x100807d,  /* types 0, 2-6, 15 */       \
    .trigger_match       = 0x333f, /* types 0-5, 8, 9, 12, 13 */    \
    .mcontext_bits       = ((_ARCH)&RV64) ? 13 : 6,                 \
    .scontext_bits       = ((_ARCH)&RV64) ? 34 : 16,                \
    .mvalue_bits         = ((_ARCH)&RV64) ? 13 : 6,                 \
    .svalue_bits         = ((_ARCH)&RV64) ? 34 : 16,                \
    .mcontrol_maskmax    = 63,                                      \
    .posedge_0_63        = 0x000f,                                  \
    .amo_constraint      = RVMC_USER1,                              \
    .lr_sc_constraint    = RVMC_USER1,                              \
    .push_pop_constraint = RVMC_USER2,                              \
}

//
// Specify named profile variant
//
#define RISC_PROFILE(_NAME, _Zic, _Zfhmin, _Svpbmt, _Svinval, _UV, _PV, _ARCH) { \
    .name                = _NAME,                                   \
    .arch                = _ARCH,                                   \
    .archMask            = RV_ARCH_MASK_DEFAULT,                    \
    .counteren_mask      = -1,                                      \
    .user_version        = _UV,                                     \
    .priv_version        = _PV,                                     \
    .bitmanip_version    = RVBV_DEFAULT,                            \
    .compress_version    = RVCV_DEFAULT,                            \
    .crypto_version      = RVKV_DEFAULT,                            \
    .vcrypto_version     = RVKVV_DEFAULT,                           \
    .hyp_version         = RVHV_DEFAULT,                            \
    .vect_version        = RVVV_DEFAULT,                            \
    .dbg_version         = RVDBG_DEFAULT,                           \
    .CLIC_version        = RVCLC_DEFAULT,                           \
    .AIA_version         = RVAIA_DEFAULT,                           \
    .debug_priority      = RVDP_DEFAULT,                            \
    .bitmanip_absent     = ~(RVBS_Zba|RVBS_Zbb|RVBS_Zbs),           \
    .Sv_modes            = ((1<<0)+(1<<8)),                         \
    .Svpbmt              = _Svpbmt,                                 \
    .Svinval             = _Svinval,                                \
    .updatePTEA          = False,                                   \
    .updatePTED          = False,                                   \
    .lr_sc_grain         = 64,                                      \
    .unaligned           = True,                                    \
    .unalignedV          = True,                                    \
    .CLICSELHVEC         = True,                                    \
    .CSIP_present        = True,                                    \
    .Zicbom              = _Zic,                                    \
    .Zicbop              = _Zic,                                    \
    .Zicboz              = _Zic,                                    \
    .cmomp_bytes         = 64,                                      \
    .cmoz_bytes          = 64,                                      \
    .Zfhmin              = _Zfhmin,                                 \
    .Zvlsseg             = 1,                                       \
    .Zvamo               = 1,                                       \
    .Zvediv              = 0,                                       \
    .Zvqmac              = 0,                                       \
    .PMP_registers       = 0,                                       \
    .tval_ii_code        = True,                                    \
    .ASID_bits           = ((_ARCH)&RV64) ? 16 : 9,                 \
    .VMID_bits           = ((_ARCH)&RV64) ? 14 : 7,                 \
    .numHarts            = RV_NUMHARTS_0,                           \
    .posedge_0_63        = 0x000f,                                  \
    .amo_constraint      = RVMC_USER1,                              \
    .lr_sc_constraint    = RVMC_USER1,                              \
    .push_pop_constraint = RVMC_USER2,                              \
}

//
// Defined configurations
//
static const riscvConfig configList[] = {

    // RV32 variants
    RISC_VARIANT("RV32I",       16, 0, 0, 0, 0, ISA_U|ISA_S|RV32I   ),
    RISC_VARIANT("RV32IM",      16, 0, 0, 0, 0, ISA_U|ISA_S|RV32IM  ),
    RISC_VARIANT("RV32IMC",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV32IMC ),
    RISC_VARIANT("RV32IMCZce",  16, 0, 1, 1, 1, ISA_U|ISA_S|RV32IMC ),
    RISC_VARIANT("RV32IMAC",    16, 0, 0, 0, 0, ISA_U|ISA_S|RV32IMAC),
    RISC_VARIANT("RV32G",       16, 0, 0, 0, 0, ISA_U|ISA_S|RV32G   ),
    RISC_VARIANT("RV32GC",      16, 0, 0, 0, 0, ISA_U|ISA_S|RV32GC  ),
    RISC_VARIANT("RV32GCZfinx", 16, 1, 0, 0, 0, ISA_U|ISA_S|RV32GC  ),
    RISC_VARIANT("RV32GCB",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV32GCB ),
    RISC_VARIANT("RV32GCH",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV32GCH ),
    RISC_VARIANT("RV32GCK",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV32GCK ),
    RISC_VARIANT("RV32GCN",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV32GCN ),
    RISC_VARIANT("RV32GCP",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV32GCP ),
    RISC_VARIANT("RV32GCV",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV32GCV ),
    RISC_VARIANT("RV32E",       16, 0, 0, 0, 0, ISA_U|ISA_S|RV32E   ),
    RISC_VARIANT("RV32EC",      16, 0, 0, 0, 0, ISA_U|ISA_S|RV32EC  ),
    RISC_VARIANT("RV32EM",      16, 0, 0, 0, 0, ISA_U|ISA_S|RV32EM  ),

    // RV64 variants
    RISC_VARIANT("RV64I",       16, 0, 0, 0, 0, ISA_U|ISA_S|RV64I   ),
    RISC_VARIANT("RV64IM",      16, 0, 0, 0, 0, ISA_U|ISA_S|RV64IM  ),
    RISC_VARIANT("RV64IMC",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV64IMC ),
    RISC_VARIANT("RV64IMCZce",  16, 0, 1, 1, 1, ISA_U|ISA_S|RV64IMC ),
    RISC_VARIANT("RV64IMAC",    16, 0, 0, 0, 0, ISA_U|ISA_S|RV64IMAC),
    RISC_VARIANT("RV64G",       16, 0, 0, 0, 0, ISA_U|ISA_S|RV64G   ),
    RISC_VARIANT("RV64GC",      16, 0, 0, 0, 0, ISA_U|ISA_S|RV64GC  ),
    RISC_VARIANT("RV64GCZfinx", 16, 1, 0, 0, 0, ISA_U|ISA_S|RV64GC  ),
    RISC_VARIANT("RV64GCB",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV64GCB ),
    RISC_VARIANT("RV64GCH",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV64GCH ),
    RISC_VARIANT("RV64GCK",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV64GCK ),
    RISC_VARIANT("RV64GCN",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV64GCN ),
    RISC_VARIANT("RV64GCP",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV64GCP ),
    RISC_VARIANT("RV64GCV",     16, 0, 0, 0, 0, ISA_U|ISA_S|RV64GCV ),

    // RV32 base variants (no User/Supervisor modes or PMP implemented)
    RISC_VARIANT("RVB32I",       0, 0, 0, 0, 0,             RV32I   ),
    RISC_VARIANT("RVB32E",       0, 0, 0, 0, 0,             RV32E   ),

    // RV64 base variants (no User/Supervisor modes or PMP implemented)
    RISC_VARIANT("RVB64I",       0, 0, 0, 0, 0,             RV64I   ),

    // 2020 profile variants
    RISC_PROFILE("RVI20U32",     0, 0, 0, 0, RVUV_20191213, RVPV_20190608, ISA_U|      RV32GC),
    RISC_PROFILE("RVI20U64",     0, 0, 0, 0, RVUV_20191213, RVPV_20190608, ISA_U|      RV64GC),
    RISC_PROFILE("RVA20U64",     0, 0, 0, 0, RVUV_20191213, RVPV_20190608, ISA_U|      RV64GC),
    RISC_PROFILE("RVA20S64",     0, 0, 0, 0, RVUV_20191213, RVPV_20190608, ISA_U|ISA_S|RV64GC),

    // 2022 profile variants
    RISC_PROFILE("RVA22U64",     1, 1, 1, 1, RVUV_20191213, RVPV_20211203, ISA_U|      RV64GCB),
    RISC_PROFILE("RVA22S64",     1, 1, 1, 1, RVUV_20191213, RVPV_20211203, ISA_U|ISA_S|RV64GCB),

    {0} // null terminator
};

//
// This returns the supported configuration list
//
riscvConfigCP riscvGetConfigList(riscvP riscv) {
    return configList;
}

