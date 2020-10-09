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
# Specification: RV32I Base Integer Instruction Set, Version 2.1
# Description: Testing instruction 'LBU'.

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


    # Addresses for test data and results
    la x6, test_1_res

    # Testcase 0:  imm:0xfff, result rd:x1(0x000000fe)
    la  x31, test_data
    addi    x31, x31,0
    li     x7, MASK_XLEN(1)
    add    x31, x31, x7
    lbu x1, -1(x31)
    sw x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x000000fe)

    # Testcase 1:  imm:0x7ff, result rd:x2(0x000000fd)
    la  x30, test_data
    addi    x30, x30,1
    li     x7, MASK_XLEN(-2047)
    add    x30, x30, x7
    lbu x2, 2047(x30)
    sw x2, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x000000fd)

    # Testcase 2:  imm:0xbff, result rd:x3(0x000000fb)
    la  x29, test_data
    addi    x29, x29,2
    li     x7, MASK_XLEN(1025)
    add    x29, x29, x7
    lbu x3, -1025(x29)
    sw x3, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x000000fb)

    # Testcase 3:  imm:0xdff, result rd:x4(0x000000f7)
    la  x28, test_data
    addi    x28, x28,3
    li     x7, MASK_XLEN(513)
    add    x28, x28, x7
    lbu x4, -513(x28)
    sw x4, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x000000f7)

    # Testcase 4:  imm:0xeff, result rd:x5(0x000000ef)
    la  x27, test_data
    addi    x27, x27,4
    li     x7, MASK_XLEN(257)
    add    x27, x27, x7
    lbu x5, -257(x27)
    sw x5, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x000000ef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # Addresses for test data and results
    la x1, test_2_res

    # Testcase 5:  imm:0xf7f, result rd:x6(0x000000df)
    la  x26, test_data
    addi    x26, x26,5
    li     x2, MASK_XLEN(129)
    add    x26, x26, x2
    lbu x6, -129(x26)
    sw x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x000000df)

    # Testcase 6:  imm:0xfbf, result rd:x7(0x000000bf)
    la  x25, test_data
    addi    x25, x25,6
    li     x2, MASK_XLEN(65)
    add    x25, x25, x2
    lbu x7, -65(x25)
    sw x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x000000bf)

    # Testcase 7:  imm:0xfdf, result rd:x8(0x0000007f)
    la  x24, test_data
    addi    x24, x24,7
    li     x2, MASK_XLEN(33)
    add    x24, x24, x2
    lbu x8, -33(x24)
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000007f)

    # Testcase 8:  imm:0xfef, result rd:x9(0x000000ff)
    la  x23, test_data
    addi    x23, x23,8
    li     x2, MASK_XLEN(17)
    add    x23, x23, x2
    lbu x9, -17(x23)
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x000000ff)

    # Testcase 9:  imm:0xff7, result rd:x10(0x00000001)
    la  x22, test_data
    addi    x22, x22,9
    li     x2, MASK_XLEN(9)
    add    x22, x22, x2
    lbu x10, -9(x22)
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00000001)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # Addresses for test data and results
    la x1, test_3_res

    # Testcase 10:  imm:0xffb, result rd:x11(0x00000002)
    la  x21, test_data
    addi    x21, x21,10
    li     x7, MASK_XLEN(5)
    add    x21, x21, x7
    lbu x11, -5(x21)
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x11, 0x00000002)

    # Testcase 11:  imm:0xffd, result rd:x12(0x00000004)
    la  x20, test_data
    addi    x20, x20,11
    li     x7, MASK_XLEN(3)
    add    x20, x20, x7
    lbu x12, -3(x20)
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x00000004)

    # Testcase 12:  imm:0xffe, result rd:x13(0x00000008)
    la  x19, test_data
    addi    x19, x19,12
    li     x7, MASK_XLEN(2)
    add    x19, x19, x7
    lbu x13, -2(x19)
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x00000008)

    # Testcase 13:  imm:0x0, result rd:x14(0x00000010)
    la  x18, test_data
    addi    x18, x18,13
    li     x7, MASK_XLEN(0)
    add    x18, x18, x7
    lbu x14, 0(x18)
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x00000010)

    # Testcase 14:  imm:0x800, result rd:x15(0x00000020)
    la  x17, test_data
    addi    x17, x17,14
    li     x7, MASK_XLEN(2048)
    add    x17, x17, x7
    lbu x15, -2048(x17)
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x15, 0x00000020)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # Addresses for test data and results
    la x2, test_4_res

    # Testcase 15:  imm:0x400, result rd:x16(0x00000040)
    la  x16, test_data
    addi    x16, x16,15
    li     x3, MASK_XLEN(-1024)
    add    x16, x16, x3
    lbu x16, 1024(x16)
    sw x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x00000040)

    # Testcase 16:  imm:0x200, result rd:x17(0x00000080)
    la  x15, test_data
    addi    x15, x15,16
    li     x3, MASK_XLEN(-512)
    add    x15, x15, x3
    lbu x17, 512(x15)
    sw x17, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x00000080)

    # Testcase 17:  imm:0x100, result rd:x18(0x00000000)
    la  x14, test_data
    addi    x14, x14,17
    li     x3, MASK_XLEN(-256)
    add    x14, x14, x3
    lbu x18, 256(x14)
    sw x18, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x00000000)

    # Testcase 18:  imm:0x80, result rd:x19(0x000000fe)
    la  x13, test_data
    addi    x13, x13,18
    li     x3, MASK_XLEN(-128)
    add    x13, x13, x3
    lbu x19, 128(x13)
    sw x19, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x000000fe)

    # Testcase 19:  imm:0x40, result rd:x20(0x000000fd)
    la  x12, test_data
    addi    x12, x12,19
    li     x3, MASK_XLEN(-64)
    add    x12, x12, x3
    lbu x20, 64(x12)
    sw x20, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x000000fd)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # Addresses for test data and results
    la x1, test_5_res

    # Testcase 20:  imm:0x20, result rd:x21(0x000000fb)
    la  x11, test_data
    addi    x11, x11,20
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    lbu x21, 32(x11)
    sw x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x000000fb)

    # Testcase 21:  imm:0x10, result rd:x22(0x000000f7)
    la  x10, test_data
    addi    x10, x10,21
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    lbu x22, 16(x10)
    sw x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x000000f7)

    # Testcase 22:  imm:0x8, result rd:x23(0x000000ef)
    la  x9, test_data
    addi    x9, x9,22
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    lbu x23, 8(x9)
    sw x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x000000ef)

    # Testcase 23:  imm:0x4, result rd:x24(0x000000df)
    la  x8, test_data
    addi    x8, x8,23
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    lbu x24, 4(x8)
    sw x24, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x000000df)

    # Testcase 24:  imm:0x2, result rd:x25(0x000000fe)
    la  x7, test_data
    addi    x7, x7,0
    li     x2, MASK_XLEN(-2)
    add    x7, x7, x2
    lbu x25, 2(x7)
    sw x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x000000fe)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # Addresses for test data and results
    la x1, test_6_res

    # Testcase 25:  imm:0x1, result rd:x26(0x000000fd)
    la  x6, test_data
    addi    x6, x6,1
    li     x7, MASK_XLEN(-1)
    add    x6, x6, x7
    lbu x26, 1(x6)
    sw x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x26, 0x000000fd)

    # Testcase 26:  imm:0xfff, result rd:x27(0x000000fb)
    la  x5, test_data
    addi    x5, x5,2
    li     x7, MASK_XLEN(1)
    add    x5, x5, x7
    lbu x27, -1(x5)
    sw x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x000000fb)

    # Testcase 27:  imm:0x7ff, result rd:x28(0x000000f7)
    la  x4, test_data
    addi    x4, x4,3
    li     x7, MASK_XLEN(-2047)
    add    x4, x4, x7
    lbu x28, 2047(x4)
    sw x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x000000f7)

    # Testcase 28:  imm:0xbff, result rd:x29(0x000000ef)
    la  x3, test_data
    addi    x3, x3,4
    li     x7, MASK_XLEN(1025)
    add    x3, x3, x7
    lbu x29, -1025(x3)
    sw x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x000000ef)

    # Testcase 29:  imm:0xdff, result rd:x30(0x000000df)
    la  x2, test_data
    addi    x2, x2,5
    li     x7, MASK_XLEN(513)
    add    x2, x2, x7
    lbu x30, -513(x2)
    sw x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x30, 0x000000df)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # Addresses for test data and results
    la x5, test_7_res

    # Testcase 30:  imm:0xeff, result rd:x31(0x000000bf)
    la  x1, test_data
    addi    x1, x1,6
    li     x6, MASK_XLEN(257)
    add    x1, x1, x6
    lbu x31, -257(x1)
    sw x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x000000bf)

    # Testcase 31:  imm:0xf7f, result rd:x1(0x0000007f)
    la  x31, test_data
    addi    x31, x31,7
    li     x6, MASK_XLEN(129)
    add    x31, x31, x6
    lbu x1, -129(x31)
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x0000007f)

    # Testcase 32:  imm:0xfbf, result rd:x2(0x000000ff)
    la  x30, test_data
    addi    x30, x30,8
    li     x6, MASK_XLEN(65)
    add    x30, x30, x6
    lbu x2, -65(x30)
    sw x2, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x000000ff)

    # Testcase 33:  imm:0xfdf, result rd:x3(0x00000001)
    la  x29, test_data
    addi    x29, x29,9
    li     x6, MASK_XLEN(33)
    add    x29, x29, x6
    lbu x3, -33(x29)
    sw x3, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x00000001)

    # Testcase 34:  imm:0xfef, result rd:x4(0x00000002)
    la  x28, test_data
    addi    x28, x28,10
    li     x6, MASK_XLEN(17)
    add    x28, x28, x6
    lbu x4, -17(x28)
    sw x4, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x00000002)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # Addresses for test data and results
    la x1, test_8_res

    # Testcase 35:  imm:0xff7, result rd:x5(0x00000004)
    la  x27, test_data
    addi    x27, x27,11
    li     x2, MASK_XLEN(9)
    add    x27, x27, x2
    lbu x5, -9(x27)
    sw x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x5, 0x00000004)

    # Testcase 36:  imm:0xffb, result rd:x6(0x00000008)
    la  x26, test_data
    addi    x26, x26,12
    li     x2, MASK_XLEN(5)
    add    x26, x26, x2
    lbu x6, -5(x26)
    sw x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x00000008)

    # Testcase 37:  imm:0xffd, result rd:x7(0x00000010)
    la  x25, test_data
    addi    x25, x25,13
    li     x2, MASK_XLEN(3)
    add    x25, x25, x2
    lbu x7, -3(x25)
    sw x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x00000010)

    # Testcase 38:  imm:0xffe, result rd:x8(0x00000020)
    la  x24, test_data
    addi    x24, x24,14
    li     x2, MASK_XLEN(2)
    add    x24, x24, x2
    lbu x8, -2(x24)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00000020)

    # Testcase 39:  imm:0x0, result rd:x9(0x00000040)
    la  x23, test_data
    addi    x23, x23,15
    li     x2, MASK_XLEN(0)
    add    x23, x23, x2
    lbu x9, 0(x23)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000040)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # Addresses for test data and results
    la x1, test_9_res

    # Testcase 40:  imm:0x800, result rd:x10(0x00000080)
    la  x22, test_data
    addi    x22, x22,16
    li     x2, MASK_XLEN(2048)
    add    x22, x22, x2
    lbu x10, -2048(x22)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x10, 0x00000080)

    # Testcase 41:  imm:0x400, result rd:x11(0x00000000)
    la  x21, test_data
    addi    x21, x21,17
    li     x2, MASK_XLEN(-1024)
    add    x21, x21, x2
    lbu x11, 1024(x21)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x11, 0x00000000)

    # Testcase 42:  imm:0x200, result rd:x12(0x000000fe)
    la  x20, test_data
    addi    x20, x20,18
    li     x2, MASK_XLEN(-512)
    add    x20, x20, x2
    lbu x12, 512(x20)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x000000fe)

    # Testcase 43:  imm:0x100, result rd:x13(0x000000fd)
    la  x19, test_data
    addi    x19, x19,19
    li     x2, MASK_XLEN(-256)
    add    x19, x19, x2
    lbu x13, 256(x19)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x000000fd)

    # Testcase 44:  imm:0x80, result rd:x14(0x000000fb)
    la  x18, test_data
    addi    x18, x18,20
    li     x2, MASK_XLEN(-128)
    add    x18, x18, x2
    lbu x14, 128(x18)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x000000fb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # Addresses for test data and results
    la x3, test_10_res

    # Testcase 45:  imm:0x40, result rd:x15(0x000000f7)
    la  x17, test_data
    addi    x17, x17,21
    li     x4, MASK_XLEN(-64)
    add    x17, x17, x4
    lbu x15, 64(x17)
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x000000f7)

    # Testcase 46:  imm:0x20, result rd:x16(0x000000ef)
    la  x16, test_data
    addi    x16, x16,22
    li     x4, MASK_XLEN(-32)
    add    x16, x16, x4
    lbu x16, 32(x16)
    sw x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x000000ef)

    # Testcase 47:  imm:0x10, result rd:x17(0x000000df)
    la  x15, test_data
    addi    x15, x15,23
    li     x4, MASK_XLEN(-16)
    add    x15, x15, x4
    lbu x17, 16(x15)
    sw x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x000000df)

    # Testcase 48:  imm:0x8, result rd:x18(0x000000fe)
    la  x14, test_data
    addi    x14, x14,0
    li     x4, MASK_XLEN(-8)
    add    x14, x14, x4
    lbu x18, 8(x14)
    sw x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x000000fe)

    # Testcase 49:  imm:0x4, result rd:x19(0x000000fd)
    la  x13, test_data
    addi    x13, x13,1
    li     x4, MASK_XLEN(-4)
    add    x13, x13, x4
    lbu x19, 4(x13)
    sw x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0x000000fd)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # Addresses for test data and results
    la x1, test_11_res

    # Testcase 50:  imm:0x2, result rd:x20(0x000000fb)
    la  x12, test_data
    addi    x12, x12,2
    li     x2, MASK_XLEN(-2)
    add    x12, x12, x2
    lbu x20, 2(x12)
    sw x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x000000fb)

    # Testcase 51:  imm:0x1, result rd:x21(0x000000f7)
    la  x11, test_data
    addi    x11, x11,3
    li     x2, MASK_XLEN(-1)
    add    x11, x11, x2
    lbu x21, 1(x11)
    sw x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x000000f7)

    # Testcase 52:  imm:0xfff, result rd:x22(0x000000ef)
    la  x10, test_data
    addi    x10, x10,4
    li     x2, MASK_XLEN(1)
    add    x10, x10, x2
    lbu x22, -1(x10)
    sw x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x000000ef)

    # Testcase 53:  imm:0x7ff, result rd:x23(0x000000df)
    la  x9, test_data
    addi    x9, x9,5
    li     x2, MASK_XLEN(-2047)
    add    x9, x9, x2
    lbu x23, 2047(x9)
    sw x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x000000df)

    # Testcase 54:  imm:0xbff, result rd:x24(0x000000bf)
    la  x8, test_data
    addi    x8, x8,6
    li     x2, MASK_XLEN(1025)
    add    x8, x8, x2
    lbu x24, -1025(x8)
    sw x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x000000bf)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # Addresses for test data and results
    la x1, test_12_res

    # Testcase 55:  imm:0xdff, result rd:x25(0x0000007f)
    la  x7, test_data
    addi    x7, x7,7
    li     x2, MASK_XLEN(513)
    add    x7, x7, x2
    lbu x25, -513(x7)
    sw x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x25, 0x0000007f)

    # Testcase 56:  imm:0xeff, result rd:x26(0x000000ff)
    la  x6, test_data
    addi    x6, x6,8
    li     x2, MASK_XLEN(257)
    add    x6, x6, x2
    lbu x26, -257(x6)
    sw x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x26, 0x000000ff)

    # Testcase 57:  imm:0xf7f, result rd:x27(0x00000001)
    la  x5, test_data
    addi    x5, x5,9
    li     x2, MASK_XLEN(129)
    add    x5, x5, x2
    lbu x27, -129(x5)
    sw x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x00000001)

    # Testcase 58:  imm:0xfbf, result rd:x28(0x00000002)
    la  x4, test_data
    addi    x4, x4,10
    li     x2, MASK_XLEN(65)
    add    x4, x4, x2
    lbu x28, -65(x4)
    sw x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x00000002)

    # Testcase 59:  imm:0xfdf, result rd:x29(0x00000004)
    la  x3, test_data
    addi    x3, x3,11
    li     x2, MASK_XLEN(33)
    add    x3, x3, x2
    lbu x29, -33(x3)
    sw x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x00000004)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # Addresses for test data and results
    la x4, test_13_res

    # Testcase 60:  imm:0xfef, result rd:x30(0x00000008)
    la  x2, test_data
    addi    x2, x2,12
    li     x5, MASK_XLEN(17)
    add    x2, x2, x5
    lbu x30, -17(x2)
    sw x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x00000008)

    # Testcase 61:  imm:0xff7, result rd:x31(0x00000010)
    la  x1, test_data
    addi    x1, x1,13
    li     x5, MASK_XLEN(9)
    add    x1, x1, x5
    lbu x31, -9(x1)
    sw x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x00000010)

    # Testcase 62:  imm:0xffb, result rd:x1(0x00000020)
    la  x31, test_data
    addi    x31, x31,14
    li     x5, MASK_XLEN(5)
    add    x31, x31, x5
    lbu x1, -5(x31)
    sw x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x00000020)

    # Testcase 63:  imm:0xffd, result rd:x2(0x00000040)
    la  x30, test_data
    addi    x30, x30,15
    li     x5, MASK_XLEN(3)
    add    x30, x30, x5
    lbu x2, -3(x30)
    sw x2, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x00000040)

    # Testcase 64:  imm:0xffe, result rd:x3(0x00000080)
    la  x29, test_data
    addi    x29, x29,16
    li     x5, MASK_XLEN(2)
    add    x29, x29, x5
    lbu x3, -2(x29)
    sw x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x00000080)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # Addresses for test data and results
    la x1, test_14_res

    # Testcase 65:  imm:0x0, result rd:x4(0x00000000)
    la  x28, test_data
    addi    x28, x28,17
    li     x2, MASK_XLEN(0)
    add    x28, x28, x2
    lbu x4, 0(x28)
    sw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Testcase 66:  imm:0x800, result rd:x5(0x000000fe)
    la  x27, test_data
    addi    x27, x27,18
    li     x2, MASK_XLEN(2048)
    add    x27, x27, x2
    lbu x5, -2048(x27)
    sw x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x5, 0x000000fe)

    # Testcase 67:  imm:0x400, result rd:x6(0x000000fd)
    la  x26, test_data
    addi    x26, x26,19
    li     x2, MASK_XLEN(-1024)
    add    x26, x26, x2
    lbu x6, 1024(x26)
    sw x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x000000fd)

    # Testcase 68:  imm:0x200, result rd:x7(0x000000fb)
    la  x25, test_data
    addi    x25, x25,20
    li     x2, MASK_XLEN(-512)
    add    x25, x25, x2
    lbu x7, 512(x25)
    sw x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x000000fb)

    # Testcase 69:  imm:0x100, result rd:x8(0x000000f7)
    la  x24, test_data
    addi    x24, x24,21
    li     x2, MASK_XLEN(-256)
    add    x24, x24, x2
    lbu x8, 256(x24)
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x000000f7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # Addresses for test data and results
    la x1, test_15_res

    # Testcase 70:  imm:0x80, result rd:x9(0x000000ef)
    la  x23, test_data
    addi    x23, x23,22
    li     x2, MASK_XLEN(-128)
    add    x23, x23, x2
    lbu x9, 128(x23)
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x000000ef)

    # Testcase 71:  imm:0x40, result rd:x10(0x000000df)
    la  x22, test_data
    addi    x22, x22,23
    li     x2, MASK_XLEN(-64)
    add    x22, x22, x2
    lbu x10, 64(x22)
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x000000df)

    # Testcase 72:  imm:0x20, result rd:x11(0x000000fe)
    la  x21, test_data
    addi    x21, x21,0
    li     x2, MASK_XLEN(-32)
    add    x21, x21, x2
    lbu x11, 32(x21)
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x000000fe)

    # Testcase 73:  imm:0x10, result rd:x12(0x000000fd)
    la  x20, test_data
    addi    x20, x20,1
    li     x2, MASK_XLEN(-16)
    add    x20, x20, x2
    lbu x12, 16(x20)
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x000000fd)

    # Testcase 74:  imm:0x8, result rd:x13(0x000000fb)
    la  x19, test_data
    addi    x19, x19,2
    li     x2, MASK_XLEN(-8)
    add    x19, x19, x2
    lbu x13, 8(x19)
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x000000fb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # Addresses for test data and results
    la x4, test_16_res

    # Testcase 75:  imm:0x4, result rd:x14(0x000000f7)
    la  x18, test_data
    addi    x18, x18,3
    li     x5, MASK_XLEN(-4)
    add    x18, x18, x5
    lbu x14, 4(x18)
    sw x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x000000f7)

    # Testcase 76:  imm:0x2, result rd:x15(0x000000ef)
    la  x17, test_data
    addi    x17, x17,4
    li     x5, MASK_XLEN(-2)
    add    x17, x17, x5
    lbu x15, 2(x17)
    sw x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x000000ef)

    # Testcase 77:  imm:0x1, result rd:x16(0x000000df)
    la  x16, test_data
    addi    x16, x16,5
    li     x5, MASK_XLEN(-1)
    add    x16, x16, x5
    lbu x16, 1(x16)
    sw x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x000000df)

    # Testcase 78:  imm:0xfff, result rd:x17(0x000000bf)
    la  x15, test_data
    addi    x15, x15,6
    li     x5, MASK_XLEN(1)
    add    x15, x15, x5
    lbu x17, -1(x15)
    sw x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x000000bf)

    # Testcase 79:  imm:0x7ff, result rd:x18(0x0000007f)
    la  x14, test_data
    addi    x14, x14,7
    li     x5, MASK_XLEN(-2047)
    add    x14, x14, x5
    lbu x18, 2047(x14)
    sw x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x18, 0x0000007f)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # Addresses for test data and results
    la x1, test_17_res

    # Testcase 80:  imm:0xbff, result rd:x19(0x000000ff)
    la  x13, test_data
    addi    x13, x13,8
    li     x2, MASK_XLEN(1025)
    add    x13, x13, x2
    lbu x19, -1025(x13)
    sw x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x000000ff)

    # Testcase 81:  imm:0xdff, result rd:x20(0x00000001)
    la  x12, test_data
    addi    x12, x12,9
    li     x2, MASK_XLEN(513)
    add    x12, x12, x2
    lbu x20, -513(x12)
    sw x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x00000001)

    # Testcase 82:  imm:0xeff, result rd:x21(0x00000002)
    la  x11, test_data
    addi    x11, x11,10
    li     x2, MASK_XLEN(257)
    add    x11, x11, x2
    lbu x21, -257(x11)
    sw x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x00000002)

    # Testcase 83:  imm:0xf7f, result rd:x22(0x00000004)
    la  x10, test_data
    addi    x10, x10,11
    li     x2, MASK_XLEN(129)
    add    x10, x10, x2
    lbu x22, -129(x10)
    sw x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x00000004)

    # Testcase 84:  imm:0xfbf, result rd:x23(0x00000008)
    la  x9, test_data
    addi    x9, x9,12
    li     x2, MASK_XLEN(65)
    add    x9, x9, x2
    lbu x23, -65(x9)
    sw x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x00000008)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # Addresses for test data and results
    la x1, test_18_res

    # Testcase 85:  imm:0xfdf, result rd:x24(0x00000010)
    la  x8, test_data
    addi    x8, x8,13
    li     x2, MASK_XLEN(33)
    add    x8, x8, x2
    lbu x24, -33(x8)
    sw x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x00000010)

    # Testcase 86:  imm:0xfef, result rd:x25(0x00000020)
    la  x7, test_data
    addi    x7, x7,14
    li     x2, MASK_XLEN(17)
    add    x7, x7, x2
    lbu x25, -17(x7)
    sw x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x00000020)

    # Testcase 87:  imm:0xff7, result rd:x26(0x00000040)
    la  x6, test_data
    addi    x6, x6,15
    li     x2, MASK_XLEN(9)
    add    x6, x6, x2
    lbu x26, -9(x6)
    sw x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x26, 0x00000040)

    # Testcase 88:  imm:0xffb, result rd:x27(0x00000080)
    la  x5, test_data
    addi    x5, x5,16
    li     x2, MASK_XLEN(5)
    add    x5, x5, x2
    lbu x27, -5(x5)
    sw x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x27, 0x00000080)

    # Testcase 89:  imm:0xffd, result rd:x28(0x00000000)
    la  x4, test_data
    addi    x4, x4,17
    li     x2, MASK_XLEN(3)
    add    x4, x4, x2
    lbu x28, -3(x4)
    sw x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x28, 0x00000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # Addresses for test data and results
    la x4, test_19_res

    # Testcase 90:  imm:0xffe, result rd:x29(0x000000fe)
    la  x3, test_data
    addi    x3, x3,18
    li     x5, MASK_XLEN(2)
    add    x3, x3, x5
    lbu x29, -2(x3)
    sw x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x000000fe)

    # Testcase 91:  imm:0x0, result rd:x30(0x000000fd)
    la  x2, test_data
    addi    x2, x2,19
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    lbu x30, 0(x2)
    sw x30, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x000000fd)

    # Testcase 92:  imm:0x800, result rd:x31(0x000000fb)
    la  x1, test_data
    addi    x1, x1,20
    li     x5, MASK_XLEN(2048)
    add    x1, x1, x5
    lbu x31, -2048(x1)
    sw x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x000000fb)

    # Testcase 93:  imm:0x400, result rd:x1(0x000000f7)
    la  x31, test_data
    addi    x31, x31,21
    li     x5, MASK_XLEN(-1024)
    add    x31, x31, x5
    lbu x1, 1024(x31)
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x000000f7)

    # Testcase 94:  imm:0x200, result rd:x2(0x000000ef)
    la  x30, test_data
    addi    x30, x30,22
    li     x5, MASK_XLEN(-512)
    add    x30, x30, x5
    lbu x2, 512(x30)
    sw x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x000000ef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # Addresses for test data and results
    la x1, test_20_res

    # Testcase 95:  imm:0x100, result rd:x3(0x000000df)
    la  x29, test_data
    addi    x29, x29,23
    li     x2, MASK_XLEN(-256)
    add    x29, x29, x2
    lbu x3, 256(x29)
    sw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x000000df)

    # Testcase 96:  imm:0x80, result rd:x4(0x000000fe)
    la  x28, test_data
    addi    x28, x28,0
    li     x2, MASK_XLEN(-128)
    add    x28, x28, x2
    lbu x4, 128(x28)
    sw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x000000fe)

    # Testcase 97:  imm:0x40, result rd:x5(0x000000fd)
    la  x27, test_data
    addi    x27, x27,1
    li     x2, MASK_XLEN(-64)
    add    x27, x27, x2
    lbu x5, 64(x27)
    sw x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x000000fd)

    # Testcase 98:  imm:0x20, result rd:x6(0x000000fb)
    la  x26, test_data
    addi    x26, x26,2
    li     x2, MASK_XLEN(-32)
    add    x26, x26, x2
    lbu x6, 32(x26)
    sw x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x000000fb)

    # Testcase 99:  imm:0x10, result rd:x7(0x000000f7)
    la  x25, test_data
    addi    x25, x25,3
    li     x2, MASK_XLEN(-16)
    add    x25, x25, x2
    lbu x7, 16(x25)
    sw x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x7, 0x000000f7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # Addresses for test data and results
    la x1, test_21_res

    # Testcase 100:  imm:0x8, result rd:x8(0x000000ef)
    la  x24, test_data
    addi    x24, x24,4
    li     x2, MASK_XLEN(-8)
    add    x24, x24, x2
    lbu x8, 8(x24)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x000000ef)

    # Testcase 101:  imm:0x4, result rd:x9(0x000000df)
    la  x23, test_data
    addi    x23, x23,5
    li     x2, MASK_XLEN(-4)
    add    x23, x23, x2
    lbu x9, 4(x23)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x000000df)

    # Testcase 102:  imm:0x2, result rd:x10(0x000000bf)
    la  x22, test_data
    addi    x22, x22,6
    li     x2, MASK_XLEN(-2)
    add    x22, x22, x2
    lbu x10, 2(x22)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x000000bf)

    # Testcase 103:  imm:0x1, result rd:x11(0x0000007f)
    la  x21, test_data
    addi    x21, x21,7
    li     x2, MASK_XLEN(-1)
    add    x21, x21, x2
    lbu x11, 1(x21)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000007f)

    # Testcase 104:  imm:0xfff, result rd:x12(0x000000ff)
    la  x20, test_data
    addi    x20, x20,8
    li     x2, MASK_XLEN(1)
    add    x20, x20, x2
    lbu x12, -1(x20)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x000000ff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # Addresses for test data and results
    la x5, test_22_res

    # Testcase 105:  imm:0x7ff, result rd:x13(0x00000001)
    la  x19, test_data
    addi    x19, x19,9
    li     x6, MASK_XLEN(-2047)
    add    x19, x19, x6
    lbu x13, 2047(x19)
    sw x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x00000001)

    # Testcase 106:  imm:0xbff, result rd:x14(0x00000002)
    la  x18, test_data
    addi    x18, x18,10
    li     x6, MASK_XLEN(1025)
    add    x18, x18, x6
    lbu x14, -1025(x18)
    sw x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x00000002)

    # Testcase 107:  imm:0xdff, result rd:x15(0x00000004)
    la  x17, test_data
    addi    x17, x17,11
    li     x6, MASK_XLEN(513)
    add    x17, x17, x6
    lbu x15, -513(x17)
    sw x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x00000004)

    # Testcase 108:  imm:0xeff, result rd:x16(0x00000008)
    la  x16, test_data
    addi    x16, x16,12
    li     x6, MASK_XLEN(257)
    add    x16, x16, x6
    lbu x16, -257(x16)
    sw x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x00000008)

    # Testcase 109:  imm:0xf7f, result rd:x17(0x00000010)
    la  x15, test_data
    addi    x15, x15,13
    li     x6, MASK_XLEN(129)
    add    x15, x15, x6
    lbu x17, -129(x15)
    sw x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x17, 0x00000010)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # Addresses for test data and results
    la x1, test_23_res

    # Testcase 110:  imm:0xfbf, result rd:x18(0x00000020)
    la  x14, test_data
    addi    x14, x14,14
    li     x2, MASK_XLEN(65)
    add    x14, x14, x2
    lbu x18, -65(x14)
    sw x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x00000020)

    # Testcase 111:  imm:0xfdf, result rd:x19(0x00000040)
    la  x13, test_data
    addi    x13, x13,15
    li     x2, MASK_XLEN(33)
    add    x13, x13, x2
    lbu x19, -33(x13)
    sw x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x00000040)

    # Testcase 112:  imm:0xfef, result rd:x20(0x00000080)
    la  x12, test_data
    addi    x12, x12,16
    li     x2, MASK_XLEN(17)
    add    x12, x12, x2
    lbu x20, -17(x12)
    sw x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x00000080)

    # Testcase 113:  imm:0xff7, result rd:x21(0x00000000)
    la  x11, test_data
    addi    x11, x11,17
    li     x2, MASK_XLEN(9)
    add    x11, x11, x2
    lbu x21, -9(x11)
    sw x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x00000000)

    # Testcase 114:  imm:0xffb, result rd:x22(0x000000fe)
    la  x10, test_data
    addi    x10, x10,18
    li     x2, MASK_XLEN(5)
    add    x10, x10, x2
    lbu x22, -5(x10)
    sw x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x000000fe)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # Addresses for test data and results
    la x1, test_24_res

    # Testcase 115:  imm:0xffd, result rd:x23(0x000000fd)
    la  x9, test_data
    addi    x9, x9,19
    li     x2, MASK_XLEN(3)
    add    x9, x9, x2
    lbu x23, -3(x9)
    sw x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x000000fd)

    # Testcase 116:  imm:0xffe, result rd:x24(0x000000fb)
    la  x8, test_data
    addi    x8, x8,20
    li     x2, MASK_XLEN(2)
    add    x8, x8, x2
    lbu x24, -2(x8)
    sw x24, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x000000fb)

    # Testcase 117:  imm:0x0, result rd:x25(0x000000f7)
    la  x7, test_data
    addi    x7, x7,21
    li     x2, MASK_XLEN(0)
    add    x7, x7, x2
    lbu x25, 0(x7)
    sw x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x000000f7)

    # Testcase 118:  imm:0x800, result rd:x26(0x000000ef)
    la  x6, test_data
    addi    x6, x6,22
    li     x2, MASK_XLEN(2048)
    add    x6, x6, x2
    lbu x26, -2048(x6)
    sw x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x26, 0x000000ef)

    # Testcase 119:  imm:0x400, result rd:x27(0x000000df)
    la  x5, test_data
    addi    x5, x5,23
    li     x2, MASK_XLEN(-1024)
    add    x5, x5, x2
    lbu x27, 1024(x5)
    sw x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x27, 0x000000df)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # Addresses for test data and results
    la x5, test_25_res

    # Testcase 120:  imm:0x200, result rd:x28(0x000000fe)
    la  x4, test_data
    addi    x4, x4,0
    li     x6, MASK_XLEN(-512)
    add    x4, x4, x6
    lbu x28, 512(x4)
    sw x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x000000fe)

    # Testcase 121:  imm:0x100, result rd:x29(0x000000fd)
    la  x3, test_data
    addi    x3, x3,1
    li     x6, MASK_XLEN(-256)
    add    x3, x3, x6
    lbu x29, 256(x3)
    sw x29, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x000000fd)

    # Testcase 122:  imm:0x80, result rd:x30(0x000000fb)
    la  x2, test_data
    addi    x2, x2,2
    li     x6, MASK_XLEN(-128)
    add    x2, x2, x6
    lbu x30, 128(x2)
    sw x30, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x000000fb)

    # Testcase 123:  imm:0x40, result rd:x31(0x000000f7)
    la  x1, test_data
    addi    x1, x1,3
    li     x6, MASK_XLEN(-64)
    add    x1, x1, x6
    lbu x31, 64(x1)
    sw x31, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x000000f7)

    # Testcase 124:  imm:0x20, result rd:x1(0x000000ef)
    la  x31, test_data
    addi    x31, x31,4
    li     x6, MASK_XLEN(-32)
    add    x31, x31, x6
    lbu x1, 32(x31)
    sw x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x000000ef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # Addresses for test data and results
    la x1, test_26_res

    # Testcase 125:  imm:0x10, result rd:x2(0x000000df)
    la  x30, test_data
    addi    x30, x30,5
    li     x7, MASK_XLEN(-16)
    add    x30, x30, x7
    lbu x2, 16(x30)
    sw x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x000000df)

    # Testcase 126:  imm:0x8, result rd:x3(0x000000bf)
    la  x29, test_data
    addi    x29, x29,6
    li     x7, MASK_XLEN(-8)
    add    x29, x29, x7
    lbu x3, 8(x29)
    sw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x000000bf)

    # Testcase 127:  imm:0x4, result rd:x4(0x0000007f)
    la  x28, test_data
    addi    x28, x28,7
    li     x7, MASK_XLEN(-4)
    add    x28, x28, x7
    lbu x4, 4(x28)
    sw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x0000007f)

    # Testcase 128:  imm:0x2, result rd:x5(0x000000ff)
    la  x27, test_data
    addi    x27, x27,8
    li     x7, MASK_XLEN(-2)
    add    x27, x27, x7
    lbu x5, 2(x27)
    sw x5, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x000000ff)

    # Testcase 129:  imm:0x1, result rd:x6(0x00000001)
    la  x26, test_data
    addi    x26, x26,9
    li     x7, MASK_XLEN(-1)
    add    x26, x26, x7
    lbu x6, 1(x26)
    sw x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x00000001)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # Addresses for test data and results
    la x1, test_27_res

    # Testcase 130:  imm:0xfff, result rd:x7(0x00000002)
    la  x25, test_data
    addi    x25, x25,10
    li     x2, MASK_XLEN(1)
    add    x25, x25, x2
    lbu x7, -1(x25)
    sw x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x00000002)

    # Testcase 131:  imm:0x7ff, result rd:x8(0x00000004)
    la  x24, test_data
    addi    x24, x24,11
    li     x2, MASK_XLEN(-2047)
    add    x24, x24, x2
    lbu x8, 2047(x24)
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00000004)

    # Testcase 132:  imm:0xbff, result rd:x9(0x00000008)
    la  x23, test_data
    addi    x23, x23,12
    li     x2, MASK_XLEN(1025)
    add    x23, x23, x2
    lbu x9, -1025(x23)
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000008)

    # Testcase 133:  imm:0xdff, result rd:x0(0x00000000)
    la  x22, test_data
    addi    x22, x22,13
    li     x2, MASK_XLEN(513)
    add    x22, x22, x2
    lbu x0, -513(x22)
    sw x0, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x0, 0x00000000)

    # Testcase 134:  imm:0xeff, result rd:x11(0x00000020)
    la  x21, test_data
    addi    x21, x21,14
    li     x2, MASK_XLEN(257)
    add    x21, x21, x2
    lbu x11, -257(x21)
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00000020)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # Addresses for test data and results
    la x1, test_28_res

    # Testcase 135:  imm:0xf7f, result rd:x12(0x00000040)
    la  x20, test_data
    addi    x20, x20,15
    li     x2, MASK_XLEN(129)
    add    x20, x20, x2
    lbu x12, -129(x20)
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00000040)



	# ---------------------------------------------------------------------------------------------
	
	RVTEST_IO_WRITE_STR(x31, "Test End\n")

	# ---------------------------------------------------------------------------------------------

	RV_COMPLIANCE_HALT

RV_COMPLIANCE_CODE_END

# Input data section.
	.data

	.align 4
test_data:

	.word 0xf7fbfdfe
	.word 0x7fbfdfef
	.word 0x040201ff
	.word 0x40201008
	.word 0xfdfe0080
	.word 0xdfeff7fb


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

