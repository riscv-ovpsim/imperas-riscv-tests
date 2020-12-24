# RISC-V Compliance Test I-XORI-01
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
# Description: Testing instruction 'XORI'.

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


    # address for test results
    la x6, test_1_res


    # Testcase 0:  rs1:x31(0x10fd3dedadea5195), imm:0xc23, result rd:x1(0x5215adb6)
    li x31, MASK_XLEN(0x10fd3dedadea5195)
    xori x1, x31, SEXT_IMM(0xc23)
    sw x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x5215adb6)

    # Testcase 1:  rs1:x30(0xbd295ce2d2ffbec1), imm:0x5b, result rd:x2(0xd2ffbe9a)
    li x30, MASK_XLEN(0xbd295ce2d2ffbec1)
    xori x2, x30, SEXT_IMM(0x5b)
    sw x2, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xd2ffbe9a)

    # Testcase 2:  rs1:x29(0xc9649f05a8e1a8bb), imm:0x2c0, result rd:x3(0xa8e1aa7b)
    li x29, MASK_XLEN(0xc9649f05a8e1a8bb)
    xori x3, x29, SEXT_IMM(0x2c0)
    sw x3, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xa8e1aa7b)

    # Testcase 3:  rs1:x28(0x3541291848c99fcb), imm:0xbc3, result rd:x4(0xb7366408)
    li x28, MASK_XLEN(0x3541291848c99fcb)
    xori x4, x28, SEXT_IMM(0xbc3)
    sw x4, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xb7366408)

    # Testcase 4:  rs1:x27(0x10a24740461d524f), imm:0xaf, result rd:x5(0x461d52e0)
    li x27, MASK_XLEN(0x10a24740461d524f)
    xori x5, x27, SEXT_IMM(0xaf)
    sw x5, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x461d52e0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rs1:x26(0x546b0e54528a10af), imm:0x24f, result rd:x6(0x528a12e0)
    li x26, MASK_XLEN(0x546b0e54528a10af)
    xori x6, x26, SEXT_IMM(0x24f)
    sw x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x528a12e0)

    # Testcase 6:  rs1:x25(0x73a92fd4e19bfbc3), imm:0xfcb, result rd:x7(0x1e640408)
    li x25, MASK_XLEN(0x73a92fd4e19bfbc3)
    xori x7, x25, SEXT_IMM(0xfcb)
    sw x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x1e640408)

    # Testcase 7:  rs1:x24(0x82f6747f707af2c0), imm:0x8bb, result rd:x8(0x8f850a7b)
    li x24, MASK_XLEN(0x82f6747f707af2c0)
    xori x8, x24, SEXT_IMM(0x8bb)
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8f850a7b)

    # Testcase 8:  rs1:x23(0xf5adb41aa47d105b), imm:0xec1, result rd:x9(0x5b82ee9a)
    li x23, MASK_XLEN(0xf5adb41aa47d105b)
    xori x9, x23, SEXT_IMM(0xec1)
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x5b82ee9a)

    # Testcase 9:  rs1:x22(0xdf7f3844121bcc23), imm:0x195, result rd:x10(0x121bcdb6)
    li x22, MASK_XLEN(0xdf7f3844121bcc23)
    xori x10, x22, SEXT_IMM(0x195)
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x121bcdb6)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rs1:x21(0x00000001), imm:0xfff, result rd:x11(0xfffffffe)
    li x21, MASK_XLEN(0x1)
    xori x11, x21, SEXT_IMM(0xfff)
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0xfffffffe)

    # Testcase 11:  rs1:x20(0x00000002), imm:0x7ff, result rd:x12(0x000007fd)
    li x20, MASK_XLEN(0x2)
    xori x12, x20, SEXT_IMM(0x7ff)
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x000007fd)

    # Testcase 12:  rs1:x19(0x00000004), imm:0xbff, result rd:x13(0xfffffbfb)
    li x19, MASK_XLEN(0x4)
    xori x13, x19, SEXT_IMM(0xbff)
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0xfffffbfb)

    # Testcase 13:  rs1:x18(0x00000008), imm:0xdff, result rd:x14(0xfffffdf7)
    li x18, MASK_XLEN(0x8)
    xori x14, x18, SEXT_IMM(0xdff)
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xfffffdf7)

    # Testcase 14:  rs1:x17(0x00000010), imm:0xeff, result rd:x15(0xfffffeef)
    li x17, MASK_XLEN(0x10)
    xori x15, x17, SEXT_IMM(0xeff)
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0xfffffeef)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res


    # Testcase 15:  rs1:x16(0x00000020), imm:0xf7f, result rd:x16(0xffffff5f)
    li x16, MASK_XLEN(0x20)
    xori x16, x16, SEXT_IMM(0xf7f)
    sw x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0xffffff5f)

    # Testcase 16:  rs1:x15(0x00000040), imm:0xfbf, result rd:x17(0xffffffff)
    li x15, MASK_XLEN(0x40)
    xori x17, x15, SEXT_IMM(0xfbf)
    sw x17, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0xffffffff)

    # Testcase 17:  rs1:x14(0x00000080), imm:0xfdf, result rd:x18(0xffffff5f)
    li x14, MASK_XLEN(0x80)
    xori x18, x14, SEXT_IMM(0xfdf)
    sw x18, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0xffffff5f)

    # Testcase 18:  rs1:x13(0x00000100), imm:0xfef, result rd:x19(0xfffffeef)
    li x13, MASK_XLEN(0x100)
    xori x19, x13, SEXT_IMM(0xfef)
    sw x19, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0xfffffeef)

    # Testcase 19:  rs1:x12(0x00000200), imm:0xff7, result rd:x20(0xfffffdf7)
    li x12, MASK_XLEN(0x200)
    xori x20, x12, SEXT_IMM(0xff7)
    sw x20, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0xfffffdf7)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rs1:x11(0x00000400), imm:0xffb, result rd:x21(0xfffffbfb)
    li x11, MASK_XLEN(0x400)
    xori x21, x11, SEXT_IMM(0xffb)
    sw x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffbfb)

    # Testcase 21:  rs1:x10(0x00000800), imm:0xffd, result rd:x22(0xfffff7fd)
    li x10, MASK_XLEN(0x800)
    xori x22, x10, SEXT_IMM(0xffd)
    sw x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffff7fd)

    # Testcase 22:  rs1:x9(0x00001000), imm:0xffe, result rd:x23(0xffffeffe)
    li x9, MASK_XLEN(0x1000)
    xori x23, x9, SEXT_IMM(0xffe)
    sw x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffeffe)

    # Testcase 23:  rs1:x8(0x00002000), imm:0x0, result rd:x24(0x00002000)
    li x8, MASK_XLEN(0x2000)
    xori x24, x8, SEXT_IMM(0x0)
    sw x24, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x00002000)

    # Testcase 24:  rs1:x7(0x00004000), imm:0x800, result rd:x25(0xffffb800)
    li x7, MASK_XLEN(0x4000)
    xori x25, x7, SEXT_IMM(0x800)
    sw x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffb800)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rs1:x6(0x00008000), imm:0x400, result rd:x26(0x00008400)
    li x6, MASK_XLEN(0x8000)
    xori x26, x6, SEXT_IMM(0x400)
    sw x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x00008400)

    # Testcase 26:  rs1:x5(0x00010000), imm:0x200, result rd:x27(0x00010200)
    li x5, MASK_XLEN(0x10000)
    xori x27, x5, SEXT_IMM(0x200)
    sw x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x00010200)

    # Testcase 27:  rs1:x4(0x00020000), imm:0x100, result rd:x28(0x00020100)
    li x4, MASK_XLEN(0x20000)
    xori x28, x4, SEXT_IMM(0x100)
    sw x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x00020100)

    # Testcase 28:  rs1:x3(0x00040000), imm:0x80, result rd:x29(0x00040080)
    li x3, MASK_XLEN(0x40000)
    xori x29, x3, SEXT_IMM(0x80)
    sw x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x00040080)

    # Testcase 29:  rs1:x2(0x00080000), imm:0x40, result rd:x30(0x00080040)
    li x2, MASK_XLEN(0x80000)
    xori x30, x2, SEXT_IMM(0x40)
    sw x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x00080040)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res


    # Testcase 30:  rs1:x1(0x00100000), imm:0x20, result rd:x31(0x00100020)
    li x1, MASK_XLEN(0x100000)
    xori x31, x1, SEXT_IMM(0x20)
    sw x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x00100020)

    # Testcase 31:  rs1:x31(0x00200000), imm:0x10, result rd:x1(0x00200010)
    li x31, MASK_XLEN(0x200000)
    xori x1, x31, SEXT_IMM(0x10)
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x00200010)

    # Testcase 32:  rs1:x30(0x00400000), imm:0x8, result rd:x2(0x00400008)
    li x30, MASK_XLEN(0x400000)
    xori x2, x30, SEXT_IMM(0x8)
    sw x2, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x00400008)

    # Testcase 33:  rs1:x29(0x00800000), imm:0x4, result rd:x3(0x00800004)
    li x29, MASK_XLEN(0x800000)
    xori x3, x29, SEXT_IMM(0x4)
    sw x3, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x00800004)

    # Testcase 34:  rs1:x28(0x01000000), imm:0x2, result rd:x4(0x01000002)
    li x28, MASK_XLEN(0x1000000)
    xori x4, x28, SEXT_IMM(0x2)
    sw x4, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x01000002)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rs1:x27(0x02000000), imm:0x1, result rd:x5(0x02000001)
    li x27, MASK_XLEN(0x2000000)
    xori x5, x27, SEXT_IMM(0x1)
    sw x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x02000001)

    # Testcase 36:  rs1:x26(0x04000000), imm:0xc23, result rd:x6(0xfbfffc23)
    li x26, MASK_XLEN(0x4000000)
    xori x6, x26, SEXT_IMM(0xc23)
    sw x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfbfffc23)

    # Testcase 37:  rs1:x25(0x08000000), imm:0x5b, result rd:x7(0x0800005b)
    li x25, MASK_XLEN(0x8000000)
    xori x7, x25, SEXT_IMM(0x5b)
    sw x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0800005b)

    # Testcase 38:  rs1:x24(0x10000000), imm:0x2c0, result rd:x8(0x100002c0)
    li x24, MASK_XLEN(0x10000000)
    xori x8, x24, SEXT_IMM(0x2c0)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x100002c0)

    # Testcase 39:  rs1:x23(0x20000000), imm:0xbc3, result rd:x9(0xdffffbc3)
    li x23, MASK_XLEN(0x20000000)
    xori x9, x23, SEXT_IMM(0xbc3)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xdffffbc3)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rs1:x22(0x40000000), imm:0xaf, result rd:x10(0x400000af)
    li x22, MASK_XLEN(0x40000000)
    xori x10, x22, SEXT_IMM(0xaf)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x400000af)

    # Testcase 41:  rs1:x21(0x80000000), imm:0x24f, result rd:x11(0x8000024f)
    li x21, MASK_XLEN(0x80000000)
    xori x11, x21, SEXT_IMM(0x24f)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8000024f)

    # Testcase 42:  rs1:x20(0x00000000), imm:0xfcb, result rd:x12(0xffffffcb)
    li x20, MASK_XLEN(0x0)
    xori x12, x20, SEXT_IMM(0xfcb)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffcb)

    # Testcase 43:  rs1:x19(0xfffffffe), imm:0x8bb, result rd:x13(0x00000745)
    li x19, MASK_XLEN(0xfffffffe)
    xori x13, x19, SEXT_IMM(0x8bb)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x00000745)

    # Testcase 44:  rs1:x18(0xfffffffd), imm:0xec1, result rd:x14(0x0000013c)
    li x18, MASK_XLEN(0xfffffffd)
    xori x14, x18, SEXT_IMM(0xec1)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0000013c)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res


    # Testcase 45:  rs1:x17(0xfffffffb), imm:0x195, result rd:x15(0xfffffe6e)
    li x17, MASK_XLEN(0xfffffffb)
    xori x15, x17, SEXT_IMM(0x195)
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0xfffffe6e)

    # Testcase 46:  rs1:x16(0xfffffff7), imm:0xfff, result rd:x16(0x00000008)
    li x16, MASK_XLEN(0xfffffff7)
    xori x16, x16, SEXT_IMM(0xfff)
    sw x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x00000008)

    # Testcase 47:  rs1:x15(0xffffffef), imm:0x7ff, result rd:x17(0xfffff810)
    li x15, MASK_XLEN(0xffffffef)
    xori x17, x15, SEXT_IMM(0x7ff)
    sw x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xfffff810)

    # Testcase 48:  rs1:x14(0xffffffdf), imm:0xbff, result rd:x18(0x00000420)
    li x14, MASK_XLEN(0xffffffdf)
    xori x18, x14, SEXT_IMM(0xbff)
    sw x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x00000420)

    # Testcase 49:  rs1:x13(0xffffffbf), imm:0xdff, result rd:x19(0x00000240)
    li x13, MASK_XLEN(0xffffffbf)
    xori x19, x13, SEXT_IMM(0xdff)
    sw x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x00000240)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rs1:x12(0xffffff7f), imm:0xeff, result rd:x20(0x00000180)
    li x12, MASK_XLEN(0xffffff7f)
    xori x20, x12, SEXT_IMM(0xeff)
    sw x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x00000180)

    # Testcase 51:  rs1:x11(0xfffffeff), imm:0xf7f, result rd:x21(0x00000180)
    li x11, MASK_XLEN(0xfffffeff)
    xori x21, x11, SEXT_IMM(0xf7f)
    sw x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x00000180)

    # Testcase 52:  rs1:x10(0xfffffdff), imm:0xfbf, result rd:x22(0x00000240)
    li x10, MASK_XLEN(0xfffffdff)
    xori x22, x10, SEXT_IMM(0xfbf)
    sw x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x00000240)

    # Testcase 53:  rs1:x9(0xfffffbff), imm:0xfdf, result rd:x23(0x00000420)
    li x9, MASK_XLEN(0xfffffbff)
    xori x23, x9, SEXT_IMM(0xfdf)
    sw x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x00000420)

    # Testcase 54:  rs1:x8(0xfffff7ff), imm:0xfef, result rd:x24(0x00000810)
    li x8, MASK_XLEN(0xfffff7ff)
    xori x24, x8, SEXT_IMM(0xfef)
    sw x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x00000810)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rs1:x7(0xffffefff), imm:0xff7, result rd:x25(0x00001008)
    li x7, MASK_XLEN(0xffffefff)
    xori x25, x7, SEXT_IMM(0xff7)
    sw x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x00001008)

    # Testcase 56:  rs1:x6(0xffffdfff), imm:0xffb, result rd:x26(0x00002004)
    li x6, MASK_XLEN(0xffffdfff)
    xori x26, x6, SEXT_IMM(0xffb)
    sw x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x00002004)

    # Testcase 57:  rs1:x5(0xffffbfff), imm:0xffd, result rd:x27(0x00004002)
    li x5, MASK_XLEN(0xffffbfff)
    xori x27, x5, SEXT_IMM(0xffd)
    sw x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x00004002)

    # Testcase 58:  rs1:x4(0xffff7fff), imm:0xffe, result rd:x28(0x00008001)
    li x4, MASK_XLEN(0xffff7fff)
    xori x28, x4, SEXT_IMM(0xffe)
    sw x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x00008001)

    # Testcase 59:  rs1:x3(0xfffeffff), imm:0x0, result rd:x29(0xfffeffff)
    li x3, MASK_XLEN(0xfffeffff)
    xori x29, x3, SEXT_IMM(0x0)
    sw x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xfffeffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res


    # Testcase 60:  rs1:x2(0xfffdffff), imm:0x800, result rd:x30(0x000207ff)
    li x2, MASK_XLEN(0xfffdffff)
    xori x30, x2, SEXT_IMM(0x800)
    sw x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x000207ff)

    # Testcase 61:  rs1:x1(0xfffbffff), imm:0x400, result rd:x31(0xfffbfbff)
    li x1, MASK_XLEN(0xfffbffff)
    xori x31, x1, SEXT_IMM(0x400)
    sw x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xfffbfbff)

    # Testcase 62:  rs1:x31(0xfff7ffff), imm:0x200, result rd:x1(0xfff7fdff)
    li x31, MASK_XLEN(0xfff7ffff)
    xori x1, x31, SEXT_IMM(0x200)
    sw x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xfff7fdff)

    # Testcase 63:  rs1:x30(0xffefffff), imm:0x100, result rd:x2(0xffeffeff)
    li x30, MASK_XLEN(0xffefffff)
    xori x2, x30, SEXT_IMM(0x100)
    sw x2, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffeffeff)

    # Testcase 64:  rs1:x29(0xffdfffff), imm:0x80, result rd:x3(0xffdfff7f)
    li x29, MASK_XLEN(0xffdfffff)
    xori x3, x29, SEXT_IMM(0x80)
    sw x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xffdfff7f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rs1:x28(0xffbfffff), imm:0x40, result rd:x4(0xffbfffbf)
    li x28, MASK_XLEN(0xffbfffff)
    xori x4, x28, SEXT_IMM(0x40)
    sw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xffbfffbf)

    # Testcase 66:  rs1:x27(0xff7fffff), imm:0x0, result rd:x5(0xff7fffff)
    li x27, MASK_XLEN(0xff7fffff)
    xori x5, x27, SEXT_IMM(0x0)
    sw x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xff7fffff)

    # Testcase 67:  rs1:x26(0xfeffffff), imm:0x0, result rd:x6(0xfeffffff)
    li x26, MASK_XLEN(0xfeffffff)
    xori x6, x26, SEXT_IMM(0x0)
    sw x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfeffffff)

    # Testcase 68:  rs1:x25(0xfdffffff), imm:0x0, result rd:x7(0xfdffffff)
    li x25, MASK_XLEN(0xfdffffff)
    xori x7, x25, SEXT_IMM(0x0)
    sw x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfdffffff)

    # Testcase 69:  rs1:x24(0xfbffffff), imm:0x0, result rd:x8(0xfbffffff)
    li x24, MASK_XLEN(0xfbffffff)
    xori x8, x24, SEXT_IMM(0x0)
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfbffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rs1:x23(0xf7ffffff), imm:0x0, result rd:x9(0xf7ffffff)
    li x23, MASK_XLEN(0xf7ffffff)
    xori x9, x23, SEXT_IMM(0x0)
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xf7ffffff)

    # Testcase 71:  rs1:x22(0xefffffff), imm:0x0, result rd:x10(0xefffffff)
    li x22, MASK_XLEN(0xefffffff)
    xori x10, x22, SEXT_IMM(0x0)
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xefffffff)

    # Testcase 72:  rs1:x21(0xdfffffff), imm:0x0, result rd:x11(0xdfffffff)
    li x21, MASK_XLEN(0xdfffffff)
    xori x11, x21, SEXT_IMM(0x0)
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xdfffffff)

    # Testcase 73:  rs1:x20(0xbfffffff), imm:0x0, result rd:x12(0xbfffffff)
    li x20, MASK_XLEN(0xbfffffff)
    xori x12, x20, SEXT_IMM(0x0)
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xbfffffff)

    # Testcase 74:  rs1:x19(0x7fffffff), imm:0x0, result rd:x13(0x7fffffff)
    li x19, MASK_XLEN(0x7fffffff)
    xori x13, x19, SEXT_IMM(0x0)
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7fffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res


    # Testcase 75:  rs1:x18(0xffffffff), imm:0x0, result rd:x14(0xffffffff)
    li x18, MASK_XLEN(0xffffffff)
    xori x14, x18, SEXT_IMM(0x0)
    sw x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xffffffff)

    # Testcase 76:  rs1:x17(0x00000001), imm:0x0, result rd:x15(0x00000001)
    li x17, MASK_XLEN(0x1)
    xori x15, x17, SEXT_IMM(0x0)
    sw x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x00000001)

    # Testcase 77:  rs1:x16(0x00000002), imm:0x0, result rd:x16(0x00000002)
    li x16, MASK_XLEN(0x2)
    xori x16, x16, SEXT_IMM(0x0)
    sw x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x00000002)

    # Testcase 78:  rs1:x15(0x00000004), imm:0x0, result rd:x17(0x00000004)
    li x15, MASK_XLEN(0x4)
    xori x17, x15, SEXT_IMM(0x0)
    sw x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x00000004)

    # Testcase 79:  rs1:x14(0x00000008), imm:0x0, result rd:x18(0x00000008)
    li x14, MASK_XLEN(0x8)
    xori x18, x14, SEXT_IMM(0x0)
    sw x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x00000008)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rs1:x13(0x00000010), imm:0x0, result rd:x19(0x00000010)
    li x13, MASK_XLEN(0x10)
    xori x19, x13, SEXT_IMM(0x0)
    sw x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x00000010)

    # Testcase 81:  rs1:x12(0x00000020), imm:0x0, result rd:x20(0x00000020)
    li x12, MASK_XLEN(0x20)
    xori x20, x12, SEXT_IMM(0x0)
    sw x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x00000020)

    # Testcase 82:  rs1:x11(0x00000040), imm:0x0, result rd:x21(0x00000040)
    li x11, MASK_XLEN(0x40)
    xori x21, x11, SEXT_IMM(0x0)
    sw x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x00000040)

    # Testcase 83:  rs1:x10(0x00000080), imm:0x0, result rd:x22(0x00000080)
    li x10, MASK_XLEN(0x80)
    xori x22, x10, SEXT_IMM(0x0)
    sw x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x00000080)

    # Testcase 84:  rs1:x9(0x00000100), imm:0x0, result rd:x23(0x00000100)
    li x9, MASK_XLEN(0x100)
    xori x23, x9, SEXT_IMM(0x0)
    sw x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x00000100)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rs1:x8(0x00000200), imm:0x0, result rd:x24(0x00000200)
    li x8, MASK_XLEN(0x200)
    xori x24, x8, SEXT_IMM(0x0)
    sw x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x00000200)

    # Testcase 86:  rs1:x7(0x00000400), imm:0x0, result rd:x25(0x00000400)
    li x7, MASK_XLEN(0x400)
    xori x25, x7, SEXT_IMM(0x0)
    sw x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x00000400)

    # Testcase 87:  rs1:x6(0x00000800), imm:0x0, result rd:x26(0x00000800)
    li x6, MASK_XLEN(0x800)
    xori x26, x6, SEXT_IMM(0x0)
    sw x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x00000800)

    # Testcase 88:  rs1:x5(0x00001000), imm:0x0, result rd:x27(0x00001000)
    li x5, MASK_XLEN(0x1000)
    xori x27, x5, SEXT_IMM(0x0)
    sw x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x00001000)

    # Testcase 89:  rs1:x4(0x00002000), imm:0x0, result rd:x28(0x00002000)
    li x4, MASK_XLEN(0x2000)
    xori x28, x4, SEXT_IMM(0x0)
    sw x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x00002000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res


    # Testcase 90:  rs1:x3(0x00004000), imm:0x0, result rd:x29(0x00004000)
    li x3, MASK_XLEN(0x4000)
    xori x29, x3, SEXT_IMM(0x0)
    sw x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x00004000)

    # Testcase 91:  rs1:x2(0x00008000), imm:0x0, result rd:x30(0x00008000)
    li x2, MASK_XLEN(0x8000)
    xori x30, x2, SEXT_IMM(0x0)
    sw x30, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x00008000)

    # Testcase 92:  rs1:x1(0x00010000), imm:0x0, result rd:x31(0x00010000)
    li x1, MASK_XLEN(0x10000)
    xori x31, x1, SEXT_IMM(0x0)
    sw x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x00010000)

    # Testcase 93:  rs1:x31(0x00020000), imm:0x0, result rd:x1(0x00020000)
    li x31, MASK_XLEN(0x20000)
    xori x1, x31, SEXT_IMM(0x0)
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x00020000)

    # Testcase 94:  rs1:x30(0x00040000), imm:0x0, result rd:x2(0x00040000)
    li x30, MASK_XLEN(0x40000)
    xori x2, x30, SEXT_IMM(0x0)
    sw x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x00040000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rs1:x29(0x00080000), imm:0x0, result rd:x3(0x00080000)
    li x29, MASK_XLEN(0x80000)
    xori x3, x29, SEXT_IMM(0x0)
    sw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00080000)

    # Testcase 96:  rs1:x28(0x00100000), imm:0x0, result rd:x4(0x00100000)
    li x28, MASK_XLEN(0x100000)
    xori x4, x28, SEXT_IMM(0x0)
    sw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x00100000)

    # Testcase 97:  rs1:x27(0x00200000), imm:0x0, result rd:x5(0x00200000)
    li x27, MASK_XLEN(0x200000)
    xori x5, x27, SEXT_IMM(0x0)
    sw x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x00200000)

    # Testcase 98:  rs1:x26(0x00400000), imm:0x0, result rd:x6(0x00400000)
    li x26, MASK_XLEN(0x400000)
    xori x6, x26, SEXT_IMM(0x0)
    sw x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x00400000)

    # Testcase 99:  rs1:x25(0x00800000), imm:0x0, result rd:x7(0x00800000)
    li x25, MASK_XLEN(0x800000)
    xori x7, x25, SEXT_IMM(0x0)
    sw x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x00800000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rs1:x24(0x01000000), imm:0x0, result rd:x8(0x01000000)
    li x24, MASK_XLEN(0x1000000)
    xori x8, x24, SEXT_IMM(0x0)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x01000000)

    # Testcase 101:  rs1:x23(0x02000000), imm:0x0, result rd:x9(0x02000000)
    li x23, MASK_XLEN(0x2000000)
    xori x9, x23, SEXT_IMM(0x0)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x02000000)

    # Testcase 102:  rs1:x22(0x04000000), imm:0x0, result rd:x10(0x04000000)
    li x22, MASK_XLEN(0x4000000)
    xori x10, x22, SEXT_IMM(0x0)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x04000000)

    # Testcase 103:  rs1:x21(0x08000000), imm:0x0, result rd:x11(0x08000000)
    li x21, MASK_XLEN(0x8000000)
    xori x11, x21, SEXT_IMM(0x0)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x08000000)

    # Testcase 104:  rs1:x20(0x10000000), imm:0x0, result rd:x12(0x10000000)
    li x20, MASK_XLEN(0x10000000)
    xori x12, x20, SEXT_IMM(0x0)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x10000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res


    # Testcase 105:  rs1:x19(0x20000000), imm:0x0, result rd:x13(0x20000000)
    li x19, MASK_XLEN(0x20000000)
    xori x13, x19, SEXT_IMM(0x0)
    sw x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x20000000)

    # Testcase 106:  rs1:x18(0x40000000), imm:0x0, result rd:x14(0x40000000)
    li x18, MASK_XLEN(0x40000000)
    xori x14, x18, SEXT_IMM(0x0)
    sw x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x40000000)

    # Testcase 107:  rs1:x17(0x80000000), imm:0x0, result rd:x15(0x80000000)
    li x17, MASK_XLEN(0x80000000)
    xori x15, x17, SEXT_IMM(0x0)
    sw x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x80000000)

    # Testcase 108:  rs1:x16(0x00000000), imm:0x0, result rd:x16(0x00000000)
    li x16, MASK_XLEN(0x0)
    xori x16, x16, SEXT_IMM(0x0)
    sw x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x00000000)

    # Testcase 109:  rs1:x15(0xfffffffe), imm:0x0, result rd:x17(0xfffffffe)
    li x15, MASK_XLEN(0xfffffffe)
    xori x17, x15, SEXT_IMM(0x0)
    sw x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xfffffffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rs1:x14(0xfffffffd), imm:0x0, result rd:x18(0xfffffffd)
    li x14, MASK_XLEN(0xfffffffd)
    xori x18, x14, SEXT_IMM(0x0)
    sw x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0xfffffffd)

    # Testcase 111:  rs1:x13(0xfffffffb), imm:0x0, result rd:x19(0xfffffffb)
    li x13, MASK_XLEN(0xfffffffb)
    xori x19, x13, SEXT_IMM(0x0)
    sw x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xfffffffb)

    # Testcase 112:  rs1:x12(0xfffffff7), imm:0x0, result rd:x20(0xfffffff7)
    li x12, MASK_XLEN(0xfffffff7)
    xori x20, x12, SEXT_IMM(0x0)
    sw x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffffff7)

    # Testcase 113:  rs1:x11(0xffffffef), imm:0x0, result rd:x21(0xffffffef)
    li x11, MASK_XLEN(0xffffffef)
    xori x21, x11, SEXT_IMM(0x0)
    sw x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffffef)

    # Testcase 114:  rs1:x10(0xffffffdf), imm:0x0, result rd:x22(0xffffffdf)
    li x10, MASK_XLEN(0xffffffdf)
    xori x22, x10, SEXT_IMM(0x0)
    sw x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffffffdf)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rs1:x9(0xffffffbf), imm:0x0, result rd:x23(0xffffffbf)
    li x9, MASK_XLEN(0xffffffbf)
    xori x23, x9, SEXT_IMM(0x0)
    sw x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffffbf)

    # Testcase 116:  rs1:x8(0xffffff7f), imm:0x0, result rd:x24(0xffffff7f)
    li x8, MASK_XLEN(0xffffff7f)
    xori x24, x8, SEXT_IMM(0x0)
    sw x24, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffffff7f)

    # Testcase 117:  rs1:x7(0xfffffeff), imm:0x0, result rd:x25(0xfffffeff)
    li x7, MASK_XLEN(0xfffffeff)
    xori x25, x7, SEXT_IMM(0x0)
    sw x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffeff)

    # Testcase 118:  rs1:x6(0xfffffdff), imm:0x0, result rd:x26(0xfffffdff)
    li x6, MASK_XLEN(0xfffffdff)
    xori x26, x6, SEXT_IMM(0x0)
    sw x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xfffffdff)

    # Testcase 119:  rs1:x5(0xfffffbff), imm:0x0, result rd:x27(0xfffffbff)
    li x5, MASK_XLEN(0xfffffbff)
    xori x27, x5, SEXT_IMM(0x0)
    sw x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfffffbff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res


    # Testcase 120:  rs1:x4(0xfffff7ff), imm:0x0, result rd:x28(0xfffff7ff)
    li x4, MASK_XLEN(0xfffff7ff)
    xori x28, x4, SEXT_IMM(0x0)
    sw x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0xfffff7ff)

    # Testcase 121:  rs1:x3(0xffffefff), imm:0x0, result rd:x29(0xffffefff)
    li x3, MASK_XLEN(0xffffefff)
    xori x29, x3, SEXT_IMM(0x0)
    sw x29, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0xffffefff)

    # Testcase 122:  rs1:x2(0xffffdfff), imm:0x0, result rd:x30(0xffffdfff)
    li x2, MASK_XLEN(0xffffdfff)
    xori x30, x2, SEXT_IMM(0x0)
    sw x30, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0xffffdfff)

    # Testcase 123:  rs1:x1(0xffffbfff), imm:0x0, result rd:x31(0xffffbfff)
    li x1, MASK_XLEN(0xffffbfff)
    xori x31, x1, SEXT_IMM(0x0)
    sw x31, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xffffbfff)

    # Testcase 124:  rs1:x31(0xffff7fff), imm:0x0, result rd:x1(0xffff7fff)
    li x31, MASK_XLEN(0xffff7fff)
    xori x1, x31, SEXT_IMM(0x0)
    sw x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xffff7fff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rs1:x30(0xfffeffff), imm:0x0, result rd:x2(0xfffeffff)
    li x30, MASK_XLEN(0xfffeffff)
    xori x2, x30, SEXT_IMM(0x0)
    sw x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xfffeffff)

    # Testcase 126:  rs1:x29(0xfffdffff), imm:0x0, result rd:x3(0xfffdffff)
    li x29, MASK_XLEN(0xfffdffff)
    xori x3, x29, SEXT_IMM(0x0)
    sw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xfffdffff)

    # Testcase 127:  rs1:x28(0xfffbffff), imm:0x0, result rd:x4(0xfffbffff)
    li x28, MASK_XLEN(0xfffbffff)
    xori x4, x28, SEXT_IMM(0x0)
    sw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xfffbffff)

    # Testcase 128:  rs1:x27(0xfff7ffff), imm:0x0, result rd:x5(0xfff7ffff)
    li x27, MASK_XLEN(0xfff7ffff)
    xori x5, x27, SEXT_IMM(0x0)
    sw x5, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xfff7ffff)

    # Testcase 129:  rs1:x26(0xffefffff), imm:0x0, result rd:x6(0xffefffff)
    li x26, MASK_XLEN(0xffefffff)
    xori x6, x26, SEXT_IMM(0x0)
    sw x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0xffefffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rs1:x25(0xffdfffff), imm:0x0, result rd:x7(0xffdfffff)
    li x25, MASK_XLEN(0xffdfffff)
    xori x7, x25, SEXT_IMM(0x0)
    sw x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffdfffff)

    # Testcase 131:  rs1:x24(0xffbfffff), imm:0x0, result rd:x8(0xffbfffff)
    li x24, MASK_XLEN(0xffbfffff)
    xori x8, x24, SEXT_IMM(0x0)
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffbfffff)

    # Testcase 132:  rs1:x23(0xff7fffff), imm:0x800, result rd:x9(0x008007ff)
    li x23, MASK_XLEN(0xff7fffff)
    xori x9, x23, SEXT_IMM(0x800)
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x008007ff)

    # Testcase 133:  rs1:x22(0xfeffffff), imm:0x400, result rd:x10(0xfefffbff)
    li x22, MASK_XLEN(0xfeffffff)
    xori x10, x22, SEXT_IMM(0x400)
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfefffbff)

    # Testcase 134:  rs1:x21(0xfdffffff), imm:0x200, result rd:x11(0xfdfffdff)
    li x21, MASK_XLEN(0xfdffffff)
    xori x11, x21, SEXT_IMM(0x200)
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfdfffdff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res


    # Testcase 135:  rs1:x20(0xfbffffff), imm:0x100, result rd:x12(0xfbfffeff)
    li x20, MASK_XLEN(0xfbffffff)
    xori x12, x20, SEXT_IMM(0x100)
    sw x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0xfbfffeff)

    # Testcase 136:  rs1:x19(0xf7ffffff), imm:0x80, result rd:x13(0xf7ffff7f)
    li x19, MASK_XLEN(0xf7ffffff)
    xori x13, x19, SEXT_IMM(0x80)
    sw x13, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0xf7ffff7f)

    # Testcase 137:  rs1:x18(0xefffffff), imm:0x40, result rd:x14(0xefffffbf)
    li x18, MASK_XLEN(0xefffffff)
    xori x14, x18, SEXT_IMM(0x40)
    sw x14, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xefffffbf)

    # Testcase 138:  rs1:x17(0xdfffffff), imm:0x20, result rd:x15(0xdfffffdf)
    li x17, MASK_XLEN(0xdfffffff)
    xori x15, x17, SEXT_IMM(0x20)
    sw x15, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0xdfffffdf)

    # Testcase 139:  rs1:x16(0xbfffffff), imm:0x10, result rd:x16(0xbfffffef)
    li x16, MASK_XLEN(0xbfffffff)
    xori x16, x16, SEXT_IMM(0x10)
    sw x16, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0xbfffffef)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res


    # Testcase 140:  rs1:x15(0x7fffffff), imm:0x8, result rd:x17(0x7ffffff7)
    li x15, MASK_XLEN(0x7fffffff)
    xori x17, x15, SEXT_IMM(0x8)
    sw x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x17, 0x7ffffff7)

    # Testcase 141:  rs1:x14(0xffffffff), imm:0x4, result rd:x18(0xfffffffb)
    li x14, MASK_XLEN(0xffffffff)
    xori x18, x14, SEXT_IMM(0x4)
    sw x18, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0xfffffffb)

    # Testcase 142:  rs1:x13(0x10fd3dedadea5195), imm:0x2, result rd:x19(0xadea5197)
    li x13, MASK_XLEN(0x10fd3dedadea5195)
    xori x19, x13, SEXT_IMM(0x2)
    sw x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xadea5197)

    # Testcase 143:  rs1:x12(0xbd295ce2d2ffbec1), imm:0x1, result rd:x0(0x00000000)
    li x12, MASK_XLEN(0xbd295ce2d2ffbec1)
    xori x0, x12, SEXT_IMM(0x1)
    sw x0, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x0, 0x00000000)

    # Testcase 144:  rs1:x11(0xc9649f05a8e1a8bb), imm:0xc23, result rd:x21(0x571e5498)
    li x11, MASK_XLEN(0xc9649f05a8e1a8bb)
    xori x21, x11, SEXT_IMM(0xc23)
    sw x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x571e5498)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res


    # Testcase 145:  rs1:x0(0x3541291848c99fcb), imm:0x5b, result rd:x22(0x0000005b)
    li x0, MASK_XLEN(0x3541291848c99fcb)
    xori x22, x0, SEXT_IMM(0x5b)
    sw x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000005b)


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

