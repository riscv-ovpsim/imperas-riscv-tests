# RISC-V Compliance Test I-C-SRLI-01
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
# Description: Testing instruction 'c.srli'.

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
    c.srli x8, 0x1f
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 1:  rd:x9(0x00000002), imm:0xf, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x2)
    c.srli x9, 0xf
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 2:  rd:x10(0x00000004), imm:0x17, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x4)
    c.srli x10, 0x17
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 3:  rd:x11(0x00000008), imm:0x1b, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x8)
    c.srli x11, 0x1b
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 4:  rd:x12(0x00000010), imm:0x1d, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x10)
    c.srli x12, 0x1d
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rd:x13(0x00000020), imm:0x1e, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x20)
    c.srli x13, 0x1e
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 6:  rd:x14(0x00000040), imm:0x1, result rd:x14(0x00000020)
    li x14, MASK_XLEN(0x40)
    c.srli x14, 0x1
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x20)

    # Testcase 7:  rd:x15(0x00000080), imm:0x10, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x80)
    c.srli x15, 0x10
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 8:  rd:x8(0x00000100), imm:0x8, result rd:x8(0x00000001)
    li x8, MASK_XLEN(0x100)
    c.srli x8, 0x8
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1)

    # Testcase 9:  rd:x9(0x00000200), imm:0x4, result rd:x9(0x00000020)
    li x9, MASK_XLEN(0x200)
    c.srli x9, 0x4
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rd:x10(0x00000400), imm:0x2, result rd:x10(0x00000100)
    li x10, MASK_XLEN(0x400)
    c.srli x10, 0x2
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x100)

    # Testcase 11:  rd:x11(0x00000800), imm:0x1, result rd:x11(0x00000400)
    li x11, MASK_XLEN(0x800)
    c.srli x11, 0x1
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400)

    # Testcase 12:  rd:x12(0x00001000), imm:0x1f, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1000)
    c.srli x12, 0x1f
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 13:  rd:x13(0x00002000), imm:0xf, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2000)
    c.srli x13, 0xf
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 14:  rd:x14(0x00004000), imm:0x17, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x4000)
    c.srli x14, 0x17
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x1, test_4_res


    # Testcase 15:  rd:x15(0x00008000), imm:0x1b, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x8000)
    c.srli x15, 0x1b
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 16:  rd:x8(0x00010000), imm:0x1d, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x10000)
    c.srli x8, 0x1d
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 17:  rd:x9(0x00020000), imm:0x1e, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x20000)
    c.srli x9, 0x1e
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 18:  rd:x10(0x00040000), imm:0x1, result rd:x10(0x00020000)
    li x10, MASK_XLEN(0x40000)
    c.srli x10, 0x1
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x20000)

    # Testcase 19:  rd:x11(0x00080000), imm:0x10, result rd:x11(0x00000008)
    li x11, MASK_XLEN(0x80000)
    c.srli x11, 0x10
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rd:x12(0x00100000), imm:0x8, result rd:x12(0x00001000)
    li x12, MASK_XLEN(0x100000)
    c.srli x12, 0x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000)

    # Testcase 21:  rd:x13(0x00200000), imm:0x4, result rd:x13(0x00020000)
    li x13, MASK_XLEN(0x200000)
    c.srli x13, 0x4
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x20000)

    # Testcase 22:  rd:x14(0x00400000), imm:0x2, result rd:x14(0x00100000)
    li x14, MASK_XLEN(0x400000)
    c.srli x14, 0x2
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x100000)

    # Testcase 23:  rd:x15(0x00800000), imm:0x1, result rd:x15(0x00400000)
    li x15, MASK_XLEN(0x800000)
    c.srli x15, 0x1
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x400000)

    # Testcase 24:  rd:x8(0x01000000), imm:0x1f, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x1000000)
    c.srli x8, 0x1f
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rd:x9(0x02000000), imm:0xf, result rd:x9(0x00000400)
    li x9, MASK_XLEN(0x2000000)
    c.srli x9, 0xf
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x400)

    # Testcase 26:  rd:x10(0x04000000), imm:0x17, result rd:x10(0x00000008)
    li x10, MASK_XLEN(0x4000000)
    c.srli x10, 0x17
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8)

    # Testcase 27:  rd:x11(0x08000000), imm:0x1b, result rd:x11(0x00000001)
    li x11, MASK_XLEN(0x8000000)
    c.srli x11, 0x1b
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1)

    # Testcase 28:  rd:x12(0x10000000), imm:0x1d, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x10000000)
    c.srli x12, 0x1d
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 29:  rd:x13(0x20000000), imm:0x1e, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x20000000)
    c.srli x13, 0x1e
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x1, test_7_res


    # Testcase 30:  rd:x14(0x40000000), imm:0x1, result rd:x14(0x20000000)
    li x14, MASK_XLEN(0x40000000)
    c.srli x14, 0x1
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x20000000)

    # Testcase 31:  rd:x15(0x80000000), imm:0x10, result rd:x15(0x00008000)
    li x15, MASK_XLEN(0x80000000)
    c.srli x15, 0x10
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x8000)

    # Testcase 32:  rd:x8(0x100000000), imm:0x8, result rd:x8(0x01000000)
    li x8, MASK_XLEN(0x100000000)
    c.srli x8, 0x8
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1000000)

    # Testcase 33:  rd:x9(0x200000000), imm:0x4, result rd:x9(0x20000000)
    li x9, MASK_XLEN(0x200000000)
    c.srli x9, 0x4
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20000000)

    # Testcase 34:  rd:x10(0x400000000), imm:0x2, result rd:x10(0x100000000)
    li x10, MASK_XLEN(0x400000000)
    c.srli x10, 0x2
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x100000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rd:x11(0x800000000), imm:0x1, result rd:x11(0x400000000)
    li x11, MASK_XLEN(0x800000000)
    c.srli x11, 0x1
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400000000)

    # Testcase 36:  rd:x12(0x1000000000), imm:0x1f, result rd:x12(0x00000020)
    li x12, MASK_XLEN(0x1000000000)
    c.srli x12, 0x1f
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20)

    # Testcase 37:  rd:x13(0x2000000000), imm:0xf, result rd:x13(0x00400000)
    li x13, MASK_XLEN(0x2000000000)
    c.srli x13, 0xf
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400000)

    # Testcase 38:  rd:x14(0x4000000000), imm:0x17, result rd:x14(0x00008000)
    li x14, MASK_XLEN(0x4000000000)
    c.srli x14, 0x17
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000)

    # Testcase 39:  rd:x15(0x8000000000), imm:0x1b, result rd:x15(0x00001000)
    li x15, MASK_XLEN(0x8000000000)
    c.srli x15, 0x1b
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rd:x8(0x10000000000), imm:0x1d, result rd:x8(0x00000800)
    li x8, MASK_XLEN(0x10000000000)
    c.srli x8, 0x1d
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x800)

    # Testcase 41:  rd:x9(0x20000000000), imm:0x1e, result rd:x9(0x00000800)
    li x9, MASK_XLEN(0x20000000000)
    c.srli x9, 0x1e
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x800)

    # Testcase 42:  rd:x10(0x40000000000), imm:0x1, result rd:x10(0x20000000000)
    li x10, MASK_XLEN(0x40000000000)
    c.srli x10, 0x1
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x20000000000)

    # Testcase 43:  rd:x11(0x80000000000), imm:0x10, result rd:x11(0x08000000)
    li x11, MASK_XLEN(0x80000000000)
    c.srli x11, 0x10
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8000000)

    # Testcase 44:  rd:x12(0x100000000000), imm:0x8, result rd:x12(0x1000000000)
    li x12, MASK_XLEN(0x100000000000)
    c.srli x12, 0x8
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x1, test_10_res


    # Testcase 45:  rd:x13(0x200000000000), imm:0x4, result rd:x13(0x20000000000)
    li x13, MASK_XLEN(0x200000000000)
    c.srli x13, 0x4
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x20000000000)

    # Testcase 46:  rd:x14(0x400000000000), imm:0x2, result rd:x14(0x100000000000)
    li x14, MASK_XLEN(0x400000000000)
    c.srli x14, 0x2
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x100000000000)

    # Testcase 47:  rd:x15(0x800000000000), imm:0x1, result rd:x15(0x400000000000)
    li x15, MASK_XLEN(0x800000000000)
    c.srli x15, 0x1
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x400000000000)

    # Testcase 48:  rd:x8(0x1000000000000), imm:0x1f, result rd:x8(0x00020000)
    li x8, MASK_XLEN(0x1000000000000)
    c.srli x8, 0x1f
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000)

    # Testcase 49:  rd:x9(0x2000000000000), imm:0xf, result rd:x9(0x400000000)
    li x9, MASK_XLEN(0x2000000000000)
    c.srli x9, 0xf
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x400000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rd:x10(0x4000000000000), imm:0x17, result rd:x10(0x08000000)
    li x10, MASK_XLEN(0x4000000000000)
    c.srli x10, 0x17
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000000)

    # Testcase 51:  rd:x11(0x8000000000000), imm:0x1b, result rd:x11(0x01000000)
    li x11, MASK_XLEN(0x8000000000000)
    c.srli x11, 0x1b
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000000)

    # Testcase 52:  rd:x12(0x10000000000000), imm:0x1d, result rd:x12(0x00800000)
    li x12, MASK_XLEN(0x10000000000000)
    c.srli x12, 0x1d
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x800000)

    # Testcase 53:  rd:x13(0x20000000000000), imm:0x1e, result rd:x13(0x00800000)
    li x13, MASK_XLEN(0x20000000000000)
    c.srli x13, 0x1e
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x800000)

    # Testcase 54:  rd:x14(0x40000000000000), imm:0x1, result rd:x14(0x20000000000000)
    li x14, MASK_XLEN(0x40000000000000)
    c.srli x14, 0x1
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x20000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rd:x15(0x80000000000000), imm:0x10, result rd:x15(0x8000000000)
    li x15, MASK_XLEN(0x80000000000000)
    c.srli x15, 0x10
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x8000000000)

    # Testcase 56:  rd:x8(0x100000000000000), imm:0x8, result rd:x8(0x1000000000000)
    li x8, MASK_XLEN(0x100000000000000)
    c.srli x8, 0x8
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1000000000000)

    # Testcase 57:  rd:x9(0x200000000000000), imm:0x4, result rd:x9(0x20000000000000)
    li x9, MASK_XLEN(0x200000000000000)
    c.srli x9, 0x4
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20000000000000)

    # Testcase 58:  rd:x10(0x400000000000000), imm:0x2, result rd:x10(0x100000000000000)
    li x10, MASK_XLEN(0x400000000000000)
    c.srli x10, 0x2
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x100000000000000)

    # Testcase 59:  rd:x11(0x800000000000000), imm:0x1, result rd:x11(0x400000000000000)
    li x11, MASK_XLEN(0x800000000000000)
    c.srli x11, 0x1
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x1, test_13_res


    # Testcase 60:  rd:x12(0x1000000000000000), imm:0x1f, result rd:x12(0x20000000)
    li x12, MASK_XLEN(0x1000000000000000)
    c.srli x12, 0x1f
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20000000)

    # Testcase 61:  rd:x13(0x2000000000000000), imm:0xf, result rd:x13(0x400000000000)
    li x13, MASK_XLEN(0x2000000000000000)
    c.srli x13, 0xf
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400000000000)

    # Testcase 62:  rd:x14(0x4000000000000000), imm:0x17, result rd:x14(0x8000000000)
    li x14, MASK_XLEN(0x4000000000000000)
    c.srli x14, 0x17
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000000000)

    # Testcase 63:  rd:x15(0x8000000000000000), imm:0x1b, result rd:x15(0x1000000000)
    li x15, MASK_XLEN(0x8000000000000000)
    c.srli x15, 0x1b
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1000000000)

    # Testcase 64:  rd:x8(0x00000000), imm:0x1d, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x0)
    c.srli x8, 0x1d
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rd:x9(0xfffffffffffffffe), imm:0x1e, result rd:x9(0x3ffffffff)
    li x9, MASK_XLEN(0xfffffffffffffffe)
    c.srli x9, 0x1e
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x3ffffffff)

    # Testcase 66:  rd:x10(0xfffffffffffffffd), imm:0x1, result rd:x10(0x7ffffffffffffffe)
    li x10, MASK_XLEN(0xfffffffffffffffd)
    c.srli x10, 0x1
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7ffffffffffffffe)

    # Testcase 67:  rd:x11(0xfffffffffffffffb), imm:0x10, result rd:x11(0xffffffffffff)
    li x11, MASK_XLEN(0xfffffffffffffffb)
    c.srli x11, 0x10
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffff)

    # Testcase 68:  rd:x12(0xfffffffffffffff7), imm:0x8, result rd:x12(0xffffffffffffff)
    li x12, MASK_XLEN(0xfffffffffffffff7)
    c.srli x12, 0x8
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffff)

    # Testcase 69:  rd:x13(0xffffffffffffffef), imm:0x4, result rd:x13(0xffffffffffffffe)
    li x13, MASK_XLEN(0xffffffffffffffef)
    c.srli x13, 0x4
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffffffffe)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rd:x14(0xffffffffffffffdf), imm:0x2, result rd:x14(0x3ffffffffffffff7)
    li x14, MASK_XLEN(0xffffffffffffffdf)
    c.srli x14, 0x2
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x3ffffffffffffff7)

    # Testcase 71:  rd:x15(0xffffffffffffffbf), imm:0x1, result rd:x15(0x7fffffffffffffdf)
    li x15, MASK_XLEN(0xffffffffffffffbf)
    c.srli x15, 0x1
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x7fffffffffffffdf)

    # Testcase 72:  rd:x8(0xffffffffffffff7f), imm:0x1f, result rd:x8(0x1ffffffff)
    li x8, MASK_XLEN(0xffffffffffffff7f)
    c.srli x8, 0x1f
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1ffffffff)

    # Testcase 73:  rd:x9(0xfffffffffffffeff), imm:0xf, result rd:x9(0x1ffffffffffff)
    li x9, MASK_XLEN(0xfffffffffffffeff)
    c.srli x9, 0xf
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1ffffffffffff)

    # Testcase 74:  rd:x10(0xfffffffffffffdff), imm:0x17, result rd:x10(0x1ffffffffff)
    li x10, MASK_XLEN(0xfffffffffffffdff)
    c.srli x10, 0x17
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1ffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x1, test_16_res


    # Testcase 75:  rd:x11(0xfffffffffffffbff), imm:0x1b, result rd:x11(0x1fffffffff)
    li x11, MASK_XLEN(0xfffffffffffffbff)
    c.srli x11, 0x1b
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1fffffffff)

    # Testcase 76:  rd:x12(0xfffffffffffff7ff), imm:0x1d, result rd:x12(0x7ffffffff)
    li x12, MASK_XLEN(0xfffffffffffff7ff)
    c.srli x12, 0x1d
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7ffffffff)

    # Testcase 77:  rd:x13(0xffffffffffffefff), imm:0x1e, result rd:x13(0x3ffffffff)
    li x13, MASK_XLEN(0xffffffffffffefff)
    c.srli x13, 0x1e
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x3ffffffff)

    # Testcase 78:  rd:x14(0xffffffffffffdfff), imm:0x1, result rd:x14(0x7fffffffffffefff)
    li x14, MASK_XLEN(0xffffffffffffdfff)
    c.srli x14, 0x1
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x7fffffffffffefff)

    # Testcase 79:  rd:x15(0xffffffffffffbfff), imm:0x10, result rd:x15(0xffffffffffff)
    li x15, MASK_XLEN(0xffffffffffffbfff)
    c.srli x15, 0x10
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rd:x8(0xffffffffffff7fff), imm:0x8, result rd:x8(0xffffffffffff7f)
    li x8, MASK_XLEN(0xffffffffffff7fff)
    c.srli x8, 0x8
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffffff7f)

    # Testcase 81:  rd:x9(0xfffffffffffeffff), imm:0x4, result rd:x9(0xfffffffffffefff)
    li x9, MASK_XLEN(0xfffffffffffeffff)
    c.srli x9, 0x4
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffffffefff)

    # Testcase 82:  rd:x10(0xfffffffffffdffff), imm:0x2, result rd:x10(0x3fffffffffff7fff)
    li x10, MASK_XLEN(0xfffffffffffdffff)
    c.srli x10, 0x2
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x3fffffffffff7fff)

    # Testcase 83:  rd:x11(0xfffffffffffbffff), imm:0x1, result rd:x11(0x7ffffffffffdffff)
    li x11, MASK_XLEN(0xfffffffffffbffff)
    c.srli x11, 0x1
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7ffffffffffdffff)

    # Testcase 84:  rd:x12(0xfffffffffff7ffff), imm:0x1f, result rd:x12(0x1ffffffff)
    li x12, MASK_XLEN(0xfffffffffff7ffff)
    c.srli x12, 0x1f
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1ffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rd:x13(0xffffffffffefffff), imm:0xf, result rd:x13(0x1ffffffffffdf)
    li x13, MASK_XLEN(0xffffffffffefffff)
    c.srli x13, 0xf
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x1ffffffffffdf)

    # Testcase 86:  rd:x14(0xffffffffffdfffff), imm:0x17, result rd:x14(0x1ffffffffff)
    li x14, MASK_XLEN(0xffffffffffdfffff)
    c.srli x14, 0x17
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x1ffffffffff)

    # Testcase 87:  rd:x15(0xffffffffffbfffff), imm:0x1b, result rd:x15(0x1fffffffff)
    li x15, MASK_XLEN(0xffffffffffbfffff)
    c.srli x15, 0x1b
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1fffffffff)

    # Testcase 88:  rd:x8(0xffffffffff7fffff), imm:0x1d, result rd:x8(0x7ffffffff)
    li x8, MASK_XLEN(0xffffffffff7fffff)
    c.srli x8, 0x1d
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7ffffffff)

    # Testcase 89:  rd:x9(0xfffffffffeffffff), imm:0x1e, result rd:x9(0x3ffffffff)
    li x9, MASK_XLEN(0xfffffffffeffffff)
    c.srli x9, 0x1e
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x3ffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x1, test_19_res


    # Testcase 90:  rd:x10(0xfffffffffdffffff), imm:0x1, result rd:x10(0x7ffffffffeffffff)
    li x10, MASK_XLEN(0xfffffffffdffffff)
    c.srli x10, 0x1
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7ffffffffeffffff)

    # Testcase 91:  rd:x11(0xfffffffffbffffff), imm:0x10, result rd:x11(0xfffffffffbff)
    li x11, MASK_XLEN(0xfffffffffbffffff)
    c.srli x11, 0x10
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffffbff)

    # Testcase 92:  rd:x12(0xfffffffff7ffffff), imm:0x8, result rd:x12(0xfffffffff7ffff)
    li x12, MASK_XLEN(0xfffffffff7ffffff)
    c.srli x12, 0x8
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffff7ffff)

    # Testcase 93:  rd:x13(0xffffffffefffffff), imm:0x4, result rd:x13(0xffffffffeffffff)
    li x13, MASK_XLEN(0xffffffffefffffff)
    c.srli x13, 0x4
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffeffffff)

    # Testcase 94:  rd:x14(0xffffffffdfffffff), imm:0x2, result rd:x14(0x3ffffffff7ffffff)
    li x14, MASK_XLEN(0xffffffffdfffffff)
    c.srli x14, 0x2
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x3ffffffff7ffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rd:x15(0xffffffffbfffffff), imm:0x1, result rd:x15(0x7fffffffdfffffff)
    li x15, MASK_XLEN(0xffffffffbfffffff)
    c.srli x15, 0x1
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x7fffffffdfffffff)

    # Testcase 96:  rd:x8(0xffffffff7fffffff), imm:0x1f, result rd:x8(0x1fffffffe)
    li x8, MASK_XLEN(0xffffffff7fffffff)
    c.srli x8, 0x1f
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1fffffffe)

    # Testcase 97:  rd:x9(0xfffffffeffffffff), imm:0xf, result rd:x9(0x1fffffffdffff)
    li x9, MASK_XLEN(0xfffffffeffffffff)
    c.srli x9, 0xf
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1fffffffdffff)

    # Testcase 98:  rd:x10(0xfffffffdffffffff), imm:0x17, result rd:x10(0x1fffffffbff)
    li x10, MASK_XLEN(0xfffffffdffffffff)
    c.srli x10, 0x17
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1fffffffbff)

    # Testcase 99:  rd:x11(0xfffffffbffffffff), imm:0x1b, result rd:x11(0x1fffffff7f)
    li x11, MASK_XLEN(0xfffffffbffffffff)
    c.srli x11, 0x1b
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1fffffff7f)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rd:x12(0xfffffff7ffffffff), imm:0x1d, result rd:x12(0x7ffffffbf)
    li x12, MASK_XLEN(0xfffffff7ffffffff)
    c.srli x12, 0x1d
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7ffffffbf)

    # Testcase 101:  rd:x13(0xffffffefffffffff), imm:0x1e, result rd:x13(0x3ffffffbf)
    li x13, MASK_XLEN(0xffffffefffffffff)
    c.srli x13, 0x1e
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x3ffffffbf)

    # Testcase 102:  rd:x14(0xffffffdfffffffff), imm:0x1, result rd:x14(0x7fffffefffffffff)
    li x14, MASK_XLEN(0xffffffdfffffffff)
    c.srli x14, 0x1
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x7fffffefffffffff)

    # Testcase 103:  rd:x15(0xffffffbfffffffff), imm:0x10, result rd:x15(0xffffffbfffff)
    li x15, MASK_XLEN(0xffffffbfffffffff)
    c.srli x15, 0x10
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffbfffff)

    # Testcase 104:  rd:x8(0xffffff7fffffffff), imm:0x8, result rd:x8(0xffffff7fffffff)
    li x8, MASK_XLEN(0xffffff7fffffffff)
    c.srli x8, 0x8
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffff7fffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x1, test_22_res


    # Testcase 105:  rd:x9(0xfffffeffffffffff), imm:0x4, result rd:x9(0xfffffefffffffff)
    li x9, MASK_XLEN(0xfffffeffffffffff)
    c.srli x9, 0x4
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffefffffffff)

    # Testcase 106:  rd:x10(0xfffffdffffffffff), imm:0x2, result rd:x10(0x3fffff7fffffffff)
    li x10, MASK_XLEN(0xfffffdffffffffff)
    c.srli x10, 0x2
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x3fffff7fffffffff)

    # Testcase 107:  rd:x11(0xfffffbffffffffff), imm:0x1, result rd:x11(0x7ffffdffffffffff)
    li x11, MASK_XLEN(0xfffffbffffffffff)
    c.srli x11, 0x1
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7ffffdffffffffff)

    # Testcase 108:  rd:x12(0xfffff7ffffffffff), imm:0x1f, result rd:x12(0x1ffffefff)
    li x12, MASK_XLEN(0xfffff7ffffffffff)
    c.srli x12, 0x1f
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1ffffefff)

    # Testcase 109:  rd:x13(0xffffefffffffffff), imm:0xf, result rd:x13(0x1ffffdfffffff)
    li x13, MASK_XLEN(0xffffefffffffffff)
    c.srli x13, 0xf
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x1ffffdfffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rd:x14(0xffffdfffffffffff), imm:0x17, result rd:x14(0x1ffffbfffff)
    li x14, MASK_XLEN(0xffffdfffffffffff)
    c.srli x14, 0x17
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x1ffffbfffff)

    # Testcase 111:  rd:x15(0xffffbfffffffffff), imm:0x1b, result rd:x15(0x1ffff7ffff)
    li x15, MASK_XLEN(0xffffbfffffffffff)
    c.srli x15, 0x1b
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1ffff7ffff)

    # Testcase 112:  rd:x8(0xffff7fffffffffff), imm:0x1d, result rd:x8(0x7fffbffff)
    li x8, MASK_XLEN(0xffff7fffffffffff)
    c.srli x8, 0x1d
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fffbffff)

    # Testcase 113:  rd:x9(0xfffeffffffffffff), imm:0x1e, result rd:x9(0x3fffbffff)
    li x9, MASK_XLEN(0xfffeffffffffffff)
    c.srli x9, 0x1e
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x3fffbffff)

    # Testcase 114:  rd:x10(0xfffdffffffffffff), imm:0x1, result rd:x10(0x7ffeffffffffffff)
    li x10, MASK_XLEN(0xfffdffffffffffff)
    c.srli x10, 0x1
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7ffeffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rd:x11(0xfffbffffffffffff), imm:0x10, result rd:x11(0xfffbffffffff)
    li x11, MASK_XLEN(0xfffbffffffffffff)
    c.srli x11, 0x10
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffbffffffff)

    # Testcase 116:  rd:x12(0xfff7ffffffffffff), imm:0x8, result rd:x12(0xfff7ffffffffff)
    li x12, MASK_XLEN(0xfff7ffffffffffff)
    c.srli x12, 0x8
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfff7ffffffffff)

    # Testcase 117:  rd:x13(0xffefffffffffffff), imm:0x4, result rd:x13(0xffeffffffffffff)
    li x13, MASK_XLEN(0xffefffffffffffff)
    c.srli x13, 0x4
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffeffffffffffff)

    # Testcase 118:  rd:x14(0xffdfffffffffffff), imm:0x2, result rd:x14(0x3ff7ffffffffffff)
    li x14, MASK_XLEN(0xffdfffffffffffff)
    c.srli x14, 0x2
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x3ff7ffffffffffff)

    # Testcase 119:  rd:x15(0xffbfffffffffffff), imm:0x1, result rd:x15(0x7fdfffffffffffff)
    li x15, MASK_XLEN(0xffbfffffffffffff)
    c.srli x15, 0x1
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x7fdfffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x1, test_25_res


    # Testcase 120:  rd:x8(0xff7fffffffffffff), imm:0x1f, result rd:x8(0x1feffffff)
    li x8, MASK_XLEN(0xff7fffffffffffff)
    c.srli x8, 0x1f
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1feffffff)

    # Testcase 121:  rd:x9(0xfeffffffffffffff), imm:0xf, result rd:x9(0x1fdffffffffff)
    li x9, MASK_XLEN(0xfeffffffffffffff)
    c.srli x9, 0xf
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1fdffffffffff)

    # Testcase 122:  rd:x10(0xfdffffffffffffff), imm:0x17, result rd:x10(0x1fbffffffff)
    li x10, MASK_XLEN(0xfdffffffffffffff)
    c.srli x10, 0x17
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1fbffffffff)

    # Testcase 123:  rd:x11(0xfbffffffffffffff), imm:0x1b, result rd:x11(0x1f7fffffff)
    li x11, MASK_XLEN(0xfbffffffffffffff)
    c.srli x11, 0x1b
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1f7fffffff)

    # Testcase 124:  rd:x12(0xf7ffffffffffffff), imm:0x1d, result rd:x12(0x7bfffffff)
    li x12, MASK_XLEN(0xf7ffffffffffffff)
    c.srli x12, 0x1d
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7bfffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rd:x13(0xefffffffffffffff), imm:0x1e, result rd:x13(0x3bfffffff)
    li x13, MASK_XLEN(0xefffffffffffffff)
    c.srli x13, 0x1e
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x3bfffffff)

    # Testcase 126:  rd:x14(0xdfffffffffffffff), imm:0x1, result rd:x14(0x6fffffffffffffff)
    li x14, MASK_XLEN(0xdfffffffffffffff)
    c.srli x14, 0x1
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x6fffffffffffffff)

    # Testcase 127:  rd:x15(0xbfffffffffffffff), imm:0x10, result rd:x15(0xbfffffffffff)
    li x15, MASK_XLEN(0xbfffffffffffffff)
    c.srli x15, 0x10
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xbfffffffffff)

    # Testcase 128:  rd:x8(0x7fffffffffffffff), imm:0x8, result rd:x8(0x7fffffffffffff)
    li x8, MASK_XLEN(0x7fffffffffffffff)
    c.srli x8, 0x8
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fffffffffffff)

    # Testcase 129:  rd:x9(0xffffffffffffffff), imm:0x4, result rd:x9(0xfffffffffffffff)
    li x9, MASK_XLEN(0xffffffffffffffff)
    c.srli x9, 0x4
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rd:x10(0x00000001), imm:0x1, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x1)
    c.srli x10, 0x1
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 131:  rd:x11(0x00000002), imm:0x1, result rd:x11(0x00000001)
    li x11, MASK_XLEN(0x2)
    c.srli x11, 0x1
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1)

    # Testcase 132:  rd:x12(0x00000004), imm:0x1, result rd:x12(0x00000002)
    li x12, MASK_XLEN(0x4)
    c.srli x12, 0x1
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2)

    # Testcase 133:  rd:x13(0x00000008), imm:0x1, result rd:x13(0x00000004)
    li x13, MASK_XLEN(0x8)
    c.srli x13, 0x1
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4)

    # Testcase 134:  rd:x14(0x00000010), imm:0x1, result rd:x14(0x00000008)
    li x14, MASK_XLEN(0x10)
    c.srli x14, 0x1
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res


    # Testcase 135:  rd:x15(0x00000020), imm:0x1, result rd:x15(0x00000010)
    li x15, MASK_XLEN(0x20)
    c.srli x15, 0x1
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10)

    # Testcase 136:  rd:x8(0x00000040), imm:0x1, result rd:x8(0x00000020)
    li x8, MASK_XLEN(0x40)
    c.srli x8, 0x1
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20)

    # Testcase 137:  rd:x9(0x00000080), imm:0x1, result rd:x9(0x00000040)
    li x9, MASK_XLEN(0x80)
    c.srli x9, 0x1
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x40)

    # Testcase 138:  rd:x10(0x00000100), imm:0x1, result rd:x10(0x00000080)
    li x10, MASK_XLEN(0x100)
    c.srli x10, 0x1
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80)

    # Testcase 139:  rd:x11(0x00000200), imm:0x1, result rd:x11(0x00000100)
    li x11, MASK_XLEN(0x200)
    c.srli x11, 0x1
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x100)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res


    # Testcase 140:  rd:x12(0x00000400), imm:0x1, result rd:x12(0x00000200)
    li x12, MASK_XLEN(0x400)
    c.srli x12, 0x1
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200)

    # Testcase 141:  rd:x13(0x00000800), imm:0x1, result rd:x13(0x00000400)
    li x13, MASK_XLEN(0x800)
    c.srli x13, 0x1
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400)

    # Testcase 142:  rd:x14(0x00001000), imm:0x1, result rd:x14(0x00000800)
    li x14, MASK_XLEN(0x1000)
    c.srli x14, 0x1
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800)

    # Testcase 143:  rd:x15(0x00002000), imm:0x1, result rd:x15(0x00001000)
    li x15, MASK_XLEN(0x2000)
    c.srli x15, 0x1
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1000)

    # Testcase 144:  rd:x8(0x00004000), imm:0x1, result rd:x8(0x00002000)
    li x8, MASK_XLEN(0x4000)
    c.srli x8, 0x1
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res


    # Testcase 145:  rd:x9(0x00008000), imm:0x1, result rd:x9(0x00004000)
    li x9, MASK_XLEN(0x8000)
    c.srli x9, 0x1
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4000)

    # Testcase 146:  rd:x10(0x00010000), imm:0x1, result rd:x10(0x00008000)
    li x10, MASK_XLEN(0x10000)
    c.srli x10, 0x1
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000)

    # Testcase 147:  rd:x11(0x00020000), imm:0x1, result rd:x11(0x00010000)
    li x11, MASK_XLEN(0x20000)
    c.srli x11, 0x1
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x10000)

    # Testcase 148:  rd:x12(0x00040000), imm:0x1, result rd:x12(0x00020000)
    li x12, MASK_XLEN(0x40000)
    c.srli x12, 0x1
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20000)

    # Testcase 149:  rd:x13(0x00080000), imm:0x1, result rd:x13(0x00040000)
    li x13, MASK_XLEN(0x80000)
    c.srli x13, 0x1
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x40000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x1, test_31_res


    # Testcase 150:  rd:x14(0x00100000), imm:0x1, result rd:x14(0x00080000)
    li x14, MASK_XLEN(0x100000)
    c.srli x14, 0x1
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x80000)

    # Testcase 151:  rd:x15(0x00200000), imm:0x1, result rd:x15(0x00100000)
    li x15, MASK_XLEN(0x200000)
    c.srli x15, 0x1
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x100000)

    # Testcase 152:  rd:x8(0x00400000), imm:0x1, result rd:x8(0x00200000)
    li x8, MASK_XLEN(0x400000)
    c.srli x8, 0x1
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x200000)

    # Testcase 153:  rd:x9(0x00800000), imm:0x1, result rd:x9(0x00400000)
    li x9, MASK_XLEN(0x800000)
    c.srli x9, 0x1
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x400000)

    # Testcase 154:  rd:x10(0x01000000), imm:0x1, result rd:x10(0x00800000)
    li x10, MASK_XLEN(0x1000000)
    c.srli x10, 0x1
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x800000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x1, test_32_res


    # Testcase 155:  rd:x11(0x02000000), imm:0x1, result rd:x11(0x01000000)
    li x11, MASK_XLEN(0x2000000)
    c.srli x11, 0x1
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000000)

    # Testcase 156:  rd:x12(0x04000000), imm:0x1, result rd:x12(0x02000000)
    li x12, MASK_XLEN(0x4000000)
    c.srli x12, 0x1
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2000000)

    # Testcase 157:  rd:x13(0x08000000), imm:0x1, result rd:x13(0x04000000)
    li x13, MASK_XLEN(0x8000000)
    c.srli x13, 0x1
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4000000)

    # Testcase 158:  rd:x14(0x10000000), imm:0x1, result rd:x14(0x08000000)
    li x14, MASK_XLEN(0x10000000)
    c.srli x14, 0x1
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000000)

    # Testcase 159:  rd:x15(0x20000000), imm:0x1, result rd:x15(0x10000000)
    li x15, MASK_XLEN(0x20000000)
    c.srli x15, 0x1
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res


    # Testcase 160:  rd:x8(0x40000000), imm:0x1, result rd:x8(0x20000000)
    li x8, MASK_XLEN(0x40000000)
    c.srli x8, 0x1
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000000)

    # Testcase 161:  rd:x9(0x80000000), imm:0x1, result rd:x9(0x40000000)
    li x9, MASK_XLEN(0x80000000)
    c.srli x9, 0x1
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x40000000)

    # Testcase 162:  rd:x10(0x100000000), imm:0x1, result rd:x10(0x80000000)
    li x10, MASK_XLEN(0x100000000)
    c.srli x10, 0x1
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80000000)

    # Testcase 163:  rd:x11(0x200000000), imm:0x1, result rd:x11(0x100000000)
    li x11, MASK_XLEN(0x200000000)
    c.srli x11, 0x1
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x100000000)

    # Testcase 164:  rd:x12(0x400000000), imm:0x1, result rd:x12(0x200000000)
    li x12, MASK_XLEN(0x400000000)
    c.srli x12, 0x1
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res


    # Testcase 165:  rd:x13(0x800000000), imm:0x1, result rd:x13(0x400000000)
    li x13, MASK_XLEN(0x800000000)
    c.srli x13, 0x1
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400000000)

    # Testcase 166:  rd:x14(0x1000000000), imm:0x1, result rd:x14(0x800000000)
    li x14, MASK_XLEN(0x1000000000)
    c.srli x14, 0x1
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800000000)

    # Testcase 167:  rd:x15(0x2000000000), imm:0x1, result rd:x15(0x1000000000)
    li x15, MASK_XLEN(0x2000000000)
    c.srli x15, 0x1
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1000000000)

    # Testcase 168:  rd:x8(0x4000000000), imm:0x1, result rd:x8(0x2000000000)
    li x8, MASK_XLEN(0x4000000000)
    c.srli x8, 0x1
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000000000)

    # Testcase 169:  rd:x9(0x8000000000), imm:0x1, result rd:x9(0x4000000000)
    li x9, MASK_XLEN(0x8000000000)
    c.srli x9, 0x1
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x1, test_35_res


    # Testcase 170:  rd:x10(0x10000000000), imm:0x1, result rd:x10(0x8000000000)
    li x10, MASK_XLEN(0x10000000000)
    c.srli x10, 0x1
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000000000)

    # Testcase 171:  rd:x11(0x20000000000), imm:0x1, result rd:x11(0x10000000000)
    li x11, MASK_XLEN(0x20000000000)
    c.srli x11, 0x1
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x10000000000)

    # Testcase 172:  rd:x12(0x40000000000), imm:0x1, result rd:x12(0x20000000000)
    li x12, MASK_XLEN(0x40000000000)
    c.srli x12, 0x1
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20000000000)

    # Testcase 173:  rd:x13(0x80000000000), imm:0x1, result rd:x13(0x40000000000)
    li x13, MASK_XLEN(0x80000000000)
    c.srli x13, 0x1
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x40000000000)

    # Testcase 174:  rd:x14(0x100000000000), imm:0x1, result rd:x14(0x80000000000)
    li x14, MASK_XLEN(0x100000000000)
    c.srli x14, 0x1
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x80000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res


    # Testcase 175:  rd:x15(0x200000000000), imm:0x1, result rd:x15(0x100000000000)
    li x15, MASK_XLEN(0x200000000000)
    c.srli x15, 0x1
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x100000000000)

    # Testcase 176:  rd:x8(0x400000000000), imm:0x1, result rd:x8(0x200000000000)
    li x8, MASK_XLEN(0x400000000000)
    c.srli x8, 0x1
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x200000000000)

    # Testcase 177:  rd:x9(0x800000000000), imm:0x1, result rd:x9(0x400000000000)
    li x9, MASK_XLEN(0x800000000000)
    c.srli x9, 0x1
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x400000000000)

    # Testcase 178:  rd:x10(0x1000000000000), imm:0x1, result rd:x10(0x800000000000)
    li x10, MASK_XLEN(0x1000000000000)
    c.srli x10, 0x1
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x800000000000)

    # Testcase 179:  rd:x11(0x2000000000000), imm:0x1, result rd:x11(0x1000000000000)
    li x11, MASK_XLEN(0x2000000000000)
    c.srli x11, 0x1
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res


    # Testcase 180:  rd:x12(0x4000000000000), imm:0x1, result rd:x12(0x2000000000000)
    li x12, MASK_XLEN(0x4000000000000)
    c.srli x12, 0x1
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2000000000000)

    # Testcase 181:  rd:x13(0x8000000000000), imm:0x1, result rd:x13(0x4000000000000)
    li x13, MASK_XLEN(0x8000000000000)
    c.srli x13, 0x1
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4000000000000)

    # Testcase 182:  rd:x14(0x10000000000000), imm:0x1, result rd:x14(0x8000000000000)
    li x14, MASK_XLEN(0x10000000000000)
    c.srli x14, 0x1
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000000000000)

    # Testcase 183:  rd:x15(0x20000000000000), imm:0x1, result rd:x15(0x10000000000000)
    li x15, MASK_XLEN(0x20000000000000)
    c.srli x15, 0x1
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10000000000000)

    # Testcase 184:  rd:x8(0x40000000000000), imm:0x1, result rd:x8(0x20000000000000)
    li x8, MASK_XLEN(0x40000000000000)
    c.srli x8, 0x1
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x1, test_38_res


    # Testcase 185:  rd:x9(0x80000000000000), imm:0x1, result rd:x9(0x40000000000000)
    li x9, MASK_XLEN(0x80000000000000)
    c.srli x9, 0x1
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x40000000000000)

    # Testcase 186:  rd:x10(0x100000000000000), imm:0x1, result rd:x10(0x80000000000000)
    li x10, MASK_XLEN(0x100000000000000)
    c.srli x10, 0x1
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80000000000000)

    # Testcase 187:  rd:x11(0x200000000000000), imm:0x1, result rd:x11(0x100000000000000)
    li x11, MASK_XLEN(0x200000000000000)
    c.srli x11, 0x1
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x100000000000000)

    # Testcase 188:  rd:x12(0x400000000000000), imm:0x1, result rd:x12(0x200000000000000)
    li x12, MASK_XLEN(0x400000000000000)
    c.srli x12, 0x1
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200000000000000)

    # Testcase 189:  rd:x13(0x800000000000000), imm:0x1, result rd:x13(0x400000000000000)
    li x13, MASK_XLEN(0x800000000000000)
    c.srli x13, 0x1
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400000000000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res


    # Testcase 190:  rd:x14(0x1000000000000000), imm:0x1, result rd:x14(0x800000000000000)
    li x14, MASK_XLEN(0x1000000000000000)
    c.srli x14, 0x1
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800000000000000)

    # Testcase 191:  rd:x15(0x2000000000000000), imm:0x1, result rd:x15(0x1000000000000000)
    li x15, MASK_XLEN(0x2000000000000000)
    c.srli x15, 0x1
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1000000000000000)

    # Testcase 192:  rd:x8(0x4000000000000000), imm:0x1, result rd:x8(0x2000000000000000)
    li x8, MASK_XLEN(0x4000000000000000)
    c.srli x8, 0x1
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000000000000000)

    # Testcase 193:  rd:x9(0x8000000000000000), imm:0x1, result rd:x9(0x4000000000000000)
    li x9, MASK_XLEN(0x8000000000000000)
    c.srli x9, 0x1
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4000000000000000)

    # Testcase 194:  rd:x10(0x00000000), imm:0x1, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x0)
    c.srli x10, 0x1
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res


    # Testcase 195:  rd:x11(0xfffffffffffffffe), imm:0x1, result rd:x11(0x7fffffffffffffff)
    li x11, MASK_XLEN(0xfffffffffffffffe)
    c.srli x11, 0x1
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7fffffffffffffff)

    # Testcase 196:  rd:x12(0xfffffffffffffffd), imm:0x1, result rd:x12(0x7ffffffffffffffe)
    li x12, MASK_XLEN(0xfffffffffffffffd)
    c.srli x12, 0x1
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7ffffffffffffffe)

    # Testcase 197:  rd:x13(0xfffffffffffffffb), imm:0x1, result rd:x13(0x7ffffffffffffffd)
    li x13, MASK_XLEN(0xfffffffffffffffb)
    c.srli x13, 0x1
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7ffffffffffffffd)

    # Testcase 198:  rd:x14(0xfffffffffffffff7), imm:0x1, result rd:x14(0x7ffffffffffffffb)
    li x14, MASK_XLEN(0xfffffffffffffff7)
    c.srli x14, 0x1
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x7ffffffffffffffb)

    # Testcase 199:  rd:x15(0xffffffffffffffef), imm:0x1, result rd:x15(0x7ffffffffffffff7)
    li x15, MASK_XLEN(0xffffffffffffffef)
    c.srli x15, 0x1
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x7ffffffffffffff7)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x1, test_41_res


    # Testcase 200:  rd:x8(0xffffffffffffffdf), imm:0x1, result rd:x8(0x7fffffffffffffef)
    li x8, MASK_XLEN(0xffffffffffffffdf)
    c.srli x8, 0x1
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fffffffffffffef)

    # Testcase 201:  rd:x9(0xffffffffffffffbf), imm:0x1, result rd:x9(0x7fffffffffffffdf)
    li x9, MASK_XLEN(0xffffffffffffffbf)
    c.srli x9, 0x1
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x7fffffffffffffdf)

    # Testcase 202:  rd:x10(0xffffffffffffff7f), imm:0x1, result rd:x10(0x7fffffffffffffbf)
    li x10, MASK_XLEN(0xffffffffffffff7f)
    c.srli x10, 0x1
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7fffffffffffffbf)

    # Testcase 203:  rd:x11(0xfffffffffffffeff), imm:0x1, result rd:x11(0x7fffffffffffff7f)
    li x11, MASK_XLEN(0xfffffffffffffeff)
    c.srli x11, 0x1
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7fffffffffffff7f)

    # Testcase 204:  rd:x12(0xfffffffffffffdff), imm:0x1, result rd:x12(0x7ffffffffffffeff)
    li x12, MASK_XLEN(0xfffffffffffffdff)
    c.srli x12, 0x1
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7ffffffffffffeff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res


    # Testcase 205:  rd:x13(0xfffffffffffffbff), imm:0x1, result rd:x13(0x7ffffffffffffdff)
    li x13, MASK_XLEN(0xfffffffffffffbff)
    c.srli x13, 0x1
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7ffffffffffffdff)

    # Testcase 206:  rd:x14(0xfffffffffffff7ff), imm:0x1, result rd:x14(0x7ffffffffffffbff)
    li x14, MASK_XLEN(0xfffffffffffff7ff)
    c.srli x14, 0x1
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x7ffffffffffffbff)

    # Testcase 207:  rd:x15(0xffffffffffffefff), imm:0x1, result rd:x15(0x7ffffffffffff7ff)
    li x15, MASK_XLEN(0xffffffffffffefff)
    c.srli x15, 0x1
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x7ffffffffffff7ff)

    # Testcase 208:  rd:x8(0xffffffffffffdfff), imm:0x1, result rd:x8(0x7fffffffffffefff)
    li x8, MASK_XLEN(0xffffffffffffdfff)
    c.srli x8, 0x1
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fffffffffffefff)

    # Testcase 209:  rd:x9(0xffffffffffffbfff), imm:0x1, result rd:x9(0x7fffffffffffdfff)
    li x9, MASK_XLEN(0xffffffffffffbfff)
    c.srli x9, 0x1
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x7fffffffffffdfff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res


    # Testcase 210:  rd:x10(0xffffffffffff7fff), imm:0x1, result rd:x10(0x7fffffffffffbfff)
    li x10, MASK_XLEN(0xffffffffffff7fff)
    c.srli x10, 0x1
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7fffffffffffbfff)

    # Testcase 211:  rd:x11(0xfffffffffffeffff), imm:0x1, result rd:x11(0x7fffffffffff7fff)
    li x11, MASK_XLEN(0xfffffffffffeffff)
    c.srli x11, 0x1
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7fffffffffff7fff)

    # Testcase 212:  rd:x12(0xfffffffffffdffff), imm:0x1, result rd:x12(0x7ffffffffffeffff)
    li x12, MASK_XLEN(0xfffffffffffdffff)
    c.srli x12, 0x1
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7ffffffffffeffff)

    # Testcase 213:  rd:x13(0xfffffffffffbffff), imm:0x1, result rd:x13(0x7ffffffffffdffff)
    li x13, MASK_XLEN(0xfffffffffffbffff)
    c.srli x13, 0x1
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7ffffffffffdffff)

    # Testcase 214:  rd:x14(0xfffffffffff7ffff), imm:0x1, result rd:x14(0x7ffffffffffbffff)
    li x14, MASK_XLEN(0xfffffffffff7ffff)
    c.srli x14, 0x1
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x7ffffffffffbffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x1, test_44_res


    # Testcase 215:  rd:x15(0xffffffffffefffff), imm:0x1, result rd:x15(0x7ffffffffff7ffff)
    li x15, MASK_XLEN(0xffffffffffefffff)
    c.srli x15, 0x1
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x7ffffffffff7ffff)

    # Testcase 216:  rd:x8(0xffffffffffdfffff), imm:0x1, result rd:x8(0x7fffffffffefffff)
    li x8, MASK_XLEN(0xffffffffffdfffff)
    c.srli x8, 0x1
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fffffffffefffff)

    # Testcase 217:  rd:x9(0xffffffffffbfffff), imm:0x1, result rd:x9(0x7fffffffffdfffff)
    li x9, MASK_XLEN(0xffffffffffbfffff)
    c.srli x9, 0x1
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x7fffffffffdfffff)

    # Testcase 218:  rd:x10(0xffffffffff7fffff), imm:0x1, result rd:x10(0x7fffffffffbfffff)
    li x10, MASK_XLEN(0xffffffffff7fffff)
    c.srli x10, 0x1
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7fffffffffbfffff)

    # Testcase 219:  rd:x11(0xfffffffffeffffff), imm:0x1, result rd:x11(0x7fffffffff7fffff)
    li x11, MASK_XLEN(0xfffffffffeffffff)
    c.srli x11, 0x1
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7fffffffff7fffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res


    # Testcase 220:  rd:x12(0xfffffffffdffffff), imm:0x1, result rd:x12(0x7ffffffffeffffff)
    li x12, MASK_XLEN(0xfffffffffdffffff)
    c.srli x12, 0x1
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7ffffffffeffffff)

    # Testcase 221:  rd:x13(0xfffffffffbffffff), imm:0x1, result rd:x13(0x7ffffffffdffffff)
    li x13, MASK_XLEN(0xfffffffffbffffff)
    c.srli x13, 0x1
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7ffffffffdffffff)

    # Testcase 222:  rd:x14(0xfffffffff7ffffff), imm:0x1, result rd:x14(0x7ffffffffbffffff)
    li x14, MASK_XLEN(0xfffffffff7ffffff)
    c.srli x14, 0x1
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x7ffffffffbffffff)

    # Testcase 223:  rd:x15(0xffffffffefffffff), imm:0x1, result rd:x15(0x7ffffffff7ffffff)
    li x15, MASK_XLEN(0xffffffffefffffff)
    c.srli x15, 0x1
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x7ffffffff7ffffff)

    # Testcase 224:  rd:x8(0xffffffffdfffffff), imm:0x1, result rd:x8(0x7fffffffefffffff)
    li x8, MASK_XLEN(0xffffffffdfffffff)
    c.srli x8, 0x1
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fffffffefffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res


    # Testcase 225:  rd:x9(0xffffffffbfffffff), imm:0x1, result rd:x9(0x7fffffffdfffffff)
    li x9, MASK_XLEN(0xffffffffbfffffff)
    c.srli x9, 0x1
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x7fffffffdfffffff)

    # Testcase 226:  rd:x10(0xffffffff7fffffff), imm:0x1, result rd:x10(0x7fffffffbfffffff)
    li x10, MASK_XLEN(0xffffffff7fffffff)
    c.srli x10, 0x1
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7fffffffbfffffff)

    # Testcase 227:  rd:x11(0xfffffffeffffffff), imm:0x1, result rd:x11(0x7fffffff7fffffff)
    li x11, MASK_XLEN(0xfffffffeffffffff)
    c.srli x11, 0x1
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7fffffff7fffffff)

    # Testcase 228:  rd:x12(0xfffffffdffffffff), imm:0x1, result rd:x12(0x7ffffffeffffffff)
    li x12, MASK_XLEN(0xfffffffdffffffff)
    c.srli x12, 0x1
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7ffffffeffffffff)

    # Testcase 229:  rd:x13(0xfffffffbffffffff), imm:0x1, result rd:x13(0x7ffffffdffffffff)
    li x13, MASK_XLEN(0xfffffffbffffffff)
    c.srli x13, 0x1
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7ffffffdffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x1, test_47_res


    # Testcase 230:  rd:x14(0xfffffff7ffffffff), imm:0x1, result rd:x14(0x7ffffffbffffffff)
    li x14, MASK_XLEN(0xfffffff7ffffffff)
    c.srli x14, 0x1
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x7ffffffbffffffff)

    # Testcase 231:  rd:x15(0xffffffefffffffff), imm:0x1, result rd:x15(0x7ffffff7ffffffff)
    li x15, MASK_XLEN(0xffffffefffffffff)
    c.srli x15, 0x1
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x7ffffff7ffffffff)

    # Testcase 232:  rd:x8(0xffffffdfffffffff), imm:0x1, result rd:x8(0x7fffffefffffffff)
    li x8, MASK_XLEN(0xffffffdfffffffff)
    c.srli x8, 0x1
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fffffefffffffff)

    # Testcase 233:  rd:x9(0xffffffbfffffffff), imm:0x1, result rd:x9(0x7fffffdfffffffff)
    li x9, MASK_XLEN(0xffffffbfffffffff)
    c.srli x9, 0x1
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x7fffffdfffffffff)

    # Testcase 234:  rd:x10(0xffffff7fffffffff), imm:0x1, result rd:x10(0x7fffffbfffffffff)
    li x10, MASK_XLEN(0xffffff7fffffffff)
    c.srli x10, 0x1
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7fffffbfffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res


    # Testcase 235:  rd:x11(0xfffffeffffffffff), imm:0x1, result rd:x11(0x7fffff7fffffffff)
    li x11, MASK_XLEN(0xfffffeffffffffff)
    c.srli x11, 0x1
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7fffff7fffffffff)

    # Testcase 236:  rd:x12(0xfffffdffffffffff), imm:0x1, result rd:x12(0x7ffffeffffffffff)
    li x12, MASK_XLEN(0xfffffdffffffffff)
    c.srli x12, 0x1
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7ffffeffffffffff)

    # Testcase 237:  rd:x13(0xfffffbffffffffff), imm:0x1, result rd:x13(0x7ffffdffffffffff)
    li x13, MASK_XLEN(0xfffffbffffffffff)
    c.srli x13, 0x1
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7ffffdffffffffff)

    # Testcase 238:  rd:x14(0xfffff7ffffffffff), imm:0x1, result rd:x14(0x7ffffbffffffffff)
    li x14, MASK_XLEN(0xfffff7ffffffffff)
    c.srli x14, 0x1
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x7ffffbffffffffff)

    # Testcase 239:  rd:x15(0xffffefffffffffff), imm:0x1, result rd:x15(0x7ffff7ffffffffff)
    li x15, MASK_XLEN(0xffffefffffffffff)
    c.srli x15, 0x1
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x7ffff7ffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res


    # Testcase 240:  rd:x8(0xffffdfffffffffff), imm:0x1, result rd:x8(0x7fffefffffffffff)
    li x8, MASK_XLEN(0xffffdfffffffffff)
    c.srli x8, 0x1
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fffefffffffffff)

    # Testcase 241:  rd:x9(0xffffbfffffffffff), imm:0x1, result rd:x9(0x7fffdfffffffffff)
    li x9, MASK_XLEN(0xffffbfffffffffff)
    c.srli x9, 0x1
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x7fffdfffffffffff)

    # Testcase 242:  rd:x10(0xffff7fffffffffff), imm:0x1, result rd:x10(0x7fffbfffffffffff)
    li x10, MASK_XLEN(0xffff7fffffffffff)
    c.srli x10, 0x1
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7fffbfffffffffff)

    # Testcase 243:  rd:x11(0xfffeffffffffffff), imm:0x1, result rd:x11(0x7fff7fffffffffff)
    li x11, MASK_XLEN(0xfffeffffffffffff)
    c.srli x11, 0x1
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7fff7fffffffffff)

    # Testcase 244:  rd:x12(0xfffdffffffffffff), imm:0x1, result rd:x12(0x7ffeffffffffffff)
    li x12, MASK_XLEN(0xfffdffffffffffff)
    c.srli x12, 0x1
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7ffeffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x1, test_50_res


    # Testcase 245:  rd:x13(0xfffbffffffffffff), imm:0x1, result rd:x13(0x7ffdffffffffffff)
    li x13, MASK_XLEN(0xfffbffffffffffff)
    c.srli x13, 0x1
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7ffdffffffffffff)

    # Testcase 246:  rd:x14(0xfff7ffffffffffff), imm:0x1, result rd:x14(0x7ffbffffffffffff)
    li x14, MASK_XLEN(0xfff7ffffffffffff)
    c.srli x14, 0x1
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x7ffbffffffffffff)

    # Testcase 247:  rd:x15(0xffefffffffffffff), imm:0x1, result rd:x15(0x7ff7ffffffffffff)
    li x15, MASK_XLEN(0xffefffffffffffff)
    c.srli x15, 0x1
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x7ff7ffffffffffff)

    # Testcase 248:  rd:x8(0xffdfffffffffffff), imm:0x1, result rd:x8(0x7fefffffffffffff)
    li x8, MASK_XLEN(0xffdfffffffffffff)
    c.srli x8, 0x1
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fefffffffffffff)

    # Testcase 249:  rd:x9(0xffbfffffffffffff), imm:0x1, result rd:x9(0x7fdfffffffffffff)
    li x9, MASK_XLEN(0xffbfffffffffffff)
    c.srli x9, 0x1
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x7fdfffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res


    # Testcase 250:  rd:x10(0xff7fffffffffffff), imm:0x1, result rd:x10(0x7fbfffffffffffff)
    li x10, MASK_XLEN(0xff7fffffffffffff)
    c.srli x10, 0x1
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7fbfffffffffffff)

    # Testcase 251:  rd:x11(0xfeffffffffffffff), imm:0x1, result rd:x11(0x7f7fffffffffffff)
    li x11, MASK_XLEN(0xfeffffffffffffff)
    c.srli x11, 0x1
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7f7fffffffffffff)

    # Testcase 252:  rd:x12(0xfdffffffffffffff), imm:0x1, result rd:x12(0x7effffffffffffff)
    li x12, MASK_XLEN(0xfdffffffffffffff)
    c.srli x12, 0x1
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x7effffffffffffff)

    # Testcase 253:  rd:x13(0xfbffffffffffffff), imm:0x1, result rd:x13(0x7dffffffffffffff)
    li x13, MASK_XLEN(0xfbffffffffffffff)
    c.srli x13, 0x1
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7dffffffffffffff)

    # Testcase 254:  rd:x14(0xf7ffffffffffffff), imm:0x1, result rd:x14(0x7bffffffffffffff)
    li x14, MASK_XLEN(0xf7ffffffffffffff)
    c.srli x14, 0x1
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x7bffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res


    # Testcase 255:  rd:x15(0xefffffffffffffff), imm:0x1, result rd:x15(0x77ffffffffffffff)
    li x15, MASK_XLEN(0xefffffffffffffff)
    c.srli x15, 0x1
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x77ffffffffffffff)

    # Testcase 256:  rd:x8(0xdfffffffffffffff), imm:0x1, result rd:x8(0x6fffffffffffffff)
    li x8, MASK_XLEN(0xdfffffffffffffff)
    c.srli x8, 0x1
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x6fffffffffffffff)

    # Testcase 257:  rd:x9(0xbfffffffffffffff), imm:0x1, result rd:x9(0x5fffffffffffffff)
    li x9, MASK_XLEN(0xbfffffffffffffff)
    c.srli x9, 0x1
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x5fffffffffffffff)

    # Testcase 258:  rd:x10(0x7fffffffffffffff), imm:0x1, result rd:x10(0x3fffffffffffffff)
    li x10, MASK_XLEN(0x7fffffffffffffff)
    c.srli x10, 0x1
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x3fffffffffffffff)

    # Testcase 259:  rd:x11(0xffffffffffffffff), imm:0x1, result rd:x11(0x7fffffffffffffff)
    li x11, MASK_XLEN(0xffffffffffffffff)
    c.srli x11, 0x1
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7fffffffffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x1, test_53_res


    # Testcase 260:  rd:x12(0x00000001), imm:0x8, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1)
    c.srli x12, 0x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 261:  rd:x13(0x00000002), imm:0x4, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2)
    c.srli x13, 0x4
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 262:  rd:x14(0x00000004), imm:0x2, result rd:x14(0x00000001)
    li x14, MASK_XLEN(0x4)
    c.srli x14, 0x2
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x1)

    # Testcase 263:  rd:x15(0x00000008), imm:0x1, result rd:x15(0x00000004)
    li x15, MASK_XLEN(0x8)
    c.srli x15, 0x1
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

