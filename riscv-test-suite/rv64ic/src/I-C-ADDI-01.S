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

RV_COMPLIANCE_RV64M

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
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x20)

    # Testcase 1:  rd:x2(0x00000002), imm:0xf, result rd:x2(0x00000011)
    li x2, MASK_XLEN(0x2)
    c.addi x2, SEXT_IMM(0xf)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x11)

    # Testcase 2:  rd:x3(0x00000004), imm:0x17, result rd:x3(0x0000001b)
    li x3, MASK_XLEN(0x4)
    c.addi x3, SEXT_IMM(0x17)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x1b)

    # Testcase 3:  rd:x4(0x00000008), imm:0x1b, result rd:x4(0x00000023)
    li x4, MASK_XLEN(0x8)
    c.addi x4, SEXT_IMM(0x1b)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x23)

    # Testcase 4:  rd:x5(0x00000010), imm:0x1d, result rd:x5(0x0000002d)
    li x5, MASK_XLEN(0x10)
    c.addi x5, SEXT_IMM(0x1d)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x2d)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rd:x6(0x00000020), imm:0x1e, result rd:x6(0x0000003e)
    li x6, MASK_XLEN(0x20)
    c.addi x6, SEXT_IMM(0x1e)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x3e)

    # Testcase 6:  rd:x7(0x00000040), imm:0x1, result rd:x7(0x00000041)
    li x7, MASK_XLEN(0x40)
    c.addi x7, SEXT_IMM(0x1)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x41)

    # Testcase 7:  rd:x8(0x00000080), imm:0x10, result rd:x8(0x00000090)
    li x8, MASK_XLEN(0x80)
    c.addi x8, SEXT_IMM(0x10)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x90)

    # Testcase 8:  rd:x9(0x00000100), imm:0x8, result rd:x9(0x00000108)
    li x9, MASK_XLEN(0x100)
    c.addi x9, SEXT_IMM(0x8)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x108)

    # Testcase 9:  rd:x10(0x00000200), imm:0x4, result rd:x10(0x00000204)
    li x10, MASK_XLEN(0x200)
    c.addi x10, SEXT_IMM(0x4)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x204)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rd:x11(0x00000400), imm:0x2, result rd:x11(0x00000402)
    li x11, MASK_XLEN(0x400)
    c.addi x11, SEXT_IMM(0x2)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x402)

    # Testcase 11:  rd:x12(0x00000800), imm:0x1, result rd:x12(0x00000801)
    li x12, MASK_XLEN(0x800)
    c.addi x12, SEXT_IMM(0x1)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x801)

    # Testcase 12:  rd:x13(0x00001000), imm:0x1f, result rd:x13(0x0000101f)
    li x13, MASK_XLEN(0x1000)
    c.addi x13, SEXT_IMM(0x1f)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x101f)

    # Testcase 13:  rd:x14(0x00002000), imm:0xf, result rd:x14(0x0000200f)
    li x14, MASK_XLEN(0x2000)
    c.addi x14, SEXT_IMM(0xf)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x200f)

    # Testcase 14:  rd:x15(0x00004000), imm:0x17, result rd:x15(0x00004017)
    li x15, MASK_XLEN(0x4000)
    c.addi x15, SEXT_IMM(0x17)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x4017)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res


    # Testcase 15:  rd:x16(0x00008000), imm:0x1b, result rd:x16(0x0000801b)
    li x16, MASK_XLEN(0x8000)
    c.addi x16, SEXT_IMM(0x1b)
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x801b)

    # Testcase 16:  rd:x17(0x00010000), imm:0x1d, result rd:x17(0x0001001d)
    li x17, MASK_XLEN(0x10000)
    c.addi x17, SEXT_IMM(0x1d)
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x1001d)

    # Testcase 17:  rd:x18(0x00020000), imm:0x1e, result rd:x18(0x0002001e)
    li x18, MASK_XLEN(0x20000)
    c.addi x18, SEXT_IMM(0x1e)
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x2001e)

    # Testcase 18:  rd:x19(0x00040000), imm:0x1, result rd:x19(0x00040001)
    li x19, MASK_XLEN(0x40000)
    c.addi x19, SEXT_IMM(0x1)
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x40001)

    # Testcase 19:  rd:x20(0x00080000), imm:0x10, result rd:x20(0x00080010)
    li x20, MASK_XLEN(0x80000)
    c.addi x20, SEXT_IMM(0x10)
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x80010)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rd:x21(0x00100000), imm:0x8, result rd:x21(0x00100008)
    li x21, MASK_XLEN(0x100000)
    c.addi x21, SEXT_IMM(0x8)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x100008)

    # Testcase 21:  rd:x22(0x00200000), imm:0x4, result rd:x22(0x00200004)
    li x22, MASK_XLEN(0x200000)
    c.addi x22, SEXT_IMM(0x4)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x200004)

    # Testcase 22:  rd:x23(0x00400000), imm:0x2, result rd:x23(0x00400002)
    li x23, MASK_XLEN(0x400000)
    c.addi x23, SEXT_IMM(0x2)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x400002)

    # Testcase 23:  rd:x24(0x00800000), imm:0x1, result rd:x24(0x00800001)
    li x24, MASK_XLEN(0x800000)
    c.addi x24, SEXT_IMM(0x1)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x800001)

    # Testcase 24:  rd:x25(0x01000000), imm:0x1f, result rd:x25(0x0100001f)
    li x25, MASK_XLEN(0x1000000)
    c.addi x25, SEXT_IMM(0x1f)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x100001f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rd:x26(0x02000000), imm:0xf, result rd:x26(0x0200000f)
    li x26, MASK_XLEN(0x2000000)
    c.addi x26, SEXT_IMM(0xf)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x200000f)

    # Testcase 26:  rd:x27(0x04000000), imm:0x17, result rd:x27(0x04000017)
    li x27, MASK_XLEN(0x4000000)
    c.addi x27, SEXT_IMM(0x17)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x4000017)

    # Testcase 27:  rd:x28(0x08000000), imm:0x1b, result rd:x28(0x0800001b)
    li x28, MASK_XLEN(0x8000000)
    c.addi x28, SEXT_IMM(0x1b)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x800001b)

    # Testcase 28:  rd:x29(0x10000000), imm:0x1d, result rd:x29(0x1000001d)
    li x29, MASK_XLEN(0x10000000)
    c.addi x29, SEXT_IMM(0x1d)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x1000001d)

    # Testcase 29:  rd:x30(0x20000000), imm:0x1e, result rd:x30(0x2000001e)
    li x30, MASK_XLEN(0x20000000)
    c.addi x30, SEXT_IMM(0x1e)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x2000001e)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res


    # Testcase 30:  rd:x31(0x40000000), imm:0x1, result rd:x31(0x40000001)
    li x31, MASK_XLEN(0x40000000)
    c.addi x31, SEXT_IMM(0x1)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x40000001)

    # Testcase 31:  rd:x1(0x80000000), imm:0x10, result rd:x1(0x80000010)
    li x1, MASK_XLEN(0x80000000)
    c.addi x1, SEXT_IMM(0x10)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x80000010)

    # Testcase 32:  rd:x2(0x100000000), imm:0x8, result rd:x2(0x100000008)
    li x2, MASK_XLEN(0x100000000)
    c.addi x2, SEXT_IMM(0x8)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x100000008)

    # Testcase 33:  rd:x3(0x200000000), imm:0x4, result rd:x3(0x200000004)
    li x3, MASK_XLEN(0x200000000)
    c.addi x3, SEXT_IMM(0x4)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x200000004)

    # Testcase 34:  rd:x4(0x400000000), imm:0x2, result rd:x4(0x400000002)
    li x4, MASK_XLEN(0x400000000)
    c.addi x4, SEXT_IMM(0x2)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x400000002)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rd:x5(0x800000000), imm:0x1, result rd:x5(0x800000001)
    li x5, MASK_XLEN(0x800000000)
    c.addi x5, SEXT_IMM(0x1)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x800000001)

    # Testcase 36:  rd:x6(0x1000000000), imm:0x1f, result rd:x6(0x100000001f)
    li x6, MASK_XLEN(0x1000000000)
    c.addi x6, SEXT_IMM(0x1f)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x100000001f)

    # Testcase 37:  rd:x7(0x2000000000), imm:0xf, result rd:x7(0x200000000f)
    li x7, MASK_XLEN(0x2000000000)
    c.addi x7, SEXT_IMM(0xf)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x200000000f)

    # Testcase 38:  rd:x8(0x4000000000), imm:0x17, result rd:x8(0x4000000017)
    li x8, MASK_XLEN(0x4000000000)
    c.addi x8, SEXT_IMM(0x17)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x4000000017)

    # Testcase 39:  rd:x9(0x8000000000), imm:0x1b, result rd:x9(0x800000001b)
    li x9, MASK_XLEN(0x8000000000)
    c.addi x9, SEXT_IMM(0x1b)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x800000001b)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rd:x10(0x10000000000), imm:0x1d, result rd:x10(0x1000000001d)
    li x10, MASK_XLEN(0x10000000000)
    c.addi x10, SEXT_IMM(0x1d)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1000000001d)

    # Testcase 41:  rd:x11(0x20000000000), imm:0x1e, result rd:x11(0x2000000001e)
    li x11, MASK_XLEN(0x20000000000)
    c.addi x11, SEXT_IMM(0x1e)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x2000000001e)

    # Testcase 42:  rd:x12(0x40000000000), imm:0x1, result rd:x12(0x40000000001)
    li x12, MASK_XLEN(0x40000000000)
    c.addi x12, SEXT_IMM(0x1)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x40000000001)

    # Testcase 43:  rd:x13(0x80000000000), imm:0x10, result rd:x13(0x80000000010)
    li x13, MASK_XLEN(0x80000000000)
    c.addi x13, SEXT_IMM(0x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x80000000010)

    # Testcase 44:  rd:x14(0x100000000000), imm:0x8, result rd:x14(0x100000000008)
    li x14, MASK_XLEN(0x100000000000)
    c.addi x14, SEXT_IMM(0x8)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x100000000008)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res


    # Testcase 45:  rd:x15(0x200000000000), imm:0x4, result rd:x15(0x200000000004)
    li x15, MASK_XLEN(0x200000000000)
    c.addi x15, SEXT_IMM(0x4)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x200000000004)

    # Testcase 46:  rd:x16(0x400000000000), imm:0x2, result rd:x16(0x400000000002)
    li x16, MASK_XLEN(0x400000000000)
    c.addi x16, SEXT_IMM(0x2)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x400000000002)

    # Testcase 47:  rd:x17(0x800000000000), imm:0x1, result rd:x17(0x800000000001)
    li x17, MASK_XLEN(0x800000000000)
    c.addi x17, SEXT_IMM(0x1)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x800000000001)

    # Testcase 48:  rd:x18(0x1000000000000), imm:0x1f, result rd:x18(0x100000000001f)
    li x18, MASK_XLEN(0x1000000000000)
    c.addi x18, SEXT_IMM(0x1f)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x100000000001f)

    # Testcase 49:  rd:x19(0x2000000000000), imm:0xf, result rd:x19(0x200000000000f)
    li x19, MASK_XLEN(0x2000000000000)
    c.addi x19, SEXT_IMM(0xf)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x200000000000f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rd:x20(0x4000000000000), imm:0x17, result rd:x20(0x4000000000017)
    li x20, MASK_XLEN(0x4000000000000)
    c.addi x20, SEXT_IMM(0x17)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x4000000000017)

    # Testcase 51:  rd:x21(0x8000000000000), imm:0x1b, result rd:x21(0x800000000001b)
    li x21, MASK_XLEN(0x8000000000000)
    c.addi x21, SEXT_IMM(0x1b)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x800000000001b)

    # Testcase 52:  rd:x22(0x10000000000000), imm:0x1d, result rd:x22(0x1000000000001d)
    li x22, MASK_XLEN(0x10000000000000)
    c.addi x22, SEXT_IMM(0x1d)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x1000000000001d)

    # Testcase 53:  rd:x23(0x20000000000000), imm:0x1e, result rd:x23(0x2000000000001e)
    li x23, MASK_XLEN(0x20000000000000)
    c.addi x23, SEXT_IMM(0x1e)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x2000000000001e)

    # Testcase 54:  rd:x24(0x40000000000000), imm:0x1, result rd:x24(0x40000000000001)
    li x24, MASK_XLEN(0x40000000000000)
    c.addi x24, SEXT_IMM(0x1)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x40000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rd:x25(0x80000000000000), imm:0x10, result rd:x25(0x80000000000010)
    li x25, MASK_XLEN(0x80000000000000)
    c.addi x25, SEXT_IMM(0x10)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x80000000000010)

    # Testcase 56:  rd:x26(0x100000000000000), imm:0x8, result rd:x26(0x100000000000008)
    li x26, MASK_XLEN(0x100000000000000)
    c.addi x26, SEXT_IMM(0x8)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x100000000000008)

    # Testcase 57:  rd:x27(0x200000000000000), imm:0x4, result rd:x27(0x200000000000004)
    li x27, MASK_XLEN(0x200000000000000)
    c.addi x27, SEXT_IMM(0x4)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x200000000000004)

    # Testcase 58:  rd:x28(0x400000000000000), imm:0x2, result rd:x28(0x400000000000002)
    li x28, MASK_XLEN(0x400000000000000)
    c.addi x28, SEXT_IMM(0x2)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x400000000000002)

    # Testcase 59:  rd:x29(0x800000000000000), imm:0x1, result rd:x29(0x800000000000001)
    li x29, MASK_XLEN(0x800000000000000)
    c.addi x29, SEXT_IMM(0x1)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x800000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res


    # Testcase 60:  rd:x30(0x1000000000000000), imm:0x1f, result rd:x30(0x100000000000001f)
    li x30, MASK_XLEN(0x1000000000000000)
    c.addi x30, SEXT_IMM(0x1f)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x100000000000001f)

    # Testcase 61:  rd:x31(0x2000000000000000), imm:0xf, result rd:x31(0x200000000000000f)
    li x31, MASK_XLEN(0x2000000000000000)
    c.addi x31, SEXT_IMM(0xf)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x200000000000000f)

    # Testcase 62:  rd:x1(0x4000000000000000), imm:0x17, result rd:x1(0x4000000000000017)
    li x1, MASK_XLEN(0x4000000000000000)
    c.addi x1, SEXT_IMM(0x17)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x4000000000000017)

    # Testcase 63:  rd:x2(0x8000000000000000), imm:0x1b, result rd:x2(0x800000000000001b)
    li x2, MASK_XLEN(0x8000000000000000)
    c.addi x2, SEXT_IMM(0x1b)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x800000000000001b)

    # Testcase 64:  rd:x3(0x00000000), imm:0x1d, result rd:x3(0x0000001d)
    li x3, MASK_XLEN(0x0)
    c.addi x3, SEXT_IMM(0x1d)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x1d)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rd:x4(0xfffffffffffffffe), imm:0x1e, result rd:x4(0x0000001c)
    li x4, MASK_XLEN(0xfffffffffffffffe)
    c.addi x4, SEXT_IMM(0x1e)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x1c)

    # Testcase 66:  rd:x5(0xfffffffffffffffd), imm:0x1, result rd:x5(0xfffffffffffffffe)
    li x5, MASK_XLEN(0xfffffffffffffffd)
    c.addi x5, SEXT_IMM(0x1)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffffffffffffe)

    # Testcase 67:  rd:x6(0xfffffffffffffffb), imm:0x10, result rd:x6(0x0000000b)
    li x6, MASK_XLEN(0xfffffffffffffffb)
    c.addi x6, SEXT_IMM(0x10)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xb)

    # Testcase 68:  rd:x7(0xfffffffffffffff7), imm:0x8, result rd:x7(0xffffffffffffffff)
    li x7, MASK_XLEN(0xfffffffffffffff7)
    c.addi x7, SEXT_IMM(0x8)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffffffffffff)

    # Testcase 69:  rd:x8(0xffffffffffffffef), imm:0x4, result rd:x8(0xfffffffffffffff3)
    li x8, MASK_XLEN(0xffffffffffffffef)
    c.addi x8, SEXT_IMM(0x4)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffffff3)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rd:x9(0xffffffffffffffdf), imm:0x2, result rd:x9(0xffffffffffffffe1)
    li x9, MASK_XLEN(0xffffffffffffffdf)
    c.addi x9, SEXT_IMM(0x2)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffffffe1)

    # Testcase 71:  rd:x10(0xffffffffffffffbf), imm:0x1, result rd:x10(0xffffffffffffffc0)
    li x10, MASK_XLEN(0xffffffffffffffbf)
    c.addi x10, SEXT_IMM(0x1)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffffffc0)

    # Testcase 72:  rd:x11(0xffffffffffffff7f), imm:0x1f, result rd:x11(0xffffffffffffff9e)
    li x11, MASK_XLEN(0xffffffffffffff7f)
    c.addi x11, SEXT_IMM(0x1f)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffff9e)

    # Testcase 73:  rd:x12(0xfffffffffffffeff), imm:0xf, result rd:x12(0xffffffffffffff0e)
    li x12, MASK_XLEN(0xfffffffffffffeff)
    c.addi x12, SEXT_IMM(0xf)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffff0e)

    # Testcase 74:  rd:x13(0xfffffffffffffdff), imm:0x17, result rd:x13(0xfffffffffffffe16)
    li x13, MASK_XLEN(0xfffffffffffffdff)
    c.addi x13, SEXT_IMM(0x17)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffffffe16)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res


    # Testcase 75:  rd:x14(0xfffffffffffffbff), imm:0x1b, result rd:x14(0xfffffffffffffc1a)
    li x14, MASK_XLEN(0xfffffffffffffbff)
    c.addi x14, SEXT_IMM(0x1b)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xfffffffffffffc1a)

    # Testcase 76:  rd:x15(0xfffffffffffff7ff), imm:0x1d, result rd:x15(0xfffffffffffff81c)
    li x15, MASK_XLEN(0xfffffffffffff7ff)
    c.addi x15, SEXT_IMM(0x1d)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xfffffffffffff81c)

    # Testcase 77:  rd:x16(0xffffffffffffefff), imm:0x1e, result rd:x16(0xfffffffffffff01d)
    li x16, MASK_XLEN(0xffffffffffffefff)
    c.addi x16, SEXT_IMM(0x1e)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xfffffffffffff01d)

    # Testcase 78:  rd:x17(0xffffffffffffdfff), imm:0x1, result rd:x17(0xffffffffffffe000)
    li x17, MASK_XLEN(0xffffffffffffdfff)
    c.addi x17, SEXT_IMM(0x1)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xffffffffffffe000)

    # Testcase 79:  rd:x18(0xffffffffffffbfff), imm:0x10, result rd:x18(0xffffffffffffc00f)
    li x18, MASK_XLEN(0xffffffffffffbfff)
    c.addi x18, SEXT_IMM(0x10)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xffffffffffffc00f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rd:x19(0xffffffffffff7fff), imm:0x8, result rd:x19(0xffffffffffff8007)
    li x19, MASK_XLEN(0xffffffffffff7fff)
    c.addi x19, SEXT_IMM(0x8)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xffffffffffff8007)

    # Testcase 81:  rd:x20(0xfffffffffffeffff), imm:0x4, result rd:x20(0xffffffffffff0003)
    li x20, MASK_XLEN(0xfffffffffffeffff)
    c.addi x20, SEXT_IMM(0x4)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffffffffffff0003)

    # Testcase 82:  rd:x21(0xfffffffffffdffff), imm:0x2, result rd:x21(0xfffffffffffe0001)
    li x21, MASK_XLEN(0xfffffffffffdffff)
    c.addi x21, SEXT_IMM(0x2)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffffffffe0001)

    # Testcase 83:  rd:x22(0xfffffffffffbffff), imm:0x1, result rd:x22(0xfffffffffffc0000)
    li x22, MASK_XLEN(0xfffffffffffbffff)
    c.addi x22, SEXT_IMM(0x1)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffffffffffc0000)

    # Testcase 84:  rd:x23(0xfffffffffff7ffff), imm:0x1f, result rd:x23(0xfffffffffff8001e)
    li x23, MASK_XLEN(0xfffffffffff7ffff)
    c.addi x23, SEXT_IMM(0x1f)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffffffffff8001e)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rd:x24(0xffffffffffefffff), imm:0xf, result rd:x24(0xfffffffffff0000e)
    li x24, MASK_XLEN(0xffffffffffefffff)
    c.addi x24, SEXT_IMM(0xf)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xfffffffffff0000e)

    # Testcase 86:  rd:x25(0xffffffffffdfffff), imm:0x17, result rd:x25(0xffffffffffe00016)
    li x25, MASK_XLEN(0xffffffffffdfffff)
    c.addi x25, SEXT_IMM(0x17)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffffffe00016)

    # Testcase 87:  rd:x26(0xffffffffffbfffff), imm:0x1b, result rd:x26(0xffffffffffc0001a)
    li x26, MASK_XLEN(0xffffffffffbfffff)
    c.addi x26, SEXT_IMM(0x1b)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffffffffffc0001a)

    # Testcase 88:  rd:x27(0xffffffffff7fffff), imm:0x1d, result rd:x27(0xffffffffff80001c)
    li x27, MASK_XLEN(0xffffffffff7fffff)
    c.addi x27, SEXT_IMM(0x1d)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffffffffff80001c)

    # Testcase 89:  rd:x28(0xfffffffffeffffff), imm:0x1e, result rd:x28(0xffffffffff00001d)
    li x28, MASK_XLEN(0xfffffffffeffffff)
    c.addi x28, SEXT_IMM(0x1e)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xffffffffff00001d)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res


    # Testcase 90:  rd:x29(0xfffffffffdffffff), imm:0x1, result rd:x29(0xfffffffffe000000)
    li x29, MASK_XLEN(0xfffffffffdffffff)
    c.addi x29, SEXT_IMM(0x1)
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0xfffffffffe000000)

    # Testcase 91:  rd:x30(0xfffffffffbffffff), imm:0x10, result rd:x30(0xfffffffffc00000f)
    li x30, MASK_XLEN(0xfffffffffbffffff)
    c.addi x30, SEXT_IMM(0x10)
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfffffffffc00000f)

    # Testcase 92:  rd:x31(0xfffffffff7ffffff), imm:0x8, result rd:x31(0xfffffffff8000007)
    li x31, MASK_XLEN(0xfffffffff7ffffff)
    c.addi x31, SEXT_IMM(0x8)
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xfffffffff8000007)

    # Testcase 93:  rd:x1(0xffffffffefffffff), imm:0x4, result rd:x1(0xfffffffff0000003)
    li x1, MASK_XLEN(0xffffffffefffffff)
    c.addi x1, SEXT_IMM(0x4)
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xfffffffff0000003)

    # Testcase 94:  rd:x2(0xffffffffdfffffff), imm:0x2, result rd:x2(0xffffffffe0000001)
    li x2, MASK_XLEN(0xffffffffdfffffff)
    c.addi x2, SEXT_IMM(0x2)
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffffffffe0000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rd:x3(0xffffffffbfffffff), imm:0x1, result rd:x3(0xffffffffc0000000)
    li x3, MASK_XLEN(0xffffffffbfffffff)
    c.addi x3, SEXT_IMM(0x1)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffffc0000000)

    # Testcase 96:  rd:x4(0xffffffff7fffffff), imm:0x1f, result rd:x4(0xffffffff8000001e)
    li x4, MASK_XLEN(0xffffffff7fffffff)
    c.addi x4, SEXT_IMM(0x1f)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xffffffff8000001e)

    # Testcase 97:  rd:x5(0xfffffffeffffffff), imm:0xf, result rd:x5(0xffffffff0000000e)
    li x5, MASK_XLEN(0xfffffffeffffffff)
    c.addi x5, SEXT_IMM(0xf)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xffffffff0000000e)

    # Testcase 98:  rd:x6(0xfffffffdffffffff), imm:0x17, result rd:x6(0xfffffffe00000016)
    li x6, MASK_XLEN(0xfffffffdffffffff)
    c.addi x6, SEXT_IMM(0x17)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfffffffe00000016)

    # Testcase 99:  rd:x7(0xfffffffbffffffff), imm:0x1b, result rd:x7(0xfffffffc0000001a)
    li x7, MASK_XLEN(0xfffffffbffffffff)
    c.addi x7, SEXT_IMM(0x1b)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffc0000001a)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rd:x8(0xfffffff7ffffffff), imm:0x1d, result rd:x8(0xfffffff80000001c)
    li x8, MASK_XLEN(0xfffffff7ffffffff)
    c.addi x8, SEXT_IMM(0x1d)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffff80000001c)

    # Testcase 101:  rd:x9(0xffffffefffffffff), imm:0x1e, result rd:x9(0xfffffff00000001d)
    li x9, MASK_XLEN(0xffffffefffffffff)
    c.addi x9, SEXT_IMM(0x1e)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffff00000001d)

    # Testcase 102:  rd:x10(0xffffffdfffffffff), imm:0x1, result rd:x10(0xffffffe000000000)
    li x10, MASK_XLEN(0xffffffdfffffffff)
    c.addi x10, SEXT_IMM(0x1)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffe000000000)

    # Testcase 103:  rd:x11(0xffffffbfffffffff), imm:0x10, result rd:x11(0xffffffc00000000f)
    li x11, MASK_XLEN(0xffffffbfffffffff)
    c.addi x11, SEXT_IMM(0x10)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffc00000000f)

    # Testcase 104:  rd:x12(0xffffff7fffffffff), imm:0x8, result rd:x12(0xffffff8000000007)
    li x12, MASK_XLEN(0xffffff7fffffffff)
    c.addi x12, SEXT_IMM(0x8)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffff8000000007)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res


    # Testcase 105:  rd:x13(0xfffffeffffffffff), imm:0x4, result rd:x13(0xffffff0000000003)
    li x13, MASK_XLEN(0xfffffeffffffffff)
    c.addi x13, SEXT_IMM(0x4)
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0xffffff0000000003)

    # Testcase 106:  rd:x14(0xfffffdffffffffff), imm:0x2, result rd:x14(0xfffffe0000000001)
    li x14, MASK_XLEN(0xfffffdffffffffff)
    c.addi x14, SEXT_IMM(0x2)
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xfffffe0000000001)

    # Testcase 107:  rd:x15(0xfffffbffffffffff), imm:0x1, result rd:x15(0xfffffc0000000000)
    li x15, MASK_XLEN(0xfffffbffffffffff)
    c.addi x15, SEXT_IMM(0x1)
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xfffffc0000000000)

    # Testcase 108:  rd:x16(0xfffff7ffffffffff), imm:0x1f, result rd:x16(0xfffff8000000001e)
    li x16, MASK_XLEN(0xfffff7ffffffffff)
    c.addi x16, SEXT_IMM(0x1f)
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xfffff8000000001e)

    # Testcase 109:  rd:x17(0xffffefffffffffff), imm:0xf, result rd:x17(0xfffff0000000000e)
    li x17, MASK_XLEN(0xffffefffffffffff)
    c.addi x17, SEXT_IMM(0xf)
    sd x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xfffff0000000000e)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rd:x18(0xffffdfffffffffff), imm:0x17, result rd:x18(0xffffe00000000016)
    li x18, MASK_XLEN(0xffffdfffffffffff)
    c.addi x18, SEXT_IMM(0x17)
    sd x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0xffffe00000000016)

    # Testcase 111:  rd:x19(0xffffbfffffffffff), imm:0x1b, result rd:x19(0xffffc0000000001a)
    li x19, MASK_XLEN(0xffffbfffffffffff)
    c.addi x19, SEXT_IMM(0x1b)
    sd x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xffffc0000000001a)

    # Testcase 112:  rd:x20(0xffff7fffffffffff), imm:0x1d, result rd:x20(0xffff80000000001c)
    li x20, MASK_XLEN(0xffff7fffffffffff)
    c.addi x20, SEXT_IMM(0x1d)
    sd x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffff80000000001c)

    # Testcase 113:  rd:x21(0xfffeffffffffffff), imm:0x1e, result rd:x21(0xffff00000000001d)
    li x21, MASK_XLEN(0xfffeffffffffffff)
    c.addi x21, SEXT_IMM(0x1e)
    sd x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffff00000000001d)

    # Testcase 114:  rd:x22(0xfffdffffffffffff), imm:0x1, result rd:x22(0xfffe000000000000)
    li x22, MASK_XLEN(0xfffdffffffffffff)
    c.addi x22, SEXT_IMM(0x1)
    sd x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffe000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rd:x23(0xfffbffffffffffff), imm:0x10, result rd:x23(0xfffc00000000000f)
    li x23, MASK_XLEN(0xfffbffffffffffff)
    c.addi x23, SEXT_IMM(0x10)
    sd x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffc00000000000f)

    # Testcase 116:  rd:x24(0xfff7ffffffffffff), imm:0x8, result rd:x24(0xfff8000000000007)
    li x24, MASK_XLEN(0xfff7ffffffffffff)
    c.addi x24, SEXT_IMM(0x8)
    sd x24, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xfff8000000000007)

    # Testcase 117:  rd:x25(0xffefffffffffffff), imm:0x4, result rd:x25(0xfff0000000000003)
    li x25, MASK_XLEN(0xffefffffffffffff)
    c.addi x25, SEXT_IMM(0x4)
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfff0000000000003)

    # Testcase 118:  rd:x26(0xffdfffffffffffff), imm:0x2, result rd:x26(0xffe0000000000001)
    li x26, MASK_XLEN(0xffdfffffffffffff)
    c.addi x26, SEXT_IMM(0x2)
    sd x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffe0000000000001)

    # Testcase 119:  rd:x27(0xffbfffffffffffff), imm:0x1, result rd:x27(0xffc0000000000000)
    li x27, MASK_XLEN(0xffbfffffffffffff)
    c.addi x27, SEXT_IMM(0x1)
    sd x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffc0000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res


    # Testcase 120:  rd:x28(0xff7fffffffffffff), imm:0x1f, result rd:x28(0xff8000000000001e)
    li x28, MASK_XLEN(0xff7fffffffffffff)
    c.addi x28, SEXT_IMM(0x1f)
    sd x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0xff8000000000001e)

    # Testcase 121:  rd:x29(0xfeffffffffffffff), imm:0xf, result rd:x29(0xff0000000000000e)
    li x29, MASK_XLEN(0xfeffffffffffffff)
    c.addi x29, SEXT_IMM(0xf)
    sd x29, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0xff0000000000000e)

    # Testcase 122:  rd:x30(0xfdffffffffffffff), imm:0x17, result rd:x30(0xfe00000000000016)
    li x30, MASK_XLEN(0xfdffffffffffffff)
    c.addi x30, SEXT_IMM(0x17)
    sd x30, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0xfe00000000000016)

    # Testcase 123:  rd:x31(0xfbffffffffffffff), imm:0x1b, result rd:x31(0xfc0000000000001a)
    li x31, MASK_XLEN(0xfbffffffffffffff)
    c.addi x31, SEXT_IMM(0x1b)
    sd x31, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xfc0000000000001a)

    # Testcase 124:  rd:x1(0xf7ffffffffffffff), imm:0x1d, result rd:x1(0xf80000000000001c)
    li x1, MASK_XLEN(0xf7ffffffffffffff)
    c.addi x1, SEXT_IMM(0x1d)
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xf80000000000001c)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rd:x2(0xefffffffffffffff), imm:0x1e, result rd:x2(0xf00000000000001d)
    li x2, MASK_XLEN(0xefffffffffffffff)
    c.addi x2, SEXT_IMM(0x1e)
    sd x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xf00000000000001d)

    # Testcase 126:  rd:x3(0xdfffffffffffffff), imm:0x1, result rd:x3(0xe000000000000000)
    li x3, MASK_XLEN(0xdfffffffffffffff)
    c.addi x3, SEXT_IMM(0x1)
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xe000000000000000)

    # Testcase 127:  rd:x4(0xbfffffffffffffff), imm:0x10, result rd:x4(0xc00000000000000f)
    li x4, MASK_XLEN(0xbfffffffffffffff)
    c.addi x4, SEXT_IMM(0x10)
    sd x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xc00000000000000f)

    # Testcase 128:  rd:x5(0x7fffffffffffffff), imm:0x8, result rd:x5(0x8000000000000007)
    li x5, MASK_XLEN(0x7fffffffffffffff)
    c.addi x5, SEXT_IMM(0x8)
    sd x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x8000000000000007)

    # Testcase 129:  rd:x6(0xffffffffffffffff), imm:0x4, result rd:x6(0x00000003)
    li x6, MASK_XLEN(0xffffffffffffffff)
    c.addi x6, SEXT_IMM(0x4)
    sd x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0x3)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rd:x7(0x00000001), imm:0x1, result rd:x7(0x00000002)
    li x7, MASK_XLEN(0x1)
    c.addi x7, SEXT_IMM(0x1)
    sd x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x2)

    # Testcase 131:  rd:x8(0x00000002), imm:0x1, result rd:x8(0x00000003)
    li x8, MASK_XLEN(0x2)
    c.addi x8, SEXT_IMM(0x1)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x3)

    # Testcase 132:  rd:x9(0x00000004), imm:0x1, result rd:x9(0x00000005)
    li x9, MASK_XLEN(0x4)
    c.addi x9, SEXT_IMM(0x1)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x5)

    # Testcase 133:  rd:x10(0x00000008), imm:0x1, result rd:x10(0x00000009)
    li x10, MASK_XLEN(0x8)
    c.addi x10, SEXT_IMM(0x1)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x9)

    # Testcase 134:  rd:x11(0x00000010), imm:0x1, result rd:x11(0x00000011)
    li x11, MASK_XLEN(0x10)
    c.addi x11, SEXT_IMM(0x1)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x11)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res


    # Testcase 135:  rd:x12(0x00000020), imm:0x1, result rd:x12(0x00000021)
    li x12, MASK_XLEN(0x20)
    c.addi x12, SEXT_IMM(0x1)
    sd x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x21)

    # Testcase 136:  rd:x13(0x00000040), imm:0x1, result rd:x13(0x00000041)
    li x13, MASK_XLEN(0x40)
    c.addi x13, SEXT_IMM(0x1)
    sd x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x41)

    # Testcase 137:  rd:x14(0x00000080), imm:0x1, result rd:x14(0x00000081)
    li x14, MASK_XLEN(0x80)
    c.addi x14, SEXT_IMM(0x1)
    sd x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x81)

    # Testcase 138:  rd:x15(0x00000100), imm:0x1, result rd:x15(0x00000101)
    li x15, MASK_XLEN(0x100)
    c.addi x15, SEXT_IMM(0x1)
    sd x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x101)

    # Testcase 139:  rd:x16(0x00000200), imm:0x1, result rd:x16(0x00000201)
    li x16, MASK_XLEN(0x200)
    c.addi x16, SEXT_IMM(0x1)
    sd x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x201)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res


    # Testcase 140:  rd:x17(0x00000400), imm:0x1, result rd:x17(0x00000401)
    li x17, MASK_XLEN(0x400)
    c.addi x17, SEXT_IMM(0x1)
    sd x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x17, 0x401)

    # Testcase 141:  rd:x18(0x00000800), imm:0x1, result rd:x18(0x00000801)
    li x18, MASK_XLEN(0x800)
    c.addi x18, SEXT_IMM(0x1)
    sd x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x801)

    # Testcase 142:  rd:x19(0x00001000), imm:0x1, result rd:x19(0x00001001)
    li x19, MASK_XLEN(0x1000)
    c.addi x19, SEXT_IMM(0x1)
    sd x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x1001)

    # Testcase 143:  rd:x20(0x00002000), imm:0x1, result rd:x20(0x00002001)
    li x20, MASK_XLEN(0x2000)
    c.addi x20, SEXT_IMM(0x1)
    sd x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x2001)

    # Testcase 144:  rd:x21(0x00004000), imm:0x1, result rd:x21(0x00004001)
    li x21, MASK_XLEN(0x4000)
    c.addi x21, SEXT_IMM(0x1)
    sd x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x4001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res


    # Testcase 145:  rd:x22(0x00008000), imm:0x1, result rd:x22(0x00008001)
    li x22, MASK_XLEN(0x8000)
    c.addi x22, SEXT_IMM(0x1)
    sd x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x8001)

    # Testcase 146:  rd:x23(0x00010000), imm:0x1, result rd:x23(0x00010001)
    li x23, MASK_XLEN(0x10000)
    c.addi x23, SEXT_IMM(0x1)
    sd x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x10001)

    # Testcase 147:  rd:x24(0x00020000), imm:0x1, result rd:x24(0x00020001)
    li x24, MASK_XLEN(0x20000)
    c.addi x24, SEXT_IMM(0x1)
    sd x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x20001)

    # Testcase 148:  rd:x25(0x00040000), imm:0x1, result rd:x25(0x00040001)
    li x25, MASK_XLEN(0x40000)
    c.addi x25, SEXT_IMM(0x1)
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x40001)

    # Testcase 149:  rd:x26(0x00080000), imm:0x1, result rd:x26(0x00080001)
    li x26, MASK_XLEN(0x80000)
    c.addi x26, SEXT_IMM(0x1)
    sd x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x80001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x6, test_31_res


    # Testcase 150:  rd:x27(0x00100000), imm:0x1, result rd:x27(0x00100001)
    li x27, MASK_XLEN(0x100000)
    c.addi x27, SEXT_IMM(0x1)
    sd x27, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x100001)

    # Testcase 151:  rd:x28(0x00200000), imm:0x1, result rd:x28(0x00200001)
    li x28, MASK_XLEN(0x200000)
    c.addi x28, SEXT_IMM(0x1)
    sd x28, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x200001)

    # Testcase 152:  rd:x29(0x00400000), imm:0x1, result rd:x29(0x00400001)
    li x29, MASK_XLEN(0x400000)
    c.addi x29, SEXT_IMM(0x1)
    sd x29, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x400001)

    # Testcase 153:  rd:x30(0x00800000), imm:0x1, result rd:x30(0x00800001)
    li x30, MASK_XLEN(0x800000)
    c.addi x30, SEXT_IMM(0x1)
    sd x30, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x800001)

    # Testcase 154:  rd:x31(0x01000000), imm:0x1, result rd:x31(0x01000001)
    li x31, MASK_XLEN(0x1000000)
    c.addi x31, SEXT_IMM(0x1)
    sd x31, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x1000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x6, test_32_res


    # Testcase 155:  rd:x1(0x02000000), imm:0x1, result rd:x1(0x02000001)
    li x1, MASK_XLEN(0x2000000)
    c.addi x1, SEXT_IMM(0x1)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x2000001)

    # Testcase 156:  rd:x2(0x04000000), imm:0x1, result rd:x2(0x04000001)
    li x2, MASK_XLEN(0x4000000)
    c.addi x2, SEXT_IMM(0x1)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x4000001)

    # Testcase 157:  rd:x3(0x08000000), imm:0x1, result rd:x3(0x08000001)
    li x3, MASK_XLEN(0x8000000)
    c.addi x3, SEXT_IMM(0x1)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x8000001)

    # Testcase 158:  rd:x4(0x10000000), imm:0x1, result rd:x4(0x10000001)
    li x4, MASK_XLEN(0x10000000)
    c.addi x4, SEXT_IMM(0x1)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x10000001)

    # Testcase 159:  rd:x5(0x20000000), imm:0x1, result rd:x5(0x20000001)
    li x5, MASK_XLEN(0x20000000)
    c.addi x5, SEXT_IMM(0x1)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x20000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res


    # Testcase 160:  rd:x6(0x40000000), imm:0x1, result rd:x6(0x40000001)
    li x6, MASK_XLEN(0x40000000)
    c.addi x6, SEXT_IMM(0x1)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x40000001)

    # Testcase 161:  rd:x7(0x80000000), imm:0x1, result rd:x7(0x80000001)
    li x7, MASK_XLEN(0x80000000)
    c.addi x7, SEXT_IMM(0x1)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x80000001)

    # Testcase 162:  rd:x8(0x100000000), imm:0x1, result rd:x8(0x100000001)
    li x8, MASK_XLEN(0x100000000)
    c.addi x8, SEXT_IMM(0x1)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x100000001)

    # Testcase 163:  rd:x9(0x200000000), imm:0x1, result rd:x9(0x200000001)
    li x9, MASK_XLEN(0x200000000)
    c.addi x9, SEXT_IMM(0x1)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x200000001)

    # Testcase 164:  rd:x10(0x400000000), imm:0x1, result rd:x10(0x400000001)
    li x10, MASK_XLEN(0x400000000)
    c.addi x10, SEXT_IMM(0x1)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x400000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res


    # Testcase 165:  rd:x11(0x800000000), imm:0x1, result rd:x11(0x800000001)
    li x11, MASK_XLEN(0x800000000)
    c.addi x11, SEXT_IMM(0x1)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x800000001)

    # Testcase 166:  rd:x12(0x1000000000), imm:0x1, result rd:x12(0x1000000001)
    li x12, MASK_XLEN(0x1000000000)
    c.addi x12, SEXT_IMM(0x1)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x1000000001)

    # Testcase 167:  rd:x13(0x2000000000), imm:0x1, result rd:x13(0x2000000001)
    li x13, MASK_XLEN(0x2000000000)
    c.addi x13, SEXT_IMM(0x1)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x2000000001)

    # Testcase 168:  rd:x14(0x4000000000), imm:0x1, result rd:x14(0x4000000001)
    li x14, MASK_XLEN(0x4000000000)
    c.addi x14, SEXT_IMM(0x1)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x4000000001)

    # Testcase 169:  rd:x15(0x8000000000), imm:0x1, result rd:x15(0x8000000001)
    li x15, MASK_XLEN(0x8000000000)
    c.addi x15, SEXT_IMM(0x1)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x8000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x2, test_35_res


    # Testcase 170:  rd:x16(0x10000000000), imm:0x1, result rd:x16(0x10000000001)
    li x16, MASK_XLEN(0x10000000000)
    c.addi x16, SEXT_IMM(0x1)
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x10000000001)

    # Testcase 171:  rd:x17(0x20000000000), imm:0x1, result rd:x17(0x20000000001)
    li x17, MASK_XLEN(0x20000000000)
    c.addi x17, SEXT_IMM(0x1)
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x20000000001)

    # Testcase 172:  rd:x18(0x40000000000), imm:0x1, result rd:x18(0x40000000001)
    li x18, MASK_XLEN(0x40000000000)
    c.addi x18, SEXT_IMM(0x1)
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x40000000001)

    # Testcase 173:  rd:x19(0x80000000000), imm:0x1, result rd:x19(0x80000000001)
    li x19, MASK_XLEN(0x80000000000)
    c.addi x19, SEXT_IMM(0x1)
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x80000000001)

    # Testcase 174:  rd:x20(0x100000000000), imm:0x1, result rd:x20(0x100000000001)
    li x20, MASK_XLEN(0x100000000000)
    c.addi x20, SEXT_IMM(0x1)
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x100000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res


    # Testcase 175:  rd:x21(0x200000000000), imm:0x1, result rd:x21(0x200000000001)
    li x21, MASK_XLEN(0x200000000000)
    c.addi x21, SEXT_IMM(0x1)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x200000000001)

    # Testcase 176:  rd:x22(0x400000000000), imm:0x1, result rd:x22(0x400000000001)
    li x22, MASK_XLEN(0x400000000000)
    c.addi x22, SEXT_IMM(0x1)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x400000000001)

    # Testcase 177:  rd:x23(0x800000000000), imm:0x1, result rd:x23(0x800000000001)
    li x23, MASK_XLEN(0x800000000000)
    c.addi x23, SEXT_IMM(0x1)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x800000000001)

    # Testcase 178:  rd:x24(0x1000000000000), imm:0x1, result rd:x24(0x1000000000001)
    li x24, MASK_XLEN(0x1000000000000)
    c.addi x24, SEXT_IMM(0x1)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x1000000000001)

    # Testcase 179:  rd:x25(0x2000000000000), imm:0x1, result rd:x25(0x2000000000001)
    li x25, MASK_XLEN(0x2000000000000)
    c.addi x25, SEXT_IMM(0x1)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x2000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res


    # Testcase 180:  rd:x26(0x4000000000000), imm:0x1, result rd:x26(0x4000000000001)
    li x26, MASK_XLEN(0x4000000000000)
    c.addi x26, SEXT_IMM(0x1)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x4000000000001)

    # Testcase 181:  rd:x27(0x8000000000000), imm:0x1, result rd:x27(0x8000000000001)
    li x27, MASK_XLEN(0x8000000000000)
    c.addi x27, SEXT_IMM(0x1)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x8000000000001)

    # Testcase 182:  rd:x28(0x10000000000000), imm:0x1, result rd:x28(0x10000000000001)
    li x28, MASK_XLEN(0x10000000000000)
    c.addi x28, SEXT_IMM(0x1)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x10000000000001)

    # Testcase 183:  rd:x29(0x20000000000000), imm:0x1, result rd:x29(0x20000000000001)
    li x29, MASK_XLEN(0x20000000000000)
    c.addi x29, SEXT_IMM(0x1)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x20000000000001)

    # Testcase 184:  rd:x30(0x40000000000000), imm:0x1, result rd:x30(0x40000000000001)
    li x30, MASK_XLEN(0x40000000000000)
    c.addi x30, SEXT_IMM(0x1)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x40000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x5, test_38_res


    # Testcase 185:  rd:x31(0x80000000000000), imm:0x1, result rd:x31(0x80000000000001)
    li x31, MASK_XLEN(0x80000000000000)
    c.addi x31, SEXT_IMM(0x1)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x80000000000001)

    # Testcase 186:  rd:x1(0x100000000000000), imm:0x1, result rd:x1(0x100000000000001)
    li x1, MASK_XLEN(0x100000000000000)
    c.addi x1, SEXT_IMM(0x1)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x100000000000001)

    # Testcase 187:  rd:x2(0x200000000000000), imm:0x1, result rd:x2(0x200000000000001)
    li x2, MASK_XLEN(0x200000000000000)
    c.addi x2, SEXT_IMM(0x1)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x200000000000001)

    # Testcase 188:  rd:x3(0x400000000000000), imm:0x1, result rd:x3(0x400000000000001)
    li x3, MASK_XLEN(0x400000000000000)
    c.addi x3, SEXT_IMM(0x1)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x400000000000001)

    # Testcase 189:  rd:x4(0x800000000000000), imm:0x1, result rd:x4(0x800000000000001)
    li x4, MASK_XLEN(0x800000000000000)
    c.addi x4, SEXT_IMM(0x1)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x800000000000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res


    # Testcase 190:  rd:x5(0x1000000000000000), imm:0x1, result rd:x5(0x1000000000000001)
    li x5, MASK_XLEN(0x1000000000000000)
    c.addi x5, SEXT_IMM(0x1)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x1000000000000001)

    # Testcase 191:  rd:x6(0x2000000000000000), imm:0x1, result rd:x6(0x2000000000000001)
    li x6, MASK_XLEN(0x2000000000000000)
    c.addi x6, SEXT_IMM(0x1)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x2000000000000001)

    # Testcase 192:  rd:x7(0x4000000000000000), imm:0x1, result rd:x7(0x4000000000000001)
    li x7, MASK_XLEN(0x4000000000000000)
    c.addi x7, SEXT_IMM(0x1)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x4000000000000001)

    # Testcase 193:  rd:x8(0x8000000000000000), imm:0x1, result rd:x8(0x8000000000000001)
    li x8, MASK_XLEN(0x8000000000000000)
    c.addi x8, SEXT_IMM(0x1)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8000000000000001)

    # Testcase 194:  rd:x9(0x00000000), imm:0x1, result rd:x9(0x00000001)
    li x9, MASK_XLEN(0x0)
    c.addi x9, SEXT_IMM(0x1)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res


    # Testcase 195:  rd:x10(0xfffffffffffffffe), imm:0x1, result rd:x10(0xffffffffffffffff)
    li x10, MASK_XLEN(0xfffffffffffffffe)
    c.addi x10, SEXT_IMM(0x1)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffffffff)

    # Testcase 196:  rd:x11(0xfffffffffffffffd), imm:0x1, result rd:x11(0xfffffffffffffffe)
    li x11, MASK_XLEN(0xfffffffffffffffd)
    c.addi x11, SEXT_IMM(0x1)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffffffffffe)

    # Testcase 197:  rd:x12(0xfffffffffffffffb), imm:0x1, result rd:x12(0xfffffffffffffffc)
    li x12, MASK_XLEN(0xfffffffffffffffb)
    c.addi x12, SEXT_IMM(0x1)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffffffffc)

    # Testcase 198:  rd:x13(0xfffffffffffffff7), imm:0x1, result rd:x13(0xfffffffffffffff8)
    li x13, MASK_XLEN(0xfffffffffffffff7)
    c.addi x13, SEXT_IMM(0x1)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffffffff8)

    # Testcase 199:  rd:x14(0xffffffffffffffef), imm:0x1, result rd:x14(0xfffffffffffffff0)
    li x14, MASK_XLEN(0xffffffffffffffef)
    c.addi x14, SEXT_IMM(0x1)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffffffffffff0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x3, test_41_res


    # Testcase 200:  rd:x15(0xffffffffffffffdf), imm:0x1, result rd:x15(0xffffffffffffffe0)
    li x15, MASK_XLEN(0xffffffffffffffdf)
    c.addi x15, SEXT_IMM(0x1)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0xffffffffffffffe0)

    # Testcase 201:  rd:x16(0xffffffffffffffbf), imm:0x1, result rd:x16(0xffffffffffffffc0)
    li x16, MASK_XLEN(0xffffffffffffffbf)
    c.addi x16, SEXT_IMM(0x1)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0xffffffffffffffc0)

    # Testcase 202:  rd:x17(0xffffffffffffff7f), imm:0x1, result rd:x17(0xffffffffffffff80)
    li x17, MASK_XLEN(0xffffffffffffff7f)
    c.addi x17, SEXT_IMM(0x1)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xffffffffffffff80)

    # Testcase 203:  rd:x18(0xfffffffffffffeff), imm:0x1, result rd:x18(0xffffffffffffff00)
    li x18, MASK_XLEN(0xfffffffffffffeff)
    c.addi x18, SEXT_IMM(0x1)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0xffffffffffffff00)

    # Testcase 204:  rd:x19(0xfffffffffffffdff), imm:0x1, result rd:x19(0xfffffffffffffe00)
    li x19, MASK_XLEN(0xfffffffffffffdff)
    c.addi x19, SEXT_IMM(0x1)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xfffffffffffffe00)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res


    # Testcase 205:  rd:x20(0xfffffffffffffbff), imm:0x1, result rd:x20(0xfffffffffffffc00)
    li x20, MASK_XLEN(0xfffffffffffffbff)
    c.addi x20, SEXT_IMM(0x1)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffffffffffffc00)

    # Testcase 206:  rd:x21(0xfffffffffffff7ff), imm:0x1, result rd:x21(0xfffffffffffff800)
    li x21, MASK_XLEN(0xfffffffffffff7ff)
    c.addi x21, SEXT_IMM(0x1)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffffffffff800)

    # Testcase 207:  rd:x22(0xffffffffffffefff), imm:0x1, result rd:x22(0xfffffffffffff000)
    li x22, MASK_XLEN(0xffffffffffffefff)
    c.addi x22, SEXT_IMM(0x1)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffffffffffff000)

    # Testcase 208:  rd:x23(0xffffffffffffdfff), imm:0x1, result rd:x23(0xffffffffffffe000)
    li x23, MASK_XLEN(0xffffffffffffdfff)
    c.addi x23, SEXT_IMM(0x1)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffffffffffe000)

    # Testcase 209:  rd:x24(0xffffffffffffbfff), imm:0x1, result rd:x24(0xffffffffffffc000)
    li x24, MASK_XLEN(0xffffffffffffbfff)
    c.addi x24, SEXT_IMM(0x1)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffffffffffffc000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res


    # Testcase 210:  rd:x25(0xffffffffffff7fff), imm:0x1, result rd:x25(0xffffffffffff8000)
    li x25, MASK_XLEN(0xffffffffffff7fff)
    c.addi x25, SEXT_IMM(0x1)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffffffff8000)

    # Testcase 211:  rd:x26(0xfffffffffffeffff), imm:0x1, result rd:x26(0xffffffffffff0000)
    li x26, MASK_XLEN(0xfffffffffffeffff)
    c.addi x26, SEXT_IMM(0x1)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffffffffffff0000)

    # Testcase 212:  rd:x27(0xfffffffffffdffff), imm:0x1, result rd:x27(0xfffffffffffe0000)
    li x27, MASK_XLEN(0xfffffffffffdffff)
    c.addi x27, SEXT_IMM(0x1)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfffffffffffe0000)

    # Testcase 213:  rd:x28(0xfffffffffffbffff), imm:0x1, result rd:x28(0xfffffffffffc0000)
    li x28, MASK_XLEN(0xfffffffffffbffff)
    c.addi x28, SEXT_IMM(0x1)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffffffffffc0000)

    # Testcase 214:  rd:x29(0xfffffffffff7ffff), imm:0x1, result rd:x29(0xfffffffffff80000)
    li x29, MASK_XLEN(0xfffffffffff7ffff)
    c.addi x29, SEXT_IMM(0x1)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xfffffffffff80000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x4, test_44_res


    # Testcase 215:  rd:x30(0xffffffffffefffff), imm:0x1, result rd:x30(0xfffffffffff00000)
    li x30, MASK_XLEN(0xffffffffffefffff)
    c.addi x30, SEXT_IMM(0x1)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfffffffffff00000)

    # Testcase 216:  rd:x31(0xffffffffffdfffff), imm:0x1, result rd:x31(0xffffffffffe00000)
    li x31, MASK_XLEN(0xffffffffffdfffff)
    c.addi x31, SEXT_IMM(0x1)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xffffffffffe00000)

    # Testcase 217:  rd:x1(0xffffffffffbfffff), imm:0x1, result rd:x1(0xffffffffffc00000)
    li x1, MASK_XLEN(0xffffffffffbfffff)
    c.addi x1, SEXT_IMM(0x1)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffffffffffc00000)

    # Testcase 218:  rd:x2(0xffffffffff7fffff), imm:0x1, result rd:x2(0xffffffffff800000)
    li x2, MASK_XLEN(0xffffffffff7fffff)
    c.addi x2, SEXT_IMM(0x1)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffffffffff800000)

    # Testcase 219:  rd:x3(0xfffffffffeffffff), imm:0x1, result rd:x3(0xffffffffff000000)
    li x3, MASK_XLEN(0xfffffffffeffffff)
    c.addi x3, SEXT_IMM(0x1)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xffffffffff000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res


    # Testcase 220:  rd:x4(0xfffffffffdffffff), imm:0x1, result rd:x4(0xfffffffffe000000)
    li x4, MASK_XLEN(0xfffffffffdffffff)
    c.addi x4, SEXT_IMM(0x1)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xfffffffffe000000)

    # Testcase 221:  rd:x5(0xfffffffffbffffff), imm:0x1, result rd:x5(0xfffffffffc000000)
    li x5, MASK_XLEN(0xfffffffffbffffff)
    c.addi x5, SEXT_IMM(0x1)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffffffc000000)

    # Testcase 222:  rd:x6(0xfffffffff7ffffff), imm:0x1, result rd:x6(0xfffffffff8000000)
    li x6, MASK_XLEN(0xfffffffff7ffffff)
    c.addi x6, SEXT_IMM(0x1)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfffffffff8000000)

    # Testcase 223:  rd:x7(0xffffffffefffffff), imm:0x1, result rd:x7(0xfffffffff0000000)
    li x7, MASK_XLEN(0xffffffffefffffff)
    c.addi x7, SEXT_IMM(0x1)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffff0000000)

    # Testcase 224:  rd:x8(0xffffffffdfffffff), imm:0x1, result rd:x8(0xffffffffe0000000)
    li x8, MASK_XLEN(0xffffffffdfffffff)
    c.addi x8, SEXT_IMM(0x1)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffe0000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res


    # Testcase 225:  rd:x9(0xffffffffbfffffff), imm:0x1, result rd:x9(0xffffffffc0000000)
    li x9, MASK_XLEN(0xffffffffbfffffff)
    c.addi x9, SEXT_IMM(0x1)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffc0000000)

    # Testcase 226:  rd:x10(0xffffffff7fffffff), imm:0x1, result rd:x10(0xffffffff80000000)
    li x10, MASK_XLEN(0xffffffff7fffffff)
    c.addi x10, SEXT_IMM(0x1)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffff80000000)

    # Testcase 227:  rd:x11(0xfffffffeffffffff), imm:0x1, result rd:x11(0xffffffff00000000)
    li x11, MASK_XLEN(0xfffffffeffffffff)
    c.addi x11, SEXT_IMM(0x1)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffff00000000)

    # Testcase 228:  rd:x12(0xfffffffdffffffff), imm:0x1, result rd:x12(0xfffffffe00000000)
    li x12, MASK_XLEN(0xfffffffdffffffff)
    c.addi x12, SEXT_IMM(0x1)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffe00000000)

    # Testcase 229:  rd:x13(0xfffffffbffffffff), imm:0x1, result rd:x13(0xfffffffc00000000)
    li x13, MASK_XLEN(0xfffffffbffffffff)
    c.addi x13, SEXT_IMM(0x1)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffc00000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x4, test_47_res


    # Testcase 230:  rd:x14(0xfffffff7ffffffff), imm:0x1, result rd:x14(0xfffffff800000000)
    li x14, MASK_XLEN(0xfffffff7ffffffff)
    c.addi x14, SEXT_IMM(0x1)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xfffffff800000000)

    # Testcase 231:  rd:x15(0xffffffefffffffff), imm:0x1, result rd:x15(0xfffffff000000000)
    li x15, MASK_XLEN(0xffffffefffffffff)
    c.addi x15, SEXT_IMM(0x1)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xfffffff000000000)

    # Testcase 232:  rd:x16(0xffffffdfffffffff), imm:0x1, result rd:x16(0xffffffe000000000)
    li x16, MASK_XLEN(0xffffffdfffffffff)
    c.addi x16, SEXT_IMM(0x1)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffffffe000000000)

    # Testcase 233:  rd:x17(0xffffffbfffffffff), imm:0x1, result rd:x17(0xffffffc000000000)
    li x17, MASK_XLEN(0xffffffbfffffffff)
    c.addi x17, SEXT_IMM(0x1)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xffffffc000000000)

    # Testcase 234:  rd:x18(0xffffff7fffffffff), imm:0x1, result rd:x18(0xffffff8000000000)
    li x18, MASK_XLEN(0xffffff7fffffffff)
    c.addi x18, SEXT_IMM(0x1)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xffffff8000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res


    # Testcase 235:  rd:x19(0xfffffeffffffffff), imm:0x1, result rd:x19(0xffffff0000000000)
    li x19, MASK_XLEN(0xfffffeffffffffff)
    c.addi x19, SEXT_IMM(0x1)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xffffff0000000000)

    # Testcase 236:  rd:x20(0xfffffdffffffffff), imm:0x1, result rd:x20(0xfffffe0000000000)
    li x20, MASK_XLEN(0xfffffdffffffffff)
    c.addi x20, SEXT_IMM(0x1)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffffe0000000000)

    # Testcase 237:  rd:x21(0xfffffbffffffffff), imm:0x1, result rd:x21(0xfffffc0000000000)
    li x21, MASK_XLEN(0xfffffbffffffffff)
    c.addi x21, SEXT_IMM(0x1)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffc0000000000)

    # Testcase 238:  rd:x22(0xfffff7ffffffffff), imm:0x1, result rd:x22(0xfffff80000000000)
    li x22, MASK_XLEN(0xfffff7ffffffffff)
    c.addi x22, SEXT_IMM(0x1)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffff80000000000)

    # Testcase 239:  rd:x23(0xffffefffffffffff), imm:0x1, result rd:x23(0xfffff00000000000)
    li x23, MASK_XLEN(0xffffefffffffffff)
    c.addi x23, SEXT_IMM(0x1)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffff00000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res


    # Testcase 240:  rd:x24(0xffffdfffffffffff), imm:0x1, result rd:x24(0xffffe00000000000)
    li x24, MASK_XLEN(0xffffdfffffffffff)
    c.addi x24, SEXT_IMM(0x1)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffffe00000000000)

    # Testcase 241:  rd:x25(0xffffbfffffffffff), imm:0x1, result rd:x25(0xffffc00000000000)
    li x25, MASK_XLEN(0xffffbfffffffffff)
    c.addi x25, SEXT_IMM(0x1)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffc00000000000)

    # Testcase 242:  rd:x26(0xffff7fffffffffff), imm:0x1, result rd:x26(0xffff800000000000)
    li x26, MASK_XLEN(0xffff7fffffffffff)
    c.addi x26, SEXT_IMM(0x1)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffff800000000000)

    # Testcase 243:  rd:x27(0xfffeffffffffffff), imm:0x1, result rd:x27(0xffff000000000000)
    li x27, MASK_XLEN(0xfffeffffffffffff)
    c.addi x27, SEXT_IMM(0x1)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffff000000000000)

    # Testcase 244:  rd:x28(0xfffdffffffffffff), imm:0x1, result rd:x28(0xfffe000000000000)
    li x28, MASK_XLEN(0xfffdffffffffffff)
    c.addi x28, SEXT_IMM(0x1)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffe000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x4, test_50_res


    # Testcase 245:  rd:x29(0xfffbffffffffffff), imm:0x1, result rd:x29(0xfffc000000000000)
    li x29, MASK_XLEN(0xfffbffffffffffff)
    c.addi x29, SEXT_IMM(0x1)
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0xfffc000000000000)

    # Testcase 246:  rd:x30(0xfff7ffffffffffff), imm:0x1, result rd:x30(0xfff8000000000000)
    li x30, MASK_XLEN(0xfff7ffffffffffff)
    c.addi x30, SEXT_IMM(0x1)
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfff8000000000000)

    # Testcase 247:  rd:x31(0xffefffffffffffff), imm:0x1, result rd:x31(0xfff0000000000000)
    li x31, MASK_XLEN(0xffefffffffffffff)
    c.addi x31, SEXT_IMM(0x1)
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xfff0000000000000)

    # Testcase 248:  rd:x1(0xffdfffffffffffff), imm:0x1, result rd:x1(0xffe0000000000000)
    li x1, MASK_XLEN(0xffdfffffffffffff)
    c.addi x1, SEXT_IMM(0x1)
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffe0000000000000)

    # Testcase 249:  rd:x2(0xffbfffffffffffff), imm:0x1, result rd:x2(0xffc0000000000000)
    li x2, MASK_XLEN(0xffbfffffffffffff)
    c.addi x2, SEXT_IMM(0x1)
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffc0000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res


    # Testcase 250:  rd:x3(0xff7fffffffffffff), imm:0x1, result rd:x3(0xff80000000000000)
    li x3, MASK_XLEN(0xff7fffffffffffff)
    c.addi x3, SEXT_IMM(0x1)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xff80000000000000)

    # Testcase 251:  rd:x4(0xfeffffffffffffff), imm:0x1, result rd:x4(0xff00000000000000)
    li x4, MASK_XLEN(0xfeffffffffffffff)
    c.addi x4, SEXT_IMM(0x1)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xff00000000000000)

    # Testcase 252:  rd:x5(0xfdffffffffffffff), imm:0x1, result rd:x5(0xfe00000000000000)
    li x5, MASK_XLEN(0xfdffffffffffffff)
    c.addi x5, SEXT_IMM(0x1)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfe00000000000000)

    # Testcase 253:  rd:x6(0xfbffffffffffffff), imm:0x1, result rd:x6(0xfc00000000000000)
    li x6, MASK_XLEN(0xfbffffffffffffff)
    c.addi x6, SEXT_IMM(0x1)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfc00000000000000)

    # Testcase 254:  rd:x7(0xf7ffffffffffffff), imm:0x1, result rd:x7(0xf800000000000000)
    li x7, MASK_XLEN(0xf7ffffffffffffff)
    c.addi x7, SEXT_IMM(0x1)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xf800000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res


    # Testcase 255:  rd:x8(0xefffffffffffffff), imm:0x1, result rd:x8(0xf000000000000000)
    li x8, MASK_XLEN(0xefffffffffffffff)
    c.addi x8, SEXT_IMM(0x1)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xf000000000000000)

    # Testcase 256:  rd:x9(0xdfffffffffffffff), imm:0x1, result rd:x9(0xe000000000000000)
    li x9, MASK_XLEN(0xdfffffffffffffff)
    c.addi x9, SEXT_IMM(0x1)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xe000000000000000)

    # Testcase 257:  rd:x10(0xbfffffffffffffff), imm:0x1, result rd:x10(0xc000000000000000)
    li x10, MASK_XLEN(0xbfffffffffffffff)
    c.addi x10, SEXT_IMM(0x1)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xc000000000000000)

    # Testcase 258:  rd:x11(0x7fffffffffffffff), imm:0x1, result rd:x11(0x8000000000000000)
    li x11, MASK_XLEN(0x7fffffffffffffff)
    c.addi x11, SEXT_IMM(0x1)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8000000000000000)

    # Testcase 259:  rd:x12(0xffffffffffffffff), imm:0x1, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xffffffffffffffff)
    c.addi x12, SEXT_IMM(0x1)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x2, test_53_res


    # Testcase 260:  rd:x13(0x00000001), imm:0x8, result rd:x13(0x00000009)
    li x13, MASK_XLEN(0x1)
    c.addi x13, SEXT_IMM(0x8)
    sd x13, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x13, 0x9)

    # Testcase 261:  rd:x0(0x00000002), imm:0x4, result rd:x0(0x00000000)
    li x0, MASK_XLEN(0x2)
    c.addi x0, SEXT_IMM(0x4)
    sd x0, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x0, 0x0)

    # Testcase 262:  rd:x15(0x00000004), imm:0x2, result rd:x15(0x00000006)
    li x15, MASK_XLEN(0x4)
    c.addi x15, SEXT_IMM(0x2)
    sd x15, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x6)

    # Testcase 263:  rd:x16(0x00000008), imm:0x1, result rd:x16(0x00000009)
    li x16, MASK_XLEN(0x8)
    c.addi x16, SEXT_IMM(0x1)
    sd x16, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x9)


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

