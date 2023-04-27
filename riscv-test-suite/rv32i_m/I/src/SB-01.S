// RISC-V Architectural Validation Test SB-01
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

    RVTEST_SIGBASE(x1,signature_1_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x28, 0xf4bcf4a7
    addi    x20, x1,0
    li     x2, MASK_XLEN(451)
    add    x20, x20, x2
    # Test Instruction 
    sb      x28, -451(x20)
    # Check results:  mem[test_1_res+0] = 0x000000a7
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000a7)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x20, 0xb26566a0
    addi    x31, x1,4
    li     x2, MASK_XLEN(923)
    add    x31, x31, x2
    # Test Instruction 
    sb      x20, -923(x31)
    # Check results:  mem[test_1_res+4] = 0x000000a0
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000a0)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x0, 0xc3e260bd
    addi    x11, x1,8
    li     x2, MASK_XLEN(710)
    add    x11, x11, x2
    # Test Instruction 
    sb      x0, -710(x11)
    # Check results:  mem[test_1_res+8] = 0
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0)



    

    RVTEST_SIGBASE(x1,signature_2_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x31, 0xa783d03f
    addi    x4, x1,0
    li     x3, MASK_XLEN(1313)
    add    x4, x4, x3
    # Test Instruction 
    sb      x31, -1313(x4)
    # Check results:  mem[test_2_res+0] = 0x0000003f
    lw x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x6, 0x0000003f)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x5, 0x807fe203
    addi    x30, x1,4
    li     x3, MASK_XLEN(-703)
    add    x30, x30, x3
    # Test Instruction 
    sb      x5, 703(x30)
    # Check results:  mem[test_2_res+4] = 0x00000003
    lw x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x6, 0x00000003)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x413f2c62
    addi    x2, x1,8
    li     x3, MASK_XLEN(12)
    add    x2, x2, x3
    # Test Instruction 
    sb      x13, -12(x2)
    # Check results:  mem[test_2_res+8] = 0x00000062
    lw x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x6, 0x00000062)



    

    RVTEST_SIGBASE(x1,signature_3_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x701512f5
    addi    x5, x1,0
    li     x3, MASK_XLEN(-1170)
    add    x5, x5, x3
    # Test Instruction 
    sb      x11, 1170(x5)
    # Check results:  mem[test_3_res+0] = 0x000000f5
    lw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x000000f5)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x2, 0x91dd5ad6
    addi    x26, x1,4
    li     x3, MASK_XLEN(1618)
    add    x26, x26, x3
    # Test Instruction 
    sb      x2, -1618(x26)
    # Check results:  mem[test_3_res+4] = 0x000000d6
    lw x4, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x000000d6)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x18, 0x589f2ccd
    addi    x19, x1,8
    li     x3, MASK_XLEN(1835)
    add    x19, x19, x3
    # Test Instruction 
    sb      x18, -1835(x19)
    # Check results:  mem[test_3_res+8] = 0x000000cd
    lw x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x000000cd)



    

    RVTEST_SIGBASE(x2,signature_4_0)

    # Clear memory
    sw      x0, 0(x2)
    # Load values and compute offsets
    li      x9, 0x4d236af8
    addi    x8, x2,0
    li     x3, MASK_XLEN(552)
    add    x8, x8, x3
    # Test Instruction 
    sb      x9, -552(x8)
    # Check results:  mem[test_4_res+0] = 0x000000f8
    lw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x000000f8)

    # Clear memory
    sw      x0, 4(x2)
    # Load values and compute offsets
    li      x17, 0x242b9878
    addi    x1, x2,4
    li     x3, MASK_XLEN(-1927)
    add    x1, x1, x3
    # Test Instruction 
    sb      x17, 1927(x1)
    # Check results:  mem[test_4_res+4] = 0x00000078
    lw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000078)

    # Clear memory
    sw      x0, 8(x2)
    # Load values and compute offsets
    li      x31, 0x353a8593
    addi    x24, x2,8
    li     x3, MASK_XLEN(-1569)
    add    x24, x24, x3
    # Test Instruction 
    sb      x31, 1569(x24)
    # Check results:  mem[test_4_res+8] = 0x00000093
    lw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000093)



    

    RVTEST_SIGBASE(x1,signature_5_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x0, 0xc357b925
    addi    x22, x1,0
    li     x2, MASK_XLEN(942)
    add    x22, x22, x2
    # Test Instruction 
    sb      x0, -942(x22)
    # Check results:  mem[test_5_res+0] = 0
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x0, 0xdc3713a2
    addi    x31, x1,4
    li     x2, MASK_XLEN(628)
    add    x31, x31, x2
    # Test Instruction 
    sb      x0, -628(x31)
    # Check results:  mem[test_5_res+4] = 0
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x31, 0x2ed729e0
    addi    x18, x1,8
    li     x2, MASK_XLEN(-1167)
    add    x18, x18, x2
    # Test Instruction 
    sb      x31, 1167(x18)
    # Check results:  mem[test_5_res+8] = 0x000000e0
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000e0)



    

    RVTEST_SIGBASE(x1,signature_6_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x825648e4
    addi    x7, x1,0
    li     x2, MASK_XLEN(-1670)
    add    x7, x7, x2
    # Test Instruction 
    sb      x11, 1670(x7)
    # Check results:  mem[test_6_res+0] = 0x000000e4
    lw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0x000000e4)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x9, 0xf4cc30bc
    addi    x23, x1,4
    li     x2, MASK_XLEN(686)
    add    x23, x23, x2
    # Test Instruction 
    sb      x9, -686(x23)
    # Check results:  mem[test_6_res+4] = 0x000000bc
    lw x4, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0x000000bc)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0xfe9b8abf
    addi    x3, x1,8
    li     x2, MASK_XLEN(-468)
    add    x3, x3, x2
    # Test Instruction 
    sb      x7, 468(x3)
    # Check results:  mem[test_6_res+8] = 0x000000bf
    lw x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0x000000bf)



    

    RVTEST_SIGBASE(x1,signature_7_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x7, 0x8cc7e790
    addi    x14, x1,0
    li     x2, MASK_XLEN(-1736)
    add    x14, x14, x2
    # Test Instruction 
    sb      x7, 1736(x14)
    # Check results:  mem[test_7_res+0] = 0x00000090
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000090)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x13, 0xcaa4b80e
    addi    x4, x1,4
    li     x2, MASK_XLEN(-1330)
    add    x4, x4, x2
    # Test Instruction 
    sb      x13, 1330(x4)
    # Check results:  mem[test_7_res+4] = 0x0000000e
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x0000000e)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0xfe96a948
    addi    x25, x1,8
    li     x2, MASK_XLEN(-1867)
    add    x25, x25, x2
    # Test Instruction 
    sb      x12, 1867(x25)
    # Check results:  mem[test_7_res+8] = 0x00000048
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000048)



    

    RVTEST_SIGBASE(x1,signature_8_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x17, 0x8fe89d23
    addi    x4, x1,0
    li     x2, MASK_XLEN(-489)
    add    x4, x4, x2
    # Test Instruction 
    sb      x17, 489(x4)
    # Check results:  mem[test_8_res+0] = 0x00000023
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000023)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x31, 0xe10f3f75
    addi    x15, x1,4
    li     x2, MASK_XLEN(-483)
    add    x15, x15, x2
    # Test Instruction 
    sb      x31, 483(x15)
    # Check results:  mem[test_8_res+4] = 0x00000075
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000075)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x18, 0x103e6515
    addi    x21, x1,8
    li     x2, MASK_XLEN(655)
    add    x21, x21, x2
    # Test Instruction 
    sb      x18, -655(x21)
    # Check results:  mem[test_8_res+8] = 0x00000015
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000015)



    

    RVTEST_SIGBASE(x1,signature_9_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x29, 0xbd562c12
    addi    x5, x1,0
    li     x3, MASK_XLEN(338)
    add    x5, x5, x3
    # Test Instruction 
    sb      x29, -338(x5)
    # Check results:  mem[test_9_res+0] = 0x00000012
    lw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000012)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x17, 0x823f2c5
    addi    x30, x1,4
    li     x3, MASK_XLEN(-1749)
    add    x30, x30, x3
    # Test Instruction 
    sb      x17, 1749(x30)
    # Check results:  mem[test_9_res+4] = 0x000000c5
    lw x4, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x000000c5)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0x92d1fb3e
    addi    x2, x1,8
    li     x3, MASK_XLEN(31)
    add    x2, x2, x3
    # Test Instruction 
    sb      x22, -31(x2)
    # Check results:  mem[test_9_res+8] = 0x0000003e
    lw x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x0000003e)



    

    RVTEST_SIGBASE(x1,signature_10_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x3, 0x6a6a04cf
    addi    x4, x1,0
    li     x2, MASK_XLEN(1971)
    add    x4, x4, x2
    # Test Instruction 
    sb      x3, -1971(x4)
    # Check results:  mem[test_10_res+0] = 0x000000cf
    lw x5, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x5, 0x000000cf)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x15, 0xff3544a9
    addi    x20, x1,4
    li     x2, MASK_XLEN(-523)
    add    x20, x20, x2
    # Test Instruction 
    sb      x15, 523(x20)
    # Check results:  mem[test_10_res+4] = 0x000000a9
    lw x5, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x5, 0x000000a9)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0xe855a90d
    addi    x14, x1,8
    li     x2, MASK_XLEN(-822)
    add    x14, x14, x2
    # Test Instruction 
    sb      x28, 822(x14)
    # Check results:  mem[test_10_res+8] = 0x0000000d
    lw x5, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x5, 0x0000000d)



    

    RVTEST_SIGBASE(x1,signature_11_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x7fffffff
    addi    x7, x1,0
    li     x2, MASK_XLEN(1)
    add    x7, x7, x2
    # Test Instruction 
    sb      x14, -1(x7)
    # Check results:  mem[test_11_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x9, 0x80000000
    addi    x7, x1,4
    li     x2, MASK_XLEN(1)
    add    x7, x7, x2
    # Test Instruction 
    sb      x9, -1(x7)
    # Check results:  mem[test_11_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0xffffffff
    addi    x18, x1,8
    li     x2, MASK_XLEN(-1)
    add    x18, x18, x2
    # Test Instruction 
    sb      x10, 1(x18)
    # Check results:  mem[test_11_res+8] = 0x000000ff
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_12_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x6, 0xffffffff
    addi    x15, x1,0
    li     x3, MASK_XLEN(0)
    add    x15, x15, x3
    # Test Instruction 
    sb      x6, 0(x15)
    # Check results:  mem[test_12_res+0] = 0x000000ff
    lw x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x0, 0xffffffff
    addi    x23, x1,4
    li     x3, MASK_XLEN(1)
    add    x23, x23, x3
    # Test Instruction 
    sb      x0, -1(x23)
    # Check results:  mem[test_12_res+4] = 0
    lw x4, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x2, x1,8
    li     x3, MASK_XLEN(1)
    add    x2, x2, x3
    # Test Instruction 
    sb      x19, -1(x2)
    # Check results:  mem[test_12_res+8] = 0x00000000
    lw x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)



    

    RVTEST_SIGBASE(x2,signature_13_0)

    # Clear memory
    sw      x0, 0(x2)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x29, x2,0
    li     x3, MASK_XLEN(0)
    add    x29, x29, x3
    # Test Instruction 
    sb      x19, 0(x29)
    # Check results:  mem[test_13_res+0] = 0x00000000
    lw x4, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x00000000)

    # Clear memory
    sw      x0, 4(x2)
    # Load values and compute offsets
    li      x30, 0xffffffff
    addi    x1, x2,4
    li     x3, MASK_XLEN(1)
    add    x1, x1, x3
    # Test Instruction 
    sb      x30, -1(x1)
    # Check results:  mem[test_13_res+4] = 0x000000ff
    lw x4, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x000000ff)

    # Clear memory
    sw      x0, 8(x2)
    # Load values and compute offsets
    li      x21, 0x7fffffff
    addi    x28, x2,8
    li     x3, MASK_XLEN(1)
    add    x28, x28, x3
    # Test Instruction 
    sb      x21, -1(x28)
    # Check results:  mem[test_13_res+8] = 0x000000ff
    lw x4, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x4, 0x000000ff)



    

    RVTEST_SIGBASE(x3,signature_14_0)

    # Clear memory
    sw      x0, 0(x3)
    # Load values and compute offsets
    li      x16, 0x80000000
    addi    x24, x3,0
    li     x4, MASK_XLEN(1)
    add    x24, x24, x4
    # Test Instruction 
    sb      x16, -1(x24)
    # Check results:  mem[test_14_res+0] = 0x00000000
    lw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 4(x3)
    # Load values and compute offsets
    li      x2, 0xfffffffe
    addi    x1, x3,4
    li     x4, MASK_XLEN(-1)
    add    x1, x1, x4
    # Test Instruction 
    sb      x2, 1(x1)
    # Check results:  mem[test_14_res+4] = 0x000000fe
    lw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x000000fe)

    # Clear memory
    sw      x0, 8(x3)
    # Load values and compute offsets
    li      x1, 0x7fffffff
    addi    x2, x3,8
    li     x4, MASK_XLEN(-2)
    add    x2, x2, x4
    # Test Instruction 
    sb      x1, 2(x2)
    # Check results:  mem[test_14_res+8] = 0x000000ff
    lw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_15_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x2, 0xbfffffff
    addi    x3, x1,0
    li     x6, MASK_XLEN(-4)
    add    x3, x3, x6
    # Test Instruction 
    sb      x2, 4(x3)
    # Check results:  mem[test_15_res+0] = 0x000000ff
    lw x7, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x3, 0xdfffffff
    addi    x4, x1,4
    li     x6, MASK_XLEN(-8)
    add    x4, x4, x6
    # Test Instruction 
    sb      x3, 8(x4)
    # Check results:  mem[test_15_res+4] = 0x000000ff
    lw x7, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x4, 0xefffffff
    addi    x5, x1,8
    li     x6, MASK_XLEN(-16)
    add    x5, x5, x6
    # Test Instruction 
    sb      x4, 16(x5)
    # Check results:  mem[test_15_res+8] = 0x000000ff
    lw x7, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_16_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x5, 0xf7ffffff
    addi    x6, x1,0
    li     x2, MASK_XLEN(-32)
    add    x6, x6, x2
    # Test Instruction 
    sb      x5, 32(x6)
    # Check results:  mem[test_16_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x6, 0xfbffffff
    addi    x7, x1,4
    li     x2, MASK_XLEN(-64)
    add    x7, x7, x2
    # Test Instruction 
    sb      x6, 64(x7)
    # Check results:  mem[test_16_res+4] = 0x000000ff
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0xfdffffff
    addi    x8, x1,8
    li     x2, MASK_XLEN(-128)
    add    x8, x8, x2
    # Test Instruction 
    sb      x7, 128(x8)
    # Check results:  mem[test_16_res+8] = 0x000000ff
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_17_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0xfeffffff
    addi    x9, x1,0
    li     x2, MASK_XLEN(-256)
    add    x9, x9, x2
    # Test Instruction 
    sb      x8, 256(x9)
    # Check results:  mem[test_17_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x9, 0xff7fffff
    addi    x10, x1,4
    li     x2, MASK_XLEN(-512)
    add    x10, x10, x2
    # Test Instruction 
    sb      x9, 512(x10)
    # Check results:  mem[test_17_res+4] = 0x000000ff
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0xffbfffff
    addi    x11, x1,8
    li     x2, MASK_XLEN(-1024)
    add    x11, x11, x2
    # Test Instruction 
    sb      x10, 1024(x11)
    # Check results:  mem[test_17_res+8] = 0x000000ff
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_18_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0xffdfffff
    addi    x12, x1,0
    li     x2, MASK_XLEN(2048)
    add    x12, x12, x2
    # Test Instruction 
    sb      x11, -2048(x12)
    # Check results:  mem[test_18_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x12, 0xffefffff
    addi    x13, x1,4
    li     x2, MASK_XLEN(2)
    add    x13, x13, x2
    # Test Instruction 
    sb      x12, -2(x13)
    # Check results:  mem[test_18_res+4] = 0x000000ff
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0xfff7ffff
    addi    x14, x1,8
    li     x2, MASK_XLEN(3)
    add    x14, x14, x2
    # Test Instruction 
    sb      x13, -3(x14)
    # Check results:  mem[test_18_res+8] = 0x000000ff
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_19_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0xfffbffff
    addi    x15, x1,0
    li     x2, MASK_XLEN(5)
    add    x15, x15, x2
    # Test Instruction 
    sb      x14, -5(x15)
    # Check results:  mem[test_19_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x15, 0xfffdffff
    addi    x16, x1,4
    li     x2, MASK_XLEN(9)
    add    x16, x16, x2
    # Test Instruction 
    sb      x15, -9(x16)
    # Check results:  mem[test_19_res+4] = 0x000000ff
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x16, 0xfffeffff
    addi    x17, x1,8
    li     x2, MASK_XLEN(17)
    add    x17, x17, x2
    # Test Instruction 
    sb      x16, -17(x17)
    # Check results:  mem[test_19_res+8] = 0x000000ff
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_20_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x17, 0xffff7fff
    addi    x18, x1,0
    li     x2, MASK_XLEN(33)
    add    x18, x18, x2
    # Test Instruction 
    sb      x17, -33(x18)
    # Check results:  mem[test_20_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x18, 0xffffbfff
    addi    x19, x1,4
    li     x2, MASK_XLEN(65)
    add    x19, x19, x2
    # Test Instruction 
    sb      x18, -65(x19)
    # Check results:  mem[test_20_res+4] = 0x000000ff
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x19, 0xffffdfff
    addi    x20, x1,8
    li     x2, MASK_XLEN(129)
    add    x20, x20, x2
    # Test Instruction 
    sb      x19, -129(x20)
    # Check results:  mem[test_20_res+8] = 0x000000ff
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_21_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x20, 0xffffefff
    addi    x21, x1,0
    li     x2, MASK_XLEN(257)
    add    x21, x21, x2
    # Test Instruction 
    sb      x20, -257(x21)
    # Check results:  mem[test_21_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x21, 0xfffff7ff
    addi    x22, x1,4
    li     x2, MASK_XLEN(513)
    add    x22, x22, x2
    # Test Instruction 
    sb      x21, -513(x22)
    # Check results:  mem[test_21_res+4] = 0x000000ff
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0xfffffbff
    addi    x23, x1,8
    li     x2, MASK_XLEN(1025)
    add    x23, x23, x2
    # Test Instruction 
    sb      x22, -1025(x23)
    # Check results:  mem[test_21_res+8] = 0x000000ff
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)



    

    RVTEST_SIGBASE(x1,signature_22_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x23, 0xfffffdff
    addi    x24, x1,0
    li     x2, MASK_XLEN(-2047)
    add    x24, x24, x2
    # Test Instruction 
    sb      x23, 2047(x24)
    # Check results:  mem[test_22_res+0] = 0x000000ff
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x24, 0xfffffeff
    addi    x25, x1,4
    li     x2, MASK_XLEN(2)
    add    x25, x25, x2
    # Test Instruction 
    sb      x24, -2(x25)
    # Check results:  mem[test_22_res+4] = 0x000000ff
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ff)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x25, 0xffffff7f
    addi    x26, x1,8
    li     x2, MASK_XLEN(3)
    add    x26, x26, x2
    # Test Instruction 
    sb      x25, -3(x26)
    # Check results:  mem[test_22_res+8] = 0x0000007f
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x0000007f)



    

    RVTEST_SIGBASE(x1,signature_23_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x26, 0xffffffbf
    addi    x27, x1,0
    li     x2, MASK_XLEN(5)
    add    x27, x27, x2
    # Test Instruction 
    sb      x26, -5(x27)
    # Check results:  mem[test_23_res+0] = 0x000000bf
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000bf)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x27, 0xffffffdf
    addi    x28, x1,4
    li     x2, MASK_XLEN(9)
    add    x28, x28, x2
    # Test Instruction 
    sb      x27, -9(x28)
    # Check results:  mem[test_23_res+4] = 0x000000df
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000df)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0xffffffef
    addi    x29, x1,8
    li     x2, MASK_XLEN(17)
    add    x29, x29, x2
    # Test Instruction 
    sb      x28, -17(x29)
    # Check results:  mem[test_23_res+8] = 0x000000ef
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x000000ef)



    

    RVTEST_SIGBASE(x3,signature_24_0)

    # Clear memory
    sw      x0, 0(x3)
    # Load values and compute offsets
    li      x29, 0xfffffff7
    addi    x30, x3,0
    li     x4, MASK_XLEN(33)
    add    x30, x30, x4
    # Test Instruction 
    sb      x29, -33(x30)
    # Check results:  mem[test_24_res+0] = 0x000000f7
    lw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x000000f7)

    # Clear memory
    sw      x0, 4(x3)
    # Load values and compute offsets
    li      x30, 0xfffffffb
    addi    x31, x3,4
    li     x4, MASK_XLEN(65)
    add    x31, x31, x4
    # Test Instruction 
    sb      x30, -65(x31)
    # Check results:  mem[test_24_res+4] = 0x000000fb
    lw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x000000fb)

    # Clear memory
    sw      x0, 8(x3)
    # Load values and compute offsets
    li      x2, 0xfffffffd
    addi    x1, x3,8
    li     x4, MASK_XLEN(129)
    add    x1, x1, x4
    # Test Instruction 
    sb      x2, -129(x1)
    # Check results:  mem[test_24_res+8] = 0x000000fd
    lw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x000000fd)



    

    RVTEST_SIGBASE(x5,signature_25_0)

    # Clear memory
    sw      x0, 0(x5)
    # Load values and compute offsets
    li      x1, 0xfffffffe
    addi    x2, x5,0
    li     x6, MASK_XLEN(257)
    add    x2, x2, x6
    # Test Instruction 
    sb      x1, -257(x2)
    # Check results:  mem[test_25_res+0] = 0x000000fe
    lw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x000000fe)

    # Clear memory
    sw      x0, 4(x5)
    # Load values and compute offsets
    li      x2, 0x80000000
    addi    x3, x5,4
    li     x6, MASK_XLEN(513)
    add    x3, x3, x6
    # Test Instruction 
    sb      x2, -513(x3)
    # Check results:  mem[test_25_res+4] = 0x00000000
    lw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 8(x5)
    # Load values and compute offsets
    li      x3, 0x40000000
    addi    x4, x5,8
    li     x6, MASK_XLEN(1025)
    add    x4, x4, x6
    # Test Instruction 
    sb      x3, -1025(x4)
    # Check results:  mem[test_25_res+8] = 0x00000000
    lw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_26_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x4, 0x20000000
    addi    x5, x1,0
    li     x2, MASK_XLEN(-2047)
    add    x5, x5, x2
    # Test Instruction 
    sb      x4, 2047(x5)
    # Check results:  mem[test_26_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x5, 0x10000000
    addi    x6, x1,4
    li     x2, MASK_XLEN(2)
    add    x6, x6, x2
    # Test Instruction 
    sb      x5, -2(x6)
    # Check results:  mem[test_26_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x6, 0x8000000
    addi    x7, x1,8
    li     x2, MASK_XLEN(3)
    add    x7, x7, x2
    # Test Instruction 
    sb      x6, -3(x7)
    # Check results:  mem[test_26_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_27_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x7, 0x4000000
    addi    x8, x1,0
    li     x2, MASK_XLEN(5)
    add    x8, x8, x2
    # Test Instruction 
    sb      x7, -5(x8)
    # Check results:  mem[test_27_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x8, 0x2000000
    addi    x9, x1,4
    li     x2, MASK_XLEN(9)
    add    x9, x9, x2
    # Test Instruction 
    sb      x8, -9(x9)
    # Check results:  mem[test_27_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x9, 0x1000000
    addi    x10, x1,8
    li     x2, MASK_XLEN(17)
    add    x10, x10, x2
    # Test Instruction 
    sb      x9, -17(x10)
    # Check results:  mem[test_27_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_28_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x10, 0x800000
    addi    x11, x1,0
    li     x2, MASK_XLEN(33)
    add    x11, x11, x2
    # Test Instruction 
    sb      x10, -33(x11)
    # Check results:  mem[test_28_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x11, 0x400000
    addi    x12, x1,4
    li     x2, MASK_XLEN(65)
    add    x12, x12, x2
    # Test Instruction 
    sb      x11, -65(x12)
    # Check results:  mem[test_28_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x12, 0x200000
    addi    x13, x1,8
    li     x2, MASK_XLEN(129)
    add    x13, x13, x2
    # Test Instruction 
    sb      x12, -129(x13)
    # Check results:  mem[test_28_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_29_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x13, 0x100000
    addi    x14, x1,0
    li     x2, MASK_XLEN(257)
    add    x14, x14, x2
    # Test Instruction 
    sb      x13, -257(x14)
    # Check results:  mem[test_29_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x14, 0x80000
    addi    x15, x1,4
    li     x2, MASK_XLEN(513)
    add    x15, x15, x2
    # Test Instruction 
    sb      x14, -513(x15)
    # Check results:  mem[test_29_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x15, 0x40000
    addi    x16, x1,8
    li     x2, MASK_XLEN(1025)
    add    x16, x16, x2
    # Test Instruction 
    sb      x15, -1025(x16)
    # Check results:  mem[test_29_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_30_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x16, 0x20000
    addi    x17, x1,0
    li     x2, MASK_XLEN(-2047)
    add    x17, x17, x2
    # Test Instruction 
    sb      x16, 2047(x17)
    # Check results:  mem[test_30_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x17, 0x10000
    addi    x18, x1,4
    li     x2, MASK_XLEN(2)
    add    x18, x18, x2
    # Test Instruction 
    sb      x17, -2(x18)
    # Check results:  mem[test_30_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x18, 0x8000
    addi    x19, x1,8
    li     x2, MASK_XLEN(3)
    add    x19, x19, x2
    # Test Instruction 
    sb      x18, -3(x19)
    # Check results:  mem[test_30_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_31_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x19, 0x4000
    addi    x20, x1,0
    li     x2, MASK_XLEN(5)
    add    x20, x20, x2
    # Test Instruction 
    sb      x19, -5(x20)
    # Check results:  mem[test_31_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x20, 0x2000
    addi    x21, x1,4
    li     x2, MASK_XLEN(9)
    add    x21, x21, x2
    # Test Instruction 
    sb      x20, -9(x21)
    # Check results:  mem[test_31_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x21, 0x1000
    addi    x22, x1,8
    li     x2, MASK_XLEN(17)
    add    x22, x22, x2
    # Test Instruction 
    sb      x21, -17(x22)
    # Check results:  mem[test_31_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_32_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x22, 0x800
    addi    x23, x1,0
    li     x2, MASK_XLEN(33)
    add    x23, x23, x2
    # Test Instruction 
    sb      x22, -33(x23)
    # Check results:  mem[test_32_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x23, 0x400
    addi    x24, x1,4
    li     x2, MASK_XLEN(65)
    add    x24, x24, x2
    # Test Instruction 
    sb      x23, -65(x24)
    # Check results:  mem[test_32_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x24, 0x200
    addi    x25, x1,8
    li     x2, MASK_XLEN(129)
    add    x25, x25, x2
    # Test Instruction 
    sb      x24, -129(x25)
    # Check results:  mem[test_32_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_33_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x25, 0x100
    addi    x26, x1,0
    li     x2, MASK_XLEN(257)
    add    x26, x26, x2
    # Test Instruction 
    sb      x25, -257(x26)
    # Check results:  mem[test_33_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x26, 0x80
    addi    x27, x1,4
    li     x2, MASK_XLEN(513)
    add    x27, x27, x2
    # Test Instruction 
    sb      x26, -513(x27)
    # Check results:  mem[test_33_res+4] = 0x00000080
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000080)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x27, 0x40
    addi    x28, x1,8
    li     x2, MASK_XLEN(1025)
    add    x28, x28, x2
    # Test Instruction 
    sb      x27, -1025(x28)
    # Check results:  mem[test_33_res+8] = 0x00000040
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000040)



    

    RVTEST_SIGBASE(x1,signature_34_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x28, 0x20
    addi    x29, x1,0
    li     x2, MASK_XLEN(-2047)
    add    x29, x29, x2
    # Test Instruction 
    sb      x28, 2047(x29)
    # Check results:  mem[test_34_res+0] = 0x00000020
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000020)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x29, 0x10
    addi    x30, x1,4
    li     x2, MASK_XLEN(2)
    add    x30, x30, x2
    # Test Instruction 
    sb      x29, -2(x30)
    # Check results:  mem[test_34_res+4] = 0x00000010
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000010)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x30, 0x8
    addi    x31, x1,8
    li     x2, MASK_XLEN(3)
    add    x31, x31, x2
    # Test Instruction 
    sb      x30, -3(x31)
    # Check results:  mem[test_34_res+8] = 0x00000008
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000008)



    

    RVTEST_SIGBASE(x4,signature_35_0)

    # Clear memory
    sw      x0, 0(x4)
    # Load values and compute offsets
    li      x2, 0x4
    addi    x1, x4,0
    li     x5, MASK_XLEN(5)
    add    x1, x1, x5
    # Test Instruction 
    sb      x2, -5(x1)
    # Check results:  mem[test_35_res+0] = 0x00000004
    lw x6, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000004)

    # Clear memory
    sw      x0, 4(x4)
    # Load values and compute offsets
    li      x1, 0x2
    addi    x2, x4,4
    li     x5, MASK_XLEN(9)
    add    x2, x2, x5
    # Test Instruction 
    sb      x1, -9(x2)
    # Check results:  mem[test_35_res+4] = 0x00000002
    lw x6, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000002)

    # Clear memory
    sw      x0, 8(x4)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x3, x4,8
    li     x5, MASK_XLEN(-1)
    add    x3, x3, x5
    # Test Instruction 
    sb      x2, 1(x3)
    # Check results:  mem[test_35_res+8] = 0x00000000
    lw x6, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x6, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_36_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x4, x1,0
    li     x2, MASK_XLEN(-2)
    add    x4, x4, x2
    # Test Instruction 
    sb      x3, 2(x4)
    # Check results:  mem[test_36_res+0] = 0x00000000
    lw x7, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x7, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x5, x1,4
    li     x2, MASK_XLEN(-4)
    add    x5, x5, x2
    # Test Instruction 
    sb      x4, 4(x5)
    # Check results:  mem[test_36_res+4] = 0x00000000
    lw x7, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x7, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x6, x1,8
    li     x2, MASK_XLEN(-8)
    add    x6, x6, x2
    # Test Instruction 
    sb      x5, 8(x6)
    # Check results:  mem[test_36_res+8] = 0x00000000
    lw x7, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x7, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_37_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x7, x1,0
    li     x2, MASK_XLEN(-16)
    add    x7, x7, x2
    # Test Instruction 
    sb      x6, 16(x7)
    # Check results:  mem[test_37_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x8, x1,4
    li     x2, MASK_XLEN(-32)
    add    x8, x8, x2
    # Test Instruction 
    sb      x7, 32(x8)
    # Check results:  mem[test_37_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x9, x1,8
    li     x2, MASK_XLEN(-64)
    add    x9, x9, x2
    # Test Instruction 
    sb      x8, 64(x9)
    # Check results:  mem[test_37_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_38_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,0
    li     x2, MASK_XLEN(-128)
    add    x10, x10, x2
    # Test Instruction 
    sb      x9, 128(x10)
    # Check results:  mem[test_38_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x11, x1,4
    li     x2, MASK_XLEN(-256)
    add    x11, x11, x2
    # Test Instruction 
    sb      x10, 256(x11)
    # Check results:  mem[test_38_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x12, x1,8
    li     x2, MASK_XLEN(-512)
    add    x12, x12, x2
    # Test Instruction 
    sb      x11, 512(x12)
    # Check results:  mem[test_38_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_39_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x13, x1,0
    li     x2, MASK_XLEN(-1024)
    add    x13, x13, x2
    # Test Instruction 
    sb      x12, 1024(x13)
    # Check results:  mem[test_39_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,4
    li     x2, MASK_XLEN(2048)
    add    x14, x14, x2
    # Test Instruction 
    sb      x13, -2048(x14)
    # Check results:  mem[test_39_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x15, x1,8
    li     x2, MASK_XLEN(2)
    add    x15, x15, x2
    # Test Instruction 
    sb      x14, -2(x15)
    # Check results:  mem[test_39_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_40_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x16, x1,0
    li     x2, MASK_XLEN(3)
    add    x16, x16, x2
    # Test Instruction 
    sb      x15, -3(x16)
    # Check results:  mem[test_40_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x17, x1,4
    li     x2, MASK_XLEN(5)
    add    x17, x17, x2
    # Test Instruction 
    sb      x16, -5(x17)
    # Check results:  mem[test_40_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x18, x1,8
    li     x2, MASK_XLEN(9)
    add    x18, x18, x2
    # Test Instruction 
    sb      x17, -9(x18)
    # Check results:  mem[test_40_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_41_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x19, x1,0
    li     x2, MASK_XLEN(17)
    add    x19, x19, x2
    # Test Instruction 
    sb      x18, -17(x19)
    # Check results:  mem[test_41_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x20, x1,4
    li     x2, MASK_XLEN(33)
    add    x20, x20, x2
    # Test Instruction 
    sb      x19, -33(x20)
    # Check results:  mem[test_41_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x21, x1,8
    li     x2, MASK_XLEN(65)
    add    x21, x21, x2
    # Test Instruction 
    sb      x20, -65(x21)
    # Check results:  mem[test_41_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_42_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x22, x1,0
    li     x2, MASK_XLEN(129)
    add    x22, x22, x2
    # Test Instruction 
    sb      x21, -129(x22)
    # Check results:  mem[test_42_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x23, x1,4
    li     x2, MASK_XLEN(257)
    add    x23, x23, x2
    # Test Instruction 
    sb      x22, -257(x23)
    # Check results:  mem[test_42_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x24, x1,8
    li     x2, MASK_XLEN(513)
    add    x24, x24, x2
    # Test Instruction 
    sb      x23, -513(x24)
    # Check results:  mem[test_42_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_43_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x25, x1,0
    li     x2, MASK_XLEN(1025)
    add    x25, x25, x2
    # Test Instruction 
    sb      x24, -1025(x25)
    # Check results:  mem[test_43_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x26, x1,4
    li     x2, MASK_XLEN(-2047)
    add    x26, x26, x2
    # Test Instruction 
    sb      x25, 2047(x26)
    # Check results:  mem[test_43_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x27, x1,8
    li     x2, MASK_XLEN(2)
    add    x27, x27, x2
    # Test Instruction 
    sb      x26, -2(x27)
    # Check results:  mem[test_43_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_44_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x28, x1,0
    li     x2, MASK_XLEN(3)
    add    x28, x28, x2
    # Test Instruction 
    sb      x27, -3(x28)
    # Check results:  mem[test_44_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x29, x1,4
    li     x2, MASK_XLEN(5)
    add    x29, x29, x2
    # Test Instruction 
    sb      x28, -5(x29)
    # Check results:  mem[test_44_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x30, x1,8
    li     x2, MASK_XLEN(9)
    add    x30, x30, x2
    # Test Instruction 
    sb      x29, -9(x30)
    # Check results:  mem[test_44_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x3,signature_45_0)

    # Clear memory
    sw      x0, 0(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x31, x3,0
    li     x4, MASK_XLEN(17)
    add    x31, x31, x4
    # Test Instruction 
    sb      x30, -17(x31)
    # Check results:  mem[test_45_res+0] = 0x00000000
    lw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 4(x3)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x1, x3,4
    li     x4, MASK_XLEN(33)
    add    x1, x1, x4
    # Test Instruction 
    sb      x2, -33(x1)
    # Check results:  mem[test_45_res+4] = 0x00000000
    lw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 8(x3)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x3,8
    li     x4, MASK_XLEN(65)
    add    x2, x2, x4
    # Test Instruction 
    sb      x1, -65(x2)
    # Check results:  mem[test_45_res+8] = 0x00000000
    lw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_46_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x3, x1,0
    li     x6, MASK_XLEN(129)
    add    x3, x3, x6
    # Test Instruction 
    sb      x2, -129(x3)
    # Check results:  mem[test_46_res+0] = 0x00000000
    lw x7, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x4, x1,4
    li     x6, MASK_XLEN(257)
    add    x4, x4, x6
    # Test Instruction 
    sb      x3, -257(x4)
    # Check results:  mem[test_46_res+4] = 0x00000000
    lw x7, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x4, 0x0
    addi    x5, x1,8
    li     x6, MASK_XLEN(513)
    add    x5, x5, x6
    # Test Instruction 
    sb      x4, -513(x5)
    # Check results:  mem[test_46_res+8] = 0x00000000
    lw x7, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_47_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x5, 0x0
    addi    x6, x1,0
    li     x2, MASK_XLEN(1025)
    add    x6, x6, x2
    # Test Instruction 
    sb      x5, -1025(x6)
    # Check results:  mem[test_47_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x6, 0x0
    addi    x7, x1,4
    li     x2, MASK_XLEN(-2047)
    add    x7, x7, x2
    # Test Instruction 
    sb      x6, 2047(x7)
    # Check results:  mem[test_47_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x7, 0x0
    addi    x8, x1,8
    li     x2, MASK_XLEN(2)
    add    x8, x8, x2
    # Test Instruction 
    sb      x7, -2(x8)
    # Check results:  mem[test_47_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_48_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x8, 0x0
    addi    x9, x1,0
    li     x2, MASK_XLEN(3)
    add    x9, x9, x2
    # Test Instruction 
    sb      x8, -3(x9)
    # Check results:  mem[test_48_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x9, 0x0
    addi    x10, x1,4
    li     x2, MASK_XLEN(5)
    add    x10, x10, x2
    # Test Instruction 
    sb      x9, -5(x10)
    # Check results:  mem[test_48_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x10, 0x0
    addi    x11, x1,8
    li     x2, MASK_XLEN(9)
    add    x11, x11, x2
    # Test Instruction 
    sb      x10, -9(x11)
    # Check results:  mem[test_48_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_49_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x11, 0x0
    addi    x12, x1,0
    li     x2, MASK_XLEN(17)
    add    x12, x12, x2
    # Test Instruction 
    sb      x11, -17(x12)
    # Check results:  mem[test_49_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x12, 0x0
    addi    x13, x1,4
    li     x2, MASK_XLEN(33)
    add    x13, x13, x2
    # Test Instruction 
    sb      x12, -33(x13)
    # Check results:  mem[test_49_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x13, 0x0
    addi    x14, x1,8
    li     x2, MASK_XLEN(65)
    add    x14, x14, x2
    # Test Instruction 
    sb      x13, -65(x14)
    # Check results:  mem[test_49_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_50_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x14, 0x0
    addi    x15, x1,0
    li     x2, MASK_XLEN(129)
    add    x15, x15, x2
    # Test Instruction 
    sb      x14, -129(x15)
    # Check results:  mem[test_50_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x15, 0x0
    addi    x16, x1,4
    li     x2, MASK_XLEN(257)
    add    x16, x16, x2
    # Test Instruction 
    sb      x15, -257(x16)
    # Check results:  mem[test_50_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x16, 0x0
    addi    x17, x1,8
    li     x2, MASK_XLEN(513)
    add    x17, x17, x2
    # Test Instruction 
    sb      x16, -513(x17)
    # Check results:  mem[test_50_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_51_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x17, 0x0
    addi    x18, x1,0
    li     x2, MASK_XLEN(1025)
    add    x18, x18, x2
    # Test Instruction 
    sb      x17, -1025(x18)
    # Check results:  mem[test_51_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x18, 0x0
    addi    x19, x1,4
    li     x2, MASK_XLEN(-2047)
    add    x19, x19, x2
    # Test Instruction 
    sb      x18, 2047(x19)
    # Check results:  mem[test_51_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x19, 0x0
    addi    x20, x1,8
    li     x2, MASK_XLEN(2)
    add    x20, x20, x2
    # Test Instruction 
    sb      x19, -2(x20)
    # Check results:  mem[test_51_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_52_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x20, 0x0
    addi    x21, x1,0
    li     x2, MASK_XLEN(3)
    add    x21, x21, x2
    # Test Instruction 
    sb      x20, -3(x21)
    # Check results:  mem[test_52_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x21, 0x0
    addi    x22, x1,4
    li     x2, MASK_XLEN(5)
    add    x22, x22, x2
    # Test Instruction 
    sb      x21, -5(x22)
    # Check results:  mem[test_52_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x22, 0x0
    addi    x23, x1,8
    li     x2, MASK_XLEN(9)
    add    x23, x23, x2
    # Test Instruction 
    sb      x22, -9(x23)
    # Check results:  mem[test_52_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_53_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x23, 0x0
    addi    x24, x1,0
    li     x2, MASK_XLEN(17)
    add    x24, x24, x2
    # Test Instruction 
    sb      x23, -17(x24)
    # Check results:  mem[test_53_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x24, 0x0
    addi    x25, x1,4
    li     x2, MASK_XLEN(33)
    add    x25, x25, x2
    # Test Instruction 
    sb      x24, -33(x25)
    # Check results:  mem[test_53_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x25, 0x0
    addi    x26, x1,8
    li     x2, MASK_XLEN(65)
    add    x26, x26, x2
    # Test Instruction 
    sb      x25, -65(x26)
    # Check results:  mem[test_53_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_54_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x26, 0x0
    addi    x27, x1,0
    li     x2, MASK_XLEN(129)
    add    x27, x27, x2
    # Test Instruction 
    sb      x26, -129(x27)
    # Check results:  mem[test_54_res+0] = 0x00000000
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 4(x1)
    # Load values and compute offsets
    li      x27, 0x0
    addi    x28, x1,4
    li     x2, MASK_XLEN(257)
    add    x28, x28, x2
    # Test Instruction 
    sb      x27, -257(x28)
    # Check results:  mem[test_54_res+4] = 0x00000000
    lw x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)

    # Clear memory
    sw      x0, 8(x1)
    # Load values and compute offsets
    li      x28, 0x0
    addi    x29, x1,8
    li     x2, MASK_XLEN(513)
    add    x29, x29, x2
    # Test Instruction 
    sb      x28, -513(x29)
    # Check results:  mem[test_54_res+8] = 0x00000000
    lw x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x00000000)



    

    RVTEST_SIGBASE(x3,signature_55_0)

    # Clear memory
    sw      x0, 0(x3)
    # Load values and compute offsets
    li      x29, 0x0
    addi    x30, x3,0
    li     x4, MASK_XLEN(1025)
    add    x30, x30, x4
    # Test Instruction 
    sb      x29, -1025(x30)
    # Check results:  mem[test_55_res+0] = 0x00000000
    lw x5, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 4(x3)
    # Load values and compute offsets
    li      x30, 0x0
    addi    x31, x3,4
    li     x4, MASK_XLEN(-2047)
    add    x31, x31, x4
    # Test Instruction 
    sb      x30, 2047(x31)
    # Check results:  mem[test_55_res+4] = 0x00000000
    lw x5, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)

    # Clear memory
    sw      x0, 8(x3)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x1, x3,8
    li     x4, MASK_XLEN(2)
    add    x1, x1, x4
    # Test Instruction 
    sb      x2, -2(x1)
    # Check results:  mem[test_55_res+8] = 0x00000000
    lw x5, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x5, 0x00000000)



    

    RVTEST_SIGBASE(x5,signature_56_0)

    # Clear memory
    sw      x0, 0(x5)
    # Load values and compute offsets
    li      x1, 0x0
    addi    x2, x5,0
    li     x6, MASK_XLEN(3)
    add    x2, x2, x6
    # Test Instruction 
    sb      x1, -3(x2)
    # Check results:  mem[test_56_res+0] = 0x00000000
    lw x7, 0(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 4(x5)
    # Load values and compute offsets
    li      x2, 0x0
    addi    x3, x5,4
    li     x6, MASK_XLEN(5)
    add    x3, x3, x6
    # Test Instruction 
    sb      x2, -5(x3)
    # Check results:  mem[test_56_res+4] = 0x00000000
    lw x7, 4(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)

    # Clear memory
    sw      x0, 8(x5)
    # Load values and compute offsets
    li      x3, 0x0
    addi    x4, x5,8
    li     x6, MASK_XLEN(9)
    add    x4, x4, x6
    # Test Instruction 
    sb      x3, -9(x4)
    # Check results:  mem[test_56_res+8] = 0x00000000
    lw x7, 8(x5)
    RVMODEL_IO_ASSERT_GPR_EQ(x6, x7, 0x00000000)



    

    RVTEST_SIGBASE(x1,signature_57_0)

    # Clear memory
    sw      x0, 0(x1)
    # Load values and compute offsets
    li      x0, 0x5742cfa5
    addi    x6, x1,0
    li     x2, MASK_XLEN(1423)
    add    x6, x6, x2
    # Test Instruction 
    sb      x0, -1423(x6)
    # Check results:  mem[test_57_res+0] = 0
    lw x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0)

	
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

