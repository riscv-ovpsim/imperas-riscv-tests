# RISC-V Compliance Test I-C-SRAI-01
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
# Description: Testing instruction 'c.srai'.

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


    # Testcase 0:  rd:x8(0x00000001), imm:0x1f, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x1)
    c.srai x8, 0x1f
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 1:  rd:x9(0x00000002), imm:0xf, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x2)
    c.srai x9, 0xf
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 2:  rd:x10(0x00000004), imm:0x17, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x4)
    c.srai x10, 0x17
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 3:  rd:x11(0x00000008), imm:0x1b, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x8)
    c.srai x11, 0x1b
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 4:  rd:x12(0x00000010), imm:0x1d, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x10)
    c.srai x12, 0x1d
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rd:x13(0x00000020), imm:0x1e, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x20)
    c.srai x13, 0x1e
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 6:  rd:x14(0x00000040), imm:0x1, result rd:x14(0x00000020)
    li x14, MASK_XLEN(0x40)
    c.srai x14, 0x1
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x20)

    # Testcase 7:  rd:x15(0x00000080), imm:0x10, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x80)
    c.srai x15, 0x10
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 8:  rd:x8(0x00000100), imm:0x8, result rd:x8(0x00000001)
    li x8, MASK_XLEN(0x100)
    c.srai x8, 0x8
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1)

    # Testcase 9:  rd:x9(0x00000200), imm:0x4, result rd:x9(0x00000020)
    li x9, MASK_XLEN(0x200)
    c.srai x9, 0x4
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rd:x10(0x00000400), imm:0x2, result rd:x10(0x00000100)
    li x10, MASK_XLEN(0x400)
    c.srai x10, 0x2
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x100)

    # Testcase 11:  rd:x11(0x00000800), imm:0x1, result rd:x11(0x00000400)
    li x11, MASK_XLEN(0x800)
    c.srai x11, 0x1
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400)

    # Testcase 12:  rd:x12(0x00001000), imm:0x1f, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1000)
    c.srai x12, 0x1f
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 13:  rd:x13(0x00002000), imm:0xf, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2000)
    c.srai x13, 0xf
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 14:  rd:x14(0x00004000), imm:0x17, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x4000)
    c.srai x14, 0x17
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x1, test_4_res


    # Testcase 15:  rd:x15(0x00008000), imm:0x1b, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x8000)
    c.srai x15, 0x1b
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 16:  rd:x8(0x00010000), imm:0x1d, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x10000)
    c.srai x8, 0x1d
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 17:  rd:x9(0x00020000), imm:0x1e, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x20000)
    c.srai x9, 0x1e
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 18:  rd:x10(0x00040000), imm:0x1, result rd:x10(0x00020000)
    li x10, MASK_XLEN(0x40000)
    c.srai x10, 0x1
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x20000)

    # Testcase 19:  rd:x11(0x00080000), imm:0x10, result rd:x11(0x00000008)
    li x11, MASK_XLEN(0x80000)
    c.srai x11, 0x10
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rd:x12(0x00100000), imm:0x8, result rd:x12(0x00001000)
    li x12, MASK_XLEN(0x100000)
    c.srai x12, 0x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000)

    # Testcase 21:  rd:x13(0x00200000), imm:0x4, result rd:x13(0x00020000)
    li x13, MASK_XLEN(0x200000)
    c.srai x13, 0x4
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x20000)

    # Testcase 22:  rd:x14(0x00400000), imm:0x2, result rd:x14(0x00100000)
    li x14, MASK_XLEN(0x400000)
    c.srai x14, 0x2
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x100000)

    # Testcase 23:  rd:x15(0x00800000), imm:0x1, result rd:x15(0x00400000)
    li x15, MASK_XLEN(0x800000)
    c.srai x15, 0x1
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x400000)

    # Testcase 24:  rd:x8(0x01000000), imm:0x1f, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x1000000)
    c.srai x8, 0x1f
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rd:x9(0x02000000), imm:0xf, result rd:x9(0x00000400)
    li x9, MASK_XLEN(0x2000000)
    c.srai x9, 0xf
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x400)

    # Testcase 26:  rd:x10(0x04000000), imm:0x17, result rd:x10(0x00000008)
    li x10, MASK_XLEN(0x4000000)
    c.srai x10, 0x17
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8)

    # Testcase 27:  rd:x11(0x08000000), imm:0x1b, result rd:x11(0x00000001)
    li x11, MASK_XLEN(0x8000000)
    c.srai x11, 0x1b
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1)

    # Testcase 28:  rd:x12(0x10000000), imm:0x1d, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x10000000)
    c.srai x12, 0x1d
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 29:  rd:x13(0x20000000), imm:0x1e, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x20000000)
    c.srai x13, 0x1e
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x1, test_7_res


    # Testcase 30:  rd:x14(0x40000000), imm:0x1, result rd:x14(0x20000000)
    li x14, MASK_XLEN(0x40000000)
    c.srai x14, 0x1
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x20000000)

    # Testcase 31:  rd:x15(0x80000000), imm:0x10, result rd:x15(0x00008000)
    li x15, MASK_XLEN(0x80000000)
    c.srai x15, 0x10
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x8000)

    # Testcase 32:  rd:x8(0x100000000), imm:0x8, result rd:x8(0x01000000)
    li x8, MASK_XLEN(0x100000000)
    c.srai x8, 0x8
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1000000)

    # Testcase 33:  rd:x9(0x200000000), imm:0x4, result rd:x9(0x20000000)
    li x9, MASK_XLEN(0x200000000)
    c.srai x9, 0x4
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20000000)

    # Testcase 34:  rd:x10(0x400000000), imm:0x2, result rd:x10(0x100000000)
    li x10, MASK_XLEN(0x400000000)
    c.srai x10, 0x2
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x100000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rd:x11(0x800000000), imm:0x1, result rd:x11(0x400000000)
    li x11, MASK_XLEN(0x800000000)
    c.srai x11, 0x1
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400000000)

    # Testcase 36:  rd:x12(0x1000000000), imm:0x1f, result rd:x12(0x00000020)
    li x12, MASK_XLEN(0x1000000000)
    c.srai x12, 0x1f
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20)

    # Testcase 37:  rd:x13(0x2000000000), imm:0xf, result rd:x13(0x00400000)
    li x13, MASK_XLEN(0x2000000000)
    c.srai x13, 0xf
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400000)

    # Testcase 38:  rd:x14(0x4000000000), imm:0x17, result rd:x14(0x00008000)
    li x14, MASK_XLEN(0x4000000000)
    c.srai x14, 0x17
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000)

    # Testcase 39:  rd:x15(0x8000000000), imm:0x1b, result rd:x15(0x00001000)
    li x15, MASK_XLEN(0x8000000000)
    c.srai x15, 0x1b
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rd:x8(0x10000000000), imm:0x1d, result rd:x8(0x00000800)
    li x8, MASK_XLEN(0x10000000000)
    c.srai x8, 0x1d
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x800)

    # Testcase 41:  rd:x9(0x20000000000), imm:0x1e, result rd:x9(0x00000800)
    li x9, MASK_XLEN(0x20000000000)
    c.srai x9, 0x1e
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x800)

    # Testcase 42:  rd:x10(0x40000000000), imm:0x1, result rd:x10(0x20000000000)
    li x10, MASK_XLEN(0x40000000000)
    c.srai x10, 0x1
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x20000000000)

    # Testcase 43:  rd:x11(0x80000000000), imm:0x10, result rd:x11(0x08000000)
    li x11, MASK_XLEN(0x80000000000)
    c.srai x11, 0x10
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8000000)

    # Testcase 44:  rd:x12(0x100000000000), imm:0x8, result rd:x12(0x1000000000)
    li x12, MASK_XLEN(0x100000000000)
    c.srai x12, 0x8
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x1, test_10_res


    # Testcase 45:  rd:x13(0x200000000000), imm:0x4, result rd:x13(0x20000000000)
    li x13, MASK_XLEN(0x200000000000)
    c.srai x13, 0x4
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x20000000000)

    # Testcase 46:  rd:x14(0x400000000000), imm:0x2, result rd:x14(0x100000000000)
    li x14, MASK_XLEN(0x400000000000)
    c.srai x14, 0x2
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x100000000000)

    # Testcase 47:  rd:x15(0x800000000000), imm:0x1, result rd:x15(0x400000000000)
    li x15, MASK_XLEN(0x800000000000)
    c.srai x15, 0x1
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x400000000000)

    # Testcase 48:  rd:x8(0x1000000000000), imm:0x1f, result rd:x8(0x00020000)
    li x8, MASK_XLEN(0x1000000000000)
    c.srai x8, 0x1f
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000)

    # Testcase 49:  rd:x9(0x2000000000000), imm:0xf, result rd:x9(0x400000000)
    li x9, MASK_XLEN(0x2000000000000)
    c.srai x9, 0xf
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x400000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rd:x10(0x4000000000000), imm:0x17, result rd:x10(0x08000000)
    li x10, MASK_XLEN(0x4000000000000)
    c.srai x10, 0x17
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000000)

    # Testcase 51:  rd:x11(0x8000000000000), imm:0x1b, result rd:x11(0x01000000)
    li x11, MASK_XLEN(0x8000000000000)
    c.srai x11, 0x1b
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000000)

    # Testcase 52:  rd:x12(0x10000000000000), imm:0x1d, result rd:x12(0x00800000)
    li x12, MASK_XLEN(0x10000000000000)
    c.srai x12, 0x1d
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x800000)

    # Testcase 53:  rd:x13(0x20000000000000), imm:0x1e, result rd:x13(0x00800000)
    li x13, MASK_XLEN(0x20000000000000)
    c.srai x13, 0x1e
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x800000)

    # Testcase 54:  rd:x14(0x40000000000000), imm:0x1, result rd:x14(0x20000000000000)
    li x14, MASK_XLEN(0x40000000000000)
    c.srai x14, 0x1
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x20000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rd:x15(0x80000000000000), imm:0x10, result rd:x15(0x8000000000)
    li x15, MASK_XLEN(0x80000000000000)
    c.srai x15, 0x10
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x8000000000)

    # Testcase 56:  rd:x8(0x100000000000000), imm:0x8, result rd:x8(0x1000000000000)
    li x8, MASK_XLEN(0x100000000000000)
    c.srai x8, 0x8
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1000000000000)

    # Testcase 57:  rd:x9(0x200000000000000), imm:0x4, result rd:x9(0x20000000000000)
    li x9, MASK_XLEN(0x200000000000000)
    c.srai x9, 0x4
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20000000000000)

    # Testcase 58:  rd:x10(0x400000000000000), imm:0x2, result rd:x10(0x100000000000000)
    li x10, MASK_XLEN(0x400000000000000)
    c.srai x10, 0x2
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x100000000000000)

    # Testcase 59:  rd:x11(0x800000000000000), imm:0x1, result rd:x11(0x400000000000000)
    li x11, MASK_XLEN(0x800000000000000)
    c.srai x11, 0x1
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x1, test_13_res


    # Testcase 60:  rd:x12(0x1000000000000000), imm:0x1f, result rd:x12(0x20000000)
    li x12, MASK_XLEN(0x1000000000000000)
    c.srai x12, 0x1f
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20000000)

    # Testcase 61:  rd:x13(0x2000000000000000), imm:0xf, result rd:x13(0x400000000000)
    li x13, MASK_XLEN(0x2000000000000000)
    c.srai x13, 0xf
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400000000000)

    # Testcase 62:  rd:x14(0x4000000000000000), imm:0x17, result rd:x14(0x8000000000)
    li x14, MASK_XLEN(0x4000000000000000)
    c.srai x14, 0x17
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000000000)

    # Testcase 63:  rd:x15(0x8000000000000000), imm:0x1b, result rd:x15(0xfffffff000000000)
    li x15, MASK_XLEN(0x8000000000000000)
    c.srai x15, 0x1b
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffff000000000)

    # Testcase 64:  rd:x8(0x00000000), imm:0x1d, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x0)
    c.srai x8, 0x1d
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rd:x9(0xfffffffffffffffe), imm:0x1e, result rd:x9(0xffffffffffffffff)
    li x9, MASK_XLEN(0xfffffffffffffffe)
    c.srai x9, 0x1e
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffffffff)

    # Testcase 66:  rd:x10(0xfffffffffffffffd), imm:0x1, result rd:x10(0xfffffffffffffffe)
    li x10, MASK_XLEN(0xfffffffffffffffd)
    c.srai x10, 0x1
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffffffffffe)

    # Testcase 67:  rd:x11(0xfffffffffffffffb), imm:0x10, result rd:x11(0xffffffffffffffff)
    li x11, MASK_XLEN(0xfffffffffffffffb)
    c.srai x11, 0x10
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffffff)

    # Testcase 68:  rd:x12(0xfffffffffffffff7), imm:0x8, result rd:x12(0xffffffffffffffff)
    li x12, MASK_XLEN(0xfffffffffffffff7)
    c.srai x12, 0x8
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffffff)

    # Testcase 69:  rd:x13(0xffffffffffffffef), imm:0x4, result rd:x13(0xfffffffffffffffe)
    li x13, MASK_XLEN(0xffffffffffffffef)
    c.srai x13, 0x4
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffffffffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rd:x14(0xffffffffffffffdf), imm:0x2, result rd:x14(0xfffffffffffffff7)
    li x14, MASK_XLEN(0xffffffffffffffdf)
    c.srai x14, 0x2
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffffffffffff7)

    # Testcase 71:  rd:x15(0xffffffffffffffbf), imm:0x1, result rd:x15(0xffffffffffffffdf)
    li x15, MASK_XLEN(0xffffffffffffffbf)
    c.srai x15, 0x1
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffffffffffdf)

    # Testcase 72:  rd:x8(0xffffffffffffff7f), imm:0x1f, result rd:x8(0xffffffffffffffff)
    li x8, MASK_XLEN(0xffffffffffffff7f)
    c.srai x8, 0x1f
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffffffffff)

    # Testcase 73:  rd:x9(0xfffffffffffffeff), imm:0xf, result rd:x9(0xffffffffffffffff)
    li x9, MASK_XLEN(0xfffffffffffffeff)
    c.srai x9, 0xf
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffffffff)

    # Testcase 74:  rd:x10(0xfffffffffffffdff), imm:0x17, result rd:x10(0xffffffffffffffff)
    li x10, MASK_XLEN(0xfffffffffffffdff)
    c.srai x10, 0x17
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x1, test_16_res


    # Testcase 75:  rd:x11(0xfffffffffffffbff), imm:0x1b, result rd:x11(0xffffffffffffffff)
    li x11, MASK_XLEN(0xfffffffffffffbff)
    c.srai x11, 0x1b
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffffff)

    # Testcase 76:  rd:x12(0xfffffffffffff7ff), imm:0x1d, result rd:x12(0xffffffffffffffff)
    li x12, MASK_XLEN(0xfffffffffffff7ff)
    c.srai x12, 0x1d
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffffff)

    # Testcase 77:  rd:x13(0xffffffffffffefff), imm:0x1e, result rd:x13(0xffffffffffffffff)
    li x13, MASK_XLEN(0xffffffffffffefff)
    c.srai x13, 0x1e
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffffffffff)

    # Testcase 78:  rd:x14(0xffffffffffffdfff), imm:0x1, result rd:x14(0xffffffffffffefff)
    li x14, MASK_XLEN(0xffffffffffffdfff)
    c.srai x14, 0x1
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffffffffefff)

    # Testcase 79:  rd:x15(0xffffffffffffbfff), imm:0x10, result rd:x15(0xffffffffffffffff)
    li x15, MASK_XLEN(0xffffffffffffbfff)
    c.srai x15, 0x10
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rd:x8(0xffffffffffff7fff), imm:0x8, result rd:x8(0xffffffffffffff7f)
    li x8, MASK_XLEN(0xffffffffffff7fff)
    c.srai x8, 0x8
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffffffff7f)

    # Testcase 81:  rd:x9(0xfffffffffffeffff), imm:0x4, result rd:x9(0xffffffffffffefff)
    li x9, MASK_XLEN(0xfffffffffffeffff)
    c.srai x9, 0x4
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffffefff)

    # Testcase 82:  rd:x10(0xfffffffffffdffff), imm:0x2, result rd:x10(0xffffffffffff7fff)
    li x10, MASK_XLEN(0xfffffffffffdffff)
    c.srai x10, 0x2
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffff7fff)

    # Testcase 83:  rd:x11(0xfffffffffffbffff), imm:0x1, result rd:x11(0xfffffffffffdffff)
    li x11, MASK_XLEN(0xfffffffffffbffff)
    c.srai x11, 0x1
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffffffdffff)

    # Testcase 84:  rd:x12(0xfffffffffff7ffff), imm:0x1f, result rd:x12(0xffffffffffffffff)
    li x12, MASK_XLEN(0xfffffffffff7ffff)
    c.srai x12, 0x1f
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rd:x13(0xffffffffffefffff), imm:0xf, result rd:x13(0xffffffffffffffdf)
    li x13, MASK_XLEN(0xffffffffffefffff)
    c.srai x13, 0xf
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffffffffdf)

    # Testcase 86:  rd:x14(0xffffffffffdfffff), imm:0x17, result rd:x14(0xffffffffffffffff)
    li x14, MASK_XLEN(0xffffffffffdfffff)
    c.srai x14, 0x17
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffffffffffff)

    # Testcase 87:  rd:x15(0xffffffffffbfffff), imm:0x1b, result rd:x15(0xffffffffffffffff)
    li x15, MASK_XLEN(0xffffffffffbfffff)
    c.srai x15, 0x1b
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffffffffffff)

    # Testcase 88:  rd:x8(0xffffffffff7fffff), imm:0x1d, result rd:x8(0xffffffffffffffff)
    li x8, MASK_XLEN(0xffffffffff7fffff)
    c.srai x8, 0x1d
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffffffffff)

    # Testcase 89:  rd:x9(0xfffffffffeffffff), imm:0x1e, result rd:x9(0xffffffffffffffff)
    li x9, MASK_XLEN(0xfffffffffeffffff)
    c.srai x9, 0x1e
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x1, test_19_res


    # Testcase 90:  rd:x10(0xfffffffffdffffff), imm:0x1, result rd:x10(0xfffffffffeffffff)
    li x10, MASK_XLEN(0xfffffffffdffffff)
    c.srai x10, 0x1
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffffeffffff)

    # Testcase 91:  rd:x11(0xfffffffffbffffff), imm:0x10, result rd:x11(0xfffffffffffffbff)
    li x11, MASK_XLEN(0xfffffffffbffffff)
    c.srai x11, 0x10
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffffffffbff)

    # Testcase 92:  rd:x12(0xfffffffff7ffffff), imm:0x8, result rd:x12(0xfffffffffff7ffff)
    li x12, MASK_XLEN(0xfffffffff7ffffff)
    c.srai x12, 0x8
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffff7ffff)

    # Testcase 93:  rd:x13(0xffffffffefffffff), imm:0x4, result rd:x13(0xfffffffffeffffff)
    li x13, MASK_XLEN(0xffffffffefffffff)
    c.srai x13, 0x4
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffeffffff)

    # Testcase 94:  rd:x14(0xffffffffdfffffff), imm:0x2, result rd:x14(0xfffffffff7ffffff)
    li x14, MASK_XLEN(0xffffffffdfffffff)
    c.srai x14, 0x2
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffffff7ffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rd:x15(0xffffffffbfffffff), imm:0x1, result rd:x15(0xffffffffdfffffff)
    li x15, MASK_XLEN(0xffffffffbfffffff)
    c.srai x15, 0x1
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffffdfffffff)

    # Testcase 96:  rd:x8(0xffffffff7fffffff), imm:0x1f, result rd:x8(0xfffffffffffffffe)
    li x8, MASK_XLEN(0xffffffff7fffffff)
    c.srai x8, 0x1f
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffffffe)

    # Testcase 97:  rd:x9(0xfffffffeffffffff), imm:0xf, result rd:x9(0xfffffffffffdffff)
    li x9, MASK_XLEN(0xfffffffeffffffff)
    c.srai x9, 0xf
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffffffdffff)

    # Testcase 98:  rd:x10(0xfffffffdffffffff), imm:0x17, result rd:x10(0xfffffffffffffbff)
    li x10, MASK_XLEN(0xfffffffdffffffff)
    c.srai x10, 0x17
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffffffffbff)

    # Testcase 99:  rd:x11(0xfffffffbffffffff), imm:0x1b, result rd:x11(0xffffffffffffff7f)
    li x11, MASK_XLEN(0xfffffffbffffffff)
    c.srai x11, 0x1b
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffff7f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rd:x12(0xfffffff7ffffffff), imm:0x1d, result rd:x12(0xffffffffffffffbf)
    li x12, MASK_XLEN(0xfffffff7ffffffff)
    c.srai x12, 0x1d
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffffbf)

    # Testcase 101:  rd:x13(0xffffffefffffffff), imm:0x1e, result rd:x13(0xffffffffffffffbf)
    li x13, MASK_XLEN(0xffffffefffffffff)
    c.srai x13, 0x1e
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffffffffbf)

    # Testcase 102:  rd:x14(0xffffffdfffffffff), imm:0x1, result rd:x14(0xffffffefffffffff)
    li x14, MASK_XLEN(0xffffffdfffffffff)
    c.srai x14, 0x1
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffefffffffff)

    # Testcase 103:  rd:x15(0xffffffbfffffffff), imm:0x10, result rd:x15(0xffffffffffbfffff)
    li x15, MASK_XLEN(0xffffffbfffffffff)
    c.srai x15, 0x10
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffffffbfffff)

    # Testcase 104:  rd:x8(0xffffff7fffffffff), imm:0x8, result rd:x8(0xffffffff7fffffff)
    li x8, MASK_XLEN(0xffffff7fffffffff)
    c.srai x8, 0x8
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffff7fffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x1, test_22_res


    # Testcase 105:  rd:x9(0xfffffeffffffffff), imm:0x4, result rd:x9(0xffffffefffffffff)
    li x9, MASK_XLEN(0xfffffeffffffffff)
    c.srai x9, 0x4
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffefffffffff)

    # Testcase 106:  rd:x10(0xfffffdffffffffff), imm:0x2, result rd:x10(0xffffff7fffffffff)
    li x10, MASK_XLEN(0xfffffdffffffffff)
    c.srai x10, 0x2
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffff7fffffffff)

    # Testcase 107:  rd:x11(0xfffffbffffffffff), imm:0x1, result rd:x11(0xfffffdffffffffff)
    li x11, MASK_XLEN(0xfffffbffffffffff)
    c.srai x11, 0x1
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffdffffffffff)

    # Testcase 108:  rd:x12(0xfffff7ffffffffff), imm:0x1f, result rd:x12(0xffffffffffffefff)
    li x12, MASK_XLEN(0xfffff7ffffffffff)
    c.srai x12, 0x1f
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffefff)

    # Testcase 109:  rd:x13(0xffffefffffffffff), imm:0xf, result rd:x13(0xffffffffdfffffff)
    li x13, MASK_XLEN(0xffffefffffffffff)
    c.srai x13, 0xf
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffdfffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rd:x14(0xffffdfffffffffff), imm:0x17, result rd:x14(0xffffffffffbfffff)
    li x14, MASK_XLEN(0xffffdfffffffffff)
    c.srai x14, 0x17
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffffffbfffff)

    # Testcase 111:  rd:x15(0xffffbfffffffffff), imm:0x1b, result rd:x15(0xfffffffffff7ffff)
    li x15, MASK_XLEN(0xffffbfffffffffff)
    c.srai x15, 0x1b
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffffffff7ffff)

    # Testcase 112:  rd:x8(0xffff7fffffffffff), imm:0x1d, result rd:x8(0xfffffffffffbffff)
    li x8, MASK_XLEN(0xffff7fffffffffff)
    c.srai x8, 0x1d
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffbffff)

    # Testcase 113:  rd:x9(0xfffeffffffffffff), imm:0x1e, result rd:x9(0xfffffffffffbffff)
    li x9, MASK_XLEN(0xfffeffffffffffff)
    c.srai x9, 0x1e
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffffffbffff)

    # Testcase 114:  rd:x10(0xfffdffffffffffff), imm:0x1, result rd:x10(0xfffeffffffffffff)
    li x10, MASK_XLEN(0xfffdffffffffffff)
    c.srai x10, 0x1
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffeffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rd:x11(0xfffbffffffffffff), imm:0x10, result rd:x11(0xfffffffbffffffff)
    li x11, MASK_XLEN(0xfffbffffffffffff)
    c.srai x11, 0x10
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffbffffffff)

    # Testcase 116:  rd:x12(0xfff7ffffffffffff), imm:0x8, result rd:x12(0xfffff7ffffffffff)
    li x12, MASK_XLEN(0xfff7ffffffffffff)
    c.srai x12, 0x8
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffff7ffffffffff)

    # Testcase 117:  rd:x13(0xffefffffffffffff), imm:0x4, result rd:x13(0xfffeffffffffffff)
    li x13, MASK_XLEN(0xffefffffffffffff)
    c.srai x13, 0x4
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffeffffffffffff)

    # Testcase 118:  rd:x14(0xffdfffffffffffff), imm:0x2, result rd:x14(0xfff7ffffffffffff)
    li x14, MASK_XLEN(0xffdfffffffffffff)
    c.srai x14, 0x2
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfff7ffffffffffff)

    # Testcase 119:  rd:x15(0xffbfffffffffffff), imm:0x1, result rd:x15(0xffdfffffffffffff)
    li x15, MASK_XLEN(0xffbfffffffffffff)
    c.srai x15, 0x1
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffdfffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x1, test_25_res


    # Testcase 120:  rd:x8(0xff7fffffffffffff), imm:0x1f, result rd:x8(0xfffffffffeffffff)
    li x8, MASK_XLEN(0xff7fffffffffffff)
    c.srai x8, 0x1f
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffeffffff)

    # Testcase 121:  rd:x9(0xfeffffffffffffff), imm:0xf, result rd:x9(0xfffffdffffffffff)
    li x9, MASK_XLEN(0xfeffffffffffffff)
    c.srai x9, 0xf
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffdffffffffff)

    # Testcase 122:  rd:x10(0xfdffffffffffffff), imm:0x17, result rd:x10(0xfffffffbffffffff)
    li x10, MASK_XLEN(0xfdffffffffffffff)
    c.srai x10, 0x17
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffbffffffff)

    # Testcase 123:  rd:x11(0xfbffffffffffffff), imm:0x1b, result rd:x11(0xffffffff7fffffff)
    li x11, MASK_XLEN(0xfbffffffffffffff)
    c.srai x11, 0x1b
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffff7fffffff)

    # Testcase 124:  rd:x12(0xf7ffffffffffffff), imm:0x1d, result rd:x12(0xffffffffbfffffff)
    li x12, MASK_XLEN(0xf7ffffffffffffff)
    c.srai x12, 0x1d
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffbfffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rd:x13(0xefffffffffffffff), imm:0x1e, result rd:x13(0xffffffffbfffffff)
    li x13, MASK_XLEN(0xefffffffffffffff)
    c.srai x13, 0x1e
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffbfffffff)

    # Testcase 126:  rd:x14(0xdfffffffffffffff), imm:0x1, result rd:x14(0xefffffffffffffff)
    li x14, MASK_XLEN(0xdfffffffffffffff)
    c.srai x14, 0x1
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xefffffffffffffff)

    # Testcase 127:  rd:x15(0xbfffffffffffffff), imm:0x10, result rd:x15(0xffffbfffffffffff)
    li x15, MASK_XLEN(0xbfffffffffffffff)
    c.srai x15, 0x10
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffbfffffffffff)

    # Testcase 128:  rd:x8(0x7fffffffffffffff), imm:0x8, result rd:x8(0x7fffffffffffff)
    li x8, MASK_XLEN(0x7fffffffffffffff)
    c.srai x8, 0x8
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fffffffffffff)

    # Testcase 129:  rd:x9(0xffffffffffffffff), imm:0x4, result rd:x9(0xffffffffffffffff)
    li x9, MASK_XLEN(0xffffffffffffffff)
    c.srai x9, 0x4
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rd:x10(0x00000001), imm:0x1, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x1)
    c.srai x10, 0x1
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 131:  rd:x11(0x00000002), imm:0x1, result rd:x11(0x00000001)
    li x11, MASK_XLEN(0x2)
    c.srai x11, 0x1
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1)

    # Testcase 132:  rd:x12(0x00000004), imm:0x1, result rd:x12(0x00000002)
    li x12, MASK_XLEN(0x4)
    c.srai x12, 0x1
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2)

    # Testcase 133:  rd:x13(0x00000008), imm:0x1, result rd:x13(0x00000004)
    li x13, MASK_XLEN(0x8)
    c.srai x13, 0x1
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4)

    # Testcase 134:  rd:x14(0x00000010), imm:0x1, result rd:x14(0x00000008)
    li x14, MASK_XLEN(0x10)
    c.srai x14, 0x1
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res


    # Testcase 135:  rd:x15(0x00000020), imm:0x1, result rd:x15(0x00000010)
    li x15, MASK_XLEN(0x20)
    c.srai x15, 0x1
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10)

    # Testcase 136:  rd:x8(0x00000040), imm:0x1, result rd:x8(0x00000020)
    li x8, MASK_XLEN(0x40)
    c.srai x8, 0x1
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20)

    # Testcase 137:  rd:x9(0x00000080), imm:0x1, result rd:x9(0x00000040)
    li x9, MASK_XLEN(0x80)
    c.srai x9, 0x1
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x40)

    # Testcase 138:  rd:x10(0x00000100), imm:0x1, result rd:x10(0x00000080)
    li x10, MASK_XLEN(0x100)
    c.srai x10, 0x1
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80)

    # Testcase 139:  rd:x11(0x00000200), imm:0x1, result rd:x11(0x00000100)
    li x11, MASK_XLEN(0x200)
    c.srai x11, 0x1
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x100)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res


    # Testcase 140:  rd:x12(0x00000400), imm:0x1, result rd:x12(0x00000200)
    li x12, MASK_XLEN(0x400)
    c.srai x12, 0x1
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200)

    # Testcase 141:  rd:x13(0x00000800), imm:0x1, result rd:x13(0x00000400)
    li x13, MASK_XLEN(0x800)
    c.srai x13, 0x1
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400)

    # Testcase 142:  rd:x14(0x00001000), imm:0x1, result rd:x14(0x00000800)
    li x14, MASK_XLEN(0x1000)
    c.srai x14, 0x1
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800)

    # Testcase 143:  rd:x15(0x00002000), imm:0x1, result rd:x15(0x00001000)
    li x15, MASK_XLEN(0x2000)
    c.srai x15, 0x1
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1000)

    # Testcase 144:  rd:x8(0x00004000), imm:0x1, result rd:x8(0x00002000)
    li x8, MASK_XLEN(0x4000)
    c.srai x8, 0x1
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res


    # Testcase 145:  rd:x9(0x00008000), imm:0x1, result rd:x9(0x00004000)
    li x9, MASK_XLEN(0x8000)
    c.srai x9, 0x1
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4000)

    # Testcase 146:  rd:x10(0x00010000), imm:0x1, result rd:x10(0x00008000)
    li x10, MASK_XLEN(0x10000)
    c.srai x10, 0x1
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000)

    # Testcase 147:  rd:x11(0x00020000), imm:0x1, result rd:x11(0x00010000)
    li x11, MASK_XLEN(0x20000)
    c.srai x11, 0x1
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x10000)

    # Testcase 148:  rd:x12(0x00040000), imm:0x1, result rd:x12(0x00020000)
    li x12, MASK_XLEN(0x40000)
    c.srai x12, 0x1
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20000)

    # Testcase 149:  rd:x13(0x00080000), imm:0x1, result rd:x13(0x00040000)
    li x13, MASK_XLEN(0x80000)
    c.srai x13, 0x1
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x40000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x1, test_31_res


    # Testcase 150:  rd:x14(0x00100000), imm:0x1, result rd:x14(0x00080000)
    li x14, MASK_XLEN(0x100000)
    c.srai x14, 0x1
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x80000)

    # Testcase 151:  rd:x15(0x00200000), imm:0x1, result rd:x15(0x00100000)
    li x15, MASK_XLEN(0x200000)
    c.srai x15, 0x1
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x100000)

    # Testcase 152:  rd:x8(0x00400000), imm:0x1, result rd:x8(0x00200000)
    li x8, MASK_XLEN(0x400000)
    c.srai x8, 0x1
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x200000)

    # Testcase 153:  rd:x9(0x00800000), imm:0x1, result rd:x9(0x00400000)
    li x9, MASK_XLEN(0x800000)
    c.srai x9, 0x1
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x400000)

    # Testcase 154:  rd:x10(0x01000000), imm:0x1, result rd:x10(0x00800000)
    li x10, MASK_XLEN(0x1000000)
    c.srai x10, 0x1
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x800000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x1, test_32_res


    # Testcase 155:  rd:x11(0x02000000), imm:0x1, result rd:x11(0x01000000)
    li x11, MASK_XLEN(0x2000000)
    c.srai x11, 0x1
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000000)

    # Testcase 156:  rd:x12(0x04000000), imm:0x1, result rd:x12(0x02000000)
    li x12, MASK_XLEN(0x4000000)
    c.srai x12, 0x1
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2000000)

    # Testcase 157:  rd:x13(0x08000000), imm:0x1, result rd:x13(0x04000000)
    li x13, MASK_XLEN(0x8000000)
    c.srai x13, 0x1
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4000000)

    # Testcase 158:  rd:x14(0x10000000), imm:0x1, result rd:x14(0x08000000)
    li x14, MASK_XLEN(0x10000000)
    c.srai x14, 0x1
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000000)

    # Testcase 159:  rd:x15(0x20000000), imm:0x1, result rd:x15(0x10000000)
    li x15, MASK_XLEN(0x20000000)
    c.srai x15, 0x1
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res


    # Testcase 160:  rd:x8(0x40000000), imm:0x1, result rd:x8(0x20000000)
    li x8, MASK_XLEN(0x40000000)
    c.srai x8, 0x1
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000000)

    # Testcase 161:  rd:x9(0x80000000), imm:0x1, result rd:x9(0x40000000)
    li x9, MASK_XLEN(0x80000000)
    c.srai x9, 0x1
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x40000000)

    # Testcase 162:  rd:x10(0x100000000), imm:0x1, result rd:x10(0x80000000)
    li x10, MASK_XLEN(0x100000000)
    c.srai x10, 0x1
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80000000)

    # Testcase 163:  rd:x11(0x200000000), imm:0x1, result rd:x11(0x100000000)
    li x11, MASK_XLEN(0x200000000)
    c.srai x11, 0x1
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x100000000)

    # Testcase 164:  rd:x12(0x400000000), imm:0x1, result rd:x12(0x200000000)
    li x12, MASK_XLEN(0x400000000)
    c.srai x12, 0x1
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res


    # Testcase 165:  rd:x13(0x800000000), imm:0x1, result rd:x13(0x400000000)
    li x13, MASK_XLEN(0x800000000)
    c.srai x13, 0x1
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400000000)

    # Testcase 166:  rd:x14(0x1000000000), imm:0x1, result rd:x14(0x800000000)
    li x14, MASK_XLEN(0x1000000000)
    c.srai x14, 0x1
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800000000)

    # Testcase 167:  rd:x15(0x2000000000), imm:0x1, result rd:x15(0x1000000000)
    li x15, MASK_XLEN(0x2000000000)
    c.srai x15, 0x1
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1000000000)

    # Testcase 168:  rd:x8(0x4000000000), imm:0x1, result rd:x8(0x2000000000)
    li x8, MASK_XLEN(0x4000000000)
    c.srai x8, 0x1
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000000000)

    # Testcase 169:  rd:x9(0x8000000000), imm:0x1, result rd:x9(0x4000000000)
    li x9, MASK_XLEN(0x8000000000)
    c.srai x9, 0x1
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x1, test_35_res


    # Testcase 170:  rd:x10(0x10000000000), imm:0x1, result rd:x10(0x8000000000)
    li x10, MASK_XLEN(0x10000000000)
    c.srai x10, 0x1
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000000000)

    # Testcase 171:  rd:x11(0x20000000000), imm:0x1, result rd:x11(0x10000000000)
    li x11, MASK_XLEN(0x20000000000)
    c.srai x11, 0x1
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x10000000000)

    # Testcase 172:  rd:x12(0x40000000000), imm:0x1, result rd:x12(0x20000000000)
    li x12, MASK_XLEN(0x40000000000)
    c.srai x12, 0x1
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20000000000)

    # Testcase 173:  rd:x13(0x80000000000), imm:0x1, result rd:x13(0x40000000000)
    li x13, MASK_XLEN(0x80000000000)
    c.srai x13, 0x1
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x40000000000)

    # Testcase 174:  rd:x14(0x100000000000), imm:0x1, result rd:x14(0x80000000000)
    li x14, MASK_XLEN(0x100000000000)
    c.srai x14, 0x1
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x80000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res


    # Testcase 175:  rd:x15(0x200000000000), imm:0x1, result rd:x15(0x100000000000)
    li x15, MASK_XLEN(0x200000000000)
    c.srai x15, 0x1
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x100000000000)

    # Testcase 176:  rd:x8(0x400000000000), imm:0x1, result rd:x8(0x200000000000)
    li x8, MASK_XLEN(0x400000000000)
    c.srai x8, 0x1
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x200000000000)

    # Testcase 177:  rd:x9(0x800000000000), imm:0x1, result rd:x9(0x400000000000)
    li x9, MASK_XLEN(0x800000000000)
    c.srai x9, 0x1
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x400000000000)

    # Testcase 178:  rd:x10(0x1000000000000), imm:0x1, result rd:x10(0x800000000000)
    li x10, MASK_XLEN(0x1000000000000)
    c.srai x10, 0x1
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x800000000000)

    # Testcase 179:  rd:x11(0x2000000000000), imm:0x1, result rd:x11(0x1000000000000)
    li x11, MASK_XLEN(0x2000000000000)
    c.srai x11, 0x1
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res


    # Testcase 180:  rd:x12(0x4000000000000), imm:0x1, result rd:x12(0x2000000000000)
    li x12, MASK_XLEN(0x4000000000000)
    c.srai x12, 0x1
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2000000000000)

    # Testcase 181:  rd:x13(0x8000000000000), imm:0x1, result rd:x13(0x4000000000000)
    li x13, MASK_XLEN(0x8000000000000)
    c.srai x13, 0x1
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4000000000000)

    # Testcase 182:  rd:x14(0x10000000000000), imm:0x1, result rd:x14(0x8000000000000)
    li x14, MASK_XLEN(0x10000000000000)
    c.srai x14, 0x1
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000000000000)

    # Testcase 183:  rd:x15(0x20000000000000), imm:0x1, result rd:x15(0x10000000000000)
    li x15, MASK_XLEN(0x20000000000000)
    c.srai x15, 0x1
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10000000000000)

    # Testcase 184:  rd:x8(0x40000000000000), imm:0x1, result rd:x8(0x20000000000000)
    li x8, MASK_XLEN(0x40000000000000)
    c.srai x8, 0x1
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x1, test_38_res


    # Testcase 185:  rd:x9(0x80000000000000), imm:0x1, result rd:x9(0x40000000000000)
    li x9, MASK_XLEN(0x80000000000000)
    c.srai x9, 0x1
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x40000000000000)

    # Testcase 186:  rd:x10(0x100000000000000), imm:0x1, result rd:x10(0x80000000000000)
    li x10, MASK_XLEN(0x100000000000000)
    c.srai x10, 0x1
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80000000000000)

    # Testcase 187:  rd:x11(0x200000000000000), imm:0x1, result rd:x11(0x100000000000000)
    li x11, MASK_XLEN(0x200000000000000)
    c.srai x11, 0x1
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x100000000000000)

    # Testcase 188:  rd:x12(0x400000000000000), imm:0x1, result rd:x12(0x200000000000000)
    li x12, MASK_XLEN(0x400000000000000)
    c.srai x12, 0x1
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200000000000000)

    # Testcase 189:  rd:x13(0x800000000000000), imm:0x1, result rd:x13(0x400000000000000)
    li x13, MASK_XLEN(0x800000000000000)
    c.srai x13, 0x1
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res


    # Testcase 190:  rd:x14(0x1000000000000000), imm:0x1, result rd:x14(0x800000000000000)
    li x14, MASK_XLEN(0x1000000000000000)
    c.srai x14, 0x1
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800000000000000)

    # Testcase 191:  rd:x15(0x2000000000000000), imm:0x1, result rd:x15(0x1000000000000000)
    li x15, MASK_XLEN(0x2000000000000000)
    c.srai x15, 0x1
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1000000000000000)

    # Testcase 192:  rd:x8(0x4000000000000000), imm:0x1, result rd:x8(0x2000000000000000)
    li x8, MASK_XLEN(0x4000000000000000)
    c.srai x8, 0x1
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000000000000000)

    # Testcase 193:  rd:x9(0x8000000000000000), imm:0x1, result rd:x9(0xc000000000000000)
    li x9, MASK_XLEN(0x8000000000000000)
    c.srai x9, 0x1
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xc000000000000000)

    # Testcase 194:  rd:x10(0x00000000), imm:0x1, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x0)
    c.srai x10, 0x1
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res


    # Testcase 195:  rd:x11(0xfffffffffffffffe), imm:0x1, result rd:x11(0xffffffffffffffff)
    li x11, MASK_XLEN(0xfffffffffffffffe)
    c.srai x11, 0x1
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffffff)

    # Testcase 196:  rd:x12(0xfffffffffffffffd), imm:0x1, result rd:x12(0xfffffffffffffffe)
    li x12, MASK_XLEN(0xfffffffffffffffd)
    c.srai x12, 0x1
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffffffffe)

    # Testcase 197:  rd:x13(0xfffffffffffffffb), imm:0x1, result rd:x13(0xfffffffffffffffd)
    li x13, MASK_XLEN(0xfffffffffffffffb)
    c.srai x13, 0x1
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffffffffd)

    # Testcase 198:  rd:x14(0xfffffffffffffff7), imm:0x1, result rd:x14(0xfffffffffffffffb)
    li x14, MASK_XLEN(0xfffffffffffffff7)
    c.srai x14, 0x1
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffffffffffffb)

    # Testcase 199:  rd:x15(0xffffffffffffffef), imm:0x1, result rd:x15(0xfffffffffffffff7)
    li x15, MASK_XLEN(0xffffffffffffffef)
    c.srai x15, 0x1
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffffffffffff7)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x1, test_41_res


    # Testcase 200:  rd:x8(0xffffffffffffffdf), imm:0x1, result rd:x8(0xffffffffffffffef)
    li x8, MASK_XLEN(0xffffffffffffffdf)
    c.srai x8, 0x1
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffffffffef)

    # Testcase 201:  rd:x9(0xffffffffffffffbf), imm:0x1, result rd:x9(0xffffffffffffffdf)
    li x9, MASK_XLEN(0xffffffffffffffbf)
    c.srai x9, 0x1
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffffffdf)

    # Testcase 202:  rd:x10(0xffffffffffffff7f), imm:0x1, result rd:x10(0xffffffffffffffbf)
    li x10, MASK_XLEN(0xffffffffffffff7f)
    c.srai x10, 0x1
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffffffbf)

    # Testcase 203:  rd:x11(0xfffffffffffffeff), imm:0x1, result rd:x11(0xffffffffffffff7f)
    li x11, MASK_XLEN(0xfffffffffffffeff)
    c.srai x11, 0x1
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffff7f)

    # Testcase 204:  rd:x12(0xfffffffffffffdff), imm:0x1, result rd:x12(0xfffffffffffffeff)
    li x12, MASK_XLEN(0xfffffffffffffdff)
    c.srai x12, 0x1
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffffffeff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res


    # Testcase 205:  rd:x13(0xfffffffffffffbff), imm:0x1, result rd:x13(0xfffffffffffffdff)
    li x13, MASK_XLEN(0xfffffffffffffbff)
    c.srai x13, 0x1
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffffffdff)

    # Testcase 206:  rd:x14(0xfffffffffffff7ff), imm:0x1, result rd:x14(0xfffffffffffffbff)
    li x14, MASK_XLEN(0xfffffffffffff7ff)
    c.srai x14, 0x1
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffffffffffbff)

    # Testcase 207:  rd:x15(0xffffffffffffefff), imm:0x1, result rd:x15(0xfffffffffffff7ff)
    li x15, MASK_XLEN(0xffffffffffffefff)
    c.srai x15, 0x1
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffffffffff7ff)

    # Testcase 208:  rd:x8(0xffffffffffffdfff), imm:0x1, result rd:x8(0xffffffffffffefff)
    li x8, MASK_XLEN(0xffffffffffffdfff)
    c.srai x8, 0x1
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffffffefff)

    # Testcase 209:  rd:x9(0xffffffffffffbfff), imm:0x1, result rd:x9(0xffffffffffffdfff)
    li x9, MASK_XLEN(0xffffffffffffbfff)
    c.srai x9, 0x1
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffffdfff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res


    # Testcase 210:  rd:x10(0xffffffffffff7fff), imm:0x1, result rd:x10(0xffffffffffffbfff)
    li x10, MASK_XLEN(0xffffffffffff7fff)
    c.srai x10, 0x1
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffffbfff)

    # Testcase 211:  rd:x11(0xfffffffffffeffff), imm:0x1, result rd:x11(0xffffffffffff7fff)
    li x11, MASK_XLEN(0xfffffffffffeffff)
    c.srai x11, 0x1
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffff7fff)

    # Testcase 212:  rd:x12(0xfffffffffffdffff), imm:0x1, result rd:x12(0xfffffffffffeffff)
    li x12, MASK_XLEN(0xfffffffffffdffff)
    c.srai x12, 0x1
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffffeffff)

    # Testcase 213:  rd:x13(0xfffffffffffbffff), imm:0x1, result rd:x13(0xfffffffffffdffff)
    li x13, MASK_XLEN(0xfffffffffffbffff)
    c.srai x13, 0x1
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffffdffff)

    # Testcase 214:  rd:x14(0xfffffffffff7ffff), imm:0x1, result rd:x14(0xfffffffffffbffff)
    li x14, MASK_XLEN(0xfffffffffff7ffff)
    c.srai x14, 0x1
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffffffffbffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x1, test_44_res


    # Testcase 215:  rd:x15(0xffffffffffefffff), imm:0x1, result rd:x15(0xfffffffffff7ffff)
    li x15, MASK_XLEN(0xffffffffffefffff)
    c.srai x15, 0x1
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffffffff7ffff)

    # Testcase 216:  rd:x8(0xffffffffffdfffff), imm:0x1, result rd:x8(0xffffffffffefffff)
    li x8, MASK_XLEN(0xffffffffffdfffff)
    c.srai x8, 0x1
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffffefffff)

    # Testcase 217:  rd:x9(0xffffffffffbfffff), imm:0x1, result rd:x9(0xffffffffffdfffff)
    li x9, MASK_XLEN(0xffffffffffbfffff)
    c.srai x9, 0x1
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffdfffff)

    # Testcase 218:  rd:x10(0xffffffffff7fffff), imm:0x1, result rd:x10(0xffffffffffbfffff)
    li x10, MASK_XLEN(0xffffffffff7fffff)
    c.srai x10, 0x1
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffbfffff)

    # Testcase 219:  rd:x11(0xfffffffffeffffff), imm:0x1, result rd:x11(0xffffffffff7fffff)
    li x11, MASK_XLEN(0xfffffffffeffffff)
    c.srai x11, 0x1
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffff7fffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res


    # Testcase 220:  rd:x12(0xfffffffffdffffff), imm:0x1, result rd:x12(0xfffffffffeffffff)
    li x12, MASK_XLEN(0xfffffffffdffffff)
    c.srai x12, 0x1
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffeffffff)

    # Testcase 221:  rd:x13(0xfffffffffbffffff), imm:0x1, result rd:x13(0xfffffffffdffffff)
    li x13, MASK_XLEN(0xfffffffffbffffff)
    c.srai x13, 0x1
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffdffffff)

    # Testcase 222:  rd:x14(0xfffffffff7ffffff), imm:0x1, result rd:x14(0xfffffffffbffffff)
    li x14, MASK_XLEN(0xfffffffff7ffffff)
    c.srai x14, 0x1
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffffffbffffff)

    # Testcase 223:  rd:x15(0xffffffffefffffff), imm:0x1, result rd:x15(0xfffffffff7ffffff)
    li x15, MASK_XLEN(0xffffffffefffffff)
    c.srai x15, 0x1
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffffff7ffffff)

    # Testcase 224:  rd:x8(0xffffffffdfffffff), imm:0x1, result rd:x8(0xffffffffefffffff)
    li x8, MASK_XLEN(0xffffffffdfffffff)
    c.srai x8, 0x1
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffefffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res


    # Testcase 225:  rd:x9(0xffffffffbfffffff), imm:0x1, result rd:x9(0xffffffffdfffffff)
    li x9, MASK_XLEN(0xffffffffbfffffff)
    c.srai x9, 0x1
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffdfffffff)

    # Testcase 226:  rd:x10(0xffffffff7fffffff), imm:0x1, result rd:x10(0xffffffffbfffffff)
    li x10, MASK_XLEN(0xffffffff7fffffff)
    c.srai x10, 0x1
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffbfffffff)

    # Testcase 227:  rd:x11(0xfffffffeffffffff), imm:0x1, result rd:x11(0xffffffff7fffffff)
    li x11, MASK_XLEN(0xfffffffeffffffff)
    c.srai x11, 0x1
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffff7fffffff)

    # Testcase 228:  rd:x12(0xfffffffdffffffff), imm:0x1, result rd:x12(0xfffffffeffffffff)
    li x12, MASK_XLEN(0xfffffffdffffffff)
    c.srai x12, 0x1
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffeffffffff)

    # Testcase 229:  rd:x13(0xfffffffbffffffff), imm:0x1, result rd:x13(0xfffffffdffffffff)
    li x13, MASK_XLEN(0xfffffffbffffffff)
    c.srai x13, 0x1
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffdffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x1, test_47_res


    # Testcase 230:  rd:x14(0xfffffff7ffffffff), imm:0x1, result rd:x14(0xfffffffbffffffff)
    li x14, MASK_XLEN(0xfffffff7ffffffff)
    c.srai x14, 0x1
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffffbffffffff)

    # Testcase 231:  rd:x15(0xffffffefffffffff), imm:0x1, result rd:x15(0xfffffff7ffffffff)
    li x15, MASK_XLEN(0xffffffefffffffff)
    c.srai x15, 0x1
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffff7ffffffff)

    # Testcase 232:  rd:x8(0xffffffdfffffffff), imm:0x1, result rd:x8(0xffffffefffffffff)
    li x8, MASK_XLEN(0xffffffdfffffffff)
    c.srai x8, 0x1
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffefffffffff)

    # Testcase 233:  rd:x9(0xffffffbfffffffff), imm:0x1, result rd:x9(0xffffffdfffffffff)
    li x9, MASK_XLEN(0xffffffbfffffffff)
    c.srai x9, 0x1
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffdfffffffff)

    # Testcase 234:  rd:x10(0xffffff7fffffffff), imm:0x1, result rd:x10(0xffffffbfffffffff)
    li x10, MASK_XLEN(0xffffff7fffffffff)
    c.srai x10, 0x1
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffbfffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res


    # Testcase 235:  rd:x11(0xfffffeffffffffff), imm:0x1, result rd:x11(0xffffff7fffffffff)
    li x11, MASK_XLEN(0xfffffeffffffffff)
    c.srai x11, 0x1
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffff7fffffffff)

    # Testcase 236:  rd:x12(0xfffffdffffffffff), imm:0x1, result rd:x12(0xfffffeffffffffff)
    li x12, MASK_XLEN(0xfffffdffffffffff)
    c.srai x12, 0x1
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffeffffffffff)

    # Testcase 237:  rd:x13(0xfffffbffffffffff), imm:0x1, result rd:x13(0xfffffdffffffffff)
    li x13, MASK_XLEN(0xfffffbffffffffff)
    c.srai x13, 0x1
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffdffffffffff)

    # Testcase 238:  rd:x14(0xfffff7ffffffffff), imm:0x1, result rd:x14(0xfffffbffffffffff)
    li x14, MASK_XLEN(0xfffff7ffffffffff)
    c.srai x14, 0x1
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffbffffffffff)

    # Testcase 239:  rd:x15(0xffffefffffffffff), imm:0x1, result rd:x15(0xfffff7ffffffffff)
    li x15, MASK_XLEN(0xffffefffffffffff)
    c.srai x15, 0x1
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffff7ffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res


    # Testcase 240:  rd:x8(0xffffdfffffffffff), imm:0x1, result rd:x8(0xffffefffffffffff)
    li x8, MASK_XLEN(0xffffdfffffffffff)
    c.srai x8, 0x1
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffefffffffffff)

    # Testcase 241:  rd:x9(0xffffbfffffffffff), imm:0x1, result rd:x9(0xffffdfffffffffff)
    li x9, MASK_XLEN(0xffffbfffffffffff)
    c.srai x9, 0x1
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffdfffffffffff)

    # Testcase 242:  rd:x10(0xffff7fffffffffff), imm:0x1, result rd:x10(0xffffbfffffffffff)
    li x10, MASK_XLEN(0xffff7fffffffffff)
    c.srai x10, 0x1
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffbfffffffffff)

    # Testcase 243:  rd:x11(0xfffeffffffffffff), imm:0x1, result rd:x11(0xffff7fffffffffff)
    li x11, MASK_XLEN(0xfffeffffffffffff)
    c.srai x11, 0x1
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffff7fffffffffff)

    # Testcase 244:  rd:x12(0xfffdffffffffffff), imm:0x1, result rd:x12(0xfffeffffffffffff)
    li x12, MASK_XLEN(0xfffdffffffffffff)
    c.srai x12, 0x1
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffeffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x1, test_50_res


    # Testcase 245:  rd:x13(0xfffbffffffffffff), imm:0x1, result rd:x13(0xfffdffffffffffff)
    li x13, MASK_XLEN(0xfffbffffffffffff)
    c.srai x13, 0x1
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffdffffffffffff)

    # Testcase 246:  rd:x14(0xfff7ffffffffffff), imm:0x1, result rd:x14(0xfffbffffffffffff)
    li x14, MASK_XLEN(0xfff7ffffffffffff)
    c.srai x14, 0x1
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffbffffffffffff)

    # Testcase 247:  rd:x15(0xffefffffffffffff), imm:0x1, result rd:x15(0xfff7ffffffffffff)
    li x15, MASK_XLEN(0xffefffffffffffff)
    c.srai x15, 0x1
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfff7ffffffffffff)

    # Testcase 248:  rd:x8(0xffdfffffffffffff), imm:0x1, result rd:x8(0xffefffffffffffff)
    li x8, MASK_XLEN(0xffdfffffffffffff)
    c.srai x8, 0x1
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffefffffffffffff)

    # Testcase 249:  rd:x9(0xffbfffffffffffff), imm:0x1, result rd:x9(0xffdfffffffffffff)
    li x9, MASK_XLEN(0xffbfffffffffffff)
    c.srai x9, 0x1
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffdfffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res


    # Testcase 250:  rd:x10(0xff7fffffffffffff), imm:0x1, result rd:x10(0xffbfffffffffffff)
    li x10, MASK_XLEN(0xff7fffffffffffff)
    c.srai x10, 0x1
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffbfffffffffffff)

    # Testcase 251:  rd:x11(0xfeffffffffffffff), imm:0x1, result rd:x11(0xff7fffffffffffff)
    li x11, MASK_XLEN(0xfeffffffffffffff)
    c.srai x11, 0x1
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xff7fffffffffffff)

    # Testcase 252:  rd:x12(0xfdffffffffffffff), imm:0x1, result rd:x12(0xfeffffffffffffff)
    li x12, MASK_XLEN(0xfdffffffffffffff)
    c.srai x12, 0x1
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfeffffffffffffff)

    # Testcase 253:  rd:x13(0xfbffffffffffffff), imm:0x1, result rd:x13(0xfdffffffffffffff)
    li x13, MASK_XLEN(0xfbffffffffffffff)
    c.srai x13, 0x1
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfdffffffffffffff)

    # Testcase 254:  rd:x14(0xf7ffffffffffffff), imm:0x1, result rd:x14(0xfbffffffffffffff)
    li x14, MASK_XLEN(0xf7ffffffffffffff)
    c.srai x14, 0x1
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfbffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res


    # Testcase 255:  rd:x15(0xefffffffffffffff), imm:0x1, result rd:x15(0xf7ffffffffffffff)
    li x15, MASK_XLEN(0xefffffffffffffff)
    c.srai x15, 0x1
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xf7ffffffffffffff)

    # Testcase 256:  rd:x8(0xdfffffffffffffff), imm:0x1, result rd:x8(0xefffffffffffffff)
    li x8, MASK_XLEN(0xdfffffffffffffff)
    c.srai x8, 0x1
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xefffffffffffffff)

    # Testcase 257:  rd:x9(0xbfffffffffffffff), imm:0x1, result rd:x9(0xdfffffffffffffff)
    li x9, MASK_XLEN(0xbfffffffffffffff)
    c.srai x9, 0x1
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xdfffffffffffffff)

    # Testcase 258:  rd:x10(0x7fffffffffffffff), imm:0x1, result rd:x10(0x3fffffffffffffff)
    li x10, MASK_XLEN(0x7fffffffffffffff)
    c.srai x10, 0x1
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x3fffffffffffffff)

    # Testcase 259:  rd:x11(0xffffffffffffffff), imm:0x1, result rd:x11(0xffffffffffffffff)
    li x11, MASK_XLEN(0xffffffffffffffff)
    c.srai x11, 0x1
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x1, test_53_res


    # Testcase 260:  rd:x12(0x00000001), imm:0x8, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1)
    c.srai x12, 0x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 261:  rd:x13(0x00000002), imm:0x4, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2)
    c.srai x13, 0x4
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 262:  rd:x14(0x00000004), imm:0x2, result rd:x14(0x00000001)
    li x14, MASK_XLEN(0x4)
    c.srai x14, 0x2
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x1)

    # Testcase 263:  rd:x15(0x00000008), imm:0x1, result rd:x15(0x00000004)
    li x15, MASK_XLEN(0x8)
    c.srai x15, 0x1
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x4)


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

