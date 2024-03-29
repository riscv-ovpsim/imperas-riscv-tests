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

// Standard header files
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Imperas header files
#include "hostapi/impAlloc.h"

// VMI header files
#include "vmi/vmiMessage.h"
#include "vmi/vmiRt.h"

// OCL area includes
#include "ocl/oclStringVar.h"

// model header files
#include "riscvAIATypes.h"
#include "riscvCLIC.h"
#include "riscvCLINT.h"
#include "riscvCSR.h"
#include "riscvDecode.h"
#include "riscvDecodeTypes.h"
#include "riscvExceptions.h"
#include "riscvExceptionDefinitions.h"
#include "riscvFunctions.h"
#include "riscvMessage.h"
#include "riscvMode.h"
#include "riscvStructure.h"
#include "riscvTrigger.h"
#include "riscvUtils.h"
#include "riscvVM.h"
#include "riscvVMConstants.h"


////////////////////////////////////////////////////////////////////////////////
// EXCEPTION DEFINITIONS
////////////////////////////////////////////////////////////////////////////////

//
// Fill one member of exceptions
//
#define RISCV_EXCEPTION(_NAME, _PORT, _ARCH, _DESC) { \
    vmiInfo    : {name:#_NAME, code:riscv_E_##_NAME, description:_DESC},    \
    arch       : _ARCH,                                                     \
    hasNetPort : _PORT                                                      \
}

//
// Table of exception descriptors
//
static const riscvExceptionDesc exceptions[] = {

    ////////////////////////////////////////////////////////////////////
    // EXCEPTIONS
    ////////////////////////////////////////////////////////////////////

    RISCV_EXCEPTION (InstructionAddressMisaligned, 0, ISA_UX,"Fetch from unaligned address"),
    RISCV_EXCEPTION (InstructionAccessFault,       0, 0,     "No access permission for fetch"),
    RISCV_EXCEPTION (IllegalInstruction,           0, 0,     "Undecoded, unimplemented or disabled instruction"),
    RISCV_EXCEPTION (Breakpoint,                   0, 0,     "EBREAK instruction executed"),
    RISCV_EXCEPTION (LoadAddressMisaligned,        0, ISA_UX,"Load from unaligned address"),
    RISCV_EXCEPTION (LoadAccessFault,              0, 0,     "No access permission for load"),
    RISCV_EXCEPTION (StoreAMOAddressMisaligned,    0, ISA_UX,"Store/atomic memory operation at unaligned address"),
    RISCV_EXCEPTION (StoreAMOAccessFault,          0, 0,     "No access permission for store/atomic memory operation"),
    RISCV_EXCEPTION (EnvironmentCallFromUMode,     0, ISA_U, "ECALL instruction executed in User mode"),
    RISCV_EXCEPTION (EnvironmentCallFromSMode,     0, ISA_S, "ECALL instruction executed in Supervisor mode"),
    RISCV_EXCEPTION (EnvironmentCallFromVSMode,    0, ISA_H, "ECALL instruction executed in Virtual Supervisor mode"),
    RISCV_EXCEPTION (EnvironmentCallFromMMode,     0, 0,     "ECALL instruction executed in Machine mode"),
    RISCV_EXCEPTION (InstructionPageFault,         0, ISA_S, "Page fault at fetch address"),
    RISCV_EXCEPTION (LoadPageFault,                0, ISA_S, "Page fault at load address"),
    RISCV_EXCEPTION (StoreAMOPageFault,            0, ISA_S, "Page fault at store/atomic memory operation address"),
    RISCV_EXCEPTION (InstructionGuestPageFault,    0, ISA_H, "Guest page fault at fetch address"),
    RISCV_EXCEPTION (LoadGuestPageFault,           0, ISA_H, "Guest page fault at load address"),
    RISCV_EXCEPTION (VirtualInstruction,           0, ISA_H, "Virtual instruction fault"),
    RISCV_EXCEPTION (StoreAMOGuestPageFault,       0, ISA_H, "Guest page fault at store/atomic memory operation address"),

    ////////////////////////////////////////////////////////////////////
    // STANDARD INTERRUPTS
    ////////////////////////////////////////////////////////////////////

    RISCV_EXCEPTION (USWInterrupt,                 1, ISA_N, "User software interrupt"),
    RISCV_EXCEPTION (SSWInterrupt,                 1, ISA_S, "Supervisor software interrupt"),
    RISCV_EXCEPTION (VSSWInterrupt,                1, ISA_H, "Virtual supervisor software interrupt"),
    RISCV_EXCEPTION (MSWInterrupt,                 1, 0,     "Machine software interrupt"),
    RISCV_EXCEPTION (UTimerInterrupt,              1, ISA_N, "User timer interrupt"),
    RISCV_EXCEPTION (STimerInterrupt,              1, ISA_S, "Supervisor timer interrupt"),
    RISCV_EXCEPTION (VSTimerInterrupt,             1, ISA_H, "Virtual supervisor timer interrupt"),
    RISCV_EXCEPTION (MTimerInterrupt,              1, 0,     "Machine timer interrupt"),
    RISCV_EXCEPTION (UExternalInterrupt,           1, ISA_N, "User external interrupt"),
    RISCV_EXCEPTION (SExternalInterrupt,           1, ISA_S, "Supervisor external interrupt"),
    RISCV_EXCEPTION (VSExternalInterrupt,          1, ISA_H, "Virtual supervisor external interrupt"),
    RISCV_EXCEPTION (MExternalInterrupt,           1, 0,     "Machine external interrupt"),
    RISCV_EXCEPTION (SGEIInterrupt,                0, ISA_H, "Guest external interrupt"),

    ////////////////////////////////////////////////////////////////////
    // CLIC INTERRUPTS
    ////////////////////////////////////////////////////////////////////

    RISCV_EXCEPTION (CSIP,                         1, 0,     "CLIC software interrupt"),

    ////////////////////////////////////////////////////////////////////
    // NMI
    ////////////////////////////////////////////////////////////////////

    RISCV_EXCEPTION (GenericNMI,                   0, 0,     "Generic NMI"),

    ////////////////////////////////////////////////////////////////////
    // TERMINATOR
    ////////////////////////////////////////////////////////////////////

    {{0}}
};


////////////////////////////////////////////////////////////////////////////////
// INTERRUPT PRIORITIES
////////////////////////////////////////////////////////////////////////////////

//
// This is the minimum priority when no interrupt is pending
//
#define RV_NO_PRI   (1ULL<<63)

//
// Helper macros for defining interrupt priorities
//
#define STD_INDEX(_NAME)     (riscv_E_##_NAME##Interrupt-riscv_E_Interrupt)
#define STD_PRI_ENTRY(_NAME) [STD_INDEX(_NAME)] = riscv_E_##_NAME##Priority
#define LCL_PRI_ENTRY(_NUM)  [_NUM] = riscv_E_Local##_NUM##Priority

//
// Table of basic-mode priority mappings for interrupts
//
static const riscvExceptionPriority intPri[64] = {

    ////////////////////////////////////////////////////////////////////
    // STANDARD MAJOR INTERRUPTS (0-15)
    ////////////////////////////////////////////////////////////////////

    STD_PRI_ENTRY(UTimer),
    STD_PRI_ENTRY(USW),
    STD_PRI_ENTRY(UExternal),
    STD_PRI_ENTRY(STimer),
    STD_PRI_ENTRY(SSW),
    STD_PRI_ENTRY(SExternal),
    STD_PRI_ENTRY(VSTimer),
    STD_PRI_ENTRY(VSSW),
    STD_PRI_ENTRY(VSExternal),
    STD_PRI_ENTRY(MTimer),
    STD_PRI_ENTRY(MSW),
    STD_PRI_ENTRY(MExternal),
    STD_PRI_ENTRY(SGEI),

    ////////////////////////////////////////////////////////////////////
    // LOCAL INTERRUPTS (16-23) WHEN AIA PRESENT
    ////////////////////////////////////////////////////////////////////

    LCL_PRI_ENTRY(16),
    LCL_PRI_ENTRY(17),
    LCL_PRI_ENTRY(18),
    LCL_PRI_ENTRY(19),
    LCL_PRI_ENTRY(20),
    LCL_PRI_ENTRY(21),
    LCL_PRI_ENTRY(22),
    LCL_PRI_ENTRY(23),

    ////////////////////////////////////////////////////////////////////
    // LOCAL INTERRUPTS (32-47) WHEN AIA PRESENT
    ////////////////////////////////////////////////////////////////////

    LCL_PRI_ENTRY(32),
    LCL_PRI_ENTRY(33),
    LCL_PRI_ENTRY(34),
    LCL_PRI_ENTRY(35),
    LCL_PRI_ENTRY(36),
    LCL_PRI_ENTRY(37),
    LCL_PRI_ENTRY(38),
    LCL_PRI_ENTRY(39),
    LCL_PRI_ENTRY(40),
    LCL_PRI_ENTRY(41),
    LCL_PRI_ENTRY(42),
    LCL_PRI_ENTRY(43),
    LCL_PRI_ENTRY(44),
    LCL_PRI_ENTRY(45),
    LCL_PRI_ENTRY(46),
    LCL_PRI_ENTRY(47),
};

#undef STD_INDEX
#undef STD_PRI_ENTRY
#undef LCL_PRI_ENTRY


////////////////////////////////////////////////////////////////////////////////
// UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Is the fault a load/store/AMO fault?
//
Bool riscvIsLoadStoreAMOFault(riscvException exception) {

    switch(exception) {
        case riscv_E_LoadAddressMisaligned:
        case riscv_E_LoadAccessFault:
        case riscv_E_StoreAMOAddressMisaligned:
        case riscv_E_StoreAMOAccessFault:
        case riscv_E_LoadPageFault:
        case riscv_E_StoreAMOPageFault:
        case riscv_E_LoadGuestPageFault:
        case riscv_E_StoreAMOGuestPageFault:
            return True;
        default:
            return False;
    }
}

//
// Is the exception a standard S-mode interrupt?
//
static Bool isSStandardInterrupt(riscvException exception) {

    switch(exception) {
        case riscv_E_SSWInterrupt:
        case riscv_E_STimerInterrupt:
        case riscv_E_SExternalInterrupt:
            return True;
        default:
            return False;
    }
}

//
// Is the exception a standard VS-mode interrupt?
//
static Bool isVSStandardInterrupt(riscvException exception) {

    switch(exception) {
        case riscv_E_VSSWInterrupt:
        case riscv_E_VSTimerInterrupt:
        case riscv_E_VSExternalInterrupt:
            return True;
        default:
            return False;
    }
}

//
// Indicate whether the currently-active inhv affects the EPC behavior in an
// exception
//
inline static Bool inhvAffectsEPC(riscvP riscv, Bool inhv) {
    return inhv && (riscv->configInfo.CLIC_version>RVCLC_0_9_20191208);
}

//
// Return current PC
//
inline static Uns64 getPC(riscvP riscv) {
    return vmirtGetPC((vmiProcessorP)riscv);
}

//
// Return current data domain
//
inline static memDomainP getDataDomain(riscvP riscv) {
    return vmirtGetProcessorDataDomain((vmiProcessorP)riscv);
}

//
// Return current code domain
//
inline static memDomainP getCodeDomain(riscvP riscv) {
    return vmirtGetProcessorCodeDomain((vmiProcessorP)riscv);
}

//
// Return memory domain for CLIC vector table access
//
static memDomainP vectorTableDomain(riscvP riscv, memAccessAttrs memAttrs) {

    if(memAttrs & MEM_AA_FETCH) {
        return getCodeDomain(riscv);
    } else {
        return getDataDomain(riscv);
    }
}

//
// Return permissions required for CLIC vector table access
//
inline static memAccessAttrs vectorTablePriv(riscvP riscv) {

    memAccessAttrs memAttrs = MEM_AA_TRUE;

    if(riscv->configInfo.CLIC_version>RVCLC_0_9_20220315) {
        memAttrs |= MEM_AA_FETCH;
    }

    return memAttrs;
}

//
// Write a net port
//
inline static void writeNet(riscvP riscv, Uns32 handle, Uns32 value) {
    if(handle) {
        vmirtWriteNetPort((vmiProcessorP)riscv, handle, value);
    }
}

//
// Set current PC on exception
//
inline static void setPC(riscvP riscv, Uns64 newPC) {
    vmirtSetPC((vmiProcessorP)riscv, newPC);
}

//
// Set current PC on exception
//
inline static void setPCException(riscvP riscv, Uns64 newPC) {
    vmirtSetPCException((vmiProcessorP)riscv, newPC);
}

//
// Set current PC on exception return
//
inline static void setPCxRET(riscvP riscv, Uns64 newPC) {

    // mask exception return address to 32 bits if compressed instructions
    // are not currently enabled
    if(!(riscv->currentArch & ISA_C)) {
        newPC &= -4;
    }

    vmirtSetPC((vmiProcessorP)riscv, newPC);
}

//
// Test for pending interrupts
//
inline static void doSynchronousInterrupt(riscvP riscv) {
    vmirtDoSynchronousInterrupt((vmiProcessorP)riscv);
}

//
// Clear any active exclusive access on an xRET, if required
//
inline static void clearEAxRET(riscvP riscv) {
    if(!riscv->configInfo.xret_preserves_lr) {
        clearEA(riscv);
    }
}

//
// Return a Boolean indicating whether an active first-only-fault exception has
// been encountered, in which case no exception should be taken
//
static Bool handleFF(riscvP riscv) {

    Bool suppress = False;

    // is first-only-fault mode active?
    if(riscv->vFirstFault) {

        // deactivate first-only-fault mode (whether or not exception is to be
        // taken)
        riscv->vFirstFault = False;

        // special action required only if not the first element
        if(RD_CSRC(riscv, vstart)) {

            // suppress the exception
            suppress = True;

            // clamp vl to current vstart
            riscvSetVL(riscv, RD_CSRC(riscv, vstart));

            // set matching polymorphic key and clamped vl
            riscvRefreshVectorPMKey(riscv);
        }
    }

    return suppress;
}

//
// Refresh artifact net indicating that the hart is in WFI state
//
static void refreshInWFI(riscvP riscv) {

    Bool inWFI = (riscv->disable&RVD_WFI) && True;

    if(riscv->inWFI != inWFI) {
        riscv->inWFI = inWFI;
        writeNet(riscv, riscv->wfiHandle, inWFI);
    }
}

//
// Update active WFI indication and notify a derived model of halt/restart if
// required
//
static void notifyHaltRestart(riscvP riscv) {

    refreshInWFI(riscv);

    ITER_EXT_CB(
        riscv, extCB, haltRestartNotifier,
        extCB->haltRestartNotifier(riscv, extCB->clientData);
    )
}

//
// Halt the passed processor for the given reason
//
void riscvHalt(riscvP riscv, riscvDisableReason reason) {

    Bool disabled = riscv->disable;

    riscv->disable |= reason;

    if(!disabled) {
        vmirtHalt((vmiProcessorP)riscv);
        notifyHaltRestart(riscv);
    }
}

//
// Block the passed processor for the given reason
//
void riscvBlock(riscvP riscv, riscvDisableReason reason) {

    Bool disabled = riscv->disable;

    riscv->disable |= reason;

    if(!disabled) {
        vmirtBlock((vmiProcessorP)riscv);
        notifyHaltRestart(riscv);
    }
}

//
// Restart the passed processor for the given reason
//
void riscvRestart(riscvP riscv, riscvDisableReason reason) {

    riscv->disable &= ~reason;

    // restart if no longer disabled (maybe from blocked state not visible in
    // disable code)
    if(!riscv->disable) {
        vmirtRestartNext((vmiProcessorP)riscv);
        notifyHaltRestart(riscv);
    }
}


////////////////////////////////////////////////////////////////////////////////
// TAKING EXCEPTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Forward reference
//
static void enterDM(riscvP riscv, dmCause cause);

//
// Return PC to which to return after taking an exception. For processors with
// instruction table extensions, the address should be the original instruction,
// not the table instruction.
//
static Uns64 getEPC(riscvP riscv) {

    Uns8  dsOffset;
    Uns64 eretPC = vmirtGetPCDS((vmiProcessorP)riscv, &dsOffset);

    return dsOffset ? riscv->jumpBase : eretPC;
}

//
// Return the mode to which to take the given exception or interrupt (mode X)
//
static riscvMode getModeX(
    riscvP         riscv,
    Uns64          toHSMask,
    Uns64          toVSMask,
    Uns64          toUMask,
    riscvException ecode
) {
    Uns64     ecodeMask = (1ULL<<ecode);
    riscvMode modeX;

    // handle trap delegation
    if(!(toHSMask & ecodeMask)) {
        modeX = RISCV_MODE_M;
    } else if(!inVMode(riscv)) {
        modeX = (toUMask & ecodeMask) ? RISCV_MODE_U : RISCV_MODE_S;
    } else if(!(toVSMask & ecodeMask)) {
        modeX = RISCV_MODE_S;
    } else {
        modeX = (toUMask & ecodeMask) ? RISCV_MODE_VU : RISCV_MODE_VS;
    }

    return modeX;
}

//
// Return the mode to which to take the given exception (mode X)
//
static riscvMode getExceptionModeX(riscvP riscv, riscvException ecode) {

    // map from processor mode to mode priority
    static const Uns8 priMap[] = {
        [RISCV_MODE_M]  = 3,
        [RISCV_MODE_S]  = 2,
        [RISCV_MODE_VS] = 1,
        [RISCV_MODE_U]  = 0,
        [RISCV_MODE_VU] = 0,
    };

    // get specified exception mode
    riscvMode modeX = getModeX(
        riscv,
        RD_CSR64(riscv, medeleg),
        RD_CSR64(riscv, hedeleg),
        RD_CSR64(riscv, sedeleg),
        ecode
    );

    // get current processor mode
    riscvMode modeY = getCurrentMode5(riscv);

    // exception cannot be taken to lower-privilege mode
    if(priMap[modeX]<priMap[modeY]) {
        modeX = modeY;
    }

    return modeX;
}

//
// Return interrupt mode (0:direct, 1:vectored) - from privileged ISA version
// 1.10 this is encoded in the [msu]tvec register, but previous versions did
// not support vectored mode except in some custom manner (for example, Andes
// N25 and NX25 processors)
//
inline static riscvICMode getIMode(riscvICMode customMode, riscvICMode tvecMode) {
    return tvecMode ? tvecMode : customMode;
}

//
// Structure holding trap context
//
typedef struct trapCxtS {
    Uns64       tval;       // trap value code
    Uns64       EPC;        // exception program counter
    Uns64       handlerPC;  // trap handler PC
    Uns64       base;       // trap base address
    Uns64       tvt;        // tvt address (if CLIC present)
    riscvICMode mode;       // interrupt mode
    Uns32       ecodeMod;   // exception code
    Int32       level;      // interrupt level
    riscvMode   modeX;      // target operating mode
    riscvMode   modeY;      // source operating mode
    Bool        isInt;      // is trap an interrupt?
} trapCxt, *trapCxtP;

//
// When taking an interrupt to VS mode, map virtual interrupt code to the
// equivalent Supervisor code
//
static Uns32 mapVSIntCode(trapCxtP cxt) {

    Uns32 ecode = cxt->ecodeMod;

    if(cxt->isInt && isVSStandardInterrupt(intToException(ecode))) {
        ecode--;
    }

    return ecode;
}

//
// Get interrupt mode dependent on M-mode interrupt mode
//
static riscvICMode getIntModeWRTM(riscvP riscv, riscvICMode mode) {

    if(mtvecDeterminesCLICMode(riscv)) {

        riscvICMode modeM = RD_CSR_FIELD_M(riscv, mtvec, MODE);

        if(modeM & riscv_int_CLIC) {
            mode = modeM;
        } else {
            mode &= ~riscv_int_CLIC;
        }
    }

    return mode;
}

//
// Get M-mode interrupt mode
//
riscvICMode riscvGetIntModeM(riscvP riscv) {
    return RD_CSR_FIELD_M(riscv, mtvec, MODE);
}

//
// Get S-mode interrupt mode
//
riscvICMode riscvGetIntModeS(riscvP riscv) {
    return getIntModeWRTM(riscv, RD_CSR_FIELD_S(riscv, stvec, MODE));
}

//
// Get U-mode interrupt mode
//
riscvICMode riscvGetIntModeU(riscvP riscv) {
    return getIntModeWRTM(riscv, RD_CSR_FIELD_U(riscv, utvec, MODE));
}

//
// Get VS-mode interrupt mode
//
riscvICMode riscvGetIntModeVS(riscvP riscv) {
    return getIntModeWRTM(riscv, RD_CSR_FIELD_VS(riscv, vstvec, MODE));
}

//
// Fill exception base address and mode for CLINT, CLIC or RNMI
//
static void getExceptBaseMode(
    riscvP      riscv,
    trapCxtP    cxt,
    Uns64       tvec,
    riscvICMode customMode,
    riscvICMode tvecMode
) {
    Uns64 base = tvec & -4;

    if(!RD_CSR_FIELDC(riscv, mnstatus, NMIE)) {

        // use nmiexc_address for NMI
        base = riscv->configInfo.nmiexc_address;

    } else if(tvecMode&riscv_int_CLIC) {

        // apply further fixed alignment constraint in CLIC mode
        base &= -0x40;
    }

    // fill base and mode
    cxt->base = base;
    cxt->mode = getIMode(customMode, tvecMode);
}

//
// Take trap to U mode
//
static void trapU(riscvP riscv, trapCxtP cxt) {

    // get interrupt enable and level bits for mode X
    Uns8 IE = RD_CSR_FIELDC(riscv, mstatus,    UIE);
    Uns8 IL = RD_CSR_FIELDC(riscv, mintstatus, uil);

    // update interrupt enable and interrupt enable stack
    WR_CSR_FIELDC(riscv, mstatus, UPIE, IE);
    WR_CSR_FIELDC(riscv, mstatus, UIE, 0);

    // clear cause register if not in CLIC mode
    if(!useCLICU(riscv)) {
        WR_CSR64(riscv, ucause, 0);
    }

    // update cause register
    WR_CSR_FIELDC (riscv, ucause, ExceptionCode, cxt->ecodeMod);
    WR_CSR_FIELD_U(riscv, ucause, Interrupt,     cxt->isInt);
    WR_CSR_FIELDC (riscv, ucause, pil,           IL);

    // update writable bits in epc register
    Uns64 epcMask = RD_CSR_MASK64(riscv, uepc);
    WR_CSR64(riscv, uepc, cxt->EPC & epcMask);

    // update tval register
    WR_CSR64(riscv, utval, cxt->tval);

    // get exception base address and mode
    Uns64 tvec = RD_CSR_U(riscv, utvec);
    getExceptBaseMode(riscv, cxt, tvec, riscv->UIMode, riscvGetIntModeU(riscv));

    // fill tvt address
    cxt->tvt = RD_CSR_U(riscv, utvt);

    // update exception level
    if(cxt->level>=0) {
        WR_CSR_FIELDC(riscv, mintstatus, uil, cxt->level);
    }
}

//
// Take trap to VU mode
//
static void trapVU(riscvP riscv, trapCxtP cxt) {

    // get interrupt enable and level bits for mode X
    Uns8 IE = RD_CSR_FIELDC(riscv, vsstatus, UIE);

    // update interrupt enable and interrupt enable stack
    WR_CSR_FIELDC(riscv, vsstatus, UPIE, IE);
    WR_CSR_FIELDC(riscv, vsstatus, UIE, 0);

    // clear ucause register if not in CLIC mode
    if(!useCLICVU(riscv)) {
        WR_CSR64(riscv, ucause, 0);
    }

    // update ucause register
    WR_CSR_FIELDC  (riscv, ucause, ExceptionCode, cxt->ecodeMod);
    WR_CSR_FIELD_VU(riscv, ucause, Interrupt,     cxt->isInt);

    // update writable bits in uepc register
    Uns64 epcMask = RD_CSR_MASK64(riscv, uepc);
    WR_CSR64(riscv, uepc, cxt->EPC & epcMask);

    // update utval register
    WR_CSR64(riscv, utval, cxt->tval);

    // get exception base address and mode
    Uns64 tvec = RD_CSR_VU(riscv, utvec);
    getExceptBaseMode(riscv, cxt, tvec, riscv->UIMode, riscvGetIntModeU(riscv));
}

//
// Take trap to HS mode
//
static void trapHS(riscvP riscv, trapCxtP cxt) {

    // get virtual state of source mode (modeY)
    Bool VY = modeIsVirtual(cxt->modeY);

    // get interrupt enable and level bits for mode X
    Uns8 IE = RD_CSR_FIELDC(riscv, mstatus,    SIE);
    Uns8 IL = RD_CSR_FIELDC(riscv, mintstatus, sil);

    // update interrupt enable and interrupt enable stack
    WR_CSR_FIELDC(riscv, mstatus, SPIE, IE);
    WR_CSR_FIELDC(riscv, mstatus, SIE, 0);

    // clear scause register if not in CLIC mode
    if(!useCLICS(riscv)) {
        WR_CSR64(riscv, scause, 0);
    }

    // update scause register
    WR_CSR_FIELDC (riscv, scause, ExceptionCode, cxt->ecodeMod);
    WR_CSR_FIELD_S(riscv, scause, Interrupt,     cxt->isInt);
    WR_CSR_FIELDC (riscv, scause, pil,           IL);

    // update writable bits in sepc register
    Uns64 epcMask = RD_CSR_MASK64(riscv, sepc);
    WR_CSR64(riscv, sepc, cxt->EPC & epcMask);

    // update stval, htval and htinst registers
    WR_CSR64(riscv, stval,  cxt->tval);
    WR_CSR64(riscv, htval,  riscv->GPA);
    WR_CSR64(riscv, htinst, riscv->tinst);

    // get exception base address and mode
    Uns64 tvec = RD_CSR_S(riscv, stvec);
    getExceptBaseMode(riscv, cxt, tvec, riscv->SIMode, riscvGetIntModeS(riscv));

    // fill tvt address
    cxt->tvt = RD_CSR_S(riscv, stvt);

    // update exception level
    if(cxt->level>=0) {
        WR_CSR_FIELDC(riscv, mintstatus, sil, cxt->level);
    }

    // update previous mode
    WR_CSR_FIELDC(riscv, mstatus, SPP, cxt->modeY);
    WR_CSR_FIELDC(riscv, hstatus, SPV, VY);
    WR_CSR_FIELDC(riscv, hstatus, GVA, riscv->GVA);

    // if access is from a virtual mode, update SPVP with that mode
    if(VY) {
        WR_CSR_FIELDC(riscv, hstatus, SPVP, cxt->modeY);
    }
}

//
// Take trap to VS mode
//
static void trapVS(riscvP riscv, trapCxtP cxt) {

    // get interrupt enable and level bits for mode X
    Uns8 IE = RD_CSR_FIELDC(riscv, vsstatus, SIE);

    // update interrupt enable and interrupt enable stack
    WR_CSR_FIELDC(riscv, vsstatus, SPIE, IE);
    WR_CSR_FIELDC(riscv, vsstatus, SIE, 0);

    // clear vscause register if not in CLIC mode
    if(!useCLICVS(riscv)) {
        WR_CSR64(riscv, vscause, 0);
    }

    // update vscause register
    WR_CSR_FIELDC  (riscv, vscause, ExceptionCode, mapVSIntCode(cxt));
    WR_CSR_FIELD_VS(riscv, vscause, Interrupt,     cxt->isInt);

    // update writable bits in vsepc register
    Uns64 epcMask = RD_CSR_MASK64(riscv, sepc);
    WR_CSR64(riscv, vsepc, cxt->EPC & epcMask);

    // update vstval register
    WR_CSR64(riscv, vstval, cxt->tval);

    // get exception base address and mode
    Uns64 tvec = RD_CSR_VS(riscv, vstvec);
    getExceptBaseMode(riscv, cxt, tvec, riscv->SIMode, riscvGetIntModeVS(riscv));

    // update previous mode
    WR_CSR_FIELDC(riscv, vsstatus, SPP, cxt->modeY);
}

//
// Take trap to M mode
//
static void trapM(riscvP riscv, trapCxtP cxt) {

    // get virtual state of source mode (modeY)
    Bool VY = modeIsVirtual(cxt->modeY);

    // get interrupt enable and level bits for mode X
    Uns8 IE = RD_CSR_FIELDC(riscv, mstatus,    MIE);
    Uns8 IL = RD_CSR_FIELDC(riscv, mintstatus, mil);

    // update interrupt enable and interrupt enable stack
    WR_CSR_FIELDC(riscv, mstatus, MPIE, IE);
    WR_CSR_FIELDC(riscv, mstatus, MIE, 0);

    // clear mcause register if not in CLIC mode
    if(!useCLICM(riscv)) {
        WR_CSR64(riscv, mcause, 0);
    }

    // update mcause register
    WR_CSR_FIELDC (riscv, mcause, ExceptionCode, cxt->ecodeMod);
    WR_CSR_FIELD_M(riscv, mcause, Interrupt,     cxt->isInt);
    WR_CSR_FIELDC (riscv, mcause, pil,           IL);

    // update writable bits in mepc register
    Uns64 epcMask = RD_CSR_MASK64(riscv, mepc);
    WR_CSR64(riscv, mepc, cxt->EPC & epcMask);

    // update mtval, mtval2 and tinst registers
    WR_CSR64(riscv, mtval,  cxt->tval);
    WR_CSR64(riscv, mtval2, riscv->GPA);
    WR_CSR64(riscv, mtinst, riscv->tinst);

    // get exception base address and mode
    Uns64 tvec = RD_CSR_M(riscv, mtvec);
    getExceptBaseMode(riscv, cxt, tvec, riscv->MIMode, riscvGetIntModeM(riscv));

    // fill tvt address
    cxt->tvt = RD_CSR_M(riscv, mtvt);

    // update exception level
    if(cxt->level>=0) {
        WR_CSR_FIELDC(riscv, mintstatus, mil, cxt->level);
    }

    // update previous mode
    WR_CSR_FIELDC(riscv, mstatus, MPP, cxt->modeY);
    WR_CSR_FIELD64(riscv, mstatus, MPV, VY);
    WR_CSR_FIELD64(riscv, mstatus, GVA, riscv->GVA);

    // update tcontrol.mpte and tcontrol.mte
    WR_CSR_FIELDC(riscv, tcontrol, mpte, RD_CSR_FIELDC(riscv, tcontrol, mte));
    WR_CSR_FIELDC(riscv, tcontrol, mte, 0);
}

//
// Take pending fetch exception
//
static void takePendingFetchException(riscvP riscv, Uns64 tval) {

    riscvTakeException(riscv, riscv->exceptionFetch, tval);

    riscv->exceptionFetch = 0;
}

//
// Get CLIC vectored handler address at the given memory address
//
static Bool getCLICVPC(riscvP riscv, Uns64 address, Uns64 *handlerPCP) {

    riscvMode      mode         = getCurrentMode5(riscv);
    memEndian      endian       = riscvGetDataEndian(riscv, mode);
    memAccessAttrs memAttrs     = vectorTablePriv(riscv);
    memDomainP     domain       = vectorTableDomain(riscv, memAttrs);
    riscvException oldException = riscv->exception;
    Bool           ok           = False;
    Uns64          handlerPC    = 0;

    // clear exception indication
    riscv->exception = 0;

    // indicate CLIC vector access active
    riscv->inhv = True;

    // read 4-byte or 8-byte entry
    if(riscv->exceptionFetch) {
        takePendingFetchException(riscv, address);
    } else if(riscvGetXlenMode(riscv)==32) {
        handlerPC = vmirtRead4ByteDomain(domain, address, endian, memAttrs);
    } else {
        handlerPC = vmirtRead8ByteDomain(domain, address, endian, memAttrs);
    }

    // indicate CLIC vector access inactive
    riscv->inhv = False;

    // determine whether exception occurred on table load
    if(!riscv->exception) {

        // restore previous exception context
        riscv->exception = oldException;

        // mask off LSB from result
        *handlerPCP = handlerPC & -2;

        ok = True;
    }

    return ok;
}

//
// Get CLIC vectored handler address given table address
//
static Bool getCLICVHandlerPC(riscvP riscv, trapCxtP cxt) {

    Uns32 ptrBytes = riscvGetXlenMode(riscv)/8;
    Uns64 address  = cxt->tvt + (ptrBytes*cxt->ecodeMod);

    // get target PC from calculated address
    return getCLICVPC(riscv, address, &cxt->handlerPC);
}

//
// Custom handler PC action
//
typedef enum customHActionE {
    CHA_NA,     // no custom handler function
    CHA_OK,     // handler address returned
    CHA_EXCEPT, // handler address calculation caused exception
} customHAction;

//
// Get custom handler PC
//
static customHAction getCustomHandlerPC(
    riscvP      riscv,
    Uns64       tvec,
    riscvICMode mode,
    Uns32       ecode,
    Uns64      *handlerPCP
) {
    customHAction  action    = CHA_NA;
    Bool           custom    = False;
    riscvException exception = riscv->exception;

    // clear exception indication (for derived exception detection)
    riscv->exception = 0;

    // do any derived model handler PC lookup
    ITER_EXT_CB_WHILE(
        riscv, extCB, getHandlerPC, !custom,
        custom = extCB->getHandlerPC(
            riscv, tvec, mode, exception, ecode, handlerPCP, extCB->clientData
        );
    )

    // handle derived exception if custom handler is present
    if(!custom) {
        riscv->exception = exception;
    } else if(riscv->exception) {
        action = CHA_EXCEPT;
    } else {
        riscv->exception = exception;
        action = CHA_OK;
    }

    return action;
}

//
// Notify a derived model of trap if required
//
inline static void notifyTrapDerived(riscvP riscv, riscvMode mode) {
    ITER_EXT_CB(
        riscv, extCB, trapNotifier,
        extCB->trapNotifier(riscv, mode, ERT_NA, extCB->clientData);
    )
}

//
// Pre Notify a derived model of trap if required
//
inline static void preNotifyTrapDerived(riscvP riscv, riscvMode mode) {
    ITER_EXT_CB(
        riscv, extCB, trapPreNotifier,
        extCB->trapPreNotifier(riscv, mode, ERT_NA, extCB->clientData);
    )
}

//
// Notify a derived model of exception return if required
//
inline static void notifyERETDerived(
    riscvP        riscv,
    riscvMode     mode,
    riscvERETType eretType
) {
    ITER_EXT_CB(
        riscv, extCB, ERETNotifier,
        extCB->ERETNotifier(riscv, mode, eretType, extCB->clientData);
    )
}

//
// Is the exception an external interrupt?
//
inline static Bool isExternalInterrupt(riscvException exception) {
    return (
        (exception>=riscv_E_UExternalInterrupt) &&
        (exception<=riscv_E_MExternalInterrupt)
    );
}

//
// End interrupt acknowledge
//
static VMI_ICOUNT_FN(endIntAcknowledge) {

    riscvP riscv = (riscvP)processor;

    writeNet(riscv, riscv->irq_ack_Handle, 0);
}

//
// Start interrupt acknowledge
//
static void startIntAcknowledge(riscvP riscv, trapCxtP cxt) {

    // indicate activated interrupt
    writeNet(riscv, riscv->irq_id_Handle, cxt->ecodeMod);

    // raise acknowledge
    writeNet(riscv, riscv->irq_ack_Handle, 1);

    // handle any trigger activated on an interrupt
    riscvTriggerInterrupt(riscv, cxt->modeY, cxt->ecodeMod);

    // set timer to end interrupt acknowledge if required
    if(riscv->irq_ack_Handle) {
        vmirtSetModelTimer(riscv->ackTimer, 1);
    }
}

//
// Clear HLV/HLVX/HSV indication and atomic state
//
static void clearVirtualAtomic(riscvP riscv) {

    // clear active HLV/HLVX/HSV indication
    riscv->HLVHSV = False;

    // clear active AMO indication
    if(riscv->atomic) {
        riscv->atomic = ACODE_NONE;
        writeNet(riscv, riscv->AMOActiveHandle, ACODE_NONE);
    }
}

//
// Take processor exception
//
void riscvTakeException(
    riscvP         riscv,
    riscvException exception,
    Uns64          tval
) {
    // S-mode external, timer and software interrupts taken to VS-mode should
    // be mapped to VS-mode equivalents in this function
    if(isSStandardInterrupt(exception) && (riscv->pendEnab.priv==RISCV_MODE_VS)) {
        exception++;
    }

    // indicate the taken exception
    riscv->exception = exception;

    // indicate any executing instruction will not retire
    riscvNoRetire(riscv);

    // unless step mode bug workaround is enabled, anything causing entry to
    // exception handler counts as a successful step for debug purposes, so
    // decrement stepICount so that a debug step exception will definitely occur
    // on the next instruction if required
    if(!riscv->configInfo.defer_step_bug) {
        riscv->stepICount--;
    }

    if(inDebugMode(riscv)) {

        // terminate execution of program buffer
        vmirtAbortRepeat((vmiProcessorP)riscv);
        enterDM(riscv, DMC_NONE);

    } else {

        Bool  shv   = riscv->clic.sel.shv;
        Uns32 ecode = getExceptionCode(exception);
        Bool  inhv  = riscv->inhv;

        // clear active HLV/HLVX/HSV indication and atomic state
        clearVirtualAtomic(riscv);

        // set trap context information
        trapCxt cxt = {
            handlerPC : 0,
            EPC       : inhvAffectsEPC(riscv, inhv) ? tval : getEPC(riscv),
            tval      : riscv->configInfo.tval_zero ? 0 : tval,
            ecodeMod  : ecode,
            level     : -1,
            modeY     : getCurrentMode5(riscv),
            isInt     : isInterrupt(exception)
        };

        // clear any active exclusive access if required
        if(!riscv->configInfo.trap_preserves_lr) {
            clearEA(riscv);
        }

        // get exception target mode (X)
        if(!cxt.isInt) {
            cxt.modeX = getExceptionModeX(riscv, ecode);
        } else {
            cxt.modeX = riscv->pendEnab.priv;
        }

        if(!inhv) {
            // trap vector table read not active
        } else if(cxt.modeX==RISCV_MODE_U) {
            WR_CSR_FIELDC(riscv, ucause, inhv, 1);
        } else if(cxt.modeY==RISCV_MODE_VU) {
            WR_CSR_FIELDC(riscv, ucause, inhv, 1);
        } else if(cxt.modeY==RISCV_MODE_S) {
            WR_CSR_FIELDC(riscv, scause, inhv, 1);
        } else if(cxt.modeY==RISCV_MODE_VS) {
            WR_CSR_FIELDC(riscv, vscause, inhv, 1);
        } else if(cxt.modeY==RISCV_MODE_M) {
            WR_CSR_FIELDC(riscv, mcause, inhv, 1);
        }

        // indicate CLIC vector access inactive
        riscv->inhv = False;

        // modify code reported for external interrupts if required
        if(isExternalInterrupt(exception)) {
            Uns32 offset = exception-riscv_E_ExternalInterrupt;
            cxt.ecodeMod = riscv->extInt[offset] ? : ecode;
        }

        // CLIC mode: horizontal synchronous exception traps, which stay within
        // a privilege mode, are serviced with the same interrupt level as the
        // instruction that raised the exception. Vertical synchronous exception
        // traps, which are serviced at a higher privilege mode, are taken at
        // interrupt level 0 in the higher privilege mode.
        if(cxt.isInt) {
            cxt.level = riscv->pendEnab.level;
        } else if(cxt.modeX != cxt.modeY) {
            cxt.level = 0;
        }

        // notify derived model of exception entry if required
        preNotifyTrapDerived(riscv, cxt.modeX);

        // clear exception detail before possible nested exception
        riscv->exceptionDetail = riscv_ED_None;

        // update state dependent on target exception level
        if(cxt.modeX==RISCV_MODE_U) {
            trapU(riscv, &cxt);
        } else if(cxt.modeX==RISCV_MODE_VU) {
            trapVU(riscv, &cxt);
        } else if(cxt.modeX==RISCV_MODE_S) {
            trapHS(riscv, &cxt);
        } else if(cxt.modeX==RISCV_MODE_VS) {
            trapVS(riscv, &cxt);
        } else if(cxt.modeX==RISCV_MODE_M) {
            trapM(riscv, &cxt);
        } else {                                // LCOV_EXCL_LINE
            VMI_ABORT("unimplemented mode X");  // LCOV_EXCL_LINE
        }

        // switch to target mode
        riscvSetMode(riscv, cxt.modeX);

        // perform any custom handler PC lookup
        customHAction action = getCustomHandlerPC(
            riscv, cxt.base, cxt.mode, cxt.ecodeMod, &cxt.handlerPC
        );

        if(action==CHA_OK) {

            // use custom handler address

        } else if(action==CHA_EXCEPT) {

            // custom handler address lookup itself caused exception
            return;

        } else if(!(cxt.mode & riscv_int_Vectored) || !cxt.isInt) {

            cxt.handlerPC = cxt.base;

        } else if(!(cxt.mode & riscv_int_CLIC)) {

            cxt.handlerPC = cxt.base + (4 * cxt.ecodeMod);

        } else if(CLICPresent(riscv) && !shv) {

            cxt.handlerPC = cxt.base;

        } else if(riscv->configInfo.tvt_undefined) {

            cxt.handlerPC = cxt.base + (4 * cxt.ecodeMod);

        } else {

            // CLIC behavior when Hypervisor implemented is not fully
            // defined (for example, what tvt CSRs are used)
            VMI_ASSERT(!modeIsVirtual(cxt.modeX), "TODO: virtualized mode");

            // SHV interrupts are acknowledged automatically
            riscvAcknowledgeCLICInt(riscv, cxt.ecodeMod);

            // abort further action if handler address lookup failed
            if(!getCLICVHandlerPC(riscv, &cxt)) {
                return;
            }
        }

        // set address at which to execute
        setPCException(riscv, cxt.handlerPC);

        // notify derived model of exception entry if required
        notifyTrapDerived(riscv, cxt.modeX);

        // acknowledge interrupt if required
        if(cxt.isInt) {
            startIntAcknowledge(riscv, &cxt);
        } else {
            riscvTriggerException(riscv, cxt.modeY, cxt.ecodeMod);
        }
    }
}

//
// Take asynchronous processor exception
//
void riscvTakeAsynchonousException(
    riscvP         riscv,
    riscvException exception,
    Uns64          tval
) {
    // restart from stalled state if required
    riscvRestart(riscv, RVD_RESTART_NMI);

    // this function is intended for use with exceptions, but if used to
    // signal an *interrupt* in a custom manner, assume that the interrupt must
    // be taken at M-mode (probably an NMI)
    riscv->pendEnab.priv = RISCV_MODE_M;

    // take exception
    riscvTakeException(riscv, exception, tval);

    // refresh pending interrupt state (in case previously enabled interrupt
    // is now masked)
    if(riscv->pendEnab.id!=RV_NO_INT) {
        riscvRefreshPendingAndEnabled(riscv);
    }
}

//
// Specify any exception to be taken on the next instruction fetch
//
void riscvPendFetchException(
    riscvP         riscv,
    riscvException exception
) {
    riscv->exceptionFetch = exception;

    if(exception) {
        doSynchronousInterrupt(riscv);
    }
}

//
// Return description of the given interrupt
//
static const char *getInterruptDesc(riscvException code, char *buffer) {

    Uns32 localNum = code-riscv_E_LocalInterrupt;
    Uns32 id       = exceptionToInt(code);

    VMI_ASSERT(code>=riscv_E_LocalInterrupt, "expected local interrupt");

    sprintf(buffer, "Local interrupt %u (id %u)", localNum, id);

    return buffer;
}

//
// Forward reference
//
static vmiExceptionInfoCP getExceptions(riscvP riscv);

//
// Return description of the given exception
//
static const char *getExceptionDesc(
    riscvP         riscv,
    riscvException exception,
    char          *buffer
) {
    const char        *result = 0;
    vmiExceptionInfoCP this;

    for(this=getExceptions(riscv); this->description && !result; this++) {
        if(this->code==exception) {
            result = this->description;
        }
    }

    return result;
}

//
// Report memory exception in verbose mode
//
static void reportMemoryException(
    riscvP         riscv,
    riscvException exception,
    Uns64          tval
) {
    if(riscv->verbose) {
        char buffer[32];
        vmiMessage("W", CPU_PREFIX "_IMA",
            SRCREF_FMT "%s (0x"FMT_Ax")",
            SRCREF_ARGS(riscv, getPC(riscv)),
            getExceptionDesc(riscv, exception, buffer), tval
        );
    }
}

//
// Should a memory exception of the given type be suppressed for a
// fault-only-first instruction or other custom reason?
//
static Bool suppressMemExcept(riscvP riscv, riscvException exception) {

    Bool suppress = handleFF(riscv);

    // handle suppression by extension
    ITER_EXT_CB_WHILE(
        riscv, extCB, suppressMemExcept, !suppress,
        suppress = extCB->suppressMemExcept(riscv, exception, extCB->clientData);
    )

    return suppress;
}

//
// Map load size in bits to decode value
//
static Uns32 mapMemBits(Uns32 memBits) {

    Uns32 result = 0;

    while(memBits>8) {
        result++;
        memBits >>= 1;
    }

    return result;
}

//
// Fill syndrome for load exception
//
static Uns32 fillSyndromeLoad(riscvInstrInfoP info, Uns32 offset) {

    // union for load instruction composition
    typedef union ldSyndromeU {
        struct {
            Uns32 opcode :  7;
            Uns32 rd     :  5;
            Uns32 funct3 :  3;
            Uns32 offset :  5;
            Uns32 _u1    : 12;
        } f;
        Uns32 u32;
    } ldSyndrome;

    ldSyndrome   u1  = {{0}};
    riscvRegDesc rd  = info->r[0];
    Bool         isF = isFReg(rd);

    // fill instruction fields
    u1.f.opcode = (isF ? 0x06 : 0x02) + (info->bytes==4);
    u1.f.rd     = getRIndex(rd);
    u1.f.funct3 = mapMemBits(info->memBits) + (info->unsExt*4);
    u1.f.offset = offset;

    // extract result
    Uns32 result = u1.u32;

    // sanity check composed result if a 32-bit instruction
    if(info->bytes==4) {

        ldSyndrome u2 = {u32:info->instruction};

        // clear offset fields that will not match
        u1.f._u1    = 0;
        u2.f._u1    = 0;
        u1.f.offset = 0;
        u2.f.offset = 0;

        VMI_ASSERT(
            u2.u32==u1.u32,
            "incorrect load syndrome: expected 0x%08x, actual 0x%08x",
            u2.u32, u1.u32
        );
    }

    // return composed value
    return result;
}

//
// Fill syndrome for store exception
//
static Uns32 fillSyndromeStore(riscvInstrInfoP info, Uns32 offset) {

    // union for store instruction composition
    typedef union stSyndromeU {
        struct {
            Uns32 opcode : 7;
            Uns32 _u1    : 5;
            Uns32 funct3 : 3;
            Uns32 offset : 5;
            Uns32 rs2    : 5;
            Uns32 _u2    : 7;
        } f;
        Uns32 u32;
    } stSyndrome;

    stSyndrome   u1  = {{0}};
    riscvRegDesc rs2 = info->r[0];
    Bool         isF = isFReg(rs2);

    // fill instruction fields
    u1.f.opcode = (isF ? 0x26 : 0x22) + (info->bytes==4);
    u1.f.rs2    = getRIndex(rs2);
    u1.f.funct3 = mapMemBits(info->memBits);
    u1.f.offset = offset;

    // extract result
    Uns32 result = u1.u32;

    // sanity check composed result if a 32-bit instruction
    if(info->bytes==4) {

        stSyndrome u2 = {u32:info->instruction};

        // clear offset fields that will not match
        u1.f._u1    = 0;
        u2.f._u1    = 0;
        u1.f._u2    = 0;
        u2.f._u2    = 0;
        u1.f.offset = 0;
        u2.f.offset = 0;

        VMI_ASSERT(
            u2.u32==u1.u32,
            "incorrect store syndrome: expected 0x%08x, actual 0x%08x",
            u2.u32, u1.u32
        );
    }

    // return composed value
    return result;
}

//
// Fill syndrome for generic 32-bit instruction that is reported unmodified,
// except for offset in fields 19:15
//
static Uns32 fillSyndrome32Offset_19_15(riscvInstrInfoP info, Uns32 offset) {

    // union for instruction composition
    typedef union i32SyndromeU {
        struct {
            Uns32 _u1    : 15;
            Uns32 offset :  5;
            Uns32 _u2    : 12;
        } f;
        Uns32 u32;
    } i32Syndrome;

    // sanity check only 4-byte instructions are encountered
    VMI_ASSERT(info->bytes==4, "unexpected instruction bytes %u", info->bytes);

    // use raw 32-bit instruction pattern without modification
    i32Syndrome u = {u32:info->instruction};

    // update offset field
    u.f.offset = offset;

    // return composed value
    return u.u32;
}

//
// Fill syndrome for load/store/AMO exception if required
//
static Uns64 fillSyndrome(riscvP riscv, riscvException exception, Uns64 VA) {

    Uns32 result = 0;

    // create syndrome for load/store/AMO exception if required
    if(!xtinstBasic(riscv) && riscvIsLoadStoreAMOFault(exception)) {

        riscvInstrInfo info;

        // decode the faulting instruction
        riscvDecode(riscv, getPC(riscv), &info);

        // calculate offset between faulting address and original virtual
        // address (non-zero only for misaligned memory accesses)
        Uns64 offset = VA-riscv->originalVA;

        // sanity check offset is valid
        VMI_ASSERT(
            offset<32,
            "Syndrome offset exceeds maximum 31 (original address 0x"FMT_Ax", "
            "faulting address 0x"FMT_Ax")",
            riscv->originalVA, VA
        );

        if(info.type==RV_IT_L_I) {
            result = fillSyndromeLoad(&info, offset);
        } else if(info.type==RV_IT_S_I) {
            result = fillSyndromeStore(&info, offset);
        } else if((info.type>=RV_IT_AMOADD_R) && (info.type<=RV_IT_SC_R)) {
            result = fillSyndrome32Offset_19_15(&info, offset);
        } else if((info.type>=RV_IT_HLV_R) && (info.type<=RV_IT_HSV_R)) {
            result = fillSyndrome32Offset_19_15(&info, offset);
        } else if((info.type>=RV_IT_CBO_CLEAN) && (info.type<=RV_IT_CBO_ZERO)) {
            result = fillSyndrome32Offset_19_15(&info, offset);
        }
    }

    return result;
}

//
// Take processor exception because of memory access error which could be
// suppressed for a fault-only-first instruction or other custom reason using
// the given GVA value
//
void riscvTakeMemoryExceptionGVA(
    riscvP         riscv,
    riscvException exception,
    Uns64          tval,
    Bool           GVA
) {
    // force vstart to zero if required
    MASK_CSR(riscv, vstart);

    // adjust exception from load to equivalent store if a cache-block
    // management instruction is active (for these, only read access is required
    // but exceptions get reported as if stores)
    if(riscv->CMO) {
        exception |= 2;
        riscv->CMO = RISCV_CMO_NA;
    }

    // adjust reported address if a cache-block management instruction is active
    // (for these, an address based on the original VA must be reported even
    // though the fault is probably generated by access at the cache-aligned
    // address)
    if(riscv->CMOBytes) {

        Uns64 keepBits = -riscv->CMOBytes;

        // preserve non-offset bits in trap value and original VA
        tval              &= keepBits;
        riscv->originalVA &= keepBits;

        // adjust both trap value and original VA to include offset
        tval              += riscv->CMOOffset;
        riscv->originalVA += riscv->CMOOffset;

        riscv->CMOBytes = 0;
    }

    // take exception unless fault-only-first mode or a custom extension
    // overrides it
    if(!suppressMemExcept(riscv, exception)) {

        // fill syndrome for load/store/AMO exception if required
        if(!riscv->tinst && hypervisorPresent(riscv)) {
            riscv->tinst = fillSyndrome(riscv, exception, tval);
        }

        reportMemoryException(riscv, exception, tval);

        riscv->GVA = GVA;
        riscvTakeException(riscv, exception, tval);
        riscv->GVA = False;
    }

    // clear down pending exception GPA and tinst
    riscv->GPA   = 0;
    riscv->tinst = 0;
}

//
// Take processor exception because of memory access error which could be
// suppressed for a fault-only-first instruction or other custom reason
//
void riscvTakeMemoryException(
    riscvP         riscv,
    riscvException exception,
    Uns64          VA
) {
    Uns64 oldVA = riscv->originalVA;

    Bool GVA = (
        // GVA is set if executing in VU/VS mode
        inVMode(riscv) ||
        // GVA is set if exception caused by HLV/HLVX/HSV access
        riscv->HLVHSV  ||
        // GVA is set if data mode is virtual and load/store/AMO fault
        (modeIsVirtual(riscv->dataMode) && riscvIsLoadStoreAMOFault(exception))
    );

    riscv->originalVA = VA;
    riscvTakeMemoryExceptionGVA(riscv, exception, VA, GVA);
    riscv->originalVA = oldVA;
}

//
// Take the given instruction exception trap
//
static void takeInstructionException(riscvP riscv, riscvException exception) {

    Uns64 tval = 0;

    // tval is either 0 or the instruction pattern
    if(riscv->configInfo.tval_ii_code && !riscv->configInfo.tval_zero) {
        tval = riscvFetchInstruction(riscv, getPC(riscv), 0);
    }

    riscvTakeException(riscv, exception, tval);
}

//
// Emit verbose reason for Illegal Instruction
//
static void illegalVerbose(riscvP riscv, const char *reason) {
    if(reason) {
        vmiMessage("W", CPU_PREFIX "_ILL",
            SRCREF_FMT "Illegal instruction - %s",
            SRCREF_ARGS(riscv, getPC(riscv)),
            reason
        );
    } else {
        vmiMessage("W", CPU_PREFIX "_ILL",
            SRCREF_FMT "Illegal instruction",
            SRCREF_ARGS(riscv, getPC(riscv))
        );
    }
}

//
// Take custom Illegal Instruction exception for the given reason
//
static void takeInstructionExceptionMessage(
    riscvP         riscv,
    riscvException exception,
    const char    *reason
) {
    // emit verbose message if required
    if(riscv->verbose) {
        illegalVerbose(riscv, reason);
    }

    // take Illegal Instruction exception
    takeInstructionException(riscv, exception);
}


//
// Take custom Illegal Instruction exception for the given reason
//
void riscvIllegalCustom(
    riscvP         riscv,
    riscvException exception,
    const char    *reason
) {
    takeInstructionExceptionMessage(riscv, exception, reason);
}

//
// Take Illegal Instruction exception
//
void riscvIllegalInstruction(riscvP riscv) {
    takeInstructionException(riscv, riscv_E_IllegalInstruction);
}

//
// Take Illegal Instruction exception for the given reason
//
void riscvIllegalInstructionMessage(riscvP riscv, const char *reason) {
    takeInstructionExceptionMessage(riscv, riscv_E_IllegalInstruction, reason);
}

//
// Take Virtual Instruction exception
//
void riscvVirtualInstruction(riscvP riscv) {
    takeInstructionException(riscv, riscv_E_VirtualInstruction);
}

//
// Take Virtual Instruction exception for the given reason
//
void riscvVirtualInstructionMessage(riscvP riscv, const char *reason) {
    takeInstructionExceptionMessage(riscv, riscv_E_VirtualInstruction, reason);
}

//
// Take Instruction Address Misaligned exception
//
void riscvInstructionAddressMisaligned(riscvP riscv, Uns64 tval) {
    riscvTakeMemoryException(riscv, riscv_E_InstructionAddressMisaligned, tval&-2);
}

//
// Execute ECALL instruction
//
void riscvECALL(riscvP riscv) {

    // map from processor mode to mode priority
    static const riscvException reasonMap[] = {
        [RISCV_MODE_M]  = riscv_E_EnvironmentCallFromMMode,
        [RISCV_MODE_S]  = riscv_E_EnvironmentCallFromSMode,
        [RISCV_MODE_VS] = riscv_E_EnvironmentCallFromVSMode,
        [RISCV_MODE_U]  = riscv_E_EnvironmentCallFromUMode,
        [RISCV_MODE_VU] = riscv_E_EnvironmentCallFromUMode,
    };

    riscvTakeException(riscv, reasonMap[getCurrentMode5(riscv)], 0);
}


////////////////////////////////////////////////////////////////////////////////
// EXCEPTION RETURN
////////////////////////////////////////////////////////////////////////////////

//
// Given a mode to which the processor is attempting to return, check that the
// mode is implemented on this processor and return the minimum implemented
// mode if not
//
static riscvMode getERETMode(riscvP riscv, riscvMode newMode, riscvMode minMode) {
    return riscvHasMode(riscv, newMode) ? newMode : minMode;
}

//
// From version 1.12, MRET and SRET clear MPRV when leaving M-mode if new mode
// is less privileged than M-mode
//
static void clearMPRV(riscvP riscv, riscvMode newMode) {
    if((RISCV_PRIV_VERSION(riscv)>=RVPV_1_12) && (newMode!=RISCV_MODE_M)) {
        WR_CSR_FIELDC(riscv, mstatus, MPRV, 0);
    }
}

//
// Do common actions when returning from an exception
//
static void doERETCommon(
    riscvP        riscv,
    riscvMode     newMode,
    riscvERETType eretType,
    Uns64         epc,
    Bool          inhv
) {
    riscvMode oldMode = getCurrentMode5(riscv);

    // switch to User or Supervisor mode on a machine with PMP when no regions
    // configured will always trap, so unconditionally warn about this
    if((newMode!=RISCV_MODE_M) && riscv->warnNoPMPUS) {

        riscv->warnNoPMPUS = False;

        vmiMessage("W", CPU_PREFIX "_PMP_US",
            SRCREF_FMT
            "Switch to %s mode without first configuring PMP regions "
            "will always cause Access Fault",
            SRCREF_ARGS(riscv, getPC(riscv)),
            riscvGetModeName(newMode)
        );
    }

    // switch to target mode
    riscvSetMode(riscv, newMode);

    // jump to return address if either not vectored or vector address lookup
    // succeeds
    if(!inhv || getCLICVPC(riscv, epc, &epc)) {
        setPCxRET(riscv, epc);
    }

    // clear CLIC xintthresh if required
    if(oldMode==newMode) {
        // no mode switch
    } else if(!xretClearsIntThresh(riscv)) {
        // clearing of xintthresh not implemented
    } else if(oldMode==RISCV_MODE_M) {
        WR_CSR32(riscv, mintthresh, riscv->threshOnes);
    } else {
        WR_CSR32(riscv, sintthresh, riscv->threshOnes);
    }

    // notify derived model of exception return if required
    notifyERETDerived(riscv, oldMode, eretType);

    // check for pending interrupts
    riscvTestInterrupt(riscv);
}

//
// Handle MRET, SRET or URET in Debug mode (behavior is unspecified; this model
// can treat this as a NOP, jump to dexc_address or trap to dexc_address)
//
static void handleDebugModeERET(riscvP riscv) {

    switch(riscv->configInfo.debug_eret_mode) {

        case RVDRM_JUMP:
            setPC(riscv, riscv->configInfo.dexc_address);
            break;

        case RVDRM_TRAP:
            riscvIllegalInstructionMessage(riscv, "in debug mode");
            break;

        default:
            break;
    }
}

//
// Perform any special actions when exception return is executed in Debug mode
//
#define HANDLE_DMODE_RET(_P) \
    if(inDebugMode(_P)) {           \
        handleDebugModeERET(_P);    \
        return;                     \
    }

//
// Get inhv for target mode
//
static Bool getXRETInhv(riscvP riscv, riscvMode newMode) {

    Bool inhv = False;

    if(newMode==RISCV_MODE_U) {
        inhv = RD_CSR_FIELDC(riscv, ucause, inhv);
        WR_CSR_FIELDC(riscv, ucause, inhv, 0);
    } else if(newMode==RISCV_MODE_VU) {
        inhv = RD_CSR_FIELDC(riscv, ucause, inhv);
        WR_CSR_FIELDC(riscv, ucause, inhv, 0);
    } else if(newMode==RISCV_MODE_S) {
        inhv = RD_CSR_FIELDC(riscv, scause, inhv);
        WR_CSR_FIELDC(riscv, scause, inhv, 0);
    } else if(newMode==RISCV_MODE_VS) {
        inhv = RD_CSR_FIELDC(riscv, vscause, inhv);
        WR_CSR_FIELDC(riscv, vscause, inhv, 0);
    } else if(newMode==RISCV_MODE_M) {
        inhv = RD_CSR_FIELDC(riscv, mcause, inhv);
        WR_CSR_FIELDC(riscv, mcause, inhv, 0);
    }

    return inhv;
}

//
// Return from M-mode resumable NMI exception
//
void riscvMNRET(riscvP riscv) {

    Uns32     MPP     = RD_CSR_FIELDC(riscv, mnstatus, MNPP);
    Bool      MPV     = RD_CSR_FIELD64(riscv, mnstatus, MNPV);
    riscvMode minMode = riscvGetMinMode(riscv);
    riscvMode newMode = getERETMode(riscv, MPP, minMode);

    // handle return to virtual mode if H extension is enabled
    if(MPV && (newMode!=RISCV_MODE_M) && hypervisorEnabled(riscv)) {
        newMode |= RISCV_MODE_V;
    }

    // clear any active exclusive access
    clearEAxRET(riscv);

    // enable interrupts blocked by RNMI state
    WR_CSR_FIELDC(riscv, mnstatus, NMIE, 1);

    // do common return actions
    doERETCommon(riscv, newMode, ERT_MN, RD_CSR_M(riscv, mnepc), False);
}

//
// Return from M-mode exception
//
void riscvMRET(riscvP riscv) {

    // handle exception return in Debug mode
    HANDLE_DMODE_RET(riscv);

    Uns32     MPP     = RD_CSR_FIELDC(riscv, mstatus, MPP);
    Bool      MPV     = RD_CSR_FIELD64(riscv, mstatus, MPV);
    riscvMode minMode = riscvGetMinMode(riscv);
    riscvMode newMode = getERETMode(riscv, MPP, minMode);

    // handle return to virtual mode if H extension is enabled
    if(MPV && (newMode!=RISCV_MODE_M) && hypervisorEnabled(riscv)) {
        newMode |= RISCV_MODE_V;
    }

    // derive target mode inhv value
    Bool useCLIC = useCLICM(riscv);
    Bool inhv    = useCLIC && inhvAffectsEPC(riscv, getXRETInhv(riscv, newMode));

    // clear any active exclusive access
    clearEAxRET(riscv);

    // restore previous mintstatus.mil (CLIC mode)
    if(useCLIC) {
        WR_CSR_FIELDC(riscv, mintstatus, mil, RD_CSR_FIELDC(riscv, mcause, pil));
    }

    // restore previous MIE
    WR_CSR_FIELDC(riscv, mstatus, MIE, RD_CSR_FIELDC(riscv, mstatus, MPIE));

    // MPIE=1
    WR_CSR_FIELDC(riscv, mstatus, MPIE, 1);

    // MPP=<minimum_supported_mode>
    WR_CSR_FIELDC(riscv, mstatus, MPP, minMode);

    // MPV=0
    WR_CSR_FIELD64(riscv, mstatus, MPV, 0);

    // clear mstatus.MPRV if required
    clearMPRV(riscv, newMode);

    // update tcontrol.mte
    WR_CSR_FIELDC(riscv, tcontrol, mte, RD_CSR_FIELDC(riscv, tcontrol, mpte));

    // do common return actions
    doERETCommon(riscv, newMode, ERT_M, RD_CSR_M(riscv, mepc), inhv);
}

//
// Return from HS-mode exception
//
void riscvHSRET(riscvP riscv) {

    // handle exception return in Debug mode
    HANDLE_DMODE_RET(riscv);

    Uns32     SPP     = RD_CSR_FIELDC(riscv, mstatus, SPP);
    riscvMode minMode = riscvGetMinMode(riscv);
    riscvMode newMode = getERETMode(riscv, SPP, minMode);

    // handle return to virtual mode
    if(RD_CSR_FIELDC(riscv, hstatus, SPV)) {
        newMode |= RISCV_MODE_V;
    }

    // derive target mode inhv value
    Bool useCLIC = useCLICS(riscv);
    Bool inhv    = useCLIC && inhvAffectsEPC(riscv, getXRETInhv(riscv, newMode));

    // clear any active exclusive access
    clearEAxRET(riscv);

    // restore previous mintstatus.sil (CLIC mode)
    if(useCLIC) {
        WR_CSR_FIELDC(riscv, mintstatus, sil, RD_CSR_FIELDC(riscv, scause, pil));
    }

    // restore previous SIE
    WR_CSR_FIELDC(riscv, mstatus, SIE, RD_CSR_FIELDC(riscv, mstatus, SPIE));

    // SPIE=1
    WR_CSR_FIELDC(riscv, mstatus, SPIE, 1);

    // SPP=<minimum_supported_mode>
    WR_CSR_FIELDC(riscv, mstatus, SPP, minMode);

    // SPV=0
    WR_CSR_FIELDC(riscv, hstatus, SPV, 0);

    // clear mstatus.MPRV if required
    clearMPRV(riscv, newMode);

    // do common return actions
    doERETCommon(riscv, newMode, ERT_S, RD_CSR_S(riscv, sepc), inhv);
}

//
// Return from VS-mode exception
//
void riscvVSRET(riscvP riscv) {

    // handle exception return in Debug mode
    HANDLE_DMODE_RET(riscv);

    Uns32     SPP     = RD_CSR_FIELDC(riscv, vsstatus, SPP);
    riscvMode minMode = riscvGetMinMode(riscv);
    riscvMode newMode = getERETMode(riscv, SPP, minMode);

    // always return to virtual mode
    newMode |= RISCV_MODE_V;

    // derive target mode inhv value
    Bool useCLIC = useCLICVS(riscv);
    Bool inhv    = useCLIC && inhvAffectsEPC(riscv, getXRETInhv(riscv, newMode));

    // clear any active exclusive access
    clearEAxRET(riscv);

    // restore previous SIE
    WR_CSR_FIELDC(riscv, vsstatus, SIE, RD_CSR_FIELDC(riscv, vsstatus, SPIE));

    // SPIE=1
    WR_CSR_FIELDC(riscv, vsstatus, SPIE, 1);

    // SPP=<minimum_supported_mode>
    WR_CSR_FIELDC(riscv, vsstatus, SPP, minMode);

    // clear mstatus.MPRV if required
    clearMPRV(riscv, newMode);

    // do common return actions
    doERETCommon(riscv, newMode, ERT_VS, RD_CSR_VS(riscv, vsepc), inhv);
}

//
// Return from U-mode exception
//
void riscvURET(riscvP riscv) {

    // handle exception return in Debug mode
    HANDLE_DMODE_RET(riscv);

    riscvMode newMode = RISCV_MODE_U;

    // derive target mode inhv value
    Bool useCLIC = useCLICU(riscv);
    Bool inhv    = useCLIC && inhvAffectsEPC(riscv, getXRETInhv(riscv, newMode));

    // clear any active exclusive access
    clearEAxRET(riscv);

    // restore previous mintstatus.uil (CLIC mode)
    if(useCLICU(riscv)) {
        WR_CSR_FIELDC(riscv, mintstatus, uil, RD_CSR_FIELDC(riscv, ucause, pil));
    }

    // restore previous UIE
    WR_CSR_FIELDC(riscv, mstatus, UIE, RD_CSR_FIELDC(riscv, mstatus, UPIE));

    // UPIE=1
    WR_CSR_FIELDC(riscv, mstatus, UPIE, 1);

    // do common return actions
    doERETCommon(riscv, newMode, ERT_U, RD_CSR_U(riscv, uepc), inhv);
}

//
// Return from VU-mode exception
//
void riscvVURET(riscvP riscv) {

    // handle exception return in Debug mode
    HANDLE_DMODE_RET(riscv);

    riscvMode newMode = RISCV_MODE_VU;

    // derive target mode inhv value
    Bool useCLIC = useCLICVU(riscv);
    Bool inhv    = useCLIC && inhvAffectsEPC(riscv, getXRETInhv(riscv, newMode));

    // clear any active exclusive access
    clearEAxRET(riscv);

    // restore previous UIE
    WR_CSR_FIELDC(riscv, vsstatus, UIE, RD_CSR_FIELDC(riscv, vsstatus, UPIE));

    // UPIE=1
    WR_CSR_FIELDC(riscv, vsstatus, UPIE, 1);

    // do common return actions
    doERETCommon(riscv, newMode, ERT_VU, RD_CSR_VU(riscv, uepc), inhv);
}


////////////////////////////////////////////////////////////////////////////////
// DEBUG MODE
////////////////////////////////////////////////////////////////////////////////

//
// Update processor Debug mode stalled state
//
inline static void updateDMStall(riscvP riscv, Bool DMStall) {

    // halt or restart processor if required
    if(riscv->configInfo.debug_mode==RVDM_HALT) {

        riscv->DMStall = DMStall;

        if(DMStall) {
            riscvHalt(riscv, RVD_DEBUG);
        } else {
            riscvRestart(riscv, RVD_DEBUG);
        }
    }
}

//
// Update processor Debug mode state
//
inline static void setDM(riscvP riscv, Bool DM) {

    riscv->DM = DM;

    // indicate new Debug mode
    writeNet(riscv, riscv->DMPortHandle, DM);
}

//
// Enter Debug mode
//
static void enterDM(riscvP riscv, dmCause cause) {

    Bool DM = inDebugMode(riscv);

    // clear pending step request on debug mode entry (even for another reason)
    riscv->netValue.stepreq = False;

    // indicate taken exception if a breakpoint
    if(cause!=DMC_NONE) {
        riscv->exception = riscv_E_Breakpoint;
    }

    // clear active HLV/HLVX/HSV indication and atomic state
    clearVirtualAtomic(riscv);

    if(!DM) {

        riscvCountState state;

        // get state before possible inhibit update
        riscvPreInhibit(riscv, &state);

        // update current state
        setDM(riscv, True);

        // save current mode
        riscvSetDCSRMode(riscv, getCurrentMode5(riscv));

        // save cause
        WR_CSR_FIELDC(riscv, dcsr, cause, cause);

        // save current instruction address
        WR_CSR_M(riscv, dpc, getEPC(riscv));

        // switch to Machine mode
        riscvSetMode(riscv, RISCV_MODE_M);

        // refresh state after possible inhibit update
        riscvPostInhibit(riscv, &state, False);
    }

    if(riscv->configInfo.debug_mode==RVDM_INTERRUPT) {

        // interrupt the processor
        vmirtInterrupt((vmiProcessorP)riscv);

    } else if(riscv->configInfo.debug_mode==RVDM_VECTOR) {

        Uns64 address;

        // use either debug entry address or debug exception address
        if(DM && (cause!=DMC_EBREAK)) {
            address = riscv->configInfo.dexc_address;
        } else {
            address = riscv->configInfo.debug_address;
        }

        setPCException(riscv, address);

    } else {

        // set exception PC to the current simulated address (to cause any
        // exception watchpoints to be triggered)
        setPCException(riscv, RD_CSR_M(riscv, dpc));

        // halt or restart processor if required
        updateDMStall(riscv, True);
    }
}

//
// Leave Debug mode
//
static void leaveDM(riscvP riscv) {

    riscvMode       dcsrMode = riscvGetDCSRMode(riscv);
    riscvMode       minMode  = riscvGetMinMode(riscv);
    riscvMode       newMode  = getERETMode(riscv, dcsrMode, minMode);
    riscvCountState state;

    // get state before possible inhibit update
    riscvPreInhibit(riscv, &state);

    // update current state
    setDM(riscv, False);

    // clear mstatus.MPRV if required
    clearMPRV(riscv, newMode);

    // do common return actions
    doERETCommon(riscv, newMode, ERT_D, RD_CSR_M(riscv, dpc), False);

    // set step breakpoint if required
    riscvSetStepBreakpoint(riscv);

    // refresh state after possible inhibit update
    riscvPostInhibit(riscv, &state, False);

    // halt or restart processor if required
    updateDMStall(riscv, False);

    // on exit from debug mode, test for interrupts that are masked in that
    // (e.g. NMI)
    doSynchronousInterrupt(riscv);
}

//
// Enter or leave Debug mode
//
void riscvSetDM(riscvP riscv, Bool DM) {

    Bool oldDM = inDebugMode(riscv);

    if(oldDM==DM) {
        // no change in state
    } else if(riscv->inSaveRestore) {
        setDM(riscv, DM);
    } else if(DM) {
        enterDM(riscv, DMC_TRIGGER);
    } else {
        leaveDM(riscv);
    }
}

//
// Update debug mode stall indication
//
void riscvSetDMStall(riscvP riscv, Bool DMStall) {
    updateDMStall(riscv, DMStall);
}

//
// Is debug step breakpoint enabled?
//
inline static Bool enableDebugStep(riscvP riscv) {
    return !inDebugMode(riscv) && RD_CSR_FIELDC(riscv, dcsr, step);
}

//
// Return least-significant 32 bits of instruction count
//
inline static Uns32 getExecutedICount32(riscvP riscv) {
    return vmirtGetExecutedICount((vmiProcessorP)riscv);
}

//
// Instruction step breakpoint callback
//
static VMI_ICOUNT_FN(riscvStepExcept) {

    riscvP riscv = (riscvP)processor;

    if(riscv->stepICount != getExecutedICount32(riscv)) {

        // single-step time has expired
        Bool doStep = False;

        if(enableDebugStep(riscv)) {
            doSynchronousInterrupt(riscv);
            doStep = True;
        }

        riscv->netValue.stepreq = doStep;

    } else {

        // reset timer for another cycle if cycles have been skipped
        riscvSetStepBreakpoint(riscv);
    }
}

//
// Set step breakpoint if required
//
void riscvSetStepBreakpoint(riscvP riscv) {

    // reset any stale step request indication
    riscv->netValue.stepreq = False;

    if(enableDebugStep(riscv)) {
        riscv->stepICount = getExecutedICount32(riscv);
        vmirtSetModelTimer(riscv->stepTimer, 1);
    }
}

//
// Return from Debug mode
//
void riscvDRET(riscvP riscv) {

    if(!inDebugMode(riscv)) {
        riscvIllegalInstructionMessage(riscv, "not debug mode");
    } else {
        leaveDM(riscv);
    }
}

//
// Execute EBREAK instruction
//
void riscvEBREAK(riscvP riscv) {

    Uns32 modeMask = 1 << (DCSR_EBREAK_SHIFT+getCurrentMode5(riscv));

    if(inDebugMode(riscv) || (RD_CSRC(riscv, dcsr) & modeMask)) {

        // ebreak is not considered to retire
        riscvNoRetire(riscv);

        // don't count the ebreak instruction if dcsr.stopcount is set
        if(RD_CSR_FIELDC(riscv, dcsr, stopcount)) {
            if(!riscvInhibitCycle(riscv)) {
                riscv->baseCycles++;
            }
        }

        // handle EBREAK as Debug module action
        enterDM(riscv, DMC_EBREAK);

    } else if(riscv->configInfo.tval_zero_ebreak) {

        // EBREAK sets mtval (and xstatus.GVA) to 0
        riscvTakeMemoryExceptionGVA(riscv, riscv_E_Breakpoint, 0, 0);

    } else {

        // EBREAK sets mtval to epc
        riscvTakeMemoryException(riscv, riscv_E_Breakpoint, getPC(riscv));
    }
}


////////////////////////////////////////////////////////////////////////////////
// TIME SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Read mtimecmp
//
Uns64 riscvReadMTIMECMP(riscvP hart) {

    return hart->mtimecmp;
}

//
// Write mtimecmp
//
void riscvWriteMTIMECMP(riscvP hart, Uns64 value) {

    hart->mtimecmp = value;

    riscvUpdateTimer(hart);
}

//
// Read mtime
//
Uns64 riscvReadMTIME(riscvP hart) {

    Uns64 result = hart->mtimebase;

    if(hart->mtime) {
        result += vmirtGetModelTimerCurrentCount(hart->mtime, True);
    }

    return result;
}

//
// Write mtime
//
void riscvWriteMTIME(riscvP hart, Uns64 value) {

    hart->mtimebase = value;

    if(hart->mtime) {
        hart->mtimebase -= vmirtGetModelTimerCurrentCount(hart->mtime, True);
    }

    riscvUpdateTimer(hart);
}

//
// Refresh timer state given time and timecmp values, returning Boolean
// indicating whether this timer is now pending
//
static Bool updateTimerInt(
    riscvP riscv,
    Uns64  time,
    Uns64  timecmp,
    Uns64 *timeoutP
) {
    Bool  pending = (time>=timecmp);
    Uns64 timeout = pending ? -time : (timecmp-time);

    // adjust timeout
    if(*timeoutP>timeout) {
        *timeoutP = timeout;
    }

    return pending;
}

//
// Refresh timer interrupt state controlled by mtimecmp, stimecmp and vstimecmp
//
void riscvUpdateTimer(riscvP hart) {

    Uns64 mtime           = riscvReadMTIME(hart);
    Bool  mtimecmpPresent = hart->clint;
    Bool  stimecmpPresent = Sstc(hart);
    Uns64 timeout         = -1;

    // handle mtimecmp effect
    if(mtimecmpPresent) {

        Uns32 intNum   = exceptionToInt(riscv_E_MTimerInterrupt);
        Bool  oldValue = hart->ip[0] & (1<<intNum);
        Uns64 mtimecmp = riscvReadMTIMECMP(hart);
        Bool  newValue = updateTimerInt(hart, mtime, mtimecmp, &timeout);

        // modify mtip pending state if required
        if(oldValue!=newValue) {
            riscvUpdateInterrupt(hart, intNum, newValue);
        }
    }

    // handle stimecmp effect
    if(stimecmpPresent) {

        Uns64 stimecmp = RD_CSR64(hart, stimecmp);
        Bool  newValue = updateTimerInt(hart, mtime, stimecmp, &timeout);

        // modify stip pending state if required
        if(hart->stimecmp!=newValue) {
            hart->stimecmp = newValue;
            riscvUpdatePending(hart);
        }
    }

    // handle vstimecmp effect
    if(stimecmpPresent && hypervisorPresent(hart)) {

        Uns64 vstimecmp = RD_CSR64(hart, vstimecmp);
        Uns64 vmtime    = mtime + RD_CSR64(hart, htimedelta);
        Bool  newValue  = updateTimerInt(hart, vmtime, vstimecmp, &timeout);

        // modify vstip pending state if required
        if(hart->vstimecmp!=newValue) {
            hart->vstimecmp = newValue;
            riscvUpdatePending(hart);
        }
    }

    // set next timeout
    if(hart->mtime && (mtimecmpPresent || stimecmpPresent)) {
        vmirtSetModelTimer(hart->mtime, timeout ? : -1);
    }
}

//
// Timer timeout callback: refresh timer
//
static VMI_ICOUNT_FN(mtimeCB) {
    riscvUpdateTimer((riscvP)processor);
}

//
// Externally-sourced mtime value change
//
static VMI_NET_CHANGE_FN(mtimePortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    riscvWriteMTIME(riscv, newValue);
}


////////////////////////////////////////////////////////////////////////////////
// ALIGNMENT CHECK UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Should unaligned loads cause an access fault?
//
static Bool faultMisalignedLoad(
    riscvP     riscv,
    memDomainP domain,
    Uns64      address,
    Uns32      bytes
) {
    Bool fault = False;

    // if unaligned accesses are not always permitted, query derived model to
    // determine whether a normal load of this address and size is allowed
    ITER_EXT_CB_WHILE(
        riscv, extCB, rdFaultCB, !fault,
        fault = extCB->rdFaultCB(
            riscv, domain, address, bytes, extCB->clientData
        )
    )

    return fault;
}

//
// Should unaligned stores cause an access fault?
//
static Bool faultMisalignedStore(
    riscvP     riscv,
    memDomainP domain,
    Uns64      address,
    Uns32      bytes
) {
    Bool fault = False;

    // if unaligned accesses are not always permitted, query derived model to
    // determine whether a normal load of this address and size is allowed
    ITER_EXT_CB_WHILE(
        riscv, extCB, wrFaultCB, !fault,
        fault = extCB->wrFaultCB(
            riscv, domain, address, bytes, extCB->clientData
        )
    )

    return fault;
}

//
// Is a misaligned normal load to the given address permitted?
//
static Bool allowMisalignedLoad(
    riscvP     riscv,
    memDomainP domain,
    Uns64      address,
    Uns32      bytes
) {
    Bool unaligned = riscv->configInfo.unaligned;

    // if unaligned accesses are not always permitted, query derived model to
    // determine whether a normal load of this address and size is allowed
    ITER_EXT_CB(
        riscv, extCB, rdSnapCB,
        unaligned = extCB->rdSnapCB(
            riscv, domain, address, bytes, ACODE_NONE, extCB->clientData
        )
    )

    return unaligned;
}

//
// Is a misaligned normal store to the given address permitted?
//
static Bool allowMisalignedStore(
    riscvP     riscv,
    memDomainP domain,
    Uns64      address,
    Uns32      bytes
) {
    Bool unaligned = riscv->configInfo.unaligned;

    // if unaligned accesses are not always permitted, query derived model to
    // determine whether a normal load of this address and size is allowed
    ITER_EXT_CB(
        riscv, extCB, wrSnapCB,
        unaligned = extCB->wrSnapCB(
            riscv, domain, address, bytes, ACODE_NONE, extCB->clientData
        )
    )

    return unaligned;
}


////////////////////////////////////////////////////////////////////////////////
// VMI INTERFACE ROUTINES
////////////////////////////////////////////////////////////////////////////////

//
// Read privilege exception handler
//
VMI_RD_PRIV_EXCEPT_FN(riscvRdPrivExcept) {

    riscvP  riscv = (riscvP)processor;
    memPriv priv  = (attrs&MEM_AA_FETCH) ? MEM_PRIV_X : MEM_PRIV_R;

    if(!riscvVMMiss(riscv, domain, priv, address, bytes, attrs)) {
        *action = VMI_LOAD_STORE_CONTINUE;
    }
}

//
// Write privilege exception handler
//
VMI_WR_PRIV_EXCEPT_FN(riscvWrPrivExcept) {

    riscvP  riscv = (riscvP)processor;
    memPriv priv  = MEM_PRIV_W;

    if(!riscvVMMiss(riscv, domain, priv, address, bytes, attrs)) {
        *action = VMI_LOAD_STORE_CONTINUE;
    }
}

//
// Read alignment exception handler
//
VMI_RD_ALIGN_EXCEPT_FN(riscvRdAlignExcept) {

    riscvP         riscv     = (riscvP)processor;
    riscvException exception = riscv_E_LoadAddressMisaligned;

    if(!(riscv->exceptionMask & (1ULL<<exception))) {

        // raise LoadAccessFault if LoadAddressMisaligned not implemented
        exception = riscv_E_LoadAccessFault;

    } else if(faultMisalignedLoad(riscv, domain, address, bytes)) {

        // raise LoadAccessFault if required
        exception = riscv_E_LoadAccessFault;

    } else if(!riscv->atomic) {

        // no action

    } else if(allowMisalignedLoad(riscv, domain, address, bytes)) {

        // if this is an atomic operation and a normal load would not raise an
        // LoadAddressMisaligned exception then raise a LoadAccessFault
        // exception instead
        exception = riscv_E_LoadAccessFault;
    }

    riscvTakeMemoryException(riscv, exception, address);

    return 0;
}

//
// Write alignment exception handler
//
VMI_WR_ALIGN_EXCEPT_FN(riscvWrAlignExcept) {

    riscvP         riscv     = (riscvP)processor;
    riscvException exception = riscv_E_StoreAMOAddressMisaligned;

    if(!(riscv->exceptionMask & (1ULL<<exception))) {

        // raise StoreAMOAccessFault if StoreAMOAddressMisaligned not implemented
        exception = riscv_E_StoreAMOAccessFault;

    } else if(faultMisalignedStore(riscv, domain, address, bytes)) {

        // raise StoreAMOAccessFault if required
        exception = riscv_E_StoreAMOAccessFault;

    } else if(!riscv->atomic) {

        // no action

    } else if(allowMisalignedStore(riscv, domain, address, bytes)) {

        // if this is an atomic operation and a normal store would not raise an
        // StoreAMOAddressMisaligned exception then raise a StoreAMOAccessFault
        // exception instead
        exception = riscv_E_StoreAMOAccessFault;
    }

    riscvTakeMemoryException(riscv, exception, address);

    return 0;
}

//
// Read abort exception handler
//
VMI_RD_ABORT_EXCEPT_FN(riscvRdAbortExcept) {

    riscvP riscv = (riscvP)processor;

    if(riscv->PTWActive) {
        riscv->PTWBadAddr = True;
    } else if(isFetch) {
        riscvTakeMemoryException(riscv, riscv_E_InstructionAccessFault, address);
    } else {
        riscvTakeMemoryException(riscv, riscv_E_LoadAccessFault, address);
    }
}

//
// Write abort exception handler
//
VMI_WR_ABORT_EXCEPT_FN(riscvWrAbortExcept) {

    riscvP riscv = (riscvP)processor;

    if(riscv->PTWActive) {
        riscv->PTWBadAddr = True;
    } else {
        riscvTakeMemoryException(riscv, riscv_E_StoreAMOAccessFault, address);
    }
}

//
// Return device error, distinguishing atomic instructions
//
inline static riscvExceptionDtl getDeviceError(riscvP riscv) {
    return riscv->atomic ? riscv_ED_Atomic : riscv_ED_Device;
}

//
// Read device exception handler
//
VMI_RD_DEVICE_EXCEPT_FN(riscvRdDeviceExcept) {

    riscvP riscv = (riscvP)processor;

    riscv->exceptionDetail = getDeviceError(riscv);
    riscvTakeMemoryException(riscv, riscv_E_LoadAccessFault, address);

    return 0;
}

//
// Write device exception handler
//
VMI_WR_DEVICE_EXCEPT_FN(riscvWrDeviceExcept) {

    riscvP riscv = (riscvP)processor;

    riscv->exceptionDetail = getDeviceError(riscv);
    riscvTakeMemoryException(riscv, riscv_E_StoreAMOAccessFault, address);

    return 0;
}

//
// Fetch addresses are always snapped to a 2-byte boundary, irrespective of
// whether compressed instructions are implemented (see comments associated
// with the JALR instruction in the RISC-V User-level ISA)
//
VMI_FETCH_SNAP_FN(riscvFetchSnap) {

    return thisPC & -2;
}

//
// Snap read address if required
//
VMI_RD_WR_SNAP_FN(riscvRdSnap) {

    riscvP riscv = (riscvP)processor;
    Uns32  snap  = MEM_SNAP(0, 0);

    ITER_EXT_CB_WHILE(
        riscv, extCB, rdSnapCB, !snap,
        snap = extCB->rdSnapCB(
            riscv, domain, address, bytes, riscv->atomic, extCB->clientData
        )
    )

    return snap;
}

//
// Snap write address if required
//
VMI_RD_WR_SNAP_FN(riscvWrSnap) {

    riscvP riscv = (riscvP)processor;
    Uns32  snap  = MEM_SNAP(0, 0);

    ITER_EXT_CB_WHILE(
        riscv, extCB, wrSnapCB, !snap,
        snap = extCB->wrSnapCB(
            riscv, domain, address, bytes, riscv->atomic, extCB->clientData
        )
    )

    return snap;
}

//
// Apply any externally-signalled pending fetch exception
//
static riscvException pendingFetchException(
    riscvP riscv,
    Uns64  thisPC,
    Bool   complete
) {
    riscvException pending = riscv->exceptionFetch;

    if(pending && complete) {
        takePendingFetchException(riscv, thisPC);
    }

    return pending;
}

//
// Validate instruction fetch from the passed address
//
static Bool validateFetchAddressInt(
    riscvP     riscv,
    memDomainP domain,
    Uns64      thisPC,
    Bool       complete
) {
    vmiProcessorP  processor = (vmiProcessorP)riscv;
    memAccessAttrs attrs     = complete ? MEM_AA_TRUE : MEM_AA_FALSE;

    if(vmirtIsExecutable(processor, thisPC)) {

        // no exception pending
        return True;

    } else if(riscvVMMiss(riscv, domain, MEM_PRIV_X, thisPC, 2, attrs)) {

        // permission exception of some kind, handled by riscvVMMiss, so no
        // further action required here.
        return False;

    } else if(!vmirtIsExecutable(processor, thisPC)) {

        // bus error if address is not executable
        if(complete) {
            riscvTakeMemoryException(riscv, riscv_E_InstructionAccessFault, thisPC);
        }

        return False;

    } else {

        // no exception pending
        return True;
    }
}

//
// Validate that the passed address is a mapped fetch address (NOTE: address
// alignment is not validated here but by the preceding branch instruction)
//
static Bool validateFetchAddress(
    riscvP     riscv,
    memDomainP domain,
    Uns64      thisPC,
    Bool       complete
) {
    if(pendingFetchException(riscv, thisPC, complete)) {

        // pending fetch exception (handled in pendingFetchException)
        return False;

    } else if(!validateFetchAddressInt(riscv, domain, thisPC, complete)) {

        // fetch exception (handled in validateFetchAddressInt)
        return False;

    } else if(riscvGetInstructionSize(riscv, thisPC) <= 2) {

        // instruction at simPC is a two-byte instruction
        return True;

    } else if(!validateFetchAddressInt(riscv, domain, thisPC+2, complete)) {

        // fetch exception (handled in validateFetchAddressInt)
        return False;

    } else {

        // no exception
        return True;
    }

    // no exception pending
    return True;
}

//
// Return interrupt enable for the passed mode, given a raw interrupt enable
// bit
//
static Bool getIE(riscvP riscv, Bool IE, riscvMode modeIE, Bool useCLIC) {

    Uns8 curPri = mode5Priority(getCurrentMode5(riscv));
    Uns8 IEPri  = mode5Priority(modeIE);

    if(useCLIC) {
        IE = False;
    } else if(curPri<IEPri) {
        IE = True;
    } else if(curPri>IEPri) {
        IE = False;
    }

    return IE;
}

//
// Relocate VSEIP, VSTIP and VSSIE to SEIP, STIP and SSIE locations in the
// given value
//
static Uns64 relocateVStoS(Uns64 ip) {

    ip &= ~(WM64_hvip>>1);
    ip |= (ip&WM64_hvip)>>1;
    ip &= ~WM64_hvip;

    return ip;
}

//
// Get pending and enabled interrupts in mip/mie
//
inline static Uns64 getPendingEnabledMIP(riscvP riscv) {
    return RD_CSR64(riscv, mie) & RD_CSR64(riscv, mip) & ~riscv->disableMask;
}

//
// Get pending and enabled interrupts in mvip/mvien
//
inline static Uns64 getPendingEnabledMVIP(riscvP riscv) {

    Uns64 mvien = getEffectiveMvien(riscv);
    Uns64 mvip  = RD_CSR64(riscv, mvip) & riscv->svie & mvien;

    return mvip;
}

//
// Are there pending and enabled virtual interrupts targeting HS mode?
// (Note that hideleg is *not* masked by mideleg in this case)
//
static Uns64 getPendingEnabledVirtualHS(riscvP riscv) {

    // get pending-and-enabled mvip virtual interrupts directed to HS mode
    Uns64 mvip   = getPendingEnabledMVIP(riscv);
    Uns64 mvipHS = mvip & ~RD_CSR64(riscv, hideleg);

    return mvipHS;
}

//
// Are there pending and enabled virtual interrupts targeting VS mode?
// (Note that hideleg is *not* masked by mideleg in this case)
//
static Uns64 getPendingEnabledVirtualVS(riscvP riscv) {

    // get pending-and-enabled mvip virtual interrupts directed to VS mode
    Uns64 mvip   = getPendingEnabledMVIP(riscv);
    Uns64 hvien  = getEffectiveHvien(riscv);
    Uns64 mvipVS = mvip & RD_CSR64(riscv, hideleg) & ~hvien;

    // get pending-and-enabled hvip virtual interrupts directed to VS mode
    Uns64 hvipVS = RD_CSR64(riscv, hvip) & RD_CSR64(riscv, vsie) & hvien;

    return mvipVS | hvipVS;
}

//
// Fill intBasic structure to indicate which exceptions are pending and enabled
// at each target exception level (note that these could however be masked by
// global interrupt enable or delegation bits - see the Privileged Architecture
// specification)
//
static Bool getPendingLocallyEnabledBasic(
    riscvP              riscv,
    riscvBasicIntStateP intState
) {
    // initially assume no interrupts are pending and enabled
    *intState = (riscvBasicIntState){{0}};

    // get pending-and-enabled standard interrupts
    Uns64 ip = getPendingEnabledMIP(riscv);

    if(ip) {

        ////////////////////////////////////////////////////////////////////////
        // HANDLE TRUE INTERRUPTS PENDED USING MIP/MIE OR ALIASES
        ////////////////////////////////////////////////////////////////////////

        Uns64 mideleg = RD_CSR64(riscv, mideleg);
        Uns64 sideleg = RD_CSR64(riscv, sideleg) & mideleg;
        Uns64 hideleg = RD_CSR64(riscv, hideleg) & mideleg;

        // fill pending-and-enabled true interrupts for each target mode
        intState->ip[RISCV_MODE_M]  = ip & ~mideleg;
        intState->ip[RISCV_MODE_S]  = ip & (mideleg & ~(hideleg|sideleg));
        intState->ip[RISCV_MODE_U]  = ip & sideleg;
        intState->ip[RISCV_MODE_VS] = relocateVStoS(ip & hideleg);
    }

    if(Smaia(riscv)) {

        ////////////////////////////////////////////////////////////////////////
        // HANDLE AIA VS AND HS LEVEL VIRTUAL INTERRUPTS PENDED USING MVIP/HVIP
        ////////////////////////////////////////////////////////////////////////

        // add to pending S-mode and VS-mode interrupts
        ip |= (intState->ip[RISCV_MODE_S]  |= getPendingEnabledVirtualHS(riscv));
        ip |= (intState->ip[RISCV_MODE_VS] |= getPendingEnabledVirtualVS(riscv));

        ////////////////////////////////////////////////////////////////////////
        // HANDLE AIA VS LEVEL INTERRUPTS INJECTED USING HVICTL
        ////////////////////////////////////////////////////////////////////////

        Uns32 seiid = exceptionToInt(riscv_E_SExternalInterrupt);
        Uns32 IID   = RD_CSR_FIELDC(riscv, hvictl, IID);
        Uns32 VTI   = RD_CSR_FIELDC(riscv, hvictl, VTI);

        // vstopi case 5 is not signalled by pending bits but is directly
        // injected using hvictl
        ip |= (intState->hvictl = (VTI && (IID!=seiid)));
    }

    // do custom interrupt assignment if required
    ITER_EXT_CB(
        riscv, extCB, customIAssign,
        ip = extCB->customIAssign(riscv, ip, intState, extCB->clientData);
    )

    return ip;
}

//
// Return an indication of whether any CLIC mode interrupt is pending and
// locally enabled and would cause resumption from WFI (note that these could
// however be masked by global interrupt enable or delegation bits - see the
// Privileged Architecture specification)
//
inline static Bool getPendingLocallyEnabledCLIC(riscvP riscv) {
    return riscv->netValue.enableCLIC && (riscv->clic.sel.id!=RV_NO_INT);
}

//
// Structure representing composed interrupt priority value
//
typedef union fullPriU {

    Int64 full;

    struct {
        Int32 tiebreak : 16;
        Uns32 minor    : 16;
        Int32 major    : 32;
    } parts;

} fullPri;

//
// Structure representing composed interrupt priority value
//
typedef union xtopiU {

    Uns32 full;

    struct {
        Uns32 IPRIO :  8;
        Uns32 _u1   :  8;
        Uns32 IID   : 12;
        Uns32 _u2   :  4;
    } parts;

} xtopi;

//
// Return M-mode raw priority for interrupt
//
static Uns32 getMIPRIORaw(riscvP riscv, Uns32 id) {

    if(id!=exceptionToInt(riscv_E_MExternalInterrupt)) {
        return riscv->aia->miprio[id];
    } else {
        return riscv->aia->meiprio;
    }
}

//
// Return S-mode raw priority for interrupt
//
static Uns32 getSIPRIORaw(riscvP riscv, Uns32 id) {

    if(id!=exceptionToInt(riscv_E_SExternalInterrupt)) {
        return riscv->aia->siprio[id];
    } else {
        return riscv->aia->seiprio;
    }
}

//
// Return VS-mode raw priority for interrupt
//
static Uns32 getVSIPRIORaw(riscvP riscv, Uns32 id) {
    return riscv->aia->vsiprio[id];
}

//
// Invert raw xiprio
//
inline static Uns16 xiprioInvert(Uns16 xiprio) {
    return 0xffff-xiprio;
}

//
// Return full interrupt priority
//
static Int64 getIntPriBasicID(
    Int64                  basePri,
    Uns32                  xiprio,
    riscvExceptionPriority major
) {
    Int32 tiebreak = basePri - riscv_E_MinPriority;

    // compose full priority value, inverting sense of xiprio (higher numbers
    // imply higher priority in this format)
    fullPri pri = {
        parts : {
            major    : major,
            minor    : xiprioInvert(xiprio),
            tiebreak : tiebreak
        }
    };

    // return priority
    return pri.full;
}

//
// Get default priority for the indexed interrupt in basic mode
//
static Int64 getDefaultPriBasic(riscvP riscv, Uns32 id) {

    Int64 result = 0;

    // get any defined custom interrupt priority
    ITER_EXT_CB_WHILE(
        riscv, extCB, getInterruptPri, !result,
        result = extCB->getInterruptPri(riscv, id, extCB->clientData);
    )

    if(result) {

        // use custom priority

    } else if(!Smaia(riscv) && (id>=riscv_E_Local)) {

        // if Smaia is absent and custom priority is not defined, use priority
        // higher than all standard interrupts, increasing with interrupt number
        result = riscv_E_LocalPriority+id-riscv_E_Local;

    } else {

        // get standard interrupt priority
        result = (id<64) ? intPri[id] : riscv_E_LocalPriority+id-riscv_E_Local;
    }

    return result;
}

//
// Get priority for the indexed interrupt in basic mode (intNum<=63)
//
static Int64 getIntPriBasic(riscvP riscv, riscvPendEnab this) {
    
    Uns32 id     = this.id;
    Int64 result = getDefaultPriBasic(riscv, id);

    // handle Smaia priority adjustment
    if(Smaia(riscv)) {

        riscvExceptionPriority major;
        Uns16                  xiprio;

        if(this.priv==RISCV_MODE_M) {

            // interrupt targets M-mode
            major  = riscv_E_MExternalPriority;
            xiprio = getMIPRIORaw(riscv, id);

        } else if(this.priv==RISCV_MODE_S) {

            // interrupt targets S-mode
            major  = riscv_E_SExternalPriority;
            xiprio = getSIPRIORaw(riscv, id);

        } else {

            // interrupt targets VS-mode
            major  = riscv_E_SExternalPriority;
            xiprio = getVSIPRIORaw(riscv, id);
        }

        result = getIntPriBasicID(result, xiprio, xiprio ? major : result);
    }

    return result;
}

//
// Return riscvPendEnab structure representing no interrupt
//
inline static riscvPendEnab noInt(void) {
    return (riscvPendEnab){id : RV_NO_INT};
}

//
// Return the highest-priority pending and enabled interrupt from the given
// set of enabled interrupts for the given mode
//
static Int64 getHighestPriorityBasicMode(
    riscvP              riscv,
    riscvPendEnabP      result,
    riscvBasicIntStateP intState,
    riscvMode           priv
) {
    riscvPendEnab try       = {priv:priv};
    Int64         selIntPri = RV_NO_PRI;
    Uns64         ip        = intState->ip[priv];

    while(ip) {

        if(ip&1) {

            // get relative priority of candidate interrupt
            Int64 tryIntPri = getIntPriBasic(riscv, try);

            // select if highest-priority
            if(selIntPri<=tryIntPri) {
                *result   = try;
                selIntPri = tryIntPri;
            }
        }

        // step to next potential pending-and-enabled interrupt
        ip >>= 1;
        try.id++;
    }

    // return selected interrupt priority or zero if no match
    return selIntPri!=RV_NO_PRI ? selIntPri : 0;
}

//
// Return the highest-priority pending and enabled interrupt from the given
// set of enabled interrupts targeting VS mode
//
static Int64 getHighestPriorityBasicVSInt(
    riscvP              riscv,
    riscvPendEnabP      result,
    riscvBasicIntStateP intState
) {
    Uns32         seiid     = exceptionToInt(riscv_E_SExternalInterrupt);
    Uns64         seiMask   = (1<<seiid);
    Int64         seiDefPri = riscv_E_SExternalPriority;
    Uns32         VGEIN     = RD_CSR_FIELDC(riscv, hstatus, VGEIN);
    Uns32         IID       = RD_CSR_FIELDC(riscv, hvictl, IID);
    Uns32         IPRIO     = RD_CSR_FIELDC(riscv, hvictl, IPRIO);
    riscvPendEnab try123    = {priv:RISCV_MODE_VS, id:seiid};
    Int64         pri123    = 0;
    Int64         pri45     = 0;

    // determine effective supervisor external interrupt priority for exclusive
    // cases 1 to 3
    if(intState->ip[RISCV_MODE_VS] & seiMask) {

        // case 3 default value
        Uns32 vsiprio = 256;

        if(!VGEIN) {
            // use case 3 default value
        } else if(riscv->aia->vseiprio) {
            vsiprio = riscv->aia->vseiprio;
        } else if((IID!=seiid) && IPRIO) {
            vsiprio = IPRIO;
        }

        // determine full supervisor external interrupt priority for exclusive
        // cases 1 to 3
        pri123 = getIntPriBasicID(seiDefPri, vsiprio, seiDefPri);
    }

    // determine full interrupt priority for exclusive cases 4 and 5
    if(!RD_CSR_FIELDC(riscv, hvictl, VTI)) {

        // ignore supervisor external interrupt in case 4
        intState->ip[RISCV_MODE_VS] &= ~seiMask;

        // select remaining interrupt of highest priority
        pri45 = getHighestPriorityBasicMode(
            riscv, result, intState, RISCV_MODE_VS
        );

    } else if(IID!=seiid) {

        // case 5 - get default priority relative to SEI
        Int32 adjust = RD_CSR_FIELDC(riscv, hvictl, DPR) ? -1 : 1;
        Int64 defPri = seiDefPri + adjust;

        pri45 = getIntPriBasicID(defPri, IPRIO, seiDefPri);

        result->priv = RISCV_MODE_VS;
        result->id   = IID;
    }

    // select highest priority interrupt from the two exclusive groups
    if(pri123 && (!pri45 || (pri123>pri45))) {
        *result = try123;
        pri45   = pri123;
    }

    // return selected interrupt priority
    return pri45;
}

//
// Return the highest-priority pending and enabled interrupt from the given
// set of enabled interrupts targeting VS mode
//
static Int64 getHighestPriorityBasicVS(
    riscvP              riscv,
    riscvPendEnabP      result,
    riscvBasicIntStateP intState
) {
    riscvMode mode   = RISCV_MODE_VS;
    Int64     intPri = 0;

    if(!Smaia(riscv)) {
        intPri = getHighestPriorityBasicMode(riscv, result, intState, mode);
    } else if(inVMode(riscv)) {
        intPri = getHighestPriorityBasicVSInt(riscv, result, intState);
    }

    return intPri;
}

//
// Return the highest-priority pending and enabled interrupt from the given
// set of enabled interrupts
//
static void getHighestPriorityBasic(
    riscvP              riscv,
    riscvPendEnabP      result,
    riscvBasicIntStateP intState
) {
    if(
        getHighestPriorityBasicMode(riscv, result, intState, RISCV_MODE_M ) ||
        getHighestPriorityBasicMode(riscv, result, intState, RISCV_MODE_S ) ||
        getHighestPriorityBasicMode(riscv, result, intState, RISCV_MODE_U ) ||
        getHighestPriorityBasicVS  (riscv, result, intState               ) ||
        getHighestPriorityBasicMode(riscv, result, intState, RISCV_MODE_VU)
    ) {}
}

//
// Return highest priority interrupt from the set specified by mask in xtopi
// format
//
static Uns32 getXTOPIInt(
    riscvP                 riscv,
    riscvMode              mode,
    riscvExceptionPriority xeiPri,
    Bool                   ipriom
) {
    xtopi              result = {0};
    riscvPendEnab      hpInt  = noInt();
    riscvBasicIntState intState;
    Int64              intPri;

    getPendingLocallyEnabledBasic(riscv, &intState);

    // get highest-priority pending-and-enabled interrupt and its priority
    if(mode==RISCV_MODE_VS) {
        intPri = getHighestPriorityBasicVSInt(riscv, &hpInt, &intState);
    } else {
        intPri = getHighestPriorityBasicMode(riscv, &hpInt, &intState, mode);
    }

    if(intPri) {

        fullPri pri    = {full : intPri};
        Uns16   xiprio = xiprioInvert(pri.parts.minor);
        Int32   defPri = pri.parts.tiebreak + riscv_E_MinPriority;

        // adjust reported priority for low-priority interrupts
        if((xiprio>255) || (!xiprio && (defPri<xeiPri))) {
            xiprio = 255;
        }

        // fill result
        result.parts.IID   = hpInt.id;
        result.parts.IPRIO = ipriom ? xiprio : 1;
    }

    return result.full;
}

//
// Return the computed value of mtopi
//
Uns32 riscvGetMTOPI(riscvP riscv) {
    return getXTOPIInt(riscv, RISCV_MODE_M, riscv_E_MExternalPriority, True);
}

//
// Return the computed value of stopi
//
Uns32 riscvGetSTOPI(riscvP riscv) {
    return getXTOPIInt(riscv, RISCV_MODE_S, riscv_E_SExternalPriority, True);
}

//
// Return the computed value of vstopi
//
Uns32 riscvGetVSTOPI(riscvP riscv) {
    Bool ipriom = RD_CSR_FIELDC(riscv, hvictl, IPRIOM);
    return getXTOPIInt(riscv, RISCV_MODE_VS, riscv_E_SExternalPriority, ipriom);
}

//
// Emit debug of interrupt state change if required
//
static void debugIntState(riscvP riscv, riscvBasicIntStateP intState) {

    // short mode names
    static const char *modeNames[RISCV_MODE_LAST] = {
        [RISCV_MODE_M]  = "M",
        [RISCV_MODE_S]  = "S",
        [RISCV_MODE_U]  = "U",
        [RISCV_MODE_VS] = "VS",
        [RISCV_MODE_VU] = "VU"
    };

    if(
        memcmp(&riscv->intState.ip, &intState->ip, sizeof(intState->ip)) ||
        (riscv->intState.hvictl != intState->hvictl)
    ) {
        octStringVarP sv = oclSVnew();
        riscvMode     mode;

        // report changed interrupt state visible in pending bits
        for(mode=0; mode<RISCV_MODE_LAST; mode++) {
            if(riscv->intState.ip[mode] != intState->ip[mode]) {
                oclSVprintf(
                    sv,
                    " %sIP:"FMT_A08x"->"FMT_A08x,
                    modeNames[mode],
                    riscv->intState.ip[mode],
                    intState->ip[mode]
                );
            }
        }

        // report changed interrupt state visible in hvictl
        if(riscv->intState.hvictl != intState->hvictl) {
            oclSVprintf(
                sv,
                " hvictl[%u]->hvictl[%u]",
                riscv->intState.hvictl,
                intState->hvictl
            );
        }

        // emit message
        vmiMessage("I", CPU_PREFIX "_IS",
            SRCREF_FMT"%s",
            SRCREF_ARGS(riscv, getPC(riscv)),
            oclSVstring(sv)
        );

        // track previous pending state
        riscv->intState = *intState;
    }
}

//
// Refresh pending basic interrupt state
//
static void refreshPendingAndEnabledBasic(riscvP riscv) {

    Bool               pendingEnabled = False;
    riscvBasicIntState intState;
    riscvMode          mode;
    
    // apply interrupt masks to pending and enabled interrupts
    if(getPendingLocallyEnabledBasic(riscv, &intState)) {

        // get raw interrupt enable bits
        Bool MIE  = RD_CSR_FIELDC(riscv, mstatus,  MIE);
        Bool HSIE = RD_CSR_FIELDC(riscv, mstatus,  SIE);
        Bool HUIE = RD_CSR_FIELDC(riscv, mstatus,  UIE);
        Bool VSIE = RD_CSR_FIELDC(riscv, vsstatus, SIE);
        Bool VUIE = RD_CSR_FIELDC(riscv, vsstatus, UIE);

        // get interrupt mask applicable for each mode for true interrupts
        Bool ie[RISCV_MODE_LAST] = {
            [RISCV_MODE_M]  = getIE(riscv, MIE,  RISCV_MODE_M,  useCLICM(riscv)),
            [RISCV_MODE_S]  = getIE(riscv, HSIE, RISCV_MODE_S,  useCLICS(riscv)),
            [RISCV_MODE_U]  = getIE(riscv, HUIE, RISCV_MODE_U,  useCLICU(riscv)),
            [RISCV_MODE_VS] = getIE(riscv, VSIE, RISCV_MODE_VS, useCLICVS(riscv)),
            [RISCV_MODE_VU] = getIE(riscv, VUIE, RISCV_MODE_VU, useCLICVU(riscv))
        };

        // handle masked interrupt modes
        for(mode=0; mode<RISCV_MODE_LAST; mode++) {
            if(!ie[mode]) {
                intState.ip[mode] = 0;
            } else if(intState.ip[mode]) {
                pendingEnabled = True;
            }
        }

        // if VS-mode interrupts are masked then hvictl-pended interrupts are
        // disabled
        if(!ie[RISCV_MODE_VS]) {
            intState.hvictl = False;
        } else if(intState.hvictl) {
            pendingEnabled = True;
        }
    }

    // debug interrupt state change if required
    if(RISCV_DEBUG_EXCEPT(riscv)) {
        debugIntState(riscv, &intState);
    }

    // select highest-priority pending-and-enabled interrupt
    if(pendingEnabled) {
        getHighestPriorityBasic(riscv, &riscv->pendEnab, &intState);
    }
}

//
// Should CLIC interrupt of the given privilege level be presented?
//
#define PRESENT_INT_CLIC(_P, _X, _x, _LEVEL, _MODE) ( \
    useCLIC##_X(hart)                 &&                        \
    RD_CSR_FIELDC(_P, mstatus, _X##IE) &&                       \
    (                                                           \
        (_MODE < RISCV_MODE_##_X) ||                            \
        (                                                       \
            (_LEVEL > RD_CSR_FIELDC(_P, mintstatus, _x##il)) && \
            (_LEVEL > RD_CSR_FIELDC(_P, _x##intthresh, th))     \
        )                                                       \
    )                                                           \
)

//
// Refresh pending CLIC interrupt when state changes
//
static void refreshPendingAndEnabledCLIC(riscvP hart) {

    // refresh state when CLIC is internally implemented
    if(CLICInternal(hart)) {
        riscvRefreshPendingAndEnabledInternalCLIC(hart);
    }

    // handle highest-priority locally enabled interrupt
    if(getPendingLocallyEnabledCLIC(hart)) {

        Int32     id     = hart->clic.sel.id;
        riscvMode priv   = hart->clic.sel.priv;
        Uns8      level  = hart->clic.sel.level;
        Bool      enable = False;
        riscvMode mode   = getCurrentMode3(hart);

        // determine whether presented interrupt is enabled
        if(hart->pendEnab.priv>priv) {
            // basic mode interrupt is higher priority
        } else if(mode>priv) {
            // execution priority is higher than interrupt priority
        } else if(priv==RISCV_MODE_M) {
            enable = PRESENT_INT_CLIC(hart, M, m, level, mode);
        } else if(priv==RISCV_MODE_S) {
            enable = PRESENT_INT_CLIC(hart, S, s, level, mode);
        } else if(priv==RISCV_MODE_U) {
            enable = PRESENT_INT_CLIC(hart, U, u, level, mode);
        } else {
            VMI_ABORT("unimplemented case"); // LCOV_EXCL_LINE
        }

        // update pending and enabled interrupt if required
        if(enable) {
            hart->pendEnab.id     = id;
            hart->pendEnab.priv   = priv;
            hart->pendEnab.level  = level;
            hart->pendEnab.isCLIC = True;
        }
    }

    // print exception status
    if(RISCV_DEBUG_EXCEPT(hart)) {

        // report only if interrupt state changes
        if(memcmp(&hart->clicState, &hart->clic.sel, sizeof(hart->clicState))) {

            vmiMessage("I", CPU_PREFIX "_ISC",
                SRCREF_FMT
                "CLIC ID:%d MODE:%u LEVEL:%u SHV:%u",
                SRCREF_ARGS(hart, getPC(hart)),
                hart->clic.sel.id,
                hart->clic.sel.priv,
                hart->clic.sel.level,
                hart->clic.sel.shv
            );

            // track previous pending state
            hart->clicState = hart->clic.sel;
        }
    }
}

//
// Refresh pending-and-enabled interrupt state
//
void riscvRefreshPendingAndEnabled(riscvP riscv) {

    // reset pending and enabled interrupt details
    riscv->pendEnab = noInt();

    // get highest-priority basic-mode pending interrupt
    if(basicICPresent(riscv)) {
        refreshPendingAndEnabledBasic(riscv);
    }

    // get highest-priority CLIC-mode pending interrupt
    if(CLICPresent(riscv)) {
        refreshPendingAndEnabledCLIC(riscv);
    }
}

//
// Are interrupts disabled in a debug instruction step?
//
inline static Bool interruptStepDisable(riscvP riscv) {
    return RD_CSR_FIELDC(riscv, dcsr, step) && !RD_CSR_FIELDC(riscv, dcsr, stepie);
}

//
// Return an indication of whether resethaltreq is pending to enter debug Mode
//
static Bool getPendingAndEnabledResethaltreq(riscvP riscv) {
    return (
        riscv->netValue.resethaltreqS &&
        !riscv->netValue.deferint
    );
}

//
// Return an indication of whether haltreq is pending to enter debug Mode
//
static Bool getPendingAndEnabledHaltreq(riscvP riscv) {
    return (
        riscv->netValue.haltreq &&
        !inDebugMode(riscv) &&
        !riscv->netValue.deferint
    );
}

//
// Return an indication of whether NMI is pending and enabled
//
static Bool getPendingAndEnabledNMI(riscvP riscv) {
    return (
        RD_CSR_FIELDC(riscv, dcsr, nmip) &&
        !inDebugMode(riscv) &&
        RD_CSR_FIELDC(riscv, mnstatus, NMIE) &&
        !riscv->netValue.deferint
    );
}

//
// Return an indication of whether there are any pending-and-enabled interrupts
// without refreshing state
//
static Bool getPendingAndEnabled(riscvP riscv) {
    return (
        (riscv->pendEnab.id!=RV_NO_INT) &&
        !inDebugMode(riscv) &&
        !interruptStepDisable(riscv) &&
        RD_CSR_FIELDC(riscv, mnstatus, NMIE) &&
        !riscv->netValue.deferint
    );
}

//
// Process highest-priority interrupt in the given mask of pending-and-enabled
// interrupts
//
static void doInterrupt(riscvP riscv) {

    // get the highest-priority interrupt and unregister it
    Uns32 id = riscv->pendEnab.id;
    riscv->pendEnab.id = RV_NO_INT;

    // sanity check there are pending-and-enabled interrupts
    VMI_ASSERT(id!=RV_NO_INT, "expected pending-and-enabled interrupt");

    // take the interrupt
    riscvTakeException(riscv, intToException(id), 0);
}

//
// Forward reference
//
static void doNMI(riscvP riscv);

//
// Do actions to handle pending haltreq or resethaltreq
//
static Bool doHaltReq(riscvP riscv, Bool complete) {

    Bool didHaltReq = False;

    if(getPendingAndEnabledResethaltreq(riscv)) {

        // enter Debug mode out of reset
        if(complete) {
            Bool no_resethaltreq = riscv->configInfo.no_resethaltreq;
            riscv->netValue.resethaltreqS = False;
            enterDM(riscv, no_resethaltreq ? DMC_HALTREQ : DMC_RESETHALTREQ);
        }

        didHaltReq = True;

    } else if(getPendingAndEnabledHaltreq(riscv)) {

        // enter Debug mode
        if(complete) {
            enterDM(riscv, DMC_HALTREQ);
        }

        didHaltReq = True;
    }

    return didHaltReq;
}

//
// This is called by the simulator when fetching from an instruction address.
// It gives the model an opportunity to take an exception instead.
//
VMI_IFETCH_FN(riscvIFetchExcept) {

    riscvP         riscv    = (riscvP)processor;
    Uns64          thisPC   = address;
    Bool           fetchOK  = False;
    Bool           triggerX = riscv->currentArch & ISA_TM_X;
    riscvDPriority priority = riscv->configInfo.debug_priority;
    Bool           H_A      = (priority==RVDP_H_A_S_X);
    Bool           H_S      = (priority==RVDP_A_H_S_X);
    Bool           X_H      = (priority==RVDP_A_S_X_H);

    // set indication of exception during fetch
    riscv->isFetch = True;

    ////////////////////////////////////////////////////////////////////////////
    // actions *after* preceding instruction
    ////////////////////////////////////////////////////////////////////////////

    if(H_A && doHaltReq(riscv, complete)) {

        // enter Debug mode on haltreq or resethaltreq

    } else if(riscvTriggerAfter(riscv, complete, True)) {

        // debug trigger after preceding instruction

    } else if(H_S && doHaltReq(riscv, complete)) {

        // enter Debug mode on haltreq or resethaltreq

    } else if(riscv->netValue.stepreq) {

        // handle pending step
        if(complete) {
            enterDM(riscv, DMC_STEP);
        }

    ////////////////////////////////////////////////////////////////////////////
    // actions *before* next instruction
    ////////////////////////////////////////////////////////////////////////////

    } else if(X_H && complete && triggerX && riscvTriggerX0(riscv, thisPC)) {

        // if in "original" debug priority mode (RVDP_S_X_H), execute address
        // trap (priority 4, handled in riscvTriggerX0 only if a lower-priority
        // case below would otherwise cause an exception - normally, this is
        // handled by a call to riscvTriggerX2 or riscvTriggerX4 just before the
        // instruction is executed)

    } else if(!H_A && !H_S && doHaltReq(riscv, complete)) {

        // enter Debug mode on haltreq or resethaltreq

    } else if(riscvTriggerAfter(riscv, complete, False)) {

        // breakpoint trigger after preceding instruction (lower priority than
        // all debug events)

    } else if(getPendingAndEnabledNMI(riscv)) {

        // handle pending NMI
        if(complete) {
            doNMI(riscv);
        }

    } else if(getPendingAndEnabled(riscv)) {

        // handle pending interrupt
        if(complete) {
            doInterrupt(riscv);
        }

    } else if(!validateFetchAddress(riscv, domain, thisPC, complete)) {

        // fetch exception (handled in validateFetchAddress)

    } else {

        // no exception pending
        fetchOK = True;
    }

    // clear indication of exception during fetch
    riscv->isFetch = False;

    if(fetchOK) {

        return VMI_FETCH_NONE;

    } else if(complete) {

        // handle deferring step breakpoint for one instruction when an
        // interrupt is triggered if required (debug module hardware bug)
        if(riscv->configInfo.defer_step_bug) {
            riscvSetStepBreakpoint(riscv);
        }

        return VMI_FETCH_EXCEPTION_COMPLETE;

    } else {

        return VMI_FETCH_EXCEPTION_PENDING;
    }
}

//
// Does the processor implement the standard exception or interrupt?
//
Bool riscvHasStandardException(riscvP riscv, riscvException code) {

    if(code==riscv_E_GenericNMI) {
        return !riscv->configInfo.ecode_nmi;
    } else if((code==riscv_E_CSIP) && useCSIP12(riscv)) {
        return True;
    } else if(!isInterrupt(code)) {
        return riscv->exceptionMask & (1ULL<<code);
    } else if(exceptionToInt(code)>=64) {
        return True;
    } else {
        Uns64 unimp_int_mask = riscv->configInfo.unimp_int_mask;
        Uns64 interruptMask  = riscv->interruptMask & ~unimp_int_mask;
        return interruptMask & (1ULL<<exceptionToInt(code));
    }
}

//
// Get effective architecture for determining presence of exceptions
//
static riscvArchitecture getExceptionArch(riscvP riscv) {

    riscvArchitecture arch = riscv->configInfo.arch;

    // determine whether misaligned access exceptions are possible
    if(
        (!riscv->configInfo.unaligned) ||
        (!riscv->configInfo.unalignedAMO && (arch&ISA_A)) ||
        (!riscv->configInfo.unalignedV   && (arch&ISA_V))
    ) {
        arch |= ISA_UX;
    }

    return arch;
}

//
// Does the processor implement the standard exception or interrupt given its
// architecture?
//
static Bool hasStandardExceptionArch(riscvP riscv, riscvExceptionDescCP desc) {

    return (
        // validate feature requirements
        ((getExceptionArch(riscv)&desc->arch)==desc->arch) &&
        // validate trap code
        riscvHasStandardException(riscv, desc->vmiInfo.code)
    );
}

//
// Return total number of interrupts (including 0 to 15)
//
Uns32 riscvGetIntNum(riscvP riscv) {
    return riscv->configInfo.local_int_num+riscv_E_Local;
}

//
// Is the RISC-V object a Hart (not a container)
//
inline static Bool isHart(riscvP riscv) {
    return !vmirtGetSMPChild((vmiProcessorP)riscv);
}

//
// Return number of local interrupts
//
inline static Uns32 getLocalIntNum(riscvP riscv) {
    return isHart(riscv) ? riscv->configInfo.local_int_num : 0;
}

//
// Return number of guest external interrupts
//
inline static Uns32 getGuestExternalIntNum(riscvP riscv) {
    return isHart(riscv) ? getGEILEN(riscv) : 0;
}

//
// Callback used to sort exceptions in code order (or alphabetically if codes
// are equal)
//
static Int32 compareExceptionCode(const void *va, const void *vb) {

    vmiExceptionInfoCP a     = va;
    vmiExceptionInfoCP b     = vb;
    Uns32              aCode = a->code;
    Uns32              bCode = b->code;

    return (aCode<bCode) ? -1 : (aCode>bCode) ? 1 : strcmp(a->name, b->name);
}

//
// Clone strings in the exception structure
//
static void cloneExceptionStrings(vmiExceptionInfoP this) {

    if(this->name) {
        this->name = strdup(this->name);
    }
    if(this->description) {
        this->description = strdup(this->description);
    }
}

//
// Free strings in the exception structure
//
static void freeExceptionStrings(vmiExceptionInfoCP this) {

    if(this->name) {
        free((char*)this->name);
    }
    if(this->description) {
        free((char*)this->description);
    }
}

//
// Return all defined exceptions, including those from intercepts, in a null
// terminated list
//
static vmiExceptionInfoCP getExceptions(riscvP riscv) {

    if(!riscv->exceptions) {

        Uns32 localIntNum = getLocalIntNum(riscv);
        Uns32 numExcept;
        Uns32 i;

        // get number of exceptions and standard interrupts in the base model
        for(i=0, numExcept=0; exceptions[i].vmiInfo.name; i++) {
            if(hasStandardExceptionArch(riscv, &exceptions[i])) {
                numExcept++;
            }
        }

        // include exceptions for derived model
        ITER_EXT_CB(
            riscv, extCB, firstException,
            {
                vmiExceptionInfoCP list = extCB->firstException(
                    riscv, extCB->clientData
                );
                while(list && list->name) {
                    numExcept++; list++;
                }
            }
        )

        // count local interrupts
        for(i=0; i<localIntNum; i++) {
            if(riscvHasStandardException(riscv, riscv_E_LocalInterrupt+i)) {
                numExcept++;
            }
        }

        // allocate list of exceptions including null terminator
        vmiExceptionInfoP all = STYPE_CALLOC_N(vmiExceptionInfo, numExcept+1);

        // fill exceptions and standard interrupts from base model
        for(i=0, numExcept=0; exceptions[i].vmiInfo.name; i++) {
            if(hasStandardExceptionArch(riscv, &exceptions[i])) {
                all[numExcept++] = exceptions[i].vmiInfo;
            }
        }

        // fill exceptions from derived model
        ITER_EXT_CB(
            riscv, extCB, firstException,
            {
                vmiExceptionInfoCP list = extCB->firstException(
                    riscv, extCB->clientData
                );
                while(list && list->name) {
                    if(list->code<64) {
                        riscv->exceptionMask |= (1ULL<<list->code);
                    }
                    all[numExcept++] = *list++;
                }
            }
        )

        // clone all strings in exception structures
        for(i=0; i<numExcept; i++) {
            cloneExceptionStrings(&all[i]);
        }

        // fill local interrupts
        for(i=0; i<localIntNum; i++) {

            riscvException code = riscv_E_LocalInterrupt+i;

            if(riscvHasStandardException(riscv, code)) {

                vmiExceptionInfoP this = &all[numExcept++];
                char              name[64];
                char              desc[64];

                if(i || !useCSIP16(riscv)) {

                    // construct name
                    sprintf(name, "LocalInterrupt%u", i);

                    // construct description
                    getInterruptDesc(code, desc);

                } else {

                    // construct name
                    strcpy(name, "CSIP");

                    // construct description
                    strcpy(desc, "CLIC software interrupt");
                }

                this->code        = code;
                this->name        = name;
                this->description = desc;

                // clone strings in exception structure
                cloneExceptionStrings(this);
            }
        }

        // sort exceptions by increasing code
        qsort(all, numExcept, sizeof(all[0]), compareExceptionCode);

        // save list on base model
        riscv->exceptions = all;
    }

    return riscv->exceptions;
}

//
// Get last-activated exception
//
VMI_GET_EXCEPTION_FN(riscvGetException) {

    riscvP             riscv     = (riscvP)processor;
    vmiExceptionInfoCP this      = getExceptions(riscv);
    riscvException     exception = riscv->exception;

    // get the first exception with matching code
    while(this->name && (this->code!=exception)) {
        this++;
    }

    return this->name ? this : 0;
}

//
// Iterate exceptions implemented on this variant
//
VMI_EXCEPTION_INFO_FN(riscvExceptionInfo) {

    riscvP             riscv = (riscvP)processor;
    vmiExceptionInfoCP this  = prev ? prev+1 : getExceptions(riscv);

    return this->name && isHart(riscv) ? this : 0;
}

//
// Return mask of implemented local interrupts
//
static Uns64 getLocalIntMask(riscvP riscv) {

    Uns32 localIntNum    = getLocalIntNum(riscv);
    Uns32 localShift     = (localIntNum<48) ? localIntNum : 48;
    Uns64 local_int_mask = (1ULL<<localShift)-1;

    return local_int_mask << riscv_E_Local;
}

//
// Initialize mask of implemented exceptions
//
void riscvSetExceptionMask(riscvP riscv) {

    riscvArchitecture    arch          = getExceptionArch(riscv);
    Uns64                exceptionMask = 0;
    Uns64                interruptMask = 0;
    riscvExceptionDescCP thisDesc;

    // get exceptions and standard interrupts supported on the current
    // architecture
    for(thisDesc=exceptions; thisDesc->vmiInfo.name; thisDesc++) {

        riscvException    code     = thisDesc->vmiInfo.code;
        riscvArchitecture required = thisDesc->arch;

        if((arch&required)!=required) {
            // not implemented by this variant
        } else if(code==riscv_E_GenericNMI) {
            // ignore generic NMI
        } else if((code==riscv_E_SGEIInterrupt) && !getGEILEN(riscv)) {
            // absent if GEILEN=0
        } else if((code==riscv_E_CSIP) && useCSIP12(riscv)) {
            // never present in interrupt mask
        } else if(!isInterrupt(code)) {
            exceptionMask |= 1ULL<<code;
        } else {
            interruptMask |= 1ULL<<exceptionToInt(code);
        }
    }

    // save composed exception mask result
    riscv->exceptionMask = exceptionMask;

    // save composed interrupt mask result (including extra local interrupts
    // and excluding interrupts that are explicitly absent)
    riscv->interruptMask = (
        (interruptMask | getLocalIntMask(riscv)) &
        ~riscv->configInfo.unimp_int_mask
    );
}

//
// Free exception state
//
void riscvExceptFree(riscvP riscv) {

    if(riscv->exceptions) {

        vmiExceptionInfoCP this = riscv->exceptions;

        // free exception description strings
        while(this->name) {
            freeExceptionStrings(this);
            this++;
        }

        // free exception descriptions
        STYPE_FREE(riscv->exceptions);
        riscv->exceptions = 0;
    }
}


////////////////////////////////////////////////////////////////////////////////
// EXTERNAL INTERRUPT UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Detect rising edge
//
inline static Bool posedge(Bool old, Bool new) {
    return !old && new;
}

//
// Detect falling edge
//
inline static Bool negedge(Uns32 old, Uns32 new) {
    return old && !new;
}

//
// Is resume from WFI required?
//
Bool riscvResumeFromWFI(riscvP riscv) {

    riscvBasicIntState intState;

    return (
        riscv->netValue.restartwfi                      ||
        getPendingLocallyEnabledBasic(riscv, &intState) ||
        getPendingLocallyEnabledCLIC(riscv)             ||
        inDebugMode(riscv)                              ||
        RD_CSR_FIELDC(riscv, dcsr, step)
    );
}

//
// Return the type of trap resulting from WFI timeout or illegal operation
//
static riscvException getWFITrap(riscvP riscv, Bool isWRS) {

    riscvMode      mode = getCurrentMode5(riscv);
    riscvException trap = 0;

    if(mode==RISCV_MODE_M) {

        // no trap in M-mode

    } else if(RD_CSR_FIELDC(riscv, mstatus, TW)) {

        // take Illegal Instruction trap when mstatus.TW=1
        trap = riscv_E_IllegalInstruction;

    } else if(modeIsVirtual(mode) && RD_CSR_FIELDC(riscv, hstatus, VTW)) {

        // take Virtual Instruction trap in virtual mode when hstatus.VTW=1
        trap = riscv_E_VirtualInstruction;

    } else if((mode!=RISCV_MODE_U) && (mode!=RISCV_MODE_VU)) {

        // no trap possible unless in U-mode or VU-mode

    } else if(isWRS) {

        // U-mode does not trap when governing TW bit is zero for WRS.NTO

    } else if(!(riscv->currentArch & ISA_S)) {

        // no trap possible if S-mode is absent or disabled

    } else if(riscv->currentArch & ISA_N) {

        // no trap possible if N extension is enabled

    } else if(mode==RISCV_MODE_VU) {

        // take Virtual Instruction trap in VU-mode
        trap = riscv_E_VirtualInstruction;

    } else {

        // take Illegal Instruction trap in U-mode
        trap = riscv_E_IllegalInstruction;
    }

    return trap;
}

//
// Take trap because of bounded time limit timeout
//
static void takeBLimitTrap(riscvP riscv, riscvException trap) {
    takeInstructionExceptionMessage(riscv, trap, "bounded time limit exceeded");
}

//
// Handle trap if waiting in wfi or wrs.nto because of bounded time limit
//
static Bool handleBLimitTrap(riscvP riscv) {

    riscvException trap = 0;

    if((riscv->disable&RVD_WFI) && (trap=getWFITrap(riscv, False))) {
        setPC(riscv, riscv->jumpBase);
        riscvRestart(riscv, RVD_RESTART_WFI);
        takeBLimitTrap(riscv, trap);
    }

    return trap;
}

//
// Function called on expiry of bounded time limit controlled by mstatus.TW or
// hstatus.VTW
//
static VMI_ICOUNT_FN(expiredTW) {

    riscvP riscv = (riscvP)processor;

    if(riscv->disable&RVD_STO) {

        // waiting in wrs.sto
        riscvRestart(riscv, RVD_RESTART_WFI);

    } else {

        // possibly waiting in wfi or wrs.nto
        handleBLimitTrap(riscv);
    }
}

//
// Return time limit for WFI or WRS instruction
//
inline static Uns32 getWFILimit(riscvP riscv, Bool isWRS) {

    Bool useLimit = isWRS || !riscv->configInfo.wfi_is_nop;

    return useLimit ? riscv->configInfo.TW_time_limit : 0;
}

//
// Immediately take or schedule WFI trap if required
//
static Bool scheduleWFITrap(riscvP riscv, Bool isWRS) {

    riscvException trap    = getWFITrap(riscv, isWRS);
    Uns32          limit   = getWFILimit(riscv, isWRS);
    Bool           trapNow = trap && !limit;

    if(trapNow) {
        takeBLimitTrap(riscv, trap);
    } else if(trap) {
        riscv->jumpBase = getPC(riscv);
        vmirtSetModelTimer(riscv->twTimer, limit);
    } else if(riscv->twTimer) {
        vmirtClearModelTimer(riscv->twTimer);
    }

    return trapNow;
}

//
// Stall the processor in WFI state if required
//
// NOTE: when time limit is zero, WFI should always be immediately trapped even
// if there is a pending locally enabled interrupt, but when the time limit is
// non-zero a pending locally enabled interrupt disables WFI altogether, even
// though this seems inconsistent
//
void riscvWFI(riscvP riscv) {

    // should pending wakeup event be higher priority than potential trap?
    Bool wfi_resume_not_trap = (
        riscv->configInfo.wfi_resume_not_trap ||
        getWFILimit(riscv, False)
    );

    if(wfi_resume_not_trap && riscvResumeFromWFI(riscv)) {
        // resume high priority: no action if pending locally enabled interrupts
    } else if(scheduleWFITrap(riscv, False)) {
        // no action if a WFI trap is immediately taken
    } else if(!wfi_resume_not_trap && riscvResumeFromWFI(riscv)) {
        // resume low priority: no action if pending locally enabled interrupts
    } else if(!riscv->configInfo.wfi_is_nop) {
        riscvHalt(riscv, RVD_WFI);
    }
}

//
// Stall the processor in WFI state while reservation set is valid if required
//
void riscvWRSNTO(riscvP riscv) {

    if(riscv->exclusiveTag==RISCV_NO_TAG) {
        // reservation set not valid
    } else if(riscvResumeFromWFI(riscv)) {
        // do not stall if there are pending locally enabled interrupts
    } else if(scheduleWFITrap(riscv, True)) {
        // no action if a WFI trap is immediately taken
    } else {
        riscvHalt(riscv, RVD_WFI|RVD_WRS);
    }
}

//
// Stall the processor in WFI state while reservation set is valid if required
//
void riscvWRSSTO(riscvP riscv) {

    if(riscv->exclusiveTag==RISCV_NO_TAG) {
        // reservation set not valid
    } else if(riscvResumeFromWFI(riscv)) {
        // do not stall if there are pending locally enabled interrupts
    } else {
        riscvHalt(riscv, RVD_WFI|RVD_WRS|RVD_STO);
        vmirtSetModelTimer(riscv->twTimer, riscv->configInfo.STO_time_limit);
    }
}

//
// Are there pending and enabled interupts?
//
Bool riscvPendingAndEnabled(riscvP riscv) {
    return (
        getPendingAndEnabledResethaltreq(riscv) ||
        getPendingAndEnabledHaltreq(riscv) ||
        getPendingAndEnabledNMI(riscv) ||
        getPendingAndEnabled(riscv)
    );
}

//
// Handle any pending and enabled interrupts
//
static Bool handlePendingAndEnabled(riscvP riscv) {

    Bool interruptNow = riscvPendingAndEnabled(riscv);

    if(interruptNow) {
        riscvRestart(riscv, RVD_RESTART_NMI);
        doSynchronousInterrupt(riscv);
    }

    return interruptNow;
}

//
// Check for pending interrupts
//
void riscvTestInterrupt(riscvP riscv) {

    // refresh pending and pending-and-enabled interrupt state
    riscvRefreshPendingAndEnabled(riscv);

    if(handlePendingAndEnabled(riscv)) {

        // interrupts will be serviced now

    } else if(riscv->disable & ~RVD_RESTART_WFI) {

        // stalled for a reason not subject to WFI restart control

    } else if(riscv->disable && riscvResumeFromWFI(riscv)) {

        // restart processor if it is halted in WFI state and interrupts are
        // locally pending and enabled but globally masked or delegated
        riscvRestart(riscv, RVD_RESTART_WFI);
    }
}

//
// Reset the processor
//
void riscvReset(riscvP riscv) {

    // notify dependent model of reset event (called before any state changes
    // in case current state is logged by the notifier)
    ITER_EXT_CB(
        riscv, extCB, resetNotifier,
        extCB->resetNotifier(riscv, extCB->clientData);
    )

    // enable interrupts that would be blocked by RNMI state if RNMI is absent,
    // otherwise disable those interrupts if RNMI version exceeds 0.2.1
    // (mnstatus.NMIE explicitly resets to 0 from that version, but otherwise
    // reset value is undefined)
    WR_CSR_FIELDC(riscv, mnstatus, NMIE, RISCV_RNMI_VERSION(riscv)<=RNMI_0_2_1);

    // restart the processor from any halted state
    riscvRestart(riscv, RVD_RESTART_RESET);

    // exit Debug mode
    riscvSetDM(riscv, False);

    // switch to Machine mode
    riscvSetMode(riscv, RISCV_MODE_M);

    // reset CSR state
    riscvCSRReset(riscv);

    // reset CLINT state
    riscvResetCLINT(riscv);

    // reset CLIC state
    riscvResetCLIC(riscv);

    // reset internal timer state
    riscvUpdateTimer(riscv);

    // indicate no taken exception
    riscv->exception = 0;

    // set address at which to execute
    setPCException(riscv, riscv->configInfo.reset_address);

    // enter Debug mode out of reset if required
    riscv->netValue.resethaltreqS = riscv->netValue.resethaltreq;
}

//
// Do NMI interrupt
//
static void doNMI(riscvP riscv) {

    riscvMode MPP = getCurrentMode3(riscv);
    Bool      MPV = inVMode(riscv);

    // clear mcause or mncause before calling customNMI
    if(RISCV_RNMI_VERSION(riscv)) {
        WR_CSR_M(riscv, mncause, 0);
    } else {
        WR_CSR_M(riscv, mcause, 0);
    }

    // do custom NMI behavior if required
    ITER_EXT_CB(
        riscv, extCB, customNMI,
        if(extCB->customNMI(riscv, extCB->clientData)) {
            return;
        }
    )

    // get NMI code after custom NMI handler (in case this is modified by that)
    Uns64 ecode_nmi = riscv->configInfo.ecode_nmi;

    // switch to Machine mode
    riscvSetMode(riscv, RISCV_MODE_M);

    if(RISCV_RNMI_VERSION(riscv)) {

        // RNMI implemented: nmi input is level sensitive and whether it is
        // active is indicated by rnmie=0
        WR_CSR_FIELDC(riscv, mnstatus, NMIE, 0);

        // update mncause register, preserving non-zero bits set by custom NMI
        WR_CSR_M(riscv, mncause, ecode_nmi | RD_CSR_M(riscv, mncause));

        // update mepc to hold next instruction address
        WR_CSR_M(riscv, mnepc, getEPC(riscv));

        // save old privilege level and virtual mode
        WR_CSR_FIELDC(riscv, mnstatus, MNPP, MPP);
        WR_CSR_FIELDC(riscv, mnstatus, MNPV, MPV);

    } else {

        // RNMI not implemented: nmi input is edge sensitive and pending NMI
        // must be cleared here
        WR_CSR_FIELDC(riscv, dcsr, nmip, 0);

        // update mcause register, preserving non-zero bits set by custom NMI
        WR_CSR_M(riscv, mcause, ecode_nmi | RD_CSR_M(riscv, mcause));

        // NMI sets mcause.Interrupt=1
        WR_CSR_FIELD_M(riscv, mcause, Interrupt, 1);

        // update mepc to hold next instruction address
        WR_CSR_M(riscv, mepc, getEPC(riscv));
    }

    // refresh pending interrupt state (in case previously enabled interrupt
    // is now masked)
    if(riscv->pendEnab.id!=RV_NO_INT) {
        riscvRefreshPendingAndEnabled(riscv);
    }

    // indicate the taken exception
    riscv->exception = ecode_nmi ? intToException(ecode_nmi) : riscv_E_GenericNMI;

    // set address at which to execute
    setPCException(riscv, riscv->configInfo.nmi_address);

    // activate NMI trigger if required
    riscvTriggerNMI(riscv);
}


////////////////////////////////////////////////////////////////////////////////
// CLIC FUNCTIONS (EXTERNAL MODEL)
////////////////////////////////////////////////////////////////////////////////

//
// Check for pending CLIC interrupts
//
inline static void testCLICInterrupt(riscvP riscv) {

    if(getPendingLocallyEnabledCLIC(riscv)) {
        riscvTestInterrupt(riscv);
    }
}

//
// Latch IRQ identifier
//
static VMI_NET_CHANGE_FN(irqIDPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    if(riscv->clic.sel.id != newValue) {

        riscv->clic.sel.id = newValue;

        if(riscv->netValue.enableCLIC) {
            riscvTestInterrupt(riscv);
        }
    }
}

//
// Latch IRQ level
//
static VMI_NET_CHANGE_FN(irqLevelPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    if(riscv->clic.sel.level != newValue) {

        riscv->clic.sel.level = newValue;

        testCLICInterrupt(riscv);
    }
}

//
// Latch IRQ mode
//
static VMI_NET_CHANGE_FN(irqSecurePortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;
    riscvMode           priv  = newValue & RISCV_MODE_M;

    if(riscv->clic.sel.priv != priv) {

        riscv->clic.sel.priv = priv;

        testCLICInterrupt(riscv);
    }
}

//
// Latch IRQ SHV state
//
static VMI_NET_CHANGE_FN(irqSHVPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;
    Bool                shv   = newValue & 1;

    if(riscv->clic.sel.shv != shv) {

        riscv->clic.sel.shv = shv;

        testCLICInterrupt(riscv);
    }
}

//
// Initiate new CLIC interrupt
//
static VMI_NET_CHANGE_FN(irqPortCB) {

    riscvInterruptInfoP ii     = userData;
    riscvP              riscv  = ii->hart;
    Bool                enable = newValue & 1;

    if(riscv->netValue.enableCLIC != enable) {

        riscv->netValue.enableCLIC = enable;

        if(riscv->clic.sel.id!=RV_NO_INT) {
            riscvTestInterrupt(riscv);
        }
    }
}


////////////////////////////////////////////////////////////////////////////////
// AIA FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Set priority of M-mode highest-priority pending and enabled external
// interrupt (from APLIC or IMSIC)
//
static VMI_NET_CHANGE_FN(miprioPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    riscv->aia->meiprio = newValue;
}

//
// Set priority of S-mode highest-priority pending and enabled external
// interrupt (from APLIC or IMSIC)
//
static VMI_NET_CHANGE_FN(siprioPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    riscv->aia->seiprio = newValue;
}

//
// Set priority of VS-mode highest-priority pending and enabled external
// interrupt for currently-enabled guest interrupt file (from APLIC or IMSIC)
//
static VMI_NET_CHANGE_FN(vsiprioPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    riscv->aia->vseiprio = newValue;
}


////////////////////////////////////////////////////////////////////////////////
// EXTERNAL INTERRUPT INTERFACE FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Return derived value of SGEI and VSEI interrupts
//
static Uns32 getGuestEIP(riscvP riscv) {

    Uns64 mask       = (1ULL<<RD_CSR_FIELDC(riscv, hstatus, VGEIN));
    Bool  selectSGEI = RD_CSR_S(riscv, hgeip) & RD_CSR_S(riscv, hgeie);
    Bool  selectVSEI = RD_CSR_S(riscv, hgeip) & mask;

    return (
        (selectSGEI ? 1<<exceptionToInt(riscv_E_SGEIInterrupt)       : 0) |
        (selectVSEI ? 1<<exceptionToInt(riscv_E_VSExternalInterrupt) : 0)
    );
}

//
// Update visible state in mip because of some pending state change (either from
// external interrupt source or software pending register)
//
void riscvUpdatePending(riscvP riscv) {

    // get active software interrupt bits, excluding bits that are disabled by
    // mvien
    Uns64 swip = riscv->swip & ~(WM64_mip_mvip & RD_CSR64(riscv, mvien));

    // reassign STIP and VSTIP from stimecmp and vstimecmp if required
    if(stimecmpEnabled(riscv)) {

        swip &= ~(1ULL<<exceptionToInt(riscv_E_STimerInterrupt));

        if(riscv->stimecmp) {
            swip |= 1ULL<<exceptionToInt(riscv_E_STimerInterrupt);
        }

        if(riscv->vstimecmp && vstimecmpEnabled(riscv)) {
            swip |= 1ULL<<exceptionToInt(riscv_E_VSTimerInterrupt);
        }
    }

    // compose mip value
    WR_CSR64(riscv, mip, riscv->ip[0] | swip | getGuestEIP(riscv));

    // test for pending interrupts
    riscvTestInterrupt(riscv);
}

//
// Reset signal
//
static VMI_NET_CHANGE_FN(resetPortCB) {

    riscvInterruptInfoP ii       = userData;
    riscvP              riscv    = ii->hart;
    Bool                oldValue = riscv->netValue.reset;

    if(posedge(oldValue, newValue)) {

        // halt the processor while signal goes high
        riscvHalt(riscv, RVD_RESET);

    } else if(negedge(oldValue, newValue)) {

        // reset the processor when signal goes low
        riscvReset(riscv);
    }

    riscv->netValue.reset = newValue;
}

//
// Reset address signal
//
static VMI_NET_CHANGE_FN(resetAddressPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    riscv->configInfo.reset_address = newValue;
}

//
// NMI signal
//
static VMI_NET_CHANGE_FN(nmiPortCB) {

    riscvInterruptInfoP ii       = userData;
    riscvP              riscv    = ii->hart;
    Bool                oldValue = RD_CSR_FIELDC(riscv, dcsr, nmip);

    // do NMI actions when signal goes high unless in Debug mode
    if(!inDebugMode(riscv) && posedge(oldValue, newValue)) {
        riscvRestart(riscv, RVD_RESTART_NMI);
        doSynchronousInterrupt(riscv);
    }

    // handle latching of NMI signal if required
    if(riscv->configInfo.nmi_is_latched) {
        newValue |= oldValue;
    }

    WR_CSR_FIELDC(riscv, dcsr, nmip, newValue);
}

//
// NMI cause signal
//
static VMI_NET_CHANGE_FN(nmiCausePortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    riscv->configInfo.ecode_nmi = newValue;
}

//
// NMI address signal
//
static VMI_NET_CHANGE_FN(nmiAddressPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    riscv->configInfo.nmi_address = newValue;
}

//
// NMI exception address signal
//
static VMI_NET_CHANGE_FN(nmiexcAddressPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    riscv->configInfo.nmiexc_address = newValue;
}

//
// haltreq signal (level-sensitive)
//
static VMI_NET_CHANGE_FN(haltreqPortCB) {

    riscvInterruptInfoP ii       = userData;
    riscvP              riscv    = ii->hart;
    Bool                oldValue = riscv->netValue.haltreq;

    // do halt actions when signal goes high unless in Debug mode
    if(!inDebugMode(riscv) && posedge(oldValue, newValue)) {
        riscvRestart(riscv, RVD_RESTART_NMI);
        doSynchronousInterrupt(riscv);
    }

    riscv->netValue.haltreq = newValue;
}

//
// resethaltreq signal (sampled at reset)
//
static VMI_NET_CHANGE_FN(resethaltreqPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    riscv->netValue.resethaltreq = newValue;
}

//
// SC_valid signal
//
static VMI_NET_CHANGE_FN(SCValidPortCB) {

    riscvInterruptInfoP ii    = userData;
    riscvP              riscv = ii->hart;

    if(!newValue) {
        clearEA(riscv);
    }
}

//
// Update the indexed standard interrupt
//
void riscvUpdateInterrupt(riscvP riscv, Uns32 index, Bool newValue) {

    Uns32 offset = index/64;
    Uns64 mask   = 1ULL << (index&63);
    Uns32 maxNum = riscvGetIntNum(riscv);

    // sanity check
    VMI_ASSERT(
        index<maxNum,
        "interrupt port index %u exceeds maximum %u",
        index, maxNum-1
    );

    // update pending bit
    if(newValue) {
        riscv->ip[offset] |= mask;
    } else {
        riscv->ip[offset] &= ~mask;
    }

    // update CLIC interrupt controller if required
    if(CLICInternal(riscv)) {
        riscvUpdateCLICInput(riscv, index, newValue);
    }

    // update basic interrupt controller if required
    if(basicICPresent(riscv)) {
        riscvUpdatePending(riscv);
    }
}

//
// Update mask of externally-disabled interrupts
//
void riscvUpdateInterruptDisable(riscvP riscv, Uns64 disableMask) {

    Uns64 oldMask = riscv->disableMask;

    // update mask of disabled interrupts
    riscv->disableMask = disableMask;

    // if interrupts have been unmasked, check for pending interrupts
    if(oldMask & ~disableMask) {
        riscvTestInterrupt(riscv);
    }
}

//
// Generic interrupt signal
//
static VMI_NET_CHANGE_FN(interruptPortCB) {

    riscvInterruptInfoP ii = userData;

    riscvUpdateInterrupt(ii->hart, ii->userData, newValue);
}

//
// Guest external interrupt signal
//
static VMI_NET_CHANGE_FN(guestExternalInterruptPortCB) {

    riscvInterruptInfoP ii       = userData;
    riscvP              riscv    = ii->hart;
    Uns32               index    = ii->userData;
    Uns64               mask     = 1ULL << index;
    Uns64               oldHGEIP = RD_CSR64(riscv, hgeip);
    Uns64               newHGEIP = oldHGEIP;

    // update pending bit
    if(newValue) {
        newHGEIP |= mask;
    } else {
        newHGEIP &= ~mask;
    }

    // update hgeip
    WR_CSR64(riscv, hgeip, newHGEIP);

    // restart the processor from WFI state if a guest external interrupt has
    // been asserted, even if this does not propagate to visible pending state
    if(newHGEIP&~oldHGEIP) {
        riscvRestart(riscv, RVD_RESTART_WFI);
    }

    // update basic interrupt controller if required
    if(oldHGEIP!=newHGEIP) {
        riscvUpdatePending(riscv);
    }
}

//
// Generic interrupt ID signal
//
static VMI_NET_CHANGE_FN(interruptIDPortCB) {

    riscvInterruptInfoP ii     = userData;
    riscvP              riscv  = ii->hart;
    Uns32               offset = ii->userData;

    // sanity check
    VMI_ASSERT(
        offset<RISCV_MODE_LAST,
        "interrupt ID port index %u out of range",
        offset
    );

    riscv->extInt[offset] = newValue;
}

//
// Artifact signal deferring taking of interrupts when high
//
static VMI_NET_CHANGE_FN(deferintPortCB) {

    riscvInterruptInfoP ii       = userData;
    riscvP              riscv    = ii->hart;
    Bool                oldValue = riscv->netValue.deferint;

    riscv->netValue.deferint = newValue;

    // handle possible interrupt when signal is released
    if(negedge(oldValue, newValue)) {
        handlePendingAndEnabled(riscv);
    }
}

//
// Artifact signal causing restart from WFI state when high
//
static VMI_NET_CHANGE_FN(restartwfiPortCB) {

    riscvInterruptInfoP ii       = userData;
    riscvP              riscv    = ii->hart;
    Bool                oldValue = riscv->netValue.restartwfi;

    riscv->netValue.restartwfi = newValue;

    // handle possible interrupt when signal is released
    if(posedge(oldValue, newValue)) {
        riscvTestInterrupt(riscv);
    }
}

//
// Raise Illegal Instruction externally to the model.
//
static VMI_NET_CHANGE_FN(illegalInstrPortCB) {

    riscvInterruptInfoP ii       = userData;
    riscvP              riscv    = ii->hart;
    Bool                oldValue = riscv->netValue.illegalInst;

    if(!posedge(oldValue, newValue)) {

        // no action unless rising edge

    } else if(handleBLimitTrap(riscv)) {

        // special case when waiting in wfi (external timeout)

    } else {

        // restart hart and immediately raise Illegal Instruction
        riscvRestart(riscv, RVD_RESTART_NMI);
        riscvIllegalInstructionMessage(riscv, "raised externally");
    }

    riscv->netValue.illegalInst = newValue;
}


////////////////////////////////////////////////////////////////////////////////
// NET PORT CREATION
////////////////////////////////////////////////////////////////////////////////

//
// Type pointers
//
DEFINE_CS(vmiNetPort);

//
// Convert bits to number of double words
//
#define BITS_TO_DWORDS(_B) (((_B)+63)/64)

//
// Macro defining input port template
//
#define PORT_I(_ID, _CB, _CODE, _DESC) [RVP_##_ID] = { \
    type        : vmi_NP_INPUT,             \
    name        : #_ID,                     \
    netChangeCB : _CB,                      \
    userData    : (void *)(_CODE),          \
    description : _DESC                     \
}

//
// Macro defining output port template
//
#define PORT_O(_ID, _HANDLE, _CODE, _DESC) [RVP_##_ID] = { \
    type        : vmi_NP_OUTPUT,            \
    name        : #_ID,                     \
    handle      : &(((riscvP)0)->_HANDLE),  \
    userData    : (void *)(_CODE),          \
    description : _DESC                     \
}

//
// Port identifiers
//
typedef enum riscvPortIdE {

    // standard ports
    RVP_reset,
    RVP_reset_addr,
    RVP_nmi,
    RVP_nmi_cause,
    RVP_nmi_addr,

    // timer ports
    RVP_mtime,

    // RNMI ports
    RVP_nmiexc_addr,

    // CLIC ports
    RVP_irq_id_i,
    RVP_irq_lev_i,
    RVP_irq_sec_i,
    RVP_irq_shv_i,
    RVP_irq_i,

    // AIA ports
    RVP_miprio,
    RVP_siprio,
    RVP_vsiprio,

    // interrupt status ports
    RVP_irq_ack_o,
    RVP_irq_id_o,
    RVP_sec_lvl_o,

    // Debug mode ports
    RVP_DM,
    RVP_haltreq,
    RVP_resethaltreq,

    // atomic operation management ports
    RVP_LR_address,
    RVP_SC_address,
    RVP_SC_valid,
    RVP_AMO_active,

    // artifact ports
    RVP_illegalinstr,
    RVP_deferint,
    RVP_coverpoint,
    RVP_readcsr,

    // WFI notification and restart ports
    RVP_core_wfi_mode,
    RVP_restart_wfi,

} riscvPortId;

//
// Port template list
//
static const vmiNetPort netPorts[] = {

    // standard ports
    PORT_I(reset,        resetPortCB,         0, "Reset"),
    PORT_I(reset_addr,   resetAddressPortCB,  0, "Externally-applied reset address"),
    PORT_I(nmi,          nmiPortCB,           0, "NMI"),
    PORT_I(nmi_cause,    nmiCausePortCB,      0, "Externally-applied NMI cause"),
    PORT_I(nmi_addr,     nmiAddressPortCB,    0, "Externally-applied NMI address"),

    // timer ports
    PORT_I(mtime,        mtimePortCB,         0, "External mtime source"),

    // RNMI ports
    PORT_I(nmiexc_addr,  nmiexcAddressPortCB, 0, "Externally-applied RNMI exception address"),

    // CLIC ports
    PORT_I(irq_id_i,     irqIDPortCB,         0, "ID of highest-priority pending interrupt"),
    PORT_I(irq_lev_i,    irqLevelPortCB,      0, "Level of highest-priority pending interrupt"),
    PORT_I(irq_sec_i,    irqSecurePortCB,     0, "Security state of highest-priority pending interrupt"),
    PORT_I(irq_shv_i,    irqSHVPortCB,        0, "Whether highest-priority pending interrupt uses selective hardware vectoring"),
    PORT_I(irq_i,        irqPortCB,           0, "Indicate new interrupt pending"),

    // AIA ports
    PORT_I(miprio,       miprioPortCB,        0, "Priority of external pending-and-enabled M-mode interrupt"),
    PORT_I(siprio,       siprioPortCB,        0, "Priority of external pending-and-enabled S-mode interrupt"),
    PORT_I(vsiprio,      vsiprioPortCB,       0, "Priority of external pending-and-enabled VS-mode interrupt"),

    // interrupt status ports
    PORT_O(irq_ack_o,    irq_ack_Handle,      0, "Interrupt acknowledge (pulse)"),
    PORT_O(irq_id_o,     irq_id_Handle,       0, "Acknowledged interrupt id (valid during irq_ack_o pulse)"),
    PORT_O(sec_lvl_o,    sec_lvl_Handle,      0, "Current privilege level"),

    // Debug mode ports
    PORT_O(DM,           DMPortHandle,        0, "Debug state indication"),
    PORT_I(haltreq,      haltreqPortCB,       0, "haltreq (Debug halt request)"),
    PORT_I(resethaltreq, resethaltreqPortCB,  0, "resethaltreq (Debug halt request after reset)"),

    // atomic operation management ports
    PORT_O(LR_address,   LRAddressHandle,     0, "Port written with effective address for LR instruction"),
    PORT_O(SC_address,   SCAddressHandle,     0, "Port written with effective address for SC instruction"),
    PORT_I(SC_valid,     SCValidPortCB,       0, "SC_address valid input signal"),
    PORT_O(AMO_active,   AMOActiveHandle,     0, "Port written with code indicating active AMO"),

    // artifact ports
    PORT_I(illegalinstr, illegalInstrPortCB,  0, "Artifact signal raising Illegal Instruction on rising edge"),
    PORT_I(deferint,     deferintPortCB,      0, "Artifact signal causing interrupts to be held off when high"),
    PORT_O(coverpoint,   coverHandle,         0, "Artifact port written with coverage point identifier"),
    PORT_O(readcsr,      readCSR,             0, "Artifact port written with CSR/GPR information when CSR is read"),

    // WFI notification port
    PORT_O(core_wfi_mode,wfiHandle,           0, "WFI is active"),
    PORT_I(restart_wfi,  restartwfiPortCB,    0, "Artifact signal causing restart from WFI state when high"),
};

//
// Allocate a new port and append to the tail of the list
//
static riscvNetPortPP newNetPort(
    riscvP         hart,
    riscvNetPortPP tail,
    const char    *name,
    vmiNetPortType type,
    vmiNetChangeFn portCB,
    const char    *desc,
    Uns32          code,
    Uns32         *handle
) {
    riscvNetPortP       this = STYPE_CALLOC(riscvNetPort);
    vmiNetPortP         info = &this->desc;
    riscvInterruptInfoP ii   = &this->ii;

    // fill port fields
    info->name        = strdup(name);
    info->type        = type;
    info->netChangeCB = portCB;
    info->handle      = handle;
    info->description = strdup(desc);
    info->userData    = ii;

    // initialize interrupt information structure to enable vectoring interrupt
    // to specific processor instance and use as userData on netChange callback
    ii->hart     = hart;
    ii->userData = code;

    // append to list
    *tail = this;

    // return new tail
    return &this->next;
}

//
// Allocate a new input port based on the given template and append to the tail
// of the list
//
static riscvNetPortPP newNetPortTemplate(
    riscvP         hart,
    riscvNetPortPP tail,
    riscvPortId    id
) {
    vmiNetPortCP template = &netPorts[id];
    void        *handle   = template->handle;

    // rebase handle to the given hart structure
    if(handle) {
        handle += (UnsPS)hart;
    }

    return newNetPort(
        hart,
        tail,
        template->name,
        template->type,
        template->netChangeCB,
        template->description,
        (UnsPS)template->userData,
        handle
    );
}

//
// Allocate new input ports based on the given template list and append them to
// the tail of the list
//
static riscvNetPortPP newNetPortsTemplate(
    riscvP         hart,
    riscvNetPortPP tail,
    riscvPortId    id1,
    riscvPortId    id2
) {
    while(id1<=id2) {
        tail = newNetPortTemplate(hart, tail, id1++);
    }

    return tail;
}

//
// Add net ports for individual external interrupts
//
static riscvNetPortPP addInterruptNetPorts(riscvP riscv, riscvNetPortPP tail) {

    // allocate implemented interrupt ports
    riscvExceptionDescCP this;

    // get standard interrupts supported on the current architecture
    for(this=exceptions; this->vmiInfo.name; this++) {

        vmiExceptionInfoCP info = &this->vmiInfo;
        riscvException     code = info->code;

        if(this->hasNetPort && hasStandardExceptionArch(riscv, this)) {

            tail = newNetPort(
                riscv,
                tail,
                info->name,
                vmi_NP_INPUT,
                interruptPortCB,
                info->description,
                exceptionToInt(code),
                0
            );

            if(!riscv->configInfo.external_int_id) {

                // no action unless External Interrupt code nets required

            } else if(!isExternalInterrupt(code)) {

                // no action unless this is an External Interrupt

            } else {

                typedef struct extIntDescS {
                    const char *name;
                    const char *desc;
                } extIntDesc;

                #define EXT_NT_DESC(_T, _N) \
                    _T "ExternalInterruptID", \
                    _N " external interrupt ID " \
                    "(sampled if non-zero as interrupt taken to "_N" mode)"

                // port names for each mode
                static const extIntDesc map[] = {
                    [RISCV_MODE_U] = {EXT_NT_DESC("U",  "User")},
                    [RISCV_MODE_S] = {EXT_NT_DESC("S",  "Supervisor")},
                    [RISCV_MODE_H] = {EXT_NT_DESC("VS", "Virtual supervisor")},
                    [RISCV_MODE_M] = {EXT_NT_DESC("M",  "Machine")},
                };

                Uns32 offset = code-riscv_E_ExternalInterrupt;

                tail = newNetPort(
                    riscv,
                    tail,
                    map[offset].name,
                    vmi_NP_INPUT,
                    interruptIDPortCB,
                    map[offset].desc,
                    offset,
                    0
                );
            }
        }
    }

    // add local interrupt ports
    Uns32 localIntNum = getLocalIntNum(riscv);
    Uns32 i;

    for(i=0; i<localIntNum; i++) {

        // synthesize code
        riscvException code = riscv_E_LocalInterrupt+i;

        if(riscvHasStandardException(riscv, code)) {

            // construct name and description
            char name[64];
            char desc[64];
            sprintf(name, "LocalInterrupt%u", i);
            sprintf(desc, "Local interrupt %u", i);

            tail = newNetPort(
                riscv,
                tail,
                name,
                vmi_NP_INPUT,
                interruptPortCB,
                desc,
                exceptionToInt(code),
                0
            );
        }
    }

    return tail;
}

//
// Add net ports for guest external interrupts
//
static riscvNetPortPP addGuestExternaIInterruptNetPorts(
    riscvP         riscv,
    riscvNetPortPP tail
) {
    // add local interrupt ports
    Uns32 guestExternalIntNum = getGuestExternalIntNum(riscv);
    Uns32 i;

    for(i=1; i<=guestExternalIntNum; i++) {

        // construct name and description
        char name[64];
        char desc[64];
        sprintf(name, "GuestExternalInterrupt%u", i);
        sprintf(desc, "Guest external interrupt %u", i);

        tail = newNetPort(
            riscv,
            tail,
            name,
            vmi_NP_INPUT,
            guestExternalInterruptPortCB,
            desc,
            i,
            0
        );
    }

    return tail;
}

//
// Allocate ports for this variant
//
void riscvNewNetPorts(riscvP riscv) {

    riscvNetPortPP tail = &riscv->netPorts;

    // allocate interrupt port state
    riscv->ipDWords = BITS_TO_DWORDS(riscvGetIntNum(riscv));
    riscv->ip       = STYPE_CALLOC_N(Uns64, riscv->ipDWords);

    // add standard input ports
    tail = newNetPortsTemplate(riscv, tail, RVP_reset, RVP_nmi_addr);

    // add standard interrupt ports if required
    if(externalMTIME(riscv)) {
        riscvNetPortPP mtimePortP = tail;
        tail = newNetPortTemplate(riscv, tail, RVP_mtime);
        riscv->mtimePort = *mtimePortP;
    }

    // allocate nmiexc_addr port if RNMI configured
    if(RISCV_RNMI_VERSION(riscv)) {
        tail = newNetPortTemplate(riscv, tail, RVP_nmiexc_addr);
    }

    // add standard interrupt ports if required
    if(basicICPresent(riscv) || CLICInternal(riscv)) {
        tail = addInterruptNetPorts(riscv, tail);
    }

    // add CLIC interrupt ports if required
    if(CLICExternal(riscv)) {
        tail = newNetPortsTemplate(riscv, tail, RVP_irq_id_i, RVP_irq_i);
    }

    // add guest external interrupt ports if required
    if(getGuestExternalIntNum(riscv)) {
        tail = addGuestExternaIInterruptNetPorts(riscv, tail);
    }

    // add M-mode AIA ports if required
    if(Smaia(riscv)) {
        tail = newNetPortsTemplate(riscv, tail, RVP_miprio, RVP_miprio);
    }

    // add S-mode AIA ports if required
    if(Smaia(riscv) && supervisorPresent(riscv)) {
        tail = newNetPortsTemplate(riscv, tail, RVP_siprio, RVP_siprio);
    }

    // add S-mode AIA ports if required
    if(Smaia(riscv) && hypervisorPresent(riscv)) {
        tail = newNetPortsTemplate(riscv, tail, RVP_vsiprio, RVP_vsiprio);
    }

    // add interrupt status ports
    tail = newNetPortsTemplate(riscv, tail, RVP_irq_ack_o, RVP_sec_lvl_o);

    // add Debug mode ports
    if(riscv->configInfo.debug_mode) {
        tail = newNetPortsTemplate(riscv, tail, RVP_DM, RVP_resethaltreq);
    }

    // add ports for external management of LR/SC locking if required
    if(riscv->configInfo.arch&ISA_A) {
        tail = newNetPortsTemplate(riscv, tail, RVP_LR_address, RVP_AMO_active);
    }

    // allocate artifact ports
    tail = newNetPortsTemplate(riscv, tail, RVP_illegalinstr, RVP_readcsr);

    // WFI notification and restart ports
    if(!riscv->configInfo.wfi_is_nop) {
        tail = newNetPortsTemplate(riscv, tail, RVP_core_wfi_mode, RVP_restart_wfi);
    }
}

//
// Free ports
//
void riscvFreeNetPorts(riscvP riscv) {

    riscvNetPortP next = riscv->netPorts;
    riscvNetPortP this;

    // free interrupt port state
    if(riscv->ip) {

        STYPE_FREE(riscv->ip);

        riscv->ip = 0;
    }

    // free ports
    while((this=next)) {

        next = this->next;

        // free name and description
        free((char *)(this->desc.name));
        free((char *)(this->desc.description));

        STYPE_FREE(this);
    }

    riscv->netPorts = 0;
}

//
// Get the next net port
//
VMI_NET_PORT_SPECS_FN(riscvNetPortSpecs) {

    riscvP        riscv = (riscvP)processor;
    riscvNetPortP this;

    if(!prev) {
        this = riscv->netPorts;
    } else {
        this = ((riscvNetPortP)prev)->next;
    }

    return this ? &this->desc : 0;
}


////////////////////////////////////////////////////////////////////////////////
// TIMER CREATION
////////////////////////////////////////////////////////////////////////////////

//
// Create mtime timer if required
//
void riscvNewMTIMETimer(riscvP riscv) {

    if(internalMTIME(riscv)) {

        // calculate time scale factor
        vmiProcessorP processor = (vmiProcessorP)riscv;
        Flt64         hart_Hz   = vmirtGetProcessorIPS(processor);
        Flt64         mtime_Hz  = riscv->configInfo.mtime_Hz;
        Uns32         scale     = hart_Hz/mtime_Hz;

        riscv->mtime = vmirtCreateMonotonicModelTimer(
            processor, mtimeCB, scale, 0
        );
    }
}

//
// Create new cycle timer
//
inline static vmiModelTimerP newCycleTimer(riscvP riscv, vmiICountFn icountCB) {
    return vmirtCreateModelTimer((vmiProcessorP)riscv, icountCB, 1, 0);
}

//
// Allocate timers
//
void riscvNewTimers(riscvP riscv) {

    if(riscv->configInfo.debug_mode) {
        riscv->stepTimer = newCycleTimer(riscv, riscvStepExcept);
    }
    if(riscv->configInfo.TW_time_limit || riscv->configInfo.STO_time_limit) {
        riscv->twTimer = newCycleTimer(riscv, expiredTW);
    }

    riscv->ackTimer = newCycleTimer(riscv, endIntAcknowledge);
}

//
// Free timers
//
void riscvFreeTimers(riscvP riscv) {

    if(riscv->mtime) {
        vmirtDeleteModelTimer(riscv->mtime);
        riscv->mtime = 0;
    }
    if(riscv->stepTimer) {
        vmirtDeleteModelTimer(riscv->stepTimer);
        riscv->stepTimer = 0;
    }
    if(riscv->twTimer) {
        vmirtDeleteModelTimer(riscv->twTimer);
        riscv->twTimer = 0;
    }
    if(riscv->ackTimer) {
        vmirtDeleteModelTimer(riscv->ackTimer);
        riscv->ackTimer = 0;
    }
}


////////////////////////////////////////////////////////////////////////////////
// SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Save/restore field keys
//
#define RV_IP               "ip"
#define RV_MTIME            "mtime"
#define RV_AIA              "aia"
#define RV_STEP_TIMER       "stepTimer"
#define RV_ACK_TIMER        "ackTimer"
#define RV_TW_TIMER         "twTimer"

//
// Save net state not covered by register read/write API
//
void riscvNetSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
) {
    if(phase==SRT_END_CORE) {

        // save pending interrupt state
        vmirtSave(cxt, RV_IP, riscv->ip, riscv->ipDWords*8);

        // save latched control input state
        VMIRT_SAVE_FIELD(cxt, riscv, netValue);

        // save basic-mode interrupt state
        if(basicICPresent(riscv)) {
            VMIRT_SAVE_FIELD(cxt, riscv, intState);
        }

        // save CLIC-mode interrupt state
        if(CLICInternal(riscv)) {
            riscvSaveCLIC(riscv, cxt);
        }

        // save AIA-mode interrupt state
        if(riscv->aia) {
            vmirtSave(cxt, RV_AIA, riscv->aia, sizeof(riscvAIA));
        }

        // save guest external interrupt state
        if(getGEILEN(riscv)) {
            VMIRT_SAVE_FIELD(cxt, riscv, csr.hgeip);
        }

        // save S-mode virtual interrupt enable
        if(RD_CSR_MASK64(riscv, mvien) || RD_CSR64(riscv, mvien)) {
            VMIRT_SAVE_FIELD(cxt, riscv, svie);
        }

        // restore software interrupt pending state
        VMIRT_SAVE_FIELD(cxt, riscv, swip);
    }
}

//
// Restore net state not covered by register read/write API
//
void riscvNetRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
) {
    if(phase==SRT_END_CORE) {

        // restore pending interrupt state
        vmirtRestore(cxt, RV_IP, riscv->ip, riscv->ipDWords*8);

        // restore latched control input state
        VMIRT_RESTORE_FIELD(cxt, riscv, netValue);

        // restore basic-mode interrupt state
        if(basicICPresent(riscv)) {
            VMIRT_RESTORE_FIELD(cxt, riscv, intState);
        }

        // restore CLIC-mode interrupt state
        if(CLICInternal(riscv)) {
            riscvRestoreCLIC(riscv, cxt);
        }

        // restore AIA-mode interrupt state
        if(riscv->aia) {
            vmirtRestore(cxt, RV_AIA, riscv->aia, sizeof(riscvAIA));
        }

        // restore guest external interrupt state
        if(getGEILEN(riscv)) {
            VMIRT_RESTORE_FIELD(cxt, riscv, csr.hgeip);
        }

        // restore S-mode virtual interrupt enable
        if(RD_CSR_MASK64(riscv, mvien) || RD_CSR64(riscv, mvien)) {
            VMIRT_RESTORE_FIELD(cxt, riscv, svie);
        }

        // restore software interrupt pending state
        VMIRT_RESTORE_FIELD(cxt, riscv, swip);

        // refresh artifact net indicating that the hart is in WFI state
        refreshInWFI(riscv);

        // check for pending interrupts
        riscvUpdatePending(riscv);
    }
}

//
// Save timer state not covered by register read/write API
//
void riscvTimerSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
) {
    if(phase==SRT_END_CORE) {

        if(riscv->mtime) {
            VMIRT_SAVE_FIELD(cxt, riscv, mtimebase);
            vmirtSaveModelTimer(cxt, RV_MTIME, riscv->mtime);
        }

        if(riscv->stepTimer) {
            VMIRT_SAVE_FIELD(cxt, riscv, stepICount);
            vmirtSaveModelTimer(cxt, RV_STEP_TIMER, riscv->stepTimer);
        }

        if(riscv->twTimer) {
            vmirtSaveModelTimer(cxt, RV_TW_TIMER, riscv->twTimer);
        }

        vmirtSaveModelTimer(cxt, RV_ACK_TIMER, riscv->ackTimer);
    }
}

//
// Restore timer state not covered by register read/write API
//
void riscvTimerRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
) {
    if(phase==SRT_END_CORE) {

        if(riscv->mtime) {
            VMIRT_RESTORE_FIELD(cxt, riscv, mtimebase);
            vmirtRestoreModelTimer(cxt, RV_MTIME, riscv->mtime);
            riscvUpdateTimer(riscv);
        }

        if(riscv->stepTimer) {
            VMIRT_RESTORE_FIELD(cxt, riscv, stepICount);
            vmirtRestoreModelTimer(cxt, RV_STEP_TIMER, riscv->stepTimer);
        }

        if(riscv->twTimer) {
            vmirtRestoreModelTimer(cxt, RV_TW_TIMER, riscv->twTimer);
        }

        vmirtRestoreModelTimer(cxt, RV_ACK_TIMER, riscv->ackTimer);
    }
}

