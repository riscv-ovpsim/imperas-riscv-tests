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
# Specification: RV64I Base Integer Instruction Set, Version 2.1
# Description: Testing instruction 'SLTI'.

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


    # address for test results
    la x6, test_1_res


    # Testcase 0:  rs1:x31(0x0000000000000001), imm:0xfff, result rd:x1(0x0000000000000000)
    li x31, MASK_XLEN(0x1)
    slti x1, x31, SEXT_IMM(0xfff)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x0000000000000000)

    # Testcase 1:  rs1:x30(0x0000000000000002), imm:0x7ff, result rd:x2(0x0000000000000001)
    li x30, MASK_XLEN(0x2)
    slti x2, x30, SEXT_IMM(0x7ff)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x0000000000000001)

    # Testcase 2:  rs1:x29(0x0000000000000004), imm:0xbff, result rd:x3(0x0000000000000000)
    li x29, MASK_XLEN(0x4)
    slti x3, x29, SEXT_IMM(0xbff)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0000000000000000)

    # Testcase 3:  rs1:x28(0x0000000000000008), imm:0xdff, result rd:x4(0x0000000000000000)
    li x28, MASK_XLEN(0x8)
    slti x4, x28, SEXT_IMM(0xdff)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x0000000000000000)

    # Testcase 4:  rs1:x27(0x0000000000000010), imm:0xeff, result rd:x5(0x0000000000000000)
    li x27, MASK_XLEN(0x10)
    slti x5, x27, SEXT_IMM(0xeff)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rs1:x26(0x0000000000000020), imm:0xf7f, result rd:x6(0x0000000000000000)
    li x26, MASK_XLEN(0x20)
    slti x6, x26, SEXT_IMM(0xf7f)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0000000000000000)

    # Testcase 6:  rs1:x25(0x0000000000000040), imm:0xfbf, result rd:x7(0x0000000000000000)
    li x25, MASK_XLEN(0x40)
    slti x7, x25, SEXT_IMM(0xfbf)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000000000000)

    # Testcase 7:  rs1:x24(0x0000000000000080), imm:0xfdf, result rd:x8(0x0000000000000000)
    li x24, MASK_XLEN(0x80)
    slti x8, x24, SEXT_IMM(0xfdf)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Testcase 8:  rs1:x23(0x0000000000000100), imm:0xfef, result rd:x9(0x0000000000000000)
    li x23, MASK_XLEN(0x100)
    slti x9, x23, SEXT_IMM(0xfef)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000000)

    # Testcase 9:  rs1:x22(0x0000000000000200), imm:0xff7, result rd:x10(0x0000000000000000)
    li x22, MASK_XLEN(0x200)
    slti x10, x22, SEXT_IMM(0xff7)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rs1:x21(0x0000000000000400), imm:0xffb, result rd:x11(0x0000000000000000)
    li x21, MASK_XLEN(0x400)
    slti x11, x21, SEXT_IMM(0xffb)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x0000000000000000)

    # Testcase 11:  rs1:x20(0x0000000000000800), imm:0xffd, result rd:x12(0x0000000000000000)
    li x20, MASK_XLEN(0x800)
    slti x12, x20, SEXT_IMM(0xffd)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x0000000000000000)

    # Testcase 12:  rs1:x19(0x0000000000001000), imm:0xffe, result rd:x13(0x0000000000000000)
    li x19, MASK_XLEN(0x1000)
    slti x13, x19, SEXT_IMM(0xffe)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0000000000000000)

    # Testcase 13:  rs1:x18(0x0000000000002000), imm:0x0, result rd:x14(0x0000000000000000)
    li x18, MASK_XLEN(0x2000)
    slti x14, x18, SEXT_IMM(0x0)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0000000000000000)

    # Testcase 14:  rs1:x17(0x0000000000004000), imm:0x800, result rd:x15(0x0000000000000000)
    li x17, MASK_XLEN(0x4000)
    slti x15, x17, SEXT_IMM(0x800)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res


    # Testcase 15:  rs1:x16(0x0000000000008000), imm:0x400, result rd:x16(0x0000000000000000)
    li x16, MASK_XLEN(0x8000)
    slti x16, x16, SEXT_IMM(0x400)
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x0000000000000000)

    # Testcase 16:  rs1:x15(0x0000000000010000), imm:0x200, result rd:x17(0x0000000000000000)
    li x15, MASK_XLEN(0x10000)
    slti x17, x15, SEXT_IMM(0x200)
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x0000000000000000)

    # Testcase 17:  rs1:x14(0x0000000000020000), imm:0x100, result rd:x18(0x0000000000000000)
    li x14, MASK_XLEN(0x20000)
    slti x18, x14, SEXT_IMM(0x100)
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x0000000000000000)

    # Testcase 18:  rs1:x13(0x0000000000040000), imm:0x80, result rd:x19(0x0000000000000000)
    li x13, MASK_XLEN(0x40000)
    slti x19, x13, SEXT_IMM(0x80)
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x0000000000000000)

    # Testcase 19:  rs1:x12(0x0000000000080000), imm:0x40, result rd:x20(0x0000000000000000)
    li x12, MASK_XLEN(0x80000)
    slti x20, x12, SEXT_IMM(0x40)
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rs1:x11(0x0000000000100000), imm:0x20, result rd:x21(0x0000000000000000)
    li x11, MASK_XLEN(0x100000)
    slti x21, x11, SEXT_IMM(0x20)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000000000000000)

    # Testcase 21:  rs1:x10(0x0000000000200000), imm:0x10, result rd:x22(0x0000000000000000)
    li x10, MASK_XLEN(0x200000)
    slti x22, x10, SEXT_IMM(0x10)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000000000000000)

    # Testcase 22:  rs1:x9(0x0000000000400000), imm:0x8, result rd:x23(0x0000000000000000)
    li x9, MASK_XLEN(0x400000)
    slti x23, x9, SEXT_IMM(0x8)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000000000000000)

    # Testcase 23:  rs1:x8(0x0000000000800000), imm:0x4, result rd:x24(0x0000000000000000)
    li x8, MASK_XLEN(0x800000)
    slti x24, x8, SEXT_IMM(0x4)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0000000000000000)

    # Testcase 24:  rs1:x7(0x0000000001000000), imm:0x2, result rd:x25(0x0000000000000000)
    li x7, MASK_XLEN(0x1000000)
    slti x25, x7, SEXT_IMM(0x2)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rs1:x6(0x0000000002000000), imm:0x1, result rd:x26(0x0000000000000000)
    li x6, MASK_XLEN(0x2000000)
    slti x26, x6, SEXT_IMM(0x1)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x0000000000000000)

    # Testcase 26:  rs1:x5(0x0000000004000000), imm:0xfff, result rd:x27(0x0000000000000000)
    li x5, MASK_XLEN(0x4000000)
    slti x27, x5, SEXT_IMM(0xfff)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x0000000000000000)

    # Testcase 27:  rs1:x4(0x0000000008000000), imm:0x7ff, result rd:x28(0x0000000000000000)
    li x4, MASK_XLEN(0x8000000)
    slti x28, x4, SEXT_IMM(0x7ff)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x0000000000000000)

    # Testcase 28:  rs1:x3(0x0000000010000000), imm:0xbff, result rd:x29(0x0000000000000000)
    li x3, MASK_XLEN(0x10000000)
    slti x29, x3, SEXT_IMM(0xbff)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x0000000000000000)

    # Testcase 29:  rs1:x2(0x0000000020000000), imm:0xdff, result rd:x30(0x0000000000000000)
    li x2, MASK_XLEN(0x20000000)
    slti x30, x2, SEXT_IMM(0xdff)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res


    # Testcase 30:  rs1:x1(0x0000000040000000), imm:0xeff, result rd:x31(0x0000000000000000)
    li x1, MASK_XLEN(0x40000000)
    slti x31, x1, SEXT_IMM(0xeff)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0000000000000000)

    # Testcase 31:  rs1:x31(0x0000000080000000), imm:0xf7f, result rd:x1(0x0000000000000000)
    li x31, MASK_XLEN(0x80000000)
    slti x1, x31, SEXT_IMM(0xf7f)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0000000000000000)

    # Testcase 32:  rs1:x30(0x0000000100000000), imm:0xfbf, result rd:x2(0x0000000000000000)
    li x30, MASK_XLEN(0x100000000)
    slti x2, x30, SEXT_IMM(0xfbf)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0000000000000000)

    # Testcase 33:  rs1:x29(0x0000000200000000), imm:0xfdf, result rd:x3(0x0000000000000000)
    li x29, MASK_XLEN(0x200000000)
    slti x3, x29, SEXT_IMM(0xfdf)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x0000000000000000)

    # Testcase 34:  rs1:x28(0x0000000400000000), imm:0xfef, result rd:x4(0x0000000000000000)
    li x28, MASK_XLEN(0x400000000)
    slti x4, x28, SEXT_IMM(0xfef)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rs1:x27(0x0000000800000000), imm:0xff7, result rd:x5(0x0000000000000000)
    li x27, MASK_XLEN(0x800000000)
    slti x5, x27, SEXT_IMM(0xff7)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0000000000000000)

    # Testcase 36:  rs1:x26(0x0000001000000000), imm:0xffb, result rd:x6(0x0000000000000000)
    li x26, MASK_XLEN(0x1000000000)
    slti x6, x26, SEXT_IMM(0xffb)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0000000000000000)

    # Testcase 37:  rs1:x25(0x0000002000000000), imm:0xffd, result rd:x7(0x0000000000000000)
    li x25, MASK_XLEN(0x2000000000)
    slti x7, x25, SEXT_IMM(0xffd)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000000000000)

    # Testcase 38:  rs1:x24(0x0000004000000000), imm:0xffe, result rd:x8(0x0000000000000000)
    li x24, MASK_XLEN(0x4000000000)
    slti x8, x24, SEXT_IMM(0xffe)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Testcase 39:  rs1:x23(0x0000008000000000), imm:0x0, result rd:x9(0x0000000000000000)
    li x23, MASK_XLEN(0x8000000000)
    slti x9, x23, SEXT_IMM(0x0)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rs1:x22(0x0000010000000000), imm:0x800, result rd:x10(0x0000000000000000)
    li x22, MASK_XLEN(0x10000000000)
    slti x10, x22, SEXT_IMM(0x800)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000000000000)

    # Testcase 41:  rs1:x21(0x0000020000000000), imm:0x400, result rd:x11(0x0000000000000000)
    li x21, MASK_XLEN(0x20000000000)
    slti x11, x21, SEXT_IMM(0x400)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0000000000000000)

    # Testcase 42:  rs1:x20(0x0000040000000000), imm:0x200, result rd:x12(0x0000000000000000)
    li x20, MASK_XLEN(0x40000000000)
    slti x12, x20, SEXT_IMM(0x200)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0000000000000000)

    # Testcase 43:  rs1:x19(0x0000080000000000), imm:0x100, result rd:x13(0x0000000000000000)
    li x19, MASK_XLEN(0x80000000000)
    slti x13, x19, SEXT_IMM(0x100)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0000000000000000)

    # Testcase 44:  rs1:x18(0x0000100000000000), imm:0x80, result rd:x14(0x0000000000000000)
    li x18, MASK_XLEN(0x100000000000)
    slti x14, x18, SEXT_IMM(0x80)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res


    # Testcase 45:  rs1:x17(0x0000200000000000), imm:0x40, result rd:x15(0x0000000000000000)
    li x17, MASK_XLEN(0x200000000000)
    slti x15, x17, SEXT_IMM(0x40)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x0000000000000000)

    # Testcase 46:  rs1:x16(0x0000400000000000), imm:0x20, result rd:x16(0x0000000000000000)
    li x16, MASK_XLEN(0x400000000000)
    slti x16, x16, SEXT_IMM(0x20)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x0000000000000000)

    # Testcase 47:  rs1:x15(0x0000800000000000), imm:0x10, result rd:x17(0x0000000000000000)
    li x15, MASK_XLEN(0x800000000000)
    slti x17, x15, SEXT_IMM(0x10)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x0000000000000000)

    # Testcase 48:  rs1:x14(0x0001000000000000), imm:0x8, result rd:x18(0x0000000000000000)
    li x14, MASK_XLEN(0x1000000000000)
    slti x18, x14, SEXT_IMM(0x8)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x0000000000000000)

    # Testcase 49:  rs1:x13(0x0002000000000000), imm:0x4, result rd:x19(0x0000000000000000)
    li x13, MASK_XLEN(0x2000000000000)
    slti x19, x13, SEXT_IMM(0x4)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rs1:x12(0x0004000000000000), imm:0x2, result rd:x20(0x0000000000000000)
    li x12, MASK_XLEN(0x4000000000000)
    slti x20, x12, SEXT_IMM(0x2)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0000000000000000)

    # Testcase 51:  rs1:x11(0x0008000000000000), imm:0x1, result rd:x21(0x0000000000000000)
    li x11, MASK_XLEN(0x8000000000000)
    slti x21, x11, SEXT_IMM(0x1)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000000000000000)

    # Testcase 52:  rs1:x10(0x0010000000000000), imm:0xfff, result rd:x22(0x0000000000000000)
    li x10, MASK_XLEN(0x10000000000000)
    slti x22, x10, SEXT_IMM(0xfff)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000000000000000)

    # Testcase 53:  rs1:x9(0x0020000000000000), imm:0x7ff, result rd:x23(0x0000000000000000)
    li x9, MASK_XLEN(0x20000000000000)
    slti x23, x9, SEXT_IMM(0x7ff)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000000000000000)

    # Testcase 54:  rs1:x8(0x0040000000000000), imm:0xbff, result rd:x24(0x0000000000000000)
    li x8, MASK_XLEN(0x40000000000000)
    slti x24, x8, SEXT_IMM(0xbff)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rs1:x7(0x0080000000000000), imm:0xdff, result rd:x25(0x0000000000000000)
    li x7, MASK_XLEN(0x80000000000000)
    slti x25, x7, SEXT_IMM(0xdff)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0000000000000000)

    # Testcase 56:  rs1:x6(0x0100000000000000), imm:0xeff, result rd:x26(0x0000000000000000)
    li x6, MASK_XLEN(0x100000000000000)
    slti x26, x6, SEXT_IMM(0xeff)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0000000000000000)

    # Testcase 57:  rs1:x5(0x0200000000000000), imm:0xf7f, result rd:x27(0x0000000000000000)
    li x5, MASK_XLEN(0x200000000000000)
    slti x27, x5, SEXT_IMM(0xf7f)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0000000000000000)

    # Testcase 58:  rs1:x4(0x0400000000000000), imm:0xfbf, result rd:x28(0x0000000000000000)
    li x4, MASK_XLEN(0x400000000000000)
    slti x28, x4, SEXT_IMM(0xfbf)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x0000000000000000)

    # Testcase 59:  rs1:x3(0x0800000000000000), imm:0xfdf, result rd:x29(0x0000000000000000)
    li x3, MASK_XLEN(0x800000000000000)
    slti x29, x3, SEXT_IMM(0xfdf)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res


    # Testcase 60:  rs1:x2(0x1000000000000000), imm:0xfef, result rd:x30(0x0000000000000000)
    li x2, MASK_XLEN(0x1000000000000000)
    slti x30, x2, SEXT_IMM(0xfef)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0000000000000000)

    # Testcase 61:  rs1:x1(0x2000000000000000), imm:0xff7, result rd:x31(0x0000000000000000)
    li x1, MASK_XLEN(0x2000000000000000)
    slti x31, x1, SEXT_IMM(0xff7)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0000000000000000)

    # Testcase 62:  rs1:x31(0x4000000000000000), imm:0xffb, result rd:x1(0x0000000000000000)
    li x31, MASK_XLEN(0x4000000000000000)
    slti x1, x31, SEXT_IMM(0xffb)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0000000000000000)

    # Testcase 63:  rs1:x30(0x8000000000000000), imm:0xffd, result rd:x2(0x0000000000000001)
    li x30, MASK_XLEN(0x8000000000000000)
    slti x2, x30, SEXT_IMM(0xffd)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0000000000000001)

    # Testcase 64:  rs1:x29(0x0000000000000000), imm:0xffe, result rd:x3(0x0000000000000000)
    li x29, MASK_XLEN(0x0)
    slti x3, x29, SEXT_IMM(0xffe)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rs1:x28(0xfffffffffffffffe), imm:0x0, result rd:x4(0x0000000000000001)
    li x28, MASK_XLEN(0xfffffffffffffffe)
    slti x4, x28, SEXT_IMM(0x0)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x0000000000000001)

    # Testcase 66:  rs1:x27(0xfffffffffffffffd), imm:0x800, result rd:x5(0x0000000000000000)
    li x27, MASK_XLEN(0xfffffffffffffffd)
    slti x5, x27, SEXT_IMM(0x800)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0000000000000000)

    # Testcase 67:  rs1:x26(0xfffffffffffffffb), imm:0x400, result rd:x6(0x0000000000000001)
    li x26, MASK_XLEN(0xfffffffffffffffb)
    slti x6, x26, SEXT_IMM(0x400)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0000000000000001)

    # Testcase 68:  rs1:x25(0xfffffffffffffff7), imm:0x200, result rd:x7(0x0000000000000001)
    li x25, MASK_XLEN(0xfffffffffffffff7)
    slti x7, x25, SEXT_IMM(0x200)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000000000001)

    # Testcase 69:  rs1:x24(0xffffffffffffffef), imm:0x100, result rd:x8(0x0000000000000001)
    li x24, MASK_XLEN(0xffffffffffffffef)
    slti x8, x24, SEXT_IMM(0x100)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rs1:x23(0xffffffffffffffdf), imm:0x80, result rd:x9(0x0000000000000001)
    li x23, MASK_XLEN(0xffffffffffffffdf)
    slti x9, x23, SEXT_IMM(0x80)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000001)

    # Testcase 71:  rs1:x22(0xffffffffffffffbf), imm:0x40, result rd:x10(0x0000000000000001)
    li x22, MASK_XLEN(0xffffffffffffffbf)
    slti x10, x22, SEXT_IMM(0x40)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000000000001)

    # Testcase 72:  rs1:x21(0xffffffffffffff7f), imm:0x20, result rd:x11(0x0000000000000001)
    li x21, MASK_XLEN(0xffffffffffffff7f)
    slti x11, x21, SEXT_IMM(0x20)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0000000000000001)

    # Testcase 73:  rs1:x20(0xfffffffffffffeff), imm:0x10, result rd:x12(0x0000000000000001)
    li x20, MASK_XLEN(0xfffffffffffffeff)
    slti x12, x20, SEXT_IMM(0x10)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0000000000000001)

    # Testcase 74:  rs1:x19(0xfffffffffffffdff), imm:0x8, result rd:x13(0x0000000000000001)
    li x19, MASK_XLEN(0xfffffffffffffdff)
    slti x13, x19, SEXT_IMM(0x8)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res


    # Testcase 75:  rs1:x18(0xfffffffffffffbff), imm:0x4, result rd:x14(0x0000000000000001)
    li x18, MASK_XLEN(0xfffffffffffffbff)
    slti x14, x18, SEXT_IMM(0x4)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x0000000000000001)

    # Testcase 76:  rs1:x17(0xfffffffffffff7ff), imm:0x2, result rd:x15(0x0000000000000001)
    li x17, MASK_XLEN(0xfffffffffffff7ff)
    slti x15, x17, SEXT_IMM(0x2)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0000000000000001)

    # Testcase 77:  rs1:x16(0xffffffffffffefff), imm:0x1, result rd:x16(0x0000000000000001)
    li x16, MASK_XLEN(0xffffffffffffefff)
    slti x16, x16, SEXT_IMM(0x1)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0000000000000001)

    # Testcase 78:  rs1:x15(0xffffffffffffdfff), imm:0xfff, result rd:x17(0x0000000000000001)
    li x15, MASK_XLEN(0xffffffffffffdfff)
    slti x17, x15, SEXT_IMM(0xfff)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x0000000000000001)

    # Testcase 79:  rs1:x14(0xffffffffffffbfff), imm:0x7ff, result rd:x18(0x0000000000000001)
    li x14, MASK_XLEN(0xffffffffffffbfff)
    slti x18, x14, SEXT_IMM(0x7ff)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rs1:x13(0xffffffffffff7fff), imm:0xbff, result rd:x19(0x0000000000000001)
    li x13, MASK_XLEN(0xffffffffffff7fff)
    slti x19, x13, SEXT_IMM(0xbff)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0000000000000001)

    # Testcase 81:  rs1:x12(0xfffffffffffeffff), imm:0xdff, result rd:x20(0x0000000000000001)
    li x12, MASK_XLEN(0xfffffffffffeffff)
    slti x20, x12, SEXT_IMM(0xdff)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0000000000000001)

    # Testcase 82:  rs1:x11(0xfffffffffffdffff), imm:0xeff, result rd:x21(0x0000000000000001)
    li x11, MASK_XLEN(0xfffffffffffdffff)
    slti x21, x11, SEXT_IMM(0xeff)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000000000000001)

    # Testcase 83:  rs1:x10(0xfffffffffffbffff), imm:0xf7f, result rd:x22(0x0000000000000001)
    li x10, MASK_XLEN(0xfffffffffffbffff)
    slti x22, x10, SEXT_IMM(0xf7f)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000000000000001)

    # Testcase 84:  rs1:x9(0xfffffffffff7ffff), imm:0xfbf, result rd:x23(0x0000000000000001)
    li x9, MASK_XLEN(0xfffffffffff7ffff)
    slti x23, x9, SEXT_IMM(0xfbf)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rs1:x8(0xffffffffffefffff), imm:0xfdf, result rd:x24(0x0000000000000001)
    li x8, MASK_XLEN(0xffffffffffefffff)
    slti x24, x8, SEXT_IMM(0xfdf)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0000000000000001)

    # Testcase 86:  rs1:x7(0xffffffffffdfffff), imm:0xfef, result rd:x25(0x0000000000000001)
    li x7, MASK_XLEN(0xffffffffffdfffff)
    slti x25, x7, SEXT_IMM(0xfef)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0000000000000001)

    # Testcase 87:  rs1:x6(0xffffffffffbfffff), imm:0xff7, result rd:x26(0x0000000000000001)
    li x6, MASK_XLEN(0xffffffffffbfffff)
    slti x26, x6, SEXT_IMM(0xff7)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0000000000000001)

    # Testcase 88:  rs1:x5(0xffffffffff7fffff), imm:0xffb, result rd:x27(0x0000000000000001)
    li x5, MASK_XLEN(0xffffffffff7fffff)
    slti x27, x5, SEXT_IMM(0xffb)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0000000000000001)

    # Testcase 89:  rs1:x4(0xfffffffffeffffff), imm:0xffd, result rd:x28(0x0000000000000001)
    li x4, MASK_XLEN(0xfffffffffeffffff)
    slti x28, x4, SEXT_IMM(0xffd)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res


    # Testcase 90:  rs1:x3(0xfffffffffdffffff), imm:0xffe, result rd:x29(0x0000000000000001)
    li x3, MASK_XLEN(0xfffffffffdffffff)
    slti x29, x3, SEXT_IMM(0xffe)
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x0000000000000001)

    # Testcase 91:  rs1:x2(0xfffffffffbffffff), imm:0x0, result rd:x30(0x0000000000000001)
    li x2, MASK_XLEN(0xfffffffffbffffff)
    slti x30, x2, SEXT_IMM(0x0)
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0000000000000001)

    # Testcase 92:  rs1:x1(0xfffffffff7ffffff), imm:0x800, result rd:x31(0x0000000000000001)
    li x1, MASK_XLEN(0xfffffffff7ffffff)
    slti x31, x1, SEXT_IMM(0x800)
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0000000000000001)

    # Testcase 93:  rs1:x31(0xffffffffefffffff), imm:0x400, result rd:x1(0x0000000000000001)
    li x31, MASK_XLEN(0xffffffffefffffff)
    slti x1, x31, SEXT_IMM(0x400)
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0000000000000001)

    # Testcase 94:  rs1:x30(0xffffffffdfffffff), imm:0x200, result rd:x2(0x0000000000000001)
    li x30, MASK_XLEN(0xffffffffdfffffff)
    slti x2, x30, SEXT_IMM(0x200)
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rs1:x29(0xffffffffbfffffff), imm:0x100, result rd:x3(0x0000000000000001)
    li x29, MASK_XLEN(0xffffffffbfffffff)
    slti x3, x29, SEXT_IMM(0x100)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000001)

    # Testcase 96:  rs1:x28(0xffffffff7fffffff), imm:0x80, result rd:x4(0x0000000000000001)
    li x28, MASK_XLEN(0xffffffff7fffffff)
    slti x4, x28, SEXT_IMM(0x80)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x0000000000000001)

    # Testcase 97:  rs1:x27(0xfffffffeffffffff), imm:0x40, result rd:x5(0x0000000000000001)
    li x27, MASK_XLEN(0xfffffffeffffffff)
    slti x5, x27, SEXT_IMM(0x40)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0000000000000001)

    # Testcase 98:  rs1:x26(0xfffffffdffffffff), imm:0x20, result rd:x6(0x0000000000000001)
    li x26, MASK_XLEN(0xfffffffdffffffff)
    slti x6, x26, SEXT_IMM(0x20)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0000000000000001)

    # Testcase 99:  rs1:x25(0xfffffffbffffffff), imm:0x10, result rd:x7(0x0000000000000001)
    li x25, MASK_XLEN(0xfffffffbffffffff)
    slti x7, x25, SEXT_IMM(0x10)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rs1:x24(0xfffffff7ffffffff), imm:0x8, result rd:x8(0x0000000000000001)
    li x24, MASK_XLEN(0xfffffff7ffffffff)
    slti x8, x24, SEXT_IMM(0x8)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000001)

    # Testcase 101:  rs1:x23(0xffffffefffffffff), imm:0x4, result rd:x9(0x0000000000000001)
    li x23, MASK_XLEN(0xffffffefffffffff)
    slti x9, x23, SEXT_IMM(0x4)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000001)

    # Testcase 102:  rs1:x22(0xffffffdfffffffff), imm:0x2, result rd:x10(0x0000000000000001)
    li x22, MASK_XLEN(0xffffffdfffffffff)
    slti x10, x22, SEXT_IMM(0x2)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000000000001)

    # Testcase 103:  rs1:x21(0xffffffbfffffffff), imm:0x1, result rd:x11(0x0000000000000001)
    li x21, MASK_XLEN(0xffffffbfffffffff)
    slti x11, x21, SEXT_IMM(0x1)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0000000000000001)

    # Testcase 104:  rs1:x20(0xffffff7fffffffff), imm:0xfff, result rd:x12(0x0000000000000001)
    li x20, MASK_XLEN(0xffffff7fffffffff)
    slti x12, x20, SEXT_IMM(0xfff)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res


    # Testcase 105:  rs1:x19(0xfffffeffffffffff), imm:0x7ff, result rd:x13(0x0000000000000001)
    li x19, MASK_XLEN(0xfffffeffffffffff)
    slti x13, x19, SEXT_IMM(0x7ff)
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x0000000000000001)

    # Testcase 106:  rs1:x18(0xfffffdffffffffff), imm:0xbff, result rd:x14(0x0000000000000001)
    li x18, MASK_XLEN(0xfffffdffffffffff)
    slti x14, x18, SEXT_IMM(0xbff)
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x0000000000000001)

    # Testcase 107:  rs1:x17(0xfffffbffffffffff), imm:0xdff, result rd:x15(0x0000000000000001)
    li x17, MASK_XLEN(0xfffffbffffffffff)
    slti x15, x17, SEXT_IMM(0xdff)
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x0000000000000001)

    # Testcase 108:  rs1:x16(0xfffff7ffffffffff), imm:0xeff, result rd:x16(0x0000000000000001)
    li x16, MASK_XLEN(0xfffff7ffffffffff)
    slti x16, x16, SEXT_IMM(0xeff)
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x0000000000000001)

    # Testcase 109:  rs1:x15(0xffffefffffffffff), imm:0xf7f, result rd:x17(0x0000000000000001)
    li x15, MASK_XLEN(0xffffefffffffffff)
    slti x17, x15, SEXT_IMM(0xf7f)
    sd x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rs1:x14(0xffffdfffffffffff), imm:0xfbf, result rd:x18(0x0000000000000001)
    li x14, MASK_XLEN(0xffffdfffffffffff)
    slti x18, x14, SEXT_IMM(0xfbf)
    sd x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x0000000000000001)

    # Testcase 111:  rs1:x13(0xffffbfffffffffff), imm:0xfdf, result rd:x19(0x0000000000000001)
    li x13, MASK_XLEN(0xffffbfffffffffff)
    slti x19, x13, SEXT_IMM(0xfdf)
    sd x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0000000000000001)

    # Testcase 112:  rs1:x12(0xffff7fffffffffff), imm:0xfef, result rd:x20(0x0000000000000001)
    li x12, MASK_XLEN(0xffff7fffffffffff)
    slti x20, x12, SEXT_IMM(0xfef)
    sd x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0000000000000001)

    # Testcase 113:  rs1:x11(0xfffeffffffffffff), imm:0xff7, result rd:x21(0x0000000000000001)
    li x11, MASK_XLEN(0xfffeffffffffffff)
    slti x21, x11, SEXT_IMM(0xff7)
    sd x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000000000000001)

    # Testcase 114:  rs1:x10(0xfffdffffffffffff), imm:0xffb, result rd:x22(0x0000000000000001)
    li x10, MASK_XLEN(0xfffdffffffffffff)
    slti x22, x10, SEXT_IMM(0xffb)
    sd x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rs1:x9(0xfffbffffffffffff), imm:0xffd, result rd:x23(0x0000000000000001)
    li x9, MASK_XLEN(0xfffbffffffffffff)
    slti x23, x9, SEXT_IMM(0xffd)
    sd x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000000000000001)

    # Testcase 116:  rs1:x8(0xfff7ffffffffffff), imm:0xffe, result rd:x24(0x0000000000000001)
    li x8, MASK_XLEN(0xfff7ffffffffffff)
    slti x24, x8, SEXT_IMM(0xffe)
    sd x24, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0000000000000001)

    # Testcase 117:  rs1:x7(0xffefffffffffffff), imm:0x0, result rd:x25(0x0000000000000001)
    li x7, MASK_XLEN(0xffefffffffffffff)
    slti x25, x7, SEXT_IMM(0x0)
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0000000000000001)

    # Testcase 118:  rs1:x6(0xffdfffffffffffff), imm:0x800, result rd:x26(0x0000000000000001)
    li x6, MASK_XLEN(0xffdfffffffffffff)
    slti x26, x6, SEXT_IMM(0x800)
    sd x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0000000000000001)

    # Testcase 119:  rs1:x5(0xffbfffffffffffff), imm:0x400, result rd:x27(0x0000000000000001)
    li x5, MASK_XLEN(0xffbfffffffffffff)
    slti x27, x5, SEXT_IMM(0x400)
    sd x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res


    # Testcase 120:  rs1:x4(0xff7fffffffffffff), imm:0x200, result rd:x28(0x0000000000000001)
    li x4, MASK_XLEN(0xff7fffffffffffff)
    slti x28, x4, SEXT_IMM(0x200)
    sd x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0x0000000000000001)

    # Testcase 121:  rs1:x3(0xfeffffffffffffff), imm:0x100, result rd:x29(0x0000000000000001)
    li x3, MASK_XLEN(0xfeffffffffffffff)
    slti x29, x3, SEXT_IMM(0x100)
    sd x29, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x0000000000000001)

    # Testcase 122:  rs1:x2(0xfdffffffffffffff), imm:0x80, result rd:x30(0x0000000000000001)
    li x2, MASK_XLEN(0xfdffffffffffffff)
    slti x30, x2, SEXT_IMM(0x80)
    sd x30, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x0000000000000001)

    # Testcase 123:  rs1:x1(0xfbffffffffffffff), imm:0x40, result rd:x31(0x0000000000000001)
    li x1, MASK_XLEN(0xfbffffffffffffff)
    slti x31, x1, SEXT_IMM(0x40)
    sd x31, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0000000000000001)

    # Testcase 124:  rs1:x31(0xf7ffffffffffffff), imm:0x20, result rd:x1(0x0000000000000001)
    li x31, MASK_XLEN(0xf7ffffffffffffff)
    slti x1, x31, SEXT_IMM(0x20)
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rs1:x30(0xefffffffffffffff), imm:0x10, result rd:x2(0x0000000000000001)
    li x30, MASK_XLEN(0xefffffffffffffff)
    slti x2, x30, SEXT_IMM(0x10)
    sd x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x0000000000000001)

    # Testcase 126:  rs1:x29(0xdfffffffffffffff), imm:0x8, result rd:x3(0x0000000000000001)
    li x29, MASK_XLEN(0xdfffffffffffffff)
    slti x3, x29, SEXT_IMM(0x8)
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0000000000000001)

    # Testcase 127:  rs1:x28(0xbfffffffffffffff), imm:0x4, result rd:x4(0x0000000000000001)
    li x28, MASK_XLEN(0xbfffffffffffffff)
    slti x4, x28, SEXT_IMM(0x4)
    sd x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x0000000000000001)

    # Testcase 128:  rs1:x27(0x7fffffffffffffff), imm:0x2, result rd:x5(0x0000000000000000)
    li x27, MASK_XLEN(0x7fffffffffffffff)
    slti x5, x27, SEXT_IMM(0x2)
    sd x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x0000000000000000)

    # Testcase 129:  rs1:x26(0xffffffffffffffff), imm:0x1, result rd:x6(0x0000000000000001)
    li x26, MASK_XLEN(0xffffffffffffffff)
    slti x6, x26, SEXT_IMM(0x1)
    sd x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rs1:x25(0x0000000000000001), imm:0x0, result rd:x7(0x0000000000000000)
    li x25, MASK_XLEN(0x1)
    slti x7, x25, SEXT_IMM(0x0)
    sd x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000000000000)

    # Testcase 131:  rs1:x24(0x0000000000000002), imm:0x0, result rd:x8(0x0000000000000000)
    li x24, MASK_XLEN(0x2)
    slti x8, x24, SEXT_IMM(0x0)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Testcase 132:  rs1:x23(0x0000000000000004), imm:0x0, result rd:x9(0x0000000000000000)
    li x23, MASK_XLEN(0x4)
    slti x9, x23, SEXT_IMM(0x0)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000000)

    # Testcase 133:  rs1:x22(0x0000000000000008), imm:0x0, result rd:x10(0x0000000000000000)
    li x22, MASK_XLEN(0x8)
    slti x10, x22, SEXT_IMM(0x0)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000000000000)

    # Testcase 134:  rs1:x21(0x0000000000000010), imm:0x0, result rd:x11(0x0000000000000000)
    li x21, MASK_XLEN(0x10)
    slti x11, x21, SEXT_IMM(0x0)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res


    # Testcase 135:  rs1:x20(0x0000000000000020), imm:0x0, result rd:x12(0x0000000000000000)
    li x20, MASK_XLEN(0x20)
    slti x12, x20, SEXT_IMM(0x0)
    sd x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x0000000000000000)

    # Testcase 136:  rs1:x19(0x0000000000000040), imm:0x0, result rd:x13(0x0000000000000000)
    li x19, MASK_XLEN(0x40)
    slti x13, x19, SEXT_IMM(0x0)
    sd x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0000000000000000)

    # Testcase 137:  rs1:x18(0x0000000000000080), imm:0x0, result rd:x14(0x0000000000000000)
    li x18, MASK_XLEN(0x80)
    slti x14, x18, SEXT_IMM(0x0)
    sd x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0000000000000000)

    # Testcase 138:  rs1:x17(0x0000000000000100), imm:0x0, result rd:x15(0x0000000000000000)
    li x17, MASK_XLEN(0x100)
    slti x15, x17, SEXT_IMM(0x0)
    sd x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0000000000000000)

    # Testcase 139:  rs1:x16(0x0000000000000200), imm:0x0, result rd:x16(0x0000000000000000)
    li x16, MASK_XLEN(0x200)
    slti x16, x16, SEXT_IMM(0x0)
    sd x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res


    # Testcase 140:  rs1:x15(0x0000000000000400), imm:0x0, result rd:x17(0x0000000000000000)
    li x15, MASK_XLEN(0x400)
    slti x17, x15, SEXT_IMM(0x0)
    sd x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x17, 0x0000000000000000)

    # Testcase 141:  rs1:x14(0x0000000000000800), imm:0x0, result rd:x18(0x0000000000000000)
    li x14, MASK_XLEN(0x800)
    slti x18, x14, SEXT_IMM(0x0)
    sd x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x0000000000000000)

    # Testcase 142:  rs1:x13(0x0000000000001000), imm:0x0, result rd:x19(0x0000000000000000)
    li x13, MASK_XLEN(0x1000)
    slti x19, x13, SEXT_IMM(0x0)
    sd x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0000000000000000)

    # Testcase 143:  rs1:x12(0x0000000000002000), imm:0x0, result rd:x20(0x0000000000000000)
    li x12, MASK_XLEN(0x2000)
    slti x20, x12, SEXT_IMM(0x0)
    sd x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0000000000000000)

    # Testcase 144:  rs1:x11(0x0000000000004000), imm:0x0, result rd:x21(0x0000000000000000)
    li x11, MASK_XLEN(0x4000)
    slti x21, x11, SEXT_IMM(0x0)
    sd x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res


    # Testcase 145:  rs1:x10(0x0000000000008000), imm:0x0, result rd:x22(0x0000000000000000)
    li x10, MASK_XLEN(0x8000)
    slti x22, x10, SEXT_IMM(0x0)
    sd x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000000000000000)

    # Testcase 146:  rs1:x9(0x0000000000010000), imm:0x0, result rd:x23(0x0000000000000000)
    li x9, MASK_XLEN(0x10000)
    slti x23, x9, SEXT_IMM(0x0)
    sd x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000000000000000)

    # Testcase 147:  rs1:x8(0x0000000000020000), imm:0x0, result rd:x24(0x0000000000000000)
    li x8, MASK_XLEN(0x20000)
    slti x24, x8, SEXT_IMM(0x0)
    sd x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0000000000000000)

    # Testcase 148:  rs1:x7(0x0000000000040000), imm:0x0, result rd:x25(0x0000000000000000)
    li x7, MASK_XLEN(0x40000)
    slti x25, x7, SEXT_IMM(0x0)
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0000000000000000)

    # Testcase 149:  rs1:x6(0x0000000000080000), imm:0x0, result rd:x26(0x0000000000000000)
    li x6, MASK_XLEN(0x80000)
    slti x26, x6, SEXT_IMM(0x0)
    sd x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x6, test_31_res


    # Testcase 150:  rs1:x5(0x0000000000100000), imm:0x0, result rd:x27(0x0000000000000000)
    li x5, MASK_XLEN(0x100000)
    slti x27, x5, SEXT_IMM(0x0)
    sd x27, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x0000000000000000)

    # Testcase 151:  rs1:x4(0x0000000000200000), imm:0x0, result rd:x28(0x0000000000000000)
    li x4, MASK_XLEN(0x200000)
    slti x28, x4, SEXT_IMM(0x0)
    sd x28, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x0000000000000000)

    # Testcase 152:  rs1:x3(0x0000000000400000), imm:0x0, result rd:x29(0x0000000000000000)
    li x3, MASK_XLEN(0x400000)
    slti x29, x3, SEXT_IMM(0x0)
    sd x29, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x0000000000000000)

    # Testcase 153:  rs1:x2(0x0000000000800000), imm:0x0, result rd:x30(0x0000000000000000)
    li x2, MASK_XLEN(0x800000)
    slti x30, x2, SEXT_IMM(0x0)
    sd x30, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x0000000000000000)

    # Testcase 154:  rs1:x1(0x0000000001000000), imm:0x0, result rd:x31(0x0000000000000000)
    li x1, MASK_XLEN(0x1000000)
    slti x31, x1, SEXT_IMM(0x0)
    sd x31, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x6, test_32_res


    # Testcase 155:  rs1:x31(0x0000000002000000), imm:0x0, result rd:x1(0x0000000000000000)
    li x31, MASK_XLEN(0x2000000)
    slti x1, x31, SEXT_IMM(0x0)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x0000000000000000)

    # Testcase 156:  rs1:x30(0x0000000004000000), imm:0x0, result rd:x2(0x0000000000000000)
    li x30, MASK_XLEN(0x4000000)
    slti x2, x30, SEXT_IMM(0x0)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x0000000000000000)

    # Testcase 157:  rs1:x29(0x0000000008000000), imm:0x0, result rd:x3(0x0000000000000000)
    li x29, MASK_XLEN(0x8000000)
    slti x3, x29, SEXT_IMM(0x0)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0000000000000000)

    # Testcase 158:  rs1:x28(0x0000000010000000), imm:0x0, result rd:x4(0x0000000000000000)
    li x28, MASK_XLEN(0x10000000)
    slti x4, x28, SEXT_IMM(0x0)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x0000000000000000)

    # Testcase 159:  rs1:x27(0x0000000020000000), imm:0x0, result rd:x5(0x0000000000000000)
    li x27, MASK_XLEN(0x20000000)
    slti x5, x27, SEXT_IMM(0x0)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res


    # Testcase 160:  rs1:x26(0x0000000040000000), imm:0x0, result rd:x6(0x0000000000000000)
    li x26, MASK_XLEN(0x40000000)
    slti x6, x26, SEXT_IMM(0x0)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0000000000000000)

    # Testcase 161:  rs1:x25(0x0000000080000000), imm:0x0, result rd:x7(0x0000000000000000)
    li x25, MASK_XLEN(0x80000000)
    slti x7, x25, SEXT_IMM(0x0)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000000000000)

    # Testcase 162:  rs1:x24(0x0000000100000000), imm:0x0, result rd:x8(0x0000000000000000)
    li x24, MASK_XLEN(0x100000000)
    slti x8, x24, SEXT_IMM(0x0)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000000)

    # Testcase 163:  rs1:x23(0x0000000200000000), imm:0x0, result rd:x9(0x0000000000000000)
    li x23, MASK_XLEN(0x200000000)
    slti x9, x23, SEXT_IMM(0x0)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000000)

    # Testcase 164:  rs1:x22(0x0000000400000000), imm:0x0, result rd:x10(0x0000000000000000)
    li x22, MASK_XLEN(0x400000000)
    slti x10, x22, SEXT_IMM(0x0)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res


    # Testcase 165:  rs1:x21(0x0000000800000000), imm:0x0, result rd:x11(0x0000000000000000)
    li x21, MASK_XLEN(0x800000000)
    slti x11, x21, SEXT_IMM(0x0)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x0000000000000000)

    # Testcase 166:  rs1:x20(0x0000001000000000), imm:0x0, result rd:x12(0x0000000000000000)
    li x20, MASK_XLEN(0x1000000000)
    slti x12, x20, SEXT_IMM(0x0)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x0000000000000000)

    # Testcase 167:  rs1:x19(0x0000002000000000), imm:0x0, result rd:x13(0x0000000000000000)
    li x19, MASK_XLEN(0x2000000000)
    slti x13, x19, SEXT_IMM(0x0)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0000000000000000)

    # Testcase 168:  rs1:x18(0x0000004000000000), imm:0x0, result rd:x14(0x0000000000000000)
    li x18, MASK_XLEN(0x4000000000)
    slti x14, x18, SEXT_IMM(0x0)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0000000000000000)

    # Testcase 169:  rs1:x17(0x0000008000000000), imm:0x0, result rd:x15(0x0000000000000000)
    li x17, MASK_XLEN(0x8000000000)
    slti x15, x17, SEXT_IMM(0x0)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x2, test_35_res


    # Testcase 170:  rs1:x16(0x0000010000000000), imm:0x0, result rd:x16(0x0000000000000000)
    li x16, MASK_XLEN(0x10000000000)
    slti x16, x16, SEXT_IMM(0x0)
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x0000000000000000)

    # Testcase 171:  rs1:x15(0x0000020000000000), imm:0x0, result rd:x17(0x0000000000000000)
    li x15, MASK_XLEN(0x20000000000)
    slti x17, x15, SEXT_IMM(0x0)
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x0000000000000000)

    # Testcase 172:  rs1:x14(0x0000040000000000), imm:0x0, result rd:x18(0x0000000000000000)
    li x14, MASK_XLEN(0x40000000000)
    slti x18, x14, SEXT_IMM(0x0)
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x0000000000000000)

    # Testcase 173:  rs1:x13(0x0000080000000000), imm:0x0, result rd:x19(0x0000000000000000)
    li x13, MASK_XLEN(0x80000000000)
    slti x19, x13, SEXT_IMM(0x0)
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x0000000000000000)

    # Testcase 174:  rs1:x12(0x0000100000000000), imm:0x0, result rd:x20(0x0000000000000000)
    li x12, MASK_XLEN(0x100000000000)
    slti x20, x12, SEXT_IMM(0x0)
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res


    # Testcase 175:  rs1:x11(0x0000200000000000), imm:0x0, result rd:x21(0x0000000000000000)
    li x11, MASK_XLEN(0x200000000000)
    slti x21, x11, SEXT_IMM(0x0)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000000000000000)

    # Testcase 176:  rs1:x10(0x0000400000000000), imm:0x0, result rd:x22(0x0000000000000000)
    li x10, MASK_XLEN(0x400000000000)
    slti x22, x10, SEXT_IMM(0x0)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000000000000000)

    # Testcase 177:  rs1:x9(0x0000800000000000), imm:0x0, result rd:x23(0x0000000000000000)
    li x9, MASK_XLEN(0x800000000000)
    slti x23, x9, SEXT_IMM(0x0)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000000000000000)

    # Testcase 178:  rs1:x8(0x0001000000000000), imm:0x0, result rd:x24(0x0000000000000000)
    li x8, MASK_XLEN(0x1000000000000)
    slti x24, x8, SEXT_IMM(0x0)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0000000000000000)

    # Testcase 179:  rs1:x7(0x0002000000000000), imm:0x0, result rd:x25(0x0000000000000000)
    li x7, MASK_XLEN(0x2000000000000)
    slti x25, x7, SEXT_IMM(0x0)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res


    # Testcase 180:  rs1:x6(0x0004000000000000), imm:0x0, result rd:x26(0x0000000000000000)
    li x6, MASK_XLEN(0x4000000000000)
    slti x26, x6, SEXT_IMM(0x0)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x0000000000000000)

    # Testcase 181:  rs1:x5(0x0008000000000000), imm:0x0, result rd:x27(0x0000000000000000)
    li x5, MASK_XLEN(0x8000000000000)
    slti x27, x5, SEXT_IMM(0x0)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x0000000000000000)

    # Testcase 182:  rs1:x4(0x0010000000000000), imm:0x0, result rd:x28(0x0000000000000000)
    li x4, MASK_XLEN(0x10000000000000)
    slti x28, x4, SEXT_IMM(0x0)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x0000000000000000)

    # Testcase 183:  rs1:x3(0x0020000000000000), imm:0x0, result rd:x29(0x0000000000000000)
    li x3, MASK_XLEN(0x20000000000000)
    slti x29, x3, SEXT_IMM(0x0)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x0000000000000000)

    # Testcase 184:  rs1:x2(0x0040000000000000), imm:0x0, result rd:x30(0x0000000000000000)
    li x2, MASK_XLEN(0x40000000000000)
    slti x30, x2, SEXT_IMM(0x0)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x5, test_38_res


    # Testcase 185:  rs1:x1(0x0080000000000000), imm:0x0, result rd:x31(0x0000000000000000)
    li x1, MASK_XLEN(0x80000000000000)
    slti x31, x1, SEXT_IMM(0x0)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0000000000000000)

    # Testcase 186:  rs1:x31(0x0100000000000000), imm:0x0, result rd:x1(0x0000000000000000)
    li x31, MASK_XLEN(0x100000000000000)
    slti x1, x31, SEXT_IMM(0x0)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0000000000000000)

    # Testcase 187:  rs1:x30(0x0200000000000000), imm:0x0, result rd:x2(0x0000000000000000)
    li x30, MASK_XLEN(0x200000000000000)
    slti x2, x30, SEXT_IMM(0x0)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0000000000000000)

    # Testcase 188:  rs1:x29(0x0400000000000000), imm:0x0, result rd:x3(0x0000000000000000)
    li x29, MASK_XLEN(0x400000000000000)
    slti x3, x29, SEXT_IMM(0x0)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x0000000000000000)

    # Testcase 189:  rs1:x28(0x0800000000000000), imm:0x0, result rd:x4(0x0000000000000000)
    li x28, MASK_XLEN(0x800000000000000)
    slti x4, x28, SEXT_IMM(0x0)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res


    # Testcase 190:  rs1:x27(0x1000000000000000), imm:0x0, result rd:x5(0x0000000000000000)
    li x27, MASK_XLEN(0x1000000000000000)
    slti x5, x27, SEXT_IMM(0x0)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0000000000000000)

    # Testcase 191:  rs1:x26(0x2000000000000000), imm:0x0, result rd:x6(0x0000000000000000)
    li x26, MASK_XLEN(0x2000000000000000)
    slti x6, x26, SEXT_IMM(0x0)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0000000000000000)

    # Testcase 192:  rs1:x25(0x4000000000000000), imm:0x0, result rd:x7(0x0000000000000000)
    li x25, MASK_XLEN(0x4000000000000000)
    slti x7, x25, SEXT_IMM(0x0)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000000000000)

    # Testcase 193:  rs1:x24(0x8000000000000000), imm:0x0, result rd:x8(0x0000000000000001)
    li x24, MASK_XLEN(0x8000000000000000)
    slti x8, x24, SEXT_IMM(0x0)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000001)

    # Testcase 194:  rs1:x23(0x0000000000000000), imm:0x0, result rd:x9(0x0000000000000000)
    li x23, MASK_XLEN(0x0)
    slti x9, x23, SEXT_IMM(0x0)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res


    # Testcase 195:  rs1:x22(0xfffffffffffffffe), imm:0x0, result rd:x10(0x0000000000000001)
    li x22, MASK_XLEN(0xfffffffffffffffe)
    slti x10, x22, SEXT_IMM(0x0)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000000000001)

    # Testcase 196:  rs1:x21(0xfffffffffffffffd), imm:0x0, result rd:x11(0x0000000000000001)
    li x21, MASK_XLEN(0xfffffffffffffffd)
    slti x11, x21, SEXT_IMM(0x0)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0000000000000001)

    # Testcase 197:  rs1:x20(0xfffffffffffffffb), imm:0x0, result rd:x12(0x0000000000000001)
    li x20, MASK_XLEN(0xfffffffffffffffb)
    slti x12, x20, SEXT_IMM(0x0)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0000000000000001)

    # Testcase 198:  rs1:x19(0xfffffffffffffff7), imm:0x0, result rd:x13(0x0000000000000001)
    li x19, MASK_XLEN(0xfffffffffffffff7)
    slti x13, x19, SEXT_IMM(0x0)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0000000000000001)

    # Testcase 199:  rs1:x18(0xffffffffffffffef), imm:0x0, result rd:x14(0x0000000000000001)
    li x18, MASK_XLEN(0xffffffffffffffef)
    slti x14, x18, SEXT_IMM(0x0)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x3, test_41_res


    # Testcase 200:  rs1:x17(0xffffffffffffffdf), imm:0x0, result rd:x15(0x0000000000000001)
    li x17, MASK_XLEN(0xffffffffffffffdf)
    slti x15, x17, SEXT_IMM(0x0)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x0000000000000001)

    # Testcase 201:  rs1:x16(0xffffffffffffffbf), imm:0x0, result rd:x16(0x0000000000000001)
    li x16, MASK_XLEN(0xffffffffffffffbf)
    slti x16, x16, SEXT_IMM(0x0)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x0000000000000001)

    # Testcase 202:  rs1:x15(0xffffffffffffff7f), imm:0x0, result rd:x17(0x0000000000000001)
    li x15, MASK_XLEN(0xffffffffffffff7f)
    slti x17, x15, SEXT_IMM(0x0)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x0000000000000001)

    # Testcase 203:  rs1:x14(0xfffffffffffffeff), imm:0x0, result rd:x18(0x0000000000000001)
    li x14, MASK_XLEN(0xfffffffffffffeff)
    slti x18, x14, SEXT_IMM(0x0)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x0000000000000001)

    # Testcase 204:  rs1:x13(0xfffffffffffffdff), imm:0x0, result rd:x19(0x0000000000000001)
    li x13, MASK_XLEN(0xfffffffffffffdff)
    slti x19, x13, SEXT_IMM(0x0)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res


    # Testcase 205:  rs1:x12(0xfffffffffffffbff), imm:0x0, result rd:x20(0x0000000000000001)
    li x12, MASK_XLEN(0xfffffffffffffbff)
    slti x20, x12, SEXT_IMM(0x0)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0000000000000001)

    # Testcase 206:  rs1:x11(0xfffffffffffff7ff), imm:0x0, result rd:x21(0x0000000000000001)
    li x11, MASK_XLEN(0xfffffffffffff7ff)
    slti x21, x11, SEXT_IMM(0x0)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000000000000001)

    # Testcase 207:  rs1:x10(0xffffffffffffefff), imm:0x0, result rd:x22(0x0000000000000001)
    li x10, MASK_XLEN(0xffffffffffffefff)
    slti x22, x10, SEXT_IMM(0x0)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000000000000001)

    # Testcase 208:  rs1:x9(0xffffffffffffdfff), imm:0x0, result rd:x23(0x0000000000000001)
    li x9, MASK_XLEN(0xffffffffffffdfff)
    slti x23, x9, SEXT_IMM(0x0)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000000000000001)

    # Testcase 209:  rs1:x8(0xffffffffffffbfff), imm:0x0, result rd:x24(0x0000000000000001)
    li x8, MASK_XLEN(0xffffffffffffbfff)
    slti x24, x8, SEXT_IMM(0x0)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res


    # Testcase 210:  rs1:x7(0xffffffffffff7fff), imm:0x0, result rd:x25(0x0000000000000001)
    li x7, MASK_XLEN(0xffffffffffff7fff)
    slti x25, x7, SEXT_IMM(0x0)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0000000000000001)

    # Testcase 211:  rs1:x6(0xfffffffffffeffff), imm:0x0, result rd:x26(0x0000000000000001)
    li x6, MASK_XLEN(0xfffffffffffeffff)
    slti x26, x6, SEXT_IMM(0x0)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0000000000000001)

    # Testcase 212:  rs1:x5(0xfffffffffffdffff), imm:0x0, result rd:x27(0x0000000000000001)
    li x5, MASK_XLEN(0xfffffffffffdffff)
    slti x27, x5, SEXT_IMM(0x0)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0000000000000001)

    # Testcase 213:  rs1:x4(0xfffffffffffbffff), imm:0x0, result rd:x28(0x0000000000000001)
    li x4, MASK_XLEN(0xfffffffffffbffff)
    slti x28, x4, SEXT_IMM(0x0)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x0000000000000001)

    # Testcase 214:  rs1:x3(0xfffffffffff7ffff), imm:0x0, result rd:x29(0x0000000000000001)
    li x3, MASK_XLEN(0xfffffffffff7ffff)
    slti x29, x3, SEXT_IMM(0x0)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x4, test_44_res


    # Testcase 215:  rs1:x2(0xffffffffffefffff), imm:0x0, result rd:x30(0x0000000000000001)
    li x2, MASK_XLEN(0xffffffffffefffff)
    slti x30, x2, SEXT_IMM(0x0)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0000000000000001)

    # Testcase 216:  rs1:x1(0xffffffffffdfffff), imm:0x0, result rd:x31(0x0000000000000001)
    li x1, MASK_XLEN(0xffffffffffdfffff)
    slti x31, x1, SEXT_IMM(0x0)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0000000000000001)

    # Testcase 217:  rs1:x31(0xffffffffffbfffff), imm:0x0, result rd:x1(0x0000000000000001)
    li x31, MASK_XLEN(0xffffffffffbfffff)
    slti x1, x31, SEXT_IMM(0x0)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0000000000000001)

    # Testcase 218:  rs1:x30(0xffffffffff7fffff), imm:0x0, result rd:x2(0x0000000000000001)
    li x30, MASK_XLEN(0xffffffffff7fffff)
    slti x2, x30, SEXT_IMM(0x0)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0000000000000001)

    # Testcase 219:  rs1:x29(0xfffffffffeffffff), imm:0x0, result rd:x3(0x0000000000000001)
    li x29, MASK_XLEN(0xfffffffffeffffff)
    slti x3, x29, SEXT_IMM(0x0)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res


    # Testcase 220:  rs1:x28(0xfffffffffdffffff), imm:0x0, result rd:x4(0x0000000000000001)
    li x28, MASK_XLEN(0xfffffffffdffffff)
    slti x4, x28, SEXT_IMM(0x0)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x0000000000000001)

    # Testcase 221:  rs1:x27(0xfffffffffbffffff), imm:0x0, result rd:x5(0x0000000000000001)
    li x27, MASK_XLEN(0xfffffffffbffffff)
    slti x5, x27, SEXT_IMM(0x0)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0000000000000001)

    # Testcase 222:  rs1:x26(0xfffffffff7ffffff), imm:0x0, result rd:x6(0x0000000000000001)
    li x26, MASK_XLEN(0xfffffffff7ffffff)
    slti x6, x26, SEXT_IMM(0x0)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0000000000000001)

    # Testcase 223:  rs1:x25(0xffffffffefffffff), imm:0x0, result rd:x7(0x0000000000000001)
    li x25, MASK_XLEN(0xffffffffefffffff)
    slti x7, x25, SEXT_IMM(0x0)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000000000001)

    # Testcase 224:  rs1:x24(0xffffffffdfffffff), imm:0x0, result rd:x8(0x0000000000000001)
    li x24, MASK_XLEN(0xffffffffdfffffff)
    slti x8, x24, SEXT_IMM(0x0)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res


    # Testcase 225:  rs1:x23(0xffffffffbfffffff), imm:0x0, result rd:x9(0x0000000000000001)
    li x23, MASK_XLEN(0xffffffffbfffffff)
    slti x9, x23, SEXT_IMM(0x0)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000001)

    # Testcase 226:  rs1:x22(0xffffffff7fffffff), imm:0x0, result rd:x10(0x0000000000000001)
    li x22, MASK_XLEN(0xffffffff7fffffff)
    slti x10, x22, SEXT_IMM(0x0)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000000000001)

    # Testcase 227:  rs1:x21(0xfffffffeffffffff), imm:0x0, result rd:x11(0x0000000000000001)
    li x21, MASK_XLEN(0xfffffffeffffffff)
    slti x11, x21, SEXT_IMM(0x0)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0000000000000001)

    # Testcase 228:  rs1:x20(0xfffffffdffffffff), imm:0x0, result rd:x12(0x0000000000000001)
    li x20, MASK_XLEN(0xfffffffdffffffff)
    slti x12, x20, SEXT_IMM(0x0)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0000000000000001)

    # Testcase 229:  rs1:x19(0xfffffffbffffffff), imm:0x0, result rd:x13(0x0000000000000001)
    li x19, MASK_XLEN(0xfffffffbffffffff)
    slti x13, x19, SEXT_IMM(0x0)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x4, test_47_res


    # Testcase 230:  rs1:x18(0xfffffff7ffffffff), imm:0x0, result rd:x14(0x0000000000000001)
    li x18, MASK_XLEN(0xfffffff7ffffffff)
    slti x14, x18, SEXT_IMM(0x0)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x0000000000000001)

    # Testcase 231:  rs1:x17(0xffffffefffffffff), imm:0x0, result rd:x15(0x0000000000000001)
    li x17, MASK_XLEN(0xffffffefffffffff)
    slti x15, x17, SEXT_IMM(0x0)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0000000000000001)

    # Testcase 232:  rs1:x16(0xffffffdfffffffff), imm:0x0, result rd:x16(0x0000000000000001)
    li x16, MASK_XLEN(0xffffffdfffffffff)
    slti x16, x16, SEXT_IMM(0x0)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0000000000000001)

    # Testcase 233:  rs1:x15(0xffffffbfffffffff), imm:0x0, result rd:x17(0x0000000000000001)
    li x15, MASK_XLEN(0xffffffbfffffffff)
    slti x17, x15, SEXT_IMM(0x0)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x0000000000000001)

    # Testcase 234:  rs1:x14(0xffffff7fffffffff), imm:0x0, result rd:x18(0x0000000000000001)
    li x14, MASK_XLEN(0xffffff7fffffffff)
    slti x18, x14, SEXT_IMM(0x0)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res


    # Testcase 235:  rs1:x13(0xfffffeffffffffff), imm:0x0, result rd:x19(0x0000000000000001)
    li x13, MASK_XLEN(0xfffffeffffffffff)
    slti x19, x13, SEXT_IMM(0x0)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0000000000000001)

    # Testcase 236:  rs1:x12(0xfffffdffffffffff), imm:0x0, result rd:x20(0x0000000000000001)
    li x12, MASK_XLEN(0xfffffdffffffffff)
    slti x20, x12, SEXT_IMM(0x0)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0000000000000001)

    # Testcase 237:  rs1:x11(0xfffffbffffffffff), imm:0x0, result rd:x21(0x0000000000000001)
    li x11, MASK_XLEN(0xfffffbffffffffff)
    slti x21, x11, SEXT_IMM(0x0)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000000000000001)

    # Testcase 238:  rs1:x10(0xfffff7ffffffffff), imm:0x0, result rd:x22(0x0000000000000001)
    li x10, MASK_XLEN(0xfffff7ffffffffff)
    slti x22, x10, SEXT_IMM(0x0)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000000000000001)

    # Testcase 239:  rs1:x9(0xffffefffffffffff), imm:0x0, result rd:x23(0x0000000000000001)
    li x9, MASK_XLEN(0xffffefffffffffff)
    slti x23, x9, SEXT_IMM(0x0)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res


    # Testcase 240:  rs1:x8(0xffffdfffffffffff), imm:0x0, result rd:x24(0x0000000000000001)
    li x8, MASK_XLEN(0xffffdfffffffffff)
    slti x24, x8, SEXT_IMM(0x0)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0000000000000001)

    # Testcase 241:  rs1:x7(0xffffbfffffffffff), imm:0x0, result rd:x25(0x0000000000000001)
    li x7, MASK_XLEN(0xffffbfffffffffff)
    slti x25, x7, SEXT_IMM(0x0)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0000000000000001)

    # Testcase 242:  rs1:x6(0xffff7fffffffffff), imm:0x0, result rd:x26(0x0000000000000001)
    li x6, MASK_XLEN(0xffff7fffffffffff)
    slti x26, x6, SEXT_IMM(0x0)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0000000000000001)

    # Testcase 243:  rs1:x5(0xfffeffffffffffff), imm:0x0, result rd:x27(0x0000000000000001)
    li x5, MASK_XLEN(0xfffeffffffffffff)
    slti x27, x5, SEXT_IMM(0x0)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0000000000000001)

    # Testcase 244:  rs1:x4(0xfffdffffffffffff), imm:0x0, result rd:x28(0x0000000000000001)
    li x4, MASK_XLEN(0xfffdffffffffffff)
    slti x28, x4, SEXT_IMM(0x0)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x4, test_50_res


    # Testcase 245:  rs1:x3(0xfffbffffffffffff), imm:0x0, result rd:x29(0x0000000000000001)
    li x3, MASK_XLEN(0xfffbffffffffffff)
    slti x29, x3, SEXT_IMM(0x0)
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x0000000000000001)

    # Testcase 246:  rs1:x2(0xfff7ffffffffffff), imm:0x0, result rd:x30(0x0000000000000001)
    li x2, MASK_XLEN(0xfff7ffffffffffff)
    slti x30, x2, SEXT_IMM(0x0)
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0000000000000001)

    # Testcase 247:  rs1:x1(0xffefffffffffffff), imm:0x0, result rd:x31(0x0000000000000001)
    li x1, MASK_XLEN(0xffefffffffffffff)
    slti x31, x1, SEXT_IMM(0x0)
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0000000000000001)

    # Testcase 248:  rs1:x31(0xffdfffffffffffff), imm:0x0, result rd:x1(0x0000000000000001)
    li x31, MASK_XLEN(0xffdfffffffffffff)
    slti x1, x31, SEXT_IMM(0x0)
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0000000000000001)

    # Testcase 249:  rs1:x30(0xffbfffffffffffff), imm:0x0, result rd:x2(0x0000000000000001)
    li x30, MASK_XLEN(0xffbfffffffffffff)
    slti x2, x30, SEXT_IMM(0x0)
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res


    # Testcase 250:  rs1:x29(0xff7fffffffffffff), imm:0x0, result rd:x3(0x0000000000000001)
    li x29, MASK_XLEN(0xff7fffffffffffff)
    slti x3, x29, SEXT_IMM(0x0)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000000000001)

    # Testcase 251:  rs1:x28(0xfeffffffffffffff), imm:0x0, result rd:x4(0x0000000000000001)
    li x28, MASK_XLEN(0xfeffffffffffffff)
    slti x4, x28, SEXT_IMM(0x0)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x0000000000000001)

    # Testcase 252:  rs1:x27(0xfdffffffffffffff), imm:0x0, result rd:x5(0x0000000000000001)
    li x27, MASK_XLEN(0xfdffffffffffffff)
    slti x5, x27, SEXT_IMM(0x0)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0000000000000001)

    # Testcase 253:  rs1:x26(0xfbffffffffffffff), imm:0x0, result rd:x6(0x0000000000000001)
    li x26, MASK_XLEN(0xfbffffffffffffff)
    slti x6, x26, SEXT_IMM(0x0)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0000000000000001)

    # Testcase 254:  rs1:x25(0xf7ffffffffffffff), imm:0x0, result rd:x7(0x0000000000000001)
    li x25, MASK_XLEN(0xf7ffffffffffffff)
    slti x7, x25, SEXT_IMM(0x0)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res


    # Testcase 255:  rs1:x24(0xefffffffffffffff), imm:0x0, result rd:x8(0x0000000000000001)
    li x24, MASK_XLEN(0xefffffffffffffff)
    slti x8, x24, SEXT_IMM(0x0)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000001)

    # Testcase 256:  rs1:x23(0xdfffffffffffffff), imm:0x0, result rd:x9(0x0000000000000001)
    li x23, MASK_XLEN(0xdfffffffffffffff)
    slti x9, x23, SEXT_IMM(0x0)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000001)

    # Testcase 257:  rs1:x22(0xbfffffffffffffff), imm:0x0, result rd:x10(0x0000000000000001)
    li x22, MASK_XLEN(0xbfffffffffffffff)
    slti x10, x22, SEXT_IMM(0x0)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000000000001)

    # Testcase 258:  rs1:x21(0x7fffffffffffffff), imm:0x0, result rd:x11(0x0000000000000000)
    li x21, MASK_XLEN(0x7fffffffffffffff)
    slti x11, x21, SEXT_IMM(0x0)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0000000000000000)

    # Testcase 259:  rs1:x20(0xffffffffffffffff), imm:0x0, result rd:x12(0x0000000000000001)
    li x20, MASK_XLEN(0xffffffffffffffff)
    slti x12, x20, SEXT_IMM(0x0)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0000000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x2, test_53_res


    # Testcase 260:  rs1:x19(0x0000000000000001), imm:0xfff, result rd:x13(0x0000000000000000)
    li x19, MASK_XLEN(0x1)
    slti x13, x19, SEXT_IMM(0xfff)
    sd x13, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x13, 0x0000000000000000)

    # Testcase 261:  rs1:x18(0x0000000000000002), imm:0x7ff, result rd:x0(0x0000000000000000)
    li x18, MASK_XLEN(0x2)
    slti x0, x18, SEXT_IMM(0x7ff)
    sd x0, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x0, 0x0000000000000000)

    # Testcase 262:  rs1:x17(0x0000000000000004), imm:0xbff, result rd:x15(0x0000000000000000)
    li x17, MASK_XLEN(0x4)
    slti x15, x17, SEXT_IMM(0xbff)
    sd x15, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0000000000000000)

    # Testcase 263:  rs1:x0(0x0000000000000008), imm:0xdff, result rd:x16(0x0000000000000000)
    li x0, MASK_XLEN(0x8)
    slti x16, x0, SEXT_IMM(0xdff)
    sd x16, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0000000000000000)


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

