# RISC-V Compliance Test I-C-LUI-01
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
# Description: Testing instruction 'c.lui'.

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

    # Testcase 0:  imm:0x1f, result rd:x1(0x1f000)
    c.lui x1, 0x1f
    sw  x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x1f000)
    
    # Testcase 1:  imm:0xf, result rd:x1(0xf000)
    c.lui x1, 0xf
    sw  x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xf000)
    
    # Testcase 2:  imm:0x17, result rd:x3(0x17000)
    c.lui x3, 0x17
    sw  x3, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x17000)
    
    # Testcase 3:  imm:0x1b, result rd:x4(0x1b000)
    c.lui x4, 0x1b
    sw  x4, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x1b000)
    
    # Testcase 4:  imm:0x1d, result rd:x5(0x1d000)
    c.lui x5, 0x1d
    sw  x5, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x5, 0x1d000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res

    # Testcase 5:  imm:0x1e, result rd:x6(0x1e000)
    c.lui x6, 0x1e
    sw  x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x1e000)
    
    # Testcase 6:  imm:0x1, result rd:x7(0x1000)
    c.lui x7, 0x1
    sw  x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x1000)
    
    # Testcase 7:  imm:0x10, result rd:x8(0x10000)
    c.lui x8, 0x10
    sw  x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x10000)
    
    # Testcase 8:  imm:0x8, result rd:x9(0x8000)
    c.lui x9, 0x8
    sw  x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x8000)
    
    # Testcase 9:  imm:0x4, result rd:x10(0x4000)
    c.lui x10, 0x4
    sw  x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x4000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res

    # Testcase 10:  imm:0x2, result rd:x11(0x2000)
    c.lui x11, 0x2
    sw  x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x2000)
    
    # Testcase 11:  imm:0x1, result rd:x12(0x1000)
    c.lui x12, 0x1
    sw  x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x1000)
    
    # Testcase 12:  imm:0x1f, result rd:x13(0x1f000)
    c.lui x13, 0x1f
    sw  x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x1f000)
    
    # Testcase 13:  imm:0xf, result rd:x14(0xf000)
    c.lui x14, 0xf
    sw  x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0xf000)
    
    # Testcase 14:  imm:0x17, result rd:x15(0x17000)
    c.lui x15, 0x17
    sw  x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x17000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res

    # Testcase 15:  imm:0x1b, result rd:x16(0x1b000)
    c.lui x16, 0x1b
    sw  x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x1b000)
    
    # Testcase 16:  imm:0x1d, result rd:x17(0x1d000)
    c.lui x17, 0x1d
    sw  x17, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x1d000)
    
    # Testcase 17:  imm:0x1e, result rd:x18(0x1e000)
    c.lui x18, 0x1e
    sw  x18, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x1e000)
    
    # Testcase 18:  imm:0x1, result rd:x19(0x1000)
    c.lui x19, 0x1
    sw  x19, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x1000)
    
    # Testcase 19:  imm:0x10, result rd:x20(0x10000)
    c.lui x20, 0x10
    sw  x20, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x10000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res

    # Testcase 20:  imm:0x8, result rd:x21(0x8000)
    c.lui x21, 0x8
    sw  x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x8000)
    
    # Testcase 21:  imm:0x4, result rd:x22(0x4000)
    c.lui x22, 0x4
    sw  x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x4000)
    
    # Testcase 22:  imm:0x2, result rd:x23(0x2000)
    c.lui x23, 0x2
    sw  x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x2000)
    
    # Testcase 23:  imm:0x1, result rd:x24(0x1000)
    c.lui x24, 0x1
    sw  x24, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x1000)
    
    # Testcase 24:  imm:0x1f, result rd:x25(0x1f000)
    c.lui x25, 0x1f
    sw  x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x1f000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res

    # Testcase 25:  imm:0xf, result rd:x26(0xf000)
    c.lui x26, 0xf
    sw  x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0xf000)
    
    # Testcase 26:  imm:0x17, result rd:x27(0x17000)
    c.lui x27, 0x17
    sw  x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x17000)
    
    # Testcase 27:  imm:0x1b, result rd:x28(0x1b000)
    c.lui x28, 0x1b
    sw  x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x1b000)
    
    # Testcase 28:  imm:0x1d, result rd:x29(0x1d000)
    c.lui x29, 0x1d
    sw  x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x1d000)
    
    # Testcase 29:  imm:0x1e, result rd:x30(0x1e000)
    c.lui x30, 0x1e
    sw  x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x1e000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x2, test_7_res

    # Testcase 30:  imm:0x1, result rd:x31(0x1000)
    c.lui x31, 0x1
    sw  x31, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x1000)
    
    # Testcase 31:  imm:0x10, result rd:x1(0x10000)
    c.lui x1, 0x10
    sw  x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x10000)
    
    # Testcase 32:  imm:0x8, result rd:x1(0x8000)
    c.lui x1, 0x8
    sw  x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x8000)
    
    # Testcase 33:  imm:0x4, result rd:x3(0x4000)
    c.lui x3, 0x4
    sw  x3, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x4000)
    
    # Testcase 34:  imm:0x2, result rd:x4(0x2000)
    c.lui x4, 0x2
    sw  x4, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x4, 0x2000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res

    # Testcase 35:  imm:0x1, result rd:x5(0x1000)
    c.lui x5, 0x1
    sw  x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x1000)
    
    # Testcase 36:  imm:0x1f, result rd:x6(0x1f000)
    c.lui x6, 0x1f
    sw  x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x1f000)
    
    # Testcase 37:  imm:0xf, result rd:x7(0xf000)
    c.lui x7, 0xf
    sw  x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xf000)
    
    # Testcase 38:  imm:0x17, result rd:x8(0x17000)
    c.lui x8, 0x17
    sw  x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x17000)
    
    # Testcase 39:  imm:0x1b, result rd:x9(0x1b000)
    c.lui x9, 0x1b
    sw  x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1b000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res

    # Testcase 40:  imm:0x1d, result rd:x10(0x1d000)
    c.lui x10, 0x1d
    sw  x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1d000)
    
    # Testcase 41:  imm:0x1e, result rd:x11(0x1e000)
    c.lui x11, 0x1e
    sw  x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1e000)
    
    # Testcase 42:  imm:0x1, result rd:x12(0x1000)
    c.lui x12, 0x1
    sw  x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000)
    
    # Testcase 43:  imm:0x10, result rd:x13(0x10000)
    c.lui x13, 0x10
    sw  x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x10000)
    
    # Testcase 44:  imm:0x8, result rd:x14(0x8000)
    c.lui x14, 0x8
    sw  x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x8000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res

    # Testcase 45:  imm:0x4, result rd:x15(0x4000)
    c.lui x15, 0x4
    sw  x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x4000)
    
    # Testcase 46:  imm:0x2, result rd:x16(0x2000)
    c.lui x16, 0x2
    sw  x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x2000)
    
    # Testcase 47:  imm:0x1, result rd:x17(0x1000)
    c.lui x17, 0x1
    sw  x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x1000)
    
    # Testcase 48:  imm:0x1f, result rd:x18(0x1f000)
    c.lui x18, 0x1f
    sw  x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x1f000)
    
    # Testcase 49:  imm:0xf, result rd:x19(0xf000)
    c.lui x19, 0xf
    sw  x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xf000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res

    # Testcase 50:  imm:0x17, result rd:x20(0x17000)
    c.lui x20, 0x17
    sw  x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x17000)
    
    # Testcase 51:  imm:0x1b, result rd:x21(0x1b000)
    c.lui x21, 0x1b
    sw  x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x1b000)
    
    # Testcase 52:  imm:0x1d, result rd:x22(0x1d000)
    c.lui x22, 0x1d
    sw  x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x1d000)
    
    # Testcase 53:  imm:0x1e, result rd:x23(0x1e000)
    c.lui x23, 0x1e
    sw  x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x1e000)
    
    # Testcase 54:  imm:0x1, result rd:x24(0x1000)
    c.lui x24, 0x1
    sw  x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res

    # Testcase 55:  imm:0x10, result rd:x25(0x10000)
    c.lui x25, 0x10
    sw  x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x10000)
    
    # Testcase 56:  imm:0x8, result rd:x26(0x8000)
    c.lui x26, 0x8
    sw  x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x8000)
    
    # Testcase 57:  imm:0x4, result rd:x27(0x4000)
    c.lui x27, 0x4
    sw  x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x4000)
    
    # Testcase 58:  imm:0x2, result rd:x28(0x2000)
    c.lui x28, 0x2
    sw  x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x2000)
    
    # Testcase 59:  imm:0x1, result rd:x29(0x1000)
    c.lui x29, 0x1
    sw  x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res

    # Testcase 60:  imm:0x1f, result rd:x30(0x1f000)
    c.lui x30, 0x1f
    sw  x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x1f000)
    
    # Testcase 61:  imm:0xf, result rd:x31(0xf000)
    c.lui x31, 0xf
    sw  x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xf000)
    
    # Testcase 62:  imm:0x17, result rd:x1(0x17000)
    c.lui x1, 0x17
    sw  x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x17000)
    
    # Testcase 63:  imm:0x1b, result rd:x1(0x1b000)
    c.lui x1, 0x1b
    sw  x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x1b000)
    
    # Testcase 64:  imm:0x1d, result rd:x3(0x1d000)
    c.lui x3, 0x1d
    sw  x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x1d000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res

    # Testcase 65:  imm:0x1e, result rd:x4(0x1e000)
    c.lui x4, 0x1e
    sw  x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x1e000)
    
    # Testcase 66:  imm:0x1, result rd:x5(0x1000)
    c.lui x5, 0x1
    sw  x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x1000)
    
    # Testcase 67:  imm:0x1, result rd:x6(0x1000)
    c.lui x6, 0x1
    sw  x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x1000)
    
    # Testcase 68:  imm:0x1, result rd:x7(0x1000)
    c.lui x7, 0x1
    sw  x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x1000)
    
    # Testcase 69:  imm:0x1, result rd:x8(0x1000)
    c.lui x8, 0x1
    sw  x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res

    # Testcase 70:  imm:0x1, result rd:x9(0x1000)
    c.lui x9, 0x1
    sw  x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1000)
    
    # Testcase 71:  imm:0x1, result rd:x10(0x1000)
    c.lui x10, 0x1
    sw  x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1000)
    
    # Testcase 72:  imm:0x1, result rd:x11(0x1000)
    c.lui x11, 0x1
    sw  x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000)
    
    # Testcase 73:  imm:0x1, result rd:x12(0x1000)
    c.lui x12, 0x1
    sw  x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000)
    
    # Testcase 74:  imm:0x1, result rd:x13(0x1000)
    c.lui x13, 0x1
    sw  x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res

    # Testcase 75:  imm:0x1, result rd:x14(0x1000)
    c.lui x14, 0x1
    sw  x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0x1000)
    
    # Testcase 76:  imm:0x1, result rd:x15(0x1000)
    c.lui x15, 0x1
    sw  x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x1000)
    
    # Testcase 77:  imm:0x1, result rd:x16(0x1000)
    c.lui x16, 0x1
    sw  x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x1000)
    
    # Testcase 78:  imm:0x1, result rd:x17(0x1000)
    c.lui x17, 0x1
    sw  x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x1000)
    
    # Testcase 79:  imm:0x1, result rd:x18(0x1000)
    c.lui x18, 0x1
    sw  x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res

    # Testcase 80:  imm:0x1, result rd:x19(0x1000)
    c.lui x19, 0x1
    sw  x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x1000)
    
    # Testcase 81:  imm:0x1, result rd:x20(0x1000)
    c.lui x20, 0x1
    sw  x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x1000)
    
    # Testcase 82:  imm:0x1, result rd:x21(0x1000)
    c.lui x21, 0x1
    sw  x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x1000)
    
    # Testcase 83:  imm:0x1, result rd:x22(0x1000)
    c.lui x22, 0x1
    sw  x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x1000)
    
    # Testcase 84:  imm:0x1, result rd:x23(0x1000)
    c.lui x23, 0x1
    sw  x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res

    # Testcase 85:  imm:0x1, result rd:x24(0x1000)
    c.lui x24, 0x1
    sw  x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x1000)
    
    # Testcase 86:  imm:0x1, result rd:x25(0x1000)
    c.lui x25, 0x1
    sw  x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x1000)
    
    # Testcase 87:  imm:0x1, result rd:x26(0x1000)
    c.lui x26, 0x1
    sw  x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x1000)
    
    # Testcase 88:  imm:0x1, result rd:x27(0x1000)
    c.lui x27, 0x1
    sw  x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x1000)
    
    # Testcase 89:  imm:0x1, result rd:x28(0x1000)
    c.lui x28, 0x1
    sw  x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res

    # Testcase 90:  imm:0x1, result rd:x29(0x1000)
    c.lui x29, 0x1
    sw  x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x1000)
    
    # Testcase 91:  imm:0x1, result rd:x30(0x1000)
    c.lui x30, 0x1
    sw  x30, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x1000)
    
    # Testcase 92:  imm:0x1, result rd:x31(0x1000)
    c.lui x31, 0x1
    sw  x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x1000)
    
    # Testcase 93:  imm:0x1, result rd:x1(0x1000)
    c.lui x1, 0x1
    sw  x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x1000)
    
    # Testcase 94:  imm:0x1, result rd:x1(0x1000)
    c.lui x1, 0x1
    sw  x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res

    # Testcase 95:  imm:0x1, result rd:x3(0x1000)
    c.lui x3, 0x1
    sw  x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0x1000)
    
    # Testcase 96:  imm:0x1, result rd:x4(0x1000)
    c.lui x4, 0x1
    sw  x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0x1000)
    
    # Testcase 97:  imm:0x1, result rd:x5(0x1000)
    c.lui x5, 0x1
    sw  x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x1000)
    
    # Testcase 98:  imm:0x1, result rd:x6(0x1000)
    c.lui x6, 0x1
    sw  x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x1000)
    
    # Testcase 99:  imm:0x1, result rd:x7(0x1000)
    c.lui x7, 0x1
    sw  x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res

    # Testcase 100:  imm:0x1, result rd:x8(0x1000)
    c.lui x8, 0x1
    sw  x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x1000)
    
    # Testcase 101:  imm:0x1, result rd:x9(0x1000)
    c.lui x9, 0x1
    sw  x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x1000)
    
    # Testcase 102:  imm:0x1, result rd:x10(0x1000)
    c.lui x10, 0x1
    sw  x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x1000)
    
    # Testcase 103:  imm:0x1, result rd:x11(0x1000)
    c.lui x11, 0x1
    sw  x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x1000)
    
    # Testcase 104:  imm:0x1, result rd:x12(0x1000)
    c.lui x12, 0x1
    sw  x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res

    # Testcase 105:  imm:0x1, result rd:x13(0x1000)
    c.lui x13, 0x1
    sw  x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0x1000)
    
    # Testcase 106:  imm:0x1, result rd:x14(0x1000)
    c.lui x14, 0x1
    sw  x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x1000)
    
    # Testcase 107:  imm:0x1, result rd:x15(0x1000)
    c.lui x15, 0x1
    sw  x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x1000)
    
    # Testcase 108:  imm:0x1, result rd:x16(0x1000)
    c.lui x16, 0x1
    sw  x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x1000)
    
    # Testcase 109:  imm:0x1, result rd:x17(0x1000)
    c.lui x17, 0x1
    sw  x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res

    # Testcase 110:  imm:0x1, result rd:x18(0x1000)
    c.lui x18, 0x1
    sw  x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x1000)
    
    # Testcase 111:  imm:0x1, result rd:x19(0x1000)
    c.lui x19, 0x1
    sw  x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x1000)
    
    # Testcase 112:  imm:0x1, result rd:x20(0x1000)
    c.lui x20, 0x1
    sw  x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x1000)
    
    # Testcase 113:  imm:0x1, result rd:x21(0x1000)
    c.lui x21, 0x1
    sw  x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x1000)
    
    # Testcase 114:  imm:0x1, result rd:x22(0x1000)
    c.lui x22, 0x1
    sw  x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res

    # Testcase 115:  imm:0x1, result rd:x23(0x1000)
    c.lui x23, 0x1
    sw  x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x1000)
    
    # Testcase 116:  imm:0x1, result rd:x24(0x1000)
    c.lui x24, 0x1
    sw  x24, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x1000)
    
    # Testcase 117:  imm:0x1, result rd:x25(0x1000)
    c.lui x25, 0x1
    sw  x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x1000)
    
    # Testcase 118:  imm:0x1, result rd:x26(0x1000)
    c.lui x26, 0x1
    sw  x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x1000)
    
    # Testcase 119:  imm:0x1, result rd:x27(0x1000)
    c.lui x27, 0x1
    sw  x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res

    # Testcase 120:  imm:0x1, result rd:x28(0x1000)
    c.lui x28, 0x1
    sw  x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0x1000)
    
    # Testcase 121:  imm:0x1, result rd:x29(0x1000)
    c.lui x29, 0x1
    sw  x29, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0x1000)
    
    # Testcase 122:  imm:0x1, result rd:x30(0x1000)
    c.lui x30, 0x1
    sw  x30, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x1000)
    
    # Testcase 123:  imm:0x1, result rd:x31(0x1000)
    c.lui x31, 0x1
    sw  x31, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x1000)
    
    # Testcase 124:  imm:0x1, result rd:x1(0x1000)
    c.lui x1, 0x1
    sw  x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x2, test_26_res

    # Testcase 125:  imm:0x1, result rd:x1(0x1000)
    c.lui x1, 0x1
    sw  x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x1000)
    
    # Testcase 126:  imm:0x1, result rd:x3(0x1000)
    c.lui x3, 0x1
    sw  x3, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x1000)
    
    # Testcase 127:  imm:0x1, result rd:x4(0x1000)
    c.lui x4, 0x1
    sw  x4, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x1000)
    
    # Testcase 128:  imm:0x1, result rd:x5(0x1000)
    c.lui x5, 0x1
    sw  x5, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x1000)
    
    # Testcase 129:  imm:0x1, result rd:x6(0x1000)
    c.lui x6, 0x1
    sw  x6, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0x1000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x2, test_27_res

    # Testcase 130:  imm:0x1, result rd:x7(0x1000)
    c.lui x7, 0x1
    sw  x7, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x7, 0x1000)
    
    # Testcase 131:  imm:0x1, result rd:x8(0x1000)
    c.lui x8, 0x1
    sw  x8, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x1000)
    
    # Testcase 132:  imm:0x1f, result rd:x9(0x1f000)
    c.lui x9, 0x1f
    sw  x9, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x1f000)
    
    # Testcase 133:  imm:0xf, result rd:x1(0xf000)
    c.lui x1, 0xf
    sw  x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xf000)
    
    # Testcase 134:  imm:0x17, result rd:x11(0x17000)
    c.lui x11, 0x17
    sw  x11, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x17000)
    


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x1, test_28_res

    # Testcase 135:  imm:0x1b, result rd:x12(0x1b000)
    c.lui x12, 0x1b
    sw  x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x1b000)
    


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

