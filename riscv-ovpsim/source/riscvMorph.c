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

// standard header files
#include <stdio.h>

// Imperas header files
#include "hostapi/impAlloc.h"

// VMI header files
#include "vmi/vmiMessage.h"
#include "vmi/vmiMt.h"
#include "vmi/vmiRt.h"

// model header files
#include "riscvBExtension.h"
#include "riscvBlockState.h"
#include "riscvCExtension.h"
#include "riscvCSRTypes.h"
#include "riscvDecode.h"
#include "riscvDecodeTypes.h"
#include "riscvExceptions.h"
#include "riscvFunctions.h"
#include "riscvKExtension.h"
#include "riscvMessage.h"
#include "riscvModelCallbackTypes.h"
#include "riscvMorph.h"
#include "riscvRegisters.h"
#include "riscvStructure.h"
#include "riscvTrigger.h"
#include "riscvTypeRefs.h"
#include "riscvUtils.h"
#include "riscvVM.h"


////////////////////////////////////////////////////////////////////////////////
// TYPES
////////////////////////////////////////////////////////////////////////////////

//
// Abstract type
//
DEFINE_S(iterDesc);

//
// Generic JIT code emission callback
//
#define RISCV_MORPH_FN(_NAME) void _NAME(riscvMorphStateP state)
typedef RISCV_MORPH_FN((*riscvMorphFn));

//
// Generic JIT code emission callback for vector element
//
#define RISCV_MORPHV_FN(_NAME) void _NAME(riscvMorphStateP state, iterDescP id)
typedef RISCV_MORPHV_FN((*riscvMorphVFn));

//
// Generic JIT code emission callback for vector element check
//
#define RISCV_CHECKV_FN(_NAME) Bool _NAME(riscvMorphStateP state, iterDescP id)
typedef RISCV_CHECKV_FN((*riscvCheckVFn));

//
// Function type to get extension operation callback
//
#define RISCV_OPCB_FN(_NAME) vmiCallFn _NAME(riscvMorphStateP state, Uns32 bits)
typedef RISCV_OPCB_FN((*riscvOpCBFn));


//
// Floating point control
//
typedef enum riscvFPCtrlE {

    // normal native operation configuration
    RVFP_NORMAL,

    // FMIN/FMAX configurations
    RVFP_FMIN,      // special for FMIN (2.2 specification)
    RVFP_FMAX,      // special for FMAX (2.2 specification)
    RVFP_FMIN_2_3,  // special for FMIN (2.3 specification)
    RVFP_FMAX_2_3,  // special for FMAX (2.3 specification)

    // estimation configurations
    RVFP_FRECE7,    // reciprocal estimate to 7 bits
    RVFP_FRSRE7,    // reciprocal square-root estimate to 7 bits

    RVFP_LAST       // KEEP LAST

} riscvFPCtrl;

//
// Vector argument types
//
typedef enum riscvVArgTypeE {
    RVVX_S1 = (1<<0),
    RVVX_S2 = (1<<1),
    RVVX_UU = 0,
    RVVX_SU = RVVX_S1,
    RVVX_US = RVVX_S2,
    RVVX_SS = RVVX_S1|RVVX_S2,
} riscvVArgType;

//
// Floating point compare relation
//
typedef enum riscvFPRelationE {
    RVFCMP_QNOK = 0x10,
    RVFCMP_ORD  = vmi_FPRL_EQUAL|vmi_FPRL_LESS|vmi_FPRL_GREATER    |RVFCMP_QNOK,
    RVFCMP_EQ   = vmi_FPRL_EQUAL                                   |RVFCMP_QNOK,
    RVFCMP_NE   = vmi_FPRL_LESS|vmi_FPRL_GREATER|vmi_FPRL_UNORDERED|RVFCMP_QNOK,
    RVFCMP_LT   = vmi_FPRL_LESS,
    RVFCMP_LE   = vmi_FPRL_LESS|vmi_FPRL_EQUAL,
    RVFCMP_GT   = vmi_FPRL_GREATER,
    RVFCMP_GE   = vmi_FPRL_GREATER|vmi_FPRL_EQUAL
} riscvFPRelation;

//
// Constraints on vstart
//
typedef enum riscvVStartTypeE {
    RVVS_NO_INT = 0,        // instruction not interruptible
    RVVS_ZERO,              // must be zero
    RVVS_ANY,               // any vstart value allowed
} riscvVStartType;

//
// P extension operation shape
//
typedef enum riscvPAttrsE {

                    // BASIC OPERATIONS
    RVPS_N = 0x01,  // narrowing operation
    RVPS_D = 0x02,  // doubling operation (after multiply)
    RVPS_X = 0x04,  // cross operands
    RVPS_W = 0x08,  // 32-bit element size
    RVPS_2 = 0x10,  // double indicated element size

                    // COMPOSITE OPERATIONS
    RVPS______ = 0,
    RVPS_ND___ = (RVPS_N|RVPS_D                     ),
    RVPS_ND_W_ = (RVPS_N|RVPS_D|       RVPS_W       ),
    RVPS_ND__2 = (RVPS_N|RVPS_D|              RVPS_2),
    RVPS_N____ = (RVPS_N                            ),
    RVPS_N__W_ = (RVPS_N|              RVPS_W       ),
    RVPS__D___ = (       RVPS_D                     ),
    RVPS__D__2 = (       RVPS_D|              RVPS_2),
    RVPS___X__ = (              RVPS_X              ),
    RVPS___XW_ = (              RVPS_X|RVPS_W       ),
    RVPS___X_2 = (              RVPS_X|       RVPS_2),
    RVPS____W_ = (                     RVPS_W       ),
    RVPS_____2 = (                            RVPS_2),

} riscvPAttrs;

//
// Attributes controlling JIT code translation
//
typedef struct riscvMorphAttrS {
    riscvMorphFn          morph;            // function to translate one instruction
    riscvCheckVFn         checkCB;          // called to check vector operation arguments
    riscvMorphVFn         initCB;           // called at start of vector operation
    riscvMorphVFn         opTCB;            // element operation when mask=1
    riscvMorphVFn         opFCB;            // element operation when mask=0
    riscvMorphVFn         endCB;            // called at end of vector operation
    riscvOpCBFn           opCB;             // called to get operation callback
    octiaInstructionClass iClass;           // supplemental instruction class
    riscvBExtOpSet        bExtOp;           // B-extension operation set
    Uns32                 offset     : 8;   // constant offset
    riscvKExtOp           kExtOp     : 8;   // K-extension operation
    vmiUnop               unop       : 8;   // integer unary operation
    vmiBinop              binop      : 8;   // integer binary operation
    vmiBinop              binop2     : 8;   // integer second binary operation
    vmiBinop              binop3     : 8;   // integer third binary operation
    vmiBinop              acc        : 8;   // accumulating binary operation
    vmiFUnop              fpUnop     : 8;   // floating-point unary operation
    vmiFBinop             fpBinop    : 8;   // floating-point binary operation
    vmiFTernop            fpTernop   : 8;   // floating-point ternary operation
    riscvFPCtrl           fpConfig   : 8;   // floating point configuration
    riscvFPRelation       fpRel      : 8;   // floating point comparison relation
    riscvVShape           vShape     : 8;   // vector operation shape
    riscvPAttrs           pAttrs     : 8;   // P-extension operation shape
    vmiCondition          cond       : 4;   // comparison condition
    riscvVArgType         argType    : 4;   // vector argument types
    riscvVStartType       vstart0    : 4;   // constraints on vstart=0
    Bool                  fpQNaNOk   : 1;   // allow QNaN in floating point compare?
    Bool                  clearFS1   : 1;   // clear FS1 sign (FSgn operation)
    Bool                  negFS2     : 1;   // negate FS2 sign (FSgn operation)
    Bool                  implicitTZ : 1;   // is top part implicitly set?
    Bool                  virtual    : 1;   // virtual machine operation?
    Bool                  execute    : 1;   // virtual machine execute operation?
    Bool                  ZfhminOK   : 1;   // compatible with Zfhmin?
} riscvMorphAttr;

//
// Context for JIT code translation (decoded instruction information and
// translation attributes)
//
typedef struct riscvMorphStateS {
    riscvInstrInfo   info;          // decoded instruction information
    riscvMorphAttrCP attrs;         // instruction attributes
    riscvP           riscv;         // current processor
    Bool             inDelaySlot;   // whether in delay slot
    Uns8             tmpIndex;      // next unallocated temporary index
    riscvVExternalFn externalCB;    // external implementation callback
    void            *userData;      // for externally-implemented operations
} riscvMorphState;


////////////////////////////////////////////////////////////////////////////////
// UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Return current program counter
//
inline static Uns64 getPC(riscvP riscv) {
    return vmirtGetPC((vmiProcessorP)riscv);
}

//
// Validate block mask
//
inline static void validateBlockMask(riscvArchitecture arch) {
    vmimtValidateBlockMaskR(sizeof(arch)*8, RISCV_BLOCK_MASK, arch);
}

//
// Validate feature is enabled using block mask if required
//
static Bool checkFeatureMT(
    riscvP            riscv,
    Bool              doCheckMT,
    riscvArchitecture feature
) {
    // validate feature blockMask if required
    if(doCheckMT) {
        validateBlockMask(feature);
    }

    // return current feature state
    return riscv->currentArch & feature;
}

//
// Return morph-time endianness for data accesses in the current mode
//
memEndian riscvGetCurrentDataEndianMT(riscvP riscv) {
    return checkFeatureMT(riscv, riscv->checkEndian, ISA_BE);
}

//
// Is morph-time trigger load address check required in the current mode?
//
inline static Bool triggerLoadAddressMT(riscvP riscv) {
    return checkFeatureMT(riscv, riscv->checkTriggerLA, ISA_TM_LA);
}

//
// Is morph-time trigger load value check required in the current mode?
//
inline static Bool triggerLoadValueMT(riscvP riscv) {
    return checkFeatureMT(riscv, riscv->checkTriggerLV, ISA_TM_LV);
}

//
// Is morph-time trigger store check required in the current mode?
//
inline static Bool triggerStoreMT(riscvP riscv) {
    return checkFeatureMT(riscv, riscv->checkTriggerS, ISA_TM_S);
}

//
// Is morph-time trigger execute check required in the current mode?
//
inline static Bool triggerExecuteMT(riscvP riscv) {
    return checkFeatureMT(riscv, riscv->checkTriggerX, ISA_TM_X);
}

//
// Is the given vmiReg the link register?
//
static Bool isLR(vmiReg r) {
    return VMI_REG_EQUAL(r, RISCV_LR);
}

//
// Disable instruction translation (test mode)
//
inline static Bool disableMorph(riscvMorphStateP state) {
    return RISCV_DISASSEMBLE(state->riscv);
}

//
// Get the currently-enabled architectural features
//
inline static riscvArchitecture getCurrentArch(riscvP riscv) {
    return riscv->currentArch;
}

//
// Validate current polymorphic block key
//
inline static void emitCheckPolymorphic(void) {
    vmimtPolymorphicBlock(16, RISCV_PM_KEY);
}

//
// Are only unit stride load/store instructions supported?
//
inline static Bool unitStrideOnly(riscvP riscv) {
    return riscv->configInfo.unitStrideOnly;
}

//
// Should vxsat and vxrm be treated as members of fcsr for dirty state update?
//
inline static Bool vxSatRMSetFSDirty(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_VS_STATUS_8);
}

//
// Is vcsr register present?
//
inline static Bool isVCSRPresent(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_VCSR_PRESENT);
}

//
// Do vector floating point instructions require mstatus.FS!=0?
//
inline static Bool vectorFPRequiresFSNZ(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_FP_REQUIRES_FSNZ);
}

//
// Are whole-register move instructions restricted?
//
inline static Bool vectorRestrictVMVR(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_RESTRICT_VMVR);
}

//
// Are whole-register load/store instructions restricted to 1 register?
//
inline static Bool vectorRestrictVLSR1(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_RESTRICT_VLSR1);
}

//
// Are whole-register load/store instructions restricted to power-of-2 registers?
//
inline static Bool vectorRestrictVLSRP2(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_RESTRICT_VLSRP2);
}

//
// Do whole-register instructions use the encoded EEW?
//
inline static Bool vectorWholeUsesEEW(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_VMVR_VLSR_EEW);
}

//
// Do vmv.x.s and vmv.s.x sign-extend short sources?
//
inline static Bool vectorSignExtVMVXS(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_SEXT_VMV_X_S);
}

//
// Is fractional LMUL supported?
//
inline static Bool vectorFractLMUL(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_FRACT_LMUL);
}

//
// Are agnostic mask and tail supported?
//
inline static Bool vectorAgnostic(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_AGNOSTIC);
}

//
// is MLEN always 1?
//
inline static Bool vectorMLEN1(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_MLEN1);
}

//
// are relaxed EEW overlap rules used?
//
inline static Bool vectorEEWOverlap(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_EEW_OVERLAP);
}

//
// Are fault-only-first instructions absent?
//
inline static Bool vectorNoFaultOnlyFirst(riscvP riscv) {
    return riscv->configInfo.noFaultOnlyFirst;
}


////////////////////////////////////////////////////////////////////////////////
// ILLEGAL INSTRUCTION HANDLING (REQUIRING PROCESSOR ONLY)
////////////////////////////////////////////////////////////////////////////////

//
// Function to emit an exception
//
#define EMIT_EXCEPTION_FN(_NAME) void _NAME(void)
typedef EMIT_EXCEPTION_FN((*emitExceptionFn));

//
// Emit call to take Illegal Instruction exception
//
static void emitIllegalInstruction(void) {
    vmimtArgProcessor();
    vmimtCallAttrs((vmiCallFn)riscvIllegalInstruction, VMCA_EXCEPTION);
}

//
// Emit call to take Virtual Instruction exception
//
static void emitVirtualInstruction(void) {
    vmimtArgProcessor();
    vmimtCallAttrs((vmiCallFn)riscvVirtualInstruction, VMCA_EXCEPTION);
}

//
// Emit Illegal Instruction description message
//
static void illegalInstructionMessage(riscvP riscv, const char *reason) {
    vmiMessage("W", CPU_PREFIX "_ILL",
        SRCREF_FMT "%s",
        SRCREF_ARGS(riscv, getPC(riscv)),
        reason
    );
}

//
// Emit Illegal Instruction description message
//
static void illegalInstructionMessageDesc(riscvP riscv, illegalDescP desc) {
    vmiMessage("W", desc->id,
        SRCREF_FMT "%s",
        SRCREF_ARGS(riscv, getPC(riscv)),
        desc->detail
    );
}

//
// Emit code to take exception for the given reason
//
static void emitIllegalInstructionMessage(
    riscvP          riscv,
    const char     *reason,
    emitExceptionFn emitException
) {
    if(riscv->verbose) {
        vmimtArgProcessor();
        vmimtArgNatAddress(reason);
        vmimtCall((vmiCallFn)illegalInstructionMessage);
    }

    // take exception
    emitException();
}

//
// Emit code to take exception for the given reason using descriptor
//
static void emitIllegalInstructionMessageDesc(
    riscvP          riscv,
    illegalDescP    desc,
    emitExceptionFn emitException
) {
    if(riscv->verbose) {
        vmimtArgProcessor();
        vmimtArgNatAddress(desc);
        vmimtCall((vmiCallFn)illegalInstructionMessageDesc);
    }

    // take exception
    emitException();
}

//
// Emit code to take an Illegal Instruction exception for the given reason
//
void riscvEmitIllegalInstructionMessage(riscvP riscv, const char *reason) {
    emitIllegalInstructionMessage(riscv, reason, emitIllegalInstruction);
}

//
// Emit code to take a Virtual Instruction exception for the given reason
//
void riscvEmitVirtualInstructionMessage(riscvP riscv, const char *reason) {
    emitIllegalInstructionMessage(riscv, reason, emitVirtualInstruction);
}

//
// Emit Illegal Instruction message and take Illegal Instruction exception
//
void riscvEmitIllegalInstructionMessageDesc(riscvP riscv, illegalDescP desc) {
    emitIllegalInstructionMessageDesc(riscv, desc, emitIllegalInstruction);
}

//
// Emit Illegal Instruction message and take Virtual Instruction exception
//
void riscvEmitVirtualInstructionMessageDesc(riscvP riscv, illegalDescP desc) {
    emitIllegalInstructionMessageDesc(riscv, desc, emitVirtualInstruction);
}

//
// Emit Illegal Instruction description message
//
static void illegalOperandMessageDesc(
    riscvP       riscv,
    illegalDescP desc,
    Uns32        operand
) {
    vmiMessage("W", desc->id,
        SRCREF_FMT "Operand %u %s",
        SRCREF_ARGS(riscv, getPC(riscv)),
        operand,
        desc->detail
    );
}

//
// Emit Illegal Operand message and take Illegal Instruction exception
//
void riscvEmitIllegalOperandMessageDesc(
    riscvP       riscv,
    illegalDescP desc,
    Uns32        operand
) {
    // emit message in verbose mode
    if(riscv->verbose) {
        vmimtArgProcessor();
        vmimtArgNatAddress(desc);
        vmimtArgUns32(operand+1);
        vmimtCall((vmiCallFn)illegalOperandMessageDesc);
    }

    // take Illegal Instruction exception
    emitIllegalInstruction();
}

//
// Get description for the first feature identified by the given feature id
//
static const char *getFeatureDesc(riscvArchitecture feature) {

    // get feature description
    const char *description = riscvGetFeatureName(feature);

    // sanity check description is valid
    VMI_ASSERT(
        description,
        "require non-zero feature name (feature %c)",
        riscvGetFeatureChar(feature)
    );

    return description;
}

//
// Take Illegal Instruction exception when feature is absent or not enabled
//
static void illegalInstructionInactiveArch(
    riscvP            riscv,
    riscvArchitecture missing,
    const char       *detail
) {
    char reason[128];

    if(riscv->verbose) {
        snprintf(
            SNPRINTF_TGT(reason), "%s %s",
            getFeatureDesc(missing), detail
        );
    }

    riscvIllegalInstructionMessage(riscv, reason);
}

//
// Take Illegal Instruction exception irrespective of feature presence
//
static void illegalInstruction(riscvP riscv) {
    riscvIllegalInstructionMessage(riscv, 0);
}

//
// Take Illegal Instruction exception in special case that FS=0
//
static void illegalInstructionFS0(riscvP riscv) {
    riscvIllegalInstructionMessage(riscv, "mstatus.FS=0");
}

//
// Take Illegal Instruction exception when feature is disabled
//
static void illegalInstructionDisabledArch(
    riscvP            riscv,
    riscvArchitecture disabled
) {
    illegalInstructionInactiveArch(riscv, disabled, "is disabled");
}

//
// Take Illegal Instruction exception when feature is absent
//
static void illegalInstructionAbsentArch(
    riscvP            riscv,
    riscvArchitecture missing
) {
    illegalInstructionInactiveArch(riscv, missing, "is absent");
}

//
// Emit code to take Illegal Instruction exception when feature is absent or not
// enabled
//
static void emitIllegalInstructionDisabledArch(riscvArchitecture disabled) {
    vmimtArgProcessor();
    vmimtArgUns32(disabled);
    vmimtCallAttrs((vmiCallFn)illegalInstructionDisabledArch, VMCA_EXCEPTION);
}

//
// Emit code to take Illegal Instruction exception when feature is absent or not
// enabled
//
static void emitIllegalInstructionAbsentArch(riscvArchitecture missing) {

    vmimtArgProcessor();

    if(!missing) {
        vmimtCallAttrs((vmiCallFn)illegalInstruction, VMCA_EXCEPTION);
    } else if(missing==ISA_FS) {
        vmimtCallAttrs((vmiCallFn)illegalInstructionFS0, VMCA_EXCEPTION);
    } else {
        vmimtArgUns32(missing);
        vmimtCallAttrs((vmiCallFn)illegalInstructionAbsentArch, VMCA_EXCEPTION);
    }
}

//
// Emit code to indicate that a custom instruction is not present if verbose
//
static void emitCustomAbsent() {
    emitIllegalInstructionAbsentArch(ISA_X);
}

//
// Take Illegal Instruction exception when subset is in the given state
//
static void illegalInstructionSubset(
    riscvP      riscv,
    const char *name,
    const char *state
) {
    char reason[64];

    if(riscv->verbose) {
        snprintf(SNPRINTF_TGT(reason), "%s %s", name, state);
    }

    // take Illegal Instruction exception
    riscvIllegalInstructionMessage(riscv, reason);
}

//
// Take Illegal Instruction exception when subset is absent
//
inline static void illegalInstructionAbsentSubset(
    riscvP      riscv,
    const char *name
) {
    illegalInstructionSubset(riscv, name, "absent");
}

//
// Take Illegal Instruction exception when subset is present
//
inline static void illegalInstructionPresentSubset(
    riscvP      riscv,
    const char *name
) {
    illegalInstructionSubset(riscv, name, "present");
}

//
// Emit code to take Illegal Instruction exception when a feature subset is
// absent
//
void riscvEmitIllegalInstructionAbsentSubset(const char *name) {
    vmimtArgProcessor();
    vmimtArgNatAddress(name);
    vmimtCallAttrs((vmiCallFn)illegalInstructionAbsentSubset, VMCA_EXCEPTION);
}

//
// Emit code to take Illegal Instruction exception when a feature subset is
// present
//
void riscvEmitIllegalInstructionPresentSubset(const char *name) {
    vmimtArgProcessor();
    vmimtArgNatAddress(name);
    vmimtCallAttrs((vmiCallFn)illegalInstructionPresentSubset, VMCA_EXCEPTION);
}

//
// Use block mask to validate the value of architectural features that can
// change at run time
//
static void emitBlockMask(riscvP riscv, riscvArchitecture feature) {

    // instruction width is implemented using a different code dictionary,
    // so block mask check is not required
    feature &= ~ISA_XLEN_ANY;

    // select features that can change dynamically
    feature &= (riscv->configInfo.archMask|ISA_DYNAMIC);

    // emit block mask check for dynamic features
    if(feature) {
        validateBlockMask(feature);
    }
}

//
// Determine if the given required feature is present and enabled (using
// blockMask if necessary)
//
static Bool isFeaturePresentMT(riscvP riscv, riscvArchitecture feature) {

    riscvArchitecture current = getCurrentArch(riscv);
    riscvArchitecture actual  = current & feature;
    riscvArchitecture present = feature & actual;

    // validate values of fields that can change at run time
    emitBlockMask(riscv, feature);

    return present;
}

//
// Validate that the given required features are present and enabled (using
// blockMask if necessary)
//
Bool riscvRequireArchPresentMT(riscvP riscv, riscvArchitecture required) {

    Bool              all = required & ISA_and;
    riscvArchitecture bad = 0;

    // mask off indication of whether *all* A-Z features are required
    required &= ~ISA_and;

    if(required) {

        riscvArchitecture current  = getCurrentArch(riscv);
        riscvArchitecture actual   = current & required;
        riscvArchitecture absent   = required & ~actual;
        riscvArchitecture features = RISCV_FEATURE_MASK;
        riscvArchitecture disabled;

        if(all) {
            // all features must match exactly
            bad = absent;
        } else if((required & features) && !(actual & features)) {
            // at least one A-Z feature must match
            bad = required & features;
        } else if(absent & ~features) {
            // non-A-Z features must always match exactly
            bad = absent & ~features;
        }

        // validate values of fields that can change at run time
        emitBlockMask(riscv, required);

        // handle absent or disabled feature
        if(!bad) {
            // no action
        } else if((disabled=(bad&riscv->configInfo.arch))) {
            emitIllegalInstructionDisabledArch(disabled);
        } else {
            emitIllegalInstructionAbsentArch(bad);
        }
    }

    return !bad;
}

//
// Emit blockMask check for the given feature set
//
void riscvEmitBlockMask(riscvP riscv, riscvArchitecture features) {

    if(features) {
        emitBlockMask(riscv, features);
    }
}

//
// Validate that the given required feature is enabled (using blockMask if
// necessary)
//
static Bool requireMISAMT(riscvP riscv, char feature) {

    // sanity check missing is valid
    VMI_ASSERT(feature, "require non-zero feature letter");

    return riscvRequireArchPresentMT(riscv, 1<<(feature-'A'));
}

//
// Validate that the instruction is supported and enabled and take an Illegal
// Instruction exception if not
//
Bool riscvInstructionEnabled(riscvP riscv, riscvArchitecture requiredVariant) {

    // get current XLEN
    Uns32             XLEN     = riscvGetXlenMode(riscv);
    riscvArchitecture XLENarch = (XLEN==32) ? ISA_XLEN_32 : ISA_XLEN_64;

    // check whether instruction is supported for the current XLEN
    if(!(requiredVariant & XLENarch)) {
        emitIllegalInstructionAbsentArch(requiredVariant & ISA_XLEN_ANY);
        return False;
    }

    // validate remaining architectural feature requirements
    return riscvRequireArchPresentMT(riscv, requiredVariant & ~ISA_XLEN_ANY);
}

//
// Emit Illegal Instruction because the current mode has insufficient
// privilege
//
void riscvEmitIllegalInstructionMode(riscvP riscv) {

    riscvMode mode = getCurrentMode5(riscv);

    switch(mode) {
        case RISCV_MODE_S:
            ILLEGAL_INSTRUCTION_MESSAGE(
                riscv, "UDM", "Illegal in Supervisor mode"
            );
            break;
        case RISCV_MODE_U:
            ILLEGAL_INSTRUCTION_MESSAGE(
                riscv, "UDM", "Illegal in User mode"
            );
            break;
        case RISCV_MODE_VS:
            ILLEGAL_INSTRUCTION_MESSAGE(
                riscv, "UDM", "Illegal in Virtual Supervisor mode"
            );
            break;
        case RISCV_MODE_VU:
            ILLEGAL_INSTRUCTION_MESSAGE(
                riscv, "UDM", "Illegal in Virtual User mode"
            );
            break;
        default:
            VMI_ABORT("Unexpected mode %u", mode); // LCOV_EXCL_LINE
            break;
    }
}

//
// Emit Illegal Instruction because the current virtual mode has insufficient
// privilege
//
void riscvEmitVirtualInstructionMode(riscvP riscv) {

    riscvMode mode = getCurrentMode5(riscv);

    switch(mode) {
        case RISCV_MODE_VS:
            VIRTUAL_INSTRUCTION_MESSAGE(
                riscv, "UDM", "Illegal in Virtual Supervisor mode"
            );
            break;
        case RISCV_MODE_VU:
            VIRTUAL_INSTRUCTION_MESSAGE(
                riscv, "UDM", "Illegal in Virtual User mode"
            );
            break;
        default:
            VMI_ABORT("Unexpected mode %u", mode); // LCOV_EXCL_LINE
            break;
    }
}

//
// Validate that the processor is executing at or above the given mode
//
static Bool requireModeMT(riscvP riscv, riscvMode required) {

    riscvMode actual = getCurrentMode3(riscv);
    Bool      ok     = (actual>=required);

    if(ok) {
        // no action
    } else if((required==RISCV_MODE_M) || !inVMode(riscv)) {
        riscvEmitIllegalInstructionMode(riscv);
    } else {
        riscvEmitVirtualInstructionMode(riscv);
    }

    return ok;
}

//
// Validate the hart operation mode is at least the specified mode and emit an
// Illegal Instruction or Virtual Instruction exception if not
//
Bool riscvEmitRequireMode(riscvP riscv, riscvMode mode) {
    return requireModeMT(riscv, getBaseMode(mode));
}

//
// Validate the hart is not in virtual mode and emit a Virtual Instruction
// exception if not
//
Bool riscvEmitRequireNotV(riscvP riscv) {

    Bool ok = !inVMode(riscv);

    if(!ok) {
        riscvEmitVirtualInstructionMode(riscv);
    }

    return ok;
}

//
// Validate that the processor is executing in Supervisor mode unless the
// required bit is set in the architecture, in which case U-mode is allowed
//
static Bool requireSIfNotArchMT(riscvP riscv, riscvArchitecture required) {

    Bool ok = True;

    if(getCurrentMode3(riscv)==RISCV_MODE_U) {

        riscvArchitecture arch = getCurrentArch(riscv);

        // in User mode, instruction is available only if the required feature
        // is enabled
        emitBlockMask(riscv, required);

        // validate at least Supervisor mode if required feature is disabled
        if(!(arch&required)) {
            requireModeMT(riscv, RISCV_MODE_S);
            ok = False;
        }
    }

    return ok;
}

//
// Validate that the processor has Supervisor mode enabled
//
static Bool checkHaveSModeMT(riscvP riscv) {

    riscvMode actual = getCurrentMode3(riscv);

    if(actual==RISCV_MODE_S) {

        // always ok if currently in Supervisor mode
        return True;

    } else {

        // otherwise, require 'S' mode to be present and enabled
        return requireMISAMT(riscv, 'S');
    }
}

//
// Validate that the processor has User mode enabled
//
static Bool checkHaveUModeMT(riscvP riscv) {

    riscvMode actual = getCurrentMode3(riscv);

    if(actual==RISCV_MODE_U) {

        // always ok if currently in User mode
        return True;

    } else {

        // otherwise, require 'U' mode to be present and enabled
        return requireMISAMT(riscv, 'U');
    }
}


////////////////////////////////////////////////////////////////////////////////
// TRAPPED INSTRUCTION HANDLING
////////////////////////////////////////////////////////////////////////////////

//
// Macro encapsulating test for trapped instruction from any non-Machine
// mode when a bit is set or clear in a register
//
#define EMIT_TRAP_MASK_FIELD_NOT_M(_RISCV, _R, _BIT, _VALUE) \
    emitTrapInstructionMaskNotM(            \
        _RISCV,                             \
        CSR_REG_MT(_R),                     \
        WM_##_R##_##_BIT,                   \
        _VALUE ? vmi_COND_Z : vmi_COND_NZ,  \
        #_R"."#_BIT"="#_VALUE               \
    )

//
// Macro encapsulating test for trapped instruction in VS mode mode when a bit
// is set or clear in a register
//
#define EMIT_TRAP_MASK_FIELD_VS(_RISCV, _R, _BIT, _VALUE) \
    emitTrapInstructionMaskVS(              \
        _RISCV,                             \
        CSR_REG_MT(_R),                     \
        WM_##_R##_##_BIT,                   \
        _VALUE ? vmi_COND_Z : vmi_COND_NZ,  \
        #_R"."#_BIT"="#_VALUE               \
    )

//
// Macro encapsulating test for either Illegal Instruction or Virtual
// Instruction trap when a bit is set or clear in a register
//
#define EMIT_TRAP_MASK_FIELD_HS_OR_VS(_RISCV, _RHS, _RVS, _BIT, _VALUE) \
    emitTrapInstructionMaskHSorVS(          \
        _RISCV,                             \
        CSR_REG_MT(_RHS),                   \
        CSR_REG_MT(_RVS),                   \
        WM_##_RHS##_##_BIT,                 \
        _VALUE ? vmi_COND_Z : vmi_COND_NZ,  \
        #_RHS"."#_BIT"="#_VALUE,            \
        #_RVS"."#_BIT"="#_VALUE             \
    )

//
// Type of function called when instruction is trapped
//
#define TRAP_FN(_NAME) void _NAME(riscvP riscv, const char *reason)
typedef TRAP_FN((*trapFn));

//
// Emit verbose reason for trapped instruction
//
static void trapVerbose(riscvP riscv, const char *reason) {
    vmiMessage("W", CPU_PREFIX "_TI",
        SRCREF_FMT "Trapped because %s",
        SRCREF_ARGS(riscv, getPC(riscv)),
        reason
    );
}

//
// Function called when instruction causes an Illegal Instruction trap
//
static TRAP_FN(trapIllegal) {

    // report the trapped feature
    if(riscv->verbose) {
        trapVerbose(riscv, reason);
    }

    // take Illegal Instruction trap
    riscvIllegalInstruction(riscv);
}

//
// Function called when instruction causes a Virtual Instruction trap
//
static TRAP_FN(trapVirtual) {

    // report the trapped feature
    if(riscv->verbose) {
        trapVerbose(riscv, reason);
    }

    // take Virtual Instruction trap
    riscvVirtualInstruction(riscv);
}

//
// Emit test for Illegal Instruction or Virtual Instruction trap when a bit is
// set or clear in a register
//
static void emitTrapInstructionMaskInt(
    vmiReg       r,
    Uns32        mask,
    vmiCondition cond,
    const char  *reason,
    trapFn       trapCB
) {
    if(!VMI_ISNOREG(r)) {

        vmiLabelP ok = vmimtNewLabel();

        // skip trap if bit is set or clear
        vmimtTestRCJumpLabel(32, cond, r, mask, ok);

        // emit call generating trap
        vmimtArgProcessor();
        vmimtArgNatAddress(reason);
        vmimtCallAttrs((vmiCallFn)trapCB, VMCA_EXCEPTION);

        // here if access is legal
        vmimtInsertLabel(ok);
    }
}

//
// Emit test for Illegal Instruction instruction when a bit is set or clear in a
// register in any non-Machine mode
//
static void emitTrapInstructionMaskNotM(
    riscvP       riscv,
    vmiReg       r,
    Uns32        mask,
    vmiCondition cond,
    const char  *reason
) {
    if(getCurrentMode5(riscv)!=RISCV_MODE_M) {
        emitTrapInstructionMaskInt(r, mask, cond, reason, trapIllegal);
    }
}

//
// Emit test for Virtual Instruction trap when a bit is set or clear in a
// register in VS mode
//
static void emitTrapInstructionMaskVS(
    riscvP       riscv,
    vmiReg       r,
    Uns32        mask,
    vmiCondition cond,
    const char  *reason
) {
    if(inVMode(riscv)) {
        emitTrapInstructionMaskInt(r, mask, cond, reason, trapVirtual);
    }
}

//
// Emit test for for either Illegal Instruction or Virtual Instruction trap when
// a bit is set or clear in a register
//
static void emitTrapInstructionMaskHSorVS(
    riscvP       riscv,
    vmiReg       rHS,
    vmiReg       rVS,
    Uns32        mask,
    vmiCondition cond,
    const char  *reasonHS,
    const char  *reasonVS
) {
    if(inVMode(riscv)) {
        emitTrapInstructionMaskInt(rVS, mask, cond, reasonVS, trapVirtual);
    } else if(getCurrentMode5(riscv)!=RISCV_MODE_M) {
        emitTrapInstructionMaskInt(rHS, mask, cond, reasonHS, trapIllegal);
    }
}

//
// Emit trap when mstatus.TVM=1 in Supervisor mode
//
void riscvEmitTrapTVM(riscvP riscv) {
    EMIT_TRAP_MASK_FIELD_HS_OR_VS(riscv, mstatus, hstatus, TVM, 1);
}

//
// Emit trap when mstatus.TSR=1 in Supervisor mode
//
void riscvEmitTrapTSR(riscvP riscv) {
    EMIT_TRAP_MASK_FIELD_HS_OR_VS(riscv, mstatus, hstatus, TSR, 1);
}


////////////////////////////////////////////////////////////////////////////////
// REGISTER ACCESS
////////////////////////////////////////////////////////////////////////////////

//
// Is mstatus.FS always dirty if enabled?
//
inline static Bool alwaysDirtyFS(riscvP riscv) {
    return riscv->configInfo.mstatus_fs_mode==RVFS_ALWAYS_DIRTY;
}

//
// Is mstatus.FS always dirty if flags are written?
//
inline static Bool writeAnyFS(riscvP riscv) {
    return riscv->configInfo.mstatus_fs_mode==RVFS_WRITE_ANY;
}

//
// Is mstatus.VS in Vector Version 0.8 location (bits 24:23)?
//
inline static Bool statusVS8(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_VS_STATUS_8);
}

//
// Is mstatus.VS in Vector Version 0.9 location (bits 10:9)?
//
inline static Bool statusVS9(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_VS_STATUS_9);
}

//
// Indicate that this instruction may update mstatus (and possibly the virtual
// alias vsstatus)
//
static void updateMStatusFS(riscvP riscv) {

    vmimtRegReadImpl("mstatus");
    vmimtRegWriteImpl("mstatus");

    if(inVMode(riscv)) {
        vmimtRegReadImpl("vsstatus");
        vmimtRegWriteImpl("vsstatus");
    }
}

//
// Indicate that this instruction may update mstatus (by changing mstatus.FS)
//
static void mayUpdateMStatusFS(riscvP riscv) {

    if(!Zfinx(riscv) && !alwaysDirtyFS(riscv)) {
        updateMStatusFS(riscv);
    }
}

//
// Indicate that this instruction may update mstatus (by changing mstatus.VS)
//
static void mayUpdateMStatusVS(riscvP riscv) {

    if((statusVS8(riscv) || statusVS9(riscv)) && !alwaysDirtyFS(riscv)) {
        updateMStatusFS(riscv);
    }
}

//
// Emit code to set bits corresponding to the given mask in mstatus and
// possibly vsstatus
//
inline static void emitSetMStatusMask(riscvP riscv, Uns32 mask) {

    // always set mstatus mask
    vmimtBinopRC(32, vmi_OR, RISCV_CPU_REG(csr.mstatus), mask, 0);

    // set vsstatus mask if in a virtual mode
    if(inVMode(riscv)) {
        vmimtBinopRC(32, vmi_OR, RISCV_CPU_REG(csr.vsstatus), mask, 0);
    }
}

//
// Set mstatus.FS to Dirty if it is not known to be in that state already
//
static void updateFS(riscvP riscv) {

    if(!Zfinx(riscv) && !alwaysDirtyFS(riscv)) {

        riscvBlockStateP blockState = riscv->blockState;

        // indicate that this instruction may update mstatus
        mayUpdateMStatusFS(riscv);

        if(!blockState->FSDirty) {
            blockState->FSDirty = True;
            emitSetMStatusMask(riscv, WM_mstatus_FS);
        }
    }
}

//
// Set mstatus.VS to Dirty if it is not known to be in that state already
//
static void updateVS(riscvP riscv) {

    Uns32 WM_mstatus_VS = 0;

    // get mask of dirty bits for mstatus.VS in either 0.8 or 0.9 location
    if(statusVS8(riscv)) {
        WM_mstatus_VS = WM_mstatus_VS_8;
    } else if(statusVS9(riscv)) {
        WM_mstatus_VS = WM_mstatus_VS_9;
    }

    if(WM_mstatus_VS && !alwaysDirtyFS(riscv)) {

        riscvBlockStateP blockState = riscv->blockState;

        // indicate that this instruction may update mstatus
        mayUpdateMStatusVS(riscv);

        if(!blockState->VSDirty) {
            blockState->VSDirty = True;
            emitSetMStatusMask(riscv, WM_mstatus_VS);
        }
    }
}

//
// Reset JIT code generator state after possible write of mstatus.FS/mstatus.VS
//
static void resetFSVS(riscvP riscv) {

    riscvBlockStateP blockState = riscv->blockState;

    blockState->FSDirty = False;
    blockState->VSDirty = False;
}

//
// Allocate new VMI temporary register
//
static vmiReg newTmp(riscvMorphStateP state) {

    Uns32 i = state->tmpIndex++;

    // sanity check temporary index
    VMI_ASSERT(
        i<NUM_TEMPS,
        "bad temporary index %u (maximum is %u)",
        i, NUM_TEMPS-1
    );

    return RISCV_CPU_TEMP(TMP[i]);
}

//
// Free VMI temporary register
//
static void freeTmp(riscvMorphStateP state) {

    Uns32 i = state->tmpIndex;

    // sanity check temporary index
    VMI_ASSERT(i, "attempting to free unused temporary");

    // kill temporary
    Uns32 tmpBits = sizeof(state->riscv->TMP[i])*8;
    vmimtRegNotReadR(tmpBits, RISCV_CPU_TEMP(TMP[i]));

    state->tmpIndex = i-1;
}

//
// Return riscvRegDesc for the indexed register
//
inline static riscvRegDesc getRVReg(riscvMorphStateP state, Uns32 argNum) {
    return state->info.r[argNum];
}

//
// Update riscvRegDesc for the indexed register
//
inline static void setRVReg(
    riscvMorphStateP state,
    Uns32            argNum,
    riscvRegDesc     rA
) {
    state->info.r[argNum] = rA;
}

//
// Get mask for the register in a 32-bit word
//
inline static Uns32 getRegMask(riscvRegDesc r) {
    return 1 << getRIndex(r);
}

//
// Clamp unimplemented 128-bit value to 64 (to prevent failures when generating
// code for quadruple-precision illegal instructions)
//
inline static Uns32 clamp64(Uns32 bits) {
    return (bits>64) ? 64 : bits;
}

//
// Return floating point type for the given abstract register
//
static vmiFType getRegFType(riscvRegDesc r) {

    Uns32 bits = clamp64(getRBits(r));

    if(isFReg(r)) {
        return VMI_FT_IEEE_754 | bits;
    } else if(isUReg(r)) {
        return VMI_FT_UNS | bits;
    } else {
        return VMI_FT_INT | bits;
    }
}

//
// Return bits in misa that must be enabled for a floating point register of
// the given size to be accessible (NOTE: half-precision has no defined enable
// bit currently, so assume it is enabled if either F or D are enabled)
//
static riscvArchitecture getFRegArch(riscvP riscv, Uns32 bits) {
    return (bits==16) ? ISA_DF : (bits==32) ? ISA_F : ISA_D;
}

//
// Validate the floating point register bits is supported and emit an Illegal
// Instruction if not
//
static Bool supportedFBitsMT(riscvP riscv, Uns32 bits) {

    Bool ok = False;

    if(bits==128) {
        ILLEGAL_INSTRUCTION_MESSAGE(
            riscv, "NFP128", "quadruple-precision floating point is absent"
        );
    } else if(bits!=16) {
        ok = True;
    } else if(!riscv->configInfo.fp16_version) {
        ILLEGAL_INSTRUCTION_MESSAGE(
            riscv, "NFP16", "half-precision floating point is absent"
        );
    } else if(riscv->configInfo.Zfhmin && !riscv->blockState->ZfhminOK) {
        ILLEGAL_INSTRUCTION_MESSAGE(
            riscv, "ZFHMIN", "Zfhmin present"
        );
    } else {
        ok = True;
    }

    return ok;
}

//
// Get the indexed X register, if it is legal
//
static vmiReg getVMIRegX(riscvP riscv, Uns32 index) {

    vmiReg result = VMI_NOREG;

    // register indices >= 16 are illegal for E extension (the inverse of
    // the I feature)
    if((index<16) || riscvRequireArchPresentMT(riscv, ISA_I)) {
        result = index ? RISCV_GPR(index) : VMI_NOREG;
    }

    return result;
}

//
// Validate floating point extension is enabled for the given register size
//
static Bool isFltEnabledMT(riscvP riscv, Uns32 bits) {

    return (
        // floating point type must be supported
        supportedFBitsMT(riscv, bits) &&
        // floating point type must be enabled
        riscvRequireArchPresentMT(riscv, getFRegArch(riscv, bits))
    );
}

//
// Is the Zfinx extension absent?
//
static Bool isZfinxAbsentMT(riscvP riscv) {

    Bool ok = !Zfinx(riscv);

    if(!ok) {
        ILLEGAL_INSTRUCTION_MESSAGE(
            riscv, "FINXIMP", "illegal because Zfinx implemented"
        );
    }

    return ok;
}

//
// Is the given Zfinx register index legal?
//
static Bool isZfinxLegalIndexMT(riscvP riscv, Uns32 index, Uns32 bits) {

    Bool ok = ((riscvGetXlenMode(riscv)>=bits) || !(index&1));

    if(!ok) {
        ILLEGAL_INSTRUCTION_MESSAGE(
            riscv, "FINXIDX", "illegal odd register index when Zfinx implemented"
        );
    }

    return ok;
}

//
// Return VMI register for the given abstract register
//
vmiReg riscvGetVMIReg(riscvP riscv, riscvRegDesc r) {

    Uns32  bits   = getRBits(r);
    Uns32  index  = getRIndex(r);
    vmiReg result = VMI_NOREG;

    if(isZfinxReg(r)) {

        if(!isFltEnabledMT(riscv, bits)) {
            // floating point absent or disabled
        } else if(!isZfinxLegalIndexMT(riscv, index, bits)) {
            // illegal register index
        } else {
            result = getVMIRegX(riscv, index);
        }

    } else if(isXReg(r)) {

        // 64-bit register requires ISA_XLEN_64 feature
        if(bits==64) {
            riscvRequireArchPresentMT(riscv, ISA_XLEN_64);
        }

        result = getVMIRegX(riscv, index);

    } else if(isFReg(r)) {

        // require no Zfinx extension and enabled floating point
        if(isZfinxAbsentMT(riscv) && isFltEnabledMT(riscv, bits)) {
            riscv->usingFP = True;
            result = RISCV_FPR(index);
        }

    } else if(isVReg(r)) {

        // require V feature
        if(riscvRequireArchPresentMT(riscv, ISA_V)) {
            result = riscvGetVReg(riscv, index);
        }

    } else {

        VMI_ABORT("Bad register specifier 0x%x", r); // LCOV_EXCL_LINE
    }

    return result;
}

//
// Return VMI register for the given abstract register
//
inline static vmiReg getVMIReg(riscvP riscv, riscvRegDesc r) {
    return riscvGetVMIReg(riscv, r);
}

//
// Does the floating point register require NaN boxing?
//
static Bool requireNaNBox(
    riscvP       riscv,
    riscvRegDesc r,
    Uns32        archBits,
    Uns32        srcBits
) {
    riscvBlockStateP blockState = riscv->blockState;
    Bool             doNaNBox   = False;

    if(archBits>srcBits) {

        Uns32 fpNaNBoxMask;

        if(srcBits==16) {
            fpNaNBoxMask = blockState->fpNaNBoxMask[0];
        } else if(srcBits==32) {
            fpNaNBoxMask = blockState->fpNaNBoxMask[1];
        } else {
            fpNaNBoxMask = -1;
        }

        doNaNBox = !(fpNaNBoxMask & getRegMask(r));
    }

    return doNaNBox;
}

//
// Do actions when a register is written (extending or NaN boxing, if
// required)
//
void riscvWriteRegSize(
    riscvP       riscv,
    riscvRegDesc r,
    Uns32        srcBits,
    Bool         signExtend
) {
    vmiReg dst = getVMIReg(riscv, r);

    if(isZfinxReg(r)) {

        Uns32 dstArch = riscvGetXlenArch(riscv);
        Uns32 dstMode = riscvGetXlenMode(riscv);

        if(requireNaNBox(riscv, r, dstMode, srcBits)) {

            // NaN-box result if required (NOTE: to dstArch, not dstMode)
            vmimtMoveRC(dstArch-srcBits, VMI_REG_DELTA(dst,srcBits/8), -1);

        } else if(dstMode<srcBits) {

            // reassign result to register pair
            Uns32  dstBytes = BITS_TO_BYTES(dstMode);
            vmiReg dst0     = dst;
            vmiReg dst1     = VMI_REG_DELTA(dst0, dstBytes);
            vmiReg dst2     = VMI_REG_DELTA(dst1, dstBytes);

            // sign-extend result halves to dstArch
            vmimtMoveExtendRR(dstArch, dst2, dstMode, dst1, signExtend);
            vmimtMoveExtendRR(dstArch, dst0, dstMode, dst0, signExtend);

        } else {

            // sign-extend result to dstArch
            vmimtMoveExtendRR(dstArch, dst, srcBits, dst, signExtend);
        }

    } else if(isXReg(r)) {

        Uns32 dstArch = riscvGetXlenArch(riscv);

        // sign-extend result to dstArch
        vmimtMoveExtendRR(dstArch, dst, srcBits, dst, signExtend);

        // add to record of X registers written by this instruction
        riscv->writtenXMask |= getRegMask(r);

    } else if(isFReg(r)) {

        riscvBlockStateP blockState = riscv->blockState;
        Uns32            dstArch    = riscvGetFlenArch(riscv);
        Uns32            fprMask    = getRegMask(r);
        Uns32            i;

        // NaN-box result if required
        if(requireNaNBox(riscv, r, dstArch, srcBits)) {
            vmimtMoveRC(dstArch-srcBits, VMI_REG_DELTA(dst,srcBits/8), -1);
        }

        // floating point views narrower than srcBits are now not NaN-boxed
        for(i=0; (16<<i)<srcBits; i++) {
            blockState->fpNaNBoxMask[i] &= ~fprMask;
        }

        // floating point views srcBits or wider are now NaN-boxed
        for(; i<2; i++) {
            blockState->fpNaNBoxMask[i] |= fprMask;
        }

        // set mstatus.FS
        updateFS(riscv);

    } else {

        VMI_ABORT("Bad register specifier 0x%x", r); // LCOV_EXCL_LINE
    }
}

//
// Do actions when a register is written (sign extending or NaN boxing, if
// required)
//
inline static void writeRegSize(riscvP riscv, riscvRegDesc r, Uns32 srcBits) {
    riscvWriteRegSize(riscv, r, srcBits, True);
}

//
// Do actions when a register is written (extending or NaN boxing, if
// required) using the derived register size
//
void riscvWriteReg(riscvP riscv, riscvRegDesc r, Bool signExtend) {
    riscvWriteRegSize(riscv, r, getRBits(r), signExtend);
}

//
// Do actions when a register is written (sign extending or NaN boxing, if
// required) using the derived register size
//
inline static void writeReg(riscvP riscv, riscvRegDesc r) {
    riscvWriteReg(riscv, r, True);
}


////////////////////////////////////////////////////////////////////////////////
// FLOATING POINT SUPPORT MACROS
////////////////////////////////////////////////////////////////////////////////

//
// Int8 macros
//
#define INT8_MIN            0x80
#define INT8_MAX            0x7f

//
// Uns8 macros
//
#define UNS8_MIN            0x00
#define UNS8_MAX            0xff

//
// Int16 macros
//
#define INT16_MIN           0x8000
#define INT16_MAX           0x7fff

//
// Uns16 macros
//
#define UNS16_MIN           0x0000
#define UNS16_MAX           0xffff

//
// Int32 macros
//
#define INT32_MIN           0x80000000
#define INT32_MAX           0x7fffffff

//
// Uns32 macros
//
#define UNS32_MIN           0x00000000
#define UNS32_MAX           0xffffffff

//
// Int64 macros
//
#define INT64_MIN           0x8000000000000000ULL
#define INT64_MAX           0x7fffffffffffffffULL

//
// Uns64 macros
//
#define UNS64_MIN           0x0000000000000000ULL
#define UNS64_MAX           0xffffffffffffffffULL

//
// Flt16 macros
//
#define FP16_EXP_ONES       0x1f
#define FP16_EXP_SHIFT      10
#define FP16_SIGN_SHIFT     15
#define FP16_SIGN_MASK      (1<<FP16_SIGN_SHIFT)

#define FP16_SIGN(_F)       (((_F) & FP16_SIGN_MASK) != 0)
#define FP16_EXPONENT(_F)   (((_F) & 0x7c00) >> FP16_EXP_SHIFT)
#define FP16_FRACTION(_F)   ((_F) & ((1<<FP16_EXP_SHIFT)-1))

#define FP16_PLUS_ZERO      (0)
#define FP16_MINUS_ZERO     (FP16_SIGN_MASK)
#define FP16_ISZERO(_F)     (((_F) & ~0x8000) == 0)
#define FP16_ZERO(_S)       ((_S) ? FP16_MINUS_ZERO : FP16_PLUS_ZERO)

#define FP16_PLUS_INFINITY  (0x7c00)
#define FP16_MINUS_INFINITY (0xfc00)
#define FP16_INFINITY(_S)   ((_S) ? FP16_MINUS_INFINITY : FP16_PLUS_INFINITY)

#define FP16_PLUS_MAX       (FP16_PLUS_INFINITY-1)
#define FP16_MINUS_MAX      (FP16_MINUS_INFINITY-1)
#define FP16_MAX(_S)        ((_S) ? FP16_MINUS_MAX : FP16_PLUS_MAX)

#define FP16_DEFAULT_QNAN   0x7e00
#define FP16_QNAN_MASK      0x0200

//
// Flt32 macros
//
#define FP32_EXP_ONES       0xff
#define FP32_EXP_SHIFT      23
#define FP32_SIGN_SHIFT     31
#define FP32_SIGN_MASK      (1<<FP32_SIGN_SHIFT)

#define FP32_SIGN(_F)       (((_F) & FP32_SIGN_MASK) != 0)
#define FP32_EXPONENT(_F)   (((_F) & 0x7f800000) >> FP32_EXP_SHIFT)
#define FP32_FRACTION(_F)   ((_F) & ((1<<FP32_EXP_SHIFT)-1))

#define FP32_PLUS_ZERO      (0)
#define FP32_MINUS_ZERO     (FP32_SIGN_MASK)
#define FP32_ISZERO(_F)     (((_F) & ~0x80000000) == 0)
#define FP32_ZERO(_S)       ((_S) ? FP32_MINUS_ZERO : FP32_PLUS_ZERO)

#define FP32_PLUS_INFINITY  (0x7f800000)
#define FP32_MINUS_INFINITY (0xff800000)
#define FP32_INFINITY(_S)   ((_S) ? FP32_MINUS_INFINITY : FP32_PLUS_INFINITY)

#define FP32_PLUS_MAX       (FP32_PLUS_INFINITY-1)
#define FP32_MINUS_MAX      (FP32_MINUS_INFINITY-1)
#define FP32_MAX(_S)        ((_S) ? FP32_MINUS_MAX : FP32_PLUS_MAX)

#define FP32_DEFAULT_QNAN   0x7fc00000
#define FP32_QNAN_MASK      0x00400000

//
// Flt64 macros
//
#define FP64_EXP_ONES       0x7ff
#define FP64_EXP_SHIFT      52
#define FP64_SIGN_SHIFT     63
#define FP64_SIGN_MASK      (1ULL<<FP64_SIGN_SHIFT)

#define FP64_SIGN(_F)       (((_F) & FP64_SIGN_MASK) != 0)
#define FP64_EXPONENT(_F)   (((_F) & 0x7ff0000000000000ULL) >> FP64_EXP_SHIFT)
#define FP64_FRACTION(_F)   ((_F) & ((1ULL<<FP64_EXP_SHIFT)-1))

#define FP64_PLUS_ZERO      (0ULL)
#define FP64_MINUS_ZERO     (FP64_SIGN_MASK)
#define FP64_ISZERO(_F)     ((_F) & ~0x8000000000000000ULL) == 0)
#define FP64_ZERO(_S)       ((_S) ? FP64_MINUS_ZERO : FP64_PLUS_ZERO)

#define FP64_PLUS_INFINITY  (0x7ff0000000000000ULL)
#define FP64_MINUS_INFINITY (0xfff0000000000000ULL)
#define FP64_INFINITY(_S)   ((_S) ? FP64_MINUS_INFINITY : FP64_PLUS_INFINITY)

#define FP64_PLUS_MAX       (FP64_PLUS_INFINITY-1)
#define FP64_MINUS_MAX      (FP64_MINUS_INFINITY-1)
#define FP64_MAX(_S)        ((_S) ? FP64_MINUS_MAX : FP64_PLUS_MAX)

#define FP64_DEFAULT_QNAN   0x7ff8000000000000ULL
#define FP64_QNAN_MASK      0x0008000000000000ULL


////////////////////////////////////////////////////////////////////////////////
// FLOATING POINT REGISTER UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Return VMI register for the given abstract register which may require a NaN
// box test if it is floating point (internal routine)
//
static vmiReg getVMIRegFSInt(
    riscvMorphStateP state,
    riscvP           riscv,
    riscvRegDesc     r,
    vmiReg           tmp
) {
    vmiReg result = getVMIReg(riscv, r);
    Uns32  bits   = getRBits(r);

    if(isZfinxReg(r)) {

        Uns32 XLEN = riscvGetXlenMode(riscv);

        if(XLEN<bits) {

            // low and high parameters are in adjacent registers
            vmiReg srcLo = result;
            vmiReg srcHi = VMI_REG_DELTA(srcLo, 8);

            // allocate temporary if required
            if(VMI_ISNOREG(tmp)) {
                tmp = newTmp(state);
            }

            // get low and high half of temporary
            vmiReg tmpLo = tmp;
            vmiReg tmpHi = VMI_REG_DELTA(tmpLo, BITS_TO_BYTES(XLEN));

            // fill temporary halves
            vmimtMoveRR(XLEN, tmpLo, srcLo);
            vmimtMoveRR(XLEN, tmpHi, srcHi);

            // use the temporary as a source
            result = tmp;
        }

    } else if(isFReg(r)) {

        Uns32 archBits = riscvGetFlenArch(riscv);

        // handle possible switch to QNaN-valued temporary if the source
        // register is smaller than the architectural register size and not
        // known to be NaN-boxed
        if(requireNaNBox(riscv, r, archBits, bits)) {

            // select default QNaN value
            Uns32 QNaN  = (bits==16) ? FP16_DEFAULT_QNAN : FP32_DEFAULT_QNAN;
            Uns64 upper = -1ULL << bits;

            // allocate temporary if required
            if(VMI_ISNOREG(tmp)) {
                tmp = newTmp(state);
            }

            // is the upper half all ones?
            vmimtCompareRC(archBits, vmi_COND_NB, result, upper, tmp);

            // seed the apparent value, depending on whether the source is
            // correctly NaN-boxed
            vmimtCondMoveRRC(bits, tmp, True, tmp, result, QNaN);

            // use the temporary as a source
            result = tmp;
        }
    }

    return result;
}

//
// Return VMI register for the given abstract register which may require a NaN
// box test if it is floating point (public interface)
//
vmiReg riscvGetVMIRegFS(riscvP riscv, riscvRegDesc r, vmiReg tmp) {
    return getVMIRegFSInt(0, riscv, r, tmp);
}

//
// Return VMI register for the given abstract register which may require a NaN
// box test if it is floating point (local interface)
//
inline static vmiReg getVMIRegFS(riscvMorphStateP state, riscvRegDesc r) {
    return getVMIRegFSInt(state, state->riscv, r, VMI_NOREG);
}

//
// Adjust JIT code generator state after write of floating point CSR
//
void riscvWFS(riscvMorphStateP state, Bool useRS1) {

    riscvP riscv = state->riscv;

    updateFS(riscv);
}

//
// Adjust JIT code generator state after write of vcsr CSR, which will set
// vector state dirty and floating point state dirty (if floating point is
// enabled)
//
void riscvWVCSR(riscvMorphStateP state, Bool useRS1) {

    riscvP riscv = state->riscv;

    updateVS(riscv);

    if(isFeaturePresentMT(riscv, ISA_FS)) {
        updateFS(riscv);
    }
}

//
// Adjust JIT code generator state after write of vector CSR that affects
// floating point state or vector extension state (behavior clearly defined only
// after version 20191118)
//
void riscvWFSVS(riscvMorphStateP state, Bool useRS1) {

    riscvP riscv = state->riscv;

    if(isVCSRPresent(riscv)) {
        updateVS(riscv);
    } else if(vxSatRMSetFSDirty(riscv)) {
        updateFS(riscv);
    }
}

//
// Reset JIT code generator state after possible write of mstatus.FS/mstatus.VS
//
void riscvRstFS(riscvMorphStateP state, Bool useRS1) {
    resetFSVS(state->riscv);
}


////////////////////////////////////////////////////////////////////////////////
// UNPACKED REGISTERS
////////////////////////////////////////////////////////////////////////////////

//
// This defines an unpacked register
//
typedef struct unpackedRegS {
    riscvMorphStateP state; // context
    riscvRegDesc     rA;    // abstract register
    Uns32            bits;  // register size
    vmiFType         ftype; // floating point type
    vmiReg           r;     // corresponding VMI register
} unpackedReg;

//
// Manufacture unpacked GPR description for the abstract GPR
//
inline static unpackedReg createRXInt(riscvMorphStateP state, riscvRegDesc rA) {

    unpackedReg result;

    result.state = state;
    result.rA    = rA;
    result.r     = getVMIReg(state->riscv, rA);
    result.bits  = getRBits(rA);
    result.ftype = 0;

    return result;
}

//
// Manufacture unpacked GPR description for the indexed GPR
//
inline static unpackedReg createRX(riscvMorphStateP state, Uns32 index) {
    Uns32 bits = riscvGetXlenMode(state->riscv);
    return createRXInt(state, RV_RD_X | index | (RV_RD_8*bits/8));
}

//
// Return unpacked GPR argument description
//
inline static unpackedReg unpackRX(riscvMorphStateP state, Uns32 argNum) {
    return createRXInt(state, getRVReg(state, argNum));
}

//
// Return unpacked destination argument FPR description
//
inline static unpackedReg unpackFD(riscvMorphStateP state, Uns32 argNum) {

    unpackedReg result;

    result.state = state;
    result.rA    = getRVReg(state, argNum);
    result.r     = getVMIReg(state->riscv, result.rA);
    result.bits  = getRBits(result.rA);
    result.ftype = getRegFType(result.rA);

    return result;
}

//
// Return unpacked source argument FPR description
//
static unpackedReg unpackFS(riscvMorphStateP state, Uns32 argNum) {

    unpackedReg result;

    result.state = state;
    result.rA    = getRVReg(state, argNum);
    result.r     = getVMIRegFS(state, result.rA);
    result.bits  = getRBits(result.rA);
    result.ftype = getRegFType(result.rA);

    return result;
}

//
// Do actions when an unpacked register is written (sign extending or NaN
// boxing, if required) using the derived register size
//
inline static void writeUnpacked(unpackedReg rd) {
    writeReg(rd.state->riscv, rd.rA);
}

//
// Do actions when a an unpacked register is written with the given size (sign
// extending or NaN boxing, if required)
//
inline static void writeUnpackedSize(unpackedReg rd, Uns32 srcBits) {
    writeRegSize(rd.state->riscv, rd.rA, srcBits);
}


////////////////////////////////////////////////////////////////////////////////
// LOAD/STORE UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Set address bits for a load/store operation (has effect when running with
// XLEN=32 on a system also implementing XLEN=64)
//
static void setAddressMaskMT(riscvP riscv) {
    vmimtSetAddressMask(getAddressMask(riscvGetXlenMode(riscv)));
}

//
// Return a Boolean indicating if transaction mode is enabled
//
inline static Bool inTransactionMode(riscvP riscv) {
    return riscv->pmKey & PMK_TRANSACTION;
}

//
// Return a Boolean indicating if vector tail elements must be set to 1
//
inline static Bool inVTA1Mode(riscvP riscv) {
    return riscv->pmKey & PMK_VECTOR_VTA1;
}

//
// Return a Boolean indicating if vector masked-off elements must be set to 1
//
inline static Bool inVMA1Mode(riscvP riscv) {
    return riscv->pmKey & PMK_VECTOR_VMA1;
}

//
// Return a Boolean indicating if transaction mode is enabled, checked using
// block mask
//
inline static Bool inTransactionModeMT(riscvP riscv) {

    // validate transaction mode state if required
    if(riscv->useTMode) {
        emitCheckPolymorphic();
    }

    if(inTransactionMode(riscv)) {

        // Assume any instruction that checks for transaction mode could
        // result in a transaction abort that exits transaction mode, which
        // changes the PMK_TRANSACTION polymorphic key, which requires an
        // end block be issued. So emit it here.
        vmimtEndBlock();
        return True;

    } else {

        // Not in transaction mode
        return False;
    }
}

//
// Return domain to use for load/store (default, transaction, or virtual for
// HLV, HLVX or HSV)
//
static memDomainP getLoadStoreDomainMT(
    riscvP riscv,
    Bool   isVirtual,
    Bool   isCode
) {
    memDomainP result = 0;

    if(inTransactionModeMT(riscv)) {

        // use transaction domain
        result = riscv->tmDomain;

    } else if(!isVirtual) {

        // use default domain if not a virtual machine operation

    } else if(inVMode(riscv)) {

         riscvEmitVirtualInstructionMode(riscv);

    } else if(!requireSIfNotArchMT(riscv, ISA_HU)) {

        // illegal in User mode

    } else if(!isFeaturePresentMT(riscv, ISA_VVM)) {

        // HLV, HLVX or HSV when virtual TLB disabled
        Bool      SPVP = isFeaturePresentMT(riscv, ISA_SPVP);
        riscvMode mode = SPVP ? RISCV_MODE_S : RISCV_MODE_U;

        result = riscv->physDomains[mode][isCode];

    } else if(isCode) {

        // HLVX when virtual TLB enabled
        Bool SPVP = isFeaturePresentMT(riscv, ISA_SPVP);

        result = riscv->hlvxDomains[SPVP];

    } else {

        // HLV or HSV when virtual TLB enabled
        Bool        SPVP = isFeaturePresentMT(riscv, ISA_SPVP);
        riscvVMMode mode = SPVP ? RISCV_VMMODE_VS : RISCV_VMMODE_VU;

        result = riscv->vmDomains[mode][isCode];
    }

    return result;
}

//
// Return endian to use for virtual machine load/store
//
static memEndian getVEndianMT(
    riscvP            riscv,
    riscvMode         mode,
    riscvArchitecture feature
) {
    emitBlockMask(riscv, feature);
    return riscvGetDataEndian(riscv, mode);
}

//
// Return endian to use for load/store (default or virtual for HLV or HSV)
//
static memEndian getLoadStoreEndianMT(riscvP riscv, Bool isVirtual) {

    memEndian result;

    if(!isVirtual) {
        result = riscvGetCurrentDataEndianMT(riscv);
    } else if(isFeaturePresentMT(riscv, ISA_SPVP)) {
        result = getVEndianMT(riscv, RISCV_MODE_VS, ISA_VSBE);
    } else {
        result = getVEndianMT(riscv, RISCV_MODE_VU, ISA_VUBE);
    }

    return result;
}

//
// Compose the access virtual address in the trigger VA pseudo-register and
// update ra and offset to reference that register
//
static void emitTriggerVA(riscvP riscv, vmiReg *raP, Uns64 *offsetP) {

    Uns32  vaBits = riscvGetXlenMode(riscv);
    vmiReg va     = RISCV_TRIGGER_VA;

    // compose trigger VA and extend to 64 bits if required
    vmimtBinopRRC(vaBits, vmi_ADD, va, *raP, *offsetP, 0);
    vmimtMoveExtendRR(64, va, vaBits, va, False);

    // use trigger VA as address
    *raP     = va;
    *offsetP = 0;
}

//
// Invoke load address trigger if required
//
static void emitTriggerLA(Bool doTrigger, Uns32 memBits) {

    if(doTrigger) {
        vmimtArgProcessor();
        vmimtArgUns32(memBits/8);
        vmimtCallAttrs((vmiCallFn)riscvTriggerLA, VMCA_NA);
    }
}

//
// Invoke load value trigger if required
//
static void emitTriggerLV(
    Bool   doTrigger,
    vmiReg rdTmp,
    Uns32  rdBits,
    Uns32  memBits
) {
    if(doTrigger) {
        vmimtMoveExtendRR(64, rdTmp, rdBits, rdTmp, False);
        vmimtArgProcessor();
        vmimtArgUns32(memBits/8);
        vmimtCallAttrs((vmiCallFn)riscvTriggerLV, VMCA_NA);
    }
}

//
// Invoke store address/value trigger if required
//
static void emitTriggerS(Bool doTrigger, vmiReg rs, Uns32 memBits) {

    if(doTrigger) {
        vmimtArgProcessor();
        vmimtArgRegSimAddress(memBits, rs);
        vmimtArgUns32(memBits/8);
        vmimtCallAttrs((vmiCallFn)riscvTriggerS, VMCA_NA);
    }
}

//
// Emit HLV/HLVX/HSV active code
//
inline static void emitHLVHSV(Bool start) {
    vmimtMoveRC(8, RISCV_HLVHSV, start);
}

//
// Fundamental load operation
//
void riscvEmitLoad(
    riscvP            riscv,
    vmiReg            rd,
    Uns32             rdBits,
    vmiReg            ra,
    Uns32             memBits,
    Uns64             offset,
    riscvExtLdStAttrs attrs
) {
    memConstraint constraint = attrs.constraint;
    Bool          sExtend    = attrs.sExtend;
    Bool          isVirtual  = attrs.isVirtual;
    Bool          isCode     = attrs.isCode;
    Bool          doLSTrig   = riscv->blockState->doLSTrig;
    memDomainP    domain     = getLoadStoreDomainMT(riscv, isVirtual, isCode);
    memEndian     endian     = getLoadStoreEndianMT(riscv, isVirtual);
    Bool          triggerLA  = doLSTrig && triggerLoadAddressMT(riscv);
    Bool          triggerLV  = doLSTrig && triggerLoadValueMT(riscv);
    vmiReg        rdTmp      = rd;

    // indicate start of HLV/HLVX/HSV if required
    if(isVirtual) {
        emitHLVHSV(True);
    }

    // generate trigger VA if required
    if(triggerLA || triggerLV) {
        emitTriggerVA(riscv, &ra, &offset);
    }

    // invoke load address trigger if required
    emitTriggerLA(triggerLA, memBits);

    // if a transactional domain access, perform try-load in current data
    // domain (to update VM and PMP structures and generate access exceptions)
    if(inTransactionMode(riscv)) {
        setAddressMaskMT(riscv);
        vmimtTryLoadRC(memBits, offset, ra, constraint);
    }

    // load result into temporary if load value trigger is active
    if(triggerLV) {
        rdTmp = RISCV_TRIGGER_LV;
    }

    // emit code to perform load
    setAddressMaskMT(riscv);
    vmimtLoadRRODomain(
        domain, rdBits, memBits, offset, rdTmp, ra, endian, sExtend, constraint
    );

    // invoke load value trigger if required
    emitTriggerLV(triggerLV, rdTmp, rdBits, memBits);

    // commit result
    vmimtMoveRR(rdBits, rd, rdTmp);

    // indicate end of HLV/HLVX/HSV if required
    if(isVirtual) {
        emitHLVHSV(False);
    }
}

//
// Fundamental store operation
//
void riscvEmitStore(
    riscvP            riscv,
    vmiReg            rs,
    vmiReg            ra,
    Uns32             memBits,
    Uns64             offset,
    riscvExtLdStAttrs attrs
) {
    memConstraint constraint = attrs.constraint;
    Bool          isVirtual  = attrs.isVirtual;
    Bool          doLSTrig   = riscv->blockState->doLSTrig;
    memDomainP    domain     = getLoadStoreDomainMT(riscv, isVirtual, False);
    memEndian     endian     = getLoadStoreEndianMT(riscv, isVirtual);
    Bool          triggerS   = doLSTrig && triggerStoreMT(riscv);

    // indicate start of HLV/HLVX/HSV if required
    if(isVirtual) {
        emitHLVHSV(True);
    }

    // generate trigger VA
    if(triggerS) {
        emitTriggerVA(riscv, &ra, &offset);
    }

    // invoke store address/value trigger if required
    emitTriggerS(triggerS, rs, memBits);

    // if a transactional domain access, perform try-store in current data
    // domain (to update VM and PMP structures and generate access exceptions)
    if(inTransactionMode(riscv)) {
        setAddressMaskMT(riscv);
        vmimtTryStoreRC(memBits, offset, ra, constraint);
    }

    // emit code to perform store
    setAddressMaskMT(riscv);
    vmimtStoreRRODomain(
        domain, memBits, offset, ra, rs, endian, constraint
    );

    // indicate end of HLV/HLVX/HSV if required
    if(isVirtual) {
        emitHLVHSV(False);
    }
}

//
// Load value from memory for explicit memBits and offset
//
static void emitLoadCommonMBO(
    riscvMorphStateP state,
    vmiReg           rd,
    Uns32            rdBits,
    vmiReg           ra,
    Uns32            memBits,
    Uns64            offset,
    memConstraint    constraint
) {
    // create attributes for memory operation
    riscvExtLdStAttrs attrs = {
        constraint : constraint,
        sExtend    : !state->info.unsExt,
        isVirtual  : state->attrs->virtual,
        isCode     : state->attrs->execute
    };

    // do fundamental operation
    riscvEmitLoad(state->riscv, rd, rdBits, ra, memBits, offset, attrs);
}

//
// Store value to memory for explicit memBits and offset
//
static void emitStoreCommonMBO(
    riscvMorphStateP state,
    vmiReg           rs,
    vmiReg           ra,
    Uns32            memBits,
    Uns64            offset,
    memConstraint    constraint
) {
    // create attributes for memory operation
    riscvExtLdStAttrs attrs = {
        constraint : constraint,
        isVirtual  : state->attrs->virtual
    };

    // do fundamental operation
    riscvEmitStore(state->riscv, rs, ra, memBits, offset, attrs);
}

//
// Load value from memory
//
static void emitLoadCommon(
    riscvMorphStateP state,
    vmiReg           rd,
    Uns32            rdBits,
    vmiReg           ra,
    memConstraint    constraint
) {
    Uns32 memBits = state->info.memBits;
    Uns64 offset  = state->info.c;

    emitLoadCommonMBO(state, rd, rdBits, ra, memBits, offset, constraint);
}

//
// Store value to memory
//
static void emitStoreCommon(
    riscvMorphStateP state,
    vmiReg           rs,
    vmiReg           ra,
    memConstraint    constraint
) {
    Uns32 memBits = state->info.memBits;
    Uns64 offset  = state->info.c;

    emitStoreCommonMBO(state, rs, ra, memBits, offset, constraint);
}

//
// Try-store value
//
static void emitTryStoreCommon(
    riscvMorphStateP state,
    vmiReg           ra,
    memConstraint    constraint
) {
    riscvP riscv   = state->riscv;
    Uns32  memBits = state->info.memBits;
    Uns64  offset  = state->info.c;

    // generate Store/AMO exception in preference to Load exception
    setAddressMaskMT(riscv);
    vmimtTryStoreRC(memBits, offset, ra, constraint);
}


////////////////////////////////////////////////////////////////////////////////
// SATURATING OPERATIONS
////////////////////////////////////////////////////////////////////////////////

//
// Return vmiFlagsCP specifying which native flag is used to set the saturation
// flag for unsigned and signed operations
//
static vmiFlagsCP getSatFlags(riscvMorphStateP state, Bool isSigned) {

    static const vmiFlags map[2] = {
        [0] = {f : {[vmi_CF] = RISCV_SF_TMP}, cin : RISCV_SF_TMP},
        [1] = {f : {[vmi_OF] = RISCV_SF_TMP}, cin : RISCV_SF_TMP}
    };

    return &map[isSigned];
}

//
// Update vxsat after saturating operation
//
static void updateVXSat(riscvMorphStateP state) {

    riscvP riscv = state->riscv;

    // set mstatus.FS if required
    if(writeAnyFS(riscv) && vxSatRMSetFSDirty(riscv)) {
        updateFS(riscv);
    }

    vmimtBinopRR(8, vmi_OR, RISCV_SF_FLAGS, RISCV_SF_TMP, 0);
}

//
// Commit saturation flag if required
//
static void commitSatFlag(riscvMorphStateP state, vmiFlagsCP flags) {

    if(!flags) {

        // no flags to commit

    } else if(RISCV_DSP_VERSION(state->riscv)==RVDSPV_0_5_2) {

        // saturation flag in ucode CSR
        vmimtBinopRR(8, vmi_OR, CSR_REG_MT(ucode), RISCV_SF_TMP, 0);

    } else {

        // saturation flag in vxsat
        updateVXSat(state);
    }
}

//
// Return any saturation flags required for the unary operation
//
static vmiFlagsCP getUnopSatFlags(riscvMorphStateP state, vmiUnop op) {

    vmiFlagsCP result = 0;

    switch(op) {

        case vmi_NEGSQ:
        case vmi_ABSSQ:
            result = getSatFlags(state, True);
            break;

        default:
            break;
    }

    return result;
}

//
// Is the binop a signed saturating one?
//
static Bool isSQBinop(vmiBinop op) {

    Bool result = False;

    switch(op) {

        case vmi_ADDSQ:
        case vmi_SUBSQ:
        case vmi_RSUBSQ:
        case vmi_SHLSQ:
#if(ENABLE_P_EXT)
        case vmi_ADCSQ:
        case vmi_SBBSQ:
#endif
            result = True;
            break;

        default:
            break;
    }

    return result;
}

//
// Is the binop an unsigned saturating one?
//
static Bool isUQBinop(vmiBinop op) {

    Bool result = False;

    switch(op) {

        case vmi_ADDUQ:
        case vmi_SUBUQ:
        case vmi_RSUBUQ:
        case vmi_SHLUQ:
#if(ENABLE_P_EXT)
        case vmi_ADCUQ:
        case vmi_SBBUQ:
#endif
            result = True;
            break;

        default:
            break;
    }

    return result;
}

//
// Return any saturation flags required for the binary operation
//
static vmiFlagsCP getBinopSatFlags(riscvMorphStateP state, vmiBinop op) {

    vmiFlagsCP result = 0;

    if(isSQBinop(op)) {
        result = getSatFlags(state, True);
    } else if(isUQBinop(op)) {
        result = getSatFlags(state, False);
    }

    return result;
}


////////////////////////////////////////////////////////////////////////////////
// ROUNDING OPERATIONS
////////////////////////////////////////////////////////////////////////////////

//
// Return the operation, or rounding equivalent if required
//
static vmiBinop getBinopRound(riscvMorphStateP state, vmiBinop op) {

    if(!state->info.round) {
        // no action
    } else if(op==vmi_SHR) {
        op = vmi_SHRR;
    } else if(op==vmi_SAR) {
        op = vmi_SARR;
    }

    return op;
}


////////////////////////////////////////////////////////////////////////////////
// BASE INSTRUCTION CALLBACKS
////////////////////////////////////////////////////////////////////////////////

//
// No operation
//
static RISCV_MORPH_FN(emitNOP) {
    // no action
}

//
// Move value (two registers)
//
static RISCV_MORPH_FN(emitMoveRR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs   = unpackRX(state, 1);
    Uns32       bits = rd.bits;

    vmimtMoveRR(bits, rd.r, rs.r);

    writeUnpacked(rd);
}

//
// Move value (one register and constant)
//
static RISCV_MORPH_FN(emitMoveRC) {

    unpackedReg rd   = unpackRX(state, 0);
    Uns64       c    = state->info.c;
    Uns32       bits = rd.bits;

    vmimtMoveRC(bits, rd.r, c);

    writeUnpacked(rd);
}

//
// Move PC-relative constant
//
static RISCV_MORPH_FN(emitMoveRPC) {

    unpackedReg rd   = unpackRX(state, 0);
    Uns64       c    = state->info.c;
    Uns32       bits = rd.bits;

    // when in a delayed instruction context, base on that address
    if(state->inDelaySlot) {
        vmimtMoveRR(bits, rd.r, RISCV_JUMP_BASE);
    } else {
        vmimtMoveRSimPC(bits, rd.r);
    }

    vmimtBinopRC(bits, state->attrs->binop, rd.r, c, 0);

    writeUnpacked(rd);
}

//
// Implement generic Unop (two registers)
//
static RISCV_MORPH_FN(emitUnopRR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    vmiUnop     op   = state->attrs->unop;
    vmiFlagsCP  f    = getUnopSatFlags(state, op);
    Uns32       bits = rd.bits;

    vmimtUnopRR(bits, op, rd.r, rs1.r, f);
    commitSatFlag(state, f);

    writeUnpacked(rd);
}

//
// Implement generic Binop (three registers)
//
static RISCV_MORPH_FN(emitBinopRRR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    vmiBinop    op   = getBinopRound(state, state->attrs->binop);
    vmiFlagsCP  f    = getBinopSatFlags(state, op);
    Uns32       bits = rd.bits;

    vmimtBinopRRR(bits, op, rd.r, rs1.r, rs2.r, f);
    commitSatFlag(state, f);

    writeUnpacked(rd);
}

//
// Implement generic Mulop (three registers, selecting result upper half)
//
static RISCV_MORPH_FN(emitMulopHRRR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    Uns32       bits = rd.bits;

    vmimtMulopRRR(bits, state->attrs->binop, rd.r, VMI_NOREG, rs1.r, rs2.r, 0);

    writeUnpacked(rd);
}

//
// Implement generic Cmpop (three registers)
//
static RISCV_MORPH_FN(emitCmpopRRR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    Uns32       bits = rd.bits;

    vmimtCompareRR(bits, state->attrs->cond, rs1.r, rs2.r, rd.r);

    writeUnpackedSize(rd, 8);
}

//
// Implement generic Binop (two registers and constant)
//
static RISCV_MORPH_FN(emitBinopRRC) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    vmiBinop    op   = getBinopRound(state, state->attrs->binop);
    vmiFlagsCP  f    = getBinopSatFlags(state, op);
    Uns64       c    = state->info.c;
    Uns32       bits = rd.bits;

    vmimtBinopRRC(bits, op, rd.r, rs1.r, c, f);
    commitSatFlag(state, f);

    writeUnpacked(rd);
}

//
// Implement generic Cmpop (two registers and constant)
//
static RISCV_MORPH_FN(emitCmpopRRC) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    Uns64       c    = state->info.c;
    Uns32       bits = rd.bits;

    vmimtCompareRC(bits, state->attrs->cond, rs1.r, c, rd.r);

    writeUnpackedSize(rd, 8);
}

//
// Get alignment constraint
//
inline static memConstraint doAligned(Bool unaligned) {
    return unaligned ? MEM_CONSTRAINT_NONE : MEM_CONSTRAINT_ALIGNED;
}

//
// Mark memory access constraint as atomic
//
inline static memConstraint markAtomic(memConstraint constraint) {
    return constraint | MEM_CONSTRAINT_USER1;
}

//
// Get alignment constraint for load/store operations
//
static memConstraint getLoadStoreConstraint(riscvMorphStateP state) {

    riscvP riscv     = state->riscv;
    Bool   unaligned = riscv->configInfo.unaligned;

    return doAligned(unaligned);
}

//
// Get alignment constraint for atomic operations (must be aligned prior to
// version 2.3, marked as atomics using MEM_CONSTRAINT_USER1)
//
static memConstraint getLoadStoreConstraintAMO(riscvMorphStateP state) {

    riscvP riscv        = state->riscv;
    Bool   unaligned    = riscv->configInfo.unaligned;
    Bool   unalignedAMO = riscv->configInfo.unalignedAMO && unaligned;

    return markAtomic(doAligned(unalignedAMO));
}

//
// Get alignment constraint for LR/SC operations (always aligned)
//
static memConstraint getLoadStoreConstraintLR(riscvMorphStateP state) {

    return markAtomic(MEM_CONSTRAINT_ALIGNED);
}

//
// Load value from memory
//
static RISCV_MORPH_FN(emitLoad) {

    unpackedReg   rd         = unpackRX(state, 0);
    unpackedReg   ra         = unpackRX(state, 1);
    Uns32         rdBits     = rd.bits;
    memConstraint constraint = getLoadStoreConstraint(state);

    // call common code to perform load
    emitLoadCommon(state, rd.r, rdBits, ra.r, constraint);

    writeUnpacked(rd);
}

//
// Store value to memory
//
static RISCV_MORPH_FN(emitStore) {

    unpackedReg   rs         = unpackRX(state, 0);
    unpackedReg   ra         = unpackRX(state, 1);
    memConstraint constraint = getLoadStoreConstraint(state);

    // call common code to perform store
    emitStoreCommon(state, rs.r, ra.r, constraint);
}

//
// Is constant target address aligned?
//
static Bool isTargetAddressAlignedC(riscvP riscv, Uns64 tgt) {

    if(!(tgt&0x2)) {

        // address is aligned
        return True;

    } else if(isFeaturePresentMT(riscv, ISA_C)) {

        // compressed instructions enabled
        return True;

    } else {

        // address is not aligned
        return False;
    }
}

//
// Take Instruction Address Misaligned exception
//
static void emitTargetAddressUnalignedC(riscvP riscv, Uns64 tgt) {

    vmiCallFn exceptCB = (vmiCallFn)riscvInstructionAddressMisaligned;

    // emit call generating Instruction Address Misaligned exception
    vmimtArgProcessor();
    vmimtArgUns64(tgt);
    vmimtCallAttrs(exceptCB, VMCA_EXCEPTION);
}

//
// Validate target address in register is aligned and take exception if not
//
static void checkTargetAddressAlignedR(
    riscvMorphStateP state,
    Uns32            bits,
    vmiReg           ra
) {
    riscvP riscv = state->riscv;

    if(!isFeaturePresentMT(riscv, ISA_C)) {

        vmiLabelP ok       = vmimtNewLabel();
        vmiCallFn exceptCB = (vmiCallFn)riscvInstructionAddressMisaligned;

        // skip misaligned instruction exception if bit[1] is clear
        vmimtTestRCJumpLabel(bits, vmi_COND_Z, ra, 0x2, ok);

        // extend target address to 64 bits
        vmiReg tmp = newTmp(state);
        vmimtMoveExtendRR(64, tmp, bits, ra, False);

        // emit call generating Illegal Instruction exception
        vmimtArgProcessor();
        vmimtArgReg(64, tmp);
        vmimtCallAttrs(exceptCB, VMCA_EXCEPTION);

        // free temporary address
        freeTmp(state);

        // here if access is legal
        vmimtInsertLabel(ok);
    }
}

//
// Branch based on comparison
//
static void emitBranchRX(riscvMorphStateP state, vmiReg tmp) {

    riscvP riscv = state->riscv;
    Uns64  tgt   = state->info.tgt;

    // validate target address alignment
    if(!isTargetAddressAlignedC(riscv, tgt)) {

        vmiLabelP noBranch = vmimtNewLabel();

        // skip alignment test if condition is False
        vmimtCondJumpLabel(tmp, False, noBranch);

        // take Instruction Address Misaligned exception
        emitTargetAddressUnalignedC(riscv, tgt);

        // here if address is aligned
        vmimtInsertLabel(noBranch);
    }

    // do branch
    vmimtCondJump(tmp, True, 0, tgt, VMI_NOREG, vmi_JH_RELATIVE);
}

//
// Branch based on register comparison
//
static RISCV_MORPH_FN(emitBranchRR) {

    unpackedReg rs1  = unpackRX(state, 0);
    unpackedReg rs2  = unpackRX(state, 1);
    Uns32       bits = rs1.bits;
    vmiReg      tmp  = newTmp(state);

    // do comparison
    vmimtCompareRR(bits, state->attrs->cond, rs1.r, rs2.r, tmp);

    // common branch code
    emitBranchRX(state, tmp);
}

//
// Branch based on constant comparison
//
static RISCV_MORPH_FN(emitBranchRC) {

    unpackedReg rs1  = unpackRX(state, 0);
    Uns64       c    = state->info.c;
    Uns32       bits = rs1.bits;
    vmiReg      tmp  = newTmp(state);

    // do comparison
    vmimtCompareRC(bits, state->attrs->cond, rs1.r, c, tmp);

    // common branch code
    emitBranchRX(state, tmp);
}

//
// Return link address if the current instruction requires it
//
static Uns64 getLinkPC(riscvMorphStateP state, vmiReg *lrP) {

    Uns64 linkPC = state->info.thisPC + state->info.bytes;

    if(state->inDelaySlot) {

        vmimtGetDelaySlotNextPC(*lrP, True);

        *lrP   = VMI_NOREG;
        linkPC = 0;
    }

    return linkPC;
}

//
// Jump to constant target address
//
static RISCV_MORPH_FN(emitJAL) {

    riscvP       riscv  = state->riscv;
    unpackedReg  lr     = unpackRX(state, 0);
    Uns64        tgt    = state->info.tgt;
    vmiJumpHint  hint   = isLR(lr.r) ? vmi_JH_CALL : vmi_JH_NONE;

    // validate target address alignment
    if(!isTargetAddressAlignedC(riscv, tgt)) {
        emitTargetAddressUnalignedC(riscv, tgt);
    }

    // emit call using calculated linkPC and adjusted lr
    Uns64 linkPC = getLinkPC(state, &lr.r);
    vmimtUncondJump(linkPC, tgt, lr.r, hint|vmi_JH_RELATIVE);
}

//
// Emit common code for indirect jump-and-link
//
static void emitJALRInt(riscvMorphStateP state, vmiReg ra, unpackedReg lr) {

    Uns32       bits = lr.bits;
    vmiJumpHint hint;

    // validate target address alignment
    checkTargetAddressAlignedR(state, bits, ra);

    // derive jump hint
    if(isLR(ra)) {
        hint = vmi_JH_RETURN;
    } else if(isLR(lr.r)) {
        hint = vmi_JH_CALL;
    } else {
        hint = vmi_JH_NONE;
    }

    // emit call using calculated linkPC and adjusted lr
    Uns64 linkPC = getLinkPC(state, &lr.r);
    vmimtUncondJumpReg(linkPC, ra, lr.r, hint|vmi_JH_RELATIVE);
}

//
// Jump to register target address
//
static RISCV_MORPH_FN(emitJALR) {

    unpackedReg ra     = unpackRX(state, 1);
    Uns64       offset = state->info.c;

    // calculate target address if required
    if(offset) {
        vmiReg tmp  = newTmp(state);
        Uns32  bits = ra.bits;
        vmimtBinopRRC(bits, vmi_ADD, tmp, ra.r, offset, 0);
        ra.r = tmp;
    }

    // emit code for indirect jump and link
    emitJALRInt(state, ra.r, unpackRX(state, 0));
}


////////////////////////////////////////////////////////////////////////////////
// ATOMIC MEMORY OPERATIONS
////////////////////////////////////////////////////////////////////////////////

//
// Get atomic operation code for current binop
//
static atomicCode getBinopAtomicCode(riscvMorphStateP state) {

    static const atomicCode map[] = {
        [vmi_IMIN] = ACODE_MIN,
        [vmi_IMAX] = ACODE_MAX,
        [vmi_MIN]  = ACODE_MINU,
        [vmi_MAX]  = ACODE_MAXU,
        [vmi_ADD]  = ACODE_ADD,
        [vmi_XOR]  = ACODE_XOR,
        [vmi_OR]   = ACODE_OR,
        [vmi_AND]  = ACODE_AND,
    };

    return map[state->attrs->binop];
}

//
// Emit atomic code operation if required
//
static void emitAtomicCode(riscvP riscv, atomicCode code) {

    Uns32  handle = riscv->AMOActiveHandle;

    // update atomic operation code
    vmimtMoveRC(8, RISCV_ATOMIC, code);

    // notify platform of active atomic operation
    if(handle) {
        vmimtArgProcessor();
        vmimtArgUns32(handle);
        vmimtArgUns32(code);
        vmimtCallAttrs((vmiCallFn)vmirtWriteNetPort, VMCA_NO_INVALIDATE);
    }
}

//
// Function type implement generic AMO operation
//
#define AMO_FN(_NAME) void _NAME( \
    riscvMorphStateP state, \
    Uns32            bits,  \
    vmiReg           rd,    \
    vmiReg           ra,    \
    vmiReg           rb     \
)
typedef AMO_FN((*amoCB));

//
// Atomic memory operation (internal interface)
//
static void emitAMOCommonInt(
    riscvMorphStateP state,
    amoCB            opCB,
    vmiReg           rd,
    vmiReg           rs,
    vmiReg           ra,
    Uns32            bits,
    atomicCode       code
) {
    riscvP        riscv      = state->riscv;
    Bool          doLSTrig   = riscv->configInfo.amo_trigger;
    Bool          triggerLA  = doLSTrig && triggerLoadAddressMT(riscv);
    Bool          triggerLV  = doLSTrig && triggerLoadValueMT(riscv);
    Bool          triggerS   = doLSTrig && triggerStoreMT(riscv);
    memConstraint constraint = getLoadStoreConstraintAMO(state);
    vmiReg        tmp1       = RISCV_TRIGGER_LV;
    vmiReg        tmp2       = newTmp(state);
    Uns32         memBits    = state->info.memBits;

    // emit operation atomic code
    emitAtomicCode(riscv, code);

    // for this instruction, memBits is bits if unspecified or SEW
    if(!memBits || (memBits==-1)) {
        memBits = state->info.memBits = bits;
    }

    // generate trigger VA if required
    if(triggerLA || triggerLV || triggerS) {
        Uns64 offset = 0;
        emitTriggerVA(riscv, &ra, &offset);
    }

    // invoke load address trigger if required
    emitTriggerLA(triggerLA, memBits);

    // this is an atomic operation
    vmimtAtomic();

    // generate Store/AMO exception in preference to Load exception
    emitTryStoreCommon(state, ra, constraint);

    // allow derived model to modify atomic operation if required
    ITER_EXT_CB(
        riscv, extCB, AMOMorph,
        extCB->AMOMorph(riscv, extCB->clientData);
    )

    // disable load/store triggers in emitLoadCommon/emitStoreCommon
    riscv->blockState->doLSTrig = False;

    // do initial load
    emitLoadCommon(state, tmp1, bits, ra, constraint);

    // invoke load value trigger if required
    emitTriggerLV(triggerLV, tmp1, bits, memBits);

    // do AMO operation
    opCB(state, bits, tmp2, tmp1, rs);

    // invoke store address/value trigger if required
    emitTriggerS(triggerS, rs, memBits);

    // do store
    emitStoreCommon(state, tmp2, ra, constraint);

    // commit result
    vmimtMoveRR(bits, rd, tmp1);

    // enable load/store triggers in emitLoadCommon/emitStoreCommon
    riscv->blockState->doLSTrig = True;

    // free temporaries
    freeTmp(state);

    // indicate end of atomic operation
    emitAtomicCode(riscv, ACODE_NONE);
}

//
// Atomic memory operation (GPR arguments)
//
static void emitAMOCommonRRR(
    riscvMorphStateP state,
    amoCB            opCB,
    atomicCode       code
) {
    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs   = unpackRX(state, 1);
    unpackedReg ra   = unpackRX(state, 2);
    Uns32       bits = rd.bits;

    emitAMOCommonInt(state, opCB, rd.r, rs.r, ra.r, bits, code);

    writeUnpacked(rd);
}

//
// AMO binop callback
//
static AMO_FN(emitAMOBinopRRRCB) {
    vmimtBinopRRR(bits, state->attrs->binop, rd, ra, rb, 0);
}

//
// AMO swap callback
//
static AMO_FN(emitAMOSwapRRRCB) {
    vmimtMoveRR(bits, rd, rb);
}

//
// Atomic memory operation using defined VMI binop
//
static RISCV_MORPH_FN(emitAMOBinopRRR) {
    emitAMOCommonRRR(state, emitAMOBinopRRRCB, getBinopAtomicCode(state));
}

//
// Atomic memory operation using swap
//
static RISCV_MORPH_FN(emitAMOSwapRRR) {
    emitAMOCommonRRR(state, emitAMOSwapRRRCB, ACODE_SWAP);
}


////////////////////////////////////////////////////////////////////////////////
// LR/SC INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Check function for externally-implemented LR/SC
//
#define RV_LR_SC_FN(_NAME) void _NAME(riscvP riscv, Uns64 address)
typedef RV_LR_SC_FN((*riscvLRSCFn));

//
// This defines exclusive tag bits
//
inline static Uns32 getEABits(riscvMorphStateP state) {
    return riscvGetXlenArch(state->riscv);
}

//
// This defines exclusive tag bits
//
inline static Uns32 getModeBits(riscvMorphStateP state) {
    return riscvGetXlenMode(state->riscv);
}

//
// Is LR/SC locking implemented externally?
//
static Bool isLockExternal(riscvMorphStateP state) {
    return state->riscv->LRAddressHandle && state->riscv->SCAddressHandle;
}

//
// Write exclusive address to the given port
//
static void writeNetPortExclusive(riscvP riscv, Uns32 port, Uns64 address) {

    Uns32 bits = riscvGetXlenMode(riscv);
    Uns64 mask = (bits==64) ? -1 : ((1ULL<<bits)-1);

    vmirtWriteNetPort((vmiProcessorP)riscv, port, address & mask);
}

//
// Callback to initiate externally-managed lock for LR instruction
//
static void externalLR(riscvP riscv, Uns64 address) {
    writeNetPortExclusive(riscv, riscv->LRAddressHandle, address);
}

//
// Callback to complete externally-managed lock for SC instruction
//
static void externalSC(riscvP riscv, Uns64 address) {
    writeNetPortExclusive(riscv, riscv->SCAddressHandle, address);
}

//
// Generate exclusive access tag address ra in register rtag
//
static void generateEATag(
    riscvMorphStateP state,
    vmiReg           rtag,
    vmiReg           ra,
    riscvLRSCFn      checkCB
) {
    Uns32 bits   = getEABits(state);
    Uns32 raBits = getModeBits(state);

    // generate tag
    vmimtMoveExtendRR(bits, rtag, raBits, ra, False);
    vmimtBinopRC(bits, vmi_AND, rtag, state->riscv->exclusiveTagMask, 0);

    // emit call to external check function if required
    if(isLockExternal(state)) {
        vmimtArgProcessor();
        vmimtArgReg(64, ra);
        vmimtCallAttrs((vmiCallFn)checkCB, VMCA_NO_INVALIDATE);
    }
}

//
// Emit code to start exclusive access to address ra
//
static void startEA(riscvMorphStateP state, vmiReg ra) {

    // instruction must execute atomically but should not be classed as atomic
    // by instruction attributes (it is OCL_IC_EXCLUSIVE)
    vmimtAtomic();
    vmimtInstructionClassSub(OCL_IC_ATOMIC);

    // generate exclusive access tag for this address
    generateEATag(state, RISCV_EA_TAG, ra, externalLR);
}

//
// Emit code to check SC access constraints
//
static void emitValidateSCAccess(riscvMorphStateP state, vmiReg ra) {

    riscvP        riscv      = state->riscv;
    memConstraint constraint = getLoadStoreConstraintLR(state);

    if(constraint) {
        setAddressMaskMT(riscv);
        vmimtTryStoreRC(state->info.memBits, 0, ra, constraint);
    }
}

//
// Validate the exclusive access and jump to label 'done' if it is invalid,
// setting rd to 1
//
static vmiLabelP validateEA(
    riscvMorphStateP state,
    vmiReg           ra,
    vmiReg           rd,
    Uns32            rdBits
) {
    vmiLabelP done = vmimtNewLabel();
    vmiLabelP ok   = vmimtNewLabel();
    vmiReg    t    = newTmp(state);

    // validate SC access constraints
    emitValidateSCAccess(state, ra);

    // generate exclusive access tag for this address
    generateEATag(state, t, ra, externalSC);

    // do load and store tags match?
    vmimtCompareRR(getEABits(state), vmi_COND_EQ, RISCV_EA_TAG, t, t);

    // commit store if tags match
    vmimtCondJumpLabel(t, True, ok);

    // indicate store failed
    vmimtMoveRC(rdBits, rd, 1);

    // jump to instruction end
    vmimtUncondJumpLabel(done);

    // here to commit store
    vmimtInsertLabel(ok);

    return done;
}

//
// Do actions required to terminate exclusive access
//
static void clearEAMT(riscvMorphStateP state) {

    // exclusiveTag becomes RISCV_NO_TAG to indicate no active access
    vmimtMoveRC(getEABits(state), RISCV_EA_TAG, RISCV_NO_TAG);
}

//
// Do actions required to complete exclusive access
//
static void endEA(
    riscvMorphStateP state,
    vmiReg           rd,
    Uns32            rdBits,
    vmiLabelP        done
) {
    // indicate store succeeded
    vmimtMoveRC(rdBits, rd, 0);

    // insert target label for aborted stores
    vmimtInsertLabel(done);

    // terminate exclusive access
    clearEAMT(state);
}

//
// Emit code for LR
//
static RISCV_MORPH_FN(emitLR) {

    riscvP        riscv      = state->riscv;
    unpackedReg   rd         = unpackRX(state, 0);
    unpackedReg   ra         = unpackRX(state, 1);
    Uns32         rdBits     = rd.bits;
    memConstraint constraint = getLoadStoreConstraintLR(state);

    // emit operation atomic code
    emitAtomicCode(riscv, ACODE_LR);

    // for this instruction, memBits is rdBits
    state->info.memBits = rdBits;

    // indicate LR is now active at address ra
    startEA(state, ra.r);

    // call common code to perform load
    emitLoadCommon(state, rd.r, rdBits, ra.r, constraint);

    // extend result to required size
    writeUnpacked(rd);

    // indicate end of atomic operation
    emitAtomicCode(riscv, ACODE_NONE);
}

//
// Emit code for SC
//
static RISCV_MORPH_FN(emitSC) {

    riscvP        riscv      = state->riscv;
    unpackedReg   rd         = unpackRX(state, 0);
    unpackedReg   rs         = unpackRX(state, 1);
    unpackedReg   ra         = unpackRX(state, 2);
    Uns32         rdBits     = rd.bits;
    memConstraint constraint = getLoadStoreConstraint(state);

    // emit operation atomic code
    emitAtomicCode(riscv, ACODE_SC);

    // for this instruction, memBits is rsBits
    state->info.memBits = rs.bits;

    // validate SC attempt at address ra
    vmiLabelP done = validateEA(state, ra.r, rd.r, rdBits);

    // call common code to perform store
    emitStoreCommon(state, rs.r, ra.r, constraint);

    // complete SC attempt
    endEA(state, rd.r, rdBits, done);

    // extend result to required size
    writeUnpacked(rd);

    // indicate end of atomic operation
    emitAtomicCode(riscv, ACODE_NONE);
}


////////////////////////////////////////////////////////////////////////////////
// SYSTEM INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// This defines the type of a non-returning exception callback
//
#define EXCEPTION_FN(_NAME) void _NAME(riscvP riscv)
typedef EXCEPTION_FN((*exceptionFn));

//
// Emit code to an embedded exception function
//
static void emitException(exceptionFn cb) {
    vmimtArgProcessor();
    vmimtCallAttrs((vmiCallFn)cb, VMCA_EXCEPTION);
}

//
// Implement ECALL instruction
//
static RISCV_MORPH_FN(emitECALL) {
    emitException(riscvECALL);
}

//
// Implement EBREAK instruction
//
static RISCV_MORPH_FN(emitEBREAK) {
    emitException(riscvEBREAK);
}

//
// Implement MRET instruction
//
static RISCV_MORPH_FN(emitMRET) {

    riscvP riscv = state->riscv;

    // this instruction must be executed in Machine mode
    requireModeMT(riscv, RISCV_MODE_M);

    emitException(riscvMRET);
}

//
// Implement MNRET instruction
//
static RISCV_MORPH_FN(emitMNRET) {

    riscvP riscv = state->riscv;

    if(!RISCV_RNMI_VERSION(riscv)) {

        // illegal unless RNMI is configured
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IRNMI", "RNMI not present");

    } else {

        // this instruction must be executed in Machine mode
        requireModeMT(riscv, RISCV_MODE_M);

        emitException(riscvMNRET);
    }
}

//
// Implement DRET instruction
//
static RISCV_MORPH_FN(emitDRET) {

    riscvP riscv = state->riscv;

    // this instruction must be executed in Machine mode
    requireModeMT(riscv, RISCV_MODE_M);

    emitException(riscvDRET);
}

//
// Implement SRET instruction
//
static RISCV_MORPH_FN(emitSRET) {

    riscvP riscv = state->riscv;

    // this instruction requires Supervisor mode to be implemented
    checkHaveSModeMT(riscv);

    // this instruction must be executed in Machine mode or Supervisor mode
    requireModeMT(riscv, RISCV_MODE_S);

    // instruction is trapped if mstatus.TSR=1
    riscvEmitTrapTSR(riscv);

    emitException(inVMode(riscv) ? riscvVSRET : riscvHSRET);
}

//
// Implement URET instruction
//
static RISCV_MORPH_FN(emitURET) {

    riscvP riscv = state->riscv;

    // this instruction requires User mode to be implemented
    checkHaveUModeMT(riscv);

    emitException(inVMode(riscv) ? riscvVURET : riscvURET);
}

//
// Implement WFI instruction
//
static RISCV_MORPH_FN(emitWFI) {

    riscvP riscv = state->riscv;

    // this instruction must be executed in Machine mode or Supervisor mode
    // unless User mode interrupts are implemented
    requireSIfNotArchMT(riscv, ISA_N);

    // instruction is trapped if mstatus.TW=1 in any non-Machine mode
    EMIT_TRAP_MASK_FIELD_NOT_M(riscv, mstatus, TW, 1);
    EMIT_TRAP_MASK_FIELD_VS(riscv, hstatus, TW, 1);

    // wait for interrupt (unless this is treated as a NOP)
    if(!riscv->configInfo.wfi_is_nop) {
        vmimtArgProcessor();
        vmimtCall((vmiCallFn)riscvWFI);
    }
}

//
// Implement FENCE.I
//
static RISCV_MORPH_FN(emitFENCEI) {

    riscvP riscv = state->riscv;

    if(riscv->configInfo.noZifencei) {
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IFI", "Zifencei absent");
    }
}

//
// Implement generic fence instruction
//
static void emitFENCECommon(
    riscvMorphStateP state,
    Bool             doTrap,
    const vmiCallFn  fenceCBs[2][2]
) {
    riscvP       riscv      = state->riscv;
    unpackedReg  VADDRr     = unpackRX(state, 0);
    unpackedReg  ASIDr      = unpackRX(state, 1);
    Uns32        bits       = VADDRr.bits;
    Bool         haveVADDRr = !VMI_ISNOREG(VADDRr.r);
    Bool         haveASIDr  = !VMI_ISNOREG(ASIDr.r);

    // this instruction requires Supervisor mode to be implemented
    checkHaveSModeMT(riscv);

    // this instruction must be executed in Machine mode or Supervisor mode
    requireModeMT(riscv, RISCV_MODE_S);

    // instruction is trapped if mstatus.TVM=1 if required
    if(doTrap) {
        riscvEmitTrapTVM(riscv);
    }

    // emit processor argument
    vmimtArgProcessor();

    // emit VA argument if required
    if(haveVADDRr) {
        vmiReg tmp = newTmp(state);
        vmimtMoveExtendRR(64, tmp, bits, VADDRr.r, False);
        vmimtArgReg(64, tmp);
    }

    // emit ASID argument if required
    if(haveASIDr) {
        vmimtArgReg(32, ASIDr.r);
    }

    // emit call
    vmimtCall(fenceCBs[haveVADDRr][haveASIDr]);
}

//
// Implement SFENCE.VMA instruction
//
static RISCV_MORPH_FN(emitSFENCE_VMA) {

    // callbacks implementing SFENCE.VMA
    const vmiCallFn fenceCBs[2][2] = {
        {
            (vmiCallFn)riscvVMInvalidateAll,
            (vmiCallFn)riscvVMInvalidateAllASID
        },
        {
            (vmiCallFn)riscvVMInvalidateVA,
            (vmiCallFn)riscvVMInvalidateVAASID
        }
    };

    emitFENCECommon(state, True, fenceCBs);
}

//
// Implement HFENCE.VVMA instruction
//
static RISCV_MORPH_FN(emitHFENCE_VVMA) {

    // callbacks implementing HFENCE.VVMA
    const vmiCallFn fenceCBs[2][2] = {
        {
            (vmiCallFn)riscvVMInvalidateAllV,
            (vmiCallFn)riscvVMInvalidateAllASIDV
        },
        {
            (vmiCallFn)riscvVMInvalidateVAV,
            (vmiCallFn)riscvVMInvalidateVAASIDV
        }
    };

    if(inVMode(state->riscv)) {
        riscvEmitVirtualInstructionMode(state->riscv);
    } else {
        emitFENCECommon(state, False, fenceCBs);
    }
}

//
// Implement HFENCE.GVMA instruction
//
static RISCV_MORPH_FN(emitHFENCE_GVMA) {

    // callbacks implementing HFENCE.GVMA
    const vmiCallFn fenceCBs[2][2] = {
        {
            (vmiCallFn)riscvVMInvalidateAllG,
            (vmiCallFn)riscvVMInvalidateAllVMIDG
        },
        {
            (vmiCallFn)riscvVMInvalidateVAG,
            (vmiCallFn)riscvVMInvalidateVAVMIDG
        }
    };

    if(inVMode(state->riscv)) {
        riscvEmitVirtualInstructionMode(state->riscv);
    } else {
        emitFENCECommon(state, True, fenceCBs);
    }
}


////////////////////////////////////////////////////////////////////////////////
// CSR ACCESS INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Indicate whether CSR must be read
//
static Bool doCSRRead(riscvMorphStateP state, vmiReg rd) {
    return (!VMI_ISNOREG(rd) || (state->info.csrUpdate!=RV_CSR_RW));
}

//
// Indicate whether CSR must be written (depending on whether rs1 is zero)
//
static Bool doCSRWriteRS1(riscvMorphStateP state, vmiReg rs1) {
    return (!VMI_ISNOREG(rs1) || (state->info.csrUpdate==RV_CSR_RW));
}

//
// Indicate whether CSR must be written (depending on whether imm is zero)
//
static Bool doCSRWriteImm(riscvMorphStateP state, Uns64 imm) {
    return (imm || (state->info.csrUpdate==RV_CSR_RW));
}

//
// Implement CSR access, either with two GPRs or GPR and immediate
//
static void emitCSRRCommon(riscvMorphStateP state, vmiReg rs1, Bool write) {

    riscvP          riscv = state->riscv;
    Uns32           csr   = state->info.csr;
    unpackedReg     rd    = unpackRX(state, 0);
    Uns32           bits  = rd.bits;
    Bool            read  = doCSRRead(state, rd.r);
    riscvCSRAttrsCP attrs = riscvValidateCSRAccess(riscv, csr, read, write);

    // action only required for valid access
    if(attrs) {

        vmiReg rdTmp = read ? newTmp(state) : VMI_NOREG;

        // handle traps if mstatus.TVM=1 (e.g. satp register)
        if(attrs->TVMT) {
            riscvEmitTrapTVM(riscv);
        }

        // emit code to read the CSR if required
        if(read) {
            riscvEmitCSRRead(attrs, riscv, rdTmp, write);
        }

        // emit code to write the CSR if required
        if(write) {

            vmiReg rs1Tmp = newTmp(state);
            vmiReg cbTmp  = newTmp(state);
            Bool   useRS1 = !VMI_ISNOREG(rs1);
            Uns64  c      = state->info.c;

            switch(state->info.csrUpdate) {

                case RV_CSR_RW:
                    if(useRS1) {
                        rs1Tmp = rs1;
                    } else {
                        vmimtMoveRC(bits, rs1Tmp, c);
                    }
                    break;

                case RV_CSR_RS:
                    if(useRS1) {
                        vmimtBinopRRR(bits, vmi_OR, rs1Tmp, rdTmp, rs1, 0);
                    } else {
                        vmimtBinopRRC(bits, vmi_OR, rs1Tmp, rdTmp, c, 0);
                    }
                    break;

                case RV_CSR_RC:
                    if(useRS1) {
                        vmimtBinopRRR(bits, vmi_ANDN, rs1Tmp, rdTmp, rs1, 0);
                    } else {
                        vmimtBinopRRC(bits, vmi_ANDN, rs1Tmp, rdTmp, c, 0);
                    }
                    break;

                default:
                    VMI_ABORT("unimplemented case"); // LCOV_EXCL_LINE
            }

            // do the write
            riscvEmitCSRWrite(attrs, riscv, rdTmp, rs1Tmp, cbTmp);

            // adjust code generator state after CSR write if required
            if(attrs->wstateCB) {
                attrs->wstateCB(state, useRS1);
            }
        }

        // commit read value
        vmimtMoveRR(bits, rd.r, rdTmp);
        writeUnpacked(rd);
    }
}

//
// Implement CSR access (two GPRs)
//
static RISCV_MORPH_FN(emitCSRR) {

    unpackedReg rs1   = unpackRX(state, 1);
    Bool        write = doCSRWriteRS1(state, rs1.r);

    emitCSRRCommon(state, rs1.r, write);
}

//
// Implement CSR access (GPR and immediate)
//
static RISCV_MORPH_FN(emitCSRRI) {

    Bool write = doCSRWriteImm(state, state->info.c);

    emitCSRRCommon(state, VMI_NOREG, write);
}


////////////////////////////////////////////////////////////////////////////////
// 16-BIT FLOATING POINT UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Is the Flt16 value a NaN or infinity?
//
inline static Bool isNaNorInf16(Uns16 value) {
    return FP16_EXPONENT(value)==FP16_EXP_ONES;
}

//
// Is the Flt16 value a NaN?
//
inline static Bool isNaN16(Uns16 value) {
    return isNaNorInf16(value) && FP16_FRACTION(value);
}

//
// Is the Flt16 value an infinity?
//
inline static Bool isInf16(Uns16 value) {
    return isNaNorInf16(value) && !FP16_FRACTION(value);
}

//
// Is the Flt16 value a denormal?
//
inline static Bool isDenorm16(Uns16 value) {
    return !FP16_EXPONENT(value) && FP16_FRACTION(value);
}

//
// Is the Flt16 value a zero?
//
inline static Bool isZero16(Uns16 value) {
    return !(value & ~FP16_SIGN_MASK);
}

//
// Is the Flt16 value a QNaN?
//
inline static Bool isQNaN16(Uns16 value) {
    return isNaN16(value) && (value & FP16_QNAN_MASK);
}

//
// Is the Flt16 value an SNaN?
//
inline static Bool isSNaN16(Uns16 value) {
    return isNaN16(value) && !(value & FP16_QNAN_MASK);
}


////////////////////////////////////////////////////////////////////////////////
// 32-BIT FLOATING POINT UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Is the Flt32 value a NaN or infinity?
//
inline static Bool isNaNorInf32(Uns32 value) {
    return FP32_EXPONENT(value)==FP32_EXP_ONES;
}

//
// Is the Flt32 value a NaN?
//
inline static Bool isNaN32(Uns32 value) {
    return isNaNorInf32(value) && FP32_FRACTION(value);
}

//
// Is the Flt32 value an infinity?
//
inline static Bool isInf32(Uns32 value) {
    return isNaNorInf32(value) && !FP32_FRACTION(value);
}

//
// Is the Flt32 value a denormal?
//
inline static Bool isDenorm32(Uns32 value) {
    return !FP32_EXPONENT(value) && FP32_FRACTION(value);
}

//
// Is the Flt32 value a zero?
//
inline static Bool isZero32(Uns32 value) {
    return !(value & ~FP32_SIGN_MASK);
}

//
// Is the Flt32 value a QNaN?
//
inline static Bool isQNaN32(Uns32 value) {
    return isNaN32(value) && (value & FP32_QNAN_MASK);
}

//
// Is the Flt32 value an SNaN?
//
inline static Bool isSNaN32(Uns32 value) {
    return isNaN32(value) && !(value & FP32_QNAN_MASK);
}


////////////////////////////////////////////////////////////////////////////////
// 64-BIT FLOATING POINT UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Is the Flt64 value a NaN or infinity?
//
inline static Bool isNaNorInf64(Uns64 value) {
    return FP64_EXPONENT(value)==FP64_EXP_ONES;
}

//
// Is the Flt64 value a NaN?
//
inline static Bool isNaN64(Uns64 value) {
    return isNaNorInf64(value) && FP64_FRACTION(value);
}

//
// Is the Flt64 value an infinity?
//
inline static Bool isInf64(Uns64 value) {
    return isNaNorInf64(value) && !FP64_FRACTION(value);
}

//
// Is the Flt64 value a denormal?
//
inline static Bool isDenorm64(Uns64 value) {
    return !FP64_EXPONENT(value) && FP64_FRACTION(value);
}

//
// Is the Flt64 value a zero?
//
inline static Bool isZero64(Uns64 value) {
    return !(value & ~FP64_SIGN_MASK);
}

//
// Is the Flt64 value a QNaN?
//
inline static Bool isQNaN64(Uns64 value) {
    return isNaN64(value) && (value & FP64_QNAN_MASK);
}

//
// Is the Flt64 value an SNaN?
//
inline static Bool isSNaN64(Uns64 value) {
    return isNaN64(value) && !(value & FP64_QNAN_MASK);
}


////////////////////////////////////////////////////////////////////////////////
// GENERAL QNAN/INDETERMINATE HANDLERS
////////////////////////////////////////////////////////////////////////////////

//
// 16-bit QNaN result - return default QNaN
//
static VMI_FP_QNAN16_RESULT_FN(handleQNaN16) {
    return FP16_DEFAULT_QNAN;
}

//
// 32-bit QNaN result - return default QNaN
//
static VMI_FP_QNAN32_RESULT_FN(handleQNaN32) {
    return FP32_DEFAULT_QNAN;
}

//
// 64-bit QNaN result - return default QNaN
//
static VMI_FP_QNAN64_RESULT_FN(handleQNaN64) {
    return FP64_DEFAULT_QNAN;
}

//
// Return the sign of the indeterminate value
//
static Bool getIndeterminateSign(vmiFPArg value) {

    Bool sign = False;

    if(value.type == vmi_FT_16_IEEE_754) {
        sign = (value.f16Parts.sign && !isNaN16(value.u16));
    } else if(value.type == vmi_FT_32_IEEE_754) {
        sign = (value.f32Parts.sign && !isNaN32(value.u32));
    } else if(value.type == vmi_FT_64_IEEE_754) {
        sign = (value.f64Parts.sign && !isNaN64(value.u64));
    } else if(value.type == vmi_FT_BFLOAT16) {
        sign = (value.f32Parts.sign && !isNaN32(value.u32));
    } else {
        VMI_ABORT("unimplemented type %u", value.type); // LCOV_EXCL_LINE
    }

    return sign;
}

//
// 8-bit indeterminate result (NOTE: signed and unsigned results have distinct
// indeterminate patterns)
//
static VMI_FP_IND8_RESULT_FN(handleIndeterminate8) {

    Uns8 result;

    if(getIndeterminateSign(value)) {
        result = isSigned ? INT8_MIN : UNS8_MIN;
    } else {
        result = isSigned ? INT8_MAX : UNS8_MAX;
    }

    return result;
}

//
// 16-bit indeterminate result (NOTE: signed and unsigned results have distinct
// indeterminate patterns)
//
static VMI_FP_IND16_RESULT_FN(handleIndeterminate16) {

    Uns16 result;

    if(getIndeterminateSign(value)) {
        result = isSigned ? INT16_MIN : UNS16_MIN;
    } else {
        result = isSigned ? INT16_MAX : UNS16_MAX;
    }

    return result;
}

//
// 32-bit indeterminate result (NOTE: signed and unsigned results have distinct
// indeterminate patterns)
//
static VMI_FP_IND32_RESULT_FN(handleIndeterminate32) {

    Uns32 result;

    if(getIndeterminateSign(value)) {
        result = isSigned ? INT32_MIN : UNS32_MIN;
    } else {
        result = isSigned ? INT32_MAX : UNS32_MAX;
    }

    return result;
}

//
// 64-bit indeterminate result (NOTE: signed and unsigned results have distinct
// indeterminate patterns)
//
static VMI_FP_IND64_RESULT_FN(handleIndeterminate64) {

    Uns64 result;

    if(getIndeterminateSign(value)) {
        result = isSigned ? INT64_MIN : UNS64_MIN;
    } else {
        result = isSigned ? INT64_MAX : UNS64_MAX;
    }

    return result;
}


////////////////////////////////////////////////////////////////////////////////
// ISA VERSION 2.2 MIN/MAX RESULT HANDLERS
////////////////////////////////////////////////////////////////////////////////

//
// Common routine for 16-bit FMIN/FMAX result
//
static Uns16 doMinMax16_2_2(
    Uns16       result16,
    vmiFPArgP   args,
    vmiFPFlagsP setFlags
) {
    Uns16 arg0 = args[0].u16;
    Uns16 arg1 = args[1].u16;

    if(isSNaN16(arg0) || isSNaN16(arg1)) {
        setFlags->f.I = 1;
        result16 = FP16_DEFAULT_QNAN;
    } else if(isNaN16(arg0) && isNaN16(arg1)) {
        result16 = FP16_DEFAULT_QNAN;
    } else if(isNaN16(arg0)) {
        result16 = arg1;
    } else if(isNaN16(arg1)) {
        result16 = arg0;
    }

    return result16;
}

//
// Common routine for 32-bit FMIN/FMAX result
//
static Uns32 doMinMax32_2_2(
    Uns32       result32,
    vmiFPArgP   args,
    vmiFPFlagsP setFlags
) {
    Uns32 arg0 = args[0].u32;
    Uns32 arg1 = args[1].u32;

    if(isSNaN32(arg0) || isSNaN32(arg1)) {
        setFlags->f.I = 1;
        result32 = FP32_DEFAULT_QNAN;
    } else if(isNaN32(arg0) && isNaN32(arg1)) {
        result32 = FP32_DEFAULT_QNAN;
    } else if(isNaN32(arg0)) {
        result32 = arg1;
    } else if(isNaN32(arg1)) {
        result32 = arg0;
    }

    return result32;
}

//
// Common routine for 64-bit FMIN/FMAX result
//
static Uns64 doMinMax64_2_2(
    Uns64       result64,
    vmiFPArgP   args,
    vmiFPFlagsP setFlags
) {
    Uns64 arg0 = args[0].u64;
    Uns64 arg1 = args[1].u64;

    if(isSNaN64(arg0) || isSNaN64(arg1)) {
        setFlags->f.I = 1;
        result64 = FP64_DEFAULT_QNAN;
    } else if(isNaN64(arg0) && isNaN64(arg1)) {
        result64 = FP64_DEFAULT_QNAN;
    } else if(isNaN64(arg0)) {
        result64 = arg1;
    } else if(isNaN64(arg1)) {
        result64 = arg0;
    }

    return result64;
}

//
// 16-bit FMIN result handler
//
static VMI_FP_16_RESULT_FN(doFMin16_2_2) {

    if(isZero16(args[0].u16) && isZero16(args[1].u16)) {
        result16 = args[1].u16;
    } else if(isNaNorInf16(result16)) {
        result16 = doMinMax16_2_2(result16, args, setFlags);
    }

    return result16;
}

//
// 16-bit FMAX result handler
//
static VMI_FP_16_RESULT_FN(doFMax16_2_2) {

    if(isZero16(args[0].u16) && isZero16(args[1].u16)) {
        result16 = args[0].u16;
    } else if(isNaNorInf16(result16)) {
        result16 = doMinMax16_2_2(result16, args, setFlags);
    }

    return result16;
}

//
// 32-bit FMIN result handler
//
static VMI_FP_32_RESULT_FN(doFMin32_2_2) {

    if(isZero32(args[0].u32) && isZero32(args[1].u32)) {
        result32 = args[1].u32;
    } else if(isNaNorInf32(result32)) {
        result32 = doMinMax32_2_2(result32, args, setFlags);
    }

    return result32;
}

//
// 32-bit FMAX result handler
//
static VMI_FP_32_RESULT_FN(doFMax32_2_2) {

    if(isZero32(args[0].u32) && isZero32(args[1].u32)) {
        result32 = args[0].u32;
    } else if(isNaNorInf32(result32)) {
        result32 = doMinMax32_2_2(result32, args, setFlags);
    }

    return result32;
}

//
// 64-bit FMIN result handler
//
static VMI_FP_64_RESULT_FN(doFMin64_2_2) {

    if(isZero64(args[0].u64) && isZero64(args[1].u64)) {
        result64 = args[1].u64;
    } else if(isNaNorInf64(result64)) {
        result64 = doMinMax64_2_2(result64, args, setFlags);
    }

    return result64;
}

//
// 64-bit FMAX result handler
//
static VMI_FP_64_RESULT_FN(doFMax64_2_2) {

    if(isZero64(args[0].u64) && isZero64(args[1].u64)) {
        result64 = args[0].u64;
    } else if(isNaNorInf64(result64)) {
        result64 = doMinMax64_2_2(result64, args, setFlags);
    }

    return result64;
}


////////////////////////////////////////////////////////////////////////////////
// ISA VERSION 2.3 MIN/MAX RESULT HANDLERS
////////////////////////////////////////////////////////////////////////////////

//
// Common routine for 16-bit FMIN/FMAX result
//
static Uns16 doMinMax16_2_3(
    Uns16       result16,
    vmiFPArgP   args,
    vmiFPFlagsP setFlags
) {
    Uns16 arg0 = args[0].u16;
    Uns16 arg1 = args[1].u16;

    if(isSNaN16(arg0) || isSNaN16(arg1)) {
        setFlags->f.I = 1;
    }

    if(isNaN16(arg0) && isNaN16(arg1)) {
        result16 = FP16_DEFAULT_QNAN;
    } else if(isNaN16(arg0)) {
        result16 = arg1;
    } else if(isNaN16(arg1)) {
        result16 = arg0;
    }

    return result16;
}

//
// Common routine for 32-bit FMIN/FMAX result
//
static Uns32 doMinMax32_2_3(
    Uns32       result32,
    vmiFPArgP   args,
    vmiFPFlagsP setFlags
) {
    Uns32 arg0 = args[0].u32;
    Uns32 arg1 = args[1].u32;

    if(isSNaN32(arg0) || isSNaN32(arg1)) {
        setFlags->f.I = 1;
    }

    if(isNaN32(arg0) && isNaN32(arg1)) {
        result32 = FP32_DEFAULT_QNAN;
    } else if(isNaN32(arg0)) {
        result32 = arg1;
    } else if(isNaN32(arg1)) {
        result32 = arg0;
    }

    return result32;
}

//
// Common routine for 64-bit FMIN/FMAX result
//
static Uns64 doMinMax64_2_3(
    Uns64       result64,
    vmiFPArgP   args,
    vmiFPFlagsP setFlags
) {
    Uns64 arg0 = args[0].u64;
    Uns64 arg1 = args[1].u64;

    if(isSNaN64(arg0) || isSNaN64(arg1)) {
        setFlags->f.I = 1;
    }

    if(isNaN64(arg0) && isNaN64(arg1)) {
        result64 = FP64_DEFAULT_QNAN;
    } else if(isNaN64(arg0)) {
        result64 = arg1;
    } else if(isNaN64(arg1)) {
        result64 = arg0;
    }

    return result64;
}

//
// 16-bit FMIN result handler
//
static VMI_FP_16_RESULT_FN(doFMin16_2_3) {

    if(isZero16(args[0].u16) && isZero16(args[1].u16)) {
        result16 = args[0].u16 | args[1].u16;
    } else if(isNaNorInf16(result16)) {
        result16 = doMinMax16_2_3(result16, args, setFlags);
    }

    return result16;
}

//
// 16-bit FMAX result handler
//
static VMI_FP_16_RESULT_FN(doFMax16_2_3) {

    if(isZero16(args[0].u16) && isZero16(args[1].u16)) {
        result16 = args[0].u16 & args[1].u16;
    } else if(isNaNorInf16(result16)) {
        result16 = doMinMax16_2_3(result16, args, setFlags);
    }

    return result16;
}

//
// 32-bit FMIN result handler
//
static VMI_FP_32_RESULT_FN(doFMin32_2_3) {

    if(isZero32(args[0].u32) && isZero32(args[1].u32)) {
        result32 = args[0].u32 | args[1].u32;
    } else if(isNaNorInf32(result32)) {
        result32 = doMinMax32_2_3(result32, args, setFlags);
    }

    return result32;
}

//
// 32-bit FMAX result handler
//
static VMI_FP_32_RESULT_FN(doFMax32_2_3) {

    if(isZero32(args[0].u32) && isZero32(args[1].u32)) {
        result32 = args[0].u32 & args[1].u32;
    } else if(isNaNorInf32(result32)) {
        result32 = doMinMax32_2_3(result32, args, setFlags);
    }

    return result32;
}

//
// 64-bit FMIN result handler
//
static VMI_FP_64_RESULT_FN(doFMin64_2_3) {

    if(isZero64(args[0].u64) && isZero64(args[1].u64)) {
        result64 = args[0].u64 | args[1].u64;
    } else if(isNaNorInf64(result64)) {
        result64 = doMinMax64_2_3(result64, args, setFlags);
    }

    return result64;
}

//
// 64-bit FMAX result handler
//
static VMI_FP_64_RESULT_FN(doFMax64_2_3) {

    if(isZero64(args[0].u64) && isZero64(args[1].u64)) {
        result64 = args[0].u64 & args[1].u64;
    } else if(isNaNorInf64(result64)) {
        result64 = doMinMax64_2_3(result64, args, setFlags);
    }

    return result64;
}


////////////////////////////////////////////////////////////////////////////////
// RECIPROCAL ESTIMATE RESULT HANDLERS
////////////////////////////////////////////////////////////////////////////////

//
// Return floating point rounding mode master value
//
inline static riscvRMDesc getCurrentRM(riscvP riscv) {

    const static riscvRMDesc map[] = {
        RV_RM_RNE, RV_RM_RTZ,  RV_RM_RDN,  RV_RM_RUP,
        RV_RM_RMM, RV_RM_BAD5, RV_RM_BAD6, RV_RM_CURRENT
    };

    return map[RD_CSR_FIELDC(riscv, fcsr, frm)];
}

//
// Get index into reciprocal estimate LUT
//
#define RECIP_LUT_INDEX(_SIG, _S, _P) ((_SIG) >> ((_S) - (_P)))

//
// Reciprocal estimate LUT
//
static const Uns8 recip_lut[] = {
    127, 125, 123, 121, 119, 117, 116, 114,
    112, 110, 109, 107, 105, 104, 102, 100,
     99,  97,  96,  94,  93,  91,  90,  88,
     87,  85,  84,  83,  81,  80,  79,  77,
     76,  75,  74,  72,  71,  70,  69,  68,
     66,  65,  64,  63,  62,  61,  60,  59,
     58,  57,  56,  55,  54,  53,  52,  51,
     50,  49,  48,  47,  46,  45,  44,  43,
     42,  41,  40,  40,  39,  38,  37,  36,
     35,  35,  34,  33,  32,  31,  31,  30,
     29,  28,  28,  27,  26,  25,  25,  24,
     23,  23,  22,  21,  21,  20,  19,  19,
     18,  17,  17,  16,  15,  15,  14,  14,
     13,  12,  12,  11,  11,  10,   9,   9,
      8,   8,   7,   7,   6,   5,   5,   4,
      4,   3,   3,   2,   2,   1,   1,   0,
};

//
// Does FRECE7 overflow to the maximum value?
//
inline static Bool FRECE7OverflowToMax(riscvP riscv, Bool sign) {

    riscvRMDesc rm = getCurrentRM(riscv);

    return (
        (rm==RV_RM_RTZ) ||
        ((rm==RV_RM_RDN) && !sign) ||
        ((rm==RV_RM_RUP) && sign)
    );
}

//
// 16-bit FRECE7 result handler
//
static VMI_FP_16_RESULT_FN(doFRecE7_16) {

    riscvP riscv = (riscvP)processor;
    Bool   sign  = args[0].f16Parts.sign;
    Int32  exp   = args[0].f16Parts.exponent;
    Uns16  sig   = args[0].f16Parts.fraction;

    if(isInf16(args[0].u16)) {

        // inf => zero of same sign
        return FP16_ZERO(sign);

    } else if(isSNaN16(args[0].u16)) {

        // raise invalid on sNaN
        setFlags->f.I = 1;
        return FP16_DEFAULT_QNAN;

    } else if(isNaN16(args[0].u16)) {

        // NaN => canonical NaN
        return FP16_DEFAULT_QNAN;

    } else if(isZero16(args[0].u16)) {

        // zero => inf of same sign; raise divide-by-zero
        setFlags->f.Z = 1;
        return FP16_INFINITY(sign);

    } else if(exp==0) {

        // normalize the subnormal
        while((sig & (1<<(FP16_EXP_SHIFT-1))) == 0) {
            exp--;
            sig <<= 1;
        }

        sig = (sig << 1) & ((1<<FP16_EXP_SHIFT)-1);

        if((exp != 0) && (exp != -1)) {

            // overflow to inf or max value of same sign, depending on sign and
            // rounding mode
            setFlags->f.P = 1;
            setFlags->f.O = 1;

            if(FRECE7OverflowToMax(riscv, sign)) {
                return FP16_MAX(sign);
            } else {
                return FP16_INFINITY(sign);
            }
        }
    }

    #define P 7                 // precision of approximation
    #define S FP16_EXP_SHIFT    // significand bits
    #define E (16-S-1)          // exponent bits
    #define B ((1<<(E-1))-1)    // exponent bias

    Int16 out_exp = 2 * B + ~exp;
    Uns16 out_sig = recip_lut[RECIP_LUT_INDEX(sig, S, P)] << (S-P);

    if((out_exp == 0) || (out_exp == -1)) {

        // the result is subnormal, but don't raise the underflow exception,
        // because there's no additional loss of precision.
        out_sig = (out_sig >> 1) | (1 << (S-1));
        if(out_exp == -1) {
            out_sig >>= 1;
            out_exp = 0;
        }
    }

    return ((Uns16)sign << (E+S)) | (out_exp << S) | out_sig;

    #undef P
    #undef S
    #undef E
    #undef B
}

//
// 32-bit FRECE7 result handler
//
static VMI_FP_32_RESULT_FN(doFRecE7_32) {

    riscvP riscv = (riscvP)processor;
    Bool   sign  = args[0].f32Parts.sign;
    Int32  exp   = args[0].f32Parts.exponent;
    Uns32  sig   = args[0].f32Parts.fraction;

    if(isInf32(args[0].u32)) {

        // inf => zero of same sign
        return FP32_ZERO(sign);

    } else if(isSNaN32(args[0].u32)) {

        // raise invalid on sNaN
        setFlags->f.I = 1;
        return FP32_DEFAULT_QNAN;

    } else if(isNaN32(args[0].u32)) {

        // NaN => canonical NaN
        return FP32_DEFAULT_QNAN;

    } else if(isZero32(args[0].u32)) {

        // zero => inf of same sign; raise divide-by-zero
        setFlags->f.Z = 1;
        return FP32_INFINITY(sign);

    } else if(exp==0) {

        // normalize the subnormal
        while((sig & (1<<(FP32_EXP_SHIFT-1))) == 0) {
            exp--;
            sig <<= 1;
        }

        sig = (sig << 1) & ((1<<FP32_EXP_SHIFT)-1);

        if((exp != 0) && (exp != -1)) {

            // overflow to inf or max value of same sign, depending on sign and
            // rounding mode
            setFlags->f.P = 1;
            setFlags->f.O = 1;

            if(FRECE7OverflowToMax(riscv, sign)) {
                return FP32_MAX(sign);
            } else {
                return FP32_INFINITY(sign);
            }
        }
    }

    #define P 7                 // precision of approximation
    #define S FP32_EXP_SHIFT    // significand bits
    #define E (32-S-1)          // exponent bits
    #define B ((1<<(E-1))-1)    // exponent bias

    Int32 out_exp = 2 * B + ~exp;
    Uns32 out_sig = recip_lut[RECIP_LUT_INDEX(sig, S, P)] << (S-P);

    if((out_exp == 0) || (out_exp == -1)) {

        // the result is subnormal, but don't raise the underflow exception,
        // because there's no additional loss of precision.
        out_sig = (out_sig >> 1) | (1 << (S-1));
        if(out_exp == -1) {
            out_sig >>= 1;
            out_exp = 0;
        }
    }

    return ((Uns32)sign << (E+S)) | (out_exp << S) | out_sig;

    #undef P
    #undef S
    #undef E
    #undef B
}

//
// 64-bit FRECE7 result handler
//
static VMI_FP_64_RESULT_FN(doFRecE7_64) {

    riscvP riscv = (riscvP)processor;
    Bool   sign  = args[0].f64Parts.sign;
    Int32  exp   = args[0].f64Parts.exponent;
    Uns64  sig   = args[0].f64Parts.fraction;

    if(isInf64(args[0].u64)) {

        // inf => zero of same sign
        return FP64_ZERO(sign);

    } else if(isSNaN64(args[0].u64)) {

        // raise invalid on sNaN
        setFlags->f.I = 1;
        return FP64_DEFAULT_QNAN;

    } else if(isNaN64(args[0].u64)) {

        // NaN => canonical NaN
        return FP64_DEFAULT_QNAN;

    } else if(isZero64(args[0].u64)) {

        // zero => inf of same sign; raise divide-by-zero
        setFlags->f.Z = 1;
        return FP64_INFINITY(sign);

    } else if(exp==0) {

        // normalize the subnormal
        while((sig & (1ULL<<(FP64_EXP_SHIFT-1))) == 0) {
            exp--;
            sig <<= 1;
        }

        sig = (sig << 1) & ((1ULL<<FP64_EXP_SHIFT)-1);

        if((exp != 0) && (exp != -1)) {

            // overflow to inf or max value of same sign, depending on sign and
            // rounding mode
            setFlags->f.P = 1;
            setFlags->f.O = 1;

            if(FRECE7OverflowToMax(riscv, sign)) {
                return FP64_MAX(sign);
            } else {
                return FP64_INFINITY(sign);
            }
        }
    }

    #define P 7                 // precision of approximation
    #define S FP64_EXP_SHIFT    // significand bits
    #define E (64-S-1)          // exponent bits
    #define B ((1<<(E-1))-1)    // exponent bias

    Int64 out_exp = 2 * B + ~exp;
    Uns64 out_sig = ((Uns64)recip_lut[RECIP_LUT_INDEX(sig, S, P)]) << (S-P);

    if((out_exp == 0) || (out_exp == -1)) {

        // the result is subnormal, but don't raise the underflow exception,
        // because there's no additional loss of precision.
        out_sig = (out_sig >> 1) | (1ULL << (S-1));
        if(out_exp == -1) {
            out_sig >>= 1;
            out_exp = 0;
        }
    }

    return ((Uns64)sign << (E+S)) | (out_exp << S) | out_sig;

    #undef P
    #undef S
    #undef E
    #undef B
}


////////////////////////////////////////////////////////////////////////////////
// RECIPROCAL SQUARE-ROOT ESTIMATE RESULT HANDLERS
////////////////////////////////////////////////////////////////////////////////

//
// Get index into reciprocal square-root estimate LUT
//
#define RSQRT_LUT_INDEX(_SIG, _EXP, _S, _P) \
    (((_SIG) >> (_S-_P+1)) | ((_EXP & 1) << (_P-1)))

//
// Reciprocal square-root estimate LUT
//
static const Uns8 rsqrt_lut[] = {
     52,  51,  50,  48,  47,  46,  44,  43,
     42,  41,  40,  39,  38,  36,  35,  34,
     33,  32,  31,  30,  30,  29,  28,  27,
     26,  25,  24,  23,  23,  22,  21,  20,
     19,  19,  18,  17,  16,  16,  15,  14,
     14,  13,  12,  12,  11,  10,  10,   9,
      9,   8,   7,   7,   6,   6,   5,   4,
      4,   3,   3,   2,   2,   1,   1,   0,
    127, 125, 123, 121, 119, 118, 116, 114,
    113, 111, 109, 108, 106, 105, 103, 102,
    100,  99,  97,  96,  95,  93,  92,  91,
     90,  88,  87,  86,  85,  84,  83,  82,
     80,  79,  78,  77,  76,  75,  74,  73,
     72,  71,  70,  70,  69,  68,  67,  66,
     65,  64,  63,  63,  62,  61,  60,  59,
     59,  58,  57,  56,  56,  55,  54,  53,
};

//
// 16-bit FRSQRTE7 result handler
//
static VMI_FP_16_RESULT_FN(doFRsqrtE7_16) {

    Bool  sign = args[0].f16Parts.sign;
    Uns16 exp  = args[0].f16Parts.exponent;
    Uns16 sig  = args[0].f16Parts.fraction;

    if(!sign && isInf16(args[0].u16)) {

        // inf => zero of same sign
        return FP16_ZERO(sign);

    } else if(isSNaN16(args[0].u16)) {

        // raise invalid on sNaN
        setFlags->f.I = 1;
        return FP16_DEFAULT_QNAN;

    } else if(isNaN16(args[0].u16)) {

        // NaN => canonical NaN
        return FP16_DEFAULT_QNAN;

    } else if(isZero16(args[0].u16)) {

        // zero => inf of same sign; raise divide-by-zero
        setFlags->f.Z = 1;
        return FP16_INFINITY(sign);

    } else if(sign) {

        // nonzero negative => NaN; raise invalid
        setFlags->f.I = 1;
        return FP16_DEFAULT_QNAN;

    } else if(exp == 0) {

        // normalize the subnormal
        while((sig & (1<<(FP16_EXP_SHIFT-1))) == 0) {
            exp--;
            sig <<= 1;
        }

        sig = (sig << 1) & ((1<<FP16_EXP_SHIFT)-1);
    }

    #define P 7                 // precision of approximation
    #define S FP16_EXP_SHIFT    // significand bits
    #define E (16-S-1)          // exponent bits
    #define B ((1<<(E-1))-1)    // exponent bias

    Uns16 out_sig = rsqrt_lut[RSQRT_LUT_INDEX(sig, exp, S, P)] << (S-P);
    Uns16 out_exp = (3 * B + ~exp) / 2;

    return (out_exp << S) | out_sig;

    #undef P
    #undef S
    #undef E
    #undef B
}

//
// 32-bit FRSQRTE7 result handler
//
static VMI_FP_32_RESULT_FN(doFRsqrtE7_32) {

    Bool  sign = args[0].f32Parts.sign;
    Uns32 exp  = args[0].f32Parts.exponent;
    Uns32 sig  = args[0].f32Parts.fraction;

    if(!sign && isInf32(args[0].u32)) {

        // inf => zero of same sign
        return FP32_ZERO(sign);

    } else if(isSNaN32(args[0].u32)) {

        // raise invalid on sNaN
        setFlags->f.I = 1;
        return FP32_DEFAULT_QNAN;

    } else if(isNaN32(args[0].u32)) {

        // NaN => canonical NaN
        return FP32_DEFAULT_QNAN;

    } else if(isZero32(args[0].u32)) {

        // zero => inf of same sign; raise divide-by-zero
        setFlags->f.Z = 1;
        return FP32_INFINITY(sign);

    } else if(sign) {

        // nonzero negative => NaN; raise invalid
        setFlags->f.I = 1;
        return FP32_DEFAULT_QNAN;

    } else if(exp == 0) {

        // normalize the subnormal
        while((sig & (1<<(FP32_EXP_SHIFT-1))) == 0) {
            exp--;
            sig <<= 1;
        }

        sig = (sig << 1) & ((1<<FP32_EXP_SHIFT)-1);
    }

    #define P 7                 // precision of approximation
    #define S FP32_EXP_SHIFT    // significand bits
    #define E (32-S-1)          // exponent bits
    #define B ((1<<(E-1))-1)    // exponent bias

    Uns32 out_sig = rsqrt_lut[RSQRT_LUT_INDEX(sig, exp, S, P)] << (S-P);
    Uns32 out_exp = (3 * B + ~exp) / 2;

    return (out_exp << S) | out_sig;

    #undef P
    #undef S
    #undef E
    #undef B
}

//
// 64-bit FRSQRTE7 result handler
//
static VMI_FP_64_RESULT_FN(doFRsqrtE7_64) {

    Bool  sign = args[0].f64Parts.sign;
    Uns64 exp  = args[0].f64Parts.exponent;
    Uns64 sig  = args[0].f64Parts.fraction;

    if(!sign && isInf64(args[0].u64)) {

        // inf => zero of same sign
        return FP64_ZERO(sign);

    } else if(isSNaN64(args[0].u64)) {

        // raise invalid on sNaN
        setFlags->f.I = 1;
        return FP64_DEFAULT_QNAN;

    } else if(isNaN64(args[0].u64)) {

        // NaN => canonical NaN
        return FP64_DEFAULT_QNAN;

    } else if(isZero64(args[0].u64)) {

        // zero => inf of same sign; raise divide-by-zero
        setFlags->f.Z = 1;
        return FP64_INFINITY(sign);

    } else if(sign) {

        // nonzero negative => NaN; raise invalid
        setFlags->f.I = 1;
        return FP64_DEFAULT_QNAN;

    } else if(exp == 0) {

        // normalize the subnormal
        while((sig & (1ULL<<(FP64_EXP_SHIFT-1))) == 0) {
            exp--;
            sig <<= 1;
        }

        sig = (sig << 1) & ((1ULL<<FP64_EXP_SHIFT)-1);
    }

    #define P 7                 // precision of approximation
    #define S FP64_EXP_SHIFT    // significand bits
    #define E (64-S-1)          // exponent bits
    #define B ((1<<(E-1))-1)    // exponent bias

    Uns64 out_sig = ((Uns64)rsqrt_lut[RSQRT_LUT_INDEX(sig, exp, S, P)]) << (S-P);
    Uns64 out_exp = (3 * B + ~exp) / 2;

    return (out_exp << S) | out_sig;

    #undef P
    #undef S
    #undef E
    #undef B
}


////////////////////////////////////////////////////////////////////////////////
// FLOATING POINT CONFIGURATION AND CONTROL
////////////////////////////////////////////////////////////////////////////////

//
// Define one vmiFPConfig
//
#define FPU_CONFIG(_QH16, _QH32, _QH64, _R16, _R32, _R64) { \
    .QNaN16                  = FP16_DEFAULT_QNAN,       \
    .QNaN32                  = FP32_DEFAULT_QNAN,       \
    .QNaN64                  = FP64_DEFAULT_QNAN,       \
    .QNaN16ResultCB          = _QH16,                   \
    .QNaN32ResultCB          = _QH32,                   \
    .QNaN64ResultCB          = _QH64,                   \
    .indeterminate8ResultCB  = handleIndeterminate8,    \
    .indeterminate16ResultCB = handleIndeterminate16,   \
    .indeterminate32ResultCB = handleIndeterminate32,   \
    .indeterminate64ResultCB = handleIndeterminate64,   \
    .fp16ResultCB            = _R16,                    \
    .fp32ResultCB            = _R32,                    \
    .fp64ResultCB            = _R64,                    \
    .suppressFlags           = {f:{D:1}},               \
    .stickyFlags             = True                     \
}

//
// Table of floating point operation configurations
//
const static vmiFPConfig fpConfigs[RVFP_LAST] = {

    // normal native operation configuration
    [RVFP_NORMAL]   = FPU_CONFIG(handleQNaN16, handleQNaN32, handleQNaN64, 0, 0, 0),

    // FMIN/FMAX configurations
    [RVFP_FMIN]     = FPU_CONFIG(0, 0, 0, doFMin16_2_2, doFMin32_2_2, doFMin64_2_2),
    [RVFP_FMAX]     = FPU_CONFIG(0, 0, 0, doFMax16_2_2, doFMax32_2_2, doFMax64_2_2),
    [RVFP_FMIN_2_3] = FPU_CONFIG(0, 0, 0, doFMin16_2_3, doFMin32_2_3, doFMin64_2_3),
    [RVFP_FMAX_2_3] = FPU_CONFIG(0, 0, 0, doFMax16_2_3, doFMax32_2_3, doFMax64_2_3),

    // estimation configurations
    [RVFP_FRECE7]   = FPU_CONFIG(0, 0, 0, doFRecE7_16,   doFRecE7_32,   doFRecE7_64  ),
    [RVFP_FRSRE7]   = FPU_CONFIG(0, 0, 0, doFRsqrtE7_16, doFRsqrtE7_32, doFRsqrtE7_64),
};

//
// Configure FPU
//
void riscvConfigureFPU(riscvP riscv) {
    vmirtConfigureFPU((vmiProcessorP)riscv, &fpConfigs[RVFP_NORMAL]);
}

//
// Return rounding control for riscvRMDesc
//
inline static vmiFPRC mapRMDescToRC(riscvRMDesc rm) {

    static const vmiFPRC map[] = {
        [RV_RM_CURRENT] = vmi_FPR_CURRENT,
        [RV_RM_RNE]     = vmi_FPR_NEAREST,
        [RV_RM_RTZ]     = vmi_FPR_ZERO,
        [RV_RM_RDN]     = vmi_FPR_NEG_INF,
        [RV_RM_RUP]     = vmi_FPR_POS_INF,
        [RV_RM_RMM]     = vmi_FPR_AWAY,
        [RV_RM_ROD]     = vmi_FPR_ODD,
        [RV_RM_BAD5]    = vmi_FPR_CURRENT,
        [RV_RM_BAD6]    = vmi_FPR_CURRENT
    };

    return map[rm];
}

//
// Is BFLOAT16 16-bit floating point format enabled?
//
inline static Bool enableBFLOAT16(riscvP riscv) {
	return riscv->configInfo.fp16_version==RVFP16_BFLOAT16;
}


////////////////////////////////////////////////////////////////////////////////
// FLOATING POINT INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Return VMI register for floating point status flags when written (NOTE:
// mstatus.FS might need to be updated as well)
//
vmiReg riscvGetFPFlagsMT(riscvP riscv) {

    // indicate that this instruction may update mstatus
    mayUpdateMStatusFS(riscv);

    // set mstatus.FS if required
    if(writeAnyFS(riscv)) {
        updateFS(riscv);
    }

    if(!perInstructionFFlags(riscv)) {

        // update sticky flags
        return RISCV_FP_FLAGS;

    } else {

        // indicate per-instruction floating point flags are written
        vmimtRegWriteImpl("fflags_i");
        riscv->blockState->updateFFlags = True;

        // update per-instruction flags
        return RISCV_FP_FLAGS_I;
    }
}

//
// Validate the given rounding mode is legal and emit an Illegal Instruction
// exception call if not
//
Bool riscvEmitCheckLegalRM(riscvP riscv, riscvRMDesc rm) {

    Bool validRM = True;

    if(rm >= RV_RM_BAD5) {

        // static check for illegal mode
        validRM = False;

    } else if(rm == RV_RM_CURRENT) {

        // insert dynamic rounding mode check if required
        if(riscv->rmCheckValid) {
            validateBlockMask(ISA_RM_INVALID);
        }

        // dynamic check for illegal mode
        validRM = !(riscv->currentArch & ISA_RM_INVALID);
    }

    // illegal instruction if invalid rounding mode
    if(!validRM) {
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IRM", "Illegal rounding mode");
    }

    return validRM;
}

//
// Update current rounding mode if required
//
static Bool emitSetOperationRM(riscvMorphStateP state) {

    Bool        validRM = True;
    riscvRMDesc rm      = state->info.rm;

    if(rm!=RV_RM_NONE) {

        validRM = riscvEmitCheckLegalRM(state->riscv, rm);

        if(validRM) {
            vmimtFSetRounding(mapRMDescToRC(rm));
        }
    }

    return validRM;
}

//
// Return floating point control to use for the current instruction
//
static vmiFPConfigCP getFPControl(riscvMorphStateP state) {

    riscvFPCtrl   ctrl   = state->attrs->fpConfig;
    vmiFPConfigCP result = 0;

    // fmin/fmax result handling changes from version 2.3
    if(ctrl && (RISCV_USER_VERSION(state->riscv) > RVUV_2_2)) {
        if(ctrl==RVFP_FMIN) {
            ctrl = RVFP_FMIN_2_3;
        } else if(ctrl==RVFP_FMAX) {
            ctrl = RVFP_FMAX_2_3;
        }
    }

    // return selected control
    if(ctrl) {
        result = &fpConfigs[ctrl];
    }

    return result;
}

//
// Return floating point operation flags for the given unary operation type
// (unless it is non-signalling, in which case no flags are set)
//
static vmiReg getFPFlagsUnopMT(riscvMorphStateP state, vmiFUnop op) {

    vmiReg flags = VMI_NOREG;

    if((op!=vmi_FQABS) && (op!=vmi_FQNEG)) {
        flags = riscvGetFPFlagsMT(state->riscv);
    }

    return flags;
}

//
// Move floating point value (two registers)
//
static RISCV_MORPH_FN(emitFMoveRR) {

    unpackedReg fd   = unpackFD(state, 0);
    unpackedReg fs1  = unpackFS(state, 1);
    Uns32       bits = fd.bits;

    vmimtMoveRR(bits, fd.r, fs1.r);

    writeUnpacked(fd);
}

//
// Implement floating point unop
//
static RISCV_MORPH_FN(emitFUnop) {

    unpackedReg   fd   = unpackFD(state, 0);
    unpackedReg   fs1  = unpackFS(state, 1);
    vmiFType      type = fd.ftype;
    vmiFUnop      op   = state->attrs->fpUnop;
    vmiFPConfigCP ctrl = getFPControl(state);

    if(emitSetOperationRM(state)) {
        vmiReg flags = getFPFlagsUnopMT(state, op);
        vmimtFUnopRR(type, op, fd.r, fs1.r, flags, ctrl);
        writeUnpacked(fd);
    }
}

//
// Implement floating point binop
//
static RISCV_MORPH_FN(emitFBinop) {

    unpackedReg   fd   = unpackFD(state, 0);
    unpackedReg   fs1  = unpackFS(state, 1);
    unpackedReg   fs2  = unpackFS(state, 2);
    vmiFType      type = fd.ftype;
    vmiFBinop     op   = state->attrs->fpBinop;
    vmiFPConfigCP ctrl = getFPControl(state);

    if(emitSetOperationRM(state)) {
        vmiReg flags = riscvGetFPFlagsMT(state->riscv);
        vmimtFBinopRRR(type, op, fd.r, fs1.r, fs2.r, flags, ctrl);
        writeUnpacked(fd);
    }
}

//
// Implement floating point ternop
//
static RISCV_MORPH_FN(emitFTernop) {

    unpackedReg   fd   = unpackFD(state, 0);
    unpackedReg   fs1  = unpackFS(state, 1);
    unpackedReg   fs2  = unpackFS(state, 2);
    unpackedReg   fs3  = unpackFS(state, 3);
    vmiFType      type = fd.ftype;
    vmiFTernop    op   = state->attrs->fpTernop;
    vmiFPConfigCP ctrl = getFPControl(state);

    if(emitSetOperationRM(state)) {
        vmiReg flags = riscvGetFPFlagsMT(state->riscv);
        vmimtFTernopRRRR(type, op, fd.r, fs1.r, fs2.r, fs3.r, flags, False, ctrl);
        writeUnpacked(fd);
    }
}

//
// Implement floating point conversion
//
static RISCV_MORPH_FN(emitFConvert) {

    unpackedReg   fd    = unpackFD(state, 0);
    unpackedReg   fs    = unpackFS(state, 1);
    vmiFType      typeD = fd.ftype;
    vmiFType      typeS = fs.ftype;
    vmiFPRC       rc    = mapRMDescToRC(state->info.rm);
    vmiFPConfigCP ctrl  = getFPControl(state);

    if(riscvEmitCheckLegalRM(state->riscv, state->info.rm)) {
        vmiReg flags = riscvGetFPFlagsMT(state->riscv);
        vmimtFConvertRR(typeD, fd.r, typeS, fs.r, rc, flags, ctrl);
        writeUnpacked(fd);
    }
}

//
// Implement floating point comparison, internal interface
//
static void emitFCompareInt(
    riscvMorphStateP state,
    vmiReg           rd,
    vmiReg           fs1,
    vmiReg           fs2,
    vmiFType         typeS
) {
    riscvFPRelation fpRel     = state->attrs->fpRel;
    vmiFPRelation   relation  = fpRel & ~RVFCMP_QNOK;
    Bool            allowQNaN = fpRel &  RVFCMP_QNOK;
    vmiReg          flags     = riscvGetFPFlagsMT(state->riscv);
    vmiFlags        zf        = {f:{[vmi_ZF]=rd}, negate:vmi_FN_ZF};
    vmiFPConfigCP   ctrl      = getFPControl(state);

    // set least-significant byte of 'rd' with the required result
    vmimtFCompareRR(typeS, rd, fs1, fs2, flags, allowQNaN, ctrl);
    vmimtBinopRC(8, vmi_AND, rd, relation, &zf);
}

//
// Implement floating point comparison
//
static RISCV_MORPH_FN(emitFCompare) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg fs1   = unpackFS(state, 1);
    unpackedReg fs2   = unpackFS(state, 2);
    vmiFType    typeS = fs1.ftype;

    emitFCompareInt(state, rd.r, fs1.r, fs2.r, typeS);

    writeUnpackedSize(rd, 8);
}

//
// Implement fsgnj, fsgnjn or fsgnjx operation, internal interface
//
static void emitFSgnInt(
    riscvMorphStateP state,
    vmiReg           fd,
    vmiReg           fs1,
    vmiReg           fs2,
    Uns32            bits
) {
    Uns64  mask = (-1ULL<<(bits-1));
    vmiReg tmp  = newTmp(state);

    // mark this instruction as floating point
    vmimtInstructionClassAdd(OCL_IC_FLOAT);

    // get required section of fs1 in tmp
    if(state->attrs->clearFS1) {
        vmimtBinopRRC(bits, vmi_AND, tmp, fs1, ~mask, 0);
    } else {
        vmimtMoveRR(bits, tmp, fs1);
    }

    // get required section of fs2
    vmimtBinopRRC(bits, vmi_AND, fd, fs2, mask, 0);

    // negate fd sign if required
    if(state->attrs->negFS2) {
        vmimtBinopRC(bits, vmi_XOR, fd, mask, 0);
    }

    // merge with tmp
    vmimtBinopRR(bits, vmi_XOR, fd, tmp, 0);
}

//
// Implement fsgnj, fsgnjn or fsgnjx operation
//
static RISCV_MORPH_FN(emitFSgn) {

    unpackedReg fd   = unpackFD(state, 0);
    unpackedReg fs1  = unpackFS(state, 1);
    unpackedReg fs2  = unpackFS(state, 2);
    Uns32       bits = fd.bits;

    if(supportedFBitsMT(state->riscv, bits)) {

        emitFSgnInt(state, fd.r, fs1.r, fs2.r, bits);

        writeUnpacked(fd);
    }
}

//
// Enumeration of FClass values
//
typedef enum riscvFClassE {
    RVFC_NINF    = 1<<0,
    RVFC_NNORM   = 1<<1,
    RVFC_NDENORM = 1<<2,
    RVFC_NZERO   = 1<<3,
    RVFC_PZERO   = 1<<4,
    RVFC_PDENORM = 1<<5,
    RVFC_PNORM   = 1<<6,
    RVFC_PINF    = 1<<7,
    RVFC_SNAN    = 1<<8,
    RVFC_QNAN    = 1<<9,
} riscvFClass;

//
// Implement 16-bit FClass operation
//
static riscvFClass doFClass16(Uns16 value) {

    Bool        isSigned = (value & FP16_SIGN_MASK) && True;
    riscvFClass result;

    if(isSNaN16(value)) {
        result = RVFC_SNAN;
    } else if(isQNaN16(value)) {
        result = RVFC_QNAN;
    } else if(isInf16(value)) {
        result = isSigned ? RVFC_NINF : RVFC_PINF;
    } else if(isDenorm16(value)) {
        result = isSigned ? RVFC_NDENORM : RVFC_PDENORM;
    } else if(isZero16(value)) {
        result = isSigned ? RVFC_NZERO : RVFC_PZERO;
    } else {
        result = isSigned ? RVFC_NNORM : RVFC_PNORM;
    }

    return result;
}

//
// Implement 32-bit FClass operation
//
static riscvFClass doFClass32(Uns32 value) {

    Bool        isSigned = (value & FP32_SIGN_MASK) && True;
    riscvFClass result;

    if(isSNaN32(value)) {
        result = RVFC_SNAN;
    } else if(isQNaN32(value)) {
        result = RVFC_QNAN;
    } else if(isInf32(value)) {
        result = isSigned ? RVFC_NINF : RVFC_PINF;
    } else if(isDenorm32(value)) {
        result = isSigned ? RVFC_NDENORM : RVFC_PDENORM;
    } else if(isZero32(value)) {
        result = isSigned ? RVFC_NZERO : RVFC_PZERO;
    } else {
        result = isSigned ? RVFC_NNORM : RVFC_PNORM;
    }

    return result;
}

//
// Implement 64-bit FClass operation
//
static riscvFClass doFClass64(Uns64 value) {

    Bool        isSigned = (value & FP64_SIGN_MASK) && True;
    riscvFClass result;

    if(isSNaN64(value)) {
        result = RVFC_SNAN;
    } else if(isQNaN64(value)) {
        result = RVFC_QNAN;
    } else if(isInf64(value)) {
        result = isSigned ? RVFC_NINF : RVFC_PINF;
    } else if(isDenorm64(value)) {
        result = isSigned ? RVFC_NDENORM : RVFC_PDENORM;
    } else if(isZero64(value)) {
        result = isSigned ? RVFC_NZERO : RVFC_PZERO;
    } else {
        result = isSigned ? RVFC_NNORM : RVFC_PNORM;
    }

    return result;
}

//
// Implement BFLOAT FClass operation
//
static riscvFClass doFClassBFLOAT(Uns16 value) {
    return doFClass32(value<<16);
}

//
// Implement fclass operation, internal interface
//
static void emitFClassInt(
    riscvP riscv,
    vmiReg rd,
    vmiReg fs1,
    Uns32  bitsS,
    Uns32  bitsD
) {
    vmiCallFn cb = 0;

    // mark this instruction as floating point
    vmimtInstructionClassAdd(OCL_IC_FLOAT);

    // get function implementing fclass
    if(bitsS==32) {
        cb = (vmiCallFn)doFClass32;
    } else if(bitsS==64) {
        cb = (vmiCallFn)doFClass64;
    } else if(bitsS!=16) {
        VMI_ABORT("unimplemented bits %u", bitsS); // LCOV_EXCL_LINE
    } else if(enableBFLOAT16(riscv)) {
        cb = (vmiCallFn)doFClassBFLOAT;
    } else {
        cb = (vmiCallFn)doFClass16;
    }

    // call function
    vmimtArgReg(bitsS, fs1);
    vmimtCallResultAttrs(cb, bitsD, rd, VMCA_PURE);
}

//
// Implement fclass operation
//
static RISCV_MORPH_FN(emitFClass) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg fs1   = unpackFS(state, 1);
    Uns32       bitsD = 32;
    Uns32       bitsS = fs1.bits;

    if(supportedFBitsMT(state->riscv, bitsS)) {

        emitFClassInt(state->riscv, rd.r, fs1.r, bitsS, bitsD);

        writeUnpackedSize(rd, bitsD);
    }
}


////////////////////////////////////////////////////////////////////////////////
// CALLBACK FUNCTION EMISSION
////////////////////////////////////////////////////////////////////////////////

//
// Emit operation using 32/64 bit callback (two registers)
//
static RISCV_MORPH_FN(emit3264RR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs   = unpackRX(state, 1);
    Uns32       bits = rd.bits;
    vmiCallFn   cb   = state->attrs->opCB(state, bits);

    vmimtArgReg(bits, rs.r);
    vmimtCallResultAttrs(cb, bits, rd.r, VMCA_PURE);

    writeUnpacked(rd);
}

//
// Emit operation using 32/64 bit callback (three registers)
//
static RISCV_MORPH_FN(emit3264RRR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    Uns32       bits = rd.bits;
    vmiCallFn   cb   = state->attrs->opCB(state, bits);

    vmimtArgReg(bits, rs1.r);
    vmimtArgReg(bits, rs2.r);
    vmimtCallResultAttrs(cb, bits, rd.r, VMCA_PURE);

    writeUnpacked(rd);
}

//
// Emit operation using 32/64 bit callback (three registers, third is shift)
//
static RISCV_MORPH_FN(emit3264RRS) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    Uns32       bits = rd.bits;
    vmiCallFn   cb   = state->attrs->opCB(state, bits);

    vmimtArgReg(bits, rs1.r);
    vmimtArgReg(32,   rs2.r);
    vmimtCallResultAttrs(cb, bits, rd.r, VMCA_PURE);

    writeUnpacked(rd);
}

//
// Emit operation using 32/64 bit callback (two registers and constant)
//
static RISCV_MORPH_FN(emit3264RRC) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    Uns64       c    = state->info.c;
    Uns32       bits = rd.bits;
    vmiCallFn   cb   = state->attrs->opCB(state, bits);

    vmimtArgReg(bits, rs1.r);
    vmimtArgUns32(c);
    vmimtCallResultAttrs(cb, bits, rd.r, VMCA_PURE);

    writeUnpacked(rd);
}

//
// Emit operation using 32/64 bit callback (four registers, third is shift)
//
static RISCV_MORPH_FN(emit3264RRSR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    unpackedReg rs3  = unpackRX(state, 3);
    Uns32       bits = rd.bits;
    vmiCallFn   cb   = state->attrs->opCB(state, bits);

    vmimtArgReg(bits, rs1.r);
    vmimtArgReg(32,   rs2.r);
    vmimtArgReg(bits, rs3.r);
    vmimtCallResultAttrs(cb, bits, rd.r, VMCA_PURE);

    writeUnpacked(rd);
}

//
// Emit operation using 32/64 bit callback (three registers and constant)
//
static RISCV_MORPH_FN(emit3264RRCR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    Uns64       c    = state->info.c;
    Uns32       bits = rd.bits;
    vmiCallFn   cb   = state->attrs->opCB(state, bits);

    vmimtArgReg(bits, rs1.r);
    vmimtArgUns32(c);
    vmimtArgReg(bits, rs2.r);
    vmimtCallResultAttrs(cb, bits, rd.r, VMCA_PURE);

    writeUnpacked(rd);
}


////////////////////////////////////////////////////////////////////////////////
// M EXTENSION UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Validate that the Zmmul subset is supported if required and take an Illegal
// Instruction exception if not
//
static Bool validateMExtSubset(riscvP riscv, Bool noZmmul) {

    // detect absent subset
    if(noZmmul && riscv->configInfo.Zmmul) {
        riscvEmitIllegalInstructionPresentSubset("Zmmul");
        return False;
    }

    return True;
}


////////////////////////////////////////////////////////////////////////////////
// BIT MANIPULATION EXTENSION INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Get B-extension implementation callback
//
static RISCV_OPCB_FN(getBOpCB) {
    return riscvGetBOpCB(state->riscv, state->attrs->bExtOp.B, bits);
}

//
// Move value with extension (two registers)
//
static RISCV_MORPH_FN(emitMoveExtendRR) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs    = unpackRX(state, 1);
    Uns32       bitsS = rs.bits;
    Uns32       bitsD = rd.bits;

    vmimtMoveExtendRR(bitsD, rd.r, bitsS, rs.r, !state->info.unsExt);

    writeUnpacked(rd);
}

//
// Implement generic Binop widening half-width result (three registers)
//
static RISCV_MORPH_FN(emitBinopRRRW) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs1   = unpackRX(state, 1);
    unpackedReg rs2   = unpackRX(state, 2);
    Uns32       bitsS = rs1.bits;
    Uns32       bitsD = bitsS*2;

    vmimtBinopRRR(bitsS, state->attrs->binop, rd.r, rs1.r, rs2.r, 0);
    vmimtMoveExtendRR(bitsD, rd.r, bitsS, rd.r, !state->info.unsExt);

    writeUnpackedSize(rd, bitsD);
}

//
// Implement generic Binop widening half-width result (two registers and
// constant)
//
static RISCV_MORPH_FN(emitBinopRRCW) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs1   = unpackRX(state, 1);
    Uns64       c     = state->info.c;
    Uns32       bitsS = rs1.bits;
    Uns32       bitsD = bitsS*2;

    vmimtBinopRRC(bitsS, state->attrs->binop, rd.r, rs1.r, c, 0);
    vmimtMoveExtendRR(bitsD, rd.r, bitsS, rd.r, !state->info.unsExt);

    writeUnpackedSize(rd, bitsD);
}

//
// For binops widening a half-width operand, is rs2 widened?
//
inline static Bool clearWRRRRS2(riscvMorphStateP state) {
    return state->riscv->configInfo.bitmanip_version<=RVBV_0_93;
}

//
// Implement generic Binop widening half-width operand (three registers)
//
static RISCV_MORPH_FN(emitBinopWRRR) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs1   = unpackRX(state, 1);
    unpackedReg rs2   = unpackRX(state, 2);
    Uns32       bitsS = rs1.bits;
    Uns32       bitsD = bitsS*2;
    vmiReg      tmp   = newTmp(state);

    if(clearWRRRRS2(state)) {
        vmimtMoveExtendRR(bitsD, tmp, bitsS, rs2.r, False);
        vmimtBinopRRR(bitsD, state->attrs->binop, rd.r, rs1.r, tmp, 0);
    } else {
        vmimtMoveExtendRR(bitsD, tmp, bitsS, rs1.r, False);
        vmimtBinopRRR(bitsD, state->attrs->binop, rd.r, tmp, rs2.r, 0);
    }

    writeUnpackedSize(rd, bitsD);
}

//
// Implement generic Binop widening half-width operand (two registers and
// constant)
//
static RISCV_MORPH_FN(emitBinopWRRC) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs1   = unpackRX(state, 1);
    Uns64       c     = state->info.c;
    Uns32       bitsD = rs1.bits;
    Uns32       bitsS = bitsD/2;
    vmiReg      tmp   = newTmp(state);

    vmimtMoveExtendRR(bitsD, tmp, bitsS, rs1.r, False);
    vmimtBinopRRC(bitsD, state->attrs->binop, rd.r, tmp, c, 0);

    writeUnpackedSize(rd, bitsD);
}

//
// Implement generic Shiftop filling with ones (three registers)
//
static RISCV_MORPH_FN(emitShiftORRR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    Uns32       bits = rd.bits;
    vmiReg      tmp  = newTmp(state);

    vmimtUnopRR(bits, vmi_NOT, tmp, rs1.r, 0);
    vmimtBinopRR(bits, state->attrs->binop, tmp, rs2.r, 0);
    vmimtUnopRR(bits, vmi_NOT, rd.r, tmp, 0);

    writeUnpacked(rd);
}

//
// Implement generic Shiftop filling with ones (two registers and constant)
//
static RISCV_MORPH_FN(emitShiftORRC) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    Uns64       c    = state->info.c;
    Uns32       bits = rd.bits;
    vmiReg      tmp  = newTmp(state);

    vmimtUnopRR(bits, vmi_NOT, tmp, rs1.r, 0);
    vmimtBinopRC(bits, state->attrs->binop, tmp, c, 0);
    vmimtUnopRR(bits, vmi_NOT, rd.r, tmp, 0);

    writeUnpacked(rd);
}

//
// Implement generic set-bit operation (three registers)
//
static RISCV_MORPH_FN(emitSBitopRRR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    Uns32       bits = rd.bits;
    vmiReg      tmp  = newTmp(state);

    vmimtBinopRCR(bits, vmi_SHL, tmp, 1, rs2.r, 0);
    vmimtBinopRRR(bits, state->attrs->binop, rd.r, rs1.r, tmp, 0);

    writeUnpacked(rd);
}

//
// Implement generic set-bit operation (two registers and constant)
//
static RISCV_MORPH_FN(emitSBitopRRC) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    Uns64       c    = state->info.c;
    Uns32       bits = rd.bits;
    vmiReg      tmp  = newTmp(state);

    vmimtBinopRCC(bits, vmi_SHL, tmp, 1, c, 0);
    vmimtBinopRRR(bits, state->attrs->binop, rd.r, rs1.r, tmp, 0);

    writeUnpacked(rd);
}

//
// Implement extract-bit operation (three registers)
//
static RISCV_MORPH_FN(emitEBitopRRR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    Uns32       bits = rd.bits;

    vmimtBinopRRR(bits, vmi_SHR, rd.r, rs1.r, rs2.r, 0);
    vmimtBinopRC(bits, vmi_AND, rd.r, 1, 0);

    writeUnpacked(rd);
}

//
// Implement extract-bit operation (two registers and constant)
//
static RISCV_MORPH_FN(emitEBitopRRC) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    Uns64       c    = state->info.c;
    Uns32       bits = rd.bits;

    vmimtBinopRRC(bits, vmi_SHR, rd.r, rs1.r, c, 0);
    vmimtBinopRC(bits, vmi_AND, rd.r, 1, 0);

    writeUnpacked(rd);
}

//
// Implement pack operation (three registers)
//
static void emitPACKLU(riscvMorphStateP state, Bool upper) {

    unpackedReg rd     = unpackRX(state, 0);
    unpackedReg rs1    = unpackRX(state, 1);
    unpackedReg rs2    = unpackRX(state, 2);
    Uns32       bits   = rd.bits;
    Uns32       hbits  = bits/2;
    Uns32       hbytes = hbits/8;
    vmiReg      srcL   = VMI_REG_DELTA(rs1.r, upper*hbytes);
    vmiReg      srcH   = VMI_REG_DELTA(rs2.r, upper*hbytes);

    if(VMI_ISNOREG(srcH)) {

        vmimtMoveExtendRR(bits, rd.r, hbits, srcL, False);

    } else {

        vmiReg tmpL = newTmp(state);
        vmiReg tmpH = VMI_REG_DELTA(tmpL, hbytes);
        vmiReg dstL = rd.r;
        vmiReg dstH = VMI_REG_DELTA(dstL, hbytes);

        vmimtMoveRR(hbits, tmpL, srcL);
        vmimtMoveRR(hbits, tmpH, srcH);
        vmimtMoveRR(hbits, dstL, tmpL);
        vmimtMoveRR(hbits, dstH, tmpH);
    }

    writeUnpacked(rd);
}

//
// Implement PACK operation (three registers)
//
static RISCV_MORPH_FN(emitPACK) {
    emitPACKLU(state, False);
}

//
// Implement PACKU operation (three registers)
//
static RISCV_MORPH_FN(emitPACKU) {
    emitPACKLU(state, True);
}

//
// Implement PACKH operation (three registers)
//
static RISCV_MORPH_FN(emitPACKH) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs1   = unpackRX(state, 1);
    unpackedReg rs2   = unpackRX(state, 2);
    Uns32       bits  = rd.bits;
    vmiReg      tmpL  = newTmp(state);
    vmiReg      tmpH  = VMI_REG_DELTA(tmpL, 1);

    vmimtMoveRR(8, tmpL, rs1.r);
    vmimtMoveRR(8, tmpH, rs2.r);
    vmimtMoveExtendRR(bits, rd.r, 16, tmpL, False);

    writeUnpacked(rd);
}

//
// Implement CLMULR/CLMULH (three registers)
//
static void emitCLMULRH(riscvMorphStateP state, vmiReg rdl) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    Uns32       bits = rd.bits;

    vmimtMulopRRR(bits, state->attrs->binop, rd.r, rdl, rs1.r, rs2.r, 0);

    if(!VMI_ISNOREG(rdl)) {
        vmimtBinopRC(bits, vmi_SHL, rd.r, 1,      0);
        vmimtBinopRC(bits, vmi_SHR, rdl,  bits-1, 0);
        vmimtBinopRR(bits, vmi_OR,  rd.r, rdl,    0);
    }

    writeUnpacked(rd);
}

//
// Implement CLMULR (three registers)
//
static RISCV_MORPH_FN(emitCLMULR) {
    emitCLMULRH(state, newTmp(state));
}

//
// Implement CLMULH (three registers)
//
static RISCV_MORPH_FN(emitCLMULH) {
    emitCLMULRH(state, VMI_NOREG);
}

//
// Implement generic CRC operation using the given constant
//
static void emitCRC32Int(riscvMorphStateP state, Uns32 constant) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs    = unpackRX(state, 1);
    Uns32       bitsS = rs.bits;
    Uns32       bitsD = rd.bits;
    vmiCallFn   cb    = getBOpCB(state, bitsD);

    vmimtArgReg(bitsD, rs.r);
    vmimtArgUns32(constant);
    vmimtArgUns32(bitsS);
    vmimtCallResultAttrs(cb, bitsD, rd.r, VMCA_PURE);

    writeUnpacked(rd);
}

//
// Implement CRC32 (three registers)
//
static RISCV_MORPH_FN(emitCRC32) {
    emitCRC32Int(state, 0xEDB88320);
}

//
// Implement CRC32C (three registers)
//
static RISCV_MORPH_FN(emitCRC32C) {
    emitCRC32Int(state, 0x82F63B78);
}

//
// Implement CMIX with given register indices
//
static void emitCMIXInt(
    riscvMorphStateP state,
    Uns32            raIndex,
    Uns32            rbIndex,
    Uns32            rcIndex
) {
    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg ra   = unpackRX(state, raIndex);
    unpackedReg rb   = unpackRX(state, rbIndex);
    unpackedReg rc   = unpackRX(state, rcIndex);
    Uns32       bits = rd.bits;
    vmiReg      tmp  = newTmp(state);

    vmimtBinopRRR(bits, vmi_AND,  tmp,  ra.r, rc.r, 0);
    vmimtBinopRRR(bits, vmi_ANDN, rd.r, rb.r, rc.r, 0);
    vmimtBinopRR (bits, vmi_OR,   rd.r, tmp, 0);

    writeUnpacked(rd);
}

//
// Implement CMIX (four registers)
//
static RISCV_MORPH_FN(emitCMIX) {
    emitCMIXInt(state, 1, 3, 2);
}

//
// Implement CMOV (four registers)
//
static RISCV_MORPH_FN(emitCMOV) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    unpackedReg rs3  = unpackRX(state, 3);
    Uns32       bits = rd.bits;
    vmiReg      tmp  = newTmp(state);

    vmimtCompareRC(bits, vmi_COND_NE, rs2.r, 0, tmp);
    vmimtCondMoveRRR(bits, tmp, True, rd.r, rs1.r, rs3.r);

    writeUnpacked(rd);
}

//
// Implement SHADD (three registers)
//
static RISCV_MORPH_FN(emitSHADD) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs1   = unpackRX(state, 1);
    unpackedReg rs2   = unpackRX(state, 2);
    Uns32       bitsS = rs1.bits;
    Uns32       bitsD = getModeBits(state);
    vmiReg      tmp   = newTmp(state);

    vmimtMoveExtendRR(bitsD, tmp, bitsS, rs1.r, False);
    vmimtBinopRC(bitsD, vmi_SHL, tmp, state->info.shN, 0);
    vmimtBinopRRR(bitsD, state->attrs->binop, rd.r, tmp, rs2.r, 0);

    writeUnpackedSize(rd, bitsD);
}


////////////////////////////////////////////////////////////////////////////////
// CRYPTOGRAPHIC EXTENSION INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Get K-extension implementation callback
//
static RISCV_OPCB_FN(getKOpCB) {
    return riscvGetKOpCB(state->riscv, state->attrs->kExtOp, bits);
}


////////////////////////////////////////////////////////////////////////////////
// CODE SIZE REDUCTION INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Move value with extension (paired registers)
//
static RISCV_MORPH_FN(emitMVP) {

    unpackedReg rd1  = unpackRX(state, 0);
    unpackedReg rd2  = unpackRX(state, 1);
    unpackedReg rs1  = unpackRX(state, 2);
    unpackedReg rs2  = unpackRX(state, 3);
    Uns32       bits = rd1.bits;

    vmimtMoveRR(bits, rd1.r, rs1.r);
    vmimtMoveRR(bits, rd2.r, rs2.r);

    writeUnpacked(rd1);
    writeUnpacked(rd2);
}

//
// Do table jump target fetch (XLEN=32)
//
static Uns32 doTBLJFetch32(vmiProcessorP processor, Uns32 va) {

    memDomainP     domain = vmirtGetProcessorCodeDomain(processor);
    memEndian      endian = MEM_ENDIAN_LITTLE;
    memAccessAttrs attrs  = MEM_AA_TRUE|MEM_AA_FETCH;

    return vmirtRead4ByteDomain(domain, va, endian, attrs) & -2;
}

//
// Do table jump target fetch (XLEN=64)
//
static Uns64 doTBLJFetch64(vmiProcessorP processor, Uns64 va) {

    memDomainP     domain = vmirtGetProcessorCodeDomain(processor);
    memEndian      endian = MEM_ENDIAN_LITTLE;
    memAccessAttrs attrs  = MEM_AA_TRUE|MEM_AA_FETCH;

    return vmirtRead8ByteDomain(domain, va, endian, attrs) & -2;
}

//
// Implement table jump
//
static RISCV_MORPH_FN(emitTBLJ) {

    unpackedReg lr     = unpackRX(state, 0);
    Uns32       bits   = lr.bits;
    Uns32       bytes  = bits/8;
    Uns64       offset = (state->info.c + state->attrs->offset)*bytes;
    vmiReg      tmp    = newTmp(state);
    vmiCallFn   cb;

    // get table access function
    cb = (bits==32) ? (vmiCallFn)doTBLJFetch32 : (vmiCallFn)doTBLJFetch64;

    // calculate address of jump table entry
    vmimtBinopRRC(bits, vmi_ADD, tmp, RISCV_CPU_REG(csr.tbljalvec), offset, 0);

    // fetch target address (may cause exception)
    vmimtArgProcessor();
    vmimtArgReg(bits, tmp);
    vmimtCallResult(cb, bits, tmp);

    // emit code for indirect jump and link
    emitJALRInt(state, tmp, unpackRX(state, 0));
}

//
// Return stack adjustment allowing for memory required for registers pushed
// implicitly
//
static Int32 getStackAdjust(Int32 spimm, Int32 rNum, Uns32 rBytes) {

    Int32 result = spimm + (rNum*rBytes);
    Uns32 align  = 16;

    if(result>0) {
        result += align-1;
    }

    return result & -align;
}

//
// Emit code to validate stack alignment
//
static void emitCheckStackAlign(riscvMorphStateP state) {

    unpackedReg sp    = createRX(state, RV_REG_X_SP);
    Uns32       align = (sp.bits==32) ? 8 : 16;
    vmiLabelP   ok    = vmimtNewLabel();

    // skip mode switch unless stack is misaligned
    vmimtTestRCJumpLabel(sp.bits, vmi_COND_Z, sp.r, align-1, ok);

    // emit call to stack alignment exception routine
    ILLEGAL_INSTRUCTION_MESSAGE(state->riscv, "ISA", "Illegal stack alignment");

    // here if no stack alignment exception
    vmimtInsertLabel(ok);
}

//
// Emit code to adjust stack
//
static void emitAdjustStack(riscvMorphStateP state, Int32 adjust) {

    unpackedReg sp = createRX(state, RV_REG_X_SP);

    vmimtBinopRC(sp.bits, vmi_ADD, sp.r, adjust, 0);

    writeUnpacked(sp);
}

//
// Structure holding rlist in unpacked form
//
typedef struct unpackedRListS {
    unpackedReg r[16];  // rlist registers
    Uns32       rNum;   // rlist register count
} unpackedRList;

//
// Unpack all members of rlist in high-to-low register order
//
static unpackedRList unpackRList(riscvMorphStateP state) {

    unpackedRList result = {rNum : 0};

    // masks of registers selected by each rlist specifier
    enum riscvRListDescE {

        // both ABIs
        MASK_x_RA           = 0,
        MASK_x_RA_S0        = MASK_x_RA         + (1<<RV_REG_X_S0),
        MASK_x_RA_S0_1      = MASK_x_RA_S0      + (1<<RV_REG_X_S1),

        // UABI
        MASK_U_RA_S0_2      = MASK_x_RA_S0_1    + (1<<RV_REG_X_S2),
        MASK_U_RA_S0_3      = MASK_U_RA_S0_2    + (1<<RV_REG_X_S3),
        MASK_U_RA_S0_4      = MASK_U_RA_S0_3    + (1<<RV_REG_X_S4),
        MASK_U_RA_S0_5      = MASK_U_RA_S0_4    + (1<<RV_REG_X_S5),
        MASK_U_RA_S0_6      = MASK_U_RA_S0_5    + (1<<RV_REG_X_S6),
        MASK_U_RA_S0_7      = MASK_U_RA_S0_6    + (1<<RV_REG_X_S7),
        MASK_U_RA_S0_8      = MASK_U_RA_S0_7    + (1<<RV_REG_X_S8),
        MASK_U_RA_S0_9      = MASK_U_RA_S0_8    + (1<<RV_REG_X_S9),
        MASK_U_RA_S0_10     = MASK_U_RA_S0_9    + (1<<RV_REG_X_S10),
        MASK_U_RA_S0_11     = MASK_U_RA_S0_10   + (1<<RV_REG_X_S11),

        // EABI
        MASK_E_RA_S0_2      = MASK_x_RA_S0_1    + (1<<RV_REG_X_A4),
        MASK_E_RA_S3_S0_2   = MASK_E_RA_S0_2    + (1<<RV_REG_X_T1),
        MASK_E_RA_S3_4_S0_2 = MASK_E_RA_S3_S0_2 + (1<<RV_REG_X_T2) ,
    };

    // macro to add entry in table below
    #define RLIST_MASK_ENTRY(_N) [RV_RL_##_N] = MASK_##_N

    // table mapping from rlist specifier to register mask
    static const Uns32 map[] = {

        // both ABIs
        RLIST_MASK_ENTRY(x_RA),             // {ra}
        RLIST_MASK_ENTRY(x_RA_S0),          // {ra,s0}
        RLIST_MASK_ENTRY(x_RA_S0_1),        // {ra,s0-s1}

        // UABI
        RLIST_MASK_ENTRY(U_RA_S0_2),        // {ra,s0-s2}
        RLIST_MASK_ENTRY(U_RA_S0_3),        // {ra,s0-s3}
        RLIST_MASK_ENTRY(U_RA_S0_4),        // {ra,s0-s4}
        RLIST_MASK_ENTRY(U_RA_S0_5),        // {ra,s0-s5}
        RLIST_MASK_ENTRY(U_RA_S0_6),        // {ra,s0-s6}
        RLIST_MASK_ENTRY(U_RA_S0_7),        // {ra,s0-s7}
        RLIST_MASK_ENTRY(U_RA_S0_8),        // {ra,s0-s8}
        RLIST_MASK_ENTRY(U_RA_S0_9),        // {ra,s0-s9}
        RLIST_MASK_ENTRY(U_RA_S0_10),       // {ra,s0-s10}
        RLIST_MASK_ENTRY(U_RA_S0_11),       // {ra,s0-s11}

        // EABI
        RLIST_MASK_ENTRY(E_RA_S0_2),        // {ra,s0-s2}
        RLIST_MASK_ENTRY(E_RA_S3_S0_2),     // {ra,s3,s0-s2}
        RLIST_MASK_ENTRY(E_RA_S3_4_S0_2),   // {ra,s3-s4,s0-s2}
    };

    // first entry is always ra
    result.r[result.rNum++] = createRX(state, RV_REG_X_RA);

    // get mask of affected registers
    Uns32 mask = map[state->info.rlist];
    rvReg i;

    // add affected registers in highest-to-lowest index order
    for(i=31; i>0; i--) {
        if(mask & (1<<i)) {
            result.r[result.rNum++] = createRX(state, i);
        }
    }

    return result;
}

//
// Implement push
//
static RISCV_MORPH_FN(emitPUSH) {

    unpackedReg   sp     = createRX(state, RV_REG_X_SP);
    unpackedRList rlist  = unpackRList(state);
    Uns32         bits   = sp.bits;
    Uns32         bytes  = bits/8;
    Int32         adjust = getStackAdjust(state->info.c, -rlist.rNum, bytes);
    Int32         offset = 0;
    Uns32         i;

    // validate stack alignment
    emitCheckStackAlign(state);

    // push registers in high-to-low order
    for(i=0; i<rlist.rNum; i++) {

        unpackedReg rs = rlist.r[i];

        offset -= bytes;

        emitStoreCommonMBO(
            state, rs.r, sp.r, bits, offset, MEM_CONSTRAINT_NONE
        );
    }

    // do moves from alist
    for(i=0; i<state->info.alist; i++) {

        Bool ABIE = (state->info.rlist>=RV_RL_E_RA_S0_2);

        static rvReg map[2][4] = {
            // UABI target registers
            {RV_REG_X_S0, RV_REG_X_S1, RV_REG_X_S2, RV_REG_X_S3},
            // EABI target registers
            {RV_REG_X_S0, RV_REG_X_S1, RV_REG_X_A4, RV_REG_X_T1},
        };

        unpackedReg ra = createRX(state, RV_REG_X_A0+i);
        unpackedReg rd = createRX(state, map[ABIE][i]);

        vmimtMoveRR(rd.bits, rd.r, ra.r);

        writeUnpacked(rd);
    }

    // update stack
    emitAdjustStack(state, adjust);
}

//
// Implement pop
//
static RISCV_MORPH_FN(emitPOP) {

    unpackedReg     sp     = createRX(state, RV_REG_X_SP);
    unpackedRList   rlist  = unpackRList(state);
    Uns32           bits   = sp.bits;
    Uns32           bytes  = bits/8;
    Int32           adjust = getStackAdjust(state->info.c, rlist.rNum, bytes);
    Int32           offset = adjust;
    riscvRetValDesc retval = state->info.retval;
    Uns32           i;

    // validate stack alignment
    emitCheckStackAlign(state);

    // pop registers in high-to-low order
    for(i=0; i<rlist.rNum; i++) {

        unpackedReg rd = rlist.r[i];

        offset -= bytes;

        emitLoadCommonMBO(
            state, rd.r, bits, sp.r, bits, offset, MEM_CONSTRAINT_NONE
        );

        writeUnpacked(rd);
    }

    // handle return value
    if(retval) {

        unpackedReg a0  = createRX(state, RV_REG_X_A0);
        Int32       val = (retval==RV_RV_0) ? 0 : (retval==RV_RV_P1) ? 1 : -1;

        vmimtMoveRC(a0.bits, a0.r, val);

        writeUnpacked(a0);
    }

    // update stack
    emitAdjustStack(state, adjust);

    // do return if required
    if(state->info.doRet) {

        unpackedReg ra   = createRX(state, RV_REG_X_RA);
        unpackedReg zero = createRX(state, RV_REG_X_ZERO);

        emitJALRInt(state, ra.r, zero);
    }
}

//
// Implement decbnez
//
static RISCV_MORPH_FN(emitDECBNEZ) {

    unpackedReg rd   = unpackRX(state, 0);
    Uns32       bits = rd.bits;
    Uns64       tgt  = state->info.tgt;
    vmiReg      tmp  = newTmp(state);
    vmiFlags    zf   = {f:{[vmi_ZF]=tmp}};

    // decrement the counter register
    vmimtBinopRC(bits, vmi_SUB, rd.r, state->info.c, &zf);
    writeUnpacked(rd);

    // jump if counter is non-zero
    vmimtCondJump(tmp, False, 0, tgt, VMI_NOREG, vmi_JH_RELATIVE);
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR UNIT CONFIGURATION
////////////////////////////////////////////////////////////////////////////////

//
// Configure vector extension
//
void riscvConfigureVector(riscvP riscv) {

    Uns32 vRegBytes = riscv->configInfo.VLEN/8;

    // allocate vector registers if required
    if(vectorPresent(riscv)) {
        riscv->v = STYPE_CALLOC_N(Uns32, (vRegBytes/4)*VREG_NUM);
    }
}

//
// Free vector extension data structures
//
void riscvFreeVector(riscvP riscv) {

    // free vector registers if required
    if(riscv->v) {
    	STYPE_FREE(riscv->v);
    }
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR OPERATION DISPATCH
////////////////////////////////////////////////////////////////////////////////

//
// This indicates the type of a vector register
//
typedef enum vrTypeE {
    VRT_NONE,                           // no register
    VRT_XF,                             // X or F register
    VRT_MASK,                           // mask register
    VRT_SCALAR,                         // scalar register
    VRT_VECTOR,                         // vector register
} vrType;

//
// This type holds information about a single vector register
//
typedef struct vrDescS {
    vrType         type;                // register type
    riscvVLMULx8Mt EMULx8;              // effective EMULx8
    riscvSEWMt     EEW;                 // effective EEW
    Uns32          EMUL;                // effective VLMUL (1 if fractional)
    Bool           forceEEW;            // force EEW for this operand
} vrDesc, *vrDescP;

//
// This type describes a base register of a given size
//
typedef struct baseDescS {
    vmiReg         reg;                 // base register
    vmiReg         index;               // index register
    riscvVLMULx8Mt EMULx8;              // effective EMULx8
    Uns32          EBITS;               // element size in bits
    Bool           striped;             // whether a striped base
} baseDesc, *baseDescP;

//
// Context for generic vector operation
//
typedef struct iterDescS {
    riscvVLMULx8Mt VLMULx8;             // effective VLMULx8
    riscvSEWMt     SEW;                 // effective SEW
    Uns32          MLEN;                // effective MLEN
    Uns32          SLEN;                // effective SLEN
    Uns32          VLEN;                // effective VLEN
    Uns32          nf;                  // effective number of fields
    Uns32          vregs;               // number of regiser affected
    riscvRegDesc   PdA;                 // predicate abstract target register
    vmiReg         mask;                // mask register
    vmiReg         rdNarrow;            // narrow destination register
    vrDesc         vr[RV_MAX_AREGS];    // vector register descriptions
    vmiReg         r[RV_MAX_AREGS];     // argument registers
    baseDesc       base[NUM_BASE_REGS]; // base registers
    vmiLabelP      maskF;               // target if mask=0
    vmiLabelP      skip;                // target if body is skipped
} iterDesc;

//
// Convert multiple to shift left amount, returning -1 if not a power of two
//
static Int32 mulToShiftLeft(Uns32 mul) {

    Uns32 result = 0;

    while(mul && !(mul&1)) {
        mul >>= 1;
        result++;
    }

    return (mul==1) ? result : -1;
}

//
// Convert power-of-two multiple to shift amount
//
static Uns32 mulToShiftP2(Uns32 mul) {

    Uns32 result = mulToShiftLeft(mul);

    VMI_ASSERT(result!=-1, "multiple not power of 2");

    return result;
}

//
// Return amount by which an offset register should be shifted to index a base
// register addressing a mask register
//
static Uns32 getMaskBaseShift(iterDescP id) {

    Uns32 shift = mulToShiftP2(id->MLEN);

    VMI_ASSERT(shift<=2, "unexpected MLEN=%u", id->MLEN);

    return 3-shift;
}

//
// Given source index of size allBits, create result in which subfield of size
// loBits+hiBits at offset fieldLSB is rotated right by loBits
//
static vmiReg rotateSubfield(
    riscvMorphStateP state,
    vmiReg           offset,
    vmiReg           index,
    Uns32            allBits,
    Uns32            fieldLSB,
    Uns32            loBits,
    Uns32            hiBits
) {
    if(!loBits || !hiBits) {

        // no rotation - use given index as offset
        offset = index;

    } else {

        // rotation required
        Uns32  loMask  = ((1<<loBits)-1) << fieldLSB;
        Uns32  hiMask   = ((1<<hiBits)-1) << (fieldLSB+loBits);
        Bool   preserve = (allBits!=(loBits+hiBits));
        vmiReg loTmp    = newTmp(state);
        vmiReg hiTmp    = preserve ? VMI_REG_DELTA(loTmp, 4) : offset;

        // copy index to offset
        vmimtMoveRR(32, offset, index);

        // extract lo field from offset to temporary
        vmimtBinopRRC(32, vmi_AND, loTmp, offset, loMask, 0);

        // extract hi field and preserve other bits in offset if required
        if(preserve) {
            vmimtBinopRRC(32, vmi_AND, hiTmp, offset, hiMask, 0);
            vmimtBinopRR(32, vmi_XOR, offset, loTmp, 0);
            vmimtBinopRR(32, vmi_XOR, offset, hiTmp, 0);
        }

        // rotate temporaries
        vmimtBinopRC(32, vmi_SHL, loTmp, hiBits, 0);
        vmimtBinopRC(32, vmi_SHR, hiTmp, loBits, 0);

        // insert lo field into result
        vmimtBinopRR(32, vmi_OR, offset, loTmp, 0);

        // insert hi field into result if required
        if(preserve) {
            vmimtBinopRR(32, vmi_OR, offset, hiTmp, 0);
        }

        // extend result to pointer size
        vmimtMoveExtendRR(IMPERAS_POINTER_BITS, offset, 32, offset, False);

        // free 32-bit temporary
        freeTmp(state);
    }

    return offset;
}

//
// Return vmiReg structure holding the rotate amount for field mask alignment
//
static vmiReg fillFieldMaskRotate(
    riscvMorphStateP state,
    iterDescP        id,
    vmiReg           count,
    vmiReg           tRotate
) {
    vmiReg result    = count;
    Uns32  shiftMLEN = mulToShiftP2(id->MLEN);
    Uns32  shiftSLEN = mulToShiftP2(id->VLEN/id->SLEN);

    // mask bits are striped when fractional LMUL is implemented
    if(shiftSLEN && vectorFractLMUL(state->riscv)) {
        vmimtBinopRRC(32, vmi_SHR, tRotate, result, shiftSLEN, 0);
        result = tRotate;
    }

    // multiply by MLEN
    if(shiftMLEN) {
        vmimtBinopRRC(8, vmi_SHL, tRotate, result, shiftMLEN, 0);
        result = tRotate;
    }

    return result;
}

//
// Fill predicate mask given rotation
//
static void fillPredMask(iterDescP id, vmiReg rotate) {

    Uns8   c    = ~((1<<id->MLEN)-1);
    vmiReg mask = RISCV_VPRED_MASK;

    vmimtBinopRCR(8, vmi_ROL, mask, c, rotate, 0);
}

//
// Fill active mask given rotation
//
static void fillActiveMask(iterDescP id, vmiReg rotate) {

    Uns8   c    = 1;
    vmiReg mask = RISCV_VACTIVE_MASK;

    vmimtBinopRCR(8, vmi_ROL, mask, c, rotate, 0);
}

//
// Prepare byte-sized predicate and active masks if required
//
static void prepareMasks(
    riscvMorphStateP state,
    iterDescP        id,
    vmiReg           t,
    Bool             needPredMask,
    Bool             needActiveMask
) {
    if((id->MLEN<8) && (needPredMask || needActiveMask)) {

        vmiReg vstart = CSR_REG_MT(vstart);
        vmiReg rotate = fillFieldMaskRotate(state, id, vstart, t);

        // create predicate mask (masks out a predicate field)
        if(needPredMask) {
            fillPredMask(id, rotate);
        }

        // create active mask (LSB within field set)
        if(needActiveMask) {
            fillActiveMask(id, rotate);
        }
    }
}

//
// Dispatch vector callback function
//
inline static void dispatchVector(
    riscvMorphStateP state,
    riscvMorphVFn    vectorCB,
    iterDescP        id
) {
    if(vectorCB) {
        vectorCB(state, id);
    }
}

//
// Is zeroing of tail elements required? (0.7.1 or earlier)
//
inline static Bool requireZeroTail(riscvP riscv) {
    return riscvVFSupport(riscv, RVVF_ZERO_TAIL);
}

//
// Is modification of tail elements required?
//
static Bool requireSetTail(riscvP riscv, iterDescP id) {
    return (
        requireZeroTail(riscv) ||
        inVTA1Mode(riscv) ||
        (id->PdA && riscv->configInfo.agnostic_ones)
    );
}

//
// Zero tail elements of vector if required
//
static void setTail(riscvP riscv, Uns32 bits, vmiReg vd) {
    if(requireZeroTail(riscv)) {
        vmimtMoveRC(bits, vd, 0);
    } else if(inVTA1Mode(riscv)) {
        vmimtMoveRC(bits, vd, -1);
    }
}

//
// Get an indexed register specification, removing any previous index
// information
//
static void getIndexedRegisterInt(vmiReg *r, vmiReg *base, Uns32 bytes) {

    // reset any current indexed state
    VMI_REG_IKEY(*r)   = 0;
    VMI_REG_IBYTES(*r) = 0;

    // define indexed register
    vmimtGetIndexedRegister(r, base, bytes);
}

//
// Construct index to access field of a vector register, given the number of
// registers, stripes and elements per stripe
//
static vmiReg getStripedIndex(
    riscvMorphStateP state,
    vmiReg           offset,
    vmiReg           index,
    Uns32            regNum,
    Uns32            stripeNum,
    Uns32            elemNum
) {
    // get bits required to represent register, stripe and field
    Uns32 regBits    = mulToShiftP2(regNum);
    Uns32 stripeBits = mulToShiftP2(stripeNum);
    Uns32 elemBits   = mulToShiftP2(elemNum);
    Uns32 allBits    = regBits+stripeBits+elemBits;

    if(vectorFractLMUL(state->riscv)) {

        // convert index from register-field-stripe to register-stripe-field
        offset = rotateSubfield(
            state, offset, index, allBits, 0, stripeBits, elemBits
        );

    } else {

        // convert index from stripe-register-field to register-stripe-field
        offset = rotateSubfield(
            state, offset, index, allBits, elemBits, regBits, stripeBits
        );
    }

    return offset;
}

//
// Construct index to access field of a mask register if required (only when
// fractional LMUL is implemented)
//
static vmiReg getStripedIndexM(
    riscvMorphStateP state,
    iterDescP        id,
    vmiReg           offset,
    vmiReg           index
) {
    if(vectorFractLMUL(state->riscv)) {

        // get number of registers, stripes and elements per stripe
        Uns32 regNum    = 1;
        Uns32 stripeNum = id->VLEN/id->SLEN;
        Uns32 elemNum   = id->SLEN/id->MLEN;

        // convert index to format register-stripe-field
        offset = getStripedIndex(
            state, offset, index, regNum, stripeNum, elemNum
        );

    } else {

        // use given index as offset
        offset = index;
    }

    return offset;
}

//
// Initialize base register
//
static void initializeBase(
    riscvMorphStateP state,
    iterDescP        id,
    vmiReg          *rP,
    baseDescP        base,
    Uns32            vecBytes
) {
    Uns32  offsetBits = IMPERAS_POINTER_BITS;
    vmiReg offset     = newTmp(state);
    vmiReg index      = base->index;
    Uns32  elemBytes  = base->EBITS/8;

    if(!elemBytes) {

        // sub-byte reference - handle mask register striping if required
        index = getStripedIndexM(state, id, offset, index);

        // sub-byte reference
        Uns32 baseShift = getMaskBaseShift(id);

        // calculate byte offset
        vmimtBinopRRC(offsetBits, vmi_SHR, offset, index, baseShift, 0);

        // use byte-sized offset
        elemBytes = 1;

    } else if(base->striped) {

        // striped base register - calculate effective VLMULx8 for this element
        Uns32 SLEN = id->SLEN;

        // if SEW>SLEN, the packing operates as if SLEN was increased to SEW
        if(SLEN<base->EBITS) {
            SLEN = base->EBITS;
        }

        // get number of registers, stripes and elements per stripe
        Uns32 regNum    = base->EMULx8/VLMULx8MT_1 ? : 1;
        Uns32 stripeNum = id->VLEN/SLEN;
        Uns32 elemNum   = SLEN/base->EBITS;

        // convert index to format register-stripe-field
        offset = getStripedIndex(
            state, offset, index, regNum, stripeNum, elemNum
        );

    } else {

        // use index as offset
        offset = index;
    }

    // initialize base register
    getIndexedRegisterInt(rP, &base->reg, vecBytes);
    vmimtAddBaseR(base->reg, offset, elemBytes, vecBytes, False, False);

    // free temporary offset
    freeTmp(state);
}

//
// Convert vector register to indexed register
//
static void getIndexedRegister(
    riscvMorphStateP state,
    iterDescP        id,
    vmiReg          *rP,
    vmiReg           index,
    riscvVLMULx8Mt   EMULx8,
    Uns32            EBITS,
    Uns32            vecBytes,
    Bool             striped
) {
    if(!VMI_ISNOREG(*rP)) {

        Bool      found = False;
        baseDescP base  = 0;
        Uns32     i;

        // search for an existing matching base register
        for(i=0; !found && (i<NUM_BASE_REGS); i++) {

            base = &id->base[i];

            found = (
                !base->EBITS ||
                (
                    (base->striped==striped) &&
                    (base->EMULx8==EMULx8)   &&
                    (base->EBITS==EBITS)     &&
                    VMI_REG_EQUAL(base->index, index)
                )
            );
        }

        // expect either to find a match or a free descriptor
        VMI_ASSERT(found, "too many base registers");

        if(base->EBITS) {

            // reuse a previously-initialized base
            getIndexedRegisterInt(rP, &base->reg, vecBytes);

        } else {

            // get index number of new base register
            Uns32 baseIndex = base - id->base;

            // create a new base
            base->reg     = RISCV_CPU_VBASE(baseIndex);
            base->index   = index;
            base->EMULx8  = EMULx8;
            base->EBITS   = EBITS;
            base->striped = striped;

            // initialize the base
            initializeBase(state, id, rP, base, vecBytes);
        }
    }
}

//
// Zero vstart register
//
static void setVStartZero(riscvMorphStateP state) {

    riscvBlockStateP blockState = state->riscv->blockState;

    if(!blockState->VStartZeroMt) {

        blockState->VStartZeroMt = True;

        vmimtMoveRC(32, CSR_REG_MT(vstart), 0);
    }
}

//
// This specifies parameter overlap constraints
//
typedef enum overlapTypeE {

    OT_NA   = 0x00, // no special constraints
    OT_S    = 0x01, // destination must not overlap vector source
    OT_M    = 0x02, // destination must not overlap mask source
    OT_M71  = 0x04, // destination must not overlap mask source (0.7.1 only)
    OT_VMSF = 0x08, // vmsif/vmsbf/vmsof overlap constraints
    OT_XSM  = 0x10, // destination must not overlap any source if segmented

    OT___   = OT_NA,
    OT_S_   = OT_S,
    OT__M   = OT_M,
    OT__M71 = OT_M71,
    OT_SM   = OT_S|OT_M,
    OT_SM71 = OT_S|OT_M71,

} overlapType;

//
// This structure gives information for each vector operation shape
//
typedef struct shapeInfoS {
    Bool        r0IsDst;        // is register 0 a destination?
    Uns8        argMul   [3];   // width multipliers (result, arg0, argN)
    Bool        argDiv   [3];   // divided-width operand (result, arg0, argN)
    Bool        isFloat  [3];   // are operands floating point?
    Bool        isMask   [3];   // are operands masks?
    Bool        isScalar [3];   // are operands scalar?
    Bool        unindexed[3];   // are operands unindexed?
    Bool        writesV0M;      // does operation implicitly write mask v0?
    Bool        implicitWiden;  // is widening implicit?
    Bool        isNarrowing;    // does operation narrow result?
    Bool        isSaturating;   // does operation saturate result?
    Bool        usesVXRM;       // does operation use vxrm?
    Bool        isMaskCIn;      // is apparent mask a carry-in?
    Bool        SEW8;           // use fixed SEW=8?
    Bool        noVStartCheck;  // skip vstart<vl check?
    overlapType ot;             // overlap constraints
} shapeInfo;

//
// Information for each vector operation shape
//
static const shapeInfo shapeDetails[RVVW_LAST] = {

    // INTEGER ARGUMENTS
    [RVVW_V1I_V1I_V1I]      = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1I_V1I_V1I_LD]   = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT_XSM },
    [RVVW_V1I_V1I_V1I_ST]   = {0, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1I_V1I_V1I_SAT]  = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 1, 1, 0, 0, 0, OT___  },
    [RVVW_V1I_V1I_V1I_VXRM] = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 1, 0, 0, 0, OT___  },
    [RVVW_V1I_V1I_V1I_SEW8] = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 1, 0, OT___  },
    [RVVW_V1I_S1I_V1I]      = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,1,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 1, OT___  },
    [RVVW_S1I_V1I_V1I]      = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {1,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_P1I_V1I_V1I]      = {1, {1,1,1}, {0,0,0}, {0,0,0}, {1,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_S1I_V1I_S1I]      = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {1,0,1}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1I_V1I_V1I_CIN]  = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 1, 0, 0, OT___  },
    [RVVW_P1I_V1I_V1I_CIN]  = {1, {1,1,1}, {0,0,0}, {0,0,0}, {1,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 1, 0, 0, OT___  },
    [RVVW_S2I_V1I_S2I]      = {1, {2,1,2}, {0,0,0}, {0,0,0}, {0,0,0}, {1,0,1}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1I_V2I_V1I]      = {1, {1,2,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 1, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1I_V2I_V1I_SAT]  = {1, {1,2,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 1, 1, 1, 0, 0, 0, OT___  },
    [RVVW_V2I_V1I_V1I_IW]   = {1, {2,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 1, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V2I_V1I_V1I]      = {1, {2,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V2I_V1I_V1I_SAT]  = {1, {2,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 1, 1, 0, 0, 0, OT___  },
    [RVVW_V4I_V1I_V1I]      = {1, {4,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V2I_V2I_V1I]      = {1, {2,2,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1I_V2I_FN]       = {1, {1,1,1}, {0,1,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },

    // FLOATING POINT ARGUMENTS
    [RVVW_V1F_V1F_V1F]      = {1, {1,1,1}, {0,0,0}, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1F_S1F_V1F]      = {1, {1,1,1}, {0,0,0}, {1,1,1}, {0,0,0}, {0,1,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 1, OT___  },
    [RVVW_S1F_V1I_V1I]      = {1, {1,1,1}, {0,0,0}, {1,1,1}, {0,0,0}, {1,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_P1I_V1F_V1F]      = {1, {1,1,1}, {0,0,0}, {0,1,1}, {1,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_S1F_V1F_S1F]      = {1, {1,1,1}, {0,0,0}, {1,1,1}, {0,0,0}, {1,0,1}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_S2F_V1F_S2F]      = {1, {2,1,2}, {0,0,0}, {1,1,1}, {0,0,0}, {1,0,1}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1F_V2F_V1F_IW]   = {1, {1,2,1}, {0,0,0}, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 1, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V2F_V1F_V1F_IW]   = {1, {2,1,1}, {0,0,0}, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 1, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V2F_V1F_V1F]      = {1, {2,1,1}, {0,0,0}, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V2F_V2F_V1F]      = {1, {2,2,1}, {0,0,0}, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1F_V1F_V1I_UP]   = {1, {1,1,1}, {0,0,0}, {1,1,1}, {0,0,0}, {0,0,0}, {0,1,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT_SM71},
    [RVVW_V1F_V1F_V1I_DN]   = {1, {1,1,1}, {0,0,0}, {1,1,1}, {0,0,0}, {0,0,0}, {0,1,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT__M71},

    // CONVERSIONS
    [RVVW_V1F_V1I]          = {1, {1,1,1}, {0,0,0}, {1,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1I_V1F]          = {1, {1,1,1}, {0,0,0}, {0,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V2F_V1I]          = {1, {2,1,0}, {0,0,0}, {1,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 1, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V2I_V1F]          = {1, {2,1,0}, {0,0,0}, {0,1,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 1, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1F_V2I_IW]       = {1, {1,2,0}, {0,0,0}, {1,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 1, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_V1I_V2F_IW]       = {1, {1,2,0}, {0,0,0}, {0,1,0}, {0,0,0}, {0,0,0}, {0,0,0}, 0, 1, 0, 0, 0, 0, 0, 0, OT___  },

    // MASK ARGUMENTS
    [RVVW_P1I_P1I_P1I]      = {1, {1,1,1}, {0,0,0}, {0,0,0}, {1,1,1}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT___  },
    [RVVW_P1I_P1I_P1I_VMSF] = {1, {1,1,1}, {0,0,0}, {0,0,0}, {1,1,1}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT_VMSF},
    [RVVW_V1I_P1I_P1I_IOTA] = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,1,1}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT_SM  },
    [RVVW_V1I_P1I_P1I_ID]   = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,1,1}, {0,0,0}, {0,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT_SM71},

    // SLIDING ARGUMENTS
    [RVVW_V1I_V1I_V1I_GR]   = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,1,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT_SM  },
    [RVVW_V1I_V1I_V1I_UP]   = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,1,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT_SM71},
    [RVVW_V1I_V1I_V1I_DN]   = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {0,1,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT__M71},
    [RVVW_V1I_V1I_V1I_CMP]  = {1, {1,1,1}, {0,0,0}, {0,0,0}, {0,0,0}, {0,0,0}, {1,0,0}, 0, 0, 0, 0, 0, 0, 0, 0, OT_SM  },
};

//
// Clamp argument index to maximum
//
inline static Uns32 clampArgIndex(Uns32 argIndex) {
    return (argIndex>2) ? 2 : argIndex;
}

//
// Return width multiplier for operation Nth vector argument
//
inline static Uns32 getWidthMultiplierN(riscvVShape vShape, Uns32 argIndex) {
    return shapeDetails[vShape].argMul[clampArgIndex(argIndex)];
}

//
// Return width multiplier for a vector operation
//
static Uns32 getWidthMultiplier(riscvVShape vShape) {

    Uns32 result = 0;
    Uns32 i;

    for(i=0; i<sizeof(shapeDetails[vShape].argMul); i++) {

        Uns32 mul = getWidthMultiplierN(vShape, i);

        if(result<mul) {
            result = mul;
        }
    }

    return result;
}

//
// Is the first register argument a destination?
//
inline static Bool isR0Dst(riscvVShape vShape) {
    return shapeDetails[vShape].r0IsDst;
}

//
// Does the operation Nth vector argument have divided width?
//
inline static Bool isDividedN(riscvVShape vShape, Uns32 argIndex) {
    return shapeDetails[vShape].argDiv[clampArgIndex(argIndex)];
}

//
// Is the operation Nth vector operation argument a floating point value?
//
inline static Bool isFloatN(riscvVShape vShape, Uns32 argIndex) {
    return shapeDetails[vShape].isFloat[clampArgIndex(argIndex)];
}

//
// Does this shape produce a scalar result
//
inline static Bool isScalarN(riscvVShape vShape, Uns32 argIndex) {
    return shapeDetails[vShape].isScalar[clampArgIndex(argIndex)];
}

//
// Is the explicit operation result a predicate?
//
inline static Bool isMaskN(riscvVShape vShape, Uns32 argIndex) {
    return shapeDetails[vShape].isMask[clampArgIndex(argIndex)];
}

//
// Does the vector operation implicitly write mask register V0?
//
inline static Bool isUnindexedN(riscvVShape vShape, Uns32 argIndex) {
    return shapeDetails[vShape].unindexed[clampArgIndex(argIndex)];
}

//
// Does this shape implement implicit argument widening?
//
inline static Bool isWideningImplicit(riscvVShape vShape) {
    return shapeDetails[vShape].implicitWiden;
}

//
// Does this shape implement result narrowing?
//
inline static Bool isNarrowing(riscvVShape vShape) {
    return shapeDetails[vShape].isNarrowing;
}

//
// Does this shape implement result saturation?
//
inline static Bool isSaturating(riscvVShape vShape) {
    return shapeDetails[vShape].isSaturating;
}

//
// Does this shape use vxrm?
//
inline static Bool usesVXRM(riscvVShape vShape) {
    return shapeDetails[vShape].usesVXRM;
}

//
// Is apparent mask actually a carry-in (VADC etc)
//
inline static Bool isMaskCIn(riscvVShape vShape) {
    return shapeDetails[vShape].isMaskCIn;
}

//
// Is SEW fixed to 8 for this operation?
//
inline static Bool isSEW8(riscvVShape vShape) {
    return shapeDetails[vShape].SEW8;
}

//
// Should this operation skip and vstart<vl check?
//
inline static Bool noVStartCheck(riscvVShape vShape) {
    return shapeDetails[vShape].noVStartCheck;
}

//
// Return overlap constraints for the operation
//
inline static overlapType getOverlapType(riscvVShape vShape) {
    return shapeDetails[vShape].ot;
}

//
// Return scale factor to apply to SEW for a vector operation
//
inline static Uns32 getSEWMultiplier(riscvVShape vShape) {
    return isWideningImplicit(vShape) ? 1 : getWidthMultiplier(vShape);
}

//
// Is the current SEW unequal to but forced to 8?
//
inline static Bool forceSEW8(riscvMorphStateP state, iterDescP id) {
    return isSEW8(state->attrs->vShape) && (id->SEW>8);
}

//
// Does the operation have any floating point arguments?
//
static Bool isFloat(riscvVShape vShape) {

    Bool  result = False;
    Uns32 i;

    for(i=0; i<sizeof(shapeDetails[vShape].isFloat); i++) {
        result |=  isFloatN(vShape, i);
    }

    return result;
}

//
// Get effective vector length multiplier
//
static riscvVLMULx8Mt getVLMULMt(riscvMorphStateP state) {

    riscvP           riscv      = state->riscv;
    riscvBlockStateP blockState = riscv->blockState;
    riscvVLMULx8Mt   VLMULx8    = blockState->VLMULx8Mt;

    if(VLMULx8==VLMULx8MT_UNKNOWN) {

        emitCheckPolymorphic();

        VLMULx8 = svlmulToVLMULx8(getCurrentSVLMUL(riscv));
        blockState->VLMULx8Mt = VLMULx8;
    }

    return VLMULx8;
}

//
// Get effective SEW
//
static riscvSEWMt getSEWMt(riscvMorphStateP state) {

    riscvP           riscv      = state->riscv;
    riscvBlockStateP blockState = riscv->blockState;
    riscvSEWMt       SEW        = blockState->SEWMt;

    if(SEW==SEWMT_UNKNOWN) {

        emitCheckPolymorphic();

        SEW = getCurrentSEW(riscv);
        blockState->SEWMt = SEW;
    }

    return SEW;
}

//
// Get effective zero/non-zero/max vector length
//
static riscvVLClassMt getVLClassMt(riscvMorphStateP state, iterDescP id) {

    riscvP           riscv      = state->riscv;
    riscvBlockStateP blockState = riscv->blockState;
    riscvVLClassMt   vlClass    = blockState->VLClassMt;

    if(vlClass==VLCLASSMT_UNKNOWN) {

        riscvSEWMt     SEW     = id->SEW;
        riscvVLMULx8Mt VLMULx8 = id->VLMULx8;
        Uns32          vl      = RD_CSRC(riscv, vl);
        Uns32          vlMax   = id->VLEN*VLMULx8/(SEW*8);

        emitCheckPolymorphic();

        if(!vl) {
            vlClass = VLCLASSMT_ZERO;
        } else if(vl>=vlMax) {
            vlClass = VLCLASSMT_MAX;
        } else {
            vlClass = VLCLASSMT_NONZERO;
        }

        blockState->VLClassMt = vlClass;
    }

    return vlClass;
}

//
// Get effective maximum vector length for this operation
//
inline static Uns32 getVLMAXOp(iterDescP id) {
    return id->VLEN * id->VLMULx8 / (id->SEW*8);
}

//
// Return type for operation Nth vector argument
//
inline static vrType getEType(iterDescP id, Uns32 argIndex) {
    return id->vr[argIndex].type;
}

//
// Return EEW for operation Nth vector argument
//
inline static riscvSEWMt getEEW(iterDescP id, Uns32 argIndex) {
    return id->vr[argIndex].EEW;
}

//
// Is EEW forced for operation Nth vector argument?
//
inline static Bool forceEEW(iterDescP id, Uns32 argIndex) {
    return id->vr[argIndex].forceEEW;
}

//
// Return EMUL for operation Nth vector argument
//
inline static Uns32 getEMUL(iterDescP id, Uns32 argIndex) {
    return id->vr[argIndex].EMUL;
}

//
// Return EMULx8 for operation Nth vector argument
//
inline static riscvVLMULx8Mt getEMULx8(iterDescP id, Uns32 argIndex) {
    return id->vr[argIndex].EMULx8;
}

//
// Return EMULxNF for operation Nth vector argument
//
static Uns32 getEMULxNF(riscvMorphStateP state, iterDescP id, Uns32 index) {

    Uns32          fieldNum = state->info.nf+1;
    riscvVLMULx8Mt EMULx8   = getEMULx8(id, index);
    Uns32          result   = EMULx8*fieldNum/8;

    return result ? : 1;
}

//
// Is EMULxNF valid for the indexed vector register (register numbers must not
// increment past the last-supported vector register)
//
static Bool legalEMULxNFIndex(
    riscvMorphStateP state,
    iterDescP        id,
    Uns32            index
) {
    riscvRegDesc rv      = getRVReg(state, index);
    Uns32        numRegs = getEMULxNF(state, id, index);
    Uns32        last    = getRIndex(rv)+numRegs-1;

    return last<VREG_NUM;
}

//
// Is the index in the mask?
//
inline static Bool indexInMask(Uns32 index, Uns32 mask) {
    return mask & (1<<index);
}

//
// Return floating point type for the given SEW
//
static vmiFType getSEWFType(riscvMorphStateP state, Uns32 SEW) {

    vmiFType result = 0;

    if(SEW==32) {
        result = vmi_FT_32_IEEE_754;
    } else if(SEW==64) {
        result = vmi_FT_64_IEEE_754;
    } else if(SEW!=16) {
        VMI_ABORT("Unexpected SEW %u", SEW); // LCOV_EXCL_LINE
    } else if(enableBFLOAT16(state->riscv)) {
        result = vmi_FT_BFLOAT16;
    } else {
        result = vmi_FT_16_IEEE_754;
    }

    return result;
}

//
// Is checking of register overlap required?
//
static Bool legalOverlap(riscvMorphStateP state, iterDescP id, Uns32 srcNum) {

    riscvSEWMt dstEEW = getEEW(id, 0);
    riscvSEWMt srcEEW = getEEW(id, srcNum);
    Bool       ok     = False;

    if(dstEEW==srcEEW) {

        // legal overlap EEW matches
        ok = True;

    } else if(vectorEEWOverlap(state->riscv)) {

        // mismatched EEW is not legal until after version 0.9
        riscvRegDesc rD       = getRVReg(state, 0);
        riscvRegDesc rS       = getRVReg(state, srcNum);
        Uns32        dstIndex = getRIndex(rD);
        Uns32        srcIndex = getRIndex(rS);

        if(dstEEW<srcEEW) {

            // legal if overlap in lowest-numbered part of destination
            ok = (dstIndex==srcIndex);

        } else if(getEMULx8(id, srcNum)>=VLMULx8MT_1) {

            // legal if overlap in highest-numbered part of destination
            Uns32 dstEMUL = getEMUL(id, 0);
            Uns32 srcEMUL = getEMUL(id, srcNum);

            ok = ((dstIndex+dstEMUL)==(srcIndex+srcEMUL));
        }
    }

    return ok;
}

//
// Validate destination does not overlap sources or mask if required
//
static Bool validateNoOverlap(riscvMorphStateP state, iterDescP id) {

    riscvVShape  vShape = state->attrs->vShape;
    riscvRegDesc rD     = getRVReg(state, 0);

    if(isR0Dst(vShape) && isVReg(rD) && !isScalarN(vShape, 0)) {

        riscvP       riscv     = state->riscv;
        riscvRegDesc mask      = state->info.mask;
        Uns32        index     = getRIndex(rD);
        Uns32        dstRegNum = getEMULxNF(state, id, 0);
        overlapType  ot        = getOverlapType(vShape);
        Uns32        badMask   = 0;
        Uns32        i;
        Uns32        srcNum;

        // construct mask of registers that may not be sources
        for(i=0; i<dstRegNum; i++) {

            Uns32 part = i+index;

            if(part<VREG_NUM) {
                badMask |= (1<<part);
            }
        }

        // destination must not overlap source or mask if segmented
        if((ot&OT_XSM) && state->info.nf) {
            ot |= OT_SM;
        }

        // destination must not overlap the mask for some instructions in
        // version 0.7.1 only (constraint relaxed from 0.8)
        if((ot&OT_M71) && riscvVFSupport(riscv, RVVF_STRICT_OVERLAP)) {
            ot |= OT_M;
        }

        // destination must not overlap source or mask for vmsof/vmsif/vmsbf
        // in some cases
        if((ot&OT_VMSF) && riscvVFSupport(riscv, RVVF_NO_VMSF_OVERLAP)) {
            ot |= OT_SM;
        }

        // validate overlap with mask if required
        if(mask && ((ot&OT_M) || (id->MLEN!=getEEW(id, 0)))) {

            Uns32 index = getRIndex(mask);

            if(indexInMask(index, badMask)) {
                ILLEGAL_INSTRUCTION_MESSAGE(
                    riscv, "IOVP", "Illegal overlap of Vd and mask"
                );
                return False;
            }
        }

        // validate overlap with sources if required
        for(srcNum=1; srcNum<RV_MAX_AREGS; srcNum++) {

            riscvRegDesc rA = getRVReg(state, srcNum);

            if(isVReg(rA)) {

                Uns32 srcRegNum = getEMUL(id, srcNum);

                if((ot&OT_S) || !legalOverlap(state, id, srcNum)) {

                    Uns32 index = getRIndex(rA);

                    for(i=0; i<srcRegNum; i++) {

                        Uns32 part = i+index;

                        if((part<VREG_NUM) && indexInMask(part, badMask)) {
                            ILLEGAL_OPERAND_MESSAGE(
                                riscv, "IOVP", "illegal overlap of Vd", srcNum
                            );
                            return False;
                        }
                    }
                }
            }
        }
    }

    return True;
}

//
// Validate vector floating point argument widths are implemented (but not
// necessarily enabled in the base ISA)
//
static Bool validateVFPArgWidth(riscvP riscv, Uns32 SEW) {

    Bool ok = False;

    if(SEW==16) {
        ok = riscv->configInfo.vect_profile & RVVS_H;
    } else if(SEW==32) {
        ok = riscv->configInfo.vect_profile & RVVS_F;
    } else if(SEW==64) {
        ok = riscv->configInfo.vect_profile & RVVS_D;
    }

    if(!ok) {
        ILLEGAL_INSTRUCTION_MESSAGE(
            riscv, "IFPSEW", "Illegal vector floating point SEW"
        );
    }

    return ok;
}

//
// Validate vector instruction argument widths
//
static Bool validateVArgWidths(riscvMorphStateP state, iterDescP id) {

    riscvP      riscv  = state->riscv;
    riscvVShape vShape = state->attrs->vShape;
    Bool        ok     = validateNoOverlap(state, id);
    Uns32       i;

    for(i=0; ok && (i<RV_MAX_AREGS); i++) {

        vrType type = getEType(id, i);

        if(type) {

            riscvSEWMt     EEW    = getEEW(id, i);
            riscvVLMULx8Mt EMULx8 = getEMULx8(id, i);

            if(EEW>riscv->configInfo.ELEN) {

                ILLEGAL_OPERAND_MESSAGE(riscv, "IEEW", "EEW>ELEN", i);

                ok = False;

            } else if((EEW<riscv->configInfo.SEW_min) && (type!=VRT_MASK)) {

                if(riscv->configInfo.SEW_min==8) {
                    ILLEGAL_OPERAND_MESSAGE(riscv, "IEEW", "EEW<8", i);
                } else {
                    ILLEGAL_OPERAND_MESSAGE(riscv, "IEEW", "EEW<SEW_min", i);
                }

                ok = False;

            } else if(!EMULx8) {

                // LCOV_EXCL_START
                ILLEGAL_OPERAND_MESSAGE(riscv, "IEMUL", "EMUL<1/8", i);

                ok = False;
                // LCOV_EXCL_STOP

            } else if(EMULx8>VLMULx8MT_8) {

                ILLEGAL_OPERAND_MESSAGE(riscv, "IEMUL", "EMUL>8", i);

                ok = False;

            } else if(isFloatN(vShape, i)) {

                ok = validateVFPArgWidth(riscv, EEW);
            }
        }
    }

    return ok;
}

//
// Indicate whether any vector argument is signed
//
inline static Bool isAnyVArgSigned(riscvMorphStateP state) {
    return state->attrs->argType != RVVX_UU;
}

//
// Indicate whether an indexed vector argument is signed
//
inline static Bool isVArgSigned(riscvMorphStateP state, Uns32 i) {
    return state->attrs->argType & ((i==1) ? RVVX_S1 : RVVX_S2);
}

//
// Widen source and destination operands if required
//
static void widenOperands(riscvMorphStateP state, iterDescP id) {

    riscvVShape vShape = state->attrs->vShape;

    if(isNarrowing(vShape)) {

        // process output if this is a narrowing operation
        id->rdNarrow = id->r[0];
        id->r[0] = newTmp(state);

    } else {

        Uns32 i;

        for(i=1; i<RV_MAX_AREGS; i++) {

            riscvSEWMt EEW = getEEW(id, i);

            // detect arguments requiring extension
            if((EEW<id->SEW) && !(forceEEW(id, i) || isMaskN(vShape, i))) {

                vmiReg tmpA = newTmp(state);

                if(!isFloatN(vShape, i)) {

                    // integer argument
                    Bool sExtend = isVArgSigned(state, i);

                    // extend to temporary
                    vmimtMoveExtendRR(id->SEW, tmpA, EEW, id->r[i], sExtend);

                } else {

                    // floating point argument
                    vmiReg        flags = riscvGetFPFlagsMT(state->riscv);
                    vmiFType      typeD = getSEWFType(state, id->SEW);
                    vmiFType      typeS = getSEWFType(state, EEW);
                    vmiFPRC       rc    = vmi_FPR_NEAREST;
                    vmiFPConfigCP ctrl  = getFPControl(state);

                    // convert to temporary
                    vmimtFConvertRR(
                        typeD, tmpA, typeS, id->r[i], rc, flags, ctrl
                    );
                }

                // use extended temporary as source or destination
                id->r[i] = tmpA;
            }
        }
    }
}

//
// Return vmiFlagsCP specifying which native flag is used to set the saturation
// flag for unsigned and signed vector operations
//
inline static vmiFlagsCP getVSatFlags(riscvMorphStateP state) {

    return getSatFlags(state, isAnyVArgSigned(state));
}

//
// Narrow result if required, possibly with saturation
//
static void narrowResult(riscvMorphStateP state, iterDescP id) {

    riscvVShape vShape = state->attrs->vShape;

    if(!isNarrowing(vShape)) {

        // no action

    } else if(!isSaturating(vShape)) {

        // narrowing without saturation
        vmimtMoveRR(id->SEW, id->rdNarrow, id->r[0]);

    } else {

        // narrowing with saturation
        Bool       isSigned = isAnyVArgSigned(state);
        vmiBinop   shiftop  = isSigned ? vmi_SHLSQ : vmi_SHLUQ;
        vmiFlagsCP flags    = getVSatFlags(state);
        Uns32      bytes    = id->SEW/8;

        // narrow result with saturation
        vmimtBinopRC(id->SEW*2, shiftop, id->r[0], id->SEW, flags);

        // merge saturation flag with sticky vxsat
        updateVXSat(state);

        // extract high part of result
        vmimtMoveRR(id->SEW, id->rdNarrow, VMI_REG_DELTA(id->r[0], bytes));
    }
}

//
// Return VMI register for the given abstract vector register
//
static vmiReg getVMIRegV(
    riscvMorphStateP state,
    iterDescP        id,
    riscvRegDesc     r,
    Uns32            i
) {
    riscvP         riscv  = state->riscv;
    riscvVLMULx8Mt EMULx8 = getEMULx8(id, i);
    Uns32          index  = getRIndex(r);

    // validate register index is a multiple of the current EMUL, ignoring
    // the case when EMULx8 is zero or greater than 8 (for which a better
    // message is emitted later)
    if(!EMULx8) {
        // no action
    } else if(!((index*8) & (EMULx8-1))) {
        // no action
    } else if(EMULx8==VLMULx8MT_2) {
        ILLEGAL_OPERAND_MESSAGE(riscv, "IVI", "register index must be multiple of 2", i);
    } else if(EMULx8==VLMULx8MT_4) {
        ILLEGAL_OPERAND_MESSAGE(riscv, "IVI", "register index must be multiple of 4", i);
    } else if(EMULx8==VLMULx8MT_8) {
        ILLEGAL_OPERAND_MESSAGE(riscv, "IVI", "register index must be multiple of 8", i);
    }

    return getVMIReg(riscv, r);
}

//
// Get mask bit for the given register in the top-set mask
//
inline static Uns32 getTopSetMask(riscvRegDesc rdA) {
    return 1<<getRIndex(rdA);
}

//
// Return a Boolean indicating whether the register requires its top part to be
// set
//
static Bool requireTopSet(
    riscvMorphStateP state,
    iterDescP        id,
    riscvRegDesc     rdA,
    Uns32            VLMUL
) {
    Bool result = False;

    if(!rdA) {

        // no target register

    } else if(inVTA1Mode(state->riscv)) {

        // no optimisation of top-set state in agnostic mode
        result = True;

    } else {

        // optimisation of top-zero state
        riscvP           riscv      = state->riscv;
        riscvBlockStateP blockState = riscv->blockState;
        Uns32            mask       = getTopSetMask(rdA);
        riscvTZ          setIndex   = (VLMUL==1) ? VTZ_SINGLE : VTZ_GROUP;
        riscvTZ          clearIndex = (VLMUL!=1) ? VTZ_SINGLE : VTZ_GROUP;
        Uns32            i;

        // process each component of the register group
        for(i=0; i<VLMUL; i++, mask<<=1) {

            // detect if any part requires top set
            result = result || !(blockState->VSetTopMt[setIndex] & mask);

            // clear VLMUL-specific top part set state for the other view
            blockState->VSetTopMt[clearIndex] &= ~mask;

            // indicate top-set state of register is known in this view, unless
            // SEW is forced to 8 by this instruction
            if(!forceSEW8(state, id)) {
                blockState->VSetTopMt[setIndex] |= mask;
            }
        }
    }

    return result;
}

//
// Unlike regular floating point instructions, the width of a scalar floating
// point argument is sometimes not encoded in the instruction itself but instead
// depends on the current SEW, so this needs to be filled when SEW is known
//
static riscvRegDesc setSEWBits(
    riscvMorphStateP state,
    iterDescP        id,
    Uns32            argNum,
    riscvRegDesc     rA
) {
    if(isFReg(rA) && !getRBits(rA)) {
        rA = setRBits(rA, id->SEW);
        setRVReg(state, argNum, rA);
    }

    return rA;
}

//
// Fill all registers for a vector operation
//
static void getVectorOpRegisters(riscvMorphStateP state, iterDescP id) {

    riscvP       riscv  = state->riscv;
    riscvRegDesc mask   = state->info.mask;
    riscvVShape  vShape = state->attrs->vShape;
    Uns32        i;

    // initialize mask register
    id->mask = mask ? getVMIReg(riscv, mask) : VMI_NOREG;

    for(i=0; i<RV_MAX_AREGS; i++) {

        riscvRegDesc rA = getRVReg(state, i);
        vmiReg       r  = VMI_NOREG;
        vrDescP      vr = &id->vr[i];

        // determine vector argument type
        if(!rA) {
            // no action
        } else if(!isVReg(rA)) {
            vr->type = VRT_XF;
        } else if(isScalarN(vShape, i)) {
            vr->type = VRT_SCALAR;
        } else if(!isMaskN(vShape, i)) {
            vr->type = VRT_VECTOR;
        } else {
            vr->type = VRT_MASK;
        }

        // seed operand EEW and EMULx8
        vr->EEW    = (vr->type==VRT_MASK)   ? id->MLEN    : id->SEW;
        vr->EMULx8 = (vr->type==VRT_VECTOR) ? id->VLMULx8 : VLMULx8MT_1;

        // refine operand SEW and EMULx8
        if((vr->type==VRT_SCALAR) || (vr->type==VRT_VECTOR)) {

            riscvVLMULx8Mt mulNx8 = getWidthMultiplierN(vShape, i)*VLMULx8MT_1;
            riscvSEWMt     eew    = state->info.eew;

            // take into account EEW encoded in the instruction
            if(state->info.isWhole) {
                // whole-register instructions already configured
            } else if(!eew) {
                // no encoded EEW
            } else if(eew==1) {
                // unit stride mask load/store
            } else if((i==2) || (state->info.memBits>0)) {
                vr->forceEEW = True;
                mulNx8 = (mulNx8*eew)/vr->EEW;
            }

            // take into account EEW divisor encoded in the instruction
            if(isDividedN(vShape, i)) {
                mulNx8 /= state->info.eewDiv;
            }

            // adjust EMULx8
            if(vr->type==VRT_VECTOR) {
                vr->EMULx8 = (vr->EMULx8*mulNx8)/VLMULx8MT_1;
            }

            // adjust EEW
            vr->EEW = (vr->EEW*mulNx8)/VLMULx8MT_1;
        }

        // determine EMUL (1 if fractional)
        vr->EMUL = (vr->EMULx8/VLMULx8MT_1) ? : 1;

        // get VMI register for the operand
        if(vr->type==VRT_XF) {
            r = getVMIRegFS(state, setSEWBits(state, id, i, rA));
        } else if(vr->type==VRT_SCALAR) {
            r = getVMIReg(riscv, rA);
        } else if(vr->type==VRT_VECTOR) {
            vr->type = VRT_VECTOR;
            r = getVMIRegV(state, id, rA, i);
        } else if(vr->type==VRT_MASK) {
            r = getVMIReg(riscv, rA);
            if(!i) {id->PdA = rA;}
        }

        id->r[i] = r;
    }
}

//
// Is the indexed vector register striped?
//
static Bool isIndexedVRegisterStriped(iterDescP id, Uns32 i) {

    Uns32          VLEN   = id->VLEN;
    Uns32          SLEN   = id->SLEN;
    riscvVLMULx8Mt EMULx8 = getEMULx8(id, i);

    return (EMULx8>VLMULx8MT_1) && (VLEN>SLEN);
}

//
// Convert vector argument register to indexed register using the given index
//
static void getIndexedVRegisterInt(
    riscvMorphStateP state,
    iterDescP        id,
    Uns32            i,
    vmiReg           index
) {
    Uns32          VLEN     = id->VLEN;
    Uns32          SLEN     = id->SLEN;
    riscvVLMULx8Mt EMULx8   = getEMULx8(id, i);
    riscvSEWMt     EEW      = getEEW(id, i);
    Bool           striped  = (VLEN>SLEN);
    Uns32          fieldNum = id->nf+1;
    Uns32          vecBytes = VLEN*EMULx8*fieldNum/64;

    // if fractional LMUL is not implemented, only registers accessed with
    // EMUL>1 are striped
    if(!vectorFractLMUL(state->riscv)) {
        striped &= (EMULx8>VLMULx8MT_1);
    }

    getIndexedRegister(
        state, id, &id->r[i], index, EMULx8, EEW, vecBytes, striped
    );
}

//
// Convert mask argument register to indexed register
//
static void getIndexedMVMIReg(riscvMorphStateP state, iterDescP id, vmiReg *rP) {

    Uns32  VLEN     = id->VLEN;
    Uns32  SLEN     = id->SLEN;
    Uns32  vecBytes = VLEN/8;
    vmiReg index    = CSR_REG_MT(vstart);
    Bool   striped  = (VLEN>SLEN);

    // if fractional LMUL is not implemented, mask registers are not striped
    if(!vectorFractLMUL(state->riscv)) {
        striped = False;
    }

    getIndexedRegister(
        state, id, rP, index, VLMULx8MT_1, id->MLEN, vecBytes, striped
    );
}

//
// Convert vector argument register to indexed register
//
static void getIndexedVRegister(riscvMorphStateP state, iterDescP id, Uns32 i) {
    getIndexedVRegisterInt(state, id, i, CSR_REG_MT(vstart));
}

//
// Convert mask argument register to indexed register
//
static void getIndexedMRegister(riscvMorphStateP state, iterDescP id, Uns32 i) {
    getIndexedMVMIReg(state, id, &id->r[i]);
}

//
// Convert vector argument registers to indexed registers
//
static void getIndexedVRegisters(riscvMorphStateP state, iterDescP id) {

    riscvVShape vShape = state->attrs->vShape;
    Uns32       i;

    for(i=0; i<RV_MAX_AREGS; i++) {
        if(!isVReg(getRVReg(state, i))) {
            // no action
        } else if(isScalarN(vShape, i)) {
            // no action
        } else if(isUnindexedN(vShape, i)) {
            // no action
        } else if(isMaskN(vShape, i)) {
            getIndexedMRegister(state, id, i);
        } else {
            getIndexedVRegister(state, id, i);
        }
    }
}

//
// Return the index number of the indexed successor register of the given
// vector register
//
static Uns32 getSegmentRegisterIndex(iterDescP id, riscvRegDesc rv, Uns32 i) {
    return (getRIndex(rv) + (i*getEMUL(id, 0))) % VREG_NUM;
}

//
// Return the descriptor of the indexed successor register of the given
// vector register
//
static riscvRegDesc getSegmentRegister(iterDescP id, riscvRegDesc rv, Uns32 i) {
    return RV_RD_V|getSegmentRegisterIndex(id, rv, i);
}

//
// Return vmiReg for the indexed successor segment register of vector register 0
//
static vmiReg getSegmentRegisterV0(riscvMorphStateP state, iterDescP id, Uns32 i) {

    vmiReg       base  = id->r[0];
    Int32        VLEN  = id->VLEN;
    riscvRegDesc rv0   = getRVReg(state, 0);
    Int32        i1    = getSegmentRegisterIndex(id, rv0, 0);
    Int32        i2    = getSegmentRegisterIndex(id, rv0, i);
    Int32        delta = (i2-i1)*(VLEN/8);

    return VMI_REG_DELTA(base, delta);
}

//
// Validate non-zero vstart if required
//
static void checkVStartZero(riscvMorphStateP state, iterDescP id) {

    riscvP           riscv          = state->riscv;
    riscvBlockStateP blockState     = riscv->blockState;
    riscvVStartType  vstart0        = state->attrs->vstart0;
    Bool             requireVStart0 = (vstart0==RVVS_ZERO);

    // non-interruptible instructions allow non-zero vstart only if configured
    if(vstart0==RVVS_NO_INT) {
        requireVStart0 = riscv->configInfo.require_vstart0;
    }

    // check for non-zero vstart if required
    if(requireVStart0 && !blockState->VStartZeroMt) {

        vmiReg    vstart = CSR_REG_MT(vstart);
        vmiLabelP doOp   = vmimtNewLabel();

        // exception if vstart is not zero
        vmimtCompareRCJumpLabel(32, vmi_COND_EQ, vstart, 0, doOp);
        ILLEGAL_INSTRUCTION_MESSAGE(state->riscv, "IVS0", "Illegal non-zero vstart");
        vmimtInsertLabel(doOp);

        // vstart is now known to be zero
        blockState->VStartZeroMt = True;
    }
}

//
// Return register holding effective vector length (EVL)
//
inline static vmiReg getEVLRegMT(riscvMorphStateP state) {
    vmimtRegReadImpl("vl");
    return (state->info.eew==1) ? RISCV_VL_EEW1 : CSR_REG_MT(vl);
}

//
// Validate vstart CSR is in range
//
static void validateVStart(
    riscvMorphStateP state,
    iterDescP        id,
    vmiCondition     cond,
    vmiLabelP        label
) {
    vmiReg vstart = CSR_REG_MT(vstart);

    if(state->info.isWhole) {
        vmimtCompareRCJumpLabel(32, cond, vstart, getVLMAXOp(id), label);
    } else {
        vmimtCompareRRJumpLabel(32, cond, vstart, getEVLRegMT(state), label);
    }
}

//
// Clamp vstart CSR if required
//
static void clampVStart(riscvMorphStateP state, iterDescP id) {

    vmiReg vstart = CSR_REG_MT(vstart);

    if(state->info.isWhole) {
        vmimtMoveRC(64, vstart, getVLMAXOp(id));
    } else {
        vmimtMoveExtendRR(64, vstart, 32, getEVLRegMT(state), False);
    }
}

//
// Handle non-zero vstart
//
static vmiLabelP handleNonZeroVStart(
    riscvMorphStateP state,
    iterDescP        id,
    Bool             iterVStart
) {
    riscvP           riscv      = state->riscv;
    riscvBlockStateP blockState = riscv->blockState;
    vmiLabelP        skip       = 0;

    if(!blockState->VStartZeroMt) {

        vmiReg      vstart = CSR_REG_MT(vstart);
        riscvVShape vShape = state->attrs->vShape;

        if(noVStartCheck(vShape)) {

            // some scalar operations do not require vstart<vl check
            vmimtMoveRC(64, vstart, 0);

        } else {

            skip = vmimtNewLabel();

            if(!iterVStart) {

                // skip operation if required, vstart clamp not required
                validateVStart(state, id, vmi_COND_NL, skip);

            } else {

                // skip operation if required, vstart clamp required
                vmiLabelP doOp = vmimtNewLabel();

                // go if at least one element should be processed
                validateVStart(state, id, vmi_COND_L, doOp);

                // clamp vstart to vl if it is used as an iteration index
                clampVStart(state, id);

                // go to zero extension operation
                vmimtUncondJumpLabel(skip);

                // here if at least one element should be processed
                vmimtInsertLabel(doOp);
            }
        }

    } else if(iterVStart) {

        // if vstart is used as an iteration index, ensure it is reset to zero
        // on instruction completion
        blockState->VStartZeroMt = False;
    }

    return skip;
}

//
// If the instruction is a vector floating point instruction, validate that the
// current rounding mode is valid. Note that this test is performed whether or
// not the instruction actually uses the current rounding mode (unlike the
// scalar floating point extension), even for instructions such as
// vfncvt.rod.f.f.w which explicitly encode a non-current mode
//
inline static Bool validVFPRM(riscvMorphStateP state) {

    Bool validRM = True;

    if(state->info.rm!=RV_RM_NONE) {
        validRM = riscvEmitCheckLegalRM(state->riscv, RV_RM_CURRENT);
    }

    return validRM;
}

//
// Do argument checks at the start of a vector operation
//
static Bool checkVectorOp(riscvMorphStateP state, iterDescP id) {

    // call operation-specific argument check if required
    riscvCheckVFn checkCB = state->attrs->checkCB;
    return !checkCB || checkCB(state, id);
}

//
// Do actions at the start of a vector operation
//
static void startVectorOp(riscvMorphStateP state, iterDescP id, Bool iterVStart) {

    // set vector state to dirty if required
    updateVS(state->riscv);

    // handle non-zero vstart
    id->skip = handleNonZeroVStart(state, id, iterVStart);

    // call operation-specific initialization if required
    dispatchVector(state, state->attrs->initCB, id);
}

//
// Kill base registers and temporaries
//
static void killBaseRegistersAndTemps(riscvMorphStateP state, iterDescP id) {

    Uns32 i;

    // reset all base registers
    for(i=0; i<NUM_BASE_REGS; i++) {
        static const baseDesc zero = {{0}};
        id->base[i] = zero;
    }

    // kill all base registers
    Uns32 vBaseBits = sizeof(state->riscv->vBase)*8;
    vmimtRegNotReadR(vBaseBits, RISCV_CPU_TEMP(vBase));

    // kill all normal temporaries
    Uns32 tmpBits = sizeof(state->riscv->TMP)*8;
    vmimtRegNotReadR(tmpBits, RISCV_CPU_TEMP(TMP));

    // kill all field mask temporaries
    vmimtRegNotReadR(8, RISCV_VPRED_MASK);
    vmimtRegNotReadR(8, RISCV_VACTIVE_MASK);
}

//
// Jump to target label if operation is not selected by mask
//
static void skipIfMask0(riscvMorphStateP state, iterDescP id) {

    if(id->MLEN>=8) {

        // mask stride is a byte multiple: byte test and jump
        getIndexedMVMIReg(state, id, &id->mask);

        // go if mask bit not set
        vmimtTestRCJumpLabel(8, vmi_COND_Z, id->mask, 1, id->maskF);

    } else {

        // mask stride is not a byte multiple: bit test and jump
        vmiReg mbit      = CSR_REG_MT(vstart);
        vmiReg t         = newTmp(state);
        Uns32  shiftMLEN = mulToShiftP2(id->MLEN);

        // handle mask register striping if required
        mbit = getStripedIndexM(state, id, t, mbit);

        // scale bit index if required
        if(shiftMLEN) {
            vmimtBinopRRC(32, vmi_SHL, t, mbit, shiftMLEN, 0);
            mbit = t;
        }

        // go if mask bit not set
        vmimtTestBitVRJumpLabel(id->VLEN, 32, False, id->mask, mbit, id->maskF);

        // free allocated temporary
        freeTmp(state);
    }
}

//
// Emit code to initialize access to predicate register field
//
static vmiReg accessMaskField(
    riscvMorphStateP state,
    iterDescP        id,
    riscvRegDesc     mask
) {
    riscvP riscv = state->riscv;
    vmiReg Pd    = getVMIReg(riscv, mask);

    getIndexedMVMIReg(state, id, &Pd);

    return Pd;
}

//
// Per-element callback to fill unmasked element with ones
//
static RISCV_MORPHV_FN(emitVMA1CB) {

    riscvRegDesc PdA = id->PdA;

    if(PdA) {

        // mask element update
        vmiReg t0 = newTmp(state);
        vmiReg Pd = accessMaskField(state, id, PdA);

        prepareMasks(state, id, t0, False, True);
        vmimtBinopRR(8, vmi_OR, Pd, RISCV_VACTIVE_MASK, 0);

        // free temporary
        freeTmp(state);

    } else {

        // vector element update
        vmimtMoveRC(id->SEW, id->r[0], -1);
    }
}

//
// Return callback to generate reult for masked-off elements
//
static riscvMorphVFn getUnmaskedCB(riscvMorphStateP state, iterDescP id) {

    riscvMorphAttrCP attrs = state->attrs;
    riscvMorphVFn    opFCB = attrs->opFCB;
    vmiLabelP        maskF = id->maskF;

    if(!opFCB && maskF && isR0Dst(attrs->vShape) && inVMA1Mode(state->riscv)) {
        opFCB = emitVMA1CB;
    }

    return opFCB;
}

//
// Start one vector operation loop iteration
//
static void startVectorLoop(riscvMorphStateP state, iterDescP id) {

    riscvVShape vShape = state->attrs->vShape;

    // handle element masking if required (NOTE: for instructions such as VADC,
    // the mask is actually a carry-in so should not be handled here)
    if(!isMaskCIn(vShape) && !VMI_ISNOREG(id->mask)) {

        // create target label if element is masked out
        id->maskF = vmimtNewLabel();

        // skip entire operation if masked out and no action for unmasked case
        if(!getUnmaskedCB(state, id)) {
            skipIfMask0(state, id);
        }
    }
}

//
// End one vector loop iteration
//
static void endVectorLoop(riscvMorphStateP state, iterDescP id, vmiLabelP loop) {

    vmiReg vstart = CSR_REG_MT(vstart);

    // here if element is not selected by mask
    if(id->maskF) {
        vmimtInsertLabel(id->maskF);
    }

    // increment vstart
    vmimtBinopRC(32, vmi_ADD, vstart, 1, 0);

    // terminate when either vl or vlmax is reached (depending on whether this
    // is a whole-register operation)
    validateVStart(state, id, vmi_COND_L, loop);
}

//
// Update target register top-set state when a scalar is written
//
static void updateScalarSetTail(riscvMorphStateP state, iterDescP id) {

    riscvP           riscv      = state->riscv;
    riscvBlockStateP blockState = riscv->blockState;
    riscvRegDesc     VdA        = getRVReg(state, 0);
    Uns32            mask       = getTopSetMask(VdA);

    // a scalar write always updates the bottom element of a vector register
    // and sets the rest, so the single register is known to have top set
    // whatever the current vector length
    blockState->VSetTopMt[VTZ_SINGLE] |=  mask;
    blockState->VSetTopMt[VTZ_GROUP]  &= ~mask;
}

//
// Return mask to select the numbered successor of a base segment register
//
inline static Uns32 getTopSetVdMask(Uns32 i) {
    return (1<<i);
}

//
// Fill top part of predicate and vector target registers using per-element
// algorithm
//
static void setVdPdTopPE(
    riscvMorphStateP state,
    iterDescP        id,
    Bool             setPd,
    Uns32            setVd
) {
    riscvP       riscv   = state->riscv;
    riscvRegDesc PdA     = id->PdA;
    vmiLabelP    loop    = vmimtNewLabel();
    vmiReg       vstart  = CSR_REG_MT(vstart);
    Int8         top     = riscv->configInfo.agnostic_ones ? -1 : 0;
    Uns32        elemNum = 0;

    // here for next iteration
    vmimtInsertLabel(loop);

    if(setPd) {

        // get indexed predicate element
        vmiReg t0 = newTmp(state);
        vmiReg Pd = accessMaskField(state, id, PdA);

        // set predicate element (NOTE: MLEN can only be 8 or greater if there
        // are instructions that write both vector *and* mask targets, which is
        // currently not true)
        if(id->MLEN>=8) {
            vmimtMoveRC(id->MLEN, Pd, top); // LCOV_EXCL_LINE
        } else if(top) {
            prepareMasks(state, id, t0, False, True);
            vmimtBinopRR(8, vmi_OR, Pd, RISCV_VACTIVE_MASK, 0);
        } else {
            prepareMasks(state, id, t0, True, False);
            vmimtBinopRR(8, vmi_AND, Pd, RISCV_VPRED_MASK, 0);
        }

        // free temporary
        freeTmp(state);

        // get number of mask elements
        elemNum = id->VLEN/id->MLEN;
    }

    if(setVd) {

        Uns32 i;

        // get indexed vector element
        getIndexedVRegister(state, id, 0);

        // iterate over all segment registers affected
        for(i=0; i<=id->nf; i++) {

            if(setVd & getTopSetVdMask(i)) {

                // get next segment register requiring top-set
                vmiReg vd = getSegmentRegisterV0(state, id, i);

                // set element, either to all-ones or all-zeroes
                vmimtMoveRC(id->SEW, vd, top);
            }
        }

        // get number of vector elements
        elemNum = (id->VLEN*id->vregs)/id->SEW;
   }

    // kill base registers for this iteration
    killBaseRegistersAndTemps(state, id);

    // increment vstart and repeat if not done
    vmimtBinopRC(32, vmi_ADD, vstart, 1, 0);
    vmimtCompareRCJumpLabel(32, vmi_COND_NE, vstart, elemNum, loop);
}

//
// Fill top part of predicate and vector target registers with zero using
// block-transfer algorithm
//
static void zeroVdPdTopBLT(
    riscvMorphStateP state,
    iterDescP        id,
    Bool             zeroPd,
    Uns32            zeroVd
) {
    Uns32        VLEN    = id->VLEN;
    Uns32        elemNum = VLEN/id->MLEN;
    riscvRegDesc PdA     = id->PdA;
    vmiReg       vstart  = CSR_REG_MT(vstart);
    vmiReg       t0      = newTmp(state);

    if(zeroPd) {

        // get indexed mask register target
        vmiReg Pd = accessMaskField(state, id, PdA);

        // calculate number of elements to clear
        vmimtBinopRCR(32, vmi_SUB, t0, elemNum, vstart, 0);

        // zero register top part
        vmimtZeroRV(VLEN, Pd, 32, t0, 0, id->MLEN/8, vmi_CC_NONE);
    }

    if(zeroVd) {

        Uns32 VLENxN = VLEN*getEMUL(id,0);
        Uns32 i;

        // get indexed vector register target
        getIndexedVRegister(state, id, 0);

        // calculate number of elements to clear
        vmimtBinopRCR(32, vmi_SUB, t0, elemNum, vstart, 0);

        // iterate over all segment registers affected
        for(i=0; i<=id->nf; i++) {

            if(zeroVd & getTopSetVdMask(i)) {

                // get next segment register requiring top-zero
                vmiReg vd = getSegmentRegisterV0(state, id, i);

                // zero register top part
                vmimtZeroRV(VLENxN, vd, 32, t0, 0, id->SEW/8, vmi_CC_NONE);
            }
        }
    }

    // free temporary
    freeTmp(state);
}

//
// Fill top part of predicate and vector target registers if required
//
static vmiLabelP setVdPdTop(riscvMorphStateP state, iterDescP id) {

    riscvRegDesc PdA   = id->PdA;
    riscvRegDesc VdA   = getRVReg(state, 0);
    Bool         setPd = requireTopSet(state, id, PdA, 1);
    Uns32        setVd = 0;
    vmiLabelP    noSet = 0;
    Uns32        i;

    // construct a mask of vector registers affected by this operation that
    // require top-set update
    if((VdA!=PdA) && isVReg(VdA)) {
        for(i=0; i<=id->nf; i++) {
            riscvRegDesc sr = getSegmentRegister(id, VdA, i);
            if(requireTopSet(state, id, sr, getEMUL(id,0))) {
                setVd |= getTopSetVdMask(i);
            }
        }
    }

    if(state->attrs->implicitTZ) {

        // for some instructions, setting of top part is implicit (VCOMPRESS)

    } else if(setPd || setVd) {

        // insert code to skip setting of top half if first fault has been
        // triggered
        if(state->info.isFF) {
            noSet = vmimtNewLabel();
            vmimtCondJumpLabel(RISCV_FF, False, noSet);
        }

        // determine whether per-element or block-transfer algorithm is needed
        if(
            inVTA1Mode(state->riscv) ||
            (setPd && (id->MLEN<8)) ||
            (setVd && isIndexedVRegisterStriped(id, 0))
        ) {
            setVdPdTopPE(state, id, setPd, setVd);
        } else {
            zeroVdPdTopBLT(state, id, setPd, setVd);
        }
    }

    return noSet;
}

//
// Perform actions at the end of a vector operation
//
static void endVectorOp(
    riscvMorphStateP state,
    iterDescP        id,
    riscvVLClassMt   vlClass
) {
    vmiLabelP noSet = 0;

    // call operation-specific post-operation function if required
    dispatchVector(state, state->attrs->endCB, id);

    // set register top parts when vl < vlmax if required
    if(vlClass==VLCLASSMT_MAX) {
        // no top set state change
    } else if(!requireSetTail(state->riscv, id)) {
        // no tail setting required
    } else if(!isR0Dst(state->attrs->vShape)) {
        // first register is not a destination
    } else if(isScalarN(state->attrs->vShape, 0)) {
        updateScalarSetTail(state, id);
    } else {
        noSet = setVdPdTop(state, id);
    }

    // clear first-fault active indication if required
    if(state->info.isFF) {

        // here if setting of top half is skipped
        if(noSet) {
            vmimtInsertLabel(noSet);
        }

        // clear first-fault active indication
        vmimtMoveRC(8, RISCV_FF, False);

        // terminate the block after this instruction because VL may be modified
        // if an exception is trapped
        vmimtEndBlock();
    }

    // here if body is skipped because initial vstart >= vl (NOTE: comment in
    // section 3.4 of 0.7.1 specification "If the value in the vstart register
    // is greater than or equal to the vector length vl then no element
    // operations are performed, nor are the elements at the end of the
    // destination vector past vl zeroed")
    if(id->skip) {
        vmimtInsertLabel(id->skip);
    }
}

//
// Do operation for a single element
//
static void doPerElementOp(riscvMorphStateP state, iterDescP id) {

    riscvMorphVFn opTCB = state->attrs->opTCB;
    riscvMorphVFn opFCB = getUnmaskedCB(state, id);

    if(!opFCB || !id->maskF) {

        // normal operation with action only if selected by mask (or unmasked)
        dispatchVector(state, opTCB, id);

    } else {

        vmiLabelP done = vmimtNewLabel();

        // operation with different actions for 0/1 mask bits
        skipIfMask0(state, id);

        // operation for mask=1
        dispatchVector(state, opTCB, id);
        vmimtUncondJumpLabel(done);

        // operation for mask=0
        vmimtInsertLabel(id->maskF);
        dispatchVector(state, opFCB, id);

        // here at end of operation
        vmimtInsertLabel(done);

        // label has been inserted
        id->maskF = 0;
    }
}

//
// Return a Boolean indicating if vector instruction cannot be executed because
// vtype.vill=1 (does not apply to whole-register instructions)
//
static Bool emitCheckVILL(riscvMorphStateP state) {

    Bool vill = RD_CSR_FIELD_U(state->riscv, vtype, vill) && !state->info.isWhole;

    // indicate this is a vector instruction
    vmimtInstructionClassAdd(OCL_IC_VECTOR);

    if(vill) {
        ILLEGAL_INSTRUCTION_MESSAGE(state->riscv, "VILL", "vtype.vill=1");
    }

    return !vill;
}

//
// Get EEW to use with whole-register operations
//
static riscvSEWMt getWholeEEW(riscvMorphStateP state) {

    riscvP     riscv = state->riscv;
    riscvSEWMt EEW   = riscv->configInfo.SEW_min;

    if(vectorWholeUsesEEW(riscv) && (EEW<state->info.eew)) {
        EEW = state->info.eew;
    }

    return EEW;
}

//
// Configure vector operation attributes
//
static riscvVLClassMt fillVectorOperationData(
    riscvMorphStateP state,
    iterDescP        id
) {
    riscvP         riscv = state->riscv;
    riscvVLClassMt vlClass;

    // configure either for normal or whole-register operations
    if(state->info.isWhole) {
        id->VLMULx8 = VLMULx8MT_1;
        id->VLEN    = riscv->configInfo.VLEN * (state->info.nf+1);
        id->SEW     = getWholeEEW(state);
        id->SLEN    = id->VLEN;
        id->nf      = 0;
        vlClass     = VLCLASSMT_MAX;
    } else {
        id->VLMULx8 = getVLMULMt(state);
        id->VLEN    = riscv->configInfo.VLEN;
        id->SEW     = getSEWMt(state);
        id->SLEN    = riscv->configInfo.SLEN;
        id->nf      = state->info.nf;
        vlClass     = getVLClassMt(state, id);
    }

    if(state->info.eew==1) {

        // mask load/store : override effective SEW and VLMUL
        id->SEW     = SEWMT_8;
        id->VLMULx8 = VLMULx8MT_1;

        // force operation class to non-zero if maximum but SEW is restricted
        if(vlClass==VLCLASSMT_MAX) {
            vlClass = VLCLASSMT_NONZERO;
        }

    } else if(forceSEW8(state, id)) {

        // SEW is forced to 8 : override effective SEW
        id->SEW = SEWMT_8;

        // force operation class to non-zero if maximum but SEW is restricted
        if(vlClass==VLCLASSMT_MAX) {
            vlClass = VLCLASSMT_NONZERO;
        }
    }

    // set derived fields
    id->vregs = (id->VLMULx8/VLMULx8MT_1) ? : 1;
    id->MLEN  = vectorMLEN1(riscv) ? 1 : (id->SEW / id->vregs);

    // return effective class for this operation
    return vlClass;
}

//
// Emit code to dispatch a vector operation
//
static RISCV_MORPH_FN(emitVectorOp) {

    if(emitCheckVILL(state) && validVFPRM(state)) {

        iterDesc       id      = {0};
        riscvVLClassMt vlClass = fillVectorOperationData(state, &id);

        // fill all registers for a vector operation (NOTE: this can cause
        // Illegal Instruction exceptions for inappropriate register arguments,
        // so it must be done before zero-length vector check)
        getVectorOpRegisters(state, &id);

        // validate vstart is zero if required
        checkVStartZero(state, &id);

        if(!validateVArgWidths(state, &id)) {

            // invalid argument widths

        } else if(!checkVectorOp(state, &id)) {

            // failed operation-specific check

        } else if(vlClass!=VLCLASSMT_ZERO) {

            vmiLabelP   loop   = vmimtNewLabel();
            riscvVShape vShape = state->attrs->vShape;
            Uns32       SEWMul = getSEWMultiplier(vShape);

            // start a new vector operation
            startVectorOp(state, &id, True);

            // loop to here
            vmimtInsertLabel(loop);

            // do actions at start of vector loop
            startVectorLoop(state, &id);

            // update base registers for this iteration
            getIndexedVRegisters(state, &id);

            // do operation on one element, scaling the SEW if required
            id.SEW *= SEWMul;
            widenOperands(state, &id);
            doPerElementOp(state, &id);
            id.SEW /= SEWMul;

            // narrow destination operands if required
            narrowResult(state, &id);

            // kill base registers and temporaries for this iteration
            killBaseRegistersAndTemps(state, &id);

            // repeat until done
            endVectorLoop(state, &id, loop);

            // perform actions at end of instruction
            endVectorOp(state, &id, vlClass);
        }

        // zero vstart register on instruction completion
        setVStartZero(state);
    }
}

//
// Emit code to dispatch a vector operation operating on one element with a
// single scalar source or destination
//
static RISCV_MORPH_FN(emitScalarOp) {

    if(emitCheckVILL(state) && validVFPRM(state)) {

        iterDesc       id      = {0};
        Bool           scalarD = !isVReg(getRVReg(state, 0));
        riscvVLClassMt vlClass = fillVectorOperationData(state, &id);

        // fill all registers for a vector operation (NOTE: this can cause
        // Illegal Instruction exceptions for inappropriate register arguments,
        // so it must be done before zero-length vector check)
        getVectorOpRegisters(state, &id);

        // validate vstart is zero if required
        checkVStartZero(state, &id);

        if(!validateVArgWidths(state, &id)) {

            // invalid argument widths

        } else if(!checkVectorOp(state, &id)) {

            // failed operation-specific check

        } else if(scalarD || (vlClass!=VLCLASSMT_ZERO)) {

            // start a new vector operation
            startVectorOp(state, &id, False);

            // do operation on one element
            doPerElementOp(state, &id);

            // end vector operation
            endVectorOp(state, &id, vlClass);
        }

        // zero vstart register on instruction completion
        setVStartZero(state);
    }
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR CSR UPDATE
////////////////////////////////////////////////////////////////////////////////

//
// This enumeration describes the options for setting vl using vsetvi/vsetvli
//
typedef enum setVLOptionE {
    SVT_SET,        // set to value in rs1
    SVT_PRESERVE,   // preserve current vl
    SVT_MAX         // set maximum vl
} setVLOption;

//
// Return the option for setting vl using vsetvi/vsetvli
//
static setVLOption getSetVLOption(riscvMorphStateP state) {

    // set vl to uimm if vsetivli
    if(!getRVReg(state, 1)) {
        return SVT_SET;
    }

    riscvP      riscv = state->riscv;
    unpackedReg rs1   = unpackRX(state, 1);

    if(!VMI_ISNOREG(rs1.r)) {

        // set vl to rs1 if rs1!=zero
        return SVT_SET;

    } else if(riscvVFSupport(riscv, RVVF_SETVLZ_MAX)) {

        // legacy behavior when rs1=zero: set vl to maximum
        return SVT_MAX;

    } else if(riscvVFSupport(riscv, RVVF_SETVLZ_PRESERVE)) {

        // legacy behavior when rs1=zero: preserve vl
        return SVT_PRESERVE;

    } else {

        // new behavior: set vl to maximum if rd!=zero, otherwise preserve it
        unpackedReg rd = unpackRX(state, 0);

        return VMI_ISNOREG(rd.r) ? SVT_PRESERVE : SVT_MAX;
    }
}

//
// Is CSR vstart forced to zero?
//
inline static Bool forceVStart0(riscvP riscv) {
    return !RD_CSR_MASK64(riscv, vstart);
}

//
// Adjust JIT code generator state after write of vstart CSR
//
void riscvWVStart(riscvMorphStateP state, Bool useRS1) {

    riscvP           riscv      = state->riscv;
    riscvBlockStateP blockState = riscv->blockState;

    if(!useRS1 && (state->info.csrUpdate==RV_CSR_RW) && !state->info.c) {
        blockState->VStartZeroMt = True;
    } else {
        blockState->VStartZeroMt = forceVStart0(riscv);
    }

    updateVS(riscv);
}

//
// Return maximum vector length for the given vector type settings
//
Uns32 riscvGetMaxVL(riscvP riscv, riscvVType vtype) {

    Uns32          VLEN    = riscv->configInfo.VLEN;
    riscvSEWMt     SEW     = getVTypeSEW(vtype);
    riscvVLMULx8Mt VLMULx8 = vtypeToVLMULx8(vtype);

    return (VLMULx8*VLEN)/(SEW*8);
}

//
// If the specified vtype is valid, return the SEW, otherwise return
// SEWMT_UNKNOWN
//
riscvSEWMt riscvValidVType(riscvP riscv, riscvVType vtype) {

    riscvSEWMt     SEW_min = riscv->configInfo.SEW_min;
    riscvSEWMt     ELEN    = riscv->configInfo.ELEN;
    riscvSEWMt     VLEN    = riscv->configInfo.VLEN;
    riscvSEWMt     FRLEN   = (ELEN<VLEN) ? ELEN : VLEN ;
    riscvSEWMt     SEW     = getVTypeSEW(vtype);
    riscvVLMULx8Mt VLMULx8 = vtypeToVLMULx8(vtype);

    if(
        // validate fields that must be zero
        getVTypeZero(vtype) ||
        // validate vlmulf setting
        ((getVTypeSVLMUL(vtype)<0) && !vectorFractLMUL(riscv)) ||
        // validate agnostic settings
        ((getVTypeVTA(vtype)||getVTypeVMA(vtype)) && !vectorAgnostic(riscv)) ||
        // validate SEW is supported
        (SEW<SEW_min) || (SEW>ELEN) ||
        // validate LMUL>=(SEW/FRLEN)
        !(VLMULx8>=((SEW*8)/FRLEN))
    ) {
        SEW = SEWMT_UNKNOWN;
    }

    return SEW;
}

//
// Update VL, and VTYPE
//
static Uns32 setVLSEWLMUL(riscvP riscv, Uns64 vl, Uns32 vtypeBits) {

    riscvVType vtype = composeVType(riscv, vtypeBits);
    Bool       vill  = !riscvValidVType(riscv, vtype);

    // handle illegal vtype setting
    if(vill) {
        vtype.u.u32 = 0;
    }

    if(vill && riscv->configInfo.vill_trap) {

        // take Illegal Instruction exception
        riscvIllegalInstructionMessage(riscv, "Illegal update to vtype");

    } else if(riscvSetVLForVType(riscv, vl, vtype)) {

        // validate vl CSR update assuming the new vtype (may cause Illegal
        // Instruction if vl should be preserved but would have to be reduced)

        // update vtype CSR
        riscvSetVType(riscv, vill, vtype);

        // set matching polymorphic key and clamped vl
        riscvRefreshVectorPMKey(riscv);
    }

    return RD_CSRC(riscv, vl);
}

//
// VSetVL to maximum supported size
//
static Uns32 setMaxVLSEWLMUL(riscvP riscv, Uns32 vtypeBits) {

    riscvVType vtype = composeVType(riscv, vtypeBits);

    // compute effective VLMAX
    Uns32 VLMAX = riscvGetMaxVL(riscv, vtype);

    return setVLSEWLMUL(riscv, VLMAX, vtypeBits);
}

//
// Emit variable rs1/uimm argument for vset[i]vl[i]
//
static void emitSetVLRS1Arg(riscvMorphStateP state) {

    if(getRVReg(state, 1)) {
        vmimtArgReg(64, unpackRX(state, 1).r);
    } else {
        vmimtArgUns64(state->info.c);
    }
}

//
// Handle the first source argument of VSetVL
//
static vmiCallFn handleVSetVLArg1(riscvMorphStateP state) {

    setVLOption option = getSetVLOption(state);

    // indicate whether this operation preserves VL (determines whether a
    // consequent change in VLmight cause an Illegal Instruction)
    vmimtMoveRC(8, RISCV_PRESERVE, option==SVT_PRESERVE);

    // emit processor argument
    vmimtArgProcessor();

    if(option==SVT_SET) {

        // set vl to rs1
        emitSetVLRS1Arg(state);
        return (vmiCallFn)setVLSEWLMUL;

    } else if(option==SVT_MAX) {

        // set vl to maximum
        return (vmiCallFn)setMaxVLSEWLMUL;

    } else {

        // preserve vl
        vmimtArgReg(64, CSR_REG_MT(vl));
        return (vmiCallFn)setVLSEWLMUL;
    }
}

//
// Indicate vtype and vl are written by this instruction
//
static void emitUpdateVTypeVL(riscvMorphStateP state) {

    // set vector state to dirty
    updateVS(state->riscv);

    // indicate written registers
    vmimtRegWriteImpl("vtype");
    vmimtRegWriteImpl("vl");
}

//
// Emit VSetVL <rd>, <rs1>, <rs2> embedded function call
//
static void emitVSetVLRRRCB(riscvMorphStateP state) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs2   = unpackRX(state, 2);
    Uns32       dBits = 32;

    // call function (may cause exception for invalid SEW)
    vmiCallFn cb = handleVSetVLArg1(state);
    vmimtArgReg(32, rs2.r);
    vmimtCallResultAttrs(cb, dBits, rd.r, VMCA_NO_INVALIDATE);
    writeUnpackedSize(rd, dBits);

    // terminate the block after this instruction because polymorphic state
    // differs from initial state
    vmimtEndBlock();
}

//
// Emit VSetVL <rd>, <rs1>, <vtypei> embedded function call
//
static void emitVSetVLRRCCB(riscvMorphStateP state) {

    unpackedReg rd    = unpackRX(state, 0);
    riscvVType  vtype = state->info.vtype;
    Uns32       dBits = 32;

    // call update function (SEW is known to be valid)
    vmiCallFn cb = handleVSetVLArg1(state);
    vmimtArgUns32(vtype.u.u32);
    vmimtCallResultAttrs(cb, dBits, rd.r, VMCA_NO_INVALIDATE);
    writeUnpackedSize(rd, dBits);

    // terminate the block after this instruction because polymorphic state
    // differs from initial state
    vmimtEndBlock();
}

//
// Implement VSetVL <rd>, <rs1>, <rs2> operation with invalid SEW or LMUL
//
static void emitVSetVLRRCBadSEWLMUL(riscvMorphStateP state) {

    unpackedReg rd    = unpackRX(state, 0);
    riscvVType  vtype = state->info.vtype;
    Uns32       dBits = 32;

    // update using invalid SEW
    vmiCallFn cb = (vmiCallFn)setVLSEWLMUL;

    // use embedded call
    vmimtArgProcessor();
    vmimtArgUns64(0);           // vl (ignored)
    vmimtArgUns32(vtype.u.u32); // vtype
    vmimtCallResultAttrs(cb, dBits, rd.r, VMCA_NO_INVALIDATE);
    writeUnpackedSize(rd, dBits);

    // terminate the block after this instruction because polymorphic state
    // differs from initial state
    vmimtEndBlock();
}

//
// Implement VSetVL <rd>, zero, <rs2> operation using maximum vector length
//
static void emitVSetVLRR0MaxVL(riscvMorphStateP state) {

    riscvP           riscv      = state->riscv;
    riscvBlockStateP blockState = riscv->blockState;
    riscvVType       vtype      = state->info.vtype;
    riscvSEWMt       SEW        = riscvValidVType(riscv, vtype);
    riscvVLMULx8Mt   VLMULx8    = vtypeToVLMULx8(vtype);

    if(
        (blockState->SEWMt     == SEW)   &&
        (blockState->VLMULx8Mt == VLMULx8) &&
        (blockState->VLClassMt == VLCLASSMT_MAX)
    ) {
        // no change to previous state
        unpackedReg rd   = unpackRX(state, 0);
        Uns32       bits = 32;

        // assign result
        vmimtMoveRR(bits, rd.r, CSR_REG_MT(vl));
        writeUnpackedSize(rd, bits);

    } else {

        // update to possibly different configuration
        emitVSetVLRRCCB(state);

        // reset knowledge of registers that have top parts set unless previous
        // configuration had the same VLMUL and was also set to maximum size
        if(
            (blockState->VLClassMt != VLCLASSMT_MAX) ||
            (blockState->VLMULx8Mt != VLMULx8)
        ) {
            blockState->VSetTopMt[VTZ_SINGLE] = 0;
            blockState->VSetTopMt[VTZ_GROUP]  = 0;
        }

        // update morph-time VLClass, SEW and VLMUL, which are now known
        blockState->VLClassMt = VLCLASSMT_MAX;
        blockState->SEWMt     = SEW;
        blockState->VLMULx8Mt = VLMULx8;
    }
}

//
// Implement VSetVL <rd>, zero, <rs2> operation preserving vector length
//
static void emitVSetVLRR0SameVL(riscvMorphStateP state) {

    riscvP           riscv      = state->riscv;
    riscvBlockStateP blockState = riscv->blockState;
    riscvVType       vtype      = state->info.vtype;
    riscvSEWMt       SEW        = riscvValidVType(riscv, vtype);
    riscvVLMULx8Mt   VLMULx8    = vtypeToVLMULx8(vtype);

    if((blockState->SEWMt == SEW) && (blockState->VLMULx8Mt == VLMULx8)) {

        // no change to previous state
        unpackedReg rd   = unpackRX(state, 0);
        Uns32       bits = 32;

        // assign result
        vmimtMoveRR(bits, rd.r, CSR_REG_MT(vl));
        writeUnpackedSize(rd, bits);

    } else {

        // update to different configuration
        emitVSetVLRRCCB(state);
    }
}

//
// Implement VSetVL <rd>, <rs1>, <rs2> operation
//
static RISCV_MORPH_FN(emitVSetVLRRR) {

    // this instruction updates vtype and vl
    emitUpdateVTypeVL(state);

    // emit VSetVL <rd>, <rs1>, <rs2> embedded function call
    emitVSetVLRRRCB(state);

    // zero vstart register on instruction completion
    setVStartZero(state);
}

//
// Implement VSetVL <rd>, <rs1>, <vtypei> operation
//
static RISCV_MORPH_FN(emitVSetVLRRC) {

    riscvP      riscv   = state->riscv;
    riscvVType  vtype   = state->info.vtype;
    riscvSEWMt  SEW     = riscvValidVType(riscv, vtype);
    setVLOption option  = getSetVLOption(state);

    // this instruction updates vtype and vl
    emitUpdateVTypeVL(state);

    if(!SEW) {

        // update using invalid SEW or LMUL
        emitVSetVLRRCBadSEWLMUL(state);

    } else if(option==SVT_SET) {

        // update to unknown vector length
        emitVSetVLRRCCB(state);

    } else if(option==SVT_MAX) {

        // update to maximum vector length
        emitVSetVLRR0MaxVL(state);

    } else {

        // update preserving vector length
        emitVSetVLRR0SameVL(state);
    }

    // zero vstart register on instruction completion
    setVStartZero(state);
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR MEMORY ACCESS INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Is this an SEW width load/store?
//
inline static Bool isMemBitsSEW(Uns32 memBits) {
    return memBits==-1;
}

//
// Return the memory element size in bits
//
static Uns32 getVMemBits(riscvMorphStateP state, iterDescP id) {

    Uns32 memBits = state->info.memBits;

    if(state->info.isWhole || isMemBitsSEW(memBits)) {
        memBits = id->SEW;
    }

    return memBits;
}

//
// Is the specified SEW/memBits pair legal?
//
inline static Bool legalVMemBits(riscvSEWMt SEW, Uns32 memBits) {
    return memBits<=SEW;
}

//
// Is the number of registers for a whole register operation a power of 2?
//
inline static Bool isRegNumP2(Uns32 regNum) {
    return !(regNum & (regNum-1));
}

//
// Get alignment constraint for vector load/store operations (always aligned)
//
inline static memConstraint getLoadStoreConstraintV(riscvMorphStateP state) {
    return MEM_CONSTRAINT_ALIGNED;
}

//
// Emit checks specific to segment loads/stores
//
static Bool emitVLdStCheckSeg(riscvMorphStateP state, iterDescP id) {

    riscvP riscv = state->riscv;
    Bool   ok    = True;

    if(state->info.isWhole) {

        // no action for whole register loads and stores

    } else if(!riscv->configInfo.Zvlsseg) {

        // Zvlsseg extension not configured
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVLSEG", "Zvlsseg extension not configured");
        ok = False;
    }

    return ok;
}

//
// Emit checks specific to whole register loads/stores
//
static Bool emitVLdStCheckWhole(riscvMorphStateP state, iterDescP id) {

    riscvP       riscv  = state->riscv;
    riscvRegDesc rA     = getRVReg(state, 0);
    Uns32        index  = getRIndex(rA);
    Uns32        regNum = getEMULxNF(state, id, 0);
    Bool         ok     = True;

    if(!state->info.isWhole) {

        // no action unless whole register load or store

    } else if((regNum!=1) && vectorRestrictVLSR1(riscv)) {

        // nf!=1 is not supported
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVNF", "Illegal register count (must be 1)");
        ok = False;

    } else if(!vectorRestrictVLSRP2(riscv)) {

        // registers not constrained

    } else if(!isRegNumP2(regNum)) {

        // illegal register number
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVNF", "Illegal register count (must be power of 2)");
        ok = False;

    } else if(index & (regNum-1)) {

        // illegal register number
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVRA", "Illegal unaligned register group");
        ok = False;
    }

    return ok;
}

//
// Operation-specific argument checks for loads and stores
//
static RISCV_CHECKV_FN(emitVLdStCheckCB) {

    riscvP     riscv   = state->riscv;
    Uns32      memBits = getVMemBits(state, id);
    riscvSEWMt EEW     = getEEW(id, 0);
    Bool       ok      = True;

    if(!legalVMemBits(EEW, memBits)) {

        // Illegal Instruction for invalid EEW/memBits combination
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IMB", "EEW < memory element bits");
        ok = False;

    } else if(state->info.isFF && vectorNoFaultOnlyFirst(riscv)) {

        // Illegal Instruction if fault-only-first not implemented
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IFF", "Fault-only-first not implemented");
        ok = False;

    } else if(!state->info.nf) {

        // no action if only one field

    } else if(!emitVLdStCheckSeg(state, id)) {

        // segment loads/store check failed
        ok = False;

    } else if(!emitVLdStCheckWhole(state, id)) {

        // whole register loads/store check failed
        ok = False;

    } else if(getEMULxNF(state, id, 0)>8) {

        // VLMUL*NFIELDS must not exceed 8 for load/store segment instructions
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVLMUL", "Illegal VLMUL*NFIELDS>8");
        ok = False;

    } else if(!legalEMULxNFIndex(state, id, 0)) {

        // register indices must not wrap
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVWRAP", "Illegal vector index wrap-around");
        ok = False;
    }

    return ok;
}

//
// Additional operation-specific argument checks for strided loads and stores
//
static RISCV_CHECKV_FN(stridedVLdStOk) {

    riscvP riscv = state->riscv;
    Bool   ok    = True;

    if(unitStrideOnly(riscv)) {

        // non-unit-stride loads and stores not supported
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "UVI", "Unimplemented instruction");
        ok = False;
    }

    return ok;
}

//
// Additional operation-specific argument checks for indexed loads and stores
//
static RISCV_CHECKV_FN(indexedVLdStOk) {

    riscvP     riscv     = state->riscv;
    riscvSEWMt EEW_index = getEEW(id, 2);
    Bool       ok        = True;

    if(unitStrideOnly(riscv)) {

        // non-unit-stride loads and stores not supported
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "UVI", "Unimplemented instruction");
        ok = False;

    } else if(EEW_index > riscv->configInfo.EEW_index) {

        // Illegal Instruction if index EEW exceeds EEW_index
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "EEWX", "EEW > maximum index EEW");
        ok = False;
    }

    return ok;
}

//
// Operation-specific argument checks for unit stride loads and stores
//
static RISCV_CHECKV_FN(emitVLdStCheckUCB) {
    return emitVLdStCheckCB(state, id);
}

//
// Operation-specific argument checks for strided loads and stores
//
static RISCV_CHECKV_FN(emitVLdStCheckSCB) {
    return stridedVLdStOk(state, id) && emitVLdStCheckCB(state, id);
}

//
// Operation-specific argument checks for indexed loads and stores
//
static RISCV_CHECKV_FN(emitVLdStCheckXCB) {
    return indexedVLdStOk(state, id) && emitVLdStCheckCB(state, id);
}

//
// Operation-specific argument checks for vmv<n>r.v
//
static RISCV_CHECKV_FN(emitVMVRCheckCB) {

    riscvP       riscv  = state->riscv;
    riscvRegDesc rdA    = getRVReg(state, 0);
    riscvRegDesc rsA    = getRVReg(state, 1);
    Uns32        dIndex = getRIndex(rdA);
    Uns32        sIndex = getRIndex(rsA);
    Uns32        regNum = getEMULxNF(state, id, 0);
    Bool         ok     = True;

    if(!legalEMULxNFIndex(state, id, 0)) {

        // destination register indices must not wrap
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVWRAPD", "Illegal destination vector index wrap-around");
        ok = False;

    } else if(!legalEMULxNFIndex(state, id, 1)) {

        // source register indices must not wrap
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVWRAPS", "Illegal source vector index wrap-around");
        ok = False;

    } else if((dIndex>sIndex) && ((dIndex-sIndex)<regNum)) {

        // illegal destination/source overlap
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVDSOV", "Illegal destination/source vector overlap");
        ok = False;

    } else if(!vectorRestrictVMVR(riscv)) {

        // registers not constrained

    } else if(!isRegNumP2(regNum)) {

        // illegal register number
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVNF", "Illegal register count (must be power of 2)");
        ok = False;

    } else if(dIndex & (regNum-1)) {

        // illegal register number
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVDRA", "Illegal unaligned destination register");
        ok = False;

    } else if(sIndex & (regNum-1)) {

        // illegal register number
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVDRA", "Illegal unaligned source register");
        ok = False;
    }

    return ok;
}

//
// Operation-specific initialization for loads and stores
//
static RISCV_MORPHV_FN(emitVLdStInitCB) {

    riscvP     riscv = state->riscv;
    riscvSEWMt eew   = state->info.eew;

    // validate whole-register load alignment if required
    if(!state->info.isWhole) {
        // not whole-register load/store
    } else if(!state->riscv->configInfo.align_whole) {
        // alignment checking not enabled
    } else if(eew<=id->SEW) {
        // encoded EEW does not exceed effective SEW
    } else {
        unpackedReg ra = unpackRX(state, 1);
        setAddressMaskMT(riscv);
        vmimtTryLoadRC(eew, 0, ra.r, getLoadStoreConstraintV(state));
    }

    // set first-fault active indication if required
    if(state->info.isFF) {
        vmimtMoveRC(8, RISCV_FF, True);
    }
}

//
// Add load/store base to calculated offset
//
static void emitVLdStAddBase(riscvMorphStateP state, iterDescP id, vmiReg ra) {

    unpackedReg rs1    = unpackRX(state, 1);
    Uns32       raBits = rs1.bits;

    vmimtBinopRR(raBits, vmi_ADD, ra, rs1.r, 0);
}

//
// Calculate element offset for unit-stride load/store
//
static vmiReg emitVLdStUOffset(riscvMorphStateP state, iterDescP id) {

    riscvRegDesc rs1A     = getRVReg(state, 1);
    vmiReg       ra       = newTmp(state);
    Uns32        raBits   = getRBits(rs1A);
    Uns32        fieldNum = id->nf+1;
    Uns32        memBits  = getVMemBits(state, id) * fieldNum;
    vmiReg       vstart   = CSR_REG_MT(vstart);
    Uns32        scale    = memBits>>3;
    Uns32        shift    = mulToShiftLeft(scale);

    if(shift==-1) {
        vmimtBinopRRC(raBits, vmi_MUL, ra, vstart, scale, 0);
    } else {
        vmimtBinopRRC(raBits, vmi_SHL, ra, vstart, shift, 0);
    }

    return ra;
}

//
// Calculate element offset for strided load/store
//
static vmiReg emitVLdStSOffset(riscvMorphStateP state, iterDescP id) {

    riscvRegDesc rs1A   = getRVReg(state, 1);
    Uns32        raBits = getRBits(rs1A);
    unpackedReg  rs2    = unpackRX(state, 2);
    vmiReg       ra     = newTmp(state);
    vmiReg       vstart = CSR_REG_MT(vstart);

    vmimtBinopRRR(raBits, vmi_MUL, ra, vstart, rs2.r, 0);

    return ra;
}

//
// Calculate element offset for indexed load/store
//
static vmiReg emitVLdStIOffset(riscvMorphStateP state, iterDescP id) {

    riscvRegDesc rs1A    = getRVReg(state, 1);
    Uns32        raBits  = getRBits(rs1A);
    vmiReg       ra      = newTmp(state);
    riscvSEWMt   EEW     = getEEW(id, 2);
    Uns32        iBits   = (EEW<raBits) ? EEW : raBits;
    Bool         sExtend = riscvVFSupport(state->riscv, RVVF_SEXT_IOFFSET);

    vmimtMoveExtendRR(raBits, ra, iBits, id->r[2], sExtend);

    return ra;
}

//
// Per-element callback for generic vector element load
//
static void emitVLdInt(riscvMorphStateP state, iterDescP id, vmiReg ra) {

    Uns32     memBits  = getVMemBits(state, id);
    Uns32     memBytes = memBits/8;
    vmiLabelP skip     = state->info.isFF ? vmimtNewLabel() : 0;
    Uns32     i;

    // add base
    emitVLdStAddBase(state, id, ra);

    for(i=0; i<=id->nf; i++) {

        riscvSEWMt EEW   = getEEW(id, 0);
        vmiReg     vd    = getSegmentRegisterV0(state, id, i);
        vmiReg     vdTmp = skip ? newTmp(state) : vd;

        // do load (either directly to result location or to temporary)
        emitLoadCommonMBO(
            state,
            vdTmp,
            EEW,
            ra,
            memBits,
            memBytes*i,
            getLoadStoreConstraintV(state)
        );

        // for a fault-only-first load, only commit the value if no fault
        if(skip) {
            vmimtCondJumpLabel(RISCV_FF, False, skip);
            vmimtMoveRR(EEW, vd, vdTmp);
            freeTmp(state);
        }
    }

    // here if aborted because of fault-only-first failure
    if(skip) {
        vmimtInsertLabel(skip);
    }
}

//
// Per-element callback for generic vector element store
//
static void emitVStInt(riscvMorphStateP state, iterDescP id, vmiReg ra) {

    Uns32 memBits  = getVMemBits(state, id);
    Uns32 memBytes = memBits/8;
    Uns32 i;

    // add base
    emitVLdStAddBase(state, id, ra);

    for(i=0; i<=id->nf; i++) {

        vmiReg vs = getSegmentRegisterV0(state, id, i);

        // do store
        emitStoreCommonMBO(
            state,
            vs,
            ra,
            memBits,
            memBytes*i,
            getLoadStoreConstraintV(state)
        );
    }
}

//
// Per-element callback for unit-stride loads
//
static RISCV_MORPHV_FN(emitVLdUCB) {
    emitVLdInt(state, id, emitVLdStUOffset(state, id));
}

//
// Per-element callback for unit-stride stores
//
static RISCV_MORPHV_FN(emitVStUCB) {
    emitVStInt(state, id, emitVLdStUOffset(state, id));
}

//
// Per-element callback for strided loads
//
static RISCV_MORPHV_FN(emitVLdSCB) {
    emitVLdInt(state, id, emitVLdStSOffset(state, id));
}

//
// Per-element callback for strided stores
//
static RISCV_MORPHV_FN(emitVStSCB) {
    emitVStInt(state, id, emitVLdStSOffset(state, id));
}

//
// Per-element callback for indexed loads
//
static RISCV_MORPHV_FN(emitVLdICB) {
    emitVLdInt(state, id, emitVLdStIOffset(state, id));
}

//
// Per-element callback for indexed stores
//
static RISCV_MORPHV_FN(emitVStICB) {
    emitVStInt(state, id, emitVLdStIOffset(state, id));
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR ATOMIC MEMORY OPERATIONS
////////////////////////////////////////////////////////////////////////////////

//
// Do vector AMO SEW checks
//
static Bool doVAMOCheck(riscvMorphStateP state, iterDescP id, Bool verbose) {

    riscvP     riscv   = state->riscv;
    Uns32      XLEN    = riscvGetXlenMode(riscv);
    Uns32      memBits = getVMemBits(state, id);
    riscvSEWMt EEW     = getEEW(id, 3);
    Bool       ok      = True;

    if(!legalVMemBits(EEW, memBits)) {

        // Illegal Instruction if SEW < memory element bits
        if(verbose) {
            ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IMB", "EEW < memory element bits");
        }

        ok = False;

    } else if(memBits < 32) {

        // Illegal Instruction if SEW < 32 (minimum supported in base)
        if(verbose) {
            ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IMB", "memory element bits < 32");
        }

        ok = False;

    } else if(EEW > XLEN) {

        // Illegal Instruction if EEW > XLEN
        if(verbose) {
            ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IXL", "EEW > XLEN");
        }

        ok = False;
    }

    return ok;
}

//
// Operation-specific argument checks for vector atomic memory operations
//
static RISCV_CHECKV_FN(emitVAMOCheckCB) {

    riscvP riscv = state->riscv;
    Bool   ok    = doVAMOCheck(state, id, True);

    if(ok && !riscv->configInfo.Zvamo) {
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVAMO", "Zvamo extension not configured");
        ok = False;
    }

    return ok;
}

//
// Atomic memory operation (vector arguments)
//
static void emitVAMOCommonRRR(
    riscvMorphStateP state,
    iterDescP        id,
    amoCB            opCB,
    atomicCode       code
) {
    if(doVAMOCheck(state, id, False)) {

        vmiReg     ra  = emitVLdStIOffset(state, id);
        riscvSEWMt EEW = getEEW(id, 3);

        emitVLdStAddBase(state, id, ra);

        emitAMOCommonInt(state, opCB, id->r[0], id->r[3], ra, EEW, code);
    }
}

//
// Atomic memory operation using defined VMI binop
//
static RISCV_MORPHV_FN(emitVAMOBinopRRR) {
    emitVAMOCommonRRR(state, id, emitAMOBinopRRRCB, getBinopAtomicCode(state));
}

//
// Atomic memory operation using swap
//
static RISCV_MORPHV_FN(emitVAMOSwapRRR) {
    emitVAMOCommonRRR(state, id, emitAMOSwapRRRCB, ACODE_SWAP);
}


////////////////////////////////////////////////////////////////////////////////
// PREDICATE OPERATIONS
////////////////////////////////////////////////////////////////////////////////

//
// Emit code to extract the LSB of the current element of the given predicate
// register to a byte-sized result register
//
static void getPaLSB(iterDescP id, vmiReg Pa, vmiReg lsb) {

    if(id->MLEN>=8) {

        // extract least significant bit of byte
        vmimtBinopRRC(8, vmi_AND, lsb, Pa, 1, 0);

    } else {

        // get mask register
        vmiReg activeMask = RISCV_VACTIVE_MASK;

        // test active bit of byte
        vmimtTestRR(8, vmi_COND_NZ, Pa, activeMask, lsb);
    }
}

//
// Emit code to write the current field in a predicate register with the flag
//
static void writePdLSB(iterDescP id, vmiReg Pd, vmiReg lsb, vmiReg t) {

    if(id->MLEN>=8) {

        // extend to mask element size
        vmimtMoveExtendRR(id->MLEN, Pd, 8, lsb, False);

    } else {

        // get mask registers
        vmiReg predMask   = RISCV_VPRED_MASK;
        vmiReg activeMask = RISCV_VACTIVE_MASK;

        // update field within mask byte
        vmimtUnopRR(8, vmi_NEG, t, lsb, 0);
        vmimtBinopRR(8, vmi_AND, t, activeMask, 0);
        vmimtBinopRR(8, vmi_AND, Pd, predMask, 0);
        vmimtBinopRR(8, vmi_OR, Pd, t, 0);
    }
}

//
// Emit code to write the current field in a predicate register with the value
//
static void writePdField(iterDescP id, vmiReg Pd, vmiReg Ps) {

    if(id->MLEN>=8) {

        // extend single bit to mask element size
        vmimtBinopRRC(id->MLEN, vmi_AND, Pd, Ps, 1, 0);

    } else {

        // get mask register
        vmiReg predMask   = RISCV_VPRED_MASK;
        vmiReg activeMask = RISCV_VACTIVE_MASK;

        // update field within mask byte with single-bit result
        vmimtBinopRR(8, vmi_AND, Ps, activeMask, 0);
        vmimtBinopRR(8, vmi_AND, Pd, predMask, 0);
        vmimtBinopRR(8, vmi_OR, Pd, Ps, 0);
    }
}

//
// Per-element callback for mask binary operations
//
static RISCV_MORPHV_FN(emitMBinaryCB) {

    vmiReg t0   = newTmp(state);
    Uns32  bits = (id->MLEN>=8) ? id->MLEN : 8;

    prepareMasks(state, id, t0, True, True);

    vmimtBinopRRR(bits, state->attrs->binop, t0, id->r[1], id->r[2], 0);

    writePdField(id, id->r[0], t0);
}

//
// Seed vector operation GPR result register
//
static void seedXd(riscvMorphStateP state, iterDescP id, Int32 c) {

    riscvP       riscv = state->riscv;
    riscvRegDesc rdA   = getRVReg(state, 0);
    Uns32        bits  = getRBits(rdA);

    // initialize target register count
    vmimtMoveRC(bits, id->r[0], c);
    writeReg(riscv, rdA);
}

//
// Initialization callback for VPOPC
//
static RISCV_CHECKV_FN(initVPOPCCB) {
    seedXd(state, id, 0);
    return True;
}

//
// Per-element callback for VPOPC
//
static RISCV_MORPHV_FN(emitVPOPCCB) {

    riscvP       riscv = state->riscv;
    riscvRegDesc rdA   = getRVReg(state, 0);
    Uns32        bits  = getRBits(rdA);
    vmiReg       t0    = newTmp(state);

    // prepare active mask
    prepareMasks(state, id, t0, False, True);

    // extract mask element LSB
    getPaLSB(id, id->r[1], t0);

    // extend to result size
    vmimtMoveExtendRR(bits, t0, 8, t0, False);

    // add to cumulative count
    vmimtBinopRR(bits, vmi_ADD, id->r[0], t0, 0);
    writeReg(riscv, rdA);
}

//
// Initialization callback for VFIRST
//
static RISCV_CHECKV_FN(initVFIRSTCB) {
    seedXd(state, id, -1);
    return True;
}

//
// Per-element callback for VFIRST
//
static RISCV_MORPHV_FN(emitVFIRSTCB) {

    riscvP       riscv = state->riscv;
    riscvRegDesc rdA   = getRVReg(state, 0);
    Uns32        bits  = getRBits(rdA);
    vmiReg       t0    = newTmp(state);
    vmiLabelP    skip  = vmimtNewLabel();

    // go if result has been found
    vmimtCompareRCJumpLabel(bits, vmi_COND_NE, id->r[0], -1, skip);

    // prepare active mask
    prepareMasks(state, id, t0, False, True);

    // extract mask element LSB
    getPaLSB(id, id->r[1], t0);

    // go if LSB is zero
    vmimtCompareRCJumpLabel(8, vmi_COND_EQ, t0, 0, skip);

    // record current index
    vmimtMoveRR(bits, id->r[0], CSR_REG_MT(vstart));
    writeReg(riscv, rdA);

    // here if result already found
    vmimtInsertLabel(skip);
}

//
// Initialization callback for VMSBF/VMSIF/VMSOF
//
static RISCV_MORPHV_FN(initVMSFCB) {
    vmimtMoveRC(8, RISCV_VTMP, 1);
}

//
// Per-element callback for VMSBF
//
static RISCV_MORPHV_FN(emitVMSBFCB) {

    vmiReg t0     = newTmp(state);
    vmiReg t1     = newTmp(state);
    vmiReg mState = RISCV_VTMP;

    // prepare active mask
    prepareMasks(state, id, t0, True, True);

    // extract mask element LSB
    getPaLSB(id, id->r[1], t0);

    // combine with active state
    vmimtBinopRR(8, vmi_ANDN, mState, t0, 0);

    // update field with new mask state
    writePdLSB(id, id->r[0], mState, t1);
}

//
// Per-element callback for VMSIF
//
static RISCV_MORPHV_FN(emitVMSIFCB) {

    vmiReg t0     = newTmp(state);
    vmiReg t1     = newTmp(state);
    vmiReg mState = RISCV_VTMP;

    // prepare active mask
    prepareMasks(state, id, t0, True, True);

    // extract mask element LSB
    getPaLSB(id, id->r[1], t0);

    // update field with new mask state
    writePdLSB(id, id->r[0], mState, t1);

    // combine with active state
    vmimtBinopRR(8, vmi_ANDN, mState, t0, 0);
}

//
// Per-element callback for VMSOF
//
static RISCV_MORPHV_FN(emitVMSOFCB) {

    vmiReg t0     = newTmp(state);
    vmiReg t1     = newTmp(state);
    vmiReg mState = RISCV_VTMP;

    // prepare active mask
    prepareMasks(state, id, t0, True, True);

    // extract mask element LSB
    getPaLSB(id, id->r[1], t0);

    // combine with active state
    vmimtBinopRR(8, vmi_AND, t0, mState, 0);

    // update field with new mask state
    writePdLSB(id, id->r[0], t0, t1);

    // combine with active state
    vmimtBinopRR(8, vmi_ANDN, mState, t0, 0);
}

//
// Initialization callback for VIOTA/VID
//
static RISCV_MORPHV_FN(initVIOTACB) {
    vmimtMoveRR(id->SEW, RISCV_VTMP, CSR_REG_MT(vstart));
}

//
// Per-element callback for VIOTA
//
static RISCV_MORPHV_FN(emitVIOTACB) {

    vmiReg t0     = newTmp(state);
    vmiReg mState = RISCV_VTMP;

    // set element with previously-accumulated result
    vmimtMoveRR(id->SEW, id->r[0], mState);

    // prepare active mask
    prepareMasks(state, id, t0, False, True);

    // extract mask element LSB
    getPaLSB(id, id->r[1], t0);

    // extend to element width
    vmimtMoveExtendRR(id->SEW, t0, 8, t0, False);

    // add to accumulated result
    vmimtBinopRR(id->SEW, vmi_ADD, mState, t0, 0);
}

//
// Per-element callback for VID
//
static RISCV_MORPHV_FN(emitVIDCB) {

    // set element index
    vmimtMoveRR(id->SEW, id->r[0], CSR_REG_MT(vstart));
}


////////////////////////////////////////////////////////////////////////////////
// IMPLICIT CARRY OPERATIONS
////////////////////////////////////////////////////////////////////////////////

//
// Context for flag extraction and assignment
//
typedef struct carryCxtS {
    vmiFlags     flags;
    riscvRegDesc carryIn;
} carryCxt, *carryCxtP;

//
// Emit code to initialize implicit vector carry-in context
//
static void getVCarryIn(riscvMorphStateP state, iterDescP id, carryCxtP cxt) {

    riscvRegDesc mask = state->info.mask;
    vmiReg       t0   = newTmp(state);
    vmiReg       cin  = mask ? t0 : VMI_NOREG;

    // prepare predicate and active masks
    prepareMasks(state, id, t0, True, True);

    // initialize flags in context
    vmiFlags flags = {cin:cin, f:{[vmi_CF]=t0}};
    cxt->flags = flags;

    // initialize carry-in if required
    if(mask) {

        // start indexed access to carry input register
        vmiReg carry = accessMaskField(state, id, mask);

        // extract mask element LSB
        getPaLSB(id, carry, flags.cin);
    }
}

//
// Emit code to write vector carry-out
//
static void setVCarryOut(riscvMorphStateP state, iterDescP id, carryCxtP cxt) {

    if(id->PdA) {

        vmiReg flag = cxt->flags.f[vmi_CF];
        vmiReg Pd   = accessMaskField(state, id, id->PdA);

        writePdLSB(id, Pd, flag, flag);
    }
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR COMPARE OPERATIONS
////////////////////////////////////////////////////////////////////////////////

//
// Context for flag extraction and assignment
//
typedef struct cmpCxtS {
    vmiReg flag;
    vmiReg Pd;
} cmpCxt, *cmpCxtP;

//
// Emit code to start compare operation
//
static void startCompare(riscvMorphStateP state, iterDescP id, cmpCxtP cxt) {

    vmiReg t0 = newTmp(state);

    // prepare predicate and active masks
    prepareMasks(state, id, t0, True, True);

    cxt->flag = t0;
    cxt->Pd   = accessMaskField(state, id, id->PdA);
}

//
// Emit code to complete compare operation
//
static void endCompare(iterDescP id, cmpCxtP cxt) {

    vmiReg flag = cxt->flag;

    writePdLSB(id, cxt->Pd, flag, flag);
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR INTEGER INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Per-element callback for merge (if unmasked or mask=1), register arg2
//
static RISCV_MORPHV_FN(emitVRMERGETCB) {

    vmimtMoveRR(id->SEW, id->r[0], id->r[2]);
}

//
// Per-element callback for merge (if unmasked or mask=1), constant arg2
//
static RISCV_MORPHV_FN(emitVIMERGETCB) {

    vmimtMoveRC(id->SEW, id->r[0], state->info.c);
}

//
// Per-element callback for merge (if masked and mask=0)
//
static RISCV_MORPHV_FN(emitVRMERGEFCB) {

    vmimtMoveRR(id->SEW, id->r[0], id->r[1]);
}

//
// Per-element callback for integer instructions with one register operand
//
static RISCV_MORPHV_FN(emitVRUnaryIntCB) {

    vmimtUnopRR(id->SEW, state->attrs->unop, id->r[0], id->r[1], 0);
}

//
// Per-element callback for integer instructions with two register operands
//
static RISCV_MORPHV_FN(emitVRBinaryIntCB) {

    vmiReg arg2 = id->r[2];

    vmimtBinopRRR(id->SEW, state->attrs->binop, id->r[0], id->r[1], arg2, 0);
}

//
// Per-element callback for integer instructions with register and constant
// operands
//
static RISCV_MORPHV_FN(emitVIBinaryIntCB) {

    Uns64 arg2 = state->info.c;

    vmimtBinopRRC(id->SEW, state->attrs->binop, id->r[0], id->r[1], arg2, 0);
}

//
// Per-element callback for integer instructions with two register operands with
// implicit carry in mask format from v0
//
static RISCV_MORPHV_FN(emitVRAdcIntCB) {

    vmiReg   arg2 = id->r[2];
    vmiReg   Vd   = id->PdA ? VMI_NOREG : id->r[0];
    carryCxt cxt;

    getVCarryIn(state, id, &cxt);

    vmimtBinopRRR(id->SEW, state->attrs->binop, Vd, id->r[1], arg2, &cxt.flags);

    setVCarryOut(state, id, &cxt);
}

//
// Per-element callback for integer instructions with register and constant
// operands with implicit carry in mask format from v0
//
static RISCV_MORPHV_FN(emitVIAdcIntCB) {

    Uns64    arg2 = state->info.c;
    vmiReg   Vd   = id->PdA ? VMI_NOREG : id->r[0];
    carryCxt cxt;

    getVCarryIn(state, id, &cxt);

    vmimtBinopRRC(id->SEW, state->attrs->binop, Vd, id->r[1], arg2, &cxt.flags);

    setVCarryOut(state, id, &cxt);
}

//
// Per-element callback for integer compare instructions with two register
// operands
//
static RISCV_MORPHV_FN(emitVRCmpIntCB) {

    vmiReg arg2 = id->r[2];
    cmpCxt cxt;

    // emit code to start compare operation
    startCompare(state, id, &cxt);

    // do compare, setting temporary flag
    vmimtCompareRR(id->SEW, state->attrs->cond, id->r[1], arg2, cxt.flag);

    // emit code to complete compare operation
    endCompare(id, &cxt);
}

//
// Per-element callback for integer compare instructions with register and
// constant operands
//
static RISCV_MORPHV_FN(emitVICmpIntCB) {

    Uns64  arg2 = state->info.c;
    cmpCxt cxt;

    // emit code to start compare operation
    startCompare(state, id, &cxt);

    // do compare, setting temporary flag
    vmimtCompareRC(id->SEW, state->attrs->cond, id->r[1], arg2, cxt.flag);

    // emit code to complete compare operation
    endCompare(id, &cxt);
}

//
// Per-element callback for shift instructions with register and constant
// operands
//
static RISCV_MORPHV_FN(emitVIShiftIntCB) {

    Uns32 bits  = id->SEW;
    Uns32 shift = state->info.c & (bits-1);

    if(shift) {

        // non-zero shift
        vmimtBinopRRC(bits, state->attrs->binop, id->r[0], id->r[1], shift, 0);

    } else {

        // zero shift
        vmimtMoveRR(bits, id->r[0], id->r[1]);
    }
}

//
// Operation-specific argument checks for wide multiply operands that are
// illegal on embedded profiles
//
static RISCV_CHECKV_FN(emitNoEmbEEW64CB) {

    riscvP riscv = state->riscv;
    Bool   ok    = (id->SEW<=SEWMT_32) || !(riscv->configInfo.vect_profile&RVVS_Embedded);

    if(id->SEW<=SEWMT_32) {
        // SEW up to 32 is allowed
    } else if(!(riscv->configInfo.vect_profile&RVVS_Embedded)) {
        // wider SEW with application profile is allowed
    } else {
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IVEPE", "Illegal when EEW>32");
        ok = False;
    }

    return ok;
}

//
// Common per-element callback for integer MULH instructions
//
static void emitVRMulHIntInt(
    riscvMorphStateP state,
    iterDescP        id,
    vmiReg           rdl,
    vmiReg           rdh
) {
    vmiReg arg1 = id->r[1];
    vmiReg arg2 = id->r[2];

    // do double-width multiply, preserving top half
    vmimtMulopRRR(id->SEW, state->attrs->binop, rdh, rdl, arg1, arg2, 0);
}

//
// Per-element callback for single-width integer MULH instructions
//
static RISCV_MORPHV_FN(emitVRMulHIntCB) {

    vmiReg rdl = VMI_NOREG;
    vmiReg rdh = id->r[0];

    emitVRMulHIntInt(state, id, rdl, rdh);
}

//
// Per-element callback for widening integer MULH instructions
//
static RISCV_MORPHV_FN(emitVRWMulHIntCB) {

    vmiReg rdl = id->r[0];
    vmiReg rdh = VMI_REG_DELTA(rdl, id->SEW/8);

    emitVRMulHIntInt(state, id, rdl, rdh);
}

//
// Per-element callback for integer multiply-add instructions
//
static void emitVRMAddIntInt(
    riscvMorphStateP state,
    iterDescP        id,
    Uns32            arg1Index,
    Uns32            arg2Index,
    Uns32            arg3Index
) {
    vmiBinop mulop = isAnyVArgSigned(state) ? vmi_IMUL : vmi_MUL;
    vmiReg   arg1  = id->r[arg1Index];
    vmiReg   arg2  = id->r[arg2Index];
    vmiReg   arg3  = id->r[arg3Index];
    vmiReg   t0    = newTmp(state);

    // do multiply
    vmimtBinopRRR(id->SEW, mulop, t0, arg2, arg3, 0);

    // do add/subtract
    vmimtBinopRRR(id->SEW, state->attrs->binop, id->r[0], arg1, t0, 0);
}

//
// Per-element callback for multiply-add instructions overwriting multiplicand
//
static RISCV_MORPHV_FN(emitVRMAddIntCB) {
    emitVRMAddIntInt(state, id, 2, 0, 1);
}

//
// Per-element callback for multiply-add instructions overwriting addend/minuend
//
static RISCV_MORPHV_FN(emitVRMAccIntCB) {
    emitVRMAddIntInt(state, id, 0, 2, 1);
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR FIXED POINT ROUNDING UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Fixed point rounding modes
//
typedef enum vxrmE {
    VXRM_RNU,   // round-to-nearest-up
    VXRM_RNE,   // round-to-nearest-even
    VXRM_RDN,   // round-down (truncate)
    VXRM_ROD,   // round-to-odd (jam)
} vxrm;

//
// Define function returning fixed-point rounding adjustment for result of the
// given bit size
//
#define FPRM_FUNC(_NAME, _BITS) Uns##_BITS _NAME(           \
    Uns32      fprm,                                        \
    Uns##_BITS result,                                      \
    Uns##_BITS discard                                      \
) {                                                         \
    Uns##_BITS msbMask = 1ULL<<((_BITS)-1);                 \
    Bool       vd      = result & 1;                        \
    Bool       vdm1    = discard & msbMask;                 \
    Bool       round;                                       \
                                                            \
    switch(fprm) {                                          \
        case VXRM_RNU:                                      \
            round = vdm1;                                   \
            break;                                          \
        case VXRM_RNE:                                      \
            round = (discard==msbMask) ? vd : vdm1;         \
            break;                                          \
        case VXRM_RDN:                                      \
            round = 0;                                      \
            break;                                          \
        case VXRM_ROD:                                      \
            round = !vd && discard;                         \
            break;                                          \
        default:                                            \
            VMI_ABORT("Unexpected rounding mode %u", fprm); \
            break;                                          \
    }                                                       \
                                                            \
    return round;                                           \
}

//
// Define rounding adjustment functions
//
static FPRM_FUNC(getRound8,  8)
static FPRM_FUNC(getRound16, 16)
static FPRM_FUNC(getRound32, 32)
static FPRM_FUNC(getRound64, 64)

//
// Return fixed-point rounding adjustment function for result of the given bit
// size
//
static vmiCallFn getRoundCB(Uns32 bits) {

    void *result = 0;

    switch(bits) {
        case 8:
            result = getRound8;
            break;
        case 16:
            result = getRound16;
            break;
        case 32:
            result = getRound32;
            break;
        case 64:
            result = getRound64;
            break;
        default:
            VMI_ABORT("Unexpected bits %u", bits);  // LCOV_EXCL_LINE
    }

    return result;
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR FIXED POINT ARITHMETIC INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Emit code to get the fixed point rounding adjustment to apply in 'discard'
//
static void emitGetFixedPointRoundingAdjust(
    iterDescP id,
    vmiReg    rd,
    vmiReg    discard
) {
    Uns32 bits = id->SEW;

    vmimtArgReg(32, CSR_REG_MT(vxrm));
    vmimtArgReg(bits, rd);
    vmimtArgReg(bits, discard);
    vmimtCallResultAttrs(getRoundCB(bits), bits, discard, VMCA_PURE);
}

//
// Emit code to round result in rd using discarded bits in discard using the
// current fixed point rounding mode
//
static void emitFixedPointRounding(
    riscvMorphStateP state,
    iterDescP        id,
    vmiReg           rd,
    vmiReg           discard
) {
    // get rounding amount to add
    emitGetFixedPointRoundingAdjust(id, rd, discard);

    // do addition of rounding amount
    vmimtBinopRR(id->SEW, vmi_ADD, rd, discard, 0);
}

//
// Per-element callback for saturating instructions with two register operands
//
static RISCV_MORPHV_FN(emitVRSBinaryCB) {

    vmiReg     arg2  = id->r[2];
    vmiFlagsCP flags = getVSatFlags(state);

    // do saturating operation
    vmimtBinopRRR(id->SEW, state->attrs->binop, id->r[0], id->r[1], arg2, flags);

    // merge saturation flag with sticky vxsat
    updateVXSat(state);
}

//
// Per-element callback for saturating instructions with register and constant
// operands
//
static RISCV_MORPHV_FN(emitVISBinaryCB) {

    Uns64      arg2  = state->info.c;
    vmiFlagsCP flags = getVSatFlags(state);

    // do saturating operation
    vmimtBinopRRC(id->SEW, state->attrs->binop, id->r[0], id->r[1], arg2, flags);

    // merge saturation flag with sticky vxsat
    updateVXSat(state);
}

//
// Per-element callback for averaging instructions with two register operands
//
static RISCV_MORPHV_FN(emitVRABinaryCB) {

    vmiReg arg2 = id->r[2];
    vmiReg t0   = newTmp(state);
    Uns32  bits = id->SEW;

    // extract discard bits
    vmimtBinopRRR(bits, vmi_XOR, t0, id->r[1], arg2, 0);
    vmimtBinopRC(bits, vmi_AND, t0, 1, 0);
    vmimtBinopRC(bits, vmi_ROR, t0, 1, 0);

    // do averaging operation
    vmimtBinopRRR(bits, state->attrs->binop, id->r[0], id->r[1], arg2, 0);

    // do fixed point rounding
    emitFixedPointRounding(state, id, id->r[0], t0);
}

//
// Per-element callback for averaging instructions with register and constant
// operands
//
static RISCV_MORPHV_FN(emitVIABinaryCB) {

    Uns64  arg2 = state->info.c;
    vmiReg t0   = newTmp(state);
    Uns32  bits = id->SEW;

    // extract discard bits
    vmimtBinopRRC(bits, vmi_XOR, t0, id->r[1], arg2, 0);
    vmimtBinopRC(bits, vmi_AND, t0, 1, 0);
    vmimtBinopRC(bits, vmi_ROR, t0, 1, 0);

    // do averaging operation
    vmimtBinopRRC(bits, state->attrs->binop, id->r[0], id->r[1], arg2, 0);

    // do fixed point rounding
    emitFixedPointRounding(state, id, id->r[0], t0);
}

//
// Per-element callback for rounding shift instructions with two register
// operands
//
static RISCV_MORPHV_FN(emitVRRShiftIntCB) {

    Uns32     bits  = id->SEW;
    vmiReg    arg2  = id->r[2];
    vmiReg    shr   = newTmp(state);
    vmiReg    trd   = newTmp(state);
    vmiReg    shl   = newTmp(state);
    vmiReg    zero  = shl;
    vmiLabelP done  = vmimtNewLabel();
    vmiFlags  flags = {f:{[vmi_ZF]=zero}};

    // assume shift is zero initially
    vmimtMoveRR(bits, trd, id->r[1]);

    // calculate shift and jump if zero
    vmimtBinopRRC(bits, vmi_AND, shr, arg2, bits-1, &flags);
    vmimtCondJumpLabel(zero, True, done);

    // extract discard bits
    vmimtBinopRCR(bits, vmi_SUB, shl, bits, shr, 0);
    vmimtBinopRRR(bits, vmi_SHL, shl, trd, shl, 0);

    // do shift
    vmimtBinopRR(bits, state->attrs->binop, trd, shr, 0);

    // do fixed point rounding
    emitFixedPointRounding(state, id, trd, shl);

    // here if shift is zero
    vmimtInsertLabel(done);

    // commit result
    vmimtMoveRR(bits, id->r[0], trd);
}

//
// Per-element callback for rounding shift instructions with register and
// constant operands
//
static RISCV_MORPHV_FN(emitVIRShiftIntCB) {

    Uns32 bits = id->SEW;
    Uns32 shr  = state->info.c & (bits-1);
    Uns32 shl  = bits - shr;

    if(shr) {

        vmiReg t0 = newTmp(state);

        // extract discard bits
        vmimtBinopRRC(bits, vmi_SHL, t0, id->r[1], shl, 0);

        // do shift
        vmimtBinopRRC(bits, state->attrs->binop, id->r[0], id->r[1], shr, 0);

        // do fixed point rounding
        emitFixedPointRounding(state, id, id->r[0], t0);

    } else {

        // no shift
        vmimtMoveRR(bits, id->r[0], id->r[1]);
    }
}

//
// Per-element callback for single-width fractional multiply with rounding and
// saturation
//
static RISCV_MORPHV_FN(emitVRSMULCB) {

    vmiReg     arg2  = id->r[2];
    vmiReg     t1    = newTmp(state);
    vmiReg     t2    = newTmp(state);
    vmiFlagsCP flags = getVSatFlags(state);
    Uns32      bits  = id->SEW;

    // produce 2*SEW-width result
    vmimtMulopRRR(bits, state->attrs->binop, id->r[0], t1, id->r[1], arg2, 0);

    // shift result left one place with saturation
    vmimtBinopRC(bits, vmi_SHLSQ, id->r[0], 1, flags);

    // merge saturation flag with sticky vxsat
    updateVXSat(state);

    // rotate LSW to place retained bit at bit 0 and discard bits at N..1
    vmimtBinopRC(bits, vmi_ROL, t1, 1, 0);

    // merge retained bit with (possibly saturated) result
    vmimtBinopRRC(bits, vmi_AND, t2, t1, 1, 0);
    vmimtBinopRR(bits, vmi_OR, id->r[0], t2, 0);

    // mask discard bits at bits N..1
    vmimtBinopRC(bits, vmi_AND, t1, -2, 0);

    // do fixed point rounding
    emitFixedPointRounding(state, id, id->r[0], t1);
}

//
// Per-element callback for saturating integer multiply-add instructions
//
static void emitVRSMAddIntInt(
    riscvMorphStateP state,
    iterDescP        id,
    Uns32            arg1Index,
    Uns32            arg2Index,
    Uns32            arg3Index
) {
    Bool       isSigned = isAnyVArgSigned(state);
    vmiBinop   mulop    = isSigned ? vmi_IMUL : vmi_MUL;
    vmiBinop   shiftop  = isSigned ? vmi_SAR  : vmi_SHR;
    vmiReg     arg1     = id->r[arg1Index];
    vmiReg     arg2     = id->r[arg2Index];
    vmiReg     arg3     = id->r[arg3Index];
    vmiReg     t0       = newTmp(state);
    vmiReg     t1       = newTmp(state);
    vmiFlagsCP flags    = getVSatFlags(state);
    Uns32      bits     = id->SEW;
    Uns32      rBits    = bits/4;
    Uns32      rMask    = (1<<rBits)-1;

    // do multiply
    vmimtBinopRRR(bits, mulop, t0, arg2, arg3, 0);

    // get discard bits in t1
    vmimtBinopRRC(bits, vmi_AND, t1, t0, rMask, 0);
    vmimtBinopRC(bits, vmi_ROR, t1, rBits, 0);

    // get shifted result in t0
    vmimtBinopRC(bits, shiftop, t0, rBits, 0);

    // do fixed point rounding
    emitFixedPointRounding(state, id, t0, t1);

    // do add/subtract
    vmimtBinopRRR(bits, state->attrs->binop, id->r[0], arg1, t0, flags);

    // merge saturation flag with sticky vxsat
    updateVXSat(state);
}

//
// Per-element callback for saturating multiply-add instructions overwriting
// addend/minuend
//
static RISCV_MORPHV_FN(emitVRSMAccIntCB) {
    emitVRSMAddIntInt(state, id, 0, 2, 1);
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR INTEGER REDUCTION INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Initialization callback for integer reduction operations
//
static RISCV_MORPHV_FN(initVRedCB) {

    vmimtMoveRR(getEEW(id, 2), RISCV_VTMP, id->r[2]);
}

//
// Per-element callback for integer reduction operations
//
static RISCV_MORPHV_FN(emitVRedBinaryIntCB) {

    vmimtBinopRR(getEEW(id, 0), state->attrs->binop, RISCV_VTMP, id->r[1], 0);
}

//
// Finalization callback for integer reduction operations
//
static RISCV_MORPHV_FN(endVRedCB) {

    // set target register
    setTail(state->riscv, id->VLEN, id->r[0]);

    // set element 0 of target register
    vmimtMoveRR(getEEW(id, 0), id->r[0], RISCV_VTMP);
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR FLOATING POINT INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Per-element callback for floating point instructions with one register
// operand
//
static RISCV_MORPHV_FN(emitVRUnaryFltCB) {

    vmiReg        fd   = id->r[0];
    vmiReg        fs1  = id->r[1];
    vmiFType      type = getSEWFType(state, id->SEW);
    vmiFUnop      op   = state->attrs->fpUnop;
    vmiFPConfigCP ctrl = getFPControl(state);

    if(emitSetOperationRM(state)) {
        vmiReg flags = riscvGetFPFlagsMT(state->riscv);
        vmimtFUnopRR(type, op, fd, fs1, flags, ctrl);
    }
}

//
// Common routine for floating point binary operation
//
static void emitVRBinaryFltInt(
    riscvMorphStateP state,
    iterDescP        id,
    Uns32            arg1Index,
    Uns32            arg2Index
) {
    vmiReg        fd   = id->r[0];
    vmiReg        fs1  = id->r[arg1Index];
    vmiReg        fs2  = id->r[arg2Index];
    vmiFType      type = getSEWFType(state, id->SEW);
    vmiFBinop     op   = state->attrs->fpBinop;
    vmiFPConfigCP ctrl = getFPControl(state);

    if(emitSetOperationRM(state)) {
        vmiReg flags = riscvGetFPFlagsMT(state->riscv);
        vmimtFBinopRRR(type, op, fd, fs1, fs2, flags, ctrl);
    }
}

//
// Per-element callback for floating point instructions with two register
// operands
//
static RISCV_MORPHV_FN(emitVRBinaryFltCB) {
    emitVRBinaryFltInt(state, id, 1, 2);
}

//
// Per-element callback for floating point instructions with two reversed
// register operands
//
static RISCV_MORPHV_FN(emitVRBinaryFltRCB) {
    emitVRBinaryFltInt(state, id, 2, 1);
}

//
// Per-element callback for floating point multiply-add instructions
//
static void emitVRMAddFltInt(
    riscvMorphStateP state,
    iterDescP        id,
    Uns32            arg1Index,
    Uns32            arg2Index,
    Uns32            arg3Index
) {
    vmiReg        fd   = id->r[0];
    vmiReg        fs1  = id->r[arg1Index];
    vmiReg        fs2  = id->r[arg2Index];
    vmiReg        fs3  = id->r[arg3Index];
    vmiFType      type = getSEWFType(state, id->SEW);
    vmiFTernop    op   = state->attrs->fpTernop;
    vmiFPConfigCP ctrl = getFPControl(state);

    if(emitSetOperationRM(state)) {
        vmiReg flags = riscvGetFPFlagsMT(state->riscv);
        vmimtFTernopRRRR(type, op, fd, fs1, fs2, fs3, flags, False, ctrl);
    }
}

//
// Per-element callback for multiply-add instructions overwriting multiplicand
//
static RISCV_MORPHV_FN(emitVRMAddFltCB) {
    emitVRMAddFltInt(state, id, 0, 1, 2);
}

//
// Per-element callback for multiply-add instructions overwriting addend/minuend
//
static RISCV_MORPHV_FN(emitVRMAccFltCB) {
    emitVRMAddFltInt(state, id, 2, 1, 0);
}

//
// Implement fsgnj, fsgnjn or fsgnjx operation
//
static RISCV_MORPHV_FN(emitVRFSgnFltCB) {
    emitFSgnInt(state, id->r[0], id->r[1], id->r[2], id->SEW);
}

//
// Implement floating point comparison
//
static RISCV_MORPHV_FN(emitVRFCmpFltCB) {

    vmiReg arg2 = id->r[2];
    cmpCxt cxt;

    // emit code to start compare operation
    startCompare(state, id, &cxt);

    // do compare, setting temporary flag
    emitFCompareInt(state, cxt.flag, id->r[1], arg2, getSEWFType(state, id->SEW));

    // emit code to complete compare operation
    endCompare(id, &cxt);
}

//
// Implement floating point class
//
static RISCV_MORPHV_FN(emitVRFClassFltCB) {

    Uns32 bitsS = id->SEW;
    Uns32 bitsD = (bitsS<=32) ? bitsS : 32;

    emitFClassInt(state->riscv, id->r[0], id->r[1], bitsS, bitsD);
    vmimtMoveExtendRR(bitsS, id->r[0], bitsD, id->r[0], False);
}

//
// Return vmiFType for the indexed argument
//
static vmiFType getVConvertType(
    riscvMorphStateP state,
    iterDescP        id,
    Uns32            argIndex
) {
    riscvVShape vShape = state->attrs->vShape;
    vmiFType    result;

    // get basic operand type
    if(isFloatN(vShape, argIndex)) {
        result = VMI_FT_IEEE_754;
    } else if(isAnyVArgSigned(state)) {
        result = VMI_FT_INT;
    } else {
        result = VMI_FT_UNS;
    }

    // include element width
    result |= getEEW(id, argIndex);

    // use BFLOAT16 type if required
    if((result==vmi_FT_16_IEEE_754) && enableBFLOAT16(state->riscv)) {
    	result = vmi_FT_BFLOAT16;
    }

    return result;
}

//
// Implement floating point convert
//
static RISCV_MORPHV_FN(emitVRConvertFltCB) {

    riscvP        riscv = state->riscv;
    vmiReg        fd    = id->r[0];
    vmiReg        fs    = id->r[1];
    vmiFType      typeD = getVConvertType(state, id, 0);
    vmiFType      typeS = getVConvertType(state, id, 1);
    vmiFPRC       rc    = mapRMDescToRC(state->info.rm);
    vmiFPConfigCP ctrl  = getFPControl(state);
    vmiReg        flags = riscvGetFPFlagsMT(riscv);

    vmimtFConvertRR(typeD, fd, typeS, fs, rc, flags, ctrl);
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR FLOATING POINT REDUCTION INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Per-element callback for floating point reduction operations
//
static RISCV_MORPHV_FN(emitVRedBinaryFltCB) {

    vmiReg        fd   = RISCV_VTMP;
    vmiReg        fs1  = RISCV_VTMP;
    vmiReg        fs2  = id->r[1];
    vmiFType      type = getSEWFType(state, id->SEW);
    vmiFBinop     op   = state->attrs->fpBinop;
    vmiFPConfigCP ctrl = getFPControl(state);

    if(emitSetOperationRM(state)) {
        vmiReg flags = riscvGetFPFlagsMT(state->riscv);
        vmimtFBinopRRR(type, op, fd, fs1, fs2, flags, ctrl);
    }
}


////////////////////////////////////////////////////////////////////////////////
// VECTOR PERMUTATION INSTRUCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Return the minimum of SEW and the bits specified
//
inline static Uns32 getMinBits(iterDescP id, Uns32 rBits) {
    return (id->SEW<rBits) ? id->SEW : rBits;
}

//
// Return the size in bits of a generic operand of a vector instruction
//
static Uns32 getRVBits(riscvMorphStateP state, iterDescP id, Uns32 index) {

    riscvRegDesc rsA = getRVReg(state, index);

    return isVReg(rsA) ? getEEW(id, index) : getRBits(rsA);
}

//
// Implement move to register Vd0 from source Vs1, indexed using index, and
// insert label target if the move should be skipped
//
static void moveIndexedVd0Vs1(
    riscvMorphStateP state,
    iterDescP        id,
    vmiReg           index,
    vmiLabelP        skip
) {
    // initialize source indexed vector register
    getIndexedVRegisterInt(state, id, 1, index);

    // move one element
    vmimtMoveRR(id->SEW, id->r[0], id->r[1]);

    // kill base registers and temporaries
    killBaseRegistersAndTemps(state, id);

    // here if operation was skipped
    if(skip) {
        vmimtInsertLabel(skip);
    }
}

//
// Per-element callback for VEXT.X.V
//
static RISCV_MORPHV_FN(emitVEXTXV) {

    riscvP       riscv   = state->riscv;
    vmiReg       rd      = id->r[0];
    vmiReg       rs1     = id->r[2];
    riscvRegDesc rdA     = getRVReg(state, 0);
    Uns32        rdBits  = getRBits(rdA);
    Uns32        eBits   = getMinBits(id, rdBits);
    Bool         sExtend = vectorSignExtVMVXS(riscv);

    if(VMI_ISNOREG(rs1)) {

        // using x0 as index
        vmimtMoveExtendRR(rdBits, rd, eBits, id->r[1], sExtend);

    } else {

        Uns32      offsetBits = IMPERAS_POINTER_BITS;
        vmiReg     index      = newTmp(state);
        Uns32      VLEN       = id->VLEN;
        riscvSEWMt SEW        = id->SEW;
        Uns32      eNum       = VLEN/SEW;
        Uns32      indexBits  = (offsetBits<rdBits) ? offsetBits : rdBits;
        vmiLabelP  badIndex   = vmimtNewLabel();

        // get element index
        vmimtMoveRR(rdBits, index, rs1);

        // assume zero result is required
        vmimtMoveRC(rdBits, rd, 0);

        // done if index out-of-range
        vmimtCompareRCJumpLabel(rdBits, vmi_COND_NB, index, eNum, badIndex);

        // get indexed source
        vmimtMoveExtendRR(offsetBits, index, indexBits, index, False);
        getIndexedVRegisterInt(state, id, 1, index);

        // get indexed value
        vmimtMoveExtendRR(rdBits, rd, eBits, id->r[1], sExtend);

        // kill base registers and temporaries
        killBaseRegistersAndTemps(state, id);

        // here if index out-of-range
        vmimtInsertLabel(badIndex);
    }

    writeReg(riscv, rdA);
}

//
// Per-element callback for VMV.S.X
//
static RISCV_MORPHV_FN(emitVMVSX) {

    riscvP       riscv   = state->riscv;
    vmiReg       vd      = id->r[0];
    vmiReg       rs1     = id->r[1];
    riscvRegDesc rs1A    = getRVReg(state, 1);
    Uns32        sBits   = getMinBits(id, getRBits(rs1A));
    Bool         sExtend = vectorSignExtVMVXS(riscv);

    // set target register
    setTail(riscv, id->VLEN, vd);

    // assign element 0 of result
    vmimtMoveExtendRR(id->SEW, vd, sBits, rs1, sExtend);
}

//
// Per-element callback for VFMV.F.S
//
static RISCV_MORPHV_FN(emitVFMVFS) {

    riscvP       riscv = state->riscv;
    vmiReg       fd    = id->r[0];
    vmiReg       vs1   = id->r[1];
    riscvRegDesc fdA   = getRVReg(state, 0);
    Uns32        eBits = getMinBits(id, getRBits(fdA));

    // extract element 0
    vmimtMoveRR(eBits, fd, vs1);

    // handle NaN boxing if required
    writeRegSize(riscv, fdA, eBits);
}

//
// Per-element callback for VFMV.S.F
//
static RISCV_MORPHV_FN(emitVFMVSF) {

    riscvP       riscv = state->riscv;
    vmiReg       vd    = id->r[0];
    riscvRegDesc fs1A  = getRVReg(state, 1);
    Uns32        sBits = getMinBits(id, getRBits(fs1A));
    vmiReg       fs1   = getVMIRegFS(state, setRBits(fs1A, sBits));

    // set target register
    setTail(riscv, id->VLEN, vd);

    // assign element 0 of result
    vmimtMoveRR(sBits, vd, fs1);
}

//
// Per-element callback for VSLIDEUP.VX
//
static RISCV_MORPHV_FN(emitVRSLIDEUPCB) {

    Uns32     offsetBits = IMPERAS_POINTER_BITS;
    vmiLabelP skip       = vmimtNewLabel();
    vmiReg    offset     = id->r[2];
    vmiReg    vstart     = CSR_REG_MT(vstart);
    Uns32     xBits      = getRVBits(state, id, 2);
    Uns32     sBits      = (xBits<offsetBits) ? xBits : offsetBits;
    vmiReg    index      = newTmp(state);

    // skip move if vstart<offset
    vmimtCompareRRJumpLabel(xBits, vmi_COND_B, vstart, offset, skip);

    // calculate source index
    vmimtMoveExtendRR(offsetBits, index, sBits, offset, False);
    vmimtBinopRR(offsetBits, vmi_RSUB, index, vstart, 0);

    // do indexed move (if not skipped)
    moveIndexedVd0Vs1(state, id, index, skip);
}

//
// Per-element callback for VSLIDEUP.VI
//
static RISCV_MORPHV_FN(emitVISLIDEUPCB) {

    Uns32     offsetBits = IMPERAS_POINTER_BITS;
    vmiLabelP skip       = vmimtNewLabel();
    Uns32     offset     = state->info.c;
    vmiReg    vstart     = CSR_REG_MT(vstart);
    vmiReg    index      = newTmp(state);

    // skip move if vstart<offset
    vmimtCompareRCJumpLabel(32, vmi_COND_B, vstart, offset, skip);

    // calculate source index
    vmimtBinopRRC(offsetBits, vmi_SUB, index, vstart, offset, 0);

    // do indexed move (if not skipped)
    moveIndexedVd0Vs1(state, id, index, skip);
}

//
// Per-element callback for VSLIDEDOWN, common routine
//
static void emitVRSLIDEDOWNInt(
    riscvMorphStateP state,
    iterDescP        id,
    vmiReg           index,
    Uns32            xBits
) {
    Uns32     vlMax = getVLMAXOp(id);
    vmiLabelP skip  = vmimtNewLabel();
    vmiLabelP done  = vmimtNewLabel();

    // skip move from vector if index>=vlmax
    vmimtCompareRCJumpLabel(xBits, vmi_COND_NB, index, vlMax, skip);

    // do indexed move (if not skipped)
    moveIndexedVd0Vs1(state, id, index, 0);
    vmimtUncondJumpLabel(done);

    // zero result if operation was skipped
    vmimtInsertLabel(skip);
    vmimtMoveRC(id->SEW, id->r[0], 0);

    vmimtInsertLabel(done);
}

//
// Per-element callback for VSLIDEDOWN.VX
//
static RISCV_MORPHV_FN(emitVRSLIDEDOWNCB) {

    Uns32  vlMax      = getVLMAXOp(id);
    Uns32  offsetBits = IMPERAS_POINTER_BITS;
    vmiReg offset     = id->r[2];
    vmiReg vstart     = CSR_REG_MT(vstart);
    Uns32  xBits      = getRVBits(state, id, 2);
    Uns32  sBits      = (xBits<offsetBits) ? xBits : offsetBits;
    vmiReg index      = newTmp(state);

    // move offset clamped to vlmax to temporary
    vmimtCompareRC(xBits, vmi_COND_B, offset, vlMax, index);
    vmimtCondMoveRRC(xBits, index, True, index, offset, vlMax);

    // calculate source index
    vmimtMoveExtendRR(offsetBits, index, sBits, index, False);
    vmimtBinopRR(offsetBits, vmi_ADD, index, vstart, 0);

    // do common part
    emitVRSLIDEDOWNInt(state, id, index, xBits);
}

//
// Per-element callback for VSLIDEDOWN.VI
//
static RISCV_MORPHV_FN(emitVISLIDEDOWNCB) {

    Uns32  offsetBits = IMPERAS_POINTER_BITS;
    Uns32  offset     = state->info.c;
    vmiReg vstart     = CSR_REG_MT(vstart);
    vmiReg index      = newTmp(state);

    // calculate source index
    vmimtBinopRRC(offsetBits, vmi_ADD, index, vstart, offset, 0);

    // do common part
    emitVRSLIDEDOWNInt(state, id, index, 32);
}

//
// Initialization callback for VFSLIDE1UP.VF/VFSLIDE1DOWN.VF
//
static RISCV_MORPHV_FN(initVFSLIDE1CB) {

    riscvRegDesc fs1A  = getRVReg(state, 2);
    Uns32        sBits = getMinBits(id, getRBits(fs1A));
    vmiReg       fs1   = getVMIRegFS(state, setRBits(fs1A, sBits));

    // prepare input (never extended)
    vmimtMoveRR(sBits, RISCV_VTMP, fs1);
}

//
// Initialization callback for VSLIDE1UP.VX/VSLIDE1DOWN.VX
//
static RISCV_MORPHV_FN(initVXSLIDE1CB) {

    riscvRegDesc rs1A    = getRVReg(state, 2);
    Uns32        sBits   = getMinBits(id, getRBits(rs1A));
    Bool         sExtend = riscvVFSupport(state->riscv, RVVF_SEXT_SLIDE1_SRC);

    // prepare zero-extended input
    vmimtMoveExtendRR(id->SEW, RISCV_VTMP, sBits, id->r[2], sExtend);
}

//
// Per-element callback for VSLIDE1UP.VX/VFSLIDE1UP.VF
//
static RISCV_MORPHV_FN(emitVRSLIDE1UPCB) {

    Uns32     offsetBits = IMPERAS_POINTER_BITS;
    vmiLabelP skip       = vmimtNewLabel();
    vmiReg    vstart     = CSR_REG_MT(vstart);
    vmiReg    index      = newTmp(state);

    // assume zero-extended rs1 result is required
    vmimtMoveRR(id->SEW, id->r[0], RISCV_VTMP);

    // skip move from vector if vstart==0
    vmimtCompareRCJumpLabel(32, vmi_COND_EQ, vstart, 0, skip);

    // calculate source index
    vmimtBinopRRC(offsetBits, vmi_SUB, index, vstart, 1, 0);

    // do indexed move (if not skipped)
    moveIndexedVd0Vs1(state, id, index, skip);
}

//
// Per-element callback for VSLIDE1DOWN.VX/VFSLIDE1DOWN.VF
//
static RISCV_MORPHV_FN(emitVRSLIDE1DOWNCB) {

    Uns32     offsetBits = IMPERAS_POINTER_BITS;
    vmiLabelP skip       = vmimtNewLabel();
    vmiReg    vstart     = CSR_REG_MT(vstart);
    vmiReg    index      = newTmp(state);

    // assume zero-extended rs1 result is required
    vmimtMoveRR(id->SEW, id->r[0], RISCV_VTMP);

    // calculate source index
    vmimtBinopRRC(offsetBits, vmi_ADD, index, vstart, 1, 0);

    // skip move from vector if index>=vl
    vmimtCompareRRJumpLabel(32, vmi_COND_NB, index, CSR_REG_MT(vl), skip);

    // do indexed move (if not skipped)
    moveIndexedVd0Vs1(state, id, index, skip);
}

//
// Per-element callback for VRGATHER.VX/VRGATHER.VV
//
static RISCV_MORPHV_FN(emitVRRGATHERCB) {

    Uns32     vlMax      = getVLMAXOp(id);
    Uns32     offsetBits = IMPERAS_POINTER_BITS;
    vmiLabelP skip       = vmimtNewLabel();
    vmiReg    offset     = id->r[2];
    Uns32     xBits      = getRVBits(state, id, 2);
    Uns32     dBits      = (xBits>offsetBits) ? xBits : offsetBits;
    vmiReg    index      = newTmp(state);

    // assume zero result is required
    vmimtMoveRC(id->SEW, id->r[0], 0);

    // calculate source index
    vmimtMoveExtendRR(dBits, index, xBits, offset, False);

    // skip move from vector if index>=vlmax
    vmimtCompareRCJumpLabel(dBits, vmi_COND_NB, index, vlMax, skip);

    // do indexed move (if not skipped)
    moveIndexedVd0Vs1(state, id, index, skip);
}

//
// Is the constant offset for this instruction less than effective VLMAX?
//
static Bool offsetLTVLMax(riscvMorphStateP state, iterDescP id) {

    Uns32 vlMax  = getVLMAXOp(id);
    Uns32 offset = state->info.c;

    return (offset<vlMax);
}

//
// Initialization callback for VRGATHER.VI
//
static RISCV_MORPHV_FN(initVIRGATHERCB) {

    // prepare operation-constant source value if index is in range
    if(offsetLTVLMax(state, id)) {

        Uns32  offsetBits = IMPERAS_POINTER_BITS;
        vmiReg index      = RISCV_VTMP;

        // calculate source index
        vmimtMoveRC(offsetBits, index, state->info.c);

        // initialize source indexed vector register
        getIndexedVRegisterInt(state, id, 1, index);

        // move one element
        vmimtMoveRR(id->SEW, index, id->r[1]);
    }
}

//
// Per-element callback for VRGATHER.VI
//
static RISCV_MORPHV_FN(emitVIRGATHERCB) {

    if(offsetLTVLMax(state, id)) {
        vmimtMoveRR(id->SEW, id->r[0], RISCV_VTMP);
    } else {
        vmimtMoveRC(id->SEW, id->r[0], 0);
    }
}

//
// Initialization callback for VCOMPRESS.VM
//
static RISCV_MORPHV_FN(initVCOMPRESSCB) {

    riscvP riscv      = state->riscv;
    Uns32  offsetBits = IMPERAS_POINTER_BITS;
    Uns32  EMUL       = getEMUL(id, 0);

    // set target register
    setTail(riscv, id->VLEN*EMUL, id->r[0]);

    // zero target index
    vmimtMoveRC(offsetBits, RISCV_VTMP, 0);
}

//
// Per-element callback for VCOMPRESS.VM
//
static RISCV_MORPHV_FN(emitVCOMPRESSCB) {

    Uns32 offsetBits = IMPERAS_POINTER_BITS;

    // initialize target indexed vector register
    getIndexedVRegisterInt(state, id, 0, RISCV_VTMP);

    // increment target index
    vmimtBinopRC(offsetBits, vmi_ADD, RISCV_VTMP, 1, 0);

    // move one element
    vmimtMoveRR(id->SEW, id->r[0], id->r[1]);

    // kill base registers and temporaries
    killBaseRegistersAndTemps(state, id);
}


////////////////////////////////////////////////////////////////////////////////
// EXTERNALLY-IMPLEMENTED VECTOR OPERATIONS
////////////////////////////////////////////////////////////////////////////////

//
// Per-element callback for externally-implemented vector operation
//
static RISCV_MORPHV_FN(emitVExternalCB) {
    state->externalCB(state->riscv, state->userData, id->r, id->SEW);
}


////////////////////////////////////////////////////////////////////////////////
// QUAD WIDENING EXTENSION
////////////////////////////////////////////////////////////////////////////////

//
// Operation-specific argument checks for quad-widening extension
//
static RISCV_CHECKV_FN(emitQMACCheckCB) {

    riscvP riscv = state->riscv;
    Bool   ok    = True;

    if(!riscv->configInfo.Zvqmac) {

        // VLMUL must be 1 for load/store segment instructions
        ILLEGAL_INSTRUCTION_MESSAGE(
            riscv, "IVQMAC", "Zvqmac extension not configured"
        );
        ok = False;
    }

    return ok;
}


////////////////////////////////////////////////////////////////////////////////
// DIVIDED ELEMENT EXTENSION
////////////////////////////////////////////////////////////////////////////////

//
// Operation-specific argument checks for divided element extension
//
static RISCV_CHECKV_FN(emitEDIVCheckCB) {

    riscvP riscv = state->riscv;
    Bool   ok    = True;

    if(!riscv->configInfo.Zvediv) {

        // extension not configured
        ILLEGAL_INSTRUCTION_MESSAGE(
            riscv, "IVEDIV", "Zvediv extension not configured"
        );
        ok = False;

    } else {

        // not yet supported
        ILLEGAL_INSTRUCTION_MESSAGE(
            riscv, "IVEDIV_INIMP", "Zvediv extension not yet supported"
        );
        ok = False;
    }

    return ok;
}


////////////////////////////////////////////////////////////////////////////////
// P EXTENSION
////////////////////////////////////////////////////////////////////////////////

#if(ENABLE_P_EXT)

//
// Macro returning members of an array
//
#define NUM_MEMBERS(_A) (sizeof(_A)/sizeof((_A)[0]))

//
// Return any saturation flags required for the binary operation
//
static vmiFlagsCP getMulopSatFlags(riscvMorphStateP state, vmiBinop op) {

    vmiFlagsCP result = 0;

    if(op==vmi_IMUL) {
        result = getSatFlags(state, True);
    } else if(op==vmi_MUL) {                    // LCOV_EXCL_LINE
        result = getSatFlags(state, False);     // LCOV_EXCL_LINE
    }

    return result;
}

//
// Is the binary operation signed?
//
inline static Bool isSignedBinop(vmiBinop op) {
    return isSQBinop(op) || (op==vmi_IMUL) || (op==vmi_IMULSU);
}

//
// Return saturating left shift operation for the given base operation
//
inline static vmiBinop getSHLQBinop(vmiBinop op) {
    return isSignedBinop(op) ? vmi_SHLSQ : vmi_SHLUQ;
}

//
// Return right shift operation for the given base operation and rounding
//
static vmiBinop getSHRRBinop(vmiBinop op, Bool round) {
    VMI_ASSERT(isSignedBinop(op), "Unexpected unsigned binop %u", op);
    return round ? vmi_SARR : vmi_SAR;
}

//
// Return the binary operation that is the pair of the given operation
//
static vmiBinop getPairBinop(vmiBinop op) {

    switch(op) {
        case vmi_ADD:
            op = vmi_SUB;
            break;
        case vmi_ADDSQ:
            op = vmi_SUBSQ;
            break;
        case vmi_ADDUQ:
            op = vmi_SUBUQ;
            break;
        case vmi_ADDSH:
            op = vmi_SUBSH;
            break;
        case vmi_ADDUH:
            op = vmi_SUBUH;
            break;
        default:
            VMI_ABORT("Unexpected pair binop %u", op);   // LCOV_EXCL_LINE
    }

    return op;
}

//
// Return the binary operation that is the equivalent of the given operation
// but is unaffected by carry-in
//
static vmiBinop getNoCINBinop(vmiBinop op) {

    switch(op) {
        case vmi_ADCSQ:
            op = vmi_ADDSQ;
            break;
        case vmi_SBBSQ:
            op = vmi_SUBSQ;
            break;
        default:
            break;
    }

    return op;
}

//
// Unpacked register for P extension - on RV32, a pair of registers may be used
// together as a wider value
//
typedef struct unpackedRegXS {
    unpackedReg r;
    unpackedReg lo32;
    unpackedReg hi32;
    Bool        isPair;
} unpackedRegX;

//
// Is a W operand explicitly specified for this operation?
//
inline static Bool explicitW(riscvMorphStateP state) {
    return state->attrs->pAttrs & RVPS_W;
}

//
// Should operation be double width?
//
inline static Bool doubleW(riscvMorphStateP state) {
    return state->attrs->pAttrs & RVPS_2;
}

//
// Return unpacked GPR argument odd/even half
//
static unpackedReg unpackRXHalf(
    riscvMorphStateP state,
    Uns32            argNum,
    Bool             useOdd
) {
    unpackedReg result;

    // after version 0.5.2, use of x0 implies zero source and ignored result
    if(getRIndex(state->info.r[argNum])) {
        // no action if encoded register is not x0
    } else if(RISCV_DSP_VERSION(state->riscv)>RVDSPV_0_5_2) {
        useOdd = False;
    }

    state->info.r[argNum] += useOdd;
    result = unpackRX(state, argNum);
    state->info.r[argNum] -= useOdd;

    return result;
}

//
// Return unpacked GPR argument description for GPR decomposed into elements
//
static unpackedRegX unpackRXxInt(
    riscvMorphStateP state,
    Uns32            argNum,
    Bool             force64
) {
    riscvP       riscv   = state->riscv;
    riscvDSPVer  version = RISCV_DSP_VERSION(riscv);
    Uns32        XLEN    = riscvGetXlenMode(riscv);
    unpackedRegX r       = {r:unpackRX(state, argNum)};

    if(XLEN>32) {

        // no action

    } else if((state->info.elemSize==32) && !explicitW(state)) {

        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IPES", "Illegal for RV32");

    } else if(!force64 && (state->info.elemSize!=64)) {

        // no action

    } else if(riscv->configInfo.dsp_absent & RVPS_Zpsfoperand) {

        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IPWO", "Zpsfoperand unimplemented");

    } else if((state->info.r[argNum]&1) && (version>RVDSPV_0_5_2)) {

        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "IUR", "Illegal misaligned register");

    } else {

        Bool loIsOdd = False;

        // in version 0.5.2 lo/hi register usage depends on data endianness
        if(version==RVDSPV_0_5_2) {
            loIsOdd = (getLoadStoreEndianMT(riscv, False)==MEM_ENDIAN_BIG);
        }

        // allocate temporary for this register
        r.r.r    = newTmp(state);
        r.r.bits = 64;

        // ensure register number is even
        state->info.r[argNum] &= -2;

        // unpack register halves
        r.lo32 = unpackRXHalf(state, argNum,  loIsOdd);
        r.hi32 = unpackRXHalf(state, argNum, !loIsOdd);

        // indicate register is a pair
        r.isPair = True;
    }

    return r;
}

//
// Return unpacked GPR argument description for GPR decomposed into elements
//
inline static unpackedRegX unpackRXx(riscvMorphStateP state, Uns32 argNum) {
    return unpackRXxInt(state, argNum, False);
}

//
// Return unpacked GPR argument description for 64-bit GPR decomposed into
// elements
//
inline static unpackedRegX unpackRXx64(riscvMorphStateP state, Uns32 argNum) {
    return unpackRXxInt(state, argNum, True);
}

//
// Return unpacked GPR argument description for destination GPR decomposed into
// elements
//
inline static unpackedRegX unpackRXxD(riscvMorphStateP state, Uns32 argNum) {
    return unpackRXx(state, argNum);
}

//
// Return unpacked GPR argument description for 64-bit destination GPR
// decomposed into elements
//
inline static unpackedRegX unpackRXxD64(riscvMorphStateP state, Uns32 argNum) {
    return unpackRXx64(state, argNum);
}

//
// Form 64-bit source from 32-bit GPRs if required
//
static unpackedRegX form64BitSrc(unpackedRegX r) {

    if(r.isPair) {

        // paired register argument
        vmiReg lo32 = r.r.r;
        vmiReg hi32 = VMI_REG_DELTA(lo32, 4);

        // copy source value from unpacked halves
        vmimtMoveRR(32, lo32, r.lo32.r);
        vmimtMoveRR(32, hi32, r.hi32.r);
    }

    return r;
}

//
// Return unpacked GPR argument description for source GPR decomposed into
// elements
//
static unpackedRegX unpackRXxS(riscvMorphStateP state, Uns32 argNum) {
    return form64BitSrc(unpackRXx(state, argNum));
}

//
// Return unpacked GPR argument description for 64-bit source GPR decomposed
// into elements
//
static unpackedRegX unpackRXxS64(riscvMorphStateP state, Uns32 argNum) {
    return form64BitSrc(unpackRXx64(state, argNum));
}

//
// Does this operation accumulate results?
//
inline static Bool doAccumulate(riscvMorphStateP state) {
    return (state->attrs->acc!=vmi_BINOP_LAST);
}

//
// Return unpacked GPR argument description for destination GPR that is
// optionally an accumulator decomposed into elements
//
static unpackedRegX unpackRXxA(riscvMorphStateP state, Uns32 argNum) {

    Bool isAcc = doAccumulate(state);

    return isAcc ? unpackRXxS(state, argNum) : unpackRXxD(state, argNum);
}

//
// Return unpacked GPR argument description for 64-bit destination GPR that is
// optionally an accumulator decomposed into elements
//
static unpackedRegX unpackRXxA64(riscvMorphStateP state, Uns32 argNum) {

    Bool isAcc = doAccumulate(state);

    return isAcc ? unpackRXxS64(state, argNum) : unpackRXxD64(state, argNum);
}

//
// Do actions when an unpacked register is written using the derived register
// size and handling paired registers
//
static void writeUnpackedX(riscvMorphStateP state, unpackedRegX rd) {

    if(!rd.isPair) {

        // not a paired register result
        writeUnpacked(rd.r);

    } else {

        // paired register result
        vmiReg lo32 = rd.r.r;
        vmiReg hi32 = VMI_REG_DELTA(lo32, 4);

        // copy result value to unpacked halves
        vmimtMoveRR(32, rd.lo32.r, lo32);
        vmimtMoveRR(32, rd.hi32.r, hi32);

        // write unpacked halves
        writeUnpacked(rd.lo32);
        writeUnpacked(rd.hi32);
    }
}

//
// Structure used to describe element characteristics
//
typedef struct elemInfoS {
    Uns8 eBits;     // element bits
    Uns8 eBytes;    // element bytes
    Uns8 num;       // number of elements
} elemInfo;

//
// Return element characteristics for GPR
//
static elemInfo getElemInfo(riscvMorphStateP state, unpackedReg r) {

    Uns32 rBits = r.bits;
    Uns32 eBits = state->info.elemSize;

    if(eBits) {
        // bits explicitly specified
    } else if(explicitW(state)) {
        eBits = 32;
    } else {
        eBits = rBits;
    }

    // use double width if required
    if(doubleW(state)) {
        eBits *= 2;
    }

    elemInfo result = {eBits:eBits, eBytes:eBits/8, num:rBits/eBits};

    return result;
}

//
// Return element characteristics for SIMD register (paired on RV32)
//
static elemInfo getElemInfoX(riscvMorphStateP state, unpackedRegX r) {

    return getElemInfo(state, r.r);
}

//
// Adjust vmiReg descriptors to next value
//
static void nextElement(vmiRegP regs, Uns32 num, Uns32 bytes) {

    Uns32 i;

    for(i=0; i<num; i++) {
        regs[i] = VMI_REG_DELTA(regs[i], bytes);
    }
}

//
// Implement generic SIMD operation (two registers)
//
static RISCV_MORPH_FN(emitUnopRR_Sx) {

    unpackedRegX rd  = unpackRXxD(state, 0);
    unpackedRegX rs1 = unpackRXxS(state, 1);
    elemInfo     ei  = getElemInfoX(state, rd);
    vmiUnop      op  = state->attrs->unop;
    vmiFlagsCP   f   = getUnopSatFlags(state, op);
    vmiReg       r[] = {rd.r.r, rs1.r.r};
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num; i++) {
        vmimtUnopRR(ei.eBits, op, r[0], r[1], f);
        commitSatFlag(state, f);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    writeUnpackedX(state, rd);
}

//
// Implement generic SIMD binary operation (three registers)
//
static RISCV_MORPH_FN(emitBinopRRR_Sx) {

    unpackedRegX rd  = unpackRXxD(state, 0);
    unpackedRegX rs1 = unpackRXxS(state, 1);
    unpackedRegX rs2 = unpackRXxS(state, 2);
    elemInfo     ei  = getElemInfoX(state, rd);
    vmiBinop     op  = getBinopRound(state, state->attrs->binop);
    vmiFlagsCP   f   = getBinopSatFlags(state, op);
    vmiReg       r[] = {rd.r.r, rs1.r.r, rs2.r.r};
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num; i++) {
        vmimtBinopRRR(ei.eBits, op, r[0], r[1], r[2], f);
        commitSatFlag(state, f);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    writeUnpackedX(state, rd);
}

//
// Implement generic SIMD binary operation (two registers and constant)
//
static RISCV_MORPH_FN(emitBinopRRC_Sx) {

    unpackedRegX rd  = unpackRXxD(state, 0);
    unpackedRegX rs1 = unpackRXxS(state, 1);
    elemInfo     ei  = getElemInfoX(state, rd);
    vmiBinop     op  = getBinopRound(state, state->attrs->binop);
    Uns64        c   = state->info.c;
    vmiFlagsCP   f   = getBinopSatFlags(state, op);
    vmiReg       r[] = {rd.r.r, rs1.r.r};
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num; i++) {
        vmimtBinopRRC(ei.eBits, op, r[0], r[1], c, f);
        commitSatFlag(state, f);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    writeUnpackedX(state, rd);
}

//
// Implement generic SIMD shift operation (three registers)
//
static RISCV_MORPH_FN(emitShiftopRRR_Sx) {

    unpackedRegX rd  = unpackRXxD(state, 0);
    unpackedRegX rs1 = unpackRXxS(state, 1);
    unpackedRegX rs2 = unpackRXxS(state, 2);
    elemInfo     ei  = getElemInfoX(state, rd);
    vmiBinop     op  = getBinopRound(state, state->attrs->binop);
    vmiFlagsCP   f   = getBinopSatFlags(state, op);
    vmiReg       r[] = {rd.r.r, rs1.r.r};
    vmiReg       tmp = newTmp(state);
    Uns32        i;

    // get shift amount
    vmimtMoveRR(ei.eBits, tmp, rs2.r.r);

    // process SIMD elements
    for(i=0; i<ei.num; i++) {
        vmimtBinopRRR(ei.eBits, op, r[0], r[1], tmp, f);
        commitSatFlag(state, f);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    writeUnpackedX(state, rd);
}

//
// Implement saturating Binop (three registers) with extension to 32 bits
//
static RISCV_MORPH_FN(emitBinopRRR_Wx) {

    unpackedRegX rd  = unpackRXxD(state, 0);
    unpackedRegX rs1 = unpackRXxS(state, 1);
    unpackedRegX rs2 = unpackRXxS(state, 2);
    vmiBinop     op   = state->attrs->binop;
    vmiFlagsCP   f    = getBinopSatFlags(state, op);
    Uns32        bits = rd.r.bits;
    Uns32        shft = 32-bits;
    vmiReg       tmp  = newTmp(state);

    // do saturating add/subtract with 32-bit width
    vmimtBinopRRR(32, op, tmp, rs1.r.r, rs2.r.r, f);

    // restrict result width if required
    if(shft) {
        commitSatFlag(state, f);
        vmimtBinopRC(32, getSHLQBinop(op), tmp, shft, f);
        vmimtBinopRC(32, vmi_SHR,          tmp, shft, 0);
    }

    // commit result from temporary (required when result in x0)
    vmimtMoveRR(bits, rd.r.r, tmp);
    commitSatFlag(state, f);

    writeUnpackedX(state, rd);
}

//
// Implement generic SIMD paired operation (three registers)
//
static RISCV_MORPH_FN(emitPairRRR_Sx) {

    riscvPAttrs  attrs = state->attrs->pAttrs;
    unpackedRegX rd    = unpackRXxD(state, 0);
    unpackedRegX rs1   = unpackRXxS(state, 1);
    unpackedRegX rs2   = unpackRXxS(state, 2);
    elemInfo     ei    = getElemInfoX(state, rd);
    vmiReg       r[]   = {rd.r.r, rs1.r.r, rs2.r.r, rs2.r.r};
    vmiBinop     opA   = state->attrs->binop;
    vmiBinop     opB   = getPairBinop(opA);
    vmiBinop     op1   = (state->info.crossOp==RV_CR_SA) ? opA : opB;
    vmiBinop     op2   = (state->info.crossOp==RV_CR_SA) ? opB : opA;
    vmiFlagsCP   f     = getBinopSatFlags(state, opA);
    vmiReg       tmp   = newTmp(state);
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num/2; i++) {

        // prepare element-swapped source if required
        if(attrs&RVPS_X) {
            r[3] = tmp;
            vmimtMoveRR(ei.eBits, r[3], VMI_REG_DELTA(r[2], ei.eBytes));
            vmimtMoveRR(ei.eBits, VMI_REG_DELTA(r[3], ei.eBytes), r[2]);
        }

        // do first pair operation
        vmimtBinopRRR(ei.eBits, op1, r[0], r[1], r[3], f);
        commitSatFlag(state, f);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);

        // do second pair operation
        vmimtBinopRRR(ei.eBits, op2, r[0], r[1], r[3], f);
        commitSatFlag(state, f);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    writeUnpackedX(state, rd);
}

//
// Implement generic SIMD compare (three registers)
//
static RISCV_MORPH_FN(emitCmpopRRR_Sx) {

    unpackedRegX rd  = unpackRXxD(state, 0);
    unpackedRegX rs1 = unpackRXxS(state, 1);
    unpackedRegX rs2 = unpackRXxS(state, 2);
    elemInfo     ei  = getElemInfoX(state, rd);
    vmiReg       r[] = {rd.r.r, rs1.r.r, rs2.r.r};
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num; i++) {
        vmimtCompareRR(ei.eBits, state->attrs->cond, r[1], r[2], r[0]);
        vmimtMoveExtendRR(ei.eBits, r[0], 8, r[0], False);
        vmimtUnopR(ei.eBits, vmi_NEG, r[0], 0);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    writeUnpackedX(state, rd);
}

//
// Implement BITREV
//
static RISCV_MORPH_FN(emitBITREV) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    vmiReg      tmp1 = newTmp(state);
    vmiReg      tmp2 = newTmp(state);
    Uns32       bits = rd.bits;

    vmimtUnopRR(bits, vmi_RBIT, tmp1, rs1.r, 0);
    vmimtBinopRCR(bits, vmi_SUB, tmp2, -1, rs2.r, 0);
    vmimtBinopRRR(bits, vmi_SHR, rd.r, tmp1, tmp2, 0);

    writeUnpacked(rd);
}

//
// Implement BITREVI
//
static RISCV_MORPH_FN(emitBITREVI) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs1   = unpackRX(state, 1);
    Uns64       c    = state->info.c;
    vmiReg      tmp  = newTmp(state);
    Uns32       bits = rd.bits;

    vmimtUnopRR(bits, vmi_RBIT, tmp, rs1.r, 0);
    vmimtBinopRRC(bits, vmi_SHR, rd.r, tmp, bits-c-1, 0);

    writeUnpacked(rd);
}

//
// Implement MADDR/MSUBR
//
static RISCV_MORPH_FN(emitMACCR) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    vmiBinop    op   = state->attrs->binop;
    vmiBinop    acc  = state->attrs->acc;
    vmiReg      tmp  = newTmp(state);
    Uns32       bits = rd.bits;

    vmimtBinopRRR(bits, op, tmp, rs1.r, rs2.r, 0);
    vmimtBinopRR(bits, acc, rd.r, tmp, 0);

    writeUnpacked(rd);
}

//
// Implement MULR/MULSR
//
static RISCV_MORPH_FN(emitMULR) {

    unpackedRegX rd   = unpackRXxD(state, 0);
    unpackedReg  rs1  = unpackRX(state, 1);
    unpackedReg  rs2  = unpackRX(state, 2);
    vmiBinop     op   = state->attrs->binop;
    Uns32        bits = rd.r.bits/2;
    vmiReg       rdl  = rd.r.r;
    vmiReg       rdh  = VMI_REG_DELTA(rdl, bits/8);

    vmimtMulopRRR(bits, op, rdh, rdl, rs1.r, rs2.r, 0);

    writeUnpackedX(state, rd);
}

//
// Emit code to accumulate result
//
static void emitAccumulateResult(
    riscvMorphStateP state,
    Uns32            bits,
    vmiReg           rd,
    vmiReg           rs1,
    vmiReg           rs2
) {
    vmiBinop acc = state->attrs->acc;

    if(acc!=vmi_BINOP_LAST) {
        vmimtBinopRRR(bits, acc, rd, rs1, rs2, 0);
    } else {
        vmimtMoveRR(bits, rd, rs2);
    }
}

//
// Implement PBSAD/PBSADA
//
static RISCV_MORPH_FN(emitPBSAD) {

    unpackedReg rd   = unpackRX(state, 0);
    unpackedReg rs1  = unpackRX(state, 1);
    unpackedReg rs2  = unpackRX(state, 2);
    vmiBinop    op   = state->attrs->binop;
    vmiReg      td   = newTmp(state);
    vmiReg      ts1  = newTmp(state);
    vmiReg      ts2  = newTmp(state);
    Uns32       bits = rd.bits;
    Uns32       num  = bits/8;
    Uns32       i;

    // zero accumulator
    vmimtMoveRC(bits, td, 0);

    for(i=0; i<num; i++) {

        // extend operands
        vmimtMoveExtendRR(bits, ts1, 8, rs1.r, False);
        vmimtMoveExtendRR(bits, ts2, 8, rs2.r, False);

        // subtract and take absolute difference
        vmimtBinopRR(bits, op, ts1, ts2, 0);
        vmimtUnopR(bits, vmi_ABS, ts1, 0);

        // add to accumulator
        vmimtBinopRR(bits, vmi_ADD, td, ts1, 0);

        // step to next byte
        rs1.r = VMI_REG_DELTA(rs1.r, 1);
        rs2.r = VMI_REG_DELTA(rs2.r, 1);
    }

    // commit result
    emitAccumulateResult(state, bits, rd.r, rd.r, td);

    writeUnpacked(rd);
}

//
// Implement BPICK
//
static RISCV_MORPH_FN(emitBPICK) {
    emitCMIXInt(state, 1, 2, 3);
}

//
// Implement INSB
//
static RISCV_MORPH_FN(emitINSB) {

    unpackedReg rd    = unpackRX(state, 0);
    unpackedReg rs1   = unpackRX(state, 1);
    Uns64       c     = state->info.c;
    Uns32       bits  = rd.bits;
    Uns32       bytes = bits/8;

    vmimtMoveRR(8, VMI_REG_DELTA(rd.r, c&(bytes-1)), rs1.r);

    writeUnpacked(rd);
}

//
// Get required half of input register ra
//
static vmiReg getRAHalf(Uns32 hbits, vmiReg ra, riscvHalfDesc half) {

    if((half==RV_HA_TB) || (half==RV_HA_TT)) {
        ra = VMI_REG_DELTA(ra, hbits/8);
    }

    return ra;
}

//
// Get required half of input register rb
//
static vmiReg getRBHalf(Uns32 hbits, vmiReg rb, riscvHalfDesc half) {

    if((half==RV_HA_BT) || (half==RV_HA_TT)) {
        rb = VMI_REG_DELTA(rb, hbits/8);
    } else if(half==RV_HA_T) {
        rb = VMI_REG_DELTA(rb, hbits/16);
    }

    return rb;
}

//
// Does operation use two half-width operands?
//
static Bool bothHalf(riscvHalfDesc half) {
    return (
        (half==RV_HA_BB) ||
        (half==RV_HA_BT) ||
        (half==RV_HA_TB) ||
        (half==RV_HA_TT)
    );
}

//
// Does operation use half-width second operand?
//
static Bool rbHalf(riscvHalfDesc half) {
    return (
        (half==RV_HA_B) ||
        (half==RV_HA_T)
    );
}

//
// Implement optionally-saturating multiply of operands, optionally with half
// width operands or result narrowing
//
static void emitMulQn(
    riscvMorphStateP state,
    Uns32            bits,
    vmiReg           rd,
    vmiReg           ra,
    vmiReg           rb
) {
    // determine operation attributes
    riscvPAttrs   attrs = state->attrs->pAttrs;
    riscvHalfDesc half  = state->info.half;
    Bool          round = state->info.round;
    Bool          doD   = (attrs&RVPS_D) || state->info.doDouble;
    Bool          doN   = (attrs&RVPS_N) || round;

    // determine operation bits, left shift and right shift from attributes
    Uns32 hbits   = (bothHalf(half) || !doN) ? bits/2 : bits;
    Uns32 shlbits = !doD ? 0 : rbHalf(half) ? (bits/2)+1 : 1;
    Uns32 shrbits = !doN ? 0 : rbHalf(half) && !doD ? bits/2 : hbits;

    vmiBinop op  = state->attrs->binop;
    vmiBinop acc = state->attrs->acc;
    vmiReg   tl  = newTmp(state);
    vmiReg   th  = VMI_REG_DELTA(tl, hbits/8);

    // select high/low operand halves if required
    ra = getRAHalf(hbits, ra, half);
    rb = getRBHalf(hbits, rb, half);

    // prepare extended second argument if required
    if(rbHalf(half)) {
        vmimtMoveExtendRR(hbits, tl, hbits/2, rb, op==vmi_IMUL);
        rb = tl;
    }

    // do multiply
    vmimtMulopRRR(hbits, op, th, tl, ra, rb, 0);

    // handle rounding if required
    if(round) {
        vmimtBinopRC(hbits*2, vmi_ADD, tl, 1ULL<<(shrbits-shlbits-1), 0);
    }

    // double result with saturation if required
    if(doD) {
        vmiFlagsCP f = getMulopSatFlags(state, op);
        vmimtBinopRC(hbits*2, getSHLQBinop(op), tl, shlbits, f);
        commitSatFlag(state, f);
    }

    // narrow result if required
    if(doN) {
        vmimtBinopRC(hbits*2, getSHRRBinop(op, False), tl, shrbits, 0);
        vmimtMoveExtendRR(bits, tl, hbits, tl, True);
    }

    // accumulate result if required
    if(acc!=vmi_BINOP_LAST) {
        vmiFlagsCP f = getBinopSatFlags(state, acc);
        vmimtBinopRRR(bits, acc, tl, rd, tl, f);
        commitSatFlag(state, f);
    }

    // commit result
    vmimtMoveRR(bits, rd, tl);

    // free allocated temporary
    freeTmp(state);
}

//
// Implement SIMD saturating multiply operation
//
static RISCV_MORPH_FN(emitMulQn_Sx) {

    unpackedRegX rd  = unpackRXxA(state, 0);
    unpackedRegX rs1 = unpackRXxS(state, 1);
    unpackedRegX rs2 = unpackRXxS(state, 2);
    elemInfo     ei  = getElemInfoX(state, rd);
    vmiReg       r[] = {rd.r.r, rs1.r.r, rs2.r.r};
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num; i++) {
        emitMulQn(state, ei.eBits, r[0], r[1], r[2]);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    writeUnpackedX(state, rd);
}

//
// Implement SIMD crossed saturating multiply operation
//
static RISCV_MORPH_FN(emitMulQnX_Sx) {

    unpackedRegX rd   = unpackRXxA(state, 0);
    unpackedRegX rs1  = unpackRXxS(state, 1);
    unpackedRegX rs2  = unpackRXxS(state, 2);
    elemInfo     ei   = getElemInfoX(state, rd);
    vmiReg       r[]  = {rd.r.r, rs1.r.r, rs2.r.r, VMI_NOREG};
    vmiReg       tmp1 = newTmp(state);
    vmiReg       tmp2 = newTmp(state);
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num/2; i++) {

        // prepare element-swapped source
        r[3] = tmp1;
        vmimtMoveRR(ei.eBits, r[3], VMI_REG_DELTA(r[2], ei.eBytes));
        vmimtMoveRR(ei.eBits, VMI_REG_DELTA(r[3], ei.eBytes), r[2]);

        // do first crossed operation
        emitMulQn(state, ei.eBits, tmp2, r[1], r[3]);
        vmimtMoveRR(ei.eBits, r[0], tmp2);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);

        // do second crossed operation
        emitMulQn(state, ei.eBits, tmp2, r[1], r[3]);
        vmimtMoveRR(ei.eBits, r[0], tmp2);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    writeUnpackedX(state, rd);
}

//
// Implement KMA[X]D[AS]
//
static RISCV_MORPH_FN(emitKMAXDAS) {

    unpackedRegX rd   = unpackRXxA(state, 0);
    unpackedRegX rs1  = unpackRXxS(state, 1);
    unpackedRegX rs2  = unpackRXxS(state, 2);
    elemInfo     ei   = getElemInfoX(state, rd);
    vmiReg       r[]  = {rd.r.r, rs1.r.r, rs2.r.r};
    vmiReg       tmp1 = newTmp(state);
    vmiReg       tmp2 = newTmp(state);
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num; i++) {

        riscvPAttrs attrs = state->attrs->pAttrs;
        vmiBinop    op    = state->attrs->binop;
        vmiBinop    op2   = state->attrs->binop2;
        vmiBinop    acc   = state->attrs->acc;
        vmiFlagsCP  f     = getBinopSatFlags(state, acc);
        vmiReg      t1L   = tmp1;
        vmiReg      t1H   = VMI_REG_DELTA(t1L, ei.eBytes/2);
        vmiReg      t2L   = tmp2;
        vmiReg      t2H   = VMI_REG_DELTA(t2L, ei.eBytes/2);
        vmiReg      s1A   = r[1];
        vmiReg      s1B   = VMI_REG_DELTA(s1A, ei.eBytes/2);
        vmiReg      s2A   = r[2];
        vmiReg      s2B   = VMI_REG_DELTA(s2A, ei.eBytes/2);

        // handle crossed arguments
        if(attrs&RVPS_X) {
            vmiReg t = s2A; s2A = s2B; s2B = t;
        }

        // do half-width multiplications (no saturation possible)
        vmimtMulopRRR(ei.eBits/2, op, t1H, t1L, s1A, s2A, 0);
        vmimtMulopRRR(ei.eBits/2, op, t2H, t2L, s1B, s2B, 0);

        // compose result
        if(acc==vmi_BINOP_LAST) {

            // compose result
            vmimtBinopRRR(ei.eBits, op2, r[0], tmp1, tmp2, f);
            commitSatFlag(state, f);

        } else if(isUQBinop(op2)) {

            // add/subtract first partial result with saturation
            vmimtBinopRRR(ei.eBits, op2, tmp1, r[0], tmp1, f);
            commitSatFlag(state, f);

            // add/subtract second partial result with saturation
            vmimtBinopRRR(ei.eBits, acc, r[0], tmp1, tmp2, f);
            commitSatFlag(state, f);

        } else {

            // add/subtract partial results with saturation
            vmimtBinopRR(ei.eBits, op2, tmp1, tmp2, f);

            // compose result
            vmimtBinopRR(ei.eBits, acc, r[0], tmp1, f);
            commitSatFlag(state, f);
        }

        // step to next element
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    writeUnpackedX(state, rd);
}

//
// Implement KMAR64/KMSR64
//
static RISCV_MORPH_FN(emitKMASR) {

    unpackedRegX rd   = unpackRXxA(state, 0);
    unpackedReg  rs1  = unpackRX(state, 1);
    unpackedReg  rs2  = unpackRX(state, 2);
    Uns32        bits = rs1.bits;

    if(bits==64) {

        // can share KMA code for other operations on RV64
        emitKMAXDAS(state);

    } else {

        // special function for RV32
        vmiBinop   op  = state->attrs->binop;
        vmiBinop   acc = getNoCINBinop(state->attrs->acc);
        vmiFlagsCP f   = getBinopSatFlags(state, acc);
        vmiReg     t1L = newTmp(state);
        vmiReg     t1H = VMI_REG_DELTA(t1L, bits/8);

        // do multiplication (no saturation possible)
        vmimtMulopRRR(bits, op, t1H, t1L, rs1.r, rs2.r, 0);

        // compose result
        vmimtBinopRR(bits*2, acc, rd.r.r, t1L, f);
        commitSatFlag(state, f);
    }

    writeUnpackedX(state, rd);
}

//
// Implement KSLRA
//
static RISCV_MORPH_FN(emitKSLRA) {

    Bool         round = state->info.round;
    vmiBinop     opP   = state->attrs->binop;
    vmiBinop     opN   = getSHRRBinop(opP, round);
    vmiFlagsCP   f     = getBinopSatFlags(state, opP);
    unpackedRegX rd    = unpackRXxD(state, 0);
    unpackedRegX rs1   = unpackRXxS(state, 1);
    unpackedRegX rs2   = unpackRXxS(state, 2);
    elemInfo     ei    = getElemInfoX(state, rd);
    vmiReg       rP[]  = {rd.r.r, rs1.r.r};
    vmiReg       rN[]  = {rd.r.r, rs1.r.r};
    vmiReg       tmp   = newTmp(state);
    vmiLabelP    neg   = vmimtNewLabel();
    vmiLabelP    shok  = vmimtNewLabel();
    vmiLabelP    done  = vmimtNewLabel();
    Uns32        i;

    // get shift amount in temporary and branch if it should be considered
    // negative
    vmimtMoveRR(ei.eBits, tmp, rs2.r.r);
    vmimtTestRCJumpLabel(ei.eBits, vmi_COND_NZ, tmp, ei.eBits, neg);

    // process SIMD elements (positive shift)
    for(i=0; i<ei.num; i++) {
        vmimtBinopRRR(ei.eBits, opP, rP[0], rP[1], tmp, f);
        commitSatFlag(state, f);
        nextElement(rP, NUM_MEMBERS(rP), ei.eBytes);
    }

    vmimtUncondJumpLabel(done);
    vmimtInsertLabel(neg);

    // negate shift
    vmimtUnopR(ei.eBits, vmi_NEG, tmp, 0);

    // adjust shift if it exceeds element size
    vmimtTestRCJumpLabel(ei.eBits, vmi_COND_Z, tmp, ei.eBits, shok);
    vmimtMoveRC(ei.eBits, tmp, ei.eBits-1);
    vmimtInsertLabel(shok);

    // process SIMD elements (negative shift)
    for(i=0; i<ei.num; i++) {
        vmimtBinopRRR(ei.eBits, opN, rN[0], rN[1], tmp, 0);
        nextElement(rN, NUM_MEMBERS(rN), ei.eBytes);
    }

    vmimtInsertLabel(done);

    writeUnpackedX(state, rd);
}

//
// Implement PK[BT][BT]
//
static RISCV_MORPH_FN(emitPK) {

    riscvHalfDesc half = state->info.half;
    unpackedRegX  rd   = unpackRXxD(state, 0);
    unpackedRegX  rs1  = unpackRXxS(state, 1);
    unpackedRegX  rs2  = unpackRXxS(state, 2);
    elemInfo      ei   = getElemInfoX(state, rd);
    vmiReg        r[]  = {rd.r.r, rs1.r.r, rs2.r.r};
    vmiReg        tmp  = newTmp(state);
    Uns32         i;

    // process SIMD elements
    for(i=0; i<ei.num/2; i++) {

        // select high/low operand halves
        vmiReg ra = getRAHalf(ei.eBits, r[1], half);
        vmiReg rb = getRBHalf(ei.eBits, r[2], half);

        // compose result
        vmimtMoveRR(ei.eBits, tmp, rb);
        vmimtMoveRR(ei.eBits, VMI_REG_DELTA(tmp, ei.eBits/8), ra);

        // assign result
        vmimtMoveRR(ei.eBits*2, r[0], tmp);

        // step to next element
        nextElement(r, NUM_MEMBERS(r), ei.eBytes*2);
    }

    writeUnpackedX(state, rd);
}

//
// Implement [SU]CLIP
//
static RISCV_MORPH_FN(emitCLIP) {

    vmiBinop     op  = state->attrs->binop;
    vmiFlagsCP   f   = getBinopSatFlags(state, op);
    unpackedRegX rd  = unpackRXxD(state, 0);
    unpackedRegX rs1 = unpackRXxS(state, 1);
    elemInfo     ei  = getElemInfoX(state, rd);
    Int32        max = (1<<state->info.c)-1;
    Int32        min = isSQBinop(op) ? -max-1 : 0;
    vmiReg       r[] = {rd.r.r, rs1.r.r};
    vmiReg       tmp = newTmp(state);
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num; i++) {

        // handle input < min
        vmimtCompareRC(ei.eBits, vmi_COND_L, r[1], min, RISCV_SF_TMP);
        vmimtCondMoveRRC(ei.eBits, RISCV_SF_TMP, False, tmp, r[1], min);
        commitSatFlag(state, f);

        // handle input > max
        vmimtCompareRC(ei.eBits, vmi_COND_NLE, tmp, max, RISCV_SF_TMP);
        vmimtCondMoveRRC(ei.eBits, RISCV_SF_TMP, False, r[0], tmp, max);
        commitSatFlag(state, f);

        // step to next element
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    writeUnpackedX(state, rd);
}

//
// Implement multiply-accumulate element accumulating 64-bit result, optionally
// with half width operands
//
static void emitMAL64Element(
    riscvMorphStateP state,
    Uns32            bits,
    vmiBinop         acc,
    vmiReg           rd,
    vmiReg           ra,
    vmiReg           rb
) {
    // determine operation attributes
    riscvHalfDesc half = state->info.half;
    vmiBinop      op   = state->attrs->binop;
    vmiReg        tl   = newTmp(state);
    vmiReg        th   = VMI_REG_DELTA(tl, bits/8);

    // select high/low operand halves if required
    ra = getRAHalf(bits, ra, half);
    rb = getRBHalf(bits, rb, half);

    // do multiplication, extend, and add to accumulator
    vmimtMulopRRR(bits, op, th, tl, ra, rb, 0);
    vmimtMoveExtendRR(64, tl, bits*2, tl, isSignedBinop(op));
    vmimtBinopRR(64, acc, rd, tl, 0);

    // free allocated temporary
    freeTmp(state);
}

//
// Implement multiply-accumulate accumulating 64-bit result, optionally with
// half width operands
//
static void emitMAL64Int(
    riscvMorphStateP state,
    unpackedRegX     rd,
    vmiReg           ra,
    vmiReg           rb,
    vmiReg           rc,
    unpackedReg      size
) {
    vmiBinop op2 = state->attrs->binop2;
    vmiBinop acc = state->attrs->acc;
    elemInfo ei  = getElemInfo(state, size);
    vmiReg   r[] = {ra, rb};
    vmiReg   tmp = newTmp(state);
    Uns32    i;

    // clear accumulator
    vmimtMoveRC(rd.r.bits, tmp, 0);

    // process SIMD elements
    for(i=0; i<ei.num; i++) {
        emitMAL64Element(state, ei.eBits/2, op2, tmp, r[0], r[1]);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
    }

    // compose result
    vmimtBinopRRR(rd.r.bits, acc, rd.r.r, rc, tmp, 0);

    writeUnpackedX(state, rd);
}

//
// Implement paired multiply-accumulate accumulating 64-bit result, optionally
// with half width operands
//
static void emitPairMAL64Int(
    riscvMorphStateP state,
    unpackedRegX     rd,
    vmiReg           ra,
    vmiReg           rb,
    vmiReg           rc,
    unpackedReg      size
) {
    riscvPAttrs attrs = state->attrs->pAttrs;
    vmiBinop    op2   = state->attrs->binop2;
    vmiBinop    op3   = state->attrs->binop3;
    elemInfo    ei    = getElemInfo(state, size);
    vmiReg      r[]   = {ra, rb, rb};
    vmiReg      tmp1  = newTmp(state);
    vmiReg      tmp2  = newTmp(state);
    Uns32       i;

    // clear accumulator
    vmimtMoveRC(rd.r.bits, tmp1, 0);

    // process SIMD elements
    for(i=0; i<ei.num; i++) {

        // prepare element-swapped source if required
        if(attrs&RVPS_X) {
            r[2] = tmp2;
            vmimtMoveRR(ei.eBits/2, r[2], VMI_REG_DELTA(r[1], ei.eBytes/2));
            vmimtMoveRR(ei.eBits/2, VMI_REG_DELTA(r[2], ei.eBytes/2), r[1]);
        }

        // do first element
        emitMAL64Element(state, ei.eBits/2, op2, tmp1, r[0], r[2]);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes/2);

        // do second element
        emitMAL64Element(state, ei.eBits/2, op3, tmp1, r[0], r[2]);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes/2);
    }

    // commit result
    emitAccumulateResult(state, rd.r.bits, rd.r.r, rc, tmp1);

    writeUnpackedX(state, rd);
}

//
// Implement [SU]MAL
//
static RISCV_MORPH_FN(emitMAL64) {

    unpackedRegX rd  = unpackRXxD64(state, 0);
    unpackedRegX rs1 = unpackRXxS64(state, 1);
    unpackedReg  rs2 = unpackRX(state, 2);
    vmiReg       ra  = rs2.r;
    vmiReg       rb  = VMI_REG_DELTA(rs2.r, 2);

    emitMAL64Int(state, rd, ra, rb, rs1.r.r, rs2);
}

//
// Implement [SU]MAL[BT][BT]
//
static RISCV_MORPH_FN(emitMAL64_Hx) {

    unpackedRegX rd  = unpackRXxA64(state, 0);
    unpackedReg  rs1 = unpackRX(state, 1);
    unpackedReg  rs2 = unpackRX(state, 2);

    emitMAL64Int(state, rd, rs1.r, rs2.r, rd.r.r, rs2);
}

//
// Implement [SU]MALDA
//
static RISCV_MORPH_FN(emitPairMAL64_Hx) {

    unpackedRegX rd  = unpackRXxA64(state, 0);
    unpackedReg  rs1 = unpackRX(state, 1);
    unpackedReg  rs2 = unpackRX(state, 2);

    emitPairMAL64Int(state, rd, rs1.r, rs2.r, rd.r.r, rs2);
}

//
// Implement [Su]MAQA
//
static RISCV_MORPH_FN(emitMAQA) {

    vmiBinop    op     = state->attrs->binop;
    vmiBinop    acc    = state->attrs->acc;
    unpackedReg rd     = unpackRX(state, 0);
    unpackedReg rs1    = unpackRX(state, 1);
    unpackedReg rs2    = unpackRX(state, 2);
    elemInfo    ei     = getElemInfo(state, rd);
    vmiReg      rS[]   = {rs1.r, rs2.r};
    vmiReg      rD[]   = {rd.r};
    vmiReg      tmp1   = newTmp(state);
    vmiReg      tmp2   = newTmp(state);
    Uns32       mBits  = 8;
    Uns32       mBytes = mBits/8;
    vmiReg      t2L    = tmp2;
    vmiReg      t2H    = VMI_REG_DELTA(t2L, mBytes);
    Uns32       i;

    // process SIMD elements
    for(i=0; i<ei.num; i++) {

        Uns32 j;

        // seed accumulator with destination
        vmimtMoveRR(ei.eBits, tmp1, rD[0]);

        for(j=0; j<(ei.eBits/mBits); j++) {
            vmimtMulopRRR(mBits, op, t2H, t2L, rS[0], rS[1], 0);
            vmimtMoveExtendRR(ei.eBits, tmp2, mBits*2, tmp2, isSignedBinop(op));
            vmimtBinopRR(ei.eBits, acc, tmp1, tmp2, 0);
            nextElement(rS, NUM_MEMBERS(rS), mBytes);
        }

        // compose result
        vmimtMoveRR(ei.eBits, rD[0], tmp1);
        nextElement(rD, NUM_MEMBERS(rD), ei.eBytes);
    }

    writeUnpacked(rd);
}

//
// Implement SMUL
//
static RISCV_MORPH_FN(emitSMUL) {

    riscvPAttrs  attrs = state->attrs->pAttrs;
    vmiBinop     op    = state->attrs->binop;
    unpackedRegX rd    = unpackRXxA64(state, 0);
    unpackedReg  rs1   = unpackRX(state, 1);
    unpackedReg  rs2   = unpackRX(state, 2);
    elemInfo     ei    = getElemInfoX(state, rd);
    vmiReg       r[]   = {rs1.r, rs2.r, rs2.r};
    vmiReg       tmp1  = newTmp(state);
    vmiReg       tmp2  = newTmp(state);
    vmiReg       tL    = tmp1;
    vmiReg       tH    = VMI_REG_DELTA(tL, ei.eBytes);
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num/2; i++) {

        // prepare element-swapped source if required
        if(attrs&RVPS_X) {
            r[2] = tmp2;
            vmimtMoveRR(ei.eBits, r[2], VMI_REG_DELTA(r[1], ei.eBytes));
            vmimtMoveRR(ei.eBits, VMI_REG_DELTA(r[2], ei.eBytes), r[1]);
        }

        // do first element
        vmimtMulopRRR(ei.eBits, op, tH, tL, r[0], r[2], 0);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
        tL = VMI_REG_DELTA(tL, ei.eBytes*2);
        tH = VMI_REG_DELTA(tH, ei.eBytes*2);

        // do second element
        vmimtMulopRRR(ei.eBits, op, tH, tL, r[0], r[2], 0);
        nextElement(r, NUM_MEMBERS(r), ei.eBytes);
        tL = VMI_REG_DELTA(tL, ei.eBytes*2);
        tH = VMI_REG_DELTA(tH, ei.eBytes*2);
    }

    // commit result
    emitAccumulateResult(state, rd.r.bits, rd.r.r, rd.r.r, tmp1);

    writeUnpackedX(state, rd);
}

//
// Implement [SZ]UNPKD8
//
static void emitUNPKD8(riscvMorphStateP state, Bool sExtend) {

    riscvPackDesc pack = state->info.pack;
    unpackedRegX  rd   = unpackRXxD(state, 0);
    unpackedRegX  rs1  = unpackRXxS(state, 1);
    elemInfo      ei   = getElemInfoX(state, rd);
    vmiReg        r[]  = {rd.r.r, rs1.r.r};
    vmiReg        tmp  = newTmp(state);
    vmiReg        tL   = tmp;
    vmiReg        tH   = VMI_REG_DELTA(tmp, 2);
    Uns32         i;

    // process SIMD elements
    for(i=0; i<ei.num/4; i++) {

        // index for first source argument
        static const Uns8 s1Map[] = {
            [RV_PD_10] = 0,
            [RV_PD_20] = 0,
            [RV_PD_30] = 0,
            [RV_PD_31] = 1,
            [RV_PD_32] = 2,
        };

        // index for second source argument
        static const Uns8 s2Map[] = {
            [RV_PD_10] = 1,
            [RV_PD_20] = 2,
            [RV_PD_30] = 3,
            [RV_PD_31] = 3,
            [RV_PD_32] = 3,
        };

        // locate byte sources
        vmiReg s1 = VMI_REG_DELTA(r[1], s1Map[pack]);
        vmiReg s2 = VMI_REG_DELTA(r[1], s2Map[pack]);

        // construct result
        vmimtMoveExtendRR(ei.eBits*2, tL, ei.eBits, s1, sExtend);
        vmimtMoveExtendRR(ei.eBits*2, tH, ei.eBits, s2, sExtend);

        // assign result
        vmimtMoveRR(ei.eBits*4, r[0], tmp);

        // step to next element
        nextElement(r, NUM_MEMBERS(r), ei.eBytes*4);
    }

    writeUnpackedX(state, rd);
}

//
// Implement SUNPKD8
//
static RISCV_MORPH_FN(emitSUNPKD8) {
    emitUNPKD8(state, True);
}

//
// Implement ZUNPKD8
//
static RISCV_MORPH_FN(emitZUNPKD8) {
    emitUNPKD8(state, False);
}

//
// Implement SWAP
//
static RISCV_MORPH_FN(emitSWAP) {

    unpackedRegX rd  = unpackRXxD(state, 0);
    unpackedRegX rs1 = unpackRXxS(state, 1);
    elemInfo     ei  = getElemInfoX(state, rd);
    vmiReg       r[] = {rd.r.r, rs1.r.r};
    vmiReg       tmp = newTmp(state);
    vmiReg       tL  = tmp;
    vmiReg       tH  = VMI_REG_DELTA(tmp, ei.eBytes);
    Uns32        i;

    // process SIMD elements
    for(i=0; i<ei.num/2; i++) {

        // locate byte sources
        vmiReg s1 = VMI_REG_DELTA(r[1], 0);
        vmiReg s2 = VMI_REG_DELTA(r[1], ei.eBytes);

        // construct result
        vmimtMoveRR(ei.eBits, tL, s2);
        vmimtMoveRR(ei.eBits, tH, s1);

        // assign result
        vmimtMoveRR(ei.eBits*2, r[0], tmp);

        // step to next element
        nextElement(r, NUM_MEMBERS(r), ei.eBytes*2);
    }

    writeUnpackedX(state, rd);
}

//
// Implement WEXT
//
static RISCV_MORPH_FN(emitWEXT) {

    unpackedReg  rd  = unpackRX(state, 0);
    unpackedRegX rs1 = unpackRXxS64(state, 1);
    unpackedReg  rs2 = unpackRX(state, 2);
    vmiReg       tmp = newTmp(state);

    vmimtSetShiftMask(0x1f);
    vmimtBinopRRR(rs1.r.bits, vmi_SHR, tmp, rs1.r.r, rs2.r, 0);
    vmimtMoveExtendRR(rd.bits, rd.r, 32, tmp, True);

    writeUnpacked(rd);
}

//
// Implement WEXTI
//
static RISCV_MORPH_FN(emitWEXTI) {

    unpackedReg  rd  = unpackRX(state, 0);
    unpackedRegX rs1 = unpackRXxS64(state, 1);
    Uns32        c   = state->info.c;
    vmiReg       tmp = newTmp(state);

    vmimtBinopRRC(rs1.r.bits, vmi_SHR, tmp, rs1.r.r, c, 0);
    vmimtMoveExtendRR(rd.bits, rd.r, 32, tmp, True);

    writeUnpacked(rd);
}

#endif


////////////////////////////////////////////////////////////////////////////////
// CBO EXTENSION
////////////////////////////////////////////////////////////////////////////////

//
// CBO usage check operation
//
#define CBO_CHECK_FN(_NAME) void _NAME(riscvP riscv)
typedef CBO_CHECK_FN((*cboCheckFn));

//
// Get size of cache block for management and prefetch instructions
//
inline static Int32 getCMOMPBytes(riscvMorphStateP state) {
    return state->riscv->configInfo.cmomp_bytes;
}

//
// Get size of cache block for zero instructions
//
inline static Int32 getCMOZBytes(riscvMorphStateP state) {
    return state->riscv->configInfo.cmoz_bytes;
}

//
// Validate CSR access controls for CBO instruction and raise Illegal Instruction
// or Virtual Instruction exception if required
//
static void checkCBO(riscvP riscv, Uns32 shift, const char *field) {

    riscvMode   mode    = getCurrentMode5(riscv);
    riscvMode   ill     = 0;
    Uns32       mask    = 1<<shift;
    Bool        mok     = RD_CSR(riscv, menvcfg) & mask;
    Bool        sok     = RD_CSR(riscv, senvcfg) & mask;
    Bool        hok     = RD_CSR(riscv, henvcfg) & mask;
    const char *reasonP = 0;
    char        pfx     = 0;
    char        reason[32];

    // determine whether access is disabled by any envcfg CSR
    if(!mok) {
        ill = RISCV_MODE_M;
        pfx = 'm';
    } else if(!sok && supervisorPresent(riscv) && (mode==RISCV_MODE_U)) {
        ill = RISCV_MODE_S;
        pfx = 's';
    } else if(!hok && ((mode==RISCV_MODE_VS) || (mode==RISCV_MODE_VU))) {
        ill = RISCV_MODE_H;
        pfx = 'h';
    } else if(!sok && (mode==RISCV_MODE_VU)) {
        ill = RISCV_MODE_H;
        pfx = 's';
    }

    // manufacture reason string for failure if required
    if(ill && riscv->verbose) {
        sprintf(reason, "%cenvcfg.%s=0", pfx, field);
        reasonP = &reason[0];
    }

    // trigger Illegal Instruction or Virtual Instruction exception if required
    if(ill==RISCV_MODE_H) {
        riscvVirtualInstructionMessage(riscv, reasonP);
    } else if(ill) {
        riscvIllegalInstructionMessage(riscv, reasonP);
    }
}

//
// Do CBO.CLEAN/CBO.FLUSH usage check
//
static CBO_CHECK_FN(checkCBCFE) {
    checkCBO(riscv, shift_envcfg_CBCFE, "CBCFE");
}

//
// Do CBO.INVAL usage check
//
static CBO_CHECK_FN(checkCBIE) {
    checkCBO(riscv, shift_envcfg_CBIE, "CBIE");
}

//
// Do CBO.ZERO usage check
//
static CBO_CHECK_FN(checkCBZE) {
    checkCBO(riscv, shift_envcfg_CBZE, "CBZE");
}

//
// Emit call to CBO usage check function
//
static void emitCBOCheck(riscvMorphStateP state, cboCheckFn checkCB) {

    if(getCurrentMode3(state->riscv) != RISCV_MODE_M) {
        vmimtArgProcessor();
        vmimtCallAttrs((vmiCallFn)checkCB, VMCA_NA);
        vmimtEndBlock();
    }
}

//
// Emit code to implement try-write associated with CBO operation
//
static void emitCBOTryWriteOrZero(
    riscvMorphStateP state,
    Int32            bytes,
    Bool             zero
) {
    riscvP        riscv      = state->riscv;
    unpackedReg   ra         = unpackRX(state, 0);
    Uns32         raBits     = ra.bits;
    vmiReg        tmp        = newTmp(state);
    Uns32         bits       = bytes*8;
    memEndian     endian     = MEM_ENDIAN_LITTLE;
    memConstraint constraint = MEM_CONSTRAINT_NONE;

    // manufacture cache-aligned address
    vmimtBinopRRC(raBits, vmi_AND, tmp, ra.r, -bytes, 0);

    // set addres mask for following operation
    setAddressMaskMT(riscv);

    // do try-write or zero of entire cache line
    if(zero) {
        vmimtStoreRCO(bits, 0, tmp, 0, endian, constraint);
    } else {
        vmimtTryStoreRC(bits, 0, tmp, constraint);
    }

    freeTmp(state);
}

//
// Implement CBO.CLEAN
//
static RISCV_MORPH_FN(emitCBOCLEAN) {

    // check CBO operation usage
    emitCBOCheck(state, checkCBCFE);

    // emit try-write
    emitCBOTryWriteOrZero(state, getCMOMPBytes(state), False);
}

//
// Implement CBO.FLUSH
//
static RISCV_MORPH_FN(emitCBOFLUSH) {

    // check CBO operation usage
    emitCBOCheck(state, checkCBCFE);

    // emit try-write
    emitCBOTryWriteOrZero(state, getCMOMPBytes(state), False);
}

//
// Implement CBO.INVAL
//
static RISCV_MORPH_FN(emitCBOINVAL) {

    // check CBO operation usage
    emitCBOCheck(state, checkCBIE);

    // emit try-write
    emitCBOTryWriteOrZero(state, getCMOMPBytes(state), False);
}

//
// Implement CBO.ZERO
//
static RISCV_MORPH_FN(emitCBOZERO) {

    // check CBO operation usage
    emitCBOCheck(state, checkCBZE);

    // emit try-write
    emitCBOTryWriteOrZero(state, getCMOZBytes(state), True);
}


////////////////////////////////////////////////////////////////////////////////
// INSTRUCTION TABLE
////////////////////////////////////////////////////////////////////////////////

//
// Dispatch table for instruction translation
//
const static riscvMorphAttr dispatchTable[] = {

    // NOP pseudo-instruction
    [RV_IT_NOP]              = {morph:emitNOP},

    // move pseudo-instructions (register and constant source)
    [RV_IT_MV_R]             = {morph:emitMoveRR,    ZfhminOK:1},
    [RV_IT_MV_C]             = {morph:emitMoveRC},

    // base R-type instructions
    [RV_IT_ADD_R]            = {morph:emitBinopRRR,  binop:vmi_ADD,    iClass:OCL_IC_INTEGER},
    [RV_IT_AND_R]            = {morph:emitBinopRRR,  binop:vmi_AND,    iClass:OCL_IC_INTEGER},
    [RV_IT_OR_R]             = {morph:emitBinopRRR,  binop:vmi_OR,     iClass:OCL_IC_INTEGER},
    [RV_IT_SLL_R]            = {morph:emitBinopRRR,  binop:vmi_SHL,    iClass:OCL_IC_INTEGER},
    [RV_IT_SLT_R]            = {morph:emitCmpopRRR,  cond :vmi_COND_L, iClass:OCL_IC_INTEGER},
    [RV_IT_SLTU_R]           = {morph:emitCmpopRRR,  cond :vmi_COND_B, iClass:OCL_IC_INTEGER},
    [RV_IT_SRA_R]            = {morph:emitBinopRRR,  binop:vmi_SAR,    iClass:OCL_IC_INTEGER},
    [RV_IT_SRL_R]            = {morph:emitBinopRRR,  binop:vmi_SHR,    iClass:OCL_IC_INTEGER},
    [RV_IT_SUB_R]            = {morph:emitBinopRRR,  binop:vmi_SUB,    iClass:OCL_IC_INTEGER},
    [RV_IT_XOR_R]            = {morph:emitBinopRRR,  binop:vmi_XOR,    iClass:OCL_IC_INTEGER},
    [RV_IT_EXT_R]            = {morph:emitMoveExtendRR,                iClass:OCL_IC_INTEGER},

    // M-extension R-type instructions
    [RV_IT_DIV_R]            = {morph:emitBinopRRR,  binop:vmi_IDIV,   iClass:OCL_IC_INTEGER},
    [RV_IT_DIVU_R]           = {morph:emitBinopRRR,  binop:vmi_DIV,    iClass:OCL_IC_INTEGER},
    [RV_IT_MUL_R]            = {morph:emitBinopRRR,  binop:vmi_MUL,    iClass:OCL_IC_INTEGER},
    [RV_IT_MULH_R]           = {morph:emitMulopHRRR, binop:vmi_IMUL,   iClass:OCL_IC_INTEGER},
    [RV_IT_MULHSU_R]         = {morph:emitMulopHRRR, binop:vmi_IMULSU, iClass:OCL_IC_INTEGER},
    [RV_IT_MULHU_R]          = {morph:emitMulopHRRR, binop:vmi_MUL,    iClass:OCL_IC_INTEGER},
    [RV_IT_REM_R]            = {morph:emitBinopRRR,  binop:vmi_IREM,   iClass:OCL_IC_INTEGER},
    [RV_IT_REMU_R]           = {morph:emitBinopRRR,  binop:vmi_REM,    iClass:OCL_IC_INTEGER},

    // base I-type instructions
    [RV_IT_ADDI_I]           = {morph:emitBinopRRC,  binop:vmi_ADD,    iClass:OCL_IC_INTEGER},
    [RV_IT_ANDI_I]           = {morph:emitBinopRRC,  binop:vmi_AND,    iClass:OCL_IC_INTEGER},
    [RV_IT_JALR_I]           = {morph:emitJALR                                              },
    [RV_IT_ORI_I]            = {morph:emitBinopRRC,  binop:vmi_OR,     iClass:OCL_IC_INTEGER},
    [RV_IT_SLTI_I]           = {morph:emitCmpopRRC,  cond :vmi_COND_L, iClass:OCL_IC_INTEGER},
    [RV_IT_SLTIU_I]          = {morph:emitCmpopRRC,  cond :vmi_COND_B, iClass:OCL_IC_INTEGER},
    [RV_IT_SLLI_I]           = {morph:emitBinopRRC,  binop:vmi_SHL,    iClass:OCL_IC_INTEGER},
    [RV_IT_SRAI_I]           = {morph:emitBinopRRC,  binop:vmi_SAR,    iClass:OCL_IC_INTEGER},
    [RV_IT_SRLI_I]           = {morph:emitBinopRRC,  binop:vmi_SHR,    iClass:OCL_IC_INTEGER},
    [RV_IT_XORI_I]           = {morph:emitBinopRRC,  binop:vmi_XOR,    iClass:OCL_IC_INTEGER},

    // base I-type instructions for load and store
    [RV_IT_L_I]              = {morph:emitLoad,  ZfhminOK:1},
    [RV_IT_S_I]              = {morph:emitStore, ZfhminOK:1},

    // base I-type instructions for CSR access (register)
    [RV_IT_CSRR_I]           = {morph:emitCSRR,   iClass:OCL_IC_SYSREG  },

    // base I-type instructions for CSR access (constant)
    [RV_IT_CSRRI_I]          = {morph:emitCSRRI,  iClass:OCL_IC_SYSREG  },

    // miscellaneous system I-type instructions
    [RV_IT_EBREAK_I]         = {morph:emitEBREAK, iClass:OCL_IC_SYSTEM  },
    [RV_IT_ECALL_I]          = {morph:emitECALL,  iClass:OCL_IC_SYSTEM  },
    [RV_IT_FENCEI_I]         = {morph:emitFENCEI, iClass:OCL_IC_IBARRIER},
    [RV_IT_MRET_I]           = {morph:emitMRET,   iClass:OCL_IC_SYSTEM  },
    [RV_IT_MNRET_I]          = {morph:emitMNRET,  iClass:OCL_IC_SYSTEM  },
    [RV_IT_SRET_I]           = {morph:emitSRET,   iClass:OCL_IC_SYSTEM  },
    [RV_IT_URET_I]           = {morph:emitURET,   iClass:OCL_IC_SYSTEM  },
    [RV_IT_DRET_I]           = {morph:emitDRET,   iClass:OCL_IC_SYSTEM  },
    [RV_IT_WFI_I]            = {morph:emitWFI,    iClass:OCL_IC_SYSTEM  },

    // system fence I-type instruction
    [RV_IT_FENCE_I]          = {morph:emitNOP,    iClass:OCL_IC_DBARRIER},

    // system fence R-type instruction
    [RV_IT_SFENCE_VMA_R]     = {morph:emitSFENCE_VMA,  iClass:OCL_IC_SYSTEM|OCL_IC_MMU},
    [RV_IT_HFENCE_VVMA_R]    = {morph:emitHFENCE_VVMA, iClass:OCL_IC_SYSTEM|OCL_IC_MMU},
    [RV_IT_HFENCE_GVMA_R]    = {morph:emitHFENCE_GVMA, iClass:OCL_IC_SYSTEM|OCL_IC_MMU},

    // base U-type instructions
    [RV_IT_AUIPC_U]          = {morph:emitMoveRPC, binop:vmi_ADD, iClass:OCL_IC_INTEGER},

    // base B-type instructions
    [RV_IT_BEQ_B]            = {morph:emitBranchRR, cond:vmi_COND_EQ},
    [RV_IT_BGE_B]            = {morph:emitBranchRR, cond:vmi_COND_NL},
    [RV_IT_BGEU_B]           = {morph:emitBranchRR, cond:vmi_COND_NB},
    [RV_IT_BLT_B]            = {morph:emitBranchRR, cond:vmi_COND_L },
    [RV_IT_BLTU_B]           = {morph:emitBranchRR, cond:vmi_COND_B },
    [RV_IT_BNE_B]            = {morph:emitBranchRR, cond:vmi_COND_NE},

    // base J-type instructions
    [RV_IT_JAL_J]            = {morph:emitJAL},

    // A-extension R-type instructions
    [RV_IT_AMOADD_R]         = {morph:emitAMOBinopRRR, binop:vmi_ADD },
    [RV_IT_AMOAND_R]         = {morph:emitAMOBinopRRR, binop:vmi_AND },
    [RV_IT_AMOMAX_R]         = {morph:emitAMOBinopRRR, binop:vmi_IMAX},
    [RV_IT_AMOMAXU_R]        = {morph:emitAMOBinopRRR, binop:vmi_MAX },
    [RV_IT_AMOMIN_R]         = {morph:emitAMOBinopRRR, binop:vmi_IMIN},
    [RV_IT_AMOMINU_R]        = {morph:emitAMOBinopRRR, binop:vmi_MIN },
    [RV_IT_AMOOR_R]          = {morph:emitAMOBinopRRR, binop:vmi_OR  },
    [RV_IT_AMOSWAP_R]        = {morph:emitAMOSwapRRR                 },
    [RV_IT_AMOXOR_R]         = {morph:emitAMOBinopRRR, binop:vmi_XOR },
    [RV_IT_LR_R]             = {morph:emitLR, iClass:OCL_IC_EXCLUSIVE},
    [RV_IT_SC_R]             = {morph:emitSC, iClass:OCL_IC_EXCLUSIVE},

    // F-extension and D-extension R-type instructions
    [RV_IT_FMV_R]            = {                      morph:emitFMoveRR                                               },
    [RV_IT_FABS_R]           = {fpConfig:RVFP_NORMAL, morph:emitFUnop,    fpUnop  : vmi_FQABS                         },
    [RV_IT_FADD_R]           = {fpConfig:RVFP_NORMAL, morph:emitFBinop,   fpBinop : vmi_FADD                          },
    [RV_IT_FCLASS_R]         = {fpConfig:RVFP_NORMAL, morph:emitFClass,                                               },
    [RV_IT_FCVTX_R]          = {fpConfig:RVFP_NORMAL, morph:emitFConvert                                              },
    [RV_IT_FCVTF_R]          = {fpConfig:RVFP_NORMAL, morph:emitFConvert, ZfhminOK:1                                  },
    [RV_IT_FDIV_R]           = {fpConfig:RVFP_NORMAL, morph:emitFBinop,   fpBinop : vmi_FDIV,   iClass:OCL_IC_DIVIDE  },
    [RV_IT_FEQ_R]            = {fpConfig:RVFP_NORMAL, morph:emitFCompare, fpRel   : RVFCMP_EQ                         },
    [RV_IT_FLE_R]            = {fpConfig:RVFP_NORMAL, morph:emitFCompare, fpRel   : RVFCMP_LE                         },
    [RV_IT_FLT_R]            = {fpConfig:RVFP_NORMAL, morph:emitFCompare, fpRel   : RVFCMP_LT                         },
    [RV_IT_FMAX_R]           = {fpConfig:RVFP_FMAX,   morph:emitFBinop,   fpBinop : vmi_FMAX,                         },
    [RV_IT_FMIN_R]           = {fpConfig:RVFP_FMIN,   morph:emitFBinop,   fpBinop : vmi_FMIN,                         },
    [RV_IT_FMUL_R]           = {fpConfig:RVFP_NORMAL, morph:emitFBinop,   fpBinop : vmi_FMUL,   iClass:OCL_IC_MULTIPLY},
    [RV_IT_FNEG_R]           = {fpConfig:RVFP_NORMAL, morph:emitFUnop,    fpUnop  : vmi_FQNEG                         },
    [RV_IT_FSGNJ_R]          = {fpConfig:RVFP_NORMAL, morph:emitFSgn,     clearFS1:1, negFS2:0,                       },
    [RV_IT_FSGNJN_R]         = {fpConfig:RVFP_NORMAL, morph:emitFSgn,     clearFS1:1, negFS2:1,                       },
    [RV_IT_FSGNJX_R]         = {fpConfig:RVFP_NORMAL, morph:emitFSgn,     clearFS1:0, negFS2:0,                       },
    [RV_IT_FSQRT_R]          = {fpConfig:RVFP_NORMAL, morph:emitFUnop,    fpUnop  : vmi_FSQRT,  iClass:OCL_IC_SQRT    },
    [RV_IT_FSUB_R]           = {fpConfig:RVFP_NORMAL, morph:emitFBinop,   fpBinop : vmi_FSUB                          },

    // F-extension and D-extension R4-type instructions
    [RV_IT_FMADD_R4]         = {fpConfig:RVFP_NORMAL, morph:emitFTernop,  fpTernop: vmi_FMADD,  iClass:OCL_IC_FMA     },
    [RV_IT_FMSUB_R4]         = {fpConfig:RVFP_NORMAL, morph:emitFTernop,  fpTernop: vmi_FMSUB,  iClass:OCL_IC_FMA     },
    [RV_IT_FNMADD_R4]        = {fpConfig:RVFP_NORMAL, morph:emitFTernop,  fpTernop: vmi_FNMADD, iClass:OCL_IC_FMA     },
    [RV_IT_FNMSUB_R4]        = {fpConfig:RVFP_NORMAL, morph:emitFTernop,  fpTernop: vmi_FNMSUB, iClass:OCL_IC_FMA     },

    // X-extension instructions
    [RV_IT_CUSTOM]           = {morph:emitCustomAbsent},

    // B-extension R-type instructions
    [RV_IT_ANDN_R]           = {morph:emitBinopRRR,  binop:vmi_ANDN, iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbbp,    K:RVBOP_Zbkb  }},
    [RV_IT_ORN_R]            = {morph:emitBinopRRR,  binop:vmi_ORN,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbbp,    K:RVBOP_Zbkb  }},
    [RV_IT_XNOR_R]           = {morph:emitBinopRRR,  binop:vmi_XNOR, iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbbp,    K:RVBOP_Zbkb  }},
    [RV_IT_SLO_R]            = {morph:emitShiftORRR, binop:vmi_SHL,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_SLO_SRO                }},
    [RV_IT_SRO_R]            = {morph:emitShiftORRR, binop:vmi_SHR,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_SLO_SRO                }},
    [RV_IT_ROL_R]            = {morph:emitBinopRRR,  binop:vmi_ROL,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbbp,    K:RVBOP_Zbkb  }},
    [RV_IT_ROR_R]            = {morph:emitBinopRRR,  binop:vmi_ROR,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbbp,    K:RVBOP_Zbkb  }},
    [RV_IT_SBCLR_R]          = {morph:emitSBitopRRR, binop:vmi_ANDN, iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbs                    }},
    [RV_IT_SBSET_R]          = {morph:emitSBitopRRR, binop:vmi_OR,   iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbs                    }},
    [RV_IT_SBINV_R]          = {morph:emitSBitopRRR, binop:vmi_XOR,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbs                    }},
    [RV_IT_SBEXT_R]          = {morph:emitEBitopRRR,                 iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbs                    }},
    [RV_IT_GORC_R]           = {morph:emit3264RRS,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_GORC                   }},
    [RV_IT_GREV_R]           = {morph:emit3264RRS,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_GREV                   }},
    [RV_IT_CLZ_R]            = {morph:emitUnopRR,    unop:vmi_CLZ,   iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_CTZ_R]            = {morph:emitUnopRR,    unop:vmi_CTZ,   iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_PCNT_R]           = {morph:emitUnopRR,    unop:vmi_CNTO,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_SEXT_R]           = {morph:emitMoveExtendRR,              iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_CRC32_R]          = {morph:emitCRC32,                     iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_CRC32                  }},
    [RV_IT_CRC32C_R]         = {morph:emitCRC32C,                    iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_CRC32                  }},
    [RV_IT_CLMUL_R]          = {morph:emitBinopRRR,  binop:vmi_PMUL, iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbc,     K:RVBOP_Zbkc  }},
    [RV_IT_CLMULR_R]         = {morph:emitCLMULR,    binop:vmi_PMUL, iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbc                    }},
    [RV_IT_CLMULH_R]         = {morph:emitCLMULH,    binop:vmi_PMUL, iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbc,     K:RVBOP_Zbkc  }},
    [RV_IT_MIN_R]            = {morph:emitBinopRRR,  binop:vmi_IMIN, iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_MAX_R]            = {morph:emitBinopRRR,  binop:vmi_IMAX, iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_MINU_R]           = {morph:emitBinopRRR,  binop:vmi_MIN,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_MAXU_R]           = {morph:emitBinopRRR,  binop:vmi_MAX,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_SHFL_R]           = {morph:emit3264RRS,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_SHFL                   }},
    [RV_IT_UNSHFL_R]         = {morph:emit3264RRS,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_UNSHFL                 }},
    [RV_IT_BDEP_R]           = {morph:emit3264RRR,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_BDEP                   }},
    [RV_IT_BEXT_R]           = {morph:emit3264RRR,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_BEXT                   }},
    [RV_IT_PACK_R]           = {morph:emitPACK,                      iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_PACK,    K:RVBOP_Zbkb  }},
    [RV_IT_PACKU_R]          = {morph:emitPACKU,                     iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_PACKU,   K:RVBOP_PACKU }},
    [RV_IT_PACKH_R]          = {morph:emitPACKH,                     iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_PACKH,   K:RVBOP_Zbkb  }},
    [RV_IT_PACKW_R]          = {morph:emitPACK,                      iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_PACKW,   K:RVBOP_Zbkb  }},
    [RV_IT_PACKUW_R]         = {morph:emitPACKU,                     iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_PACKUW,  K:RVBOP_PACKUW}},
    [RV_IT_ZEXT32_H_R]       = {morph:emitPACK,                      iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_ZEXT32_H               }},
    [RV_IT_ZEXT64_H_R]       = {morph:emitPACK,                      iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_ZEXT64_H               }},
    [RV_IT_BMATFLIP_R]       = {morph:emit3264RR,    opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_BMATFLIP               }},
    [RV_IT_BMATOR_R]         = {morph:emit3264RRR,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_BMATOR                 }},
    [RV_IT_BMATXOR_R]        = {morph:emit3264RRR,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_BMATXOR                }},
    [RV_IT_BFP_R]            = {morph:emit3264RRR,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_BFP                    }},
    [RV_IT_ADDWU_R]          = {morph:emitBinopRRRW, binop:vmi_ADD,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_SUBWU_R]          = {morph:emitBinopRRRW, binop:vmi_SUB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_ADDU_W_R]         = {morph:emitBinopWRRR, binop:vmi_ADD,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_ADD_UW                 }},
    [RV_IT_SUBU_W_R]         = {morph:emitBinopWRRR, binop:vmi_SUB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_SHADD_R]          = {morph:emitSHADD,     binop:vmi_ADD,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zba                    }},
    [RV_IT_XPERM_R]          = {morph:emit3264RRCR,  opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_XPERM,   K:RVBOP_XPERM }},

    // B-extension I-type instructions
    [RV_IT_SLOI_I]           = {morph:emitShiftORRC, binop:vmi_SHL,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_SLO_SRO                }},
    [RV_IT_SROI_I]           = {morph:emitShiftORRC, binop:vmi_SHR,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_SLO_SRO                }},
    [RV_IT_RORI_I]           = {morph:emitBinopRRC,  binop:vmi_ROR,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbbp,    K:RVBOP_Zbkb  }},
    [RV_IT_SBCLRI_I]         = {morph:emitSBitopRRC, binop:vmi_ANDN, iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbs                    }},
    [RV_IT_SBSETI_I]         = {morph:emitSBitopRRC, binop:vmi_OR,   iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbs                    }},
    [RV_IT_SBINVI_I]         = {morph:emitSBitopRRC, binop:vmi_XOR,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbs                    }},
    [RV_IT_SBEXTI_I]         = {morph:emitEBitopRRC,                 iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbs                    }},
    [RV_IT_GORCI_I]          = {morph:emit3264RRC,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_GORC,    K:RVBOP_GORCI }},
    [RV_IT_ORCB_I]           = {morph:emit3264RRC,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_ORCB,    K:RVBOP_GORCI }},
    [RV_IT_ORC16_I]          = {morph:emit3264RRC,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_ORC16                  }},
    [RV_IT_GREVI_I]          = {morph:emit3264RRC,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_GREV                   }},
    [RV_IT_REVB_I]           = {morph:emit3264RRC,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_GREV,    K:RVBOP_Zbkb  }},
    [RV_IT_REV8_I]           = {morph:emit3264RRC,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_REV8,    K:RVBOP_Zbkb  }},
    [RV_IT_REV8W_I]          = {morph:emit3264RRC,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_GREV,    K:RVBOP_REV8W }},
    [RV_IT_REV_I]            = {morph:emit3264RRC,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_REV,     K:RVBOP_Zbkb  }},
    [RV_IT_SHFLI_I]          = {morph:emit3264RRC,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_SHFL,    K:RVBOP_Zbkb  }},
    [RV_IT_UNSHFLI_I]        = {morph:emit3264RRC,   opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_UNSHFL,  K:RVBOP_Zbkb  }},
    [RV_IT_ADDIWU_I]         = {morph:emitBinopRRCW, binop:vmi_ADD,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbb                    }},
    [RV_IT_SLLIU_W_I]        = {morph:emitBinopWRRC, binop:vmi_SHL,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_SLLI_UW                }},

    // B-extension R4-type instructions
    [RV_IT_CMIX_R4]          = {morph:emitCMIX,                      iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbt                    }},
    [RV_IT_CMOV_R4]          = {morph:emitCMOV,                      iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_Zbt                    }},
    [RV_IT_FSL_R4]           = {morph:emit3264RRSR,  opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_FSL                    }},
    [RV_IT_FSR_R4]           = {morph:emit3264RRSR,  opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_FSR                    }},

    // B-extension R3I-type instructions
    [RV_IT_FSRI_R3I]         = {morph:emit3264RRCR,  opCB:getBOpCB,  iClass:OCL_IC_INTEGER, bExtOp:{B:RVBOP_FSR                    }},

    // H-extension R-type instructions for load
    [RV_IT_HLV_R]            = {morph:emitLoad,  virtual:1},

    // H-extension R-type instructions for load-as-if-execute
    [RV_IT_HLVX_R]           = {morph:emitLoad,  virtual:1, execute:1},

    // H-extension S-type instructions for store
    [RV_IT_HSV_R]            = {morph:emitStore, virtual:1},

    // K-extension R-type LUT instructions
    [RV_IT_LUT4LO_R]         = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_LUT4LO},
    [RV_IT_LUT4HI_R]         = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_LUT4HI},
    [RV_IT_LUT4_R]           = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_LUT4  },

    // K-extension R-type SAES32 instructions
    [RV_IT_SAES32_ENCS_R]    = {morph:emit3264RRCR, opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES32_ENCS },
    [RV_IT_SAES32_ENCSM_R]   = {morph:emit3264RRCR, opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES32_ENCSM},
    [RV_IT_SAES32_DECS_R]    = {morph:emit3264RRCR, opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES32_DECS },
    [RV_IT_SAES32_DECSM_R]   = {morph:emit3264RRCR, opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES32_DECSM},

    // K-extension R-type SSM3/SSM4 instructions
    [RV_IT_SSM3_P0_R]        = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSM3_P0},
    [RV_IT_SSM3_P1_R]        = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSM3_P1},
    [RV_IT_SSM4_ED_R]        = {morph:emit3264RRCR, opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSM4_ED},
    [RV_IT_SSM4_KS_R]        = {morph:emit3264RRCR, opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSM4_KS},

    // K-extension R-type SAES64 instructions
    [RV_IT_SAES64_KS1_R]     = {morph:emit3264RRC,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES64_KS1  },
    [RV_IT_SAES64_KS2_R]     = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES64_KS2  },
    [RV_IT_SAES64_IMIX_R]    = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES64_IMIX },
    [RV_IT_SAES64_ENCS_R]    = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES64_ENCS },
    [RV_IT_SAES64_ENCSM_R]   = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES64_ENCSM},
    [RV_IT_SAES64_DECS_R]    = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES64_DECS },
    [RV_IT_SAES64_DECSM_R]   = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SAES64_DECSM},

    // K-extension R-type SSHA256 instructions
    [RV_IT_SSHA256_SIG0_R]   = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA256_SIG0},
    [RV_IT_SSHA256_SIG1_R]   = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA256_SIG1},
    [RV_IT_SSHA256_SUM0_R]   = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA256_SUM0},
    [RV_IT_SSHA256_SUM1_R]   = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA256_SUM1},

    // K-extension R-type SSHA512 instructions
    [RV_IT_SSHA512_SIG0L_R]  = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA512_SIG0L},
    [RV_IT_SSHA512_SIG0H_R]  = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA512_SIG0H},
    [RV_IT_SSHA512_SIG1L_R]  = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA512_SIG1L},
    [RV_IT_SSHA512_SIG1H_R]  = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA512_SIG1H},
    [RV_IT_SSHA512_SUM0R_R]  = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA512_SUM0R},
    [RV_IT_SSHA512_SUM1R_R]  = {morph:emit3264RRR,  opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA512_SUM1R},
    [RV_IT_SSHA512_SIG0_R]   = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA512_SIG0 },
    [RV_IT_SSHA512_SIG1_R]   = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA512_SIG1 },
    [RV_IT_SSHA512_SUM0_R]   = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA512_SUM0 },
    [RV_IT_SSHA512_SUM1_R]   = {morph:emit3264RR,   opCB:getKOpCB, iClass:OCL_IC_INTEGER, kExtOp:RVKOP_SSHA512_SUM1 },

    // V-extension R-type instructions
    [RV_IT_VSETVL_R]         = {morph:emitVSetVLRRR},

    // V-extension I-type
    [RV_IT_VSETVL_I]         = {morph:emitVSetVLRRC},

    // V-extension load/store instructions
    [RV_IT_VL_I]             = {morph:emitVectorOp, opTCB:emitVLdUCB, checkCB:emitVLdStCheckUCB, initCB:emitVLdStInitCB, vstart0:RVVS_ANY, vShape:RVVW_V1I_V1I_V1I_LD},
    [RV_IT_VLS_I]            = {morph:emitVectorOp, opTCB:emitVLdSCB, checkCB:emitVLdStCheckSCB, initCB:emitVLdStInitCB, vstart0:RVVS_ANY, vShape:RVVW_V1I_V1I_V1I_LD},
    [RV_IT_VLX_I]            = {morph:emitVectorOp, opTCB:emitVLdICB, checkCB:emitVLdStCheckXCB, initCB:emitVLdStInitCB, vstart0:RVVS_ANY, vShape:RVVW_V1I_V1I_V1I_LD},
    [RV_IT_VS_I]             = {morph:emitVectorOp, opTCB:emitVStUCB, checkCB:emitVLdStCheckUCB, initCB:emitVLdStInitCB, vstart0:RVVS_ANY, vShape:RVVW_V1I_V1I_V1I_ST},
    [RV_IT_VSS_I]            = {morph:emitVectorOp, opTCB:emitVStSCB, checkCB:emitVLdStCheckSCB, initCB:emitVLdStInitCB, vstart0:RVVS_ANY, vShape:RVVW_V1I_V1I_V1I_ST},
    [RV_IT_VSX_I]            = {morph:emitVectorOp, opTCB:emitVStICB, checkCB:emitVLdStCheckXCB, initCB:emitVLdStInitCB, vstart0:RVVS_ANY, vShape:RVVW_V1I_V1I_V1I_ST},

    // V-extension AMO operations (Zvamo)
    [RV_IT_VAMOADD_R]        = {morph:emitVectorOp, opTCB:emitVAMOBinopRRR, checkCB:emitVAMOCheckCB, binop:vmi_ADD,  vstart0:RVVS_ANY},
    [RV_IT_VAMOAND_R]        = {morph:emitVectorOp, opTCB:emitVAMOBinopRRR, checkCB:emitVAMOCheckCB, binop:vmi_AND,  vstart0:RVVS_ANY},
    [RV_IT_VAMOMAX_R]        = {morph:emitVectorOp, opTCB:emitVAMOBinopRRR, checkCB:emitVAMOCheckCB, binop:vmi_IMAX, vstart0:RVVS_ANY},
    [RV_IT_VAMOMAXU_R]       = {morph:emitVectorOp, opTCB:emitVAMOBinopRRR, checkCB:emitVAMOCheckCB, binop:vmi_MAX,  vstart0:RVVS_ANY},
    [RV_IT_VAMOMIN_R]        = {morph:emitVectorOp, opTCB:emitVAMOBinopRRR, checkCB:emitVAMOCheckCB, binop:vmi_IMIN, vstart0:RVVS_ANY},
    [RV_IT_VAMOMINU_R]       = {morph:emitVectorOp, opTCB:emitVAMOBinopRRR, checkCB:emitVAMOCheckCB, binop:vmi_MIN,  vstart0:RVVS_ANY},
    [RV_IT_VAMOOR_R]         = {morph:emitVectorOp, opTCB:emitVAMOBinopRRR, checkCB:emitVAMOCheckCB, binop:vmi_OR,   vstart0:RVVS_ANY},
    [RV_IT_VAMOSWAP_R]       = {morph:emitVectorOp, opTCB:emitVAMOSwapRRR,  checkCB:emitVAMOCheckCB,                 vstart0:RVVS_ANY},
    [RV_IT_VAMOXOR_R]        = {morph:emitVectorOp, opTCB:emitVAMOBinopRRR, checkCB:emitVAMOCheckCB, binop:vmi_XOR,  vstart0:RVVS_ANY},

    // V-extension IVV/IVX-type common instructions
    [RV_IT_VMERGE_VR]        = {morph:emitVectorOp, opTCB:emitVRMERGETCB,   opFCB:emitVRMERGEFCB                                                                      },
    [RV_IT_VADD_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_ADD                                                    },
    [RV_IT_VSUB_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_SUB                                                    },
    [RV_IT_VRSUB_VR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_RSUB                                                   },
    [RV_IT_VMINU_VR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_MIN                                                    },
    [RV_IT_VMIN_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_IMIN                                                   },
    [RV_IT_VMAXU_VR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_MAX                                                    },
    [RV_IT_VMAX_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_IMAX                                                   },
    [RV_IT_VAND_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_AND                                                    },
    [RV_IT_VOR_VR]           = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_OR                                                     },
    [RV_IT_VXOR_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_XOR                                                    },
    [RV_IT_VADC_VR]          = {morph:emitVectorOp, opTCB:emitVRAdcIntCB,                            binop:vmi_ADC,      vShape:RVVW_V1I_V1I_V1I_CIN                  },
    [RV_IT_VMADC_VR]         = {morph:emitVectorOp, opTCB:emitVRAdcIntCB,                            binop:vmi_ADC,      vShape:RVVW_P1I_V1I_V1I_CIN                  },
    [RV_IT_VSBC_VR]          = {morph:emitVectorOp, opTCB:emitVRAdcIntCB,                            binop:vmi_SBB,      vShape:RVVW_V1I_V1I_V1I_CIN                  },
    [RV_IT_VMSBC_VR]         = {morph:emitVectorOp, opTCB:emitVRAdcIntCB,                            binop:vmi_SBB,      vShape:RVVW_P1I_V1I_V1I_CIN                  },
    [RV_IT_VSLL_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_SHL                                                    },
    [RV_IT_VSRL_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_SHR                                                    },
    [RV_IT_VSRA_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_SAR                                                    },
    [RV_IT_VNSRL_VR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_SHR,      vShape:RVVW_V1I_V2I_V1I                      },
    [RV_IT_VNSRA_VR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_SAR,      vShape:RVVW_V1I_V2I_V1I                      },
    [RV_IT_VSEQ_VR]          = {morph:emitVectorOp, opTCB:emitVRCmpIntCB,                            cond :vmi_COND_EQ,  vShape:RVVW_P1I_V1I_V1I                      },
    [RV_IT_VSNE_VR]          = {morph:emitVectorOp, opTCB:emitVRCmpIntCB,                            cond :vmi_COND_NE,  vShape:RVVW_P1I_V1I_V1I                      },
    [RV_IT_VSLTU_VR]         = {morph:emitVectorOp, opTCB:emitVRCmpIntCB,                            cond :vmi_COND_B,   vShape:RVVW_P1I_V1I_V1I                      },
    [RV_IT_VSLT_VR]          = {morph:emitVectorOp, opTCB:emitVRCmpIntCB,                            cond :vmi_COND_L,   vShape:RVVW_P1I_V1I_V1I                      },
    [RV_IT_VSLEU_VR]         = {morph:emitVectorOp, opTCB:emitVRCmpIntCB,                            cond :vmi_COND_BE,  vShape:RVVW_P1I_V1I_V1I                      },
    [RV_IT_VSLE_VR]          = {morph:emitVectorOp, opTCB:emitVRCmpIntCB,                            cond :vmi_COND_LE,  vShape:RVVW_P1I_V1I_V1I                      },
    [RV_IT_VSGTU_VR]         = {morph:emitVectorOp, opTCB:emitVRCmpIntCB,                            cond :vmi_COND_NBE, vShape:RVVW_P1I_V1I_V1I                      },
    [RV_IT_VSGT_VR]          = {morph:emitVectorOp, opTCB:emitVRCmpIntCB,                            cond :vmi_COND_NLE, vShape:RVVW_P1I_V1I_V1I                      },
    [RV_IT_VRGATHER_VR]      = {morph:emitVectorOp, opTCB:emitVRRGATHERCB,                                               vShape:RVVW_V1I_V1I_V1I_GR                   },
    [RV_IT_VSLIDEUP_VR]      = {morph:emitVectorOp, opTCB:emitVRSLIDEUPCB,                                               vShape:RVVW_V1I_V1I_V1I_UP                   },
    [RV_IT_VSLIDEDOWN_VR]    = {morph:emitVectorOp, opTCB:emitVRSLIDEDOWNCB,                                             vShape:RVVW_V1I_V1I_V1I_DN                   },
    [RV_IT_VSADDU_VR]        = {morph:emitVectorOp, opTCB:emitVRSBinaryCB,                           binop:vmi_ADDUQ,    vShape:RVVW_V1I_V1I_V1I_SAT,  argType:RVVX_UU},
    [RV_IT_VSADD_VR]         = {morph:emitVectorOp, opTCB:emitVRSBinaryCB,                           binop:vmi_ADDSQ,    vShape:RVVW_V1I_V1I_V1I_SAT,  argType:RVVX_SS},
    [RV_IT_VSSUBU_VR]        = {morph:emitVectorOp, opTCB:emitVRSBinaryCB,                           binop:vmi_SUBUQ,    vShape:RVVW_V1I_V1I_V1I_SAT,  argType:RVVX_UU},
    [RV_IT_VSSUB_VR]         = {morph:emitVectorOp, opTCB:emitVRSBinaryCB,                           binop:vmi_SUBSQ,    vShape:RVVW_V1I_V1I_V1I_SAT,  argType:RVVX_SS},
    [RV_IT_VAADDU_VR]        = {morph:emitVectorOp, opTCB:emitVRABinaryCB,                           binop:vmi_ADDUH,    vShape:RVVW_V1I_V1I_V1I_VXRM, argType:RVVX_UU},
    [RV_IT_VAADD_VR]         = {morph:emitVectorOp, opTCB:emitVRABinaryCB,                           binop:vmi_ADDSH,    vShape:RVVW_V1I_V1I_V1I_VXRM, argType:RVVX_SS},
    [RV_IT_VASUBU_VR]        = {morph:emitVectorOp, opTCB:emitVRABinaryCB,                           binop:vmi_SUBUH,    vShape:RVVW_V1I_V1I_V1I_VXRM, argType:RVVX_UU},
    [RV_IT_VASUB_VR]         = {morph:emitVectorOp, opTCB:emitVRABinaryCB,                           binop:vmi_SUBSH,    vShape:RVVW_V1I_V1I_V1I_VXRM, argType:RVVX_SS},
    [RV_IT_VSMUL_VR]         = {morph:emitVectorOp, opTCB:emitVRSMULCB,    checkCB:emitNoEmbEEW64CB, binop:vmi_IMUL,     vShape:RVVW_V1I_V1I_V1I_SAT,  argType:RVVX_SS},
    [RV_IT_VWSMACCU_VR]      = {morph:emitVectorOp, opTCB:emitVRSMAccIntCB,                          binop:vmi_ADDUQ,    vShape:RVVW_V2I_V1I_V1I_SAT,  argType:RVVX_UU},
    [RV_IT_VWSMACC_VR]       = {morph:emitVectorOp, opTCB:emitVRSMAccIntCB,                          binop:vmi_ADDSQ,    vShape:RVVW_V2I_V1I_V1I_SAT,  argType:RVVX_SS},
    [RV_IT_VWSMACCSU_VR]     = {morph:emitVectorOp, opTCB:emitVRSMAccIntCB,                          binop:vmi_ADDSQ,    vShape:RVVW_V2I_V1I_V1I_SAT,  argType:RVVX_SU},
    [RV_IT_VWSMACCUS_VR]     = {morph:emitVectorOp, opTCB:emitVRSMAccIntCB,                          binop:vmi_ADDSQ,    vShape:RVVW_V2I_V1I_V1I_SAT,  argType:RVVX_US},
    [RV_IT_VSSRL_VR]         = {morph:emitVectorOp, opTCB:emitVRRShiftIntCB,                         binop:vmi_SHR,      vShape:RVVW_V1I_V1I_V1I_VXRM                 },
    [RV_IT_VSSRA_VR]         = {morph:emitVectorOp, opTCB:emitVRRShiftIntCB,                         binop:vmi_SAR,      vShape:RVVW_V1I_V1I_V1I_VXRM                 },
    [RV_IT_VNCLIPU_VR]       = {morph:emitVectorOp, opTCB:emitVRRShiftIntCB,                         binop:vmi_SHR,      vShape:RVVW_V1I_V2I_V1I_SAT,  argType:RVVX_UU},
    [RV_IT_VNCLIP_VR]        = {morph:emitVectorOp, opTCB:emitVRRShiftIntCB,                         binop:vmi_SAR,      vShape:RVVW_V1I_V2I_V1I_SAT,  argType:RVVX_SS},

    // V-extension MVV/MVX-type common instructions
    [RV_IT_VDIVU_VR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_DIV                                                  },
    [RV_IT_VDIV_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_IDIV                                                 },
    [RV_IT_VREMU_VR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_REM                                                  },
    [RV_IT_VREM_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_IREM                                                 },
    [RV_IT_VMUL_VR]          = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_IMUL                                                 },
    [RV_IT_VMULHU_VR]        = {morph:emitVectorOp, opTCB:emitVRMulHIntCB, checkCB:emitNoEmbEEW64CB, binop:vmi_MUL                                                  },
    [RV_IT_VMULHSU_VR]       = {morph:emitVectorOp, opTCB:emitVRMulHIntCB, checkCB:emitNoEmbEEW64CB, binop:vmi_IMULSU                                               },
    [RV_IT_VMULH_VR]         = {morph:emitVectorOp, opTCB:emitVRMulHIntCB, checkCB:emitNoEmbEEW64CB, binop:vmi_IMUL                                                 },
    [RV_IT_VWMULU_VR]        = {morph:emitVectorOp, opTCB:emitVRWMulHIntCB,                          binop:vmi_MUL,      vShape:RVVW_V2I_V1I_V1I_IW, argType:RVVX_UU},
    [RV_IT_VWMULSU_VR]       = {morph:emitVectorOp, opTCB:emitVRWMulHIntCB,                          binop:vmi_IMULSU,   vShape:RVVW_V2I_V1I_V1I_IW, argType:RVVX_SU},
    [RV_IT_VWMUL_VR]         = {morph:emitVectorOp, opTCB:emitVRWMulHIntCB,                          binop:vmi_IMUL,     vShape:RVVW_V2I_V1I_V1I_IW, argType:RVVX_SS},
    [RV_IT_VWADDU_VR]        = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_ADD,      vShape:RVVW_V2I_V1I_V1I,    argType:RVVX_UU},
    [RV_IT_VWADD_VR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_ADD,      vShape:RVVW_V2I_V1I_V1I,    argType:RVVX_SS},
    [RV_IT_VWSUBU_VR]        = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_SUB,      vShape:RVVW_V2I_V1I_V1I,    argType:RVVX_UU},
    [RV_IT_VWSUB_VR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_SUB,      vShape:RVVW_V2I_V1I_V1I,    argType:RVVX_SS},
    [RV_IT_VWADDU_WR]        = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_ADD,      vShape:RVVW_V2I_V2I_V1I,    argType:RVVX_UU},
    [RV_IT_VWADD_WR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_ADD,      vShape:RVVW_V2I_V2I_V1I,    argType:RVVX_SS},
    [RV_IT_VWSUBU_WR]        = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_SUB,      vShape:RVVW_V2I_V2I_V1I,    argType:RVVX_UU},
    [RV_IT_VWSUB_WR]         = {morph:emitVectorOp, opTCB:emitVRBinaryIntCB,                         binop:vmi_SUB,      vShape:RVVW_V2I_V2I_V1I,    argType:RVVX_SS},
    [RV_IT_VMADD_VR]         = {morph:emitVectorOp, opTCB:emitVRMAddIntCB,                           binop:vmi_ADD,                                                 },
    [RV_IT_VNMSUB_VR]        = {morph:emitVectorOp, opTCB:emitVRMAddIntCB,                           binop:vmi_SUB,                                                 },
    [RV_IT_VMACC_VR]         = {morph:emitVectorOp, opTCB:emitVRMAccIntCB,                           binop:vmi_ADD,                                                 },
    [RV_IT_VNMSAC_VR]        = {morph:emitVectorOp, opTCB:emitVRMAccIntCB,                           binop:vmi_SUB,                                                 },
    [RV_IT_VWMACCU_VR]       = {morph:emitVectorOp, opTCB:emitVRMAccIntCB,                           binop:vmi_ADD,      vShape:RVVW_V2I_V1I_V1I,    argType:RVVX_UU},
    [RV_IT_VWMACC_VR]        = {morph:emitVectorOp, opTCB:emitVRMAccIntCB,                           binop:vmi_ADD,      vShape:RVVW_V2I_V1I_V1I,    argType:RVVX_SS},
    [RV_IT_VWMACCSU_VR]      = {morph:emitVectorOp, opTCB:emitVRMAccIntCB,                           binop:vmi_ADD,      vShape:RVVW_V2I_V1I_V1I,    argType:RVVX_SU},
    [RV_IT_VWMACCUS_VR]      = {morph:emitVectorOp, opTCB:emitVRMAccIntCB,                           binop:vmi_ADD,      vShape:RVVW_V2I_V1I_V1I,    argType:RVVX_US},

    // V-extension MVV/MVX-type common instructions (Zvqmac extension)
    [RV_IT_VQMACCU_VR]       = {morph:emitVectorOp, opTCB:emitVRMAccIntCB, checkCB:emitQMACCheckCB,  binop:vmi_ADD,      vShape:RVVW_V4I_V1I_V1I,    argType:RVVX_UU},
    [RV_IT_VQMACC_VR]        = {morph:emitVectorOp, opTCB:emitVRMAccIntCB, checkCB:emitQMACCheckCB,  binop:vmi_ADD,      vShape:RVVW_V4I_V1I_V1I,    argType:RVVX_SS},
    [RV_IT_VQMACCSU_VR]      = {morph:emitVectorOp, opTCB:emitVRMAccIntCB, checkCB:emitQMACCheckCB,  binop:vmi_ADD,      vShape:RVVW_V4I_V1I_V1I,    argType:RVVX_SU},
    [RV_IT_VQMACCUS_VR]      = {morph:emitVectorOp, opTCB:emitVRMAccIntCB, checkCB:emitQMACCheckCB,  binop:vmi_ADD,      vShape:RVVW_V4I_V1I_V1I,    argType:RVVX_US},

    // V-extension IVV-type instructions
    [RV_IT_VWREDSUMU_VS]     = {morph:emitVectorOp, opTCB:emitVRedBinaryIntCB, initCB:initVRedCB, endCB:endVRedCB, binop:vmi_ADD, vShape:RVVW_S2I_V1I_S2I, argType:RVVX_UU, vstart0:RVVS_ZERO},
    [RV_IT_VWREDSUM_VS]      = {morph:emitVectorOp, opTCB:emitVRedBinaryIntCB, initCB:initVRedCB, endCB:endVRedCB, binop:vmi_ADD, vShape:RVVW_S2I_V1I_S2I, argType:RVVX_SS, vstart0:RVVS_ZERO},
    [RV_IT_VDOTU_VV]         = {morph:emitVectorOp, checkCB:emitEDIVCheckCB},
    [RV_IT_VDOT_VV]          = {morph:emitVectorOp, checkCB:emitEDIVCheckCB},

    // V-extension FVV/FVF-type common instructions
    [RV_IT_VFMERGE_VR]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMERGETCB, opFCB:emitVRMERGEFCB,    vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFADD_VR]         = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FADD,   vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFSUB_VR]         = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FSUB,   vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFRSUB_VR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltRCB, fpBinop: vmi_FSUB,   vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFMUL_VR]         = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FMUL,   vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFDIV_VR]         = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FDIV,   vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFRDIV_VR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltRCB, fpBinop: vmi_FDIV,   vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFWADD_VR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FADD,   vShape:RVVW_V2F_V1F_V1F},
    [RV_IT_VFWSUB_VR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FSUB,   vShape:RVVW_V2F_V1F_V1F},
    [RV_IT_VFWADD_WR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FADD,   vShape:RVVW_V2F_V2F_V1F},
    [RV_IT_VFWSUB_WR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FSUB,   vShape:RVVW_V2F_V2F_V1F},
    [RV_IT_VFWMUL_VR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FMUL,   vShape:RVVW_V2F_V1F_V1F},
    [RV_IT_VFMADD_VR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAddFltCB,    fpTernop:vmi_FMADD,  vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFNMADD_VR]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAddFltCB,    fpTernop:vmi_FNMADD, vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFMSUB_VR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAddFltCB,    fpTernop:vmi_FMSUB,  vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFNMSUB_VR]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAddFltCB,    fpTernop:vmi_FNMSUB, vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFMACC_VR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAccFltCB,    fpTernop:vmi_FMADD,  vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFNMACC_VR]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAccFltCB,    fpTernop:vmi_FNMADD, vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFMSAC_VR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAccFltCB,    fpTernop:vmi_FMSUB,  vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFNMSAC_VR]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAccFltCB,    fpTernop:vmi_FNMSUB, vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFWMACC_VR]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAccFltCB,    fpTernop:vmi_FMADD,  vShape:RVVW_V2F_V1F_V1F},
    [RV_IT_VFWNMACC_VR]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAccFltCB,    fpTernop:vmi_FNMADD, vShape:RVVW_V2F_V1F_V1F},
    [RV_IT_VFWMSAC_VR]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAccFltCB,    fpTernop:vmi_FMSUB,  vShape:RVVW_V2F_V1F_V1F},
    [RV_IT_VFWNMSAC_VR]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRMAccFltCB,    fpTernop:vmi_FNMSUB, vShape:RVVW_V2F_V1F_V1F},
    [RV_IT_VFSQRT_V]         = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRUnaryFltCB,   fpUnop:  vmi_FSQRT,  vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFRSQRTE7_V]      = {fpConfig:RVFP_FRSRE7, morph:emitVectorOp, opTCB:emitVRUnaryFltCB,   fpUnop:  vmi_FUNUD,  vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFRECE7_V]        = {fpConfig:RVFP_FRECE7, morph:emitVectorOp, opTCB:emitVRUnaryFltCB,   fpUnop:  vmi_FUNUD,  vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFMIN_VR]         = {fpConfig:RVFP_FMIN,   morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FMIN,   vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFMAX_VR]         = {fpConfig:RVFP_FMAX,   morph:emitVectorOp, opTCB:emitVRBinaryFltCB,  fpBinop: vmi_FMAX,   vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFSGNJ_VR]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFSgnFltCB,    clearFS1:1,negFS2:0, vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFSGNJN_VR]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFSgnFltCB,    clearFS1:1,negFS2:1, vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFSGNJX_VR]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFSgnFltCB,    clearFS1:0,negFS2:0, vShape:RVVW_V1F_V1F_V1F},
    [RV_IT_VFORD_VR]         = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFCmpFltCB,    fpRel:RVFCMP_ORD,    vShape:RVVW_P1I_V1F_V1F},
    [RV_IT_VFEQ_VR]          = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFCmpFltCB,    fpRel:RVFCMP_EQ,     vShape:RVVW_P1I_V1F_V1F},
    [RV_IT_VFNE_VR]          = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFCmpFltCB,    fpRel:RVFCMP_NE,     vShape:RVVW_P1I_V1F_V1F},
    [RV_IT_VFLE_VR]          = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFCmpFltCB,    fpRel:RVFCMP_LE,     vShape:RVVW_P1I_V1F_V1F},
    [RV_IT_VFLT_VR]          = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFCmpFltCB,    fpRel:RVFCMP_LT,     vShape:RVVW_P1I_V1F_V1F},
    [RV_IT_VFGE_VR]          = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFCmpFltCB,    fpRel:RVFCMP_GE,     vShape:RVVW_P1I_V1F_V1F},
    [RV_IT_VFGT_VR]          = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFCmpFltCB,    fpRel:RVFCMP_GT,     vShape:RVVW_P1I_V1F_V1F},

    // V-extension FVV-type instructions
    [RV_IT_VFREDSUM_VS]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRedBinaryFltCB, initCB:initVRedCB, endCB:endVRedCB, fpBinop:vmi_FADD, vShape:RVVW_S1F_V1F_S1F, vstart0:RVVS_ZERO},
    [RV_IT_VFREDOSUM_VS]     = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRedBinaryFltCB, initCB:initVRedCB, endCB:endVRedCB, fpBinop:vmi_FADD, vShape:RVVW_S1F_V1F_S1F, vstart0:RVVS_ZERO},
    [RV_IT_VFREDMIN_VS]      = {fpConfig:RVFP_FMIN,   morph:emitVectorOp, opTCB:emitVRedBinaryFltCB, initCB:initVRedCB, endCB:endVRedCB, fpBinop:vmi_FMIN, vShape:RVVW_S1F_V1F_S1F, vstart0:RVVS_ZERO},
    [RV_IT_VFREDMAX_VS]      = {fpConfig:RVFP_FMAX,   morph:emitVectorOp, opTCB:emitVRedBinaryFltCB, initCB:initVRedCB, endCB:endVRedCB, fpBinop:vmi_FMAX, vShape:RVVW_S1F_V1F_S1F, vstart0:RVVS_ZERO},
    [RV_IT_VFMV_F_S]         = {                      morph:emitScalarOp, opTCB:emitVFMVFS,         vShape:RVVW_V1F_S1F_V1F                   },
    [RV_IT_VFCVT_XUF_V]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V1I_V1F,       argType:RVVX_UU},
    [RV_IT_VFCVT_XF_V]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V1I_V1F,       argType:RVVX_SS},
    [RV_IT_VFCVT_FXU_V]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V1F_V1I,       argType:RVVX_UU},
    [RV_IT_VFCVT_FX_V]       = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V1F_V1I,       argType:RVVX_SS},
    [RV_IT_VFWCVT_XUF_V]     = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V2I_V1F,       argType:RVVX_UU},
    [RV_IT_VFWCVT_XF_V]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V2I_V1F,       argType:RVVX_SS},
    [RV_IT_VFWCVT_FXU_V]     = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V2F_V1I,       argType:RVVX_UU},
    [RV_IT_VFWCVT_FX_V]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V2F_V1I,       argType:RVVX_SS},
    [RV_IT_VFWCVT_FF_V]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V2F_V1F_V1F_IW                },
    [RV_IT_VFNCVT_XUF_V]     = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V1I_V2F_IW,    argType:RVVX_UU},
    [RV_IT_VFNCVT_XF_V]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V1I_V2F_IW,    argType:RVVX_SS},
    [RV_IT_VFNCVT_FXU_V]     = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V1F_V2I_IW,    argType:RVVX_UU},
    [RV_IT_VFNCVT_FX_V]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V1F_V2I_IW,    argType:RVVX_SS},
    [RV_IT_VFNCVT_FF_V]      = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRConvertFltCB, vShape:RVVW_V1F_V2F_V1F_IW                },
    [RV_IT_VFCLASS_V]        = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRFClassFltCB,  vShape:RVVW_V1F_V1F_V1F                   },
    [RV_IT_VFWREDSUM_VS]     = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRedBinaryFltCB, initCB:initVRedCB, endCB:endVRedCB, fpBinop:vmi_FADD, vShape:RVVW_S2F_V1F_S2F, vstart0:RVVS_ZERO},
    [RV_IT_VFWREDOSUM_VS]    = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, opTCB:emitVRedBinaryFltCB, initCB:initVRedCB, endCB:endVRedCB, fpBinop:vmi_FADD, vShape:RVVW_S2F_V1F_S2F, vstart0:RVVS_ZERO},
    [RV_IT_VFDOT_VV]         = {fpConfig:RVFP_NORMAL, morph:emitVectorOp, checkCB:emitEDIVCheckCB,  vShape:RVVW_V1F_V1F_V1F                   },

    // V-extension MVV-type instructions
    [RV_IT_VREDSUM_VS]       = {morph:emitVectorOp, opTCB:emitVRedBinaryIntCB, initCB:initVRedCB, endCB:endVRedCB, binop:vmi_ADD,  vShape:RVVW_S1I_V1I_S1I,     vstart0:RVVS_ZERO},
    [RV_IT_VREDAND_VS]       = {morph:emitVectorOp, opTCB:emitVRedBinaryIntCB, initCB:initVRedCB, endCB:endVRedCB, binop:vmi_AND,  vShape:RVVW_S1I_V1I_S1I,     vstart0:RVVS_ZERO},
    [RV_IT_VREDOR_VS]        = {morph:emitVectorOp, opTCB:emitVRedBinaryIntCB, initCB:initVRedCB, endCB:endVRedCB, binop:vmi_OR,   vShape:RVVW_S1I_V1I_S1I,     vstart0:RVVS_ZERO},
    [RV_IT_VREDXOR_VS]       = {morph:emitVectorOp, opTCB:emitVRedBinaryIntCB, initCB:initVRedCB, endCB:endVRedCB, binop:vmi_XOR,  vShape:RVVW_S1I_V1I_S1I,     vstart0:RVVS_ZERO},
    [RV_IT_VREDMINU_VS]      = {morph:emitVectorOp, opTCB:emitVRedBinaryIntCB, initCB:initVRedCB, endCB:endVRedCB, binop:vmi_MIN,  vShape:RVVW_S1I_V1I_S1I,     vstart0:RVVS_ZERO},
    [RV_IT_VREDMIN_VS]       = {morph:emitVectorOp, opTCB:emitVRedBinaryIntCB, initCB:initVRedCB, endCB:endVRedCB, binop:vmi_IMIN, vShape:RVVW_S1I_V1I_S1I,     vstart0:RVVS_ZERO},
    [RV_IT_VREDMAXU_VS]      = {morph:emitVectorOp, opTCB:emitVRedBinaryIntCB, initCB:initVRedCB, endCB:endVRedCB, binop:vmi_MAX,  vShape:RVVW_S1I_V1I_S1I,     vstart0:RVVS_ZERO},
    [RV_IT_VREDMAX_VS]       = {morph:emitVectorOp, opTCB:emitVRedBinaryIntCB, initCB:initVRedCB, endCB:endVRedCB, binop:vmi_IMAX, vShape:RVVW_S1I_V1I_S1I,     vstart0:RVVS_ZERO},
    [RV_IT_VEXT_X_V]         = {morph:emitScalarOp, opTCB:emitVEXTXV,                                                              vShape:RVVW_V1I_S1I_V1I,                      },
    [RV_IT_VPOPC_M]          = {morph:emitVectorOp, opTCB:emitVPOPCCB,                     checkCB:initVPOPCCB,                    vShape:RVVW_P1I_P1I_P1I,     vstart0:RVVS_ZERO},
    [RV_IT_VFIRST_M]         = {morph:emitVectorOp, opTCB:emitVFIRSTCB,                    checkCB:initVFIRSTCB,                   vShape:RVVW_P1I_P1I_P1I,     vstart0:RVVS_ZERO},
    [RV_IT_VMSBF_M]          = {morph:emitVectorOp, opTCB:emitVMSBFCB,                     initCB:initVMSFCB,                      vShape:RVVW_P1I_P1I_P1I_VMSF,vstart0:RVVS_ZERO},
    [RV_IT_VMSOF_M]          = {morph:emitVectorOp, opTCB:emitVMSOFCB,                     initCB:initVMSFCB,                      vShape:RVVW_P1I_P1I_P1I_VMSF,vstart0:RVVS_ZERO},
    [RV_IT_VMSIF_M]          = {morph:emitVectorOp, opTCB:emitVMSIFCB,                     initCB:initVMSFCB,                      vShape:RVVW_P1I_P1I_P1I_VMSF,vstart0:RVVS_ZERO},
    [RV_IT_VIOTA_M]          = {morph:emitVectorOp, opTCB:emitVIOTACB,                     initCB:initVIOTACB,                     vShape:RVVW_V1I_P1I_P1I_IOTA,vstart0:RVVS_ZERO},
    [RV_IT_VID_V]            = {morph:emitVectorOp, opTCB:emitVIDCB,                                                               vShape:RVVW_V1I_P1I_P1I_ID,                   },
    [RV_IT_VCOMPRESS_VM]     = {morph:emitVectorOp, opTCB:emitVCOMPRESSCB,                 initCB:initVCOMPRESSCB,                 vShape:RVVW_V1I_V1I_V1I_CMP, vstart0:RVVS_ZERO, implicitTZ:1},
    [RV_IT_VMAND_MM]         = {morph:emitVectorOp, opTCB:emitMBinaryCB, binop:vmi_AND,  vShape:RVVW_P1I_P1I_P1I},
    [RV_IT_VMANDNOT_MM]      = {morph:emitVectorOp, opTCB:emitMBinaryCB, binop:vmi_ANDN, vShape:RVVW_P1I_P1I_P1I},
    [RV_IT_VMOR_MM]          = {morph:emitVectorOp, opTCB:emitMBinaryCB, binop:vmi_OR,   vShape:RVVW_P1I_P1I_P1I},
    [RV_IT_VMXOR_MM]         = {morph:emitVectorOp, opTCB:emitMBinaryCB, binop:vmi_XOR,  vShape:RVVW_P1I_P1I_P1I},
    [RV_IT_VMORNOT_MM]       = {morph:emitVectorOp, opTCB:emitMBinaryCB, binop:vmi_ORN,  vShape:RVVW_P1I_P1I_P1I},
    [RV_IT_VMNAND_MM]        = {morph:emitVectorOp, opTCB:emitMBinaryCB, binop:vmi_NAND, vShape:RVVW_P1I_P1I_P1I},
    [RV_IT_VMNOR_MM]         = {morph:emitVectorOp, opTCB:emitMBinaryCB, binop:vmi_NOR,  vShape:RVVW_P1I_P1I_P1I},
    [RV_IT_VMXNOR_MM]        = {morph:emitVectorOp, opTCB:emitMBinaryCB, binop:vmi_XNOR, vShape:RVVW_P1I_P1I_P1I},

    // V-extension IVI-type instructions
    [RV_IT_VMERGE_VI]        = {morph:emitVectorOp, opTCB:emitVIMERGETCB, opFCB:emitVRMERGEFCB},
    [RV_IT_VADD_VI]          = {morph:emitVectorOp, opTCB:emitVIBinaryIntCB, binop:vmi_ADD},
    [RV_IT_VRSUB_VI]         = {morph:emitVectorOp, opTCB:emitVIBinaryIntCB, binop:vmi_RSUB},
    [RV_IT_VAND_VI]          = {morph:emitVectorOp, opTCB:emitVIBinaryIntCB, binop:vmi_AND},
    [RV_IT_VOR_VI]           = {morph:emitVectorOp, opTCB:emitVIBinaryIntCB, binop:vmi_OR },
    [RV_IT_VXOR_VI]          = {morph:emitVectorOp, opTCB:emitVIBinaryIntCB, binop:vmi_XOR},
    [RV_IT_VRGATHER_VI]      = {morph:emitVectorOp, opTCB:emitVIRGATHERCB,   initCB:initVIRGATHERCB, vShape:RVVW_V1I_V1I_V1I_GR},
    [RV_IT_VSLIDEUP_VI]      = {morph:emitVectorOp, opTCB:emitVISLIDEUPCB,                           vShape:RVVW_V1I_V1I_V1I_UP},
    [RV_IT_VSLIDEDOWN_VI]    = {morph:emitVectorOp, opTCB:emitVISLIDEDOWNCB,                         vShape:RVVW_V1I_V1I_V1I_DN},
    [RV_IT_VADC_VI]          = {morph:emitVectorOp, opTCB:emitVIAdcIntCB,    binop:vmi_ADC,          vShape:RVVW_V1I_V1I_V1I_CIN},
    [RV_IT_VMADC_VI]         = {morph:emitVectorOp, opTCB:emitVIAdcIntCB,    binop:vmi_ADC,          vShape:RVVW_P1I_V1I_V1I_CIN},
    [RV_IT_VSEQ_VI]          = {morph:emitVectorOp, opTCB:emitVICmpIntCB,    cond :vmi_COND_EQ,      vShape:RVVW_P1I_V1I_V1I},
    [RV_IT_VSNE_VI]          = {morph:emitVectorOp, opTCB:emitVICmpIntCB,    cond :vmi_COND_NE,      vShape:RVVW_P1I_V1I_V1I},
    [RV_IT_VSLEU_VI]         = {morph:emitVectorOp, opTCB:emitVICmpIntCB,    cond :vmi_COND_BE,      vShape:RVVW_P1I_V1I_V1I},
    [RV_IT_VSLE_VI]          = {morph:emitVectorOp, opTCB:emitVICmpIntCB,    cond :vmi_COND_LE,      vShape:RVVW_P1I_V1I_V1I},
    [RV_IT_VSGTU_VI]         = {morph:emitVectorOp, opTCB:emitVICmpIntCB,    cond :vmi_COND_NBE,     vShape:RVVW_P1I_V1I_V1I},
    [RV_IT_VSGT_VI]          = {morph:emitVectorOp, opTCB:emitVICmpIntCB,    cond :vmi_COND_NLE,     vShape:RVVW_P1I_V1I_V1I},
    [RV_IT_VSADDU_VI]        = {morph:emitVectorOp, opTCB:emitVISBinaryCB,   binop:vmi_ADDUQ,        vShape:RVVW_V1I_V1I_V1I_SAT, argType:RVVX_UU},
    [RV_IT_VSADD_VI]         = {morph:emitVectorOp, opTCB:emitVISBinaryCB,   binop:vmi_ADDSQ,        vShape:RVVW_V1I_V1I_V1I_SAT, argType:RVVX_SS},
    [RV_IT_VAADD_VI]         = {morph:emitVectorOp, opTCB:emitVIABinaryCB,   binop:vmi_ADDSH,        vShape:RVVW_V1I_V1I_V1I_SAT, argType:RVVX_SS},
    [RV_IT_VSLL_VI]          = {morph:emitVectorOp, opTCB:emitVIShiftIntCB,  binop:vmi_SHL},
    [RV_IT_VMVR_VI]          = {morph:emitVectorOp, opTCB:emitVRUnaryIntCB,  unop :vmi_MOV, checkCB:emitVMVRCheckCB},
    [RV_IT_VSRL_VI]          = {morph:emitVectorOp, opTCB:emitVIShiftIntCB,  binop:vmi_SHR},
    [RV_IT_VSRA_VI]          = {morph:emitVectorOp, opTCB:emitVIShiftIntCB,  binop:vmi_SAR},
    [RV_IT_VSSRL_VI]         = {morph:emitVectorOp, opTCB:emitVIRShiftIntCB, binop:vmi_SHR,          vShape:RVVW_V1I_V1I_V1I_VXRM},
    [RV_IT_VSSRA_VI]         = {morph:emitVectorOp, opTCB:emitVIRShiftIntCB, binop:vmi_SAR,          vShape:RVVW_V1I_V1I_V1I_VXRM},
    [RV_IT_VNSRL_VI]         = {morph:emitVectorOp, opTCB:emitVIShiftIntCB,  binop:vmi_SHR,          vShape:RVVW_V1I_V2I_V1I},
    [RV_IT_VNSRA_VI]         = {morph:emitVectorOp, opTCB:emitVIShiftIntCB,  binop:vmi_SAR,          vShape:RVVW_V1I_V2I_V1I},
    [RV_IT_VNCLIPU_VI]       = {morph:emitVectorOp, opTCB:emitVIRShiftIntCB, binop:vmi_SHR,          vShape:RVVW_V1I_V2I_V1I_SAT, argType:RVVX_UU},
    [RV_IT_VNCLIP_VI]        = {morph:emitVectorOp, opTCB:emitVIRShiftIntCB, binop:vmi_SAR,          vShape:RVVW_V1I_V2I_V1I_SAT, argType:RVVX_SS},

    // V-extension FVF-type instructions
    [RV_IT_VFMV_S_F]         = {morph:emitScalarOp, opTCB:emitVFMVSF,                                vShape:RVVW_S1F_V1I_V1I},
    [RV_IT_VFSLIDE1UP_VF]    = {morph:emitVectorOp, opTCB:emitVRSLIDE1UPCB,   initCB:initVFSLIDE1CB, vShape:RVVW_V1F_V1F_V1I_UP},
    [RV_IT_VFSLIDE1DOWN_VF]  = {morph:emitVectorOp, opTCB:emitVRSLIDE1DOWNCB, initCB:initVFSLIDE1CB, vShape:RVVW_V1F_V1F_V1I_DN},

    // V-extension MVX-type instructions
    [RV_IT_VMV_S_X]          = {morph:emitScalarOp, opTCB:emitVMVSX,                                 vShape:RVVW_S1I_V1I_V1I},
    [RV_IT_VSLIDE1UP_VX]     = {morph:emitVectorOp, opTCB:emitVRSLIDE1UPCB,   initCB:initVXSLIDE1CB, vShape:RVVW_V1I_V1I_V1I_UP},
    [RV_IT_VSLIDE1DOWN_VX]   = {morph:emitVectorOp, opTCB:emitVRSLIDE1DOWNCB, initCB:initVXSLIDE1CB, vShape:RVVW_V1I_V1I_V1I_DN},
    [RV_IT_VZEXT_V]          = {morph:emitVectorOp, opTCB:emitVRUnaryIntCB,   unop :vmi_MOV,         vShape:RVVW_V1I_V2I_FN, argType:RVVX_UU},
    [RV_IT_VSEXT_V]          = {morph:emitVectorOp, opTCB:emitVRUnaryIntCB,   unop :vmi_MOV,         vShape:RVVW_V1I_V2I_FN, argType:RVVX_SS},

#if(ENABLE_P_EXT)

    // P-extension instructions (RV32 and RV64)
    [RV_IT_ADD_Sx]           = {morph:emitBinopRRR_Sx,   binop:vmi_ADD,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_AVE]              = {morph:emitBinopRRR,      binop:vmi_ADDSHR,                                                                          iClass:OCL_IC_INTEGER},
    [RV_IT_BITREV]           = {morph:emitBITREV,                                                                                                   iClass:OCL_IC_INTEGER},
    [RV_IT_BITREVI]          = {morph:emitBITREVI,                                                                                                  iClass:OCL_IC_INTEGER},
    [RV_IT_BPICK]            = {morph:emitBPICK,                                                                                                    iClass:OCL_IC_INTEGER},
    [RV_IT_CLRS_Sx]          = {morph:emitUnopRR_Sx,     unop :vmi_CLS,     pAttrs:RVPS____W_,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_CLO_Sx]           = {morph:emitUnopRR_Sx,     unop :vmi_CLO,     pAttrs:RVPS____W_,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_CLZ_Sx]           = {morph:emitUnopRR_Sx,     unop :vmi_CLZ,     pAttrs:RVPS____W_,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_CMPEQ_Sx]         = {morph:emitCmpopRRR_Sx,   cond :vmi_COND_EQ,                                                                         iClass:OCL_IC_INTEGER},
    [RV_IT_CR_Sx]            = {morph:emitPairRRR_Sx,    binop:vmi_ADD,     pAttrs:RVPS___X__,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_INSB]             = {morph:emitINSB,                                                                                                     iClass:OCL_IC_INTEGER},
    [RV_IT_KABS_Sx]          = {morph:emitUnopRR_Sx,     unop :vmi_ABSSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KABSW]            = {morph:emitUnopRR,        unop :vmi_ABSSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KADD_Sx]          = {morph:emitBinopRRR_Sx,   binop:vmi_ADDSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KADD_Wx]          = {morph:emitBinopRRR_Wx,   binop:vmi_ADDSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KCR_Sx]           = {morph:emitPairRRR_Sx,    binop:vmi_ADDSQ,   pAttrs:RVPS___X__,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_KDM_Hx]           = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS__D___,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KDMA_Hx]          = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS__D___,                                  acc:vmi_ADDSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KHM_Sx]           = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_ND___,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KHM_Hx]           = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_ND___,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KHMX_Sx]          = {morph:emitMulQnX_Sx,     binop:vmi_IMUL,    pAttrs:RVPS_ND___,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KMA_Hx]           = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS____W_,                                  acc:vmi_ADDSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMADA]            = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_ADDSQ,                acc:vmi_ADCSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMAXDA]           = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS___XW_, binop2:vmi_ADDSQ,                acc:vmi_ADCSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMADS]            = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_RSUBSQ,               acc:vmi_ADCSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMAXDS]           = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS___XW_, binop2:vmi_RSUBSQ,               acc:vmi_ADCSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMADRS]           = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_SUBSQ,                acc:vmi_ADCSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMAR_Sx]          = {morph:emitKMASR,         binop:vmi_IMUL,    pAttrs:RVPS______, binop2:vmi_ADDSQ,                acc:vmi_ADCSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMDA]             = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_ADDSQ,                acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KMXDA]            = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS___XW_, binop2:vmi_ADDSQ,                acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KMMAC_Rx]         = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_N__W_,                                  acc:vmi_ADDSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMMAW_Hx_Dx_Rx]   = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_N__W_,                                  acc:vmi_ADDSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMMSB_Rx]         = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_N__W_,                                  acc:vmi_SUBSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMMW_Hx_Dx_Rx]    = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_N__W_, binop2:vmi_ADDSQ,                acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KMSDA]            = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_ADDSQ,                acc:vmi_SUBSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMSXDA]           = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS___XW_, binop2:vmi_ADDSQ,                acc:vmi_SUBSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMSR_Sx]          = {morph:emitKMASR,         binop:vmi_IMUL,    pAttrs:RVPS______, binop2:vmi_ADDSQ,                acc:vmi_SBBSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KSLL_Sx]          = {morph:emitShiftopRRR_Sx, binop:vmi_SHLSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KSLLI_Sx]         = {morph:emitBinopRRC_Sx,   binop:vmi_SHLSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KSLLW]            = {morph:emitBinopRRR,      binop:vmi_SHLSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KSLLIW]           = {morph:emitBinopRRC,      binop:vmi_SHLSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KSLRA_Sx_Rx]      = {morph:emitKSLRA,         binop:vmi_SHLSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KST_Sx]           = {morph:emitPairRRR_Sx,    binop:vmi_ADDSQ,   pAttrs:RVPS______,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_KSUB_Sx]          = {morph:emitBinopRRR_Sx,   binop:vmi_SUBSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KSUB_Wx]          = {morph:emitBinopRRR_Wx,   binop:vmi_SUBSQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_KWMMUL_Rx]        = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_ND_W_,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_MADDR_Sx]         = {morph:emitMACCR,         binop:vmi_IMUL,                                                        acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_MAXW]             = {morph:emitBinopRRR,      binop:vmi_IMAX,                                                                            iClass:OCL_IC_INTEGER},
    [RV_IT_MINW]             = {morph:emitBinopRRR,      binop:vmi_IMIN,                                                                            iClass:OCL_IC_INTEGER},
    [RV_IT_MSUBR_Sx]         = {morph:emitMACCR,         binop:vmi_IMUL,                                                        acc:vmi_SUB,        iClass:OCL_IC_INTEGER},
    [RV_IT_MULR_Sx]          = {morph:emitMULR,          binop:vmi_MUL,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_MULSR_Sx]         = {morph:emitMULR,          binop:vmi_IMUL,                                                                            iClass:OCL_IC_INTEGER},
    [RV_IT_PBSAD]            = {morph:emitPBSAD,         binop:vmi_SUB,                                                         acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_PBSADA]           = {morph:emitPBSAD,         binop:vmi_SUB,                                                         acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_PK_Hx_Sx]         = {morph:emitPK,                                                                                                       iClass:OCL_IC_INTEGER},
    [RV_IT_RADD_Sx]          = {morph:emitBinopRRR_Sx,   binop:vmi_ADDSH,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_RADDW]            = {morph:emitBinopRRR,      binop:vmi_ADDSH,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_RCR_Sx]           = {morph:emitPairRRR_Sx,    binop:vmi_ADDSH,   pAttrs:RVPS___X__,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_RST_Sx]           = {morph:emitPairRRR_Sx,    binop:vmi_ADDSH,   pAttrs:RVPS______,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_RSUB_Sx]          = {morph:emitBinopRRR_Sx,   binop:vmi_SUBSH,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_RSUBW]            = {morph:emitBinopRRR,      binop:vmi_SUBSH,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_SCLIP_Sx]         = {morph:emitCLIP,          binop:vmi_SHLSQ,   pAttrs:RVPS____W_,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_SCMPLE_Sx]        = {morph:emitCmpopRRR_Sx,   cond :vmi_COND_LE,                                                                         iClass:OCL_IC_INTEGER},
    [RV_IT_SCMPLT_Sx]        = {morph:emitCmpopRRR_Sx,   cond :vmi_COND_L,                                                                          iClass:OCL_IC_INTEGER},
    [RV_IT_SLL_Sx]           = {morph:emitShiftopRRR_Sx, binop:vmi_SHL,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_SLLI_Sx]          = {morph:emitBinopRRC_Sx,   binop:vmi_SHL,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_SMAL]             = {morph:emitMAL64,         binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_ADD,                  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMAL_Hx]          = {morph:emitMAL64_Hx,      binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_ADD,                  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMALDA]           = {morph:emitPairMAL64_Hx,  binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_ADD, binop3:vmi_ADD,  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMALXDA]          = {morph:emitPairMAL64_Hx,  binop:vmi_IMUL,    pAttrs:RVPS___XW_, binop2:vmi_ADD, binop3:vmi_ADD,  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMALDS]           = {morph:emitPairMAL64_Hx,  binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_SUB, binop3:vmi_ADD,  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMALDRS]          = {morph:emitPairMAL64_Hx,  binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_ADD, binop3:vmi_SUB,  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMALXDS]          = {morph:emitPairMAL64_Hx,  binop:vmi_IMUL,    pAttrs:RVPS___XW_, binop2:vmi_SUB, binop3:vmi_ADD,  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMAR_Sx]          = {morph:emitKMASR,         binop:vmi_IMUL,    pAttrs:RVPS______, binop2:vmi_ADD,                  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMAQA]            = {morph:emitMAQA,          binop:vmi_IMUL,    pAttrs:RVPS____W_,                                  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMAQA_SU]         = {morph:emitMAQA,          binop:vmi_IMULSU,  pAttrs:RVPS____W_,                                  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMAX_Sx]          = {morph:emitBinopRRR_Sx,   binop:vmi_IMAX,                                                                            iClass:OCL_IC_INTEGER},
    [RV_IT_SM_Hx_Sx]         = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_____2,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_SMDS]             = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_RSUB,                 acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_SMDRS]            = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_SUB,                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_SMXDS]            = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS___XW_, binop2:vmi_RSUB,                 acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_SMIN_Sx]          = {morph:emitBinopRRR_Sx,   binop:vmi_IMIN,                                                                            iClass:OCL_IC_INTEGER},
    [RV_IT_SMMUL_Rx]         = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_N__W_,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_SMMW_Hx_Dx_Rx]    = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_N__W_,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_SMSLDA]           = {morph:emitPairMAL64_Hx,  binop:vmi_IMUL,    pAttrs:RVPS____W_, binop2:vmi_ADD, binop3:vmi_ADD,  acc:vmi_SUB,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMSLXDA]          = {morph:emitPairMAL64_Hx,  binop:vmi_IMUL,    pAttrs:RVPS___XW_, binop2:vmi_ADD, binop3:vmi_ADD,  acc:vmi_SUB,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMSR_Sx]          = {morph:emitKMASR,         binop:vmi_IMUL,    pAttrs:RVPS______, binop2:vmi_ADD,                  acc:vmi_SUB,        iClass:OCL_IC_INTEGER},
    [RV_IT_SMUL_Sx]          = {morph:emitSMUL,          binop:vmi_IMUL,    pAttrs:RVPS______,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_SMULX_Sx]         = {morph:emitSMUL,          binop:vmi_IMUL,    pAttrs:RVPS___X__,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_SRA_Rx]           = {morph:emitBinopRRR,      binop:vmi_SAR,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_SRA_Sx_Rx]        = {morph:emitShiftopRRR_Sx, binop:vmi_SAR,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_SRAI_Rx]          = {morph:emitBinopRRC,      binop:vmi_SAR,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_SRAI_Sx_Rx]       = {morph:emitBinopRRC_Sx,   binop:vmi_SAR,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_SRL_Sx_Rx]        = {morph:emitShiftopRRR_Sx, binop:vmi_SHR,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_SRLI_Sx_Rx]       = {morph:emitBinopRRC_Sx,   binop:vmi_SHR,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_ST_Sx]            = {morph:emitPairRRR_Sx,    binop:vmi_ADD,     pAttrs:RVPS______,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_SUB_Sx]           = {morph:emitBinopRRR_Sx,   binop:vmi_SUB,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_SUNPKD_Sx_Px]     = {morph:emitSUNPKD8,                                                                                                  iClass:OCL_IC_INTEGER},
    [RV_IT_SWAP_Sx]          = {morph:emitSWAP,                                                                                                     iClass:OCL_IC_INTEGER},
    [RV_IT_UCLIP_Sx]         = {morph:emitCLIP,          binop:vmi_SHLUQ,   pAttrs:RVPS____W_,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_UCMPLE_Sx]        = {morph:emitCmpopRRR_Sx,   cond :vmi_COND_BE,                                                                         iClass:OCL_IC_INTEGER},
    [RV_IT_UCMPLT_Sx]        = {morph:emitCmpopRRR_Sx,   cond :vmi_COND_B,                                                                          iClass:OCL_IC_INTEGER},
    [RV_IT_UKADD_Sx]         = {morph:emitBinopRRR_Sx,   binop:vmi_ADDUQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_UKADD_Wx]         = {morph:emitBinopRRR_Wx,   binop:vmi_ADDUQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_UKCR_Sx]          = {morph:emitPairRRR_Sx,    binop:vmi_ADDUQ,   pAttrs:RVPS___X__,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_UKMAR_Sx]         = {morph:emitKMASR,         binop:vmi_MUL,     pAttrs:RVPS______, binop2:vmi_ADDUQ,                acc:vmi_ADDUQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_UKMSR_Sx]         = {morph:emitKMASR,         binop:vmi_MUL,     pAttrs:RVPS______, binop2:vmi_SUBUQ,                acc:vmi_SUBUQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_UKST_Sx]          = {morph:emitPairRRR_Sx,    binop:vmi_ADDUQ,   pAttrs:RVPS______,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_UKSUB_Sx]         = {morph:emitBinopRRR_Sx,   binop:vmi_SUBUQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_UKSUB_Wx]         = {morph:emitBinopRRR_Wx,   binop:vmi_SUBUQ,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_UMAR_Sx]          = {morph:emitKMASR,         binop:vmi_MUL,     pAttrs:RVPS______, binop2:vmi_ADD,                  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_UMAQA]            = {morph:emitMAQA,          binop:vmi_MUL,     pAttrs:RVPS____W_,                                  acc:vmi_ADD,        iClass:OCL_IC_INTEGER},
    [RV_IT_UMAX_Sx]          = {morph:emitBinopRRR_Sx,   binop:vmi_MAX,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_UMIN_Sx]          = {morph:emitBinopRRR_Sx,   binop:vmi_MIN,                                                                             iClass:OCL_IC_INTEGER},
    [RV_IT_UMSR_Sx]          = {morph:emitKMASR,         binop:vmi_MUL,     pAttrs:RVPS______, binop2:vmi_ADD,                  acc:vmi_SUB,        iClass:OCL_IC_INTEGER},
    [RV_IT_UMUL_Sx]          = {morph:emitSMUL,          binop:vmi_MUL,     pAttrs:RVPS______,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_UMULX_Sx]         = {morph:emitSMUL,          binop:vmi_MUL,     pAttrs:RVPS___X__,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_URADD_Sx]         = {morph:emitBinopRRR_Sx,   binop:vmi_ADDUH,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_URADDW]           = {morph:emitBinopRRR,      binop:vmi_ADDUH,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_URCR_Sx]          = {morph:emitPairRRR_Sx,    binop:vmi_ADDUH,   pAttrs:RVPS___X__,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_URST_Sx]          = {morph:emitPairRRR_Sx,    binop:vmi_ADDUH,   pAttrs:RVPS______,                                                      iClass:OCL_IC_INTEGER},
    [RV_IT_URSUB_Sx]         = {morph:emitBinopRRR_Sx,   binop:vmi_SUBUH,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_URSUBW]           = {morph:emitBinopRRR,      binop:vmi_SUBUH,                                                                           iClass:OCL_IC_INTEGER},
    [RV_IT_WEXT]             = {morph:emitWEXT,                                                                                                     iClass:OCL_IC_INTEGER},
    [RV_IT_WEXTI]            = {morph:emitWEXTI,                                                                                                    iClass:OCL_IC_INTEGER},
    [RV_IT_ZUNPKD_Sx_Px]     = {morph:emitZUNPKD8,                                                                                                  iClass:OCL_IC_INTEGER},

    // P-extension instructions (RV64 only)
    [RV_IT_KDM_Hx_Sx]        = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS__D__2,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KDMA_Hx_Sx]       = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS__D__2,                                  acc:vmi_ADDSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KHM_Hx_Sx]        = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_ND__2,                                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KMA_Hx_Sx]        = {morph:emitMulQn_Sx,      binop:vmi_IMUL,    pAttrs:RVPS_____2,                                  acc:vmi_ADDSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMAXDA_Sx]        = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS___X_2, binop2:vmi_ADDSQ,                acc:vmi_ADCSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMDA_Sx]          = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS_____2, binop2:vmi_ADDSQ,                acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KMXDA_Sx]         = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS___X_2, binop2:vmi_ADDSQ,                acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_KMADS_Sx]         = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS_____2, binop2:vmi_RSUBSQ,               acc:vmi_ADCSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMADRS_Sx]        = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS_____2, binop2:vmi_SUBSQ,                acc:vmi_ADCSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMAXDS_Sx]        = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS___X_2, binop2:vmi_RSUBSQ,               acc:vmi_ADCSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMSDA_Sx]         = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS_____2, binop2:vmi_ADDSQ,                acc:vmi_SUBSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_KMSXDA_Sx]        = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS___X_2, binop2:vmi_ADDSQ,                acc:vmi_SUBSQ,      iClass:OCL_IC_INTEGER},
    [RV_IT_SMDS_Sx]          = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS_____2, binop2:vmi_RSUB,                 acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_SMDRS_Sx]         = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS_____2, binop2:vmi_SUB,                  acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},
    [RV_IT_SMXDS_Sx]         = {morph:emitKMAXDAS,       binop:vmi_IMUL,    pAttrs:RVPS___X_2, binop2:vmi_RSUB,                 acc:vmi_BINOP_LAST, iClass:OCL_IC_INTEGER},

    #endif

    // code size reduction instructions
    [RV_IT_NOT_R]            = {morph:emitUnopRR,   unop :vmi_NOT,  iClass:OCL_IC_INTEGER},
    [RV_IT_NEG_R]            = {morph:emitUnopRR,   unop :vmi_NEG,  iClass:OCL_IC_INTEGER},
    [RV_IT_MVP_R]            = {morph:emitMVP,                      iClass:OCL_IC_INTEGER},
    [RV_IT_MULI_I]           = {morph:emitBinopRRC, binop:vmi_IMUL, iClass:OCL_IC_INTEGER},
    [RV_IT_BEQI_B]           = {morph:emitBranchRC, cond:vmi_COND_EQ},
    [RV_IT_BNEI_B]           = {morph:emitBranchRC, cond:vmi_COND_NE},
    [RV_IT_TBLJ]             = {morph:emitTBLJ,     offset: 8},
    [RV_IT_TBLJAL]           = {morph:emitTBLJ,     offset:64},
    [RV_IT_TBLJALM]          = {morph:emitTBLJ,     offset: 0},
    [RV_IT_PUSH]             = {morph:emitPUSH},
    [RV_IT_POP]              = {morph:emitPOP},
    [RV_IT_DECBNEZ]          = {morph:emitDECBNEZ},

    // Zicbom-extension instructions (RV32 and RV64)
    [RV_IT_CBO_CLEAN]        = {morph:emitCBOCLEAN, iClass:OCL_IC_DCACHE},
    [RV_IT_CBO_FLUSH]        = {morph:emitCBOFLUSH, iClass:OCL_IC_DCACHE},
    [RV_IT_CBO_INVAL]        = {morph:emitCBOINVAL, iClass:OCL_IC_DCACHE},
    [RV_IT_CBO_ZERO]         = {morph:emitCBOZERO,  iClass:OCL_IC_DCACHE},

    // KEEP LAST
    [RV_IT_LAST]             = {0}
};

//
// Called at the start of a new code block
//
VMI_START_END_BLOCK_FN(riscvStartBlock) {

    riscvP           riscv     = (riscvP)processor;
    riscvBlockStateP thisState = blockState;
    riscvBlockStateP prevState = riscv->blockState;

    // save currently-active block state and set new state
    thisState->prevState = prevState;
    riscv->blockState    = thisState;

    // no floating point registers are known to be NaN-boxed initially
    thisState->fpNaNBoxMask[0] = 0;
    thisState->fpNaNBoxMask[1] = 0;

    // no floating-point or vector instructions have been seen initially
    thisState->FSDirty = False;
    thisState->VSDirty = False;

    // current vector configuration is not known initially
    thisState->SEWMt                 = SEWMT_UNKNOWN;
    thisState->VLMULx8Mt             = VLMULx8MT_UNKNOWN;
    thisState->VLClassMt             = VLCLASSMT_UNKNOWN;
    thisState->VSetTopMt[VTZ_SINGLE] = 0;
    thisState->VSetTopMt[VTZ_GROUP]  = 0;
    thisState->VStartZeroMt          = forceVStart0(riscv);

    // inherit any previously-active SEW, VLMUL and VLClass
    if(prevState) {
        thisState->SEWMt     = prevState->SEWMt;
        thisState->VLMULx8Mt = prevState->VLMULx8Mt;
        thisState->VLClassMt = prevState->VLClassMt;
    }
}

//
// Called at the end of a new code block
//
VMI_START_END_BLOCK_FN(riscvEndBlock) {

    riscvP           riscv     = (riscvP)processor;
    riscvBlockStateP thisState = blockState;

    // sanity check that the current block is being ended
    VMI_ASSERT(
        thisState==riscv->blockState,
        "unexpected mismatched blockState at end of block"
    );

    // restore previously-active block state
    riscv->blockState = thisState->prevState;
}

//
// Called before an instruction is translated (including intercepts)
//
VMI_MORPH_FN(riscvPreMorph) {

    riscvP           riscv     = (riscvP)processor;
    riscvBlockStateP thisState = blockState;

    thisState->updateFFlags = False;
    thisState->doLSTrig     = True;

    // clear per-instruction fflags if required
    if(perInstructionFFlags(riscv)) {
        vmimtMoveRC(8, RISCV_FP_FLAGS_I, 0);
    }
}

//
// Called after an instruction is translated (including intercepts)
//
VMI_MORPH_FN(riscvPostMorph) {

    riscvBlockStateP thisState = blockState;

    // accumulate sticky fflags if required
    if(thisState->updateFFlags) {
        vmimtBinopRR(8, vmi_OR, RISCV_FP_FLAGS, RISCV_FP_FLAGS_I, 0);
    }
}

//
// Insert optional call to instruction fetch trigger
//
static Bool doExecuteTrigger(riscvP riscv, Uns32 instruction, Uns32 bytes) {

    if(triggerExecuteMT(riscv)) {

        vmiCallFn cb = 0;

        if(bytes==2) {
            cb = (vmiCallFn)riscvTriggerX2;
        } else if(bytes==4) {
            cb = (vmiCallFn)riscvTriggerX4;
        }

        // sanity check instruction size
        VMI_ASSERT(cb, "illegal instruction size %u bytes", bytes);

        // emit call to instruction trigger check
        vmimtArgProcessor();
        vmimtArgSimPC(64);
        vmimtArgUns32(instruction);
        vmimtCallAttrs((vmiCallFn)cb, VMCA_NA);
    }

    return False;
}

//
// Instruction Morpher
//
VMI_MORPH_FN(riscvMorph) {

    riscvP          riscv = (riscvP)processor;
    riscvMorphState state;

    // get instruction and instruction type
    riscvDecode(riscv, thisPC, &state.info);

    // fill JIT translation state
    state.attrs       = &dispatchTable[state.info.type];
    state.riscv       = riscv;
    state.inDelaySlot = inDelaySlot;
    state.tmpIndex    = 0;

    // clear mask of X registers targeted by this instruction
    riscv->writtenXMask = 0;

    // handle fixed point vector instructions that have an implicit dependency
    // on mstatus.FS
    if(vxSatRMSetFSDirty(riscv) && usesVXRM(state.attrs->vShape)) {
        state.info.arch |= ISA_FS;
    }

    // handle floating point vector instructions that have an implicit
    // dependency on mstatus.FS
    if(vectorFPRequiresFSNZ(riscv) && isFloat(state.attrs->vShape)) {
        state.info.arch |= ISA_FS;
    }

    if(disableMorph(&state)) {

        // no action if in disassembly mode

    } else if(doExecuteTrigger(riscv, state.info.instruction, state.info.bytes)) {

        // execute trigger precedes Illegal Instruction check

    } else if(state.info.type==RV_IT_LAST) {

        // take Illegal Instruction exception
        ILLEGAL_INSTRUCTION_MESSAGE(riscv, "UDEC", "Undecoded instruction");

    } else if(!riscvInstructionEnabled(riscv, state.info.arch)) {

        // instruction not enabled

    } else if(!riscvValidateBExtSubset(riscv, state.attrs->bExtOp)) {

        // B-extension feature subset not present

    } else if(!riscvValidateCExtSubset(riscv, state.info.Zc)) {

        // C-extension feature subset not present

    } else if(!riscvValidateKExtSubset(riscv, state.attrs->kExtOp)) {

        // K-extension feature subset not present

    } else if(!validateMExtSubset(riscv, state.info.Zmmul)) {

        // K-extension feature subset not present

    } else if(state.attrs->morph) {

        // call derived model preMorph functions if required
        ITER_EXT_CB(
            riscv, extCB, preMorph,
            extCB->preMorph(riscv, extCB->clientData);
        )

        // give information about instruction class
        vmimtInstructionClassAdd(state.attrs->iClass);

        // translate the instruction with Zfhmin context
        riscv->blockState->ZfhminOK = state.attrs->ZfhminOK;
        state.attrs->morph(&state);
        riscv->blockState->ZfhminOK = False;

        // call derived model postMorph functions if required
        ITER_EXT_CB(
            riscv, extCB, postMorph,
            extCB->postMorph(riscv, extCB->clientData);
        )

    } else {

        // here if no morph callback specified
        vmiMessage("F", CPU_PREFIX "_UIMP", // LCOV_EXCL_LINE
            SRCREF_FMT "unimplemented",
            SRCREF_ARGS(riscv, thisPC)
        );
    }
}

//
// Translate externally-implemented instruction
//
void riscvMorphExternal(
    riscvExtMorphStateP state,
    const char         *disableReason,
    Bool               *opaque
) {
    riscvP riscv = state->riscv;

    // indicate instruction is implemented here
    *opaque = True;

    if(RISCV_DISASSEMBLE(riscv)) {

        // no action if in disassembly mode

    } else if(doExecuteTrigger(riscv, state->info.instruction, state->info.bytes)) {

        // execute trigger precedes Illegal Instruction check

    } else if(!riscvInstructionEnabled(riscv, state->info.arch)) {

        // instruction not enabled

    } else if(disableReason) {

        // instruction not enabled
        riscvEmitIllegalInstructionMessage(riscv, disableReason);

    } else if(state->attrs->morph) {

        // translate the instruction
        vmimtInstructionClassAdd(state->attrs->iClass);
        state->attrs->morph(state);

    } else {

        // here if no morph callback specified
        vmiMessage("F", CPU_PREFIX "_UIMP", // LCOV_EXCL_LINE
            SRCREF_FMT "unimplemented",
            SRCREF_ARGS(riscv, getPC(riscv))
        );
    }
}

//
// Emit externally-implemented vector operation
//
void riscvMorphVOp(
    riscvP           riscv,
    Uns64            thisPC,
    riscvRegDesc     r0,
    riscvRegDesc     r1,
    riscvRegDesc     r2,
    riscvRegDesc     mask,
    riscvVShape      shape,
    riscvVExternalFn externalCB,
    void            *userData
) {
    riscvMorphState state = {externalCB:externalCB, userData:userData};
    riscvInstrInfoP info  = &state.info;

    // fill instruction details
    info->thisPC = thisPC;
    info->r[0]   = r0;
    info->r[1]   = r1;
    info->r[2]   = r2;
    info->mask   = mask;

    // define attributes with the given shape
    riscvMorphAttr attrs = {opTCB:emitVExternalCB, vShape:shape};

    // fill JIT translation state
    state.attrs = &attrs;
    state.riscv = riscv;

    // translate the instruction
    emitVectorOp(&state);
}

//
// Adjust results for divide-by-zero and integer overflow
//
VMI_ARITH_RESULT_FN(riscvArithResult) {

    if(!divideInfo->divisor) {

        // divide by zero
        divideResults->quotient  = -1;
        divideResults->remainder = divideInfo->dividendLSW;

    } else {

        // integer overflow
        divideResults->quotient  = divideInfo->dividendLSW;
        divideResults->remainder = 0;
    }
}
