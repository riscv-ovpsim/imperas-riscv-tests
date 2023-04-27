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

// model header files
#include "riscvFeatures.h"
#include "riscvModelCallbacks.h"
#include "riscvTypeRefs.h"


////////////////////////////////////////////////////////////////////////////////
// LAZY MEMORY PRIVILEGE UPDATE
////////////////////////////////////////////////////////////////////////////////

//
// Try mapping memory at the passed address for the specified access type and
// return a status code indicating if there was a TLB miss
//
Bool riscvVMMiss(
    riscvP         riscv,
    memDomainP     domain,
    memPriv        requiredPriv,
    Uns64          address,
    Uns32          bytes,
    memAccessAttrs attrs
);

//
// Refresh the current data domain to reflect current mstatus.MPRV setting
//
void riscvVMRefreshMPRVDomain(riscvP riscv);

//
// Perform actions when the indicated TLB base register is updated
//
void riscvVMUpdateTableBase(riscvP riscv, riscvTLBId id);


////////////////////////////////////////////////////////////////////////////////
// TLB MANAGEMENT
////////////////////////////////////////////////////////////////////////////////

//
// Free structures used for virtual memory management
//
void riscvVMFree(riscvP riscv);

//
// Perform any required memory mapping updates on an ASID change
//
void riscvVMSetASID(riscvP riscv);

//
// Invalidate entire TLB
//
void riscvVMInvalidateAll(riscvP riscv);

//
// Invalidate entire TLB with matching ASID
//
void riscvVMInvalidateAllASID(riscvP riscv, Uns32 ASID);

//
// Invalidate TLB entries for the given address
//
void riscvVMInvalidateVA(riscvP riscv, Uns64 VA);

//
// Invalidate TLB entries with matching address and ASID
//
void riscvVMInvalidateVAASID(riscvP riscv, Uns64 VA, Uns32 ASID);

//
// Invalidate entire virtual stage 1 TLB
//
void riscvVMInvalidateAllV(riscvP riscv);

//
// Invalidate entire virtual stage 1 TLB with matching ASID
//
void riscvVMInvalidateAllASIDV(riscvP riscv, Uns32 ASID);

//
// Invalidate virtual stage 1 TLB entries for the given address
//
void riscvVMInvalidateVAV(riscvP riscv, Uns64 VA);

//
// Invalidate virtual stage 1 TLB entries with matching address and ASID
//
void riscvVMInvalidateVAASIDV(riscvP riscv, Uns64 VA, Uns32 ASID);

//
// Invalidate entire virtual stage 2 TLB
//
void riscvVMInvalidateAllG(riscvP riscv);

//
// Invalidate entire virtual stage 2 TLB with matching VMID
//
void riscvVMInvalidateAllVMIDG(riscvP riscv, Uns32 VMID);

//
// Invalidate virtual stage 2 TLB entries for the given address
//
void riscvVMInvalidateVAG(riscvP riscv, Uns64 GPAsh2);

//
// Invalidate virtual stage 2 TLB entries with matching address and VMID
//
void riscvVMInvalidateVAVMIDG(riscvP riscv, Uns64 GPAsh2, Uns32 VMID);

//
// Create a new TLB entry
//
RISCV_NEW_TLB_ENTRY_FN(riscvVMNewTLBEntry);

//
// Free an old TLB entry
//
RISCV_FREE_TLB_ENTRY_FN(riscvVMFreeTLBEntry);


////////////////////////////////////////////////////////////////////////////////
// PMP MANAGEMENT
////////////////////////////////////////////////////////////////////////////////

//
// Read the indexed PMP configuration register
//
Uns64 riscvVMReadPMPCFG(riscvP riscv, Uns32 index);

//
// Write the indexed PMP configuration register with the new value and return
// the new effective value
//
Uns64 riscvVMWritePMPCFG(riscvP riscv, Uns32 index, Uns64 newValue);

//
// Read the indexed PMP address register
//
Uns64 riscvVMReadPMPAddr(riscvP riscv, Uns32 index);

//
// Write the indexed PMP address register with the new value and return
// the new effective value
//
Uns64 riscvVMWritePMPAddr(riscvP riscv, Uns32 index, Uns64 newValue);

//
// Are any PMP entries locked?
//
Bool riscvVMAnyPMPLocked(riscvP riscv);

//
// Unmap all PMP entries
//
void riscvVMUnmapAllPMP(riscvP riscv);

//
// Allocate PMP structures
//
void riscvVMNewPMP(riscvP riscv);

//
// Free PMP structures
//
void riscvVMFreePMP(riscvP riscv);

//
// Reset PMP unit
//
void riscvVMResetPMP(riscvP riscv);

//
// Unmap PMP region with the given index
//
void riscvVMUnmapPMPRegion(riscvP riscv, Uns32 regionIndex);


////////////////////////////////////////////////////////////////////////////////
// MPU MANAGEMENT
////////////////////////////////////////////////////////////////////////////////

#if(ENABLE_SSMPU)

//
// Read the indexed MPU configuration register
//
Uns64 riscvVMReadMPUCFG(riscvP riscv, Uns32 index);

//
// Write the indexed MPU configuration register with the new value and return
// the new effective value
//
Uns64 riscvVMWriteMPUCFG(riscvP riscv, Uns32 index, Uns64 newValue);

//
// Read the indexed MPU address register
//
Uns64 riscvVMReadMPUAddr(riscvP riscv, Uns32 index);

//
// Write the indexed MPU address register with the new value and return
// the new effective value
//
Uns64 riscvVMWriteMPUAddr(riscvP riscv, Uns32 index, Uns64 newValue);

//
// Allocate MPU structures
//
void riscvVMNewMPU(riscvP riscv);

//
// Free MPU structures
//
void riscvVMFreeMPU(riscvP riscv);

//
// Reset MPU unit
//
void riscvVMResetMPU(riscvP riscv);

#endif


////////////////////////////////////////////////////////////////////////////////
// SAVE/RESTORE
////////////////////////////////////////////////////////////////////////////////

//
// Save VM state not covered by register read/write API
//
void riscvVMSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
);

//
// Restore VM state not covered by register read/write API
//
void riscvVMRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
);
