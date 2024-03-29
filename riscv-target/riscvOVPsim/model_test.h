// RISC-V Compliance IO Test Header File

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


#ifndef _MODEL_TEST_H
#define _MODEL_TEST_H

#define TESTNUM gp

#if XLEN == 64
  #define ALIGNMENT 3
#else
  #define ALIGNMENT 2
#endif

//RVMODEL_HALT
#define RVMODEL_HALT    \
  fence;                \
  ecall

#define RVMODEL_BOOT                                                    \
        .align  6;                                                      \
        .weak stvec_handler;                                            \
        .weak mtvec_handler;                                            \
        /* reset vector */                                              \
        j reset_vector;                                                 \
        .align 2;                                                       \
trap_vector:                                                            \
        /* test whether the test came from pass/fail */                 \
        csrr t0, mcause;                                                \
        li t1, CAUSE_USER_ECALL;                                        \
        beq t0, t1, write_tohost;                                       \
        li t1, CAUSE_SUPERVISOR_ECALL;                                  \
        beq t0, t1, write_tohost;                                       \
        li t1, CAUSE_MACHINE_ECALL;                                     \
        beq t0, t1, write_tohost;                                       \
        /* if an mtvec_handler is defined, jump to it */                \
        la t0, mtvec_handler;                                           \
        beqz t0, 1f;                                                    \
        jr t0;                                                          \
        /* was it an interrupt or an exception? */                      \
  1:    csrr t0, mcause;                                                \
        bgez t0, handle_exception;                                      \
handle_exception:                                                       \
        /* we don't know how to handle whatever the exception was */    \
  other_exception:                                                      \
        /* some unhandlable exception occurred */                       \
  1:    ori gp, gp, 1337;                                               \
  write_tohost:                                                         \
        sw gp, tohost, t0;                                              \
        j write_tohost;                                                 \
reset_vector:                                                           \
        li a0, MSTATUS_MPP;                                             \
        csrs mstatus, a0;                                               \
        la t0, trap_vector;                                             \
        csrw mtvec, t0;                                                 \
        la t0, rvtest_init;                                             \
        csrw mepc, t0;                                                  \
        csrr a0, mhartid;                                               \
        mret;                                                           \
1:

//RVMODEL_DATA_BEGIN
#define RVMODEL_DATA_BEGIN                                              \
  .align 4; .global begin_signature; begin_signature:

//RVMODEL_DATA_END
#define RVMODEL_DATA_END                                          \
  .align 4; .global end_signature; end_signature:                 \
  .pushsection .tohost,"aw",@progbits;                            \
  .align 8; .global tohost; tohost: .dword 0;                     \
  .align 8; .global fromhost; fromhost: .dword 0;                 \
  .popsection;                                                    \
  .align 8; .global begin_regstate; begin_regstate:               \
  .word 128;                                                      \
  .align 8; .global end_regstate; end_regstate:                   \
  .word 4;                                                        \
  .align ALIGNMENT;\

#define RVMODEL_IO_INIT

#define RVMODEL_SET_MSW_INT       


#define RVMODEL_CLEAR_MSW_INT

#define RVMODEL_CLEAR_MTIMER_INT

#define RVMODEL_CLEAR_MEXT_INT



//
// In general the following registers are reserved
// ra, a0, t0, t1
// x1, x10 x5, x6
// new reserve x31
//

#ifndef  RVMODEL_ASSERT
#  define RVMODEL_IO_QUIET
#endif

//-----------------------------------------------------------------------
// RV IO Macros (Character transfer by custom instruction)
//-----------------------------------------------------------------------
#define STRINGIFY(x) #x
#define TOSTRING(x)  STRINGIFY(x)

#define RVMODEL_CUSTOM1 0x0005200B

#ifdef RVMODEL_IO_QUIET

#define RVMODEL_IO_INIT
#define RVMODEL_IO_WRITE_STR(_SP, _STR)
#define RVMODEL_IO_CHECK()
#define RVMODEL_IO_ASSERT_GPR_EQ(_SP, _R, _I)
#define RVMODEL_IO_ASSERT_SFPR_EQ(_F, _R, _I)
#define RVMODEL_IO_ASSERT_DFPR_EQ(_D, _R, _I)

#else

#if (__riscv_xlen==32)
#    define RSIZE 4
#    define SX sw
#    define LX lw
#endif
#if (__riscv_xlen==64)
#    define RSIZE 8
#    define SX sd
#    define LX ld
#endif

// _SP = (volatile register)
#define LOCAL_IO_PUSH(_SP)                                              \
    la      _SP,  begin_regstate;                                       \
    SX      x1,   (1*RSIZE)(_SP);                                       \
    SX      x5,   (5*RSIZE)(_SP);                                       \
    SX      x6,   (6*RSIZE)(_SP);                                       \
    SX      x8,   (8*RSIZE)(_SP);                                       \
    SX      x10,  (10*RSIZE)(_SP);

// _SP = (volatile register)
#define LOCAL_IO_POP(_SP)                                               \
    la      _SP,   begin_regstate;                                      \
    LX      x1,   (1*RSIZE)(_SP);                                       \
    LX      x5,   (5*RSIZE)(_SP);                                       \
    LX      x6,   (6*RSIZE)(_SP);                                       \
    LX      x8,   (8*RSIZE)(_SP);                                       \
    LX      x10,  (10*RSIZE)(_SP);

#define LOCAL_IO_WRITE_GPR(_R)                                          \
    mv          a0, _R;                                                 \
    la          t0, FN_WriteA0;                                         \
    jalr         t0;

#define LOCAL_IO_WRITE_FPR(_F)                                          \
    fmv.x.s     a0, _F;                                                 \
    jal         FN_WriteA0;

#define LOCAL_IO_WRITE_DFPR(_V1, _V2)                                   \
    mv          a0, _V1;                                                \
    jal         FN_WriteA0; \
    mv          a0, _V2; \
    jal         FN_WriteA0; \

#define LOCAL_IO_PUTC(_R)                                               \
    .word RVMODEL_CUSTOM1;                                              \


#ifdef  RVMODEL_ASSERT_SHORT

#define RVMODEL_IO_ASSERT_GPR_EQ(_SP, _R, _I)                                    \
    LOCAL_IO_PUSH(_SP)                                                           \
    mv          s0, _R;                                                          \
    li          t0, _I;                                                          \
    beq         s0, t0, 20002f;                                                  \
    LOCAL_IO_WRITE_STR("Assertion violation found with RISCV_ASSERT=2. ");       \
    LOCAL_IO_WRITE_STR("Set RISCV_ASSERT=1 and rerun for full info.\n");   \
    li TESTNUM, 100;                                                             \
    call rvtest_code_end;                                                        \
20002:                                                                           \
    LOCAL_IO_POP(_SP)

#else
// Assertion violation: file file.c, line 1234: (expr)
// _SP = (volatile register)
// _R = GPR
// _I = Immediate
#define RVMODEL_IO_ASSERT_GPR_EQ(_SP, _R, _I)                           \
    LOCAL_IO_PUSH(_SP)                                                  \
    mv          s0, _R;                                                 \
    li          t0, _I;                                                 \
    beq         s0, t0, 20002f;                                         \
    LOCAL_IO_WRITE_STR("Assertion violation: file ");                   \
    LOCAL_IO_WRITE_STR(__FILE__);                                       \
    LOCAL_IO_WRITE_STR(", line ");                                      \
    LOCAL_IO_WRITE_STR(TOSTRING(__LINE__));                             \
    LOCAL_IO_WRITE_STR(": ");                                           \
    LOCAL_IO_WRITE_STR(# _R);                                           \
    LOCAL_IO_WRITE_STR("(");                                            \
    LOCAL_IO_WRITE_GPR(s0);                                             \
    LOCAL_IO_WRITE_STR(") != ");                                        \
    LOCAL_IO_WRITE_STR(# _I);                                           \
    LOCAL_IO_WRITE_STR("\n");                                     \
    li TESTNUM, 100;                                                    \
    call rvtest_code_end;                                               \
20002:                                                                  \
    LOCAL_IO_POP(_SP)

#endif

// _F = FPR
// _C = GPR
// _I = Immediate
#define RVMODEL_IO_ASSERT_SFPR_EQ(_F, _C, _I)                           \
    fmv.x.s     t0, _F;                                                 \
    beq         _C, t0, 20003f;                                         \
    LOCAL_IO_WRITE_STR("Assertion violation: file ");                   \
    LOCAL_IO_WRITE_STR(__FILE__);                                       \
    LOCAL_IO_WRITE_STR(", line ");                                      \
    LOCAL_IO_WRITE_STR(TOSTRING(__LINE__));                             \
    LOCAL_IO_WRITE_STR(": ");                                           \
    LOCAL_IO_WRITE_STR(# _F);                                           \
    LOCAL_IO_WRITE_STR("(");                                            \
    LOCAL_IO_WRITE_FPR(_F);                                             \
    LOCAL_IO_WRITE_STR(") != ");                                        \
    LOCAL_IO_WRITE_STR(# _I);                                           \
    LOCAL_IO_WRITE_STR("\n");                                     \
    li TESTNUM, 100;                                                    \
    call rvtest_code_end;                                               \
20003:

// _D = DFPR
// _R = GPR
// _I = Immediate
#define RVMODEL_IO_ASSERT_DFPR_EQ(_D, _R, _I)                           \
    fmv.x.d     t0, _D;                                                 \
    beq         _R, t0, 20005f;                                         \
    LOCAL_IO_WRITE_STR("Assertion violation: file ");                   \
    LOCAL_IO_WRITE_STR(__FILE__);                                       \
    LOCAL_IO_WRITE_STR(", line ");                                      \
    LOCAL_IO_WRITE_STR(TOSTRING(__LINE__));                             \
    LOCAL_IO_WRITE_STR(": ");                                           \
    LOCAL_IO_WRITE_STR(# _D);                                           \
    LOCAL_IO_WRITE_STR("(");                                            \
    LOCAL_IO_WRITE_DFPR(_D);                                            \
    LOCAL_IO_WRITE_STR(") != ");                                        \
    LOCAL_IO_WRITE_STR(# _I);                                           \
    LOCAL_IO_WRITE_STR("\n");                                     \
    li TESTNUM, 100;                                                    \
    call rvtest_code_end;                                               \
20005:

// _SP = (volatile register)
#define LOCAL_IO_WRITE_STR(_STR) RVMODEL_IO_WRITE_STR(x15, _STR)
#define RVMODEL_IO_WRITE_STR(_SP, _STR)                                 \
    LOCAL_IO_PUSH(_SP)                                                  \
    .section .data.string;                                              \
20001:                                                                  \
    .string _STR;                                                       \
    .section .text.init;                                                \
    la a0, 20001b;                                                      \
    la t0, FN_WriteStr;                                                 \
    jalr t0;                                                            \
    LOCAL_IO_POP(_SP)

// generate assertion listing
#define LOCAL_CHECK() RVMODEL_IO_CHECK()
#define RVMODEL_IO_CHECK()                                              \
    li zero, -1;                                                        \

//
// FN_WriteStr: Uses a0, t0
//
FN_WriteStr:
    mv          t0, a0;
10000:
    lbu         a0, (t0);
    addi        t0, t0, 1;
    beq         a0, zero, 10000f;
    LOCAL_IO_PUTC(a0);
    j           10000b;
10000:
    ret;

//
// FN_WriteA0: write register a0(x10) (destroys a0(x10), t0-t2(x5-x7))
//
FN_WriteA0:
        mv          t0, a0
        // determine architectural register width
        li          a0, -1
        srli        a0, a0, 31
        srli        a0, a0, 1
        bnez        a0, FN_WriteA0_64

FN_WriteA0_32:
        // reverse register when xlen is 32
        li          t1, 8
10000:  slli        t2, t2, 4
        andi        a0, t0, 0xf
        srli        t0, t0, 4
        or          t2, t2, a0
        addi        t1, t1, -1
        bnez        t1, 10000b
        li          t1, 8
        j           FN_WriteA0_common

FN_WriteA0_64:
        // reverse register when xlen is 64
        li          t1, 16
10000:  slli        t2, t2, 4
        andi        a0, t0, 0xf
        srli        t0, t0, 4
        or          t2, t2, a0
        addi        t1, t1, -1
        bnez        t1, 10000b
        li          t1, 16

FN_WriteA0_common:
        // write reversed characters
        li          t0, 10
10000:  andi        a0, t2, 0xf
        blt         a0, t0, 10001f
        addi        a0, a0, 'a'-10
        j           10002f
10001:  addi        a0, a0, '0'
10002:  LOCAL_IO_PUTC(a0)
        srli        t2, t2, 4
        addi        t1, t1, -1
        bnez        t1, 10000b
        ret

#endif // RVMODEL_IO_QUIET

#endif // _MODEL_TEST_H

