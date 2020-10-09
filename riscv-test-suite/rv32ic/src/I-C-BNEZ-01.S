# RISC-V Compliance Test I-C-BNEZ-01
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
# Description: Testing instruction 'c.bnez'.

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
    
     # Testcase 0:  rs1:x15(0x1), result Branch=1
    li x8, 0xcccc
    li x15, 0x1
    c.bnez x15, 1f
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 1:  rs1:x14(0x2), result Branch=1
    li x9, 0xcccc
    li x14, 0x2
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 2:  rs1:x13(0x4), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x10, 0xcccc
    li x13, 0x4
    c.bnez x13, 2b
    li x10, 0x123ab
4:
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 3:  rs1:x12(0x8), result Branch=1
    li x11, 0xcccc
    li x12, 0x8
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 4:  rs1:x11(0x10), result Branch=1
    li x12, 0xcccc
    li x11, 0x10
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res
    
     # Testcase 5:  rs1:x10(0x20), result Branch=1
    li x13, 0xcccc
    li x10, 0x20
    c.bnez x10, 1f
    li x13, 0x123ab
1: 
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 6:  rs1:x9(0x40), result Branch=1
    li x14, 0xcccc
    li x9, 0x40
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 7:  rs1:x8(0x80), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x15, 0xcccc
    li x8, 0x80
    c.bnez x8, 2b
    li x15, 0x123ab
4:
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 8:  rs1:x15(0x100), result Branch=1
    li x8, 0xcccc
    li x15, 0x100
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 9:  rs1:x14(0x200), result Branch=1
    li x9, 0xcccc
    li x14, 0x200
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res
    
     # Testcase 10:  rs1:x13(0x400), result Branch=1
    li x10, 0xcccc
    li x13, 0x400
    c.bnez x13, 1f
    li x10, 0x123ab
1: 
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 11:  rs1:x12(0x800), result Branch=1
    li x11, 0xcccc
    li x12, 0x800
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 12:  rs1:x11(0x1000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x12, 0xcccc
    li x11, 0x1000
    c.bnez x11, 2b
    li x12, 0x123ab
4:
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 13:  rs1:x10(0x2000), result Branch=1
    li x13, 0xcccc
    li x10, 0x2000
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 14:  rs1:x9(0x4000), result Branch=1
    li x14, 0xcccc
    li x9, 0x4000
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x1, test_4_res
    
     # Testcase 15:  rs1:x8(0x8000), result Branch=1
    li x15, 0xcccc
    li x8, 0x8000
    c.bnez x8, 1f
    li x15, 0x123ab
1: 
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 16:  rs1:x15(0x10000), result Branch=1
    li x8, 0xcccc
    li x15, 0x10000
    c.bnez x15, 2f
    li x8, 0x123ab
2: 
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 17:  rs1:x14(0x20000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x14, 0x20000
    c.bnez x14, 2b
    li x9, 0x123ab
4:
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 18:  rs1:x13(0x40000), result Branch=1
    li x10, 0xcccc
    li x13, 0x40000
    c.bnez x13, 4f
    li x10, 0x123ab
4: 
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 19:  rs1:x12(0x80000), result Branch=1
    li x11, 0xcccc
    li x12, 0x80000
    c.bnez x12, 5f
    li x11, 0x123ab
5: 
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res
    
     # Testcase 20:  rs1:x11(0x100000), result Branch=1
    li x12, 0xcccc
    li x11, 0x100000
    c.bnez x11, 1f
    li x12, 0x123ab
1: 
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 21:  rs1:x10(0x200000), result Branch=1
    li x13, 0xcccc
    li x10, 0x200000
    c.bnez x10, 2f
    li x13, 0x123ab
2: 
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 22:  rs1:x9(0x400000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x14, 0xcccc
    li x9, 0x400000
    c.bnez x9, 2b
    li x14, 0x123ab
4:
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 23:  rs1:x8(0x800000), result Branch=1
    li x15, 0xcccc
    li x8, 0x800000
    c.bnez x8, 4f
    li x15, 0x123ab
4: 
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 24:  rs1:x15(0x1000000), result Branch=1
    li x8, 0xcccc
    li x15, 0x1000000
    c.bnez x15, 5f
    li x8, 0x123ab
5: 
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res
    
     # Testcase 25:  rs1:x14(0x2000000), result Branch=1
    li x9, 0xcccc
    li x14, 0x2000000
    c.bnez x14, 1f
    li x9, 0x123ab
1: 
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 26:  rs1:x13(0x4000000), result Branch=1
    li x10, 0xcccc
    li x13, 0x4000000
    c.bnez x13, 2f
    li x10, 0x123ab
2: 
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 27:  rs1:x12(0x8000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x11, 0xcccc
    li x12, 0x8000000
    c.bnez x12, 2b
    li x11, 0x123ab
4:
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 28:  rs1:x11(0x10000000), result Branch=1
    li x12, 0xcccc
    li x11, 0x10000000
    c.bnez x11, 4f
    li x12, 0x123ab
4: 
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 29:  rs1:x10(0x20000000), result Branch=1
    li x13, 0xcccc
    li x10, 0x20000000
    c.bnez x10, 5f
    li x13, 0x123ab
5: 
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x1, test_7_res
    
     # Testcase 30:  rs1:x9(0x40000000), result Branch=1
    li x14, 0xcccc
    li x9, 0x40000000
    c.bnez x9, 1f
    li x14, 0x123ab
1: 
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 31:  rs1:x8(0x80000000), result Branch=1
    li x15, 0xcccc
    li x8, 0x80000000
    c.bnez x8, 2f
    li x15, 0x123ab
2: 
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 32:  rs1:x15(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x8, 0xcccc
    li x15, 0x0
    c.bnez x15, 2b
    li x8, 0x123ab
4:
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x123ab)

     # Testcase 33:  rs1:x14(0xfffffffe), result Branch=1
    li x9, 0xcccc
    li x14, 0xfffffffe
    c.bnez x14, 4f
    li x9, 0x123ab
4: 
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 34:  rs1:x13(0xfffffffd), result Branch=1
    li x10, 0xcccc
    li x13, 0xfffffffd
    c.bnez x13, 5f
    li x10, 0x123ab
5: 
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res
    
     # Testcase 35:  rs1:x12(0xfffffffb), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffffb
    c.bnez x12, 1f
    li x11, 0x123ab
1: 
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 36:  rs1:x11(0xfffffff7), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffff7
    c.bnez x11, 2f
    li x12, 0x123ab
2: 
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 37:  rs1:x10(0xffffffef), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x13, 0xcccc
    li x10, 0xffffffef
    c.bnez x10, 2b
    li x13, 0x123ab
4:
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 38:  rs1:x9(0xffffffdf), result Branch=1
    li x14, 0xcccc
    li x9, 0xffffffdf
    c.bnez x9, 4f
    li x14, 0x123ab
4: 
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 39:  rs1:x8(0xffffffbf), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffffbf
    c.bnez x8, 5f
    li x15, 0x123ab
5: 
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res
    
     # Testcase 40:  rs1:x15(0xffffff7f), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffff7f
    c.bnez x15, 1f
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 41:  rs1:x14(0xfffffeff), result Branch=1
    li x9, 0xcccc
    li x14, 0xfffffeff
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 42:  rs1:x13(0xfffffdff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x10, 0xcccc
    li x13, 0xfffffdff
    c.bnez x13, 2b
    li x10, 0x123ab
4:
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 43:  rs1:x12(0xfffffbff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffbff
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 44:  rs1:x11(0xfffff7ff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffff7ff
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x1, test_10_res
    
     # Testcase 45:  rs1:x10(0xffffefff), result Branch=1
    li x13, 0xcccc
    li x10, 0xffffefff
    c.bnez x10, 1f
    li x13, 0x123ab
1: 
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 46:  rs1:x9(0xffffdfff), result Branch=1
    li x14, 0xcccc
    li x9, 0xffffdfff
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 47:  rs1:x8(0xffffbfff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x15, 0xcccc
    li x8, 0xffffbfff
    c.bnez x8, 2b
    li x15, 0x123ab
4:
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 48:  rs1:x15(0xffff7fff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffff7fff
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 49:  rs1:x14(0xfffeffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xfffeffff
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res
    
     # Testcase 50:  rs1:x13(0xfffdffff), result Branch=1
    li x10, 0xcccc
    li x13, 0xfffdffff
    c.bnez x13, 1f
    li x10, 0x123ab
1: 
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 51:  rs1:x12(0xfffbffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffbffff
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 52:  rs1:x11(0xfff7ffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x12, 0xcccc
    li x11, 0xfff7ffff
    c.bnez x11, 2b
    li x12, 0x123ab
4:
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 53:  rs1:x10(0xffefffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xffefffff
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 54:  rs1:x9(0xffdfffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xffdfffff
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res
    
     # Testcase 55:  rs1:x8(0xffbfffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffbfffff
    c.bnez x8, 1f
    li x15, 0x123ab
1: 
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 56:  rs1:x15(0xff7fffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xff7fffff
    c.bnez x15, 2f
    li x8, 0x123ab
2: 
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 57:  rs1:x14(0xfeffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x14, 0xfeffffff
    c.bnez x14, 2b
    li x9, 0x123ab
4:
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 58:  rs1:x13(0xfdffffff), result Branch=1
    li x10, 0xcccc
    li x13, 0xfdffffff
    c.bnez x13, 4f
    li x10, 0x123ab
4: 
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 59:  rs1:x12(0xfbffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfbffffff
    c.bnez x12, 5f
    li x11, 0x123ab
5: 
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x1, test_13_res
    
     # Testcase 60:  rs1:x11(0xf7ffffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xf7ffffff
    c.bnez x11, 1f
    li x12, 0x123ab
1: 
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 61:  rs1:x10(0xefffffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xefffffff
    c.bnez x10, 2f
    li x13, 0x123ab
2: 
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 62:  rs1:x9(0xdfffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x14, 0xcccc
    li x9, 0xdfffffff
    c.bnez x9, 2b
    li x14, 0x123ab
4:
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 63:  rs1:x8(0xbfffffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xbfffffff
    c.bnez x8, 4f
    li x15, 0x123ab
4: 
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 64:  rs1:x15(0x7fffffff), result Branch=1
    li x8, 0xcccc
    li x15, 0x7fffffff
    c.bnez x15, 5f
    li x8, 0x123ab
5: 
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res
    
     # Testcase 65:  rs1:x14(0xffffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xffffffff
    c.bnez x14, 1f
    li x9, 0x123ab
1: 
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 66:  rs1:x13(0x1), result Branch=1
    li x10, 0xcccc
    li x13, 0x1
    c.bnez x13, 2f
    li x10, 0x123ab
2: 
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 67:  rs1:x12(0x2), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x11, 0xcccc
    li x12, 0x2
    c.bnez x12, 2b
    li x11, 0x123ab
4:
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 68:  rs1:x11(0x4), result Branch=1
    li x12, 0xcccc
    li x11, 0x4
    c.bnez x11, 4f
    li x12, 0x123ab
4: 
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 69:  rs1:x10(0x8), result Branch=1
    li x13, 0xcccc
    li x10, 0x8
    c.bnez x10, 5f
    li x13, 0x123ab
5: 
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res
    
     # Testcase 70:  rs1:x9(0x10), result Branch=1
    li x14, 0xcccc
    li x9, 0x10
    c.bnez x9, 1f
    li x14, 0x123ab
1: 
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 71:  rs1:x8(0x20), result Branch=1
    li x15, 0xcccc
    li x8, 0x20
    c.bnez x8, 2f
    li x15, 0x123ab
2: 
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 72:  rs1:x15(0x40), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x8, 0xcccc
    li x15, 0x40
    c.bnez x15, 2b
    li x8, 0x123ab
4:
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 73:  rs1:x14(0x80), result Branch=1
    li x9, 0xcccc
    li x14, 0x80
    c.bnez x14, 4f
    li x9, 0x123ab
4: 
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 74:  rs1:x13(0x100), result Branch=1
    li x10, 0xcccc
    li x13, 0x100
    c.bnez x13, 5f
    li x10, 0x123ab
5: 
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x1, test_16_res
    
     # Testcase 75:  rs1:x12(0x200), result Branch=1
    li x11, 0xcccc
    li x12, 0x200
    c.bnez x12, 1f
    li x11, 0x123ab
1: 
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 76:  rs1:x11(0x400), result Branch=1
    li x12, 0xcccc
    li x11, 0x400
    c.bnez x11, 2f
    li x12, 0x123ab
2: 
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 77:  rs1:x10(0x800), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x13, 0xcccc
    li x10, 0x800
    c.bnez x10, 2b
    li x13, 0x123ab
4:
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 78:  rs1:x9(0x1000), result Branch=1
    li x14, 0xcccc
    li x9, 0x1000
    c.bnez x9, 4f
    li x14, 0x123ab
4: 
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 79:  rs1:x8(0x2000), result Branch=1
    li x15, 0xcccc
    li x8, 0x2000
    c.bnez x8, 5f
    li x15, 0x123ab
5: 
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res
    
     # Testcase 80:  rs1:x15(0x4000), result Branch=1
    li x8, 0xcccc
    li x15, 0x4000
    c.bnez x15, 1f
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 81:  rs1:x14(0x8000), result Branch=1
    li x9, 0xcccc
    li x14, 0x8000
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 82:  rs1:x13(0x10000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x10, 0xcccc
    li x13, 0x10000
    c.bnez x13, 2b
    li x10, 0x123ab
4:
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 83:  rs1:x12(0x20000), result Branch=1
    li x11, 0xcccc
    li x12, 0x20000
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 84:  rs1:x11(0x40000), result Branch=1
    li x12, 0xcccc
    li x11, 0x40000
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res
    
     # Testcase 85:  rs1:x10(0x80000), result Branch=1
    li x13, 0xcccc
    li x10, 0x80000
    c.bnez x10, 1f
    li x13, 0x123ab
1: 
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 86:  rs1:x9(0x100000), result Branch=1
    li x14, 0xcccc
    li x9, 0x100000
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 87:  rs1:x8(0x200000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x15, 0xcccc
    li x8, 0x200000
    c.bnez x8, 2b
    li x15, 0x123ab
4:
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 88:  rs1:x15(0x400000), result Branch=1
    li x8, 0xcccc
    li x15, 0x400000
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 89:  rs1:x14(0x800000), result Branch=1
    li x9, 0xcccc
    li x14, 0x800000
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x1, test_19_res
    
     # Testcase 90:  rs1:x13(0x1000000), result Branch=1
    li x10, 0xcccc
    li x13, 0x1000000
    c.bnez x13, 1f
    li x10, 0x123ab
1: 
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 91:  rs1:x12(0x2000000), result Branch=1
    li x11, 0xcccc
    li x12, 0x2000000
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 92:  rs1:x11(0x4000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x12, 0xcccc
    li x11, 0x4000000
    c.bnez x11, 2b
    li x12, 0x123ab
4:
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 93:  rs1:x10(0x8000000), result Branch=1
    li x13, 0xcccc
    li x10, 0x8000000
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 94:  rs1:x9(0x10000000), result Branch=1
    li x14, 0xcccc
    li x9, 0x10000000
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res
    
     # Testcase 95:  rs1:x8(0x20000000), result Branch=1
    li x15, 0xcccc
    li x8, 0x20000000
    c.bnez x8, 1f
    li x15, 0x123ab
1: 
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 96:  rs1:x15(0x40000000), result Branch=1
    li x8, 0xcccc
    li x15, 0x40000000
    c.bnez x15, 2f
    li x8, 0x123ab
2: 
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 97:  rs1:x14(0x80000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x14, 0x80000000
    c.bnez x14, 2b
    li x9, 0x123ab
4:
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 98:  rs1:x13(0x0), result Branch=0
    li x10, 0xcccc
    li x13, 0x0
    c.bnez x13, 4f
    li x10, 0x123ab
4: 
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x123ab)

     # Testcase 99:  rs1:x12(0xfffffffe), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffffe
    c.bnez x12, 5f
    li x11, 0x123ab
5: 
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res
    
     # Testcase 100:  rs1:x11(0xfffffffd), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffffd
    c.bnez x11, 1f
    li x12, 0x123ab
1: 
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 101:  rs1:x10(0xfffffffb), result Branch=1
    li x13, 0xcccc
    li x10, 0xfffffffb
    c.bnez x10, 2f
    li x13, 0x123ab
2: 
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 102:  rs1:x9(0xfffffff7), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x14, 0xcccc
    li x9, 0xfffffff7
    c.bnez x9, 2b
    li x14, 0x123ab
4:
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 103:  rs1:x8(0xffffffef), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffffef
    c.bnez x8, 4f
    li x15, 0x123ab
4: 
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 104:  rs1:x15(0xffffffdf), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffffdf
    c.bnez x15, 5f
    li x8, 0x123ab
5: 
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x1, test_22_res
    
     # Testcase 105:  rs1:x14(0xffffffbf), result Branch=1
    li x9, 0xcccc
    li x14, 0xffffffbf
    c.bnez x14, 1f
    li x9, 0x123ab
1: 
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 106:  rs1:x13(0xffffff7f), result Branch=1
    li x10, 0xcccc
    li x13, 0xffffff7f
    c.bnez x13, 2f
    li x10, 0x123ab
2: 
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 107:  rs1:x12(0xfffffeff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x11, 0xcccc
    li x12, 0xfffffeff
    c.bnez x12, 2b
    li x11, 0x123ab
4:
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 108:  rs1:x11(0xfffffdff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffdff
    c.bnez x11, 4f
    li x12, 0x123ab
4: 
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 109:  rs1:x10(0xfffffbff), result Branch=1
    li x13, 0xcccc
    li x10, 0xfffffbff
    c.bnez x10, 5f
    li x13, 0x123ab
5: 
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res
    
     # Testcase 110:  rs1:x9(0xfffff7ff), result Branch=1
    li x14, 0xcccc
    li x9, 0xfffff7ff
    c.bnez x9, 1f
    li x14, 0x123ab
1: 
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 111:  rs1:x8(0xffffefff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffefff
    c.bnez x8, 2f
    li x15, 0x123ab
2: 
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 112:  rs1:x15(0xffffdfff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x8, 0xcccc
    li x15, 0xffffdfff
    c.bnez x15, 2b
    li x8, 0x123ab
4:
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 113:  rs1:x14(0xffffbfff), result Branch=1
    li x9, 0xcccc
    li x14, 0xffffbfff
    c.bnez x14, 4f
    li x9, 0x123ab
4: 
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 114:  rs1:x13(0xffff7fff), result Branch=1
    li x10, 0xcccc
    li x13, 0xffff7fff
    c.bnez x13, 5f
    li x10, 0x123ab
5: 
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res
    
     # Testcase 115:  rs1:x12(0xfffeffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffeffff
    c.bnez x12, 1f
    li x11, 0x123ab
1: 
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 116:  rs1:x11(0xfffdffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffdffff
    c.bnez x11, 2f
    li x12, 0x123ab
2: 
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 117:  rs1:x10(0xfffbffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x13, 0xcccc
    li x10, 0xfffbffff
    c.bnez x10, 2b
    li x13, 0x123ab
4:
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 118:  rs1:x9(0xfff7ffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xfff7ffff
    c.bnez x9, 4f
    li x14, 0x123ab
4: 
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 119:  rs1:x8(0xffefffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffefffff
    c.bnez x8, 5f
    li x15, 0x123ab
5: 
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x1, test_25_res
    
     # Testcase 120:  rs1:x15(0xffdfffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffdfffff
    c.bnez x15, 1f
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 121:  rs1:x14(0xffbfffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xffbfffff
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 122:  rs1:x13(0xff7fffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x10, 0xcccc
    li x13, 0xff7fffff
    c.bnez x13, 2b
    li x10, 0x123ab
4:
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 123:  rs1:x12(0xfeffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfeffffff
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 124:  rs1:x11(0xfdffffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfdffffff
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res
    
     # Testcase 125:  rs1:x10(0xfbffffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xfbffffff
    c.bnez x10, 1f
    li x13, 0x123ab
1: 
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 126:  rs1:x9(0xf7ffffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xf7ffffff
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 127:  rs1:x8(0xefffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x15, 0xcccc
    li x8, 0xefffffff
    c.bnez x8, 2b
    li x15, 0x123ab
4:
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 128:  rs1:x15(0xdfffffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xdfffffff
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 129:  rs1:x14(0xbfffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xbfffffff
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res
    
     # Testcase 130:  rs1:x13(0x7fffffff), result Branch=1
    li x10, 0xcccc
    li x13, 0x7fffffff
    c.bnez x13, 1f
    li x10, 0x123ab
1: 
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 131:  rs1:x12(0xffffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xffffffff
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 132:  rs1:x11(0x1), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x12, 0xcccc
    li x11, 0x1
    c.bnez x11, 2b
    li x12, 0x123ab
4:
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 133:  rs1:x10(0x2), result Branch=1
    li x13, 0xcccc
    li x10, 0x2
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 134:  rs1:x9(0x4), result Branch=1
    li x14, 0xcccc
    li x9, 0x4
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res
    
     # Testcase 135:  rs1:x8(0x8), result Branch=1
    li x15, 0xcccc
    li x8, 0x8
    c.bnez x8, 1f
    li x15, 0x123ab
1: 
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)



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

