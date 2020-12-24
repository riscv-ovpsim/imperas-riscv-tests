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

// VMI header files
#include "vmi/vmiAttrs.h"
#include "vmi/vmiMessage.h"
#include "vmi/vmiMt.h"

// model header files
#include "riscvFunctions.h"
#include "riscvMessage.h"
#include "riscvMorph.h"
#include "riscvRegisters.h"
#include "riscvStructure.h"
#include "riscvUtils.h"


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
// Return processor XLEN
//
inline static Uns32 getXLEN(riscvP riscv) {
    return riscvGetXlenMode(riscv);
}

//
// Return next temporary, checking index for overflow
//
static vmiReg getTmp(Uns32 index) {

    VMI_ASSERT(index<NUM_TEMPS, "Semihost register index overflow (%u)", index);

    return RISCV_CPU_TEMP(TMP[index]);
}

//
// Morph return from an opaque intercepted function
//
VMI_INT_RETURN_FN(riscvIntReturn) {
    vmimtUncondJumpReg(0, RISCV_LR, VMI_NOREG, vmi_JH_RETURN);
}

//
// This callback should create code to assign a result to the standard return
// result register
//
VMI_INT_RESULT_FN(riscvIntResult) {

    riscvP riscv = (riscvP)processor;
    vmiReg rdL   = RISCV_GPR(RV_REG_X_A0);
    vmiReg rdH   = RISCV_GPR(RV_REG_X_A1);
    Uns32  xlen  = getXLEN(riscv);
    Uns32  resBits;

    // decode return value format
    if(format=='4') {
        resBits = 32;
    } else if(format=='8') {
        resBits = 64;
    } else {                                                    // LCOV_EXCL_LINE
        VMI_ABORT("Unrecognised format character '%c'", format);// LCOV_EXCL_LINE
    }

    // assign result to register or register pair
    if(resBits<=xlen) {
        vmimtMoveRR(resBits, rdL, VMI_FUNCRESULT);
        vmimtMoveExtendRR(xlen, rdL, resBits, rdL, False);
    } else {
        vmiReg tmp = getTmp(0);
        vmimtMoveRR(resBits, tmp, VMI_FUNCRESULT);
        vmimtMoveRR(xlen, rdL, tmp);
        vmimtMoveRR(xlen, rdH, VMI_REG_DELTA(tmp, xlen/8));
    }
}

//
// This callback should create code to push function arguments prior to an
// Imperas standard intercept
//
VMI_INT_PAR_FN(riscvIntParCB) {

    riscvP riscv    = (riscvP)processor;
    Uns32  xlen     = getXLEN(riscv);
    Uns32  memAlign = 0;
    Uns32  rNum     = 0;
    Uns32  tmpIdx   = 0;
    char   ch;

    while((ch=*format++)) {

        vmiReg argReg;
        Uns32  argBits;

        // determine argument size
        if(ch=='4') {
            argBits = 32;
        } else if(ch=='a') {
            argBits = xlen;
        } else {
            argBits = 64;
        }

        // double-width arguments may be passed in an aligned register pair
        if(ALIGN_PAIR_64 && (argBits>xlen) && (rNum&1)) {
            rNum++; // LCOV_EXCL_LINE
        }

        // determine whether argument is passed in f or x register
        Bool isFReg = False;
        Bool isPair = (argBits>xlen);

        if(rNum >= AREG_NUM) {

            // argument passed in memory
            argReg = getTmp(tmpIdx++);

            // align double-width arguments
            if(isPair && ((rNum+memAlign)&1)) {
                memAlign++;
            }

            // load from stack into temporary
            vmimtLoadRRO(
                argBits,
                argBits,
                ((rNum+memAlign)-AREG_NUM) * (xlen/8),
                argReg,
                RISCV_GPR(RV_REG_X_SP),
                riscvGetCurrentDataEndian(riscv),
                False,
                False
            );

        } else if(isFReg) {

            // argument passed in F register
            argReg = RISCV_FPR(RV_REG_X_A0+rNum);

        } else if(!isPair) {

            // argument passed in X register
            argReg = RISCV_GPR(RV_REG_X_A0+rNum);

        } else if(rNum==AREG_NUM-1) {

            // argument passed in X register and memory
            argReg = getTmp(tmpIdx++);

            vmiReg loSrc = RISCV_GPR(RV_REG_X_A0+rNum);
            vmiReg loDst = argReg;
            vmiReg hiDst = VMI_REG_DELTA(argReg, xlen/8);

            // move argument low half to temporary low half
            vmimtMoveRR(xlen, loDst, loSrc);

            // load from stack into temporary high half
            vmimtLoadRRO(
                xlen,
                xlen,
                0,
                hiDst,
                RISCV_GPR(RV_REG_X_SP),
                riscvGetCurrentDataEndian(riscv),
                False,
                False
            );

        } else {

            // argument passed in X register pair
            argReg = getTmp(tmpIdx++);

            vmiReg loSrc = RISCV_GPR(RV_REG_X_A0+rNum);
            vmiReg hiSrc = RISCV_GPR(RV_REG_X_A0+rNum+1);
            vmiReg loDst = argReg;
            vmiReg hiDst = VMI_REG_DELTA(argReg, xlen/8);

            // move argument halves to wider temporary
            vmimtMoveRR(xlen, loDst, loSrc);
            vmimtMoveRR(xlen, hiDst, hiSrc);
        }

        // adjust register indices
        rNum += !isFReg && (argBits>xlen) ? 2 : 1;

        if(ch=='4') {
            vmimtArgReg(32, argReg);
        } else if(ch=='a') {
            vmimtArgRegSimAddress(xlen, argReg);
        } else if(ch=='8') {
            vmimtArgReg(64, argReg);
        } else if(ch=='d') {
            vmimtArgReg(VPRRAT_FLT64, argReg);
        } else {                                                    // LCOV_EXCL_LINE
            VMI_ABORT("Unrecognised format character '%c'", ch);    // LCOV_EXCL_LINE
        }
    }
}

