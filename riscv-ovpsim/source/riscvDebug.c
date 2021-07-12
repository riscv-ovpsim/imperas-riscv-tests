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

// Imperas header files
#include "hostapi/impAlloc.h"

// VMI header files
#include "vmi/vmiAttrs.h"
#include "vmi/vmiDbg.h"
#include "vmi/vmiMessage.h"
#include "vmi/vmiMt.h"
#include "vmi/vmiRt.h"

// model header files
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
    RV_RG_INTEGRATION,  // integration support registers
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
    [RV_RG_INTEGRATION] = {name: "Integration_support"},
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
// This is the index of the first CSR
//
#define RISCV_CSR0_INDEX        65

//
// This is the index of the first ISR
//
#define RISCV_ISR0_INDEX        0x1100

//
// This is the index of the first vector register
//
#define RISCV_V0_INDEX          0x2000


////////////////////////////////////////////////////////////////////////////////
// INTEGRATION SUPPORT REGISTER ITERATION
////////////////////////////////////////////////////////////////////////////////

DEFINE_CS(isrDetails);

//
// Function type indicating ISR presence
//
#define ISR_PRESENT_FN(_NAME) Bool _NAME(riscvP riscv, isrDetailsCP this)
typedef ISR_PRESENT_FN((*isrPresentFn));

//
// Structure providing details of integration support registers
//
typedef struct isrDetailsS {
    const char       *name;
    const char       *desc;
    riscvArchitecture arch;
    Uns32             index;
    Uns32             bits;
    vmiReg            raw;
    vmiRegReadFn      readCB;
    vmiRegWriteFn     writeCB;
    vmiRegAccess      access;
    Bool              noTraceChange;
    Bool              noSaveRestore;
    Bool              instrAttrIgnore;
    isrPresentFn      present;
} isrDetails;

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
    return riscv->configInfo.debug_mode>=RVDM_HALT;
}

//
// Is fflags_i artifact register present?
//
static ISR_PRESENT_FN(presentFFlagsI) {
    return perInstructionFFlags(riscv);
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
// List of integration support registers
//
static const isrDetails isRegs[] = {

    {"LRSCAddress",  "LR/SC active lock address",               ISA_A,  0,  0, RISCV_EA_TAG,     0,                0,            vmi_RA_RW, 0, 0, 0, 0             },
    {"DM",           "Debug mode active",                       0,      1,  8, RISCV_DM,         0,                writeDM,      vmi_RA_RW, 0, 0, 0, presentDM     },
    {"DMStall",      "Debug mode stalled",                      0,      2,  8, RISCV_DM_STALL,   0,                writeDMStall, vmi_RA_RW, 0, 0, 0, presentDMStall},
    {"commercial",   "Commercial feature in use",               0,      3,  8, RISCV_COMMERCIAL, 0,                0,            vmi_RA_R,  0, 0, 0, 0             },
    {"PTWStage",     "PTW active stage (0:none 1:HS 2:VS 3:G)", ISA_S,  4,  8, VMI_NOREG,        readPTWStage,     0,            vmi_RA_R,  1, 1, 0, 0             },
    {"PTWInputAddr", "PTW input address",                       ISA_S,  5, 64, VMI_NOREG,        readPTWInputAddr, 0,            vmi_RA_R,  1, 1, 0, 0             },
    {"PTWLevel",     "PTW active level",                        ISA_S,  6,  8, VMI_NOREG,        readPTWLevel,     0,            vmi_RA_R,  1, 1, 0, 0             },
    {"fflags_i",     "Per-instruction floating point flags",    ISA_DF, 7,  8, VMI_NOREG,        readFFlagsI,      0,            vmi_RA_R,  0, 0, 1, presentFFlagsI},

    // KEEP LAST
    {0}
};

//
// Is the ISR present?
//
static Bool isISRPresent(riscvP riscv, isrDetailsCP this) {

    riscvArchitecture required = this->arch;
    riscvArchitecture actual   = riscv->configInfo.arch;
    Bool              present  = True;

    if(this->present && !this->present(riscv, this)) {

        // excluded by presence callback
        present = False;

    } else if(required & ISA_and) {

        // all specified features are required
        present = !(required & ~(actual|ISA_and));

    } else if(required) {

        // one or more of the specified features is required
        present = (required & actual);
    }

    return present;
}

//
// Given the previous integration support register, return the next one for this
// variant. Note that no integration support registers are returned in the
// client debug interface view (RSP 'g' and 'p' packets), indicated by 'normal'
// being False.
//
static isrDetailsCP getNextISRDetails(
    riscvP       riscv,
    isrDetailsCP prev,
    Bool         normal
) {
    if(normal) {

        isrDetailsCP this = prev ? prev+1 : isRegs;

        while(this->name && !isISRPresent(riscv, this)) {
            this++;
        }

        return this->name ? this : 0;

    } else {

        return 0;
    }
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
    return (riscv->configInfo.arch&ISA_V) ? VREG_NUM : 0;
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
        riscvCSRDetails csrDetails;
        isrDetailsCP    isrDetails;
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

        // count visible ISRs
        isrDetails = 0;
        while((isrDetails=getNextISRDetails(riscv, isrDetails, normal))) {
            regNum++;
        }

        // allocate register information, including terminating NULL entry
        dst = riscv->regInfo[normal] = STYPE_CALLOC_N(vmiRegInfo, regNum+1);

        // fill GPR entries
        for(i=0; i<gprNum; i++) {
            dst->name     = riscvGetXRegName(i);
            dst->group    = RV_GROUP(CORE);
            dst->bits     = XLEN;
            dst->gdbIndex = i;
            dst->access   = i ? vmi_RA_RW : vmi_RA_R;
            dst->raw      = RISCV_GPR(i);
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
            dst->name     = riscvGetFRegName(i);
            dst->group    = RV_GROUP(FP);
            dst->bits     = FLEN;
            dst->gdbIndex = i+RISCV_FPR0_INDEX;
            dst->access   = vmi_RA_RW;
            dst->raw      = RISCV_FPR(i);
            dst++;
        }

        // fill VR entries
        for(i=0; i<vrNum; i++) {
            dst->name     = riscvGetVRegName(i);
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

        // fill visible ISRs
        isrDetails = 0;
        while((isrDetails=getNextISRDetails(riscv, isrDetails, normal))) {
            dst->name            = isrDetails->name;
            dst->description     = isrDetails->desc;
            dst->group           = RV_GROUP(INTEGRATION);
            dst->bits            = isrDetails->bits ? : XLEN;
            dst->gdbIndex        = isrDetails->index+RISCV_ISR0_INDEX;
            dst->access          = isrDetails->access;
            dst->raw             = isrDetails->raw;
            dst->readCB          = isrDetails->readCB;
            dst->writeCB         = isrDetails->writeCB;
            dst->noTraceChange   = isrDetails->noTraceChange;
            dst->noSaveRestore   = isrDetails->noSaveRestore;
            dst->instrAttrIgnore = isrDetails->instrAttrIgnore;
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
// Return next supported group on this processor
//
static vmiRegGroupCP getNextGroup(riscvP riscv, vmiRegGroupCP group) {

    do {
        if(!group) {
            group = groups;
        } else if((group+1)->name) {
            group = group+1;
        } else {
            group = 0;
        }
    } while(group && !isGroupSupported(riscv, group));

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
// Free register descriptions, if they have been allocated
//
void riscvFreeRegInfo(riscvP riscv) {

    Uns32 i;

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

