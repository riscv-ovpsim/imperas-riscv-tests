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
# Specification: RV32I Base Integer Instruction Set, Version 2.1
# Description: Testing instruction 'JAL'.

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
    la x2, test_1_res
    
     # Testcase 0:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 1:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 3:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 4:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 6:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 8:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 9:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 11:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x7)
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
    sw x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 13:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 14:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x7)
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
    sw x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     # Testcase 16:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x3)
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
    sw x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 18:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 19:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x12, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x3)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 21:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 23:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 24:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x7, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 26:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x7)
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
    sw x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 28:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 29:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x2, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x7)
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
    sw x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     # Testcase 31:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x3)
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
    sw x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 33:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 34:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x3)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 36:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 38:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 39:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 41:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 43:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 44:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 46:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x16, 2f
    li x2, 0x123ab
2: 
    sw x2, 4(x3)
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
    sw x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 48:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x14, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 49:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x3)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 51:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x11, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 53:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x9, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 54:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 56:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x6, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 58:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x4, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 59:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 61:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x1, 2f
    li x2, 0x123ab
2: 
    sw x2, 4(x3)
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
    sw x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 63:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 64:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x3)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 66:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 68:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 69:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 71:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x22, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 73:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 74:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x19, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 76:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x17, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x4)
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
    sw x2, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xcccc)

     # Testcase 78:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 79:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x14, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x4)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 81:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x12, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 83:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 84:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x9, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 86:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x7, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 88:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 89:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x4, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 91:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x2, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x4)
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
    sw x2, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xcccc)

     # Testcase 93:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 94:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x30, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x4)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 96:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x28, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 98:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 99:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x25, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 101:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x23, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 103:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 104:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x20, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 106:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x18, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x5)
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
    sw x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 108:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x16, 4f
    li x2, 0x123ab
4: 
    sw x2, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xcccc)

     # Testcase 109:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x15, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x5)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 111:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x13, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 113:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x11, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 114:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x10, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 116:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x8, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 118:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x6, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 119:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x5, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 121:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x3, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x5)
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
    sw x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 123:  result rd:x2(0xcccc)
    li x2, 0xcccc
    jal x1, 4f
    li x2, 0x123ab
4: 
    sw x2, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xcccc)

     # Testcase 124:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x31, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x5)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 126:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x29, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 128:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x27, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 129:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x26, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
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
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 131:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x24, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
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
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 133:  result rd:x0(0)
    li x0, 0xcccc
    jal x22, 4f
    li x0, 0x123ab
4: 
    sw x0, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x0, 0)

     # Testcase 134:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x21, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x2, test_28_res
    
     # Testcase 135:  result rd:x1(0xcccc)
    li x1, 0xcccc
    jal x0, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



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

