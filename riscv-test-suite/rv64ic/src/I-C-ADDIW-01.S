# RISC-V Compliance Test I-C-ADDIW-01
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
# Description: Testing instruction 'c.addiw'.

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
    c.addiw x1, SEXT_IMM(0x1f)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x20)

    # Testcase 1:  rd:x2(0x00000002), imm:0xf, result rd:x2(0x00000011)
    li x2, MASK_XLEN(0x2)
    c.addiw x2, SEXT_IMM(0xf)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x11)

    # Testcase 2:  rd:x3(0x00000004), imm:0x17, result rd:x3(0x0000001b)
    li x3, MASK_XLEN(0x4)
    c.addiw x3, SEXT_IMM(0x17)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x1b)

    # Testcase 3:  rd:x4(0x00000008), imm:0x1b, result rd:x4(0x00000023)
    li x4, MASK_XLEN(0x8)
    c.addiw x4, SEXT_IMM(0x1b)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x23)

    # Testcase 4:  rd:x5(0x00000010), imm:0x1d, result rd:x5(0x0000002d)
    li x5, MASK_XLEN(0x10)
    c.addiw x5, SEXT_IMM(0x1d)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x2d)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rd:x6(0x00000020), imm:0x1e, result rd:x6(0x0000003e)
    li x6, MASK_XLEN(0x20)
    c.addiw x6, SEXT_IMM(0x1e)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x3e)

    # Testcase 6:  rd:x7(0x00000040), imm:0x0, result rd:x7(0x00000040)
    li x7, MASK_XLEN(0x40)
    c.addiw x7, SEXT_IMM(0x0)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x40)

    # Testcase 7:  rd:x8(0x00000080), imm:0x10, result rd:x8(0x00000090)
    li x8, MASK_XLEN(0x80)
    c.addiw x8, SEXT_IMM(0x10)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x90)

    # Testcase 8:  rd:x9(0x00000100), imm:0x8, result rd:x9(0x00000108)
    li x9, MASK_XLEN(0x100)
    c.addiw x9, SEXT_IMM(0x8)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x108)

    # Testcase 9:  rd:x10(0x00000200), imm:0x4, result rd:x10(0x00000204)
    li x10, MASK_XLEN(0x200)
    c.addiw x10, SEXT_IMM(0x4)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x204)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rd:x11(0x00000400), imm:0x2, result rd:x11(0x00000402)
    li x11, MASK_XLEN(0x400)
    c.addiw x11, SEXT_IMM(0x2)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x402)

    # Testcase 11:  rd:x12(0x00000800), imm:0x1, result rd:x12(0x00000801)
    li x12, MASK_XLEN(0x800)
    c.addiw x12, SEXT_IMM(0x1)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x801)

    # Testcase 12:  rd:x13(0x00001000), imm:0x1f, result rd:x13(0x0000101f)
    li x13, MASK_XLEN(0x1000)
    c.addiw x13, SEXT_IMM(0x1f)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x101f)

    # Testcase 13:  rd:x14(0x00002000), imm:0xf, result rd:x14(0x0000200f)
    li x14, MASK_XLEN(0x2000)
    c.addiw x14, SEXT_IMM(0xf)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x200f)

    # Testcase 14:  rd:x15(0x00004000), imm:0x17, result rd:x15(0x00004017)
    li x15, MASK_XLEN(0x4000)
    c.addiw x15, SEXT_IMM(0x17)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x4017)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res


    # Testcase 15:  rd:x16(0x00008000), imm:0x1b, result rd:x16(0x0000801b)
    li x16, MASK_XLEN(0x8000)
    c.addiw x16, SEXT_IMM(0x1b)
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x801b)

    # Testcase 16:  rd:x17(0x00010000), imm:0x1d, result rd:x17(0x0001001d)
    li x17, MASK_XLEN(0x10000)
    c.addiw x17, SEXT_IMM(0x1d)
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x1001d)

    # Testcase 17:  rd:x18(0x00020000), imm:0x1e, result rd:x18(0x0002001e)
    li x18, MASK_XLEN(0x20000)
    c.addiw x18, SEXT_IMM(0x1e)
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x2001e)

    # Testcase 18:  rd:x19(0x00040000), imm:0x0, result rd:x19(0x00040000)
    li x19, MASK_XLEN(0x40000)
    c.addiw x19, SEXT_IMM(0x0)
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x40000)

    # Testcase 19:  rd:x20(0x00080000), imm:0x10, result rd:x20(0x00080010)
    li x20, MASK_XLEN(0x80000)
    c.addiw x20, SEXT_IMM(0x10)
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x80010)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rd:x21(0x00100000), imm:0x8, result rd:x21(0x00100008)
    li x21, MASK_XLEN(0x100000)
    c.addiw x21, SEXT_IMM(0x8)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x100008)

    # Testcase 21:  rd:x22(0x00200000), imm:0x4, result rd:x22(0x00200004)
    li x22, MASK_XLEN(0x200000)
    c.addiw x22, SEXT_IMM(0x4)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x200004)

    # Testcase 22:  rd:x23(0x00400000), imm:0x2, result rd:x23(0x00400002)
    li x23, MASK_XLEN(0x400000)
    c.addiw x23, SEXT_IMM(0x2)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x400002)

    # Testcase 23:  rd:x24(0x00800000), imm:0x1, result rd:x24(0x00800001)
    li x24, MASK_XLEN(0x800000)
    c.addiw x24, SEXT_IMM(0x1)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x800001)

    # Testcase 24:  rd:x25(0x01000000), imm:0x1f, result rd:x25(0x0100001f)
    li x25, MASK_XLEN(0x1000000)
    c.addiw x25, SEXT_IMM(0x1f)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x100001f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rd:x26(0x02000000), imm:0xf, result rd:x26(0x0200000f)
    li x26, MASK_XLEN(0x2000000)
    c.addiw x26, SEXT_IMM(0xf)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x200000f)

    # Testcase 26:  rd:x27(0x04000000), imm:0x17, result rd:x27(0x04000017)
    li x27, MASK_XLEN(0x4000000)
    c.addiw x27, SEXT_IMM(0x17)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x4000017)

    # Testcase 27:  rd:x28(0x08000000), imm:0x1b, result rd:x28(0x0800001b)
    li x28, MASK_XLEN(0x8000000)
    c.addiw x28, SEXT_IMM(0x1b)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x800001b)

    # Testcase 28:  rd:x29(0x10000000), imm:0x1d, result rd:x29(0x1000001d)
    li x29, MASK_XLEN(0x10000000)
    c.addiw x29, SEXT_IMM(0x1d)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x1000001d)

    # Testcase 29:  rd:x30(0x20000000), imm:0x1e, result rd:x30(0x2000001e)
    li x30, MASK_XLEN(0x20000000)
    c.addiw x30, SEXT_IMM(0x1e)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x2000001e)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res


    # Testcase 30:  rd:x31(0x40000000), imm:0x0, result rd:x31(0x40000000)
    li x31, MASK_XLEN(0x40000000)
    c.addiw x31, SEXT_IMM(0x0)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x40000000)

    # Testcase 31:  rd:x1(0x80000000), imm:0x10, result rd:x1(0xffffffff80000010)
    li x1, MASK_XLEN(0x80000000)
    c.addiw x1, SEXT_IMM(0x10)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xffffffff80000010)

    # Testcase 32:  rd:x2(0x100000000), imm:0x8, result rd:x2(0x00000008)
    li x2, MASK_XLEN(0x100000000)
    c.addiw x2, SEXT_IMM(0x8)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x8)

    # Testcase 33:  rd:x3(0x200000000), imm:0x4, result rd:x3(0x00000004)
    li x3, MASK_XLEN(0x200000000)
    c.addiw x3, SEXT_IMM(0x4)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x4)

    # Testcase 34:  rd:x4(0x400000000), imm:0x2, result rd:x4(0x00000002)
    li x4, MASK_XLEN(0x400000000)
    c.addiw x4, SEXT_IMM(0x2)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x2)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rd:x5(0x800000000), imm:0x1, result rd:x5(0x00000001)
    li x5, MASK_XLEN(0x800000000)
    c.addiw x5, SEXT_IMM(0x1)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x1)

    # Testcase 36:  rd:x6(0x1000000000), imm:0x1f, result rd:x6(0x0000001f)
    li x6, MASK_XLEN(0x1000000000)
    c.addiw x6, SEXT_IMM(0x1f)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x1f)

    # Testcase 37:  rd:x7(0x2000000000), imm:0xf, result rd:x7(0x0000000f)
    li x7, MASK_XLEN(0x2000000000)
    c.addiw x7, SEXT_IMM(0xf)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xf)

    # Testcase 38:  rd:x8(0x4000000000), imm:0x17, result rd:x8(0x00000017)
    li x8, MASK_XLEN(0x4000000000)
    c.addiw x8, SEXT_IMM(0x17)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x17)

    # Testcase 39:  rd:x9(0x8000000000), imm:0x1b, result rd:x9(0x0000001b)
    li x9, MASK_XLEN(0x8000000000)
    c.addiw x9, SEXT_IMM(0x1b)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1b)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rd:x10(0x10000000000), imm:0x1d, result rd:x10(0x0000001d)
    li x10, MASK_XLEN(0x10000000000)
    c.addiw x10, SEXT_IMM(0x1d)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1d)

    # Testcase 41:  rd:x11(0x20000000000), imm:0x1e, result rd:x11(0x0000001e)
    li x11, MASK_XLEN(0x20000000000)
    c.addiw x11, SEXT_IMM(0x1e)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1e)

    # Testcase 42:  rd:x12(0x40000000000), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x40000000000)
    c.addiw x12, SEXT_IMM(0x0)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 43:  rd:x13(0x80000000000), imm:0x10, result rd:x13(0x00000010)
    li x13, MASK_XLEN(0x80000000000)
    c.addiw x13, SEXT_IMM(0x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x10)

    # Testcase 44:  rd:x14(0x100000000000), imm:0x8, result rd:x14(0x00000008)
    li x14, MASK_XLEN(0x100000000000)
    c.addiw x14, SEXT_IMM(0x8)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res


    # Testcase 45:  rd:x15(0x200000000000), imm:0x4, result rd:x15(0x00000004)
    li x15, MASK_XLEN(0x200000000000)
    c.addiw x15, SEXT_IMM(0x4)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x4)

    # Testcase 46:  rd:x16(0x400000000000), imm:0x2, result rd:x16(0x00000002)
    li x16, MASK_XLEN(0x400000000000)
    c.addiw x16, SEXT_IMM(0x2)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x2)

    # Testcase 47:  rd:x17(0x800000000000), imm:0x1, result rd:x17(0x00000001)
    li x17, MASK_XLEN(0x800000000000)
    c.addiw x17, SEXT_IMM(0x1)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x1)

    # Testcase 48:  rd:x18(0x1000000000000), imm:0x1f, result rd:x18(0x0000001f)
    li x18, MASK_XLEN(0x1000000000000)
    c.addiw x18, SEXT_IMM(0x1f)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x1f)

    # Testcase 49:  rd:x19(0x2000000000000), imm:0xf, result rd:x19(0x0000000f)
    li x19, MASK_XLEN(0x2000000000000)
    c.addiw x19, SEXT_IMM(0xf)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xf)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rd:x20(0x4000000000000), imm:0x17, result rd:x20(0x00000017)
    li x20, MASK_XLEN(0x4000000000000)
    c.addiw x20, SEXT_IMM(0x17)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x17)

    # Testcase 51:  rd:x21(0x8000000000000), imm:0x1b, result rd:x21(0x0000001b)
    li x21, MASK_XLEN(0x8000000000000)
    c.addiw x21, SEXT_IMM(0x1b)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x1b)

    # Testcase 52:  rd:x22(0x10000000000000), imm:0x1d, result rd:x22(0x0000001d)
    li x22, MASK_XLEN(0x10000000000000)
    c.addiw x22, SEXT_IMM(0x1d)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x1d)

    # Testcase 53:  rd:x23(0x20000000000000), imm:0x1e, result rd:x23(0x0000001e)
    li x23, MASK_XLEN(0x20000000000000)
    c.addiw x23, SEXT_IMM(0x1e)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x1e)

    # Testcase 54:  rd:x24(0x40000000000000), imm:0x0, result rd:x24(0x00000000)
    li x24, MASK_XLEN(0x40000000000000)
    c.addiw x24, SEXT_IMM(0x0)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rd:x25(0x80000000000000), imm:0x10, result rd:x25(0x00000010)
    li x25, MASK_XLEN(0x80000000000000)
    c.addiw x25, SEXT_IMM(0x10)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x10)

    # Testcase 56:  rd:x26(0x100000000000000), imm:0x8, result rd:x26(0x00000008)
    li x26, MASK_XLEN(0x100000000000000)
    c.addiw x26, SEXT_IMM(0x8)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x8)

    # Testcase 57:  rd:x27(0x200000000000000), imm:0x4, result rd:x27(0x00000004)
    li x27, MASK_XLEN(0x200000000000000)
    c.addiw x27, SEXT_IMM(0x4)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x4)

    # Testcase 58:  rd:x28(0x400000000000000), imm:0x2, result rd:x28(0x00000002)
    li x28, MASK_XLEN(0x400000000000000)
    c.addiw x28, SEXT_IMM(0x2)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x2)

    # Testcase 59:  rd:x29(0x800000000000000), imm:0x1, result rd:x29(0x00000001)
    li x29, MASK_XLEN(0x800000000000000)
    c.addiw x29, SEXT_IMM(0x1)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x1)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res


    # Testcase 60:  rd:x30(0x1000000000000000), imm:0x1f, result rd:x30(0x0000001f)
    li x30, MASK_XLEN(0x1000000000000000)
    c.addiw x30, SEXT_IMM(0x1f)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x1f)

    # Testcase 61:  rd:x31(0x2000000000000000), imm:0xf, result rd:x31(0x0000000f)
    li x31, MASK_XLEN(0x2000000000000000)
    c.addiw x31, SEXT_IMM(0xf)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xf)

    # Testcase 62:  rd:x1(0x4000000000000000), imm:0x17, result rd:x1(0x00000017)
    li x1, MASK_XLEN(0x4000000000000000)
    c.addiw x1, SEXT_IMM(0x17)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x17)

    # Testcase 63:  rd:x2(0x8000000000000000), imm:0x1b, result rd:x2(0x0000001b)
    li x2, MASK_XLEN(0x8000000000000000)
    c.addiw x2, SEXT_IMM(0x1b)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x1b)

    # Testcase 64:  rd:x3(0x00000000), imm:0x1d, result rd:x3(0x0000001d)
    li x3, MASK_XLEN(0x0)
    c.addiw x3, SEXT_IMM(0x1d)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x1d)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rd:x4(0xfffffffffffffffe), imm:0x1e, result rd:x4(0x0000001c)
    li x4, MASK_XLEN(0xfffffffffffffffe)
    c.addiw x4, SEXT_IMM(0x1e)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x1c)

    # Testcase 66:  rd:x5(0xfffffffffffffffd), imm:0x0, result rd:x5(0xfffffffffffffffd)
    li x5, MASK_XLEN(0xfffffffffffffffd)
    c.addiw x5, SEXT_IMM(0x0)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffffffffffffd)

    # Testcase 67:  rd:x6(0xfffffffffffffffb), imm:0x10, result rd:x6(0x0000000b)
    li x6, MASK_XLEN(0xfffffffffffffffb)
    c.addiw x6, SEXT_IMM(0x10)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xb)

    # Testcase 68:  rd:x7(0xfffffffffffffff7), imm:0x8, result rd:x7(0xffffffffffffffff)
    li x7, MASK_XLEN(0xfffffffffffffff7)
    c.addiw x7, SEXT_IMM(0x8)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffffffffffff)

    # Testcase 69:  rd:x8(0xffffffffffffffef), imm:0x4, result rd:x8(0xfffffffffffffff3)
    li x8, MASK_XLEN(0xffffffffffffffef)
    c.addiw x8, SEXT_IMM(0x4)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffffff3)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rd:x9(0xffffffffffffffdf), imm:0x2, result rd:x9(0xffffffffffffffe1)
    li x9, MASK_XLEN(0xffffffffffffffdf)
    c.addiw x9, SEXT_IMM(0x2)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffffffe1)

    # Testcase 71:  rd:x10(0xffffffffffffffbf), imm:0x1, result rd:x10(0xffffffffffffffc0)
    li x10, MASK_XLEN(0xffffffffffffffbf)
    c.addiw x10, SEXT_IMM(0x1)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffffffc0)

    # Testcase 72:  rd:x11(0xffffffffffffff7f), imm:0x1f, result rd:x11(0xffffffffffffff9e)
    li x11, MASK_XLEN(0xffffffffffffff7f)
    c.addiw x11, SEXT_IMM(0x1f)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffff9e)

    # Testcase 73:  rd:x12(0xfffffffffffffeff), imm:0xf, result rd:x12(0xffffffffffffff0e)
    li x12, MASK_XLEN(0xfffffffffffffeff)
    c.addiw x12, SEXT_IMM(0xf)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffff0e)

    # Testcase 74:  rd:x13(0xfffffffffffffdff), imm:0x17, result rd:x13(0xfffffffffffffe16)
    li x13, MASK_XLEN(0xfffffffffffffdff)
    c.addiw x13, SEXT_IMM(0x17)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffffffe16)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res


    # Testcase 75:  rd:x14(0xfffffffffffffbff), imm:0x1b, result rd:x14(0xfffffffffffffc1a)
    li x14, MASK_XLEN(0xfffffffffffffbff)
    c.addiw x14, SEXT_IMM(0x1b)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xfffffffffffffc1a)

    # Testcase 76:  rd:x15(0xfffffffffffff7ff), imm:0x1d, result rd:x15(0xfffffffffffff81c)
    li x15, MASK_XLEN(0xfffffffffffff7ff)
    c.addiw x15, SEXT_IMM(0x1d)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xfffffffffffff81c)

    # Testcase 77:  rd:x16(0xffffffffffffefff), imm:0x1e, result rd:x16(0xfffffffffffff01d)
    li x16, MASK_XLEN(0xffffffffffffefff)
    c.addiw x16, SEXT_IMM(0x1e)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xfffffffffffff01d)

    # Testcase 78:  rd:x17(0xffffffffffffdfff), imm:0x0, result rd:x17(0xffffffffffffdfff)
    li x17, MASK_XLEN(0xffffffffffffdfff)
    c.addiw x17, SEXT_IMM(0x0)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xffffffffffffdfff)

    # Testcase 79:  rd:x18(0xffffffffffffbfff), imm:0x10, result rd:x18(0xffffffffffffc00f)
    li x18, MASK_XLEN(0xffffffffffffbfff)
    c.addiw x18, SEXT_IMM(0x10)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xffffffffffffc00f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rd:x19(0xffffffffffff7fff), imm:0x8, result rd:x19(0xffffffffffff8007)
    li x19, MASK_XLEN(0xffffffffffff7fff)
    c.addiw x19, SEXT_IMM(0x8)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xffffffffffff8007)

    # Testcase 81:  rd:x20(0xfffffffffffeffff), imm:0x4, result rd:x20(0xffffffffffff0003)
    li x20, MASK_XLEN(0xfffffffffffeffff)
    c.addiw x20, SEXT_IMM(0x4)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffffffffffff0003)

    # Testcase 82:  rd:x21(0xfffffffffffdffff), imm:0x2, result rd:x21(0xfffffffffffe0001)
    li x21, MASK_XLEN(0xfffffffffffdffff)
    c.addiw x21, SEXT_IMM(0x2)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffffffffe0001)

    # Testcase 83:  rd:x22(0xfffffffffffbffff), imm:0x1, result rd:x22(0xfffffffffffc0000)
    li x22, MASK_XLEN(0xfffffffffffbffff)
    c.addiw x22, SEXT_IMM(0x1)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffffffffffc0000)

    # Testcase 84:  rd:x23(0xfffffffffff7ffff), imm:0x1f, result rd:x23(0xfffffffffff8001e)
    li x23, MASK_XLEN(0xfffffffffff7ffff)
    c.addiw x23, SEXT_IMM(0x1f)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffffffffff8001e)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rd:x24(0xffffffffffefffff), imm:0xf, result rd:x24(0xfffffffffff0000e)
    li x24, MASK_XLEN(0xffffffffffefffff)
    c.addiw x24, SEXT_IMM(0xf)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xfffffffffff0000e)

    # Testcase 86:  rd:x25(0xffffffffffdfffff), imm:0x17, result rd:x25(0xffffffffffe00016)
    li x25, MASK_XLEN(0xffffffffffdfffff)
    c.addiw x25, SEXT_IMM(0x17)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffffffe00016)

    # Testcase 87:  rd:x26(0xffffffffffbfffff), imm:0x1b, result rd:x26(0xffffffffffc0001a)
    li x26, MASK_XLEN(0xffffffffffbfffff)
    c.addiw x26, SEXT_IMM(0x1b)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffffffffffc0001a)

    # Testcase 88:  rd:x27(0xffffffffff7fffff), imm:0x1d, result rd:x27(0xffffffffff80001c)
    li x27, MASK_XLEN(0xffffffffff7fffff)
    c.addiw x27, SEXT_IMM(0x1d)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffffffffff80001c)

    # Testcase 89:  rd:x28(0xfffffffffeffffff), imm:0x1e, result rd:x28(0xffffffffff00001d)
    li x28, MASK_XLEN(0xfffffffffeffffff)
    c.addiw x28, SEXT_IMM(0x1e)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xffffffffff00001d)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res


    # Testcase 90:  rd:x29(0xfffffffffdffffff), imm:0x0, result rd:x29(0xfffffffffdffffff)
    li x29, MASK_XLEN(0xfffffffffdffffff)
    c.addiw x29, SEXT_IMM(0x0)
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0xfffffffffdffffff)

    # Testcase 91:  rd:x30(0xfffffffffbffffff), imm:0x10, result rd:x30(0xfffffffffc00000f)
    li x30, MASK_XLEN(0xfffffffffbffffff)
    c.addiw x30, SEXT_IMM(0x10)
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfffffffffc00000f)

    # Testcase 92:  rd:x31(0xfffffffff7ffffff), imm:0x8, result rd:x31(0xfffffffff8000007)
    li x31, MASK_XLEN(0xfffffffff7ffffff)
    c.addiw x31, SEXT_IMM(0x8)
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xfffffffff8000007)

    # Testcase 93:  rd:x1(0xffffffffefffffff), imm:0x4, result rd:x1(0xfffffffff0000003)
    li x1, MASK_XLEN(0xffffffffefffffff)
    c.addiw x1, SEXT_IMM(0x4)
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xfffffffff0000003)

    # Testcase 94:  rd:x2(0xffffffffdfffffff), imm:0x2, result rd:x2(0xffffffffe0000001)
    li x2, MASK_XLEN(0xffffffffdfffffff)
    c.addiw x2, SEXT_IMM(0x2)
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffffffffe0000001)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rd:x3(0xffffffffbfffffff), imm:0x1, result rd:x3(0xffffffffc0000000)
    li x3, MASK_XLEN(0xffffffffbfffffff)
    c.addiw x3, SEXT_IMM(0x1)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffffc0000000)

    # Testcase 96:  rd:x4(0xffffffff7fffffff), imm:0x1f, result rd:x4(0xffffffff8000001e)
    li x4, MASK_XLEN(0xffffffff7fffffff)
    c.addiw x4, SEXT_IMM(0x1f)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xffffffff8000001e)

    # Testcase 97:  rd:x5(0xfffffffeffffffff), imm:0xf, result rd:x5(0x0000000e)
    li x5, MASK_XLEN(0xfffffffeffffffff)
    c.addiw x5, SEXT_IMM(0xf)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xe)

    # Testcase 98:  rd:x6(0xfffffffdffffffff), imm:0x17, result rd:x6(0x00000016)
    li x6, MASK_XLEN(0xfffffffdffffffff)
    c.addiw x6, SEXT_IMM(0x17)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x16)

    # Testcase 99:  rd:x7(0xfffffffbffffffff), imm:0x1b, result rd:x7(0x0000001a)
    li x7, MASK_XLEN(0xfffffffbffffffff)
    c.addiw x7, SEXT_IMM(0x1b)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x1a)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rd:x8(0xfffffff7ffffffff), imm:0x1d, result rd:x8(0x0000001c)
    li x8, MASK_XLEN(0xfffffff7ffffffff)
    c.addiw x8, SEXT_IMM(0x1d)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1c)

    # Testcase 101:  rd:x9(0xffffffefffffffff), imm:0x1e, result rd:x9(0x0000001d)
    li x9, MASK_XLEN(0xffffffefffffffff)
    c.addiw x9, SEXT_IMM(0x1e)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1d)

    # Testcase 102:  rd:x10(0xffffffdfffffffff), imm:0x0, result rd:x10(0xffffffffffffffff)
    li x10, MASK_XLEN(0xffffffdfffffffff)
    c.addiw x10, SEXT_IMM(0x0)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffffffff)

    # Testcase 103:  rd:x11(0xffffffbfffffffff), imm:0x10, result rd:x11(0x0000000f)
    li x11, MASK_XLEN(0xffffffbfffffffff)
    c.addiw x11, SEXT_IMM(0x10)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xf)

    # Testcase 104:  rd:x12(0xffffff7fffffffff), imm:0x8, result rd:x12(0x00000007)
    li x12, MASK_XLEN(0xffffff7fffffffff)
    c.addiw x12, SEXT_IMM(0x8)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res


    # Testcase 105:  rd:x13(0xfffffeffffffffff), imm:0x4, result rd:x13(0x00000003)
    li x13, MASK_XLEN(0xfffffeffffffffff)
    c.addiw x13, SEXT_IMM(0x4)
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x3)

    # Testcase 106:  rd:x14(0xfffffdffffffffff), imm:0x2, result rd:x14(0x00000001)
    li x14, MASK_XLEN(0xfffffdffffffffff)
    c.addiw x14, SEXT_IMM(0x2)
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x1)

    # Testcase 107:  rd:x15(0xfffffbffffffffff), imm:0x1, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0xfffffbffffffffff)
    c.addiw x15, SEXT_IMM(0x1)
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x0)

    # Testcase 108:  rd:x16(0xfffff7ffffffffff), imm:0x1f, result rd:x16(0x0000001e)
    li x16, MASK_XLEN(0xfffff7ffffffffff)
    c.addiw x16, SEXT_IMM(0x1f)
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x1e)

    # Testcase 109:  rd:x17(0xffffefffffffffff), imm:0xf, result rd:x17(0x0000000e)
    li x17, MASK_XLEN(0xffffefffffffffff)
    c.addiw x17, SEXT_IMM(0xf)
    sd x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rd:x18(0xffffdfffffffffff), imm:0x17, result rd:x18(0x00000016)
    li x18, MASK_XLEN(0xffffdfffffffffff)
    c.addiw x18, SEXT_IMM(0x17)
    sd x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x16)

    # Testcase 111:  rd:x19(0xffffbfffffffffff), imm:0x1b, result rd:x19(0x0000001a)
    li x19, MASK_XLEN(0xffffbfffffffffff)
    c.addiw x19, SEXT_IMM(0x1b)
    sd x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x1a)

    # Testcase 112:  rd:x20(0xffff7fffffffffff), imm:0x1d, result rd:x20(0x0000001c)
    li x20, MASK_XLEN(0xffff7fffffffffff)
    c.addiw x20, SEXT_IMM(0x1d)
    sd x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x1c)

    # Testcase 113:  rd:x21(0xfffeffffffffffff), imm:0x1e, result rd:x21(0x0000001d)
    li x21, MASK_XLEN(0xfffeffffffffffff)
    c.addiw x21, SEXT_IMM(0x1e)
    sd x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x1d)

    # Testcase 114:  rd:x22(0xfffdffffffffffff), imm:0x0, result rd:x22(0xffffffffffffffff)
    li x22, MASK_XLEN(0xfffdffffffffffff)
    c.addiw x22, SEXT_IMM(0x0)
    sd x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rd:x23(0xfffbffffffffffff), imm:0x10, result rd:x23(0x0000000f)
    li x23, MASK_XLEN(0xfffbffffffffffff)
    c.addiw x23, SEXT_IMM(0x10)
    sd x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xf)

    # Testcase 116:  rd:x24(0xfff7ffffffffffff), imm:0x8, result rd:x24(0x00000007)
    li x24, MASK_XLEN(0xfff7ffffffffffff)
    c.addiw x24, SEXT_IMM(0x8)
    sd x24, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x7)

    # Testcase 117:  rd:x25(0xffefffffffffffff), imm:0x4, result rd:x25(0x00000003)
    li x25, MASK_XLEN(0xffefffffffffffff)
    c.addiw x25, SEXT_IMM(0x4)
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x3)

    # Testcase 118:  rd:x26(0xffdfffffffffffff), imm:0x2, result rd:x26(0x00000001)
    li x26, MASK_XLEN(0xffdfffffffffffff)
    c.addiw x26, SEXT_IMM(0x2)
    sd x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x1)

    # Testcase 119:  rd:x27(0xffbfffffffffffff), imm:0x1, result rd:x27(0x00000000)
    li x27, MASK_XLEN(0xffbfffffffffffff)
    c.addiw x27, SEXT_IMM(0x1)
    sd x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res


    # Testcase 120:  rd:x28(0xff7fffffffffffff), imm:0x1f, result rd:x28(0x0000001e)
    li x28, MASK_XLEN(0xff7fffffffffffff)
    c.addiw x28, SEXT_IMM(0x1f)
    sd x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0x1e)

    # Testcase 121:  rd:x29(0xfeffffffffffffff), imm:0xf, result rd:x29(0x0000000e)
    li x29, MASK_XLEN(0xfeffffffffffffff)
    c.addiw x29, SEXT_IMM(0xf)
    sd x29, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0xe)

    # Testcase 122:  rd:x30(0xfdffffffffffffff), imm:0x17, result rd:x30(0x00000016)
    li x30, MASK_XLEN(0xfdffffffffffffff)
    c.addiw x30, SEXT_IMM(0x17)
    sd x30, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x16)

    # Testcase 123:  rd:x31(0xfbffffffffffffff), imm:0x1b, result rd:x31(0x0000001a)
    li x31, MASK_XLEN(0xfbffffffffffffff)
    c.addiw x31, SEXT_IMM(0x1b)
    sd x31, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x1a)

    # Testcase 124:  rd:x1(0xf7ffffffffffffff), imm:0x1d, result rd:x1(0x0000001c)
    li x1, MASK_XLEN(0xf7ffffffffffffff)
    c.addiw x1, SEXT_IMM(0x1d)
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x1c)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rd:x2(0xefffffffffffffff), imm:0x1e, result rd:x2(0x0000001d)
    li x2, MASK_XLEN(0xefffffffffffffff)
    c.addiw x2, SEXT_IMM(0x1e)
    sd x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x1d)

    # Testcase 126:  rd:x3(0xdfffffffffffffff), imm:0x0, result rd:x3(0xffffffffffffffff)
    li x3, MASK_XLEN(0xdfffffffffffffff)
    c.addiw x3, SEXT_IMM(0x0)
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xffffffffffffffff)

    # Testcase 127:  rd:x4(0xbfffffffffffffff), imm:0x10, result rd:x4(0x0000000f)
    li x4, MASK_XLEN(0xbfffffffffffffff)
    c.addiw x4, SEXT_IMM(0x10)
    sd x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xf)

    # Testcase 128:  rd:x5(0x7fffffffffffffff), imm:0x8, result rd:x5(0x00000007)
    li x5, MASK_XLEN(0x7fffffffffffffff)
    c.addiw x5, SEXT_IMM(0x8)
    sd x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x7)

    # Testcase 129:  rd:x6(0xffffffffffffffff), imm:0x4, result rd:x6(0x00000003)
    li x6, MASK_XLEN(0xffffffffffffffff)
    c.addiw x6, SEXT_IMM(0x4)
    sd x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0x3)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rd:x7(0x00000001), imm:0x0, result rd:x7(0x00000001)
    li x7, MASK_XLEN(0x1)
    c.addiw x7, SEXT_IMM(0x0)
    sd x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x1)

    # Testcase 131:  rd:x8(0x00000002), imm:0x0, result rd:x8(0x00000002)
    li x8, MASK_XLEN(0x2)
    c.addiw x8, SEXT_IMM(0x0)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2)

    # Testcase 132:  rd:x9(0x00000004), imm:0x0, result rd:x9(0x00000004)
    li x9, MASK_XLEN(0x4)
    c.addiw x9, SEXT_IMM(0x0)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4)

    # Testcase 133:  rd:x10(0x00000008), imm:0x0, result rd:x10(0x00000008)
    li x10, MASK_XLEN(0x8)
    c.addiw x10, SEXT_IMM(0x0)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8)

    # Testcase 134:  rd:x11(0x00000010), imm:0x0, result rd:x11(0x00000010)
    li x11, MASK_XLEN(0x10)
    c.addiw x11, SEXT_IMM(0x0)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x10)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res


    # Testcase 135:  rd:x12(0x00000020), imm:0x0, result rd:x12(0x00000020)
    li x12, MASK_XLEN(0x20)
    c.addiw x12, SEXT_IMM(0x0)
    sd x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x20)

    # Testcase 136:  rd:x13(0x00000040), imm:0x0, result rd:x13(0x00000040)
    li x13, MASK_XLEN(0x40)
    c.addiw x13, SEXT_IMM(0x0)
    sd x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x40)

    # Testcase 137:  rd:x14(0x00000080), imm:0x0, result rd:x14(0x00000080)
    li x14, MASK_XLEN(0x80)
    c.addiw x14, SEXT_IMM(0x0)
    sd x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x80)

    # Testcase 138:  rd:x15(0x00000100), imm:0x0, result rd:x15(0x00000100)
    li x15, MASK_XLEN(0x100)
    c.addiw x15, SEXT_IMM(0x0)
    sd x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x100)

    # Testcase 139:  rd:x16(0x00000200), imm:0x0, result rd:x16(0x00000200)
    li x16, MASK_XLEN(0x200)
    c.addiw x16, SEXT_IMM(0x0)
    sd x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x200)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res


    # Testcase 140:  rd:x17(0x00000400), imm:0x0, result rd:x17(0x00000400)
    li x17, MASK_XLEN(0x400)
    c.addiw x17, SEXT_IMM(0x0)
    sd x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x17, 0x400)

    # Testcase 141:  rd:x18(0x00000800), imm:0x0, result rd:x18(0x00000800)
    li x18, MASK_XLEN(0x800)
    c.addiw x18, SEXT_IMM(0x0)
    sd x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x800)

    # Testcase 142:  rd:x19(0x00001000), imm:0x0, result rd:x19(0x00001000)
    li x19, MASK_XLEN(0x1000)
    c.addiw x19, SEXT_IMM(0x0)
    sd x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x1000)

    # Testcase 143:  rd:x20(0x00002000), imm:0x0, result rd:x20(0x00002000)
    li x20, MASK_XLEN(0x2000)
    c.addiw x20, SEXT_IMM(0x0)
    sd x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x2000)

    # Testcase 144:  rd:x21(0x00004000), imm:0x0, result rd:x21(0x00004000)
    li x21, MASK_XLEN(0x4000)
    c.addiw x21, SEXT_IMM(0x0)
    sd x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x4000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res


    # Testcase 145:  rd:x22(0x00008000), imm:0x0, result rd:x22(0x00008000)
    li x22, MASK_XLEN(0x8000)
    c.addiw x22, SEXT_IMM(0x0)
    sd x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x8000)

    # Testcase 146:  rd:x23(0x00010000), imm:0x0, result rd:x23(0x00010000)
    li x23, MASK_XLEN(0x10000)
    c.addiw x23, SEXT_IMM(0x0)
    sd x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x10000)

    # Testcase 147:  rd:x24(0x00020000), imm:0x0, result rd:x24(0x00020000)
    li x24, MASK_XLEN(0x20000)
    c.addiw x24, SEXT_IMM(0x0)
    sd x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x20000)

    # Testcase 148:  rd:x25(0x00040000), imm:0x0, result rd:x25(0x00040000)
    li x25, MASK_XLEN(0x40000)
    c.addiw x25, SEXT_IMM(0x0)
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x40000)

    # Testcase 149:  rd:x26(0x00080000), imm:0x0, result rd:x26(0x00080000)
    li x26, MASK_XLEN(0x80000)
    c.addiw x26, SEXT_IMM(0x0)
    sd x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x80000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x6, test_31_res


    # Testcase 150:  rd:x27(0x00100000), imm:0x0, result rd:x27(0x00100000)
    li x27, MASK_XLEN(0x100000)
    c.addiw x27, SEXT_IMM(0x0)
    sd x27, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x100000)

    # Testcase 151:  rd:x28(0x00200000), imm:0x0, result rd:x28(0x00200000)
    li x28, MASK_XLEN(0x200000)
    c.addiw x28, SEXT_IMM(0x0)
    sd x28, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x200000)

    # Testcase 152:  rd:x29(0x00400000), imm:0x0, result rd:x29(0x00400000)
    li x29, MASK_XLEN(0x400000)
    c.addiw x29, SEXT_IMM(0x0)
    sd x29, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x400000)

    # Testcase 153:  rd:x30(0x00800000), imm:0x0, result rd:x30(0x00800000)
    li x30, MASK_XLEN(0x800000)
    c.addiw x30, SEXT_IMM(0x0)
    sd x30, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x800000)

    # Testcase 154:  rd:x31(0x01000000), imm:0x0, result rd:x31(0x01000000)
    li x31, MASK_XLEN(0x1000000)
    c.addiw x31, SEXT_IMM(0x0)
    sd x31, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x1000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x6, test_32_res


    # Testcase 155:  rd:x1(0x02000000), imm:0x0, result rd:x1(0x02000000)
    li x1, MASK_XLEN(0x2000000)
    c.addiw x1, SEXT_IMM(0x0)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x2000000)

    # Testcase 156:  rd:x2(0x04000000), imm:0x0, result rd:x2(0x04000000)
    li x2, MASK_XLEN(0x4000000)
    c.addiw x2, SEXT_IMM(0x0)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x4000000)

    # Testcase 157:  rd:x3(0x08000000), imm:0x0, result rd:x3(0x08000000)
    li x3, MASK_XLEN(0x8000000)
    c.addiw x3, SEXT_IMM(0x0)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x8000000)

    # Testcase 158:  rd:x4(0x10000000), imm:0x0, result rd:x4(0x10000000)
    li x4, MASK_XLEN(0x10000000)
    c.addiw x4, SEXT_IMM(0x0)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x10000000)

    # Testcase 159:  rd:x5(0x20000000), imm:0x0, result rd:x5(0x20000000)
    li x5, MASK_XLEN(0x20000000)
    c.addiw x5, SEXT_IMM(0x0)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x20000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res


    # Testcase 160:  rd:x6(0x40000000), imm:0x0, result rd:x6(0x40000000)
    li x6, MASK_XLEN(0x40000000)
    c.addiw x6, SEXT_IMM(0x0)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x40000000)

    # Testcase 161:  rd:x7(0x80000000), imm:0x0, result rd:x7(0xffffffff80000000)
    li x7, MASK_XLEN(0x80000000)
    c.addiw x7, SEXT_IMM(0x0)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffff80000000)

    # Testcase 162:  rd:x8(0x100000000), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x100000000)
    c.addiw x8, SEXT_IMM(0x0)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 163:  rd:x9(0x200000000), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x200000000)
    c.addiw x9, SEXT_IMM(0x0)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 164:  rd:x10(0x400000000), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x400000000)
    c.addiw x10, SEXT_IMM(0x0)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res


    # Testcase 165:  rd:x11(0x800000000), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x800000000)
    c.addiw x11, SEXT_IMM(0x0)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x0)

    # Testcase 166:  rd:x12(0x1000000000), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1000000000)
    c.addiw x12, SEXT_IMM(0x0)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x0)

    # Testcase 167:  rd:x13(0x2000000000), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2000000000)
    c.addiw x13, SEXT_IMM(0x0)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0)

    # Testcase 168:  rd:x14(0x4000000000), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x4000000000)
    c.addiw x14, SEXT_IMM(0x0)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0)

    # Testcase 169:  rd:x15(0x8000000000), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x8000000000)
    c.addiw x15, SEXT_IMM(0x0)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x2, test_35_res


    # Testcase 170:  rd:x16(0x10000000000), imm:0x0, result rd:x16(0x00000000)
    li x16, MASK_XLEN(0x10000000000)
    c.addiw x16, SEXT_IMM(0x0)
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x0)

    # Testcase 171:  rd:x17(0x20000000000), imm:0x0, result rd:x17(0x00000000)
    li x17, MASK_XLEN(0x20000000000)
    c.addiw x17, SEXT_IMM(0x0)
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x0)

    # Testcase 172:  rd:x18(0x40000000000), imm:0x0, result rd:x18(0x00000000)
    li x18, MASK_XLEN(0x40000000000)
    c.addiw x18, SEXT_IMM(0x0)
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x0)

    # Testcase 173:  rd:x19(0x80000000000), imm:0x0, result rd:x19(0x00000000)
    li x19, MASK_XLEN(0x80000000000)
    c.addiw x19, SEXT_IMM(0x0)
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x0)

    # Testcase 174:  rd:x20(0x100000000000), imm:0x0, result rd:x20(0x00000000)
    li x20, MASK_XLEN(0x100000000000)
    c.addiw x20, SEXT_IMM(0x0)
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res


    # Testcase 175:  rd:x21(0x200000000000), imm:0x0, result rd:x21(0x00000000)
    li x21, MASK_XLEN(0x200000000000)
    c.addiw x21, SEXT_IMM(0x0)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0)

    # Testcase 176:  rd:x22(0x400000000000), imm:0x0, result rd:x22(0x00000000)
    li x22, MASK_XLEN(0x400000000000)
    c.addiw x22, SEXT_IMM(0x0)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0)

    # Testcase 177:  rd:x23(0x800000000000), imm:0x0, result rd:x23(0x00000000)
    li x23, MASK_XLEN(0x800000000000)
    c.addiw x23, SEXT_IMM(0x0)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0)

    # Testcase 178:  rd:x24(0x1000000000000), imm:0x0, result rd:x24(0x00000000)
    li x24, MASK_XLEN(0x1000000000000)
    c.addiw x24, SEXT_IMM(0x0)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0)

    # Testcase 179:  rd:x25(0x2000000000000), imm:0x0, result rd:x25(0x00000000)
    li x25, MASK_XLEN(0x2000000000000)
    c.addiw x25, SEXT_IMM(0x0)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res


    # Testcase 180:  rd:x26(0x4000000000000), imm:0x0, result rd:x26(0x00000000)
    li x26, MASK_XLEN(0x4000000000000)
    c.addiw x26, SEXT_IMM(0x0)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x0)

    # Testcase 181:  rd:x27(0x8000000000000), imm:0x0, result rd:x27(0x00000000)
    li x27, MASK_XLEN(0x8000000000000)
    c.addiw x27, SEXT_IMM(0x0)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x0)

    # Testcase 182:  rd:x28(0x10000000000000), imm:0x0, result rd:x28(0x00000000)
    li x28, MASK_XLEN(0x10000000000000)
    c.addiw x28, SEXT_IMM(0x0)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x0)

    # Testcase 183:  rd:x29(0x20000000000000), imm:0x0, result rd:x29(0x00000000)
    li x29, MASK_XLEN(0x20000000000000)
    c.addiw x29, SEXT_IMM(0x0)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x0)

    # Testcase 184:  rd:x30(0x40000000000000), imm:0x0, result rd:x30(0x00000000)
    li x30, MASK_XLEN(0x40000000000000)
    c.addiw x30, SEXT_IMM(0x0)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x5, test_38_res


    # Testcase 185:  rd:x31(0x80000000000000), imm:0x0, result rd:x31(0x00000000)
    li x31, MASK_XLEN(0x80000000000000)
    c.addiw x31, SEXT_IMM(0x0)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0)

    # Testcase 186:  rd:x1(0x100000000000000), imm:0x0, result rd:x1(0x00000000)
    li x1, MASK_XLEN(0x100000000000000)
    c.addiw x1, SEXT_IMM(0x0)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0)

    # Testcase 187:  rd:x2(0x200000000000000), imm:0x0, result rd:x2(0x00000000)
    li x2, MASK_XLEN(0x200000000000000)
    c.addiw x2, SEXT_IMM(0x0)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0)

    # Testcase 188:  rd:x3(0x400000000000000), imm:0x0, result rd:x3(0x00000000)
    li x3, MASK_XLEN(0x400000000000000)
    c.addiw x3, SEXT_IMM(0x0)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x0)

    # Testcase 189:  rd:x4(0x800000000000000), imm:0x0, result rd:x4(0x00000000)
    li x4, MASK_XLEN(0x800000000000000)
    c.addiw x4, SEXT_IMM(0x0)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res


    # Testcase 190:  rd:x5(0x1000000000000000), imm:0x0, result rd:x5(0x00000000)
    li x5, MASK_XLEN(0x1000000000000000)
    c.addiw x5, SEXT_IMM(0x0)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0)

    # Testcase 191:  rd:x6(0x2000000000000000), imm:0x0, result rd:x6(0x00000000)
    li x6, MASK_XLEN(0x2000000000000000)
    c.addiw x6, SEXT_IMM(0x0)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0)

    # Testcase 192:  rd:x7(0x4000000000000000), imm:0x0, result rd:x7(0x00000000)
    li x7, MASK_XLEN(0x4000000000000000)
    c.addiw x7, SEXT_IMM(0x0)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0)

    # Testcase 193:  rd:x8(0x8000000000000000), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x8000000000000000)
    c.addiw x8, SEXT_IMM(0x0)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 194:  rd:x9(0x00000000), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x0)
    c.addiw x9, SEXT_IMM(0x0)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res


    # Testcase 195:  rd:x10(0xfffffffffffffffe), imm:0x0, result rd:x10(0xfffffffffffffffe)
    li x10, MASK_XLEN(0xfffffffffffffffe)
    c.addiw x10, SEXT_IMM(0x0)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffffffffffe)

    # Testcase 196:  rd:x11(0xfffffffffffffffd), imm:0x0, result rd:x11(0xfffffffffffffffd)
    li x11, MASK_XLEN(0xfffffffffffffffd)
    c.addiw x11, SEXT_IMM(0x0)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffffffffffd)

    # Testcase 197:  rd:x12(0xfffffffffffffffb), imm:0x0, result rd:x12(0xfffffffffffffffb)
    li x12, MASK_XLEN(0xfffffffffffffffb)
    c.addiw x12, SEXT_IMM(0x0)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffffffffb)

    # Testcase 198:  rd:x13(0xfffffffffffffff7), imm:0x0, result rd:x13(0xfffffffffffffff7)
    li x13, MASK_XLEN(0xfffffffffffffff7)
    c.addiw x13, SEXT_IMM(0x0)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffffffff7)

    # Testcase 199:  rd:x14(0xffffffffffffffef), imm:0x0, result rd:x14(0xffffffffffffffef)
    li x14, MASK_XLEN(0xffffffffffffffef)
    c.addiw x14, SEXT_IMM(0x0)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffffffffffef)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x3, test_41_res


    # Testcase 200:  rd:x15(0xffffffffffffffdf), imm:0x0, result rd:x15(0xffffffffffffffdf)
    li x15, MASK_XLEN(0xffffffffffffffdf)
    c.addiw x15, SEXT_IMM(0x0)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0xffffffffffffffdf)

    # Testcase 201:  rd:x16(0xffffffffffffffbf), imm:0x0, result rd:x16(0xffffffffffffffbf)
    li x16, MASK_XLEN(0xffffffffffffffbf)
    c.addiw x16, SEXT_IMM(0x0)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0xffffffffffffffbf)

    # Testcase 202:  rd:x17(0xffffffffffffff7f), imm:0x0, result rd:x17(0xffffffffffffff7f)
    li x17, MASK_XLEN(0xffffffffffffff7f)
    c.addiw x17, SEXT_IMM(0x0)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xffffffffffffff7f)

    # Testcase 203:  rd:x18(0xfffffffffffffeff), imm:0x0, result rd:x18(0xfffffffffffffeff)
    li x18, MASK_XLEN(0xfffffffffffffeff)
    c.addiw x18, SEXT_IMM(0x0)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0xfffffffffffffeff)

    # Testcase 204:  rd:x19(0xfffffffffffffdff), imm:0x0, result rd:x19(0xfffffffffffffdff)
    li x19, MASK_XLEN(0xfffffffffffffdff)
    c.addiw x19, SEXT_IMM(0x0)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xfffffffffffffdff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res


    # Testcase 205:  rd:x20(0xfffffffffffffbff), imm:0x0, result rd:x20(0xfffffffffffffbff)
    li x20, MASK_XLEN(0xfffffffffffffbff)
    c.addiw x20, SEXT_IMM(0x0)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffffffffffffbff)

    # Testcase 206:  rd:x21(0xfffffffffffff7ff), imm:0x0, result rd:x21(0xfffffffffffff7ff)
    li x21, MASK_XLEN(0xfffffffffffff7ff)
    c.addiw x21, SEXT_IMM(0x0)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffffffffff7ff)

    # Testcase 207:  rd:x22(0xffffffffffffefff), imm:0x0, result rd:x22(0xffffffffffffefff)
    li x22, MASK_XLEN(0xffffffffffffefff)
    c.addiw x22, SEXT_IMM(0x0)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffffffffffffefff)

    # Testcase 208:  rd:x23(0xffffffffffffdfff), imm:0x0, result rd:x23(0xffffffffffffdfff)
    li x23, MASK_XLEN(0xffffffffffffdfff)
    c.addiw x23, SEXT_IMM(0x0)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffffffffffdfff)

    # Testcase 209:  rd:x24(0xffffffffffffbfff), imm:0x0, result rd:x24(0xffffffffffffbfff)
    li x24, MASK_XLEN(0xffffffffffffbfff)
    c.addiw x24, SEXT_IMM(0x0)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffffffffffffbfff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res


    # Testcase 210:  rd:x25(0xffffffffffff7fff), imm:0x0, result rd:x25(0xffffffffffff7fff)
    li x25, MASK_XLEN(0xffffffffffff7fff)
    c.addiw x25, SEXT_IMM(0x0)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffffffff7fff)

    # Testcase 211:  rd:x26(0xfffffffffffeffff), imm:0x0, result rd:x26(0xfffffffffffeffff)
    li x26, MASK_XLEN(0xfffffffffffeffff)
    c.addiw x26, SEXT_IMM(0x0)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xfffffffffffeffff)

    # Testcase 212:  rd:x27(0xfffffffffffdffff), imm:0x0, result rd:x27(0xfffffffffffdffff)
    li x27, MASK_XLEN(0xfffffffffffdffff)
    c.addiw x27, SEXT_IMM(0x0)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfffffffffffdffff)

    # Testcase 213:  rd:x28(0xfffffffffffbffff), imm:0x0, result rd:x28(0xfffffffffffbffff)
    li x28, MASK_XLEN(0xfffffffffffbffff)
    c.addiw x28, SEXT_IMM(0x0)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffffffffffbffff)

    # Testcase 214:  rd:x29(0xfffffffffff7ffff), imm:0x0, result rd:x29(0xfffffffffff7ffff)
    li x29, MASK_XLEN(0xfffffffffff7ffff)
    c.addiw x29, SEXT_IMM(0x0)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xfffffffffff7ffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x4, test_44_res


    # Testcase 215:  rd:x30(0xffffffffffefffff), imm:0x0, result rd:x30(0xffffffffffefffff)
    li x30, MASK_XLEN(0xffffffffffefffff)
    c.addiw x30, SEXT_IMM(0x0)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xffffffffffefffff)

    # Testcase 216:  rd:x31(0xffffffffffdfffff), imm:0x0, result rd:x31(0xffffffffffdfffff)
    li x31, MASK_XLEN(0xffffffffffdfffff)
    c.addiw x31, SEXT_IMM(0x0)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xffffffffffdfffff)

    # Testcase 217:  rd:x1(0xffffffffffbfffff), imm:0x0, result rd:x1(0xffffffffffbfffff)
    li x1, MASK_XLEN(0xffffffffffbfffff)
    c.addiw x1, SEXT_IMM(0x0)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffffffffffbfffff)

    # Testcase 218:  rd:x2(0xffffffffff7fffff), imm:0x0, result rd:x2(0xffffffffff7fffff)
    li x2, MASK_XLEN(0xffffffffff7fffff)
    c.addiw x2, SEXT_IMM(0x0)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffffffffff7fffff)

    # Testcase 219:  rd:x3(0xfffffffffeffffff), imm:0x0, result rd:x3(0xfffffffffeffffff)
    li x3, MASK_XLEN(0xfffffffffeffffff)
    c.addiw x3, SEXT_IMM(0x0)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xfffffffffeffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res


    # Testcase 220:  rd:x4(0xfffffffffdffffff), imm:0x0, result rd:x4(0xfffffffffdffffff)
    li x4, MASK_XLEN(0xfffffffffdffffff)
    c.addiw x4, SEXT_IMM(0x0)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xfffffffffdffffff)

    # Testcase 221:  rd:x5(0xfffffffffbffffff), imm:0x0, result rd:x5(0xfffffffffbffffff)
    li x5, MASK_XLEN(0xfffffffffbffffff)
    c.addiw x5, SEXT_IMM(0x0)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffffffbffffff)

    # Testcase 222:  rd:x6(0xfffffffff7ffffff), imm:0x0, result rd:x6(0xfffffffff7ffffff)
    li x6, MASK_XLEN(0xfffffffff7ffffff)
    c.addiw x6, SEXT_IMM(0x0)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfffffffff7ffffff)

    # Testcase 223:  rd:x7(0xffffffffefffffff), imm:0x0, result rd:x7(0xffffffffefffffff)
    li x7, MASK_XLEN(0xffffffffefffffff)
    c.addiw x7, SEXT_IMM(0x0)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffffefffffff)

    # Testcase 224:  rd:x8(0xffffffffdfffffff), imm:0x0, result rd:x8(0xffffffffdfffffff)
    li x8, MASK_XLEN(0xffffffffdfffffff)
    c.addiw x8, SEXT_IMM(0x0)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffdfffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res


    # Testcase 225:  rd:x9(0xffffffffbfffffff), imm:0x0, result rd:x9(0xffffffffbfffffff)
    li x9, MASK_XLEN(0xffffffffbfffffff)
    c.addiw x9, SEXT_IMM(0x0)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffbfffffff)

    # Testcase 226:  rd:x10(0xffffffff7fffffff), imm:0x0, result rd:x10(0x7fffffff)
    li x10, MASK_XLEN(0xffffffff7fffffff)
    c.addiw x10, SEXT_IMM(0x0)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7fffffff)

    # Testcase 227:  rd:x11(0xfffffffeffffffff), imm:0x0, result rd:x11(0xffffffffffffffff)
    li x11, MASK_XLEN(0xfffffffeffffffff)
    c.addiw x11, SEXT_IMM(0x0)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffffff)

    # Testcase 228:  rd:x12(0xfffffffdffffffff), imm:0x0, result rd:x12(0xffffffffffffffff)
    li x12, MASK_XLEN(0xfffffffdffffffff)
    c.addiw x12, SEXT_IMM(0x0)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffffff)

    # Testcase 229:  rd:x13(0xfffffffbffffffff), imm:0x0, result rd:x13(0xffffffffffffffff)
    li x13, MASK_XLEN(0xfffffffbffffffff)
    c.addiw x13, SEXT_IMM(0x0)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x4, test_47_res


    # Testcase 230:  rd:x14(0xfffffff7ffffffff), imm:0x0, result rd:x14(0xffffffffffffffff)
    li x14, MASK_XLEN(0xfffffff7ffffffff)
    c.addiw x14, SEXT_IMM(0x0)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xffffffffffffffff)

    # Testcase 231:  rd:x15(0xffffffefffffffff), imm:0x0, result rd:x15(0xffffffffffffffff)
    li x15, MASK_XLEN(0xffffffefffffffff)
    c.addiw x15, SEXT_IMM(0x0)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xffffffffffffffff)

    # Testcase 232:  rd:x16(0xffffffdfffffffff), imm:0x0, result rd:x16(0xffffffffffffffff)
    li x16, MASK_XLEN(0xffffffdfffffffff)
    c.addiw x16, SEXT_IMM(0x0)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffffffffffffffff)

    # Testcase 233:  rd:x17(0xffffffbfffffffff), imm:0x0, result rd:x17(0xffffffffffffffff)
    li x17, MASK_XLEN(0xffffffbfffffffff)
    c.addiw x17, SEXT_IMM(0x0)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xffffffffffffffff)

    # Testcase 234:  rd:x18(0xffffff7fffffffff), imm:0x0, result rd:x18(0xffffffffffffffff)
    li x18, MASK_XLEN(0xffffff7fffffffff)
    c.addiw x18, SEXT_IMM(0x0)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res


    # Testcase 235:  rd:x19(0xfffffeffffffffff), imm:0x0, result rd:x19(0xffffffffffffffff)
    li x19, MASK_XLEN(0xfffffeffffffffff)
    c.addiw x19, SEXT_IMM(0x0)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xffffffffffffffff)

    # Testcase 236:  rd:x20(0xfffffdffffffffff), imm:0x0, result rd:x20(0xffffffffffffffff)
    li x20, MASK_XLEN(0xfffffdffffffffff)
    c.addiw x20, SEXT_IMM(0x0)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffffffffffffffff)

    # Testcase 237:  rd:x21(0xfffffbffffffffff), imm:0x0, result rd:x21(0xffffffffffffffff)
    li x21, MASK_XLEN(0xfffffbffffffffff)
    c.addiw x21, SEXT_IMM(0x0)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffffffffffffff)

    # Testcase 238:  rd:x22(0xfffff7ffffffffff), imm:0x0, result rd:x22(0xffffffffffffffff)
    li x22, MASK_XLEN(0xfffff7ffffffffff)
    c.addiw x22, SEXT_IMM(0x0)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffffffffffffffff)

    # Testcase 239:  rd:x23(0xffffefffffffffff), imm:0x0, result rd:x23(0xffffffffffffffff)
    li x23, MASK_XLEN(0xffffefffffffffff)
    c.addiw x23, SEXT_IMM(0x0)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res


    # Testcase 240:  rd:x24(0xffffdfffffffffff), imm:0x0, result rd:x24(0xffffffffffffffff)
    li x24, MASK_XLEN(0xffffdfffffffffff)
    c.addiw x24, SEXT_IMM(0x0)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffffffffffffffff)

    # Testcase 241:  rd:x25(0xffffbfffffffffff), imm:0x0, result rd:x25(0xffffffffffffffff)
    li x25, MASK_XLEN(0xffffbfffffffffff)
    c.addiw x25, SEXT_IMM(0x0)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffffffffffff)

    # Testcase 242:  rd:x26(0xffff7fffffffffff), imm:0x0, result rd:x26(0xffffffffffffffff)
    li x26, MASK_XLEN(0xffff7fffffffffff)
    c.addiw x26, SEXT_IMM(0x0)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffffffffffffffff)

    # Testcase 243:  rd:x27(0xfffeffffffffffff), imm:0x0, result rd:x27(0xffffffffffffffff)
    li x27, MASK_XLEN(0xfffeffffffffffff)
    c.addiw x27, SEXT_IMM(0x0)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffffffffffffffff)

    # Testcase 244:  rd:x28(0xfffdffffffffffff), imm:0x0, result rd:x28(0xffffffffffffffff)
    li x28, MASK_XLEN(0xfffdffffffffffff)
    c.addiw x28, SEXT_IMM(0x0)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x4, test_50_res


    # Testcase 245:  rd:x29(0xfffbffffffffffff), imm:0x0, result rd:x29(0xffffffffffffffff)
    li x29, MASK_XLEN(0xfffbffffffffffff)
    c.addiw x29, SEXT_IMM(0x0)
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0xffffffffffffffff)

    # Testcase 246:  rd:x30(0xfff7ffffffffffff), imm:0x0, result rd:x30(0xffffffffffffffff)
    li x30, MASK_XLEN(0xfff7ffffffffffff)
    c.addiw x30, SEXT_IMM(0x0)
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xffffffffffffffff)

    # Testcase 247:  rd:x31(0xffefffffffffffff), imm:0x0, result rd:x31(0xffffffffffffffff)
    li x31, MASK_XLEN(0xffefffffffffffff)
    c.addiw x31, SEXT_IMM(0x0)
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xffffffffffffffff)

    # Testcase 248:  rd:x1(0xffdfffffffffffff), imm:0x0, result rd:x1(0xffffffffffffffff)
    li x1, MASK_XLEN(0xffdfffffffffffff)
    c.addiw x1, SEXT_IMM(0x0)
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffffffffffffffff)

    # Testcase 249:  rd:x2(0xffbfffffffffffff), imm:0x0, result rd:x2(0xffffffffffffffff)
    li x2, MASK_XLEN(0xffbfffffffffffff)
    c.addiw x2, SEXT_IMM(0x0)
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res


    # Testcase 250:  rd:x3(0xff7fffffffffffff), imm:0x0, result rd:x3(0xffffffffffffffff)
    li x3, MASK_XLEN(0xff7fffffffffffff)
    c.addiw x3, SEXT_IMM(0x0)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffffffffffff)

    # Testcase 251:  rd:x4(0xfeffffffffffffff), imm:0x0, result rd:x4(0xffffffffffffffff)
    li x4, MASK_XLEN(0xfeffffffffffffff)
    c.addiw x4, SEXT_IMM(0x0)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xffffffffffffffff)

    # Testcase 252:  rd:x5(0xfdffffffffffffff), imm:0x0, result rd:x5(0xffffffffffffffff)
    li x5, MASK_XLEN(0xfdffffffffffffff)
    c.addiw x5, SEXT_IMM(0x0)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xffffffffffffffff)

    # Testcase 253:  rd:x6(0xfbffffffffffffff), imm:0x0, result rd:x6(0xffffffffffffffff)
    li x6, MASK_XLEN(0xfbffffffffffffff)
    c.addiw x6, SEXT_IMM(0x0)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xffffffffffffffff)

    # Testcase 254:  rd:x7(0xf7ffffffffffffff), imm:0x0, result rd:x7(0xffffffffffffffff)
    li x7, MASK_XLEN(0xf7ffffffffffffff)
    c.addiw x7, SEXT_IMM(0x0)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res


    # Testcase 255:  rd:x8(0xefffffffffffffff), imm:0x0, result rd:x8(0xffffffffffffffff)
    li x8, MASK_XLEN(0xefffffffffffffff)
    c.addiw x8, SEXT_IMM(0x0)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffffffffff)

    # Testcase 256:  rd:x9(0xdfffffffffffffff), imm:0x0, result rd:x9(0xffffffffffffffff)
    li x9, MASK_XLEN(0xdfffffffffffffff)
    c.addiw x9, SEXT_IMM(0x0)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffffffff)

    # Testcase 257:  rd:x10(0xbfffffffffffffff), imm:0x0, result rd:x10(0xffffffffffffffff)
    li x10, MASK_XLEN(0xbfffffffffffffff)
    c.addiw x10, SEXT_IMM(0x0)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffffffff)

    # Testcase 258:  rd:x11(0x7fffffffffffffff), imm:0x0, result rd:x11(0xffffffffffffffff)
    li x11, MASK_XLEN(0x7fffffffffffffff)
    c.addiw x11, SEXT_IMM(0x0)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffffff)

    # Testcase 259:  rd:x12(0xffffffffffffffff), imm:0x0, result rd:x12(0xffffffffffffffff)
    li x12, MASK_XLEN(0xffffffffffffffff)
    c.addiw x12, SEXT_IMM(0x0)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x2, test_53_res


    # Testcase 260:  rd:x13(0x00000001), imm:0x8, result rd:x13(0x00000009)
    li x13, MASK_XLEN(0x1)
    c.addiw x13, SEXT_IMM(0x8)
    sd x13, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x13, 0x9)

    # Testcase 261:  rd:x14(0x00000002), imm:0x4, result rd:x14(0x00000006)
    li x14, MASK_XLEN(0x2)
    c.addiw x14, SEXT_IMM(0x4)
    sd x14, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x6)

    # Testcase 262:  rd:x15(0x00000004), imm:0x2, result rd:x15(0x00000006)
    li x15, MASK_XLEN(0x4)
    c.addiw x15, SEXT_IMM(0x2)
    sd x15, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x6)

    # Testcase 263:  rd:x16(0x00000008), imm:0x1, result rd:x16(0x00000009)
    li x16, MASK_XLEN(0x8)
    c.addiw x16, SEXT_IMM(0x1)
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

