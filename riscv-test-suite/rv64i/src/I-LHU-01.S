# RISC-V Compliance Test I-LHU-01
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
# Description: Testing instruction 'LHU'.

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

    # Testcase 0:  imm:0xfff, result rd:x1(0x000000000000fffe)
    la  x31, test_data
    addi    x31, x31,0
    li     x7, MASK_XLEN(1)
    add    x31, x31, x7
    lhu x1, -1(x31)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x000000000000fffe)

    # Testcase 1:  imm:0x7ff, result rd:x2(0x000000000000fffd)
    la  x30, test_data
    addi    x30, x30,2
    li     x7, MASK_XLEN(-2047)
    add    x30, x30, x7
    lhu x2, 2047(x30)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x000000000000fffd)

    # Testcase 2:  imm:0xbff, result rd:x3(0x000000000000fffb)
    la  x29, test_data
    addi    x29, x29,4
    li     x7, MASK_XLEN(1025)
    add    x29, x29, x7
    lhu x3, -1025(x29)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x000000000000fffb)

    # Testcase 3:  imm:0xdff, result rd:x4(0x000000000000fff7)
    la  x28, test_data
    addi    x28, x28,6
    li     x7, MASK_XLEN(513)
    add    x28, x28, x7
    lhu x4, -513(x28)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x000000000000fff7)

    # Testcase 4:  imm:0xeff, result rd:x5(0x000000000000ffef)
    la  x27, test_data
    addi    x27, x27,8
    li     x7, MASK_XLEN(257)
    add    x27, x27, x7
    lhu x5, -257(x27)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x000000000000ffef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # Addresses for test data and results
    la x1, test_2_res

    # Testcase 5:  imm:0xf7f, result rd:x6(0x000000000000ffdf)
    la  x26, test_data
    addi    x26, x26,10
    li     x2, MASK_XLEN(129)
    add    x26, x26, x2
    lhu x6, -129(x26)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x000000000000ffdf)

    # Testcase 6:  imm:0xfbf, result rd:x7(0x000000000000ffbf)
    la  x25, test_data
    addi    x25, x25,12
    li     x2, MASK_XLEN(65)
    add    x25, x25, x2
    lhu x7, -65(x25)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x000000000000ffbf)

    # Testcase 7:  imm:0xfdf, result rd:x8(0x000000000000ff7f)
    la  x24, test_data
    addi    x24, x24,14
    li     x2, MASK_XLEN(33)
    add    x24, x24, x2
    lhu x8, -33(x24)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x000000000000ff7f)

    # Testcase 8:  imm:0xfef, result rd:x9(0x000000000000feff)
    la  x23, test_data
    addi    x23, x23,16
    li     x2, MASK_XLEN(17)
    add    x23, x23, x2
    lhu x9, -17(x23)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x000000000000feff)

    # Testcase 9:  imm:0xff7, result rd:x10(0x000000000000fdff)
    la  x22, test_data
    addi    x22, x22,18
    li     x2, MASK_XLEN(9)
    add    x22, x22, x2
    lhu x10, -9(x22)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x000000000000fdff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # Addresses for test data and results
    la x1, test_3_res

    # Testcase 10:  imm:0xffb, result rd:x11(0x000000000000feff)
    la  x21, test_data
    addi    x21, x21,20
    li     x7, MASK_XLEN(5)
    add    x21, x21, x7
    lhu x11, -5(x21)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x11, 0x000000000000feff)

    # Testcase 11:  imm:0xffd, result rd:x12(0x000000000000f7ff)
    la  x20, test_data
    addi    x20, x20,22
    li     x7, MASK_XLEN(3)
    add    x20, x20, x7
    lhu x12, -3(x20)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x000000000000f7ff)

    # Testcase 12:  imm:0xffe, result rd:x13(0x000000000000efff)
    la  x19, test_data
    addi    x19, x19,24
    li     x7, MASK_XLEN(2)
    add    x19, x19, x7
    lhu x13, -2(x19)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x000000000000efff)

    # Testcase 13:  imm:0x0, result rd:x14(0x000000000000dfff)
    la  x18, test_data
    addi    x18, x18,26
    li     x7, MASK_XLEN(0)
    add    x18, x18, x7
    lhu x14, 0(x18)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x000000000000dfff)

    # Testcase 14:  imm:0x800, result rd:x15(0x000000000000efff)
    la  x17, test_data
    addi    x17, x17,28
    li     x7, MASK_XLEN(2048)
    add    x17, x17, x7
    lhu x15, -2048(x17)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x15, 0x000000000000efff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # Addresses for test data and results
    la x2, test_4_res

    # Testcase 15:  imm:0x400, result rd:x16(0x0000000000007fff)
    la  x16, test_data
    addi    x16, x16,30
    li     x3, MASK_XLEN(-1024)
    add    x16, x16, x3
    lhu x16, 1024(x16)
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x0000000000007fff)

    # Testcase 16:  imm:0x200, result rd:x17(0x000000000000ffff)
    la  x15, test_data
    addi    x15, x15,32
    li     x3, MASK_XLEN(-512)
    add    x15, x15, x3
    lhu x17, 512(x15)
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x000000000000ffff)

    # Testcase 17:  imm:0x100, result rd:x18(0x0000000000000001)
    la  x14, test_data
    addi    x14, x14,34
    li     x3, MASK_XLEN(-256)
    add    x14, x14, x3
    lhu x18, 256(x14)
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x0000000000000001)

    # Testcase 18:  imm:0x80, result rd:x19(0x0000000000000002)
    la  x13, test_data
    addi    x13, x13,36
    li     x3, MASK_XLEN(-128)
    add    x13, x13, x3
    lhu x19, 128(x13)
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0000000000000002)

    # Testcase 19:  imm:0x40, result rd:x20(0x0000000000000004)
    la  x12, test_data
    addi    x12, x12,38
    li     x3, MASK_XLEN(-64)
    add    x12, x12, x3
    lhu x20, 64(x12)
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x0000000000000004)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # Addresses for test data and results
    la x1, test_5_res

    # Testcase 20:  imm:0x20, result rd:x21(0x0000000000000008)
    la  x11, test_data
    addi    x11, x11,40
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    lhu x21, 32(x11)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x0000000000000008)

    # Testcase 21:  imm:0x10, result rd:x22(0x0000000000000010)
    la  x10, test_data
    addi    x10, x10,42
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    lhu x22, 16(x10)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x0000000000000010)

    # Testcase 22:  imm:0x8, result rd:x23(0x0000000000000020)
    la  x9, test_data
    addi    x9, x9,44
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    lhu x23, 8(x9)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x0000000000000020)

    # Testcase 23:  imm:0x4, result rd:x24(0x0000000000000040)
    la  x8, test_data
    addi    x8, x8,46
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    lhu x24, 4(x8)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x0000000000000040)

    # Testcase 24:  imm:0x2, result rd:x25(0x0000000000000080)
    la  x7, test_data
    addi    x7, x7,48
    li     x2, MASK_XLEN(-2)
    add    x7, x7, x2
    lhu x25, 2(x7)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x0000000000000080)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # Addresses for test data and results
    la x1, test_6_res

    # Testcase 25:  imm:0x1, result rd:x26(0x0000000000000100)
    la  x6, test_data
    addi    x6, x6,50
    li     x7, MASK_XLEN(-1)
    add    x6, x6, x7
    lhu x26, 1(x6)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x26, 0x0000000000000100)

    # Testcase 26:  imm:0xfff, result rd:x27(0x0000000000000200)
    la  x5, test_data
    addi    x5, x5,52
    li     x7, MASK_XLEN(1)
    add    x5, x5, x7
    lhu x27, -1(x5)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x0000000000000200)

    # Testcase 27:  imm:0x7ff, result rd:x28(0x0000000000000400)
    la  x4, test_data
    addi    x4, x4,54
    li     x7, MASK_XLEN(-2047)
    add    x4, x4, x7
    lhu x28, 2047(x4)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x0000000000000400)

    # Testcase 28:  imm:0xbff, result rd:x29(0x0000000000000800)
    la  x3, test_data
    addi    x3, x3,56
    li     x7, MASK_XLEN(1025)
    add    x3, x3, x7
    lhu x29, -1025(x3)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x0000000000000800)

    # Testcase 29:  imm:0xdff, result rd:x30(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,58
    li     x7, MASK_XLEN(513)
    add    x2, x2, x7
    lhu x30, -513(x2)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x30, 0x0000000000001000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # Addresses for test data and results
    la x5, test_7_res

    # Testcase 30:  imm:0xeff, result rd:x31(0x0000000000002000)
    la  x1, test_data
    addi    x1, x1,60
    li     x6, MASK_XLEN(257)
    add    x1, x1, x6
    lhu x31, -257(x1)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x0000000000002000)

    # Testcase 31:  imm:0xf7f, result rd:x1(0x0000000000004000)
    la  x31, test_data
    addi    x31, x31,62
    li     x6, MASK_XLEN(129)
    add    x31, x31, x6
    lhu x1, -129(x31)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x0000000000004000)

    # Testcase 32:  imm:0xfbf, result rd:x2(0x0000000000008000)
    la  x30, test_data
    addi    x30, x30,64
    li     x6, MASK_XLEN(65)
    add    x30, x30, x6
    lhu x2, -65(x30)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x0000000000008000)

    # Testcase 33:  imm:0xfdf, result rd:x3(0x0000000000000000)
    la  x29, test_data
    addi    x29, x29,66
    li     x6, MASK_XLEN(33)
    add    x29, x29, x6
    lhu x3, -33(x29)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0000000000000000)

    # Testcase 34:  imm:0xfef, result rd:x4(0x000000000000fffe)
    la  x28, test_data
    addi    x28, x28,68
    li     x6, MASK_XLEN(17)
    add    x28, x28, x6
    lhu x4, -17(x28)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x000000000000fffe)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # Addresses for test data and results
    la x1, test_8_res

    # Testcase 35:  imm:0xff7, result rd:x5(0x000000000000fffd)
    la  x27, test_data
    addi    x27, x27,70
    li     x2, MASK_XLEN(9)
    add    x27, x27, x2
    lhu x5, -9(x27)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x5, 0x000000000000fffd)

    # Testcase 36:  imm:0xffb, result rd:x6(0x000000000000fffe)
    la  x26, test_data
    addi    x26, x26,0
    li     x2, MASK_XLEN(5)
    add    x26, x26, x2
    lhu x6, -5(x26)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x000000000000fffe)

    # Testcase 37:  imm:0xffd, result rd:x7(0x000000000000fffd)
    la  x25, test_data
    addi    x25, x25,2
    li     x2, MASK_XLEN(3)
    add    x25, x25, x2
    lhu x7, -3(x25)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x000000000000fffd)

    # Testcase 38:  imm:0xffe, result rd:x8(0x000000000000fffb)
    la  x24, test_data
    addi    x24, x24,4
    li     x2, MASK_XLEN(2)
    add    x24, x24, x2
    lhu x8, -2(x24)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x000000000000fffb)

    # Testcase 39:  imm:0x0, result rd:x9(0x000000000000fff7)
    la  x23, test_data
    addi    x23, x23,6
    li     x2, MASK_XLEN(0)
    add    x23, x23, x2
    lhu x9, 0(x23)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x000000000000fff7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # Addresses for test data and results
    la x1, test_9_res

    # Testcase 40:  imm:0x800, result rd:x10(0x000000000000ffef)
    la  x22, test_data
    addi    x22, x22,8
    li     x2, MASK_XLEN(2048)
    add    x22, x22, x2
    lhu x10, -2048(x22)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x10, 0x000000000000ffef)

    # Testcase 41:  imm:0x400, result rd:x11(0x000000000000ffdf)
    la  x21, test_data
    addi    x21, x21,10
    li     x2, MASK_XLEN(-1024)
    add    x21, x21, x2
    lhu x11, 1024(x21)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x11, 0x000000000000ffdf)

    # Testcase 42:  imm:0x200, result rd:x12(0x000000000000ffbf)
    la  x20, test_data
    addi    x20, x20,12
    li     x2, MASK_XLEN(-512)
    add    x20, x20, x2
    lhu x12, 512(x20)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x000000000000ffbf)

    # Testcase 43:  imm:0x100, result rd:x13(0x000000000000ff7f)
    la  x19, test_data
    addi    x19, x19,14
    li     x2, MASK_XLEN(-256)
    add    x19, x19, x2
    lhu x13, 256(x19)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x000000000000ff7f)

    # Testcase 44:  imm:0x80, result rd:x14(0x000000000000feff)
    la  x18, test_data
    addi    x18, x18,16
    li     x2, MASK_XLEN(-128)
    add    x18, x18, x2
    lhu x14, 128(x18)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x000000000000feff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # Addresses for test data and results
    la x3, test_10_res

    # Testcase 45:  imm:0x40, result rd:x15(0x000000000000fdff)
    la  x17, test_data
    addi    x17, x17,18
    li     x4, MASK_XLEN(-64)
    add    x17, x17, x4
    lhu x15, 64(x17)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x000000000000fdff)

    # Testcase 46:  imm:0x20, result rd:x16(0x000000000000feff)
    la  x16, test_data
    addi    x16, x16,20
    li     x4, MASK_XLEN(-32)
    add    x16, x16, x4
    lhu x16, 32(x16)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x000000000000feff)

    # Testcase 47:  imm:0x10, result rd:x17(0x000000000000f7ff)
    la  x15, test_data
    addi    x15, x15,22
    li     x4, MASK_XLEN(-16)
    add    x15, x15, x4
    lhu x17, 16(x15)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x000000000000f7ff)

    # Testcase 48:  imm:0x8, result rd:x18(0x000000000000efff)
    la  x14, test_data
    addi    x14, x14,24
    li     x4, MASK_XLEN(-8)
    add    x14, x14, x4
    lhu x18, 8(x14)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x000000000000efff)

    # Testcase 49:  imm:0x4, result rd:x19(0x000000000000dfff)
    la  x13, test_data
    addi    x13, x13,26
    li     x4, MASK_XLEN(-4)
    add    x13, x13, x4
    lhu x19, 4(x13)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0x000000000000dfff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # Addresses for test data and results
    la x1, test_11_res

    # Testcase 50:  imm:0x2, result rd:x20(0x000000000000efff)
    la  x12, test_data
    addi    x12, x12,28
    li     x2, MASK_XLEN(-2)
    add    x12, x12, x2
    lhu x20, 2(x12)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x000000000000efff)

    # Testcase 51:  imm:0x1, result rd:x21(0x0000000000007fff)
    la  x11, test_data
    addi    x11, x11,30
    li     x2, MASK_XLEN(-1)
    add    x11, x11, x2
    lhu x21, 1(x11)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x0000000000007fff)

    # Testcase 52:  imm:0xfff, result rd:x22(0x000000000000ffff)
    la  x10, test_data
    addi    x10, x10,32
    li     x2, MASK_XLEN(1)
    add    x10, x10, x2
    lhu x22, -1(x10)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x000000000000ffff)

    # Testcase 53:  imm:0x7ff, result rd:x23(0x0000000000000001)
    la  x9, test_data
    addi    x9, x9,34
    li     x2, MASK_XLEN(-2047)
    add    x9, x9, x2
    lhu x23, 2047(x9)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x0000000000000001)

    # Testcase 54:  imm:0xbff, result rd:x24(0x0000000000000002)
    la  x8, test_data
    addi    x8, x8,36
    li     x2, MASK_XLEN(1025)
    add    x8, x8, x2
    lhu x24, -1025(x8)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x0000000000000002)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # Addresses for test data and results
    la x1, test_12_res

    # Testcase 55:  imm:0xdff, result rd:x25(0x0000000000000004)
    la  x7, test_data
    addi    x7, x7,38
    li     x2, MASK_XLEN(513)
    add    x7, x7, x2
    lhu x25, -513(x7)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x25, 0x0000000000000004)

    # Testcase 56:  imm:0xeff, result rd:x26(0x0000000000000008)
    la  x6, test_data
    addi    x6, x6,40
    li     x2, MASK_XLEN(257)
    add    x6, x6, x2
    lhu x26, -257(x6)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x26, 0x0000000000000008)

    # Testcase 57:  imm:0xf7f, result rd:x27(0x0000000000000010)
    la  x5, test_data
    addi    x5, x5,42
    li     x2, MASK_XLEN(129)
    add    x5, x5, x2
    lhu x27, -129(x5)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x0000000000000010)

    # Testcase 58:  imm:0xfbf, result rd:x28(0x0000000000000020)
    la  x4, test_data
    addi    x4, x4,44
    li     x2, MASK_XLEN(65)
    add    x4, x4, x2
    lhu x28, -65(x4)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x0000000000000020)

    # Testcase 59:  imm:0xfdf, result rd:x29(0x0000000000000040)
    la  x3, test_data
    addi    x3, x3,46
    li     x2, MASK_XLEN(33)
    add    x3, x3, x2
    lhu x29, -33(x3)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x0000000000000040)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # Addresses for test data and results
    la x4, test_13_res

    # Testcase 60:  imm:0xfef, result rd:x30(0x0000000000000080)
    la  x2, test_data
    addi    x2, x2,48
    li     x5, MASK_XLEN(17)
    add    x2, x2, x5
    lhu x30, -17(x2)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x0000000000000080)

    # Testcase 61:  imm:0xff7, result rd:x31(0x0000000000000100)
    la  x1, test_data
    addi    x1, x1,50
    li     x5, MASK_XLEN(9)
    add    x1, x1, x5
    lhu x31, -9(x1)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0000000000000100)

    # Testcase 62:  imm:0xffb, result rd:x1(0x0000000000000200)
    la  x31, test_data
    addi    x31, x31,52
    li     x5, MASK_XLEN(5)
    add    x31, x31, x5
    lhu x1, -5(x31)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0000000000000200)

    # Testcase 63:  imm:0xffd, result rd:x2(0x0000000000000400)
    la  x30, test_data
    addi    x30, x30,54
    li     x5, MASK_XLEN(3)
    add    x30, x30, x5
    lhu x2, -3(x30)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0000000000000400)

    # Testcase 64:  imm:0xffe, result rd:x3(0x0000000000000800)
    la  x29, test_data
    addi    x29, x29,56
    li     x5, MASK_XLEN(2)
    add    x29, x29, x5
    lhu x3, -2(x29)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x0000000000000800)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # Addresses for test data and results
    la x1, test_14_res

    # Testcase 65:  imm:0x0, result rd:x4(0x0000000000001000)
    la  x28, test_data
    addi    x28, x28,58
    li     x2, MASK_XLEN(0)
    add    x28, x28, x2
    lhu x4, 0(x28)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x0000000000001000)

    # Testcase 66:  imm:0x800, result rd:x5(0x0000000000002000)
    la  x27, test_data
    addi    x27, x27,60
    li     x2, MASK_XLEN(2048)
    add    x27, x27, x2
    lhu x5, -2048(x27)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x5, 0x0000000000002000)

    # Testcase 67:  imm:0x400, result rd:x6(0x0000000000004000)
    la  x26, test_data
    addi    x26, x26,62
    li     x2, MASK_XLEN(-1024)
    add    x26, x26, x2
    lhu x6, 1024(x26)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x0000000000004000)

    # Testcase 68:  imm:0x200, result rd:x7(0x0000000000008000)
    la  x25, test_data
    addi    x25, x25,64
    li     x2, MASK_XLEN(-512)
    add    x25, x25, x2
    lhu x7, 512(x25)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x0000000000008000)

    # Testcase 69:  imm:0x100, result rd:x8(0x0000000000000000)
    la  x24, test_data
    addi    x24, x24,66
    li     x2, MASK_XLEN(-256)
    add    x24, x24, x2
    lhu x8, 256(x24)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # Addresses for test data and results
    la x1, test_15_res

    # Testcase 70:  imm:0x80, result rd:x9(0x000000000000fffe)
    la  x23, test_data
    addi    x23, x23,68
    li     x2, MASK_XLEN(-128)
    add    x23, x23, x2
    lhu x9, 128(x23)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x000000000000fffe)

    # Testcase 71:  imm:0x40, result rd:x10(0x000000000000fffd)
    la  x22, test_data
    addi    x22, x22,70
    li     x2, MASK_XLEN(-64)
    add    x22, x22, x2
    lhu x10, 64(x22)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x000000000000fffd)

    # Testcase 72:  imm:0x20, result rd:x11(0x000000000000fffe)
    la  x21, test_data
    addi    x21, x21,0
    li     x2, MASK_XLEN(-32)
    add    x21, x21, x2
    lhu x11, 32(x21)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x000000000000fffe)

    # Testcase 73:  imm:0x10, result rd:x12(0x000000000000fffd)
    la  x20, test_data
    addi    x20, x20,2
    li     x2, MASK_XLEN(-16)
    add    x20, x20, x2
    lhu x12, 16(x20)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x000000000000fffd)

    # Testcase 74:  imm:0x8, result rd:x13(0x000000000000fffb)
    la  x19, test_data
    addi    x19, x19,4
    li     x2, MASK_XLEN(-8)
    add    x19, x19, x2
    lhu x13, 8(x19)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x000000000000fffb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # Addresses for test data and results
    la x4, test_16_res

    # Testcase 75:  imm:0x4, result rd:x14(0x000000000000fff7)
    la  x18, test_data
    addi    x18, x18,6
    li     x5, MASK_XLEN(-4)
    add    x18, x18, x5
    lhu x14, 4(x18)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x000000000000fff7)

    # Testcase 76:  imm:0x2, result rd:x15(0x000000000000ffef)
    la  x17, test_data
    addi    x17, x17,8
    li     x5, MASK_XLEN(-2)
    add    x17, x17, x5
    lhu x15, 2(x17)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x000000000000ffef)

    # Testcase 77:  imm:0x1, result rd:x16(0x000000000000ffdf)
    la  x16, test_data
    addi    x16, x16,10
    li     x5, MASK_XLEN(-1)
    add    x16, x16, x5
    lhu x16, 1(x16)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x000000000000ffdf)

    # Testcase 78:  imm:0xfff, result rd:x17(0x000000000000ffbf)
    la  x15, test_data
    addi    x15, x15,12
    li     x5, MASK_XLEN(1)
    add    x15, x15, x5
    lhu x17, -1(x15)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x000000000000ffbf)

    # Testcase 79:  imm:0x7ff, result rd:x18(0x000000000000ff7f)
    la  x14, test_data
    addi    x14, x14,14
    li     x5, MASK_XLEN(-2047)
    add    x14, x14, x5
    lhu x18, 2047(x14)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x18, 0x000000000000ff7f)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # Addresses for test data and results
    la x1, test_17_res

    # Testcase 80:  imm:0xbff, result rd:x19(0x000000000000feff)
    la  x13, test_data
    addi    x13, x13,16
    li     x2, MASK_XLEN(1025)
    add    x13, x13, x2
    lhu x19, -1025(x13)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x000000000000feff)

    # Testcase 81:  imm:0xdff, result rd:x20(0x000000000000fdff)
    la  x12, test_data
    addi    x12, x12,18
    li     x2, MASK_XLEN(513)
    add    x12, x12, x2
    lhu x20, -513(x12)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x000000000000fdff)

    # Testcase 82:  imm:0xeff, result rd:x21(0x000000000000feff)
    la  x11, test_data
    addi    x11, x11,20
    li     x2, MASK_XLEN(257)
    add    x11, x11, x2
    lhu x21, -257(x11)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x000000000000feff)

    # Testcase 83:  imm:0xf7f, result rd:x22(0x000000000000f7ff)
    la  x10, test_data
    addi    x10, x10,22
    li     x2, MASK_XLEN(129)
    add    x10, x10, x2
    lhu x22, -129(x10)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x000000000000f7ff)

    # Testcase 84:  imm:0xfbf, result rd:x23(0x000000000000efff)
    la  x9, test_data
    addi    x9, x9,24
    li     x2, MASK_XLEN(65)
    add    x9, x9, x2
    lhu x23, -65(x9)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x000000000000efff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # Addresses for test data and results
    la x1, test_18_res

    # Testcase 85:  imm:0xfdf, result rd:x24(0x000000000000dfff)
    la  x8, test_data
    addi    x8, x8,26
    li     x2, MASK_XLEN(33)
    add    x8, x8, x2
    lhu x24, -33(x8)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x000000000000dfff)

    # Testcase 86:  imm:0xfef, result rd:x25(0x000000000000efff)
    la  x7, test_data
    addi    x7, x7,28
    li     x2, MASK_XLEN(17)
    add    x7, x7, x2
    lhu x25, -17(x7)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x000000000000efff)

    # Testcase 87:  imm:0xff7, result rd:x26(0x0000000000007fff)
    la  x6, test_data
    addi    x6, x6,30
    li     x2, MASK_XLEN(9)
    add    x6, x6, x2
    lhu x26, -9(x6)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x26, 0x0000000000007fff)

    # Testcase 88:  imm:0xffb, result rd:x27(0x000000000000ffff)
    la  x5, test_data
    addi    x5, x5,32
    li     x2, MASK_XLEN(5)
    add    x5, x5, x2
    lhu x27, -5(x5)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x27, 0x000000000000ffff)

    # Testcase 89:  imm:0xffd, result rd:x28(0x0000000000000001)
    la  x4, test_data
    addi    x4, x4,34
    li     x2, MASK_XLEN(3)
    add    x4, x4, x2
    lhu x28, -3(x4)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x28, 0x0000000000000001)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # Addresses for test data and results
    la x4, test_19_res

    # Testcase 90:  imm:0xffe, result rd:x29(0x0000000000000002)
    la  x3, test_data
    addi    x3, x3,36
    li     x5, MASK_XLEN(2)
    add    x3, x3, x5
    lhu x29, -2(x3)
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x0000000000000002)

    # Testcase 91:  imm:0x0, result rd:x30(0x0000000000000004)
    la  x2, test_data
    addi    x2, x2,38
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    lhu x30, 0(x2)
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x0000000000000004)

    # Testcase 92:  imm:0x800, result rd:x31(0x0000000000000008)
    la  x1, test_data
    addi    x1, x1,40
    li     x5, MASK_XLEN(2048)
    add    x1, x1, x5
    lhu x31, -2048(x1)
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0000000000000008)

    # Testcase 93:  imm:0x400, result rd:x1(0x0000000000000010)
    la  x31, test_data
    addi    x31, x31,42
    li     x5, MASK_XLEN(-1024)
    add    x31, x31, x5
    lhu x1, 1024(x31)
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0000000000000010)

    # Testcase 94:  imm:0x200, result rd:x2(0x0000000000000020)
    la  x30, test_data
    addi    x30, x30,44
    li     x5, MASK_XLEN(-512)
    add    x30, x30, x5
    lhu x2, 512(x30)
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0000000000000020)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # Addresses for test data and results
    la x1, test_20_res

    # Testcase 95:  imm:0x100, result rd:x3(0x0000000000000040)
    la  x29, test_data
    addi    x29, x29,46
    li     x2, MASK_XLEN(-256)
    add    x29, x29, x2
    lhu x3, 256(x29)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x0000000000000040)

    # Testcase 96:  imm:0x80, result rd:x4(0x0000000000000080)
    la  x28, test_data
    addi    x28, x28,48
    li     x2, MASK_XLEN(-128)
    add    x28, x28, x2
    lhu x4, 128(x28)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x0000000000000080)

    # Testcase 97:  imm:0x40, result rd:x5(0x0000000000000100)
    la  x27, test_data
    addi    x27, x27,50
    li     x2, MASK_XLEN(-64)
    add    x27, x27, x2
    lhu x5, 64(x27)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x0000000000000100)

    # Testcase 98:  imm:0x20, result rd:x6(0x0000000000000200)
    la  x26, test_data
    addi    x26, x26,52
    li     x2, MASK_XLEN(-32)
    add    x26, x26, x2
    lhu x6, 32(x26)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x0000000000000200)

    # Testcase 99:  imm:0x10, result rd:x7(0x0000000000000400)
    la  x25, test_data
    addi    x25, x25,54
    li     x2, MASK_XLEN(-16)
    add    x25, x25, x2
    lhu x7, 16(x25)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x7, 0x0000000000000400)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # Addresses for test data and results
    la x1, test_21_res

    # Testcase 100:  imm:0x8, result rd:x8(0x0000000000000800)
    la  x24, test_data
    addi    x24, x24,56
    li     x2, MASK_XLEN(-8)
    add    x24, x24, x2
    lhu x8, 8(x24)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000800)

    # Testcase 101:  imm:0x4, result rd:x9(0x0000000000001000)
    la  x23, test_data
    addi    x23, x23,58
    li     x2, MASK_XLEN(-4)
    add    x23, x23, x2
    lhu x9, 4(x23)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000001000)

    # Testcase 102:  imm:0x2, result rd:x10(0x0000000000002000)
    la  x22, test_data
    addi    x22, x22,60
    li     x2, MASK_XLEN(-2)
    add    x22, x22, x2
    lhu x10, 2(x22)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000002000)

    # Testcase 103:  imm:0x1, result rd:x11(0x0000000000004000)
    la  x21, test_data
    addi    x21, x21,62
    li     x2, MASK_XLEN(-1)
    add    x21, x21, x2
    lhu x11, 1(x21)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000004000)

    # Testcase 104:  imm:0xfff, result rd:x12(0x0000000000008000)
    la  x20, test_data
    addi    x20, x20,64
    li     x2, MASK_XLEN(1)
    add    x20, x20, x2
    lhu x12, -1(x20)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000008000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # Addresses for test data and results
    la x5, test_22_res

    # Testcase 105:  imm:0x7ff, result rd:x13(0x0000000000000000)
    la  x19, test_data
    addi    x19, x19,66
    li     x6, MASK_XLEN(-2047)
    add    x19, x19, x6
    lhu x13, 2047(x19)
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0000000000000000)

    # Testcase 106:  imm:0xbff, result rd:x14(0x000000000000fffe)
    la  x18, test_data
    addi    x18, x18,68
    li     x6, MASK_XLEN(1025)
    add    x18, x18, x6
    lhu x14, -1025(x18)
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x000000000000fffe)

    # Testcase 107:  imm:0xdff, result rd:x15(0x000000000000fffd)
    la  x17, test_data
    addi    x17, x17,70
    li     x6, MASK_XLEN(513)
    add    x17, x17, x6
    lhu x15, -513(x17)
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x000000000000fffd)

    # Testcase 108:  imm:0xeff, result rd:x16(0x000000000000fffe)
    la  x16, test_data
    addi    x16, x16,0
    li     x6, MASK_XLEN(257)
    add    x16, x16, x6
    lhu x16, -257(x16)
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x000000000000fffe)

    # Testcase 109:  imm:0xf7f, result rd:x17(0x000000000000fffd)
    la  x15, test_data
    addi    x15, x15,2
    li     x6, MASK_XLEN(129)
    add    x15, x15, x6
    lhu x17, -129(x15)
    sd x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x17, 0x000000000000fffd)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # Addresses for test data and results
    la x1, test_23_res

    # Testcase 110:  imm:0xfbf, result rd:x18(0x000000000000fffb)
    la  x14, test_data
    addi    x14, x14,4
    li     x2, MASK_XLEN(65)
    add    x14, x14, x2
    lhu x18, -65(x14)
    sd x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x000000000000fffb)

    # Testcase 111:  imm:0xfdf, result rd:x19(0x000000000000fff7)
    la  x13, test_data
    addi    x13, x13,6
    li     x2, MASK_XLEN(33)
    add    x13, x13, x2
    lhu x19, -33(x13)
    sd x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x000000000000fff7)

    # Testcase 112:  imm:0xfef, result rd:x20(0x000000000000ffef)
    la  x12, test_data
    addi    x12, x12,8
    li     x2, MASK_XLEN(17)
    add    x12, x12, x2
    lhu x20, -17(x12)
    sd x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x000000000000ffef)

    # Testcase 113:  imm:0xff7, result rd:x21(0x000000000000ffdf)
    la  x11, test_data
    addi    x11, x11,10
    li     x2, MASK_XLEN(9)
    add    x11, x11, x2
    lhu x21, -9(x11)
    sd x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x000000000000ffdf)

    # Testcase 114:  imm:0xffb, result rd:x22(0x000000000000ffbf)
    la  x10, test_data
    addi    x10, x10,12
    li     x2, MASK_XLEN(5)
    add    x10, x10, x2
    lhu x22, -5(x10)
    sd x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x000000000000ffbf)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # Addresses for test data and results
    la x1, test_24_res

    # Testcase 115:  imm:0xffd, result rd:x23(0x000000000000ff7f)
    la  x9, test_data
    addi    x9, x9,14
    li     x2, MASK_XLEN(3)
    add    x9, x9, x2
    lhu x23, -3(x9)
    sd x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x000000000000ff7f)

    # Testcase 116:  imm:0xffe, result rd:x24(0x000000000000feff)
    la  x8, test_data
    addi    x8, x8,16
    li     x2, MASK_XLEN(2)
    add    x8, x8, x2
    lhu x24, -2(x8)
    sd x24, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x000000000000feff)

    # Testcase 117:  imm:0x0, result rd:x25(0x000000000000fdff)
    la  x7, test_data
    addi    x7, x7,18
    li     x2, MASK_XLEN(0)
    add    x7, x7, x2
    lhu x25, 0(x7)
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x000000000000fdff)

    # Testcase 118:  imm:0x800, result rd:x26(0x000000000000feff)
    la  x6, test_data
    addi    x6, x6,20
    li     x2, MASK_XLEN(2048)
    add    x6, x6, x2
    lhu x26, -2048(x6)
    sd x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x26, 0x000000000000feff)

    # Testcase 119:  imm:0x400, result rd:x27(0x000000000000f7ff)
    la  x5, test_data
    addi    x5, x5,22
    li     x2, MASK_XLEN(-1024)
    add    x5, x5, x2
    lhu x27, 1024(x5)
    sd x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x27, 0x000000000000f7ff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # Addresses for test data and results
    la x5, test_25_res

    # Testcase 120:  imm:0x200, result rd:x28(0x000000000000efff)
    la  x4, test_data
    addi    x4, x4,24
    li     x6, MASK_XLEN(-512)
    add    x4, x4, x6
    lhu x28, 512(x4)
    sd x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x000000000000efff)

    # Testcase 121:  imm:0x100, result rd:x29(0x000000000000dfff)
    la  x3, test_data
    addi    x3, x3,26
    li     x6, MASK_XLEN(-256)
    add    x3, x3, x6
    lhu x29, 256(x3)
    sd x29, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x000000000000dfff)

    # Testcase 122:  imm:0x80, result rd:x30(0x000000000000efff)
    la  x2, test_data
    addi    x2, x2,28
    li     x6, MASK_XLEN(-128)
    add    x2, x2, x6
    lhu x30, 128(x2)
    sd x30, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x000000000000efff)

    # Testcase 123:  imm:0x40, result rd:x31(0x0000000000007fff)
    la  x1, test_data
    addi    x1, x1,30
    li     x6, MASK_XLEN(-64)
    add    x1, x1, x6
    lhu x31, 64(x1)
    sd x31, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x0000000000007fff)

    # Testcase 124:  imm:0x20, result rd:x1(0x000000000000ffff)
    la  x31, test_data
    addi    x31, x31,32
    li     x6, MASK_XLEN(-32)
    add    x31, x31, x6
    lhu x1, 32(x31)
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x000000000000ffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # Addresses for test data and results
    la x1, test_26_res

    # Testcase 125:  imm:0x10, result rd:x2(0x0000000000000001)
    la  x30, test_data
    addi    x30, x30,34
    li     x7, MASK_XLEN(-16)
    add    x30, x30, x7
    lhu x2, 16(x30)
    sd x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x0000000000000001)

    # Testcase 126:  imm:0x8, result rd:x3(0x0000000000000002)
    la  x29, test_data
    addi    x29, x29,36
    li     x7, MASK_XLEN(-8)
    add    x29, x29, x7
    lhu x3, 8(x29)
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x0000000000000002)

    # Testcase 127:  imm:0x4, result rd:x4(0x0000000000000004)
    la  x28, test_data
    addi    x28, x28,38
    li     x7, MASK_XLEN(-4)
    add    x28, x28, x7
    lhu x4, 4(x28)
    sd x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x0000000000000004)

    # Testcase 128:  imm:0x2, result rd:x5(0x0000000000000008)
    la  x27, test_data
    addi    x27, x27,40
    li     x7, MASK_XLEN(-2)
    add    x27, x27, x7
    lhu x5, 2(x27)
    sd x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x0000000000000008)

    # Testcase 129:  imm:0x1, result rd:x6(0x0000000000000010)
    la  x26, test_data
    addi    x26, x26,42
    li     x7, MASK_XLEN(-1)
    add    x26, x26, x7
    lhu x6, 1(x26)
    sd x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x0000000000000010)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # Addresses for test data and results
    la x1, test_27_res

    # Testcase 130:  imm:0xfff, result rd:x7(0x0000000000000020)
    la  x25, test_data
    addi    x25, x25,44
    li     x2, MASK_XLEN(1)
    add    x25, x25, x2
    lhu x7, -1(x25)
    sd x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x0000000000000020)

    # Testcase 131:  imm:0x7ff, result rd:x8(0x0000000000000040)
    la  x24, test_data
    addi    x24, x24,46
    li     x2, MASK_XLEN(-2047)
    add    x24, x24, x2
    lhu x8, 2047(x24)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000040)

    # Testcase 132:  imm:0xbff, result rd:x9(0x0000000000000080)
    la  x23, test_data
    addi    x23, x23,48
    li     x2, MASK_XLEN(1025)
    add    x23, x23, x2
    lhu x9, -1025(x23)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000080)

    # Testcase 133:  imm:0xdff, result rd:x10(0x0000000000000100)
    la  x22, test_data
    addi    x22, x22,50
    li     x2, MASK_XLEN(513)
    add    x22, x22, x2
    lhu x10, -513(x22)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000100)

    # Testcase 134:  imm:0xeff, result rd:x11(0x0000000000000200)
    la  x21, test_data
    addi    x21, x21,52
    li     x2, MASK_XLEN(257)
    add    x21, x21, x2
    lhu x11, -257(x21)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000200)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # Addresses for test data and results
    la x6, test_28_res

    # Testcase 135:  imm:0xf7f, result rd:x12(0x0000000000000400)
    la  x20, test_data
    addi    x20, x20,54
    li     x7, MASK_XLEN(129)
    add    x20, x20, x7
    lhu x12, -129(x20)
    sd x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x0000000000000400)

    # Testcase 136:  imm:0xfbf, result rd:x13(0x0000000000000800)
    la  x19, test_data
    addi    x19, x19,56
    li     x7, MASK_XLEN(65)
    add    x19, x19, x7
    lhu x13, -65(x19)
    sd x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x0000000000000800)

    # Testcase 137:  imm:0xfdf, result rd:x14(0x0000000000001000)
    la  x18, test_data
    addi    x18, x18,58
    li     x7, MASK_XLEN(33)
    add    x18, x18, x7
    lhu x14, -33(x18)
    sd x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x0000000000001000)

    # Testcase 138:  imm:0xfef, result rd:x15(0x0000000000002000)
    la  x17, test_data
    addi    x17, x17,60
    li     x7, MASK_XLEN(17)
    add    x17, x17, x7
    lhu x15, -17(x17)
    sd x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x15, 0x0000000000002000)

    # Testcase 139:  imm:0xff7, result rd:x16(0x0000000000004000)
    la  x16, test_data
    addi    x16, x16,62
    li     x7, MASK_XLEN(9)
    add    x16, x16, x7
    lhu x16, -9(x16)
    sd x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x16, 0x0000000000004000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # Addresses for test data and results
    la x1, test_29_res

    # Testcase 140:  imm:0xffb, result rd:x17(0x0000000000008000)
    la  x15, test_data
    addi    x15, x15,64
    li     x2, MASK_XLEN(5)
    add    x15, x15, x2
    lhu x17, -5(x15)
    sd x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x0000000000008000)

    # Testcase 141:  imm:0xffd, result rd:x18(0x0000000000000000)
    la  x14, test_data
    addi    x14, x14,66
    li     x2, MASK_XLEN(3)
    add    x14, x14, x2
    lhu x18, -3(x14)
    sd x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x0000000000000000)

    # Testcase 142:  imm:0xffe, result rd:x19(0x000000000000fffe)
    la  x13, test_data
    addi    x13, x13,68
    li     x2, MASK_XLEN(2)
    add    x13, x13, x2
    lhu x19, -2(x13)
    sd x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x000000000000fffe)

    # Testcase 143:  imm:0x0, result rd:x20(0x000000000000fffd)
    la  x12, test_data
    addi    x12, x12,70
    li     x2, MASK_XLEN(0)
    add    x12, x12, x2
    lhu x20, 0(x12)
    sd x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x000000000000fffd)

    # Testcase 144:  imm:0x800, result rd:x21(0x000000000000fffe)
    la  x11, test_data
    addi    x11, x11,0
    li     x2, MASK_XLEN(2048)
    add    x11, x11, x2
    lhu x21, -2048(x11)
    sd x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x000000000000fffe)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # Addresses for test data and results
    la x1, test_30_res

    # Testcase 145:  imm:0x400, result rd:x22(0x000000000000fffd)
    la  x10, test_data
    addi    x10, x10,2
    li     x2, MASK_XLEN(-1024)
    add    x10, x10, x2
    lhu x22, 1024(x10)
    sd x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x000000000000fffd)

    # Testcase 146:  imm:0x200, result rd:x23(0x000000000000fffb)
    la  x9, test_data
    addi    x9, x9,4
    li     x2, MASK_XLEN(-512)
    add    x9, x9, x2
    lhu x23, 512(x9)
    sd x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x000000000000fffb)

    # Testcase 147:  imm:0x100, result rd:x24(0x000000000000fff7)
    la  x8, test_data
    addi    x8, x8,6
    li     x2, MASK_XLEN(-256)
    add    x8, x8, x2
    lhu x24, 256(x8)
    sd x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x000000000000fff7)

    # Testcase 148:  imm:0x80, result rd:x25(0x000000000000ffef)
    la  x7, test_data
    addi    x7, x7,8
    li     x2, MASK_XLEN(-128)
    add    x7, x7, x2
    lhu x25, 128(x7)
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x000000000000ffef)

    # Testcase 149:  imm:0x40, result rd:x26(0x000000000000ffdf)
    la  x6, test_data
    addi    x6, x6,10
    li     x2, MASK_XLEN(-64)
    add    x6, x6, x2
    lhu x26, 64(x6)
    sd x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x26, 0x000000000000ffdf)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # Addresses for test data and results
    la x6, test_31_res

    # Testcase 150:  imm:0x20, result rd:x27(0x000000000000ffbf)
    la  x5, test_data
    addi    x5, x5,12
    li     x7, MASK_XLEN(-32)
    add    x5, x5, x7
    lhu x27, 32(x5)
    sd x27, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x000000000000ffbf)

    # Testcase 151:  imm:0x10, result rd:x28(0x000000000000ff7f)
    la  x4, test_data
    addi    x4, x4,14
    li     x7, MASK_XLEN(-16)
    add    x4, x4, x7
    lhu x28, 16(x4)
    sd x28, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x000000000000ff7f)

    # Testcase 152:  imm:0x8, result rd:x29(0x000000000000feff)
    la  x3, test_data
    addi    x3, x3,16
    li     x7, MASK_XLEN(-8)
    add    x3, x3, x7
    lhu x29, 8(x3)
    sd x29, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x000000000000feff)

    # Testcase 153:  imm:0x4, result rd:x30(0x000000000000fdff)
    la  x2, test_data
    addi    x2, x2,18
    li     x7, MASK_XLEN(-4)
    add    x2, x2, x7
    lhu x30, 4(x2)
    sd x30, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x30, 0x000000000000fdff)

    # Testcase 154:  imm:0x2, result rd:x31(0x000000000000feff)
    la  x1, test_data
    addi    x1, x1,20
    li     x7, MASK_XLEN(-2)
    add    x1, x1, x7
    lhu x31, 2(x1)
    sd x31, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x31, 0x000000000000feff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # Addresses for test data and results
    la x6, test_32_res

    # Testcase 155:  imm:0x1, result rd:x1(0x000000000000f7ff)
    la  x31, test_data
    addi    x31, x31,22
    li     x7, MASK_XLEN(-1)
    add    x31, x31, x7
    lhu x1, 1(x31)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x000000000000f7ff)

    # Testcase 156:  imm:0xfff, result rd:x2(0x000000000000efff)
    la  x30, test_data
    addi    x30, x30,24
    li     x7, MASK_XLEN(1)
    add    x30, x30, x7
    lhu x2, -1(x30)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x000000000000efff)

    # Testcase 157:  imm:0x7ff, result rd:x3(0x000000000000dfff)
    la  x29, test_data
    addi    x29, x29,26
    li     x7, MASK_XLEN(-2047)
    add    x29, x29, x7
    lhu x3, 2047(x29)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x000000000000dfff)

    # Testcase 158:  imm:0xbff, result rd:x4(0x000000000000efff)
    la  x28, test_data
    addi    x28, x28,28
    li     x7, MASK_XLEN(1025)
    add    x28, x28, x7
    lhu x4, -1025(x28)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x000000000000efff)

    # Testcase 159:  imm:0xdff, result rd:x5(0x0000000000007fff)
    la  x27, test_data
    addi    x27, x27,30
    li     x7, MASK_XLEN(513)
    add    x27, x27, x7
    lhu x5, -513(x27)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x0000000000007fff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # Addresses for test data and results
    la x1, test_33_res

    # Testcase 160:  imm:0xeff, result rd:x6(0x000000000000ffff)
    la  x26, test_data
    addi    x26, x26,32
    li     x2, MASK_XLEN(257)
    add    x26, x26, x2
    lhu x6, -257(x26)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x000000000000ffff)

    # Testcase 161:  imm:0xf7f, result rd:x7(0x0000000000000001)
    la  x25, test_data
    addi    x25, x25,34
    li     x2, MASK_XLEN(129)
    add    x25, x25, x2
    lhu x7, -129(x25)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x0000000000000001)

    # Testcase 162:  imm:0xfbf, result rd:x8(0x0000000000000002)
    la  x24, test_data
    addi    x24, x24,36
    li     x2, MASK_XLEN(65)
    add    x24, x24, x2
    lhu x8, -65(x24)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000002)

    # Testcase 163:  imm:0xfdf, result rd:x9(0x0000000000000004)
    la  x23, test_data
    addi    x23, x23,38
    li     x2, MASK_XLEN(33)
    add    x23, x23, x2
    lhu x9, -33(x23)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000004)

    # Testcase 164:  imm:0xfef, result rd:x10(0x0000000000000008)
    la  x22, test_data
    addi    x22, x22,40
    li     x2, MASK_XLEN(17)
    add    x22, x22, x2
    lhu x10, -17(x22)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000008)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # Addresses for test data and results
    la x1, test_34_res

    # Testcase 165:  imm:0xff7, result rd:x11(0x0000000000000010)
    la  x21, test_data
    addi    x21, x21,42
    li     x7, MASK_XLEN(9)
    add    x21, x21, x7
    lhu x11, -9(x21)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x11, 0x0000000000000010)

    # Testcase 166:  imm:0xffb, result rd:x12(0x0000000000000020)
    la  x20, test_data
    addi    x20, x20,44
    li     x7, MASK_XLEN(5)
    add    x20, x20, x7
    lhu x12, -5(x20)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x0000000000000020)

    # Testcase 167:  imm:0xffd, result rd:x13(0x0000000000000040)
    la  x19, test_data
    addi    x19, x19,46
    li     x7, MASK_XLEN(3)
    add    x19, x19, x7
    lhu x13, -3(x19)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x0000000000000040)

    # Testcase 168:  imm:0xffe, result rd:x14(0x0000000000000080)
    la  x18, test_data
    addi    x18, x18,48
    li     x7, MASK_XLEN(2)
    add    x18, x18, x7
    lhu x14, -2(x18)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x0000000000000080)

    # Testcase 169:  imm:0x0, result rd:x15(0x0000000000000100)
    la  x17, test_data
    addi    x17, x17,50
    li     x7, MASK_XLEN(0)
    add    x17, x17, x7
    lhu x15, 0(x17)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x15, 0x0000000000000100)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # Addresses for test data and results
    la x2, test_35_res

    # Testcase 170:  imm:0x800, result rd:x16(0x0000000000000200)
    la  x16, test_data
    addi    x16, x16,52
    li     x3, MASK_XLEN(2048)
    add    x16, x16, x3
    lhu x16, -2048(x16)
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x0000000000000200)

    # Testcase 171:  imm:0x400, result rd:x17(0x0000000000000400)
    la  x15, test_data
    addi    x15, x15,54
    li     x3, MASK_XLEN(-1024)
    add    x15, x15, x3
    lhu x17, 1024(x15)
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x0000000000000400)

    # Testcase 172:  imm:0x200, result rd:x18(0x0000000000000800)
    la  x14, test_data
    addi    x14, x14,56
    li     x3, MASK_XLEN(-512)
    add    x14, x14, x3
    lhu x18, 512(x14)
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x0000000000000800)

    # Testcase 173:  imm:0x100, result rd:x19(0x0000000000001000)
    la  x13, test_data
    addi    x13, x13,58
    li     x3, MASK_XLEN(-256)
    add    x13, x13, x3
    lhu x19, 256(x13)
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0000000000001000)

    # Testcase 174:  imm:0x80, result rd:x20(0x0000000000002000)
    la  x12, test_data
    addi    x12, x12,60
    li     x3, MASK_XLEN(-128)
    add    x12, x12, x3
    lhu x20, 128(x12)
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x0000000000002000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # Addresses for test data and results
    la x1, test_36_res

    # Testcase 175:  imm:0x40, result rd:x21(0x0000000000004000)
    la  x11, test_data
    addi    x11, x11,62
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    lhu x21, 64(x11)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x0000000000004000)

    # Testcase 176:  imm:0x20, result rd:x22(0x0000000000008000)
    la  x10, test_data
    addi    x10, x10,64
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    lhu x22, 32(x10)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x0000000000008000)

    # Testcase 177:  imm:0x10, result rd:x23(0x0000000000000000)
    la  x9, test_data
    addi    x9, x9,66
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    lhu x23, 16(x9)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x0000000000000000)

    # Testcase 178:  imm:0x8, result rd:x24(0x000000000000fffe)
    la  x8, test_data
    addi    x8, x8,68
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    lhu x24, 8(x8)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x000000000000fffe)

    # Testcase 179:  imm:0x4, result rd:x25(0x000000000000fffd)
    la  x7, test_data
    addi    x7, x7,70
    li     x2, MASK_XLEN(-4)
    add    x7, x7, x2
    lhu x25, 4(x7)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x000000000000fffd)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # Addresses for test data and results
    la x1, test_37_res

    # Testcase 180:  imm:0x2, result rd:x26(0x000000000000fffe)
    la  x6, test_data
    addi    x6, x6,0
    li     x7, MASK_XLEN(-2)
    add    x6, x6, x7
    lhu x26, 2(x6)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x26, 0x000000000000fffe)

    # Testcase 181:  imm:0x1, result rd:x27(0x000000000000fffd)
    la  x5, test_data
    addi    x5, x5,2
    li     x7, MASK_XLEN(-1)
    add    x5, x5, x7
    lhu x27, 1(x5)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x000000000000fffd)

    # Testcase 182:  imm:0xfff, result rd:x28(0x000000000000fffb)
    la  x4, test_data
    addi    x4, x4,4
    li     x7, MASK_XLEN(1)
    add    x4, x4, x7
    lhu x28, -1(x4)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x000000000000fffb)

    # Testcase 183:  imm:0x7ff, result rd:x29(0x000000000000fff7)
    la  x3, test_data
    addi    x3, x3,6
    li     x7, MASK_XLEN(-2047)
    add    x3, x3, x7
    lhu x29, 2047(x3)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x000000000000fff7)

    # Testcase 184:  imm:0xbff, result rd:x30(0x000000000000ffef)
    la  x2, test_data
    addi    x2, x2,8
    li     x7, MASK_XLEN(1025)
    add    x2, x2, x7
    lhu x30, -1025(x2)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x30, 0x000000000000ffef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # Addresses for test data and results
    la x5, test_38_res

    # Testcase 185:  imm:0xdff, result rd:x31(0x000000000000ffdf)
    la  x1, test_data
    addi    x1, x1,10
    li     x6, MASK_XLEN(513)
    add    x1, x1, x6
    lhu x31, -513(x1)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x000000000000ffdf)

    # Testcase 186:  imm:0xeff, result rd:x1(0x000000000000ffbf)
    la  x31, test_data
    addi    x31, x31,12
    li     x6, MASK_XLEN(257)
    add    x31, x31, x6
    lhu x1, -257(x31)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x000000000000ffbf)

    # Testcase 187:  imm:0xf7f, result rd:x2(0x000000000000ff7f)
    la  x30, test_data
    addi    x30, x30,14
    li     x6, MASK_XLEN(129)
    add    x30, x30, x6
    lhu x2, -129(x30)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x000000000000ff7f)

    # Testcase 188:  imm:0xfbf, result rd:x3(0x000000000000feff)
    la  x29, test_data
    addi    x29, x29,16
    li     x6, MASK_XLEN(65)
    add    x29, x29, x6
    lhu x3, -65(x29)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x000000000000feff)

    # Testcase 189:  imm:0xfdf, result rd:x4(0x000000000000fdff)
    la  x28, test_data
    addi    x28, x28,18
    li     x6, MASK_XLEN(33)
    add    x28, x28, x6
    lhu x4, -33(x28)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x000000000000fdff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # Addresses for test data and results
    la x1, test_39_res

    # Testcase 190:  imm:0xfef, result rd:x5(0x000000000000feff)
    la  x27, test_data
    addi    x27, x27,20
    li     x2, MASK_XLEN(17)
    add    x27, x27, x2
    lhu x5, -17(x27)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x5, 0x000000000000feff)

    # Testcase 191:  imm:0xff7, result rd:x6(0x000000000000f7ff)
    la  x26, test_data
    addi    x26, x26,22
    li     x2, MASK_XLEN(9)
    add    x26, x26, x2
    lhu x6, -9(x26)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x000000000000f7ff)

    # Testcase 192:  imm:0xffb, result rd:x7(0x000000000000efff)
    la  x25, test_data
    addi    x25, x25,24
    li     x2, MASK_XLEN(5)
    add    x25, x25, x2
    lhu x7, -5(x25)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x000000000000efff)

    # Testcase 193:  imm:0xffd, result rd:x8(0x000000000000dfff)
    la  x24, test_data
    addi    x24, x24,26
    li     x2, MASK_XLEN(3)
    add    x24, x24, x2
    lhu x8, -3(x24)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x000000000000dfff)

    # Testcase 194:  imm:0xffe, result rd:x9(0x000000000000efff)
    la  x23, test_data
    addi    x23, x23,28
    li     x2, MASK_XLEN(2)
    add    x23, x23, x2
    lhu x9, -2(x23)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x000000000000efff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # Addresses for test data and results
    la x1, test_40_res

    # Testcase 195:  imm:0x0, result rd:x10(0x0000000000007fff)
    la  x22, test_data
    addi    x22, x22,30
    li     x2, MASK_XLEN(0)
    add    x22, x22, x2
    lhu x10, 0(x22)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x10, 0x0000000000007fff)

    # Testcase 196:  imm:0x800, result rd:x11(0x000000000000ffff)
    la  x21, test_data
    addi    x21, x21,32
    li     x2, MASK_XLEN(2048)
    add    x21, x21, x2
    lhu x11, -2048(x21)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x11, 0x000000000000ffff)

    # Testcase 197:  imm:0x400, result rd:x12(0x0000000000000001)
    la  x20, test_data
    addi    x20, x20,34
    li     x2, MASK_XLEN(-1024)
    add    x20, x20, x2
    lhu x12, 1024(x20)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0x0000000000000001)

    # Testcase 198:  imm:0x200, result rd:x13(0x0000000000000002)
    la  x19, test_data
    addi    x19, x19,36
    li     x2, MASK_XLEN(-512)
    add    x19, x19, x2
    lhu x13, 512(x19)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0x0000000000000002)

    # Testcase 199:  imm:0x100, result rd:x14(0x0000000000000004)
    la  x18, test_data
    addi    x18, x18,38
    li     x2, MASK_XLEN(-256)
    add    x18, x18, x2
    lhu x14, 256(x18)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0x0000000000000004)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # Addresses for test data and results
    la x3, test_41_res

    # Testcase 200:  imm:0x80, result rd:x15(0x0000000000000008)
    la  x17, test_data
    addi    x17, x17,40
    li     x4, MASK_XLEN(-128)
    add    x17, x17, x4
    lhu x15, 128(x17)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0000000000000008)

    # Testcase 201:  imm:0x40, result rd:x16(0x0000000000000010)
    la  x16, test_data
    addi    x16, x16,42
    li     x4, MASK_XLEN(-64)
    add    x16, x16, x4
    lhu x16, 64(x16)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0000000000000010)

    # Testcase 202:  imm:0x20, result rd:x17(0x0000000000000020)
    la  x15, test_data
    addi    x15, x15,44
    li     x4, MASK_XLEN(-32)
    add    x15, x15, x4
    lhu x17, 32(x15)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x0000000000000020)

    # Testcase 203:  imm:0x10, result rd:x18(0x0000000000000040)
    la  x14, test_data
    addi    x14, x14,46
    li     x4, MASK_XLEN(-16)
    add    x14, x14, x4
    lhu x18, 16(x14)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x0000000000000040)

    # Testcase 204:  imm:0x8, result rd:x19(0x0000000000000080)
    la  x13, test_data
    addi    x13, x13,48
    li     x4, MASK_XLEN(-8)
    add    x13, x13, x4
    lhu x19, 8(x13)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0x0000000000000080)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # Addresses for test data and results
    la x1, test_42_res

    # Testcase 205:  imm:0x4, result rd:x20(0x0000000000000100)
    la  x12, test_data
    addi    x12, x12,50
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    lhu x20, 4(x12)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0000000000000100)

    # Testcase 206:  imm:0x2, result rd:x21(0x0000000000000200)
    la  x11, test_data
    addi    x11, x11,52
    li     x2, MASK_XLEN(-2)
    add    x11, x11, x2
    lhu x21, 2(x11)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x0000000000000200)

    # Testcase 207:  imm:0x1, result rd:x22(0x0000000000000400)
    la  x10, test_data
    addi    x10, x10,54
    li     x2, MASK_XLEN(-1)
    add    x10, x10, x2
    lhu x22, 1(x10)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x0000000000000400)

    # Testcase 208:  imm:0xfff, result rd:x23(0x0000000000000800)
    la  x9, test_data
    addi    x9, x9,56
    li     x2, MASK_XLEN(1)
    add    x9, x9, x2
    lhu x23, -1(x9)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x0000000000000800)

    # Testcase 209:  imm:0x7ff, result rd:x24(0x0000000000001000)
    la  x8, test_data
    addi    x8, x8,58
    li     x2, MASK_XLEN(-2047)
    add    x8, x8, x2
    lhu x24, 2047(x8)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x0000000000001000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # Addresses for test data and results
    la x1, test_43_res

    # Testcase 210:  imm:0xbff, result rd:x25(0x0000000000002000)
    la  x7, test_data
    addi    x7, x7,60
    li     x2, MASK_XLEN(1025)
    add    x7, x7, x2
    lhu x25, -1025(x7)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x25, 0x0000000000002000)

    # Testcase 211:  imm:0xdff, result rd:x26(0x0000000000004000)
    la  x6, test_data
    addi    x6, x6,62
    li     x2, MASK_XLEN(513)
    add    x6, x6, x2
    lhu x26, -513(x6)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x26, 0x0000000000004000)

    # Testcase 212:  imm:0xeff, result rd:x27(0x0000000000008000)
    la  x5, test_data
    addi    x5, x5,64
    li     x2, MASK_XLEN(257)
    add    x5, x5, x2
    lhu x27, -257(x5)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x27, 0x0000000000008000)

    # Testcase 213:  imm:0xf7f, result rd:x28(0x0000000000000000)
    la  x4, test_data
    addi    x4, x4,66
    li     x2, MASK_XLEN(129)
    add    x4, x4, x2
    lhu x28, -129(x4)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x28, 0x0000000000000000)

    # Testcase 214:  imm:0xfbf, result rd:x29(0x000000000000fffe)
    la  x3, test_data
    addi    x3, x3,68
    li     x2, MASK_XLEN(65)
    add    x3, x3, x2
    lhu x29, -65(x3)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x29, 0x000000000000fffe)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # Addresses for test data and results
    la x4, test_44_res

    # Testcase 215:  imm:0xfdf, result rd:x30(0x000000000000fffd)
    la  x2, test_data
    addi    x2, x2,70
    li     x5, MASK_XLEN(33)
    add    x2, x2, x5
    lhu x30, -33(x2)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x000000000000fffd)

    # Testcase 216:  imm:0xfef, result rd:x31(0x000000000000fffe)
    la  x1, test_data
    addi    x1, x1,0
    li     x5, MASK_XLEN(17)
    add    x1, x1, x5
    lhu x31, -17(x1)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x000000000000fffe)

    # Testcase 217:  imm:0xff7, result rd:x1(0x000000000000fffd)
    la  x31, test_data
    addi    x31, x31,2
    li     x5, MASK_XLEN(9)
    add    x31, x31, x5
    lhu x1, -9(x31)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x000000000000fffd)

    # Testcase 218:  imm:0xffb, result rd:x2(0x000000000000fffb)
    la  x30, test_data
    addi    x30, x30,4
    li     x5, MASK_XLEN(5)
    add    x30, x30, x5
    lhu x2, -5(x30)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x000000000000fffb)

    # Testcase 219:  imm:0xffd, result rd:x3(0x000000000000fff7)
    la  x29, test_data
    addi    x29, x29,6
    li     x5, MASK_XLEN(3)
    add    x29, x29, x5
    lhu x3, -3(x29)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x000000000000fff7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # Addresses for test data and results
    la x1, test_45_res

    # Testcase 220:  imm:0xffe, result rd:x4(0x000000000000ffef)
    la  x28, test_data
    addi    x28, x28,8
    li     x2, MASK_XLEN(2)
    add    x28, x28, x2
    lhu x4, -2(x28)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0x000000000000ffef)

    # Testcase 221:  imm:0x0, result rd:x5(0x000000000000ffdf)
    la  x27, test_data
    addi    x27, x27,10
    li     x2, MASK_XLEN(0)
    add    x27, x27, x2
    lhu x5, 0(x27)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x5, 0x000000000000ffdf)

    # Testcase 222:  imm:0x800, result rd:x6(0x000000000000ffbf)
    la  x26, test_data
    addi    x26, x26,12
    li     x2, MASK_XLEN(2048)
    add    x26, x26, x2
    lhu x6, -2048(x26)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x6, 0x000000000000ffbf)

    # Testcase 223:  imm:0x400, result rd:x7(0x000000000000ff7f)
    la  x25, test_data
    addi    x25, x25,14
    li     x2, MASK_XLEN(-1024)
    add    x25, x25, x2
    lhu x7, 1024(x25)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x000000000000ff7f)

    # Testcase 224:  imm:0x200, result rd:x8(0x000000000000feff)
    la  x24, test_data
    addi    x24, x24,16
    li     x2, MASK_XLEN(-512)
    add    x24, x24, x2
    lhu x8, 512(x24)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x000000000000feff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # Addresses for test data and results
    la x1, test_46_res

    # Testcase 225:  imm:0x100, result rd:x9(0x000000000000fdff)
    la  x23, test_data
    addi    x23, x23,18
    li     x2, MASK_XLEN(-256)
    add    x23, x23, x2
    lhu x9, 256(x23)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x000000000000fdff)

    # Testcase 226:  imm:0x80, result rd:x10(0x000000000000feff)
    la  x22, test_data
    addi    x22, x22,20
    li     x2, MASK_XLEN(-128)
    add    x22, x22, x2
    lhu x10, 128(x22)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x000000000000feff)

    # Testcase 227:  imm:0x40, result rd:x11(0x000000000000f7ff)
    la  x21, test_data
    addi    x21, x21,22
    li     x2, MASK_XLEN(-64)
    add    x21, x21, x2
    lhu x11, 64(x21)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x000000000000f7ff)

    # Testcase 228:  imm:0x20, result rd:x12(0x000000000000efff)
    la  x20, test_data
    addi    x20, x20,24
    li     x2, MASK_XLEN(-32)
    add    x20, x20, x2
    lhu x12, 32(x20)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x000000000000efff)

    # Testcase 229:  imm:0x10, result rd:x13(0x000000000000dfff)
    la  x19, test_data
    addi    x19, x19,26
    li     x2, MASK_XLEN(-16)
    add    x19, x19, x2
    lhu x13, 16(x19)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x000000000000dfff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # Addresses for test data and results
    la x4, test_47_res

    # Testcase 230:  imm:0x8, result rd:x14(0x000000000000efff)
    la  x18, test_data
    addi    x18, x18,28
    li     x5, MASK_XLEN(-8)
    add    x18, x18, x5
    lhu x14, 8(x18)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x000000000000efff)

    # Testcase 231:  imm:0x4, result rd:x15(0x0000000000007fff)
    la  x17, test_data
    addi    x17, x17,30
    li     x5, MASK_XLEN(-4)
    add    x17, x17, x5
    lhu x15, 4(x17)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x0000000000007fff)

    # Testcase 232:  imm:0x2, result rd:x16(0x000000000000ffff)
    la  x16, test_data
    addi    x16, x16,32
    li     x5, MASK_XLEN(-2)
    add    x16, x16, x5
    lhu x16, 2(x16)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x000000000000ffff)

    # Testcase 233:  imm:0x1, result rd:x17(0x0000000000000001)
    la  x15, test_data
    addi    x15, x15,34
    li     x5, MASK_XLEN(-1)
    add    x15, x15, x5
    lhu x17, 1(x15)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x0000000000000001)

    # Testcase 234:  imm:0xfff, result rd:x18(0x0000000000000002)
    la  x14, test_data
    addi    x14, x14,36
    li     x5, MASK_XLEN(1)
    add    x14, x14, x5
    lhu x18, -1(x14)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x18, 0x0000000000000002)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # Addresses for test data and results
    la x1, test_48_res

    # Testcase 235:  imm:0x7ff, result rd:x19(0x0000000000000004)
    la  x13, test_data
    addi    x13, x13,38
    li     x2, MASK_XLEN(-2047)
    add    x13, x13, x2
    lhu x19, 2047(x13)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x0000000000000004)

    # Testcase 236:  imm:0xbff, result rd:x20(0x0000000000000008)
    la  x12, test_data
    addi    x12, x12,40
    li     x2, MASK_XLEN(1025)
    add    x12, x12, x2
    lhu x20, -1025(x12)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0000000000000008)

    # Testcase 237:  imm:0xdff, result rd:x21(0x0000000000000010)
    la  x11, test_data
    addi    x11, x11,42
    li     x2, MASK_XLEN(513)
    add    x11, x11, x2
    lhu x21, -513(x11)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x21, 0x0000000000000010)

    # Testcase 238:  imm:0xeff, result rd:x22(0x0000000000000020)
    la  x10, test_data
    addi    x10, x10,44
    li     x2, MASK_XLEN(257)
    add    x10, x10, x2
    lhu x22, -257(x10)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x22, 0x0000000000000020)

    # Testcase 239:  imm:0xf7f, result rd:x23(0x0000000000000040)
    la  x9, test_data
    addi    x9, x9,46
    li     x2, MASK_XLEN(129)
    add    x9, x9, x2
    lhu x23, -129(x9)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x23, 0x0000000000000040)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # Addresses for test data and results
    la x1, test_49_res

    # Testcase 240:  imm:0xfbf, result rd:x24(0x0000000000000080)
    la  x8, test_data
    addi    x8, x8,48
    li     x2, MASK_XLEN(65)
    add    x8, x8, x2
    lhu x24, -65(x8)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x24, 0x0000000000000080)

    # Testcase 241:  imm:0xfdf, result rd:x25(0x0000000000000100)
    la  x7, test_data
    addi    x7, x7,50
    li     x2, MASK_XLEN(33)
    add    x7, x7, x2
    lhu x25, -33(x7)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x25, 0x0000000000000100)

    # Testcase 242:  imm:0xfef, result rd:x26(0x0000000000000200)
    la  x6, test_data
    addi    x6, x6,52
    li     x2, MASK_XLEN(17)
    add    x6, x6, x2
    lhu x26, -17(x6)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x26, 0x0000000000000200)

    # Testcase 243:  imm:0xff7, result rd:x27(0x0000000000000400)
    la  x5, test_data
    addi    x5, x5,54
    li     x2, MASK_XLEN(9)
    add    x5, x5, x2
    lhu x27, -9(x5)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x27, 0x0000000000000400)

    # Testcase 244:  imm:0xffb, result rd:x28(0x0000000000000800)
    la  x4, test_data
    addi    x4, x4,56
    li     x2, MASK_XLEN(5)
    add    x4, x4, x2
    lhu x28, -5(x4)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x28, 0x0000000000000800)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # Addresses for test data and results
    la x4, test_50_res

    # Testcase 245:  imm:0xffd, result rd:x29(0x0000000000001000)
    la  x3, test_data
    addi    x3, x3,58
    li     x5, MASK_XLEN(3)
    add    x3, x3, x5
    lhu x29, -3(x3)
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x0000000000001000)

    # Testcase 246:  imm:0xffe, result rd:x30(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,60
    li     x5, MASK_XLEN(2)
    add    x2, x2, x5
    lhu x30, -2(x2)
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x0000000000002000)

    # Testcase 247:  imm:0x0, result rd:x31(0x0000000000004000)
    la  x1, test_data
    addi    x1, x1,62
    li     x5, MASK_XLEN(0)
    add    x1, x1, x5
    lhu x31, 0(x1)
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0000000000004000)

    # Testcase 248:  imm:0x800, result rd:x1(0x0000000000008000)
    la  x31, test_data
    addi    x31, x31,64
    li     x5, MASK_XLEN(2048)
    add    x31, x31, x5
    lhu x1, -2048(x31)
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0000000000008000)

    # Testcase 249:  imm:0x400, result rd:x2(0x0000000000000000)
    la  x30, test_data
    addi    x30, x30,66
    li     x5, MASK_XLEN(-1024)
    add    x30, x30, x5
    lhu x2, 1024(x30)
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # Addresses for test data and results
    la x1, test_51_res

    # Testcase 250:  imm:0x200, result rd:x3(0x000000000000fffe)
    la  x29, test_data
    addi    x29, x29,68
    li     x2, MASK_XLEN(-512)
    add    x29, x29, x2
    lhu x3, 512(x29)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x000000000000fffe)

    # Testcase 251:  imm:0x100, result rd:x4(0x000000000000fffd)
    la  x28, test_data
    addi    x28, x28,70
    li     x2, MASK_XLEN(-256)
    add    x28, x28, x2
    lhu x4, 256(x28)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x000000000000fffd)

    # Testcase 252:  imm:0x80, result rd:x5(0x000000000000fffe)
    la  x27, test_data
    addi    x27, x27,0
    li     x2, MASK_XLEN(-128)
    add    x27, x27, x2
    lhu x5, 128(x27)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x000000000000fffe)

    # Testcase 253:  imm:0x40, result rd:x6(0x000000000000fffd)
    la  x26, test_data
    addi    x26, x26,2
    li     x2, MASK_XLEN(-64)
    add    x26, x26, x2
    lhu x6, 64(x26)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x000000000000fffd)

    # Testcase 254:  imm:0x20, result rd:x7(0x000000000000fffb)
    la  x25, test_data
    addi    x25, x25,4
    li     x2, MASK_XLEN(-32)
    add    x25, x25, x2
    lhu x7, 32(x25)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x7, 0x000000000000fffb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # Addresses for test data and results
    la x1, test_52_res

    # Testcase 255:  imm:0x10, result rd:x8(0x000000000000fff7)
    la  x24, test_data
    addi    x24, x24,6
    li     x2, MASK_XLEN(-16)
    add    x24, x24, x2
    lhu x8, 16(x24)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x000000000000fff7)

    # Testcase 256:  imm:0x8, result rd:x9(0x000000000000ffef)
    la  x23, test_data
    addi    x23, x23,8
    li     x2, MASK_XLEN(-8)
    add    x23, x23, x2
    lhu x9, 8(x23)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x000000000000ffef)

    # Testcase 257:  imm:0x4, result rd:x10(0x000000000000ffdf)
    la  x22, test_data
    addi    x22, x22,10
    li     x2, MASK_XLEN(-4)
    add    x22, x22, x2
    lhu x10, 4(x22)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x000000000000ffdf)

    # Testcase 258:  imm:0x2, result rd:x11(0x000000000000ffbf)
    la  x21, test_data
    addi    x21, x21,12
    li     x2, MASK_XLEN(-2)
    add    x21, x21, x2
    lhu x11, 2(x21)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x000000000000ffbf)

    # Testcase 259:  imm:0x1, result rd:x12(0x000000000000ff7f)
    la  x20, test_data
    addi    x20, x20,14
    li     x2, MASK_XLEN(-1)
    add    x20, x20, x2
    lhu x12, 1(x20)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x000000000000ff7f)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # Addresses for test data and results
    la x2, test_53_res

    # Testcase 260:  imm:0xfff, result rd:x13(0x000000000000feff)
    la  x19, test_data
    addi    x19, x19,16
    li     x5, MASK_XLEN(1)
    add    x19, x19, x5
    lhu x13, -1(x19)
    sd x13, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x000000000000feff)

    # Testcase 261:  imm:0x7ff, result rd:x0(0x0000000000000000)
    la  x18, test_data
    addi    x18, x18,18
    li     x5, MASK_XLEN(-2047)
    add    x18, x18, x5
    lhu x0, 2047(x18)
    sd x0, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x0, 0x0000000000000000)

    # Testcase 262:  imm:0xbff, result rd:x15(0x000000000000feff)
    la  x17, test_data
    addi    x17, x17,20
    li     x5, MASK_XLEN(1025)
    add    x17, x17, x5
    lhu x15, -1025(x17)
    sd x15, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x000000000000feff)

    # Testcase 263:  imm:0xdff, result rd:x16(0x000000000000f7ff)
    la  x16, test_data
    addi    x16, x16,22
    li     x5, MASK_XLEN(513)
    add    x16, x16, x5
    lhu x16, -513(x16)
    sd x16, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x000000000000f7ff)



	# ---------------------------------------------------------------------------------------------
	
	RVTEST_IO_WRITE_STR(x31, "Test End\n")

	# ---------------------------------------------------------------------------------------------

	RV_COMPLIANCE_HALT

RV_COMPLIANCE_CODE_END

# Input data section.
	.data

	.align 8
test_data:

	.dword 0xfff7fffbfffdfffe
	.dword 0xff7fffbfffdfffef
	.dword 0xf7fffefffdfffeff
	.dword 0x7fffefffdfffefff
	.dword 0x000400020001ffff
	.dword 0x0040002000100008
	.dword 0x0400020001000080
	.dword 0x4000200010000800
	.dword 0xfffdfffe00008000


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

