# RISC-V Compliance Test I-AUIPC-01
#
    #
    # Copyright (c) 2005-2021 Imperas Software Ltd., www.imperas.com
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
# Specification: RV32I Base Integer Instruction Set, Version 2.1
# Description: Testing instruction 'AUIPC'.

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

    # Testcase 0:  imm:0xbcc23, result rd:x1(0xbcc23000)
1: 
    auipc x1, 0xbcc23
    la x8, 1b
    sub  x1,  x1, x8
    sw  x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xbcc23000)

    # Testcase 1:  imm:0xd105b, result rd:x2(0xd105b000)
1: 
    auipc x2, 0xd105b
    la x8, 1b
    sub  x2,  x2, x8
    sw  x2, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xd105b000)

    # Testcase 2:  imm:0xaf2c0, result rd:x3(0xaf2c0000)
1: 
    auipc x3, 0xaf2c0
    la x8, 1b
    sub  x3,  x3, x8
    sw  x3, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xaf2c0000)

    # Testcase 3:  imm:0xbfbc3, result rd:x4(0xbfbc3000)
1: 
    auipc x4, 0xbfbc3
    la x8, 1b
    sub  x4,  x4, x8
    sw  x4, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xbfbc3000)

    # Testcase 4:  imm:0xa10af, result rd:x5(0xa10af000)
1: 
    auipc x5, 0xa10af
    la x8, 1b
    sub  x5,  x5, x8
    sw  x5, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xa10af000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res

    # Testcase 5:  imm:0xd524f, result rd:x6(0xd524f000)
1: 
    auipc x6, 0xd524f
    la x3, 1b
    sub  x6,  x6, x3
    sw  x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xd524f000)

    # Testcase 6:  imm:0x99fcb, result rd:x7(0x99fcb000)
1: 
    auipc x7, 0x99fcb
    la x3, 1b
    sub  x7,  x7, x3
    sw  x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x99fcb000)

    # Testcase 7:  imm:0x1a8bb, result rd:x8(0x1a8bb000)
1: 
    auipc x8, 0x1a8bb
    la x3, 1b
    sub  x8,  x8, x3
    sw  x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1a8bb000)

    # Testcase 8:  imm:0xfbec1, result rd:x9(0xfbec1000)
1: 
    auipc x9, 0xfbec1
    la x3, 1b
    sub  x9,  x9, x3
    sw  x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfbec1000)

    # Testcase 9:  imm:0xa5195, result rd:x10(0xa5195000)
1: 
    auipc x10, 0xa5195
    la x3, 1b
    sub  x10,  x10, x3
    sw  x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xa5195000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res

    # Testcase 10:  imm:0xfffff, result rd:x11(0xfffff000)
1: 
    auipc x11, 0xfffff
    la x8, 1b
    sub  x11,  x11, x8
    sw  x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0xfffff000)

    # Testcase 11:  imm:0x7ffff, result rd:x12(0x7ffff000)
1: 
    auipc x12, 0x7ffff
    la x8, 1b
    sub  x12,  x12, x8
    sw  x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x7ffff000)

    # Testcase 12:  imm:0xbffff, result rd:x13(0xbffff000)
1: 
    auipc x13, 0xbffff
    la x8, 1b
    sub  x13,  x13, x8
    sw  x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0xbffff000)

    # Testcase 13:  imm:0xdffff, result rd:x14(0xdffff000)
1: 
    auipc x14, 0xdffff
    la x8, 1b
    sub  x14,  x14, x8
    sw  x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xdffff000)

    # Testcase 14:  imm:0xeffff, result rd:x15(0xeffff000)
1: 
    auipc x15, 0xeffff
    la x8, 1b
    sub  x15,  x15, x8
    sw  x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0xeffff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res

    # Testcase 15:  imm:0xf7fff, result rd:x16(0xf7fff000)
1: 
    auipc x16, 0xf7fff
    la x4, 1b
    sub  x16,  x16, x4
    sw  x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0xf7fff000)

    # Testcase 16:  imm:0xfbfff, result rd:x17(0xfbfff000)
1: 
    auipc x17, 0xfbfff
    la x4, 1b
    sub  x17,  x17, x4
    sw  x17, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0xfbfff000)

    # Testcase 17:  imm:0xfdfff, result rd:x18(0xfdfff000)
1: 
    auipc x18, 0xfdfff
    la x4, 1b
    sub  x18,  x18, x4
    sw  x18, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0xfdfff000)

    # Testcase 18:  imm:0xfefff, result rd:x19(0xfefff000)
1: 
    auipc x19, 0xfefff
    la x4, 1b
    sub  x19,  x19, x4
    sw  x19, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0xfefff000)

    # Testcase 19:  imm:0xff7ff, result rd:x20(0xff7ff000)
1: 
    auipc x20, 0xff7ff
    la x4, 1b
    sub  x20,  x20, x4
    sw  x20, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0xff7ff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res

    # Testcase 20:  imm:0xffbff, result rd:x21(0xffbff000)
1: 
    auipc x21, 0xffbff
    la x3, 1b
    sub  x21,  x21, x3
    sw  x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffbff000)

    # Testcase 21:  imm:0xffdff, result rd:x22(0xffdff000)
1: 
    auipc x22, 0xffdff
    la x3, 1b
    sub  x22,  x22, x3
    sw  x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffdff000)

    # Testcase 22:  imm:0xffeff, result rd:x23(0xffeff000)
1: 
    auipc x23, 0xffeff
    la x3, 1b
    sub  x23,  x23, x3
    sw  x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffeff000)

    # Testcase 23:  imm:0xfff7f, result rd:x24(0xfff7f000)
1: 
    auipc x24, 0xfff7f
    la x3, 1b
    sub  x24,  x24, x3
    sw  x24, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xfff7f000)

    # Testcase 24:  imm:0xfffbf, result rd:x25(0xfffbf000)
1: 
    auipc x25, 0xfffbf
    la x3, 1b
    sub  x25,  x25, x3
    sw  x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffbf000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res

    # Testcase 25:  imm:0xfffdf, result rd:x26(0xfffdf000)
1: 
    auipc x26, 0xfffdf
    la x8, 1b
    sub  x26,  x26, x8
    sw  x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0xfffdf000)

    # Testcase 26:  imm:0xfffef, result rd:x27(0xfffef000)
1: 
    auipc x27, 0xfffef
    la x8, 1b
    sub  x27,  x27, x8
    sw  x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0xfffef000)

    # Testcase 27:  imm:0xffff7, result rd:x28(0xffff7000)
1: 
    auipc x28, 0xffff7
    la x8, 1b
    sub  x28,  x28, x8
    sw  x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0xffff7000)

    # Testcase 28:  imm:0xffffb, result rd:x29(0xffffb000)
1: 
    auipc x29, 0xffffb
    la x8, 1b
    sub  x29,  x29, x8
    sw  x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0xffffb000)

    # Testcase 29:  imm:0xffffd, result rd:x30(0xffffd000)
1: 
    auipc x30, 0xffffd
    la x8, 1b
    sub  x30,  x30, x8
    sw  x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0xffffd000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res

    # Testcase 30:  imm:0xffffe, result rd:x31(0xffffe000)
1: 
    auipc x31, 0xffffe
    la x7, 1b
    sub  x31,  x31, x7
    sw  x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xffffe000)

    # Testcase 31:  imm:0x0, result rd:x1(0x0)
1: 
    auipc x1, 0x0
    la x7, 1b
    sub  x1,  x1, x7
    sw  x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0)

    # Testcase 32:  imm:0x80000, result rd:x2(0x80000000)
1: 
    auipc x2, 0x80000
    la x7, 1b
    sub  x2,  x2, x7
    sw  x2, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x80000000)

    # Testcase 33:  imm:0x40000, result rd:x3(0x40000000)
1: 
    auipc x3, 0x40000
    la x7, 1b
    sub  x3,  x3, x7
    sw  x3, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x40000000)

    # Testcase 34:  imm:0x20000, result rd:x4(0x20000000)
1: 
    auipc x4, 0x20000
    la x7, 1b
    sub  x4,  x4, x7
    sw  x4, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x20000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res

    # Testcase 35:  imm:0x10000, result rd:x5(0x10000000)
1: 
    auipc x5, 0x10000
    la x3, 1b
    sub  x5,  x5, x3
    sw  x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x10000000)

    # Testcase 36:  imm:0x8000, result rd:x6(0x8000000)
1: 
    auipc x6, 0x8000
    la x3, 1b
    sub  x6,  x6, x3
    sw  x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x8000000)

    # Testcase 37:  imm:0x4000, result rd:x7(0x4000000)
1: 
    auipc x7, 0x4000
    la x3, 1b
    sub  x7,  x7, x3
    sw  x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x4000000)

    # Testcase 38:  imm:0x2000, result rd:x8(0x2000000)
1: 
    auipc x8, 0x2000
    la x3, 1b
    sub  x8,  x8, x3
    sw  x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000000)

    # Testcase 39:  imm:0x1000, result rd:x9(0x1000000)
1: 
    auipc x9, 0x1000
    la x3, 1b
    sub  x9,  x9, x3
    sw  x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res

    # Testcase 40:  imm:0x800, result rd:x10(0x800000)
1: 
    auipc x10, 0x800
    la x8, 1b
    sub  x10,  x10, x8
    sw  x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x800000)

    # Testcase 41:  imm:0x400, result rd:x11(0x400000)
1: 
    auipc x11, 0x400
    la x8, 1b
    sub  x11,  x11, x8
    sw  x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400000)

    # Testcase 42:  imm:0x200, result rd:x12(0x200000)
1: 
    auipc x12, 0x200
    la x8, 1b
    sub  x12,  x12, x8
    sw  x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200000)

    # Testcase 43:  imm:0x100, result rd:x13(0x100000)
1: 
    auipc x13, 0x100
    la x8, 1b
    sub  x13,  x13, x8
    sw  x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x100000)

    # Testcase 44:  imm:0x80, result rd:x14(0x80000)
1: 
    auipc x14, 0x80
    la x8, 1b
    sub  x14,  x14, x8
    sw  x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x80000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res

    # Testcase 45:  imm:0x40, result rd:x15(0x40000)
1: 
    auipc x15, 0x40
    la x5, 1b
    sub  x15,  x15, x5
    sw  x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x40000)

    # Testcase 46:  imm:0x20, result rd:x16(0x20000)
1: 
    auipc x16, 0x20
    la x5, 1b
    sub  x16,  x16, x5
    sw  x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x20000)

    # Testcase 47:  imm:0x10, result rd:x17(0x10000)
1: 
    auipc x17, 0x10
    la x5, 1b
    sub  x17,  x17, x5
    sw  x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x10000)

    # Testcase 48:  imm:0x8, result rd:x18(0x8000)
1: 
    auipc x18, 0x8
    la x5, 1b
    sub  x18,  x18, x5
    sw  x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x8000)

    # Testcase 49:  imm:0x4, result rd:x19(0x4000)
1: 
    auipc x19, 0x4
    la x5, 1b
    sub  x19,  x19, x5
    sw  x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x4000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res

    # Testcase 50:  imm:0x2, result rd:x20(0x2000)
1: 
    auipc x20, 0x2
    la x3, 1b
    sub  x20,  x20, x3
    sw  x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x2000)

    # Testcase 51:  imm:0x1, result rd:x21(0x1000)
1: 
    auipc x21, 0x1
    la x3, 1b
    sub  x21,  x21, x3
    sw  x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x1000)

    # Testcase 52:  imm:0xbcc23, result rd:x22(0xbcc23000)
1: 
    auipc x22, 0xbcc23
    la x3, 1b
    sub  x22,  x22, x3
    sw  x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xbcc23000)

    # Testcase 53:  imm:0xd105b, result rd:x23(0xd105b000)
1: 
    auipc x23, 0xd105b
    la x3, 1b
    sub  x23,  x23, x3
    sw  x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xd105b000)

    # Testcase 54:  imm:0xaf2c0, result rd:x24(0xaf2c0000)
1: 
    auipc x24, 0xaf2c0
    la x3, 1b
    sub  x24,  x24, x3
    sw  x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xaf2c0000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res

    # Testcase 55:  imm:0xbfbc3, result rd:x25(0xbfbc3000)
1: 
    auipc x25, 0xbfbc3
    la x8, 1b
    sub  x25,  x25, x8
    sw  x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xbfbc3000)

    # Testcase 56:  imm:0xa10af, result rd:x26(0xa10af000)
1: 
    auipc x26, 0xa10af
    la x8, 1b
    sub  x26,  x26, x8
    sw  x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xa10af000)

    # Testcase 57:  imm:0xd524f, result rd:x27(0xd524f000)
1: 
    auipc x27, 0xd524f
    la x8, 1b
    sub  x27,  x27, x8
    sw  x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xd524f000)

    # Testcase 58:  imm:0x99fcb, result rd:x28(0x99fcb000)
1: 
    auipc x28, 0x99fcb
    la x8, 1b
    sub  x28,  x28, x8
    sw  x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x99fcb000)

    # Testcase 59:  imm:0x1a8bb, result rd:x29(0x1a8bb000)
1: 
    auipc x29, 0x1a8bb
    la x8, 1b
    sub  x29,  x29, x8
    sw  x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x1a8bb000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res

    # Testcase 60:  imm:0xfbec1, result rd:x30(0xfbec1000)
1: 
    auipc x30, 0xfbec1
    la x6, 1b
    sub  x30,  x30, x6
    sw  x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfbec1000)

    # Testcase 61:  imm:0xa5195, result rd:x31(0xa5195000)
1: 
    auipc x31, 0xa5195
    la x6, 1b
    sub  x31,  x31, x6
    sw  x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xa5195000)

    # Testcase 62:  imm:0xfffff, result rd:x1(0xfffff000)
1: 
    auipc x1, 0xfffff
    la x6, 1b
    sub  x1,  x1, x6
    sw  x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xfffff000)

    # Testcase 63:  imm:0x7ffff, result rd:x2(0x7ffff000)
1: 
    auipc x2, 0x7ffff
    la x6, 1b
    sub  x2,  x2, x6
    sw  x2, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x7ffff000)

    # Testcase 64:  imm:0xbffff, result rd:x3(0xbffff000)
1: 
    auipc x3, 0xbffff
    la x6, 1b
    sub  x3,  x3, x6
    sw  x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xbffff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res

    # Testcase 65:  imm:0xdffff, result rd:x4(0xdffff000)
1: 
    auipc x4, 0xdffff
    la x3, 1b
    sub  x4,  x4, x3
    sw  x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xdffff000)

    # Testcase 66:  imm:0xeffff, result rd:x5(0xeffff000)
1: 
    auipc x5, 0xeffff
    la x3, 1b
    sub  x5,  x5, x3
    sw  x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xeffff000)

    # Testcase 67:  imm:0xf7fff, result rd:x6(0xf7fff000)
1: 
    auipc x6, 0xf7fff
    la x3, 1b
    sub  x6,  x6, x3
    sw  x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xf7fff000)

    # Testcase 68:  imm:0xfbfff, result rd:x7(0xfbfff000)
1: 
    auipc x7, 0xfbfff
    la x3, 1b
    sub  x7,  x7, x3
    sw  x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfbfff000)

    # Testcase 69:  imm:0xfdfff, result rd:x8(0xfdfff000)
1: 
    auipc x8, 0xfdfff
    la x3, 1b
    sub  x8,  x8, x3
    sw  x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfdfff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res

    # Testcase 70:  imm:0xfefff, result rd:x9(0xfefff000)
1: 
    auipc x9, 0xfefff
    la x3, 1b
    sub  x9,  x9, x3
    sw  x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfefff000)

    # Testcase 71:  imm:0xff7ff, result rd:x10(0xff7ff000)
1: 
    auipc x10, 0xff7ff
    la x3, 1b
    sub  x10,  x10, x3
    sw  x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xff7ff000)

    # Testcase 72:  imm:0xffbff, result rd:x11(0xffbff000)
1: 
    auipc x11, 0xffbff
    la x3, 1b
    sub  x11,  x11, x3
    sw  x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffbff000)

    # Testcase 73:  imm:0xffdff, result rd:x12(0xffdff000)
1: 
    auipc x12, 0xffdff
    la x3, 1b
    sub  x12,  x12, x3
    sw  x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffdff000)

    # Testcase 74:  imm:0xffeff, result rd:x13(0xffeff000)
1: 
    auipc x13, 0xffeff
    la x3, 1b
    sub  x13,  x13, x3
    sw  x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffeff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res

    # Testcase 75:  imm:0xfff7f, result rd:x14(0xfff7f000)
1: 
    auipc x14, 0xfff7f
    la x6, 1b
    sub  x14,  x14, x6
    sw  x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xfff7f000)

    # Testcase 76:  imm:0xfffbf, result rd:x15(0xfffbf000)
1: 
    auipc x15, 0xfffbf
    la x6, 1b
    sub  x15,  x15, x6
    sw  x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xfffbf000)

    # Testcase 77:  imm:0xfffdf, result rd:x16(0xfffdf000)
1: 
    auipc x16, 0xfffdf
    la x6, 1b
    sub  x16,  x16, x6
    sw  x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xfffdf000)

    # Testcase 78:  imm:0xfffef, result rd:x17(0xfffef000)
1: 
    auipc x17, 0xfffef
    la x6, 1b
    sub  x17,  x17, x6
    sw  x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xfffef000)

    # Testcase 79:  imm:0xffff7, result rd:x18(0xffff7000)
1: 
    auipc x18, 0xffff7
    la x6, 1b
    sub  x18,  x18, x6
    sw  x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xffff7000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res

    # Testcase 80:  imm:0xffffb, result rd:x19(0xffffb000)
1: 
    auipc x19, 0xffffb
    la x3, 1b
    sub  x19,  x19, x3
    sw  x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xffffb000)

    # Testcase 81:  imm:0xffffd, result rd:x20(0xffffd000)
1: 
    auipc x20, 0xffffd
    la x3, 1b
    sub  x20,  x20, x3
    sw  x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffffd000)

    # Testcase 82:  imm:0xffffe, result rd:x21(0xffffe000)
1: 
    auipc x21, 0xffffe
    la x3, 1b
    sub  x21,  x21, x3
    sw  x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffe000)

    # Testcase 83:  imm:0x0, result rd:x22(0x0)
1: 
    auipc x22, 0x0
    la x3, 1b
    sub  x22,  x22, x3
    sw  x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0)

    # Testcase 84:  imm:0x80000, result rd:x23(0x80000000)
1: 
    auipc x23, 0x80000
    la x3, 1b
    sub  x23,  x23, x3
    sw  x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x80000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res

    # Testcase 85:  imm:0x40000, result rd:x24(0x40000000)
1: 
    auipc x24, 0x40000
    la x3, 1b
    sub  x24,  x24, x3
    sw  x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x40000000)

    # Testcase 86:  imm:0x20000, result rd:x25(0x20000000)
1: 
    auipc x25, 0x20000
    la x3, 1b
    sub  x25,  x25, x3
    sw  x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x20000000)

    # Testcase 87:  imm:0x10000, result rd:x26(0x10000000)
1: 
    auipc x26, 0x10000
    la x3, 1b
    sub  x26,  x26, x3
    sw  x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x10000000)

    # Testcase 88:  imm:0x8000, result rd:x27(0x8000000)
1: 
    auipc x27, 0x8000
    la x3, 1b
    sub  x27,  x27, x3
    sw  x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x8000000)

    # Testcase 89:  imm:0x4000, result rd:x28(0x4000000)
1: 
    auipc x28, 0x4000
    la x3, 1b
    sub  x28,  x28, x3
    sw  x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x4000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res

    # Testcase 90:  imm:0x2000, result rd:x29(0x2000000)
1: 
    auipc x29, 0x2000
    la x6, 1b
    sub  x29,  x29, x6
    sw  x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x2000000)

    # Testcase 91:  imm:0x1000, result rd:x30(0x1000000)
1: 
    auipc x30, 0x1000
    la x6, 1b
    sub  x30,  x30, x6
    sw  x30, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x1000000)

    # Testcase 92:  imm:0x800, result rd:x31(0x800000)
1: 
    auipc x31, 0x800
    la x6, 1b
    sub  x31,  x31, x6
    sw  x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x800000)

    # Testcase 93:  imm:0x400, result rd:x1(0x400000)
1: 
    auipc x1, 0x400
    la x6, 1b
    sub  x1,  x1, x6
    sw  x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x400000)

    # Testcase 94:  imm:0x200, result rd:x2(0x200000)
1: 
    auipc x2, 0x200
    la x6, 1b
    sub  x2,  x2, x6
    sw  x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x200000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res

    # Testcase 95:  imm:0x100, result rd:x3(0x100000)
1: 
    auipc x3, 0x100
    la x8, 1b
    sub  x3,  x3, x8
    sw  x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x100000)

    # Testcase 96:  imm:0x80, result rd:x4(0x80000)
1: 
    auipc x4, 0x80
    la x8, 1b
    sub  x4,  x4, x8
    sw  x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x80000)

    # Testcase 97:  imm:0x40, result rd:x5(0x40000)
1: 
    auipc x5, 0x40
    la x8, 1b
    sub  x5,  x5, x8
    sw  x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x40000)

    # Testcase 98:  imm:0x20, result rd:x6(0x20000)
1: 
    auipc x6, 0x20
    la x8, 1b
    sub  x6,  x6, x8
    sw  x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x20000)

    # Testcase 99:  imm:0x10, result rd:x7(0x10000)
1: 
    auipc x7, 0x10
    la x8, 1b
    sub  x7,  x7, x8
    sw  x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x10000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res

    # Testcase 100:  imm:0x8, result rd:x8(0x8000)
1: 
    auipc x8, 0x8
    la x3, 1b
    sub  x8,  x8, x3
    sw  x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8000)

    # Testcase 101:  imm:0x4, result rd:x9(0x4000)
1: 
    auipc x9, 0x4
    la x3, 1b
    sub  x9,  x9, x3
    sw  x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4000)

    # Testcase 102:  imm:0x2, result rd:x10(0x2000)
1: 
    auipc x10, 0x2
    la x3, 1b
    sub  x10,  x10, x3
    sw  x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x2000)

    # Testcase 103:  imm:0x1, result rd:x11(0x1000)
1: 
    auipc x11, 0x1
    la x3, 1b
    sub  x11,  x11, x3
    sw  x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000)

    # Testcase 104:  imm:0xbcc23, result rd:x12(0xbcc23000)
1: 
    auipc x12, 0xbcc23
    la x3, 1b
    sub  x12,  x12, x3
    sw  x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xbcc23000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res

    # Testcase 105:  imm:0xd105b, result rd:x13(0xd105b000)
1: 
    auipc x13, 0xd105b
    la x7, 1b
    sub  x13,  x13, x7
    sw  x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0xd105b000)

    # Testcase 106:  imm:0xaf2c0, result rd:x14(0xaf2c0000)
1: 
    auipc x14, 0xaf2c0
    la x7, 1b
    sub  x14,  x14, x7
    sw  x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xaf2c0000)

    # Testcase 107:  imm:0xbfbc3, result rd:x15(0xbfbc3000)
1: 
    auipc x15, 0xbfbc3
    la x7, 1b
    sub  x15,  x15, x7
    sw  x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xbfbc3000)

    # Testcase 108:  imm:0xa10af, result rd:x16(0xa10af000)
1: 
    auipc x16, 0xa10af
    la x7, 1b
    sub  x16,  x16, x7
    sw  x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xa10af000)

    # Testcase 109:  imm:0xd524f, result rd:x17(0xd524f000)
1: 
    auipc x17, 0xd524f
    la x7, 1b
    sub  x17,  x17, x7
    sw  x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xd524f000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res

    # Testcase 110:  imm:0x99fcb, result rd:x18(0x99fcb000)
1: 
    auipc x18, 0x99fcb
    la x3, 1b
    sub  x18,  x18, x3
    sw  x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x99fcb000)

    # Testcase 111:  imm:0x1a8bb, result rd:x19(0x1a8bb000)
1: 
    auipc x19, 0x1a8bb
    la x3, 1b
    sub  x19,  x19, x3
    sw  x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x1a8bb000)

    # Testcase 112:  imm:0xfbec1, result rd:x20(0xfbec1000)
1: 
    auipc x20, 0xfbec1
    la x3, 1b
    sub  x20,  x20, x3
    sw  x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfbec1000)

    # Testcase 113:  imm:0xa5195, result rd:x21(0xa5195000)
1: 
    auipc x21, 0xa5195
    la x3, 1b
    sub  x21,  x21, x3
    sw  x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xa5195000)

    # Testcase 114:  imm:0xfffff, result rd:x22(0xfffff000)
1: 
    auipc x22, 0xfffff
    la x3, 1b
    sub  x22,  x22, x3
    sw  x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res

    # Testcase 115:  imm:0x7ffff, result rd:x23(0x7ffff000)
1: 
    auipc x23, 0x7ffff
    la x3, 1b
    sub  x23,  x23, x3
    sw  x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x7ffff000)

    # Testcase 116:  imm:0xbffff, result rd:x24(0xbffff000)
1: 
    auipc x24, 0xbffff
    la x3, 1b
    sub  x24,  x24, x3
    sw  x24, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xbffff000)

    # Testcase 117:  imm:0xdffff, result rd:x25(0xdffff000)
1: 
    auipc x25, 0xdffff
    la x3, 1b
    sub  x25,  x25, x3
    sw  x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xdffff000)

    # Testcase 118:  imm:0xeffff, result rd:x26(0xeffff000)
1: 
    auipc x26, 0xeffff
    la x3, 1b
    sub  x26,  x26, x3
    sw  x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xeffff000)

    # Testcase 119:  imm:0xf7fff, result rd:x27(0xf7fff000)
1: 
    auipc x27, 0xf7fff
    la x3, 1b
    sub  x27,  x27, x3
    sw  x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xf7fff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res

    # Testcase 120:  imm:0xfbfff, result rd:x28(0xfbfff000)
1: 
    auipc x28, 0xfbfff
    la x7, 1b
    sub  x28,  x28, x7
    sw  x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0xfbfff000)

    # Testcase 121:  imm:0xfdfff, result rd:x29(0xfdfff000)
1: 
    auipc x29, 0xfdfff
    la x7, 1b
    sub  x29,  x29, x7
    sw  x29, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0xfdfff000)

    # Testcase 122:  imm:0xfefff, result rd:x30(0xfefff000)
1: 
    auipc x30, 0xfefff
    la x7, 1b
    sub  x30,  x30, x7
    sw  x30, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0xfefff000)

    # Testcase 123:  imm:0xff7ff, result rd:x31(0xff7ff000)
1: 
    auipc x31, 0xff7ff
    la x7, 1b
    sub  x31,  x31, x7
    sw  x31, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xff7ff000)

    # Testcase 124:  imm:0xffbff, result rd:x1(0xffbff000)
1: 
    auipc x1, 0xffbff
    la x7, 1b
    sub  x1,  x1, x7
    sw  x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xffbff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res

    # Testcase 125:  imm:0xffdff, result rd:x2(0xffdff000)
1: 
    auipc x2, 0xffdff
    la x8, 1b
    sub  x2,  x2, x8
    sw  x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xffdff000)

    # Testcase 126:  imm:0xffeff, result rd:x3(0xffeff000)
1: 
    auipc x3, 0xffeff
    la x8, 1b
    sub  x3,  x3, x8
    sw  x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xffeff000)

    # Testcase 127:  imm:0xfff7f, result rd:x4(0xfff7f000)
1: 
    auipc x4, 0xfff7f
    la x8, 1b
    sub  x4,  x4, x8
    sw  x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xfff7f000)

    # Testcase 128:  imm:0xfffbf, result rd:x5(0xfffbf000)
1: 
    auipc x5, 0xfffbf
    la x8, 1b
    sub  x5,  x5, x8
    sw  x5, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xfffbf000)

    # Testcase 129:  imm:0xfffdf, result rd:x6(0xfffdf000)
1: 
    auipc x6, 0xfffdf
    la x8, 1b
    sub  x6,  x6, x8
    sw  x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0xfffdf000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res

    # Testcase 130:  imm:0xfffef, result rd:x7(0xfffef000)
1: 
    auipc x7, 0xfffef
    la x3, 1b
    sub  x7,  x7, x3
    sw  x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffef000)

    # Testcase 131:  imm:0xffff7, result rd:x8(0xffff7000)
1: 
    auipc x8, 0xffff7
    la x3, 1b
    sub  x8,  x8, x3
    sw  x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffff7000)

    # Testcase 132:  imm:0xffffb, result rd:x9(0xffffb000)
1: 
    auipc x9, 0xffffb
    la x3, 1b
    sub  x9,  x9, x3
    sw  x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffb000)

    # Testcase 133:  imm:0xffffd, result rd:x10(0xffffd000)
1: 
    auipc x10, 0xffffd
    la x3, 1b
    sub  x10,  x10, x3
    sw  x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffd000)

    # Testcase 134:  imm:0xffffe, result rd:x11(0xffffe000)
1: 
    auipc x11, 0xffffe
    la x3, 1b
    sub  x11,  x11, x3
    sw  x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffe000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res

    # Testcase 135:  imm:0x0, result rd:x12(0x0)
1: 
    auipc x12, 0x0
    la x8, 1b
    sub  x12,  x12, x8
    sw  x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x0)

    # Testcase 136:  imm:0x80000, result rd:x13(0x80000000)
1: 
    auipc x13, 0x80000
    la x8, 1b
    sub  x13,  x13, x8
    sw  x13, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x80000000)

    # Testcase 137:  imm:0x40000, result rd:x14(0x40000000)
1: 
    auipc x14, 0x40000
    la x8, 1b
    sub  x14,  x14, x8
    sw  x14, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x40000000)

    # Testcase 138:  imm:0x20000, result rd:x15(0x20000000)
1: 
    auipc x15, 0x20000
    la x8, 1b
    sub  x15,  x15, x8
    sw  x15, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x20000000)

    # Testcase 139:  imm:0x10000, result rd:x16(0x10000000)
1: 
    auipc x16, 0x10000
    la x8, 1b
    sub  x16,  x16, x8
    sw  x16, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x10000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res

    # Testcase 140:  imm:0x8000, result rd:x17(0x8000000)
1: 
    auipc x17, 0x8000
    la x3, 1b
    sub  x17,  x17, x3
    sw  x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x17, 0x8000000)

    # Testcase 141:  imm:0x4000, result rd:x18(0x4000000)
1: 
    auipc x18, 0x4000
    la x3, 1b
    sub  x18,  x18, x3
    sw  x18, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x4000000)

    # Testcase 142:  imm:0x2000, result rd:x19(0x2000000)
1: 
    auipc x19, 0x2000
    la x3, 1b
    sub  x19,  x19, x3
    sw  x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x2000000)

    # Testcase 143:  imm:0x1000, result rd:x20(0x1000000)
1: 
    auipc x20, 0x1000
    la x3, 1b
    sub  x20,  x20, x3
    sw  x20, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x1000000)

    # Testcase 144:  imm:0x800, result rd:x21(0x800000)
1: 
    auipc x21, 0x800
    la x3, 1b
    sub  x21,  x21, x3
    sw  x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x800000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res

    # Testcase 145:  imm:0x400, result rd:x22(0x400000)
1: 
    auipc x22, 0x400
    la x3, 1b
    sub  x22,  x22, x3
    sw  x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x400000)



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
test_29_res:
	.fill 5, 4, -1
test_30_res:
	.fill 5, 4, -1

RV_COMPLIANCE_DATA_END

