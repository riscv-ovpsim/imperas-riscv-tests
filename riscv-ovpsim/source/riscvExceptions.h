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

#pragma once

// VMI header files
#include "hostapi/impTypes.h"

// model header files
#include "riscvExceptionTypes.h"
#include "riscvTypeRefs.h"
#include "riscvTypes.h"


//
// Get M-mode interrupt mode
//
riscvICMode riscvGetIntModeM(riscvP riscv);

//
// Get S-mode interrupt mode
//
riscvICMode riscvGetIntModeS(riscvP riscv);

//
// Get U-mode interrupt mode
//
riscvICMode riscvGetIntModeU(riscvP riscv);

//
// Get VS-mode interrupt mode
//
riscvICMode riscvGetIntModeVS(riscvP riscv);

//
// Halt the passed processor for the given reason
//
void riscvHalt(riscvP riscv, riscvDisableReason reason);

//
// Restart the passed processor for the given reason
//
void riscvRestart(riscvP riscv, riscvDisableReason reason);

//
// Is the fault a load/store/AMO fault?
//
Bool riscvIsLoadStoreAMOFault(riscvException exception);

//
// Take processor exception
//
void riscvTakeException(
    riscvP         riscv,
    riscvException exception,
    Uns64          tval
);

//
// Take asynchronous processor exception
//
void riscvTakeAsynchonousException(
    riscvP         riscv,
    riscvException exception,
    Uns64          tval
);

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
);

//
// Take processor exception because of memory access error which could be
// suppressed for a fault-only-first instruction
//
void riscvTakeMemoryException(
    riscvP         riscv,
    riscvException exception,
    Uns64          VA
);

//
// Reset the processor
//
void riscvReset(riscvP riscv);

//
// Take custom Illegal Instruction exception for the given reason
//
void riscvIllegalCustom(
    riscvP         riscv,
    riscvException exception,
    const char    *reason
);

//
// Take Illegal Instruction exception
//
void riscvIllegalInstruction(riscvP riscv);

//
// Take Illegal Instruction exception for the given reason
//
void riscvIllegalInstructionMessage(riscvP riscv, const char *reason);

//
// Take Virtual Instruction exception
//
void riscvVirtualInstruction(riscvP riscv);

//
// Take Virtual Instruction exception for the given reason
//
void riscvVirtualInstructionMessage(riscvP riscv, const char *reason);

//
// Take Instruction Address Misaligned exception
//
void riscvInstructionAddressMisaligned(riscvP riscv, Uns64 tval);

//
// Execute ECALL instruction
//
void riscvECALL(riscvP riscv);

//
// Execute EBREAK instruction
//
void riscvEBREAK(riscvP riscv);

//
// Return from M-mode resumable NMI exception
//
void riscvMNRET(riscvP riscv);

//
// Return from M-mode exception
//
void riscvMRET(riscvP riscv);

//
// Return from HS-mode exception
//
void riscvHSRET(riscvP riscv);

//
// Return from VS-mode exception
//
void riscvVSRET(riscvP riscv);

//
// Return from U-mode exception
//
void riscvURET(riscvP riscv);

//
// Return from VU-mode exception
//
void riscvVURET(riscvP riscv);

//
// Return from Debug mode
//
void riscvDRET(riscvP riscv);

//
// Enter or leave debug mode
//
void riscvSetDM(riscvP riscv, Bool DM);

//
// Update debug mode stall indication
//
void riscvSetDMStall(riscvP riscv, Bool DMStall);

//
// Set step breakpoint if required
//
void riscvSetStepBreakpoint(riscvP riscv);

//
// Halt the processor in WFI state if required
//
void riscvWFI(riscvP riscv);

//
// Stall the processor in WFI state while reservation set is valid if required
//
void riscvWRSNTO(riscvP riscv);

//
// Stall the processor in WFI state while reservation set is valid if required
//
void riscvWRSSTO(riscvP riscv);

//
// Does the processor implement the stndard exception or interrupt?
//
Bool riscvHasStandardException(riscvP riscv, riscvException code);

//
// Return total number of interrupts (including 0 to 15)
//
Uns32 riscvGetIntNum(riscvP riscv);

//
// Initialize mask of implemented exceptions
//
void riscvSetExceptionMask(riscvP riscv);

//
// Free exception state
//
void riscvExceptFree(riscvP riscv);

//
// Update the indexed standard interrupt
//
void riscvUpdateInterrupt(riscvP riscv, Uns32 index, Bool newValue);

//
// Update mask of externally-disabled interrupts
//
void riscvUpdateInterruptDisable(riscvP riscv, Uns64 disableMask);

//
// Update interrupt state because of some pending state change (either from
// external interrupt source or software pending register)
//
void riscvUpdatePending(riscvP riscv);

//
// Refresh pending-and-enabled interrupt state
//
void riscvRefreshPendingAndEnabled(riscvP riscv);

//
// Are there pending and enabled interupts?
//
Bool riscvPendingAndEnabled(riscvP riscv);

//
// Check for pending interrupts
//
void riscvTestInterrupt(riscvP riscv);

//
// Return the computed value of mtopi
//
Uns32 riscvGetMTOPI(riscvP riscv);

//
// Return the computed value of stopi
//
Uns32 riscvGetSTOPI(riscvP riscv);

//
// Return the computed value of vstopi
//
Uns32 riscvGetVSTOPI(riscvP riscv);

//
// Read mtimecmp
//
Uns64 riscvReadMTIMECMP(riscvP hart);

//
// Write mtimecmp
//
void riscvWriteMTIMECMP(riscvP hart, Uns64 value);

//
// Read mtime
//
Uns64 riscvReadMTIME(riscvP hart);

//
// Write mtime
//
void riscvWriteMTIME(riscvP hart, Uns64 value);

//
// Refresh timer interrupt state controlled by mtimecmp, stimecmp and vstimecmp
//
void riscvUpdateTimer(riscvP hart);

//
// Allocate ports for this variant
//
void riscvNewNetPorts(riscvP riscv);

//
// Free ports
//
void riscvFreeNetPorts(riscvP riscv);

//
// Create mtime timer if required
//
void riscvNewMTIMETimer(riscvP riscv);

//
// Allocate timers
//
void riscvNewTimers(riscvP riscv);

//
// Free timers
//
void riscvFreeTimers(riscvP riscv);

//
// Save net state not covered by register read/write API
//
void riscvNetSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
);

//
// Restore net state not covered by register read/write API
//
void riscvNetRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
);

//
// Save timer state not covered by register read/write API
//
void riscvTimerSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
);

//
// Restore timer state not covered by register read/write API
//
void riscvTimerRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
);

