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

// model header files
#include "riscvMode.h"

//
// Declare indexed exception
//
#define RISCV_EXCEPTION_TYPE_N(_BASE, _NUM) \
    riscv_E_##_BASE##_NUM = riscv_E_##_BASE + _NUM

//
// Exception codes
//
typedef enum riscvExceptionE {

    ////////////////////////////////////////////////////////////////////
    // EXCEPTIONS
    ////////////////////////////////////////////////////////////////////

    riscv_E_InstructionAddressMisaligned =  0,
    riscv_E_InstructionAccessFault       =  1,
    riscv_E_IllegalInstruction           =  2,
    riscv_E_Breakpoint                   =  3,
    riscv_E_LoadAddressMisaligned        =  4,
    riscv_E_LoadAccessFault              =  5,
    riscv_E_StoreAMOAddressMisaligned    =  6,
    riscv_E_StoreAMOAccessFault          =  7,
    riscv_E_EnvironmentCallFromUMode     =  8,
    riscv_E_EnvironmentCallFromSMode     =  9,
    riscv_E_EnvironmentCallFromVSMode    = 10,
    riscv_E_EnvironmentCallFromMMode     = 11,
    riscv_E_InstructionPageFault         = 12,
    riscv_E_InstructionMPUFault          = 12,
    riscv_E_LoadPageFault                = 13,
    riscv_E_LoadMPUFault                 = 13,
    riscv_E_StoreAMOPageFault            = 15,
    riscv_E_StoreAMOMPUFault             = 15,
    riscv_E_InstructionGuestPageFault    = 20,
    riscv_E_LoadGuestPageFault           = 21,
    riscv_E_VirtualInstruction           = 22,
    riscv_E_StoreAMOGuestPageFault       = 23,

    ////////////////////////////////////////////////////////////////////
    // INTERRUPTS
    ////////////////////////////////////////////////////////////////////

    // this identifies interrupts (currently, we allow up to 64 non-interrupt
    // exceptions; this value is not architectural and can be increased if
    // required)
    // NOTE: please update rv32CpuHelper events.c if this changes
    riscv_E_Interrupt           = 0x40,

    // these classify interrupt types
    riscv_E_SW                  = 0x00,
    riscv_E_Timer               = 0x04,
    riscv_E_External            = 0x08,
    riscv_E_Guest               = 0x0c,
    riscv_E_CLIC                = 0x0c,
    riscv_E_Local               = 0x10,

    // these are interrupt type groups
    riscv_E_SWInterrupt         = riscv_E_SW       | riscv_E_Interrupt,
    riscv_E_TimerInterrupt      = riscv_E_Timer    | riscv_E_Interrupt,
    riscv_E_ExternalInterrupt   = riscv_E_External | riscv_E_Interrupt,
    riscv_E_CLICInterrupt       = riscv_E_CLIC     | riscv_E_Interrupt,
    riscv_E_LocalInterrupt      = riscv_E_Local    | riscv_E_Interrupt,
    riscv_E_GuestInterrupt      = riscv_E_Guest    | riscv_E_Interrupt,

    // interrupts defined by architectural specification
    riscv_E_USWInterrupt        = riscv_E_SWInterrupt       | RISCV_MODE_U,
    riscv_E_SSWInterrupt        = riscv_E_SWInterrupt       | RISCV_MODE_S,
    riscv_E_VSSWInterrupt       = riscv_E_SWInterrupt       | RISCV_MODE_H,
    riscv_E_MSWInterrupt        = riscv_E_SWInterrupt       | RISCV_MODE_M,
    riscv_E_UTimerInterrupt     = riscv_E_TimerInterrupt    | RISCV_MODE_U,
    riscv_E_STimerInterrupt     = riscv_E_TimerInterrupt    | RISCV_MODE_S,
    riscv_E_VSTimerInterrupt    = riscv_E_TimerInterrupt    | RISCV_MODE_H,
    riscv_E_MTimerInterrupt     = riscv_E_TimerInterrupt    | RISCV_MODE_M,
    riscv_E_UExternalInterrupt  = riscv_E_ExternalInterrupt | RISCV_MODE_U,
    riscv_E_SExternalInterrupt  = riscv_E_ExternalInterrupt | RISCV_MODE_S,
    riscv_E_VSExternalInterrupt = riscv_E_ExternalInterrupt | RISCV_MODE_H,
    riscv_E_MExternalInterrupt  = riscv_E_ExternalInterrupt | RISCV_MODE_M,
    riscv_E_SGEIInterrupt       = riscv_E_GuestInterrupt,

    // interrupts defined when CLIC is present
    riscv_E_CSIP               = riscv_E_CLICInterrupt,

    ////////////////////////////////////////////////////////////////////
    // for sizing (local interrupts follow)
    ////////////////////////////////////////////////////////////////////

    riscv_E_Last = riscv_E_LocalInterrupt,

    ////////////////////////////////////////////////////////////////////
    // generic NMI (special case)
    ////////////////////////////////////////////////////////////////////

    riscv_E_GenericNMI = -1

} riscvException;

//
// Exception priorities for standard exceptions (implementation-dependent
// local interrupts may be interleaved with these, but by default are highest
// priority starting with riscv_E_LocalPriority and increasing for higher
// numbered interrupts)
//
typedef enum riscvExceptionPriorityE {

    // this is the lowest architectural priority
    riscv_E_MinPriority        = -120,

    // low-priority local interrupt default priorities when AIA present
    riscv_E_Local32Priority    = riscv_E_MinPriority,
    riscv_E_Local16Priority    = -110,
    riscv_E_Local33Priority    = -100,
    riscv_E_Local34Priority    = -90,
    riscv_E_Local17Priority    = -80,
    riscv_E_Local35Priority    = -70,
    riscv_E_Local36Priority    = -60,
    riscv_E_Local18Priority    = -50,
    riscv_E_Local37Priority    = -40,
    riscv_E_Local38Priority    = -30,
    riscv_E_Local19Priority    = -20,
    riscv_E_Local39Priority    = -10,

    // standard major interrupts (0-15)
    riscv_E_UTimerPriority     = 10,
    riscv_E_USWPriority        = 20,
    riscv_E_UExternalPriority  = 30,
    riscv_E_VSTimerPriority    = 40,
    riscv_E_VSSWPriority       = 50,
    riscv_E_VSExternalPriority = 60,
    riscv_E_SGEIPriority       = 70,
    riscv_E_STimerPriority     = 80,
    riscv_E_SSWPriority        = 90,
    riscv_E_SExternalPriority  = 100,
    riscv_E_MTimerPriority     = 110,
    riscv_E_MSWPriority        = 120,
    riscv_E_MExternalPriority  = 130,

    // high-priority local interrupt default priorities when AIA present
    riscv_E_Local40Priority    = 140,
    riscv_E_Local20Priority    = 150,
    riscv_E_Local41Priority    = 160,
    riscv_E_Local42Priority    = 170,
    riscv_E_Local21Priority    = 180,
    riscv_E_Local43Priority    = 190,
    riscv_E_Local44Priority    = 200,
    riscv_E_Local22Priority    = 210,
    riscv_E_Local45Priority    = 220,
    riscv_E_Local46Priority    = 230,
    riscv_E_Local23Priority    = 240,
    riscv_E_Local47Priority    = 250,

    // local interrupt default priorities when AIA absent
    riscv_E_LocalPriority      = 260

} riscvExceptionPriority;

//
// Detail of exception reason to differentiate causes further
//
typedef enum riscvExceptionDtlS {
    riscv_ED_None,      // no detail
    riscv_ED_PMP,       // PMP permission error
    riscv_ED_Bus,       // bus error
    riscv_ED_Atomic,    // illegal atomic access
    riscv_ED_Device,    // device error
    riscv_ED_FS,        // FP disabled
    riscv_ED_VS,        // V extension disabled
    riscv_ED_Custom1,   // custom reason (1)
    riscv_ED_Custom2,   // custom reason (2)
    riscv_ED_Custom3,   // custom reason (3)
    riscv_ED_Custom4,   // custom reason (4)
    riscv_ED_LAST,      // KEEP LAST: for sizing
} riscvExceptionDtl;

//
// Specify enabled interrupt mode
//
typedef enum riscvICModeE {

    // discrete options
    riscv_int_Direct        = 0x0,  // direct interrupt mode
    riscv_int_Vectored      = 0x1,  // vectored interrupt mode
    riscv_int_CLIC          = 0x2,  // CLIC interrupt mode

    // CLIC composite options
    riscv_int_CLIC_Direct   = (riscv_int_CLIC|riscv_int_Direct),
    riscv_int_CLIC_Vectored = (riscv_int_CLIC|riscv_int_Vectored),

} riscvICMode;

//
// Return exception code for interrupt number
//
inline static riscvException intToException(Uns32 intIndex) {
    return intIndex+riscv_E_Interrupt;
}

//
// Return interrupt number for exception code
//
inline static Uns32 exceptionToInt(riscvException exception) {
    return exception-riscv_E_Interrupt;
}

//
// Is the exception an interrupt
//
inline static Bool isInterrupt(riscvException exception) {
    return exception>=riscv_E_Interrupt;
}

//
// Get code from an exception
//
inline static Uns32 getExceptionCode(riscvException exception) {
    return isInterrupt(exception) ? exceptionToInt(exception) : exception;
}


