# RISC-V Compliance Test I-JALR-01
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
# Description: Testing instruction 'JALR'.

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
 
    
 
 
    # Testcase 0:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x16, 1f + 1
    jalr x1, x16,  -1
    li x8, 0x123ab
1: 
    sd x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 1:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x15, 2f - 2047
    jalr x2, x15,  2047
    li x8, 0x123ab
2: 
    sd x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 2:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x14, 2b + 1025
    jalr x3, x14,  -1025
    li x8, 0x123ab
4: 
    sd x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 3:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x13, 4f + 513
    jalr x4, x13,  -513
    li x8, 0x123ab
4: 
    sd x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 4:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x12, 5f + 257
    jalr x5, x12,  -257
    li x8, 0x123ab
5: 
    sd x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res
 
    
 
 
    # Testcase 5:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 1f + 129
    jalr x6, x11,  -129
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 6:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 2f + 65
    jalr x7, x10,  -65
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 7:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 2b + 33
    jalr x8, x9,  -33
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 8:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 4f + 17
    jalr x9, x8,  -17
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 9:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 5f + 9
    jalr x10, x7,  -9
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res
 
    
 
 
    # Testcase 10:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x6, 1f + 5
    jalr x11, x6,  -5
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 11:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x5, 2f + 3
    jalr x12, x5,  -3
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 12:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x4, 2b + 2
    jalr x13, x4,  -2
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 13:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x3, 4f - 0
    jalr x14, x3,  0
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 14:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x2, 5f + 2048
    jalr x15, x2,  -2048
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res
 
    
 
 
    # Testcase 15:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x1, 1f - 1024
    jalr x16, x1,  1024
    li x4, 0x123ab
1: 
    sd x4, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


 
    # Testcase 16:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x31, 2f - 512
    jalr x17, x31,  512
    li x4, 0x123ab
2: 
    sd x4, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 17:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x30, 2b - 256
    jalr x18, x30,  256
    li x4, 0x123ab
4: 
    sd x4, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)  


 
    # Testcase 18:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x29, 4f - 128
    jalr x19, x29,  128
    li x4, 0x123ab
4: 
    sd x4, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


 
    # Testcase 19:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x28, 5f - 64
    jalr x20, x28,  64
    li x4, 0x123ab
5: 
    sd x4, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res
 
    
 
 
    # Testcase 20:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 1f - 32
    jalr x21, x27,  32
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 21:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 2f - 16
    jalr x22, x26,  16
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 22:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 2b - 8
    jalr x23, x25,  8
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 23:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 4f - 4
    jalr x24, x24,  4
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 24:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 5f - 2
    jalr x25, x23,  2
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res
 
    
 
 
    # Testcase 25:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x22, 1f - 1
    jalr x26, x22,  1
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 26:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x21, 2f + 1
    jalr x27, x21,  -1
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 27:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x20, 2b - 2047
    jalr x28, x20,  2047
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 28:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x19, 4f + 1025
    jalr x29, x19,  -1025
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 29:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x18, 5f + 513
    jalr x30, x18,  -513
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res
 
    
 
 
    # Testcase 30:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x17, 1f + 257
    jalr x31, x17,  -257
    li x7, 0x123ab
1: 
    sd x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 31:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x16, 2f + 129
    jalr x1, x16,  -129
    li x7, 0x123ab
2: 
    sd x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 32:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x15, 2b + 65
    jalr x2, x15,  -65
    li x7, 0x123ab
4: 
    sd x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  


 
    # Testcase 33:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x14, 4f + 33
    jalr x3, x14,  -33
    li x7, 0x123ab
4: 
    sd x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 34:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x13, 5f + 17
    jalr x4, x13,  -17
    li x7, 0x123ab
5: 
    sd x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res
 
    
 
 
    # Testcase 35:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 1f + 9
    jalr x5, x12,  -9
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 36:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 2f + 5
    jalr x6, x11,  -5
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 37:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 2b + 3
    jalr x7, x10,  -3
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 38:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 4f + 2
    jalr x8, x9,  -2
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 39:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 5f - 0
    jalr x9, x8,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res
 
    
 
 
    # Testcase 40:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x7, 1f + 2048
    jalr x10, x7,  -2048
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 41:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x6, 2f - 1024
    jalr x11, x6,  1024
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 42:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x5, 2b - 512
    jalr x12, x5,  512
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)  


 
    # Testcase 43:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x4, 4f - 256
    jalr x13, x4,  256
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 44:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x3, 5f - 128
    jalr x14, x3,  128
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res
 
    
 
 
    # Testcase 45:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x2, 1f - 64
    jalr x15, x2,  64
    li x5, 0x123ab
1: 
    sd x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 46:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x1, 2f - 32
    jalr x16, x1,  32
    li x5, 0x123ab
2: 
    sd x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 47:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x31, 2b - 16
    jalr x17, x31,  16
    li x5, 0x123ab
4: 
    sd x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  


 
    # Testcase 48:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x30, 4f - 8
    jalr x18, x30,  8
    li x5, 0x123ab
4: 
    sd x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 49:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x29, 5f - 4
    jalr x19, x29,  4
    li x5, 0x123ab
5: 
    sd x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res
 
    
 
 
    # Testcase 50:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 1f - 2
    jalr x20, x28,  2
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 51:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 2f - 1
    jalr x21, x27,  1
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 52:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 2b + 1
    jalr x22, x26,  -1
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 53:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 4f - 2047
    jalr x23, x25,  2047
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 54:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 5f + 1025
    jalr x24, x24,  -1025
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res
 
    
 
 
    # Testcase 55:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x23, 1f + 513
    jalr x25, x23,  -513
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 56:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x22, 2f + 257
    jalr x26, x22,  -257
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 57:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x21, 2b + 129
    jalr x27, x21,  -129
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)  


 
    # Testcase 58:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x20, 4f + 65
    jalr x28, x20,  -65
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 59:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x19, 5f + 33
    jalr x29, x19,  -33
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res
 
    
 
 
    # Testcase 60:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 1f + 17
    jalr x30, x18,  -17
    li x6, 0x123ab
1: 
    sd x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 61:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x17, 2f + 9
    jalr x31, x17,  -9
    li x6, 0x123ab
2: 
    sd x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 62:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x16, 2b + 5
    jalr x1, x16,  -5
    li x6, 0x123ab
4: 
    sd x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  


 
    # Testcase 63:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x15, 4f + 3
    jalr x2, x15,  -3
    li x6, 0x123ab
4: 
    sd x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 64:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x14, 5f + 2
    jalr x3, x14,  -2
    li x6, 0x123ab
5: 
    sd x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res
 
    
 
 
    # Testcase 65:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x13, 1f - 0
    jalr x4, x13,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 66:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 2f + 2048
    jalr x5, x12,  -2048
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 67:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 2b - 1024
    jalr x6, x11,  1024
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 68:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 4f - 512
    jalr x7, x10,  512
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 69:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 5f - 256
    jalr x8, x9,  256
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res
 
    
 
 
    # Testcase 70:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 1f - 128
    jalr x9, x8,  128
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 71:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 2f - 64
    jalr x10, x7,  64
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 72:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 2b - 32
    jalr x11, x6,  32
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 73:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x5, 4f - 16
    jalr x12, x5,  16
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 74:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x4, 5f - 8
    jalr x13, x4,  8
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res
 
    
 
 
    # Testcase 75:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x3, 1f - 4
    jalr x14, x3,  4
    li x6, 0x123ab
1: 
    sd x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 76:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x2, 2f - 2
    jalr x15, x2,  2
    li x6, 0x123ab
2: 
    sd x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 77:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x1, 2b - 1
    jalr x16, x1,  1
    li x6, 0x123ab
4: 
    sd x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  


 
    # Testcase 78:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x31, 4f + 1
    jalr x17, x31,  -1
    li x6, 0x123ab
4: 
    sd x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 79:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x30, 5f - 2047
    jalr x18, x30,  2047
    li x6, 0x123ab
5: 
    sd x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res
 
    
 
 
    # Testcase 80:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x29, 1f + 1025
    jalr x19, x29,  -1025
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 81:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 2f + 513
    jalr x20, x28,  -513
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 82:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 2b + 257
    jalr x21, x27,  -257
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 83:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 4f + 129
    jalr x22, x26,  -129
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 84:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 5f + 65
    jalr x23, x25,  -65
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res
 
    
 
 
    # Testcase 85:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 1f + 33
    jalr x24, x24,  -33
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 86:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 2f + 17
    jalr x25, x23,  -17
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 87:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 2b + 9
    jalr x26, x22,  -9
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 88:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x21, 4f + 5
    jalr x27, x21,  -5
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 89:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x20, 5f + 3
    jalr x28, x20,  -3
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res
 
    
 
 
    # Testcase 90:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x19, 1f + 2
    jalr x29, x19,  -2
    li x6, 0x123ab
1: 
    sd x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 91:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 2f - 0
    jalr x30, x18,  0
    li x6, 0x123ab
2: 
    sd x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 92:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x17, 2b + 2048
    jalr x31, x17,  -2048
    li x6, 0x123ab
4: 
    sd x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  


 
    # Testcase 93:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x16, 4f - 1024
    jalr x1, x16,  1024
    li x6, 0x123ab
4: 
    sd x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 94:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x15, 5f - 512
    jalr x2, x15,  512
    li x6, 0x123ab
5: 
    sd x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res
 
    
 
 
    # Testcase 95:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x14, 1f - 256
    jalr x3, x14,  256
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 96:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x13, 2f - 128
    jalr x4, x13,  128
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 97:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x12, 2b - 64
    jalr x5, x12,  64
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)  


 
    # Testcase 98:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x11, 4f - 32
    jalr x6, x11,  32
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 99:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x10, 5f - 16
    jalr x7, x10,  16
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res
 
    
 
 
    # Testcase 100:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 1f - 8
    jalr x8, x9,  8
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 101:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 2f - 4
    jalr x9, x8,  4
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 102:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 2b - 2
    jalr x10, x7,  2
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 103:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 4f - 1
    jalr x11, x6,  1
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 104:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x5, 5f + 1
    jalr x12, x5,  -1
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res
 
    
 
 
    # Testcase 105:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x4, 1f - 2047
    jalr x13, x4,  2047
    li x7, 0x123ab
1: 
    sd x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 106:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x3, 2f + 1025
    jalr x14, x3,  -1025
    li x7, 0x123ab
2: 
    sd x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 107:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x2, 2b + 513
    jalr x15, x2,  -513
    li x7, 0x123ab
4: 
    sd x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  


 
    # Testcase 108:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x1, 4f + 257
    jalr x16, x1,  -257
    li x7, 0x123ab
4: 
    sd x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 109:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x31, 5f + 129
    jalr x17, x31,  -129
    li x7, 0x123ab
5: 
    sd x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res
 
    
 
 
    # Testcase 110:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x30, 1f + 65
    jalr x18, x30,  -65
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 111:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x29, 2f + 33
    jalr x19, x29,  -33
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 112:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 2b + 17
    jalr x20, x28,  -17
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 113:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 4f + 9
    jalr x21, x27,  -9
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 114:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 5f + 5
    jalr x22, x26,  -5
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res
 
    
 
 
    # Testcase 115:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 1f + 3
    jalr x23, x25,  -3
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 116:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 2f + 2
    jalr x24, x24,  -2
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 117:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 2b - 0
    jalr x25, x23,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 118:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 4f + 2048
    jalr x26, x22,  -2048
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 119:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x21, 5f - 1024
    jalr x27, x21,  1024
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res
 
    
 
 
    # Testcase 120:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x20, 1f - 512
    jalr x28, x20,  512
    li x7, 0x123ab
1: 
    sd x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 121:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x19, 2f - 256
    jalr x29, x19,  256
    li x7, 0x123ab
2: 
    sd x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 122:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x18, 2b - 128
    jalr x30, x18,  128
    li x7, 0x123ab
4: 
    sd x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  


 
    # Testcase 123:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x17, 4f - 64
    jalr x31, x17,  64
    li x7, 0x123ab
4: 
    sd x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 124:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x16, 5f - 32
    jalr x1, x16,  32
    li x7, 0x123ab
5: 
    sd x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res
 
    
 
 
    # Testcase 125:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x15, 1f - 16
    jalr x2, x15,  16
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 126:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x14, 2f - 8
    jalr x3, x14,  8
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 127:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x13, 2b - 4
    jalr x4, x13,  4
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 128:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x12, 4f - 2
    jalr x5, x12,  2
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 129:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x11, 5f - 1
    jalr x6, x11,  1
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res
 
    
 
 
    # Testcase 130:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 1f - 0
    jalr x7, x10,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 131:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 2f - 0
    jalr x8, x9,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 132:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 2b - 0
    jalr x9, x8,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 133:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 4f - 0
    jalr x10, x7,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 134:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 5f - 0
    jalr x11, x6,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res
 
    
 
 
    # Testcase 135:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x5, 1f - 0
    jalr x12, x5,  0
    li x8, 0x123ab
1: 
    sd x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 136:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x4, 2f - 0
    jalr x13, x4,  0
    li x8, 0x123ab
2: 
    sd x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 137:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x3, 2b - 0
    jalr x14, x3,  0
    li x8, 0x123ab
4: 
    sd x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 138:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x2, 4f - 0
    jalr x15, x2,  0
    li x8, 0x123ab
4: 
    sd x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 139:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x1, 5f - 0
    jalr x16, x1,  0
    li x8, 0x123ab
5: 
    sd x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res
 
    
 
 
    # Testcase 140:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x31, 1f - 0
    jalr x17, x31,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 141:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x30, 2f - 0
    jalr x18, x30,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 142:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x29, 2b - 0
    jalr x19, x29,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 143:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 4f - 0
    jalr x20, x28,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 144:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 5f - 0
    jalr x21, x27,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res
 
    
 
 
    # Testcase 145:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 1f - 0
    jalr x22, x26,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 146:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 2f - 0
    jalr x23, x25,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 147:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 2b - 0
    jalr x24, x24,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 148:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 4f - 0
    jalr x25, x23,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 149:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 5f - 0
    jalr x26, x22,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x6, test_31_res
 
    
 
 
    # Testcase 150:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x21, 1f - 0
    jalr x27, x21,  0
    li x8, 0x123ab
1: 
    sd x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 151:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x20, 2f - 0
    jalr x28, x20,  0
    li x8, 0x123ab
2: 
    sd x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 152:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x19, 2b - 0
    jalr x29, x19,  0
    li x8, 0x123ab
4: 
    sd x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 153:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x18, 4f - 0
    jalr x30, x18,  0
    li x8, 0x123ab
4: 
    sd x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 154:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x17, 5f - 0
    jalr x31, x17,  0
    li x8, 0x123ab
5: 
    sd x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x6, test_32_res
 
    
 
 
    # Testcase 155:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x16, 1f - 0
    jalr x1, x16,  0
    li x8, 0x123ab
1: 
    sd x8, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 156:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x15, 2f - 0
    jalr x2, x15,  0
    li x8, 0x123ab
2: 
    sd x8, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 157:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x14, 2b - 0
    jalr x3, x14,  0
    li x8, 0x123ab
4: 
    sd x8, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 158:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x13, 4f - 0
    jalr x4, x13,  0
    li x8, 0x123ab
4: 
    sd x8, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 159:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x12, 5f - 0
    jalr x5, x12,  0
    li x8, 0x123ab
5: 
    sd x8, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res
 
    
 
 
    # Testcase 160:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 1f - 0
    jalr x6, x11,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 161:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 2f - 0
    jalr x7, x10,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 162:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 2b - 0
    jalr x8, x9,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 163:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 4f - 0
    jalr x9, x8,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 164:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 5f - 0
    jalr x10, x7,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res
 
    
 
 
    # Testcase 165:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x6, 1f - 0
    jalr x11, x6,  0
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 166:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x5, 2f - 0
    jalr x12, x5,  0
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 167:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x4, 2b - 0
    jalr x13, x4,  0
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 168:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x3, 4f - 0
    jalr x14, x3,  0
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 169:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x2, 5f - 0
    jalr x15, x2,  0
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x2, test_35_res
 
    
 
 
    # Testcase 170:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x1, 1f - 0
    jalr x16, x1,  0
    li x4, 0x123ab
1: 
    sd x4, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


 
    # Testcase 171:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x31, 2f - 0
    jalr x17, x31,  0
    li x4, 0x123ab
2: 
    sd x4, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 172:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x30, 2b - 0
    jalr x18, x30,  0
    li x4, 0x123ab
4: 
    sd x4, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)  


 
    # Testcase 173:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x29, 4f - 0
    jalr x19, x29,  0
    li x4, 0x123ab
4: 
    sd x4, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


 
    # Testcase 174:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x28, 5f - 0
    jalr x20, x28,  0
    li x4, 0x123ab
5: 
    sd x4, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res
 
    
 
 
    # Testcase 175:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 1f - 0
    jalr x21, x27,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 176:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 2f - 0
    jalr x22, x26,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 177:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 2b - 0
    jalr x23, x25,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 178:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 4f - 0
    jalr x24, x24,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 179:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 5f - 0
    jalr x25, x23,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res
 
    
 
 
    # Testcase 180:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x22, 1f - 0
    jalr x26, x22,  0
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 181:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x21, 2f - 0
    jalr x27, x21,  0
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 182:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x20, 2b - 0
    jalr x28, x20,  0
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 183:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x19, 4f - 0
    jalr x29, x19,  0
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 184:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x18, 5f - 0
    jalr x30, x18,  0
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x5, test_38_res
 
    
 
 
    # Testcase 185:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x17, 1f - 0
    jalr x31, x17,  0
    li x7, 0x123ab
1: 
    sd x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 186:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x16, 2f - 0
    jalr x1, x16,  0
    li x7, 0x123ab
2: 
    sd x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 187:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x15, 2b - 0
    jalr x2, x15,  0
    li x7, 0x123ab
4: 
    sd x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  


 
    # Testcase 188:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x14, 4f - 0
    jalr x3, x14,  0
    li x7, 0x123ab
4: 
    sd x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 189:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x13, 5f - 0
    jalr x4, x13,  0
    li x7, 0x123ab
5: 
    sd x7, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res
 
    
 
 
    # Testcase 190:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 1f - 0
    jalr x5, x12,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 191:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 2f - 0
    jalr x6, x11,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 192:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 2b - 0
    jalr x7, x10,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 193:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 4f - 0
    jalr x8, x9,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 194:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 5f - 0
    jalr x9, x8,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res
 
    
 
 
    # Testcase 195:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x7, 1f - 0
    jalr x10, x7,  0
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 196:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x6, 2f - 0
    jalr x11, x6,  0
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 197:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x5, 2b - 0
    jalr x12, x5,  0
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)  


 
    # Testcase 198:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x4, 4f - 0
    jalr x13, x4,  0
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 199:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x3, 5f - 0
    jalr x14, x3,  0
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x3, test_41_res
 
    
 
 
    # Testcase 200:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x2, 1f - 0
    jalr x15, x2,  0
    li x5, 0x123ab
1: 
    sd x5, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 201:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x1, 2f - 0
    jalr x16, x1,  0
    li x5, 0x123ab
2: 
    sd x5, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 202:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x31, 2b - 0
    jalr x17, x31,  0
    li x5, 0x123ab
4: 
    sd x5, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  


 
    # Testcase 203:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x30, 4f - 0
    jalr x18, x30,  0
    li x5, 0x123ab
4: 
    sd x5, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 204:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x29, 5f - 0
    jalr x19, x29,  0
    li x5, 0x123ab
5: 
    sd x5, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res
 
    
 
 
    # Testcase 205:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 1f - 0
    jalr x20, x28,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 206:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 2f - 0
    jalr x21, x27,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 207:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 2b - 0
    jalr x22, x26,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 208:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 4f - 0
    jalr x23, x25,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 209:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 5f - 0
    jalr x24, x24,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res
 
    
 
 
    # Testcase 210:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x23, 1f - 0
    jalr x25, x23,  0
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 211:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x22, 2f - 0
    jalr x26, x22,  0
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 212:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x21, 2b - 0
    jalr x27, x21,  0
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)  


 
    # Testcase 213:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x20, 4f - 0
    jalr x28, x20,  0
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 214:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x19, 5f - 0
    jalr x29, x19,  0
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x4, test_44_res
 
    
 
 
    # Testcase 215:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 1f - 0
    jalr x30, x18,  0
    li x6, 0x123ab
1: 
    sd x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 216:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x17, 2f - 0
    jalr x31, x17,  0
    li x6, 0x123ab
2: 
    sd x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 217:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x16, 2b - 0
    jalr x1, x16,  0
    li x6, 0x123ab
4: 
    sd x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  


 
    # Testcase 218:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x15, 4f - 0
    jalr x2, x15,  0
    li x6, 0x123ab
4: 
    sd x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 219:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x14, 5f - 0
    jalr x3, x14,  0
    li x6, 0x123ab
5: 
    sd x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res
 
    
 
 
    # Testcase 220:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x13, 1f - 0
    jalr x4, x13,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 221:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 2f - 0
    jalr x5, x12,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 222:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 2b - 0
    jalr x6, x11,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 223:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 4f - 0
    jalr x7, x10,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 224:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 5f - 0
    jalr x8, x9,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res
 
    
 
 
    # Testcase 225:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 1f - 0
    jalr x9, x8,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 226:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 2f - 0
    jalr x10, x7,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 227:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 2b - 0
    jalr x11, x6,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 228:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x5, 4f - 0
    jalr x12, x5,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 229:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x4, 5f - 0
    jalr x13, x4,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x4, test_47_res
 
    
 
 
    # Testcase 230:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x3, 1f - 0
    jalr x14, x3,  0
    li x6, 0x123ab
1: 
    sd x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 231:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x2, 2f - 0
    jalr x15, x2,  0
    li x6, 0x123ab
2: 
    sd x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 232:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x1, 2b - 0
    jalr x16, x1,  0
    li x6, 0x123ab
4: 
    sd x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  


 
    # Testcase 233:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x31, 4f - 0
    jalr x17, x31,  0
    li x6, 0x123ab
4: 
    sd x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 234:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x30, 5f - 0
    jalr x18, x30,  0
    li x6, 0x123ab
5: 
    sd x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res
 
    
 
 
    # Testcase 235:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x29, 1f - 0
    jalr x19, x29,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 236:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 2f - 0
    jalr x20, x28,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 237:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 2b - 0
    jalr x21, x27,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 238:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 4f - 0
    jalr x22, x26,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 239:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 5f - 0
    jalr x23, x25,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res
 
    
 
 
    # Testcase 240:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 1f - 0
    jalr x24, x24,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 241:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 2f - 0
    jalr x25, x23,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 242:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 2b - 0
    jalr x26, x22,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 243:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x21, 4f - 0
    jalr x27, x21,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 244:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x20, 5f - 0
    jalr x28, x20,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x4, test_50_res
 
    
 
 
    # Testcase 245:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x19, 1f - 0
    jalr x29, x19,  0
    li x6, 0x123ab
1: 
    sd x6, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 246:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 2f - 0
    jalr x30, x18,  0
    li x6, 0x123ab
2: 
    sd x6, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 247:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x17, 2b - 0
    jalr x31, x17,  0
    li x6, 0x123ab
4: 
    sd x6, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  


 
    # Testcase 248:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x16, 4f - 0
    jalr x1, x16,  0
    li x6, 0x123ab
4: 
    sd x6, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 249:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x15, 5f - 0
    jalr x2, x15,  0
    li x6, 0x123ab
5: 
    sd x6, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res
 
    
 
 
    # Testcase 250:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x14, 1f - 0
    jalr x3, x14,  0
    li x8, 0x123ab
1: 
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 251:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x13, 2f - 0
    jalr x4, x13,  0
    li x8, 0x123ab
2: 
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 252:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x12, 2b - 0
    jalr x5, x12,  0
    li x8, 0x123ab
4: 
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)  


 
    # Testcase 253:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x11, 4f - 0
    jalr x6, x11,  0
    li x8, 0x123ab
4: 
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 254:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x10, 5f - 0
    jalr x7, x10,  0
    li x8, 0x123ab
5: 
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res
 
    
 
 
    # Testcase 255:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 1f - 0
    jalr x8, x9,  0
    li x3, 0x123ab
1: 
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 256:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 2f - 0
    jalr x9, x8,  0
    li x3, 0x123ab
2: 
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 257:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 2b - 0
    jalr x10, x7,  0
    li x3, 0x123ab
4: 
    sd x3, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 258:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 4f - 0
    jalr x11, x6,  0
    li x3, 0x123ab
4: 
    sd x3, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 259:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x5, 5f - 0
    jalr x12, x5,  0
    li x3, 0x123ab
5: 
    sd x3, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x5, test_53_res
 
    
 
 
    # Testcase 260:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x4, 1f + 1
    jalr x13, x4,  -1
    li x7, 0x123ab
1: 
    sd x7, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 261:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x3, 2f - 2047
    jalr x0, x3,  2047
    li x7, 0x123ab
2: 
    sd x7, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 262:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x2, 2b + 1025
    jalr x15, x2,  -1025
    li x7, 0x123ab
4: 
    sd x7, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  


 
    # Testcase 263:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x1, 4f + 513
    jalr x16, x1,  -513
    li x7, 0x123ab
4: 
    sd x7, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



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

