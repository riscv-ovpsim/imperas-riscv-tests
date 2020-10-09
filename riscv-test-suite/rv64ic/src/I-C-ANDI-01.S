# RISC-V Compliance Test I-C-ANDI-01
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
# Description: Testing instruction 'c.andi'.

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
    la x1, test_1_res


    # Testcase 0:  rd:x8(0x00000001), imm:0x1f, result rd:x8(0x00000001)
    li x8, MASK_XLEN(0x1)
    c.andi x8, SEXT_IMM(0x1f)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1)

    # Testcase 1:  rd:x9(0x00000002), imm:0xf, result rd:x9(0x00000002)
    li x9, MASK_XLEN(0x2)
    c.andi x9, SEXT_IMM(0xf)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x2)

    # Testcase 2:  rd:x10(0x00000004), imm:0x17, result rd:x10(0x00000004)
    li x10, MASK_XLEN(0x4)
    c.andi x10, SEXT_IMM(0x17)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x4)

    # Testcase 3:  rd:x11(0x00000008), imm:0x1b, result rd:x11(0x00000008)
    li x11, MASK_XLEN(0x8)
    c.andi x11, SEXT_IMM(0x1b)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8)

    # Testcase 4:  rd:x12(0x00000010), imm:0x1d, result rd:x12(0x00000010)
    li x12, MASK_XLEN(0x10)
    c.andi x12, SEXT_IMM(0x1d)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x10)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rd:x13(0x00000020), imm:0x1e, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x20)
    c.andi x13, SEXT_IMM(0x1e)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 6:  rd:x14(0x00000040), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x40)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 7:  rd:x15(0x00000080), imm:0x10, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x80)
    c.andi x15, SEXT_IMM(0x10)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 8:  rd:x8(0x00000100), imm:0x8, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x100)
    c.andi x8, SEXT_IMM(0x8)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 9:  rd:x9(0x00000200), imm:0x4, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x200)
    c.andi x9, SEXT_IMM(0x4)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rd:x10(0x00000400), imm:0x2, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x400)
    c.andi x10, SEXT_IMM(0x2)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 11:  rd:x11(0x00000800), imm:0x1, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x800)
    c.andi x11, SEXT_IMM(0x1)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 12:  rd:x12(0x00001000), imm:0x1f, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1000)
    c.andi x12, SEXT_IMM(0x1f)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 13:  rd:x13(0x00002000), imm:0xf, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2000)
    c.andi x13, SEXT_IMM(0xf)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 14:  rd:x14(0x00004000), imm:0x17, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x4000)
    c.andi x14, SEXT_IMM(0x17)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x1, test_4_res


    # Testcase 15:  rd:x15(0x00008000), imm:0x1b, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x8000)
    c.andi x15, SEXT_IMM(0x1b)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 16:  rd:x8(0x00010000), imm:0x1d, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x10000)
    c.andi x8, SEXT_IMM(0x1d)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 17:  rd:x9(0x00020000), imm:0x1e, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x20000)
    c.andi x9, SEXT_IMM(0x1e)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 18:  rd:x10(0x00040000), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x40000)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 19:  rd:x11(0x00080000), imm:0x10, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x80000)
    c.andi x11, SEXT_IMM(0x10)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rd:x12(0x00100000), imm:0x8, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x100000)
    c.andi x12, SEXT_IMM(0x8)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 21:  rd:x13(0x00200000), imm:0x4, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x200000)
    c.andi x13, SEXT_IMM(0x4)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 22:  rd:x14(0x00400000), imm:0x2, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x400000)
    c.andi x14, SEXT_IMM(0x2)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 23:  rd:x15(0x00800000), imm:0x1, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x800000)
    c.andi x15, SEXT_IMM(0x1)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 24:  rd:x8(0x01000000), imm:0x1f, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x1000000)
    c.andi x8, SEXT_IMM(0x1f)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rd:x9(0x02000000), imm:0xf, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x2000000)
    c.andi x9, SEXT_IMM(0xf)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 26:  rd:x10(0x04000000), imm:0x17, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x4000000)
    c.andi x10, SEXT_IMM(0x17)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 27:  rd:x11(0x08000000), imm:0x1b, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x8000000)
    c.andi x11, SEXT_IMM(0x1b)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 28:  rd:x12(0x10000000), imm:0x1d, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x10000000)
    c.andi x12, SEXT_IMM(0x1d)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 29:  rd:x13(0x20000000), imm:0x1e, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x20000000)
    c.andi x13, SEXT_IMM(0x1e)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x1, test_7_res


    # Testcase 30:  rd:x14(0x40000000), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x40000000)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 31:  rd:x15(0x80000000), imm:0x10, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x80000000)
    c.andi x15, SEXT_IMM(0x10)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 32:  rd:x8(0x100000000), imm:0x8, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x100000000)
    c.andi x8, SEXT_IMM(0x8)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 33:  rd:x9(0x200000000), imm:0x4, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x200000000)
    c.andi x9, SEXT_IMM(0x4)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 34:  rd:x10(0x400000000), imm:0x2, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x400000000)
    c.andi x10, SEXT_IMM(0x2)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rd:x11(0x800000000), imm:0x1, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x800000000)
    c.andi x11, SEXT_IMM(0x1)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 36:  rd:x12(0x1000000000), imm:0x1f, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1000000000)
    c.andi x12, SEXT_IMM(0x1f)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 37:  rd:x13(0x2000000000), imm:0xf, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2000000000)
    c.andi x13, SEXT_IMM(0xf)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 38:  rd:x14(0x4000000000), imm:0x17, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x4000000000)
    c.andi x14, SEXT_IMM(0x17)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 39:  rd:x15(0x8000000000), imm:0x1b, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x8000000000)
    c.andi x15, SEXT_IMM(0x1b)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rd:x8(0x10000000000), imm:0x1d, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x10000000000)
    c.andi x8, SEXT_IMM(0x1d)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 41:  rd:x9(0x20000000000), imm:0x1e, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x20000000000)
    c.andi x9, SEXT_IMM(0x1e)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 42:  rd:x10(0x40000000000), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x40000000000)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 43:  rd:x11(0x80000000000), imm:0x10, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x80000000000)
    c.andi x11, SEXT_IMM(0x10)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 44:  rd:x12(0x100000000000), imm:0x8, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x100000000000)
    c.andi x12, SEXT_IMM(0x8)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x1, test_10_res


    # Testcase 45:  rd:x13(0x200000000000), imm:0x4, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x200000000000)
    c.andi x13, SEXT_IMM(0x4)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 46:  rd:x14(0x400000000000), imm:0x2, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x400000000000)
    c.andi x14, SEXT_IMM(0x2)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 47:  rd:x15(0x800000000000), imm:0x1, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x800000000000)
    c.andi x15, SEXT_IMM(0x1)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 48:  rd:x8(0x1000000000000), imm:0x1f, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x1000000000000)
    c.andi x8, SEXT_IMM(0x1f)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 49:  rd:x9(0x2000000000000), imm:0xf, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x2000000000000)
    c.andi x9, SEXT_IMM(0xf)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rd:x10(0x4000000000000), imm:0x17, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x4000000000000)
    c.andi x10, SEXT_IMM(0x17)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 51:  rd:x11(0x8000000000000), imm:0x1b, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x8000000000000)
    c.andi x11, SEXT_IMM(0x1b)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 52:  rd:x12(0x10000000000000), imm:0x1d, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x10000000000000)
    c.andi x12, SEXT_IMM(0x1d)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 53:  rd:x13(0x20000000000000), imm:0x1e, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x20000000000000)
    c.andi x13, SEXT_IMM(0x1e)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 54:  rd:x14(0x40000000000000), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x40000000000000)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rd:x15(0x80000000000000), imm:0x10, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x80000000000000)
    c.andi x15, SEXT_IMM(0x10)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 56:  rd:x8(0x100000000000000), imm:0x8, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x100000000000000)
    c.andi x8, SEXT_IMM(0x8)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 57:  rd:x9(0x200000000000000), imm:0x4, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x200000000000000)
    c.andi x9, SEXT_IMM(0x4)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 58:  rd:x10(0x400000000000000), imm:0x2, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x400000000000000)
    c.andi x10, SEXT_IMM(0x2)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 59:  rd:x11(0x800000000000000), imm:0x1, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x800000000000000)
    c.andi x11, SEXT_IMM(0x1)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x1, test_13_res


    # Testcase 60:  rd:x12(0x1000000000000000), imm:0x1f, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1000000000000000)
    c.andi x12, SEXT_IMM(0x1f)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 61:  rd:x13(0x2000000000000000), imm:0xf, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2000000000000000)
    c.andi x13, SEXT_IMM(0xf)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 62:  rd:x14(0x4000000000000000), imm:0x17, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x4000000000000000)
    c.andi x14, SEXT_IMM(0x17)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 63:  rd:x15(0x8000000000000000), imm:0x1b, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x8000000000000000)
    c.andi x15, SEXT_IMM(0x1b)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 64:  rd:x8(0x00000000), imm:0x1d, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x0)
    c.andi x8, SEXT_IMM(0x1d)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rd:x9(0xfffffffffffffffe), imm:0x1e, result rd:x9(0x0000001e)
    li x9, MASK_XLEN(0xfffffffffffffffe)
    c.andi x9, SEXT_IMM(0x1e)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1e)

    # Testcase 66:  rd:x10(0xfffffffffffffffd), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xfffffffffffffffd)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 67:  rd:x11(0xfffffffffffffffb), imm:0x10, result rd:x11(0x00000010)
    li x11, MASK_XLEN(0xfffffffffffffffb)
    c.andi x11, SEXT_IMM(0x10)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x10)

    # Testcase 68:  rd:x12(0xfffffffffffffff7), imm:0x8, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xfffffffffffffff7)
    c.andi x12, SEXT_IMM(0x8)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 69:  rd:x13(0xffffffffffffffef), imm:0x4, result rd:x13(0x00000004)
    li x13, MASK_XLEN(0xffffffffffffffef)
    c.andi x13, SEXT_IMM(0x4)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rd:x14(0xffffffffffffffdf), imm:0x2, result rd:x14(0x00000002)
    li x14, MASK_XLEN(0xffffffffffffffdf)
    c.andi x14, SEXT_IMM(0x2)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x2)

    # Testcase 71:  rd:x15(0xffffffffffffffbf), imm:0x1, result rd:x15(0x00000001)
    li x15, MASK_XLEN(0xffffffffffffffbf)
    c.andi x15, SEXT_IMM(0x1)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1)

    # Testcase 72:  rd:x8(0xffffffffffffff7f), imm:0x1f, result rd:x8(0x0000001f)
    li x8, MASK_XLEN(0xffffffffffffff7f)
    c.andi x8, SEXT_IMM(0x1f)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1f)

    # Testcase 73:  rd:x9(0xfffffffffffffeff), imm:0xf, result rd:x9(0x0000000f)
    li x9, MASK_XLEN(0xfffffffffffffeff)
    c.andi x9, SEXT_IMM(0xf)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xf)

    # Testcase 74:  rd:x10(0xfffffffffffffdff), imm:0x17, result rd:x10(0x00000017)
    li x10, MASK_XLEN(0xfffffffffffffdff)
    c.andi x10, SEXT_IMM(0x17)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x17)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x1, test_16_res


    # Testcase 75:  rd:x11(0xfffffffffffffbff), imm:0x1b, result rd:x11(0x0000001b)
    li x11, MASK_XLEN(0xfffffffffffffbff)
    c.andi x11, SEXT_IMM(0x1b)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1b)

    # Testcase 76:  rd:x12(0xfffffffffffff7ff), imm:0x1d, result rd:x12(0x0000001d)
    li x12, MASK_XLEN(0xfffffffffffff7ff)
    c.andi x12, SEXT_IMM(0x1d)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1d)

    # Testcase 77:  rd:x13(0xffffffffffffefff), imm:0x1e, result rd:x13(0x0000001e)
    li x13, MASK_XLEN(0xffffffffffffefff)
    c.andi x13, SEXT_IMM(0x1e)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x1e)

    # Testcase 78:  rd:x14(0xffffffffffffdfff), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xffffffffffffdfff)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 79:  rd:x15(0xffffffffffffbfff), imm:0x10, result rd:x15(0x00000010)
    li x15, MASK_XLEN(0xffffffffffffbfff)
    c.andi x15, SEXT_IMM(0x10)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rd:x8(0xffffffffffff7fff), imm:0x8, result rd:x8(0x00000008)
    li x8, MASK_XLEN(0xffffffffffff7fff)
    c.andi x8, SEXT_IMM(0x8)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8)

    # Testcase 81:  rd:x9(0xfffffffffffeffff), imm:0x4, result rd:x9(0x00000004)
    li x9, MASK_XLEN(0xfffffffffffeffff)
    c.andi x9, SEXT_IMM(0x4)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4)

    # Testcase 82:  rd:x10(0xfffffffffffdffff), imm:0x2, result rd:x10(0x00000002)
    li x10, MASK_XLEN(0xfffffffffffdffff)
    c.andi x10, SEXT_IMM(0x2)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x2)

    # Testcase 83:  rd:x11(0xfffffffffffbffff), imm:0x1, result rd:x11(0x00000001)
    li x11, MASK_XLEN(0xfffffffffffbffff)
    c.andi x11, SEXT_IMM(0x1)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1)

    # Testcase 84:  rd:x12(0xfffffffffff7ffff), imm:0x1f, result rd:x12(0x0000001f)
    li x12, MASK_XLEN(0xfffffffffff7ffff)
    c.andi x12, SEXT_IMM(0x1f)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rd:x13(0xffffffffffefffff), imm:0xf, result rd:x13(0x0000000f)
    li x13, MASK_XLEN(0xffffffffffefffff)
    c.andi x13, SEXT_IMM(0xf)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xf)

    # Testcase 86:  rd:x14(0xffffffffffdfffff), imm:0x17, result rd:x14(0x00000017)
    li x14, MASK_XLEN(0xffffffffffdfffff)
    c.andi x14, SEXT_IMM(0x17)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x17)

    # Testcase 87:  rd:x15(0xffffffffffbfffff), imm:0x1b, result rd:x15(0x0000001b)
    li x15, MASK_XLEN(0xffffffffffbfffff)
    c.andi x15, SEXT_IMM(0x1b)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1b)

    # Testcase 88:  rd:x8(0xffffffffff7fffff), imm:0x1d, result rd:x8(0x0000001d)
    li x8, MASK_XLEN(0xffffffffff7fffff)
    c.andi x8, SEXT_IMM(0x1d)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1d)

    # Testcase 89:  rd:x9(0xfffffffffeffffff), imm:0x1e, result rd:x9(0x0000001e)
    li x9, MASK_XLEN(0xfffffffffeffffff)
    c.andi x9, SEXT_IMM(0x1e)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1e)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x1, test_19_res


    # Testcase 90:  rd:x10(0xfffffffffdffffff), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xfffffffffdffffff)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 91:  rd:x11(0xfffffffffbffffff), imm:0x10, result rd:x11(0x00000010)
    li x11, MASK_XLEN(0xfffffffffbffffff)
    c.andi x11, SEXT_IMM(0x10)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x10)

    # Testcase 92:  rd:x12(0xfffffffff7ffffff), imm:0x8, result rd:x12(0x00000008)
    li x12, MASK_XLEN(0xfffffffff7ffffff)
    c.andi x12, SEXT_IMM(0x8)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x8)

    # Testcase 93:  rd:x13(0xffffffffefffffff), imm:0x4, result rd:x13(0x00000004)
    li x13, MASK_XLEN(0xffffffffefffffff)
    c.andi x13, SEXT_IMM(0x4)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4)

    # Testcase 94:  rd:x14(0xffffffffdfffffff), imm:0x2, result rd:x14(0x00000002)
    li x14, MASK_XLEN(0xffffffffdfffffff)
    c.andi x14, SEXT_IMM(0x2)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x2)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rd:x15(0xffffffffbfffffff), imm:0x1, result rd:x15(0x00000001)
    li x15, MASK_XLEN(0xffffffffbfffffff)
    c.andi x15, SEXT_IMM(0x1)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1)

    # Testcase 96:  rd:x8(0xffffffff7fffffff), imm:0x1f, result rd:x8(0x0000001f)
    li x8, MASK_XLEN(0xffffffff7fffffff)
    c.andi x8, SEXT_IMM(0x1f)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1f)

    # Testcase 97:  rd:x9(0xfffffffeffffffff), imm:0xf, result rd:x9(0x0000000f)
    li x9, MASK_XLEN(0xfffffffeffffffff)
    c.andi x9, SEXT_IMM(0xf)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xf)

    # Testcase 98:  rd:x10(0xfffffffdffffffff), imm:0x17, result rd:x10(0x00000017)
    li x10, MASK_XLEN(0xfffffffdffffffff)
    c.andi x10, SEXT_IMM(0x17)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x17)

    # Testcase 99:  rd:x11(0xfffffffbffffffff), imm:0x1b, result rd:x11(0x0000001b)
    li x11, MASK_XLEN(0xfffffffbffffffff)
    c.andi x11, SEXT_IMM(0x1b)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1b)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rd:x12(0xfffffff7ffffffff), imm:0x1d, result rd:x12(0x0000001d)
    li x12, MASK_XLEN(0xfffffff7ffffffff)
    c.andi x12, SEXT_IMM(0x1d)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1d)

    # Testcase 101:  rd:x13(0xffffffefffffffff), imm:0x1e, result rd:x13(0x0000001e)
    li x13, MASK_XLEN(0xffffffefffffffff)
    c.andi x13, SEXT_IMM(0x1e)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x1e)

    # Testcase 102:  rd:x14(0xffffffdfffffffff), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xffffffdfffffffff)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 103:  rd:x15(0xffffffbfffffffff), imm:0x10, result rd:x15(0x00000010)
    li x15, MASK_XLEN(0xffffffbfffffffff)
    c.andi x15, SEXT_IMM(0x10)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10)

    # Testcase 104:  rd:x8(0xffffff7fffffffff), imm:0x8, result rd:x8(0x00000008)
    li x8, MASK_XLEN(0xffffff7fffffffff)
    c.andi x8, SEXT_IMM(0x8)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x1, test_22_res


    # Testcase 105:  rd:x9(0xfffffeffffffffff), imm:0x4, result rd:x9(0x00000004)
    li x9, MASK_XLEN(0xfffffeffffffffff)
    c.andi x9, SEXT_IMM(0x4)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4)

    # Testcase 106:  rd:x10(0xfffffdffffffffff), imm:0x2, result rd:x10(0x00000002)
    li x10, MASK_XLEN(0xfffffdffffffffff)
    c.andi x10, SEXT_IMM(0x2)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x2)

    # Testcase 107:  rd:x11(0xfffffbffffffffff), imm:0x1, result rd:x11(0x00000001)
    li x11, MASK_XLEN(0xfffffbffffffffff)
    c.andi x11, SEXT_IMM(0x1)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1)

    # Testcase 108:  rd:x12(0xfffff7ffffffffff), imm:0x1f, result rd:x12(0x0000001f)
    li x12, MASK_XLEN(0xfffff7ffffffffff)
    c.andi x12, SEXT_IMM(0x1f)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1f)

    # Testcase 109:  rd:x13(0xffffefffffffffff), imm:0xf, result rd:x13(0x0000000f)
    li x13, MASK_XLEN(0xffffefffffffffff)
    c.andi x13, SEXT_IMM(0xf)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xf)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rd:x14(0xffffdfffffffffff), imm:0x17, result rd:x14(0x00000017)
    li x14, MASK_XLEN(0xffffdfffffffffff)
    c.andi x14, SEXT_IMM(0x17)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x17)

    # Testcase 111:  rd:x15(0xffffbfffffffffff), imm:0x1b, result rd:x15(0x0000001b)
    li x15, MASK_XLEN(0xffffbfffffffffff)
    c.andi x15, SEXT_IMM(0x1b)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1b)

    # Testcase 112:  rd:x8(0xffff7fffffffffff), imm:0x1d, result rd:x8(0x0000001d)
    li x8, MASK_XLEN(0xffff7fffffffffff)
    c.andi x8, SEXT_IMM(0x1d)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1d)

    # Testcase 113:  rd:x9(0xfffeffffffffffff), imm:0x1e, result rd:x9(0x0000001e)
    li x9, MASK_XLEN(0xfffeffffffffffff)
    c.andi x9, SEXT_IMM(0x1e)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1e)

    # Testcase 114:  rd:x10(0xfffdffffffffffff), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xfffdffffffffffff)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rd:x11(0xfffbffffffffffff), imm:0x10, result rd:x11(0x00000010)
    li x11, MASK_XLEN(0xfffbffffffffffff)
    c.andi x11, SEXT_IMM(0x10)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x10)

    # Testcase 116:  rd:x12(0xfff7ffffffffffff), imm:0x8, result rd:x12(0x00000008)
    li x12, MASK_XLEN(0xfff7ffffffffffff)
    c.andi x12, SEXT_IMM(0x8)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x8)

    # Testcase 117:  rd:x13(0xffefffffffffffff), imm:0x4, result rd:x13(0x00000004)
    li x13, MASK_XLEN(0xffefffffffffffff)
    c.andi x13, SEXT_IMM(0x4)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4)

    # Testcase 118:  rd:x14(0xffdfffffffffffff), imm:0x2, result rd:x14(0x00000002)
    li x14, MASK_XLEN(0xffdfffffffffffff)
    c.andi x14, SEXT_IMM(0x2)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x2)

    # Testcase 119:  rd:x15(0xffbfffffffffffff), imm:0x1, result rd:x15(0x00000001)
    li x15, MASK_XLEN(0xffbfffffffffffff)
    c.andi x15, SEXT_IMM(0x1)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x1, test_25_res


    # Testcase 120:  rd:x8(0xff7fffffffffffff), imm:0x1f, result rd:x8(0x0000001f)
    li x8, MASK_XLEN(0xff7fffffffffffff)
    c.andi x8, SEXT_IMM(0x1f)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1f)

    # Testcase 121:  rd:x9(0xfeffffffffffffff), imm:0xf, result rd:x9(0x0000000f)
    li x9, MASK_XLEN(0xfeffffffffffffff)
    c.andi x9, SEXT_IMM(0xf)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xf)

    # Testcase 122:  rd:x10(0xfdffffffffffffff), imm:0x17, result rd:x10(0x00000017)
    li x10, MASK_XLEN(0xfdffffffffffffff)
    c.andi x10, SEXT_IMM(0x17)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x17)

    # Testcase 123:  rd:x11(0xfbffffffffffffff), imm:0x1b, result rd:x11(0x0000001b)
    li x11, MASK_XLEN(0xfbffffffffffffff)
    c.andi x11, SEXT_IMM(0x1b)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1b)

    # Testcase 124:  rd:x12(0xf7ffffffffffffff), imm:0x1d, result rd:x12(0x0000001d)
    li x12, MASK_XLEN(0xf7ffffffffffffff)
    c.andi x12, SEXT_IMM(0x1d)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1d)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rd:x13(0xefffffffffffffff), imm:0x1e, result rd:x13(0x0000001e)
    li x13, MASK_XLEN(0xefffffffffffffff)
    c.andi x13, SEXT_IMM(0x1e)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x1e)

    # Testcase 126:  rd:x14(0xdfffffffffffffff), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xdfffffffffffffff)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 127:  rd:x15(0xbfffffffffffffff), imm:0x10, result rd:x15(0x00000010)
    li x15, MASK_XLEN(0xbfffffffffffffff)
    c.andi x15, SEXT_IMM(0x10)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10)

    # Testcase 128:  rd:x8(0x7fffffffffffffff), imm:0x8, result rd:x8(0x00000008)
    li x8, MASK_XLEN(0x7fffffffffffffff)
    c.andi x8, SEXT_IMM(0x8)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8)

    # Testcase 129:  rd:x9(0xffffffffffffffff), imm:0x4, result rd:x9(0x00000004)
    li x9, MASK_XLEN(0xffffffffffffffff)
    c.andi x9, SEXT_IMM(0x4)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rd:x10(0x00000001), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x1)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 131:  rd:x11(0x00000002), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x2)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 132:  rd:x12(0x00000004), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x4)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 133:  rd:x13(0x00000008), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x8)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 134:  rd:x14(0x00000010), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x10)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res


    # Testcase 135:  rd:x15(0x00000020), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x20)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 136:  rd:x8(0x00000040), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x40)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 137:  rd:x9(0x00000080), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x80)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 138:  rd:x10(0x00000100), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x100)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 139:  rd:x11(0x00000200), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x200)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res


    # Testcase 140:  rd:x12(0x00000400), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x400)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 141:  rd:x13(0x00000800), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x800)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 142:  rd:x14(0x00001000), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x1000)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 143:  rd:x15(0x00002000), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x2000)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 144:  rd:x8(0x00004000), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x4000)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res


    # Testcase 145:  rd:x9(0x00008000), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x8000)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 146:  rd:x10(0x00010000), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x10000)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 147:  rd:x11(0x00020000), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x20000)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 148:  rd:x12(0x00040000), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x40000)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 149:  rd:x13(0x00080000), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x80000)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x1, test_31_res


    # Testcase 150:  rd:x14(0x00100000), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x100000)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 151:  rd:x15(0x00200000), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x200000)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 152:  rd:x8(0x00400000), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x400000)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 153:  rd:x9(0x00800000), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x800000)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 154:  rd:x10(0x01000000), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x1000000)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x1, test_32_res


    # Testcase 155:  rd:x11(0x02000000), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x2000000)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 156:  rd:x12(0x04000000), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x4000000)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 157:  rd:x13(0x08000000), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x8000000)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 158:  rd:x14(0x10000000), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x10000000)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 159:  rd:x15(0x20000000), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x20000000)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res


    # Testcase 160:  rd:x8(0x40000000), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x40000000)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 161:  rd:x9(0x80000000), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x80000000)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 162:  rd:x10(0x100000000), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x100000000)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 163:  rd:x11(0x200000000), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x200000000)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 164:  rd:x12(0x400000000), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x400000000)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res


    # Testcase 165:  rd:x13(0x800000000), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x800000000)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 166:  rd:x14(0x1000000000), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x1000000000)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 167:  rd:x15(0x2000000000), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x2000000000)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 168:  rd:x8(0x4000000000), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x4000000000)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 169:  rd:x9(0x8000000000), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x8000000000)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x1, test_35_res


    # Testcase 170:  rd:x10(0x10000000000), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x10000000000)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 171:  rd:x11(0x20000000000), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x20000000000)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 172:  rd:x12(0x40000000000), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x40000000000)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 173:  rd:x13(0x80000000000), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x80000000000)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 174:  rd:x14(0x100000000000), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x100000000000)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res


    # Testcase 175:  rd:x15(0x200000000000), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x200000000000)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 176:  rd:x8(0x400000000000), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x400000000000)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 177:  rd:x9(0x800000000000), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x800000000000)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 178:  rd:x10(0x1000000000000), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x1000000000000)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 179:  rd:x11(0x2000000000000), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x2000000000000)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res


    # Testcase 180:  rd:x12(0x4000000000000), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x4000000000000)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 181:  rd:x13(0x8000000000000), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x8000000000000)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 182:  rd:x14(0x10000000000000), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x10000000000000)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 183:  rd:x15(0x20000000000000), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x20000000000000)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 184:  rd:x8(0x40000000000000), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x40000000000000)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x1, test_38_res


    # Testcase 185:  rd:x9(0x80000000000000), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x80000000000000)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 186:  rd:x10(0x100000000000000), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x100000000000000)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 187:  rd:x11(0x200000000000000), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x200000000000000)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 188:  rd:x12(0x400000000000000), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x400000000000000)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 189:  rd:x13(0x800000000000000), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x800000000000000)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res


    # Testcase 190:  rd:x14(0x1000000000000000), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x1000000000000000)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 191:  rd:x15(0x2000000000000000), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x2000000000000000)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 192:  rd:x8(0x4000000000000000), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x4000000000000000)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 193:  rd:x9(0x8000000000000000), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x8000000000000000)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 194:  rd:x10(0x00000000), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x0)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res


    # Testcase 195:  rd:x11(0xfffffffffffffffe), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0xfffffffffffffffe)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 196:  rd:x12(0xfffffffffffffffd), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xfffffffffffffffd)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 197:  rd:x13(0xfffffffffffffffb), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0xfffffffffffffffb)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 198:  rd:x14(0xfffffffffffffff7), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xfffffffffffffff7)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 199:  rd:x15(0xffffffffffffffef), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0xffffffffffffffef)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x1, test_41_res


    # Testcase 200:  rd:x8(0xffffffffffffffdf), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xffffffffffffffdf)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 201:  rd:x9(0xffffffffffffffbf), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0xffffffffffffffbf)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 202:  rd:x10(0xffffffffffffff7f), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xffffffffffffff7f)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 203:  rd:x11(0xfffffffffffffeff), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0xfffffffffffffeff)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 204:  rd:x12(0xfffffffffffffdff), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xfffffffffffffdff)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res


    # Testcase 205:  rd:x13(0xfffffffffffffbff), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0xfffffffffffffbff)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 206:  rd:x14(0xfffffffffffff7ff), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xfffffffffffff7ff)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 207:  rd:x15(0xffffffffffffefff), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0xffffffffffffefff)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 208:  rd:x8(0xffffffffffffdfff), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xffffffffffffdfff)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 209:  rd:x9(0xffffffffffffbfff), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0xffffffffffffbfff)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res


    # Testcase 210:  rd:x10(0xffffffffffff7fff), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xffffffffffff7fff)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 211:  rd:x11(0xfffffffffffeffff), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0xfffffffffffeffff)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 212:  rd:x12(0xfffffffffffdffff), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xfffffffffffdffff)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 213:  rd:x13(0xfffffffffffbffff), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0xfffffffffffbffff)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 214:  rd:x14(0xfffffffffff7ffff), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xfffffffffff7ffff)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x1, test_44_res


    # Testcase 215:  rd:x15(0xffffffffffefffff), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0xffffffffffefffff)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 216:  rd:x8(0xffffffffffdfffff), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xffffffffffdfffff)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 217:  rd:x9(0xffffffffffbfffff), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0xffffffffffbfffff)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 218:  rd:x10(0xffffffffff7fffff), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xffffffffff7fffff)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 219:  rd:x11(0xfffffffffeffffff), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0xfffffffffeffffff)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res


    # Testcase 220:  rd:x12(0xfffffffffdffffff), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xfffffffffdffffff)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 221:  rd:x13(0xfffffffffbffffff), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0xfffffffffbffffff)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 222:  rd:x14(0xfffffffff7ffffff), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xfffffffff7ffffff)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 223:  rd:x15(0xffffffffefffffff), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0xffffffffefffffff)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 224:  rd:x8(0xffffffffdfffffff), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xffffffffdfffffff)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res


    # Testcase 225:  rd:x9(0xffffffffbfffffff), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0xffffffffbfffffff)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 226:  rd:x10(0xffffffff7fffffff), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xffffffff7fffffff)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 227:  rd:x11(0xfffffffeffffffff), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0xfffffffeffffffff)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 228:  rd:x12(0xfffffffdffffffff), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xfffffffdffffffff)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 229:  rd:x13(0xfffffffbffffffff), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0xfffffffbffffffff)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x1, test_47_res


    # Testcase 230:  rd:x14(0xfffffff7ffffffff), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xfffffff7ffffffff)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 231:  rd:x15(0xffffffefffffffff), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0xffffffefffffffff)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 232:  rd:x8(0xffffffdfffffffff), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xffffffdfffffffff)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 233:  rd:x9(0xffffffbfffffffff), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0xffffffbfffffffff)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 234:  rd:x10(0xffffff7fffffffff), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xffffff7fffffffff)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res


    # Testcase 235:  rd:x11(0xfffffeffffffffff), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0xfffffeffffffffff)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 236:  rd:x12(0xfffffdffffffffff), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xfffffdffffffffff)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 237:  rd:x13(0xfffffbffffffffff), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0xfffffbffffffffff)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 238:  rd:x14(0xfffff7ffffffffff), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xfffff7ffffffffff)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 239:  rd:x15(0xffffefffffffffff), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0xffffefffffffffff)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res


    # Testcase 240:  rd:x8(0xffffdfffffffffff), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xffffdfffffffffff)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 241:  rd:x9(0xffffbfffffffffff), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0xffffbfffffffffff)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 242:  rd:x10(0xffff7fffffffffff), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xffff7fffffffffff)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 243:  rd:x11(0xfffeffffffffffff), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0xfffeffffffffffff)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 244:  rd:x12(0xfffdffffffffffff), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xfffdffffffffffff)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x1, test_50_res


    # Testcase 245:  rd:x13(0xfffbffffffffffff), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0xfffbffffffffffff)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 246:  rd:x14(0xfff7ffffffffffff), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xfff7ffffffffffff)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 247:  rd:x15(0xffefffffffffffff), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0xffefffffffffffff)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 248:  rd:x8(0xffdfffffffffffff), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xffdfffffffffffff)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 249:  rd:x9(0xffbfffffffffffff), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0xffbfffffffffffff)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res


    # Testcase 250:  rd:x10(0xff7fffffffffffff), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0xff7fffffffffffff)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 251:  rd:x11(0xfeffffffffffffff), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0xfeffffffffffffff)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 252:  rd:x12(0xfdffffffffffffff), imm:0x0, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0xfdffffffffffffff)
    c.andi x12, SEXT_IMM(0x0)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 253:  rd:x13(0xfbffffffffffffff), imm:0x0, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0xfbffffffffffffff)
    c.andi x13, SEXT_IMM(0x0)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 254:  rd:x14(0xf7ffffffffffffff), imm:0x0, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0xf7ffffffffffffff)
    c.andi x14, SEXT_IMM(0x0)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res


    # Testcase 255:  rd:x15(0xefffffffffffffff), imm:0x0, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0xefffffffffffffff)
    c.andi x15, SEXT_IMM(0x0)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 256:  rd:x8(0xdfffffffffffffff), imm:0x0, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0xdfffffffffffffff)
    c.andi x8, SEXT_IMM(0x0)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 257:  rd:x9(0xbfffffffffffffff), imm:0x0, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0xbfffffffffffffff)
    c.andi x9, SEXT_IMM(0x0)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 258:  rd:x10(0x7fffffffffffffff), imm:0x0, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x7fffffffffffffff)
    c.andi x10, SEXT_IMM(0x0)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 259:  rd:x11(0xffffffffffffffff), imm:0x0, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0xffffffffffffffff)
    c.andi x11, SEXT_IMM(0x0)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x1, test_53_res


    # Testcase 260:  rd:x12(0x00000001), imm:0x8, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1)
    c.andi x12, SEXT_IMM(0x8)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 261:  rd:x13(0x00000002), imm:0x4, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2)
    c.andi x13, SEXT_IMM(0x4)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 262:  rd:x14(0x00000004), imm:0x2, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x4)
    c.andi x14, SEXT_IMM(0x2)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)

    # Testcase 263:  rd:x15(0x00000008), imm:0x1, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x8)
    c.andi x15, SEXT_IMM(0x1)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)


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

