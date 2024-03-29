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
#include "vmi/vmiDbg.h"
#include "vmi/vmiTypes.h"

// model header files
#include "riscvFeatures.h"
#include "riscvMode.h"
#include "riscvRegisters.h"
#include "riscvTypeRefs.h"
#include "riscvTypes.h"
#include "riscvVariant.h"


////////////////////////////////////////////////////////////////////////////////
// CSR ENUMERATION
////////////////////////////////////////////////////////////////////////////////

//
// Construct enumeration member name from register name
//
#define CSR_ID(_R) CSR_ID_##_R

//
// Construct enumeration member names from the given base and indices 0..9
//
#define CSR_ID_0_9(_R) \
    CSR_ID(_R##0),      \
    CSR_ID(_R##1),      \
    CSR_ID(_R##2),      \
    CSR_ID(_R##3),      \
    CSR_ID(_R##4),      \
    CSR_ID(_R##5),      \
    CSR_ID(_R##6),      \
    CSR_ID(_R##7),      \
    CSR_ID(_R##8),      \
    CSR_ID(_R##9)

//
// Construct enumeration member names from the given base and indices 3..31
//
#define CSR_ID_3_31(_R) \
    CSR_ID(_R##3),      \
    CSR_ID(_R##4),      \
    CSR_ID(_R##5),      \
    CSR_ID(_R##6),      \
    CSR_ID(_R##7),      \
    CSR_ID(_R##8),      \
    CSR_ID(_R##9),      \
    CSR_ID_0_9(_R##1),  \
    CSR_ID_0_9(_R##2),  \
    CSR_ID(_R##30),     \
    CSR_ID(_R##31)

//
// Construct enumeration member names from the given base and indices 0..3
//
#define CSR_ID_0_3(_R) \
    CSR_ID(_R##0),      \
    CSR_ID(_R##1),      \
    CSR_ID(_R##2),      \
    CSR_ID(_R##3)

//
// Construct enumeration member names from the given base and indices 0..3 + h
//
#define CSR_ID_0_3H(_R) \
    CSR_ID(_R##0##h),   \
    CSR_ID(_R##1##h),   \
    CSR_ID(_R##2##h),   \
    CSR_ID(_R##3##h)

//
// Construct enumeration member names from the given base and indices 0..15
//
#define CSR_ID_0_15(_R) \
    CSR_ID_0_9(_R),     \
    CSR_ID(_R##10),     \
    CSR_ID(_R##11),     \
    CSR_ID(_R##12),     \
    CSR_ID(_R##13),     \
    CSR_ID(_R##14),     \
    CSR_ID(_R##15)

//
// Construct enumeration member names from the given base and indices 0..63
//
#define CSR_ID_0_63(_R) \
    CSR_ID_0_9(_R),     \
    CSR_ID_0_9(_R##1),  \
    CSR_ID_0_9(_R##2),  \
    CSR_ID_0_9(_R##3),  \
    CSR_ID_0_9(_R##4),  \
    CSR_ID_0_9(_R##5),  \
    CSR_ID(_R##60),     \
    CSR_ID(_R##61),     \
    CSR_ID(_R##62),     \
    CSR_ID(_R##63)

//
// Identifiers for each implemented CSR
//
typedef enum riscvCSRIdE {

    CSR_ID      (ustatus),      // 0x000
    CSR_ID      (fflags),       // 0x001
    CSR_ID      (frm),          // 0x002
    CSR_ID      (fcsr),         // 0x003
    CSR_ID      (uie),          // 0x004
    CSR_ID      (utvec),        // 0x005
    CSR_ID      (utvt),         // 0x007
    CSR_ID      (vstart),       // 0x008
    CSR_ID      (vxsat),        // 0x009
    CSR_ID      (vxrm),         // 0x00A
    CSR_ID      (vcsr),         // 0x00F
    CSR_ID      (seed),         // 0x015
    CSR_ID      (jvt701),       // 0x017
    CSR_ID      (jvt705),       // 0x017
    CSR_ID      (uscratch),     // 0x040
    CSR_ID      (uepc),         // 0x041
    CSR_ID      (ucause),       // 0x042
    CSR_ID      (utval),        // 0x043
    CSR_ID      (uip),          // 0x044
    CSR_ID      (unxti),        // 0x045
    CSR_ID      (uintstatusRW), // 0x046
    CSR_ID      (uintstatusR1), // 0xC46
    CSR_ID      (uintstatusR2), // 0xCB1
    CSR_ID      (uintthresh),   // 0x047
    CSR_ID      (uscratchcswl), // 0x049

    CSR_ID      (tbljalvec),    // 0x800
    CSR_ID      (ucode),        // 0x801
    CSR_ID      (cycle),        // 0xC00
    CSR_ID      (time),         // 0xC01
    CSR_ID      (instret),      // 0xC02
    CSR_ID_3_31 (hpmcounter),   // 0xC03-0xC1F
    CSR_ID      (vl),           // 0xC20
    CSR_ID      (vtype),        // 0xC21
    CSR_ID      (vlenb),        // 0xC22
    CSR_ID      (cycleh),       // 0xC80
    CSR_ID      (timeh),        // 0xC80
    CSR_ID      (instreth),     // 0xC80
    CSR_ID_3_31 (hpmcounterh),  // 0xC83-0xC9F

    CSR_ID      (sstatus),      // 0x100
    CSR_ID      (sedeleg),      // 0x102
    CSR_ID      (sideleg),      // 0x103
    CSR_ID      (sie),          // 0x104
    CSR_ID      (stvec),        // 0x105
    CSR_ID      (scounteren),   // 0x106
    CSR_ID      (stvt),         // 0x107
    CSR_ID      (senvcfg),      // 0x10A
    CSR_ID_0_3  (sstateen),     // 0x10C-0x10F
    CSR_ID      (sieh),         // 0x114
    CSR_ID      (sscratch),     // 0x140
    CSR_ID      (sepc),         // 0x141
    CSR_ID      (scause),       // 0x142
    CSR_ID      (stval),        // 0x143
    CSR_ID      (sip),          // 0x144
    CSR_ID      (snxti),        // 0x145
    CSR_ID      (sintstatusRW), // 0x146
    CSR_ID      (sintstatusR1), // 0xD46
    CSR_ID      (sintstatusR2), // 0xDB1
    CSR_ID      (sintthresh),   // 0x147
    CSR_ID      (sscratchcsw),  // 0x148
    CSR_ID      (sscratchcswl), // 0x149
    CSR_ID      (stimecmp),     // 0x14D
    CSR_ID      (siselect),     // 0x150
    CSR_ID      (sireg),        // 0x151
    CSR_ID      (siph),         // 0x154
    CSR_ID      (stopei),       // 0x15C
    CSR_ID      (stimecmph),    // 0x15D
    CSR_ID      (stopi),        // 0xDB0
    CSR_ID      (satp),         // 0x180
#if(ENABLE_SSMPU)
    CSR_ID_0_15 (mpucfg),       // 0x1A0-0x1AF
    CSR_ID_0_63 (mpuaddr),      // 0x1B0-0x1EF
#endif
    CSR_ID      (sentropyA),    // 0xDBF
    CSR_ID      (sentropyB),    // 0x546

    CSR_ID      (hstatus),      // 0x600
    CSR_ID      (hedeleg),      // 0x602
    CSR_ID      (hideleg),      // 0x603
    CSR_ID      (hie),          // 0x604
    CSR_ID      (htimedelta),   // 0x605
    CSR_ID      (hcounteren),   // 0x606
    CSR_ID      (hgeie),        // 0x607
    CSR_ID      (hvien),        // 0x608
    CSR_ID      (hvictl),       // 0x609
    CSR_ID      (henvcfg),      // 0x60A
    CSR_ID_0_3  (hstateen),     // 0x60C-0x60F
    CSR_ID      (hidelegh),     // 0x613
    CSR_ID      (hvienh),       // 0x618
    CSR_ID      (henvcfgh),     // 0x61A
    CSR_ID_0_3H (hstateen),     // 0x61C-0x61F
    CSR_ID      (htimedeltah),  // 0x615
    CSR_ID      (htval),        // 0x643
    CSR_ID      (hip),          // 0x644
    CSR_ID      (hvip),         // 0x645
    CSR_ID      (hviprio1),     // 0x646
    CSR_ID      (hviprio2),     // 0x647
    CSR_ID      (htinst),       // 0x64A
    CSR_ID      (hviph),        // 0x655
    CSR_ID      (hviprio1h),    // 0x656
    CSR_ID      (hviprio2h),    // 0x657
    CSR_ID      (hgeip),        // 0xE12
    CSR_ID      (hgatp),        // 0x680

    CSR_ID      (vsstatus),     // 0x200
    CSR_ID      (vsie),         // 0x204
    CSR_ID      (vstvec),       // 0x205
    CSR_ID      (vsieh),        // 0x214
    CSR_ID      (vsscratch),    // 0x240
    CSR_ID      (vsepc),        // 0x241
    CSR_ID      (vscause),      // 0x242
    CSR_ID      (vstval),       // 0x243
    CSR_ID      (vsip),         // 0x244
    CSR_ID      (vsscratchcsw), // 0x248 (assumed, if CLIC+H supported)
    CSR_ID      (vsscratchcswl),// 0x249 (assumed, if CLIC+H supported)
    CSR_ID      (vstimecmp),    // 0x24D
    CSR_ID      (vsiselect),    // 0x250
    CSR_ID      (vsireg),       // 0x251
    CSR_ID      (vsiph),        // 0x254
    CSR_ID      (vstopei),      // 0x25C
    CSR_ID      (vstimecmph),   // 0x25D
    CSR_ID      (vstopi),       // 0xEB0
    CSR_ID      (vsatp),        // 0x280

    CSR_ID      (mvendorid),    // 0xF11
    CSR_ID      (marchid),      // 0xF12
    CSR_ID      (mimpid),       // 0xF13
    CSR_ID      (mhartid),      // 0xF14
    CSR_ID      (mconfigptr),   // 0xF15
    CSR_ID      (mentropy),     // 0xF15 (legacy, conflicts with mconfigptr)
    CSR_ID      (mstatus),      // 0x300
    CSR_ID      (misa),         // 0x301
    CSR_ID      (medeleg),      // 0x302
    CSR_ID      (mideleg),      // 0x303
    CSR_ID      (mie),          // 0x304
    CSR_ID      (mtvec),        // 0x305
    CSR_ID      (mcounteren),   // 0x306
    CSR_ID      (mtvt),         // 0x307
    CSR_ID      (mvien),        // 0x308
    CSR_ID      (mvip),         // 0x309
    CSR_ID      (menvcfg),      // 0x30A
    CSR_ID_0_3  (mstateen),     // 0x30C-0x30F
    CSR_ID      (mstatush),     // 0x310
    CSR_ID      (midelegh),     // 0x313
    CSR_ID      (mieh),         // 0x314
    CSR_ID      (mvienh),       // 0x318
    CSR_ID      (mviph),        // 0x319
    CSR_ID      (menvcfgh),     // 0x31A
    CSR_ID_0_3H (mstateen),     // 0x31C-0x31F
    CSR_ID      (mcountinhibit),// 0x320
    CSR_ID      (mscratch),     // 0x340
    CSR_ID      (mepc),         // 0x341
    CSR_ID      (mcause),       // 0x342
    CSR_ID      (mtval),        // 0x343
    CSR_ID      (mip),          // 0x344
    CSR_ID      (mnxti),        // 0x345
    CSR_ID      (mintstatusRW), // 0x346
    CSR_ID      (mintstatusR1), // 0xF46
    CSR_ID      (mintstatusR2), // 0xFB1
    CSR_ID      (mintthresh),   // 0x347
    CSR_ID      (mscratchcsw),  // 0x348
    CSR_ID      (mscratchcswl), // 0x349
    CSR_ID      (mtinst),       // 0x34A
    CSR_ID      (mclicbase),    // 0x34B
    CSR_ID      (mtval2),       // 0x34B
    CSR_ID      (miselect),     // 0x350
    CSR_ID      (mnscratch21),  // 0x350
    CSR_ID      (mireg),        // 0x351
    CSR_ID      (mnepc21),      // 0x351
    CSR_ID      (mncause21),    // 0x352
    CSR_ID      (mnstatus21),   // 0x353
    CSR_ID      (miph),         // 0x354
    CSR_ID      (mtopei),       // 0x35C
    CSR_ID      (mtopi),        // 0xFB0
    CSR_ID_0_15 (pmpcfg),       // 0x3A0-0x3AF
    CSR_ID_0_63 (pmpaddr),      // 0x3B0-0x3EF
    CSR_ID      (mnscratch4),   // 0x740
    CSR_ID      (mnepc4),       // 0x741
    CSR_ID      (mncause4),     // 0x742
    CSR_ID      (mnstatus4),    // 0x744
    CSR_ID      (mseccfg),      // 0x747
    CSR_ID      (mseccfgh),     // 0x757
    CSR_ID      (mcycle),       // 0xB00
    CSR_ID      (minstret),     // 0xB02
    CSR_ID_3_31 (mhpmcounter),  // 0xB03-0xB1F
    CSR_ID      (mcycleh),      // 0xB80
    CSR_ID      (minstreth),    // 0xB82
    CSR_ID_3_31 (mhpmcounterh), // 0xB83-0xB9F
    CSR_ID_3_31 (mhpmevent),    // 0x323-0x33F

    CSR_ID      (tselect),      // 0x7A0
    CSR_ID      (tdata1),       // 0x7A1
    CSR_ID      (tdata2),       // 0x7A2
    CSR_ID      (tdata3),       // 0x7A3
    CSR_ID      (tinfo),        // 0x7A4
    CSR_ID      (tcontrol),     // 0x7A5
    CSR_ID      (mcontext),     // 0x7A8
    CSR_ID      (mnoise),       // 0x7A9
    CSR_ID      (mscontext),    // 0x7AA
    CSR_ID      (scontext13),   // 0x5A8
    CSR_ID      (scontext14),   // 0x5A8
    CSR_ID      (hcontext),     // 0x6A8

    CSR_ID      (dcsr),         // 0x7B0
    CSR_ID      (dpc),          // 0x7B1
    CSR_ID      (dscratch0),    // 0x7B2
    CSR_ID      (dscratch1),    // 0x7B3

    // keep last (used to define size of the enumeration)
    CSR_ID      (LAST)

} riscvCSRId;

//
// CSRs in this range are accessible only in debug mode
//
#define CSR_DEGUG_START     0x7B0
#define CSR_DEGUG_END       0x7BF
#define IS_DEBUG_CSR(_NUM)  (((_NUM)>=CSR_DEGUG_START) && ((_NUM)<=CSR_DEGUG_END))


////////////////////////////////////////////////////////////////////////////////
// INITIALIZATION
////////////////////////////////////////////////////////////////////////////////

//
// Initialize CSR state
//
void riscvCSRInit(riscvP riscv);

//
// Add CSR commands
//
void riscvAddCSRCommands(riscvP riscv);

//
// Free CSR state
//
void riscvCSRFree(riscvP riscv);

//
// Reset CSR state
//
void riscvCSRReset(riscvP riscv);

//
// Allocate CSR remap list
//
void riscvNewCSRRemaps(riscvP riscv, const char *remaps);


////////////////////////////////////////////////////////////////////////////////
// DISASSEMBLER INTERFACE ACCESS FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Return CSR name for the given index number (or NULL if undefined)
//
const char *riscvGetCSRName(riscvP riscv, Uns32 csrNum);


////////////////////////////////////////////////////////////////////////////////
// DEBUG INTERFACE ACCESS FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Read a CSR given its id
//
Bool riscvReadCSR(riscvCSRAttrsCP attrs, riscvP riscv, void *buffer);

//
// Write a CSR given its id
//
Bool riscvWriteCSR(riscvCSRAttrsCP attrs, riscvP riscv, const void *buffer);


////////////////////////////////////////////////////////////////////////////////
// LINKED MODEL ACCESS FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Read a CSR in the model given its number
//
Uns64 riscvReadCSRNum(riscvP riscv, Uns32 csrNum);

//
// Write a CSR in the model given its number
//
Uns64 riscvWriteCSRNum(riscvP riscv, riscvCSRId csrNum, Uns64 newValue);

//
// Read a CSR in the base model given its id
//
Uns64 riscvReadBaseCSR(riscvP riscv, riscvCSRId id);

//
// Write a CSR in the base model given its id
//
Uns64 riscvWriteBaseCSR(riscvP riscv, riscvCSRId id, Uns64 newValue);


////////////////////////////////////////////////////////////////////////////////
// MORPH-TIME INTERFACE ACCESS FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Validate CSR with the given index can be accessed for read or write in the
// current processor mode, and return either a true CSR id or an error code id
//
riscvCSRAttrsCP riscvValidateCSRAccess(
    riscvP riscv,
    Uns32  csrNum,
    Bool   read,
    Bool   write
);

//
// Emit code to read a CSR
//
void riscvEmitCSRRead(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    vmiReg          rd,
    Bool            isWrite
);

//
// Emit code to write a CSR
//
void riscvEmitCSRWrite(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    vmiReg          rd,
    vmiReg          rs,
    vmiReg          tmp
);


////////////////////////////////////////////////////////////////////////////////
// CSR ITERATOR AND REGISTRATION
////////////////////////////////////////////////////////////////////////////////

//
// Structure filled with CSR register details by riscvGetCSRDetails
//
typedef struct riscvCSRDetailsS {
    riscvCSRAttrsCP attrs;
    riscvMode       mode;
    Uns8            bits;
    Bool            rdRaw;
    Bool            wrRaw;
    Bool            extension;
    vmiReg          raw;
    vmiRegAccess    access;
} riscvCSRDetails, *riscvCSRDetailsP;

//
// Iterator filling 'details' with the next CSR register details. The value
// pointed to by 'csrNumP' should be initialized to zero prior to the first call
// and is used by this function to manage the iteration.
//
Bool riscvGetCSRDetails(
    riscvP           riscv,
    riscvCSRDetailsP details,
    Uns32           *csrNumP
);

//
// Register new externally-implemented CSR
//
void riscvNewCSR(
    riscvCSRAttrsP  attrs,
    riscvCSRAttrsCP src,
    riscvP          riscv,
    vmiosObjectP    object
);


////////////////////////////////////////////////////////////////////////////////
// CSR BUS SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Is the CSR implemented externally for read?
//
// NOTE: if this is a CSR with read/write semantics but only *read* access is
// externally implemented then:
//
// 1. For true accesses (csrr) the *external* CSR value should be returned;
// 2. For artifact accesses (trace, debug interface read/write) the *internal*
//    CSR value should be returned.
//
// This allows a test harness to inject a volatile apparent value for a CSR when
// it is read without affecting the underlying model behavior in any other way.
//
// Parameter 'rwOnly' indicates whether the external callback should be used
// only if both read and write callbacks are specified
//
Bool riscvCSRImplementExternalRead(
    riscvCSRAttrsCP attrs,
    riscvP          riscv,
    Bool            rwOnly
);

//
// Is the CSR implemented externally for write?
//
Bool riscvCSRImplementExternalWrite(riscvCSRAttrsCP attrs, riscvP riscv);


////////////////////////////////////////////////////////////////////////////////
// COUNTER / TIMER ACCESS VALIDITY
////////////////////////////////////////////////////////////////////////////////

//
// Return a Boolean indicating if an access to the indicated Performance
// Monitor register is valid (and take an Undefined Instruction or Virtual
// Instruction trap if not)
//
Bool riscvHPMAccessValid(riscvCSRAttrsCP attrs, riscvP riscv);


////////////////////////////////////////////////////////////////////////////////
// COUNTER INHIBIT
////////////////////////////////////////////////////////////////////////////////

//
// Structure used when updating state when inhibit values change
//
typedef struct riscvCountStateS {
    Bool  inhibitCycle;     // old value of cycle count inhibit
    Bool  inhibitInstret;   // old value of retired instruction inhibit
    Uns64 cycle;            // cycle count before update
    Uns64 instret;          // retired instruction count before update
} riscvCountState, *riscvCountStateP;

//
// Get state before possible inhibit update
//
void riscvPreInhibit(riscvP riscv, riscvCountStateP state);

//
// Update state after possible inhibit update
//
void riscvPostInhibit(riscvP riscv, riscvCountStateP state, Bool preIncrement);

//
// Is cycle count inhibited?
//
Bool riscvInhibitCycle(riscvP riscv);

//
// Is retired instruction count inhibited?
//
Bool riscvInhibitInstret(riscvP riscv);

//
// Indicate that any executing instruction will not retire
//
void riscvNoRetire(riscvP riscv);


////////////////////////////////////////////////////////////////////////////////
// STATEEN SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Return a Boolean indicating if an access in the current mode to a feature
// enabled by the given xstateen bit is valid (and optionally take an Undefined
// Instruction or Virtual Instruction trap if not)
//
Bool riscvStateenFeatureEnabled(riscvP riscv, Uns32 bit, Bool trap);


////////////////////////////////////////////////////////////////////////////////
// SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Save CSR state not covered by register read/write API
//
void riscvCSRSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
);

//
// Restore CSR state not covered by register read/write API
//
void riscvCSRRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
);


////////////////////////////////////////////////////////////////////////////////
// POLYMORPHIC VECTOR BLOCK CONTROL
////////////////////////////////////////////////////////////////////////////////

//
// Refresh the vector polymorphic block key
//
void riscvRefreshVectorPMKey(riscvP riscv);

//
// Update vtype CSR
//
void riscvSetVType(riscvP riscv, Bool vill, riscvVType vtype);

//
// Update vl CSR and aliases of it for the given vtype
//
Bool riscvSetVLForVType(riscvP riscv, Uns64 vl, riscvVType vtype);

//
// Update vl CSR and aliases of it for the current vtype
//
void riscvSetVL(riscvP riscv, Uns64 vl);


////////////////////////////////////////////////////////////////////////////////
// FLAG MANAGEMENT
////////////////////////////////////////////////////////////////////////////////

//
// Consolidate floating point and fixed point flags on CSR view
//
void riscvConsolidateFPFlags(riscvP riscv);


////////////////////////////////////////////////////////////////////////////////
// DCSR MODE
////////////////////////////////////////////////////////////////////////////////

//
// Return the mode encoded in DCSR
//
riscvMode riscvGetDCSRMode(riscvP riscv);

//
// Set the mode encoded in DCSR
//
void riscvSetDCSRMode(riscvP riscv, riscvMode mode);


////////////////////////////////////////////////////////////////////////////////
// REGISTER DEFINITIONS
////////////////////////////////////////////////////////////////////////////////

//
// Use this to declare a 32-bit register type name
//
#define CSR_REG_TYPE_32(_N) riscvCSR32_##_N

//
// Use this to declare a 64-bit register type name
//
#define CSR_REG_TYPE_64(_N) riscvCSR64_##_N

//
// Use this to declare a register type name
//
#define CSR_REG_TYPE(_N)    riscvCSR_##_N

//
// Use this to declare a register with 32-bit view only (zero-extended to 64)
//
#define CSR_REG_STRUCT_DECL_32(_N) typedef union { \
    Uns64                   _pad;       \
    union {                             \
        Uns32               bits;       \
        CSR_REG_TYPE_32(_N) fields;     \
    } u32;                              \
    union {                             \
        Uns32               bits;       \
        CSR_REG_TYPE_32(_N) fields;     \
    } u64;                              \
} CSR_REG_TYPE(_N)

//
// Use this to declare a register with 32-bit view equivalent to lower half of
// 64-bit view
//
#define CSR_REG_STRUCT_DECL_64(_N) typedef union { \
    Uns64                   _pad;       \
    union {                             \
        Uns32               bits;       \
        CSR_REG_TYPE_64(_N) fields;     \
    } u32;                              \
    union {                             \
        Uns64               bits;       \
        CSR_REG_TYPE_64(_N) fields;     \
    } u64;                              \
} CSR_REG_TYPE(_N)

//
// Use this to declare a register with distinct 32/64 bit views
//
#define CSR_REG_STRUCT_DECL_32_64(_N) typedef union { \
    Uns64                   _pad;       \
    union {                             \
        Uns32               bits;       \
        CSR_REG_TYPE_32(_N) fields;     \
    } u32;                              \
    union {                             \
        Uns64               bits;       \
        CSR_REG_TYPE_64(_N) fields;     \
    } u64;                              \
} CSR_REG_TYPE(_N)


// -----------------------------------------------------------------------------
// generic 32-bit register
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 value;
} CSR_REG_TYPE_32(generic32);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(generic32);

// -----------------------------------------------------------------------------
// generic XLEN-width register
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns64 value;
} CSR_REG_TYPE_64(genericXLEN);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_64(genericXLEN);

// -----------------------------------------------------------------------------
// ustatus      (id 0x000)
// sstatus      (id 0x100)
// vsstatus     (id 0x200)
// mstatus      (id 0x300)
// mstatush     (id 0x310)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 UIE  : 1;         // User mode interrupt enable, N only
    Uns32 SIE  : 1;         // Supervisor mode interrupt enable
    Uns32 _u0  : 1;
    Uns32 MIE  : 1;         // Machine mode interrupt enable
    Uns32 UPIE : 1;         // User mode interrupt enable (stacked), N only
    Uns32 SPIE : 1;         // Supervisor mode interrupt enable (stacked)
    Uns32 UBE  : 1;         // User mode big-endian
    Uns32 MPIE : 1;         // Machine mode interrupt enable (stacked)
    Uns32 SPP  : 1;         // Supervisor previous mode
    Uns32 VS_9 : 2;         // Vector Extension dirty state (version 0.9)
    Uns32 MPP  : 2;         // Machine previous mode
    Uns32 FS   : 2;         // Floating point dirty state
    Uns32 XS   : 2;         // User extension dirty state
    Uns32 MPRV : 1;         // Modify privilege (requires U extension)
    Uns32 SUM  : 1;         // Permit Supervisor User access (requires S extension)
    Uns32 MXR  : 1;         // Make executable readable (requires S extension)
    Uns32 TVM  : 1;         // Trap virtual memory (requires S extension)
    Uns32 TW   : 1;         // Timeout wait (requires S extension)
    Uns32 TSR  : 1;         // Trap SRET (requires S extension)
    Uns32 VS_8 : 2;         // Vector Extension dirty state (version 0.8)
    Uns32 _u3  : 6;
    Uns32 SD   : 1;         // Dirty state summary bit (read only)
} CSR_REG_TYPE_32(status);

// 64-bit view
typedef struct {
    Uns64 UIE  :  1;        // User mode interrupt enable, N only
    Uns64 SIE  :  1;        // Supervisor mode interrupt enable
    Uns64 _u0  :  1;
    Uns64 MIE  :  1;        // Machine mode interrupt enable
    Uns64 UPIE :  1;        // User mode interrupt enable (stacked), N only
    Uns64 SPIE :  1;        // Supervisor mode interrupt enable (stacked)
    Uns64 UBE  :  1;        // User mode big-endian
    Uns64 MPIE :  1;        // Machine mode interrupt enable (stacked)
    Uns64 SPP  :  1;        // Supervisor previous mode
    Uns32 VS_9 :  2;        // Vector Extension dirty state (version 0.9)
    Uns64 MPP  :  2;        // Machine previous mode
    Uns64 FS   :  2;        // Floating point dirty state
    Uns64 XS   :  2;        // User extension dirty state
    Uns64 MPRV :  1;        // Modify privilege (requires U extension)
    Uns64 SUM  :  1;        // Permit Supervisor User access (requires S extension)
    Uns64 MXR  :  1;        // Make executable readable (requires S extension)
    Uns64 TVM  :  1;        // Trap virtual memory (requires S extension)
    Uns64 TW   :  1;        // Timeout wait (requires S extension)
    Uns64 TSR  :  1;        // Trap SRET (requires S extension)
    Uns32 VS_8 :  2;        // Vector Extension dirty state (version 0.8)
    Uns64 _u3  :  7;
    Uns64 UXL  :  2;        // User mode XLEN
    Uns64 SXL  :  2;        // Supervisor mode XLEN
    Uns64 SBE  :  1;        // Supervisor mode big-endian
    Uns64 MBE  :  1;        // Machine mode big-endian
    Uns64 GVA  :  1;        // Guest virtual address
    Uns64 MPV  :  1;        // Machine previous virtualization mode
    Uns64 _u4  : 23;
    Uns64 SD   :  1;        // Dirty state summary bit (read only)
} CSR_REG_TYPE_64(status);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32_64(status);

// define alias types
typedef CSR_REG_TYPE(status) CSR_REG_TYPE(ustatus);
typedef CSR_REG_TYPE(status) CSR_REG_TYPE(sstatus);
typedef CSR_REG_TYPE(status) CSR_REG_TYPE(mstatus);
typedef CSR_REG_TYPE(status) CSR_REG_TYPE(vsstatus);

// define alias masks (include sstatus.VS field in both 0.8 and 0.9 positions)
#define sstatus_AMASK 0x80000003818de773ULL
#define ustatus_AMASK 0x0000000000000011ULL

// define bit masks
#define WM_mstatus_MPP  (3<<11)
#define WM_mstatus_FS   (3<<13)
#define WM_mstatus_TVM  (1<<20)
#define WM_mstatus_TW   (1<<21)
#define WM_mstatus_TSR  (1<<22)
#define WM_mstatus_VS_8 (3<<23)
#define WM_mstatus_VS_9 (3<<9)
#define WM_mstatus_IE   0xf
#define WM_mstatus_UBE  (1<<6)
#define WM_mstatus_SBE  (1ULL<<36)
#define WM_mstatus_MBE  (1ULL<<37)
#define WM_mstatus_BE   (WM_mstatus_UBE|WM_mstatus_SBE|WM_mstatus_MBE)
#define WM_mstatus_UXL  (3ULL<<32)
#define WM_mstatus_SXL  (3ULL<<34)
#define WM_mstatus_XL   (WM_mstatus_UXL|WM_mstatus_SXL)
#define WM_mstatus_GVA  (1ULL<<38)
#define WM_mstatus_MPV  (1ULL<<39)

// define write masks for reset (note RV32 includes mstatush.{MBE,SBE}
#define WM32_mstatus_reset (0xffffffff | WM_mstatus_MBE | WM_mstatus_SBE)
#define WM64_mstatus_reset 0xffffffffffffffffULL


// -----------------------------------------------------------------------------
// mnstatus     (id 0x744)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 _u1  : 3;
    Uns32 NMIE : 1;         // NMI enable
    Uns32 _u2  : 3;
    Uns32 MNPV : 1;         // NMI previous virtualization mode
    Uns32 _u3  : 3;
    Uns32 MNPP : 2;         // NMI previous mode
    Uns32 _u4  : 19;
} CSR_REG_TYPE_32(mnstatus);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32(mnstatus);

// define bit masks
#define WM_mnstatus_NMIE (1<<3)

// -----------------------------------------------------------------------------
// senvcfg      (id 0x10A)
// menvcfg      (id 0x30A)
// menvcfgh     (id 0x31A)
// henvcfg      (id 0x60A)
// henvcfgh     (id 0x61A)
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns64 FIOM  :  1;       // Fence of I/O implies Memory
    Uns64 _u1   :  3;
    Uns64 CBIE  :  2;       // Zicbom custom field
    Uns64 CBCFE :  1;       // Zicbom custom field
    Uns64 CBZE  :  1;       // Zicboz custom field
    Uns64 _u2   : 54;
    Uns64 PBMTE :  1;       // Svpbmt custom field
    Uns64 STCE  :  1;       // Sstc custom field
} CSR_REG_TYPE_64(envcfg);

// define 64 bit type
CSR_REG_STRUCT_DECL_64(envcfg);

// define alias types
typedef CSR_REG_TYPE(envcfg) CSR_REG_TYPE(menvcfg);
typedef CSR_REG_TYPE(envcfg) CSR_REG_TYPE(henvcfg);
typedef CSR_REG_TYPE(envcfg) CSR_REG_TYPE(senvcfg);

// define write masks and field shifts
#define shift_envcfg_FIOM  0
#define shift_envcfg_CBIE  4
#define shift_envcfg_CBCFE 6
#define shift_envcfg_CBZE  7
#define shift_envcfg_PBMTE 62
#define shift_envcfg_STCE  63

// -----------------------------------------------------------------------------
// sstateen0-sstateen3 (id 0x10C-0x10F)
// mstateen0-mstateen3 (id 0x30C-0x30F)
// hstateen0-hstateen3 (id 0x60C-0x60F)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(sstateen);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mstateen);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(hstateen);

// -----------------------------------------------------------------------------
// hstatus      (id 0x600)
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns64 _u1   :  5;
    Uns64 VSBE  :  1;       // VS mode big-endian
    Uns64 GVA   :  1;       // Guest virtual address
    Uns64 SPV   :  1;       // Supervisor previous virtualization mode
    Uns64 SPVP  :  1;       // Supervisor previous virtual privilege
    Uns64 HU    :  1;       // Hypervisor user mode
    Uns64 _u2   :  2;
    Uns64 VGEIN :  6;       // Virtual guest external interrupt number
    Uns64 _u3   :  2;
    Uns64 VTVM  :  1;       // Trap virtual memory
    Uns64 VTW   :  1;       // Timeout wait
    Uns64 VTSR  :  1;       // Trap SRET
    Uns64 _u4   :  9;
    Uns64 VSXL  :  2;       // VS mode XLEN
    Uns64 _u5   : 30;
} CSR_REG_TYPE_64(hstatus);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_64(hstatus);

// define write masks
#define WM_hstatus 0x007003c0

// define bit masks
#define WM_hstatus_VSBE (1<<5)
#define WM_hstatus_SPV  (1<<7)
#define WM_hstatus_HU   (1<<9)
#define WM_hstatus_TW   (1<<21)

// -----------------------------------------------------------------------------
// fflags       (id 0x001)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 NX  :  1;
    Uns32 UF  :  1;
    Uns32 OF  :  1;
    Uns32 DZ  :  1;
    Uns32 NV  :  1;
    Uns32 _u0 : 27;
} CSR_REG_TYPE_32(fflags);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(fflags);

// define write masks
#define WM32_fflags 0x1f

// -----------------------------------------------------------------------------
// frm          (id 0x002)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 frm :  3;
    Uns32 _u0 : 29;
} CSR_REG_TYPE_32(frm);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(frm);

// define write masks
#define WM32_frm 0x7

// -----------------------------------------------------------------------------
// fcsr         (id 0x003)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 NX    :  1;
    Uns32 UF    :  1;
    Uns32 OF    :  1;
    Uns32 DZ    :  1;
    Uns32 NV    :  1;
    Uns32 frm   :  3;
    Uns32 vxsat :  1;   // Vector Version 0.8 only
    Uns32 vxrm  :  2;   // Vector Version 0.8 only
    Uns32 _u0   : 21;
} CSR_REG_TYPE_32(fcsr);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(fcsr);

// define write masks
#define WM32_fcsr_f       0x0ff
#define WM32_fcsr_v       0x700
#define WM32_fcsr_frm_msb 0x080

// -----------------------------------------------------------------------------
// misa         (id 0x301)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns64 Extensions : 26;
    Uns64 _u1        :  4;
    Uns64  MXL       :  2;
} CSR_REG_TYPE_32(isa);

// 64-bit view
typedef struct {
    Uns64 Extensions : 26;
    Uns64 _u1        : 36;
    Uns64  MXL       :  2;
} CSR_REG_TYPE_64(isa);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32_64(isa);

// define alias types
typedef CSR_REG_TYPE(isa) CSR_REG_TYPE(misa);

// -----------------------------------------------------------------------------
// sedeleg      (id 0x102)
// hedeleg      (id 0x602)
// medeleg      (id 0x302)
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns64 SynchronousExceptions;
} CSR_REG_TYPE_64(edeleg);

// define 32 bit type
CSR_REG_STRUCT_DECL_64(edeleg);

// define alias types
typedef CSR_REG_TYPE(edeleg) CSR_REG_TYPE(sedeleg);
typedef CSR_REG_TYPE(edeleg) CSR_REG_TYPE(hedeleg);
typedef CSR_REG_TYPE(edeleg) CSR_REG_TYPE(medeleg);

// -----------------------------------------------------------------------------
// sideleg      (id 0x103)
// hideleg      (id 0x603)
// mideleg      (id 0x303)
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns64 Interrupts;
} CSR_REG_TYPE_64(ideleg);

// define 32 bit type
CSR_REG_STRUCT_DECL_64(ideleg);

// define alias types
typedef CSR_REG_TYPE(ideleg) CSR_REG_TYPE(sideleg);
typedef CSR_REG_TYPE(ideleg) CSR_REG_TYPE(hideleg);
typedef CSR_REG_TYPE(ideleg) CSR_REG_TYPE(mideleg);

// -----------------------------------------------------------------------------
// uie          (id 0x004)
// sie          (id 0x104)
// vsie         (id 0x204)
// hie          (id 0x604)
// mie          (id 0x304)
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns32 USIE  : 1;
    Uns32 SSIE  : 1;
    Uns32 VSSIE : 1;
    Uns32 MSIE  : 1;
    Uns32 UTIE  : 1;
    Uns32 STIE  : 1;
    Uns32 VSTIE : 1;
    Uns32 MTIE  : 1;
    Uns32 UEIE  : 1;
    Uns32 SEIE  : 1;
    Uns32 VSEIE : 1;
    Uns32 MEIE  : 1;
} CSR_REG_TYPE_64(ie);

// define 64 bit type
CSR_REG_STRUCT_DECL_64(ie);

// define alias types
typedef CSR_REG_TYPE(ie) CSR_REG_TYPE(mie);
typedef CSR_REG_TYPE(ie) CSR_REG_TYPE(vsie);

// define write masks
#define WM32_hie 0x1444

// -----------------------------------------------------------------------------
// utvec        (id 0x005)
// stvec        (id 0x105)
// vstvec       (id 0x205)
// mtvec        (id 0x305)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 MODE :  2;
    Uns32 BASE : 30;
} CSR_REG_TYPE_32(tvec);

// 64-bit view
typedef struct {
    Uns64 MODE :  2;
    Uns64 BASE : 62;
} CSR_REG_TYPE_64(tvec);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32_64(tvec);

// define alias types
typedef CSR_REG_TYPE(tvec) CSR_REG_TYPE(utvec);
typedef CSR_REG_TYPE(tvec) CSR_REG_TYPE(stvec);
typedef CSR_REG_TYPE(tvec) CSR_REG_TYPE(mtvec);
typedef CSR_REG_TYPE(tvec) CSR_REG_TYPE(xtvec);

// define write masks
#define WM64_tvec_orig -3
#define WM64_tvec_clic -2

// -----------------------------------------------------------------------------
// scounteren   (id 0x106)
// hcounteren   (id 0x606)
// mcounteren   (id 0x306)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 CY  : 1;
    Uns32 TM  : 1;
    Uns32 IR  : 1;
    Uns32 HPM : 29;
} CSR_REG_TYPE_32(counteren);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(counteren);

// define alias types
typedef CSR_REG_TYPE(counteren) CSR_REG_TYPE(scounteren);
typedef CSR_REG_TYPE(counteren) CSR_REG_TYPE(hcounteren);
typedef CSR_REG_TYPE(counteren) CSR_REG_TYPE(mcounteren);

// define write masks
#define WM32_counteren_CY  0x00000001
#define WM32_counteren_TM  0x00000002
#define WM32_counteren_IR  0x00000004
#define WM32_counteren_HPM 0xfffffff8

// -----------------------------------------------------------------------------
// utvt         (id 0x007)
// stvt         (id 0x107)
// mtvt         (id 0x307)
// -----------------------------------------------------------------------------

typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(utvt);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(stvt);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mtvt);

// define write masks
#define WM64_tvt -0x40

// -----------------------------------------------------------------------------
// mcountinhibit (id 0x320)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(counteren) CSR_REG_TYPE(mcountinhibit);

// -----------------------------------------------------------------------------
// mhpmevent    (id 0x323-0x33F)
// -----------------------------------------------------------------------------

typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mhpmevent);

// -----------------------------------------------------------------------------
// uscratch     (id 0x040)
// sscratch     (id 0x140)
// vsscratch    (id 0x240)
// mscratch     (id 0x340)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(uscratch);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(sscratch);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mscratch);

// -----------------------------------------------------------------------------
// uepc         (id 0x041)
// sepc         (id 0x141)
// vsepc        (id 0x241)
// mepc         (id 0x341)
// mnepc        (id 0x741)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(uepc);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(sepc);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mepc);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mnepc);

// -----------------------------------------------------------------------------
// ucause       (id 0x042)
// scause       (id 0x142)
// vscause      (id 0x242)
// mcause       (id 0x342)
// mncause      (id 0x742)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 ExceptionCode : 16;
    Uns32 pil           : 8;
    Uns32 _u1           : 3;
    Uns32 pie           : 1;
    Uns32 pp            : 2;
    Uns32 inhv          : 1;
    Uns32 Interrupt     : 1;
} CSR_REG_TYPE_32(cause);

// 64-bit view
typedef struct {
    Uns32 ExceptionCode : 16;
    Uns32 pil           : 8;
    Uns32 _u1           : 3;
    Uns32 pie           : 1;
    Uns32 pp            : 2;
    Uns32 inhv          : 1;
    Uns64 _u2           : 32;
    Uns64 Interrupt     : 1;
} CSR_REG_TYPE_64(cause);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32_64(cause);

// define alias types
typedef CSR_REG_TYPE(cause) CSR_REG_TYPE(ucause);
typedef CSR_REG_TYPE(cause) CSR_REG_TYPE(scause);
typedef CSR_REG_TYPE(cause) CSR_REG_TYPE(mcause);
typedef CSR_REG_TYPE(cause) CSR_REG_TYPE(mncause);

// -----------------------------------------------------------------------------
// utval        (id 0x043)
// stval        (id 0x143)
// vstval       (id 0x243)
// mtval        (id 0x343)
// mtval2       (id 0x34B)
// htval        (id 0x643)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(utval);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(stval);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mtval);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mtval2);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(htval);

// -----------------------------------------------------------------------------
// mtinst       (id 0x34A)
// htinst       (id 0x64A)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mtinst);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(htinst);

// -----------------------------------------------------------------------------
// uip          (id 0x044)
// sip          (id 0x144)
// vsip         (id 0x244)
// hip          (id 0x644)
// hvip         (id 0x645)
// mip          (id 0x344)
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns32 USIP  :  1;
    Uns32 SSIP  :  1;
    Uns32 VSSIP :  1;
    Uns32 MSIP  :  1;
    Uns32 UTIP  :  1;
    Uns32 STIP  :  1;
    Uns32 VSTIP :  1;
    Uns32 MTIP  :  1;
    Uns32 UEIP  :  1;
    Uns32 SEIP  :  1;
    Uns32 VSEIP :  1;
    Uns32 MEIP  :  1;
    Uns32 SGEIP :  1;
    Uns32 _u1   :  3;
    Uns64 LI    : 48;
} CSR_REG_TYPE_64(ip);

// define 64 bit type
CSR_REG_STRUCT_DECL_64(ip);

// define alias types
typedef CSR_REG_TYPE(ip) CSR_REG_TYPE(uip);
typedef CSR_REG_TYPE(ip) CSR_REG_TYPE(sip);
typedef CSR_REG_TYPE(ip) CSR_REG_TYPE(vsip);
typedef CSR_REG_TYPE(ip) CSR_REG_TYPE(hip);
typedef CSR_REG_TYPE(ip) CSR_REG_TYPE(hvip);
typedef CSR_REG_TYPE(ip) CSR_REG_TYPE(mip);

// define write masks
#define WM32_ip       0x00000fff
#define WM32_uip      0x00000001
#define WM32_sip      0x00000103
#define WM32_vsip     0x00000002
#define WM32_hip      0x00000004
#define WM32_mip      0x00000337
#define WM64_ssip     0x00000002ULL
#define WM64_hvip     0x00000444ULL
#define WM64_mip_mvip 0x00000222ULL
#define WM64_seip     0x00000200ULL
#define WM64_meip     0x00000800ULL

// -----------------------------------------------------------------------------
// mseccfg      (id 0x747)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 MML        :  1;
    Uns32 MMWP       :  1;
    Uns32 RLB        :  1;
    Uns32 _u1        :  5;
    Uns32 USEED_SKES :  1;
    Uns32 SSEED      :  1;
    Uns64 _u2        : 54;
} CSR_REG_TYPE_64(mseccfg);

// define 32 bit type
CSR_REG_STRUCT_DECL_64(mseccfg);

// define write masks
#define WM_mseccfg_MML      (1ULL<<0)
#define WM_mseccfg_MMWP     (1ULL<<1)
#define WM_mseccfg_RLB      (1ULL<<2)
#define WM_mseccfg_MML_MMWP (WM_mseccfg_MML|WM_mseccfg_MMWP)

// -----------------------------------------------------------------------------
// hgeip (id 0xE12)
// hgeie (id 0x607)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(hgeip);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(hgeie);

// define write masks
#define WM32_hgeip 0x00000000
#define WM64_hgeip 0x00000000

// -----------------------------------------------------------------------------
// uintstatus   (id 0x046 or 0xC46)
// sintstatus   (id 0x146 or 0xD46)
// mintstatus   (id 0x346 or 0xF46)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 uil  : 8;
    Uns32 sil  : 8;
    Uns32 vsil : 8; // assumed, if CLIC+H supported
    Uns32 mil  : 8;
} CSR_REG_TYPE_32(mintstatus);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(mintstatus);

// define write masks
#define WM32_mintstatus 0x00000000
#define WM64_mintstatus 0x00000000
#define WM32_sintstatus 0x00000000
#define WM64_sintstatus 0x00000000
#define WM32_uintstatus 0x00000000
#define WM64_uintstatus 0x00000000

// define read masks
#define RM32_sintstatus 0x0000ffff
#define RM32_uintstatus 0x000000ff

// -----------------------------------------------------------------------------
// uintthresh   (id 0x047)
// sintthresh   (id 0x147)
// mintthresh   (id 0x347)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 th  :  8;
    Uns32 _u1 : 24;
} CSR_REG_TYPE_32(intthresh);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(intthresh);

// define alias types
typedef CSR_REG_TYPE(intthresh) CSR_REG_TYPE(uintthresh);
typedef CSR_REG_TYPE(intthresh) CSR_REG_TYPE(sintthresh);
typedef CSR_REG_TYPE(intthresh) CSR_REG_TYPE(mintthresh);

// -----------------------------------------------------------------------------
// sscratchcsw  (id 0x148)
// vsscratchcsw (id 0x248)
// mscratchcsw  (id 0x348)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(sscratchcsw);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(vsscratchcsw);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mscratchcsw);

// -----------------------------------------------------------------------------
// uscratchcswl  (id 0x049)
// sscratchcswl  (id 0x149)
// vsscratchcswl (id 0x249)
// mscratchcswl  (id 0x349)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(uscratchcswl);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(sscratchcswl);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(vsscratchcswl);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mscratchcswl);

// -----------------------------------------------------------------------------
// pmpcfg       (id 0x3A0-0x3AF)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(pmpcfg);

// for use in riscvConfig.csrMasks
// - non-standard name clarifies this is a read-only mask,not a write mask
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(romask_pmpcfg);

// define write masks
#define WM64_pmpcfg 0x9f9f9f9f9f9f9f9fULL

// -----------------------------------------------------------------------------
// pmpaddr      (id 0x3B0-0x3EF)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(pmpaddr);

// for use in riscvConfig.csrMasks
// - non-standard name clarifies this is a read-only mask,not a write mask
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(romask_pmpaddr);

// -----------------------------------------------------------------------------
// mpucfg       (id 0x1A0-0x1A3?)
// -----------------------------------------------------------------------------

// define write masks
#define WM64_mpucfg 0x9f9f9f9f9f9f9f9fULL

// -----------------------------------------------------------------------------
// satp         (id 0x180)
// vsatp        (id 0x280)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 PPN  : 22;
    Uns32 ASID :  9;
    Uns32 MODE :  1;
} CSR_REG_TYPE_32(atp);

// 64-bit view
typedef struct {
    Uns64 PPN  : 44;
    Uns64 ASID : 16;
    Uns64 MODE :  4;
} CSR_REG_TYPE_64(atp);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32_64(atp);

// define alias types
typedef CSR_REG_TYPE(atp) CSR_REG_TYPE(satp);

// -----------------------------------------------------------------------------
// hgatp        (id 0x680)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 PPN  : 22;
    Uns32 VMID :  7;
    Uns32 _u1  :  2;
    Uns32 MODE :  1;
} CSR_REG_TYPE_32(hgatp);

// 64-bit view
typedef struct {
    Uns64 PPN  : 44;
    Uns64 VMID : 14;
    Uns64 _u1  :  2;
    Uns64 MODE :  4;
} CSR_REG_TYPE_64(hgatp);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32_64(hgatp);

// -----------------------------------------------------------------------------
// jvt          (id 0x017)
// tbljalvec    (id 0x800)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(jvt);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(tbljalvec);

// define write masks
#define WM32_jvt       -64
#define WM64_jvt       -64
#define WM32_tbljalvec -64
#define WM64_tbljalvec -64

// -----------------------------------------------------------------------------
// ucode        (id 0x801)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(ucode);

// define write masks
#define WM32_ucode 0x1
#define WM64_ucode 0x1

// -----------------------------------------------------------------------------
// mcycle       (id 0xB00)
// cycle        (id 0xC00)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mcycle);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(cycle);

// -----------------------------------------------------------------------------
// time         (id 0xC01)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(time);

// -----------------------------------------------------------------------------
// minstret     (id 0xB02)
// instret      (id 0xC02)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(minstret);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(instret);

// -----------------------------------------------------------------------------
// mhpmcounter  (id 0xB03-0xB1F)
// hpmcounter   (id 0xC03-0xC1F)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mhpmcounter);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(hpmcounter);

// -----------------------------------------------------------------------------
// htimedelta   (id 0x605)
// htimedeltah  (id 0x615)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(htimedelta);

// -----------------------------------------------------------------------------
// stimecmp     (id 0x14D)
// stimecmph    (id 0x15D)
// vstimecmp    (id 0x24D)
// vstimecmph   (id 0x25D)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(stimecmp);

// -----------------------------------------------------------------------------
// mvendorid    (id 0xF11)
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns64 Offset :  7;
    Uns64 Bank   : 25;
} CSR_REG_TYPE_64(vendorid);

// define 32 bit type
CSR_REG_STRUCT_DECL_64(vendorid);

// define alias types
typedef CSR_REG_TYPE(vendorid) CSR_REG_TYPE(mvendorid);

// -----------------------------------------------------------------------------
// marchid      (id 0xF12)
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns64 ArchitectureID;
} CSR_REG_TYPE_64(archid);

// define 32 bit type
CSR_REG_STRUCT_DECL_64(archid);

// define alias types
typedef CSR_REG_TYPE(archid) CSR_REG_TYPE(marchid);

// -----------------------------------------------------------------------------
// mimpid       (id 0xF13)
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns64 Implementation;
} CSR_REG_TYPE_64(impid);

// define 32 bit type
CSR_REG_STRUCT_DECL_64(impid);

// define alias types
typedef CSR_REG_TYPE(impid) CSR_REG_TYPE(mimpid);

// -----------------------------------------------------------------------------
// mhartid      (id 0xF14)
// -----------------------------------------------------------------------------

// 64-bit view
typedef struct {
    Uns64 HartID;
} CSR_REG_TYPE_64(hartid);

// define 32 bit type
CSR_REG_STRUCT_DECL_64(hartid);

// define alias types
typedef CSR_REG_TYPE(hartid) CSR_REG_TYPE(mhartid);

// -----------------------------------------------------------------------------
// mconfigptr   (id 0xF15)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mconfigptr);

// define write masks
#define WM32_mconfigptr 0
#define WM64_mconfigptr 0

// -----------------------------------------------------------------------------
// mnoise        (id 0x7A9)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 _u1        : 31;
    Uns32 NOISE_TEST :  1;
} CSR_REG_TYPE_32(noise);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(noise);

// define alias types
typedef CSR_REG_TYPE(noise) CSR_REG_TYPE(mnoise);

// define write masks
#define WM32_mnoise 0x80000000
#define WM64_mnoise 0x80000000

// -----------------------------------------------------------------------------
// seed          (id 0x015)
// sentropy      (id 0xDBF/0x546)
// mentropy      (id 0xF15)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 seed   : 16;
    Uns32 custom :  8;
    Uns32 _u1    :  6;
    Uns32 OPST   :  2;
} CSR_REG_TYPE_32(entropy);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(entropy);

// define alias types
typedef CSR_REG_TYPE(entropy) CSR_REG_TYPE(seed);
typedef CSR_REG_TYPE(entropy) CSR_REG_TYPE(sentropy);
typedef CSR_REG_TYPE(entropy) CSR_REG_TYPE(mentropy);

// -----------------------------------------------------------------------------
// dcsr         (id 0x7B0)
// -----------------------------------------------------------------------------

// cause for entry to Debug mode
typedef enum dmCauseE {
    DMC_NONE         = 0,
    DMC_EBREAK       = 1,
    DMC_TRIGGER      = 2,
    DMC_HALTREQ      = 3,
    DMC_STEP         = 4,
    DMC_RESETHALTREQ = 5,
    DMC_HALTGROUP    = 6,
} dmCause;

// 32-bit view
typedef struct {
    Uns32   prv       :  2;
    Uns32   step      :  1;
    Uns32   nmip      :  1;
    Uns32   mprven    :  1;
    Uns32   v         :  1;
    dmCause cause     :  3;
    Uns32   stoptime  :  1;
    Uns32   stopcount :  1;
    Uns32   stepie    :  1;
    Uns32   ebreaku   :  1;
    Uns32   ebreaks   :  1;
    Uns32   _u1       :  1;
    Uns32   ebreakm   :  1;
    Uns32   ebreakvu  :  1;
    Uns32   ebreakvs  :  1;
    Uns32   _u2       : 10;
    Uns32   xdebugver :  4;
} CSR_REG_TYPE_32(dcsr);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(dcsr);

// shift to ebreak fields in dcsr
#define DCSR_EBREAK_SHIFT 12

// -----------------------------------------------------------------------------
// dpc          (id 0x7B1)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(dpc);

// -----------------------------------------------------------------------------
// dscratch0    (id 0x7B2)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(dscratch0);

// define write masks
#define WM32_dscratch0 -1
#define WM64_dscratch0 -1

// -----------------------------------------------------------------------------
// dscratch1    (id 0x7B3)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(dscratch1);

// define write masks
#define WM32_dscratch1 -1
#define WM64_dscratch1 -1

// -----------------------------------------------------------------------------
// vstart       (id 0x008)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(vstart);

// -----------------------------------------------------------------------------
// vxsat        (id 0x009)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 sat :  1;
    Uns32 _u1 : 31;
} CSR_REG_TYPE_32(vxsat);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(vxsat);

// define write masks
#define WM32_vxsat  0x00000001
#define WM64_vxsat  0x00000001

// -----------------------------------------------------------------------------
// vxrm         (id 0x00A)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 rm  :  2;
    Uns32 _u1 : 30;
} CSR_REG_TYPE_32(vxrm);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(vxrm);

// define write masks
#define WM32_vxrm   0x00000003
#define WM64_vxrm   0x00000003

// -----------------------------------------------------------------------------
// vcsr         (id 0x00F)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 vxsat :  1;
    Uns32 vxrm  :  2;
    Uns32 _u0   : 29;
} CSR_REG_TYPE_32(vcsr);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(vcsr);

// define write masks
#define WM32_vcsr   0x00000007

// -----------------------------------------------------------------------------
// vl           (id 0xC20)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(vl);

// define write masks
#define WM32_vl     0x00000000

// -----------------------------------------------------------------------------
// vtype        (id 0xC21)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 _u1    : 31;
    Uns32 vill   :  1;
} CSR_REG_TYPE_32(vtype);

// 64-bit view
typedef struct {
    Uns64 _u1    : 63;
    Uns64 vill   :  1;
} CSR_REG_TYPE_64(vtype);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32_64(vtype);

// define write masks
#define WM32_vtype  0x00000000
#define WM64_vtype  0x00000000

// -----------------------------------------------------------------------------
// vlenb        (id 0xC22)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(vlenb);

// define write masks
#define WM32_vlenb  0x00000000

// -----------------------------------------------------------------------------
// tselect      (id 0x7A0)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(tselect);

// define write masks
#define WM32_tselect    0x00000000

// -----------------------------------------------------------------------------
// tdata1       (id 0x7A1)
// -----------------------------------------------------------------------------

// trigger types
typedef enum triggerTypeE {
    TT_NONE        = 0,     // disabled
    TT_ADMATCH     = 2,     // address/data match
    TT_ICOUNT      = 3,     // instruction count
    TT_INTERRUPT   = 4,     // interrupt
    TT_EXCEPTION   = 5,     // exception
    TT_MCONTROL6   = 6,     // address/data match (type 6)
    TT_UNAVAILABLE = 15,    // present but unavailable
} triggerType;

// 32-bit view
typedef union {

    // common view
    struct {
        Uns32       _u1       : 27;
        Uns32       dmode     :  1;
        triggerType type      :  4;
    };

    // mcontrol view (Type=2)
    struct {
        Uns32       priv      :  3;
        Uns32       modes     :  4;
        Uns32       match     :  4;
        Uns32       chain     :  1;
        Uns32       action    :  4;
        Uns32       sizelo    :  2;
        Uns32       timing    :  1;
        Uns32       select    :  1;
        Uns32       hit       :  1;
        Uns32       maskmax   :  6;
        Uns32       dmode     :  1;
        triggerType type      :  4;
    } mcontrol;

    // icount view (Type=3)
    struct {
        Uns32       action    :  6;
        Uns32       modes     :  4;
        Uns32       count     : 14;
        Uns32       hit       :  1;
        Uns32       vu        :  1;
        Uns32       vs        :  1;
        Uns32       dmode     :  1;
        triggerType type      :  4;
    } icount;

    // itrigger view (Type=4)
    struct {
        Uns32       action    :  6;
        Uns32       modes     :  4;
        Uns32       nmi       :  1;   // in version 1.0-STABLE
        Uns32       vu        :  1;
        Uns32       vs        :  1;
        Uns32       _u2       : 13;
        Uns32       hit       :  1;
        Uns32       dmode     :  1;
        triggerType type      :  4;
    } itrigger;

    // etrigger view (Type=5)
    struct {
        Uns32       action    :  6;
        Uns32       modes     :  4;
        Uns32       nmi       :  1;   // legacy position
        Uns32       vu        :  1;
        Uns32       vs        :  1;
        Uns32       _u1       : 13;
        Uns32       hit       :  1;
        Uns32       dmode     :  1;
        triggerType type      :  4;
    } etrigger;

    // mcontrol6 view (Type=6)
    struct {
        Uns32       priv      :  3;
        Uns32       modes     :  4;
        Uns32       match     :  4;
        Uns32       chain     :  1;
        Uns32       action    :  4;
        Uns32       size      :  4;
        Uns32       timing    :  1;
        Uns32       select    :  1;
        Uns32       hit0      :  1;
        Uns32       vu        :  1;
        Uns32       vs        :  1;
        Uns32       hit1      :  1;
        Uns32       uncertain :  1;
        Uns32       dmode     :  1;
        triggerType type      :  4;
    } mcontrol6;

} CSR_REG_TYPE_32(tdata1);

// 64-bit view
typedef union {

    // common view
    struct {
        Uns64       _u1       : 59;
        Uns64       dmode     :  1;
        triggerType type      :  4;
    };

    // mcontrol view
    struct {
        Uns64       priv      :  3;
        Uns64       modes     :  4;
        Uns64       match     :  4;
        Uns64       chain     :  1;
        Uns64       action    :  4;
        Uns64       sizelo    :  2;
        Uns64       timing    :  1;
        Uns64       select    :  1;
        Uns64       hit       :  1;
        Uns64       sizehi    :  2;
        Uns64       _u1       : 30;
        Uns64       maskmax   :  6;
        Uns64       dmode     :  1;
        triggerType type      :  4;
    } mcontrol;

    // icount view
    struct {
        Uns64       action    :  6;
        Uns64       modes     :  4;
        Uns64       count     : 14;
        Uns64       hit       :  1;
        Uns64       vu        :  1;
        Uns64       vs        :  1;
        Uns64       _u1       : 32;
        Uns64       dmode     :  1;
        triggerType type      :  4;
    } icount;

    // itrigger view
    struct {
        Uns64       action    :  6;
        Uns64       modes     :  4;
        Uns32       nmi       :  1;   // in version 1.0-STABLE
        Uns64       vu        :  1;
        Uns64       vs        :  1;
        Uns64       _u2       : 45;
        Uns64       hit       :  1;
        Uns64       dmode     :  1;
        triggerType type      :  4;
    } itrigger;

    // etrigger view
    struct {
        Uns64       action    :  6;
        Uns64       modes     :  4;
        Uns32       nmi       :  1;   // legacy position
        Uns64       vu        :  1;
        Uns64       vs        :  1;
        Uns64       _u1       : 45;
        Uns64       hit       :  1;
        Uns64       dmode     :  1;
        triggerType type      :  4;
    } etrigger;

    // mcontrol6 view
    struct {
        Uns64       priv      :  3;
        Uns64       modes     :  4;
        Uns64       match     :  4;
        Uns64       chain     :  1;
        Uns64       action    :  4;
        Uns64       size      :  4;
        Uns64       timing    :  1;
        Uns64       select    :  1;
        Uns64       hit0      :  1;
        Uns64       vu        :  1;
        Uns64       vs        :  1;
        Uns64       hit1      :  1;
        Uns64       uncertain :  1;
        Uns64       _u1       : 32;
        Uns64       dmode     :  1;
        triggerType type      :  4;
    } mcontrol6;

} CSR_REG_TYPE_64(tdata1);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32_64(tdata1);

// define write masks
#define WM32_tdata1 0x00000000
#define WM64_tdata1 0x00000000

// -----------------------------------------------------------------------------
// tdata2       (id 0x7A2)
// -----------------------------------------------------------------------------

typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(tdata2);

// define write masks
#define WM32_tdata2     -1
#define WM64_tdata2     -1

// -----------------------------------------------------------------------------
// tdata3       (id 0x7A3)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 sselect   :  2;
    Uns32 svalue    : 16;
    Uns32 sbytemask :  2;
    Uns32 _u1       :  3;
    Uns32 mhselect  :  3;
    Uns32 mhvalue   :  6;
} CSR_REG_TYPE_32(tdata3);

// 64-bit view
typedef struct {
    Uns64 sselect   :  2;
    Uns64 svalue    : 34;
    Uns64 sbytemask :  5;
    Uns64 _u1       :  7;
    Uns64 mhselect  :  3;
    Uns64 mhvalue   : 13;
} CSR_REG_TYPE_64(tdata3);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32_64(tdata3);

// define write masks
#define WM32_tdata3     0x00000000
#define WM64_tdata3     0x00000000

// -----------------------------------------------------------------------------
// tinfo        (id 0x7A4)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 info    : 16;
    Uns32 _u1     :  8;
    Uns32 version :  8;
} CSR_REG_TYPE_32(tinfo);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(tinfo);

// define write masks
#define WM32_tinfo      0x00000000

// -----------------------------------------------------------------------------
// tcontrol     (id 0x7A5)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 _u1  :  3;
    Uns32 mte  :  1;
    Uns32 _u2  :  3;
    Uns32 mpte :  1;
    Uns32 scxe :  1;
    Uns32 hcxe :  1;
    Uns32 _u3  : 22;
} CSR_REG_TYPE_32(tcontrol);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(tcontrol);

// define write masks
#define WM32_tcontrol   0x00000088
#define WM64_tcontrol   0x00000088

// -----------------------------------------------------------------------------
// mcontext     (id 0x7A8)
// scontext     (id 0x7AA)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mcontext);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(scontext);

// define write masks
#define WM32_mcontext   0x00000000
#define WM32_scontext   0x00000000

// -----------------------------------------------------------------------------
// mnscratch    (id 0x740)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(mnscratch);

// define write masks
#define WM32_mnscratch  -1
#define WM64_mnscratch  -1

// -----------------------------------------------------------------------------
// mvien        (id 0x308)
// mvip         (id 0x309)
// hvien        (id 0x608)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(ip) CSR_REG_TYPE(mvien);
typedef CSR_REG_TYPE(ip) CSR_REG_TYPE(mvip);
typedef CSR_REG_TYPE(ip) CSR_REG_TYPE(hvien);

// define write masks
#define WM64_mvien  (-1ULL << 13)
#define WM64_mvip   (-1ULL << 13)
#define WM64_hvien  (-1ULL << 13)

// -----------------------------------------------------------------------------
// miselect     (id 0x350)
// siselect     (id 0x150)
// vsiselect    (id 0x250)
// -----------------------------------------------------------------------------

// define alias types
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(miselect);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(siselect);
typedef CSR_REG_TYPE(genericXLEN) CSR_REG_TYPE(vsiselect);

// define write masks
#define WM64_miselect  -1
#define WM64_siselect  -1
#define WM64_vsiselect -1

// -----------------------------------------------------------------------------
// miselect     (id 0x350)
// siselect     (id 0x150)
// vsiselect    (id 0x250)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 priority : 11;
    Uns32 _u1      :  5;
    Uns32 identity : 11;
    Uns32 _u2      :  5;
} CSR_REG_TYPE_32(topei);

// define 32 bit type
CSR_REG_STRUCT_DECL_32(topei);

// define alias types
typedef CSR_REG_TYPE(topei) CSR_REG_TYPE(mtopei);
typedef CSR_REG_TYPE(topei) CSR_REG_TYPE(stopei);
typedef CSR_REG_TYPE(topei) CSR_REG_TYPE(vstopei);

// define write masks
#define WM32_mtopei  0x00000000
#define WM64_mtopei  0x00000000
#define WM32_stopei  0x00000000
#define WM64_stopei  0x00000000
#define WM32_vstopei 0x00000000
#define WM64_vstopei 0x00000000

// -----------------------------------------------------------------------------
// hvictl       (id 0x609)
// -----------------------------------------------------------------------------

// 32-bit view
typedef struct {
    Uns32 IPRIO  :  8;
    Uns32 IPRIOM :  1;
    Uns32 DPR    :  1;
    Uns32 _u1    :  6;
    Uns32 IID    : 12;
    Uns32 _u2    :  2;
    Uns32 VTI    :  1;
    Uns32 _u3    :  1;
} CSR_REG_TYPE_32(hvictl);

// define 32/64 bit type
CSR_REG_STRUCT_DECL_32(hvictl);

// define write masks
#define WM32_hvictl 0x400003ff
#define WM64_hvictl 0x400003ff

// define bit masks
#define WM_hvictl_VTI (1<<30)


////////////////////////////////////////////////////////////////////////////////
// SYSTEM REGISTER CONTAINER
////////////////////////////////////////////////////////////////////////////////

//
// Use this to define a register entry in riscvCSRs below
//
#define CSR_REG_DECL(_N)    CSR_REG_TYPE(_N) _N

//
// Use this to define a register entry in riscvCSRs below with normal and
// virtual aliases
//
#define CSR_REG_DECL_V(_N)  CSR_REG_TYPE(_N) _N, v##_N

//
// Use this to define a register entry in riscvCSRs below with two named aliases
//
#define CSR_REG_DECL_A(_N1, _N2) union {CSR_REG_DECL(_N1); CSR_REG_DECL(_N2);}

//
// Use this to define four register entries in riscvCSRs below
//
#define CSR_REG_DECLx4(_N)  CSR_REG_TYPE(_N) _N[4]

//
// Use this to define an indexed register entry in riscvCSRs below
//
#define CSR_REG_DECL_I(_R, _I)    CSR_REG_TYPE(_R) _R##_I

//
// Construct reg declarations with indices  0..9
//
#define CSR_REG_DECL_0_9(_R) \
    CSR_REG_DECL_I(_R, 0);   \
    CSR_REG_DECL_I(_R, 1);   \
    CSR_REG_DECL_I(_R, 2);   \
    CSR_REG_DECL_I(_R, 3);   \
    CSR_REG_DECL_I(_R, 4);   \
    CSR_REG_DECL_I(_R, 5);   \
    CSR_REG_DECL_I(_R, 6);   \
    CSR_REG_DECL_I(_R, 7);   \
    CSR_REG_DECL_I(_R, 8);   \
    CSR_REG_DECL_I(_R, 9)

//
// Construct reg declarations with indices 0..15
//
#define CSR_REG_DECL_0_15(_R) \
    CSR_REG_DECL_0_9(_R);     \
    CSR_REG_DECL_I(_R, 10);   \
    CSR_REG_DECL_I(_R, 11);   \
    CSR_REG_DECL_I(_R, 12);   \
    CSR_REG_DECL_I(_R, 13);   \
    CSR_REG_DECL_I(_R, 14);   \
    CSR_REG_DECL_I(_R, 15)

//
// Construct reg declarations with indices  x0..x9
//
#define CSR_REG_DECL_X0_X9(_R, _X) \
    CSR_REG_DECL_I(_R, _X##0);   \
    CSR_REG_DECL_I(_R, _X##1);   \
    CSR_REG_DECL_I(_R, _X##2);   \
    CSR_REG_DECL_I(_R, _X##3);   \
    CSR_REG_DECL_I(_R, _X##4);   \
    CSR_REG_DECL_I(_R, _X##5);   \
    CSR_REG_DECL_I(_R, _X##6);   \
    CSR_REG_DECL_I(_R, _X##7);   \
    CSR_REG_DECL_I(_R, _X##8);   \
    CSR_REG_DECL_I(_R, _X##9)

//
// Construct reg declarations with indices 0..63
//
#define CSR_REG_DECL_0_63(_R)   \
    CSR_REG_DECL_0_9(_R);       \
    CSR_REG_DECL_X0_X9(_R, 1);  \
    CSR_REG_DECL_X0_X9(_R, 2);  \
    CSR_REG_DECL_X0_X9(_R, 3);  \
    CSR_REG_DECL_X0_X9(_R, 4);  \
    CSR_REG_DECL_X0_X9(_R, 5);  \
    CSR_REG_DECL_I(_R, 60);     \
    CSR_REG_DECL_I(_R, 61);     \
    CSR_REG_DECL_I(_R, 62);     \
    CSR_REG_DECL_I(_R, 63)

//
// This type defines the CSRs implemented as true registers in the processor
// structure
//
typedef struct riscvCSRsS {

    // USER MODE CSRS
    CSR_REG_DECL  (fcsr);           // 0x003
    CSR_REG_DECL  (utvec);          // 0x005
    CSR_REG_DECL  (utvt);           // 0x007
    CSR_REG_DECL  (vstart);         // 0x008
    CSR_REG_DECL  (vxsat);          // 0x009
    CSR_REG_DECL  (vxrm);           // 0x00A
    CSR_REG_DECL  (vcsr);           // 0x00E
    CSR_REG_DECL_A(jvt, tbljalvec); // 0x017 or 0x800
    CSR_REG_DECL  (uscratch);       // 0x040
    CSR_REG_DECL  (uepc);           // 0x041
    CSR_REG_DECL  (ucause);         // 0x042
    CSR_REG_DECL  (utval);          // 0x043
    CSR_REG_DECL  (uintthresh);     // 0x04A
    CSR_REG_DECL  (ucode);          // 0x801
    CSR_REG_DECL  (vl);             // 0xC20
    CSR_REG_DECL  (vtype);          // 0xC21
    CSR_REG_DECL  (vlenb);          // 0xC22

    // SUPERVISOR MODE CSRS
    CSR_REG_DECL  (sedeleg);        // 0x102
    CSR_REG_DECL  (sideleg);        // 0x103
    CSR_REG_DECL_V(stvec);          // 0x105
    CSR_REG_DECL  (scounteren);     // 0x106
    CSR_REG_DECL  (stvt);           // 0x107
    CSR_REG_DECL  (senvcfg);        // 0x10A
    CSR_REG_DECLx4(sstateen);       // 0x10C-0x10F
    CSR_REG_DECL_V(sscratch);       // 0x140
    CSR_REG_DECL_V(sepc);           // 0x141
    CSR_REG_DECL_V(scause);         // 0x142
    CSR_REG_DECL_V(stval);          // 0x143
    CSR_REG_DECL  (sintthresh);     // 0x14A
    CSR_REG_DECL_V(stimecmp);       // 0x14D
    CSR_REG_DECL_V(siselect);       // 0x150
    CSR_REG_DECL_V(satp);           // 0x180

    // HYPERVISOR MODE CSRS
    CSR_REG_DECL  (hstatus);        // 0x600
    CSR_REG_DECL  (hedeleg);        // 0x602
    CSR_REG_DECL  (hideleg);        // 0x603
    CSR_REG_DECL  (htimedelta);     // 0x605
    CSR_REG_DECL  (hcounteren);     // 0x606
    CSR_REG_DECL  (hgeie);          // 0x607
    CSR_REG_DECL  (hvien);          // 0x608
    CSR_REG_DECL  (hvictl);         // 0x609
    CSR_REG_DECL  (henvcfg);        // 0x60A
    CSR_REG_DECLx4(hstateen);       // 0x60C-0x60F
    CSR_REG_DECL  (htval);          // 0x643
    CSR_REG_DECL  (hvip);           // 0x645
    CSR_REG_DECL  (htinst);         // 0x64A
    CSR_REG_DECL  (hgatp);          // 0x680
    CSR_REG_DECL  (hgeip);          // 0xE12

    // VIRTUAL MODE CSRS
    CSR_REG_DECL  (vsstatus);       // 0x200
    CSR_REG_DECL  (vsie);           // 0x204

    // MACHINE MODE CSRS
    CSR_REG_DECL  (mvendorid);      // 0xF11
    CSR_REG_DECL  (marchid);        // 0xF12
    CSR_REG_DECL  (mimpid);         // 0xF13
    CSR_REG_DECL  (mhartid);        // 0xF14
    CSR_REG_DECL  (mconfigptr);     // 0xF15
    CSR_REG_DECL  (mstatus);        // 0x300
    CSR_REG_DECL  (misa);           // 0x301
    CSR_REG_DECL  (medeleg);        // 0x302
    CSR_REG_DECL  (mideleg);        // 0x303
    CSR_REG_DECL  (mie);            // 0x304
    CSR_REG_DECL  (mtvec);          // 0x305
    CSR_REG_DECL  (mcounteren);     // 0x306
    CSR_REG_DECL  (mtvt);           // 0x307
    CSR_REG_DECL  (mvien);          // 0x308
    CSR_REG_DECL  (mvip);           // 0x309
    CSR_REG_DECL  (menvcfg);        // 0x30A
    CSR_REG_DECLx4(mstateen);       // 0x30C-0x30F
    CSR_REG_DECL  (mcountinhibit);  // 0x320
    CSR_REG_DECL  (mscratch);       // 0x340
    CSR_REG_DECL  (mepc);           // 0x341
    CSR_REG_DECL  (mcause);         // 0x342
    CSR_REG_DECL  (mtval);          // 0x343
    CSR_REG_DECL  (mip);            // 0x344
    CSR_REG_DECL  (mintstatus);     // 0x346
    CSR_REG_DECL  (mintthresh);     // 0x347
    CSR_REG_DECL  (mtinst);         // 0x34A
    CSR_REG_DECL  (mtval2);         // 0x34B
    CSR_REG_DECL  (miselect);       // 0x350
    CSR_REG_DECL  (mnscratch);      // 0x740
    CSR_REG_DECL  (mnepc);          // 0x741
    CSR_REG_DECL  (mncause);        // 0x742
    CSR_REG_DECL  (mnstatus);       // 0x744
    CSR_REG_DECL  (mseccfg);        // 0x747

    // TRIGGER CSRS
    CSR_REG_DECL  (tselect);        // 0x7A0
    CSR_REG_DECL  (tcontrol);       // 0x7A5

    // CRYPTOGRAPHIC CSRS
    CSR_REG_DECL  (mnoise);         // 0x7A9

    // DEBUG MODE CSRS
    CSR_REG_DECL  (dcsr);           // 0x7B0
    CSR_REG_DECL  (dpc);            // 0x7B1
    CSR_REG_DECL  (dscratch0);      // 0x7B2
    CSR_REG_DECL  (dscratch1);      // 0x7B3

} riscvCSRs;


////////////////////////////////////////////////////////////////////////////////
// SYSTEM REGISTER WRITE MASKS
////////////////////////////////////////////////////////////////////////////////

//
// This type defines write masks for CSRs
//
typedef struct riscvCSRMasksS {

    // USER MODE CSRS
    CSR_REG_DECL  (fcsr);           // 0x003
    CSR_REG_DECL  (utvec);          // 0x005
    CSR_REG_DECL  (utvt);           // 0x007
    CSR_REG_DECL  (vstart);         // 0x008
    CSR_REG_DECL  (jvt);            // 0x017
    CSR_REG_DECL  (uepc);           // 0x041
    CSR_REG_DECL  (ucause);         // 0x042
    CSR_REG_DECL  (utval);          // 0x043
    CSR_REG_DECL  (uip);            // 0x044

    // SUPERVISOR MODE CSRS
    CSR_REG_DECL  (sedeleg);        // 0x102
    CSR_REG_DECL  (sideleg);        // 0x103
    CSR_REG_DECL_V(stvec);          // 0x105
    CSR_REG_DECL  (stvt);           // 0x107
    CSR_REG_DECL  (scounteren);     // 0x106
    CSR_REG_DECL  (senvcfg);        // 0x10A
    CSR_REG_DECLx4(sstateen);       // 0x10C-0x10F
    CSR_REG_DECL_V(sepc);           // 0x141
    CSR_REG_DECL  (scause);         // 0x142
    CSR_REG_DECL_V(stval);          // 0x143
    CSR_REG_DECL  (sip);            // 0x144

    // HYPERVISOR MODE CSRS
    CSR_REG_DECL  (hstatus);        // 0x600
    CSR_REG_DECL  (hedeleg);        // 0x602
    CSR_REG_DECL  (hideleg);        // 0x603
    CSR_REG_DECL  (hcounteren);     // 0x606
    CSR_REG_DECL  (hvien);          // 0x608
    CSR_REG_DECL  (hvictl);         // 0x609
    CSR_REG_DECL  (henvcfg);        // 0x60A
    CSR_REG_DECLx4(hstateen);       // 0x60C-0x60F
    CSR_REG_DECL  (hip);            // 0x644
    CSR_REG_DECL  (hvip);           // 0x645
    CSR_REG_DECL  (htinst);         // 0x64A

    // MACHINE MODE CSRS
    CSR_REG_DECL  (mstatus);        // 0x300
    CSR_REG_DECL  (misa);           // 0x301
    CSR_REG_DECL  (medeleg);        // 0x302
    CSR_REG_DECL  (mideleg);        // 0x303
    CSR_REG_DECL  (mie);            // 0x304
    CSR_REG_DECL  (mtvec);          // 0x305
    CSR_REG_DECL  (mtvt);           // 0x307
    CSR_REG_DECL  (mcounteren);     // 0x306
    CSR_REG_DECL  (mvien);          // 0x308
    CSR_REG_DECL  (mvip);           // 0x309
    CSR_REG_DECL  (menvcfg);        // 0x30A
    CSR_REG_DECLx4(mstateen);       // 0x30C-0x30F
    CSR_REG_DECL  (mcountinhibit);  // 0x320
    CSR_REG_DECL  (mepc);           // 0x341
    CSR_REG_DECL  (mcause);         // 0x342
    CSR_REG_DECL  (mtval);          // 0x343
    CSR_REG_DECL  (mip);            // 0x344
    CSR_REG_DECL  (mtinst);         // 0x34A
    CSR_REG_DECL  (mnepc);          // 0x741
    CSR_REG_DECL  (mnstatus);       // 0x744
    CSR_REG_DECL  (mseccfg);        // 0x747

    // TRIGGER CSRS
    CSR_REG_DECL  (tcontrol);       // 0x7A5
    CSR_REG_DECL  (tdata1);         // 0x7A8
    CSR_REG_DECL  (mcontext);       // 0x7A8
    CSR_REG_DECL  (scontext);       // 0x7AA

    // DEBUG MODE CSRS
    CSR_REG_DECL  (dcsr);           // 0x7B0
    CSR_REG_DECL  (dpc);            // 0x7B1

} riscvCSRMasks;


////////////////////////////////////////////////////////////////////////////////
// SYSTEM REGISTER ACCESS MACROS, CONSTANT FIELD POSITION
////////////////////////////////////////////////////////////////////////////////

// get raw value using XLEN=32 view
#define RD_RAW32(_R) ((_R).u32.bits)

// get raw value using XLEN=64 view
#define RD_RAW64(_R) ((_R).u64.bits)

// get raw value using common view
#define RD_RAWC(_R)  RD_RAW32(_R)

// get CSR value using XLEN=32 view
#define RD_CSR32(_CPU, _RNAME) RD_RAW32((_CPU)->csr._RNAME)

// get CSR value using XLEN=64 view
#define RD_CSR64(_CPU, _RNAME) RD_RAW64((_CPU)->csr._RNAME)

// get CSR value using common view
#define RD_CSRC(_CPU, _RNAME) RD_RAWC((_CPU)->csr._RNAME)

// set raw value using XLEN=32 view
#define WR_RAW32(_R, _VALUE) (_R).u32.bits = _VALUE

// set raw value using XLEN=64 view
#define WR_RAW64(_R, _VALUE) (_R).u64.bits = _VALUE

// set raw value using common view
#define WR_RAWC(_R, _VALUE) WR_RAW32(_R, _VALUE)

// bitwise-and raw value using XLEN=32 view
#define AND_RAW32(_R, _VALUE) (_R).u32.bits &= _VALUE

// bitwise-and raw value using XLEN=64 view
#define AND_RAW64(_R, _VALUE) (_R).u64.bits &= _VALUE

// bitwise-or raw value using XLEN=32 view
#define OR_RAW32(_R, _VALUE) (_R).u32.bits |= _VALUE

// bitwise-or raw value using XLEN=64 view
#define OR_RAW64(_R, _VALUE) (_R).u64.bits |= _VALUE

// bitwise-and raw value using common view
#define AND_RAWC(_R, _VALUE) AND_RAW32(_R, _VALUE)

// bitwise-or raw value using common view
#define OR_RAWC(_R, _VALUE) OR_RAW32(_R, _VALUE)

// set CSR value using XLEN=32 view
#define WR_CSR32(_CPU, _RNAME, _VALUE) WR_RAW32((_CPU)->csr._RNAME, _VALUE)

// set CSR value using XLEN=64 view
#define WR_CSR64(_CPU, _RNAME, _VALUE) WR_RAW64((_CPU)->csr._RNAME, _VALUE)

// set CSR value using common view
#define WR_CSRC(_CPU, _RNAME, _VALUE) WR_RAWC((_CPU)->csr._RNAME, _VALUE)

// get raw field using XLEN=32 view
#define RD_RAW_FIELD32(_R, _FIELD) (_R).u32.fields._FIELD

// get raw field using XLEN=64 view
#define RD_RAW_FIELD64(_R, _FIELD) (_R).u64.fields._FIELD

// get raw field using common view
#define RD_RAW_FIELDC(_R, _FIELD) RD_RAW_FIELD32(_R, _FIELD)

// set raw field using XLEN=32 view
#define WR_RAW_FIELD32(_R, _FIELD, _VALUE) (_R).u32.fields._FIELD = _VALUE

// set raw field using XLEN=64 view
#define WR_RAW_FIELD64(_R, _FIELD, _VALUE) (_R).u64.fields._FIELD = _VALUE

// set raw field using common view
#define WR_RAW_FIELDC(_R, _FIELD, _VALUE) WR_RAW_FIELD32(_R, _FIELD, _VALUE)

// bitwise-or raw field using XLEN=32 view
#define OR_RAW_FIELD32(_R, _FIELD, _VALUE) (_R).u32.fields._FIELD |= _VALUE

// bitwise-or raw field using XLEN=64 view
#define OR_RAW_FIELD64(_R, _FIELD, _VALUE) (_R).u64.fields._FIELD |= _VALUE

// bitwise-or raw field using common view
#define OR_RAW_FIELDC(_R, _FIELD, _VALUE) OR_RAW_FIELD32(_R, _FIELD, _VALUE)

// get CSR field in XLEN=32 view
#define RD_CSR_FIELD32(_CPU, _RNAME, _FIELD) \
    RD_RAW_FIELD32((_CPU)->csr._RNAME, _FIELD)

// get CSR field in XLEN=64 view
#define RD_CSR_FIELD64(_CPU, _RNAME, _FIELD) \
    RD_RAW_FIELD64((_CPU)->csr._RNAME, _FIELD)

// get CSR field using common view
#define RD_CSR_FIELDC(_CPU, _RNAME, _FIELD) \
    RD_CSR_FIELD32(_CPU, _RNAME, _FIELD)

// set CSR field in XLEN=32 view
#define WR_CSR_FIELD32(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_RAW_FIELD32((_CPU)->csr._RNAME, _FIELD, _VALUE)

// set CSR field in XLEN=64 view
#define WR_CSR_FIELD64(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_RAW_FIELD64((_CPU)->csr._RNAME, _FIELD, _VALUE)

// set CSR field using common view
#define WR_CSR_FIELDC(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_FIELD32(_CPU, _RNAME, _FIELD, _VALUE)

// bitwise-or CSR field in XLEN=32 view
#define OR_CSR_FIELD32(_CPU, _RNAME, _FIELD, _VALUE) \
    OR_RAW_FIELD32((_CPU)->csr._RNAME, _FIELD, _VALUE)

// bitwise-or CSR field in XLEN=64 view
#define OR_CSR_FIELD64(_CPU, _RNAME, _FIELD, _VALUE) \
    OR_RAW_FIELD64((_CPU)->csr._RNAME, _FIELD, _VALUE)

// bitwise-or CSR field using common view
#define OR_CSR_FIELDC(_CPU, _RNAME, _FIELD, _VALUE) \
    OR_CSR_FIELD32(_CPU, _RNAME, _FIELD, _VALUE)

// get CSR mask using XLEN=32 view
#define RD_CSR_MASK32(_CPU, _RNAME) (_CPU)->csrMask._RNAME.u32.bits

// get CSR mask using XLEN=64 view
#define RD_CSR_MASK64(_CPU, _RNAME) (_CPU)->csrMask._RNAME.u64.bits

// set CSR mask value using XLEN=32 view
#define WR_CSR_MASK32(_CPU, _RNAME, _VALUE) (_CPU)->csrMask._RNAME.u32.bits = _VALUE

// set CSR mask value using XLEN=64 view
#define WR_CSR_MASK64(_CPU, _RNAME, _VALUE) (_CPU)->csrMask._RNAME.u64.bits = _VALUE

// get CSR mask using common view
#define RD_CSR_MASKC(_CPU, _RNAME) RD_CSR_MASK32(_CPU, _RNAME)

// get CSR mask field in XLEN=32 view
#define RD_CSR_MASK_FIELD32(_CPU, _RNAME, _FIELD) \
    (_CPU)->csrMask._RNAME.u32.fields._FIELD

// get CSR mask field in XLEN=64 view
#define RD_CSR_MASK_FIELD64(_CPU, _RNAME, _FIELD) \
    (_CPU)->csrMask._RNAME.u64.fields._FIELD

// get CSR mask field in common view
#define RD_CSR_MASK_FIELDC(_CPU, _RNAME, _FIELD) \
    RD_CSR_MASK_FIELD32(_CPU, _RNAME, _FIELD)

// mask CSR using variable mask
#define MASK_CSR(_CPU, _RNAME) \
    (_CPU)->csr._RNAME.u64.bits &= (_CPU)->csrMask._RNAME.u64.bits

// set mask to the given value in common view
#define WR_CSR_MASKC(_CPU, _RNAME, _VALUE) \
    (_CPU)->csrMask._RNAME._pad = _VALUE

// add mask to the given value in common view
#define OR_CSR_MASKC(_CPU, _RNAME, _VALUE) \
    (_CPU)->csrMask._RNAME._pad |= _VALUE

// set field mask to the given value in 32-bit view
#define WR_CSR_MASK_FIELD32(_CPU, _RNAME, _FIELD, _VALUE) \
    (_CPU)->csrMask._RNAME.u32.fields._FIELD = _VALUE

// set field mask to the given value in 64-bit view
#define WR_CSR_MASK_FIELD64(_CPU, _RNAME, _FIELD, _VALUE) \
    (_CPU)->csrMask._RNAME.u64.fields._FIELD = _VALUE

// set field mask to the given value in common view
#define WR_CSR_MASK_FIELDC(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_MASK_FIELD64(_CPU, _RNAME, _FIELD, _VALUE)

// set field mask to all 1's in 64-bit view
#define WR_CSR_MASK_FIELD64_1(_CPU, _RNAME, _FIELD) \
    WR_CSR_MASK_FIELD64(_CPU, _RNAME, _FIELD, -1)

// set field mask to all 1's in common view
#define WR_CSR_MASK_FIELDC_1(_CPU, _RNAME, _FIELD) \
    WR_CSR_MASK_FIELDC(_CPU, _RNAME, _FIELD, -1)


////////////////////////////////////////////////////////////////////////////////
// SYSTEM REGISTER ACCESS MACROS, VARIABLE FIELD POSITION BASED ON CURRENT XLEN
////////////////////////////////////////////////////////////////////////////////

// macro indicating if current XLEN is 32
#define RISCV_XLEN_IS_32C(_CPU) \
    (((_CPU)->currentArch & ISA_XLEN_32) && True)

// macro returning current XLEN in bytes
#define RISCV_XLEN_BYTESC(_CPU) \
    (RISCV_XLEN_IS_32C(_CPU) ? 4 : 8)

// get raw value using current XLEN
#define RD_RAW_CUR(_CPU, _R) ( \
    RISCV_XLEN_IS_32C(_CPU) ? RD_RAW32(_R) : RD_RAW64(_R))

// get CSR value using current XLEN
#define RD_CSR_CUR(_CPU, _RNAME) \
    RD_RAW(_CPU, (_CPU)->csr._RNAME)

// get CSR mask value using current XLEN
#define RD_CSR_MASK_CUR(_CPU, _RNAME) \
    RD_RAW(_CPU, (_CPU)->csrMask._RNAME)

// set raw value using current XLEN
#define WR_RAW_CUR(_CPU, _R, _VALUE) \
    if(RISCV_XLEN_IS_32C(_CPU)) {                       \
        WR_RAW32(_R, _VALUE);                           \
    } else {                                            \
        WR_RAW64(_R, _VALUE);                           \
    }

// bitwise-and raw value using current XLEN
#define AND_RAW_CUR(_CPU, _R, _VALUE) \
    if(RISCV_XLEN_IS_32C(_CPU)) {                       \
        AND_RAW32(_R, _VALUE);                          \
    } else {                                            \
        AND_RAW64(_R, _VALUE);                          \
    }

// bitwise-or raw value using current XLEN
#define OR_RAW_CUR(_CPU, _R, _VALUE) \
    if(RISCV_XLEN_IS_32C(_CPU)) {                       \
        OR_RAW32(_R, _VALUE);                           \
    } else {                                            \
        OR_RAW64(_R, _VALUE);                           \
    }

// set CSR value using current XLEN
#define WR_CSR_CUR(_CPU, _RNAME, _VALUE) \
    WR_RAW(_CPU, (_CPU)->csr._RNAME, _VALUE)

// get raw field using current XLEN
#define RD_RAW_FIELD_CUR(_CPU, _R, _FIELD) ( \
    (RISCV_XLEN_IS_32C(_CPU) ?                          \
        (_R).u32.fields._FIELD :                        \
        (_R).u64.fields._FIELD)                         \
)

// set raw field using current XLEN
#define WR_RAW_FIELD_CUR(_CPU, _R, _FIELD, _VALUE) \
    if(RISCV_XLEN_IS_32C(_CPU)) {                       \
        (_R).u32.fields._FIELD = _VALUE;                \
    } else {                                            \
        (_R).u64.fields._FIELD = _VALUE;                \
    }

// get CSR field using current XLEN
#define RD_CSR_FIELD_CUR(_CPU, _RNAME, _FIELD) \
    RD_RAW_FIELD_CUR(_CPU, (_CPU)->csr._RNAME, _FIELD)

// set CSR field using current XLEN
#define WR_CSR_FIELD_CUR(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_RAW_FIELD_CUR(_CPU, (_CPU)->csr._RNAME, _FIELD, _VALUE)

// get CSR mask field using current XLEN
#define RD_CSR_MASK_FIELD_CUR(_CPU, _RNAME, _FIELD) \
    RD_RAW_FIELD_CUR(_CPU, (_CPU)->csrMask._RNAME, _FIELD)

// set CSR mask field using current XLEN
#define WR_CSR_MASK_FIELD_CUR(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_RAW_FIELD_CUR(_CPU, (_CPU)->csrMask._RNAME, _FIELD, _VALUE)


////////////////////////////////////////////////////////////////////////////////
// SYSTEM REGISTER ACCESS MACROS, VARIABLE FIELD POSITION BASED ON MODAL XLEN
////////////////////////////////////////////////////////////////////////////////

// macro indicating if modal XLEN is 32
#define RISCV_XLEN_IS_32M(_CPU, _MODE5) \
    !((_CPU)->xlenMask & (1<<_MODE5))

// macro indicating if modal XLEN is 64
#define RISCV_XLEN_IS_64M(_CPU, _MODE5) \
    ((_CPU)->xlenMask & (1<<_MODE5))

// macro returning mode-specific XLEN in bytes
#define RISCV_XLEN_BYTESM(_CPU, _MODE5) \
    (RISCV_XLEN_IS_32M(_CPU, _MODE5) ? 4 : 8)

// get raw value using modal XLEN
#define RD_RAW_MODE(_CPU, _MODE, _R) ( \
    RISCV_XLEN_IS_32M(_CPU, _MODE) ? RD_RAW32(_R) : RD_RAW64(_R))

// get CSR value using modal XLEN
#define RD_CSR_MODE(_CPU, _MODE, _RNAME) \
    RD_RAW_MODE(_CPU, _MODE, (_CPU)->csr._RNAME)

// get CSR mask value using modal XLEN
#define RD_CSR_MASK_MODE(_CPU, _MODE, _RNAME) \
    RD_RAW_MODE(_CPU, _MODE, (_CPU)->csrMask._RNAME)

// set raw value using modal XLEN
#define WR_RAW_MODE(_CPU, _MODE, _R, _VALUE) \
    if(RISCV_XLEN_IS_32M(_CPU, _MODE)) {                \
        WR_RAW32(_R, _VALUE);                           \
    } else {                                            \
        WR_RAW64(_R, _VALUE);                           \
    }

// bitwise-and raw value using modal XLEN
#define AND_RAW_MODE(_CPU, _MODE, _R, _VALUE) \
    if(RISCV_XLEN_IS_32M(_CPU, _MODE)) {                \
        AND_RAW32(_R, _VALUE);                          \
    } else {                                            \
        AND_RAW64(_R, _VALUE);                          \
    }

// bitwise-or raw value using modal XLEN
#define OR_RAW_MODE(_CPU, _MODE, _R, _VALUE) \
    if(RISCV_XLEN_IS_32M(_CPU, _MODE)) {                \
        OR_RAW32(_R, _VALUE);                           \
    } else {                                            \
        OR_RAW64(_R, _VALUE);                           \
    }

// set CSR value using modal XLEN
#define WR_CSR_MODE(_CPU, _MODE, _RNAME, _VALUE) \
    WR_RAW_MODE(_CPU, _MODE, (_CPU)->csr._RNAME, _VALUE)

// set CSR mask using modal XLEN
#define WR_CSR_MASK_MODE(_CPU, _MODE, _RNAME, _VALUE) \
    WR_RAW_MODE(_CPU, _MODE, (_CPU)->csrMask._RNAME, _VALUE)

// bitwise-and CSR mask using modal XLEN
#define AND_CSR_MASK_MODE(_CPU, _MODE, _RNAME, _VALUE) \
    AND_RAW_MODE(_CPU, _MODE, (_CPU)->csrMask._RNAME, _VALUE)

// bitwise-or CSR mask using modal XLEN
#define OR_CSR_MASK_MODE(_CPU, _MODE, _RNAME, _VALUE) \
    OR_RAW_MODE(_CPU, _MODE, (_CPU)->csrMask._RNAME, _VALUE)

// get raw field using modal XLEN
#define RD_RAW_FIELD_MODE(_CPU, _MODE, _R, _FIELD) ( \
    (RISCV_XLEN_IS_32M(_CPU, _MODE) ?                   \
        (_R).u32.fields._FIELD :                        \
        (_R).u64.fields._FIELD)                         \
)

// set raw field using modal XLEN
#define WR_RAW_FIELD_MODE(_CPU, _MODE, _R, _FIELD, _VALUE) \
    if(RISCV_XLEN_IS_32M(_CPU, _MODE)) {                \
        (_R).u32.fields._FIELD = _VALUE;                \
    } else {                                            \
        (_R).u64.fields._FIELD = _VALUE;                \
    }

// get CSR field using modal XLEN
#define RD_CSR_FIELD_MODE(_CPU, _MODE, _RNAME, _FIELD) \
    RD_RAW_FIELD_MODE(_CPU, _MODE, (_CPU)->csr._RNAME, _FIELD)

// set CSR field using modal XLEN
#define WR_CSR_FIELD_MODE(_CPU, _MODE, _RNAME, _FIELD, _VALUE) \
    WR_RAW_FIELD_MODE(_CPU, _MODE, (_CPU)->csr._RNAME, _FIELD, _VALUE)

// get CSR mask field using modal XLEN
#define RD_CSR_MASK_FIELD_MODE(_CPU, _MODE, _RNAME, _FIELD) \
    RD_RAW_FIELD_MODE(_CPU, _MODE, (_CPU)->csrMask._RNAME, _FIELD)

// set CSR mask field using modal XLEN
#define WR_CSR_MASK_FIELD_MODE(_CPU, _MODE, _RNAME, _FIELD, _VALUE) \
    WR_RAW_FIELD_MODE(_CPU, _MODE, (_CPU)->csrMask._RNAME, _FIELD, _VALUE)

// get CSR value using mode-specific XLEN
#define RD_CSR_M(_CPU, _RNAME) \
    RD_CSR_MODE(_CPU, RISCV_MODE_M,  _RNAME)
#define RD_CSR_S(_CPU, _RNAME) \
    RD_CSR_MODE(_CPU, RISCV_MODE_S,  _RNAME)
#define RD_CSR_U(_CPU, _RNAME) \
    RD_CSR_MODE(_CPU, RISCV_MODE_U,  _RNAME)
#define RD_CSR_VS(_CPU, _RNAME) \
    RD_CSR_MODE(_CPU, RISCV_MODE_VS, _RNAME)
#define RD_CSR_VU(_CPU, _RNAME) \
    RD_CSR_MODE(_CPU, RISCV_MODE_VU, _RNAME)

// set CSR value using mode-specific XLEN
#define WR_CSR_M(_CPU, _RNAME, _VALUE) \
    WR_CSR_MODE(_CPU, RISCV_MODE_M,  _RNAME, _VALUE)
#define WR_CSR_S(_CPU, _RNAME, _VALUE) \
    WR_CSR_MODE(_CPU, RISCV_MODE_S,  _RNAME, _VALUE)
#define WR_CSR_U(_CPU, _RNAME, _VALUE) \
    WR_CSR_MODE(_CPU, RISCV_MODE_U,  _RNAME, _VALUE)
#define WR_CSR_VS(_CPU, _RNAME, _VALUE) \
    WR_CSR_MODE(_CPU, RISCV_MODE_VS, _RNAME, _VALUE)
#define WR_CSR_VU(_CPU, _RNAME, _VALUE) \
    WR_CSR_MODE(_CPU, RISCV_MODE_VU, _RNAME, _VALUE)

// get CSR field value using mode-specific XLEN
#define RD_CSR_FIELD_M(_CPU, _RNAME, _FIELD) \
    RD_CSR_FIELD_MODE(_CPU, RISCV_MODE_M,  _RNAME, _FIELD)
#define RD_CSR_FIELD_S(_CPU, _RNAME, _FIELD) \
    RD_CSR_FIELD_MODE(_CPU, RISCV_MODE_S,  _RNAME, _FIELD)
#define RD_CSR_FIELD_U(_CPU, _RNAME, _FIELD) \
    RD_CSR_FIELD_MODE(_CPU, RISCV_MODE_U,  _RNAME, _FIELD)
#define RD_CSR_FIELD_VS(_CPU, _RNAME, _FIELD) \
    RD_CSR_FIELD_MODE(_CPU, RISCV_MODE_VS, _RNAME, _FIELD)
#define RD_CSR_FIELD_VU(_CPU, _RNAME, _FIELD) \
    RD_CSR_FIELD_MODE(_CPU, RISCV_MODE_VU, _RNAME, _FIELD)

// set CSR field value using mode-specific XLEN
#define WR_CSR_FIELD_M(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_FIELD_MODE(_CPU, RISCV_MODE_M,  _RNAME, _FIELD, _VALUE)
#define WR_CSR_FIELD_S(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_FIELD_MODE(_CPU, RISCV_MODE_S,  _RNAME, _FIELD, _VALUE)
#define WR_CSR_FIELD_U(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_FIELD_MODE(_CPU, RISCV_MODE_U,  _RNAME, _FIELD, _VALUE)
#define WR_CSR_FIELD_VS(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_FIELD_MODE(_CPU, RISCV_MODE_VS, _RNAME, _FIELD, _VALUE)
#define WR_CSR_FIELD_VU(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_FIELD_MODE(_CPU, RISCV_MODE_VU, _RNAME, _FIELD, _VALUE)

// get CSR mask using mode-specific XLEN
#define RD_CSR_MASK_M( _CPU, _RNAME) \
    RD_CSR_MASK_MODE(_CPU, RISCV_MODE_M,  _RNAME)
#define RD_CSR_MASK_S( _CPU, _RNAME) \
    RD_CSR_MASK_MODE(_CPU, RISCV_MODE_S,  _RNAME)
#define RD_CSR_MASK_U( _CPU, _RNAME) \
    RD_CSR_MASK_MODE(_CPU, RISCV_MODE_U,  _RNAME)
#define RD_CSR_MASK_VS( _CPU, _RNAME) \
    RD_CSR_MASK_MODE(_CPU, RISCV_MODE_VS, _RNAME)
#define RD_CSR_MASK_VU( _CPU, _RNAME) \
    RD_CSR_MASK_MODE(_CPU, RISCV_MODE_VU, _RNAME)

// set CSR mask using mode-specific XLEN
#define WR_CSR_MASK_M(_CPU, _RNAME, _VALUE) \
    WR_CSR_MASK_MODE(_CPU, RISCV_MODE_M,  _RNAME, _VALUE)
#define WR_CSR_MASK_S(_CPU, _RNAME, _VALUE) \
    WR_CSR_MASK_MODE(_CPU, RISCV_MODE_S,  _RNAME, _VALUE)
#define WR_CSR_MASK_U(_CPU, _RNAME, _VALUE) \
    WR_CSR_MASK_MODE(_CPU, RISCV_MODE_U,  _RNAME, _VALUE)
#define WR_CSR_MASK_VS(_CPU, _RNAME, _VALUE) \
    WR_CSR_MASK_MODE(_CPU, RISCV_MODE_VS, _RNAME, _VALUE)
#define WR_CSR_MASK_VU(_CPU, _RNAME, _VALUE) \
    WR_CSR_MASK_MODE(_CPU, RISCV_MODE_VU, _RNAME, _VALUE)

// bitwise-and mask with the given value using mode-specific XLEN
#define AND_CSR_MASK_M(_CPU, _RNAME, _VALUE) \
    AND_CSR_MASK_MODE(_CPU, RISCV_MODE_M,  _RNAME, _VALUE)
#define AND_CSR_MASK_S(_CPU, _RNAME, _VALUE) \
    AND_CSR_MASK_MODE(_CPU, RISCV_MODE_S,  _RNAME, _VALUE)
#define AND_CSR_MASK_U(_CPU, _RNAME, _VALUE) \
    AND_CSR_MASK_MODE(_CPU, RISCV_MODE_U,  _RNAME, _VALUE)
#define AND_CSR_MASK_VS(_CPU, _RNAME, _VALUE) \
    AND_CSR_MASK_MODE(_CPU, RISCV_MODE_VS, _RNAME, _VALUE)
#define AND_CSR_MASK_VU(_CPU, _RNAME, _VALUE) \
    AND_CSR_MASK_MODE(_CPU, RISCV_MODE_VU, _RNAME, _VALUE)

// bitwise-or mask with the given value using mode-specific XLEN
#define OR_CSR_MASK_M(_CPU, _RNAME, _VALUE) \
    OR_CSR_MASK_MODE(_CPU, RISCV_MODE_M,  _RNAME, _VALUE)
#define OR_CSR_MASK_S(_CPU, _RNAME, _VALUE) \
    OR_CSR_MASK_MODE(_CPU, RISCV_MODE_S,  _RNAME, _VALUE)
#define OR_CSR_MASK_U(_CPU, _RNAME, _VALUE) \
    OR_CSR_MASK_MODE(_CPU, RISCV_MODE_U,  _RNAME, _VALUE)
#define OR_CSR_MASK_VS(_CPU, _RNAME, _VALUE) \
    OR_CSR_MASK_MODE(_CPU, RISCV_MODE_VS, _RNAME, _VALUE)
#define OR_CSR_MASK_VU(_CPU, _RNAME, _VALUE) \
    OR_CSR_MASK_MODE(_CPU, RISCV_MODE_VU, _RNAME, _VALUE)

// get CSR mask field using mode-specific XLEN
#define RD_CSR_MASK_FIELD_M(_CPU, _RNAME, _FIELD) \
    RD_CSR_MASK_FIELD_MODE(_CPU, RISCV_MODE_M,  _RNAME, _FIELD)
#define RD_CSR_MASK_FIELD_S(_CPU, _RNAME, _FIELD) \
    RD_CSR_MASK_FIELD_MODE(_CPU, RISCV_MODE_S,  _RNAME, _FIELD)
#define RD_CSR_MASK_FIELD_U(_CPU, _RNAME, _FIELD) \
    RD_CSR_MASK_FIELD_MODE(_CPU, RISCV_MODE_U,  _RNAME, _FIELD)
#define RD_CSR_MASK_FIELD_VS(_CPU, _RNAME, _FIELD) \
    RD_CSR_MASK_FIELD_MODE(_CPU, RISCV_MODE_VS, _RNAME, _FIELD)
#define RD_CSR_MASK_FIELD_VU(_CPU, _RNAME, _FIELD) \
    RD_CSR_MASK_FIELD_MODE(_CPU, RISCV_MODE_VU, _RNAME, _FIELD)

// set CSR mask field using mode-specific XLEN
#define WR_CSR_MASK_FIELD_M(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_MASK_FIELD_MODE(_CPU, RISCV_MODE_M,  _RNAME, _FIELD, _VALUE)
#define WR_CSR_MASK_FIELD_S(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_MASK_FIELD_MODE(_CPU, RISCV_MODE_S,  _RNAME, _FIELD, _VALUE)
#define WR_CSR_MASK_FIELD_U(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_MASK_FIELD_MODE(_CPU, RISCV_MODE_U,  _RNAME, _FIELD, _VALUE)
#define WR_CSR_MASK_FIELD_VS(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_MASK_FIELD_MODE(_CPU, RISCV_MODE_VS, _RNAME, _FIELD, _VALUE)
#define WR_CSR_MASK_FIELD_VU(_CPU, _RNAME, _FIELD, _VALUE) \
    WR_CSR_MASK_FIELD_MODE(_CPU, RISCV_MODE_VU, _RNAME, _FIELD, _VALUE)


////////////////////////////////////////////////////////////////////////////////
// SYSTEM REGISTER FIELD MIGRATION
////////////////////////////////////////////////////////////////////////////////

// migrate field and write mask from MXLEN=64 location to MXLEN=32 location
#define MV_CSR_FIELD_MASK_64_32(_P, _R, _F) { \
                                                        \
    /* enable value in MXLEN=32 location */             \
    WR_CSR_MASK_FIELD32(_P, _R, _F, -1);                \
                                                        \
    /* disable value in MXLEN=64 location */            \
    WR_CSR_FIELD64(_P, _R, _F, 0);                      \
    WR_CSR_MASK_FIELD64(_P, _R, _F, 0);                 \
}

// migrate field and write mask from MXLEN=64 location to MXLEN=32 location
#define MV_CSR_FIELD_MASK_32_64(_P, _R, _F) { \
                                                        \
    /* enable value in MXLEN=64 location */             \
    WR_CSR_MASK_FIELD64(_P, _R, _F, -1);                \
                                                        \
    /* disable value in MXLEN=32 location */            \
    WR_CSR_FIELD32(_P, _R, _F, 0);                      \
    WR_CSR_MASK_FIELD32(_P, _R, _F, 0);                 \
}


////////////////////////////////////////////////////////////////////////////////
// SYSTEM REGISTER ACCESS MACROS (NORMAL OR VIRTUAL ALIAS, CONSTANT FIELD
// POSITION)
////////////////////////////////////////////////////////////////////////////////

// get CSR value in common view
#define RD_CSRC_V(_CPU, _RNAME, _V) ( \
    (_V) ?                                                  \
        RD_CSRC(_CPU, v##_RNAME) :                          \
        RD_CSRC(_CPU, _RNAME)                               \
)

// set CSR value in common view
#define WR_CSRC_V(_CPU, _RNAME, _V, _VALUE) \
    if(_V) {                                                \
        WR_CSRC(_CPU, v##_RNAME, _VALUE);                   \
    } else {                                                \
        WR_CSRC(_CPU, _RNAME, _VALUE);                      \
    }

// get CSR field in common view
#define RD_CSR_FIELDC_V(_CPU, _RNAME, _V, _FIELD) ( \
    (_V) ?                                                  \
        RD_CSR_FIELDC(_CPU, v##_RNAME, _FIELD) :            \
        RD_CSR_FIELDC(_CPU, _RNAME, _FIELD)                 \
)

// set CSR field in common view
#define WR_CSR_FIELDC_V(_CPU, _RNAME, _V, _FIELD, _VALUE) \
    if(_V) {                                                \
        WR_CSR_FIELDC(_CPU, v##_RNAME, _FIELD, _VALUE);     \
    } else {                                                \
        WR_CSR_FIELDC(_CPU, _RNAME, _FIELD, _VALUE);        \
    }


////////////////////////////////////////////////////////////////////////////////
// SYSTEM REGISTER ACCESS MACROS (NORMAL OR VIRTUAL ALIAS, VARIABLE FIELD
// POSITION)
////////////////////////////////////////////////////////////////////////////////

// get CSR value using current XLEN
#define RD_CSR_V(_CPU, _RNAME, _V) ( \
    (_V) ?                                                  \
        RD_CSR_VS(_CPU, v##_RNAME) :                        \
        RD_CSR_S(_CPU, _RNAME)                              \
)

// set CSR value using current XLEN
#define WR_CSR_V(_CPU, _RNAME, _V, _VALUE) \
    if(_V) {                                                \
        WR_CSR_VS(_CPU, v##_RNAME, _VALUE);                 \
    } else {                                                \
        WR_CSR_S(_CPU, _RNAME, _VALUE);                     \
    }

// get CSR field using current XLEN
#define RD_CSR_FIELD_V(_CPU, _RNAME, _V, _FIELD) ( \
    (_V) ?                                                  \
        RD_CSR_FIELD_VS(_CPU, v##_RNAME, _FIELD) :          \
        RD_CSR_FIELD_S(_CPU, _RNAME, _FIELD)                \
)

// set CSR field using current XLEN
#define WR_CSR_FIELD_V(_CPU, _RNAME, _V, _FIELD, _VALUE) \
    if(_V) {                                                \
        WR_CSR_FIELD_VS(_CPU, v##_RNAME, _FIELD, _VALUE);   \
    } else {                                                \
        WR_CSR_FIELD_S(_CPU, _RNAME, _FIELD, _VALUE);       \
    }


////////////////////////////////////////////////////////////////////////////////
// TRIGGER REGISTER ACCESS MACROS, CONSTANT FIELD POSITION
////////////////////////////////////////////////////////////////////////////////

// get trigger value
#define RD_REG_TRIGGER(_TRIGGER, _R) ( \
    RD_RAWC(_TRIGGER->_R))

// set trigger value
#define WR_REG_TRIGGER(_TRIGGER, _R, _VALUE) \
    WR_RAWC(_TRIGGER->_R, _VALUE)

// get trigger field
#define RD_REG_FIELD_TRIGGER(_TRIGGER, _R, _FIELD) ( \
    RD_RAW_FIELDC(_TRIGGER->_R, _FIELD))

// set trigger field
#define WR_REG_FIELD_TRIGGER(_TRIGGER, _R, _FIELD, _VALUE) \
    WR_RAW_FIELDC(_TRIGGER->_R, _FIELD, _VALUE)


////////////////////////////////////////////////////////////////////////////////
// TRIGGER REGISTER ACCESS MACROS, 64-BIT ONLY
////////////////////////////////////////////////////////////////////////////////

// get trigger value
#define RD_REG_TRIGGER64(_TRIGGER, _R) ( \
    RD_RAW64(_TRIGGER->_R))

// set trigger value
#define WR_REG_TRIGGER64(_TRIGGER, _R, _VALUE) \
    WR_RAW64(_TRIGGER->_R, _VALUE)

// get trigger field
#define RD_REG_FIELD_TRIGGER64(_TRIGGER, _R, _FIELD) ( \
    RD_RAW_FIELD64(_TRIGGER->_R, _FIELD))

// set trigger field
#define WR_REG_FIELD_TRIGGER64(_TRIGGER, _R, _FIELD, _VALUE) \
    WR_RAW_FIELD64(_TRIGGER->_R, _FIELD, _VALUE)


////////////////////////////////////////////////////////////////////////////////
// TRIGGER REGISTER ACCESS MACROS, VARIABLE FIELD POSITION BASED ON MODAL XLEN
////////////////////////////////////////////////////////////////////////////////

// is the trigger mode 32-bit?
#define TRIGGER_IS_32M(_CPU) \
    RISCV_XLEN_IS_32M(_CPU, RISCV_MODE_M)

// get trigger value
#define RD_REG_TRIGGER_MODE(_CPU, _TRIGGER, _R) ( \
    RD_RAW_MODE(_CPU, RISCV_MODE_M, _TRIGGER->_R))

// set trigger value
#define WR_REG_TRIGGER_MODE(_CPU, _TRIGGER, _R, _VALUE) \
    WR_RAW_MODE(_CPU, RISCV_MODE_M, _TRIGGER->_R, _VALUE)

// get raw trigger field
#define RD_RAW_FIELD_TRIGGER_MODE(_CPU, _R, _FIELD) ( \
    RD_RAW_FIELD_MODE(_CPU, RISCV_MODE_M, _R, _FIELD))

// set raw trigger field
#define WR_RAW_FIELD_TRIGGER_MODE(_CPU, _R, _FIELD, _VALUE) \
    WR_RAW_FIELD_MODE(_CPU, RISCV_MODE_M, _R, _FIELD, _VALUE)

// get trigger field
#define RD_REG_FIELD_TRIGGER_MODE(_CPU, _TRIGGER, _R, _FIELD) ( \
    RD_RAW_FIELD_TRIGGER_MODE(_CPU, _TRIGGER->_R, _FIELD))

// set trigger field
#define WR_REG_FIELD_TRIGGER_MODE(_CPU, _TRIGGER, _R, _FIELD, _VALUE) \
    WR_RAW_FIELD_TRIGGER_MODE(_CPU, _TRIGGER->_R, _FIELD, _VALUE)


////////////////////////////////////////////////////////////////////////////////
// MORPH-TIME SYSTEM REGISTER ACCESS MACROS
////////////////////////////////////////////////////////////////////////////////

//
// Morph-time macros to access a CSR register by id
//
#define CSR_REG_MT(_ID)     RISCV_CPU_REG(csr._ID)

//
// Morph-time macros to access a CSR register high half by id
//
#define CSR_REGH_MT(_ID)    RISCV_CPU_REGH(csr._ID)

//
// Morph-time macros to access a CSR register mask by id
//
#define CSR_MASK_MT(_ID)    RISCV_CPU_REG(csrMask._ID)

//
// Morph-time macros to access a CSR register high half mask by id
//
#define CSR_MASKH_MT(_ID)   RISCV_CPU_REGH(csrMask._ID)

