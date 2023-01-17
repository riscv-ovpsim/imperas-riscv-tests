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
#include "vmi/vmiTypes.h"

// model header files
#include "riscvTypeRefs.h"


//
// This holds AIA state for each hart
//
typedef struct riscvAIAS {
    Uns8  miprio [64];  // M-mode interrupt priorities
    Uns8  siprio [64];  // S-mode interrupt priorities
    Uns8  vsiprio[64];  // VS-mode interrupt priorities
    Uns16 meiprio;      // M-mode external interrupt priority
    Uns16 seiprio;      // S-mode external interrupt priority
    Uns16 vseiprio;     // VS-mode external interrupt priority
} riscvAIA;


