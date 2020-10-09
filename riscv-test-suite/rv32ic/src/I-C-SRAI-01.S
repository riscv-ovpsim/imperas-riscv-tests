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

RV_COMPLIANCE_RV32M

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
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 1:  rd:x9(0x00000002), imm:0xf, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x2)
    c.srai x9, 0xf
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 2:  rd:x10(0x00000004), imm:0x17, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x4)
    c.srai x10, 0x17
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 3:  rd:x11(0x00000008), imm:0x1b, result rd:x11(0x00000000)
    li x11, MASK_XLEN(0x8)
    c.srai x11, 0x1b
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0)

    # Testcase 4:  rd:x12(0x00000010), imm:0x1d, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x10)
    c.srai x12, 0x1d
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res


    # Testcase 5:  rd:x13(0x00000020), imm:0x1e, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x20)
    c.srai x13, 0x1e
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 6:  rd:x14(0x00000040), imm:0x1, result rd:x14(0x00000020)
    li x14, MASK_XLEN(0x40)
    c.srai x14, 0x1
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x20)

    # Testcase 7:  rd:x15(0x00000080), imm:0x10, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x80)
    c.srai x15, 0x10
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 8:  rd:x8(0x00000100), imm:0x8, result rd:x8(0x00000001)
    li x8, MASK_XLEN(0x100)
    c.srai x8, 0x8
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1)

    # Testcase 9:  rd:x9(0x00000200), imm:0x4, result rd:x9(0x00000020)
    li x9, MASK_XLEN(0x200)
    c.srai x9, 0x4
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res


    # Testcase 10:  rd:x10(0x00000400), imm:0x2, result rd:x10(0x00000100)
    li x10, MASK_XLEN(0x400)
    c.srai x10, 0x2
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x100)

    # Testcase 11:  rd:x11(0x00000800), imm:0x1, result rd:x11(0x00000400)
    li x11, MASK_XLEN(0x800)
    c.srai x11, 0x1
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400)

    # Testcase 12:  rd:x12(0x00001000), imm:0x1f, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1000)
    c.srai x12, 0x1f
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 13:  rd:x13(0x00002000), imm:0xf, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2000)
    c.srai x13, 0xf
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 14:  rd:x14(0x00004000), imm:0x17, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x4000)
    c.srai x14, 0x17
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x1, test_4_res


    # Testcase 15:  rd:x15(0x00008000), imm:0x1b, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x8000)
    c.srai x15, 0x1b
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0)

    # Testcase 16:  rd:x8(0x00010000), imm:0x1d, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x10000)
    c.srai x8, 0x1d
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 17:  rd:x9(0x00020000), imm:0x1e, result rd:x9(0x00000000)
    li x9, MASK_XLEN(0x20000)
    c.srai x9, 0x1e
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0)

    # Testcase 18:  rd:x10(0x00040000), imm:0x1, result rd:x10(0x00020000)
    li x10, MASK_XLEN(0x40000)
    c.srai x10, 0x1
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x20000)

    # Testcase 19:  rd:x11(0x00080000), imm:0x10, result rd:x11(0x00000008)
    li x11, MASK_XLEN(0x80000)
    c.srai x11, 0x10
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res


    # Testcase 20:  rd:x12(0x00100000), imm:0x8, result rd:x12(0x00001000)
    li x12, MASK_XLEN(0x100000)
    c.srai x12, 0x8
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000)

    # Testcase 21:  rd:x13(0x00200000), imm:0x4, result rd:x13(0x00020000)
    li x13, MASK_XLEN(0x200000)
    c.srai x13, 0x4
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x20000)

    # Testcase 22:  rd:x14(0x00400000), imm:0x2, result rd:x14(0x00100000)
    li x14, MASK_XLEN(0x400000)
    c.srai x14, 0x2
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x100000)

    # Testcase 23:  rd:x15(0x00800000), imm:0x1, result rd:x15(0x00400000)
    li x15, MASK_XLEN(0x800000)
    c.srai x15, 0x1
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x400000)

    # Testcase 24:  rd:x8(0x01000000), imm:0x1f, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x1000000)
    c.srai x8, 0x1f
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res


    # Testcase 25:  rd:x9(0x02000000), imm:0xf, result rd:x9(0x00000400)
    li x9, MASK_XLEN(0x2000000)
    c.srai x9, 0xf
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x400)

    # Testcase 26:  rd:x10(0x04000000), imm:0x17, result rd:x10(0x00000008)
    li x10, MASK_XLEN(0x4000000)
    c.srai x10, 0x17
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8)

    # Testcase 27:  rd:x11(0x08000000), imm:0x1b, result rd:x11(0x00000001)
    li x11, MASK_XLEN(0x8000000)
    c.srai x11, 0x1b
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1)

    # Testcase 28:  rd:x12(0x10000000), imm:0x1d, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x10000000)
    c.srai x12, 0x1d
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 29:  rd:x13(0x20000000), imm:0x1e, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x20000000)
    c.srai x13, 0x1e
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x1, test_7_res


    # Testcase 30:  rd:x14(0x40000000), imm:0x1, result rd:x14(0x20000000)
    li x14, MASK_XLEN(0x40000000)
    c.srai x14, 0x1
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x20000000)

    # Testcase 31:  rd:x15(0x80000000), imm:0x10, result rd:x15(0xffff8000)
    li x15, MASK_XLEN(0x80000000)
    c.srai x15, 0x10
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffff8000)

    # Testcase 32:  rd:x8(0x00000000), imm:0x8, result rd:x8(0x00000000)
    li x8, MASK_XLEN(0x0)
    c.srai x8, 0x8
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0)

    # Testcase 33:  rd:x9(0xfffffffe), imm:0x4, result rd:x9(0xffffffff)
    li x9, MASK_XLEN(0xfffffffe)
    c.srai x9, 0x4
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffff)

    # Testcase 34:  rd:x10(0xfffffffd), imm:0x2, result rd:x10(0xffffffff)
    li x10, MASK_XLEN(0xfffffffd)
    c.srai x10, 0x2
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res


    # Testcase 35:  rd:x11(0xfffffffb), imm:0x1, result rd:x11(0xfffffffd)
    li x11, MASK_XLEN(0xfffffffb)
    c.srai x11, 0x1
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffd)

    # Testcase 36:  rd:x12(0xfffffff7), imm:0x1f, result rd:x12(0xffffffff)
    li x12, MASK_XLEN(0xfffffff7)
    c.srai x12, 0x1f
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffff)

    # Testcase 37:  rd:x13(0xffffffef), imm:0xf, result rd:x13(0xffffffff)
    li x13, MASK_XLEN(0xffffffef)
    c.srai x13, 0xf
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffff)

    # Testcase 38:  rd:x14(0xffffffdf), imm:0x17, result rd:x14(0xffffffff)
    li x14, MASK_XLEN(0xffffffdf)
    c.srai x14, 0x17
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffff)

    # Testcase 39:  rd:x15(0xffffffbf), imm:0x1b, result rd:x15(0xffffffff)
    li x15, MASK_XLEN(0xffffffbf)
    c.srai x15, 0x1b
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res


    # Testcase 40:  rd:x8(0xffffff7f), imm:0x1d, result rd:x8(0xffffffff)
    li x8, MASK_XLEN(0xffffff7f)
    c.srai x8, 0x1d
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffff)

    # Testcase 41:  rd:x9(0xfffffeff), imm:0x1e, result rd:x9(0xffffffff)
    li x9, MASK_XLEN(0xfffffeff)
    c.srai x9, 0x1e
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffff)

    # Testcase 42:  rd:x10(0xfffffdff), imm:0x1, result rd:x10(0xfffffeff)
    li x10, MASK_XLEN(0xfffffdff)
    c.srai x10, 0x1
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffeff)

    # Testcase 43:  rd:x11(0xfffffbff), imm:0x10, result rd:x11(0xffffffff)
    li x11, MASK_XLEN(0xfffffbff)
    c.srai x11, 0x10
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffff)

    # Testcase 44:  rd:x12(0xfffff7ff), imm:0x8, result rd:x12(0xfffffff7)
    li x12, MASK_XLEN(0xfffff7ff)
    c.srai x12, 0x8
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffff7)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x1, test_10_res


    # Testcase 45:  rd:x13(0xffffefff), imm:0x4, result rd:x13(0xfffffeff)
    li x13, MASK_XLEN(0xffffefff)
    c.srai x13, 0x4
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffeff)

    # Testcase 46:  rd:x14(0xffffdfff), imm:0x2, result rd:x14(0xfffff7ff)
    li x14, MASK_XLEN(0xffffdfff)
    c.srai x14, 0x2
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffff7ff)

    # Testcase 47:  rd:x15(0xffffbfff), imm:0x1, result rd:x15(0xffffdfff)
    li x15, MASK_XLEN(0xffffbfff)
    c.srai x15, 0x1
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffdfff)

    # Testcase 48:  rd:x8(0xffff7fff), imm:0x1f, result rd:x8(0xffffffff)
    li x8, MASK_XLEN(0xffff7fff)
    c.srai x8, 0x1f
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffff)

    # Testcase 49:  rd:x9(0xfffeffff), imm:0xf, result rd:x9(0xfffffffd)
    li x9, MASK_XLEN(0xfffeffff)
    c.srai x9, 0xf
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffd)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res


    # Testcase 50:  rd:x10(0xfffdffff), imm:0x17, result rd:x10(0xffffffff)
    li x10, MASK_XLEN(0xfffdffff)
    c.srai x10, 0x17
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffff)

    # Testcase 51:  rd:x11(0xfffbffff), imm:0x1b, result rd:x11(0xffffffff)
    li x11, MASK_XLEN(0xfffbffff)
    c.srai x11, 0x1b
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffff)

    # Testcase 52:  rd:x12(0xfff7ffff), imm:0x1d, result rd:x12(0xffffffff)
    li x12, MASK_XLEN(0xfff7ffff)
    c.srai x12, 0x1d
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffff)

    # Testcase 53:  rd:x13(0xffefffff), imm:0x1e, result rd:x13(0xffffffff)
    li x13, MASK_XLEN(0xffefffff)
    c.srai x13, 0x1e
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffff)

    # Testcase 54:  rd:x14(0xffdfffff), imm:0x1, result rd:x14(0xffefffff)
    li x14, MASK_XLEN(0xffdfffff)
    c.srai x14, 0x1
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffefffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res


    # Testcase 55:  rd:x15(0xffbfffff), imm:0x10, result rd:x15(0xffffffbf)
    li x15, MASK_XLEN(0xffbfffff)
    c.srai x15, 0x10
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffbf)

    # Testcase 56:  rd:x8(0xff7fffff), imm:0x8, result rd:x8(0xffff7fff)
    li x8, MASK_XLEN(0xff7fffff)
    c.srai x8, 0x8
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffff7fff)

    # Testcase 57:  rd:x9(0xfeffffff), imm:0x4, result rd:x9(0xffefffff)
    li x9, MASK_XLEN(0xfeffffff)
    c.srai x9, 0x4
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffefffff)

    # Testcase 58:  rd:x10(0xfdffffff), imm:0x2, result rd:x10(0xff7fffff)
    li x10, MASK_XLEN(0xfdffffff)
    c.srai x10, 0x2
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xff7fffff)

    # Testcase 59:  rd:x11(0xfbffffff), imm:0x1, result rd:x11(0xfdffffff)
    li x11, MASK_XLEN(0xfbffffff)
    c.srai x11, 0x1
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfdffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x1, test_13_res


    # Testcase 60:  rd:x12(0xf7ffffff), imm:0x1f, result rd:x12(0xffffffff)
    li x12, MASK_XLEN(0xf7ffffff)
    c.srai x12, 0x1f
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffff)

    # Testcase 61:  rd:x13(0xefffffff), imm:0xf, result rd:x13(0xffffdfff)
    li x13, MASK_XLEN(0xefffffff)
    c.srai x13, 0xf
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffdfff)

    # Testcase 62:  rd:x14(0xdfffffff), imm:0x17, result rd:x14(0xffffffbf)
    li x14, MASK_XLEN(0xdfffffff)
    c.srai x14, 0x17
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffbf)

    # Testcase 63:  rd:x15(0xbfffffff), imm:0x1b, result rd:x15(0xfffffff7)
    li x15, MASK_XLEN(0xbfffffff)
    c.srai x15, 0x1b
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffff7)

    # Testcase 64:  rd:x8(0x7fffffff), imm:0x1d, result rd:x8(0x00000003)
    li x8, MASK_XLEN(0x7fffffff)
    c.srai x8, 0x1d
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x3)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res


    # Testcase 65:  rd:x9(0xffffffff), imm:0x1e, result rd:x9(0xffffffff)
    li x9, MASK_XLEN(0xffffffff)
    c.srai x9, 0x1e
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffff)

    # Testcase 66:  rd:x10(0x00000001), imm:0x1, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x1)
    c.srai x10, 0x1
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 67:  rd:x11(0x00000002), imm:0x1, result rd:x11(0x00000001)
    li x11, MASK_XLEN(0x2)
    c.srai x11, 0x1
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1)

    # Testcase 68:  rd:x12(0x00000004), imm:0x1, result rd:x12(0x00000002)
    li x12, MASK_XLEN(0x4)
    c.srai x12, 0x1
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2)

    # Testcase 69:  rd:x13(0x00000008), imm:0x1, result rd:x13(0x00000004)
    li x13, MASK_XLEN(0x8)
    c.srai x13, 0x1
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res


    # Testcase 70:  rd:x14(0x00000010), imm:0x1, result rd:x14(0x00000008)
    li x14, MASK_XLEN(0x10)
    c.srai x14, 0x1
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8)

    # Testcase 71:  rd:x15(0x00000020), imm:0x1, result rd:x15(0x00000010)
    li x15, MASK_XLEN(0x20)
    c.srai x15, 0x1
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10)

    # Testcase 72:  rd:x8(0x00000040), imm:0x1, result rd:x8(0x00000020)
    li x8, MASK_XLEN(0x40)
    c.srai x8, 0x1
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20)

    # Testcase 73:  rd:x9(0x00000080), imm:0x1, result rd:x9(0x00000040)
    li x9, MASK_XLEN(0x80)
    c.srai x9, 0x1
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x40)

    # Testcase 74:  rd:x10(0x00000100), imm:0x1, result rd:x10(0x00000080)
    li x10, MASK_XLEN(0x100)
    c.srai x10, 0x1
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x1, test_16_res


    # Testcase 75:  rd:x11(0x00000200), imm:0x1, result rd:x11(0x00000100)
    li x11, MASK_XLEN(0x200)
    c.srai x11, 0x1
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x100)

    # Testcase 76:  rd:x12(0x00000400), imm:0x1, result rd:x12(0x00000200)
    li x12, MASK_XLEN(0x400)
    c.srai x12, 0x1
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200)

    # Testcase 77:  rd:x13(0x00000800), imm:0x1, result rd:x13(0x00000400)
    li x13, MASK_XLEN(0x800)
    c.srai x13, 0x1
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400)

    # Testcase 78:  rd:x14(0x00001000), imm:0x1, result rd:x14(0x00000800)
    li x14, MASK_XLEN(0x1000)
    c.srai x14, 0x1
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800)

    # Testcase 79:  rd:x15(0x00002000), imm:0x1, result rd:x15(0x00001000)
    li x15, MASK_XLEN(0x2000)
    c.srai x15, 0x1
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x1000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res


    # Testcase 80:  rd:x8(0x00004000), imm:0x1, result rd:x8(0x00002000)
    li x8, MASK_XLEN(0x4000)
    c.srai x8, 0x1
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000)

    # Testcase 81:  rd:x9(0x00008000), imm:0x1, result rd:x9(0x00004000)
    li x9, MASK_XLEN(0x8000)
    c.srai x9, 0x1
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4000)

    # Testcase 82:  rd:x10(0x00010000), imm:0x1, result rd:x10(0x00008000)
    li x10, MASK_XLEN(0x10000)
    c.srai x10, 0x1
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000)

    # Testcase 83:  rd:x11(0x00020000), imm:0x1, result rd:x11(0x00010000)
    li x11, MASK_XLEN(0x20000)
    c.srai x11, 0x1
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x10000)

    # Testcase 84:  rd:x12(0x00040000), imm:0x1, result rd:x12(0x00020000)
    li x12, MASK_XLEN(0x40000)
    c.srai x12, 0x1
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res


    # Testcase 85:  rd:x13(0x00080000), imm:0x1, result rd:x13(0x00040000)
    li x13, MASK_XLEN(0x80000)
    c.srai x13, 0x1
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x40000)

    # Testcase 86:  rd:x14(0x00100000), imm:0x1, result rd:x14(0x00080000)
    li x14, MASK_XLEN(0x100000)
    c.srai x14, 0x1
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x80000)

    # Testcase 87:  rd:x15(0x00200000), imm:0x1, result rd:x15(0x00100000)
    li x15, MASK_XLEN(0x200000)
    c.srai x15, 0x1
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x100000)

    # Testcase 88:  rd:x8(0x00400000), imm:0x1, result rd:x8(0x00200000)
    li x8, MASK_XLEN(0x400000)
    c.srai x8, 0x1
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x200000)

    # Testcase 89:  rd:x9(0x00800000), imm:0x1, result rd:x9(0x00400000)
    li x9, MASK_XLEN(0x800000)
    c.srai x9, 0x1
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x400000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x1, test_19_res


    # Testcase 90:  rd:x10(0x01000000), imm:0x1, result rd:x10(0x00800000)
    li x10, MASK_XLEN(0x1000000)
    c.srai x10, 0x1
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x800000)

    # Testcase 91:  rd:x11(0x02000000), imm:0x1, result rd:x11(0x01000000)
    li x11, MASK_XLEN(0x2000000)
    c.srai x11, 0x1
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000000)

    # Testcase 92:  rd:x12(0x04000000), imm:0x1, result rd:x12(0x02000000)
    li x12, MASK_XLEN(0x4000000)
    c.srai x12, 0x1
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2000000)

    # Testcase 93:  rd:x13(0x08000000), imm:0x1, result rd:x13(0x04000000)
    li x13, MASK_XLEN(0x8000000)
    c.srai x13, 0x1
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x4000000)

    # Testcase 94:  rd:x14(0x10000000), imm:0x1, result rd:x14(0x08000000)
    li x14, MASK_XLEN(0x10000000)
    c.srai x14, 0x1
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000000)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res


    # Testcase 95:  rd:x15(0x20000000), imm:0x1, result rd:x15(0x10000000)
    li x15, MASK_XLEN(0x20000000)
    c.srai x15, 0x1
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x10000000)

    # Testcase 96:  rd:x8(0x40000000), imm:0x1, result rd:x8(0x20000000)
    li x8, MASK_XLEN(0x40000000)
    c.srai x8, 0x1
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000000)

    # Testcase 97:  rd:x9(0x80000000), imm:0x1, result rd:x9(0xc0000000)
    li x9, MASK_XLEN(0x80000000)
    c.srai x9, 0x1
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xc0000000)

    # Testcase 98:  rd:x10(0x00000000), imm:0x1, result rd:x10(0x00000000)
    li x10, MASK_XLEN(0x0)
    c.srai x10, 0x1
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0)

    # Testcase 99:  rd:x11(0xfffffffe), imm:0x1, result rd:x11(0xffffffff)
    li x11, MASK_XLEN(0xfffffffe)
    c.srai x11, 0x1
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res


    # Testcase 100:  rd:x12(0xfffffffd), imm:0x1, result rd:x12(0xfffffffe)
    li x12, MASK_XLEN(0xfffffffd)
    c.srai x12, 0x1
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffe)

    # Testcase 101:  rd:x13(0xfffffffb), imm:0x1, result rd:x13(0xfffffffd)
    li x13, MASK_XLEN(0xfffffffb)
    c.srai x13, 0x1
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffd)

    # Testcase 102:  rd:x14(0xfffffff7), imm:0x1, result rd:x14(0xfffffffb)
    li x14, MASK_XLEN(0xfffffff7)
    c.srai x14, 0x1
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffffb)

    # Testcase 103:  rd:x15(0xffffffef), imm:0x1, result rd:x15(0xfffffff7)
    li x15, MASK_XLEN(0xffffffef)
    c.srai x15, 0x1
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffff7)

    # Testcase 104:  rd:x8(0xffffffdf), imm:0x1, result rd:x8(0xffffffef)
    li x8, MASK_XLEN(0xffffffdf)
    c.srai x8, 0x1
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffef)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x1, test_22_res


    # Testcase 105:  rd:x9(0xffffffbf), imm:0x1, result rd:x9(0xffffffdf)
    li x9, MASK_XLEN(0xffffffbf)
    c.srai x9, 0x1
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffdf)

    # Testcase 106:  rd:x10(0xffffff7f), imm:0x1, result rd:x10(0xffffffbf)
    li x10, MASK_XLEN(0xffffff7f)
    c.srai x10, 0x1
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffbf)

    # Testcase 107:  rd:x11(0xfffffeff), imm:0x1, result rd:x11(0xffffff7f)
    li x11, MASK_XLEN(0xfffffeff)
    c.srai x11, 0x1
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffff7f)

    # Testcase 108:  rd:x12(0xfffffdff), imm:0x1, result rd:x12(0xfffffeff)
    li x12, MASK_XLEN(0xfffffdff)
    c.srai x12, 0x1
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffeff)

    # Testcase 109:  rd:x13(0xfffffbff), imm:0x1, result rd:x13(0xfffffdff)
    li x13, MASK_XLEN(0xfffffbff)
    c.srai x13, 0x1
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffdff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res


    # Testcase 110:  rd:x14(0xfffff7ff), imm:0x1, result rd:x14(0xfffffbff)
    li x14, MASK_XLEN(0xfffff7ff)
    c.srai x14, 0x1
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffbff)

    # Testcase 111:  rd:x15(0xffffefff), imm:0x1, result rd:x15(0xfffff7ff)
    li x15, MASK_XLEN(0xffffefff)
    c.srai x15, 0x1
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffff7ff)

    # Testcase 112:  rd:x8(0xffffdfff), imm:0x1, result rd:x8(0xffffefff)
    li x8, MASK_XLEN(0xffffdfff)
    c.srai x8, 0x1
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffefff)

    # Testcase 113:  rd:x9(0xffffbfff), imm:0x1, result rd:x9(0xffffdfff)
    li x9, MASK_XLEN(0xffffbfff)
    c.srai x9, 0x1
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffdfff)

    # Testcase 114:  rd:x10(0xffff7fff), imm:0x1, result rd:x10(0xffffbfff)
    li x10, MASK_XLEN(0xffff7fff)
    c.srai x10, 0x1
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffbfff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res


    # Testcase 115:  rd:x11(0xfffeffff), imm:0x1, result rd:x11(0xffff7fff)
    li x11, MASK_XLEN(0xfffeffff)
    c.srai x11, 0x1
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffff7fff)

    # Testcase 116:  rd:x12(0xfffdffff), imm:0x1, result rd:x12(0xfffeffff)
    li x12, MASK_XLEN(0xfffdffff)
    c.srai x12, 0x1
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffeffff)

    # Testcase 117:  rd:x13(0xfffbffff), imm:0x1, result rd:x13(0xfffdffff)
    li x13, MASK_XLEN(0xfffbffff)
    c.srai x13, 0x1
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffdffff)

    # Testcase 118:  rd:x14(0xfff7ffff), imm:0x1, result rd:x14(0xfffbffff)
    li x14, MASK_XLEN(0xfff7ffff)
    c.srai x14, 0x1
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffbffff)

    # Testcase 119:  rd:x15(0xffefffff), imm:0x1, result rd:x15(0xfff7ffff)
    li x15, MASK_XLEN(0xffefffff)
    c.srai x15, 0x1
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfff7ffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x1, test_25_res


    # Testcase 120:  rd:x8(0xffdfffff), imm:0x1, result rd:x8(0xffefffff)
    li x8, MASK_XLEN(0xffdfffff)
    c.srai x8, 0x1
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffefffff)

    # Testcase 121:  rd:x9(0xffbfffff), imm:0x1, result rd:x9(0xffdfffff)
    li x9, MASK_XLEN(0xffbfffff)
    c.srai x9, 0x1
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffdfffff)

    # Testcase 122:  rd:x10(0xff7fffff), imm:0x1, result rd:x10(0xffbfffff)
    li x10, MASK_XLEN(0xff7fffff)
    c.srai x10, 0x1
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffbfffff)

    # Testcase 123:  rd:x11(0xfeffffff), imm:0x1, result rd:x11(0xff7fffff)
    li x11, MASK_XLEN(0xfeffffff)
    c.srai x11, 0x1
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xff7fffff)

    # Testcase 124:  rd:x12(0xfdffffff), imm:0x1, result rd:x12(0xfeffffff)
    li x12, MASK_XLEN(0xfdffffff)
    c.srai x12, 0x1
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfeffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res


    # Testcase 125:  rd:x13(0xfbffffff), imm:0x1, result rd:x13(0xfdffffff)
    li x13, MASK_XLEN(0xfbffffff)
    c.srai x13, 0x1
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfdffffff)

    # Testcase 126:  rd:x14(0xf7ffffff), imm:0x1, result rd:x14(0xfbffffff)
    li x14, MASK_XLEN(0xf7ffffff)
    c.srai x14, 0x1
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfbffffff)

    # Testcase 127:  rd:x15(0xefffffff), imm:0x1, result rd:x15(0xf7ffffff)
    li x15, MASK_XLEN(0xefffffff)
    c.srai x15, 0x1
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xf7ffffff)

    # Testcase 128:  rd:x8(0xdfffffff), imm:0x1, result rd:x8(0xefffffff)
    li x8, MASK_XLEN(0xdfffffff)
    c.srai x8, 0x1
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xefffffff)

    # Testcase 129:  rd:x9(0xbfffffff), imm:0x1, result rd:x9(0xdfffffff)
    li x9, MASK_XLEN(0xbfffffff)
    c.srai x9, 0x1
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xdfffffff)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res


    # Testcase 130:  rd:x10(0x7fffffff), imm:0x1, result rd:x10(0x3fffffff)
    li x10, MASK_XLEN(0x7fffffff)
    c.srai x10, 0x1
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x3fffffff)

    # Testcase 131:  rd:x11(0xffffffff), imm:0x1, result rd:x11(0xffffffff)
    li x11, MASK_XLEN(0xffffffff)
    c.srai x11, 0x1
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffff)

    # Testcase 132:  rd:x12(0x00000001), imm:0x1f, result rd:x12(0x00000000)
    li x12, MASK_XLEN(0x1)
    c.srai x12, 0x1f
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0)

    # Testcase 133:  rd:x13(0x00000002), imm:0xf, result rd:x13(0x00000000)
    li x13, MASK_XLEN(0x2)
    c.srai x13, 0xf
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0)

    # Testcase 134:  rd:x14(0x00000004), imm:0x17, result rd:x14(0x00000000)
    li x14, MASK_XLEN(0x4)
    c.srai x14, 0x17
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0)


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res


    # Testcase 135:  rd:x15(0x00000008), imm:0x1b, result rd:x15(0x00000000)
    li x15, MASK_XLEN(0x8)
    c.srai x15, 0x1b
    sw x15, 0(x1)
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

