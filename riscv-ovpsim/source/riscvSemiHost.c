/*
 * Copyright (c) 2005-2020 Imperas Software Ltd., www.imperas.com
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

// Imperas header files
#include "hostapi/impAlloc.h"

// VMI header files
#include "vmi/vmiAttrs.h"
#include "vmi/vmiMessage.h"
#include "vmi/vmiMt.h"
#include "vmi/vmiPSETypes.h"
#include "vmi/vmiRt.h"

// model header files
#include "riscvFunctions.h"
#include "riscvMorph.h"
#include "riscvRegisters.h"
#include "riscvStructure.h"
#include "riscvUtils.h"


//
// Prefix for messages from this module
//
#define CPU_PREFIX "RISCV_SEMI"

//
// This specifies whether 64-bit registers are passed in aligned register
// pairs (as RVG calling convention says) or not (as tool chain does)
//
#define ALIGN_PAIR_64 0

//
// This defines the number of arguments passed in registers
//
#define AREG_NUM 8

//
// Return processor GPR bits
//
inline static Uns32 getRegBits(riscvP riscv) {
    return riscvGetXlenMode(riscv);
}

//
// Morph return from an opaque intercepted function
//
VMI_INT_RETURN_FN(riscvIntReturn) {
    vmimtUncondJumpReg(0, RISCV_LR, VMI_NOREG, vmi_JH_RETURN);
}

//
// This callback should create code to assign Int32 result to the standard
// return result register
//
VMI_INT_RESULT_FN(riscvIntResult) {

    riscvP riscv = (riscvP)processor;
    Uns32  bits  = getRegBits(riscv);
    vmiReg rd    = RISCV_GPR(RV_REG_X_A0);

    vmimtMoveRR(32, rd, VMI_FUNCRESULT);
    vmimtMoveExtendRR(bits, rd, 32, rd, False);
}

//
// This callback should create code to push function arguments prior to an
// Imperas standard intercept
//
VMI_INT_PAR_FN(riscvIntParCB) {

    riscvP riscv    = (riscvP)processor;
    Uns32  archBits = getRegBits(riscv);
    Uns32  rNum     = 0;
    char   ch;

    while((ch=*format++)) {

        vmiReg argReg;
        Uns32  argBits;

        // determine argument size
        if(ch=='4') {
            argBits = 32;
        } else if(ch=='a') {
            argBits = archBits;
        } else {
            argBits = 64;
        }

        // double-width arguments may be passed in an aligned register pair
        if(ALIGN_PAIR_64 && (argBits>archBits) && (rNum&1)) {
            rNum++;
        }

        // determine whether argument is passed in f or x register
        Bool isFReg = (ch=='d') && (archBits==64);

        if(rNum >= AREG_NUM) {

            // argument passed in memory
            argReg = RISCV_CPU_TEMP(TMP[0]);

            // load from stack into temporary
            vmimtLoadRRO(
                argBits,
                argBits,
                rNum * (archBits/8),
                argReg,
                RISCV_GPR(RV_REG_X_SP),
                riscvGetCurrentDataEndian(riscv),
                False,
                False
            );

        } else if(isFReg) {

            // argument passed in F register
            argReg = RISCV_FPR(RV_REG_X_A0+rNum);

        } else {

            // argument passed in X register
            argReg = RISCV_GPR(RV_REG_X_A0+rNum);
        }

        // adjust register indices
        rNum += (argBits>archBits) ? 2 : 1;

        if(ch=='4') {
            vmimtArgReg(32, argReg);
        } else if(ch=='a') {
            vmimtArgRegSimAddress(32, argReg);
        } else if(ch=='8') {
            vmimtArgReg(64, argReg);
        } else if(ch=='d') {
            vmimtArgReg(VPRRAT_FLT64, argReg);
        } else {
            VMI_ABORT("Unrecognised format character '%c'", ch);
        }
    }
}


////////////////////////////////////////////////////////////////////////////////
// ABI SUPPORT FOR PSE
////////////////////////////////////////////////////////////////////////////////

#define RISCV_SEMIHOST_ARGS 16

// argument block for synthesized call (when used as PSE)
typedef struct vmipseArgBlockS {
    riscvP riscv;                       // associated PSE
    Uns32  wordNum;                     // count of active words
    Uns32  u32[RISCV_SEMIHOST_ARGS];    // active frame
} vmipseArgBlock;

//
// Get 32-bit result register
//
static VMIPSE_GET_RESULT32_FN(getResult32) {
    riscvP riscv = (riscvP)pse;
    return riscv->x[RV_REG_X_A0];
}

//
// Set 32-bit result register
//
static VMIPSE_SET_RESULT32_FN(setResult32) {
    riscvP riscv = (riscvP)pse;
    riscv->x[RV_REG_X_A0] = value;
}

//
// Get 32-bit stack pointer register
//
static VMIPSE_GET_RESULT32_FN(getSP) {
    riscvP riscv = (riscvP)pse;
    return riscv->x[RV_REG_X_SP];
}

//
// Set 32-bit stack pointer register
//
static VMIPSE_SET_RESULT32_FN(setSP) {
    riscvP riscv = (riscvP)pse;
    riscv->x[RV_REG_X_SP] = value;
}

//
// Add a new Uns32 argument to the argument block
//
static VMIPSE_ARG32_FN(arg32) {
    VMI_ASSERT(block->wordNum<RISCV_SEMIHOST_ARGS, "Too many PSE arguments");
    block->u32[block->wordNum++] = arg;
}

//
// Add a new Uns64 argument to the argument block
//
static VMIPSE_ARG64_FN(arg64) {

    // align register index if required
    if(ALIGN_PAIR_64 && (block->wordNum&1)) {
        block->wordNum++;
    }

    // pass argument in a pair of registers
    arg32(block, arg);
    arg32(block, arg>>32);
}

//
// Return initialized argument block for the given PC using the supplied stack
// pointer (or use the current stack pointer if value 0xffffffff is given)
//
static VMIPSE_INIT_ARGS_FN(initArgs) {

    riscvP          riscv = (riscvP)pse;
    vmipseArgBlockP block = riscv->argBlockPSE;

    // initialize block fields
    block->riscv   = riscv;
    block->wordNum = 0;

    // update stack pointer if required
    if(sp!=-1) {
        riscv->x[RV_REG_X_SP] = sp&-4;
    }

    // link value is ra reg for this processor
    riscv->x[RV_REG_X_RA] = lr;

    return block;
}

//
// Finalise arguments to create stack frame
//
static VMIPSE_END_ARGS_FN(endArgs) {

    riscvP riscv     = block->riscv;
    Uns32  sp        = riscv->x[RV_REG_X_SP];
    Uns32  wordNum   = block->wordNum;
    Uns32  frameSize = wordNum*4;
    Uns32  numInReg  = (wordNum<AREG_NUM) ? wordNum : AREG_NUM;
    Uns32  i;

    // handle arguments passed in registers
    for(i=0; i<numInReg; i++) {
        riscv->x[RV_REG_X_A0+i] = block->u32[i];
    }

    // handle arguments passed in memory
    if(wordNum>AREG_NUM) {

        Uns32 regSize = AREG_NUM*4;

        vmirtWriteNByteDomain(
            vmirtGetProcessorDataDomain((vmiProcessorP)riscv),
            sp-frameSize+regSize,
            &block->u32[AREG_NUM],
            frameSize-regSize,
            0,
            MEM_AA_FALSE
        );
    }

    riscv->x[RV_REG_X_SP] = sp-frameSize;
}

//
// Return the address of a buffer capable of holding 'bytes' on the stack above
// the pending synthesized call argument block
//
static VMIPSE_ALLOCA_FN(allocA) {

    riscvP riscv = block->riscv;
    Uns32  words = (bytes+3)/4;

    riscv->x[RV_REG_X_SP] -= words*4;

    return riscv->x[RV_REG_X_SP];
}

//
// PSE ABI support attributes
//
const vmipseAttrs riscvPSEAttrs = {
    .initArgs    = initArgs,       // initialize arguments
    .endArgs     = endArgs,        // finalise arguments
    .getResult32 = getResult32,    // get 32-bit result register
    .setResult32 = setResult32,    // set 32-bit result register
    .getSP       = getSP,          // get SP register
    .setSP       = setSP,          // set SP register
    .arg32       = arg32,          // add Uns32 argument
    .arg64       = arg64,          // add Uns64 argument
    .allocA      = allocA,         // allocate space in frame
};

//
// Allocate PSE support structures
//
void riscvNewPSE(riscvP riscv) {

    riscv->argBlockPSE = STYPE_ALLOC(vmipseArgBlock);
}

//
// Free PSE support structures
//
void riscvFreePSE(riscvP riscv) {

    if(riscv->argBlockPSE) {
        STYPE_FREE(riscv->argBlockPSE);
    }
}

