# RISC-V Compliance Test I-DELAY_SLOTS-01
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
# Description: Testing delay slots of jump and branch instructions.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32I")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN

#ifdef TEST_CASE_1

RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*C.*);def TEST_CASE_1=True;",jalr)

    RVMODEL_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
	RVMODEL_IO_WRITE_STR(x31, "# Test Begin\n")

    # ---------------------------------------------------------------------------------------------
    RVMODEL_IO_WRITE_STR(x31, "#  Test part A1 - test JAL\n")

    # Address for test results
    RVTEST_SIGBASE( x1,test_A1_res)

inst_0:


    # Test
    li      x2, 0x11111111
    jal     x0, 1f
    li      x2, 0
1:

    # Store results
    sw      x2, 0(x1)

    //
    // Assert
    //
    RVMODEL_IO_CHECK()
    RVMODEL_IO_ASSERT_GPR_EQ(x1, x2, 0x11111111)

    RVMODEL_IO_WRITE_STR(x31, "#  Test part A1  - Complete\n")

    # ---------------------------------------------------------------------------------------------
    RVMODEL_IO_WRITE_STR(x31, "#  Test part A2 - test JALR\n")

    # Address for test results
    RVTEST_SIGBASE( x1,test_A2_res)

inst_1:

    # Test
    li      x2, 0x22222222
    la      x4, 1f
    jalr    x0, x4, 0
    li      x2, 0
1:

    # Store results
    sw      x2, 0(x1)

    RVMODEL_IO_ASSERT_GPR_EQ(x1, x2, 0x22222222)

    RVMODEL_IO_WRITE_STR(x31, "#  Test part A2  - Complete\n")

    # ---------------------------------------------------------------------------------------------
    RVMODEL_IO_WRITE_STR(x31, "#  Test part B1 - test BEQ\n")

    # Address for test results
    RVTEST_SIGBASE( x1,test_B1_res)

inst_2:

    # Register initialization
    li      x5, 5
    li      x6, 6

    # Test
    li      x2, 0x33333333
    beq     x5, x5, 1f
    li      x2, 0
1:

    # Store results
    sw      x2, 0(x1)

    RVMODEL_IO_ASSERT_GPR_EQ(x1, x2, 0x33333333)

    RVMODEL_IO_WRITE_STR(x31, "#  Test part A3  - Complete\n")

    # ---------------------------------------------------------------------------------------------
    RVMODEL_IO_WRITE_STR(x31, "#  Test part B2 - test BNE\n")

    # Address for test results
    RVTEST_SIGBASE( x1,test_B2_res)

inst_3:

    # Register initialization
    li      x5, 5
    li      x6, 6

    # Test
    li      x2, 0x44444444
    bne     x5, x6, 1f
    li      x2, 0
1:

    # Store results
    sw      x2, 0(x1)

    RVMODEL_IO_ASSERT_GPR_EQ(x1, x2, 0x44444444)

    RVMODEL_IO_WRITE_STR(x31, "#  Test part A4  - Complete\n")

    # ---------------------------------------------------------------------------------------------
    RVMODEL_IO_WRITE_STR(x31, "#  Test part B3 - test BLT\n")

    # Address for test results
    RVTEST_SIGBASE( x1,test_B3_res)

inst_4:

    # Register initialization
    li      x5, 5
    li      x6, 6

    # Test
    li      x2, 0x55555555
    blt     x5, x6, 1f
    li      x2, 0
1:

    # Store results
    sw      x2, 0(x1)

    RVMODEL_IO_ASSERT_GPR_EQ(x1, x2, 0x55555555)

    RVMODEL_IO_WRITE_STR(x31, "#  Test part A5  - Complete\n")

    # ---------------------------------------------------------------------------------------------
    RVMODEL_IO_WRITE_STR(x31, "#  Test part B4 - test BLTU\n")

    # Address for test results
    RVTEST_SIGBASE( x1,test_B4_res)

inst_5:

    # Register initialization
    li      x5, 5
    li      x6, 6

    # Test
    li      x2, 0x66666666
    bltu    x5, x6, 1f
    li      x2, 0
1:

    # Store results
    sw      x2, 0(x1)

    RVMODEL_IO_ASSERT_GPR_EQ(x1, x2, 0x66666666)

    RVMODEL_IO_WRITE_STR(x31, "#  Test part B  - Complete\n")

    # ---------------------------------------------------------------------------------------------
    RVMODEL_IO_WRITE_STR(x31, "#  Test part B5 - test BGE\n")

    # Address for test results
    RVTEST_SIGBASE( x1,test_B5_res)

inst_6:

    # Register initialization
    li      x5, 5
    li      x6, 6

    # Test
    li      x2, 0x77777777
    bge     x6, x5, 1f
    li      x2, 0
1:

    # Store results
    sw      x2, 0(x1)

    RVMODEL_IO_ASSERT_GPR_EQ(x1, x2, 0x77777777)

    RVMODEL_IO_WRITE_STR(x31, "#  Test part C  - Complete\n")

    # ---------------------------------------------------------------------------------------------
    RVMODEL_IO_WRITE_STR(x31, "#  Test part B6 - test BGEU\n")

    # Address for test results
    RVTEST_SIGBASE( x1,test_B6_res)

inst_7:

    # Register initialization
    li      x5, 5
    li      x6, 6

    # Test
    li      x2, 0x88888888
    bgeu    x6, x5, 1f
    li      x2, 0
1:

    # Store results
    sw      x2, 0(x1)

    RVMODEL_IO_ASSERT_GPR_EQ(x1, x2, 0x88888888)

    RVMODEL_IO_WRITE_STR(x31, "#  Test part D  - Complete\n")

    RVMODEL_IO_WRITE_STR(x31, "#  Test End\n")

 # ---------------------------------------------------------------------------------------------

#endif

    # HALT
    RVMODEL_HALT

RVTEST_CODE_END

RVTEST_DATA_BEGIN
.align 4
rvtest_data:
.word 0xbabecafe
RVTEST_DATA_END

RVMODEL_DATA_BEGIN

test_A1_res:
    .fill 1, 4, -1
test_A2_res:
    .fill 1, 4, -1
test_B1_res:
    .fill 1, 4, -1
test_B2_res:
    .fill 1, 4, -1
test_B3_res:
    .fill 1, 4, -1
test_B4_res:
    .fill 1, 4, -1
test_B5_res:
    .fill 1, 4, -1
test_B6_res:
    .fill 1, 4, -1

RVMODEL_DATA_END

