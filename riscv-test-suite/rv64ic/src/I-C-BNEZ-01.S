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

RV_COMPLIANCE_RV64M

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
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 1:  rs1:x14(0x2), result Branch=1
    li x9, 0xcccc
    li x14, 0x2
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sd x9, 8(x1)
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
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 3:  rs1:x12(0x8), result Branch=1
    li x11, 0xcccc
    li x12, 0x8
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 4:  rs1:x11(0x10), result Branch=1
    li x12, 0xcccc
    li x11, 0x10
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sd x12, 32(x1)
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
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 6:  rs1:x9(0x40), result Branch=1
    li x14, 0xcccc
    li x9, 0x40
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sd x14, 8(x1)
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
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 8:  rs1:x15(0x100), result Branch=1
    li x8, 0xcccc
    li x15, 0x100
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 9:  rs1:x14(0x200), result Branch=1
    li x9, 0xcccc
    li x14, 0x200
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sd x9, 32(x1)
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
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 11:  rs1:x12(0x800), result Branch=1
    li x11, 0xcccc
    li x12, 0x800
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sd x11, 8(x1)
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
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 13:  rs1:x10(0x2000), result Branch=1
    li x13, 0xcccc
    li x10, 0x2000
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 14:  rs1:x9(0x4000), result Branch=1
    li x14, 0xcccc
    li x9, 0x4000
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sd x14, 32(x1)
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
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 16:  rs1:x15(0x10000), result Branch=1
    li x8, 0xcccc
    li x15, 0x10000
    c.bnez x15, 2f
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
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
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 18:  rs1:x13(0x40000), result Branch=1
    li x10, 0xcccc
    li x13, 0x40000
    c.bnez x13, 4f
    li x10, 0x123ab
4: 
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 19:  rs1:x12(0x80000), result Branch=1
    li x11, 0xcccc
    li x12, 0x80000
    c.bnez x12, 5f
    li x11, 0x123ab
5: 
    sd x11, 32(x1)
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
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 21:  rs1:x10(0x200000), result Branch=1
    li x13, 0xcccc
    li x10, 0x200000
    c.bnez x10, 2f
    li x13, 0x123ab
2: 
    sd x13, 8(x1)
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
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 23:  rs1:x8(0x800000), result Branch=1
    li x15, 0xcccc
    li x8, 0x800000
    c.bnez x8, 4f
    li x15, 0x123ab
4: 
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 24:  rs1:x15(0x1000000), result Branch=1
    li x8, 0xcccc
    li x15, 0x1000000
    c.bnez x15, 5f
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
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
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 26:  rs1:x13(0x4000000), result Branch=1
    li x10, 0xcccc
    li x13, 0x4000000
    c.bnez x13, 2f
    li x10, 0x123ab
2: 
    sd x10, 8(x1)
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
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 28:  rs1:x11(0x10000000), result Branch=1
    li x12, 0xcccc
    li x11, 0x10000000
    c.bnez x11, 4f
    li x12, 0x123ab
4: 
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 29:  rs1:x10(0x20000000), result Branch=1
    li x13, 0xcccc
    li x10, 0x20000000
    c.bnez x10, 5f
    li x13, 0x123ab
5: 
    sd x13, 32(x1)
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
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 31:  rs1:x8(0x80000000), result Branch=1
    li x15, 0xcccc
    li x8, 0x80000000
    c.bnez x8, 2f
    li x15, 0x123ab
2: 
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 32:  rs1:x15(0x100000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x8, 0xcccc
    li x15, 0x100000000
    c.bnez x15, 2b
    li x8, 0x123ab
4:
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 33:  rs1:x14(0x200000000), result Branch=1
    li x9, 0xcccc
    li x14, 0x200000000
    c.bnez x14, 4f
    li x9, 0x123ab
4: 
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 34:  rs1:x13(0x400000000), result Branch=1
    li x10, 0xcccc
    li x13, 0x400000000
    c.bnez x13, 5f
    li x10, 0x123ab
5: 
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res
    
     # Testcase 35:  rs1:x12(0x800000000), result Branch=1
    li x11, 0xcccc
    li x12, 0x800000000
    c.bnez x12, 1f
    li x11, 0x123ab
1: 
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 36:  rs1:x11(0x1000000000), result Branch=1
    li x12, 0xcccc
    li x11, 0x1000000000
    c.bnez x11, 2f
    li x12, 0x123ab
2: 
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 37:  rs1:x10(0x2000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x13, 0xcccc
    li x10, 0x2000000000
    c.bnez x10, 2b
    li x13, 0x123ab
4:
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 38:  rs1:x9(0x4000000000), result Branch=1
    li x14, 0xcccc
    li x9, 0x4000000000
    c.bnez x9, 4f
    li x14, 0x123ab
4: 
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 39:  rs1:x8(0x8000000000), result Branch=1
    li x15, 0xcccc
    li x8, 0x8000000000
    c.bnez x8, 5f
    li x15, 0x123ab
5: 
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res
    
     # Testcase 40:  rs1:x15(0x10000000000), result Branch=1
    li x8, 0xcccc
    li x15, 0x10000000000
    c.bnez x15, 1f
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 41:  rs1:x14(0x20000000000), result Branch=1
    li x9, 0xcccc
    li x14, 0x20000000000
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 42:  rs1:x13(0x40000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x10, 0xcccc
    li x13, 0x40000000000
    c.bnez x13, 2b
    li x10, 0x123ab
4:
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 43:  rs1:x12(0x80000000000), result Branch=1
    li x11, 0xcccc
    li x12, 0x80000000000
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 44:  rs1:x11(0x100000000000), result Branch=1
    li x12, 0xcccc
    li x11, 0x100000000000
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x1, test_10_res
    
     # Testcase 45:  rs1:x10(0x200000000000), result Branch=1
    li x13, 0xcccc
    li x10, 0x200000000000
    c.bnez x10, 1f
    li x13, 0x123ab
1: 
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 46:  rs1:x9(0x400000000000), result Branch=1
    li x14, 0xcccc
    li x9, 0x400000000000
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 47:  rs1:x8(0x800000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x15, 0xcccc
    li x8, 0x800000000000
    c.bnez x8, 2b
    li x15, 0x123ab
4:
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 48:  rs1:x15(0x1000000000000), result Branch=1
    li x8, 0xcccc
    li x15, 0x1000000000000
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 49:  rs1:x14(0x2000000000000), result Branch=1
    li x9, 0xcccc
    li x14, 0x2000000000000
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res
    
     # Testcase 50:  rs1:x13(0x4000000000000), result Branch=1
    li x10, 0xcccc
    li x13, 0x4000000000000
    c.bnez x13, 1f
    li x10, 0x123ab
1: 
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 51:  rs1:x12(0x8000000000000), result Branch=1
    li x11, 0xcccc
    li x12, 0x8000000000000
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 52:  rs1:x11(0x10000000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x12, 0xcccc
    li x11, 0x10000000000000
    c.bnez x11, 2b
    li x12, 0x123ab
4:
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 53:  rs1:x10(0x20000000000000), result Branch=1
    li x13, 0xcccc
    li x10, 0x20000000000000
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 54:  rs1:x9(0x40000000000000), result Branch=1
    li x14, 0xcccc
    li x9, 0x40000000000000
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res
    
     # Testcase 55:  rs1:x8(0x80000000000000), result Branch=1
    li x15, 0xcccc
    li x8, 0x80000000000000
    c.bnez x8, 1f
    li x15, 0x123ab
1: 
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 56:  rs1:x15(0x100000000000000), result Branch=1
    li x8, 0xcccc
    li x15, 0x100000000000000
    c.bnez x15, 2f
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 57:  rs1:x14(0x200000000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x14, 0x200000000000000
    c.bnez x14, 2b
    li x9, 0x123ab
4:
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 58:  rs1:x13(0x400000000000000), result Branch=1
    li x10, 0xcccc
    li x13, 0x400000000000000
    c.bnez x13, 4f
    li x10, 0x123ab
4: 
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 59:  rs1:x12(0x800000000000000), result Branch=1
    li x11, 0xcccc
    li x12, 0x800000000000000
    c.bnez x12, 5f
    li x11, 0x123ab
5: 
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x1, test_13_res
    
     # Testcase 60:  rs1:x11(0x1000000000000000), result Branch=1
    li x12, 0xcccc
    li x11, 0x1000000000000000
    c.bnez x11, 1f
    li x12, 0x123ab
1: 
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 61:  rs1:x10(0x2000000000000000), result Branch=1
    li x13, 0xcccc
    li x10, 0x2000000000000000
    c.bnez x10, 2f
    li x13, 0x123ab
2: 
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 62:  rs1:x9(0x4000000000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x14, 0xcccc
    li x9, 0x4000000000000000
    c.bnez x9, 2b
    li x14, 0x123ab
4:
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 63:  rs1:x8(0x8000000000000000), result Branch=1
    li x15, 0xcccc
    li x8, 0x8000000000000000
    c.bnez x8, 4f
    li x15, 0x123ab
4: 
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 64:  rs1:x15(0x0), result Branch=0
    li x8, 0xcccc
    li x15, 0x0
    c.bnez x15, 5f
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res
    
     # Testcase 65:  rs1:x14(0xfffffffffffffffe), result Branch=1
    li x9, 0xcccc
    li x14, 0xfffffffffffffffe
    c.bnez x14, 1f
    li x9, 0x123ab
1: 
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 66:  rs1:x13(0xfffffffffffffffd), result Branch=1
    li x10, 0xcccc
    li x13, 0xfffffffffffffffd
    c.bnez x13, 2f
    li x10, 0x123ab
2: 
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 67:  rs1:x12(0xfffffffffffffffb), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x11, 0xcccc
    li x12, 0xfffffffffffffffb
    c.bnez x12, 2b
    li x11, 0x123ab
4:
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 68:  rs1:x11(0xfffffffffffffff7), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffffffffffff7
    c.bnez x11, 4f
    li x12, 0x123ab
4: 
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 69:  rs1:x10(0xffffffffffffffef), result Branch=1
    li x13, 0xcccc
    li x10, 0xffffffffffffffef
    c.bnez x10, 5f
    li x13, 0x123ab
5: 
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res
    
     # Testcase 70:  rs1:x9(0xffffffffffffffdf), result Branch=1
    li x14, 0xcccc
    li x9, 0xffffffffffffffdf
    c.bnez x9, 1f
    li x14, 0x123ab
1: 
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 71:  rs1:x8(0xffffffffffffffbf), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffffffffffffbf
    c.bnez x8, 2f
    li x15, 0x123ab
2: 
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 72:  rs1:x15(0xffffffffffffff7f), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x8, 0xcccc
    li x15, 0xffffffffffffff7f
    c.bnez x15, 2b
    li x8, 0x123ab
4:
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 73:  rs1:x14(0xfffffffffffffeff), result Branch=1
    li x9, 0xcccc
    li x14, 0xfffffffffffffeff
    c.bnez x14, 4f
    li x9, 0x123ab
4: 
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 74:  rs1:x13(0xfffffffffffffdff), result Branch=1
    li x10, 0xcccc
    li x13, 0xfffffffffffffdff
    c.bnez x13, 5f
    li x10, 0x123ab
5: 
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x1, test_16_res
    
     # Testcase 75:  rs1:x12(0xfffffffffffffbff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffffffffffbff
    c.bnez x12, 1f
    li x11, 0x123ab
1: 
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 76:  rs1:x11(0xfffffffffffff7ff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffffffffff7ff
    c.bnez x11, 2f
    li x12, 0x123ab
2: 
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 77:  rs1:x10(0xffffffffffffefff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x13, 0xcccc
    li x10, 0xffffffffffffefff
    c.bnez x10, 2b
    li x13, 0x123ab
4:
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 78:  rs1:x9(0xffffffffffffdfff), result Branch=1
    li x14, 0xcccc
    li x9, 0xffffffffffffdfff
    c.bnez x9, 4f
    li x14, 0x123ab
4: 
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 79:  rs1:x8(0xffffffffffffbfff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffffffffffbfff
    c.bnez x8, 5f
    li x15, 0x123ab
5: 
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res
    
     # Testcase 80:  rs1:x15(0xffffffffffff7fff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffffffffff7fff
    c.bnez x15, 1f
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 81:  rs1:x14(0xfffffffffffeffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xfffffffffffeffff
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 82:  rs1:x13(0xfffffffffffdffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x10, 0xcccc
    li x13, 0xfffffffffffdffff
    c.bnez x13, 2b
    li x10, 0x123ab
4:
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 83:  rs1:x12(0xfffffffffffbffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffffffffbffff
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 84:  rs1:x11(0xfffffffffff7ffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffffffff7ffff
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res
    
     # Testcase 85:  rs1:x10(0xffffffffffefffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xffffffffffefffff
    c.bnez x10, 1f
    li x13, 0x123ab
1: 
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 86:  rs1:x9(0xffffffffffdfffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xffffffffffdfffff
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 87:  rs1:x8(0xffffffffffbfffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x15, 0xcccc
    li x8, 0xffffffffffbfffff
    c.bnez x8, 2b
    li x15, 0x123ab
4:
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 88:  rs1:x15(0xffffffffff7fffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffffffff7fffff
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 89:  rs1:x14(0xfffffffffeffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xfffffffffeffffff
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x1, test_19_res
    
     # Testcase 90:  rs1:x13(0xfffffffffdffffff), result Branch=1
    li x10, 0xcccc
    li x13, 0xfffffffffdffffff
    c.bnez x13, 1f
    li x10, 0x123ab
1: 
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 91:  rs1:x12(0xfffffffffbffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffffffbffffff
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 92:  rs1:x11(0xfffffffff7ffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x12, 0xcccc
    li x11, 0xfffffffff7ffffff
    c.bnez x11, 2b
    li x12, 0x123ab
4:
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 93:  rs1:x10(0xffffffffefffffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xffffffffefffffff
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 94:  rs1:x9(0xffffffffdfffffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xffffffffdfffffff
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res
    
     # Testcase 95:  rs1:x8(0xffffffffbfffffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffffffbfffffff
    c.bnez x8, 1f
    li x15, 0x123ab
1: 
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 96:  rs1:x15(0xffffffff7fffffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffffff7fffffff
    c.bnez x15, 2f
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 97:  rs1:x14(0xfffffffeffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x14, 0xfffffffeffffffff
    c.bnez x14, 2b
    li x9, 0x123ab
4:
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 98:  rs1:x13(0xfffffffdffffffff), result Branch=1
    li x10, 0xcccc
    li x13, 0xfffffffdffffffff
    c.bnez x13, 4f
    li x10, 0x123ab
4: 
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 99:  rs1:x12(0xfffffffbffffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffffbffffffff
    c.bnez x12, 5f
    li x11, 0x123ab
5: 
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res
    
     # Testcase 100:  rs1:x11(0xfffffff7ffffffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffff7ffffffff
    c.bnez x11, 1f
    li x12, 0x123ab
1: 
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 101:  rs1:x10(0xffffffefffffffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xffffffefffffffff
    c.bnez x10, 2f
    li x13, 0x123ab
2: 
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 102:  rs1:x9(0xffffffdfffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x14, 0xcccc
    li x9, 0xffffffdfffffffff
    c.bnez x9, 2b
    li x14, 0x123ab
4:
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 103:  rs1:x8(0xffffffbfffffffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffffbfffffffff
    c.bnez x8, 4f
    li x15, 0x123ab
4: 
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 104:  rs1:x15(0xffffff7fffffffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffff7fffffffff
    c.bnez x15, 5f
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x1, test_22_res
    
     # Testcase 105:  rs1:x14(0xfffffeffffffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xfffffeffffffffff
    c.bnez x14, 1f
    li x9, 0x123ab
1: 
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 106:  rs1:x13(0xfffffdffffffffff), result Branch=1
    li x10, 0xcccc
    li x13, 0xfffffdffffffffff
    c.bnez x13, 2f
    li x10, 0x123ab
2: 
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 107:  rs1:x12(0xfffffbffffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x11, 0xcccc
    li x12, 0xfffffbffffffffff
    c.bnez x12, 2b
    li x11, 0x123ab
4:
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 108:  rs1:x11(0xfffff7ffffffffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffff7ffffffffff
    c.bnez x11, 4f
    li x12, 0x123ab
4: 
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 109:  rs1:x10(0xffffefffffffffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xffffefffffffffff
    c.bnez x10, 5f
    li x13, 0x123ab
5: 
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res
    
     # Testcase 110:  rs1:x9(0xffffdfffffffffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xffffdfffffffffff
    c.bnez x9, 1f
    li x14, 0x123ab
1: 
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 111:  rs1:x8(0xffffbfffffffffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffbfffffffffff
    c.bnez x8, 2f
    li x15, 0x123ab
2: 
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 112:  rs1:x15(0xffff7fffffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x8, 0xcccc
    li x15, 0xffff7fffffffffff
    c.bnez x15, 2b
    li x8, 0x123ab
4:
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 113:  rs1:x14(0xfffeffffffffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xfffeffffffffffff
    c.bnez x14, 4f
    li x9, 0x123ab
4: 
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 114:  rs1:x13(0xfffdffffffffffff), result Branch=1
    li x10, 0xcccc
    li x13, 0xfffdffffffffffff
    c.bnez x13, 5f
    li x10, 0x123ab
5: 
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res
    
     # Testcase 115:  rs1:x12(0xfffbffffffffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffbffffffffffff
    c.bnez x12, 1f
    li x11, 0x123ab
1: 
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 116:  rs1:x11(0xfff7ffffffffffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfff7ffffffffffff
    c.bnez x11, 2f
    li x12, 0x123ab
2: 
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 117:  rs1:x10(0xffefffffffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x13, 0xcccc
    li x10, 0xffefffffffffffff
    c.bnez x10, 2b
    li x13, 0x123ab
4:
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 118:  rs1:x9(0xffdfffffffffffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xffdfffffffffffff
    c.bnez x9, 4f
    li x14, 0x123ab
4: 
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 119:  rs1:x8(0xffbfffffffffffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffbfffffffffffff
    c.bnez x8, 5f
    li x15, 0x123ab
5: 
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x1, test_25_res
    
     # Testcase 120:  rs1:x15(0xff7fffffffffffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xff7fffffffffffff
    c.bnez x15, 1f
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 121:  rs1:x14(0xfeffffffffffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xfeffffffffffffff
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 122:  rs1:x13(0xfdffffffffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x10, 0xcccc
    li x13, 0xfdffffffffffffff
    c.bnez x13, 2b
    li x10, 0x123ab
4:
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 123:  rs1:x12(0xfbffffffffffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfbffffffffffffff
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 124:  rs1:x11(0xf7ffffffffffffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xf7ffffffffffffff
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res
    
     # Testcase 125:  rs1:x10(0xefffffffffffffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xefffffffffffffff
    c.bnez x10, 1f
    li x13, 0x123ab
1: 
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 126:  rs1:x9(0xdfffffffffffffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xdfffffffffffffff
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 127:  rs1:x8(0xbfffffffffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x15, 0xcccc
    li x8, 0xbfffffffffffffff
    c.bnez x8, 2b
    li x15, 0x123ab
4:
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 128:  rs1:x15(0x7fffffffffffffff), result Branch=1
    li x8, 0xcccc
    li x15, 0x7fffffffffffffff
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 129:  rs1:x14(0xffffffffffffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xffffffffffffffff
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res
    
     # Testcase 130:  rs1:x13(0x1), result Branch=1
    li x10, 0xcccc
    li x13, 0x1
    c.bnez x13, 1f
    li x10, 0x123ab
1: 
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 131:  rs1:x12(0x2), result Branch=1
    li x11, 0xcccc
    li x12, 0x2
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 132:  rs1:x11(0x4), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x12, 0xcccc
    li x11, 0x4
    c.bnez x11, 2b
    li x12, 0x123ab
4:
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 133:  rs1:x10(0x8), result Branch=1
    li x13, 0xcccc
    li x10, 0x8
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 134:  rs1:x9(0x10), result Branch=1
    li x14, 0xcccc
    li x9, 0x10
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res
    
     # Testcase 135:  rs1:x8(0x20), result Branch=1
    li x15, 0xcccc
    li x8, 0x20
    c.bnez x8, 1f
    li x15, 0x123ab
1: 
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 136:  rs1:x15(0x40), result Branch=1
    li x8, 0xcccc
    li x15, 0x40
    c.bnez x15, 2f
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 137:  rs1:x14(0x80), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x14, 0x80
    c.bnez x14, 2b
    li x9, 0x123ab
4:
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 138:  rs1:x13(0x100), result Branch=1
    li x10, 0xcccc
    li x13, 0x100
    c.bnez x13, 4f
    li x10, 0x123ab
4: 
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 139:  rs1:x12(0x200), result Branch=1
    li x11, 0xcccc
    li x12, 0x200
    c.bnez x12, 5f
    li x11, 0x123ab
5: 
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res
    
     # Testcase 140:  rs1:x11(0x400), result Branch=1
    li x12, 0xcccc
    li x11, 0x400
    c.bnez x11, 1f
    li x12, 0x123ab
1: 
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 141:  rs1:x10(0x800), result Branch=1
    li x13, 0xcccc
    li x10, 0x800
    c.bnez x10, 2f
    li x13, 0x123ab
2: 
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 142:  rs1:x9(0x1000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x14, 0xcccc
    li x9, 0x1000
    c.bnez x9, 2b
    li x14, 0x123ab
4:
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 143:  rs1:x8(0x2000), result Branch=1
    li x15, 0xcccc
    li x8, 0x2000
    c.bnez x8, 4f
    li x15, 0x123ab
4: 
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 144:  rs1:x15(0x4000), result Branch=1
    li x8, 0xcccc
    li x15, 0x4000
    c.bnez x15, 5f
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res
    
     # Testcase 145:  rs1:x14(0x8000), result Branch=1
    li x9, 0xcccc
    li x14, 0x8000
    c.bnez x14, 1f
    li x9, 0x123ab
1: 
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 146:  rs1:x13(0x10000), result Branch=1
    li x10, 0xcccc
    li x13, 0x10000
    c.bnez x13, 2f
    li x10, 0x123ab
2: 
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 147:  rs1:x12(0x20000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x11, 0xcccc
    li x12, 0x20000
    c.bnez x12, 2b
    li x11, 0x123ab
4:
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 148:  rs1:x11(0x40000), result Branch=1
    li x12, 0xcccc
    li x11, 0x40000
    c.bnez x11, 4f
    li x12, 0x123ab
4: 
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 149:  rs1:x10(0x80000), result Branch=1
    li x13, 0xcccc
    li x10, 0x80000
    c.bnez x10, 5f
    li x13, 0x123ab
5: 
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x1, test_31_res
    
     # Testcase 150:  rs1:x9(0x100000), result Branch=1
    li x14, 0xcccc
    li x9, 0x100000
    c.bnez x9, 1f
    li x14, 0x123ab
1: 
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 151:  rs1:x8(0x200000), result Branch=1
    li x15, 0xcccc
    li x8, 0x200000
    c.bnez x8, 2f
    li x15, 0x123ab
2: 
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 152:  rs1:x15(0x400000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x8, 0xcccc
    li x15, 0x400000
    c.bnez x15, 2b
    li x8, 0x123ab
4:
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 153:  rs1:x14(0x800000), result Branch=1
    li x9, 0xcccc
    li x14, 0x800000
    c.bnez x14, 4f
    li x9, 0x123ab
4: 
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 154:  rs1:x13(0x1000000), result Branch=1
    li x10, 0xcccc
    li x13, 0x1000000
    c.bnez x13, 5f
    li x10, 0x123ab
5: 
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x1, test_32_res
    
     # Testcase 155:  rs1:x12(0x2000000), result Branch=1
    li x11, 0xcccc
    li x12, 0x2000000
    c.bnez x12, 1f
    li x11, 0x123ab
1: 
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 156:  rs1:x11(0x4000000), result Branch=1
    li x12, 0xcccc
    li x11, 0x4000000
    c.bnez x11, 2f
    li x12, 0x123ab
2: 
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 157:  rs1:x10(0x8000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x13, 0xcccc
    li x10, 0x8000000
    c.bnez x10, 2b
    li x13, 0x123ab
4:
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 158:  rs1:x9(0x10000000), result Branch=1
    li x14, 0xcccc
    li x9, 0x10000000
    c.bnez x9, 4f
    li x14, 0x123ab
4: 
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 159:  rs1:x8(0x20000000), result Branch=1
    li x15, 0xcccc
    li x8, 0x20000000
    c.bnez x8, 5f
    li x15, 0x123ab
5: 
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res
    
     # Testcase 160:  rs1:x15(0x40000000), result Branch=1
    li x8, 0xcccc
    li x15, 0x40000000
    c.bnez x15, 1f
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 161:  rs1:x14(0x80000000), result Branch=1
    li x9, 0xcccc
    li x14, 0x80000000
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 162:  rs1:x13(0x100000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x10, 0xcccc
    li x13, 0x100000000
    c.bnez x13, 2b
    li x10, 0x123ab
4:
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 163:  rs1:x12(0x200000000), result Branch=1
    li x11, 0xcccc
    li x12, 0x200000000
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 164:  rs1:x11(0x400000000), result Branch=1
    li x12, 0xcccc
    li x11, 0x400000000
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res
    
     # Testcase 165:  rs1:x10(0x800000000), result Branch=1
    li x13, 0xcccc
    li x10, 0x800000000
    c.bnez x10, 1f
    li x13, 0x123ab
1: 
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 166:  rs1:x9(0x1000000000), result Branch=1
    li x14, 0xcccc
    li x9, 0x1000000000
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 167:  rs1:x8(0x2000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x15, 0xcccc
    li x8, 0x2000000000
    c.bnez x8, 2b
    li x15, 0x123ab
4:
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 168:  rs1:x15(0x4000000000), result Branch=1
    li x8, 0xcccc
    li x15, 0x4000000000
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 169:  rs1:x14(0x8000000000), result Branch=1
    li x9, 0xcccc
    li x14, 0x8000000000
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x1, test_35_res
    
     # Testcase 170:  rs1:x13(0x10000000000), result Branch=1
    li x10, 0xcccc
    li x13, 0x10000000000
    c.bnez x13, 1f
    li x10, 0x123ab
1: 
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 171:  rs1:x12(0x20000000000), result Branch=1
    li x11, 0xcccc
    li x12, 0x20000000000
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 172:  rs1:x11(0x40000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x12, 0xcccc
    li x11, 0x40000000000
    c.bnez x11, 2b
    li x12, 0x123ab
4:
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 173:  rs1:x10(0x80000000000), result Branch=1
    li x13, 0xcccc
    li x10, 0x80000000000
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 174:  rs1:x9(0x100000000000), result Branch=1
    li x14, 0xcccc
    li x9, 0x100000000000
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res
    
     # Testcase 175:  rs1:x8(0x200000000000), result Branch=1
    li x15, 0xcccc
    li x8, 0x200000000000
    c.bnez x8, 1f
    li x15, 0x123ab
1: 
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 176:  rs1:x15(0x400000000000), result Branch=1
    li x8, 0xcccc
    li x15, 0x400000000000
    c.bnez x15, 2f
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 177:  rs1:x14(0x800000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x14, 0x800000000000
    c.bnez x14, 2b
    li x9, 0x123ab
4:
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 178:  rs1:x13(0x1000000000000), result Branch=1
    li x10, 0xcccc
    li x13, 0x1000000000000
    c.bnez x13, 4f
    li x10, 0x123ab
4: 
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 179:  rs1:x12(0x2000000000000), result Branch=1
    li x11, 0xcccc
    li x12, 0x2000000000000
    c.bnez x12, 5f
    li x11, 0x123ab
5: 
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res
    
     # Testcase 180:  rs1:x11(0x4000000000000), result Branch=1
    li x12, 0xcccc
    li x11, 0x4000000000000
    c.bnez x11, 1f
    li x12, 0x123ab
1: 
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 181:  rs1:x10(0x8000000000000), result Branch=1
    li x13, 0xcccc
    li x10, 0x8000000000000
    c.bnez x10, 2f
    li x13, 0x123ab
2: 
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 182:  rs1:x9(0x10000000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x14, 0xcccc
    li x9, 0x10000000000000
    c.bnez x9, 2b
    li x14, 0x123ab
4:
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 183:  rs1:x8(0x20000000000000), result Branch=1
    li x15, 0xcccc
    li x8, 0x20000000000000
    c.bnez x8, 4f
    li x15, 0x123ab
4: 
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 184:  rs1:x15(0x40000000000000), result Branch=1
    li x8, 0xcccc
    li x15, 0x40000000000000
    c.bnez x15, 5f
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x1, test_38_res
    
     # Testcase 185:  rs1:x14(0x80000000000000), result Branch=1
    li x9, 0xcccc
    li x14, 0x80000000000000
    c.bnez x14, 1f
    li x9, 0x123ab
1: 
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 186:  rs1:x13(0x100000000000000), result Branch=1
    li x10, 0xcccc
    li x13, 0x100000000000000
    c.bnez x13, 2f
    li x10, 0x123ab
2: 
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 187:  rs1:x12(0x200000000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x11, 0xcccc
    li x12, 0x200000000000000
    c.bnez x12, 2b
    li x11, 0x123ab
4:
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 188:  rs1:x11(0x400000000000000), result Branch=1
    li x12, 0xcccc
    li x11, 0x400000000000000
    c.bnez x11, 4f
    li x12, 0x123ab
4: 
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 189:  rs1:x10(0x800000000000000), result Branch=1
    li x13, 0xcccc
    li x10, 0x800000000000000
    c.bnez x10, 5f
    li x13, 0x123ab
5: 
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res
    
     # Testcase 190:  rs1:x9(0x1000000000000000), result Branch=1
    li x14, 0xcccc
    li x9, 0x1000000000000000
    c.bnez x9, 1f
    li x14, 0x123ab
1: 
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 191:  rs1:x8(0x2000000000000000), result Branch=1
    li x15, 0xcccc
    li x8, 0x2000000000000000
    c.bnez x8, 2f
    li x15, 0x123ab
2: 
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 192:  rs1:x15(0x4000000000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x8, 0xcccc
    li x15, 0x4000000000000000
    c.bnez x15, 2b
    li x8, 0x123ab
4:
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 193:  rs1:x14(0x8000000000000000), result Branch=1
    li x9, 0xcccc
    li x14, 0x8000000000000000
    c.bnez x14, 4f
    li x9, 0x123ab
4: 
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 194:  rs1:x13(0x0), result Branch=0
    li x10, 0xcccc
    li x13, 0x0
    c.bnez x13, 5f
    li x10, 0x123ab
5: 
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res
    
     # Testcase 195:  rs1:x12(0xfffffffffffffffe), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffffffffffffe
    c.bnez x12, 1f
    li x11, 0x123ab
1: 
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 196:  rs1:x11(0xfffffffffffffffd), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffffffffffffd
    c.bnez x11, 2f
    li x12, 0x123ab
2: 
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 197:  rs1:x10(0xfffffffffffffffb), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x13, 0xcccc
    li x10, 0xfffffffffffffffb
    c.bnez x10, 2b
    li x13, 0x123ab
4:
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 198:  rs1:x9(0xfffffffffffffff7), result Branch=1
    li x14, 0xcccc
    li x9, 0xfffffffffffffff7
    c.bnez x9, 4f
    li x14, 0x123ab
4: 
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 199:  rs1:x8(0xffffffffffffffef), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffffffffffffef
    c.bnez x8, 5f
    li x15, 0x123ab
5: 
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x1, test_41_res
    
     # Testcase 200:  rs1:x15(0xffffffffffffffdf), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffffffffffffdf
    c.bnez x15, 1f
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 201:  rs1:x14(0xffffffffffffffbf), result Branch=1
    li x9, 0xcccc
    li x14, 0xffffffffffffffbf
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 202:  rs1:x13(0xffffffffffffff7f), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x10, 0xcccc
    li x13, 0xffffffffffffff7f
    c.bnez x13, 2b
    li x10, 0x123ab
4:
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 203:  rs1:x12(0xfffffffffffffeff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffffffffffeff
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 204:  rs1:x11(0xfffffffffffffdff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffffffffffdff
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res
    
     # Testcase 205:  rs1:x10(0xfffffffffffffbff), result Branch=1
    li x13, 0xcccc
    li x10, 0xfffffffffffffbff
    c.bnez x10, 1f
    li x13, 0x123ab
1: 
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 206:  rs1:x9(0xfffffffffffff7ff), result Branch=1
    li x14, 0xcccc
    li x9, 0xfffffffffffff7ff
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 207:  rs1:x8(0xffffffffffffefff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x15, 0xcccc
    li x8, 0xffffffffffffefff
    c.bnez x8, 2b
    li x15, 0x123ab
4:
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 208:  rs1:x15(0xffffffffffffdfff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffffffffffdfff
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 209:  rs1:x14(0xffffffffffffbfff), result Branch=1
    li x9, 0xcccc
    li x14, 0xffffffffffffbfff
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res
    
     # Testcase 210:  rs1:x13(0xffffffffffff7fff), result Branch=1
    li x10, 0xcccc
    li x13, 0xffffffffffff7fff
    c.bnez x13, 1f
    li x10, 0x123ab
1: 
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 211:  rs1:x12(0xfffffffffffeffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffffffffeffff
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 212:  rs1:x11(0xfffffffffffdffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x12, 0xcccc
    li x11, 0xfffffffffffdffff
    c.bnez x11, 2b
    li x12, 0x123ab
4:
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 213:  rs1:x10(0xfffffffffffbffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xfffffffffffbffff
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 214:  rs1:x9(0xfffffffffff7ffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xfffffffffff7ffff
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x1, test_44_res
    
     # Testcase 215:  rs1:x8(0xffffffffffefffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffffffffefffff
    c.bnez x8, 1f
    li x15, 0x123ab
1: 
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 216:  rs1:x15(0xffffffffffdfffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffffffffdfffff
    c.bnez x15, 2f
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 217:  rs1:x14(0xffffffffffbfffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x14, 0xffffffffffbfffff
    c.bnez x14, 2b
    li x9, 0x123ab
4:
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 218:  rs1:x13(0xffffffffff7fffff), result Branch=1
    li x10, 0xcccc
    li x13, 0xffffffffff7fffff
    c.bnez x13, 4f
    li x10, 0x123ab
4: 
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 219:  rs1:x12(0xfffffffffeffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffffffeffffff
    c.bnez x12, 5f
    li x11, 0x123ab
5: 
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res
    
     # Testcase 220:  rs1:x11(0xfffffffffdffffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffffffdffffff
    c.bnez x11, 1f
    li x12, 0x123ab
1: 
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 221:  rs1:x10(0xfffffffffbffffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xfffffffffbffffff
    c.bnez x10, 2f
    li x13, 0x123ab
2: 
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 222:  rs1:x9(0xfffffffff7ffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x14, 0xcccc
    li x9, 0xfffffffff7ffffff
    c.bnez x9, 2b
    li x14, 0x123ab
4:
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 223:  rs1:x8(0xffffffffefffffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffffffefffffff
    c.bnez x8, 4f
    li x15, 0x123ab
4: 
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 224:  rs1:x15(0xffffffffdfffffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffffffdfffffff
    c.bnez x15, 5f
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res
    
     # Testcase 225:  rs1:x14(0xffffffffbfffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xffffffffbfffffff
    c.bnez x14, 1f
    li x9, 0x123ab
1: 
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 226:  rs1:x13(0xffffffff7fffffff), result Branch=1
    li x10, 0xcccc
    li x13, 0xffffffff7fffffff
    c.bnez x13, 2f
    li x10, 0x123ab
2: 
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 227:  rs1:x12(0xfffffffeffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x11, 0xcccc
    li x12, 0xfffffffeffffffff
    c.bnez x12, 2b
    li x11, 0x123ab
4:
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 228:  rs1:x11(0xfffffffdffffffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffffdffffffff
    c.bnez x11, 4f
    li x12, 0x123ab
4: 
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 229:  rs1:x10(0xfffffffbffffffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xfffffffbffffffff
    c.bnez x10, 5f
    li x13, 0x123ab
5: 
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x1, test_47_res
    
     # Testcase 230:  rs1:x9(0xfffffff7ffffffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xfffffff7ffffffff
    c.bnez x9, 1f
    li x14, 0x123ab
1: 
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 231:  rs1:x8(0xffffffefffffffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffffefffffffff
    c.bnez x8, 2f
    li x15, 0x123ab
2: 
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 232:  rs1:x15(0xffffffdfffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x8, 0xcccc
    li x15, 0xffffffdfffffffff
    c.bnez x15, 2b
    li x8, 0x123ab
4:
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 233:  rs1:x14(0xffffffbfffffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xffffffbfffffffff
    c.bnez x14, 4f
    li x9, 0x123ab
4: 
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 234:  rs1:x13(0xffffff7fffffffff), result Branch=1
    li x10, 0xcccc
    li x13, 0xffffff7fffffffff
    c.bnez x13, 5f
    li x10, 0x123ab
5: 
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res
    
     # Testcase 235:  rs1:x12(0xfffffeffffffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffffeffffffffff
    c.bnez x12, 1f
    li x11, 0x123ab
1: 
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 236:  rs1:x11(0xfffffdffffffffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffffdffffffffff
    c.bnez x11, 2f
    li x12, 0x123ab
2: 
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 237:  rs1:x10(0xfffffbffffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x13, 0xcccc
    li x10, 0xfffffbffffffffff
    c.bnez x10, 2b
    li x13, 0x123ab
4:
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 238:  rs1:x9(0xfffff7ffffffffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xfffff7ffffffffff
    c.bnez x9, 4f
    li x14, 0x123ab
4: 
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 239:  rs1:x8(0xffffefffffffffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xffffefffffffffff
    c.bnez x8, 5f
    li x15, 0x123ab
5: 
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res
    
     # Testcase 240:  rs1:x15(0xffffdfffffffffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffffdfffffffffff
    c.bnez x15, 1f
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 241:  rs1:x14(0xffffbfffffffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xffffbfffffffffff
    c.bnez x14, 2f
    li x9, 0x123ab
2: 
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 242:  rs1:x13(0xffff7fffffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x10, 0xcccc
    li x13, 0xffff7fffffffffff
    c.bnez x13, 2b
    li x10, 0x123ab
4:
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 243:  rs1:x12(0xfffeffffffffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfffeffffffffffff
    c.bnez x12, 4f
    li x11, 0x123ab
4: 
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 244:  rs1:x11(0xfffdffffffffffff), result Branch=1
    li x12, 0xcccc
    li x11, 0xfffdffffffffffff
    c.bnez x11, 5f
    li x12, 0x123ab
5: 
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x1, test_50_res
    
     # Testcase 245:  rs1:x10(0xfffbffffffffffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xfffbffffffffffff
    c.bnez x10, 1f
    li x13, 0x123ab
1: 
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 246:  rs1:x9(0xfff7ffffffffffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xfff7ffffffffffff
    c.bnez x9, 2f
    li x14, 0x123ab
2: 
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 247:  rs1:x8(0xffefffffffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x15, 0xcccc
    li x8, 0xffefffffffffffff
    c.bnez x8, 2b
    li x15, 0x123ab
4:
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 248:  rs1:x15(0xffdfffffffffffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xffdfffffffffffff
    c.bnez x15, 4f
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 249:  rs1:x14(0xffbfffffffffffff), result Branch=1
    li x9, 0xcccc
    li x14, 0xffbfffffffffffff
    c.bnez x14, 5f
    li x9, 0x123ab
5: 
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res
    
     # Testcase 250:  rs1:x13(0xff7fffffffffffff), result Branch=1
    li x10, 0xcccc
    li x13, 0xff7fffffffffffff
    c.bnez x13, 1f
    li x10, 0x123ab
1: 
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 251:  rs1:x12(0xfeffffffffffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xfeffffffffffffff
    c.bnez x12, 2f
    li x11, 0x123ab
2: 
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)

     # Testcase 252:  rs1:x11(0xfdffffffffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x12, 0xcccc
    li x11, 0xfdffffffffffffff
    c.bnez x11, 2b
    li x12, 0x123ab
4:
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 253:  rs1:x10(0xfbffffffffffffff), result Branch=1
    li x13, 0xcccc
    li x10, 0xfbffffffffffffff
    c.bnez x10, 4f
    li x13, 0x123ab
4: 
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 254:  rs1:x9(0xf7ffffffffffffff), result Branch=1
    li x14, 0xcccc
    li x9, 0xf7ffffffffffffff
    c.bnez x9, 5f
    li x14, 0x123ab
5: 
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res
    
     # Testcase 255:  rs1:x8(0xefffffffffffffff), result Branch=1
    li x15, 0xcccc
    li x8, 0xefffffffffffffff
    c.bnez x8, 1f
    li x15, 0x123ab
1: 
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x15, 0xcccc)

     # Testcase 256:  rs1:x15(0xdfffffffffffffff), result Branch=1
    li x8, 0xcccc
    li x15, 0xdfffffffffffffff
    c.bnez x15, 2f
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 257:  rs1:x14(0xbfffffffffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x14, 0xbfffffffffffffff
    c.bnez x14, 2b
    li x9, 0x123ab
4:
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xcccc)

     # Testcase 258:  rs1:x13(0x7fffffffffffffff), result Branch=1
    li x10, 0xcccc
    li x13, 0x7fffffffffffffff
    c.bnez x13, 4f
    li x10, 0x123ab
4: 
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xcccc)

     # Testcase 259:  rs1:x12(0xffffffffffffffff), result Branch=1
    li x11, 0xcccc
    li x12, 0xffffffffffffffff
    c.bnez x12, 5f
    li x11, 0x123ab
5: 
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x1, test_53_res
    
     # Testcase 260:  rs1:x11(0x1), result Branch=1
    li x12, 0xcccc
    li x11, 0x1
    c.bnez x11, 1f
    li x12, 0x123ab
1: 
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xcccc)

     # Testcase 261:  rs1:x10(0x2), result Branch=1
    li x13, 0xcccc
    li x10, 0x2
    c.bnez x10, 2f
    li x13, 0x123ab
2: 
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xcccc)

     # Testcase 262:  rs1:x9(0x4), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x14, 0xcccc
    li x9, 0x4
    c.bnez x9, 2b
    li x14, 0x123ab
4:
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xcccc)

     # Testcase 263:  rs1:x8(0x8), result Branch=1
    li x15, 0xcccc
    li x8, 0x8
    c.bnez x8, 4f
    li x15, 0x123ab
4: 
    sd x15, 24(x1)
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

