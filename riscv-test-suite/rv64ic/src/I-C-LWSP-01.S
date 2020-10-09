# RISC-V Compliance Test I-C-LWSP-01
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
# Description: Testing instruction 'c.lwsp'.

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



    # Addresses for test data and results
    la x6, test_1_res

    # Testcase 0:  imm:0x7c, result rd:x1(0xfffffffffffffffe)
    la  x2, test_data
    addi    x2, x2,0
    li     x7, MASK_XLEN(-124)
    add    x2, x2, x7
    c.lwsp x1, 124(x2)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xfffffffffffffffe)

    # Testcase 1:  imm:0x3c, result rd:x2(0xfffffffffffffffd)
    la  x2, test_data
    addi    x2, x2,4
    li     x7, MASK_XLEN(-60)
    add    x2, x2, x7
    c.lwsp x2, 60(x2)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0xfffffffffffffffd)

    # Testcase 2:  imm:0x5c, result rd:x3(0xfffffffffffffffb)
    la  x2, test_data
    addi    x2, x2,8
    li     x7, MASK_XLEN(-92)
    add    x2, x2, x7
    c.lwsp x3, 92(x2)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0xfffffffffffffffb)

    # Testcase 3:  imm:0x6c, result rd:x4(0xfffffffffffffff7)
    la  x2, test_data
    addi    x2, x2,12
    li     x7, MASK_XLEN(-108)
    add    x2, x2, x7
    c.lwsp x4, 108(x2)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0xfffffffffffffff7)

    # Testcase 4:  imm:0x74, result rd:x5(0xffffffffffffffef)
    la  x2, test_data
    addi    x2, x2,16
    li     x7, MASK_XLEN(-116)
    add    x2, x2, x7
    c.lwsp x5, 116(x2)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0xffffffffffffffef)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")



    # Addresses for test data and results
    la x1, test_2_res

    # Testcase 5:  imm:0x78, result rd:x6(0xffffffffffffffdf)
    la  x2, test_data
    addi    x2, x2,20
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x6, 120(x2)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0xffffffffffffffdf)

    # Testcase 6:  imm:0x0, result rd:x7(0xffffffffffffffbf)
    la  x2, test_data
    addi    x2, x2,24
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x7, 0(x2)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0xffffffffffffffbf)

    # Testcase 7:  imm:0x40, result rd:x8(0xffffffffffffff7f)
    la  x2, test_data
    addi    x2, x2,28
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x8, 64(x2)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0xffffffffffffff7f)

    # Testcase 8:  imm:0x20, result rd:x9(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,32
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x9, 32(x2)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0xfffffffffffffeff)

    # Testcase 9:  imm:0x10, result rd:x10(0xfffffffffffffdff)
    la  x2, test_data
    addi    x2, x2,36
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x10, 16(x2)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xfffffffffffffdff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")



    # Addresses for test data and results
    la x7, test_3_res

    # Testcase 10:  imm:0x8, result rd:x11(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,40
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    c.lwsp x11, 8(x2)
    sd x11, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x11, 0xfffffffffffffeff)

    # Testcase 11:  imm:0x4, result rd:x12(0xfffffffffffff7ff)
    la  x2, test_data
    addi    x2, x2,44
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    c.lwsp x12, 4(x2)
    sd x12, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x12, 0xfffffffffffff7ff)

    # Testcase 12:  imm:0x7c, result rd:x13(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,48
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    c.lwsp x13, 124(x2)
    sd x13, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x13, 0xffffffffffffefff)

    # Testcase 13:  imm:0x3c, result rd:x14(0xffffffffffffdfff)
    la  x2, test_data
    addi    x2, x2,52
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    c.lwsp x14, 60(x2)
    sd x14, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x14, 0xffffffffffffdfff)

    # Testcase 14:  imm:0x5c, result rd:x15(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,56
    li     x8, MASK_XLEN(-92)
    add    x2, x2, x8
    c.lwsp x15, 92(x2)
    sd x15, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xffffffffffffefff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")



    # Addresses for test data and results
    la x3, test_4_res

    # Testcase 15:  imm:0x6c, result rd:x16(0xffffffffffff7fff)
    la  x2, test_data
    addi    x2, x2,60
    li     x4, MASK_XLEN(-108)
    add    x2, x2, x4
    c.lwsp x16, 108(x2)
    sd x16, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffffffffffff7fff)

    # Testcase 16:  imm:0x74, result rd:x17(0xfffffffffffeffff)
    la  x2, test_data
    addi    x2, x2,64
    li     x4, MASK_XLEN(-116)
    add    x2, x2, x4
    c.lwsp x17, 116(x2)
    sd x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xfffffffffffeffff)

    # Testcase 17:  imm:0x78, result rd:x18(0xfffffffffffdffff)
    la  x2, test_data
    addi    x2, x2,68
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    c.lwsp x18, 120(x2)
    sd x18, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xfffffffffffdffff)

    # Testcase 18:  imm:0x0, result rd:x19(0xfffffffffffbffff)
    la  x2, test_data
    addi    x2, x2,72
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    c.lwsp x19, 0(x2)
    sd x19, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0xfffffffffffbffff)

    # Testcase 19:  imm:0x40, result rd:x20(0xfffffffffff7ffff)
    la  x2, test_data
    addi    x2, x2,76
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    c.lwsp x20, 64(x2)
    sd x20, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x20, 0xfffffffffff7ffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")



    # Addresses for test data and results
    la x1, test_5_res

    # Testcase 20:  imm:0x20, result rd:x21(0xffffffffffefffff)
    la  x2, test_data
    addi    x2, x2,80
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x21, 32(x2)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0xffffffffffefffff)

    # Testcase 21:  imm:0x10, result rd:x22(0xffffffffffdfffff)
    la  x2, test_data
    addi    x2, x2,84
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x22, 16(x2)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0xffffffffffdfffff)

    # Testcase 22:  imm:0x8, result rd:x23(0xffffffffffbfffff)
    la  x2, test_data
    addi    x2, x2,88
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x23, 8(x2)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0xffffffffffbfffff)

    # Testcase 23:  imm:0x4, result rd:x24(0xffffffffff7fffff)
    la  x2, test_data
    addi    x2, x2,92
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x24, 4(x2)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0xffffffffff7fffff)

    # Testcase 24:  imm:0x7c, result rd:x25(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,96
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x25, 124(x2)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0xfffffffffeffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")



    # Addresses for test data and results
    la x1, test_6_res

    # Testcase 25:  imm:0x3c, result rd:x26(0xfffffffffdffffff)
    la  x2, test_data
    addi    x2, x2,100
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x26, 60(x2)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0xfffffffffdffffff)

    # Testcase 26:  imm:0x5c, result rd:x27(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,104
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x27, 92(x2)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0xfffffffffeffffff)

    # Testcase 27:  imm:0x6c, result rd:x28(0xfffffffff7ffffff)
    la  x2, test_data
    addi    x2, x2,108
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x28, 108(x2)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0xfffffffff7ffffff)

    # Testcase 28:  imm:0x74, result rd:x29(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,112
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x29, 116(x2)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0xffffffffefffffff)

    # Testcase 29:  imm:0x78, result rd:x30(0xffffffffdfffffff)
    la  x2, test_data
    addi    x2, x2,116
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x30, 120(x2)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x30, 0xffffffffdfffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")



    # Addresses for test data and results
    la x5, test_7_res

    # Testcase 30:  imm:0x0, result rd:x31(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,120
    li     x6, MASK_XLEN(0)
    add    x2, x2, x6
    c.lwsp x31, 0(x2)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0xffffffffefffffff)

    # Testcase 31:  imm:0x40, result rd:x1(0x000000007fffffff)
    la  x2, test_data
    addi    x2, x2,124
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    c.lwsp x1, 64(x2)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x000000007fffffff)

    # Testcase 32:  imm:0x20, result rd:x2(0xffffffffffffffff)
    la  x2, test_data
    addi    x2, x2,128
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    c.lwsp x2, 32(x2)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xffffffffffffffff)

    # Testcase 33:  imm:0x10, result rd:x3(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,132
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    c.lwsp x3, 16(x2)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0000000000000001)

    # Testcase 34:  imm:0x8, result rd:x4(0x0000000000000002)
    la  x2, test_data
    addi    x2, x2,136
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    c.lwsp x4, 8(x2)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x0000000000000002)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")



    # Addresses for test data and results
    la x1, test_8_res

    # Testcase 35:  imm:0x4, result rd:x5(0x0000000000000004)
    la  x2, test_data
    addi    x2, x2,140
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x5, 4(x2)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000004)

    # Testcase 36:  imm:0x7c, result rd:x6(0x0000000000000008)
    la  x2, test_data
    addi    x2, x2,144
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x6, 124(x2)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0x0000000000000008)

    # Testcase 37:  imm:0x3c, result rd:x7(0x0000000000000010)
    la  x2, test_data
    addi    x2, x2,148
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x7, 60(x2)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0x0000000000000010)

    # Testcase 38:  imm:0x5c, result rd:x8(0x0000000000000020)
    la  x2, test_data
    addi    x2, x2,152
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x8, 92(x2)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x0000000000000020)

    # Testcase 39:  imm:0x6c, result rd:x9(0x0000000000000040)
    la  x2, test_data
    addi    x2, x2,156
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x9, 108(x2)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0x0000000000000040)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")



    # Addresses for test data and results
    la x1, test_9_res

    # Testcase 40:  imm:0x74, result rd:x10(0x0000000000000080)
    la  x2, test_data
    addi    x2, x2,160
    li     x8, MASK_XLEN(-116)
    add    x2, x2, x8
    c.lwsp x10, 116(x2)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0x0000000000000080)

    # Testcase 41:  imm:0x78, result rd:x11(0x0000000000000100)
    la  x2, test_data
    addi    x2, x2,164
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    c.lwsp x11, 120(x2)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x11, 0x0000000000000100)

    # Testcase 42:  imm:0x0, result rd:x12(0x0000000000000200)
    la  x2, test_data
    addi    x2, x2,168
    li     x8, MASK_XLEN(0)
    add    x2, x2, x8
    c.lwsp x12, 0(x2)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x12, 0x0000000000000200)

    # Testcase 43:  imm:0x40, result rd:x13(0x0000000000000400)
    la  x2, test_data
    addi    x2, x2,172
    li     x8, MASK_XLEN(-64)
    add    x2, x2, x8
    c.lwsp x13, 64(x2)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x13, 0x0000000000000400)

    # Testcase 44:  imm:0x20, result rd:x14(0x0000000000000800)
    la  x2, test_data
    addi    x2, x2,176
    li     x8, MASK_XLEN(-32)
    add    x2, x2, x8
    c.lwsp x14, 32(x2)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x14, 0x0000000000000800)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")



    # Addresses for test data and results
    la x3, test_10_res

    # Testcase 45:  imm:0x10, result rd:x15(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,180
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    c.lwsp x15, 16(x2)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0000000000001000)

    # Testcase 46:  imm:0x8, result rd:x16(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,184
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    c.lwsp x16, 8(x2)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0000000000002000)

    # Testcase 47:  imm:0x4, result rd:x17(0x0000000000004000)
    la  x2, test_data
    addi    x2, x2,188
    li     x4, MASK_XLEN(-4)
    add    x2, x2, x4
    c.lwsp x17, 4(x2)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x0000000000004000)

    # Testcase 48:  imm:0x7c, result rd:x18(0x0000000000008000)
    la  x2, test_data
    addi    x2, x2,192
    li     x4, MASK_XLEN(-124)
    add    x2, x2, x4
    c.lwsp x18, 124(x2)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x0000000000008000)

    # Testcase 49:  imm:0x3c, result rd:x19(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,196
    li     x4, MASK_XLEN(-60)
    add    x2, x2, x4
    c.lwsp x19, 60(x2)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0x0000000000000001)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")



    # Addresses for test data and results
    la x1, test_11_res

    # Testcase 50:  imm:0x5c, result rd:x20(0x0000000000000002)
    la  x2, test_data
    addi    x2, x2,200
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x20, 92(x2)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x0000000000000002)

    # Testcase 51:  imm:0x6c, result rd:x21(0x0000000000040000)
    la  x2, test_data
    addi    x2, x2,204
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x21, 108(x2)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0x0000000000040000)

    # Testcase 52:  imm:0x74, result rd:x22(0x0000000000080000)
    la  x2, test_data
    addi    x2, x2,208
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x22, 116(x2)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0x0000000000080000)

    # Testcase 53:  imm:0x78, result rd:x23(0x0000000000000010)
    la  x2, test_data
    addi    x2, x2,212
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x23, 120(x2)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0x0000000000000010)

    # Testcase 54:  imm:0x0, result rd:x24(0x0000000000000020)
    la  x2, test_data
    addi    x2, x2,216
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x24, 0(x2)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0x0000000000000020)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")



    # Addresses for test data and results
    la x1, test_12_res

    # Testcase 55:  imm:0x40, result rd:x25(0x0000000000400000)
    la  x2, test_data
    addi    x2, x2,220
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x25, 64(x2)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0x0000000000400000)

    # Testcase 56:  imm:0x20, result rd:x26(0x0000000000800000)
    la  x2, test_data
    addi    x2, x2,224
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x26, 32(x2)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0x0000000000800000)

    # Testcase 57:  imm:0x10, result rd:x27(0x0000000000000100)
    la  x2, test_data
    addi    x2, x2,228
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x27, 16(x2)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0x0000000000000100)

    # Testcase 58:  imm:0x8, result rd:x28(0x0000000000000200)
    la  x2, test_data
    addi    x2, x2,232
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x28, 8(x2)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0x0000000000000200)

    # Testcase 59:  imm:0x4, result rd:x29(0x0000000004000000)
    la  x2, test_data
    addi    x2, x2,236
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x29, 4(x2)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0x0000000004000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")



    # Addresses for test data and results
    la x4, test_13_res

    # Testcase 60:  imm:0x7c, result rd:x30(0x0000000008000000)
    la  x2, test_data
    addi    x2, x2,240
    li     x5, MASK_XLEN(-124)
    add    x2, x2, x5
    c.lwsp x30, 124(x2)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x0000000008000000)

    # Testcase 61:  imm:0x3c, result rd:x31(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,244
    li     x5, MASK_XLEN(-60)
    add    x2, x2, x5
    c.lwsp x31, 60(x2)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0000000000001000)

    # Testcase 62:  imm:0x5c, result rd:x1(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,248
    li     x5, MASK_XLEN(-92)
    add    x2, x2, x5
    c.lwsp x1, 92(x2)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0000000000002000)

    # Testcase 63:  imm:0x6c, result rd:x2(0x0000000040000000)
    la  x2, test_data
    addi    x2, x2,252
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    c.lwsp x2, 108(x2)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0000000040000000)

    # Testcase 64:  imm:0x74, result rd:x3(0xffffffff80000000)
    la  x2, test_data
    addi    x2, x2,256
    li     x5, MASK_XLEN(-116)
    add    x2, x2, x5
    c.lwsp x3, 116(x2)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0xffffffff80000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")



    # Addresses for test data and results
    la x1, test_14_res

    # Testcase 65:  imm:0x78, result rd:x4(0x0000000000000000)
    la  x2, test_data
    addi    x2, x2,260
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x4, 120(x2)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x4, 0x0000000000000000)

    # Testcase 66:  imm:0x0, result rd:x5(0xfffffffffffffffe)
    la  x2, test_data
    addi    x2, x2,0
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x5, 0(x2)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x5, 0xfffffffffffffffe)

    # Testcase 67:  imm:0x40, result rd:x6(0xfffffffffffffffd)
    la  x2, test_data
    addi    x2, x2,4
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x6, 64(x2)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x6, 0xfffffffffffffffd)

    # Testcase 68:  imm:0x20, result rd:x7(0xfffffffffffffffb)
    la  x2, test_data
    addi    x2, x2,8
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x7, 32(x2)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x7, 0xfffffffffffffffb)

    # Testcase 69:  imm:0x10, result rd:x8(0xfffffffffffffff7)
    la  x2, test_data
    addi    x2, x2,12
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x8, 16(x2)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x8, 0xfffffffffffffff7)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")



    # Addresses for test data and results
    la x1, test_15_res

    # Testcase 70:  imm:0x8, result rd:x9(0xffffffffffffffef)
    la  x2, test_data
    addi    x2, x2,16
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x9, 8(x2)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x9, 0xffffffffffffffef)

    # Testcase 71:  imm:0x4, result rd:x10(0xffffffffffffffdf)
    la  x2, test_data
    addi    x2, x2,20
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x10, 4(x2)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x10, 0xffffffffffffffdf)

    # Testcase 72:  imm:0x7c, result rd:x11(0xffffffffffffffbf)
    la  x2, test_data
    addi    x2, x2,24
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x11, 124(x2)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x11, 0xffffffffffffffbf)

    # Testcase 73:  imm:0x3c, result rd:x12(0xffffffffffffff7f)
    la  x2, test_data
    addi    x2, x2,28
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x12, 60(x2)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x12, 0xffffffffffffff7f)

    # Testcase 74:  imm:0x5c, result rd:x13(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,32
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x13, 92(x2)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x13, 0xfffffffffffffeff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")



    # Addresses for test data and results
    la x4, test_16_res

    # Testcase 75:  imm:0x6c, result rd:x14(0xfffffffffffffdff)
    la  x2, test_data
    addi    x2, x2,36
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    c.lwsp x14, 108(x2)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xfffffffffffffdff)

    # Testcase 76:  imm:0x74, result rd:x15(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,40
    li     x5, MASK_XLEN(-116)
    add    x2, x2, x5
    c.lwsp x15, 116(x2)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xfffffffffffffeff)

    # Testcase 77:  imm:0x78, result rd:x16(0xfffffffffffff7ff)
    la  x2, test_data
    addi    x2, x2,44
    li     x5, MASK_XLEN(-120)
    add    x2, x2, x5
    c.lwsp x16, 120(x2)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xfffffffffffff7ff)

    # Testcase 78:  imm:0x0, result rd:x17(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,48
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    c.lwsp x17, 0(x2)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xffffffffffffefff)

    # Testcase 79:  imm:0x40, result rd:x18(0xffffffffffffdfff)
    la  x2, test_data
    addi    x2, x2,52
    li     x5, MASK_XLEN(-64)
    add    x2, x2, x5
    c.lwsp x18, 64(x2)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x18, 0xffffffffffffdfff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")



    # Addresses for test data and results
    la x1, test_17_res

    # Testcase 80:  imm:0x20, result rd:x19(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,56
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x19, 32(x2)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xffffffffffffefff)

    # Testcase 81:  imm:0x10, result rd:x20(0xffffffffffff7fff)
    la  x2, test_data
    addi    x2, x2,60
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x20, 16(x2)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0xffffffffffff7fff)

    # Testcase 82:  imm:0x8, result rd:x21(0xfffffffffffeffff)
    la  x2, test_data
    addi    x2, x2,64
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x21, 8(x2)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0xfffffffffffeffff)

    # Testcase 83:  imm:0x4, result rd:x22(0xfffffffffffdffff)
    la  x2, test_data
    addi    x2, x2,68
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x22, 4(x2)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0xfffffffffffdffff)

    # Testcase 84:  imm:0x7c, result rd:x23(0xfffffffffffbffff)
    la  x2, test_data
    addi    x2, x2,72
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x23, 124(x2)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0xfffffffffffbffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")



    # Addresses for test data and results
    la x1, test_18_res

    # Testcase 85:  imm:0x3c, result rd:x24(0xfffffffffff7ffff)
    la  x2, test_data
    addi    x2, x2,76
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x24, 60(x2)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0xfffffffffff7ffff)

    # Testcase 86:  imm:0x5c, result rd:x25(0xffffffffffefffff)
    la  x2, test_data
    addi    x2, x2,80
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x25, 92(x2)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0xffffffffffefffff)

    # Testcase 87:  imm:0x6c, result rd:x26(0xffffffffffdfffff)
    la  x2, test_data
    addi    x2, x2,84
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x26, 108(x2)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0xffffffffffdfffff)

    # Testcase 88:  imm:0x74, result rd:x27(0xffffffffffbfffff)
    la  x2, test_data
    addi    x2, x2,88
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x27, 116(x2)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0xffffffffffbfffff)

    # Testcase 89:  imm:0x78, result rd:x28(0xffffffffff7fffff)
    la  x2, test_data
    addi    x2, x2,92
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x28, 120(x2)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0xffffffffff7fffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")



    # Addresses for test data and results
    la x3, test_19_res

    # Testcase 90:  imm:0x0, result rd:x29(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,96
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    c.lwsp x29, 0(x2)
    sd x29, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0xfffffffffeffffff)

    # Testcase 91:  imm:0x40, result rd:x30(0xfffffffffdffffff)
    la  x2, test_data
    addi    x2, x2,100
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    c.lwsp x30, 64(x2)
    sd x30, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfffffffffdffffff)

    # Testcase 92:  imm:0x20, result rd:x31(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,104
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    c.lwsp x31, 32(x2)
    sd x31, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xfffffffffeffffff)

    # Testcase 93:  imm:0x10, result rd:x1(0xfffffffff7ffffff)
    la  x2, test_data
    addi    x2, x2,108
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    c.lwsp x1, 16(x2)
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xfffffffff7ffffff)

    # Testcase 94:  imm:0x8, result rd:x2(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,112
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    c.lwsp x2, 8(x2)
    sd x2, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xffffffffefffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")



    # Addresses for test data and results
    la x1, test_20_res

    # Testcase 95:  imm:0x4, result rd:x3(0xffffffffdfffffff)
    la  x2, test_data
    addi    x2, x2,116
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    c.lwsp x3, 4(x2)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x3, 0xffffffffdfffffff)

    # Testcase 96:  imm:0x7c, result rd:x4(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,120
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    c.lwsp x4, 124(x2)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x4, 0xffffffffefffffff)

    # Testcase 97:  imm:0x3c, result rd:x5(0x000000007fffffff)
    la  x2, test_data
    addi    x2, x2,124
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    c.lwsp x5, 60(x2)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x5, 0x000000007fffffff)

    # Testcase 98:  imm:0x5c, result rd:x6(0xffffffffffffffff)
    la  x2, test_data
    addi    x2, x2,128
    li     x8, MASK_XLEN(-92)
    add    x2, x2, x8
    c.lwsp x6, 92(x2)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x6, 0xffffffffffffffff)

    # Testcase 99:  imm:0x6c, result rd:x7(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,132
    li     x8, MASK_XLEN(-108)
    add    x2, x2, x8
    c.lwsp x7, 108(x2)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x7, 0x0000000000000001)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")



    # Addresses for test data and results
    la x1, test_21_res

    # Testcase 100:  imm:0x74, result rd:x8(0x0000000000000002)
    la  x2, test_data
    addi    x2, x2,136
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x8, 116(x2)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x0000000000000002)

    # Testcase 101:  imm:0x78, result rd:x9(0x0000000000000004)
    la  x2, test_data
    addi    x2, x2,140
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x9, 120(x2)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0x0000000000000004)

    # Testcase 102:  imm:0x0, result rd:x10(0x0000000000000008)
    la  x2, test_data
    addi    x2, x2,144
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x10, 0(x2)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0x0000000000000008)

    # Testcase 103:  imm:0x40, result rd:x11(0x0000000000000010)
    la  x2, test_data
    addi    x2, x2,148
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x11, 64(x2)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x11, 0x0000000000000010)

    # Testcase 104:  imm:0x20, result rd:x12(0x0000000000000020)
    la  x2, test_data
    addi    x2, x2,152
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x12, 32(x2)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x12, 0x0000000000000020)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")



    # Addresses for test data and results
    la x5, test_22_res

    # Testcase 105:  imm:0x10, result rd:x13(0x0000000000000040)
    la  x2, test_data
    addi    x2, x2,156
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    c.lwsp x13, 16(x2)
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0000000000000040)

    # Testcase 106:  imm:0x8, result rd:x14(0x0000000000000080)
    la  x2, test_data
    addi    x2, x2,160
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    c.lwsp x14, 8(x2)
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0000000000000080)

    # Testcase 107:  imm:0x4, result rd:x15(0x0000000000000100)
    la  x2, test_data
    addi    x2, x2,164
    li     x6, MASK_XLEN(-4)
    add    x2, x2, x6
    c.lwsp x15, 4(x2)
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0000000000000100)

    # Testcase 108:  imm:0x7c, result rd:x16(0x0000000000000200)
    la  x2, test_data
    addi    x2, x2,168
    li     x6, MASK_XLEN(-124)
    add    x2, x2, x6
    c.lwsp x16, 124(x2)
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x0000000000000200)

    # Testcase 109:  imm:0x3c, result rd:x17(0x0000000000000400)
    la  x2, test_data
    addi    x2, x2,172
    li     x6, MASK_XLEN(-60)
    add    x2, x2, x6
    c.lwsp x17, 60(x2)
    sd x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x17, 0x0000000000000400)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")



    # Addresses for test data and results
    la x1, test_23_res

    # Testcase 110:  imm:0x5c, result rd:x18(0x0000000000000800)
    la  x2, test_data
    addi    x2, x2,176
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x18, 92(x2)
    sd x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x0000000000000800)

    # Testcase 111:  imm:0x6c, result rd:x19(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,180
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x19, 108(x2)
    sd x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0000000000001000)

    # Testcase 112:  imm:0x74, result rd:x20(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,184
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x20, 116(x2)
    sd x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x0000000000002000)

    # Testcase 113:  imm:0x78, result rd:x21(0x0000000000004000)
    la  x2, test_data
    addi    x2, x2,188
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x21, 120(x2)
    sd x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0x0000000000004000)

    # Testcase 114:  imm:0x0, result rd:x22(0x0000000000008000)
    la  x2, test_data
    addi    x2, x2,192
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x22, 0(x2)
    sd x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0x0000000000008000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")



    # Addresses for test data and results
    la x1, test_24_res

    # Testcase 115:  imm:0x40, result rd:x23(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,196
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x23, 64(x2)
    sd x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0x0000000000000001)

    # Testcase 116:  imm:0x20, result rd:x24(0x0000000000000002)
    la  x2, test_data
    addi    x2, x2,200
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x24, 32(x2)
    sd x24, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0x0000000000000002)

    # Testcase 117:  imm:0x10, result rd:x25(0x0000000000040000)
    la  x2, test_data
    addi    x2, x2,204
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x25, 16(x2)
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0x0000000000040000)

    # Testcase 118:  imm:0x8, result rd:x26(0x0000000000080000)
    la  x2, test_data
    addi    x2, x2,208
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x26, 8(x2)
    sd x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0x0000000000080000)

    # Testcase 119:  imm:0x4, result rd:x27(0x0000000000000010)
    la  x2, test_data
    addi    x2, x2,212
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x27, 4(x2)
    sd x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0x0000000000000010)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")



    # Addresses for test data and results
    la x3, test_25_res

    # Testcase 120:  imm:0x7c, result rd:x28(0x0000000000000020)
    la  x2, test_data
    addi    x2, x2,216
    li     x4, MASK_XLEN(-124)
    add    x2, x2, x4
    c.lwsp x28, 124(x2)
    sd x28, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x28, 0x0000000000000020)

    # Testcase 121:  imm:0x3c, result rd:x29(0x0000000000400000)
    la  x2, test_data
    addi    x2, x2,220
    li     x4, MASK_XLEN(-60)
    add    x2, x2, x4
    c.lwsp x29, 60(x2)
    sd x29, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x0000000000400000)

    # Testcase 122:  imm:0x5c, result rd:x30(0x0000000000800000)
    la  x2, test_data
    addi    x2, x2,224
    li     x4, MASK_XLEN(-92)
    add    x2, x2, x4
    c.lwsp x30, 92(x2)
    sd x30, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0000000000800000)

    # Testcase 123:  imm:0x6c, result rd:x31(0x0000000000000100)
    la  x2, test_data
    addi    x2, x2,228
    li     x4, MASK_XLEN(-108)
    add    x2, x2, x4
    c.lwsp x31, 108(x2)
    sd x31, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0000000000000100)

    # Testcase 124:  imm:0x74, result rd:x1(0x0000000000000200)
    la  x2, test_data
    addi    x2, x2,232
    li     x4, MASK_XLEN(-116)
    add    x2, x2, x4
    c.lwsp x1, 116(x2)
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0000000000000200)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")



    # Addresses for test data and results
    la x1, test_26_res

    # Testcase 125:  imm:0x78, result rd:x2(0x0000000004000000)
    la  x2, test_data
    addi    x2, x2,236
    li     x7, MASK_XLEN(-120)
    add    x2, x2, x7
    c.lwsp x2, 120(x2)
    sd x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x0000000004000000)

    # Testcase 126:  imm:0x0, result rd:x3(0x0000000008000000)
    la  x2, test_data
    addi    x2, x2,240
    li     x7, MASK_XLEN(0)
    add    x2, x2, x7
    c.lwsp x3, 0(x2)
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x0000000008000000)

    # Testcase 127:  imm:0x40, result rd:x4(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,244
    li     x7, MASK_XLEN(-64)
    add    x2, x2, x7
    c.lwsp x4, 64(x2)
    sd x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x0000000000001000)

    # Testcase 128:  imm:0x20, result rd:x5(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,248
    li     x7, MASK_XLEN(-32)
    add    x2, x2, x7
    c.lwsp x5, 32(x2)
    sd x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x0000000000002000)

    # Testcase 129:  imm:0x10, result rd:x6(0x0000000040000000)
    la  x2, test_data
    addi    x2, x2,252
    li     x7, MASK_XLEN(-16)
    add    x2, x2, x7
    c.lwsp x6, 16(x2)
    sd x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x0000000040000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")



    # Addresses for test data and results
    la x1, test_27_res

    # Testcase 130:  imm:0x8, result rd:x7(0xffffffff80000000)
    la  x2, test_data
    addi    x2, x2,256
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x7, 8(x2)
    sd x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0xffffffff80000000)

    # Testcase 131:  imm:0x4, result rd:x8(0x0000000000000000)
    la  x2, test_data
    addi    x2, x2,260
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x8, 4(x2)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x0000000000000000)

    # Testcase 132:  imm:0x7c, result rd:x9(0xfffffffffffffffe)
    la  x2, test_data
    addi    x2, x2,0
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x9, 124(x2)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0xfffffffffffffffe)

    # Testcase 133:  imm:0x3c, result rd:x10(0xfffffffffffffffd)
    la  x2, test_data
    addi    x2, x2,4
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x10, 60(x2)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xfffffffffffffffd)

    # Testcase 134:  imm:0x5c, result rd:x11(0xfffffffffffffffb)
    la  x2, test_data
    addi    x2, x2,8
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x11, 92(x2)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x11, 0xfffffffffffffffb)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")



    # Addresses for test data and results
    la x6, test_28_res

    # Testcase 135:  imm:0x6c, result rd:x12(0xfffffffffffffff7)
    la  x2, test_data
    addi    x2, x2,12
    li     x7, MASK_XLEN(-108)
    add    x2, x2, x7
    c.lwsp x12, 108(x2)
    sd x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0xfffffffffffffff7)

    # Testcase 136:  imm:0x74, result rd:x13(0xffffffffffffffef)
    la  x2, test_data
    addi    x2, x2,16
    li     x7, MASK_XLEN(-116)
    add    x2, x2, x7
    c.lwsp x13, 116(x2)
    sd x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0xffffffffffffffef)

    # Testcase 137:  imm:0x78, result rd:x14(0xffffffffffffffdf)
    la  x2, test_data
    addi    x2, x2,20
    li     x7, MASK_XLEN(-120)
    add    x2, x2, x7
    c.lwsp x14, 120(x2)
    sd x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0xffffffffffffffdf)

    # Testcase 138:  imm:0x0, result rd:x15(0xffffffffffffffbf)
    la  x2, test_data
    addi    x2, x2,24
    li     x7, MASK_XLEN(0)
    add    x2, x2, x7
    c.lwsp x15, 0(x2)
    sd x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x15, 0xffffffffffffffbf)

    # Testcase 139:  imm:0x40, result rd:x16(0xffffffffffffff7f)
    la  x2, test_data
    addi    x2, x2,28
    li     x7, MASK_XLEN(-64)
    add    x2, x2, x7
    c.lwsp x16, 64(x2)
    sd x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x16, 0xffffffffffffff7f)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")



    # Addresses for test data and results
    la x1, test_29_res

    # Testcase 140:  imm:0x20, result rd:x17(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,32
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x17, 32(x2)
    sd x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xfffffffffffffeff)

    # Testcase 141:  imm:0x10, result rd:x18(0xfffffffffffffdff)
    la  x2, test_data
    addi    x2, x2,36
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x18, 16(x2)
    sd x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0xfffffffffffffdff)

    # Testcase 142:  imm:0x8, result rd:x19(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,40
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x19, 8(x2)
    sd x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xfffffffffffffeff)

    # Testcase 143:  imm:0x4, result rd:x20(0xfffffffffffff7ff)
    la  x2, test_data
    addi    x2, x2,44
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x20, 4(x2)
    sd x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0xfffffffffffff7ff)

    # Testcase 144:  imm:0x7c, result rd:x21(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,48
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x21, 124(x2)
    sd x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0xffffffffffffefff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")



    # Addresses for test data and results
    la x1, test_30_res

    # Testcase 145:  imm:0x3c, result rd:x22(0xffffffffffffdfff)
    la  x2, test_data
    addi    x2, x2,52
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x22, 60(x2)
    sd x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0xffffffffffffdfff)

    # Testcase 146:  imm:0x5c, result rd:x23(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,56
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x23, 92(x2)
    sd x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0xffffffffffffefff)

    # Testcase 147:  imm:0x6c, result rd:x24(0xffffffffffff7fff)
    la  x2, test_data
    addi    x2, x2,60
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x24, 108(x2)
    sd x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0xffffffffffff7fff)

    # Testcase 148:  imm:0x74, result rd:x25(0xfffffffffffeffff)
    la  x2, test_data
    addi    x2, x2,64
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x25, 116(x2)
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0xfffffffffffeffff)

    # Testcase 149:  imm:0x78, result rd:x26(0xfffffffffffdffff)
    la  x2, test_data
    addi    x2, x2,68
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x26, 120(x2)
    sd x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0xfffffffffffdffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")



    # Addresses for test data and results
    la x1, test_31_res

    # Testcase 150:  imm:0x0, result rd:x27(0xfffffffffffbffff)
    la  x2, test_data
    addi    x2, x2,72
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x27, 0(x2)
    sd x27, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0xfffffffffffbffff)

    # Testcase 151:  imm:0x40, result rd:x28(0xfffffffffff7ffff)
    la  x2, test_data
    addi    x2, x2,76
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x28, 64(x2)
    sd x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0xfffffffffff7ffff)

    # Testcase 152:  imm:0x20, result rd:x29(0xffffffffffefffff)
    la  x2, test_data
    addi    x2, x2,80
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x29, 32(x2)
    sd x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0xffffffffffefffff)

    # Testcase 153:  imm:0x10, result rd:x30(0xffffffffffdfffff)
    la  x2, test_data
    addi    x2, x2,84
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x30, 16(x2)
    sd x30, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x30, 0xffffffffffdfffff)

    # Testcase 154:  imm:0x8, result rd:x31(0xffffffffffbfffff)
    la  x2, test_data
    addi    x2, x2,88
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x31, 8(x2)
    sd x31, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x31, 0xffffffffffbfffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")



    # Addresses for test data and results
    la x6, test_32_res

    # Testcase 155:  imm:0x4, result rd:x1(0xffffffffff7fffff)
    la  x2, test_data
    addi    x2, x2,92
    li     x7, MASK_XLEN(-4)
    add    x2, x2, x7
    c.lwsp x1, 4(x2)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xffffffffff7fffff)

    # Testcase 156:  imm:0x7c, result rd:x2(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,96
    li     x7, MASK_XLEN(-124)
    add    x2, x2, x7
    c.lwsp x2, 124(x2)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0xfffffffffeffffff)

    # Testcase 157:  imm:0x3c, result rd:x3(0xfffffffffdffffff)
    la  x2, test_data
    addi    x2, x2,100
    li     x7, MASK_XLEN(-60)
    add    x2, x2, x7
    c.lwsp x3, 60(x2)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0xfffffffffdffffff)

    # Testcase 158:  imm:0x5c, result rd:x4(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,104
    li     x7, MASK_XLEN(-92)
    add    x2, x2, x7
    c.lwsp x4, 92(x2)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0xfffffffffeffffff)

    # Testcase 159:  imm:0x6c, result rd:x5(0xfffffffff7ffffff)
    la  x2, test_data
    addi    x2, x2,108
    li     x7, MASK_XLEN(-108)
    add    x2, x2, x7
    c.lwsp x5, 108(x2)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0xfffffffff7ffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")



    # Addresses for test data and results
    la x1, test_33_res

    # Testcase 160:  imm:0x74, result rd:x6(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,112
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x6, 116(x2)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0xffffffffefffffff)

    # Testcase 161:  imm:0x78, result rd:x7(0xffffffffdfffffff)
    la  x2, test_data
    addi    x2, x2,116
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x7, 120(x2)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0xffffffffdfffffff)

    # Testcase 162:  imm:0x0, result rd:x8(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,120
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x8, 0(x2)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0xffffffffefffffff)

    # Testcase 163:  imm:0x40, result rd:x9(0x000000007fffffff)
    la  x2, test_data
    addi    x2, x2,124
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x9, 64(x2)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0x000000007fffffff)

    # Testcase 164:  imm:0x20, result rd:x10(0xffffffffffffffff)
    la  x2, test_data
    addi    x2, x2,128
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x10, 32(x2)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xffffffffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")



    # Addresses for test data and results
    la x7, test_34_res

    # Testcase 165:  imm:0x10, result rd:x11(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,132
    li     x8, MASK_XLEN(-16)
    add    x2, x2, x8
    c.lwsp x11, 16(x2)
    sd x11, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x11, 0x0000000000000001)

    # Testcase 166:  imm:0x8, result rd:x12(0x0000000000000002)
    la  x2, test_data
    addi    x2, x2,136
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    c.lwsp x12, 8(x2)
    sd x12, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x12, 0x0000000000000002)

    # Testcase 167:  imm:0x4, result rd:x13(0x0000000000000004)
    la  x2, test_data
    addi    x2, x2,140
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    c.lwsp x13, 4(x2)
    sd x13, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x13, 0x0000000000000004)

    # Testcase 168:  imm:0x7c, result rd:x14(0x0000000000000008)
    la  x2, test_data
    addi    x2, x2,144
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    c.lwsp x14, 124(x2)
    sd x14, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x14, 0x0000000000000008)

    # Testcase 169:  imm:0x3c, result rd:x15(0x0000000000000010)
    la  x2, test_data
    addi    x2, x2,148
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    c.lwsp x15, 60(x2)
    sd x15, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0x0000000000000010)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")



    # Addresses for test data and results
    la x3, test_35_res

    # Testcase 170:  imm:0x5c, result rd:x16(0x0000000000000020)
    la  x2, test_data
    addi    x2, x2,152
    li     x4, MASK_XLEN(-92)
    add    x2, x2, x4
    c.lwsp x16, 92(x2)
    sd x16, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0000000000000020)

    # Testcase 171:  imm:0x6c, result rd:x17(0x0000000000000040)
    la  x2, test_data
    addi    x2, x2,156
    li     x4, MASK_XLEN(-108)
    add    x2, x2, x4
    c.lwsp x17, 108(x2)
    sd x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x0000000000000040)

    # Testcase 172:  imm:0x74, result rd:x18(0x0000000000000080)
    la  x2, test_data
    addi    x2, x2,160
    li     x4, MASK_XLEN(-116)
    add    x2, x2, x4
    c.lwsp x18, 116(x2)
    sd x18, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x0000000000000080)

    # Testcase 173:  imm:0x78, result rd:x19(0x0000000000000100)
    la  x2, test_data
    addi    x2, x2,164
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    c.lwsp x19, 120(x2)
    sd x19, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0x0000000000000100)

    # Testcase 174:  imm:0x0, result rd:x20(0x0000000000000200)
    la  x2, test_data
    addi    x2, x2,168
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    c.lwsp x20, 0(x2)
    sd x20, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x20, 0x0000000000000200)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")



    # Addresses for test data and results
    la x1, test_36_res

    # Testcase 175:  imm:0x40, result rd:x21(0x0000000000000400)
    la  x2, test_data
    addi    x2, x2,172
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x21, 64(x2)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0x0000000000000400)

    # Testcase 176:  imm:0x20, result rd:x22(0x0000000000000800)
    la  x2, test_data
    addi    x2, x2,176
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x22, 32(x2)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0x0000000000000800)

    # Testcase 177:  imm:0x10, result rd:x23(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,180
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x23, 16(x2)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0x0000000000001000)

    # Testcase 178:  imm:0x8, result rd:x24(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,184
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x24, 8(x2)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0x0000000000002000)

    # Testcase 179:  imm:0x4, result rd:x25(0x0000000000004000)
    la  x2, test_data
    addi    x2, x2,188
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x25, 4(x2)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0x0000000000004000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")



    # Addresses for test data and results
    la x1, test_37_res

    # Testcase 180:  imm:0x7c, result rd:x26(0x0000000000008000)
    la  x2, test_data
    addi    x2, x2,192
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x26, 124(x2)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0x0000000000008000)

    # Testcase 181:  imm:0x3c, result rd:x27(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,196
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x27, 60(x2)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0x0000000000000001)

    # Testcase 182:  imm:0x5c, result rd:x28(0x0000000000000002)
    la  x2, test_data
    addi    x2, x2,200
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x28, 92(x2)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0x0000000000000002)

    # Testcase 183:  imm:0x6c, result rd:x29(0x0000000000040000)
    la  x2, test_data
    addi    x2, x2,204
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x29, 108(x2)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0x0000000000040000)

    # Testcase 184:  imm:0x74, result rd:x30(0x0000000000080000)
    la  x2, test_data
    addi    x2, x2,208
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x30, 116(x2)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x30, 0x0000000000080000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")



    # Addresses for test data and results
    la x5, test_38_res

    # Testcase 185:  imm:0x78, result rd:x31(0x0000000000000010)
    la  x2, test_data
    addi    x2, x2,212
    li     x6, MASK_XLEN(-120)
    add    x2, x2, x6
    c.lwsp x31, 120(x2)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0x0000000000000010)

    # Testcase 186:  imm:0x0, result rd:x1(0x0000000000000020)
    la  x2, test_data
    addi    x2, x2,216
    li     x6, MASK_XLEN(0)
    add    x2, x2, x6
    c.lwsp x1, 0(x2)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x0000000000000020)

    # Testcase 187:  imm:0x40, result rd:x2(0x0000000000400000)
    la  x2, test_data
    addi    x2, x2,220
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    c.lwsp x2, 64(x2)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0x0000000000400000)

    # Testcase 188:  imm:0x20, result rd:x3(0x0000000000800000)
    la  x2, test_data
    addi    x2, x2,224
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    c.lwsp x3, 32(x2)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x0000000000800000)

    # Testcase 189:  imm:0x10, result rd:x4(0x0000000000000100)
    la  x2, test_data
    addi    x2, x2,228
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    c.lwsp x4, 16(x2)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x0000000000000100)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")



    # Addresses for test data and results
    la x1, test_39_res

    # Testcase 190:  imm:0x8, result rd:x5(0x0000000000000200)
    la  x2, test_data
    addi    x2, x2,232
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x5, 8(x2)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x0000000000000200)

    # Testcase 191:  imm:0x4, result rd:x6(0x0000000004000000)
    la  x2, test_data
    addi    x2, x2,236
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x6, 4(x2)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0x0000000004000000)

    # Testcase 192:  imm:0x7c, result rd:x7(0x0000000008000000)
    la  x2, test_data
    addi    x2, x2,240
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x7, 124(x2)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0x0000000008000000)

    # Testcase 193:  imm:0x3c, result rd:x8(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,244
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x8, 60(x2)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x0000000000001000)

    # Testcase 194:  imm:0x5c, result rd:x9(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,248
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x9, 92(x2)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0x0000000000002000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")



    # Addresses for test data and results
    la x1, test_40_res

    # Testcase 195:  imm:0x6c, result rd:x10(0x0000000040000000)
    la  x2, test_data
    addi    x2, x2,252
    li     x8, MASK_XLEN(-108)
    add    x2, x2, x8
    c.lwsp x10, 108(x2)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0x0000000040000000)

    # Testcase 196:  imm:0x74, result rd:x11(0xffffffff80000000)
    la  x2, test_data
    addi    x2, x2,256
    li     x8, MASK_XLEN(-116)
    add    x2, x2, x8
    c.lwsp x11, 116(x2)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x11, 0xffffffff80000000)

    # Testcase 197:  imm:0x78, result rd:x12(0x0000000000000000)
    la  x2, test_data
    addi    x2, x2,260
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    c.lwsp x12, 120(x2)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x12, 0x0000000000000000)

    # Testcase 198:  imm:0x0, result rd:x13(0xfffffffffffffffe)
    la  x2, test_data
    addi    x2, x2,0
    li     x8, MASK_XLEN(0)
    add    x2, x2, x8
    c.lwsp x13, 0(x2)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x13, 0xfffffffffffffffe)

    # Testcase 199:  imm:0x40, result rd:x14(0xfffffffffffffffd)
    la  x2, test_data
    addi    x2, x2,4
    li     x8, MASK_XLEN(-64)
    add    x2, x2, x8
    c.lwsp x14, 64(x2)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x14, 0xfffffffffffffffd)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")



    # Addresses for test data and results
    la x3, test_41_res

    # Testcase 200:  imm:0x20, result rd:x15(0xfffffffffffffffb)
    la  x2, test_data
    addi    x2, x2,8
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    c.lwsp x15, 32(x2)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xfffffffffffffffb)

    # Testcase 201:  imm:0x10, result rd:x16(0xfffffffffffffff7)
    la  x2, test_data
    addi    x2, x2,12
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    c.lwsp x16, 16(x2)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xfffffffffffffff7)

    # Testcase 202:  imm:0x8, result rd:x17(0xffffffffffffffef)
    la  x2, test_data
    addi    x2, x2,16
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    c.lwsp x17, 8(x2)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xffffffffffffffef)

    # Testcase 203:  imm:0x4, result rd:x18(0xffffffffffffffdf)
    la  x2, test_data
    addi    x2, x2,20
    li     x4, MASK_XLEN(-4)
    add    x2, x2, x4
    c.lwsp x18, 4(x2)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xffffffffffffffdf)

    # Testcase 204:  imm:0x7c, result rd:x19(0xffffffffffffffbf)
    la  x2, test_data
    addi    x2, x2,24
    li     x4, MASK_XLEN(-124)
    add    x2, x2, x4
    c.lwsp x19, 124(x2)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0xffffffffffffffbf)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")



    # Addresses for test data and results
    la x1, test_42_res

    # Testcase 205:  imm:0x3c, result rd:x20(0xffffffffffffff7f)
    la  x2, test_data
    addi    x2, x2,28
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x20, 60(x2)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0xffffffffffffff7f)

    # Testcase 206:  imm:0x5c, result rd:x21(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,32
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x21, 92(x2)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0xfffffffffffffeff)

    # Testcase 207:  imm:0x6c, result rd:x22(0xfffffffffffffdff)
    la  x2, test_data
    addi    x2, x2,36
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x22, 108(x2)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0xfffffffffffffdff)

    # Testcase 208:  imm:0x74, result rd:x23(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,40
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x23, 116(x2)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0xfffffffffffffeff)

    # Testcase 209:  imm:0x78, result rd:x24(0xfffffffffffff7ff)
    la  x2, test_data
    addi    x2, x2,44
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x24, 120(x2)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0xfffffffffffff7ff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")



    # Addresses for test data and results
    la x1, test_43_res

    # Testcase 210:  imm:0x0, result rd:x25(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,48
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x25, 0(x2)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0xffffffffffffefff)

    # Testcase 211:  imm:0x40, result rd:x26(0xffffffffffffdfff)
    la  x2, test_data
    addi    x2, x2,52
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x26, 64(x2)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0xffffffffffffdfff)

    # Testcase 212:  imm:0x20, result rd:x27(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,56
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x27, 32(x2)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0xffffffffffffefff)

    # Testcase 213:  imm:0x10, result rd:x28(0xffffffffffff7fff)
    la  x2, test_data
    addi    x2, x2,60
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x28, 16(x2)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0xffffffffffff7fff)

    # Testcase 214:  imm:0x8, result rd:x29(0xfffffffffffeffff)
    la  x2, test_data
    addi    x2, x2,64
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x29, 8(x2)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0xfffffffffffeffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")



    # Addresses for test data and results
    la x4, test_44_res

    # Testcase 215:  imm:0x4, result rd:x30(0xfffffffffffdffff)
    la  x2, test_data
    addi    x2, x2,68
    li     x5, MASK_XLEN(-4)
    add    x2, x2, x5
    c.lwsp x30, 4(x2)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0xfffffffffffdffff)

    # Testcase 216:  imm:0x7c, result rd:x31(0xfffffffffffbffff)
    la  x2, test_data
    addi    x2, x2,72
    li     x5, MASK_XLEN(-124)
    add    x2, x2, x5
    c.lwsp x31, 124(x2)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xfffffffffffbffff)

    # Testcase 217:  imm:0x3c, result rd:x1(0xfffffffffff7ffff)
    la  x2, test_data
    addi    x2, x2,76
    li     x5, MASK_XLEN(-60)
    add    x2, x2, x5
    c.lwsp x1, 60(x2)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xfffffffffff7ffff)

    # Testcase 218:  imm:0x5c, result rd:x2(0xffffffffffefffff)
    la  x2, test_data
    addi    x2, x2,80
    li     x5, MASK_XLEN(-92)
    add    x2, x2, x5
    c.lwsp x2, 92(x2)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xffffffffffefffff)

    # Testcase 219:  imm:0x6c, result rd:x3(0xffffffffffdfffff)
    la  x2, test_data
    addi    x2, x2,84
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    c.lwsp x3, 108(x2)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0xffffffffffdfffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")



    # Addresses for test data and results
    la x1, test_45_res

    # Testcase 220:  imm:0x74, result rd:x4(0xffffffffffbfffff)
    la  x2, test_data
    addi    x2, x2,88
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x4, 116(x2)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x4, 0xffffffffffbfffff)

    # Testcase 221:  imm:0x78, result rd:x5(0xffffffffff7fffff)
    la  x2, test_data
    addi    x2, x2,92
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x5, 120(x2)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x5, 0xffffffffff7fffff)

    # Testcase 222:  imm:0x0, result rd:x6(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,96
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x6, 0(x2)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x6, 0xfffffffffeffffff)

    # Testcase 223:  imm:0x40, result rd:x7(0xfffffffffdffffff)
    la  x2, test_data
    addi    x2, x2,100
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x7, 64(x2)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x7, 0xfffffffffdffffff)

    # Testcase 224:  imm:0x20, result rd:x8(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,104
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x8, 32(x2)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x8, 0xfffffffffeffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")



    # Addresses for test data and results
    la x1, test_46_res

    # Testcase 225:  imm:0x10, result rd:x9(0xfffffffff7ffffff)
    la  x2, test_data
    addi    x2, x2,108
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x9, 16(x2)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x9, 0xfffffffff7ffffff)

    # Testcase 226:  imm:0x8, result rd:x10(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,112
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x10, 8(x2)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x10, 0xffffffffefffffff)

    # Testcase 227:  imm:0x4, result rd:x11(0xffffffffdfffffff)
    la  x2, test_data
    addi    x2, x2,116
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x11, 4(x2)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x11, 0xffffffffdfffffff)

    # Testcase 228:  imm:0x7c, result rd:x12(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,120
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x12, 124(x2)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x12, 0xffffffffefffffff)

    # Testcase 229:  imm:0x3c, result rd:x13(0x000000007fffffff)
    la  x2, test_data
    addi    x2, x2,124
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x13, 60(x2)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x13, 0x000000007fffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")



    # Addresses for test data and results
    la x4, test_47_res

    # Testcase 230:  imm:0x5c, result rd:x14(0xffffffffffffffff)
    la  x2, test_data
    addi    x2, x2,128
    li     x5, MASK_XLEN(-92)
    add    x2, x2, x5
    c.lwsp x14, 92(x2)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xffffffffffffffff)

    # Testcase 231:  imm:0x6c, result rd:x15(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,132
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    c.lwsp x15, 108(x2)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x0000000000000001)

    # Testcase 232:  imm:0x74, result rd:x16(0x0000000000000002)
    la  x2, test_data
    addi    x2, x2,136
    li     x5, MASK_XLEN(-116)
    add    x2, x2, x5
    c.lwsp x16, 116(x2)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x0000000000000002)

    # Testcase 233:  imm:0x78, result rd:x17(0x0000000000000004)
    la  x2, test_data
    addi    x2, x2,140
    li     x5, MASK_XLEN(-120)
    add    x2, x2, x5
    c.lwsp x17, 120(x2)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x0000000000000004)

    # Testcase 234:  imm:0x0, result rd:x18(0x0000000000000008)
    la  x2, test_data
    addi    x2, x2,144
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    c.lwsp x18, 0(x2)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x18, 0x0000000000000008)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")



    # Addresses for test data and results
    la x1, test_48_res

    # Testcase 235:  imm:0x40, result rd:x19(0x0000000000000010)
    la  x2, test_data
    addi    x2, x2,148
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x19, 64(x2)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0000000000000010)

    # Testcase 236:  imm:0x20, result rd:x20(0x0000000000000020)
    la  x2, test_data
    addi    x2, x2,152
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x20, 32(x2)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x0000000000000020)

    # Testcase 237:  imm:0x10, result rd:x21(0x0000000000000040)
    la  x2, test_data
    addi    x2, x2,156
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x21, 16(x2)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0x0000000000000040)

    # Testcase 238:  imm:0x8, result rd:x22(0x0000000000000080)
    la  x2, test_data
    addi    x2, x2,160
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x22, 8(x2)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0x0000000000000080)

    # Testcase 239:  imm:0x4, result rd:x23(0x0000000000000100)
    la  x2, test_data
    addi    x2, x2,164
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x23, 4(x2)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0x0000000000000100)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")



    # Addresses for test data and results
    la x1, test_49_res

    # Testcase 240:  imm:0x7c, result rd:x24(0x0000000000000200)
    la  x2, test_data
    addi    x2, x2,168
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x24, 124(x2)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0x0000000000000200)

    # Testcase 241:  imm:0x3c, result rd:x25(0x0000000000000400)
    la  x2, test_data
    addi    x2, x2,172
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x25, 60(x2)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0x0000000000000400)

    # Testcase 242:  imm:0x5c, result rd:x26(0x0000000000000800)
    la  x2, test_data
    addi    x2, x2,176
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x26, 92(x2)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0x0000000000000800)

    # Testcase 243:  imm:0x6c, result rd:x27(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,180
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x27, 108(x2)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0x0000000000001000)

    # Testcase 244:  imm:0x74, result rd:x28(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,184
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x28, 116(x2)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0x0000000000002000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")



    # Addresses for test data and results
    la x3, test_50_res

    # Testcase 245:  imm:0x78, result rd:x29(0x0000000000004000)
    la  x2, test_data
    addi    x2, x2,188
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    c.lwsp x29, 120(x2)
    sd x29, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x0000000000004000)

    # Testcase 246:  imm:0x0, result rd:x30(0x0000000000008000)
    la  x2, test_data
    addi    x2, x2,192
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    c.lwsp x30, 0(x2)
    sd x30, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0000000000008000)

    # Testcase 247:  imm:0x40, result rd:x31(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,196
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    c.lwsp x31, 64(x2)
    sd x31, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0000000000000001)

    # Testcase 248:  imm:0x20, result rd:x1(0x0000000000000002)
    la  x2, test_data
    addi    x2, x2,200
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    c.lwsp x1, 32(x2)
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0000000000000002)

    # Testcase 249:  imm:0x10, result rd:x2(0x0000000000040000)
    la  x2, test_data
    addi    x2, x2,204
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    c.lwsp x2, 16(x2)
    sd x2, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0000000000040000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")



    # Addresses for test data and results
    la x1, test_51_res

    # Testcase 250:  imm:0x8, result rd:x3(0x0000000000080000)
    la  x2, test_data
    addi    x2, x2,208
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    c.lwsp x3, 8(x2)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x3, 0x0000000000080000)

    # Testcase 251:  imm:0x4, result rd:x4(0x0000000000000010)
    la  x2, test_data
    addi    x2, x2,212
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    c.lwsp x4, 4(x2)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x4, 0x0000000000000010)

    # Testcase 252:  imm:0x7c, result rd:x5(0x0000000000000020)
    la  x2, test_data
    addi    x2, x2,216
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    c.lwsp x5, 124(x2)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x5, 0x0000000000000020)

    # Testcase 253:  imm:0x3c, result rd:x6(0x0000000000400000)
    la  x2, test_data
    addi    x2, x2,220
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    c.lwsp x6, 60(x2)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x6, 0x0000000000400000)

    # Testcase 254:  imm:0x5c, result rd:x7(0x0000000000800000)
    la  x2, test_data
    addi    x2, x2,224
    li     x8, MASK_XLEN(-92)
    add    x2, x2, x8
    c.lwsp x7, 92(x2)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x7, 0x0000000000800000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")



    # Addresses for test data and results
    la x1, test_52_res

    # Testcase 255:  imm:0x6c, result rd:x8(0x0000000000000100)
    la  x2, test_data
    addi    x2, x2,228
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x8, 108(x2)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x0000000000000100)

    # Testcase 256:  imm:0x74, result rd:x9(0x0000000000000200)
    la  x2, test_data
    addi    x2, x2,232
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x9, 116(x2)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0x0000000000000200)

    # Testcase 257:  imm:0x78, result rd:x10(0x0000000004000000)
    la  x2, test_data
    addi    x2, x2,236
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x10, 120(x2)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0x0000000004000000)

    # Testcase 258:  imm:0x0, result rd:x11(0x0000000008000000)
    la  x2, test_data
    addi    x2, x2,240
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x11, 0(x2)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x11, 0x0000000008000000)

    # Testcase 259:  imm:0x40, result rd:x12(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,244
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x12, 64(x2)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x12, 0x0000000000001000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")



    # Addresses for test data and results
    la x5, test_53_res

    # Testcase 260:  imm:0x20, result rd:x13(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,248
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    c.lwsp x13, 32(x2)
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0000000000002000)

    # Testcase 261:  imm:0x10, result rd:x14(0x0000000040000000)
    la  x2, test_data
    addi    x2, x2,252
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    c.lwsp x14, 16(x2)
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0000000040000000)

    # Testcase 262:  imm:0x8, result rd:x15(0xffffffff80000000)
    la  x2, test_data
    addi    x2, x2,256
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    c.lwsp x15, 8(x2)
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0xffffffff80000000)

    # Testcase 263:  imm:0x4, result rd:x16(0x0000000000000000)
    la  x2, test_data
    addi    x2, x2,260
    li     x6, MASK_XLEN(-4)
    add    x2, x2, x6
    c.lwsp x16, 4(x2)
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x0000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	
	RVTEST_IO_WRITE_STR(x31, "Test End\n")

	# ---------------------------------------------------------------------------------------------

	RV_COMPLIANCE_HALT

RV_COMPLIANCE_CODE_END

# Input data section.
	.data

	.align 8
test_data:

	.dword 0xfffffffdfffffffe
	.dword 0xfffffff7fffffffb
	.dword 0xffffffdfffffffef
	.dword 0xffffff7fffffffbf
	.dword 0xfffffdfffffffeff
	.dword 0xfffff7fffffffeff
	.dword 0xffffdfffffffefff
	.dword 0xffff7fffffffefff
	.dword 0xfffdfffffffeffff
	.dword 0xfff7fffffffbffff
	.dword 0xffdfffffffefffff
	.dword 0xff7fffffffbfffff
	.dword 0xfdfffffffeffffff
	.dword 0xf7fffffffeffffff
	.dword 0xdfffffffefffffff
	.dword 0x7fffffffefffffff
	.dword 0x00000001ffffffff
	.dword 0x0000000400000002
	.dword 0x0000001000000008
	.dword 0x0000004000000020
	.dword 0x0000010000000080
	.dword 0x0000040000000200
	.dword 0x0000100000000800
	.dword 0x0000400000002000
	.dword 0x0000000100008000
	.dword 0x0004000000000002
	.dword 0x0000001000080000
	.dword 0x0040000000000020
	.dword 0x0000010000800000
	.dword 0x0400000000000200
	.dword 0x0000100008000000
	.dword 0x4000000000002000
	.dword 0x0000000080000000


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

