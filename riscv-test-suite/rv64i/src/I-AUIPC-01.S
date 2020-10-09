# RISC-V Compliance Test I-AUIPC-01
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
# Specification: RV64I Base Integer Instruction Set, Version 2.1
# Description: Testing instruction 'AUIPC'.

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

    # Testcase 0:  imm:0xfffff, result rd:x1(0xfffffffffffff000)
1: 
    auipc x1, 0xfffff
    la x8, 1b
    sub  x1,  x1, x8
    sd  x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xfffffffffffff000)

    # Testcase 1:  imm:0x7ffff, result rd:x2(0x7ffff000)
1: 
    auipc x2, 0x7ffff
    la x8, 1b
    sub  x2,  x2, x8
    sd  x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x7ffff000)

    # Testcase 2:  imm:0xbffff, result rd:x3(0xffffffffbffff000)
1: 
    auipc x3, 0xbffff
    la x8, 1b
    sub  x3,  x3, x8
    sd  x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xffffffffbffff000)

    # Testcase 3:  imm:0xdffff, result rd:x4(0xffffffffdffff000)
1: 
    auipc x4, 0xdffff
    la x8, 1b
    sub  x4,  x4, x8
    sd  x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xffffffffdffff000)

    # Testcase 4:  imm:0xeffff, result rd:x5(0xffffffffeffff000)
1: 
    auipc x5, 0xeffff
    la x8, 1b
    sub  x5,  x5, x8
    sd  x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xffffffffeffff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res

    # Testcase 5:  imm:0xf7fff, result rd:x6(0xfffffffff7fff000)
1: 
    auipc x6, 0xf7fff
    la x3, 1b
    sub  x6,  x6, x3
    sd  x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfffffffff7fff000)

    # Testcase 6:  imm:0xfbfff, result rd:x7(0xfffffffffbfff000)
1: 
    auipc x7, 0xfbfff
    la x3, 1b
    sub  x7,  x7, x3
    sd  x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffffbfff000)

    # Testcase 7:  imm:0xfdfff, result rd:x8(0xfffffffffdfff000)
1: 
    auipc x8, 0xfdfff
    la x3, 1b
    sub  x8,  x8, x3
    sd  x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffdfff000)

    # Testcase 8:  imm:0xfefff, result rd:x9(0xfffffffffefff000)
1: 
    auipc x9, 0xfefff
    la x3, 1b
    sub  x9,  x9, x3
    sd  x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffffefff000)

    # Testcase 9:  imm:0xff7ff, result rd:x10(0xffffffffff7ff000)
1: 
    auipc x10, 0xff7ff
    la x3, 1b
    sub  x10,  x10, x3
    sd  x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffff7ff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res

    # Testcase 10:  imm:0xffbff, result rd:x11(0xffffffffffbff000)
1: 
    auipc x11, 0xffbff
    la x8, 1b
    sub  x11,  x11, x8
    sd  x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0xffffffffffbff000)

    # Testcase 11:  imm:0xffdff, result rd:x12(0xffffffffffdff000)
1: 
    auipc x12, 0xffdff
    la x8, 1b
    sub  x12,  x12, x8
    sd  x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0xffffffffffdff000)

    # Testcase 12:  imm:0xffeff, result rd:x13(0xffffffffffeff000)
1: 
    auipc x13, 0xffeff
    la x8, 1b
    sub  x13,  x13, x8
    sd  x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0xffffffffffeff000)

    # Testcase 13:  imm:0xfff7f, result rd:x14(0xfffffffffff7f000)
1: 
    auipc x14, 0xfff7f
    la x8, 1b
    sub  x14,  x14, x8
    sd  x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xfffffffffff7f000)

    # Testcase 14:  imm:0xfffbf, result rd:x15(0xfffffffffffbf000)
1: 
    auipc x15, 0xfffbf
    la x8, 1b
    sub  x15,  x15, x8
    sd  x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0xfffffffffffbf000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res

    # Testcase 15:  imm:0xfffdf, result rd:x16(0xfffffffffffdf000)
1: 
    auipc x16, 0xfffdf
    la x4, 1b
    sub  x16,  x16, x4
    sd  x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0xfffffffffffdf000)

    # Testcase 16:  imm:0xfffef, result rd:x17(0xfffffffffffef000)
1: 
    auipc x17, 0xfffef
    la x4, 1b
    sub  x17,  x17, x4
    sd  x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0xfffffffffffef000)

    # Testcase 17:  imm:0xffff7, result rd:x18(0xffffffffffff7000)
1: 
    auipc x18, 0xffff7
    la x4, 1b
    sub  x18,  x18, x4
    sd  x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0xffffffffffff7000)

    # Testcase 18:  imm:0xffffb, result rd:x19(0xffffffffffffb000)
1: 
    auipc x19, 0xffffb
    la x4, 1b
    sub  x19,  x19, x4
    sd  x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0xffffffffffffb000)

    # Testcase 19:  imm:0xffffd, result rd:x20(0xffffffffffffd000)
1: 
    auipc x20, 0xffffd
    la x4, 1b
    sub  x20,  x20, x4
    sd  x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0xffffffffffffd000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res

    # Testcase 20:  imm:0xffffe, result rd:x21(0xffffffffffffe000)
1: 
    auipc x21, 0xffffe
    la x3, 1b
    sub  x21,  x21, x3
    sd  x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffffffffffe000)

    # Testcase 21:  imm:0x0, result rd:x22(0x0)
1: 
    auipc x22, 0x0
    la x3, 1b
    sub  x22,  x22, x3
    sd  x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0)

    # Testcase 22:  imm:0x80000, result rd:x23(0xffffffff80000000)
1: 
    auipc x23, 0x80000
    la x3, 1b
    sub  x23,  x23, x3
    sd  x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffffff80000000)

    # Testcase 23:  imm:0x40000, result rd:x24(0x40000000)
1: 
    auipc x24, 0x40000
    la x3, 1b
    sub  x24,  x24, x3
    sd  x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x40000000)

    # Testcase 24:  imm:0x20000, result rd:x25(0x20000000)
1: 
    auipc x25, 0x20000
    la x3, 1b
    sub  x25,  x25, x3
    sd  x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x20000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res

    # Testcase 25:  imm:0x10000, result rd:x26(0x10000000)
1: 
    auipc x26, 0x10000
    la x8, 1b
    sub  x26,  x26, x8
    sd  x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x10000000)

    # Testcase 26:  imm:0x8000, result rd:x27(0x8000000)
1: 
    auipc x27, 0x8000
    la x8, 1b
    sub  x27,  x27, x8
    sd  x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x8000000)

    # Testcase 27:  imm:0x4000, result rd:x28(0x4000000)
1: 
    auipc x28, 0x4000
    la x8, 1b
    sub  x28,  x28, x8
    sd  x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x4000000)

    # Testcase 28:  imm:0x2000, result rd:x29(0x2000000)
1: 
    auipc x29, 0x2000
    la x8, 1b
    sub  x29,  x29, x8
    sd  x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x2000000)

    # Testcase 29:  imm:0x1000, result rd:x30(0x1000000)
1: 
    auipc x30, 0x1000
    la x8, 1b
    sub  x30,  x30, x8
    sd  x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x1000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res

    # Testcase 30:  imm:0x800, result rd:x31(0x800000)
1: 
    auipc x31, 0x800
    la x7, 1b
    sub  x31,  x31, x7
    sd  x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x800000)

    # Testcase 31:  imm:0x400, result rd:x1(0x400000)
1: 
    auipc x1, 0x400
    la x7, 1b
    sub  x1,  x1, x7
    sd  x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x400000)

    # Testcase 32:  imm:0x200, result rd:x2(0x200000)
1: 
    auipc x2, 0x200
    la x7, 1b
    sub  x2,  x2, x7
    sd  x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x200000)

    # Testcase 33:  imm:0x100, result rd:x3(0x100000)
1: 
    auipc x3, 0x100
    la x7, 1b
    sub  x3,  x3, x7
    sd  x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x100000)

    # Testcase 34:  imm:0x80, result rd:x4(0x80000)
1: 
    auipc x4, 0x80
    la x7, 1b
    sub  x4,  x4, x7
    sd  x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x80000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res

    # Testcase 35:  imm:0x40, result rd:x5(0x40000)
1: 
    auipc x5, 0x40
    la x3, 1b
    sub  x5,  x5, x3
    sd  x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x40000)

    # Testcase 36:  imm:0x20, result rd:x6(0x20000)
1: 
    auipc x6, 0x20
    la x3, 1b
    sub  x6,  x6, x3
    sd  x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x20000)

    # Testcase 37:  imm:0x10, result rd:x7(0x10000)
1: 
    auipc x7, 0x10
    la x3, 1b
    sub  x7,  x7, x3
    sd  x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x10000)

    # Testcase 38:  imm:0x8, result rd:x8(0x8000)
1: 
    auipc x8, 0x8
    la x3, 1b
    sub  x8,  x8, x3
    sd  x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8000)

    # Testcase 39:  imm:0x4, result rd:x9(0x4000)
1: 
    auipc x9, 0x4
    la x3, 1b
    sub  x9,  x9, x3
    sd  x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res

    # Testcase 40:  imm:0x2, result rd:x10(0x2000)
1: 
    auipc x10, 0x2
    la x8, 1b
    sub  x10,  x10, x8
    sd  x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x2000)

    # Testcase 41:  imm:0x1, result rd:x11(0x1000)
1: 
    auipc x11, 0x1
    la x8, 1b
    sub  x11,  x11, x8
    sd  x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000)

    # Testcase 42:  imm:0xfffff, result rd:x12(0xfffffffffffff000)
1: 
    auipc x12, 0xfffff
    la x8, 1b
    sub  x12,  x12, x8
    sd  x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffffff000)

    # Testcase 43:  imm:0x7ffff, result rd:x13(0x7ffff000)
1: 
    auipc x13, 0x7ffff
    la x8, 1b
    sub  x13,  x13, x8
    sd  x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7ffff000)

    # Testcase 44:  imm:0xbffff, result rd:x14(0xffffffffbffff000)
1: 
    auipc x14, 0xbffff
    la x8, 1b
    sub  x14,  x14, x8
    sd  x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffffbffff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res

    # Testcase 45:  imm:0xdffff, result rd:x15(0xffffffffdffff000)
1: 
    auipc x15, 0xdffff
    la x5, 1b
    sub  x15,  x15, x5
    sd  x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0xffffffffdffff000)

    # Testcase 46:  imm:0xeffff, result rd:x16(0xffffffffeffff000)
1: 
    auipc x16, 0xeffff
    la x5, 1b
    sub  x16,  x16, x5
    sd  x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0xffffffffeffff000)

    # Testcase 47:  imm:0xf7fff, result rd:x17(0xfffffffff7fff000)
1: 
    auipc x17, 0xf7fff
    la x5, 1b
    sub  x17,  x17, x5
    sd  x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xfffffffff7fff000)

    # Testcase 48:  imm:0xfbfff, result rd:x18(0xfffffffffbfff000)
1: 
    auipc x18, 0xfbfff
    la x5, 1b
    sub  x18,  x18, x5
    sd  x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0xfffffffffbfff000)

    # Testcase 49:  imm:0xfdfff, result rd:x19(0xfffffffffdfff000)
1: 
    auipc x19, 0xfdfff
    la x5, 1b
    sub  x19,  x19, x5
    sd  x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xfffffffffdfff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res

    # Testcase 50:  imm:0xfefff, result rd:x20(0xfffffffffefff000)
1: 
    auipc x20, 0xfefff
    la x3, 1b
    sub  x20,  x20, x3
    sd  x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffffffffefff000)

    # Testcase 51:  imm:0xff7ff, result rd:x21(0xffffffffff7ff000)
1: 
    auipc x21, 0xff7ff
    la x3, 1b
    sub  x21,  x21, x3
    sd  x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffffffff7ff000)

    # Testcase 52:  imm:0xffbff, result rd:x22(0xffffffffffbff000)
1: 
    auipc x22, 0xffbff
    la x3, 1b
    sub  x22,  x22, x3
    sd  x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffffffffffbff000)

    # Testcase 53:  imm:0xffdff, result rd:x23(0xffffffffffdff000)
1: 
    auipc x23, 0xffdff
    la x3, 1b
    sub  x23,  x23, x3
    sd  x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffffffffdff000)

    # Testcase 54:  imm:0xffeff, result rd:x24(0xffffffffffeff000)
1: 
    auipc x24, 0xffeff
    la x3, 1b
    sub  x24,  x24, x3
    sd  x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffffffffffeff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res

    # Testcase 55:  imm:0xfff7f, result rd:x25(0xfffffffffff7f000)
1: 
    auipc x25, 0xfff7f
    la x8, 1b
    sub  x25,  x25, x8
    sd  x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffffffff7f000)

    # Testcase 56:  imm:0xfffbf, result rd:x26(0xfffffffffffbf000)
1: 
    auipc x26, 0xfffbf
    la x8, 1b
    sub  x26,  x26, x8
    sd  x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xfffffffffffbf000)

    # Testcase 57:  imm:0xfffdf, result rd:x27(0xfffffffffffdf000)
1: 
    auipc x27, 0xfffdf
    la x8, 1b
    sub  x27,  x27, x8
    sd  x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfffffffffffdf000)

    # Testcase 58:  imm:0xfffef, result rd:x28(0xfffffffffffef000)
1: 
    auipc x28, 0xfffef
    la x8, 1b
    sub  x28,  x28, x8
    sd  x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffffffffffef000)

    # Testcase 59:  imm:0xffff7, result rd:x29(0xffffffffffff7000)
1: 
    auipc x29, 0xffff7
    la x8, 1b
    sub  x29,  x29, x8
    sd  x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xffffffffffff7000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res

    # Testcase 60:  imm:0xffffb, result rd:x30(0xffffffffffffb000)
1: 
    auipc x30, 0xffffb
    la x6, 1b
    sub  x30,  x30, x6
    sd  x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xffffffffffffb000)

    # Testcase 61:  imm:0xffffd, result rd:x31(0xffffffffffffd000)
1: 
    auipc x31, 0xffffd
    la x6, 1b
    sub  x31,  x31, x6
    sd  x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xffffffffffffd000)

    # Testcase 62:  imm:0xffffe, result rd:x1(0xffffffffffffe000)
1: 
    auipc x1, 0xffffe
    la x6, 1b
    sub  x1,  x1, x6
    sd  x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffffffffffffe000)

    # Testcase 63:  imm:0x0, result rd:x2(0x0)
1: 
    auipc x2, 0x0
    la x6, 1b
    sub  x2,  x2, x6
    sd  x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0)

    # Testcase 64:  imm:0x80000, result rd:x3(0xffffffff80000000)
1: 
    auipc x3, 0x80000
    la x6, 1b
    sub  x3,  x3, x6
    sd  x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xffffffff80000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res

    # Testcase 65:  imm:0x40000, result rd:x4(0x40000000)
1: 
    auipc x4, 0x40000
    la x3, 1b
    sub  x4,  x4, x3
    sd  x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x40000000)

    # Testcase 66:  imm:0x20000, result rd:x5(0x20000000)
1: 
    auipc x5, 0x20000
    la x3, 1b
    sub  x5,  x5, x3
    sd  x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x20000000)

    # Testcase 67:  imm:0x10000, result rd:x6(0x10000000)
1: 
    auipc x6, 0x10000
    la x3, 1b
    sub  x6,  x6, x3
    sd  x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x10000000)

    # Testcase 68:  imm:0x8000, result rd:x7(0x8000000)
1: 
    auipc x7, 0x8000
    la x3, 1b
    sub  x7,  x7, x3
    sd  x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x8000000)

    # Testcase 69:  imm:0x4000, result rd:x8(0x4000000)
1: 
    auipc x8, 0x4000
    la x3, 1b
    sub  x8,  x8, x3
    sd  x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x4000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res

    # Testcase 70:  imm:0x2000, result rd:x9(0x2000000)
1: 
    auipc x9, 0x2000
    la x3, 1b
    sub  x9,  x9, x3
    sd  x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x2000000)

    # Testcase 71:  imm:0x1000, result rd:x10(0x1000000)
1: 
    auipc x10, 0x1000
    la x3, 1b
    sub  x10,  x10, x3
    sd  x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1000000)

    # Testcase 72:  imm:0x800, result rd:x11(0x800000)
1: 
    auipc x11, 0x800
    la x3, 1b
    sub  x11,  x11, x3
    sd  x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x800000)

    # Testcase 73:  imm:0x400, result rd:x12(0x400000)
1: 
    auipc x12, 0x400
    la x3, 1b
    sub  x12,  x12, x3
    sd  x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x400000)

    # Testcase 74:  imm:0x200, result rd:x13(0x200000)
1: 
    auipc x13, 0x200
    la x3, 1b
    sub  x13,  x13, x3
    sd  x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x200000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res

    # Testcase 75:  imm:0x100, result rd:x14(0x100000)
1: 
    auipc x14, 0x100
    la x6, 1b
    sub  x14,  x14, x6
    sd  x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x100000)

    # Testcase 76:  imm:0x80, result rd:x15(0x80000)
1: 
    auipc x15, 0x80
    la x6, 1b
    sub  x15,  x15, x6
    sd  x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x80000)

    # Testcase 77:  imm:0x40, result rd:x16(0x40000)
1: 
    auipc x16, 0x40
    la x6, 1b
    sub  x16,  x16, x6
    sd  x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x40000)

    # Testcase 78:  imm:0x20, result rd:x17(0x20000)
1: 
    auipc x17, 0x20
    la x6, 1b
    sub  x17,  x17, x6
    sd  x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x20000)

    # Testcase 79:  imm:0x10, result rd:x18(0x10000)
1: 
    auipc x18, 0x10
    la x6, 1b
    sub  x18,  x18, x6
    sd  x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x10000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res

    # Testcase 80:  imm:0x8, result rd:x19(0x8000)
1: 
    auipc x19, 0x8
    la x3, 1b
    sub  x19,  x19, x3
    sd  x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x8000)

    # Testcase 81:  imm:0x4, result rd:x20(0x4000)
1: 
    auipc x20, 0x4
    la x3, 1b
    sub  x20,  x20, x3
    sd  x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x4000)

    # Testcase 82:  imm:0x2, result rd:x21(0x2000)
1: 
    auipc x21, 0x2
    la x3, 1b
    sub  x21,  x21, x3
    sd  x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x2000)

    # Testcase 83:  imm:0x1, result rd:x22(0x1000)
1: 
    auipc x22, 0x1
    la x3, 1b
    sub  x22,  x22, x3
    sd  x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x1000)

    # Testcase 84:  imm:0xfffff, result rd:x23(0xfffffffffffff000)
1: 
    auipc x23, 0xfffff
    la x3, 1b
    sub  x23,  x23, x3
    sd  x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffffffffffff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res

    # Testcase 85:  imm:0x7ffff, result rd:x24(0x7ffff000)
1: 
    auipc x24, 0x7ffff
    la x3, 1b
    sub  x24,  x24, x3
    sd  x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x7ffff000)

    # Testcase 86:  imm:0xbffff, result rd:x25(0xffffffffbffff000)
1: 
    auipc x25, 0xbffff
    la x3, 1b
    sub  x25,  x25, x3
    sd  x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffffbffff000)

    # Testcase 87:  imm:0xdffff, result rd:x26(0xffffffffdffff000)
1: 
    auipc x26, 0xdffff
    la x3, 1b
    sub  x26,  x26, x3
    sd  x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffffffffdffff000)

    # Testcase 88:  imm:0xeffff, result rd:x27(0xffffffffeffff000)
1: 
    auipc x27, 0xeffff
    la x3, 1b
    sub  x27,  x27, x3
    sd  x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffffffffeffff000)

    # Testcase 89:  imm:0xf7fff, result rd:x28(0xfffffffff7fff000)
1: 
    auipc x28, 0xf7fff
    la x3, 1b
    sub  x28,  x28, x3
    sd  x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffffffff7fff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res

    # Testcase 90:  imm:0xfbfff, result rd:x29(0xfffffffffbfff000)
1: 
    auipc x29, 0xfbfff
    la x6, 1b
    sub  x29,  x29, x6
    sd  x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0xfffffffffbfff000)

    # Testcase 91:  imm:0xfdfff, result rd:x30(0xfffffffffdfff000)
1: 
    auipc x30, 0xfdfff
    la x6, 1b
    sub  x30,  x30, x6
    sd  x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfffffffffdfff000)

    # Testcase 92:  imm:0xfefff, result rd:x31(0xfffffffffefff000)
1: 
    auipc x31, 0xfefff
    la x6, 1b
    sub  x31,  x31, x6
    sd  x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xfffffffffefff000)

    # Testcase 93:  imm:0xff7ff, result rd:x1(0xffffffffff7ff000)
1: 
    auipc x1, 0xff7ff
    la x6, 1b
    sub  x1,  x1, x6
    sd  x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffffffffff7ff000)

    # Testcase 94:  imm:0xffbff, result rd:x2(0xffffffffffbff000)
1: 
    auipc x2, 0xffbff
    la x6, 1b
    sub  x2,  x2, x6
    sd  x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffffffffffbff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res

    # Testcase 95:  imm:0xffdff, result rd:x3(0xffffffffffdff000)
1: 
    auipc x3, 0xffdff
    la x8, 1b
    sub  x3,  x3, x8
    sd  x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xffffffffffdff000)

    # Testcase 96:  imm:0xffeff, result rd:x4(0xffffffffffeff000)
1: 
    auipc x4, 0xffeff
    la x8, 1b
    sub  x4,  x4, x8
    sd  x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xffffffffffeff000)

    # Testcase 97:  imm:0xfff7f, result rd:x5(0xfffffffffff7f000)
1: 
    auipc x5, 0xfff7f
    la x8, 1b
    sub  x5,  x5, x8
    sd  x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffffffff7f000)

    # Testcase 98:  imm:0xfffbf, result rd:x6(0xfffffffffffbf000)
1: 
    auipc x6, 0xfffbf
    la x8, 1b
    sub  x6,  x6, x8
    sd  x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfffffffffffbf000)

    # Testcase 99:  imm:0xfffdf, result rd:x7(0xfffffffffffdf000)
1: 
    auipc x7, 0xfffdf
    la x8, 1b
    sub  x7,  x7, x8
    sd  x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffffffdf000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res

    # Testcase 100:  imm:0xfffef, result rd:x8(0xfffffffffffef000)
1: 
    auipc x8, 0xfffef
    la x3, 1b
    sub  x8,  x8, x3
    sd  x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffef000)

    # Testcase 101:  imm:0xffff7, result rd:x9(0xffffffffffff7000)
1: 
    auipc x9, 0xffff7
    la x3, 1b
    sub  x9,  x9, x3
    sd  x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffffff7000)

    # Testcase 102:  imm:0xffffb, result rd:x10(0xffffffffffffb000)
1: 
    auipc x10, 0xffffb
    la x3, 1b
    sub  x10,  x10, x3
    sd  x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffffffffb000)

    # Testcase 103:  imm:0xffffd, result rd:x11(0xffffffffffffd000)
1: 
    auipc x11, 0xffffd
    la x3, 1b
    sub  x11,  x11, x3
    sd  x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffffd000)

    # Testcase 104:  imm:0xffffe, result rd:x12(0xffffffffffffe000)
1: 
    auipc x12, 0xffffe
    la x3, 1b
    sub  x12,  x12, x3
    sd  x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffe000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res

    # Testcase 105:  imm:0x0, result rd:x13(0x0)
1: 
    auipc x13, 0x0
    la x7, 1b
    sub  x13,  x13, x7
    sd  x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x0)

    # Testcase 106:  imm:0x80000, result rd:x14(0xffffffff80000000)
1: 
    auipc x14, 0x80000
    la x7, 1b
    sub  x14,  x14, x7
    sd  x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xffffffff80000000)

    # Testcase 107:  imm:0x40000, result rd:x15(0x40000000)
1: 
    auipc x15, 0x40000
    la x7, 1b
    sub  x15,  x15, x7
    sd  x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x40000000)

    # Testcase 108:  imm:0x20000, result rd:x16(0x20000000)
1: 
    auipc x16, 0x20000
    la x7, 1b
    sub  x16,  x16, x7
    sd  x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x20000000)

    # Testcase 109:  imm:0x10000, result rd:x17(0x10000000)
1: 
    auipc x17, 0x10000
    la x7, 1b
    sub  x17,  x17, x7
    sd  x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x10000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res

    # Testcase 110:  imm:0x8000, result rd:x18(0x8000000)
1: 
    auipc x18, 0x8000
    la x3, 1b
    sub  x18,  x18, x3
    sd  x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x8000000)

    # Testcase 111:  imm:0x4000, result rd:x19(0x4000000)
1: 
    auipc x19, 0x4000
    la x3, 1b
    sub  x19,  x19, x3
    sd  x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x4000000)

    # Testcase 112:  imm:0x2000, result rd:x20(0x2000000)
1: 
    auipc x20, 0x2000
    la x3, 1b
    sub  x20,  x20, x3
    sd  x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x2000000)

    # Testcase 113:  imm:0x1000, result rd:x21(0x1000000)
1: 
    auipc x21, 0x1000
    la x3, 1b
    sub  x21,  x21, x3
    sd  x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x1000000)

    # Testcase 114:  imm:0x800, result rd:x22(0x800000)
1: 
    auipc x22, 0x800
    la x3, 1b
    sub  x22,  x22, x3
    sd  x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x800000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res

    # Testcase 115:  imm:0x400, result rd:x23(0x400000)
1: 
    auipc x23, 0x400
    la x3, 1b
    sub  x23,  x23, x3
    sd  x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x400000)

    # Testcase 116:  imm:0x200, result rd:x24(0x200000)
1: 
    auipc x24, 0x200
    la x3, 1b
    sub  x24,  x24, x3
    sd  x24, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x200000)

    # Testcase 117:  imm:0x100, result rd:x25(0x100000)
1: 
    auipc x25, 0x100
    la x3, 1b
    sub  x25,  x25, x3
    sd  x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x100000)

    # Testcase 118:  imm:0x80, result rd:x26(0x80000)
1: 
    auipc x26, 0x80
    la x3, 1b
    sub  x26,  x26, x3
    sd  x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x80000)

    # Testcase 119:  imm:0x40, result rd:x27(0x40000)
1: 
    auipc x27, 0x40
    la x3, 1b
    sub  x27,  x27, x3
    sd  x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x40000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res

    # Testcase 120:  imm:0x20, result rd:x28(0x20000)
1: 
    auipc x28, 0x20
    la x7, 1b
    sub  x28,  x28, x7
    sd  x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0x20000)

    # Testcase 121:  imm:0x10, result rd:x29(0x10000)
1: 
    auipc x29, 0x10
    la x7, 1b
    sub  x29,  x29, x7
    sd  x29, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x10000)

    # Testcase 122:  imm:0x8, result rd:x30(0x8000)
1: 
    auipc x30, 0x8
    la x7, 1b
    sub  x30,  x30, x7
    sd  x30, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x8000)

    # Testcase 123:  imm:0x4, result rd:x31(0x4000)
1: 
    auipc x31, 0x4
    la x7, 1b
    sub  x31,  x31, x7
    sd  x31, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x4000)

    # Testcase 124:  imm:0x2, result rd:x1(0x2000)
1: 
    auipc x1, 0x2
    la x7, 1b
    sub  x1,  x1, x7
    sd  x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x2000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res

    # Testcase 125:  imm:0x1, result rd:x2(0x1000)
1: 
    auipc x2, 0x1
    la x8, 1b
    sub  x2,  x2, x8
    sd  x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x1000)

    # Testcase 126:  imm:0xfffff, result rd:x3(0xfffffffffffff000)
1: 
    auipc x3, 0xfffff
    la x8, 1b
    sub  x3,  x3, x8
    sd  x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xfffffffffffff000)

    # Testcase 127:  imm:0x7ffff, result rd:x4(0x7ffff000)
1: 
    auipc x4, 0x7ffff
    la x8, 1b
    sub  x4,  x4, x8
    sd  x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x7ffff000)

    # Testcase 128:  imm:0xbffff, result rd:x5(0xffffffffbffff000)
1: 
    auipc x5, 0xbffff
    la x8, 1b
    sub  x5,  x5, x8
    sd  x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xffffffffbffff000)

    # Testcase 129:  imm:0xdffff, result rd:x6(0xffffffffdffff000)
1: 
    auipc x6, 0xdffff
    la x8, 1b
    sub  x6,  x6, x8
    sd  x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0xffffffffdffff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res

    # Testcase 130:  imm:0xeffff, result rd:x7(0xffffffffeffff000)
1: 
    auipc x7, 0xeffff
    la x3, 1b
    sub  x7,  x7, x3
    sd  x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffffeffff000)

    # Testcase 131:  imm:0xf7fff, result rd:x8(0xfffffffff7fff000)
1: 
    auipc x8, 0xf7fff
    la x3, 1b
    sub  x8,  x8, x3
    sd  x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffff7fff000)

    # Testcase 132:  imm:0xfbfff, result rd:x9(0xfffffffffbfff000)
1: 
    auipc x9, 0xfbfff
    la x3, 1b
    sub  x9,  x9, x3
    sd  x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffffbfff000)

    # Testcase 133:  imm:0xfdfff, result rd:x10(0xfffffffffdfff000)
1: 
    auipc x10, 0xfdfff
    la x3, 1b
    sub  x10,  x10, x3
    sd  x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffffdfff000)

    # Testcase 134:  imm:0xfefff, result rd:x11(0xfffffffffefff000)
1: 
    auipc x11, 0xfefff
    la x3, 1b
    sub  x11,  x11, x3
    sd  x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffffefff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res

    # Testcase 135:  imm:0xff7ff, result rd:x12(0xffffffffff7ff000)
1: 
    auipc x12, 0xff7ff
    la x8, 1b
    sub  x12,  x12, x8
    sd  x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0xffffffffff7ff000)

    # Testcase 136:  imm:0xffbff, result rd:x13(0xffffffffffbff000)
1: 
    auipc x13, 0xffbff
    la x8, 1b
    sub  x13,  x13, x8
    sd  x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0xffffffffffbff000)

    # Testcase 137:  imm:0xffdff, result rd:x14(0xffffffffffdff000)
1: 
    auipc x14, 0xffdff
    la x8, 1b
    sub  x14,  x14, x8
    sd  x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xffffffffffdff000)

    # Testcase 138:  imm:0xffeff, result rd:x15(0xffffffffffeff000)
1: 
    auipc x15, 0xffeff
    la x8, 1b
    sub  x15,  x15, x8
    sd  x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0xffffffffffeff000)

    # Testcase 139:  imm:0xfff7f, result rd:x16(0xfffffffffff7f000)
1: 
    auipc x16, 0xfff7f
    la x8, 1b
    sub  x16,  x16, x8
    sd  x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0xfffffffffff7f000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res

    # Testcase 140:  imm:0xfffbf, result rd:x17(0xfffffffffffbf000)
1: 
    auipc x17, 0xfffbf
    la x3, 1b
    sub  x17,  x17, x3
    sd  x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x17, 0xfffffffffffbf000)

    # Testcase 141:  imm:0xfffdf, result rd:x18(0xfffffffffffdf000)
1: 
    auipc x18, 0xfffdf
    la x3, 1b
    sub  x18,  x18, x3
    sd  x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0xfffffffffffdf000)

    # Testcase 142:  imm:0xfffef, result rd:x19(0xfffffffffffef000)
1: 
    auipc x19, 0xfffef
    la x3, 1b
    sub  x19,  x19, x3
    sd  x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xfffffffffffef000)

    # Testcase 143:  imm:0xffff7, result rd:x20(0xffffffffffff7000)
1: 
    auipc x20, 0xffff7
    la x3, 1b
    sub  x20,  x20, x3
    sd  x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffffffffffff7000)

    # Testcase 144:  imm:0xffffb, result rd:x21(0xffffffffffffb000)
1: 
    auipc x21, 0xffffb
    la x3, 1b
    sub  x21,  x21, x3
    sd  x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffffffffffb000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res

    # Testcase 145:  imm:0xffffd, result rd:x22(0xffffffffffffd000)
1: 
    auipc x22, 0xffffd
    la x3, 1b
    sub  x22,  x22, x3
    sd  x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffffffffffffd000)

    # Testcase 146:  imm:0xffffe, result rd:x23(0xffffffffffffe000)
1: 
    auipc x23, 0xffffe
    la x3, 1b
    sub  x23,  x23, x3
    sd  x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffffffffffe000)

    # Testcase 147:  imm:0x0, result rd:x24(0x0)
1: 
    auipc x24, 0x0
    la x3, 1b
    sub  x24,  x24, x3
    sd  x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0)

    # Testcase 148:  imm:0x80000, result rd:x25(0xffffffff80000000)
1: 
    auipc x25, 0x80000
    la x3, 1b
    sub  x25,  x25, x3
    sd  x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffff80000000)

    # Testcase 149:  imm:0x40000, result rd:x26(0x40000000)
1: 
    auipc x26, 0x40000
    la x3, 1b
    sub  x26,  x26, x3
    sd  x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x40000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x6, test_31_res

    # Testcase 150:  imm:0x20000, result rd:x27(0x20000000)
1: 
    auipc x27, 0x20000
    la x8, 1b
    sub  x27,  x27, x8
    sd  x27, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x20000000)

    # Testcase 151:  imm:0x10000, result rd:x28(0x10000000)
1: 
    auipc x28, 0x10000
    la x8, 1b
    sub  x28,  x28, x8
    sd  x28, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x10000000)

    # Testcase 152:  imm:0x8000, result rd:x29(0x8000000)
1: 
    auipc x29, 0x8000
    la x8, 1b
    sub  x29,  x29, x8
    sd  x29, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x8000000)

    # Testcase 153:  imm:0x4000, result rd:x30(0x4000000)
1: 
    auipc x30, 0x4000
    la x8, 1b
    sub  x30,  x30, x8
    sd  x30, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x4000000)

    # Testcase 154:  imm:0x2000, result rd:x31(0x2000000)
1: 
    auipc x31, 0x2000
    la x8, 1b
    sub  x31,  x31, x8
    sd  x31, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x2000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x6, test_32_res

    # Testcase 155:  imm:0x1000, result rd:x1(0x1000000)
1: 
    auipc x1, 0x1000
    la x8, 1b
    sub  x1,  x1, x8
    sd  x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x1000000)

    # Testcase 156:  imm:0x800, result rd:x2(0x800000)
1: 
    auipc x2, 0x800
    la x8, 1b
    sub  x2,  x2, x8
    sd  x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x800000)

    # Testcase 157:  imm:0x400, result rd:x3(0x400000)
1: 
    auipc x3, 0x400
    la x8, 1b
    sub  x3,  x3, x8
    sd  x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x400000)

    # Testcase 158:  imm:0x200, result rd:x4(0x200000)
1: 
    auipc x4, 0x200
    la x8, 1b
    sub  x4,  x4, x8
    sd  x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x200000)

    # Testcase 159:  imm:0x100, result rd:x5(0x100000)
1: 
    auipc x5, 0x100
    la x8, 1b
    sub  x5,  x5, x8
    sd  x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x100000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res

    # Testcase 160:  imm:0x80, result rd:x6(0x80000)
1: 
    auipc x6, 0x80
    la x3, 1b
    sub  x6,  x6, x3
    sd  x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x80000)

    # Testcase 161:  imm:0x40, result rd:x7(0x40000)
1: 
    auipc x7, 0x40
    la x3, 1b
    sub  x7,  x7, x3
    sd  x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x40000)

    # Testcase 162:  imm:0x20, result rd:x8(0x20000)
1: 
    auipc x8, 0x20
    la x3, 1b
    sub  x8,  x8, x3
    sd  x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000)

    # Testcase 163:  imm:0x10, result rd:x9(0x10000)
1: 
    auipc x9, 0x10
    la x3, 1b
    sub  x9,  x9, x3
    sd  x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x10000)

    # Testcase 164:  imm:0x8, result rd:x10(0x8000)
1: 
    auipc x10, 0x8
    la x3, 1b
    sub  x10,  x10, x3
    sd  x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res

    # Testcase 165:  imm:0x4, result rd:x11(0x4000)
1: 
    auipc x11, 0x4
    la x8, 1b
    sub  x11,  x11, x8
    sd  x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x4000)

    # Testcase 166:  imm:0x2, result rd:x12(0x2000)
1: 
    auipc x12, 0x2
    la x8, 1b
    sub  x12,  x12, x8
    sd  x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x2000)

    # Testcase 167:  imm:0x1, result rd:x13(0x1000)
1: 
    auipc x13, 0x1
    la x8, 1b
    sub  x13,  x13, x8
    sd  x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x1000)

    # Testcase 168:  imm:0xfffff, result rd:x14(0xfffffffffffff000)
1: 
    auipc x14, 0xfffff
    la x8, 1b
    sub  x14,  x14, x8
    sd  x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xfffffffffffff000)

    # Testcase 169:  imm:0x7ffff, result rd:x15(0x7ffff000)
1: 
    auipc x15, 0x7ffff
    la x8, 1b
    sub  x15,  x15, x8
    sd  x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x7ffff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x2, test_35_res

    # Testcase 170:  imm:0xbffff, result rd:x16(0xffffffffbffff000)
1: 
    auipc x16, 0xbffff
    la x4, 1b
    sub  x16,  x16, x4
    sd  x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0xffffffffbffff000)

    # Testcase 171:  imm:0xdffff, result rd:x17(0xffffffffdffff000)
1: 
    auipc x17, 0xdffff
    la x4, 1b
    sub  x17,  x17, x4
    sd  x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0xffffffffdffff000)

    # Testcase 172:  imm:0xeffff, result rd:x18(0xffffffffeffff000)
1: 
    auipc x18, 0xeffff
    la x4, 1b
    sub  x18,  x18, x4
    sd  x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0xffffffffeffff000)

    # Testcase 173:  imm:0xf7fff, result rd:x19(0xfffffffff7fff000)
1: 
    auipc x19, 0xf7fff
    la x4, 1b
    sub  x19,  x19, x4
    sd  x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0xfffffffff7fff000)

    # Testcase 174:  imm:0xfbfff, result rd:x20(0xfffffffffbfff000)
1: 
    auipc x20, 0xfbfff
    la x4, 1b
    sub  x20,  x20, x4
    sd  x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0xfffffffffbfff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res

    # Testcase 175:  imm:0xfdfff, result rd:x21(0xfffffffffdfff000)
1: 
    auipc x21, 0xfdfff
    la x3, 1b
    sub  x21,  x21, x3
    sd  x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffffffdfff000)

    # Testcase 176:  imm:0xfefff, result rd:x22(0xfffffffffefff000)
1: 
    auipc x22, 0xfefff
    la x3, 1b
    sub  x22,  x22, x3
    sd  x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffffffffefff000)

    # Testcase 177:  imm:0xff7ff, result rd:x23(0xffffffffff7ff000)
1: 
    auipc x23, 0xff7ff
    la x3, 1b
    sub  x23,  x23, x3
    sd  x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffffffff7ff000)

    # Testcase 178:  imm:0xffbff, result rd:x24(0xffffffffffbff000)
1: 
    auipc x24, 0xffbff
    la x3, 1b
    sub  x24,  x24, x3
    sd  x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffffffffffbff000)

    # Testcase 179:  imm:0xffdff, result rd:x25(0xffffffffffdff000)
1: 
    auipc x25, 0xffdff
    la x3, 1b
    sub  x25,  x25, x3
    sd  x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffffffdff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res

    # Testcase 180:  imm:0xffeff, result rd:x26(0xffffffffffeff000)
1: 
    auipc x26, 0xffeff
    la x8, 1b
    sub  x26,  x26, x8
    sd  x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0xffffffffffeff000)

    # Testcase 181:  imm:0xfff7f, result rd:x27(0xfffffffffff7f000)
1: 
    auipc x27, 0xfff7f
    la x8, 1b
    sub  x27,  x27, x8
    sd  x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0xfffffffffff7f000)

    # Testcase 182:  imm:0xfffbf, result rd:x28(0xfffffffffffbf000)
1: 
    auipc x28, 0xfffbf
    la x8, 1b
    sub  x28,  x28, x8
    sd  x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0xfffffffffffbf000)

    # Testcase 183:  imm:0xfffdf, result rd:x29(0xfffffffffffdf000)
1: 
    auipc x29, 0xfffdf
    la x8, 1b
    sub  x29,  x29, x8
    sd  x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0xfffffffffffdf000)

    # Testcase 184:  imm:0xfffef, result rd:x30(0xfffffffffffef000)
1: 
    auipc x30, 0xfffef
    la x8, 1b
    sub  x30,  x30, x8
    sd  x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0xfffffffffffef000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x5, test_38_res

    # Testcase 185:  imm:0xffff7, result rd:x31(0xffffffffffff7000)
1: 
    auipc x31, 0xffff7
    la x7, 1b
    sub  x31,  x31, x7
    sd  x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xffffffffffff7000)

    # Testcase 186:  imm:0xffffb, result rd:x1(0xffffffffffffb000)
1: 
    auipc x1, 0xffffb
    la x7, 1b
    sub  x1,  x1, x7
    sd  x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xffffffffffffb000)

    # Testcase 187:  imm:0xffffd, result rd:x2(0xffffffffffffd000)
1: 
    auipc x2, 0xffffd
    la x7, 1b
    sub  x2,  x2, x7
    sd  x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xffffffffffffd000)

    # Testcase 188:  imm:0xffffe, result rd:x3(0xffffffffffffe000)
1: 
    auipc x3, 0xffffe
    la x7, 1b
    sub  x3,  x3, x7
    sd  x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0xffffffffffffe000)

    # Testcase 189:  imm:0x0, result rd:x4(0x0)
1: 
    auipc x4, 0x0
    la x7, 1b
    sub  x4,  x4, x7
    sd  x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x0)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res

    # Testcase 190:  imm:0x80000, result rd:x5(0xffffffff80000000)
1: 
    auipc x5, 0x80000
    la x3, 1b
    sub  x5,  x5, x3
    sd  x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xffffffff80000000)

    # Testcase 191:  imm:0x40000, result rd:x6(0x40000000)
1: 
    auipc x6, 0x40000
    la x3, 1b
    sub  x6,  x6, x3
    sd  x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x40000000)

    # Testcase 192:  imm:0x20000, result rd:x7(0x20000000)
1: 
    auipc x7, 0x20000
    la x3, 1b
    sub  x7,  x7, x3
    sd  x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x20000000)

    # Testcase 193:  imm:0x10000, result rd:x8(0x10000000)
1: 
    auipc x8, 0x10000
    la x3, 1b
    sub  x8,  x8, x3
    sd  x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x10000000)

    # Testcase 194:  imm:0x8000, result rd:x9(0x8000000)
1: 
    auipc x9, 0x8000
    la x3, 1b
    sub  x9,  x9, x3
    sd  x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x8000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res

    # Testcase 195:  imm:0x4000, result rd:x10(0x4000000)
1: 
    auipc x10, 0x4000
    la x8, 1b
    sub  x10,  x10, x8
    sd  x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x4000000)

    # Testcase 196:  imm:0x2000, result rd:x11(0x2000000)
1: 
    auipc x11, 0x2000
    la x8, 1b
    sub  x11,  x11, x8
    sd  x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x2000000)

    # Testcase 197:  imm:0x1000, result rd:x12(0x1000000)
1: 
    auipc x12, 0x1000
    la x8, 1b
    sub  x12,  x12, x8
    sd  x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000000)

    # Testcase 198:  imm:0x800, result rd:x13(0x800000)
1: 
    auipc x13, 0x800
    la x8, 1b
    sub  x13,  x13, x8
    sd  x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x800000)

    # Testcase 199:  imm:0x400, result rd:x14(0x400000)
1: 
    auipc x14, 0x400
    la x8, 1b
    sub  x14,  x14, x8
    sd  x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x400000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x3, test_41_res

    # Testcase 200:  imm:0x200, result rd:x15(0x200000)
1: 
    auipc x15, 0x200
    la x5, 1b
    sub  x15,  x15, x5
    sd  x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x200000)

    # Testcase 201:  imm:0x100, result rd:x16(0x100000)
1: 
    auipc x16, 0x100
    la x5, 1b
    sub  x16,  x16, x5
    sd  x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x100000)

    # Testcase 202:  imm:0x80, result rd:x17(0x80000)
1: 
    auipc x17, 0x80
    la x5, 1b
    sub  x17,  x17, x5
    sd  x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x80000)

    # Testcase 203:  imm:0x40, result rd:x18(0x40000)
1: 
    auipc x18, 0x40
    la x5, 1b
    sub  x18,  x18, x5
    sd  x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x40000)

    # Testcase 204:  imm:0x20, result rd:x19(0x20000)
1: 
    auipc x19, 0x20
    la x5, 1b
    sub  x19,  x19, x5
    sd  x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x20000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res

    # Testcase 205:  imm:0x10, result rd:x20(0x10000)
1: 
    auipc x20, 0x10
    la x3, 1b
    sub  x20,  x20, x3
    sd  x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x10000)

    # Testcase 206:  imm:0x8, result rd:x21(0x8000)
1: 
    auipc x21, 0x8
    la x3, 1b
    sub  x21,  x21, x3
    sd  x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x8000)

    # Testcase 207:  imm:0x4, result rd:x22(0x4000)
1: 
    auipc x22, 0x4
    la x3, 1b
    sub  x22,  x22, x3
    sd  x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x4000)

    # Testcase 208:  imm:0x2, result rd:x23(0x2000)
1: 
    auipc x23, 0x2
    la x3, 1b
    sub  x23,  x23, x3
    sd  x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x2000)

    # Testcase 209:  imm:0x1, result rd:x24(0x1000)
1: 
    auipc x24, 0x1
    la x3, 1b
    sub  x24,  x24, x3
    sd  x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x1000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res

    # Testcase 210:  imm:0xfffff, result rd:x25(0xfffffffffffff000)
1: 
    auipc x25, 0xfffff
    la x8, 1b
    sub  x25,  x25, x8
    sd  x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffffffffff000)

    # Testcase 211:  imm:0x7ffff, result rd:x26(0x7ffff000)
1: 
    auipc x26, 0x7ffff
    la x8, 1b
    sub  x26,  x26, x8
    sd  x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x7ffff000)

    # Testcase 212:  imm:0xbffff, result rd:x27(0xffffffffbffff000)
1: 
    auipc x27, 0xbffff
    la x8, 1b
    sub  x27,  x27, x8
    sd  x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffffffffbffff000)

    # Testcase 213:  imm:0xdffff, result rd:x28(0xffffffffdffff000)
1: 
    auipc x28, 0xdffff
    la x8, 1b
    sub  x28,  x28, x8
    sd  x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xffffffffdffff000)

    # Testcase 214:  imm:0xeffff, result rd:x29(0xffffffffeffff000)
1: 
    auipc x29, 0xeffff
    la x8, 1b
    sub  x29,  x29, x8
    sd  x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xffffffffeffff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x4, test_44_res

    # Testcase 215:  imm:0xf7fff, result rd:x30(0xfffffffff7fff000)
1: 
    auipc x30, 0xf7fff
    la x6, 1b
    sub  x30,  x30, x6
    sd  x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfffffffff7fff000)

    # Testcase 216:  imm:0xfbfff, result rd:x31(0xfffffffffbfff000)
1: 
    auipc x31, 0xfbfff
    la x6, 1b
    sub  x31,  x31, x6
    sd  x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xfffffffffbfff000)

    # Testcase 217:  imm:0xfdfff, result rd:x1(0xfffffffffdfff000)
1: 
    auipc x1, 0xfdfff
    la x6, 1b
    sub  x1,  x1, x6
    sd  x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xfffffffffdfff000)

    # Testcase 218:  imm:0xfefff, result rd:x2(0xfffffffffefff000)
1: 
    auipc x2, 0xfefff
    la x6, 1b
    sub  x2,  x2, x6
    sd  x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xfffffffffefff000)

    # Testcase 219:  imm:0xff7ff, result rd:x3(0xffffffffff7ff000)
1: 
    auipc x3, 0xff7ff
    la x6, 1b
    sub  x3,  x3, x6
    sd  x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xffffffffff7ff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res

    # Testcase 220:  imm:0xffbff, result rd:x4(0xffffffffffbff000)
1: 
    auipc x4, 0xffbff
    la x3, 1b
    sub  x4,  x4, x3
    sd  x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xffffffffffbff000)

    # Testcase 221:  imm:0xffdff, result rd:x5(0xffffffffffdff000)
1: 
    auipc x5, 0xffdff
    la x3, 1b
    sub  x5,  x5, x3
    sd  x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xffffffffffdff000)

    # Testcase 222:  imm:0xffeff, result rd:x6(0xffffffffffeff000)
1: 
    auipc x6, 0xffeff
    la x3, 1b
    sub  x6,  x6, x3
    sd  x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xffffffffffeff000)

    # Testcase 223:  imm:0xfff7f, result rd:x7(0xfffffffffff7f000)
1: 
    auipc x7, 0xfff7f
    la x3, 1b
    sub  x7,  x7, x3
    sd  x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffffff7f000)

    # Testcase 224:  imm:0xfffbf, result rd:x8(0xfffffffffffbf000)
1: 
    auipc x8, 0xfffbf
    la x3, 1b
    sub  x8,  x8, x3
    sd  x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffbf000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res

    # Testcase 225:  imm:0xfffdf, result rd:x9(0xfffffffffffdf000)
1: 
    auipc x9, 0xfffdf
    la x3, 1b
    sub  x9,  x9, x3
    sd  x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffffffdf000)

    # Testcase 226:  imm:0xfffef, result rd:x10(0xfffffffffffef000)
1: 
    auipc x10, 0xfffef
    la x3, 1b
    sub  x10,  x10, x3
    sd  x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffffffef000)

    # Testcase 227:  imm:0xffff7, result rd:x11(0xffffffffffff7000)
1: 
    auipc x11, 0xffff7
    la x3, 1b
    sub  x11,  x11, x3
    sd  x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffffff7000)

    # Testcase 228:  imm:0xffffb, result rd:x12(0xffffffffffffb000)
1: 
    auipc x12, 0xffffb
    la x3, 1b
    sub  x12,  x12, x3
    sd  x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffb000)

    # Testcase 229:  imm:0xffffd, result rd:x13(0xffffffffffffd000)
1: 
    auipc x13, 0xffffd
    la x3, 1b
    sub  x13,  x13, x3
    sd  x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffffffd000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x4, test_47_res

    # Testcase 230:  imm:0xffffe, result rd:x14(0xffffffffffffe000)
1: 
    auipc x14, 0xffffe
    la x6, 1b
    sub  x14,  x14, x6
    sd  x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xffffffffffffe000)

    # Testcase 231:  imm:0x0, result rd:x15(0x0)
1: 
    auipc x15, 0x0
    la x6, 1b
    sub  x15,  x15, x6
    sd  x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0)

    # Testcase 232:  imm:0x80000, result rd:x16(0xffffffff80000000)
1: 
    auipc x16, 0x80000
    la x6, 1b
    sub  x16,  x16, x6
    sd  x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffffffff80000000)

    # Testcase 233:  imm:0x40000, result rd:x17(0x40000000)
1: 
    auipc x17, 0x40000
    la x6, 1b
    sub  x17,  x17, x6
    sd  x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x40000000)

    # Testcase 234:  imm:0x20000, result rd:x18(0x20000000)
1: 
    auipc x18, 0x20000
    la x6, 1b
    sub  x18,  x18, x6
    sd  x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x20000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res

    # Testcase 235:  imm:0x10000, result rd:x19(0x10000000)
1: 
    auipc x19, 0x10000
    la x3, 1b
    sub  x19,  x19, x3
    sd  x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x10000000)

    # Testcase 236:  imm:0x8000, result rd:x20(0x8000000)
1: 
    auipc x20, 0x8000
    la x3, 1b
    sub  x20,  x20, x3
    sd  x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x8000000)

    # Testcase 237:  imm:0x4000, result rd:x21(0x4000000)
1: 
    auipc x21, 0x4000
    la x3, 1b
    sub  x21,  x21, x3
    sd  x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x4000000)

    # Testcase 238:  imm:0x2000, result rd:x22(0x2000000)
1: 
    auipc x22, 0x2000
    la x3, 1b
    sub  x22,  x22, x3
    sd  x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x2000000)

    # Testcase 239:  imm:0x1000, result rd:x23(0x1000000)
1: 
    auipc x23, 0x1000
    la x3, 1b
    sub  x23,  x23, x3
    sd  x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x1000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res

    # Testcase 240:  imm:0x800, result rd:x24(0x800000)
1: 
    auipc x24, 0x800
    la x3, 1b
    sub  x24,  x24, x3
    sd  x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x800000)

    # Testcase 241:  imm:0x400, result rd:x25(0x400000)
1: 
    auipc x25, 0x400
    la x3, 1b
    sub  x25,  x25, x3
    sd  x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x400000)

    # Testcase 242:  imm:0x200, result rd:x26(0x200000)
1: 
    auipc x26, 0x200
    la x3, 1b
    sub  x26,  x26, x3
    sd  x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x200000)

    # Testcase 243:  imm:0x100, result rd:x27(0x100000)
1: 
    auipc x27, 0x100
    la x3, 1b
    sub  x27,  x27, x3
    sd  x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x100000)

    # Testcase 244:  imm:0x80, result rd:x28(0x80000)
1: 
    auipc x28, 0x80
    la x3, 1b
    sub  x28,  x28, x3
    sd  x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x80000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x4, test_50_res

    # Testcase 245:  imm:0x40, result rd:x29(0x40000)
1: 
    auipc x29, 0x40
    la x6, 1b
    sub  x29,  x29, x6
    sd  x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x40000)

    # Testcase 246:  imm:0x20, result rd:x30(0x20000)
1: 
    auipc x30, 0x20
    la x6, 1b
    sub  x30,  x30, x6
    sd  x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x20000)

    # Testcase 247:  imm:0x10, result rd:x31(0x10000)
1: 
    auipc x31, 0x10
    la x6, 1b
    sub  x31,  x31, x6
    sd  x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x10000)

    # Testcase 248:  imm:0x8, result rd:x1(0x8000)
1: 
    auipc x1, 0x8
    la x6, 1b
    sub  x1,  x1, x6
    sd  x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x8000)

    # Testcase 249:  imm:0x4, result rd:x2(0x4000)
1: 
    auipc x2, 0x4
    la x6, 1b
    sub  x2,  x2, x6
    sd  x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x4000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res

    # Testcase 250:  imm:0x2, result rd:x3(0x2000)
1: 
    auipc x3, 0x2
    la x8, 1b
    sub  x3,  x3, x8
    sd  x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x2000)

    # Testcase 251:  imm:0x1, result rd:x4(0x1000)
1: 
    auipc x4, 0x1
    la x8, 1b
    sub  x4,  x4, x8
    sd  x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x1000)

    # Testcase 252:  imm:0xfffff, result rd:x5(0xfffffffffffff000)
1: 
    auipc x5, 0xfffff
    la x8, 1b
    sub  x5,  x5, x8
    sd  x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffffffffff000)

    # Testcase 253:  imm:0x7ffff, result rd:x6(0x7ffff000)
1: 
    auipc x6, 0x7ffff
    la x8, 1b
    sub  x6,  x6, x8
    sd  x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x7ffff000)

    # Testcase 254:  imm:0xbffff, result rd:x7(0xffffffffbffff000)
1: 
    auipc x7, 0xbffff
    la x8, 1b
    sub  x7,  x7, x8
    sd  x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffffbffff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res

    # Testcase 255:  imm:0xdffff, result rd:x8(0xffffffffdffff000)
1: 
    auipc x8, 0xdffff
    la x3, 1b
    sub  x8,  x8, x3
    sd  x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffdffff000)

    # Testcase 256:  imm:0xeffff, result rd:x9(0xffffffffeffff000)
1: 
    auipc x9, 0xeffff
    la x3, 1b
    sub  x9,  x9, x3
    sd  x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffeffff000)

    # Testcase 257:  imm:0xf7fff, result rd:x10(0xfffffffff7fff000)
1: 
    auipc x10, 0xf7fff
    la x3, 1b
    sub  x10,  x10, x3
    sd  x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffff7fff000)

    # Testcase 258:  imm:0xfbfff, result rd:x11(0xfffffffffbfff000)
1: 
    auipc x11, 0xfbfff
    la x3, 1b
    sub  x11,  x11, x3
    sd  x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffffbfff000)

    # Testcase 259:  imm:0xfdfff, result rd:x12(0xfffffffffdfff000)
1: 
    auipc x12, 0xfdfff
    la x3, 1b
    sub  x12,  x12, x3
    sd  x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffdfff000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x2, test_53_res

    # Testcase 260:  imm:0xfefff, result rd:x13(0xfffffffffefff000)
1: 
    auipc x13, 0xfefff
    la x6, 1b
    sub  x13,  x13, x6
    sd  x13, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x13, 0xfffffffffefff000)

    # Testcase 261:  imm:0xff7ff, result rd:x14(0xffffffffff7ff000)
1: 
    auipc x14, 0xff7ff
    la x6, 1b
    sub  x14,  x14, x6
    sd  x14, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xffffffffff7ff000)

    # Testcase 262:  imm:0xffbff, result rd:x15(0xffffffffffbff000)
1: 
    auipc x15, 0xffbff
    la x6, 1b
    sub  x15,  x15, x6
    sd  x15, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xffffffffffbff000)

    # Testcase 263:  imm:0xffdff, result rd:x16(0xffffffffffdff000)
1: 
    auipc x16, 0xffdff
    la x6, 1b
    sub  x16,  x16, x6
    sd  x16, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffffffffffdff000)



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

