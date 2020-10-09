# RISC-V Compliance Test I-C-SW-01
#
    #
    # Copyright (c) 2005-2020 Imperas Software Ltd., www.imperas.com
    #
    # The contents of this file are provided under the Software License
    # Agreement that you accepted before downloading this file.
    #
    # This source forms part of the Software and can be used for educational,
    # training, and demonstration purposes but cannot be used for derivative
    # works except in cases where the derivative works require OVP technology
    # to run.
    #
    # For open source models released under licenses that you can use for
    # derivative works, please visit www.OVPworld.org or www.imperas.com
    # for the location of the open source models.
    #
    

#
# Specification: C Standard Extension for Compressed Integer Instructions
# Description: Testing instruction 'c.sw'.

#include "riscv_test_macros.h"
#include "compliance_test.h"
#include "compliance_io.h"

RV_COMPLIANCE_RV64M

RV_COMPLIANCE_CODE_BEGIN


	RVTEST_IO_INIT
	RVTEST_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
	RVTEST_IO_WRITE_STR(x31, "Test Begin\n")

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test group 1\n")



    # Addresses for test results
    la x1, test_1_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0xffffffffffffffff
    addi    x15, x1,0
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_1_res+0] = 0x00000000ffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,8
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_1_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,16
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_1_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,24
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_1_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,32
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_1_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")



    # Addresses for test results
    la x1, test_2_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,0
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_2_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,8
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_2_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,16
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_2_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,24
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_2_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,32
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_2_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")



    # Addresses for test results
    la x1, test_3_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,0
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_3_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,8
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_3_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,16
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_3_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,24
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_3_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,32
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_3_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")



    # Addresses for test results
    la x1, test_4_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,0
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_4_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,8
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_4_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,16
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_4_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,24
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_4_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,32
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_4_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")



    # Addresses for test results
    la x1, test_5_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,0
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_5_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,8
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_5_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,16
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_5_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,24
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_5_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,32
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_5_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")



    # Addresses for test results
    la x1, test_6_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,0
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_6_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,8
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_6_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,16
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_6_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,24
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_6_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,32
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_6_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")



    # Addresses for test results
    la x1, test_7_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,0
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_7_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,8
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_7_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,16
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_7_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,24
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_7_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,32
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_7_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")



    # Addresses for test results
    la x1, test_8_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,0
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_8_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,8
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_8_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,16
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_8_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,24
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_8_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,32
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_8_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")



    # Addresses for test results
    la x1, test_9_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,0
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_9_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,8
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_9_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,16
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_9_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,24
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_9_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,32
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_9_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")



    # Addresses for test results
    la x1, test_10_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,0
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_10_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,8
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_10_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,16
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_10_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,24
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_10_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,32
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_10_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")



    # Addresses for test results
    la x1, test_11_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,0
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_11_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,8
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_11_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,16
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_11_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,24
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_11_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,32
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_11_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")



    # Addresses for test results
    la x1, test_12_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,0
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_12_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,8
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_12_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,16
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_12_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,24
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_12_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,32
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_12_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")



    # Addresses for test results
    la x1, test_13_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,0
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_13_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,8
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_13_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,16
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_13_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,24
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_13_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,32
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_13_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")



    # Addresses for test results
    la x1, test_14_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,0
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_14_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,8
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_14_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,16
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_14_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,24
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_14_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,32
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_14_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")



    # Addresses for test results
    la x1, test_15_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,0
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_15_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,8
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_15_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,16
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_15_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,24
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_15_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,32
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_15_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")



    # Addresses for test results
    la x1, test_16_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,0
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_16_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,8
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_16_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,16
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_16_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,24
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_16_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,32
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_16_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")



    # Addresses for test results
    la x1, test_17_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,0
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_17_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,8
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_17_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,16
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_17_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,24
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_17_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,32
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_17_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")



    # Addresses for test results
    la x1, test_18_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,0
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_18_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,8
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_18_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,16
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_18_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,24
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_18_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,32
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_18_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")



    # Addresses for test results
    la x1, test_19_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,0
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_19_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,8
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_19_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,16
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_19_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,24
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_19_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,32
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_19_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")



    # Addresses for test results
    la x1, test_20_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,0
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_20_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,8
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_20_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,16
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_20_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,24
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_20_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,32
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_20_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")



    # Addresses for test results
    la x1, test_21_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,0
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_21_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,8
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_21_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,16
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_21_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,24
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_21_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,32
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_21_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")



    # Addresses for test results
    la x1, test_22_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,0
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_22_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,8
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_22_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,16
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_22_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,24
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_22_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,32
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_22_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")



    # Addresses for test results
    la x1, test_23_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,0
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_23_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,8
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_23_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,16
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_23_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,24
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_23_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,32
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_23_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")



    # Addresses for test results
    la x1, test_24_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,0
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_24_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,8
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_24_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,16
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_24_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,24
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_24_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,32
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_24_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")



    # Addresses for test results
    la x1, test_25_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,0
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_25_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,8
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_25_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,16
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_25_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,24
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_25_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,32
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_25_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")



    # Addresses for test results
    la x1, test_26_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,0
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_26_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,8
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_26_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,16
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_26_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,24
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_26_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,32
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_26_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")



    # Addresses for test results
    la x1, test_27_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,0
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_27_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0x1
    addi    x12, x1,8
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_27_res+8] = 0x0000000000000001
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000001)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x2
    addi    x11, x1,16
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_27_res+16] = 0x0000000000000002
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000002)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x4
    addi    x10, x1,24
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_27_res+24] = 0x0000000000000004
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000004)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0x8
    addi    x9, x1,32
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_27_res+32] = 0x0000000000000008
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000008)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")



    # Addresses for test results
    la x1, test_28_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x10
    addi    x8, x1,0
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_28_res+0] = 0x0000000000000010
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000010)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x20
    addi    x15, x1,8
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_28_res+8] = 0x0000000000000020
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000020)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x40
    addi    x14, x1,16
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_28_res+16] = 0x0000000000000040
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000040)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x14, 0x80
    addi    x13, x1,24
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_28_res+24] = 0x0000000000000080
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000080)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x15, 0x100
    addi    x12, x1,32
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_28_res+32] = 0x0000000000000100
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000100)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")



    # Addresses for test results
    la x1, test_29_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x200
    addi    x11, x1,0
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_29_res+0] = 0x0000000000000200
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000200)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x400
    addi    x10, x1,8
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_29_res+8] = 0x0000000000000400
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000400)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x800
    addi    x9, x1,16
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_29_res+16] = 0x0000000000000800
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000800)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0x1000
    addi    x8, x1,24
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_29_res+24] = 0x0000000000001000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000001000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x12, 0x2000
    addi    x15, x1,32
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_29_res+32] = 0x0000000000002000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000002000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")



    # Addresses for test results
    la x1, test_30_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x4000
    addi    x14, x1,0
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_30_res+0] = 0x0000000000004000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000004000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x8000
    addi    x13, x1,8
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_30_res+8] = 0x0000000000008000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000008000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x15, 0x10000
    addi    x12, x1,16
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_30_res+16] = 0x0000000000010000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000010000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x20000
    addi    x11, x1,24
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_30_res+24] = 0x0000000000020000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000020000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0x40000
    addi    x10, x1,32
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_30_res+32] = 0x0000000000040000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000040000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")



    # Addresses for test results
    la x1, test_31_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0x80000
    addi    x9, x1,0
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_31_res+0] = 0x0000000000080000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000080000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x100000
    addi    x8, x1,8
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_31_res+8] = 0x0000000000100000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000100000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0x200000
    addi    x15, x1,16
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_31_res+16] = 0x0000000000200000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000200000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x13, 0x400000
    addi    x14, x1,24
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_31_res+24] = 0x0000000000400000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000400000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x14, 0x800000
    addi    x13, x1,32
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_31_res+32] = 0x0000000000800000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000800000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")



    # Addresses for test results
    la x1, test_32_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0x1000000
    addi    x12, x1,0
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_32_res+0] = 0x0000000001000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000001000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x2000000
    addi    x11, x1,8
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_32_res+8] = 0x0000000002000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000002000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x4000000
    addi    x10, x1,16
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_32_res+16] = 0x0000000004000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000004000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0x8000000
    addi    x9, x1,24
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_32_res+24] = 0x0000000008000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000008000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x11, 0x10000000
    addi    x8, x1,32
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_32_res+32] = 0x0000000010000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000010000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")



    # Addresses for test results
    la x1, test_33_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x20000000
    addi    x15, x1,0
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_33_res+0] = 0x0000000020000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000020000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x40000000
    addi    x14, x1,8
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_33_res+8] = 0x0000000040000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000040000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x14, 0x80000000
    addi    x13, x1,16
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_33_res+16] = 0x0000000080000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000080000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x15, 0x100000000
    addi    x12, x1,24
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_33_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x200000000
    addi    x11, x1,32
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_33_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")



    # Addresses for test results
    la x1, test_34_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x400000000
    addi    x10, x1,0
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_34_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x800000000
    addi    x9, x1,8
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_34_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0x1000000000
    addi    x8, x1,16
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_34_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x12, 0x2000000000
    addi    x15, x1,24
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_34_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x13, 0x4000000000
    addi    x14, x1,32
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_34_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")



    # Addresses for test results
    la x1, test_35_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x8000000000
    addi    x13, x1,0
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_35_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0x10000000000
    addi    x12, x1,8
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_35_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x20000000000
    addi    x11, x1,16
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_35_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x40000000000
    addi    x10, x1,24
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_35_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0x80000000000
    addi    x9, x1,32
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_35_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")



    # Addresses for test results
    la x1, test_36_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x100000000000
    addi    x8, x1,0
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_36_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x200000000000
    addi    x15, x1,8
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_36_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x400000000000
    addi    x14, x1,16
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_36_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x14, 0x800000000000
    addi    x13, x1,24
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_36_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x15, 0x1000000000000
    addi    x12, x1,32
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_36_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")



    # Addresses for test results
    la x1, test_37_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x2000000000000
    addi    x11, x1,0
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_37_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x4000000000000
    addi    x10, x1,8
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_37_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x8000000000000
    addi    x9, x1,16
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_37_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0x10000000000000
    addi    x8, x1,24
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_37_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x12, 0x20000000000000
    addi    x15, x1,32
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_37_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")



    # Addresses for test results
    la x1, test_38_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x40000000000000
    addi    x14, x1,0
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_38_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x80000000000000
    addi    x13, x1,8
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_38_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x15, 0x100000000000000
    addi    x12, x1,16
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_38_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x200000000000000
    addi    x11, x1,24
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_38_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0x400000000000000
    addi    x10, x1,32
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_38_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")



    # Addresses for test results
    la x1, test_39_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0x800000000000000
    addi    x9, x1,0
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_39_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x1000000000000000
    addi    x8, x1,8
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_39_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0x2000000000000000
    addi    x15, x1,16
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_39_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x13, 0x4000000000000000
    addi    x14, x1,24
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_39_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x14, 0x8000000000000000
    addi    x13, x1,32
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_39_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")



    # Addresses for test results
    la x1, test_40_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,0
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_40_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0xfffffffffffffffe
    addi    x11, x1,8
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_40_res+8] = 0x00000000fffffffe
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffffffe)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0xfffffffffffffffd
    addi    x10, x1,16
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_40_res+16] = 0x00000000fffffffd
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffffffd)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0xfffffffffffffffb
    addi    x9, x1,24
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_40_res+24] = 0x00000000fffffffb
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffffffb)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x11, 0xfffffffffffffff7
    addi    x8, x1,32
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_40_res+32] = 0x00000000fffffff7
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffffff7)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")



    # Addresses for test results
    la x1, test_41_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0xffffffffffffffef
    addi    x15, x1,0
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_41_res+0] = 0x00000000ffffffef
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffef)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0xffffffffffffffdf
    addi    x14, x1,8
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_41_res+8] = 0x00000000ffffffdf
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffdf)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x14, 0xffffffffffffffbf
    addi    x13, x1,16
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_41_res+16] = 0x00000000ffffffbf
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffbf)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x15, 0xffffffffffffff7f
    addi    x12, x1,24
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_41_res+24] = 0x00000000ffffff7f
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffff7f)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0xfffffffffffffeff
    addi    x11, x1,32
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_41_res+32] = 0x00000000fffffeff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffffeff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")



    # Addresses for test results
    la x1, test_42_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0xfffffffffffffdff
    addi    x10, x1,0
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_42_res+0] = 0x00000000fffffdff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffffdff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0xfffffffffffffbff
    addi    x9, x1,8
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_42_res+8] = 0x00000000fffffbff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffffbff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0xfffffffffffff7ff
    addi    x8, x1,16
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_42_res+16] = 0x00000000fffff7ff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffff7ff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x12, 0xffffffffffffefff
    addi    x15, x1,24
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_42_res+24] = 0x00000000ffffefff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffefff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x13, 0xffffffffffffdfff
    addi    x14, x1,32
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_42_res+32] = 0x00000000ffffdfff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffdfff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")



    # Addresses for test results
    la x1, test_43_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0xffffffffffffbfff
    addi    x13, x1,0
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_43_res+0] = 0x00000000ffffbfff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffbfff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0xffffffffffff7fff
    addi    x12, x1,8
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_43_res+8] = 0x00000000ffff7fff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffff7fff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0xfffffffffffeffff
    addi    x11, x1,16
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_43_res+16] = 0x00000000fffeffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffeffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0xfffffffffffdffff
    addi    x10, x1,24
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_43_res+24] = 0x00000000fffdffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffdffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0xfffffffffffbffff
    addi    x9, x1,32
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_43_res+32] = 0x00000000fffbffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fffbffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")



    # Addresses for test results
    la x1, test_44_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0xfffffffffff7ffff
    addi    x8, x1,0
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_44_res+0] = 0x00000000fff7ffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fff7ffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0xffffffffffefffff
    addi    x15, x1,8
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_44_res+8] = 0x00000000ffefffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffefffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0xffffffffffdfffff
    addi    x14, x1,16
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_44_res+16] = 0x00000000ffdfffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffdfffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x14, 0xffffffffffbfffff
    addi    x13, x1,24
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_44_res+24] = 0x00000000ffbfffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffbfffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x15, 0xffffffffff7fffff
    addi    x12, x1,32
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_44_res+32] = 0x00000000ff7fffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ff7fffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")



    # Addresses for test results
    la x1, test_45_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0xfffffffffeffffff
    addi    x11, x1,0
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_45_res+0] = 0x00000000feffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000feffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0xfffffffffdffffff
    addi    x10, x1,8
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_45_res+8] = 0x00000000fdffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fdffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0xfffffffffbffffff
    addi    x9, x1,16
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_45_res+16] = 0x00000000fbffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000fbffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0xfffffffff7ffffff
    addi    x8, x1,24
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_45_res+24] = 0x00000000f7ffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000f7ffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x12, 0xffffffffefffffff
    addi    x15, x1,32
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_45_res+32] = 0x00000000efffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000efffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")



    # Addresses for test results
    la x1, test_46_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0xffffffffdfffffff
    addi    x14, x1,0
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_46_res+0] = 0x00000000dfffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000dfffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0xffffffffbfffffff
    addi    x13, x1,8
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_46_res+8] = 0x00000000bfffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000bfffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x15, 0xffffffff7fffffff
    addi    x12, x1,16
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_46_res+16] = 0x000000007fffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x000000007fffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0xfffffffeffffffff
    addi    x11, x1,24
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_46_res+24] = 0x00000000ffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0xfffffffdffffffff
    addi    x10, x1,32
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_46_res+32] = 0x00000000ffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")



    # Addresses for test results
    la x1, test_47_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0xfffffffbffffffff
    addi    x9, x1,0
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_47_res+0] = 0x00000000ffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0xfffffff7ffffffff
    addi    x8, x1,8
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_47_res+8] = 0x00000000ffffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0xffffffefffffffff
    addi    x15, x1,16
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_47_res+16] = 0x00000000ffffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x13, 0xffffffdfffffffff
    addi    x14, x1,24
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_47_res+24] = 0x00000000ffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x14, 0xffffffbfffffffff
    addi    x13, x1,32
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_47_res+32] = 0x00000000ffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")



    # Addresses for test results
    la x1, test_48_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0xffffff7fffffffff
    addi    x12, x1,0
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_48_res+0] = 0x00000000ffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0xfffffeffffffffff
    addi    x11, x1,8
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_48_res+8] = 0x00000000ffffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0xfffffdffffffffff
    addi    x10, x1,16
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_48_res+16] = 0x00000000ffffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0xfffffbffffffffff
    addi    x9, x1,24
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_48_res+24] = 0x00000000ffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x11, 0xfffff7ffffffffff
    addi    x8, x1,32
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_48_res+32] = 0x00000000ffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")



    # Addresses for test results
    la x1, test_49_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0xffffefffffffffff
    addi    x15, x1,0
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_49_res+0] = 0x00000000ffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0xffffdfffffffffff
    addi    x14, x1,8
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_49_res+8] = 0x00000000ffffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x14, 0xffffbfffffffffff
    addi    x13, x1,16
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_49_res+16] = 0x00000000ffffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x15, 0xffff7fffffffffff
    addi    x12, x1,24
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_49_res+24] = 0x00000000ffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0xfffeffffffffffff
    addi    x11, x1,32
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_49_res+32] = 0x00000000ffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")



    # Addresses for test results
    la x1, test_50_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0xfffdffffffffffff
    addi    x10, x1,0
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_50_res+0] = 0x00000000ffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0xfffbffffffffffff
    addi    x9, x1,8
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_50_res+8] = 0x00000000ffffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0xfff7ffffffffffff
    addi    x8, x1,16
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_50_res+16] = 0x00000000ffffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x12, 0xffefffffffffffff
    addi    x15, x1,24
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_50_res+24] = 0x00000000ffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x13, 0xffdfffffffffffff
    addi    x14, x1,32
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_50_res+32] = 0x00000000ffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")



    # Addresses for test results
    la x1, test_51_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0xffbfffffffffffff
    addi    x13, x1,0
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_51_res+0] = 0x00000000ffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0xff7fffffffffffff
    addi    x12, x1,8
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_51_res+8] = 0x00000000ffffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0xfeffffffffffffff
    addi    x11, x1,16
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_51_res+16] = 0x00000000ffffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0xfdffffffffffffff
    addi    x10, x1,24
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_51_res+24] = 0x00000000ffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0xfbffffffffffffff
    addi    x9, x1,32
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_51_res+32] = 0x00000000ffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")



    # Addresses for test results
    la x1, test_52_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0xf7ffffffffffffff
    addi    x8, x1,0
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_52_res+0] = 0x00000000ffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0xefffffffffffffff
    addi    x15, x1,8
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_52_res+8] = 0x00000000ffffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0xdfffffffffffffff
    addi    x14, x1,16
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_52_res+16] = 0x00000000ffffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x14, 0xbfffffffffffffff
    addi    x13, x1,24
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_52_res+24] = 0x00000000ffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x15, 0x7fffffffffffffff
    addi    x12, x1,32
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_52_res+32] = 0x00000000ffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")



    # Addresses for test results
    la x1, test_53_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0xffffffffffffffff
    addi    x11, x1,0
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_53_res+0] = 0x00000000ffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,8
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_53_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,16
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_53_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,24
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_53_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	
	RVTEST_IO_WRITE_STR(x31, "Test End\n")

	# ---------------------------------------------------------------------------------------------

	RV_COMPLIANCE_HALT

RV_COMPLIANCE_CODE_END

# Input data section.
	.data


# Output data section.
RV_COMPLIANCE_DATA_BEGIN

test_1_res:
	.fill 5, 8, -1
test_2_res:
	.fill 5, 8, -1
test_3_res:
	.fill 5, 8, -1
test_4_res:
	.fill 5, 8, -1
test_5_res:
	.fill 5, 8, -1
test_6_res:
	.fill 5, 8, -1
test_7_res:
	.fill 5, 8, -1
test_8_res:
	.fill 5, 8, -1
test_9_res:
	.fill 5, 8, -1
test_10_res:
	.fill 5, 8, -1
test_11_res:
	.fill 5, 8, -1
test_12_res:
	.fill 5, 8, -1
test_13_res:
	.fill 5, 8, -1
test_14_res:
	.fill 5, 8, -1
test_15_res:
	.fill 5, 8, -1
test_16_res:
	.fill 5, 8, -1
test_17_res:
	.fill 5, 8, -1
test_18_res:
	.fill 5, 8, -1
test_19_res:
	.fill 5, 8, -1
test_20_res:
	.fill 5, 8, -1
test_21_res:
	.fill 5, 8, -1
test_22_res:
	.fill 5, 8, -1
test_23_res:
	.fill 5, 8, -1
test_24_res:
	.fill 5, 8, -1
test_25_res:
	.fill 5, 8, -1
test_26_res:
	.fill 5, 8, -1
test_27_res:
	.fill 5, 8, -1
test_28_res:
	.fill 5, 8, -1
test_29_res:
	.fill 5, 8, -1
test_30_res:
	.fill 5, 8, -1
test_31_res:
	.fill 5, 8, -1
test_32_res:
	.fill 5, 8, -1
test_33_res:
	.fill 5, 8, -1
test_34_res:
	.fill 5, 8, -1
test_35_res:
	.fill 5, 8, -1
test_36_res:
	.fill 5, 8, -1
test_37_res:
	.fill 5, 8, -1
test_38_res:
	.fill 5, 8, -1
test_39_res:
	.fill 5, 8, -1
test_40_res:
	.fill 5, 8, -1
test_41_res:
	.fill 5, 8, -1
test_42_res:
	.fill 5, 8, -1
test_43_res:
	.fill 5, 8, -1
test_44_res:
	.fill 5, 8, -1
test_45_res:
	.fill 5, 8, -1
test_46_res:
	.fill 5, 8, -1
test_47_res:
	.fill 5, 8, -1
test_48_res:
	.fill 5, 8, -1
test_49_res:
	.fill 5, 8, -1
test_50_res:
	.fill 5, 8, -1
test_51_res:
	.fill 5, 8, -1
test_52_res:
	.fill 5, 8, -1
test_53_res:
	.fill 5, 8, -1

RV_COMPLIANCE_DATA_END

