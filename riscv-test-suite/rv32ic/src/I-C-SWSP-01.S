# RISC-V Compliance Test I-C-SWSP-01
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
# Description: Testing instruction 'c.swsp'.

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
    la x6, test_1_res

    # Clear memory
    sw      x0, 0(x6)
    # Load values and compute offsets
    li      x16, 0xffffffff
    addi    x2, x6,0
    li     x7, MASK_XLEN(-124)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x16, 124(x2)
    # Check results:  mem[test_1_res+0] = 0xffffffff
    lw x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xffffffff)

    # Clear memory
    sw      x0, 4(x6)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x6,4
    li     x7, MASK_XLEN(-60)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x15, 60(x2)
    # Check results:  mem[test_1_res+4] = 0x00000000
    lw x8, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x6)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x6,8
    li     x7, MASK_XLEN(-92)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x14, 92(x2)
    # Check results:  mem[test_1_res+8] = 0x00000000
    lw x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x6)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x6,12
    li     x7, MASK_XLEN(-108)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x13, 108(x2)
    # Check results:  mem[test_1_res+12] = 0x00000000
    lw x8, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x6)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x6,16
    li     x7, MASK_XLEN(-116)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x12, 116(x2)
    # Check results:  mem[test_1_res+16] = 0x00000000
    lw x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")



    # Addresses for test results
    la x1, test_2_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x11, 120(x2)
    # Check results:  mem[test_2_res+0] = 0x00000000
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,4
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 0(x2)
    # Check results:  mem[test_2_res+4] = 0x00000000
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 64(x2)
    # Check results:  mem[test_2_res+8] = 0x00000000
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x2, x1,12
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 32(x2)
    # Check results:  mem[test_2_res+12] = 0x00000000
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 16(x2)
    # Check results:  mem[test_2_res+16] = 0x00000000
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")



    # Addresses for test results
    la x7, test_3_res

    # Clear memory
    sw      x0, 0(x7)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x2, x7,0
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x6, 8(x2)
    # Check results:  mem[test_3_res+0] = 0x00000000
    lw x9, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

    # Clear memory
    sw      x0, 4(x7)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x2, x7,4
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x5, 4(x2)
    # Check results:  mem[test_3_res+4] = 0x00000000
    lw x9, 4(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

    # Clear memory
    sw      x0, 8(x7)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x2, x7,8
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x4, 124(x2)
    # Check results:  mem[test_3_res+8] = 0x00000000
    lw x9, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

    # Clear memory
    sw      x0, 12(x7)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x7,12
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x3, 60(x2)
    # Check results:  mem[test_3_res+12] = 0x00000000
    lw x9, 12(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

    # Clear memory
    sw      x0, 16(x7)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x7,16
    li     x8, MASK_XLEN(-92)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x1, 92(x2)
    # Check results:  mem[test_3_res+16] = 0x00000000
    lw x9, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")



    # Addresses for test results
    la x3, test_4_res

    # Clear memory
    sw      x0, 0(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x3,0
    li     x4, MASK_XLEN(-108)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x1, 108(x2)
    # Check results:  mem[test_4_res+0] = 0x00000000
    lw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 4(x3)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x2, x3,4
    li     x4, MASK_XLEN(-116)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x31, 116(x2)
    # Check results:  mem[test_4_res+4] = 0x00000000
    lw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 8(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x30, 120(x2)
    # Check results:  mem[test_4_res+8] = 0x00000000
    lw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 12(x3)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x2, x3,12
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x29, 0(x2)
    # Check results:  mem[test_4_res+12] = 0x00000000
    lw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 16(x3)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x2, x3,16
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x28, 64(x2)
    # Check results:  mem[test_4_res+16] = 0x00000000
    lw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")



    # Addresses for test results
    la x1, test_5_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 32(x2)
    # Check results:  mem[test_5_res+0] = 0x00000000
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x2, x1,4
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 16(x2)
    # Check results:  mem[test_5_res+4] = 0x00000000
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 8(x2)
    # Check results:  mem[test_5_res+8] = 0x00000000
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x2, x1,12
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 4(x2)
    # Check results:  mem[test_5_res+12] = 0x00000000
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 124(x2)
    # Check results:  mem[test_5_res+16] = 0x00000000
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")



    # Addresses for test results
    la x1, test_6_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 60(x2)
    # Check results:  mem[test_6_res+0] = 0x00000000
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x2, x1,4
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 92(x2)
    # Check results:  mem[test_6_res+4] = 0x00000000
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x20, 108(x2)
    # Check results:  mem[test_6_res+8] = 0x00000000
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x2, x1,12
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x19, 116(x2)
    # Check results:  mem[test_6_res+12] = 0x00000000
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x18, 120(x2)
    # Check results:  mem[test_6_res+16] = 0x00000000
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")



    # Addresses for test results
    la x5, test_7_res

    # Clear memory
    sw      x0, 0(x5)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x2, x5,0
    li     x6, MASK_XLEN(0)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x17, 0(x2)
    # Check results:  mem[test_7_res+0] = 0x00000000
    lw x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 4(x5)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x2, x5,4
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x16, 64(x2)
    # Check results:  mem[test_7_res+4] = 0x00000000
    lw x7, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 8(x5)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x5,8
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x15, 32(x2)
    # Check results:  mem[test_7_res+8] = 0x00000000
    lw x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 12(x5)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x5,12
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x14, 16(x2)
    # Check results:  mem[test_7_res+12] = 0x00000000
    lw x7, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 16(x5)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x5,16
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x13, 8(x2)
    # Check results:  mem[test_7_res+16] = 0x00000000
    lw x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")



    # Addresses for test results
    la x1, test_8_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x12, 4(x2)
    # Check results:  mem[test_8_res+0] = 0x00000000
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,4
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x11, 124(x2)
    # Check results:  mem[test_8_res+4] = 0x00000000
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 60(x2)
    # Check results:  mem[test_8_res+8] = 0x00000000
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x2, x1,12
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 92(x2)
    # Check results:  mem[test_8_res+12] = 0x00000000
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 108(x2)
    # Check results:  mem[test_8_res+16] = 0x00000000
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")



    # Addresses for test results
    la x1, test_9_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x2, x1,0
    li     x8, MASK_XLEN(-116)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x7, 116(x2)
    # Check results:  mem[test_9_res+0] = 0x00000000
    lw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x2, x1,4
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x6, 120(x2)
    # Check results:  mem[test_9_res+4] = 0x00000000
    lw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x2, x1,8
    li     x8, MASK_XLEN(0)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x5, 0(x2)
    # Check results:  mem[test_9_res+8] = 0x00000000
    lw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x2, x1,12
    li     x8, MASK_XLEN(-64)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x4, 64(x2)
    # Check results:  mem[test_9_res+12] = 0x00000000
    lw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x1,16
    li     x8, MASK_XLEN(-32)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x3, 32(x2)
    # Check results:  mem[test_9_res+16] = 0x00000000
    lw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")



    # Addresses for test results
    la x3, test_10_res

    # Clear memory
    sw      x0, 0(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x3,0
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x1, 16(x2)
    # Check results:  mem[test_10_res+0] = 0x00000000
    lw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 4(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x3,4
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x1, 8(x2)
    # Check results:  mem[test_10_res+4] = 0x00000000
    lw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 8(x3)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(-4)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x31, 4(x2)
    # Check results:  mem[test_10_res+8] = 0x00000000
    lw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 12(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x2, x3,12
    li     x4, MASK_XLEN(-124)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x30, 124(x2)
    # Check results:  mem[test_10_res+12] = 0x00000000
    lw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 16(x3)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x2, x3,16
    li     x4, MASK_XLEN(-60)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x29, 60(x2)
    # Check results:  mem[test_10_res+16] = 0x00000000
    lw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")



    # Addresses for test results
    la x1, test_11_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x28, 92(x2)
    # Check results:  mem[test_11_res+0] = 0x00000000
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x2, x1,4
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 108(x2)
    # Check results:  mem[test_11_res+4] = 0x00000000
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 116(x2)
    # Check results:  mem[test_11_res+8] = 0x00000000
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x2, x1,12
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 120(x2)
    # Check results:  mem[test_11_res+12] = 0x00000000
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 0(x2)
    # Check results:  mem[test_11_res+16] = 0x00000000
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")



    # Addresses for test results
    la x1, test_12_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 64(x2)
    # Check results:  mem[test_12_res+0] = 0x00000000
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x2, x1,4
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 32(x2)
    # Check results:  mem[test_12_res+4] = 0x00000000
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 16(x2)
    # Check results:  mem[test_12_res+8] = 0x00000000
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x2, x1,12
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x20, 8(x2)
    # Check results:  mem[test_12_res+12] = 0x00000000
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x19, 4(x2)
    # Check results:  mem[test_12_res+16] = 0x00000000
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")



    # Addresses for test results
    la x4, test_13_res

    # Clear memory
    sw      x0, 0(x4)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x4,0
    li     x5, MASK_XLEN(-124)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x18, 124(x2)
    # Check results:  mem[test_13_res+0] = 0x00000000
    lw x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 4(x4)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x2, x4,4
    li     x5, MASK_XLEN(-60)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x17, 60(x2)
    # Check results:  mem[test_13_res+4] = 0x00000000
    lw x6, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 8(x4)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x2, x4,8
    li     x5, MASK_XLEN(-92)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x16, 92(x2)
    # Check results:  mem[test_13_res+8] = 0x00000000
    lw x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 12(x4)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x4,12
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x15, 108(x2)
    # Check results:  mem[test_13_res+12] = 0x00000000
    lw x6, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 16(x4)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x4,16
    li     x5, MASK_XLEN(-116)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x14, 116(x2)
    # Check results:  mem[test_13_res+16] = 0x00000000
    lw x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")



    # Addresses for test results
    la x1, test_14_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x13, 120(x2)
    # Check results:  mem[test_14_res+0] = 0x00000000
    lw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x1,4
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x12, 0(x2)
    # Check results:  mem[test_14_res+4] = 0x00000000
    lw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x1
    addi    x2, x1,8
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x11, 64(x2)
    # Check results:  mem[test_14_res+8] = 0x00000001
    lw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000001)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x10, 0x2
    addi    x2, x1,12
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 32(x2)
    # Check results:  mem[test_14_res+12] = 0x00000002
    lw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000002)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x4
    addi    x2, x1,16
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 16(x2)
    # Check results:  mem[test_14_res+16] = 0x00000004
    lw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000004)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")



    # Addresses for test results
    la x1, test_15_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x8
    addi    x2, x1,0
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 8(x2)
    # Check results:  mem[test_15_res+0] = 0x00000008
    lw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000008)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x7, 0x10
    addi    x2, x1,4
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 4(x2)
    # Check results:  mem[test_15_res+4] = 0x00000010
    lw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000010)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x6, 0x20
    addi    x2, x1,8
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x6, 124(x2)
    # Check results:  mem[test_15_res+8] = 0x00000020
    lw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000020)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x5, 0x40
    addi    x2, x1,12
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x5, 60(x2)
    # Check results:  mem[test_15_res+12] = 0x00000040
    lw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000040)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x4, 0x80
    addi    x2, x1,16
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x4, 92(x2)
    # Check results:  mem[test_15_res+16] = 0x00000080
    lw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000080)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")



    # Addresses for test results
    la x4, test_16_res

    # Clear memory
    sw      x0, 0(x4)
    # Load values and compute offsets
    li      x3, 0x100
    addi    x2, x4,0
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x3, 108(x2)
    # Check results:  mem[test_16_res+0] = 0x00000100
    lw x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000100)

    # Clear memory
    sw      x0, 4(x4)
    # Load values and compute offsets
    li      x1, 0x200
    addi    x2, x4,4
    li     x5, MASK_XLEN(-116)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x1, 116(x2)
    # Check results:  mem[test_16_res+4] = 0x00000200
    lw x6, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000200)

    # Clear memory
    sw      x0, 8(x4)
    # Load values and compute offsets
    li      x1, 0x400
    addi    x2, x4,8
    li     x5, MASK_XLEN(-120)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x1, 120(x2)
    # Check results:  mem[test_16_res+8] = 0x00000400
    lw x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000400)

    # Clear memory
    sw      x0, 12(x4)
    # Load values and compute offsets
    li      x31, 0x800
    addi    x2, x4,12
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x31, 0(x2)
    # Check results:  mem[test_16_res+12] = 0x00000800
    lw x6, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000800)

    # Clear memory
    sw      x0, 16(x4)
    # Load values and compute offsets
    li      x30, 0x1000
    addi    x2, x4,16
    li     x5, MASK_XLEN(-64)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x30, 64(x2)
    # Check results:  mem[test_16_res+16] = 0x00001000
    lw x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00001000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")



    # Addresses for test results
    la x1, test_17_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x29, 0x2000
    addi    x2, x1,0
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x29, 32(x2)
    # Check results:  mem[test_17_res+0] = 0x00002000
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00002000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x28, 0x4000
    addi    x2, x1,4
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x28, 16(x2)
    # Check results:  mem[test_17_res+4] = 0x00004000
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00004000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x27, 0x8000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 8(x2)
    # Check results:  mem[test_17_res+8] = 0x00008000
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00008000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x26, 0x10000
    addi    x2, x1,12
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 4(x2)
    # Check results:  mem[test_17_res+12] = 0x00010000
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00010000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x25, 0x20000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 124(x2)
    # Check results:  mem[test_17_res+16] = 0x00020000
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00020000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")



    # Addresses for test results
    la x1, test_18_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x24, 0x40000
    addi    x2, x1,0
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 60(x2)
    # Check results:  mem[test_18_res+0] = 0x00040000
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00040000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x23, 0x80000
    addi    x2, x1,4
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 92(x2)
    # Check results:  mem[test_18_res+4] = 0x00080000
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00080000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0x100000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 108(x2)
    # Check results:  mem[test_18_res+8] = 0x00100000
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00100000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x21, 0x200000
    addi    x2, x1,12
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 116(x2)
    # Check results:  mem[test_18_res+12] = 0x00200000
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00200000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x20, 0x400000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x20, 120(x2)
    # Check results:  mem[test_18_res+16] = 0x00400000
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00400000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")



    # Addresses for test results
    la x3, test_19_res

    # Clear memory
    sw      x0, 0(x3)
    # Load values and compute offsets
    li      x19, 0x800000
    addi    x2, x3,0
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x19, 0(x2)
    # Check results:  mem[test_19_res+0] = 0x00800000
    lw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00800000)

    # Clear memory
    sw      x0, 4(x3)
    # Load values and compute offsets
    li      x18, 0x1000000
    addi    x2, x3,4
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x18, 64(x2)
    # Check results:  mem[test_19_res+4] = 0x01000000
    lw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x01000000)

    # Clear memory
    sw      x0, 8(x3)
    # Load values and compute offsets
    li      x17, 0x2000000
    addi    x2, x3,8
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x17, 32(x2)
    # Check results:  mem[test_19_res+8] = 0x02000000
    lw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x02000000)

    # Clear memory
    sw      x0, 12(x3)
    # Load values and compute offsets
    li      x16, 0x4000000
    addi    x2, x3,12
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x16, 16(x2)
    # Check results:  mem[test_19_res+12] = 0x04000000
    lw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x04000000)

    # Clear memory
    sw      x0, 16(x3)
    # Load values and compute offsets
    li      x15, 0x8000000
    addi    x2, x3,16
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x15, 8(x2)
    # Check results:  mem[test_19_res+16] = 0x08000000
    lw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x08000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")



    # Addresses for test results
    la x1, test_20_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x10000000
    addi    x2, x1,0
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x14, 4(x2)
    # Check results:  mem[test_20_res+0] = 0x10000000
    lw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x10000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x13, 0x20000000
    addi    x2, x1,4
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x13, 124(x2)
    # Check results:  mem[test_20_res+4] = 0x20000000
    lw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x20000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x40000000
    addi    x2, x1,8
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x12, 60(x2)
    # Check results:  mem[test_20_res+8] = 0x40000000
    lw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x40000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x11, 0x80000000
    addi    x2, x1,12
    li     x8, MASK_XLEN(-92)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x11, 92(x2)
    # Check results:  mem[test_20_res+12] = 0x80000000
    lw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x80000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,16
    li     x8, MASK_XLEN(-108)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x10, 108(x2)
    # Check results:  mem[test_20_res+16] = 0x00000000
    lw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")



    # Addresses for test results
    la x1, test_21_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0xfffffffe
    addi    x2, x1,0
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 116(x2)
    # Check results:  mem[test_21_res+0] = 0xfffffffe
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffffe)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x8, 0xfffffffd
    addi    x2, x1,4
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 120(x2)
    # Check results:  mem[test_21_res+4] = 0xfffffffd
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffffd)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0xfffffffb
    addi    x2, x1,8
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 0(x2)
    # Check results:  mem[test_21_res+8] = 0xfffffffb
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffffb)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x6, 0xfffffff7
    addi    x2, x1,12
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x6, 64(x2)
    # Check results:  mem[test_21_res+12] = 0xfffffff7
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffff7)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x5, 0xffffffef
    addi    x2, x1,16
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x5, 32(x2)
    # Check results:  mem[test_21_res+16] = 0xffffffef
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffffef)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")



    # Addresses for test results
    la x5, test_22_res

    # Clear memory
    sw      x0, 0(x5)
    # Load values and compute offsets
    li      x4, 0xffffffdf
    addi    x2, x5,0
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x4, 16(x2)
    # Check results:  mem[test_22_res+0] = 0xffffffdf
    lw x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xffffffdf)

    # Clear memory
    sw      x0, 4(x5)
    # Load values and compute offsets
    li      x3, 0xffffffbf
    addi    x2, x5,4
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x3, 8(x2)
    # Check results:  mem[test_22_res+4] = 0xffffffbf
    lw x7, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xffffffbf)

    # Clear memory
    sw      x0, 8(x5)
    # Load values and compute offsets
    li      x1, 0xffffff7f
    addi    x2, x5,8
    li     x6, MASK_XLEN(-4)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x1, 4(x2)
    # Check results:  mem[test_22_res+8] = 0xffffff7f
    lw x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xffffff7f)

    # Clear memory
    sw      x0, 12(x5)
    # Load values and compute offsets
    li      x1, 0xfffffeff
    addi    x2, x5,12
    li     x6, MASK_XLEN(-124)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x1, 124(x2)
    # Check results:  mem[test_22_res+12] = 0xfffffeff
    lw x7, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xfffffeff)

    # Clear memory
    sw      x0, 16(x5)
    # Load values and compute offsets
    li      x31, 0xfffffdff
    addi    x2, x5,16
    li     x6, MASK_XLEN(-60)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x31, 60(x2)
    # Check results:  mem[test_22_res+16] = 0xfffffdff
    lw x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xfffffdff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")



    # Addresses for test results
    la x1, test_23_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x30, 0xfffffbff
    addi    x2, x1,0
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x30, 92(x2)
    # Check results:  mem[test_23_res+0] = 0xfffffbff
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffbff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x29, 0xfffff7ff
    addi    x2, x1,4
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x29, 108(x2)
    # Check results:  mem[test_23_res+4] = 0xfffff7ff
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffff7ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0xffffefff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x28, 116(x2)
    # Check results:  mem[test_23_res+8] = 0xffffefff
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffefff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x27, 0xffffdfff
    addi    x2, x1,12
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 120(x2)
    # Check results:  mem[test_23_res+12] = 0xffffdfff
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffdfff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x26, 0xffffbfff
    addi    x2, x1,16
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 0(x2)
    # Check results:  mem[test_23_res+16] = 0xffffbfff
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffbfff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")



    # Addresses for test results
    la x1, test_24_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x25, 0xffff7fff
    addi    x2, x1,0
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 64(x2)
    # Check results:  mem[test_24_res+0] = 0xffff7fff
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffff7fff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x24, 0xfffeffff
    addi    x2, x1,4
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 32(x2)
    # Check results:  mem[test_24_res+4] = 0xfffeffff
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffeffff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x23, 0xfffdffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 16(x2)
    # Check results:  mem[test_24_res+8] = 0xfffdffff
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffdffff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x22, 0xfffbffff
    addi    x2, x1,12
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 8(x2)
    # Check results:  mem[test_24_res+12] = 0xfffbffff
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffbffff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x21, 0xfff7ffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 4(x2)
    # Check results:  mem[test_24_res+16] = 0xfff7ffff
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfff7ffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")



    # Addresses for test results
    la x3, test_25_res

    # Clear memory
    sw      x0, 0(x3)
    # Load values and compute offsets
    li      x20, 0xffefffff
    addi    x2, x3,0
    li     x4, MASK_XLEN(-124)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x20, 124(x2)
    # Check results:  mem[test_25_res+0] = 0xffefffff
    lw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffefffff)

    # Clear memory
    sw      x0, 4(x3)
    # Load values and compute offsets
    li      x19, 0xffdfffff
    addi    x2, x3,4
    li     x4, MASK_XLEN(-60)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x19, 60(x2)
    # Check results:  mem[test_25_res+4] = 0xffdfffff
    lw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffdfffff)

    # Clear memory
    sw      x0, 8(x3)
    # Load values and compute offsets
    li      x18, 0xffbfffff
    addi    x2, x3,8
    li     x4, MASK_XLEN(-92)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x18, 92(x2)
    # Check results:  mem[test_25_res+8] = 0xffbfffff
    lw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffbfffff)

    # Clear memory
    sw      x0, 12(x3)
    # Load values and compute offsets
    li      x17, 0xff7fffff
    addi    x2, x3,12
    li     x4, MASK_XLEN(-108)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x17, 108(x2)
    # Check results:  mem[test_25_res+12] = 0xff7fffff
    lw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xff7fffff)

    # Clear memory
    sw      x0, 16(x3)
    # Load values and compute offsets
    li      x16, 0xfeffffff
    addi    x2, x3,16
    li     x4, MASK_XLEN(-116)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x16, 116(x2)
    # Check results:  mem[test_25_res+16] = 0xfeffffff
    lw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xfeffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")



    # Addresses for test results
    la x1, test_26_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0xfdffffff
    addi    x2, x1,0
    li     x7, MASK_XLEN(-120)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x15, 120(x2)
    # Check results:  mem[test_26_res+0] = 0xfdffffff
    lw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xfdffffff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x14, 0xfbffffff
    addi    x2, x1,4
    li     x7, MASK_XLEN(0)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x14, 0(x2)
    # Check results:  mem[test_26_res+4] = 0xfbffffff
    lw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xfbffffff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0xf7ffffff
    addi    x2, x1,8
    li     x7, MASK_XLEN(-64)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x13, 64(x2)
    # Check results:  mem[test_26_res+8] = 0xf7ffffff
    lw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xf7ffffff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x12, 0xefffffff
    addi    x2, x1,12
    li     x7, MASK_XLEN(-32)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x12, 32(x2)
    # Check results:  mem[test_26_res+12] = 0xefffffff
    lw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xefffffff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0xdfffffff
    addi    x2, x1,16
    li     x7, MASK_XLEN(-16)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x11, 16(x2)
    # Check results:  mem[test_26_res+16] = 0xdfffffff
    lw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xdfffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")



    # Addresses for test results
    la x1, test_27_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0xbfffffff
    addi    x2, x1,0
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 8(x2)
    # Check results:  mem[test_27_res+0] = 0xbfffffff
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xbfffffff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x9, 0x7fffffff
    addi    x2, x1,4
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 4(x2)
    # Check results:  mem[test_27_res+4] = 0x7fffffff
    lw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x7fffffff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0xffffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 124(x2)
    # Check results:  mem[test_27_res+8] = 0xffffffff
    lw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffffff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x2, x1,12
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 60(x2)
    # Check results:  mem[test_27_res+12] = 0x00000000
    lw x4, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x0, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x0, 92(x2)
    # Check results:  mem[test_27_res+16] = 0
    lw x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")



    # Addresses for test results
    la x1, test_28_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x5, 108(x2)
    # Check results:  mem[test_28_res+0] = 0x00000000
    lw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

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

