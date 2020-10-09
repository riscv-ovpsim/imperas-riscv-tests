# RISC-V Compliance Test I-SUB-01
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
# Description: Testing instruction 'SUB'.

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

 
    # Testcase 0:  rs1:x31(0x0000000000000001), rs2:x16(0xffffffffffffffff), result rd:x1(0x0000000000000002)
    li  x16, MASK_XLEN(0xffffffffffffffff)
    li  x31, MASK_XLEN(0x1)
    sub x1, x31, x16
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x0000000000000002) 
 
    # Testcase 1:  rs1:x30(0x0000000000000002), rs2:x15(0x7fffffffffffffff), result rd:x2(0x8000000000000003)
    li  x15, MASK_XLEN(0x7fffffffffffffff)
    li  x30, MASK_XLEN(0x2)
    sub x2, x30, x15
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x8000000000000003) 
 
    # Testcase 2:  rs1:x29(0x0000000000000004), rs2:x14(0xbfffffffffffffff), result rd:x3(0x4000000000000005)
    li  x14, MASK_XLEN(0xbfffffffffffffff)
    li  x29, MASK_XLEN(0x4)
    sub x3, x29, x14
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x4000000000000005) 
 
    # Testcase 3:  rs1:x28(0x0000000000000008), rs2:x13(0xdfffffffffffffff), result rd:x4(0x2000000000000009)
    li  x13, MASK_XLEN(0xdfffffffffffffff)
    li  x28, MASK_XLEN(0x8)
    sub x4, x28, x13
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x2000000000000009) 
 
    # Testcase 4:  rs1:x27(0x0000000000000010), rs2:x12(0xefffffffffffffff), result rd:x5(0x1000000000000011)
    li  x12, MASK_XLEN(0xefffffffffffffff)
    li  x27, MASK_XLEN(0x10)
    sub x5, x27, x12
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x1000000000000011) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")


    # address for test results
    la x1, test_2_res

 
    # Testcase 5:  rs1:x26(0x0000000000000020), rs2:x11(0xf7ffffffffffffff), result rd:x6(0x0800000000000021)
    li  x11, MASK_XLEN(0xf7ffffffffffffff)
    li  x26, MASK_XLEN(0x20)
    sub x6, x26, x11
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0800000000000021) 
 
    # Testcase 6:  rs1:x25(0x0000000000000040), rs2:x10(0xfbffffffffffffff), result rd:x7(0x0400000000000041)
    li  x10, MASK_XLEN(0xfbffffffffffffff)
    li  x25, MASK_XLEN(0x40)
    sub x7, x25, x10
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0400000000000041) 
 
    # Testcase 7:  rs1:x24(0x0000000000000080), rs2:x9(0xfdffffffffffffff), result rd:x8(0x0200000000000081)
    li  x9, MASK_XLEN(0xfdffffffffffffff)
    li  x24, MASK_XLEN(0x80)
    sub x8, x24, x9
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0200000000000081) 
 
    # Testcase 8:  rs1:x23(0x0000000000000100), rs2:x8(0xfeffffffffffffff), result rd:x9(0x0100000000000101)
    li  x8, MASK_XLEN(0xfeffffffffffffff)
    li  x23, MASK_XLEN(0x100)
    sub x9, x23, x8
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0100000000000101) 
 
    # Testcase 9:  rs1:x22(0x0000000000000200), rs2:x7(0xff7fffffffffffff), result rd:x10(0x0080000000000201)
    li  x7, MASK_XLEN(0xff7fffffffffffff)
    li  x22, MASK_XLEN(0x200)
    sub x10, x22, x7
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0080000000000201) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")


    # address for test results
    la x1, test_3_res

 
    # Testcase 10:  rs1:x21(0x0000000000000400), rs2:x6(0xffbfffffffffffff), result rd:x11(0x0040000000000401)
    li  x6, MASK_XLEN(0xffbfffffffffffff)
    li  x21, MASK_XLEN(0x400)
    sub x11, x21, x6
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x0040000000000401) 
 
    # Testcase 11:  rs1:x20(0x0000000000000800), rs2:x5(0xffdfffffffffffff), result rd:x12(0x0020000000000801)
    li  x5, MASK_XLEN(0xffdfffffffffffff)
    li  x20, MASK_XLEN(0x800)
    sub x12, x20, x5
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x0020000000000801) 
 
    # Testcase 12:  rs1:x19(0x0000000000001000), rs2:x4(0xffefffffffffffff), result rd:x13(0x0010000000001001)
    li  x4, MASK_XLEN(0xffefffffffffffff)
    li  x19, MASK_XLEN(0x1000)
    sub x13, x19, x4
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0010000000001001) 
 
    # Testcase 13:  rs1:x18(0x0000000000002000), rs2:x3(0xfff7ffffffffffff), result rd:x14(0x0008000000002001)
    li  x3, MASK_XLEN(0xfff7ffffffffffff)
    li  x18, MASK_XLEN(0x2000)
    sub x14, x18, x3
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0008000000002001) 
 
    # Testcase 14:  rs1:x17(0x0000000000004000), rs2:x2(0xfffbffffffffffff), result rd:x15(0x0004000000004001)
    li  x2, MASK_XLEN(0xfffbffffffffffff)
    li  x17, MASK_XLEN(0x4000)
    sub x15, x17, x2
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0004000000004001) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")


    # address for test results
    la x2, test_4_res

 
    # Testcase 15:  rs1:x16(0x0000000000008000), rs2:x1(0xfffdffffffffffff), result rd:x16(0x0002000000008001)
    li  x1, MASK_XLEN(0xfffdffffffffffff)
    li  x16, MASK_XLEN(0x8000)
    sub x16, x16, x1
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x0002000000008001) 
 
    # Testcase 16:  rs1:x15(0x0000000000010000), rs2:x31(0xfffeffffffffffff), result rd:x17(0x0001000000010001)
    li  x31, MASK_XLEN(0xfffeffffffffffff)
    li  x15, MASK_XLEN(0x10000)
    sub x17, x15, x31
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x0001000000010001) 
 
    # Testcase 17:  rs1:x14(0x0000000000020000), rs2:x30(0xffff7fffffffffff), result rd:x18(0x0000800000020001)
    li  x30, MASK_XLEN(0xffff7fffffffffff)
    li  x14, MASK_XLEN(0x20000)
    sub x18, x14, x30
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x0000800000020001) 
 
    # Testcase 18:  rs1:x13(0x0000000000040000), rs2:x29(0xffffbfffffffffff), result rd:x19(0x0000400000040001)
    li  x29, MASK_XLEN(0xffffbfffffffffff)
    li  x13, MASK_XLEN(0x40000)
    sub x19, x13, x29
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x0000400000040001) 
 
    # Testcase 19:  rs1:x12(0x0000000000080000), rs2:x28(0xffffdfffffffffff), result rd:x20(0x0000200000080001)
    li  x28, MASK_XLEN(0xffffdfffffffffff)
    li  x12, MASK_XLEN(0x80000)
    sub x20, x12, x28
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0000200000080001) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")


    # address for test results
    la x1, test_5_res

 
    # Testcase 20:  rs1:x11(0x0000000000100000), rs2:x27(0xffffefffffffffff), result rd:x21(0x0000100000100001)
    li  x27, MASK_XLEN(0xffffefffffffffff)
    li  x11, MASK_XLEN(0x100000)
    sub x21, x11, x27
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000100000100001) 
 
    # Testcase 21:  rs1:x10(0x0000000000200000), rs2:x26(0xfffff7ffffffffff), result rd:x22(0x0000080000200001)
    li  x26, MASK_XLEN(0xfffff7ffffffffff)
    li  x10, MASK_XLEN(0x200000)
    sub x22, x10, x26
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000080000200001) 
 
    # Testcase 22:  rs1:x9(0x0000000000400000), rs2:x25(0xfffffbffffffffff), result rd:x23(0x0000040000400001)
    li  x25, MASK_XLEN(0xfffffbffffffffff)
    li  x9, MASK_XLEN(0x400000)
    sub x23, x9, x25
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000040000400001) 
 
    # Testcase 23:  rs1:x8(0x0000000000800000), rs2:x24(0xfffffdffffffffff), result rd:x24(0x0000020000800001)
    li  x24, MASK_XLEN(0xfffffdffffffffff)
    li  x8, MASK_XLEN(0x800000)
    sub x24, x8, x24
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0000020000800001) 
 
    # Testcase 24:  rs1:x7(0x0000000001000000), rs2:x23(0xfffffeffffffffff), result rd:x25(0x0000010001000001)
    li  x23, MASK_XLEN(0xfffffeffffffffff)
    li  x7, MASK_XLEN(0x1000000)
    sub x25, x7, x23
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0000010001000001) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")


    # address for test results
    la x1, test_6_res

 
    # Testcase 25:  rs1:x6(0x0000000002000000), rs2:x22(0xffffff7fffffffff), result rd:x26(0x0000008002000001)
    li  x22, MASK_XLEN(0xffffff7fffffffff)
    li  x6, MASK_XLEN(0x2000000)
    sub x26, x6, x22
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x0000008002000001) 
 
    # Testcase 26:  rs1:x5(0x0000000004000000), rs2:x21(0xffffffbfffffffff), result rd:x27(0x0000004004000001)
    li  x21, MASK_XLEN(0xffffffbfffffffff)
    li  x5, MASK_XLEN(0x4000000)
    sub x27, x5, x21
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x0000004004000001) 
 
    # Testcase 27:  rs1:x4(0x0000000008000000), rs2:x20(0xffffffdfffffffff), result rd:x28(0x0000002008000001)
    li  x20, MASK_XLEN(0xffffffdfffffffff)
    li  x4, MASK_XLEN(0x8000000)
    sub x28, x4, x20
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x0000002008000001) 
 
    # Testcase 28:  rs1:x3(0x0000000010000000), rs2:x19(0xffffffefffffffff), result rd:x29(0x0000001010000001)
    li  x19, MASK_XLEN(0xffffffefffffffff)
    li  x3, MASK_XLEN(0x10000000)
    sub x29, x3, x19
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x0000001010000001) 
 
    # Testcase 29:  rs1:x2(0x0000000020000000), rs2:x18(0xfffffff7ffffffff), result rd:x30(0x0000000820000001)
    li  x18, MASK_XLEN(0xfffffff7ffffffff)
    li  x2, MASK_XLEN(0x20000000)
    sub x30, x2, x18
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x0000000820000001) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")


    # address for test results
    la x5, test_7_res

 
    # Testcase 30:  rs1:x1(0x0000000040000000), rs2:x17(0xfffffffbffffffff), result rd:x31(0x0000000440000001)
    li  x17, MASK_XLEN(0xfffffffbffffffff)
    li  x1, MASK_XLEN(0x40000000)
    sub x31, x1, x17
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0000000440000001) 
 
    # Testcase 31:  rs1:x31(0x0000000080000000), rs2:x16(0xfffffffdffffffff), result rd:x1(0x0000000280000001)
    li  x16, MASK_XLEN(0xfffffffdffffffff)
    li  x31, MASK_XLEN(0x80000000)
    sub x1, x31, x16
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0000000280000001) 
 
    # Testcase 32:  rs1:x30(0x0000000100000000), rs2:x15(0xfffffffeffffffff), result rd:x2(0x0000000200000001)
    li  x15, MASK_XLEN(0xfffffffeffffffff)
    li  x30, MASK_XLEN(0x100000000)
    sub x2, x30, x15
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0000000200000001) 
 
    # Testcase 33:  rs1:x29(0x0000000200000000), rs2:x14(0xffffffff7fffffff), result rd:x3(0x0000000280000001)
    li  x14, MASK_XLEN(0xffffffff7fffffff)
    li  x29, MASK_XLEN(0x200000000)
    sub x3, x29, x14
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x0000000280000001) 
 
    # Testcase 34:  rs1:x28(0x0000000400000000), rs2:x13(0xffffffffbfffffff), result rd:x4(0x0000000440000001)
    li  x13, MASK_XLEN(0xffffffffbfffffff)
    li  x28, MASK_XLEN(0x400000000)
    sub x4, x28, x13
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x0000000440000001) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")


    # address for test results
    la x1, test_8_res

 
    # Testcase 35:  rs1:x27(0x0000000800000000), rs2:x12(0xffffffffdfffffff), result rd:x5(0x0000000820000001)
    li  x12, MASK_XLEN(0xffffffffdfffffff)
    li  x27, MASK_XLEN(0x800000000)
    sub x5, x27, x12
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x0000000820000001) 
 
    # Testcase 36:  rs1:x26(0x0000001000000000), rs2:x11(0xffffffffefffffff), result rd:x6(0x0000001010000001)
    li  x11, MASK_XLEN(0xffffffffefffffff)
    li  x26, MASK_XLEN(0x1000000000)
    sub x6, x26, x11
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0000001010000001) 
 
    # Testcase 37:  rs1:x25(0x0000002000000000), rs2:x10(0xfffffffff7ffffff), result rd:x7(0x0000002008000001)
    li  x10, MASK_XLEN(0xfffffffff7ffffff)
    li  x25, MASK_XLEN(0x2000000000)
    sub x7, x25, x10
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000002008000001) 
 
    # Testcase 38:  rs1:x24(0x0000004000000000), rs2:x9(0xfffffffffbffffff), result rd:x8(0x0000004004000001)
    li  x9, MASK_XLEN(0xfffffffffbffffff)
    li  x24, MASK_XLEN(0x4000000000)
    sub x8, x24, x9
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000004004000001) 
 
    # Testcase 39:  rs1:x23(0x0000008000000000), rs2:x8(0xfffffffffdffffff), result rd:x9(0x0000008002000001)
    li  x8, MASK_XLEN(0xfffffffffdffffff)
    li  x23, MASK_XLEN(0x8000000000)
    sub x9, x23, x8
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000008002000001) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")


    # address for test results
    la x1, test_9_res

 
    # Testcase 40:  rs1:x22(0x0000010000000000), rs2:x7(0xfffffffffeffffff), result rd:x10(0x0000010001000001)
    li  x7, MASK_XLEN(0xfffffffffeffffff)
    li  x22, MASK_XLEN(0x10000000000)
    sub x10, x22, x7
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000010001000001) 
 
    # Testcase 41:  rs1:x21(0x0000020000000000), rs2:x6(0xffffffffff7fffff), result rd:x11(0x0000020000800001)
    li  x6, MASK_XLEN(0xffffffffff7fffff)
    li  x21, MASK_XLEN(0x20000000000)
    sub x11, x21, x6
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0000020000800001) 
 
    # Testcase 42:  rs1:x20(0x0000040000000000), rs2:x5(0xffffffffffbfffff), result rd:x12(0x0000040000400001)
    li  x5, MASK_XLEN(0xffffffffffbfffff)
    li  x20, MASK_XLEN(0x40000000000)
    sub x12, x20, x5
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0x0000040000400001) 
 
    # Testcase 43:  rs1:x19(0x0000080000000000), rs2:x4(0xffffffffffdfffff), result rd:x13(0x0000080000200001)
    li  x4, MASK_XLEN(0xffffffffffdfffff)
    li  x19, MASK_XLEN(0x80000000000)
    sub x13, x19, x4
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0x0000080000200001) 
 
    # Testcase 44:  rs1:x18(0x0000100000000000), rs2:x3(0xffffffffffefffff), result rd:x14(0x0000100000100001)
    li  x3, MASK_XLEN(0xffffffffffefffff)
    li  x18, MASK_XLEN(0x100000000000)
    sub x14, x18, x3
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0x0000100000100001) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")


    # address for test results
    la x3, test_10_res

 
    # Testcase 45:  rs1:x17(0x0000200000000000), rs2:x2(0xfffffffffff7ffff), result rd:x15(0x0000200000080001)
    li  x2, MASK_XLEN(0xfffffffffff7ffff)
    li  x17, MASK_XLEN(0x200000000000)
    sub x15, x17, x2
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0x0000200000080001) 
 
    # Testcase 46:  rs1:x16(0x0000400000000000), rs2:x1(0xfffffffffffbffff), result rd:x16(0x0000400000040001)
    li  x1, MASK_XLEN(0xfffffffffffbffff)
    li  x16, MASK_XLEN(0x400000000000)
    sub x16, x16, x1
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0x0000400000040001) 
 
    # Testcase 47:  rs1:x15(0x0000800000000000), rs2:x31(0xfffffffffffdffff), result rd:x17(0x0000800000020001)
    li  x31, MASK_XLEN(0xfffffffffffdffff)
    li  x15, MASK_XLEN(0x800000000000)
    sub x17, x15, x31
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0x0000800000020001) 
 
    # Testcase 48:  rs1:x14(0x0001000000000000), rs2:x30(0xfffffffffffeffff), result rd:x18(0x0001000000010001)
    li  x30, MASK_XLEN(0xfffffffffffeffff)
    li  x14, MASK_XLEN(0x1000000000000)
    sub x18, x14, x30
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x0001000000010001) 
 
    # Testcase 49:  rs1:x13(0x0002000000000000), rs2:x29(0xffffffffffff7fff), result rd:x19(0x0002000000008001)
    li  x29, MASK_XLEN(0xffffffffffff7fff)
    li  x13, MASK_XLEN(0x2000000000000)
    sub x19, x13, x29
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0002000000008001) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")


    # address for test results
    la x1, test_11_res

 
    # Testcase 50:  rs1:x12(0x0004000000000000), rs2:x28(0xffffffffffffbfff), result rd:x20(0x0004000000004001)
    li  x28, MASK_XLEN(0xffffffffffffbfff)
    li  x12, MASK_XLEN(0x4000000000000)
    sub x20, x12, x28
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0004000000004001) 
 
    # Testcase 51:  rs1:x11(0x0008000000000000), rs2:x27(0xffffffffffffdfff), result rd:x21(0x0008000000002001)
    li  x27, MASK_XLEN(0xffffffffffffdfff)
    li  x11, MASK_XLEN(0x8000000000000)
    sub x21, x11, x27
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0008000000002001) 
 
    # Testcase 52:  rs1:x10(0x0010000000000000), rs2:x26(0xffffffffffffefff), result rd:x22(0x0010000000001001)
    li  x26, MASK_XLEN(0xffffffffffffefff)
    li  x10, MASK_XLEN(0x10000000000000)
    sub x22, x10, x26
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0010000000001001) 
 
    # Testcase 53:  rs1:x9(0x0020000000000000), rs2:x25(0xfffffffffffff7ff), result rd:x23(0x0020000000000801)
    li  x25, MASK_XLEN(0xfffffffffffff7ff)
    li  x9, MASK_XLEN(0x20000000000000)
    sub x23, x9, x25
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0020000000000801) 
 
    # Testcase 54:  rs1:x8(0x0040000000000000), rs2:x24(0xfffffffffffffbff), result rd:x24(0x0040000000000401)
    li  x24, MASK_XLEN(0xfffffffffffffbff)
    li  x8, MASK_XLEN(0x40000000000000)
    sub x24, x8, x24
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0040000000000401) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")


    # address for test results
    la x1, test_12_res

 
    # Testcase 55:  rs1:x7(0x0080000000000000), rs2:x23(0xfffffffffffffdff), result rd:x25(0x0080000000000201)
    li  x23, MASK_XLEN(0xfffffffffffffdff)
    li  x7, MASK_XLEN(0x80000000000000)
    sub x25, x7, x23
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0080000000000201) 
 
    # Testcase 56:  rs1:x6(0x0100000000000000), rs2:x22(0xfffffffffffffeff), result rd:x26(0x0100000000000101)
    li  x22, MASK_XLEN(0xfffffffffffffeff)
    li  x6, MASK_XLEN(0x100000000000000)
    sub x26, x6, x22
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0100000000000101) 
 
    # Testcase 57:  rs1:x5(0x0200000000000000), rs2:x21(0xffffffffffffff7f), result rd:x27(0x0200000000000081)
    li  x21, MASK_XLEN(0xffffffffffffff7f)
    li  x5, MASK_XLEN(0x200000000000000)
    sub x27, x5, x21
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0x0200000000000081) 
 
    # Testcase 58:  rs1:x4(0x0400000000000000), rs2:x20(0xffffffffffffffbf), result rd:x28(0x0400000000000041)
    li  x20, MASK_XLEN(0xffffffffffffffbf)
    li  x4, MASK_XLEN(0x400000000000000)
    sub x28, x4, x20
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0x0400000000000041) 
 
    # Testcase 59:  rs1:x3(0x0800000000000000), rs2:x19(0xffffffffffffffdf), result rd:x29(0x0800000000000021)
    li  x19, MASK_XLEN(0xffffffffffffffdf)
    li  x3, MASK_XLEN(0x800000000000000)
    sub x29, x3, x19
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0x0800000000000021) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")


    # address for test results
    la x4, test_13_res

 
    # Testcase 60:  rs1:x2(0x1000000000000000), rs2:x18(0xffffffffffffffef), result rd:x30(0x1000000000000011)
    li  x18, MASK_XLEN(0xffffffffffffffef)
    li  x2, MASK_XLEN(0x1000000000000000)
    sub x30, x2, x18
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x1000000000000011) 
 
    # Testcase 61:  rs1:x1(0x2000000000000000), rs2:x17(0xfffffffffffffff7), result rd:x31(0x2000000000000009)
    li  x17, MASK_XLEN(0xfffffffffffffff7)
    li  x1, MASK_XLEN(0x2000000000000000)
    sub x31, x1, x17
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x2000000000000009) 
 
    # Testcase 62:  rs1:x31(0x4000000000000000), rs2:x16(0xfffffffffffffffb), result rd:x1(0x4000000000000005)
    li  x16, MASK_XLEN(0xfffffffffffffffb)
    li  x31, MASK_XLEN(0x4000000000000000)
    sub x1, x31, x16
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x4000000000000005) 
 
    # Testcase 63:  rs1:x30(0x8000000000000000), rs2:x15(0xfffffffffffffffd), result rd:x2(0x8000000000000003)
    li  x15, MASK_XLEN(0xfffffffffffffffd)
    li  x30, MASK_XLEN(0x8000000000000000)
    sub x2, x30, x15
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x8000000000000003) 
 
    # Testcase 64:  rs1:x29(0x0000000000000000), rs2:x14(0xfffffffffffffffe), result rd:x3(0x0000000000000002)
    li  x14, MASK_XLEN(0xfffffffffffffffe)
    li  x29, MASK_XLEN(0x0)
    sub x3, x29, x14
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0x0000000000000002) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")


    # address for test results
    la x1, test_14_res

 
    # Testcase 65:  rs1:x28(0xfffffffffffffffe), rs2:x13(0x0000000000000000), result rd:x4(0xfffffffffffffffe)
    li  x13, MASK_XLEN(0x0)
    li  x28, MASK_XLEN(0xfffffffffffffffe)
    sub x4, x28, x13
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xfffffffffffffffe) 
 
    # Testcase 66:  rs1:x27(0xfffffffffffffffd), rs2:x12(0x8000000000000000), result rd:x5(0x7ffffffffffffffd)
    li  x12, MASK_XLEN(0x8000000000000000)
    li  x27, MASK_XLEN(0xfffffffffffffffd)
    sub x5, x27, x12
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x7ffffffffffffffd) 
 
    # Testcase 67:  rs1:x26(0xfffffffffffffffb), rs2:x11(0x4000000000000000), result rd:x6(0xbffffffffffffffb)
    li  x11, MASK_XLEN(0x4000000000000000)
    li  x26, MASK_XLEN(0xfffffffffffffffb)
    sub x6, x26, x11
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xbffffffffffffffb) 
 
    # Testcase 68:  rs1:x25(0xfffffffffffffff7), rs2:x10(0x2000000000000000), result rd:x7(0xdffffffffffffff7)
    li  x10, MASK_XLEN(0x2000000000000000)
    li  x25, MASK_XLEN(0xfffffffffffffff7)
    sub x7, x25, x10
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xdffffffffffffff7) 
 
    # Testcase 69:  rs1:x24(0xffffffffffffffef), rs2:x9(0x1000000000000000), result rd:x8(0xefffffffffffffef)
    li  x9, MASK_XLEN(0x1000000000000000)
    li  x24, MASK_XLEN(0xffffffffffffffef)
    sub x8, x24, x9
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xefffffffffffffef) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")


    # address for test results
    la x1, test_15_res

 
    # Testcase 70:  rs1:x23(0xffffffffffffffdf), rs2:x8(0x0800000000000000), result rd:x9(0xf7ffffffffffffdf)
    li  x8, MASK_XLEN(0x800000000000000)
    li  x23, MASK_XLEN(0xffffffffffffffdf)
    sub x9, x23, x8
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xf7ffffffffffffdf) 
 
    # Testcase 71:  rs1:x22(0xffffffffffffffbf), rs2:x7(0x0400000000000000), result rd:x10(0xfbffffffffffffbf)
    li  x7, MASK_XLEN(0x400000000000000)
    li  x22, MASK_XLEN(0xffffffffffffffbf)
    sub x10, x22, x7
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfbffffffffffffbf) 
 
    # Testcase 72:  rs1:x21(0xffffffffffffff7f), rs2:x6(0x0200000000000000), result rd:x11(0xfdffffffffffff7f)
    li  x6, MASK_XLEN(0x200000000000000)
    li  x21, MASK_XLEN(0xffffffffffffff7f)
    sub x11, x21, x6
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfdffffffffffff7f) 
 
    # Testcase 73:  rs1:x20(0xfffffffffffffeff), rs2:x5(0x0100000000000000), result rd:x12(0xfefffffffffffeff)
    li  x5, MASK_XLEN(0x100000000000000)
    li  x20, MASK_XLEN(0xfffffffffffffeff)
    sub x12, x20, x5
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfefffffffffffeff) 
 
    # Testcase 74:  rs1:x19(0xfffffffffffffdff), rs2:x4(0x0080000000000000), result rd:x13(0xff7ffffffffffdff)
    li  x4, MASK_XLEN(0x80000000000000)
    li  x19, MASK_XLEN(0xfffffffffffffdff)
    sub x13, x19, x4
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xff7ffffffffffdff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")


    # address for test results
    la x4, test_16_res

 
    # Testcase 75:  rs1:x18(0xfffffffffffffbff), rs2:x3(0x0040000000000000), result rd:x14(0xffbffffffffffbff)
    li  x3, MASK_XLEN(0x40000000000000)
    li  x18, MASK_XLEN(0xfffffffffffffbff)
    sub x14, x18, x3
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xffbffffffffffbff) 
 
    # Testcase 76:  rs1:x17(0xfffffffffffff7ff), rs2:x2(0x0020000000000000), result rd:x15(0xffdffffffffff7ff)
    li  x2, MASK_XLEN(0x20000000000000)
    li  x17, MASK_XLEN(0xfffffffffffff7ff)
    sub x15, x17, x2
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xffdffffffffff7ff) 
 
    # Testcase 77:  rs1:x16(0xffffffffffffefff), rs2:x1(0x0010000000000000), result rd:x16(0xffefffffffffefff)
    li  x1, MASK_XLEN(0x10000000000000)
    li  x16, MASK_XLEN(0xffffffffffffefff)
    sub x16, x16, x1
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffefffffffffefff) 
 
    # Testcase 78:  rs1:x15(0xffffffffffffdfff), rs2:x31(0x0008000000000000), result rd:x17(0xfff7ffffffffdfff)
    li  x31, MASK_XLEN(0x8000000000000)
    li  x15, MASK_XLEN(0xffffffffffffdfff)
    sub x17, x15, x31
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xfff7ffffffffdfff) 
 
    # Testcase 79:  rs1:x14(0xffffffffffffbfff), rs2:x30(0x0004000000000000), result rd:x18(0xfffbffffffffbfff)
    li  x30, MASK_XLEN(0x4000000000000)
    li  x14, MASK_XLEN(0xffffffffffffbfff)
    sub x18, x14, x30
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xfffbffffffffbfff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")


    # address for test results
    la x1, test_17_res

 
    # Testcase 80:  rs1:x13(0xffffffffffff7fff), rs2:x29(0x0002000000000000), result rd:x19(0xfffdffffffff7fff)
    li  x29, MASK_XLEN(0x2000000000000)
    li  x13, MASK_XLEN(0xffffffffffff7fff)
    sub x19, x13, x29
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xfffdffffffff7fff) 
 
    # Testcase 81:  rs1:x12(0xfffffffffffeffff), rs2:x28(0x0001000000000000), result rd:x20(0xfffefffffffeffff)
    li  x28, MASK_XLEN(0x1000000000000)
    li  x12, MASK_XLEN(0xfffffffffffeffff)
    sub x20, x12, x28
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffefffffffeffff) 
 
    # Testcase 82:  rs1:x11(0xfffffffffffdffff), rs2:x27(0x0000800000000000), result rd:x21(0xffff7ffffffdffff)
    li  x27, MASK_XLEN(0x800000000000)
    li  x11, MASK_XLEN(0xfffffffffffdffff)
    sub x21, x11, x27
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xffff7ffffffdffff) 
 
    # Testcase 83:  rs1:x10(0xfffffffffffbffff), rs2:x26(0x0000400000000000), result rd:x22(0xffffbffffffbffff)
    li  x26, MASK_XLEN(0x400000000000)
    li  x10, MASK_XLEN(0xfffffffffffbffff)
    sub x22, x10, x26
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffffbffffffbffff) 
 
    # Testcase 84:  rs1:x9(0xfffffffffff7ffff), rs2:x25(0x0000200000000000), result rd:x23(0xffffdffffff7ffff)
    li  x25, MASK_XLEN(0x200000000000)
    li  x9, MASK_XLEN(0xfffffffffff7ffff)
    sub x23, x9, x25
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffdffffff7ffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")


    # address for test results
    la x1, test_18_res

 
    # Testcase 85:  rs1:x8(0xffffffffffefffff), rs2:x24(0x0000100000000000), result rd:x24(0xffffefffffefffff)
    li  x24, MASK_XLEN(0x100000000000)
    li  x8, MASK_XLEN(0xffffffffffefffff)
    sub x24, x8, x24
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffffefffffefffff) 
 
    # Testcase 86:  rs1:x7(0xffffffffffdfffff), rs2:x23(0x0000080000000000), result rd:x25(0xfffff7ffffdfffff)
    li  x23, MASK_XLEN(0x80000000000)
    li  x7, MASK_XLEN(0xffffffffffdfffff)
    sub x25, x7, x23
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xfffff7ffffdfffff) 
 
    # Testcase 87:  rs1:x6(0xffffffffffbfffff), rs2:x22(0x0000040000000000), result rd:x26(0xfffffbffffbfffff)
    li  x22, MASK_XLEN(0x40000000000)
    li  x6, MASK_XLEN(0xffffffffffbfffff)
    sub x26, x6, x22
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xfffffbffffbfffff) 
 
    # Testcase 88:  rs1:x5(0xffffffffff7fffff), rs2:x21(0x0000020000000000), result rd:x27(0xfffffdffff7fffff)
    li  x21, MASK_XLEN(0x20000000000)
    li  x5, MASK_XLEN(0xffffffffff7fffff)
    sub x27, x5, x21
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfffffdffff7fffff) 
 
    # Testcase 89:  rs1:x4(0xfffffffffeffffff), rs2:x20(0x0000010000000000), result rd:x28(0xfffffefffeffffff)
    li  x20, MASK_XLEN(0x10000000000)
    li  x4, MASK_XLEN(0xfffffffffeffffff)
    sub x28, x4, x20
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffffefffeffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")


    # address for test results
    la x4, test_19_res

 
    # Testcase 90:  rs1:x3(0xfffffffffdffffff), rs2:x19(0x0000008000000000), result rd:x29(0xffffff7ffdffffff)
    li  x19, MASK_XLEN(0x8000000000)
    li  x3, MASK_XLEN(0xfffffffffdffffff)
    sub x29, x3, x19
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0xffffff7ffdffffff) 
 
    # Testcase 91:  rs1:x2(0xfffffffffbffffff), rs2:x18(0x0000004000000000), result rd:x30(0xffffffbffbffffff)
    li  x18, MASK_XLEN(0x4000000000)
    li  x2, MASK_XLEN(0xfffffffffbffffff)
    sub x30, x2, x18
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xffffffbffbffffff) 
 
    # Testcase 92:  rs1:x1(0xfffffffff7ffffff), rs2:x17(0x0000002000000000), result rd:x31(0xffffffdff7ffffff)
    li  x17, MASK_XLEN(0x2000000000)
    li  x1, MASK_XLEN(0xfffffffff7ffffff)
    sub x31, x1, x17
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xffffffdff7ffffff) 
 
    # Testcase 93:  rs1:x31(0xffffffffefffffff), rs2:x16(0x0000001000000000), result rd:x1(0xffffffefefffffff)
    li  x16, MASK_XLEN(0x1000000000)
    li  x31, MASK_XLEN(0xffffffffefffffff)
    sub x1, x31, x16
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffffffefefffffff) 
 
    # Testcase 94:  rs1:x30(0xffffffffdfffffff), rs2:x15(0x0000000800000000), result rd:x2(0xfffffff7dfffffff)
    li  x15, MASK_XLEN(0x800000000)
    li  x30, MASK_XLEN(0xffffffffdfffffff)
    sub x2, x30, x15
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xfffffff7dfffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")


    # address for test results
    la x1, test_20_res

 
    # Testcase 95:  rs1:x29(0xffffffffbfffffff), rs2:x14(0x0000000400000000), result rd:x3(0xfffffffbbfffffff)
    li  x14, MASK_XLEN(0x400000000)
    li  x29, MASK_XLEN(0xffffffffbfffffff)
    sub x3, x29, x14
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xfffffffbbfffffff) 
 
    # Testcase 96:  rs1:x28(0xffffffff7fffffff), rs2:x13(0x0000000200000000), result rd:x4(0xfffffffd7fffffff)
    li  x13, MASK_XLEN(0x200000000)
    li  x28, MASK_XLEN(0xffffffff7fffffff)
    sub x4, x28, x13
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xfffffffd7fffffff) 
 
    # Testcase 97:  rs1:x27(0xfffffffeffffffff), rs2:x12(0x0000000100000000), result rd:x5(0xfffffffdffffffff)
    li  x12, MASK_XLEN(0x100000000)
    li  x27, MASK_XLEN(0xfffffffeffffffff)
    sub x5, x27, x12
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffffdffffffff) 
 
    # Testcase 98:  rs1:x26(0xfffffffdffffffff), rs2:x11(0x0000000080000000), result rd:x6(0xfffffffd7fffffff)
    li  x11, MASK_XLEN(0x80000000)
    li  x26, MASK_XLEN(0xfffffffdffffffff)
    sub x6, x26, x11
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfffffffd7fffffff) 
 
    # Testcase 99:  rs1:x25(0xfffffffbffffffff), rs2:x10(0x0000000040000000), result rd:x7(0xfffffffbbfffffff)
    li  x10, MASK_XLEN(0x40000000)
    li  x25, MASK_XLEN(0xfffffffbffffffff)
    sub x7, x25, x10
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xfffffffbbfffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")


    # address for test results
    la x1, test_21_res

 
    # Testcase 100:  rs1:x24(0xfffffff7ffffffff), rs2:x9(0x0000000020000000), result rd:x8(0xfffffff7dfffffff)
    li  x9, MASK_XLEN(0x20000000)
    li  x24, MASK_XLEN(0xfffffff7ffffffff)
    sub x8, x24, x9
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xfffffff7dfffffff) 
 
    # Testcase 101:  rs1:x23(0xffffffefffffffff), rs2:x8(0x0000000010000000), result rd:x9(0xffffffefefffffff)
    li  x8, MASK_XLEN(0x10000000)
    li  x23, MASK_XLEN(0xffffffefffffffff)
    sub x9, x23, x8
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffefefffffff) 
 
    # Testcase 102:  rs1:x22(0xffffffdfffffffff), rs2:x7(0x0000000008000000), result rd:x10(0xffffffdff7ffffff)
    li  x7, MASK_XLEN(0x8000000)
    li  x22, MASK_XLEN(0xffffffdfffffffff)
    sub x10, x22, x7
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffdff7ffffff) 
 
    # Testcase 103:  rs1:x21(0xffffffbfffffffff), rs2:x6(0x0000000004000000), result rd:x11(0xffffffbffbffffff)
    li  x6, MASK_XLEN(0x4000000)
    li  x21, MASK_XLEN(0xffffffbfffffffff)
    sub x11, x21, x6
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xffffffbffbffffff) 
 
    # Testcase 104:  rs1:x20(0xffffff7fffffffff), rs2:x5(0x0000000002000000), result rd:x12(0xffffff7ffdffffff)
    li  x5, MASK_XLEN(0x2000000)
    li  x20, MASK_XLEN(0xffffff7fffffffff)
    sub x12, x20, x5
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffff7ffdffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")


    # address for test results
    la x5, test_22_res

 
    # Testcase 105:  rs1:x19(0xfffffeffffffffff), rs2:x4(0x0000000001000000), result rd:x13(0xfffffefffeffffff)
    li  x4, MASK_XLEN(0x1000000)
    li  x19, MASK_XLEN(0xfffffeffffffffff)
    sub x13, x19, x4
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x13, 0xfffffefffeffffff) 
 
    # Testcase 106:  rs1:x18(0xfffffdffffffffff), rs2:x3(0x0000000000800000), result rd:x14(0xfffffdffff7fffff)
    li  x3, MASK_XLEN(0x800000)
    li  x18, MASK_XLEN(0xfffffdffffffffff)
    sub x14, x18, x3
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xfffffdffff7fffff) 
 
    # Testcase 107:  rs1:x17(0xfffffbffffffffff), rs2:x2(0x0000000000400000), result rd:x15(0xfffffbffffbfffff)
    li  x2, MASK_XLEN(0x400000)
    li  x17, MASK_XLEN(0xfffffbffffffffff)
    sub x15, x17, x2
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xfffffbffffbfffff) 
 
    # Testcase 108:  rs1:x16(0xfffff7ffffffffff), rs2:x1(0x0000000000200000), result rd:x16(0xfffff7ffffdfffff)
    li  x1, MASK_XLEN(0x200000)
    li  x16, MASK_XLEN(0xfffff7ffffffffff)
    sub x16, x16, x1
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xfffff7ffffdfffff) 
 
    # Testcase 109:  rs1:x15(0xffffefffffffffff), rs2:x31(0x0000000000100000), result rd:x17(0xffffefffffefffff)
    li  x31, MASK_XLEN(0x100000)
    li  x15, MASK_XLEN(0xffffefffffffffff)
    sub x17, x15, x31
    sd x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xffffefffffefffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")


    # address for test results
    la x1, test_23_res

 
    # Testcase 110:  rs1:x14(0xffffdfffffffffff), rs2:x30(0x0000000000080000), result rd:x18(0xffffdffffff7ffff)
    li  x30, MASK_XLEN(0x80000)
    li  x14, MASK_XLEN(0xffffdfffffffffff)
    sub x18, x14, x30
    sd x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0xffffdffffff7ffff) 
 
    # Testcase 111:  rs1:x13(0xffffbfffffffffff), rs2:x29(0x0000000000040000), result rd:x19(0xffffbffffffbffff)
    li  x29, MASK_XLEN(0x40000)
    li  x13, MASK_XLEN(0xffffbfffffffffff)
    sub x19, x13, x29
    sd x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xffffbffffffbffff) 
 
    # Testcase 112:  rs1:x12(0xffff7fffffffffff), rs2:x28(0x0000000000020000), result rd:x20(0xffff7ffffffdffff)
    li  x28, MASK_XLEN(0x20000)
    li  x12, MASK_XLEN(0xffff7fffffffffff)
    sub x20, x12, x28
    sd x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xffff7ffffffdffff) 
 
    # Testcase 113:  rs1:x11(0xfffeffffffffffff), rs2:x27(0x0000000000010000), result rd:x21(0xfffefffffffeffff)
    li  x27, MASK_XLEN(0x10000)
    li  x11, MASK_XLEN(0xfffeffffffffffff)
    sub x21, x11, x27
    sd x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffefffffffeffff) 
 
    # Testcase 114:  rs1:x10(0xfffdffffffffffff), rs2:x26(0x0000000000008000), result rd:x22(0xfffdffffffff7fff)
    li  x26, MASK_XLEN(0x8000)
    li  x10, MASK_XLEN(0xfffdffffffffffff)
    sub x22, x10, x26
    sd x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffdffffffff7fff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")


    # address for test results
    la x1, test_24_res

 
    # Testcase 115:  rs1:x9(0xfffbffffffffffff), rs2:x25(0x0000000000004000), result rd:x23(0xfffbffffffffbfff)
    li  x25, MASK_XLEN(0x4000)
    li  x9, MASK_XLEN(0xfffbffffffffffff)
    sub x23, x9, x25
    sd x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xfffbffffffffbfff) 
 
    # Testcase 116:  rs1:x8(0xfff7ffffffffffff), rs2:x24(0x0000000000002000), result rd:x24(0xfff7ffffffffdfff)
    li  x24, MASK_XLEN(0x2000)
    li  x8, MASK_XLEN(0xfff7ffffffffffff)
    sub x24, x8, x24
    sd x24, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xfff7ffffffffdfff) 
 
    # Testcase 117:  rs1:x7(0xffefffffffffffff), rs2:x23(0x0000000000001000), result rd:x25(0xffefffffffffefff)
    li  x23, MASK_XLEN(0x1000)
    li  x7, MASK_XLEN(0xffefffffffffffff)
    sub x25, x7, x23
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffefffffffffefff) 
 
    # Testcase 118:  rs1:x6(0xffdfffffffffffff), rs2:x22(0x0000000000000800), result rd:x26(0xffdffffffffff7ff)
    li  x22, MASK_XLEN(0x800)
    li  x6, MASK_XLEN(0xffdfffffffffffff)
    sub x26, x6, x22
    sd x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffdffffffffff7ff) 
 
    # Testcase 119:  rs1:x5(0xffbfffffffffffff), rs2:x21(0x0000000000000400), result rd:x27(0xffbffffffffffbff)
    li  x21, MASK_XLEN(0x400)
    li  x5, MASK_XLEN(0xffbfffffffffffff)
    sub x27, x5, x21
    sd x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xffbffffffffffbff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")


    # address for test results
    la x5, test_25_res

 
    # Testcase 120:  rs1:x4(0xff7fffffffffffff), rs2:x20(0x0000000000000200), result rd:x28(0xff7ffffffffffdff)
    li  x20, MASK_XLEN(0x200)
    li  x4, MASK_XLEN(0xff7fffffffffffff)
    sub x28, x4, x20
    sd x28, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x28, 0xff7ffffffffffdff) 
 
    # Testcase 121:  rs1:x3(0xfeffffffffffffff), rs2:x19(0x0000000000000100), result rd:x29(0xfefffffffffffeff)
    li  x19, MASK_XLEN(0x100)
    li  x3, MASK_XLEN(0xfeffffffffffffff)
    sub x29, x3, x19
    sd x29, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x29, 0xfefffffffffffeff) 
 
    # Testcase 122:  rs1:x2(0xfdffffffffffffff), rs2:x18(0x0000000000000080), result rd:x30(0xfdffffffffffff7f)
    li  x18, MASK_XLEN(0x80)
    li  x2, MASK_XLEN(0xfdffffffffffffff)
    sub x30, x2, x18
    sd x30, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0xfdffffffffffff7f) 
 
    # Testcase 123:  rs1:x1(0xfbffffffffffffff), rs2:x17(0x0000000000000040), result rd:x31(0xfbffffffffffffbf)
    li  x17, MASK_XLEN(0x40)
    li  x1, MASK_XLEN(0xfbffffffffffffff)
    sub x31, x1, x17
    sd x31, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xfbffffffffffffbf) 
 
    # Testcase 124:  rs1:x31(0xf7ffffffffffffff), rs2:x16(0x0000000000000020), result rd:x1(0xf7ffffffffffffdf)
    li  x16, MASK_XLEN(0x20)
    li  x31, MASK_XLEN(0xf7ffffffffffffff)
    sub x1, x31, x16
    sd x1, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xf7ffffffffffffdf) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")


    # address for test results
    la x1, test_26_res

 
    # Testcase 125:  rs1:x30(0xefffffffffffffff), rs2:x15(0x0000000000000010), result rd:x2(0xefffffffffffffef)
    li  x15, MASK_XLEN(0x10)
    li  x30, MASK_XLEN(0xefffffffffffffff)
    sub x2, x30, x15
    sd x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xefffffffffffffef) 
 
    # Testcase 126:  rs1:x29(0xdfffffffffffffff), rs2:x14(0x0000000000000008), result rd:x3(0xdffffffffffffff7)
    li  x14, MASK_XLEN(0x8)
    li  x29, MASK_XLEN(0xdfffffffffffffff)
    sub x3, x29, x14
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xdffffffffffffff7) 
 
    # Testcase 127:  rs1:x28(0xbfffffffffffffff), rs2:x13(0x0000000000000004), result rd:x4(0xbffffffffffffffb)
    li  x13, MASK_XLEN(0x4)
    li  x28, MASK_XLEN(0xbfffffffffffffff)
    sub x4, x28, x13
    sd x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xbffffffffffffffb) 
 
    # Testcase 128:  rs1:x27(0x7fffffffffffffff), rs2:x12(0x0000000000000002), result rd:x5(0x7ffffffffffffffd)
    li  x12, MASK_XLEN(0x2)
    li  x27, MASK_XLEN(0x7fffffffffffffff)
    sub x5, x27, x12
    sd x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x7ffffffffffffffd) 
 
    # Testcase 129:  rs1:x26(0xffffffffffffffff), rs2:x11(0x0000000000000001), result rd:x6(0xfffffffffffffffe)
    li  x11, MASK_XLEN(0x1)
    li  x26, MASK_XLEN(0xffffffffffffffff)
    sub x6, x26, x11
    sd x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x6, 0xfffffffffffffffe) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")


    # address for test results
    la x1, test_27_res

 
    # Testcase 130:  rs1:x25(0x0000000000000001), rs2:x10(0x0000000000000000), result rd:x7(0x0000000000000001)
    li  x10, MASK_XLEN(0x0)
    li  x25, MASK_XLEN(0x1)
    sub x7, x25, x10
    sd x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000000000001) 
 
    # Testcase 131:  rs1:x24(0x0000000000000002), rs2:x9(0x0000000000000000), result rd:x8(0x0000000000000002)
    li  x9, MASK_XLEN(0x0)
    li  x24, MASK_XLEN(0x2)
    sub x8, x24, x9
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000000000002) 
 
    # Testcase 132:  rs1:x23(0x0000000000000004), rs2:x8(0x0000000000000000), result rd:x9(0x0000000000000004)
    li  x8, MASK_XLEN(0x0)
    li  x23, MASK_XLEN(0x4)
    sub x9, x23, x8
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000004) 
 
    # Testcase 133:  rs1:x22(0x0000000000000008), rs2:x7(0x0000000000000000), result rd:x10(0x0000000000000008)
    li  x7, MASK_XLEN(0x0)
    li  x22, MASK_XLEN(0x8)
    sub x10, x22, x7
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000000000008) 
 
    # Testcase 134:  rs1:x21(0x0000000000000010), rs2:x6(0x0000000000000000), result rd:x11(0x0000000000000010)
    li  x6, MASK_XLEN(0x0)
    li  x21, MASK_XLEN(0x10)
    sub x11, x21, x6
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x0000000000000010) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")


    # address for test results
    la x6, test_28_res

 
    # Testcase 135:  rs1:x20(0x0000000000000020), rs2:x5(0x0000000000000000), result rd:x12(0x0000000000000020)
    li  x5, MASK_XLEN(0x0)
    li  x20, MASK_XLEN(0x20)
    sub x12, x20, x5
    sd x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x0000000000000020) 
 
    # Testcase 136:  rs1:x19(0x0000000000000040), rs2:x4(0x0000000000000000), result rd:x13(0x0000000000000040)
    li  x4, MASK_XLEN(0x0)
    li  x19, MASK_XLEN(0x40)
    sub x13, x19, x4
    sd x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0000000000000040) 
 
    # Testcase 137:  rs1:x18(0x0000000000000080), rs2:x3(0x0000000000000000), result rd:x14(0x0000000000000080)
    li  x3, MASK_XLEN(0x0)
    li  x18, MASK_XLEN(0x80)
    sub x14, x18, x3
    sd x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0000000000000080) 
 
    # Testcase 138:  rs1:x17(0x0000000000000100), rs2:x2(0x0000000000000000), result rd:x15(0x0000000000000100)
    li  x2, MASK_XLEN(0x0)
    li  x17, MASK_XLEN(0x100)
    sub x15, x17, x2
    sd x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0000000000000100) 
 
    # Testcase 139:  rs1:x16(0x0000000000000200), rs2:x1(0x0000000000000000), result rd:x16(0x0000000000000200)
    li  x1, MASK_XLEN(0x0)
    li  x16, MASK_XLEN(0x200)
    sub x16, x16, x1
    sd x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x0000000000000200) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")


    # address for test results
    la x1, test_29_res

 
    # Testcase 140:  rs1:x15(0x0000000000000400), rs2:x31(0x0000000000000000), result rd:x17(0x0000000000000400)
    li  x31, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x400)
    sub x17, x15, x31
    sd x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x17, 0x0000000000000400) 
 
    # Testcase 141:  rs1:x14(0x0000000000000800), rs2:x30(0x0000000000000000), result rd:x18(0x0000000000000800)
    li  x30, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x800)
    sub x18, x14, x30
    sd x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x18, 0x0000000000000800) 
 
    # Testcase 142:  rs1:x13(0x0000000000001000), rs2:x29(0x0000000000000000), result rd:x19(0x0000000000001000)
    li  x29, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x1000)
    sub x19, x13, x29
    sd x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0x0000000000001000) 
 
    # Testcase 143:  rs1:x12(0x0000000000002000), rs2:x28(0x0000000000000000), result rd:x20(0x0000000000002000)
    li  x28, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x2000)
    sub x20, x12, x28
    sd x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0x0000000000002000) 
 
    # Testcase 144:  rs1:x11(0x0000000000004000), rs2:x27(0x0000000000000000), result rd:x21(0x0000000000004000)
    li  x27, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x4000)
    sub x21, x11, x27
    sd x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000000000004000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")


    # address for test results
    la x1, test_30_res

 
    # Testcase 145:  rs1:x10(0x0000000000008000), rs2:x26(0x0000000000000000), result rd:x22(0x0000000000008000)
    li  x26, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x8000)
    sub x22, x10, x26
    sd x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000000000008000) 
 
    # Testcase 146:  rs1:x9(0x0000000000010000), rs2:x25(0x0000000000000000), result rd:x23(0x0000000000010000)
    li  x25, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x10000)
    sub x23, x9, x25
    sd x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000000000010000) 
 
    # Testcase 147:  rs1:x8(0x0000000000020000), rs2:x24(0x0000000000000000), result rd:x24(0x0000000000020000)
    li  x24, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x20000)
    sub x24, x8, x24
    sd x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0000000000020000) 
 
    # Testcase 148:  rs1:x7(0x0000000000040000), rs2:x23(0x0000000000000000), result rd:x25(0x0000000000040000)
    li  x23, MASK_XLEN(0x0)
    li  x7, MASK_XLEN(0x40000)
    sub x25, x7, x23
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0000000000040000) 
 
    # Testcase 149:  rs1:x6(0x0000000000080000), rs2:x22(0x0000000000000000), result rd:x26(0x0000000000080000)
    li  x22, MASK_XLEN(0x0)
    li  x6, MASK_XLEN(0x80000)
    sub x26, x6, x22
    sd x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0x0000000000080000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")


    # address for test results
    la x6, test_31_res

 
    # Testcase 150:  rs1:x5(0x0000000000100000), rs2:x21(0x0000000000000000), result rd:x27(0x0000000000100000)
    li  x21, MASK_XLEN(0x0)
    li  x5, MASK_XLEN(0x100000)
    sub x27, x5, x21
    sd x27, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x0000000000100000) 
 
    # Testcase 151:  rs1:x4(0x0000000000200000), rs2:x20(0x0000000000000000), result rd:x28(0x0000000000200000)
    li  x20, MASK_XLEN(0x0)
    li  x4, MASK_XLEN(0x200000)
    sub x28, x4, x20
    sd x28, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x0000000000200000) 
 
    # Testcase 152:  rs1:x3(0x0000000000400000), rs2:x19(0x0000000000000000), result rd:x29(0x0000000000400000)
    li  x19, MASK_XLEN(0x0)
    li  x3, MASK_XLEN(0x400000)
    sub x29, x3, x19
    sd x29, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x0000000000400000) 
 
    # Testcase 153:  rs1:x2(0x0000000000800000), rs2:x18(0x0000000000000000), result rd:x30(0x0000000000800000)
    li  x18, MASK_XLEN(0x0)
    li  x2, MASK_XLEN(0x800000)
    sub x30, x2, x18
    sd x30, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x0000000000800000) 
 
    # Testcase 154:  rs1:x1(0x0000000001000000), rs2:x17(0x0000000000000000), result rd:x31(0x0000000001000000)
    li  x17, MASK_XLEN(0x0)
    li  x1, MASK_XLEN(0x1000000)
    sub x31, x1, x17
    sd x31, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x0000000001000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")


    # address for test results
    la x6, test_32_res

 
    # Testcase 155:  rs1:x31(0x0000000002000000), rs2:x16(0x0000000000000000), result rd:x1(0x0000000002000000)
    li  x16, MASK_XLEN(0x0)
    li  x31, MASK_XLEN(0x2000000)
    sub x1, x31, x16
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x0000000002000000) 
 
    # Testcase 156:  rs1:x30(0x0000000004000000), rs2:x15(0x0000000000000000), result rd:x2(0x0000000004000000)
    li  x15, MASK_XLEN(0x0)
    li  x30, MASK_XLEN(0x4000000)
    sub x2, x30, x15
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x0000000004000000) 
 
    # Testcase 157:  rs1:x29(0x0000000008000000), rs2:x14(0x0000000000000000), result rd:x3(0x0000000008000000)
    li  x14, MASK_XLEN(0x0)
    li  x29, MASK_XLEN(0x8000000)
    sub x3, x29, x14
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0000000008000000) 
 
    # Testcase 158:  rs1:x28(0x0000000010000000), rs2:x13(0x0000000000000000), result rd:x4(0x0000000010000000)
    li  x13, MASK_XLEN(0x0)
    li  x28, MASK_XLEN(0x10000000)
    sub x4, x28, x13
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x0000000010000000) 
 
    # Testcase 159:  rs1:x27(0x0000000020000000), rs2:x12(0x0000000000000000), result rd:x5(0x0000000020000000)
    li  x12, MASK_XLEN(0x0)
    li  x27, MASK_XLEN(0x20000000)
    sub x5, x27, x12
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x5, 0x0000000020000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")


    # address for test results
    la x1, test_33_res

 
    # Testcase 160:  rs1:x26(0x0000000040000000), rs2:x11(0x0000000000000000), result rd:x6(0x0000000040000000)
    li  x11, MASK_XLEN(0x0)
    li  x26, MASK_XLEN(0x40000000)
    sub x6, x26, x11
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x0000000040000000) 
 
    # Testcase 161:  rs1:x25(0x0000000080000000), rs2:x10(0x0000000000000000), result rd:x7(0x0000000080000000)
    li  x10, MASK_XLEN(0x0)
    li  x25, MASK_XLEN(0x80000000)
    sub x7, x25, x10
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x0000000080000000) 
 
    # Testcase 162:  rs1:x24(0x0000000100000000), rs2:x9(0x0000000000000000), result rd:x8(0x0000000100000000)
    li  x9, MASK_XLEN(0x0)
    li  x24, MASK_XLEN(0x100000000)
    sub x8, x24, x9
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x0000000100000000) 
 
    # Testcase 163:  rs1:x23(0x0000000200000000), rs2:x8(0x0000000000000000), result rd:x9(0x0000000200000000)
    li  x8, MASK_XLEN(0x0)
    li  x23, MASK_XLEN(0x200000000)
    sub x9, x23, x8
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000200000000) 
 
    # Testcase 164:  rs1:x22(0x0000000400000000), rs2:x7(0x0000000000000000), result rd:x10(0x0000000400000000)
    li  x7, MASK_XLEN(0x0)
    li  x22, MASK_XLEN(0x400000000)
    sub x10, x22, x7
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0x0000000400000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")


    # address for test results
    la x1, test_34_res

 
    # Testcase 165:  rs1:x21(0x0000000800000000), rs2:x6(0x0000000000000000), result rd:x11(0x0000000800000000)
    li  x6, MASK_XLEN(0x0)
    li  x21, MASK_XLEN(0x800000000)
    sub x11, x21, x6
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x11, 0x0000000800000000) 
 
    # Testcase 166:  rs1:x20(0x0000001000000000), rs2:x5(0x0000000000000000), result rd:x12(0x0000001000000000)
    li  x5, MASK_XLEN(0x0)
    li  x20, MASK_XLEN(0x1000000000)
    sub x12, x20, x5
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x12, 0x0000001000000000) 
 
    # Testcase 167:  rs1:x19(0x0000002000000000), rs2:x4(0x0000000000000000), result rd:x13(0x0000002000000000)
    li  x4, MASK_XLEN(0x0)
    li  x19, MASK_XLEN(0x2000000000)
    sub x13, x19, x4
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0000002000000000) 
 
    # Testcase 168:  rs1:x18(0x0000004000000000), rs2:x3(0x0000000000000000), result rd:x14(0x0000004000000000)
    li  x3, MASK_XLEN(0x0)
    li  x18, MASK_XLEN(0x4000000000)
    sub x14, x18, x3
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0000004000000000) 
 
    # Testcase 169:  rs1:x17(0x0000008000000000), rs2:x2(0x0000000000000000), result rd:x15(0x0000008000000000)
    li  x2, MASK_XLEN(0x0)
    li  x17, MASK_XLEN(0x8000000000)
    sub x15, x17, x2
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0000008000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")


    # address for test results
    la x2, test_35_res

 
    # Testcase 170:  rs1:x16(0x0000010000000000), rs2:x1(0x0000000000000000), result rd:x16(0x0000010000000000)
    li  x1, MASK_XLEN(0x0)
    li  x16, MASK_XLEN(0x10000000000)
    sub x16, x16, x1
    sd x16, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x16, 0x0000010000000000) 
 
    # Testcase 171:  rs1:x15(0x0000020000000000), rs2:x31(0x0000000000000000), result rd:x17(0x0000020000000000)
    li  x31, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0x20000000000)
    sub x17, x15, x31
    sd x17, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x17, 0x0000020000000000) 
 
    # Testcase 172:  rs1:x14(0x0000040000000000), rs2:x30(0x0000000000000000), result rd:x18(0x0000040000000000)
    li  x30, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0x40000000000)
    sub x18, x14, x30
    sd x18, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x18, 0x0000040000000000) 
 
    # Testcase 173:  rs1:x13(0x0000080000000000), rs2:x29(0x0000000000000000), result rd:x19(0x0000080000000000)
    li  x29, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0x80000000000)
    sub x19, x13, x29
    sd x19, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x19, 0x0000080000000000) 
 
    # Testcase 174:  rs1:x12(0x0000100000000000), rs2:x28(0x0000000000000000), result rd:x20(0x0000100000000000)
    li  x28, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0x100000000000)
    sub x20, x12, x28
    sd x20, 32(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x20, 0x0000100000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")


    # address for test results
    la x1, test_36_res

 
    # Testcase 175:  rs1:x11(0x0000200000000000), rs2:x27(0x0000000000000000), result rd:x21(0x0000200000000000)
    li  x27, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0x200000000000)
    sub x21, x11, x27
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0x0000200000000000) 
 
    # Testcase 176:  rs1:x10(0x0000400000000000), rs2:x26(0x0000000000000000), result rd:x22(0x0000400000000000)
    li  x26, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0x400000000000)
    sub x22, x10, x26
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0x0000400000000000) 
 
    # Testcase 177:  rs1:x9(0x0000800000000000), rs2:x25(0x0000000000000000), result rd:x23(0x0000800000000000)
    li  x25, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0x800000000000)
    sub x23, x9, x25
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0x0000800000000000) 
 
    # Testcase 178:  rs1:x8(0x0001000000000000), rs2:x24(0x0000000000000000), result rd:x24(0x0001000000000000)
    li  x24, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0x1000000000000)
    sub x24, x8, x24
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0x0001000000000000) 
 
    # Testcase 179:  rs1:x7(0x0002000000000000), rs2:x23(0x0000000000000000), result rd:x25(0x0002000000000000)
    li  x23, MASK_XLEN(0x0)
    li  x7, MASK_XLEN(0x2000000000000)
    sub x25, x7, x23
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0x0002000000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")


    # address for test results
    la x1, test_37_res

 
    # Testcase 180:  rs1:x6(0x0004000000000000), rs2:x22(0x0000000000000000), result rd:x26(0x0004000000000000)
    li  x22, MASK_XLEN(0x0)
    li  x6, MASK_XLEN(0x4000000000000)
    sub x26, x6, x22
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x26, 0x0004000000000000) 
 
    # Testcase 181:  rs1:x5(0x0008000000000000), rs2:x21(0x0000000000000000), result rd:x27(0x0008000000000000)
    li  x21, MASK_XLEN(0x0)
    li  x5, MASK_XLEN(0x8000000000000)
    sub x27, x5, x21
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x27, 0x0008000000000000) 
 
    # Testcase 182:  rs1:x4(0x0010000000000000), rs2:x20(0x0000000000000000), result rd:x28(0x0010000000000000)
    li  x20, MASK_XLEN(0x0)
    li  x4, MASK_XLEN(0x10000000000000)
    sub x28, x4, x20
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x28, 0x0010000000000000) 
 
    # Testcase 183:  rs1:x3(0x0020000000000000), rs2:x19(0x0000000000000000), result rd:x29(0x0020000000000000)
    li  x19, MASK_XLEN(0x0)
    li  x3, MASK_XLEN(0x20000000000000)
    sub x29, x3, x19
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x29, 0x0020000000000000) 
 
    # Testcase 184:  rs1:x2(0x0040000000000000), rs2:x18(0x0000000000000000), result rd:x30(0x0040000000000000)
    li  x18, MASK_XLEN(0x0)
    li  x2, MASK_XLEN(0x40000000000000)
    sub x30, x2, x18
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x30, 0x0040000000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")


    # address for test results
    la x5, test_38_res

 
    # Testcase 185:  rs1:x1(0x0080000000000000), rs2:x17(0x0000000000000000), result rd:x31(0x0080000000000000)
    li  x17, MASK_XLEN(0x0)
    li  x1, MASK_XLEN(0x80000000000000)
    sub x31, x1, x17
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0080000000000000) 
 
    # Testcase 186:  rs1:x31(0x0100000000000000), rs2:x16(0x0000000000000000), result rd:x1(0x0100000000000000)
    li  x16, MASK_XLEN(0x0)
    li  x31, MASK_XLEN(0x100000000000000)
    sub x1, x31, x16
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0100000000000000) 
 
    # Testcase 187:  rs1:x30(0x0200000000000000), rs2:x15(0x0000000000000000), result rd:x2(0x0200000000000000)
    li  x15, MASK_XLEN(0x0)
    li  x30, MASK_XLEN(0x200000000000000)
    sub x2, x30, x15
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0200000000000000) 
 
    # Testcase 188:  rs1:x29(0x0400000000000000), rs2:x14(0x0000000000000000), result rd:x3(0x0400000000000000)
    li  x14, MASK_XLEN(0x0)
    li  x29, MASK_XLEN(0x400000000000000)
    sub x3, x29, x14
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x0400000000000000) 
 
    # Testcase 189:  rs1:x28(0x0800000000000000), rs2:x13(0x0000000000000000), result rd:x4(0x0800000000000000)
    li  x13, MASK_XLEN(0x0)
    li  x28, MASK_XLEN(0x800000000000000)
    sub x4, x28, x13
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x4, 0x0800000000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")


    # address for test results
    la x1, test_39_res

 
    # Testcase 190:  rs1:x27(0x1000000000000000), rs2:x12(0x0000000000000000), result rd:x5(0x1000000000000000)
    li  x12, MASK_XLEN(0x0)
    li  x27, MASK_XLEN(0x1000000000000000)
    sub x5, x27, x12
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0x1000000000000000) 
 
    # Testcase 191:  rs1:x26(0x2000000000000000), rs2:x11(0x0000000000000000), result rd:x6(0x2000000000000000)
    li  x11, MASK_XLEN(0x0)
    li  x26, MASK_XLEN(0x2000000000000000)
    sub x6, x26, x11
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0x2000000000000000) 
 
    # Testcase 192:  rs1:x25(0x4000000000000000), rs2:x10(0x0000000000000000), result rd:x7(0x4000000000000000)
    li  x10, MASK_XLEN(0x0)
    li  x25, MASK_XLEN(0x4000000000000000)
    sub x7, x25, x10
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0x4000000000000000) 
 
    # Testcase 193:  rs1:x24(0x8000000000000000), rs2:x9(0x0000000000000000), result rd:x8(0x8000000000000000)
    li  x9, MASK_XLEN(0x0)
    li  x24, MASK_XLEN(0x8000000000000000)
    sub x8, x24, x9
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0x8000000000000000) 
 
    # Testcase 194:  rs1:x23(0x0000000000000000), rs2:x8(0x0000000000000000), result rd:x9(0x0000000000000000)
    li  x8, MASK_XLEN(0x0)
    li  x23, MASK_XLEN(0x0)
    sub x9, x23, x8
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0x0000000000000000) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")


    # address for test results
    la x1, test_40_res

 
    # Testcase 195:  rs1:x22(0xfffffffffffffffe), rs2:x7(0x0000000000000000), result rd:x10(0xfffffffffffffffe)
    li  x7, MASK_XLEN(0x0)
    li  x22, MASK_XLEN(0xfffffffffffffffe)
    sub x10, x22, x7
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xfffffffffffffffe) 
 
    # Testcase 196:  rs1:x21(0xfffffffffffffffd), rs2:x6(0x0000000000000000), result rd:x11(0xfffffffffffffffd)
    li  x6, MASK_XLEN(0x0)
    li  x21, MASK_XLEN(0xfffffffffffffffd)
    sub x11, x21, x6
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffffffffffd) 
 
    # Testcase 197:  rs1:x20(0xfffffffffffffffb), rs2:x5(0x0000000000000000), result rd:x12(0xfffffffffffffffb)
    li  x5, MASK_XLEN(0x0)
    li  x20, MASK_XLEN(0xfffffffffffffffb)
    sub x12, x20, x5
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffffffffffb) 
 
    # Testcase 198:  rs1:x19(0xfffffffffffffff7), rs2:x4(0x0000000000000000), result rd:x13(0xfffffffffffffff7)
    li  x4, MASK_XLEN(0x0)
    li  x19, MASK_XLEN(0xfffffffffffffff7)
    sub x13, x19, x4
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffffffffff7) 
 
    # Testcase 199:  rs1:x18(0xffffffffffffffef), rs2:x3(0x0000000000000000), result rd:x14(0xffffffffffffffef)
    li  x3, MASK_XLEN(0x0)
    li  x18, MASK_XLEN(0xffffffffffffffef)
    sub x14, x18, x3
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x14, 0xffffffffffffffef) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")


    # address for test results
    la x3, test_41_res

 
    # Testcase 200:  rs1:x17(0xffffffffffffffdf), rs2:x2(0x0000000000000000), result rd:x15(0xffffffffffffffdf)
    li  x2, MASK_XLEN(0x0)
    li  x17, MASK_XLEN(0xffffffffffffffdf)
    sub x15, x17, x2
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x15, 0xffffffffffffffdf) 
 
    # Testcase 201:  rs1:x16(0xffffffffffffffbf), rs2:x1(0x0000000000000000), result rd:x16(0xffffffffffffffbf)
    li  x1, MASK_XLEN(0x0)
    li  x16, MASK_XLEN(0xffffffffffffffbf)
    sub x16, x16, x1
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x16, 0xffffffffffffffbf) 
 
    # Testcase 202:  rs1:x15(0xffffffffffffff7f), rs2:x31(0x0000000000000000), result rd:x17(0xffffffffffffff7f)
    li  x31, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffffffffffff7f)
    sub x17, x15, x31
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xffffffffffffff7f) 
 
    # Testcase 203:  rs1:x14(0xfffffffffffffeff), rs2:x30(0x0000000000000000), result rd:x18(0xfffffffffffffeff)
    li  x30, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xfffffffffffffeff)
    sub x18, x14, x30
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0xfffffffffffffeff) 
 
    # Testcase 204:  rs1:x13(0xfffffffffffffdff), rs2:x29(0x0000000000000000), result rd:x19(0xfffffffffffffdff)
    li  x29, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffffffffffdff)
    sub x19, x13, x29
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xfffffffffffffdff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")


    # address for test results
    la x1, test_42_res

 
    # Testcase 205:  rs1:x12(0xfffffffffffffbff), rs2:x28(0x0000000000000000), result rd:x20(0xfffffffffffffbff)
    li  x28, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffffffffffbff)
    sub x20, x12, x28
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffffffffffffbff) 
 
    # Testcase 206:  rs1:x11(0xfffffffffffff7ff), rs2:x27(0x0000000000000000), result rd:x21(0xfffffffffffff7ff)
    li  x27, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffffffffff7ff)
    sub x21, x11, x27
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffffffffff7ff) 
 
    # Testcase 207:  rs1:x10(0xffffffffffffefff), rs2:x26(0x0000000000000000), result rd:x22(0xffffffffffffefff)
    li  x26, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xffffffffffffefff)
    sub x22, x10, x26
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xffffffffffffefff) 
 
    # Testcase 208:  rs1:x9(0xffffffffffffdfff), rs2:x25(0x0000000000000000), result rd:x23(0xffffffffffffdfff)
    li  x25, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffffffffffdfff)
    sub x23, x9, x25
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffffffffffdfff) 
 
    # Testcase 209:  rs1:x8(0xffffffffffffbfff), rs2:x24(0x0000000000000000), result rd:x24(0xffffffffffffbfff)
    li  x24, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffffffffffbfff)
    sub x24, x8, x24
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffffffffffffbfff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")


    # address for test results
    la x1, test_43_res

 
    # Testcase 210:  rs1:x7(0xffffffffffff7fff), rs2:x23(0x0000000000000000), result rd:x25(0xffffffffffff7fff)
    li  x23, MASK_XLEN(0x0)
    li  x7, MASK_XLEN(0xffffffffffff7fff)
    sub x25, x7, x23
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffffffffff7fff) 
 
    # Testcase 211:  rs1:x6(0xfffffffffffeffff), rs2:x22(0x0000000000000000), result rd:x26(0xfffffffffffeffff)
    li  x22, MASK_XLEN(0x0)
    li  x6, MASK_XLEN(0xfffffffffffeffff)
    sub x26, x6, x22
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xfffffffffffeffff) 
 
    # Testcase 212:  rs1:x5(0xfffffffffffdffff), rs2:x21(0x0000000000000000), result rd:x27(0xfffffffffffdffff)
    li  x21, MASK_XLEN(0x0)
    li  x5, MASK_XLEN(0xfffffffffffdffff)
    sub x27, x5, x21
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfffffffffffdffff) 
 
    # Testcase 213:  rs1:x4(0xfffffffffffbffff), rs2:x20(0x0000000000000000), result rd:x28(0xfffffffffffbffff)
    li  x20, MASK_XLEN(0x0)
    li  x4, MASK_XLEN(0xfffffffffffbffff)
    sub x28, x4, x20
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffffffffffbffff) 
 
    # Testcase 214:  rs1:x3(0xfffffffffff7ffff), rs2:x19(0x0000000000000000), result rd:x29(0xfffffffffff7ffff)
    li  x19, MASK_XLEN(0x0)
    li  x3, MASK_XLEN(0xfffffffffff7ffff)
    sub x29, x3, x19
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x29, 0xfffffffffff7ffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")


    # address for test results
    la x4, test_44_res

 
    # Testcase 215:  rs1:x2(0xffffffffffefffff), rs2:x18(0x0000000000000000), result rd:x30(0xffffffffffefffff)
    li  x18, MASK_XLEN(0x0)
    li  x2, MASK_XLEN(0xffffffffffefffff)
    sub x30, x2, x18
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xffffffffffefffff) 
 
    # Testcase 216:  rs1:x1(0xffffffffffdfffff), rs2:x17(0x0000000000000000), result rd:x31(0xffffffffffdfffff)
    li  x17, MASK_XLEN(0x0)
    li  x1, MASK_XLEN(0xffffffffffdfffff)
    sub x31, x1, x17
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xffffffffffdfffff) 
 
    # Testcase 217:  rs1:x31(0xffffffffffbfffff), rs2:x16(0x0000000000000000), result rd:x1(0xffffffffffbfffff)
    li  x16, MASK_XLEN(0x0)
    li  x31, MASK_XLEN(0xffffffffffbfffff)
    sub x1, x31, x16
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffffffffffbfffff) 
 
    # Testcase 218:  rs1:x30(0xffffffffff7fffff), rs2:x15(0x0000000000000000), result rd:x2(0xffffffffff7fffff)
    li  x15, MASK_XLEN(0x0)
    li  x30, MASK_XLEN(0xffffffffff7fffff)
    sub x2, x30, x15
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffffffffff7fffff) 
 
    # Testcase 219:  rs1:x29(0xfffffffffeffffff), rs2:x14(0x0000000000000000), result rd:x3(0xfffffffffeffffff)
    li  x14, MASK_XLEN(0x0)
    li  x29, MASK_XLEN(0xfffffffffeffffff)
    sub x3, x29, x14
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x3, 0xfffffffffeffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")


    # address for test results
    la x1, test_45_res

 
    # Testcase 220:  rs1:x28(0xfffffffffdffffff), rs2:x13(0x0000000000000000), result rd:x4(0xfffffffffdffffff)
    li  x13, MASK_XLEN(0x0)
    li  x28, MASK_XLEN(0xfffffffffdffffff)
    sub x4, x28, x13
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xfffffffffdffffff) 
 
    # Testcase 221:  rs1:x27(0xfffffffffbffffff), rs2:x12(0x0000000000000000), result rd:x5(0xfffffffffbffffff)
    li  x12, MASK_XLEN(0x0)
    li  x27, MASK_XLEN(0xfffffffffbffffff)
    sub x5, x27, x12
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfffffffffbffffff) 
 
    # Testcase 222:  rs1:x26(0xfffffffff7ffffff), rs2:x11(0x0000000000000000), result rd:x6(0xfffffffff7ffffff)
    li  x11, MASK_XLEN(0x0)
    li  x26, MASK_XLEN(0xfffffffff7ffffff)
    sub x6, x26, x11
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfffffffff7ffffff) 
 
    # Testcase 223:  rs1:x25(0xffffffffefffffff), rs2:x10(0x0000000000000000), result rd:x7(0xffffffffefffffff)
    li  x10, MASK_XLEN(0x0)
    li  x25, MASK_XLEN(0xffffffffefffffff)
    sub x7, x25, x10
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xffffffffefffffff) 
 
    # Testcase 224:  rs1:x24(0xffffffffdfffffff), rs2:x9(0x0000000000000000), result rd:x8(0xffffffffdfffffff)
    li  x9, MASK_XLEN(0x0)
    li  x24, MASK_XLEN(0xffffffffdfffffff)
    sub x8, x24, x9
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xffffffffdfffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")


    # address for test results
    la x1, test_46_res

 
    # Testcase 225:  rs1:x23(0xffffffffbfffffff), rs2:x8(0x0000000000000000), result rd:x9(0xffffffffbfffffff)
    li  x8, MASK_XLEN(0x0)
    li  x23, MASK_XLEN(0xffffffffbfffffff)
    sub x9, x23, x8
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xffffffffbfffffff) 
 
    # Testcase 226:  rs1:x22(0xffffffff7fffffff), rs2:x7(0x0000000000000000), result rd:x10(0xffffffff7fffffff)
    li  x7, MASK_XLEN(0x0)
    li  x22, MASK_XLEN(0xffffffff7fffffff)
    sub x10, x22, x7
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xffffffff7fffffff) 
 
    # Testcase 227:  rs1:x21(0xfffffffeffffffff), rs2:x6(0x0000000000000000), result rd:x11(0xfffffffeffffffff)
    li  x6, MASK_XLEN(0x0)
    li  x21, MASK_XLEN(0xfffffffeffffffff)
    sub x11, x21, x6
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0xfffffffeffffffff) 
 
    # Testcase 228:  rs1:x20(0xfffffffdffffffff), rs2:x5(0x0000000000000000), result rd:x12(0xfffffffdffffffff)
    li  x5, MASK_XLEN(0x0)
    li  x20, MASK_XLEN(0xfffffffdffffffff)
    sub x12, x20, x5
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xfffffffdffffffff) 
 
    # Testcase 229:  rs1:x19(0xfffffffbffffffff), rs2:x4(0x0000000000000000), result rd:x13(0xfffffffbffffffff)
    li  x4, MASK_XLEN(0x0)
    li  x19, MASK_XLEN(0xfffffffbffffffff)
    sub x13, x19, x4
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x13, 0xfffffffbffffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")


    # address for test results
    la x4, test_47_res

 
    # Testcase 230:  rs1:x18(0xfffffff7ffffffff), rs2:x3(0x0000000000000000), result rd:x14(0xfffffff7ffffffff)
    li  x3, MASK_XLEN(0x0)
    li  x18, MASK_XLEN(0xfffffff7ffffffff)
    sub x14, x18, x3
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x14, 0xfffffff7ffffffff) 
 
    # Testcase 231:  rs1:x17(0xffffffefffffffff), rs2:x2(0x0000000000000000), result rd:x15(0xffffffefffffffff)
    li  x2, MASK_XLEN(0x0)
    li  x17, MASK_XLEN(0xffffffefffffffff)
    sub x15, x17, x2
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xffffffefffffffff) 
 
    # Testcase 232:  rs1:x16(0xffffffdfffffffff), rs2:x1(0x0000000000000000), result rd:x16(0xffffffdfffffffff)
    li  x1, MASK_XLEN(0x0)
    li  x16, MASK_XLEN(0xffffffdfffffffff)
    sub x16, x16, x1
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffffffdfffffffff) 
 
    # Testcase 233:  rs1:x15(0xffffffbfffffffff), rs2:x31(0x0000000000000000), result rd:x17(0xffffffbfffffffff)
    li  x31, MASK_XLEN(0x0)
    li  x15, MASK_XLEN(0xffffffbfffffffff)
    sub x17, x15, x31
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xffffffbfffffffff) 
 
    # Testcase 234:  rs1:x14(0xffffff7fffffffff), rs2:x30(0x0000000000000000), result rd:x18(0xffffff7fffffffff)
    li  x30, MASK_XLEN(0x0)
    li  x14, MASK_XLEN(0xffffff7fffffffff)
    sub x18, x14, x30
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xffffff7fffffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")


    # address for test results
    la x1, test_48_res

 
    # Testcase 235:  rs1:x13(0xfffffeffffffffff), rs2:x29(0x0000000000000000), result rd:x19(0xfffffeffffffffff)
    li  x29, MASK_XLEN(0x0)
    li  x13, MASK_XLEN(0xfffffeffffffffff)
    sub x19, x13, x29
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x19, 0xfffffeffffffffff) 
 
    # Testcase 236:  rs1:x12(0xfffffdffffffffff), rs2:x28(0x0000000000000000), result rd:x20(0xfffffdffffffffff)
    li  x28, MASK_XLEN(0x0)
    li  x12, MASK_XLEN(0xfffffdffffffffff)
    sub x20, x12, x28
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x20, 0xfffffdffffffffff) 
 
    # Testcase 237:  rs1:x11(0xfffffbffffffffff), rs2:x27(0x0000000000000000), result rd:x21(0xfffffbffffffffff)
    li  x27, MASK_XLEN(0x0)
    li  x11, MASK_XLEN(0xfffffbffffffffff)
    sub x21, x11, x27
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x21, 0xfffffbffffffffff) 
 
    # Testcase 238:  rs1:x10(0xfffff7ffffffffff), rs2:x26(0x0000000000000000), result rd:x22(0xfffff7ffffffffff)
    li  x26, MASK_XLEN(0x0)
    li  x10, MASK_XLEN(0xfffff7ffffffffff)
    sub x22, x10, x26
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x22, 0xfffff7ffffffffff) 
 
    # Testcase 239:  rs1:x9(0xffffefffffffffff), rs2:x25(0x0000000000000000), result rd:x23(0xffffefffffffffff)
    li  x25, MASK_XLEN(0x0)
    li  x9, MASK_XLEN(0xffffefffffffffff)
    sub x23, x9, x25
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x23, 0xffffefffffffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")


    # address for test results
    la x1, test_49_res

 
    # Testcase 240:  rs1:x8(0xffffdfffffffffff), rs2:x24(0x0000000000000000), result rd:x24(0xffffdfffffffffff)
    li  x24, MASK_XLEN(0x0)
    li  x8, MASK_XLEN(0xffffdfffffffffff)
    sub x24, x8, x24
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x24, 0xffffdfffffffffff) 
 
    # Testcase 241:  rs1:x7(0xffffbfffffffffff), rs2:x23(0x0000000000000000), result rd:x25(0xffffbfffffffffff)
    li  x23, MASK_XLEN(0x0)
    li  x7, MASK_XLEN(0xffffbfffffffffff)
    sub x25, x7, x23
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x25, 0xffffbfffffffffff) 
 
    # Testcase 242:  rs1:x6(0xffff7fffffffffff), rs2:x22(0x0000000000000000), result rd:x26(0xffff7fffffffffff)
    li  x22, MASK_XLEN(0x0)
    li  x6, MASK_XLEN(0xffff7fffffffffff)
    sub x26, x6, x22
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x26, 0xffff7fffffffffff) 
 
    # Testcase 243:  rs1:x5(0xfffeffffffffffff), rs2:x21(0x0000000000000000), result rd:x27(0xfffeffffffffffff)
    li  x21, MASK_XLEN(0x0)
    li  x5, MASK_XLEN(0xfffeffffffffffff)
    sub x27, x5, x21
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x27, 0xfffeffffffffffff) 
 
    # Testcase 244:  rs1:x4(0xfffdffffffffffff), rs2:x20(0x0000000000000000), result rd:x28(0xfffdffffffffffff)
    li  x20, MASK_XLEN(0x0)
    li  x4, MASK_XLEN(0xfffdffffffffffff)
    sub x28, x4, x20
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x28, 0xfffdffffffffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")


    # address for test results
    la x4, test_50_res

 
    # Testcase 245:  rs1:x3(0xfffbffffffffffff), rs2:x19(0x0000000000000000), result rd:x29(0xfffbffffffffffff)
    li  x19, MASK_XLEN(0x0)
    li  x3, MASK_XLEN(0xfffbffffffffffff)
    sub x29, x3, x19
    sd x29, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0xfffbffffffffffff) 
 
    # Testcase 246:  rs1:x2(0xfff7ffffffffffff), rs2:x18(0x0000000000000000), result rd:x30(0xfff7ffffffffffff)
    li  x18, MASK_XLEN(0x0)
    li  x2, MASK_XLEN(0xfff7ffffffffffff)
    sub x30, x2, x18
    sd x30, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfff7ffffffffffff) 
 
    # Testcase 247:  rs1:x1(0xffefffffffffffff), rs2:x17(0x0000000000000000), result rd:x31(0xffefffffffffffff)
    li  x17, MASK_XLEN(0x0)
    li  x1, MASK_XLEN(0xffefffffffffffff)
    sub x31, x1, x17
    sd x31, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xffefffffffffffff) 
 
    # Testcase 248:  rs1:x31(0xffdfffffffffffff), rs2:x16(0x0000000000000000), result rd:x1(0xffdfffffffffffff)
    li  x16, MASK_XLEN(0x0)
    li  x31, MASK_XLEN(0xffdfffffffffffff)
    sub x1, x31, x16
    sd x1, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xffdfffffffffffff) 
 
    # Testcase 249:  rs1:x30(0xffbfffffffffffff), rs2:x15(0x0000000000000000), result rd:x2(0xffbfffffffffffff)
    li  x15, MASK_XLEN(0x0)
    li  x30, MASK_XLEN(0xffbfffffffffffff)
    sub x2, x30, x15
    sd x2, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffbfffffffffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")


    # address for test results
    la x1, test_51_res

 
    # Testcase 250:  rs1:x29(0xff7fffffffffffff), rs2:x14(0x0000000000000000), result rd:x3(0xff7fffffffffffff)
    li  x14, MASK_XLEN(0x0)
    li  x29, MASK_XLEN(0xff7fffffffffffff)
    sub x3, x29, x14
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x3, 0xff7fffffffffffff) 
 
    # Testcase 251:  rs1:x28(0xfeffffffffffffff), rs2:x13(0x0000000000000000), result rd:x4(0xfeffffffffffffff)
    li  x13, MASK_XLEN(0x0)
    li  x28, MASK_XLEN(0xfeffffffffffffff)
    sub x4, x28, x13
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x4, 0xfeffffffffffffff) 
 
    # Testcase 252:  rs1:x27(0xfdffffffffffffff), rs2:x12(0x0000000000000000), result rd:x5(0xfdffffffffffffff)
    li  x12, MASK_XLEN(0x0)
    li  x27, MASK_XLEN(0xfdffffffffffffff)
    sub x5, x27, x12
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x5, 0xfdffffffffffffff) 
 
    # Testcase 253:  rs1:x26(0xfbffffffffffffff), rs2:x11(0x0000000000000000), result rd:x6(0xfbffffffffffffff)
    li  x11, MASK_XLEN(0x0)
    li  x26, MASK_XLEN(0xfbffffffffffffff)
    sub x6, x26, x11
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x6, 0xfbffffffffffffff) 
 
    # Testcase 254:  rs1:x25(0xf7ffffffffffffff), rs2:x10(0x0000000000000000), result rd:x7(0xf7ffffffffffffff)
    li  x10, MASK_XLEN(0x0)
    li  x25, MASK_XLEN(0xf7ffffffffffffff)
    sub x7, x25, x10
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x7, 0xf7ffffffffffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")


    # address for test results
    la x1, test_52_res

 
    # Testcase 255:  rs1:x24(0xefffffffffffffff), rs2:x9(0x0000000000000000), result rd:x8(0xefffffffffffffff)
    li  x9, MASK_XLEN(0x0)
    li  x24, MASK_XLEN(0xefffffffffffffff)
    sub x8, x24, x9
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x8, 0xefffffffffffffff) 
 
    # Testcase 256:  rs1:x23(0xdfffffffffffffff), rs2:x8(0x0000000000000000), result rd:x9(0xdfffffffffffffff)
    li  x8, MASK_XLEN(0x0)
    li  x23, MASK_XLEN(0xdfffffffffffffff)
    sub x9, x23, x8
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x9, 0xdfffffffffffffff) 
 
    # Testcase 257:  rs1:x22(0xbfffffffffffffff), rs2:x7(0x0000000000000000), result rd:x10(0xbfffffffffffffff)
    li  x7, MASK_XLEN(0x0)
    li  x22, MASK_XLEN(0xbfffffffffffffff)
    sub x10, x22, x7
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x10, 0xbfffffffffffffff) 
 
    # Testcase 258:  rs1:x21(0x7fffffffffffffff), rs2:x6(0x0000000000000000), result rd:x11(0x7fffffffffffffff)
    li  x6, MASK_XLEN(0x0)
    li  x21, MASK_XLEN(0x7fffffffffffffff)
    sub x11, x21, x6
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x11, 0x7fffffffffffffff) 
 
    # Testcase 259:  rs1:x20(0xffffffffffffffff), rs2:x5(0x0000000000000000), result rd:x12(0xffffffffffffffff)
    li  x5, MASK_XLEN(0x0)
    li  x20, MASK_XLEN(0xffffffffffffffff)
    sub x12, x20, x5
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x2, x12, 0xffffffffffffffff) 


	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")


    # address for test results
    la x2, test_53_res

 
    # Testcase 260:  rs1:x4(0x0000000000000001), rs2:x4(0xffffffffffffffff), result rd:x13(0x0000000000000000)
    li  x4, MASK_XLEN(0xffffffffffffffff)
    li  x4, MASK_XLEN(0x1)
    sub x13, x4, x4
    sd x13, 0(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x13, 0x0000000000000000) 
 
    # Testcase 261:  rs1:x18(0x0000000000000002), rs2:x3(0x7fffffffffffffff), result rd:x0(0x0000000000000000)
    li  x3, MASK_XLEN(0x7fffffffffffffff)
    li  x18, MASK_XLEN(0x2)
    sub x0, x18, x3
    sd x0, 8(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x0, 0x0000000000000000) 
 
    # Testcase 262:  rs1:x17(0x0000000000000004), rs2:x0(0xbfffffffffffffff), result rd:x15(0x0000000000000004)
    li  x0, MASK_XLEN(0xbfffffffffffffff)
    li  x17, MASK_XLEN(0x4)
    sub x15, x17, x0
    sd x15, 16(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0000000000000004) 
 
    # Testcase 263:  rs1:x0(0x0000000000000008), rs2:x1(0xdfffffffffffffff), result rd:x16(0x2000000000000001)
    li  x1, MASK_XLEN(0xdfffffffffffffff)
    li  x0, MASK_XLEN(0x8)
    sub x16, x0, x1
    sd x16, 24(x2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x2000000000000001) 


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

