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

    RVTEST_SIGBASE(x4,signature_1_0)
 

 
 
    # Testcase 0:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x31, 1f
    la x5, 3
    sub x31, x31, x5
    jalr x1, x31,  3
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 1:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x30, 2f
    la x5, 27
    sub x30, x30, x5
    jalr x2, x30,  27
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 2:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x29, 2b
    la x5, 0
    sub x29, x29, x5
    jalr x3, x29,  0
    li x6, 0x123ab
4: 
    sw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_2_0)
 

 
 
    # Testcase 3:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 1f
    la x2, 3
    sub x28, x28, x2
    jalr x4, x28,  3
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 4:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 2f
    la x2, 15
    sub x27, x27, x2
    jalr x5, x27,  15
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 5:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 2b
    la x2, 15
    sub x26, x26, x2
    jalr x6, x26,  15
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_3_0)
 

 
 
    # Testcase 6:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 1f
    la x2, 11
    sub x25, x25, x2
    jalr x7, x25,  11
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 7:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 2f
    la x2, 27
    sub x24, x24, x2
    jalr x8, x24,  27
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 8:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 2b
    la x2, 1
    sub x23, x23, x2
    jalr x9, x23,  1
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_4_0)
 

 
 
    # Testcase 9:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 1f
    la x2, 21
    sub x22, x22, x2
    jalr x10, x22,  21
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 10:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x21, 2f
    la x2, 31
    sub x21, x21, x2
    jalr x11, x21,  31
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 11:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x20, 2b
    la x2, 15
    sub x20, x20, x2
    jalr x12, x20,  15
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_5_0)
 

 
 
    # Testcase 12:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x19, 1f
    la x5, 23
    sub x19, x19, x5
    jalr x13, x19,  23
    li x6, 0x123ab
1: 
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 13:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 2f
    la x5, 27
    sub x18, x18, x5
    jalr x14, x18,  27
    li x6, 0x123ab
2: 
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 14:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x17, 2b
    la x5, 29
    sub x17, x17, x5
    jalr x15, x17,  29
    li x6, 0x123ab
4: 
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x2,signature_6_0)
 

 
 
    # Testcase 15:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x16, 1f
    la x3, 30
    sub x16, x16, x3
    jalr x16, x16,  30
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


 
    # Testcase 16:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x15, 2f
    la x3, 0
    sub x15, x15, x3
    jalr x17, x15,  0
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
    la x14, 2b
    la x3, 16
    sub x14, x14, x3
    jalr x18, x14,  16
    li x4, 0x123ab
4: 
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_7_0)
 

 
 
    # Testcase 18:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x13, 1f
    la x2, 8
    sub x13, x13, x2
    jalr x19, x13,  8
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 19:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 2f
    la x2, 4
    sub x12, x12, x2
    jalr x20, x12,  4
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 20:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 2b
    la x2, 2
    sub x11, x11, x2
    jalr x21, x11,  2
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_8_0)
 

 
 
    # Testcase 21:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 1f
    la x2, 1
    sub x10, x10, x2
    jalr x22, x10,  1
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 22:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 2f
    la x2, 3
    sub x9, x9, x2
    jalr x23, x9,  3
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 23:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 2b
    la x2, 27
    sub x8, x8, x2
    jalr x24, x8,  27
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_9_0)
 

 
 
    # Testcase 24:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 1f
    la x2, 0
    sub x7, x7, x2
    jalr x25, x7,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 25:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 2f
    la x2, 3
    sub x6, x6, x2
    jalr x26, x6,  3
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 26:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x5, 2b
    la x2, 15
    sub x5, x5, x2
    jalr x27, x5,  15
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_10_0)
 

 
 
    # Testcase 27:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x4, 1f
    la x5, 15
    sub x4, x4, x5
    jalr x28, x4,  15
    li x6, 0x123ab
1: 
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 28:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x3, 2f
    la x5, 11
    sub x3, x3, x5
    jalr x29, x3,  11
    li x6, 0x123ab
2: 
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 29:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x2, 2b
    la x5, 27
    sub x2, x2, x5
    jalr x30, x2,  27
    li x6, 0x123ab
4: 
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x3,signature_11_0)
 

 
 
    # Testcase 30:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x1, 1f
    la x4, 1
    sub x1, x1, x4
    jalr x31, x1,  1
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 31:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x31, 2f
    la x4, 21
    sub x31, x31, x4
    jalr x1, x31,  21
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 32:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x30, 2b
    la x4, 31
    sub x30, x30, x4
    jalr x2, x30,  31
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_12_0)
 

 
 
    # Testcase 33:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x29, 1f
    la x2, 15
    sub x29, x29, x2
    jalr x3, x29,  15
    li x6, 0x123ab
1: 
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc) 


 
    # Testcase 34:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x28, 2f
    la x2, 23
    sub x28, x28, x2
    jalr x4, x28,  23
    li x6, 0x123ab
2: 
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 35:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x27, 2b
    la x2, 27
    sub x27, x27, x2
    jalr x5, x27,  27
    li x6, 0x123ab
4: 
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_13_0)
 

 
 
    # Testcase 36:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 1f
    la x2, 29
    sub x26, x26, x2
    jalr x6, x26,  29
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 37:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 2f
    la x2, 30
    sub x25, x25, x2
    jalr x7, x25,  30
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 38:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 2b
    la x2, 0
    sub x24, x24, x2
    jalr x8, x24,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_14_0)
 

 
 
    # Testcase 39:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 1f
    la x2, 16
    sub x23, x23, x2
    jalr x9, x23,  16
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 40:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 2f
    la x2, 8
    sub x22, x22, x2
    jalr x10, x22,  8
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 41:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x21, 2b
    la x2, 4
    sub x21, x21, x2
    jalr x11, x21,  4
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_15_0)
 

 
 
    # Testcase 42:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x20, 1f
    la x2, 2
    sub x20, x20, x2
    jalr x12, x20,  2
    li x6, 0x123ab
1: 
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc) 


 
    # Testcase 43:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x19, 2f
    la x2, 1
    sub x19, x19, x2
    jalr x13, x19,  1
    li x6, 0x123ab
2: 
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 44:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 2b
    la x2, 3
    sub x18, x18, x2
    jalr x14, x18,  3
    li x6, 0x123ab
4: 
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x3,signature_16_0)
 

 
 
    # Testcase 45:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x17, 1f
    la x4, 27
    sub x17, x17, x4
    jalr x15, x17,  27
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 46:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x16, 2f
    la x4, 0
    sub x16, x16, x4
    jalr x16, x16,  0
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
    la x15, 2b
    la x4, 3
    sub x15, x15, x4
    jalr x17, x15,  3
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_17_0)
 

 
 
    # Testcase 48:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x14, 1f
    la x2, 15
    sub x14, x14, x2
    jalr x18, x14,  15
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 49:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x13, 2f
    la x2, 15
    sub x13, x13, x2
    jalr x19, x13,  15
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 50:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 2b
    la x2, 11
    sub x12, x12, x2
    jalr x20, x12,  11
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_18_0)
 

 
 
    # Testcase 51:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 1f
    la x2, 27
    sub x11, x11, x2
    jalr x21, x11,  27
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 52:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 2f
    la x2, 1
    sub x10, x10, x2
    jalr x22, x10,  1
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 53:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 2b
    la x2, 21
    sub x9, x9, x2
    jalr x23, x9,  21
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_19_0)
 

 
 
    # Testcase 54:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 1f
    la x2, 31
    sub x8, x8, x2
    jalr x24, x8,  31
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 55:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 2f
    la x2, 15
    sub x7, x7, x2
    jalr x25, x7,  15
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 56:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 2b
    la x2, 23
    sub x6, x6, x2
    jalr x26, x6,  23
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_20_0)
 

 
 
    # Testcase 57:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x5, 1f
    la x2, 27
    sub x5, x5, x2
    jalr x27, x5,  27
    li x6, 0x123ab
1: 
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc) 


 
    # Testcase 58:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x4, 2f
    la x2, 29
    sub x4, x4, x2
    jalr x28, x4,  29
    li x6, 0x123ab
2: 
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 59:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x3, 2b
    la x2, 30
    sub x3, x3, x2
    jalr x29, x3,  30
    li x6, 0x123ab
4: 
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x3,signature_21_0)
 

 
 
    # Testcase 60:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x2, 1f
    la x4, 0
    sub x2, x2, x4
    jalr x30, x2,  0
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 61:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x1, 2f
    la x4, 16
    sub x1, x1, x4
    jalr x31, x1,  16
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 62:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x31, 2b
    la x4, 8
    sub x31, x31, x4
    jalr x1, x31,  8
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_22_0)
 

 
 
    # Testcase 63:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x30, 1f
    la x5, 4
    sub x30, x30, x5
    jalr x2, x30,  4
    li x6, 0x123ab
1: 
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 64:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x29, 2f
    la x5, 2
    sub x29, x29, x5
    jalr x3, x29,  2
    li x6, 0x123ab
2: 
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 65:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x28, 2b
    la x5, 1
    sub x28, x28, x5
    jalr x4, x28,  1
    li x6, 0x123ab
4: 
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_23_0)
 

 
 
    # Testcase 66:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 1f
    la x2, 0
    sub x27, x27, x2
    jalr x5, x27,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 67:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 2f
    la x2, 0
    sub x26, x26, x2
    jalr x6, x26,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 68:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 2b
    la x2, 0
    sub x25, x25, x2
    jalr x7, x25,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_24_0)
 

 
 
    # Testcase 69:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 1f
    la x2, 0
    sub x24, x24, x2
    jalr x8, x24,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 70:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 2f
    la x2, 0
    sub x23, x23, x2
    jalr x9, x23,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 71:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 2b
    la x2, 0
    sub x22, x22, x2
    jalr x10, x22,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_25_0)
 

 
 
    # Testcase 72:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x21, 1f
    la x2, 0
    sub x21, x21, x2
    jalr x11, x21,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 73:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x20, 2f
    la x2, 0
    sub x20, x20, x2
    jalr x12, x20,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 74:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x19, 2b
    la x2, 0
    sub x19, x19, x2
    jalr x13, x19,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x4,signature_26_0)
 

 
 
    # Testcase 75:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 1f
    la x5, 0
    sub x18, x18, x5
    jalr x14, x18,  0
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 76:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x17, 2f
    la x5, 0
    sub x17, x17, x5
    jalr x15, x17,  0
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
    la x16, 2b
    la x5, 0
    sub x16, x16, x5
    jalr x16, x16,  0
    li x6, 0x123ab
4: 
    sw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_27_0)
 

 
 
    # Testcase 78:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x15, 1f
    la x2, 0
    sub x15, x15, x2
    jalr x17, x15,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 79:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x14, 2f
    la x2, 0
    sub x14, x14, x2
    jalr x18, x14,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 80:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x13, 2b
    la x2, 0
    sub x13, x13, x2
    jalr x19, x13,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_28_0)
 

 
 
    # Testcase 81:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 1f
    la x2, 0
    sub x12, x12, x2
    jalr x20, x12,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 82:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 2f
    la x2, 0
    sub x11, x11, x2
    jalr x21, x11,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 83:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 2b
    la x2, 0
    sub x10, x10, x2
    jalr x22, x10,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_29_0)
 

 
 
    # Testcase 84:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 1f
    la x2, 0
    sub x9, x9, x2
    jalr x23, x9,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 85:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 2f
    la x2, 0
    sub x8, x8, x2
    jalr x24, x8,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 86:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 2b
    la x2, 0
    sub x7, x7, x2
    jalr x25, x7,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_30_0)
 

 
 
    # Testcase 87:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 1f
    la x2, 0
    sub x6, x6, x2
    jalr x26, x6,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 88:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x5, 2f
    la x2, 0
    sub x5, x5, x2
    jalr x27, x5,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 89:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x4, 2b
    la x2, 0
    sub x4, x4, x2
    jalr x28, x4,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x4,signature_31_0)
 

 
 
    # Testcase 90:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x3, 1f
    la x5, 0
    sub x3, x3, x5
    jalr x29, x3,  0
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 91:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x2, 2f
    la x5, 0
    sub x2, x2, x5
    jalr x30, x2,  0
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
    la x1, 2b
    la x5, 0
    sub x1, x1, x5
    jalr x31, x1,  0
    li x6, 0x123ab
4: 
    sw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x4,signature_32_0)
 

 
 
    # Testcase 93:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x31, 1f
    la x5, 0
    sub x31, x31, x5
    jalr x1, x31,  0
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 94:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x30, 2f
    la x5, 0
    sub x30, x30, x5
    jalr x2, x30,  0
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 95:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x29, 2b
    la x5, 0
    sub x29, x29, x5
    jalr x3, x29,  0
    li x6, 0x123ab
4: 
    sw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_33_0)
 

 
 
    # Testcase 96:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x28, 1f
    la x2, 0
    sub x28, x28, x2
    jalr x4, x28,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 97:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x27, 2f
    la x2, 0
    sub x27, x27, x2
    jalr x5, x27,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 98:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 2b
    la x2, 0
    sub x26, x26, x2
    jalr x6, x26,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_34_0)
 

 
 
    # Testcase 99:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 1f
    la x2, 0
    sub x25, x25, x2
    jalr x7, x25,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 100:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 2f
    la x2, 0
    sub x24, x24, x2
    jalr x8, x24,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 101:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 2b
    la x2, 0
    sub x23, x23, x2
    jalr x9, x23,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_35_0)
 

 
 
    # Testcase 102:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 1f
    la x2, 0
    sub x22, x22, x2
    jalr x10, x22,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 103:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x21, 2f
    la x2, 0
    sub x21, x21, x2
    jalr x11, x21,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 104:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x20, 2b
    la x2, 0
    sub x20, x20, x2
    jalr x12, x20,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_36_0)
 

 
 
    # Testcase 105:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x19, 1f
    la x5, 0
    sub x19, x19, x5
    jalr x13, x19,  0
    li x6, 0x123ab
1: 
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 106:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 2f
    la x5, 0
    sub x18, x18, x5
    jalr x14, x18,  0
    li x6, 0x123ab
2: 
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 107:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x17, 2b
    la x5, 0
    sub x17, x17, x5
    jalr x15, x17,  0
    li x6, 0x123ab
4: 
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x2,signature_37_0)
 

 
 
    # Testcase 108:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x16, 1f
    la x3, 0
    sub x16, x16, x3
    jalr x16, x16,  0
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


 
    # Testcase 109:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x15, 2f
    la x3, 0
    sub x15, x15, x3
    jalr x17, x15,  0
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 110:  result rd:x4(0xcccc)
    li x4, 0xcccc
    la x14, 2b
    la x3, 0
    sub x14, x14, x3
    jalr x18, x14,  0
    li x4, 0x123ab
4: 
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_38_0)
 

 
 
    # Testcase 111:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x13, 1f
    la x2, 0
    sub x13, x13, x2
    jalr x19, x13,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 112:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 2f
    la x2, 0
    sub x12, x12, x2
    jalr x20, x12,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 113:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 2b
    la x2, 0
    sub x11, x11, x2
    jalr x21, x11,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_39_0)
 

 
 
    # Testcase 114:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 1f
    la x2, 0
    sub x10, x10, x2
    jalr x22, x10,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 115:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x9, 2f
    la x2, 0
    sub x9, x9, x2
    jalr x23, x9,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 116:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x8, 2b
    la x2, 0
    sub x8, x8, x2
    jalr x24, x8,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_40_0)
 

 
 
    # Testcase 117:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x7, 1f
    la x2, 0
    sub x7, x7, x2
    jalr x25, x7,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 118:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x6, 2f
    la x2, 0
    sub x6, x6, x2
    jalr x26, x6,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 119:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x5, 2b
    la x2, 0
    sub x5, x5, x2
    jalr x27, x5,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_41_0)
 

 
 
    # Testcase 120:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x4, 1f
    la x5, 0
    sub x4, x4, x5
    jalr x28, x4,  0
    li x6, 0x123ab
1: 
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


 
    # Testcase 121:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x3, 2f
    la x5, 0
    sub x3, x3, x5
    jalr x29, x3,  0
    li x6, 0x123ab
2: 
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 122:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x2, 2b
    la x5, 0
    sub x2, x2, x5
    jalr x30, x2,  0
    li x6, 0x123ab
4: 
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x3,signature_42_0)
 

 
 
    # Testcase 123:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x1, 1f
    la x4, 0
    sub x1, x1, x4
    jalr x31, x1,  0
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 124:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x31, 2f
    la x4, 0
    sub x31, x31, x4
    jalr x1, x31,  0
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 125:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x30, 2b
    la x4, 0
    sub x30, x30, x4
    jalr x2, x30,  0
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_43_0)
 

 
 
    # Testcase 126:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x29, 1f
    la x2, 0
    sub x29, x29, x2
    jalr x3, x29,  0
    li x6, 0x123ab
1: 
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc) 


 
    # Testcase 127:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x28, 2f
    la x2, 0
    sub x28, x28, x2
    jalr x4, x28,  0
    li x6, 0x123ab
2: 
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 128:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x27, 2b
    la x2, 0
    sub x27, x27, x2
    jalr x5, x27,  0
    li x6, 0x123ab
4: 
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_44_0)
 

 
 
    # Testcase 129:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x26, 1f
    la x2, 0
    sub x26, x26, x2
    jalr x6, x26,  0
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 130:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x25, 2f
    la x2, 0
    sub x25, x25, x2
    jalr x7, x25,  0
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 131:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x24, 2b
    la x2, 0
    sub x24, x24, x2
    jalr x8, x24,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_45_0)
 

 
 
    # Testcase 132:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x23, 1f
    la x2, 3
    sub x23, x23, x2
    jalr x9, x23,  3
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 133:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x22, 2f
    la x2, 27
    sub x22, x22, x2
    jalr x10, x22,  27
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 134:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x21, 2b
    la x2, 0
    sub x21, x21, x2
    jalr x11, x21,  0
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_46_0)
 

 
 
    # Testcase 135:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x20, 1f
    la x2, 3
    sub x20, x20, x2
    jalr x12, x20,  3
    li x6, 0x123ab
1: 
    sw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc) 


 
    # Testcase 136:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x19, 2f
    la x2, 15
    sub x19, x19, x2
    jalr x13, x19,  15
    li x6, 0x123ab
2: 
    sw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 137:  result rd:x6(0xcccc)
    li x6, 0xcccc
    la x18, 2b
    la x2, 15
    sub x18, x18, x2
    jalr x14, x18,  15
    li x6, 0x123ab
4: 
    sw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xcccc)  



    

    RVTEST_SIGBASE(x3,signature_47_0)
 

 
 
    # Testcase 138:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x17, 1f
    la x4, 11
    sub x17, x17, x4
    jalr x15, x17,  11
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


 
    # Testcase 139:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x16, 2f
    la x4, 27
    sub x16, x16, x4
    jalr x16, x16,  27
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 140:  result rd:x5(0xcccc)
    li x5, 0xcccc
    la x15, 2b
    la x4, 1
    sub x15, x15, x4
    jalr x17, x15,  1
    li x5, 0x123ab
4: 
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_48_0)
 

 
 
    # Testcase 141:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x14, 1f
    la x2, 21
    sub x14, x14, x2
    jalr x18, x14,  21
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 142:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x13, 2f
    la x2, 31
    sub x13, x13, x2
    jalr x19, x13,  31
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


    jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 143:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x12, 2b
    la x2, 15
    sub x12, x12, x2
    jalr x0, x12,  15
    li x3, 0x123ab
4: 
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)  



    

    RVTEST_SIGBASE(x1,signature_49_0)
 

 
 
    # Testcase 144:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x11, 1f
    la x2, 23
    sub x11, x11, x2
    jalr x21, x11,  23
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc) 


 
    # Testcase 145:  result rd:x3(0xcccc)
    li x3, 0xcccc
    la x10, 2f
    la x2, 27
    sub x10, x10, x2
    jalr x22, x10,  27
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
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


#ifdef rvtest_mtrap_routine

mtrap_sigptr:
    .fill 64*(XLEN/32),4,0xdeadbeef

#endif

#ifdef rvtest_gpr_save

gpr_save:
    .fill 32*(XLEN/32),4,0xdeadbeef

#endif

RVMODEL_DATA_END

