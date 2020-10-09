# RISC-V Compliance Test I-C-LD-01
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
# Description: Testing instruction 'c.ld'.

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

    # Testcase 0:  imm:0xf8, result rd:x8(0xfffffffffffffffe)
    la  x15, test_data
    addi    x15, x15,0
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffffffffe)

    # Testcase 1:  imm:0x78, result rd:x9(0xfffffffffffffffd)
    la  x14, test_data
    addi    x14, x14,8
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffffffffd)

    # Testcase 2:  imm:0xb8, result rd:x10(0xfffffffffffffffb)
    la  x13, test_data
    addi    x13, x13,16
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffffffffb)

    # Testcase 3:  imm:0xd8, result rd:x11(0xfffffffffffffff7)
    la  x12, test_data
    addi    x12, x12,24
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffffffffff7)

    # Testcase 4:  imm:0xe8, result rd:x12(0xffffffffffffffef)
    la  x11, test_data
    addi    x11, x11,32
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffffffef)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")



    # Addresses for test data and results
    la x1, test_2_res

    # Testcase 5:  imm:0xf0, result rd:x13(0xffffffffffffffdf)
    la  x10, test_data
    addi    x10, x10,40
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffffffffdf)

    # Testcase 6:  imm:0x0, result rd:x14(0xffffffffffffffbf)
    la  x9, test_data
    addi    x9, x9,48
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffffffffbf)

    # Testcase 7:  imm:0x80, result rd:x15(0xffffffffffffff7f)
    la  x8, test_data
    addi    x8, x8,56
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffffffffff7f)

    # Testcase 8:  imm:0x40, result rd:x8(0xfffffffffffffeff)
    la  x15, test_data
    addi    x15, x15,64
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffffffeff)

    # Testcase 9:  imm:0x20, result rd:x9(0xfffffffffffffdff)
    la  x14, test_data
    addi    x14, x14,72
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffffffdff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")



    # Addresses for test data and results
    la x1, test_3_res

    # Testcase 10:  imm:0x10, result rd:x10(0xfffffffffffffeff)
    la  x13, test_data
    addi    x13, x13,80
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffffffeff)

    # Testcase 11:  imm:0x8, result rd:x11(0xfffffffffffff7ff)
    la  x12, test_data
    addi    x12, x12,88
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffffffff7ff)

    # Testcase 12:  imm:0xf8, result rd:x12(0xffffffffffffefff)
    la  x11, test_data
    addi    x11, x11,96
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffffefff)

    # Testcase 13:  imm:0x78, result rd:x13(0xffffffffffffdfff)
    la  x10, test_data
    addi    x10, x10,104
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffffffdfff)

    # Testcase 14:  imm:0xb8, result rd:x14(0xffffffffffffefff)
    la  x9, test_data
    addi    x9, x9,112
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffffffefff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")



    # Addresses for test data and results
    la x1, test_4_res

    # Testcase 15:  imm:0xd8, result rd:x15(0xffffffffffff7fff)
    la  x8, test_data
    addi    x8, x8,120
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffffffff7fff)

    # Testcase 16:  imm:0xe8, result rd:x8(0xfffffffffffeffff)
    la  x15, test_data
    addi    x15, x15,128
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffffeffff)

    # Testcase 17:  imm:0xf0, result rd:x9(0xfffffffffffdffff)
    la  x14, test_data
    addi    x14, x14,136
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffffdffff)

    # Testcase 18:  imm:0x0, result rd:x10(0xfffffffffffbffff)
    la  x13, test_data
    addi    x13, x13,144
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffffbffff)

    # Testcase 19:  imm:0x80, result rd:x11(0xfffffffffff7ffff)
    la  x12, test_data
    addi    x12, x12,152
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffffff7ffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")



    # Addresses for test data and results
    la x1, test_5_res

    # Testcase 20:  imm:0x40, result rd:x12(0xffffffffffefffff)
    la  x11, test_data
    addi    x11, x11,160
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffefffff)

    # Testcase 21:  imm:0x20, result rd:x13(0xffffffffffdfffff)
    la  x10, test_data
    addi    x10, x10,168
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffffdfffff)

    # Testcase 22:  imm:0x10, result rd:x14(0xffffffffffbfffff)
    la  x9, test_data
    addi    x9, x9,176
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffffbfffff)

    # Testcase 23:  imm:0x8, result rd:x15(0xffffffffff7fffff)
    la  x8, test_data
    addi    x8, x8,184
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffffff7fffff)

    # Testcase 24:  imm:0xf8, result rd:x8(0xfffffffffeffffff)
    la  x15, test_data
    addi    x15, x15,192
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffffffeffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")



    # Addresses for test data and results
    la x1, test_6_res

    # Testcase 25:  imm:0x78, result rd:x9(0xfffffffffdffffff)
    la  x14, test_data
    addi    x14, x14,200
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffffdffffff)

    # Testcase 26:  imm:0xb8, result rd:x10(0xfffffffffeffffff)
    la  x13, test_data
    addi    x13, x13,208
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffffeffffff)

    # Testcase 27:  imm:0xd8, result rd:x11(0xfffffffff7ffffff)
    la  x12, test_data
    addi    x12, x12,216
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffff7ffffff)

    # Testcase 28:  imm:0xe8, result rd:x12(0xffffffffefffffff)
    la  x11, test_data
    addi    x11, x11,224
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffefffffff)

    # Testcase 29:  imm:0xf0, result rd:x13(0xffffffffdfffffff)
    la  x10, test_data
    addi    x10, x10,232
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffdfffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")



    # Addresses for test data and results
    la x1, test_7_res

    # Testcase 30:  imm:0x0, result rd:x14(0xffffffffefffffff)
    la  x9, test_data
    addi    x9, x9,240
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffffefffffff)

    # Testcase 31:  imm:0x80, result rd:x15(0xffffffff7fffffff)
    la  x8, test_data
    addi    x8, x8,248
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffff7fffffff)

    # Testcase 32:  imm:0x40, result rd:x8(0xffffffffffffffff)
    la  x15, test_data
    addi    x15, x15,256
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffffffff)

    # Testcase 33:  imm:0x20, result rd:x9(0xfffffffeffffffff)
    la  x14, test_data
    addi    x14, x14,264
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffffeffffffff)

    # Testcase 34:  imm:0x10, result rd:x10(0xfffffffdffffffff)
    la  x13, test_data
    addi    x13, x13,272
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffffdffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")



    # Addresses for test data and results
    la x1, test_8_res

    # Testcase 35:  imm:0x8, result rd:x11(0xfffffffbffffffff)
    la  x12, test_data
    addi    x12, x12,280
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffffbffffffff)

    # Testcase 36:  imm:0xf8, result rd:x12(0xfffffff7ffffffff)
    la  x11, test_data
    addi    x11, x11,288
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffff7ffffffff)

    # Testcase 37:  imm:0x78, result rd:x13(0xffffffefffffffff)
    la  x10, test_data
    addi    x10, x10,296
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffefffffffff)

    # Testcase 38:  imm:0xb8, result rd:x14(0xffffffdfffffffff)
    la  x9, test_data
    addi    x9, x9,304
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffffdfffffffff)

    # Testcase 39:  imm:0xd8, result rd:x15(0xffffffbfffffffff)
    la  x8, test_data
    addi    x8, x8,312
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffffbfffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")



    # Addresses for test data and results
    la x1, test_9_res

    # Testcase 40:  imm:0xe8, result rd:x8(0xffffff7fffffffff)
    la  x15, test_data
    addi    x15, x15,320
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffff7fffffffff)

    # Testcase 41:  imm:0xf0, result rd:x9(0xfffffeffffffffff)
    la  x14, test_data
    addi    x14, x14,328
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffffeffffffffff)

    # Testcase 42:  imm:0x0, result rd:x10(0xfffffdffffffffff)
    la  x13, test_data
    addi    x13, x13,336
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffffdffffffffff)

    # Testcase 43:  imm:0x80, result rd:x11(0xfffffeffffffffff)
    la  x12, test_data
    addi    x12, x12,344
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffffeffffffffff)

    # Testcase 44:  imm:0x40, result rd:x12(0xfffff7ffffffffff)
    la  x11, test_data
    addi    x11, x11,352
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffff7ffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")



    # Addresses for test data and results
    la x1, test_10_res

    # Testcase 45:  imm:0x20, result rd:x13(0xffffefffffffffff)
    la  x10, test_data
    addi    x10, x10,360
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffefffffffffff)

    # Testcase 46:  imm:0x10, result rd:x14(0xffffdfffffffffff)
    la  x9, test_data
    addi    x9, x9,368
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffffdfffffffffff)

    # Testcase 47:  imm:0x8, result rd:x15(0xffffefffffffffff)
    la  x8, test_data
    addi    x8, x8,376
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffffefffffffffff)

    # Testcase 48:  imm:0xf8, result rd:x8(0xffff7fffffffffff)
    la  x15, test_data
    addi    x15, x15,384
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffff7fffffffffff)

    # Testcase 49:  imm:0x78, result rd:x9(0xfffeffffffffffff)
    la  x14, test_data
    addi    x14, x14,392
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfffeffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")



    # Addresses for test data and results
    la x1, test_11_res

    # Testcase 50:  imm:0xb8, result rd:x10(0xfffdffffffffffff)
    la  x13, test_data
    addi    x13, x13,400
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfffdffffffffffff)

    # Testcase 51:  imm:0xd8, result rd:x11(0xfffbffffffffffff)
    la  x12, test_data
    addi    x12, x12,408
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfffbffffffffffff)

    # Testcase 52:  imm:0xe8, result rd:x12(0xfff7ffffffffffff)
    la  x11, test_data
    addi    x11, x11,416
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfff7ffffffffffff)

    # Testcase 53:  imm:0xf0, result rd:x13(0xffefffffffffffff)
    la  x10, test_data
    addi    x10, x10,424
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffefffffffffffff)

    # Testcase 54:  imm:0x0, result rd:x14(0xffdfffffffffffff)
    la  x9, test_data
    addi    x9, x9,432
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xffdfffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")



    # Addresses for test data and results
    la x1, test_12_res

    # Testcase 55:  imm:0x80, result rd:x15(0xffbfffffffffffff)
    la  x8, test_data
    addi    x8, x8,440
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xffbfffffffffffff)

    # Testcase 56:  imm:0x40, result rd:x8(0xff7fffffffffffff)
    la  x15, test_data
    addi    x15, x15,448
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xff7fffffffffffff)

    # Testcase 57:  imm:0x20, result rd:x9(0xfeffffffffffffff)
    la  x14, test_data
    addi    x14, x14,456
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xfeffffffffffffff)

    # Testcase 58:  imm:0x10, result rd:x10(0xfdffffffffffffff)
    la  x13, test_data
    addi    x13, x13,464
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xfdffffffffffffff)

    # Testcase 59:  imm:0x8, result rd:x11(0xfeffffffffffffff)
    la  x12, test_data
    addi    x12, x12,472
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xfeffffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")



    # Addresses for test data and results
    la x1, test_13_res

    # Testcase 60:  imm:0xf8, result rd:x12(0xf7ffffffffffffff)
    la  x11, test_data
    addi    x11, x11,480
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xf7ffffffffffffff)

    # Testcase 61:  imm:0x78, result rd:x13(0xefffffffffffffff)
    la  x10, test_data
    addi    x10, x10,488
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xefffffffffffffff)

    # Testcase 62:  imm:0xb8, result rd:x14(0xdfffffffffffffff)
    la  x9, test_data
    addi    x9, x9,496
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xdfffffffffffffff)

    # Testcase 63:  imm:0xd8, result rd:x15(0xefffffffffffffff)
    la  x8, test_data
    addi    x8, x8,504
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xefffffffffffffff)

    # Testcase 64:  imm:0xe8, result rd:x8(0x7fffffffffffffff)
    la  x15, test_data
    addi    x15, x15,512
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x7fffffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")



    # Addresses for test data and results
    la x1, test_14_res

    # Testcase 65:  imm:0xf0, result rd:x9(0xffffffffffffffff)
    la  x14, test_data
    addi    x14, x14,520
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffffffffff)

    # Testcase 66:  imm:0x0, result rd:x10(0x0000000000000001)
    la  x13, test_data
    addi    x13, x13,528
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000001)

    # Testcase 67:  imm:0x80, result rd:x11(0x0000000000000002)
    la  x12, test_data
    addi    x12, x12,536
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000002)

    # Testcase 68:  imm:0x40, result rd:x12(0x0000000000000004)
    la  x11, test_data
    addi    x11, x11,544
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000004)

    # Testcase 69:  imm:0x20, result rd:x13(0x0000000000000008)
    la  x10, test_data
    addi    x10, x10,552
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000008)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")



    # Addresses for test data and results
    la x1, test_15_res

    # Testcase 70:  imm:0x10, result rd:x14(0x0000000000000010)
    la  x9, test_data
    addi    x9, x9,560
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000010)

    # Testcase 71:  imm:0x8, result rd:x15(0x0000000000000020)
    la  x8, test_data
    addi    x8, x8,568
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000020)

    # Testcase 72:  imm:0xf8, result rd:x8(0x0000000000000040)
    la  x15, test_data
    addi    x15, x15,576
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000040)

    # Testcase 73:  imm:0x78, result rd:x9(0x0000000000000080)
    la  x14, test_data
    addi    x14, x14,584
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000080)

    # Testcase 74:  imm:0xb8, result rd:x10(0x0000000000000100)
    la  x13, test_data
    addi    x13, x13,592
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000100)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")



    # Addresses for test data and results
    la x1, test_16_res

    # Testcase 75:  imm:0xd8, result rd:x11(0x0000000000000200)
    la  x12, test_data
    addi    x12, x12,600
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000200)

    # Testcase 76:  imm:0xe8, result rd:x12(0x0000000000000400)
    la  x11, test_data
    addi    x11, x11,608
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000400)

    # Testcase 77:  imm:0xf0, result rd:x13(0x0000000000000800)
    la  x10, test_data
    addi    x10, x10,616
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000800)

    # Testcase 78:  imm:0x0, result rd:x14(0x0000000000001000)
    la  x9, test_data
    addi    x9, x9,624
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000001000)

    # Testcase 79:  imm:0x80, result rd:x15(0x0000000000002000)
    la  x8, test_data
    addi    x8, x8,632
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000002000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")



    # Addresses for test data and results
    la x1, test_17_res

    # Testcase 80:  imm:0x40, result rd:x8(0x0000000000004000)
    la  x15, test_data
    addi    x15, x15,640
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000004000)

    # Testcase 81:  imm:0x20, result rd:x9(0x0000000000008000)
    la  x14, test_data
    addi    x14, x14,648
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000008000)

    # Testcase 82:  imm:0x10, result rd:x10(0x0000000000010000)
    la  x13, test_data
    addi    x13, x13,656
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000010000)

    # Testcase 83:  imm:0x8, result rd:x11(0x0000000000020000)
    la  x12, test_data
    addi    x12, x12,664
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000020000)

    # Testcase 84:  imm:0xf8, result rd:x12(0x0000000000040000)
    la  x11, test_data
    addi    x11, x11,672
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000040000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")



    # Addresses for test data and results
    la x1, test_18_res

    # Testcase 85:  imm:0x78, result rd:x13(0x0000000000080000)
    la  x10, test_data
    addi    x10, x10,680
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000080000)

    # Testcase 86:  imm:0xb8, result rd:x14(0x0000000000100000)
    la  x9, test_data
    addi    x9, x9,688
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000100000)

    # Testcase 87:  imm:0xd8, result rd:x15(0x0000000000200000)
    la  x8, test_data
    addi    x8, x8,696
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000200000)

    # Testcase 88:  imm:0xe8, result rd:x8(0x0000000000400000)
    la  x15, test_data
    addi    x15, x15,704
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000400000)

    # Testcase 89:  imm:0xf0, result rd:x9(0x0000000000800000)
    la  x14, test_data
    addi    x14, x14,712
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000800000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")



    # Addresses for test data and results
    la x1, test_19_res

    # Testcase 90:  imm:0x0, result rd:x10(0x0000000001000000)
    la  x13, test_data
    addi    x13, x13,720
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000001000000)

    # Testcase 91:  imm:0x80, result rd:x11(0x0000000002000000)
    la  x12, test_data
    addi    x12, x12,728
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000002000000)

    # Testcase 92:  imm:0x40, result rd:x12(0x0000000004000000)
    la  x11, test_data
    addi    x11, x11,736
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000004000000)

    # Testcase 93:  imm:0x20, result rd:x13(0x0000000008000000)
    la  x10, test_data
    addi    x10, x10,744
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000008000000)

    # Testcase 94:  imm:0x10, result rd:x14(0x0000000010000000)
    la  x9, test_data
    addi    x9, x9,752
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000010000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")



    # Addresses for test data and results
    la x1, test_20_res

    # Testcase 95:  imm:0x8, result rd:x15(0x0000000020000000)
    la  x8, test_data
    addi    x8, x8,760
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000020000000)

    # Testcase 96:  imm:0xf8, result rd:x8(0x0000000040000000)
    la  x15, test_data
    addi    x15, x15,768
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000040000000)

    # Testcase 97:  imm:0x78, result rd:x9(0x0000000080000000)
    la  x14, test_data
    addi    x14, x14,776
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000080000000)

    # Testcase 98:  imm:0xb8, result rd:x10(0x0000000000000000)
    la  x13, test_data
    addi    x13, x13,784
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000000)

    # Testcase 99:  imm:0xd8, result rd:x11(0x0000000100000000)
    la  x12, test_data
    addi    x12, x12,792
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000100000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")



    # Addresses for test data and results
    la x1, test_21_res

    # Testcase 100:  imm:0xe8, result rd:x12(0x0000000200000000)
    la  x11, test_data
    addi    x11, x11,800
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000200000000)

    # Testcase 101:  imm:0xf0, result rd:x13(0x0000000400000000)
    la  x10, test_data
    addi    x10, x10,808
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000400000000)

    # Testcase 102:  imm:0x0, result rd:x14(0x0000000800000000)
    la  x9, test_data
    addi    x9, x9,816
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000800000000)

    # Testcase 103:  imm:0x80, result rd:x15(0x0000001000000000)
    la  x8, test_data
    addi    x8, x8,824
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000001000000000)

    # Testcase 104:  imm:0x40, result rd:x8(0x0000002000000000)
    la  x15, test_data
    addi    x15, x15,832
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000002000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")



    # Addresses for test data and results
    la x1, test_22_res

    # Testcase 105:  imm:0x20, result rd:x9(0x0000004000000000)
    la  x14, test_data
    addi    x14, x14,840
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000004000000000)

    # Testcase 106:  imm:0x10, result rd:x10(0x0000008000000000)
    la  x13, test_data
    addi    x13, x13,848
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000008000000000)

    # Testcase 107:  imm:0x8, result rd:x11(0x0000010000000000)
    la  x12, test_data
    addi    x12, x12,856
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000010000000000)

    # Testcase 108:  imm:0xf8, result rd:x12(0x0000020000000000)
    la  x11, test_data
    addi    x11, x11,864
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000020000000000)

    # Testcase 109:  imm:0x78, result rd:x13(0x0000040000000000)
    la  x10, test_data
    addi    x10, x10,872
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000040000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")



    # Addresses for test data and results
    la x1, test_23_res

    # Testcase 110:  imm:0xb8, result rd:x14(0x0000080000000000)
    la  x9, test_data
    addi    x9, x9,880
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000080000000000)

    # Testcase 111:  imm:0xd8, result rd:x15(0x0000100000000000)
    la  x8, test_data
    addi    x8, x8,888
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000100000000000)

    # Testcase 112:  imm:0xe8, result rd:x8(0x0000200000000000)
    la  x15, test_data
    addi    x15, x15,896
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000200000000000)

    # Testcase 113:  imm:0xf0, result rd:x9(0x0000400000000000)
    la  x14, test_data
    addi    x14, x14,904
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000400000000000)

    # Testcase 114:  imm:0x0, result rd:x10(0x0000800000000000)
    la  x13, test_data
    addi    x13, x13,912
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000800000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")



    # Addresses for test data and results
    la x1, test_24_res

    # Testcase 115:  imm:0x80, result rd:x11(0x0001000000000000)
    la  x12, test_data
    addi    x12, x12,920
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0001000000000000)

    # Testcase 116:  imm:0x40, result rd:x12(0x0002000000000000)
    la  x11, test_data
    addi    x11, x11,928
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0002000000000000)

    # Testcase 117:  imm:0x20, result rd:x13(0x0004000000000000)
    la  x10, test_data
    addi    x10, x10,936
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0004000000000000)

    # Testcase 118:  imm:0x10, result rd:x14(0x0008000000000000)
    la  x9, test_data
    addi    x9, x9,944
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0008000000000000)

    # Testcase 119:  imm:0x8, result rd:x15(0x0010000000000000)
    la  x8, test_data
    addi    x8, x8,952
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0010000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")



    # Addresses for test data and results
    la x1, test_25_res

    # Testcase 120:  imm:0xf8, result rd:x8(0x0020000000000000)
    la  x15, test_data
    addi    x15, x15,960
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0020000000000000)

    # Testcase 121:  imm:0x78, result rd:x9(0x0040000000000000)
    la  x14, test_data
    addi    x14, x14,968
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0040000000000000)

    # Testcase 122:  imm:0xb8, result rd:x10(0x0080000000000000)
    la  x13, test_data
    addi    x13, x13,976
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0080000000000000)

    # Testcase 123:  imm:0xd8, result rd:x11(0x0100000000000000)
    la  x12, test_data
    addi    x12, x12,984
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0100000000000000)

    # Testcase 124:  imm:0xe8, result rd:x12(0x0200000000000000)
    la  x11, test_data
    addi    x11, x11,992
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0200000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")



    # Addresses for test data and results
    la x1, test_26_res

    # Testcase 125:  imm:0xf0, result rd:x13(0x0400000000000000)
    la  x10, test_data
    addi    x10, x10,1000
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0400000000000000)

    # Testcase 126:  imm:0x0, result rd:x14(0x0800000000000000)
    la  x9, test_data
    addi    x9, x9,1008
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0800000000000000)

    # Testcase 127:  imm:0x80, result rd:x15(0x1000000000000000)
    la  x8, test_data
    addi    x8, x8,1016
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x1000000000000000)

    # Testcase 128:  imm:0x40, result rd:x8(0x2000000000000000)
    la  x15, test_data
    addi    x15, x15,1024
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x2000000000000000)

    # Testcase 129:  imm:0x20, result rd:x9(0x4000000000000000)
    la  x14, test_data
    addi    x14, x14,1032
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x4000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")



    # Addresses for test data and results
    la x1, test_27_res

    # Testcase 130:  imm:0x10, result rd:x10(0x8000000000000000)
    la  x13, test_data
    addi    x13, x13,1040
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x8000000000000000)

    # Testcase 131:  imm:0x8, result rd:x11(0x0000000000000000)
    la  x12, test_data
    addi    x12, x12,1048
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000000)

    # Testcase 132:  imm:0xf8, result rd:x12(0xfffffffffffffffe)
    la  x11, test_data
    addi    x11, x11,0
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffffffffe)

    # Testcase 133:  imm:0x78, result rd:x13(0xfffffffffffffffd)
    la  x10, test_data
    addi    x10, x10,8
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffffffffd)

    # Testcase 134:  imm:0xb8, result rd:x14(0xfffffffffffffffb)
    la  x9, test_data
    addi    x9, x9,16
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffffffffb)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")



    # Addresses for test data and results
    la x1, test_28_res

    # Testcase 135:  imm:0xd8, result rd:x15(0xfffffffffffffff7)
    la  x8, test_data
    addi    x8, x8,24
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffffffffff7)

    # Testcase 136:  imm:0xe8, result rd:x8(0xffffffffffffffef)
    la  x15, test_data
    addi    x15, x15,32
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffffffef)

    # Testcase 137:  imm:0xf0, result rd:x9(0xffffffffffffffdf)
    la  x14, test_data
    addi    x14, x14,40
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffffffffdf)

    # Testcase 138:  imm:0x0, result rd:x10(0xffffffffffffffbf)
    la  x13, test_data
    addi    x13, x13,48
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffffffffbf)

    # Testcase 139:  imm:0x80, result rd:x11(0xffffffffffffff7f)
    la  x12, test_data
    addi    x12, x12,56
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffffffffff7f)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")



    # Addresses for test data and results
    la x1, test_29_res

    # Testcase 140:  imm:0x40, result rd:x12(0xfffffffffffffeff)
    la  x11, test_data
    addi    x11, x11,64
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffffffeff)

    # Testcase 141:  imm:0x20, result rd:x13(0xfffffffffffffdff)
    la  x10, test_data
    addi    x10, x10,72
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffffffdff)

    # Testcase 142:  imm:0x10, result rd:x14(0xfffffffffffffeff)
    la  x9, test_data
    addi    x9, x9,80
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffffffeff)

    # Testcase 143:  imm:0x8, result rd:x15(0xfffffffffffff7ff)
    la  x8, test_data
    addi    x8, x8,88
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffffffff7ff)

    # Testcase 144:  imm:0xf8, result rd:x8(0xffffffffffffefff)
    la  x15, test_data
    addi    x15, x15,96
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffffefff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")



    # Addresses for test data and results
    la x1, test_30_res

    # Testcase 145:  imm:0x78, result rd:x9(0xffffffffffffdfff)
    la  x14, test_data
    addi    x14, x14,104
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffffffdfff)

    # Testcase 146:  imm:0xb8, result rd:x10(0xffffffffffffefff)
    la  x13, test_data
    addi    x13, x13,112
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffffffefff)

    # Testcase 147:  imm:0xd8, result rd:x11(0xffffffffffff7fff)
    la  x12, test_data
    addi    x12, x12,120
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffffffff7fff)

    # Testcase 148:  imm:0xe8, result rd:x12(0xfffffffffffeffff)
    la  x11, test_data
    addi    x11, x11,128
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffffeffff)

    # Testcase 149:  imm:0xf0, result rd:x13(0xfffffffffffdffff)
    la  x10, test_data
    addi    x10, x10,136
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffffdffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")



    # Addresses for test data and results
    la x1, test_31_res

    # Testcase 150:  imm:0x0, result rd:x14(0xfffffffffffbffff)
    la  x9, test_data
    addi    x9, x9,144
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffffbffff)

    # Testcase 151:  imm:0x80, result rd:x15(0xfffffffffff7ffff)
    la  x8, test_data
    addi    x8, x8,152
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffffff7ffff)

    # Testcase 152:  imm:0x40, result rd:x8(0xffffffffffefffff)
    la  x15, test_data
    addi    x15, x15,160
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffffefffff)

    # Testcase 153:  imm:0x20, result rd:x9(0xffffffffffdfffff)
    la  x14, test_data
    addi    x14, x14,168
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffffdfffff)

    # Testcase 154:  imm:0x10, result rd:x10(0xffffffffffbfffff)
    la  x13, test_data
    addi    x13, x13,176
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffffbfffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")



    # Addresses for test data and results
    la x1, test_32_res

    # Testcase 155:  imm:0x8, result rd:x11(0xffffffffff7fffff)
    la  x12, test_data
    addi    x12, x12,184
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffffff7fffff)

    # Testcase 156:  imm:0xf8, result rd:x12(0xfffffffffeffffff)
    la  x11, test_data
    addi    x11, x11,192
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xfffffffffeffffff)

    # Testcase 157:  imm:0x78, result rd:x13(0xfffffffffdffffff)
    la  x10, test_data
    addi    x10, x10,200
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffffdffffff)

    # Testcase 158:  imm:0xb8, result rd:x14(0xfffffffffeffffff)
    la  x9, test_data
    addi    x9, x9,208
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffffeffffff)

    # Testcase 159:  imm:0xd8, result rd:x15(0xfffffffff7ffffff)
    la  x8, test_data
    addi    x8, x8,216
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffff7ffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")



    # Addresses for test data and results
    la x1, test_33_res

    # Testcase 160:  imm:0xe8, result rd:x8(0xffffffffefffffff)
    la  x15, test_data
    addi    x15, x15,224
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xffffffffefffffff)

    # Testcase 161:  imm:0xf0, result rd:x9(0xffffffffdfffffff)
    la  x14, test_data
    addi    x14, x14,232
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffffdfffffff)

    # Testcase 162:  imm:0x0, result rd:x10(0xffffffffefffffff)
    la  x13, test_data
    addi    x13, x13,240
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffffefffffff)

    # Testcase 163:  imm:0x80, result rd:x11(0xffffffff7fffffff)
    la  x12, test_data
    addi    x12, x12,248
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffff7fffffff)

    # Testcase 164:  imm:0x40, result rd:x12(0xffffffffffffffff)
    la  x11, test_data
    addi    x11, x11,256
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")



    # Addresses for test data and results
    la x1, test_34_res

    # Testcase 165:  imm:0x20, result rd:x13(0xfffffffeffffffff)
    la  x10, test_data
    addi    x10, x10,264
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffffeffffffff)

    # Testcase 166:  imm:0x10, result rd:x14(0xfffffffdffffffff)
    la  x9, test_data
    addi    x9, x9,272
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffffdffffffff)

    # Testcase 167:  imm:0x8, result rd:x15(0xfffffffbffffffff)
    la  x8, test_data
    addi    x8, x8,280
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffffbffffffff)

    # Testcase 168:  imm:0xf8, result rd:x8(0xfffffff7ffffffff)
    la  x15, test_data
    addi    x15, x15,288
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffffff7ffffffff)

    # Testcase 169:  imm:0x78, result rd:x9(0xffffffefffffffff)
    la  x14, test_data
    addi    x14, x14,296
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffefffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")



    # Addresses for test data and results
    la x1, test_35_res

    # Testcase 170:  imm:0xb8, result rd:x10(0xffffffdfffffffff)
    la  x13, test_data
    addi    x13, x13,304
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffffdfffffffff)

    # Testcase 171:  imm:0xd8, result rd:x11(0xffffffbfffffffff)
    la  x12, test_data
    addi    x12, x12,312
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffffbfffffffff)

    # Testcase 172:  imm:0xe8, result rd:x12(0xffffff7fffffffff)
    la  x11, test_data
    addi    x11, x11,320
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffffff7fffffffff)

    # Testcase 173:  imm:0xf0, result rd:x13(0xfffffeffffffffff)
    la  x10, test_data
    addi    x10, x10,328
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffffeffffffffff)

    # Testcase 174:  imm:0x0, result rd:x14(0xfffffdffffffffff)
    la  x9, test_data
    addi    x9, x9,336
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffffdffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")



    # Addresses for test data and results
    la x1, test_36_res

    # Testcase 175:  imm:0x80, result rd:x15(0xfffffeffffffffff)
    la  x8, test_data
    addi    x8, x8,344
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffffeffffffffff)

    # Testcase 176:  imm:0x40, result rd:x8(0xfffff7ffffffffff)
    la  x15, test_data
    addi    x15, x15,352
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfffff7ffffffffff)

    # Testcase 177:  imm:0x20, result rd:x9(0xffffefffffffffff)
    la  x14, test_data
    addi    x14, x14,360
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffffefffffffffff)

    # Testcase 178:  imm:0x10, result rd:x10(0xffffdfffffffffff)
    la  x13, test_data
    addi    x13, x13,368
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffffdfffffffffff)

    # Testcase 179:  imm:0x8, result rd:x11(0xffffefffffffffff)
    la  x12, test_data
    addi    x12, x12,376
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffffefffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")



    # Addresses for test data and results
    la x1, test_37_res

    # Testcase 180:  imm:0xf8, result rd:x12(0xffff7fffffffffff)
    la  x11, test_data
    addi    x11, x11,384
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xffff7fffffffffff)

    # Testcase 181:  imm:0x78, result rd:x13(0xfffeffffffffffff)
    la  x10, test_data
    addi    x10, x10,392
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfffeffffffffffff)

    # Testcase 182:  imm:0xb8, result rd:x14(0xfffdffffffffffff)
    la  x9, test_data
    addi    x9, x9,400
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfffdffffffffffff)

    # Testcase 183:  imm:0xd8, result rd:x15(0xfffbffffffffffff)
    la  x8, test_data
    addi    x8, x8,408
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfffbffffffffffff)

    # Testcase 184:  imm:0xe8, result rd:x8(0xfff7ffffffffffff)
    la  x15, test_data
    addi    x15, x15,416
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xfff7ffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")



    # Addresses for test data and results
    la x1, test_38_res

    # Testcase 185:  imm:0xf0, result rd:x9(0xffefffffffffffff)
    la  x14, test_data
    addi    x14, x14,424
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xffefffffffffffff)

    # Testcase 186:  imm:0x0, result rd:x10(0xffdfffffffffffff)
    la  x13, test_data
    addi    x13, x13,432
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xffdfffffffffffff)

    # Testcase 187:  imm:0x80, result rd:x11(0xffbfffffffffffff)
    la  x12, test_data
    addi    x12, x12,440
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xffbfffffffffffff)

    # Testcase 188:  imm:0x40, result rd:x12(0xff7fffffffffffff)
    la  x11, test_data
    addi    x11, x11,448
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0xff7fffffffffffff)

    # Testcase 189:  imm:0x20, result rd:x13(0xfeffffffffffffff)
    la  x10, test_data
    addi    x10, x10,456
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xfeffffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")



    # Addresses for test data and results
    la x1, test_39_res

    # Testcase 190:  imm:0x10, result rd:x14(0xfdffffffffffffff)
    la  x9, test_data
    addi    x9, x9,464
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0xfdffffffffffffff)

    # Testcase 191:  imm:0x8, result rd:x15(0xfeffffffffffffff)
    la  x8, test_data
    addi    x8, x8,472
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0xfeffffffffffffff)

    # Testcase 192:  imm:0xf8, result rd:x8(0xf7ffffffffffffff)
    la  x15, test_data
    addi    x15, x15,480
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0xf7ffffffffffffff)

    # Testcase 193:  imm:0x78, result rd:x9(0xefffffffffffffff)
    la  x14, test_data
    addi    x14, x14,488
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0xefffffffffffffff)

    # Testcase 194:  imm:0xb8, result rd:x10(0xdfffffffffffffff)
    la  x13, test_data
    addi    x13, x13,496
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0xdfffffffffffffff)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")



    # Addresses for test data and results
    la x1, test_40_res

    # Testcase 195:  imm:0xd8, result rd:x11(0xefffffffffffffff)
    la  x12, test_data
    addi    x12, x12,504
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0xefffffffffffffff)

    # Testcase 196:  imm:0xe8, result rd:x12(0x7fffffffffffffff)
    la  x11, test_data
    addi    x11, x11,512
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x7fffffffffffffff)

    # Testcase 197:  imm:0xf0, result rd:x13(0xffffffffffffffff)
    la  x10, test_data
    addi    x10, x10,520
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0xffffffffffffffff)

    # Testcase 198:  imm:0x0, result rd:x14(0x0000000000000001)
    la  x9, test_data
    addi    x9, x9,528
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000001)

    # Testcase 199:  imm:0x80, result rd:x15(0x0000000000000002)
    la  x8, test_data
    addi    x8, x8,536
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000002)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")



    # Addresses for test data and results
    la x1, test_41_res

    # Testcase 200:  imm:0x40, result rd:x8(0x0000000000000004)
    la  x15, test_data
    addi    x15, x15,544
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000004)

    # Testcase 201:  imm:0x20, result rd:x9(0x0000000000000008)
    la  x14, test_data
    addi    x14, x14,552
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000008)

    # Testcase 202:  imm:0x10, result rd:x10(0x0000000000000010)
    la  x13, test_data
    addi    x13, x13,560
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000000010)

    # Testcase 203:  imm:0x8, result rd:x11(0x0000000000000020)
    la  x12, test_data
    addi    x12, x12,568
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000000020)

    # Testcase 204:  imm:0xf8, result rd:x12(0x0000000000000040)
    la  x11, test_data
    addi    x11, x11,576
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000000040)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")



    # Addresses for test data and results
    la x1, test_42_res

    # Testcase 205:  imm:0x78, result rd:x13(0x0000000000000080)
    la  x10, test_data
    addi    x10, x10,584
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000000080)

    # Testcase 206:  imm:0xb8, result rd:x14(0x0000000000000100)
    la  x9, test_data
    addi    x9, x9,592
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000100)

    # Testcase 207:  imm:0xd8, result rd:x15(0x0000000000000200)
    la  x8, test_data
    addi    x8, x8,600
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000000200)

    # Testcase 208:  imm:0xe8, result rd:x8(0x0000000000000400)
    la  x15, test_data
    addi    x15, x15,608
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000000400)

    # Testcase 209:  imm:0xf0, result rd:x9(0x0000000000000800)
    la  x14, test_data
    addi    x14, x14,616
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000000800)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")



    # Addresses for test data and results
    la x1, test_43_res

    # Testcase 210:  imm:0x0, result rd:x10(0x0000000000001000)
    la  x13, test_data
    addi    x13, x13,624
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000001000)

    # Testcase 211:  imm:0x80, result rd:x11(0x0000000000002000)
    la  x12, test_data
    addi    x12, x12,632
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000002000)

    # Testcase 212:  imm:0x40, result rd:x12(0x0000000000004000)
    la  x11, test_data
    addi    x11, x11,640
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000004000)

    # Testcase 213:  imm:0x20, result rd:x13(0x0000000000008000)
    la  x10, test_data
    addi    x10, x10,648
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000008000)

    # Testcase 214:  imm:0x10, result rd:x14(0x0000000000010000)
    la  x9, test_data
    addi    x9, x9,656
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000010000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")



    # Addresses for test data and results
    la x1, test_44_res

    # Testcase 215:  imm:0x8, result rd:x15(0x0000000000020000)
    la  x8, test_data
    addi    x8, x8,664
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000000020000)

    # Testcase 216:  imm:0xf8, result rd:x8(0x0000000000040000)
    la  x15, test_data
    addi    x15, x15,672
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000000040000)

    # Testcase 217:  imm:0x78, result rd:x9(0x0000000000080000)
    la  x14, test_data
    addi    x14, x14,680
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000000080000)

    # Testcase 218:  imm:0xb8, result rd:x10(0x0000000000100000)
    la  x13, test_data
    addi    x13, x13,688
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000000100000)

    # Testcase 219:  imm:0xd8, result rd:x11(0x0000000000200000)
    la  x12, test_data
    addi    x12, x12,696
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000000200000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")



    # Addresses for test data and results
    la x1, test_45_res

    # Testcase 220:  imm:0xe8, result rd:x12(0x0000000000400000)
    la  x11, test_data
    addi    x11, x11,704
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000000400000)

    # Testcase 221:  imm:0xf0, result rd:x13(0x0000000000800000)
    la  x10, test_data
    addi    x10, x10,712
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000000800000)

    # Testcase 222:  imm:0x0, result rd:x14(0x0000000001000000)
    la  x9, test_data
    addi    x9, x9,720
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000001000000)

    # Testcase 223:  imm:0x80, result rd:x15(0x0000000002000000)
    la  x8, test_data
    addi    x8, x8,728
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000002000000)

    # Testcase 224:  imm:0x40, result rd:x8(0x0000000004000000)
    la  x15, test_data
    addi    x15, x15,736
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000004000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")



    # Addresses for test data and results
    la x1, test_46_res

    # Testcase 225:  imm:0x20, result rd:x9(0x0000000008000000)
    la  x14, test_data
    addi    x14, x14,744
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000008000000)

    # Testcase 226:  imm:0x10, result rd:x10(0x0000000010000000)
    la  x13, test_data
    addi    x13, x13,752
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000010000000)

    # Testcase 227:  imm:0x8, result rd:x11(0x0000000020000000)
    la  x12, test_data
    addi    x12, x12,760
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000000020000000)

    # Testcase 228:  imm:0xf8, result rd:x12(0x0000000040000000)
    la  x11, test_data
    addi    x11, x11,768
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000000040000000)

    # Testcase 229:  imm:0x78, result rd:x13(0x0000000080000000)
    la  x10, test_data
    addi    x10, x10,776
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000000080000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")



    # Addresses for test data and results
    la x1, test_47_res

    # Testcase 230:  imm:0xb8, result rd:x14(0x0000000000000000)
    la  x9, test_data
    addi    x9, x9,784
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000000000000000)

    # Testcase 231:  imm:0xd8, result rd:x15(0x0000000100000000)
    la  x8, test_data
    addi    x8, x8,792
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000000100000000)

    # Testcase 232:  imm:0xe8, result rd:x8(0x0000000200000000)
    la  x15, test_data
    addi    x15, x15,800
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000000200000000)

    # Testcase 233:  imm:0xf0, result rd:x9(0x0000000400000000)
    la  x14, test_data
    addi    x14, x14,808
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000000400000000)

    # Testcase 234:  imm:0x0, result rd:x10(0x0000000800000000)
    la  x13, test_data
    addi    x13, x13,816
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000000800000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")



    # Addresses for test data and results
    la x1, test_48_res

    # Testcase 235:  imm:0x80, result rd:x11(0x0000001000000000)
    la  x12, test_data
    addi    x12, x12,824
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000001000000000)

    # Testcase 236:  imm:0x40, result rd:x12(0x0000002000000000)
    la  x11, test_data
    addi    x11, x11,832
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000002000000000)

    # Testcase 237:  imm:0x20, result rd:x13(0x0000004000000000)
    la  x10, test_data
    addi    x10, x10,840
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000004000000000)

    # Testcase 238:  imm:0x10, result rd:x14(0x0000008000000000)
    la  x9, test_data
    addi    x9, x9,848
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000008000000000)

    # Testcase 239:  imm:0x8, result rd:x15(0x0000010000000000)
    la  x8, test_data
    addi    x8, x8,856
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
    sd x15, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0000010000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")



    # Addresses for test data and results
    la x1, test_49_res

    # Testcase 240:  imm:0xf8, result rd:x8(0x0000020000000000)
    la  x15, test_data
    addi    x15, x15,864
    li     x2, MASK_XLEN(-248)
    add    x15, x15, x2
    c.ld x8, 248(x15)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0000020000000000)

    # Testcase 241:  imm:0x78, result rd:x9(0x0000040000000000)
    la  x14, test_data
    addi    x14, x14,872
    li     x2, MASK_XLEN(-120)
    add    x14, x14, x2
    c.ld x9, 120(x14)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0000040000000000)

    # Testcase 242:  imm:0xb8, result rd:x10(0x0000080000000000)
    la  x13, test_data
    addi    x13, x13,880
    li     x2, MASK_XLEN(-184)
    add    x13, x13, x2
    c.ld x10, 184(x13)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0000080000000000)

    # Testcase 243:  imm:0xd8, result rd:x11(0x0000100000000000)
    la  x12, test_data
    addi    x12, x12,888
    li     x2, MASK_XLEN(-216)
    add    x12, x12, x2
    c.ld x11, 216(x12)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0000100000000000)

    # Testcase 244:  imm:0xe8, result rd:x12(0x0000200000000000)
    la  x11, test_data
    addi    x11, x11,896
    li     x2, MASK_XLEN(-232)
    add    x11, x11, x2
    c.ld x12, 232(x11)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0000200000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")



    # Addresses for test data and results
    la x1, test_50_res

    # Testcase 245:  imm:0xf0, result rd:x13(0x0000400000000000)
    la  x10, test_data
    addi    x10, x10,904
    li     x2, MASK_XLEN(-240)
    add    x10, x10, x2
    c.ld x13, 240(x10)
    sd x13, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0000400000000000)

    # Testcase 246:  imm:0x0, result rd:x14(0x0000800000000000)
    la  x9, test_data
    addi    x9, x9,912
    li     x2, MASK_XLEN(0)
    add    x9, x9, x2
    c.ld x14, 0(x9)
    sd x14, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0000800000000000)

    # Testcase 247:  imm:0x80, result rd:x15(0x0001000000000000)
    la  x8, test_data
    addi    x8, x8,920
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    c.ld x15, 128(x8)
    sd x15, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0001000000000000)

    # Testcase 248:  imm:0x40, result rd:x8(0x0002000000000000)
    la  x15, test_data
    addi    x15, x15,928
    li     x2, MASK_XLEN(-64)
    add    x15, x15, x2
    c.ld x8, 64(x15)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0002000000000000)

    # Testcase 249:  imm:0x20, result rd:x9(0x0004000000000000)
    la  x14, test_data
    addi    x14, x14,936
    li     x2, MASK_XLEN(-32)
    add    x14, x14, x2
    c.ld x9, 32(x14)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0004000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")



    # Addresses for test data and results
    la x1, test_51_res

    # Testcase 250:  imm:0x10, result rd:x10(0x0008000000000000)
    la  x13, test_data
    addi    x13, x13,944
    li     x2, MASK_XLEN(-16)
    add    x13, x13, x2
    c.ld x10, 16(x13)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0008000000000000)

    # Testcase 251:  imm:0x8, result rd:x11(0x0010000000000000)
    la  x12, test_data
    addi    x12, x12,952
    li     x2, MASK_XLEN(-8)
    add    x12, x12, x2
    c.ld x11, 8(x12)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x0010000000000000)

    # Testcase 252:  imm:0xf8, result rd:x12(0x0020000000000000)
    la  x11, test_data
    addi    x11, x11,960
    li     x2, MASK_XLEN(-248)
    add    x11, x11, x2
    c.ld x12, 248(x11)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x0020000000000000)

    # Testcase 253:  imm:0x78, result rd:x13(0x0040000000000000)
    la  x10, test_data
    addi    x10, x10,968
    li     x2, MASK_XLEN(-120)
    add    x10, x10, x2
    c.ld x13, 120(x10)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x0040000000000000)

    # Testcase 254:  imm:0xb8, result rd:x14(0x0080000000000000)
    la  x9, test_data
    addi    x9, x9,976
    li     x2, MASK_XLEN(-184)
    add    x9, x9, x2
    c.ld x14, 184(x9)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x0080000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")



    # Addresses for test data and results
    la x1, test_52_res

    # Testcase 255:  imm:0xd8, result rd:x15(0x0100000000000000)
    la  x8, test_data
    addi    x8, x8,984
    li     x2, MASK_XLEN(-216)
    add    x8, x8, x2
    c.ld x15, 216(x8)
    sd x15, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x15, 0x0100000000000000)

    # Testcase 256:  imm:0xe8, result rd:x8(0x0200000000000000)
    la  x15, test_data
    addi    x15, x15,992
    li     x2, MASK_XLEN(-232)
    add    x15, x15, x2
    c.ld x8, 232(x15)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x8, 0x0200000000000000)

    # Testcase 257:  imm:0xf0, result rd:x9(0x0400000000000000)
    la  x14, test_data
    addi    x14, x14,1000
    li     x2, MASK_XLEN(-240)
    add    x14, x14, x2
    c.ld x9, 240(x14)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x9, 0x0400000000000000)

    # Testcase 258:  imm:0x0, result rd:x10(0x0800000000000000)
    la  x13, test_data
    addi    x13, x13,1008
    li     x2, MASK_XLEN(0)
    add    x13, x13, x2
    c.ld x10, 0(x13)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x10, 0x0800000000000000)

    # Testcase 259:  imm:0x80, result rd:x11(0x1000000000000000)
    la  x12, test_data
    addi    x12, x12,1016
    li     x2, MASK_XLEN(-128)
    add    x12, x12, x2
    c.ld x11, 128(x12)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x11, 0x1000000000000000)



	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")



    # Addresses for test data and results
    la x1, test_53_res

    # Testcase 260:  imm:0x40, result rd:x12(0x2000000000000000)
    la  x11, test_data
    addi    x11, x11,1024
    li     x2, MASK_XLEN(-64)
    add    x11, x11, x2
    c.ld x12, 64(x11)
    sd x12, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x12, 0x2000000000000000)

    # Testcase 261:  imm:0x20, result rd:x13(0x4000000000000000)
    la  x10, test_data
    addi    x10, x10,1032
    li     x2, MASK_XLEN(-32)
    add    x10, x10, x2
    c.ld x13, 32(x10)
    sd x13, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x13, 0x4000000000000000)

    # Testcase 262:  imm:0x10, result rd:x14(0x8000000000000000)
    la  x9, test_data
    addi    x9, x9,1040
    li     x2, MASK_XLEN(-16)
    add    x9, x9, x2
    c.ld x14, 16(x9)
    sd x14, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x3, x14, 0x8000000000000000)

    # Testcase 263:  imm:0x8, result rd:x15(0x0000000000000000)
    la  x8, test_data
    addi    x8, x8,1048
    li     x2, MASK_XLEN(-8)
    add    x8, x8, x2
    c.ld x15, 8(x8)
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

	.dword 0xfffffffffffffffe
	.dword 0xfffffffffffffffd
	.dword 0xfffffffffffffffb
	.dword 0xfffffffffffffff7
	.dword 0xffffffffffffffef
	.dword 0xffffffffffffffdf
	.dword 0xffffffffffffffbf
	.dword 0xffffffffffffff7f
	.dword 0xfffffffffffffeff
	.dword 0xfffffffffffffdff
	.dword 0xfffffffffffffeff
	.dword 0xfffffffffffff7ff
	.dword 0xffffffffffffefff
	.dword 0xffffffffffffdfff
	.dword 0xffffffffffffefff
	.dword 0xffffffffffff7fff
	.dword 0xfffffffffffeffff
	.dword 0xfffffffffffdffff
	.dword 0xfffffffffffbffff
	.dword 0xfffffffffff7ffff
	.dword 0xffffffffffefffff
	.dword 0xffffffffffdfffff
	.dword 0xffffffffffbfffff
	.dword 0xffffffffff7fffff
	.dword 0xfffffffffeffffff
	.dword 0xfffffffffdffffff
	.dword 0xfffffffffeffffff
	.dword 0xfffffffff7ffffff
	.dword 0xffffffffefffffff
	.dword 0xffffffffdfffffff
	.dword 0xffffffffefffffff
	.dword 0xffffffff7fffffff
	.dword 0xffffffffffffffff
	.dword 0xfffffffeffffffff
	.dword 0xfffffffdffffffff
	.dword 0xfffffffbffffffff
	.dword 0xfffffff7ffffffff
	.dword 0xffffffefffffffff
	.dword 0xffffffdfffffffff
	.dword 0xffffffbfffffffff
	.dword 0xffffff7fffffffff
	.dword 0xfffffeffffffffff
	.dword 0xfffffdffffffffff
	.dword 0xfffffeffffffffff
	.dword 0xfffff7ffffffffff
	.dword 0xffffefffffffffff
	.dword 0xffffdfffffffffff
	.dword 0xffffefffffffffff
	.dword 0xffff7fffffffffff
	.dword 0xfffeffffffffffff
	.dword 0xfffdffffffffffff
	.dword 0xfffbffffffffffff
	.dword 0xfff7ffffffffffff
	.dword 0xffefffffffffffff
	.dword 0xffdfffffffffffff
	.dword 0xffbfffffffffffff
	.dword 0xff7fffffffffffff
	.dword 0xfeffffffffffffff
	.dword 0xfdffffffffffffff
	.dword 0xfeffffffffffffff
	.dword 0xf7ffffffffffffff
	.dword 0xefffffffffffffff
	.dword 0xdfffffffffffffff
	.dword 0xefffffffffffffff
	.dword 0x7fffffffffffffff
	.dword 0xffffffffffffffff
	.dword 0x0000000000000001
	.dword 0x0000000000000002
	.dword 0x0000000000000004
	.dword 0x0000000000000008
	.dword 0x0000000000000010
	.dword 0x0000000000000020
	.dword 0x0000000000000040
	.dword 0x0000000000000080
	.dword 0x0000000000000100
	.dword 0x0000000000000200
	.dword 0x0000000000000400
	.dword 0x0000000000000800
	.dword 0x0000000000001000
	.dword 0x0000000000002000
	.dword 0x0000000000004000
	.dword 0x0000000000008000
	.dword 0x0000000000010000
	.dword 0x0000000000020000
	.dword 0x0000000000040000
	.dword 0x0000000000080000
	.dword 0x0000000000100000
	.dword 0x0000000000200000
	.dword 0x0000000000400000
	.dword 0x0000000000800000
	.dword 0x0000000001000000
	.dword 0x0000000002000000
	.dword 0x0000000004000000
	.dword 0x0000000008000000
	.dword 0x0000000010000000
	.dword 0x0000000020000000
	.dword 0x0000000040000000
	.dword 0x0000000080000000
	.dword 0x0000000000000000
	.dword 0x0000000100000000
	.dword 0x0000000200000000
	.dword 0x0000000400000000
	.dword 0x0000000800000000
	.dword 0x0000001000000000
	.dword 0x0000002000000000
	.dword 0x0000004000000000
	.dword 0x0000008000000000
	.dword 0x0000010000000000
	.dword 0x0000020000000000
	.dword 0x0000040000000000
	.dword 0x0000080000000000
	.dword 0x0000100000000000
	.dword 0x0000200000000000
	.dword 0x0000400000000000
	.dword 0x0000800000000000
	.dword 0x0001000000000000
	.dword 0x0002000000000000
	.dword 0x0004000000000000
	.dword 0x0008000000000000
	.dword 0x0010000000000000
	.dword 0x0020000000000000
	.dword 0x0040000000000000
	.dword 0x0080000000000000
	.dword 0x0100000000000000
	.dword 0x0200000000000000
	.dword 0x0400000000000000
	.dword 0x0800000000000000
	.dword 0x1000000000000000
	.dword 0x2000000000000000
	.dword 0x4000000000000000
	.dword 0x8000000000000000
	.dword 0x0000000000000000


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

