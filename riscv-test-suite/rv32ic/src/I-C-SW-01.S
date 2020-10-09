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

RV_COMPLIANCE_RV32M

RV_COMPLIANCE_CODE_BEGIN


	RVTEST_IO_INIT
	RVTEST_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
	RVTEST_IO_WRITE_STR(x31, "Test Begin\n")

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test group 1\n")



    # Addresses for test results
    la x1, test_1_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0xffffffff
    addi    x15, x1,0
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_1_res+0] = 0xffffffff
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,4
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_1_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,8
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_1_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,12
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_1_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,16
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_1_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")



    # Addresses for test results
    la x1, test_2_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,0
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_2_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,4
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_2_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,8
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_2_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,12
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_2_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,16
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_2_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")



    # Addresses for test results
    la x1, test_3_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,0
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_3_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,4
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_3_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,8
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_3_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,12
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_3_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,16
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_3_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")



    # Addresses for test results
    la x1, test_4_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,0
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_4_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,4
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_4_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,8
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_4_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,12
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_4_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,16
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_4_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")



    # Addresses for test results
    la x1, test_5_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,0
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_5_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,4
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_5_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,8
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_5_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,12
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_5_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,16
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_5_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")



    # Addresses for test results
    la x1, test_6_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,0
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_6_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,4
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_6_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,8
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_6_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,12
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_6_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,16
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_6_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")



    # Addresses for test results
    la x1, test_7_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,0
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_7_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,4
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_7_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,8
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_7_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,12
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_7_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,16
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_7_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")



    # Addresses for test results
    la x1, test_8_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,0
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_8_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,4
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_8_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,8
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_8_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,12
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_8_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,16
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_8_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")



    # Addresses for test results
    la x1, test_9_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,0
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_9_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,4
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_9_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,8
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_9_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,12
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_9_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,16
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_9_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")



    # Addresses for test results
    la x1, test_10_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,0
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_10_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,4
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_10_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,8
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_10_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,12
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_10_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,16
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_10_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")



    # Addresses for test results
    la x1, test_11_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,0
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_11_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,4
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_11_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,8
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_11_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,12
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_11_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,16
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_11_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")



    # Addresses for test results
    la x1, test_12_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,0
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_12_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,4
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_12_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,8
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_12_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,12
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_12_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,16
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_12_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")



    # Addresses for test results
    la x1, test_13_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x11, x1,0
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_13_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,4
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_13_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,8
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_13_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,12
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_13_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x15, x1,16
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_13_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")



    # Addresses for test results
    la x1, test_14_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,0
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_14_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x13, x1,4
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_14_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0x1
    addi    x12, x1,8
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_14_res+8] = 0x00000001
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000001)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x8, 0x2
    addi    x11, x1,12
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_14_res+12] = 0x00000002
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000002)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x4
    addi    x10, x1,16
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_14_res+16] = 0x00000004
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000004)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")



    # Addresses for test results
    la x1, test_15_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0x8
    addi    x9, x1,0
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_15_res+0] = 0x00000008
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000008)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x11, 0x10
    addi    x8, x1,4
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_15_res+4] = 0x00000010
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000010)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x20
    addi    x15, x1,8
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_15_res+8] = 0x00000020
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000020)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x13, 0x40
    addi    x14, x1,12
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_15_res+12] = 0x00000040
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000040)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x14, 0x80
    addi    x13, x1,16
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_15_res+16] = 0x00000080
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000080)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")



    # Addresses for test results
    la x1, test_16_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0x100
    addi    x12, x1,0
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_16_res+0] = 0x00000100
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000100)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x8, 0x200
    addi    x11, x1,4
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_16_res+4] = 0x00000200
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000200)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x400
    addi    x10, x1,8
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_16_res+8] = 0x00000400
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000400)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x10, 0x800
    addi    x9, x1,12
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_16_res+12] = 0x00000800
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000800)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0x1000
    addi    x8, x1,16
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_16_res+16] = 0x00001000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00001000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")



    # Addresses for test results
    la x1, test_17_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x2000
    addi    x15, x1,0
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_17_res+0] = 0x00002000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00002000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x13, 0x4000
    addi    x14, x1,4
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_17_res+4] = 0x00004000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00004000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x8000
    addi    x13, x1,8
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_17_res+8] = 0x00008000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00008000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x15, 0x10000
    addi    x12, x1,12
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_17_res+12] = 0x00010000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00010000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x20000
    addi    x11, x1,16
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_17_res+16] = 0x00020000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00020000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")



    # Addresses for test results
    la x1, test_18_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x40000
    addi    x10, x1,0
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_18_res+0] = 0x00040000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00040000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x10, 0x80000
    addi    x9, x1,4
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_18_res+4] = 0x00080000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00080000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x100000
    addi    x8, x1,8
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_18_res+8] = 0x00100000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00100000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x12, 0x200000
    addi    x15, x1,12
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_18_res+12] = 0x00200000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00200000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x400000
    addi    x14, x1,16
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_18_res+16] = 0x00400000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00400000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")



    # Addresses for test results
    la x1, test_19_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x800000
    addi    x13, x1,0
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_19_res+0] = 0x00800000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00800000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x15, 0x1000000
    addi    x12, x1,4
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_19_res+4] = 0x01000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x01000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x2000000
    addi    x11, x1,8
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_19_res+8] = 0x02000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x02000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x9, 0x4000000
    addi    x10, x1,12
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_19_res+12] = 0x04000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x04000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x8000000
    addi    x9, x1,16
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_19_res+16] = 0x08000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x08000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")



    # Addresses for test results
    la x1, test_20_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x10000000
    addi    x8, x1,0
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_20_res+0] = 0x10000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x10000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x12, 0x20000000
    addi    x15, x1,4
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_20_res+4] = 0x20000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x20000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x40000000
    addi    x14, x1,8
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_20_res+8] = 0x40000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x40000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x14, 0x80000000
    addi    x13, x1,12
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_20_res+12] = 0x80000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x80000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x12, x1,16
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_20_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")



    # Addresses for test results
    la x1, test_21_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0xfffffffe
    addi    x11, x1,0
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_21_res+0] = 0xfffffffe
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffe)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x9, 0xfffffffd
    addi    x10, x1,4
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_21_res+4] = 0xfffffffd
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffd)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0xfffffffb
    addi    x9, x1,8
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_21_res+8] = 0xfffffffb
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffb)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x11, 0xfffffff7
    addi    x8, x1,12
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_21_res+12] = 0xfffffff7
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffff7)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0xffffffef
    addi    x15, x1,16
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_21_res+16] = 0xffffffef
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffef)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")



    # Addresses for test results
    la x1, test_22_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0xffffffdf
    addi    x14, x1,0
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_22_res+0] = 0xffffffdf
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffdf)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x14, 0xffffffbf
    addi    x13, x1,4
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_22_res+4] = 0xffffffbf
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffbf)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0xffffff7f
    addi    x12, x1,8
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_22_res+8] = 0xffffff7f
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffff7f)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x8, 0xfffffeff
    addi    x11, x1,12
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_22_res+12] = 0xfffffeff
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffeff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0xfffffdff
    addi    x10, x1,16
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_22_res+16] = 0xfffffdff
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffdff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")



    # Addresses for test results
    la x1, test_23_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0xfffffbff
    addi    x9, x1,0
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_23_res+0] = 0xfffffbff
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffbff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x11, 0xfffff7ff
    addi    x8, x1,4
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_23_res+4] = 0xfffff7ff
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffff7ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0xffffefff
    addi    x15, x1,8
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 116(x15)
    # Check results:  mem[test_23_res+8] = 0xffffefff
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffefff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x13, 0xffffdfff
    addi    x14, x1,12
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 120(x14)
    # Check results:  mem[test_23_res+12] = 0xffffdfff
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffdfff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x14, 0xffffbfff
    addi    x13, x1,16
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 0(x13)
    # Check results:  mem[test_23_res+16] = 0xffffbfff
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffbfff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")



    # Addresses for test results
    la x1, test_24_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0xffff7fff
    addi    x12, x1,0
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 64(x12)
    # Check results:  mem[test_24_res+0] = 0xffff7fff
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffff7fff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x8, 0xfffeffff
    addi    x11, x1,4
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 32(x11)
    # Check results:  mem[test_24_res+4] = 0xfffeffff
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffeffff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0xfffdffff
    addi    x10, x1,8
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 16(x10)
    # Check results:  mem[test_24_res+8] = 0xfffdffff
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffdffff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x10, 0xfffbffff
    addi    x9, x1,12
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 8(x9)
    # Check results:  mem[test_24_res+12] = 0xfffbffff
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffbffff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0xfff7ffff
    addi    x8, x1,16
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 4(x8)
    # Check results:  mem[test_24_res+16] = 0xfff7ffff
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfff7ffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")



    # Addresses for test results
    la x1, test_25_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0xffefffff
    addi    x15, x1,0
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 124(x15)
    # Check results:  mem[test_25_res+0] = 0xffefffff
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffefffff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x13, 0xffdfffff
    addi    x14, x1,4
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 60(x14)
    # Check results:  mem[test_25_res+4] = 0xffdfffff
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffdfffff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0xffbfffff
    addi    x13, x1,8
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 92(x13)
    # Check results:  mem[test_25_res+8] = 0xffbfffff
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffbfffff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x15, 0xff7fffff
    addi    x12, x1,12
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 108(x12)
    # Check results:  mem[test_25_res+12] = 0xff7fffff
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xff7fffff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0xfeffffff
    addi    x11, x1,16
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 116(x11)
    # Check results:  mem[test_25_res+16] = 0xfeffffff
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfeffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")



    # Addresses for test results
    la x1, test_26_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0xfdffffff
    addi    x10, x1,0
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 120(x10)
    # Check results:  mem[test_26_res+0] = 0xfdffffff
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfdffffff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x10, 0xfbffffff
    addi    x9, x1,4
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 0(x9)
    # Check results:  mem[test_26_res+4] = 0xfbffffff
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfbffffff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0xf7ffffff
    addi    x8, x1,8
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 64(x8)
    # Check results:  mem[test_26_res+8] = 0xf7ffffff
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xf7ffffff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x12, 0xefffffff
    addi    x15, x1,12
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    # Test Instruction 
    c.sw      x12, 32(x15)
    # Check results:  mem[test_26_res+12] = 0xefffffff
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xefffffff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0xdfffffff
    addi    x14, x1,16
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    # Test Instruction 
    c.sw      x13, 16(x14)
    # Check results:  mem[test_26_res+16] = 0xdfffffff
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xdfffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")



    # Addresses for test results
    la x1, test_27_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0xbfffffff
    addi    x13, x1,0
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    # Test Instruction 
    c.sw      x14, 8(x13)
    # Check results:  mem[test_27_res+0] = 0xbfffffff
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xbfffffff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x15, 0x7fffffff
    addi    x12, x1,4
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    c.sw      x15, 4(x12)
    # Check results:  mem[test_27_res+4] = 0x7fffffff
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x7fffffff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0xffffffff
    addi    x11, x1,8
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    # Test Instruction 
    c.sw      x8, 124(x11)
    # Check results:  mem[test_27_res+8] = 0xffffffff
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,12
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    # Test Instruction 
    c.sw      x9, 60(x10)
    # Check results:  mem[test_27_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x9, x1,16
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    # Test Instruction 
    c.sw      x10, 92(x9)
    # Check results:  mem[test_27_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")



    # Addresses for test results
    la x1, test_28_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x8, x1,0
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    # Test Instruction 
    c.sw      x11, 108(x8)
    # Check results:  mem[test_28_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

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
	.fill 5, 4, -1
test_2_res:
	.fill 5, 4, -1
test_3_res:
	.fill 5, 4, -1
test_4_res:
	.fill 5, 4, -1
test_5_res:
	.fill 5, 4, -1
test_6_res:
	.fill 5, 4, -1
test_7_res:
	.fill 5, 4, -1
test_8_res:
	.fill 5, 4, -1
test_9_res:
	.fill 5, 4, -1
test_10_res:
	.fill 5, 4, -1
test_11_res:
	.fill 5, 4, -1
test_12_res:
	.fill 5, 4, -1
test_13_res:
	.fill 5, 4, -1
test_14_res:
	.fill 5, 4, -1
test_15_res:
	.fill 5, 4, -1
test_16_res:
	.fill 5, 4, -1
test_17_res:
	.fill 5, 4, -1
test_18_res:
	.fill 5, 4, -1
test_19_res:
	.fill 5, 4, -1
test_20_res:
	.fill 5, 4, -1
test_21_res:
	.fill 5, 4, -1
test_22_res:
	.fill 5, 4, -1
test_23_res:
	.fill 5, 4, -1
test_24_res:
	.fill 5, 4, -1
test_25_res:
	.fill 5, 4, -1
test_26_res:
	.fill 5, 4, -1
test_27_res:
	.fill 5, 4, -1
test_28_res:
	.fill 5, 4, -1

RV_COMPLIANCE_DATA_END

