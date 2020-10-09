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

RV_COMPLIANCE_RV64M

RV_COMPLIANCE_CODE_BEGIN


	RVTEST_IO_INIT
	RVTEST_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
	RVTEST_IO_WRITE_STR(x31, "Test Begin\n")

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test group 1\n")



    # Addresses for test results
    la x6, test_1_res

    # Clear memory
    sd      x0, 0(x6)
    # Load values and compute offsets
    li      x16, 0xffffffffffffffff
    addi    x2, x6,0
    li     x7, MASK_XLEN(-124)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x16, 124(x2)
    # Check results:  mem[test_1_res+0] = 0x00000000ffffffff
    ld x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x6)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x6,8
    li     x7, MASK_XLEN(-60)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x15, 60(x2)
    # Check results:  mem[test_1_res+8] = 0x0000000000000000
    ld x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x6)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x6,16
    li     x7, MASK_XLEN(-92)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x14, 92(x2)
    # Check results:  mem[test_1_res+16] = 0x0000000000000000
    ld x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x6)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x6,24
    li     x7, MASK_XLEN(-108)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x13, 108(x2)
    # Check results:  mem[test_1_res+24] = 0x0000000000000000
    ld x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x6)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x6,32
    li     x7, MASK_XLEN(-116)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x12, 116(x2)
    # Check results:  mem[test_1_res+32] = 0x0000000000000000
    ld x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")



    # Addresses for test results
    la x1, test_2_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x11, 120(x2)
    # Check results:  mem[test_2_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 0(x2)
    # Check results:  mem[test_2_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 64(x2)
    # Check results:  mem[test_2_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 32(x2)
    # Check results:  mem[test_2_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 16(x2)
    # Check results:  mem[test_2_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")



    # Addresses for test results
    la x7, test_3_res

    # Clear memory
    sd      x0, 0(x7)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x2, x7,0
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x6, 8(x2)
    # Check results:  mem[test_3_res+0] = 0x0000000000000000
    ld x9, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x7)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x2, x7,8
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x5, 4(x2)
    # Check results:  mem[test_3_res+8] = 0x0000000000000000
    ld x9, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x7)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x2, x7,16
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x4, 124(x2)
    # Check results:  mem[test_3_res+16] = 0x0000000000000000
    ld x9, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x7)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x7,24
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x3, 60(x2)
    # Check results:  mem[test_3_res+24] = 0x0000000000000000
    ld x9, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x7)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x7,32
    li     x8, MASK_XLEN(-92)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x1, 92(x2)
    # Check results:  mem[test_3_res+32] = 0x0000000000000000
    ld x9, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")



    # Addresses for test results
    la x3, test_4_res

    # Clear memory
    sd      x0, 0(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x3,0
    li     x4, MASK_XLEN(-108)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x1, 108(x2)
    # Check results:  mem[test_4_res+0] = 0x0000000000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(-116)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x31, 116(x2)
    # Check results:  mem[test_4_res+8] = 0x0000000000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x2, x3,16
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x30, 120(x2)
    # Check results:  mem[test_4_res+16] = 0x0000000000000000
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x2, x3,24
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x29, 0(x2)
    # Check results:  mem[test_4_res+24] = 0x0000000000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x2, x3,32
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x28, 64(x2)
    # Check results:  mem[test_4_res+32] = 0x0000000000000000
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")



    # Addresses for test results
    la x1, test_5_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 32(x2)
    # Check results:  mem[test_5_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 16(x2)
    # Check results:  mem[test_5_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 8(x2)
    # Check results:  mem[test_5_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 4(x2)
    # Check results:  mem[test_5_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 124(x2)
    # Check results:  mem[test_5_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")



    # Addresses for test results
    la x1, test_6_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 60(x2)
    # Check results:  mem[test_6_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 92(x2)
    # Check results:  mem[test_6_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x20, 108(x2)
    # Check results:  mem[test_6_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x19, 116(x2)
    # Check results:  mem[test_6_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x18, 120(x2)
    # Check results:  mem[test_6_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")



    # Addresses for test results
    la x5, test_7_res

    # Clear memory
    sd      x0, 0(x5)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x2, x5,0
    li     x6, MASK_XLEN(0)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x17, 0(x2)
    # Check results:  mem[test_7_res+0] = 0x0000000000000000
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x2, x5,8
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x16, 64(x2)
    # Check results:  mem[test_7_res+8] = 0x0000000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x5,16
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x15, 32(x2)
    # Check results:  mem[test_7_res+16] = 0x0000000000000000
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x5,24
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x14, 16(x2)
    # Check results:  mem[test_7_res+24] = 0x0000000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x5)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x5,32
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x13, 8(x2)
    # Check results:  mem[test_7_res+32] = 0x0000000000000000
    ld x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")



    # Addresses for test results
    la x1, test_8_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x12, 4(x2)
    # Check results:  mem[test_8_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x11, 124(x2)
    # Check results:  mem[test_8_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 60(x2)
    # Check results:  mem[test_8_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 92(x2)
    # Check results:  mem[test_8_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 108(x2)
    # Check results:  mem[test_8_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")



    # Addresses for test results
    la x1, test_9_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x2, x1,0
    li     x8, MASK_XLEN(-116)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x7, 116(x2)
    # Check results:  mem[test_9_res+0] = 0x0000000000000000
    ld x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x2, x1,8
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x6, 120(x2)
    # Check results:  mem[test_9_res+8] = 0x0000000000000000
    ld x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x2, x1,16
    li     x8, MASK_XLEN(0)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x5, 0(x2)
    # Check results:  mem[test_9_res+16] = 0x0000000000000000
    ld x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x2, x1,24
    li     x8, MASK_XLEN(-64)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x4, 64(x2)
    # Check results:  mem[test_9_res+24] = 0x0000000000000000
    ld x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x1,32
    li     x8, MASK_XLEN(-32)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x3, 32(x2)
    # Check results:  mem[test_9_res+32] = 0x0000000000000000
    ld x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")



    # Addresses for test results
    la x3, test_10_res

    # Clear memory
    sd      x0, 0(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x3,0
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x1, 16(x2)
    # Check results:  mem[test_10_res+0] = 0x0000000000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x1, 8(x2)
    # Check results:  mem[test_10_res+8] = 0x0000000000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x2, x3,16
    li     x4, MASK_XLEN(-4)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x31, 4(x2)
    # Check results:  mem[test_10_res+16] = 0x0000000000000000
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x2, x3,24
    li     x4, MASK_XLEN(-124)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x30, 124(x2)
    # Check results:  mem[test_10_res+24] = 0x0000000000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x2, x3,32
    li     x4, MASK_XLEN(-60)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x29, 60(x2)
    # Check results:  mem[test_10_res+32] = 0x0000000000000000
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")



    # Addresses for test results
    la x1, test_11_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x28, 92(x2)
    # Check results:  mem[test_11_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 108(x2)
    # Check results:  mem[test_11_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 116(x2)
    # Check results:  mem[test_11_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 120(x2)
    # Check results:  mem[test_11_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 0(x2)
    # Check results:  mem[test_11_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")



    # Addresses for test results
    la x1, test_12_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 64(x2)
    # Check results:  mem[test_12_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 32(x2)
    # Check results:  mem[test_12_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 16(x2)
    # Check results:  mem[test_12_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x20, 8(x2)
    # Check results:  mem[test_12_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x19, 4(x2)
    # Check results:  mem[test_12_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")



    # Addresses for test results
    la x4, test_13_res

    # Clear memory
    sd      x0, 0(x4)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x4,0
    li     x5, MASK_XLEN(-124)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x18, 124(x2)
    # Check results:  mem[test_13_res+0] = 0x0000000000000000
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x2, x4,8
    li     x5, MASK_XLEN(-60)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x17, 60(x2)
    # Check results:  mem[test_13_res+8] = 0x0000000000000000
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x2, x4,16
    li     x5, MASK_XLEN(-92)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x16, 92(x2)
    # Check results:  mem[test_13_res+16] = 0x0000000000000000
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x4,24
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x15, 108(x2)
    # Check results:  mem[test_13_res+24] = 0x0000000000000000
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x4,32
    li     x5, MASK_XLEN(-116)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x14, 116(x2)
    # Check results:  mem[test_13_res+32] = 0x0000000000000000
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")



    # Addresses for test results
    la x1, test_14_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x13, 120(x2)
    # Check results:  mem[test_14_res+0] = 0x0000000000000000
    ld x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x12, 0(x2)
    # Check results:  mem[test_14_res+8] = 0x0000000000000000
    ld x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x11, 64(x2)
    # Check results:  mem[test_14_res+16] = 0x0000000000000000
    ld x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 32(x2)
    # Check results:  mem[test_14_res+24] = 0x0000000000000000
    ld x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 16(x2)
    # Check results:  mem[test_14_res+32] = 0x0000000000000000
    ld x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")



    # Addresses for test results
    la x1, test_15_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 8(x2)
    # Check results:  mem[test_15_res+0] = 0x0000000000000000
    ld x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 4(x2)
    # Check results:  mem[test_15_res+8] = 0x0000000000000000
    ld x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x6, 124(x2)
    # Check results:  mem[test_15_res+16] = 0x0000000000000000
    ld x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x5, 60(x2)
    # Check results:  mem[test_15_res+24] = 0x0000000000000000
    ld x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x4, 92(x2)
    # Check results:  mem[test_15_res+32] = 0x0000000000000000
    ld x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")



    # Addresses for test results
    la x4, test_16_res

    # Clear memory
    sd      x0, 0(x4)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x4,0
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x3, 108(x2)
    # Check results:  mem[test_16_res+0] = 0x0000000000000000
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x4,8
    li     x5, MASK_XLEN(-116)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x1, 116(x2)
    # Check results:  mem[test_16_res+8] = 0x0000000000000000
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x4,16
    li     x5, MASK_XLEN(-120)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x1, 120(x2)
    # Check results:  mem[test_16_res+16] = 0x0000000000000000
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x2, x4,24
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x31, 0(x2)
    # Check results:  mem[test_16_res+24] = 0x0000000000000000
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x2, x4,32
    li     x5, MASK_XLEN(-64)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x30, 64(x2)
    # Check results:  mem[test_16_res+32] = 0x0000000000000000
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")



    # Addresses for test results
    la x1, test_17_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x29, 32(x2)
    # Check results:  mem[test_17_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x28, 16(x2)
    # Check results:  mem[test_17_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 8(x2)
    # Check results:  mem[test_17_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 4(x2)
    # Check results:  mem[test_17_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 124(x2)
    # Check results:  mem[test_17_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")



    # Addresses for test results
    la x1, test_18_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 60(x2)
    # Check results:  mem[test_18_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 92(x2)
    # Check results:  mem[test_18_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 108(x2)
    # Check results:  mem[test_18_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 116(x2)
    # Check results:  mem[test_18_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x20, 120(x2)
    # Check results:  mem[test_18_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")



    # Addresses for test results
    la x3, test_19_res

    # Clear memory
    sd      x0, 0(x3)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x2, x3,0
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x19, 0(x2)
    # Check results:  mem[test_19_res+0] = 0x0000000000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x18, 64(x2)
    # Check results:  mem[test_19_res+8] = 0x0000000000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x2, x3,16
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x17, 32(x2)
    # Check results:  mem[test_19_res+16] = 0x0000000000000000
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x2, x3,24
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x16, 16(x2)
    # Check results:  mem[test_19_res+24] = 0x0000000000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x3,32
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x15, 8(x2)
    # Check results:  mem[test_19_res+32] = 0x0000000000000000
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")



    # Addresses for test results
    la x1, test_20_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x1,0
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x14, 4(x2)
    # Check results:  mem[test_20_res+0] = 0x0000000000000000
    ld x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x1,8
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x13, 124(x2)
    # Check results:  mem[test_20_res+8] = 0x0000000000000000
    ld x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x1,16
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x12, 60(x2)
    # Check results:  mem[test_20_res+16] = 0x0000000000000000
    ld x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,24
    li     x8, MASK_XLEN(-92)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x11, 92(x2)
    # Check results:  mem[test_20_res+24] = 0x0000000000000000
    ld x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,32
    li     x8, MASK_XLEN(-108)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x10, 108(x2)
    # Check results:  mem[test_20_res+32] = 0x0000000000000000
    ld x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")



    # Addresses for test results
    la x1, test_21_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 116(x2)
    # Check results:  mem[test_21_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 120(x2)
    # Check results:  mem[test_21_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 0(x2)
    # Check results:  mem[test_21_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x6, 64(x2)
    # Check results:  mem[test_21_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x5, 32(x2)
    # Check results:  mem[test_21_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")



    # Addresses for test results
    la x5, test_22_res

    # Clear memory
    sd      x0, 0(x5)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x2, x5,0
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x4, 16(x2)
    # Check results:  mem[test_22_res+0] = 0x0000000000000000
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x5,8
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x3, 8(x2)
    # Check results:  mem[test_22_res+8] = 0x0000000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x5,16
    li     x6, MASK_XLEN(-4)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x1, 4(x2)
    # Check results:  mem[test_22_res+16] = 0x0000000000000000
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x5,24
    li     x6, MASK_XLEN(-124)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x1, 124(x2)
    # Check results:  mem[test_22_res+24] = 0x0000000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x5)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x2, x5,32
    li     x6, MASK_XLEN(-60)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x31, 60(x2)
    # Check results:  mem[test_22_res+32] = 0x0000000000000000
    ld x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")



    # Addresses for test results
    la x1, test_23_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x30, 92(x2)
    # Check results:  mem[test_23_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x29, 108(x2)
    # Check results:  mem[test_23_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x28, 116(x2)
    # Check results:  mem[test_23_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 120(x2)
    # Check results:  mem[test_23_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 0(x2)
    # Check results:  mem[test_23_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")



    # Addresses for test results
    la x1, test_24_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 64(x2)
    # Check results:  mem[test_24_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 32(x2)
    # Check results:  mem[test_24_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 16(x2)
    # Check results:  mem[test_24_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 8(x2)
    # Check results:  mem[test_24_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 4(x2)
    # Check results:  mem[test_24_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")



    # Addresses for test results
    la x3, test_25_res

    # Clear memory
    sd      x0, 0(x3)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x2, x3,0
    li     x4, MASK_XLEN(-124)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x20, 124(x2)
    # Check results:  mem[test_25_res+0] = 0x0000000000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(-60)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x19, 60(x2)
    # Check results:  mem[test_25_res+8] = 0x0000000000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x3,16
    li     x4, MASK_XLEN(-92)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x18, 92(x2)
    # Check results:  mem[test_25_res+16] = 0x0000000000000000
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x2, x3,24
    li     x4, MASK_XLEN(-108)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x17, 108(x2)
    # Check results:  mem[test_25_res+24] = 0x0000000000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x2, x3,32
    li     x4, MASK_XLEN(-116)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x16, 116(x2)
    # Check results:  mem[test_25_res+32] = 0x0000000000000000
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")



    # Addresses for test results
    la x1, test_26_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x1,0
    li     x7, MASK_XLEN(-120)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x15, 120(x2)
    # Check results:  mem[test_26_res+0] = 0x0000000000000000
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x1,8
    li     x7, MASK_XLEN(0)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x14, 0(x2)
    # Check results:  mem[test_26_res+8] = 0x0000000000000000
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x1,16
    li     x7, MASK_XLEN(-64)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x13, 64(x2)
    # Check results:  mem[test_26_res+16] = 0x0000000000000000
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x1,24
    li     x7, MASK_XLEN(-32)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x12, 32(x2)
    # Check results:  mem[test_26_res+24] = 0x0000000000000000
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,32
    li     x7, MASK_XLEN(-16)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x11, 16(x2)
    # Check results:  mem[test_26_res+32] = 0x0000000000000000
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")



    # Addresses for test results
    la x1, test_27_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,0
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 8(x2)
    # Check results:  mem[test_27_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x1
    addi    x2, x1,8
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 4(x2)
    # Check results:  mem[test_27_res+8] = 0x0000000000000001
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000001)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x2
    addi    x2, x1,16
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 124(x2)
    # Check results:  mem[test_27_res+16] = 0x0000000000000002
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000002)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x7, 0x4
    addi    x2, x1,24
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 60(x2)
    # Check results:  mem[test_27_res+24] = 0x0000000000000004
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000004)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x6, 0x8
    addi    x2, x1,32
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x6, 92(x2)
    # Check results:  mem[test_27_res+32] = 0x0000000000000008
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000008)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")



    # Addresses for test results
    la x6, test_28_res

    # Clear memory
    sd      x0, 0(x6)
    # Load values and compute offsets
    li      x5, 0x10
    addi    x2, x6,0
    li     x7, MASK_XLEN(-108)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x5, 108(x2)
    # Check results:  mem[test_28_res+0] = 0x0000000000000010
    ld x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000010)

    # Clear memory
    sd      x0, 8(x6)
    # Load values and compute offsets
    li      x4, 0x20
    addi    x2, x6,8
    li     x7, MASK_XLEN(-116)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x4, 116(x2)
    # Check results:  mem[test_28_res+8] = 0x0000000000000020
    ld x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000020)

    # Clear memory
    sd      x0, 16(x6)
    # Load values and compute offsets
    li      x3, 0x40
    addi    x2, x6,16
    li     x7, MASK_XLEN(-120)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x3, 120(x2)
    # Check results:  mem[test_28_res+16] = 0x0000000000000040
    ld x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000040)

    # Clear memory
    sd      x0, 24(x6)
    # Load values and compute offsets
    li      x1, 0x80
    addi    x2, x6,24
    li     x7, MASK_XLEN(0)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x1, 0(x2)
    # Check results:  mem[test_28_res+24] = 0x0000000000000080
    ld x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000080)

    # Clear memory
    sd      x0, 32(x6)
    # Load values and compute offsets
    li      x1, 0x100
    addi    x2, x6,32
    li     x7, MASK_XLEN(-64)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x1, 64(x2)
    # Check results:  mem[test_28_res+32] = 0x0000000000000100
    ld x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000100)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")



    # Addresses for test results
    la x1, test_29_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x31, 0x200
    addi    x2, x1,0
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x31, 32(x2)
    # Check results:  mem[test_29_res+0] = 0x0000000000000200
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000200)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x30, 0x400
    addi    x2, x1,8
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x30, 16(x2)
    # Check results:  mem[test_29_res+8] = 0x0000000000000400
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000400)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x29, 0x800
    addi    x2, x1,16
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x29, 8(x2)
    # Check results:  mem[test_29_res+16] = 0x0000000000000800
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000800)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x28, 0x1000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x28, 4(x2)
    # Check results:  mem[test_29_res+24] = 0x0000000000001000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000001000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x27, 0x2000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 124(x2)
    # Check results:  mem[test_29_res+32] = 0x0000000000002000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000002000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")



    # Addresses for test results
    la x1, test_30_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x26, 0x4000
    addi    x2, x1,0
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 60(x2)
    # Check results:  mem[test_30_res+0] = 0x0000000000004000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000004000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x25, 0x8000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 92(x2)
    # Check results:  mem[test_30_res+8] = 0x0000000000008000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000008000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x24, 0x10000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 108(x2)
    # Check results:  mem[test_30_res+16] = 0x0000000000010000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000010000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x23, 0x20000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 116(x2)
    # Check results:  mem[test_30_res+24] = 0x0000000000020000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000020000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x22, 0x40000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 120(x2)
    # Check results:  mem[test_30_res+32] = 0x0000000000040000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000040000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")



    # Addresses for test results
    la x1, test_31_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x21, 0x80000
    addi    x2, x1,0
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 0(x2)
    # Check results:  mem[test_31_res+0] = 0x0000000000080000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000080000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x20, 0x100000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x20, 64(x2)
    # Check results:  mem[test_31_res+8] = 0x0000000000100000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000100000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x19, 0x200000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x19, 32(x2)
    # Check results:  mem[test_31_res+16] = 0x0000000000200000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000200000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x18, 0x400000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x18, 16(x2)
    # Check results:  mem[test_31_res+24] = 0x0000000000400000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000400000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x17, 0x800000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x17, 8(x2)
    # Check results:  mem[test_31_res+32] = 0x0000000000800000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000800000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")



    # Addresses for test results
    la x6, test_32_res

    # Clear memory
    sd      x0, 0(x6)
    # Load values and compute offsets
    li      x16, 0x1000000
    addi    x2, x6,0
    li     x7, MASK_XLEN(-4)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x16, 4(x2)
    # Check results:  mem[test_32_res+0] = 0x0000000001000000
    ld x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000001000000)

    # Clear memory
    sd      x0, 8(x6)
    # Load values and compute offsets
    li      x15, 0x2000000
    addi    x2, x6,8
    li     x7, MASK_XLEN(-124)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x15, 124(x2)
    # Check results:  mem[test_32_res+8] = 0x0000000002000000
    ld x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000002000000)

    # Clear memory
    sd      x0, 16(x6)
    # Load values and compute offsets
    li      x14, 0x4000000
    addi    x2, x6,16
    li     x7, MASK_XLEN(-60)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x14, 60(x2)
    # Check results:  mem[test_32_res+16] = 0x0000000004000000
    ld x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000004000000)

    # Clear memory
    sd      x0, 24(x6)
    # Load values and compute offsets
    li      x13, 0x8000000
    addi    x2, x6,24
    li     x7, MASK_XLEN(-92)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x13, 92(x2)
    # Check results:  mem[test_32_res+24] = 0x0000000008000000
    ld x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000008000000)

    # Clear memory
    sd      x0, 32(x6)
    # Load values and compute offsets
    li      x12, 0x10000000
    addi    x2, x6,32
    li     x7, MASK_XLEN(-108)
    add    x2, x2, x7
    # Test Instruction 
    c.swsp      x12, 108(x2)
    # Check results:  mem[test_32_res+32] = 0x0000000010000000
    ld x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000010000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")



    # Addresses for test results
    la x1, test_33_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x20000000
    addi    x2, x1,0
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x11, 116(x2)
    # Check results:  mem[test_33_res+0] = 0x0000000020000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000020000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x40000000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 120(x2)
    # Check results:  mem[test_33_res+8] = 0x0000000040000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000040000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x80000000
    addi    x2, x1,16
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 0(x2)
    # Check results:  mem[test_33_res+16] = 0x0000000080000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000080000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x100000000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 64(x2)
    # Check results:  mem[test_33_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x7, 0x200000000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 32(x2)
    # Check results:  mem[test_33_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")



    # Addresses for test results
    la x7, test_34_res

    # Clear memory
    sd      x0, 0(x7)
    # Load values and compute offsets
    li      x6, 0x400000000
    addi    x2, x7,0
    li     x8, MASK_XLEN(-16)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x6, 16(x2)
    # Check results:  mem[test_34_res+0] = 0x0000000000000000
    ld x9, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x7)
    # Load values and compute offsets
    li      x5, 0x800000000
    addi    x2, x7,8
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x5, 8(x2)
    # Check results:  mem[test_34_res+8] = 0x0000000000000000
    ld x9, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x7)
    # Load values and compute offsets
    li      x4, 0x1000000000
    addi    x2, x7,16
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x4, 4(x2)
    # Check results:  mem[test_34_res+16] = 0x0000000000000000
    ld x9, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x7)
    # Load values and compute offsets
    li      x3, 0x2000000000
    addi    x2, x7,24
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x3, 124(x2)
    # Check results:  mem[test_34_res+24] = 0x0000000000000000
    ld x9, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x7)
    # Load values and compute offsets
    li      x1, 0x4000000000
    addi    x2, x7,32
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x1, 60(x2)
    # Check results:  mem[test_34_res+32] = 0x0000000000000000
    ld x9, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")



    # Addresses for test results
    la x3, test_35_res

    # Clear memory
    sd      x0, 0(x3)
    # Load values and compute offsets
    li      x1, 0x8000000000
    addi    x2, x3,0
    li     x4, MASK_XLEN(-92)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x1, 92(x2)
    # Check results:  mem[test_35_res+0] = 0x0000000000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x31, 0x10000000000
    addi    x2, x3,8
    li     x4, MASK_XLEN(-108)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x31, 108(x2)
    # Check results:  mem[test_35_res+8] = 0x0000000000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x30, 0x20000000000
    addi    x2, x3,16
    li     x4, MASK_XLEN(-116)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x30, 116(x2)
    # Check results:  mem[test_35_res+16] = 0x0000000000000000
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x29, 0x40000000000
    addi    x2, x3,24
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x29, 120(x2)
    # Check results:  mem[test_35_res+24] = 0x0000000000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x28, 0x80000000000
    addi    x2, x3,32
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x28, 0(x2)
    # Check results:  mem[test_35_res+32] = 0x0000000000000000
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")



    # Addresses for test results
    la x1, test_36_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x27, 0x100000000000
    addi    x2, x1,0
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 64(x2)
    # Check results:  mem[test_36_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x26, 0x200000000000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 32(x2)
    # Check results:  mem[test_36_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x25, 0x400000000000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 16(x2)
    # Check results:  mem[test_36_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x24, 0x800000000000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 8(x2)
    # Check results:  mem[test_36_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x23, 0x1000000000000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 4(x2)
    # Check results:  mem[test_36_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")



    # Addresses for test results
    la x1, test_37_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x22, 0x2000000000000
    addi    x2, x1,0
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 124(x2)
    # Check results:  mem[test_37_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x21, 0x4000000000000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 60(x2)
    # Check results:  mem[test_37_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x20, 0x8000000000000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x20, 92(x2)
    # Check results:  mem[test_37_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x19, 0x10000000000000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x19, 108(x2)
    # Check results:  mem[test_37_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x18, 0x20000000000000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x18, 116(x2)
    # Check results:  mem[test_37_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")



    # Addresses for test results
    la x5, test_38_res

    # Clear memory
    sd      x0, 0(x5)
    # Load values and compute offsets
    li      x17, 0x40000000000000
    addi    x2, x5,0
    li     x6, MASK_XLEN(-120)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x17, 120(x2)
    # Check results:  mem[test_38_res+0] = 0x0000000000000000
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x16, 0x80000000000000
    addi    x2, x5,8
    li     x6, MASK_XLEN(0)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x16, 0(x2)
    # Check results:  mem[test_38_res+8] = 0x0000000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x15, 0x100000000000000
    addi    x2, x5,16
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x15, 64(x2)
    # Check results:  mem[test_38_res+16] = 0x0000000000000000
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x14, 0x200000000000000
    addi    x2, x5,24
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x14, 32(x2)
    # Check results:  mem[test_38_res+24] = 0x0000000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x5)
    # Load values and compute offsets
    li      x13, 0x400000000000000
    addi    x2, x5,32
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x13, 16(x2)
    # Check results:  mem[test_38_res+32] = 0x0000000000000000
    ld x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")



    # Addresses for test results
    la x1, test_39_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x800000000000000
    addi    x2, x1,0
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x12, 8(x2)
    # Check results:  mem[test_39_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x1000000000000000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x11, 4(x2)
    # Check results:  mem[test_39_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x2000000000000000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 124(x2)
    # Check results:  mem[test_39_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x4000000000000000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 60(x2)
    # Check results:  mem[test_39_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x8000000000000000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 92(x2)
    # Check results:  mem[test_39_res+32] = 0x0000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")



    # Addresses for test results
    la x1, test_40_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x2, x1,0
    li     x8, MASK_XLEN(-108)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x7, 108(x2)
    # Check results:  mem[test_40_res+0] = 0x0000000000000000
    ld x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x6, 0xfffffffffffffffe
    addi    x2, x1,8
    li     x8, MASK_XLEN(-116)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x6, 116(x2)
    # Check results:  mem[test_40_res+8] = 0x00000000fffffffe
    ld x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000fffffffe)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x5, 0xfffffffffffffffd
    addi    x2, x1,16
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x5, 120(x2)
    # Check results:  mem[test_40_res+16] = 0x00000000fffffffd
    ld x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000fffffffd)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x4, 0xfffffffffffffffb
    addi    x2, x1,24
    li     x8, MASK_XLEN(0)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x4, 0(x2)
    # Check results:  mem[test_40_res+24] = 0x00000000fffffffb
    ld x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000fffffffb)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x3, 0xfffffffffffffff7
    addi    x2, x1,32
    li     x8, MASK_XLEN(-64)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x3, 64(x2)
    # Check results:  mem[test_40_res+32] = 0x00000000fffffff7
    ld x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000fffffff7)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")



    # Addresses for test results
    la x3, test_41_res

    # Clear memory
    sd      x0, 0(x3)
    # Load values and compute offsets
    li      x1, 0xffffffffffffffef
    addi    x2, x3,0
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x1, 32(x2)
    # Check results:  mem[test_41_res+0] = 0x00000000ffffffef
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000ffffffef)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x1, 0xffffffffffffffdf
    addi    x2, x3,8
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x1, 16(x2)
    # Check results:  mem[test_41_res+8] = 0x00000000ffffffdf
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000ffffffdf)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x31, 0xffffffffffffffbf
    addi    x2, x3,16
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x31, 8(x2)
    # Check results:  mem[test_41_res+16] = 0x00000000ffffffbf
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000ffffffbf)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x30, 0xffffffffffffff7f
    addi    x2, x3,24
    li     x4, MASK_XLEN(-4)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x30, 4(x2)
    # Check results:  mem[test_41_res+24] = 0x00000000ffffff7f
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000ffffff7f)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x29, 0xfffffffffffffeff
    addi    x2, x3,32
    li     x4, MASK_XLEN(-124)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x29, 124(x2)
    # Check results:  mem[test_41_res+32] = 0x00000000fffffeff
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000fffffeff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")



    # Addresses for test results
    la x1, test_42_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x28, 0xfffffffffffffdff
    addi    x2, x1,0
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x28, 60(x2)
    # Check results:  mem[test_42_res+0] = 0x00000000fffffdff
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000fffffdff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x27, 0xfffffffffffffbff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 92(x2)
    # Check results:  mem[test_42_res+8] = 0x00000000fffffbff
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000fffffbff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x26, 0xfffffffffffff7ff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 108(x2)
    # Check results:  mem[test_42_res+16] = 0x00000000fffff7ff
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000fffff7ff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x25, 0xffffffffffffefff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 116(x2)
    # Check results:  mem[test_42_res+24] = 0x00000000ffffefff
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffefff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x24, 0xffffffffffffdfff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 120(x2)
    # Check results:  mem[test_42_res+32] = 0x00000000ffffdfff
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffdfff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")



    # Addresses for test results
    la x1, test_43_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x23, 0xffffffffffffbfff
    addi    x2, x1,0
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 0(x2)
    # Check results:  mem[test_43_res+0] = 0x00000000ffffbfff
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffbfff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0xffffffffffff7fff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 64(x2)
    # Check results:  mem[test_43_res+8] = 0x00000000ffff7fff
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffff7fff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x21, 0xfffffffffffeffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 32(x2)
    # Check results:  mem[test_43_res+16] = 0x00000000fffeffff
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000fffeffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x20, 0xfffffffffffdffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x20, 16(x2)
    # Check results:  mem[test_43_res+24] = 0x00000000fffdffff
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000fffdffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x19, 0xfffffffffffbffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x19, 8(x2)
    # Check results:  mem[test_43_res+32] = 0x00000000fffbffff
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000fffbffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")



    # Addresses for test results
    la x4, test_44_res

    # Clear memory
    sd      x0, 0(x4)
    # Load values and compute offsets
    li      x18, 0xfffffffffff7ffff
    addi    x2, x4,0
    li     x5, MASK_XLEN(-4)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x18, 4(x2)
    # Check results:  mem[test_44_res+0] = 0x00000000fff7ffff
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000fff7ffff)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x17, 0xffffffffffefffff
    addi    x2, x4,8
    li     x5, MASK_XLEN(-124)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x17, 124(x2)
    # Check results:  mem[test_44_res+8] = 0x00000000ffefffff
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000ffefffff)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x16, 0xffffffffffdfffff
    addi    x2, x4,16
    li     x5, MASK_XLEN(-60)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x16, 60(x2)
    # Check results:  mem[test_44_res+16] = 0x00000000ffdfffff
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000ffdfffff)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x15, 0xffffffffffbfffff
    addi    x2, x4,24
    li     x5, MASK_XLEN(-92)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x15, 92(x2)
    # Check results:  mem[test_44_res+24] = 0x00000000ffbfffff
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000ffbfffff)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x14, 0xffffffffff7fffff
    addi    x2, x4,32
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x14, 108(x2)
    # Check results:  mem[test_44_res+32] = 0x00000000ff7fffff
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000ff7fffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")



    # Addresses for test results
    la x1, test_45_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0xfffffffffeffffff
    addi    x2, x1,0
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x13, 116(x2)
    # Check results:  mem[test_45_res+0] = 0x00000000feffffff
    ld x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000feffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0xfffffffffdffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x12, 120(x2)
    # Check results:  mem[test_45_res+8] = 0x00000000fdffffff
    ld x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000fdffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0xfffffffffbffffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x11, 0(x2)
    # Check results:  mem[test_45_res+16] = 0x00000000fbffffff
    ld x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000fbffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0xfffffffff7ffffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x10, 64(x2)
    # Check results:  mem[test_45_res+24] = 0x00000000f7ffffff
    ld x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000f7ffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0xffffffffefffffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 32(x2)
    # Check results:  mem[test_45_res+32] = 0x00000000efffffff
    ld x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000efffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")



    # Addresses for test results
    la x1, test_46_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0xffffffffdfffffff
    addi    x2, x1,0
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 16(x2)
    # Check results:  mem[test_46_res+0] = 0x00000000dfffffff
    ld x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000dfffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0xffffffffbfffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 8(x2)
    # Check results:  mem[test_46_res+8] = 0x00000000bfffffff
    ld x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000bfffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x6, 0xffffffff7fffffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x6, 4(x2)
    # Check results:  mem[test_46_res+16] = 0x000000007fffffff
    ld x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x000000007fffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x5, 0xfffffffeffffffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x5, 124(x2)
    # Check results:  mem[test_46_res+24] = 0x00000000ffffffff
    ld x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x4, 0xfffffffdffffffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x4, 60(x2)
    # Check results:  mem[test_46_res+32] = 0x00000000ffffffff
    ld x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")



    # Addresses for test results
    la x4, test_47_res

    # Clear memory
    sd      x0, 0(x4)
    # Load values and compute offsets
    li      x3, 0xfffffffbffffffff
    addi    x2, x4,0
    li     x5, MASK_XLEN(-92)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x3, 92(x2)
    # Check results:  mem[test_47_res+0] = 0x00000000ffffffff
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x1, 0xfffffff7ffffffff
    addi    x2, x4,8
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x1, 108(x2)
    # Check results:  mem[test_47_res+8] = 0x00000000ffffffff
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x1, 0xffffffefffffffff
    addi    x2, x4,16
    li     x5, MASK_XLEN(-116)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x1, 116(x2)
    # Check results:  mem[test_47_res+16] = 0x00000000ffffffff
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x31, 0xffffffdfffffffff
    addi    x2, x4,24
    li     x5, MASK_XLEN(-120)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x31, 120(x2)
    # Check results:  mem[test_47_res+24] = 0x00000000ffffffff
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x30, 0xffffffbfffffffff
    addi    x2, x4,32
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    # Test Instruction 
    c.swsp      x30, 0(x2)
    # Check results:  mem[test_47_res+32] = 0x00000000ffffffff
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")



    # Addresses for test results
    la x1, test_48_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x29, 0xffffff7fffffffff
    addi    x2, x1,0
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x29, 64(x2)
    # Check results:  mem[test_48_res+0] = 0x00000000ffffffff
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0xfffffeffffffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x28, 32(x2)
    # Check results:  mem[test_48_res+8] = 0x00000000ffffffff
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x27, 0xfffffdffffffffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x27, 16(x2)
    # Check results:  mem[test_48_res+16] = 0x00000000ffffffff
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x26, 0xfffffbffffffffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x26, 8(x2)
    # Check results:  mem[test_48_res+24] = 0x00000000ffffffff
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x25, 0xfffff7ffffffffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x25, 4(x2)
    # Check results:  mem[test_48_res+32] = 0x00000000ffffffff
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")



    # Addresses for test results
    la x1, test_49_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x24, 0xffffefffffffffff
    addi    x2, x1,0
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x24, 124(x2)
    # Check results:  mem[test_49_res+0] = 0x00000000ffffffff
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x23, 0xffffdfffffffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x23, 60(x2)
    # Check results:  mem[test_49_res+8] = 0x00000000ffffffff
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x22, 0xffffbfffffffffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x22, 92(x2)
    # Check results:  mem[test_49_res+16] = 0x00000000ffffffff
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x21, 0xffff7fffffffffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x21, 108(x2)
    # Check results:  mem[test_49_res+24] = 0x00000000ffffffff
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x20, 0xfffeffffffffffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x20, 116(x2)
    # Check results:  mem[test_49_res+32] = 0x00000000ffffffff
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")



    # Addresses for test results
    la x3, test_50_res

    # Clear memory
    sd      x0, 0(x3)
    # Load values and compute offsets
    li      x19, 0xfffdffffffffffff
    addi    x2, x3,0
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x19, 120(x2)
    # Check results:  mem[test_50_res+0] = 0x00000000ffffffff
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x18, 0xfffbffffffffffff
    addi    x2, x3,8
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x18, 0(x2)
    # Check results:  mem[test_50_res+8] = 0x00000000ffffffff
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x17, 0xfff7ffffffffffff
    addi    x2, x3,16
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x17, 64(x2)
    # Check results:  mem[test_50_res+16] = 0x00000000ffffffff
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x16, 0xffefffffffffffff
    addi    x2, x3,24
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x16, 32(x2)
    # Check results:  mem[test_50_res+24] = 0x00000000ffffffff
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x15, 0xffdfffffffffffff
    addi    x2, x3,32
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    # Test Instruction 
    c.swsp      x15, 16(x2)
    # Check results:  mem[test_50_res+32] = 0x00000000ffffffff
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")



    # Addresses for test results
    la x1, test_51_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0xffbfffffffffffff
    addi    x2, x1,0
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x14, 8(x2)
    # Check results:  mem[test_51_res+0] = 0x00000000ffffffff
    ld x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0xff7fffffffffffff
    addi    x2, x1,8
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x13, 4(x2)
    # Check results:  mem[test_51_res+8] = 0x00000000ffffffff
    ld x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0xfeffffffffffffff
    addi    x2, x1,16
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x12, 124(x2)
    # Check results:  mem[test_51_res+16] = 0x00000000ffffffff
    ld x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0xfdffffffffffffff
    addi    x2, x1,24
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x11, 60(x2)
    # Check results:  mem[test_51_res+24] = 0x00000000ffffffff
    ld x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0xfbffffffffffffff
    addi    x2, x1,32
    li     x8, MASK_XLEN(-92)
    add    x2, x2, x8
    # Test Instruction 
    c.swsp      x10, 92(x2)
    # Check results:  mem[test_51_res+32] = 0x00000000ffffffff
    ld x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")



    # Addresses for test results
    la x1, test_52_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0xf7ffffffffffffff
    addi    x2, x1,0
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x9, 108(x2)
    # Check results:  mem[test_52_res+0] = 0x00000000ffffffff
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0xefffffffffffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x8, 116(x2)
    # Check results:  mem[test_52_res+8] = 0x00000000ffffffff
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x7, 0xdfffffffffffffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x7, 120(x2)
    # Check results:  mem[test_52_res+16] = 0x00000000ffffffff
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x6, 0xbfffffffffffffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x6, 0(x2)
    # Check results:  mem[test_52_res+24] = 0x00000000ffffffff
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x5, 0x7fffffffffffffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.swsp      x5, 64(x2)
    # Check results:  mem[test_52_res+32] = 0x00000000ffffffff
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000ffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")



    # Addresses for test results
    la x5, test_53_res

    # Clear memory
    sd      x0, 0(x5)
    # Load values and compute offsets
    li      x4, 0xffffffffffffffff
    addi    x2, x5,0
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x4, 32(x2)
    # Check results:  mem[test_53_res+0] = 0x00000000ffffffff
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000ffffffff)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x5,8
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x3, 16(x2)
    # Check results:  mem[test_53_res+8] = 0x0000000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x0, 0x0
    addi    x2, x5,16
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x0, 8(x2)
    # Check results:  mem[test_53_res+16] = 0
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x5,24
    li     x6, MASK_XLEN(-4)
    add    x2, x2, x6
    # Test Instruction 
    c.swsp      x1, 4(x2)
    # Check results:  mem[test_53_res+24] = 0x0000000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

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

