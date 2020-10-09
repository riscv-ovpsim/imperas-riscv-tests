# RISC-V Compliance Test I-SLTI-01
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
# Description: Testing instruction 'SLTI'.

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


    # Testcase 0:  rs1:x31(0x00000001), imm:0xfff, result rd:x1(0x00000000)
    li x31, MASK_XLEN(0x1)
    slti x1, x31, SEXT_IMM(0xfff)
    sw x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x00000000)

    # Testcase 1:  rs1:x30(0x00000002), imm:0x7ff, result rd:x2(0x00000001)
    li x30, MASK_XLEN(0x2)
    slti x2, x30, SEXT_IMM(0x7ff)
    sw x2, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x00000001)

    # Testcase 2:  rs1:x29(0x00000004), imm:0xbff, result rd:x3(0x00000000)
    li x29, MASK_XLEN(0x4)
    slti x3, x29, SEXT_IMM(0xbff)
    sw x3, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x00000000)

    # Testcase 3:  rs1:x28(0x00000008), imm:0xdff, result rd:x4(0x00000000)
    li x28, MASK_XLEN(0x8)
    slti x4, x28, SEXT_IMM(0xdff)
    sw x4, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x00000000)

    # Testcase 4:  rs1:x27(0x00000010), imm:0xeff, result rd:x5(0x00000000)
    li x27, MASK_XLEN(0x10)
    slti x5, x27, SEXT_IMM(0xeff)
    sw x5, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rs1:x26(0x00000020), imm:0xf7f, result rd:x6(0x00000000)
    li x26, MASK_XLEN(0x20)
    slti x6, x26, SEXT_IMM(0xf7f)
    sw x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x00000000)

    # Testcase 6:  rs1:x25(0x00000040), imm:0xfbf, result rd:x7(0x00000000)
    li x25, MASK_XLEN(0x40)
    slti x7, x25, SEXT_IMM(0xfbf)
    sw x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x00000000)

    # Testcase 7:  rs1:x24(0x00000080), imm:0xfdf, result rd:x8(0x00000000)
    li x24, MASK_XLEN(0x80)
    slti x8, x24, SEXT_IMM(0xfdf)
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Testcase 8:  rs1:x23(0x00000100), imm:0xfef, result rd:x9(0x00000000)
    li x23, MASK_XLEN(0x100)
    slti x9, x23, SEXT_IMM(0xfef)
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x00000000)

    # Testcase 9:  rs1:x22(0x00000200), imm:0xff7, result rd:x10(0x00000000)
    li x22, MASK_XLEN(0x200)
    slti x10, x22, SEXT_IMM(0xff7)
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rs1:x21(0x00000400), imm:0xffb, result rd:x11(0x00000000)
    li x21, MASK_XLEN(0x400)
    slti x11, x21, SEXT_IMM(0xffb)
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x00000000)

    # Testcase 11:  rs1:x20(0x00000800), imm:0xffd, result rd:x12(0x00000000)
    li x20, MASK_XLEN(0x800)
    slti x12, x20, SEXT_IMM(0xffd)
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x00000000)

    # Testcase 12:  rs1:x19(0x00001000), imm:0xffe, result rd:x13(0x00000000)
    li x19, MASK_XLEN(0x1000)
    slti x13, x19, SEXT_IMM(0xffe)
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x00000000)

    # Testcase 13:  rs1:x18(0x00002000), imm:0x0, result rd:x14(0x00000000)
    li x18, MASK_XLEN(0x2000)
    slti x14, x18, SEXT_IMM(0x0)
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x00000000)

    # Testcase 14:  rs1:x17(0x00004000), imm:0x800, result rd:x15(0x00000000)
    li x17, MASK_XLEN(0x4000)
    slti x15, x17, SEXT_IMM(0x800)
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res


    # Testcase 15:  rs1:x16(0x00008000), imm:0x400, result rd:x16(0x00000000)
    li x16, MASK_XLEN(0x8000)
    slti x16, x16, SEXT_IMM(0x400)
    sw x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x00000000)

    # Testcase 16:  rs1:x15(0x00010000), imm:0x200, result rd:x17(0x00000000)
    li x15, MASK_XLEN(0x10000)
    slti x17, x15, SEXT_IMM(0x200)
    sw x17, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x00000000)

    # Testcase 17:  rs1:x14(0x00020000), imm:0x100, result rd:x18(0x00000000)
    li x14, MASK_XLEN(0x20000)
    slti x18, x14, SEXT_IMM(0x100)
    sw x18, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x00000000)

    # Testcase 18:  rs1:x13(0x00040000), imm:0x80, result rd:x19(0x00000000)
    li x13, MASK_XLEN(0x40000)
    slti x19, x13, SEXT_IMM(0x80)
    sw x19, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x00000000)

    # Testcase 19:  rs1:x12(0x00080000), imm:0x40, result rd:x20(0x00000000)
    li x12, MASK_XLEN(0x80000)
    slti x20, x12, SEXT_IMM(0x40)
    sw x20, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rs1:x11(0x00100000), imm:0x20, result rd:x21(0x00000000)
    li x11, MASK_XLEN(0x100000)
    slti x21, x11, SEXT_IMM(0x20)
    sw x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x00000000)

    # Testcase 21:  rs1:x10(0x00200000), imm:0x10, result rd:x22(0x00000000)
    li x10, MASK_XLEN(0x200000)
    slti x22, x10, SEXT_IMM(0x10)
    sw x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x00000000)

    # Testcase 22:  rs1:x9(0x00400000), imm:0x8, result rd:x23(0x00000000)
    li x9, MASK_XLEN(0x400000)
    slti x23, x9, SEXT_IMM(0x8)
    sw x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x00000000)

    # Testcase 23:  rs1:x8(0x00800000), imm:0x4, result rd:x24(0x00000000)
    li x8, MASK_XLEN(0x800000)
    slti x24, x8, SEXT_IMM(0x4)
    sw x24, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x00000000)

    # Testcase 24:  rs1:x7(0x01000000), imm:0x2, result rd:x25(0x00000000)
    li x7, MASK_XLEN(0x1000000)
    slti x25, x7, SEXT_IMM(0x2)
    sw x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rs1:x6(0x02000000), imm:0x1, result rd:x26(0x00000000)
    li x6, MASK_XLEN(0x2000000)
    slti x26, x6, SEXT_IMM(0x1)
    sw x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x00000000)

    # Testcase 26:  rs1:x5(0x04000000), imm:0xfff, result rd:x27(0x00000000)
    li x5, MASK_XLEN(0x4000000)
    slti x27, x5, SEXT_IMM(0xfff)
    sw x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x00000000)

    # Testcase 27:  rs1:x4(0x08000000), imm:0x7ff, result rd:x28(0x00000000)
    li x4, MASK_XLEN(0x8000000)
    slti x28, x4, SEXT_IMM(0x7ff)
    sw x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x00000000)

    # Testcase 28:  rs1:x3(0x10000000), imm:0xbff, result rd:x29(0x00000000)
    li x3, MASK_XLEN(0x10000000)
    slti x29, x3, SEXT_IMM(0xbff)
    sw x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x00000000)

    # Testcase 29:  rs1:x2(0x20000000), imm:0xdff, result rd:x30(0x00000000)
    li x2, MASK_XLEN(0x20000000)
    slti x30, x2, SEXT_IMM(0xdff)
    sw x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res


    # Testcase 30:  rs1:x1(0x40000000), imm:0xeff, result rd:x31(0x00000000)
    li x1, MASK_XLEN(0x40000000)
    slti x31, x1, SEXT_IMM(0xeff)
    sw x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x00000000)

    # Testcase 31:  rs1:x31(0x80000000), imm:0xf7f, result rd:x1(0x00000001)
    li x31, MASK_XLEN(0x80000000)
    slti x1, x31, SEXT_IMM(0xf7f)
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x00000001)

    # Testcase 32:  rs1:x30(0x00000000), imm:0xfbf, result rd:x2(0x00000000)
    li x30, MASK_XLEN(0x0)
    slti x2, x30, SEXT_IMM(0xfbf)
    sw x2, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x00000000)

    # Testcase 33:  rs1:x29(0xfffffffe), imm:0xfdf, result rd:x3(0x00000000)
    li x29, MASK_XLEN(0xfffffffe)
    slti x3, x29, SEXT_IMM(0xfdf)
    sw x3, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x00000000)

    # Testcase 34:  rs1:x28(0xfffffffd), imm:0xfef, result rd:x4(0x00000000)
    li x28, MASK_XLEN(0xfffffffd)
    slti x4, x28, SEXT_IMM(0xfef)
    sw x4, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rs1:x27(0xfffffffb), imm:0xff7, result rd:x5(0x00000000)
    li x27, MASK_XLEN(0xfffffffb)
    slti x5, x27, SEXT_IMM(0xff7)
    sw x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x00000000)

    # Testcase 36:  rs1:x26(0xfffffff7), imm:0xffb, result rd:x6(0x00000001)
    li x26, MASK_XLEN(0xfffffff7)
    slti x6, x26, SEXT_IMM(0xffb)
    sw x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x00000001)

    # Testcase 37:  rs1:x25(0xffffffef), imm:0xffd, result rd:x7(0x00000001)
    li x25, MASK_XLEN(0xffffffef)
    slti x7, x25, SEXT_IMM(0xffd)
    sw x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x00000001)

    # Testcase 38:  rs1:x24(0xffffffdf), imm:0xffe, result rd:x8(0x00000001)
    li x24, MASK_XLEN(0xffffffdf)
    slti x8, x24, SEXT_IMM(0xffe)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000001)

    # Testcase 39:  rs1:x23(0xffffffbf), imm:0x0, result rd:x9(0x00000001)
    li x23, MASK_XLEN(0xffffffbf)
    slti x9, x23, SEXT_IMM(0x0)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rs1:x22(0xffffff7f), imm:0x800, result rd:x10(0x00000000)
    li x22, MASK_XLEN(0xffffff7f)
    slti x10, x22, SEXT_IMM(0x800)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x00000000)

    # Testcase 41:  rs1:x21(0xfffffeff), imm:0x400, result rd:x11(0x00000001)
    li x21, MASK_XLEN(0xfffffeff)
    slti x11, x21, SEXT_IMM(0x400)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x00000001)

    # Testcase 42:  rs1:x20(0xfffffdff), imm:0x200, result rd:x12(0x00000001)
    li x20, MASK_XLEN(0xfffffdff)
    slti x12, x20, SEXT_IMM(0x200)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x00000001)

    # Testcase 43:  rs1:x19(0xfffffbff), imm:0x100, result rd:x13(0x00000001)
    li x19, MASK_XLEN(0xfffffbff)
    slti x13, x19, SEXT_IMM(0x100)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x00000001)

    # Testcase 44:  rs1:x18(0xfffff7ff), imm:0x80, result rd:x14(0x00000001)
    li x18, MASK_XLEN(0xfffff7ff)
    slti x14, x18, SEXT_IMM(0x80)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res


    # Testcase 45:  rs1:x17(0xffffefff), imm:0x40, result rd:x15(0x00000001)
    li x17, MASK_XLEN(0xffffefff)
    slti x15, x17, SEXT_IMM(0x40)
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x00000001)

    # Testcase 46:  rs1:x16(0xffffdfff), imm:0x20, result rd:x16(0x00000001)
    li x16, MASK_XLEN(0xffffdfff)
    slti x16, x16, SEXT_IMM(0x20)
    sw x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x00000001)

    # Testcase 47:  rs1:x15(0xffffbfff), imm:0x10, result rd:x17(0x00000001)
    li x15, MASK_XLEN(0xffffbfff)
    slti x17, x15, SEXT_IMM(0x10)
    sw x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x00000001)

    # Testcase 48:  rs1:x14(0xffff7fff), imm:0x8, result rd:x18(0x00000001)
    li x14, MASK_XLEN(0xffff7fff)
    slti x18, x14, SEXT_IMM(0x8)
    sw x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x00000001)

    # Testcase 49:  rs1:x13(0xfffeffff), imm:0x4, result rd:x19(0x00000001)
    li x13, MASK_XLEN(0xfffeffff)
    slti x19, x13, SEXT_IMM(0x4)
    sw x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rs1:x12(0xfffdffff), imm:0x2, result rd:x20(0x00000001)
    li x12, MASK_XLEN(0xfffdffff)
    slti x20, x12, SEXT_IMM(0x2)
    sw x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x00000001)

    # Testcase 51:  rs1:x11(0xfffbffff), imm:0x1, result rd:x21(0x00000001)
    li x11, MASK_XLEN(0xfffbffff)
    slti x21, x11, SEXT_IMM(0x1)
    sw x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x00000001)

    # Testcase 52:  rs1:x10(0xfff7ffff), imm:0xfff, result rd:x22(0x00000001)
    li x10, MASK_XLEN(0xfff7ffff)
    slti x22, x10, SEXT_IMM(0xfff)
    sw x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x00000001)

    # Testcase 53:  rs1:x9(0xffefffff), imm:0x7ff, result rd:x23(0x00000001)
    li x9, MASK_XLEN(0xffefffff)
    slti x23, x9, SEXT_IMM(0x7ff)
    sw x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x00000001)

    # Testcase 54:  rs1:x8(0xffdfffff), imm:0xbff, result rd:x24(0x00000001)
    li x8, MASK_XLEN(0xffdfffff)
    slti x24, x8, SEXT_IMM(0xbff)
    sw x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rs1:x7(0xffbfffff), imm:0xdff, result rd:x25(0x00000001)
    li x7, MASK_XLEN(0xffbfffff)
    slti x25, x7, SEXT_IMM(0xdff)
    sw x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x00000001)

    # Testcase 56:  rs1:x6(0xff7fffff), imm:0xeff, result rd:x26(0x00000001)
    li x6, MASK_XLEN(0xff7fffff)
    slti x26, x6, SEXT_IMM(0xeff)
    sw x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x00000001)

    # Testcase 57:  rs1:x5(0xfeffffff), imm:0xf7f, result rd:x27(0x00000001)
    li x5, MASK_XLEN(0xfeffffff)
    slti x27, x5, SEXT_IMM(0xf7f)
    sw x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x00000001)

    # Testcase 58:  rs1:x4(0xfdffffff), imm:0xfbf, result rd:x28(0x00000001)
    li x4, MASK_XLEN(0xfdffffff)
    slti x28, x4, SEXT_IMM(0xfbf)
    sw x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x00000001)

    # Testcase 59:  rs1:x3(0xfbffffff), imm:0xfdf, result rd:x29(0x00000001)
    li x3, MASK_XLEN(0xfbffffff)
    slti x29, x3, SEXT_IMM(0xfdf)
    sw x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res


    # Testcase 60:  rs1:x2(0xf7ffffff), imm:0xfef, result rd:x30(0x00000001)
    li x2, MASK_XLEN(0xf7ffffff)
    slti x30, x2, SEXT_IMM(0xfef)
    sw x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x00000001)

    # Testcase 61:  rs1:x1(0xefffffff), imm:0xff7, result rd:x31(0x00000001)
    li x1, MASK_XLEN(0xefffffff)
    slti x31, x1, SEXT_IMM(0xff7)
    sw x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x00000001)

    # Testcase 62:  rs1:x31(0xdfffffff), imm:0xffb, result rd:x1(0x00000001)
    li x31, MASK_XLEN(0xdfffffff)
    slti x1, x31, SEXT_IMM(0xffb)
    sw x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x00000001)

    # Testcase 63:  rs1:x30(0xbfffffff), imm:0xffd, result rd:x2(0x00000001)
    li x30, MASK_XLEN(0xbfffffff)
    slti x2, x30, SEXT_IMM(0xffd)
    sw x2, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x00000001)

    # Testcase 64:  rs1:x29(0x7fffffff), imm:0xffe, result rd:x3(0x00000000)
    li x29, MASK_XLEN(0x7fffffff)
    slti x3, x29, SEXT_IMM(0xffe)
    sw x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rs1:x28(0xffffffff), imm:0x0, result rd:x4(0x00000001)
    li x28, MASK_XLEN(0xffffffff)
    slti x4, x28, SEXT_IMM(0x0)
    sw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x00000001)

    # Testcase 66:  rs1:x27(0x00000001), imm:0x0, result rd:x5(0x00000000)
    li x27, MASK_XLEN(0x1)
    slti x5, x27, SEXT_IMM(0x0)
    sw x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x00000000)

    # Testcase 67:  rs1:x26(0x00000002), imm:0x0, result rd:x6(0x00000000)
    li x26, MASK_XLEN(0x2)
    slti x6, x26, SEXT_IMM(0x0)
    sw x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x00000000)

    # Testcase 68:  rs1:x25(0x00000004), imm:0x0, result rd:x7(0x00000000)
    li x25, MASK_XLEN(0x4)
    slti x7, x25, SEXT_IMM(0x0)
    sw x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x00000000)

    # Testcase 69:  rs1:x24(0x00000008), imm:0x0, result rd:x8(0x00000000)
    li x24, MASK_XLEN(0x8)
    slti x8, x24, SEXT_IMM(0x0)
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rs1:x23(0x00000010), imm:0x0, result rd:x9(0x00000000)
    li x23, MASK_XLEN(0x10)
    slti x9, x23, SEXT_IMM(0x0)
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x00000000)

    # Testcase 71:  rs1:x22(0x00000020), imm:0x0, result rd:x10(0x00000000)
    li x22, MASK_XLEN(0x20)
    slti x10, x22, SEXT_IMM(0x0)
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x00000000)

    # Testcase 72:  rs1:x21(0x00000040), imm:0x0, result rd:x11(0x00000000)
    li x21, MASK_XLEN(0x40)
    slti x11, x21, SEXT_IMM(0x0)
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x00000000)

    # Testcase 73:  rs1:x20(0x00000080), imm:0x0, result rd:x12(0x00000000)
    li x20, MASK_XLEN(0x80)
    slti x12, x20, SEXT_IMM(0x0)
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x00000000)

    # Testcase 74:  rs1:x19(0x00000100), imm:0x0, result rd:x13(0x00000000)
    li x19, MASK_XLEN(0x100)
    slti x13, x19, SEXT_IMM(0x0)
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res


    # Testcase 75:  rs1:x18(0x00000200), imm:0x0, result rd:x14(0x00000000)
    li x18, MASK_XLEN(0x200)
    slti x14, x18, SEXT_IMM(0x0)
    sw x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x00000000)

    # Testcase 76:  rs1:x17(0x00000400), imm:0x0, result rd:x15(0x00000000)
    li x17, MASK_XLEN(0x400)
    slti x15, x17, SEXT_IMM(0x0)
    sw x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x00000000)

    # Testcase 77:  rs1:x16(0x00000800), imm:0x0, result rd:x16(0x00000000)
    li x16, MASK_XLEN(0x800)
    slti x16, x16, SEXT_IMM(0x0)
    sw x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x00000000)

    # Testcase 78:  rs1:x15(0x00001000), imm:0x0, result rd:x17(0x00000000)
    li x15, MASK_XLEN(0x1000)
    slti x17, x15, SEXT_IMM(0x0)
    sw x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x00000000)

    # Testcase 79:  rs1:x14(0x00002000), imm:0x0, result rd:x18(0x00000000)
    li x14, MASK_XLEN(0x2000)
    slti x18, x14, SEXT_IMM(0x0)
    sw x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rs1:x13(0x00004000), imm:0x0, result rd:x19(0x00000000)
    li x13, MASK_XLEN(0x4000)
    slti x19, x13, SEXT_IMM(0x0)
    sw x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x00000000)

    # Testcase 81:  rs1:x12(0x00008000), imm:0x0, result rd:x20(0x00000000)
    li x12, MASK_XLEN(0x8000)
    slti x20, x12, SEXT_IMM(0x0)
    sw x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x00000000)

    # Testcase 82:  rs1:x11(0x00010000), imm:0x0, result rd:x21(0x00000000)
    li x11, MASK_XLEN(0x10000)
    slti x21, x11, SEXT_IMM(0x0)
    sw x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x00000000)

    # Testcase 83:  rs1:x10(0x00020000), imm:0x0, result rd:x22(0x00000000)
    li x10, MASK_XLEN(0x20000)
    slti x22, x10, SEXT_IMM(0x0)
    sw x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x00000000)

    # Testcase 84:  rs1:x9(0x00040000), imm:0x0, result rd:x23(0x00000000)
    li x9, MASK_XLEN(0x40000)
    slti x23, x9, SEXT_IMM(0x0)
    sw x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rs1:x8(0x00080000), imm:0x0, result rd:x24(0x00000000)
    li x8, MASK_XLEN(0x80000)
    slti x24, x8, SEXT_IMM(0x0)
    sw x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x00000000)

    # Testcase 86:  rs1:x7(0x00100000), imm:0x0, result rd:x25(0x00000000)
    li x7, MASK_XLEN(0x100000)
    slti x25, x7, SEXT_IMM(0x0)
    sw x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x00000000)

    # Testcase 87:  rs1:x6(0x00200000), imm:0x0, result rd:x26(0x00000000)
    li x6, MASK_XLEN(0x200000)
    slti x26, x6, SEXT_IMM(0x0)
    sw x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x00000000)

    # Testcase 88:  rs1:x5(0x00400000), imm:0x0, result rd:x27(0x00000000)
    li x5, MASK_XLEN(0x400000)
    slti x27, x5, SEXT_IMM(0x0)
    sw x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x00000000)

    # Testcase 89:  rs1:x4(0x00800000), imm:0x0, result rd:x28(0x00000000)
    li x4, MASK_XLEN(0x800000)
    slti x28, x4, SEXT_IMM(0x0)
    sw x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res


    # Testcase 90:  rs1:x3(0x01000000), imm:0x0, result rd:x29(0x00000000)
    li x3, MASK_XLEN(0x1000000)
    slti x29, x3, SEXT_IMM(0x0)
    sw x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x00000000)

    # Testcase 91:  rs1:x2(0x02000000), imm:0x0, result rd:x30(0x00000000)
    li x2, MASK_XLEN(0x2000000)
    slti x30, x2, SEXT_IMM(0x0)
    sw x30, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x00000000)

    # Testcase 92:  rs1:x1(0x04000000), imm:0x0, result rd:x31(0x00000000)
    li x1, MASK_XLEN(0x4000000)
    slti x31, x1, SEXT_IMM(0x0)
    sw x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x00000000)

    # Testcase 93:  rs1:x31(0x08000000), imm:0x0, result rd:x1(0x00000000)
    li x31, MASK_XLEN(0x8000000)
    slti x1, x31, SEXT_IMM(0x0)
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x00000000)

    # Testcase 94:  rs1:x30(0x10000000), imm:0x0, result rd:x2(0x00000000)
    li x30, MASK_XLEN(0x10000000)
    slti x2, x30, SEXT_IMM(0x0)
    sw x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rs1:x29(0x20000000), imm:0x0, result rd:x3(0x00000000)
    li x29, MASK_XLEN(0x20000000)
    slti x3, x29, SEXT_IMM(0x0)
    sw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Testcase 96:  rs1:x28(0x40000000), imm:0x0, result rd:x4(0x00000000)
    li x28, MASK_XLEN(0x40000000)
    slti x4, x28, SEXT_IMM(0x0)
    sw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x00000000)

    # Testcase 97:  rs1:x27(0x80000000), imm:0x0, result rd:x5(0x00000001)
    li x27, MASK_XLEN(0x80000000)
    slti x5, x27, SEXT_IMM(0x0)
    sw x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x00000001)

    # Testcase 98:  rs1:x26(0x00000000), imm:0x0, result rd:x6(0x00000000)
    li x26, MASK_XLEN(0x0)
    slti x6, x26, SEXT_IMM(0x0)
    sw x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x00000000)

    # Testcase 99:  rs1:x25(0xfffffffe), imm:0x0, result rd:x7(0x00000001)
    li x25, MASK_XLEN(0xfffffffe)
    slti x7, x25, SEXT_IMM(0x0)
    sw x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rs1:x24(0xfffffffd), imm:0x0, result rd:x8(0x00000001)
    li x24, MASK_XLEN(0xfffffffd)
    slti x8, x24, SEXT_IMM(0x0)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000001)

    # Testcase 101:  rs1:x23(0xfffffffb), imm:0x0, result rd:x9(0x00000001)
    li x23, MASK_XLEN(0xfffffffb)
    slti x9, x23, SEXT_IMM(0x0)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x00000001)

    # Testcase 102:  rs1:x22(0xfffffff7), imm:0x0, result rd:x10(0x00000001)
    li x22, MASK_XLEN(0xfffffff7)
    slti x10, x22, SEXT_IMM(0x0)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x00000001)

    # Testcase 103:  rs1:x21(0xffffffef), imm:0x0, result rd:x11(0x00000001)
    li x21, MASK_XLEN(0xffffffef)
    slti x11, x21, SEXT_IMM(0x0)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x00000001)

    # Testcase 104:  rs1:x20(0xffffffdf), imm:0x0, result rd:x12(0x00000001)
    li x20, MASK_XLEN(0xffffffdf)
    slti x12, x20, SEXT_IMM(0x0)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res


    # Testcase 105:  rs1:x19(0xffffffbf), imm:0x0, result rd:x13(0x00000001)
    li x19, MASK_XLEN(0xffffffbf)
    slti x13, x19, SEXT_IMM(0x0)
    sw x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x00000001)

    # Testcase 106:  rs1:x18(0xffffff7f), imm:0x0, result rd:x14(0x00000001)
    li x18, MASK_XLEN(0xffffff7f)
    slti x14, x18, SEXT_IMM(0x0)
    sw x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x00000001)

    # Testcase 107:  rs1:x17(0xfffffeff), imm:0x0, result rd:x15(0x00000001)
    li x17, MASK_XLEN(0xfffffeff)
    slti x15, x17, SEXT_IMM(0x0)
    sw x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x00000001)

    # Testcase 108:  rs1:x16(0xfffffdff), imm:0x0, result rd:x16(0x00000001)
    li x16, MASK_XLEN(0xfffffdff)
    slti x16, x16, SEXT_IMM(0x0)
    sw x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x00000001)

    # Testcase 109:  rs1:x15(0xfffffbff), imm:0x0, result rd:x17(0x00000001)
    li x15, MASK_XLEN(0xfffffbff)
    slti x17, x15, SEXT_IMM(0x0)
    sw x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rs1:x14(0xfffff7ff), imm:0x0, result rd:x18(0x00000001)
    li x14, MASK_XLEN(0xfffff7ff)
    slti x18, x14, SEXT_IMM(0x0)
    sw x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x00000001)

    # Testcase 111:  rs1:x13(0xffffefff), imm:0x0, result rd:x19(0x00000001)
    li x13, MASK_XLEN(0xffffefff)
    slti x19, x13, SEXT_IMM(0x0)
    sw x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x00000001)

    # Testcase 112:  rs1:x12(0xffffdfff), imm:0x0, result rd:x20(0x00000001)
    li x12, MASK_XLEN(0xffffdfff)
    slti x20, x12, SEXT_IMM(0x0)
    sw x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x00000001)

    # Testcase 113:  rs1:x11(0xffffbfff), imm:0x0, result rd:x21(0x00000001)
    li x11, MASK_XLEN(0xffffbfff)
    slti x21, x11, SEXT_IMM(0x0)
    sw x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x00000001)

    # Testcase 114:  rs1:x10(0xffff7fff), imm:0x0, result rd:x22(0x00000001)
    li x10, MASK_XLEN(0xffff7fff)
    slti x22, x10, SEXT_IMM(0x0)
    sw x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rs1:x9(0xfffeffff), imm:0x0, result rd:x23(0x00000001)
    li x9, MASK_XLEN(0xfffeffff)
    slti x23, x9, SEXT_IMM(0x0)
    sw x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x00000001)

    # Testcase 116:  rs1:x8(0xfffdffff), imm:0x0, result rd:x24(0x00000001)
    li x8, MASK_XLEN(0xfffdffff)
    slti x24, x8, SEXT_IMM(0x0)
    sw x24, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x00000001)

    # Testcase 117:  rs1:x7(0xfffbffff), imm:0x0, result rd:x25(0x00000001)
    li x7, MASK_XLEN(0xfffbffff)
    slti x25, x7, SEXT_IMM(0x0)
    sw x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x00000001)

    # Testcase 118:  rs1:x6(0xfff7ffff), imm:0x0, result rd:x26(0x00000001)
    li x6, MASK_XLEN(0xfff7ffff)
    slti x26, x6, SEXT_IMM(0x0)
    sw x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x00000001)

    # Testcase 119:  rs1:x5(0xffefffff), imm:0x0, result rd:x27(0x00000001)
    li x5, MASK_XLEN(0xffefffff)
    slti x27, x5, SEXT_IMM(0x0)
    sw x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res


    # Testcase 120:  rs1:x4(0xffdfffff), imm:0x0, result rd:x28(0x00000001)
    li x4, MASK_XLEN(0xffdfffff)
    slti x28, x4, SEXT_IMM(0x0)
    sw x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0x00000001)

    # Testcase 121:  rs1:x3(0xffbfffff), imm:0x0, result rd:x29(0x00000001)
    li x3, MASK_XLEN(0xffbfffff)
    slti x29, x3, SEXT_IMM(0x0)
    sw x29, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x00000001)

    # Testcase 122:  rs1:x2(0xff7fffff), imm:0x0, result rd:x30(0x00000001)
    li x2, MASK_XLEN(0xff7fffff)
    slti x30, x2, SEXT_IMM(0x0)
    sw x30, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x00000001)

    # Testcase 123:  rs1:x1(0xfeffffff), imm:0x0, result rd:x31(0x00000001)
    li x1, MASK_XLEN(0xfeffffff)
    slti x31, x1, SEXT_IMM(0x0)
    sw x31, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x00000001)

    # Testcase 124:  rs1:x31(0xfdffffff), imm:0x0, result rd:x1(0x00000001)
    li x31, MASK_XLEN(0xfdffffff)
    slti x1, x31, SEXT_IMM(0x0)
    sw x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rs1:x30(0xfbffffff), imm:0x0, result rd:x2(0x00000001)
    li x30, MASK_XLEN(0xfbffffff)
    slti x2, x30, SEXT_IMM(0x0)
    sw x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x00000001)

    # Testcase 126:  rs1:x29(0xf7ffffff), imm:0x0, result rd:x3(0x00000001)
    li x29, MASK_XLEN(0xf7ffffff)
    slti x3, x29, SEXT_IMM(0x0)
    sw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x00000001)

    # Testcase 127:  rs1:x28(0xefffffff), imm:0x0, result rd:x4(0x00000001)
    li x28, MASK_XLEN(0xefffffff)
    slti x4, x28, SEXT_IMM(0x0)
    sw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x00000001)

    # Testcase 128:  rs1:x27(0xdfffffff), imm:0x0, result rd:x5(0x00000001)
    li x27, MASK_XLEN(0xdfffffff)
    slti x5, x27, SEXT_IMM(0x0)
    sw x5, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x00000001)

    # Testcase 129:  rs1:x26(0xbfffffff), imm:0x0, result rd:x6(0x00000001)
    li x26, MASK_XLEN(0xbfffffff)
    slti x6, x26, SEXT_IMM(0x0)
    sw x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0x00000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rs1:x25(0x7fffffff), imm:0x0, result rd:x7(0x00000000)
    li x25, MASK_XLEN(0x7fffffff)
    slti x7, x25, SEXT_IMM(0x0)
    sw x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x00000000)

    # Testcase 131:  rs1:x24(0xffffffff), imm:0x0, result rd:x8(0x00000001)
    li x24, MASK_XLEN(0xffffffff)
    slti x8, x24, SEXT_IMM(0x0)
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x00000001)

    # Testcase 132:  rs1:x23(0x00000001), imm:0xbff, result rd:x9(0x00000000)
    li x23, MASK_XLEN(0x1)
    slti x9, x23, SEXT_IMM(0xbff)
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x00000000)

    # Testcase 133:  rs1:x22(0x00000002), imm:0xdff, result rd:x0(0x00000000)
    li x22, MASK_XLEN(0x2)
    slti x0, x22, SEXT_IMM(0xdff)
    sw x0, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x0, 0x00000000)

    # Testcase 134:  rs1:x21(0x00000004), imm:0xeff, result rd:x11(0x00000000)
    li x21, MASK_XLEN(0x4)
    slti x11, x21, SEXT_IMM(0xeff)
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res


    # Testcase 135:  rs1:x0(0x00000008), imm:0xf7f, result rd:x12(0x00000000)
    li x0, MASK_XLEN(0x8)
    slti x12, x0, SEXT_IMM(0xf7f)
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

