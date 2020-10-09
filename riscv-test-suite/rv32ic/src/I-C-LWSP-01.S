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

RV_COMPLIANCE_RV32M

RV_COMPLIANCE_CODE_BEGIN


	RVTEST_IO_INIT
	RVTEST_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
	RVTEST_IO_WRITE_STR(x31, "Test Begin\n")

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test group 1\n")



    # Addresses for test data and results
    la x6, test_1_res

    # Testcase 0:  imm:0x7c, result rd:x1(0xfffffffe)
    la  x2, test_data
    addi    x2, x2,0
    li     x7, MASK_XLEN(-124)
    add    x2, x2, x7
    c.lwsp x1, 124(x2)
    sw x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xfffffffe)

    # Testcase 1:  imm:0x3c, result rd:x2(0xfffffffd)
    la  x2, test_data
    addi    x2, x2,4
    li     x7, MASK_XLEN(-60)
    add    x2, x2, x7
    c.lwsp x2, 60(x2)
    sw x2, 4(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0xfffffffd)

    # Testcase 2:  imm:0x5c, result rd:x3(0xfffffffb)
    la  x2, test_data
    addi    x2, x2,8
    li     x7, MASK_XLEN(-92)
    add    x2, x2, x7
    c.lwsp x3, 92(x2)
    sw x3, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0xfffffffb)

    # Testcase 3:  imm:0x6c, result rd:x4(0xfffffff7)
    la  x2, test_data
    addi    x2, x2,12
    li     x7, MASK_XLEN(-108)
    add    x2, x2, x7
    c.lwsp x4, 108(x2)
    sw x4, 12(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0xfffffff7)

    # Testcase 4:  imm:0x74, result rd:x5(0xffffffef)
    la  x2, test_data
    addi    x2, x2,16
    li     x7, MASK_XLEN(-116)
    add    x2, x2, x7
    c.lwsp x5, 116(x2)
    sw x5, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0xffffffef)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")



    # Addresses for test data and results
    la x1, test_2_res

    # Testcase 5:  imm:0x78, result rd:x6(0xffffffdf)
    la  x2, test_data
    addi    x2, x2,20
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x6, 120(x2)
    sw x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0xffffffdf)

    # Testcase 6:  imm:0x0, result rd:x7(0xffffffbf)
    la  x2, test_data
    addi    x2, x2,24
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x7, 0(x2)
    sw x7, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0xffffffbf)

    # Testcase 7:  imm:0x40, result rd:x8(0xffffff7f)
    la  x2, test_data
    addi    x2, x2,28
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x8, 64(x2)
    sw x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0xffffff7f)

    # Testcase 8:  imm:0x20, result rd:x9(0xfffffeff)
    la  x2, test_data
    addi    x2, x2,32
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x9, 32(x2)
    sw x9, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0xfffffeff)

    # Testcase 9:  imm:0x10, result rd:x10(0xfffffdff)
    la  x2, test_data
    addi    x2, x2,36
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x10, 16(x2)
    sw x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xfffffdff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")



    # Addresses for test data and results
    la x7, test_3_res

    # Testcase 10:  imm:0x8, result rd:x11(0xfffffeff)
    la  x2, test_data
    addi    x2, x2,40
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    c.lwsp x11, 8(x2)
    sw x11, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x11, 0xfffffeff)

    # Testcase 11:  imm:0x4, result rd:x12(0xfffff7ff)
    la  x2, test_data
    addi    x2, x2,44
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    c.lwsp x12, 4(x2)
    sw x12, 4(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x12, 0xfffff7ff)

    # Testcase 12:  imm:0x7c, result rd:x13(0xffffefff)
    la  x2, test_data
    addi    x2, x2,48
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    c.lwsp x13, 124(x2)
    sw x13, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x13, 0xffffefff)

    # Testcase 13:  imm:0x3c, result rd:x14(0xffffdfff)
    la  x2, test_data
    addi    x2, x2,52
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    c.lwsp x14, 60(x2)
    sw x14, 12(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x14, 0xffffdfff)

    # Testcase 14:  imm:0x5c, result rd:x15(0xffffefff)
    la  x2, test_data
    addi    x2, x2,56
    li     x8, MASK_XLEN(-92)
    add    x2, x2, x8
    c.lwsp x15, 92(x2)
    sw x15, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xffffefff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")



    # Addresses for test data and results
    la x3, test_4_res

    # Testcase 15:  imm:0x6c, result rd:x16(0xffff7fff)
    la  x2, test_data
    addi    x2, x2,60
    li     x4, MASK_XLEN(-108)
    add    x2, x2, x4
    c.lwsp x16, 108(x2)
    sw x16, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffff7fff)

    # Testcase 16:  imm:0x74, result rd:x17(0xfffeffff)
    la  x2, test_data
    addi    x2, x2,64
    li     x4, MASK_XLEN(-116)
    add    x2, x2, x4
    c.lwsp x17, 116(x2)
    sw x17, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xfffeffff)

    # Testcase 17:  imm:0x78, result rd:x18(0xfffdffff)
    la  x2, test_data
    addi    x2, x2,68
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    c.lwsp x18, 120(x2)
    sw x18, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xfffdffff)

    # Testcase 18:  imm:0x0, result rd:x19(0xfffbffff)
    la  x2, test_data
    addi    x2, x2,72
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    c.lwsp x19, 0(x2)
    sw x19, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0xfffbffff)

    # Testcase 19:  imm:0x40, result rd:x20(0xfff7ffff)
    la  x2, test_data
    addi    x2, x2,76
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    c.lwsp x20, 64(x2)
    sw x20, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x20, 0xfff7ffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")



    # Addresses for test data and results
    la x1, test_5_res

    # Testcase 20:  imm:0x20, result rd:x21(0xffefffff)
    la  x2, test_data
    addi    x2, x2,80
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x21, 32(x2)
    sw x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0xffefffff)

    # Testcase 21:  imm:0x10, result rd:x22(0xffdfffff)
    la  x2, test_data
    addi    x2, x2,84
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x22, 16(x2)
    sw x22, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0xffdfffff)

    # Testcase 22:  imm:0x8, result rd:x23(0xffbfffff)
    la  x2, test_data
    addi    x2, x2,88
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x23, 8(x2)
    sw x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0xffbfffff)

    # Testcase 23:  imm:0x4, result rd:x24(0xff7fffff)
    la  x2, test_data
    addi    x2, x2,92
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x24, 4(x2)
    sw x24, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0xff7fffff)

    # Testcase 24:  imm:0x7c, result rd:x25(0xfeffffff)
    la  x2, test_data
    addi    x2, x2,96
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x25, 124(x2)
    sw x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0xfeffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")



    # Addresses for test data and results
    la x1, test_6_res

    # Testcase 25:  imm:0x3c, result rd:x26(0xfdffffff)
    la  x2, test_data
    addi    x2, x2,100
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x26, 60(x2)
    sw x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0xfdffffff)

    # Testcase 26:  imm:0x5c, result rd:x27(0xfeffffff)
    la  x2, test_data
    addi    x2, x2,104
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x27, 92(x2)
    sw x27, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0xfeffffff)

    # Testcase 27:  imm:0x6c, result rd:x28(0xf7ffffff)
    la  x2, test_data
    addi    x2, x2,108
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x28, 108(x2)
    sw x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0xf7ffffff)

    # Testcase 28:  imm:0x74, result rd:x29(0xefffffff)
    la  x2, test_data
    addi    x2, x2,112
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x29, 116(x2)
    sw x29, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0xefffffff)

    # Testcase 29:  imm:0x78, result rd:x30(0xdfffffff)
    la  x2, test_data
    addi    x2, x2,116
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x30, 120(x2)
    sw x30, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x30, 0xdfffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")



    # Addresses for test data and results
    la x5, test_7_res

    # Testcase 30:  imm:0x0, result rd:x31(0xefffffff)
    la  x2, test_data
    addi    x2, x2,120
    li     x6, MASK_XLEN(0)
    add    x2, x2, x6
    c.lwsp x31, 0(x2)
    sw x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0xefffffff)

    # Testcase 31:  imm:0x40, result rd:x1(0x7fffffff)
    la  x2, test_data
    addi    x2, x2,124
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    c.lwsp x1, 64(x2)
    sw x1, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0x7fffffff)

    # Testcase 32:  imm:0x20, result rd:x2(0xffffffff)
    la  x2, test_data
    addi    x2, x2,128
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    c.lwsp x2, 32(x2)
    sw x2, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xffffffff)

    # Testcase 33:  imm:0x10, result rd:x3(0x00000001)
    la  x2, test_data
    addi    x2, x2,132
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    c.lwsp x3, 16(x2)
    sw x3, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0x00000001)

    # Testcase 34:  imm:0x8, result rd:x4(0x00000002)
    la  x2, test_data
    addi    x2, x2,136
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    c.lwsp x4, 8(x2)
    sw x4, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0x00000002)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")



    # Addresses for test data and results
    la x1, test_8_res

    # Testcase 35:  imm:0x4, result rd:x5(0x00000004)
    la  x2, test_data
    addi    x2, x2,140
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x5, 4(x2)
    sw x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0x00000004)

    # Testcase 36:  imm:0x7c, result rd:x6(0x00000008)
    la  x2, test_data
    addi    x2, x2,144
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x6, 124(x2)
    sw x6, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0x00000008)

    # Testcase 37:  imm:0x3c, result rd:x7(0x00000010)
    la  x2, test_data
    addi    x2, x2,148
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x7, 60(x2)
    sw x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0x00000010)

    # Testcase 38:  imm:0x5c, result rd:x8(0x00000020)
    la  x2, test_data
    addi    x2, x2,152
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x8, 92(x2)
    sw x8, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x00000020)

    # Testcase 39:  imm:0x6c, result rd:x9(0x00000040)
    la  x2, test_data
    addi    x2, x2,156
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x9, 108(x2)
    sw x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0x00000040)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")



    # Addresses for test data and results
    la x1, test_9_res

    # Testcase 40:  imm:0x74, result rd:x10(0x00000080)
    la  x2, test_data
    addi    x2, x2,160
    li     x8, MASK_XLEN(-116)
    add    x2, x2, x8
    c.lwsp x10, 116(x2)
    sw x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0x00000080)

    # Testcase 41:  imm:0x78, result rd:x11(0x00000100)
    la  x2, test_data
    addi    x2, x2,164
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    c.lwsp x11, 120(x2)
    sw x11, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x11, 0x00000100)

    # Testcase 42:  imm:0x0, result rd:x12(0x00000200)
    la  x2, test_data
    addi    x2, x2,168
    li     x8, MASK_XLEN(0)
    add    x2, x2, x8
    c.lwsp x12, 0(x2)
    sw x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x12, 0x00000200)

    # Testcase 43:  imm:0x40, result rd:x13(0x00000400)
    la  x2, test_data
    addi    x2, x2,172
    li     x8, MASK_XLEN(-64)
    add    x2, x2, x8
    c.lwsp x13, 64(x2)
    sw x13, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x13, 0x00000400)

    # Testcase 44:  imm:0x20, result rd:x14(0x00000800)
    la  x2, test_data
    addi    x2, x2,176
    li     x8, MASK_XLEN(-32)
    add    x2, x2, x8
    c.lwsp x14, 32(x2)
    sw x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x14, 0x00000800)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")



    # Addresses for test data and results
    la x3, test_10_res

    # Testcase 45:  imm:0x10, result rd:x15(0x00001000)
    la  x2, test_data
    addi    x2, x2,180
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    c.lwsp x15, 16(x2)
    sw x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x00001000)

    # Testcase 46:  imm:0x8, result rd:x16(0x00002000)
    la  x2, test_data
    addi    x2, x2,184
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    c.lwsp x16, 8(x2)
    sw x16, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x00002000)

    # Testcase 47:  imm:0x4, result rd:x17(0x00004000)
    la  x2, test_data
    addi    x2, x2,188
    li     x4, MASK_XLEN(-4)
    add    x2, x2, x4
    c.lwsp x17, 4(x2)
    sw x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x00004000)

    # Testcase 48:  imm:0x7c, result rd:x18(0x00008000)
    la  x2, test_data
    addi    x2, x2,192
    li     x4, MASK_XLEN(-124)
    add    x2, x2, x4
    c.lwsp x18, 124(x2)
    sw x18, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x00008000)

    # Testcase 49:  imm:0x3c, result rd:x19(0x00000001)
    la  x2, test_data
    addi    x2, x2,196
    li     x4, MASK_XLEN(-60)
    add    x2, x2, x4
    c.lwsp x19, 60(x2)
    sw x19, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0x00000001)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")



    # Addresses for test data and results
    la x1, test_11_res

    # Testcase 50:  imm:0x5c, result rd:x20(0x00000002)
    la  x2, test_data
    addi    x2, x2,200
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x20, 92(x2)
    sw x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x00000002)

    # Testcase 51:  imm:0x6c, result rd:x21(0x00040000)
    la  x2, test_data
    addi    x2, x2,204
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x21, 108(x2)
    sw x21, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0x00040000)

    # Testcase 52:  imm:0x74, result rd:x22(0x00080000)
    la  x2, test_data
    addi    x2, x2,208
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x22, 116(x2)
    sw x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0x00080000)

    # Testcase 53:  imm:0x78, result rd:x23(0x00000010)
    la  x2, test_data
    addi    x2, x2,212
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x23, 120(x2)
    sw x23, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0x00000010)

    # Testcase 54:  imm:0x0, result rd:x24(0x00000020)
    la  x2, test_data
    addi    x2, x2,216
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x24, 0(x2)
    sw x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0x00000020)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")



    # Addresses for test data and results
    la x1, test_12_res

    # Testcase 55:  imm:0x40, result rd:x25(0x00400000)
    la  x2, test_data
    addi    x2, x2,220
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x25, 64(x2)
    sw x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0x00400000)

    # Testcase 56:  imm:0x20, result rd:x26(0x00800000)
    la  x2, test_data
    addi    x2, x2,224
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x26, 32(x2)
    sw x26, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0x00800000)

    # Testcase 57:  imm:0x10, result rd:x27(0x00000100)
    la  x2, test_data
    addi    x2, x2,228
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x27, 16(x2)
    sw x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0x00000100)

    # Testcase 58:  imm:0x8, result rd:x28(0x00000200)
    la  x2, test_data
    addi    x2, x2,232
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x28, 8(x2)
    sw x28, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0x00000200)

    # Testcase 59:  imm:0x4, result rd:x29(0x04000000)
    la  x2, test_data
    addi    x2, x2,236
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x29, 4(x2)
    sw x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0x04000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")



    # Addresses for test data and results
    la x4, test_13_res

    # Testcase 60:  imm:0x7c, result rd:x30(0x08000000)
    la  x2, test_data
    addi    x2, x2,240
    li     x5, MASK_XLEN(-124)
    add    x2, x2, x5
    c.lwsp x30, 124(x2)
    sw x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x08000000)

    # Testcase 61:  imm:0x3c, result rd:x31(0x00001000)
    la  x2, test_data
    addi    x2, x2,244
    li     x5, MASK_XLEN(-60)
    add    x2, x2, x5
    c.lwsp x31, 60(x2)
    sw x31, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x00001000)

    # Testcase 62:  imm:0x5c, result rd:x1(0x00002000)
    la  x2, test_data
    addi    x2, x2,248
    li     x5, MASK_XLEN(-92)
    add    x2, x2, x5
    c.lwsp x1, 92(x2)
    sw x1, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x00002000)

    # Testcase 63:  imm:0x6c, result rd:x2(0x40000000)
    la  x2, test_data
    addi    x2, x2,252
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    c.lwsp x2, 108(x2)
    sw x2, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x40000000)

    # Testcase 64:  imm:0x74, result rd:x3(0x80000000)
    la  x2, test_data
    addi    x2, x2,256
    li     x5, MASK_XLEN(-116)
    add    x2, x2, x5
    c.lwsp x3, 116(x2)
    sw x3, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x80000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")



    # Addresses for test data and results
    la x1, test_14_res

    # Testcase 65:  imm:0x78, result rd:x4(0x00000000)
    la  x2, test_data
    addi    x2, x2,260
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x4, 120(x2)
    sw x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x4, 0x00000000)

    # Testcase 66:  imm:0x0, result rd:x5(0xfffffffe)
    la  x2, test_data
    addi    x2, x2,0
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x5, 0(x2)
    sw x5, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x5, 0xfffffffe)

    # Testcase 67:  imm:0x40, result rd:x6(0xfffffffd)
    la  x2, test_data
    addi    x2, x2,4
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x6, 64(x2)
    sw x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x6, 0xfffffffd)

    # Testcase 68:  imm:0x20, result rd:x7(0xfffffffb)
    la  x2, test_data
    addi    x2, x2,8
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x7, 32(x2)
    sw x7, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x7, 0xfffffffb)

    # Testcase 69:  imm:0x10, result rd:x8(0xfffffff7)
    la  x2, test_data
    addi    x2, x2,12
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x8, 16(x2)
    sw x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x8, 0xfffffff7)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")



    # Addresses for test data and results
    la x1, test_15_res

    # Testcase 70:  imm:0x8, result rd:x9(0xffffffef)
    la  x2, test_data
    addi    x2, x2,16
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x9, 8(x2)
    sw x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x9, 0xffffffef)

    # Testcase 71:  imm:0x4, result rd:x10(0xffffffdf)
    la  x2, test_data
    addi    x2, x2,20
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x10, 4(x2)
    sw x10, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x10, 0xffffffdf)

    # Testcase 72:  imm:0x7c, result rd:x11(0xffffffbf)
    la  x2, test_data
    addi    x2, x2,24
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x11, 124(x2)
    sw x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x11, 0xffffffbf)

    # Testcase 73:  imm:0x3c, result rd:x12(0xffffff7f)
    la  x2, test_data
    addi    x2, x2,28
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x12, 60(x2)
    sw x12, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x12, 0xffffff7f)

    # Testcase 74:  imm:0x5c, result rd:x13(0xfffffeff)
    la  x2, test_data
    addi    x2, x2,32
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x13, 92(x2)
    sw x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x13, 0xfffffeff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")



    # Addresses for test data and results
    la x4, test_16_res

    # Testcase 75:  imm:0x6c, result rd:x14(0xfffffdff)
    la  x2, test_data
    addi    x2, x2,36
    li     x5, MASK_XLEN(-108)
    add    x2, x2, x5
    c.lwsp x14, 108(x2)
    sw x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0xfffffdff)

    # Testcase 76:  imm:0x74, result rd:x15(0xfffffeff)
    la  x2, test_data
    addi    x2, x2,40
    li     x5, MASK_XLEN(-116)
    add    x2, x2, x5
    c.lwsp x15, 116(x2)
    sw x15, 4(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0xfffffeff)

    # Testcase 77:  imm:0x78, result rd:x16(0xfffff7ff)
    la  x2, test_data
    addi    x2, x2,44
    li     x5, MASK_XLEN(-120)
    add    x2, x2, x5
    c.lwsp x16, 120(x2)
    sw x16, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0xfffff7ff)

    # Testcase 78:  imm:0x0, result rd:x17(0xffffefff)
    la  x2, test_data
    addi    x2, x2,48
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    c.lwsp x17, 0(x2)
    sw x17, 12(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0xffffefff)

    # Testcase 79:  imm:0x40, result rd:x18(0xffffdfff)
    la  x2, test_data
    addi    x2, x2,52
    li     x5, MASK_XLEN(-64)
    add    x2, x2, x5
    c.lwsp x18, 64(x2)
    sw x18, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x18, 0xffffdfff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")



    # Addresses for test data and results
    la x1, test_17_res

    # Testcase 80:  imm:0x20, result rd:x19(0xffffefff)
    la  x2, test_data
    addi    x2, x2,56
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x19, 32(x2)
    sw x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xffffefff)

    # Testcase 81:  imm:0x10, result rd:x20(0xffff7fff)
    la  x2, test_data
    addi    x2, x2,60
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x20, 16(x2)
    sw x20, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0xffff7fff)

    # Testcase 82:  imm:0x8, result rd:x21(0xfffeffff)
    la  x2, test_data
    addi    x2, x2,64
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x21, 8(x2)
    sw x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0xfffeffff)

    # Testcase 83:  imm:0x4, result rd:x22(0xfffdffff)
    la  x2, test_data
    addi    x2, x2,68
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x22, 4(x2)
    sw x22, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0xfffdffff)

    # Testcase 84:  imm:0x7c, result rd:x23(0xfffbffff)
    la  x2, test_data
    addi    x2, x2,72
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x23, 124(x2)
    sw x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0xfffbffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")



    # Addresses for test data and results
    la x1, test_18_res

    # Testcase 85:  imm:0x3c, result rd:x24(0xfff7ffff)
    la  x2, test_data
    addi    x2, x2,76
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x24, 60(x2)
    sw x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0xfff7ffff)

    # Testcase 86:  imm:0x5c, result rd:x25(0xffefffff)
    la  x2, test_data
    addi    x2, x2,80
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x25, 92(x2)
    sw x25, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0xffefffff)

    # Testcase 87:  imm:0x6c, result rd:x26(0xffdfffff)
    la  x2, test_data
    addi    x2, x2,84
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x26, 108(x2)
    sw x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0xffdfffff)

    # Testcase 88:  imm:0x74, result rd:x27(0xffbfffff)
    la  x2, test_data
    addi    x2, x2,88
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x27, 116(x2)
    sw x27, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0xffbfffff)

    # Testcase 89:  imm:0x78, result rd:x28(0xff7fffff)
    la  x2, test_data
    addi    x2, x2,92
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x28, 120(x2)
    sw x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0xff7fffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")



    # Addresses for test data and results
    la x3, test_19_res

    # Testcase 90:  imm:0x0, result rd:x29(0xfeffffff)
    la  x2, test_data
    addi    x2, x2,96
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    c.lwsp x29, 0(x2)
    sw x29, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0xfeffffff)

    # Testcase 91:  imm:0x40, result rd:x30(0xfdffffff)
    la  x2, test_data
    addi    x2, x2,100
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    c.lwsp x30, 64(x2)
    sw x30, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0xfdffffff)

    # Testcase 92:  imm:0x20, result rd:x31(0xfeffffff)
    la  x2, test_data
    addi    x2, x2,104
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    c.lwsp x31, 32(x2)
    sw x31, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0xfeffffff)

    # Testcase 93:  imm:0x10, result rd:x1(0xf7ffffff)
    la  x2, test_data
    addi    x2, x2,108
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    c.lwsp x1, 16(x2)
    sw x1, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0xf7ffffff)

    # Testcase 94:  imm:0x8, result rd:x2(0xefffffff)
    la  x2, test_data
    addi    x2, x2,112
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    c.lwsp x2, 8(x2)
    sw x2, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0xefffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")



    # Addresses for test data and results
    la x1, test_20_res

    # Testcase 95:  imm:0x4, result rd:x3(0xdfffffff)
    la  x2, test_data
    addi    x2, x2,116
    li     x8, MASK_XLEN(-4)
    add    x2, x2, x8
    c.lwsp x3, 4(x2)
    sw x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x3, 0xdfffffff)

    # Testcase 96:  imm:0x7c, result rd:x4(0xefffffff)
    la  x2, test_data
    addi    x2, x2,120
    li     x8, MASK_XLEN(-124)
    add    x2, x2, x8
    c.lwsp x4, 124(x2)
    sw x4, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x4, 0xefffffff)

    # Testcase 97:  imm:0x3c, result rd:x5(0x7fffffff)
    la  x2, test_data
    addi    x2, x2,124
    li     x8, MASK_XLEN(-60)
    add    x2, x2, x8
    c.lwsp x5, 60(x2)
    sw x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x5, 0x7fffffff)

    # Testcase 98:  imm:0x5c, result rd:x6(0xffffffff)
    la  x2, test_data
    addi    x2, x2,128
    li     x8, MASK_XLEN(-92)
    add    x2, x2, x8
    c.lwsp x6, 92(x2)
    sw x6, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x6, 0xffffffff)

    # Testcase 99:  imm:0x6c, result rd:x7(0x00000001)
    la  x2, test_data
    addi    x2, x2,132
    li     x8, MASK_XLEN(-108)
    add    x2, x2, x8
    c.lwsp x7, 108(x2)
    sw x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x7, 0x00000001)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")



    # Addresses for test data and results
    la x1, test_21_res

    # Testcase 100:  imm:0x74, result rd:x8(0x00000002)
    la  x2, test_data
    addi    x2, x2,136
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x8, 116(x2)
    sw x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x00000002)

    # Testcase 101:  imm:0x78, result rd:x9(0x00000004)
    la  x2, test_data
    addi    x2, x2,140
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x9, 120(x2)
    sw x9, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0x00000004)

    # Testcase 102:  imm:0x0, result rd:x10(0x00000008)
    la  x2, test_data
    addi    x2, x2,144
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x10, 0(x2)
    sw x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0x00000008)

    # Testcase 103:  imm:0x40, result rd:x11(0x00000010)
    la  x2, test_data
    addi    x2, x2,148
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x11, 64(x2)
    sw x11, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x11, 0x00000010)

    # Testcase 104:  imm:0x20, result rd:x12(0x00000020)
    la  x2, test_data
    addi    x2, x2,152
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x12, 32(x2)
    sw x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x12, 0x00000020)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")



    # Addresses for test data and results
    la x5, test_22_res

    # Testcase 105:  imm:0x10, result rd:x13(0x00000040)
    la  x2, test_data
    addi    x2, x2,156
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    c.lwsp x13, 16(x2)
    sw x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x00000040)

    # Testcase 106:  imm:0x8, result rd:x14(0x00000080)
    la  x2, test_data
    addi    x2, x2,160
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    c.lwsp x14, 8(x2)
    sw x14, 4(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x00000080)

    # Testcase 107:  imm:0x4, result rd:x15(0x00000100)
    la  x2, test_data
    addi    x2, x2,164
    li     x6, MASK_XLEN(-4)
    add    x2, x2, x6
    c.lwsp x15, 4(x2)
    sw x15, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x00000100)

    # Testcase 108:  imm:0x7c, result rd:x16(0x00000200)
    la  x2, test_data
    addi    x2, x2,168
    li     x6, MASK_XLEN(-124)
    add    x2, x2, x6
    c.lwsp x16, 124(x2)
    sw x16, 12(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x00000200)

    # Testcase 109:  imm:0x3c, result rd:x17(0x00000400)
    la  x2, test_data
    addi    x2, x2,172
    li     x6, MASK_XLEN(-60)
    add    x2, x2, x6
    c.lwsp x17, 60(x2)
    sw x17, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x17, 0x00000400)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")



    # Addresses for test data and results
    la x1, test_23_res

    # Testcase 110:  imm:0x5c, result rd:x18(0x00000800)
    la  x2, test_data
    addi    x2, x2,176
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x18, 92(x2)
    sw x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x00000800)

    # Testcase 111:  imm:0x6c, result rd:x19(0x00001000)
    la  x2, test_data
    addi    x2, x2,180
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x19, 108(x2)
    sw x19, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x00001000)

    # Testcase 112:  imm:0x74, result rd:x20(0x00002000)
    la  x2, test_data
    addi    x2, x2,184
    li     x3, MASK_XLEN(-116)
    add    x2, x2, x3
    c.lwsp x20, 116(x2)
    sw x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x00002000)

    # Testcase 113:  imm:0x78, result rd:x21(0x00004000)
    la  x2, test_data
    addi    x2, x2,188
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.lwsp x21, 120(x2)
    sw x21, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0x00004000)

    # Testcase 114:  imm:0x0, result rd:x22(0x00008000)
    la  x2, test_data
    addi    x2, x2,192
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.lwsp x22, 0(x2)
    sw x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0x00008000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")



    # Addresses for test data and results
    la x1, test_24_res

    # Testcase 115:  imm:0x40, result rd:x23(0x00000001)
    la  x2, test_data
    addi    x2, x2,196
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.lwsp x23, 64(x2)
    sw x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0x00000001)

    # Testcase 116:  imm:0x20, result rd:x24(0x00000002)
    la  x2, test_data
    addi    x2, x2,200
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.lwsp x24, 32(x2)
    sw x24, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0x00000002)

    # Testcase 117:  imm:0x10, result rd:x25(0x00040000)
    la  x2, test_data
    addi    x2, x2,204
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.lwsp x25, 16(x2)
    sw x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0x00040000)

    # Testcase 118:  imm:0x8, result rd:x26(0x00080000)
    la  x2, test_data
    addi    x2, x2,208
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x26, 8(x2)
    sw x26, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0x00080000)

    # Testcase 119:  imm:0x4, result rd:x27(0x00000010)
    la  x2, test_data
    addi    x2, x2,212
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x27, 4(x2)
    sw x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0x00000010)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")



    # Addresses for test data and results
    la x3, test_25_res

    # Testcase 120:  imm:0x7c, result rd:x28(0x00000020)
    la  x2, test_data
    addi    x2, x2,216
    li     x4, MASK_XLEN(-124)
    add    x2, x2, x4
    c.lwsp x28, 124(x2)
    sw x28, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x28, 0x00000020)

    # Testcase 121:  imm:0x3c, result rd:x29(0x00400000)
    la  x2, test_data
    addi    x2, x2,220
    li     x4, MASK_XLEN(-60)
    add    x2, x2, x4
    c.lwsp x29, 60(x2)
    sw x29, 4(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x00400000)

    # Testcase 122:  imm:0x5c, result rd:x30(0x00800000)
    la  x2, test_data
    addi    x2, x2,224
    li     x4, MASK_XLEN(-92)
    add    x2, x2, x4
    c.lwsp x30, 92(x2)
    sw x30, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x00800000)

    # Testcase 123:  imm:0x6c, result rd:x31(0x00000100)
    la  x2, test_data
    addi    x2, x2,228
    li     x4, MASK_XLEN(-108)
    add    x2, x2, x4
    c.lwsp x31, 108(x2)
    sw x31, 12(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x00000100)

    # Testcase 124:  imm:0x74, result rd:x1(0x00000200)
    la  x2, test_data
    addi    x2, x2,232
    li     x4, MASK_XLEN(-116)
    add    x2, x2, x4
    c.lwsp x1, 116(x2)
    sw x1, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x00000200)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")



    # Addresses for test data and results
    la x1, test_26_res

    # Testcase 125:  imm:0x78, result rd:x2(0x04000000)
    la  x2, test_data
    addi    x2, x2,236
    li     x7, MASK_XLEN(-120)
    add    x2, x2, x7
    c.lwsp x2, 120(x2)
    sw x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x04000000)

    # Testcase 126:  imm:0x0, result rd:x3(0x08000000)
    la  x2, test_data
    addi    x2, x2,240
    li     x7, MASK_XLEN(0)
    add    x2, x2, x7
    c.lwsp x3, 0(x2)
    sw x3, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x08000000)

    # Testcase 127:  imm:0x40, result rd:x4(0x00001000)
    la  x2, test_data
    addi    x2, x2,244
    li     x7, MASK_XLEN(-64)
    add    x2, x2, x7
    c.lwsp x4, 64(x2)
    sw x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x00001000)

    # Testcase 128:  imm:0x20, result rd:x5(0x00002000)
    la  x2, test_data
    addi    x2, x2,248
    li     x7, MASK_XLEN(-32)
    add    x2, x2, x7
    c.lwsp x5, 32(x2)
    sw x5, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x00002000)

    # Testcase 129:  imm:0x10, result rd:x6(0x40000000)
    la  x2, test_data
    addi    x2, x2,252
    li     x7, MASK_XLEN(-16)
    add    x2, x2, x7
    c.lwsp x6, 16(x2)
    sw x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x40000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")



    # Addresses for test data and results
    la x1, test_27_res

    # Testcase 130:  imm:0x8, result rd:x7(0x80000000)
    la  x2, test_data
    addi    x2, x2,256
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.lwsp x7, 8(x2)
    sw x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0x80000000)

    # Testcase 131:  imm:0x4, result rd:x8(0x00000000)
    la  x2, test_data
    addi    x2, x2,260
    li     x3, MASK_XLEN(-4)
    add    x2, x2, x3
    c.lwsp x8, 4(x2)
    sw x8, 4(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x00000000)

    # Testcase 132:  imm:0x7c, result rd:x9(0xfffffffe)
    la  x2, test_data
    addi    x2, x2,0
    li     x3, MASK_XLEN(-124)
    add    x2, x2, x3
    c.lwsp x9, 124(x2)
    sw x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0xfffffffe)

    # Testcase 133:  imm:0x3c, result rd:x10(0xfffffffd)
    la  x2, test_data
    addi    x2, x2,4
    li     x3, MASK_XLEN(-60)
    add    x2, x2, x3
    c.lwsp x10, 60(x2)
    sw x10, 12(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xfffffffd)

    # Testcase 134:  imm:0x5c, result rd:x11(0xfffffffb)
    la  x2, test_data
    addi    x2, x2,8
    li     x3, MASK_XLEN(-92)
    add    x2, x2, x3
    c.lwsp x11, 92(x2)
    sw x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x11, 0xfffffffb)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")



    # Addresses for test data and results
    la x1, test_28_res

    # Testcase 135:  imm:0x6c, result rd:x12(0xfffffff7)
    la  x2, test_data
    addi    x2, x2,12
    li     x3, MASK_XLEN(-108)
    add    x2, x2, x3
    c.lwsp x12, 108(x2)
    sw x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x12, 0xfffffff7)

\

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

