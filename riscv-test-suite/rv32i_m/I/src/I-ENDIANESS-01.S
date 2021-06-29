# RISC-V Compliance Test I-ENDIANESS-01
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
# Description: Testing ENDIANESS of RISC-V processor.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32IC")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN

#ifdef TEST_CASE_1

RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*C.*);def TEST_CASE_1=True;",endian)

    RVMODEL_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
    RVMODEL_IO_WRITE_STR(x31, "Test Begin\n")

    # ---------------------------------------------------------------------------------------------
    RVMODEL_IO_WRITE_STR(x31, "Test part A - test loading word by LW, LH, LB\n")

    # Addresses for test data and results
    RVTEST_SIGBASE( x16,test_A_data)
    RVTEST_SIGBASE( x17,test_A_res)

    # Test
    lw      x1, 0(x16)
    lhu     x2, 0(x16)
    lhu     x3, 2(x16)
    lbu     x4, -1(x16)
    lbu     x5, 0(x16)
    lbu     x6, 1(x16)
    lbu     x7, 2(x16)
    lbu     x8, 3(x16)

    # Store results
    sw      x1, 0(x17)
    sw      x2, 4(x17)
    sw      x3, 8(x17)
    sw      x4, 12(x17)
    sw      x5, 16(x17)
    sw      x6, 20(x17)
    sw      x7, 24(x17)
    sw      x8, 28(x17)

    //
    // Assert
    //
    RVMODEL_IO_CHECK()
    RVMODEL_IO_ASSERT_GPR_EQ(x17, x1, 0x01234567)
    RVMODEL_IO_ASSERT_GPR_EQ(x17, x2, 0x00004567)
    RVMODEL_IO_ASSERT_GPR_EQ(x17, x3, 0x00000123)
    RVMODEL_IO_ASSERT_GPR_EQ(x17, x4, 0x00000089)
    RVMODEL_IO_ASSERT_GPR_EQ(x17, x5, 0x00000067)
    RVMODEL_IO_ASSERT_GPR_EQ(x17, x6, 0x00000045)
    RVMODEL_IO_ASSERT_GPR_EQ(x17, x7, 0x00000023)
    RVMODEL_IO_ASSERT_GPR_EQ(x17, x8, 0x00000001)

    RVMODEL_IO_WRITE_STR(x31, "Test part A1  - Complete\n")

    RVMODEL_IO_WRITE_STR(x31, "Test End\n")

#endif

 # ---------------------------------------------------------------------------------------------

    # HALT
    RVMODEL_HALT

RVTEST_CODE_END

RVTEST_DATA_BEGIN
    .align 4
    .word 0x89ABCDEF
test_A_data:
    .word 0x01234567
RVTEST_DATA_END

RVMODEL_DATA_BEGIN
    .align 4

test_A_res:
    .fill 8, 4, -1

RVMODEL_DATA_END

