// RISC-V Architectural Validation Test JALR-01
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
// Description: Testing instruction 'JALR'.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32I")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN







#ifdef TEST_CASE_1


    
    RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*I.*);def TEST_CASE_1=True;",jalr)

    RVTEST_SIGBASE(x6,signature_1_0)
 
    
 
 
    # Testcase 0:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x16, 1f + 989
    jalr x1, x16,  -989
    li x8, 0x123ab
1: 
    sw x8, 0(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 1:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x15, 2f - 91
    jalr x2, x15,  91
    li x8, 0x123ab
2: 
    sw x8, 4(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 2:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x14, 2b - 704
    jalr x3, x14,  704
    li x8, 0x123ab
4: 
    sw x8, 8(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 3:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x13, 4f + 1085
    jalr x4, x13,  -1085
    li x8, 0x123ab
4: 
    sw x8, 12(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 4:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x12, 5f - 175
    jalr x5, x12,  175
    li x8, 0x123ab
5: 
    sw x8, 16(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_2_0)
 
    
 
 
    # Testcase 5:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 1f - 591
    jalr x6, x11,  591
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 6:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 2f + 53
    jalr x7, x10,  -53
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 7:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 2b + 1861
    jalr x8, x9,  -1861
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 8:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 4f + 319
    jalr x9, x8,  -319
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 9:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 5f - 405
    jalr x10, x7,  405
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_3_0)
 
    
 
 
    # Testcase 10:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x6, 1f + 1
    jalr x11, x6,  -1
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 11:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x5, 2f - 2047
    jalr x12, x5,  2047
    li x8, 0x123ab
2: 
    sw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 12:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x4, 2b + 1025
    jalr x13, x4,  -1025
    li x8, 0x123ab
4: 
    sw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 13:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x3, 4f + 513
    jalr x14, x3,  -513
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 14:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x2, 5f + 257
    jalr x15, x2,  -257
    li x8, 0x123ab
5: 
    sw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



    

    RVTEST_SIGBASE(x2,signature_4_0)
 
    
 
 
    # Testcase 15:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x1, 1f + 129
    jalr x16, x1,  -129
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


 
    # Testcase 16:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x31, 2f + 65
    jalr x17, x31,  -65
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 17:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x30, 2b + 33
    jalr x18, x30,  -33
    li x4, 0x123ab
4: 
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)  


 
    # Testcase 18:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x29, 4f + 17
    jalr x19, x29,  -17
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


 
    # Testcase 19:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x28, 5f + 9
    jalr x20, x28,  -9
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_5_0)
 
    
 
 
    # Testcase 20:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 1f + 5
    jalr x21, x27,  -5
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 21:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 2f + 3
    jalr x22, x26,  -3
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 22:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 2b + 2
    jalr x23, x25,  -2
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 23:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 4f - 0
    jalr x24, x24,  0
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 24:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 5f + 2048
    jalr x25, x23,  -2048
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_6_0)
 
    
 
 
    # Testcase 25:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x22, 1f - 1024
    jalr x26, x22,  1024
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 26:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x21, 2f - 512
    jalr x27, x21,  512
    li x8, 0x123ab
2: 
    sw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 27:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x20, 2b - 256
    jalr x28, x20,  256
    li x8, 0x123ab
4: 
    sw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 28:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x19, 4f - 128
    jalr x29, x19,  128
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 29:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x18, 5f - 64
    jalr x30, x18,  64
    li x8, 0x123ab
5: 
    sw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



    

    RVTEST_SIGBASE(x5,signature_7_0)
 
    
 
 
    # Testcase 30:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x17, 1f - 32
    jalr x31, x17,  32
    li x7, 0x123ab
1: 
    sw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 31:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x16, 2f - 16
    jalr x1, x16,  16
    li x7, 0x123ab
2: 
    sw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 32:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x15, 2b - 8
    jalr x2, x15,  8
    li x7, 0x123ab
4: 
    sw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  


 
    # Testcase 33:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x14, 4f - 4
    jalr x3, x14,  4
    li x7, 0x123ab
4: 
    sw x7, 12(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 34:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x13, 5f - 2
    jalr x4, x13,  2
    li x7, 0x123ab
5: 
    sw x7, 16(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_8_0)
 
    
 
 
    # Testcase 35:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 1f - 1
    jalr x5, x12,  1
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 36:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 2f + 989
    jalr x6, x11,  -989
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 37:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 2b - 91
    jalr x7, x10,  91
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 38:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 4f - 704
    jalr x8, x9,  704
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 39:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 5f + 1085
    jalr x9, x8,  -1085
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_9_0)
 
    
 
 
    # Testcase 40:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x7, 1f - 175
    jalr x10, x7,  175
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 41:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x6, 2f - 591
    jalr x11, x6,  591
    li x8, 0x123ab
2: 
    sw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 42:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x5, 2b + 53
    jalr x12, x5,  -53
    li x8, 0x123ab
4: 
    sw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)  


 
    # Testcase 43:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x4, 4f + 1861
    jalr x13, x4,  -1861
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 44:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x3, 5f + 319
    jalr x14, x3,  -319
    li x8, 0x123ab
5: 
    sw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 



    

    RVTEST_SIGBASE(x3,signature_10_0)
 
    
 
 
    # Testcase 45:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x2, 1f - 405
    jalr x15, x2,  405
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 46:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x1, 2f + 1
    jalr x16, x1,  -1
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 47:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x31, 2b - 2047
    jalr x17, x31,  2047
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  


 
    # Testcase 48:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x30, 4f + 1025
    jalr x18, x30,  -1025
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 49:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x29, 5f + 513
    jalr x19, x29,  -513
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_11_0)
 
    
 
 
    # Testcase 50:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 1f + 257
    jalr x20, x28,  -257
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 51:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 2f + 129
    jalr x21, x27,  -129
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 52:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 2b + 65
    jalr x22, x26,  -65
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 53:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 4f + 33
    jalr x23, x25,  -33
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 54:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 5f + 17
    jalr x24, x24,  -17
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_12_0)
 
    
 
 
    # Testcase 55:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x23, 1f + 9
    jalr x25, x23,  -9
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 56:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x22, 2f + 5
    jalr x26, x22,  -5
    li x8, 0x123ab
2: 
    sw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 57:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x21, 2b + 3
    jalr x27, x21,  -3
    li x8, 0x123ab
4: 
    sw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)  


 
    # Testcase 58:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x20, 4f + 2
    jalr x28, x20,  -2
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 59:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x19, 5f - 0
    jalr x29, x19,  0
    li x8, 0x123ab
5: 
    sw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 



    

    RVTEST_SIGBASE(x4,signature_13_0)
 
    
 
 
    # Testcase 60:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 1f + 2048
    jalr x30, x18,  -2048
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 61:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x17, 2f - 1024
    jalr x31, x17,  1024
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 62:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x16, 2b - 512
    jalr x1, x16,  512
    li x6, 0x123ab
4: 
    sw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  


 
    # Testcase 63:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x15, 4f - 256
    jalr x2, x15,  256
    li x6, 0x123ab
4: 
    sw x6, 12(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 64:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x14, 5f - 128
    jalr x3, x14,  128
    li x6, 0x123ab
5: 
    sw x6, 16(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_14_0)
 
    
 
 
    # Testcase 65:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x13, 1f - 64
    jalr x4, x13,  64
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 66:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 2f - 0
    jalr x5, x12,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 67:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 2b - 0
    jalr x6, x11,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 68:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 4f - 0
    jalr x7, x10,  0
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 69:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 5f - 0
    jalr x8, x9,  0
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_15_0)
 
    
 
 
    # Testcase 70:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 1f - 0
    jalr x9, x8,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 71:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 2f - 0
    jalr x10, x7,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 72:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 2b - 0
    jalr x11, x6,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 73:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x5, 4f - 0
    jalr x12, x5,  0
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 74:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x4, 5f - 0
    jalr x13, x4,  0
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x4,signature_16_0)
 
    
 
 
    # Testcase 75:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x3, 1f - 0
    jalr x14, x3,  0
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 76:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x2, 2f - 0
    jalr x15, x2,  0
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 77:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x1, 2b - 0
    jalr x16, x1,  0
    li x6, 0x123ab
4: 
    sw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  


 
    # Testcase 78:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x31, 4f - 0
    jalr x17, x31,  0
    li x6, 0x123ab
4: 
    sw x6, 12(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 79:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x30, 5f - 0
    jalr x18, x30,  0
    li x6, 0x123ab
5: 
    sw x6, 16(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_17_0)
 
    
 
 
    # Testcase 80:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x29, 1f - 0
    jalr x19, x29,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 81:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 2f - 0
    jalr x20, x28,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 82:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 2b - 0
    jalr x21, x27,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 83:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 4f - 0
    jalr x22, x26,  0
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 84:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 5f - 0
    jalr x23, x25,  0
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_18_0)
 
    
 
 
    # Testcase 85:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 1f - 0
    jalr x24, x24,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 86:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 2f - 0
    jalr x25, x23,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 87:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 2b - 0
    jalr x26, x22,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 88:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x21, 4f - 0
    jalr x27, x21,  0
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 89:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x20, 5f - 0
    jalr x28, x20,  0
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x4,signature_19_0)
 
    
 
 
    # Testcase 90:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x19, 1f - 0
    jalr x29, x19,  0
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 91:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 2f - 0
    jalr x30, x18,  0
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 92:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x17, 2b - 0
    jalr x31, x17,  0
    li x6, 0x123ab
4: 
    sw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  


 
    # Testcase 93:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x16, 4f - 0
    jalr x1, x16,  0
    li x6, 0x123ab
4: 
    sw x6, 12(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 94:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x15, 5f - 0
    jalr x2, x15,  0
    li x6, 0x123ab
5: 
    sw x6, 16(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_20_0)
 
    
 
 
    # Testcase 95:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x14, 1f - 0
    jalr x3, x14,  0
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 96:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x13, 2f - 0
    jalr x4, x13,  0
    li x8, 0x123ab
2: 
    sw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 97:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x12, 2b - 0
    jalr x5, x12,  0
    li x8, 0x123ab
4: 
    sw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)  


 
    # Testcase 98:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x11, 4f - 0
    jalr x6, x11,  0
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 


 
    # Testcase 99:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x10, 5f - 0
    jalr x7, x10,  0
    li x8, 0x123ab
5: 
    sw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_21_0)
 
    
 
 
    # Testcase 100:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 1f - 0
    jalr x8, x9,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 101:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 2f - 0
    jalr x9, x8,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 102:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 2b - 0
    jalr x10, x7,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 103:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 4f - 0
    jalr x11, x6,  0
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 104:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x5, 5f - 0
    jalr x12, x5,  0
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x5,signature_22_0)
 
    
 
 
    # Testcase 105:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x4, 1f - 0
    jalr x13, x4,  0
    li x7, 0x123ab
1: 
    sw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 106:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x3, 2f - 0
    jalr x14, x3,  0
    li x7, 0x123ab
2: 
    sw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 107:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x2, 2b - 0
    jalr x15, x2,  0
    li x7, 0x123ab
4: 
    sw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  


 
    # Testcase 108:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x1, 4f - 0
    jalr x16, x1,  0
    li x7, 0x123ab
4: 
    sw x7, 12(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 109:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x31, 5f - 0
    jalr x17, x31,  0
    li x7, 0x123ab
5: 
    sw x7, 16(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_23_0)
 
    
 
 
    # Testcase 110:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x30, 1f - 0
    jalr x18, x30,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 111:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x29, 2f - 0
    jalr x19, x29,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 112:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 2b - 0
    jalr x20, x28,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 113:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 4f - 0
    jalr x21, x27,  0
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 114:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 5f - 0
    jalr x22, x26,  0
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_24_0)
 
    
 
 
    # Testcase 115:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 1f - 0
    jalr x23, x25,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 116:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 2f - 0
    jalr x24, x24,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 117:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 2b - 0
    jalr x25, x23,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 118:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 4f - 0
    jalr x26, x22,  0
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 119:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x21, 5f - 0
    jalr x27, x21,  0
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x5,signature_25_0)
 
    
 
 
    # Testcase 120:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x20, 1f - 0
    jalr x28, x20,  0
    li x7, 0x123ab
1: 
    sw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 121:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x19, 2f - 0
    jalr x29, x19,  0
    li x7, 0x123ab
2: 
    sw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 122:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x18, 2b - 0
    jalr x30, x18,  0
    li x7, 0x123ab
4: 
    sw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)  


 
    # Testcase 123:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x17, 4f - 0
    jalr x31, x17,  0
    li x7, 0x123ab
4: 
    sw x7, 12(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 


 
    # Testcase 124:  result rd:x7(0xcccc)
    li x7, 0xcccc
    la x16, 5f - 0
    jalr x1, x16,  0
    li x7, 0x123ab
5: 
    sw x7, 16(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_26_0)
 
    
 
 
    # Testcase 125:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x15, 1f - 0
    jalr x2, x15,  0
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 126:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x14, 2f - 0
    jalr x3, x14,  0
    li x8, 0x123ab
2: 
    sw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 127:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x13, 2b - 0
    jalr x4, x13,  0
    li x8, 0x123ab
4: 
    sw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 128:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x12, 4f - 0
    jalr x5, x12,  0
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 129:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x11, 5f - 0
    jalr x6, x11,  0
    li x8, 0x123ab
5: 
    sw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_27_0)
 
    
 
 
    # Testcase 130:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 1f - 0
    jalr x7, x10,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 131:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 2f - 0
    jalr x8, x9,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 132:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 2b + 2048
    jalr x9, x8,  -2048
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 133:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 4f - 1024
    jalr x10, x7,  1024
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 134:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 5f - 512
    jalr x11, x6,  512
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x6,signature_28_0)
 
    
 
 
    # Testcase 135:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x5, 1f - 256
    jalr x12, x5,  256
    li x8, 0x123ab
1: 
    sw x8, 0(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 136:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x4, 2f - 128
    jalr x13, x4,  128
    li x8, 0x123ab
2: 
    sw x8, 4(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 137:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x3, 2b - 64
    jalr x14, x3,  64
    li x8, 0x123ab
4: 
    sw x8, 8(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)  


 
    # Testcase 138:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x2, 4f - 32
    jalr x15, x2,  32
    li x8, 0x123ab
4: 
    sw x8, 12(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 


 
    # Testcase 139:  result rd:x8(0xcccc)
    li x8, 0xcccc
    la x1, 5f - 16
    jalr x16, x1,  16
    li x8, 0x123ab
5: 
    sw x8, 16(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_29_0)
 
    
 
 
    # Testcase 140:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x31, 1f - 8
    jalr x17, x31,  8
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 141:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x30, 2f - 4
    jalr x18, x30,  4
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 142:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x29, 2b - 2
    jalr x19, x29,  2
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  


 
    # Testcase 143:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 4f - 1
    jalr x0, x28,  1
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 144:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 5f + 989
    jalr x21, x27,  -989
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 



    

    RVTEST_SIGBASE(x1,signature_30_0)
 
    
 
 
    # Testcase 145:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 1f - 91
    jalr x22, x26,  91
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 

	
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

