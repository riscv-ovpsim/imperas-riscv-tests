# RISC-V Compliance Test I-C-OR-01
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
# Description: Testing instruction 'c.or'.

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

 
    # Testcase 0:  rd:x8(0x00000001), rs2:x12(0xffffffff), result rd:x8(0xffffffff)
    li  x12, MASK_XLEN(0xffffffff)
    li  x8, MASK_XLEN(0x1)
    c.or x8, x12
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffff) 
 
    # Testcase 1:  rd:x9(0x00000002), rs2:x13(0x7fffffff), result rd:x9(0x7fffffff)
    li  x13, MASK_XLEN(0x7fffffff)
    li  x9, MASK_XLEN(0x2)
    c.or x9, x13
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x7fffffff) 
 
    # Testcase 2:  rd:x10(0x00000004), rs2:x14(0xbfffffff), result rd:x10(0xbfffffff)
    li  x14, MASK_XLEN(0xbfffffff)
    li  x10, MASK_XLEN(0x4)
    c.or x10, x14
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xbfffffff) 
 
    # Testcase 3:  rd:x11(0x00000008), rs2:x15(0xdfffffff), result rd:x11(0xdfffffff)
    li  x15, MASK_XLEN(0xdfffffff)
    li  x11, MASK_XLEN(0x8)
    c.or x11, x15
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xdfffffff) 
 
    # Testcase 4:  rd:x12(0x00000010), rs2:x8(0xefffffff), result rd:x12(0xefffffff)
    li  x8, MASK_XLEN(0xefffffff)
    li  x12, MASK_XLEN(0x10)
    c.or x12, x8
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xefffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res

 
    # Testcase 5:  rd:x13(0x00000020), rs2:x9(0xf7ffffff), result rd:x13(0xf7ffffff)
    li  x9, MASK_XLEN(0xf7ffffff)
    li  x13, MASK_XLEN(0x20)
    c.or x13, x9
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xf7ffffff) 
 
    # Testcase 6:  rd:x14(0x00000040), rs2:x10(0xfbffffff), result rd:x14(0xfbffffff)
    li  x10, MASK_XLEN(0xfbffffff)
    li  x14, MASK_XLEN(0x40)
    c.or x14, x10
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfbffffff) 
 
    # Testcase 7:  rd:x15(0x00000080), rs2:x11(0xfdffffff), result rd:x15(0xfdffffff)
    li  x11, MASK_XLEN(0xfdffffff)
    li  x15, MASK_XLEN(0x80)
    c.or x15, x11
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfdffffff) 
 
    # Testcase 8:  rd:x8(0x00000100), rs2:x12(0xfeffffff), result rd:x8(0xfeffffff)
    li  x12, MASK_XLEN(0xfeffffff)
    li  x8, MASK_XLEN(0x100)
    c.or x8, x12
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfeffffff) 
 
    # Testcase 9:  rd:x9(0x00000200), rs2:x13(0xff7fffff), result rd:x9(0xff7fffff)
    li  x13, MASK_XLEN(0xff7fffff)
    li  x9, MASK_XLEN(0x200)
    c.or x9, x13
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xff7fffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res

 
    # Testcase 10:  rd:x10(0x00000400), rs2:x14(0xffbfffff), result rd:x10(0xffbfffff)
    li  x14, MASK_XLEN(0xffbfffff)
    li  x10, MASK_XLEN(0x400)
    c.or x10, x14
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffbfffff) 
 
    # Testcase 11:  rd:x11(0x00000800), rs2:x15(0xffdfffff), result rd:x11(0xffdfffff)
    li  x15, MASK_XLEN(0xffdfffff)
    li  x11, MASK_XLEN(0x800)
    c.or x11, x15
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffdfffff) 
 
    # Testcase 12:  rd:x12(0x00001000), rs2:x8(0xffefffff), result rd:x12(0xffefffff)
    li  x8, MASK_XLEN(0xffefffff)
    li  x12, MASK_XLEN(0x1000)
    c.or x12, x8
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffefffff) 
 
    # Testcase 13:  rd:x13(0x00002000), rs2:x9(0xfff7ffff), result rd:x13(0xfff7ffff)
    li  x9, MASK_XLEN(0xfff7ffff)
    li  x13, MASK_XLEN(0x2000)
    c.or x13, x9
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfff7ffff) 
 
    # Testcase 14:  rd:x14(0x00004000), rs2:x10(0xfffbffff), result rd:x14(0xfffbffff)
    li  x10, MASK_XLEN(0xfffbffff)
    li  x14, MASK_XLEN(0x4000)
    c.or x14, x10
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffbffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x1, test_4_res

 
    # Testcase 15:  rd:x15(0x00008000), rs2:x11(0xfffdffff), result rd:x15(0xfffdffff)
    li  x11, MASK_XLEN(0xfffdffff)
    li  x15, MASK_XLEN(0x8000)
    c.or x15, x11
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffdffff) 
 
    # Testcase 16:  rd:x8(0x00010000), rs2:x12(0xfffeffff), result rd:x8(0xffffffff)
    li  x12, MASK_XLEN(0xfffeffff)
    li  x8, MASK_XLEN(0x10000)
    c.or x8, x12
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffff) 
 
    # Testcase 17:  rd:x9(0x00020000), rs2:x13(0xffff7fff), result rd:x9(0xffff7fff)
    li  x13, MASK_XLEN(0xffff7fff)
    li  x9, MASK_XLEN(0x20000)
    c.or x9, x13
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffff7fff) 
 
    # Testcase 18:  rd:x10(0x00040000), rs2:x14(0xffffbfff), result rd:x10(0xffffbfff)
    li  x14, MASK_XLEN(0xffffbfff)
    li  x10, MASK_XLEN(0x40000)
    c.or x10, x14
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffbfff) 
 
    # Testcase 19:  rd:x11(0x00080000), rs2:x15(0xffffdfff), result rd:x11(0xffffdfff)
    li  x15, MASK_XLEN(0xffffdfff)
    li  x11, MASK_XLEN(0x80000)
    c.or x11, x15
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffdfff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res

 
    # Testcase 20:  rd:x12(0x00100000), rs2:x8(0xffffefff), result rd:x12(0xffffefff)
    li  x8, MASK_XLEN(0xffffefff)
    li  x12, MASK_XLEN(0x100000)
    c.or x12, x8
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffefff) 
 
    # Testcase 21:  rd:x13(0x00200000), rs2:x9(0xfffff7ff), result rd:x13(0xfffff7ff)
    li  x9, MASK_XLEN(0xfffff7ff)
    li  x13, MASK_XLEN(0x200000)
    c.or x13, x9
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffff7ff) 
 
    # Testcase 22:  rd:x14(0x00400000), rs2:x10(0xfffffbff), result rd:x14(0xfffffbff)
    li  x10, MASK_XLEN(0xfffffbff)
    li  x14, MASK_XLEN(0x400000)
    c.or x14, x10
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffbff) 
 
    # Testcase 23:  rd:x15(0x00800000), rs2:x11(0xfffffdff), result rd:x15(0xfffffdff)
    li  x11, MASK_XLEN(0xfffffdff)
    li  x15, MASK_XLEN(0x800000)
    c.or x15, x11
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffdff) 
 
    # Testcase 24:  rd:x8(0x01000000), rs2:x12(0xfffffeff), result rd:x8(0xfffffeff)
    li  x12, MASK_XLEN(0xfffffeff)
    li  x8, MASK_XLEN(0x1000000)
    c.or x8, x12
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffeff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res

 
    # Testcase 25:  rd:x9(0x02000000), rs2:x13(0xffffff7f), result rd:x9(0xffffff7f)
    li  x13, MASK_XLEN(0xffffff7f)
    li  x9, MASK_XLEN(0x2000000)
    c.or x9, x13
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffff7f) 
 
    # Testcase 26:  rd:x10(0x04000000), rs2:x14(0xffffffbf), result rd:x10(0xffffffbf)
    li  x14, MASK_XLEN(0xffffffbf)
    li  x10, MASK_XLEN(0x4000000)
    c.or x10, x14
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffbf) 
 
    # Testcase 27:  rd:x11(0x08000000), rs2:x15(0xffffffdf), result rd:x11(0xffffffdf)
    li  x15, MASK_XLEN(0xffffffdf)
    li  x11, MASK_XLEN(0x8000000)
    c.or x11, x15
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffdf) 
 
    # Testcase 28:  rd:x12(0x10000000), rs2:x8(0xffffffef), result rd:x12(0xffffffef)
    li  x8, MASK_XLEN(0xffffffef)
    li  x12, MASK_XLEN(0x10000000)
    c.or x12, x8
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffef) 
 
    # Testcase 29:  rd:x13(0x20000000), rs2:x9(0xfffffff7), result rd:x13(0xfffffff7)
    li  x9, MASK_XLEN(0xfffffff7)
    li  x13, MASK_XLEN(0x20000000)
    c.or x13, x9
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffff7) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x1, test_7_res

 
    # Testcase 30:  rd:x14(0x40000000), rs2:x10(0xfffffffb), result rd:x14(0xfffffffb)
    li  x10, MASK_XLEN(0xfffffffb)
    li  x14, MASK_XLEN(0x40000000)
    c.or x14, x10
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffffb) 
 
    # Testcase 31:  rd:x15(0x80000000), rs2:x11(0xfffffffd), result rd:x15(0xfffffffd)
    li  x11, MASK_XLEN(0xfffffffd)
    li  x15, MASK_XLEN(0x80000000)
    c.or x15, x11
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xfffffffd) 
 
    # Testcase 32:  rd:x8(0x00000000), rs2:x12(0xfffffffe), result rd:x8(0xfffffffe)
    li  x12, MASK_XLEN(0xfffffffe)
    li  x8, MASK_XLEN(0x0)
    c.or x8, x12
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffffe) 
 
    # Testcase 33:  rd:x9(0xfffffffe), rs2:x13(0x00000000), result rd:x9(0xfffffffe)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xfffffffe)
    c.or x9, x13
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffffe) 
 
    # Testcase 34:  rd:x10(0xfffffffd), rs2:x14(0x80000000), result rd:x10(0xfffffffd)
    li  x14, MASK_XLEN(0x80000000)
    li  x10, MASK_XLEN(0xfffffffd)
    c.or x10, x14
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffd) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res

 
    # Testcase 35:  rd:x11(0xfffffffb), rs2:x15(0x40000000), result rd:x11(0xfffffffb)
    li  x15, MASK_XLEN(0x40000000)
    li  x11, MASK_XLEN(0xfffffffb)
    c.or x11, x15
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffb) 
 
    # Testcase 36:  rd:x12(0xfffffff7), rs2:x8(0x20000000), result rd:x12(0xfffffff7)
    li  x8, MASK_XLEN(0x20000000)
    li  x12, MASK_XLEN(0xfffffff7)
    c.or x12, x8
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffff7) 
 
    # Testcase 37:  rd:x13(0xffffffef), rs2:x9(0x10000000), result rd:x13(0xffffffef)
    li  x9, MASK_XLEN(0x10000000)
    li  x13, MASK_XLEN(0xffffffef)
    c.or x13, x9
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffffef) 
 
    # Testcase 38:  rd:x14(0xffffffdf), rs2:x10(0x08000000), result rd:x14(0xffffffdf)
    li  x10, MASK_XLEN(0x8000000)
    li  x14, MASK_XLEN(0xffffffdf)
    c.or x14, x10
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffdf) 
 
    # Testcase 39:  rd:x15(0xffffffbf), rs2:x11(0x04000000), result rd:x15(0xffffffbf)
    li  x11, MASK_XLEN(0x4000000)
    li  x15, MASK_XLEN(0xffffffbf)
    c.or x15, x11
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffbf) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res

 
    # Testcase 40:  rd:x8(0xffffff7f), rs2:x12(0x02000000), result rd:x8(0xffffff7f)
    li  x12, MASK_XLEN(0x2000000)
    li  x8, MASK_XLEN(0xffffff7f)
    c.or x8, x12
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffff7f) 
 
    # Testcase 41:  rd:x9(0xfffffeff), rs2:x13(0x01000000), result rd:x9(0xfffffeff)
    li  x13, MASK_XLEN(0x1000000)
    li  x9, MASK_XLEN(0xfffffeff)
    c.or x9, x13
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfffffeff) 
 
    # Testcase 42:  rd:x10(0xfffffdff), rs2:x14(0x00800000), result rd:x10(0xfffffdff)
    li  x14, MASK_XLEN(0x800000)
    li  x10, MASK_XLEN(0xfffffdff)
    c.or x10, x14
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffdff) 
 
    # Testcase 43:  rd:x11(0xfffffbff), rs2:x15(0x00400000), result rd:x11(0xfffffbff)
    li  x15, MASK_XLEN(0x400000)
    li  x11, MASK_XLEN(0xfffffbff)
    c.or x11, x15
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffbff) 
 
    # Testcase 44:  rd:x12(0xfffff7ff), rs2:x8(0x00200000), result rd:x12(0xfffff7ff)
    li  x8, MASK_XLEN(0x200000)
    li  x12, MASK_XLEN(0xfffff7ff)
    c.or x12, x8
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffff7ff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x1, test_10_res

 
    # Testcase 45:  rd:x13(0xffffefff), rs2:x9(0x00100000), result rd:x13(0xffffefff)
    li  x9, MASK_XLEN(0x100000)
    li  x13, MASK_XLEN(0xffffefff)
    c.or x13, x9
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffffefff) 
 
    # Testcase 46:  rd:x14(0xffffdfff), rs2:x10(0x00080000), result rd:x14(0xffffdfff)
    li  x10, MASK_XLEN(0x80000)
    li  x14, MASK_XLEN(0xffffdfff)
    c.or x14, x10
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffdfff) 
 
    # Testcase 47:  rd:x15(0xffffbfff), rs2:x11(0x00040000), result rd:x15(0xffffbfff)
    li  x11, MASK_XLEN(0x40000)
    li  x15, MASK_XLEN(0xffffbfff)
    c.or x15, x11
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffbfff) 
 
    # Testcase 48:  rd:x8(0xffff7fff), rs2:x12(0x00020000), result rd:x8(0xffff7fff)
    li  x12, MASK_XLEN(0x20000)
    li  x8, MASK_XLEN(0xffff7fff)
    c.or x8, x12
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffff7fff) 
 
    # Testcase 49:  rd:x9(0xfffeffff), rs2:x13(0x00010000), result rd:x9(0xffffffff)
    li  x13, MASK_XLEN(0x10000)
    li  x9, MASK_XLEN(0xfffeffff)
    c.or x9, x13
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res

 
    # Testcase 50:  rd:x10(0xfffdffff), rs2:x14(0x00008000), result rd:x10(0xfffdffff)
    li  x14, MASK_XLEN(0x8000)
    li  x10, MASK_XLEN(0xfffdffff)
    c.or x10, x14
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffdffff) 
 
    # Testcase 51:  rd:x11(0xfffbffff), rs2:x15(0x00004000), result rd:x11(0xfffbffff)
    li  x15, MASK_XLEN(0x4000)
    li  x11, MASK_XLEN(0xfffbffff)
    c.or x11, x15
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffbffff) 
 
    # Testcase 52:  rd:x12(0xfff7ffff), rs2:x8(0x00002000), result rd:x12(0xfff7ffff)
    li  x8, MASK_XLEN(0x2000)
    li  x12, MASK_XLEN(0xfff7ffff)
    c.or x12, x8
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfff7ffff) 
 
    # Testcase 53:  rd:x13(0xffefffff), rs2:x9(0x00001000), result rd:x13(0xffefffff)
    li  x9, MASK_XLEN(0x1000)
    li  x13, MASK_XLEN(0xffefffff)
    c.or x13, x9
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xffefffff) 
 
    # Testcase 54:  rd:x14(0xffdfffff), rs2:x10(0x00000800), result rd:x14(0xffdfffff)
    li  x10, MASK_XLEN(0x800)
    li  x14, MASK_XLEN(0xffdfffff)
    c.or x14, x10
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffdfffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res

 
    # Testcase 55:  rd:x15(0xffbfffff), rs2:x11(0x00000400), result rd:x15(0xffbfffff)
    li  x11, MASK_XLEN(0x400)
    li  x15, MASK_XLEN(0xffbfffff)
    c.or x15, x11
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffbfffff) 
 
    # Testcase 56:  rd:x8(0xff7fffff), rs2:x12(0x00000200), result rd:x8(0xff7fffff)
    li  x12, MASK_XLEN(0x200)
    li  x8, MASK_XLEN(0xff7fffff)
    c.or x8, x12
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xff7fffff) 
 
    # Testcase 57:  rd:x9(0xfeffffff), rs2:x13(0x00000100), result rd:x9(0xfeffffff)
    li  x13, MASK_XLEN(0x100)
    li  x9, MASK_XLEN(0xfeffffff)
    c.or x9, x13
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xfeffffff) 
 
    # Testcase 58:  rd:x10(0xfdffffff), rs2:x14(0x00000080), result rd:x10(0xfdffffff)
    li  x14, MASK_XLEN(0x80)
    li  x10, MASK_XLEN(0xfdffffff)
    c.or x10, x14
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfdffffff) 
 
    # Testcase 59:  rd:x11(0xfbffffff), rs2:x15(0x00000040), result rd:x11(0xfbffffff)
    li  x15, MASK_XLEN(0x40)
    li  x11, MASK_XLEN(0xfbffffff)
    c.or x11, x15
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfbffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x1, test_13_res

 
    # Testcase 60:  rd:x12(0xf7ffffff), rs2:x8(0x00000020), result rd:x12(0xf7ffffff)
    li  x8, MASK_XLEN(0x20)
    li  x12, MASK_XLEN(0xf7ffffff)
    c.or x12, x8
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xf7ffffff) 
 
    # Testcase 61:  rd:x13(0xefffffff), rs2:x9(0x00000010), result rd:x13(0xefffffff)
    li  x9, MASK_XLEN(0x10)
    li  x13, MASK_XLEN(0xefffffff)
    c.or x13, x9
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xefffffff) 
 
    # Testcase 62:  rd:x14(0xdfffffff), rs2:x10(0x00000008), result rd:x14(0xdfffffff)
    li  x10, MASK_XLEN(0x8)
    li  x14, MASK_XLEN(0xdfffffff)
    c.or x14, x10
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xdfffffff) 
 
    # Testcase 63:  rd:x15(0xbfffffff), rs2:x11(0x00000004), result rd:x15(0xbfffffff)
    li  x11, MASK_XLEN(0x4)
    li  x15, MASK_XLEN(0xbfffffff)
    c.or x15, x11
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xbfffffff) 
 
    # Testcase 64:  rd:x8(0x7fffffff), rs2:x12(0x00000002), result rd:x8(0x7fffffff)
    li  x12, MASK_XLEN(0x2)
    li  x8, MASK_XLEN(0x7fffffff)
    c.or x8, x12
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x7fffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res

 
    # Testcase 65:  rd:x9(0xffffffff), rs2:x13(0x00000001), result rd:x9(0xffffffff)
    li  x13, MASK_XLEN(0x1)
    li  x9, MASK_XLEN(0xffffffff)
    c.or x9, x13
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffff) 
 
    # Testcase 66:  rd:x10(0x00000001), rs2:x14(0x00000000), result rd:x10(0x00000001)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x1)
    c.or x10, x14
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1) 
 
    # Testcase 67:  rd:x11(0x00000002), rs2:x15(0x00000000), result rd:x11(0x00000002)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x2)
    c.or x11, x15
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x2) 
 
    # Testcase 68:  rd:x12(0x00000004), rs2:x8(0x00000000), result rd:x12(0x00000004)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x4)
    c.or x12, x8
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x4) 
 
    # Testcase 69:  rd:x13(0x00000008), rs2:x9(0x00000000), result rd:x13(0x00000008)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x8)
    c.or x13, x9
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x8) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res

 
    # Testcase 70:  rd:x14(0x00000010), rs2:x10(0x00000000), result rd:x14(0x00000010)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x10)
    c.or x14, x10
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x10) 
 
    # Testcase 71:  rd:x15(0x00000020), rs2:x11(0x00000000), result rd:x15(0x00000020)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x20)
    c.or x15, x11
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x20) 
 
    # Testcase 72:  rd:x8(0x00000040), rs2:x12(0x00000000), result rd:x8(0x00000040)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x40)
    c.or x8, x12
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x40) 
 
    # Testcase 73:  rd:x9(0x00000080), rs2:x13(0x00000000), result rd:x9(0x00000080)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x80)
    c.or x9, x13
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x80) 
 
    # Testcase 74:  rd:x10(0x00000100), rs2:x14(0x00000000), result rd:x10(0x00000100)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x100)
    c.or x10, x14
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x100) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x1, test_16_res

 
    # Testcase 75:  rd:x11(0x00000200), rs2:x15(0x00000000), result rd:x11(0x00000200)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x200)
    c.or x11, x15
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x200) 
 
    # Testcase 76:  rd:x12(0x00000400), rs2:x8(0x00000000), result rd:x12(0x00000400)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x400)
    c.or x12, x8
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x400) 
 
    # Testcase 77:  rd:x13(0x00000800), rs2:x9(0x00000000), result rd:x13(0x00000800)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x800)
    c.or x13, x9
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x800) 
 
    # Testcase 78:  rd:x14(0x00001000), rs2:x10(0x00000000), result rd:x14(0x00001000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x1000)
    c.or x14, x10
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x1000) 
 
    # Testcase 79:  rd:x15(0x00002000), rs2:x11(0x00000000), result rd:x15(0x00002000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x2000)
    c.or x15, x11
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x2000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res

 
    # Testcase 80:  rd:x8(0x00004000), rs2:x12(0x00000000), result rd:x8(0x00004000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x4000)
    c.or x8, x12
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x4000) 
 
    # Testcase 81:  rd:x9(0x00008000), rs2:x13(0x00000000), result rd:x9(0x00008000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x8000)
    c.or x9, x13
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x8000) 
 
    # Testcase 82:  rd:x10(0x00010000), rs2:x14(0x00000000), result rd:x10(0x00010000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x10000)
    c.or x10, x14
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x10000) 
 
    # Testcase 83:  rd:x11(0x00020000), rs2:x15(0x00000000), result rd:x11(0x00020000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x20000)
    c.or x11, x15
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x20000) 
 
    # Testcase 84:  rd:x12(0x00040000), rs2:x8(0x00000000), result rd:x12(0x00040000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x40000)
    c.or x12, x8
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x40000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res

 
    # Testcase 85:  rd:x13(0x00080000), rs2:x9(0x00000000), result rd:x13(0x00080000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x80000)
    c.or x13, x9
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x80000) 
 
    # Testcase 86:  rd:x14(0x00100000), rs2:x10(0x00000000), result rd:x14(0x00100000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x100000)
    c.or x14, x10
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x100000) 
 
    # Testcase 87:  rd:x15(0x00200000), rs2:x11(0x00000000), result rd:x15(0x00200000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x200000)
    c.or x15, x11
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x200000) 
 
    # Testcase 88:  rd:x8(0x00400000), rs2:x12(0x00000000), result rd:x8(0x00400000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x400000)
    c.or x8, x12
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x400000) 
 
    # Testcase 89:  rd:x9(0x00800000), rs2:x13(0x00000000), result rd:x9(0x00800000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x800000)
    c.or x9, x13
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x800000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x1, test_19_res

 
    # Testcase 90:  rd:x10(0x01000000), rs2:x14(0x00000000), result rd:x10(0x01000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x1000000)
    c.or x10, x14
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1000000) 
 
    # Testcase 91:  rd:x11(0x02000000), rs2:x15(0x00000000), result rd:x11(0x02000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x2000000)
    c.or x11, x15
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x2000000) 
 
    # Testcase 92:  rd:x12(0x04000000), rs2:x8(0x00000000), result rd:x12(0x04000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x4000000)
    c.or x12, x8
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x4000000) 
 
    # Testcase 93:  rd:x13(0x08000000), rs2:x9(0x00000000), result rd:x13(0x08000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x8000000)
    c.or x13, x9
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x8000000) 
 
    # Testcase 94:  rd:x14(0x10000000), rs2:x10(0x00000000), result rd:x14(0x10000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x10000000)
    c.or x14, x10
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x10000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res

 
    # Testcase 95:  rd:x15(0x20000000), rs2:x11(0x00000000), result rd:x15(0x20000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x20000000)
    c.or x15, x11
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x20000000) 
 
    # Testcase 96:  rd:x8(0x40000000), rs2:x12(0x00000000), result rd:x8(0x40000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x40000000)
    c.or x8, x12
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x40000000) 
 
    # Testcase 97:  rd:x9(0x80000000), rs2:x13(0x00000000), result rd:x9(0x80000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x80000000)
    c.or x9, x13
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x80000000) 
 
    # Testcase 98:  rd:x10(0x00000000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x0)
    c.or x10, x14
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 99:  rd:x11(0xfffffffe), rs2:x15(0x00000000), result rd:x11(0xfffffffe)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffffe)
    c.or x11, x15
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffe) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res

 
    # Testcase 100:  rd:x12(0xfffffffd), rs2:x8(0x00000000), result rd:x12(0xfffffffd)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffffd)
    c.or x12, x8
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffd) 
 
    # Testcase 101:  rd:x13(0xfffffffb), rs2:x9(0x00000000), result rd:x13(0xfffffffb)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffffb)
    c.or x13, x9
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffb) 
 
    # Testcase 102:  rd:x14(0xfffffff7), rs2:x10(0x00000000), result rd:x14(0xfffffff7)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffffff7)
    c.or x14, x10
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffffff7) 
 
    # Testcase 103:  rd:x15(0xffffffef), rs2:x11(0x00000000), result rd:x15(0xffffffef)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffffef)
    c.or x15, x11
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffffef) 
 
    # Testcase 104:  rd:x8(0xffffffdf), rs2:x12(0x00000000), result rd:x8(0xffffffdf)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffffdf)
    c.or x8, x12
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffdf) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x1, test_22_res

 
    # Testcase 105:  rd:x9(0xffffffbf), rs2:x13(0x00000000), result rd:x9(0xffffffbf)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffffbf)
    c.or x9, x13
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffbf) 
 
    # Testcase 106:  rd:x10(0xffffff7f), rs2:x14(0x00000000), result rd:x10(0xffffff7f)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffffff7f)
    c.or x10, x14
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffff7f) 
 
    # Testcase 107:  rd:x11(0xfffffeff), rs2:x15(0x00000000), result rd:x11(0xfffffeff)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffeff)
    c.or x11, x15
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffeff) 
 
    # Testcase 108:  rd:x12(0xfffffdff), rs2:x8(0x00000000), result rd:x12(0xfffffdff)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffdff)
    c.or x12, x8
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffdff) 
 
    # Testcase 109:  rd:x13(0xfffffbff), rs2:x9(0x00000000), result rd:x13(0xfffffbff)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffbff)
    c.or x13, x9
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffbff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res

 
    # Testcase 110:  rd:x14(0xfffff7ff), rs2:x10(0x00000000), result rd:x14(0xfffff7ff)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffff7ff)
    c.or x14, x10
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfffff7ff) 
 
    # Testcase 111:  rd:x15(0xffffefff), rs2:x11(0x00000000), result rd:x15(0xffffefff)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffefff)
    c.or x15, x11
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffffefff) 
 
    # Testcase 112:  rd:x8(0xffffdfff), rs2:x12(0x00000000), result rd:x8(0xffffdfff)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffdfff)
    c.or x8, x12
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffdfff) 
 
    # Testcase 113:  rd:x9(0xffffbfff), rs2:x13(0x00000000), result rd:x9(0xffffbfff)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffbfff)
    c.or x9, x13
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffbfff) 
 
    # Testcase 114:  rd:x10(0xffff7fff), rs2:x14(0x00000000), result rd:x10(0xffff7fff)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffff7fff)
    c.or x10, x14
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffff7fff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res

 
    # Testcase 115:  rd:x11(0xfffeffff), rs2:x15(0x00000000), result rd:x11(0xfffeffff)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffeffff)
    c.or x11, x15
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffeffff) 
 
    # Testcase 116:  rd:x12(0xfffdffff), rs2:x8(0x00000000), result rd:x12(0xfffdffff)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffdffff)
    c.or x12, x8
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffdffff) 
 
    # Testcase 117:  rd:x13(0xfffbffff), rs2:x9(0x00000000), result rd:x13(0xfffbffff)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffbffff)
    c.or x13, x9
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffbffff) 
 
    # Testcase 118:  rd:x14(0xfff7ffff), rs2:x10(0x00000000), result rd:x14(0xfff7ffff)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfff7ffff)
    c.or x14, x10
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xfff7ffff) 
 
    # Testcase 119:  rd:x15(0xffefffff), rs2:x11(0x00000000), result rd:x15(0xffefffff)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffefffff)
    c.or x15, x11
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xffefffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x1, test_25_res

 
    # Testcase 120:  rd:x8(0xffdfffff), rs2:x12(0x00000000), result rd:x8(0xffdfffff)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffdfffff)
    c.or x8, x12
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffdfffff) 
 
    # Testcase 121:  rd:x9(0xffbfffff), rs2:x13(0x00000000), result rd:x9(0xffbfffff)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffbfffff)
    c.or x9, x13
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffbfffff) 
 
    # Testcase 122:  rd:x10(0xff7fffff), rs2:x14(0x00000000), result rd:x10(0xff7fffff)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xff7fffff)
    c.or x10, x14
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xff7fffff) 
 
    # Testcase 123:  rd:x11(0xfeffffff), rs2:x15(0x00000000), result rd:x11(0xfeffffff)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfeffffff)
    c.or x11, x15
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfeffffff) 
 
    # Testcase 124:  rd:x12(0xfdffffff), rs2:x8(0x00000000), result rd:x12(0xfdffffff)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfdffffff)
    c.or x12, x8
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfdffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res

 
    # Testcase 125:  rd:x13(0xfbffffff), rs2:x9(0x00000000), result rd:x13(0xfbffffff)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfbffffff)
    c.or x13, x9
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfbffffff) 
 
    # Testcase 126:  rd:x14(0xf7ffffff), rs2:x10(0x00000000), result rd:x14(0xf7ffffff)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xf7ffffff)
    c.or x14, x10
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xf7ffffff) 
 
    # Testcase 127:  rd:x15(0xefffffff), rs2:x11(0x00000000), result rd:x15(0xefffffff)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xefffffff)
    c.or x15, x11
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xefffffff) 
 
    # Testcase 128:  rd:x8(0xdfffffff), rs2:x12(0x00000000), result rd:x8(0xdfffffff)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xdfffffff)
    c.or x8, x12
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xdfffffff) 
 
    # Testcase 129:  rd:x9(0xbfffffff), rs2:x13(0x00000000), result rd:x9(0xbfffffff)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xbfffffff)
    c.or x9, x13
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xbfffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res

 
    # Testcase 130:  rd:x10(0x7fffffff), rs2:x14(0x00000000), result rd:x10(0x7fffffff)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x7fffffff)
    c.or x10, x14
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x7fffffff) 
 
    # Testcase 131:  rd:x11(0xffffffff), rs2:x15(0x00000000), result rd:x11(0xffffffff)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xffffffff)
    c.or x11, x15
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffff) 
 
    # Testcase 132:  rd:x12(0x00000001), rs2:x8(0xffffffff), result rd:x12(0xffffffff)
    li  x8, MASK_XLEN(0xffffffff)
    li  x12, MASK_XLEN(0x1)
    c.or x12, x8
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffff) 
 
    # Testcase 133:  rd:x13(0x00000002), rs2:x9(0x7fffffff), result rd:x13(0x7fffffff)
    li  x9, MASK_XLEN(0x7fffffff)
    li  x13, MASK_XLEN(0x2)
    c.or x13, x9
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x7fffffff) 
 
    # Testcase 134:  rd:x14(0x00000004), rs2:x10(0xbfffffff), result rd:x14(0xbfffffff)
    li  x10, MASK_XLEN(0xbfffffff)
    li  x14, MASK_XLEN(0x4)
    c.or x14, x10
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xbfffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res

 
    # Testcase 135:  rd:x15(0x00000008), rs2:x11(0xdfffffff), result rd:x15(0xdfffffff)
    li  x11, MASK_XLEN(0xdfffffff)
    li  x15, MASK_XLEN(0x8)
    c.or x15, x11
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xdfffffff) 


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

