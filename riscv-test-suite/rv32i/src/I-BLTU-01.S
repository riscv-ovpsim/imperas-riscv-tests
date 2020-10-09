# RISC-V Compliance Test I-BLTU-01
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
# Description: Testing instruction 'BLTU'.

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
    
     # Testcase 0:  rs1:x31(0x1), rs2:x16(0xffffffff), result Branch=1
    li x1, 0xcccc
    li x31, 0x1
    li x16, 0xffffffff
    bltu x31, x16, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 1:  rs1:x30(0x2), rs2:x15(0x7fffffff), result Branch=1
    li x1, 0xcccc
    li x30, 0x2
    li x15, 0x7fffffff
    bltu x30, x15, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 2:  rs1:x29(0x4), rs2:x14(0xbfffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x29, 0x4
    li x14, 0xbfffffff
    bltu x29, x14, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 3:  rs1:x28(0x8), rs2:x13(0xdfffffff), result Branch=1
    li x1, 0xcccc
    li x28, 0x8
    li x13, 0xdfffffff
    bltu x28, x13, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 4:  rs1:x27(0x10), rs2:x12(0xefffffff), result Branch=1
    li x1, 0xcccc
    li x27, 0x10
    li x12, 0xefffffff
    bltu x27, x12, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x2, test_2_res
    
     # Testcase 5:  rs1:x26(0x20), rs2:x11(0xf7ffffff), result Branch=1
    li x1, 0xcccc
    li x26, 0x20
    li x11, 0xf7ffffff
    bltu x26, x11, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 6:  rs1:x25(0x40), rs2:x10(0xfbffffff), result Branch=1
    li x1, 0xcccc
    li x25, 0x40
    li x10, 0xfbffffff
    bltu x25, x10, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 7:  rs1:x24(0x80), rs2:x9(0xfdffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x24, 0x80
    li x9, 0xfdffffff
    bltu x24, x9, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 8:  rs1:x23(0x100), rs2:x8(0xfeffffff), result Branch=1
    li x1, 0xcccc
    li x23, 0x100
    li x8, 0xfeffffff
    bltu x23, x8, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 9:  rs1:x22(0x200), rs2:x7(0xff7fffff), result Branch=1
    li x1, 0xcccc
    li x22, 0x200
    li x7, 0xff7fffff
    bltu x22, x7, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x7, test_3_res
    
     # Testcase 10:  rs1:x21(0x400), rs2:x6(0xffbfffff), result Branch=1
    li x1, 0xcccc
    li x21, 0x400
    li x6, 0xffbfffff
    bltu x21, x6, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 11:  rs1:x20(0x800), rs2:x5(0xffdfffff), result Branch=1
    li x1, 0xcccc
    li x20, 0x800
    li x5, 0xffdfffff
    bltu x20, x5, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 12:  rs1:x19(0x1000), rs2:x4(0xffefffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x19, 0x1000
    li x4, 0xffefffff
    bltu x19, x4, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 13:  rs1:x18(0x2000), rs2:x3(0xfff7ffff), result Branch=1
    li x1, 0xcccc
    li x18, 0x2000
    li x3, 0xfff7ffff
    bltu x18, x3, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 14:  rs1:x17(0x4000), rs2:x2(0xfffbffff), result Branch=1
    li x1, 0xcccc
    li x17, 0x4000
    li x2, 0xfffbffff
    bltu x17, x2, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x3, test_4_res
    
     # Testcase 15:  rs1:x16(0x8000), rs2:x1(0xfffdffff), result Branch=1
    li x2, 0xcccc
    li x16, 0x8000
    li x1, 0xfffdffff
    bltu x16, x1, 1f
    li x2, 0x123ab
1: 
    sw x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     # Testcase 16:  rs1:x15(0x10000), rs2:x31(0xfffeffff), result Branch=1
    li x1, 0xcccc
    li x15, 0x10000
    li x31, 0xfffeffff
    bltu x15, x31, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 17:  rs1:x14(0x20000), rs2:x30(0xffff7fff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x14, 0x20000
    li x30, 0xffff7fff
    bltu x14, x30, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 18:  rs1:x13(0x40000), rs2:x29(0xffffbfff), result Branch=1
    li x1, 0xcccc
    li x13, 0x40000
    li x29, 0xffffbfff
    bltu x13, x29, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 19:  rs1:x12(0x80000), rs2:x28(0xffffdfff), result Branch=1
    li x1, 0xcccc
    li x12, 0x80000
    li x28, 0xffffdfff
    bltu x12, x28, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x2, test_5_res
    
     # Testcase 20:  rs1:x11(0x100000), rs2:x27(0xffffefff), result Branch=1
    li x1, 0xcccc
    li x11, 0x100000
    li x27, 0xffffefff
    bltu x11, x27, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 21:  rs1:x10(0x200000), rs2:x26(0xfffff7ff), result Branch=1
    li x1, 0xcccc
    li x10, 0x200000
    li x26, 0xfffff7ff
    bltu x10, x26, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 22:  rs1:x9(0x400000), rs2:x25(0xfffffbff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x9, 0x400000
    li x25, 0xfffffbff
    bltu x9, x25, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 23:  rs1:x8(0x800000), rs2:x24(0xfffffdff), result Branch=1
    li x1, 0xcccc
    li x8, 0x800000
    li x24, 0xfffffdff
    bltu x8, x24, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 24:  rs1:x7(0x1000000), rs2:x23(0xfffffeff), result Branch=1
    li x1, 0xcccc
    li x7, 0x1000000
    li x23, 0xfffffeff
    bltu x7, x23, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x7, test_6_res
    
     # Testcase 25:  rs1:x6(0x2000000), rs2:x22(0xffffff7f), result Branch=1
    li x1, 0xcccc
    li x6, 0x2000000
    li x22, 0xffffff7f
    bltu x6, x22, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 26:  rs1:x5(0x4000000), rs2:x21(0xffffffbf), result Branch=1
    li x1, 0xcccc
    li x5, 0x4000000
    li x21, 0xffffffbf
    bltu x5, x21, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 27:  rs1:x4(0x8000000), rs2:x20(0xffffffdf), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x4, 0x8000000
    li x20, 0xffffffdf
    bltu x4, x20, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 28:  rs1:x3(0x10000000), rs2:x19(0xffffffef), result Branch=1
    li x1, 0xcccc
    li x3, 0x10000000
    li x19, 0xffffffef
    bltu x3, x19, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 29:  rs1:x2(0x20000000), rs2:x18(0xfffffff7), result Branch=1
    li x1, 0xcccc
    li x2, 0x20000000
    li x18, 0xfffffff7
    bltu x2, x18, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x3, test_7_res
    
     # Testcase 30:  rs1:x1(0x40000000), rs2:x17(0xfffffffb), result Branch=1
    li x2, 0xcccc
    li x1, 0x40000000
    li x17, 0xfffffffb
    bltu x1, x17, 1f
    li x2, 0x123ab
1: 
    sw x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     # Testcase 31:  rs1:x31(0x80000000), rs2:x16(0xfffffffd), result Branch=1
    li x1, 0xcccc
    li x31, 0x80000000
    li x16, 0xfffffffd
    bltu x31, x16, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 32:  rs1:x30(0x0), rs2:x15(0xfffffffe), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x30, 0x0
    li x15, 0xfffffffe
    bltu x30, x15, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 33:  rs1:x29(0xfffffffe), rs2:x14(0x0), result Branch=0
    li x1, 0xcccc
    li x29, 0xfffffffe
    li x14, 0x0
    bltu x29, x14, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 34:  rs1:x28(0xfffffffd), rs2:x13(0x80000000), result Branch=0
    li x1, 0xcccc
    li x28, 0xfffffffd
    li x13, 0x80000000
    bltu x28, x13, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x2, test_8_res
    
     # Testcase 35:  rs1:x27(0xfffffffb), rs2:x12(0x40000000), result Branch=0
    li x1, 0xcccc
    li x27, 0xfffffffb
    li x12, 0x40000000
    bltu x27, x12, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 36:  rs1:x26(0xfffffff7), rs2:x11(0x20000000), result Branch=0
    li x1, 0xcccc
    li x26, 0xfffffff7
    li x11, 0x20000000
    bltu x26, x11, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 37:  rs1:x25(0xffffffef), rs2:x10(0x10000000), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x25, 0xffffffef
    li x10, 0x10000000
    bltu x25, x10, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 38:  rs1:x24(0xffffffdf), rs2:x9(0x8000000), result Branch=0
    li x1, 0xcccc
    li x24, 0xffffffdf
    li x9, 0x8000000
    bltu x24, x9, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 39:  rs1:x23(0xffffffbf), rs2:x8(0x4000000), result Branch=0
    li x1, 0xcccc
    li x23, 0xffffffbf
    li x8, 0x4000000
    bltu x23, x8, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x2, test_9_res
    
     # Testcase 40:  rs1:x22(0xffffff7f), rs2:x7(0x2000000), result Branch=0
    li x1, 0xcccc
    li x22, 0xffffff7f
    li x7, 0x2000000
    bltu x22, x7, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 41:  rs1:x21(0xfffffeff), rs2:x6(0x1000000), result Branch=0
    li x1, 0xcccc
    li x21, 0xfffffeff
    li x6, 0x1000000
    bltu x21, x6, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 42:  rs1:x20(0xfffffdff), rs2:x5(0x800000), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x20, 0xfffffdff
    li x5, 0x800000
    bltu x20, x5, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 43:  rs1:x19(0xfffffbff), rs2:x4(0x400000), result Branch=0
    li x1, 0xcccc
    li x19, 0xfffffbff
    li x4, 0x400000
    bltu x19, x4, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 44:  rs1:x18(0xfffff7ff), rs2:x3(0x200000), result Branch=0
    li x1, 0xcccc
    li x18, 0xfffff7ff
    li x3, 0x200000
    bltu x18, x3, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res
    
     # Testcase 45:  rs1:x17(0xffffefff), rs2:x2(0x100000), result Branch=0
    li x1, 0xcccc
    li x17, 0xffffefff
    li x2, 0x100000
    bltu x17, x2, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 46:  rs1:x16(0xffffdfff), rs2:x1(0x80000), result Branch=0
    li x2, 0xcccc
    li x16, 0xffffdfff
    li x1, 0x80000
    bltu x16, x1, 2f
    li x2, 0x123ab
2: 
    sw x2, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0x123ab)

     # Testcase 47:  rs1:x15(0xffffbfff), rs2:x31(0x40000), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x15, 0xffffbfff
    li x31, 0x40000
    bltu x15, x31, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 48:  rs1:x14(0xffff7fff), rs2:x30(0x20000), result Branch=0
    li x1, 0xcccc
    li x14, 0xffff7fff
    li x30, 0x20000
    bltu x14, x30, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 49:  rs1:x13(0xfffeffff), rs2:x29(0x10000), result Branch=0
    li x1, 0xcccc
    li x13, 0xfffeffff
    li x29, 0x10000
    bltu x13, x29, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x2, test_11_res
    
     # Testcase 50:  rs1:x12(0xfffdffff), rs2:x28(0x8000), result Branch=0
    li x1, 0xcccc
    li x12, 0xfffdffff
    li x28, 0x8000
    bltu x12, x28, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 51:  rs1:x11(0xfffbffff), rs2:x27(0x4000), result Branch=0
    li x1, 0xcccc
    li x11, 0xfffbffff
    li x27, 0x4000
    bltu x11, x27, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 52:  rs1:x10(0xfff7ffff), rs2:x26(0x2000), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x10, 0xfff7ffff
    li x26, 0x2000
    bltu x10, x26, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 53:  rs1:x9(0xffefffff), rs2:x25(0x1000), result Branch=0
    li x1, 0xcccc
    li x9, 0xffefffff
    li x25, 0x1000
    bltu x9, x25, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 54:  rs1:x8(0xffdfffff), rs2:x24(0x800), result Branch=0
    li x1, 0xcccc
    li x8, 0xffdfffff
    li x24, 0x800
    bltu x8, x24, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x2, test_12_res
    
     # Testcase 55:  rs1:x7(0xffbfffff), rs2:x23(0x400), result Branch=0
    li x1, 0xcccc
    li x7, 0xffbfffff
    li x23, 0x400
    bltu x7, x23, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 56:  rs1:x6(0xff7fffff), rs2:x22(0x200), result Branch=0
    li x1, 0xcccc
    li x6, 0xff7fffff
    li x22, 0x200
    bltu x6, x22, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 57:  rs1:x5(0xfeffffff), rs2:x21(0x100), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x5, 0xfeffffff
    li x21, 0x100
    bltu x5, x21, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 58:  rs1:x4(0xfdffffff), rs2:x20(0x80), result Branch=0
    li x1, 0xcccc
    li x4, 0xfdffffff
    li x20, 0x80
    bltu x4, x20, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 59:  rs1:x3(0xfbffffff), rs2:x19(0x40), result Branch=0
    li x1, 0xcccc
    li x3, 0xfbffffff
    li x19, 0x40
    bltu x3, x19, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x3, test_13_res
    
     # Testcase 60:  rs1:x2(0xf7ffffff), rs2:x18(0x20), result Branch=0
    li x1, 0xcccc
    li x2, 0xf7ffffff
    li x18, 0x20
    bltu x2, x18, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 61:  rs1:x1(0xefffffff), rs2:x17(0x10), result Branch=0
    li x2, 0xcccc
    li x1, 0xefffffff
    li x17, 0x10
    bltu x1, x17, 2f
    li x2, 0x123ab
2: 
    sw x2, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0x123ab)

     # Testcase 62:  rs1:x31(0xdfffffff), rs2:x16(0x8), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x31, 0xdfffffff
    li x16, 0x8
    bltu x31, x16, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 63:  rs1:x30(0xbfffffff), rs2:x15(0x4), result Branch=0
    li x1, 0xcccc
    li x30, 0xbfffffff
    li x15, 0x4
    bltu x30, x15, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 64:  rs1:x29(0x7fffffff), rs2:x14(0x2), result Branch=0
    li x1, 0xcccc
    li x29, 0x7fffffff
    li x14, 0x2
    bltu x29, x14, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x2, test_14_res
    
     # Testcase 65:  rs1:x28(0xffffffff), rs2:x13(0x1), result Branch=0
    li x1, 0xcccc
    li x28, 0xffffffff
    li x13, 0x1
    bltu x28, x13, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 66:  rs1:x27(0x1), rs2:x12(0x0), result Branch=0
    li x1, 0xcccc
    li x27, 0x1
    li x12, 0x0
    bltu x27, x12, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 67:  rs1:x26(0x2), rs2:x11(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x26, 0x2
    li x11, 0x0
    bltu x26, x11, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 68:  rs1:x25(0x4), rs2:x10(0x0), result Branch=0
    li x1, 0xcccc
    li x25, 0x4
    li x10, 0x0
    bltu x25, x10, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 69:  rs1:x24(0x8), rs2:x9(0x0), result Branch=0
    li x1, 0xcccc
    li x24, 0x8
    li x9, 0x0
    bltu x24, x9, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x2, test_15_res
    
     # Testcase 70:  rs1:x23(0x10), rs2:x8(0x0), result Branch=0
    li x1, 0xcccc
    li x23, 0x10
    li x8, 0x0
    bltu x23, x8, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 71:  rs1:x22(0x20), rs2:x7(0x0), result Branch=0
    li x1, 0xcccc
    li x22, 0x20
    li x7, 0x0
    bltu x22, x7, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 72:  rs1:x21(0x40), rs2:x6(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x21, 0x40
    li x6, 0x0
    bltu x21, x6, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 73:  rs1:x20(0x80), rs2:x5(0x0), result Branch=0
    li x1, 0xcccc
    li x20, 0x80
    li x5, 0x0
    bltu x20, x5, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 74:  rs1:x19(0x100), rs2:x4(0x0), result Branch=0
    li x1, 0xcccc
    li x19, 0x100
    li x4, 0x0
    bltu x19, x4, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res
    
     # Testcase 75:  rs1:x18(0x200), rs2:x3(0x0), result Branch=0
    li x1, 0xcccc
    li x18, 0x200
    li x3, 0x0
    bltu x18, x3, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x123ab)

     # Testcase 76:  rs1:x17(0x400), rs2:x2(0x0), result Branch=0
    li x1, 0xcccc
    li x17, 0x400
    li x2, 0x0
    bltu x17, x2, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x123ab)

     # Testcase 77:  rs1:x16(0x800), rs2:x1(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x2, 0xcccc
    li x16, 0x800
    li x1, 0x0
    bltu x16, x1, 2b
    li x2, 0x123ab
4:
    sw x2, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x123ab)

     # Testcase 78:  rs1:x15(0x1000), rs2:x31(0x0), result Branch=0
    li x1, 0xcccc
    li x15, 0x1000
    li x31, 0x0
    bltu x15, x31, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x123ab)

     # Testcase 79:  rs1:x14(0x2000), rs2:x30(0x0), result Branch=0
    li x1, 0xcccc
    li x14, 0x2000
    li x30, 0x0
    bltu x14, x30, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x2, test_17_res
    
     # Testcase 80:  rs1:x13(0x4000), rs2:x29(0x0), result Branch=0
    li x1, 0xcccc
    li x13, 0x4000
    li x29, 0x0
    bltu x13, x29, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 81:  rs1:x12(0x8000), rs2:x28(0x0), result Branch=0
    li x1, 0xcccc
    li x12, 0x8000
    li x28, 0x0
    bltu x12, x28, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 82:  rs1:x11(0x10000), rs2:x27(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x11, 0x10000
    li x27, 0x0
    bltu x11, x27, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 83:  rs1:x10(0x20000), rs2:x26(0x0), result Branch=0
    li x1, 0xcccc
    li x10, 0x20000
    li x26, 0x0
    bltu x10, x26, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 84:  rs1:x9(0x40000), rs2:x25(0x0), result Branch=0
    li x1, 0xcccc
    li x9, 0x40000
    li x25, 0x0
    bltu x9, x25, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x2, test_18_res
    
     # Testcase 85:  rs1:x8(0x80000), rs2:x24(0x0), result Branch=0
    li x1, 0xcccc
    li x8, 0x80000
    li x24, 0x0
    bltu x8, x24, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 86:  rs1:x7(0x100000), rs2:x23(0x0), result Branch=0
    li x1, 0xcccc
    li x7, 0x100000
    li x23, 0x0
    bltu x7, x23, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 87:  rs1:x6(0x200000), rs2:x22(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x6, 0x200000
    li x22, 0x0
    bltu x6, x22, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 88:  rs1:x5(0x400000), rs2:x21(0x0), result Branch=0
    li x1, 0xcccc
    li x5, 0x400000
    li x21, 0x0
    bltu x5, x21, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 89:  rs1:x4(0x800000), rs2:x20(0x0), result Branch=0
    li x1, 0xcccc
    li x4, 0x800000
    li x20, 0x0
    bltu x4, x20, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res
    
     # Testcase 90:  rs1:x3(0x1000000), rs2:x19(0x0), result Branch=0
    li x1, 0xcccc
    li x3, 0x1000000
    li x19, 0x0
    bltu x3, x19, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x123ab)

     # Testcase 91:  rs1:x2(0x2000000), rs2:x18(0x0), result Branch=0
    li x1, 0xcccc
    li x2, 0x2000000
    li x18, 0x0
    bltu x2, x18, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x123ab)

     # Testcase 92:  rs1:x1(0x4000000), rs2:x17(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x2, 0xcccc
    li x1, 0x4000000
    li x17, 0x0
    bltu x1, x17, 2b
    li x2, 0x123ab
4:
    sw x2, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x123ab)

     # Testcase 93:  rs1:x31(0x8000000), rs2:x16(0x0), result Branch=0
    li x1, 0xcccc
    li x31, 0x8000000
    li x16, 0x0
    bltu x31, x16, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x123ab)

     # Testcase 94:  rs1:x30(0x10000000), rs2:x15(0x0), result Branch=0
    li x1, 0xcccc
    li x30, 0x10000000
    li x15, 0x0
    bltu x30, x15, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x2, test_20_res
    
     # Testcase 95:  rs1:x29(0x20000000), rs2:x14(0x0), result Branch=0
    li x1, 0xcccc
    li x29, 0x20000000
    li x14, 0x0
    bltu x29, x14, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 96:  rs1:x28(0x40000000), rs2:x13(0x0), result Branch=0
    li x1, 0xcccc
    li x28, 0x40000000
    li x13, 0x0
    bltu x28, x13, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 97:  rs1:x27(0x80000000), rs2:x12(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x27, 0x80000000
    li x12, 0x0
    bltu x27, x12, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 98:  rs1:x26(0x0), rs2:x11(0x0), result Branch=0
    li x1, 0xcccc
    li x26, 0x0
    li x11, 0x0
    bltu x26, x11, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 99:  rs1:x25(0xfffffffe), rs2:x10(0x0), result Branch=0
    li x1, 0xcccc
    li x25, 0xfffffffe
    li x10, 0x0
    bltu x25, x10, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x2, test_21_res
    
     # Testcase 100:  rs1:x24(0xfffffffd), rs2:x9(0x0), result Branch=0
    li x1, 0xcccc
    li x24, 0xfffffffd
    li x9, 0x0
    bltu x24, x9, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 101:  rs1:x23(0xfffffffb), rs2:x8(0x0), result Branch=0
    li x1, 0xcccc
    li x23, 0xfffffffb
    li x8, 0x0
    bltu x23, x8, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 102:  rs1:x22(0xfffffff7), rs2:x7(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x22, 0xfffffff7
    li x7, 0x0
    bltu x22, x7, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 103:  rs1:x21(0xffffffef), rs2:x6(0x0), result Branch=0
    li x1, 0xcccc
    li x21, 0xffffffef
    li x6, 0x0
    bltu x21, x6, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 104:  rs1:x20(0xffffffdf), rs2:x5(0x0), result Branch=0
    li x1, 0xcccc
    li x20, 0xffffffdf
    li x5, 0x0
    bltu x20, x5, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res
    
     # Testcase 105:  rs1:x19(0xffffffbf), rs2:x4(0x0), result Branch=0
    li x1, 0xcccc
    li x19, 0xffffffbf
    li x4, 0x0
    bltu x19, x4, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x123ab)

     # Testcase 106:  rs1:x18(0xffffff7f), rs2:x3(0x0), result Branch=0
    li x1, 0xcccc
    li x18, 0xffffff7f
    li x3, 0x0
    bltu x18, x3, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x123ab)

     # Testcase 107:  rs1:x17(0xfffffeff), rs2:x2(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x17, 0xfffffeff
    li x2, 0x0
    bltu x17, x2, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x123ab)

     # Testcase 108:  rs1:x16(0xfffffdff), rs2:x1(0x0), result Branch=0
    li x2, 0xcccc
    li x16, 0xfffffdff
    li x1, 0x0
    bltu x16, x1, 4f
    li x2, 0x123ab
4: 
    sw x2, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x123ab)

     # Testcase 109:  rs1:x15(0xfffffbff), rs2:x31(0x0), result Branch=0
    li x1, 0xcccc
    li x15, 0xfffffbff
    li x31, 0x0
    bltu x15, x31, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x2, test_23_res
    
     # Testcase 110:  rs1:x14(0xfffff7ff), rs2:x30(0x0), result Branch=0
    li x1, 0xcccc
    li x14, 0xfffff7ff
    li x30, 0x0
    bltu x14, x30, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 111:  rs1:x13(0xffffefff), rs2:x29(0x0), result Branch=0
    li x1, 0xcccc
    li x13, 0xffffefff
    li x29, 0x0
    bltu x13, x29, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 112:  rs1:x12(0xffffdfff), rs2:x28(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x12, 0xffffdfff
    li x28, 0x0
    bltu x12, x28, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 113:  rs1:x11(0xffffbfff), rs2:x27(0x0), result Branch=0
    li x1, 0xcccc
    li x11, 0xffffbfff
    li x27, 0x0
    bltu x11, x27, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 114:  rs1:x10(0xffff7fff), rs2:x26(0x0), result Branch=0
    li x1, 0xcccc
    li x10, 0xffff7fff
    li x26, 0x0
    bltu x10, x26, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x2, test_24_res
    
     # Testcase 115:  rs1:x9(0xfffeffff), rs2:x25(0x0), result Branch=0
    li x1, 0xcccc
    li x9, 0xfffeffff
    li x25, 0x0
    bltu x9, x25, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 116:  rs1:x8(0xfffdffff), rs2:x24(0x0), result Branch=0
    li x1, 0xcccc
    li x8, 0xfffdffff
    li x24, 0x0
    bltu x8, x24, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 117:  rs1:x7(0xfffbffff), rs2:x23(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x7, 0xfffbffff
    li x23, 0x0
    bltu x7, x23, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 118:  rs1:x6(0xfff7ffff), rs2:x22(0x0), result Branch=0
    li x1, 0xcccc
    li x6, 0xfff7ffff
    li x22, 0x0
    bltu x6, x22, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 119:  rs1:x5(0xffefffff), rs2:x21(0x0), result Branch=0
    li x1, 0xcccc
    li x5, 0xffefffff
    li x21, 0x0
    bltu x5, x21, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res
    
     # Testcase 120:  rs1:x4(0xffdfffff), rs2:x20(0x0), result Branch=0
    li x1, 0xcccc
    li x4, 0xffdfffff
    li x20, 0x0
    bltu x4, x20, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x123ab)

     # Testcase 121:  rs1:x3(0xffbfffff), rs2:x19(0x0), result Branch=0
    li x1, 0xcccc
    li x3, 0xffbfffff
    li x19, 0x0
    bltu x3, x19, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x123ab)

     # Testcase 122:  rs1:x2(0xff7fffff), rs2:x18(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x2, 0xff7fffff
    li x18, 0x0
    bltu x2, x18, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x123ab)

     # Testcase 123:  rs1:x1(0xfeffffff), rs2:x17(0x0), result Branch=0
    li x2, 0xcccc
    li x1, 0xfeffffff
    li x17, 0x0
    bltu x1, x17, 4f
    li x2, 0x123ab
4: 
    sw x2, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x123ab)

     # Testcase 124:  rs1:x31(0xfdffffff), rs2:x16(0x0), result Branch=0
    li x1, 0xcccc
    li x31, 0xfdffffff
    li x16, 0x0
    bltu x31, x16, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x2, test_26_res
    
     # Testcase 125:  rs1:x30(0xfbffffff), rs2:x15(0x0), result Branch=0
    li x1, 0xcccc
    li x30, 0xfbffffff
    li x15, 0x0
    bltu x30, x15, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 126:  rs1:x29(0xf7ffffff), rs2:x14(0x0), result Branch=0
    li x1, 0xcccc
    li x29, 0xf7ffffff
    li x14, 0x0
    bltu x29, x14, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 127:  rs1:x28(0xefffffff), rs2:x13(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x28, 0xefffffff
    li x13, 0x0
    bltu x28, x13, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 128:  rs1:x27(0xdfffffff), rs2:x12(0x0), result Branch=0
    li x1, 0xcccc
    li x27, 0xdfffffff
    li x12, 0x0
    bltu x27, x12, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 129:  rs1:x26(0xbfffffff), rs2:x11(0x0), result Branch=0
    li x1, 0xcccc
    li x26, 0xbfffffff
    li x11, 0x0
    bltu x26, x11, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x2, test_27_res
    
     # Testcase 130:  rs1:x25(0x7fffffff), rs2:x10(0x0), result Branch=0
    li x1, 0xcccc
    li x25, 0x7fffffff
    li x10, 0x0
    bltu x25, x10, 1f
    li x1, 0x123ab
1: 
    sw x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 131:  rs1:x24(0xffffffff), rs2:x9(0x0), result Branch=0
    li x1, 0xcccc
    li x24, 0xffffffff
    li x9, 0x0
    bltu x24, x9, 2f
    li x1, 0x123ab
2: 
    sw x1, 4(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 132:  rs1:x23(0x1), rs2:x8(0xffffffff), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x23, 0x1
    li x8, 0xffffffff
    bltu x23, x8, 2b
    li x1, 0x123ab
4:
    sw x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 133:  rs1:x22(0x2), rs2:x7(0x7fffffff), result Branch=1
    li x1, 0xcccc
    li x22, 0x2
    li x7, 0x7fffffff
    bltu x22, x7, 4f
    li x1, 0x123ab
4: 
    sw x1, 12(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 134:  rs1:x21(0x4), rs2:x0(0xbfffffff), result Branch=0
    li x1, 0xcccc
    li x21, 0x4
    li x0, 0xbfffffff
    bltu x21, x0, 5f
    li x1, 0x123ab
5: 
    sw x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x2, test_28_res
    
     # Testcase 135:  rs1:x0(0x8), rs2:x5(0xdfffffff), result Branch=1
    li x1, 0xcccc
    li x0, 0x8
    li x5, 0xdfffffff
    bltu x0, x5, 1f
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

