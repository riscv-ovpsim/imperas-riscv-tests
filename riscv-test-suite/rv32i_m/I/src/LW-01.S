// RISC-V Architectural Validation Test LW-01
//
//
// Copyright (c) 2005-2023 Imperas Software Ltd., www.imperas.com
//
// The contents of this file are provided under the Software License
// Agreement that you accepted before downloading this file.
//
// This source forms part of the Software and can be used for educational,
// training, and demonstration purposes but cannot be used for derivative
// works except in cases where the derivative works require OVP technology
// to run.
//
// For open source models released under licenses that you can use for
// derivative works, please visit www.OVPworld.org or www.imperas.com
// for the location of the open source models.
//
    

//
// Specification: RV32I Base Integer Instruction Set, Version 2.1
// Description: Testing instruction 'LW'.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32I")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN







#ifdef TEST_CASE_1


    
    RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*I.*);def TEST_CASE_1=True;",lw)

    RVTEST_SIGBASE(x1,signature_1_0)

    # Testcase 0:  imm:0xd27, result rd:x19(0xfffffffe)
    la  x29, test_data
    addi    x29, x29,0
    li     x3, MASK_XLEN(729)
    add    x29, x29, x3
    lw x19, -729(x29)
    sw x19, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x19, 0xfffffffe)

    # Testcase 1:  imm:0xa51, result rd:x30(0xfffffffd)
    la  x21, test_data
    addi    x21, x21,4
    li     x3, MASK_XLEN(1455)
    add    x21, x21, x3
    lw x30, -1455(x21)
    sw x30, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x30, 0xfffffffd)

    # Testcase 2:  imm:0xc65, result rd:x10(0xfffffffb)
    la  x2, test_data
    addi    x2, x2,8
    li     x3, MASK_XLEN(923)
    add    x2, x2, x3
    lw x10, -923(x2)
    sw x10, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x10, 0xfffffffb)



    

    RVTEST_SIGBASE(x2,signature_2_0)

    # Testcase 3:  imm:0xa64, result rd:x3(0xfffffff7)
    la  x1, test_data
    addi    x1, x1,12
    li     x4, MASK_XLEN(1436)
    add    x1, x1, x4
    lw x3, -1436(x1)
    sw x3, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x3, 0xfffffff7)

    # Testcase 4:  imm:0xc1e, result rd:x29(0xffffffef)
    la  x6, test_data
    addi    x6, x6,16
    li     x4, MASK_XLEN(994)
    add    x6, x6, x4
    lw x29, -994(x6)
    sw x29, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x29, 0xffffffef)

    # Testcase 5:  imm:0xadf, result rd:x0(0x00000000)
    la  x14, test_data
    addi    x14, x14,20
    li     x4, MASK_XLEN(1313)
    add    x14, x14, x4
    lw x0, -1313(x14)
    sw x0, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x0, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_3_0)

    # Testcase 6:  imm:0xae7, result rd:x4(0xffffffbf)
    la  x12, test_data
    addi    x12, x12,24
    li     x2, MASK_XLEN(1305)
    add    x12, x12, x2
    lw x4, -1305(x12)
    sw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x4, 0xffffffbf)

    # Testcase 7:  imm:0x3d1, result rd:x25(0xffffff7f)
    la  x3, test_data
    addi    x3, x3,28
    li     x2, MASK_XLEN(-977)
    add    x3, x3, x2
    lw x25, 977(x3)
    sw x25, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x25, 0xffffff7f)

    # Testcase 8:  imm:0xff4, result rd:x18(0xfffffeff)
    la  x19, test_data
    addi    x19, x19,32
    li     x2, MASK_XLEN(12)
    add    x19, x19, x2
    lw x18, -12(x19)
    sw x18, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x18, 0xfffffeff)



    

    RVTEST_SIGBASE(x2,signature_4_0)

    # Testcase 9:  imm:0x4c0, result rd:x7(0xfffffdff)
    la  x10, test_data
    addi    x10, x10,36
    li     x3, MASK_XLEN(-1216)
    add    x10, x10, x3
    lw x7, 1216(x10)
    sw x7, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x7, 0xfffffdff)

    # Testcase 10:  imm:0x63e, result rd:x31(0xfffffeff)
    la  x18, test_data
    addi    x18, x18,40
    li     x3, MASK_XLEN(-1598)
    add    x18, x18, x3
    lw x31, 1598(x18)
    sw x31, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x31, 0xfffffeff)

    # Testcase 11:  imm:0x9ae, result rd:x23(0xfffff7ff)
    la  x1, test_data
    addi    x1, x1,44
    li     x3, MASK_XLEN(1618)
    add    x1, x1, x3
    lw x23, -1618(x1)
    sw x23, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x23, 0xfffff7ff)



    

    RVTEST_SIGBASE(x3,signature_5_0)

    # Testcase 12:  imm:0x650, result rd:x21(0xffffefff)
    la  x2, test_data
    addi    x2, x2,48
    li     x4, MASK_XLEN(-1616)
    add    x2, x2, x4
    lw x21, 1616(x2)
    sw x21, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x21, 0xffffefff)

    # Testcase 13:  imm:0x71, result rd:x30(0xffffdfff)
    la  x1, test_data
    addi    x1, x1,52
    li     x4, MASK_XLEN(-113)
    add    x1, x1, x4
    lw x30, 113(x1)
    sw x30, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x30, 0xffffdfff)

    # Testcase 14:  imm:0xdd8, result rd:x17(0xffffefff)
    la  x1, test_data
    addi    x1, x1,56
    li     x4, MASK_XLEN(552)
    add    x1, x1, x4
    lw x17, -552(x1)
    sw x17, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x17, 0xffffefff)



    

    RVTEST_SIGBASE(x1,signature_6_0)

    # Testcase 15:  imm:0xb6d, result rd:x6(0xffff7fff)
    la  x12, test_data
    addi    x12, x12,60
    li     x3, MASK_XLEN(1171)
    add    x12, x12, x3
    lw x6, -1171(x12)
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x6, 0xffff7fff)

    # Testcase 16:  imm:0x8a5, result rd:x22(0xfffeffff)
    la  x10, test_data
    addi    x10, x10,64
    li     x3, MASK_XLEN(1883)
    add    x10, x10, x3
    lw x22, -1883(x10)
    sw x22, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x22, 0xfffeffff)

    # Testcase 17:  imm:0x621, result rd:x2(0xfffdffff)
    la  x8, test_data
    addi    x8, x8,68
    li     x3, MASK_XLEN(-1569)
    add    x8, x8, x3
    lw x2, 1569(x8)
    sw x2, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x2, 0xfffdffff)



    

    RVTEST_SIGBASE(x1,signature_7_0)

    # Testcase 18:  imm:0xba8, result rd:x13(0xfffbffff)
    la  x8, test_data
    addi    x8, x8,72
    li     x2, MASK_XLEN(1112)
    add    x8, x8, x2
    lw x13, -1112(x8)
    sw x13, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x13, 0xfffbffff)

    # Testcase 19:  imm:0x81b, result rd:x3(0xfff7ffff)
    la  x14, test_data
    addi    x14, x14,76
    li     x2, MASK_XLEN(2021)
    add    x14, x14, x2
    lw x3, -2021(x14)
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x3, 0xfff7ffff)

    # Testcase 20:  imm:0xd8c, result rd:x24(0xffefffff)
    la  x13, test_data
    addi    x13, x13,80
    li     x2, MASK_XLEN(628)
    add    x13, x13, x2
    lw x24, -628(x13)
    sw x24, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x24, 0xffefffff)



    

    RVTEST_SIGBASE(x2,signature_8_0)

    # Testcase 21:  imm:0xeb5, result rd:x3(0xffdfffff)
    la  x18, test_data
    addi    x18, x18,84
    li     x4, MASK_XLEN(331)
    add    x18, x18, x4
    lw x3, -331(x18)
    sw x3, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x3, 0xffdfffff)

    # Testcase 22:  imm:0xd04, result rd:x14(0xffbfffff)
    la  x1, test_data
    addi    x1, x1,88
    li     x4, MASK_XLEN(764)
    add    x1, x1, x4
    lw x14, -764(x1)
    sw x14, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x14, 0xffbfffff)

    # Testcase 23:  imm:0x686, result rd:x20(0xff7fffff)
    la  x19, test_data
    addi    x19, x19,92
    li     x4, MASK_XLEN(-1670)
    add    x19, x19, x4
    lw x20, 1670(x19)
    sw x20, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x20, 0xff7fffff)



    

    RVTEST_SIGBASE(x1,signature_9_0)

    # Testcase 24:  imm:0x92c, result rd:x4(0xfeffffff)
    la  x30, test_data
    addi    x30, x30,96
    li     x3, MASK_XLEN(1748)
    add    x30, x30, x3
    lw x4, -1748(x30)
    sw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x4, 0xfeffffff)

    # Testcase 25:  imm:0x156, result rd:x29(0xfdffffff)
    la  x31, test_data
    addi    x31, x31,100
    li     x3, MASK_XLEN(-342)
    add    x31, x31, x3
    lw x29, 342(x31)
    sw x29, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x29, 0xfdffffff)

    # Testcase 26:  imm:0x1d4, result rd:x17(0xfeffffff)
    la  x2, test_data
    addi    x2, x2,104
    li     x3, MASK_XLEN(-468)
    add    x2, x2, x3
    lw x17, 468(x2)
    sw x17, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x17, 0xfeffffff)



    

    RVTEST_SIGBASE(x1,signature_10_0)

    # Testcase 27:  imm:0x678, result rd:x22(0xf7ffffff)
    la  x4, test_data
    addi    x4, x4,108
    li     x2, MASK_XLEN(-1656)
    add    x4, x4, x2
    lw x22, 1656(x4)
    sw x22, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x22, 0xf7ffffff)

    # Testcase 28:  imm:0xddc, result rd:x3(0xefffffff)
    la  x20, test_data
    addi    x20, x20,112
    li     x2, MASK_XLEN(548)
    add    x20, x20, x2
    lw x3, -548(x20)
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x3, 0xefffffff)

    # Testcase 29:  imm:0x532, result rd:x15(0xdfffffff)
    la  x14, test_data
    addi    x14, x14,116
    li     x2, MASK_XLEN(-1330)
    add    x14, x14, x2
    lw x15, 1330(x14)
    sw x15, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x15, 0xdfffffff)



    

    RVTEST_SIGBASE(x1,signature_11_0)

    # Testcase 30:  imm:0x0, result rd:x28(0xefffffff)
    la  x7, test_data
    addi    x7, x7,120
    li     x2, MASK_XLEN(0)
    add    x7, x7, x2
    lw x28, 0(x7)
    sw x28, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x28, 0xefffffff)

    # Testcase 31:  imm:0xfff, result rd:x14(0x7fffffff)
    la  x7, test_data
    addi    x7, x7,124
    li     x2, MASK_XLEN(1)
    add    x7, x7, x2
    lw x14, -1(x7)
    sw x14, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x14, 0x7fffffff)

    # Testcase 32:  imm:0xfff, result rd:x9(0xffffffff)
    la  x18, test_data
    addi    x18, x18,128
    li     x2, MASK_XLEN(1)
    add    x18, x18, x2
    lw x9, -1(x18)
    sw x9, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xffffffff)



    

    RVTEST_SIGBASE(x1,signature_12_0)

    # Testcase 33:  imm:0xfff, result rd:x10(0x00000001)
    la  x15, test_data
    addi    x15, x15,132
    li     x3, MASK_XLEN(1)
    add    x15, x15, x3
    lw x10, -1(x15)
    sw x10, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x10, 0x00000001)

    # Testcase 34:  imm:0x0, result rd:x6(0x00000002)
    la  x23, test_data
    addi    x23, x23,136
    li     x3, MASK_XLEN(0)
    add    x23, x23, x3
    lw x6, 0(x23)
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x6, 0x00000002)

    # Testcase 35:  imm:0xfff, result rd:x0(0x00000000)
    la  x2, test_data
    addi    x2, x2,140
    li     x3, MASK_XLEN(1)
    add    x2, x2, x3
    lw x0, -1(x2)
    sw x0, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x0, 0x00000000)



    

    RVTEST_SIGBASE(x2,signature_13_0)

    # Testcase 36:  imm:0xfff, result rd:x19(0x00000008)
    la  x29, test_data
    addi    x29, x29,144
    li     x3, MASK_XLEN(1)
    add    x29, x29, x3
    lw x19, -1(x29)
    sw x19, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x19, 0x00000008)

    # Testcase 37:  imm:0xfff, result rd:x19(0x00000010)
    la  x1, test_data
    addi    x1, x1,148
    li     x3, MASK_XLEN(1)
    add    x1, x1, x3
    lw x19, -1(x1)
    sw x19, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x19, 0x00000010)

    # Testcase 38:  imm:0x0, result rd:x30(0x00000020)
    la  x28, test_data
    addi    x28, x28,152
    li     x3, MASK_XLEN(0)
    add    x28, x28, x3
    lw x30, 0(x28)
    sw x30, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x30, 0x00000020)



    

    RVTEST_SIGBASE(x3,signature_14_0)

    # Testcase 39:  imm:0xfff, result rd:x21(0x00000040)
    la  x24, test_data
    addi    x24, x24,156
    li     x4, MASK_XLEN(1)
    add    x24, x24, x4
    lw x21, -1(x24)
    sw x21, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x21, 0x00000040)

    # Testcase 40:  imm:0x1, result rd:x1(0x00000080)
    la  x2, test_data
    addi    x2, x2,160
    li     x4, MASK_XLEN(-1)
    add    x2, x2, x4
    lw x1, 1(x2)
    sw x1, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x1, 0x00000080)

    # Testcase 41:  imm:0x2, result rd:x1(0x00000100)
    la  x2, test_data
    addi    x2, x2,164
    li     x4, MASK_XLEN(-2)
    add    x2, x2, x4
    lw x1, 2(x2)
    sw x1, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x1, 0x00000100)



    

    RVTEST_SIGBASE(x1,signature_15_0)

    # Testcase 42:  imm:0x4, result rd:x2(0x00000200)
    la  x3, test_data
    addi    x3, x3,168
    li     x6, MASK_XLEN(-4)
    add    x3, x3, x6
    lw x2, 4(x3)
    sw x2, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x2, 0x00000200)

    # Testcase 43:  imm:0x8, result rd:x3(0x00000400)
    la  x4, test_data
    addi    x4, x4,172
    li     x6, MASK_XLEN(-8)
    add    x4, x4, x6
    lw x3, 8(x4)
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x3, 0x00000400)

    # Testcase 44:  imm:0x10, result rd:x4(0x00000800)
    la  x5, test_data
    addi    x5, x5,176
    li     x6, MASK_XLEN(-16)
    add    x5, x5, x6
    lw x4, 16(x5)
    sw x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x4, 0x00000800)



    

    RVTEST_SIGBASE(x1,signature_16_0)

    # Testcase 45:  imm:0x20, result rd:x5(0x00001000)
    la  x6, test_data
    addi    x6, x6,180
    li     x2, MASK_XLEN(-32)
    add    x6, x6, x2
    lw x5, 32(x6)
    sw x5, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x5, 0x00001000)

    # Testcase 46:  imm:0x40, result rd:x6(0x00002000)
    la  x7, test_data
    addi    x7, x7,184
    li     x2, MASK_XLEN(-64)
    add    x7, x7, x2
    lw x6, 64(x7)
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x6, 0x00002000)

    # Testcase 47:  imm:0x80, result rd:x7(0x00004000)
    la  x8, test_data
    addi    x8, x8,188
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    lw x7, 128(x8)
    sw x7, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x7, 0x00004000)



    

    RVTEST_SIGBASE(x1,signature_17_0)

    # Testcase 48:  imm:0x100, result rd:x8(0x00008000)
    la  x9, test_data
    addi    x9, x9,192
    li     x2, MASK_XLEN(-256)
    add    x9, x9, x2
    lw x8, 256(x9)
    sw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x8, 0x00008000)

    # Testcase 49:  imm:0x200, result rd:x9(0x00000001)
    la  x10, test_data
    addi    x10, x10,196
    li     x2, MASK_XLEN(-512)
    add    x10, x10, x2
    lw x9, 512(x10)
    sw x9, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0x00000001)

    # Testcase 50:  imm:0x400, result rd:x10(0x00000002)
    la  x11, test_data
    addi    x11, x11,200
    li     x2, MASK_XLEN(-1024)
    add    x11, x11, x2
    lw x10, 1024(x11)
    sw x10, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x10, 0x00000002)



    

    RVTEST_SIGBASE(x1,signature_18_0)

    # Testcase 51:  imm:0x800, result rd:x11(0x00040000)
    la  x12, test_data
    addi    x12, x12,204
    li     x2, MASK_XLEN(2048)
    add    x12, x12, x2
    lw x11, -2048(x12)
    sw x11, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x11, 0x00040000)

    # Testcase 52:  imm:0xffe, result rd:x12(0x00080000)
    la  x13, test_data
    addi    x13, x13,208
    li     x2, MASK_XLEN(2)
    add    x13, x13, x2
    lw x12, -2(x13)
    sw x12, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x12, 0x00080000)

    # Testcase 53:  imm:0xffd, result rd:x13(0x00000010)
    la  x14, test_data
    addi    x14, x14,212
    li     x2, MASK_XLEN(3)
    add    x14, x14, x2
    lw x13, -3(x14)
    sw x13, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x13, 0x00000010)



    

    RVTEST_SIGBASE(x1,signature_19_0)

    # Testcase 54:  imm:0xffb, result rd:x14(0x00000020)
    la  x15, test_data
    addi    x15, x15,216
    li     x2, MASK_XLEN(5)
    add    x15, x15, x2
    lw x14, -5(x15)
    sw x14, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x14, 0x00000020)

    # Testcase 55:  imm:0xff7, result rd:x15(0x00400000)
    la  x16, test_data
    addi    x16, x16,220
    li     x2, MASK_XLEN(9)
    add    x16, x16, x2
    lw x15, -9(x16)
    sw x15, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x15, 0x00400000)

    # Testcase 56:  imm:0xfef, result rd:x16(0x00800000)
    la  x17, test_data
    addi    x17, x17,224
    li     x2, MASK_XLEN(17)
    add    x17, x17, x2
    lw x16, -17(x17)
    sw x16, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x16, 0x00800000)



    

    RVTEST_SIGBASE(x1,signature_20_0)

    # Testcase 57:  imm:0xfdf, result rd:x17(0x00000100)
    la  x18, test_data
    addi    x18, x18,228
    li     x2, MASK_XLEN(33)
    add    x18, x18, x2
    lw x17, -33(x18)
    sw x17, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x17, 0x00000100)

    # Testcase 58:  imm:0xfbf, result rd:x18(0x00000200)
    la  x19, test_data
    addi    x19, x19,232
    li     x2, MASK_XLEN(65)
    add    x19, x19, x2
    lw x18, -65(x19)
    sw x18, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x18, 0x00000200)

    # Testcase 59:  imm:0xf7f, result rd:x19(0x04000000)
    la  x20, test_data
    addi    x20, x20,236
    li     x2, MASK_XLEN(129)
    add    x20, x20, x2
    lw x19, -129(x20)
    sw x19, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x19, 0x04000000)



    

    RVTEST_SIGBASE(x1,signature_21_0)

    # Testcase 60:  imm:0xeff, result rd:x20(0x08000000)
    la  x21, test_data
    addi    x21, x21,240
    li     x2, MASK_XLEN(257)
    add    x21, x21, x2
    lw x20, -257(x21)
    sw x20, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x20, 0x08000000)

    # Testcase 61:  imm:0xdff, result rd:x21(0x00001000)
    la  x22, test_data
    addi    x22, x22,244
    li     x2, MASK_XLEN(513)
    add    x22, x22, x2
    lw x21, -513(x22)
    sw x21, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x21, 0x00001000)

    # Testcase 62:  imm:0xbff, result rd:x22(0x00002000)
    la  x23, test_data
    addi    x23, x23,248
    li     x2, MASK_XLEN(1025)
    add    x23, x23, x2
    lw x22, -1025(x23)
    sw x22, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x22, 0x00002000)



    

    RVTEST_SIGBASE(x1,signature_22_0)

    # Testcase 63:  imm:0x7ff, result rd:x23(0x40000000)
    la  x24, test_data
    addi    x24, x24,252
    li     x2, MASK_XLEN(-2047)
    add    x24, x24, x2
    lw x23, 2047(x24)
    sw x23, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x23, 0x40000000)

    # Testcase 64:  imm:0xffe, result rd:x24(0x80000000)
    la  x25, test_data
    addi    x25, x25,256
    li     x2, MASK_XLEN(2)
    add    x25, x25, x2
    lw x24, -2(x25)
    sw x24, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x24, 0x80000000)

    # Testcase 65:  imm:0xffd, result rd:x25(0x00000000)
    la  x26, test_data
    addi    x26, x26,260
    li     x2, MASK_XLEN(3)
    add    x26, x26, x2
    lw x25, -3(x26)
    sw x25, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x25, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_23_0)

    # Testcase 66:  imm:0xffb, result rd:x26(0xfffffffe)
    la  x27, test_data
    addi    x27, x27,0
    li     x2, MASK_XLEN(5)
    add    x27, x27, x2
    lw x26, -5(x27)
    sw x26, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x26, 0xfffffffe)

    # Testcase 67:  imm:0xff7, result rd:x27(0xfffffffd)
    la  x28, test_data
    addi    x28, x28,4
    li     x2, MASK_XLEN(9)
    add    x28, x28, x2
    lw x27, -9(x28)
    sw x27, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x27, 0xfffffffd)

    # Testcase 68:  imm:0xfef, result rd:x28(0xfffffffb)
    la  x29, test_data
    addi    x29, x29,8
    li     x2, MASK_XLEN(17)
    add    x29, x29, x2
    lw x28, -17(x29)
    sw x28, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x28, 0xfffffffb)



    

    RVTEST_SIGBASE(x2,signature_24_0)

    # Testcase 69:  imm:0xfdf, result rd:x29(0xfffffff7)
    la  x30, test_data
    addi    x30, x30,12
    li     x3, MASK_XLEN(33)
    add    x30, x30, x3
    lw x29, -33(x30)
    sw x29, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x29, 0xfffffff7)

    # Testcase 70:  imm:0xfbf, result rd:x30(0xffffffef)
    la  x31, test_data
    addi    x31, x31,16
    li     x3, MASK_XLEN(65)
    add    x31, x31, x3
    lw x30, -65(x31)
    sw x30, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x30, 0xffffffef)

    # Testcase 71:  imm:0xf7f, result rd:x31(0xffffffdf)
    la  x1, test_data
    addi    x1, x1,20
    li     x3, MASK_XLEN(129)
    add    x1, x1, x3
    lw x31, -129(x1)
    sw x31, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x31, 0xffffffdf)



    

    RVTEST_SIGBASE(x4,signature_25_0)

    # Testcase 72:  imm:0xeff, result rd:x1(0xffffffbf)
    la  x2, test_data
    addi    x2, x2,24
    li     x5, MASK_XLEN(257)
    add    x2, x2, x5
    lw x1, -257(x2)
    sw x1, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x1, 0xffffffbf)

    # Testcase 73:  imm:0xdff, result rd:x1(0xffffff7f)
    la  x2, test_data
    addi    x2, x2,28
    li     x5, MASK_XLEN(513)
    add    x2, x2, x5
    lw x1, -513(x2)
    sw x1, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x1, 0xffffff7f)

    # Testcase 74:  imm:0xbff, result rd:x2(0xfffffeff)
    la  x3, test_data
    addi    x3, x3,32
    li     x5, MASK_XLEN(1025)
    add    x3, x3, x5
    lw x2, -1025(x3)
    sw x2, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x2, 0xfffffeff)



    

    RVTEST_SIGBASE(x1,signature_26_0)

    # Testcase 75:  imm:0x7ff, result rd:x3(0xfffffdff)
    la  x4, test_data
    addi    x4, x4,36
    li     x2, MASK_XLEN(-2047)
    add    x4, x4, x2
    lw x3, 2047(x4)
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x3, 0xfffffdff)

    # Testcase 76:  imm:0xffe, result rd:x4(0xfffffeff)
    la  x5, test_data
    addi    x5, x5,40
    li     x2, MASK_XLEN(2)
    add    x5, x5, x2
    lw x4, -2(x5)
    sw x4, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x4, 0xfffffeff)

    # Testcase 77:  imm:0xffd, result rd:x5(0xfffff7ff)
    la  x6, test_data
    addi    x6, x6,44
    li     x2, MASK_XLEN(3)
    add    x6, x6, x2
    lw x5, -3(x6)
    sw x5, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x5, 0xfffff7ff)



    

    RVTEST_SIGBASE(x1,signature_27_0)

    # Testcase 78:  imm:0xffb, result rd:x6(0xffffefff)
    la  x7, test_data
    addi    x7, x7,48
    li     x2, MASK_XLEN(5)
    add    x7, x7, x2
    lw x6, -5(x7)
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x6, 0xffffefff)

    # Testcase 79:  imm:0xff7, result rd:x7(0xffffdfff)
    la  x8, test_data
    addi    x8, x8,52
    li     x2, MASK_XLEN(9)
    add    x8, x8, x2
    lw x7, -9(x8)
    sw x7, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x7, 0xffffdfff)

    # Testcase 80:  imm:0xfef, result rd:x8(0xffffefff)
    la  x9, test_data
    addi    x9, x9,56
    li     x2, MASK_XLEN(17)
    add    x9, x9, x2
    lw x8, -17(x9)
    sw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x8, 0xffffefff)



    

    RVTEST_SIGBASE(x1,signature_28_0)

    # Testcase 81:  imm:0xfdf, result rd:x9(0xffff7fff)
    la  x10, test_data
    addi    x10, x10,60
    li     x2, MASK_XLEN(33)
    add    x10, x10, x2
    lw x9, -33(x10)
    sw x9, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xffff7fff)

    # Testcase 82:  imm:0xfbf, result rd:x10(0xfffeffff)
    la  x11, test_data
    addi    x11, x11,64
    li     x2, MASK_XLEN(65)
    add    x11, x11, x2
    lw x10, -65(x11)
    sw x10, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x10, 0xfffeffff)

    # Testcase 83:  imm:0xf7f, result rd:x11(0xfffdffff)
    la  x12, test_data
    addi    x12, x12,68
    li     x2, MASK_XLEN(129)
    add    x12, x12, x2
    lw x11, -129(x12)
    sw x11, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x11, 0xfffdffff)



    

    RVTEST_SIGBASE(x1,signature_29_0)

    # Testcase 84:  imm:0xeff, result rd:x12(0xfffbffff)
    la  x13, test_data
    addi    x13, x13,72
    li     x2, MASK_XLEN(257)
    add    x13, x13, x2
    lw x12, -257(x13)
    sw x12, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x12, 0xfffbffff)

    # Testcase 85:  imm:0xdff, result rd:x13(0xfff7ffff)
    la  x14, test_data
    addi    x14, x14,76
    li     x2, MASK_XLEN(513)
    add    x14, x14, x2
    lw x13, -513(x14)
    sw x13, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x13, 0xfff7ffff)

    # Testcase 86:  imm:0xbff, result rd:x14(0xffefffff)
    la  x15, test_data
    addi    x15, x15,80
    li     x2, MASK_XLEN(1025)
    add    x15, x15, x2
    lw x14, -1025(x15)
    sw x14, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x14, 0xffefffff)



    

    RVTEST_SIGBASE(x1,signature_30_0)

    # Testcase 87:  imm:0x7ff, result rd:x15(0xffdfffff)
    la  x16, test_data
    addi    x16, x16,84
    li     x2, MASK_XLEN(-2047)
    add    x16, x16, x2
    lw x15, 2047(x16)
    sw x15, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x15, 0xffdfffff)

    # Testcase 88:  imm:0xffe, result rd:x16(0xffbfffff)
    la  x17, test_data
    addi    x17, x17,88
    li     x2, MASK_XLEN(2)
    add    x17, x17, x2
    lw x16, -2(x17)
    sw x16, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x16, 0xffbfffff)

    # Testcase 89:  imm:0xffd, result rd:x17(0xff7fffff)
    la  x18, test_data
    addi    x18, x18,92
    li     x2, MASK_XLEN(3)
    add    x18, x18, x2
    lw x17, -3(x18)
    sw x17, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x17, 0xff7fffff)



    

    RVTEST_SIGBASE(x1,signature_31_0)

    # Testcase 90:  imm:0xffb, result rd:x18(0xfeffffff)
    la  x19, test_data
    addi    x19, x19,96
    li     x2, MASK_XLEN(5)
    add    x19, x19, x2
    lw x18, -5(x19)
    sw x18, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x18, 0xfeffffff)

    # Testcase 91:  imm:0xff7, result rd:x19(0xfdffffff)
    la  x20, test_data
    addi    x20, x20,100
    li     x2, MASK_XLEN(9)
    add    x20, x20, x2
    lw x19, -9(x20)
    sw x19, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x19, 0xfdffffff)

    # Testcase 92:  imm:0xfef, result rd:x20(0xfeffffff)
    la  x21, test_data
    addi    x21, x21,104
    li     x2, MASK_XLEN(17)
    add    x21, x21, x2
    lw x20, -17(x21)
    sw x20, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x20, 0xfeffffff)



    

    RVTEST_SIGBASE(x1,signature_32_0)

    # Testcase 93:  imm:0xfdf, result rd:x21(0xf7ffffff)
    la  x22, test_data
    addi    x22, x22,108
    li     x2, MASK_XLEN(33)
    add    x22, x22, x2
    lw x21, -33(x22)
    sw x21, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x21, 0xf7ffffff)

    # Testcase 94:  imm:0xfbf, result rd:x22(0xefffffff)
    la  x23, test_data
    addi    x23, x23,112
    li     x2, MASK_XLEN(65)
    add    x23, x23, x2
    lw x22, -65(x23)
    sw x22, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x22, 0xefffffff)

    # Testcase 95:  imm:0xf7f, result rd:x23(0xdfffffff)
    la  x24, test_data
    addi    x24, x24,116
    li     x2, MASK_XLEN(129)
    add    x24, x24, x2
    lw x23, -129(x24)
    sw x23, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x23, 0xdfffffff)



    

    RVTEST_SIGBASE(x1,signature_33_0)

    # Testcase 96:  imm:0xeff, result rd:x24(0xefffffff)
    la  x25, test_data
    addi    x25, x25,120
    li     x2, MASK_XLEN(257)
    add    x25, x25, x2
    lw x24, -257(x25)
    sw x24, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x24, 0xefffffff)

    # Testcase 97:  imm:0xdff, result rd:x25(0x7fffffff)
    la  x26, test_data
    addi    x26, x26,124
    li     x2, MASK_XLEN(513)
    add    x26, x26, x2
    lw x25, -513(x26)
    sw x25, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x25, 0x7fffffff)

    # Testcase 98:  imm:0xbff, result rd:x26(0xffffffff)
    la  x27, test_data
    addi    x27, x27,128
    li     x2, MASK_XLEN(1025)
    add    x27, x27, x2
    lw x26, -1025(x27)
    sw x26, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x26, 0xffffffff)



    

    RVTEST_SIGBASE(x1,signature_34_0)

    # Testcase 99:  imm:0x7ff, result rd:x27(0x00000001)
    la  x28, test_data
    addi    x28, x28,132
    li     x2, MASK_XLEN(-2047)
    add    x28, x28, x2
    lw x27, 2047(x28)
    sw x27, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x27, 0x00000001)

    # Testcase 100:  imm:0xffe, result rd:x28(0x00000002)
    la  x29, test_data
    addi    x29, x29,136
    li     x2, MASK_XLEN(2)
    add    x29, x29, x2
    lw x28, -2(x29)
    sw x28, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x28, 0x00000002)

    # Testcase 101:  imm:0xffd, result rd:x29(0x00000004)
    la  x30, test_data
    addi    x30, x30,140
    li     x2, MASK_XLEN(3)
    add    x30, x30, x2
    lw x29, -3(x30)
    sw x29, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x29, 0x00000004)



    

    RVTEST_SIGBASE(x3,signature_35_0)

    # Testcase 102:  imm:0xffb, result rd:x30(0x00000008)
    la  x31, test_data
    addi    x31, x31,144
    li     x4, MASK_XLEN(5)
    add    x31, x31, x4
    lw x30, -5(x31)
    sw x30, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x30, 0x00000008)

    # Testcase 103:  imm:0xff7, result rd:x31(0x00000010)
    la  x1, test_data
    addi    x1, x1,148
    li     x4, MASK_XLEN(9)
    add    x1, x1, x4
    lw x31, -9(x1)
    sw x31, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x31, 0x00000010)

    # Testcase 104:  imm:0x1, result rd:x1(0x00000020)
    la  x2, test_data
    addi    x2, x2,152
    li     x4, MASK_XLEN(-1)
    add    x2, x2, x4
    lw x1, 1(x2)
    sw x1, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x1, 0x00000020)



    

    RVTEST_SIGBASE(x5,signature_36_0)

    # Testcase 105:  imm:0x2, result rd:x1(0x00000040)
    la  x2, test_data
    addi    x2, x2,156
    li     x6, MASK_XLEN(-2)
    add    x2, x2, x6
    lw x1, 2(x2)
    sw x1, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x1, 0x00000040)

    # Testcase 106:  imm:0x4, result rd:x2(0x00000080)
    la  x3, test_data
    addi    x3, x3,160
    li     x6, MASK_XLEN(-4)
    add    x3, x3, x6
    lw x2, 4(x3)
    sw x2, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x2, 0x00000080)

    # Testcase 107:  imm:0x8, result rd:x3(0x00000100)
    la  x4, test_data
    addi    x4, x4,164
    li     x6, MASK_XLEN(-8)
    add    x4, x4, x6
    lw x3, 8(x4)
    sw x3, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x3, 0x00000100)



    

    RVTEST_SIGBASE(x1,signature_37_0)

    # Testcase 108:  imm:0x10, result rd:x4(0x00000200)
    la  x5, test_data
    addi    x5, x5,168
    li     x2, MASK_XLEN(-16)
    add    x5, x5, x2
    lw x4, 16(x5)
    sw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000200)

    # Testcase 109:  imm:0x20, result rd:x5(0x00000400)
    la  x6, test_data
    addi    x6, x6,172
    li     x2, MASK_XLEN(-32)
    add    x6, x6, x2
    lw x5, 32(x6)
    sw x5, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x5, 0x00000400)

    # Testcase 110:  imm:0x40, result rd:x6(0x00000800)
    la  x7, test_data
    addi    x7, x7,176
    li     x2, MASK_XLEN(-64)
    add    x7, x7, x2
    lw x6, 64(x7)
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x6, 0x00000800)



    

    RVTEST_SIGBASE(x1,signature_38_0)

    # Testcase 111:  imm:0x80, result rd:x7(0x00001000)
    la  x8, test_data
    addi    x8, x8,180
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    lw x7, 128(x8)
    sw x7, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x7, 0x00001000)

    # Testcase 112:  imm:0x100, result rd:x8(0x00002000)
    la  x9, test_data
    addi    x9, x9,184
    li     x2, MASK_XLEN(-256)
    add    x9, x9, x2
    lw x8, 256(x9)
    sw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x8, 0x00002000)

    # Testcase 113:  imm:0x200, result rd:x9(0x00004000)
    la  x10, test_data
    addi    x10, x10,188
    li     x2, MASK_XLEN(-512)
    add    x10, x10, x2
    lw x9, 512(x10)
    sw x9, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0x00004000)



    

    RVTEST_SIGBASE(x1,signature_39_0)

    # Testcase 114:  imm:0x400, result rd:x10(0x00008000)
    la  x11, test_data
    addi    x11, x11,192
    li     x2, MASK_XLEN(-1024)
    add    x11, x11, x2
    lw x10, 1024(x11)
    sw x10, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x10, 0x00008000)

    # Testcase 115:  imm:0x800, result rd:x11(0x00000001)
    la  x12, test_data
    addi    x12, x12,196
    li     x2, MASK_XLEN(2048)
    add    x12, x12, x2
    lw x11, -2048(x12)
    sw x11, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x11, 0x00000001)

    # Testcase 116:  imm:0xffe, result rd:x12(0x00000002)
    la  x13, test_data
    addi    x13, x13,200
    li     x2, MASK_XLEN(2)
    add    x13, x13, x2
    lw x12, -2(x13)
    sw x12, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x12, 0x00000002)



    

    RVTEST_SIGBASE(x1,signature_40_0)

    # Testcase 117:  imm:0xffd, result rd:x13(0x00040000)
    la  x14, test_data
    addi    x14, x14,204
    li     x2, MASK_XLEN(3)
    add    x14, x14, x2
    lw x13, -3(x14)
    sw x13, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x13, 0x00040000)

    # Testcase 118:  imm:0xffb, result rd:x14(0x00080000)
    la  x15, test_data
    addi    x15, x15,208
    li     x2, MASK_XLEN(5)
    add    x15, x15, x2
    lw x14, -5(x15)
    sw x14, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x14, 0x00080000)

    # Testcase 119:  imm:0xff7, result rd:x15(0x00000010)
    la  x16, test_data
    addi    x16, x16,212
    li     x2, MASK_XLEN(9)
    add    x16, x16, x2
    lw x15, -9(x16)
    sw x15, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x15, 0x00000010)



    

    RVTEST_SIGBASE(x1,signature_41_0)

    # Testcase 120:  imm:0xfef, result rd:x16(0x00000020)
    la  x17, test_data
    addi    x17, x17,216
    li     x2, MASK_XLEN(17)
    add    x17, x17, x2
    lw x16, -17(x17)
    sw x16, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x16, 0x00000020)

    # Testcase 121:  imm:0xfdf, result rd:x17(0x00400000)
    la  x18, test_data
    addi    x18, x18,220
    li     x2, MASK_XLEN(33)
    add    x18, x18, x2
    lw x17, -33(x18)
    sw x17, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x17, 0x00400000)

    # Testcase 122:  imm:0xfbf, result rd:x18(0x00800000)
    la  x19, test_data
    addi    x19, x19,224
    li     x2, MASK_XLEN(65)
    add    x19, x19, x2
    lw x18, -65(x19)
    sw x18, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x18, 0x00800000)



    

    RVTEST_SIGBASE(x1,signature_42_0)

    # Testcase 123:  imm:0xf7f, result rd:x19(0x00000100)
    la  x20, test_data
    addi    x20, x20,228
    li     x2, MASK_XLEN(129)
    add    x20, x20, x2
    lw x19, -129(x20)
    sw x19, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x19, 0x00000100)

    # Testcase 124:  imm:0xeff, result rd:x20(0x00000200)
    la  x21, test_data
    addi    x21, x21,232
    li     x2, MASK_XLEN(257)
    add    x21, x21, x2
    lw x20, -257(x21)
    sw x20, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x20, 0x00000200)

    # Testcase 125:  imm:0xdff, result rd:x21(0x04000000)
    la  x22, test_data
    addi    x22, x22,236
    li     x2, MASK_XLEN(513)
    add    x22, x22, x2
    lw x21, -513(x22)
    sw x21, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x21, 0x04000000)



    

    RVTEST_SIGBASE(x1,signature_43_0)

    # Testcase 126:  imm:0xbff, result rd:x22(0x08000000)
    la  x23, test_data
    addi    x23, x23,240
    li     x2, MASK_XLEN(1025)
    add    x23, x23, x2
    lw x22, -1025(x23)
    sw x22, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x22, 0x08000000)

    # Testcase 127:  imm:0x7ff, result rd:x23(0x00001000)
    la  x24, test_data
    addi    x24, x24,244
    li     x2, MASK_XLEN(-2047)
    add    x24, x24, x2
    lw x23, 2047(x24)
    sw x23, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x23, 0x00001000)

    # Testcase 128:  imm:0xffe, result rd:x24(0x00002000)
    la  x25, test_data
    addi    x25, x25,248
    li     x2, MASK_XLEN(2)
    add    x25, x25, x2
    lw x24, -2(x25)
    sw x24, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x24, 0x00002000)



    

    RVTEST_SIGBASE(x1,signature_44_0)

    # Testcase 129:  imm:0xffd, result rd:x25(0x40000000)
    la  x26, test_data
    addi    x26, x26,252
    li     x2, MASK_XLEN(3)
    add    x26, x26, x2
    lw x25, -3(x26)
    sw x25, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x25, 0x40000000)

    # Testcase 130:  imm:0xffb, result rd:x26(0x80000000)
    la  x27, test_data
    addi    x27, x27,256
    li     x2, MASK_XLEN(5)
    add    x27, x27, x2
    lw x26, -5(x27)
    sw x26, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x26, 0x80000000)

    # Testcase 131:  imm:0xff7, result rd:x27(0x00000000)
    la  x28, test_data
    addi    x28, x28,260
    li     x2, MASK_XLEN(9)
    add    x28, x28, x2
    lw x27, -9(x28)
    sw x27, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x27, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_45_0)

    # Testcase 132:  imm:0xfef, result rd:x28(0xfffffffe)
    la  x29, test_data
    addi    x29, x29,0
    li     x2, MASK_XLEN(17)
    add    x29, x29, x2
    lw x28, -17(x29)
    sw x28, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x28, 0xfffffffe)

    # Testcase 133:  imm:0xfdf, result rd:x29(0xfffffffd)
    la  x30, test_data
    addi    x30, x30,4
    li     x2, MASK_XLEN(33)
    add    x30, x30, x2
    lw x29, -33(x30)
    sw x29, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x29, 0xfffffffd)

    # Testcase 134:  imm:0xfbf, result rd:x30(0xfffffffb)
    la  x31, test_data
    addi    x31, x31,8
    li     x2, MASK_XLEN(65)
    add    x31, x31, x2
    lw x30, -65(x31)
    sw x30, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x30, 0xfffffffb)



    

    RVTEST_SIGBASE(x3,signature_46_0)

    # Testcase 135:  imm:0xf7f, result rd:x31(0xfffffff7)
    la  x1, test_data
    addi    x1, x1,12
    li     x4, MASK_XLEN(129)
    add    x1, x1, x4
    lw x31, -129(x1)
    sw x31, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x31, 0xfffffff7)

    # Testcase 136:  imm:0xeff, result rd:x1(0xffffffef)
    la  x2, test_data
    addi    x2, x2,16
    li     x4, MASK_XLEN(257)
    add    x2, x2, x4
    lw x1, -257(x2)
    sw x1, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x1, 0xffffffef)

    # Testcase 137:  imm:0xdff, result rd:x1(0xffffffdf)
    la  x2, test_data
    addi    x2, x2,20
    li     x4, MASK_XLEN(513)
    add    x2, x2, x4
    lw x1, -513(x2)
    sw x1, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x1, 0xffffffdf)



    

    RVTEST_SIGBASE(x1,signature_47_0)

    # Testcase 138:  imm:0xbff, result rd:x2(0xffffffbf)
    la  x3, test_data
    addi    x3, x3,24
    li     x6, MASK_XLEN(1025)
    add    x3, x3, x6
    lw x2, -1025(x3)
    sw x2, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x2, 0xffffffbf)

    # Testcase 139:  imm:0x7ff, result rd:x3(0xffffff7f)
    la  x4, test_data
    addi    x4, x4,28
    li     x6, MASK_XLEN(-2047)
    add    x4, x4, x6
    lw x3, 2047(x4)
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x3, 0xffffff7f)

    # Testcase 140:  imm:0xffe, result rd:x4(0xfffffeff)
    la  x5, test_data
    addi    x5, x5,32
    li     x6, MASK_XLEN(2)
    add    x5, x5, x6
    lw x4, -2(x5)
    sw x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x4, 0xfffffeff)



    

    RVTEST_SIGBASE(x1,signature_48_0)

    # Testcase 141:  imm:0xffd, result rd:x5(0xfffffdff)
    la  x6, test_data
    addi    x6, x6,36
    li     x2, MASK_XLEN(3)
    add    x6, x6, x2
    lw x5, -3(x6)
    sw x5, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x5, 0xfffffdff)

    # Testcase 142:  imm:0xffb, result rd:x6(0xfffffeff)
    la  x7, test_data
    addi    x7, x7,40
    li     x2, MASK_XLEN(5)
    add    x7, x7, x2
    lw x6, -5(x7)
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x6, 0xfffffeff)

    # Testcase 143:  imm:0xff7, result rd:x7(0xfffff7ff)
    la  x8, test_data
    addi    x8, x8,44
    li     x2, MASK_XLEN(9)
    add    x8, x8, x2
    lw x7, -9(x8)
    sw x7, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x7, 0xfffff7ff)



    

    RVTEST_SIGBASE(x1,signature_49_0)

    # Testcase 144:  imm:0xfef, result rd:x8(0xffffefff)
    la  x9, test_data
    addi    x9, x9,48
    li     x2, MASK_XLEN(17)
    add    x9, x9, x2
    lw x8, -17(x9)
    sw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x8, 0xffffefff)

    # Testcase 145:  imm:0xfdf, result rd:x9(0xffffdfff)
    la  x10, test_data
    addi    x10, x10,52
    li     x2, MASK_XLEN(33)
    add    x10, x10, x2
    lw x9, -33(x10)
    sw x9, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xffffdfff)

    # Testcase 146:  imm:0xfbf, result rd:x10(0xffffefff)
    la  x11, test_data
    addi    x11, x11,56
    li     x2, MASK_XLEN(65)
    add    x11, x11, x2
    lw x10, -65(x11)
    sw x10, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x10, 0xffffefff)



    

    RVTEST_SIGBASE(x1,signature_50_0)

    # Testcase 147:  imm:0xf7f, result rd:x11(0xffff7fff)
    la  x12, test_data
    addi    x12, x12,60
    li     x2, MASK_XLEN(129)
    add    x12, x12, x2
    lw x11, -129(x12)
    sw x11, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x11, 0xffff7fff)

    # Testcase 148:  imm:0xeff, result rd:x12(0xfffeffff)
    la  x13, test_data
    addi    x13, x13,64
    li     x2, MASK_XLEN(257)
    add    x13, x13, x2
    lw x12, -257(x13)
    sw x12, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x12, 0xfffeffff)

    # Testcase 149:  imm:0xdff, result rd:x13(0xfffdffff)
    la  x14, test_data
    addi    x14, x14,68
    li     x2, MASK_XLEN(513)
    add    x14, x14, x2
    lw x13, -513(x14)
    sw x13, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x13, 0xfffdffff)



    

    RVTEST_SIGBASE(x1,signature_51_0)

    # Testcase 150:  imm:0xbff, result rd:x14(0xfffbffff)
    la  x15, test_data
    addi    x15, x15,72
    li     x2, MASK_XLEN(1025)
    add    x15, x15, x2
    lw x14, -1025(x15)
    sw x14, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x14, 0xfffbffff)

    # Testcase 151:  imm:0x7ff, result rd:x15(0xfff7ffff)
    la  x16, test_data
    addi    x16, x16,76
    li     x2, MASK_XLEN(-2047)
    add    x16, x16, x2
    lw x15, 2047(x16)
    sw x15, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x15, 0xfff7ffff)

    # Testcase 152:  imm:0xffe, result rd:x16(0xffefffff)
    la  x17, test_data
    addi    x17, x17,80
    li     x2, MASK_XLEN(2)
    add    x17, x17, x2
    lw x16, -2(x17)
    sw x16, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x16, 0xffefffff)



    

    RVTEST_SIGBASE(x1,signature_52_0)

    # Testcase 153:  imm:0xffd, result rd:x17(0xffdfffff)
    la  x18, test_data
    addi    x18, x18,84
    li     x2, MASK_XLEN(3)
    add    x18, x18, x2
    lw x17, -3(x18)
    sw x17, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x17, 0xffdfffff)

    # Testcase 154:  imm:0xffb, result rd:x18(0xffbfffff)
    la  x19, test_data
    addi    x19, x19,88
    li     x2, MASK_XLEN(5)
    add    x19, x19, x2
    lw x18, -5(x19)
    sw x18, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x18, 0xffbfffff)

    # Testcase 155:  imm:0xff7, result rd:x19(0xff7fffff)
    la  x20, test_data
    addi    x20, x20,92
    li     x2, MASK_XLEN(9)
    add    x20, x20, x2
    lw x19, -9(x20)
    sw x19, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x19, 0xff7fffff)



    

    RVTEST_SIGBASE(x1,signature_53_0)

    # Testcase 156:  imm:0xfef, result rd:x20(0xfeffffff)
    la  x21, test_data
    addi    x21, x21,96
    li     x2, MASK_XLEN(17)
    add    x21, x21, x2
    lw x20, -17(x21)
    sw x20, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x20, 0xfeffffff)

    # Testcase 157:  imm:0xfdf, result rd:x21(0xfdffffff)
    la  x22, test_data
    addi    x22, x22,100
    li     x2, MASK_XLEN(33)
    add    x22, x22, x2
    lw x21, -33(x22)
    sw x21, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x21, 0xfdffffff)

    # Testcase 158:  imm:0xfbf, result rd:x22(0xfeffffff)
    la  x23, test_data
    addi    x23, x23,104
    li     x2, MASK_XLEN(65)
    add    x23, x23, x2
    lw x22, -65(x23)
    sw x22, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x22, 0xfeffffff)



    

    RVTEST_SIGBASE(x1,signature_54_0)

    # Testcase 159:  imm:0xf7f, result rd:x23(0xf7ffffff)
    la  x24, test_data
    addi    x24, x24,108
    li     x2, MASK_XLEN(129)
    add    x24, x24, x2
    lw x23, -129(x24)
    sw x23, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x23, 0xf7ffffff)

    # Testcase 160:  imm:0xeff, result rd:x24(0xefffffff)
    la  x25, test_data
    addi    x25, x25,112
    li     x2, MASK_XLEN(257)
    add    x25, x25, x2
    lw x24, -257(x25)
    sw x24, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x24, 0xefffffff)

    # Testcase 161:  imm:0xdff, result rd:x25(0xdfffffff)
    la  x26, test_data
    addi    x26, x26,116
    li     x2, MASK_XLEN(513)
    add    x26, x26, x2
    lw x25, -513(x26)
    sw x25, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x25, 0xdfffffff)



    

    RVTEST_SIGBASE(x1,signature_55_0)

    # Testcase 162:  imm:0xbff, result rd:x26(0xefffffff)
    la  x27, test_data
    addi    x27, x27,120
    li     x2, MASK_XLEN(1025)
    add    x27, x27, x2
    lw x26, -1025(x27)
    sw x26, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x26, 0xefffffff)

    # Testcase 163:  imm:0x7ff, result rd:x27(0x7fffffff)
    la  x28, test_data
    addi    x28, x28,124
    li     x2, MASK_XLEN(-2047)
    add    x28, x28, x2
    lw x27, 2047(x28)
    sw x27, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x27, 0x7fffffff)

    # Testcase 164:  imm:0xffe, result rd:x28(0xffffffff)
    la  x29, test_data
    addi    x29, x29,128
    li     x2, MASK_XLEN(2)
    add    x29, x29, x2
    lw x28, -2(x29)
    sw x28, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x28, 0xffffffff)



    

    RVTEST_SIGBASE(x2,signature_56_0)

    # Testcase 165:  imm:0xffd, result rd:x29(0x00000001)
    la  x30, test_data
    addi    x30, x30,132
    li     x3, MASK_XLEN(3)
    add    x30, x30, x3
    lw x29, -3(x30)
    sw x29, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x29, 0x00000001)

    # Testcase 166:  imm:0xffb, result rd:x30(0x00000002)
    la  x31, test_data
    addi    x31, x31,136
    li     x3, MASK_XLEN(5)
    add    x31, x31, x3
    lw x30, -5(x31)
    sw x30, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x30, 0x00000002)

    # Testcase 167:  imm:0xff7, result rd:x31(0x00000004)
    la  x1, test_data
    addi    x1, x1,140
    li     x3, MASK_XLEN(9)
    add    x1, x1, x3
    lw x31, -9(x1)
    sw x31, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x31, 0x00000004)



    

    RVTEST_SIGBASE(x1,signature_57_0)

    # Testcase 168:  imm:0x497, result rd:x0(0x00000000)
    la  x3, test_data
    addi    x3, x3,144
    li     x2, MASK_XLEN(-1175)
    add    x3, x3, x2
    lw x0, 1175(x3)
    sw x0, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x0, 0x00000000)

	
#endif


RVTEST_CODE_END
RVMODEL_HALT

RVTEST_DATA_BEGIN
.align 4
rvtest_data:
.word 0xbabecafe

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

RVTEST_DATA_END

RVMODEL_DATA_BEGIN




signature_1_0:
	.fill 3, 4, 0xdeadbeef
signature_2_0:
	.fill 3, 4, 0xdeadbeef
signature_3_0:
	.fill 3, 4, 0xdeadbeef
signature_4_0:
	.fill 3, 4, 0xdeadbeef
signature_5_0:
	.fill 3, 4, 0xdeadbeef
signature_6_0:
	.fill 3, 4, 0xdeadbeef
signature_7_0:
	.fill 3, 4, 0xdeadbeef
signature_8_0:
	.fill 3, 4, 0xdeadbeef
signature_9_0:
	.fill 3, 4, 0xdeadbeef
signature_10_0:
	.fill 3, 4, 0xdeadbeef
signature_11_0:
	.fill 3, 4, 0xdeadbeef
signature_12_0:
	.fill 3, 4, 0xdeadbeef
signature_13_0:
	.fill 3, 4, 0xdeadbeef
signature_14_0:
	.fill 3, 4, 0xdeadbeef
signature_15_0:
	.fill 3, 4, 0xdeadbeef
signature_16_0:
	.fill 3, 4, 0xdeadbeef
signature_17_0:
	.fill 3, 4, 0xdeadbeef
signature_18_0:
	.fill 3, 4, 0xdeadbeef
signature_19_0:
	.fill 3, 4, 0xdeadbeef
signature_20_0:
	.fill 3, 4, 0xdeadbeef
signature_21_0:
	.fill 3, 4, 0xdeadbeef
signature_22_0:
	.fill 3, 4, 0xdeadbeef
signature_23_0:
	.fill 3, 4, 0xdeadbeef
signature_24_0:
	.fill 3, 4, 0xdeadbeef
signature_25_0:
	.fill 3, 4, 0xdeadbeef
signature_26_0:
	.fill 3, 4, 0xdeadbeef
signature_27_0:
	.fill 3, 4, 0xdeadbeef
signature_28_0:
	.fill 3, 4, 0xdeadbeef
signature_29_0:
	.fill 3, 4, 0xdeadbeef
signature_30_0:
	.fill 3, 4, 0xdeadbeef
signature_31_0:
	.fill 3, 4, 0xdeadbeef
signature_32_0:
	.fill 3, 4, 0xdeadbeef
signature_33_0:
	.fill 3, 4, 0xdeadbeef
signature_34_0:
	.fill 3, 4, 0xdeadbeef
signature_35_0:
	.fill 3, 4, 0xdeadbeef
signature_36_0:
	.fill 3, 4, 0xdeadbeef
signature_37_0:
	.fill 3, 4, 0xdeadbeef
signature_38_0:
	.fill 3, 4, 0xdeadbeef
signature_39_0:
	.fill 3, 4, 0xdeadbeef
signature_40_0:
	.fill 3, 4, 0xdeadbeef
signature_41_0:
	.fill 3, 4, 0xdeadbeef
signature_42_0:
	.fill 3, 4, 0xdeadbeef
signature_43_0:
	.fill 3, 4, 0xdeadbeef
signature_44_0:
	.fill 3, 4, 0xdeadbeef
signature_45_0:
	.fill 3, 4, 0xdeadbeef
signature_46_0:
	.fill 3, 4, 0xdeadbeef
signature_47_0:
	.fill 3, 4, 0xdeadbeef
signature_48_0:
	.fill 3, 4, 0xdeadbeef
signature_49_0:
	.fill 3, 4, 0xdeadbeef
signature_50_0:
	.fill 3, 4, 0xdeadbeef
signature_51_0:
	.fill 3, 4, 0xdeadbeef
signature_52_0:
	.fill 3, 4, 0xdeadbeef
signature_53_0:
	.fill 3, 4, 0xdeadbeef
signature_54_0:
	.fill 3, 4, 0xdeadbeef
signature_55_0:
	.fill 3, 4, 0xdeadbeef
signature_56_0:
	.fill 3, 4, 0xdeadbeef
signature_57_0:
	.fill 3, 4, 0xdeadbeef


#ifdef rvtest_mtrap_routine

mtrap_sigptr:
    .fill 64*(XLEN/32),4,0xdeadbeef

#endif

#ifdef rvtest_gpr_save

gpr_save:
    .fill 32*(XLEN/32),4,0xdeadbeef

#endif

RVMODEL_DATA_END

