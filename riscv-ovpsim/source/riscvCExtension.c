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

// standard header files
#include <stdio.h>

// basic types
#include "hostapi/impTypes.h"

// VMI header files
#include "vmi/vmiMessage.h"
#include "vmi/vmiMt.h"

// model header files
#include "riscvCExtension.h"
#include "riscvExceptions.h"
#include "riscvMessage.h"
#include "riscvMorph.h"
#include "riscvStructure.h"


//
// Get description for missing instruction subset
//
static const char *getSubsetDesc(riscvP riscv, riscvCompressSet requiredSet) {

    riscvCompressSet legacySet = RVCS_Zcea|RVCS_Zceb|RVCS_Zcee;

    // get feature description
    const char *description = 0;

    // select alternative architectural features implied by version
    requiredSet &= RISCV_COMPRESS_VERSION(riscv) ? ~legacySet : legacySet;

    // get missing subset description
    //
    // NOTES ON UNREACHABLE CASES
    // --------------------------
    // 1. All RVCS_Zceb subset instructions map to D extension opcodes if Zceb
    //    is unimplemented, meaning that RVCS_Zceb case cannot be reached.
    // 2. Disabling RVCS_Zca is difficult to test because default assembler
    //    options always use compressed instructions.
    // 3. RVCS_Zcd is a pseudo-option that is used to elect between other
    //    Zc instructions and compressed double-precision instructions and
    //    cannot be reached here.
    // 4. RVCS_Zcmpe currently controls no instructions, so cannot be reached
    //    here.
    // 5. Composite values selecting either legacy or current features cannot
    //    be reached here (see code above).
    //
    switch(requiredSet) {

        // LEGACY SETS
        case RVCS_Zcea  : description = "Zcea";  break;
        case RVCS_Zceb  : description = "Zceb";  break; // LCOV_EXCL_LINE
        case RVCS_Zcee  : description = "Zcee";  break;

        // NEW SETS
        case RVCS_Zca   : description = "Zca";   break; // LCOV_EXCL_LINE
        case RVCS_Zcb   : description = "Zcb";   break;
        case RVCS_Zcd   : description = "Zcd";   break; // LCOV_EXCL_LINE
        case RVCS_Zcf   : description = "Zcf";   break;
        case RVCS_Zcmb  : description = "Zcmb";  break;
        case RVCS_Zcmp  : description = "Zcmp";  break;
        case RVCS_Zcmpe : description = "Zcmpe"; break; // LCOV_EXCL_LINE
        case RVCS_Zcmt  : description = "Zcmt";  break;

        // COMPOSITE VALUES
        case RVCS_ZcmpZcmpe : description = "Zcmp and Zcmpe"; break;

        // OTHER VALUES (IGNORE, UNREACHABLE)
        default: break; // LCOV_EXCL_LINE
    }

    // sanity check known subset
    VMI_ASSERT(description, "unexpected subset 0x%x", requiredSet);

    return description;
}

//
// Validate that the compressed subset is supported and take an Illegal
// Instruction exception if not
//
Bool riscvValidateCExtSubset(riscvP riscv, riscvCompressSet Zc) {

    // detect absent subset
    if(Zc && !(Zc & riscv->configInfo.compress_present)) {
        riscvEmitIllegalInstructionAbsentSubset(getSubsetDesc(riscv, Zc));
        return False;
    }

    return True;
}


