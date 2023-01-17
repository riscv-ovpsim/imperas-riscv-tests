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
#include "riscvTypeRefs.h"
#include "riscvVariant.h"

//
// Add extension register to debug interface
//
void riscvNewExtReg(riscvP riscv, vmiRegInfoCP src);

//
// Free register descriptions, if they have been allocated
//
void riscvFreeRegInfo(riscvP riscv);

//
// If the CSR bus is used, it is possible that this could be connected or
// filled *after* the first access to a register through the OP/ICM interface,
// in which case vmiRegInfo entries implemented using the CSR bus must be
// modified to use callbacks here
//
void riscvPatchCSRBusCallbacks(riscvP riscv);
