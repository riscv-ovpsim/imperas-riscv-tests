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
#include "vmi/vmiAttrs.h"

// model header files
#include "riscvMode.h"
#include "riscvModelCallbacks.h"
#include "riscvTypes.h"
#include "riscvTypeRefs.h"
#include "riscvVariant.h"


//
// Does the processor mode use XLEN=64?
//
Bool riscvModeIsXLEN64(riscvP riscv, riscvMode mode);

//
// Update the currently-enabled architecture settings
//
void riscvSetCurrentArch(riscvP riscv);

//
// Update dynamic BFLOAT16 state
//
void riscvUpdateDynamicBF16(riscvP riscv, Bool newBF16);

//
// Return the configured XLEN (may not be the current XLEN if dynamic update
// of XLEN is allowed)
//
Uns32 riscvGetXlenArch(riscvP riscv);

//
// Return the configured FLEN (may not be the current FLEN if dynamic update
// of FLEN is allowed)
//
Uns32 riscvGetFlenArch(riscvP riscv);

//
// Return the current XLEN
//
Uns32 riscvGetXlenMode(riscvP riscv);

//
// Return the current FLEN
//
Uns32 riscvGetFlenMode(riscvP riscv);

//
// Does the processor support configurable endianness?
//
Bool riscvSupportEndian(riscvP riscv);

//
// Return endianness for data access in the given mode
//
memEndian riscvGetDataEndian(riscvP riscv, riscvMode mode);

//
// Return endianness for data access in the current mode
//
memEndian riscvGetCurrentDataEndian(riscvP riscv);

//
// Register extension callback block with the base model
//
void riscvRegisterExtCB(riscvP riscv, riscvExtCBP extCB, Uns32 id);

//
// Return the indexed extension's extCB clientData
//
void *riscvGetExtClientData(riscvP riscv, Uns32 id);

//
// Return extension configuration with the given id
//
riscvExtConfigCP riscvGetExtConfig(riscvP riscv, Uns32 id);

//
// Get mode name for the indexed mode
//
const char *riscvGetModeName(riscvMode mode);

//
// Change processor mode
//
void riscvSetMode(riscvP riscv, riscvMode mode);

//
// Refresh XLEN mask and current mode when required
//
void riscvRefreshXLEN(riscvP riscv);

//
// Return the minimum supported processor mode
//
riscvMode riscvGetMinMode(riscvP riscv);

//
// Does the processor implement the given mode?
//
Bool riscvHasMode(riscvP riscv, riscvMode mode);

//
// Does the given mode have variable XLEN?
//
Bool riscvHasVariableXLEN(riscvP riscv, riscvMode mode);

//
// Does the processor implement the given mode for 32-bit XLEN?
//
Bool riscvHasXLEN32(riscvP riscv, riscvMode mode);

//
// Does the processor implement the given mode for 64-bit XLEN?
//
Bool riscvHasXLEN64(riscvP riscv, riscvMode mode);

//
// Does the processor implement the given dictionary mode?
//
Bool riscvHasDMode(riscvP riscv, riscvDMode dMode);

//
// Return the indexed X register name
//
const char *riscvGetXRegName(riscvP riscv, Uns32 index);

//
// Return the indexed F register name
//
const char *riscvGetFRegName(riscvP riscv, Uns32 index);

//
// Return the indexed V register name
//
const char *riscvGetVRegName(riscvP riscv, Uns32 index);

//
// Utility function returning a vmiReg object to access the indexed vector
// register
//
vmiReg riscvGetVReg(riscvP riscv, Uns32 index);

//
// Get description for the first feature identified by the given feature id
//
const char *riscvGetFeatureName(riscvArchitecture feature, Bool nullOK);

//
// Parse the extensions string
//
riscvArchitecture riscvParseExtensions(const char *extensions);

//
// Abort any active exclusive access
//
void riscvAbortExclusiveAccess(riscvP riscv);

//
// Install or remove the exclusive access monitor callback if required
//
void riscvUpdateExclusiveAccessCallback(riscvP riscv, Bool install);

//
// Enable or disable transaction mode
//
RISCV_SET_TMODE_FN(riscvSetTMode);

//
// Return true if in transaction mode
//
RISCV_GET_TMODE_FN(riscvGetTMode);

