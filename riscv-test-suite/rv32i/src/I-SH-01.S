# RISC-V Compliance Test I-SH-01
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
# Specification: RV32I Base Integer Instruction Set, Version 2.1
# Description: Testing instruction 'SH'.

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
    li      x16, 0xdf7f3844121bcc23
    addi    x31, x6,0
    li     x7, MASK_XLEN(989)
    add    x31, x31, x7
    # Test Instruction 
    sh      x16, -989(x31)
    # Check results:  mem[test_1_res+0] = 0x0000cc23
    lw x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000cc23)

    # Clear memory
    sw      x0, 4(x6)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x6,4
    li     x7, MASK_XLEN(-91)
    add    x30, x30, x7
    # Test Instruction 
    sh      x15, 91(x30)
    # Check results:  mem[test_1_res+4] = 0x00000000
    lw x8, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x6)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x6,8
    li     x7, MASK_XLEN(-704)
    add    x29, x29, x7
    # Test Instruction 
    sh      x14, 704(x29)
    # Check results:  mem[test_1_res+8] = 0x00000000
    lw x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x6)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x6,12
    li     x7, MASK_XLEN(1085)
    add    x28, x28, x7
    # Test Instruction 
    sh      x13, -1085(x28)
    # Check results:  mem[test_1_res+12] = 0x00000000
    lw x8, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x6)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x6,16
    li     x7, MASK_XLEN(-175)
    add    x27, x27, x7
    # Test Instruction 
    sh      x12, 175(x27)
    # Check results:  mem[test_1_res+16] = 0x00000000
    lw x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # Addresses for test results
    la x1, test_2_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x26, x1,0
    li     x2, MASK_XLEN(-591)
    add    x26, x26, x2
    # Test Instruction 
    sh      x11, 591(x26)
    # Check results:  mem[test_2_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,4
    li     x2, MASK_XLEN(53)
    add    x25, x25, x2
    # Test Instruction 
    sh      x10, -53(x25)
    # Check results:  mem[test_2_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x24, x1,8
    li     x2, MASK_XLEN(1861)
    add    x24, x24, x2
    # Test Instruction 
    sh      x9, -1861(x24)
    # Check results:  mem[test_2_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x23, x1,12
    li     x2, MASK_XLEN(319)
    add    x23, x23, x2
    # Test Instruction 
    sh      x8, -319(x23)
    # Check results:  mem[test_2_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x22, x1,16
    li     x2, MASK_XLEN(-405)
    add    x22, x22, x2
    # Test Instruction 
    sh      x7, 405(x22)
    # Check results:  mem[test_2_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # Addresses for test results
    la x1, test_3_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x21, x1,0
    li     x7, MASK_XLEN(1)
    add    x21, x21, x7
    # Test Instruction 
    sh      x6, -1(x21)
    # Check results:  mem[test_3_res+0] = 0x00000000
    lw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x20, x1,4
    li     x7, MASK_XLEN(-2047)
    add    x20, x20, x7
    # Test Instruction 
    sh      x5, 2047(x20)
    # Check results:  mem[test_3_res+4] = 0x00000000
    lw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x19, x1,8
    li     x7, MASK_XLEN(1025)
    add    x19, x19, x7
    # Test Instruction 
    sh      x4, -1025(x19)
    # Check results:  mem[test_3_res+8] = 0x00000000
    lw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x18, x1,12
    li     x7, MASK_XLEN(513)
    add    x18, x18, x7
    # Test Instruction 
    sh      x3, -513(x18)
    # Check results:  mem[test_3_res+12] = 0x00000000
    lw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x17, x1,16
    li     x7, MASK_XLEN(257)
    add    x17, x17, x7
    # Test Instruction 
    sh      x2, -257(x17)
    # Check results:  mem[test_3_res+16] = 0x00000000
    lw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # Addresses for test results
    la x2, test_4_res

    # Clear memory
    sw      x0, 0(x2)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x16, x2,0
    li     x3, MASK_XLEN(129)
    add    x16, x16, x3
    # Test Instruction 
    sh      x1, -129(x16)
    # Check results:  mem[test_4_res+0] = 0x00000000
    lw x4, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 4(x2)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x15, x2,4
    li     x3, MASK_XLEN(65)
    add    x15, x15, x3
    # Test Instruction 
    sh      x31, -65(x15)
    # Check results:  mem[test_4_res+4] = 0x00000000
    lw x4, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 8(x2)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x14, x2,8
    li     x3, MASK_XLEN(33)
    add    x14, x14, x3
    # Test Instruction 
    sh      x30, -33(x14)
    # Check results:  mem[test_4_res+8] = 0x00000000
    lw x4, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 12(x2)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x13, x2,12
    li     x3, MASK_XLEN(17)
    add    x13, x13, x3
    # Test Instruction 
    sh      x29, -17(x13)
    # Check results:  mem[test_4_res+12] = 0x00000000
    lw x4, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 16(x2)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x12, x2,16
    li     x3, MASK_XLEN(9)
    add    x12, x12, x3
    # Test Instruction 
    sh      x28, -9(x12)
    # Check results:  mem[test_4_res+16] = 0x00000000
    lw x4, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # Addresses for test results
    la x1, test_5_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x11, x1,0
    li     x2, MASK_XLEN(5)
    add    x11, x11, x2
    # Test Instruction 
    sh      x27, -5(x11)
    # Check results:  mem[test_5_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x10, x1,4
    li     x2, MASK_XLEN(3)
    add    x10, x10, x2
    # Test Instruction 
    sh      x26, -3(x10)
    # Check results:  mem[test_5_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x9, x1,8
    li     x2, MASK_XLEN(2)
    add    x9, x9, x2
    # Test Instruction 
    sh      x25, -2(x9)
    # Check results:  mem[test_5_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x8, x1,12
    li     x2, MASK_XLEN(0)
    add    x8, x8, x2
    # Test Instruction 
    sh      x24, 0(x8)
    # Check results:  mem[test_5_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x7, x1,16
    li     x2, MASK_XLEN(2048)
    add    x7, x7, x2
    # Test Instruction 
    sh      x23, -2048(x7)
    # Check results:  mem[test_5_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # Addresses for test results
    la x1, test_6_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x6, x1,0
    li     x7, MASK_XLEN(-1024)
    add    x6, x6, x7
    # Test Instruction 
    sh      x22, 1024(x6)
    # Check results:  mem[test_6_res+0] = 0x00000000
    lw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x5, x1,4
    li     x7, MASK_XLEN(-512)
    add    x5, x5, x7
    # Test Instruction 
    sh      x21, 512(x5)
    # Check results:  mem[test_6_res+4] = 0x00000000
    lw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x4, x1,8
    li     x7, MASK_XLEN(-256)
    add    x4, x4, x7
    # Test Instruction 
    sh      x20, 256(x4)
    # Check results:  mem[test_6_res+8] = 0x00000000
    lw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x3, x1,12
    li     x7, MASK_XLEN(-128)
    add    x3, x3, x7
    # Test Instruction 
    sh      x19, 128(x3)
    # Check results:  mem[test_6_res+12] = 0x00000000
    lw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x1,16
    li     x7, MASK_XLEN(-64)
    add    x2, x2, x7
    # Test Instruction 
    sh      x18, 64(x2)
    # Check results:  mem[test_6_res+16] = 0x00000000
    lw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # Addresses for test results
    la x5, test_7_res

    # Clear memory
    sw      x0, 0(x5)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x1, x5,0
    li     x6, MASK_XLEN(-32)
    add    x1, x1, x6
    # Test Instruction 
    sh      x17, 32(x1)
    # Check results:  mem[test_7_res+0] = 0x00000000
    lw x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 4(x5)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x31, x5,4
    li     x6, MASK_XLEN(-16)
    add    x31, x31, x6
    # Test Instruction 
    sh      x16, 16(x31)
    # Check results:  mem[test_7_res+4] = 0x00000000
    lw x7, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 8(x5)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x5,8
    li     x6, MASK_XLEN(-8)
    add    x30, x30, x6
    # Test Instruction 
    sh      x15, 8(x30)
    # Check results:  mem[test_7_res+8] = 0x00000000
    lw x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 12(x5)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x5,12
    li     x6, MASK_XLEN(-4)
    add    x29, x29, x6
    # Test Instruction 
    sh      x14, 4(x29)
    # Check results:  mem[test_7_res+12] = 0x00000000
    lw x7, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 16(x5)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x5,16
    li     x6, MASK_XLEN(-2)
    add    x28, x28, x6
    # Test Instruction 
    sh      x13, 2(x28)
    # Check results:  mem[test_7_res+16] = 0x00000000
    lw x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # Addresses for test results
    la x1, test_8_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x1,0
    li     x2, MASK_XLEN(-1)
    add    x27, x27, x2
    # Test Instruction 
    sh      x12, 1(x27)
    # Check results:  mem[test_8_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x26, x1,4
    li     x2, MASK_XLEN(989)
    add    x26, x26, x2
    # Test Instruction 
    sh      x11, -989(x26)
    # Check results:  mem[test_8_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,8
    li     x2, MASK_XLEN(-91)
    add    x25, x25, x2
    # Test Instruction 
    sh      x10, 91(x25)
    # Check results:  mem[test_8_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x24, x1,12
    li     x2, MASK_XLEN(-704)
    add    x24, x24, x2
    # Test Instruction 
    sh      x9, 704(x24)
    # Check results:  mem[test_8_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x23, x1,16
    li     x2, MASK_XLEN(1085)
    add    x23, x23, x2
    # Test Instruction 
    sh      x8, -1085(x23)
    # Check results:  mem[test_8_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # Addresses for test results
    la x1, test_9_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x22, x1,0
    li     x2, MASK_XLEN(-175)
    add    x22, x22, x2
    # Test Instruction 
    sh      x7, 175(x22)
    # Check results:  mem[test_9_res+0] = 0x00000000
    lw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x21, x1,4
    li     x2, MASK_XLEN(-591)
    add    x21, x21, x2
    # Test Instruction 
    sh      x6, 591(x21)
    # Check results:  mem[test_9_res+4] = 0x00000000
    lw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x20, x1,8
    li     x2, MASK_XLEN(53)
    add    x20, x20, x2
    # Test Instruction 
    sh      x5, -53(x20)
    # Check results:  mem[test_9_res+8] = 0x00000000
    lw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x19, x1,12
    li     x2, MASK_XLEN(1861)
    add    x19, x19, x2
    # Test Instruction 
    sh      x4, -1861(x19)
    # Check results:  mem[test_9_res+12] = 0x00000000
    lw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x18, x1,16
    li     x2, MASK_XLEN(319)
    add    x18, x18, x2
    # Test Instruction 
    sh      x3, -319(x18)
    # Check results:  mem[test_9_res+16] = 0x00000000
    lw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # Addresses for test results
    la x3, test_10_res

    # Clear memory
    sw      x0, 0(x3)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x17, x3,0
    li     x4, MASK_XLEN(-405)
    add    x17, x17, x4
    # Test Instruction 
    sh      x2, 405(x17)
    # Check results:  mem[test_10_res+0] = 0x00000000
    lw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 4(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x16, x3,4
    li     x4, MASK_XLEN(1)
    add    x16, x16, x4
    # Test Instruction 
    sh      x1, -1(x16)
    # Check results:  mem[test_10_res+4] = 0x00000000
    lw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 8(x3)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x15, x3,8
    li     x4, MASK_XLEN(-2047)
    add    x15, x15, x4
    # Test Instruction 
    sh      x31, 2047(x15)
    # Check results:  mem[test_10_res+8] = 0x00000000
    lw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 12(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x14, x3,12
    li     x4, MASK_XLEN(1025)
    add    x14, x14, x4
    # Test Instruction 
    sh      x30, -1025(x14)
    # Check results:  mem[test_10_res+12] = 0x00000000
    lw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 16(x3)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x13, x3,16
    li     x4, MASK_XLEN(513)
    add    x13, x13, x4
    # Test Instruction 
    sh      x29, -513(x13)
    # Check results:  mem[test_10_res+16] = 0x00000000
    lw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # Addresses for test results
    la x1, test_11_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x12, x1,0
    li     x2, MASK_XLEN(257)
    add    x12, x12, x2
    # Test Instruction 
    sh      x28, -257(x12)
    # Check results:  mem[test_11_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x11, x1,4
    li     x2, MASK_XLEN(129)
    add    x11, x11, x2
    # Test Instruction 
    sh      x27, -129(x11)
    # Check results:  mem[test_11_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x10, x1,8
    li     x2, MASK_XLEN(65)
    add    x10, x10, x2
    # Test Instruction 
    sh      x26, -65(x10)
    # Check results:  mem[test_11_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x9, x1,12
    li     x2, MASK_XLEN(33)
    add    x9, x9, x2
    # Test Instruction 
    sh      x25, -33(x9)
    # Check results:  mem[test_11_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x8, x1,16
    li     x2, MASK_XLEN(17)
    add    x8, x8, x2
    # Test Instruction 
    sh      x24, -17(x8)
    # Check results:  mem[test_11_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # Addresses for test results
    la x1, test_12_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x7, x1,0
    li     x2, MASK_XLEN(9)
    add    x7, x7, x2
    # Test Instruction 
    sh      x23, -9(x7)
    # Check results:  mem[test_12_res+0] = 0x00000000
    lw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x6, x1,4
    li     x2, MASK_XLEN(5)
    add    x6, x6, x2
    # Test Instruction 
    sh      x22, -5(x6)
    # Check results:  mem[test_12_res+4] = 0x00000000
    lw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x5, x1,8
    li     x2, MASK_XLEN(3)
    add    x5, x5, x2
    # Test Instruction 
    sh      x21, -3(x5)
    # Check results:  mem[test_12_res+8] = 0x00000000
    lw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x4, x1,12
    li     x2, MASK_XLEN(2)
    add    x4, x4, x2
    # Test Instruction 
    sh      x20, -2(x4)
    # Check results:  mem[test_12_res+12] = 0x00000000
    lw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x3, x1,16
    li     x2, MASK_XLEN(0)
    add    x3, x3, x2
    # Test Instruction 
    sh      x19, 0(x3)
    # Check results:  mem[test_12_res+16] = 0x00000000
    lw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # Addresses for test results
    la x4, test_13_res

    # Clear memory
    sw      x0, 0(x4)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x4,0
    li     x5, MASK_XLEN(2048)
    add    x2, x2, x5
    # Test Instruction 
    sh      x18, -2048(x2)
    # Check results:  mem[test_13_res+0] = 0x00000000
    lw x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 4(x4)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x1, x4,4
    li     x5, MASK_XLEN(-1024)
    add    x1, x1, x5
    # Test Instruction 
    sh      x17, 1024(x1)
    # Check results:  mem[test_13_res+4] = 0x00000000
    lw x6, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 8(x4)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x31, x4,8
    li     x5, MASK_XLEN(-512)
    add    x31, x31, x5
    # Test Instruction 
    sh      x16, 512(x31)
    # Check results:  mem[test_13_res+8] = 0x00000000
    lw x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 12(x4)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x4,12
    li     x5, MASK_XLEN(-256)
    add    x30, x30, x5
    # Test Instruction 
    sh      x15, 256(x30)
    # Check results:  mem[test_13_res+12] = 0x00000000
    lw x6, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 16(x4)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x4,16
    li     x5, MASK_XLEN(-128)
    add    x29, x29, x5
    # Test Instruction 
    sh      x14, 128(x29)
    # Check results:  mem[test_13_res+16] = 0x00000000
    lw x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # Addresses for test results
    la x1, test_14_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x1,0
    li     x2, MASK_XLEN(-64)
    add    x28, x28, x2
    # Test Instruction 
    sh      x13, 64(x28)
    # Check results:  mem[test_14_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x1,4
    li     x2, MASK_XLEN(-32)
    add    x27, x27, x2
    # Test Instruction 
    sh      x12, 32(x27)
    # Check results:  mem[test_14_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x1
    addi    x26, x1,8
    li     x2, MASK_XLEN(-16)
    add    x26, x26, x2
    # Test Instruction 
    sh      x11, 16(x26)
    # Check results:  mem[test_14_res+8] = 0x00000001
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000001)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x10, 0x2
    addi    x25, x1,12
    li     x2, MASK_XLEN(-8)
    add    x25, x25, x2
    # Test Instruction 
    sh      x10, 8(x25)
    # Check results:  mem[test_14_res+12] = 0x00000002
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000002)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x4
    addi    x24, x1,16
    li     x2, MASK_XLEN(-4)
    add    x24, x24, x2
    # Test Instruction 
    sh      x9, 4(x24)
    # Check results:  mem[test_14_res+16] = 0x00000004
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000004)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # Addresses for test results
    la x1, test_15_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x8
    addi    x23, x1,0
    li     x2, MASK_XLEN(-2)
    add    x23, x23, x2
    # Test Instruction 
    sh      x8, 2(x23)
    # Check results:  mem[test_15_res+0] = 0x00000008
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000008)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x7, 0x10
    addi    x22, x1,4
    li     x2, MASK_XLEN(-1)
    add    x22, x22, x2
    # Test Instruction 
    sh      x7, 1(x22)
    # Check results:  mem[test_15_res+4] = 0x00000010
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000010)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x6, 0x20
    addi    x21, x1,8
    li     x2, MASK_XLEN(989)
    add    x21, x21, x2
    # Test Instruction 
    sh      x6, -989(x21)
    # Check results:  mem[test_15_res+8] = 0x00000020
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000020)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x5, 0x40
    addi    x20, x1,12
    li     x2, MASK_XLEN(-91)
    add    x20, x20, x2
    # Test Instruction 
    sh      x5, 91(x20)
    # Check results:  mem[test_15_res+12] = 0x00000040
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000040)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x4, 0x80
    addi    x19, x1,16
    li     x2, MASK_XLEN(-704)
    add    x19, x19, x2
    # Test Instruction 
    sh      x4, 704(x19)
    # Check results:  mem[test_15_res+16] = 0x00000080
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000080)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # Addresses for test results
    la x4, test_16_res

    # Clear memory
    sw      x0, 0(x4)
    # Load values and compute offsets
    li      x3, 0x100
    addi    x18, x4,0
    li     x5, MASK_XLEN(1085)
    add    x18, x18, x5
    # Test Instruction 
    sh      x3, -1085(x18)
    # Check results:  mem[test_16_res+0] = 0x00000100
    lw x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000100)

    # Clear memory
    sw      x0, 4(x4)
    # Load values and compute offsets
    li      x2, 0x200
    addi    x17, x4,4
    li     x5, MASK_XLEN(-175)
    add    x17, x17, x5
    # Test Instruction 
    sh      x2, 175(x17)
    # Check results:  mem[test_16_res+4] = 0x00000200
    lw x6, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000200)

    # Clear memory
    sw      x0, 8(x4)
    # Load values and compute offsets
    li      x1, 0x400
    addi    x16, x4,8
    li     x5, MASK_XLEN(-591)
    add    x16, x16, x5
    # Test Instruction 
    sh      x1, 591(x16)
    # Check results:  mem[test_16_res+8] = 0x00000400
    lw x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000400)

    # Clear memory
    sw      x0, 12(x4)
    # Load values and compute offsets
    li      x31, 0x800
    addi    x15, x4,12
    li     x5, MASK_XLEN(53)
    add    x15, x15, x5
    # Test Instruction 
    sh      x31, -53(x15)
    # Check results:  mem[test_16_res+12] = 0x00000800
    lw x6, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000800)

    # Clear memory
    sw      x0, 16(x4)
    # Load values and compute offsets
    li      x30, 0x1000
    addi    x14, x4,16
    li     x5, MASK_XLEN(1861)
    add    x14, x14, x5
    # Test Instruction 
    sh      x30, -1861(x14)
    # Check results:  mem[test_16_res+16] = 0x00001000
    lw x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00001000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # Addresses for test results
    la x1, test_17_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x29, 0x2000
    addi    x13, x1,0
    li     x2, MASK_XLEN(319)
    add    x13, x13, x2
    # Test Instruction 
    sh      x29, -319(x13)
    # Check results:  mem[test_17_res+0] = 0x00002000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00002000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x28, 0x4000
    addi    x12, x1,4
    li     x2, MASK_XLEN(-405)
    add    x12, x12, x2
    # Test Instruction 
    sh      x28, 405(x12)
    # Check results:  mem[test_17_res+4] = 0x00004000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00004000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x27, 0x8000
    addi    x11, x1,8
    li     x2, MASK_XLEN(1)
    add    x11, x11, x2
    # Test Instruction 
    sh      x27, -1(x11)
    # Check results:  mem[test_17_res+8] = 0x00008000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00008000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x26, 0x10000
    addi    x10, x1,12
    li     x2, MASK_XLEN(-2047)
    add    x10, x10, x2
    # Test Instruction 
    sh      x26, 2047(x10)
    # Check results:  mem[test_17_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x25, 0x20000
    addi    x9, x1,16
    li     x2, MASK_XLEN(1025)
    add    x9, x9, x2
    # Test Instruction 
    sh      x25, -1025(x9)
    # Check results:  mem[test_17_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # Addresses for test results
    la x1, test_18_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x24, 0x40000
    addi    x8, x1,0
    li     x2, MASK_XLEN(513)
    add    x8, x8, x2
    # Test Instruction 
    sh      x24, -513(x8)
    # Check results:  mem[test_18_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x23, 0x80000
    addi    x7, x1,4
    li     x2, MASK_XLEN(257)
    add    x7, x7, x2
    # Test Instruction 
    sh      x23, -257(x7)
    # Check results:  mem[test_18_res+4] = 0x00000000
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0x100000
    addi    x6, x1,8
    li     x2, MASK_XLEN(129)
    add    x6, x6, x2
    # Test Instruction 
    sh      x22, -129(x6)
    # Check results:  mem[test_18_res+8] = 0x00000000
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x21, 0x200000
    addi    x5, x1,12
    li     x2, MASK_XLEN(65)
    add    x5, x5, x2
    # Test Instruction 
    sh      x21, -65(x5)
    # Check results:  mem[test_18_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x20, 0x400000
    addi    x4, x1,16
    li     x2, MASK_XLEN(33)
    add    x4, x4, x2
    # Test Instruction 
    sh      x20, -33(x4)
    # Check results:  mem[test_18_res+16] = 0x00000000
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # Addresses for test results
    la x4, test_19_res

    # Clear memory
    sw      x0, 0(x4)
    # Load values and compute offsets
    li      x19, 0x800000
    addi    x3, x4,0
    li     x5, MASK_XLEN(17)
    add    x3, x3, x5
    # Test Instruction 
    sh      x19, -17(x3)
    # Check results:  mem[test_19_res+0] = 0x00000000
    lw x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 4(x4)
    # Load values and compute offsets
    li      x18, 0x1000000
    addi    x2, x4,4
    li     x5, MASK_XLEN(9)
    add    x2, x2, x5
    # Test Instruction 
    sh      x18, -9(x2)
    # Check results:  mem[test_19_res+4] = 0x00000000
    lw x6, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 8(x4)
    # Load values and compute offsets
    li      x17, 0x2000000
    addi    x1, x4,8
    li     x5, MASK_XLEN(5)
    add    x1, x1, x5
    # Test Instruction 
    sh      x17, -5(x1)
    # Check results:  mem[test_19_res+8] = 0x00000000
    lw x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 12(x4)
    # Load values and compute offsets
    li      x16, 0x4000000
    addi    x31, x4,12
    li     x5, MASK_XLEN(3)
    add    x31, x31, x5
    # Test Instruction 
    sh      x16, -3(x31)
    # Check results:  mem[test_19_res+12] = 0x00000000
    lw x6, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 16(x4)
    # Load values and compute offsets
    li      x15, 0x8000000
    addi    x30, x4,16
    li     x5, MASK_XLEN(2)
    add    x30, x30, x5
    # Test Instruction 
    sh      x15, -2(x30)
    # Check results:  mem[test_19_res+16] = 0x00000000
    lw x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # Addresses for test results
    la x1, test_20_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x10000000
    addi    x29, x1,0
    li     x2, MASK_XLEN(0)
    add    x29, x29, x2
    # Test Instruction 
    sh      x14, 0(x29)
    # Check results:  mem[test_20_res+0] = 0x00000000
    lw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x13, 0x20000000
    addi    x28, x1,4
    li     x2, MASK_XLEN(2048)
    add    x28, x28, x2
    # Test Instruction 
    sh      x13, -2048(x28)
    # Check results:  mem[test_20_res+4] = 0x00000000
    lw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x40000000
    addi    x27, x1,8
    li     x2, MASK_XLEN(-1024)
    add    x27, x27, x2
    # Test Instruction 
    sh      x12, 1024(x27)
    # Check results:  mem[test_20_res+8] = 0x00000000
    lw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x11, 0x80000000
    addi    x26, x1,12
    li     x2, MASK_XLEN(-512)
    add    x26, x26, x2
    # Test Instruction 
    sh      x11, 512(x26)
    # Check results:  mem[test_20_res+12] = 0x00000000
    lw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,16
    li     x2, MASK_XLEN(-256)
    add    x25, x25, x2
    # Test Instruction 
    sh      x10, 256(x25)
    # Check results:  mem[test_20_res+16] = 0x00000000
    lw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # Addresses for test results
    la x1, test_21_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0xfffffffe
    addi    x24, x1,0
    li     x2, MASK_XLEN(-128)
    add    x24, x24, x2
    # Test Instruction 
    sh      x9, 128(x24)
    # Check results:  mem[test_21_res+0] = 0x0000fffe
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000fffe)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x8, 0xfffffffd
    addi    x23, x1,4
    li     x2, MASK_XLEN(-64)
    add    x23, x23, x2
    # Test Instruction 
    sh      x8, 64(x23)
    # Check results:  mem[test_21_res+4] = 0x0000fffd
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000fffd)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0xfffffffb
    addi    x22, x1,8
    li     x2, MASK_XLEN(-32)
    add    x22, x22, x2
    # Test Instruction 
    sh      x7, 32(x22)
    # Check results:  mem[test_21_res+8] = 0x0000fffb
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000fffb)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x6, 0xfffffff7
    addi    x21, x1,12
    li     x2, MASK_XLEN(-16)
    add    x21, x21, x2
    # Test Instruction 
    sh      x6, 16(x21)
    # Check results:  mem[test_21_res+12] = 0x0000fff7
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000fff7)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x5, 0xffffffef
    addi    x20, x1,16
    li     x2, MASK_XLEN(-8)
    add    x20, x20, x2
    # Test Instruction 
    sh      x5, 8(x20)
    # Check results:  mem[test_21_res+16] = 0x0000ffef
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000ffef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # Addresses for test results
    la x5, test_22_res

    # Clear memory
    sw      x0, 0(x5)
    # Load values and compute offsets
    li      x4, 0xffffffdf
    addi    x19, x5,0
    li     x6, MASK_XLEN(-4)
    add    x19, x19, x6
    # Test Instruction 
    sh      x4, 4(x19)
    # Check results:  mem[test_22_res+0] = 0x0000ffdf
    lw x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000ffdf)

    # Clear memory
    sw      x0, 4(x5)
    # Load values and compute offsets
    li      x3, 0xffffffbf
    addi    x18, x5,4
    li     x6, MASK_XLEN(-2)
    add    x18, x18, x6
    # Test Instruction 
    sh      x3, 2(x18)
    # Check results:  mem[test_22_res+4] = 0x0000ffbf
    lw x7, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000ffbf)

    # Clear memory
    sw      x0, 8(x5)
    # Load values and compute offsets
    li      x2, 0xffffff7f
    addi    x17, x5,8
    li     x6, MASK_XLEN(-1)
    add    x17, x17, x6
    # Test Instruction 
    sh      x2, 1(x17)
    # Check results:  mem[test_22_res+8] = 0x0000ff7f
    lw x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000ff7f)

    # Clear memory
    sw      x0, 12(x5)
    # Load values and compute offsets
    li      x1, 0xfffffeff
    addi    x16, x5,12
    li     x6, MASK_XLEN(989)
    add    x16, x16, x6
    # Test Instruction 
    sh      x1, -989(x16)
    # Check results:  mem[test_22_res+12] = 0x0000feff
    lw x7, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000feff)

    # Clear memory
    sw      x0, 16(x5)
    # Load values and compute offsets
    li      x31, 0xfffffdff
    addi    x15, x5,16
    li     x6, MASK_XLEN(-91)
    add    x15, x15, x6
    # Test Instruction 
    sh      x31, 91(x15)
    # Check results:  mem[test_22_res+16] = 0x0000fdff
    lw x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000fdff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # Addresses for test results
    la x1, test_23_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x30, 0xfffffbff
    addi    x14, x1,0
    li     x2, MASK_XLEN(-704)
    add    x14, x14, x2
    # Test Instruction 
    sh      x30, 704(x14)
    # Check results:  mem[test_23_res+0] = 0x0000fbff
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000fbff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x29, 0xfffff7ff
    addi    x13, x1,4
    li     x2, MASK_XLEN(1085)
    add    x13, x13, x2
    # Test Instruction 
    sh      x29, -1085(x13)
    # Check results:  mem[test_23_res+4] = 0x0000f7ff
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000f7ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0xffffefff
    addi    x12, x1,8
    li     x2, MASK_XLEN(-175)
    add    x12, x12, x2
    # Test Instruction 
    sh      x28, 175(x12)
    # Check results:  mem[test_23_res+8] = 0x0000efff
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000efff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x27, 0xffffdfff
    addi    x11, x1,12
    li     x2, MASK_XLEN(-591)
    add    x11, x11, x2
    # Test Instruction 
    sh      x27, 591(x11)
    # Check results:  mem[test_23_res+12] = 0x0000dfff
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000dfff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x26, 0xffffbfff
    addi    x10, x1,16
    li     x2, MASK_XLEN(53)
    add    x10, x10, x2
    # Test Instruction 
    sh      x26, -53(x10)
    # Check results:  mem[test_23_res+16] = 0x0000bfff
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000bfff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # Addresses for test results
    la x1, test_24_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x25, 0xffff7fff
    addi    x9, x1,0
    li     x2, MASK_XLEN(1861)
    add    x9, x9, x2
    # Test Instruction 
    sh      x25, -1861(x9)
    # Check results:  mem[test_24_res+0] = 0x00007fff
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00007fff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x24, 0xfffeffff
    addi    x8, x1,4
    li     x2, MASK_XLEN(319)
    add    x8, x8, x2
    # Test Instruction 
    sh      x24, -319(x8)
    # Check results:  mem[test_24_res+4] = 0x0000ffff
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000ffff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x23, 0xfffdffff
    addi    x7, x1,8
    li     x2, MASK_XLEN(-405)
    add    x7, x7, x2
    # Test Instruction 
    sh      x23, 405(x7)
    # Check results:  mem[test_24_res+8] = 0x0000ffff
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000ffff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x22, 0xfffbffff
    addi    x6, x1,12
    li     x2, MASK_XLEN(1)
    add    x6, x6, x2
    # Test Instruction 
    sh      x22, -1(x6)
    # Check results:  mem[test_24_res+12] = 0x0000ffff
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000ffff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x21, 0xfff7ffff
    addi    x5, x1,16
    li     x2, MASK_XLEN(-2047)
    add    x5, x5, x2
    # Test Instruction 
    sh      x21, 2047(x5)
    # Check results:  mem[test_24_res+16] = 0x0000ffff
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000ffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # Addresses for test results
    la x5, test_25_res

    # Clear memory
    sw      x0, 0(x5)
    # Load values and compute offsets
    li      x20, 0xffefffff
    addi    x4, x5,0
    li     x6, MASK_XLEN(1025)
    add    x4, x4, x6
    # Test Instruction 
    sh      x20, -1025(x4)
    # Check results:  mem[test_25_res+0] = 0x0000ffff
    lw x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000ffff)

    # Clear memory
    sw      x0, 4(x5)
    # Load values and compute offsets
    li      x19, 0xffdfffff
    addi    x3, x5,4
    li     x6, MASK_XLEN(513)
    add    x3, x3, x6
    # Test Instruction 
    sh      x19, -513(x3)
    # Check results:  mem[test_25_res+4] = 0x0000ffff
    lw x7, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000ffff)

    # Clear memory
    sw      x0, 8(x5)
    # Load values and compute offsets
    li      x18, 0xffbfffff
    addi    x2, x5,8
    li     x6, MASK_XLEN(257)
    add    x2, x2, x6
    # Test Instruction 
    sh      x18, -257(x2)
    # Check results:  mem[test_25_res+8] = 0x0000ffff
    lw x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000ffff)

    # Clear memory
    sw      x0, 12(x5)
    # Load values and compute offsets
    li      x17, 0xff7fffff
    addi    x1, x5,12
    li     x6, MASK_XLEN(129)
    add    x1, x1, x6
    # Test Instruction 
    sh      x17, -129(x1)
    # Check results:  mem[test_25_res+12] = 0x0000ffff
    lw x7, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000ffff)

    # Clear memory
    sw      x0, 16(x5)
    # Load values and compute offsets
    li      x16, 0xfeffffff
    addi    x31, x5,16
    li     x6, MASK_XLEN(65)
    add    x31, x31, x6
    # Test Instruction 
    sh      x16, -65(x31)
    # Check results:  mem[test_25_res+16] = 0x0000ffff
    lw x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0x0000ffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # Addresses for test results
    la x1, test_26_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0xfdffffff
    addi    x30, x1,0
    li     x7, MASK_XLEN(33)
    add    x30, x30, x7
    # Test Instruction 
    sh      x15, -33(x30)
    # Check results:  mem[test_26_res+0] = 0x0000ffff
    lw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000ffff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x14, 0xfbffffff
    addi    x29, x1,4
    li     x7, MASK_XLEN(17)
    add    x29, x29, x7
    # Test Instruction 
    sh      x14, -17(x29)
    # Check results:  mem[test_26_res+4] = 0x0000ffff
    lw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000ffff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0xf7ffffff
    addi    x28, x1,8
    li     x7, MASK_XLEN(9)
    add    x28, x28, x7
    # Test Instruction 
    sh      x13, -9(x28)
    # Check results:  mem[test_26_res+8] = 0x0000ffff
    lw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000ffff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x12, 0xefffffff
    addi    x27, x1,12
    li     x7, MASK_XLEN(5)
    add    x27, x27, x7
    # Test Instruction 
    sh      x12, -5(x27)
    # Check results:  mem[test_26_res+12] = 0x0000ffff
    lw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000ffff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0xdfffffff
    addi    x26, x1,16
    li     x7, MASK_XLEN(3)
    add    x26, x26, x7
    # Test Instruction 
    sh      x11, -3(x26)
    # Check results:  mem[test_26_res+16] = 0x0000ffff
    lw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000ffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # Addresses for test results
    la x1, test_27_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0xbfffffff
    addi    x25, x1,0
    li     x2, MASK_XLEN(2)
    add    x25, x25, x2
    # Test Instruction 
    sh      x10, -2(x25)
    # Check results:  mem[test_27_res+0] = 0x0000ffff
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000ffff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x9, 0x7fffffff
    addi    x24, x1,4
    li     x2, MASK_XLEN(0)
    add    x24, x24, x2
    # Test Instruction 
    sh      x9, 0(x24)
    # Check results:  mem[test_27_res+4] = 0x0000ffff
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000ffff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0xffffffff
    addi    x23, x1,8
    li     x2, MASK_XLEN(2048)
    add    x23, x23, x2
    # Test Instruction 
    sh      x8, -2048(x23)
    # Check results:  mem[test_27_res+8] = 0x0000ffff
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000ffff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x7, 0x10fd3dedadea5195
    addi    x22, x1,12
    li     x2, MASK_XLEN(-1024)
    add    x22, x22, x2
    # Test Instruction 
    sh      x7, 1024(x22)
    # Check results:  mem[test_27_res+12] = 0x00005195
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00005195)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x6, 0xbd295ce2d2ffbec1
    addi    x21, x1,16
    li     x2, MASK_XLEN(-512)
    add    x21, x21, x2
    # Test Instruction 
    sh      x6, 512(x21)
    # Check results:  mem[test_27_res+16] = 0x0000bec1
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000bec1)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # Addresses for test results
    la x6, test_28_res

    # Clear memory
    sw      x0, 0(x6)
    # Load values and compute offsets
    li      x5, 0xc9649f05a8e1a8bb
    addi    x20, x6,0
    li     x7, MASK_XLEN(-256)
    add    x20, x20, x7
    # Test Instruction 
    sh      x5, 256(x20)
    # Check results:  mem[test_28_res+0] = 0x0000a8bb
    lw x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000a8bb)

    # Clear memory
    sw      x0, 4(x6)
    # Load values and compute offsets
    li      x4, 0x3541291848c99fcb
    addi    x19, x6,4
    li     x7, MASK_XLEN(-128)
    add    x19, x19, x7
    # Test Instruction 
    sh      x4, 128(x19)
    # Check results:  mem[test_28_res+4] = 0x00009fcb
    lw x8, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x00009fcb)

    # Clear memory
    sw      x0, 8(x6)
    # Load values and compute offsets
    li      x3, 0x10a24740461d524f
    addi    x18, x6,8
    li     x7, MASK_XLEN(-64)
    add    x18, x18, x7
    # Test Instruction 
    sh      x3, 64(x18)
    # Check results:  mem[test_28_res+8] = 0x0000524f
    lw x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000524f)

    # Clear memory
    sw      x0, 12(x6)
    # Load values and compute offsets
    li      x2, 0x546b0e54528a10af
    addi    x17, x6,12
    li     x7, MASK_XLEN(-32)
    add    x17, x17, x7
    # Test Instruction 
    sh      x2, 32(x17)
    # Check results:  mem[test_28_res+12] = 0x000010af
    lw x8, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x000010af)

    # Clear memory
    sw      x0, 16(x6)
    # Load values and compute offsets
    li      x1, 0x73a92fd4e19bfbc3
    addi    x16, x6,16
    li     x7, MASK_XLEN(-16)
    add    x16, x16, x7
    # Test Instruction 
    sh      x1, 16(x16)
    # Check results:  mem[test_28_res+16] = 0x0000fbc3
    lw x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0x0000fbc3)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # Addresses for test results
    la x1, test_29_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x31, 0x82f6747f707af2c0
    addi    x15, x1,0
    li     x2, MASK_XLEN(-8)
    add    x15, x15, x2
    # Test Instruction 
    sh      x31, 8(x15)
    # Check results:  mem[test_29_res+0] = 0x0000f2c0
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000f2c0)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x30, 0xf5adb41aa47d105b
    addi    x14, x1,4
    li     x2, MASK_XLEN(-4)
    add    x14, x14, x2
    # Test Instruction 
    sh      x30, 4(x14)
    # Check results:  mem[test_29_res+4] = 0x0000105b
    lw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000105b)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x29, 0xdf7f3844121bcc23
    addi    x13, x1,8
    li     x2, MASK_XLEN(-2)
    add    x13, x13, x2
    # Test Instruction 
    sh      x29, 2(x13)
    # Check results:  mem[test_29_res+8] = 0x0000cc23
    lw x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000cc23)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x12, x1,12
    li     x2, MASK_XLEN(-1)
    add    x12, x12, x2
    # Test Instruction 
    sh      x28, 1(x12)
    # Check results:  mem[test_29_res+12] = 0x00000000
    lw x3, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x0, 0x0
    addi    x11, x1,16
    li     x2, MASK_XLEN(989)
    add    x11, x11, x2
    # Test Instruction 
    sh      x0, -989(x11)
    # Check results:  mem[test_29_res+16] = 0
    lw x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # Addresses for test results
    la x1, test_30_res

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x10, x1,0
    li     x2, MASK_XLEN(-91)
    add    x10, x10, x2
    # Test Instruction 
    sh      x26, 91(x10)
    # Check results:  mem[test_30_res+0] = 0x00000000
    lw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



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
test_29_res:
	.fill 5, 4, -1
test_30_res:
	.fill 5, 4, -1

RV_COMPLIANCE_DATA_END

