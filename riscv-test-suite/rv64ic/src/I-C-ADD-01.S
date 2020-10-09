# RISC-V Compliance Test I-C-ADD-01
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
# Description: Testing instruction 'c.add'.

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

 
    # Testcase 0:  rd:x1(0x00000001), rs2:x16(0xffffffffffffffff), result rd:x1(0x00000000)
    li  x1,  MASK_XLEN(0x1)
    li  x16, MASK_XLEN(0xffffffffffffffff)
    c.add x1, x16
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x0) 
 
    # Testcase 1:  rd:x2(0x00000002), rs2:x15(0x7fffffffffffffff), result rd:x2(0x8000000000000001)
    li  x2,  MASK_XLEN(0x2)
    li  x15, MASK_XLEN(0x7fffffffffffffff)
    c.add x2, x15
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x8000000000000001) 
 
    # Testcase 2:  rd:x3(0x00000004), rs2:x14(0xbfffffffffffffff), result rd:x3(0xc000000000000003)
    li  x3,  MASK_XLEN(0x4)
    li  x14, MASK_XLEN(0xbfffffffffffffff)
    c.add x3, x14
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xc000000000000003) 
 
    # Testcase 3:  rd:x4(0x00000008), rs2:x13(0xdfffffffffffffff), result rd:x4(0xe000000000000007)
    li  x4,  MASK_XLEN(0x8)
    li  x13, MASK_XLEN(0xdfffffffffffffff)
    c.add x4, x13
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xe000000000000007) 
 
    # Testcase 4:  rd:x5(0x00000010), rs2:x12(0xefffffffffffffff), result rd:x5(0xf00000000000000f)
    li  x5,  MASK_XLEN(0x10)
    li  x12, MASK_XLEN(0xefffffffffffffff)
    c.add x5, x12
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xf00000000000000f) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res

 
    # Testcase 5:  rd:x6(0x00000020), rs2:x11(0xf7ffffffffffffff), result rd:x6(0xf80000000000001f)
    li  x6,  MASK_XLEN(0x20)
    li  x11, MASK_XLEN(0xf7ffffffffffffff)
    c.add x6, x11
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xf80000000000001f) 
 
    # Testcase 6:  rd:x7(0x00000040), rs2:x10(0xfbffffffffffffff), result rd:x7(0xfc0000000000003f)
    li  x7,  MASK_XLEN(0x40)
    li  x10, MASK_XLEN(0xfbffffffffffffff)
    c.add x7, x10
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfc0000000000003f) 
 
    # Testcase 7:  rd:x8(0x00000080), rs2:x9(0xfdffffffffffffff), result rd:x8(0xfe0000000000007f)
    li  x8,  MASK_XLEN(0x80)
    li  x9, MASK_XLEN(0xfdffffffffffffff)
    c.add x8, x9
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfe0000000000007f) 
 
    # Testcase 8:  rd:x9(0x00000100), rs2:x8(0xfeffffffffffffff), result rd:x9(0xff000000000000ff)
    li  x9,  MASK_XLEN(0x100)
    li  x8, MASK_XLEN(0xfeffffffffffffff)
    c.add x9, x8
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xff000000000000ff) 
 
    # Testcase 9:  rd:x10(0x00000200), rs2:x7(0xff7fffffffffffff), result rd:x10(0xff800000000001ff)
    li  x10,  MASK_XLEN(0x200)
    li  x7, MASK_XLEN(0xff7fffffffffffff)
    c.add x10, x7
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xff800000000001ff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res

 
    # Testcase 10:  rd:x11(0x00000400), rs2:x6(0xffbfffffffffffff), result rd:x11(0xffc00000000003ff)
    li  x11,  MASK_XLEN(0x400)
    li  x6, MASK_XLEN(0xffbfffffffffffff)
    c.add x11, x6
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0xffc00000000003ff) 
 
    # Testcase 11:  rd:x12(0x00000800), rs2:x5(0xffdfffffffffffff), result rd:x12(0xffe00000000007ff)
    li  x12,  MASK_XLEN(0x800)
    li  x5, MASK_XLEN(0xffdfffffffffffff)
    c.add x12, x5
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0xffe00000000007ff) 
 
    # Testcase 12:  rd:x13(0x00001000), rs2:x4(0xffefffffffffffff), result rd:x13(0xfff0000000000fff)
    li  x13,  MASK_XLEN(0x1000)
    li  x4, MASK_XLEN(0xffefffffffffffff)
    c.add x13, x4
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0xfff0000000000fff) 
 
    # Testcase 13:  rd:x14(0x00002000), rs2:x3(0xfff7ffffffffffff), result rd:x14(0xfff8000000001fff)
    li  x14,  MASK_XLEN(0x2000)
    li  x3, MASK_XLEN(0xfff7ffffffffffff)
    c.add x14, x3
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xfff8000000001fff) 
 
    # Testcase 14:  rd:x15(0x00004000), rs2:x2(0xfffbffffffffffff), result rd:x15(0xfffc000000003fff)
    li  x15,  MASK_XLEN(0x4000)
    li  x2, MASK_XLEN(0xfffbffffffffffff)
    c.add x15, x2
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0xfffc000000003fff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res

 
    # Testcase 15:  rd:x16(0x00008000), rs2:x1(0xfffdffffffffffff), result rd:x16(0xfffe000000007fff)
    li  x16,  MASK_XLEN(0x8000)
    li  x1, MASK_XLEN(0xfffdffffffffffff)
    c.add x16, x1
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0xfffe000000007fff) 
 
    # Testcase 16:  rd:x17(0x00010000), rs2:x31(0xfffeffffffffffff), result rd:x17(0xffff00000000ffff)
    li  x17,  MASK_XLEN(0x10000)
    li  x31, MASK_XLEN(0xfffeffffffffffff)
    c.add x17, x31
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0xffff00000000ffff) 
 
    # Testcase 17:  rd:x18(0x00020000), rs2:x30(0xffff7fffffffffff), result rd:x18(0xffff80000001ffff)
    li  x18,  MASK_XLEN(0x20000)
    li  x30, MASK_XLEN(0xffff7fffffffffff)
    c.add x18, x30
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0xffff80000001ffff) 
 
    # Testcase 18:  rd:x19(0x00040000), rs2:x29(0xffffbfffffffffff), result rd:x19(0xffffc0000003ffff)
    li  x19,  MASK_XLEN(0x40000)
    li  x29, MASK_XLEN(0xffffbfffffffffff)
    c.add x19, x29
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0xffffc0000003ffff) 
 
    # Testcase 19:  rd:x20(0x00080000), rs2:x28(0xffffdfffffffffff), result rd:x20(0xffffe0000007ffff)
    li  x20,  MASK_XLEN(0x80000)
    li  x28, MASK_XLEN(0xffffdfffffffffff)
    c.add x20, x28
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0xffffe0000007ffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res

 
    # Testcase 20:  rd:x21(0x00100000), rs2:x27(0xffffefffffffffff), result rd:x21(0xfffff000000fffff)
    li  x21,  MASK_XLEN(0x100000)
    li  x27, MASK_XLEN(0xffffefffffffffff)
    c.add x21, x27
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffff000000fffff) 
 
    # Testcase 21:  rd:x22(0x00200000), rs2:x26(0xfffff7ffffffffff), result rd:x22(0xfffff800001fffff)
    li  x22,  MASK_XLEN(0x200000)
    li  x26, MASK_XLEN(0xfffff7ffffffffff)
    c.add x22, x26
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffff800001fffff) 
 
    # Testcase 22:  rd:x23(0x00400000), rs2:x25(0xfffffbffffffffff), result rd:x23(0xfffffc00003fffff)
    li  x23,  MASK_XLEN(0x400000)
    li  x25, MASK_XLEN(0xfffffbffffffffff)
    c.add x23, x25
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffffc00003fffff) 
 
    # Testcase 23:  rd:x25(0x00800000), rs2:x24(0xfffffdffffffffff), result rd:x25(0xfffffe00007fffff)
    li  x25,  MASK_XLEN(0x800000)
    li  x24, MASK_XLEN(0xfffffdffffffffff)
    c.add x25, x24
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffe00007fffff) 
 
    # Testcase 24:  rd:x25(0x01000000), rs2:x23(0xfffffeffffffffff), result rd:x25(0xffffff0000ffffff)
    li  x25,  MASK_XLEN(0x1000000)
    li  x23, MASK_XLEN(0xfffffeffffffffff)
    c.add x25, x23
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffff0000ffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res

 
    # Testcase 25:  rd:x26(0x02000000), rs2:x22(0xffffff7fffffffff), result rd:x26(0xffffff8001ffffff)
    li  x26,  MASK_XLEN(0x2000000)
    li  x22, MASK_XLEN(0xffffff7fffffffff)
    c.add x26, x22
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0xffffff8001ffffff) 
 
    # Testcase 26:  rd:x27(0x04000000), rs2:x21(0xffffffbfffffffff), result rd:x27(0xffffffc003ffffff)
    li  x27,  MASK_XLEN(0x4000000)
    li  x21, MASK_XLEN(0xffffffbfffffffff)
    c.add x27, x21
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0xffffffc003ffffff) 
 
    # Testcase 27:  rd:x28(0x08000000), rs2:x20(0xffffffdfffffffff), result rd:x28(0xffffffe007ffffff)
    li  x28,  MASK_XLEN(0x8000000)
    li  x20, MASK_XLEN(0xffffffdfffffffff)
    c.add x28, x20
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0xffffffe007ffffff) 
 
    # Testcase 28:  rd:x29(0x10000000), rs2:x19(0xffffffefffffffff), result rd:x29(0xfffffff00fffffff)
    li  x29,  MASK_XLEN(0x10000000)
    li  x19, MASK_XLEN(0xffffffefffffffff)
    c.add x29, x19
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0xfffffff00fffffff) 
 
    # Testcase 29:  rd:x30(0x20000000), rs2:x18(0xfffffff7ffffffff), result rd:x30(0xfffffff81fffffff)
    li  x30,  MASK_XLEN(0x20000000)
    li  x18, MASK_XLEN(0xfffffff7ffffffff)
    c.add x30, x18
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0xfffffff81fffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res

 
    # Testcase 30:  rd:x31(0x40000000), rs2:x17(0xfffffffbffffffff), result rd:x31(0xfffffffc3fffffff)
    li  x31,  MASK_XLEN(0x40000000)
    li  x17, MASK_XLEN(0xfffffffbffffffff)
    c.add x31, x17
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xfffffffc3fffffff) 
 
    # Testcase 31:  rd:x1(0x80000000), rs2:x16(0xfffffffdffffffff), result rd:x1(0xfffffffe7fffffff)
    li  x1,  MASK_XLEN(0x80000000)
    li  x16, MASK_XLEN(0xfffffffdffffffff)
    c.add x1, x16
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xfffffffe7fffffff) 
 
    # Testcase 32:  rd:x2(0x100000000), rs2:x15(0xfffffffeffffffff), result rd:x2(0xffffffffffffffff)
    li  x2,  MASK_XLEN(0x100000000)
    li  x15, MASK_XLEN(0xfffffffeffffffff)
    c.add x2, x15
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xffffffffffffffff) 
 
    # Testcase 33:  rd:x3(0x200000000), rs2:x14(0xffffffff7fffffff), result rd:x3(0x17fffffff)
    li  x3,  MASK_XLEN(0x200000000)
    li  x14, MASK_XLEN(0xffffffff7fffffff)
    c.add x3, x14
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x17fffffff) 
 
    # Testcase 34:  rd:x4(0x400000000), rs2:x13(0xffffffffbfffffff), result rd:x4(0x3bfffffff)
    li  x4,  MASK_XLEN(0x400000000)
    li  x13, MASK_XLEN(0xffffffffbfffffff)
    c.add x4, x13
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x3bfffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res

 
    # Testcase 35:  rd:x5(0x800000000), rs2:x12(0xffffffffdfffffff), result rd:x5(0x7dfffffff)
    li  x5,  MASK_XLEN(0x800000000)
    li  x12, MASK_XLEN(0xffffffffdfffffff)
    c.add x5, x12
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x7dfffffff) 
 
    # Testcase 36:  rd:x6(0x1000000000), rs2:x11(0xffffffffefffffff), result rd:x6(0xfefffffff)
    li  x6,  MASK_XLEN(0x1000000000)
    li  x11, MASK_XLEN(0xffffffffefffffff)
    c.add x6, x11
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfefffffff) 
 
    # Testcase 37:  rd:x7(0x2000000000), rs2:x10(0xfffffffff7ffffff), result rd:x7(0x1ff7ffffff)
    li  x7,  MASK_XLEN(0x2000000000)
    li  x10, MASK_XLEN(0xfffffffff7ffffff)
    c.add x7, x10
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x1ff7ffffff) 
 
    # Testcase 38:  rd:x8(0x4000000000), rs2:x9(0xfffffffffbffffff), result rd:x8(0x3ffbffffff)
    li  x8,  MASK_XLEN(0x4000000000)
    li  x9, MASK_XLEN(0xfffffffffbffffff)
    c.add x8, x9
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x3ffbffffff) 
 
    # Testcase 39:  rd:x9(0x8000000000), rs2:x8(0xfffffffffdffffff), result rd:x9(0x7ffdffffff)
    li  x9,  MASK_XLEN(0x8000000000)
    li  x8, MASK_XLEN(0xfffffffffdffffff)
    c.add x9, x8
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x7ffdffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res

 
    # Testcase 40:  rd:x10(0x10000000000), rs2:x7(0xfffffffffeffffff), result rd:x10(0xfffeffffff)
    li  x10,  MASK_XLEN(0x10000000000)
    li  x7, MASK_XLEN(0xfffffffffeffffff)
    c.add x10, x7
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffeffffff) 
 
    # Testcase 41:  rd:x11(0x20000000000), rs2:x6(0xffffffffff7fffff), result rd:x11(0x1ffff7fffff)
    li  x11,  MASK_XLEN(0x20000000000)
    li  x6, MASK_XLEN(0xffffffffff7fffff)
    c.add x11, x6
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1ffff7fffff) 
 
    # Testcase 42:  rd:x12(0x40000000000), rs2:x5(0xffffffffffbfffff), result rd:x12(0x3ffffbfffff)
    li  x12,  MASK_XLEN(0x40000000000)
    li  x5, MASK_XLEN(0xffffffffffbfffff)
    c.add x12, x5
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x3ffffbfffff) 
 
    # Testcase 43:  rd:x13(0x80000000000), rs2:x4(0xffffffffffdfffff), result rd:x13(0x7ffffdfffff)
    li  x13,  MASK_XLEN(0x80000000000)
    li  x4, MASK_XLEN(0xffffffffffdfffff)
    c.add x13, x4
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7ffffdfffff) 
 
    # Testcase 44:  rd:x14(0x100000000000), rs2:x3(0xffffffffffefffff), result rd:x14(0xfffffefffff)
    li  x14,  MASK_XLEN(0x100000000000)
    li  x3, MASK_XLEN(0xffffffffffefffff)
    c.add x14, x3
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffefffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res

 
    # Testcase 45:  rd:x15(0x200000000000), rs2:x2(0xfffffffffff7ffff), result rd:x15(0x1ffffff7ffff)
    li  x15,  MASK_XLEN(0x200000000000)
    li  x2, MASK_XLEN(0xfffffffffff7ffff)
    c.add x15, x2
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x1ffffff7ffff) 
 
    # Testcase 46:  rd:x16(0x400000000000), rs2:x1(0xfffffffffffbffff), result rd:x16(0x3ffffffbffff)
    li  x16,  MASK_XLEN(0x400000000000)
    li  x1, MASK_XLEN(0xfffffffffffbffff)
    c.add x16, x1
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x3ffffffbffff) 
 
    # Testcase 47:  rd:x17(0x800000000000), rs2:x31(0xfffffffffffdffff), result rd:x17(0x7ffffffdffff)
    li  x17,  MASK_XLEN(0x800000000000)
    li  x31, MASK_XLEN(0xfffffffffffdffff)
    c.add x17, x31
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x7ffffffdffff) 
 
    # Testcase 48:  rd:x18(0x1000000000000), rs2:x30(0xfffffffffffeffff), result rd:x18(0xfffffffeffff)
    li  x18,  MASK_XLEN(0x1000000000000)
    li  x30, MASK_XLEN(0xfffffffffffeffff)
    c.add x18, x30
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0xfffffffeffff) 
 
    # Testcase 49:  rd:x19(0x2000000000000), rs2:x29(0xffffffffffff7fff), result rd:x19(0x1ffffffff7fff)
    li  x19,  MASK_XLEN(0x2000000000000)
    li  x29, MASK_XLEN(0xffffffffffff7fff)
    c.add x19, x29
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x1ffffffff7fff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res

 
    # Testcase 50:  rd:x20(0x4000000000000), rs2:x28(0xffffffffffffbfff), result rd:x20(0x3ffffffffbfff)
    li  x20,  MASK_XLEN(0x4000000000000)
    li  x28, MASK_XLEN(0xffffffffffffbfff)
    c.add x20, x28
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x3ffffffffbfff) 
 
    # Testcase 51:  rd:x21(0x8000000000000), rs2:x27(0xffffffffffffdfff), result rd:x21(0x7ffffffffdfff)
    li  x21,  MASK_XLEN(0x8000000000000)
    li  x27, MASK_XLEN(0xffffffffffffdfff)
    c.add x21, x27
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x7ffffffffdfff) 
 
    # Testcase 52:  rd:x22(0x10000000000000), rs2:x26(0xffffffffffffefff), result rd:x22(0xfffffffffefff)
    li  x22,  MASK_XLEN(0x10000000000000)
    li  x26, MASK_XLEN(0xffffffffffffefff)
    c.add x22, x26
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffffffffefff) 
 
    # Testcase 53:  rd:x23(0x20000000000000), rs2:x25(0xfffffffffffff7ff), result rd:x23(0x1ffffffffff7ff)
    li  x23,  MASK_XLEN(0x20000000000000)
    li  x25, MASK_XLEN(0xfffffffffffff7ff)
    c.add x23, x25
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x1ffffffffff7ff) 
 
    # Testcase 54:  rd:x25(0x40000000000000), rs2:x24(0xfffffffffffffbff), result rd:x25(0x3ffffffffffbff)
    li  x25,  MASK_XLEN(0x40000000000000)
    li  x24, MASK_XLEN(0xfffffffffffffbff)
    c.add x25, x24
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x3ffffffffffbff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res

 
    # Testcase 55:  rd:x25(0x80000000000000), rs2:x23(0xfffffffffffffdff), result rd:x25(0x7ffffffffffdff)
    li  x25,  MASK_XLEN(0x80000000000000)
    li  x23, MASK_XLEN(0xfffffffffffffdff)
    c.add x25, x23
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x7ffffffffffdff) 
 
    # Testcase 56:  rd:x26(0x100000000000000), rs2:x22(0xfffffffffffffeff), result rd:x26(0xfffffffffffeff)
    li  x26,  MASK_XLEN(0x100000000000000)
    li  x22, MASK_XLEN(0xfffffffffffffeff)
    c.add x26, x22
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xfffffffffffeff) 
 
    # Testcase 57:  rd:x27(0x200000000000000), rs2:x21(0xffffffffffffff7f), result rd:x27(0x1ffffffffffff7f)
    li  x27,  MASK_XLEN(0x200000000000000)
    li  x21, MASK_XLEN(0xffffffffffffff7f)
    c.add x27, x21
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x1ffffffffffff7f) 
 
    # Testcase 58:  rd:x28(0x400000000000000), rs2:x20(0xffffffffffffffbf), result rd:x28(0x3ffffffffffffbf)
    li  x28,  MASK_XLEN(0x400000000000000)
    li  x20, MASK_XLEN(0xffffffffffffffbf)
    c.add x28, x20
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x3ffffffffffffbf) 
 
    # Testcase 59:  rd:x29(0x800000000000000), rs2:x19(0xffffffffffffffdf), result rd:x29(0x7ffffffffffffdf)
    li  x29,  MASK_XLEN(0x800000000000000)
    li  x19, MASK_XLEN(0xffffffffffffffdf)
    c.add x29, x19
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x7ffffffffffffdf) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res

 
    # Testcase 60:  rd:x30(0x1000000000000000), rs2:x18(0xffffffffffffffef), result rd:x30(0xfffffffffffffef)
    li  x30,  MASK_XLEN(0x1000000000000000)
    li  x18, MASK_XLEN(0xffffffffffffffef)
    c.add x30, x18
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfffffffffffffef) 
 
    # Testcase 61:  rd:x31(0x2000000000000000), rs2:x17(0xfffffffffffffff7), result rd:x31(0x1ffffffffffffff7)
    li  x31,  MASK_XLEN(0x2000000000000000)
    li  x17, MASK_XLEN(0xfffffffffffffff7)
    c.add x31, x17
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x1ffffffffffffff7) 
 
    # Testcase 62:  rd:x1(0x4000000000000000), rs2:x16(0xfffffffffffffffb), result rd:x1(0x3ffffffffffffffb)
    li  x1,  MASK_XLEN(0x4000000000000000)
    li  x16, MASK_XLEN(0xfffffffffffffffb)
    c.add x1, x16
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x3ffffffffffffffb) 
 
    # Testcase 63:  rd:x2(0x8000000000000000), rs2:x15(0xfffffffffffffffd), result rd:x2(0x7ffffffffffffffd)
    li  x2,  MASK_XLEN(0x8000000000000000)
    li  x15, MASK_XLEN(0xfffffffffffffffd)
    c.add x2, x15
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x7ffffffffffffffd) 
 
    # Testcase 64:  rd:x3(0x00000000), rs2:x14(0xfffffffffffffffe), result rd:x3(0xfffffffffffffffe)
    li  x3,  MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffffffffffffffe)
    c.add x3, x14
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xfffffffffffffffe) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res

 
    # Testcase 65:  rd:x4(0xfffffffffffffffe), rs2:x13(0x00000000), result rd:x4(0xfffffffffffffffe)
    li  x4,  MASK_XLEN(0xfffffffffffffffe)
    li  x13, MASK_XLEN(0x0)
    c.add x4, x13
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xfffffffffffffffe) 
 
    # Testcase 66:  rd:x5(0xfffffffffffffffd), rs2:x12(0x8000000000000000), result rd:x5(0x7ffffffffffffffd)
    li  x5,  MASK_XLEN(0xfffffffffffffffd)
    li  x12, MASK_XLEN(0x8000000000000000)
    c.add x5, x12
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x7ffffffffffffffd) 
 
    # Testcase 67:  rd:x6(0xfffffffffffffffb), rs2:x11(0x4000000000000000), result rd:x6(0x3ffffffffffffffb)
    li  x6,  MASK_XLEN(0xfffffffffffffffb)
    li  x11, MASK_XLEN(0x4000000000000000)
    c.add x6, x11
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x3ffffffffffffffb) 
 
    # Testcase 68:  rd:x7(0xfffffffffffffff7), rs2:x10(0x2000000000000000), result rd:x7(0x1ffffffffffffff7)
    li  x7,  MASK_XLEN(0xfffffffffffffff7)
    li  x10, MASK_XLEN(0x2000000000000000)
    c.add x7, x10
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x1ffffffffffffff7) 
 
    # Testcase 69:  rd:x8(0xffffffffffffffef), rs2:x9(0x1000000000000000), result rd:x8(0xfffffffffffffef)
    li  x8,  MASK_XLEN(0xffffffffffffffef)
    li  x9, MASK_XLEN(0x1000000000000000)
    c.add x8, x9
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffffffffef) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res

 
    # Testcase 70:  rd:x9(0xffffffffffffffdf), rs2:x8(0x800000000000000), result rd:x9(0x7ffffffffffffdf)
    li  x9,  MASK_XLEN(0xffffffffffffffdf)
    li  x8, MASK_XLEN(0x800000000000000)
    c.add x9, x8
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x7ffffffffffffdf) 
 
    # Testcase 71:  rd:x10(0xffffffffffffffbf), rs2:x7(0x400000000000000), result rd:x10(0x3ffffffffffffbf)
    li  x10,  MASK_XLEN(0xffffffffffffffbf)
    li  x7, MASK_XLEN(0x400000000000000)
    c.add x10, x7
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x3ffffffffffffbf) 
 
    # Testcase 72:  rd:x11(0xffffffffffffff7f), rs2:x6(0x200000000000000), result rd:x11(0x1ffffffffffff7f)
    li  x11,  MASK_XLEN(0xffffffffffffff7f)
    li  x6, MASK_XLEN(0x200000000000000)
    c.add x11, x6
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1ffffffffffff7f) 
 
    # Testcase 73:  rd:x12(0xfffffffffffffeff), rs2:x5(0x100000000000000), result rd:x12(0xfffffffffffeff)
    li  x12,  MASK_XLEN(0xfffffffffffffeff)
    li  x5, MASK_XLEN(0x100000000000000)
    c.add x12, x5
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffffeff) 
 
    # Testcase 74:  rd:x13(0xfffffffffffffdff), rs2:x4(0x80000000000000), result rd:x13(0x7ffffffffffdff)
    li  x13,  MASK_XLEN(0xfffffffffffffdff)
    li  x4, MASK_XLEN(0x80000000000000)
    c.add x13, x4
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7ffffffffffdff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res

 
    # Testcase 75:  rd:x14(0xfffffffffffffbff), rs2:x3(0x40000000000000), result rd:x14(0x3ffffffffffbff)
    li  x14,  MASK_XLEN(0xfffffffffffffbff)
    li  x3, MASK_XLEN(0x40000000000000)
    c.add x14, x3
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x3ffffffffffbff) 
 
    # Testcase 76:  rd:x15(0xfffffffffffff7ff), rs2:x2(0x20000000000000), result rd:x15(0x1ffffffffff7ff)
    li  x15,  MASK_XLEN(0xfffffffffffff7ff)
    li  x2, MASK_XLEN(0x20000000000000)
    c.add x15, x2
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x1ffffffffff7ff) 
 
    # Testcase 77:  rd:x16(0xffffffffffffefff), rs2:x1(0x10000000000000), result rd:x16(0xfffffffffefff)
    li  x16,  MASK_XLEN(0xffffffffffffefff)
    li  x1, MASK_XLEN(0x10000000000000)
    c.add x16, x1
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xfffffffffefff) 
 
    # Testcase 78:  rd:x17(0xffffffffffffdfff), rs2:x31(0x8000000000000), result rd:x17(0x7ffffffffdfff)
    li  x17,  MASK_XLEN(0xffffffffffffdfff)
    li  x31, MASK_XLEN(0x8000000000000)
    c.add x17, x31
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x7ffffffffdfff) 
 
    # Testcase 79:  rd:x18(0xffffffffffffbfff), rs2:x30(0x4000000000000), result rd:x18(0x3ffffffffbfff)
    li  x18,  MASK_XLEN(0xffffffffffffbfff)
    li  x30, MASK_XLEN(0x4000000000000)
    c.add x18, x30
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x3ffffffffbfff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res

 
    # Testcase 80:  rd:x19(0xffffffffffff7fff), rs2:x29(0x2000000000000), result rd:x19(0x1ffffffff7fff)
    li  x19,  MASK_XLEN(0xffffffffffff7fff)
    li  x29, MASK_XLEN(0x2000000000000)
    c.add x19, x29
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x1ffffffff7fff) 
 
    # Testcase 81:  rd:x20(0xfffffffffffeffff), rs2:x28(0x1000000000000), result rd:x20(0xfffffffeffff)
    li  x20,  MASK_XLEN(0xfffffffffffeffff)
    li  x28, MASK_XLEN(0x1000000000000)
    c.add x20, x28
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffffffeffff) 
 
    # Testcase 82:  rd:x21(0xfffffffffffdffff), rs2:x27(0x800000000000), result rd:x21(0x7ffffffdffff)
    li  x21,  MASK_XLEN(0xfffffffffffdffff)
    li  x27, MASK_XLEN(0x800000000000)
    c.add x21, x27
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x7ffffffdffff) 
 
    # Testcase 83:  rd:x22(0xfffffffffffbffff), rs2:x26(0x400000000000), result rd:x22(0x3ffffffbffff)
    li  x22,  MASK_XLEN(0xfffffffffffbffff)
    li  x26, MASK_XLEN(0x400000000000)
    c.add x22, x26
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x3ffffffbffff) 
 
    # Testcase 84:  rd:x23(0xfffffffffff7ffff), rs2:x25(0x200000000000), result rd:x23(0x1ffffff7ffff)
    li  x23,  MASK_XLEN(0xfffffffffff7ffff)
    li  x25, MASK_XLEN(0x200000000000)
    c.add x23, x25
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x1ffffff7ffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res

 
    # Testcase 85:  rd:x25(0xffffffffffefffff), rs2:x24(0x100000000000), result rd:x25(0xfffffefffff)
    li  x25,  MASK_XLEN(0xffffffffffefffff)
    li  x24, MASK_XLEN(0x100000000000)
    c.add x25, x24
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffefffff) 
 
    # Testcase 86:  rd:x25(0xffffffffffdfffff), rs2:x23(0x80000000000), result rd:x25(0x7ffffdfffff)
    li  x25,  MASK_XLEN(0xffffffffffdfffff)
    li  x23, MASK_XLEN(0x80000000000)
    c.add x25, x23
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x7ffffdfffff) 
 
    # Testcase 87:  rd:x26(0xffffffffffbfffff), rs2:x22(0x40000000000), result rd:x26(0x3ffffbfffff)
    li  x26,  MASK_XLEN(0xffffffffffbfffff)
    li  x22, MASK_XLEN(0x40000000000)
    c.add x26, x22
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x3ffffbfffff) 
 
    # Testcase 88:  rd:x27(0xffffffffff7fffff), rs2:x21(0x20000000000), result rd:x27(0x1ffff7fffff)
    li  x27,  MASK_XLEN(0xffffffffff7fffff)
    li  x21, MASK_XLEN(0x20000000000)
    c.add x27, x21
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x1ffff7fffff) 
 
    # Testcase 89:  rd:x28(0xfffffffffeffffff), rs2:x20(0x10000000000), result rd:x28(0xfffeffffff)
    li  x28,  MASK_XLEN(0xfffffffffeffffff)
    li  x20, MASK_XLEN(0x10000000000)
    c.add x28, x20
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffeffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res

 
    # Testcase 90:  rd:x29(0xfffffffffdffffff), rs2:x19(0x8000000000), result rd:x29(0x7ffdffffff)
    li  x29,  MASK_XLEN(0xfffffffffdffffff)
    li  x19, MASK_XLEN(0x8000000000)
    c.add x29, x19
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x7ffdffffff) 
 
    # Testcase 91:  rd:x30(0xfffffffffbffffff), rs2:x18(0x4000000000), result rd:x30(0x3ffbffffff)
    li  x30,  MASK_XLEN(0xfffffffffbffffff)
    li  x18, MASK_XLEN(0x4000000000)
    c.add x30, x18
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x3ffbffffff) 
 
    # Testcase 92:  rd:x31(0xfffffffff7ffffff), rs2:x17(0x2000000000), result rd:x31(0x1ff7ffffff)
    li  x31,  MASK_XLEN(0xfffffffff7ffffff)
    li  x17, MASK_XLEN(0x2000000000)
    c.add x31, x17
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x1ff7ffffff) 
 
    # Testcase 93:  rd:x1(0xffffffffefffffff), rs2:x16(0x1000000000), result rd:x1(0xfefffffff)
    li  x1,  MASK_XLEN(0xffffffffefffffff)
    li  x16, MASK_XLEN(0x1000000000)
    c.add x1, x16
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xfefffffff) 
 
    # Testcase 94:  rd:x2(0xffffffffdfffffff), rs2:x15(0x800000000), result rd:x2(0x7dfffffff)
    li  x2,  MASK_XLEN(0xffffffffdfffffff)
    li  x15, MASK_XLEN(0x800000000)
    c.add x2, x15
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x7dfffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res

 
    # Testcase 95:  rd:x3(0xffffffffbfffffff), rs2:x14(0x400000000), result rd:x3(0x3bfffffff)
    li  x3,  MASK_XLEN(0xffffffffbfffffff)
    li  x14, MASK_XLEN(0x400000000)
    c.add x3, x14
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x3bfffffff) 
 
    # Testcase 96:  rd:x4(0xffffffff7fffffff), rs2:x13(0x200000000), result rd:x4(0x17fffffff)
    li  x4,  MASK_XLEN(0xffffffff7fffffff)
    li  x13, MASK_XLEN(0x200000000)
    c.add x4, x13
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x17fffffff) 
 
    # Testcase 97:  rd:x5(0xfffffffeffffffff), rs2:x12(0x100000000), result rd:x5(0xffffffffffffffff)
    li  x5,  MASK_XLEN(0xfffffffeffffffff)
    li  x12, MASK_XLEN(0x100000000)
    c.add x5, x12
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xffffffffffffffff) 
 
    # Testcase 98:  rd:x6(0xfffffffdffffffff), rs2:x11(0x80000000), result rd:x6(0xfffffffe7fffffff)
    li  x6,  MASK_XLEN(0xfffffffdffffffff)
    li  x11, MASK_XLEN(0x80000000)
    c.add x6, x11
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfffffffe7fffffff) 
 
    # Testcase 99:  rd:x7(0xfffffffbffffffff), rs2:x10(0x40000000), result rd:x7(0xfffffffc3fffffff)
    li  x7,  MASK_XLEN(0xfffffffbffffffff)
    li  x10, MASK_XLEN(0x40000000)
    c.add x7, x10
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffc3fffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res

 
    # Testcase 100:  rd:x8(0xfffffff7ffffffff), rs2:x9(0x20000000), result rd:x8(0xfffffff81fffffff)
    li  x8,  MASK_XLEN(0xfffffff7ffffffff)
    li  x9, MASK_XLEN(0x20000000)
    c.add x8, x9
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffff81fffffff) 
 
    # Testcase 101:  rd:x9(0xffffffefffffffff), rs2:x8(0x10000000), result rd:x9(0xfffffff00fffffff)
    li  x9,  MASK_XLEN(0xffffffefffffffff)
    li  x8, MASK_XLEN(0x10000000)
    c.add x9, x8
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffff00fffffff) 
 
    # Testcase 102:  rd:x10(0xffffffdfffffffff), rs2:x7(0x08000000), result rd:x10(0xffffffe007ffffff)
    li  x10,  MASK_XLEN(0xffffffdfffffffff)
    li  x7, MASK_XLEN(0x8000000)
    c.add x10, x7
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffe007ffffff) 
 
    # Testcase 103:  rd:x11(0xffffffbfffffffff), rs2:x6(0x04000000), result rd:x11(0xffffffc003ffffff)
    li  x11,  MASK_XLEN(0xffffffbfffffffff)
    li  x6, MASK_XLEN(0x4000000)
    c.add x11, x6
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffc003ffffff) 
 
    # Testcase 104:  rd:x12(0xffffff7fffffffff), rs2:x5(0x02000000), result rd:x12(0xffffff8001ffffff)
    li  x12,  MASK_XLEN(0xffffff7fffffffff)
    li  x5, MASK_XLEN(0x2000000)
    c.add x12, x5
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffff8001ffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res

 
    # Testcase 105:  rd:x13(0xfffffeffffffffff), rs2:x4(0x01000000), result rd:x13(0xffffff0000ffffff)
    li  x13,  MASK_XLEN(0xfffffeffffffffff)
    li  x4, MASK_XLEN(0x1000000)
    c.add x13, x4
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0xffffff0000ffffff) 
 
    # Testcase 106:  rd:x14(0xfffffdffffffffff), rs2:x3(0x00800000), result rd:x14(0xfffffe00007fffff)
    li  x14,  MASK_XLEN(0xfffffdffffffffff)
    li  x3, MASK_XLEN(0x800000)
    c.add x14, x3
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xfffffe00007fffff) 
 
    # Testcase 107:  rd:x15(0xfffffbffffffffff), rs2:x2(0x00400000), result rd:x15(0xfffffc00003fffff)
    li  x15,  MASK_XLEN(0xfffffbffffffffff)
    li  x2, MASK_XLEN(0x400000)
    c.add x15, x2
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xfffffc00003fffff) 
 
    # Testcase 108:  rd:x16(0xfffff7ffffffffff), rs2:x1(0x00200000), result rd:x16(0xfffff800001fffff)
    li  x16,  MASK_XLEN(0xfffff7ffffffffff)
    li  x1, MASK_XLEN(0x200000)
    c.add x16, x1
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xfffff800001fffff) 
 
    # Testcase 109:  rd:x17(0xffffefffffffffff), rs2:x31(0x00100000), result rd:x17(0xfffff000000fffff)
    li  x17,  MASK_XLEN(0xffffefffffffffff)
    li  x31, MASK_XLEN(0x100000)
    c.add x17, x31
    sd x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xfffff000000fffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res

 
    # Testcase 110:  rd:x18(0xffffdfffffffffff), rs2:x30(0x00080000), result rd:x18(0xffffe0000007ffff)
    li  x18,  MASK_XLEN(0xffffdfffffffffff)
    li  x30, MASK_XLEN(0x80000)
    c.add x18, x30
    sd x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0xffffe0000007ffff) 
 
    # Testcase 111:  rd:x19(0xffffbfffffffffff), rs2:x29(0x00040000), result rd:x19(0xffffc0000003ffff)
    li  x19,  MASK_XLEN(0xffffbfffffffffff)
    li  x29, MASK_XLEN(0x40000)
    c.add x19, x29
    sd x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xffffc0000003ffff) 
 
    # Testcase 112:  rd:x20(0xffff7fffffffffff), rs2:x28(0x00020000), result rd:x20(0xffff80000001ffff)
    li  x20,  MASK_XLEN(0xffff7fffffffffff)
    li  x28, MASK_XLEN(0x20000)
    c.add x20, x28
    sd x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffff80000001ffff) 
 
    # Testcase 113:  rd:x21(0xfffeffffffffffff), rs2:x27(0x00010000), result rd:x21(0xffff00000000ffff)
    li  x21,  MASK_XLEN(0xfffeffffffffffff)
    li  x27, MASK_XLEN(0x10000)
    c.add x21, x27
    sd x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffff00000000ffff) 
 
    # Testcase 114:  rd:x22(0xfffdffffffffffff), rs2:x26(0x00008000), result rd:x22(0xfffe000000007fff)
    li  x22,  MASK_XLEN(0xfffdffffffffffff)
    li  x26, MASK_XLEN(0x8000)
    c.add x22, x26
    sd x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffe000000007fff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res

 
    # Testcase 115:  rd:x23(0xfffbffffffffffff), rs2:x25(0x00004000), result rd:x23(0xfffc000000003fff)
    li  x23,  MASK_XLEN(0xfffbffffffffffff)
    li  x25, MASK_XLEN(0x4000)
    c.add x23, x25
    sd x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffc000000003fff) 
 
    # Testcase 116:  rd:x25(0xfff7ffffffffffff), rs2:x24(0x00002000), result rd:x25(0xfff8000000001fff)
    li  x25,  MASK_XLEN(0xfff7ffffffffffff)
    li  x24, MASK_XLEN(0x2000)
    c.add x25, x24
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfff8000000001fff) 
 
    # Testcase 117:  rd:x25(0xffefffffffffffff), rs2:x23(0x00001000), result rd:x25(0xfff0000000000fff)
    li  x25,  MASK_XLEN(0xffefffffffffffff)
    li  x23, MASK_XLEN(0x1000)
    c.add x25, x23
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfff0000000000fff) 
 
    # Testcase 118:  rd:x26(0xffdfffffffffffff), rs2:x22(0x00000800), result rd:x26(0xffe00000000007ff)
    li  x26,  MASK_XLEN(0xffdfffffffffffff)
    li  x22, MASK_XLEN(0x800)
    c.add x26, x22
    sd x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffe00000000007ff) 
 
    # Testcase 119:  rd:x27(0xffbfffffffffffff), rs2:x21(0x00000400), result rd:x27(0xffc00000000003ff)
    li  x27,  MASK_XLEN(0xffbfffffffffffff)
    li  x21, MASK_XLEN(0x400)
    c.add x27, x21
    sd x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffc00000000003ff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res

 
    # Testcase 120:  rd:x28(0xff7fffffffffffff), rs2:x20(0x00000200), result rd:x28(0xff800000000001ff)
    li  x28,  MASK_XLEN(0xff7fffffffffffff)
    li  x20, MASK_XLEN(0x200)
    c.add x28, x20
    sd x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0xff800000000001ff) 
 
    # Testcase 121:  rd:x29(0xfeffffffffffffff), rs2:x19(0x00000100), result rd:x29(0xff000000000000ff)
    li  x29,  MASK_XLEN(0xfeffffffffffffff)
    li  x19, MASK_XLEN(0x100)
    c.add x29, x19
    sd x29, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0xff000000000000ff) 
 
    # Testcase 122:  rd:x30(0xfdffffffffffffff), rs2:x18(0x00000080), result rd:x30(0xfe0000000000007f)
    li  x30,  MASK_XLEN(0xfdffffffffffffff)
    li  x18, MASK_XLEN(0x80)
    c.add x30, x18
    sd x30, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0xfe0000000000007f) 
 
    # Testcase 123:  rd:x31(0xfbffffffffffffff), rs2:x17(0x00000040), result rd:x31(0xfc0000000000003f)
    li  x31,  MASK_XLEN(0xfbffffffffffffff)
    li  x17, MASK_XLEN(0x40)
    c.add x31, x17
    sd x31, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xfc0000000000003f) 
 
    # Testcase 124:  rd:x1(0xf7ffffffffffffff), rs2:x16(0x00000020), result rd:x1(0xf80000000000001f)
    li  x1,  MASK_XLEN(0xf7ffffffffffffff)
    li  x16, MASK_XLEN(0x20)
    c.add x1, x16
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xf80000000000001f) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res

 
    # Testcase 125:  rd:x2(0xefffffffffffffff), rs2:x15(0x00000010), result rd:x2(0xf00000000000000f)
    li  x2,  MASK_XLEN(0xefffffffffffffff)
    li  x15, MASK_XLEN(0x10)
    c.add x2, x15
    sd x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xf00000000000000f) 
 
    # Testcase 126:  rd:x3(0xdfffffffffffffff), rs2:x14(0x00000008), result rd:x3(0xe000000000000007)
    li  x3,  MASK_XLEN(0xdfffffffffffffff)
    li  x14, MASK_XLEN(0x8)
    c.add x3, x14
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xe000000000000007) 
 
    # Testcase 127:  rd:x4(0xbfffffffffffffff), rs2:x13(0x00000004), result rd:x4(0xc000000000000003)
    li  x4,  MASK_XLEN(0xbfffffffffffffff)
    li  x13, MASK_XLEN(0x4)
    c.add x4, x13
    sd x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xc000000000000003) 
 
    # Testcase 128:  rd:x5(0x7fffffffffffffff), rs2:x12(0x00000002), result rd:x5(0x8000000000000001)
    li  x5,  MASK_XLEN(0x7fffffffffffffff)
    li  x12, MASK_XLEN(0x2)
    c.add x5, x12
    sd x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x8000000000000001) 
 
    # Testcase 129:  rd:x6(0xffffffffffffffff), rs2:x11(0x00000001), result rd:x6(0x00000000)
    li  x6,  MASK_XLEN(0xffffffffffffffff)
    li  x11, MASK_XLEN(0x1)
    c.add x6, x11
    sd x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res

 
    # Testcase 130:  rd:x7(0x00000001), rs2:x10(0x00000000), result rd:x7(0x00000001)
    li  x7,  MASK_XLEN(0x1)
    li  x10, MASK_XLEN(0x0)
    c.add x7, x10
    sd x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x1) 
 
    # Testcase 131:  rd:x8(0x00000002), rs2:x9(0x00000000), result rd:x8(0x00000002)
    li  x8,  MASK_XLEN(0x2)
    li  x9, MASK_XLEN(0x0)
    c.add x8, x9
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2) 
 
    # Testcase 132:  rd:x9(0x00000004), rs2:x8(0x00000000), result rd:x9(0x00000004)
    li  x9,  MASK_XLEN(0x4)
    li  x8, MASK_XLEN(0x0)
    c.add x9, x8
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4) 
 
    # Testcase 133:  rd:x10(0x00000008), rs2:x7(0x00000000), result rd:x10(0x00000008)
    li  x10,  MASK_XLEN(0x8)
    li  x7, MASK_XLEN(0x0)
    c.add x10, x7
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8) 
 
    # Testcase 134:  rd:x11(0x00000010), rs2:x6(0x00000000), result rd:x11(0x00000010)
    li  x11,  MASK_XLEN(0x10)
    li  x6, MASK_XLEN(0x0)
    c.add x11, x6
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x10) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res

 
    # Testcase 135:  rd:x12(0x00000020), rs2:x5(0x00000000), result rd:x12(0x00000020)
    li  x12,  MASK_XLEN(0x20)
    li  x5, MASK_XLEN(0x0)
    c.add x12, x5
    sd x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x20) 
 
    # Testcase 136:  rd:x13(0x00000040), rs2:x4(0x00000000), result rd:x13(0x00000040)
    li  x13,  MASK_XLEN(0x40)
    li  x4, MASK_XLEN(0x0)
    c.add x13, x4
    sd x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x40) 
 
    # Testcase 137:  rd:x14(0x00000080), rs2:x3(0x00000000), result rd:x14(0x00000080)
    li  x14,  MASK_XLEN(0x80)
    li  x3, MASK_XLEN(0x0)
    c.add x14, x3
    sd x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x80) 
 
    # Testcase 138:  rd:x15(0x00000100), rs2:x2(0x00000000), result rd:x15(0x00000100)
    li  x15,  MASK_XLEN(0x100)
    li  x2, MASK_XLEN(0x0)
    c.add x15, x2
    sd x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x100) 
 
    # Testcase 139:  rd:x16(0x00000200), rs2:x1(0x00000000), result rd:x16(0x00000200)
    li  x16,  MASK_XLEN(0x200)
    li  x1, MASK_XLEN(0x0)
    c.add x16, x1
    sd x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x200) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res

 
    # Testcase 140:  rd:x17(0x00000400), rs2:x31(0x00000000), result rd:x17(0x00000400)
    li  x17,  MASK_XLEN(0x400)
    li  x31, MASK_XLEN(0x0)
    c.add x17, x31
    sd x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x17, 0x400) 
 
    # Testcase 141:  rd:x18(0x00000800), rs2:x30(0x00000000), result rd:x18(0x00000800)
    li  x18,  MASK_XLEN(0x800)
    li  x30, MASK_XLEN(0x0)
    c.add x18, x30
    sd x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x800) 
 
    # Testcase 142:  rd:x19(0x00001000), rs2:x29(0x00000000), result rd:x19(0x00001000)
    li  x19,  MASK_XLEN(0x1000)
    li  x29, MASK_XLEN(0x0)
    c.add x19, x29
    sd x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x1000) 
 
    # Testcase 143:  rd:x20(0x00002000), rs2:x28(0x00000000), result rd:x20(0x00002000)
    li  x20,  MASK_XLEN(0x2000)
    li  x28, MASK_XLEN(0x0)
    c.add x20, x28
    sd x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x2000) 
 
    # Testcase 144:  rd:x21(0x00004000), rs2:x27(0x00000000), result rd:x21(0x00004000)
    li  x21,  MASK_XLEN(0x4000)
    li  x27, MASK_XLEN(0x0)
    c.add x21, x27
    sd x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x4000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res

 
    # Testcase 145:  rd:x22(0x00008000), rs2:x26(0x00000000), result rd:x22(0x00008000)
    li  x22,  MASK_XLEN(0x8000)
    li  x26, MASK_XLEN(0x0)
    c.add x22, x26
    sd x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x8000) 
 
    # Testcase 146:  rd:x23(0x00010000), rs2:x25(0x00000000), result rd:x23(0x00010000)
    li  x23,  MASK_XLEN(0x10000)
    li  x25, MASK_XLEN(0x0)
    c.add x23, x25
    sd x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x10000) 
 
    # Testcase 147:  rd:x25(0x00020000), rs2:x24(0x00000000), result rd:x25(0x00020000)
    li  x25,  MASK_XLEN(0x20000)
    li  x24, MASK_XLEN(0x0)
    c.add x25, x24
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x20000) 
 
    # Testcase 148:  rd:x25(0x00040000), rs2:x23(0x00000000), result rd:x25(0x00040000)
    li  x25,  MASK_XLEN(0x40000)
    li  x23, MASK_XLEN(0x0)
    c.add x25, x23
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x40000) 
 
    # Testcase 149:  rd:x26(0x00080000), rs2:x22(0x00000000), result rd:x26(0x00080000)
    li  x26,  MASK_XLEN(0x80000)
    li  x22, MASK_XLEN(0x0)
    c.add x26, x22
    sd x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x80000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x6, test_31_res

 
    # Testcase 150:  rd:x27(0x00100000), rs2:x21(0x00000000), result rd:x27(0x00100000)
    li  x27,  MASK_XLEN(0x100000)
    li  x21, MASK_XLEN(0x0)
    c.add x27, x21
    sd x27, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x100000) 
 
    # Testcase 151:  rd:x28(0x00200000), rs2:x20(0x00000000), result rd:x28(0x00200000)
    li  x28,  MASK_XLEN(0x200000)
    li  x20, MASK_XLEN(0x0)
    c.add x28, x20
    sd x28, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x200000) 
 
    # Testcase 152:  rd:x29(0x00400000), rs2:x19(0x00000000), result rd:x29(0x00400000)
    li  x29,  MASK_XLEN(0x400000)
    li  x19, MASK_XLEN(0x0)
    c.add x29, x19
    sd x29, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x400000) 
 
    # Testcase 153:  rd:x30(0x00800000), rs2:x18(0x00000000), result rd:x30(0x00800000)
    li  x30,  MASK_XLEN(0x800000)
    li  x18, MASK_XLEN(0x0)
    c.add x30, x18
    sd x30, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x800000) 
 
    # Testcase 154:  rd:x31(0x01000000), rs2:x17(0x00000000), result rd:x31(0x01000000)
    li  x31,  MASK_XLEN(0x1000000)
    li  x17, MASK_XLEN(0x0)
    c.add x31, x17
    sd x31, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x1000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x6, test_32_res

 
    # Testcase 155:  rd:x1(0x02000000), rs2:x16(0x00000000), result rd:x1(0x02000000)
    li  x1,  MASK_XLEN(0x2000000)
    li  x16, MASK_XLEN(0x0)
    c.add x1, x16
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x2000000) 
 
    # Testcase 156:  rd:x2(0x04000000), rs2:x15(0x00000000), result rd:x2(0x04000000)
    li  x2,  MASK_XLEN(0x4000000)
    li  x15, MASK_XLEN(0x0)
    c.add x2, x15
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x4000000) 
 
    # Testcase 157:  rd:x3(0x08000000), rs2:x14(0x00000000), result rd:x3(0x08000000)
    li  x3,  MASK_XLEN(0x8000000)
    li  x14, MASK_XLEN(0x0)
    c.add x3, x14
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x8000000) 
 
    # Testcase 158:  rd:x4(0x10000000), rs2:x13(0x00000000), result rd:x4(0x10000000)
    li  x4,  MASK_XLEN(0x10000000)
    li  x13, MASK_XLEN(0x0)
    c.add x4, x13
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x10000000) 
 
    # Testcase 159:  rd:x5(0x20000000), rs2:x12(0x00000000), result rd:x5(0x20000000)
    li  x5,  MASK_XLEN(0x20000000)
    li  x12, MASK_XLEN(0x0)
    c.add x5, x12
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x20000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res

 
    # Testcase 160:  rd:x6(0x40000000), rs2:x11(0x00000000), result rd:x6(0x40000000)
    li  x6,  MASK_XLEN(0x40000000)
    li  x11, MASK_XLEN(0x0)
    c.add x6, x11
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x40000000) 
 
    # Testcase 161:  rd:x7(0x80000000), rs2:x10(0x00000000), result rd:x7(0x80000000)
    li  x7,  MASK_XLEN(0x80000000)
    li  x10, MASK_XLEN(0x0)
    c.add x7, x10
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x80000000) 
 
    # Testcase 162:  rd:x8(0x100000000), rs2:x9(0x00000000), result rd:x8(0x100000000)
    li  x8,  MASK_XLEN(0x100000000)
    li  x9, MASK_XLEN(0x0)
    c.add x8, x9
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x100000000) 
 
    # Testcase 163:  rd:x9(0x200000000), rs2:x8(0x00000000), result rd:x9(0x200000000)
    li  x9,  MASK_XLEN(0x200000000)
    li  x8, MASK_XLEN(0x0)
    c.add x9, x8
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x200000000) 
 
    # Testcase 164:  rd:x10(0x400000000), rs2:x7(0x00000000), result rd:x10(0x400000000)
    li  x10,  MASK_XLEN(0x400000000)
    li  x7, MASK_XLEN(0x0)
    c.add x10, x7
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x400000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res

 
    # Testcase 165:  rd:x11(0x800000000), rs2:x6(0x00000000), result rd:x11(0x800000000)
    li  x11,  MASK_XLEN(0x800000000)
    li  x6, MASK_XLEN(0x0)
    c.add x11, x6
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x800000000) 
 
    # Testcase 166:  rd:x12(0x1000000000), rs2:x5(0x00000000), result rd:x12(0x1000000000)
    li  x12,  MASK_XLEN(0x1000000000)
    li  x5, MASK_XLEN(0x0)
    c.add x12, x5
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x1000000000) 
 
    # Testcase 167:  rd:x13(0x2000000000), rs2:x4(0x00000000), result rd:x13(0x2000000000)
    li  x13,  MASK_XLEN(0x2000000000)
    li  x4, MASK_XLEN(0x0)
    c.add x13, x4
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x2000000000) 
 
    # Testcase 168:  rd:x14(0x4000000000), rs2:x3(0x00000000), result rd:x14(0x4000000000)
    li  x14,  MASK_XLEN(0x4000000000)
    li  x3, MASK_XLEN(0x0)
    c.add x14, x3
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x4000000000) 
 
    # Testcase 169:  rd:x15(0x8000000000), rs2:x2(0x00000000), result rd:x15(0x8000000000)
    li  x15,  MASK_XLEN(0x8000000000)
    li  x2, MASK_XLEN(0x0)
    c.add x15, x2
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x8000000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x2, test_35_res

 
    # Testcase 170:  rd:x16(0x10000000000), rs2:x1(0x00000000), result rd:x16(0x10000000000)
    li  x16,  MASK_XLEN(0x10000000000)
    li  x1, MASK_XLEN(0x0)
    c.add x16, x1
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x10000000000) 
 
    # Testcase 171:  rd:x17(0x20000000000), rs2:x31(0x00000000), result rd:x17(0x20000000000)
    li  x17,  MASK_XLEN(0x20000000000)
    li  x31, MASK_XLEN(0x0)
    c.add x17, x31
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x20000000000) 
 
    # Testcase 172:  rd:x18(0x40000000000), rs2:x30(0x00000000), result rd:x18(0x40000000000)
    li  x18,  MASK_XLEN(0x40000000000)
    li  x30, MASK_XLEN(0x0)
    c.add x18, x30
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x40000000000) 
 
    # Testcase 173:  rd:x19(0x80000000000), rs2:x29(0x00000000), result rd:x19(0x80000000000)
    li  x19,  MASK_XLEN(0x80000000000)
    li  x29, MASK_XLEN(0x0)
    c.add x19, x29
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x80000000000) 
 
    # Testcase 174:  rd:x20(0x100000000000), rs2:x28(0x00000000), result rd:x20(0x100000000000)
    li  x20,  MASK_XLEN(0x100000000000)
    li  x28, MASK_XLEN(0x0)
    c.add x20, x28
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x100000000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res

 
    # Testcase 175:  rd:x21(0x200000000000), rs2:x27(0x00000000), result rd:x21(0x200000000000)
    li  x21,  MASK_XLEN(0x200000000000)
    li  x27, MASK_XLEN(0x0)
    c.add x21, x27
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x200000000000) 
 
    # Testcase 176:  rd:x22(0x400000000000), rs2:x26(0x00000000), result rd:x22(0x400000000000)
    li  x22,  MASK_XLEN(0x400000000000)
    li  x26, MASK_XLEN(0x0)
    c.add x22, x26
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x400000000000) 
 
    # Testcase 177:  rd:x23(0x800000000000), rs2:x25(0x00000000), result rd:x23(0x800000000000)
    li  x23,  MASK_XLEN(0x800000000000)
    li  x25, MASK_XLEN(0x0)
    c.add x23, x25
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x800000000000) 
 
    # Testcase 178:  rd:x25(0x1000000000000), rs2:x24(0x00000000), result rd:x25(0x1000000000000)
    li  x25,  MASK_XLEN(0x1000000000000)
    li  x24, MASK_XLEN(0x0)
    c.add x25, x24
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x1000000000000) 
 
    # Testcase 179:  rd:x25(0x2000000000000), rs2:x23(0x00000000), result rd:x25(0x2000000000000)
    li  x25,  MASK_XLEN(0x2000000000000)
    li  x23, MASK_XLEN(0x0)
    c.add x25, x23
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x2000000000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res

 
    # Testcase 180:  rd:x26(0x4000000000000), rs2:x22(0x00000000), result rd:x26(0x4000000000000)
    li  x26,  MASK_XLEN(0x4000000000000)
    li  x22, MASK_XLEN(0x0)
    c.add x26, x22
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x4000000000000) 
 
    # Testcase 181:  rd:x27(0x8000000000000), rs2:x21(0x00000000), result rd:x27(0x8000000000000)
    li  x27,  MASK_XLEN(0x8000000000000)
    li  x21, MASK_XLEN(0x0)
    c.add x27, x21
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x8000000000000) 
 
    # Testcase 182:  rd:x28(0x10000000000000), rs2:x20(0x00000000), result rd:x28(0x10000000000000)
    li  x28,  MASK_XLEN(0x10000000000000)
    li  x20, MASK_XLEN(0x0)
    c.add x28, x20
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x10000000000000) 
 
    # Testcase 183:  rd:x29(0x20000000000000), rs2:x19(0x00000000), result rd:x29(0x20000000000000)
    li  x29,  MASK_XLEN(0x20000000000000)
    li  x19, MASK_XLEN(0x0)
    c.add x29, x19
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x20000000000000) 
 
    # Testcase 184:  rd:x30(0x40000000000000), rs2:x18(0x00000000), result rd:x30(0x40000000000000)
    li  x30,  MASK_XLEN(0x40000000000000)
    li  x18, MASK_XLEN(0x0)
    c.add x30, x18
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x40000000000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x5, test_38_res

 
    # Testcase 185:  rd:x31(0x80000000000000), rs2:x17(0x00000000), result rd:x31(0x80000000000000)
    li  x31,  MASK_XLEN(0x80000000000000)
    li  x17, MASK_XLEN(0x0)
    c.add x31, x17
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x80000000000000) 
 
    # Testcase 186:  rd:x1(0x100000000000000), rs2:x16(0x00000000), result rd:x1(0x100000000000000)
    li  x1,  MASK_XLEN(0x100000000000000)
    li  x16, MASK_XLEN(0x0)
    c.add x1, x16
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x100000000000000) 
 
    # Testcase 187:  rd:x2(0x200000000000000), rs2:x15(0x00000000), result rd:x2(0x200000000000000)
    li  x2,  MASK_XLEN(0x200000000000000)
    li  x15, MASK_XLEN(0x0)
    c.add x2, x15
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x200000000000000) 
 
    # Testcase 188:  rd:x3(0x400000000000000), rs2:x14(0x00000000), result rd:x3(0x400000000000000)
    li  x3,  MASK_XLEN(0x400000000000000)
    li  x14, MASK_XLEN(0x0)
    c.add x3, x14
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x400000000000000) 
 
    # Testcase 189:  rd:x4(0x800000000000000), rs2:x13(0x00000000), result rd:x4(0x800000000000000)
    li  x4,  MASK_XLEN(0x800000000000000)
    li  x13, MASK_XLEN(0x0)
    c.add x4, x13
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x800000000000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res

 
    # Testcase 190:  rd:x5(0x1000000000000000), rs2:x12(0x00000000), result rd:x5(0x1000000000000000)
    li  x5,  MASK_XLEN(0x1000000000000000)
    li  x12, MASK_XLEN(0x0)
    c.add x5, x12
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x1000000000000000) 
 
    # Testcase 191:  rd:x6(0x2000000000000000), rs2:x11(0x00000000), result rd:x6(0x2000000000000000)
    li  x6,  MASK_XLEN(0x2000000000000000)
    li  x11, MASK_XLEN(0x0)
    c.add x6, x11
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x2000000000000000) 
 
    # Testcase 192:  rd:x7(0x4000000000000000), rs2:x10(0x00000000), result rd:x7(0x4000000000000000)
    li  x7,  MASK_XLEN(0x4000000000000000)
    li  x10, MASK_XLEN(0x0)
    c.add x7, x10
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x4000000000000000) 
 
    # Testcase 193:  rd:x8(0x8000000000000000), rs2:x9(0x00000000), result rd:x8(0x8000000000000000)
    li  x8,  MASK_XLEN(0x8000000000000000)
    li  x9, MASK_XLEN(0x0)
    c.add x8, x9
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8000000000000000) 
 
    # Testcase 194:  rd:x9(0x00000000), rs2:x8(0x00000000), result rd:x9(0x00000000)
    li  x9,  MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x0)
    c.add x9, x8
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res

 
    # Testcase 195:  rd:x10(0xfffffffffffffffe), rs2:x7(0x00000000), result rd:x10(0xfffffffffffffffe)
    li  x10,  MASK_XLEN(0xfffffffffffffffe)
    li  x7, MASK_XLEN(0x0)
    c.add x10, x7
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffffffffffe) 
 
    # Testcase 196:  rd:x11(0xfffffffffffffffd), rs2:x6(0x00000000), result rd:x11(0xfffffffffffffffd)
    li  x11,  MASK_XLEN(0xfffffffffffffffd)
    li  x6, MASK_XLEN(0x0)
    c.add x11, x6
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffffffffffd) 
 
    # Testcase 197:  rd:x12(0xfffffffffffffffb), rs2:x5(0x00000000), result rd:x12(0xfffffffffffffffb)
    li  x12,  MASK_XLEN(0xfffffffffffffffb)
    li  x5, MASK_XLEN(0x0)
    c.add x12, x5
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffffffffb) 
 
    # Testcase 198:  rd:x13(0xfffffffffffffff7), rs2:x4(0x00000000), result rd:x13(0xfffffffffffffff7)
    li  x13,  MASK_XLEN(0xfffffffffffffff7)
    li  x4, MASK_XLEN(0x0)
    c.add x13, x4
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffffffff7) 
 
    # Testcase 199:  rd:x14(0xffffffffffffffef), rs2:x3(0x00000000), result rd:x14(0xffffffffffffffef)
    li  x14,  MASK_XLEN(0xffffffffffffffef)
    li  x3, MASK_XLEN(0x0)
    c.add x14, x3
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffffffffffef) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x3, test_41_res

 
    # Testcase 200:  rd:x15(0xffffffffffffffdf), rs2:x2(0x00000000), result rd:x15(0xffffffffffffffdf)
    li  x15,  MASK_XLEN(0xffffffffffffffdf)
    li  x2, MASK_XLEN(0x0)
    c.add x15, x2
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0xffffffffffffffdf) 
 
    # Testcase 201:  rd:x16(0xffffffffffffffbf), rs2:x1(0x00000000), result rd:x16(0xffffffffffffffbf)
    li  x16,  MASK_XLEN(0xffffffffffffffbf)
    li  x1, MASK_XLEN(0x0)
    c.add x16, x1
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0xffffffffffffffbf) 
 
    # Testcase 202:  rd:x17(0xffffffffffffff7f), rs2:x31(0x00000000), result rd:x17(0xffffffffffffff7f)
    li  x17,  MASK_XLEN(0xffffffffffffff7f)
    li  x31, MASK_XLEN(0x0)
    c.add x17, x31
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xffffffffffffff7f) 
 
    # Testcase 203:  rd:x18(0xfffffffffffffeff), rs2:x30(0x00000000), result rd:x18(0xfffffffffffffeff)
    li  x18,  MASK_XLEN(0xfffffffffffffeff)
    li  x30, MASK_XLEN(0x0)
    c.add x18, x30
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0xfffffffffffffeff) 
 
    # Testcase 204:  rd:x19(0xfffffffffffffdff), rs2:x29(0x00000000), result rd:x19(0xfffffffffffffdff)
    li  x19,  MASK_XLEN(0xfffffffffffffdff)
    li  x29, MASK_XLEN(0x0)
    c.add x19, x29
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xfffffffffffffdff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res

 
    # Testcase 205:  rd:x20(0xfffffffffffffbff), rs2:x28(0x00000000), result rd:x20(0xfffffffffffffbff)
    li  x20,  MASK_XLEN(0xfffffffffffffbff)
    li  x28, MASK_XLEN(0x0)
    c.add x20, x28
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffffffffffffbff) 
 
    # Testcase 206:  rd:x21(0xfffffffffffff7ff), rs2:x27(0x00000000), result rd:x21(0xfffffffffffff7ff)
    li  x21,  MASK_XLEN(0xfffffffffffff7ff)
    li  x27, MASK_XLEN(0x0)
    c.add x21, x27
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffffffffff7ff) 
 
    # Testcase 207:  rd:x22(0xffffffffffffefff), rs2:x26(0x00000000), result rd:x22(0xffffffffffffefff)
    li  x22,  MASK_XLEN(0xffffffffffffefff)
    li  x26, MASK_XLEN(0x0)
    c.add x22, x26
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffffffffffffefff) 
 
    # Testcase 208:  rd:x23(0xffffffffffffdfff), rs2:x25(0x00000000), result rd:x23(0xffffffffffffdfff)
    li  x23,  MASK_XLEN(0xffffffffffffdfff)
    li  x25, MASK_XLEN(0x0)
    c.add x23, x25
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffffffffffdfff) 
 
    # Testcase 209:  rd:x25(0xffffffffffffbfff), rs2:x24(0x00000000), result rd:x25(0xffffffffffffbfff)
    li  x25,  MASK_XLEN(0xffffffffffffbfff)
    li  x24, MASK_XLEN(0x0)
    c.add x25, x24
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffffffffbfff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res

 
    # Testcase 210:  rd:x25(0xffffffffffff7fff), rs2:x23(0x00000000), result rd:x25(0xffffffffffff7fff)
    li  x25,  MASK_XLEN(0xffffffffffff7fff)
    li  x23, MASK_XLEN(0x0)
    c.add x25, x23
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffffffff7fff) 
 
    # Testcase 211:  rd:x26(0xfffffffffffeffff), rs2:x22(0x00000000), result rd:x26(0xfffffffffffeffff)
    li  x26,  MASK_XLEN(0xfffffffffffeffff)
    li  x22, MASK_XLEN(0x0)
    c.add x26, x22
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xfffffffffffeffff) 
 
    # Testcase 212:  rd:x27(0xfffffffffffdffff), rs2:x21(0x00000000), result rd:x27(0xfffffffffffdffff)
    li  x27,  MASK_XLEN(0xfffffffffffdffff)
    li  x21, MASK_XLEN(0x0)
    c.add x27, x21
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfffffffffffdffff) 
 
    # Testcase 213:  rd:x28(0xfffffffffffbffff), rs2:x20(0x00000000), result rd:x28(0xfffffffffffbffff)
    li  x28,  MASK_XLEN(0xfffffffffffbffff)
    li  x20, MASK_XLEN(0x0)
    c.add x28, x20
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffffffffffbffff) 
 
    # Testcase 214:  rd:x29(0xfffffffffff7ffff), rs2:x19(0x00000000), result rd:x29(0xfffffffffff7ffff)
    li  x29,  MASK_XLEN(0xfffffffffff7ffff)
    li  x19, MASK_XLEN(0x0)
    c.add x29, x19
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xfffffffffff7ffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x4, test_44_res

 
    # Testcase 215:  rd:x30(0xffffffffffefffff), rs2:x18(0x00000000), result rd:x30(0xffffffffffefffff)
    li  x30,  MASK_XLEN(0xffffffffffefffff)
    li  x18, MASK_XLEN(0x0)
    c.add x30, x18
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xffffffffffefffff) 
 
    # Testcase 216:  rd:x31(0xffffffffffdfffff), rs2:x17(0x00000000), result rd:x31(0xffffffffffdfffff)
    li  x31,  MASK_XLEN(0xffffffffffdfffff)
    li  x17, MASK_XLEN(0x0)
    c.add x31, x17
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xffffffffffdfffff) 
 
    # Testcase 217:  rd:x1(0xffffffffffbfffff), rs2:x16(0x00000000), result rd:x1(0xffffffffffbfffff)
    li  x1,  MASK_XLEN(0xffffffffffbfffff)
    li  x16, MASK_XLEN(0x0)
    c.add x1, x16
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffffffffffbfffff) 
 
    # Testcase 218:  rd:x2(0xffffffffff7fffff), rs2:x15(0x00000000), result rd:x2(0xffffffffff7fffff)
    li  x2,  MASK_XLEN(0xffffffffff7fffff)
    li  x15, MASK_XLEN(0x0)
    c.add x2, x15
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffffffffff7fffff) 
 
    # Testcase 219:  rd:x3(0xfffffffffeffffff), rs2:x14(0x00000000), result rd:x3(0xfffffffffeffffff)
    li  x3,  MASK_XLEN(0xfffffffffeffffff)
    li  x14, MASK_XLEN(0x0)
    c.add x3, x14
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xfffffffffeffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res

 
    # Testcase 220:  rd:x4(0xfffffffffdffffff), rs2:x13(0x00000000), result rd:x4(0xfffffffffdffffff)
    li  x4,  MASK_XLEN(0xfffffffffdffffff)
    li  x13, MASK_XLEN(0x0)
    c.add x4, x13
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xfffffffffdffffff) 
 
    # Testcase 221:  rd:x5(0xfffffffffbffffff), rs2:x12(0x00000000), result rd:x5(0xfffffffffbffffff)
    li  x5,  MASK_XLEN(0xfffffffffbffffff)
    li  x12, MASK_XLEN(0x0)
    c.add x5, x12
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffffffbffffff) 
 
    # Testcase 222:  rd:x6(0xfffffffff7ffffff), rs2:x11(0x00000000), result rd:x6(0xfffffffff7ffffff)
    li  x6,  MASK_XLEN(0xfffffffff7ffffff)
    li  x11, MASK_XLEN(0x0)
    c.add x6, x11
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfffffffff7ffffff) 
 
    # Testcase 223:  rd:x7(0xffffffffefffffff), rs2:x10(0x00000000), result rd:x7(0xffffffffefffffff)
    li  x7,  MASK_XLEN(0xffffffffefffffff)
    li  x10, MASK_XLEN(0x0)
    c.add x7, x10
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffffefffffff) 
 
    # Testcase 224:  rd:x8(0xffffffffdfffffff), rs2:x9(0x00000000), result rd:x8(0xffffffffdfffffff)
    li  x8,  MASK_XLEN(0xffffffffdfffffff)
    li  x9, MASK_XLEN(0x0)
    c.add x8, x9
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffdfffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res

 
    # Testcase 225:  rd:x9(0xffffffffbfffffff), rs2:x8(0x00000000), result rd:x9(0xffffffffbfffffff)
    li  x9,  MASK_XLEN(0xffffffffbfffffff)
    li  x8, MASK_XLEN(0x0)
    c.add x9, x8
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffbfffffff) 
 
    # Testcase 226:  rd:x10(0xffffffff7fffffff), rs2:x7(0x00000000), result rd:x10(0xffffffff7fffffff)
    li  x10,  MASK_XLEN(0xffffffff7fffffff)
    li  x7, MASK_XLEN(0x0)
    c.add x10, x7
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffff7fffffff) 
 
    # Testcase 227:  rd:x11(0xfffffffeffffffff), rs2:x6(0x00000000), result rd:x11(0xfffffffeffffffff)
    li  x11,  MASK_XLEN(0xfffffffeffffffff)
    li  x6, MASK_XLEN(0x0)
    c.add x11, x6
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffeffffffff) 
 
    # Testcase 228:  rd:x12(0xfffffffdffffffff), rs2:x5(0x00000000), result rd:x12(0xfffffffdffffffff)
    li  x12,  MASK_XLEN(0xfffffffdffffffff)
    li  x5, MASK_XLEN(0x0)
    c.add x12, x5
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffdffffffff) 
 
    # Testcase 229:  rd:x13(0xfffffffbffffffff), rs2:x4(0x00000000), result rd:x13(0xfffffffbffffffff)
    li  x13,  MASK_XLEN(0xfffffffbffffffff)
    li  x4, MASK_XLEN(0x0)
    c.add x13, x4
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffbffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x4, test_47_res

 
    # Testcase 230:  rd:x14(0xfffffff7ffffffff), rs2:x3(0x00000000), result rd:x14(0xfffffff7ffffffff)
    li  x14,  MASK_XLEN(0xfffffff7ffffffff)
    li  x3, MASK_XLEN(0x0)
    c.add x14, x3
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xfffffff7ffffffff) 
 
    # Testcase 231:  rd:x15(0xffffffefffffffff), rs2:x2(0x00000000), result rd:x15(0xffffffefffffffff)
    li  x15,  MASK_XLEN(0xffffffefffffffff)
    li  x2, MASK_XLEN(0x0)
    c.add x15, x2
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xffffffefffffffff) 
 
    # Testcase 232:  rd:x16(0xffffffdfffffffff), rs2:x1(0x00000000), result rd:x16(0xffffffdfffffffff)
    li  x16,  MASK_XLEN(0xffffffdfffffffff)
    li  x1, MASK_XLEN(0x0)
    c.add x16, x1
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffffffdfffffffff) 
 
    # Testcase 233:  rd:x17(0xffffffbfffffffff), rs2:x31(0x00000000), result rd:x17(0xffffffbfffffffff)
    li  x17,  MASK_XLEN(0xffffffbfffffffff)
    li  x31, MASK_XLEN(0x0)
    c.add x17, x31
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xffffffbfffffffff) 
 
    # Testcase 234:  rd:x18(0xffffff7fffffffff), rs2:x30(0x00000000), result rd:x18(0xffffff7fffffffff)
    li  x18,  MASK_XLEN(0xffffff7fffffffff)
    li  x30, MASK_XLEN(0x0)
    c.add x18, x30
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xffffff7fffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res

 
    # Testcase 235:  rd:x19(0xfffffeffffffffff), rs2:x29(0x00000000), result rd:x19(0xfffffeffffffffff)
    li  x19,  MASK_XLEN(0xfffffeffffffffff)
    li  x29, MASK_XLEN(0x0)
    c.add x19, x29
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xfffffeffffffffff) 
 
    # Testcase 236:  rd:x20(0xfffffdffffffffff), rs2:x28(0x00000000), result rd:x20(0xfffffdffffffffff)
    li  x20,  MASK_XLEN(0xfffffdffffffffff)
    li  x28, MASK_XLEN(0x0)
    c.add x20, x28
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffffdffffffffff) 
 
    # Testcase 237:  rd:x21(0xfffffbffffffffff), rs2:x27(0x00000000), result rd:x21(0xfffffbffffffffff)
    li  x21,  MASK_XLEN(0xfffffbffffffffff)
    li  x27, MASK_XLEN(0x0)
    c.add x21, x27
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffbffffffffff) 
 
    # Testcase 238:  rd:x22(0xfffff7ffffffffff), rs2:x26(0x00000000), result rd:x22(0xfffff7ffffffffff)
    li  x22,  MASK_XLEN(0xfffff7ffffffffff)
    li  x26, MASK_XLEN(0x0)
    c.add x22, x26
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffff7ffffffffff) 
 
    # Testcase 239:  rd:x23(0xffffefffffffffff), rs2:x25(0x00000000), result rd:x23(0xffffefffffffffff)
    li  x23,  MASK_XLEN(0xffffefffffffffff)
    li  x25, MASK_XLEN(0x0)
    c.add x23, x25
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffefffffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res

 
    # Testcase 240:  rd:x25(0xffffdfffffffffff), rs2:x24(0x00000000), result rd:x25(0xffffdfffffffffff)
    li  x25,  MASK_XLEN(0xffffdfffffffffff)
    li  x24, MASK_XLEN(0x0)
    c.add x25, x24
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffdfffffffffff) 
 
    # Testcase 241:  rd:x25(0xffffbfffffffffff), rs2:x23(0x00000000), result rd:x25(0xffffbfffffffffff)
    li  x25,  MASK_XLEN(0xffffbfffffffffff)
    li  x23, MASK_XLEN(0x0)
    c.add x25, x23
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffbfffffffffff) 
 
    # Testcase 242:  rd:x26(0xffff7fffffffffff), rs2:x22(0x00000000), result rd:x26(0xffff7fffffffffff)
    li  x26,  MASK_XLEN(0xffff7fffffffffff)
    li  x22, MASK_XLEN(0x0)
    c.add x26, x22
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffff7fffffffffff) 
 
    # Testcase 243:  rd:x27(0xfffeffffffffffff), rs2:x21(0x00000000), result rd:x27(0xfffeffffffffffff)
    li  x27,  MASK_XLEN(0xfffeffffffffffff)
    li  x21, MASK_XLEN(0x0)
    c.add x27, x21
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfffeffffffffffff) 
 
    # Testcase 244:  rd:x28(0xfffdffffffffffff), rs2:x20(0x00000000), result rd:x28(0xfffdffffffffffff)
    li  x28,  MASK_XLEN(0xfffdffffffffffff)
    li  x20, MASK_XLEN(0x0)
    c.add x28, x20
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffdffffffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x4, test_50_res

 
    # Testcase 245:  rd:x29(0xfffbffffffffffff), rs2:x19(0x00000000), result rd:x29(0xfffbffffffffffff)
    li  x29,  MASK_XLEN(0xfffbffffffffffff)
    li  x19, MASK_XLEN(0x0)
    c.add x29, x19
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0xfffbffffffffffff) 
 
    # Testcase 246:  rd:x30(0xfff7ffffffffffff), rs2:x18(0x00000000), result rd:x30(0xfff7ffffffffffff)
    li  x30,  MASK_XLEN(0xfff7ffffffffffff)
    li  x18, MASK_XLEN(0x0)
    c.add x30, x18
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfff7ffffffffffff) 
 
    # Testcase 247:  rd:x31(0xffefffffffffffff), rs2:x17(0x00000000), result rd:x31(0xffefffffffffffff)
    li  x31,  MASK_XLEN(0xffefffffffffffff)
    li  x17, MASK_XLEN(0x0)
    c.add x31, x17
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xffefffffffffffff) 
 
    # Testcase 248:  rd:x1(0xffdfffffffffffff), rs2:x16(0x00000000), result rd:x1(0xffdfffffffffffff)
    li  x1,  MASK_XLEN(0xffdfffffffffffff)
    li  x16, MASK_XLEN(0x0)
    c.add x1, x16
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffdfffffffffffff) 
 
    # Testcase 249:  rd:x2(0xffbfffffffffffff), rs2:x15(0x00000000), result rd:x2(0xffbfffffffffffff)
    li  x2,  MASK_XLEN(0xffbfffffffffffff)
    li  x15, MASK_XLEN(0x0)
    c.add x2, x15
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffbfffffffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res

 
    # Testcase 250:  rd:x3(0xff7fffffffffffff), rs2:x14(0x00000000), result rd:x3(0xff7fffffffffffff)
    li  x3,  MASK_XLEN(0xff7fffffffffffff)
    li  x14, MASK_XLEN(0x0)
    c.add x3, x14
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xff7fffffffffffff) 
 
    # Testcase 251:  rd:x4(0xfeffffffffffffff), rs2:x13(0x00000000), result rd:x4(0xfeffffffffffffff)
    li  x4,  MASK_XLEN(0xfeffffffffffffff)
    li  x13, MASK_XLEN(0x0)
    c.add x4, x13
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xfeffffffffffffff) 
 
    # Testcase 252:  rd:x5(0xfdffffffffffffff), rs2:x12(0x00000000), result rd:x5(0xfdffffffffffffff)
    li  x5,  MASK_XLEN(0xfdffffffffffffff)
    li  x12, MASK_XLEN(0x0)
    c.add x5, x12
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfdffffffffffffff) 
 
    # Testcase 253:  rd:x6(0xfbffffffffffffff), rs2:x11(0x00000000), result rd:x6(0xfbffffffffffffff)
    li  x6,  MASK_XLEN(0xfbffffffffffffff)
    li  x11, MASK_XLEN(0x0)
    c.add x6, x11
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfbffffffffffffff) 
 
    # Testcase 254:  rd:x7(0xf7ffffffffffffff), rs2:x10(0x00000000), result rd:x7(0xf7ffffffffffffff)
    li  x7,  MASK_XLEN(0xf7ffffffffffffff)
    li  x10, MASK_XLEN(0x0)
    c.add x7, x10
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xf7ffffffffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res

 
    # Testcase 255:  rd:x8(0xefffffffffffffff), rs2:x9(0x00000000), result rd:x8(0xefffffffffffffff)
    li  x8,  MASK_XLEN(0xefffffffffffffff)
    li  x9, MASK_XLEN(0x0)
    c.add x8, x9
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xefffffffffffffff) 
 
    # Testcase 256:  rd:x9(0xdfffffffffffffff), rs2:x8(0x00000000), result rd:x9(0xdfffffffffffffff)
    li  x9,  MASK_XLEN(0xdfffffffffffffff)
    li  x8, MASK_XLEN(0x0)
    c.add x9, x8
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xdfffffffffffffff) 
 
    # Testcase 257:  rd:x10(0xbfffffffffffffff), rs2:x7(0x00000000), result rd:x10(0xbfffffffffffffff)
    li  x10,  MASK_XLEN(0xbfffffffffffffff)
    li  x7, MASK_XLEN(0x0)
    c.add x10, x7
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xbfffffffffffffff) 
 
    # Testcase 258:  rd:x11(0x7fffffffffffffff), rs2:x6(0x00000000), result rd:x11(0x7fffffffffffffff)
    li  x11,  MASK_XLEN(0x7fffffffffffffff)
    li  x6, MASK_XLEN(0x0)
    c.add x11, x6
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7fffffffffffffff) 
 
    # Testcase 259:  rd:x12(0xffffffffffffffff), rs2:x5(0x00000000), result rd:x12(0xffffffffffffffff)
    li  x12,  MASK_XLEN(0xffffffffffffffff)
    li  x5, MASK_XLEN(0x0)
    c.add x12, x5
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x5, test_53_res

 
    # Testcase 260:  rd:x13(0x00000001), rs2:x4(0xffffffffffffffff), result rd:x13(0x00000000)
    li  x13,  MASK_XLEN(0x1)
    li  x4, MASK_XLEN(0xffffffffffffffff)
    c.add x13, x4
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x0) 
 
    # Testcase 261:  rd:x14(0x00000002), rs2:x3(0x7fffffffffffffff), result rd:x14(0x8000000000000001)
    li  x14,  MASK_XLEN(0x2)
    li  x3, MASK_XLEN(0x7fffffffffffffff)
    c.add x14, x3
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x8000000000000001) 
 
    # Testcase 262:  rd:x15(0x00000004), rs2:x2(0xbfffffffffffffff), result rd:x15(0xc000000000000003)
    li  x15,  MASK_XLEN(0x4)
    li  x2, MASK_XLEN(0xbfffffffffffffff)
    c.add x15, x2
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xc000000000000003) 
 
    # Testcase 263:  rd:x16(0x00000008), rs2:x1(0xdfffffffffffffff), result rd:x16(0xe000000000000007)
    li  x16,  MASK_XLEN(0x8)
    li  x1, MASK_XLEN(0xdfffffffffffffff)
    c.add x16, x1
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xe000000000000007) 



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

