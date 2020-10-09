# RISC-V Compliance Test I-ANDI-01
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
# Description: Testing instruction 'ANDI'.

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


    # Testcase 0:  rs1:x31(0x00000001), imm:0xfff, result rd:x1(0x00000001)
    li x31, MASK_XLEN(0x1)
    andi x1, x31, SEXT_IMM(0xfff)
    sw x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x00000001)

    # Testcase 1:  rs1:x30(0x00000002), imm:0x7ff, result rd:x2(0x00000002)
    li x30, MASK_XLEN(0x2)
    andi x2, x30, SEXT_IMM(0x7ff)
    sw x2, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x00000002)

    # Testcase 2:  rs1:x29(0x00000004), imm:0xbff, result rd:x3(0x00000004)
    li x29, MASK_XLEN(0x4)
    andi x3, x29, SEXT_IMM(0xbff)
    sw x3, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x00000004)

    # Testcase 3:  rs1:x28(0x00000008), imm:0xdff, result rd:x4(0x00000008)
    li x28, MASK_XLEN(0x8)
    andi x4, x28, SEXT_IMM(0xdff)
    sw x4, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x00000008)

    # Testcase 4:  rs1:x27(0x00000010), imm:0xeff, result rd:x5(0x00000010)
    li x27, MASK_XLEN(0x10)
    andi x5, x27, SEXT_IMM(0xeff)
    sw x5, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x00000010)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rs1:x26(0x00000020), imm:0xf7f, result rd:x6(0x00000020)
    li x26, MASK_XLEN(0x20)
    andi x6, x26, SEXT_IMM(0xf7f)
    sw x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x00000020)

    # Testcase 6:  rs1:x25(0x00000040), imm:0xfbf, result rd:x7(0x00000000)
    li x25, MASK_XLEN(0x40)
    andi x7, x25, SEXT_IMM(0xfbf)
    sw x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x00000000)

    # Testcase 7:  rs1:x24(0x00000080), imm:0xfdf, result rd:x8(0x00000080)
    li x24, MASK_XLEN(0x80)
    andi x8, x24, SEXT_IMM(0xfdf)
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000080)

    # Testcase 8:  rs1:x23(0x00000100), imm:0xfef, result rd:x9(0x00000100)
    li x23, MASK_XLEN(0x100)
    andi x9, x23, SEXT_IMM(0xfef)
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x00000100)

    # Testcase 9:  rs1:x22(0x00000200), imm:0xff7, result rd:x10(0x00000200)
    li x22, MASK_XLEN(0x200)
    andi x10, x22, SEXT_IMM(0xff7)
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x00000200)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rs1:x21(0x00000400), imm:0xffb, result rd:x11(0x00000400)
    li x21, MASK_XLEN(0x400)
    andi x11, x21, SEXT_IMM(0xffb)
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x00000400)

    # Testcase 11:  rs1:x20(0x00000800), imm:0xffd, result rd:x12(0x00000800)
    li x20, MASK_XLEN(0x800)
    andi x12, x20, SEXT_IMM(0xffd)
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x00000800)

    # Testcase 12:  rs1:x19(0x00001000), imm:0xffe, result rd:x13(0x00001000)
    li x19, MASK_XLEN(0x1000)
    andi x13, x19, SEXT_IMM(0xffe)
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x00001000)

    # Testcase 13:  rs1:x18(0x00002000), imm:0x0, result rd:x14(0x00000000)
    li x18, MASK_XLEN(0x2000)
    andi x14, x18, SEXT_IMM(0x0)
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x00000000)

    # Testcase 14:  rs1:x17(0x00004000), imm:0x800, result rd:x15(0x00004000)
    li x17, MASK_XLEN(0x4000)
    andi x15, x17, SEXT_IMM(0x800)
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x00004000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res


    # Testcase 15:  rs1:x16(0x00008000), imm:0x400, result rd:x16(0x00000000)
    li x16, MASK_XLEN(0x8000)
    andi x16, x16, SEXT_IMM(0x400)
    sw x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x00000000)

    # Testcase 16:  rs1:x15(0x00010000), imm:0x200, result rd:x17(0x00000000)
    li x15, MASK_XLEN(0x10000)
    andi x17, x15, SEXT_IMM(0x200)
    sw x17, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x00000000)

    # Testcase 17:  rs1:x14(0x00020000), imm:0x100, result rd:x18(0x00000000)
    li x14, MASK_XLEN(0x20000)
    andi x18, x14, SEXT_IMM(0x100)
    sw x18, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x00000000)

    # Testcase 18:  rs1:x13(0x00040000), imm:0x80, result rd:x19(0x00000000)
    li x13, MASK_XLEN(0x40000)
    andi x19, x13, SEXT_IMM(0x80)
    sw x19, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x00000000)

    # Testcase 19:  rs1:x12(0x00080000), imm:0x40, result rd:x20(0x00000000)
    li x12, MASK_XLEN(0x80000)
    andi x20, x12, SEXT_IMM(0x40)
    sw x20, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rs1:x11(0x00100000), imm:0x20, result rd:x21(0x00000000)
    li x11, MASK_XLEN(0x100000)
    andi x21, x11, SEXT_IMM(0x20)
    sw x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x00000000)

    # Testcase 21:  rs1:x10(0x00200000), imm:0x10, result rd:x22(0x00000000)
    li x10, MASK_XLEN(0x200000)
    andi x22, x10, SEXT_IMM(0x10)
    sw x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x00000000)

    # Testcase 22:  rs1:x9(0x00400000), imm:0x8, result rd:x23(0x00000000)
    li x9, MASK_XLEN(0x400000)
    andi x23, x9, SEXT_IMM(0x8)
    sw x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x00000000)

    # Testcase 23:  rs1:x8(0x00800000), imm:0x4, result rd:x24(0x00000000)
    li x8, MASK_XLEN(0x800000)
    andi x24, x8, SEXT_IMM(0x4)
    sw x24, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x00000000)

    # Testcase 24:  rs1:x7(0x01000000), imm:0x2, result rd:x25(0x00000000)
    li x7, MASK_XLEN(0x1000000)
    andi x25, x7, SEXT_IMM(0x2)
    sw x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rs1:x6(0x02000000), imm:0x1, result rd:x26(0x00000000)
    li x6, MASK_XLEN(0x2000000)
    andi x26, x6, SEXT_IMM(0x1)
    sw x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x00000000)

    # Testcase 26:  rs1:x5(0x04000000), imm:0xfff, result rd:x27(0x04000000)
    li x5, MASK_XLEN(0x4000000)
    andi x27, x5, SEXT_IMM(0xfff)
    sw x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x04000000)

    # Testcase 27:  rs1:x4(0x08000000), imm:0x7ff, result rd:x28(0x00000000)
    li x4, MASK_XLEN(0x8000000)
    andi x28, x4, SEXT_IMM(0x7ff)
    sw x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x00000000)

    # Testcase 28:  rs1:x3(0x10000000), imm:0xbff, result rd:x29(0x10000000)
    li x3, MASK_XLEN(0x10000000)
    andi x29, x3, SEXT_IMM(0xbff)
    sw x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x10000000)

    # Testcase 29:  rs1:x2(0x20000000), imm:0xdff, result rd:x30(0x20000000)
    li x2, MASK_XLEN(0x20000000)
    andi x30, x2, SEXT_IMM(0xdff)
    sw x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x20000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res


    # Testcase 30:  rs1:x1(0x40000000), imm:0xeff, result rd:x31(0x40000000)
    li x1, MASK_XLEN(0x40000000)
    andi x31, x1, SEXT_IMM(0xeff)
    sw x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x40000000)

    # Testcase 31:  rs1:x31(0x80000000), imm:0xf7f, result rd:x1(0x80000000)
    li x31, MASK_XLEN(0x80000000)
    andi x1, x31, SEXT_IMM(0xf7f)
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x80000000)

    # Testcase 32:  rs1:x30(0x00000000), imm:0xfbf, result rd:x2(0x00000000)
    li x30, MASK_XLEN(0x0)
    andi x2, x30, SEXT_IMM(0xfbf)
    sw x2, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x00000000)

    # Testcase 33:  rs1:x29(0xfffffffe), imm:0xfdf, result rd:x3(0xffffffde)
    li x29, MASK_XLEN(0xfffffffe)
    andi x3, x29, SEXT_IMM(0xfdf)
    sw x3, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0xffffffde)

    # Testcase 34:  rs1:x28(0xfffffffd), imm:0xfef, result rd:x4(0xffffffed)
    li x28, MASK_XLEN(0xfffffffd)
    andi x4, x28, SEXT_IMM(0xfef)
    sw x4, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0xffffffed)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rs1:x27(0xfffffffb), imm:0xff7, result rd:x5(0xfffffff3)
    li x27, MASK_XLEN(0xfffffffb)
    andi x5, x27, SEXT_IMM(0xff7)
    sw x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffff3)

    # Testcase 36:  rs1:x26(0xfffffff7), imm:0xffb, result rd:x6(0xfffffff3)
    li x26, MASK_XLEN(0xfffffff7)
    andi x6, x26, SEXT_IMM(0xffb)
    sw x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfffffff3)

    # Testcase 37:  rs1:x25(0xffffffef), imm:0xffd, result rd:x7(0xffffffed)
    li x25, MASK_XLEN(0xffffffef)
    andi x7, x25, SEXT_IMM(0xffd)
    sw x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffed)

    # Testcase 38:  rs1:x24(0xffffffdf), imm:0xffe, result rd:x8(0xffffffde)
    li x24, MASK_XLEN(0xffffffdf)
    andi x8, x24, SEXT_IMM(0xffe)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffde)

    # Testcase 39:  rs1:x23(0xffffffbf), imm:0x0, result rd:x9(0x00000000)
    li x23, MASK_XLEN(0xffffffbf)
    andi x9, x23, SEXT_IMM(0x0)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rs1:x22(0xffffff7f), imm:0x800, result rd:x10(0xfffff800)
    li x22, MASK_XLEN(0xffffff7f)
    andi x10, x22, SEXT_IMM(0x800)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffff800)

    # Testcase 41:  rs1:x21(0xfffffeff), imm:0x400, result rd:x11(0x00000400)
    li x21, MASK_XLEN(0xfffffeff)
    andi x11, x21, SEXT_IMM(0x400)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x00000400)

    # Testcase 42:  rs1:x20(0xfffffdff), imm:0x200, result rd:x12(0x00000000)
    li x20, MASK_XLEN(0xfffffdff)
    andi x12, x20, SEXT_IMM(0x200)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x00000000)

    # Testcase 43:  rs1:x19(0xfffffbff), imm:0x100, result rd:x13(0x00000100)
    li x19, MASK_XLEN(0xfffffbff)
    andi x13, x19, SEXT_IMM(0x100)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x00000100)

    # Testcase 44:  rs1:x18(0xfffff7ff), imm:0x80, result rd:x14(0x00000080)
    li x18, MASK_XLEN(0xfffff7ff)
    andi x14, x18, SEXT_IMM(0x80)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x00000080)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res


    # Testcase 45:  rs1:x17(0xffffefff), imm:0x40, result rd:x15(0x00000040)
    li x17, MASK_XLEN(0xffffefff)
    andi x15, x17, SEXT_IMM(0x40)
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x00000040)

    # Testcase 46:  rs1:x16(0xffffdfff), imm:0x20, result rd:x16(0x00000020)
    li x16, MASK_XLEN(0xffffdfff)
    andi x16, x16, SEXT_IMM(0x20)
    sw x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x00000020)

    # Testcase 47:  rs1:x15(0xffffbfff), imm:0x10, result rd:x17(0x00000010)
    li x15, MASK_XLEN(0xffffbfff)
    andi x17, x15, SEXT_IMM(0x10)
    sw x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x00000010)

    # Testcase 48:  rs1:x14(0xffff7fff), imm:0x8, result rd:x18(0x00000008)
    li x14, MASK_XLEN(0xffff7fff)
    andi x18, x14, SEXT_IMM(0x8)
    sw x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x00000008)

    # Testcase 49:  rs1:x13(0xfffeffff), imm:0x4, result rd:x19(0x00000004)
    li x13, MASK_XLEN(0xfffeffff)
    andi x19, x13, SEXT_IMM(0x4)
    sw x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x00000004)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rs1:x12(0xfffdffff), imm:0x2, result rd:x20(0x00000002)
    li x12, MASK_XLEN(0xfffdffff)
    andi x20, x12, SEXT_IMM(0x2)
    sw x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x00000002)

    # Testcase 51:  rs1:x11(0xfffbffff), imm:0x1, result rd:x21(0x00000001)
    li x11, MASK_XLEN(0xfffbffff)
    andi x21, x11, SEXT_IMM(0x1)
    sw x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x00000001)

    # Testcase 52:  rs1:x10(0xfff7ffff), imm:0xfff, result rd:x22(0xfff7ffff)
    li x10, MASK_XLEN(0xfff7ffff)
    andi x22, x10, SEXT_IMM(0xfff)
    sw x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfff7ffff)

    # Testcase 53:  rs1:x9(0xffefffff), imm:0x7ff, result rd:x23(0x000007ff)
    li x9, MASK_XLEN(0xffefffff)
    andi x23, x9, SEXT_IMM(0x7ff)
    sw x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x000007ff)

    # Testcase 54:  rs1:x8(0xffdfffff), imm:0xbff, result rd:x24(0xffdffbff)
    li x8, MASK_XLEN(0xffdfffff)
    andi x24, x8, SEXT_IMM(0xbff)
    sw x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffdffbff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rs1:x7(0xffbfffff), imm:0xdff, result rd:x25(0xffbffdff)
    li x7, MASK_XLEN(0xffbfffff)
    andi x25, x7, SEXT_IMM(0xdff)
    sw x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffbffdff)

    # Testcase 56:  rs1:x6(0xff7fffff), imm:0xeff, result rd:x26(0xff7ffeff)
    li x6, MASK_XLEN(0xff7fffff)
    andi x26, x6, SEXT_IMM(0xeff)
    sw x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xff7ffeff)

    # Testcase 57:  rs1:x5(0xfeffffff), imm:0xf7f, result rd:x27(0xfeffff7f)
    li x5, MASK_XLEN(0xfeffffff)
    andi x27, x5, SEXT_IMM(0xf7f)
    sw x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfeffff7f)

    # Testcase 58:  rs1:x4(0xfdffffff), imm:0xfbf, result rd:x28(0xfdffffbf)
    li x4, MASK_XLEN(0xfdffffff)
    andi x28, x4, SEXT_IMM(0xfbf)
    sw x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfdffffbf)

    # Testcase 59:  rs1:x3(0xfbffffff), imm:0xfdf, result rd:x29(0xfbffffdf)
    li x3, MASK_XLEN(0xfbffffff)
    andi x29, x3, SEXT_IMM(0xfdf)
    sw x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xfbffffdf)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res


    # Testcase 60:  rs1:x2(0xf7ffffff), imm:0xfef, result rd:x30(0xf7ffffef)
    li x2, MASK_XLEN(0xf7ffffff)
    andi x30, x2, SEXT_IMM(0xfef)
    sw x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xf7ffffef)

    # Testcase 61:  rs1:x1(0xefffffff), imm:0xff7, result rd:x31(0xeffffff7)
    li x1, MASK_XLEN(0xefffffff)
    andi x31, x1, SEXT_IMM(0xff7)
    sw x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xeffffff7)

    # Testcase 62:  rs1:x31(0xdfffffff), imm:0xffb, result rd:x1(0xdffffffb)
    li x31, MASK_XLEN(0xdfffffff)
    andi x1, x31, SEXT_IMM(0xffb)
    sw x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xdffffffb)

    # Testcase 63:  rs1:x30(0xbfffffff), imm:0xffd, result rd:x2(0xbffffffd)
    li x30, MASK_XLEN(0xbfffffff)
    andi x2, x30, SEXT_IMM(0xffd)
    sw x2, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xbffffffd)

    # Testcase 64:  rs1:x29(0x7fffffff), imm:0xffe, result rd:x3(0x7ffffffe)
    li x29, MASK_XLEN(0x7fffffff)
    andi x3, x29, SEXT_IMM(0xffe)
    sw x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x7ffffffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rs1:x28(0xffffffff), imm:0x0, result rd:x4(0x00000000)
    li x28, MASK_XLEN(0xffffffff)
    andi x4, x28, SEXT_IMM(0x0)
    sw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x00000000)

    # Testcase 66:  rs1:x27(0x00000001), imm:0xfff, result rd:x5(0x00000001)
    li x27, MASK_XLEN(0x1)
    andi x5, x27, SEXT_IMM(0xfff)
    sw x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x00000001)

    # Testcase 67:  rs1:x26(0x00000002), imm:0xfff, result rd:x6(0x00000002)
    li x26, MASK_XLEN(0x2)
    andi x6, x26, SEXT_IMM(0xfff)
    sw x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x00000002)

    # Testcase 68:  rs1:x25(0x00000004), imm:0xfff, result rd:x7(0x00000004)
    li x25, MASK_XLEN(0x4)
    andi x7, x25, SEXT_IMM(0xfff)
    sw x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x00000004)

    # Testcase 69:  rs1:x24(0x00000008), imm:0xfff, result rd:x8(0x00000008)
    li x24, MASK_XLEN(0x8)
    andi x8, x24, SEXT_IMM(0xfff)
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000008)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rs1:x23(0x00000010), imm:0xfff, result rd:x9(0x00000010)
    li x23, MASK_XLEN(0x10)
    andi x9, x23, SEXT_IMM(0xfff)
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x00000010)

    # Testcase 71:  rs1:x22(0x00000020), imm:0xfff, result rd:x10(0x00000020)
    li x22, MASK_XLEN(0x20)
    andi x10, x22, SEXT_IMM(0xfff)
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x00000020)

    # Testcase 72:  rs1:x21(0x00000040), imm:0xfff, result rd:x11(0x00000040)
    li x21, MASK_XLEN(0x40)
    andi x11, x21, SEXT_IMM(0xfff)
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x00000040)

    # Testcase 73:  rs1:x20(0x00000080), imm:0xfff, result rd:x12(0x00000080)
    li x20, MASK_XLEN(0x80)
    andi x12, x20, SEXT_IMM(0xfff)
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x00000080)

    # Testcase 74:  rs1:x19(0x00000100), imm:0xfff, result rd:x13(0x00000100)
    li x19, MASK_XLEN(0x100)
    andi x13, x19, SEXT_IMM(0xfff)
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x00000100)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res


    # Testcase 75:  rs1:x18(0x00000200), imm:0xfff, result rd:x14(0x00000200)
    li x18, MASK_XLEN(0x200)
    andi x14, x18, SEXT_IMM(0xfff)
    sw x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x00000200)

    # Testcase 76:  rs1:x17(0x00000400), imm:0xfff, result rd:x15(0x00000400)
    li x17, MASK_XLEN(0x400)
    andi x15, x17, SEXT_IMM(0xfff)
    sw x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x00000400)

    # Testcase 77:  rs1:x16(0x00000800), imm:0xfff, result rd:x16(0x00000800)
    li x16, MASK_XLEN(0x800)
    andi x16, x16, SEXT_IMM(0xfff)
    sw x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x00000800)

    # Testcase 78:  rs1:x15(0x00001000), imm:0xfff, result rd:x17(0x00001000)
    li x15, MASK_XLEN(0x1000)
    andi x17, x15, SEXT_IMM(0xfff)
    sw x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x00001000)

    # Testcase 79:  rs1:x14(0x00002000), imm:0xfff, result rd:x18(0x00002000)
    li x14, MASK_XLEN(0x2000)
    andi x18, x14, SEXT_IMM(0xfff)
    sw x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x00002000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rs1:x13(0x00004000), imm:0xfff, result rd:x19(0x00004000)
    li x13, MASK_XLEN(0x4000)
    andi x19, x13, SEXT_IMM(0xfff)
    sw x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x00004000)

    # Testcase 81:  rs1:x12(0x00008000), imm:0xfff, result rd:x20(0x00008000)
    li x12, MASK_XLEN(0x8000)
    andi x20, x12, SEXT_IMM(0xfff)
    sw x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x00008000)

    # Testcase 82:  rs1:x11(0x00010000), imm:0xfff, result rd:x21(0x00010000)
    li x11, MASK_XLEN(0x10000)
    andi x21, x11, SEXT_IMM(0xfff)
    sw x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x00010000)

    # Testcase 83:  rs1:x10(0x00020000), imm:0xfff, result rd:x22(0x00020000)
    li x10, MASK_XLEN(0x20000)
    andi x22, x10, SEXT_IMM(0xfff)
    sw x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x00020000)

    # Testcase 84:  rs1:x9(0x00040000), imm:0xfff, result rd:x23(0x00040000)
    li x9, MASK_XLEN(0x40000)
    andi x23, x9, SEXT_IMM(0xfff)
    sw x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x00040000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rs1:x8(0x00080000), imm:0xfff, result rd:x24(0x00080000)
    li x8, MASK_XLEN(0x80000)
    andi x24, x8, SEXT_IMM(0xfff)
    sw x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x00080000)

    # Testcase 86:  rs1:x7(0x00100000), imm:0xfff, result rd:x25(0x00100000)
    li x7, MASK_XLEN(0x100000)
    andi x25, x7, SEXT_IMM(0xfff)
    sw x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x00100000)

    # Testcase 87:  rs1:x6(0x00200000), imm:0xfff, result rd:x26(0x00200000)
    li x6, MASK_XLEN(0x200000)
    andi x26, x6, SEXT_IMM(0xfff)
    sw x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x00200000)

    # Testcase 88:  rs1:x5(0x00400000), imm:0xfff, result rd:x27(0x00400000)
    li x5, MASK_XLEN(0x400000)
    andi x27, x5, SEXT_IMM(0xfff)
    sw x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x00400000)

    # Testcase 89:  rs1:x4(0x00800000), imm:0xfff, result rd:x28(0x00800000)
    li x4, MASK_XLEN(0x800000)
    andi x28, x4, SEXT_IMM(0xfff)
    sw x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x00800000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res


    # Testcase 90:  rs1:x3(0x01000000), imm:0xfff, result rd:x29(0x01000000)
    li x3, MASK_XLEN(0x1000000)
    andi x29, x3, SEXT_IMM(0xfff)
    sw x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x01000000)

    # Testcase 91:  rs1:x2(0x02000000), imm:0xfff, result rd:x30(0x02000000)
    li x2, MASK_XLEN(0x2000000)
    andi x30, x2, SEXT_IMM(0xfff)
    sw x30, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x02000000)

    # Testcase 92:  rs1:x1(0x04000000), imm:0xfff, result rd:x31(0x04000000)
    li x1, MASK_XLEN(0x4000000)
    andi x31, x1, SEXT_IMM(0xfff)
    sw x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x04000000)

    # Testcase 93:  rs1:x31(0x08000000), imm:0xfff, result rd:x1(0x08000000)
    li x31, MASK_XLEN(0x8000000)
    andi x1, x31, SEXT_IMM(0xfff)
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x08000000)

    # Testcase 94:  rs1:x30(0x10000000), imm:0xfff, result rd:x2(0x10000000)
    li x30, MASK_XLEN(0x10000000)
    andi x2, x30, SEXT_IMM(0xfff)
    sw x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x10000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rs1:x29(0x20000000), imm:0xfff, result rd:x3(0x20000000)
    li x29, MASK_XLEN(0x20000000)
    andi x3, x29, SEXT_IMM(0xfff)
    sw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x20000000)

    # Testcase 96:  rs1:x28(0x40000000), imm:0xfff, result rd:x4(0x40000000)
    li x28, MASK_XLEN(0x40000000)
    andi x4, x28, SEXT_IMM(0xfff)
    sw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x40000000)

    # Testcase 97:  rs1:x27(0x80000000), imm:0xfff, result rd:x5(0x80000000)
    li x27, MASK_XLEN(0x80000000)
    andi x5, x27, SEXT_IMM(0xfff)
    sw x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x80000000)

    # Testcase 98:  rs1:x26(0x00000000), imm:0xfff, result rd:x6(0x00000000)
    li x26, MASK_XLEN(0x0)
    andi x6, x26, SEXT_IMM(0xfff)
    sw x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x00000000)

    # Testcase 99:  rs1:x25(0xfffffffe), imm:0xfff, result rd:x7(0xfffffffe)
    li x25, MASK_XLEN(0xfffffffe)
    andi x7, x25, SEXT_IMM(0xfff)
    sw x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rs1:x24(0xfffffffd), imm:0xfff, result rd:x8(0xfffffffd)
    li x24, MASK_XLEN(0xfffffffd)
    andi x8, x24, SEXT_IMM(0xfff)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffd)

    # Testcase 101:  rs1:x23(0xfffffffb), imm:0xfff, result rd:x9(0xfffffffb)
    li x23, MASK_XLEN(0xfffffffb)
    andi x9, x23, SEXT_IMM(0xfff)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffb)

    # Testcase 102:  rs1:x22(0xfffffff7), imm:0xfff, result rd:x10(0xfffffff7)
    li x22, MASK_XLEN(0xfffffff7)
    andi x10, x22, SEXT_IMM(0xfff)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffff7)

    # Testcase 103:  rs1:x21(0xffffffef), imm:0xfff, result rd:x11(0xffffffef)
    li x21, MASK_XLEN(0xffffffef)
    andi x11, x21, SEXT_IMM(0xfff)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffef)

    # Testcase 104:  rs1:x20(0xffffffdf), imm:0xfff, result rd:x12(0xffffffdf)
    li x20, MASK_XLEN(0xffffffdf)
    andi x12, x20, SEXT_IMM(0xfff)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffdf)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res


    # Testcase 105:  rs1:x19(0xffffffbf), imm:0xfff, result rd:x13(0xffffffbf)
    li x19, MASK_XLEN(0xffffffbf)
    andi x13, x19, SEXT_IMM(0xfff)
    sw x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0xffffffbf)

    # Testcase 106:  rs1:x18(0xffffff7f), imm:0xfff, result rd:x14(0xffffff7f)
    li x18, MASK_XLEN(0xffffff7f)
    andi x14, x18, SEXT_IMM(0xfff)
    sw x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xffffff7f)

    # Testcase 107:  rs1:x17(0xfffffeff), imm:0xfff, result rd:x15(0xfffffeff)
    li x17, MASK_XLEN(0xfffffeff)
    andi x15, x17, SEXT_IMM(0xfff)
    sw x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xfffffeff)

    # Testcase 108:  rs1:x16(0xfffffdff), imm:0xfff, result rd:x16(0xfffffdff)
    li x16, MASK_XLEN(0xfffffdff)
    andi x16, x16, SEXT_IMM(0xfff)
    sw x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xfffffdff)

    # Testcase 109:  rs1:x15(0xfffffbff), imm:0xfff, result rd:x17(0xfffffbff)
    li x15, MASK_XLEN(0xfffffbff)
    andi x17, x15, SEXT_IMM(0xfff)
    sw x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xfffffbff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rs1:x14(0xfffff7ff), imm:0xfff, result rd:x18(0xfffff7ff)
    li x14, MASK_XLEN(0xfffff7ff)
    andi x18, x14, SEXT_IMM(0xfff)
    sw x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0xfffff7ff)

    # Testcase 111:  rs1:x13(0xffffefff), imm:0xfff, result rd:x19(0xffffefff)
    li x13, MASK_XLEN(0xffffefff)
    andi x19, x13, SEXT_IMM(0xfff)
    sw x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xffffefff)

    # Testcase 112:  rs1:x12(0xffffdfff), imm:0xfff, result rd:x20(0xffffdfff)
    li x12, MASK_XLEN(0xffffdfff)
    andi x20, x12, SEXT_IMM(0xfff)
    sw x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffffdfff)

    # Testcase 113:  rs1:x11(0xffffbfff), imm:0xfff, result rd:x21(0xffffbfff)
    li x11, MASK_XLEN(0xffffbfff)
    andi x21, x11, SEXT_IMM(0xfff)
    sw x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffbfff)

    # Testcase 114:  rs1:x10(0xffff7fff), imm:0xfff, result rd:x22(0xffff7fff)
    li x10, MASK_XLEN(0xffff7fff)
    andi x22, x10, SEXT_IMM(0xfff)
    sw x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffff7fff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rs1:x9(0xfffeffff), imm:0xfff, result rd:x23(0xfffeffff)
    li x9, MASK_XLEN(0xfffeffff)
    andi x23, x9, SEXT_IMM(0xfff)
    sw x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffeffff)

    # Testcase 116:  rs1:x8(0xfffdffff), imm:0xfff, result rd:x24(0xfffdffff)
    li x8, MASK_XLEN(0xfffdffff)
    andi x24, x8, SEXT_IMM(0xfff)
    sw x24, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xfffdffff)

    # Testcase 117:  rs1:x7(0xfffbffff), imm:0xfff, result rd:x25(0xfffbffff)
    li x7, MASK_XLEN(0xfffbffff)
    andi x25, x7, SEXT_IMM(0xfff)
    sw x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffbffff)

    # Testcase 118:  rs1:x6(0xfff7ffff), imm:0xfff, result rd:x26(0xfff7ffff)
    li x6, MASK_XLEN(0xfff7ffff)
    andi x26, x6, SEXT_IMM(0xfff)
    sw x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xfff7ffff)

    # Testcase 119:  rs1:x5(0xffefffff), imm:0xfff, result rd:x27(0xffefffff)
    li x5, MASK_XLEN(0xffefffff)
    andi x27, x5, SEXT_IMM(0xfff)
    sw x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffefffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res


    # Testcase 120:  rs1:x4(0xffdfffff), imm:0xfff, result rd:x28(0xffdfffff)
    li x4, MASK_XLEN(0xffdfffff)
    andi x28, x4, SEXT_IMM(0xfff)
    sw x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0xffdfffff)

    # Testcase 121:  rs1:x3(0xffbfffff), imm:0xfff, result rd:x29(0xffbfffff)
    li x3, MASK_XLEN(0xffbfffff)
    andi x29, x3, SEXT_IMM(0xfff)
    sw x29, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0xffbfffff)

    # Testcase 122:  rs1:x2(0xff7fffff), imm:0xfff, result rd:x30(0xff7fffff)
    li x2, MASK_XLEN(0xff7fffff)
    andi x30, x2, SEXT_IMM(0xfff)
    sw x30, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0xff7fffff)

    # Testcase 123:  rs1:x1(0xfeffffff), imm:0xfff, result rd:x31(0xfeffffff)
    li x1, MASK_XLEN(0xfeffffff)
    andi x31, x1, SEXT_IMM(0xfff)
    sw x31, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xfeffffff)

    # Testcase 124:  rs1:x31(0xfdffffff), imm:0xfff, result rd:x1(0xfdffffff)
    li x31, MASK_XLEN(0xfdffffff)
    andi x1, x31, SEXT_IMM(0xfff)
    sw x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xfdffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rs1:x30(0xfbffffff), imm:0xfff, result rd:x2(0xfbffffff)
    li x30, MASK_XLEN(0xfbffffff)
    andi x2, x30, SEXT_IMM(0xfff)
    sw x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xfbffffff)

    # Testcase 126:  rs1:x29(0xf7ffffff), imm:0xfff, result rd:x3(0xf7ffffff)
    li x29, MASK_XLEN(0xf7ffffff)
    andi x3, x29, SEXT_IMM(0xfff)
    sw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xf7ffffff)

    # Testcase 127:  rs1:x28(0xefffffff), imm:0xfff, result rd:x4(0xefffffff)
    li x28, MASK_XLEN(0xefffffff)
    andi x4, x28, SEXT_IMM(0xfff)
    sw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xefffffff)

    # Testcase 128:  rs1:x27(0xdfffffff), imm:0xfff, result rd:x5(0xdfffffff)
    li x27, MASK_XLEN(0xdfffffff)
    andi x5, x27, SEXT_IMM(0xfff)
    sw x5, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xdfffffff)

    # Testcase 129:  rs1:x26(0xbfffffff), imm:0xfff, result rd:x6(0xbfffffff)
    li x26, MASK_XLEN(0xbfffffff)
    andi x6, x26, SEXT_IMM(0xfff)
    sw x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0xbfffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rs1:x25(0x7fffffff), imm:0xfff, result rd:x7(0x7fffffff)
    li x25, MASK_XLEN(0x7fffffff)
    andi x7, x25, SEXT_IMM(0xfff)
    sw x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x7fffffff)

    # Testcase 131:  rs1:x24(0xffffffff), imm:0xfff, result rd:x8(0xffffffff)
    li x24, MASK_XLEN(0xffffffff)
    andi x8, x24, SEXT_IMM(0xfff)
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffff)

    # Testcase 132:  rs1:x23(0x00000001), imm:0xbff, result rd:x9(0x00000001)
    li x23, MASK_XLEN(0x1)
    andi x9, x23, SEXT_IMM(0xbff)
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x00000001)

    # Testcase 133:  rs1:x22(0x00000002), imm:0xdff, result rd:x0(0x00000000)
    li x22, MASK_XLEN(0x2)
    andi x0, x22, SEXT_IMM(0xdff)
    sw x0, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x0, 0x00000000)

    # Testcase 134:  rs1:x21(0x00000004), imm:0xeff, result rd:x11(0x00000004)
    li x21, MASK_XLEN(0x4)
    andi x11, x21, SEXT_IMM(0xeff)
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x00000004)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res


    # Testcase 135:  rs1:x0(0x00000008), imm:0xf7f, result rd:x12(0x00000000)
    li x0, MASK_XLEN(0x8)
    andi x12, x0, SEXT_IMM(0xf7f)
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x00000000)


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

