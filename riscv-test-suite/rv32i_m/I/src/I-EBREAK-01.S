# RISC-V Compliance Test I-EBREAK-01
#
# Copyright (c) 2017, Codasip Ltd.
# Copyright (c) 2021, Imperas Software Ltd. Additions
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#      * Redistributions of source code must retain the above copyright
#        notice, this list of conditions and the following disclaimer.
#      * Redistributions in binary form must reproduce the above copyright
#        notice, this list of conditions and the following disclaimer in the
#        documentation and/or other materials provided with the distribution.
#      * Neither the name of the Codasip Ltd., Imperas Software Ltd. nor the
#        names of its contributors may be used to endorse or promote products
#        derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Codasip Ltd., Imperas Software Ltd.
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Specification: RV32I Base Integer Instruction Set, Version 2.0
# Description: Testing instruction EBREAK.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32IC")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN

#ifdef TEST_CASE_1

RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*C.*);def TEST_CASE_1=True;",ebreak)

    RVMODEL_IO_ASSERT_GPR_EQ(x30, x0, 0x00000000)
    RVMODEL_IO_WRITE_STR(x30, "#  Test Begin Reserved reg x31\n")

    # Save and set trap handler address
    la x1, _trap_handler
    csrrw x31, mtvec, x1

    //
    // Assert
    //
    RVMODEL_IO_CHECK()
    # ---------------------------------------------------------------------------------------------
    RVMODEL_IO_WRITE_STR(x30, "#  Test part A - test EBREAK\n")

    # Address for test results
    RVTEST_SIGBASE( x1,test_A_res_exc)

inst_0:

    # Test
    li      x2, 0x11111111
    ebreak
    sw      x0, 0(x1)

    RVMODEL_IO_WRITE_STR(x30, "#  Test part A1  - Complete\n")

    # ---------------------------------------------------------------------------------------------
    # restore mtvec and jump to the end
    csrw mtvec, x31
    jal x0, test_end

    # ---------------------------------------------------------------------------------------------
    # force alignment
    .balign 64
    # Exception handler
_trap_handler:
    # increment return address
    csrr    x30, mepc
    addi    x30, x30, 4
    csrw    mepc, x30

    # Store MCAUSE
    csrr    x30, mcause
    sw      x30, 0(x1)

    # Store data from test
    sw      x2, 4(x1)
    sw      x0, 8(x1)

    # increment data_exc address
    addi    x1, x1, 12

    # return
    mret

    # ---------------------------------------------------------------------------------------------

test_end:

    RVMODEL_IO_WRITE_STR(x30, "#  Test End\n")

#endif

 # ---------------------------------------------------------------------------------------------

    # HALT
    RVMODEL_HALT

RVTEST_CODE_END

RVTEST_DATA_BEGIN
.align 4
rvtest_data:
.word 0xbabecafe
RVTEST_DATA_END

RVMODEL_DATA_BEGIN

test_A_res_exc:
    .fill 4, 4, -1

RVMODEL_DATA_END

