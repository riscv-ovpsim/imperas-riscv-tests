# RISC-V Compliance Test I-LBU-01
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
# Description: Testing instruction 'LBU'.

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


    # Addresses for test data and results
    la x6, test_1_res

    # Testcase 0:  imm:0xfff, result rd:x1(0x00000000000000fe)
    la  x31, test_data
    addi    x31, x31,0
    li     x7, MASK_XLEN(1)
    add    x31, x31, x7
    lbu x1, -1(x31)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x00000000000000fe)

    # Testcase 1:  imm:0x7ff, result rd:x2(0x00000000000000fd)
    la  x30, test_data
    addi    x30, x30,1
    li     x7, MASK_XLEN(-2047)
    add    x30, x30, x7
    lbu x2, 2047(x30)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x00000000000000fd)

    # Testcase 2:  imm:0xbff, result rd:x3(0x00000000000000fb)
    la  x29, test_data
    addi    x29, x29,2
    li     x7, MASK_XLEN(1025)
    add    x29, x29, x7
    lbu x3, -1025(x29)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x00000000000000fb)

    # Testcase 3:  imm:0xdff, result rd:x4(0x00000000000000f7)
    la  x28, test_data
    addi    x28, x28,3
    li     x7, MASK_XLEN(513)
    add    x28, x28, x7
    lbu x4, -513(x28)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x00000000000000f7)

    # Testcase 4:  imm:0xeff, result rd:x5(0x00000000000000ef)
    la  x27, test_data
    addi    x27, x27,4
    li     x7, MASK_XLEN(257)
    add    x27, x27, x7
    lbu x5, -257(x27)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x00000000000000ef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # Addresses for test data and results
    la x1, test_2_res

    # Testcase 5:  imm:0xf7f, result rd:x6(0x00000000000000df)
    la  x26, test_data
    addi    x26, x26,5
    li     x2, MASK_XLEN(129)
    add    x26, x26, x2
    lbu x6, -129(x26)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x00000000000000df)

    # Testcase 6:  imm:0xfbf, result rd:x7(0x00000000000000bf)
    la  x25, test_data
    addi    x25, x25,6
    li     x2, MASK_XLEN(65)
    add    x25, x25, x2
    lbu x7, -65(x25)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x00000000000000bf)

    # Testcase 7:  imm:0xfdf, result rd:x8(0x000000000000007f)
    la  x24, test_data
    addi    x24, x24,7
    li     x2, MASK_XLEN(33)
    add    x24, x24, x2
    lbu x8, -33(x24)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x000000000000007f)

    # Testcase 8:  imm:0xfef, result rd:x9(0x00000000000000ff)
    la  x23, test_data
    addi    x23, x23,8
    li     x2, MASK_XLEN(17)
    add    x23, x23, x2
    lbu x9, -17(x23)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000000000000ff)

    # Testcase 9:  imm:0xff7, result rd:x10(0x0000000000000001)
    la  x22, test_data
    addi    x22, x22,9
    li     x2, MASK_XLEN(9)
    add    x22, x22, x2
    lbu x10, -9(x22)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000001)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # Addresses for test data and results
    la x1, test_3_res

    # Testcase 10:  imm:0xffb, result rd:x11(0x0000000000000002)
    la  x21, test_data
    addi    x21, x21,10
    li     x7, MASK_XLEN(5)
    add    x21, x21, x7
    lbu x11, -5(x21)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x11, 0x0000000000000002)

    # Testcase 11:  imm:0xffd, result rd:x12(0x0000000000000004)
    la  x20, test_data
    addi    x20, x20,11
    li     x7, MASK_XLEN(3)
    add    x20, x20, x7
    lbu x12, -3(x20)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x0000000000000004)

    # Testcase 12:  imm:0xffe, result rd:x13(0x0000000000000008)
    la  x19, test_data
    addi    x19, x19,12
    li     x7, MASK_XLEN(2)
    add    x19, x19, x7
    lbu x13, -2(x19)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x0000000000000008)

    # Testcase 13:  imm:0x0, result rd:x14(0x0000000000000010)
    la  x18, test_data
    addi    x18, x18,13
    li     x7, MASK_XLEN(0)
    add    x18, x18, x7
    lbu x14, 0(x18)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x0000000000000010)

    # Testcase 14:  imm:0x800, result rd:x15(0x0000000000000020)
    la  x17, test_data
    addi    x17, x17,14
    li     x7, MASK_XLEN(2048)
    add    x17, x17, x7
    lbu x15, -2048(x17)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x15, 0x0000000000000020)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # Addresses for test data and results
    la x2, test_4_res

    # Testcase 15:  imm:0x400, result rd:x16(0x0000000000000040)
    la  x16, test_data
    addi    x16, x16,15
    li     x3, MASK_XLEN(-1024)
    add    x16, x16, x3
    lbu x16, 1024(x16)
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x0000000000000040)

    # Testcase 16:  imm:0x200, result rd:x17(0x0000000000000080)
    la  x15, test_data
    addi    x15, x15,16
    li     x3, MASK_XLEN(-512)
    add    x15, x15, x3
    lbu x17, 512(x15)
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x0000000000000080)

    # Testcase 17:  imm:0x100, result rd:x18(0x0000000000000000)
    la  x14, test_data
    addi    x14, x14,17
    li     x3, MASK_XLEN(-256)
    add    x14, x14, x3
    lbu x18, 256(x14)
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x0000000000000000)

    # Testcase 18:  imm:0x80, result rd:x19(0x00000000000000fe)
    la  x13, test_data
    addi    x13, x13,18
    li     x3, MASK_XLEN(-128)
    add    x13, x13, x3
    lbu x19, 128(x13)
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x00000000000000fe)

    # Testcase 19:  imm:0x40, result rd:x20(0x00000000000000fd)
    la  x12, test_data
    addi    x12, x12,19
    li     x3, MASK_XLEN(-64)
    add    x12, x12, x3
    lbu x20, 64(x12)
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x00000000000000fd)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # Addresses for test data and results
    la x1, test_5_res

    # Testcase 20:  imm:0x20, result rd:x21(0x00000000000000fb)
    la  x11, test_data
    addi    x11, x11,20
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    lbu x21, 32(x11)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x00000000000000fb)

    # Testcase 21:  imm:0x10, result rd:x22(0x00000000000000f7)
    la  x10, test_data
    addi    x10, x10,21
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    lbu x22, 16(x10)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x00000000000000f7)

    # Testcase 22:  imm:0x8, result rd:x23(0x00000000000000ef)
    la  x9, test_data
    addi    x9, x9,22
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    lbu x23, 8(x9)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x00000000000000ef)

    # Testcase 23:  imm:0x4, result rd:x24(0x00000000000000df)
    la  x8, test_data
    addi    x8, x8,23
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    lbu x24, 4(x8)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x00000000000000df)

    # Testcase 24:  imm:0x2, result rd:x25(0x00000000000000fe)
    la  x7, test_data
    addi    x7, x7,0
    li     x2, MASK_XLEN(-2)
    add    x7, x7, x2
    lbu x25, 2(x7)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x00000000000000fe)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # Addresses for test data and results
    la x1, test_6_res

    # Testcase 25:  imm:0x1, result rd:x26(0x00000000000000fd)
    la  x6, test_data
    addi    x6, x6,1
    li     x7, MASK_XLEN(-1)
    add    x6, x6, x7
    lbu x26, 1(x6)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x26, 0x00000000000000fd)

    # Testcase 26:  imm:0xfff, result rd:x27(0x00000000000000fb)
    la  x5, test_data
    addi    x5, x5,2
    li     x7, MASK_XLEN(1)
    add    x5, x5, x7
    lbu x27, -1(x5)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x00000000000000fb)

    # Testcase 27:  imm:0x7ff, result rd:x28(0x00000000000000f7)
    la  x4, test_data
    addi    x4, x4,3
    li     x7, MASK_XLEN(-2047)
    add    x4, x4, x7
    lbu x28, 2047(x4)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x00000000000000f7)

    # Testcase 28:  imm:0xbff, result rd:x29(0x00000000000000ef)
    la  x3, test_data
    addi    x3, x3,4
    li     x7, MASK_XLEN(1025)
    add    x3, x3, x7
    lbu x29, -1025(x3)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x00000000000000ef)

    # Testcase 29:  imm:0xdff, result rd:x30(0x00000000000000df)
    la  x2, test_data
    addi    x2, x2,5
    li     x7, MASK_XLEN(513)
    add    x2, x2, x7
    lbu x30, -513(x2)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x30, 0x00000000000000df)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # Addresses for test data and results
    la x5, test_7_res

    # Testcase 30:  imm:0xeff, result rd:x31(0x00000000000000bf)
    la  x1, test_data
    addi    x1, x1,6
    li     x6, MASK_XLEN(257)
    add    x1, x1, x6
    lbu x31, -257(x1)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x00000000000000bf)

    # Testcase 31:  imm:0xf7f, result rd:x1(0x000000000000007f)
    la  x31, test_data
    addi    x31, x31,7
    li     x6, MASK_XLEN(129)
    add    x31, x31, x6
    lbu x1, -129(x31)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x000000000000007f)

    # Testcase 32:  imm:0xfbf, result rd:x2(0x00000000000000ff)
    la  x30, test_data
    addi    x30, x30,8
    li     x6, MASK_XLEN(65)
    add    x30, x30, x6
    lbu x2, -65(x30)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x00000000000000ff)

    # Testcase 33:  imm:0xfdf, result rd:x3(0x0000000000000001)
    la  x29, test_data
    addi    x29, x29,9
    li     x6, MASK_XLEN(33)
    add    x29, x29, x6
    lbu x3, -33(x29)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0000000000000001)

    # Testcase 34:  imm:0xfef, result rd:x4(0x0000000000000002)
    la  x28, test_data
    addi    x28, x28,10
    li     x6, MASK_XLEN(17)
    add    x28, x28, x6
    lbu x4, -17(x28)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x0000000000000002)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # Addresses for test data and results
    la x1, test_8_res

    # Testcase 35:  imm:0xff7, result rd:x5(0x0000000000000004)
    la  x27, test_data
    addi    x27, x27,11
    li     x2, MASK_XLEN(9)
    add    x27, x27, x2
    lbu x5, -9(x27)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x5, 0x0000000000000004)

    # Testcase 36:  imm:0xffb, result rd:x6(0x0000000000000008)
    la  x26, test_data
    addi    x26, x26,12
    li     x2, MASK_XLEN(5)
    add    x26, x26, x2
    lbu x6, -5(x26)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x0000000000000008)

    # Testcase 37:  imm:0xffd, result rd:x7(0x0000000000000010)
    la  x25, test_data
    addi    x25, x25,13
    li     x2, MASK_XLEN(3)
    add    x25, x25, x2
    lbu x7, -3(x25)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x0000000000000010)

    # Testcase 38:  imm:0xffe, result rd:x8(0x0000000000000020)
    la  x24, test_data
    addi    x24, x24,14
    li     x2, MASK_XLEN(2)
    add    x24, x24, x2
    lbu x8, -2(x24)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000020)

    # Testcase 39:  imm:0x0, result rd:x9(0x0000000000000040)
    la  x23, test_data
    addi    x23, x23,15
    li     x2, MASK_XLEN(0)
    add    x23, x23, x2
    lbu x9, 0(x23)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000040)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # Addresses for test data and results
    la x1, test_9_res

    # Testcase 40:  imm:0x800, result rd:x10(0x0000000000000080)
    la  x22, test_data
    addi    x22, x22,16
    li     x2, MASK_XLEN(2048)
    add    x22, x22, x2
    lbu x10, -2048(x22)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x10, 0x0000000000000080)

    # Testcase 41:  imm:0x400, result rd:x11(0x0000000000000000)
    la  x21, test_data
    addi    x21, x21,17
    li     x2, MASK_XLEN(-1024)
    add    x21, x21, x2
    lbu x11, 1024(x21)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x11, 0x0000000000000000)

    # Testcase 42:  imm:0x200, result rd:x12(0x00000000000000fe)
    la  x20, test_data
    addi    x20, x20,18
    li     x2, MASK_XLEN(-512)
    add    x20, x20, x2
    lbu x12, 512(x20)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x00000000000000fe)

    # Testcase 43:  imm:0x100, result rd:x13(0x00000000000000fd)
    la  x19, test_data
    addi    x19, x19,19
    li     x2, MASK_XLEN(-256)
    add    x19, x19, x2
    lbu x13, 256(x19)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x00000000000000fd)

    # Testcase 44:  imm:0x80, result rd:x14(0x00000000000000fb)
    la  x18, test_data
    addi    x18, x18,20
    li     x2, MASK_XLEN(-128)
    add    x18, x18, x2
    lbu x14, 128(x18)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x00000000000000fb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # Addresses for test data and results
    la x3, test_10_res

    # Testcase 45:  imm:0x40, result rd:x15(0x00000000000000f7)
    la  x17, test_data
    addi    x17, x17,21
    li     x4, MASK_XLEN(-64)
    add    x17, x17, x4
    lbu x15, 64(x17)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x00000000000000f7)

    # Testcase 46:  imm:0x20, result rd:x16(0x00000000000000ef)
    la  x16, test_data
    addi    x16, x16,22
    li     x4, MASK_XLEN(-32)
    add    x16, x16, x4
    lbu x16, 32(x16)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x00000000000000ef)

    # Testcase 47:  imm:0x10, result rd:x17(0x00000000000000df)
    la  x15, test_data
    addi    x15, x15,23
    li     x4, MASK_XLEN(-16)
    add    x15, x15, x4
    lbu x17, 16(x15)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x00000000000000df)

    # Testcase 48:  imm:0x8, result rd:x18(0x00000000000000fe)
    la  x14, test_data
    addi    x14, x14,0
    li     x4, MASK_XLEN(-8)
    add    x14, x14, x4
    lbu x18, 8(x14)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x00000000000000fe)

    # Testcase 49:  imm:0x4, result rd:x19(0x00000000000000fd)
    la  x13, test_data
    addi    x13, x13,1
    li     x4, MASK_XLEN(-4)
    add    x13, x13, x4
    lbu x19, 4(x13)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0x00000000000000fd)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # Addresses for test data and results
    la x1, test_11_res

    # Testcase 50:  imm:0x2, result rd:x20(0x00000000000000fb)
    la  x12, test_data
    addi    x12, x12,2
    li     x2, MASK_XLEN(-2)
    add    x12, x12, x2
    lbu x20, 2(x12)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x00000000000000fb)

    # Testcase 51:  imm:0x1, result rd:x21(0x00000000000000f7)
    la  x11, test_data
    addi    x11, x11,3
    li     x2, MASK_XLEN(-1)
    add    x11, x11, x2
    lbu x21, 1(x11)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x00000000000000f7)

    # Testcase 52:  imm:0xfff, result rd:x22(0x00000000000000ef)
    la  x10, test_data
    addi    x10, x10,4
    li     x2, MASK_XLEN(1)
    add    x10, x10, x2
    lbu x22, -1(x10)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x00000000000000ef)

    # Testcase 53:  imm:0x7ff, result rd:x23(0x00000000000000df)
    la  x9, test_data
    addi    x9, x9,5
    li     x2, MASK_XLEN(-2047)
    add    x9, x9, x2
    lbu x23, 2047(x9)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x00000000000000df)

    # Testcase 54:  imm:0xbff, result rd:x24(0x00000000000000bf)
    la  x8, test_data
    addi    x8, x8,6
    li     x2, MASK_XLEN(1025)
    add    x8, x8, x2
    lbu x24, -1025(x8)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x00000000000000bf)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # Addresses for test data and results
    la x1, test_12_res

    # Testcase 55:  imm:0xdff, result rd:x25(0x000000000000007f)
    la  x7, test_data
    addi    x7, x7,7
    li     x2, MASK_XLEN(513)
    add    x7, x7, x2
    lbu x25, -513(x7)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x25, 0x000000000000007f)

    # Testcase 56:  imm:0xeff, result rd:x26(0x00000000000000ff)
    la  x6, test_data
    addi    x6, x6,8
    li     x2, MASK_XLEN(257)
    add    x6, x6, x2
    lbu x26, -257(x6)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x26, 0x00000000000000ff)

    # Testcase 57:  imm:0xf7f, result rd:x27(0x0000000000000001)
    la  x5, test_data
    addi    x5, x5,9
    li     x2, MASK_XLEN(129)
    add    x5, x5, x2
    lbu x27, -129(x5)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x0000000000000001)

    # Testcase 58:  imm:0xfbf, result rd:x28(0x0000000000000002)
    la  x4, test_data
    addi    x4, x4,10
    li     x2, MASK_XLEN(65)
    add    x4, x4, x2
    lbu x28, -65(x4)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x0000000000000002)

    # Testcase 59:  imm:0xfdf, result rd:x29(0x0000000000000004)
    la  x3, test_data
    addi    x3, x3,11
    li     x2, MASK_XLEN(33)
    add    x3, x3, x2
    lbu x29, -33(x3)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x0000000000000004)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # Addresses for test data and results
    la x4, test_13_res

    # Testcase 60:  imm:0xfef, result rd:x30(0x0000000000000008)
    la  x2, test_data
    addi    x2, x2,12
    li     x5, MASK_XLEN(17)
    add    x2, x2, x5
    lbu x30, -17(x2)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x0000000000000008)

    # Testcase 61:  imm:0xff7, result rd:x31(0x0000000000000010)
    la  x1, test_data
    addi    x1, x1,13
    li     x5, MASK_XLEN(9)
    add    x1, x1, x5
    lbu x31, -9(x1)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0000000000000010)

    # Testcase 62:  imm:0xffb, result rd:x1(0x0000000000000020)
    la  x31, test_data
    addi    x31, x31,14
    li     x5, MASK_XLEN(5)
    add    x31, x31, x5
    lbu x1, -5(x31)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0000000000000020)

    # Testcase 63:  imm:0xffd, result rd:x2(0x0000000000000040)
    la  x30, test_data
    addi    x30, x30,15
    li     x5, MASK_XLEN(3)
    add    x30, x30, x5
    lbu x2, -3(x30)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0000000000000040)

    # Testcase 64:  imm:0xffe, result rd:x3(0x0000000000000080)
    la  x29, test_data
    addi    x29, x29,16
    li     x5, MASK_XLEN(2)
    add    x29, x29, x5
    lbu x3, -2(x29)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x0000000000000080)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # Addresses for test data and results
    la x1, test_14_res

    # Testcase 65:  imm:0x0, result rd:x4(0x0000000000000000)
    la  x28, test_data
    addi    x28, x28,17
    li     x2, MASK_XLEN(0)
    add    x28, x28, x2
    lbu x4, 0(x28)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000000000)

    # Testcase 66:  imm:0x800, result rd:x5(0x00000000000000fe)
    la  x27, test_data
    addi    x27, x27,18
    li     x2, MASK_XLEN(2048)
    add    x27, x27, x2
    lbu x5, -2048(x27)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x5, 0x00000000000000fe)

    # Testcase 67:  imm:0x400, result rd:x6(0x00000000000000fd)
    la  x26, test_data
    addi    x26, x26,19
    li     x2, MASK_XLEN(-1024)
    add    x26, x26, x2
    lbu x6, 1024(x26)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x00000000000000fd)

    # Testcase 68:  imm:0x200, result rd:x7(0x00000000000000fb)
    la  x25, test_data
    addi    x25, x25,20
    li     x2, MASK_XLEN(-512)
    add    x25, x25, x2
    lbu x7, 512(x25)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x00000000000000fb)

    # Testcase 69:  imm:0x100, result rd:x8(0x00000000000000f7)
    la  x24, test_data
    addi    x24, x24,21
    li     x2, MASK_XLEN(-256)
    add    x24, x24, x2
    lbu x8, 256(x24)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00000000000000f7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # Addresses for test data and results
    la x1, test_15_res

    # Testcase 70:  imm:0x80, result rd:x9(0x00000000000000ef)
    la  x23, test_data
    addi    x23, x23,22
    li     x2, MASK_XLEN(-128)
    add    x23, x23, x2
    lbu x9, 128(x23)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000000000000ef)

    # Testcase 71:  imm:0x40, result rd:x10(0x00000000000000df)
    la  x22, test_data
    addi    x22, x22,23
    li     x2, MASK_XLEN(-64)
    add    x22, x22, x2
    lbu x10, 64(x22)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00000000000000df)

    # Testcase 72:  imm:0x20, result rd:x11(0x00000000000000fe)
    la  x21, test_data
    addi    x21, x21,0
    li     x2, MASK_XLEN(-32)
    add    x21, x21, x2
    lbu x11, 32(x21)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00000000000000fe)

    # Testcase 73:  imm:0x10, result rd:x12(0x00000000000000fd)
    la  x20, test_data
    addi    x20, x20,1
    li     x2, MASK_XLEN(-16)
    add    x20, x20, x2
    lbu x12, 16(x20)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00000000000000fd)

    # Testcase 74:  imm:0x8, result rd:x13(0x00000000000000fb)
    la  x19, test_data
    addi    x19, x19,2
    li     x2, MASK_XLEN(-8)
    add    x19, x19, x2
    lbu x13, 8(x19)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x00000000000000fb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # Addresses for test data and results
    la x4, test_16_res

    # Testcase 75:  imm:0x4, result rd:x14(0x00000000000000f7)
    la  x18, test_data
    addi    x18, x18,3
    li     x5, MASK_XLEN(-4)
    add    x18, x18, x5
    lbu x14, 4(x18)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x00000000000000f7)

    # Testcase 76:  imm:0x2, result rd:x15(0x00000000000000ef)
    la  x17, test_data
    addi    x17, x17,4
    li     x5, MASK_XLEN(-2)
    add    x17, x17, x5
    lbu x15, 2(x17)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x00000000000000ef)

    # Testcase 77:  imm:0x1, result rd:x16(0x00000000000000df)
    la  x16, test_data
    addi    x16, x16,5
    li     x5, MASK_XLEN(-1)
    add    x16, x16, x5
    lbu x16, 1(x16)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x00000000000000df)

    # Testcase 78:  imm:0xfff, result rd:x17(0x00000000000000bf)
    la  x15, test_data
    addi    x15, x15,6
    li     x5, MASK_XLEN(1)
    add    x15, x15, x5
    lbu x17, -1(x15)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x00000000000000bf)

    # Testcase 79:  imm:0x7ff, result rd:x18(0x000000000000007f)
    la  x14, test_data
    addi    x14, x14,7
    li     x5, MASK_XLEN(-2047)
    add    x14, x14, x5
    lbu x18, 2047(x14)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x18, 0x000000000000007f)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # Addresses for test data and results
    la x1, test_17_res

    # Testcase 80:  imm:0xbff, result rd:x19(0x00000000000000ff)
    la  x13, test_data
    addi    x13, x13,8
    li     x2, MASK_XLEN(1025)
    add    x13, x13, x2
    lbu x19, -1025(x13)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x00000000000000ff)

    # Testcase 81:  imm:0xdff, result rd:x20(0x0000000000000001)
    la  x12, test_data
    addi    x12, x12,9
    li     x2, MASK_XLEN(513)
    add    x12, x12, x2
    lbu x20, -513(x12)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0000000000000001)

    # Testcase 82:  imm:0xeff, result rd:x21(0x0000000000000002)
    la  x11, test_data
    addi    x11, x11,10
    li     x2, MASK_XLEN(257)
    add    x11, x11, x2
    lbu x21, -257(x11)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x0000000000000002)

    # Testcase 83:  imm:0xf7f, result rd:x22(0x0000000000000004)
    la  x10, test_data
    addi    x10, x10,11
    li     x2, MASK_XLEN(129)
    add    x10, x10, x2
    lbu x22, -129(x10)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x0000000000000004)

    # Testcase 84:  imm:0xfbf, result rd:x23(0x0000000000000008)
    la  x9, test_data
    addi    x9, x9,12
    li     x2, MASK_XLEN(65)
    add    x9, x9, x2
    lbu x23, -65(x9)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x0000000000000008)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # Addresses for test data and results
    la x1, test_18_res

    # Testcase 85:  imm:0xfdf, result rd:x24(0x0000000000000010)
    la  x8, test_data
    addi    x8, x8,13
    li     x2, MASK_XLEN(33)
    add    x8, x8, x2
    lbu x24, -33(x8)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x0000000000000010)

    # Testcase 86:  imm:0xfef, result rd:x25(0x0000000000000020)
    la  x7, test_data
    addi    x7, x7,14
    li     x2, MASK_XLEN(17)
    add    x7, x7, x2
    lbu x25, -17(x7)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x0000000000000020)

    # Testcase 87:  imm:0xff7, result rd:x26(0x0000000000000040)
    la  x6, test_data
    addi    x6, x6,15
    li     x2, MASK_XLEN(9)
    add    x6, x6, x2
    lbu x26, -9(x6)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x26, 0x0000000000000040)

    # Testcase 88:  imm:0xffb, result rd:x27(0x0000000000000080)
    la  x5, test_data
    addi    x5, x5,16
    li     x2, MASK_XLEN(5)
    add    x5, x5, x2
    lbu x27, -5(x5)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x27, 0x0000000000000080)

    # Testcase 89:  imm:0xffd, result rd:x28(0x0000000000000000)
    la  x4, test_data
    addi    x4, x4,17
    li     x2, MASK_XLEN(3)
    add    x4, x4, x2
    lbu x28, -3(x4)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x28, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # Addresses for test data and results
    la x4, test_19_res

    # Testcase 90:  imm:0xffe, result rd:x29(0x00000000000000fe)
    la  x3, test_data
    addi    x3, x3,18
    li     x5, MASK_XLEN(2)
    add    x3, x3, x5
    lbu x29, -2(x3)
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x00000000000000fe)

    # Testcase 91:  imm:0x0, result rd:x30(0x00000000000000fd)
    la  x2, test_data
    addi    x2, x2,19
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    lbu x30, 0(x2)
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x00000000000000fd)

    # Testcase 92:  imm:0x800, result rd:x31(0x00000000000000fb)
    la  x1, test_data
    addi    x1, x1,20
    li     x5, MASK_XLEN(2048)
    add    x1, x1, x5
    lbu x31, -2048(x1)
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x00000000000000fb)

    # Testcase 93:  imm:0x400, result rd:x1(0x00000000000000f7)
    la  x31, test_data
    addi    x31, x31,21
    li     x5, MASK_XLEN(-1024)
    add    x31, x31, x5
    lbu x1, 1024(x31)
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x00000000000000f7)

    # Testcase 94:  imm:0x200, result rd:x2(0x00000000000000ef)
    la  x30, test_data
    addi    x30, x30,22
    li     x5, MASK_XLEN(-512)
    add    x30, x30, x5
    lbu x2, 512(x30)
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x00000000000000ef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # Addresses for test data and results
    la x1, test_20_res

    # Testcase 95:  imm:0x100, result rd:x3(0x00000000000000df)
    la  x29, test_data
    addi    x29, x29,23
    li     x2, MASK_XLEN(-256)
    add    x29, x29, x2
    lbu x3, 256(x29)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x00000000000000df)

    # Testcase 96:  imm:0x80, result rd:x4(0x00000000000000fe)
    la  x28, test_data
    addi    x28, x28,0
    li     x2, MASK_XLEN(-128)
    add    x28, x28, x2
    lbu x4, 128(x28)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x00000000000000fe)

    # Testcase 97:  imm:0x40, result rd:x5(0x00000000000000fd)
    la  x27, test_data
    addi    x27, x27,1
    li     x2, MASK_XLEN(-64)
    add    x27, x27, x2
    lbu x5, 64(x27)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x00000000000000fd)

    # Testcase 98:  imm:0x20, result rd:x6(0x00000000000000fb)
    la  x26, test_data
    addi    x26, x26,2
    li     x2, MASK_XLEN(-32)
    add    x26, x26, x2
    lbu x6, 32(x26)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x00000000000000fb)

    # Testcase 99:  imm:0x10, result rd:x7(0x00000000000000f7)
    la  x25, test_data
    addi    x25, x25,3
    li     x2, MASK_XLEN(-16)
    add    x25, x25, x2
    lbu x7, 16(x25)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x7, 0x00000000000000f7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # Addresses for test data and results
    la x1, test_21_res

    # Testcase 100:  imm:0x8, result rd:x8(0x00000000000000ef)
    la  x24, test_data
    addi    x24, x24,4
    li     x2, MASK_XLEN(-8)
    add    x24, x24, x2
    lbu x8, 8(x24)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00000000000000ef)

    # Testcase 101:  imm:0x4, result rd:x9(0x00000000000000df)
    la  x23, test_data
    addi    x23, x23,5
    li     x2, MASK_XLEN(-4)
    add    x23, x23, x2
    lbu x9, 4(x23)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000000000000df)

    # Testcase 102:  imm:0x2, result rd:x10(0x00000000000000bf)
    la  x22, test_data
    addi    x22, x22,6
    li     x2, MASK_XLEN(-2)
    add    x22, x22, x2
    lbu x10, 2(x22)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00000000000000bf)

    # Testcase 103:  imm:0x1, result rd:x11(0x000000000000007f)
    la  x21, test_data
    addi    x21, x21,7
    li     x2, MASK_XLEN(-1)
    add    x21, x21, x2
    lbu x11, 1(x21)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x000000000000007f)

    # Testcase 104:  imm:0xfff, result rd:x12(0x00000000000000ff)
    la  x20, test_data
    addi    x20, x20,8
    li     x2, MASK_XLEN(1)
    add    x20, x20, x2
    lbu x12, -1(x20)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00000000000000ff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # Addresses for test data and results
    la x5, test_22_res

    # Testcase 105:  imm:0x7ff, result rd:x13(0x0000000000000001)
    la  x19, test_data
    addi    x19, x19,9
    li     x6, MASK_XLEN(-2047)
    add    x19, x19, x6
    lbu x13, 2047(x19)
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0000000000000001)

    # Testcase 106:  imm:0xbff, result rd:x14(0x0000000000000002)
    la  x18, test_data
    addi    x18, x18,10
    li     x6, MASK_XLEN(1025)
    add    x18, x18, x6
    lbu x14, -1025(x18)
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0000000000000002)

    # Testcase 107:  imm:0xdff, result rd:x15(0x0000000000000004)
    la  x17, test_data
    addi    x17, x17,11
    li     x6, MASK_XLEN(513)
    add    x17, x17, x6
    lbu x15, -513(x17)
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0000000000000004)

    # Testcase 108:  imm:0xeff, result rd:x16(0x0000000000000008)
    la  x16, test_data
    addi    x16, x16,12
    li     x6, MASK_XLEN(257)
    add    x16, x16, x6
    lbu x16, -257(x16)
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x0000000000000008)

    # Testcase 109:  imm:0xf7f, result rd:x17(0x0000000000000010)
    la  x15, test_data
    addi    x15, x15,13
    li     x6, MASK_XLEN(129)
    add    x15, x15, x6
    lbu x17, -129(x15)
    sd x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x17, 0x0000000000000010)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # Addresses for test data and results
    la x1, test_23_res

    # Testcase 110:  imm:0xfbf, result rd:x18(0x0000000000000020)
    la  x14, test_data
    addi    x14, x14,14
    li     x2, MASK_XLEN(65)
    add    x14, x14, x2
    lbu x18, -65(x14)
    sd x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x0000000000000020)

    # Testcase 111:  imm:0xfdf, result rd:x19(0x0000000000000040)
    la  x13, test_data
    addi    x13, x13,15
    li     x2, MASK_XLEN(33)
    add    x13, x13, x2
    lbu x19, -33(x13)
    sd x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x0000000000000040)

    # Testcase 112:  imm:0xfef, result rd:x20(0x0000000000000080)
    la  x12, test_data
    addi    x12, x12,16
    li     x2, MASK_XLEN(17)
    add    x12, x12, x2
    lbu x20, -17(x12)
    sd x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0000000000000080)

    # Testcase 113:  imm:0xff7, result rd:x21(0x0000000000000000)
    la  x11, test_data
    addi    x11, x11,17
    li     x2, MASK_XLEN(9)
    add    x11, x11, x2
    lbu x21, -9(x11)
    sd x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x0000000000000000)

    # Testcase 114:  imm:0xffb, result rd:x22(0x00000000000000fe)
    la  x10, test_data
    addi    x10, x10,18
    li     x2, MASK_XLEN(5)
    add    x10, x10, x2
    lbu x22, -5(x10)
    sd x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x00000000000000fe)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # Addresses for test data and results
    la x1, test_24_res

    # Testcase 115:  imm:0xffd, result rd:x23(0x00000000000000fd)
    la  x9, test_data
    addi    x9, x9,19
    li     x2, MASK_XLEN(3)
    add    x9, x9, x2
    lbu x23, -3(x9)
    sd x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x00000000000000fd)

    # Testcase 116:  imm:0xffe, result rd:x24(0x00000000000000fb)
    la  x8, test_data
    addi    x8, x8,20
    li     x2, MASK_XLEN(2)
    add    x8, x8, x2
    lbu x24, -2(x8)
    sd x24, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x00000000000000fb)

    # Testcase 117:  imm:0x0, result rd:x25(0x00000000000000f7)
    la  x7, test_data
    addi    x7, x7,21
    li     x2, MASK_XLEN(0)
    add    x7, x7, x2
    lbu x25, 0(x7)
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x00000000000000f7)

    # Testcase 118:  imm:0x800, result rd:x26(0x00000000000000ef)
    la  x6, test_data
    addi    x6, x6,22
    li     x2, MASK_XLEN(2048)
    add    x6, x6, x2
    lbu x26, -2048(x6)
    sd x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x26, 0x00000000000000ef)

    # Testcase 119:  imm:0x400, result rd:x27(0x00000000000000df)
    la  x5, test_data
    addi    x5, x5,23
    li     x2, MASK_XLEN(-1024)
    add    x5, x5, x2
    lbu x27, 1024(x5)
    sd x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x27, 0x00000000000000df)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # Addresses for test data and results
    la x5, test_25_res

    # Testcase 120:  imm:0x200, result rd:x28(0x00000000000000fe)
    la  x4, test_data
    addi    x4, x4,0
    li     x6, MASK_XLEN(-512)
    add    x4, x4, x6
    lbu x28, 512(x4)
    sd x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x00000000000000fe)

    # Testcase 121:  imm:0x100, result rd:x29(0x00000000000000fd)
    la  x3, test_data
    addi    x3, x3,1
    li     x6, MASK_XLEN(-256)
    add    x3, x3, x6
    lbu x29, 256(x3)
    sd x29, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x00000000000000fd)

    # Testcase 122:  imm:0x80, result rd:x30(0x00000000000000fb)
    la  x2, test_data
    addi    x2, x2,2
    li     x6, MASK_XLEN(-128)
    add    x2, x2, x6
    lbu x30, 128(x2)
    sd x30, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x00000000000000fb)

    # Testcase 123:  imm:0x40, result rd:x31(0x00000000000000f7)
    la  x1, test_data
    addi    x1, x1,3
    li     x6, MASK_XLEN(-64)
    add    x1, x1, x6
    lbu x31, 64(x1)
    sd x31, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x00000000000000f7)

    # Testcase 124:  imm:0x20, result rd:x1(0x00000000000000ef)
    la  x31, test_data
    addi    x31, x31,4
    li     x6, MASK_XLEN(-32)
    add    x31, x31, x6
    lbu x1, 32(x31)
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x00000000000000ef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # Addresses for test data and results
    la x1, test_26_res

    # Testcase 125:  imm:0x10, result rd:x2(0x00000000000000df)
    la  x30, test_data
    addi    x30, x30,5
    li     x7, MASK_XLEN(-16)
    add    x30, x30, x7
    lbu x2, 16(x30)
    sd x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x00000000000000df)

    # Testcase 126:  imm:0x8, result rd:x3(0x00000000000000bf)
    la  x29, test_data
    addi    x29, x29,6
    li     x7, MASK_XLEN(-8)
    add    x29, x29, x7
    lbu x3, 8(x29)
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x00000000000000bf)

    # Testcase 127:  imm:0x4, result rd:x4(0x000000000000007f)
    la  x28, test_data
    addi    x28, x28,7
    li     x7, MASK_XLEN(-4)
    add    x28, x28, x7
    lbu x4, 4(x28)
    sd x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x000000000000007f)

    # Testcase 128:  imm:0x2, result rd:x5(0x00000000000000ff)
    la  x27, test_data
    addi    x27, x27,8
    li     x7, MASK_XLEN(-2)
    add    x27, x27, x7
    lbu x5, 2(x27)
    sd x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x00000000000000ff)

    # Testcase 129:  imm:0x1, result rd:x6(0x0000000000000001)
    la  x26, test_data
    addi    x26, x26,9
    li     x7, MASK_XLEN(-1)
    add    x26, x26, x7
    lbu x6, 1(x26)
    sd x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x0000000000000001)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # Addresses for test data and results
    la x1, test_27_res

    # Testcase 130:  imm:0xfff, result rd:x7(0x0000000000000002)
    la  x25, test_data
    addi    x25, x25,10
    li     x2, MASK_XLEN(1)
    add    x25, x25, x2
    lbu x7, -1(x25)
    sd x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x0000000000000002)

    # Testcase 131:  imm:0x7ff, result rd:x8(0x0000000000000004)
    la  x24, test_data
    addi    x24, x24,11
    li     x2, MASK_XLEN(-2047)
    add    x24, x24, x2
    lbu x8, 2047(x24)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000004)

    # Testcase 132:  imm:0xbff, result rd:x9(0x0000000000000008)
    la  x23, test_data
    addi    x23, x23,12
    li     x2, MASK_XLEN(1025)
    add    x23, x23, x2
    lbu x9, -1025(x23)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000008)

    # Testcase 133:  imm:0xdff, result rd:x10(0x0000000000000010)
    la  x22, test_data
    addi    x22, x22,13
    li     x2, MASK_XLEN(513)
    add    x22, x22, x2
    lbu x10, -513(x22)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000010)

    # Testcase 134:  imm:0xeff, result rd:x11(0x0000000000000020)
    la  x21, test_data
    addi    x21, x21,14
    li     x2, MASK_XLEN(257)
    add    x21, x21, x2
    lbu x11, -257(x21)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000020)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # Addresses for test data and results
    la x6, test_28_res

    # Testcase 135:  imm:0xf7f, result rd:x12(0x0000000000000040)
    la  x20, test_data
    addi    x20, x20,15
    li     x7, MASK_XLEN(129)
    add    x20, x20, x7
    lbu x12, -129(x20)
    sd x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x0000000000000040)

    # Testcase 136:  imm:0xfbf, result rd:x13(0x0000000000000080)
    la  x19, test_data
    addi    x19, x19,16
    li     x7, MASK_XLEN(65)
    add    x19, x19, x7
    lbu x13, -65(x19)
    sd x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x0000000000000080)

    # Testcase 137:  imm:0xfdf, result rd:x14(0x0000000000000000)
    la  x18, test_data
    addi    x18, x18,17
    li     x7, MASK_XLEN(33)
    add    x18, x18, x7
    lbu x14, -33(x18)
    sd x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x0000000000000000)

    # Testcase 138:  imm:0xfef, result rd:x15(0x00000000000000fe)
    la  x17, test_data
    addi    x17, x17,18
    li     x7, MASK_XLEN(17)
    add    x17, x17, x7
    lbu x15, -17(x17)
    sd x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x15, 0x00000000000000fe)

    # Testcase 139:  imm:0xff7, result rd:x16(0x00000000000000fd)
    la  x16, test_data
    addi    x16, x16,19
    li     x7, MASK_XLEN(9)
    add    x16, x16, x7
    lbu x16, -9(x16)
    sd x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x16, 0x00000000000000fd)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # Addresses for test data and results
    la x1, test_29_res

    # Testcase 140:  imm:0xffb, result rd:x17(0x00000000000000fb)
    la  x15, test_data
    addi    x15, x15,20
    li     x2, MASK_XLEN(5)
    add    x15, x15, x2
    lbu x17, -5(x15)
    sd x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x00000000000000fb)

    # Testcase 141:  imm:0xffd, result rd:x18(0x00000000000000f7)
    la  x14, test_data
    addi    x14, x14,21
    li     x2, MASK_XLEN(3)
    add    x14, x14, x2
    lbu x18, -3(x14)
    sd x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x00000000000000f7)

    # Testcase 142:  imm:0xffe, result rd:x19(0x00000000000000ef)
    la  x13, test_data
    addi    x13, x13,22
    li     x2, MASK_XLEN(2)
    add    x13, x13, x2
    lbu x19, -2(x13)
    sd x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x00000000000000ef)

    # Testcase 143:  imm:0x0, result rd:x20(0x00000000000000df)
    la  x12, test_data
    addi    x12, x12,23
    li     x2, MASK_XLEN(0)
    add    x12, x12, x2
    lbu x20, 0(x12)
    sd x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x00000000000000df)

    # Testcase 144:  imm:0x800, result rd:x21(0x00000000000000fe)
    la  x11, test_data
    addi    x11, x11,0
    li     x2, MASK_XLEN(2048)
    add    x11, x11, x2
    lbu x21, -2048(x11)
    sd x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x00000000000000fe)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # Addresses for test data and results
    la x1, test_30_res

    # Testcase 145:  imm:0x400, result rd:x22(0x00000000000000fd)
    la  x10, test_data
    addi    x10, x10,1
    li     x2, MASK_XLEN(-1024)
    add    x10, x10, x2
    lbu x22, 1024(x10)
    sd x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x00000000000000fd)

    # Testcase 146:  imm:0x200, result rd:x23(0x00000000000000fb)
    la  x9, test_data
    addi    x9, x9,2
    li     x2, MASK_XLEN(-512)
    add    x9, x9, x2
    lbu x23, 512(x9)
    sd x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x00000000000000fb)

    # Testcase 147:  imm:0x100, result rd:x24(0x00000000000000f7)
    la  x8, test_data
    addi    x8, x8,3
    li     x2, MASK_XLEN(-256)
    add    x8, x8, x2
    lbu x24, 256(x8)
    sd x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x00000000000000f7)

    # Testcase 148:  imm:0x80, result rd:x25(0x00000000000000ef)
    la  x7, test_data
    addi    x7, x7,4
    li     x2, MASK_XLEN(-128)
    add    x7, x7, x2
    lbu x25, 128(x7)
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x00000000000000ef)

    # Testcase 149:  imm:0x40, result rd:x26(0x00000000000000df)
    la  x6, test_data
    addi    x6, x6,5
    li     x2, MASK_XLEN(-64)
    add    x6, x6, x2
    lbu x26, 64(x6)
    sd x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x26, 0x00000000000000df)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # Addresses for test data and results
    la x6, test_31_res

    # Testcase 150:  imm:0x20, result rd:x27(0x00000000000000bf)
    la  x5, test_data
    addi    x5, x5,6
    li     x7, MASK_XLEN(-32)
    add    x5, x5, x7
    lbu x27, 32(x5)
    sd x27, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x00000000000000bf)

    # Testcase 151:  imm:0x10, result rd:x28(0x000000000000007f)
    la  x4, test_data
    addi    x4, x4,7
    li     x7, MASK_XLEN(-16)
    add    x4, x4, x7
    lbu x28, 16(x4)
    sd x28, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x000000000000007f)

    # Testcase 152:  imm:0x8, result rd:x29(0x00000000000000ff)
    la  x3, test_data
    addi    x3, x3,8
    li     x7, MASK_XLEN(-8)
    add    x3, x3, x7
    lbu x29, 8(x3)
    sd x29, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x00000000000000ff)

    # Testcase 153:  imm:0x4, result rd:x30(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,9
    li     x7, MASK_XLEN(-4)
    add    x2, x2, x7
    lbu x30, 4(x2)
    sd x30, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x30, 0x0000000000000001)

    # Testcase 154:  imm:0x2, result rd:x31(0x0000000000000002)
    la  x1, test_data
    addi    x1, x1,10
    li     x7, MASK_XLEN(-2)
    add    x1, x1, x7
    lbu x31, 2(x1)
    sd x31, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x31, 0x0000000000000002)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # Addresses for test data and results
    la x6, test_32_res

    # Testcase 155:  imm:0x1, result rd:x1(0x0000000000000004)
    la  x31, test_data
    addi    x31, x31,11
    li     x7, MASK_XLEN(-1)
    add    x31, x31, x7
    lbu x1, 1(x31)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x0000000000000004)

    # Testcase 156:  imm:0xfff, result rd:x2(0x0000000000000008)
    la  x30, test_data
    addi    x30, x30,12
    li     x7, MASK_XLEN(1)
    add    x30, x30, x7
    lbu x2, -1(x30)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x0000000000000008)

    # Testcase 157:  imm:0x7ff, result rd:x3(0x0000000000000010)
    la  x29, test_data
    addi    x29, x29,13
    li     x7, MASK_XLEN(-2047)
    add    x29, x29, x7
    lbu x3, 2047(x29)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x0000000000000010)

    # Testcase 158:  imm:0xbff, result rd:x4(0x0000000000000020)
    la  x28, test_data
    addi    x28, x28,14
    li     x7, MASK_XLEN(1025)
    add    x28, x28, x7
    lbu x4, -1025(x28)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x0000000000000020)

    # Testcase 159:  imm:0xdff, result rd:x5(0x0000000000000040)
    la  x27, test_data
    addi    x27, x27,15
    li     x7, MASK_XLEN(513)
    add    x27, x27, x7
    lbu x5, -513(x27)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x0000000000000040)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # Addresses for test data and results
    la x1, test_33_res

    # Testcase 160:  imm:0xeff, result rd:x6(0x0000000000000080)
    la  x26, test_data
    addi    x26, x26,16
    li     x2, MASK_XLEN(257)
    add    x26, x26, x2
    lbu x6, -257(x26)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x0000000000000080)

    # Testcase 161:  imm:0xf7f, result rd:x7(0x0000000000000000)
    la  x25, test_data
    addi    x25, x25,17
    li     x2, MASK_XLEN(129)
    add    x25, x25, x2
    lbu x7, -129(x25)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x0000000000000000)

    # Testcase 162:  imm:0xfbf, result rd:x8(0x00000000000000fe)
    la  x24, test_data
    addi    x24, x24,18
    li     x2, MASK_XLEN(65)
    add    x24, x24, x2
    lbu x8, -65(x24)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00000000000000fe)

    # Testcase 163:  imm:0xfdf, result rd:x9(0x00000000000000fd)
    la  x23, test_data
    addi    x23, x23,19
    li     x2, MASK_XLEN(33)
    add    x23, x23, x2
    lbu x9, -33(x23)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000000000000fd)

    # Testcase 164:  imm:0xfef, result rd:x10(0x00000000000000fb)
    la  x22, test_data
    addi    x22, x22,20
    li     x2, MASK_XLEN(17)
    add    x22, x22, x2
    lbu x10, -17(x22)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00000000000000fb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # Addresses for test data and results
    la x1, test_34_res

    # Testcase 165:  imm:0xff7, result rd:x11(0x00000000000000f7)
    la  x21, test_data
    addi    x21, x21,21
    li     x7, MASK_XLEN(9)
    add    x21, x21, x7
    lbu x11, -9(x21)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x11, 0x00000000000000f7)

    # Testcase 166:  imm:0xffb, result rd:x12(0x00000000000000ef)
    la  x20, test_data
    addi    x20, x20,22
    li     x7, MASK_XLEN(5)
    add    x20, x20, x7
    lbu x12, -5(x20)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x00000000000000ef)

    # Testcase 167:  imm:0xffd, result rd:x13(0x00000000000000df)
    la  x19, test_data
    addi    x19, x19,23
    li     x7, MASK_XLEN(3)
    add    x19, x19, x7
    lbu x13, -3(x19)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x00000000000000df)

    # Testcase 168:  imm:0xffe, result rd:x14(0x00000000000000fe)
    la  x18, test_data
    addi    x18, x18,0
    li     x7, MASK_XLEN(2)
    add    x18, x18, x7
    lbu x14, -2(x18)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x00000000000000fe)

    # Testcase 169:  imm:0x0, result rd:x15(0x00000000000000fd)
    la  x17, test_data
    addi    x17, x17,1
    li     x7, MASK_XLEN(0)
    add    x17, x17, x7
    lbu x15, 0(x17)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x15, 0x00000000000000fd)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # Addresses for test data and results
    la x2, test_35_res

    # Testcase 170:  imm:0x800, result rd:x16(0x00000000000000fb)
    la  x16, test_data
    addi    x16, x16,2
    li     x3, MASK_XLEN(2048)
    add    x16, x16, x3
    lbu x16, -2048(x16)
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x00000000000000fb)

    # Testcase 171:  imm:0x400, result rd:x17(0x00000000000000f7)
    la  x15, test_data
    addi    x15, x15,3
    li     x3, MASK_XLEN(-1024)
    add    x15, x15, x3
    lbu x17, 1024(x15)
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x00000000000000f7)

    # Testcase 172:  imm:0x200, result rd:x18(0x00000000000000ef)
    la  x14, test_data
    addi    x14, x14,4
    li     x3, MASK_XLEN(-512)
    add    x14, x14, x3
    lbu x18, 512(x14)
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x00000000000000ef)

    # Testcase 173:  imm:0x100, result rd:x19(0x00000000000000df)
    la  x13, test_data
    addi    x13, x13,5
    li     x3, MASK_XLEN(-256)
    add    x13, x13, x3
    lbu x19, 256(x13)
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x00000000000000df)

    # Testcase 174:  imm:0x80, result rd:x20(0x00000000000000bf)
    la  x12, test_data
    addi    x12, x12,6
    li     x3, MASK_XLEN(-128)
    add    x12, x12, x3
    lbu x20, 128(x12)
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x00000000000000bf)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # Addresses for test data and results
    la x1, test_36_res

    # Testcase 175:  imm:0x40, result rd:x21(0x000000000000007f)
    la  x11, test_data
    addi    x11, x11,7
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    lbu x21, 64(x11)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x000000000000007f)

    # Testcase 176:  imm:0x20, result rd:x22(0x00000000000000ff)
    la  x10, test_data
    addi    x10, x10,8
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    lbu x22, 32(x10)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x00000000000000ff)

    # Testcase 177:  imm:0x10, result rd:x23(0x0000000000000001)
    la  x9, test_data
    addi    x9, x9,9
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    lbu x23, 16(x9)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x0000000000000001)

    # Testcase 178:  imm:0x8, result rd:x24(0x0000000000000002)
    la  x8, test_data
    addi    x8, x8,10
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    lbu x24, 8(x8)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x0000000000000002)

    # Testcase 179:  imm:0x4, result rd:x25(0x0000000000000004)
    la  x7, test_data
    addi    x7, x7,11
    li     x2, MASK_XLEN(-4)
    add    x7, x7, x2
    lbu x25, 4(x7)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x0000000000000004)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # Addresses for test data and results
    la x1, test_37_res

    # Testcase 180:  imm:0x2, result rd:x26(0x0000000000000008)
    la  x6, test_data
    addi    x6, x6,12
    li     x7, MASK_XLEN(-2)
    add    x6, x6, x7
    lbu x26, 2(x6)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x26, 0x0000000000000008)

    # Testcase 181:  imm:0x1, result rd:x27(0x0000000000000010)
    la  x5, test_data
    addi    x5, x5,13
    li     x7, MASK_XLEN(-1)
    add    x5, x5, x7
    lbu x27, 1(x5)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x0000000000000010)

    # Testcase 182:  imm:0xfff, result rd:x28(0x0000000000000020)
    la  x4, test_data
    addi    x4, x4,14
    li     x7, MASK_XLEN(1)
    add    x4, x4, x7
    lbu x28, -1(x4)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x0000000000000020)

    # Testcase 183:  imm:0x7ff, result rd:x29(0x0000000000000040)
    la  x3, test_data
    addi    x3, x3,15
    li     x7, MASK_XLEN(-2047)
    add    x3, x3, x7
    lbu x29, 2047(x3)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x0000000000000040)

    # Testcase 184:  imm:0xbff, result rd:x30(0x0000000000000080)
    la  x2, test_data
    addi    x2, x2,16
    li     x7, MASK_XLEN(1025)
    add    x2, x2, x7
    lbu x30, -1025(x2)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x30, 0x0000000000000080)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # Addresses for test data and results
    la x5, test_38_res

    # Testcase 185:  imm:0xdff, result rd:x31(0x0000000000000000)
    la  x1, test_data
    addi    x1, x1,17
    li     x6, MASK_XLEN(513)
    add    x1, x1, x6
    lbu x31, -513(x1)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x0000000000000000)

    # Testcase 186:  imm:0xeff, result rd:x1(0x00000000000000fe)
    la  x31, test_data
    addi    x31, x31,18
    li     x6, MASK_XLEN(257)
    add    x31, x31, x6
    lbu x1, -257(x31)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x00000000000000fe)

    # Testcase 187:  imm:0xf7f, result rd:x2(0x00000000000000fd)
    la  x30, test_data
    addi    x30, x30,19
    li     x6, MASK_XLEN(129)
    add    x30, x30, x6
    lbu x2, -129(x30)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x00000000000000fd)

    # Testcase 188:  imm:0xfbf, result rd:x3(0x00000000000000fb)
    la  x29, test_data
    addi    x29, x29,20
    li     x6, MASK_XLEN(65)
    add    x29, x29, x6
    lbu x3, -65(x29)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x00000000000000fb)

    # Testcase 189:  imm:0xfdf, result rd:x4(0x00000000000000f7)
    la  x28, test_data
    addi    x28, x28,21
    li     x6, MASK_XLEN(33)
    add    x28, x28, x6
    lbu x4, -33(x28)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x00000000000000f7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # Addresses for test data and results
    la x1, test_39_res

    # Testcase 190:  imm:0xfef, result rd:x5(0x00000000000000ef)
    la  x27, test_data
    addi    x27, x27,22
    li     x2, MASK_XLEN(17)
    add    x27, x27, x2
    lbu x5, -17(x27)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x5, 0x00000000000000ef)

    # Testcase 191:  imm:0xff7, result rd:x6(0x00000000000000df)
    la  x26, test_data
    addi    x26, x26,23
    li     x2, MASK_XLEN(9)
    add    x26, x26, x2
    lbu x6, -9(x26)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x00000000000000df)

    # Testcase 192:  imm:0xffb, result rd:x7(0x00000000000000fe)
    la  x25, test_data
    addi    x25, x25,0
    li     x2, MASK_XLEN(5)
    add    x25, x25, x2
    lbu x7, -5(x25)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x00000000000000fe)

    # Testcase 193:  imm:0xffd, result rd:x8(0x00000000000000fd)
    la  x24, test_data
    addi    x24, x24,1
    li     x2, MASK_XLEN(3)
    add    x24, x24, x2
    lbu x8, -3(x24)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00000000000000fd)

    # Testcase 194:  imm:0xffe, result rd:x9(0x00000000000000fb)
    la  x23, test_data
    addi    x23, x23,2
    li     x2, MASK_XLEN(2)
    add    x23, x23, x2
    lbu x9, -2(x23)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000000000000fb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # Addresses for test data and results
    la x1, test_40_res

    # Testcase 195:  imm:0x0, result rd:x10(0x00000000000000f7)
    la  x22, test_data
    addi    x22, x22,3
    li     x2, MASK_XLEN(0)
    add    x22, x22, x2
    lbu x10, 0(x22)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x10, 0x00000000000000f7)

    # Testcase 196:  imm:0x800, result rd:x11(0x00000000000000ef)
    la  x21, test_data
    addi    x21, x21,4
    li     x2, MASK_XLEN(2048)
    add    x21, x21, x2
    lbu x11, -2048(x21)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x11, 0x00000000000000ef)

    # Testcase 197:  imm:0x400, result rd:x12(0x00000000000000df)
    la  x20, test_data
    addi    x20, x20,5
    li     x2, MASK_XLEN(-1024)
    add    x20, x20, x2
    lbu x12, 1024(x20)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x00000000000000df)

    # Testcase 198:  imm:0x200, result rd:x13(0x00000000000000bf)
    la  x19, test_data
    addi    x19, x19,6
    li     x2, MASK_XLEN(-512)
    add    x19, x19, x2
    lbu x13, 512(x19)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x00000000000000bf)

    # Testcase 199:  imm:0x100, result rd:x14(0x000000000000007f)
    la  x18, test_data
    addi    x18, x18,7
    li     x2, MASK_XLEN(-256)
    add    x18, x18, x2
    lbu x14, 256(x18)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x000000000000007f)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # Addresses for test data and results
    la x3, test_41_res

    # Testcase 200:  imm:0x80, result rd:x15(0x00000000000000ff)
    la  x17, test_data
    addi    x17, x17,8
    li     x4, MASK_XLEN(-128)
    add    x17, x17, x4
    lbu x15, 128(x17)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x00000000000000ff)

    # Testcase 201:  imm:0x40, result rd:x16(0x0000000000000001)
    la  x16, test_data
    addi    x16, x16,9
    li     x4, MASK_XLEN(-64)
    add    x16, x16, x4
    lbu x16, 64(x16)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0000000000000001)

    # Testcase 202:  imm:0x20, result rd:x17(0x0000000000000002)
    la  x15, test_data
    addi    x15, x15,10
    li     x4, MASK_XLEN(-32)
    add    x15, x15, x4
    lbu x17, 32(x15)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x0000000000000002)

    # Testcase 203:  imm:0x10, result rd:x18(0x0000000000000004)
    la  x14, test_data
    addi    x14, x14,11
    li     x4, MASK_XLEN(-16)
    add    x14, x14, x4
    lbu x18, 16(x14)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x0000000000000004)

    # Testcase 204:  imm:0x8, result rd:x19(0x0000000000000008)
    la  x13, test_data
    addi    x13, x13,12
    li     x4, MASK_XLEN(-8)
    add    x13, x13, x4
    lbu x19, 8(x13)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0x0000000000000008)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # Addresses for test data and results
    la x1, test_42_res

    # Testcase 205:  imm:0x4, result rd:x20(0x0000000000000010)
    la  x12, test_data
    addi    x12, x12,13
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    lbu x20, 4(x12)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0000000000000010)

    # Testcase 206:  imm:0x2, result rd:x21(0x0000000000000020)
    la  x11, test_data
    addi    x11, x11,14
    li     x2, MASK_XLEN(-2)
    add    x11, x11, x2
    lbu x21, 2(x11)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x0000000000000020)

    # Testcase 207:  imm:0x1, result rd:x22(0x0000000000000040)
    la  x10, test_data
    addi    x10, x10,15
    li     x2, MASK_XLEN(-1)
    add    x10, x10, x2
    lbu x22, 1(x10)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x0000000000000040)

    # Testcase 208:  imm:0xfff, result rd:x23(0x0000000000000080)
    la  x9, test_data
    addi    x9, x9,16
    li     x2, MASK_XLEN(1)
    add    x9, x9, x2
    lbu x23, -1(x9)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x0000000000000080)

    # Testcase 209:  imm:0x7ff, result rd:x24(0x0000000000000000)
    la  x8, test_data
    addi    x8, x8,17
    li     x2, MASK_XLEN(-2047)
    add    x8, x8, x2
    lbu x24, 2047(x8)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # Addresses for test data and results
    la x1, test_43_res

    # Testcase 210:  imm:0xbff, result rd:x25(0x00000000000000fe)
    la  x7, test_data
    addi    x7, x7,18
    li     x2, MASK_XLEN(1025)
    add    x7, x7, x2
    lbu x25, -1025(x7)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x25, 0x00000000000000fe)

    # Testcase 211:  imm:0xdff, result rd:x26(0x00000000000000fd)
    la  x6, test_data
    addi    x6, x6,19
    li     x2, MASK_XLEN(513)
    add    x6, x6, x2
    lbu x26, -513(x6)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x26, 0x00000000000000fd)

    # Testcase 212:  imm:0xeff, result rd:x27(0x00000000000000fb)
    la  x5, test_data
    addi    x5, x5,20
    li     x2, MASK_XLEN(257)
    add    x5, x5, x2
    lbu x27, -257(x5)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x00000000000000fb)

    # Testcase 213:  imm:0xf7f, result rd:x28(0x00000000000000f7)
    la  x4, test_data
    addi    x4, x4,21
    li     x2, MASK_XLEN(129)
    add    x4, x4, x2
    lbu x28, -129(x4)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x00000000000000f7)

    # Testcase 214:  imm:0xfbf, result rd:x29(0x00000000000000ef)
    la  x3, test_data
    addi    x3, x3,22
    li     x2, MASK_XLEN(65)
    add    x3, x3, x2
    lbu x29, -65(x3)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x00000000000000ef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # Addresses for test data and results
    la x4, test_44_res

    # Testcase 215:  imm:0xfdf, result rd:x30(0x00000000000000df)
    la  x2, test_data
    addi    x2, x2,23
    li     x5, MASK_XLEN(33)
    add    x2, x2, x5
    lbu x30, -33(x2)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x00000000000000df)

    # Testcase 216:  imm:0xfef, result rd:x31(0x00000000000000fe)
    la  x1, test_data
    addi    x1, x1,0
    li     x5, MASK_XLEN(17)
    add    x1, x1, x5
    lbu x31, -17(x1)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x00000000000000fe)

    # Testcase 217:  imm:0xff7, result rd:x1(0x00000000000000fd)
    la  x31, test_data
    addi    x31, x31,1
    li     x5, MASK_XLEN(9)
    add    x31, x31, x5
    lbu x1, -9(x31)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x00000000000000fd)

    # Testcase 218:  imm:0xffb, result rd:x2(0x00000000000000fb)
    la  x30, test_data
    addi    x30, x30,2
    li     x5, MASK_XLEN(5)
    add    x30, x30, x5
    lbu x2, -5(x30)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x00000000000000fb)

    # Testcase 219:  imm:0xffd, result rd:x3(0x00000000000000f7)
    la  x29, test_data
    addi    x29, x29,3
    li     x5, MASK_XLEN(3)
    add    x29, x29, x5
    lbu x3, -3(x29)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x00000000000000f7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # Addresses for test data and results
    la x1, test_45_res

    # Testcase 220:  imm:0xffe, result rd:x4(0x00000000000000ef)
    la  x28, test_data
    addi    x28, x28,4
    li     x2, MASK_XLEN(2)
    add    x28, x28, x2
    lbu x4, -2(x28)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000000000ef)

    # Testcase 221:  imm:0x0, result rd:x5(0x00000000000000df)
    la  x27, test_data
    addi    x27, x27,5
    li     x2, MASK_XLEN(0)
    add    x27, x27, x2
    lbu x5, 0(x27)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x5, 0x00000000000000df)

    # Testcase 222:  imm:0x800, result rd:x6(0x00000000000000bf)
    la  x26, test_data
    addi    x26, x26,6
    li     x2, MASK_XLEN(2048)
    add    x26, x26, x2
    lbu x6, -2048(x26)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x00000000000000bf)

    # Testcase 223:  imm:0x400, result rd:x7(0x000000000000007f)
    la  x25, test_data
    addi    x25, x25,7
    li     x2, MASK_XLEN(-1024)
    add    x25, x25, x2
    lbu x7, 1024(x25)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x000000000000007f)

    # Testcase 224:  imm:0x200, result rd:x8(0x00000000000000ff)
    la  x24, test_data
    addi    x24, x24,8
    li     x2, MASK_XLEN(-512)
    add    x24, x24, x2
    lbu x8, 512(x24)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00000000000000ff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # Addresses for test data and results
    la x1, test_46_res

    # Testcase 225:  imm:0x100, result rd:x9(0x0000000000000001)
    la  x23, test_data
    addi    x23, x23,9
    li     x2, MASK_XLEN(-256)
    add    x23, x23, x2
    lbu x9, 256(x23)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000001)

    # Testcase 226:  imm:0x80, result rd:x10(0x0000000000000002)
    la  x22, test_data
    addi    x22, x22,10
    li     x2, MASK_XLEN(-128)
    add    x22, x22, x2
    lbu x10, 128(x22)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000002)

    # Testcase 227:  imm:0x40, result rd:x11(0x0000000000000004)
    la  x21, test_data
    addi    x21, x21,11
    li     x2, MASK_XLEN(-64)
    add    x21, x21, x2
    lbu x11, 64(x21)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000004)

    # Testcase 228:  imm:0x20, result rd:x12(0x0000000000000008)
    la  x20, test_data
    addi    x20, x20,12
    li     x2, MASK_XLEN(-32)
    add    x20, x20, x2
    lbu x12, 32(x20)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000008)

    # Testcase 229:  imm:0x10, result rd:x13(0x0000000000000010)
    la  x19, test_data
    addi    x19, x19,13
    li     x2, MASK_XLEN(-16)
    add    x19, x19, x2
    lbu x13, 16(x19)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000010)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # Addresses for test data and results
    la x4, test_47_res

    # Testcase 230:  imm:0x8, result rd:x14(0x0000000000000020)
    la  x18, test_data
    addi    x18, x18,14
    li     x5, MASK_XLEN(-8)
    add    x18, x18, x5
    lbu x14, 8(x18)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x0000000000000020)

    # Testcase 231:  imm:0x4, result rd:x15(0x0000000000000040)
    la  x17, test_data
    addi    x17, x17,15
    li     x5, MASK_XLEN(-4)
    add    x17, x17, x5
    lbu x15, 4(x17)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x0000000000000040)

    # Testcase 232:  imm:0x2, result rd:x16(0x0000000000000080)
    la  x16, test_data
    addi    x16, x16,16
    li     x5, MASK_XLEN(-2)
    add    x16, x16, x5
    lbu x16, 2(x16)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x0000000000000080)

    # Testcase 233:  imm:0x1, result rd:x17(0x0000000000000000)
    la  x15, test_data
    addi    x15, x15,17
    li     x5, MASK_XLEN(-1)
    add    x15, x15, x5
    lbu x17, 1(x15)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x0000000000000000)

    # Testcase 234:  imm:0xfff, result rd:x18(0x00000000000000fe)
    la  x14, test_data
    addi    x14, x14,18
    li     x5, MASK_XLEN(1)
    add    x14, x14, x5
    lbu x18, -1(x14)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x18, 0x00000000000000fe)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # Addresses for test data and results
    la x1, test_48_res

    # Testcase 235:  imm:0x7ff, result rd:x19(0x00000000000000fd)
    la  x13, test_data
    addi    x13, x13,19
    li     x2, MASK_XLEN(-2047)
    add    x13, x13, x2
    lbu x19, 2047(x13)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x00000000000000fd)

    # Testcase 236:  imm:0xbff, result rd:x20(0x00000000000000fb)
    la  x12, test_data
    addi    x12, x12,20
    li     x2, MASK_XLEN(1025)
    add    x12, x12, x2
    lbu x20, -1025(x12)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x00000000000000fb)

    # Testcase 237:  imm:0xdff, result rd:x21(0x00000000000000f7)
    la  x11, test_data
    addi    x11, x11,21
    li     x2, MASK_XLEN(513)
    add    x11, x11, x2
    lbu x21, -513(x11)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x00000000000000f7)

    # Testcase 238:  imm:0xeff, result rd:x22(0x00000000000000ef)
    la  x10, test_data
    addi    x10, x10,22
    li     x2, MASK_XLEN(257)
    add    x10, x10, x2
    lbu x22, -257(x10)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x00000000000000ef)

    # Testcase 239:  imm:0xf7f, result rd:x23(0x00000000000000df)
    la  x9, test_data
    addi    x9, x9,23
    li     x2, MASK_XLEN(129)
    add    x9, x9, x2
    lbu x23, -129(x9)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x00000000000000df)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # Addresses for test data and results
    la x1, test_49_res

    # Testcase 240:  imm:0xfbf, result rd:x24(0x00000000000000fe)
    la  x8, test_data
    addi    x8, x8,0
    li     x2, MASK_XLEN(65)
    add    x8, x8, x2
    lbu x24, -65(x8)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x00000000000000fe)

    # Testcase 241:  imm:0xfdf, result rd:x25(0x00000000000000fd)
    la  x7, test_data
    addi    x7, x7,1
    li     x2, MASK_XLEN(33)
    add    x7, x7, x2
    lbu x25, -33(x7)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x00000000000000fd)

    # Testcase 242:  imm:0xfef, result rd:x26(0x00000000000000fb)
    la  x6, test_data
    addi    x6, x6,2
    li     x2, MASK_XLEN(17)
    add    x6, x6, x2
    lbu x26, -17(x6)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x26, 0x00000000000000fb)

    # Testcase 243:  imm:0xff7, result rd:x27(0x00000000000000f7)
    la  x5, test_data
    addi    x5, x5,3
    li     x2, MASK_XLEN(9)
    add    x5, x5, x2
    lbu x27, -9(x5)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x27, 0x00000000000000f7)

    # Testcase 244:  imm:0xffb, result rd:x28(0x00000000000000ef)
    la  x4, test_data
    addi    x4, x4,4
    li     x2, MASK_XLEN(5)
    add    x4, x4, x2
    lbu x28, -5(x4)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x28, 0x00000000000000ef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # Addresses for test data and results
    la x4, test_50_res

    # Testcase 245:  imm:0xffd, result rd:x29(0x00000000000000df)
    la  x3, test_data
    addi    x3, x3,5
    li     x5, MASK_XLEN(3)
    add    x3, x3, x5
    lbu x29, -3(x3)
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x00000000000000df)

    # Testcase 246:  imm:0xffe, result rd:x30(0x00000000000000bf)
    la  x2, test_data
    addi    x2, x2,6
    li     x5, MASK_XLEN(2)
    add    x2, x2, x5
    lbu x30, -2(x2)
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x00000000000000bf)

    # Testcase 247:  imm:0x0, result rd:x31(0x000000000000007f)
    la  x1, test_data
    addi    x1, x1,7
    li     x5, MASK_XLEN(0)
    add    x1, x1, x5
    lbu x31, 0(x1)
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x000000000000007f)

    # Testcase 248:  imm:0x800, result rd:x1(0x00000000000000ff)
    la  x31, test_data
    addi    x31, x31,8
    li     x5, MASK_XLEN(2048)
    add    x31, x31, x5
    lbu x1, -2048(x31)
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x00000000000000ff)

    # Testcase 249:  imm:0x400, result rd:x2(0x0000000000000001)
    la  x30, test_data
    addi    x30, x30,9
    li     x5, MASK_XLEN(-1024)
    add    x30, x30, x5
    lbu x2, 1024(x30)
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0000000000000001)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # Addresses for test data and results
    la x1, test_51_res

    # Testcase 250:  imm:0x200, result rd:x3(0x0000000000000002)
    la  x29, test_data
    addi    x29, x29,10
    li     x2, MASK_XLEN(-512)
    add    x29, x29, x2
    lbu x3, 512(x29)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x0000000000000002)

    # Testcase 251:  imm:0x100, result rd:x4(0x0000000000000004)
    la  x28, test_data
    addi    x28, x28,11
    li     x2, MASK_XLEN(-256)
    add    x28, x28, x2
    lbu x4, 256(x28)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x0000000000000004)

    # Testcase 252:  imm:0x80, result rd:x5(0x0000000000000008)
    la  x27, test_data
    addi    x27, x27,12
    li     x2, MASK_XLEN(-128)
    add    x27, x27, x2
    lbu x5, 128(x27)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x0000000000000008)

    # Testcase 253:  imm:0x40, result rd:x6(0x0000000000000010)
    la  x26, test_data
    addi    x26, x26,13
    li     x2, MASK_XLEN(-64)
    add    x26, x26, x2
    lbu x6, 64(x26)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x0000000000000010)

    # Testcase 254:  imm:0x20, result rd:x7(0x0000000000000020)
    la  x25, test_data
    addi    x25, x25,14
    li     x2, MASK_XLEN(-32)
    add    x25, x25, x2
    lbu x7, 32(x25)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x7, 0x0000000000000020)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # Addresses for test data and results
    la x1, test_52_res

    # Testcase 255:  imm:0x10, result rd:x8(0x0000000000000040)
    la  x24, test_data
    addi    x24, x24,15
    li     x2, MASK_XLEN(-16)
    add    x24, x24, x2
    lbu x8, 16(x24)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000040)

    # Testcase 256:  imm:0x8, result rd:x9(0x0000000000000080)
    la  x23, test_data
    addi    x23, x23,16
    li     x2, MASK_XLEN(-8)
    add    x23, x23, x2
    lbu x9, 8(x23)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000080)

    # Testcase 257:  imm:0x4, result rd:x10(0x0000000000000000)
    la  x22, test_data
    addi    x22, x22,17
    li     x2, MASK_XLEN(-4)
    add    x22, x22, x2
    lbu x10, 4(x22)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000000)

    # Testcase 258:  imm:0x2, result rd:x11(0x00000000000000fe)
    la  x21, test_data
    addi    x21, x21,18
    li     x2, MASK_XLEN(-2)
    add    x21, x21, x2
    lbu x11, 2(x21)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00000000000000fe)

    # Testcase 259:  imm:0x1, result rd:x12(0x00000000000000fd)
    la  x20, test_data
    addi    x20, x20,19
    li     x2, MASK_XLEN(-1)
    add    x20, x20, x2
    lbu x12, 1(x20)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00000000000000fd)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # Addresses for test data and results
    la x2, test_53_res

    # Testcase 260:  imm:0xfff, result rd:x13(0x00000000000000fb)
    la  x19, test_data
    addi    x19, x19,20
    li     x5, MASK_XLEN(1)
    add    x19, x19, x5
    lbu x13, -1(x19)
    sd x13, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x00000000000000fb)

    # Testcase 261:  imm:0x7ff, result rd:x0(0x0000000000000000)
    la  x18, test_data
    addi    x18, x18,21
    li     x5, MASK_XLEN(-2047)
    add    x18, x18, x5
    lbu x0, 2047(x18)
    sd x0, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x0, 0x0000000000000000)

    # Testcase 262:  imm:0xbff, result rd:x15(0x00000000000000ef)
    la  x17, test_data
    addi    x17, x17,22
    li     x5, MASK_XLEN(1025)
    add    x17, x17, x5
    lbu x15, -1025(x17)
    sd x15, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x00000000000000ef)

    # Testcase 263:  imm:0xdff, result rd:x16(0x00000000000000df)
    la  x16, test_data
    addi    x16, x16,23
    li     x5, MASK_XLEN(513)
    add    x16, x16, x5
    lbu x16, -513(x16)
    sd x16, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x00000000000000df)



	# ---------------------------------------------------------------------------------------------
	
	RVTEST_IO_WRITE_STR(x31, "Test End\n")

	# ---------------------------------------------------------------------------------------------

	RV_COMPLIANCE_HALT

RV_COMPLIANCE_CODE_END

# Input data section.
	.data

	.align 8
test_data:

	.dword 0x7fbfdfeff7fbfdfe
	.dword 0x40201008040201ff
	.dword 0xdfeff7fbfdfe0080


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

