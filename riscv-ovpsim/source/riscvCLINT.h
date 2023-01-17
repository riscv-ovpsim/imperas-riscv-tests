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

// basic types
#include "hostapi/impTypes.h"

// VMI header files
#include "vmi/vmiTypes.h"

// model header files
#include "riscvTypeRefs.h"


//
// Create CLINT memory-mapped block and data structures
//
void riscvMapCLINTDomain(riscvP riscv, memDomainP CLINTDomain);

//
// Allocate CLINT data structures if implemented internally
//
void riscvNewCLINT(riscvP root);

//
// Fill CLINT entry if required
//
void riscvFillCLINT(riscvP riscv);

//
// Free CLINT data structures
//
void riscvFreeCLINT(riscvP riscv);

//
// Reset CLINT
//
void riscvResetCLINT(riscvP riscv);

//
// Read msip[i]
//
Bool riscvReadCLINTMSIP(riscvP hart);

//
// Write msip[i]
//
void riscvWriteCLINTMSIP(riscvP hart, Bool value);

//
// Write mtime (common to all harts)
//
void riscvWriteCLINTMTIME(riscvP hart, Uns64 value);

