# RISC-V Compliance Test I-C-SDSP-01
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
# Description: Testing instruction 'c.sdsp'.

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
    li     x7, MASK_XLEN(-248)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x16, 248(x2)
    # Check results:  mem[test_1_res+0] = 0xffffffffffffffff
    ld x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xffffffffffffffff)

    # Clear memory
    sd      x0, 8(x6)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x6,8
    li     x7, MASK_XLEN(-120)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x15, 120(x2)
    # Check results:  mem[test_1_res+8] = 0x0000000000000000
    ld x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x6)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x6,16
    li     x7, MASK_XLEN(-184)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x14, 184(x2)
    # Check results:  mem[test_1_res+16] = 0x0000000000000000
    ld x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x6)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x6,24
    li     x7, MASK_XLEN(-216)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x13, 216(x2)
    # Check results:  mem[test_1_res+24] = 0x0000000000000000
    ld x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x6)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x6,32
    li     x7, MASK_XLEN(-232)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x12, 232(x2)
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
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x11, 240(x2)
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
    c.sdsp      x10, 0(x2)
    # Check results:  mem[test_2_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x9, 128(x2)
    # Check results:  mem[test_2_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x8, 64(x2)
    # Check results:  mem[test_2_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x7, 32(x2)
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
    li     x8, MASK_XLEN(-16)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x6, 16(x2)
    # Check results:  mem[test_3_res+0] = 0x0000000000000000
    ld x9, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x7)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x2, x7,8
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x5, 8(x2)
    # Check results:  mem[test_3_res+8] = 0x0000000000000000
    ld x9, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x7)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x2, x7,16
    li     x8, MASK_XLEN(-248)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x4, 248(x2)
    # Check results:  mem[test_3_res+16] = 0x0000000000000000
    ld x9, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x7)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x7,24
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x3, 120(x2)
    # Check results:  mem[test_3_res+24] = 0x0000000000000000
    ld x9, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x7)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x7,32
    li     x8, MASK_XLEN(-184)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x1, 184(x2)
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
    li     x4, MASK_XLEN(-216)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x1, 216(x2)
    # Check results:  mem[test_4_res+0] = 0x0000000000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(-232)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x31, 232(x2)
    # Check results:  mem[test_4_res+8] = 0x0000000000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x2, x3,16
    li     x4, MASK_XLEN(-240)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x30, 240(x2)
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
    c.sdsp      x29, 0(x2)
    # Check results:  mem[test_4_res+24] = 0x0000000000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x2, x3,32
    li     x4, MASK_XLEN(-128)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x28, 128(x2)
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
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x27, 64(x2)
    # Check results:  mem[test_5_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x26, 32(x2)
    # Check results:  mem[test_5_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x25, 16(x2)
    # Check results:  mem[test_5_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x24, 8(x2)
    # Check results:  mem[test_5_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x23, 248(x2)
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
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x22, 120(x2)
    # Check results:  mem[test_6_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x21, 184(x2)
    # Check results:  mem[test_6_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x20, 216(x2)
    # Check results:  mem[test_6_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x19, 232(x2)
    # Check results:  mem[test_6_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x18, 240(x2)
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
    c.sdsp      x17, 0(x2)
    # Check results:  mem[test_7_res+0] = 0x0000000000000000
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x2, x5,8
    li     x6, MASK_XLEN(-128)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x16, 128(x2)
    # Check results:  mem[test_7_res+8] = 0x0000000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x5,16
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x15, 64(x2)
    # Check results:  mem[test_7_res+16] = 0x0000000000000000
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x5,24
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x14, 32(x2)
    # Check results:  mem[test_7_res+24] = 0x0000000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x5)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x5,32
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x13, 16(x2)
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
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x12, 8(x2)
    # Check results:  mem[test_8_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x11, 248(x2)
    # Check results:  mem[test_8_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x10, 120(x2)
    # Check results:  mem[test_8_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x9, 184(x2)
    # Check results:  mem[test_8_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x8, 216(x2)
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
    li     x8, MASK_XLEN(-232)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x7, 232(x2)
    # Check results:  mem[test_9_res+0] = 0x0000000000000000
    ld x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x2, x1,8
    li     x8, MASK_XLEN(-240)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x6, 240(x2)
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
    c.sdsp      x5, 0(x2)
    # Check results:  mem[test_9_res+16] = 0x0000000000000000
    ld x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x2, x1,24
    li     x8, MASK_XLEN(-128)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x4, 128(x2)
    # Check results:  mem[test_9_res+24] = 0x0000000000000000
    ld x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x1,32
    li     x8, MASK_XLEN(-64)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x3, 64(x2)
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
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x1, 32(x2)
    # Check results:  mem[test_10_res+0] = 0x0000000000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x1, 16(x2)
    # Check results:  mem[test_10_res+8] = 0x0000000000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x2, x3,16
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x31, 8(x2)
    # Check results:  mem[test_10_res+16] = 0x0000000000000000
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x2, x3,24
    li     x4, MASK_XLEN(-248)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x30, 248(x2)
    # Check results:  mem[test_10_res+24] = 0x0000000000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x2, x3,32
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x29, 120(x2)
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
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x28, 184(x2)
    # Check results:  mem[test_11_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x27, 216(x2)
    # Check results:  mem[test_11_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x26, 232(x2)
    # Check results:  mem[test_11_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x25, 240(x2)
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
    c.sdsp      x24, 0(x2)
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
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x23, 128(x2)
    # Check results:  mem[test_12_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x22, 64(x2)
    # Check results:  mem[test_12_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x21, 32(x2)
    # Check results:  mem[test_12_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x20, 16(x2)
    # Check results:  mem[test_12_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x19, 8(x2)
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
    li     x5, MASK_XLEN(-248)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x18, 248(x2)
    # Check results:  mem[test_13_res+0] = 0x0000000000000000
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x2, x4,8
    li     x5, MASK_XLEN(-120)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x17, 120(x2)
    # Check results:  mem[test_13_res+8] = 0x0000000000000000
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x2, x4,16
    li     x5, MASK_XLEN(-184)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x16, 184(x2)
    # Check results:  mem[test_13_res+16] = 0x0000000000000000
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x4,24
    li     x5, MASK_XLEN(-216)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x15, 216(x2)
    # Check results:  mem[test_13_res+24] = 0x0000000000000000
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x2, x4,32
    li     x5, MASK_XLEN(-232)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x14, 232(x2)
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
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x13, 240(x2)
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
    c.sdsp      x12, 0(x2)
    # Check results:  mem[test_14_res+8] = 0x0000000000000000
    ld x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x11, 128(x2)
    # Check results:  mem[test_14_res+16] = 0x0000000000000000
    ld x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x10, 64(x2)
    # Check results:  mem[test_14_res+24] = 0x0000000000000000
    ld x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x9, 32(x2)
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
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x8, 16(x2)
    # Check results:  mem[test_15_res+0] = 0x0000000000000000
    ld x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x7, 8(x2)
    # Check results:  mem[test_15_res+8] = 0x0000000000000000
    ld x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x6, 248(x2)
    # Check results:  mem[test_15_res+16] = 0x0000000000000000
    ld x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x5, 120(x2)
    # Check results:  mem[test_15_res+24] = 0x0000000000000000
    ld x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x4, 184(x2)
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
    li     x5, MASK_XLEN(-216)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x3, 216(x2)
    # Check results:  mem[test_16_res+0] = 0x0000000000000000
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x4,8
    li     x5, MASK_XLEN(-232)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x1, 232(x2)
    # Check results:  mem[test_16_res+8] = 0x0000000000000000
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x4,16
    li     x5, MASK_XLEN(-240)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x1, 240(x2)
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
    c.sdsp      x31, 0(x2)
    # Check results:  mem[test_16_res+24] = 0x0000000000000000
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x2, x4,32
    li     x5, MASK_XLEN(-128)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x30, 128(x2)
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
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x29, 64(x2)
    # Check results:  mem[test_17_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x28, 32(x2)
    # Check results:  mem[test_17_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x27, 16(x2)
    # Check results:  mem[test_17_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x26, 8(x2)
    # Check results:  mem[test_17_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x25, 248(x2)
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
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x24, 120(x2)
    # Check results:  mem[test_18_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x23, 184(x2)
    # Check results:  mem[test_18_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x22, 216(x2)
    # Check results:  mem[test_18_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x21, 232(x2)
    # Check results:  mem[test_18_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x20, 240(x2)
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
    c.sdsp      x19, 0(x2)
    # Check results:  mem[test_19_res+0] = 0x0000000000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(-128)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x18, 128(x2)
    # Check results:  mem[test_19_res+8] = 0x0000000000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x2, x3,16
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x17, 64(x2)
    # Check results:  mem[test_19_res+16] = 0x0000000000000000
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x2, x3,24
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x16, 32(x2)
    # Check results:  mem[test_19_res+24] = 0x0000000000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x2, x3,32
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x15, 16(x2)
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
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x14, 8(x2)
    # Check results:  mem[test_20_res+0] = 0x0000000000000000
    ld x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x1,8
    li     x8, MASK_XLEN(-248)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x13, 248(x2)
    # Check results:  mem[test_20_res+8] = 0x0000000000000000
    ld x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x1,16
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x12, 120(x2)
    # Check results:  mem[test_20_res+16] = 0x0000000000000000
    ld x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,24
    li     x8, MASK_XLEN(-184)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x11, 184(x2)
    # Check results:  mem[test_20_res+24] = 0x0000000000000000
    ld x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x2, x1,32
    li     x8, MASK_XLEN(-216)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x10, 216(x2)
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
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x9, 232(x2)
    # Check results:  mem[test_21_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x8, 240(x2)
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
    c.sdsp      x7, 0(x2)
    # Check results:  mem[test_21_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x6, 128(x2)
    # Check results:  mem[test_21_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x5, 64(x2)
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
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x4, 32(x2)
    # Check results:  mem[test_22_res+0] = 0x0000000000000000
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x5,8
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x3, 16(x2)
    # Check results:  mem[test_22_res+8] = 0x0000000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x5,16
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x1, 8(x2)
    # Check results:  mem[test_22_res+16] = 0x0000000000000000
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x5,24
    li     x6, MASK_XLEN(-248)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x1, 248(x2)
    # Check results:  mem[test_22_res+24] = 0x0000000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x5)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x2, x5,32
    li     x6, MASK_XLEN(-120)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x31, 120(x2)
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
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x30, 184(x2)
    # Check results:  mem[test_23_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x29, 216(x2)
    # Check results:  mem[test_23_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x28, 232(x2)
    # Check results:  mem[test_23_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x27, 240(x2)
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
    c.sdsp      x26, 0(x2)
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
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x25, 128(x2)
    # Check results:  mem[test_24_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x24, 64(x2)
    # Check results:  mem[test_24_res+8] = 0x0000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x2, x1,16
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x23, 32(x2)
    # Check results:  mem[test_24_res+16] = 0x0000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x2, x1,24
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x22, 16(x2)
    # Check results:  mem[test_24_res+24] = 0x0000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x2, x1,32
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x21, 8(x2)
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
    li     x4, MASK_XLEN(-248)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x20, 248(x2)
    # Check results:  mem[test_25_res+0] = 0x0000000000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x19, 120(x2)
    # Check results:  mem[test_25_res+8] = 0x0000000000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x3,16
    li     x4, MASK_XLEN(-184)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x18, 184(x2)
    # Check results:  mem[test_25_res+16] = 0x0000000000000000
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x2, x3,24
    li     x4, MASK_XLEN(-216)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x17, 216(x2)
    # Check results:  mem[test_25_res+24] = 0x0000000000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x2, x3,32
    li     x4, MASK_XLEN(-232)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x16, 232(x2)
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
    li     x7, MASK_XLEN(-240)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x15, 240(x2)
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
    c.sdsp      x14, 0(x2)
    # Check results:  mem[test_26_res+8] = 0x0000000000000000
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x2, x1,16
    li     x7, MASK_XLEN(-128)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x13, 128(x2)
    # Check results:  mem[test_26_res+16] = 0x0000000000000000
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x2, x1,24
    li     x7, MASK_XLEN(-64)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x12, 64(x2)
    # Check results:  mem[test_26_res+24] = 0x0000000000000000
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x2, x1,32
    li     x7, MASK_XLEN(-32)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x11, 32(x2)
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
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x10, 16(x2)
    # Check results:  mem[test_27_res+0] = 0x0000000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x1
    addi    x2, x1,8
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x9, 8(x2)
    # Check results:  mem[test_27_res+8] = 0x0000000000000001
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000001)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x2
    addi    x2, x1,16
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x8, 248(x2)
    # Check results:  mem[test_27_res+16] = 0x0000000000000002
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000002)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x7, 0x4
    addi    x2, x1,24
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x7, 120(x2)
    # Check results:  mem[test_27_res+24] = 0x0000000000000004
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000004)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x6, 0x8
    addi    x2, x1,32
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x6, 184(x2)
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
    li     x7, MASK_XLEN(-216)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x5, 216(x2)
    # Check results:  mem[test_28_res+0] = 0x0000000000000010
    ld x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000010)

    # Clear memory
    sd      x0, 8(x6)
    # Load values and compute offsets
    li      x4, 0x20
    addi    x2, x6,8
    li     x7, MASK_XLEN(-232)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x4, 232(x2)
    # Check results:  mem[test_28_res+8] = 0x0000000000000020
    ld x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000020)

    # Clear memory
    sd      x0, 16(x6)
    # Load values and compute offsets
    li      x3, 0x40
    addi    x2, x6,16
    li     x7, MASK_XLEN(-240)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x3, 240(x2)
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
    c.sdsp      x1, 0(x2)
    # Check results:  mem[test_28_res+24] = 0x0000000000000080
    ld x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000080)

    # Clear memory
    sd      x0, 32(x6)
    # Load values and compute offsets
    li      x1, 0x100
    addi    x2, x6,32
    li     x7, MASK_XLEN(-128)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x1, 128(x2)
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
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x31, 64(x2)
    # Check results:  mem[test_29_res+0] = 0x0000000000000200
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000200)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x30, 0x400
    addi    x2, x1,8
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x30, 32(x2)
    # Check results:  mem[test_29_res+8] = 0x0000000000000400
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000400)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x29, 0x800
    addi    x2, x1,16
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x29, 16(x2)
    # Check results:  mem[test_29_res+16] = 0x0000000000000800
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000800)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x28, 0x1000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x28, 8(x2)
    # Check results:  mem[test_29_res+24] = 0x0000000000001000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000001000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x27, 0x2000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x27, 248(x2)
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
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x26, 120(x2)
    # Check results:  mem[test_30_res+0] = 0x0000000000004000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000004000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x25, 0x8000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x25, 184(x2)
    # Check results:  mem[test_30_res+8] = 0x0000000000008000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000008000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x24, 0x10000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x24, 216(x2)
    # Check results:  mem[test_30_res+16] = 0x0000000000010000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000010000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x23, 0x20000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x23, 232(x2)
    # Check results:  mem[test_30_res+24] = 0x0000000000020000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000020000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x22, 0x40000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x22, 240(x2)
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
    c.sdsp      x21, 0(x2)
    # Check results:  mem[test_31_res+0] = 0x0000000000080000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000080000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x20, 0x100000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x20, 128(x2)
    # Check results:  mem[test_31_res+8] = 0x0000000000100000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000100000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x19, 0x200000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x19, 64(x2)
    # Check results:  mem[test_31_res+16] = 0x0000000000200000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000200000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x18, 0x400000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x18, 32(x2)
    # Check results:  mem[test_31_res+24] = 0x0000000000400000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000400000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x17, 0x800000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x17, 16(x2)
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
    li     x7, MASK_XLEN(-8)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x16, 8(x2)
    # Check results:  mem[test_32_res+0] = 0x0000000001000000
    ld x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000001000000)

    # Clear memory
    sd      x0, 8(x6)
    # Load values and compute offsets
    li      x15, 0x2000000
    addi    x2, x6,8
    li     x7, MASK_XLEN(-248)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x15, 248(x2)
    # Check results:  mem[test_32_res+8] = 0x0000000002000000
    ld x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000002000000)

    # Clear memory
    sd      x0, 16(x6)
    # Load values and compute offsets
    li      x14, 0x4000000
    addi    x2, x6,16
    li     x7, MASK_XLEN(-120)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x14, 120(x2)
    # Check results:  mem[test_32_res+16] = 0x0000000004000000
    ld x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000004000000)

    # Clear memory
    sd      x0, 24(x6)
    # Load values and compute offsets
    li      x13, 0x8000000
    addi    x2, x6,24
    li     x7, MASK_XLEN(-184)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x13, 184(x2)
    # Check results:  mem[test_32_res+24] = 0x0000000008000000
    ld x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000008000000)

    # Clear memory
    sd      x0, 32(x6)
    # Load values and compute offsets
    li      x12, 0x10000000
    addi    x2, x6,32
    li     x7, MASK_XLEN(-216)
    add    x2, x2, x7
    # Test Instruction 
    c.sdsp      x12, 216(x2)
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
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x11, 232(x2)
    # Check results:  mem[test_33_res+0] = 0x0000000020000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000020000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x40000000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x10, 240(x2)
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
    c.sdsp      x9, 0(x2)
    # Check results:  mem[test_33_res+16] = 0x0000000080000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000080000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x100000000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x8, 128(x2)
    # Check results:  mem[test_33_res+24] = 0x0000000100000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000100000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x7, 0x200000000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x7, 64(x2)
    # Check results:  mem[test_33_res+32] = 0x0000000200000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000200000000)

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
    li     x8, MASK_XLEN(-32)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x6, 32(x2)
    # Check results:  mem[test_34_res+0] = 0x0000000400000000
    ld x9, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000400000000)

    # Clear memory
    sd      x0, 8(x7)
    # Load values and compute offsets
    li      x5, 0x800000000
    addi    x2, x7,8
    li     x8, MASK_XLEN(-16)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x5, 16(x2)
    # Check results:  mem[test_34_res+8] = 0x0000000800000000
    ld x9, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000800000000)

    # Clear memory
    sd      x0, 16(x7)
    # Load values and compute offsets
    li      x4, 0x1000000000
    addi    x2, x7,16
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x4, 8(x2)
    # Check results:  mem[test_34_res+16] = 0x0000001000000000
    ld x9, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000001000000000)

    # Clear memory
    sd      x0, 24(x7)
    # Load values and compute offsets
    li      x3, 0x2000000000
    addi    x2, x7,24
    li     x8, MASK_XLEN(-248)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x3, 248(x2)
    # Check results:  mem[test_34_res+24] = 0x0000002000000000
    ld x9, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000002000000000)

    # Clear memory
    sd      x0, 32(x7)
    # Load values and compute offsets
    li      x1, 0x4000000000
    addi    x2, x7,32
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x1, 120(x2)
    # Check results:  mem[test_34_res+32] = 0x0000004000000000
    ld x9, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000004000000000)

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
    li     x4, MASK_XLEN(-184)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x1, 184(x2)
    # Check results:  mem[test_35_res+0] = 0x0000008000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000008000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x31, 0x10000000000
    addi    x2, x3,8
    li     x4, MASK_XLEN(-216)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x31, 216(x2)
    # Check results:  mem[test_35_res+8] = 0x0000010000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000010000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x30, 0x20000000000
    addi    x2, x3,16
    li     x4, MASK_XLEN(-232)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x30, 232(x2)
    # Check results:  mem[test_35_res+16] = 0x0000020000000000
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000020000000000)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x29, 0x40000000000
    addi    x2, x3,24
    li     x4, MASK_XLEN(-240)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x29, 240(x2)
    # Check results:  mem[test_35_res+24] = 0x0000040000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000040000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x28, 0x80000000000
    addi    x2, x3,32
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x28, 0(x2)
    # Check results:  mem[test_35_res+32] = 0x0000080000000000
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000080000000000)

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
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x27, 128(x2)
    # Check results:  mem[test_36_res+0] = 0x0000100000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000100000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x26, 0x200000000000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x26, 64(x2)
    # Check results:  mem[test_36_res+8] = 0x0000200000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000200000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x25, 0x400000000000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x25, 32(x2)
    # Check results:  mem[test_36_res+16] = 0x0000400000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000400000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x24, 0x800000000000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x24, 16(x2)
    # Check results:  mem[test_36_res+24] = 0x0000800000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000800000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x23, 0x1000000000000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x23, 8(x2)
    # Check results:  mem[test_36_res+32] = 0x0001000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0001000000000000)

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
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x22, 248(x2)
    # Check results:  mem[test_37_res+0] = 0x0002000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0002000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x21, 0x4000000000000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x21, 120(x2)
    # Check results:  mem[test_37_res+8] = 0x0004000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0004000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x20, 0x8000000000000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x20, 184(x2)
    # Check results:  mem[test_37_res+16] = 0x0008000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0008000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x19, 0x10000000000000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x19, 216(x2)
    # Check results:  mem[test_37_res+24] = 0x0010000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0010000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x18, 0x20000000000000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x18, 232(x2)
    # Check results:  mem[test_37_res+32] = 0x0020000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0020000000000000)

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
    li     x6, MASK_XLEN(-240)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x17, 240(x2)
    # Check results:  mem[test_38_res+0] = 0x0040000000000000
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0040000000000000)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x16, 0x80000000000000
    addi    x2, x5,8
    li     x6, MASK_XLEN(0)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x16, 0(x2)
    # Check results:  mem[test_38_res+8] = 0x0080000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0080000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x15, 0x100000000000000
    addi    x2, x5,16
    li     x6, MASK_XLEN(-128)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x15, 128(x2)
    # Check results:  mem[test_38_res+16] = 0x0100000000000000
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0100000000000000)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x14, 0x200000000000000
    addi    x2, x5,24
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x14, 64(x2)
    # Check results:  mem[test_38_res+24] = 0x0200000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0200000000000000)

    # Clear memory
    sd      x0, 32(x5)
    # Load values and compute offsets
    li      x13, 0x400000000000000
    addi    x2, x5,32
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x13, 32(x2)
    # Check results:  mem[test_38_res+32] = 0x0400000000000000
    ld x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0400000000000000)

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
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x12, 16(x2)
    # Check results:  mem[test_39_res+0] = 0x0800000000000000
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0800000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x1000000000000000
    addi    x2, x1,8
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x11, 8(x2)
    # Check results:  mem[test_39_res+8] = 0x1000000000000000
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x1000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x2000000000000000
    addi    x2, x1,16
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x10, 248(x2)
    # Check results:  mem[test_39_res+16] = 0x2000000000000000
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x2000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x4000000000000000
    addi    x2, x1,24
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x9, 120(x2)
    # Check results:  mem[test_39_res+24] = 0x4000000000000000
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x4000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x8000000000000000
    addi    x2, x1,32
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x8, 184(x2)
    # Check results:  mem[test_39_res+32] = 0x8000000000000000
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x8000000000000000)

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
    li     x8, MASK_XLEN(-216)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x7, 216(x2)
    # Check results:  mem[test_40_res+0] = 0x0000000000000000
    ld x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x6, 0xfffffffffffffffe
    addi    x2, x1,8
    li     x8, MASK_XLEN(-232)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x6, 232(x2)
    # Check results:  mem[test_40_res+8] = 0xfffffffffffffffe
    ld x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xfffffffffffffffe)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x5, 0xfffffffffffffffd
    addi    x2, x1,16
    li     x8, MASK_XLEN(-240)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x5, 240(x2)
    # Check results:  mem[test_40_res+16] = 0xfffffffffffffffd
    ld x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xfffffffffffffffd)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x4, 0xfffffffffffffffb
    addi    x2, x1,24
    li     x8, MASK_XLEN(0)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x4, 0(x2)
    # Check results:  mem[test_40_res+24] = 0xfffffffffffffffb
    ld x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xfffffffffffffffb)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x3, 0xfffffffffffffff7
    addi    x2, x1,32
    li     x8, MASK_XLEN(-128)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x3, 128(x2)
    # Check results:  mem[test_40_res+32] = 0xfffffffffffffff7
    ld x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xfffffffffffffff7)

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
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x1, 64(x2)
    # Check results:  mem[test_41_res+0] = 0xffffffffffffffef
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffffffffffffffef)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x1, 0xffffffffffffffdf
    addi    x2, x3,8
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x1, 32(x2)
    # Check results:  mem[test_41_res+8] = 0xffffffffffffffdf
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffffffffffffffdf)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x31, 0xffffffffffffffbf
    addi    x2, x3,16
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x31, 16(x2)
    # Check results:  mem[test_41_res+16] = 0xffffffffffffffbf
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffffffffffffffbf)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x30, 0xffffffffffffff7f
    addi    x2, x3,24
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x30, 8(x2)
    # Check results:  mem[test_41_res+24] = 0xffffffffffffff7f
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffffffffffffff7f)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x29, 0xfffffffffffffeff
    addi    x2, x3,32
    li     x4, MASK_XLEN(-248)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x29, 248(x2)
    # Check results:  mem[test_41_res+32] = 0xfffffffffffffeff
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xfffffffffffffeff)

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
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x28, 120(x2)
    # Check results:  mem[test_42_res+0] = 0xfffffffffffffdff
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffffffffffdff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x27, 0xfffffffffffffbff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x27, 184(x2)
    # Check results:  mem[test_42_res+8] = 0xfffffffffffffbff
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffffffffffbff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x26, 0xfffffffffffff7ff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x26, 216(x2)
    # Check results:  mem[test_42_res+16] = 0xfffffffffffff7ff
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffffffffff7ff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x25, 0xffffffffffffefff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x25, 232(x2)
    # Check results:  mem[test_42_res+24] = 0xffffffffffffefff
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffffffffffefff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x24, 0xffffffffffffdfff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x24, 240(x2)
    # Check results:  mem[test_42_res+32] = 0xffffffffffffdfff
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffffffffffdfff)

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
    c.sdsp      x23, 0(x2)
    # Check results:  mem[test_43_res+0] = 0xffffffffffffbfff
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffffffffffbfff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0xffffffffffff7fff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x22, 128(x2)
    # Check results:  mem[test_43_res+8] = 0xffffffffffff7fff
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffffffffff7fff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x21, 0xfffffffffffeffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x21, 64(x2)
    # Check results:  mem[test_43_res+16] = 0xfffffffffffeffff
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffffffffeffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x20, 0xfffffffffffdffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x20, 32(x2)
    # Check results:  mem[test_43_res+24] = 0xfffffffffffdffff
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffffffffdffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x19, 0xfffffffffffbffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x19, 16(x2)
    # Check results:  mem[test_43_res+32] = 0xfffffffffffbffff
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffffffffbffff)

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
    li     x5, MASK_XLEN(-8)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x18, 8(x2)
    # Check results:  mem[test_44_res+0] = 0xfffffffffff7ffff
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xfffffffffff7ffff)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x17, 0xffffffffffefffff
    addi    x2, x4,8
    li     x5, MASK_XLEN(-248)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x17, 248(x2)
    # Check results:  mem[test_44_res+8] = 0xffffffffffefffff
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffffffefffff)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x16, 0xffffffffffdfffff
    addi    x2, x4,16
    li     x5, MASK_XLEN(-120)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x16, 120(x2)
    # Check results:  mem[test_44_res+16] = 0xffffffffffdfffff
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffffffdfffff)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x15, 0xffffffffffbfffff
    addi    x2, x4,24
    li     x5, MASK_XLEN(-184)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x15, 184(x2)
    # Check results:  mem[test_44_res+24] = 0xffffffffffbfffff
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffffffbfffff)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x14, 0xffffffffff7fffff
    addi    x2, x4,32
    li     x5, MASK_XLEN(-216)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x14, 216(x2)
    # Check results:  mem[test_44_res+32] = 0xffffffffff7fffff
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffffff7fffff)

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
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x13, 232(x2)
    # Check results:  mem[test_45_res+0] = 0xfffffffffeffffff
    ld x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffeffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0xfffffffffdffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x12, 240(x2)
    # Check results:  mem[test_45_res+8] = 0xfffffffffdffffff
    ld x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffdffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0xfffffffffbffffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x11, 0(x2)
    # Check results:  mem[test_45_res+16] = 0xfffffffffbffffff
    ld x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffbffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0xfffffffff7ffffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x10, 128(x2)
    # Check results:  mem[test_45_res+24] = 0xfffffffff7ffffff
    ld x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffff7ffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0xffffffffefffffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x9, 64(x2)
    # Check results:  mem[test_45_res+32] = 0xffffffffefffffff
    ld x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffefffffff)

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
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x8, 32(x2)
    # Check results:  mem[test_46_res+0] = 0xffffffffdfffffff
    ld x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffdfffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0xffffffffbfffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x7, 16(x2)
    # Check results:  mem[test_46_res+8] = 0xffffffffbfffffff
    ld x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffbfffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x6, 0xffffffff7fffffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x6, 8(x2)
    # Check results:  mem[test_46_res+16] = 0xffffffff7fffffff
    ld x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffff7fffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x5, 0xfffffffeffffffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x5, 248(x2)
    # Check results:  mem[test_46_res+24] = 0xfffffffeffffffff
    ld x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffeffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x4, 0xfffffffdffffffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x4, 120(x2)
    # Check results:  mem[test_46_res+32] = 0xfffffffdffffffff
    ld x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffdffffffff)

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
    li     x5, MASK_XLEN(-184)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x3, 184(x2)
    # Check results:  mem[test_47_res+0] = 0xfffffffbffffffff
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xfffffffbffffffff)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x1, 0xfffffff7ffffffff
    addi    x2, x4,8
    li     x5, MASK_XLEN(-216)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x1, 216(x2)
    # Check results:  mem[test_47_res+8] = 0xfffffff7ffffffff
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xfffffff7ffffffff)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x1, 0xffffffefffffffff
    addi    x2, x4,16
    li     x5, MASK_XLEN(-232)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x1, 232(x2)
    # Check results:  mem[test_47_res+16] = 0xffffffefffffffff
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffefffffffff)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x31, 0xffffffdfffffffff
    addi    x2, x4,24
    li     x5, MASK_XLEN(-240)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x31, 240(x2)
    # Check results:  mem[test_47_res+24] = 0xffffffdfffffffff
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffdfffffffff)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x30, 0xffffffbfffffffff
    addi    x2, x4,32
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    # Test Instruction 
    c.sdsp      x30, 0(x2)
    # Check results:  mem[test_47_res+32] = 0xffffffbfffffffff
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffbfffffffff)

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
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x29, 128(x2)
    # Check results:  mem[test_48_res+0] = 0xffffff7fffffffff
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffff7fffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0xfffffeffffffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x28, 64(x2)
    # Check results:  mem[test_48_res+8] = 0xfffffeffffffffff
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffeffffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x27, 0xfffffdffffffffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x27, 32(x2)
    # Check results:  mem[test_48_res+16] = 0xfffffdffffffffff
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffdffffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x26, 0xfffffbffffffffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x26, 16(x2)
    # Check results:  mem[test_48_res+24] = 0xfffffbffffffffff
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffffbffffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x25, 0xfffff7ffffffffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x25, 8(x2)
    # Check results:  mem[test_48_res+32] = 0xfffff7ffffffffff
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffff7ffffffffff)

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
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x24, 248(x2)
    # Check results:  mem[test_49_res+0] = 0xffffefffffffffff
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffefffffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x23, 0xffffdfffffffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x23, 120(x2)
    # Check results:  mem[test_49_res+8] = 0xffffdfffffffffff
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffdfffffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x22, 0xffffbfffffffffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x22, 184(x2)
    # Check results:  mem[test_49_res+16] = 0xffffbfffffffffff
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffffbfffffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x21, 0xffff7fffffffffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x21, 216(x2)
    # Check results:  mem[test_49_res+24] = 0xffff7fffffffffff
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xffff7fffffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x20, 0xfffeffffffffffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x20, 232(x2)
    # Check results:  mem[test_49_res+32] = 0xfffeffffffffffff
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xfffeffffffffffff)

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
    li     x4, MASK_XLEN(-240)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x19, 240(x2)
    # Check results:  mem[test_50_res+0] = 0xfffdffffffffffff
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xfffdffffffffffff)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x18, 0xfffbffffffffffff
    addi    x2, x3,8
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x18, 0(x2)
    # Check results:  mem[test_50_res+8] = 0xfffbffffffffffff
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xfffbffffffffffff)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x17, 0xfff7ffffffffffff
    addi    x2, x3,16
    li     x4, MASK_XLEN(-128)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x17, 128(x2)
    # Check results:  mem[test_50_res+16] = 0xfff7ffffffffffff
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xfff7ffffffffffff)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x16, 0xffefffffffffffff
    addi    x2, x3,24
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x16, 64(x2)
    # Check results:  mem[test_50_res+24] = 0xffefffffffffffff
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffefffffffffffff)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x15, 0xffdfffffffffffff
    addi    x2, x3,32
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    # Test Instruction 
    c.sdsp      x15, 32(x2)
    # Check results:  mem[test_50_res+32] = 0xffdfffffffffffff
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffdfffffffffffff)

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
    li     x8, MASK_XLEN(-16)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x14, 16(x2)
    # Check results:  mem[test_51_res+0] = 0xffbfffffffffffff
    ld x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xffbfffffffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0xff7fffffffffffff
    addi    x2, x1,8
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x13, 8(x2)
    # Check results:  mem[test_51_res+8] = 0xff7fffffffffffff
    ld x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xff7fffffffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0xfeffffffffffffff
    addi    x2, x1,16
    li     x8, MASK_XLEN(-248)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x12, 248(x2)
    # Check results:  mem[test_51_res+16] = 0xfeffffffffffffff
    ld x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xfeffffffffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0xfdffffffffffffff
    addi    x2, x1,24
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x11, 120(x2)
    # Check results:  mem[test_51_res+24] = 0xfdffffffffffffff
    ld x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xfdffffffffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0xfbffffffffffffff
    addi    x2, x1,32
    li     x8, MASK_XLEN(-184)
    add    x2, x2, x8
    # Test Instruction 
    c.sdsp      x10, 184(x2)
    # Check results:  mem[test_51_res+32] = 0xfbffffffffffffff
    ld x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xfbffffffffffffff)

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
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x9, 216(x2)
    # Check results:  mem[test_52_res+0] = 0xf7ffffffffffffff
    ld x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xf7ffffffffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0xefffffffffffffff
    addi    x2, x1,8
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x8, 232(x2)
    # Check results:  mem[test_52_res+8] = 0xefffffffffffffff
    ld x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xefffffffffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x7, 0xdfffffffffffffff
    addi    x2, x1,16
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x7, 240(x2)
    # Check results:  mem[test_52_res+16] = 0xdfffffffffffffff
    ld x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xdfffffffffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x6, 0xbfffffffffffffff
    addi    x2, x1,24
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x6, 0(x2)
    # Check results:  mem[test_52_res+24] = 0xbfffffffffffffff
    ld x4, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xbfffffffffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x5, 0x7fffffffffffffff
    addi    x2, x1,32
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    # Test Instruction 
    c.sdsp      x5, 128(x2)
    # Check results:  mem[test_52_res+32] = 0x7fffffffffffffff
    ld x4, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x7fffffffffffffff)

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
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x4, 64(x2)
    # Check results:  mem[test_53_res+0] = 0xffffffffffffffff
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xffffffffffffffff)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x2, x5,8
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x3, 32(x2)
    # Check results:  mem[test_53_res+8] = 0x0000000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x0, 0x0
    addi    x2, x5,16
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x0, 16(x2)
    # Check results:  mem[test_53_res+16] = 0
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x5,24
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    # Test Instruction 
    c.sdsp      x1, 8(x2)
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

