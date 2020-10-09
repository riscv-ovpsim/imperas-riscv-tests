# RISC-V Compliance Test I-C-ADDI-01
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
# Description: Testing instruction 'c.addi'.

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


    # Testcase 0:  rd:x1(0x00000001), imm:0x1f, result rd:x1(0x00000020)
    li x1, MASK_XLEN(0x1)
    c.addi x1, SEXT_IMM(0x1f)
    sw x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x20)

    # Testcase 1:  rd:x2(0x00000002), imm:0xf, result rd:x2(0x00000011)
    li x2, MASK_XLEN(0x2)
    c.addi x2, SEXT_IMM(0xf)
    sw x2, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x11)

    # Testcase 2:  rd:x3(0x00000004), imm:0x17, result rd:x3(0x0000001b)
    li x3, MASK_XLEN(0x4)
    c.addi x3, SEXT_IMM(0x17)
    sw x3, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x1b)

    # Testcase 3:  rd:x4(0x00000008), imm:0x1b, result rd:x4(0x00000023)
    li x4, MASK_XLEN(0x8)
    c.addi x4, SEXT_IMM(0x1b)
    sw x4, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x23)

    # Testcase 4:  rd:x5(0x00000010), imm:0x1d, result rd:x5(0x0000002d)
    li x5, MASK_XLEN(0x10)
    c.addi x5, SEXT_IMM(0x1d)
    sw x5, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x2d)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rd:x6(0x00000020), imm:0x1e, result rd:x6(0x0000003e)
    li x6, MASK_XLEN(0x20)
    c.addi x6, SEXT_IMM(0x1e)
    sw x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x3e)

    # Testcase 6:  rd:x7(0x00000040), imm:0x1, result rd:x7(0x00000041)
    li x7, MASK_XLEN(0x40)
    c.addi x7, SEXT_IMM(0x1)
    sw x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x41)

    # Testcase 7:  rd:x8(0x00000080), imm:0x10, result rd:x8(0x00000090)
    li x8, MASK_XLEN(0x80)
    c.addi x8, SEXT_IMM(0x10)
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x90)

    # Testcase 8:  rd:x9(0x00000100), imm:0x8, result rd:x9(0x00000108)
    li x9, MASK_XLEN(0x100)
    c.addi x9, SEXT_IMM(0x8)
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x108)

    # Testcase 9:  rd:x10(0x00000200), imm:0x4, result rd:x10(0x00000204)
    li x10, MASK_XLEN(0x200)
    c.addi x10, SEXT_IMM(0x4)
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x204)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rd:x11(0x00000400), imm:0x2, result rd:x11(0x00000402)
    li x11, MASK_XLEN(0x400)
    c.addi x11, SEXT_IMM(0x2)
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x402)

    # Testcase 11:  rd:x12(0x00000800), imm:0x1, result rd:x12(0x00000801)
    li x12, MASK_XLEN(0x800)
    c.addi x12, SEXT_IMM(0x1)
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x801)

    # Testcase 12:  rd:x13(0x00001000), imm:0x1f, result rd:x13(0x0000101f)
    li x13, MASK_XLEN(0x1000)
    c.addi x13, SEXT_IMM(0x1f)
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x101f)

    # Testcase 13:  rd:x14(0x00002000), imm:0xf, result rd:x14(0x0000200f)
    li x14, MASK_XLEN(0x2000)
    c.addi x14, SEXT_IMM(0xf)
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x200f)

    # Testcase 14:  rd:x15(0x00004000), imm:0x17, result rd:x15(0x00004017)
    li x15, MASK_XLEN(0x4000)
    c.addi x15, SEXT_IMM(0x17)
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x4017)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res


    # Testcase 15:  rd:x16(0x00008000), imm:0x1b, result rd:x16(0x0000801b)
    li x16, MASK_XLEN(0x8000)
    c.addi x16, SEXT_IMM(0x1b)
    sw x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x801b)

    # Testcase 16:  rd:x17(0x00010000), imm:0x1d, result rd:x17(0x0001001d)
    li x17, MASK_XLEN(0x10000)
    c.addi x17, SEXT_IMM(0x1d)
    sw x17, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x1001d)

    # Testcase 17:  rd:x18(0x00020000), imm:0x1e, result rd:x18(0x0002001e)
    li x18, MASK_XLEN(0x20000)
    c.addi x18, SEXT_IMM(0x1e)
    sw x18, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x2001e)

    # Testcase 18:  rd:x19(0x00040000), imm:0x1, result rd:x19(0x00040001)
    li x19, MASK_XLEN(0x40000)
    c.addi x19, SEXT_IMM(0x1)
    sw x19, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x40001)

    # Testcase 19:  rd:x20(0x00080000), imm:0x10, result rd:x20(0x00080010)
    li x20, MASK_XLEN(0x80000)
    c.addi x20, SEXT_IMM(0x10)
    sw x20, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x80010)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rd:x21(0x00100000), imm:0x8, result rd:x21(0x00100008)
    li x21, MASK_XLEN(0x100000)
    c.addi x21, SEXT_IMM(0x8)
    sw x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x100008)

    # Testcase 21:  rd:x22(0x00200000), imm:0x4, result rd:x22(0x00200004)
    li x22, MASK_XLEN(0x200000)
    c.addi x22, SEXT_IMM(0x4)
    sw x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x200004)

    # Testcase 22:  rd:x23(0x00400000), imm:0x2, result rd:x23(0x00400002)
    li x23, MASK_XLEN(0x400000)
    c.addi x23, SEXT_IMM(0x2)
    sw x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x400002)

    # Testcase 23:  rd:x24(0x00800000), imm:0x1, result rd:x24(0x00800001)
    li x24, MASK_XLEN(0x800000)
    c.addi x24, SEXT_IMM(0x1)
    sw x24, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x800001)

    # Testcase 24:  rd:x25(0x01000000), imm:0x1f, result rd:x25(0x0100001f)
    li x25, MASK_XLEN(0x1000000)
    c.addi x25, SEXT_IMM(0x1f)
    sw x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x100001f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rd:x26(0x02000000), imm:0xf, result rd:x26(0x0200000f)
    li x26, MASK_XLEN(0x2000000)
    c.addi x26, SEXT_IMM(0xf)
    sw x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x200000f)

    # Testcase 26:  rd:x27(0x04000000), imm:0x17, result rd:x27(0x04000017)
    li x27, MASK_XLEN(0x4000000)
    c.addi x27, SEXT_IMM(0x17)
    sw x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x4000017)

    # Testcase 27:  rd:x28(0x08000000), imm:0x1b, result rd:x28(0x0800001b)
    li x28, MASK_XLEN(0x8000000)
    c.addi x28, SEXT_IMM(0x1b)
    sw x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x800001b)

    # Testcase 28:  rd:x29(0x10000000), imm:0x1d, result rd:x29(0x1000001d)
    li x29, MASK_XLEN(0x10000000)
    c.addi x29, SEXT_IMM(0x1d)
    sw x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x1000001d)

    # Testcase 29:  rd:x30(0x20000000), imm:0x1e, result rd:x30(0x2000001e)
    li x30, MASK_XLEN(0x20000000)
    c.addi x30, SEXT_IMM(0x1e)
    sw x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x2000001e)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res


    # Testcase 30:  rd:x31(0x40000000), imm:0x1, result rd:x31(0x40000001)
    li x31, MASK_XLEN(0x40000000)
    c.addi x31, SEXT_IMM(0x1)
    sw x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x40000001)

    # Testcase 31:  rd:x1(0x80000000), imm:0x10, result rd:x1(0x80000010)
    li x1, MASK_XLEN(0x80000000)
    c.addi x1, SEXT_IMM(0x10)
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x80000010)

    # Testcase 32:  rd:x2(0x00000000), imm:0x8, result rd:x2(0x00000008)
    li x2, MASK_XLEN(0x0)
    c.addi x2, SEXT_IMM(0x8)
    sw x2, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x8)

    # Testcase 33:  rd:x3(0xfffffffe), imm:0x4, result rd:x3(0x00000002)
    li x3, MASK_XLEN(0xfffffffe)
    c.addi x3, SEXT_IMM(0x4)
    sw x3, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x2)

    # Testcase 34:  rd:x4(0xfffffffd), imm:0x2, result rd:x4(0xffffffff)
    li x4, MASK_XLEN(0xfffffffd)
    c.addi x4, SEXT_IMM(0x2)
    sw x4, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0xffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rd:x5(0xfffffffb), imm:0x1, result rd:x5(0xfffffffc)
    li x5, MASK_XLEN(0xfffffffb)
    c.addi x5, SEXT_IMM(0x1)
    sw x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffffc)

    # Testcase 36:  rd:x6(0xfffffff7), imm:0x1f, result rd:x6(0x00000016)
    li x6, MASK_XLEN(0xfffffff7)
    c.addi x6, SEXT_IMM(0x1f)
    sw x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x16)

    # Testcase 37:  rd:x7(0xffffffef), imm:0xf, result rd:x7(0xfffffffe)
    li x7, MASK_XLEN(0xffffffef)
    c.addi x7, SEXT_IMM(0xf)
    sw x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffe)

    # Testcase 38:  rd:x8(0xffffffdf), imm:0x17, result rd:x8(0xfffffff6)
    li x8, MASK_XLEN(0xffffffdf)
    c.addi x8, SEXT_IMM(0x17)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffff6)

    # Testcase 39:  rd:x9(0xffffffbf), imm:0x1b, result rd:x9(0xffffffda)
    li x9, MASK_XLEN(0xffffffbf)
    c.addi x9, SEXT_IMM(0x1b)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffda)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rd:x10(0xffffff7f), imm:0x1d, result rd:x10(0xffffff9c)
    li x10, MASK_XLEN(0xffffff7f)
    c.addi x10, SEXT_IMM(0x1d)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffff9c)

    # Testcase 41:  rd:x11(0xfffffeff), imm:0x1e, result rd:x11(0xffffff1d)
    li x11, MASK_XLEN(0xfffffeff)
    c.addi x11, SEXT_IMM(0x1e)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffff1d)

    # Testcase 42:  rd:x12(0xfffffdff), imm:0x1, result rd:x12(0xfffffe00)
    li x12, MASK_XLEN(0xfffffdff)
    c.addi x12, SEXT_IMM(0x1)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffe00)

    # Testcase 43:  rd:x13(0xfffffbff), imm:0x10, result rd:x13(0xfffffc0f)
    li x13, MASK_XLEN(0xfffffbff)
    c.addi x13, SEXT_IMM(0x10)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffc0f)

    # Testcase 44:  rd:x14(0xfffff7ff), imm:0x8, result rd:x14(0xfffff807)
    li x14, MASK_XLEN(0xfffff7ff)
    c.addi x14, SEXT_IMM(0x8)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffff807)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res


    # Testcase 45:  rd:x15(0xffffefff), imm:0x4, result rd:x15(0xfffff003)
    li x15, MASK_XLEN(0xffffefff)
    c.addi x15, SEXT_IMM(0x4)
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0xfffff003)

    # Testcase 46:  rd:x16(0xffffdfff), imm:0x2, result rd:x16(0xffffe001)
    li x16, MASK_XLEN(0xffffdfff)
    c.addi x16, SEXT_IMM(0x2)
    sw x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0xffffe001)

    # Testcase 47:  rd:x17(0xffffbfff), imm:0x1, result rd:x17(0xffffc000)
    li x17, MASK_XLEN(0xffffbfff)
    c.addi x17, SEXT_IMM(0x1)
    sw x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xffffc000)

    # Testcase 48:  rd:x18(0xffff7fff), imm:0x1f, result rd:x18(0xffff801e)
    li x18, MASK_XLEN(0xffff7fff)
    c.addi x18, SEXT_IMM(0x1f)
    sw x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0xffff801e)

    # Testcase 49:  rd:x19(0xfffeffff), imm:0xf, result rd:x19(0xffff000e)
    li x19, MASK_XLEN(0xfffeffff)
    c.addi x19, SEXT_IMM(0xf)
    sw x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xffff000e)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rd:x20(0xfffdffff), imm:0x17, result rd:x20(0xfffe0016)
    li x20, MASK_XLEN(0xfffdffff)
    c.addi x20, SEXT_IMM(0x17)
    sw x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffe0016)

    # Testcase 51:  rd:x21(0xfffbffff), imm:0x1b, result rd:x21(0xfffc001a)
    li x21, MASK_XLEN(0xfffbffff)
    c.addi x21, SEXT_IMM(0x1b)
    sw x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffc001a)

    # Testcase 52:  rd:x22(0xfff7ffff), imm:0x1d, result rd:x22(0xfff8001c)
    li x22, MASK_XLEN(0xfff7ffff)
    c.addi x22, SEXT_IMM(0x1d)
    sw x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfff8001c)

    # Testcase 53:  rd:x23(0xffefffff), imm:0x1e, result rd:x23(0xfff0001d)
    li x23, MASK_XLEN(0xffefffff)
    c.addi x23, SEXT_IMM(0x1e)
    sw x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfff0001d)

    # Testcase 54:  rd:x24(0xffdfffff), imm:0x1, result rd:x24(0xffe00000)
    li x24, MASK_XLEN(0xffdfffff)
    c.addi x24, SEXT_IMM(0x1)
    sw x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffe00000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rd:x25(0xffbfffff), imm:0x10, result rd:x25(0xffc0000f)
    li x25, MASK_XLEN(0xffbfffff)
    c.addi x25, SEXT_IMM(0x10)
    sw x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffc0000f)

    # Testcase 56:  rd:x26(0xff7fffff), imm:0x8, result rd:x26(0xff800007)
    li x26, MASK_XLEN(0xff7fffff)
    c.addi x26, SEXT_IMM(0x8)
    sw x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xff800007)

    # Testcase 57:  rd:x27(0xfeffffff), imm:0x4, result rd:x27(0xff000003)
    li x27, MASK_XLEN(0xfeffffff)
    c.addi x27, SEXT_IMM(0x4)
    sw x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xff000003)

    # Testcase 58:  rd:x28(0xfdffffff), imm:0x2, result rd:x28(0xfe000001)
    li x28, MASK_XLEN(0xfdffffff)
    c.addi x28, SEXT_IMM(0x2)
    sw x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfe000001)

    # Testcase 59:  rd:x29(0xfbffffff), imm:0x1, result rd:x29(0xfc000000)
    li x29, MASK_XLEN(0xfbffffff)
    c.addi x29, SEXT_IMM(0x1)
    sw x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xfc000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res


    # Testcase 60:  rd:x30(0xf7ffffff), imm:0x1f, result rd:x30(0xf800001e)
    li x30, MASK_XLEN(0xf7ffffff)
    c.addi x30, SEXT_IMM(0x1f)
    sw x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xf800001e)

    # Testcase 61:  rd:x31(0xefffffff), imm:0xf, result rd:x31(0xf000000e)
    li x31, MASK_XLEN(0xefffffff)
    c.addi x31, SEXT_IMM(0xf)
    sw x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xf000000e)

    # Testcase 62:  rd:x1(0xdfffffff), imm:0x17, result rd:x1(0xe0000016)
    li x1, MASK_XLEN(0xdfffffff)
    c.addi x1, SEXT_IMM(0x17)
    sw x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xe0000016)

    # Testcase 63:  rd:x2(0xbfffffff), imm:0x1b, result rd:x2(0xc000001a)
    li x2, MASK_XLEN(0xbfffffff)
    c.addi x2, SEXT_IMM(0x1b)
    sw x2, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xc000001a)

    # Testcase 64:  rd:x3(0x7fffffff), imm:0x1d, result rd:x3(0x8000001c)
    li x3, MASK_XLEN(0x7fffffff)
    c.addi x3, SEXT_IMM(0x1d)
    sw x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x8000001c)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rd:x4(0xffffffff), imm:0x1e, result rd:x4(0x0000001d)
    li x4, MASK_XLEN(0xffffffff)
    c.addi x4, SEXT_IMM(0x1e)
    sw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x1d)

    # Testcase 66:  rd:x5(0x00000001), imm:0x1, result rd:x5(0x00000002)
    li x5, MASK_XLEN(0x1)
    c.addi x5, SEXT_IMM(0x1)
    sw x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x2)

    # Testcase 67:  rd:x6(0x00000002), imm:0x1, result rd:x6(0x00000003)
    li x6, MASK_XLEN(0x2)
    c.addi x6, SEXT_IMM(0x1)
    sw x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x3)

    # Testcase 68:  rd:x7(0x00000004), imm:0x1, result rd:x7(0x00000005)
    li x7, MASK_XLEN(0x4)
    c.addi x7, SEXT_IMM(0x1)
    sw x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x5)

    # Testcase 69:  rd:x8(0x00000008), imm:0x1, result rd:x8(0x00000009)
    li x8, MASK_XLEN(0x8)
    c.addi x8, SEXT_IMM(0x1)
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x9)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rd:x9(0x00000010), imm:0x1, result rd:x9(0x00000011)
    li x9, MASK_XLEN(0x10)
    c.addi x9, SEXT_IMM(0x1)
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x11)

    # Testcase 71:  rd:x10(0x00000020), imm:0x1, result rd:x10(0x00000021)
    li x10, MASK_XLEN(0x20)
    c.addi x10, SEXT_IMM(0x1)
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x21)

    # Testcase 72:  rd:x11(0x00000040), imm:0x1, result rd:x11(0x00000041)
    li x11, MASK_XLEN(0x40)
    c.addi x11, SEXT_IMM(0x1)
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x41)

    # Testcase 73:  rd:x12(0x00000080), imm:0x1, result rd:x12(0x00000081)
    li x12, MASK_XLEN(0x80)
    c.addi x12, SEXT_IMM(0x1)
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x81)

    # Testcase 74:  rd:x13(0x00000100), imm:0x1, result rd:x13(0x00000101)
    li x13, MASK_XLEN(0x100)
    c.addi x13, SEXT_IMM(0x1)
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x101)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res


    # Testcase 75:  rd:x14(0x00000200), imm:0x1, result rd:x14(0x00000201)
    li x14, MASK_XLEN(0x200)
    c.addi x14, SEXT_IMM(0x1)
    sw x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x201)

    # Testcase 76:  rd:x15(0x00000400), imm:0x1, result rd:x15(0x00000401)
    li x15, MASK_XLEN(0x400)
    c.addi x15, SEXT_IMM(0x1)
    sw x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x401)

    # Testcase 77:  rd:x16(0x00000800), imm:0x1, result rd:x16(0x00000801)
    li x16, MASK_XLEN(0x800)
    c.addi x16, SEXT_IMM(0x1)
    sw x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x801)

    # Testcase 78:  rd:x17(0x00001000), imm:0x1, result rd:x17(0x00001001)
    li x17, MASK_XLEN(0x1000)
    c.addi x17, SEXT_IMM(0x1)
    sw x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x1001)

    # Testcase 79:  rd:x18(0x00002000), imm:0x1, result rd:x18(0x00002001)
    li x18, MASK_XLEN(0x2000)
    c.addi x18, SEXT_IMM(0x1)
    sw x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x2001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rd:x19(0x00004000), imm:0x1, result rd:x19(0x00004001)
    li x19, MASK_XLEN(0x4000)
    c.addi x19, SEXT_IMM(0x1)
    sw x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x4001)

    # Testcase 81:  rd:x20(0x00008000), imm:0x1, result rd:x20(0x00008001)
    li x20, MASK_XLEN(0x8000)
    c.addi x20, SEXT_IMM(0x1)
    sw x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x8001)

    # Testcase 82:  rd:x21(0x00010000), imm:0x1, result rd:x21(0x00010001)
    li x21, MASK_XLEN(0x10000)
    c.addi x21, SEXT_IMM(0x1)
    sw x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x10001)

    # Testcase 83:  rd:x22(0x00020000), imm:0x1, result rd:x22(0x00020001)
    li x22, MASK_XLEN(0x20000)
    c.addi x22, SEXT_IMM(0x1)
    sw x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x20001)

    # Testcase 84:  rd:x23(0x00040000), imm:0x1, result rd:x23(0x00040001)
    li x23, MASK_XLEN(0x40000)
    c.addi x23, SEXT_IMM(0x1)
    sw x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x40001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rd:x24(0x00080000), imm:0x1, result rd:x24(0x00080001)
    li x24, MASK_XLEN(0x80000)
    c.addi x24, SEXT_IMM(0x1)
    sw x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x80001)

    # Testcase 86:  rd:x25(0x00100000), imm:0x1, result rd:x25(0x00100001)
    li x25, MASK_XLEN(0x100000)
    c.addi x25, SEXT_IMM(0x1)
    sw x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x100001)

    # Testcase 87:  rd:x26(0x00200000), imm:0x1, result rd:x26(0x00200001)
    li x26, MASK_XLEN(0x200000)
    c.addi x26, SEXT_IMM(0x1)
    sw x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x200001)

    # Testcase 88:  rd:x27(0x00400000), imm:0x1, result rd:x27(0x00400001)
    li x27, MASK_XLEN(0x400000)
    c.addi x27, SEXT_IMM(0x1)
    sw x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x400001)

    # Testcase 89:  rd:x28(0x00800000), imm:0x1, result rd:x28(0x00800001)
    li x28, MASK_XLEN(0x800000)
    c.addi x28, SEXT_IMM(0x1)
    sw x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x800001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res


    # Testcase 90:  rd:x29(0x01000000), imm:0x1, result rd:x29(0x01000001)
    li x29, MASK_XLEN(0x1000000)
    c.addi x29, SEXT_IMM(0x1)
    sw x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x1000001)

    # Testcase 91:  rd:x30(0x02000000), imm:0x1, result rd:x30(0x02000001)
    li x30, MASK_XLEN(0x2000000)
    c.addi x30, SEXT_IMM(0x1)
    sw x30, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x2000001)

    # Testcase 92:  rd:x31(0x04000000), imm:0x1, result rd:x31(0x04000001)
    li x31, MASK_XLEN(0x4000000)
    c.addi x31, SEXT_IMM(0x1)
    sw x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x4000001)

    # Testcase 93:  rd:x1(0x08000000), imm:0x1, result rd:x1(0x08000001)
    li x1, MASK_XLEN(0x8000000)
    c.addi x1, SEXT_IMM(0x1)
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x8000001)

    # Testcase 94:  rd:x2(0x10000000), imm:0x1, result rd:x2(0x10000001)
    li x2, MASK_XLEN(0x10000000)
    c.addi x2, SEXT_IMM(0x1)
    sw x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x10000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rd:x3(0x20000000), imm:0x1, result rd:x3(0x20000001)
    li x3, MASK_XLEN(0x20000000)
    c.addi x3, SEXT_IMM(0x1)
    sw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x20000001)

    # Testcase 96:  rd:x4(0x40000000), imm:0x1, result rd:x4(0x40000001)
    li x4, MASK_XLEN(0x40000000)
    c.addi x4, SEXT_IMM(0x1)
    sw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x40000001)

    # Testcase 97:  rd:x5(0x80000000), imm:0x1, result rd:x5(0x80000001)
    li x5, MASK_XLEN(0x80000000)
    c.addi x5, SEXT_IMM(0x1)
    sw x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x80000001)

    # Testcase 98:  rd:x6(0x00000000), imm:0x1, result rd:x6(0x00000001)
    li x6, MASK_XLEN(0x0)
    c.addi x6, SEXT_IMM(0x1)
    sw x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x1)

    # Testcase 99:  rd:x7(0xfffffffe), imm:0x1, result rd:x7(0xffffffff)
    li x7, MASK_XLEN(0xfffffffe)
    c.addi x7, SEXT_IMM(0x1)
    sw x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rd:x8(0xfffffffd), imm:0x1, result rd:x8(0xfffffffe)
    li x8, MASK_XLEN(0xfffffffd)
    c.addi x8, SEXT_IMM(0x1)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffe)

    # Testcase 101:  rd:x9(0xfffffffb), imm:0x1, result rd:x9(0xfffffffc)
    li x9, MASK_XLEN(0xfffffffb)
    c.addi x9, SEXT_IMM(0x1)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffc)

    # Testcase 102:  rd:x10(0xfffffff7), imm:0x1, result rd:x10(0xfffffff8)
    li x10, MASK_XLEN(0xfffffff7)
    c.addi x10, SEXT_IMM(0x1)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffff8)

    # Testcase 103:  rd:x11(0xffffffef), imm:0x1, result rd:x11(0xfffffff0)
    li x11, MASK_XLEN(0xffffffef)
    c.addi x11, SEXT_IMM(0x1)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffff0)

    # Testcase 104:  rd:x12(0xffffffdf), imm:0x1, result rd:x12(0xffffffe0)
    li x12, MASK_XLEN(0xffffffdf)
    c.addi x12, SEXT_IMM(0x1)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffe0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res


    # Testcase 105:  rd:x13(0xffffffbf), imm:0x1, result rd:x13(0xffffffc0)
    li x13, MASK_XLEN(0xffffffbf)
    c.addi x13, SEXT_IMM(0x1)
    sw x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0xffffffc0)

    # Testcase 106:  rd:x14(0xffffff7f), imm:0x1, result rd:x14(0xffffff80)
    li x14, MASK_XLEN(0xffffff7f)
    c.addi x14, SEXT_IMM(0x1)
    sw x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xffffff80)

    # Testcase 107:  rd:x15(0xfffffeff), imm:0x1, result rd:x15(0xffffff00)
    li x15, MASK_XLEN(0xfffffeff)
    c.addi x15, SEXT_IMM(0x1)
    sw x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xffffff00)

    # Testcase 108:  rd:x16(0xfffffdff), imm:0x1, result rd:x16(0xfffffe00)
    li x16, MASK_XLEN(0xfffffdff)
    c.addi x16, SEXT_IMM(0x1)
    sw x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xfffffe00)

    # Testcase 109:  rd:x17(0xfffffbff), imm:0x1, result rd:x17(0xfffffc00)
    li x17, MASK_XLEN(0xfffffbff)
    c.addi x17, SEXT_IMM(0x1)
    sw x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xfffffc00)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rd:x18(0xfffff7ff), imm:0x1, result rd:x18(0xfffff800)
    li x18, MASK_XLEN(0xfffff7ff)
    c.addi x18, SEXT_IMM(0x1)
    sw x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0xfffff800)

    # Testcase 111:  rd:x19(0xffffefff), imm:0x1, result rd:x19(0xfffff000)
    li x19, MASK_XLEN(0xffffefff)
    c.addi x19, SEXT_IMM(0x1)
    sw x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xfffff000)

    # Testcase 112:  rd:x20(0xffffdfff), imm:0x1, result rd:x20(0xffffe000)
    li x20, MASK_XLEN(0xffffdfff)
    c.addi x20, SEXT_IMM(0x1)
    sw x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffffe000)

    # Testcase 113:  rd:x21(0xffffbfff), imm:0x1, result rd:x21(0xffffc000)
    li x21, MASK_XLEN(0xffffbfff)
    c.addi x21, SEXT_IMM(0x1)
    sw x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffc000)

    # Testcase 114:  rd:x22(0xffff7fff), imm:0x1, result rd:x22(0xffff8000)
    li x22, MASK_XLEN(0xffff7fff)
    c.addi x22, SEXT_IMM(0x1)
    sw x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffff8000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rd:x23(0xfffeffff), imm:0x1, result rd:x23(0xffff0000)
    li x23, MASK_XLEN(0xfffeffff)
    c.addi x23, SEXT_IMM(0x1)
    sw x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffff0000)

    # Testcase 116:  rd:x24(0xfffdffff), imm:0x1, result rd:x24(0xfffe0000)
    li x24, MASK_XLEN(0xfffdffff)
    c.addi x24, SEXT_IMM(0x1)
    sw x24, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xfffe0000)

    # Testcase 117:  rd:x25(0xfffbffff), imm:0x1, result rd:x25(0xfffc0000)
    li x25, MASK_XLEN(0xfffbffff)
    c.addi x25, SEXT_IMM(0x1)
    sw x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffc0000)

    # Testcase 118:  rd:x26(0xfff7ffff), imm:0x1, result rd:x26(0xfff80000)
    li x26, MASK_XLEN(0xfff7ffff)
    c.addi x26, SEXT_IMM(0x1)
    sw x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xfff80000)

    # Testcase 119:  rd:x27(0xffefffff), imm:0x1, result rd:x27(0xfff00000)
    li x27, MASK_XLEN(0xffefffff)
    c.addi x27, SEXT_IMM(0x1)
    sw x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfff00000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res


    # Testcase 120:  rd:x28(0xffdfffff), imm:0x1, result rd:x28(0xffe00000)
    li x28, MASK_XLEN(0xffdfffff)
    c.addi x28, SEXT_IMM(0x1)
    sw x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0xffe00000)

    # Testcase 121:  rd:x29(0xffbfffff), imm:0x1, result rd:x29(0xffc00000)
    li x29, MASK_XLEN(0xffbfffff)
    c.addi x29, SEXT_IMM(0x1)
    sw x29, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0xffc00000)

    # Testcase 122:  rd:x30(0xff7fffff), imm:0x1, result rd:x30(0xff800000)
    li x30, MASK_XLEN(0xff7fffff)
    c.addi x30, SEXT_IMM(0x1)
    sw x30, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0xff800000)

    # Testcase 123:  rd:x31(0xfeffffff), imm:0x1, result rd:x31(0xff000000)
    li x31, MASK_XLEN(0xfeffffff)
    c.addi x31, SEXT_IMM(0x1)
    sw x31, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xff000000)

    # Testcase 124:  rd:x1(0xfdffffff), imm:0x1, result rd:x1(0xfe000000)
    li x1, MASK_XLEN(0xfdffffff)
    c.addi x1, SEXT_IMM(0x1)
    sw x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xfe000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rd:x2(0xfbffffff), imm:0x1, result rd:x2(0xfc000000)
    li x2, MASK_XLEN(0xfbffffff)
    c.addi x2, SEXT_IMM(0x1)
    sw x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xfc000000)

    # Testcase 126:  rd:x3(0xf7ffffff), imm:0x1, result rd:x3(0xf8000000)
    li x3, MASK_XLEN(0xf7ffffff)
    c.addi x3, SEXT_IMM(0x1)
    sw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xf8000000)

    # Testcase 127:  rd:x4(0xefffffff), imm:0x1, result rd:x4(0xf0000000)
    li x4, MASK_XLEN(0xefffffff)
    c.addi x4, SEXT_IMM(0x1)
    sw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xf0000000)

    # Testcase 128:  rd:x5(0xdfffffff), imm:0x1, result rd:x5(0xe0000000)
    li x5, MASK_XLEN(0xdfffffff)
    c.addi x5, SEXT_IMM(0x1)
    sw x5, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xe0000000)

    # Testcase 129:  rd:x6(0xbfffffff), imm:0x1, result rd:x6(0xc0000000)
    li x6, MASK_XLEN(0xbfffffff)
    c.addi x6, SEXT_IMM(0x1)
    sw x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0xc0000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rd:x7(0x7fffffff), imm:0x1, result rd:x7(0x80000000)
    li x7, MASK_XLEN(0x7fffffff)
    c.addi x7, SEXT_IMM(0x1)
    sw x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x80000000)

    # Testcase 131:  rd:x8(0xffffffff), imm:0x1, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xffffffff)
    c.addi x8, SEXT_IMM(0x1)
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 132:  rd:x9(0x00000001), imm:0x1f, result rd:x9(0x00000020)
    li x9, MASK_XLEN(0x1)
    c.addi x9, SEXT_IMM(0x1f)
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20)

    # Testcase 133:  rd:x0(0x00000002), imm:0xf, result rd:x0(0x00000000)
    li x0, MASK_XLEN(0x2)
    c.addi x0, SEXT_IMM(0xf)
    sw x0, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x0, 0x0)

    # Testcase 134:  rd:x11(0x00000004), imm:0x17, result rd:x11(0x0000001b)
    li x11, MASK_XLEN(0x4)
    c.addi x11, SEXT_IMM(0x17)
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1b)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res


    # Testcase 135:  rd:x12(0x00000008), imm:0x1b, result rd:x12(0x00000023)
    li x12, MASK_XLEN(0x8)
    c.addi x12, SEXT_IMM(0x1b)
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x23)


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

