# RISC-V Compliance Test I-C-MV-01
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
# Description: Testing instruction 'c.mv'.

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

 
    # Testcase 0:  rd:x1(0x00000001), rs2:x16(0xffffffffffffffff), result rd:x1(0xffffffffffffffff)
    li  x1,  MASK_XLEN(0x1)
    li  x16, MASK_XLEN(0xffffffffffffffff)
    c.mv x1, x16
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xffffffffffffffff) 
 
    # Testcase 1:  rd:x2(0x00000002), rs2:x15(0x7fffffffffffffff), result rd:x2(0x7fffffffffffffff)
    li  x2,  MASK_XLEN(0x2)
    li  x15, MASK_XLEN(0x7fffffffffffffff)
    c.mv x2, x15
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x7fffffffffffffff) 
 
    # Testcase 2:  rd:x3(0x00000004), rs2:x14(0xbfffffffffffffff), result rd:x3(0xbfffffffffffffff)
    li  x3,  MASK_XLEN(0x4)
    li  x14, MASK_XLEN(0xbfffffffffffffff)
    c.mv x3, x14
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xbfffffffffffffff) 
 
    # Testcase 3:  rd:x4(0x00000008), rs2:x13(0xdfffffffffffffff), result rd:x4(0xdfffffffffffffff)
    li  x4,  MASK_XLEN(0x8)
    li  x13, MASK_XLEN(0xdfffffffffffffff)
    c.mv x4, x13
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xdfffffffffffffff) 
 
    # Testcase 4:  rd:x5(0x00000010), rs2:x12(0xefffffffffffffff), result rd:x5(0xefffffffffffffff)
    li  x5,  MASK_XLEN(0x10)
    li  x12, MASK_XLEN(0xefffffffffffffff)
    c.mv x5, x12
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xefffffffffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res

 
    # Testcase 5:  rd:x6(0x00000020), rs2:x11(0xf7ffffffffffffff), result rd:x6(0xf7ffffffffffffff)
    li  x6,  MASK_XLEN(0x20)
    li  x11, MASK_XLEN(0xf7ffffffffffffff)
    c.mv x6, x11
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xf7ffffffffffffff) 
 
    # Testcase 6:  rd:x7(0x00000040), rs2:x10(0xfbffffffffffffff), result rd:x7(0xfbffffffffffffff)
    li  x7,  MASK_XLEN(0x40)
    li  x10, MASK_XLEN(0xfbffffffffffffff)
    c.mv x7, x10
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfbffffffffffffff) 
 
    # Testcase 7:  rd:x8(0x00000080), rs2:x9(0xfdffffffffffffff), result rd:x8(0xfdffffffffffffff)
    li  x8,  MASK_XLEN(0x80)
    li  x9, MASK_XLEN(0xfdffffffffffffff)
    c.mv x8, x9
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfdffffffffffffff) 
 
    # Testcase 8:  rd:x9(0x00000100), rs2:x8(0xfeffffffffffffff), result rd:x9(0xfeffffffffffffff)
    li  x9,  MASK_XLEN(0x100)
    li  x8, MASK_XLEN(0xfeffffffffffffff)
    c.mv x9, x8
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfeffffffffffffff) 
 
    # Testcase 9:  rd:x10(0x00000200), rs2:x7(0xff7fffffffffffff), result rd:x10(0xff7fffffffffffff)
    li  x10,  MASK_XLEN(0x200)
    li  x7, MASK_XLEN(0xff7fffffffffffff)
    c.mv x10, x7
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xff7fffffffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res

 
    # Testcase 10:  rd:x11(0x00000400), rs2:x6(0xffbfffffffffffff), result rd:x11(0xffbfffffffffffff)
    li  x11,  MASK_XLEN(0x400)
    li  x6, MASK_XLEN(0xffbfffffffffffff)
    c.mv x11, x6
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0xffbfffffffffffff) 
 
    # Testcase 11:  rd:x12(0x00000800), rs2:x5(0xffdfffffffffffff), result rd:x12(0xffdfffffffffffff)
    li  x12,  MASK_XLEN(0x800)
    li  x5, MASK_XLEN(0xffdfffffffffffff)
    c.mv x12, x5
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0xffdfffffffffffff) 
 
    # Testcase 12:  rd:x13(0x00001000), rs2:x4(0xffefffffffffffff), result rd:x13(0xffefffffffffffff)
    li  x13,  MASK_XLEN(0x1000)
    li  x4, MASK_XLEN(0xffefffffffffffff)
    c.mv x13, x4
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0xffefffffffffffff) 
 
    # Testcase 13:  rd:x14(0x00002000), rs2:x3(0xfff7ffffffffffff), result rd:x14(0xfff7ffffffffffff)
    li  x14,  MASK_XLEN(0x2000)
    li  x3, MASK_XLEN(0xfff7ffffffffffff)
    c.mv x14, x3
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xfff7ffffffffffff) 
 
    # Testcase 14:  rd:x15(0x00004000), rs2:x2(0xfffbffffffffffff), result rd:x15(0xfffbffffffffffff)
    li  x15,  MASK_XLEN(0x4000)
    li  x2, MASK_XLEN(0xfffbffffffffffff)
    c.mv x15, x2
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0xfffbffffffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res

 
    # Testcase 15:  rd:x16(0x00008000), rs2:x1(0xfffdffffffffffff), result rd:x16(0xfffdffffffffffff)
    li  x16,  MASK_XLEN(0x8000)
    li  x1, MASK_XLEN(0xfffdffffffffffff)
    c.mv x16, x1
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0xfffdffffffffffff) 
 
    # Testcase 16:  rd:x17(0x00010000), rs2:x31(0xfffeffffffffffff), result rd:x17(0xfffeffffffffffff)
    li  x17,  MASK_XLEN(0x10000)
    li  x31, MASK_XLEN(0xfffeffffffffffff)
    c.mv x17, x31
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0xfffeffffffffffff) 
 
    # Testcase 17:  rd:x18(0x00020000), rs2:x30(0xffff7fffffffffff), result rd:x18(0xffff7fffffffffff)
    li  x18,  MASK_XLEN(0x20000)
    li  x30, MASK_XLEN(0xffff7fffffffffff)
    c.mv x18, x30
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0xffff7fffffffffff) 
 
    # Testcase 18:  rd:x19(0x00040000), rs2:x29(0xffffbfffffffffff), result rd:x19(0xffffbfffffffffff)
    li  x19,  MASK_XLEN(0x40000)
    li  x29, MASK_XLEN(0xffffbfffffffffff)
    c.mv x19, x29
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0xffffbfffffffffff) 
 
    # Testcase 19:  rd:x20(0x00080000), rs2:x28(0xffffdfffffffffff), result rd:x20(0xffffdfffffffffff)
    li  x20,  MASK_XLEN(0x80000)
    li  x28, MASK_XLEN(0xffffdfffffffffff)
    c.mv x20, x28
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0xffffdfffffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res

 
    # Testcase 20:  rd:x21(0x00100000), rs2:x27(0xffffefffffffffff), result rd:x21(0xffffefffffffffff)
    li  x21,  MASK_XLEN(0x100000)
    li  x27, MASK_XLEN(0xffffefffffffffff)
    c.mv x21, x27
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffefffffffffff) 
 
    # Testcase 21:  rd:x22(0x00200000), rs2:x26(0xfffff7ffffffffff), result rd:x22(0xfffff7ffffffffff)
    li  x22,  MASK_XLEN(0x200000)
    li  x26, MASK_XLEN(0xfffff7ffffffffff)
    c.mv x22, x26
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffff7ffffffffff) 
 
    # Testcase 22:  rd:x23(0x00400000), rs2:x25(0xfffffbffffffffff), result rd:x23(0xfffffbffffffffff)
    li  x23,  MASK_XLEN(0x400000)
    li  x25, MASK_XLEN(0xfffffbffffffffff)
    c.mv x23, x25
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffffbffffffffff) 
 
    # Testcase 23:  rd:x25(0x00800000), rs2:x24(0xfffffdffffffffff), result rd:x25(0xfffffdffffffffff)
    li  x25,  MASK_XLEN(0x800000)
    li  x24, MASK_XLEN(0xfffffdffffffffff)
    c.mv x25, x24
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffdffffffffff) 
 
    # Testcase 24:  rd:x25(0x01000000), rs2:x23(0xfffffeffffffffff), result rd:x25(0xfffffeffffffffff)
    li  x25,  MASK_XLEN(0x1000000)
    li  x23, MASK_XLEN(0xfffffeffffffffff)
    c.mv x25, x23
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffeffffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res

 
    # Testcase 25:  rd:x26(0x02000000), rs2:x22(0xffffff7fffffffff), result rd:x26(0xffffff7fffffffff)
    li  x26,  MASK_XLEN(0x2000000)
    li  x22, MASK_XLEN(0xffffff7fffffffff)
    c.mv x26, x22
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0xffffff7fffffffff) 
 
    # Testcase 26:  rd:x27(0x04000000), rs2:x21(0xffffffbfffffffff), result rd:x27(0xffffffbfffffffff)
    li  x27,  MASK_XLEN(0x4000000)
    li  x21, MASK_XLEN(0xffffffbfffffffff)
    c.mv x27, x21
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0xffffffbfffffffff) 
 
    # Testcase 27:  rd:x28(0x08000000), rs2:x20(0xffffffdfffffffff), result rd:x28(0xffffffdfffffffff)
    li  x28,  MASK_XLEN(0x8000000)
    li  x20, MASK_XLEN(0xffffffdfffffffff)
    c.mv x28, x20
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0xffffffdfffffffff) 
 
    # Testcase 28:  rd:x29(0x10000000), rs2:x19(0xffffffefffffffff), result rd:x29(0xffffffefffffffff)
    li  x29,  MASK_XLEN(0x10000000)
    li  x19, MASK_XLEN(0xffffffefffffffff)
    c.mv x29, x19
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0xffffffefffffffff) 
 
    # Testcase 29:  rd:x30(0x20000000), rs2:x18(0xfffffff7ffffffff), result rd:x30(0xfffffff7ffffffff)
    li  x30,  MASK_XLEN(0x20000000)
    li  x18, MASK_XLEN(0xfffffff7ffffffff)
    c.mv x30, x18
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0xfffffff7ffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res

 
    # Testcase 30:  rd:x31(0x40000000), rs2:x17(0xfffffffbffffffff), result rd:x31(0xfffffffbffffffff)
    li  x31,  MASK_XLEN(0x40000000)
    li  x17, MASK_XLEN(0xfffffffbffffffff)
    c.mv x31, x17
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xfffffffbffffffff) 
 
    # Testcase 31:  rd:x1(0x80000000), rs2:x16(0xfffffffdffffffff), result rd:x1(0xfffffffdffffffff)
    li  x1,  MASK_XLEN(0x80000000)
    li  x16, MASK_XLEN(0xfffffffdffffffff)
    c.mv x1, x16
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xfffffffdffffffff) 
 
    # Testcase 32:  rd:x2(0x100000000), rs2:x15(0xfffffffeffffffff), result rd:x2(0xfffffffeffffffff)
    li  x2,  MASK_XLEN(0x100000000)
    li  x15, MASK_XLEN(0xfffffffeffffffff)
    c.mv x2, x15
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xfffffffeffffffff) 
 
    # Testcase 33:  rd:x3(0x200000000), rs2:x14(0xffffffff7fffffff), result rd:x3(0xffffffff7fffffff)
    li  x3,  MASK_XLEN(0x200000000)
    li  x14, MASK_XLEN(0xffffffff7fffffff)
    c.mv x3, x14
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0xffffffff7fffffff) 
 
    # Testcase 34:  rd:x4(0x400000000), rs2:x13(0xffffffffbfffffff), result rd:x4(0xffffffffbfffffff)
    li  x4,  MASK_XLEN(0x400000000)
    li  x13, MASK_XLEN(0xffffffffbfffffff)
    c.mv x4, x13
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0xffffffffbfffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res

 
    # Testcase 35:  rd:x5(0x800000000), rs2:x12(0xffffffffdfffffff), result rd:x5(0xffffffffdfffffff)
    li  x5,  MASK_XLEN(0x800000000)
    li  x12, MASK_XLEN(0xffffffffdfffffff)
    c.mv x5, x12
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xffffffffdfffffff) 
 
    # Testcase 36:  rd:x6(0x1000000000), rs2:x11(0xffffffffefffffff), result rd:x6(0xffffffffefffffff)
    li  x6,  MASK_XLEN(0x1000000000)
    li  x11, MASK_XLEN(0xffffffffefffffff)
    c.mv x6, x11
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xffffffffefffffff) 
 
    # Testcase 37:  rd:x7(0x2000000000), rs2:x10(0xfffffffff7ffffff), result rd:x7(0xfffffffff7ffffff)
    li  x7,  MASK_XLEN(0x2000000000)
    li  x10, MASK_XLEN(0xfffffffff7ffffff)
    c.mv x7, x10
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffff7ffffff) 
 
    # Testcase 38:  rd:x8(0x4000000000), rs2:x9(0xfffffffffbffffff), result rd:x8(0xfffffffffbffffff)
    li  x8,  MASK_XLEN(0x4000000000)
    li  x9, MASK_XLEN(0xfffffffffbffffff)
    c.mv x8, x9
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffbffffff) 
 
    # Testcase 39:  rd:x9(0x8000000000), rs2:x8(0xfffffffffdffffff), result rd:x9(0xfffffffffdffffff)
    li  x9,  MASK_XLEN(0x8000000000)
    li  x8, MASK_XLEN(0xfffffffffdffffff)
    c.mv x9, x8
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffffdffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res

 
    # Testcase 40:  rd:x10(0x10000000000), rs2:x7(0xfffffffffeffffff), result rd:x10(0xfffffffffeffffff)
    li  x10,  MASK_XLEN(0x10000000000)
    li  x7, MASK_XLEN(0xfffffffffeffffff)
    c.mv x10, x7
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffffeffffff) 
 
    # Testcase 41:  rd:x11(0x20000000000), rs2:x6(0xffffffffff7fffff), result rd:x11(0xffffffffff7fffff)
    li  x11,  MASK_XLEN(0x20000000000)
    li  x6, MASK_XLEN(0xffffffffff7fffff)
    c.mv x11, x6
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffffff7fffff) 
 
    # Testcase 42:  rd:x12(0x40000000000), rs2:x5(0xffffffffffbfffff), result rd:x12(0xffffffffffbfffff)
    li  x12,  MASK_XLEN(0x40000000000)
    li  x5, MASK_XLEN(0xffffffffffbfffff)
    c.mv x12, x5
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffbfffff) 
 
    # Testcase 43:  rd:x13(0x80000000000), rs2:x4(0xffffffffffdfffff), result rd:x13(0xffffffffffdfffff)
    li  x13,  MASK_XLEN(0x80000000000)
    li  x4, MASK_XLEN(0xffffffffffdfffff)
    c.mv x13, x4
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffffffdfffff) 
 
    # Testcase 44:  rd:x14(0x100000000000), rs2:x3(0xffffffffffefffff), result rd:x14(0xffffffffffefffff)
    li  x14,  MASK_XLEN(0x100000000000)
    li  x3, MASK_XLEN(0xffffffffffefffff)
    c.mv x14, x3
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffffffefffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res

 
    # Testcase 45:  rd:x15(0x200000000000), rs2:x2(0xfffffffffff7ffff), result rd:x15(0xfffffffffff7ffff)
    li  x15,  MASK_XLEN(0x200000000000)
    li  x2, MASK_XLEN(0xfffffffffff7ffff)
    c.mv x15, x2
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0xfffffffffff7ffff) 
 
    # Testcase 46:  rd:x16(0x400000000000), rs2:x1(0xfffffffffffbffff), result rd:x16(0xfffffffffffbffff)
    li  x16,  MASK_XLEN(0x400000000000)
    li  x1, MASK_XLEN(0xfffffffffffbffff)
    c.mv x16, x1
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0xfffffffffffbffff) 
 
    # Testcase 47:  rd:x17(0x800000000000), rs2:x31(0xfffffffffffdffff), result rd:x17(0xfffffffffffdffff)
    li  x17,  MASK_XLEN(0x800000000000)
    li  x31, MASK_XLEN(0xfffffffffffdffff)
    c.mv x17, x31
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xfffffffffffdffff) 
 
    # Testcase 48:  rd:x18(0x1000000000000), rs2:x30(0xfffffffffffeffff), result rd:x18(0xfffffffffffeffff)
    li  x18,  MASK_XLEN(0x1000000000000)
    li  x30, MASK_XLEN(0xfffffffffffeffff)
    c.mv x18, x30
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0xfffffffffffeffff) 
 
    # Testcase 49:  rd:x19(0x2000000000000), rs2:x29(0xffffffffffff7fff), result rd:x19(0xffffffffffff7fff)
    li  x19,  MASK_XLEN(0x2000000000000)
    li  x29, MASK_XLEN(0xffffffffffff7fff)
    c.mv x19, x29
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xffffffffffff7fff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res

 
    # Testcase 50:  rd:x20(0x4000000000000), rs2:x28(0xffffffffffffbfff), result rd:x20(0xffffffffffffbfff)
    li  x20,  MASK_XLEN(0x4000000000000)
    li  x28, MASK_XLEN(0xffffffffffffbfff)
    c.mv x20, x28
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffffffffffffbfff) 
 
    # Testcase 51:  rd:x21(0x8000000000000), rs2:x27(0xffffffffffffdfff), result rd:x21(0xffffffffffffdfff)
    li  x21,  MASK_XLEN(0x8000000000000)
    li  x27, MASK_XLEN(0xffffffffffffdfff)
    c.mv x21, x27
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffffffffffdfff) 
 
    # Testcase 52:  rd:x22(0x10000000000000), rs2:x26(0xffffffffffffefff), result rd:x22(0xffffffffffffefff)
    li  x22,  MASK_XLEN(0x10000000000000)
    li  x26, MASK_XLEN(0xffffffffffffefff)
    c.mv x22, x26
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffffffffffffefff) 
 
    # Testcase 53:  rd:x23(0x20000000000000), rs2:x25(0xfffffffffffff7ff), result rd:x23(0xfffffffffffff7ff)
    li  x23,  MASK_XLEN(0x20000000000000)
    li  x25, MASK_XLEN(0xfffffffffffff7ff)
    c.mv x23, x25
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffffffffffff7ff) 
 
    # Testcase 54:  rd:x25(0x40000000000000), rs2:x24(0xfffffffffffffbff), result rd:x25(0xfffffffffffffbff)
    li  x25,  MASK_XLEN(0x40000000000000)
    li  x24, MASK_XLEN(0xfffffffffffffbff)
    c.mv x25, x24
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffffffffffbff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res

 
    # Testcase 55:  rd:x25(0x80000000000000), rs2:x23(0xfffffffffffffdff), result rd:x25(0xfffffffffffffdff)
    li  x25,  MASK_XLEN(0x80000000000000)
    li  x23, MASK_XLEN(0xfffffffffffffdff)
    c.mv x25, x23
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffffffffffdff) 
 
    # Testcase 56:  rd:x26(0x100000000000000), rs2:x22(0xfffffffffffffeff), result rd:x26(0xfffffffffffffeff)
    li  x26,  MASK_XLEN(0x100000000000000)
    li  x22, MASK_XLEN(0xfffffffffffffeff)
    c.mv x26, x22
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xfffffffffffffeff) 
 
    # Testcase 57:  rd:x27(0x200000000000000), rs2:x21(0xffffffffffffff7f), result rd:x27(0xffffffffffffff7f)
    li  x27,  MASK_XLEN(0x200000000000000)
    li  x21, MASK_XLEN(0xffffffffffffff7f)
    c.mv x27, x21
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffffffffffffff7f) 
 
    # Testcase 58:  rd:x28(0x400000000000000), rs2:x20(0xffffffffffffffbf), result rd:x28(0xffffffffffffffbf)
    li  x28,  MASK_XLEN(0x400000000000000)
    li  x20, MASK_XLEN(0xffffffffffffffbf)
    c.mv x28, x20
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xffffffffffffffbf) 
 
    # Testcase 59:  rd:x29(0x800000000000000), rs2:x19(0xffffffffffffffdf), result rd:x29(0xffffffffffffffdf)
    li  x29,  MASK_XLEN(0x800000000000000)
    li  x19, MASK_XLEN(0xffffffffffffffdf)
    c.mv x29, x19
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xffffffffffffffdf) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res

 
    # Testcase 60:  rd:x30(0x1000000000000000), rs2:x18(0xffffffffffffffef), result rd:x30(0xffffffffffffffef)
    li  x30,  MASK_XLEN(0x1000000000000000)
    li  x18, MASK_XLEN(0xffffffffffffffef)
    c.mv x30, x18
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xffffffffffffffef) 
 
    # Testcase 61:  rd:x31(0x2000000000000000), rs2:x17(0xfffffffffffffff7), result rd:x31(0xfffffffffffffff7)
    li  x31,  MASK_XLEN(0x2000000000000000)
    li  x17, MASK_XLEN(0xfffffffffffffff7)
    c.mv x31, x17
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xfffffffffffffff7) 
 
    # Testcase 62:  rd:x1(0x4000000000000000), rs2:x16(0xfffffffffffffffb), result rd:x1(0xfffffffffffffffb)
    li  x1,  MASK_XLEN(0x4000000000000000)
    li  x16, MASK_XLEN(0xfffffffffffffffb)
    c.mv x1, x16
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xfffffffffffffffb) 
 
    # Testcase 63:  rd:x2(0x8000000000000000), rs2:x15(0xfffffffffffffffd), result rd:x2(0xfffffffffffffffd)
    li  x2,  MASK_XLEN(0x8000000000000000)
    li  x15, MASK_XLEN(0xfffffffffffffffd)
    c.mv x2, x15
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xfffffffffffffffd) 
 
    # Testcase 64:  rd:x3(0x00000000), rs2:x14(0xfffffffffffffffe), result rd:x3(0xfffffffffffffffe)
    li  x3,  MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffffffffffffffe)
    c.mv x3, x14
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xfffffffffffffffe) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res

 
    # Testcase 65:  rd:x4(0xfffffffffffffffe), rs2:x13(0x00000000), result rd:x4(0x00000000)
    li  x4,  MASK_XLEN(0xfffffffffffffffe)
    li  x13, MASK_XLEN(0x0)
    c.mv x4, x13
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x0) 
 
    # Testcase 66:  rd:x5(0xfffffffffffffffd), rs2:x12(0x8000000000000000), result rd:x5(0x8000000000000000)
    li  x5,  MASK_XLEN(0xfffffffffffffffd)
    li  x12, MASK_XLEN(0x8000000000000000)
    c.mv x5, x12
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x8000000000000000) 
 
    # Testcase 67:  rd:x6(0xfffffffffffffffb), rs2:x11(0x4000000000000000), result rd:x6(0x4000000000000000)
    li  x6,  MASK_XLEN(0xfffffffffffffffb)
    li  x11, MASK_XLEN(0x4000000000000000)
    c.mv x6, x11
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x4000000000000000) 
 
    # Testcase 68:  rd:x7(0xfffffffffffffff7), rs2:x10(0x2000000000000000), result rd:x7(0x2000000000000000)
    li  x7,  MASK_XLEN(0xfffffffffffffff7)
    li  x10, MASK_XLEN(0x2000000000000000)
    c.mv x7, x10
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x2000000000000000) 
 
    # Testcase 69:  rd:x8(0xffffffffffffffef), rs2:x9(0x1000000000000000), result rd:x8(0x1000000000000000)
    li  x8,  MASK_XLEN(0xffffffffffffffef)
    li  x9, MASK_XLEN(0x1000000000000000)
    c.mv x8, x9
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1000000000000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res

 
    # Testcase 70:  rd:x9(0xffffffffffffffdf), rs2:x8(0x800000000000000), result rd:x9(0x800000000000000)
    li  x9,  MASK_XLEN(0xffffffffffffffdf)
    li  x8, MASK_XLEN(0x800000000000000)
    c.mv x9, x8
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x800000000000000) 
 
    # Testcase 71:  rd:x10(0xffffffffffffffbf), rs2:x7(0x400000000000000), result rd:x10(0x400000000000000)
    li  x10,  MASK_XLEN(0xffffffffffffffbf)
    li  x7, MASK_XLEN(0x400000000000000)
    c.mv x10, x7
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x400000000000000) 
 
    # Testcase 72:  rd:x11(0xffffffffffffff7f), rs2:x6(0x200000000000000), result rd:x11(0x200000000000000)
    li  x11,  MASK_XLEN(0xffffffffffffff7f)
    li  x6, MASK_XLEN(0x200000000000000)
    c.mv x11, x6
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x200000000000000) 
 
    # Testcase 73:  rd:x12(0xfffffffffffffeff), rs2:x5(0x100000000000000), result rd:x12(0x100000000000000)
    li  x12,  MASK_XLEN(0xfffffffffffffeff)
    li  x5, MASK_XLEN(0x100000000000000)
    c.mv x12, x5
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x100000000000000) 
 
    # Testcase 74:  rd:x13(0xfffffffffffffdff), rs2:x4(0x80000000000000), result rd:x13(0x80000000000000)
    li  x13,  MASK_XLEN(0xfffffffffffffdff)
    li  x4, MASK_XLEN(0x80000000000000)
    c.mv x13, x4
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x80000000000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res

 
    # Testcase 75:  rd:x14(0xfffffffffffffbff), rs2:x3(0x40000000000000), result rd:x14(0x40000000000000)
    li  x14,  MASK_XLEN(0xfffffffffffffbff)
    li  x3, MASK_XLEN(0x40000000000000)
    c.mv x14, x3
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x40000000000000) 
 
    # Testcase 76:  rd:x15(0xfffffffffffff7ff), rs2:x2(0x20000000000000), result rd:x15(0x20000000000000)
    li  x15,  MASK_XLEN(0xfffffffffffff7ff)
    li  x2, MASK_XLEN(0x20000000000000)
    c.mv x15, x2
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x20000000000000) 
 
    # Testcase 77:  rd:x16(0xffffffffffffefff), rs2:x1(0x10000000000000), result rd:x16(0x10000000000000)
    li  x16,  MASK_XLEN(0xffffffffffffefff)
    li  x1, MASK_XLEN(0x10000000000000)
    c.mv x16, x1
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x10000000000000) 
 
    # Testcase 78:  rd:x17(0xffffffffffffdfff), rs2:x31(0x8000000000000), result rd:x17(0x8000000000000)
    li  x17,  MASK_XLEN(0xffffffffffffdfff)
    li  x31, MASK_XLEN(0x8000000000000)
    c.mv x17, x31
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x8000000000000) 
 
    # Testcase 79:  rd:x18(0xffffffffffffbfff), rs2:x30(0x4000000000000), result rd:x18(0x4000000000000)
    li  x18,  MASK_XLEN(0xffffffffffffbfff)
    li  x30, MASK_XLEN(0x4000000000000)
    c.mv x18, x30
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x4000000000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res

 
    # Testcase 80:  rd:x19(0xffffffffffff7fff), rs2:x29(0x2000000000000), result rd:x19(0x2000000000000)
    li  x19,  MASK_XLEN(0xffffffffffff7fff)
    li  x29, MASK_XLEN(0x2000000000000)
    c.mv x19, x29
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x2000000000000) 
 
    # Testcase 81:  rd:x20(0xfffffffffffeffff), rs2:x28(0x1000000000000), result rd:x20(0x1000000000000)
    li  x20,  MASK_XLEN(0xfffffffffffeffff)
    li  x28, MASK_XLEN(0x1000000000000)
    c.mv x20, x28
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x1000000000000) 
 
    # Testcase 82:  rd:x21(0xfffffffffffdffff), rs2:x27(0x800000000000), result rd:x21(0x800000000000)
    li  x21,  MASK_XLEN(0xfffffffffffdffff)
    li  x27, MASK_XLEN(0x800000000000)
    c.mv x21, x27
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x800000000000) 
 
    # Testcase 83:  rd:x22(0xfffffffffffbffff), rs2:x26(0x400000000000), result rd:x22(0x400000000000)
    li  x22,  MASK_XLEN(0xfffffffffffbffff)
    li  x26, MASK_XLEN(0x400000000000)
    c.mv x22, x26
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x400000000000) 
 
    # Testcase 84:  rd:x23(0xfffffffffff7ffff), rs2:x25(0x200000000000), result rd:x23(0x200000000000)
    li  x23,  MASK_XLEN(0xfffffffffff7ffff)
    li  x25, MASK_XLEN(0x200000000000)
    c.mv x23, x25
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x200000000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res

 
    # Testcase 85:  rd:x25(0xffffffffffefffff), rs2:x24(0x100000000000), result rd:x25(0x100000000000)
    li  x25,  MASK_XLEN(0xffffffffffefffff)
    li  x24, MASK_XLEN(0x100000000000)
    c.mv x25, x24
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x100000000000) 
 
    # Testcase 86:  rd:x25(0xffffffffffdfffff), rs2:x23(0x80000000000), result rd:x25(0x80000000000)
    li  x25,  MASK_XLEN(0xffffffffffdfffff)
    li  x23, MASK_XLEN(0x80000000000)
    c.mv x25, x23
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x80000000000) 
 
    # Testcase 87:  rd:x26(0xffffffffffbfffff), rs2:x22(0x40000000000), result rd:x26(0x40000000000)
    li  x26,  MASK_XLEN(0xffffffffffbfffff)
    li  x22, MASK_XLEN(0x40000000000)
    c.mv x26, x22
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x40000000000) 
 
    # Testcase 88:  rd:x27(0xffffffffff7fffff), rs2:x21(0x20000000000), result rd:x27(0x20000000000)
    li  x27,  MASK_XLEN(0xffffffffff7fffff)
    li  x21, MASK_XLEN(0x20000000000)
    c.mv x27, x21
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x20000000000) 
 
    # Testcase 89:  rd:x28(0xfffffffffeffffff), rs2:x20(0x10000000000), result rd:x28(0x10000000000)
    li  x28,  MASK_XLEN(0xfffffffffeffffff)
    li  x20, MASK_XLEN(0x10000000000)
    c.mv x28, x20
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x10000000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res

 
    # Testcase 90:  rd:x29(0xfffffffffdffffff), rs2:x19(0x8000000000), result rd:x29(0x8000000000)
    li  x29,  MASK_XLEN(0xfffffffffdffffff)
    li  x19, MASK_XLEN(0x8000000000)
    c.mv x29, x19
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x8000000000) 
 
    # Testcase 91:  rd:x30(0xfffffffffbffffff), rs2:x18(0x4000000000), result rd:x30(0x4000000000)
    li  x30,  MASK_XLEN(0xfffffffffbffffff)
    li  x18, MASK_XLEN(0x4000000000)
    c.mv x30, x18
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x4000000000) 
 
    # Testcase 92:  rd:x31(0xfffffffff7ffffff), rs2:x17(0x2000000000), result rd:x31(0x2000000000)
    li  x31,  MASK_XLEN(0xfffffffff7ffffff)
    li  x17, MASK_XLEN(0x2000000000)
    c.mv x31, x17
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x2000000000) 
 
    # Testcase 93:  rd:x1(0xffffffffefffffff), rs2:x16(0x1000000000), result rd:x1(0x1000000000)
    li  x1,  MASK_XLEN(0xffffffffefffffff)
    li  x16, MASK_XLEN(0x1000000000)
    c.mv x1, x16
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x1000000000) 
 
    # Testcase 94:  rd:x2(0xffffffffdfffffff), rs2:x15(0x800000000), result rd:x2(0x800000000)
    li  x2,  MASK_XLEN(0xffffffffdfffffff)
    li  x15, MASK_XLEN(0x800000000)
    c.mv x2, x15
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x800000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res

 
    # Testcase 95:  rd:x3(0xffffffffbfffffff), rs2:x14(0x400000000), result rd:x3(0x400000000)
    li  x3,  MASK_XLEN(0xffffffffbfffffff)
    li  x14, MASK_XLEN(0x400000000)
    c.mv x3, x14
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x400000000) 
 
    # Testcase 96:  rd:x4(0xffffffff7fffffff), rs2:x13(0x200000000), result rd:x4(0x200000000)
    li  x4,  MASK_XLEN(0xffffffff7fffffff)
    li  x13, MASK_XLEN(0x200000000)
    c.mv x4, x13
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x200000000) 
 
    # Testcase 97:  rd:x5(0xfffffffeffffffff), rs2:x12(0x100000000), result rd:x5(0x100000000)
    li  x5,  MASK_XLEN(0xfffffffeffffffff)
    li  x12, MASK_XLEN(0x100000000)
    c.mv x5, x12
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x100000000) 
 
    # Testcase 98:  rd:x6(0xfffffffdffffffff), rs2:x11(0x80000000), result rd:x6(0x80000000)
    li  x6,  MASK_XLEN(0xfffffffdffffffff)
    li  x11, MASK_XLEN(0x80000000)
    c.mv x6, x11
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x80000000) 
 
    # Testcase 99:  rd:x7(0xfffffffbffffffff), rs2:x10(0x40000000), result rd:x7(0x40000000)
    li  x7,  MASK_XLEN(0xfffffffbffffffff)
    li  x10, MASK_XLEN(0x40000000)
    c.mv x7, x10
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x40000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res

 
    # Testcase 100:  rd:x8(0xfffffff7ffffffff), rs2:x9(0x20000000), result rd:x8(0x20000000)
    li  x8,  MASK_XLEN(0xfffffff7ffffffff)
    li  x9, MASK_XLEN(0x20000000)
    c.mv x8, x9
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000000) 
 
    # Testcase 101:  rd:x9(0xffffffefffffffff), rs2:x8(0x10000000), result rd:x9(0x10000000)
    li  x9,  MASK_XLEN(0xffffffefffffffff)
    li  x8, MASK_XLEN(0x10000000)
    c.mv x9, x8
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x10000000) 
 
    # Testcase 102:  rd:x10(0xffffffdfffffffff), rs2:x7(0x08000000), result rd:x10(0x08000000)
    li  x10,  MASK_XLEN(0xffffffdfffffffff)
    li  x7, MASK_XLEN(0x8000000)
    c.mv x10, x7
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000000) 
 
    # Testcase 103:  rd:x11(0xffffffbfffffffff), rs2:x6(0x04000000), result rd:x11(0x04000000)
    li  x11,  MASK_XLEN(0xffffffbfffffffff)
    li  x6, MASK_XLEN(0x4000000)
    c.mv x11, x6
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x4000000) 
 
    # Testcase 104:  rd:x12(0xffffff7fffffffff), rs2:x5(0x02000000), result rd:x12(0x02000000)
    li  x12,  MASK_XLEN(0xffffff7fffffffff)
    li  x5, MASK_XLEN(0x2000000)
    c.mv x12, x5
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res

 
    # Testcase 105:  rd:x13(0xfffffeffffffffff), rs2:x4(0x01000000), result rd:x13(0x01000000)
    li  x13,  MASK_XLEN(0xfffffeffffffffff)
    li  x4, MASK_XLEN(0x1000000)
    c.mv x13, x4
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x1000000) 
 
    # Testcase 106:  rd:x14(0xfffffdffffffffff), rs2:x3(0x00800000), result rd:x14(0x00800000)
    li  x14,  MASK_XLEN(0xfffffdffffffffff)
    li  x3, MASK_XLEN(0x800000)
    c.mv x14, x3
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x800000) 
 
    # Testcase 107:  rd:x15(0xfffffbffffffffff), rs2:x2(0x00400000), result rd:x15(0x00400000)
    li  x15,  MASK_XLEN(0xfffffbffffffffff)
    li  x2, MASK_XLEN(0x400000)
    c.mv x15, x2
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x400000) 
 
    # Testcase 108:  rd:x16(0xfffff7ffffffffff), rs2:x1(0x00200000), result rd:x16(0x00200000)
    li  x16,  MASK_XLEN(0xfffff7ffffffffff)
    li  x1, MASK_XLEN(0x200000)
    c.mv x16, x1
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x200000) 
 
    # Testcase 109:  rd:x17(0xffffefffffffffff), rs2:x31(0x00100000), result rd:x17(0x00100000)
    li  x17,  MASK_XLEN(0xffffefffffffffff)
    li  x31, MASK_XLEN(0x100000)
    c.mv x17, x31
    sd x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x100000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res

 
    # Testcase 110:  rd:x18(0xffffdfffffffffff), rs2:x30(0x00080000), result rd:x18(0x00080000)
    li  x18,  MASK_XLEN(0xffffdfffffffffff)
    li  x30, MASK_XLEN(0x80000)
    c.mv x18, x30
    sd x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x80000) 
 
    # Testcase 111:  rd:x19(0xffffbfffffffffff), rs2:x29(0x00040000), result rd:x19(0x00040000)
    li  x19,  MASK_XLEN(0xffffbfffffffffff)
    li  x29, MASK_XLEN(0x40000)
    c.mv x19, x29
    sd x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x40000) 
 
    # Testcase 112:  rd:x20(0xffff7fffffffffff), rs2:x28(0x00020000), result rd:x20(0x00020000)
    li  x20,  MASK_XLEN(0xffff7fffffffffff)
    li  x28, MASK_XLEN(0x20000)
    c.mv x20, x28
    sd x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x20000) 
 
    # Testcase 113:  rd:x21(0xfffeffffffffffff), rs2:x27(0x00010000), result rd:x21(0x00010000)
    li  x21,  MASK_XLEN(0xfffeffffffffffff)
    li  x27, MASK_XLEN(0x10000)
    c.mv x21, x27
    sd x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x10000) 
 
    # Testcase 114:  rd:x22(0xfffdffffffffffff), rs2:x26(0x00008000), result rd:x22(0x00008000)
    li  x22,  MASK_XLEN(0xfffdffffffffffff)
    li  x26, MASK_XLEN(0x8000)
    c.mv x22, x26
    sd x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x8000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res

 
    # Testcase 115:  rd:x23(0xfffbffffffffffff), rs2:x25(0x00004000), result rd:x23(0x00004000)
    li  x23,  MASK_XLEN(0xfffbffffffffffff)
    li  x25, MASK_XLEN(0x4000)
    c.mv x23, x25
    sd x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x4000) 
 
    # Testcase 116:  rd:x25(0xfff7ffffffffffff), rs2:x24(0x00002000), result rd:x25(0x00002000)
    li  x25,  MASK_XLEN(0xfff7ffffffffffff)
    li  x24, MASK_XLEN(0x2000)
    c.mv x25, x24
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x2000) 
 
    # Testcase 117:  rd:x25(0xffefffffffffffff), rs2:x23(0x00001000), result rd:x25(0x00001000)
    li  x25,  MASK_XLEN(0xffefffffffffffff)
    li  x23, MASK_XLEN(0x1000)
    c.mv x25, x23
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x1000) 
 
    # Testcase 118:  rd:x26(0xffdfffffffffffff), rs2:x22(0x00000800), result rd:x26(0x00000800)
    li  x26,  MASK_XLEN(0xffdfffffffffffff)
    li  x22, MASK_XLEN(0x800)
    c.mv x26, x22
    sd x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x800) 
 
    # Testcase 119:  rd:x27(0xffbfffffffffffff), rs2:x21(0x00000400), result rd:x27(0x00000400)
    li  x27,  MASK_XLEN(0xffbfffffffffffff)
    li  x21, MASK_XLEN(0x400)
    c.mv x27, x21
    sd x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x400) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res

 
    # Testcase 120:  rd:x28(0xff7fffffffffffff), rs2:x20(0x00000200), result rd:x28(0x00000200)
    li  x28,  MASK_XLEN(0xff7fffffffffffff)
    li  x20, MASK_XLEN(0x200)
    c.mv x28, x20
    sd x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0x200) 
 
    # Testcase 121:  rd:x29(0xfeffffffffffffff), rs2:x19(0x00000100), result rd:x29(0x00000100)
    li  x29,  MASK_XLEN(0xfeffffffffffffff)
    li  x19, MASK_XLEN(0x100)
    c.mv x29, x19
    sd x29, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x100) 
 
    # Testcase 122:  rd:x30(0xfdffffffffffffff), rs2:x18(0x00000080), result rd:x30(0x00000080)
    li  x30,  MASK_XLEN(0xfdffffffffffffff)
    li  x18, MASK_XLEN(0x80)
    c.mv x30, x18
    sd x30, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x80) 
 
    # Testcase 123:  rd:x31(0xfbffffffffffffff), rs2:x17(0x00000040), result rd:x31(0x00000040)
    li  x31,  MASK_XLEN(0xfbffffffffffffff)
    li  x17, MASK_XLEN(0x40)
    c.mv x31, x17
    sd x31, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x40) 
 
    # Testcase 124:  rd:x1(0xf7ffffffffffffff), rs2:x16(0x00000020), result rd:x1(0x00000020)
    li  x1,  MASK_XLEN(0xf7ffffffffffffff)
    li  x16, MASK_XLEN(0x20)
    c.mv x1, x16
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x20) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res

 
    # Testcase 125:  rd:x2(0xefffffffffffffff), rs2:x15(0x00000010), result rd:x2(0x00000010)
    li  x2,  MASK_XLEN(0xefffffffffffffff)
    li  x15, MASK_XLEN(0x10)
    c.mv x2, x15
    sd x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x10) 
 
    # Testcase 126:  rd:x3(0xdfffffffffffffff), rs2:x14(0x00000008), result rd:x3(0x00000008)
    li  x3,  MASK_XLEN(0xdfffffffffffffff)
    li  x14, MASK_XLEN(0x8)
    c.mv x3, x14
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x8) 
 
    # Testcase 127:  rd:x4(0xbfffffffffffffff), rs2:x13(0x00000004), result rd:x4(0x00000004)
    li  x4,  MASK_XLEN(0xbfffffffffffffff)
    li  x13, MASK_XLEN(0x4)
    c.mv x4, x13
    sd x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x4) 
 
    # Testcase 128:  rd:x5(0x7fffffffffffffff), rs2:x12(0x00000002), result rd:x5(0x00000002)
    li  x5,  MASK_XLEN(0x7fffffffffffffff)
    li  x12, MASK_XLEN(0x2)
    c.mv x5, x12
    sd x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x2) 
 
    # Testcase 129:  rd:x6(0xffffffffffffffff), rs2:x11(0x00000001), result rd:x6(0x00000001)
    li  x6,  MASK_XLEN(0xffffffffffffffff)
    li  x11, MASK_XLEN(0x1)
    c.mv x6, x11
    sd x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0x1) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res

 
    # Testcase 130:  rd:x7(0x00000001), rs2:x10(0x00000000), result rd:x7(0x00000000)
    li  x7,  MASK_XLEN(0x1)
    li  x10, MASK_XLEN(0x0)
    c.mv x7, x10
    sd x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0) 
 
    # Testcase 131:  rd:x8(0x00000002), rs2:x9(0x00000000), result rd:x8(0x00000000)
    li  x8,  MASK_XLEN(0x2)
    li  x9, MASK_XLEN(0x0)
    c.mv x8, x9
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 132:  rd:x9(0x00000004), rs2:x8(0x00000000), result rd:x9(0x00000000)
    li  x9,  MASK_XLEN(0x4)
    li  x8, MASK_XLEN(0x0)
    c.mv x9, x8
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 133:  rd:x10(0x00000008), rs2:x7(0x00000000), result rd:x10(0x00000000)
    li  x10,  MASK_XLEN(0x8)
    li  x7, MASK_XLEN(0x0)
    c.mv x10, x7
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 134:  rd:x11(0x00000010), rs2:x6(0x00000000), result rd:x11(0x00000000)
    li  x11,  MASK_XLEN(0x10)
    li  x6, MASK_XLEN(0x0)
    c.mv x11, x6
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res

 
    # Testcase 135:  rd:x12(0x00000020), rs2:x5(0x00000000), result rd:x12(0x00000000)
    li  x12,  MASK_XLEN(0x20)
    li  x5, MASK_XLEN(0x0)
    c.mv x12, x5
    sd x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x0) 
 
    # Testcase 136:  rd:x13(0x00000040), rs2:x4(0x00000000), result rd:x13(0x00000000)
    li  x13,  MASK_XLEN(0x40)
    li  x4, MASK_XLEN(0x0)
    c.mv x13, x4
    sd x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0) 
 
    # Testcase 137:  rd:x14(0x00000080), rs2:x3(0x00000000), result rd:x14(0x00000000)
    li  x14,  MASK_XLEN(0x80)
    li  x3, MASK_XLEN(0x0)
    c.mv x14, x3
    sd x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0) 
 
    # Testcase 138:  rd:x15(0x00000100), rs2:x2(0x00000000), result rd:x15(0x00000000)
    li  x15,  MASK_XLEN(0x100)
    li  x2, MASK_XLEN(0x0)
    c.mv x15, x2
    sd x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0) 
 
    # Testcase 139:  rd:x16(0x00000200), rs2:x1(0x00000000), result rd:x16(0x00000000)
    li  x16,  MASK_XLEN(0x200)
    li  x1, MASK_XLEN(0x0)
    c.mv x16, x1
    sd x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res

 
    # Testcase 140:  rd:x17(0x00000400), rs2:x31(0x00000000), result rd:x17(0x00000000)
    li  x17,  MASK_XLEN(0x400)
    li  x31, MASK_XLEN(0x0)
    c.mv x17, x31
    sd x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x17, 0x0) 
 
    # Testcase 141:  rd:x18(0x00000800), rs2:x30(0x00000000), result rd:x18(0x00000000)
    li  x18,  MASK_XLEN(0x800)
    li  x30, MASK_XLEN(0x0)
    c.mv x18, x30
    sd x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x0) 
 
    # Testcase 142:  rd:x19(0x00001000), rs2:x29(0x00000000), result rd:x19(0x00000000)
    li  x19,  MASK_XLEN(0x1000)
    li  x29, MASK_XLEN(0x0)
    c.mv x19, x29
    sd x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0) 
 
    # Testcase 143:  rd:x20(0x00002000), rs2:x28(0x00000000), result rd:x20(0x00000000)
    li  x20,  MASK_XLEN(0x2000)
    li  x28, MASK_XLEN(0x0)
    c.mv x20, x28
    sd x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0) 
 
    # Testcase 144:  rd:x21(0x00004000), rs2:x27(0x00000000), result rd:x21(0x00000000)
    li  x21,  MASK_XLEN(0x4000)
    li  x27, MASK_XLEN(0x0)
    c.mv x21, x27
    sd x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res

 
    # Testcase 145:  rd:x22(0x00008000), rs2:x26(0x00000000), result rd:x22(0x00000000)
    li  x22,  MASK_XLEN(0x8000)
    li  x26, MASK_XLEN(0x0)
    c.mv x22, x26
    sd x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0) 
 
    # Testcase 146:  rd:x23(0x00010000), rs2:x25(0x00000000), result rd:x23(0x00000000)
    li  x23,  MASK_XLEN(0x10000)
    li  x25, MASK_XLEN(0x0)
    c.mv x23, x25
    sd x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0) 
 
    # Testcase 147:  rd:x25(0x00020000), rs2:x24(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0x20000)
    li  x24, MASK_XLEN(0x0)
    c.mv x25, x24
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 
 
    # Testcase 148:  rd:x25(0x00040000), rs2:x23(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0x40000)
    li  x23, MASK_XLEN(0x0)
    c.mv x25, x23
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 
 
    # Testcase 149:  rd:x26(0x00080000), rs2:x22(0x00000000), result rd:x26(0x00000000)
    li  x26,  MASK_XLEN(0x80000)
    li  x22, MASK_XLEN(0x0)
    c.mv x26, x22
    sd x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x6, test_31_res

 
    # Testcase 150:  rd:x27(0x00100000), rs2:x21(0x00000000), result rd:x27(0x00000000)
    li  x27,  MASK_XLEN(0x100000)
    li  x21, MASK_XLEN(0x0)
    c.mv x27, x21
    sd x27, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x0) 
 
    # Testcase 151:  rd:x28(0x00200000), rs2:x20(0x00000000), result rd:x28(0x00000000)
    li  x28,  MASK_XLEN(0x200000)
    li  x20, MASK_XLEN(0x0)
    c.mv x28, x20
    sd x28, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x0) 
 
    # Testcase 152:  rd:x29(0x00400000), rs2:x19(0x00000000), result rd:x29(0x00000000)
    li  x29,  MASK_XLEN(0x400000)
    li  x19, MASK_XLEN(0x0)
    c.mv x29, x19
    sd x29, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x0) 
 
    # Testcase 153:  rd:x30(0x00800000), rs2:x18(0x00000000), result rd:x30(0x00000000)
    li  x30,  MASK_XLEN(0x800000)
    li  x18, MASK_XLEN(0x0)
    c.mv x30, x18
    sd x30, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x0) 
 
    # Testcase 154:  rd:x31(0x01000000), rs2:x17(0x00000000), result rd:x31(0x00000000)
    li  x31,  MASK_XLEN(0x1000000)
    li  x17, MASK_XLEN(0x0)
    c.mv x31, x17
    sd x31, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x6, test_32_res

 
    # Testcase 155:  rd:x1(0x02000000), rs2:x16(0x00000000), result rd:x1(0x00000000)
    li  x1,  MASK_XLEN(0x2000000)
    li  x16, MASK_XLEN(0x0)
    c.mv x1, x16
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x0) 
 
    # Testcase 156:  rd:x2(0x04000000), rs2:x15(0x00000000), result rd:x2(0x00000000)
    li  x2,  MASK_XLEN(0x4000000)
    li  x15, MASK_XLEN(0x0)
    c.mv x2, x15
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x0) 
 
    # Testcase 157:  rd:x3(0x08000000), rs2:x14(0x00000000), result rd:x3(0x00000000)
    li  x3,  MASK_XLEN(0x8000000)
    li  x14, MASK_XLEN(0x0)
    c.mv x3, x14
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0) 
 
    # Testcase 158:  rd:x4(0x10000000), rs2:x13(0x00000000), result rd:x4(0x00000000)
    li  x4,  MASK_XLEN(0x10000000)
    li  x13, MASK_XLEN(0x0)
    c.mv x4, x13
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x0) 
 
    # Testcase 159:  rd:x5(0x20000000), rs2:x12(0x00000000), result rd:x5(0x00000000)
    li  x5,  MASK_XLEN(0x20000000)
    li  x12, MASK_XLEN(0x0)
    c.mv x5, x12
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res

 
    # Testcase 160:  rd:x6(0x40000000), rs2:x11(0x00000000), result rd:x6(0x00000000)
    li  x6,  MASK_XLEN(0x40000000)
    li  x11, MASK_XLEN(0x0)
    c.mv x6, x11
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0) 
 
    # Testcase 161:  rd:x7(0x80000000), rs2:x10(0x00000000), result rd:x7(0x00000000)
    li  x7,  MASK_XLEN(0x80000000)
    li  x10, MASK_XLEN(0x0)
    c.mv x7, x10
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0) 
 
    # Testcase 162:  rd:x8(0x100000000), rs2:x9(0x00000000), result rd:x8(0x00000000)
    li  x8,  MASK_XLEN(0x100000000)
    li  x9, MASK_XLEN(0x0)
    c.mv x8, x9
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 163:  rd:x9(0x200000000), rs2:x8(0x00000000), result rd:x9(0x00000000)
    li  x9,  MASK_XLEN(0x200000000)
    li  x8, MASK_XLEN(0x0)
    c.mv x9, x8
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 164:  rd:x10(0x400000000), rs2:x7(0x00000000), result rd:x10(0x00000000)
    li  x10,  MASK_XLEN(0x400000000)
    li  x7, MASK_XLEN(0x0)
    c.mv x10, x7
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res

 
    # Testcase 165:  rd:x11(0x800000000), rs2:x6(0x00000000), result rd:x11(0x00000000)
    li  x11,  MASK_XLEN(0x800000000)
    li  x6, MASK_XLEN(0x0)
    c.mv x11, x6
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x0) 
 
    # Testcase 166:  rd:x12(0x1000000000), rs2:x5(0x00000000), result rd:x12(0x00000000)
    li  x12,  MASK_XLEN(0x1000000000)
    li  x5, MASK_XLEN(0x0)
    c.mv x12, x5
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x0) 
 
    # Testcase 167:  rd:x13(0x2000000000), rs2:x4(0x00000000), result rd:x13(0x00000000)
    li  x13,  MASK_XLEN(0x2000000000)
    li  x4, MASK_XLEN(0x0)
    c.mv x13, x4
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0) 
 
    # Testcase 168:  rd:x14(0x4000000000), rs2:x3(0x00000000), result rd:x14(0x00000000)
    li  x14,  MASK_XLEN(0x4000000000)
    li  x3, MASK_XLEN(0x0)
    c.mv x14, x3
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0) 
 
    # Testcase 169:  rd:x15(0x8000000000), rs2:x2(0x00000000), result rd:x15(0x00000000)
    li  x15,  MASK_XLEN(0x8000000000)
    li  x2, MASK_XLEN(0x0)
    c.mv x15, x2
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x2, test_35_res

 
    # Testcase 170:  rd:x16(0x10000000000), rs2:x1(0x00000000), result rd:x16(0x00000000)
    li  x16,  MASK_XLEN(0x10000000000)
    li  x1, MASK_XLEN(0x0)
    c.mv x16, x1
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x0) 
 
    # Testcase 171:  rd:x17(0x20000000000), rs2:x31(0x00000000), result rd:x17(0x00000000)
    li  x17,  MASK_XLEN(0x20000000000)
    li  x31, MASK_XLEN(0x0)
    c.mv x17, x31
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x0) 
 
    # Testcase 172:  rd:x18(0x40000000000), rs2:x30(0x00000000), result rd:x18(0x00000000)
    li  x18,  MASK_XLEN(0x40000000000)
    li  x30, MASK_XLEN(0x0)
    c.mv x18, x30
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x0) 
 
    # Testcase 173:  rd:x19(0x80000000000), rs2:x29(0x00000000), result rd:x19(0x00000000)
    li  x19,  MASK_XLEN(0x80000000000)
    li  x29, MASK_XLEN(0x0)
    c.mv x19, x29
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x0) 
 
    # Testcase 174:  rd:x20(0x100000000000), rs2:x28(0x00000000), result rd:x20(0x00000000)
    li  x20,  MASK_XLEN(0x100000000000)
    li  x28, MASK_XLEN(0x0)
    c.mv x20, x28
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res

 
    # Testcase 175:  rd:x21(0x200000000000), rs2:x27(0x00000000), result rd:x21(0x00000000)
    li  x21,  MASK_XLEN(0x200000000000)
    li  x27, MASK_XLEN(0x0)
    c.mv x21, x27
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0) 
 
    # Testcase 176:  rd:x22(0x400000000000), rs2:x26(0x00000000), result rd:x22(0x00000000)
    li  x22,  MASK_XLEN(0x400000000000)
    li  x26, MASK_XLEN(0x0)
    c.mv x22, x26
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0) 
 
    # Testcase 177:  rd:x23(0x800000000000), rs2:x25(0x00000000), result rd:x23(0x00000000)
    li  x23,  MASK_XLEN(0x800000000000)
    li  x25, MASK_XLEN(0x0)
    c.mv x23, x25
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0) 
 
    # Testcase 178:  rd:x25(0x1000000000000), rs2:x24(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0x1000000000000)
    li  x24, MASK_XLEN(0x0)
    c.mv x25, x24
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 
 
    # Testcase 179:  rd:x25(0x2000000000000), rs2:x23(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0x2000000000000)
    li  x23, MASK_XLEN(0x0)
    c.mv x25, x23
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res

 
    # Testcase 180:  rd:x26(0x4000000000000), rs2:x22(0x00000000), result rd:x26(0x00000000)
    li  x26,  MASK_XLEN(0x4000000000000)
    li  x22, MASK_XLEN(0x0)
    c.mv x26, x22
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x0) 
 
    # Testcase 181:  rd:x27(0x8000000000000), rs2:x21(0x00000000), result rd:x27(0x00000000)
    li  x27,  MASK_XLEN(0x8000000000000)
    li  x21, MASK_XLEN(0x0)
    c.mv x27, x21
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x0) 
 
    # Testcase 182:  rd:x28(0x10000000000000), rs2:x20(0x00000000), result rd:x28(0x00000000)
    li  x28,  MASK_XLEN(0x10000000000000)
    li  x20, MASK_XLEN(0x0)
    c.mv x28, x20
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x0) 
 
    # Testcase 183:  rd:x29(0x20000000000000), rs2:x19(0x00000000), result rd:x29(0x00000000)
    li  x29,  MASK_XLEN(0x20000000000000)
    li  x19, MASK_XLEN(0x0)
    c.mv x29, x19
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x0) 
 
    # Testcase 184:  rd:x30(0x40000000000000), rs2:x18(0x00000000), result rd:x30(0x00000000)
    li  x30,  MASK_XLEN(0x40000000000000)
    li  x18, MASK_XLEN(0x0)
    c.mv x30, x18
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x5, test_38_res

 
    # Testcase 185:  rd:x31(0x80000000000000), rs2:x17(0x00000000), result rd:x31(0x00000000)
    li  x31,  MASK_XLEN(0x80000000000000)
    li  x17, MASK_XLEN(0x0)
    c.mv x31, x17
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0) 
 
    # Testcase 186:  rd:x1(0x100000000000000), rs2:x16(0x00000000), result rd:x1(0x00000000)
    li  x1,  MASK_XLEN(0x100000000000000)
    li  x16, MASK_XLEN(0x0)
    c.mv x1, x16
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0) 
 
    # Testcase 187:  rd:x2(0x200000000000000), rs2:x15(0x00000000), result rd:x2(0x00000000)
    li  x2,  MASK_XLEN(0x200000000000000)
    li  x15, MASK_XLEN(0x0)
    c.mv x2, x15
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0) 
 
    # Testcase 188:  rd:x3(0x400000000000000), rs2:x14(0x00000000), result rd:x3(0x00000000)
    li  x3,  MASK_XLEN(0x400000000000000)
    li  x14, MASK_XLEN(0x0)
    c.mv x3, x14
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x0) 
 
    # Testcase 189:  rd:x4(0x800000000000000), rs2:x13(0x00000000), result rd:x4(0x00000000)
    li  x4,  MASK_XLEN(0x800000000000000)
    li  x13, MASK_XLEN(0x0)
    c.mv x4, x13
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res

 
    # Testcase 190:  rd:x5(0x1000000000000000), rs2:x12(0x00000000), result rd:x5(0x00000000)
    li  x5,  MASK_XLEN(0x1000000000000000)
    li  x12, MASK_XLEN(0x0)
    c.mv x5, x12
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0) 
 
    # Testcase 191:  rd:x6(0x2000000000000000), rs2:x11(0x00000000), result rd:x6(0x00000000)
    li  x6,  MASK_XLEN(0x2000000000000000)
    li  x11, MASK_XLEN(0x0)
    c.mv x6, x11
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0) 
 
    # Testcase 192:  rd:x7(0x4000000000000000), rs2:x10(0x00000000), result rd:x7(0x00000000)
    li  x7,  MASK_XLEN(0x4000000000000000)
    li  x10, MASK_XLEN(0x0)
    c.mv x7, x10
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0) 
 
    # Testcase 193:  rd:x8(0x8000000000000000), rs2:x9(0x00000000), result rd:x8(0x00000000)
    li  x8,  MASK_XLEN(0x8000000000000000)
    li  x9, MASK_XLEN(0x0)
    c.mv x8, x9
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 194:  rd:x9(0x00000000), rs2:x8(0x00000000), result rd:x9(0x00000000)
    li  x9,  MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x0)
    c.mv x9, x8
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res

 
    # Testcase 195:  rd:x10(0xfffffffffffffffe), rs2:x7(0x00000000), result rd:x10(0x00000000)
    li  x10,  MASK_XLEN(0xfffffffffffffffe)
    li  x7, MASK_XLEN(0x0)
    c.mv x10, x7
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 196:  rd:x11(0xfffffffffffffffd), rs2:x6(0x00000000), result rd:x11(0x00000000)
    li  x11,  MASK_XLEN(0xfffffffffffffffd)
    li  x6, MASK_XLEN(0x0)
    c.mv x11, x6
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 197:  rd:x12(0xfffffffffffffffb), rs2:x5(0x00000000), result rd:x12(0x00000000)
    li  x12,  MASK_XLEN(0xfffffffffffffffb)
    li  x5, MASK_XLEN(0x0)
    c.mv x12, x5
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 198:  rd:x13(0xfffffffffffffff7), rs2:x4(0x00000000), result rd:x13(0x00000000)
    li  x13,  MASK_XLEN(0xfffffffffffffff7)
    li  x4, MASK_XLEN(0x0)
    c.mv x13, x4
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 199:  rd:x14(0xffffffffffffffef), rs2:x3(0x00000000), result rd:x14(0x00000000)
    li  x14,  MASK_XLEN(0xffffffffffffffef)
    li  x3, MASK_XLEN(0x0)
    c.mv x14, x3
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x3, test_41_res

 
    # Testcase 200:  rd:x15(0xffffffffffffffdf), rs2:x2(0x00000000), result rd:x15(0x00000000)
    li  x15,  MASK_XLEN(0xffffffffffffffdf)
    li  x2, MASK_XLEN(0x0)
    c.mv x15, x2
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x0) 
 
    # Testcase 201:  rd:x16(0xffffffffffffffbf), rs2:x1(0x00000000), result rd:x16(0x00000000)
    li  x16,  MASK_XLEN(0xffffffffffffffbf)
    li  x1, MASK_XLEN(0x0)
    c.mv x16, x1
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x0) 
 
    # Testcase 202:  rd:x17(0xffffffffffffff7f), rs2:x31(0x00000000), result rd:x17(0x00000000)
    li  x17,  MASK_XLEN(0xffffffffffffff7f)
    li  x31, MASK_XLEN(0x0)
    c.mv x17, x31
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x0) 
 
    # Testcase 203:  rd:x18(0xfffffffffffffeff), rs2:x30(0x00000000), result rd:x18(0x00000000)
    li  x18,  MASK_XLEN(0xfffffffffffffeff)
    li  x30, MASK_XLEN(0x0)
    c.mv x18, x30
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x0) 
 
    # Testcase 204:  rd:x19(0xfffffffffffffdff), rs2:x29(0x00000000), result rd:x19(0x00000000)
    li  x19,  MASK_XLEN(0xfffffffffffffdff)
    li  x29, MASK_XLEN(0x0)
    c.mv x19, x29
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res

 
    # Testcase 205:  rd:x20(0xfffffffffffffbff), rs2:x28(0x00000000), result rd:x20(0x00000000)
    li  x20,  MASK_XLEN(0xfffffffffffffbff)
    li  x28, MASK_XLEN(0x0)
    c.mv x20, x28
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0) 
 
    # Testcase 206:  rd:x21(0xfffffffffffff7ff), rs2:x27(0x00000000), result rd:x21(0x00000000)
    li  x21,  MASK_XLEN(0xfffffffffffff7ff)
    li  x27, MASK_XLEN(0x0)
    c.mv x21, x27
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0) 
 
    # Testcase 207:  rd:x22(0xffffffffffffefff), rs2:x26(0x00000000), result rd:x22(0x00000000)
    li  x22,  MASK_XLEN(0xffffffffffffefff)
    li  x26, MASK_XLEN(0x0)
    c.mv x22, x26
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0) 
 
    # Testcase 208:  rd:x23(0xffffffffffffdfff), rs2:x25(0x00000000), result rd:x23(0x00000000)
    li  x23,  MASK_XLEN(0xffffffffffffdfff)
    li  x25, MASK_XLEN(0x0)
    c.mv x23, x25
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0) 
 
    # Testcase 209:  rd:x25(0xffffffffffffbfff), rs2:x24(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0xffffffffffffbfff)
    li  x24, MASK_XLEN(0x0)
    c.mv x25, x24
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res

 
    # Testcase 210:  rd:x25(0xffffffffffff7fff), rs2:x23(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0xffffffffffff7fff)
    li  x23, MASK_XLEN(0x0)
    c.mv x25, x23
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 
 
    # Testcase 211:  rd:x26(0xfffffffffffeffff), rs2:x22(0x00000000), result rd:x26(0x00000000)
    li  x26,  MASK_XLEN(0xfffffffffffeffff)
    li  x22, MASK_XLEN(0x0)
    c.mv x26, x22
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0) 
 
    # Testcase 212:  rd:x27(0xfffffffffffdffff), rs2:x21(0x00000000), result rd:x27(0x00000000)
    li  x27,  MASK_XLEN(0xfffffffffffdffff)
    li  x21, MASK_XLEN(0x0)
    c.mv x27, x21
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0) 
 
    # Testcase 213:  rd:x28(0xfffffffffffbffff), rs2:x20(0x00000000), result rd:x28(0x00000000)
    li  x28,  MASK_XLEN(0xfffffffffffbffff)
    li  x20, MASK_XLEN(0x0)
    c.mv x28, x20
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x0) 
 
    # Testcase 214:  rd:x29(0xfffffffffff7ffff), rs2:x19(0x00000000), result rd:x29(0x00000000)
    li  x29,  MASK_XLEN(0xfffffffffff7ffff)
    li  x19, MASK_XLEN(0x0)
    c.mv x29, x19
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x4, test_44_res

 
    # Testcase 215:  rd:x30(0xffffffffffefffff), rs2:x18(0x00000000), result rd:x30(0x00000000)
    li  x30,  MASK_XLEN(0xffffffffffefffff)
    li  x18, MASK_XLEN(0x0)
    c.mv x30, x18
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0) 
 
    # Testcase 216:  rd:x31(0xffffffffffdfffff), rs2:x17(0x00000000), result rd:x31(0x00000000)
    li  x31,  MASK_XLEN(0xffffffffffdfffff)
    li  x17, MASK_XLEN(0x0)
    c.mv x31, x17
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0) 
 
    # Testcase 217:  rd:x1(0xffffffffffbfffff), rs2:x16(0x00000000), result rd:x1(0x00000000)
    li  x1,  MASK_XLEN(0xffffffffffbfffff)
    li  x16, MASK_XLEN(0x0)
    c.mv x1, x16
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0) 
 
    # Testcase 218:  rd:x2(0xffffffffff7fffff), rs2:x15(0x00000000), result rd:x2(0x00000000)
    li  x2,  MASK_XLEN(0xffffffffff7fffff)
    li  x15, MASK_XLEN(0x0)
    c.mv x2, x15
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0) 
 
    # Testcase 219:  rd:x3(0xfffffffffeffffff), rs2:x14(0x00000000), result rd:x3(0x00000000)
    li  x3,  MASK_XLEN(0xfffffffffeffffff)
    li  x14, MASK_XLEN(0x0)
    c.mv x3, x14
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res

 
    # Testcase 220:  rd:x4(0xfffffffffdffffff), rs2:x13(0x00000000), result rd:x4(0x00000000)
    li  x4,  MASK_XLEN(0xfffffffffdffffff)
    li  x13, MASK_XLEN(0x0)
    c.mv x4, x13
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x0) 
 
    # Testcase 221:  rd:x5(0xfffffffffbffffff), rs2:x12(0x00000000), result rd:x5(0x00000000)
    li  x5,  MASK_XLEN(0xfffffffffbffffff)
    li  x12, MASK_XLEN(0x0)
    c.mv x5, x12
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0) 
 
    # Testcase 222:  rd:x6(0xfffffffff7ffffff), rs2:x11(0x00000000), result rd:x6(0x00000000)
    li  x6,  MASK_XLEN(0xfffffffff7ffffff)
    li  x11, MASK_XLEN(0x0)
    c.mv x6, x11
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0) 
 
    # Testcase 223:  rd:x7(0xffffffffefffffff), rs2:x10(0x00000000), result rd:x7(0x00000000)
    li  x7,  MASK_XLEN(0xffffffffefffffff)
    li  x10, MASK_XLEN(0x0)
    c.mv x7, x10
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0) 
 
    # Testcase 224:  rd:x8(0xffffffffdfffffff), rs2:x9(0x00000000), result rd:x8(0x00000000)
    li  x8,  MASK_XLEN(0xffffffffdfffffff)
    li  x9, MASK_XLEN(0x0)
    c.mv x8, x9
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res

 
    # Testcase 225:  rd:x9(0xffffffffbfffffff), rs2:x8(0x00000000), result rd:x9(0x00000000)
    li  x9,  MASK_XLEN(0xffffffffbfffffff)
    li  x8, MASK_XLEN(0x0)
    c.mv x9, x8
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 226:  rd:x10(0xffffffff7fffffff), rs2:x7(0x00000000), result rd:x10(0x00000000)
    li  x10,  MASK_XLEN(0xffffffff7fffffff)
    li  x7, MASK_XLEN(0x0)
    c.mv x10, x7
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 227:  rd:x11(0xfffffffeffffffff), rs2:x6(0x00000000), result rd:x11(0x00000000)
    li  x11,  MASK_XLEN(0xfffffffeffffffff)
    li  x6, MASK_XLEN(0x0)
    c.mv x11, x6
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 228:  rd:x12(0xfffffffdffffffff), rs2:x5(0x00000000), result rd:x12(0x00000000)
    li  x12,  MASK_XLEN(0xfffffffdffffffff)
    li  x5, MASK_XLEN(0x0)
    c.mv x12, x5
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 229:  rd:x13(0xfffffffbffffffff), rs2:x4(0x00000000), result rd:x13(0x00000000)
    li  x13,  MASK_XLEN(0xfffffffbffffffff)
    li  x4, MASK_XLEN(0x0)
    c.mv x13, x4
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x4, test_47_res

 
    # Testcase 230:  rd:x14(0xfffffff7ffffffff), rs2:x3(0x00000000), result rd:x14(0x00000000)
    li  x14,  MASK_XLEN(0xfffffff7ffffffff)
    li  x3, MASK_XLEN(0x0)
    c.mv x14, x3
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x0) 
 
    # Testcase 231:  rd:x15(0xffffffefffffffff), rs2:x2(0x00000000), result rd:x15(0x00000000)
    li  x15,  MASK_XLEN(0xffffffefffffffff)
    li  x2, MASK_XLEN(0x0)
    c.mv x15, x2
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0) 
 
    # Testcase 232:  rd:x16(0xffffffdfffffffff), rs2:x1(0x00000000), result rd:x16(0x00000000)
    li  x16,  MASK_XLEN(0xffffffdfffffffff)
    li  x1, MASK_XLEN(0x0)
    c.mv x16, x1
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0) 
 
    # Testcase 233:  rd:x17(0xffffffbfffffffff), rs2:x31(0x00000000), result rd:x17(0x00000000)
    li  x17,  MASK_XLEN(0xffffffbfffffffff)
    li  x31, MASK_XLEN(0x0)
    c.mv x17, x31
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x0) 
 
    # Testcase 234:  rd:x18(0xffffff7fffffffff), rs2:x30(0x00000000), result rd:x18(0x00000000)
    li  x18,  MASK_XLEN(0xffffff7fffffffff)
    li  x30, MASK_XLEN(0x0)
    c.mv x18, x30
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res

 
    # Testcase 235:  rd:x19(0xfffffeffffffffff), rs2:x29(0x00000000), result rd:x19(0x00000000)
    li  x19,  MASK_XLEN(0xfffffeffffffffff)
    li  x29, MASK_XLEN(0x0)
    c.mv x19, x29
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0) 
 
    # Testcase 236:  rd:x20(0xfffffdffffffffff), rs2:x28(0x00000000), result rd:x20(0x00000000)
    li  x20,  MASK_XLEN(0xfffffdffffffffff)
    li  x28, MASK_XLEN(0x0)
    c.mv x20, x28
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0) 
 
    # Testcase 237:  rd:x21(0xfffffbffffffffff), rs2:x27(0x00000000), result rd:x21(0x00000000)
    li  x21,  MASK_XLEN(0xfffffbffffffffff)
    li  x27, MASK_XLEN(0x0)
    c.mv x21, x27
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0) 
 
    # Testcase 238:  rd:x22(0xfffff7ffffffffff), rs2:x26(0x00000000), result rd:x22(0x00000000)
    li  x22,  MASK_XLEN(0xfffff7ffffffffff)
    li  x26, MASK_XLEN(0x0)
    c.mv x22, x26
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0) 
 
    # Testcase 239:  rd:x23(0xffffefffffffffff), rs2:x25(0x00000000), result rd:x23(0x00000000)
    li  x23,  MASK_XLEN(0xffffefffffffffff)
    li  x25, MASK_XLEN(0x0)
    c.mv x23, x25
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res

 
    # Testcase 240:  rd:x25(0xffffdfffffffffff), rs2:x24(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0xffffdfffffffffff)
    li  x24, MASK_XLEN(0x0)
    c.mv x25, x24
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 
 
    # Testcase 241:  rd:x25(0xffffbfffffffffff), rs2:x23(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0xffffbfffffffffff)
    li  x23, MASK_XLEN(0x0)
    c.mv x25, x23
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 
 
    # Testcase 242:  rd:x26(0xffff7fffffffffff), rs2:x22(0x00000000), result rd:x26(0x00000000)
    li  x26,  MASK_XLEN(0xffff7fffffffffff)
    li  x22, MASK_XLEN(0x0)
    c.mv x26, x22
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0) 
 
    # Testcase 243:  rd:x27(0xfffeffffffffffff), rs2:x21(0x00000000), result rd:x27(0x00000000)
    li  x27,  MASK_XLEN(0xfffeffffffffffff)
    li  x21, MASK_XLEN(0x0)
    c.mv x27, x21
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0) 
 
    # Testcase 244:  rd:x28(0xfffdffffffffffff), rs2:x20(0x00000000), result rd:x28(0x00000000)
    li  x28,  MASK_XLEN(0xfffdffffffffffff)
    li  x20, MASK_XLEN(0x0)
    c.mv x28, x20
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x4, test_50_res

 
    # Testcase 245:  rd:x29(0xfffbffffffffffff), rs2:x19(0x00000000), result rd:x29(0x00000000)
    li  x29,  MASK_XLEN(0xfffbffffffffffff)
    li  x19, MASK_XLEN(0x0)
    c.mv x29, x19
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x0) 
 
    # Testcase 246:  rd:x30(0xfff7ffffffffffff), rs2:x18(0x00000000), result rd:x30(0x00000000)
    li  x30,  MASK_XLEN(0xfff7ffffffffffff)
    li  x18, MASK_XLEN(0x0)
    c.mv x30, x18
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0) 
 
    # Testcase 247:  rd:x31(0xffefffffffffffff), rs2:x17(0x00000000), result rd:x31(0x00000000)
    li  x31,  MASK_XLEN(0xffefffffffffffff)
    li  x17, MASK_XLEN(0x0)
    c.mv x31, x17
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0) 
 
    # Testcase 248:  rd:x1(0xffdfffffffffffff), rs2:x16(0x00000000), result rd:x1(0x00000000)
    li  x1,  MASK_XLEN(0xffdfffffffffffff)
    li  x16, MASK_XLEN(0x0)
    c.mv x1, x16
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0) 
 
    # Testcase 249:  rd:x2(0xffbfffffffffffff), rs2:x15(0x00000000), result rd:x2(0x00000000)
    li  x2,  MASK_XLEN(0xffbfffffffffffff)
    li  x15, MASK_XLEN(0x0)
    c.mv x2, x15
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res

 
    # Testcase 250:  rd:x3(0xff7fffffffffffff), rs2:x14(0x00000000), result rd:x3(0x00000000)
    li  x3,  MASK_XLEN(0xff7fffffffffffff)
    li  x14, MASK_XLEN(0x0)
    c.mv x3, x14
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0) 
 
    # Testcase 251:  rd:x4(0xfeffffffffffffff), rs2:x13(0x00000000), result rd:x4(0x00000000)
    li  x4,  MASK_XLEN(0xfeffffffffffffff)
    li  x13, MASK_XLEN(0x0)
    c.mv x4, x13
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x0) 
 
    # Testcase 252:  rd:x5(0xfdffffffffffffff), rs2:x12(0x00000000), result rd:x5(0x00000000)
    li  x5,  MASK_XLEN(0xfdffffffffffffff)
    li  x12, MASK_XLEN(0x0)
    c.mv x5, x12
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0) 
 
    # Testcase 253:  rd:x6(0xfbffffffffffffff), rs2:x11(0x00000000), result rd:x6(0x00000000)
    li  x6,  MASK_XLEN(0xfbffffffffffffff)
    li  x11, MASK_XLEN(0x0)
    c.mv x6, x11
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0) 
 
    # Testcase 254:  rd:x7(0xf7ffffffffffffff), rs2:x10(0x00000000), result rd:x7(0x00000000)
    li  x7,  MASK_XLEN(0xf7ffffffffffffff)
    li  x10, MASK_XLEN(0x0)
    c.mv x7, x10
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res

 
    # Testcase 255:  rd:x8(0xefffffffffffffff), rs2:x9(0x00000000), result rd:x8(0x00000000)
    li  x8,  MASK_XLEN(0xefffffffffffffff)
    li  x9, MASK_XLEN(0x0)
    c.mv x8, x9
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 256:  rd:x9(0xdfffffffffffffff), rs2:x8(0x00000000), result rd:x9(0x00000000)
    li  x9,  MASK_XLEN(0xdfffffffffffffff)
    li  x8, MASK_XLEN(0x0)
    c.mv x9, x8
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 257:  rd:x10(0xbfffffffffffffff), rs2:x7(0x00000000), result rd:x10(0x00000000)
    li  x10,  MASK_XLEN(0xbfffffffffffffff)
    li  x7, MASK_XLEN(0x0)
    c.mv x10, x7
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 258:  rd:x11(0x7fffffffffffffff), rs2:x6(0x00000000), result rd:x11(0x00000000)
    li  x11,  MASK_XLEN(0x7fffffffffffffff)
    li  x6, MASK_XLEN(0x0)
    c.mv x11, x6
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 259:  rd:x12(0xffffffffffffffff), rs2:x5(0x00000000), result rd:x12(0x00000000)
    li  x12,  MASK_XLEN(0xffffffffffffffff)
    li  x5, MASK_XLEN(0x0)
    c.mv x12, x5
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x5, test_53_res

 
    # Testcase 260:  rd:x13(0x00000001), rs2:x4(0xffffffffffffffff), result rd:x13(0xffffffffffffffff)
    li  x13,  MASK_XLEN(0x1)
    li  x4, MASK_XLEN(0xffffffffffffffff)
    c.mv x13, x4
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0xffffffffffffffff) 
 
    # Testcase 261:  rd:x14(0x00000002), rs2:x3(0x7fffffffffffffff), result rd:x14(0x7fffffffffffffff)
    li  x14,  MASK_XLEN(0x2)
    li  x3, MASK_XLEN(0x7fffffffffffffff)
    c.mv x14, x3
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x7fffffffffffffff) 
 
    # Testcase 262:  rd:x15(0x00000004), rs2:x2(0xbfffffffffffffff), result rd:x15(0xbfffffffffffffff)
    li  x15,  MASK_XLEN(0x4)
    li  x2, MASK_XLEN(0xbfffffffffffffff)
    c.mv x15, x2
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xbfffffffffffffff) 
 
    # Testcase 263:  rd:x16(0x00000008), rs2:x1(0xdfffffffffffffff), result rd:x16(0xdfffffffffffffff)
    li  x16,  MASK_XLEN(0x8)
    li  x1, MASK_XLEN(0xdfffffffffffffff)
    c.mv x16, x1
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xdfffffffffffffff) 



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

