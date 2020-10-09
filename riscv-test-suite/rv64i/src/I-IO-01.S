# RISC-V Compliance Test I-IO-01
#
# Additions Copyright (c) 2005-2018 Imperas Software Ltd., www.imperas.com
#
# Copyright (c) 2017, Codasip Ltd.
# Copyright (c) 2018, Imperas Software Ltd. Additions
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
# Specification: RV64I Base Integer Instruction Set, Version 2.1
# Description: Testing instruction IO-S.


#include "compliance_test.h"
#include "compliance_io.h"
#include "test_macros.h"

# Test Virtual Machine (TVM) used by program.
RV_COMPLIANCE_RV64M

# Test code region.
RV_COMPLIANCE_CODE_BEGIN

    RVTEST_IO_INIT
    RVTEST_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
    RVTEST_IO_WRITE_STR(x31, "# Test Begin\n")

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR(x31, "# Test part A1 - general test of value 0 with 0, 1, -1, MIN, MAX register values\n");

    # Addresses for test data and results
    la      x1, test_A1_data
    la      x2, test_A1_res

    # Load testdata
    ld      x3, 0(x1)

    # Register initialization
    li      x4, 0
    li      x5, 1
    li      x6, -1
    li      x7, 0x7FFFFFFFFFFFFFFF
    li      x8, 0x8000000000000000

    # Test
    add     x4, x3, x4
    add     x5, x3, x5
    add     x6, x3, x6
    add     x7, x3, x7
    add     x8, x3, x8

    # Store results
    sd      x3, 0(x2)
    sd      x4, 8(x2)
    sd      x5, 16(x2)
    sd      x6, 24(x2)
    sd      x7, 32(x2)
    sd      x8, 40(x2)

    //
    // Assert
    //
    RVTEST_IO_CHECK()
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x0000000000000000)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0000000000000001)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xffffffffffffffff)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x7fffffffffffffff)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8000000000000000)
    RVTEST_IO_WRITE_STR(x31, "# Test part A1 - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR(x31, "# Test part A2 - general test of value 1 with 0, 1, -1, MIN, MAX register values\n");

    # Addresses for test data and results
    la      x1, test_A2_data
    la      x2, test_A2_res

    # Load testdata
    ld      x8, 0(x1)

    # Register initialization
    li      x9, 0
    li      x10, 1
    li      x11, -1
    li      x12, 0x7FFFFFFFFFFFFFFF
    li      x13, 0x8000000000000000

    # Test
    add     x9, x8, x9
    add     x10, x8, x10
    add     x11, x8, x11
    add     x12, x8, x12
    add     x13, x8, x13

    # Store results
    sd      x8, 0(x2)
    sd      x9, 8(x2)
    sd      x10, 16(x2)
    sd      x11, 24(x2)
    sd      x12, 32(x2)
    sd      x13, 40(x2)

    RVTEST_IO_ASSERT_GPR_EQ(x2, x8,  0x00000001)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9,  0x00000001)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x00000002)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x00000000)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x8000000000000000)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x8000000000000001)
    RVTEST_IO_WRITE_STR(x31, "# Test part A2 - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR(x31, "# Test part A3 - general test of value -1 with 0, 1, -1, MIN, MAX register values\n");

    # Addresses for test data and results
    la      x1, test_A3_data
    la      x2, test_A3_res

    # Load testdata
    ld      x13, 0(x1)

    # Register initialization
    li      x14, 0
    li      x15, 1
    li      x16, -1
    li      x17, 0x7FFFFFFFFFFFFFFF
    li      x18, 0x8000000000000000

    # Test
    add     x14, x13, x14
    add     x15, x13, x15
    add     x16, x13, x16
    add     x17, x13, x17
    add     x18, x13, x18

    # Store results
    sd      x13, 0(x2)
    sd      x14, 8(x2)
    sd      x15, 16(x2)
    sd      x16, 24(x2)
    sd      x17, 32(x2)
    sd      x18, 40(x2)

    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffffffffff)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffffffffffff)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x00000000)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x16, 0xfffffffffffffffe)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x17, 0x7FFFFFFFFFFFFFFE)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x7FFFFFFFFFFFFFFF)
    RVTEST_IO_WRITE_STR(x31, "# Test part A3 - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR(x31, "# Test part A4 - general test of value 0x7FFFFFFFFFFFFFFF with 0, 1, -1, MIN, MAX register values\n");

    # Addresses for test data and results
    la      x1, test_A4_data
    la      x2, test_A4_res

    # Load testdata
    ld      x18, 0(x1)

    # Register initialization
    li      x19, 0
    li      x20, 1
    li      x21, -1
    li      x22, 0x7FFFFFFFFFFFFFFF
    li      x23, 0x8000000000000000

    # Test execution
    add     x19, x18, x19
    add     x20, x18, x20
    add     x21, x18, x21
    add     x22, x18, x22
    add     x23, x18, x23

    # Store results
    sd      x18, 0(x2)
    sd      x19, 8(x2)
    sd      x20, 16(x2)
    sd      x21, 24(x2)
    sd      x22, 32(x2)
    sd      x23, 40(x2)

    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x7FFFFFFFFFFFFFFF)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x7FFFFFFFFFFFFFFF)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x8000000000000000)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x7FFFFFFFFFFFFFFE)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xFFFFFFFFFFFFFFFE)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xFFFFFFFFFFFFFFFF)
    RVTEST_IO_WRITE_STR(x31, "# Test part A4 - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR(x31, "# Test part A5 - general test of value 0x8000000000000000 with 0, 1, -1, MIN, MAX register values\n");

    # Addresses for test data and results
    la      x1, test_A5_data
    la      x2, test_A5_res

    # Load testdata
    ld      x23, 0(x1)

    # Register initialization
    li      x24, 0
    li      x25, 1
    li      x26, -1
    li      x27, 0x7FFFFFFFFFFFFFFF
    li      x28, 0x8000000000000000

    # Test
    add     x24, x23, x24
    add     x25, x23, x25
    add     x26, x23, x26
    add     x27, x23, x27
    add     x28, x23, x28

    # Store results
    sd      x23, 0(x2)
    sd      x24, 8(x2)
    sd      x25, 16(x2)
    sd      x26, 24(x2)
    sd      x27, 32(x2)
    sd      x28, 40(x2)

    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x8000000000000000)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x8000000000000000)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x8000000000000001)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x7FFFFFFFFFFFFFFF)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xFFFFFFFFFFFFFFFF)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x0000000000000000)
    RVTEST_IO_WRITE_STR(x31, "# Test part A5 - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR(x31, "# Test part B - testing forwarding between instructions\n");

    # Addresses for test data and results
    la      x25, test_B_data
    la      x26, test_B_res

    # Load testdata
    ld      x28, 0(x25)

    # Register initialization
    li      x27, 0x1

    # Test
    add     x29, x28, x27
    add     x30, x29, x27
    add     x31, x30, x27
    add     x1, x31, x27
    add     x2, x1, x27
    add     x3, x2, x27

    # store results
    sd      x27, 0(x26)
    sd      x28, 8(x26)
    sd      x29, 16(x26)
    sd      x30, 24(x26)
    sd      x31, 32(x26)
    sd      x1, 40(x26)
    sd      x2, 48(x26)
    sd      x3, 56(x26)

    RVTEST_IO_ASSERT_GPR_EQ(x26, x27, 0x00000001)
    RVTEST_IO_ASSERT_GPR_EQ(x26, x28, 0x0000ABCD12345678)
    RVTEST_IO_ASSERT_GPR_EQ(x26, x29, 0x0000ABCD12345679)
    RVTEST_IO_ASSERT_GPR_EQ(x26, x30, 0x0000ABCD1234567A)
    RVTEST_IO_ASSERT_GPR_EQ(x26, x31, 0x0000ABCD1234567B)
    RVTEST_IO_ASSERT_GPR_EQ(x26, x1,  0x0000ABCD1234567C)
    RVTEST_IO_ASSERT_GPR_EQ(x26, x2,  0x0000ABCD1234567D)
    RVTEST_IO_ASSERT_GPR_EQ(x26, x3,  0x0000ABCD1234567E)
    RVTEST_IO_WRITE_STR(x31, "# Test part B - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR(x31, "# Test part C - testing writing to x0\n");

    # Addresses for test data and results
    la      x1, test_C_data
    la      x2, test_C_res

    # Load testdata
    ld      x28, 0(x1)

    # Register initialization
    li      x27, 0xF7FF8818

    # Test
    add     x0, x28, x27

    # store results
    sd      x0, 0(x2)

    RVTEST_IO_ASSERT_GPR_EQ(x2, x0,  0x00000000)
    RVTEST_IO_WRITE_STR(x31, "# Test part C - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR(x31, "# Test part D - testing forwarding throught x0\n");

    # Addresses for test data and results
    la      x1, test_D_data
    la      x2, test_D_res

    # Load testdata
    ld      x28, 0(x1)

    # Register initialization
    li      x27, 0xF7FF8818F7FF8818

    # Test
    add     x0, x28, x27
    add     x5, x0, x0

    # store results
    sd      x0, 0(x2)
    sd      x5, 8(x2)

    RVTEST_IO_ASSERT_GPR_EQ(x2, x0,  0x00000000)
  //RVTEST_IO_ASSERT_GPR_EQ(x2, x5,  0x00000000)
    RVTEST_IO_WRITE_STR(x31, "# Test part D - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR(x31, "# Test part E - testing moving (add with x0)\n");

    # Addresses for test data and results
    la      x1, test_E_data
    la      x2, test_E_res

    # Load testdata
    ld      x3, 0(x1)

    # Test
    add     x4, x3, x0
    add     x5, x4, x0
    add     x6, x0, x5
    add     x14, x6, x0
    add     x15, x14, x0
    add     x16, x15, x0
    add     x25, x0, x16
    add     x26, x0, x25
    add     x27, x26, x0

    # Store results
    sd      x4, 0(x2)
    sd      x26, 8(x2)
    sd      x27, 16(x2)

    RVTEST_IO_ASSERT_GPR_EQ(x2, x4,  0x3692581436925814)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x3692581436925814)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x3692581436925814)
    RVTEST_IO_WRITE_STR(x31, "# Test part E - Complete\n");

    RVTEST_IO_WRITE_STR(x31, "# Test End\n")

    # ---------------------------------------------------------------------------------------------
    # HALT
    RV_COMPLIANCE_HALT

RV_COMPLIANCE_CODE_END

# Input data section.
    .data
    .align 8
test_A1_data:
    .dword 0
test_A2_data:
    .dword 1
test_A3_data:
    .dword -1
test_A4_data:
    .dword 0x7FFFFFFFFFFFFFFF
test_A5_data:
    .dword 0x8000000000000000
test_B_data:
    .dword 0x0000ABCD12345678
test_C_data:
    .dword 0x12345678abcdef0
test_D_data:
    .dword 0xFEDCBA98FEDCBA98
test_E_data:
    .dword 0x3692581436925814

# Output data section.
RV_COMPLIANCE_DATA_BEGIN
    .align 8
test_A1_res:
    .fill 6, 8, -1
test_A2_res:
    .fill 6, 8, -1
test_A3_res:
    .fill 6, 8, -1
test_A4_res:
    .fill 6, 8, -1
test_A5_res:
    .fill 6, 8, -1
test_B_res:
    .fill 8, 8, -1
test_C_res:
    .fill 1, 8, -1
test_D_res:
    .fill 2, 8, -1
test_E_res:
    .fill 3, 8, -1

RV_COMPLIANCE_DATA_END


