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

// VMI header files
#include "vmi/vmiAttrs.h"
#include "vmi/vmiParameters.h"

// model header files
#include "riscvFeatures.h"
#include "riscvTypeRefs.h"

#define PMP_CFG_PARAMS_64(_I) \
    VMI_UNS64_PARAM(mask_pmpcfg##_I); \
    VMI_UNS64_PARAM(pmpcfg##_I)

#define PMP_CFG_PARAMS_32(_I) \
    VMI_UNS32_PARAM(mask_pmpcfg##_I); \
    VMI_UNS32_PARAM(pmpcfg##_I)

#define PMP_CFG_PARAMS_0_15 \
    PMP_CFG_PARAMS_64(0); \
    PMP_CFG_PARAMS_32(1); \
    PMP_CFG_PARAMS_64(2); \
    PMP_CFG_PARAMS_32(3); \
    PMP_CFG_PARAMS_64(4); \
    PMP_CFG_PARAMS_32(5); \
    PMP_CFG_PARAMS_64(6); \
    PMP_CFG_PARAMS_32(7); \
    PMP_CFG_PARAMS_64(8); \
    PMP_CFG_PARAMS_32(9); \
    PMP_CFG_PARAMS_64(10); \
    PMP_CFG_PARAMS_32(11); \
    PMP_CFG_PARAMS_64(12); \
    PMP_CFG_PARAMS_32(13); \
    PMP_CFG_PARAMS_64(14); \
    PMP_CFG_PARAMS_32(15)

#define PMP_ADDR_PARAMS(_I) \
    VMI_UNS64_PARAM(mask_pmpaddr##_I); \
    VMI_UNS64_PARAM(pmpaddr##_I)

#define PMP_ADDR_PARAMS_0_9(_I) \
    PMP_ADDR_PARAMS(_I##0); \
    PMP_ADDR_PARAMS(_I##1); \
    PMP_ADDR_PARAMS(_I##2); \
    PMP_ADDR_PARAMS(_I##3); \
    PMP_ADDR_PARAMS(_I##4); \
    PMP_ADDR_PARAMS(_I##5); \
    PMP_ADDR_PARAMS(_I##6); \
    PMP_ADDR_PARAMS(_I##7); \
    PMP_ADDR_PARAMS(_I##8); \
    PMP_ADDR_PARAMS(_I##9)

#define PMP_ADDR_PARAMS_0_63 \
    PMP_ADDR_PARAMS(0); \
    PMP_ADDR_PARAMS(1); \
    PMP_ADDR_PARAMS(2); \
    PMP_ADDR_PARAMS(3); \
    PMP_ADDR_PARAMS(4); \
    PMP_ADDR_PARAMS(5); \
    PMP_ADDR_PARAMS(6); \
    PMP_ADDR_PARAMS(7); \
    PMP_ADDR_PARAMS(8); \
    PMP_ADDR_PARAMS(9); \
    PMP_ADDR_PARAMS_0_9(1); \
    PMP_ADDR_PARAMS_0_9(2); \
    PMP_ADDR_PARAMS_0_9(3); \
    PMP_ADDR_PARAMS_0_9(4); \
    PMP_ADDR_PARAMS_0_9(5); \
    PMP_ADDR_PARAMS(60); \
    PMP_ADDR_PARAMS(61); \
    PMP_ADDR_PARAMS(62); \
    PMP_ADDR_PARAMS(63)

//
// Define model parameters
//
typedef struct riscvParamValuesS {

    // simulation controls
    VMI_ENUM_PARAM(variant);
    VMI_STRING_PARAM(clusterVariants);
    VMI_BOOL_PARAM(use_hw_reg_names);
    VMI_BOOL_PARAM(no_pseudo_inst);
    VMI_BOOL_PARAM(ABI_d);
    VMI_BOOL_PARAM(verbose);
    VMI_BOOL_PARAM(traceVolatile);

    // fundamental configuration
    VMI_ENDIAN_PARAM(endian);
    VMI_BOOL_PARAM(enable_expanded);
    VMI_BOOL_PARAM(endianFixed);
    VMI_ENUM_PARAM(user_version);
    VMI_ENUM_PARAM(priv_version);
    VMI_ENUM_PARAM(vector_version);
    VMI_ENUM_PARAM(bitmanip_version);
    VMI_ENUM_PARAM(compress_version);
    VMI_ENUM_PARAM(hypervisor_version);
    VMI_ENUM_PARAM(crypto_version);
    VMI_ENUM_PARAM(dsp_version);
    VMI_ENUM_PARAM(debug_version);
    VMI_ENUM_PARAM(rnmi_version);
    VMI_ENUM_PARAM(Smepmp_version);
    VMI_ENUM_PARAM(CLIC_version);
    VMI_ENUM_PARAM(fp16_version);
    VMI_ENUM_PARAM(mstatus_fs_mode);
    VMI_UNS32_PARAM(numHarts);
    VMI_ENUM_PARAM(debug_mode);
    VMI_UNS64_PARAM(debug_address);
    VMI_UNS64_PARAM(dexc_address);
    VMI_ENUM_PARAM(debug_eret_mode);
    VMI_ENUM_PARAM(debug_priority);
    VMI_UNS32_PARAM(dcsr_ebreak_mask);
    VMI_ENUM_PARAM(amo_constraint);
    VMI_ENUM_PARAM(lr_sc_constraint);
    VMI_ENUM_PARAM(push_pop_constraint);
    VMI_BOOL_PARAM(updatePTEA);
    VMI_BOOL_PARAM(updatePTED);
    VMI_BOOL_PARAM(unaligned_low_pri);
    VMI_BOOL_PARAM(unaligned);
    VMI_BOOL_PARAM(unalignedAMO);
    VMI_BOOL_PARAM(unalignedV);
    VMI_BOOL_PARAM(wfi_is_nop);
    VMI_BOOL_PARAM(mtvec_is_ro);
    VMI_UNS32_PARAM(counteren_mask);
    VMI_UNS32_PARAM(noinhibit_mask);
    VMI_UNS32_PARAM(tvec_align);
    VMI_UNS64_PARAM(mtvec_mask);
    VMI_UNS64_PARAM(stvec_mask);
    VMI_UNS64_PARAM(utvec_mask);
    VMI_UNS64_PARAM(mtvt_mask);
    VMI_UNS64_PARAM(stvt_mask);
    VMI_UNS64_PARAM(utvt_mask);
    VMI_UNS64_PARAM(jvt_mask);
    VMI_UNS64_PARAM(tdata1_mask);
    VMI_UNS64_PARAM(mip_mask);
    VMI_UNS64_PARAM(sip_mask);
    VMI_UNS64_PARAM(uip_mask);
    VMI_UNS64_PARAM(hip_mask);
    VMI_UNS64_PARAM(envcfg_mask);
    VMI_BOOL_PARAM(mtvec_sext);
    VMI_BOOL_PARAM(stvec_sext);
    VMI_BOOL_PARAM(utvec_sext);
    VMI_BOOL_PARAM(mtvt_sext);
    VMI_BOOL_PARAM(stvt_sext);
    VMI_BOOL_PARAM(utvt_sext);
    VMI_UNS64_PARAM(ecode_mask);
    VMI_UNS64_PARAM(ecode_nmi);
    VMI_BOOL_PARAM(nmi_is_latched);
    VMI_UNS64_PARAM(ecode_nmi_mask);
    VMI_BOOL_PARAM(tval_zero);
    VMI_BOOL_PARAM(tval_zero_ebreak);
    VMI_BOOL_PARAM(tval_ii_code);
    VMI_BOOL_PARAM(time_undefined);
    VMI_BOOL_PARAM(cycle_undefined);
    VMI_BOOL_PARAM(mcycle_undefined);
    VMI_BOOL_PARAM(instret_undefined);
    VMI_BOOL_PARAM(minstret_undefined);
    VMI_BOOL_PARAM(hpmcounter_undefined);
    VMI_BOOL_PARAM(mhpmcounter_undefined);
    VMI_BOOL_PARAM(tinfo_undefined);
    VMI_BOOL_PARAM(tcontrol_undefined);
    VMI_BOOL_PARAM(mcontext_undefined);
    VMI_BOOL_PARAM(scontext_undefined);
    VMI_BOOL_PARAM(mscontext_undefined);
    VMI_BOOL_PARAM(hcontext_undefined);
    VMI_BOOL_PARAM(mnoise_undefined);
    VMI_BOOL_PARAM(amo_trigger);
    VMI_BOOL_PARAM(amo_aborts_lr_sc);
    VMI_BOOL_PARAM(no_hit);
    VMI_BOOL_PARAM(no_sselect_2);
    VMI_BOOL_PARAM(enable_CSR_bus);
    VMI_STRING_PARAM(CSR_remap);
    VMI_BOOL_PARAM(d_requires_f);
    VMI_BOOL_PARAM(enable_fflags_i);
    VMI_BOOL_PARAM(trap_preserves_lr);
    VMI_BOOL_PARAM(xret_preserves_lr);
    VMI_BOOL_PARAM(fence_g_preserves_vs);
    VMI_BOOL_PARAM(require_vstart0);
    VMI_BOOL_PARAM(align_whole);
    VMI_BOOL_PARAM(vill_trap);
    VMI_UNS32_PARAM(ASID_cache_size);
    VMI_UNS32_PARAM(ASID_bits);
    VMI_UNS32_PARAM(trigger_num);
    VMI_UNS32_PARAM(tinfo);
    VMI_UNS32_PARAM(mcontext_bits);
    VMI_UNS32_PARAM(scontext_bits);
    VMI_UNS32_PARAM(mvalue_bits);
    VMI_UNS32_PARAM(svalue_bits);
    VMI_UNS32_PARAM(mcontrol_maskmax);
    VMI_UNS32_PARAM(VMID_bits);
#if(ENABLE_SSMPU)
    VMI_UNS32_PARAM(MPU_grain);
    VMI_UNS32_PARAM(MPU_registers);
    VMI_BOOL_PARAM(MPU_decompose);
#endif
    VMI_UNS32_PARAM(cmomp_bytes);
    VMI_UNS32_PARAM(cmoz_bytes);
    VMI_UNS32_PARAM(Sv_modes);
    VMI_BOOL_PARAM(Smstateen);
    VMI_BOOL_PARAM(Svpbmt);
    VMI_BOOL_PARAM(Svinval);
    VMI_UNS32_PARAM(lr_sc_grain);
    VMI_UNS64_PARAM(reset_address);
    VMI_UNS64_PARAM(nmi_address);
    VMI_UNS64_PARAM(nmiexc_address);
    VMI_UNS64_PARAM(CLINT_address);
    VMI_DBL_PARAM(mtime_Hz);
    VMI_UNS32_PARAM(local_int_num);
    VMI_UNS64_PARAM(unimp_int_mask);
    VMI_UNS64_PARAM(force_mideleg);
    VMI_UNS64_PARAM(force_sideleg);
    VMI_UNS64_PARAM(no_ideleg);
    VMI_UNS64_PARAM(no_edeleg);
    VMI_BOOL_PARAM(external_int_id);

    // ISA configuration
    VMI_UNS32_PARAM(misa_MXL);
    VMI_UNS32_PARAM(misa_Extensions);
    VMI_STRING_PARAM(add_Extensions);
    VMI_STRING_PARAM(sub_Extensions);
    VMI_UNS32_PARAM(misa_Extensions_mask);
    VMI_STRING_PARAM(add_Extensions_mask);
    VMI_STRING_PARAM(sub_Extensions_mask);
    VMI_STRING_PARAM(add_implicit_Extensions);
    VMI_STRING_PARAM(sub_implicit_Extensions);
    VMI_UNS64_PARAM(mvendorid);
    VMI_UNS64_PARAM(marchid);
    VMI_UNS64_PARAM(mimpid);
    VMI_UNS64_PARAM(mhartid);
    VMI_UNS64_PARAM(mconfigptr);
    VMI_UNS64_PARAM(mtvec);
    VMI_UNS64_PARAM(mseccfg);
    VMI_UNS64_PARAM(Svnapot_page_mask);
    VMI_UNS32_PARAM(mstatus_FS);
    VMI_UNS32_PARAM(mstatus_VS);
    VMI_UNS32_PARAM(mstatus_FS_zero);
    VMI_UNS32_PARAM(ELEN);
    VMI_UNS32_PARAM(SLEN);
    VMI_UNS32_PARAM(VLEN);
    VMI_UNS32_PARAM(EEW_index);
    VMI_UNS32_PARAM(SEW_min);
    VMI_BOOL_PARAM(agnostic_ones);
    VMI_BOOL_PARAM(MXL_writable);
    VMI_BOOL_PARAM(SXL_writable);
    VMI_BOOL_PARAM(UXL_writable);
    VMI_BOOL_PARAM(VSXL_writable);
    VMI_BOOL_PARAM(Zmmul);
    VMI_BOOL_PARAM(Zvlsseg);
    VMI_BOOL_PARAM(Zvamo);
    VMI_BOOL_PARAM(Zvediv);
    VMI_BOOL_PARAM(Zvqmac);
    VMI_BOOL_PARAM(Zve32x);
    VMI_BOOL_PARAM(Zve32f);
    VMI_BOOL_PARAM(Zve64x);
    VMI_BOOL_PARAM(Zve64f);
    VMI_BOOL_PARAM(Zve64d);
    VMI_BOOL_PARAM(Zba);
    VMI_BOOL_PARAM(Zbb);
    VMI_BOOL_PARAM(Zbc);
    VMI_BOOL_PARAM(Zbe);
    VMI_BOOL_PARAM(Zbf);
    VMI_BOOL_PARAM(Zbm);
    VMI_BOOL_PARAM(Zbp);
    VMI_BOOL_PARAM(Zbr);
    VMI_BOOL_PARAM(Zbs);
    VMI_BOOL_PARAM(Zbt);
    VMI_BOOL_PARAM(Zbkb);
    VMI_BOOL_PARAM(Zbkc);
    VMI_BOOL_PARAM(Zbkx);
    VMI_BOOL_PARAM(Zicsr);
    VMI_BOOL_PARAM(Zifencei);
    VMI_BOOL_PARAM(Zicbom);
    VMI_BOOL_PARAM(Zicbop);
    VMI_BOOL_PARAM(Zicboz);
    VMI_BOOL_PARAM(Zkr);
    VMI_BOOL_PARAM(Zknd);
    VMI_BOOL_PARAM(Zkne);
    VMI_BOOL_PARAM(Zknh);
    VMI_BOOL_PARAM(Zksed);
    VMI_BOOL_PARAM(Zksh);
    VMI_BOOL_PARAM(Zkb);
    VMI_BOOL_PARAM(Zkg);
    VMI_BOOL_PARAM(Zfh);
    VMI_BOOL_PARAM(Zfhmin);
    VMI_BOOL_PARAM(Zpsfoperand);
    VMI_ENUM_PARAM(Zfinx_version);
    VMI_ENUM_PARAM(Zcea_version);
    VMI_ENUM_PARAM(Zceb_version);
    VMI_ENUM_PARAM(Zcee_version);
    VMI_BOOL_PARAM(Zca);
    VMI_BOOL_PARAM(Zcb);
    VMI_BOOL_PARAM(Zcf);
    VMI_BOOL_PARAM(Zcmb);
    VMI_BOOL_PARAM(Zcmp);
    VMI_BOOL_PARAM(Zcmpe);
    VMI_BOOL_PARAM(Zcmt);

    // CLIC configuration
    VMI_UNS64_PARAM(mclicbase);
    VMI_UNS32_PARAM(CLICLEVELS);
    VMI_BOOL_PARAM(CLICANDBASIC);
    VMI_UNS32_PARAM(CLICVERSION);
    VMI_UNS32_PARAM(CLICINTCTLBITS);
    VMI_UNS32_PARAM(CLICCFGMBITS);
    VMI_UNS32_PARAM(CLICCFGLBITS);
    VMI_BOOL_PARAM(CLICSELHVEC);
    VMI_BOOL_PARAM(CLICXNXTI);
    VMI_BOOL_PARAM(CLICXCSW);
    VMI_BOOL_PARAM(externalCLIC);
    VMI_BOOL_PARAM(tvt_undefined);
    VMI_BOOL_PARAM(intthresh_undefined);
    VMI_BOOL_PARAM(mclicbase_undefined);
    VMI_UNS64_PARAM(posedge_0_63);
    VMI_UNS64_PARAM(poslevel_0_63);
    VMI_BOOL_PARAM(posedge_other);
    VMI_BOOL_PARAM(poslevel_other);

    // Hypervisor configuration
    VMI_UNS32_PARAM(GEILEN);
    VMI_BOOL_PARAM(xtinst_basic);

    // PMP configuration
    VMI_UNS32_PARAM(PMP_grain);
    VMI_UNS32_PARAM(PMP_registers);
    VMI_UNS32_PARAM(PMP_max_page);
    VMI_BOOL_PARAM(PMP_decompose);
    VMI_BOOL_PARAM(PMP_undefined);
    VMI_BOOL_PARAM(PMP_maskparams);
    VMI_BOOL_PARAM(PMP_initialparams);
    PMP_CFG_PARAMS_0_15;
    PMP_ADDR_PARAMS_0_63;
    
} riscvParamValues;

//
// Free parameter definitions
//
void riscvFreeParameters(riscvP riscv);

//
// Get any configuration with the given name
//
riscvConfigCP riscvGetNamedConfig(riscvConfigCP cfgList, const char *variant);

//
// Return Privileged Architecture description
//
const char *riscvGetPrivVersionDesc(riscvP riscv);

//
// Return User Architecture description
//
const char *riscvGetUserVersionDesc(riscvP riscv);

//
// Return Vector Architecture description
//
const char *riscvGetVectorVersionDesc(riscvP riscv);

//
// Return Compressed Architecture description
//
const char *riscvGetCompressedVersionDesc(riscvP riscv);

//
// Return Bit Manipulation Architecture description
//
const char *riscvGetBitManipVersionDesc(riscvP riscv);

//
// Return Bit Manipulation Architecture description
//
const char *riscvGetHypervisorVersionDesc(riscvP riscv);

//
// Return Cryptographic Architecture description
//
const char *riscvGetCryptographicVersionDesc(riscvP riscv);

//
// Return DSP Architecture description
//
const char *riscvGetDSPVersionDesc(riscvP riscv);

//
// Return Debug Architecture description
//
const char *riscvGetDebugVersionDesc(riscvP riscv);

//
// Return RNMI Architecture name
//
const char *riscvGetRNMIVersionName(riscvP riscv);

//
// Return Smepmp Architecture name
//
const char *riscvGetSmepmpVersionName(riscvP riscv);

//
// Return CLIC description
//
const char *riscvGetCLICVersionDesc(riscvP riscv);

//
// Return Zfinx version description
//
const char *riscvGetZfinxVersionDesc(riscvP riscv);

//
// Return Zcea version name
//
const char *riscvGetZceaVersionName(riscvP riscv);

//
// Return Zceb version name
//
const char *riscvGetZcebVersionName(riscvP riscv);

//
// Return Zcee version name
//
const char *riscvGetZceeVersionName(riscvP riscv);

//
// Return 16-bit floating point description
//
const char *riscvGetFP16VersionDesc(riscvP riscv);

//
// Return mstatus.FS mode name
//
const char *riscvGetFSModeName(riscvP riscv);
