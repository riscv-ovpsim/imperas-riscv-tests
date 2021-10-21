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

// VMI header files
#include "vmi/vmiTypes.h"

// model header files
#include "riscvTypeRefs.h"


////////////////////////////////////////////////////////////////////////////////
// REGISTER ACCESS MACROS
////////////////////////////////////////////////////////////////////////////////

// aliases for specific RISCV registers
typedef enum rvRegE {
    RV_REG_X_ZERO =  0,
    RV_REG_X_RA   =  1,
    RV_REG_X_SP   =  2,
    RV_REG_X_GP   =  3,
    RV_REG_X_TP   =  4,
    RV_REG_X_T0   =  5,
    RV_REG_X_T1   =  6,
    RV_REG_X_T2   =  7,
    RV_REG_X_S0   =  8,
    RV_REG_X_S1   =  9,
    RV_REG_X_A0   =  10,
    RV_REG_X_A1   =  11,
    RV_REG_X_A2   =  12,
    RV_REG_X_A3   =  13,
    RV_REG_X_A4   =  14,
    RV_REG_X_A5   =  15,
    RV_REG_X_A6   =  16,
    RV_REG_X_A7   =  17,
    RV_REG_X_S2   =  18,
    RV_REG_X_S3   =  19,
    RV_REG_X_S4   =  20,
    RV_REG_X_S5   =  21,
    RV_REG_X_S6   =  22,
    RV_REG_X_S7   =  23,
    RV_REG_X_S8   =  24,
    RV_REG_X_S9   =  25,
    RV_REG_X_S10  =  26,
    RV_REG_X_S11  =  27,
    RV_REG_X_T3   =  28,
    RV_REG_X_T4   =  29,
    RV_REG_X_T5   =  30,
    RV_REG_X_T6   =  31,
} rvReg;

// morph-time macros to calculate offsets to registers in a RISCV structure
#define RISCV_CPU_OFFSET(_R)    VMI_CPU_OFFSET(riscvP, _R)
#define RISCV_CPU_REG(_R)       VMI_CPU_REG(riscvP, _R)
#define RISCV_CPU_REGH(_R)      VMI_CPU_REG_DELTA(riscvP, _R, 4)
#define RISCV_CPU_TEMP(_R)      VMI_CPU_TEMP(riscvP, _R)
#define RISCV_CPU_VBASE(_I)     VMI_CPU_TEMP(riscvP, vBase[_I])
#define RISCV_GPR(_I)           RISCV_CPU_REG(x[_I])
#define RISCV_FPR(_I)           RISCV_CPU_REG(f[_I])
#define RISCV_SF_TMP            RISCV_CPU_TEMP(SF)
#define RISCV_LR                RISCV_CPU_REG(x[RV_REG_X_RA])
#define RISCV_EA_ADDR           RISCV_CPU_REG(exclusiveAddr)
#define RISCV_EA_TAG            RISCV_CPU_REG(exclusiveTag)
#define RISCV_ATOMIC            RISCV_CPU_REG(atomic)
#define RISCV_HLVHSV            RISCV_CPU_REG(HLVHSV)
#define RISCV_DM                RISCV_CPU_REG(DM)
#define RISCV_DM_STALL          RISCV_CPU_REG(DMStall)
#define RISCV_COMMERCIAL        RISCV_CPU_REG(commercial)
#define RISCV_FP_FLAGS          RISCV_CPU_REG(fpFlagsMT)
#define RISCV_FP_FLAGS_I        RISCV_CPU_REG(fpFlagsI)
#define RISCV_SF_FLAGS          RISCV_CPU_REG(SFMT)
#define RISCV_JUMP_BASE         RISCV_CPU_REG(jumpBase)
#define RISCV_PM_KEY            RISCV_CPU_REG(pmKey)
#define RISCV_VPRED_MASK        RISCV_CPU_TEMP(vFieldMask)
#define RISCV_VACTIVE_MASK      RISCV_CPU_TEMP(vActiveMask)
#define RISCV_VTMP              RISCV_CPU_TEMP(vTmp)
#define RISCV_VSTATE            RISCV_CPU_TEMP(vState)
#define RISCV_FF                RISCV_CPU_REG(vFirstFault)
#define RISCV_PRESERVE          RISCV_CPU_REG(vPreserve)
#define RISCV_VLMAX             RISCV_CPU_TEMP(vlMax)
#define RISCV_VL_EEW1           RISCV_CPU_REG(vlEEW1)
#define RISCV_OFFSETS_LMULx2    RISCV_CPU_REG(offsetsLMULx2)
#define RISCV_OFFSETS_LMULx4    RISCV_CPU_REG(offsetsLMULx4)
#define RISCV_OFFSETS_LMULx8    RISCV_CPU_REG(offsetsLMULx8)
#define RISCV_BLOCK_MASK        RISCV_CPU_REG(currentArch)
#define RISCV_TRIGGER_VA        RISCV_CPU_REG(triggerVA)
#define RISCV_TRIGGER_LV        RISCV_CPU_REG(triggerLV)


