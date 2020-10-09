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

RV_COMPLIANCE_RV32M

RV_COMPLIANCE_CODE_BEGIN


	RVTEST_IO_INIT
	RVTEST_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
	RVTEST_IO_WRITE_STR(x31, "Test Begin\n")

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test group 1\n")



    # Addresses for test data and results
    la x1, test_1_res

    # Testcase 0:  imm:0x7c, result rd:x8(0xfffffffe)
    la  x15, test_data
    addi    x15, x15,0
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffe)

    # Testcase 1:  imm:0x3c, result rd:x9(0xfffffffd)
    la  x14, test_data
    addi    x14, x14,4
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffd)

    # Testcase 2:  imm:0x5c, result rd:x10(0xfffffffb)
    la  x13, test_data
    addi    x13, x13,8
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffb)

    # Testcase 3:  imm:0x6c, result rd:x11(0xfffffff7)
    la  x12, test_data
    addi    x12, x12,12
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffff7)

    # Testcase 4:  imm:0x74, result rd:x12(0xffffffef)
    la  x11, test_data
    addi    x11, x11,16
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")



    # Addresses for test data and results
    la x1, test_2_res

    # Testcase 5:  imm:0x78, result rd:x13(0xffffffdf)
    la  x10, test_data
    addi    x10, x10,20
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffdf)

    # Testcase 6:  imm:0x0, result rd:x14(0xffffffbf)
    la  x9, test_data
    addi    x9, x9,24
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffbf)

    # Testcase 7:  imm:0x40, result rd:x15(0xffffff7f)
    la  x8, test_data
    addi    x8, x8,28
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffff7f)

    # Testcase 8:  imm:0x20, result rd:x8(0xfffffeff)
    la  x15, test_data
    addi    x15, x15,32
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffeff)

    # Testcase 9:  imm:0x10, result rd:x9(0xfffffdff)
    la  x14, test_data
    addi    x14, x14,36
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffdff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")



    # Addresses for test data and results
    la x1, test_3_res

    # Testcase 10:  imm:0x8, result rd:x10(0xfffffeff)
    la  x13, test_data
    addi    x13, x13,40
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffeff)

    # Testcase 11:  imm:0x4, result rd:x11(0xfffff7ff)
    la  x12, test_data
    addi    x12, x12,44
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffff7ff)

    # Testcase 12:  imm:0x7c, result rd:x12(0xffffefff)
    la  x11, test_data
    addi    x11, x11,48
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffefff)

    # Testcase 13:  imm:0x3c, result rd:x13(0xffffdfff)
    la  x10, test_data
    addi    x10, x10,52
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffdfff)

    # Testcase 14:  imm:0x5c, result rd:x14(0xffffefff)
    la  x9, test_data
    addi    x9, x9,56
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffefff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")



    # Addresses for test data and results
    la x1, test_4_res

    # Testcase 15:  imm:0x6c, result rd:x15(0xffff7fff)
    la  x8, test_data
    addi    x8, x8,60
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffff7fff)

    # Testcase 16:  imm:0x74, result rd:x8(0xfffeffff)
    la  x15, test_data
    addi    x15, x15,64
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffeffff)

    # Testcase 17:  imm:0x78, result rd:x9(0xfffdffff)
    la  x14, test_data
    addi    x14, x14,68
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffdffff)

    # Testcase 18:  imm:0x0, result rd:x10(0xfffbffff)
    la  x13, test_data
    addi    x13, x13,72
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffbffff)

    # Testcase 19:  imm:0x40, result rd:x11(0xfff7ffff)
    la  x12, test_data
    addi    x12, x12,76
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfff7ffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")



    # Addresses for test data and results
    la x1, test_5_res

    # Testcase 20:  imm:0x20, result rd:x12(0xffefffff)
    la  x11, test_data
    addi    x11, x11,80
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffefffff)

    # Testcase 21:  imm:0x10, result rd:x13(0xffdfffff)
    la  x10, test_data
    addi    x10, x10,84
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffdfffff)

    # Testcase 22:  imm:0x8, result rd:x14(0xffbfffff)
    la  x9, test_data
    addi    x9, x9,88
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffbfffff)

    # Testcase 23:  imm:0x4, result rd:x15(0xff7fffff)
    la  x8, test_data
    addi    x8, x8,92
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xff7fffff)

    # Testcase 24:  imm:0x7c, result rd:x8(0xfeffffff)
    la  x15, test_data
    addi    x15, x15,96
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfeffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")



    # Addresses for test data and results
    la x1, test_6_res

    # Testcase 25:  imm:0x3c, result rd:x9(0xfdffffff)
    la  x14, test_data
    addi    x14, x14,100
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfdffffff)

    # Testcase 26:  imm:0x5c, result rd:x10(0xfeffffff)
    la  x13, test_data
    addi    x13, x13,104
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfeffffff)

    # Testcase 27:  imm:0x6c, result rd:x11(0xf7ffffff)
    la  x12, test_data
    addi    x12, x12,108
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xf7ffffff)

    # Testcase 28:  imm:0x74, result rd:x12(0xefffffff)
    la  x11, test_data
    addi    x11, x11,112
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xefffffff)

    # Testcase 29:  imm:0x78, result rd:x13(0xdfffffff)
    la  x10, test_data
    addi    x10, x10,116
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xdfffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")



    # Addresses for test data and results
    la x1, test_7_res

    # Testcase 30:  imm:0x0, result rd:x14(0xefffffff)
    la  x9, test_data
    addi    x9, x9,120
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xefffffff)

    # Testcase 31:  imm:0x40, result rd:x15(0x7fffffff)
    la  x8, test_data
    addi    x8, x8,124
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x7fffffff)

    # Testcase 32:  imm:0x20, result rd:x8(0xffffffff)
    la  x15, test_data
    addi    x15, x15,128
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffff)

    # Testcase 33:  imm:0x10, result rd:x9(0x00000001)
    la  x14, test_data
    addi    x14, x14,132
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000001)

    # Testcase 34:  imm:0x8, result rd:x10(0x00000002)
    la  x13, test_data
    addi    x13, x13,136
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00000002)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")



    # Addresses for test data and results
    la x1, test_8_res

    # Testcase 35:  imm:0x4, result rd:x11(0x00000004)
    la  x12, test_data
    addi    x12, x12,140
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00000004)

    # Testcase 36:  imm:0x7c, result rd:x12(0x00000008)
    la  x11, test_data
    addi    x11, x11,144
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00000008)

    # Testcase 37:  imm:0x3c, result rd:x13(0x00000010)
    la  x10, test_data
    addi    x10, x10,148
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x00000010)

    # Testcase 38:  imm:0x5c, result rd:x14(0x00000020)
    la  x9, test_data
    addi    x9, x9,152
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000020)

    # Testcase 39:  imm:0x6c, result rd:x15(0x00000040)
    la  x8, test_data
    addi    x8, x8,156
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x00000040)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")



    # Addresses for test data and results
    la x1, test_9_res

    # Testcase 40:  imm:0x74, result rd:x8(0x00000080)
    la  x15, test_data
    addi    x15, x15,160
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00000080)

    # Testcase 41:  imm:0x78, result rd:x9(0x00000100)
    la  x14, test_data
    addi    x14, x14,164
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000100)

    # Testcase 42:  imm:0x0, result rd:x10(0x00000200)
    la  x13, test_data
    addi    x13, x13,168
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00000200)

    # Testcase 43:  imm:0x40, result rd:x11(0x00000400)
    la  x12, test_data
    addi    x12, x12,172
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00000400)

    # Testcase 44:  imm:0x20, result rd:x12(0x00000800)
    la  x11, test_data
    addi    x11, x11,176
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00000800)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")



    # Addresses for test data and results
    la x1, test_10_res

    # Testcase 45:  imm:0x10, result rd:x13(0x00001000)
    la  x10, test_data
    addi    x10, x10,180
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x00001000)

    # Testcase 46:  imm:0x8, result rd:x14(0x00002000)
    la  x9, test_data
    addi    x9, x9,184
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00002000)

    # Testcase 47:  imm:0x4, result rd:x15(0x00004000)
    la  x8, test_data
    addi    x8, x8,188
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x00004000)

    # Testcase 48:  imm:0x7c, result rd:x8(0x00008000)
    la  x15, test_data
    addi    x15, x15,192
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00008000)

    # Testcase 49:  imm:0x3c, result rd:x9(0x00000001)
    la  x14, test_data
    addi    x14, x14,196
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000001)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")



    # Addresses for test data and results
    la x1, test_11_res

    # Testcase 50:  imm:0x5c, result rd:x10(0x00000002)
    la  x13, test_data
    addi    x13, x13,200
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00000002)

    # Testcase 51:  imm:0x6c, result rd:x11(0x00040000)
    la  x12, test_data
    addi    x12, x12,204
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00040000)

    # Testcase 52:  imm:0x74, result rd:x12(0x00080000)
    la  x11, test_data
    addi    x11, x11,208
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00080000)

    # Testcase 53:  imm:0x78, result rd:x13(0x00000010)
    la  x10, test_data
    addi    x10, x10,212
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x00000010)

    # Testcase 54:  imm:0x0, result rd:x14(0x00000020)
    la  x9, test_data
    addi    x9, x9,216
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000020)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")



    # Addresses for test data and results
    la x1, test_12_res

    # Testcase 55:  imm:0x40, result rd:x15(0x00400000)
    la  x8, test_data
    addi    x8, x8,220
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x00400000)

    # Testcase 56:  imm:0x20, result rd:x8(0x00800000)
    la  x15, test_data
    addi    x15, x15,224
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00800000)

    # Testcase 57:  imm:0x10, result rd:x9(0x00000100)
    la  x14, test_data
    addi    x14, x14,228
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000100)

    # Testcase 58:  imm:0x8, result rd:x10(0x00000200)
    la  x13, test_data
    addi    x13, x13,232
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00000200)

    # Testcase 59:  imm:0x4, result rd:x11(0x04000000)
    la  x12, test_data
    addi    x12, x12,236
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x04000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")



    # Addresses for test data and results
    la x1, test_13_res

    # Testcase 60:  imm:0x7c, result rd:x12(0x08000000)
    la  x11, test_data
    addi    x11, x11,240
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x08000000)

    # Testcase 61:  imm:0x3c, result rd:x13(0x00001000)
    la  x10, test_data
    addi    x10, x10,244
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x00001000)

    # Testcase 62:  imm:0x5c, result rd:x14(0x00002000)
    la  x9, test_data
    addi    x9, x9,248
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00002000)

    # Testcase 63:  imm:0x6c, result rd:x15(0x40000000)
    la  x8, test_data
    addi    x8, x8,252
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x40000000)

    # Testcase 64:  imm:0x74, result rd:x8(0x80000000)
    la  x15, test_data
    addi    x15, x15,256
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x80000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")



    # Addresses for test data and results
    la x1, test_14_res

    # Testcase 65:  imm:0x78, result rd:x9(0x00000000)
    la  x14, test_data
    addi    x14, x14,260
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000000)

    # Testcase 66:  imm:0x0, result rd:x10(0xfffffffe)
    la  x13, test_data
    addi    x13, x13,0
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffe)

    # Testcase 67:  imm:0x40, result rd:x11(0xfffffffd)
    la  x12, test_data
    addi    x12, x12,4
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffd)

    # Testcase 68:  imm:0x20, result rd:x12(0xfffffffb)
    la  x11, test_data
    addi    x11, x11,8
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffb)

    # Testcase 69:  imm:0x10, result rd:x13(0xfffffff7)
    la  x10, test_data
    addi    x10, x10,12
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffff7)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")



    # Addresses for test data and results
    la x1, test_15_res

    # Testcase 70:  imm:0x8, result rd:x14(0xffffffef)
    la  x9, test_data
    addi    x9, x9,16
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffef)

    # Testcase 71:  imm:0x4, result rd:x15(0xffffffdf)
    la  x8, test_data
    addi    x8, x8,20
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffdf)

    # Testcase 72:  imm:0x7c, result rd:x8(0xffffffbf)
    la  x15, test_data
    addi    x15, x15,24
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffbf)

    # Testcase 73:  imm:0x3c, result rd:x9(0xffffff7f)
    la  x14, test_data
    addi    x14, x14,28
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffff7f)

    # Testcase 74:  imm:0x5c, result rd:x10(0xfffffeff)
    la  x13, test_data
    addi    x13, x13,32
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffeff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")



    # Addresses for test data and results
    la x1, test_16_res

    # Testcase 75:  imm:0x6c, result rd:x11(0xfffffdff)
    la  x12, test_data
    addi    x12, x12,36
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffdff)

    # Testcase 76:  imm:0x74, result rd:x12(0xfffffeff)
    la  x11, test_data
    addi    x11, x11,40
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffeff)

    # Testcase 77:  imm:0x78, result rd:x13(0xfffff7ff)
    la  x10, test_data
    addi    x10, x10,44
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffff7ff)

    # Testcase 78:  imm:0x0, result rd:x14(0xffffefff)
    la  x9, test_data
    addi    x9, x9,48
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffefff)

    # Testcase 79:  imm:0x40, result rd:x15(0xffffdfff)
    la  x8, test_data
    addi    x8, x8,52
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffdfff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")



    # Addresses for test data and results
    la x1, test_17_res

    # Testcase 80:  imm:0x20, result rd:x8(0xffffefff)
    la  x15, test_data
    addi    x15, x15,56
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffefff)

    # Testcase 81:  imm:0x10, result rd:x9(0xffff7fff)
    la  x14, test_data
    addi    x14, x14,60
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffff7fff)

    # Testcase 82:  imm:0x8, result rd:x10(0xfffeffff)
    la  x13, test_data
    addi    x13, x13,64
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffeffff)

    # Testcase 83:  imm:0x4, result rd:x11(0xfffdffff)
    la  x12, test_data
    addi    x12, x12,68
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffdffff)

    # Testcase 84:  imm:0x7c, result rd:x12(0xfffbffff)
    la  x11, test_data
    addi    x11, x11,72
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffbffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")



    # Addresses for test data and results
    la x1, test_18_res

    # Testcase 85:  imm:0x3c, result rd:x13(0xfff7ffff)
    la  x10, test_data
    addi    x10, x10,76
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfff7ffff)

    # Testcase 86:  imm:0x5c, result rd:x14(0xffefffff)
    la  x9, test_data
    addi    x9, x9,80
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffefffff)

    # Testcase 87:  imm:0x6c, result rd:x15(0xffdfffff)
    la  x8, test_data
    addi    x8, x8,84
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffdfffff)

    # Testcase 88:  imm:0x74, result rd:x8(0xffbfffff)
    la  x15, test_data
    addi    x15, x15,88
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffbfffff)

    # Testcase 89:  imm:0x78, result rd:x9(0xff7fffff)
    la  x14, test_data
    addi    x14, x14,92
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xff7fffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")



    # Addresses for test data and results
    la x1, test_19_res

    # Testcase 90:  imm:0x0, result rd:x10(0xfeffffff)
    la  x13, test_data
    addi    x13, x13,96
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfeffffff)

    # Testcase 91:  imm:0x40, result rd:x11(0xfdffffff)
    la  x12, test_data
    addi    x12, x12,100
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfdffffff)

    # Testcase 92:  imm:0x20, result rd:x12(0xfeffffff)
    la  x11, test_data
    addi    x11, x11,104
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfeffffff)

    # Testcase 93:  imm:0x10, result rd:x13(0xf7ffffff)
    la  x10, test_data
    addi    x10, x10,108
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xf7ffffff)

    # Testcase 94:  imm:0x8, result rd:x14(0xefffffff)
    la  x9, test_data
    addi    x9, x9,112
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xefffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")



    # Addresses for test data and results
    la x1, test_20_res

    # Testcase 95:  imm:0x4, result rd:x15(0xdfffffff)
    la  x8, test_data
    addi    x8, x8,116
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xdfffffff)

    # Testcase 96:  imm:0x7c, result rd:x8(0xefffffff)
    la  x15, test_data
    addi    x15, x15,120
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xefffffff)

    # Testcase 97:  imm:0x3c, result rd:x9(0x7fffffff)
    la  x14, test_data
    addi    x14, x14,124
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x7fffffff)

    # Testcase 98:  imm:0x5c, result rd:x10(0xffffffff)
    la  x13, test_data
    addi    x13, x13,128
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffff)

    # Testcase 99:  imm:0x6c, result rd:x11(0x00000001)
    la  x12, test_data
    addi    x12, x12,132
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00000001)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")



    # Addresses for test data and results
    la x1, test_21_res

    # Testcase 100:  imm:0x74, result rd:x12(0x00000002)
    la  x11, test_data
    addi    x11, x11,136
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00000002)

    # Testcase 101:  imm:0x78, result rd:x13(0x00000004)
    la  x10, test_data
    addi    x10, x10,140
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sw x13, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x00000004)

    # Testcase 102:  imm:0x0, result rd:x14(0x00000008)
    la  x9, test_data
    addi    x9, x9,144
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sw x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000008)

    # Testcase 103:  imm:0x40, result rd:x15(0x00000010)
    la  x8, test_data
    addi    x8, x8,148
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sw x15, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x00000010)

    # Testcase 104:  imm:0x20, result rd:x8(0x00000020)
    la  x15, test_data
    addi    x15, x15,152
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00000020)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")



    # Addresses for test data and results
    la x1, test_22_res

    # Testcase 105:  imm:0x10, result rd:x9(0x00000040)
    la  x14, test_data
    addi    x14, x14,156
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00000040)

    # Testcase 106:  imm:0x8, result rd:x10(0x00000080)
    la  x13, test_data
    addi    x13, x13,160
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00000080)

    # Testcase 107:  imm:0x4, result rd:x11(0x00000100)
    la  x12, test_data
    addi    x12, x12,164
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00000100)

    # Testcase 108:  imm:0x7c, result rd:x12(0x00000200)
    la  x11, test_data
    addi    x11, x11,168
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00000200)

    # Testcase 109:  imm:0x3c, result rd:x13(0x00000400)
    la  x10, test_data
    addi    x10, x10,172
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x00000400)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")



    # Addresses for test data and results
    la x1, test_23_res

    # Testcase 110:  imm:0x5c, result rd:x14(0x00000800)
    la  x9, test_data
    addi    x9, x9,176
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sw x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00000800)

    # Testcase 111:  imm:0x6c, result rd:x15(0x00001000)
    la  x8, test_data
    addi    x8, x8,180
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sw x15, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x00001000)

    # Testcase 112:  imm:0x74, result rd:x8(0x00002000)
    la  x15, test_data
    addi    x15, x15,184
    li     x2, MASK_XLEN(-116)
    add    x15, x15, x2
    c.lw x8, 116(x15)
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00002000)

    # Testcase 113:  imm:0x78, result rd:x9(0x00004000)
    la  x14, test_data
    addi    x14, x14,188
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.lw x9, 120(x14)
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00004000)

    # Testcase 114:  imm:0x0, result rd:x10(0x00008000)
    la  x13, test_data
    addi    x13, x13,192
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.lw x10, 0(x13)
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00008000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")



    # Addresses for test data and results
    la x1, test_24_res

    # Testcase 115:  imm:0x40, result rd:x11(0x00000001)
    la  x12, test_data
    addi    x12, x12,196
    li     x2, MASK_XLEN(-64)
    add    x12, x12, x2
    c.lw x11, 64(x12)
    sw x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00000001)

    # Testcase 116:  imm:0x20, result rd:x12(0x00000002)
    la  x11, test_data
    addi    x11, x11,200
    li     x2, MASK_XLEN(-32)
    add    x11, x11, x2
    c.lw x12, 32(x11)
    sw x12, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00000002)

    # Testcase 117:  imm:0x10, result rd:x13(0x00040000)
    la  x10, test_data
    addi    x10, x10,204
    li     x2, MASK_XLEN(-16)
    add    x10, x10, x2
    c.lw x13, 16(x10)
    sw x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x00040000)

    # Testcase 118:  imm:0x8, result rd:x14(0x00080000)
    la  x9, test_data
    addi    x9, x9,208
    li     x2, MASK_XLEN(-8)
    add    x9, x9, x2
    c.lw x14, 8(x9)
    sw x14, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x00080000)

    # Testcase 119:  imm:0x4, result rd:x15(0x00000010)
    la  x8, test_data
    addi    x8, x8,212
    li     x2, MASK_XLEN(-4)
    add    x8, x8, x2
    c.lw x15, 4(x8)
    sw x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x00000010)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")



    # Addresses for test data and results
    la x1, test_25_res

    # Testcase 120:  imm:0x7c, result rd:x8(0x00000020)
    la  x15, test_data
    addi    x15, x15,216
    li     x2, MASK_XLEN(-124)
    add    x15, x15, x2
    c.lw x8, 124(x15)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00000020)

    # Testcase 121:  imm:0x3c, result rd:x9(0x00400000)
    la  x14, test_data
    addi    x14, x14,220
    li     x2, MASK_XLEN(-60)
    add    x14, x14, x2
    c.lw x9, 60(x14)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x00400000)

    # Testcase 122:  imm:0x5c, result rd:x10(0x00800000)
    la  x13, test_data
    addi    x13, x13,224
    li     x2, MASK_XLEN(-92)
    add    x13, x13, x2
    c.lw x10, 92(x13)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x00800000)

    # Testcase 123:  imm:0x6c, result rd:x11(0x00000100)
    la  x12, test_data
    addi    x12, x12,228
    li     x2, MASK_XLEN(-108)
    add    x12, x12, x2
    c.lw x11, 108(x12)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00000100)

    # Testcase 124:  imm:0x74, result rd:x12(0x00000200)
    la  x11, test_data
    addi    x11, x11,232
    li     x2, MASK_XLEN(-116)
    add    x11, x11, x2
    c.lw x12, 116(x11)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x00000200)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")



    # Addresses for test data and results
    la x1, test_26_res

    # Testcase 125:  imm:0x78, result rd:x13(0x04000000)
    la  x10, test_data
    addi    x10, x10,236
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.lw x13, 120(x10)
    sw x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x04000000)

    # Testcase 126:  imm:0x0, result rd:x14(0x08000000)
    la  x9, test_data
    addi    x9, x9,240
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.lw x14, 0(x9)
    sw x14, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x08000000)

    # Testcase 127:  imm:0x40, result rd:x15(0x00001000)
    la  x8, test_data
    addi    x8, x8,244
    li     x2, MASK_XLEN(-64)
    add    x8, x8, x2
    c.lw x15, 64(x8)
    sw x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x00001000)

    # Testcase 128:  imm:0x20, result rd:x8(0x00002000)
    la  x15, test_data
    addi    x15, x15,248
    li     x2, MASK_XLEN(-32)
    add    x15, x15, x2
    c.lw x8, 32(x15)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x00002000)

    # Testcase 129:  imm:0x10, result rd:x9(0x40000000)
    la  x14, test_data
    addi    x14, x14,252
    li     x2, MASK_XLEN(-16)
    add    x14, x14, x2
    c.lw x9, 16(x14)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x40000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")



    # Addresses for test data and results
    la x1, test_27_res

    # Testcase 130:  imm:0x8, result rd:x10(0x80000000)
    la  x13, test_data
    addi    x13, x13,256
    li     x2, MASK_XLEN(-8)
    add    x13, x13, x2
    c.lw x10, 8(x13)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x80000000)

    # Testcase 131:  imm:0x4, result rd:x11(0x00000000)
    la  x12, test_data
    addi    x12, x12,260
    li     x2, MASK_XLEN(-4)
    add    x12, x12, x2
    c.lw x11, 4(x12)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x00000000)

    # Testcase 132:  imm:0x7c, result rd:x12(0xfffffffe)
    la  x11, test_data
    addi    x11, x11,0
    li     x2, MASK_XLEN(-124)
    add    x11, x11, x2
    c.lw x12, 124(x11)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffe)

    # Testcase 133:  imm:0x3c, result rd:x13(0xfffffffd)
    la  x10, test_data
    addi    x10, x10,4
    li     x2, MASK_XLEN(-60)
    add    x10, x10, x2
    c.lw x13, 60(x10)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffd)

    # Testcase 134:  imm:0x5c, result rd:x14(0xfffffffb)
    la  x9, test_data
    addi    x9, x9,8
    li     x2, MASK_XLEN(-92)
    add    x9, x9, x2
    c.lw x14, 92(x9)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")



    # Addresses for test data and results
    la x1, test_28_res

    # Testcase 135:  imm:0x6c, result rd:x15(0xfffffff7)
    la  x8, test_data
    addi    x8, x8,12
    li     x2, MASK_XLEN(-108)
    add    x8, x8, x2
    c.lw x15, 108(x8)
    sw x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffff7)



	# ---------------------------------------------------------------------------------------------
	
	RVTEST_IO_WRITE_STR(x31, "Test End\n")

	# ---------------------------------------------------------------------------------------------

	RV_COMPLIANCE_HALT

RV_COMPLIANCE_CODE_END

# Input data section.
	.data

	.align 4
test_data:

	.word 0xfffffffe
	.word 0xfffffffd
	.word 0xfffffffb
	.word 0xfffffff7
	.word 0xffffffef
	.word 0xffffffdf
	.word 0xffffffbf
	.word 0xffffff7f
	.word 0xfffffeff
	.word 0xfffffdff
	.word 0xfffffeff
	.word 0xfffff7ff
	.word 0xffffefff
	.word 0xffffdfff
	.word 0xffffefff
	.word 0xffff7fff
	.word 0xfffeffff
	.word 0xfffdffff
	.word 0xfffbffff
	.word 0xfff7ffff
	.word 0xffefffff
	.word 0xffdfffff
	.word 0xffbfffff
	.word 0xff7fffff
	.word 0xfeffffff
	.word 0xfdffffff
	.word 0xfeffffff
	.word 0xf7ffffff
	.word 0xefffffff
	.word 0xdfffffff
	.word 0xefffffff
	.word 0x7fffffff
	.word 0xffffffff
	.word 0x00000001
	.word 0x00000002
	.word 0x00000004
	.word 0x00000008
	.word 0x00000010
	.word 0x00000020
	.word 0x00000040
	.word 0x00000080
	.word 0x00000100
	.word 0x00000200
	.word 0x00000400
	.word 0x00000800
	.word 0x00001000
	.word 0x00002000
	.word 0x00004000
	.word 0x00008000
	.word 0x00000001
	.word 0x00000002
	.word 0x00040000
	.word 0x00080000
	.word 0x00000010
	.word 0x00000020
	.word 0x00400000
	.word 0x00800000
	.word 0x00000100
	.word 0x00000200
	.word 0x04000000
	.word 0x08000000
	.word 0x00001000
	.word 0x00002000
	.word 0x40000000
	.word 0x80000000
	.word 0x00000000


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

