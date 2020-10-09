# RISC-V Compliance Test I-JAL-01
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
# Description: Testing instruction 'JAL'.

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
    la x2, test_1_res
    
     # Testcase 0:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 1:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 2:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 3:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 4:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x2, test_2_res
    
     # Testcase 5:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 6:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 7:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 8:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 9:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x7, test_3_res
    
     # Testcase 10:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 11:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 12:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 13:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 14:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x3, test_4_res
    
     # Testcase 15:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x16, 1f
    li x2, 0x123ab
1: 
    sd x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     # Testcase 16:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 17:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x14, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 18:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 19:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x12, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x2, test_5_res
    
     # Testcase 20:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x11, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 21:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 22:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x9, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 23:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 24:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x7, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x7, test_6_res
    
     # Testcase 25:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x6, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 26:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 27:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x4, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 28:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 29:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x2, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x3, test_7_res
    
     # Testcase 30:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x1, 1f
    li x2, 0x123ab
1: 
    sd x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     # Testcase 31:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 32:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 33:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 34:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x2, test_8_res
    
     # Testcase 35:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 36:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 37:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 38:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 39:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x2, test_9_res
    
     # Testcase 40:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 41:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 42:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 43:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 44:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res
    
     # Testcase 45:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 46:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x16, 2f
    li x2, 0x123ab
2: 
    sd x2, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 47:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 48:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x14, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 49:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x2, test_11_res
    
     # Testcase 50:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x12, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 51:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x11, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 52:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 53:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x9, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 54:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x2, test_12_res
    
     # Testcase 55:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x7, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 56:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x6, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 57:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 58:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x4, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 59:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x3, test_13_res
    
     # Testcase 60:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x2, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 61:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x1, 2f
    li x2, 0x123ab
2: 
    sd x2, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 62:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 63:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 64:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x2, test_14_res
    
     # Testcase 65:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 66:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 67:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 68:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 69:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x2, test_15_res
    
     # Testcase 70:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 71:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 72:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 73:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 74:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res
    
     # Testcase 75:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 76:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 77:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x16, 2b
    li x2, 0x123ab
4:
    sd x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xcccc)

     # Testcase 78:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 79:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x14, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x2, test_17_res
    
     # Testcase 80:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 81:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x12, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 82:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x11, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 83:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 84:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x9, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x2, test_18_res
    
     # Testcase 85:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 86:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x7, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 87:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x6, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 88:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 89:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x4, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res
    
     # Testcase 90:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 91:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x2, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 92:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x1, 2b
    li x2, 0x123ab
4:
    sd x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xcccc)

     # Testcase 93:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 94:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x2, test_20_res
    
     # Testcase 95:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 96:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 97:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 98:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 99:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x2, test_21_res
    
     # Testcase 100:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 101:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 102:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 103:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 104:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res
    
     # Testcase 105:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 106:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 107:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 108:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x16, 4f
    li x2, 0x123ab
4: 
    sd x2, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xcccc)

     # Testcase 109:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x2, test_23_res
    
     # Testcase 110:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x14, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 111:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 112:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x12, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 113:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x11, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 114:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x2, test_24_res
    
     # Testcase 115:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x9, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 116:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 117:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x7, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 118:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x6, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 119:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res
    
     # Testcase 120:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x4, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 121:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 122:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x2, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 123:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x1, 4f
    li x2, 0x123ab
4: 
    sd x2, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xcccc)

     # Testcase 124:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x2, test_26_res
    
     # Testcase 125:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 126:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 127:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 128:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 129:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x2, test_27_res
    
     # Testcase 130:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 131:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 132:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 133:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 134:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res
    
     # Testcase 135:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xcccc)

     # Testcase 136:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 137:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xcccc)

     # Testcase 138:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xcccc)

     # Testcase 139:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x16, 5f
    li x2, 0x123ab
5: 
    sd x2, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x2, test_29_res
    
     # Testcase 140:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 141:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x14, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 142:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 143:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x12, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 144:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x11, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x2, test_30_res
    
     # Testcase 145:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 146:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x9, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 147:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 148:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x7, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 149:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x6, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x6, test_31_res
    
     # Testcase 150:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xcccc)

     # Testcase 151:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x4, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 152:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xcccc)

     # Testcase 153:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x2, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xcccc)

     # Testcase 154:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x1, 5f
    li x2, 0x123ab
5: 
    sd x2, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x2, test_32_res
    
     # Testcase 155:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 156:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 157:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 158:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 159:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x2, test_33_res
    
     # Testcase 160:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 161:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 162:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 163:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 164:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x7, test_34_res
    
     # Testcase 165:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 166:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 167:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 168:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 169:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x3, test_35_res
    
     # Testcase 170:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x16, 1f
    li x2, 0x123ab
1: 
    sd x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     # Testcase 171:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 172:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x14, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 173:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 174:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x12, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x2, test_36_res
    
     # Testcase 175:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x11, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 176:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 177:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x9, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 178:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 179:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x7, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x7, test_37_res
    
     # Testcase 180:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x6, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 181:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 182:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x4, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 183:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 184:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x2, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x3, test_38_res
    
     # Testcase 185:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x1, 1f
    li x2, 0x123ab
1: 
    sd x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     # Testcase 186:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 187:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 188:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 189:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x2, test_39_res
    
     # Testcase 190:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 191:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 192:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 193:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 194:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x2, test_40_res
    
     # Testcase 195:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 196:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 197:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 198:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 199:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x3, test_41_res
    
     # Testcase 200:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 201:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x16, 2f
    li x2, 0x123ab
2: 
    sd x2, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 202:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 203:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x14, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 204:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x2, test_42_res
    
     # Testcase 205:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x12, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 206:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x11, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 207:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 208:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x9, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 209:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x2, test_43_res
    
     # Testcase 210:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x7, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 211:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x6, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 212:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 213:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x4, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 214:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x3, test_44_res
    
     # Testcase 215:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x2, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 216:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x1, 2f
    li x2, 0x123ab
2: 
    sd x2, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 217:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 218:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 219:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x2, test_45_res
    
     # Testcase 220:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 221:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 222:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 223:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 224:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x2, test_46_res
    
     # Testcase 225:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 226:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 227:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 228:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 229:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x4, test_47_res
    
     # Testcase 230:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 231:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 232:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x16, 2b
    li x2, 0x123ab
4:
    sd x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xcccc)

     # Testcase 233:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 234:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x14, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x2, test_48_res
    
     # Testcase 235:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 236:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x12, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 237:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x11, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 238:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 239:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x9, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x2, test_49_res
    
     # Testcase 240:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 241:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x7, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 242:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x6, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 243:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 244:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x4, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x4, test_50_res
    
     # Testcase 245:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 246:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x2, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 247:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x1, 2b
    li x2, 0x123ab
4:
    sd x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xcccc)

     # Testcase 248:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 249:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x2, test_51_res
    
     # Testcase 250:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 251:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 252:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 253:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 254:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x2, test_52_res
    
     # Testcase 255:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 256:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 257:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 258:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 259:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x5, test_53_res
    
     # Testcase 260:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 261:  result rd:x0(0)
    li x0, 0xcccc
    jal x18, 2f
    li x0, 0x123ab
2: 
    sd x0, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x0, 0)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 262:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 263:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x0, 4f
    li x2, 0x123ab
4: 
    sd x2, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xcccc)



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

