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
#include "riscvCSRTypes.h"
#include "riscvRegisterTypes.h"
#include "riscvTypes.h"
#include "riscvTypeRefs.h"
#include "riscvVariant.h"


////////////////////////////////////////////////////////////////////////////////
// INSTRUCTION DECODE SUPPORT TYPES
////////////////////////////////////////////////////////////////////////////////

//
// Structure filled with information about a decoded instruction
//
typedef struct riscvExtInstrInfoS {
    riscvAddr         thisPC;       // instruction address
    Uns64             instruction;  // instruction word
    Uns8              bytes;        // instruction bytes
    const char       *opcode;       // opcode name
    const char       *format;       // disassembly format string
    riscvArchitecture arch;         // architecture requirements
    riscvRegDesc      r[4];         // argument registers
    riscvRegDesc      mask;         // mask register (vector instructions)
    riscvRMDesc       rm;           // rounding mode
    Uns64             c;            // constant value
    Addr              tgt;          // target address calculated relative to the PC
    void             *userData;     // client-specific data
} riscvExtInstrInfo;

//
// Standard instruction patterns
// (See doc/ovp/OVP_RISCV_Model_Custom_Extension_Guide.pdf for more details)
//
typedef enum riscvExtInstrPatternE {

                            // GPR INSTRUCTIONS
    RVIP_RD_RS1_RS2,        // op   xd, xs1, xs2        (R-Type)
    RVIP_RD_RS1_SI,         // op   xd, xs1, imm        (I-Type)
    RVIP_RD_RS1_SHIFT,      // op   xd, xs1, shift      (I-Type - 5 or 6 bit shift)
    RVIP_BASE_RS2_OFFSET,   // op   base, xs2, offset   (S-Type)
    RVIP_RS1_RS2_OFFSET,    // op   xs1, xs2, offset    (B-Type)
    RVIP_RD_SI,             // op   xd, imm             (U-Type)
    RVIP_RD_OFFSET,         // op   xd, offset          (J-Type)
    RVIP_RD_RS1_RS2_RS3,    // op   xd, xs1, xs2, xs3   (R4-Type)
    RVIP_RD_RS1_RS3_SHIFT,  // op   xd, xs1, xs2, shift (Non-Standard)

                            // FPR INSTRUCTIONS
    RVIP_FD_FS1_FS2,        // op   fd, fs1, fs2
    RVIP_FD_FS1_FS2_RM,     // op   fd, fs1, fs2, rm
    RVIP_FD_FS1_FS2_FS3_RM, // op   fd, fs1, fs2, fs3, rm
    RVIP_RD_FS1_FS2,        // op   xd, fs1, fs2

                            // VECTOR INSTRUCTIONS
    RVIP_VD_VS1_VS2_M,      // op   vd, vs1, vs2, vm
    RVIP_VD_VS1_SI_M,       // op   vd, vs1, simm, vm
    RVIP_VD_VS1_UI_M,       // op   vd, vs1, uimm, vm
    RVIP_VD_VS1_RS2_M,      // op   vd, vs1, rs2, vm
    RVIP_VD_VS1_FS2_M,      // op   vd, vs1, fs2, vm
    RVIP_RD_VS1_RS2,        // op   xd, vs1, vs2
    RVIP_RD_VS1_M,          // op   xd, vs1, vm
    RVIP_VD_RS2,            // op   vd, xs2
    RVIP_FD_VS1,            // op   fd, vs1
    RVIP_VD_FS2,            // op   vd, fs2

    RVIP_LAST               // KEEP LAST: for sizing

} riscvExtInstrPattern;

//
// Structure defining characteristics of each instruction
//
typedef struct riscvExtInstrAttrsS {
    const char          *opcode;    // opcode name
    riscvArchitecture    arch;      // architectural requirements
    riscvExtInstrPattern pattern;   // instruction pattern
    const char          *format;    // disassembly format string
    const char          *decode;    // decode string
} riscvExtInstrAttrs;

//
// Use this macro to fill decode table entries
//
#define EXT_INSTRUCTION(_ID, _NAME, _ARCH, _PATTERN, _FORMAT, _DECODE) [_ID] = { \
    opcode  : _NAME,    \
    arch    : _ARCH,    \
    pattern : _PATTERN, \
    format  : _FORMAT,  \
    decode  : _DECODE   \
}


////////////////////////////////////////////////////////////////////////////////
// INSTRUCTION TRANSLATION SUPPORT TYPES
////////////////////////////////////////////////////////////////////////////////

//
// Generic JIT code emission callback
//
#define EXT_MORPH_FN(_NAME) void _NAME(riscvExtMorphStateP state)
typedef EXT_MORPH_FN((*extMorphFn));

//
// Attributes controlling JIT code translation
//
typedef struct riscvExtMorphAttrS {
    extMorphFn            morph;    // function to translate one instruction
    octiaInstructionClass iClass;   // supplemental instruction class
    Uns32                 variant;  // required variant
    void                 *userData; // client-specific data
} riscvExtMorphAttr;

//
// Context for JIT code translation (decoded instruction information and
// translation attributes)
//
typedef struct riscvExtMorphStateS {
    riscvExtInstrInfo   info;       // decoded instruction information
    riscvExtMorphAttrCP attrs;      // instruction attributes
    riscvP              riscv;      // current processor
    vmiosObjectP        object;     // current extension object
} riscvExtMorphState;

//
// Context for load/store operation
//
typedef struct riscvExtLdStAttrsS {
    memConstraint constraint : 4;   // access constraints
    Bool          sExtend    : 1;   // sign-extension (load only)
    Bool          isVirtual  : 1;   // whether HLV/HLVX/HSV
    Bool          isCode     : 1;   // whether load as if fetch (HLVX)
} riscvExtLdStAttrs;


////////////////////////////////////////////////////////////////////////////////
// REGISTER ACCESS MACROS
////////////////////////////////////////////////////////////////////////////////

//
// Morph-time macros to calculate offsets to fields in an extension object
//
#define EXT_OFFSET(_R)  VMI_CPU_OFFSET(vmiosObjectP, _R)
#define EXT_REG(_R)     VMI_CPU_REG(vmiosObjectP, _R)

// morph-time macros to calculate offset to the high part of a 64-bit register
#define EXT_OFFSETH(_R) VMI_CPU_OFFSET_DELTA(vmiosObjectP, _R, 4)
#define EXT_REGH(_R)    VMI_CPU_REG_CONST_DELTA(vmiosObjectP, _R, 4)


////////////////////////////////////////////////////////////////////////////////
// CSR ENUMERATION
////////////////////////////////////////////////////////////////////////////////

//
// Construct CSR enumeration member name from register name
//
#define XCSR_ID(_R) XCSR_ID_##_R


////////////////////////////////////////////////////////////////////////////////
// CSR DEFINITIONS
////////////////////////////////////////////////////////////////////////////////

//
// Use this to declare a 32-bit register type name
//
#define XCSR_REG_TYPE_32(_N) riscvXCSR32_##_N

//
// Use this to declare a 64-bit register type name
//
#define XCSR_REG_TYPE_64(_N) riscvXCSR64_##_N

//
// Use this to declare a register type name
//
#define XCSR_REG_TYPE(_N)    riscvXCSR_##_N

//
// Use this to declare a register with 32-bit view only (zero-extended to 64)
//
#define XCSR_REG_STRUCT_DECL_32(_N) typedef union { \
    Uns64                    _pad;      \
    union {                             \
        Uns32                bits;      \
        XCSR_REG_TYPE_32(_N) fields;    \
    } u32;                              \
    union {                             \
        Uns32                bits;      \
        XCSR_REG_TYPE_32(_N) fields;    \
    } u64;                              \
} XCSR_REG_TYPE(_N)

//
// Use this to declare a register with 32-bit view equivalent to lower half of
// 64-bit view
//
#define XCSR_REG_STRUCT_DECL_64(_N) typedef union { \
    Uns64                    _pad;      \
    union {                             \
        Uns32                bits;      \
        XCSR_REG_TYPE_64(_N) fields;    \
    } u32;                              \
    union {                             \
        Uns64                bits;      \
        XCSR_REG_TYPE_64(_N) fields;    \
    } u64;                              \
} XCSR_REG_TYPE(_N)

//
// Use this to declare a register with distinct 32/64 bit views
//
#define XCSR_REG_STRUCT_DECL_32_64(_N) typedef union { \
    Uns64                    _pad;      \
    union {                             \
        Uns32                bits;      \
        XCSR_REG_TYPE_32(_N) fields;    \
    } u32;                              \
    union {                             \
        Uns64                bits;      \
        XCSR_REG_TYPE_64(_N) fields;    \
    } u64;                              \
} XCSR_REG_TYPE(_N)

//
// Use this to define a CSR entry
//
#define XCSR_REG_DECL(_N)   XCSR_REG_TYPE(_N) _N

//
// This type defines CSR attributes together with extension-specific
// configuration information
//
typedef struct extCSRAttrsS {
    Uns32         extension;    // extension requirements
    riscvCSRAttrs baseAttrs;    // base attributes
} extCSRAttrs;

DEFINE_CS(extCSRAttrs);

//
// This macro declares an undefined CSR. This can be used where an extension
// model does not implement a standard CSR for some reason.
//
#define XCSR_ATTR_UIP(_ID, _NUM, _ARCH, _EXT) [XCSR_ID(_ID)] = { \
    .extension = _EXT,                              \
    .baseAttrs = {                                  \
        name          : #_ID,                       \
        csrNum        : _NUM,                       \
        arch          : _ARCH,                      \
        undefined     : True                        \
    }                                               \
}

//
// This macro declares a defined but unimplemented CSR. This can be used where
// an extension model is under development and a temporary placeholder is needed
// for future implementation.
//
#define XCSR_ATTR_NIP( \
    _ID, _NUM, _ARCH, _EXT, _ENDB,_ENDRM,_NOTR,_TRAP, _DESC \
) [XCSR_ID(_ID)] = { \
    .extension = _EXT,                              \
    .baseAttrs = {                                  \
        name          : #_ID,                       \
        desc          : _DESC" (not implemented)",  \
        csrNum        : _NUM,                       \
        arch          : _ARCH,                      \
        wEndBlock     : _ENDB,                      \
        wEndRM        : _ENDRM,                     \
        noTraceChange : _NOTR,                      \
        trap          : _TRAP,                      \
    }                                               \
}

//
// This macro declares a CSR that has a value implemented by a field in the
// extension object with no write mask constraints. There can optionally be
// read or write callbacks.
//
#define XCSR_ATTR_T__( \
    _ID, _NUM, _ARCH, _EXT, _ENDB,_ENDRM,_NOTR,_TRAP, _DESC, _RCB, _RWCB, _WCB \
) [XCSR_ID(_ID)] = { \
    .extension = _EXT,                              \
    .baseAttrs = {                                  \
        name          : #_ID,                       \
        desc          : _DESC,                      \
        csrNum        : _NUM,                       \
        arch          : _ARCH,                      \
        wEndBlock     : _ENDB,                      \
        wEndRM        : _ENDRM,                     \
        noTraceChange : _NOTR,                      \
        trap          : _TRAP,                      \
        readCB        : _RCB,                       \
        readWriteCB   : _RWCB,                      \
        writeCB       : _WCB,                       \
        reg           : XCSR_REG_MT(_ID),           \
        writeMaskC32  : -1,                         \
        writeMaskC64  : -1                          \
    }                                               \
}

//
// This macro declares a CSR that has a value implemented by a field in the
// extension object and constant write masks. There can optionally be read or
// write callbacks.
//
#define XCSR_ATTR_TC_( \
    _ID, _NUM, _ARCH, _EXT, _ENDB,_ENDRM,_NOTR,_TRAP, _DESC, _RCB, _RWCB, _WCB \
) [XCSR_ID(_ID)] = { \
    .extension = _EXT,                              \
    .baseAttrs = {                                  \
        name          : #_ID,                       \
        desc          : _DESC,                      \
        csrNum        : _NUM,                       \
        arch          : _ARCH,                      \
        wEndBlock     : _ENDB,                      \
        wEndRM        : _ENDRM,                     \
        noTraceChange : _NOTR,                      \
        trap          : _TRAP,                      \
        readCB        : _RCB,                       \
        readWriteCB   : _RWCB,                      \
        writeCB       : _WCB,                       \
        reg           : XCSR_REG_MT(_ID),           \
        writeMaskC32  : WM32_##_ID,                 \
        writeMaskC64  : WM64_##_ID                  \
    }                                               \
}

//
// This macro declares a CSR that has a value implemented by a field in the
// extension object and configurable write mask. There can optionally be read
// or write callbacks.
//
#define XCSR_ATTR_TV_( \
    _ID, _NUM, _ARCH, _EXT, _ENDB,_ENDRM,_NOTR,_TRAP, _DESC, _RCB, _RWCB, _WCB \
) [XCSR_ID(_ID)] = { \
    .extension = _EXT,                              \
    .baseAttrs = {                                  \
        name          : #_ID,                       \
        desc          : _DESC,                      \
        csrNum        : _NUM,                       \
        arch          : _ARCH,                      \
        wEndBlock     : _ENDB,                      \
        wEndRM        : _ENDRM,                     \
        noTraceChange : _NOTR,                      \
        trap          : _TRAP,                      \
        readCB        : _RCB,                       \
        readWriteCB   : _RWCB,                      \
        writeCB       : _WCB,                       \
        reg           : XCSR_REG_MT(_ID),           \
        writeMaskV    : XCSR_MASK_MT(_ID)           \
    }                                               \
}

//
// This macro declares a CSR that is implemented by callbacks only and has no
// corresponding value field in the extension object. If readCB is absent, the
// CSR always reads zero. If writeCB is absent, writes are ignored.
//
#define XCSR_ATTR_P__( \
    _ID, _NUM, _ARCH, _EXT, _ENDB,_ENDRM,_NOTR,_TRAP, _DESC, _RCB, _RWCB, _WCB \
) [XCSR_ID(_ID)] = { \
    .extension = _EXT,                              \
    .baseAttrs = {                                  \
        name          : #_ID,                       \
        desc          : _DESC,                      \
        csrNum        : _NUM,                       \
        arch          : _ARCH,                      \
        wEndBlock     : _ENDB,                      \
        wEndRM        : _ENDRM,                     \
        noTraceChange : _NOTR,                      \
        trap          : _TRAP,                      \
        readCB        : _RCB,                       \
        readWriteCB   : _RWCB,                      \
        writeCB       : _WCB,                       \
        writeMaskC32  : -1,                         \
        writeMaskC64  : -1                          \
    }                                               \
}

//
// Same as XCSR_ATTR_P__, but includes a constructor phase
// callback to specify whether the register is present
//
#define XCSR_ATTR_PP_( \
    _ID, _NUM, _ARCH, _EXT, _ENDB,_ENDRM,_NOTR,_TRAP, _DESC, _RCB, _RWCB, _WCB, _PCB \
) [XCSR_ID(_ID)] = { \
    .extension = _EXT,                              \
    .baseAttrs = {                                  \
        name          : #_ID,                       \
        desc          : _DESC,                      \
        csrNum        : _NUM,                       \
        arch          : _ARCH,                      \
        wEndBlock     : _ENDB,                      \
        wEndRM        : _ENDRM,                     \
        noTraceChange : _NOTR,                      \
        trap          : _TRAP,                      \
        readCB        : _RCB,                       \
        readWriteCB   : _RWCB,                      \
        writeCB       : _WCB,                       \
        writeMaskC32  : -1,                         \
        writeMaskC64  : -1,                         \
        presentCB     : _PCB                        \
    }                                               \
}

//
// This macro declares a CSR that has a value implemented by a field in the
// extension object with no write mask constraints. The value field is the high
// half of a second CSR. There can optionally be read or write callbacks.
//
#define XCSR_ATTR_TH_( \
    _ID, _SUFFIX, _NUM, _ARCH, _EXT, _ENDB,_ENDRM,_NOTR,_TRAP, _DESC, _RCB, _RWCB, _WCB \
) [XCSR_ID(_ID##_SUFFIX)] = { \
    .extension = _EXT,                              \
    .baseAttrs = {                                  \
        name          : #_ID#_SUFFIX,               \
        desc          : _DESC,                      \
        csrNum        : _NUM,                       \
        arch          : _ARCH,                      \
        wEndBlock     : _ENDB,                      \
        wEndRM        : _ENDRM,                     \
        noTraceChange : _NOTR,                      \
        trap          : _TRAP,                      \
        readCB        : _RCB,                       \
        readWriteCB   : _RWCB,                      \
        writeCB       : _WCB,                       \
        reg           : XCSR_REG64H_MT(_ID),        \
        writeMaskC32  : -1,                         \
        writeMaskC64  : -1                          \
    }                                               \
}


////////////////////////////////////////////////////////////////////////////////
// CSR ACCESS MACROS FOR BASE MODEL CSRS BASED ON ON CURRENT XLEN
////////////////////////////////////////////////////////////////////////////////

// get raw value using current XLEN
#define RD_RAW(_CPU, _R) \
    (RISCV_XLEN_IS_32(_CPU) ?                               \
        RD_RAW32(_R) :                                      \
        RD_RAW64(_R))

// set raw value using current XLEN
#define WR_RAW(_CPU, _R, _VALUE) \
    if(RISCV_XLEN_IS_32(_CPU)) {                            \
        WR_RAW32(_R, _VALUE);                               \
    } else {                                                \
        WR_RAW64(_R, _VALUE);                               \
    }

// get CSR value using current XLEN
#define RD_CSR(_CPU, _RNAME) \
    RD_RAW(_CPU, (_CPU)->csr._RNAME)

// set CSR value using current XLEN
#define WR_CSR(_CPU, _RNAME, _VALUE) \
    WR_RAW(_CPU, (_CPU)->csr._RNAME, _VALUE)

// get raw field using current XLEN
#define RD_RAW_FIELD(_CPU, _R, _FIELD) \
    (RISCV_XLEN_IS_32(_CPU) ?                               \
        (_R).u32.fields._FIELD :                            \
        (_R).u64.fields._FIELD)

// set raw field using current XLEN
#define WR_RAW_FIELD(_CPU, _R, _FIELD, _VALUE) \
    if(RISCV_XLEN_IS_32(_CPU)) {                            \
        (_R).u32.fields._FIELD = _VALUE;                    \
    } else {                                                \
        (_R).u64.fields._FIELD = _VALUE;                    \
    }

// get CSR field using current XLEN
#define RD_CSR_FIELD(_CPU, _RNAME, _FIELD) \
    RD_RAW_FIELD(_CPU, (_CPU)->csr._RNAME, _FIELD)

// set CSR field using current XLEN
#define WR_CSR_FIELD(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_RAW_FIELD(_CPU, (_CPU)->csr._RNAME, _FIELD, _VALUE)


////////////////////////////////////////////////////////////////////////////////
// CSR ACCESS MACROS FOR BASE MODEL CSR MASKS BASED ON ON CURRENT XLEN
////////////////////////////////////////////////////////////////////////////////

// get CSR mask using current XLEN
#define RD_CSR_MASK(_CPU, _RNAME)  \
    (RISCV_XLEN_IS_32(_CPU) ?                               \
        RD_CSR_MASK32(_CPU, _RNAME) :                       \
        RD_CSR_MASK64(_CPU, _RNAME))

// set mask to the given value using current XLEN
#define WR_CSR_MASK(_CPU, _RNAME, _VALUE) \
    if(RISCV_XLEN_IS_32(_CPU)) {                            \
        (_CPU)->csrMask._RNAME.u32.bits = _VALUE;           \
    } else {                                                \
        (_CPU)->csrMask._RNAME.u64.bits = _VALUE;           \
    }

// get CSR mask field using current XLEN
#define RD_CSR_MASK_FIELD(_CPU, _RNAME, _FIELD) \
    (RISCV_XLEN_IS_32(_CPU) ?                               \
        RD_CSR_MASK_FIELD32(_CPU, _RNAME, _FIELD) :         \
        RD_CSR_MASK_FIELD64(_CPU, _RNAME, _FIELD))

// set field mask to the given value using current XLEN
#define WR_CSR_MASK_FIELD(_CPU, _RNAME, _FIELD, _VALUE) \
    if(RISCV_XLEN_IS_32(_CPU)) {                            \
        WR_CSR_MASK_FIELD32(_CPU, _RNAME, _FIELD, _VALUE);  \
    } else {                                                \
        WR_CSR_MASK_FIELD64(_CPU, _RNAME, _FIELD, _VALUE);  \
    }


////////////////////////////////////////////////////////////////////////////////
// CSR ACCESS MACROS FOR EXTENSION-DEFINED CSRS BASED ON ON CURRENT XLEN
////////////////////////////////////////////////////////////////////////////////

// get CSR value using current XLEN
#define RD_XCSR(_OBJ, _RNAME) \
    (RISCV_XLEN_IS_32((_OBJ)->riscv) ?                      \
        (_OBJ)->csr._RNAME.u32.bits :                       \
        (_OBJ)->csr._RNAME.u64.bits)                        \

// set CSR value using current XLEN
#define WR_XCSR(_OBJ, _RNAME, _VALUE) \
    if(RISCV_XLEN_IS_32((_OBJ)->riscv)) {                   \
        (_OBJ)->csr._RNAME.u32.bits = _VALUE;               \
    } else {                                                \
        (_OBJ)->csr._RNAME.u64.bits = _VALUE;               \
    }

// set 64-bit CSR value
#define WR_XCSR64(_OBJ, _RNAME, _VALUE) \
    (_OBJ)->csr._RNAME.u64.bits = _VALUE;                   \

// get CSR field using current XLEN
#define RD_XCSR_FIELD(_OBJ, _RNAME, _FIELD) \
    (RISCV_XLEN_IS_32((_OBJ)->riscv) ?                      \
        (_OBJ)->csr._RNAME.u32.fields._FIELD :              \
        (_OBJ)->csr._RNAME.u64.fields._FIELD)               \

// set CSR field using current XLEN
#define WR_XCSR_FIELD(_OBJ, _RNAME, _FIELD, _VALUE) \
    if(RISCV_XLEN_IS_32((_OBJ)->riscv)) {                   \
        (_OBJ)->csr._RNAME.u32.fields._FIELD = _VALUE;      \
    } else {                                                \
        (_OBJ)->csr._RNAME.u64.fields._FIELD = _VALUE;      \
    }

// set CSR field when XLEN is 64
#define WR_XCSR64_FIELD(_OBJ, _RNAME, _FIELD, _VALUE) \
    if(RISCV_XLEN_IS_64((_OBJ)->riscv)) {                   \
        (_OBJ)->csr._RNAME.u64.fields._FIELD = _VALUE;      \
    }


////////////////////////////////////////////////////////////////////////////////
// CSR ACCESS MACROS FOR EXTENSION-DEFINED CSR MASKS BASED ON ON CURRENT XLEN
////////////////////////////////////////////////////////////////////////////////

// set CSR mask to the given value
#define SET_XCSR_MASK_V(_OBJ, _RNAME, _VALUE) \
    if(RISCV_XLEN_IS_32((_OBJ)->riscv)) {                   \
        (_OBJ)->csrMask._RNAME.u32.bits = _VALUE;           \
    } else {                                                \
        (_OBJ)->csrMask._RNAME.u64.bits = _VALUE;           \
    }

// get CSR mask
#define RD_XCSR_MASK(_OBJ, _RNAME) \
    (_OBJ)->csrMask._RNAME.u64.bits

// get CSR mask field using current XLEN
#define RD_XCSR_MASK_FIELD(_OBJ, _RNAME, _FIELD) \
    (RISCV_XLEN_IS_32((_OBJ)->riscv) ?                      \
        (_OBJ)->csrMask._RNAME.u32.fields._FIELD :          \
        (_OBJ)->csrMask._RNAME.u64.fields._FIELD)

// mask CSR using variable mask
#define MASK_XCSR(_OBJ, _RNAME) \
    (_OBJ)->csr._RNAME.u64.bits &= (_OBJ)->csrMask._RNAME.u64.bits


////////////////////////////////////////////////////////////////////////////////
// MORPH-TIME CSR ACCESS MACROS
////////////////////////////////////////////////////////////////////////////////

//
// Morph-time macros to access a CSR register by id
//
#define XCSR_REG_MT(_ID)    EXT_REG(csr._ID)
#define XCSR_REG64H_MT(_ID) EXT_REGH(csr._ID)

//
// Morph-time macros to access a CSR register mask by id
//
#define XCSR_MASK_MT(_ID)   EXT_REG(csrMask._ID)


////////////////////////////////////////////////////////////////////////////////
// ADDRESS TRANSLATION SUPPORT TYPES
////////////////////////////////////////////////////////////////////////////////

//
// Address mapping to store in a TLB
//
typedef struct riscvExtVMMappingS {
    Uns64   lowVA;          // low VA
    Uns64   highVA;         // high VA
    Uns64   PA;             // low PA
    Uns16   entryId : 16;   // custom unique identifier
    memPriv priv    :  8;   // access privileges
    Bool    V       :  1;   // valid bit
    Bool    U       :  1;   // User-mode access
    Bool    G       :  1;   // global entry
    Bool    A       :  1;   // accessed
    Bool    D       :  1;   // dirty
} riscvExtVMMapping;
