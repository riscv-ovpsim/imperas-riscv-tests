// RISC-V Architectural Validation Test SB-01
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
// Description: Testing instruction 'SB'.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32I")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN







#ifdef TEST_CASE_1


    
    RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*I.*);def TEST_CASE_1=True;",sb)

    RVTEST_SIGBASE(x6,signature_1_0)

    # Clear memory
    sw      x0, 0(x6)
    # Load values and compute offsets
    li      x16, 0x121bcc23
    addi    x31, x6,0
    li     x7, MASK_XLEN(989)
    add    x31, x31, x7
    # Test Instruction 
    sb      x16, -989(x31)
    # Check results:  mem[test_1_res+0] = 0x00000023
    lw x8, 0(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000023)

    # Clear memory
    sw      x0, 4(x6)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x6,4
    li     x7, MASK_XLEN(-91)
    add    x30, x30, x7
    # Test Instruction 
    sb      x15, 91(x30)
    # Check results:  mem[test_1_res+4] = 0x00000000
    lw x8, 4(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x6)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x6,8
    li     x7, MASK_XLEN(-704)
    add    x29, x29, x7
    # Test Instruction 
    sb      x14, 704(x29)
    # Check results:  mem[test_1_res+8] = 0x00000000
    lw x8, 8(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x6)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x6,12
    li     x7, MASK_XLEN(1085)
    add    x28, x28, x7
    # Test Instruction 
    sb      x13, -1085(x28)
    # Check results:  mem[test_1_res+12] = 0x00000000
    lw x8, 12(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x6)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x6,16
    li     x7, MASK_XLEN(-175)
    add    x27, x27, x7
    # Test Instruction 
    sb      x12, 175(x27)
    # Check results:  mem[test_1_res+16] = 0x00000000
    lw x8, 16(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_2_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x26, x1,0
    li     x2, MASK_XLEN(-591)
    add    x26, x26, x2
    # Test Instruction 
    sb      x11, 591(x26)
    # Check results:  mem[test_2_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,4
    li     x2, MASK_XLEN(53)
    add    x25, x25, x2
    # Test Instruction 
    sb      x10, -53(x25)
    # Check results:  mem[test_2_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x24, x1,8
    li     x2, MASK_XLEN(1861)
    add    x24, x24, x2
    # Test Instruction 
    sb      x9, -1861(x24)
    # Check results:  mem[test_2_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x23, x1,12
    li     x2, MASK_XLEN(319)
    add    x23, x23, x2
    # Test Instruction 
    sb      x8, -319(x23)
    # Check results:  mem[test_2_res+12] = 0x00000000
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x22, x1,16
    li     x2, MASK_XLEN(-405)
    add    x22, x22, x2
    # Test Instruction 
    sb      x7, 405(x22)
    # Check results:  mem[test_2_res+16] = 0x00000000
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_3_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x21, x1,0
    li     x7, MASK_XLEN(1)
    add    x21, x21, x7
    # Test Instruction 
    sb      x6, -1(x21)
    # Check results:  mem[test_3_res+0] = 0x00000000
    lw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x20, x1,4
    li     x7, MASK_XLEN(-2047)
    add    x20, x20, x7
    # Test Instruction 
    sb      x5, 2047(x20)
    # Check results:  mem[test_3_res+4] = 0x00000000
    lw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x19, x1,8
    li     x7, MASK_XLEN(1025)
    add    x19, x19, x7
    # Test Instruction 
    sb      x4, -1025(x19)
    # Check results:  mem[test_3_res+8] = 0x00000000
    lw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x18, x1,12
    li     x7, MASK_XLEN(513)
    add    x18, x18, x7
    # Test Instruction 
    sb      x3, -513(x18)
    # Check results:  mem[test_3_res+12] = 0x00000000
    lw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x17, x1,16
    li     x7, MASK_XLEN(257)
    add    x17, x17, x7
    # Test Instruction 
    sb      x2, -257(x17)
    # Check results:  mem[test_3_res+16] = 0x00000000
    lw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)



    

    RVTEST_SIGBASE(x2,signature_4_0)

    # Clear memory
    sw      x0, 0(x2)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x16, x2,0
    li     x3, MASK_XLEN(129)
    add    x16, x16, x3
    # Test Instruction 
    sb      x1, -129(x16)
    # Check results:  mem[test_4_res+0] = 0x00000000
    lw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 4(x2)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x15, x2,4
    li     x3, MASK_XLEN(65)
    add    x15, x15, x3
    # Test Instruction 
    sb      x31, -65(x15)
    # Check results:  mem[test_4_res+4] = 0x00000000
    lw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 8(x2)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x14, x2,8
    li     x3, MASK_XLEN(33)
    add    x14, x14, x3
    # Test Instruction 
    sb      x30, -33(x14)
    # Check results:  mem[test_4_res+8] = 0x00000000
    lw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 12(x2)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x13, x2,12
    li     x3, MASK_XLEN(17)
    add    x13, x13, x3
    # Test Instruction 
    sb      x29, -17(x13)
    # Check results:  mem[test_4_res+12] = 0x00000000
    lw x4, 12(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 16(x2)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x12, x2,16
    li     x3, MASK_XLEN(9)
    add    x12, x12, x3
    # Test Instruction 
    sb      x28, -9(x12)
    # Check results:  mem[test_4_res+16] = 0x00000000
    lw x4, 16(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_5_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x11, x1,0
    li     x2, MASK_XLEN(5)
    add    x11, x11, x2
    # Test Instruction 
    sb      x27, -5(x11)
    # Check results:  mem[test_5_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x10, x1,4
    li     x2, MASK_XLEN(3)
    add    x10, x10, x2
    # Test Instruction 
    sb      x26, -3(x10)
    # Check results:  mem[test_5_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x9, x1,8
    li     x2, MASK_XLEN(2)
    add    x9, x9, x2
    # Test Instruction 
    sb      x25, -2(x9)
    # Check results:  mem[test_5_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x8, x1,12
    li     x2, MASK_XLEN(0)
    add    x8, x8, x2
    # Test Instruction 
    sb      x24, 0(x8)
    # Check results:  mem[test_5_res+12] = 0x00000000
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x7, x1,16
    li     x2, MASK_XLEN(2048)
    add    x7, x7, x2
    # Test Instruction 
    sb      x23, -2048(x7)
    # Check results:  mem[test_5_res+16] = 0x00000000
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_6_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x6, x1,0
    li     x7, MASK_XLEN(-1024)
    add    x6, x6, x7
    # Test Instruction 
    sb      x22, 1024(x6)
    # Check results:  mem[test_6_res+0] = 0x00000000
    lw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x5, x1,4
    li     x7, MASK_XLEN(-512)
    add    x5, x5, x7
    # Test Instruction 
    sb      x21, 512(x5)
    # Check results:  mem[test_6_res+4] = 0x00000000
    lw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x4, x1,8
    li     x7, MASK_XLEN(-256)
    add    x4, x4, x7
    # Test Instruction 
    sb      x20, 256(x4)
    # Check results:  mem[test_6_res+8] = 0x00000000
    lw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x3, x1,12
    li     x7, MASK_XLEN(-128)
    add    x3, x3, x7
    # Test Instruction 
    sb      x19, 128(x3)
    # Check results:  mem[test_6_res+12] = 0x00000000
    lw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x1,16
    li     x7, MASK_XLEN(-64)
    add    x2, x2, x7
    # Test Instruction 
    sb      x18, 64(x2)
    # Check results:  mem[test_6_res+16] = 0x00000000
    lw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x00000000)



    

    RVTEST_SIGBASE(x5,signature_7_0)

    # Clear memory
    sw      x0, 0(x5)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x1, x5,0
    li     x6, MASK_XLEN(-32)
    add    x1, x1, x6
    # Test Instruction 
    sb      x17, 32(x1)
    # Check results:  mem[test_7_res+0] = 0x00000000
    lw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 4(x5)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x31, x5,4
    li     x6, MASK_XLEN(-16)
    add    x31, x31, x6
    # Test Instruction 
    sb      x16, 16(x31)
    # Check results:  mem[test_7_res+4] = 0x00000000
    lw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 8(x5)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x5,8
    li     x6, MASK_XLEN(-8)
    add    x30, x30, x6
    # Test Instruction 
    sb      x15, 8(x30)
    # Check results:  mem[test_7_res+8] = 0x00000000
    lw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 12(x5)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x5,12
    li     x6, MASK_XLEN(-4)
    add    x29, x29, x6
    # Test Instruction 
    sb      x14, 4(x29)
    # Check results:  mem[test_7_res+12] = 0x00000000
    lw x7, 12(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 16(x5)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x5,16
    li     x6, MASK_XLEN(-2)
    add    x28, x28, x6
    # Test Instruction 
    sb      x13, 2(x28)
    # Check results:  mem[test_7_res+16] = 0x00000000
    lw x7, 16(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_8_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x1,0
    li     x2, MASK_XLEN(-1)
    add    x27, x27, x2
    # Test Instruction 
    sb      x12, 1(x27)
    # Check results:  mem[test_8_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x26, x1,4
    li     x2, MASK_XLEN(989)
    add    x26, x26, x2
    # Test Instruction 
    sb      x11, -989(x26)
    # Check results:  mem[test_8_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,8
    li     x2, MASK_XLEN(-91)
    add    x25, x25, x2
    # Test Instruction 
    sb      x10, 91(x25)
    # Check results:  mem[test_8_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x24, x1,12
    li     x2, MASK_XLEN(-704)
    add    x24, x24, x2
    # Test Instruction 
    sb      x9, 704(x24)
    # Check results:  mem[test_8_res+12] = 0x00000000
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x23, x1,16
    li     x2, MASK_XLEN(1085)
    add    x23, x23, x2
    # Test Instruction 
    sb      x8, -1085(x23)
    # Check results:  mem[test_8_res+16] = 0x00000000
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_9_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x22, x1,0
    li     x2, MASK_XLEN(-175)
    add    x22, x22, x2
    # Test Instruction 
    sb      x7, 175(x22)
    # Check results:  mem[test_9_res+0] = 0x00000000
    lw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x21, x1,4
    li     x2, MASK_XLEN(-591)
    add    x21, x21, x2
    # Test Instruction 
    sb      x6, 591(x21)
    # Check results:  mem[test_9_res+4] = 0x00000000
    lw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x20, x1,8
    li     x2, MASK_XLEN(53)
    add    x20, x20, x2
    # Test Instruction 
    sb      x5, -53(x20)
    # Check results:  mem[test_9_res+8] = 0x00000000
    lw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x19, x1,12
    li     x2, MASK_XLEN(1861)
    add    x19, x19, x2
    # Test Instruction 
    sb      x4, -1861(x19)
    # Check results:  mem[test_9_res+12] = 0x00000000
    lw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x18, x1,16
    li     x2, MASK_XLEN(319)
    add    x18, x18, x2
    # Test Instruction 
    sb      x3, -319(x18)
    # Check results:  mem[test_9_res+16] = 0x00000000
    lw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)



    

    RVTEST_SIGBASE(x3,signature_10_0)

    # Clear memory
    sw      x0, 0(x3)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x17, x3,0
    li     x4, MASK_XLEN(-405)
    add    x17, x17, x4
    # Test Instruction 
    sb      x2, 405(x17)
    # Check results:  mem[test_10_res+0] = 0x00000000
    lw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 4(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x16, x3,4
    li     x4, MASK_XLEN(1)
    add    x16, x16, x4
    # Test Instruction 
    sb      x1, -1(x16)
    # Check results:  mem[test_10_res+4] = 0x00000000
    lw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 8(x3)
    # Load values and compute offsets
    li      x31, 0x0
    addi    x15, x3,8
    li     x4, MASK_XLEN(-2047)
    add    x15, x15, x4
    # Test Instruction 
    sb      x31, 2047(x15)
    # Check results:  mem[test_10_res+8] = 0x00000000
    lw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 12(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x14, x3,12
    li     x4, MASK_XLEN(1025)
    add    x14, x14, x4
    # Test Instruction 
    sb      x30, -1025(x14)
    # Check results:  mem[test_10_res+12] = 0x00000000
    lw x5, 12(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 16(x3)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x13, x3,16
    li     x4, MASK_XLEN(513)
    add    x13, x13, x4
    # Test Instruction 
    sb      x29, -513(x13)
    # Check results:  mem[test_10_res+16] = 0x00000000
    lw x5, 16(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_11_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x12, x1,0
    li     x2, MASK_XLEN(257)
    add    x12, x12, x2
    # Test Instruction 
    sb      x28, -257(x12)
    # Check results:  mem[test_11_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x11, x1,4
    li     x2, MASK_XLEN(129)
    add    x11, x11, x2
    # Test Instruction 
    sb      x27, -129(x11)
    # Check results:  mem[test_11_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x10, x1,8
    li     x2, MASK_XLEN(65)
    add    x10, x10, x2
    # Test Instruction 
    sb      x26, -65(x10)
    # Check results:  mem[test_11_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x9, x1,12
    li     x2, MASK_XLEN(33)
    add    x9, x9, x2
    # Test Instruction 
    sb      x25, -33(x9)
    # Check results:  mem[test_11_res+12] = 0x00000000
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x8, x1,16
    li     x2, MASK_XLEN(17)
    add    x8, x8, x2
    # Test Instruction 
    sb      x24, -17(x8)
    # Check results:  mem[test_11_res+16] = 0x00000000
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_12_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x7, x1,0
    li     x2, MASK_XLEN(9)
    add    x7, x7, x2
    # Test Instruction 
    sb      x23, -9(x7)
    # Check results:  mem[test_12_res+0] = 0x00000000
    lw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x6, x1,4
    li     x2, MASK_XLEN(5)
    add    x6, x6, x2
    # Test Instruction 
    sb      x22, -5(x6)
    # Check results:  mem[test_12_res+4] = 0x00000000
    lw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x5, x1,8
    li     x2, MASK_XLEN(3)
    add    x5, x5, x2
    # Test Instruction 
    sb      x21, -3(x5)
    # Check results:  mem[test_12_res+8] = 0x00000000
    lw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x4, x1,12
    li     x2, MASK_XLEN(2)
    add    x4, x4, x2
    # Test Instruction 
    sb      x20, -2(x4)
    # Check results:  mem[test_12_res+12] = 0x00000000
    lw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x3, x1,16
    li     x2, MASK_XLEN(0)
    add    x3, x3, x2
    # Test Instruction 
    sb      x19, 0(x3)
    # Check results:  mem[test_12_res+16] = 0x00000000
    lw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)



    

    RVTEST_SIGBASE(x4,signature_13_0)

    # Clear memory
    sw      x0, 0(x4)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x2, x4,0
    li     x5, MASK_XLEN(2048)
    add    x2, x2, x5
    # Test Instruction 
    sb      x18, -2048(x2)
    # Check results:  mem[test_13_res+0] = 0x00000000
    lw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 4(x4)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x1, x4,4
    li     x5, MASK_XLEN(-1024)
    add    x1, x1, x5
    # Test Instruction 
    sb      x17, 1024(x1)
    # Check results:  mem[test_13_res+4] = 0x00000000
    lw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 8(x4)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x31, x4,8
    li     x5, MASK_XLEN(-512)
    add    x31, x31, x5
    # Test Instruction 
    sb      x16, 512(x31)
    # Check results:  mem[test_13_res+8] = 0x00000000
    lw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 12(x4)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x30, x4,12
    li     x5, MASK_XLEN(-256)
    add    x30, x30, x5
    # Test Instruction 
    sb      x15, 256(x30)
    # Check results:  mem[test_13_res+12] = 0x00000000
    lw x6, 12(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 16(x4)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x29, x4,16
    li     x5, MASK_XLEN(-128)
    add    x29, x29, x5
    # Test Instruction 
    sb      x14, 128(x29)
    # Check results:  mem[test_13_res+16] = 0x00000000
    lw x6, 16(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_14_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x28, x1,0
    li     x2, MASK_XLEN(-64)
    add    x28, x28, x2
    # Test Instruction 
    sb      x13, 64(x28)
    # Check results:  mem[test_14_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x27, x1,4
    li     x2, MASK_XLEN(-32)
    add    x27, x27, x2
    # Test Instruction 
    sb      x12, 32(x27)
    # Check results:  mem[test_14_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x1
    addi    x26, x1,8
    li     x2, MASK_XLEN(-16)
    add    x26, x26, x2
    # Test Instruction 
    sb      x11, 16(x26)
    # Check results:  mem[test_14_res+8] = 0x00000001
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000001)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x10, 0x2
    addi    x25, x1,12
    li     x2, MASK_XLEN(-8)
    add    x25, x25, x2
    # Test Instruction 
    sb      x10, 8(x25)
    # Check results:  mem[test_14_res+12] = 0x00000002
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000002)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x9, 0x4
    addi    x24, x1,16
    li     x2, MASK_XLEN(-4)
    add    x24, x24, x2
    # Test Instruction 
    sb      x9, 4(x24)
    # Check results:  mem[test_14_res+16] = 0x00000004
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000004)



    

    RVTEST_SIGBASE(x1,signature_15_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x8
    addi    x23, x1,0
    li     x2, MASK_XLEN(-2)
    add    x23, x23, x2
    # Test Instruction 
    sb      x8, 2(x23)
    # Check results:  mem[test_15_res+0] = 0x00000008
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000008)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x7, 0x10
    addi    x22, x1,4
    li     x2, MASK_XLEN(-1)
    add    x22, x22, x2
    # Test Instruction 
    sb      x7, 1(x22)
    # Check results:  mem[test_15_res+4] = 0x00000010
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000010)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x6, 0x20
    addi    x21, x1,8
    li     x2, MASK_XLEN(989)
    add    x21, x21, x2
    # Test Instruction 
    sb      x6, -989(x21)
    # Check results:  mem[test_15_res+8] = 0x00000020
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000020)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x5, 0x40
    addi    x20, x1,12
    li     x2, MASK_XLEN(-91)
    add    x20, x20, x2
    # Test Instruction 
    sb      x5, 91(x20)
    # Check results:  mem[test_15_res+12] = 0x00000040
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000040)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x4, 0x80
    addi    x19, x1,16
    li     x2, MASK_XLEN(-704)
    add    x19, x19, x2
    # Test Instruction 
    sb      x4, 704(x19)
    # Check results:  mem[test_15_res+16] = 0x00000080
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000080)



    

    RVTEST_SIGBASE(x4,signature_16_0)

    # Clear memory
    sw      x0, 0(x4)
    # Load values and compute offsets
    li      x3, 0x100
    addi    x18, x4,0
    li     x5, MASK_XLEN(1085)
    add    x18, x18, x5
    # Test Instruction 
    sb      x3, -1085(x18)
    # Check results:  mem[test_16_res+0] = 0x00000000
    lw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 4(x4)
    # Load values and compute offsets
    li      x2, 0x200
    addi    x17, x4,4
    li     x5, MASK_XLEN(-175)
    add    x17, x17, x5
    # Test Instruction 
    sb      x2, 175(x17)
    # Check results:  mem[test_16_res+4] = 0x00000000
    lw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 8(x4)
    # Load values and compute offsets
    li      x1, 0x400
    addi    x16, x4,8
    li     x5, MASK_XLEN(-591)
    add    x16, x16, x5
    # Test Instruction 
    sb      x1, 591(x16)
    # Check results:  mem[test_16_res+8] = 0x00000000
    lw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 12(x4)
    # Load values and compute offsets
    li      x31, 0x800
    addi    x15, x4,12
    li     x5, MASK_XLEN(53)
    add    x15, x15, x5
    # Test Instruction 
    sb      x31, -53(x15)
    # Check results:  mem[test_16_res+12] = 0x00000000
    lw x6, 12(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 16(x4)
    # Load values and compute offsets
    li      x30, 0x1000
    addi    x14, x4,16
    li     x5, MASK_XLEN(1861)
    add    x14, x14, x5
    # Test Instruction 
    sb      x30, -1861(x14)
    # Check results:  mem[test_16_res+16] = 0x00000000
    lw x6, 16(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_17_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x29, 0x2000
    addi    x13, x1,0
    li     x2, MASK_XLEN(319)
    add    x13, x13, x2
    # Test Instruction 
    sb      x29, -319(x13)
    # Check results:  mem[test_17_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x28, 0x4000
    addi    x12, x1,4
    li     x2, MASK_XLEN(-405)
    add    x12, x12, x2
    # Test Instruction 
    sb      x28, 405(x12)
    # Check results:  mem[test_17_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x27, 0x8000
    addi    x11, x1,8
    li     x2, MASK_XLEN(1)
    add    x11, x11, x2
    # Test Instruction 
    sb      x27, -1(x11)
    # Check results:  mem[test_17_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x26, 0x10000
    addi    x10, x1,12
    li     x2, MASK_XLEN(-2047)
    add    x10, x10, x2
    # Test Instruction 
    sb      x26, 2047(x10)
    # Check results:  mem[test_17_res+12] = 0x00000000
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x25, 0x20000
    addi    x9, x1,16
    li     x2, MASK_XLEN(1025)
    add    x9, x9, x2
    # Test Instruction 
    sb      x25, -1025(x9)
    # Check results:  mem[test_17_res+16] = 0x00000000
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_18_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x24, 0x40000
    addi    x8, x1,0
    li     x2, MASK_XLEN(513)
    add    x8, x8, x2
    # Test Instruction 
    sb      x24, -513(x8)
    # Check results:  mem[test_18_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x23, 0x80000
    addi    x7, x1,4
    li     x2, MASK_XLEN(257)
    add    x7, x7, x2
    # Test Instruction 
    sb      x23, -257(x7)
    # Check results:  mem[test_18_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0x100000
    addi    x6, x1,8
    li     x2, MASK_XLEN(129)
    add    x6, x6, x2
    # Test Instruction 
    sb      x22, -129(x6)
    # Check results:  mem[test_18_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x21, 0x200000
    addi    x5, x1,12
    li     x2, MASK_XLEN(65)
    add    x5, x5, x2
    # Test Instruction 
    sb      x21, -65(x5)
    # Check results:  mem[test_18_res+12] = 0x00000000
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x20, 0x400000
    addi    x4, x1,16
    li     x2, MASK_XLEN(33)
    add    x4, x4, x2
    # Test Instruction 
    sb      x20, -33(x4)
    # Check results:  mem[test_18_res+16] = 0x00000000
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x4,signature_19_0)

    # Clear memory
    sw      x0, 0(x4)
    # Load values and compute offsets
    li      x19, 0x800000
    addi    x3, x4,0
    li     x5, MASK_XLEN(17)
    add    x3, x3, x5
    # Test Instruction 
    sb      x19, -17(x3)
    # Check results:  mem[test_19_res+0] = 0x00000000
    lw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 4(x4)
    # Load values and compute offsets
    li      x18, 0x1000000
    addi    x2, x4,4
    li     x5, MASK_XLEN(9)
    add    x2, x2, x5
    # Test Instruction 
    sb      x18, -9(x2)
    # Check results:  mem[test_19_res+4] = 0x00000000
    lw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 8(x4)
    # Load values and compute offsets
    li      x17, 0x2000000
    addi    x1, x4,8
    li     x5, MASK_XLEN(5)
    add    x1, x1, x5
    # Test Instruction 
    sb      x17, -5(x1)
    # Check results:  mem[test_19_res+8] = 0x00000000
    lw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 12(x4)
    # Load values and compute offsets
    li      x16, 0x4000000
    addi    x31, x4,12
    li     x5, MASK_XLEN(3)
    add    x31, x31, x5
    # Test Instruction 
    sb      x16, -3(x31)
    # Check results:  mem[test_19_res+12] = 0x00000000
    lw x6, 12(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)

    # Clear memory
    sw      x0, 16(x4)
    # Load values and compute offsets
    li      x15, 0x8000000
    addi    x30, x4,16
    li     x5, MASK_XLEN(2)
    add    x30, x30, x5
    # Test Instruction 
    sb      x15, -2(x30)
    # Check results:  mem[test_19_res+16] = 0x00000000
    lw x6, 16(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_20_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x10000000
    addi    x29, x1,0
    li     x2, MASK_XLEN(0)
    add    x29, x29, x2
    # Test Instruction 
    sb      x14, 0(x29)
    # Check results:  mem[test_20_res+0] = 0x00000000
    lw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x13, 0x20000000
    addi    x28, x1,4
    li     x2, MASK_XLEN(2048)
    add    x28, x28, x2
    # Test Instruction 
    sb      x13, -2048(x28)
    # Check results:  mem[test_20_res+4] = 0x00000000
    lw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x40000000
    addi    x27, x1,8
    li     x2, MASK_XLEN(-1024)
    add    x27, x27, x2
    # Test Instruction 
    sb      x12, 1024(x27)
    # Check results:  mem[test_20_res+8] = 0x00000000
    lw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x11, 0x80000000
    addi    x26, x1,12
    li     x2, MASK_XLEN(-512)
    add    x26, x26, x2
    # Test Instruction 
    sb      x11, 512(x26)
    # Check results:  mem[test_20_res+12] = 0x00000000
    lw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x25, x1,16
    li     x2, MASK_XLEN(-256)
    add    x25, x25, x2
    # Test Instruction 
    sb      x10, 256(x25)
    # Check results:  mem[test_20_res+16] = 0x00000000
    lw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_21_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0xfffffffe
    addi    x24, x1,0
    li     x2, MASK_XLEN(-128)
    add    x24, x24, x2
    # Test Instruction 
    sb      x9, 128(x24)
    # Check results:  mem[test_21_res+0] = 0x000000fe
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000fe)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x8, 0xfffffffd
    addi    x23, x1,4
    li     x2, MASK_XLEN(-64)
    add    x23, x23, x2
    # Test Instruction 
    sb      x8, 64(x23)
    # Check results:  mem[test_21_res+4] = 0x000000fd
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000fd)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0xfffffffb
    addi    x22, x1,8
    li     x2, MASK_XLEN(-32)
    add    x22, x22, x2
    # Test Instruction 
    sb      x7, 32(x22)
    # Check results:  mem[test_21_res+8] = 0x000000fb
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000fb)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x6, 0xfffffff7
    addi    x21, x1,12
    li     x2, MASK_XLEN(-16)
    add    x21, x21, x2
    # Test Instruction 
    sb      x6, 16(x21)
    # Check results:  mem[test_21_res+12] = 0x000000f7
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000f7)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x5, 0xffffffef
    addi    x20, x1,16
    li     x2, MASK_XLEN(-8)
    add    x20, x20, x2
    # Test Instruction 
    sb      x5, 8(x20)
    # Check results:  mem[test_21_res+16] = 0x000000ef
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ef)



    

    RVTEST_SIGBASE(x5,signature_22_0)

    # Clear memory
    sw      x0, 0(x5)
    # Load values and compute offsets
    li      x4, 0xffffffdf
    addi    x19, x5,0
    li     x6, MASK_XLEN(-4)
    add    x19, x19, x6
    # Test Instruction 
    sb      x4, 4(x19)
    # Check results:  mem[test_22_res+0] = 0x000000df
    lw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000df)

    # Clear memory
    sw      x0, 4(x5)
    # Load values and compute offsets
    li      x3, 0xffffffbf
    addi    x18, x5,4
    li     x6, MASK_XLEN(-2)
    add    x18, x18, x6
    # Test Instruction 
    sb      x3, 2(x18)
    # Check results:  mem[test_22_res+4] = 0x000000bf
    lw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000bf)

    # Clear memory
    sw      x0, 8(x5)
    # Load values and compute offsets
    li      x2, 0xffffff7f
    addi    x17, x5,8
    li     x6, MASK_XLEN(-1)
    add    x17, x17, x6
    # Test Instruction 
    sb      x2, 1(x17)
    # Check results:  mem[test_22_res+8] = 0x0000007f
    lw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x0000007f)

    # Clear memory
    sw      x0, 12(x5)
    # Load values and compute offsets
    li      x1, 0xfffffeff
    addi    x16, x5,12
    li     x6, MASK_XLEN(989)
    add    x16, x16, x6
    # Test Instruction 
    sb      x1, -989(x16)
    # Check results:  mem[test_22_res+12] = 0x000000ff
    lw x7, 12(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000ff)

    # Clear memory
    sw      x0, 16(x5)
    # Load values and compute offsets
    li      x31, 0xfffffdff
    addi    x15, x5,16
    li     x6, MASK_XLEN(-91)
    add    x15, x15, x6
    # Test Instruction 
    sb      x31, 91(x15)
    # Check results:  mem[test_22_res+16] = 0x000000ff
    lw x7, 16(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_23_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x30, 0xfffffbff
    addi    x14, x1,0
    li     x2, MASK_XLEN(-704)
    add    x14, x14, x2
    # Test Instruction 
    sb      x30, 704(x14)
    # Check results:  mem[test_23_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x29, 0xfffff7ff
    addi    x13, x1,4
    li     x2, MASK_XLEN(1085)
    add    x13, x13, x2
    # Test Instruction 
    sb      x29, -1085(x13)
    # Check results:  mem[test_23_res+4] = 0x000000ff
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0xffffefff
    addi    x12, x1,8
    li     x2, MASK_XLEN(-175)
    add    x12, x12, x2
    # Test Instruction 
    sb      x28, 175(x12)
    # Check results:  mem[test_23_res+8] = 0x000000ff
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x27, 0xffffdfff
    addi    x11, x1,12
    li     x2, MASK_XLEN(-591)
    add    x11, x11, x2
    # Test Instruction 
    sb      x27, 591(x11)
    # Check results:  mem[test_23_res+12] = 0x000000ff
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x26, 0xffffbfff
    addi    x10, x1,16
    li     x2, MASK_XLEN(53)
    add    x10, x10, x2
    # Test Instruction 
    sb      x26, -53(x10)
    # Check results:  mem[test_23_res+16] = 0x000000ff
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_24_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x25, 0xffff7fff
    addi    x9, x1,0
    li     x2, MASK_XLEN(1861)
    add    x9, x9, x2
    # Test Instruction 
    sb      x25, -1861(x9)
    # Check results:  mem[test_24_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x24, 0xfffeffff
    addi    x8, x1,4
    li     x2, MASK_XLEN(319)
    add    x8, x8, x2
    # Test Instruction 
    sb      x24, -319(x8)
    # Check results:  mem[test_24_res+4] = 0x000000ff
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x23, 0xfffdffff
    addi    x7, x1,8
    li     x2, MASK_XLEN(-405)
    add    x7, x7, x2
    # Test Instruction 
    sb      x23, 405(x7)
    # Check results:  mem[test_24_res+8] = 0x000000ff
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x22, 0xfffbffff
    addi    x6, x1,12
    li     x2, MASK_XLEN(1)
    add    x6, x6, x2
    # Test Instruction 
    sb      x22, -1(x6)
    # Check results:  mem[test_24_res+12] = 0x000000ff
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x21, 0xfff7ffff
    addi    x5, x1,16
    li     x2, MASK_XLEN(-2047)
    add    x5, x5, x2
    # Test Instruction 
    sb      x21, 2047(x5)
    # Check results:  mem[test_24_res+16] = 0x000000ff
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)



    

    RVTEST_SIGBASE(x5,signature_25_0)

    # Clear memory
    sw      x0, 0(x5)
    # Load values and compute offsets
    li      x20, 0xffefffff
    addi    x4, x5,0
    li     x6, MASK_XLEN(1025)
    add    x4, x4, x6
    # Test Instruction 
    sb      x20, -1025(x4)
    # Check results:  mem[test_25_res+0] = 0x000000ff
    lw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000ff)

    # Clear memory
    sw      x0, 4(x5)
    # Load values and compute offsets
    li      x19, 0xffdfffff
    addi    x3, x5,4
    li     x6, MASK_XLEN(513)
    add    x3, x3, x6
    # Test Instruction 
    sb      x19, -513(x3)
    # Check results:  mem[test_25_res+4] = 0x000000ff
    lw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000ff)

    # Clear memory
    sw      x0, 8(x5)
    # Load values and compute offsets
    li      x18, 0xffbfffff
    addi    x2, x5,8
    li     x6, MASK_XLEN(257)
    add    x2, x2, x6
    # Test Instruction 
    sb      x18, -257(x2)
    # Check results:  mem[test_25_res+8] = 0x000000ff
    lw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000ff)

    # Clear memory
    sw      x0, 12(x5)
    # Load values and compute offsets
    li      x17, 0xff7fffff
    addi    x1, x5,12
    li     x6, MASK_XLEN(129)
    add    x1, x1, x6
    # Test Instruction 
    sb      x17, -129(x1)
    # Check results:  mem[test_25_res+12] = 0x000000ff
    lw x7, 12(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000ff)

    # Clear memory
    sw      x0, 16(x5)
    # Load values and compute offsets
    li      x16, 0xfeffffff
    addi    x31, x5,16
    li     x6, MASK_XLEN(65)
    add    x31, x31, x6
    # Test Instruction 
    sb      x16, -65(x31)
    # Check results:  mem[test_25_res+16] = 0x000000ff
    lw x7, 16(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_26_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0xfdffffff
    addi    x30, x1,0
    li     x7, MASK_XLEN(33)
    add    x30, x30, x7
    # Test Instruction 
    sb      x15, -33(x30)
    # Check results:  mem[test_26_res+0] = 0x000000ff
    lw x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x14, 0xfbffffff
    addi    x29, x1,4
    li     x7, MASK_XLEN(17)
    add    x29, x29, x7
    # Test Instruction 
    sb      x14, -17(x29)
    # Check results:  mem[test_26_res+4] = 0x000000ff
    lw x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0xf7ffffff
    addi    x28, x1,8
    li     x7, MASK_XLEN(9)
    add    x28, x28, x7
    # Test Instruction 
    sb      x13, -9(x28)
    # Check results:  mem[test_26_res+8] = 0x000000ff
    lw x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x000000ff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x12, 0xefffffff
    addi    x27, x1,12
    li     x7, MASK_XLEN(5)
    add    x27, x27, x7
    # Test Instruction 
    sb      x12, -5(x27)
    # Check results:  mem[test_26_res+12] = 0x000000ff
    lw x8, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x000000ff)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x11, 0xdfffffff
    addi    x26, x1,16
    li     x7, MASK_XLEN(3)
    add    x26, x26, x7
    # Test Instruction 
    sb      x11, -3(x26)
    # Check results:  mem[test_26_res+16] = 0x000000ff
    lw x8, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_27_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0xbfffffff
    addi    x25, x1,0
    li     x2, MASK_XLEN(2)
    add    x25, x25, x2
    # Test Instruction 
    sb      x10, -2(x25)
    # Check results:  mem[test_27_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x9, 0x7fffffff
    addi    x24, x1,4
    li     x2, MASK_XLEN(0)
    add    x24, x24, x2
    # Test Instruction 
    sb      x9, 0(x24)
    # Check results:  mem[test_27_res+4] = 0x000000ff
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0xffffffff
    addi    x23, x1,8
    li     x2, MASK_XLEN(2048)
    add    x23, x23, x2
    # Test Instruction 
    sb      x8, -2048(x23)
    # Check results:  mem[test_27_res+8] = 0x000000ff
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x7, 0xadea5195
    addi    x22, x1,12
    li     x2, MASK_XLEN(-1024)
    add    x22, x22, x2
    # Test Instruction 
    sb      x7, 1024(x22)
    # Check results:  mem[test_27_res+12] = 0x00000095
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000095)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x6, 0xd2ffbec1
    addi    x21, x1,16
    li     x2, MASK_XLEN(-512)
    add    x21, x21, x2
    # Test Instruction 
    sb      x6, 512(x21)
    # Check results:  mem[test_27_res+16] = 0x000000c1
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000c1)



    

    RVTEST_SIGBASE(x6,signature_28_0)

    # Clear memory
    sw      x0, 0(x6)
    # Load values and compute offsets
    li      x5, 0xa8e1a8bb
    addi    x20, x6,0
    li     x7, MASK_XLEN(-256)
    add    x20, x20, x7
    # Test Instruction 
    sb      x5, 256(x20)
    # Check results:  mem[test_28_res+0] = 0x000000bb
    lw x8, 0(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x000000bb)

    # Clear memory
    sw      x0, 4(x6)
    # Load values and compute offsets
    li      x4, 0x48c99fcb
    addi    x19, x6,4
    li     x7, MASK_XLEN(-128)
    add    x19, x19, x7
    # Test Instruction 
    sb      x4, 128(x19)
    # Check results:  mem[test_28_res+4] = 0x000000cb
    lw x8, 4(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x000000cb)

    # Clear memory
    sw      x0, 8(x6)
    # Load values and compute offsets
    li      x3, 0x461d524f
    addi    x18, x6,8
    li     x7, MASK_XLEN(-64)
    add    x18, x18, x7
    # Test Instruction 
    sb      x3, 64(x18)
    # Check results:  mem[test_28_res+8] = 0x0000004f
    lw x8, 8(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x0000004f)

    # Clear memory
    sw      x0, 12(x6)
    # Load values and compute offsets
    li      x2, 0x528a10af
    addi    x17, x6,12
    li     x7, MASK_XLEN(-32)
    add    x17, x17, x7
    # Test Instruction 
    sb      x2, 32(x17)
    # Check results:  mem[test_28_res+12] = 0x000000af
    lw x8, 12(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x000000af)

    # Clear memory
    sw      x0, 16(x6)
    # Load values and compute offsets
    li      x1, 0xe19bfbc3
    addi    x16, x6,16
    li     x7, MASK_XLEN(-16)
    add    x16, x16, x7
    # Test Instruction 
    sb      x1, 16(x16)
    # Check results:  mem[test_28_res+16] = 0x000000c3
    lw x8, 16(x6)
    RVMODEL_IO_ASSERT_GPR_EQ(x7, x8, 0x000000c3)



    

    RVTEST_SIGBASE(x1,signature_29_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x31, 0x707af2c0
    addi    x15, x1,0
    li     x2, MASK_XLEN(-8)
    add    x15, x15, x2
    # Test Instruction 
    sb      x31, 8(x15)
    # Check results:  mem[test_29_res+0] = 0x000000c0
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000c0)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x30, 0xa47d105b
    addi    x14, x1,4
    li     x2, MASK_XLEN(-4)
    add    x14, x14, x2
    # Test Instruction 
    sb      x30, 4(x14)
    # Check results:  mem[test_29_res+4] = 0x0000005b
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x0000005b)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x29, 0x121bcc23
    addi    x13, x1,8
    li     x2, MASK_XLEN(-2)
    add    x13, x13, x2
    # Test Instruction 
    sb      x29, 2(x13)
    # Check results:  mem[test_29_res+8] = 0x00000023
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000023)

    # Clear memory
    sw      x0, 12(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x12, x1,12
    li     x2, MASK_XLEN(-1)
    add    x12, x12, x2
    # Test Instruction 
    sb      x28, 1(x12)
    # Check results:  mem[test_29_res+12] = 0x00000000
    lw x3, 12(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 16(x1)
    # Load values and compute offsets
    li      x0, 0x0
    addi    x11, x1,16
    li     x2, MASK_XLEN(989)
    add    x11, x11, x2
    # Test Instruction 
    sb      x0, -989(x11)
    # Check results:  mem[test_29_res+16] = 0
    lw x3, 16(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0)



    

    RVTEST_SIGBASE(x1,signature_30_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x10, x1,0
    li     x2, MASK_XLEN(-91)
    add    x10, x10, x2
    # Test Instruction 
    sb      x26, 91(x10)
    # Check results:  mem[test_30_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

	
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

