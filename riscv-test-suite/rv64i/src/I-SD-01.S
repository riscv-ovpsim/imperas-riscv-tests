# RISC-V Compliance Test I-SD-01
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
# Specification: RV64I Base Integer Instruction Set, Version 2.1
# Description: Testing instruction 'SD'.

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
    addi    x31, x6,0
    li     x7, MASK_XLEN(1)
    add    x31, x31, x7
    # Test Instruction 
    sd      x16, -1(x31)
    # Check results:  mem[test_1_res+0] = 0xffffffffffffffff
    ld x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xffffffffffffffff)

    # Clear memory
    sd      x0, 8(x6)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x6,8
    li     x7, MASK_XLEN(-2047)
    add    x30, x30, x7
    # Test Instruction 
    sd      x15, 2047(x30)
    # Check results:  mem[test_1_res+8] = 0x0000000000000000
    ld x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x6)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x6,16
    li     x7, MASK_XLEN(1025)
    add    x29, x29, x7
    # Test Instruction 
    sd      x14, -1025(x29)
    # Check results:  mem[test_1_res+16] = 0x0000000000000000
    ld x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x6)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x6,24
    li     x7, MASK_XLEN(513)
    add    x28, x28, x7
    # Test Instruction 
    sd      x13, -513(x28)
    # Check results:  mem[test_1_res+24] = 0x0000000000000000
    ld x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x6)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x6,32
    li     x7, MASK_XLEN(257)
    add    x27, x27, x7
    # Test Instruction 
    sd      x12, -257(x27)
    # Check results:  mem[test_1_res+32] = 0x0000000000000000
    ld x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # Addresses for test results
    la x1, test_2_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x26, x1,0
    li     x2, MASK_XLEN(129)
    add    x26, x26, x2
    # Test Instruction 
    sd      x11, -129(x26)
    # Check results:  mem[test_2_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,8
    li     x2, MASK_XLEN(65)
    add    x25, x25, x2
    # Test Instruction 
    sd      x10, -65(x25)
    # Check results:  mem[test_2_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x24, x1,16
    li     x2, MASK_XLEN(33)
    add    x24, x24, x2
    # Test Instruction 
    sd      x9, -33(x24)
    # Check results:  mem[test_2_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x23, x1,24
    li     x2, MASK_XLEN(17)
    add    x23, x23, x2
    # Test Instruction 
    sd      x8, -17(x23)
    # Check results:  mem[test_2_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x22, x1,32
    li     x2, MASK_XLEN(9)
    add    x22, x22, x2
    # Test Instruction 
    sd      x7, -9(x22)
    # Check results:  mem[test_2_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # Addresses for test results
    la x1, test_3_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x21, x1,0
    li     x7, MASK_XLEN(5)
    add    x21, x21, x7
    # Test Instruction 
    sd      x6, -5(x21)
    # Check results:  mem[test_3_res+0] = 0x0000000000000000
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x20, x1,8
    li     x7, MASK_XLEN(3)
    add    x20, x20, x7
    # Test Instruction 
    sd      x5, -3(x20)
    # Check results:  mem[test_3_res+8] = 0x0000000000000000
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x19, x1,16
    li     x7, MASK_XLEN(2)
    add    x19, x19, x7
    # Test Instruction 
    sd      x4, -2(x19)
    # Check results:  mem[test_3_res+16] = 0x0000000000000000
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x18, x1,24
    li     x7, MASK_XLEN(0)
    add    x18, x18, x7
    # Test Instruction 
    sd      x3, 0(x18)
    # Check results:  mem[test_3_res+24] = 0x0000000000000000
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x17, x1,32
    li     x7, MASK_XLEN(2048)
    add    x17, x17, x7
    # Test Instruction 
    sd      x2, -2048(x17)
    # Check results:  mem[test_3_res+32] = 0x0000000000000000
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # Addresses for test results
    la x2, test_4_res

    # Clear memory
    sd      x0, 0(x2)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x16, x2,0
    li     x3, MASK_XLEN(-1024)
    add    x16, x16, x3
    # Test Instruction 
    sd      x1, 1024(x16)
    # Check results:  mem[test_4_res+0] = 0x0000000000000000
    ld x4, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x2)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x15, x2,8
    li     x3, MASK_XLEN(-512)
    add    x15, x15, x3
    # Test Instruction 
    sd      x31, 512(x15)
    # Check results:  mem[test_4_res+8] = 0x0000000000000000
    ld x4, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x2)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x14, x2,16
    li     x3, MASK_XLEN(-256)
    add    x14, x14, x3
    # Test Instruction 
    sd      x30, 256(x14)
    # Check results:  mem[test_4_res+16] = 0x0000000000000000
    ld x4, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x2)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x13, x2,24
    li     x3, MASK_XLEN(-128)
    add    x13, x13, x3
    # Test Instruction 
    sd      x29, 128(x13)
    # Check results:  mem[test_4_res+24] = 0x0000000000000000
    ld x4, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x2)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x12, x2,32
    li     x3, MASK_XLEN(-64)
    add    x12, x12, x3
    # Test Instruction 
    sd      x28, 64(x12)
    # Check results:  mem[test_4_res+32] = 0x0000000000000000
    ld x4, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # Addresses for test results
    la x1, test_5_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x11, x1,0
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    # Test Instruction 
    sd      x27, 32(x11)
    # Check results:  mem[test_5_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x10, x1,8
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    # Test Instruction 
    sd      x26, 16(x10)
    # Check results:  mem[test_5_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x9, x1,16
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    # Test Instruction 
    sd      x25, 8(x9)
    # Check results:  mem[test_5_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x8, x1,24
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    # Test Instruction 
    sd      x24, 4(x8)
    # Check results:  mem[test_5_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x7, x1,32
    li     x2, MASK_XLEN(-2)
    add    x7, x7, x2
    # Test Instruction 
    sd      x23, 2(x7)
    # Check results:  mem[test_5_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # Addresses for test results
    la x1, test_6_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x6, x1,0
    li     x7, MASK_XLEN(-1)
    add    x6, x6, x7
    # Test Instruction 
    sd      x22, 1(x6)
    # Check results:  mem[test_6_res+0] = 0x0000000000000000
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x5, x1,8
    li     x7, MASK_XLEN(1)
    add    x5, x5, x7
    # Test Instruction 
    sd      x21, -1(x5)
    # Check results:  mem[test_6_res+8] = 0x0000000000000000
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x4, x1,16
    li     x7, MASK_XLEN(-2047)
    add    x4, x4, x7
    # Test Instruction 
    sd      x20, 2047(x4)
    # Check results:  mem[test_6_res+16] = 0x0000000000000000
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x3, x1,24
    li     x7, MASK_XLEN(1025)
    add    x3, x3, x7
    # Test Instruction 
    sd      x19, -1025(x3)
    # Check results:  mem[test_6_res+24] = 0x0000000000000000
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x1,32
    li     x7, MASK_XLEN(513)
    add    x2, x2, x7
    # Test Instruction 
    sd      x18, -513(x2)
    # Check results:  mem[test_6_res+32] = 0x0000000000000000
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # Addresses for test results
    la x5, test_7_res

    # Clear memory
    sd      x0, 0(x5)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x1, x5,0
    li     x6, MASK_XLEN(257)
    add    x1, x1, x6
    # Test Instruction 
    sd      x17, -257(x1)
    # Check results:  mem[test_7_res+0] = 0x0000000000000000
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x31, x5,8
    li     x6, MASK_XLEN(129)
    add    x31, x31, x6
    # Test Instruction 
    sd      x16, -129(x31)
    # Check results:  mem[test_7_res+8] = 0x0000000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x5,16
    li     x6, MASK_XLEN(65)
    add    x30, x30, x6
    # Test Instruction 
    sd      x15, -65(x30)
    # Check results:  mem[test_7_res+16] = 0x0000000000000000
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x5,24
    li     x6, MASK_XLEN(33)
    add    x29, x29, x6
    # Test Instruction 
    sd      x14, -33(x29)
    # Check results:  mem[test_7_res+24] = 0x0000000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x5)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x5,32
    li     x6, MASK_XLEN(17)
    add    x28, x28, x6
    # Test Instruction 
    sd      x13, -17(x28)
    # Check results:  mem[test_7_res+32] = 0x0000000000000000
    ld x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # Addresses for test results
    la x1, test_8_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x1,0
    li     x2, MASK_XLEN(9)
    add    x27, x27, x2
    # Test Instruction 
    sd      x12, -9(x27)
    # Check results:  mem[test_8_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x26, x1,8
    li     x2, MASK_XLEN(5)
    add    x26, x26, x2
    # Test Instruction 
    sd      x11, -5(x26)
    # Check results:  mem[test_8_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,16
    li     x2, MASK_XLEN(3)
    add    x25, x25, x2
    # Test Instruction 
    sd      x10, -3(x25)
    # Check results:  mem[test_8_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x24, x1,24
    li     x2, MASK_XLEN(2)
    add    x24, x24, x2
    # Test Instruction 
    sd      x9, -2(x24)
    # Check results:  mem[test_8_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x23, x1,32
    li     x2, MASK_XLEN(0)
    add    x23, x23, x2
    # Test Instruction 
    sd      x8, 0(x23)
    # Check results:  mem[test_8_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # Addresses for test results
    la x1, test_9_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x22, x1,0
    li     x2, MASK_XLEN(2048)
    add    x22, x22, x2
    # Test Instruction 
    sd      x7, -2048(x22)
    # Check results:  mem[test_9_res+0] = 0x0000000000000000
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x21, x1,8
    li     x2, MASK_XLEN(-1024)
    add    x21, x21, x2
    # Test Instruction 
    sd      x6, 1024(x21)
    # Check results:  mem[test_9_res+8] = 0x0000000000000000
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x20, x1,16
    li     x2, MASK_XLEN(-512)
    add    x20, x20, x2
    # Test Instruction 
    sd      x5, 512(x20)
    # Check results:  mem[test_9_res+16] = 0x0000000000000000
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x19, x1,24
    li     x2, MASK_XLEN(-256)
    add    x19, x19, x2
    # Test Instruction 
    sd      x4, 256(x19)
    # Check results:  mem[test_9_res+24] = 0x0000000000000000
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x18, x1,32
    li     x2, MASK_XLEN(-128)
    add    x18, x18, x2
    # Test Instruction 
    sd      x3, 128(x18)
    # Check results:  mem[test_9_res+32] = 0x0000000000000000
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # Addresses for test results
    la x3, test_10_res

    # Clear memory
    sd      x0, 0(x3)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x17, x3,0
    li     x4, MASK_XLEN(-64)
    add    x17, x17, x4
    # Test Instruction 
    sd      x2, 64(x17)
    # Check results:  mem[test_10_res+0] = 0x0000000000000000
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x16, x3,8
    li     x4, MASK_XLEN(-32)
    add    x16, x16, x4
    # Test Instruction 
    sd      x1, 32(x16)
    # Check results:  mem[test_10_res+8] = 0x0000000000000000
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x15, x3,16
    li     x4, MASK_XLEN(-16)
    add    x15, x15, x4
    # Test Instruction 
    sd      x31, 16(x15)
    # Check results:  mem[test_10_res+16] = 0x0000000000000000
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x14, x3,24
    li     x4, MASK_XLEN(-8)
    add    x14, x14, x4
    # Test Instruction 
    sd      x30, 8(x14)
    # Check results:  mem[test_10_res+24] = 0x0000000000000000
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x13, x3,32
    li     x4, MASK_XLEN(-4)
    add    x13, x13, x4
    # Test Instruction 
    sd      x29, 4(x13)
    # Check results:  mem[test_10_res+32] = 0x0000000000000000
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # Addresses for test results
    la x1, test_11_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x12, x1,0
    li     x2, MASK_XLEN(-2)
    add    x12, x12, x2
    # Test Instruction 
    sd      x28, 2(x12)
    # Check results:  mem[test_11_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x11, x1,8
    li     x2, MASK_XLEN(-1)
    add    x11, x11, x2
    # Test Instruction 
    sd      x27, 1(x11)
    # Check results:  mem[test_11_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x10, x1,16
    li     x2, MASK_XLEN(1)
    add    x10, x10, x2
    # Test Instruction 
    sd      x26, -1(x10)
    # Check results:  mem[test_11_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x9, x1,24
    li     x2, MASK_XLEN(-2047)
    add    x9, x9, x2
    # Test Instruction 
    sd      x25, 2047(x9)
    # Check results:  mem[test_11_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x8, x1,32
    li     x2, MASK_XLEN(1025)
    add    x8, x8, x2
    # Test Instruction 
    sd      x24, -1025(x8)
    # Check results:  mem[test_11_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # Addresses for test results
    la x1, test_12_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x7, x1,0
    li     x2, MASK_XLEN(513)
    add    x7, x7, x2
    # Test Instruction 
    sd      x23, -513(x7)
    # Check results:  mem[test_12_res+0] = 0x0000000000000000
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x6, x1,8
    li     x2, MASK_XLEN(257)
    add    x6, x6, x2
    # Test Instruction 
    sd      x22, -257(x6)
    # Check results:  mem[test_12_res+8] = 0x0000000000000000
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x5, x1,16
    li     x2, MASK_XLEN(129)
    add    x5, x5, x2
    # Test Instruction 
    sd      x21, -129(x5)
    # Check results:  mem[test_12_res+16] = 0x0000000000000000
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x4, x1,24
    li     x2, MASK_XLEN(65)
    add    x4, x4, x2
    # Test Instruction 
    sd      x20, -65(x4)
    # Check results:  mem[test_12_res+24] = 0x0000000000000000
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x3, x1,32
    li     x2, MASK_XLEN(33)
    add    x3, x3, x2
    # Test Instruction 
    sd      x19, -33(x3)
    # Check results:  mem[test_12_res+32] = 0x0000000000000000
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # Addresses for test results
    la x4, test_13_res

    # Clear memory
    sd      x0, 0(x4)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x4,0
    li     x5, MASK_XLEN(17)
    add    x2, x2, x5
    # Test Instruction 
    sd      x18, -17(x2)
    # Check results:  mem[test_13_res+0] = 0x0000000000000000
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x1, x4,8
    li     x5, MASK_XLEN(9)
    add    x1, x1, x5
    # Test Instruction 
    sd      x17, -9(x1)
    # Check results:  mem[test_13_res+8] = 0x0000000000000000
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x31, x4,16
    li     x5, MASK_XLEN(5)
    add    x31, x31, x5
    # Test Instruction 
    sd      x16, -5(x31)
    # Check results:  mem[test_13_res+16] = 0x0000000000000000
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x4,24
    li     x5, MASK_XLEN(3)
    add    x30, x30, x5
    # Test Instruction 
    sd      x15, -3(x30)
    # Check results:  mem[test_13_res+24] = 0x0000000000000000
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x4,32
    li     x5, MASK_XLEN(2)
    add    x29, x29, x5
    # Test Instruction 
    sd      x14, -2(x29)
    # Check results:  mem[test_13_res+32] = 0x0000000000000000
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # Addresses for test results
    la x1, test_14_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x1,0
    li     x2, MASK_XLEN(0)
    add    x28, x28, x2
    # Test Instruction 
    sd      x13, 0(x28)
    # Check results:  mem[test_14_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x1,8
    li     x2, MASK_XLEN(2048)
    add    x27, x27, x2
    # Test Instruction 
    sd      x12, -2048(x27)
    # Check results:  mem[test_14_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x26, x1,16
    li     x2, MASK_XLEN(-1024)
    add    x26, x26, x2
    # Test Instruction 
    sd      x11, 1024(x26)
    # Check results:  mem[test_14_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,24
    li     x2, MASK_XLEN(-512)
    add    x25, x25, x2
    # Test Instruction 
    sd      x10, 512(x25)
    # Check results:  mem[test_14_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x24, x1,32
    li     x2, MASK_XLEN(-256)
    add    x24, x24, x2
    # Test Instruction 
    sd      x9, 256(x24)
    # Check results:  mem[test_14_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # Addresses for test results
    la x1, test_15_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x23, x1,0
    li     x2, MASK_XLEN(-128)
    add    x23, x23, x2
    # Test Instruction 
    sd      x8, 128(x23)
    # Check results:  mem[test_15_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x22, x1,8
    li     x2, MASK_XLEN(-64)
    add    x22, x22, x2
    # Test Instruction 
    sd      x7, 64(x22)
    # Check results:  mem[test_15_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x21, x1,16
    li     x2, MASK_XLEN(-32)
    add    x21, x21, x2
    # Test Instruction 
    sd      x6, 32(x21)
    # Check results:  mem[test_15_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x20, x1,24
    li     x2, MASK_XLEN(-16)
    add    x20, x20, x2
    # Test Instruction 
    sd      x5, 16(x20)
    # Check results:  mem[test_15_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x19, x1,32
    li     x2, MASK_XLEN(-8)
    add    x19, x19, x2
    # Test Instruction 
    sd      x4, 8(x19)
    # Check results:  mem[test_15_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # Addresses for test results
    la x4, test_16_res

    # Clear memory
    sd      x0, 0(x4)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x18, x4,0
    li     x5, MASK_XLEN(-4)
    add    x18, x18, x5
    # Test Instruction 
    sd      x3, 4(x18)
    # Check results:  mem[test_16_res+0] = 0x0000000000000000
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x17, x4,8
    li     x5, MASK_XLEN(-2)
    add    x17, x17, x5
    # Test Instruction 
    sd      x2, 2(x17)
    # Check results:  mem[test_16_res+8] = 0x0000000000000000
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x16, x4,16
    li     x5, MASK_XLEN(-1)
    add    x16, x16, x5
    # Test Instruction 
    sd      x1, 1(x16)
    # Check results:  mem[test_16_res+16] = 0x0000000000000000
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x15, x4,24
    li     x5, MASK_XLEN(1)
    add    x15, x15, x5
    # Test Instruction 
    sd      x31, -1(x15)
    # Check results:  mem[test_16_res+24] = 0x0000000000000000
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x14, x4,32
    li     x5, MASK_XLEN(-2047)
    add    x14, x14, x5
    # Test Instruction 
    sd      x30, 2047(x14)
    # Check results:  mem[test_16_res+32] = 0x0000000000000000
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # Addresses for test results
    la x1, test_17_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x13, x1,0
    li     x2, MASK_XLEN(1025)
    add    x13, x13, x2
    # Test Instruction 
    sd      x29, -1025(x13)
    # Check results:  mem[test_17_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x12, x1,8
    li     x2, MASK_XLEN(513)
    add    x12, x12, x2
    # Test Instruction 
    sd      x28, -513(x12)
    # Check results:  mem[test_17_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x11, x1,16
    li     x2, MASK_XLEN(257)
    add    x11, x11, x2
    # Test Instruction 
    sd      x27, -257(x11)
    # Check results:  mem[test_17_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x10, x1,24
    li     x2, MASK_XLEN(129)
    add    x10, x10, x2
    # Test Instruction 
    sd      x26, -129(x10)
    # Check results:  mem[test_17_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x9, x1,32
    li     x2, MASK_XLEN(65)
    add    x9, x9, x2
    # Test Instruction 
    sd      x25, -65(x9)
    # Check results:  mem[test_17_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # Addresses for test results
    la x1, test_18_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x8, x1,0
    li     x2, MASK_XLEN(33)
    add    x8, x8, x2
    # Test Instruction 
    sd      x24, -33(x8)
    # Check results:  mem[test_18_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x7, x1,8
    li     x2, MASK_XLEN(17)
    add    x7, x7, x2
    # Test Instruction 
    sd      x23, -17(x7)
    # Check results:  mem[test_18_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x6, x1,16
    li     x2, MASK_XLEN(9)
    add    x6, x6, x2
    # Test Instruction 
    sd      x22, -9(x6)
    # Check results:  mem[test_18_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x5, x1,24
    li     x2, MASK_XLEN(5)
    add    x5, x5, x2
    # Test Instruction 
    sd      x21, -5(x5)
    # Check results:  mem[test_18_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x4, x1,32
    li     x2, MASK_XLEN(3)
    add    x4, x4, x2
    # Test Instruction 
    sd      x20, -3(x4)
    # Check results:  mem[test_18_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # Addresses for test results
    la x4, test_19_res

    # Clear memory
    sd      x0, 0(x4)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x3, x4,0
    li     x5, MASK_XLEN(2)
    add    x3, x3, x5
    # Test Instruction 
    sd      x19, -2(x3)
    # Check results:  mem[test_19_res+0] = 0x0000000000000000
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x4,8
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    # Test Instruction 
    sd      x18, 0(x2)
    # Check results:  mem[test_19_res+8] = 0x0000000000000000
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x1, x4,16
    li     x5, MASK_XLEN(2048)
    add    x1, x1, x5
    # Test Instruction 
    sd      x17, -2048(x1)
    # Check results:  mem[test_19_res+16] = 0x0000000000000000
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x31, x4,24
    li     x5, MASK_XLEN(-1024)
    add    x31, x31, x5
    # Test Instruction 
    sd      x16, 1024(x31)
    # Check results:  mem[test_19_res+24] = 0x0000000000000000
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x4,32
    li     x5, MASK_XLEN(-512)
    add    x30, x30, x5
    # Test Instruction 
    sd      x15, 512(x30)
    # Check results:  mem[test_19_res+32] = 0x0000000000000000
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # Addresses for test results
    la x1, test_20_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x1,0
    li     x2, MASK_XLEN(-256)
    add    x29, x29, x2
    # Test Instruction 
    sd      x14, 256(x29)
    # Check results:  mem[test_20_res+0] = 0x0000000000000000
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x1,8
    li     x2, MASK_XLEN(-128)
    add    x28, x28, x2
    # Test Instruction 
    sd      x13, 128(x28)
    # Check results:  mem[test_20_res+8] = 0x0000000000000000
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x1,16
    li     x2, MASK_XLEN(-64)
    add    x27, x27, x2
    # Test Instruction 
    sd      x12, 64(x27)
    # Check results:  mem[test_20_res+16] = 0x0000000000000000
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x26, x1,24
    li     x2, MASK_XLEN(-32)
    add    x26, x26, x2
    # Test Instruction 
    sd      x11, 32(x26)
    # Check results:  mem[test_20_res+24] = 0x0000000000000000
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,32
    li     x2, MASK_XLEN(-16)
    add    x25, x25, x2
    # Test Instruction 
    sd      x10, 16(x25)
    # Check results:  mem[test_20_res+32] = 0x0000000000000000
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # Addresses for test results
    la x1, test_21_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x24, x1,0
    li     x2, MASK_XLEN(-8)
    add    x24, x24, x2
    # Test Instruction 
    sd      x9, 8(x24)
    # Check results:  mem[test_21_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x23, x1,8
    li     x2, MASK_XLEN(-4)
    add    x23, x23, x2
    # Test Instruction 
    sd      x8, 4(x23)
    # Check results:  mem[test_21_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x22, x1,16
    li     x2, MASK_XLEN(-2)
    add    x22, x22, x2
    # Test Instruction 
    sd      x7, 2(x22)
    # Check results:  mem[test_21_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x21, x1,24
    li     x2, MASK_XLEN(-1)
    add    x21, x21, x2
    # Test Instruction 
    sd      x6, 1(x21)
    # Check results:  mem[test_21_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x20, x1,32
    li     x2, MASK_XLEN(1)
    add    x20, x20, x2
    # Test Instruction 
    sd      x5, -1(x20)
    # Check results:  mem[test_21_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # Addresses for test results
    la x5, test_22_res

    # Clear memory
    sd      x0, 0(x5)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x19, x5,0
    li     x6, MASK_XLEN(-2047)
    add    x19, x19, x6
    # Test Instruction 
    sd      x4, 2047(x19)
    # Check results:  mem[test_22_res+0] = 0x0000000000000000
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x18, x5,8
    li     x6, MASK_XLEN(1025)
    add    x18, x18, x6
    # Test Instruction 
    sd      x3, -1025(x18)
    # Check results:  mem[test_22_res+8] = 0x0000000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x17, x5,16
    li     x6, MASK_XLEN(513)
    add    x17, x17, x6
    # Test Instruction 
    sd      x2, -513(x17)
    # Check results:  mem[test_22_res+16] = 0x0000000000000000
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x16, x5,24
    li     x6, MASK_XLEN(257)
    add    x16, x16, x6
    # Test Instruction 
    sd      x1, -257(x16)
    # Check results:  mem[test_22_res+24] = 0x0000000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x5)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x15, x5,32
    li     x6, MASK_XLEN(129)
    add    x15, x15, x6
    # Test Instruction 
    sd      x31, -129(x15)
    # Check results:  mem[test_22_res+32] = 0x0000000000000000
    ld x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # Addresses for test results
    la x1, test_23_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x14, x1,0
    li     x2, MASK_XLEN(65)
    add    x14, x14, x2
    # Test Instruction 
    sd      x30, -65(x14)
    # Check results:  mem[test_23_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x13, x1,8
    li     x2, MASK_XLEN(33)
    add    x13, x13, x2
    # Test Instruction 
    sd      x29, -33(x13)
    # Check results:  mem[test_23_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x12, x1,16
    li     x2, MASK_XLEN(17)
    add    x12, x12, x2
    # Test Instruction 
    sd      x28, -17(x12)
    # Check results:  mem[test_23_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x11, x1,24
    li     x2, MASK_XLEN(9)
    add    x11, x11, x2
    # Test Instruction 
    sd      x27, -9(x11)
    # Check results:  mem[test_23_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x10, x1,32
    li     x2, MASK_XLEN(5)
    add    x10, x10, x2
    # Test Instruction 
    sd      x26, -5(x10)
    # Check results:  mem[test_23_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # Addresses for test results
    la x1, test_24_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x9, x1,0
    li     x2, MASK_XLEN(3)
    add    x9, x9, x2
    # Test Instruction 
    sd      x25, -3(x9)
    # Check results:  mem[test_24_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x8, x1,8
    li     x2, MASK_XLEN(2)
    add    x8, x8, x2
    # Test Instruction 
    sd      x24, -2(x8)
    # Check results:  mem[test_24_res+8] = 0x0000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x7, x1,16
    li     x2, MASK_XLEN(0)
    add    x7, x7, x2
    # Test Instruction 
    sd      x23, 0(x7)
    # Check results:  mem[test_24_res+16] = 0x0000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x6, x1,24
    li     x2, MASK_XLEN(2048)
    add    x6, x6, x2
    # Test Instruction 
    sd      x22, -2048(x6)
    # Check results:  mem[test_24_res+24] = 0x0000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x5, x1,32
    li     x2, MASK_XLEN(-1024)
    add    x5, x5, x2
    # Test Instruction 
    sd      x21, 1024(x5)
    # Check results:  mem[test_24_res+32] = 0x0000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # Addresses for test results
    la x5, test_25_res

    # Clear memory
    sd      x0, 0(x5)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x4, x5,0
    li     x6, MASK_XLEN(-512)
    add    x4, x4, x6
    # Test Instruction 
    sd      x20, 512(x4)
    # Check results:  mem[test_25_res+0] = 0x0000000000000000
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x3, x5,8
    li     x6, MASK_XLEN(-256)
    add    x3, x3, x6
    # Test Instruction 
    sd      x19, 256(x3)
    # Check results:  mem[test_25_res+8] = 0x0000000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x5,16
    li     x6, MASK_XLEN(-128)
    add    x2, x2, x6
    # Test Instruction 
    sd      x18, 128(x2)
    # Check results:  mem[test_25_res+16] = 0x0000000000000000
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x1, x5,24
    li     x6, MASK_XLEN(-64)
    add    x1, x1, x6
    # Test Instruction 
    sd      x17, 64(x1)
    # Check results:  mem[test_25_res+24] = 0x0000000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x5)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x31, x5,32
    li     x6, MASK_XLEN(-32)
    add    x31, x31, x6
    # Test Instruction 
    sd      x16, 32(x31)
    # Check results:  mem[test_25_res+32] = 0x0000000000000000
    ld x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # Addresses for test results
    la x1, test_26_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x1,0
    li     x7, MASK_XLEN(-16)
    add    x30, x30, x7
    # Test Instruction 
    sd      x15, 16(x30)
    # Check results:  mem[test_26_res+0] = 0x0000000000000000
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x1,8
    li     x7, MASK_XLEN(-8)
    add    x29, x29, x7
    # Test Instruction 
    sd      x14, 8(x29)
    # Check results:  mem[test_26_res+8] = 0x0000000000000000
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x1,16
    li     x7, MASK_XLEN(-4)
    add    x28, x28, x7
    # Test Instruction 
    sd      x13, 4(x28)
    # Check results:  mem[test_26_res+16] = 0x0000000000000000
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x1,24
    li     x7, MASK_XLEN(-2)
    add    x27, x27, x7
    # Test Instruction 
    sd      x12, 2(x27)
    # Check results:  mem[test_26_res+24] = 0x0000000000000000
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x26, x1,32
    li     x7, MASK_XLEN(-1)
    add    x26, x26, x7
    # Test Instruction 
    sd      x11, 1(x26)
    # Check results:  mem[test_26_res+32] = 0x0000000000000000
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # Addresses for test results
    la x1, test_27_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,0
    li     x2, MASK_XLEN(1)
    add    x25, x25, x2
    # Test Instruction 
    sd      x10, -1(x25)
    # Check results:  mem[test_27_res+0] = 0x0000000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x1
    addi    x24, x1,8
    li     x2, MASK_XLEN(-2047)
    add    x24, x24, x2
    # Test Instruction 
    sd      x9, 2047(x24)
    # Check results:  mem[test_27_res+8] = 0x0000000000000001
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000001)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x2
    addi    x23, x1,16
    li     x2, MASK_XLEN(1025)
    add    x23, x23, x2
    # Test Instruction 
    sd      x8, -1025(x23)
    # Check results:  mem[test_27_res+16] = 0x0000000000000002
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000002)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x7, 0x4
    addi    x22, x1,24
    li     x2, MASK_XLEN(513)
    add    x22, x22, x2
    # Test Instruction 
    sd      x7, -513(x22)
    # Check results:  mem[test_27_res+24] = 0x0000000000000004
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000004)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x6, 0x8
    addi    x21, x1,32
    li     x2, MASK_XLEN(257)
    add    x21, x21, x2
    # Test Instruction 
    sd      x6, -257(x21)
    # Check results:  mem[test_27_res+32] = 0x0000000000000008
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000008)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # Addresses for test results
    la x6, test_28_res

    # Clear memory
    sd      x0, 0(x6)
    # Load values and compute offsets
    li      x5, 0x10
    addi    x20, x6,0
    li     x7, MASK_XLEN(129)
    add    x20, x20, x7
    # Test Instruction 
    sd      x5, -129(x20)
    # Check results:  mem[test_28_res+0] = 0x0000000000000010
    ld x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000010)

    # Clear memory
    sd      x0, 8(x6)
    # Load values and compute offsets
    li      x4, 0x20
    addi    x19, x6,8
    li     x7, MASK_XLEN(65)
    add    x19, x19, x7
    # Test Instruction 
    sd      x4, -65(x19)
    # Check results:  mem[test_28_res+8] = 0x0000000000000020
    ld x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000020)

    # Clear memory
    sd      x0, 16(x6)
    # Load values and compute offsets
    li      x3, 0x40
    addi    x18, x6,16
    li     x7, MASK_XLEN(33)
    add    x18, x18, x7
    # Test Instruction 
    sd      x3, -33(x18)
    # Check results:  mem[test_28_res+16] = 0x0000000000000040
    ld x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000040)

    # Clear memory
    sd      x0, 24(x6)
    # Load values and compute offsets
    li      x2, 0x80
    addi    x17, x6,24
    li     x7, MASK_XLEN(17)
    add    x17, x17, x7
    # Test Instruction 
    sd      x2, -17(x17)
    # Check results:  mem[test_28_res+24] = 0x0000000000000080
    ld x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000080)

    # Clear memory
    sd      x0, 32(x6)
    # Load values and compute offsets
    li      x1, 0x100
    addi    x16, x6,32
    li     x7, MASK_XLEN(9)
    add    x16, x16, x7
    # Test Instruction 
    sd      x1, -9(x16)
    # Check results:  mem[test_28_res+32] = 0x0000000000000100
    ld x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000000100)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # Addresses for test results
    la x1, test_29_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x31, 0x200
    addi    x15, x1,0
    li     x2, MASK_XLEN(5)
    add    x15, x15, x2
    # Test Instruction 
    sd      x31, -5(x15)
    # Check results:  mem[test_29_res+0] = 0x0000000000000200
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000200)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x30, 0x400
    addi    x14, x1,8
    li     x2, MASK_XLEN(3)
    add    x14, x14, x2
    # Test Instruction 
    sd      x30, -3(x14)
    # Check results:  mem[test_29_res+8] = 0x0000000000000400
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000400)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x29, 0x800
    addi    x13, x1,16
    li     x2, MASK_XLEN(2)
    add    x13, x13, x2
    # Test Instruction 
    sd      x29, -2(x13)
    # Check results:  mem[test_29_res+16] = 0x0000000000000800
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000800)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x28, 0x1000
    addi    x12, x1,24
    li     x2, MASK_XLEN(0)
    add    x12, x12, x2
    # Test Instruction 
    sd      x28, 0(x12)
    # Check results:  mem[test_29_res+24] = 0x0000000000001000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000001000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x27, 0x2000
    addi    x11, x1,32
    li     x2, MASK_XLEN(2048)
    add    x11, x11, x2
    # Test Instruction 
    sd      x27, -2048(x11)
    # Check results:  mem[test_29_res+32] = 0x0000000000002000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000002000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # Addresses for test results
    la x1, test_30_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x26, 0x4000
    addi    x10, x1,0
    li     x2, MASK_XLEN(-1024)
    add    x10, x10, x2
    # Test Instruction 
    sd      x26, 1024(x10)
    # Check results:  mem[test_30_res+0] = 0x0000000000004000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000004000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x25, 0x8000
    addi    x9, x1,8
    li     x2, MASK_XLEN(-512)
    add    x9, x9, x2
    # Test Instruction 
    sd      x25, 512(x9)
    # Check results:  mem[test_30_res+8] = 0x0000000000008000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000008000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x24, 0x10000
    addi    x8, x1,16
    li     x2, MASK_XLEN(-256)
    add    x8, x8, x2
    # Test Instruction 
    sd      x24, 256(x8)
    # Check results:  mem[test_30_res+16] = 0x0000000000010000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000010000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x23, 0x20000
    addi    x7, x1,24
    li     x2, MASK_XLEN(-128)
    add    x7, x7, x2
    # Test Instruction 
    sd      x23, 128(x7)
    # Check results:  mem[test_30_res+24] = 0x0000000000020000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000020000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x22, 0x40000
    addi    x6, x1,32
    li     x2, MASK_XLEN(-64)
    add    x6, x6, x2
    # Test Instruction 
    sd      x22, 64(x6)
    # Check results:  mem[test_30_res+32] = 0x0000000000040000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000040000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # Addresses for test results
    la x6, test_31_res

    # Clear memory
    sd      x0, 0(x6)
    # Load values and compute offsets
    li      x21, 0x80000
    addi    x5, x6,0
    li     x7, MASK_XLEN(-32)
    add    x5, x5, x7
    # Test Instruction 
    sd      x21, 32(x5)
    # Check results:  mem[test_31_res+0] = 0x0000000000080000
    ld x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000080000)

    # Clear memory
    sd      x0, 8(x6)
    # Load values and compute offsets
    li      x20, 0x100000
    addi    x4, x6,8
    li     x7, MASK_XLEN(-16)
    add    x4, x4, x7
    # Test Instruction 
    sd      x20, 16(x4)
    # Check results:  mem[test_31_res+8] = 0x0000000000100000
    ld x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000100000)

    # Clear memory
    sd      x0, 16(x6)
    # Load values and compute offsets
    li      x19, 0x200000
    addi    x3, x6,16
    li     x7, MASK_XLEN(-8)
    add    x3, x3, x7
    # Test Instruction 
    sd      x19, 8(x3)
    # Check results:  mem[test_31_res+16] = 0x0000000000200000
    ld x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000200000)

    # Clear memory
    sd      x0, 24(x6)
    # Load values and compute offsets
    li      x18, 0x400000
    addi    x2, x6,24
    li     x7, MASK_XLEN(-4)
    add    x2, x2, x7
    # Test Instruction 
    sd      x18, 4(x2)
    # Check results:  mem[test_31_res+24] = 0x0000000000400000
    ld x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000400000)

    # Clear memory
    sd      x0, 32(x6)
    # Load values and compute offsets
    li      x17, 0x800000
    addi    x1, x6,32
    li     x7, MASK_XLEN(-2)
    add    x1, x1, x7
    # Test Instruction 
    sd      x17, 2(x1)
    # Check results:  mem[test_31_res+32] = 0x0000000000800000
    ld x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000000800000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # Addresses for test results
    la x6, test_32_res

    # Clear memory
    sd      x0, 0(x6)
    # Load values and compute offsets
    li      x16, 0x1000000
    addi    x31, x6,0
    li     x7, MASK_XLEN(-1)
    add    x31, x31, x7
    # Test Instruction 
    sd      x16, 1(x31)
    # Check results:  mem[test_32_res+0] = 0x0000000001000000
    ld x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000001000000)

    # Clear memory
    sd      x0, 8(x6)
    # Load values and compute offsets
    li      x15, 0x2000000
    addi    x30, x6,8
    li     x7, MASK_XLEN(1)
    add    x30, x30, x7
    # Test Instruction 
    sd      x15, -1(x30)
    # Check results:  mem[test_32_res+8] = 0x0000000002000000
    ld x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000002000000)

    # Clear memory
    sd      x0, 16(x6)
    # Load values and compute offsets
    li      x14, 0x4000000
    addi    x29, x6,16
    li     x7, MASK_XLEN(-2047)
    add    x29, x29, x7
    # Test Instruction 
    sd      x14, 2047(x29)
    # Check results:  mem[test_32_res+16] = 0x0000000004000000
    ld x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000004000000)

    # Clear memory
    sd      x0, 24(x6)
    # Load values and compute offsets
    li      x13, 0x8000000
    addi    x28, x6,24
    li     x7, MASK_XLEN(1025)
    add    x28, x28, x7
    # Test Instruction 
    sd      x13, -1025(x28)
    # Check results:  mem[test_32_res+24] = 0x0000000008000000
    ld x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000008000000)

    # Clear memory
    sd      x0, 32(x6)
    # Load values and compute offsets
    li      x12, 0x10000000
    addi    x27, x6,32
    li     x7, MASK_XLEN(513)
    add    x27, x27, x7
    # Test Instruction 
    sd      x12, -513(x27)
    # Check results:  mem[test_32_res+32] = 0x0000000010000000
    ld x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000010000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # Addresses for test results
    la x1, test_33_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x20000000
    addi    x26, x1,0
    li     x2, MASK_XLEN(257)
    add    x26, x26, x2
    # Test Instruction 
    sd      x11, -257(x26)
    # Check results:  mem[test_33_res+0] = 0x0000000020000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000020000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x40000000
    addi    x25, x1,8
    li     x2, MASK_XLEN(129)
    add    x25, x25, x2
    # Test Instruction 
    sd      x10, -129(x25)
    # Check results:  mem[test_33_res+8] = 0x0000000040000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000040000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x80000000
    addi    x24, x1,16
    li     x2, MASK_XLEN(65)
    add    x24, x24, x2
    # Test Instruction 
    sd      x9, -65(x24)
    # Check results:  mem[test_33_res+16] = 0x0000000080000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000080000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x8, 0x100000000
    addi    x23, x1,24
    li     x2, MASK_XLEN(33)
    add    x23, x23, x2
    # Test Instruction 
    sd      x8, -33(x23)
    # Check results:  mem[test_33_res+24] = 0x0000000100000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000100000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x7, 0x200000000
    addi    x22, x1,32
    li     x2, MASK_XLEN(17)
    add    x22, x22, x2
    # Test Instruction 
    sd      x7, -17(x22)
    # Check results:  mem[test_33_res+32] = 0x0000000200000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000200000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # Addresses for test results
    la x1, test_34_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x6, 0x400000000
    addi    x21, x1,0
    li     x7, MASK_XLEN(9)
    add    x21, x21, x7
    # Test Instruction 
    sd      x6, -9(x21)
    # Check results:  mem[test_34_res+0] = 0x0000000400000000
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000400000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x5, 0x800000000
    addi    x20, x1,8
    li     x7, MASK_XLEN(5)
    add    x20, x20, x7
    # Test Instruction 
    sd      x5, -5(x20)
    # Check results:  mem[test_34_res+8] = 0x0000000800000000
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000000800000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x4, 0x1000000000
    addi    x19, x1,16
    li     x7, MASK_XLEN(3)
    add    x19, x19, x7
    # Test Instruction 
    sd      x4, -3(x19)
    # Check results:  mem[test_34_res+16] = 0x0000001000000000
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000001000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x3, 0x2000000000
    addi    x18, x1,24
    li     x7, MASK_XLEN(2)
    add    x18, x18, x7
    # Test Instruction 
    sd      x3, -2(x18)
    # Check results:  mem[test_34_res+24] = 0x0000002000000000
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000002000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x2, 0x4000000000
    addi    x17, x1,32
    li     x7, MASK_XLEN(0)
    add    x17, x17, x7
    # Test Instruction 
    sd      x2, 0(x17)
    # Check results:  mem[test_34_res+32] = 0x0000004000000000
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000004000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # Addresses for test results
    la x2, test_35_res

    # Clear memory
    sd      x0, 0(x2)
    # Load values and compute offsets
    li      x1, 0x8000000000
    addi    x16, x2,0
    li     x3, MASK_XLEN(2048)
    add    x16, x16, x3
    # Test Instruction 
    sd      x1, -2048(x16)
    # Check results:  mem[test_35_res+0] = 0x0000008000000000
    ld x4, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000008000000000)

    # Clear memory
    sd      x0, 8(x2)
    # Load values and compute offsets
    li      x31, 0x10000000000
    addi    x15, x2,8
    li     x3, MASK_XLEN(-1024)
    add    x15, x15, x3
    # Test Instruction 
    sd      x31, 1024(x15)
    # Check results:  mem[test_35_res+8] = 0x0000010000000000
    ld x4, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000010000000000)

    # Clear memory
    sd      x0, 16(x2)
    # Load values and compute offsets
    li      x30, 0x20000000000
    addi    x14, x2,16
    li     x3, MASK_XLEN(-512)
    add    x14, x14, x3
    # Test Instruction 
    sd      x30, 512(x14)
    # Check results:  mem[test_35_res+16] = 0x0000020000000000
    ld x4, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000020000000000)

    # Clear memory
    sd      x0, 24(x2)
    # Load values and compute offsets
    li      x29, 0x40000000000
    addi    x13, x2,24
    li     x3, MASK_XLEN(-256)
    add    x13, x13, x3
    # Test Instruction 
    sd      x29, 256(x13)
    # Check results:  mem[test_35_res+24] = 0x0000040000000000
    ld x4, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000040000000000)

    # Clear memory
    sd      x0, 32(x2)
    # Load values and compute offsets
    li      x28, 0x80000000000
    addi    x12, x2,32
    li     x3, MASK_XLEN(-128)
    add    x12, x12, x3
    # Test Instruction 
    sd      x28, 128(x12)
    # Check results:  mem[test_35_res+32] = 0x0000080000000000
    ld x4, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000080000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # Addresses for test results
    la x1, test_36_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x27, 0x100000000000
    addi    x11, x1,0
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    # Test Instruction 
    sd      x27, 64(x11)
    # Check results:  mem[test_36_res+0] = 0x0000100000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000100000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x26, 0x200000000000
    addi    x10, x1,8
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    # Test Instruction 
    sd      x26, 32(x10)
    # Check results:  mem[test_36_res+8] = 0x0000200000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000200000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x25, 0x400000000000
    addi    x9, x1,16
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    # Test Instruction 
    sd      x25, 16(x9)
    # Check results:  mem[test_36_res+16] = 0x0000400000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000400000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x24, 0x800000000000
    addi    x8, x1,24
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    # Test Instruction 
    sd      x24, 8(x8)
    # Check results:  mem[test_36_res+24] = 0x0000800000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000800000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x23, 0x1000000000000
    addi    x7, x1,32
    li     x2, MASK_XLEN(-4)
    add    x7, x7, x2
    # Test Instruction 
    sd      x23, 4(x7)
    # Check results:  mem[test_36_res+32] = 0x0001000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0001000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # Addresses for test results
    la x1, test_37_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x22, 0x2000000000000
    addi    x6, x1,0
    li     x7, MASK_XLEN(-2)
    add    x6, x6, x7
    # Test Instruction 
    sd      x22, 2(x6)
    # Check results:  mem[test_37_res+0] = 0x0002000000000000
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0002000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x21, 0x4000000000000
    addi    x5, x1,8
    li     x7, MASK_XLEN(-1)
    add    x5, x5, x7
    # Test Instruction 
    sd      x21, 1(x5)
    # Check results:  mem[test_37_res+8] = 0x0004000000000000
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0004000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x20, 0x8000000000000
    addi    x4, x1,16
    li     x7, MASK_XLEN(1)
    add    x4, x4, x7
    # Test Instruction 
    sd      x20, -1(x4)
    # Check results:  mem[test_37_res+16] = 0x0008000000000000
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0008000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x19, 0x10000000000000
    addi    x3, x1,24
    li     x7, MASK_XLEN(-2047)
    add    x3, x3, x7
    # Test Instruction 
    sd      x19, 2047(x3)
    # Check results:  mem[test_37_res+24] = 0x0010000000000000
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0010000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x18, 0x20000000000000
    addi    x2, x1,32
    li     x7, MASK_XLEN(1025)
    add    x2, x2, x7
    # Test Instruction 
    sd      x18, -1025(x2)
    # Check results:  mem[test_37_res+32] = 0x0020000000000000
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0020000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # Addresses for test results
    la x5, test_38_res

    # Clear memory
    sd      x0, 0(x5)
    # Load values and compute offsets
    li      x17, 0x40000000000000
    addi    x1, x5,0
    li     x6, MASK_XLEN(513)
    add    x1, x1, x6
    # Test Instruction 
    sd      x17, -513(x1)
    # Check results:  mem[test_38_res+0] = 0x0040000000000000
    ld x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0040000000000000)

    # Clear memory
    sd      x0, 8(x5)
    # Load values and compute offsets
    li      x16, 0x80000000000000
    addi    x31, x5,8
    li     x6, MASK_XLEN(257)
    add    x31, x31, x6
    # Test Instruction 
    sd      x16, -257(x31)
    # Check results:  mem[test_38_res+8] = 0x0080000000000000
    ld x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0080000000000000)

    # Clear memory
    sd      x0, 16(x5)
    # Load values and compute offsets
    li      x15, 0x100000000000000
    addi    x30, x5,16
    li     x6, MASK_XLEN(129)
    add    x30, x30, x6
    # Test Instruction 
    sd      x15, -129(x30)
    # Check results:  mem[test_38_res+16] = 0x0100000000000000
    ld x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0100000000000000)

    # Clear memory
    sd      x0, 24(x5)
    # Load values and compute offsets
    li      x14, 0x200000000000000
    addi    x29, x5,24
    li     x6, MASK_XLEN(65)
    add    x29, x29, x6
    # Test Instruction 
    sd      x14, -65(x29)
    # Check results:  mem[test_38_res+24] = 0x0200000000000000
    ld x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0200000000000000)

    # Clear memory
    sd      x0, 32(x5)
    # Load values and compute offsets
    li      x13, 0x400000000000000
    addi    x28, x5,32
    li     x6, MASK_XLEN(33)
    add    x28, x28, x6
    # Test Instruction 
    sd      x13, -33(x28)
    # Check results:  mem[test_38_res+32] = 0x0400000000000000
    ld x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0400000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # Addresses for test results
    la x1, test_39_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x800000000000000
    addi    x27, x1,0
    li     x2, MASK_XLEN(17)
    add    x27, x27, x2
    # Test Instruction 
    sd      x12, -17(x27)
    # Check results:  mem[test_39_res+0] = 0x0800000000000000
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0800000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x1000000000000000
    addi    x26, x1,8
    li     x2, MASK_XLEN(9)
    add    x26, x26, x2
    # Test Instruction 
    sd      x11, -9(x26)
    # Check results:  mem[test_39_res+8] = 0x1000000000000000
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x1000000000000000)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x2000000000000000
    addi    x25, x1,16
    li     x2, MASK_XLEN(5)
    add    x25, x25, x2
    # Test Instruction 
    sd      x10, -5(x25)
    # Check results:  mem[test_39_res+16] = 0x2000000000000000
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x2000000000000000)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x9, 0x4000000000000000
    addi    x24, x1,24
    li     x2, MASK_XLEN(3)
    add    x24, x24, x2
    # Test Instruction 
    sd      x9, -3(x24)
    # Check results:  mem[test_39_res+24] = 0x4000000000000000
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x4000000000000000)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x8, 0x8000000000000000
    addi    x23, x1,32
    li     x2, MASK_XLEN(2)
    add    x23, x23, x2
    # Test Instruction 
    sd      x8, -2(x23)
    # Check results:  mem[test_39_res+32] = 0x8000000000000000
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x8000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # Addresses for test results
    la x1, test_40_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x22, x1,0
    li     x2, MASK_XLEN(0)
    add    x22, x22, x2
    # Test Instruction 
    sd      x7, 0(x22)
    # Check results:  mem[test_40_res+0] = 0x0000000000000000
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x6, 0xfffffffffffffffe
    addi    x21, x1,8
    li     x2, MASK_XLEN(2048)
    add    x21, x21, x2
    # Test Instruction 
    sd      x6, -2048(x21)
    # Check results:  mem[test_40_res+8] = 0xfffffffffffffffe
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffffffe)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x5, 0xfffffffffffffffd
    addi    x20, x1,16
    li     x2, MASK_XLEN(-1024)
    add    x20, x20, x2
    # Test Instruction 
    sd      x5, 1024(x20)
    # Check results:  mem[test_40_res+16] = 0xfffffffffffffffd
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffffffd)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x4, 0xfffffffffffffffb
    addi    x19, x1,24
    li     x2, MASK_XLEN(-512)
    add    x19, x19, x2
    # Test Instruction 
    sd      x4, 512(x19)
    # Check results:  mem[test_40_res+24] = 0xfffffffffffffffb
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffffffb)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x3, 0xfffffffffffffff7
    addi    x18, x1,32
    li     x2, MASK_XLEN(-256)
    add    x18, x18, x2
    # Test Instruction 
    sd      x3, 256(x18)
    # Check results:  mem[test_40_res+32] = 0xfffffffffffffff7
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffffff7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # Addresses for test results
    la x3, test_41_res

    # Clear memory
    sd      x0, 0(x3)
    # Load values and compute offsets
    li      x2, 0xffffffffffffffef
    addi    x17, x3,0
    li     x4, MASK_XLEN(-128)
    add    x17, x17, x4
    # Test Instruction 
    sd      x2, 128(x17)
    # Check results:  mem[test_41_res+0] = 0xffffffffffffffef
    ld x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffffffffffffffef)

    # Clear memory
    sd      x0, 8(x3)
    # Load values and compute offsets
    li      x1, 0xffffffffffffffdf
    addi    x16, x3,8
    li     x4, MASK_XLEN(-64)
    add    x16, x16, x4
    # Test Instruction 
    sd      x1, 64(x16)
    # Check results:  mem[test_41_res+8] = 0xffffffffffffffdf
    ld x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffffffffffffffdf)

    # Clear memory
    sd      x0, 16(x3)
    # Load values and compute offsets
    li      x31, 0xffffffffffffffbf
    addi    x15, x3,16
    li     x4, MASK_XLEN(-32)
    add    x15, x15, x4
    # Test Instruction 
    sd      x31, 32(x15)
    # Check results:  mem[test_41_res+16] = 0xffffffffffffffbf
    ld x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffffffffffffffbf)

    # Clear memory
    sd      x0, 24(x3)
    # Load values and compute offsets
    li      x30, 0xffffffffffffff7f
    addi    x14, x3,24
    li     x4, MASK_XLEN(-16)
    add    x14, x14, x4
    # Test Instruction 
    sd      x30, 16(x14)
    # Check results:  mem[test_41_res+24] = 0xffffffffffffff7f
    ld x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xffffffffffffff7f)

    # Clear memory
    sd      x0, 32(x3)
    # Load values and compute offsets
    li      x29, 0xfffffffffffffeff
    addi    x13, x3,32
    li     x4, MASK_XLEN(-8)
    add    x13, x13, x4
    # Test Instruction 
    sd      x29, 8(x13)
    # Check results:  mem[test_41_res+32] = 0xfffffffffffffeff
    ld x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xfffffffffffffeff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # Addresses for test results
    la x1, test_42_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x28, 0xfffffffffffffdff
    addi    x12, x1,0
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    # Test Instruction 
    sd      x28, 4(x12)
    # Check results:  mem[test_42_res+0] = 0xfffffffffffffdff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffffffffdff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x27, 0xfffffffffffffbff
    addi    x11, x1,8
    li     x2, MASK_XLEN(-2)
    add    x11, x11, x2
    # Test Instruction 
    sd      x27, 2(x11)
    # Check results:  mem[test_42_res+8] = 0xfffffffffffffbff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffffffffbff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x26, 0xfffffffffffff7ff
    addi    x10, x1,16
    li     x2, MASK_XLEN(-1)
    add    x10, x10, x2
    # Test Instruction 
    sd      x26, 1(x10)
    # Check results:  mem[test_42_res+16] = 0xfffffffffffff7ff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffffffff7ff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x25, 0xffffffffffffefff
    addi    x9, x1,24
    li     x2, MASK_XLEN(1)
    add    x9, x9, x2
    # Test Instruction 
    sd      x25, -1(x9)
    # Check results:  mem[test_42_res+24] = 0xffffffffffffefff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffffffffefff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x24, 0xffffffffffffdfff
    addi    x8, x1,32
    li     x2, MASK_XLEN(-2047)
    add    x8, x8, x2
    # Test Instruction 
    sd      x24, 2047(x8)
    # Check results:  mem[test_42_res+32] = 0xffffffffffffdfff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffffffffdfff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # Addresses for test results
    la x1, test_43_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x23, 0xffffffffffffbfff
    addi    x7, x1,0
    li     x2, MASK_XLEN(1025)
    add    x7, x7, x2
    # Test Instruction 
    sd      x23, -1025(x7)
    # Check results:  mem[test_43_res+0] = 0xffffffffffffbfff
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffffffbfff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0xffffffffffff7fff
    addi    x6, x1,8
    li     x2, MASK_XLEN(513)
    add    x6, x6, x2
    # Test Instruction 
    sd      x22, -513(x6)
    # Check results:  mem[test_43_res+8] = 0xffffffffffff7fff
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffffff7fff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x21, 0xfffffffffffeffff
    addi    x5, x1,16
    li     x2, MASK_XLEN(257)
    add    x5, x5, x2
    # Test Instruction 
    sd      x21, -257(x5)
    # Check results:  mem[test_43_res+16] = 0xfffffffffffeffff
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffeffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x20, 0xfffffffffffdffff
    addi    x4, x1,24
    li     x2, MASK_XLEN(129)
    add    x4, x4, x2
    # Test Instruction 
    sd      x20, -129(x4)
    # Check results:  mem[test_43_res+24] = 0xfffffffffffdffff
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffdffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x19, 0xfffffffffffbffff
    addi    x3, x1,32
    li     x2, MASK_XLEN(65)
    add    x3, x3, x2
    # Test Instruction 
    sd      x19, -65(x3)
    # Check results:  mem[test_43_res+32] = 0xfffffffffffbffff
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffbffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # Addresses for test results
    la x4, test_44_res

    # Clear memory
    sd      x0, 0(x4)
    # Load values and compute offsets
    li      x18, 0xfffffffffff7ffff
    addi    x2, x4,0
    li     x5, MASK_XLEN(33)
    add    x2, x2, x5
    # Test Instruction 
    sd      x18, -33(x2)
    # Check results:  mem[test_44_res+0] = 0xfffffffffff7ffff
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xfffffffffff7ffff)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x17, 0xffffffffffefffff
    addi    x1, x4,8
    li     x5, MASK_XLEN(17)
    add    x1, x1, x5
    # Test Instruction 
    sd      x17, -17(x1)
    # Check results:  mem[test_44_res+8] = 0xffffffffffefffff
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffffffefffff)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x16, 0xffffffffffdfffff
    addi    x31, x4,16
    li     x5, MASK_XLEN(9)
    add    x31, x31, x5
    # Test Instruction 
    sd      x16, -9(x31)
    # Check results:  mem[test_44_res+16] = 0xffffffffffdfffff
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffffffdfffff)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x15, 0xffffffffffbfffff
    addi    x30, x4,24
    li     x5, MASK_XLEN(5)
    add    x30, x30, x5
    # Test Instruction 
    sd      x15, -5(x30)
    # Check results:  mem[test_44_res+24] = 0xffffffffffbfffff
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffffffbfffff)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x14, 0xffffffffff7fffff
    addi    x29, x4,32
    li     x5, MASK_XLEN(3)
    add    x29, x29, x5
    # Test Instruction 
    sd      x14, -3(x29)
    # Check results:  mem[test_44_res+32] = 0xffffffffff7fffff
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffffff7fffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # Addresses for test results
    la x1, test_45_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0xfffffffffeffffff
    addi    x28, x1,0
    li     x2, MASK_XLEN(2)
    add    x28, x28, x2
    # Test Instruction 
    sd      x13, -2(x28)
    # Check results:  mem[test_45_res+0] = 0xfffffffffeffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffffeffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0xfffffffffdffffff
    addi    x27, x1,8
    li     x2, MASK_XLEN(0)
    add    x27, x27, x2
    # Test Instruction 
    sd      x12, 0(x27)
    # Check results:  mem[test_45_res+8] = 0xfffffffffdffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffffdffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0xfffffffffbffffff
    addi    x26, x1,16
    li     x2, MASK_XLEN(2048)
    add    x26, x26, x2
    # Test Instruction 
    sd      x11, -2048(x26)
    # Check results:  mem[test_45_res+16] = 0xfffffffffbffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffffbffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x10, 0xfffffffff7ffffff
    addi    x25, x1,24
    li     x2, MASK_XLEN(-1024)
    add    x25, x25, x2
    # Test Instruction 
    sd      x10, 1024(x25)
    # Check results:  mem[test_45_res+24] = 0xfffffffff7ffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffff7ffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x9, 0xffffffffefffffff
    addi    x24, x1,32
    li     x2, MASK_XLEN(-512)
    add    x24, x24, x2
    # Test Instruction 
    sd      x9, 512(x24)
    # Check results:  mem[test_45_res+32] = 0xffffffffefffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffffefffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # Addresses for test results
    la x1, test_46_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0xffffffffdfffffff
    addi    x23, x1,0
    li     x2, MASK_XLEN(-256)
    add    x23, x23, x2
    # Test Instruction 
    sd      x8, 256(x23)
    # Check results:  mem[test_46_res+0] = 0xffffffffdfffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffffdfffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0xffffffffbfffffff
    addi    x22, x1,8
    li     x2, MASK_XLEN(-128)
    add    x22, x22, x2
    # Test Instruction 
    sd      x7, 128(x22)
    # Check results:  mem[test_46_res+8] = 0xffffffffbfffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffffbfffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x6, 0xffffffff7fffffff
    addi    x21, x1,16
    li     x2, MASK_XLEN(-64)
    add    x21, x21, x2
    # Test Instruction 
    sd      x6, 64(x21)
    # Check results:  mem[test_46_res+16] = 0xffffffff7fffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffff7fffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x5, 0xfffffffeffffffff
    addi    x20, x1,24
    li     x2, MASK_XLEN(-32)
    add    x20, x20, x2
    # Test Instruction 
    sd      x5, 32(x20)
    # Check results:  mem[test_46_res+24] = 0xfffffffeffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffeffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x4, 0xfffffffdffffffff
    addi    x19, x1,32
    li     x2, MASK_XLEN(-16)
    add    x19, x19, x2
    # Test Instruction 
    sd      x4, 16(x19)
    # Check results:  mem[test_46_res+32] = 0xfffffffdffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffdffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # Addresses for test results
    la x4, test_47_res

    # Clear memory
    sd      x0, 0(x4)
    # Load values and compute offsets
    li      x3, 0xfffffffbffffffff
    addi    x18, x4,0
    li     x5, MASK_XLEN(-8)
    add    x18, x18, x5
    # Test Instruction 
    sd      x3, 8(x18)
    # Check results:  mem[test_47_res+0] = 0xfffffffbffffffff
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xfffffffbffffffff)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x2, 0xfffffff7ffffffff
    addi    x17, x4,8
    li     x5, MASK_XLEN(-4)
    add    x17, x17, x5
    # Test Instruction 
    sd      x2, 4(x17)
    # Check results:  mem[test_47_res+8] = 0xfffffff7ffffffff
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xfffffff7ffffffff)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x1, 0xffffffefffffffff
    addi    x16, x4,16
    li     x5, MASK_XLEN(-2)
    add    x16, x16, x5
    # Test Instruction 
    sd      x1, 2(x16)
    # Check results:  mem[test_47_res+16] = 0xffffffefffffffff
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffefffffffff)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x31, 0xffffffdfffffffff
    addi    x15, x4,24
    li     x5, MASK_XLEN(-1)
    add    x15, x15, x5
    # Test Instruction 
    sd      x31, 1(x15)
    # Check results:  mem[test_47_res+24] = 0xffffffdfffffffff
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffdfffffffff)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x30, 0xffffffbfffffffff
    addi    x14, x4,32
    li     x5, MASK_XLEN(1)
    add    x14, x14, x5
    # Test Instruction 
    sd      x30, -1(x14)
    # Check results:  mem[test_47_res+32] = 0xffffffbfffffffff
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffbfffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # Addresses for test results
    la x1, test_48_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x29, 0xffffff7fffffffff
    addi    x13, x1,0
    li     x2, MASK_XLEN(-2047)
    add    x13, x13, x2
    # Test Instruction 
    sd      x29, 2047(x13)
    # Check results:  mem[test_48_res+0] = 0xffffff7fffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffff7fffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0xfffffeffffffffff
    addi    x12, x1,8
    li     x2, MASK_XLEN(1025)
    add    x12, x12, x2
    # Test Instruction 
    sd      x28, -1025(x12)
    # Check results:  mem[test_48_res+8] = 0xfffffeffffffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffeffffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x27, 0xfffffdffffffffff
    addi    x11, x1,16
    li     x2, MASK_XLEN(513)
    add    x11, x11, x2
    # Test Instruction 
    sd      x27, -513(x11)
    # Check results:  mem[test_48_res+16] = 0xfffffdffffffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffdffffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x26, 0xfffffbffffffffff
    addi    x10, x1,24
    li     x2, MASK_XLEN(257)
    add    x10, x10, x2
    # Test Instruction 
    sd      x26, -257(x10)
    # Check results:  mem[test_48_res+24] = 0xfffffbffffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffbffffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x25, 0xfffff7ffffffffff
    addi    x9, x1,32
    li     x2, MASK_XLEN(129)
    add    x9, x9, x2
    # Test Instruction 
    sd      x25, -129(x9)
    # Check results:  mem[test_48_res+32] = 0xfffff7ffffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffff7ffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # Addresses for test results
    la x1, test_49_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x24, 0xffffefffffffffff
    addi    x8, x1,0
    li     x2, MASK_XLEN(65)
    add    x8, x8, x2
    # Test Instruction 
    sd      x24, -65(x8)
    # Check results:  mem[test_49_res+0] = 0xffffefffffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffefffffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x23, 0xffffdfffffffffff
    addi    x7, x1,8
    li     x2, MASK_XLEN(33)
    add    x7, x7, x2
    # Test Instruction 
    sd      x23, -33(x7)
    # Check results:  mem[test_49_res+8] = 0xffffdfffffffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffdfffffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x22, 0xffffbfffffffffff
    addi    x6, x1,16
    li     x2, MASK_XLEN(17)
    add    x6, x6, x2
    # Test Instruction 
    sd      x22, -17(x6)
    # Check results:  mem[test_49_res+16] = 0xffffbfffffffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffbfffffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x21, 0xffff7fffffffffff
    addi    x5, x1,24
    li     x2, MASK_XLEN(9)
    add    x5, x5, x2
    # Test Instruction 
    sd      x21, -9(x5)
    # Check results:  mem[test_49_res+24] = 0xffff7fffffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffff7fffffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x20, 0xfffeffffffffffff
    addi    x4, x1,32
    li     x2, MASK_XLEN(5)
    add    x4, x4, x2
    # Test Instruction 
    sd      x20, -5(x4)
    # Check results:  mem[test_49_res+32] = 0xfffeffffffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffeffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # Addresses for test results
    la x4, test_50_res

    # Clear memory
    sd      x0, 0(x4)
    # Load values and compute offsets
    li      x19, 0xfffdffffffffffff
    addi    x3, x4,0
    li     x5, MASK_XLEN(3)
    add    x3, x3, x5
    # Test Instruction 
    sd      x19, -3(x3)
    # Check results:  mem[test_50_res+0] = 0xfffdffffffffffff
    ld x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xfffdffffffffffff)

    # Clear memory
    sd      x0, 8(x4)
    # Load values and compute offsets
    li      x18, 0xfffbffffffffffff
    addi    x2, x4,8
    li     x5, MASK_XLEN(2)
    add    x2, x2, x5
    # Test Instruction 
    sd      x18, -2(x2)
    # Check results:  mem[test_50_res+8] = 0xfffbffffffffffff
    ld x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xfffbffffffffffff)

    # Clear memory
    sd      x0, 16(x4)
    # Load values and compute offsets
    li      x17, 0xfff7ffffffffffff
    addi    x1, x4,16
    li     x5, MASK_XLEN(0)
    add    x1, x1, x5
    # Test Instruction 
    sd      x17, 0(x1)
    # Check results:  mem[test_50_res+16] = 0xfff7ffffffffffff
    ld x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xfff7ffffffffffff)

    # Clear memory
    sd      x0, 24(x4)
    # Load values and compute offsets
    li      x16, 0xffefffffffffffff
    addi    x31, x4,24
    li     x5, MASK_XLEN(2048)
    add    x31, x31, x5
    # Test Instruction 
    sd      x16, -2048(x31)
    # Check results:  mem[test_50_res+24] = 0xffefffffffffffff
    ld x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffefffffffffffff)

    # Clear memory
    sd      x0, 32(x4)
    # Load values and compute offsets
    li      x15, 0xffdfffffffffffff
    addi    x30, x4,32
    li     x5, MASK_XLEN(-1024)
    add    x30, x30, x5
    # Test Instruction 
    sd      x15, 1024(x30)
    # Check results:  mem[test_50_res+32] = 0xffdfffffffffffff
    ld x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffdfffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # Addresses for test results
    la x1, test_51_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0xffbfffffffffffff
    addi    x29, x1,0
    li     x2, MASK_XLEN(-512)
    add    x29, x29, x2
    # Test Instruction 
    sd      x14, 512(x29)
    # Check results:  mem[test_51_res+0] = 0xffbfffffffffffff
    ld x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffbfffffffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0xff7fffffffffffff
    addi    x28, x1,8
    li     x2, MASK_XLEN(-256)
    add    x28, x28, x2
    # Test Instruction 
    sd      x13, 256(x28)
    # Check results:  mem[test_51_res+8] = 0xff7fffffffffffff
    ld x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xff7fffffffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x12, 0xfeffffffffffffff
    addi    x27, x1,16
    li     x2, MASK_XLEN(-128)
    add    x27, x27, x2
    # Test Instruction 
    sd      x12, 128(x27)
    # Check results:  mem[test_51_res+16] = 0xfeffffffffffffff
    ld x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfeffffffffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x11, 0xfdffffffffffffff
    addi    x26, x1,24
    li     x2, MASK_XLEN(-64)
    add    x26, x26, x2
    # Test Instruction 
    sd      x11, 64(x26)
    # Check results:  mem[test_51_res+24] = 0xfdffffffffffffff
    ld x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfdffffffffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x10, 0xfbffffffffffffff
    addi    x25, x1,32
    li     x2, MASK_XLEN(-32)
    add    x25, x25, x2
    # Test Instruction 
    sd      x10, 32(x25)
    # Check results:  mem[test_51_res+32] = 0xfbffffffffffffff
    ld x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfbffffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # Addresses for test results
    la x1, test_52_res

    # Clear memory
    sd      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0xf7ffffffffffffff
    addi    x24, x1,0
    li     x2, MASK_XLEN(-16)
    add    x24, x24, x2
    # Test Instruction 
    sd      x9, 16(x24)
    # Check results:  mem[test_52_res+0] = 0xf7ffffffffffffff
    ld x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xf7ffffffffffffff)

    # Clear memory
    sd      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0xefffffffffffffff
    addi    x23, x1,8
    li     x2, MASK_XLEN(-8)
    add    x23, x23, x2
    # Test Instruction 
    sd      x8, 8(x23)
    # Check results:  mem[test_52_res+8] = 0xefffffffffffffff
    ld x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xefffffffffffffff)

    # Clear memory
    sd      x0, 16(x1)
    # Load values and compute offsets
    li      x7, 0xdfffffffffffffff
    addi    x22, x1,16
    li     x2, MASK_XLEN(-4)
    add    x22, x22, x2
    # Test Instruction 
    sd      x7, 4(x22)
    # Check results:  mem[test_52_res+16] = 0xdfffffffffffffff
    ld x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xdfffffffffffffff)

    # Clear memory
    sd      x0, 24(x1)
    # Load values and compute offsets
    li      x6, 0xbfffffffffffffff
    addi    x21, x1,24
    li     x2, MASK_XLEN(-2)
    add    x21, x21, x2
    # Test Instruction 
    sd      x6, 2(x21)
    # Check results:  mem[test_52_res+24] = 0xbfffffffffffffff
    ld x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xbfffffffffffffff)

    # Clear memory
    sd      x0, 32(x1)
    # Load values and compute offsets
    li      x5, 0x7fffffffffffffff
    addi    x20, x1,32
    li     x2, MASK_XLEN(-1)
    add    x20, x20, x2
    # Test Instruction 
    sd      x5, 1(x20)
    # Check results:  mem[test_52_res+32] = 0x7fffffffffffffff
    ld x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x7fffffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # Addresses for test results
    la x2, test_53_res

    # Clear memory
    sd      x0, 0(x2)
    # Load values and compute offsets
    li      x4, 0xffffffffffffffff
    addi    x19, x2,0
    li     x5, MASK_XLEN(1)
    add    x19, x19, x5
    # Test Instruction 
    sd      x4, -1(x19)
    # Check results:  mem[test_53_res+0] = 0xffffffffffffffff
    ld x6, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xffffffffffffffff)

    # Clear memory
    sd      x0, 8(x2)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x18, x2,8
    li     x5, MASK_XLEN(-2047)
    add    x18, x18, x5
    # Test Instruction 
    sd      x3, 2047(x18)
    # Check results:  mem[test_53_res+8] = 0x0000000000000000
    ld x6, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)

    # Clear memory
    sd      x0, 16(x2)
    # Load values and compute offsets
    li      x0, 0x0
    addi    x17, x2,16
    li     x5, MASK_XLEN(1025)
    add    x17, x17, x5
    # Test Instruction 
    sd      x0, -1025(x17)
    # Check results:  mem[test_53_res+16] = 0
    ld x6, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0)

    # Clear memory
    sd      x0, 24(x2)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x16, x2,24
    li     x5, MASK_XLEN(513)
    add    x16, x16, x5
    # Test Instruction 
    sd      x1, -513(x16)
    # Check results:  mem[test_53_res+24] = 0x0000000000000000
    ld x6, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x0000000000000000)



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

