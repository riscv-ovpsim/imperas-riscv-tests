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

// Imperas header files
#include "hostapi/impTypes.h"

// VMI header files
#include "vmi/vmiTypes.h"

// model header files
#include "riscvTypeRefs.h"
#include "riscvVariant.h"


////////////////////////////////////////////////////////////////////////////////
// CSR ACCESS FUNCTION TYPES
////////////////////////////////////////////////////////////////////////////////

//
// Function type to read a 64-bit CSR
//
#define RISCV_CSR_READFN(_NAME) Uns64 _NAME( \
    riscvCSRAttrsCP attrs,      \
    riscvP          riscv       \
)
typedef RISCV_CSR_READFN((*riscvCSRReadFn));

//
// Function type to write a CSR
//
#define RISCV_CSR_WRITEFN(_NAME) Uns64 _NAME( \
    riscvCSRAttrsCP attrs,      \
    riscvP          riscv,      \
    Uns64           newValue    \
)
typedef RISCV_CSR_WRITEFN((*riscvCSRWriteFn));


////////////////////////////////////////////////////////////////////////////////
// CSR JIT CODE MAINTENANCE CALLBACKS
////////////////////////////////////////////////////////////////////////////////

//
// Function called to adjust JIT code generator state after a CSR write
//
#define RISCV_CSR_WSTATEFN(_NAME) void _NAME( \
    riscvMorphStateP state,     \
    Bool             useRS1     \
)
typedef RISCV_CSR_WSTATEFN((*riscvCSRWStateFn));


////////////////////////////////////////////////////////////////////////////////
// CSR SUPPORT FUNCTION TYPE
////////////////////////////////////////////////////////////////////////////////

//
// Function called to indicate CSR presence
//
#define RISCV_CSR_PRESENTFN(_NAME) Bool _NAME( \
    riscvCSRAttrsCP attrs,      \
    riscvP          riscv       \
)
typedef RISCV_CSR_PRESENTFN((*riscvCSRPresentFn));


////////////////////////////////////////////////////////////////////////////////
// CSR DEFINITION TYPE
////////////////////////////////////////////////////////////////////////////////

//
// CSR trace constraints
//
typedef enum riscvCSRTraceE {
    RCSRT_YES,          // always trace CSR
    RCSRT_NO,           // never trace CSR
    RCSRT_VOLATILE,     // trace only in volatile mode
} riscvCSRTrace;

//
// CSR trap constraints
//
typedef enum riscvCSRTrapE {
    CSRT_NA,            // CSR not trapped
    CSRT_TVM = 1<<0,    // trapped by mstatus.TVM=1 (e.g. satp register)
    CSRT_VTI = 1<<1,    // trapped by hvictl.VTI=1 (e.g. sip, sie registers)
} riscvCSRTrap;

//
// Stateen standard feature bits
//
typedef enum riscvCSRStateenBitE {
    bit_stateen_NA       = 0,
    bit_stateen_Zfinx    = 1,
    bit_stateen_Zcmt     = 2,
    bit_stateen_xcse     = 57,
    bit_stateen_IMSIC    = 58,
    bit_stateen_AIA      = 59,
    bit_stateen_sireg    = 60,
    bit_stateen_xenvcfg  = 62,
    bit_stateen_xstateen = 63,
} riscvCSRStateenBit;

// macro to define Stateen standard feature mask
#define STATEEN_MASK(_N) WM64_stateen_##_N = (1ULL<<bit_stateen_##_N)

//
// Stateen standard feature masks
//
typedef enum riscvCSRStateenBitStateenMaskE {
    STATEEN_MASK(Zfinx),
    STATEEN_MASK(Zcmt),
    STATEEN_MASK(xcse),
    STATEEN_MASK(IMSIC),
    STATEEN_MASK(AIA),
    STATEEN_MASK(sireg),
    STATEEN_MASK(xenvcfg),
    STATEEN_MASK(xstateen),
} riscvCSRStateenBitStateenMask;

//
// This structure records information about each CSR
//
typedef struct riscvCSRAttrsS {

    const char        *name;            // register name
    const char        *desc;            // register description
    vmiosObjectP       object;          // custom extension
    Uns32              csrNum;          // CSR number (includes privilege and r/w access)
    riscvArchitecture  arch;            // required architecture (presence)
    riscvArchitecture  access;          // required architecture (access)
    riscvPrivVer       version;         // minimum specification version
    riscvCSRPresentFn  presentCB;       // CSR present callback
    riscvCSRReadFn     readCB;          // read callback
    riscvCSRReadFn     readWriteCB;     // read callback (in r/w context)
    riscvCSRWriteFn    writeCB;         // write callback
    riscvCSRWStateFn   wstateCB;        // adjust JIT code generator state
    vmiReg             reg;             // register
    vmiReg             writeMaskV;      // configuration-dependent write mask
    Uns32              writeMaskC32;    // constant 32-bit write mask
    Uns64              writeMaskC64;    // constant 64-bit write mask

    riscvCSRStateenBit Smstateen    :8; // whether xstateen-controlled access
    riscvCSRTrap       trap         :2; // whether trapped
    riscvCSRTrace      noTraceChange:2; // trace mode
    Bool               wEndBlock    :1; // whether write terminates this block
    Bool               wEndRM       :1; // whether write invalidates RM assumption
    Bool               noSaveRestore:1; // whether to exclude from save/restore
    Bool               writeRd      :1; // whether write updates Rd
    Bool               aliasV       :1; // whether CSR has virtual alias
    Bool               undefined    :1; // whether CSR is undefined

} riscvCSRAttrs;

