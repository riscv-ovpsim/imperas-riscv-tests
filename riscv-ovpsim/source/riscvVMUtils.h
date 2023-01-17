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
#include "riscvStructure.h"

//
// Clamp the range in loMapP:hiMapP using the configured maximum page map size,
// ensuring the range loPA:hiPA is contained in the result
//
inline static void riscvClampPage(
    riscvP riscv,
    Uns64  loPA,
    Uns64  hiPA,
    Uns64 *loMapP,
    Uns64 *hiMapP
) {
    Uns64 clamp = riscv->configInfo.PMP_max_page;

    if(clamp) {

        // convert page size to page mask
        clamp--;

        // get page range for requested addresses
        loPA = (loPA & ~clamp);
        hiPA = (hiPA & ~clamp) + clamp;

        // clamp PMP region to page range
        if(*loMapP<loPA) {
            *loMapP = loPA;
        }
        if(*hiMapP>hiPA) {
            *hiMapP = hiPA;
        }
    }
}
