# RISC-V Compliance Test I-C-SLLI-01
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
# Description: Testing instruction 'c.slli'.

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


    # Testcase 0:  rd:x1(0x00000001), imm:0x1f, result rd:x1(0x80000000)
    li x1, MASK_XLEN(0x1)
    c.slli x1, 0x1f
    sw x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x80000000)

    # Testcase 1:  rd:x2(0x00000002), imm:0xf, result rd:x2(0x00010000)
    li x2, MASK_XLEN(0x2)
    c.slli x2, 0xf
    sw x2, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x10000)

    # Testcase 2:  rd:x3(0x00000004), imm:0x17, result rd:x3(0x02000000)
    li x3, MASK_XLEN(0x4)
    c.slli x3, 0x17
    sw x3, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x2000000)

    # Testcase 3:  rd:x4(0x00000008), imm:0x1b, result rd:x4(0x40000000)
    li x4, MASK_XLEN(0x8)
    c.slli x4, 0x1b
    sw x4, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x40000000)

    # Testcase 4:  rd:x5(0x00000010), imm:0x1d, result rd:x5(0x00000000)
    li x5, MASK_XLEN(0x10)
    c.slli x5, 0x1d
    sw x5, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rd:x6(0x00000020), imm:0x1e, result rd:x6(0x00000000)
    li x6, MASK_XLEN(0x20)
    c.slli x6, 0x1e
    sw x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0)

    # Testcase 6:  rd:x7(0x00000040), imm:0x1, result rd:x7(0x00000080)
    li x7, MASK_XLEN(0x40)
    c.slli x7, 0x1
    sw x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x80)

    # Testcase 7:  rd:x8(0x00000080), imm:0x10, result rd:x8(0x00800000)
    li x8, MASK_XLEN(0x80)
    c.slli x8, 0x10
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x800000)

    # Testcase 8:  rd:x9(0x00000100), imm:0x8, result rd:x9(0x00010000)
    li x9, MASK_XLEN(0x100)
    c.slli x9, 0x8
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x10000)

    # Testcase 9:  rd:x10(0x00000200), imm:0x4, result rd:x10(0x00002000)
    li x10, MASK_XLEN(0x200)
    c.slli x10, 0x4
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x2000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rd:x11(0x00000400), imm:0x2, result rd:x11(0x00001000)
    li x11, MASK_XLEN(0x400)
    c.slli x11, 0x2
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x1000)

    # Testcase 11:  rd:x12(0x00000800), imm:0x1, result rd:x12(0x00001000)
    li x12, MASK_XLEN(0x800)
    c.slli x12, 0x1
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x1000)

    # Testcase 12:  rd:x13(0x00001000), imm:0x1f, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x1000)
    c.slli x13, 0x1f
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0)

    # Testcase 13:  rd:x14(0x00002000), imm:0xf, result rd:x14(0x10000000)
    li x14, MASK_XLEN(0x2000)
    c.slli x14, 0xf
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x10000000)

    # Testcase 14:  rd:x15(0x00004000), imm:0x17, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x4000)
    c.slli x15, 0x17
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res


    # Testcase 15:  rd:x16(0x00008000), imm:0x1b, result rd:x16(0x00000000)
    li x16, MASK_XLEN(0x8000)
    c.slli x16, 0x1b
    sw x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x0)

    # Testcase 16:  rd:x17(0x00010000), imm:0x1d, result rd:x17(0x00000000)
    li x17, MASK_XLEN(0x10000)
    c.slli x17, 0x1d
    sw x17, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x0)

    # Testcase 17:  rd:x18(0x00020000), imm:0x1e, result rd:x18(0x00000000)
    li x18, MASK_XLEN(0x20000)
    c.slli x18, 0x1e
    sw x18, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x0)

    # Testcase 18:  rd:x19(0x00040000), imm:0x1, result rd:x19(0x00080000)
    li x19, MASK_XLEN(0x40000)
    c.slli x19, 0x1
    sw x19, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x80000)

    # Testcase 19:  rd:x20(0x00080000), imm:0x10, result rd:x20(0x00000000)
    li x20, MASK_XLEN(0x80000)
    c.slli x20, 0x10
    sw x20, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rd:x21(0x00100000), imm:0x8, result rd:x21(0x10000000)
    li x21, MASK_XLEN(0x100000)
    c.slli x21, 0x8
    sw x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x10000000)

    # Testcase 21:  rd:x22(0x00200000), imm:0x4, result rd:x22(0x02000000)
    li x22, MASK_XLEN(0x200000)
    c.slli x22, 0x4
    sw x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x2000000)

    # Testcase 22:  rd:x23(0x00400000), imm:0x2, result rd:x23(0x01000000)
    li x23, MASK_XLEN(0x400000)
    c.slli x23, 0x2
    sw x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x1000000)

    # Testcase 23:  rd:x24(0x00800000), imm:0x1, result rd:x24(0x01000000)
    li x24, MASK_XLEN(0x800000)
    c.slli x24, 0x1
    sw x24, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x1000000)

    # Testcase 24:  rd:x25(0x01000000), imm:0x1f, result rd:x25(0x00000000)
    li x25, MASK_XLEN(0x1000000)
    c.slli x25, 0x1f
    sw x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rd:x26(0x02000000), imm:0xf, result rd:x26(0x00000000)
    li x26, MASK_XLEN(0x2000000)
    c.slli x26, 0xf
    sw x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x0)

    # Testcase 26:  rd:x27(0x04000000), imm:0x17, result rd:x27(0x00000000)
    li x27, MASK_XLEN(0x4000000)
    c.slli x27, 0x17
    sw x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x0)

    # Testcase 27:  rd:x28(0x08000000), imm:0x1b, result rd:x28(0x00000000)
    li x28, MASK_XLEN(0x8000000)
    c.slli x28, 0x1b
    sw x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x0)

    # Testcase 28:  rd:x29(0x10000000), imm:0x1d, result rd:x29(0x00000000)
    li x29, MASK_XLEN(0x10000000)
    c.slli x29, 0x1d
    sw x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x0)

    # Testcase 29:  rd:x30(0x20000000), imm:0x1e, result rd:x30(0x00000000)
    li x30, MASK_XLEN(0x20000000)
    c.slli x30, 0x1e
    sw x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res


    # Testcase 30:  rd:x31(0x40000000), imm:0x1, result rd:x31(0x80000000)
    li x31, MASK_XLEN(0x40000000)
    c.slli x31, 0x1
    sw x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x80000000)

    # Testcase 31:  rd:x1(0x80000000), imm:0x10, result rd:x1(0x00000000)
    li x1, MASK_XLEN(0x80000000)
    c.slli x1, 0x10
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0)

    # Testcase 32:  rd:x2(0x00000000), imm:0x8, result rd:x2(0x00000000)
    li x2, MASK_XLEN(0x0)
    c.slli x2, 0x8
    sw x2, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0)

    # Testcase 33:  rd:x3(0xfffffffe), imm:0x4, result rd:x3(0xffffffe0)
    li x3, MASK_XLEN(0xfffffffe)
    c.slli x3, 0x4
    sw x3, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0xffffffe0)

    # Testcase 34:  rd:x4(0xfffffffd), imm:0x2, result rd:x4(0xfffffff4)
    li x4, MASK_XLEN(0xfffffffd)
    c.slli x4, 0x2
    sw x4, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0xfffffff4)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rd:x5(0xfffffffb), imm:0x1, result rd:x5(0xfffffff6)
    li x5, MASK_XLEN(0xfffffffb)
    c.slli x5, 0x1
    sw x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffff6)

    # Testcase 36:  rd:x6(0xfffffff7), imm:0x1f, result rd:x6(0x80000000)
    li x6, MASK_XLEN(0xfffffff7)
    c.slli x6, 0x1f
    sw x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x80000000)

    # Testcase 37:  rd:x7(0xffffffef), imm:0xf, result rd:x7(0xfff78000)
    li x7, MASK_XLEN(0xffffffef)
    c.slli x7, 0xf
    sw x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfff78000)

    # Testcase 38:  rd:x8(0xffffffdf), imm:0x17, result rd:x8(0xef800000)
    li x8, MASK_XLEN(0xffffffdf)
    c.slli x8, 0x17
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xef800000)

    # Testcase 39:  rd:x9(0xffffffbf), imm:0x1b, result rd:x9(0xf8000000)
    li x9, MASK_XLEN(0xffffffbf)
    c.slli x9, 0x1b
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xf8000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rd:x10(0xffffff7f), imm:0x1d, result rd:x10(0xe0000000)
    li x10, MASK_XLEN(0xffffff7f)
    c.slli x10, 0x1d
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xe0000000)

    # Testcase 41:  rd:x11(0xfffffeff), imm:0x1e, result rd:x11(0xc0000000)
    li x11, MASK_XLEN(0xfffffeff)
    c.slli x11, 0x1e
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xc0000000)

    # Testcase 42:  rd:x12(0xfffffdff), imm:0x1, result rd:x12(0xfffffbfe)
    li x12, MASK_XLEN(0xfffffdff)
    c.slli x12, 0x1
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffbfe)

    # Testcase 43:  rd:x13(0xfffffbff), imm:0x10, result rd:x13(0xfbff0000)
    li x13, MASK_XLEN(0xfffffbff)
    c.slli x13, 0x10
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfbff0000)

    # Testcase 44:  rd:x14(0xfffff7ff), imm:0x8, result rd:x14(0xfff7ff00)
    li x14, MASK_XLEN(0xfffff7ff)
    c.slli x14, 0x8
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfff7ff00)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res


    # Testcase 45:  rd:x15(0xffffefff), imm:0x4, result rd:x15(0xfffefff0)
    li x15, MASK_XLEN(0xffffefff)
    c.slli x15, 0x4
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0xfffefff0)

    # Testcase 46:  rd:x16(0xffffdfff), imm:0x2, result rd:x16(0xffff7ffc)
    li x16, MASK_XLEN(0xffffdfff)
    c.slli x16, 0x2
    sw x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0xffff7ffc)

    # Testcase 47:  rd:x17(0xffffbfff), imm:0x1, result rd:x17(0xffff7ffe)
    li x17, MASK_XLEN(0xffffbfff)
    c.slli x17, 0x1
    sw x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xffff7ffe)

    # Testcase 48:  rd:x18(0xffff7fff), imm:0x1f, result rd:x18(0x80000000)
    li x18, MASK_XLEN(0xffff7fff)
    c.slli x18, 0x1f
    sw x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x80000000)

    # Testcase 49:  rd:x19(0xfffeffff), imm:0xf, result rd:x19(0x7fff8000)
    li x19, MASK_XLEN(0xfffeffff)
    c.slli x19, 0xf
    sw x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x7fff8000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rd:x20(0xfffdffff), imm:0x17, result rd:x20(0xff800000)
    li x20, MASK_XLEN(0xfffdffff)
    c.slli x20, 0x17
    sw x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xff800000)

    # Testcase 51:  rd:x21(0xfffbffff), imm:0x1b, result rd:x21(0xf8000000)
    li x21, MASK_XLEN(0xfffbffff)
    c.slli x21, 0x1b
    sw x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xf8000000)

    # Testcase 52:  rd:x22(0xfff7ffff), imm:0x1d, result rd:x22(0xe0000000)
    li x22, MASK_XLEN(0xfff7ffff)
    c.slli x22, 0x1d
    sw x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xe0000000)

    # Testcase 53:  rd:x23(0xffefffff), imm:0x1e, result rd:x23(0xc0000000)
    li x23, MASK_XLEN(0xffefffff)
    c.slli x23, 0x1e
    sw x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xc0000000)

    # Testcase 54:  rd:x24(0xffdfffff), imm:0x1, result rd:x24(0xffbffffe)
    li x24, MASK_XLEN(0xffdfffff)
    c.slli x24, 0x1
    sw x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffbffffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rd:x25(0xffbfffff), imm:0x10, result rd:x25(0xffff0000)
    li x25, MASK_XLEN(0xffbfffff)
    c.slli x25, 0x10
    sw x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffff0000)

    # Testcase 56:  rd:x26(0xff7fffff), imm:0x8, result rd:x26(0x7fffff00)
    li x26, MASK_XLEN(0xff7fffff)
    c.slli x26, 0x8
    sw x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x7fffff00)

    # Testcase 57:  rd:x27(0xfeffffff), imm:0x4, result rd:x27(0xeffffff0)
    li x27, MASK_XLEN(0xfeffffff)
    c.slli x27, 0x4
    sw x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xeffffff0)

    # Testcase 58:  rd:x28(0xfdffffff), imm:0x2, result rd:x28(0xf7fffffc)
    li x28, MASK_XLEN(0xfdffffff)
    c.slli x28, 0x2
    sw x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xf7fffffc)

    # Testcase 59:  rd:x29(0xfbffffff), imm:0x1, result rd:x29(0xf7fffffe)
    li x29, MASK_XLEN(0xfbffffff)
    c.slli x29, 0x1
    sw x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xf7fffffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res


    # Testcase 60:  rd:x30(0xf7ffffff), imm:0x1f, result rd:x30(0x80000000)
    li x30, MASK_XLEN(0xf7ffffff)
    c.slli x30, 0x1f
    sw x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x80000000)

    # Testcase 61:  rd:x31(0xefffffff), imm:0xf, result rd:x31(0xffff8000)
    li x31, MASK_XLEN(0xefffffff)
    c.slli x31, 0xf
    sw x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xffff8000)

    # Testcase 62:  rd:x1(0xdfffffff), imm:0x17, result rd:x1(0xff800000)
    li x1, MASK_XLEN(0xdfffffff)
    c.slli x1, 0x17
    sw x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xff800000)

    # Testcase 63:  rd:x2(0xbfffffff), imm:0x1b, result rd:x2(0xf8000000)
    li x2, MASK_XLEN(0xbfffffff)
    c.slli x2, 0x1b
    sw x2, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xf8000000)

    # Testcase 64:  rd:x3(0x7fffffff), imm:0x1d, result rd:x3(0xe0000000)
    li x3, MASK_XLEN(0x7fffffff)
    c.slli x3, 0x1d
    sw x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xe0000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rd:x4(0xffffffff), imm:0x1e, result rd:x4(0xc0000000)
    li x4, MASK_XLEN(0xffffffff)
    c.slli x4, 0x1e
    sw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xc0000000)

    # Testcase 66:  rd:x5(0x00000001), imm:0x1, result rd:x5(0x00000002)
    li x5, MASK_XLEN(0x1)
    c.slli x5, 0x1
    sw x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x2)

    # Testcase 67:  rd:x6(0x00000002), imm:0x1, result rd:x6(0x00000004)
    li x6, MASK_XLEN(0x2)
    c.slli x6, 0x1
    sw x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x4)

    # Testcase 68:  rd:x7(0x00000004), imm:0x1, result rd:x7(0x00000008)
    li x7, MASK_XLEN(0x4)
    c.slli x7, 0x1
    sw x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x8)

    # Testcase 69:  rd:x8(0x00000008), imm:0x1, result rd:x8(0x00000010)
    li x8, MASK_XLEN(0x8)
    c.slli x8, 0x1
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x10)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rd:x9(0x00000010), imm:0x1, result rd:x9(0x00000020)
    li x9, MASK_XLEN(0x10)
    c.slli x9, 0x1
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20)

    # Testcase 71:  rd:x10(0x00000020), imm:0x1, result rd:x10(0x00000040)
    li x10, MASK_XLEN(0x20)
    c.slli x10, 0x1
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x40)

    # Testcase 72:  rd:x11(0x00000040), imm:0x1, result rd:x11(0x00000080)
    li x11, MASK_XLEN(0x40)
    c.slli x11, 0x1
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x80)

    # Testcase 73:  rd:x12(0x00000080), imm:0x1, result rd:x12(0x00000100)
    li x12, MASK_XLEN(0x80)
    c.slli x12, 0x1
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x100)

    # Testcase 74:  rd:x13(0x00000100), imm:0x1, result rd:x13(0x00000200)
    li x13, MASK_XLEN(0x100)
    c.slli x13, 0x1
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x200)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res


    # Testcase 75:  rd:x14(0x00000200), imm:0x1, result rd:x14(0x00000400)
    li x14, MASK_XLEN(0x200)
    c.slli x14, 0x1
    sw x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x400)

    # Testcase 76:  rd:x15(0x00000400), imm:0x1, result rd:x15(0x00000800)
    li x15, MASK_XLEN(0x400)
    c.slli x15, 0x1
    sw x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x800)

    # Testcase 77:  rd:x16(0x00000800), imm:0x1, result rd:x16(0x00001000)
    li x16, MASK_XLEN(0x800)
    c.slli x16, 0x1
    sw x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x1000)

    # Testcase 78:  rd:x17(0x00001000), imm:0x1, result rd:x17(0x00002000)
    li x17, MASK_XLEN(0x1000)
    c.slli x17, 0x1
    sw x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x2000)

    # Testcase 79:  rd:x18(0x00002000), imm:0x1, result rd:x18(0x00004000)
    li x18, MASK_XLEN(0x2000)
    c.slli x18, 0x1
    sw x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x4000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rd:x19(0x00004000), imm:0x1, result rd:x19(0x00008000)
    li x19, MASK_XLEN(0x4000)
    c.slli x19, 0x1
    sw x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x8000)

    # Testcase 81:  rd:x20(0x00008000), imm:0x1, result rd:x20(0x00010000)
    li x20, MASK_XLEN(0x8000)
    c.slli x20, 0x1
    sw x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x10000)

    # Testcase 82:  rd:x21(0x00010000), imm:0x1, result rd:x21(0x00020000)
    li x21, MASK_XLEN(0x10000)
    c.slli x21, 0x1
    sw x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x20000)

    # Testcase 83:  rd:x22(0x00020000), imm:0x1, result rd:x22(0x00040000)
    li x22, MASK_XLEN(0x20000)
    c.slli x22, 0x1
    sw x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x40000)

    # Testcase 84:  rd:x23(0x00040000), imm:0x1, result rd:x23(0x00080000)
    li x23, MASK_XLEN(0x40000)
    c.slli x23, 0x1
    sw x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x80000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rd:x24(0x00080000), imm:0x1, result rd:x24(0x00100000)
    li x24, MASK_XLEN(0x80000)
    c.slli x24, 0x1
    sw x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x100000)

    # Testcase 86:  rd:x25(0x00100000), imm:0x1, result rd:x25(0x00200000)
    li x25, MASK_XLEN(0x100000)
    c.slli x25, 0x1
    sw x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x200000)

    # Testcase 87:  rd:x26(0x00200000), imm:0x1, result rd:x26(0x00400000)
    li x26, MASK_XLEN(0x200000)
    c.slli x26, 0x1
    sw x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x400000)

    # Testcase 88:  rd:x27(0x00400000), imm:0x1, result rd:x27(0x00800000)
    li x27, MASK_XLEN(0x400000)
    c.slli x27, 0x1
    sw x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x800000)

    # Testcase 89:  rd:x28(0x00800000), imm:0x1, result rd:x28(0x01000000)
    li x28, MASK_XLEN(0x800000)
    c.slli x28, 0x1
    sw x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x1000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res


    # Testcase 90:  rd:x29(0x01000000), imm:0x1, result rd:x29(0x02000000)
    li x29, MASK_XLEN(0x1000000)
    c.slli x29, 0x1
    sw x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x2000000)

    # Testcase 91:  rd:x30(0x02000000), imm:0x1, result rd:x30(0x04000000)
    li x30, MASK_XLEN(0x2000000)
    c.slli x30, 0x1
    sw x30, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x4000000)

    # Testcase 92:  rd:x31(0x04000000), imm:0x1, result rd:x31(0x08000000)
    li x31, MASK_XLEN(0x4000000)
    c.slli x31, 0x1
    sw x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x8000000)

    # Testcase 93:  rd:x1(0x08000000), imm:0x1, result rd:x1(0x10000000)
    li x1, MASK_XLEN(0x8000000)
    c.slli x1, 0x1
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x10000000)

    # Testcase 94:  rd:x2(0x10000000), imm:0x1, result rd:x2(0x20000000)
    li x2, MASK_XLEN(0x10000000)
    c.slli x2, 0x1
    sw x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x20000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rd:x3(0x20000000), imm:0x1, result rd:x3(0x40000000)
    li x3, MASK_XLEN(0x20000000)
    c.slli x3, 0x1
    sw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x40000000)

    # Testcase 96:  rd:x4(0x40000000), imm:0x1, result rd:x4(0x80000000)
    li x4, MASK_XLEN(0x40000000)
    c.slli x4, 0x1
    sw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x80000000)

    # Testcase 97:  rd:x5(0x80000000), imm:0x1, result rd:x5(0x00000000)
    li x5, MASK_XLEN(0x80000000)
    c.slli x5, 0x1
    sw x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0)

    # Testcase 98:  rd:x6(0x00000000), imm:0x1, result rd:x6(0x00000000)
    li x6, MASK_XLEN(0x0)
    c.slli x6, 0x1
    sw x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0)

    # Testcase 99:  rd:x7(0xfffffffe), imm:0x1, result rd:x7(0xfffffffc)
    li x7, MASK_XLEN(0xfffffffe)
    c.slli x7, 0x1
    sw x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffc)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rd:x8(0xfffffffd), imm:0x1, result rd:x8(0xfffffffa)
    li x8, MASK_XLEN(0xfffffffd)
    c.slli x8, 0x1
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffa)

    # Testcase 101:  rd:x9(0xfffffffb), imm:0x1, result rd:x9(0xfffffff6)
    li x9, MASK_XLEN(0xfffffffb)
    c.slli x9, 0x1
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffff6)

    # Testcase 102:  rd:x10(0xfffffff7), imm:0x1, result rd:x10(0xffffffee)
    li x10, MASK_XLEN(0xfffffff7)
    c.slli x10, 0x1
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffee)

    # Testcase 103:  rd:x11(0xffffffef), imm:0x1, result rd:x11(0xffffffde)
    li x11, MASK_XLEN(0xffffffef)
    c.slli x11, 0x1
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffde)

    # Testcase 104:  rd:x12(0xffffffdf), imm:0x1, result rd:x12(0xffffffbe)
    li x12, MASK_XLEN(0xffffffdf)
    c.slli x12, 0x1
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffbe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res


    # Testcase 105:  rd:x13(0xffffffbf), imm:0x1, result rd:x13(0xffffff7e)
    li x13, MASK_XLEN(0xffffffbf)
    c.slli x13, 0x1
    sw x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0xffffff7e)

    # Testcase 106:  rd:x14(0xffffff7f), imm:0x1, result rd:x14(0xfffffefe)
    li x14, MASK_XLEN(0xffffff7f)
    c.slli x14, 0x1
    sw x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xfffffefe)

    # Testcase 107:  rd:x15(0xfffffeff), imm:0x1, result rd:x15(0xfffffdfe)
    li x15, MASK_XLEN(0xfffffeff)
    c.slli x15, 0x1
    sw x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xfffffdfe)

    # Testcase 108:  rd:x16(0xfffffdff), imm:0x1, result rd:x16(0xfffffbfe)
    li x16, MASK_XLEN(0xfffffdff)
    c.slli x16, 0x1
    sw x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xfffffbfe)

    # Testcase 109:  rd:x17(0xfffffbff), imm:0x1, result rd:x17(0xfffff7fe)
    li x17, MASK_XLEN(0xfffffbff)
    c.slli x17, 0x1
    sw x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xfffff7fe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rd:x18(0xfffff7ff), imm:0x1, result rd:x18(0xffffeffe)
    li x18, MASK_XLEN(0xfffff7ff)
    c.slli x18, 0x1
    sw x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0xffffeffe)

    # Testcase 111:  rd:x19(0xffffefff), imm:0x1, result rd:x19(0xffffdffe)
    li x19, MASK_XLEN(0xffffefff)
    c.slli x19, 0x1
    sw x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xffffdffe)

    # Testcase 112:  rd:x20(0xffffdfff), imm:0x1, result rd:x20(0xffffbffe)
    li x20, MASK_XLEN(0xffffdfff)
    c.slli x20, 0x1
    sw x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffffbffe)

    # Testcase 113:  rd:x21(0xffffbfff), imm:0x1, result rd:x21(0xffff7ffe)
    li x21, MASK_XLEN(0xffffbfff)
    c.slli x21, 0x1
    sw x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffff7ffe)

    # Testcase 114:  rd:x22(0xffff7fff), imm:0x1, result rd:x22(0xfffefffe)
    li x22, MASK_XLEN(0xffff7fff)
    c.slli x22, 0x1
    sw x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffefffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rd:x23(0xfffeffff), imm:0x1, result rd:x23(0xfffdfffe)
    li x23, MASK_XLEN(0xfffeffff)
    c.slli x23, 0x1
    sw x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffdfffe)

    # Testcase 116:  rd:x24(0xfffdffff), imm:0x1, result rd:x24(0xfffbfffe)
    li x24, MASK_XLEN(0xfffdffff)
    c.slli x24, 0x1
    sw x24, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xfffbfffe)

    # Testcase 117:  rd:x25(0xfffbffff), imm:0x1, result rd:x25(0xfff7fffe)
    li x25, MASK_XLEN(0xfffbffff)
    c.slli x25, 0x1
    sw x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfff7fffe)

    # Testcase 118:  rd:x26(0xfff7ffff), imm:0x1, result rd:x26(0xffeffffe)
    li x26, MASK_XLEN(0xfff7ffff)
    c.slli x26, 0x1
    sw x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffeffffe)

    # Testcase 119:  rd:x27(0xffefffff), imm:0x1, result rd:x27(0xffdffffe)
    li x27, MASK_XLEN(0xffefffff)
    c.slli x27, 0x1
    sw x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffdffffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res


    # Testcase 120:  rd:x28(0xffdfffff), imm:0x1, result rd:x28(0xffbffffe)
    li x28, MASK_XLEN(0xffdfffff)
    c.slli x28, 0x1
    sw x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0xffbffffe)

    # Testcase 121:  rd:x29(0xffbfffff), imm:0x1, result rd:x29(0xff7ffffe)
    li x29, MASK_XLEN(0xffbfffff)
    c.slli x29, 0x1
    sw x29, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0xff7ffffe)

    # Testcase 122:  rd:x30(0xff7fffff), imm:0x1, result rd:x30(0xfefffffe)
    li x30, MASK_XLEN(0xff7fffff)
    c.slli x30, 0x1
    sw x30, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0xfefffffe)

    # Testcase 123:  rd:x31(0xfeffffff), imm:0x1, result rd:x31(0xfdfffffe)
    li x31, MASK_XLEN(0xfeffffff)
    c.slli x31, 0x1
    sw x31, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xfdfffffe)

    # Testcase 124:  rd:x1(0xfdffffff), imm:0x1, result rd:x1(0xfbfffffe)
    li x1, MASK_XLEN(0xfdffffff)
    c.slli x1, 0x1
    sw x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xfbfffffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rd:x2(0xfbffffff), imm:0x1, result rd:x2(0xf7fffffe)
    li x2, MASK_XLEN(0xfbffffff)
    c.slli x2, 0x1
    sw x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xf7fffffe)

    # Testcase 126:  rd:x3(0xf7ffffff), imm:0x1, result rd:x3(0xeffffffe)
    li x3, MASK_XLEN(0xf7ffffff)
    c.slli x3, 0x1
    sw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xeffffffe)

    # Testcase 127:  rd:x4(0xefffffff), imm:0x1, result rd:x4(0xdffffffe)
    li x4, MASK_XLEN(0xefffffff)
    c.slli x4, 0x1
    sw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xdffffffe)

    # Testcase 128:  rd:x5(0xdfffffff), imm:0x1, result rd:x5(0xbffffffe)
    li x5, MASK_XLEN(0xdfffffff)
    c.slli x5, 0x1
    sw x5, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xbffffffe)

    # Testcase 129:  rd:x6(0xbfffffff), imm:0x1, result rd:x6(0x7ffffffe)
    li x6, MASK_XLEN(0xbfffffff)
    c.slli x6, 0x1
    sw x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0x7ffffffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rd:x7(0x7fffffff), imm:0x1, result rd:x7(0xfffffffe)
    li x7, MASK_XLEN(0x7fffffff)
    c.slli x7, 0x1
    sw x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffe)

    # Testcase 131:  rd:x8(0xffffffff), imm:0x1, result rd:x8(0xfffffffe)
    li x8, MASK_XLEN(0xffffffff)
    c.slli x8, 0x1
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffe)

    # Testcase 132:  rd:x9(0x00000001), imm:0x1f, result rd:x9(0x80000000)
    li x9, MASK_XLEN(0x1)
    c.slli x9, 0x1f
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x80000000)

    # Testcase 133:  rd:x10(0x00000002), imm:0xf, result rd:x10(0x00010000)
    li x10, MASK_XLEN(0x2)
    c.slli x10, 0xf
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x10000)

    # Testcase 134:  rd:x11(0x00000004), imm:0x17, result rd:x11(0x02000000)
    li x11, MASK_XLEN(0x4)
    c.slli x11, 0x17
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x2000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res


    # Testcase 135:  rd:x12(0x00000008), imm:0x1b, result rd:x12(0x40000000)
    li x12, MASK_XLEN(0x8)
    c.slli x12, 0x1b
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x40000000)


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

