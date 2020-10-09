# RISC-V Compliance Test I-C-AND-01
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
# Description: Testing instruction 'c.and'.

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

 
    # Testcase 0:  rd:x8(0x00000001), rs2:x12(0xffffffffffffffff), result rd:x8(0x00000001)
    li  x12, MASK_XLEN(0xffffffffffffffff)
    li  x8, MASK_XLEN(0x1)
    c.and x8, x12
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1) 
 
    # Testcase 1:  rd:x9(0x00000002), rs2:x13(0x7fffffffffffffff), result rd:x9(0x00000002)
    li  x13, MASK_XLEN(0x7fffffffffffffff)
    li  x9, MASK_XLEN(0x2)
    c.and x9, x13
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x2) 
 
    # Testcase 2:  rd:x10(0x00000004), rs2:x14(0xbfffffffffffffff), result rd:x10(0x00000004)
    li  x14, MASK_XLEN(0xbfffffffffffffff)
    li  x10, MASK_XLEN(0x4)
    c.and x10, x14
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x4) 
 
    # Testcase 3:  rd:x11(0x00000008), rs2:x15(0xdfffffffffffffff), result rd:x11(0x00000008)
    li  x15, MASK_XLEN(0xdfffffffffffffff)
    li  x11, MASK_XLEN(0x8)
    c.and x11, x15
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8) 
 
    # Testcase 4:  rd:x12(0x00000010), rs2:x8(0xefffffffffffffff), result rd:x12(0x00000010)
    li  x8, MASK_XLEN(0xefffffffffffffff)
    li  x12, MASK_XLEN(0x10)
    c.and x12, x8
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x10) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res

 
    # Testcase 5:  rd:x13(0x00000020), rs2:x9(0xf7ffffffffffffff), result rd:x13(0x00000020)
    li  x9, MASK_XLEN(0xf7ffffffffffffff)
    li  x13, MASK_XLEN(0x20)
    c.and x13, x9
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x20) 
 
    # Testcase 6:  rd:x14(0x00000040), rs2:x10(0xfbffffffffffffff), result rd:x14(0x00000040)
    li  x10, MASK_XLEN(0xfbffffffffffffff)
    li  x14, MASK_XLEN(0x40)
    c.and x14, x10
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x40) 
 
    # Testcase 7:  rd:x15(0x00000080), rs2:x11(0xfdffffffffffffff), result rd:x15(0x00000080)
    li  x11, MASK_XLEN(0xfdffffffffffffff)
    li  x15, MASK_XLEN(0x80)
    c.and x15, x11
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x80) 
 
    # Testcase 8:  rd:x8(0x00000100), rs2:x12(0xfeffffffffffffff), result rd:x8(0x00000100)
    li  x12, MASK_XLEN(0xfeffffffffffffff)
    li  x8, MASK_XLEN(0x100)
    c.and x8, x12
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x100) 
 
    # Testcase 9:  rd:x9(0x00000200), rs2:x13(0xff7fffffffffffff), result rd:x9(0x00000200)
    li  x13, MASK_XLEN(0xff7fffffffffffff)
    li  x9, MASK_XLEN(0x200)
    c.and x9, x13
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x200) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res

 
    # Testcase 10:  rd:x10(0x00000400), rs2:x14(0xffbfffffffffffff), result rd:x10(0x00000400)
    li  x14, MASK_XLEN(0xffbfffffffffffff)
    li  x10, MASK_XLEN(0x400)
    c.and x10, x14
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x400) 
 
    # Testcase 11:  rd:x11(0x00000800), rs2:x15(0xffdfffffffffffff), result rd:x11(0x00000800)
    li  x15, MASK_XLEN(0xffdfffffffffffff)
    li  x11, MASK_XLEN(0x800)
    c.and x11, x15
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x800) 
 
    # Testcase 12:  rd:x12(0x00001000), rs2:x8(0xffefffffffffffff), result rd:x12(0x00001000)
    li  x8, MASK_XLEN(0xffefffffffffffff)
    li  x12, MASK_XLEN(0x1000)
    c.and x12, x8
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000) 
 
    # Testcase 13:  rd:x13(0x00002000), rs2:x9(0xfff7ffffffffffff), result rd:x13(0x00002000)
    li  x9, MASK_XLEN(0xfff7ffffffffffff)
    li  x13, MASK_XLEN(0x2000)
    c.and x13, x9
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x2000) 
 
    # Testcase 14:  rd:x14(0x00004000), rs2:x10(0xfffbffffffffffff), result rd:x14(0x00004000)
    li  x10, MASK_XLEN(0xfffbffffffffffff)
    li  x14, MASK_XLEN(0x4000)
    c.and x14, x10
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x4000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x1, test_4_res

 
    # Testcase 15:  rd:x15(0x00008000), rs2:x11(0xfffdffffffffffff), result rd:x15(0x00008000)
    li  x11, MASK_XLEN(0xfffdffffffffffff)
    li  x15, MASK_XLEN(0x8000)
    c.and x15, x11
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x8000) 
 
    # Testcase 16:  rd:x8(0x00010000), rs2:x12(0xfffeffffffffffff), result rd:x8(0x00010000)
    li  x12, MASK_XLEN(0xfffeffffffffffff)
    li  x8, MASK_XLEN(0x10000)
    c.and x8, x12
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x10000) 
 
    # Testcase 17:  rd:x9(0x00020000), rs2:x13(0xffff7fffffffffff), result rd:x9(0x00020000)
    li  x13, MASK_XLEN(0xffff7fffffffffff)
    li  x9, MASK_XLEN(0x20000)
    c.and x9, x13
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20000) 
 
    # Testcase 18:  rd:x10(0x00040000), rs2:x14(0xffffbfffffffffff), result rd:x10(0x00040000)
    li  x14, MASK_XLEN(0xffffbfffffffffff)
    li  x10, MASK_XLEN(0x40000)
    c.and x10, x14
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x40000) 
 
    # Testcase 19:  rd:x11(0x00080000), rs2:x15(0xffffdfffffffffff), result rd:x11(0x00080000)
    li  x15, MASK_XLEN(0xffffdfffffffffff)
    li  x11, MASK_XLEN(0x80000)
    c.and x11, x15
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x80000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res

 
    # Testcase 20:  rd:x12(0x00100000), rs2:x8(0xffffefffffffffff), result rd:x12(0x00100000)
    li  x8, MASK_XLEN(0xffffefffffffffff)
    li  x12, MASK_XLEN(0x100000)
    c.and x12, x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x100000) 
 
    # Testcase 21:  rd:x13(0x00200000), rs2:x9(0xfffff7ffffffffff), result rd:x13(0x00200000)
    li  x9, MASK_XLEN(0xfffff7ffffffffff)
    li  x13, MASK_XLEN(0x200000)
    c.and x13, x9
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x200000) 
 
    # Testcase 22:  rd:x14(0x00400000), rs2:x10(0xfffffbffffffffff), result rd:x14(0x00400000)
    li  x10, MASK_XLEN(0xfffffbffffffffff)
    li  x14, MASK_XLEN(0x400000)
    c.and x14, x10
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x400000) 
 
    # Testcase 23:  rd:x15(0x00800000), rs2:x11(0xfffffdffffffffff), result rd:x15(0x00800000)
    li  x11, MASK_XLEN(0xfffffdffffffffff)
    li  x15, MASK_XLEN(0x800000)
    c.and x15, x11
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x800000) 
 
    # Testcase 24:  rd:x8(0x01000000), rs2:x12(0xfffffeffffffffff), result rd:x8(0x01000000)
    li  x12, MASK_XLEN(0xfffffeffffffffff)
    li  x8, MASK_XLEN(0x1000000)
    c.and x8, x12
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res

 
    # Testcase 25:  rd:x9(0x02000000), rs2:x13(0xffffff7fffffffff), result rd:x9(0x02000000)
    li  x13, MASK_XLEN(0xffffff7fffffffff)
    li  x9, MASK_XLEN(0x2000000)
    c.and x9, x13
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x2000000) 
 
    # Testcase 26:  rd:x10(0x04000000), rs2:x14(0xffffffbfffffffff), result rd:x10(0x04000000)
    li  x14, MASK_XLEN(0xffffffbfffffffff)
    li  x10, MASK_XLEN(0x4000000)
    c.and x10, x14
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x4000000) 
 
    # Testcase 27:  rd:x11(0x08000000), rs2:x15(0xffffffdfffffffff), result rd:x11(0x08000000)
    li  x15, MASK_XLEN(0xffffffdfffffffff)
    li  x11, MASK_XLEN(0x8000000)
    c.and x11, x15
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8000000) 
 
    # Testcase 28:  rd:x12(0x10000000), rs2:x8(0xffffffefffffffff), result rd:x12(0x10000000)
    li  x8, MASK_XLEN(0xffffffefffffffff)
    li  x12, MASK_XLEN(0x10000000)
    c.and x12, x8
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x10000000) 
 
    # Testcase 29:  rd:x13(0x20000000), rs2:x9(0xfffffff7ffffffff), result rd:x13(0x20000000)
    li  x9, MASK_XLEN(0xfffffff7ffffffff)
    li  x13, MASK_XLEN(0x20000000)
    c.and x13, x9
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x20000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x1, test_7_res

 
    # Testcase 30:  rd:x14(0x40000000), rs2:x10(0xfffffffbffffffff), result rd:x14(0x40000000)
    li  x10, MASK_XLEN(0xfffffffbffffffff)
    li  x14, MASK_XLEN(0x40000000)
    c.and x14, x10
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x40000000) 
 
    # Testcase 31:  rd:x15(0x80000000), rs2:x11(0xfffffffdffffffff), result rd:x15(0x80000000)
    li  x11, MASK_XLEN(0xfffffffdffffffff)
    li  x15, MASK_XLEN(0x80000000)
    c.and x15, x11
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x80000000) 
 
    # Testcase 32:  rd:x8(0x100000000), rs2:x12(0xfffffffeffffffff), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0xfffffffeffffffff)
    li  x8, MASK_XLEN(0x100000000)
    c.and x8, x12
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 33:  rd:x9(0x200000000), rs2:x13(0xffffffff7fffffff), result rd:x9(0x200000000)
    li  x13, MASK_XLEN(0xffffffff7fffffff)
    li  x9, MASK_XLEN(0x200000000)
    c.and x9, x13
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x200000000) 
 
    # Testcase 34:  rd:x10(0x400000000), rs2:x14(0xffffffffbfffffff), result rd:x10(0x400000000)
    li  x14, MASK_XLEN(0xffffffffbfffffff)
    li  x10, MASK_XLEN(0x400000000)
    c.and x10, x14
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x400000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res

 
    # Testcase 35:  rd:x11(0x800000000), rs2:x15(0xffffffffdfffffff), result rd:x11(0x800000000)
    li  x15, MASK_XLEN(0xffffffffdfffffff)
    li  x11, MASK_XLEN(0x800000000)
    c.and x11, x15
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x800000000) 
 
    # Testcase 36:  rd:x12(0x1000000000), rs2:x8(0xffffffffefffffff), result rd:x12(0x1000000000)
    li  x8, MASK_XLEN(0xffffffffefffffff)
    li  x12, MASK_XLEN(0x1000000000)
    c.and x12, x8
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000000000) 
 
    # Testcase 37:  rd:x13(0x2000000000), rs2:x9(0xfffffffff7ffffff), result rd:x13(0x2000000000)
    li  x9, MASK_XLEN(0xfffffffff7ffffff)
    li  x13, MASK_XLEN(0x2000000000)
    c.and x13, x9
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x2000000000) 
 
    # Testcase 38:  rd:x14(0x4000000000), rs2:x10(0xfffffffffbffffff), result rd:x14(0x4000000000)
    li  x10, MASK_XLEN(0xfffffffffbffffff)
    li  x14, MASK_XLEN(0x4000000000)
    c.and x14, x10
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x4000000000) 
 
    # Testcase 39:  rd:x15(0x8000000000), rs2:x11(0xfffffffffdffffff), result rd:x15(0x8000000000)
    li  x11, MASK_XLEN(0xfffffffffdffffff)
    li  x15, MASK_XLEN(0x8000000000)
    c.and x15, x11
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x8000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res

 
    # Testcase 40:  rd:x8(0x10000000000), rs2:x12(0xfffffffffeffffff), result rd:x8(0x10000000000)
    li  x12, MASK_XLEN(0xfffffffffeffffff)
    li  x8, MASK_XLEN(0x10000000000)
    c.and x8, x12
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x10000000000) 
 
    # Testcase 41:  rd:x9(0x20000000000), rs2:x13(0xffffffffff7fffff), result rd:x9(0x20000000000)
    li  x13, MASK_XLEN(0xffffffffff7fffff)
    li  x9, MASK_XLEN(0x20000000000)
    c.and x9, x13
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20000000000) 
 
    # Testcase 42:  rd:x10(0x40000000000), rs2:x14(0xffffffffffbfffff), result rd:x10(0x40000000000)
    li  x14, MASK_XLEN(0xffffffffffbfffff)
    li  x10, MASK_XLEN(0x40000000000)
    c.and x10, x14
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x40000000000) 
 
    # Testcase 43:  rd:x11(0x80000000000), rs2:x15(0xffffffffffdfffff), result rd:x11(0x80000000000)
    li  x15, MASK_XLEN(0xffffffffffdfffff)
    li  x11, MASK_XLEN(0x80000000000)
    c.and x11, x15
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x80000000000) 
 
    # Testcase 44:  rd:x12(0x100000000000), rs2:x8(0xffffffffffefffff), result rd:x12(0x100000000000)
    li  x8, MASK_XLEN(0xffffffffffefffff)
    li  x12, MASK_XLEN(0x100000000000)
    c.and x12, x8
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x100000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x1, test_10_res

 
    # Testcase 45:  rd:x13(0x200000000000), rs2:x9(0xfffffffffff7ffff), result rd:x13(0x200000000000)
    li  x9, MASK_XLEN(0xfffffffffff7ffff)
    li  x13, MASK_XLEN(0x200000000000)
    c.and x13, x9
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x200000000000) 
 
    # Testcase 46:  rd:x14(0x400000000000), rs2:x10(0xfffffffffffbffff), result rd:x14(0x400000000000)
    li  x10, MASK_XLEN(0xfffffffffffbffff)
    li  x14, MASK_XLEN(0x400000000000)
    c.and x14, x10
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x400000000000) 
 
    # Testcase 47:  rd:x15(0x800000000000), rs2:x11(0xfffffffffffdffff), result rd:x15(0x800000000000)
    li  x11, MASK_XLEN(0xfffffffffffdffff)
    li  x15, MASK_XLEN(0x800000000000)
    c.and x15, x11
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x800000000000) 
 
    # Testcase 48:  rd:x8(0x1000000000000), rs2:x12(0xfffffffffffeffff), result rd:x8(0x1000000000000)
    li  x12, MASK_XLEN(0xfffffffffffeffff)
    li  x8, MASK_XLEN(0x1000000000000)
    c.and x8, x12
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1000000000000) 
 
    # Testcase 49:  rd:x9(0x2000000000000), rs2:x13(0xffffffffffff7fff), result rd:x9(0x2000000000000)
    li  x13, MASK_XLEN(0xffffffffffff7fff)
    li  x9, MASK_XLEN(0x2000000000000)
    c.and x9, x13
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x2000000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res

 
    # Testcase 50:  rd:x10(0x4000000000000), rs2:x14(0xffffffffffffbfff), result rd:x10(0x4000000000000)
    li  x14, MASK_XLEN(0xffffffffffffbfff)
    li  x10, MASK_XLEN(0x4000000000000)
    c.and x10, x14
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x4000000000000) 
 
    # Testcase 51:  rd:x11(0x8000000000000), rs2:x15(0xffffffffffffdfff), result rd:x11(0x8000000000000)
    li  x15, MASK_XLEN(0xffffffffffffdfff)
    li  x11, MASK_XLEN(0x8000000000000)
    c.and x11, x15
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8000000000000) 
 
    # Testcase 52:  rd:x12(0x10000000000000), rs2:x8(0xffffffffffffefff), result rd:x12(0x10000000000000)
    li  x8, MASK_XLEN(0xffffffffffffefff)
    li  x12, MASK_XLEN(0x10000000000000)
    c.and x12, x8
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x10000000000000) 
 
    # Testcase 53:  rd:x13(0x20000000000000), rs2:x9(0xfffffffffffff7ff), result rd:x13(0x20000000000000)
    li  x9, MASK_XLEN(0xfffffffffffff7ff)
    li  x13, MASK_XLEN(0x20000000000000)
    c.and x13, x9
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x20000000000000) 
 
    # Testcase 54:  rd:x14(0x40000000000000), rs2:x10(0xfffffffffffffbff), result rd:x14(0x40000000000000)
    li  x10, MASK_XLEN(0xfffffffffffffbff)
    li  x14, MASK_XLEN(0x40000000000000)
    c.and x14, x10
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x40000000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res

 
    # Testcase 55:  rd:x15(0x80000000000000), rs2:x11(0xfffffffffffffdff), result rd:x15(0x80000000000000)
    li  x11, MASK_XLEN(0xfffffffffffffdff)
    li  x15, MASK_XLEN(0x80000000000000)
    c.and x15, x11
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x80000000000000) 
 
    # Testcase 56:  rd:x8(0x100000000000000), rs2:x12(0xfffffffffffffeff), result rd:x8(0x100000000000000)
    li  x12, MASK_XLEN(0xfffffffffffffeff)
    li  x8, MASK_XLEN(0x100000000000000)
    c.and x8, x12
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x100000000000000) 
 
    # Testcase 57:  rd:x9(0x200000000000000), rs2:x13(0xffffffffffffff7f), result rd:x9(0x200000000000000)
    li  x13, MASK_XLEN(0xffffffffffffff7f)
    li  x9, MASK_XLEN(0x200000000000000)
    c.and x9, x13
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x200000000000000) 
 
    # Testcase 58:  rd:x10(0x400000000000000), rs2:x14(0xffffffffffffffbf), result rd:x10(0x400000000000000)
    li  x14, MASK_XLEN(0xffffffffffffffbf)
    li  x10, MASK_XLEN(0x400000000000000)
    c.and x10, x14
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x400000000000000) 
 
    # Testcase 59:  rd:x11(0x800000000000000), rs2:x15(0xffffffffffffffdf), result rd:x11(0x800000000000000)
    li  x15, MASK_XLEN(0xffffffffffffffdf)
    li  x11, MASK_XLEN(0x800000000000000)
    c.and x11, x15
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x800000000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x1, test_13_res

 
    # Testcase 60:  rd:x12(0x1000000000000000), rs2:x8(0xffffffffffffffef), result rd:x12(0x1000000000000000)
    li  x8, MASK_XLEN(0xffffffffffffffef)
    li  x12, MASK_XLEN(0x1000000000000000)
    c.and x12, x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000000000000000) 
 
    # Testcase 61:  rd:x13(0x2000000000000000), rs2:x9(0xfffffffffffffff7), result rd:x13(0x2000000000000000)
    li  x9, MASK_XLEN(0xfffffffffffffff7)
    li  x13, MASK_XLEN(0x2000000000000000)
    c.and x13, x9
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x2000000000000000) 
 
    # Testcase 62:  rd:x14(0x4000000000000000), rs2:x10(0xfffffffffffffffb), result rd:x14(0x4000000000000000)
    li  x10, MASK_XLEN(0xfffffffffffffffb)
    li  x14, MASK_XLEN(0x4000000000000000)
    c.and x14, x10
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x4000000000000000) 
 
    # Testcase 63:  rd:x15(0x8000000000000000), rs2:x11(0xfffffffffffffffd), result rd:x15(0x8000000000000000)
    li  x11, MASK_XLEN(0xfffffffffffffffd)
    li  x15, MASK_XLEN(0x8000000000000000)
    c.and x15, x11
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x8000000000000000) 
 
    # Testcase 64:  rd:x8(0x00000000), rs2:x12(0xfffffffffffffffe), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0xfffffffffffffffe)
    li  x8, MASK_XLEN(0x0)
    c.and x8, x12
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res

 
    # Testcase 65:  rd:x9(0xfffffffffffffffe), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xfffffffffffffffe)
    c.and x9, x13
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 66:  rd:x10(0xfffffffffffffffd), rs2:x14(0x8000000000000000), result rd:x10(0x8000000000000000)
    li  x14, MASK_XLEN(0x8000000000000000)
    li  x10, MASK_XLEN(0xfffffffffffffffd)
    c.and x10, x14
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000000000000000) 
 
    # Testcase 67:  rd:x11(0xfffffffffffffffb), rs2:x15(0x4000000000000000), result rd:x11(0x4000000000000000)
    li  x15, MASK_XLEN(0x4000000000000000)
    li  x11, MASK_XLEN(0xfffffffffffffffb)
    c.and x11, x15
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x4000000000000000) 
 
    # Testcase 68:  rd:x12(0xfffffffffffffff7), rs2:x8(0x2000000000000000), result rd:x12(0x2000000000000000)
    li  x8, MASK_XLEN(0x2000000000000000)
    li  x12, MASK_XLEN(0xfffffffffffffff7)
    c.and x12, x8
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2000000000000000) 
 
    # Testcase 69:  rd:x13(0xffffffffffffffef), rs2:x9(0x1000000000000000), result rd:x13(0x1000000000000000)
    li  x9, MASK_XLEN(0x1000000000000000)
    li  x13, MASK_XLEN(0xffffffffffffffef)
    c.and x13, x9
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x1000000000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res

 
    # Testcase 70:  rd:x14(0xffffffffffffffdf), rs2:x10(0x800000000000000), result rd:x14(0x800000000000000)
    li  x10, MASK_XLEN(0x800000000000000)
    li  x14, MASK_XLEN(0xffffffffffffffdf)
    c.and x14, x10
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800000000000000) 
 
    # Testcase 71:  rd:x15(0xffffffffffffffbf), rs2:x11(0x400000000000000), result rd:x15(0x400000000000000)
    li  x11, MASK_XLEN(0x400000000000000)
    li  x15, MASK_XLEN(0xffffffffffffffbf)
    c.and x15, x11
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x400000000000000) 
 
    # Testcase 72:  rd:x8(0xffffffffffffff7f), rs2:x12(0x200000000000000), result rd:x8(0x200000000000000)
    li  x12, MASK_XLEN(0x200000000000000)
    li  x8, MASK_XLEN(0xffffffffffffff7f)
    c.and x8, x12
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x200000000000000) 
 
    # Testcase 73:  rd:x9(0xfffffffffffffeff), rs2:x13(0x100000000000000), result rd:x9(0x100000000000000)
    li  x13, MASK_XLEN(0x100000000000000)
    li  x9, MASK_XLEN(0xfffffffffffffeff)
    c.and x9, x13
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x100000000000000) 
 
    # Testcase 74:  rd:x10(0xfffffffffffffdff), rs2:x14(0x80000000000000), result rd:x10(0x80000000000000)
    li  x14, MASK_XLEN(0x80000000000000)
    li  x10, MASK_XLEN(0xfffffffffffffdff)
    c.and x10, x14
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80000000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x1, test_16_res

 
    # Testcase 75:  rd:x11(0xfffffffffffffbff), rs2:x15(0x40000000000000), result rd:x11(0x40000000000000)
    li  x15, MASK_XLEN(0x40000000000000)
    li  x11, MASK_XLEN(0xfffffffffffffbff)
    c.and x11, x15
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x40000000000000) 
 
    # Testcase 76:  rd:x12(0xfffffffffffff7ff), rs2:x8(0x20000000000000), result rd:x12(0x20000000000000)
    li  x8, MASK_XLEN(0x20000000000000)
    li  x12, MASK_XLEN(0xfffffffffffff7ff)
    c.and x12, x8
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20000000000000) 
 
    # Testcase 77:  rd:x13(0xffffffffffffefff), rs2:x9(0x10000000000000), result rd:x13(0x10000000000000)
    li  x9, MASK_XLEN(0x10000000000000)
    li  x13, MASK_XLEN(0xffffffffffffefff)
    c.and x13, x9
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x10000000000000) 
 
    # Testcase 78:  rd:x14(0xffffffffffffdfff), rs2:x10(0x8000000000000), result rd:x14(0x8000000000000)
    li  x10, MASK_XLEN(0x8000000000000)
    li  x14, MASK_XLEN(0xffffffffffffdfff)
    c.and x14, x10
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000000000000) 
 
    # Testcase 79:  rd:x15(0xffffffffffffbfff), rs2:x11(0x4000000000000), result rd:x15(0x4000000000000)
    li  x11, MASK_XLEN(0x4000000000000)
    li  x15, MASK_XLEN(0xffffffffffffbfff)
    c.and x15, x11
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x4000000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res

 
    # Testcase 80:  rd:x8(0xffffffffffff7fff), rs2:x12(0x2000000000000), result rd:x8(0x2000000000000)
    li  x12, MASK_XLEN(0x2000000000000)
    li  x8, MASK_XLEN(0xffffffffffff7fff)
    c.and x8, x12
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000000000000) 
 
    # Testcase 81:  rd:x9(0xfffffffffffeffff), rs2:x13(0x1000000000000), result rd:x9(0x1000000000000)
    li  x13, MASK_XLEN(0x1000000000000)
    li  x9, MASK_XLEN(0xfffffffffffeffff)
    c.and x9, x13
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1000000000000) 
 
    # Testcase 82:  rd:x10(0xfffffffffffdffff), rs2:x14(0x800000000000), result rd:x10(0x800000000000)
    li  x14, MASK_XLEN(0x800000000000)
    li  x10, MASK_XLEN(0xfffffffffffdffff)
    c.and x10, x14
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x800000000000) 
 
    # Testcase 83:  rd:x11(0xfffffffffffbffff), rs2:x15(0x400000000000), result rd:x11(0x400000000000)
    li  x15, MASK_XLEN(0x400000000000)
    li  x11, MASK_XLEN(0xfffffffffffbffff)
    c.and x11, x15
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400000000000) 
 
    # Testcase 84:  rd:x12(0xfffffffffff7ffff), rs2:x8(0x200000000000), result rd:x12(0x200000000000)
    li  x8, MASK_XLEN(0x200000000000)
    li  x12, MASK_XLEN(0xfffffffffff7ffff)
    c.and x12, x8
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res

 
    # Testcase 85:  rd:x13(0xffffffffffefffff), rs2:x9(0x100000000000), result rd:x13(0x100000000000)
    li  x9, MASK_XLEN(0x100000000000)
    li  x13, MASK_XLEN(0xffffffffffefffff)
    c.and x13, x9
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x100000000000) 
 
    # Testcase 86:  rd:x14(0xffffffffffdfffff), rs2:x10(0x80000000000), result rd:x14(0x80000000000)
    li  x10, MASK_XLEN(0x80000000000)
    li  x14, MASK_XLEN(0xffffffffffdfffff)
    c.and x14, x10
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x80000000000) 
 
    # Testcase 87:  rd:x15(0xffffffffffbfffff), rs2:x11(0x40000000000), result rd:x15(0x40000000000)
    li  x11, MASK_XLEN(0x40000000000)
    li  x15, MASK_XLEN(0xffffffffffbfffff)
    c.and x15, x11
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x40000000000) 
 
    # Testcase 88:  rd:x8(0xffffffffff7fffff), rs2:x12(0x20000000000), result rd:x8(0x20000000000)
    li  x12, MASK_XLEN(0x20000000000)
    li  x8, MASK_XLEN(0xffffffffff7fffff)
    c.and x8, x12
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000000000) 
 
    # Testcase 89:  rd:x9(0xfffffffffeffffff), rs2:x13(0x10000000000), result rd:x9(0x10000000000)
    li  x13, MASK_XLEN(0x10000000000)
    li  x9, MASK_XLEN(0xfffffffffeffffff)
    c.and x9, x13
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x10000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x1, test_19_res

 
    # Testcase 90:  rd:x10(0xfffffffffdffffff), rs2:x14(0x8000000000), result rd:x10(0x8000000000)
    li  x14, MASK_XLEN(0x8000000000)
    li  x10, MASK_XLEN(0xfffffffffdffffff)
    c.and x10, x14
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000000000) 
 
    # Testcase 91:  rd:x11(0xfffffffffbffffff), rs2:x15(0x4000000000), result rd:x11(0x4000000000)
    li  x15, MASK_XLEN(0x4000000000)
    li  x11, MASK_XLEN(0xfffffffffbffffff)
    c.and x11, x15
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x4000000000) 
 
    # Testcase 92:  rd:x12(0xfffffffff7ffffff), rs2:x8(0x2000000000), result rd:x12(0x2000000000)
    li  x8, MASK_XLEN(0x2000000000)
    li  x12, MASK_XLEN(0xfffffffff7ffffff)
    c.and x12, x8
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2000000000) 
 
    # Testcase 93:  rd:x13(0xffffffffefffffff), rs2:x9(0x1000000000), result rd:x13(0x1000000000)
    li  x9, MASK_XLEN(0x1000000000)
    li  x13, MASK_XLEN(0xffffffffefffffff)
    c.and x13, x9
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x1000000000) 
 
    # Testcase 94:  rd:x14(0xffffffffdfffffff), rs2:x10(0x800000000), result rd:x14(0x800000000)
    li  x10, MASK_XLEN(0x800000000)
    li  x14, MASK_XLEN(0xffffffffdfffffff)
    c.and x14, x10
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res

 
    # Testcase 95:  rd:x15(0xffffffffbfffffff), rs2:x11(0x400000000), result rd:x15(0x400000000)
    li  x11, MASK_XLEN(0x400000000)
    li  x15, MASK_XLEN(0xffffffffbfffffff)
    c.and x15, x11
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x400000000) 
 
    # Testcase 96:  rd:x8(0xffffffff7fffffff), rs2:x12(0x200000000), result rd:x8(0x200000000)
    li  x12, MASK_XLEN(0x200000000)
    li  x8, MASK_XLEN(0xffffffff7fffffff)
    c.and x8, x12
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x200000000) 
 
    # Testcase 97:  rd:x9(0xfffffffeffffffff), rs2:x13(0x100000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x100000000)
    li  x9, MASK_XLEN(0xfffffffeffffffff)
    c.and x9, x13
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 98:  rd:x10(0xfffffffdffffffff), rs2:x14(0x80000000), result rd:x10(0x80000000)
    li  x14, MASK_XLEN(0x80000000)
    li  x10, MASK_XLEN(0xfffffffdffffffff)
    c.and x10, x14
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80000000) 
 
    # Testcase 99:  rd:x11(0xfffffffbffffffff), rs2:x15(0x40000000), result rd:x11(0x40000000)
    li  x15, MASK_XLEN(0x40000000)
    li  x11, MASK_XLEN(0xfffffffbffffffff)
    c.and x11, x15
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x40000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res

 
    # Testcase 100:  rd:x12(0xfffffff7ffffffff), rs2:x8(0x20000000), result rd:x12(0x20000000)
    li  x8, MASK_XLEN(0x20000000)
    li  x12, MASK_XLEN(0xfffffff7ffffffff)
    c.and x12, x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20000000) 
 
    # Testcase 101:  rd:x13(0xffffffefffffffff), rs2:x9(0x10000000), result rd:x13(0x10000000)
    li  x9, MASK_XLEN(0x10000000)
    li  x13, MASK_XLEN(0xffffffefffffffff)
    c.and x13, x9
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x10000000) 
 
    # Testcase 102:  rd:x14(0xffffffdfffffffff), rs2:x10(0x08000000), result rd:x14(0x08000000)
    li  x10, MASK_XLEN(0x8000000)
    li  x14, MASK_XLEN(0xffffffdfffffffff)
    c.and x14, x10
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000000) 
 
    # Testcase 103:  rd:x15(0xffffffbfffffffff), rs2:x11(0x04000000), result rd:x15(0x04000000)
    li  x11, MASK_XLEN(0x4000000)
    li  x15, MASK_XLEN(0xffffffbfffffffff)
    c.and x15, x11
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x4000000) 
 
    # Testcase 104:  rd:x8(0xffffff7fffffffff), rs2:x12(0x02000000), result rd:x8(0x02000000)
    li  x12, MASK_XLEN(0x2000000)
    li  x8, MASK_XLEN(0xffffff7fffffffff)
    c.and x8, x12
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x1, test_22_res

 
    # Testcase 105:  rd:x9(0xfffffeffffffffff), rs2:x13(0x01000000), result rd:x9(0x01000000)
    li  x13, MASK_XLEN(0x1000000)
    li  x9, MASK_XLEN(0xfffffeffffffffff)
    c.and x9, x13
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1000000) 
 
    # Testcase 106:  rd:x10(0xfffffdffffffffff), rs2:x14(0x00800000), result rd:x10(0x00800000)
    li  x14, MASK_XLEN(0x800000)
    li  x10, MASK_XLEN(0xfffffdffffffffff)
    c.and x10, x14
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x800000) 
 
    # Testcase 107:  rd:x11(0xfffffbffffffffff), rs2:x15(0x00400000), result rd:x11(0x00400000)
    li  x15, MASK_XLEN(0x400000)
    li  x11, MASK_XLEN(0xfffffbffffffffff)
    c.and x11, x15
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400000) 
 
    # Testcase 108:  rd:x12(0xfffff7ffffffffff), rs2:x8(0x00200000), result rd:x12(0x00200000)
    li  x8, MASK_XLEN(0x200000)
    li  x12, MASK_XLEN(0xfffff7ffffffffff)
    c.and x12, x8
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200000) 
 
    # Testcase 109:  rd:x13(0xffffefffffffffff), rs2:x9(0x00100000), result rd:x13(0x00100000)
    li  x9, MASK_XLEN(0x100000)
    li  x13, MASK_XLEN(0xffffefffffffffff)
    c.and x13, x9
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x100000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res

 
    # Testcase 110:  rd:x14(0xffffdfffffffffff), rs2:x10(0x00080000), result rd:x14(0x00080000)
    li  x10, MASK_XLEN(0x80000)
    li  x14, MASK_XLEN(0xffffdfffffffffff)
    c.and x14, x10
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x80000) 
 
    # Testcase 111:  rd:x15(0xffffbfffffffffff), rs2:x11(0x00040000), result rd:x15(0x00040000)
    li  x11, MASK_XLEN(0x40000)
    li  x15, MASK_XLEN(0xffffbfffffffffff)
    c.and x15, x11
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x40000) 
 
    # Testcase 112:  rd:x8(0xffff7fffffffffff), rs2:x12(0x00020000), result rd:x8(0x00020000)
    li  x12, MASK_XLEN(0x20000)
    li  x8, MASK_XLEN(0xffff7fffffffffff)
    c.and x8, x12
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000) 
 
    # Testcase 113:  rd:x9(0xfffeffffffffffff), rs2:x13(0x00010000), result rd:x9(0x00010000)
    li  x13, MASK_XLEN(0x10000)
    li  x9, MASK_XLEN(0xfffeffffffffffff)
    c.and x9, x13
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x10000) 
 
    # Testcase 114:  rd:x10(0xfffdffffffffffff), rs2:x14(0x00008000), result rd:x10(0x00008000)
    li  x14, MASK_XLEN(0x8000)
    li  x10, MASK_XLEN(0xfffdffffffffffff)
    c.and x10, x14
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res

 
    # Testcase 115:  rd:x11(0xfffbffffffffffff), rs2:x15(0x00004000), result rd:x11(0x00004000)
    li  x15, MASK_XLEN(0x4000)
    li  x11, MASK_XLEN(0xfffbffffffffffff)
    c.and x11, x15
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x4000) 
 
    # Testcase 116:  rd:x12(0xfff7ffffffffffff), rs2:x8(0x00002000), result rd:x12(0x00002000)
    li  x8, MASK_XLEN(0x2000)
    li  x12, MASK_XLEN(0xfff7ffffffffffff)
    c.and x12, x8
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2000) 
 
    # Testcase 117:  rd:x13(0xffefffffffffffff), rs2:x9(0x00001000), result rd:x13(0x00001000)
    li  x9, MASK_XLEN(0x1000)
    li  x13, MASK_XLEN(0xffefffffffffffff)
    c.and x13, x9
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x1000) 
 
    # Testcase 118:  rd:x14(0xffdfffffffffffff), rs2:x10(0x00000800), result rd:x14(0x00000800)
    li  x10, MASK_XLEN(0x800)
    li  x14, MASK_XLEN(0xffdfffffffffffff)
    c.and x14, x10
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800) 
 
    # Testcase 119:  rd:x15(0xffbfffffffffffff), rs2:x11(0x00000400), result rd:x15(0x00000400)
    li  x11, MASK_XLEN(0x400)
    li  x15, MASK_XLEN(0xffbfffffffffffff)
    c.and x15, x11
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x400) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x1, test_25_res

 
    # Testcase 120:  rd:x8(0xff7fffffffffffff), rs2:x12(0x00000200), result rd:x8(0x00000200)
    li  x12, MASK_XLEN(0x200)
    li  x8, MASK_XLEN(0xff7fffffffffffff)
    c.and x8, x12
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x200) 
 
    # Testcase 121:  rd:x9(0xfeffffffffffffff), rs2:x13(0x00000100), result rd:x9(0x00000100)
    li  x13, MASK_XLEN(0x100)
    li  x9, MASK_XLEN(0xfeffffffffffffff)
    c.and x9, x13
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x100) 
 
    # Testcase 122:  rd:x10(0xfdffffffffffffff), rs2:x14(0x00000080), result rd:x10(0x00000080)
    li  x14, MASK_XLEN(0x80)
    li  x10, MASK_XLEN(0xfdffffffffffffff)
    c.and x10, x14
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80) 
 
    # Testcase 123:  rd:x11(0xfbffffffffffffff), rs2:x15(0x00000040), result rd:x11(0x00000040)
    li  x15, MASK_XLEN(0x40)
    li  x11, MASK_XLEN(0xfbffffffffffffff)
    c.and x11, x15
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x40) 
 
    # Testcase 124:  rd:x12(0xf7ffffffffffffff), rs2:x8(0x00000020), result rd:x12(0x00000020)
    li  x8, MASK_XLEN(0x20)
    li  x12, MASK_XLEN(0xf7ffffffffffffff)
    c.and x12, x8
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res

 
    # Testcase 125:  rd:x13(0xefffffffffffffff), rs2:x9(0x00000010), result rd:x13(0x00000010)
    li  x9, MASK_XLEN(0x10)
    li  x13, MASK_XLEN(0xefffffffffffffff)
    c.and x13, x9
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x10) 
 
    # Testcase 126:  rd:x14(0xdfffffffffffffff), rs2:x10(0x00000008), result rd:x14(0x00000008)
    li  x10, MASK_XLEN(0x8)
    li  x14, MASK_XLEN(0xdfffffffffffffff)
    c.and x14, x10
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8) 
 
    # Testcase 127:  rd:x15(0xbfffffffffffffff), rs2:x11(0x00000004), result rd:x15(0x00000004)
    li  x11, MASK_XLEN(0x4)
    li  x15, MASK_XLEN(0xbfffffffffffffff)
    c.and x15, x11
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x4) 
 
    # Testcase 128:  rd:x8(0x7fffffffffffffff), rs2:x12(0x00000002), result rd:x8(0x00000002)
    li  x12, MASK_XLEN(0x2)
    li  x8, MASK_XLEN(0x7fffffffffffffff)
    c.and x8, x12
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2) 
 
    # Testcase 129:  rd:x9(0xffffffffffffffff), rs2:x13(0x00000001), result rd:x9(0x00000001)
    li  x13, MASK_XLEN(0x1)
    li  x9, MASK_XLEN(0xffffffffffffffff)
    c.and x9, x13
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res

 
    # Testcase 130:  rd:x10(0x00000001), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x1)
    c.and x10, x14
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 131:  rd:x11(0x00000002), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x2)
    c.and x11, x15
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 132:  rd:x12(0x00000004), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x4)
    c.and x12, x8
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 133:  rd:x13(0x00000008), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x8)
    c.and x13, x9
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 134:  rd:x14(0x00000010), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x10)
    c.and x14, x10
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res

 
    # Testcase 135:  rd:x15(0x00000020), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x20)
    c.and x15, x11
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 136:  rd:x8(0x00000040), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x40)
    c.and x8, x12
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 137:  rd:x9(0x00000080), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x80)
    c.and x9, x13
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 138:  rd:x10(0x00000100), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x100)
    c.and x10, x14
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 139:  rd:x11(0x00000200), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x200)
    c.and x11, x15
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res

 
    # Testcase 140:  rd:x12(0x00000400), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x400)
    c.and x12, x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 141:  rd:x13(0x00000800), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x800)
    c.and x13, x9
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 142:  rd:x14(0x00001000), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x1000)
    c.and x14, x10
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 143:  rd:x15(0x00002000), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x2000)
    c.and x15, x11
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 144:  rd:x8(0x00004000), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x4000)
    c.and x8, x12
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res

 
    # Testcase 145:  rd:x9(0x00008000), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x8000)
    c.and x9, x13
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 146:  rd:x10(0x00010000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x10000)
    c.and x10, x14
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 147:  rd:x11(0x00020000), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x20000)
    c.and x11, x15
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 148:  rd:x12(0x00040000), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x40000)
    c.and x12, x8
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 149:  rd:x13(0x00080000), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x80000)
    c.and x13, x9
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x1, test_31_res

 
    # Testcase 150:  rd:x14(0x00100000), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x100000)
    c.and x14, x10
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 151:  rd:x15(0x00200000), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x200000)
    c.and x15, x11
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 152:  rd:x8(0x00400000), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x400000)
    c.and x8, x12
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 153:  rd:x9(0x00800000), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x800000)
    c.and x9, x13
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 154:  rd:x10(0x01000000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x1000000)
    c.and x10, x14
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x1, test_32_res

 
    # Testcase 155:  rd:x11(0x02000000), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x2000000)
    c.and x11, x15
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 156:  rd:x12(0x04000000), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x4000000)
    c.and x12, x8
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 157:  rd:x13(0x08000000), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x8000000)
    c.and x13, x9
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 158:  rd:x14(0x10000000), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x10000000)
    c.and x14, x10
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 159:  rd:x15(0x20000000), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x20000000)
    c.and x15, x11
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res

 
    # Testcase 160:  rd:x8(0x40000000), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x40000000)
    c.and x8, x12
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 161:  rd:x9(0x80000000), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x80000000)
    c.and x9, x13
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 162:  rd:x10(0x100000000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x100000000)
    c.and x10, x14
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 163:  rd:x11(0x200000000), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x200000000)
    c.and x11, x15
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 164:  rd:x12(0x400000000), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x400000000)
    c.and x12, x8
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res

 
    # Testcase 165:  rd:x13(0x800000000), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x800000000)
    c.and x13, x9
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 166:  rd:x14(0x1000000000), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x1000000000)
    c.and x14, x10
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 167:  rd:x15(0x2000000000), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x2000000000)
    c.and x15, x11
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 168:  rd:x8(0x4000000000), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x4000000000)
    c.and x8, x12
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 169:  rd:x9(0x8000000000), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x8000000000)
    c.and x9, x13
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x1, test_35_res

 
    # Testcase 170:  rd:x10(0x10000000000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x10000000000)
    c.and x10, x14
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 171:  rd:x11(0x20000000000), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x20000000000)
    c.and x11, x15
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 172:  rd:x12(0x40000000000), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x40000000000)
    c.and x12, x8
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 173:  rd:x13(0x80000000000), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x80000000000)
    c.and x13, x9
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 174:  rd:x14(0x100000000000), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x100000000000)
    c.and x14, x10
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res

 
    # Testcase 175:  rd:x15(0x200000000000), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x200000000000)
    c.and x15, x11
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 176:  rd:x8(0x400000000000), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x400000000000)
    c.and x8, x12
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 177:  rd:x9(0x800000000000), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x800000000000)
    c.and x9, x13
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 178:  rd:x10(0x1000000000000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x1000000000000)
    c.and x10, x14
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 179:  rd:x11(0x2000000000000), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x2000000000000)
    c.and x11, x15
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res

 
    # Testcase 180:  rd:x12(0x4000000000000), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x4000000000000)
    c.and x12, x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 181:  rd:x13(0x8000000000000), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x8000000000000)
    c.and x13, x9
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 182:  rd:x14(0x10000000000000), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x10000000000000)
    c.and x14, x10
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 183:  rd:x15(0x20000000000000), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x20000000000000)
    c.and x15, x11
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 184:  rd:x8(0x40000000000000), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x40000000000000)
    c.and x8, x12
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x1, test_38_res

 
    # Testcase 185:  rd:x9(0x80000000000000), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x80000000000000)
    c.and x9, x13
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 186:  rd:x10(0x100000000000000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x100000000000000)
    c.and x10, x14
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 187:  rd:x11(0x200000000000000), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x200000000000000)
    c.and x11, x15
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 188:  rd:x12(0x400000000000000), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x400000000000000)
    c.and x12, x8
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 189:  rd:x13(0x800000000000000), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x800000000000000)
    c.and x13, x9
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res

 
    # Testcase 190:  rd:x14(0x1000000000000000), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x1000000000000000)
    c.and x14, x10
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 191:  rd:x15(0x2000000000000000), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x2000000000000000)
    c.and x15, x11
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 192:  rd:x8(0x4000000000000000), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x4000000000000000)
    c.and x8, x12
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 193:  rd:x9(0x8000000000000000), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x8000000000000000)
    c.and x9, x13
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 194:  rd:x10(0x00000000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x0)
    c.and x10, x14
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res

 
    # Testcase 195:  rd:x11(0xfffffffffffffffe), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffffffffffffe)
    c.and x11, x15
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 196:  rd:x12(0xfffffffffffffffd), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffffffffffffd)
    c.and x12, x8
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 197:  rd:x13(0xfffffffffffffffb), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffffffffffffb)
    c.and x13, x9
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 198:  rd:x14(0xfffffffffffffff7), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffffffffffffff7)
    c.and x14, x10
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 199:  rd:x15(0xffffffffffffffef), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffffffffffffef)
    c.and x15, x11
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x1, test_41_res

 
    # Testcase 200:  rd:x8(0xffffffffffffffdf), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffffffffffffdf)
    c.and x8, x12
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 201:  rd:x9(0xffffffffffffffbf), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffffffffffffbf)
    c.and x9, x13
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 202:  rd:x10(0xffffffffffffff7f), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffffffffffffff7f)
    c.and x10, x14
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 203:  rd:x11(0xfffffffffffffeff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffffffffffeff)
    c.and x11, x15
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 204:  rd:x12(0xfffffffffffffdff), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffffffffffdff)
    c.and x12, x8
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res

 
    # Testcase 205:  rd:x13(0xfffffffffffffbff), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffffffffffbff)
    c.and x13, x9
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 206:  rd:x14(0xfffffffffffff7ff), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffffffffffff7ff)
    c.and x14, x10
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 207:  rd:x15(0xffffffffffffefff), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffffffffffefff)
    c.and x15, x11
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 208:  rd:x8(0xffffffffffffdfff), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffffffffffdfff)
    c.and x8, x12
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 209:  rd:x9(0xffffffffffffbfff), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffffffffffbfff)
    c.and x9, x13
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res

 
    # Testcase 210:  rd:x10(0xffffffffffff7fff), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffffffffffff7fff)
    c.and x10, x14
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 211:  rd:x11(0xfffffffffffeffff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffffffffeffff)
    c.and x11, x15
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 212:  rd:x12(0xfffffffffffdffff), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffffffffdffff)
    c.and x12, x8
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 213:  rd:x13(0xfffffffffffbffff), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffffffffbffff)
    c.and x13, x9
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 214:  rd:x14(0xfffffffffff7ffff), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffffffffff7ffff)
    c.and x14, x10
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x1, test_44_res

 
    # Testcase 215:  rd:x15(0xffffffffffefffff), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffffffffefffff)
    c.and x15, x11
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 216:  rd:x8(0xffffffffffdfffff), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffffffffdfffff)
    c.and x8, x12
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 217:  rd:x9(0xffffffffffbfffff), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffffffffbfffff)
    c.and x9, x13
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 218:  rd:x10(0xffffffffff7fffff), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffffffffff7fffff)
    c.and x10, x14
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 219:  rd:x11(0xfffffffffeffffff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffffffeffffff)
    c.and x11, x15
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res

 
    # Testcase 220:  rd:x12(0xfffffffffdffffff), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffffffdffffff)
    c.and x12, x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 221:  rd:x13(0xfffffffffbffffff), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffffffbffffff)
    c.and x13, x9
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 222:  rd:x14(0xfffffffff7ffffff), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffffffff7ffffff)
    c.and x14, x10
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 223:  rd:x15(0xffffffffefffffff), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffffffefffffff)
    c.and x15, x11
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 224:  rd:x8(0xffffffffdfffffff), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffffffdfffffff)
    c.and x8, x12
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res

 
    # Testcase 225:  rd:x9(0xffffffffbfffffff), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffffffbfffffff)
    c.and x9, x13
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 226:  rd:x10(0xffffffff7fffffff), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffffffff7fffffff)
    c.and x10, x14
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 227:  rd:x11(0xfffffffeffffffff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffffeffffffff)
    c.and x11, x15
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 228:  rd:x12(0xfffffffdffffffff), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffffdffffffff)
    c.and x12, x8
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 229:  rd:x13(0xfffffffbffffffff), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffffbffffffff)
    c.and x13, x9
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x1, test_47_res

 
    # Testcase 230:  rd:x14(0xfffffff7ffffffff), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffffff7ffffffff)
    c.and x14, x10
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 231:  rd:x15(0xffffffefffffffff), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffffefffffffff)
    c.and x15, x11
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 232:  rd:x8(0xffffffdfffffffff), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffffdfffffffff)
    c.and x8, x12
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 233:  rd:x9(0xffffffbfffffffff), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffffbfffffffff)
    c.and x9, x13
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 234:  rd:x10(0xffffff7fffffffff), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffffff7fffffffff)
    c.and x10, x14
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res

 
    # Testcase 235:  rd:x11(0xfffffeffffffffff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffeffffffffff)
    c.and x11, x15
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 236:  rd:x12(0xfffffdffffffffff), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffdffffffffff)
    c.and x12, x8
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 237:  rd:x13(0xfffffbffffffffff), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffbffffffffff)
    c.and x13, x9
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 238:  rd:x14(0xfffff7ffffffffff), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffff7ffffffffff)
    c.and x14, x10
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 239:  rd:x15(0xffffefffffffffff), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffefffffffffff)
    c.and x15, x11
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res

 
    # Testcase 240:  rd:x8(0xffffdfffffffffff), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffdfffffffffff)
    c.and x8, x12
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 241:  rd:x9(0xffffbfffffffffff), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffbfffffffffff)
    c.and x9, x13
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 242:  rd:x10(0xffff7fffffffffff), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffff7fffffffffff)
    c.and x10, x14
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 243:  rd:x11(0xfffeffffffffffff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffeffffffffffff)
    c.and x11, x15
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 244:  rd:x12(0xfffdffffffffffff), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffdffffffffffff)
    c.and x12, x8
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x1, test_50_res

 
    # Testcase 245:  rd:x13(0xfffbffffffffffff), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffbffffffffffff)
    c.and x13, x9
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 246:  rd:x14(0xfff7ffffffffffff), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfff7ffffffffffff)
    c.and x14, x10
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 247:  rd:x15(0xffefffffffffffff), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffefffffffffffff)
    c.and x15, x11
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 248:  rd:x8(0xffdfffffffffffff), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffdfffffffffffff)
    c.and x8, x12
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 249:  rd:x9(0xffbfffffffffffff), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffbfffffffffffff)
    c.and x9, x13
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res

 
    # Testcase 250:  rd:x10(0xff7fffffffffffff), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xff7fffffffffffff)
    c.and x10, x14
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 251:  rd:x11(0xfeffffffffffffff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfeffffffffffffff)
    c.and x11, x15
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 252:  rd:x12(0xfdffffffffffffff), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfdffffffffffffff)
    c.and x12, x8
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 253:  rd:x13(0xfbffffffffffffff), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfbffffffffffffff)
    c.and x13, x9
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 254:  rd:x14(0xf7ffffffffffffff), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xf7ffffffffffffff)
    c.and x14, x10
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res

 
    # Testcase 255:  rd:x15(0xefffffffffffffff), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xefffffffffffffff)
    c.and x15, x11
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 256:  rd:x8(0xdfffffffffffffff), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xdfffffffffffffff)
    c.and x8, x12
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 257:  rd:x9(0xbfffffffffffffff), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xbfffffffffffffff)
    c.and x9, x13
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 258:  rd:x10(0x7fffffffffffffff), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x7fffffffffffffff)
    c.and x10, x14
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 259:  rd:x11(0xffffffffffffffff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xffffffffffffffff)
    c.and x11, x15
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x1, test_53_res

 
    # Testcase 260:  rd:x12(0x00000001), rs2:x8(0xffffffffffffffff), result rd:x12(0x00000001)
    li  x8, MASK_XLEN(0xffffffffffffffff)
    li  x12, MASK_XLEN(0x1)
    c.and x12, x8
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1) 
 
    # Testcase 261:  rd:x13(0x00000002), rs2:x9(0x7fffffffffffffff), result rd:x13(0x00000002)
    li  x9, MASK_XLEN(0x7fffffffffffffff)
    li  x13, MASK_XLEN(0x2)
    c.and x13, x9
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x2) 
 
    # Testcase 262:  rd:x14(0x00000004), rs2:x10(0xbfffffffffffffff), result rd:x14(0x00000004)
    li  x10, MASK_XLEN(0xbfffffffffffffff)
    li  x14, MASK_XLEN(0x4)
    c.and x14, x10
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x4) 
 
    # Testcase 263:  rd:x15(0x00000008), rs2:x11(0xdfffffffffffffff), result rd:x15(0x00000008)
    li  x11, MASK_XLEN(0xdfffffffffffffff)
    li  x15, MASK_XLEN(0x8)
    c.and x15, x11
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x8) 


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

