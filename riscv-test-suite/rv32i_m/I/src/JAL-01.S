// RISC-V Architectural Validation Test JAL-01
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
// Description: Testing instruction 'JAL'.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32I")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN







#ifdef TEST_CASE_1


    
    RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*I.*);def TEST_CASE_1=True;",jal)

    RVTEST_SIGBASE(x1,signature_1_0)
    
     # Testcase 0:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x19, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 1:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x28, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 2:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x30, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 3:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x20, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 4:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x10, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_2_0)
    
     # Testcase 5:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x0, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xcccc)

     # Testcase 6:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x3, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 7:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x31, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xcccc)

     # Testcase 8:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x29, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xcccc)

     # Testcase 9:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x5, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_3_0)
    
     # Testcase 10:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x0, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 11:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x13, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 12:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x4, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 13:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x11, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 14:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x25, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_4_0)
    
     # Testcase 15:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x2, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 16:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x18, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 17:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x18, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 18:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x7, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 19:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x9, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_5_0)
    
     # Testcase 20:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x31, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 21:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x17, 2f
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
    jal x23, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 23:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x31, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 24:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x21, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_6_0)
    
     # Testcase 25:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x0, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 26:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x30, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 27:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x0, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 28:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x17, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 29:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x31, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_7_0)
    
     # Testcase 30:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x6, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 31:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x11, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 32:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x22, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 33:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x9, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 34:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x2, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_8_0)
    
     # Testcase 35:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x7, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xcccc)

     # Testcase 36:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x13, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 37:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x7, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xcccc)

     # Testcase 38:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x3, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xcccc)

     # Testcase 39:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x13, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xcccc)



    

    RVTEST_SIGBASE(x5,signature_9_0)
    
     # Testcase 40:  result rd:x7(0xcccc)
    li x7, 0xcccc
    jal x1, 1f
    li x7, 0x123ab
1: 
    sw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 41:  result rd:x7(0xcccc)
    li x7, 0xcccc
    jal x1, 2f
    li x7, 0x123ab
2: 
    sw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 42:  result rd:x7(0xcccc)
    li x7, 0xcccc
    jal x2, 2b
    li x7, 0x123ab
4:
    sw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 43:  result rd:x7(0xcccc)
    li x7, 0xcccc
    jal x3, 4f
    li x7, 0x123ab
4: 
    sw x7, 12(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)

     # Testcase 44:  result rd:x7(0xcccc)
    li x7, 0xcccc
    jal x4, 5f
    li x7, 0x123ab
5: 
    sw x7, 16(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_10_0)
    
     # Testcase 45:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x5, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 46:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x6, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 47:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x7, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 48:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x8, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 49:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x9, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_11_0)
    
     # Testcase 50:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x10, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 51:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x11, 2f
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
    jal x12, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 53:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x13, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 54:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x14, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_12_0)
    
     # Testcase 55:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x15, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 56:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x16, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 57:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x17, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 58:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x18, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 59:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x19, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_13_0)
    
     # Testcase 60:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x20, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 61:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x21, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 62:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x22, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 63:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x23, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 64:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x24, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_14_0)
    
     # Testcase 65:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x25, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 66:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x26, 2f
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
    jal x27, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 68:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x28, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 69:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x29, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x3,signature_15_0)
    
     # Testcase 70:  result rd:x5(0xcccc)
    li x5, 0xcccc
    jal x30, 1f
    li x5, 0x123ab
1: 
    sw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 71:  result rd:x5(0xcccc)
    li x5, 0xcccc
    jal x31, 2f
    li x5, 0x123ab
2: 
    sw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 72:  result rd:x5(0xcccc)
    li x5, 0xcccc
    jal x1, 2b
    li x5, 0x123ab
4:
    sw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 73:  result rd:x5(0xcccc)
    li x5, 0xcccc
    jal x1, 4f
    li x5, 0x123ab
4: 
    sw x5, 12(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)

     # Testcase 74:  result rd:x5(0xcccc)
    li x5, 0xcccc
    jal x2, 5f
    li x5, 0x123ab
5: 
    sw x5, 16(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_16_0)
    
     # Testcase 75:  result rd:x8(0xcccc)
    li x8, 0xcccc
    jal x3, 1f
    li x8, 0x123ab
1: 
    sw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 76:  result rd:x8(0xcccc)
    li x8, 0xcccc
    jal x4, 2f
    li x8, 0x123ab
2: 
    sw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 77:  result rd:x8(0xcccc)
    li x8, 0xcccc
    jal x5, 2b
    li x8, 0x123ab
4:
    sw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 78:  result rd:x8(0xcccc)
    li x8, 0xcccc
    jal x6, 4f
    li x8, 0x123ab
4: 
    sw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)

     # Testcase 79:  result rd:x8(0xcccc)
    li x8, 0xcccc
    jal x7, 5f
    li x8, 0x123ab
5: 
    sw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_17_0)
    
     # Testcase 80:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x8, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 81:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x9, 2f
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
    jal x10, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 83:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x11, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 84:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x12, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_18_0)
    
     # Testcase 85:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x13, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 86:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x14, 2f
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
    jal x15, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 88:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x16, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 89:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x17, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_19_0)
    
     # Testcase 90:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x18, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 91:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x19, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 92:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x20, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 93:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x21, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 94:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x22, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_20_0)
    
     # Testcase 95:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x23, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 96:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x24, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 97:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x25, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 98:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x26, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 99:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x27, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x2,signature_21_0)
    
     # Testcase 100:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x28, 1f
    li x4, 0x123ab
1: 
    sw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 101:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x29, 2f
    li x4, 0x123ab
2: 
    sw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 102:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x30, 2b
    li x4, 0x123ab
4:
    sw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 103:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x31, 4f
    li x4, 0x123ab
4: 
    sw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)

     # Testcase 104:  result rd:x4(0xcccc)
    li x4, 0xcccc
    jal x1, 5f
    li x4, 0x123ab
5: 
    sw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0xcccc)



    

    RVTEST_SIGBASE(x6,signature_22_0)
    
     # Testcase 105:  result rd:x8(0xcccc)
    li x8, 0xcccc
    jal x1, 1f
    li x8, 0x123ab
1: 
    sw x8, 0(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)

     # Testcase 106:  result rd:x8(0xcccc)
    li x8, 0xcccc
    jal x2, 2f
    li x8, 0x123ab
2: 
    sw x8, 4(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 107:  result rd:x8(0xcccc)
    li x8, 0xcccc
    jal x3, 2b
    li x8, 0x123ab
4:
    sw x8, 8(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)

     # Testcase 108:  result rd:x8(0xcccc)
    li x8, 0xcccc
    jal x4, 4f
    li x8, 0x123ab
4: 
    sw x8, 12(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)

     # Testcase 109:  result rd:x8(0xcccc)
    li x8, 0xcccc
    jal x5, 5f
    li x8, 0x123ab
5: 
    sw x8, 16(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_23_0)
    
     # Testcase 110:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x6, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 111:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x7, 2f
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
    jal x8, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 113:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x9, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 114:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x10, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_24_0)
    
     # Testcase 115:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x11, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 116:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x12, 2f
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
    jal x13, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 118:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x14, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 119:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x15, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_25_0)
    
     # Testcase 120:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x16, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 121:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x17, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 122:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x18, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 123:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x19, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 124:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x20, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_26_0)
    
     # Testcase 125:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x21, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 126:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x22, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 127:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x23, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 128:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x24, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 129:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x25, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_27_0)
    
     # Testcase 130:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x26, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 131:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x27, 2f
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
    jal x28, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 133:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x29, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 134:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x30, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x4,signature_28_0)
    
     # Testcase 135:  result rd:x6(0xcccc)
    li x6, 0xcccc
    jal x31, 1f
    li x6, 0x123ab
1: 
    sw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 136:  result rd:x6(0xcccc)
    li x6, 0xcccc
    jal x1, 2f
    li x6, 0x123ab
2: 
    sw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 137:  result rd:x6(0xcccc)
    li x6, 0xcccc
    jal x1, 2b
    li x6, 0x123ab
4:
    sw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 138:  result rd:x6(0xcccc)
    li x6, 0xcccc
    jal x2, 4f
    li x6, 0x123ab
4: 
    sw x6, 12(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)

     # Testcase 139:  result rd:x6(0xcccc)
    li x6, 0xcccc
    jal x3, 5f
    li x6, 0x123ab
5: 
    sw x6, 16(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_29_0)
    
     # Testcase 140:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x4, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 141:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x5, 2f
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
    jal x6, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 143:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x7, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 144:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x8, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_30_0)
    
     # Testcase 145:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x9, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 146:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x10, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 147:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x11, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 148:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x12, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 149:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x13, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_31_0)
    
     # Testcase 150:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x14, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 151:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x15, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 152:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x16, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 153:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x17, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 154:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x18, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_32_0)
    
     # Testcase 155:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x19, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 156:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x20, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 157:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x21, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 158:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x22, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 159:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x23, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_33_0)
    
     # Testcase 160:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x24, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 161:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x25, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 162:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x26, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 163:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x27, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 164:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x28, 5f
    li x3, 0x123ab
5: 
    sw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)



    

    RVTEST_SIGBASE(x1,signature_34_0)
    
     # Testcase 165:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x29, 1f
    li x3, 0x123ab
1: 
    sw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 166:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x30, 2f
    li x3, 0x123ab
2: 
    sw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     jal x0, 3f
2:
    jal x0, 4f
3:
    # Testcase 167:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x31, 2b
    li x3, 0x123ab
4:
    sw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xcccc)

     # Testcase 168:  result rd:x3(0xcccc)
    li x3, 0xcccc
    jal x0, 4f
    li x3, 0x123ab
4: 
    sw x3, 12(x1)
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
signature_31_0:
	.fill 5, 4, 0xdeadbeef
signature_32_0:
	.fill 5, 4, 0xdeadbeef
signature_33_0:
	.fill 5, 4, 0xdeadbeef
signature_34_0:
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

