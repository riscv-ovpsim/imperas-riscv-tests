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

RV_COMPLIANCE_RV32M

RV_COMPLIANCE_CODE_BEGIN


	RVTEST_IO_INIT
	RVTEST_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
	RVTEST_IO_WRITE_STR(x31, "Test Begin\n")

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test group 1\n")


    # address for test results
    la x1, test_1_res

 
    # Testcase 0:  rd:x8(0x00000001), rs2:x12(0xffffffff), result rd:x8(0x00000001)
    li  x12, MASK_XLEN(0xffffffff)
    li  x8, MASK_XLEN(0x1)
    c.and x8, x12
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1) 
 
    # Testcase 1:  rd:x9(0x00000002), rs2:x13(0x7fffffff), result rd:x9(0x00000002)
    li  x13, MASK_XLEN(0x7fffffff)
    li  x9, MASK_XLEN(0x2)
    c.and x9, x13
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x2) 
 
    # Testcase 2:  rd:x10(0x00000004), rs2:x14(0xbfffffff), result rd:x10(0x00000004)
    li  x14, MASK_XLEN(0xbfffffff)
    li  x10, MASK_XLEN(0x4)
    c.and x10, x14
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x4) 
 
    # Testcase 3:  rd:x11(0x00000008), rs2:x15(0xdfffffff), result rd:x11(0x00000008)
    li  x15, MASK_XLEN(0xdfffffff)
    li  x11, MASK_XLEN(0x8)
    c.and x11, x15
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8) 
 
    # Testcase 4:  rd:x12(0x00000010), rs2:x8(0xefffffff), result rd:x12(0x00000010)
    li  x8, MASK_XLEN(0xefffffff)
    li  x12, MASK_XLEN(0x10)
    c.and x12, x8
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x10) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res

 
    # Testcase 5:  rd:x13(0x00000020), rs2:x9(0xf7ffffff), result rd:x13(0x00000020)
    li  x9, MASK_XLEN(0xf7ffffff)
    li  x13, MASK_XLEN(0x20)
    c.and x13, x9
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x20) 
 
    # Testcase 6:  rd:x14(0x00000040), rs2:x10(0xfbffffff), result rd:x14(0x00000040)
    li  x10, MASK_XLEN(0xfbffffff)
    li  x14, MASK_XLEN(0x40)
    c.and x14, x10
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x40) 
 
    # Testcase 7:  rd:x15(0x00000080), rs2:x11(0xfdffffff), result rd:x15(0x00000080)
    li  x11, MASK_XLEN(0xfdffffff)
    li  x15, MASK_XLEN(0x80)
    c.and x15, x11
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x80) 
 
    # Testcase 8:  rd:x8(0x00000100), rs2:x12(0xfeffffff), result rd:x8(0x00000100)
    li  x12, MASK_XLEN(0xfeffffff)
    li  x8, MASK_XLEN(0x100)
    c.and x8, x12
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x100) 
 
    # Testcase 9:  rd:x9(0x00000200), rs2:x13(0xff7fffff), result rd:x9(0x00000200)
    li  x13, MASK_XLEN(0xff7fffff)
    li  x9, MASK_XLEN(0x200)
    c.and x9, x13
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x200) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res

 
    # Testcase 10:  rd:x10(0x00000400), rs2:x14(0xffbfffff), result rd:x10(0x00000400)
    li  x14, MASK_XLEN(0xffbfffff)
    li  x10, MASK_XLEN(0x400)
    c.and x10, x14
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x400) 
 
    # Testcase 11:  rd:x11(0x00000800), rs2:x15(0xffdfffff), result rd:x11(0x00000800)
    li  x15, MASK_XLEN(0xffdfffff)
    li  x11, MASK_XLEN(0x800)
    c.and x11, x15
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x800) 
 
    # Testcase 12:  rd:x12(0x00001000), rs2:x8(0xffefffff), result rd:x12(0x00001000)
    li  x8, MASK_XLEN(0xffefffff)
    li  x12, MASK_XLEN(0x1000)
    c.and x12, x8
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000) 
 
    # Testcase 13:  rd:x13(0x00002000), rs2:x9(0xfff7ffff), result rd:x13(0x00002000)
    li  x9, MASK_XLEN(0xfff7ffff)
    li  x13, MASK_XLEN(0x2000)
    c.and x13, x9
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x2000) 
 
    # Testcase 14:  rd:x14(0x00004000), rs2:x10(0xfffbffff), result rd:x14(0x00004000)
    li  x10, MASK_XLEN(0xfffbffff)
    li  x14, MASK_XLEN(0x4000)
    c.and x14, x10
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x4000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x1, test_4_res

 
    # Testcase 15:  rd:x15(0x00008000), rs2:x11(0xfffdffff), result rd:x15(0x00008000)
    li  x11, MASK_XLEN(0xfffdffff)
    li  x15, MASK_XLEN(0x8000)
    c.and x15, x11
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x8000) 
 
    # Testcase 16:  rd:x8(0x00010000), rs2:x12(0xfffeffff), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0xfffeffff)
    li  x8, MASK_XLEN(0x10000)
    c.and x8, x12
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 17:  rd:x9(0x00020000), rs2:x13(0xffff7fff), result rd:x9(0x00020000)
    li  x13, MASK_XLEN(0xffff7fff)
    li  x9, MASK_XLEN(0x20000)
    c.and x9, x13
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x20000) 
 
    # Testcase 18:  rd:x10(0x00040000), rs2:x14(0xffffbfff), result rd:x10(0x00040000)
    li  x14, MASK_XLEN(0xffffbfff)
    li  x10, MASK_XLEN(0x40000)
    c.and x10, x14
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x40000) 
 
    # Testcase 19:  rd:x11(0x00080000), rs2:x15(0xffffdfff), result rd:x11(0x00080000)
    li  x15, MASK_XLEN(0xffffdfff)
    li  x11, MASK_XLEN(0x80000)
    c.and x11, x15
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x80000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res

 
    # Testcase 20:  rd:x12(0x00100000), rs2:x8(0xffffefff), result rd:x12(0x00100000)
    li  x8, MASK_XLEN(0xffffefff)
    li  x12, MASK_XLEN(0x100000)
    c.and x12, x8
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x100000) 
 
    # Testcase 21:  rd:x13(0x00200000), rs2:x9(0xfffff7ff), result rd:x13(0x00200000)
    li  x9, MASK_XLEN(0xfffff7ff)
    li  x13, MASK_XLEN(0x200000)
    c.and x13, x9
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x200000) 
 
    # Testcase 22:  rd:x14(0x00400000), rs2:x10(0xfffffbff), result rd:x14(0x00400000)
    li  x10, MASK_XLEN(0xfffffbff)
    li  x14, MASK_XLEN(0x400000)
    c.and x14, x10
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x400000) 
 
    # Testcase 23:  rd:x15(0x00800000), rs2:x11(0xfffffdff), result rd:x15(0x00800000)
    li  x11, MASK_XLEN(0xfffffdff)
    li  x15, MASK_XLEN(0x800000)
    c.and x15, x11
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x800000) 
 
    # Testcase 24:  rd:x8(0x01000000), rs2:x12(0xfffffeff), result rd:x8(0x01000000)
    li  x12, MASK_XLEN(0xfffffeff)
    li  x8, MASK_XLEN(0x1000000)
    c.and x8, x12
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res

 
    # Testcase 25:  rd:x9(0x02000000), rs2:x13(0xffffff7f), result rd:x9(0x02000000)
    li  x13, MASK_XLEN(0xffffff7f)
    li  x9, MASK_XLEN(0x2000000)
    c.and x9, x13
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x2000000) 
 
    # Testcase 26:  rd:x10(0x04000000), rs2:x14(0xffffffbf), result rd:x10(0x04000000)
    li  x14, MASK_XLEN(0xffffffbf)
    li  x10, MASK_XLEN(0x4000000)
    c.and x10, x14
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x4000000) 
 
    # Testcase 27:  rd:x11(0x08000000), rs2:x15(0xffffffdf), result rd:x11(0x08000000)
    li  x15, MASK_XLEN(0xffffffdf)
    li  x11, MASK_XLEN(0x8000000)
    c.and x11, x15
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x8000000) 
 
    # Testcase 28:  rd:x12(0x10000000), rs2:x8(0xffffffef), result rd:x12(0x10000000)
    li  x8, MASK_XLEN(0xffffffef)
    li  x12, MASK_XLEN(0x10000000)
    c.and x12, x8
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x10000000) 
 
    # Testcase 29:  rd:x13(0x20000000), rs2:x9(0xfffffff7), result rd:x13(0x20000000)
    li  x9, MASK_XLEN(0xfffffff7)
    li  x13, MASK_XLEN(0x20000000)
    c.and x13, x9
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x20000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x1, test_7_res

 
    # Testcase 30:  rd:x14(0x40000000), rs2:x10(0xfffffffb), result rd:x14(0x40000000)
    li  x10, MASK_XLEN(0xfffffffb)
    li  x14, MASK_XLEN(0x40000000)
    c.and x14, x10
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x40000000) 
 
    # Testcase 31:  rd:x15(0x80000000), rs2:x11(0xfffffffd), result rd:x15(0x80000000)
    li  x11, MASK_XLEN(0xfffffffd)
    li  x15, MASK_XLEN(0x80000000)
    c.and x15, x11
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x80000000) 
 
    # Testcase 32:  rd:x8(0x00000000), rs2:x12(0xfffffffe), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0xfffffffe)
    li  x8, MASK_XLEN(0x0)
    c.and x8, x12
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 33:  rd:x9(0xfffffffe), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xfffffffe)
    c.and x9, x13
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 34:  rd:x10(0xfffffffd), rs2:x14(0x80000000), result rd:x10(0x80000000)
    li  x14, MASK_XLEN(0x80000000)
    li  x10, MASK_XLEN(0xfffffffd)
    c.and x10, x14
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res

 
    # Testcase 35:  rd:x11(0xfffffffb), rs2:x15(0x40000000), result rd:x11(0x40000000)
    li  x15, MASK_XLEN(0x40000000)
    li  x11, MASK_XLEN(0xfffffffb)
    c.and x11, x15
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x40000000) 
 
    # Testcase 36:  rd:x12(0xfffffff7), rs2:x8(0x20000000), result rd:x12(0x20000000)
    li  x8, MASK_XLEN(0x20000000)
    li  x12, MASK_XLEN(0xfffffff7)
    c.and x12, x8
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20000000) 
 
    # Testcase 37:  rd:x13(0xffffffef), rs2:x9(0x10000000), result rd:x13(0x10000000)
    li  x9, MASK_XLEN(0x10000000)
    li  x13, MASK_XLEN(0xffffffef)
    c.and x13, x9
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x10000000) 
 
    # Testcase 38:  rd:x14(0xffffffdf), rs2:x10(0x08000000), result rd:x14(0x08000000)
    li  x10, MASK_XLEN(0x8000000)
    li  x14, MASK_XLEN(0xffffffdf)
    c.and x14, x10
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000000) 
 
    # Testcase 39:  rd:x15(0xffffffbf), rs2:x11(0x04000000), result rd:x15(0x04000000)
    li  x11, MASK_XLEN(0x4000000)
    li  x15, MASK_XLEN(0xffffffbf)
    c.and x15, x11
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x4000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res

 
    # Testcase 40:  rd:x8(0xffffff7f), rs2:x12(0x02000000), result rd:x8(0x02000000)
    li  x12, MASK_XLEN(0x2000000)
    li  x8, MASK_XLEN(0xffffff7f)
    c.and x8, x12
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2000000) 
 
    # Testcase 41:  rd:x9(0xfffffeff), rs2:x13(0x01000000), result rd:x9(0x01000000)
    li  x13, MASK_XLEN(0x1000000)
    li  x9, MASK_XLEN(0xfffffeff)
    c.and x9, x13
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1000000) 
 
    # Testcase 42:  rd:x10(0xfffffdff), rs2:x14(0x00800000), result rd:x10(0x00800000)
    li  x14, MASK_XLEN(0x800000)
    li  x10, MASK_XLEN(0xfffffdff)
    c.and x10, x14
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x800000) 
 
    # Testcase 43:  rd:x11(0xfffffbff), rs2:x15(0x00400000), result rd:x11(0x00400000)
    li  x15, MASK_XLEN(0x400000)
    li  x11, MASK_XLEN(0xfffffbff)
    c.and x11, x15
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x400000) 
 
    # Testcase 44:  rd:x12(0xfffff7ff), rs2:x8(0x00200000), result rd:x12(0x00200000)
    li  x8, MASK_XLEN(0x200000)
    li  x12, MASK_XLEN(0xfffff7ff)
    c.and x12, x8
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x200000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x1, test_10_res

 
    # Testcase 45:  rd:x13(0xffffefff), rs2:x9(0x00100000), result rd:x13(0x00100000)
    li  x9, MASK_XLEN(0x100000)
    li  x13, MASK_XLEN(0xffffefff)
    c.and x13, x9
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x100000) 
 
    # Testcase 46:  rd:x14(0xffffdfff), rs2:x10(0x00080000), result rd:x14(0x00080000)
    li  x10, MASK_XLEN(0x80000)
    li  x14, MASK_XLEN(0xffffdfff)
    c.and x14, x10
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x80000) 
 
    # Testcase 47:  rd:x15(0xffffbfff), rs2:x11(0x00040000), result rd:x15(0x00040000)
    li  x11, MASK_XLEN(0x40000)
    li  x15, MASK_XLEN(0xffffbfff)
    c.and x15, x11
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x40000) 
 
    # Testcase 48:  rd:x8(0xffff7fff), rs2:x12(0x00020000), result rd:x8(0x00020000)
    li  x12, MASK_XLEN(0x20000)
    li  x8, MASK_XLEN(0xffff7fff)
    c.and x8, x12
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x20000) 
 
    # Testcase 49:  rd:x9(0xfffeffff), rs2:x13(0x00010000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x10000)
    li  x9, MASK_XLEN(0xfffeffff)
    c.and x9, x13
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res

 
    # Testcase 50:  rd:x10(0xfffdffff), rs2:x14(0x00008000), result rd:x10(0x00008000)
    li  x14, MASK_XLEN(0x8000)
    li  x10, MASK_XLEN(0xfffdffff)
    c.and x10, x14
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x8000) 
 
    # Testcase 51:  rd:x11(0xfffbffff), rs2:x15(0x00004000), result rd:x11(0x00004000)
    li  x15, MASK_XLEN(0x4000)
    li  x11, MASK_XLEN(0xfffbffff)
    c.and x11, x15
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x4000) 
 
    # Testcase 52:  rd:x12(0xfff7ffff), rs2:x8(0x00002000), result rd:x12(0x00002000)
    li  x8, MASK_XLEN(0x2000)
    li  x12, MASK_XLEN(0xfff7ffff)
    c.and x12, x8
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x2000) 
 
    # Testcase 53:  rd:x13(0xffefffff), rs2:x9(0x00001000), result rd:x13(0x00001000)
    li  x9, MASK_XLEN(0x1000)
    li  x13, MASK_XLEN(0xffefffff)
    c.and x13, x9
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x1000) 
 
    # Testcase 54:  rd:x14(0xffdfffff), rs2:x10(0x00000800), result rd:x14(0x00000800)
    li  x10, MASK_XLEN(0x800)
    li  x14, MASK_XLEN(0xffdfffff)
    c.and x14, x10
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x800) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res

 
    # Testcase 55:  rd:x15(0xffbfffff), rs2:x11(0x00000400), result rd:x15(0x00000400)
    li  x11, MASK_XLEN(0x400)
    li  x15, MASK_XLEN(0xffbfffff)
    c.and x15, x11
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x400) 
 
    # Testcase 56:  rd:x8(0xff7fffff), rs2:x12(0x00000200), result rd:x8(0x00000200)
    li  x12, MASK_XLEN(0x200)
    li  x8, MASK_XLEN(0xff7fffff)
    c.and x8, x12
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x200) 
 
    # Testcase 57:  rd:x9(0xfeffffff), rs2:x13(0x00000100), result rd:x9(0x00000100)
    li  x13, MASK_XLEN(0x100)
    li  x9, MASK_XLEN(0xfeffffff)
    c.and x9, x13
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x100) 
 
    # Testcase 58:  rd:x10(0xfdffffff), rs2:x14(0x00000080), result rd:x10(0x00000080)
    li  x14, MASK_XLEN(0x80)
    li  x10, MASK_XLEN(0xfdffffff)
    c.and x10, x14
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x80) 
 
    # Testcase 59:  rd:x11(0xfbffffff), rs2:x15(0x00000040), result rd:x11(0x00000040)
    li  x15, MASK_XLEN(0x40)
    li  x11, MASK_XLEN(0xfbffffff)
    c.and x11, x15
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x40) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x1, test_13_res

 
    # Testcase 60:  rd:x12(0xf7ffffff), rs2:x8(0x00000020), result rd:x12(0x00000020)
    li  x8, MASK_XLEN(0x20)
    li  x12, MASK_XLEN(0xf7ffffff)
    c.and x12, x8
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x20) 
 
    # Testcase 61:  rd:x13(0xefffffff), rs2:x9(0x00000010), result rd:x13(0x00000010)
    li  x9, MASK_XLEN(0x10)
    li  x13, MASK_XLEN(0xefffffff)
    c.and x13, x9
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x10) 
 
    # Testcase 62:  rd:x14(0xdfffffff), rs2:x10(0x00000008), result rd:x14(0x00000008)
    li  x10, MASK_XLEN(0x8)
    li  x14, MASK_XLEN(0xdfffffff)
    c.and x14, x10
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8) 
 
    # Testcase 63:  rd:x15(0xbfffffff), rs2:x11(0x00000004), result rd:x15(0x00000004)
    li  x11, MASK_XLEN(0x4)
    li  x15, MASK_XLEN(0xbfffffff)
    c.and x15, x11
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x4) 
 
    # Testcase 64:  rd:x8(0x7fffffff), rs2:x12(0x00000002), result rd:x8(0x00000002)
    li  x12, MASK_XLEN(0x2)
    li  x8, MASK_XLEN(0x7fffffff)
    c.and x8, x12
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x2) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res

 
    # Testcase 65:  rd:x9(0xffffffff), rs2:x13(0x00000001), result rd:x9(0x00000001)
    li  x13, MASK_XLEN(0x1)
    li  x9, MASK_XLEN(0xffffffff)
    c.and x9, x13
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1) 
 
    # Testcase 66:  rd:x10(0x00000001), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x1)
    c.and x10, x14
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 67:  rd:x11(0x00000002), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x2)
    c.and x11, x15
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 68:  rd:x12(0x00000004), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x4)
    c.and x12, x8
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 69:  rd:x13(0x00000008), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x8)
    c.and x13, x9
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res

 
    # Testcase 70:  rd:x14(0x00000010), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x10)
    c.and x14, x10
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 71:  rd:x15(0x00000020), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x20)
    c.and x15, x11
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 72:  rd:x8(0x00000040), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x40)
    c.and x8, x12
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 73:  rd:x9(0x00000080), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x80)
    c.and x9, x13
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 74:  rd:x10(0x00000100), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x100)
    c.and x10, x14
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x1, test_16_res

 
    # Testcase 75:  rd:x11(0x00000200), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x200)
    c.and x11, x15
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 76:  rd:x12(0x00000400), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x400)
    c.and x12, x8
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 77:  rd:x13(0x00000800), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x800)
    c.and x13, x9
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 78:  rd:x14(0x00001000), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x1000)
    c.and x14, x10
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 79:  rd:x15(0x00002000), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x2000)
    c.and x15, x11
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res

 
    # Testcase 80:  rd:x8(0x00004000), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x4000)
    c.and x8, x12
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 81:  rd:x9(0x00008000), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x8000)
    c.and x9, x13
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 82:  rd:x10(0x00010000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x10000)
    c.and x10, x14
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 83:  rd:x11(0x00020000), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x20000)
    c.and x11, x15
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 84:  rd:x12(0x00040000), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x40000)
    c.and x12, x8
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res

 
    # Testcase 85:  rd:x13(0x00080000), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x80000)
    c.and x13, x9
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 86:  rd:x14(0x00100000), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x100000)
    c.and x14, x10
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 87:  rd:x15(0x00200000), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x200000)
    c.and x15, x11
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 88:  rd:x8(0x00400000), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x400000)
    c.and x8, x12
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 89:  rd:x9(0x00800000), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x800000)
    c.and x9, x13
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x1, test_19_res

 
    # Testcase 90:  rd:x10(0x01000000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x1000000)
    c.and x10, x14
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 91:  rd:x11(0x02000000), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x2000000)
    c.and x11, x15
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 92:  rd:x12(0x04000000), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x4000000)
    c.and x12, x8
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 93:  rd:x13(0x08000000), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x8000000)
    c.and x13, x9
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 94:  rd:x14(0x10000000), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x10000000)
    c.and x14, x10
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res

 
    # Testcase 95:  rd:x15(0x20000000), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x20000000)
    c.and x15, x11
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 96:  rd:x8(0x40000000), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x40000000)
    c.and x8, x12
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 97:  rd:x9(0x80000000), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x80000000)
    c.and x9, x13
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 98:  rd:x10(0x00000000), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x0)
    c.and x10, x14
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 99:  rd:x11(0xfffffffe), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffffe)
    c.and x11, x15
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res

 
    # Testcase 100:  rd:x12(0xfffffffd), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffffd)
    c.and x12, x8
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 101:  rd:x13(0xfffffffb), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffffb)
    c.and x13, x9
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 102:  rd:x14(0xfffffff7), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffffff7)
    c.and x14, x10
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 103:  rd:x15(0xffffffef), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffffef)
    c.and x15, x11
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 104:  rd:x8(0xffffffdf), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffffdf)
    c.and x8, x12
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x1, test_22_res

 
    # Testcase 105:  rd:x9(0xffffffbf), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffffbf)
    c.and x9, x13
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 106:  rd:x10(0xffffff7f), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffffff7f)
    c.and x10, x14
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 107:  rd:x11(0xfffffeff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffeff)
    c.and x11, x15
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 108:  rd:x12(0xfffffdff), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffdff)
    c.and x12, x8
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 109:  rd:x13(0xfffffbff), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffbff)
    c.and x13, x9
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res

 
    # Testcase 110:  rd:x14(0xfffff7ff), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffff7ff)
    c.and x14, x10
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 111:  rd:x15(0xffffefff), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffefff)
    c.and x15, x11
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 112:  rd:x8(0xffffdfff), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffdfff)
    c.and x8, x12
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 113:  rd:x9(0xffffbfff), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffbfff)
    c.and x9, x13
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 114:  rd:x10(0xffff7fff), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffff7fff)
    c.and x10, x14
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res

 
    # Testcase 115:  rd:x11(0xfffeffff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffeffff)
    c.and x11, x15
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 116:  rd:x12(0xfffdffff), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffdffff)
    c.and x12, x8
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 
 
    # Testcase 117:  rd:x13(0xfffbffff), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffbffff)
    c.and x13, x9
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 118:  rd:x14(0xfff7ffff), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfff7ffff)
    c.and x14, x10
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 119:  rd:x15(0xffefffff), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffefffff)
    c.and x15, x11
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x1, test_25_res

 
    # Testcase 120:  rd:x8(0xffdfffff), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffdfffff)
    c.and x8, x12
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 121:  rd:x9(0xffbfffff), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffbfffff)
    c.and x9, x13
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 
 
    # Testcase 122:  rd:x10(0xff7fffff), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xff7fffff)
    c.and x10, x14
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 123:  rd:x11(0xfeffffff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfeffffff)
    c.and x11, x15
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 124:  rd:x12(0xfdffffff), rs2:x8(0x00000000), result rd:x12(0x00000000)
    li  x8, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfdffffff)
    c.and x12, x8
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res

 
    # Testcase 125:  rd:x13(0xfbffffff), rs2:x9(0x00000000), result rd:x13(0x00000000)
    li  x9, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfbffffff)
    c.and x13, x9
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0) 
 
    # Testcase 126:  rd:x14(0xf7ffffff), rs2:x10(0x00000000), result rd:x14(0x00000000)
    li  x10, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xf7ffffff)
    c.and x14, x10
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0) 
 
    # Testcase 127:  rd:x15(0xefffffff), rs2:x11(0x00000000), result rd:x15(0x00000000)
    li  x11, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xefffffff)
    c.and x15, x11
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0x0) 
 
    # Testcase 128:  rd:x8(0xdfffffff), rs2:x12(0x00000000), result rd:x8(0x00000000)
    li  x12, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xdfffffff)
    c.and x8, x12
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0) 
 
    # Testcase 129:  rd:x9(0xbfffffff), rs2:x13(0x00000000), result rd:x9(0x00000000)
    li  x13, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xbfffffff)
    c.and x9, x13
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res

 
    # Testcase 130:  rd:x10(0x7fffffff), rs2:x14(0x00000000), result rd:x10(0x00000000)
    li  x14, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x7fffffff)
    c.and x10, x14
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0) 
 
    # Testcase 131:  rd:x11(0xffffffff), rs2:x15(0x00000000), result rd:x11(0x00000000)
    li  x15, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xffffffff)
    c.and x11, x15
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0) 
 
    # Testcase 132:  rd:x12(0x00000001), rs2:x8(0xffffffff), result rd:x12(0x00000001)
    li  x8, MASK_XLEN(0xffffffff)
    li  x12, MASK_XLEN(0x1)
    c.and x12, x8
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1) 
 
    # Testcase 133:  rd:x13(0x00000002), rs2:x9(0x7fffffff), result rd:x13(0x00000002)
    li  x9, MASK_XLEN(0x7fffffff)
    li  x13, MASK_XLEN(0x2)
    c.and x13, x9
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x2) 
 
    # Testcase 134:  rd:x14(0x00000004), rs2:x10(0xbfffffff), result rd:x14(0x00000004)
    li  x10, MASK_XLEN(0xbfffffff)
    li  x14, MASK_XLEN(0x4)
    c.and x14, x10
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x4) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res

 
    # Testcase 135:  rd:x15(0x00000008), rs2:x11(0xdfffffff), result rd:x15(0x00000008)
    li  x11, MASK_XLEN(0xdfffffff)
    li  x15, MASK_XLEN(0x8)
    c.and x15, x11
    sw x15, 0(x1)
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

