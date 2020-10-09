# RISC-V Compliance Test I-C-LI-01
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
# Description: Testing instruction 'c.li'.

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


    # Testcase 0:  rd:x1(0x00000001), imm:0x1f, result rd:x1(0x0000001f)
    li x1, MASK_XLEN(0x1)
    c.li x1, SEXT_IMM(0x1f)
    sw x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x1f)

    # Testcase 1:  rd:x2(0x00000002), imm:0xf, result rd:x2(0x0000000f)
    li x2, MASK_XLEN(0x2)
    c.li x2, SEXT_IMM(0xf)
    sw x2, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xf)

    # Testcase 2:  rd:x3(0x00000004), imm:0x17, result rd:x3(0x00000017)
    li x3, MASK_XLEN(0x4)
    c.li x3, SEXT_IMM(0x17)
    sw x3, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x17)

    # Testcase 3:  rd:x4(0x00000008), imm:0x1b, result rd:x4(0x0000001b)
    li x4, MASK_XLEN(0x8)
    c.li x4, SEXT_IMM(0x1b)
    sw x4, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x1b)

    # Testcase 4:  rd:x5(0x00000010), imm:0x1d, result rd:x5(0x0000001d)
    li x5, MASK_XLEN(0x10)
    c.li x5, SEXT_IMM(0x1d)
    sw x5, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x1d)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rd:x6(0x00000020), imm:0x1e, result rd:x6(0x0000001e)
    li x6, MASK_XLEN(0x20)
    c.li x6, SEXT_IMM(0x1e)
    sw x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x1e)

    # Testcase 6:  rd:x7(0x00000040), imm:0x0, result rd:x7(0x00000000)
    li x7, MASK_XLEN(0x40)
    c.li x7, SEXT_IMM(0x0)
    sw x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0)

    # Testcase 7:  rd:x8(0x00000080), imm:0x10, result rd:x8(0x00000010)
    li x8, MASK_XLEN(0x80)
    c.li x8, SEXT_IMM(0x10)
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x10)

    # Testcase 8:  rd:x9(0x00000100), imm:0x8, result rd:x9(0x00000008)
    li x9, MASK_XLEN(0x100)
    c.li x9, SEXT_IMM(0x8)
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x8)

    # Testcase 9:  rd:x10(0x00000200), imm:0x4, result rd:x10(0x00000004)
    li x10, MASK_XLEN(0x200)
    c.li x10, SEXT_IMM(0x4)
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x4)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rd:x11(0x00000400), imm:0x2, result rd:x11(0x00000002)
    li x11, MASK_XLEN(0x400)
    c.li x11, SEXT_IMM(0x2)
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x2)

    # Testcase 11:  rd:x12(0x00000800), imm:0x1, result rd:x12(0x00000001)
    li x12, MASK_XLEN(0x800)
    c.li x12, SEXT_IMM(0x1)
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x1)

    # Testcase 12:  rd:x13(0x00001000), imm:0x1f, result rd:x13(0x0000001f)
    li x13, MASK_XLEN(0x1000)
    c.li x13, SEXT_IMM(0x1f)
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x1f)

    # Testcase 13:  rd:x14(0x00002000), imm:0xf, result rd:x14(0x0000000f)
    li x14, MASK_XLEN(0x2000)
    c.li x14, SEXT_IMM(0xf)
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xf)

    # Testcase 14:  rd:x15(0x00004000), imm:0x17, result rd:x15(0x00000017)
    li x15, MASK_XLEN(0x4000)
    c.li x15, SEXT_IMM(0x17)
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x17)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res


    # Testcase 15:  rd:x16(0x00008000), imm:0x1b, result rd:x16(0x0000001b)
    li x16, MASK_XLEN(0x8000)
    c.li x16, SEXT_IMM(0x1b)
    sw x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x1b)

    # Testcase 16:  rd:x17(0x00010000), imm:0x1d, result rd:x17(0x0000001d)
    li x17, MASK_XLEN(0x10000)
    c.li x17, SEXT_IMM(0x1d)
    sw x17, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x1d)

    # Testcase 17:  rd:x18(0x00020000), imm:0x1e, result rd:x18(0x0000001e)
    li x18, MASK_XLEN(0x20000)
    c.li x18, SEXT_IMM(0x1e)
    sw x18, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x1e)

    # Testcase 18:  rd:x19(0x00040000), imm:0x0, result rd:x19(0x00000000)
    li x19, MASK_XLEN(0x40000)
    c.li x19, SEXT_IMM(0x0)
    sw x19, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x0)

    # Testcase 19:  rd:x20(0x00080000), imm:0x10, result rd:x20(0x00000010)
    li x20, MASK_XLEN(0x80000)
    c.li x20, SEXT_IMM(0x10)
    sw x20, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x10)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rd:x21(0x00100000), imm:0x8, result rd:x21(0x00000008)
    li x21, MASK_XLEN(0x100000)
    c.li x21, SEXT_IMM(0x8)
    sw x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x8)

    # Testcase 21:  rd:x22(0x00200000), imm:0x4, result rd:x22(0x00000004)
    li x22, MASK_XLEN(0x200000)
    c.li x22, SEXT_IMM(0x4)
    sw x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x4)

    # Testcase 22:  rd:x23(0x00400000), imm:0x2, result rd:x23(0x00000002)
    li x23, MASK_XLEN(0x400000)
    c.li x23, SEXT_IMM(0x2)
    sw x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x2)

    # Testcase 23:  rd:x24(0x00800000), imm:0x1, result rd:x24(0x00000001)
    li x24, MASK_XLEN(0x800000)
    c.li x24, SEXT_IMM(0x1)
    sw x24, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x1)

    # Testcase 24:  rd:x25(0x01000000), imm:0x1f, result rd:x25(0x0000001f)
    li x25, MASK_XLEN(0x1000000)
    c.li x25, SEXT_IMM(0x1f)
    sw x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x1f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rd:x26(0x02000000), imm:0xf, result rd:x26(0x0000000f)
    li x26, MASK_XLEN(0x2000000)
    c.li x26, SEXT_IMM(0xf)
    sw x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0xf)

    # Testcase 26:  rd:x27(0x04000000), imm:0x17, result rd:x27(0x00000017)
    li x27, MASK_XLEN(0x4000000)
    c.li x27, SEXT_IMM(0x17)
    sw x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x17)

    # Testcase 27:  rd:x28(0x08000000), imm:0x1b, result rd:x28(0x0000001b)
    li x28, MASK_XLEN(0x8000000)
    c.li x28, SEXT_IMM(0x1b)
    sw x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x1b)

    # Testcase 28:  rd:x29(0x10000000), imm:0x1d, result rd:x29(0x0000001d)
    li x29, MASK_XLEN(0x10000000)
    c.li x29, SEXT_IMM(0x1d)
    sw x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x1d)

    # Testcase 29:  rd:x30(0x20000000), imm:0x1e, result rd:x30(0x0000001e)
    li x30, MASK_XLEN(0x20000000)
    c.li x30, SEXT_IMM(0x1e)
    sw x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x1e)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res


    # Testcase 30:  rd:x31(0x40000000), imm:0x0, result rd:x31(0x00000000)
    li x31, MASK_XLEN(0x40000000)
    c.li x31, SEXT_IMM(0x0)
    sw x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0)

    # Testcase 31:  rd:x1(0x80000000), imm:0x10, result rd:x1(0x00000010)
    li x1, MASK_XLEN(0x80000000)
    c.li x1, SEXT_IMM(0x10)
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x10)

    # Testcase 32:  rd:x2(0x00000000), imm:0x8, result rd:x2(0x00000008)
    li x2, MASK_XLEN(0x0)
    c.li x2, SEXT_IMM(0x8)
    sw x2, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x8)

    # Testcase 33:  rd:x3(0xfffffffe), imm:0x4, result rd:x3(0x00000004)
    li x3, MASK_XLEN(0xfffffffe)
    c.li x3, SEXT_IMM(0x4)
    sw x3, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x4)

    # Testcase 34:  rd:x4(0xfffffffd), imm:0x2, result rd:x4(0x00000002)
    li x4, MASK_XLEN(0xfffffffd)
    c.li x4, SEXT_IMM(0x2)
    sw x4, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x2)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rd:x5(0xfffffffb), imm:0x1, result rd:x5(0x00000001)
    li x5, MASK_XLEN(0xfffffffb)
    c.li x5, SEXT_IMM(0x1)
    sw x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x1)

    # Testcase 36:  rd:x6(0xfffffff7), imm:0x1f, result rd:x6(0x0000001f)
    li x6, MASK_XLEN(0xfffffff7)
    c.li x6, SEXT_IMM(0x1f)
    sw x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x1f)

    # Testcase 37:  rd:x7(0xffffffef), imm:0xf, result rd:x7(0x0000000f)
    li x7, MASK_XLEN(0xffffffef)
    c.li x7, SEXT_IMM(0xf)
    sw x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xf)

    # Testcase 38:  rd:x8(0xffffffdf), imm:0x17, result rd:x8(0x00000017)
    li x8, MASK_XLEN(0xffffffdf)
    c.li x8, SEXT_IMM(0x17)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x17)

    # Testcase 39:  rd:x9(0xffffffbf), imm:0x1b, result rd:x9(0x0000001b)
    li x9, MASK_XLEN(0xffffffbf)
    c.li x9, SEXT_IMM(0x1b)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1b)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rd:x10(0xffffff7f), imm:0x1d, result rd:x10(0x0000001d)
    li x10, MASK_XLEN(0xffffff7f)
    c.li x10, SEXT_IMM(0x1d)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1d)

    # Testcase 41:  rd:x11(0xfffffeff), imm:0x1e, result rd:x11(0x0000001e)
    li x11, MASK_XLEN(0xfffffeff)
    c.li x11, SEXT_IMM(0x1e)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1e)

    # Testcase 42:  rd:x12(0xfffffdff), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xfffffdff)
    c.li x12, SEXT_IMM(0x0)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 43:  rd:x13(0xfffffbff), imm:0x10, result rd:x13(0x00000010)
    li x13, MASK_XLEN(0xfffffbff)
    c.li x13, SEXT_IMM(0x10)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x10)

    # Testcase 44:  rd:x14(0xfffff7ff), imm:0x8, result rd:x14(0x00000008)
    li x14, MASK_XLEN(0xfffff7ff)
    c.li x14, SEXT_IMM(0x8)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res


    # Testcase 45:  rd:x15(0xffffefff), imm:0x4, result rd:x15(0x00000004)
    li x15, MASK_XLEN(0xffffefff)
    c.li x15, SEXT_IMM(0x4)
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x4)

    # Testcase 46:  rd:x16(0xffffdfff), imm:0x2, result rd:x16(0x00000002)
    li x16, MASK_XLEN(0xffffdfff)
    c.li x16, SEXT_IMM(0x2)
    sw x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x2)

    # Testcase 47:  rd:x17(0xffffbfff), imm:0x1, result rd:x17(0x00000001)
    li x17, MASK_XLEN(0xffffbfff)
    c.li x17, SEXT_IMM(0x1)
    sw x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x1)

    # Testcase 48:  rd:x18(0xffff7fff), imm:0x1f, result rd:x18(0x0000001f)
    li x18, MASK_XLEN(0xffff7fff)
    c.li x18, SEXT_IMM(0x1f)
    sw x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x1f)

    # Testcase 49:  rd:x19(0xfffeffff), imm:0xf, result rd:x19(0x0000000f)
    li x19, MASK_XLEN(0xfffeffff)
    c.li x19, SEXT_IMM(0xf)
    sw x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xf)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rd:x20(0xfffdffff), imm:0x17, result rd:x20(0x00000017)
    li x20, MASK_XLEN(0xfffdffff)
    c.li x20, SEXT_IMM(0x17)
    sw x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x17)

    # Testcase 51:  rd:x21(0xfffbffff), imm:0x1b, result rd:x21(0x0000001b)
    li x21, MASK_XLEN(0xfffbffff)
    c.li x21, SEXT_IMM(0x1b)
    sw x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x1b)

    # Testcase 52:  rd:x22(0xfff7ffff), imm:0x1d, result rd:x22(0x0000001d)
    li x22, MASK_XLEN(0xfff7ffff)
    c.li x22, SEXT_IMM(0x1d)
    sw x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x1d)

    # Testcase 53:  rd:x23(0xffefffff), imm:0x1e, result rd:x23(0x0000001e)
    li x23, MASK_XLEN(0xffefffff)
    c.li x23, SEXT_IMM(0x1e)
    sw x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x1e)

    # Testcase 54:  rd:x24(0xffdfffff), imm:0x0, result rd:x24(0x00000000)
    li x24, MASK_XLEN(0xffdfffff)
    c.li x24, SEXT_IMM(0x0)
    sw x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rd:x25(0xffbfffff), imm:0x10, result rd:x25(0x00000010)
    li x25, MASK_XLEN(0xffbfffff)
    c.li x25, SEXT_IMM(0x10)
    sw x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x10)

    # Testcase 56:  rd:x26(0xff7fffff), imm:0x8, result rd:x26(0x00000008)
    li x26, MASK_XLEN(0xff7fffff)
    c.li x26, SEXT_IMM(0x8)
    sw x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x8)

    # Testcase 57:  rd:x27(0xfeffffff), imm:0x4, result rd:x27(0x00000004)
    li x27, MASK_XLEN(0xfeffffff)
    c.li x27, SEXT_IMM(0x4)
    sw x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x4)

    # Testcase 58:  rd:x28(0xfdffffff), imm:0x2, result rd:x28(0x00000002)
    li x28, MASK_XLEN(0xfdffffff)
    c.li x28, SEXT_IMM(0x2)
    sw x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x2)

    # Testcase 59:  rd:x29(0xfbffffff), imm:0x1, result rd:x29(0x00000001)
    li x29, MASK_XLEN(0xfbffffff)
    c.li x29, SEXT_IMM(0x1)
    sw x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x1)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res


    # Testcase 60:  rd:x30(0xf7ffffff), imm:0x1f, result rd:x30(0x0000001f)
    li x30, MASK_XLEN(0xf7ffffff)
    c.li x30, SEXT_IMM(0x1f)
    sw x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x1f)

    # Testcase 61:  rd:x31(0xefffffff), imm:0xf, result rd:x31(0x0000000f)
    li x31, MASK_XLEN(0xefffffff)
    c.li x31, SEXT_IMM(0xf)
    sw x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xf)

    # Testcase 62:  rd:x1(0xdfffffff), imm:0x17, result rd:x1(0x00000017)
    li x1, MASK_XLEN(0xdfffffff)
    c.li x1, SEXT_IMM(0x17)
    sw x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x17)

    # Testcase 63:  rd:x2(0xbfffffff), imm:0x1b, result rd:x2(0x0000001b)
    li x2, MASK_XLEN(0xbfffffff)
    c.li x2, SEXT_IMM(0x1b)
    sw x2, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x1b)

    # Testcase 64:  rd:x3(0x7fffffff), imm:0x1d, result rd:x3(0x0000001d)
    li x3, MASK_XLEN(0x7fffffff)
    c.li x3, SEXT_IMM(0x1d)
    sw x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x1d)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rd:x4(0xffffffff), imm:0x1e, result rd:x4(0x0000001e)
    li x4, MASK_XLEN(0xffffffff)
    c.li x4, SEXT_IMM(0x1e)
    sw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x1e)

    # Testcase 66:  rd:x5(0x00000001), imm:0x0, result rd:x5(0x00000000)
    li x5, MASK_XLEN(0x1)
    c.li x5, SEXT_IMM(0x0)
    sw x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0)

    # Testcase 67:  rd:x6(0x00000002), imm:0x0, result rd:x6(0x00000000)
    li x6, MASK_XLEN(0x2)
    c.li x6, SEXT_IMM(0x0)
    sw x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0)

    # Testcase 68:  rd:x7(0x00000004), imm:0x0, result rd:x7(0x00000000)
    li x7, MASK_XLEN(0x4)
    c.li x7, SEXT_IMM(0x0)
    sw x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0)

    # Testcase 69:  rd:x8(0x00000008), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x8)
    c.li x8, SEXT_IMM(0x0)
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rd:x9(0x00000010), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x10)
    c.li x9, SEXT_IMM(0x0)
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 71:  rd:x10(0x00000020), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x20)
    c.li x10, SEXT_IMM(0x0)
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 72:  rd:x11(0x00000040), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x40)
    c.li x11, SEXT_IMM(0x0)
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 73:  rd:x12(0x00000080), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x80)
    c.li x12, SEXT_IMM(0x0)
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 74:  rd:x13(0x00000100), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x100)
    c.li x13, SEXT_IMM(0x0)
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res


    # Testcase 75:  rd:x14(0x00000200), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x200)
    c.li x14, SEXT_IMM(0x0)
    sw x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x0)

    # Testcase 76:  rd:x15(0x00000400), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x400)
    c.li x15, SEXT_IMM(0x0)
    sw x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0)

    # Testcase 77:  rd:x16(0x00000800), imm:0x0, result rd:x16(0x00000000)
    li x16, MASK_XLEN(0x800)
    c.li x16, SEXT_IMM(0x0)
    sw x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0)

    # Testcase 78:  rd:x17(0x00001000), imm:0x0, result rd:x17(0x00000000)
    li x17, MASK_XLEN(0x1000)
    c.li x17, SEXT_IMM(0x0)
    sw x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x0)

    # Testcase 79:  rd:x18(0x00002000), imm:0x0, result rd:x18(0x00000000)
    li x18, MASK_XLEN(0x2000)
    c.li x18, SEXT_IMM(0x0)
    sw x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rd:x19(0x00004000), imm:0x0, result rd:x19(0x00000000)
    li x19, MASK_XLEN(0x4000)
    c.li x19, SEXT_IMM(0x0)
    sw x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0)

    # Testcase 81:  rd:x20(0x00008000), imm:0x0, result rd:x20(0x00000000)
    li x20, MASK_XLEN(0x8000)
    c.li x20, SEXT_IMM(0x0)
    sw x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0)

    # Testcase 82:  rd:x21(0x00010000), imm:0x0, result rd:x21(0x00000000)
    li x21, MASK_XLEN(0x10000)
    c.li x21, SEXT_IMM(0x0)
    sw x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0)

    # Testcase 83:  rd:x22(0x00020000), imm:0x0, result rd:x22(0x00000000)
    li x22, MASK_XLEN(0x20000)
    c.li x22, SEXT_IMM(0x0)
    sw x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0)

    # Testcase 84:  rd:x23(0x00040000), imm:0x0, result rd:x23(0x00000000)
    li x23, MASK_XLEN(0x40000)
    c.li x23, SEXT_IMM(0x0)
    sw x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rd:x24(0x00080000), imm:0x0, result rd:x24(0x00000000)
    li x24, MASK_XLEN(0x80000)
    c.li x24, SEXT_IMM(0x0)
    sw x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0)

    # Testcase 86:  rd:x25(0x00100000), imm:0x0, result rd:x25(0x00000000)
    li x25, MASK_XLEN(0x100000)
    c.li x25, SEXT_IMM(0x0)
    sw x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0)

    # Testcase 87:  rd:x26(0x00200000), imm:0x0, result rd:x26(0x00000000)
    li x26, MASK_XLEN(0x200000)
    c.li x26, SEXT_IMM(0x0)
    sw x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0)

    # Testcase 88:  rd:x27(0x00400000), imm:0x0, result rd:x27(0x00000000)
    li x27, MASK_XLEN(0x400000)
    c.li x27, SEXT_IMM(0x0)
    sw x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0)

    # Testcase 89:  rd:x28(0x00800000), imm:0x0, result rd:x28(0x00000000)
    li x28, MASK_XLEN(0x800000)
    c.li x28, SEXT_IMM(0x0)
    sw x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res


    # Testcase 90:  rd:x29(0x01000000), imm:0x0, result rd:x29(0x00000000)
    li x29, MASK_XLEN(0x1000000)
    c.li x29, SEXT_IMM(0x0)
    sw x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x0)

    # Testcase 91:  rd:x30(0x02000000), imm:0x0, result rd:x30(0x00000000)
    li x30, MASK_XLEN(0x2000000)
    c.li x30, SEXT_IMM(0x0)
    sw x30, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0)

    # Testcase 92:  rd:x31(0x04000000), imm:0x0, result rd:x31(0x00000000)
    li x31, MASK_XLEN(0x4000000)
    c.li x31, SEXT_IMM(0x0)
    sw x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0)

    # Testcase 93:  rd:x1(0x08000000), imm:0x0, result rd:x1(0x00000000)
    li x1, MASK_XLEN(0x8000000)
    c.li x1, SEXT_IMM(0x0)
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0)

    # Testcase 94:  rd:x2(0x10000000), imm:0x0, result rd:x2(0x00000000)
    li x2, MASK_XLEN(0x10000000)
    c.li x2, SEXT_IMM(0x0)
    sw x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rd:x3(0x20000000), imm:0x0, result rd:x3(0x00000000)
    li x3, MASK_XLEN(0x20000000)
    c.li x3, SEXT_IMM(0x0)
    sw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0)

    # Testcase 96:  rd:x4(0x40000000), imm:0x0, result rd:x4(0x00000000)
    li x4, MASK_XLEN(0x40000000)
    c.li x4, SEXT_IMM(0x0)
    sw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x0)

    # Testcase 97:  rd:x5(0x80000000), imm:0x0, result rd:x5(0x00000000)
    li x5, MASK_XLEN(0x80000000)
    c.li x5, SEXT_IMM(0x0)
    sw x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0)

    # Testcase 98:  rd:x6(0x00000000), imm:0x0, result rd:x6(0x00000000)
    li x6, MASK_XLEN(0x0)
    c.li x6, SEXT_IMM(0x0)
    sw x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0)

    # Testcase 99:  rd:x7(0xfffffffe), imm:0x0, result rd:x7(0x00000000)
    li x7, MASK_XLEN(0xfffffffe)
    c.li x7, SEXT_IMM(0x0)
    sw x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rd:x8(0xfffffffd), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xfffffffd)
    c.li x8, SEXT_IMM(0x0)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 101:  rd:x9(0xfffffffb), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0xfffffffb)
    c.li x9, SEXT_IMM(0x0)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 102:  rd:x10(0xfffffff7), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xfffffff7)
    c.li x10, SEXT_IMM(0x0)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 103:  rd:x11(0xffffffef), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0xffffffef)
    c.li x11, SEXT_IMM(0x0)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 104:  rd:x12(0xffffffdf), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xffffffdf)
    c.li x12, SEXT_IMM(0x0)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res


    # Testcase 105:  rd:x13(0xffffffbf), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0xffffffbf)
    c.li x13, SEXT_IMM(0x0)
    sw x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x0)

    # Testcase 106:  rd:x14(0xffffff7f), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xffffff7f)
    c.li x14, SEXT_IMM(0x0)
    sw x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x0)

    # Testcase 107:  rd:x15(0xfffffeff), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0xfffffeff)
    c.li x15, SEXT_IMM(0x0)
    sw x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x0)

    # Testcase 108:  rd:x16(0xfffffdff), imm:0x0, result rd:x16(0x00000000)
    li x16, MASK_XLEN(0xfffffdff)
    c.li x16, SEXT_IMM(0x0)
    sw x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x0)

    # Testcase 109:  rd:x17(0xfffffbff), imm:0x0, result rd:x17(0x00000000)
    li x17, MASK_XLEN(0xfffffbff)
    c.li x17, SEXT_IMM(0x0)
    sw x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rd:x18(0xfffff7ff), imm:0x0, result rd:x18(0x00000000)
    li x18, MASK_XLEN(0xfffff7ff)
    c.li x18, SEXT_IMM(0x0)
    sw x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x0)

    # Testcase 111:  rd:x19(0xffffefff), imm:0x0, result rd:x19(0x00000000)
    li x19, MASK_XLEN(0xffffefff)
    c.li x19, SEXT_IMM(0x0)
    sw x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0)

    # Testcase 112:  rd:x20(0xffffdfff), imm:0x0, result rd:x20(0x00000000)
    li x20, MASK_XLEN(0xffffdfff)
    c.li x20, SEXT_IMM(0x0)
    sw x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0)

    # Testcase 113:  rd:x21(0xffffbfff), imm:0x0, result rd:x21(0x00000000)
    li x21, MASK_XLEN(0xffffbfff)
    c.li x21, SEXT_IMM(0x0)
    sw x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0)

    # Testcase 114:  rd:x22(0xffff7fff), imm:0x0, result rd:x22(0x00000000)
    li x22, MASK_XLEN(0xffff7fff)
    c.li x22, SEXT_IMM(0x0)
    sw x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rd:x23(0xfffeffff), imm:0x0, result rd:x23(0x00000000)
    li x23, MASK_XLEN(0xfffeffff)
    c.li x23, SEXT_IMM(0x0)
    sw x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0)

    # Testcase 116:  rd:x24(0xfffdffff), imm:0x0, result rd:x24(0x00000000)
    li x24, MASK_XLEN(0xfffdffff)
    c.li x24, SEXT_IMM(0x0)
    sw x24, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0)

    # Testcase 117:  rd:x25(0xfffbffff), imm:0x0, result rd:x25(0x00000000)
    li x25, MASK_XLEN(0xfffbffff)
    c.li x25, SEXT_IMM(0x0)
    sw x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0)

    # Testcase 118:  rd:x26(0xfff7ffff), imm:0x0, result rd:x26(0x00000000)
    li x26, MASK_XLEN(0xfff7ffff)
    c.li x26, SEXT_IMM(0x0)
    sw x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0)

    # Testcase 119:  rd:x27(0xffefffff), imm:0x0, result rd:x27(0x00000000)
    li x27, MASK_XLEN(0xffefffff)
    c.li x27, SEXT_IMM(0x0)
    sw x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res


    # Testcase 120:  rd:x28(0xffdfffff), imm:0x0, result rd:x28(0x00000000)
    li x28, MASK_XLEN(0xffdfffff)
    c.li x28, SEXT_IMM(0x0)
    sw x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0x0)

    # Testcase 121:  rd:x29(0xffbfffff), imm:0x0, result rd:x29(0x00000000)
    li x29, MASK_XLEN(0xffbfffff)
    c.li x29, SEXT_IMM(0x0)
    sw x29, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x0)

    # Testcase 122:  rd:x30(0xff7fffff), imm:0x0, result rd:x30(0x00000000)
    li x30, MASK_XLEN(0xff7fffff)
    c.li x30, SEXT_IMM(0x0)
    sw x30, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x0)

    # Testcase 123:  rd:x31(0xfeffffff), imm:0x0, result rd:x31(0x00000000)
    li x31, MASK_XLEN(0xfeffffff)
    c.li x31, SEXT_IMM(0x0)
    sw x31, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0)

    # Testcase 124:  rd:x1(0xfdffffff), imm:0x0, result rd:x1(0x00000000)
    li x1, MASK_XLEN(0xfdffffff)
    c.li x1, SEXT_IMM(0x0)
    sw x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rd:x2(0xfbffffff), imm:0x0, result rd:x2(0x00000000)
    li x2, MASK_XLEN(0xfbffffff)
    c.li x2, SEXT_IMM(0x0)
    sw x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x0)

    # Testcase 126:  rd:x3(0xf7ffffff), imm:0x0, result rd:x3(0x00000000)
    li x3, MASK_XLEN(0xf7ffffff)
    c.li x3, SEXT_IMM(0x0)
    sw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0)

    # Testcase 127:  rd:x4(0xefffffff), imm:0x0, result rd:x4(0x00000000)
    li x4, MASK_XLEN(0xefffffff)
    c.li x4, SEXT_IMM(0x0)
    sw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x0)

    # Testcase 128:  rd:x5(0xdfffffff), imm:0x0, result rd:x5(0x00000000)
    li x5, MASK_XLEN(0xdfffffff)
    c.li x5, SEXT_IMM(0x0)
    sw x5, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x0)

    # Testcase 129:  rd:x6(0xbfffffff), imm:0x0, result rd:x6(0x00000000)
    li x6, MASK_XLEN(0xbfffffff)
    c.li x6, SEXT_IMM(0x0)
    sw x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rd:x7(0x7fffffff), imm:0x0, result rd:x7(0x00000000)
    li x7, MASK_XLEN(0x7fffffff)
    c.li x7, SEXT_IMM(0x0)
    sw x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0)

    # Testcase 131:  rd:x8(0xffffffff), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xffffffff)
    c.li x8, SEXT_IMM(0x0)
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 132:  rd:x9(0x00000001), imm:0x1f, result rd:x9(0x0000001f)
    li x9, MASK_XLEN(0x1)
    c.li x9, SEXT_IMM(0x1f)
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1f)

    # Testcase 133:  rd:x10(0x00000002), imm:0xf, result rd:x10(0x0000000f)
    li x10, MASK_XLEN(0x2)
    c.li x10, SEXT_IMM(0xf)
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xf)

    # Testcase 134:  rd:x11(0x00000004), imm:0x17, result rd:x11(0x00000017)
    li x11, MASK_XLEN(0x4)
    c.li x11, SEXT_IMM(0x17)
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x17)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res


    # Testcase 135:  rd:x12(0x00000008), imm:0x1b, result rd:x12(0x0000001b)
    li x12, MASK_XLEN(0x8)
    c.li x12, SEXT_IMM(0x1b)
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1b)


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

