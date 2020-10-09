# RISC-V Compliance Test I-C-LDSP-01
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
# Description: Testing instruction 'c.ldsp'.

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

    # Testcase 0:  imm:0xf8, result rd:x1(0xfffffffffffffffe)
    la  x2, test_data
    addi    x2, x2,0
    li     x7, MASK_XLEN(-248)
    add    x2, x2, x7
    c.ldsp x1, 248(x2)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xfffffffffffffffe)

    # Testcase 1:  imm:0x78, result rd:x2(0xfffffffffffffffd)
    la  x2, test_data
    addi    x2, x2,8
    li     x7, MASK_XLEN(-120)
    add    x2, x2, x7
    c.ldsp x2, 120(x2)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0xfffffffffffffffd)

    # Testcase 2:  imm:0xb8, result rd:x3(0xfffffffffffffffb)
    la  x2, test_data
    addi    x2, x2,16
    li     x7, MASK_XLEN(-184)
    add    x2, x2, x7
    c.ldsp x3, 184(x2)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0xfffffffffffffffb)

    # Testcase 3:  imm:0xd8, result rd:x4(0xfffffffffffffff7)
    la  x2, test_data
    addi    x2, x2,24
    li     x7, MASK_XLEN(-216)
    add    x2, x2, x7
    c.ldsp x4, 216(x2)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0xfffffffffffffff7)

    # Testcase 4:  imm:0xe8, result rd:x5(0xffffffffffffffef)
    la  x2, test_data
    addi    x2, x2,32
    li     x7, MASK_XLEN(-232)
    add    x2, x2, x7
    c.ldsp x5, 232(x2)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0xffffffffffffffef)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 2\n")



    # Addresses for test data and results
    la x1, test_2_res

    # Testcase 5:  imm:0xf0, result rd:x6(0xffffffffffffffdf)
    la  x2, test_data
    addi    x2, x2,40
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x6, 240(x2)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0xffffffffffffffdf)

    # Testcase 6:  imm:0x0, result rd:x7(0xffffffffffffffbf)
    la  x2, test_data
    addi    x2, x2,48
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.ldsp x7, 0(x2)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0xffffffffffffffbf)

    # Testcase 7:  imm:0x80, result rd:x8(0xffffffffffffff7f)
    la  x2, test_data
    addi    x2, x2,56
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x8, 128(x2)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0xffffffffffffff7f)

    # Testcase 8:  imm:0x40, result rd:x9(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,64
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x9, 64(x2)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0xfffffffffffffeff)

    # Testcase 9:  imm:0x20, result rd:x10(0xfffffffffffffdff)
    la  x2, test_data
    addi    x2, x2,72
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x10, 32(x2)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xfffffffffffffdff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 3\n")



    # Addresses for test data and results
    la x7, test_3_res

    # Testcase 10:  imm:0x10, result rd:x11(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,80
    li     x8, MASK_XLEN(-16)
    add    x2, x2, x8
    c.ldsp x11, 16(x2)
    sd x11, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x11, 0xfffffffffffffeff)

    # Testcase 11:  imm:0x8, result rd:x12(0xfffffffffffff7ff)
    la  x2, test_data
    addi    x2, x2,88
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    c.ldsp x12, 8(x2)
    sd x12, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x12, 0xfffffffffffff7ff)

    # Testcase 12:  imm:0xf8, result rd:x13(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,96
    li     x8, MASK_XLEN(-248)
    add    x2, x2, x8
    c.ldsp x13, 248(x2)
    sd x13, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x13, 0xffffffffffffefff)

    # Testcase 13:  imm:0x78, result rd:x14(0xffffffffffffdfff)
    la  x2, test_data
    addi    x2, x2,104
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    c.ldsp x14, 120(x2)
    sd x14, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x14, 0xffffffffffffdfff)

    # Testcase 14:  imm:0xb8, result rd:x15(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,112
    li     x8, MASK_XLEN(-184)
    add    x2, x2, x8
    c.ldsp x15, 184(x2)
    sd x15, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xffffffffffffefff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 4\n")



    # Addresses for test data and results
    la x3, test_4_res

    # Testcase 15:  imm:0xd8, result rd:x16(0xffffffffffff7fff)
    la  x2, test_data
    addi    x2, x2,120
    li     x4, MASK_XLEN(-216)
    add    x2, x2, x4
    c.ldsp x16, 216(x2)
    sd x16, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffffffffffff7fff)

    # Testcase 16:  imm:0xe8, result rd:x17(0xfffffffffffeffff)
    la  x2, test_data
    addi    x2, x2,128
    li     x4, MASK_XLEN(-232)
    add    x2, x2, x4
    c.ldsp x17, 232(x2)
    sd x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xfffffffffffeffff)

    # Testcase 17:  imm:0xf0, result rd:x18(0xfffffffffffdffff)
    la  x2, test_data
    addi    x2, x2,136
    li     x4, MASK_XLEN(-240)
    add    x2, x2, x4
    c.ldsp x18, 240(x2)
    sd x18, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xfffffffffffdffff)

    # Testcase 18:  imm:0x0, result rd:x19(0xfffffffffffbffff)
    la  x2, test_data
    addi    x2, x2,144
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    c.ldsp x19, 0(x2)
    sd x19, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0xfffffffffffbffff)

    # Testcase 19:  imm:0x80, result rd:x20(0xfffffffffff7ffff)
    la  x2, test_data
    addi    x2, x2,152
    li     x4, MASK_XLEN(-128)
    add    x2, x2, x4
    c.ldsp x20, 128(x2)
    sd x20, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x20, 0xfffffffffff7ffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 5\n")



    # Addresses for test data and results
    la x1, test_5_res

    # Testcase 20:  imm:0x40, result rd:x21(0xffffffffffefffff)
    la  x2, test_data
    addi    x2, x2,160
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x21, 64(x2)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0xffffffffffefffff)

    # Testcase 21:  imm:0x20, result rd:x22(0xffffffffffdfffff)
    la  x2, test_data
    addi    x2, x2,168
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x22, 32(x2)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0xffffffffffdfffff)

    # Testcase 22:  imm:0x10, result rd:x23(0xffffffffffbfffff)
    la  x2, test_data
    addi    x2, x2,176
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x23, 16(x2)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0xffffffffffbfffff)

    # Testcase 23:  imm:0x8, result rd:x24(0xffffffffff7fffff)
    la  x2, test_data
    addi    x2, x2,184
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x24, 8(x2)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0xffffffffff7fffff)

    # Testcase 24:  imm:0xf8, result rd:x25(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,192
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    c.ldsp x25, 248(x2)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0xfffffffffeffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 6\n")



    # Addresses for test data and results
    la x1, test_6_res

    # Testcase 25:  imm:0x78, result rd:x26(0xfffffffffdffffff)
    la  x2, test_data
    addi    x2, x2,200
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x26, 120(x2)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0xfffffffffdffffff)

    # Testcase 26:  imm:0xb8, result rd:x27(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,208
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x27, 184(x2)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0xfffffffffeffffff)

    # Testcase 27:  imm:0xd8, result rd:x28(0xfffffffff7ffffff)
    la  x2, test_data
    addi    x2, x2,216
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    c.ldsp x28, 216(x2)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0xfffffffff7ffffff)

    # Testcase 28:  imm:0xe8, result rd:x29(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,224
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x29, 232(x2)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0xffffffffefffffff)

    # Testcase 29:  imm:0xf0, result rd:x30(0xffffffffdfffffff)
    la  x2, test_data
    addi    x2, x2,232
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x30, 240(x2)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x30, 0xffffffffdfffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 7\n")



    # Addresses for test data and results
    la x5, test_7_res

    # Testcase 30:  imm:0x0, result rd:x31(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,240
    li     x6, MASK_XLEN(0)
    add    x2, x2, x6
    c.ldsp x31, 0(x2)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0xffffffffefffffff)

    # Testcase 31:  imm:0x80, result rd:x1(0xffffffff7fffffff)
    la  x2, test_data
    addi    x2, x2,248
    li     x6, MASK_XLEN(-128)
    add    x2, x2, x6
    c.ldsp x1, 128(x2)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xffffffff7fffffff)

    # Testcase 32:  imm:0x40, result rd:x2(0xffffffffffffffff)
    la  x2, test_data
    addi    x2, x2,256
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    c.ldsp x2, 64(x2)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xffffffffffffffff)

    # Testcase 33:  imm:0x20, result rd:x3(0xfffffffeffffffff)
    la  x2, test_data
    addi    x2, x2,264
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    c.ldsp x3, 32(x2)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xfffffffeffffffff)

    # Testcase 34:  imm:0x10, result rd:x4(0xfffffffdffffffff)
    la  x2, test_data
    addi    x2, x2,272
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    c.ldsp x4, 16(x2)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xfffffffdffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 8\n")



    # Addresses for test data and results
    la x1, test_8_res

    # Testcase 35:  imm:0x8, result rd:x5(0xfffffffbffffffff)
    la  x2, test_data
    addi    x2, x2,280
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x5, 8(x2)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xfffffffbffffffff)

    # Testcase 36:  imm:0xf8, result rd:x6(0xfffffff7ffffffff)
    la  x2, test_data
    addi    x2, x2,288
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    c.ldsp x6, 248(x2)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0xfffffff7ffffffff)

    # Testcase 37:  imm:0x78, result rd:x7(0xffffffefffffffff)
    la  x2, test_data
    addi    x2, x2,296
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x7, 120(x2)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0xffffffefffffffff)

    # Testcase 38:  imm:0xb8, result rd:x8(0xffffffdfffffffff)
    la  x2, test_data
    addi    x2, x2,304
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x8, 184(x2)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0xffffffdfffffffff)

    # Testcase 39:  imm:0xd8, result rd:x9(0xffffffbfffffffff)
    la  x2, test_data
    addi    x2, x2,312
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    c.ldsp x9, 216(x2)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0xffffffbfffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 9\n")



    # Addresses for test data and results
    la x1, test_9_res

    # Testcase 40:  imm:0xe8, result rd:x10(0xffffff7fffffffff)
    la  x2, test_data
    addi    x2, x2,320
    li     x8, MASK_XLEN(-232)
    add    x2, x2, x8
    c.ldsp x10, 232(x2)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xffffff7fffffffff)

    # Testcase 41:  imm:0xf0, result rd:x11(0xfffffeffffffffff)
    la  x2, test_data
    addi    x2, x2,328
    li     x8, MASK_XLEN(-240)
    add    x2, x2, x8
    c.ldsp x11, 240(x2)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x11, 0xfffffeffffffffff)

    # Testcase 42:  imm:0x0, result rd:x12(0xfffffdffffffffff)
    la  x2, test_data
    addi    x2, x2,336
    li     x8, MASK_XLEN(0)
    add    x2, x2, x8
    c.ldsp x12, 0(x2)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x12, 0xfffffdffffffffff)

    # Testcase 43:  imm:0x80, result rd:x13(0xfffffeffffffffff)
    la  x2, test_data
    addi    x2, x2,344
    li     x8, MASK_XLEN(-128)
    add    x2, x2, x8
    c.ldsp x13, 128(x2)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x13, 0xfffffeffffffffff)

    # Testcase 44:  imm:0x40, result rd:x14(0xfffff7ffffffffff)
    la  x2, test_data
    addi    x2, x2,352
    li     x8, MASK_XLEN(-64)
    add    x2, x2, x8
    c.ldsp x14, 64(x2)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x14, 0xfffff7ffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 10\n")



    # Addresses for test data and results
    la x3, test_10_res

    # Testcase 45:  imm:0x20, result rd:x15(0xffffefffffffffff)
    la  x2, test_data
    addi    x2, x2,360
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    c.ldsp x15, 32(x2)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0xffffefffffffffff)

    # Testcase 46:  imm:0x10, result rd:x16(0xffffdfffffffffff)
    la  x2, test_data
    addi    x2, x2,368
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    c.ldsp x16, 16(x2)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffffdfffffffffff)

    # Testcase 47:  imm:0x8, result rd:x17(0xffffefffffffffff)
    la  x2, test_data
    addi    x2, x2,376
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    c.ldsp x17, 8(x2)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xffffefffffffffff)

    # Testcase 48:  imm:0xf8, result rd:x18(0xffff7fffffffffff)
    la  x2, test_data
    addi    x2, x2,384
    li     x4, MASK_XLEN(-248)
    add    x2, x2, x4
    c.ldsp x18, 248(x2)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xffff7fffffffffff)

    # Testcase 49:  imm:0x78, result rd:x19(0xfffeffffffffffff)
    la  x2, test_data
    addi    x2, x2,392
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    c.ldsp x19, 120(x2)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0xfffeffffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 11\n")



    # Addresses for test data and results
    la x1, test_11_res

    # Testcase 50:  imm:0xb8, result rd:x20(0xfffdffffffffffff)
    la  x2, test_data
    addi    x2, x2,400
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x20, 184(x2)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0xfffdffffffffffff)

    # Testcase 51:  imm:0xd8, result rd:x21(0xfffbffffffffffff)
    la  x2, test_data
    addi    x2, x2,408
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    c.ldsp x21, 216(x2)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0xfffbffffffffffff)

    # Testcase 52:  imm:0xe8, result rd:x22(0xfff7ffffffffffff)
    la  x2, test_data
    addi    x2, x2,416
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x22, 232(x2)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0xfff7ffffffffffff)

    # Testcase 53:  imm:0xf0, result rd:x23(0xffefffffffffffff)
    la  x2, test_data
    addi    x2, x2,424
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x23, 240(x2)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0xffefffffffffffff)

    # Testcase 54:  imm:0x0, result rd:x24(0xffdfffffffffffff)
    la  x2, test_data
    addi    x2, x2,432
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.ldsp x24, 0(x2)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0xffdfffffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 12\n")



    # Addresses for test data and results
    la x1, test_12_res

    # Testcase 55:  imm:0x80, result rd:x25(0xffbfffffffffffff)
    la  x2, test_data
    addi    x2, x2,440
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x25, 128(x2)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0xffbfffffffffffff)

    # Testcase 56:  imm:0x40, result rd:x26(0xff7fffffffffffff)
    la  x2, test_data
    addi    x2, x2,448
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x26, 64(x2)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0xff7fffffffffffff)

    # Testcase 57:  imm:0x20, result rd:x27(0xfeffffffffffffff)
    la  x2, test_data
    addi    x2, x2,456
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x27, 32(x2)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0xfeffffffffffffff)

    # Testcase 58:  imm:0x10, result rd:x28(0xfdffffffffffffff)
    la  x2, test_data
    addi    x2, x2,464
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x28, 16(x2)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0xfdffffffffffffff)

    # Testcase 59:  imm:0x8, result rd:x29(0xfeffffffffffffff)
    la  x2, test_data
    addi    x2, x2,472
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x29, 8(x2)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0xfeffffffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 13\n")



    # Addresses for test data and results
    la x4, test_13_res

    # Testcase 60:  imm:0xf8, result rd:x30(0xf7ffffffffffffff)
    la  x2, test_data
    addi    x2, x2,480
    li     x5, MASK_XLEN(-248)
    add    x2, x2, x5
    c.ldsp x30, 248(x2)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0xf7ffffffffffffff)

    # Testcase 61:  imm:0x78, result rd:x31(0xefffffffffffffff)
    la  x2, test_data
    addi    x2, x2,488
    li     x5, MASK_XLEN(-120)
    add    x2, x2, x5
    c.ldsp x31, 120(x2)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0xefffffffffffffff)

    # Testcase 62:  imm:0xb8, result rd:x1(0xdfffffffffffffff)
    la  x2, test_data
    addi    x2, x2,496
    li     x5, MASK_XLEN(-184)
    add    x2, x2, x5
    c.ldsp x1, 184(x2)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0xdfffffffffffffff)

    # Testcase 63:  imm:0xd8, result rd:x2(0xefffffffffffffff)
    la  x2, test_data
    addi    x2, x2,504
    li     x5, MASK_XLEN(-216)
    add    x2, x2, x5
    c.ldsp x2, 216(x2)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0xefffffffffffffff)

    # Testcase 64:  imm:0xe8, result rd:x3(0x7fffffffffffffff)
    la  x2, test_data
    addi    x2, x2,512
    li     x5, MASK_XLEN(-232)
    add    x2, x2, x5
    c.ldsp x3, 232(x2)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x7fffffffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 14\n")



    # Addresses for test data and results
    la x1, test_14_res

    # Testcase 65:  imm:0xf0, result rd:x4(0xffffffffffffffff)
    la  x2, test_data
    addi    x2, x2,520
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x4, 240(x2)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x4, 0xffffffffffffffff)

    # Testcase 66:  imm:0x0, result rd:x5(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,528
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.ldsp x5, 0(x2)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x5, 0x0000000000000001)

    # Testcase 67:  imm:0x80, result rd:x6(0x0000000000000002)
    la  x2, test_data
    addi    x2, x2,536
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x6, 128(x2)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x6, 0x0000000000000002)

    # Testcase 68:  imm:0x40, result rd:x7(0x0000000000000004)
    la  x2, test_data
    addi    x2, x2,544
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x7, 64(x2)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x7, 0x0000000000000004)

    # Testcase 69:  imm:0x20, result rd:x8(0x0000000000000008)
    la  x2, test_data
    addi    x2, x2,552
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x8, 32(x2)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x8, 0x0000000000000008)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 15\n")



    # Addresses for test data and results
    la x1, test_15_res

    # Testcase 70:  imm:0x10, result rd:x9(0x0000000000000010)
    la  x2, test_data
    addi    x2, x2,560
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x9, 16(x2)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x9, 0x0000000000000010)

    # Testcase 71:  imm:0x8, result rd:x10(0x0000000000000020)
    la  x2, test_data
    addi    x2, x2,568
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x10, 8(x2)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x10, 0x0000000000000020)

    # Testcase 72:  imm:0xf8, result rd:x11(0x0000000000000040)
    la  x2, test_data
    addi    x2, x2,576
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    c.ldsp x11, 248(x2)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x11, 0x0000000000000040)

    # Testcase 73:  imm:0x78, result rd:x12(0x0000000000000080)
    la  x2, test_data
    addi    x2, x2,584
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x12, 120(x2)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x12, 0x0000000000000080)

    # Testcase 74:  imm:0xb8, result rd:x13(0x0000000000000100)
    la  x2, test_data
    addi    x2, x2,592
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x13, 184(x2)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x13, 0x0000000000000100)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 16\n")



    # Addresses for test data and results
    la x4, test_16_res

    # Testcase 75:  imm:0xd8, result rd:x14(0x0000000000000200)
    la  x2, test_data
    addi    x2, x2,600
    li     x5, MASK_XLEN(-216)
    add    x2, x2, x5
    c.ldsp x14, 216(x2)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x0000000000000200)

    # Testcase 76:  imm:0xe8, result rd:x15(0x0000000000000400)
    la  x2, test_data
    addi    x2, x2,608
    li     x5, MASK_XLEN(-232)
    add    x2, x2, x5
    c.ldsp x15, 232(x2)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x0000000000000400)

    # Testcase 77:  imm:0xf0, result rd:x16(0x0000000000000800)
    la  x2, test_data
    addi    x2, x2,616
    li     x5, MASK_XLEN(-240)
    add    x2, x2, x5
    c.ldsp x16, 240(x2)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x0000000000000800)

    # Testcase 78:  imm:0x0, result rd:x17(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,624
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    c.ldsp x17, 0(x2)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x0000000000001000)

    # Testcase 79:  imm:0x80, result rd:x18(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,632
    li     x5, MASK_XLEN(-128)
    add    x2, x2, x5
    c.ldsp x18, 128(x2)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x18, 0x0000000000002000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 17\n")



    # Addresses for test data and results
    la x1, test_17_res

    # Testcase 80:  imm:0x40, result rd:x19(0x0000000000004000)
    la  x2, test_data
    addi    x2, x2,640
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x19, 64(x2)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0000000000004000)

    # Testcase 81:  imm:0x20, result rd:x20(0x0000000000008000)
    la  x2, test_data
    addi    x2, x2,648
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x20, 32(x2)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x0000000000008000)

    # Testcase 82:  imm:0x10, result rd:x21(0x0000000000010000)
    la  x2, test_data
    addi    x2, x2,656
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x21, 16(x2)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0x0000000000010000)

    # Testcase 83:  imm:0x8, result rd:x22(0x0000000000020000)
    la  x2, test_data
    addi    x2, x2,664
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x22, 8(x2)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0x0000000000020000)

    # Testcase 84:  imm:0xf8, result rd:x23(0x0000000000040000)
    la  x2, test_data
    addi    x2, x2,672
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    c.ldsp x23, 248(x2)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0x0000000000040000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 18\n")



    # Addresses for test data and results
    la x1, test_18_res

    # Testcase 85:  imm:0x78, result rd:x24(0x0000000000080000)
    la  x2, test_data
    addi    x2, x2,680
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x24, 120(x2)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0x0000000000080000)

    # Testcase 86:  imm:0xb8, result rd:x25(0x0000000000100000)
    la  x2, test_data
    addi    x2, x2,688
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x25, 184(x2)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0x0000000000100000)

    # Testcase 87:  imm:0xd8, result rd:x26(0x0000000000200000)
    la  x2, test_data
    addi    x2, x2,696
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    c.ldsp x26, 216(x2)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0x0000000000200000)

    # Testcase 88:  imm:0xe8, result rd:x27(0x0000000000400000)
    la  x2, test_data
    addi    x2, x2,704
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x27, 232(x2)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0x0000000000400000)

    # Testcase 89:  imm:0xf0, result rd:x28(0x0000000000800000)
    la  x2, test_data
    addi    x2, x2,712
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x28, 240(x2)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0x0000000000800000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 19\n")



    # Addresses for test data and results
    la x3, test_19_res

    # Testcase 90:  imm:0x0, result rd:x29(0x0000000001000000)
    la  x2, test_data
    addi    x2, x2,720
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    c.ldsp x29, 0(x2)
    sd x29, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x0000000001000000)

    # Testcase 91:  imm:0x80, result rd:x30(0x0000000002000000)
    la  x2, test_data
    addi    x2, x2,728
    li     x4, MASK_XLEN(-128)
    add    x2, x2, x4
    c.ldsp x30, 128(x2)
    sd x30, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0000000002000000)

    # Testcase 92:  imm:0x40, result rd:x31(0x0000000004000000)
    la  x2, test_data
    addi    x2, x2,736
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    c.ldsp x31, 64(x2)
    sd x31, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0000000004000000)

    # Testcase 93:  imm:0x20, result rd:x1(0x0000000008000000)
    la  x2, test_data
    addi    x2, x2,744
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    c.ldsp x1, 32(x2)
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0000000008000000)

    # Testcase 94:  imm:0x10, result rd:x2(0x0000000010000000)
    la  x2, test_data
    addi    x2, x2,752
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    c.ldsp x2, 16(x2)
    sd x2, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0000000010000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 20\n")



    # Addresses for test data and results
    la x1, test_20_res

    # Testcase 95:  imm:0x8, result rd:x3(0x0000000020000000)
    la  x2, test_data
    addi    x2, x2,760
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    c.ldsp x3, 8(x2)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x3, 0x0000000020000000)

    # Testcase 96:  imm:0xf8, result rd:x4(0x0000000040000000)
    la  x2, test_data
    addi    x2, x2,768
    li     x8, MASK_XLEN(-248)
    add    x2, x2, x8
    c.ldsp x4, 248(x2)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x4, 0x0000000040000000)

    # Testcase 97:  imm:0x78, result rd:x5(0x0000000080000000)
    la  x2, test_data
    addi    x2, x2,776
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    c.ldsp x5, 120(x2)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x5, 0x0000000080000000)

    # Testcase 98:  imm:0xb8, result rd:x6(0x0000000000000000)
    la  x2, test_data
    addi    x2, x2,784
    li     x8, MASK_XLEN(-184)
    add    x2, x2, x8
    c.ldsp x6, 184(x2)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x6, 0x0000000000000000)

    # Testcase 99:  imm:0xd8, result rd:x7(0x0000000100000000)
    la  x2, test_data
    addi    x2, x2,792
    li     x8, MASK_XLEN(-216)
    add    x2, x2, x8
    c.ldsp x7, 216(x2)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x7, 0x0000000100000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 21\n")



    # Addresses for test data and results
    la x1, test_21_res

    # Testcase 100:  imm:0xe8, result rd:x8(0x0000000200000000)
    la  x2, test_data
    addi    x2, x2,800
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x8, 232(x2)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x0000000200000000)

    # Testcase 101:  imm:0xf0, result rd:x9(0x0000000400000000)
    la  x2, test_data
    addi    x2, x2,808
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x9, 240(x2)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0x0000000400000000)

    # Testcase 102:  imm:0x0, result rd:x10(0x0000000800000000)
    la  x2, test_data
    addi    x2, x2,816
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.ldsp x10, 0(x2)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0x0000000800000000)

    # Testcase 103:  imm:0x80, result rd:x11(0x0000001000000000)
    la  x2, test_data
    addi    x2, x2,824
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x11, 128(x2)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x11, 0x0000001000000000)

    # Testcase 104:  imm:0x40, result rd:x12(0x0000002000000000)
    la  x2, test_data
    addi    x2, x2,832
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x12, 64(x2)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x12, 0x0000002000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 22\n")



    # Addresses for test data and results
    la x5, test_22_res

    # Testcase 105:  imm:0x20, result rd:x13(0x0000004000000000)
    la  x2, test_data
    addi    x2, x2,840
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    c.ldsp x13, 32(x2)
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x0000004000000000)

    # Testcase 106:  imm:0x10, result rd:x14(0x0000008000000000)
    la  x2, test_data
    addi    x2, x2,848
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    c.ldsp x14, 16(x2)
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x0000008000000000)

    # Testcase 107:  imm:0x8, result rd:x15(0x0000010000000000)
    la  x2, test_data
    addi    x2, x2,856
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    c.ldsp x15, 8(x2)
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x0000010000000000)

    # Testcase 108:  imm:0xf8, result rd:x16(0x0000020000000000)
    la  x2, test_data
    addi    x2, x2,864
    li     x6, MASK_XLEN(-248)
    add    x2, x2, x6
    c.ldsp x16, 248(x2)
    sd x16, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x16, 0x0000020000000000)

    # Testcase 109:  imm:0x78, result rd:x17(0x0000040000000000)
    la  x2, test_data
    addi    x2, x2,872
    li     x6, MASK_XLEN(-120)
    add    x2, x2, x6
    c.ldsp x17, 120(x2)
    sd x17, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x17, 0x0000040000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 23\n")



    # Addresses for test data and results
    la x1, test_23_res

    # Testcase 110:  imm:0xb8, result rd:x18(0x0000080000000000)
    la  x2, test_data
    addi    x2, x2,880
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x18, 184(x2)
    sd x18, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0x0000080000000000)

    # Testcase 111:  imm:0xd8, result rd:x19(0x0000100000000000)
    la  x2, test_data
    addi    x2, x2,888
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    c.ldsp x19, 216(x2)
    sd x19, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0000100000000000)

    # Testcase 112:  imm:0xe8, result rd:x20(0x0000200000000000)
    la  x2, test_data
    addi    x2, x2,896
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x20, 232(x2)
    sd x20, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x0000200000000000)

    # Testcase 113:  imm:0xf0, result rd:x21(0x0000400000000000)
    la  x2, test_data
    addi    x2, x2,904
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x21, 240(x2)
    sd x21, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0x0000400000000000)

    # Testcase 114:  imm:0x0, result rd:x22(0x0000800000000000)
    la  x2, test_data
    addi    x2, x2,912
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.ldsp x22, 0(x2)
    sd x22, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0x0000800000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 24\n")



    # Addresses for test data and results
    la x1, test_24_res

    # Testcase 115:  imm:0x80, result rd:x23(0x0001000000000000)
    la  x2, test_data
    addi    x2, x2,920
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x23, 128(x2)
    sd x23, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0x0001000000000000)

    # Testcase 116:  imm:0x40, result rd:x24(0x0002000000000000)
    la  x2, test_data
    addi    x2, x2,928
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x24, 64(x2)
    sd x24, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0x0002000000000000)

    # Testcase 117:  imm:0x20, result rd:x25(0x0004000000000000)
    la  x2, test_data
    addi    x2, x2,936
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x25, 32(x2)
    sd x25, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0x0004000000000000)

    # Testcase 118:  imm:0x10, result rd:x26(0x0008000000000000)
    la  x2, test_data
    addi    x2, x2,944
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x26, 16(x2)
    sd x26, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0x0008000000000000)

    # Testcase 119:  imm:0x8, result rd:x27(0x0010000000000000)
    la  x2, test_data
    addi    x2, x2,952
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x27, 8(x2)
    sd x27, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0x0010000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 25\n")



    # Addresses for test data and results
    la x3, test_25_res

    # Testcase 120:  imm:0xf8, result rd:x28(0x0020000000000000)
    la  x2, test_data
    addi    x2, x2,960
    li     x4, MASK_XLEN(-248)
    add    x2, x2, x4
    c.ldsp x28, 248(x2)
    sd x28, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x28, 0x0020000000000000)

    # Testcase 121:  imm:0x78, result rd:x29(0x0040000000000000)
    la  x2, test_data
    addi    x2, x2,968
    li     x4, MASK_XLEN(-120)
    add    x2, x2, x4
    c.ldsp x29, 120(x2)
    sd x29, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x0040000000000000)

    # Testcase 122:  imm:0xb8, result rd:x30(0x0080000000000000)
    la  x2, test_data
    addi    x2, x2,976
    li     x4, MASK_XLEN(-184)
    add    x2, x2, x4
    c.ldsp x30, 184(x2)
    sd x30, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0080000000000000)

    # Testcase 123:  imm:0xd8, result rd:x31(0x0100000000000000)
    la  x2, test_data
    addi    x2, x2,984
    li     x4, MASK_XLEN(-216)
    add    x2, x2, x4
    c.ldsp x31, 216(x2)
    sd x31, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0100000000000000)

    # Testcase 124:  imm:0xe8, result rd:x1(0x0200000000000000)
    la  x2, test_data
    addi    x2, x2,992
    li     x4, MASK_XLEN(-232)
    add    x2, x2, x4
    c.ldsp x1, 232(x2)
    sd x1, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0200000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 26\n")



    # Addresses for test data and results
    la x1, test_26_res

    # Testcase 125:  imm:0xf0, result rd:x2(0x0400000000000000)
    la  x2, test_data
    addi    x2, x2,1000
    li     x7, MASK_XLEN(-240)
    add    x2, x2, x7
    c.ldsp x2, 240(x2)
    sd x2, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0x0400000000000000)

    # Testcase 126:  imm:0x0, result rd:x3(0x0800000000000000)
    la  x2, test_data
    addi    x2, x2,1008
    li     x7, MASK_XLEN(0)
    add    x2, x2, x7
    c.ldsp x3, 0(x2)
    sd x3, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0x0800000000000000)

    # Testcase 127:  imm:0x80, result rd:x4(0x1000000000000000)
    la  x2, test_data
    addi    x2, x2,1016
    li     x7, MASK_XLEN(-128)
    add    x2, x2, x7
    c.ldsp x4, 128(x2)
    sd x4, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0x1000000000000000)

    # Testcase 128:  imm:0x40, result rd:x5(0x2000000000000000)
    la  x2, test_data
    addi    x2, x2,1024
    li     x7, MASK_XLEN(-64)
    add    x2, x2, x7
    c.ldsp x5, 64(x2)
    sd x5, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0x2000000000000000)

    # Testcase 129:  imm:0x20, result rd:x6(0x4000000000000000)
    la  x2, test_data
    addi    x2, x2,1032
    li     x7, MASK_XLEN(-32)
    add    x2, x2, x7
    c.ldsp x6, 32(x2)
    sd x6, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x6, 0x4000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 27\n")



    # Addresses for test data and results
    la x1, test_27_res

    # Testcase 130:  imm:0x10, result rd:x7(0x8000000000000000)
    la  x2, test_data
    addi    x2, x2,1040
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x7, 16(x2)
    sd x7, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0x8000000000000000)

    # Testcase 131:  imm:0x8, result rd:x8(0x0000000000000000)
    la  x2, test_data
    addi    x2, x2,1048
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x8, 8(x2)
    sd x8, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x0000000000000000)

    # Testcase 132:  imm:0xf8, result rd:x9(0xfffffffffffffffe)
    la  x2, test_data
    addi    x2, x2,0
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    c.ldsp x9, 248(x2)
    sd x9, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0xfffffffffffffffe)

    # Testcase 133:  imm:0x78, result rd:x10(0xfffffffffffffffd)
    la  x2, test_data
    addi    x2, x2,8
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x10, 120(x2)
    sd x10, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xfffffffffffffffd)

    # Testcase 134:  imm:0xb8, result rd:x11(0xfffffffffffffffb)
    la  x2, test_data
    addi    x2, x2,16
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x11, 184(x2)
    sd x11, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x11, 0xfffffffffffffffb)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 28\n")



    # Addresses for test data and results
    la x6, test_28_res

    # Testcase 135:  imm:0xd8, result rd:x12(0xfffffffffffffff7)
    la  x2, test_data
    addi    x2, x2,24
    li     x7, MASK_XLEN(-216)
    add    x2, x2, x7
    c.ldsp x12, 216(x2)
    sd x12, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x12, 0xfffffffffffffff7)

    # Testcase 136:  imm:0xe8, result rd:x13(0xffffffffffffffef)
    la  x2, test_data
    addi    x2, x2,32
    li     x7, MASK_XLEN(-232)
    add    x2, x2, x7
    c.ldsp x13, 232(x2)
    sd x13, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x13, 0xffffffffffffffef)

    # Testcase 137:  imm:0xf0, result rd:x14(0xffffffffffffffdf)
    la  x2, test_data
    addi    x2, x2,40
    li     x7, MASK_XLEN(-240)
    add    x2, x2, x7
    c.ldsp x14, 240(x2)
    sd x14, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x14, 0xffffffffffffffdf)

    # Testcase 138:  imm:0x0, result rd:x15(0xffffffffffffffbf)
    la  x2, test_data
    addi    x2, x2,48
    li     x7, MASK_XLEN(0)
    add    x2, x2, x7
    c.ldsp x15, 0(x2)
    sd x15, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x15, 0xffffffffffffffbf)

    # Testcase 139:  imm:0x80, result rd:x16(0xffffffffffffff7f)
    la  x2, test_data
    addi    x2, x2,56
    li     x7, MASK_XLEN(-128)
    add    x2, x2, x7
    c.ldsp x16, 128(x2)
    sd x16, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x16, 0xffffffffffffff7f)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 29\n")



    # Addresses for test data and results
    la x1, test_29_res

    # Testcase 140:  imm:0x40, result rd:x17(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,64
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x17, 64(x2)
    sd x17, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x17, 0xfffffffffffffeff)

    # Testcase 141:  imm:0x20, result rd:x18(0xfffffffffffffdff)
    la  x2, test_data
    addi    x2, x2,72
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x18, 32(x2)
    sd x18, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x18, 0xfffffffffffffdff)

    # Testcase 142:  imm:0x10, result rd:x19(0xfffffffffffffeff)
    la  x2, test_data
    addi    x2, x2,80
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x19, 16(x2)
    sd x19, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0xfffffffffffffeff)

    # Testcase 143:  imm:0x8, result rd:x20(0xfffffffffffff7ff)
    la  x2, test_data
    addi    x2, x2,88
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x20, 8(x2)
    sd x20, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0xfffffffffffff7ff)

    # Testcase 144:  imm:0xf8, result rd:x21(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,96
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    c.ldsp x21, 248(x2)
    sd x21, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0xffffffffffffefff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 30\n")



    # Addresses for test data and results
    la x1, test_30_res

    # Testcase 145:  imm:0x78, result rd:x22(0xffffffffffffdfff)
    la  x2, test_data
    addi    x2, x2,104
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x22, 120(x2)
    sd x22, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0xffffffffffffdfff)

    # Testcase 146:  imm:0xb8, result rd:x23(0xffffffffffffefff)
    la  x2, test_data
    addi    x2, x2,112
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x23, 184(x2)
    sd x23, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0xffffffffffffefff)

    # Testcase 147:  imm:0xd8, result rd:x24(0xffffffffffff7fff)
    la  x2, test_data
    addi    x2, x2,120
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    c.ldsp x24, 216(x2)
    sd x24, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0xffffffffffff7fff)

    # Testcase 148:  imm:0xe8, result rd:x25(0xfffffffffffeffff)
    la  x2, test_data
    addi    x2, x2,128
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x25, 232(x2)
    sd x25, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0xfffffffffffeffff)

    # Testcase 149:  imm:0xf0, result rd:x26(0xfffffffffffdffff)
    la  x2, test_data
    addi    x2, x2,136
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x26, 240(x2)
    sd x26, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0xfffffffffffdffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 31\n")



    # Addresses for test data and results
    la x1, test_31_res

    # Testcase 150:  imm:0x0, result rd:x27(0xfffffffffffbffff)
    la  x2, test_data
    addi    x2, x2,144
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.ldsp x27, 0(x2)
    sd x27, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0xfffffffffffbffff)

    # Testcase 151:  imm:0x80, result rd:x28(0xfffffffffff7ffff)
    la  x2, test_data
    addi    x2, x2,152
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x28, 128(x2)
    sd x28, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0xfffffffffff7ffff)

    # Testcase 152:  imm:0x40, result rd:x29(0xffffffffffefffff)
    la  x2, test_data
    addi    x2, x2,160
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x29, 64(x2)
    sd x29, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0xffffffffffefffff)

    # Testcase 153:  imm:0x20, result rd:x30(0xffffffffffdfffff)
    la  x2, test_data
    addi    x2, x2,168
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x30, 32(x2)
    sd x30, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x30, 0xffffffffffdfffff)

    # Testcase 154:  imm:0x10, result rd:x31(0xffffffffffbfffff)
    la  x2, test_data
    addi    x2, x2,176
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x31, 16(x2)
    sd x31, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x31, 0xffffffffffbfffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 32\n")



    # Addresses for test data and results
    la x6, test_32_res

    # Testcase 155:  imm:0x8, result rd:x1(0xffffffffff7fffff)
    la  x2, test_data
    addi    x2, x2,184
    li     x7, MASK_XLEN(-8)
    add    x2, x2, x7
    c.ldsp x1, 8(x2)
    sd x1, 0(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x1, 0xffffffffff7fffff)

    # Testcase 156:  imm:0xf8, result rd:x2(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,192
    li     x7, MASK_XLEN(-248)
    add    x2, x2, x7
    c.ldsp x2, 248(x2)
    sd x2, 8(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x2, 0xfffffffffeffffff)

    # Testcase 157:  imm:0x78, result rd:x3(0xfffffffffdffffff)
    la  x2, test_data
    addi    x2, x2,200
    li     x7, MASK_XLEN(-120)
    add    x2, x2, x7
    c.ldsp x3, 120(x2)
    sd x3, 16(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x3, 0xfffffffffdffffff)

    # Testcase 158:  imm:0xb8, result rd:x4(0xfffffffffeffffff)
    la  x2, test_data
    addi    x2, x2,208
    li     x7, MASK_XLEN(-184)
    add    x2, x2, x7
    c.ldsp x4, 184(x2)
    sd x4, 24(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x4, 0xfffffffffeffffff)

    # Testcase 159:  imm:0xd8, result rd:x5(0xfffffffff7ffffff)
    la  x2, test_data
    addi    x2, x2,216
    li     x7, MASK_XLEN(-216)
    add    x2, x2, x7
    c.ldsp x5, 216(x2)
    sd x5, 32(x6)
    RVTEST_IO_ASSERT_GPR_EQ(x8, x5, 0xfffffffff7ffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 33\n")



    # Addresses for test data and results
    la x1, test_33_res

    # Testcase 160:  imm:0xe8, result rd:x6(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,224
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x6, 232(x2)
    sd x6, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0xffffffffefffffff)

    # Testcase 161:  imm:0xf0, result rd:x7(0xffffffffdfffffff)
    la  x2, test_data
    addi    x2, x2,232
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x7, 240(x2)
    sd x7, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0xffffffffdfffffff)

    # Testcase 162:  imm:0x0, result rd:x8(0xffffffffefffffff)
    la  x2, test_data
    addi    x2, x2,240
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.ldsp x8, 0(x2)
    sd x8, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0xffffffffefffffff)

    # Testcase 163:  imm:0x80, result rd:x9(0xffffffff7fffffff)
    la  x2, test_data
    addi    x2, x2,248
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x9, 128(x2)
    sd x9, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0xffffffff7fffffff)

    # Testcase 164:  imm:0x40, result rd:x10(0xffffffffffffffff)
    la  x2, test_data
    addi    x2, x2,256
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x10, 64(x2)
    sd x10, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0xffffffffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 34\n")



    # Addresses for test data and results
    la x7, test_34_res

    # Testcase 165:  imm:0x20, result rd:x11(0xfffffffeffffffff)
    la  x2, test_data
    addi    x2, x2,264
    li     x8, MASK_XLEN(-32)
    add    x2, x2, x8
    c.ldsp x11, 32(x2)
    sd x11, 0(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x11, 0xfffffffeffffffff)

    # Testcase 166:  imm:0x10, result rd:x12(0xfffffffdffffffff)
    la  x2, test_data
    addi    x2, x2,272
    li     x8, MASK_XLEN(-16)
    add    x2, x2, x8
    c.ldsp x12, 16(x2)
    sd x12, 8(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x12, 0xfffffffdffffffff)

    # Testcase 167:  imm:0x8, result rd:x13(0xfffffffbffffffff)
    la  x2, test_data
    addi    x2, x2,280
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    c.ldsp x13, 8(x2)
    sd x13, 16(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x13, 0xfffffffbffffffff)

    # Testcase 168:  imm:0xf8, result rd:x14(0xfffffff7ffffffff)
    la  x2, test_data
    addi    x2, x2,288
    li     x8, MASK_XLEN(-248)
    add    x2, x2, x8
    c.ldsp x14, 248(x2)
    sd x14, 24(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x14, 0xfffffff7ffffffff)

    # Testcase 169:  imm:0x78, result rd:x15(0xffffffefffffffff)
    la  x2, test_data
    addi    x2, x2,296
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    c.ldsp x15, 120(x2)
    sd x15, 32(x7)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x15, 0xffffffefffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 35\n")



    # Addresses for test data and results
    la x3, test_35_res

    # Testcase 170:  imm:0xb8, result rd:x16(0xffffffdfffffffff)
    la  x2, test_data
    addi    x2, x2,304
    li     x4, MASK_XLEN(-184)
    add    x2, x2, x4
    c.ldsp x16, 184(x2)
    sd x16, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0xffffffdfffffffff)

    # Testcase 171:  imm:0xd8, result rd:x17(0xffffffbfffffffff)
    la  x2, test_data
    addi    x2, x2,312
    li     x4, MASK_XLEN(-216)
    add    x2, x2, x4
    c.ldsp x17, 216(x2)
    sd x17, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0xffffffbfffffffff)

    # Testcase 172:  imm:0xe8, result rd:x18(0xffffff7fffffffff)
    la  x2, test_data
    addi    x2, x2,320
    li     x4, MASK_XLEN(-232)
    add    x2, x2, x4
    c.ldsp x18, 232(x2)
    sd x18, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0xffffff7fffffffff)

    # Testcase 173:  imm:0xf0, result rd:x19(0xfffffeffffffffff)
    la  x2, test_data
    addi    x2, x2,328
    li     x4, MASK_XLEN(-240)
    add    x2, x2, x4
    c.ldsp x19, 240(x2)
    sd x19, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0xfffffeffffffffff)

    # Testcase 174:  imm:0x0, result rd:x20(0xfffffdffffffffff)
    la  x2, test_data
    addi    x2, x2,336
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    c.ldsp x20, 0(x2)
    sd x20, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x20, 0xfffffdffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 36\n")



    # Addresses for test data and results
    la x1, test_36_res

    # Testcase 175:  imm:0x80, result rd:x21(0xfffffeffffffffff)
    la  x2, test_data
    addi    x2, x2,344
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x21, 128(x2)
    sd x21, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0xfffffeffffffffff)

    # Testcase 176:  imm:0x40, result rd:x22(0xfffff7ffffffffff)
    la  x2, test_data
    addi    x2, x2,352
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x22, 64(x2)
    sd x22, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0xfffff7ffffffffff)

    # Testcase 177:  imm:0x20, result rd:x23(0xffffefffffffffff)
    la  x2, test_data
    addi    x2, x2,360
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x23, 32(x2)
    sd x23, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0xffffefffffffffff)

    # Testcase 178:  imm:0x10, result rd:x24(0xffffdfffffffffff)
    la  x2, test_data
    addi    x2, x2,368
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x24, 16(x2)
    sd x24, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0xffffdfffffffffff)

    # Testcase 179:  imm:0x8, result rd:x25(0xffffefffffffffff)
    la  x2, test_data
    addi    x2, x2,376
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x25, 8(x2)
    sd x25, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0xffffefffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 37\n")



    # Addresses for test data and results
    la x1, test_37_res

    # Testcase 180:  imm:0xf8, result rd:x26(0xffff7fffffffffff)
    la  x2, test_data
    addi    x2, x2,384
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    c.ldsp x26, 248(x2)
    sd x26, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0xffff7fffffffffff)

    # Testcase 181:  imm:0x78, result rd:x27(0xfffeffffffffffff)
    la  x2, test_data
    addi    x2, x2,392
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x27, 120(x2)
    sd x27, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0xfffeffffffffffff)

    # Testcase 182:  imm:0xb8, result rd:x28(0xfffdffffffffffff)
    la  x2, test_data
    addi    x2, x2,400
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x28, 184(x2)
    sd x28, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0xfffdffffffffffff)

    # Testcase 183:  imm:0xd8, result rd:x29(0xfffbffffffffffff)
    la  x2, test_data
    addi    x2, x2,408
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    c.ldsp x29, 216(x2)
    sd x29, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0xfffbffffffffffff)

    # Testcase 184:  imm:0xe8, result rd:x30(0xfff7ffffffffffff)
    la  x2, test_data
    addi    x2, x2,416
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x30, 232(x2)
    sd x30, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x30, 0xfff7ffffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 38\n")



    # Addresses for test data and results
    la x5, test_38_res

    # Testcase 185:  imm:0xf0, result rd:x31(0xffefffffffffffff)
    la  x2, test_data
    addi    x2, x2,424
    li     x6, MASK_XLEN(-240)
    add    x2, x2, x6
    c.ldsp x31, 240(x2)
    sd x31, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x31, 0xffefffffffffffff)

    # Testcase 186:  imm:0x0, result rd:x1(0xffdfffffffffffff)
    la  x2, test_data
    addi    x2, x2,432
    li     x6, MASK_XLEN(0)
    add    x2, x2, x6
    c.ldsp x1, 0(x2)
    sd x1, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x1, 0xffdfffffffffffff)

    # Testcase 187:  imm:0x80, result rd:x2(0xffbfffffffffffff)
    la  x2, test_data
    addi    x2, x2,440
    li     x6, MASK_XLEN(-128)
    add    x2, x2, x6
    c.ldsp x2, 128(x2)
    sd x2, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x2, 0xffbfffffffffffff)

    # Testcase 188:  imm:0x40, result rd:x3(0xff7fffffffffffff)
    la  x2, test_data
    addi    x2, x2,448
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    c.ldsp x3, 64(x2)
    sd x3, 24(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x3, 0xff7fffffffffffff)

    # Testcase 189:  imm:0x20, result rd:x4(0xfeffffffffffffff)
    la  x2, test_data
    addi    x2, x2,456
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    c.ldsp x4, 32(x2)
    sd x4, 32(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x4, 0xfeffffffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 39\n")



    # Addresses for test data and results
    la x1, test_39_res

    # Testcase 190:  imm:0x10, result rd:x5(0xfdffffffffffffff)
    la  x2, test_data
    addi    x2, x2,464
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x5, 16(x2)
    sd x5, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x5, 0xfdffffffffffffff)

    # Testcase 191:  imm:0x8, result rd:x6(0xfeffffffffffffff)
    la  x2, test_data
    addi    x2, x2,472
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x6, 8(x2)
    sd x6, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x6, 0xfeffffffffffffff)

    # Testcase 192:  imm:0xf8, result rd:x7(0xf7ffffffffffffff)
    la  x2, test_data
    addi    x2, x2,480
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    c.ldsp x7, 248(x2)
    sd x7, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x7, 0xf7ffffffffffffff)

    # Testcase 193:  imm:0x78, result rd:x8(0xefffffffffffffff)
    la  x2, test_data
    addi    x2, x2,488
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x8, 120(x2)
    sd x8, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0xefffffffffffffff)

    # Testcase 194:  imm:0xb8, result rd:x9(0xdfffffffffffffff)
    la  x2, test_data
    addi    x2, x2,496
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x9, 184(x2)
    sd x9, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0xdfffffffffffffff)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 40\n")



    # Addresses for test data and results
    la x1, test_40_res

    # Testcase 195:  imm:0xd8, result rd:x10(0xefffffffffffffff)
    la  x2, test_data
    addi    x2, x2,504
    li     x8, MASK_XLEN(-216)
    add    x2, x2, x8
    c.ldsp x10, 216(x2)
    sd x10, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x10, 0xefffffffffffffff)

    # Testcase 196:  imm:0xe8, result rd:x11(0x7fffffffffffffff)
    la  x2, test_data
    addi    x2, x2,512
    li     x8, MASK_XLEN(-232)
    add    x2, x2, x8
    c.ldsp x11, 232(x2)
    sd x11, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x11, 0x7fffffffffffffff)

    # Testcase 197:  imm:0xf0, result rd:x12(0xffffffffffffffff)
    la  x2, test_data
    addi    x2, x2,520
    li     x8, MASK_XLEN(-240)
    add    x2, x2, x8
    c.ldsp x12, 240(x2)
    sd x12, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x12, 0xffffffffffffffff)

    # Testcase 198:  imm:0x0, result rd:x13(0x0000000000000001)
    la  x2, test_data
    addi    x2, x2,528
    li     x8, MASK_XLEN(0)
    add    x2, x2, x8
    c.ldsp x13, 0(x2)
    sd x13, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x13, 0x0000000000000001)

    # Testcase 199:  imm:0x80, result rd:x14(0x0000000000000002)
    la  x2, test_data
    addi    x2, x2,536
    li     x8, MASK_XLEN(-128)
    add    x2, x2, x8
    c.ldsp x14, 128(x2)
    sd x14, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x14, 0x0000000000000002)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 41\n")



    # Addresses for test data and results
    la x3, test_41_res

    # Testcase 200:  imm:0x40, result rd:x15(0x0000000000000004)
    la  x2, test_data
    addi    x2, x2,544
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    c.ldsp x15, 64(x2)
    sd x15, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x15, 0x0000000000000004)

    # Testcase 201:  imm:0x20, result rd:x16(0x0000000000000008)
    la  x2, test_data
    addi    x2, x2,552
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    c.ldsp x16, 32(x2)
    sd x16, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x16, 0x0000000000000008)

    # Testcase 202:  imm:0x10, result rd:x17(0x0000000000000010)
    la  x2, test_data
    addi    x2, x2,560
    li     x4, MASK_XLEN(-16)
    add    x2, x2, x4
    c.ldsp x17, 16(x2)
    sd x17, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x17, 0x0000000000000010)

    # Testcase 203:  imm:0x8, result rd:x18(0x0000000000000020)
    la  x2, test_data
    addi    x2, x2,568
    li     x4, MASK_XLEN(-8)
    add    x2, x2, x4
    c.ldsp x18, 8(x2)
    sd x18, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x18, 0x0000000000000020)

    # Testcase 204:  imm:0xf8, result rd:x19(0x0000000000000040)
    la  x2, test_data
    addi    x2, x2,576
    li     x4, MASK_XLEN(-248)
    add    x2, x2, x4
    c.ldsp x19, 248(x2)
    sd x19, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x19, 0x0000000000000040)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 42\n")



    # Addresses for test data and results
    la x1, test_42_res

    # Testcase 205:  imm:0x78, result rd:x20(0x0000000000000080)
    la  x2, test_data
    addi    x2, x2,584
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x20, 120(x2)
    sd x20, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x0000000000000080)

    # Testcase 206:  imm:0xb8, result rd:x21(0x0000000000000100)
    la  x2, test_data
    addi    x2, x2,592
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x21, 184(x2)
    sd x21, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0x0000000000000100)

    # Testcase 207:  imm:0xd8, result rd:x22(0x0000000000000200)
    la  x2, test_data
    addi    x2, x2,600
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    c.ldsp x22, 216(x2)
    sd x22, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0x0000000000000200)

    # Testcase 208:  imm:0xe8, result rd:x23(0x0000000000000400)
    la  x2, test_data
    addi    x2, x2,608
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x23, 232(x2)
    sd x23, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0x0000000000000400)

    # Testcase 209:  imm:0xf0, result rd:x24(0x0000000000000800)
    la  x2, test_data
    addi    x2, x2,616
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x24, 240(x2)
    sd x24, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0x0000000000000800)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 43\n")



    # Addresses for test data and results
    la x1, test_43_res

    # Testcase 210:  imm:0x0, result rd:x25(0x0000000000001000)
    la  x2, test_data
    addi    x2, x2,624
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.ldsp x25, 0(x2)
    sd x25, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0x0000000000001000)

    # Testcase 211:  imm:0x80, result rd:x26(0x0000000000002000)
    la  x2, test_data
    addi    x2, x2,632
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x26, 128(x2)
    sd x26, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0x0000000000002000)

    # Testcase 212:  imm:0x40, result rd:x27(0x0000000000004000)
    la  x2, test_data
    addi    x2, x2,640
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x27, 64(x2)
    sd x27, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0x0000000000004000)

    # Testcase 213:  imm:0x20, result rd:x28(0x0000000000008000)
    la  x2, test_data
    addi    x2, x2,648
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x28, 32(x2)
    sd x28, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0x0000000000008000)

    # Testcase 214:  imm:0x10, result rd:x29(0x0000000000010000)
    la  x2, test_data
    addi    x2, x2,656
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x29, 16(x2)
    sd x29, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x29, 0x0000000000010000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 44\n")



    # Addresses for test data and results
    la x4, test_44_res

    # Testcase 215:  imm:0x8, result rd:x30(0x0000000000020000)
    la  x2, test_data
    addi    x2, x2,664
    li     x5, MASK_XLEN(-8)
    add    x2, x2, x5
    c.ldsp x30, 8(x2)
    sd x30, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x30, 0x0000000000020000)

    # Testcase 216:  imm:0xf8, result rd:x31(0x0000000000040000)
    la  x2, test_data
    addi    x2, x2,672
    li     x5, MASK_XLEN(-248)
    add    x2, x2, x5
    c.ldsp x31, 248(x2)
    sd x31, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x31, 0x0000000000040000)

    # Testcase 217:  imm:0x78, result rd:x1(0x0000000000080000)
    la  x2, test_data
    addi    x2, x2,680
    li     x5, MASK_XLEN(-120)
    add    x2, x2, x5
    c.ldsp x1, 120(x2)
    sd x1, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x1, 0x0000000000080000)

    # Testcase 218:  imm:0xb8, result rd:x2(0x0000000000100000)
    la  x2, test_data
    addi    x2, x2,688
    li     x5, MASK_XLEN(-184)
    add    x2, x2, x5
    c.ldsp x2, 184(x2)
    sd x2, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x2, 0x0000000000100000)

    # Testcase 219:  imm:0xd8, result rd:x3(0x0000000000200000)
    la  x2, test_data
    addi    x2, x2,696
    li     x5, MASK_XLEN(-216)
    add    x2, x2, x5
    c.ldsp x3, 216(x2)
    sd x3, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x3, 0x0000000000200000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 45\n")



    # Addresses for test data and results
    la x1, test_45_res

    # Testcase 220:  imm:0xe8, result rd:x4(0x0000000000400000)
    la  x2, test_data
    addi    x2, x2,704
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x4, 232(x2)
    sd x4, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x4, 0x0000000000400000)

    # Testcase 221:  imm:0xf0, result rd:x5(0x0000000000800000)
    la  x2, test_data
    addi    x2, x2,712
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x5, 240(x2)
    sd x5, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x5, 0x0000000000800000)

    # Testcase 222:  imm:0x0, result rd:x6(0x0000000001000000)
    la  x2, test_data
    addi    x2, x2,720
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.ldsp x6, 0(x2)
    sd x6, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x6, 0x0000000001000000)

    # Testcase 223:  imm:0x80, result rd:x7(0x0000000002000000)
    la  x2, test_data
    addi    x2, x2,728
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x7, 128(x2)
    sd x7, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x7, 0x0000000002000000)

    # Testcase 224:  imm:0x40, result rd:x8(0x0000000004000000)
    la  x2, test_data
    addi    x2, x2,736
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x8, 64(x2)
    sd x8, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x8, 0x0000000004000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 46\n")



    # Addresses for test data and results
    la x1, test_46_res

    # Testcase 225:  imm:0x20, result rd:x9(0x0000000008000000)
    la  x2, test_data
    addi    x2, x2,744
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x9, 32(x2)
    sd x9, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x9, 0x0000000008000000)

    # Testcase 226:  imm:0x10, result rd:x10(0x0000000010000000)
    la  x2, test_data
    addi    x2, x2,752
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x10, 16(x2)
    sd x10, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x10, 0x0000000010000000)

    # Testcase 227:  imm:0x8, result rd:x11(0x0000000020000000)
    la  x2, test_data
    addi    x2, x2,760
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x11, 8(x2)
    sd x11, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x11, 0x0000000020000000)

    # Testcase 228:  imm:0xf8, result rd:x12(0x0000000040000000)
    la  x2, test_data
    addi    x2, x2,768
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    c.ldsp x12, 248(x2)
    sd x12, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x12, 0x0000000040000000)

    # Testcase 229:  imm:0x78, result rd:x13(0x0000000080000000)
    la  x2, test_data
    addi    x2, x2,776
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x13, 120(x2)
    sd x13, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x14, x13, 0x0000000080000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 47\n")



    # Addresses for test data and results
    la x4, test_47_res

    # Testcase 230:  imm:0xb8, result rd:x14(0x0000000000000000)
    la  x2, test_data
    addi    x2, x2,784
    li     x5, MASK_XLEN(-184)
    add    x2, x2, x5
    c.ldsp x14, 184(x2)
    sd x14, 0(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x14, 0x0000000000000000)

    # Testcase 231:  imm:0xd8, result rd:x15(0x0000000100000000)
    la  x2, test_data
    addi    x2, x2,792
    li     x5, MASK_XLEN(-216)
    add    x2, x2, x5
    c.ldsp x15, 216(x2)
    sd x15, 8(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x15, 0x0000000100000000)

    # Testcase 232:  imm:0xe8, result rd:x16(0x0000000200000000)
    la  x2, test_data
    addi    x2, x2,800
    li     x5, MASK_XLEN(-232)
    add    x2, x2, x5
    c.ldsp x16, 232(x2)
    sd x16, 16(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x16, 0x0000000200000000)

    # Testcase 233:  imm:0xf0, result rd:x17(0x0000000400000000)
    la  x2, test_data
    addi    x2, x2,808
    li     x5, MASK_XLEN(-240)
    add    x2, x2, x5
    c.ldsp x17, 240(x2)
    sd x17, 24(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x17, 0x0000000400000000)

    # Testcase 234:  imm:0x0, result rd:x18(0x0000000800000000)
    la  x2, test_data
    addi    x2, x2,816
    li     x5, MASK_XLEN(0)
    add    x2, x2, x5
    c.ldsp x18, 0(x2)
    sd x18, 32(x4)
    RVTEST_IO_ASSERT_GPR_EQ(x6, x18, 0x0000000800000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 48\n")



    # Addresses for test data and results
    la x1, test_48_res

    # Testcase 235:  imm:0x80, result rd:x19(0x0000001000000000)
    la  x2, test_data
    addi    x2, x2,824
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x19, 128(x2)
    sd x19, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x19, 0x0000001000000000)

    # Testcase 236:  imm:0x40, result rd:x20(0x0000002000000000)
    la  x2, test_data
    addi    x2, x2,832
    li     x3, MASK_XLEN(-64)
    add    x2, x2, x3
    c.ldsp x20, 64(x2)
    sd x20, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x20, 0x0000002000000000)

    # Testcase 237:  imm:0x20, result rd:x21(0x0000004000000000)
    la  x2, test_data
    addi    x2, x2,840
    li     x3, MASK_XLEN(-32)
    add    x2, x2, x3
    c.ldsp x21, 32(x2)
    sd x21, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x21, 0x0000004000000000)

    # Testcase 238:  imm:0x10, result rd:x22(0x0000008000000000)
    la  x2, test_data
    addi    x2, x2,848
    li     x3, MASK_XLEN(-16)
    add    x2, x2, x3
    c.ldsp x22, 16(x2)
    sd x22, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x22, 0x0000008000000000)

    # Testcase 239:  imm:0x8, result rd:x23(0x0000010000000000)
    la  x2, test_data
    addi    x2, x2,856
    li     x3, MASK_XLEN(-8)
    add    x2, x2, x3
    c.ldsp x23, 8(x2)
    sd x23, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x23, 0x0000010000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 49\n")



    # Addresses for test data and results
    la x1, test_49_res

    # Testcase 240:  imm:0xf8, result rd:x24(0x0000020000000000)
    la  x2, test_data
    addi    x2, x2,864
    li     x3, MASK_XLEN(-248)
    add    x2, x2, x3
    c.ldsp x24, 248(x2)
    sd x24, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x24, 0x0000020000000000)

    # Testcase 241:  imm:0x78, result rd:x25(0x0000040000000000)
    la  x2, test_data
    addi    x2, x2,872
    li     x3, MASK_XLEN(-120)
    add    x2, x2, x3
    c.ldsp x25, 120(x2)
    sd x25, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x25, 0x0000040000000000)

    # Testcase 242:  imm:0xb8, result rd:x26(0x0000080000000000)
    la  x2, test_data
    addi    x2, x2,880
    li     x3, MASK_XLEN(-184)
    add    x2, x2, x3
    c.ldsp x26, 184(x2)
    sd x26, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x26, 0x0000080000000000)

    # Testcase 243:  imm:0xd8, result rd:x27(0x0000100000000000)
    la  x2, test_data
    addi    x2, x2,888
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    c.ldsp x27, 216(x2)
    sd x27, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x27, 0x0000100000000000)

    # Testcase 244:  imm:0xe8, result rd:x28(0x0000200000000000)
    la  x2, test_data
    addi    x2, x2,896
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x28, 232(x2)
    sd x28, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x28, 0x0000200000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 50\n")



    # Addresses for test data and results
    la x3, test_50_res

    # Testcase 245:  imm:0xf0, result rd:x29(0x0000400000000000)
    la  x2, test_data
    addi    x2, x2,904
    li     x4, MASK_XLEN(-240)
    add    x2, x2, x4
    c.ldsp x29, 240(x2)
    sd x29, 0(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x29, 0x0000400000000000)

    # Testcase 246:  imm:0x0, result rd:x30(0x0000800000000000)
    la  x2, test_data
    addi    x2, x2,912
    li     x4, MASK_XLEN(0)
    add    x2, x2, x4
    c.ldsp x30, 0(x2)
    sd x30, 8(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x30, 0x0000800000000000)

    # Testcase 247:  imm:0x80, result rd:x31(0x0001000000000000)
    la  x2, test_data
    addi    x2, x2,920
    li     x4, MASK_XLEN(-128)
    add    x2, x2, x4
    c.ldsp x31, 128(x2)
    sd x31, 16(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x31, 0x0001000000000000)

    # Testcase 248:  imm:0x40, result rd:x1(0x0002000000000000)
    la  x2, test_data
    addi    x2, x2,928
    li     x4, MASK_XLEN(-64)
    add    x2, x2, x4
    c.ldsp x1, 64(x2)
    sd x1, 24(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x1, 0x0002000000000000)

    # Testcase 249:  imm:0x20, result rd:x2(0x0004000000000000)
    la  x2, test_data
    addi    x2, x2,936
    li     x4, MASK_XLEN(-32)
    add    x2, x2, x4
    c.ldsp x2, 32(x2)
    sd x2, 32(x3)
    RVTEST_IO_ASSERT_GPR_EQ(x5, x2, 0x0004000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 51\n")



    # Addresses for test data and results
    la x1, test_51_res

    # Testcase 250:  imm:0x10, result rd:x3(0x0008000000000000)
    la  x2, test_data
    addi    x2, x2,944
    li     x8, MASK_XLEN(-16)
    add    x2, x2, x8
    c.ldsp x3, 16(x2)
    sd x3, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x3, 0x0008000000000000)

    # Testcase 251:  imm:0x8, result rd:x4(0x0010000000000000)
    la  x2, test_data
    addi    x2, x2,952
    li     x8, MASK_XLEN(-8)
    add    x2, x2, x8
    c.ldsp x4, 8(x2)
    sd x4, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x4, 0x0010000000000000)

    # Testcase 252:  imm:0xf8, result rd:x5(0x0020000000000000)
    la  x2, test_data
    addi    x2, x2,960
    li     x8, MASK_XLEN(-248)
    add    x2, x2, x8
    c.ldsp x5, 248(x2)
    sd x5, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x5, 0x0020000000000000)

    # Testcase 253:  imm:0x78, result rd:x6(0x0040000000000000)
    la  x2, test_data
    addi    x2, x2,968
    li     x8, MASK_XLEN(-120)
    add    x2, x2, x8
    c.ldsp x6, 120(x2)
    sd x6, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x6, 0x0040000000000000)

    # Testcase 254:  imm:0xb8, result rd:x7(0x0080000000000000)
    la  x2, test_data
    addi    x2, x2,976
    li     x8, MASK_XLEN(-184)
    add    x2, x2, x8
    c.ldsp x7, 184(x2)
    sd x7, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x9, x7, 0x0080000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 52\n")



    # Addresses for test data and results
    la x1, test_52_res

    # Testcase 255:  imm:0xd8, result rd:x8(0x0100000000000000)
    la  x2, test_data
    addi    x2, x2,984
    li     x3, MASK_XLEN(-216)
    add    x2, x2, x3
    c.ldsp x8, 216(x2)
    sd x8, 0(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x8, 0x0100000000000000)

    # Testcase 256:  imm:0xe8, result rd:x9(0x0200000000000000)
    la  x2, test_data
    addi    x2, x2,992
    li     x3, MASK_XLEN(-232)
    add    x2, x2, x3
    c.ldsp x9, 232(x2)
    sd x9, 8(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x9, 0x0200000000000000)

    # Testcase 257:  imm:0xf0, result rd:x10(0x0400000000000000)
    la  x2, test_data
    addi    x2, x2,1000
    li     x3, MASK_XLEN(-240)
    add    x2, x2, x3
    c.ldsp x10, 240(x2)
    sd x10, 16(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x10, 0x0400000000000000)

    # Testcase 258:  imm:0x0, result rd:x11(0x0800000000000000)
    la  x2, test_data
    addi    x2, x2,1008
    li     x3, MASK_XLEN(0)
    add    x2, x2, x3
    c.ldsp x11, 0(x2)
    sd x11, 24(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x11, 0x0800000000000000)

    # Testcase 259:  imm:0x80, result rd:x12(0x1000000000000000)
    la  x2, test_data
    addi    x2, x2,1016
    li     x3, MASK_XLEN(-128)
    add    x2, x2, x3
    c.ldsp x12, 128(x2)
    sd x12, 32(x1)
    RVTEST_IO_ASSERT_GPR_EQ(x4, x12, 0x1000000000000000)

\

	# ---------------------------------------------------------------------------------------------
	RVTEST_IO_WRITE_STR(x31, "# Test group 53\n")



    # Addresses for test data and results
    la x5, test_53_res

    # Testcase 260:  imm:0x40, result rd:x13(0x2000000000000000)
    la  x2, test_data
    addi    x2, x2,1024
    li     x6, MASK_XLEN(-64)
    add    x2, x2, x6
    c.ldsp x13, 64(x2)
    sd x13, 0(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x13, 0x2000000000000000)

    # Testcase 261:  imm:0x20, result rd:x14(0x4000000000000000)
    la  x2, test_data
    addi    x2, x2,1032
    li     x6, MASK_XLEN(-32)
    add    x2, x2, x6
    c.ldsp x14, 32(x2)
    sd x14, 8(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x14, 0x4000000000000000)

    # Testcase 262:  imm:0x10, result rd:x15(0x8000000000000000)
    la  x2, test_data
    addi    x2, x2,1040
    li     x6, MASK_XLEN(-16)
    add    x2, x2, x6
    c.ldsp x15, 16(x2)
    sd x15, 16(x5)
    RVTEST_IO_ASSERT_GPR_EQ(x7, x15, 0x8000000000000000)

    # Testcase 263:  imm:0x8, result rd:x16(0x0000000000000000)
    la  x2, test_data
    addi    x2, x2,1048
    li     x6, MASK_XLEN(-8)
    add    x2, x2, x6
    c.ldsp x16, 8(x2)
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

