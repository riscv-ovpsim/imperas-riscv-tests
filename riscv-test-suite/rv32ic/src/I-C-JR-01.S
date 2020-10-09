# RISC-V Compliance Test I-C-JR-01
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
# Description: Testing instruction 'c.jr'.

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
 
    
 

 
    # Testcase 0:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x31, 1f 
    c.jr x31
    li x8, 0x123ab
1: 
    sw x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



 
    # Testcase 1:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x30, 2f 
    c.jr x30
    li x8, 0x123ab
2: 
    sw x8, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 2:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x29, 2b
    c.jr x29
    li x8, 0x123ab
4: 
    sw x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  



 
    # Testcase 3:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x28, 4f 
    c.jr x28
    li x8, 0x123ab
4: 
    sw x8, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



 
    # Testcase 4:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x27, 5f 
    c.jr x27
    li x8, 0x123ab
5: 
    sw x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x3, test_2_res
 
    
 

 
    # Testcase 5:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x26, 1f 
    c.jr x26
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 6:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x25, 2f 
    c.jr x25
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 7:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x24, 2b
    c.jr x24
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



 
    # Testcase 8:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x23, 4f 
    c.jr x23
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 9:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x22, 5f 
    c.jr x22
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x7, test_3_res
 
    
 

 
    # Testcase 10:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x21, 1f 
    c.jr x21
    li x9, 0x123ab
1: 
    sw x9, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



 
    # Testcase 11:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x20, 2f 
    c.jr x20
    li x9, 0x123ab
2: 
    sw x9, 4(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 12:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x19, 2b
    c.jr x19
    li x9, 0x123ab
4: 
    sw x9, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc)  



 
    # Testcase 13:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x18, 4f 
    c.jr x18
    li x9, 0x123ab
4: 
    sw x9, 12(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



 
    # Testcase 14:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x17, 5f 
    c.jr x17
    li x9, 0x123ab
5: 
    sw x9, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x3, test_4_res
 
    
 

 
    # Testcase 15:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x16, 1f 
    c.jr x16
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 16:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x15, 2f 
    c.jr x15
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 17:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x14, 2b
    c.jr x14
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



 
    # Testcase 18:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x13, 4f 
    c.jr x13
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 19:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x12, 5f 
    c.jr x12
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x3, test_5_res
 
    
 

 
    # Testcase 20:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x11, 1f 
    c.jr x11
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 21:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x10, 2f 
    c.jr x10
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 22:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x9, 2b
    c.jr x9
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



 
    # Testcase 23:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x8, 4f 
    c.jr x8
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 24:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x7, 5f 
    c.jr x7
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x7, test_6_res
 
    
 

 
    # Testcase 25:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x6, 1f 
    c.jr x6
    li x9, 0x123ab
1: 
    sw x9, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



 
    # Testcase 26:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x5, 2f 
    c.jr x5
    li x9, 0x123ab
2: 
    sw x9, 4(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 27:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x4, 2b
    c.jr x4
    li x9, 0x123ab
4: 
    sw x9, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc)  



 
    # Testcase 28:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x3, 4f 
    c.jr x3
    li x9, 0x123ab
4: 
    sw x9, 12(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



 
    # Testcase 29:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x2, 5f 
    c.jr x2
    li x9, 0x123ab
5: 
    sw x9, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res
 
    
 

 
    # Testcase 30:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x1, 1f 
    c.jr x1
    li x7, 0x123ab
1: 
    sw x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



 
    # Testcase 31:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x31, 2f 
    c.jr x31
    li x7, 0x123ab
2: 
    sw x7, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 32:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x30, 2b
    c.jr x30
    li x7, 0x123ab
4: 
    sw x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  



 
    # Testcase 33:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x29, 4f 
    c.jr x29
    li x7, 0x123ab
4: 
    sw x7, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



 
    # Testcase 34:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x28, 5f 
    c.jr x28
    li x7, 0x123ab
5: 
    sw x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x3, test_8_res
 
    
 

 
    # Testcase 35:  result rd:x13(0xcccc)
    li x13, 0xcccc
    la x27, 1f 
    c.jr x27
    li x13, 0x123ab
1: 
    sw x13, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x13, 0xcccc) 



 
    # Testcase 36:  result rd:x13(0xcccc)
    li x13, 0xcccc
    la x26, 2f 
    c.jr x26
    li x13, 0x123ab
2: 
    sw x13, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x13, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 37:  result rd:x13(0xcccc)
    li x13, 0xcccc
    la x25, 2b
    c.jr x25
    li x13, 0x123ab
4: 
    sw x13, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x13, 0xcccc)  



 
    # Testcase 38:  result rd:x13(0xcccc)
    li x13, 0xcccc
    la x24, 4f 
    c.jr x24
    li x13, 0x123ab
4: 
    sw x13, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x13, 0xcccc) 



 
    # Testcase 39:  result rd:x13(0xcccc)
    li x13, 0xcccc
    la x23, 5f 
    c.jr x23
    li x13, 0x123ab
5: 
    sw x13, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x13, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x8, test_9_res
 
    
 

 
    # Testcase 40:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x22, 1f 
    c.jr x22
    li x15, 0x123ab
1: 
    sw x15, 0(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xcccc) 



 
    # Testcase 41:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x21, 2f 
    c.jr x21
    li x15, 0x123ab
2: 
    sw x15, 4(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 42:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x20, 2b
    c.jr x20
    li x15, 0x123ab
4: 
    sw x15, 8(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xcccc)  



 
    # Testcase 43:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x19, 4f 
    c.jr x19
    li x15, 0x123ab
4: 
    sw x15, 12(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xcccc) 



 
    # Testcase 44:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x18, 5f 
    c.jr x18
    li x15, 0x123ab
5: 
    sw x15, 16(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res
 
    
 

 
    # Testcase 45:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x17, 1f 
    c.jr x17
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 46:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x16, 2f 
    c.jr x16
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 47:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x15, 2b
    c.jr x15
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



 
    # Testcase 48:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x14, 4f 
    c.jr x14
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 49:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x13, 5f 
    c.jr x13
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x3, test_11_res
 
    
 

 
    # Testcase 50:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x12, 1f 
    c.jr x12
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 51:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x11, 2f 
    c.jr x11
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 52:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x10, 2b
    c.jr x10
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



 
    # Testcase 53:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x9, 4f 
    c.jr x9
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 54:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x8, 5f 
    c.jr x8
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x8, test_12_res
 
    
 

 
    # Testcase 55:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x7, 1f 
    c.jr x7
    li x10, 0x123ab
1: 
    sw x10, 0(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xcccc) 



 
    # Testcase 56:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x6, 2f 
    c.jr x6
    li x10, 0x123ab
2: 
    sw x10, 4(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 57:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x5, 2b
    c.jr x5
    li x10, 0x123ab
4: 
    sw x10, 8(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xcccc)  



 
    # Testcase 58:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x4, 4f 
    c.jr x4
    li x10, 0x123ab
4: 
    sw x10, 12(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xcccc) 



 
    # Testcase 59:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x3, 5f 
    c.jr x3
    li x10, 0x123ab
5: 
    sw x10, 16(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res
 
    
 

 
    # Testcase 60:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x2, 1f 
    c.jr x2
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



 
    # Testcase 61:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x1, 2f 
    c.jr x1
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 62:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x31, 2b
    c.jr x31
    li x6, 0x123ab
4: 
    sw x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



 
    # Testcase 63:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x30, 4f 
    c.jr x30
    li x6, 0x123ab
4: 
    sw x6, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



 
    # Testcase 64:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x29, 5f 
    c.jr x29
    li x6, 0x123ab
5: 
    sw x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x3, test_14_res
 
    
 

 
    # Testcase 65:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x28, 1f 
    c.jr x28
    li x15, 0x123ab
1: 
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x15, 0xcccc) 



 
    # Testcase 66:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x27, 2f 
    c.jr x27
    li x15, 0x123ab
2: 
    sw x15, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x15, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 67:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x26, 2b
    c.jr x26
    li x15, 0x123ab
4: 
    sw x15, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x15, 0xcccc)  



 
    # Testcase 68:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x25, 4f 
    c.jr x25
    li x15, 0x123ab
4: 
    sw x15, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x15, 0xcccc) 



 
    # Testcase 69:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x24, 5f 
    c.jr x24
    li x15, 0x123ab
5: 
    sw x15, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x15, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x3, test_15_res
 
    
 

 
    # Testcase 70:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x23, 1f 
    c.jr x23
    li x15, 0x123ab
1: 
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x15, 0xcccc) 



 
    # Testcase 71:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x22, 2f 
    c.jr x22
    li x15, 0x123ab
2: 
    sw x15, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x15, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 72:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x21, 2b
    c.jr x21
    li x15, 0x123ab
4: 
    sw x15, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x15, 0xcccc)  



 
    # Testcase 73:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x20, 4f 
    c.jr x20
    li x15, 0x123ab
4: 
    sw x15, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x15, 0xcccc) 



 
    # Testcase 74:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x19, 5f 
    c.jr x19
    li x15, 0x123ab
5: 
    sw x15, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x15, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res
 
    
 

 
    # Testcase 75:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 1f 
    c.jr x18
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



 
    # Testcase 76:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x17, 2f 
    c.jr x17
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 77:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x16, 2b
    c.jr x16
    li x6, 0x123ab
4: 
    sw x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



 
    # Testcase 78:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x15, 4f 
    c.jr x15
    li x6, 0x123ab
4: 
    sw x6, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



 
    # Testcase 79:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x14, 5f 
    c.jr x14
    li x6, 0x123ab
5: 
    sw x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x3, test_17_res
 
    
 

 
    # Testcase 80:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x13, 1f 
    c.jr x13
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 81:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x12, 2f 
    c.jr x12
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 82:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x11, 2b
    c.jr x11
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



 
    # Testcase 83:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x10, 4f 
    c.jr x10
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 84:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x9, 5f 
    c.jr x9
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x3, test_18_res
 
    
 

 
    # Testcase 85:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x8, 1f 
    c.jr x8
    li x10, 0x123ab
1: 
    sw x10, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xcccc) 



 
    # Testcase 86:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x7, 2f 
    c.jr x7
    li x10, 0x123ab
2: 
    sw x10, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 87:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x6, 2b
    c.jr x6
    li x10, 0x123ab
4: 
    sw x10, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xcccc)  



 
    # Testcase 88:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x5, 4f 
    c.jr x5
    li x10, 0x123ab
4: 
    sw x10, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xcccc) 



 
    # Testcase 89:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x4, 5f 
    c.jr x4
    li x10, 0x123ab
5: 
    sw x10, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res
 
    
 

 
    # Testcase 90:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x3, 1f 
    c.jr x3
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



 
    # Testcase 91:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x2, 2f 
    c.jr x2
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 92:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x1, 2b
    c.jr x1
    li x6, 0x123ab
4: 
    sw x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



 
    # Testcase 93:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x31, 4f 
    c.jr x31
    li x6, 0x123ab
4: 
    sw x6, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



 
    # Testcase 94:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x30, 5f 
    c.jr x30
    li x6, 0x123ab
5: 
    sw x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x8, test_20_res
 
    
 

 
    # Testcase 95:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x29, 1f 
    c.jr x29
    li x15, 0x123ab
1: 
    sw x15, 0(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xcccc) 



 
    # Testcase 96:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x28, 2f 
    c.jr x28
    li x15, 0x123ab
2: 
    sw x15, 4(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 97:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x27, 2b
    c.jr x27
    li x15, 0x123ab
4: 
    sw x15, 8(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xcccc)  



 
    # Testcase 98:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x26, 4f 
    c.jr x26
    li x15, 0x123ab
4: 
    sw x15, 12(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xcccc) 



 
    # Testcase 99:  result rd:x15(0xcccc)
    li x15, 0xcccc
    la x25, 5f 
    c.jr x25
    li x15, 0x123ab
5: 
    sw x15, 16(x8)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x3, test_21_res
 
    
 

 
    # Testcase 100:  result rd:x13(0xcccc)
    li x13, 0xcccc
    la x24, 1f 
    c.jr x24
    li x13, 0x123ab
1: 
    sw x13, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x13, 0xcccc) 



 
    # Testcase 101:  result rd:x13(0xcccc)
    li x13, 0xcccc
    la x23, 2f 
    c.jr x23
    li x13, 0x123ab
2: 
    sw x13, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x13, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 102:  result rd:x13(0xcccc)
    li x13, 0xcccc
    la x22, 2b
    c.jr x22
    li x13, 0x123ab
4: 
    sw x13, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x13, 0xcccc)  



 
    # Testcase 103:  result rd:x13(0xcccc)
    li x13, 0xcccc
    la x21, 4f 
    c.jr x21
    li x13, 0x123ab
4: 
    sw x13, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x13, 0xcccc) 



 
    # Testcase 104:  result rd:x13(0xcccc)
    li x13, 0xcccc
    la x20, 5f 
    c.jr x20
    li x13, 0x123ab
5: 
    sw x13, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x13, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res
 
    
 

 
    # Testcase 105:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x19, 1f 
    c.jr x19
    li x7, 0x123ab
1: 
    sw x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



 
    # Testcase 106:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x18, 2f 
    c.jr x18
    li x7, 0x123ab
2: 
    sw x7, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 107:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x17, 2b
    c.jr x17
    li x7, 0x123ab
4: 
    sw x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  



 
    # Testcase 108:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x16, 4f 
    c.jr x16
    li x7, 0x123ab
4: 
    sw x7, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



 
    # Testcase 109:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x15, 5f 
    c.jr x15
    li x7, 0x123ab
5: 
    sw x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x3, test_23_res
 
    
 

 
    # Testcase 110:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x14, 1f 
    c.jr x14
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 111:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x13, 2f 
    c.jr x13
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 112:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x12, 2b
    c.jr x12
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



 
    # Testcase 113:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x11, 4f 
    c.jr x11
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 114:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x10, 5f 
    c.jr x10
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x3, test_24_res
 
    
 

 
    # Testcase 115:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x9, 1f 
    c.jr x9
    li x10, 0x123ab
1: 
    sw x10, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xcccc) 



 
    # Testcase 116:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x8, 2f 
    c.jr x8
    li x10, 0x123ab
2: 
    sw x10, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 117:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x7, 2b
    c.jr x7
    li x10, 0x123ab
4: 
    sw x10, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xcccc)  



 
    # Testcase 118:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x6, 4f 
    c.jr x6
    li x10, 0x123ab
4: 
    sw x10, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xcccc) 



 
    # Testcase 119:  result rd:x10(0xcccc)
    li x10, 0xcccc
    la x5, 5f 
    c.jr x5
    li x10, 0x123ab
5: 
    sw x10, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res
 
    
 

 
    # Testcase 120:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x4, 1f 
    c.jr x4
    li x7, 0x123ab
1: 
    sw x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



 
    # Testcase 121:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x3, 2f 
    c.jr x3
    li x7, 0x123ab
2: 
    sw x7, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 122:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x2, 2b
    c.jr x2
    li x7, 0x123ab
4: 
    sw x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  



 
    # Testcase 123:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x1, 4f 
    c.jr x1
    li x7, 0x123ab
4: 
    sw x7, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



 
    # Testcase 124:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x31, 5f 
    c.jr x31
    li x7, 0x123ab
5: 
    sw x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x7, test_26_res
 
    
 

 
    # Testcase 125:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x30, 1f 
    c.jr x30
    li x9, 0x123ab
1: 
    sw x9, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



 
    # Testcase 126:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x29, 2f 
    c.jr x29
    li x9, 0x123ab
2: 
    sw x9, 4(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 127:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x28, 2b
    c.jr x28
    li x9, 0x123ab
4: 
    sw x9, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc)  



 
    # Testcase 128:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x27, 4f 
    c.jr x27
    li x9, 0x123ab
4: 
    sw x9, 12(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



 
    # Testcase 129:  result rd:x9(0xcccc)
    li x9, 0xcccc
    la x26, 5f 
    c.jr x26
    li x9, 0x123ab
5: 
    sw x9, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x3, test_27_res
 
    
 

 
    # Testcase 130:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x25, 1f 
    c.jr x25
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 131:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x24, 2f 
    c.jr x24
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 132:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x23, 2b
    c.jr x23
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



 
    # Testcase 133:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x22, 4f 
    c.jr x22
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



 
    # Testcase 134:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x21, 5f 
    c.jr x21
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x3, test_28_res
 
    
 

 
    # Testcase 135:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x2, 1f 
    c.jr x2
    li x6, 0x123ab
1: 
    sw x6, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0xcccc) 



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

