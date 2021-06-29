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

// basic number types
#include "hostapi/impTypes.h"

// VMI header files
#include "vmi/vmiDbg.h"

// model header files
#include "riscvCSR.h"
#include "riscvDerivedMorph.h"
#include "riscvExceptionTypes.h"
#include "riscvMode.h"
#include "riscvModelCallbackTypes.h"
#include "riscvRegisterTypes.h"
#include "riscvTypes.h"
#include "riscvTypeRefs.h"
#include "riscvVariant.h"
#include "riscvVectorTypes.h"


////////////////////////////////////////////////////////////////////////////////
// IMPLEMENTED BY BASE MODEL
////////////////////////////////////////////////////////////////////////////////

//
// Register extension callback block with the base model
//
#define RISCV_REGISTER_EXT_CB_FN(_NAME) void _NAME( \
    riscvP      riscv,  \
    riscvExtCBP extCB,  \
    Uns32       id      \
)
typedef RISCV_REGISTER_EXT_CB_FN((*riscvRegisterExtCBFn));

//
// Return the indexed extension's extCB clientData
//
#define RISCV_GET_EXT_CLIENT_DATA_FN(_NAME) void *_NAME( \
    riscvP riscv,      \
    Uns32  id          \
)
typedef RISCV_GET_EXT_CLIENT_DATA_FN((*riscvGetExtClientDataFn));

//
// Return the indexed extension configuration
//
#define RISCV_GET_EXT_CONFIG_FN(_NAME) riscvExtConfigCP _NAME( \
    riscvP riscv,   \
    Uns32  id       \
)
typedef RISCV_GET_EXT_CONFIG_FN((*riscvGetExtConfigFn));

//
// Return the current XLEN
//
#define RISCV_GET_XLEN_FN(_NAME) Uns32 _NAME(riscvP riscv)
typedef RISCV_GET_XLEN_FN((*riscvGetXlenFn));

//
// Return the indexed register name
//
#define RISCV_GET_REG_NAME_FN(_NAME) const char *_NAME(Uns32 index)
typedef RISCV_GET_REG_NAME_FN((*riscvGetRegNameFn));

//
// Enable or disable transaction mode
//
#define RISCV_SET_TMODE_FN(_NAME) void _NAME(riscvP riscv, Bool enable)
typedef RISCV_SET_TMODE_FN((*riscvSetTModeFn));

//
// Return true if in transaction mode
//
#define RISCV_GET_TMODE_FN(_NAME) Bool _NAME(riscvP riscv)
typedef RISCV_GET_TMODE_FN((*riscvGetTModeFn));

//
// Return data endianness in the given processor mode
//
#define RISCV_GET_DATA_ENDIAN_FN(_NAME) memEndian _NAME( \
    riscvP    riscv,    \
    riscvMode mode      \
)
typedef RISCV_GET_DATA_ENDIAN_FN((*riscvGetDataEndianFn));

//
// Read a CSR in the base model given its number
//
#define RISCV_READ_CSR_NUM_FN(_NAME) Uns64 _NAME( \
    riscvP riscv,               \
    Uns32  csrNum               \
)
typedef RISCV_READ_CSR_NUM_FN((*riscvReadCSRNumFn));

//
// Write a CSR in the base model given its number
//
#define RISCV_WRITE_CSR_NUM_FN(_NAME) Uns64 _NAME( \
    riscvP riscv,               \
    Uns32  csrNum,              \
    Uns64  newValue             \
)
typedef RISCV_WRITE_CSR_NUM_FN((*riscvWriteCSRNumFn));

//
// Read a CSR in the base model given its id
//
#define RISCV_READ_BASE_CSR_FN(_NAME) Uns64 _NAME( \
    riscvP     riscv,           \
    riscvCSRId id               \
)
typedef RISCV_READ_BASE_CSR_FN((*riscvReadBaseCSRFn));

//
// Write a CSR in the base model given its id
//
#define RISCV_WRITE_BASE_CSR_FN(_NAME) Uns64 _NAME( \
    riscvP     riscv,           \
    riscvCSRId id,              \
    Uns64      newValue         \
)
typedef RISCV_WRITE_BASE_CSR_FN((*riscvWriteBaseCSRFn));

//
// Halt or restart the processor for the given reason
//
#define RISCV_HALT_RESTART_FN(_NAME) void _NAME( \
    riscvP             riscv,   \
    riscvDisableReason reason   \
)
typedef RISCV_HALT_RESTART_FN((*riscvHaltRestartFn));

//
// Update the indexed standard interrupt
//
#define RISCV_UPDATE_INTERRUPT_FN(_NAME) void _NAME( \
    riscvP riscv,               \
    Uns32  index,               \
    Bool   newValue             \
)
typedef RISCV_UPDATE_INTERRUPT_FN((*riscvUpdateInterruptFn));

//
// Update mask of externally-disabled interrupts
//
#define RISCV_UPDATE_DISABLE_FN(_NAME) void _NAME( \
    riscvP riscv,               \
    Uns64  disableMask          \
)
typedef RISCV_UPDATE_DISABLE_FN((*riscvUpdateDisableFn));

//
// Check for pending interrupts
//
#define RISCV_TEST_INTERRUPT_FN(_NAME) void _NAME(riscvP riscv)
typedef RISCV_TEST_INTERRUPT_FN((*riscvTestInterruptFn));

//
// Take Illegal Instruction exception
//
#define RISCV_ILLEGAL_INSTRUCTION_FN(_NAME) void _NAME(riscvP riscv)
typedef RISCV_ILLEGAL_INSTRUCTION_FN((*riscvIllegalInstructionFn));

//
// Take Illegal Instruction exception issuing message in verbose mode
//
#define RISCV_ILLEGAL_VERBOSE_FN(_NAME) void _NAME( \
    riscvP      riscv,          \
    const char *reason          \
)
typedef RISCV_ILLEGAL_VERBOSE_FN((*riscvIllegalVerboseFn));

//
// Take processor exception
//
#define RISCV_TAKE_EXCEPTION_FN(_NAME) void _NAME( \
    riscvP         riscv,       \
    riscvException exception,   \
    Uns64          tval         \
)
typedef RISCV_TAKE_EXCEPTION_FN((*riscvTakeExceptionFn));

//
// Take processor reset
//
#define RISCV_TAKE_RESET_FN(_NAME) void _NAME(riscvP riscv)
typedef RISCV_TAKE_RESET_FN((*riscvTakeResetFn));

//
// Fetch an instruction at the given simulated address and if it matches a
// decode pattern in the given instruction table unpack the instruction fields
// into 'info'
//
#define RISCV_FETCH_INSTRUCTION_FN(_NAME) Uns32 _NAME( \
    riscvP               riscv,     \
    riscvAddr            thisPC,    \
    riscvExtInstrInfoP   info,      \
    vmidDecodeTablePP    tableP,    \
    riscvExtInstrAttrsCP attrs,     \
    Uns32                last,      \
    Uns32                bits       \
)
typedef RISCV_FETCH_INSTRUCTION_FN((*riscvFetchInstructionFn));

//
// Disassemble unpacked instruction using the given format
//
#define RISCV_DISASS_INSTRUCTION_FN(_NAME) const char *_NAME( \
    riscvP             riscv,       \
    riscvExtInstrInfoP instrInfo,   \
    vmiDisassAttrs     attrs        \
)
typedef RISCV_DISASS_INSTRUCTION_FN((*riscvDisassInstructionFn));

//
// Validate that the instruction is supported and enabled and take an Illegal
// Instruction exception if not
//
#define RISCV_INSTRUCTION_ENABLED_FN(_NAME) Bool _NAME( \
    riscvP            riscv,            \
    riscvArchitecture requiredVariant   \
)
typedef RISCV_INSTRUCTION_ENABLED_FN((*riscvInstructionEnabledFn));

//
// Translate externally-implemented instruction
//
#define RISCV_MORPH_EXTERNAL_FN(_NAME) void _NAME( \
    riscvExtMorphStateP state,          \
    const char         *disableReason,  \
    Bool               *opaque          \
);
typedef RISCV_MORPH_EXTERNAL_FN((*riscvMorphExternalFn));

//
// Emit code to take an illegal instruction exception with the given reason
//
#define RISCV_MORPH_ILLEGAL_FN(_NAME) void _NAME( \
    riscvP      riscv,  \
    const char *reason  \
)
typedef RISCV_MORPH_ILLEGAL_FN((*riscvMorphIllegalFn));

//
// Return VMI register for the given abstract register
//
#define RISCV_GET_VMI_REG_FN(_NAME) vmiReg _NAME(riscvP riscv, riscvRegDesc r)
typedef RISCV_GET_VMI_REG_FN((*riscvGetVMIRegFn));

//
// Return VMI register for the given abstract register which may require a NaN
// box test if it is floating point
//
#define RISCV_GET_VMI_REG_FS_FN(_NAME) vmiReg _NAME( \
    riscvP       riscv,     \
    riscvRegDesc r,         \
    vmiReg       tmp        \
)
typedef RISCV_GET_VMI_REG_FS_FN((*riscvGetVMIRegFSFn));

//
// Do actions when a register is written (extending or NaN boxing, if
// required)
//
#define RISCV_WRITE_REG_SIZE_FN(_NAME) void _NAME( \
    riscvP       riscv,     \
    riscvRegDesc r,         \
    Uns32        srcBits,   \
    Bool         signExtend \
)
typedef RISCV_WRITE_REG_SIZE_FN((*riscvWriteRegSizeFn));

//
// Do actions when a register is written (extending or NaN boxing, if
// required) using the derived register size
//
#define RISCV_WRITE_REG_FN(_NAME) void _NAME( \
    riscvP       riscv,     \
    riscvRegDesc r,         \
    Bool         signExtend \
)
typedef RISCV_WRITE_REG_FN((*riscvWriteRegFn));

//
// Return VMI register for floating point status flags when written
//
#define RISCV_GET_FP_FLAGS_MT_FN(_NAME) vmiReg _NAME(riscvP riscv)
typedef RISCV_GET_FP_FLAGS_MT_FN((*riscvGetFPFlagsMtFn));

//
// Return data endianness in the current processor mode at morph time
//
#define RISCV_GET_DATA_ENDIAN_MT_FN(_NAME) memEndian _NAME(riscvP riscv)
typedef RISCV_GET_DATA_ENDIAN_MT_FN((*riscvGetDataEndianMtFn));

//
// Validate the hart is in the given mode or a more privileged one and emit an
// Illegal Instruction exception call if not
//
#define RISCV_REQUIRE_MODE_MT_FN(_NAME) Bool _NAME( \
    riscvP    riscv,    \
    riscvMode mode      \
)
typedef RISCV_REQUIRE_MODE_MT_FN((*riscvRequireModeMtFn));

//
// Validate the hart is not in virtual mode and  and emit a Virtual Instruction
// exception call if not
//
#define RISCV_REQUIRE_NOT_V_MT_FN(_NAME) Bool _NAME(riscvP riscv)
typedef RISCV_REQUIRE_NOT_V_MT_FN((*riscvRequireNotVMtFn));

//
// Validate the given rounding mode is legal and emit an Illegal Instruction
// exception call if not
//
#define RISCV_CHECK_LEGAL_RM_MT_FN(_NAME) Bool _NAME( \
    riscvP      riscv,  \
    riscvRMDesc rm      \
)
typedef RISCV_CHECK_LEGAL_RM_MT_FN((*riscvCheckLegalRMMtFn));

//
// Emit trap when mstatus.TVM=1 in Supervisor mode
//
#define RISCV_MORPH_TRAP_TVM_FN(_NAME) void _NAME(riscvP riscv)
typedef RISCV_MORPH_TRAP_TVM_FN((*riscvMorphTrapTVMFn));

//
// Emit vector operation from extension library
//
#define RISCV_MORPH_VOP_FN(_NAME) void _NAME( \
    riscvP           riscv,         \
    Uns64            thisPC,        \
    riscvRegDesc     r0,            \
    riscvRegDesc     r1,            \
    riscvRegDesc     r2,            \
    riscvRegDesc     mask,          \
    riscvVShape      shape,         \
    riscvVExternalFn externalCB,    \
    void            *userData       \
)
typedef RISCV_MORPH_VOP_FN((*riscvMorphVOpFn));

//
// Register new CSR
//
#define RISCV_NEW_CSR_FN(_NAME) void _NAME( \
    riscvCSRAttrsP  attrs,          \
    riscvCSRAttrsCP src,            \
    riscvP          riscv,          \
    vmiosObjectP    object          \
)
typedef RISCV_NEW_CSR_FN((*riscvNewCSRFn));

//
// Try mapping memory at the passed address for the specified access type and
// return a status code indicating if virtual mapping failed
//
#define RISCV_MAP_ADDRESS_FN(_NAME) Bool _NAME( \
    riscvP         riscv,           \
    memDomainP     domain,          \
    memPriv        requiredPriv,    \
    Uns64          address,         \
    Uns32          bytes,           \
    memAccessAttrs attrs            \
)
typedef RISCV_MAP_ADDRESS_FN((*riscvMapAddressFn));

//
// Unmap the indexed PMP region
//
#define RISCV_UNMAP_PMP_REGION_FN(_NAME) void _NAME( \
    riscvP riscv,                   \
    Uns32  regionIndex              \
)
typedef RISCV_UNMAP_PMP_REGION_FN((*riscvUnmapPMPRegionFn));

//
// Update load/store domain on state change
//
#define RISCV_UPDATE_LD_ST_DOMAIN_FN(_NAME) void _NAME(riscvP riscv)
typedef RISCV_UPDATE_LD_ST_DOMAIN_FN((*riscvUpdateLdStDomainFn));

//
// Create new TLB entry
//
#define RISCV_NEW_TLB_ENTRY_FN(_NAME) void _NAME( \
    riscvP            riscv,        \
    riscvTLBId        tlbId,        \
    riscvExtVMMapping mapping       \
)
typedef RISCV_NEW_TLB_ENTRY_FN((*riscvNewTLBEntryFn));

//
// Free TLB entry
//
#define RISCV_FREE_TLB_ENTRY_FN(_NAME) void _NAME( \
    riscvP     riscv,               \
    riscvTLBId tlbId,               \
    Uns16      entryId              \
)
typedef RISCV_FREE_TLB_ENTRY_FN((*riscvFreeTLBEntryFn));


////////////////////////////////////////////////////////////////////////////////
// IMPLEMENTED BY DERIVED MODEL
////////////////////////////////////////////////////////////////////////////////

//
// Callback indicate whether misaligned read or write accesses should be
// indicated by access fault exceptions instead of the default address
// misaligned exceptions
//
#define RISCV_RD_WR_FAULT_FN(_NAME) Bool _NAME( \
    riscvP     riscv,           \
    memDomainP domain,          \
    Addr       address,         \
    Uns32      bytes,           \
    void      *clientData       \
)
typedef RISCV_RD_WR_FAULT_FN((*riscvRdWrFaultFn));

//
// Callback to handle misaligned read or write accesses when these should either
// cause the read/write address to be snapped or cause the read/written value to
// be rotated, or both. The return value should be constructed using the
// MEM_SNAP macro defined in vmiTypes.h. A return value of zero indicates no
// address snapping or rotation is required and that the read alignment
// exception handler should be called.
//
#define RISCV_RD_WR_SNAP_FN(_NAME) Uns32 _NAME( \
    riscvP     riscv,           \
    memDomainP domain,          \
    Addr       address,         \
    Uns32      bytes,           \
    atomicCode atomic,          \
    void      *clientData       \
)
typedef RISCV_RD_WR_SNAP_FN((*riscvRdWrSnapFn));

//
// Should a memory exception of the given type be suppressed or raised as
// normal?
//
#define RISCV_SUPPRESS_MEM_EXCEPT_FN(_NAME) Bool _NAME( \
    riscvP         riscv,       \
    riscvException exception,   \
    void          *clientData   \
)
typedef RISCV_SUPPRESS_MEM_EXCEPT_FN((*riscvSuppressMemExceptFn));

//
// Implementation-specific NMI
//
#define RISCV_CUSTOM_NMI_FN(_NAME) Bool _NAME( \
    riscvP riscv,               \
    void  *clientData           \
)
typedef RISCV_CUSTOM_NMI_FN((*riscvCustomNMIFn));

//
// Notifier called on trap entry or exception return
//
#define RISCV_TRAP_NOTIFIER_FN(_NAME) void _NAME( \
    riscvP    riscv,            \
    riscvMode mode,             \
    void     *clientData        \
)
typedef RISCV_TRAP_NOTIFIER_FN((*riscvTrapNotifierFn));

//
// Notifier called at reset
//
#define RISCV_RESET_NOTIFIER_FN(_NAME) void _NAME( \
    riscvP riscv,               \
    void  *clientData           \
)
typedef RISCV_RESET_NOTIFIER_FN((*riscvResetNotifierFn));

//
// Return first exception in the derived model
//
#define RISCV_FIRST_EXCEPTION_FN(_NAME) vmiExceptionInfoCP _NAME( \
    riscvP riscv,               \
    void  *clientData           \
)
typedef RISCV_FIRST_EXCEPTION_FN((*riscvFirstExceptionFn));

//
// Return priority for the indexed custom interrupt
//
#define RISCV_GET_INTERRUPT_PRI_FN(_NAME) riscvExceptionPriority _NAME( \
    riscvP riscv,               \
    Uns32  intNum,              \
    void  *clientData           \
)
typedef RISCV_GET_INTERRUPT_PRI_FN((*riscvGetInterruptPriFn));

//
// Called when core has either halted or restarted
//
#define RISCV_HR_NOTIFIER_FN(_NAME) void _NAME( \
    riscvP riscv,               \
    void  *clientData           \
)
typedef RISCV_HR_NOTIFIER_FN((*riscvHRNotifierFn));

//
// Called when LR/SC sequence is aborted
//
#define RISCV_LRSC_ABORT_FN(_NAME) void _NAME( \
    riscvP riscv,               \
    void  *clientData           \
)
typedef RISCV_LRSC_ABORT_FN((*riscvLRSCAbortFn));

//
// Notifier called on a model context switch. 'state' describes the new state.
//
#define RISCV_IASSWITCH_FN(_NAME) void _NAME( \
    riscvP         riscv,       \
    vmiIASRunState state,       \
    void          *clientData   \
)
typedef RISCV_IASSWITCH_FN((*riscvIASSwitchFn));

//
// Implement a load that is part of a transaction of the given size in bytes
// from the given virtual address, writing the loaded value to the buffer
//
#define RISCV_TLOAD_FN(_NAME) void _NAME( \
    riscvP riscv,               \
    void  *buffer,              \
    Addr   VA,                  \
    Uns32  bytes,               \
    void  *clientData           \
)
typedef RISCV_TLOAD_FN((*riscvTLoadFn));

//
// Implement a store that is part of a transaction of the given size in bytes
// to the given virtual address, taking the value from the buffer
//
#define RISCV_TSTORE_FN(_NAME) void _NAME( \
    riscvP      riscv,          \
    const void *buffer,         \
    Addr        VA,             \
    Uns32       bytes,          \
    void       *clientData      \
)
typedef RISCV_TSTORE_FN((*riscvTStoreFn));

//
// Refine access privilege for accesses to the indicated PMP region
//
#define RISCV_PMP_PRIV_FN(_NAME) memPriv _NAME( \
    riscvP  riscv,              \
    memPriv priv,               \
    Uns32   regionIndex,        \
    void   *clientData          \
)
typedef RISCV_PMP_PRIV_FN((*riscvPMPPrivFn));

//
// Does the extension implement PMA mapping?
//
#define RISCV_PMA_ENABLE_FN(_NAME) Bool _NAME( \
    riscvP riscv,               \
    void  *clientData           \
)
typedef RISCV_PMA_ENABLE_FN((*riscvPMAEnableFn));

//
// Implement PMA check for the given address range
//
#define RISCV_PMA_CHECK_FN(_NAME) void _NAME( \
    riscvP    riscv,            \
    riscvMode mode,             \
    memPriv   requiredPriv,     \
    Uns64     lowPA,            \
    Uns64     highPA,           \
    void     *clientData        \
)
typedef RISCV_PMA_CHECK_FN((*riscvPMACheckFn));

//
// Implement trap for attempted TLB lookup of the given address
//
#define RISCV_VM_TRAP_FN(_NAME) riscvException _NAME( \
    riscvP     riscv,           \
    riscvTLBId id,              \
    memPriv    requiredPriv,    \
    Uns64      VA,              \
    void      *clientData       \
)
typedef RISCV_VM_TRAP_FN((*riscvVMTrapFn));

//
// Do custom checks to indicate whether a PTE is valid
//
#define RISCV_VALID_PTE_FN(_NAME) Bool _NAME( \
    riscvP      riscv,          \
    riscvTLBId  id,             \
    riscvVAMode vaMode,         \
    Uns64       PTE,            \
    void       *clientData      \
)
typedef RISCV_VALID_PTE_FN((*riscvValidPTEFn));

//
// Notifier called when current data domain is refreshed
//
#define RISCV_SET_DOMAIN_NOTIFIER_FN(_NAME) void _NAME( \
    riscvP      riscv,          \
    memDomainPP domainP,        \
    void       *clientData      \
)
typedef RISCV_SET_DOMAIN_NOTIFIER_FN((*riscvSetDomainNotifierFn));

//
// Notifier called when TLB entry is deleted
//
#define RISCV_FREE_ENTRY_NOTIFIER_FN(_NAME) void _NAME( \
    riscvP     riscv,           \
    riscvTLBId id,              \
    Uns16      entryId,         \
    void      *clientData       \
)
typedef RISCV_FREE_ENTRY_NOTIFIER_FN((*riscvFreeEntryNotifierFn));

//
// Document extension-specific restrictions
//
#define RISCV_RESTRICTIONS_FN(_NAME) void _NAME( \
    riscvP      riscv,          \
    vmiDocNodeP node,           \
    void       *clientData      \
)
typedef RISCV_RESTRICTIONS_FN((*riscvRestrictionsFn));

//
// Container structure for all callbacks implemented by the base model
//
typedef struct riscvModelCBS {

    // from riscvUtils.h
    riscvRegisterExtCBFn      registerExtCB;
    riscvGetExtClientDataFn   getExtClientData;
    riscvGetExtConfigFn       getExtConfig;
    riscvGetXlenFn            getXlenMode;
    riscvGetXlenFn            getXlenArch;
    riscvGetRegNameFn         getXRegName;
    riscvGetRegNameFn         getFRegName;
    riscvGetRegNameFn         getVRegName;
    riscvSetTModeFn           setTMode;
    riscvGetTModeFn           getTMode;
    riscvGetDataEndianFn      getDataEndian;
    riscvReadCSRNumFn         readCSR;
    riscvWriteCSRNumFn        writeCSR;
    riscvReadBaseCSRFn        readBaseCSR;
    riscvWriteBaseCSRFn       writeBaseCSR;

    // from riscvExceptions.h
    riscvHaltRestartFn        halt;
    riscvHaltRestartFn        restart;
    riscvUpdateInterruptFn    updateInterrupt;
    riscvUpdateDisableFn      updateDisable;
    riscvTestInterruptFn      testInterrupt;
    riscvIllegalInstructionFn illegalInstruction;
    riscvIllegalVerboseFn     illegalVerbose;
    riscvIllegalInstructionFn virtualInstruction;
    riscvIllegalVerboseFn     virtualVerbose;
    riscvTakeExceptionFn      takeException;
    riscvTakeResetFn          takeReset;

    // from riscvDecode.h
    riscvFetchInstructionFn   fetchInstruction;

    // from riscvDisassemble.h
    riscvDisassInstructionFn  disassInstruction;

    // from riscvMorph.h
    riscvInstructionEnabledFn instructionEnabled;
    riscvMorphExternalFn      morphExternal;
    riscvMorphIllegalFn       morphIllegal;
    riscvMorphIllegalFn       morphVirtual;
    riscvGetVMIRegFn          getVMIReg;
    riscvGetVMIRegFSFn        getVMIRegFS;
    riscvWriteRegSizeFn       writeRegSize;
    riscvWriteRegFn           writeReg;
    riscvGetFPFlagsMtFn       getFPFlagsMt;
    riscvGetDataEndianMtFn    getDataEndianMt;
    riscvRequireModeMtFn      requireModeMt;
    riscvRequireNotVMtFn      requireNotVMt;
    riscvCheckLegalRMMtFn     checkLegalRMMt;
    riscvMorphTrapTVMFn       morphTrapTVM;
    riscvMorphVOpFn           morphVOp;

    // from riscvCSR.h
    riscvNewCSRFn             newCSR;

    // from riscvVM.h
    riscvMapAddressFn         mapAddress;
    riscvUnmapPMPRegionFn     unmapPMPRegion;
    riscvUpdateLdStDomainFn   updateLdStDomain;
    riscvNewTLBEntryFn        newTLBEntry;
    riscvFreeTLBEntryFn       freeTLBEntry;

} riscvModelCB;

//
// Container structure for all callbacks implemented by an extension
//
typedef struct riscvExtCBS {

    // link pointer and id (maintained by base model)
    riscvExtCBP               next;
    Uns32                     id;

    // handle back to client data
    void                     *clientData;

    // exception modification
    riscvRdWrFaultFn          rdFaultCB;
    riscvRdWrFaultFn          wrFaultCB;
    riscvRdWrSnapFn           rdSnapCB;
    riscvRdWrSnapFn           wrSnapCB;

    // exception actions
    riscvSuppressMemExceptFn  suppressMemExcept;
    riscvCustomNMIFn          customNMI;
    riscvTrapNotifierFn       trapNotifier;
    riscvTrapNotifierFn       trapPreNotifier;
    riscvTrapNotifierFn       ERETNotifier;
    riscvResetNotifierFn      resetNotifier;
    riscvFirstExceptionFn     firstException;
    riscvGetInterruptPriFn    getInterruptPri;

    // halt/restart actions
    riscvHRNotifierFn         haltRestartNotifier;
    riscvLRSCAbortFn          LRSCAbortFn;

    // code generation actions
    riscvDerivedMorphFn       preMorph;
    riscvDerivedMorphFn       postMorph;

    // transaction support actions
    riscvIASSwitchFn          switchCB;
    riscvTLoadFn              tLoad;
    riscvTStoreFn             tStore;

    // PMP support actions
    riscvPMPPrivFn            PMPPriv;

    // PMA check actions
    riscvPMAEnableFn          PMAEnable;
    riscvPMACheckFn           PMACheck;

    // virtual memory actions
    riscvVMTrapFn             VMTrap;
    riscvValidPTEFn           validPTE;
    riscvSetDomainNotifierFn  setDomainNotifier;
    riscvFreeEntryNotifierFn  freeEntryNotifier;

    // documentation
    riscvRestrictionsFn       restrictionsCB;

} riscvExtCB;

//
// Invoke body for all extensions implementing the callback
//
#define ITER_EXT_CB(_P, _EXT, _CB, _BODY) { \
                                                            \
    riscvExtCBP _EXT;                                       \
                                                            \
    for(_EXT=_P->extCBs; _EXT; _EXT=_EXT->next) {           \
        if(_EXT->_CB) {                                     \
            _BODY;                                          \
        }                                                   \
    }                                                       \
}

//
// Invoke body for all extensions implementing the callback while condition holds
//
#define ITER_EXT_CB_WHILE(_P, _EXT, _CB, _COND, _BODY) { \
                                                            \
    riscvExtCBP _EXT;                                       \
                                                            \
    for(_EXT=_P->extCBs; _COND && _EXT; _EXT=_EXT->next) {  \
        if(_EXT->_CB) {                                     \
            _BODY;                                          \
        }                                                   \
    }                                                       \
}


