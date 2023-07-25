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
#include <string.h>
#include <stdio.h>

// Imperas header files
#include "hostapi/impAlloc.h"

// common header files
#include "ocl/oclSymbol.h"

// VMI header files
#include "vmi/vmiAttrs.h"
#include "vmi/vmiDbg.h"
#include "vmi/vmiMessage.h"
#include "vmi/vmiMt.h"
#include "vmi/vmiRt.h"

// model header files
#include "riscvBus.h"
#include "riscvCLINT.h"
#include "riscvCluster.h"
#include "riscvCSR.h"
#include "riscvCSRTypes.h"
#include "riscvDebug.h"
#include "riscvExceptions.h"
#include "riscvFunctions.h"
#include "riscvMessage.h"
#include "riscvRegisters.h"
#include "riscvStructure.h"
#include "riscvUtils.h"
#include "riscvVariant.h"


////////////////////////////////////////////////////////////////////////////////
// REGISTER GROUPS
////////////////////////////////////////////////////////////////////////////////

//
// This describes the register groups in the processor
//
typedef enum riscvRegGroupIdE {
    RV_RG_CORE,         // core register group
    RV_RG_FP,           // floating point register group
    RV_RG_V,            // vector register group
    RV_RG_U_CSR,        // User mode CSR register group
    RV_RG_S_CSR,        // Supervisor mode CSR register group
    RV_RG_H_CSR,        // Hypervisor mode CSR register group
    RV_RG_M_CSR,        // Machine mode CSR register group
    RV_RG_CLINT,        // CLINT register group
    RV_RG_INTEGRATION,  // integration support registers
    RV_RG_EXTENSION,    // extension registers
    RV_RG_LAST          // KEEP LAST: for sizing
} riscvRegGroupId;

//
// This provides information about each group
//
static const vmiRegGroup groups[RV_RG_LAST+1] = {
    [RV_RG_CORE]        = {name: "Core"},
    [RV_RG_FP]          = {name: "Floating_point"},
    [RV_RG_V]           = {name: "Vector"},
    [RV_RG_U_CSR]       = {name: "User_Control_and_Status"},
    [RV_RG_S_CSR]       = {name: "Supervisor_Control_and_Status"},
    [RV_RG_H_CSR]       = {name: "Hypervisor_Control_and_Status"},
    [RV_RG_M_CSR]       = {name: "Machine_Control_and_Status"},
    [RV_RG_CLINT]       = {name: "CLINT"},
    [RV_RG_INTEGRATION] = {name: "Integration_support"},
    [RV_RG_EXTENSION]   = {name: "Extension"},
};

//
// Macro to specify a the group for a register
//
#define RV_GROUP(_G) &groups[RV_RG_##_G]

//
// This is the index of the first FPR
//
#define RISCV_FPR0_INDEX        33

//
// This is the index of the first CSR (NOTE: last potential CSR is at address
// RISCV_CSR0_INDEX+0xfff
//
#define RISCV_CSR0_INDEX        65

//
// This is the index of the first integration support register (after last
// potential CSR)
//
#define RISCV_SUP0_INDEX        0x1100

//
// This is the index of the first expanded pmpcfg integration support register
//
#define RISCV_PMPCFG_INDEX      0x1200

//
// This is the index of the first vector register
//
#define RISCV_V0_INDEX          0x2000

//
// This is the index of the first extension register
//
#define RISCV_EXT_INDEX         0x80000000


////////////////////////////////////////////////////////////////////////////////
// SUPPLEMENTAL REGISTER ITERATION
////////////////////////////////////////////////////////////////////////////////

DEFINE_CS(supDetails);
DEFINE_S (regList);

//
// Function type indicating ISR presence
//
#define ISR_PRESENT_FN(_NAME) Bool _NAME(riscvP riscv, supDetailsCP this)
typedef ISR_PRESENT_FN((*isrPresentFn));

//
// Structure providing details of supplemental registers
//
typedef struct supDetailsS {
    const char       *name;
    const char       *desc;
    riscvArchitecture arch;
    Uns32             index;
    Uns32             bits;
    vmiReg            raw;
    vmiRegReadFn      readCB;
    vmiRegWriteFn     writeCB;
    vmiRegAccess      access;
    vmiRegGroupCP     group;
    Bool              noTraceChange;
    Bool              noSaveRestore;
    Bool              instrAttrIgnore;
    void             *userData;
    isrPresentFn      present;
} supDetails;

//
// Structure defining register list entry
//
typedef struct riscvRegListS {
    riscvRegListP next;
    vmiRegInfo    reg;
} riscvRegList;

//
// Is DM artifact register present?
//
static ISR_PRESENT_FN(presentDM) {
    return riscv->configInfo.debug_mode>=RVDM_VECTOR;
}

//
// Is DMStall artifact register present?
//
static ISR_PRESENT_FN(presentDMStall) {
    return riscv->configInfo.debug_mode==RVDM_HALT;
}

//
// Is fflags_i artifact register present?
//
static ISR_PRESENT_FN(presentFFlagsI) {
    return perInstructionFFlags(riscv);
}

//
// Is dynamic FP16 format selection enabled?
//
static ISR_PRESENT_FN(dynamicFP16) {
    return riscv->configInfo.fp16_version==RVFP16_DYNAMIC;
}

//
// Are CLINT-specific registers present?
//
static ISR_PRESENT_FN(presentCLINT) {
    return riscv->clint;
}

//
// Is the pmpcfg register with index in userData present?
// - 4 cfg entries per register, so multiply index by 4 before
//   comparing with number of PMP entries
//
static ISR_PRESENT_FN(presentPMPCFG) {
    Uns32 index = (Uns32)(UnsPS)this->userData * 4;
    return (index < riscv->configInfo.PMP_registers);
}

//
// Is the pmpaddr register with index in userData present?
//
static ISR_PRESENT_FN(presentPMPAddr) {
    Uns32 index = (Uns32)(UnsPS)this->userData;
    return (index < riscv->configInfo.PMP_registers);
}

//
// Write processor DM bit (enables or disables Debug mode)
//
static VMI_REG_WRITE_FN(writeDM) {

    riscvP      riscv = (riscvP)processor;
    const Uns8 *DMP   = buffer;
    Uns8        DM    = *DMP;

    riscvSetDM(riscv, DM&1);

    return True;
}

//
// Write processor DM stall bit (indicates stalled in Debug mode)
//
static VMI_REG_WRITE_FN(writeDMStall) {

    riscvP      riscv    = (riscvP)processor;
    const Uns8 *DMStallP = buffer;
    Uns8        DMStall  = *DMStallP;

    riscvSetDMStall(riscv, DMStall&1);

    return True;
}

//
// Read readPTWStage (indicates page table walk active stage)
//
static VMI_REG_READ_FN(readPTWStage) {

    riscvP riscv     = (riscvP)processor;
    Uns8  *PTWStageP = buffer;

    *PTWStageP = riscv->PTWActive ? riscv->activeTLB+1 : 0;

    return True;
}

//
// Read readPTWInputAddr (indicates page table walk input address)
//
static VMI_REG_READ_FN(readPTWInputAddr) {

    riscvP riscv         = (riscvP)processor;
    Uns64 *PTWInputAddrP = buffer;

    *PTWInputAddrP = riscv->PTWActive ? riscv->originalVA : 0;

    return True;
}

//
// Read readPTWLevel (indicates page table walk active level)
//
static VMI_REG_READ_FN(readPTWLevel) {

    riscvP riscv     = (riscvP)processor;
    Uns8  *PTWLevelP = buffer;

    *PTWLevelP = riscv->PTWActive ? riscv->PTWLevel : 0;

    return True;
}

//
// Read fflags_i (indicates floating point flags written by current instruction)
//
static VMI_REG_READ_FN(readFFlagsI) {

    riscvP      riscv    = (riscvP)processor;
    Uns8       *FFlagsIP = buffer;
    vmiFPFlags  vmiFlags = {bits : riscv->fpFlagsI};
    CSR_REG_DECL(fflags) = {u32 : {bits:0}};

    // compose register value
    fflags.u32.fields.NX = vmiFlags.f.P;
    fflags.u32.fields.UF = vmiFlags.f.U;
    fflags.u32.fields.OF = vmiFlags.f.O;
    fflags.u32.fields.DZ = vmiFlags.f.Z;
    fflags.u32.fields.NV = vmiFlags.f.I;

    // return composed value
    *FFlagsIP = fflags.u32.bits;

    return True;
}

//
// Return indication of whether there are pending and enabled interrupts
//
static VMI_REG_READ_FN(readASYNCPE) {

    riscvP riscv   = (riscvP)processor;
    Uns8  *ASYNCPE = buffer;

    *ASYNCPE = riscvPendingAndEnabled(riscv);

    return True;
}

//
// Return indication of whether FP16 format is in use
//
static VMI_REG_READ_FN(readFP16) {

    riscvP riscv      = (riscvP)processor;
    Uns8  *usingBF16P = buffer;

    *usingBF16P = riscv->usingBF16;

    return True;
}

//
// Write indication of whether FP16 format is in use
//
static VMI_REG_WRITE_FN(writeFP16) {

    riscvP      riscv      = (riscvP)processor;
    const Uns8 *usingBF16P = buffer;
    Uns8        usingBF16  = *usingBF16P;

    riscvUpdateDynamicBF16(riscv, usingBF16&1);

    return True;
}

//
// Read CLINT msip
//
static VMI_REG_READ_FN(readMSIP) {

    riscvP riscv = (riscvP)processor;
    Uns8  *msipP = buffer;

    *msipP = riscvReadCLINTMSIP(riscv);

    return True;
}

//
// Write CLINT msip
//
static VMI_REG_WRITE_FN(writeMSIP) {

    riscvP      riscv = (riscvP)processor;
    const Uns8 *msipP = buffer;
    Uns8        msip  = *msipP;

    riscvWriteCLINTMSIP(riscv, msip&1);

    return True;
}

//
// Read CLINT mtimecmp
//
static VMI_REG_READ_FN(readMTIMECMP) {

    riscvP riscv     = (riscvP)processor;
    Uns64 *mtimecmpP = buffer;

    *mtimecmpP = riscvReadMTIMECMP(riscv);

    return True;
}

//
// Write CLINT mtimecmp
//
static VMI_REG_WRITE_FN(writeMTIMECMP) {

    riscvP       riscv     = (riscvP)processor;
    const Uns64 *mtimecmpP = buffer;
    Uns64        mtimecmp  = *mtimecmpP;

    riscvWriteMTIMECMP(riscv, mtimecmp);

    return True;
}

//
// Read CLINT mtime
//
static VMI_REG_READ_FN(readMTIME) {

    riscvP riscv  = (riscvP)processor;
    Uns64 *mtimeP = buffer;

    *mtimeP = riscvReadMTIME(riscv);

    return True;
}

//
// Write CLINT mtime
//
static VMI_REG_WRITE_FN(writeMTIME) {

    riscvP       riscv  = (riscvP)processor;
    const Uns64 *mtimeP = buffer;
    Uns64        mtime  = *mtimeP;

    riscvWriteCLINTMTIME(riscv, mtime);

    return True;
}

//
// Read PMP CFG register write mask value
// - invert read-only mask value stored internally to return as a writemask
//
static VMI_REG_READ_FN(readPMPCFGMask) {

    riscvP riscv = (riscvP)processor;
    Uns32  index = (UnsPS)reg->userData;
    Uns32  bits  = reg->bits;

    VMI_ASSERT(index < 16, "pmpcfgMask index out of range");
    VMI_ASSERT((bits==32) || (bits==64), "unimplemented bits %u", bits);

    if(bits==32) {
        *(Uns32 *)buffer = ~riscv->romask_pmpcfg.u32[index];
    } else {
        *(Uns64 *)buffer = ~riscv->romask_pmpcfg.u64[index/2];
    }

    return True;
}

//
// Read PMP Addr register write mask value
// - invert read-only mask value stored internally to return as a writemask
//
static VMI_REG_READ_FN(readPMPAddrMask) {

    riscvP                        riscv        = (riscvP)processor;
    Uns32                         index        = (Uns32)(UnsPS)reg->userData;
    CSR_REG_TYPE(romask_pmpaddr) *romasks      = &riscv->configInfo.csrMask.romask_pmpaddr0;
    Uns64                        *pmpaddrMaskP = buffer;

    VMI_ASSERT(index < 64, "pmpcfgMask index out of range");
    VMI_ASSERT(reg->bits == 64, "%s register must be 64 bits", reg->name);

    *pmpaddrMaskP = ~romasks[index].u64.bits;

    return True;
}

//
// Macros for "arrays" of PMP register write masks
//
#define PMP_CFG_EVEN(_I, _GDB_I_0) \
    {"mask_pmpcfg"#_I,  "Write mask for pmpcfg"#_I,    0, (_GDB_I_0)+_I,  64, VMI_NOREG, readPMPCFGMask, 0, vmi_RA_R, RV_GROUP(INTEGRATION), 1, 1, 1, (void *)(UnsPS)_I, presentPMPCFG}

#define PMP_CFG_ODD(_I, _GDB_I_0) \
    {"mask_pmpcfg"#_I,  "Write mask for pmpcfg"#_I, RV32, (_GDB_I_0)+_I,  32, VMI_NOREG, readPMPCFGMask, 0, vmi_RA_R, RV_GROUP(INTEGRATION), 1, 1, 1, (void *)(UnsPS)_I, presentPMPCFG}

#define PMP_CFG_0_15(_GDB_I_0) \
    PMP_CFG_EVEN(0,  _GDB_I_0), \
    PMP_CFG_ODD(1,   _GDB_I_0), \
    PMP_CFG_EVEN(2,  _GDB_I_0), \
    PMP_CFG_ODD(3,   _GDB_I_0), \
    PMP_CFG_EVEN(4,  _GDB_I_0), \
    PMP_CFG_ODD(5,   _GDB_I_0), \
    PMP_CFG_EVEN(6,  _GDB_I_0), \
    PMP_CFG_ODD(7,   _GDB_I_0), \
    PMP_CFG_EVEN(8,  _GDB_I_0), \
    PMP_CFG_ODD(9,   _GDB_I_0), \
    PMP_CFG_EVEN(10, _GDB_I_0), \
    PMP_CFG_ODD(11,  _GDB_I_0), \
    PMP_CFG_EVEN(12, _GDB_I_0), \
    PMP_CFG_ODD(13,  _GDB_I_0), \
    PMP_CFG_EVEN(14, _GDB_I_0), \
    PMP_CFG_ODD(15,  _GDB_I_0)

#define PMP_ADDR(_I, _GDB_I_0) \
    {"mask_pmpaddr"#_I, "Write mask for pmpaddr"#_I, 0, (_GDB_I_0)+_I, 64, VMI_NOREG, readPMPAddrMask, 0, vmi_RA_R, RV_GROUP(INTEGRATION), 1, 1, 1, (void *)(UnsPS)_I, presentPMPAddr}

#define PMP_ADDR_0_9(_X,_GDB_I_0) \
    PMP_ADDR(_X##0, _GDB_I_0), \
    PMP_ADDR(_X##1, _GDB_I_0), \
    PMP_ADDR(_X##2, _GDB_I_0), \
    PMP_ADDR(_X##3, _GDB_I_0), \
    PMP_ADDR(_X##4, _GDB_I_0), \
    PMP_ADDR(_X##5, _GDB_I_0), \
    PMP_ADDR(_X##6, _GDB_I_0), \
    PMP_ADDR(_X##7, _GDB_I_0), \
    PMP_ADDR(_X##8, _GDB_I_0), \
    PMP_ADDR(_X##9, _GDB_I_0)

#define PMP_ADDR_0_63(_GDB_I_0) \
    PMP_ADDR(0, _GDB_I_0), \
    PMP_ADDR(1, _GDB_I_0), \
    PMP_ADDR(2, _GDB_I_0), \
    PMP_ADDR(3, _GDB_I_0), \
    PMP_ADDR(4, _GDB_I_0), \
    PMP_ADDR(5, _GDB_I_0), \
    PMP_ADDR(6, _GDB_I_0), \
    PMP_ADDR(7, _GDB_I_0), \
    PMP_ADDR(8, _GDB_I_0), \
    PMP_ADDR(9, _GDB_I_0), \
    PMP_ADDR_0_9(1, _GDB_I_0), \
    PMP_ADDR_0_9(2, _GDB_I_0), \
    PMP_ADDR_0_9(3, _GDB_I_0), \
    PMP_ADDR_0_9(4, _GDB_I_0), \
    PMP_ADDR_0_9(5, _GDB_I_0), \
    PMP_ADDR(60, _GDB_I_0), \
    PMP_ADDR(61, _GDB_I_0), \
    PMP_ADDR(62, _GDB_I_0), \
    PMP_ADDR(63, _GDB_I_0)

//
// List of supplemental registers
//
static const supDetails supRegs[] = {

    {"LRSCAddress",  "LR/SC active lock address",               ISA_A,  0,  0, RISCV_EA_TAG,     0,                0,             vmi_RA_RW, RV_GROUP(INTEGRATION), 0, 0, 0, 0, 0             },
    {"DM",           "Debug mode active",                       0,      1,  8, RISCV_DM,         0,                writeDM,       vmi_RA_RW, RV_GROUP(INTEGRATION), 0, 0, 0, 0, presentDM     },
    {"DMStall",      "Debug mode stalled",                      0,      2,  8, RISCV_DM_STALL,   0,                writeDMStall,  vmi_RA_RW, RV_GROUP(INTEGRATION), 0, 0, 0, 0, presentDMStall},
    {"commercial",   "Commercial feature in use",               0,      3,  8, RISCV_COMMERCIAL, 0,                0,             vmi_RA_R,  RV_GROUP(INTEGRATION), 0, 0, 0, 0, 0             },
    {"PTWStage",     "PTW active stage (0:none 1:HS 2:VS 3:G)", ISA_S,  4,  8, VMI_NOREG,        readPTWStage,     0,             vmi_RA_R,  RV_GROUP(INTEGRATION), 1, 1, 0, 0, 0             },
    {"PTWInputAddr", "PTW input address",                       ISA_S,  5, 64, VMI_NOREG,        readPTWInputAddr, 0,             vmi_RA_R,  RV_GROUP(INTEGRATION), 1, 1, 0, 0, 0             },
    {"PTWLevel",     "PTW active level",                        ISA_S,  6,  8, VMI_NOREG,        readPTWLevel,     0,             vmi_RA_R,  RV_GROUP(INTEGRATION), 1, 1, 0, 0, 0             },
    {"fflags_i",     "Per-instruction floating point flags",    ISA_DF, 7,  8, VMI_NOREG,        readFFlagsI,      0,             vmi_RA_R,  RV_GROUP(INTEGRATION), 0, 0, 1, 0, presentFFlagsI},
    {"ASYNCPE",      "Asynchronous Event Pending & Enabled",    0,      8,  8, VMI_NOREG,        readASYNCPE,      0,             vmi_RA_R,  RV_GROUP(INTEGRATION), 1, 1, 0, 0, 0             },
    {"fp16Format",   "Dynamic 16-bit floating point format",    0,      9,  8, VMI_NOREG,        readFP16,         writeFP16,     vmi_RA_RW, RV_GROUP(INTEGRATION), 1, 1, 0, 0, dynamicFP16   },
    {"msip",         "CLINT msip",                              0,     16,  8, VMI_NOREG,        readMSIP,         writeMSIP,     vmi_RA_RW, RV_GROUP(CLINT),       0, 0, 0, 0, presentCLINT  },
    {"mtimecmp",     "CLINT mtimecmp",                          0,     17, 64, VMI_NOREG,        readMTIMECMP,     writeMTIMECMP, vmi_RA_RW, RV_GROUP(CLINT),       0, 0, 0, 0, presentCLINT  },
    {"mtime",        "CLINT mtime",                             0,     18, 64, VMI_NOREG,        readMTIME,        writeMTIME,    vmi_RA_RW, RV_GROUP(CLINT),       1, 0, 0, 0, presentCLINT  },
    PMP_CFG_0_15(19),
    PMP_ADDR_0_63(35),

    // KEEP LAST
    {0}
};

//
// Is the supplemental register present?
//
static Bool isSupPresent(riscvP riscv, supDetailsCP this) {

    riscvArchitecture required = this->arch;
    riscvArchitecture actual   = riscv->configInfo.arch;
    Bool              present  = True;

    if(this->present && !this->present(riscv, this)) {

        // excluded by presence callback
        present = False;

    } else if(required) {

        // one or more of the specified features is required
        present = (required & actual);
    }

    return present;
}

//
// Given the previous supplemental register, return the next one for this
// variant. Note that no integration support registers are returned in the
// client debug interface view (RSP 'g' and 'p' packets), indicated by 'normal'
// being False.
//
static supDetailsCP getNextSupDetails(
    riscvP       riscv,
    supDetailsCP prev,
    Bool         normal
) {
    supDetailsCP this = prev ? prev+1 : supRegs;

    while(
        this->name &&
        (
            !isSupPresent(riscv, this) ||
            (
                !normal &&
                (this->group==RV_GROUP(INTEGRATION))
            )
        )
    ) {
        this++;
    }

    return this->name ? this : 0;
}

//
// Given the previous extension register, return the next one for this
// variant.
//
static riscvRegListP getNextExtReg(
    riscvP        riscv,
    riscvRegListP prev,
    Bool          normal
) {
    riscvRegListP this = 0;

    if(prev) {
        this = prev->next;
    } else {
        this = riscv->extRegHead;
    }

    return this;
}


////////////////////////////////////////////////////////////////////////////////
// REGISTER ACCESS FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Return any child of the passed processor
//
inline static riscvP getChild(riscvP riscv) {
    return (riscvP)vmirtGetSMPChild((vmiProcessorP)riscv);
}

//
// Read processor PC
//
static VMI_REG_READ_FN(readPC) {

    riscvP riscv = (riscvP)processor;
    Uns32  bits  = riscvGetXlenArch(riscv);
    Uns64  pc    = vmirtGetPC(processor);

    if(bits==32) {
        *(Uns32*)buffer = pc;
    } else {
        *(Uns64*)buffer = pc;
    }

    return True;
}

//
// Write processor PC
//
static VMI_REG_WRITE_FN(writePC) {

    riscvP riscv = (riscvP)processor;
    Uns32  bits  = riscvGetXlenMode(riscv);
    Uns64  pc    = (bits==32) ? *(Uns32*)buffer : *(Uns64*)buffer;

    vmirtSetPC(processor, pc);

    return True;
}

//
// Return CSR register attributes
//
inline static riscvCSRAttrsCP getCSRAttrs(vmiRegInfoCP reg) {
    return reg->userData;
}

//
// Read callback for AArch64 system register, current view
//
static VMI_REG_READ_FN(readCSR) {

    riscvP riscv = (riscvP)processor;
    Bool   old   = riscv->artifactAccess;

    riscv->artifactAccess = True;
    Bool ok = riscvReadCSR(getCSRAttrs(reg), riscv, buffer);
    riscv->artifactAccess = old;

    return ok;
}

//
// Write callback for AArch64 system register, current view
//
static VMI_REG_WRITE_FN(writeCSR) {

    riscvP riscv = (riscvP)processor;
    Bool   old   = riscv->artifactAccess;

    riscv->artifactAccess = True;
    Bool ok = riscvWriteCSR(getCSRAttrs(reg), riscv, buffer);
    riscv->artifactAccess = old;

    return ok;
}

//
// Return special purpose of the indexed GPR, if any
//
static vmiRegUsage getGPRUsage(Uns32 i) {

    if(i==RV_REG_X_RA) {
        return vmi_REG_LR;
    } else if(i==RV_REG_X_SP) {
        return vmi_REG_SP;
    } else {
        return vmi_REG_NONE;
    }
}

//
// Should the CSR be excluded from trace change?
//
static Bool getCSRNoTraceChange(riscvP riscv, riscvCSRTrace traceMode) {
    return (
        (traceMode==RCSRT_NO) ||
        ((traceMode==RCSRT_VOLATILE) && !riscv->traceVolatile)
    );
}

//
// Return number of GPRs (see below for meaning of 'normal' parameter)
//
inline static Uns32 getGPRNum(riscvP riscv, Bool normal) {
    return (!normal || (riscv->configInfo.arch&ISA_I)) ? 32 : 16;
}

//
// Return number of FPRs
//
inline static Uns32 getFPRNum(riscvP riscv) {
    return (riscv->configInfo.arch&ISA_DF) && !Zfinx(riscv) ? 32 : 0;
}

//
// Return number of vector registers
//
inline static Uns32 getVRNum(riscvP riscv) {
    return vectorPresent(riscv) ? VREG_NUM : 0;
}

//
// Allocate register name
//
static const char *allocRegName(riscvP riscv, const char *name) {

    // free register name table
    if(!riscv->regNames) {
        riscv->regNames = oclSymbolTableCreate();
    }

    // return permanent name
    return oclSymbolName(oclSymbolFindAdd(riscv->regNames, name, 0));
}

//
// Return expanded pmpcfg register name
//
static const char *getPMPCFGName(riscvP riscv, Uns32 i, Uns32 XLEN) {

    Uns32 elemPerCSR = XLEN/8;
    Uns32 CSR        = (i/elemPerCSR) * (elemPerCSR/4);
    char  tmp[32];

    sprintf(tmp, "pmp%ucfg%u", i, CSR);

    return allocRegName(riscv, tmp);
}

//
// Return vmiReg for expanded pmpcfg register
//
static vmiReg getPMPCFGVMIReg(riscvP riscv, Uns32 i) {
    return vmimtGetExtReg((vmiProcessorP)riscv, &riscv->pmpcfg.u8[i]);
}

//
// Return register list (either normal or debug). When parameter 'normal' is
// True, all processor registers should be returned; when False, registers
// that should be reported using RSP 'g' or 'p' packets should be returned.
//
static vmiRegInfoCP getRegisters(riscvP riscv, Bool normal) {

    // create registers if they have not been created
    if(!riscv->regInfo[normal]) {

        Uns32           XLEN   = riscvGetXlenArch(riscv);
        Uns32           FLEN   = riscvGetFlenArch(riscv);
        Uns32           gprNum = getGPRNum(riscv, normal);
        Uns32           fprNum = getFPRNum(riscv);
        Uns32           vrNum  = getVRNum(riscv);
        Uns32           regNum = 0;
        Uns32           csrNum;
        Uns32           pmpcfgNum;
        riscvCSRDetails csrDetails;
        supDetailsCP    supDetails;
        riscvRegListP   extReg;
        vmiRegInfoP     dst;
        Uns32           i;

        // count GPR entries
        regNum += gprNum;

        // count PC
        regNum++;

        // count FPR entries
        regNum += fprNum;

        // count VR entries
        regNum += vrNum;

        // count visible CSRs
        csrNum = 0;
        while(riscvGetCSRDetails(riscv, &csrDetails, &csrNum)) {
            regNum++;
        }

        // count visible supplemental registers
        supDetails = 0;
        while((supDetails=getNextSupDetails(riscv, supDetails, normal))) {
            regNum++;
        }

        // count visible extension registers
        extReg = 0;
        while((extReg=getNextExtReg(riscv, extReg, normal))) {
            regNum++;
        }

        // count expanded pmpcfg registers
        pmpcfgNum = riscv->configInfo.PMP_registers;
        regNum += pmpcfgNum;

        // allocate register information, including terminating NULL entry
        dst = riscv->regInfo[normal] = STYPE_CALLOC_N(vmiRegInfo, regNum+1);

        // fill GPR entries
        for(i=0; i<gprNum; i++) {
            dst->name     = riscvGetXRegName(riscv, i);
            dst->group    = RV_GROUP(CORE);
            dst->bits     = XLEN;
            dst->gdbIndex = i;
            dst->access   = i ? vmi_RA_RW    : vmi_RA_R;
            dst->raw      = i ? RISCV_GPR(i) : VMI_NOREG;
            dst->usage    = getGPRUsage(i);
            dst++;
        }

        // fill PC entry
        {
            dst->name     = "pc";
            dst->group    = RV_GROUP(CORE);
            dst->bits     = XLEN;
            dst->gdbIndex = i++;
            dst->access   = vmi_RA_RW;
            dst->readCB   = readPC;
            dst->writeCB  = writePC;
            dst->usage    = vmi_REG_PC;
            dst++;
        }

        // fill FPR entries
        for(i=0; i<fprNum; i++) {
            dst->name     = riscvGetFRegName(riscv, i);
            dst->group    = RV_GROUP(FP);
            dst->bits     = FLEN;
            dst->gdbIndex = i+RISCV_FPR0_INDEX;
            dst->access   = vmi_RA_RW;
            dst->raw      = RISCV_FPR(i);
            dst++;
        }

        // fill VR entries
        for(i=0; i<vrNum; i++) {
            dst->name     = riscvGetVRegName(riscv, i);
            dst->group    = RV_GROUP(V);
            dst->bits     = riscv->configInfo.VLEN;
            dst->gdbIndex = i+RISCV_V0_INDEX;
            dst->access   = vmi_RA_RW;
            dst->raw      = riscvGetVReg(riscv, i);
            dst++;
        }

        // fill visible CSRs
        csrNum = 0;
        while(riscvGetCSRDetails(riscv, &csrDetails, &csrNum)) {
            riscvCSRAttrsCP attrs = csrDetails.attrs;
            dst->name          = attrs->name;
            dst->description   = attrs->desc;
            dst->group         = RV_GROUP(U_CSR+csrDetails.mode);
            dst->bits          = csrDetails.bits;
            dst->gdbIndex      = attrs->csrNum+RISCV_CSR0_INDEX;
            dst->access        = csrDetails.access;
            dst->raw           = csrDetails.raw;
            dst->readCB        = csrDetails.rdRaw ? 0 : readCSR;
            dst->writeCB       = csrDetails.wrRaw ? 0 : writeCSR;
            dst->userData      = (void *)attrs;
            dst->noSaveRestore = attrs->noSaveRestore;
            dst->noTraceChange = getCSRNoTraceChange(riscv, attrs->noTraceChange);
            dst->extension     = csrDetails.extension;
            dst++;
        }

        // fill visible integration support registers
        supDetails = 0;
        while((supDetails=getNextSupDetails(riscv, supDetails, normal))) {
            dst->name            = supDetails->name;
            dst->description     = supDetails->desc;
            dst->group           = supDetails->group;
            dst->bits            = supDetails->bits ? : XLEN;
            dst->gdbIndex        = supDetails->index+RISCV_SUP0_INDEX;
            dst->access          = supDetails->access;
            dst->raw             = supDetails->raw;
            dst->readCB          = supDetails->readCB;
            dst->writeCB         = supDetails->writeCB;
            dst->noTraceChange   = supDetails->noTraceChange;
            dst->noSaveRestore   = supDetails->noSaveRestore;
            dst->instrAttrIgnore = supDetails->instrAttrIgnore;
            dst->userData        = supDetails->userData;
            dst++;
        }

        // fill expanded pmpcfg integration support registers
        for(i=0; i<pmpcfgNum; i++) {
            dst->name     = getPMPCFGName(riscv, i, XLEN);
            dst->group    = RV_GROUP(INTEGRATION);
            dst->bits     = 8;
            dst->gdbIndex = i+RISCV_PMPCFG_INDEX;
            dst->access   = vmi_RA_R;
            dst->raw      = getPMPCFGVMIReg(riscv, i);
            dst++;
        }

        // fill visible extension registers
        extReg = 0;
        while((extReg=getNextExtReg(riscv, extReg, normal))) {
            *dst = extReg->reg;
            dst->gdbIndex |= RISCV_EXT_INDEX;
            dst++;
        }
    }

    // return head of register list
    return riscv->regInfo[normal];
}

//
// Is the register visible in this view?
//
static Bool isRegVisible(vmiRegInfoCP reg, vmiRegInfoType type) {
    if(type==VMIRIT_NORMAL) {
        return True;
    } else if(type==VMIRIT_GPACKET) {
        return (reg->group==RV_GROUP(CORE));
    } else {
        return (reg->group!=RV_GROUP(CORE));
    }
}

//
// Return next supported register on this processor
//
static vmiRegInfoCP getNextRegister(
    riscvP         riscv,
    vmiRegInfoCP   reg,
    vmiRegInfoType type
) {
    do {
        if(!reg) {
            reg = getChild(riscv) ? 0 : getRegisters(riscv, type==VMIRIT_NORMAL);
        } else if((reg+1)->name) {
            reg = reg+1;
        } else {
            reg = 0;
        }
    } while(reg && !isRegVisible(reg, type));

    return reg;
}

//
// Is the passed register group supported on this processor?
//
static Bool isGroupSupported(riscvP riscv, vmiRegGroupCP group) {

    vmiRegInfoCP info = 0;

    while((info=getNextRegister(riscv, info, VMIRIT_NORMAL))) {
        if(info->group == group) {
            return True;
        }
    }

    return False;
}

//
// Is the group a standard RISC-V register group?
//
static Bool isStandardGroup(vmiRegGroupCP group) {
    return (group>=&groups[0]) && (group<=&groups[RV_RG_LAST-1]);
}

//
// Return next supported extension-defined group on this processor
//
static vmiRegGroupCP getNextExtensionGroup(riscvP riscv, vmiRegGroupCP prev) {

    vmiRegGroupCP result = 0;
    vmiRegInfoCP  info   = 0;

    while((info=getNextRegister(riscv, info, VMIRIT_NORMAL))) {

        vmiRegGroupCP try = info->group;

        if(!try) {
            // no action
        } else if(isStandardGroup(try)) {
            // no action
        } else if(try<=prev) {
            // no action
        } else if(!result || (result>try)) {
            result = try;
        }
    }

    return result;
}

//
// Return next supported group on this processor
//
static vmiRegGroupCP getNextGroup(riscvP riscv, vmiRegGroupCP group) {

    // scan for next standard group
    do {
        if(!group) {
            group = groups;
        } else if(!isStandardGroup(group)) {
            break;
        } else if((group+1)->name) {
            group = group+1;
        } else {
            group = 0;
        }
    } while(group && !isGroupSupported(riscv, group));

    // scan for next extension-defined group
    if(!group || !isStandardGroup(group)) {
        group = getNextExtensionGroup(riscv, group);
    }

    return group;
}

//
// Return next register group
//
VMI_REG_GROUP_FN(riscvRegGroup) {
    return getNextGroup((riscvP)processor, prev);
}

//
// Return next register for the passed view
//
VMI_REG_INFO_FN(riscvRegInfo) {
    return getNextRegister((riscvP)processor, prev, gdbFrame);
}

//
// Add extension register to debug interface
//
void riscvNewExtReg(riscvP riscv, vmiRegInfoCP src) {

    riscvRegListP this = STYPE_CALLOC(riscvRegList);
    vmiRegInfoP   dst  = &this->reg;

    // copy template register
    *dst = *src;

    // create local copies of name and description
    if(dst->name) {
        dst->name = strdup(dst->name);
    }
    if(dst->description) {
        dst->description = strdup(dst->description);
    }

    // use default group if none is given
    if(!dst->group) {
        dst->group = &groups[RV_RG_EXTENSION];
    }

    // add to tail of list
    if(riscv->extRegTail) {
        riscv->extRegTail->next = this;
    } else {
        riscv->extRegHead = this;
    }

    // update tail
    riscv->extRegTail = this;
}

//
// Free register descriptions, if they have been allocated
//
void riscvFreeRegInfo(riscvP riscv) {

    riscvRegListP extReg;
    Uns32         i;

    // free register name table
    if(riscv->regNames) {
        oclSymbolTableDestroy(riscv->regNames);
    }

    // free extension register templates
    while((extReg=riscv->extRegHead)) {

        riscv->extRegHead = extReg->next;

        // free local copies of name and description
        if(extReg->reg.name) {
            free((char*)extReg->reg.name);
        }
        if(extReg->reg.description) {
            free((char*)extReg->reg.description);
        }

        STYPE_FREE(extReg);
    }

    // free register descriptions
    for(i=0; i<2; i++) {
        if(riscv->regInfo[i]) {
            STYPE_FREE(riscv->regInfo[i]);
            riscv->regInfo[i] = 0;
        }
    }
}

//
// Helper macro for defining register implementations
//
#define RISCV_REG_IMPL_RAW(_REG, _FIELD, _BITS) \
    vmirtRegImplRaw(processor, _REG, _FIELD, _BITS)

//
// Helper macro for defining field-to-register mappings
//
#define RISCV_FIELD_IMPL_RAW(_REGINFO, _FIELD) { \
    Uns32 bits = sizeof(((riscvP)0)->_FIELD) * 8;               \
    RISCV_REG_IMPL_RAW(_REGINFO, RISCV_CPU_REG(_FIELD), bits);  \
}

//
// Helper macro for defining ignored fields
//
#define RISCV_FIELD_IMPL_IGNORE(_FIELD) \
    RISCV_FIELD_IMPL_RAW(0, _FIELD)

//
// Specify vmiReg-to-vmiRegInfoCP correspondence for registers for which this
// cannot be automatically derived
//
VMI_REG_IMPL_FN(riscvRegImpl) {

    // specify that fpFlags is in fflags
    vmiRegInfoCP fflags = vmirtGetRegByName(processor, "fflags");
    RISCV_FIELD_IMPL_RAW(fflags, fpFlagsMT);

    // specify that SFMT is in vxsat
    vmiRegInfoCP vxsat = vmirtGetRegByName(processor, "vxsat");
    RISCV_FIELD_IMPL_RAW(vxsat, SFMT);

    // exclude artifact registers
    RISCV_FIELD_IMPL_IGNORE(atomic);
    RISCV_FIELD_IMPL_IGNORE(HLVHSV);
    RISCV_FIELD_IMPL_IGNORE(CMO);
    RISCV_FIELD_IMPL_IGNORE(CMOOffset);
    RISCV_FIELD_IMPL_IGNORE(CMOBytes);
    RISCV_FIELD_IMPL_IGNORE(pmKey);
    RISCV_FIELD_IMPL_IGNORE(vlEEW1);
    RISCV_FIELD_IMPL_IGNORE(vFirstFault);
    RISCV_FIELD_IMPL_IGNORE(vPreserve);
    RISCV_FIELD_IMPL_IGNORE(vBase);
    RISCV_FIELD_IMPL_IGNORE(jumpBase);
    RISCV_FIELD_IMPL_IGNORE(currentArch);
    RISCV_FIELD_IMPL_IGNORE(triggerVA);
    RISCV_FIELD_IMPL_IGNORE(triggerLV);
    RISCV_FIELD_IMPL_IGNORE(fpFlagsI);
}


////////////////////////////////////////////////////////////////////////////////
// MEMORY ACCESS TRACE ELABORATION
////////////////////////////////////////////////////////////////////////////////

//
// Patch vmiRegInfo objects for CSRs that use the CSR bus so that callbacks are
// always used
//
static void patchCSRBusCallbacksInt(riscvP riscv, Bool normal) {

    vmiRegInfoP this;

    for(this=riscv->regInfo[normal]; this && this->name; this++) {

        if(
            (this->group==RV_GROUP(U_CSR)) ||
            (this->group==RV_GROUP(S_CSR)) ||
            (this->group==RV_GROUP(H_CSR)) ||
            (this->group==RV_GROUP(M_CSR))
        ) {
            riscvCSRAttrsCP attrs = this->userData;

            if(riscvCSRImplementExternalRead(attrs, riscv, True)) {
                this->readCB = readCSR;
            }

            if(riscvCSRImplementExternalWrite(attrs, riscv)) {
                this->writeCB = writeCSR;
            }
        }
    }
}

//
// If the CSR bus is used, it is possible that this could be connected or
// filled *after* the first access to a register through the OP/ICM interface,
// in which case vmiRegInfo entries implemented using the CSR bus must be
// modified to use callbacks here
//
void riscvPatchCSRBusCallbacks(riscvP riscv) {

    if(riscvGetExternalCSRDomain(riscv)) {
        patchCSRBusCallbacksInt(riscv, False);
        patchCSRBusCallbacksInt(riscv, True);
    }
}


////////////////////////////////////////////////////////////////////////////////
// MEMORY ACCESS TRACE ELABORATION
////////////////////////////////////////////////////////////////////////////////

//
// Return elaboration string for memory accesses
//
VMI_TRACE_MEM_ATTRS_FN(riscvTraceMemAttrs) {

    riscvP riscv = (riscvP)processor;
    char  *attrs = 0;

    if(riscv->PTWActive) {
        attrs = riscv->tmpString;
        sprintf(attrs, "L%u", riscv->PTWLevel);
    }

    return attrs;
}


////////////////////////////////////////////////////////////////////////////////
// PROCESSOR DESCRIPTION
////////////////////////////////////////////////////////////////////////////////

//
// Return processor description
//
VMI_PROC_DESC_FN(riscvProcessorDescription) {

    riscvP      riscv  = (riscvP)processor;
    const char *result = "Hart";

    if(riscvIsCluster(riscv)) {
        result = "Cluster";
    } else if(getChild(riscv)) {
        result = "SMP";
    }

    return result;
}

