// RISC-V Architectural Validation Test BGEU-01
//
//
// Copyright (c) 2005-2021 Imperas Software Ltd., www.imperas.com
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
// Description: Testing instruction 'BGEU'.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32I")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN







#ifdef TEST_CASE_1


    
    RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*I.*);def TEST_CASE_1=True;",bgeu)

    RVTEST_SIGBASE(x2,signature_1_0)
    
     # Testcase 0:  rs1:x31(0xadea5195), rs2:x16(0x121bcc23), result Branch=1
    li x4, 0xcccc
    li x31, 0xadea5195
    li x16, 0x121bcc23
    bgeu x31, x16, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 1:  rs1:x30(0xd2ffbec1), rs2:x15(0xa47d105b), result Branch=1
    li x4, 0xcccc
    li x30, 0xd2ffbec1
    li x15, 0xa47d105b
    bgeu x30, x15, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 2:  rs1:x29(0xa8e1a8bb), rs2:x14(0x707af2c0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x29, 0xa8e1a8bb
    li x14, 0x707af2c0
    bgeu x29, x14, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 3:  rs1:x28(0x48c99fcb), rs2:x13(0xe19bfbc3), result Branch=0
    li x4, 0xcccc
    li x28, 0x48c99fcb
    li x13, 0xe19bfbc3
    bgeu x28, x13, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 4:  rs1:x27(0x461d524f), rs2:x12(0x528a10af), result Branch=0
    li x4, 0xcccc
    li x27, 0x461d524f
    li x12, 0x528a10af
    bgeu x27, x12, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)



    

    RVTEST_SIGBASE(x2,signature_2_0)
    
     # Testcase 5:  rs1:x26(0x528a10af), rs2:x11(0x461d524f), result Branch=1
    li x4, 0xcccc
    li x26, 0x528a10af
    li x11, 0x461d524f
    bgeu x26, x11, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 6:  rs1:x25(0xe19bfbc3), rs2:x10(0x48c99fcb), result Branch=1
    li x4, 0xcccc
    li x25, 0xe19bfbc3
    li x10, 0x48c99fcb
    bgeu x25, x10, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 7:  rs1:x24(0x707af2c0), rs2:x9(0xa8e1a8bb), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x24, 0x707af2c0
    li x9, 0xa8e1a8bb
    bgeu x24, x9, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 8:  rs1:x23(0xa47d105b), rs2:x8(0xd2ffbec1), result Branch=0
    li x4, 0xcccc
    li x23, 0xa47d105b
    li x8, 0xd2ffbec1
    bgeu x23, x8, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 9:  rs1:x22(0x121bcc23), rs2:x7(0xadea5195), result Branch=0
    li x4, 0xcccc
    li x22, 0x121bcc23
    li x7, 0xadea5195
    bgeu x22, x7, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)



    

    RVTEST_SIGBASE(x7,signature_3_0)
    
     # Testcase 10:  rs1:x21(0x1), rs2:x6(0xffffffff), result Branch=0
    li x9, 0xcccc
    li x21, 0x1
    li x6, 0xffffffff
    bgeu x21, x6, 1f
    li x9, 0x123ab
1: 
    sw x9, 0(x7)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 11:  rs1:x20(0x2), rs2:x5(0x7fffffff), result Branch=0
    li x9, 0xcccc
    li x20, 0x2
    li x5, 0x7fffffff
    bgeu x20, x5, 2f
    li x9, 0x123ab
2: 
    sw x9, 4(x7)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 12:  rs1:x19(0x4), rs2:x4(0xbfffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x19, 0x4
    li x4, 0xbfffffff
    bgeu x19, x4, 2b
    li x9, 0x123ab
4:
    sw x9, 8(x7)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 13:  rs1:x18(0x8), rs2:x3(0xdfffffff), result Branch=0
    li x9, 0xcccc
    li x18, 0x8
    li x3, 0xdfffffff
    bgeu x18, x3, 4f
    li x9, 0x123ab
4: 
    sw x9, 12(x7)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 14:  rs1:x17(0x10), rs2:x2(0xefffffff), result Branch=0
    li x9, 0xcccc
    li x17, 0x10
    li x2, 0xefffffff
    bgeu x17, x2, 5f
    li x9, 0x123ab
5: 
    sw x9, 16(x7)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)



    

    RVTEST_SIGBASE(x3,signature_4_0)
    
     # Testcase 15:  rs1:x16(0x20), rs2:x1(0xf7ffffff), result Branch=0
    li x5, 0xcccc
    li x16, 0x20
    li x1, 0xf7ffffff
    bgeu x16, x1, 1f
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x123ab)

     # Testcase 16:  rs1:x15(0x40), rs2:x31(0xfbffffff), result Branch=0
    li x5, 0xcccc
    li x15, 0x40
    li x31, 0xfbffffff
    bgeu x15, x31, 2f
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x123ab)

     # Testcase 17:  rs1:x14(0x80), rs2:x30(0xfdffffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x5, 0xcccc
    li x14, 0x80
    li x30, 0xfdffffff
    bgeu x14, x30, 2b
    li x5, 0x123ab
4:
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x123ab)

     # Testcase 18:  rs1:x13(0x100), rs2:x29(0xfeffffff), result Branch=0
    li x5, 0xcccc
    li x13, 0x100
    li x29, 0xfeffffff
    bgeu x13, x29, 4f
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x123ab)

     # Testcase 19:  rs1:x12(0x200), rs2:x28(0xff7fffff), result Branch=0
    li x5, 0xcccc
    li x12, 0x200
    li x28, 0xff7fffff
    bgeu x12, x28, 5f
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x123ab)



    

    RVTEST_SIGBASE(x2,signature_5_0)
    
     # Testcase 20:  rs1:x11(0x400), rs2:x27(0xffbfffff), result Branch=0
    li x4, 0xcccc
    li x11, 0x400
    li x27, 0xffbfffff
    bgeu x11, x27, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 21:  rs1:x10(0x800), rs2:x26(0xffdfffff), result Branch=0
    li x4, 0xcccc
    li x10, 0x800
    li x26, 0xffdfffff
    bgeu x10, x26, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 22:  rs1:x9(0x1000), rs2:x25(0xffefffff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x9, 0x1000
    li x25, 0xffefffff
    bgeu x9, x25, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 23:  rs1:x8(0x2000), rs2:x24(0xfff7ffff), result Branch=0
    li x4, 0xcccc
    li x8, 0x2000
    li x24, 0xfff7ffff
    bgeu x8, x24, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 24:  rs1:x7(0x4000), rs2:x23(0xfffbffff), result Branch=0
    li x4, 0xcccc
    li x7, 0x4000
    li x23, 0xfffbffff
    bgeu x7, x23, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)



    

    RVTEST_SIGBASE(x7,signature_6_0)
    
     # Testcase 25:  rs1:x6(0x8000), rs2:x22(0xfffdffff), result Branch=0
    li x9, 0xcccc
    li x6, 0x8000
    li x22, 0xfffdffff
    bgeu x6, x22, 1f
    li x9, 0x123ab
1: 
    sw x9, 0(x7)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 26:  rs1:x5(0x10000), rs2:x21(0xfffeffff), result Branch=0
    li x9, 0xcccc
    li x5, 0x10000
    li x21, 0xfffeffff
    bgeu x5, x21, 2f
    li x9, 0x123ab
2: 
    sw x9, 4(x7)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 27:  rs1:x4(0x20000), rs2:x20(0xffff7fff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x4, 0x20000
    li x20, 0xffff7fff
    bgeu x4, x20, 2b
    li x9, 0x123ab
4:
    sw x9, 8(x7)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 28:  rs1:x3(0x40000), rs2:x19(0xffffbfff), result Branch=0
    li x9, 0xcccc
    li x3, 0x40000
    li x19, 0xffffbfff
    bgeu x3, x19, 4f
    li x9, 0x123ab
4: 
    sw x9, 12(x7)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 29:  rs1:x2(0x80000), rs2:x18(0xffffdfff), result Branch=0
    li x9, 0xcccc
    li x2, 0x80000
    li x18, 0xffffdfff
    bgeu x2, x18, 5f
    li x9, 0x123ab
5: 
    sw x9, 16(x7)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)



    

    RVTEST_SIGBASE(x3,signature_7_0)
    
     # Testcase 30:  rs1:x1(0x100000), rs2:x17(0xffffefff), result Branch=0
    li x5, 0xcccc
    li x1, 0x100000
    li x17, 0xffffefff
    bgeu x1, x17, 1f
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x123ab)

     # Testcase 31:  rs1:x31(0x200000), rs2:x16(0xfffff7ff), result Branch=0
    li x5, 0xcccc
    li x31, 0x200000
    li x16, 0xfffff7ff
    bgeu x31, x16, 2f
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x123ab)

     # Testcase 32:  rs1:x30(0x400000), rs2:x15(0xfffffbff), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x5, 0xcccc
    li x30, 0x400000
    li x15, 0xfffffbff
    bgeu x30, x15, 2b
    li x5, 0x123ab
4:
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x123ab)

     # Testcase 33:  rs1:x29(0x800000), rs2:x14(0xfffffdff), result Branch=0
    li x5, 0xcccc
    li x29, 0x800000
    li x14, 0xfffffdff
    bgeu x29, x14, 4f
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x123ab)

     # Testcase 34:  rs1:x28(0x1000000), rs2:x13(0xfffffeff), result Branch=0
    li x5, 0xcccc
    li x28, 0x1000000
    li x13, 0xfffffeff
    bgeu x28, x13, 5f
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x123ab)



    

    RVTEST_SIGBASE(x2,signature_8_0)
    
     # Testcase 35:  rs1:x27(0x2000000), rs2:x12(0xffffff7f), result Branch=0
    li x4, 0xcccc
    li x27, 0x2000000
    li x12, 0xffffff7f
    bgeu x27, x12, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 36:  rs1:x26(0x4000000), rs2:x11(0xffffffbf), result Branch=0
    li x4, 0xcccc
    li x26, 0x4000000
    li x11, 0xffffffbf
    bgeu x26, x11, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 37:  rs1:x25(0x8000000), rs2:x10(0xffffffdf), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x25, 0x8000000
    li x10, 0xffffffdf
    bgeu x25, x10, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 38:  rs1:x24(0x10000000), rs2:x9(0xffffffef), result Branch=0
    li x4, 0xcccc
    li x24, 0x10000000
    li x9, 0xffffffef
    bgeu x24, x9, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

     # Testcase 39:  rs1:x23(0x20000000), rs2:x8(0xfffffff7), result Branch=0
    li x4, 0xcccc
    li x23, 0x20000000
    li x8, 0xfffffff7
    bgeu x23, x8, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)



    

    RVTEST_SIGBASE(x2,signature_9_0)
    
     # Testcase 40:  rs1:x22(0x40000000), rs2:x7(0xfffffffb), result Branch=0
    li x9, 0xcccc
    li x22, 0x40000000
    li x7, 0xfffffffb
    bgeu x22, x7, 1f
    li x9, 0x123ab
1: 
    sw x9, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 41:  rs1:x21(0x80000000), rs2:x6(0xfffffffd), result Branch=0
    li x9, 0xcccc
    li x21, 0x80000000
    li x6, 0xfffffffd
    bgeu x21, x6, 2f
    li x9, 0x123ab
2: 
    sw x9, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 42:  rs1:x20(0x0), rs2:x5(0xfffffffe), result Branch=0
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x20, 0x0
    li x5, 0xfffffffe
    bgeu x20, x5, 2b
    li x9, 0x123ab
4:
    sw x9, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0x123ab)

     # Testcase 43:  rs1:x19(0xfffffffe), rs2:x4(0x0), result Branch=1
    li x9, 0xcccc
    li x19, 0xfffffffe
    li x4, 0x0
    bgeu x19, x4, 4f
    li x9, 0x123ab
4: 
    sw x9, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc)

     # Testcase 44:  rs1:x18(0xfffffffd), rs2:x3(0x80000000), result Branch=1
    li x9, 0xcccc
    li x18, 0xfffffffd
    li x3, 0x80000000
    bgeu x18, x3, 5f
    li x9, 0x123ab
5: 
    sw x9, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc)



    

    RVTEST_SIGBASE(x3,signature_10_0)
    
     # Testcase 45:  rs1:x17(0xfffffffb), rs2:x2(0x40000000), result Branch=1
    li x5, 0xcccc
    li x17, 0xfffffffb
    li x2, 0x40000000
    bgeu x17, x2, 1f
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 46:  rs1:x16(0xfffffff7), rs2:x1(0x20000000), result Branch=1
    li x5, 0xcccc
    li x16, 0xfffffff7
    li x1, 0x20000000
    bgeu x16, x1, 2f
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 47:  rs1:x15(0xffffffef), rs2:x31(0x10000000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x5, 0xcccc
    li x15, 0xffffffef
    li x31, 0x10000000
    bgeu x15, x31, 2b
    li x5, 0x123ab
4:
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 48:  rs1:x14(0xffffffdf), rs2:x30(0x8000000), result Branch=1
    li x5, 0xcccc
    li x14, 0xffffffdf
    li x30, 0x8000000
    bgeu x14, x30, 4f
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 49:  rs1:x13(0xffffffbf), rs2:x29(0x4000000), result Branch=1
    li x5, 0xcccc
    li x13, 0xffffffbf
    li x29, 0x4000000
    bgeu x13, x29, 5f
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_11_0)
    
     # Testcase 50:  rs1:x12(0xffffff7f), rs2:x28(0x2000000), result Branch=1
    li x4, 0xcccc
    li x12, 0xffffff7f
    li x28, 0x2000000
    bgeu x12, x28, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 51:  rs1:x11(0xfffffeff), rs2:x27(0x1000000), result Branch=1
    li x4, 0xcccc
    li x11, 0xfffffeff
    li x27, 0x1000000
    bgeu x11, x27, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 52:  rs1:x10(0xfffffdff), rs2:x26(0x800000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x10, 0xfffffdff
    li x26, 0x800000
    bgeu x10, x26, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 53:  rs1:x9(0xfffffbff), rs2:x25(0x400000), result Branch=1
    li x4, 0xcccc
    li x9, 0xfffffbff
    li x25, 0x400000
    bgeu x9, x25, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 54:  rs1:x8(0xfffff7ff), rs2:x24(0x200000), result Branch=1
    li x4, 0xcccc
    li x8, 0xfffff7ff
    li x24, 0x200000
    bgeu x8, x24, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_12_0)
    
     # Testcase 55:  rs1:x7(0xffffefff), rs2:x23(0x100000), result Branch=1
    li x9, 0xcccc
    li x7, 0xffffefff
    li x23, 0x100000
    bgeu x7, x23, 1f
    li x9, 0x123ab
1: 
    sw x9, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc)

     # Testcase 56:  rs1:x6(0xffffdfff), rs2:x22(0x80000), result Branch=1
    li x9, 0xcccc
    li x6, 0xffffdfff
    li x22, 0x80000
    bgeu x6, x22, 2f
    li x9, 0x123ab
2: 
    sw x9, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc)

     # Testcase 57:  rs1:x5(0xffffbfff), rs2:x21(0x40000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x5, 0xffffbfff
    li x21, 0x40000
    bgeu x5, x21, 2b
    li x9, 0x123ab
4:
    sw x9, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc)

     # Testcase 58:  rs1:x4(0xffff7fff), rs2:x20(0x20000), result Branch=1
    li x9, 0xcccc
    li x4, 0xffff7fff
    li x20, 0x20000
    bgeu x4, x20, 4f
    li x9, 0x123ab
4: 
    sw x9, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc)

     # Testcase 59:  rs1:x3(0xfffeffff), rs2:x19(0x10000), result Branch=1
    li x9, 0xcccc
    li x3, 0xfffeffff
    li x19, 0x10000
    bgeu x3, x19, 5f
    li x9, 0x123ab
5: 
    sw x9, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x8, x9, 0xcccc)



    

    RVTEST_SIGBASE(x3,signature_13_0)
    
     # Testcase 60:  rs1:x2(0xfffdffff), rs2:x18(0x8000), result Branch=1
    li x5, 0xcccc
    li x2, 0xfffdffff
    li x18, 0x8000
    bgeu x2, x18, 1f
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 61:  rs1:x1(0xfffbffff), rs2:x17(0x4000), result Branch=1
    li x5, 0xcccc
    li x1, 0xfffbffff
    li x17, 0x4000
    bgeu x1, x17, 2f
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 62:  rs1:x31(0xfff7ffff), rs2:x16(0x2000), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x5, 0xcccc
    li x31, 0xfff7ffff
    li x16, 0x2000
    bgeu x31, x16, 2b
    li x5, 0x123ab
4:
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 63:  rs1:x30(0xffefffff), rs2:x15(0x1000), result Branch=1
    li x5, 0xcccc
    li x30, 0xffefffff
    li x15, 0x1000
    bgeu x30, x15, 4f
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 64:  rs1:x29(0xffdfffff), rs2:x14(0x800), result Branch=1
    li x5, 0xcccc
    li x29, 0xffdfffff
    li x14, 0x800
    bgeu x29, x14, 5f
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_14_0)
    
     # Testcase 65:  rs1:x28(0xffbfffff), rs2:x13(0x400), result Branch=1
    li x4, 0xcccc
    li x28, 0xffbfffff
    li x13, 0x400
    bgeu x28, x13, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 66:  rs1:x27(0xff7fffff), rs2:x12(0x200), result Branch=1
    li x4, 0xcccc
    li x27, 0xff7fffff
    li x12, 0x200
    bgeu x27, x12, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 67:  rs1:x26(0xfeffffff), rs2:x11(0x100), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x26, 0xfeffffff
    li x11, 0x100
    bgeu x26, x11, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 68:  rs1:x25(0xfdffffff), rs2:x10(0x80), result Branch=1
    li x4, 0xcccc
    li x25, 0xfdffffff
    li x10, 0x80
    bgeu x25, x10, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 69:  rs1:x24(0xfbffffff), rs2:x9(0x40), result Branch=1
    li x4, 0xcccc
    li x24, 0xfbffffff
    li x9, 0x40
    bgeu x24, x9, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_15_0)
    
     # Testcase 70:  rs1:x23(0xf7ffffff), rs2:x8(0x20), result Branch=1
    li x9, 0xcccc
    li x23, 0xf7ffffff
    li x8, 0x20
    bgeu x23, x8, 1f
    li x9, 0x123ab
1: 
    sw x9, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xcccc)

     # Testcase 71:  rs1:x22(0xefffffff), rs2:x7(0x10), result Branch=1
    li x9, 0xcccc
    li x22, 0xefffffff
    li x7, 0x10
    bgeu x22, x7, 2f
    li x9, 0x123ab
2: 
    sw x9, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xcccc)

     # Testcase 72:  rs1:x21(0xdfffffff), rs2:x6(0x8), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x21, 0xdfffffff
    li x6, 0x8
    bgeu x21, x6, 2b
    li x9, 0x123ab
4:
    sw x9, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xcccc)

     # Testcase 73:  rs1:x20(0xbfffffff), rs2:x5(0x4), result Branch=1
    li x9, 0xcccc
    li x20, 0xbfffffff
    li x5, 0x4
    bgeu x20, x5, 4f
    li x9, 0x123ab
4: 
    sw x9, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xcccc)

     # Testcase 74:  rs1:x19(0x7fffffff), rs2:x4(0x2), result Branch=1
    li x9, 0xcccc
    li x19, 0x7fffffff
    li x4, 0x2
    bgeu x19, x4, 5f
    li x9, 0x123ab
5: 
    sw x9, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xcccc)



    

    RVTEST_SIGBASE(x4,signature_16_0)
    
     # Testcase 75:  rs1:x18(0xffffffff), rs2:x3(0x1), result Branch=1
    li x6, 0xcccc
    li x18, 0xffffffff
    li x3, 0x1
    bgeu x18, x3, 1f
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 76:  rs1:x17(0x1), rs2:x2(0x0), result Branch=1
    li x6, 0xcccc
    li x17, 0x1
    li x2, 0x0
    bgeu x17, x2, 2f
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 77:  rs1:x16(0x2), rs2:x1(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x6, 0xcccc
    li x16, 0x2
    li x1, 0x0
    bgeu x16, x1, 2b
    li x6, 0x123ab
4:
    sw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 78:  rs1:x15(0x4), rs2:x31(0x0), result Branch=1
    li x6, 0xcccc
    li x15, 0x4
    li x31, 0x0
    bgeu x15, x31, 4f
    li x6, 0x123ab
4: 
    sw x6, 12(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 79:  rs1:x14(0x8), rs2:x30(0x0), result Branch=1
    li x6, 0xcccc
    li x14, 0x8
    li x30, 0x0
    bgeu x14, x30, 5f
    li x6, 0x123ab
5: 
    sw x6, 16(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_17_0)
    
     # Testcase 80:  rs1:x13(0x10), rs2:x29(0x0), result Branch=1
    li x4, 0xcccc
    li x13, 0x10
    li x29, 0x0
    bgeu x13, x29, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 81:  rs1:x12(0x20), rs2:x28(0x0), result Branch=1
    li x4, 0xcccc
    li x12, 0x20
    li x28, 0x0
    bgeu x12, x28, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 82:  rs1:x11(0x40), rs2:x27(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x11, 0x40
    li x27, 0x0
    bgeu x11, x27, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 83:  rs1:x10(0x80), rs2:x26(0x0), result Branch=1
    li x4, 0xcccc
    li x10, 0x80
    li x26, 0x0
    bgeu x10, x26, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 84:  rs1:x9(0x100), rs2:x25(0x0), result Branch=1
    li x4, 0xcccc
    li x9, 0x100
    li x25, 0x0
    bgeu x9, x25, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_18_0)
    
     # Testcase 85:  rs1:x8(0x200), rs2:x24(0x0), result Branch=1
    li x9, 0xcccc
    li x8, 0x200
    li x24, 0x0
    bgeu x8, x24, 1f
    li x9, 0x123ab
1: 
    sw x9, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xcccc)

     # Testcase 86:  rs1:x7(0x400), rs2:x23(0x0), result Branch=1
    li x9, 0xcccc
    li x7, 0x400
    li x23, 0x0
    bgeu x7, x23, 2f
    li x9, 0x123ab
2: 
    sw x9, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xcccc)

     # Testcase 87:  rs1:x6(0x800), rs2:x22(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x9, 0xcccc
    li x6, 0x800
    li x22, 0x0
    bgeu x6, x22, 2b
    li x9, 0x123ab
4:
    sw x9, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xcccc)

     # Testcase 88:  rs1:x5(0x1000), rs2:x21(0x0), result Branch=1
    li x9, 0xcccc
    li x5, 0x1000
    li x21, 0x0
    bgeu x5, x21, 4f
    li x9, 0x123ab
4: 
    sw x9, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xcccc)

     # Testcase 89:  rs1:x4(0x2000), rs2:x20(0x0), result Branch=1
    li x9, 0xcccc
    li x4, 0x2000
    li x20, 0x0
    bgeu x4, x20, 5f
    li x9, 0x123ab
5: 
    sw x9, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xcccc)



    

    RVTEST_SIGBASE(x4,signature_19_0)
    
     # Testcase 90:  rs1:x3(0x4000), rs2:x19(0x0), result Branch=1
    li x6, 0xcccc
    li x3, 0x4000
    li x19, 0x0
    bgeu x3, x19, 1f
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 91:  rs1:x2(0x8000), rs2:x18(0x0), result Branch=1
    li x6, 0xcccc
    li x2, 0x8000
    li x18, 0x0
    bgeu x2, x18, 2f
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 92:  rs1:x1(0x10000), rs2:x17(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x6, 0xcccc
    li x1, 0x10000
    li x17, 0x0
    bgeu x1, x17, 2b
    li x6, 0x123ab
4:
    sw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 93:  rs1:x31(0x20000), rs2:x16(0x0), result Branch=1
    li x6, 0xcccc
    li x31, 0x20000
    li x16, 0x0
    bgeu x31, x16, 4f
    li x6, 0x123ab
4: 
    sw x6, 12(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 94:  rs1:x30(0x40000), rs2:x15(0x0), result Branch=1
    li x6, 0xcccc
    li x30, 0x40000
    li x15, 0x0
    bgeu x30, x15, 5f
    li x6, 0x123ab
5: 
    sw x6, 16(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_20_0)
    
     # Testcase 95:  rs1:x29(0x80000), rs2:x14(0x0), result Branch=1
    li x4, 0xcccc
    li x29, 0x80000
    li x14, 0x0
    bgeu x29, x14, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 96:  rs1:x28(0x100000), rs2:x13(0x0), result Branch=1
    li x4, 0xcccc
    li x28, 0x100000
    li x13, 0x0
    bgeu x28, x13, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 97:  rs1:x27(0x200000), rs2:x12(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x27, 0x200000
    li x12, 0x0
    bgeu x27, x12, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 98:  rs1:x26(0x400000), rs2:x11(0x0), result Branch=1
    li x4, 0xcccc
    li x26, 0x400000
    li x11, 0x0
    bgeu x26, x11, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 99:  rs1:x25(0x800000), rs2:x10(0x0), result Branch=1
    li x4, 0xcccc
    li x25, 0x800000
    li x10, 0x0
    bgeu x25, x10, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_21_0)
    
     # Testcase 100:  rs1:x24(0x1000000), rs2:x9(0x0), result Branch=1
    li x4, 0xcccc
    li x24, 0x1000000
    li x9, 0x0
    bgeu x24, x9, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 101:  rs1:x23(0x2000000), rs2:x8(0x0), result Branch=1
    li x4, 0xcccc
    li x23, 0x2000000
    li x8, 0x0
    bgeu x23, x8, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 102:  rs1:x22(0x4000000), rs2:x7(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x22, 0x4000000
    li x7, 0x0
    bgeu x22, x7, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 103:  rs1:x21(0x8000000), rs2:x6(0x0), result Branch=1
    li x4, 0xcccc
    li x21, 0x8000000
    li x6, 0x0
    bgeu x21, x6, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 104:  rs1:x20(0x10000000), rs2:x5(0x0), result Branch=1
    li x4, 0xcccc
    li x20, 0x10000000
    li x5, 0x0
    bgeu x20, x5, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x5,signature_22_0)
    
     # Testcase 105:  rs1:x19(0x20000000), rs2:x4(0x0), result Branch=1
    li x7, 0xcccc
    li x19, 0x20000000
    li x4, 0x0
    bgeu x19, x4, 1f
    li x7, 0x123ab
1: 
    sw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 106:  rs1:x18(0x40000000), rs2:x3(0x0), result Branch=1
    li x7, 0xcccc
    li x18, 0x40000000
    li x3, 0x0
    bgeu x18, x3, 2f
    li x7, 0x123ab
2: 
    sw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 107:  rs1:x17(0x80000000), rs2:x2(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x7, 0xcccc
    li x17, 0x80000000
    li x2, 0x0
    bgeu x17, x2, 2b
    li x7, 0x123ab
4:
    sw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 108:  rs1:x16(0x0), rs2:x1(0x0), result Branch=1
    li x7, 0xcccc
    li x16, 0x0
    li x1, 0x0
    bgeu x16, x1, 4f
    li x7, 0x123ab
4: 
    sw x7, 12(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 109:  rs1:x15(0xfffffffe), rs2:x31(0x0), result Branch=1
    li x7, 0xcccc
    li x15, 0xfffffffe
    li x31, 0x0
    bgeu x15, x31, 5f
    li x7, 0x123ab
5: 
    sw x7, 16(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_23_0)
    
     # Testcase 110:  rs1:x14(0xfffffffd), rs2:x30(0x0), result Branch=1
    li x4, 0xcccc
    li x14, 0xfffffffd
    li x30, 0x0
    bgeu x14, x30, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 111:  rs1:x13(0xfffffffb), rs2:x29(0x0), result Branch=1
    li x4, 0xcccc
    li x13, 0xfffffffb
    li x29, 0x0
    bgeu x13, x29, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 112:  rs1:x12(0xfffffff7), rs2:x28(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x12, 0xfffffff7
    li x28, 0x0
    bgeu x12, x28, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 113:  rs1:x11(0xffffffef), rs2:x27(0x0), result Branch=1
    li x4, 0xcccc
    li x11, 0xffffffef
    li x27, 0x0
    bgeu x11, x27, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 114:  rs1:x10(0xffffffdf), rs2:x26(0x0), result Branch=1
    li x4, 0xcccc
    li x10, 0xffffffdf
    li x26, 0x0
    bgeu x10, x26, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_24_0)
    
     # Testcase 115:  rs1:x9(0xffffffbf), rs2:x25(0x0), result Branch=1
    li x4, 0xcccc
    li x9, 0xffffffbf
    li x25, 0x0
    bgeu x9, x25, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 116:  rs1:x8(0xffffff7f), rs2:x24(0x0), result Branch=1
    li x4, 0xcccc
    li x8, 0xffffff7f
    li x24, 0x0
    bgeu x8, x24, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 117:  rs1:x7(0xfffffeff), rs2:x23(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x7, 0xfffffeff
    li x23, 0x0
    bgeu x7, x23, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 118:  rs1:x6(0xfffffdff), rs2:x22(0x0), result Branch=1
    li x4, 0xcccc
    li x6, 0xfffffdff
    li x22, 0x0
    bgeu x6, x22, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 119:  rs1:x5(0xfffffbff), rs2:x21(0x0), result Branch=1
    li x4, 0xcccc
    li x5, 0xfffffbff
    li x21, 0x0
    bgeu x5, x21, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x5,signature_25_0)
    
     # Testcase 120:  rs1:x4(0xfffff7ff), rs2:x20(0x0), result Branch=1
    li x7, 0xcccc
    li x4, 0xfffff7ff
    li x20, 0x0
    bgeu x4, x20, 1f
    li x7, 0x123ab
1: 
    sw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 121:  rs1:x3(0xffffefff), rs2:x19(0x0), result Branch=1
    li x7, 0xcccc
    li x3, 0xffffefff
    li x19, 0x0
    bgeu x3, x19, 2f
    li x7, 0x123ab
2: 
    sw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 122:  rs1:x2(0xffffdfff), rs2:x18(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x7, 0xcccc
    li x2, 0xffffdfff
    li x18, 0x0
    bgeu x2, x18, 2b
    li x7, 0x123ab
4:
    sw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 123:  rs1:x1(0xffffbfff), rs2:x17(0x0), result Branch=1
    li x7, 0xcccc
    li x1, 0xffffbfff
    li x17, 0x0
    bgeu x1, x17, 4f
    li x7, 0x123ab
4: 
    sw x7, 12(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 124:  rs1:x31(0xffff7fff), rs2:x16(0x0), result Branch=1
    li x7, 0xcccc
    li x31, 0xffff7fff
    li x16, 0x0
    bgeu x31, x16, 5f
    li x7, 0x123ab
5: 
    sw x7, 16(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_26_0)
    
     # Testcase 125:  rs1:x30(0xfffeffff), rs2:x15(0x0), result Branch=1
    li x4, 0xcccc
    li x30, 0xfffeffff
    li x15, 0x0
    bgeu x30, x15, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 126:  rs1:x29(0xfffdffff), rs2:x14(0x0), result Branch=1
    li x4, 0xcccc
    li x29, 0xfffdffff
    li x14, 0x0
    bgeu x29, x14, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 127:  rs1:x28(0xfffbffff), rs2:x13(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x28, 0xfffbffff
    li x13, 0x0
    bgeu x28, x13, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 128:  rs1:x27(0xfff7ffff), rs2:x12(0x0), result Branch=1
    li x4, 0xcccc
    li x27, 0xfff7ffff
    li x12, 0x0
    bgeu x27, x12, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 129:  rs1:x26(0xffefffff), rs2:x11(0x0), result Branch=1
    li x4, 0xcccc
    li x26, 0xffefffff
    li x11, 0x0
    bgeu x26, x11, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_27_0)
    
     # Testcase 130:  rs1:x25(0xffdfffff), rs2:x10(0x0), result Branch=1
    li x4, 0xcccc
    li x25, 0xffdfffff
    li x10, 0x0
    bgeu x25, x10, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 131:  rs1:x24(0xffbfffff), rs2:x9(0x0), result Branch=1
    li x4, 0xcccc
    li x24, 0xffbfffff
    li x9, 0x0
    bgeu x24, x9, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 132:  rs1:x23(0xff7fffff), rs2:x8(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x23, 0xff7fffff
    li x8, 0x0
    bgeu x23, x8, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 133:  rs1:x22(0xfeffffff), rs2:x7(0x0), result Branch=1
    li x4, 0xcccc
    li x22, 0xfeffffff
    li x7, 0x0
    bgeu x22, x7, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 134:  rs1:x21(0xfdffffff), rs2:x6(0x0), result Branch=1
    li x4, 0xcccc
    li x21, 0xfdffffff
    li x6, 0x0
    bgeu x21, x6, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x6,signature_28_0)
    
     # Testcase 135:  rs1:x20(0xfbffffff), rs2:x5(0x0), result Branch=1
    li x8, 0xcccc
    li x20, 0xfbffffff
    li x5, 0x0
    bgeu x20, x5, 1f
    li x8, 0x123ab
1: 
    sw x8, 0(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)

     # Testcase 136:  rs1:x19(0xf7ffffff), rs2:x4(0x0), result Branch=1
    li x8, 0xcccc
    li x19, 0xf7ffffff
    li x4, 0x0
    bgeu x19, x4, 2f
    li x8, 0x123ab
2: 
    sw x8, 4(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)

     # Testcase 137:  rs1:x18(0xefffffff), rs2:x3(0x0), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x8, 0xcccc
    li x18, 0xefffffff
    li x3, 0x0
    bgeu x18, x3, 2b
    li x8, 0x123ab
4:
    sw x8, 8(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)

     # Testcase 138:  rs1:x17(0xdfffffff), rs2:x2(0x0), result Branch=1
    li x8, 0xcccc
    li x17, 0xdfffffff
    li x2, 0x0
    bgeu x17, x2, 4f
    li x8, 0x123ab
4: 
    sw x8, 12(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)

     # Testcase 139:  rs1:x16(0xbfffffff), rs2:x1(0x0), result Branch=1
    li x8, 0xcccc
    li x16, 0xbfffffff
    li x1, 0x0
    bgeu x16, x1, 5f
    li x8, 0x123ab
5: 
    sw x8, 16(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_29_0)
    
     # Testcase 140:  rs1:x15(0x7fffffff), rs2:x31(0x0), result Branch=1
    li x4, 0xcccc
    li x15, 0x7fffffff
    li x31, 0x0
    bgeu x15, x31, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 141:  rs1:x14(0xffffffff), rs2:x30(0x0), result Branch=1
    li x4, 0xcccc
    li x14, 0xffffffff
    li x30, 0x0
    bgeu x14, x30, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 142:  rs1:x13(0xadea5195), rs2:x29(0x121bcc23), result Branch=1
    jal x0, 3f
2:
    jal x0, 4f
3:
     
    li x4, 0xcccc
    li x13, 0xadea5195
    li x29, 0x121bcc23
    bgeu x13, x29, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 143:  rs1:x12(0xd2ffbec1), rs2:x28(0xa47d105b), result Branch=1
    li x4, 0xcccc
    li x12, 0xd2ffbec1
    li x28, 0xa47d105b
    bgeu x12, x28, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 144:  rs1:x11(0xa8e1a8bb), rs2:x0(0x707af2c0), result Branch=1
    li x4, 0xcccc
    li x11, 0xa8e1a8bb
    li x0, 0x707af2c0
    bgeu x11, x0, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_30_0)
    
     # Testcase 145:  rs1:x0(0x48c99fcb), rs2:x26(0xe19bfbc3), result Branch=0
    li x4, 0xcccc
    li x0, 0x48c99fcb
    li x26, 0xe19bfbc3
    bgeu x0, x26, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x123ab)

	
#endif


RVTEST_CODE_END
RVMODEL_HALT

RVTEST_DATA_BEGIN
.align 4
rvtest_data:
.word 0xbabecafe

# Input data section.
	.data

RVTEST_DATA_END

RVMODEL_DATA_BEGIN




signature_1_0:
	.fill 5, 4, 0xdeadbeef
signature_2_0:
	.fill 5, 4, 0xdeadbeef
signature_3_0:
	.fill 5, 4, 0xdeadbeef
signature_4_0:
	.fill 5, 4, 0xdeadbeef
signature_5_0:
	.fill 5, 4, 0xdeadbeef
signature_6_0:
	.fill 5, 4, 0xdeadbeef
signature_7_0:
	.fill 5, 4, 0xdeadbeef
signature_8_0:
	.fill 5, 4, 0xdeadbeef
signature_9_0:
	.fill 5, 4, 0xdeadbeef
signature_10_0:
	.fill 5, 4, 0xdeadbeef
signature_11_0:
	.fill 5, 4, 0xdeadbeef
signature_12_0:
	.fill 5, 4, 0xdeadbeef
signature_13_0:
	.fill 5, 4, 0xdeadbeef
signature_14_0:
	.fill 5, 4, 0xdeadbeef
signature_15_0:
	.fill 5, 4, 0xdeadbeef
signature_16_0:
	.fill 5, 4, 0xdeadbeef
signature_17_0:
	.fill 5, 4, 0xdeadbeef
signature_18_0:
	.fill 5, 4, 0xdeadbeef
signature_19_0:
	.fill 5, 4, 0xdeadbeef
signature_20_0:
	.fill 5, 4, 0xdeadbeef
signature_21_0:
	.fill 5, 4, 0xdeadbeef
signature_22_0:
	.fill 5, 4, 0xdeadbeef
signature_23_0:
	.fill 5, 4, 0xdeadbeef
signature_24_0:
	.fill 5, 4, 0xdeadbeef
signature_25_0:
	.fill 5, 4, 0xdeadbeef
signature_26_0:
	.fill 5, 4, 0xdeadbeef
signature_27_0:
	.fill 5, 4, 0xdeadbeef
signature_28_0:
	.fill 5, 4, 0xdeadbeef
signature_29_0:
	.fill 5, 4, 0xdeadbeef
signature_30_0:
	.fill 5, 4, 0xdeadbeef


#ifdef rvtest_mtrap_routine

mtrap_sigptr:
    .fill 64*(XLEN/32),4,0xdeadbeef

#endif

#ifdef rvtest_gpr_save

gpr_save:
    .fill 32*(XLEN/32),4,0xdeadbeef

#endif

RVMODEL_DATA_END

