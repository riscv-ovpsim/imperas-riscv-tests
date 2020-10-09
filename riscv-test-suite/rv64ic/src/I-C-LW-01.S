# RISC-V Compliance Test I-C-LW-01
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
# Description: Testing instruction 'c.lw'.

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
    la x1, test_1_res

    # Testcase 0:  imm:0x7c, result rd:x8(0xfffffffffffffffe)
    la  x15, test_data
    addi    x15, x15,0
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffffffffe)

    # Testcase 1:  imm:0x3c, result rd:x9(0xfffffffffffffffd)
    la  x14, test_data
    addi    x14, x14,4
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffffffffd)

    # Testcase 2:  imm:0x5c, result rd:x10(0xfffffffffffffffb)
    la  x13, test_data
    addi    x13, x13,8
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffffffffb)

    # Testcase 3:  imm:0x6c, result rd:x11(0xfffffffffffffff7)
    la  x12, test_data
    addi    x12, x12,12
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffffffffff7)

    # Testcase 4:  imm:0x74, result rd:x12(0xffffffffffffffef)
    la  x11, test_data
    addi    x11, x11,16
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffffffef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")



    # Addresses for test data and results
    la x1, test_2_res

    # Testcase 5:  imm:0x78, result rd:x13(0xffffffffffffffdf)
    la  x10, test_data
    addi    x10, x10,20
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffffffffdf)

    # Testcase 6:  imm:0x0, result rd:x14(0xffffffffffffffbf)
    la  x9, test_data
    addi    x9, x9,24
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffffffffbf)

    # Testcase 7:  imm:0x40, result rd:x15(0xffffffffffffff7f)
    la  x8, test_data
    addi    x8, x8,28
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffffffffff7f)

    # Testcase 8:  imm:0x20, result rd:x8(0xfffffffffffffeff)
    la  x15, test_data
    addi    x15, x15,32
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffffffeff)

    # Testcase 9:  imm:0x10, result rd:x9(0xfffffffffffffdff)
    la  x14, test_data
    addi    x14, x14,36
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffffffdff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")



    # Addresses for test data and results
    la x1, test_3_res

    # Testcase 10:  imm:0x8, result rd:x10(0xfffffffffffffeff)
    la  x13, test_data
    addi    x13, x13,40
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffffffeff)

    # Testcase 11:  imm:0x4, result rd:x11(0xfffffffffffff7ff)
    la  x12, test_data
    addi    x12, x12,44
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffffffff7ff)

    # Testcase 12:  imm:0x7c, result rd:x12(0xffffffffffffefff)
    la  x11, test_data
    addi    x11, x11,48
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffffefff)

    # Testcase 13:  imm:0x3c, result rd:x13(0xffffffffffffdfff)
    la  x10, test_data
    addi    x10, x10,52
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffffffdfff)

    # Testcase 14:  imm:0x5c, result rd:x14(0xffffffffffffefff)
    la  x9, test_data
    addi    x9, x9,56
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffffffefff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")



    # Addresses for test data and results
    la x1, test_4_res

    # Testcase 15:  imm:0x6c, result rd:x15(0xffffffffffff7fff)
    la  x8, test_data
    addi    x8, x8,60
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffffffff7fff)

    # Testcase 16:  imm:0x74, result rd:x8(0xfffffffffffeffff)
    la  x15, test_data
    addi    x15, x15,64
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffffeffff)

    # Testcase 17:  imm:0x78, result rd:x9(0xfffffffffffdffff)
    la  x14, test_data
    addi    x14, x14,68
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffffdffff)

    # Testcase 18:  imm:0x0, result rd:x10(0xfffffffffffbffff)
    la  x13, test_data
    addi    x13, x13,72
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffffbffff)

    # Testcase 19:  imm:0x40, result rd:x11(0xfffffffffff7ffff)
    la  x12, test_data
    addi    x12, x12,76
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffffff7ffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")



    # Addresses for test data and results
    la x1, test_5_res

    # Testcase 20:  imm:0x20, result rd:x12(0xffffffffffefffff)
    la  x11, test_data
    addi    x11, x11,80
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffefffff)

    # Testcase 21:  imm:0x10, result rd:x13(0xffffffffffdfffff)
    la  x10, test_data
    addi    x10, x10,84
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffffdfffff)

    # Testcase 22:  imm:0x8, result rd:x14(0xffffffffffbfffff)
    la  x9, test_data
    addi    x9, x9,88
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffffbfffff)

    # Testcase 23:  imm:0x4, result rd:x15(0xffffffffff7fffff)
    la  x8, test_data
    addi    x8, x8,92
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffffff7fffff)

    # Testcase 24:  imm:0x7c, result rd:x8(0xfffffffffeffffff)
    la  x15, test_data
    addi    x15, x15,96
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffeffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")



    # Addresses for test data and results
    la x1, test_6_res

    # Testcase 25:  imm:0x3c, result rd:x9(0xfffffffffdffffff)
    la  x14, test_data
    addi    x14, x14,100
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffdffffff)

    # Testcase 26:  imm:0x5c, result rd:x10(0xfffffffffeffffff)
    la  x13, test_data
    addi    x13, x13,104
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffeffffff)

    # Testcase 27:  imm:0x6c, result rd:x11(0xfffffffff7ffffff)
    la  x12, test_data
    addi    x12, x12,108
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffff7ffffff)

    # Testcase 28:  imm:0x74, result rd:x12(0xffffffffefffffff)
    la  x11, test_data
    addi    x11, x11,112
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffefffffff)

    # Testcase 29:  imm:0x78, result rd:x13(0xffffffffdfffffff)
    la  x10, test_data
    addi    x10, x10,116
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffdfffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")



    # Addresses for test data and results
    la x1, test_7_res

    # Testcase 30:  imm:0x0, result rd:x14(0xffffffffefffffff)
    la  x9, test_data
    addi    x9, x9,120
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffefffffff)

    # Testcase 31:  imm:0x40, result rd:x15(0x000000007fffffff)
    la  x8, test_data
    addi    x8, x8,124
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x000000007fffffff)

    # Testcase 32:  imm:0x20, result rd:x8(0xffffffffffffffff)
    la  x15, test_data
    addi    x15, x15,128
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffffffff)

    # Testcase 33:  imm:0x10, result rd:x9(0x0000000000000001)
    la  x14, test_data
    addi    x14, x14,132
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000001)

    # Testcase 34:  imm:0x8, result rd:x10(0x0000000000000002)
    la  x13, test_data
    addi    x13, x13,136
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000002)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")



    # Addresses for test data and results
    la x1, test_8_res

    # Testcase 35:  imm:0x4, result rd:x11(0x0000000000000004)
    la  x12, test_data
    addi    x12, x12,140
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000004)

    # Testcase 36:  imm:0x7c, result rd:x12(0x0000000000000008)
    la  x11, test_data
    addi    x11, x11,144
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000008)

    # Testcase 37:  imm:0x3c, result rd:x13(0x0000000000000010)
    la  x10, test_data
    addi    x10, x10,148
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000010)

    # Testcase 38:  imm:0x5c, result rd:x14(0x0000000000000020)
    la  x9, test_data
    addi    x9, x9,152
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000020)

    # Testcase 39:  imm:0x6c, result rd:x15(0x0000000000000040)
    la  x8, test_data
    addi    x8, x8,156
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000040)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")



    # Addresses for test data and results
    la x1, test_9_res

    # Testcase 40:  imm:0x74, result rd:x8(0x0000000000000080)
    la  x15, test_data
    addi    x15, x15,160
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000080)

    # Testcase 41:  imm:0x78, result rd:x9(0x0000000000000100)
    la  x14, test_data
    addi    x14, x14,164
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000100)

    # Testcase 42:  imm:0x0, result rd:x10(0x0000000000000200)
    la  x13, test_data
    addi    x13, x13,168
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000200)

    # Testcase 43:  imm:0x40, result rd:x11(0x0000000000000400)
    la  x12, test_data
    addi    x12, x12,172
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000400)

    # Testcase 44:  imm:0x20, result rd:x12(0x0000000000000800)
    la  x11, test_data
    addi    x11, x11,176
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000800)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")



    # Addresses for test data and results
    la x1, test_10_res

    # Testcase 45:  imm:0x10, result rd:x13(0x0000000000001000)
    la  x10, test_data
    addi    x10, x10,180
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000001000)

    # Testcase 46:  imm:0x8, result rd:x14(0x0000000000002000)
    la  x9, test_data
    addi    x9, x9,184
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000002000)

    # Testcase 47:  imm:0x4, result rd:x15(0x0000000000004000)
    la  x8, test_data
    addi    x8, x8,188
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000004000)

    # Testcase 48:  imm:0x7c, result rd:x8(0x0000000000008000)
    la  x15, test_data
    addi    x15, x15,192
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000008000)

    # Testcase 49:  imm:0x3c, result rd:x9(0x0000000000000001)
    la  x14, test_data
    addi    x14, x14,196
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000001)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")



    # Addresses for test data and results
    la x1, test_11_res

    # Testcase 50:  imm:0x5c, result rd:x10(0x0000000000000002)
    la  x13, test_data
    addi    x13, x13,200
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000002)

    # Testcase 51:  imm:0x6c, result rd:x11(0x0000000000040000)
    la  x12, test_data
    addi    x12, x12,204
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000040000)

    # Testcase 52:  imm:0x74, result rd:x12(0x0000000000080000)
    la  x11, test_data
    addi    x11, x11,208
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000080000)

    # Testcase 53:  imm:0x78, result rd:x13(0x0000000000000010)
    la  x10, test_data
    addi    x10, x10,212
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000010)

    # Testcase 54:  imm:0x0, result rd:x14(0x0000000000000020)
    la  x9, test_data
    addi    x9, x9,216
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000020)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")



    # Addresses for test data and results
    la x1, test_12_res

    # Testcase 55:  imm:0x40, result rd:x15(0x0000000000400000)
    la  x8, test_data
    addi    x8, x8,220
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000400000)

    # Testcase 56:  imm:0x20, result rd:x8(0x0000000000800000)
    la  x15, test_data
    addi    x15, x15,224
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000800000)

    # Testcase 57:  imm:0x10, result rd:x9(0x0000000000000100)
    la  x14, test_data
    addi    x14, x14,228
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000100)

    # Testcase 58:  imm:0x8, result rd:x10(0x0000000000000200)
    la  x13, test_data
    addi    x13, x13,232
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000200)

    # Testcase 59:  imm:0x4, result rd:x11(0x0000000004000000)
    la  x12, test_data
    addi    x12, x12,236
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000004000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")



    # Addresses for test data and results
    la x1, test_13_res

    # Testcase 60:  imm:0x7c, result rd:x12(0x0000000008000000)
    la  x11, test_data
    addi    x11, x11,240
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000008000000)

    # Testcase 61:  imm:0x3c, result rd:x13(0x0000000000001000)
    la  x10, test_data
    addi    x10, x10,244
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000001000)

    # Testcase 62:  imm:0x5c, result rd:x14(0x0000000000002000)
    la  x9, test_data
    addi    x9, x9,248
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000002000)

    # Testcase 63:  imm:0x6c, result rd:x15(0x0000000040000000)
    la  x8, test_data
    addi    x8, x8,252
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000040000000)

    # Testcase 64:  imm:0x74, result rd:x8(0xffffffff80000000)
    la  x15, test_data
    addi    x15, x15,256
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffff80000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")



    # Addresses for test data and results
    la x1, test_14_res

    # Testcase 65:  imm:0x78, result rd:x9(0x0000000000000000)
    la  x14, test_data
    addi    x14, x14,260
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000000)

    # Testcase 66:  imm:0x0, result rd:x10(0xfffffffffffffffe)
    la  x13, test_data
    addi    x13, x13,0
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffffffffe)

    # Testcase 67:  imm:0x40, result rd:x11(0xfffffffffffffffd)
    la  x12, test_data
    addi    x12, x12,4
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffffffffffd)

    # Testcase 68:  imm:0x20, result rd:x12(0xfffffffffffffffb)
    la  x11, test_data
    addi    x11, x11,8
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffffffffb)

    # Testcase 69:  imm:0x10, result rd:x13(0xfffffffffffffff7)
    la  x10, test_data
    addi    x10, x10,12
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffffffff7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")



    # Addresses for test data and results
    la x1, test_15_res

    # Testcase 70:  imm:0x8, result rd:x14(0xffffffffffffffef)
    la  x9, test_data
    addi    x9, x9,16
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffffffffef)

    # Testcase 71:  imm:0x4, result rd:x15(0xffffffffffffffdf)
    la  x8, test_data
    addi    x8, x8,20
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffffffffffdf)

    # Testcase 72:  imm:0x7c, result rd:x8(0xffffffffffffffbf)
    la  x15, test_data
    addi    x15, x15,24
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffffffbf)

    # Testcase 73:  imm:0x3c, result rd:x9(0xffffffffffffff7f)
    la  x14, test_data
    addi    x14, x14,28
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffffffff7f)

    # Testcase 74:  imm:0x5c, result rd:x10(0xfffffffffffffeff)
    la  x13, test_data
    addi    x13, x13,32
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffffffeff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")



    # Addresses for test data and results
    la x1, test_16_res

    # Testcase 75:  imm:0x6c, result rd:x11(0xfffffffffffffdff)
    la  x12, test_data
    addi    x12, x12,36
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffffffffdff)

    # Testcase 76:  imm:0x74, result rd:x12(0xfffffffffffffeff)
    la  x11, test_data
    addi    x11, x11,40
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffffffeff)

    # Testcase 77:  imm:0x78, result rd:x13(0xfffffffffffff7ff)
    la  x10, test_data
    addi    x10, x10,44
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffffff7ff)

    # Testcase 78:  imm:0x0, result rd:x14(0xffffffffffffefff)
    la  x9, test_data
    addi    x9, x9,48
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffffffefff)

    # Testcase 79:  imm:0x40, result rd:x15(0xffffffffffffdfff)
    la  x8, test_data
    addi    x8, x8,52
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffffffffdfff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")



    # Addresses for test data and results
    la x1, test_17_res

    # Testcase 80:  imm:0x20, result rd:x8(0xffffffffffffefff)
    la  x15, test_data
    addi    x15, x15,56
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffffefff)

    # Testcase 81:  imm:0x10, result rd:x9(0xffffffffffff7fff)
    la  x14, test_data
    addi    x14, x14,60
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffffff7fff)

    # Testcase 82:  imm:0x8, result rd:x10(0xfffffffffffeffff)
    la  x13, test_data
    addi    x13, x13,64
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffffeffff)

    # Testcase 83:  imm:0x4, result rd:x11(0xfffffffffffdffff)
    la  x12, test_data
    addi    x12, x12,68
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffffffdffff)

    # Testcase 84:  imm:0x7c, result rd:x12(0xfffffffffffbffff)
    la  x11, test_data
    addi    x11, x11,72
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffffbffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")



    # Addresses for test data and results
    la x1, test_18_res

    # Testcase 85:  imm:0x3c, result rd:x13(0xfffffffffff7ffff)
    la  x10, test_data
    addi    x10, x10,76
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffff7ffff)

    # Testcase 86:  imm:0x5c, result rd:x14(0xffffffffffefffff)
    la  x9, test_data
    addi    x9, x9,80
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffffefffff)

    # Testcase 87:  imm:0x6c, result rd:x15(0xffffffffffdfffff)
    la  x8, test_data
    addi    x8, x8,84
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffffffdfffff)

    # Testcase 88:  imm:0x74, result rd:x8(0xffffffffffbfffff)
    la  x15, test_data
    addi    x15, x15,88
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffbfffff)

    # Testcase 89:  imm:0x78, result rd:x9(0xffffffffff7fffff)
    la  x14, test_data
    addi    x14, x14,92
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffff7fffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")



    # Addresses for test data and results
    la x1, test_19_res

    # Testcase 90:  imm:0x0, result rd:x10(0xfffffffffeffffff)
    la  x13, test_data
    addi    x13, x13,96
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffeffffff)

    # Testcase 91:  imm:0x40, result rd:x11(0xfffffffffdffffff)
    la  x12, test_data
    addi    x12, x12,100
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffffdffffff)

    # Testcase 92:  imm:0x20, result rd:x12(0xfffffffffeffffff)
    la  x11, test_data
    addi    x11, x11,104
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffeffffff)

    # Testcase 93:  imm:0x10, result rd:x13(0xfffffffff7ffffff)
    la  x10, test_data
    addi    x10, x10,108
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffff7ffffff)

    # Testcase 94:  imm:0x8, result rd:x14(0xffffffffefffffff)
    la  x9, test_data
    addi    x9, x9,112
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffefffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")



    # Addresses for test data and results
    la x1, test_20_res

    # Testcase 95:  imm:0x4, result rd:x15(0xffffffffdfffffff)
    la  x8, test_data
    addi    x8, x8,116
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffffdfffffff)

    # Testcase 96:  imm:0x7c, result rd:x8(0xffffffffefffffff)
    la  x15, test_data
    addi    x15, x15,120
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffefffffff)

    # Testcase 97:  imm:0x3c, result rd:x9(0x000000007fffffff)
    la  x14, test_data
    addi    x14, x14,124
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x000000007fffffff)

    # Testcase 98:  imm:0x5c, result rd:x10(0xffffffffffffffff)
    la  x13, test_data
    addi    x13, x13,128
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffffffffff)

    # Testcase 99:  imm:0x6c, result rd:x11(0x0000000000000001)
    la  x12, test_data
    addi    x12, x12,132
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000001)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")



    # Addresses for test data and results
    la x1, test_21_res

    # Testcase 100:  imm:0x74, result rd:x12(0x0000000000000002)
    la  x11, test_data
    addi    x11, x11,136
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000002)

    # Testcase 101:  imm:0x78, result rd:x13(0x0000000000000004)
    la  x10, test_data
    addi    x10, x10,140
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000004)

    # Testcase 102:  imm:0x0, result rd:x14(0x0000000000000008)
    la  x9, test_data
    addi    x9, x9,144
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000008)

    # Testcase 103:  imm:0x40, result rd:x15(0x0000000000000010)
    la  x8, test_data
    addi    x8, x8,148
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000010)

    # Testcase 104:  imm:0x20, result rd:x8(0x0000000000000020)
    la  x15, test_data
    addi    x15, x15,152
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000020)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")



    # Addresses for test data and results
    la x1, test_22_res

    # Testcase 105:  imm:0x10, result rd:x9(0x0000000000000040)
    la  x14, test_data
    addi    x14, x14,156
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000040)

    # Testcase 106:  imm:0x8, result rd:x10(0x0000000000000080)
    la  x13, test_data
    addi    x13, x13,160
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000080)

    # Testcase 107:  imm:0x4, result rd:x11(0x0000000000000100)
    la  x12, test_data
    addi    x12, x12,164
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000100)

    # Testcase 108:  imm:0x7c, result rd:x12(0x0000000000000200)
    la  x11, test_data
    addi    x11, x11,168
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000200)

    # Testcase 109:  imm:0x3c, result rd:x13(0x0000000000000400)
    la  x10, test_data
    addi    x10, x10,172
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000400)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")



    # Addresses for test data and results
    la x1, test_23_res

    # Testcase 110:  imm:0x5c, result rd:x14(0x0000000000000800)
    la  x9, test_data
    addi    x9, x9,176
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000800)

    # Testcase 111:  imm:0x6c, result rd:x15(0x0000000000001000)
    la  x8, test_data
    addi    x8, x8,180
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000001000)

    # Testcase 112:  imm:0x74, result rd:x8(0x0000000000002000)
    la  x15, test_data
    addi    x15, x15,184
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000002000)

    # Testcase 113:  imm:0x78, result rd:x9(0x0000000000004000)
    la  x14, test_data
    addi    x14, x14,188
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000004000)

    # Testcase 114:  imm:0x0, result rd:x10(0x0000000000008000)
    la  x13, test_data
    addi    x13, x13,192
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000008000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")



    # Addresses for test data and results
    la x1, test_24_res

    # Testcase 115:  imm:0x40, result rd:x11(0x0000000000000001)
    la  x12, test_data
    addi    x12, x12,196
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000001)

    # Testcase 116:  imm:0x20, result rd:x12(0x0000000000000002)
    la  x11, test_data
    addi    x11, x11,200
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000002)

    # Testcase 117:  imm:0x10, result rd:x13(0x0000000000040000)
    la  x10, test_data
    addi    x10, x10,204
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000040000)

    # Testcase 118:  imm:0x8, result rd:x14(0x0000000000080000)
    la  x9, test_data
    addi    x9, x9,208
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000080000)

    # Testcase 119:  imm:0x4, result rd:x15(0x0000000000000010)
    la  x8, test_data
    addi    x8, x8,212
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000010)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")



    # Addresses for test data and results
    la x1, test_25_res

    # Testcase 120:  imm:0x7c, result rd:x8(0x0000000000000020)
    la  x15, test_data
    addi    x15, x15,216
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000020)

    # Testcase 121:  imm:0x3c, result rd:x9(0x0000000000400000)
    la  x14, test_data
    addi    x14, x14,220
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000400000)

    # Testcase 122:  imm:0x5c, result rd:x10(0x0000000000800000)
    la  x13, test_data
    addi    x13, x13,224
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000800000)

    # Testcase 123:  imm:0x6c, result rd:x11(0x0000000000000100)
    la  x12, test_data
    addi    x12, x12,228
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000100)

    # Testcase 124:  imm:0x74, result rd:x12(0x0000000000000200)
    la  x11, test_data
    addi    x11, x11,232
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000200)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")



    # Addresses for test data and results
    la x1, test_26_res

    # Testcase 125:  imm:0x78, result rd:x13(0x0000000004000000)
    la  x10, test_data
    addi    x10, x10,236
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000004000000)

    # Testcase 126:  imm:0x0, result rd:x14(0x0000000008000000)
    la  x9, test_data
    addi    x9, x9,240
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000008000000)

    # Testcase 127:  imm:0x40, result rd:x15(0x0000000000001000)
    la  x8, test_data
    addi    x8, x8,244
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000001000)

    # Testcase 128:  imm:0x20, result rd:x8(0x0000000000002000)
    la  x15, test_data
    addi    x15, x15,248
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000002000)

    # Testcase 129:  imm:0x10, result rd:x9(0x0000000040000000)
    la  x14, test_data
    addi    x14, x14,252
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000040000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")



    # Addresses for test data and results
    la x1, test_27_res

    # Testcase 130:  imm:0x8, result rd:x10(0xffffffff80000000)
    la  x13, test_data
    addi    x13, x13,256
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffff80000000)

    # Testcase 131:  imm:0x4, result rd:x11(0x0000000000000000)
    la  x12, test_data
    addi    x12, x12,260
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000000)

    # Testcase 132:  imm:0x7c, result rd:x12(0xfffffffffffffffe)
    la  x11, test_data
    addi    x11, x11,0
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffffffffe)

    # Testcase 133:  imm:0x3c, result rd:x13(0xfffffffffffffffd)
    la  x10, test_data
    addi    x10, x10,4
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffffffffd)

    # Testcase 134:  imm:0x5c, result rd:x14(0xfffffffffffffffb)
    la  x9, test_data
    addi    x9, x9,8
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffffffffb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")



    # Addresses for test data and results
    la x1, test_28_res

    # Testcase 135:  imm:0x6c, result rd:x15(0xfffffffffffffff7)
    la  x8, test_data
    addi    x8, x8,12
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffffffffff7)

    # Testcase 136:  imm:0x74, result rd:x8(0xffffffffffffffef)
    la  x15, test_data
    addi    x15, x15,16
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffffffef)

    # Testcase 137:  imm:0x78, result rd:x9(0xffffffffffffffdf)
    la  x14, test_data
    addi    x14, x14,20
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffffffffdf)

    # Testcase 138:  imm:0x0, result rd:x10(0xffffffffffffffbf)
    la  x13, test_data
    addi    x13, x13,24
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffffffffbf)

    # Testcase 139:  imm:0x40, result rd:x11(0xffffffffffffff7f)
    la  x12, test_data
    addi    x12, x12,28
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffffffffff7f)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")



    # Addresses for test data and results
    la x1, test_29_res

    # Testcase 140:  imm:0x20, result rd:x12(0xfffffffffffffeff)
    la  x11, test_data
    addi    x11, x11,32
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffffffeff)

    # Testcase 141:  imm:0x10, result rd:x13(0xfffffffffffffdff)
    la  x10, test_data
    addi    x10, x10,36
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffffffdff)

    # Testcase 142:  imm:0x8, result rd:x14(0xfffffffffffffeff)
    la  x9, test_data
    addi    x9, x9,40
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffffffeff)

    # Testcase 143:  imm:0x4, result rd:x15(0xfffffffffffff7ff)
    la  x8, test_data
    addi    x8, x8,44
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffffffff7ff)

    # Testcase 144:  imm:0x7c, result rd:x8(0xffffffffffffefff)
    la  x15, test_data
    addi    x15, x15,48
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffffefff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")



    # Addresses for test data and results
    la x1, test_30_res

    # Testcase 145:  imm:0x3c, result rd:x9(0xffffffffffffdfff)
    la  x14, test_data
    addi    x14, x14,52
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffffffdfff)

    # Testcase 146:  imm:0x5c, result rd:x10(0xffffffffffffefff)
    la  x13, test_data
    addi    x13, x13,56
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffffffefff)

    # Testcase 147:  imm:0x6c, result rd:x11(0xffffffffffff7fff)
    la  x12, test_data
    addi    x12, x12,60
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffffffff7fff)

    # Testcase 148:  imm:0x74, result rd:x12(0xfffffffffffeffff)
    la  x11, test_data
    addi    x11, x11,64
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffffeffff)

    # Testcase 149:  imm:0x78, result rd:x13(0xfffffffffffdffff)
    la  x10, test_data
    addi    x10, x10,68
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffffdffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")



    # Addresses for test data and results
    la x1, test_31_res

    # Testcase 150:  imm:0x0, result rd:x14(0xfffffffffffbffff)
    la  x9, test_data
    addi    x9, x9,72
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffffbffff)

    # Testcase 151:  imm:0x40, result rd:x15(0xfffffffffff7ffff)
    la  x8, test_data
    addi    x8, x8,76
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffffff7ffff)

    # Testcase 152:  imm:0x20, result rd:x8(0xffffffffffefffff)
    la  x15, test_data
    addi    x15, x15,80
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffefffff)

    # Testcase 153:  imm:0x10, result rd:x9(0xffffffffffdfffff)
    la  x14, test_data
    addi    x14, x14,84
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffffdfffff)

    # Testcase 154:  imm:0x8, result rd:x10(0xffffffffffbfffff)
    la  x13, test_data
    addi    x13, x13,88
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffffbfffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")



    # Addresses for test data and results
    la x1, test_32_res

    # Testcase 155:  imm:0x4, result rd:x11(0xffffffffff7fffff)
    la  x12, test_data
    addi    x12, x12,92
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffffff7fffff)

    # Testcase 156:  imm:0x7c, result rd:x12(0xfffffffffeffffff)
    la  x11, test_data
    addi    x11, x11,96
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffeffffff)

    # Testcase 157:  imm:0x3c, result rd:x13(0xfffffffffdffffff)
    la  x10, test_data
    addi    x10, x10,100
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffdffffff)

    # Testcase 158:  imm:0x5c, result rd:x14(0xfffffffffeffffff)
    la  x9, test_data
    addi    x9, x9,104
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffeffffff)

    # Testcase 159:  imm:0x6c, result rd:x15(0xfffffffff7ffffff)
    la  x8, test_data
    addi    x8, x8,108
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffff7ffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")



    # Addresses for test data and results
    la x1, test_33_res

    # Testcase 160:  imm:0x74, result rd:x8(0xffffffffefffffff)
    la  x15, test_data
    addi    x15, x15,112
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffefffffff)

    # Testcase 161:  imm:0x78, result rd:x9(0xffffffffdfffffff)
    la  x14, test_data
    addi    x14, x14,116
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffdfffffff)

    # Testcase 162:  imm:0x0, result rd:x10(0xffffffffefffffff)
    la  x13, test_data
    addi    x13, x13,120
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffefffffff)

    # Testcase 163:  imm:0x40, result rd:x11(0x000000007fffffff)
    la  x12, test_data
    addi    x12, x12,124
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x000000007fffffff)

    # Testcase 164:  imm:0x20, result rd:x12(0xffffffffffffffff)
    la  x11, test_data
    addi    x11, x11,128
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")



    # Addresses for test data and results
    la x1, test_34_res

    # Testcase 165:  imm:0x10, result rd:x13(0x0000000000000001)
    la  x10, test_data
    addi    x10, x10,132
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000001)

    # Testcase 166:  imm:0x8, result rd:x14(0x0000000000000002)
    la  x9, test_data
    addi    x9, x9,136
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000002)

    # Testcase 167:  imm:0x4, result rd:x15(0x0000000000000004)
    la  x8, test_data
    addi    x8, x8,140
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000004)

    # Testcase 168:  imm:0x7c, result rd:x8(0x0000000000000008)
    la  x15, test_data
    addi    x15, x15,144
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000008)

    # Testcase 169:  imm:0x3c, result rd:x9(0x0000000000000010)
    la  x14, test_data
    addi    x14, x14,148
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000010)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")



    # Addresses for test data and results
    la x1, test_35_res

    # Testcase 170:  imm:0x5c, result rd:x10(0x0000000000000020)
    la  x13, test_data
    addi    x13, x13,152
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000020)

    # Testcase 171:  imm:0x6c, result rd:x11(0x0000000000000040)
    la  x12, test_data
    addi    x12, x12,156
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000040)

    # Testcase 172:  imm:0x74, result rd:x12(0x0000000000000080)
    la  x11, test_data
    addi    x11, x11,160
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000080)

    # Testcase 173:  imm:0x78, result rd:x13(0x0000000000000100)
    la  x10, test_data
    addi    x10, x10,164
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000100)

    # Testcase 174:  imm:0x0, result rd:x14(0x0000000000000200)
    la  x9, test_data
    addi    x9, x9,168
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000200)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")



    # Addresses for test data and results
    la x1, test_36_res

    # Testcase 175:  imm:0x40, result rd:x15(0x0000000000000400)
    la  x8, test_data
    addi    x8, x8,172
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000400)

    # Testcase 176:  imm:0x20, result rd:x8(0x0000000000000800)
    la  x15, test_data
    addi    x15, x15,176
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000800)

    # Testcase 177:  imm:0x10, result rd:x9(0x0000000000001000)
    la  x14, test_data
    addi    x14, x14,180
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000001000)

    # Testcase 178:  imm:0x8, result rd:x10(0x0000000000002000)
    la  x13, test_data
    addi    x13, x13,184
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000002000)

    # Testcase 179:  imm:0x4, result rd:x11(0x0000000000004000)
    la  x12, test_data
    addi    x12, x12,188
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000004000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")



    # Addresses for test data and results
    la x1, test_37_res

    # Testcase 180:  imm:0x7c, result rd:x12(0x0000000000008000)
    la  x11, test_data
    addi    x11, x11,192
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000008000)

    # Testcase 181:  imm:0x3c, result rd:x13(0x0000000000000001)
    la  x10, test_data
    addi    x10, x10,196
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000001)

    # Testcase 182:  imm:0x5c, result rd:x14(0x0000000000000002)
    la  x9, test_data
    addi    x9, x9,200
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000002)

    # Testcase 183:  imm:0x6c, result rd:x15(0x0000000000040000)
    la  x8, test_data
    addi    x8, x8,204
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000040000)

    # Testcase 184:  imm:0x74, result rd:x8(0x0000000000080000)
    la  x15, test_data
    addi    x15, x15,208
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000080000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")



    # Addresses for test data and results
    la x1, test_38_res

    # Testcase 185:  imm:0x78, result rd:x9(0x0000000000000010)
    la  x14, test_data
    addi    x14, x14,212
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000010)

    # Testcase 186:  imm:0x0, result rd:x10(0x0000000000000020)
    la  x13, test_data
    addi    x13, x13,216
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000020)

    # Testcase 187:  imm:0x40, result rd:x11(0x0000000000400000)
    la  x12, test_data
    addi    x12, x12,220
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000400000)

    # Testcase 188:  imm:0x20, result rd:x12(0x0000000000800000)
    la  x11, test_data
    addi    x11, x11,224
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000800000)

    # Testcase 189:  imm:0x10, result rd:x13(0x0000000000000100)
    la  x10, test_data
    addi    x10, x10,228
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000100)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")



    # Addresses for test data and results
    la x1, test_39_res

    # Testcase 190:  imm:0x8, result rd:x14(0x0000000000000200)
    la  x9, test_data
    addi    x9, x9,232
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000200)

    # Testcase 191:  imm:0x4, result rd:x15(0x0000000004000000)
    la  x8, test_data
    addi    x8, x8,236
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000004000000)

    # Testcase 192:  imm:0x7c, result rd:x8(0x0000000008000000)
    la  x15, test_data
    addi    x15, x15,240
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000008000000)

    # Testcase 193:  imm:0x3c, result rd:x9(0x0000000000001000)
    la  x14, test_data
    addi    x14, x14,244
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000001000)

    # Testcase 194:  imm:0x5c, result rd:x10(0x0000000000002000)
    la  x13, test_data
    addi    x13, x13,248
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000002000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")



    # Addresses for test data and results
    la x1, test_40_res

    # Testcase 195:  imm:0x6c, result rd:x11(0x0000000040000000)
    la  x12, test_data
    addi    x12, x12,252
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000040000000)

    # Testcase 196:  imm:0x74, result rd:x12(0xffffffff80000000)
    la  x11, test_data
    addi    x11, x11,256
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffff80000000)

    # Testcase 197:  imm:0x78, result rd:x13(0x0000000000000000)
    la  x10, test_data
    addi    x10, x10,260
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000000)

    # Testcase 198:  imm:0x0, result rd:x14(0xfffffffffffffffe)
    la  x9, test_data
    addi    x9, x9,0
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffffffffe)

    # Testcase 199:  imm:0x40, result rd:x15(0xfffffffffffffffd)
    la  x8, test_data
    addi    x8, x8,4
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffffffffffd)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")



    # Addresses for test data and results
    la x1, test_41_res

    # Testcase 200:  imm:0x20, result rd:x8(0xfffffffffffffffb)
    la  x15, test_data
    addi    x15, x15,8
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffffffffb)

    # Testcase 201:  imm:0x10, result rd:x9(0xfffffffffffffff7)
    la  x14, test_data
    addi    x14, x14,12
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffffffff7)

    # Testcase 202:  imm:0x8, result rd:x10(0xffffffffffffffef)
    la  x13, test_data
    addi    x13, x13,16
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffffffffef)

    # Testcase 203:  imm:0x4, result rd:x11(0xffffffffffffffdf)
    la  x12, test_data
    addi    x12, x12,20
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffffffffffdf)

    # Testcase 204:  imm:0x7c, result rd:x12(0xffffffffffffffbf)
    la  x11, test_data
    addi    x11, x11,24
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffffffbf)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")



    # Addresses for test data and results
    la x1, test_42_res

    # Testcase 205:  imm:0x3c, result rd:x13(0xffffffffffffff7f)
    la  x10, test_data
    addi    x10, x10,28
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffffffff7f)

    # Testcase 206:  imm:0x5c, result rd:x14(0xfffffffffffffeff)
    la  x9, test_data
    addi    x9, x9,32
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffffffeff)

    # Testcase 207:  imm:0x6c, result rd:x15(0xfffffffffffffdff)
    la  x8, test_data
    addi    x8, x8,36
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffffffffdff)

    # Testcase 208:  imm:0x74, result rd:x8(0xfffffffffffffeff)
    la  x15, test_data
    addi    x15, x15,40
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffffffeff)

    # Testcase 209:  imm:0x78, result rd:x9(0xfffffffffffff7ff)
    la  x14, test_data
    addi    x14, x14,44
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffffff7ff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")



    # Addresses for test data and results
    la x1, test_43_res

    # Testcase 210:  imm:0x0, result rd:x10(0xffffffffffffefff)
    la  x13, test_data
    addi    x13, x13,48
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffffffefff)

    # Testcase 211:  imm:0x40, result rd:x11(0xffffffffffffdfff)
    la  x12, test_data
    addi    x12, x12,52
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffffffffdfff)

    # Testcase 212:  imm:0x20, result rd:x12(0xffffffffffffefff)
    la  x11, test_data
    addi    x11, x11,56
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffffefff)

    # Testcase 213:  imm:0x10, result rd:x13(0xffffffffffff7fff)
    la  x10, test_data
    addi    x10, x10,60
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffffff7fff)

    # Testcase 214:  imm:0x8, result rd:x14(0xfffffffffffeffff)
    la  x9, test_data
    addi    x9, x9,64
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffffeffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")



    # Addresses for test data and results
    la x1, test_44_res

    # Testcase 215:  imm:0x4, result rd:x15(0xfffffffffffdffff)
    la  x8, test_data
    addi    x8, x8,68
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffffffdffff)

    # Testcase 216:  imm:0x7c, result rd:x8(0xfffffffffffbffff)
    la  x15, test_data
    addi    x15, x15,72
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffffbffff)

    # Testcase 217:  imm:0x3c, result rd:x9(0xfffffffffff7ffff)
    la  x14, test_data
    addi    x14, x14,76
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffff7ffff)

    # Testcase 218:  imm:0x5c, result rd:x10(0xffffffffffefffff)
    la  x13, test_data
    addi    x13, x13,80
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffffefffff)

    # Testcase 219:  imm:0x6c, result rd:x11(0xffffffffffdfffff)
    la  x12, test_data
    addi    x12, x12,84
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffffffdfffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")



    # Addresses for test data and results
    la x1, test_45_res

    # Testcase 220:  imm:0x74, result rd:x12(0xffffffffffbfffff)
    la  x11, test_data
    addi    x11, x11,88
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffbfffff)

    # Testcase 221:  imm:0x78, result rd:x13(0xffffffffff7fffff)
    la  x10, test_data
    addi    x10, x10,92
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffff7fffff)

    # Testcase 222:  imm:0x0, result rd:x14(0xfffffffffeffffff)
    la  x9, test_data
    addi    x9, x9,96
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffeffffff)

    # Testcase 223:  imm:0x40, result rd:x15(0xfffffffffdffffff)
    la  x8, test_data
    addi    x8, x8,100
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffffdffffff)

    # Testcase 224:  imm:0x20, result rd:x8(0xfffffffffeffffff)
    la  x15, test_data
    addi    x15, x15,104
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffeffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")



    # Addresses for test data and results
    la x1, test_46_res

    # Testcase 225:  imm:0x10, result rd:x9(0xfffffffff7ffffff)
    la  x14, test_data
    addi    x14, x14,108
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffff7ffffff)

    # Testcase 226:  imm:0x8, result rd:x10(0xffffffffefffffff)
    la  x13, test_data
    addi    x13, x13,112
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffefffffff)

    # Testcase 227:  imm:0x4, result rd:x11(0xffffffffdfffffff)
    la  x12, test_data
    addi    x12, x12,116
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffffdfffffff)

    # Testcase 228:  imm:0x7c, result rd:x12(0xffffffffefffffff)
    la  x11, test_data
    addi    x11, x11,120
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffefffffff)

    # Testcase 229:  imm:0x3c, result rd:x13(0x000000007fffffff)
    la  x10, test_data
    addi    x10, x10,124
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x000000007fffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")



    # Addresses for test data and results
    la x1, test_47_res

    # Testcase 230:  imm:0x5c, result rd:x14(0xffffffffffffffff)
    la  x9, test_data
    addi    x9, x9,128
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffffffffff)

    # Testcase 231:  imm:0x6c, result rd:x15(0x0000000000000001)
    la  x8, test_data
    addi    x8, x8,132
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000001)

    # Testcase 232:  imm:0x74, result rd:x8(0x0000000000000002)
    la  x15, test_data
    addi    x15, x15,136
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000002)

    # Testcase 233:  imm:0x78, result rd:x9(0x0000000000000004)
    la  x14, test_data
    addi    x14, x14,140
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000004)

    # Testcase 234:  imm:0x0, result rd:x10(0x0000000000000008)
    la  x13, test_data
    addi    x13, x13,144
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000008)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")



    # Addresses for test data and results
    la x1, test_48_res

    # Testcase 235:  imm:0x40, result rd:x11(0x0000000000000010)
    la  x12, test_data
    addi    x12, x12,148
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000010)

    # Testcase 236:  imm:0x20, result rd:x12(0x0000000000000020)
    la  x11, test_data
    addi    x11, x11,152
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000020)

    # Testcase 237:  imm:0x10, result rd:x13(0x0000000000000040)
    la  x10, test_data
    addi    x10, x10,156
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000040)

    # Testcase 238:  imm:0x8, result rd:x14(0x0000000000000080)
    la  x9, test_data
    addi    x9, x9,160
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000080)

    # Testcase 239:  imm:0x4, result rd:x15(0x0000000000000100)
    la  x8, test_data
    addi    x8, x8,164
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000100)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")



    # Addresses for test data and results
    la x1, test_49_res

    # Testcase 240:  imm:0x7c, result rd:x8(0x0000000000000200)
    la  x15, test_data
    addi    x15, x15,168
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000200)

    # Testcase 241:  imm:0x3c, result rd:x9(0x0000000000000400)
    la  x14, test_data
    addi    x14, x14,172
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000400)

    # Testcase 242:  imm:0x5c, result rd:x10(0x0000000000000800)
    la  x13, test_data
    addi    x13, x13,176
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000800)

    # Testcase 243:  imm:0x6c, result rd:x11(0x0000000000001000)
    la  x12, test_data
    addi    x12, x12,180
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000001000)

    # Testcase 244:  imm:0x74, result rd:x12(0x0000000000002000)
    la  x11, test_data
    addi    x11, x11,184
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000002000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")



    # Addresses for test data and results
    la x1, test_50_res

    # Testcase 245:  imm:0x78, result rd:x13(0x0000000000004000)
    la  x10, test_data
    addi    x10, x10,188
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000004000)

    # Testcase 246:  imm:0x0, result rd:x14(0x0000000000008000)
    la  x9, test_data
    addi    x9, x9,192
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000008000)

    # Testcase 247:  imm:0x40, result rd:x15(0x0000000000000001)
    la  x8, test_data
    addi    x8, x8,196
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000001)

    # Testcase 248:  imm:0x20, result rd:x8(0x0000000000000002)
    la  x15, test_data
    addi    x15, x15,200
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000002)

    # Testcase 249:  imm:0x10, result rd:x9(0x0000000000040000)
    la  x14, test_data
    addi    x14, x14,204
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000040000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")



    # Addresses for test data and results
    la x1, test_51_res

    # Testcase 250:  imm:0x8, result rd:x10(0x0000000000080000)
    la  x13, test_data
    addi    x13, x13,208
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000080000)

    # Testcase 251:  imm:0x4, result rd:x11(0x0000000000000010)
    la  x12, test_data
    addi    x12, x12,212
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000010)

    # Testcase 252:  imm:0x7c, result rd:x12(0x0000000000000020)
    la  x11, test_data
    addi    x11, x11,216
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000020)

    # Testcase 253:  imm:0x3c, result rd:x13(0x0000000000400000)
    la  x10, test_data
    addi    x10, x10,220
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000400000)

    # Testcase 254:  imm:0x5c, result rd:x14(0x0000000000800000)
    la  x9, test_data
    addi    x9, x9,224
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000800000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")



    # Addresses for test data and results
    la x1, test_52_res

    # Testcase 255:  imm:0x6c, result rd:x15(0x0000000000000100)
    la  x8, test_data
    addi    x8, x8,228
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000100)

    # Testcase 256:  imm:0x74, result rd:x8(0x0000000000000200)
    la  x15, test_data
    addi    x15, x15,232
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000200)

    # Testcase 257:  imm:0x78, result rd:x9(0x0000000004000000)
    la  x14, test_data
    addi    x14, x14,236
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000004000000)

    # Testcase 258:  imm:0x0, result rd:x10(0x0000000008000000)
    la  x13, test_data
    addi    x13, x13,240
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000008000000)

    # Testcase 259:  imm:0x40, result rd:x11(0x0000000000001000)
    la  x12, test_data
    addi    x12, x12,244
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000001000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")



    # Addresses for test data and results
    la x1, test_53_res

    # Testcase 260:  imm:0x20, result rd:x12(0x0000000000002000)
    la  x11, test_data
    addi    x11, x11,248
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000002000)

    # Testcase 261:  imm:0x10, result rd:x13(0x0000000040000000)
    la  x10, test_data
    addi    x10, x10,252
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000040000000)

    # Testcase 262:  imm:0x8, result rd:x14(0xffffffff80000000)
    la  x9, test_data
    addi    x9, x9,256
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffff80000000)

    # Testcase 263:  imm:0x4, result rd:x15(0x0000000000000000)
    la  x8, test_data
    addi    x8, x8,260
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000000)



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

