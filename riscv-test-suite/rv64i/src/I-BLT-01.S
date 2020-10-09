# RISC-V Compliance Test I-BLT-01
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
# Description: Testing instruction 'BLT'.

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
    
     # Testcase 0:  rs1:x31(0x1), rs2:x16(0xffffffffffffffff), result Branch=0
    li x1, 0xcccc
    li x31, 0x1
    li x16, 0xffffffffffffffff
    blt x31, x16, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 1:  rs1:x30(0x2), rs2:x15(0x7fffffffffffffff), result Branch=1
    li x1, 0xcccc
    li x30, 0x2
    li x15, 0x7fffffffffffffff
    blt x30, x15, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 2:  rs1:x29(0x4), rs2:x14(0xbfffffffffffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x29, 0x4
    li x14, 0xbfffffffffffffff
    blt x29, x14, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 3:  rs1:x28(0x8), rs2:x13(0xdfffffffffffffff), result Branch=0
    li x1, 0xcccc
    li x28, 0x8
    li x13, 0xdfffffffffffffff
    blt x28, x13, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 4:  rs1:x27(0x10), rs2:x12(0xefffffffffffffff), result Branch=0
    li x1, 0xcccc
    li x27, 0x10
    li x12, 0xefffffffffffffff
    blt x27, x12, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x2, test_2_res
    
     # Testcase 5:  rs1:x26(0x20), rs2:x11(0xf7ffffffffffffff), result Branch=0
    li x1, 0xcccc
    li x26, 0x20
    li x11, 0xf7ffffffffffffff
    blt x26, x11, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 6:  rs1:x25(0x40), rs2:x10(0xfbffffffffffffff), result Branch=0
    li x1, 0xcccc
    li x25, 0x40
    li x10, 0xfbffffffffffffff
    blt x25, x10, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 7:  rs1:x24(0x80), rs2:x9(0xfdffffffffffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x24, 0x80
    li x9, 0xfdffffffffffffff
    blt x24, x9, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 8:  rs1:x23(0x100), rs2:x8(0xfeffffffffffffff), result Branch=0
    li x1, 0xcccc
    li x23, 0x100
    li x8, 0xfeffffffffffffff
    blt x23, x8, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 9:  rs1:x22(0x200), rs2:x7(0xff7fffffffffffff), result Branch=0
    li x1, 0xcccc
    li x22, 0x200
    li x7, 0xff7fffffffffffff
    blt x22, x7, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x7, test_3_res
    
     # Testcase 10:  rs1:x21(0x400), rs2:x6(0xffbfffffffffffff), result Branch=0
    li x1, 0xcccc
    li x21, 0x400
    li x6, 0xffbfffffffffffff
    blt x21, x6, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 11:  rs1:x20(0x800), rs2:x5(0xffdfffffffffffff), result Branch=0
    li x1, 0xcccc
    li x20, 0x800
    li x5, 0xffdfffffffffffff
    blt x20, x5, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 12:  rs1:x19(0x1000), rs2:x4(0xffefffffffffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x19, 0x1000
    li x4, 0xffefffffffffffff
    blt x19, x4, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 13:  rs1:x18(0x2000), rs2:x3(0xfff7ffffffffffff), result Branch=0
    li x1, 0xcccc
    li x18, 0x2000
    li x3, 0xfff7ffffffffffff
    blt x18, x3, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 14:  rs1:x17(0x4000), rs2:x2(0xfffbffffffffffff), result Branch=0
    li x1, 0xcccc
    li x17, 0x4000
    li x2, 0xfffbffffffffffff
    blt x17, x2, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x3, test_4_res
    
     # Testcase 15:  rs1:x16(0x8000), rs2:x1(0xfffdffffffffffff), result Branch=0
    li x2, 0xcccc
    li x16, 0x8000
    li x1, 0xfffdffffffffffff
    blt x16, x1, 1f
    li x2, 0x123ab
1: 
    sd x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0x123ab)

     # Testcase 16:  rs1:x15(0x10000), rs2:x31(0xfffeffffffffffff), result Branch=0
    li x1, 0xcccc
    li x15, 0x10000
    li x31, 0xfffeffffffffffff
    blt x15, x31, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 17:  rs1:x14(0x20000), rs2:x30(0xffff7fffffffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x14, 0x20000
    li x30, 0xffff7fffffffffff
    blt x14, x30, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 18:  rs1:x13(0x40000), rs2:x29(0xffffbfffffffffff), result Branch=0
    li x1, 0xcccc
    li x13, 0x40000
    li x29, 0xffffbfffffffffff
    blt x13, x29, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 19:  rs1:x12(0x80000), rs2:x28(0xffffdfffffffffff), result Branch=0
    li x1, 0xcccc
    li x12, 0x80000
    li x28, 0xffffdfffffffffff
    blt x12, x28, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x2, test_5_res
    
     # Testcase 20:  rs1:x11(0x100000), rs2:x27(0xffffefffffffffff), result Branch=0
    li x1, 0xcccc
    li x11, 0x100000
    li x27, 0xffffefffffffffff
    blt x11, x27, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 21:  rs1:x10(0x200000), rs2:x26(0xfffff7ffffffffff), result Branch=0
    li x1, 0xcccc
    li x10, 0x200000
    li x26, 0xfffff7ffffffffff
    blt x10, x26, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 22:  rs1:x9(0x400000), rs2:x25(0xfffffbffffffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x9, 0x400000
    li x25, 0xfffffbffffffffff
    blt x9, x25, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 23:  rs1:x8(0x800000), rs2:x24(0xfffffdffffffffff), result Branch=0
    li x1, 0xcccc
    li x8, 0x800000
    li x24, 0xfffffdffffffffff
    blt x8, x24, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 24:  rs1:x7(0x1000000), rs2:x23(0xfffffeffffffffff), result Branch=0
    li x1, 0xcccc
    li x7, 0x1000000
    li x23, 0xfffffeffffffffff
    blt x7, x23, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x7, test_6_res
    
     # Testcase 25:  rs1:x6(0x2000000), rs2:x22(0xffffff7fffffffff), result Branch=0
    li x1, 0xcccc
    li x6, 0x2000000
    li x22, 0xffffff7fffffffff
    blt x6, x22, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 26:  rs1:x5(0x4000000), rs2:x21(0xffffffbfffffffff), result Branch=0
    li x1, 0xcccc
    li x5, 0x4000000
    li x21, 0xffffffbfffffffff
    blt x5, x21, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 27:  rs1:x4(0x8000000), rs2:x20(0xffffffdfffffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x4, 0x8000000
    li x20, 0xffffffdfffffffff
    blt x4, x20, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 28:  rs1:x3(0x10000000), rs2:x19(0xffffffefffffffff), result Branch=0
    li x1, 0xcccc
    li x3, 0x10000000
    li x19, 0xffffffefffffffff
    blt x3, x19, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 29:  rs1:x2(0x20000000), rs2:x18(0xfffffff7ffffffff), result Branch=0
    li x1, 0xcccc
    li x2, 0x20000000
    li x18, 0xfffffff7ffffffff
    blt x2, x18, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x3, test_7_res
    
     # Testcase 30:  rs1:x1(0x40000000), rs2:x17(0xfffffffbffffffff), result Branch=0
    li x2, 0xcccc
    li x1, 0x40000000
    li x17, 0xfffffffbffffffff
    blt x1, x17, 1f
    li x2, 0x123ab
1: 
    sd x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0x123ab)

     # Testcase 31:  rs1:x31(0x80000000), rs2:x16(0xfffffffdffffffff), result Branch=0
    li x1, 0xcccc
    li x31, 0x80000000
    li x16, 0xfffffffdffffffff
    blt x31, x16, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 32:  rs1:x30(0x100000000), rs2:x15(0xfffffffeffffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x30, 0x100000000
    li x15, 0xfffffffeffffffff
    blt x30, x15, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 33:  rs1:x29(0x200000000), rs2:x14(0xffffffff7fffffff), result Branch=0
    li x1, 0xcccc
    li x29, 0x200000000
    li x14, 0xffffffff7fffffff
    blt x29, x14, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 34:  rs1:x28(0x400000000), rs2:x13(0xffffffffbfffffff), result Branch=0
    li x1, 0xcccc
    li x28, 0x400000000
    li x13, 0xffffffffbfffffff
    blt x28, x13, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x2, test_8_res
    
     # Testcase 35:  rs1:x27(0x800000000), rs2:x12(0xffffffffdfffffff), result Branch=0
    li x1, 0xcccc
    li x27, 0x800000000
    li x12, 0xffffffffdfffffff
    blt x27, x12, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 36:  rs1:x26(0x1000000000), rs2:x11(0xffffffffefffffff), result Branch=0
    li x1, 0xcccc
    li x26, 0x1000000000
    li x11, 0xffffffffefffffff
    blt x26, x11, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 37:  rs1:x25(0x2000000000), rs2:x10(0xfffffffff7ffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x25, 0x2000000000
    li x10, 0xfffffffff7ffffff
    blt x25, x10, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 38:  rs1:x24(0x4000000000), rs2:x9(0xfffffffffbffffff), result Branch=0
    li x1, 0xcccc
    li x24, 0x4000000000
    li x9, 0xfffffffffbffffff
    blt x24, x9, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 39:  rs1:x23(0x8000000000), rs2:x8(0xfffffffffdffffff), result Branch=0
    li x1, 0xcccc
    li x23, 0x8000000000
    li x8, 0xfffffffffdffffff
    blt x23, x8, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x2, test_9_res
    
     # Testcase 40:  rs1:x22(0x10000000000), rs2:x7(0xfffffffffeffffff), result Branch=0
    li x1, 0xcccc
    li x22, 0x10000000000
    li x7, 0xfffffffffeffffff
    blt x22, x7, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 41:  rs1:x21(0x20000000000), rs2:x6(0xffffffffff7fffff), result Branch=0
    li x1, 0xcccc
    li x21, 0x20000000000
    li x6, 0xffffffffff7fffff
    blt x21, x6, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 42:  rs1:x20(0x40000000000), rs2:x5(0xffffffffffbfffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x20, 0x40000000000
    li x5, 0xffffffffffbfffff
    blt x20, x5, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 43:  rs1:x19(0x80000000000), rs2:x4(0xffffffffffdfffff), result Branch=0
    li x1, 0xcccc
    li x19, 0x80000000000
    li x4, 0xffffffffffdfffff
    blt x19, x4, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 44:  rs1:x18(0x100000000000), rs2:x3(0xffffffffffefffff), result Branch=0
    li x1, 0xcccc
    li x18, 0x100000000000
    li x3, 0xffffffffffefffff
    blt x18, x3, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res
    
     # Testcase 45:  rs1:x17(0x200000000000), rs2:x2(0xfffffffffff7ffff), result Branch=0
    li x1, 0xcccc
    li x17, 0x200000000000
    li x2, 0xfffffffffff7ffff
    blt x17, x2, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 46:  rs1:x16(0x400000000000), rs2:x1(0xfffffffffffbffff), result Branch=0
    li x2, 0xcccc
    li x16, 0x400000000000
    li x1, 0xfffffffffffbffff
    blt x16, x1, 2f
    li x2, 0x123ab
2: 
    sd x2, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0x123ab)

     # Testcase 47:  rs1:x15(0x800000000000), rs2:x31(0xfffffffffffdffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x15, 0x800000000000
    li x31, 0xfffffffffffdffff
    blt x15, x31, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 48:  rs1:x14(0x1000000000000), rs2:x30(0xfffffffffffeffff), result Branch=0
    li x1, 0xcccc
    li x14, 0x1000000000000
    li x30, 0xfffffffffffeffff
    blt x14, x30, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 49:  rs1:x13(0x2000000000000), rs2:x29(0xffffffffffff7fff), result Branch=0
    li x1, 0xcccc
    li x13, 0x2000000000000
    li x29, 0xffffffffffff7fff
    blt x13, x29, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x2, test_11_res
    
     # Testcase 50:  rs1:x12(0x4000000000000), rs2:x28(0xffffffffffffbfff), result Branch=0
    li x1, 0xcccc
    li x12, 0x4000000000000
    li x28, 0xffffffffffffbfff
    blt x12, x28, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 51:  rs1:x11(0x8000000000000), rs2:x27(0xffffffffffffdfff), result Branch=0
    li x1, 0xcccc
    li x11, 0x8000000000000
    li x27, 0xffffffffffffdfff
    blt x11, x27, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 52:  rs1:x10(0x10000000000000), rs2:x26(0xffffffffffffefff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x10, 0x10000000000000
    li x26, 0xffffffffffffefff
    blt x10, x26, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 53:  rs1:x9(0x20000000000000), rs2:x25(0xfffffffffffff7ff), result Branch=0
    li x1, 0xcccc
    li x9, 0x20000000000000
    li x25, 0xfffffffffffff7ff
    blt x9, x25, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 54:  rs1:x8(0x40000000000000), rs2:x24(0xfffffffffffffbff), result Branch=0
    li x1, 0xcccc
    li x8, 0x40000000000000
    li x24, 0xfffffffffffffbff
    blt x8, x24, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x2, test_12_res
    
     # Testcase 55:  rs1:x7(0x80000000000000), rs2:x23(0xfffffffffffffdff), result Branch=0
    li x1, 0xcccc
    li x7, 0x80000000000000
    li x23, 0xfffffffffffffdff
    blt x7, x23, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 56:  rs1:x6(0x100000000000000), rs2:x22(0xfffffffffffffeff), result Branch=0
    li x1, 0xcccc
    li x6, 0x100000000000000
    li x22, 0xfffffffffffffeff
    blt x6, x22, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 57:  rs1:x5(0x200000000000000), rs2:x21(0xffffffffffffff7f), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x5, 0x200000000000000
    li x21, 0xffffffffffffff7f
    blt x5, x21, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 58:  rs1:x4(0x400000000000000), rs2:x20(0xffffffffffffffbf), result Branch=0
    li x1, 0xcccc
    li x4, 0x400000000000000
    li x20, 0xffffffffffffffbf
    blt x4, x20, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 59:  rs1:x3(0x800000000000000), rs2:x19(0xffffffffffffffdf), result Branch=0
    li x1, 0xcccc
    li x3, 0x800000000000000
    li x19, 0xffffffffffffffdf
    blt x3, x19, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x3, test_13_res
    
     # Testcase 60:  rs1:x2(0x1000000000000000), rs2:x18(0xffffffffffffffef), result Branch=0
    li x1, 0xcccc
    li x2, 0x1000000000000000
    li x18, 0xffffffffffffffef
    blt x2, x18, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 61:  rs1:x1(0x2000000000000000), rs2:x17(0xfffffffffffffff7), result Branch=0
    li x2, 0xcccc
    li x1, 0x2000000000000000
    li x17, 0xfffffffffffffff7
    blt x1, x17, 2f
    li x2, 0x123ab
2: 
    sd x2, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0x123ab)

     # Testcase 62:  rs1:x31(0x4000000000000000), rs2:x16(0xfffffffffffffffb), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x31, 0x4000000000000000
    li x16, 0xfffffffffffffffb
    blt x31, x16, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 63:  rs1:x30(0x8000000000000000), rs2:x15(0xfffffffffffffffd), result Branch=1
    li x1, 0xcccc
    li x30, 0x8000000000000000
    li x15, 0xfffffffffffffffd
    blt x30, x15, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 64:  rs1:x29(0x0), rs2:x14(0xfffffffffffffffe), result Branch=0
    li x1, 0xcccc
    li x29, 0x0
    li x14, 0xfffffffffffffffe
    blt x29, x14, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x2, test_14_res
    
     # Testcase 65:  rs1:x28(0xfffffffffffffffe), rs2:x13(0x0), result Branch=1
    li x1, 0xcccc
    li x28, 0xfffffffffffffffe
    li x13, 0x0
    blt x28, x13, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 66:  rs1:x27(0xfffffffffffffffd), rs2:x12(0x8000000000000000), result Branch=0
    li x1, 0xcccc
    li x27, 0xfffffffffffffffd
    li x12, 0x8000000000000000
    blt x27, x12, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 67:  rs1:x26(0xfffffffffffffffb), rs2:x11(0x4000000000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x26, 0xfffffffffffffffb
    li x11, 0x4000000000000000
    blt x26, x11, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 68:  rs1:x25(0xfffffffffffffff7), rs2:x10(0x2000000000000000), result Branch=1
    li x1, 0xcccc
    li x25, 0xfffffffffffffff7
    li x10, 0x2000000000000000
    blt x25, x10, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 69:  rs1:x24(0xffffffffffffffef), rs2:x9(0x1000000000000000), result Branch=1
    li x1, 0xcccc
    li x24, 0xffffffffffffffef
    li x9, 0x1000000000000000
    blt x24, x9, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x2, test_15_res
    
     # Testcase 70:  rs1:x23(0xffffffffffffffdf), rs2:x8(0x800000000000000), result Branch=1
    li x1, 0xcccc
    li x23, 0xffffffffffffffdf
    li x8, 0x800000000000000
    blt x23, x8, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 71:  rs1:x22(0xffffffffffffffbf), rs2:x7(0x400000000000000), result Branch=1
    li x1, 0xcccc
    li x22, 0xffffffffffffffbf
    li x7, 0x400000000000000
    blt x22, x7, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 72:  rs1:x21(0xffffffffffffff7f), rs2:x6(0x200000000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x21, 0xffffffffffffff7f
    li x6, 0x200000000000000
    blt x21, x6, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 73:  rs1:x20(0xfffffffffffffeff), rs2:x5(0x100000000000000), result Branch=1
    li x1, 0xcccc
    li x20, 0xfffffffffffffeff
    li x5, 0x100000000000000
    blt x20, x5, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 74:  rs1:x19(0xfffffffffffffdff), rs2:x4(0x80000000000000), result Branch=1
    li x1, 0xcccc
    li x19, 0xfffffffffffffdff
    li x4, 0x80000000000000
    blt x19, x4, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res
    
     # Testcase 75:  rs1:x18(0xfffffffffffffbff), rs2:x3(0x40000000000000), result Branch=1
    li x1, 0xcccc
    li x18, 0xfffffffffffffbff
    li x3, 0x40000000000000
    blt x18, x3, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 76:  rs1:x17(0xfffffffffffff7ff), rs2:x2(0x20000000000000), result Branch=1
    li x1, 0xcccc
    li x17, 0xfffffffffffff7ff
    li x2, 0x20000000000000
    blt x17, x2, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 77:  rs1:x16(0xffffffffffffefff), rs2:x1(0x10000000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x2, 0xcccc
    li x16, 0xffffffffffffefff
    li x1, 0x10000000000000
    blt x16, x1, 2b
    li x2, 0x123ab
4:
    sd x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xcccc)

     # Testcase 78:  rs1:x15(0xffffffffffffdfff), rs2:x31(0x8000000000000), result Branch=1
    li x1, 0xcccc
    li x15, 0xffffffffffffdfff
    li x31, 0x8000000000000
    blt x15, x31, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 79:  rs1:x14(0xffffffffffffbfff), rs2:x30(0x4000000000000), result Branch=1
    li x1, 0xcccc
    li x14, 0xffffffffffffbfff
    li x30, 0x4000000000000
    blt x14, x30, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x2, test_17_res
    
     # Testcase 80:  rs1:x13(0xffffffffffff7fff), rs2:x29(0x2000000000000), result Branch=1
    li x1, 0xcccc
    li x13, 0xffffffffffff7fff
    li x29, 0x2000000000000
    blt x13, x29, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 81:  rs1:x12(0xfffffffffffeffff), rs2:x28(0x1000000000000), result Branch=1
    li x1, 0xcccc
    li x12, 0xfffffffffffeffff
    li x28, 0x1000000000000
    blt x12, x28, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 82:  rs1:x11(0xfffffffffffdffff), rs2:x27(0x800000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x11, 0xfffffffffffdffff
    li x27, 0x800000000000
    blt x11, x27, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 83:  rs1:x10(0xfffffffffffbffff), rs2:x26(0x400000000000), result Branch=1
    li x1, 0xcccc
    li x10, 0xfffffffffffbffff
    li x26, 0x400000000000
    blt x10, x26, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 84:  rs1:x9(0xfffffffffff7ffff), rs2:x25(0x200000000000), result Branch=1
    li x1, 0xcccc
    li x9, 0xfffffffffff7ffff
    li x25, 0x200000000000
    blt x9, x25, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x2, test_18_res
    
     # Testcase 85:  rs1:x8(0xffffffffffefffff), rs2:x24(0x100000000000), result Branch=1
    li x1, 0xcccc
    li x8, 0xffffffffffefffff
    li x24, 0x100000000000
    blt x8, x24, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 86:  rs1:x7(0xffffffffffdfffff), rs2:x23(0x80000000000), result Branch=1
    li x1, 0xcccc
    li x7, 0xffffffffffdfffff
    li x23, 0x80000000000
    blt x7, x23, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 87:  rs1:x6(0xffffffffffbfffff), rs2:x22(0x40000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x6, 0xffffffffffbfffff
    li x22, 0x40000000000
    blt x6, x22, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 88:  rs1:x5(0xffffffffff7fffff), rs2:x21(0x20000000000), result Branch=1
    li x1, 0xcccc
    li x5, 0xffffffffff7fffff
    li x21, 0x20000000000
    blt x5, x21, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 89:  rs1:x4(0xfffffffffeffffff), rs2:x20(0x10000000000), result Branch=1
    li x1, 0xcccc
    li x4, 0xfffffffffeffffff
    li x20, 0x10000000000
    blt x4, x20, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res
    
     # Testcase 90:  rs1:x3(0xfffffffffdffffff), rs2:x19(0x8000000000), result Branch=1
    li x1, 0xcccc
    li x3, 0xfffffffffdffffff
    li x19, 0x8000000000
    blt x3, x19, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 91:  rs1:x2(0xfffffffffbffffff), rs2:x18(0x4000000000), result Branch=1
    li x1, 0xcccc
    li x2, 0xfffffffffbffffff
    li x18, 0x4000000000
    blt x2, x18, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 92:  rs1:x1(0xfffffffff7ffffff), rs2:x17(0x2000000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x2, 0xcccc
    li x1, 0xfffffffff7ffffff
    li x17, 0x2000000000
    blt x1, x17, 2b
    li x2, 0x123ab
4:
    sd x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xcccc)

     # Testcase 93:  rs1:x31(0xffffffffefffffff), rs2:x16(0x1000000000), result Branch=1
    li x1, 0xcccc
    li x31, 0xffffffffefffffff
    li x16, 0x1000000000
    blt x31, x16, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 94:  rs1:x30(0xffffffffdfffffff), rs2:x15(0x800000000), result Branch=1
    li x1, 0xcccc
    li x30, 0xffffffffdfffffff
    li x15, 0x800000000
    blt x30, x15, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x2, test_20_res
    
     # Testcase 95:  rs1:x29(0xffffffffbfffffff), rs2:x14(0x400000000), result Branch=1
    li x1, 0xcccc
    li x29, 0xffffffffbfffffff
    li x14, 0x400000000
    blt x29, x14, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 96:  rs1:x28(0xffffffff7fffffff), rs2:x13(0x200000000), result Branch=1
    li x1, 0xcccc
    li x28, 0xffffffff7fffffff
    li x13, 0x200000000
    blt x28, x13, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 97:  rs1:x27(0xfffffffeffffffff), rs2:x12(0x100000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x27, 0xfffffffeffffffff
    li x12, 0x100000000
    blt x27, x12, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 98:  rs1:x26(0xfffffffdffffffff), rs2:x11(0x80000000), result Branch=1
    li x1, 0xcccc
    li x26, 0xfffffffdffffffff
    li x11, 0x80000000
    blt x26, x11, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 99:  rs1:x25(0xfffffffbffffffff), rs2:x10(0x40000000), result Branch=1
    li x1, 0xcccc
    li x25, 0xfffffffbffffffff
    li x10, 0x40000000
    blt x25, x10, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x2, test_21_res
    
     # Testcase 100:  rs1:x24(0xfffffff7ffffffff), rs2:x9(0x20000000), result Branch=1
    li x1, 0xcccc
    li x24, 0xfffffff7ffffffff
    li x9, 0x20000000
    blt x24, x9, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 101:  rs1:x23(0xffffffefffffffff), rs2:x8(0x10000000), result Branch=1
    li x1, 0xcccc
    li x23, 0xffffffefffffffff
    li x8, 0x10000000
    blt x23, x8, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 102:  rs1:x22(0xffffffdfffffffff), rs2:x7(0x8000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x22, 0xffffffdfffffffff
    li x7, 0x8000000
    blt x22, x7, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 103:  rs1:x21(0xffffffbfffffffff), rs2:x6(0x4000000), result Branch=1
    li x1, 0xcccc
    li x21, 0xffffffbfffffffff
    li x6, 0x4000000
    blt x21, x6, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 104:  rs1:x20(0xffffff7fffffffff), rs2:x5(0x2000000), result Branch=1
    li x1, 0xcccc
    li x20, 0xffffff7fffffffff
    li x5, 0x2000000
    blt x20, x5, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res
    
     # Testcase 105:  rs1:x19(0xfffffeffffffffff), rs2:x4(0x1000000), result Branch=1
    li x1, 0xcccc
    li x19, 0xfffffeffffffffff
    li x4, 0x1000000
    blt x19, x4, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 106:  rs1:x18(0xfffffdffffffffff), rs2:x3(0x800000), result Branch=1
    li x1, 0xcccc
    li x18, 0xfffffdffffffffff
    li x3, 0x800000
    blt x18, x3, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 107:  rs1:x17(0xfffffbffffffffff), rs2:x2(0x400000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x17, 0xfffffbffffffffff
    li x2, 0x400000
    blt x17, x2, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 108:  rs1:x16(0xfffff7ffffffffff), rs2:x1(0x200000), result Branch=1
    li x2, 0xcccc
    li x16, 0xfffff7ffffffffff
    li x1, 0x200000
    blt x16, x1, 4f
    li x2, 0x123ab
4: 
    sd x2, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xcccc)

     # Testcase 109:  rs1:x15(0xffffefffffffffff), rs2:x31(0x100000), result Branch=1
    li x1, 0xcccc
    li x15, 0xffffefffffffffff
    li x31, 0x100000
    blt x15, x31, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x2, test_23_res
    
     # Testcase 110:  rs1:x14(0xffffdfffffffffff), rs2:x30(0x80000), result Branch=1
    li x1, 0xcccc
    li x14, 0xffffdfffffffffff
    li x30, 0x80000
    blt x14, x30, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 111:  rs1:x13(0xffffbfffffffffff), rs2:x29(0x40000), result Branch=1
    li x1, 0xcccc
    li x13, 0xffffbfffffffffff
    li x29, 0x40000
    blt x13, x29, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 112:  rs1:x12(0xffff7fffffffffff), rs2:x28(0x20000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x12, 0xffff7fffffffffff
    li x28, 0x20000
    blt x12, x28, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 113:  rs1:x11(0xfffeffffffffffff), rs2:x27(0x10000), result Branch=1
    li x1, 0xcccc
    li x11, 0xfffeffffffffffff
    li x27, 0x10000
    blt x11, x27, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 114:  rs1:x10(0xfffdffffffffffff), rs2:x26(0x8000), result Branch=1
    li x1, 0xcccc
    li x10, 0xfffdffffffffffff
    li x26, 0x8000
    blt x10, x26, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x2, test_24_res
    
     # Testcase 115:  rs1:x9(0xfffbffffffffffff), rs2:x25(0x4000), result Branch=1
    li x1, 0xcccc
    li x9, 0xfffbffffffffffff
    li x25, 0x4000
    blt x9, x25, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 116:  rs1:x8(0xfff7ffffffffffff), rs2:x24(0x2000), result Branch=1
    li x1, 0xcccc
    li x8, 0xfff7ffffffffffff
    li x24, 0x2000
    blt x8, x24, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 117:  rs1:x7(0xffefffffffffffff), rs2:x23(0x1000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x7, 0xffefffffffffffff
    li x23, 0x1000
    blt x7, x23, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 118:  rs1:x6(0xffdfffffffffffff), rs2:x22(0x800), result Branch=1
    li x1, 0xcccc
    li x6, 0xffdfffffffffffff
    li x22, 0x800
    blt x6, x22, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 119:  rs1:x5(0xffbfffffffffffff), rs2:x21(0x400), result Branch=1
    li x1, 0xcccc
    li x5, 0xffbfffffffffffff
    li x21, 0x400
    blt x5, x21, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res
    
     # Testcase 120:  rs1:x4(0xff7fffffffffffff), rs2:x20(0x200), result Branch=1
    li x1, 0xcccc
    li x4, 0xff7fffffffffffff
    li x20, 0x200
    blt x4, x20, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 121:  rs1:x3(0xfeffffffffffffff), rs2:x19(0x100), result Branch=1
    li x1, 0xcccc
    li x3, 0xfeffffffffffffff
    li x19, 0x100
    blt x3, x19, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 122:  rs1:x2(0xfdffffffffffffff), rs2:x18(0x80), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x2, 0xfdffffffffffffff
    li x18, 0x80
    blt x2, x18, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 123:  rs1:x1(0xfbffffffffffffff), rs2:x17(0x40), result Branch=1
    li x2, 0xcccc
    li x1, 0xfbffffffffffffff
    li x17, 0x40
    blt x1, x17, 4f
    li x2, 0x123ab
4: 
    sd x2, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xcccc)

     # Testcase 124:  rs1:x31(0xf7ffffffffffffff), rs2:x16(0x20), result Branch=1
    li x1, 0xcccc
    li x31, 0xf7ffffffffffffff
    li x16, 0x20
    blt x31, x16, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x2, test_26_res
    
     # Testcase 125:  rs1:x30(0xefffffffffffffff), rs2:x15(0x10), result Branch=1
    li x1, 0xcccc
    li x30, 0xefffffffffffffff
    li x15, 0x10
    blt x30, x15, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 126:  rs1:x29(0xdfffffffffffffff), rs2:x14(0x8), result Branch=1
    li x1, 0xcccc
    li x29, 0xdfffffffffffffff
    li x14, 0x8
    blt x29, x14, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 127:  rs1:x28(0xbfffffffffffffff), rs2:x13(0x4), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x28, 0xbfffffffffffffff
    li x13, 0x4
    blt x28, x13, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 128:  rs1:x27(0x7fffffffffffffff), rs2:x12(0x2), result Branch=0
    li x1, 0xcccc
    li x27, 0x7fffffffffffffff
    li x12, 0x2
    blt x27, x12, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 129:  rs1:x26(0xffffffffffffffff), rs2:x11(0x1), result Branch=1
    li x1, 0xcccc
    li x26, 0xffffffffffffffff
    li x11, 0x1
    blt x26, x11, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x2, test_27_res
    
     # Testcase 130:  rs1:x25(0x1), rs2:x10(0x0), result Branch=0
    li x1, 0xcccc
    li x25, 0x1
    li x10, 0x0
    blt x25, x10, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 131:  rs1:x24(0x2), rs2:x9(0x0), result Branch=0
    li x1, 0xcccc
    li x24, 0x2
    li x9, 0x0
    blt x24, x9, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 132:  rs1:x23(0x4), rs2:x8(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x23, 0x4
    li x8, 0x0
    blt x23, x8, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 133:  rs1:x22(0x8), rs2:x7(0x0), result Branch=0
    li x1, 0xcccc
    li x22, 0x8
    li x7, 0x0
    blt x22, x7, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 134:  rs1:x21(0x10), rs2:x6(0x0), result Branch=0
    li x1, 0xcccc
    li x21, 0x10
    li x6, 0x0
    blt x21, x6, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res
    
     # Testcase 135:  rs1:x20(0x20), rs2:x5(0x0), result Branch=0
    li x1, 0xcccc
    li x20, 0x20
    li x5, 0x0
    blt x20, x5, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x123ab)

     # Testcase 136:  rs1:x19(0x40), rs2:x4(0x0), result Branch=0
    li x1, 0xcccc
    li x19, 0x40
    li x4, 0x0
    blt x19, x4, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x123ab)

     # Testcase 137:  rs1:x18(0x80), rs2:x3(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x18, 0x80
    li x3, 0x0
    blt x18, x3, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x123ab)

     # Testcase 138:  rs1:x17(0x100), rs2:x2(0x0), result Branch=0
    li x1, 0xcccc
    li x17, 0x100
    li x2, 0x0
    blt x17, x2, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x123ab)

     # Testcase 139:  rs1:x16(0x200), rs2:x1(0x0), result Branch=0
    li x2, 0xcccc
    li x16, 0x200
    li x1, 0x0
    blt x16, x1, 5f
    li x2, 0x123ab
5: 
    sd x2, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x2, test_29_res
    
     # Testcase 140:  rs1:x15(0x400), rs2:x31(0x0), result Branch=0
    li x1, 0xcccc
    li x15, 0x400
    li x31, 0x0
    blt x15, x31, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 141:  rs1:x14(0x800), rs2:x30(0x0), result Branch=0
    li x1, 0xcccc
    li x14, 0x800
    li x30, 0x0
    blt x14, x30, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 142:  rs1:x13(0x1000), rs2:x29(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x13, 0x1000
    li x29, 0x0
    blt x13, x29, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 143:  rs1:x12(0x2000), rs2:x28(0x0), result Branch=0
    li x1, 0xcccc
    li x12, 0x2000
    li x28, 0x0
    blt x12, x28, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 144:  rs1:x11(0x4000), rs2:x27(0x0), result Branch=0
    li x1, 0xcccc
    li x11, 0x4000
    li x27, 0x0
    blt x11, x27, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x2, test_30_res
    
     # Testcase 145:  rs1:x10(0x8000), rs2:x26(0x0), result Branch=0
    li x1, 0xcccc
    li x10, 0x8000
    li x26, 0x0
    blt x10, x26, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 146:  rs1:x9(0x10000), rs2:x25(0x0), result Branch=0
    li x1, 0xcccc
    li x9, 0x10000
    li x25, 0x0
    blt x9, x25, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 147:  rs1:x8(0x20000), rs2:x24(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x8, 0x20000
    li x24, 0x0
    blt x8, x24, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 148:  rs1:x7(0x40000), rs2:x23(0x0), result Branch=0
    li x1, 0xcccc
    li x7, 0x40000
    li x23, 0x0
    blt x7, x23, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 149:  rs1:x6(0x80000), rs2:x22(0x0), result Branch=0
    li x1, 0xcccc
    li x6, 0x80000
    li x22, 0x0
    blt x6, x22, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x6, test_31_res
    
     # Testcase 150:  rs1:x5(0x100000), rs2:x21(0x0), result Branch=0
    li x1, 0xcccc
    li x5, 0x100000
    li x21, 0x0
    blt x5, x21, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x123ab)

     # Testcase 151:  rs1:x4(0x200000), rs2:x20(0x0), result Branch=0
    li x1, 0xcccc
    li x4, 0x200000
    li x20, 0x0
    blt x4, x20, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x123ab)

     # Testcase 152:  rs1:x3(0x400000), rs2:x19(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x3, 0x400000
    li x19, 0x0
    blt x3, x19, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x123ab)

     # Testcase 153:  rs1:x2(0x800000), rs2:x18(0x0), result Branch=0
    li x1, 0xcccc
    li x2, 0x800000
    li x18, 0x0
    blt x2, x18, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x123ab)

     # Testcase 154:  rs1:x1(0x1000000), rs2:x17(0x0), result Branch=0
    li x2, 0xcccc
    li x1, 0x1000000
    li x17, 0x0
    blt x1, x17, 5f
    li x2, 0x123ab
5: 
    sd x2, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x2, test_32_res
    
     # Testcase 155:  rs1:x31(0x2000000), rs2:x16(0x0), result Branch=0
    li x1, 0xcccc
    li x31, 0x2000000
    li x16, 0x0
    blt x31, x16, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 156:  rs1:x30(0x4000000), rs2:x15(0x0), result Branch=0
    li x1, 0xcccc
    li x30, 0x4000000
    li x15, 0x0
    blt x30, x15, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 157:  rs1:x29(0x8000000), rs2:x14(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x29, 0x8000000
    li x14, 0x0
    blt x29, x14, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 158:  rs1:x28(0x10000000), rs2:x13(0x0), result Branch=0
    li x1, 0xcccc
    li x28, 0x10000000
    li x13, 0x0
    blt x28, x13, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 159:  rs1:x27(0x20000000), rs2:x12(0x0), result Branch=0
    li x1, 0xcccc
    li x27, 0x20000000
    li x12, 0x0
    blt x27, x12, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x2, test_33_res
    
     # Testcase 160:  rs1:x26(0x40000000), rs2:x11(0x0), result Branch=0
    li x1, 0xcccc
    li x26, 0x40000000
    li x11, 0x0
    blt x26, x11, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 161:  rs1:x25(0x80000000), rs2:x10(0x0), result Branch=0
    li x1, 0xcccc
    li x25, 0x80000000
    li x10, 0x0
    blt x25, x10, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 162:  rs1:x24(0x100000000), rs2:x9(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x24, 0x100000000
    li x9, 0x0
    blt x24, x9, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 163:  rs1:x23(0x200000000), rs2:x8(0x0), result Branch=0
    li x1, 0xcccc
    li x23, 0x200000000
    li x8, 0x0
    blt x23, x8, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 164:  rs1:x22(0x400000000), rs2:x7(0x0), result Branch=0
    li x1, 0xcccc
    li x22, 0x400000000
    li x7, 0x0
    blt x22, x7, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x7, test_34_res
    
     # Testcase 165:  rs1:x21(0x800000000), rs2:x6(0x0), result Branch=0
    li x1, 0xcccc
    li x21, 0x800000000
    li x6, 0x0
    blt x21, x6, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 166:  rs1:x20(0x1000000000), rs2:x5(0x0), result Branch=0
    li x1, 0xcccc
    li x20, 0x1000000000
    li x5, 0x0
    blt x20, x5, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 167:  rs1:x19(0x2000000000), rs2:x4(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x19, 0x2000000000
    li x4, 0x0
    blt x19, x4, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 168:  rs1:x18(0x4000000000), rs2:x3(0x0), result Branch=0
    li x1, 0xcccc
    li x18, 0x4000000000
    li x3, 0x0
    blt x18, x3, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 169:  rs1:x17(0x8000000000), rs2:x2(0x0), result Branch=0
    li x1, 0xcccc
    li x17, 0x8000000000
    li x2, 0x0
    blt x17, x2, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x3, test_35_res
    
     # Testcase 170:  rs1:x16(0x10000000000), rs2:x1(0x0), result Branch=0
    li x2, 0xcccc
    li x16, 0x10000000000
    li x1, 0x0
    blt x16, x1, 1f
    li x2, 0x123ab
1: 
    sd x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0x123ab)

     # Testcase 171:  rs1:x15(0x20000000000), rs2:x31(0x0), result Branch=0
    li x1, 0xcccc
    li x15, 0x20000000000
    li x31, 0x0
    blt x15, x31, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 172:  rs1:x14(0x40000000000), rs2:x30(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x14, 0x40000000000
    li x30, 0x0
    blt x14, x30, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 173:  rs1:x13(0x80000000000), rs2:x29(0x0), result Branch=0
    li x1, 0xcccc
    li x13, 0x80000000000
    li x29, 0x0
    blt x13, x29, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 174:  rs1:x12(0x100000000000), rs2:x28(0x0), result Branch=0
    li x1, 0xcccc
    li x12, 0x100000000000
    li x28, 0x0
    blt x12, x28, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x2, test_36_res
    
     # Testcase 175:  rs1:x11(0x200000000000), rs2:x27(0x0), result Branch=0
    li x1, 0xcccc
    li x11, 0x200000000000
    li x27, 0x0
    blt x11, x27, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 176:  rs1:x10(0x400000000000), rs2:x26(0x0), result Branch=0
    li x1, 0xcccc
    li x10, 0x400000000000
    li x26, 0x0
    blt x10, x26, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 177:  rs1:x9(0x800000000000), rs2:x25(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x9, 0x800000000000
    li x25, 0x0
    blt x9, x25, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 178:  rs1:x8(0x1000000000000), rs2:x24(0x0), result Branch=0
    li x1, 0xcccc
    li x8, 0x1000000000000
    li x24, 0x0
    blt x8, x24, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 179:  rs1:x7(0x2000000000000), rs2:x23(0x0), result Branch=0
    li x1, 0xcccc
    li x7, 0x2000000000000
    li x23, 0x0
    blt x7, x23, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x7, test_37_res
    
     # Testcase 180:  rs1:x6(0x4000000000000), rs2:x22(0x0), result Branch=0
    li x1, 0xcccc
    li x6, 0x4000000000000
    li x22, 0x0
    blt x6, x22, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 181:  rs1:x5(0x8000000000000), rs2:x21(0x0), result Branch=0
    li x1, 0xcccc
    li x5, 0x8000000000000
    li x21, 0x0
    blt x5, x21, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 182:  rs1:x4(0x10000000000000), rs2:x20(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x4, 0x10000000000000
    li x20, 0x0
    blt x4, x20, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 183:  rs1:x3(0x20000000000000), rs2:x19(0x0), result Branch=0
    li x1, 0xcccc
    li x3, 0x20000000000000
    li x19, 0x0
    blt x3, x19, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)

     # Testcase 184:  rs1:x2(0x40000000000000), rs2:x18(0x0), result Branch=0
    li x1, 0xcccc
    li x2, 0x40000000000000
    li x18, 0x0
    blt x2, x18, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x3, test_38_res
    
     # Testcase 185:  rs1:x1(0x80000000000000), rs2:x17(0x0), result Branch=0
    li x2, 0xcccc
    li x1, 0x80000000000000
    li x17, 0x0
    blt x1, x17, 1f
    li x2, 0x123ab
1: 
    sd x2, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0x123ab)

     # Testcase 186:  rs1:x31(0x100000000000000), rs2:x16(0x0), result Branch=0
    li x1, 0xcccc
    li x31, 0x100000000000000
    li x16, 0x0
    blt x31, x16, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 187:  rs1:x30(0x200000000000000), rs2:x15(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x30, 0x200000000000000
    li x15, 0x0
    blt x30, x15, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 188:  rs1:x29(0x400000000000000), rs2:x14(0x0), result Branch=0
    li x1, 0xcccc
    li x29, 0x400000000000000
    li x14, 0x0
    blt x29, x14, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)

     # Testcase 189:  rs1:x28(0x800000000000000), rs2:x13(0x0), result Branch=0
    li x1, 0xcccc
    li x28, 0x800000000000000
    li x13, 0x0
    blt x28, x13, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x2, test_39_res
    
     # Testcase 190:  rs1:x27(0x1000000000000000), rs2:x12(0x0), result Branch=0
    li x1, 0xcccc
    li x27, 0x1000000000000000
    li x12, 0x0
    blt x27, x12, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 191:  rs1:x26(0x2000000000000000), rs2:x11(0x0), result Branch=0
    li x1, 0xcccc
    li x26, 0x2000000000000000
    li x11, 0x0
    blt x26, x11, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 192:  rs1:x25(0x4000000000000000), rs2:x10(0x0), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x25, 0x4000000000000000
    li x10, 0x0
    blt x25, x10, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 193:  rs1:x24(0x8000000000000000), rs2:x9(0x0), result Branch=1
    li x1, 0xcccc
    li x24, 0x8000000000000000
    li x9, 0x0
    blt x24, x9, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 194:  rs1:x23(0x0), rs2:x8(0x0), result Branch=0
    li x1, 0xcccc
    li x23, 0x0
    li x8, 0x0
    blt x23, x8, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x2, test_40_res
    
     # Testcase 195:  rs1:x22(0xfffffffffffffffe), rs2:x7(0x0), result Branch=1
    li x1, 0xcccc
    li x22, 0xfffffffffffffffe
    li x7, 0x0
    blt x22, x7, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 196:  rs1:x21(0xfffffffffffffffd), rs2:x6(0x0), result Branch=1
    li x1, 0xcccc
    li x21, 0xfffffffffffffffd
    li x6, 0x0
    blt x21, x6, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 197:  rs1:x20(0xfffffffffffffffb), rs2:x5(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x20, 0xfffffffffffffffb
    li x5, 0x0
    blt x20, x5, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 198:  rs1:x19(0xfffffffffffffff7), rs2:x4(0x0), result Branch=1
    li x1, 0xcccc
    li x19, 0xfffffffffffffff7
    li x4, 0x0
    blt x19, x4, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 199:  rs1:x18(0xffffffffffffffef), rs2:x3(0x0), result Branch=1
    li x1, 0xcccc
    li x18, 0xffffffffffffffef
    li x3, 0x0
    blt x18, x3, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x3, test_41_res
    
     # Testcase 200:  rs1:x17(0xffffffffffffffdf), rs2:x2(0x0), result Branch=1
    li x1, 0xcccc
    li x17, 0xffffffffffffffdf
    li x2, 0x0
    blt x17, x2, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 201:  rs1:x16(0xffffffffffffffbf), rs2:x1(0x0), result Branch=1
    li x2, 0xcccc
    li x16, 0xffffffffffffffbf
    li x1, 0x0
    blt x16, x1, 2f
    li x2, 0x123ab
2: 
    sd x2, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     # Testcase 202:  rs1:x15(0xffffffffffffff7f), rs2:x31(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x15, 0xffffffffffffff7f
    li x31, 0x0
    blt x15, x31, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 203:  rs1:x14(0xfffffffffffffeff), rs2:x30(0x0), result Branch=1
    li x1, 0xcccc
    li x14, 0xfffffffffffffeff
    li x30, 0x0
    blt x14, x30, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 204:  rs1:x13(0xfffffffffffffdff), rs2:x29(0x0), result Branch=1
    li x1, 0xcccc
    li x13, 0xfffffffffffffdff
    li x29, 0x0
    blt x13, x29, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x2, test_42_res
    
     # Testcase 205:  rs1:x12(0xfffffffffffffbff), rs2:x28(0x0), result Branch=1
    li x1, 0xcccc
    li x12, 0xfffffffffffffbff
    li x28, 0x0
    blt x12, x28, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 206:  rs1:x11(0xfffffffffffff7ff), rs2:x27(0x0), result Branch=1
    li x1, 0xcccc
    li x11, 0xfffffffffffff7ff
    li x27, 0x0
    blt x11, x27, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 207:  rs1:x10(0xffffffffffffefff), rs2:x26(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x10, 0xffffffffffffefff
    li x26, 0x0
    blt x10, x26, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 208:  rs1:x9(0xffffffffffffdfff), rs2:x25(0x0), result Branch=1
    li x1, 0xcccc
    li x9, 0xffffffffffffdfff
    li x25, 0x0
    blt x9, x25, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 209:  rs1:x8(0xffffffffffffbfff), rs2:x24(0x0), result Branch=1
    li x1, 0xcccc
    li x8, 0xffffffffffffbfff
    li x24, 0x0
    blt x8, x24, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x2, test_43_res
    
     # Testcase 210:  rs1:x7(0xffffffffffff7fff), rs2:x23(0x0), result Branch=1
    li x1, 0xcccc
    li x7, 0xffffffffffff7fff
    li x23, 0x0
    blt x7, x23, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 211:  rs1:x6(0xfffffffffffeffff), rs2:x22(0x0), result Branch=1
    li x1, 0xcccc
    li x6, 0xfffffffffffeffff
    li x22, 0x0
    blt x6, x22, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 212:  rs1:x5(0xfffffffffffdffff), rs2:x21(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x5, 0xfffffffffffdffff
    li x21, 0x0
    blt x5, x21, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 213:  rs1:x4(0xfffffffffffbffff), rs2:x20(0x0), result Branch=1
    li x1, 0xcccc
    li x4, 0xfffffffffffbffff
    li x20, 0x0
    blt x4, x20, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)

     # Testcase 214:  rs1:x3(0xfffffffffff7ffff), rs2:x19(0x0), result Branch=1
    li x1, 0xcccc
    li x3, 0xfffffffffff7ffff
    li x19, 0x0
    blt x3, x19, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x3, test_44_res
    
     # Testcase 215:  rs1:x2(0xffffffffffefffff), rs2:x18(0x0), result Branch=1
    li x1, 0xcccc
    li x2, 0xffffffffffefffff
    li x18, 0x0
    blt x2, x18, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 216:  rs1:x1(0xffffffffffdfffff), rs2:x17(0x0), result Branch=1
    li x2, 0xcccc
    li x1, 0xffffffffffdfffff
    li x17, 0x0
    blt x1, x17, 2f
    li x2, 0x123ab
2: 
    sd x2, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x2, 0xcccc)

     # Testcase 217:  rs1:x31(0xffffffffffbfffff), rs2:x16(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x31, 0xffffffffffbfffff
    li x16, 0x0
    blt x31, x16, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 218:  rs1:x30(0xffffffffff7fffff), rs2:x15(0x0), result Branch=1
    li x1, 0xcccc
    li x30, 0xffffffffff7fffff
    li x15, 0x0
    blt x30, x15, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)

     # Testcase 219:  rs1:x29(0xfffffffffeffffff), rs2:x14(0x0), result Branch=1
    li x1, 0xcccc
    li x29, 0xfffffffffeffffff
    li x14, 0x0
    blt x29, x14, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x2, test_45_res
    
     # Testcase 220:  rs1:x28(0xfffffffffdffffff), rs2:x13(0x0), result Branch=1
    li x1, 0xcccc
    li x28, 0xfffffffffdffffff
    li x13, 0x0
    blt x28, x13, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 221:  rs1:x27(0xfffffffffbffffff), rs2:x12(0x0), result Branch=1
    li x1, 0xcccc
    li x27, 0xfffffffffbffffff
    li x12, 0x0
    blt x27, x12, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 222:  rs1:x26(0xfffffffff7ffffff), rs2:x11(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x26, 0xfffffffff7ffffff
    li x11, 0x0
    blt x26, x11, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 223:  rs1:x25(0xffffffffefffffff), rs2:x10(0x0), result Branch=1
    li x1, 0xcccc
    li x25, 0xffffffffefffffff
    li x10, 0x0
    blt x25, x10, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 224:  rs1:x24(0xffffffffdfffffff), rs2:x9(0x0), result Branch=1
    li x1, 0xcccc
    li x24, 0xffffffffdfffffff
    li x9, 0x0
    blt x24, x9, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x2, test_46_res
    
     # Testcase 225:  rs1:x23(0xffffffffbfffffff), rs2:x8(0x0), result Branch=1
    li x1, 0xcccc
    li x23, 0xffffffffbfffffff
    li x8, 0x0
    blt x23, x8, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 226:  rs1:x22(0xffffffff7fffffff), rs2:x7(0x0), result Branch=1
    li x1, 0xcccc
    li x22, 0xffffffff7fffffff
    li x7, 0x0
    blt x22, x7, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 227:  rs1:x21(0xfffffffeffffffff), rs2:x6(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x21, 0xfffffffeffffffff
    li x6, 0x0
    blt x21, x6, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 228:  rs1:x20(0xfffffffdffffffff), rs2:x5(0x0), result Branch=1
    li x1, 0xcccc
    li x20, 0xfffffffdffffffff
    li x5, 0x0
    blt x20, x5, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 229:  rs1:x19(0xfffffffbffffffff), rs2:x4(0x0), result Branch=1
    li x1, 0xcccc
    li x19, 0xfffffffbffffffff
    li x4, 0x0
    blt x19, x4, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x4, test_47_res
    
     # Testcase 230:  rs1:x18(0xfffffff7ffffffff), rs2:x3(0x0), result Branch=1
    li x1, 0xcccc
    li x18, 0xfffffff7ffffffff
    li x3, 0x0
    blt x18, x3, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 231:  rs1:x17(0xffffffefffffffff), rs2:x2(0x0), result Branch=1
    li x1, 0xcccc
    li x17, 0xffffffefffffffff
    li x2, 0x0
    blt x17, x2, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 232:  rs1:x16(0xffffffdfffffffff), rs2:x1(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x2, 0xcccc
    li x16, 0xffffffdfffffffff
    li x1, 0x0
    blt x16, x1, 2b
    li x2, 0x123ab
4:
    sd x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xcccc)

     # Testcase 233:  rs1:x15(0xffffffbfffffffff), rs2:x31(0x0), result Branch=1
    li x1, 0xcccc
    li x15, 0xffffffbfffffffff
    li x31, 0x0
    blt x15, x31, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 234:  rs1:x14(0xffffff7fffffffff), rs2:x30(0x0), result Branch=1
    li x1, 0xcccc
    li x14, 0xffffff7fffffffff
    li x30, 0x0
    blt x14, x30, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x2, test_48_res
    
     # Testcase 235:  rs1:x13(0xfffffeffffffffff), rs2:x29(0x0), result Branch=1
    li x1, 0xcccc
    li x13, 0xfffffeffffffffff
    li x29, 0x0
    blt x13, x29, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 236:  rs1:x12(0xfffffdffffffffff), rs2:x28(0x0), result Branch=1
    li x1, 0xcccc
    li x12, 0xfffffdffffffffff
    li x28, 0x0
    blt x12, x28, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 237:  rs1:x11(0xfffffbffffffffff), rs2:x27(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x11, 0xfffffbffffffffff
    li x27, 0x0
    blt x11, x27, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 238:  rs1:x10(0xfffff7ffffffffff), rs2:x26(0x0), result Branch=1
    li x1, 0xcccc
    li x10, 0xfffff7ffffffffff
    li x26, 0x0
    blt x10, x26, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 239:  rs1:x9(0xffffefffffffffff), rs2:x25(0x0), result Branch=1
    li x1, 0xcccc
    li x9, 0xffffefffffffffff
    li x25, 0x0
    blt x9, x25, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x2, test_49_res
    
     # Testcase 240:  rs1:x8(0xffffdfffffffffff), rs2:x24(0x0), result Branch=1
    li x1, 0xcccc
    li x8, 0xffffdfffffffffff
    li x24, 0x0
    blt x8, x24, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 241:  rs1:x7(0xffffbfffffffffff), rs2:x23(0x0), result Branch=1
    li x1, 0xcccc
    li x7, 0xffffbfffffffffff
    li x23, 0x0
    blt x7, x23, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 242:  rs1:x6(0xffff7fffffffffff), rs2:x22(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x6, 0xffff7fffffffffff
    li x22, 0x0
    blt x6, x22, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 243:  rs1:x5(0xfffeffffffffffff), rs2:x21(0x0), result Branch=1
    li x1, 0xcccc
    li x5, 0xfffeffffffffffff
    li x21, 0x0
    blt x5, x21, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 244:  rs1:x4(0xfffdffffffffffff), rs2:x20(0x0), result Branch=1
    li x1, 0xcccc
    li x4, 0xfffdffffffffffff
    li x20, 0x0
    blt x4, x20, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x4, test_50_res
    
     # Testcase 245:  rs1:x3(0xfffbffffffffffff), rs2:x19(0x0), result Branch=1
    li x1, 0xcccc
    li x3, 0xfffbffffffffffff
    li x19, 0x0
    blt x3, x19, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 246:  rs1:x2(0xfff7ffffffffffff), rs2:x18(0x0), result Branch=1
    li x1, 0xcccc
    li x2, 0xfff7ffffffffffff
    li x18, 0x0
    blt x2, x18, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 247:  rs1:x1(0xffefffffffffffff), rs2:x17(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x2, 0xcccc
    li x1, 0xffefffffffffffff
    li x17, 0x0
    blt x1, x17, 2b
    li x2, 0x123ab
4:
    sd x2, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xcccc)

     # Testcase 248:  rs1:x31(0xffdfffffffffffff), rs2:x16(0x0), result Branch=1
    li x1, 0xcccc
    li x31, 0xffdfffffffffffff
    li x16, 0x0
    blt x31, x16, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)

     # Testcase 249:  rs1:x30(0xffbfffffffffffff), rs2:x15(0x0), result Branch=1
    li x1, 0xcccc
    li x30, 0xffbfffffffffffff
    li x15, 0x0
    blt x30, x15, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x2, test_51_res
    
     # Testcase 250:  rs1:x29(0xff7fffffffffffff), rs2:x14(0x0), result Branch=1
    li x1, 0xcccc
    li x29, 0xff7fffffffffffff
    li x14, 0x0
    blt x29, x14, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 251:  rs1:x28(0xfeffffffffffffff), rs2:x13(0x0), result Branch=1
    li x1, 0xcccc
    li x28, 0xfeffffffffffffff
    li x13, 0x0
    blt x28, x13, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 252:  rs1:x27(0xfdffffffffffffff), rs2:x12(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x27, 0xfdffffffffffffff
    li x12, 0x0
    blt x27, x12, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 253:  rs1:x26(0xfbffffffffffffff), rs2:x11(0x0), result Branch=1
    li x1, 0xcccc
    li x26, 0xfbffffffffffffff
    li x11, 0x0
    blt x26, x11, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 254:  rs1:x25(0xf7ffffffffffffff), rs2:x10(0x0), result Branch=1
    li x1, 0xcccc
    li x25, 0xf7ffffffffffffff
    li x10, 0x0
    blt x25, x10, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x2, test_52_res
    
     # Testcase 255:  rs1:x24(0xefffffffffffffff), rs2:x9(0x0), result Branch=1
    li x1, 0xcccc
    li x24, 0xefffffffffffffff
    li x9, 0x0
    blt x24, x9, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 256:  rs1:x23(0xdfffffffffffffff), rs2:x8(0x0), result Branch=1
    li x1, 0xcccc
    li x23, 0xdfffffffffffffff
    li x8, 0x0
    blt x23, x8, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 257:  rs1:x22(0xbfffffffffffffff), rs2:x7(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x22, 0xbfffffffffffffff
    li x7, 0x0
    blt x22, x7, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)

     # Testcase 258:  rs1:x21(0x7fffffffffffffff), rs2:x6(0x0), result Branch=0
    li x1, 0xcccc
    li x21, 0x7fffffffffffffff
    li x6, 0x0
    blt x21, x6, 4f
    li x1, 0x123ab
4: 
    sd x1, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0x123ab)

     # Testcase 259:  rs1:x20(0xffffffffffffffff), rs2:x5(0x0), result Branch=1
    li x1, 0xcccc
    li x20, 0xffffffffffffffff
    li x5, 0x0
    blt x20, x5, 5f
    li x1, 0x123ab
5: 
    sd x1, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x1, 0xcccc)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x5, test_53_res
    
     # Testcase 260:  rs1:x19(0x1), rs2:x4(0xffffffffffffffff), result Branch=0
    li x1, 0xcccc
    li x19, 0x1
    li x4, 0xffffffffffffffff
    blt x19, x4, 1f
    li x1, 0x123ab
1: 
    sd x1, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x123ab)

     # Testcase 261:  rs1:x18(0x2), rs2:x3(0x7fffffffffffffff), result Branch=1
    li x1, 0xcccc
    li x18, 0x2
    li x3, 0x7fffffffffffffff
    blt x18, x3, 2f
    li x1, 0x123ab
2: 
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xcccc)

     # Testcase 262:  rs1:x17(0x4), rs2:x0(0xbfffffffffffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x1, 0xcccc
    li x17, 0x4
    li x0, 0xbfffffffffffffff
    blt x17, x0, 2b
    li x1, 0x123ab
4:
    sd x1, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x123ab)

     # Testcase 263:  rs1:x0(0x8), rs2:x1(0xdfffffffffffffff), result Branch=0
    li x2, 0xcccc
    li x0, 0x8
    li x1, 0xdfffffffffffffff
    blt x0, x1, 4f
    li x2, 0x123ab
4: 
    sd x2, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x123ab)



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

