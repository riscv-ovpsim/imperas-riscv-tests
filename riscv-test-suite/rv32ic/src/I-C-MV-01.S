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

RV_COMPLIANCE_RV32M

RV_COMPLIANCE_CODE_BEGIN


	RVTEST_IO_INIT
	RVTEST_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
	RVTEST_IO_WRITE_STR(x31, "Test Begin\n")

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test group 1\n")


    # address for test results
    la x6, test_1_res

 
    # Testcase 0:  rd:x1(0x00000001), rs2:x16(0xffffffff), result rd:x1(0xffffffff)
    li  x1,  MASK_XLEN(0x1)
    li  x16, MASK_XLEN(0xffffffff)
    c.mv x1, x16
    sw x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xffffffff) 
 
    # Testcase 1:  rd:x2(0x00000002), rs2:x15(0x7fffffff), result rd:x2(0x7fffffff)
    li  x2,  MASK_XLEN(0x2)
    li  x15, MASK_XLEN(0x7fffffff)
    c.mv x2, x15
    sw x2, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x7fffffff) 
 
    # Testcase 2:  rd:x3(0x00000004), rs2:x14(0xbfffffff), result rd:x3(0xbfffffff)
    li  x3,  MASK_XLEN(0x4)
    li  x14, MASK_XLEN(0xbfffffff)
    c.mv x3, x14
    sw x3, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xbfffffff) 
 
    # Testcase 3:  rd:x4(0x00000008), rs2:x13(0xdfffffff), result rd:x4(0xdfffffff)
    li  x4,  MASK_XLEN(0x8)
    li  x13, MASK_XLEN(0xdfffffff)
    c.mv x4, x13
    sw x4, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xdfffffff) 
 
    # Testcase 4:  rd:x5(0x00000010), rs2:x12(0xefffffff), result rd:x5(0xefffffff)
    li  x5,  MASK_XLEN(0x10)
    li  x12, MASK_XLEN(0xefffffff)
    c.mv x5, x12
    sw x5, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0xefffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res

 
    # Testcase 5:  rd:x6(0x00000020), rs2:x11(0xf7ffffff), result rd:x6(0xf7ffffff)
    li  x6,  MASK_XLEN(0x20)
    li  x11, MASK_XLEN(0xf7ffffff)
    c.mv x6, x11
    sw x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xf7ffffff) 
 
    # Testcase 6:  rd:x7(0x00000040), rs2:x10(0xfbffffff), result rd:x7(0xfbffffff)
    li  x7,  MASK_XLEN(0x40)
    li  x10, MASK_XLEN(0xfbffffff)
    c.mv x7, x10
    sw x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfbffffff) 
 
    # Testcase 7:  rd:x8(0x00000080), rs2:x9(0xfdffffff), result rd:x8(0xfdffffff)
    li  x8,  MASK_XLEN(0x80)
    li  x9, MASK_XLEN(0xfdffffff)
    c.mv x8, x9
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfdffffff) 
 
    # Testcase 8:  rd:x9(0x00000100), rs2:x8(0xfeffffff), result rd:x9(0xfeffffff)
    li  x9,  MASK_XLEN(0x100)
    li  x8, MASK_XLEN(0xfeffffff)
    c.mv x9, x8
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfeffffff) 
 
    # Testcase 9:  rd:x10(0x00000200), rs2:x7(0xff7fffff), result rd:x10(0xff7fffff)
    li  x10,  MASK_XLEN(0x200)
    li  x7, MASK_XLEN(0xff7fffff)
    c.mv x10, x7
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xff7fffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res

 
    # Testcase 10:  rd:x11(0x00000400), rs2:x6(0xffbfffff), result rd:x11(0xffbfffff)
    li  x11,  MASK_XLEN(0x400)
    li  x6, MASK_XLEN(0xffbfffff)
    c.mv x11, x6
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0xffbfffff) 
 
    # Testcase 11:  rd:x12(0x00000800), rs2:x5(0xffdfffff), result rd:x12(0xffdfffff)
    li  x12,  MASK_XLEN(0x800)
    li  x5, MASK_XLEN(0xffdfffff)
    c.mv x12, x5
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0xffdfffff) 
 
    # Testcase 12:  rd:x13(0x00001000), rs2:x4(0xffefffff), result rd:x13(0xffefffff)
    li  x13,  MASK_XLEN(0x1000)
    li  x4, MASK_XLEN(0xffefffff)
    c.mv x13, x4
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0xffefffff) 
 
    # Testcase 13:  rd:x14(0x00002000), rs2:x3(0xfff7ffff), result rd:x14(0xfff7ffff)
    li  x14,  MASK_XLEN(0x2000)
    li  x3, MASK_XLEN(0xfff7ffff)
    c.mv x14, x3
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xfff7ffff) 
 
    # Testcase 14:  rd:x15(0x00004000), rs2:x2(0xfffbffff), result rd:x15(0xfffbffff)
    li  x15,  MASK_XLEN(0x4000)
    li  x2, MASK_XLEN(0xfffbffff)
    c.mv x15, x2
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0xfffbffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res

 
    # Testcase 15:  rd:x16(0x00008000), rs2:x1(0xfffdffff), result rd:x16(0xfffdffff)
    li  x16,  MASK_XLEN(0x8000)
    li  x1, MASK_XLEN(0xfffdffff)
    c.mv x16, x1
    sw x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0xfffdffff) 
 
    # Testcase 16:  rd:x17(0x00010000), rs2:x31(0xfffeffff), result rd:x17(0xfffeffff)
    li  x17,  MASK_XLEN(0x10000)
    li  x31, MASK_XLEN(0xfffeffff)
    c.mv x17, x31
    sw x17, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0xfffeffff) 
 
    # Testcase 17:  rd:x18(0x00020000), rs2:x30(0xffff7fff), result rd:x18(0xffff7fff)
    li  x18,  MASK_XLEN(0x20000)
    li  x30, MASK_XLEN(0xffff7fff)
    c.mv x18, x30
    sw x18, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0xffff7fff) 
 
    # Testcase 18:  rd:x19(0x00040000), rs2:x29(0xffffbfff), result rd:x19(0xffffbfff)
    li  x19,  MASK_XLEN(0x40000)
    li  x29, MASK_XLEN(0xffffbfff)
    c.mv x19, x29
    sw x19, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0xffffbfff) 
 
    # Testcase 19:  rd:x20(0x00080000), rs2:x28(0xffffdfff), result rd:x20(0xffffdfff)
    li  x20,  MASK_XLEN(0x80000)
    li  x28, MASK_XLEN(0xffffdfff)
    c.mv x20, x28
    sw x20, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0xffffdfff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res

 
    # Testcase 20:  rd:x21(0x00100000), rs2:x27(0xffffefff), result rd:x21(0xffffefff)
    li  x21,  MASK_XLEN(0x100000)
    li  x27, MASK_XLEN(0xffffefff)
    c.mv x21, x27
    sw x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffffefff) 
 
    # Testcase 21:  rd:x22(0x00200000), rs2:x26(0xfffff7ff), result rd:x22(0xfffff7ff)
    li  x22,  MASK_XLEN(0x200000)
    li  x26, MASK_XLEN(0xfffff7ff)
    c.mv x22, x26
    sw x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffff7ff) 
 
    # Testcase 22:  rd:x23(0x00400000), rs2:x25(0xfffffbff), result rd:x23(0xfffffbff)
    li  x23,  MASK_XLEN(0x400000)
    li  x25, MASK_XLEN(0xfffffbff)
    c.mv x23, x25
    sw x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffffbff) 
 
    # Testcase 23:  rd:x25(0x00800000), rs2:x24(0xfffffdff), result rd:x25(0xfffffdff)
    li  x25,  MASK_XLEN(0x800000)
    li  x24, MASK_XLEN(0xfffffdff)
    c.mv x25, x24
    sw x25, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffdff) 
 
    # Testcase 24:  rd:x25(0x01000000), rs2:x23(0xfffffeff), result rd:x25(0xfffffeff)
    li  x25,  MASK_XLEN(0x1000000)
    li  x23, MASK_XLEN(0xfffffeff)
    c.mv x25, x23
    sw x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffffeff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res

 
    # Testcase 25:  rd:x26(0x02000000), rs2:x22(0xffffff7f), result rd:x26(0xffffff7f)
    li  x26,  MASK_XLEN(0x2000000)
    li  x22, MASK_XLEN(0xffffff7f)
    c.mv x26, x22
    sw x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0xffffff7f) 
 
    # Testcase 26:  rd:x27(0x04000000), rs2:x21(0xffffffbf), result rd:x27(0xffffffbf)
    li  x27,  MASK_XLEN(0x4000000)
    li  x21, MASK_XLEN(0xffffffbf)
    c.mv x27, x21
    sw x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0xffffffbf) 
 
    # Testcase 27:  rd:x28(0x08000000), rs2:x20(0xffffffdf), result rd:x28(0xffffffdf)
    li  x28,  MASK_XLEN(0x8000000)
    li  x20, MASK_XLEN(0xffffffdf)
    c.mv x28, x20
    sw x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0xffffffdf) 
 
    # Testcase 28:  rd:x29(0x10000000), rs2:x19(0xffffffef), result rd:x29(0xffffffef)
    li  x29,  MASK_XLEN(0x10000000)
    li  x19, MASK_XLEN(0xffffffef)
    c.mv x29, x19
    sw x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0xffffffef) 
 
    # Testcase 29:  rd:x30(0x20000000), rs2:x18(0xfffffff7), result rd:x30(0xfffffff7)
    li  x30,  MASK_XLEN(0x20000000)
    li  x18, MASK_XLEN(0xfffffff7)
    c.mv x30, x18
    sw x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0xfffffff7) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res

 
    # Testcase 30:  rd:x31(0x40000000), rs2:x17(0xfffffffb), result rd:x31(0xfffffffb)
    li  x31,  MASK_XLEN(0x40000000)
    li  x17, MASK_XLEN(0xfffffffb)
    c.mv x31, x17
    sw x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xfffffffb) 
 
    # Testcase 31:  rd:x1(0x80000000), rs2:x16(0xfffffffd), result rd:x1(0xfffffffd)
    li  x1,  MASK_XLEN(0x80000000)
    li  x16, MASK_XLEN(0xfffffffd)
    c.mv x1, x16
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xfffffffd) 
 
    # Testcase 32:  rd:x2(0x00000000), rs2:x15(0xfffffffe), result rd:x2(0xfffffffe)
    li  x2,  MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xfffffffe)
    c.mv x2, x15
    sw x2, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xfffffffe) 
 
    # Testcase 33:  rd:x3(0xfffffffe), rs2:x14(0x00000000), result rd:x3(0x00000000)
    li  x3,  MASK_XLEN(0xfffffffe)
    li  x14, MASK_XLEN(0x0)
    c.mv x3, x14
    sw x3, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x0) 
 
    # Testcase 34:  rd:x4(0xfffffffd), rs2:x13(0x80000000), result rd:x4(0x80000000)
    li  x4,  MASK_XLEN(0xfffffffd)
    li  x13, MASK_XLEN(0x80000000)
    c.mv x4, x13
    sw x4, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x80000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res

 
    # Testcase 35:  rd:x5(0xfffffffb), rs2:x12(0x40000000), result rd:x5(0x40000000)
    li  x5,  MASK_XLEN(0xfffffffb)
    li  x12, MASK_XLEN(0x40000000)
    c.mv x5, x12
    sw x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x40000000) 
 
    # Testcase 36:  rd:x6(0xfffffff7), rs2:x11(0x20000000), result rd:x6(0x20000000)
    li  x6,  MASK_XLEN(0xfffffff7)
    li  x11, MASK_XLEN(0x20000000)
    c.mv x6, x11
    sw x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x20000000) 
 
    # Testcase 37:  rd:x7(0xffffffef), rs2:x10(0x10000000), result rd:x7(0x10000000)
    li  x7,  MASK_XLEN(0xffffffef)
    li  x10, MASK_XLEN(0x10000000)
    c.mv x7, x10
    sw x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x10000000) 
 
    # Testcase 38:  rd:x8(0xffffffdf), rs2:x9(0x08000000), result rd:x8(0x08000000)
    li  x8,  MASK_XLEN(0xffffffdf)
    li  x9, MASK_XLEN(0x8000000)
    c.mv x8, x9
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8000000) 
 
    # Testcase 39:  rd:x9(0xffffffbf), rs2:x8(0x04000000), result rd:x9(0x04000000)
    li  x9,  MASK_XLEN(0xffffffbf)
    li  x8, MASK_XLEN(0x4000000)
    c.mv x9, x8
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x4000000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res

 
    # Testcase 40:  rd:x10(0xffffff7f), rs2:x7(0x02000000), result rd:x10(0x02000000)
    li  x10,  MASK_XLEN(0xffffff7f)
    li  x7, MASK_XLEN(0x2000000)
    c.mv x10, x7
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x2000000) 
 
    # Testcase 41:  rd:x11(0xfffffeff), rs2:x6(0x01000000), result rd:x11(0x01000000)
    li  x11,  MASK_XLEN(0xfffffeff)
    li  x6, MASK_XLEN(0x1000000)
    c.mv x11, x6
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000000) 
 
    # Testcase 42:  rd:x12(0xfffffdff), rs2:x5(0x00800000), result rd:x12(0x00800000)
    li  x12,  MASK_XLEN(0xfffffdff)
    li  x5, MASK_XLEN(0x800000)
    c.mv x12, x5
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x800000) 
 
    # Testcase 43:  rd:x13(0xfffffbff), rs2:x4(0x00400000), result rd:x13(0x00400000)
    li  x13,  MASK_XLEN(0xfffffbff)
    li  x4, MASK_XLEN(0x400000)
    c.mv x13, x4
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x400000) 
 
    # Testcase 44:  rd:x14(0xfffff7ff), rs2:x3(0x00200000), result rd:x14(0x00200000)
    li  x14,  MASK_XLEN(0xfffff7ff)
    li  x3, MASK_XLEN(0x200000)
    c.mv x14, x3
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x200000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res

 
    # Testcase 45:  rd:x15(0xffffefff), rs2:x2(0x00100000), result rd:x15(0x00100000)
    li  x15,  MASK_XLEN(0xffffefff)
    li  x2, MASK_XLEN(0x100000)
    c.mv x15, x2
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x100000) 
 
    # Testcase 46:  rd:x16(0xffffdfff), rs2:x1(0x00080000), result rd:x16(0x00080000)
    li  x16,  MASK_XLEN(0xffffdfff)
    li  x1, MASK_XLEN(0x80000)
    c.mv x16, x1
    sw x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x80000) 
 
    # Testcase 47:  rd:x17(0xffffbfff), rs2:x31(0x00040000), result rd:x17(0x00040000)
    li  x17,  MASK_XLEN(0xffffbfff)
    li  x31, MASK_XLEN(0x40000)
    c.mv x17, x31
    sw x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x40000) 
 
    # Testcase 48:  rd:x18(0xffff7fff), rs2:x30(0x00020000), result rd:x18(0x00020000)
    li  x18,  MASK_XLEN(0xffff7fff)
    li  x30, MASK_XLEN(0x20000)
    c.mv x18, x30
    sw x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x20000) 
 
    # Testcase 49:  rd:x19(0xfffeffff), rs2:x29(0x00010000), result rd:x19(0x00010000)
    li  x19,  MASK_XLEN(0xfffeffff)
    li  x29, MASK_XLEN(0x10000)
    c.mv x19, x29
    sw x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x10000) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res

 
    # Testcase 50:  rd:x20(0xfffdffff), rs2:x28(0x00008000), result rd:x20(0x00008000)
    li  x20,  MASK_XLEN(0xfffdffff)
    li  x28, MASK_XLEN(0x8000)
    c.mv x20, x28
    sw x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x8000) 
 
    # Testcase 51:  rd:x21(0xfffbffff), rs2:x27(0x00004000), result rd:x21(0x00004000)
    li  x21,  MASK_XLEN(0xfffbffff)
    li  x27, MASK_XLEN(0x4000)
    c.mv x21, x27
    sw x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x4000) 
 
    # Testcase 52:  rd:x22(0xfff7ffff), rs2:x26(0x00002000), result rd:x22(0x00002000)
    li  x22,  MASK_XLEN(0xfff7ffff)
    li  x26, MASK_XLEN(0x2000)
    c.mv x22, x26
    sw x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x2000) 
 
    # Testcase 53:  rd:x23(0xffefffff), rs2:x25(0x00001000), result rd:x23(0x00001000)
    li  x23,  MASK_XLEN(0xffefffff)
    li  x25, MASK_XLEN(0x1000)
    c.mv x23, x25
    sw x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x1000) 
 
    # Testcase 54:  rd:x25(0xffdfffff), rs2:x24(0x00000800), result rd:x25(0x00000800)
    li  x25,  MASK_XLEN(0xffdfffff)
    li  x24, MASK_XLEN(0x800)
    c.mv x25, x24
    sw x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x800) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res

 
    # Testcase 55:  rd:x25(0xffbfffff), rs2:x23(0x00000400), result rd:x25(0x00000400)
    li  x25,  MASK_XLEN(0xffbfffff)
    li  x23, MASK_XLEN(0x400)
    c.mv x25, x23
    sw x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x400) 
 
    # Testcase 56:  rd:x26(0xff7fffff), rs2:x22(0x00000200), result rd:x26(0x00000200)
    li  x26,  MASK_XLEN(0xff7fffff)
    li  x22, MASK_XLEN(0x200)
    c.mv x26, x22
    sw x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x200) 
 
    # Testcase 57:  rd:x27(0xfeffffff), rs2:x21(0x00000100), result rd:x27(0x00000100)
    li  x27,  MASK_XLEN(0xfeffffff)
    li  x21, MASK_XLEN(0x100)
    c.mv x27, x21
    sw x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x100) 
 
    # Testcase 58:  rd:x28(0xfdffffff), rs2:x20(0x00000080), result rd:x28(0x00000080)
    li  x28,  MASK_XLEN(0xfdffffff)
    li  x20, MASK_XLEN(0x80)
    c.mv x28, x20
    sw x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x80) 
 
    # Testcase 59:  rd:x29(0xfbffffff), rs2:x19(0x00000040), result rd:x29(0x00000040)
    li  x29,  MASK_XLEN(0xfbffffff)
    li  x19, MASK_XLEN(0x40)
    c.mv x29, x19
    sw x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x40) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res

 
    # Testcase 60:  rd:x30(0xf7ffffff), rs2:x18(0x00000020), result rd:x30(0x00000020)
    li  x30,  MASK_XLEN(0xf7ffffff)
    li  x18, MASK_XLEN(0x20)
    c.mv x30, x18
    sw x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x20) 
 
    # Testcase 61:  rd:x31(0xefffffff), rs2:x17(0x00000010), result rd:x31(0x00000010)
    li  x31,  MASK_XLEN(0xefffffff)
    li  x17, MASK_XLEN(0x10)
    c.mv x31, x17
    sw x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x10) 
 
    # Testcase 62:  rd:x1(0xdfffffff), rs2:x16(0x00000008), result rd:x1(0x00000008)
    li  x1,  MASK_XLEN(0xdfffffff)
    li  x16, MASK_XLEN(0x8)
    c.mv x1, x16
    sw x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x8) 
 
    # Testcase 63:  rd:x2(0xbfffffff), rs2:x15(0x00000004), result rd:x2(0x00000004)
    li  x2,  MASK_XLEN(0xbfffffff)
    li  x15, MASK_XLEN(0x4)
    c.mv x2, x15
    sw x2, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x4) 
 
    # Testcase 64:  rd:x3(0x7fffffff), rs2:x14(0x00000002), result rd:x3(0x00000002)
    li  x3,  MASK_XLEN(0x7fffffff)
    li  x14, MASK_XLEN(0x2)
    c.mv x3, x14
    sw x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x2) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res

 
    # Testcase 65:  rd:x4(0xffffffff), rs2:x13(0x00000001), result rd:x4(0x00000001)
    li  x4,  MASK_XLEN(0xffffffff)
    li  x13, MASK_XLEN(0x1)
    c.mv x4, x13
    sw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x1) 
 
    # Testcase 66:  rd:x5(0x00000001), rs2:x12(0x00000000), result rd:x5(0x00000000)
    li  x5,  MASK_XLEN(0x1)
    li  x12, MASK_XLEN(0x0)
    c.mv x5, x12
    sw x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0) 
 
    # Testcase 67:  rd:x6(0x00000002), rs2:x11(0x00000000), result rd:x6(0x00000000)
    li  x6,  MASK_XLEN(0x2)
    li  x11, MASK_XLEN(0x0)
    c.mv x6, x11
    sw x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0) 
 
    # Testcase 68:  rd:x7(0x00000004), rs2:x10(0x00000000), result rd:x7(0x00000000)
    li  x7,  MASK_XLEN(0x4)
    li  x10, MASK_XLEN(0x0)
    c.mv x7, x10
    sw x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0) 
 
    # Testcase 69:  rd:x8(0x00000008), rs2:x9(0x00000000), result rd:x8(0x00000000)
    li  x8,  MASK_XLEN(0x8)
    li  x9, MASK_XLEN(0x0)
    c.mv x8, x9
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res

 
    # Testcase 70:  rd:x9(0x00000010), rs2:x8(0x00000000), result rd:x9(0x00000000)
    li  x9,  MASK_XLEN(0x10)
    li  x8, MASK_XLEN(0x0)
    c.mv x9, x8
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 71:  rd:x10(0x00000020), rs2:x7(0x00000000), result rd:x10(0x00000000)
    li  x10,  MASK_XLEN(0x20)
    li  x7, MASK_XLEN(0x0)
    c.mv x10, x7
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 72:  rd:x11(0x00000040), rs2:x6(0x00000000), result rd:x11(0x00000000)
    li  x11,  MASK_XLEN(0x40)
    li  x6, MASK_XLEN(0x0)
    c.mv x11, x6
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 73:  rd:x12(0x00000080), rs2:x5(0x00000000), result rd:x12(0x00000000)
    li  x12,  MASK_XLEN(0x80)
    li  x5, MASK_XLEN(0x0)
    c.mv x12, x5
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 74:  rd:x13(0x00000100), rs2:x4(0x00000000), result rd:x13(0x00000000)
    li  x13,  MASK_XLEN(0x100)
    li  x4, MASK_XLEN(0x0)
    c.mv x13, x4
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res

 
    # Testcase 75:  rd:x14(0x00000200), rs2:x3(0x00000000), result rd:x14(0x00000000)
    li  x14,  MASK_XLEN(0x200)
    li  x3, MASK_XLEN(0x0)
    c.mv x14, x3
    sw x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x0) 
 
    # Testcase 76:  rd:x15(0x00000400), rs2:x2(0x00000000), result rd:x15(0x00000000)
    li  x15,  MASK_XLEN(0x400)
    li  x2, MASK_XLEN(0x0)
    c.mv x15, x2
    sw x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0) 
 
    # Testcase 77:  rd:x16(0x00000800), rs2:x1(0x00000000), result rd:x16(0x00000000)
    li  x16,  MASK_XLEN(0x800)
    li  x1, MASK_XLEN(0x0)
    c.mv x16, x1
    sw x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0) 
 
    # Testcase 78:  rd:x17(0x00001000), rs2:x31(0x00000000), result rd:x17(0x00000000)
    li  x17,  MASK_XLEN(0x1000)
    li  x31, MASK_XLEN(0x0)
    c.mv x17, x31
    sw x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x0) 
 
    # Testcase 79:  rd:x18(0x00002000), rs2:x30(0x00000000), result rd:x18(0x00000000)
    li  x18,  MASK_XLEN(0x2000)
    li  x30, MASK_XLEN(0x0)
    c.mv x18, x30
    sw x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res

 
    # Testcase 80:  rd:x19(0x00004000), rs2:x29(0x00000000), result rd:x19(0x00000000)
    li  x19,  MASK_XLEN(0x4000)
    li  x29, MASK_XLEN(0x0)
    c.mv x19, x29
    sw x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0) 
 
    # Testcase 81:  rd:x20(0x00008000), rs2:x28(0x00000000), result rd:x20(0x00000000)
    li  x20,  MASK_XLEN(0x8000)
    li  x28, MASK_XLEN(0x0)
    c.mv x20, x28
    sw x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0) 
 
    # Testcase 82:  rd:x21(0x00010000), rs2:x27(0x00000000), result rd:x21(0x00000000)
    li  x21,  MASK_XLEN(0x10000)
    li  x27, MASK_XLEN(0x0)
    c.mv x21, x27
    sw x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0) 
 
    # Testcase 83:  rd:x22(0x00020000), rs2:x26(0x00000000), result rd:x22(0x00000000)
    li  x22,  MASK_XLEN(0x20000)
    li  x26, MASK_XLEN(0x0)
    c.mv x22, x26
    sw x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0) 
 
    # Testcase 84:  rd:x23(0x00040000), rs2:x25(0x00000000), result rd:x23(0x00000000)
    li  x23,  MASK_XLEN(0x40000)
    li  x25, MASK_XLEN(0x0)
    c.mv x23, x25
    sw x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res

 
    # Testcase 85:  rd:x25(0x00080000), rs2:x24(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0x80000)
    li  x24, MASK_XLEN(0x0)
    c.mv x25, x24
    sw x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 
 
    # Testcase 86:  rd:x25(0x00100000), rs2:x23(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0x100000)
    li  x23, MASK_XLEN(0x0)
    c.mv x25, x23
    sw x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 
 
    # Testcase 87:  rd:x26(0x00200000), rs2:x22(0x00000000), result rd:x26(0x00000000)
    li  x26,  MASK_XLEN(0x200000)
    li  x22, MASK_XLEN(0x0)
    c.mv x26, x22
    sw x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0) 
 
    # Testcase 88:  rd:x27(0x00400000), rs2:x21(0x00000000), result rd:x27(0x00000000)
    li  x27,  MASK_XLEN(0x400000)
    li  x21, MASK_XLEN(0x0)
    c.mv x27, x21
    sw x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0) 
 
    # Testcase 89:  rd:x28(0x00800000), rs2:x20(0x00000000), result rd:x28(0x00000000)
    li  x28,  MASK_XLEN(0x800000)
    li  x20, MASK_XLEN(0x0)
    c.mv x28, x20
    sw x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res

 
    # Testcase 90:  rd:x29(0x01000000), rs2:x19(0x00000000), result rd:x29(0x00000000)
    li  x29,  MASK_XLEN(0x1000000)
    li  x19, MASK_XLEN(0x0)
    c.mv x29, x19
    sw x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x0) 
 
    # Testcase 91:  rd:x30(0x02000000), rs2:x18(0x00000000), result rd:x30(0x00000000)
    li  x30,  MASK_XLEN(0x2000000)
    li  x18, MASK_XLEN(0x0)
    c.mv x30, x18
    sw x30, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0) 
 
    # Testcase 92:  rd:x31(0x04000000), rs2:x17(0x00000000), result rd:x31(0x00000000)
    li  x31,  MASK_XLEN(0x4000000)
    li  x17, MASK_XLEN(0x0)
    c.mv x31, x17
    sw x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0) 
 
    # Testcase 93:  rd:x1(0x08000000), rs2:x16(0x00000000), result rd:x1(0x00000000)
    li  x1,  MASK_XLEN(0x8000000)
    li  x16, MASK_XLEN(0x0)
    c.mv x1, x16
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0) 
 
    # Testcase 94:  rd:x2(0x10000000), rs2:x15(0x00000000), result rd:x2(0x00000000)
    li  x2,  MASK_XLEN(0x10000000)
    li  x15, MASK_XLEN(0x0)
    c.mv x2, x15
    sw x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res

 
    # Testcase 95:  rd:x3(0x20000000), rs2:x14(0x00000000), result rd:x3(0x00000000)
    li  x3,  MASK_XLEN(0x20000000)
    li  x14, MASK_XLEN(0x0)
    c.mv x3, x14
    sw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x0) 
 
    # Testcase 96:  rd:x4(0x40000000), rs2:x13(0x00000000), result rd:x4(0x00000000)
    li  x4,  MASK_XLEN(0x40000000)
    li  x13, MASK_XLEN(0x0)
    c.mv x4, x13
    sw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x0) 
 
    # Testcase 97:  rd:x5(0x80000000), rs2:x12(0x00000000), result rd:x5(0x00000000)
    li  x5,  MASK_XLEN(0x80000000)
    li  x12, MASK_XLEN(0x0)
    c.mv x5, x12
    sw x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0) 
 
    # Testcase 98:  rd:x6(0x00000000), rs2:x11(0x00000000), result rd:x6(0x00000000)
    li  x6,  MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x0)
    c.mv x6, x11
    sw x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0) 
 
    # Testcase 99:  rd:x7(0xfffffffe), rs2:x10(0x00000000), result rd:x7(0x00000000)
    li  x7,  MASK_XLEN(0xfffffffe)
    li  x10, MASK_XLEN(0x0)
    c.mv x7, x10
    sw x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res

 
    # Testcase 100:  rd:x8(0xfffffffd), rs2:x9(0x00000000), result rd:x8(0x00000000)
    li  x8,  MASK_XLEN(0xfffffffd)
    li  x9, MASK_XLEN(0x0)
    c.mv x8, x9
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 101:  rd:x9(0xfffffffb), rs2:x8(0x00000000), result rd:x9(0x00000000)
    li  x9,  MASK_XLEN(0xfffffffb)
    li  x8, MASK_XLEN(0x0)
    c.mv x9, x8
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 102:  rd:x10(0xfffffff7), rs2:x7(0x00000000), result rd:x10(0x00000000)
    li  x10,  MASK_XLEN(0xfffffff7)
    li  x7, MASK_XLEN(0x0)
    c.mv x10, x7
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 103:  rd:x11(0xffffffef), rs2:x6(0x00000000), result rd:x11(0x00000000)
    li  x11,  MASK_XLEN(0xffffffef)
    li  x6, MASK_XLEN(0x0)
    c.mv x11, x6
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 104:  rd:x12(0xffffffdf), rs2:x5(0x00000000), result rd:x12(0x00000000)
    li  x12,  MASK_XLEN(0xffffffdf)
    li  x5, MASK_XLEN(0x0)
    c.mv x12, x5
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res

 
    # Testcase 105:  rd:x13(0xffffffbf), rs2:x4(0x00000000), result rd:x13(0x00000000)
    li  x13,  MASK_XLEN(0xffffffbf)
    li  x4, MASK_XLEN(0x0)
    c.mv x13, x4
    sw x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x0) 
 
    # Testcase 106:  rd:x14(0xffffff7f), rs2:x3(0x00000000), result rd:x14(0x00000000)
    li  x14,  MASK_XLEN(0xffffff7f)
    li  x3, MASK_XLEN(0x0)
    c.mv x14, x3
    sw x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x0) 
 
    # Testcase 107:  rd:x15(0xfffffeff), rs2:x2(0x00000000), result rd:x15(0x00000000)
    li  x15,  MASK_XLEN(0xfffffeff)
    li  x2, MASK_XLEN(0x0)
    c.mv x15, x2
    sw x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x0) 
 
    # Testcase 108:  rd:x16(0xfffffdff), rs2:x1(0x00000000), result rd:x16(0x00000000)
    li  x16,  MASK_XLEN(0xfffffdff)
    li  x1, MASK_XLEN(0x0)
    c.mv x16, x1
    sw x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x0) 
 
    # Testcase 109:  rd:x17(0xfffffbff), rs2:x31(0x00000000), result rd:x17(0x00000000)
    li  x17,  MASK_XLEN(0xfffffbff)
    li  x31, MASK_XLEN(0x0)
    c.mv x17, x31
    sw x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res

 
    # Testcase 110:  rd:x18(0xfffff7ff), rs2:x30(0x00000000), result rd:x18(0x00000000)
    li  x18,  MASK_XLEN(0xfffff7ff)
    li  x30, MASK_XLEN(0x0)
    c.mv x18, x30
    sw x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x0) 
 
    # Testcase 111:  rd:x19(0xffffefff), rs2:x29(0x00000000), result rd:x19(0x00000000)
    li  x19,  MASK_XLEN(0xffffefff)
    li  x29, MASK_XLEN(0x0)
    c.mv x19, x29
    sw x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0) 
 
    # Testcase 112:  rd:x20(0xffffdfff), rs2:x28(0x00000000), result rd:x20(0x00000000)
    li  x20,  MASK_XLEN(0xffffdfff)
    li  x28, MASK_XLEN(0x0)
    c.mv x20, x28
    sw x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0) 
 
    # Testcase 113:  rd:x21(0xffffbfff), rs2:x27(0x00000000), result rd:x21(0x00000000)
    li  x21,  MASK_XLEN(0xffffbfff)
    li  x27, MASK_XLEN(0x0)
    c.mv x21, x27
    sw x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0) 
 
    # Testcase 114:  rd:x22(0xffff7fff), rs2:x26(0x00000000), result rd:x22(0x00000000)
    li  x22,  MASK_XLEN(0xffff7fff)
    li  x26, MASK_XLEN(0x0)
    c.mv x22, x26
    sw x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res

 
    # Testcase 115:  rd:x23(0xfffeffff), rs2:x25(0x00000000), result rd:x23(0x00000000)
    li  x23,  MASK_XLEN(0xfffeffff)
    li  x25, MASK_XLEN(0x0)
    c.mv x23, x25
    sw x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0) 
 
    # Testcase 116:  rd:x25(0xfffdffff), rs2:x24(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0xfffdffff)
    li  x24, MASK_XLEN(0x0)
    c.mv x25, x24
    sw x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 
 
    # Testcase 117:  rd:x25(0xfffbffff), rs2:x23(0x00000000), result rd:x25(0x00000000)
    li  x25,  MASK_XLEN(0xfffbffff)
    li  x23, MASK_XLEN(0x0)
    c.mv x25, x23
    sw x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0) 
 
    # Testcase 118:  rd:x26(0xfff7ffff), rs2:x22(0x00000000), result rd:x26(0x00000000)
    li  x26,  MASK_XLEN(0xfff7ffff)
    li  x22, MASK_XLEN(0x0)
    c.mv x26, x22
    sw x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0) 
 
    # Testcase 119:  rd:x27(0xffefffff), rs2:x21(0x00000000), result rd:x27(0x00000000)
    li  x27,  MASK_XLEN(0xffefffff)
    li  x21, MASK_XLEN(0x0)
    c.mv x27, x21
    sw x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res

 
    # Testcase 120:  rd:x28(0xffdfffff), rs2:x20(0x00000000), result rd:x28(0x00000000)
    li  x28,  MASK_XLEN(0xffdfffff)
    li  x20, MASK_XLEN(0x0)
    c.mv x28, x20
    sw x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0x0) 
 
    # Testcase 121:  rd:x29(0xffbfffff), rs2:x19(0x00000000), result rd:x29(0x00000000)
    li  x29,  MASK_XLEN(0xffbfffff)
    li  x19, MASK_XLEN(0x0)
    c.mv x29, x19
    sw x29, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x0) 
 
    # Testcase 122:  rd:x30(0xff7fffff), rs2:x18(0x00000000), result rd:x30(0x00000000)
    li  x30,  MASK_XLEN(0xff7fffff)
    li  x18, MASK_XLEN(0x0)
    c.mv x30, x18
    sw x30, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x0) 
 
    # Testcase 123:  rd:x31(0xfeffffff), rs2:x17(0x00000000), result rd:x31(0x00000000)
    li  x31,  MASK_XLEN(0xfeffffff)
    li  x17, MASK_XLEN(0x0)
    c.mv x31, x17
    sw x31, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0) 
 
    # Testcase 124:  rd:x1(0xfdffffff), rs2:x16(0x00000000), result rd:x1(0x00000000)
    li  x1,  MASK_XLEN(0xfdffffff)
    li  x16, MASK_XLEN(0x0)
    c.mv x1, x16
    sw x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res

 
    # Testcase 125:  rd:x2(0xfbffffff), rs2:x15(0x00000000), result rd:x2(0x00000000)
    li  x2,  MASK_XLEN(0xfbffffff)
    li  x15, MASK_XLEN(0x0)
    c.mv x2, x15
    sw x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x0) 
 
    # Testcase 126:  rd:x3(0xf7ffffff), rs2:x14(0x00000000), result rd:x3(0x00000000)
    li  x3,  MASK_XLEN(0xf7ffffff)
    li  x14, MASK_XLEN(0x0)
    c.mv x3, x14
    sw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0) 
 
    # Testcase 127:  rd:x4(0xefffffff), rs2:x13(0x00000000), result rd:x4(0x00000000)
    li  x4,  MASK_XLEN(0xefffffff)
    li  x13, MASK_XLEN(0x0)
    c.mv x4, x13
    sw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x0) 
 
    # Testcase 128:  rd:x5(0xdfffffff), rs2:x12(0x00000000), result rd:x5(0x00000000)
    li  x5,  MASK_XLEN(0xdfffffff)
    li  x12, MASK_XLEN(0x0)
    c.mv x5, x12
    sw x5, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x0) 
 
    # Testcase 129:  rd:x6(0xbfffffff), rs2:x11(0x00000000), result rd:x6(0x00000000)
    li  x6,  MASK_XLEN(0xbfffffff)
    li  x11, MASK_XLEN(0x0)
    c.mv x6, x11
    sw x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0x0) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res

 
    # Testcase 130:  rd:x7(0x7fffffff), rs2:x10(0x00000000), result rd:x7(0x00000000)
    li  x7,  MASK_XLEN(0x7fffffff)
    li  x10, MASK_XLEN(0x0)
    c.mv x7, x10
    sw x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0) 
 
    # Testcase 131:  rd:x8(0xffffffff), rs2:x9(0x00000000), result rd:x8(0x00000000)
    li  x8,  MASK_XLEN(0xffffffff)
    li  x9, MASK_XLEN(0x0)
    c.mv x8, x9
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 132:  rd:x9(0x00000001), rs2:x8(0xffffffff), result rd:x9(0xffffffff)
    li  x9,  MASK_XLEN(0x1)
    li  x8, MASK_XLEN(0xffffffff)
    c.mv x9, x8
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffff) 
 
    # Testcase 133:  rd:x10(0x00000002), rs2:x7(0x7fffffff), result rd:x10(0x7fffffff)
    li  x10,  MASK_XLEN(0x2)
    li  x7, MASK_XLEN(0x7fffffff)
    c.mv x10, x7
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7fffffff) 
 
    # Testcase 134:  rd:x11(0x00000004), rs2:x6(0xbfffffff), result rd:x11(0xbfffffff)
    li  x11,  MASK_XLEN(0x4)
    li  x6, MASK_XLEN(0xbfffffff)
    c.mv x11, x6
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xbfffffff) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res

 
    # Testcase 135:  rd:x12(0x00000008), rs2:x5(0xdfffffff), result rd:x12(0xdfffffff)
    li  x12,  MASK_XLEN(0x8)
    li  x5, MASK_XLEN(0xdfffffff)
    c.mv x12, x5
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xdfffffff) 



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

