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
#include "riscvTypes.h"
#include "riscvTypeRefs.h"

//
// This indicates the known active vector standard element width (SEW)
//
typedef enum riscvSEWMtE {
    SEWMT_UNKNOWN =    0,
    SEWMT_1       =    1,
    SEWMT_8       =    8,
    SEWMT_16      =   16,
    SEWMT_32      =   32,
    SEWMT_64      =   64,
    SEWMT_128     =  128,
    SEWMT_256     =  256,
    SEWMT_512     =  512,
    SEWMT_1024    = 1024,
    SEWMT_32_64   = SEWMT_32|SEWMT_64,
} riscvSEWMt;

//
// This indicates 8x the known active vector length multiplier (VLMUL)
//
typedef enum riscvVLMULx8MtE {
    VLMULx8MT_UNKNOWN = 0,
    VLMULx8MT_0125    = 1,
    VLMULx8MT_025     = 2,
    VLMULx8MT_05      = 4,
    VLMULx8MT_1       = 8,
    VLMULx8MT_2       = 16,
    VLMULx8MT_4       = 32,
    VLMULx8MT_8       = 64,
} riscvVLMULx8Mt;

//
// This indicates the known active vector length zero/non-zero state
//
typedef enum riscvVLClassE {
    VLCLASSMT_UNKNOWN = 0,
    VLCLASSMT_ZERO    = 1,
    VLCLASSMT_NONZERO = 2,
    VLCLASSMT_MAX     = 3,
} riscvVLClassMt;

//
// This indicates the VLMUL for which a vector register is known to have top
// zero (either a single register, or a component of a group)
//
typedef enum riscvTZE {
    VTZ_SINGLE,
    VTZ_GROUP,
} riscvTZ;

//
// This subdivides the polymorphic key into parts used by the vector extension
// and transaction mode
//
typedef enum riscvPMKE {
    PMK_VECTOR_VTA1 = 0x0400,
    PMK_VECTOR_VMA1 = 0x0800,
    PMK_VECTOR      = 0x0fff,
    PMK_TRANSACTION = 0x8000,
} riscvPMK;

//
// This structure holds state for a code block as it is morphed
//
typedef struct riscvBlockStateS {

    riscvBlockStateP prevState;         // previous block state
    Uns32            fpNaNBoxMask[2];   // mask of known NaN-boxed registers
    Uns32            VSetTopMt[2];      // known vector registers with top set
    riscvSEWMt       SEWMt        : 16; // known active vector SEW
    riscvVLMULx8Mt   VLMULx8Mt    :  8; // known active vector VLMULx8
    riscvVLClassMt   VLClassMt    :  2; // known active vector VL zero/non-zero/max
    Bool             vtaMt        :  1; // known active vta
    Bool             vmaMt        :  1; // known active vma
    Bool             VStartZeroMt :  1; // vstart known to be zero?
    Bool             updateFFlags :  1; // whether to update fflags from fflags_i
    Bool             doLSTrig     :  1; // whether load/store triggers enabled
    Bool             ZfhminOK     :  1; // whether allowed by Zfhmin
    Bool             ZfbfminOK    :  1; // whether allowed by Zfbfmin
    Bool             ZvfbfwmaOK   :  1; // whether allowed by Zvfbfwma
    Bool             FSDirty      :  1; // is status.FS known to be dirty?
    Bool             VSDirty      :  1; // is status.VS known to be dirty?

} riscvBlockState;

//
// Convert signed vlmul value to riscvVLMULx8Mt type
//
inline static riscvVLMULx8Mt svlmulToVLMULx8(Int32 svlmul) {
    return (svlmul==-4) ? VLMULx8MT_UNKNOWN : (1<<(svlmul+3));
}

//
// Get riscvVLMULx8Mt for vtype
//
inline static riscvVLMULx8Mt vtypeToVLMULx8(riscvVType vtype) {
    return svlmulToVLMULx8(getVTypeSVLMUL(vtype));
}

