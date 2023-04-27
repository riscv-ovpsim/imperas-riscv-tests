// RISC-V Architectural Validation Test SLTU-01
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
// Description: Testing instruction 'SLTU'.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32I")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN







#ifdef TEST_CASE_1

    
    RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*I.*);def TEST_CASE_1=True;",sltu)

    RVTEST_SIGBASE(x1,signature_1_0)


inst_0:
    // Test 0:  Test with random values and registers (non-overlapping)
    // result rd:x19(0x00000001), rs1:x28(0x54f4aeeb), rs2:x30(0xf4bcf4a7)
    TEST_RR_OP(sltu, x19, x28, x30, 0x00000001, 0x54f4aeeb, 0xf4bcf4a7, x1, 0, x2)

inst_1:
    // Test 1:  Test with random values and registers (non-overlapping)
    // result rd:x20(0x00000000), rs1:x10(0xe1b1199b), rs2:x0(0xe3977ec1)
    TEST_RR_OP(sltu, x20, x10, x0, 0x00000000, 0xe1b1199b, 0xe3977ec1, x1, 4, x2)

inst_2:
    // Test 2:  Test with random values and registers (non-overlapping)
    // result rd:x3(0x00000000), rs1:x31(0xb26566a0), rs2:x29(0x80bd3ffe)
    TEST_RR_OP(sltu, x3, x31, x29, 0x00000000, 0xb26566a0, 0x80bd3ffe, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_2_0)


inst_3:
    // Test 3:  Test with random values and registers (non-overlapping)
    // result rd:x5(0x00000001), rs1:x0(0xf27008e6), rs2:x13(0xc3e260bd)
    TEST_RR_OP(sltu, x5, x0, x13, 0x00000001, 0xf27008e6, 0xc3e260bd, x1, 0, x3)

inst_4:
    // Test 4:  Test with random values and registers (non-overlapping)
    // result rd:x4(0x00000001), rs1:x11(0x0c8484a3), rs2:x25(0x2f7b22b7)
    TEST_RR_OP(sltu, x4, x11, x25, 0x00000001, 0xc8484a3, 0x2f7b22b7, x1, 4, x3)

inst_5:
    // Test 5:  Test with random values and registers (non-overlapping)
    // result rd:x2(0x00000001), rs1:x18(0xa783d03f), rs2:x7(0xbf042c8c)
    TEST_RR_OP(sltu, x2, x18, x7, 0x00000001, 0xa783d03f, 0xbf042c8c, x1, 8, x3)

    

    RVTEST_SIGBASE(x1,signature_3_0)


inst_6:
    // Test 6:  Test with random values and registers (non-overlapping)
    // result rd:x9(0x00000000), rs1:x31(0xfd7b9df8), rs2:x17(0x807fe203)
    TEST_RR_OP(sltu, x9, x31, x17, 0x00000000, 0xfd7b9df8, 0x807fe203, x1, 0, x2)

inst_7:
    // Test 7:  Test with random values and registers (non-overlapping)
    // result rd:x23(0x00000001), rs1:x31(0x0afaa29d), rs2:x21(0xa14cf866)
    TEST_RR_OP(sltu, x23, x31, x21, 0x00000001, 0xafaa29d, 0xa14cf866, x1, 4, x2)

inst_8:
    // Test 8:  Test with random values and registers (non-overlapping)
    // result rd:x0(0x00000000), rs1:x30(0x413f2c62), rs2:x17(0xe2fe6443)
    TEST_RR_OP(sltu, x0, x30, x17, 0x00000000, 0x413f2c62, 0xe2fe6443, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_4_0)


inst_9:
    // Test 9:  Test with random values and registers (non-overlapping)
    // result rd:x31(0x00000001), rs1:x6(0x2c370a9a), rs2:x11(0x701512f5)
    TEST_RR_OP(sltu, x31, x6, x11, 0x00000001, 0x2c370a9a, 0x701512f5, x1, 0, x4)

inst_10:
    // Test 10:  Test with random values and registers (non-overlapping)
    // result rd:x22(0x00000001), rs1:x9(0x2882a0b3), rs2:x2(0x2a81b798)
    TEST_RR_OP(sltu, x22, x9, x2, 0x00000001, 0x2882a0b3, 0x2a81b798, x1, 4, x4)

inst_11:
    // Test 11:  Test with random values and registers (non-overlapping)
    // result rd:x7(0x00000001), rs1:x13(0x91dd5ad6), rs2:x3(0xc68101ee)
    TEST_RR_OP(sltu, x7, x13, x3, 0x00000001, 0x91dd5ad6, 0xc68101ee, x1, 8, x4)

    

    RVTEST_SIGBASE(x1,signature_5_0)


inst_12:
    // Test 12:  Test with random values and registers (non-overlapping)
    // result rd:x13(0x00000001), rs1:x24(0x42f1d629), rs2:x12(0x589f2ccd)
    TEST_RR_OP(sltu, x13, x24, x12, 0x00000001, 0x42f1d629, 0x589f2ccd, x1, 0, x2)

inst_13:
    // Test 13:  Test with random values and registers (non-overlapping)
    // result rd:x3(0x00000000), rs1:x17(0xcddbdf6f), rs2:x14(0x014cf50e)
    TEST_RR_OP(sltu, x3, x17, x14, 0x00000000, 0xcddbdf6f, 0x14cf50e, x1, 4, x2)

inst_14:
    // Test 14:  Test with random values and registers (non-overlapping)
    // result rd:x31(0x00000001), rs1:x20(0x4d236af8), rs2:x18(0xc9e2ce4f)
    TEST_RR_OP(sltu, x31, x20, x18, 0x00000001, 0x4d236af8, 0xc9e2ce4f, x1, 8, x2)

    

    RVTEST_SIGBASE(x2,signature_6_0)


inst_15:
    // Test 15:  Test with random values and registers (non-overlapping)
    // result rd:x4(0x00000000), rs1:x29(0x983b9f63), rs2:x30(0x242b9878)
    TEST_RR_OP(sltu, x4, x29, x30, 0x00000000, 0x983b9f63, 0x242b9878, x2, 0, x5)

inst_16:
    // Test 16:  Test with random values and registers (non-overlapping)
    // result rd:x17(0x00000001), rs1:x1(0x1fbe3ca6), rs2:x22(0x28aadb5b)
    TEST_RR_OP(sltu, x17, x1, x22, 0x00000001, 0x1fbe3ca6, 0x28aadb5b, x2, 4, x5)

inst_17:
    // Test 17:  Test with random values and registers (non-overlapping)
    // result rd:x3(0x00000001), rs1:x19(0x353a8593), rs2:x15(0xdf0fdcd2)
    TEST_RR_OP(sltu, x3, x19, x15, 0x00000001, 0x353a8593, 0xdf0fdcd2, x2, 8, x5)

    

    RVTEST_SIGBASE(x1,signature_7_0)


inst_18:
    // Test 18:  Test with random values and registers (non-overlapping)
    // result rd:x13(0x00000001), rs1:x28(0x66268a1a), rs2:x6(0xc357b925)
    TEST_RR_OP(sltu, x13, x28, x6, 0x00000001, 0x66268a1a, 0xc357b925, x1, 0, x2)

inst_19:
    // Test 19:  Test with random values and registers (non-overlapping)
    // result rd:x14(0x00000001), rs1:x6(0x28ac54a3), rs2:x9(0xba4194f8)
    TEST_RR_OP(sltu, x14, x6, x9, 0x00000001, 0x28ac54a3, 0xba4194f8, x1, 4, x2)

inst_20:
    // Test 20:  Test with random values and registers (non-overlapping)
    // result rd:x17(0x00000000), rs1:x10(0xdc3713a2), rs2:x14(0xc2e008f5)
    TEST_RR_OP(sltu, x17, x10, x14, 0x00000000, 0xdc3713a2, 0xc2e008f5, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_8_0)


inst_21:
    // Test 21:  Test with random values and registers (non-overlapping)
    // result rd:x6(0x00000000), rs1:x22(0x74674399), rs2:x0(0x2ed729e0)
    TEST_RR_OP(sltu, x6, x22, x0, 0x00000000, 0x74674399, 0x2ed729e0, x1, 0, x2)

inst_22:
    // Test 22:  Test with random values and registers (non-overlapping)
    // result rd:x0(0x00000000), rs1:x19(0x6bdd9821), rs2:x28(0x5b57716e)
    TEST_RR_OP(sltu, x0, x19, x28, 0x00000000, 0x6bdd9821, 0x5b57716e, x1, 4, x2)

inst_23:
    // Test 23:  Test with random values and registers (non-overlapping)
    // result rd:x19(0x00000000), rs1:x31(0x825648e4), rs2:x30(0x78636af4)
    TEST_RR_OP(sltu, x19, x31, x30, 0x00000000, 0x825648e4, 0x78636af4, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_9_0)


inst_24:
    // Test 24:  Test with random values and registers (non-overlapping)
    // result rd:x27(0x00000001), rs1:x21(0x7bf4ef1c), rs2:x23(0xf4cc30bc)
    TEST_RR_OP(sltu, x27, x21, x23, 0x00000001, 0x7bf4ef1c, 0xf4cc30bc, x1, 0, x2)

inst_25:
    // Test 25:  Test with random values and registers (non-overlapping)
    // result rd:x16(0x00000001), rs1:x24(0x0f49a4b2), rs2:x28(0x35a0ec80)
    TEST_RR_OP(sltu, x16, x24, x28, 0x00000001, 0xf49a4b2, 0x35a0ec80, x1, 4, x2)

inst_26:
    // Test 26:  Test with random values and registers (non-overlapping)
    // result rd:x7(0x00000000), rs1:x26(0xfe9b8abf), rs2:x16(0xcb0947ed)
    TEST_RR_OP(sltu, x7, x26, x16, 0x00000000, 0xfe9b8abf, 0xcb0947ed, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_10_0)


inst_27:
    // Test 27:  Test with random values and registers (non-overlapping)
    // result rd:x5(0x00000001), rs1:x13(0x347ebc89), rs2:x3(0x8cc7e790)
    TEST_RR_OP(sltu, x5, x13, x3, 0x00000001, 0x347ebc89, 0x8cc7e790, x1, 0, x4)

inst_28:
    // Test 28:  Test with random values and registers (non-overlapping)
    // result rd:x5(0x00000000), rs1:x8(0xf52a52bf), rs2:x27(0xa5c8d860)
    TEST_RR_OP(sltu, x5, x8, x27, 0x00000000, 0xf52a52bf, 0xa5c8d860, x1, 4, x4)

inst_29:
    // Test 29:  Test with random values and registers (non-overlapping)
    // result rd:x0(0x00000000), rs1:x2(0xcaa4b80e), rs2:x7(0xf4a64999)
    TEST_RR_OP(sltu, x0, x2, x7, 0x00000000, 0xcaa4b80e, 0xf4a64999, x1, 8, x4)

    

    RVTEST_SIGBASE(x1,signature_11_0)


inst_30:
    // Test 30:  Test with min, max, and other significant values
    // result rd:x28(0x00000000), rs1:x3(0xffffffff), rs2:x30(0x00000000)
    TEST_RR_OP(sltu, x28, x3, x30, 0x00000000, 0xffffffff, 0x0, x1, 0, x2)

inst_31:
    // Test 31:  Test with min, max, and other significant values
    // result rd:x24(0x00000001), rs1:x17(0x80000000), rs2:x28(0xffffffff)
    TEST_RR_OP(sltu, x24, x17, x28, 0x00000001, 0x80000000, 0xffffffff, x1, 4, x2)

inst_32:
    // Test 32:  Test with min, max, and other significant values
    // result rd:x14(0x00000000), rs1:x21(0xffffffff), rs2:x22(0xffffffff)
    TEST_RR_OP(sltu, x14, x21, x22, 0x00000000, 0xffffffff, 0xffffffff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_12_0)


inst_33:
    // Test 33:  Test with min, max, and other significant values
    // result rd:x0(0x00000000), rs1:x12(0x00000000), rs2:x5(0x7fffffff)
    TEST_RR_OP(sltu, x0, x12, x5, 0x00000000, 0x0, 0x7fffffff, x1, 0, x2)

inst_34:
    // Test 34:  Test with min, max, and other significant values
    // result rd:x29(0x00000000), rs1:x0(0xffffffff), rs2:x30(0x00000000)
    TEST_RR_OP(sltu, x29, x0, x30, 0x00000000, 0xffffffff, 0x0, x1, 4, x2)

inst_35:
    // Test 35:  Test with min, max, and other significant values
    // result rd:x0(0x00000000), rs1:x11(0x80000000), rs2:x17(0xffffffff)
    TEST_RR_OP(sltu, x0, x11, x17, 0x00000000, 0x80000000, 0xffffffff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_13_0)


inst_36:
    // Test 36:  Test with min, max, and other significant values
    // result rd:x23(0x00000000), rs1:x16(0xffffffff), rs2:x24(0xffffffff)
    TEST_RR_OP(sltu, x23, x16, x24, 0x00000000, 0xffffffff, 0xffffffff, x1, 0, x3)

inst_37:
    // Test 37:  Test with min, max, and other significant values
    // result rd:x12(0x00000001), rs1:x29(0x00000000), rs2:x2(0x7fffffff)
    TEST_RR_OP(sltu, x12, x29, x2, 0x00000001, 0x0, 0x7fffffff, x1, 4, x3)

inst_38:
    // Test 38:  Test with min, max, and other significant values
    // result rd:x31(0x00000000), rs1:x12(0xffffffff), rs2:x30(0x00000000)
    TEST_RR_OP(sltu, x31, x12, x30, 0x00000000, 0xffffffff, 0x0, x1, 8, x3)

    

    RVTEST_SIGBASE(x4,signature_14_0)


inst_39:
    // Test 39:  Test with min, max, and other significant values
    // result rd:x7(0x00000001), rs1:x26(0x80000000), rs2:x6(0xffffffff)
    TEST_RR_OP(sltu, x7, x26, x6, 0x00000001, 0x80000000, 0xffffffff, x4, 0, x5)

inst_40:
    // Test 40:  Test with marching zeros/ones
    // result rd:x1(0x00000001), rs1:x2(0x00000001), rs2:x3(0xfffffffe)
    TEST_RR_OP(sltu, x1, x2, x3, 0x00000001, 0x1, 0xfffffffe, x4, 4, x5)

inst_41:
    // Test 41:  Test with marching zeros/ones
    // result rd:x1(0x00000001), rs1:x2(0x00000002), rs2:x3(0x7fffffff)
    TEST_RR_OP(sltu, x1, x2, x3, 0x00000001, 0x2, 0x7fffffff, x4, 8, x5)

    

    RVTEST_SIGBASE(x1,signature_15_0)


inst_42:
    // Test 42:  Test with marching zeros/ones
    // result rd:x2(0x00000001), rs1:x3(0x00000004), rs2:x4(0xbfffffff)
    TEST_RR_OP(sltu, x2, x3, x4, 0x00000001, 0x4, 0xbfffffff, x1, 0, x7)

inst_43:
    // Test 43:  Test with marching zeros/ones
    // result rd:x3(0x00000001), rs1:x4(0x00000008), rs2:x5(0xdfffffff)
    TEST_RR_OP(sltu, x3, x4, x5, 0x00000001, 0x8, 0xdfffffff, x1, 4, x7)

inst_44:
    // Test 44:  Test with marching zeros/ones
    // result rd:x4(0x00000001), rs1:x5(0x00000010), rs2:x6(0xefffffff)
    TEST_RR_OP(sltu, x4, x5, x6, 0x00000001, 0x10, 0xefffffff, x1, 8, x7)

    

    RVTEST_SIGBASE(x1,signature_16_0)


inst_45:
    // Test 45:  Test with marching zeros/ones
    // result rd:x5(0x00000001), rs1:x6(0x00000020), rs2:x7(0xf7ffffff)
    TEST_RR_OP(sltu, x5, x6, x7, 0x00000001, 0x20, 0xf7ffffff, x1, 0, x2)

inst_46:
    // Test 46:  Test with marching zeros/ones
    // result rd:x6(0x00000001), rs1:x7(0x00000040), rs2:x8(0xfbffffff)
    TEST_RR_OP(sltu, x6, x7, x8, 0x00000001, 0x40, 0xfbffffff, x1, 4, x2)

inst_47:
    // Test 47:  Test with marching zeros/ones
    // result rd:x7(0x00000001), rs1:x8(0x00000080), rs2:x9(0xfdffffff)
    TEST_RR_OP(sltu, x7, x8, x9, 0x00000001, 0x80, 0xfdffffff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_17_0)


inst_48:
    // Test 48:  Test with marching zeros/ones
    // result rd:x8(0x00000001), rs1:x9(0x00000100), rs2:x10(0xfeffffff)
    TEST_RR_OP(sltu, x8, x9, x10, 0x00000001, 0x100, 0xfeffffff, x1, 0, x2)

inst_49:
    // Test 49:  Test with marching zeros/ones
    // result rd:x9(0x00000001), rs1:x10(0x00000200), rs2:x11(0xff7fffff)
    TEST_RR_OP(sltu, x9, x10, x11, 0x00000001, 0x200, 0xff7fffff, x1, 4, x2)

inst_50:
    // Test 50:  Test with marching zeros/ones
    // result rd:x10(0x00000001), rs1:x11(0x00000400), rs2:x12(0xffbfffff)
    TEST_RR_OP(sltu, x10, x11, x12, 0x00000001, 0x400, 0xffbfffff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_18_0)


inst_51:
    // Test 51:  Test with marching zeros/ones
    // result rd:x11(0x00000001), rs1:x12(0x00000800), rs2:x13(0xffdfffff)
    TEST_RR_OP(sltu, x11, x12, x13, 0x00000001, 0x800, 0xffdfffff, x1, 0, x2)

inst_52:
    // Test 52:  Test with marching zeros/ones
    // result rd:x12(0x00000001), rs1:x13(0x00001000), rs2:x14(0xffefffff)
    TEST_RR_OP(sltu, x12, x13, x14, 0x00000001, 0x1000, 0xffefffff, x1, 4, x2)

inst_53:
    // Test 53:  Test with marching zeros/ones
    // result rd:x13(0x00000001), rs1:x14(0x00002000), rs2:x15(0xfff7ffff)
    TEST_RR_OP(sltu, x13, x14, x15, 0x00000001, 0x2000, 0xfff7ffff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_19_0)


inst_54:
    // Test 54:  Test with marching zeros/ones
    // result rd:x14(0x00000001), rs1:x15(0x00004000), rs2:x16(0xfffbffff)
    TEST_RR_OP(sltu, x14, x15, x16, 0x00000001, 0x4000, 0xfffbffff, x1, 0, x2)

inst_55:
    // Test 55:  Test with marching zeros/ones
    // result rd:x15(0x00000001), rs1:x16(0x00008000), rs2:x17(0xfffdffff)
    TEST_RR_OP(sltu, x15, x16, x17, 0x00000001, 0x8000, 0xfffdffff, x1, 4, x2)

inst_56:
    // Test 56:  Test with marching zeros/ones
    // result rd:x16(0x00000001), rs1:x17(0x00010000), rs2:x18(0xfffeffff)
    TEST_RR_OP(sltu, x16, x17, x18, 0x00000001, 0x10000, 0xfffeffff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_20_0)


inst_57:
    // Test 57:  Test with marching zeros/ones
    // result rd:x17(0x00000001), rs1:x18(0x00020000), rs2:x19(0xffff7fff)
    TEST_RR_OP(sltu, x17, x18, x19, 0x00000001, 0x20000, 0xffff7fff, x1, 0, x2)

inst_58:
    // Test 58:  Test with marching zeros/ones
    // result rd:x18(0x00000001), rs1:x19(0x00040000), rs2:x20(0xffffbfff)
    TEST_RR_OP(sltu, x18, x19, x20, 0x00000001, 0x40000, 0xffffbfff, x1, 4, x2)

inst_59:
    // Test 59:  Test with marching zeros/ones
    // result rd:x19(0x00000001), rs1:x20(0x00080000), rs2:x21(0xffffdfff)
    TEST_RR_OP(sltu, x19, x20, x21, 0x00000001, 0x80000, 0xffffdfff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_21_0)


inst_60:
    // Test 60:  Test with marching zeros/ones
    // result rd:x20(0x00000001), rs1:x21(0x00100000), rs2:x22(0xffffefff)
    TEST_RR_OP(sltu, x20, x21, x22, 0x00000001, 0x100000, 0xffffefff, x1, 0, x2)

inst_61:
    // Test 61:  Test with marching zeros/ones
    // result rd:x21(0x00000001), rs1:x22(0x00200000), rs2:x23(0xfffff7ff)
    TEST_RR_OP(sltu, x21, x22, x23, 0x00000001, 0x200000, 0xfffff7ff, x1, 4, x2)

inst_62:
    // Test 62:  Test with marching zeros/ones
    // result rd:x22(0x00000001), rs1:x23(0x00400000), rs2:x24(0xfffffbff)
    TEST_RR_OP(sltu, x22, x23, x24, 0x00000001, 0x400000, 0xfffffbff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_22_0)


inst_63:
    // Test 63:  Test with marching zeros/ones
    // result rd:x23(0x00000001), rs1:x24(0x00800000), rs2:x25(0xfffffdff)
    TEST_RR_OP(sltu, x23, x24, x25, 0x00000001, 0x800000, 0xfffffdff, x1, 0, x2)

inst_64:
    // Test 64:  Test with marching zeros/ones
    // result rd:x24(0x00000001), rs1:x25(0x01000000), rs2:x26(0xfffffeff)
    TEST_RR_OP(sltu, x24, x25, x26, 0x00000001, 0x1000000, 0xfffffeff, x1, 4, x2)

inst_65:
    // Test 65:  Test with marching zeros/ones
    // result rd:x25(0x00000001), rs1:x26(0x02000000), rs2:x27(0xffffff7f)
    TEST_RR_OP(sltu, x25, x26, x27, 0x00000001, 0x2000000, 0xffffff7f, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_23_0)


inst_66:
    // Test 66:  Test with marching zeros/ones
    // result rd:x26(0x00000001), rs1:x27(0x04000000), rs2:x28(0xffffffbf)
    TEST_RR_OP(sltu, x26, x27, x28, 0x00000001, 0x4000000, 0xffffffbf, x1, 0, x2)

inst_67:
    // Test 67:  Test with marching zeros/ones
    // result rd:x27(0x00000001), rs1:x28(0x08000000), rs2:x29(0xffffffdf)
    TEST_RR_OP(sltu, x27, x28, x29, 0x00000001, 0x8000000, 0xffffffdf, x1, 4, x2)

inst_68:
    // Test 68:  Test with marching zeros/ones
    // result rd:x28(0x00000001), rs1:x29(0x10000000), rs2:x30(0xffffffef)
    TEST_RR_OP(sltu, x28, x29, x30, 0x00000001, 0x10000000, 0xffffffef, x1, 8, x2)

    

    RVTEST_SIGBASE(x3,signature_24_0)


inst_69:
    // Test 69:  Test with marching zeros/ones
    // result rd:x29(0x00000001), rs1:x30(0x20000000), rs2:x31(0xfffffff7)
    TEST_RR_OP(sltu, x29, x30, x31, 0x00000001, 0x20000000, 0xfffffff7, x3, 0, x4)

inst_70:
    // Test 70:  Test with marching zeros/ones
    // result rd:x30(0x00000001), rs1:x31(0x40000000), rs2:x1(0xfffffffb)
    TEST_RR_OP(sltu, x30, x31, x1, 0x00000001, 0x40000000, 0xfffffffb, x3, 4, x4)

inst_71:
    // Test 71:  Test with marching zeros/ones
    // result rd:x31(0x00000001), rs1:x1(0x80000000), rs2:x2(0xfffffffd)
    TEST_RR_OP(sltu, x31, x1, x2, 0x00000001, 0x80000000, 0xfffffffd, x3, 8, x4)

    

    RVTEST_SIGBASE(x5,signature_25_0)


inst_72:
    // Test 72:  Test with marching zeros/ones
    // result rd:x1(0x00000000), rs1:x2(0xfffffffe), rs2:x3(0xfffffffe)
    TEST_RR_OP(sltu, x1, x2, x3, 0x00000000, 0xfffffffe, 0xfffffffe, x5, 0, x6)

inst_73:
    // Test 73:  Test with marching zeros/ones
    // result rd:x1(0x00000000), rs1:x2(0xfffffffd), rs2:x3(0x80000000)
    TEST_RR_OP(sltu, x1, x2, x3, 0x00000000, 0xfffffffd, 0x80000000, x5, 4, x6)

inst_74:
    // Test 74:  Test with marching zeros/ones
    // result rd:x2(0x00000000), rs1:x3(0xfffffffb), rs2:x4(0x40000000)
    TEST_RR_OP(sltu, x2, x3, x4, 0x00000000, 0xfffffffb, 0x40000000, x5, 8, x6)

    

    RVTEST_SIGBASE(x1,signature_26_0)


inst_75:
    // Test 75:  Test with marching zeros/ones
    // result rd:x3(0x00000000), rs1:x4(0xfffffff7), rs2:x5(0x20000000)
    TEST_RR_OP(sltu, x3, x4, x5, 0x00000000, 0xfffffff7, 0x20000000, x1, 0, x2)

inst_76:
    // Test 76:  Test with marching zeros/ones
    // result rd:x4(0x00000000), rs1:x5(0xffffffef), rs2:x6(0x10000000)
    TEST_RR_OP(sltu, x4, x5, x6, 0x00000000, 0xffffffef, 0x10000000, x1, 4, x2)

inst_77:
    // Test 77:  Test with marching zeros/ones
    // result rd:x5(0x00000000), rs1:x6(0xffffffdf), rs2:x7(0x08000000)
    TEST_RR_OP(sltu, x5, x6, x7, 0x00000000, 0xffffffdf, 0x8000000, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_27_0)


inst_78:
    // Test 78:  Test with marching zeros/ones
    // result rd:x6(0x00000000), rs1:x7(0xffffffbf), rs2:x8(0x04000000)
    TEST_RR_OP(sltu, x6, x7, x8, 0x00000000, 0xffffffbf, 0x4000000, x1, 0, x2)

inst_79:
    // Test 79:  Test with marching zeros/ones
    // result rd:x7(0x00000000), rs1:x8(0xffffff7f), rs2:x9(0x02000000)
    TEST_RR_OP(sltu, x7, x8, x9, 0x00000000, 0xffffff7f, 0x2000000, x1, 4, x2)

inst_80:
    // Test 80:  Test with marching zeros/ones
    // result rd:x8(0x00000000), rs1:x9(0xfffffeff), rs2:x10(0x01000000)
    TEST_RR_OP(sltu, x8, x9, x10, 0x00000000, 0xfffffeff, 0x1000000, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_28_0)


inst_81:
    // Test 81:  Test with marching zeros/ones
    // result rd:x9(0x00000000), rs1:x10(0xfffffdff), rs2:x11(0x00800000)
    TEST_RR_OP(sltu, x9, x10, x11, 0x00000000, 0xfffffdff, 0x800000, x1, 0, x2)

inst_82:
    // Test 82:  Test with marching zeros/ones
    // result rd:x10(0x00000000), rs1:x11(0xfffffbff), rs2:x12(0x00400000)
    TEST_RR_OP(sltu, x10, x11, x12, 0x00000000, 0xfffffbff, 0x400000, x1, 4, x2)

inst_83:
    // Test 83:  Test with marching zeros/ones
    // result rd:x11(0x00000000), rs1:x12(0xfffff7ff), rs2:x13(0x00200000)
    TEST_RR_OP(sltu, x11, x12, x13, 0x00000000, 0xfffff7ff, 0x200000, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_29_0)


inst_84:
    // Test 84:  Test with marching zeros/ones
    // result rd:x12(0x00000000), rs1:x13(0xffffefff), rs2:x14(0x00100000)
    TEST_RR_OP(sltu, x12, x13, x14, 0x00000000, 0xffffefff, 0x100000, x1, 0, x2)

inst_85:
    // Test 85:  Test with marching zeros/ones
    // result rd:x13(0x00000000), rs1:x14(0xffffdfff), rs2:x15(0x00080000)
    TEST_RR_OP(sltu, x13, x14, x15, 0x00000000, 0xffffdfff, 0x80000, x1, 4, x2)

inst_86:
    // Test 86:  Test with marching zeros/ones
    // result rd:x14(0x00000000), rs1:x15(0xffffbfff), rs2:x16(0x00040000)
    TEST_RR_OP(sltu, x14, x15, x16, 0x00000000, 0xffffbfff, 0x40000, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_30_0)


inst_87:
    // Test 87:  Test with marching zeros/ones
    // result rd:x15(0x00000000), rs1:x16(0xffff7fff), rs2:x17(0x00020000)
    TEST_RR_OP(sltu, x15, x16, x17, 0x00000000, 0xffff7fff, 0x20000, x1, 0, x2)

inst_88:
    // Test 88:  Test with marching zeros/ones
    // result rd:x16(0x00000000), rs1:x17(0xfffeffff), rs2:x18(0x00010000)
    TEST_RR_OP(sltu, x16, x17, x18, 0x00000000, 0xfffeffff, 0x10000, x1, 4, x2)

inst_89:
    // Test 89:  Test with marching zeros/ones
    // result rd:x17(0x00000000), rs1:x18(0xfffdffff), rs2:x19(0x00008000)
    TEST_RR_OP(sltu, x17, x18, x19, 0x00000000, 0xfffdffff, 0x8000, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_31_0)


inst_90:
    // Test 90:  Test with marching zeros/ones
    // result rd:x18(0x00000000), rs1:x19(0xfffbffff), rs2:x20(0x00004000)
    TEST_RR_OP(sltu, x18, x19, x20, 0x00000000, 0xfffbffff, 0x4000, x1, 0, x2)

inst_91:
    // Test 91:  Test with marching zeros/ones
    // result rd:x19(0x00000000), rs1:x20(0xfff7ffff), rs2:x21(0x00002000)
    TEST_RR_OP(sltu, x19, x20, x21, 0x00000000, 0xfff7ffff, 0x2000, x1, 4, x2)

inst_92:
    // Test 92:  Test with marching zeros/ones
    // result rd:x20(0x00000000), rs1:x21(0xffefffff), rs2:x22(0x00001000)
    TEST_RR_OP(sltu, x20, x21, x22, 0x00000000, 0xffefffff, 0x1000, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_32_0)


inst_93:
    // Test 93:  Test with marching zeros/ones
    // result rd:x21(0x00000000), rs1:x22(0xffdfffff), rs2:x23(0x00000800)
    TEST_RR_OP(sltu, x21, x22, x23, 0x00000000, 0xffdfffff, 0x800, x1, 0, x2)

inst_94:
    // Test 94:  Test with marching zeros/ones
    // result rd:x22(0x00000000), rs1:x23(0xffbfffff), rs2:x24(0x00000400)
    TEST_RR_OP(sltu, x22, x23, x24, 0x00000000, 0xffbfffff, 0x400, x1, 4, x2)

inst_95:
    // Test 95:  Test with marching zeros/ones
    // result rd:x23(0x00000000), rs1:x24(0xff7fffff), rs2:x25(0x00000200)
    TEST_RR_OP(sltu, x23, x24, x25, 0x00000000, 0xff7fffff, 0x200, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_33_0)


inst_96:
    // Test 96:  Test with marching zeros/ones
    // result rd:x24(0x00000000), rs1:x25(0xfeffffff), rs2:x26(0x00000100)
    TEST_RR_OP(sltu, x24, x25, x26, 0x00000000, 0xfeffffff, 0x100, x1, 0, x2)

inst_97:
    // Test 97:  Test with marching zeros/ones
    // result rd:x25(0x00000000), rs1:x26(0xfdffffff), rs2:x27(0x00000080)
    TEST_RR_OP(sltu, x25, x26, x27, 0x00000000, 0xfdffffff, 0x80, x1, 4, x2)

inst_98:
    // Test 98:  Test with marching zeros/ones
    // result rd:x26(0x00000000), rs1:x27(0xfbffffff), rs2:x28(0x00000040)
    TEST_RR_OP(sltu, x26, x27, x28, 0x00000000, 0xfbffffff, 0x40, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_34_0)


inst_99:
    // Test 99:  Test with marching zeros/ones
    // result rd:x27(0x00000000), rs1:x28(0xf7ffffff), rs2:x29(0x00000020)
    TEST_RR_OP(sltu, x27, x28, x29, 0x00000000, 0xf7ffffff, 0x20, x1, 0, x2)

inst_100:
    // Test 100:  Test with marching zeros/ones
    // result rd:x28(0x00000000), rs1:x29(0xefffffff), rs2:x30(0x00000010)
    TEST_RR_OP(sltu, x28, x29, x30, 0x00000000, 0xefffffff, 0x10, x1, 4, x2)

inst_101:
    // Test 101:  Test with marching zeros/ones
    // result rd:x29(0x00000000), rs1:x30(0xdfffffff), rs2:x31(0x00000008)
    TEST_RR_OP(sltu, x29, x30, x31, 0x00000000, 0xdfffffff, 0x8, x1, 8, x2)

    

    RVTEST_SIGBASE(x4,signature_35_0)


inst_102:
    // Test 102:  Test with marching zeros/ones
    // result rd:x30(0x00000000), rs1:x31(0xbfffffff), rs2:x1(0x00000004)
    TEST_RR_OP(sltu, x30, x31, x1, 0x00000000, 0xbfffffff, 0x4, x4, 0, x5)

inst_103:
    // Test 103:  Test with marching zeros/ones
    // result rd:x31(0x00000000), rs1:x1(0x7fffffff), rs2:x2(0x00000002)
    TEST_RR_OP(sltu, x31, x1, x2, 0x00000000, 0x7fffffff, 0x2, x4, 4, x5)

inst_104:
    // Test 104:  Test with marching zeros/ones
    // result rd:x1(0x00000000), rs1:x2(0x00000001), rs2:x3(0x00000000)
    TEST_RR_OP(sltu, x1, x2, x3, 0x00000000, 0x1, 0x0, x4, 8, x5)

    

    RVTEST_SIGBASE(x6,signature_36_0)


inst_105:
    // Test 105:  Test with marching zeros/ones
    // result rd:x1(0x00000000), rs1:x2(0x00000002), rs2:x3(0x00000000)
    TEST_RR_OP(sltu, x1, x2, x3, 0x00000000, 0x2, 0x0, x6, 0, x7)

inst_106:
    // Test 106:  Test with marching zeros/ones
    // result rd:x2(0x00000000), rs1:x3(0x00000004), rs2:x4(0x00000000)
    TEST_RR_OP(sltu, x2, x3, x4, 0x00000000, 0x4, 0x0, x6, 4, x7)

inst_107:
    // Test 107:  Test with marching zeros/ones
    // result rd:x3(0x00000000), rs1:x4(0x00000008), rs2:x5(0x00000000)
    TEST_RR_OP(sltu, x3, x4, x5, 0x00000000, 0x8, 0x0, x6, 8, x7)

    

    RVTEST_SIGBASE(x1,signature_37_0)


inst_108:
    // Test 108:  Test with marching zeros/ones
    // result rd:x4(0x00000000), rs1:x5(0x00000010), rs2:x6(0x00000000)
    TEST_RR_OP(sltu, x4, x5, x6, 0x00000000, 0x10, 0x0, x1, 0, x2)

inst_109:
    // Test 109:  Test with marching zeros/ones
    // result rd:x5(0x00000000), rs1:x6(0x00000020), rs2:x7(0x00000000)
    TEST_RR_OP(sltu, x5, x6, x7, 0x00000000, 0x20, 0x0, x1, 4, x2)

inst_110:
    // Test 110:  Test with marching zeros/ones
    // result rd:x6(0x00000000), rs1:x7(0x00000040), rs2:x8(0x00000000)
    TEST_RR_OP(sltu, x6, x7, x8, 0x00000000, 0x40, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_38_0)


inst_111:
    // Test 111:  Test with marching zeros/ones
    // result rd:x7(0x00000000), rs1:x8(0x00000080), rs2:x9(0x00000000)
    TEST_RR_OP(sltu, x7, x8, x9, 0x00000000, 0x80, 0x0, x1, 0, x2)

inst_112:
    // Test 112:  Test with marching zeros/ones
    // result rd:x8(0x00000000), rs1:x9(0x00000100), rs2:x10(0x00000000)
    TEST_RR_OP(sltu, x8, x9, x10, 0x00000000, 0x100, 0x0, x1, 4, x2)

inst_113:
    // Test 113:  Test with marching zeros/ones
    // result rd:x9(0x00000000), rs1:x10(0x00000200), rs2:x11(0x00000000)
    TEST_RR_OP(sltu, x9, x10, x11, 0x00000000, 0x200, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_39_0)


inst_114:
    // Test 114:  Test with marching zeros/ones
    // result rd:x10(0x00000000), rs1:x11(0x00000400), rs2:x12(0x00000000)
    TEST_RR_OP(sltu, x10, x11, x12, 0x00000000, 0x400, 0x0, x1, 0, x2)

inst_115:
    // Test 115:  Test with marching zeros/ones
    // result rd:x11(0x00000000), rs1:x12(0x00000800), rs2:x13(0x00000000)
    TEST_RR_OP(sltu, x11, x12, x13, 0x00000000, 0x800, 0x0, x1, 4, x2)

inst_116:
    // Test 116:  Test with marching zeros/ones
    // result rd:x12(0x00000000), rs1:x13(0x00001000), rs2:x14(0x00000000)
    TEST_RR_OP(sltu, x12, x13, x14, 0x00000000, 0x1000, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_40_0)


inst_117:
    // Test 117:  Test with marching zeros/ones
    // result rd:x13(0x00000000), rs1:x14(0x00002000), rs2:x15(0x00000000)
    TEST_RR_OP(sltu, x13, x14, x15, 0x00000000, 0x2000, 0x0, x1, 0, x2)

inst_118:
    // Test 118:  Test with marching zeros/ones
    // result rd:x14(0x00000000), rs1:x15(0x00004000), rs2:x16(0x00000000)
    TEST_RR_OP(sltu, x14, x15, x16, 0x00000000, 0x4000, 0x0, x1, 4, x2)

inst_119:
    // Test 119:  Test with marching zeros/ones
    // result rd:x15(0x00000000), rs1:x16(0x00008000), rs2:x17(0x00000000)
    TEST_RR_OP(sltu, x15, x16, x17, 0x00000000, 0x8000, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_41_0)


inst_120:
    // Test 120:  Test with marching zeros/ones
    // result rd:x16(0x00000000), rs1:x17(0x00010000), rs2:x18(0x00000000)
    TEST_RR_OP(sltu, x16, x17, x18, 0x00000000, 0x10000, 0x0, x1, 0, x2)

inst_121:
    // Test 121:  Test with marching zeros/ones
    // result rd:x17(0x00000000), rs1:x18(0x00020000), rs2:x19(0x00000000)
    TEST_RR_OP(sltu, x17, x18, x19, 0x00000000, 0x20000, 0x0, x1, 4, x2)

inst_122:
    // Test 122:  Test with marching zeros/ones
    // result rd:x18(0x00000000), rs1:x19(0x00040000), rs2:x20(0x00000000)
    TEST_RR_OP(sltu, x18, x19, x20, 0x00000000, 0x40000, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_42_0)


inst_123:
    // Test 123:  Test with marching zeros/ones
    // result rd:x19(0x00000000), rs1:x20(0x00080000), rs2:x21(0x00000000)
    TEST_RR_OP(sltu, x19, x20, x21, 0x00000000, 0x80000, 0x0, x1, 0, x2)

inst_124:
    // Test 124:  Test with marching zeros/ones
    // result rd:x20(0x00000000), rs1:x21(0x00100000), rs2:x22(0x00000000)
    TEST_RR_OP(sltu, x20, x21, x22, 0x00000000, 0x100000, 0x0, x1, 4, x2)

inst_125:
    // Test 125:  Test with marching zeros/ones
    // result rd:x21(0x00000000), rs1:x22(0x00200000), rs2:x23(0x00000000)
    TEST_RR_OP(sltu, x21, x22, x23, 0x00000000, 0x200000, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_43_0)


inst_126:
    // Test 126:  Test with marching zeros/ones
    // result rd:x22(0x00000000), rs1:x23(0x00400000), rs2:x24(0x00000000)
    TEST_RR_OP(sltu, x22, x23, x24, 0x00000000, 0x400000, 0x0, x1, 0, x2)

inst_127:
    // Test 127:  Test with marching zeros/ones
    // result rd:x23(0x00000000), rs1:x24(0x00800000), rs2:x25(0x00000000)
    TEST_RR_OP(sltu, x23, x24, x25, 0x00000000, 0x800000, 0x0, x1, 4, x2)

inst_128:
    // Test 128:  Test with marching zeros/ones
    // result rd:x24(0x00000000), rs1:x25(0x01000000), rs2:x26(0x00000000)
    TEST_RR_OP(sltu, x24, x25, x26, 0x00000000, 0x1000000, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_44_0)


inst_129:
    // Test 129:  Test with marching zeros/ones
    // result rd:x25(0x00000000), rs1:x26(0x02000000), rs2:x27(0x00000000)
    TEST_RR_OP(sltu, x25, x26, x27, 0x00000000, 0x2000000, 0x0, x1, 0, x2)

inst_130:
    // Test 130:  Test with marching zeros/ones
    // result rd:x26(0x00000000), rs1:x27(0x04000000), rs2:x28(0x00000000)
    TEST_RR_OP(sltu, x26, x27, x28, 0x00000000, 0x4000000, 0x0, x1, 4, x2)

inst_131:
    // Test 131:  Test with marching zeros/ones
    // result rd:x27(0x00000000), rs1:x28(0x08000000), rs2:x29(0x00000000)
    TEST_RR_OP(sltu, x27, x28, x29, 0x00000000, 0x8000000, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x2,signature_45_0)


inst_132:
    // Test 132:  Test with marching zeros/ones
    // result rd:x28(0x00000000), rs1:x29(0x10000000), rs2:x30(0x00000000)
    TEST_RR_OP(sltu, x28, x29, x30, 0x00000000, 0x10000000, 0x0, x2, 0, x3)

inst_133:
    // Test 133:  Test with marching zeros/ones
    // result rd:x29(0x00000000), rs1:x30(0x20000000), rs2:x31(0x00000000)
    TEST_RR_OP(sltu, x29, x30, x31, 0x00000000, 0x20000000, 0x0, x2, 4, x3)

inst_134:
    // Test 134:  Test with marching zeros/ones
    // result rd:x30(0x00000000), rs1:x31(0x40000000), rs2:x1(0x00000000)
    TEST_RR_OP(sltu, x30, x31, x1, 0x00000000, 0x40000000, 0x0, x2, 8, x3)

    

    RVTEST_SIGBASE(x4,signature_46_0)


inst_135:
    // Test 135:  Test with marching zeros/ones
    // result rd:x31(0x00000000), rs1:x1(0x80000000), rs2:x2(0x00000000)
    TEST_RR_OP(sltu, x31, x1, x2, 0x00000000, 0x80000000, 0x0, x4, 0, x5)

inst_136:
    // Test 136:  Test with marching zeros/ones
    // result rd:x1(0x00000000), rs1:x2(0xfffffffe), rs2:x3(0x00000000)
    TEST_RR_OP(sltu, x1, x2, x3, 0x00000000, 0xfffffffe, 0x0, x4, 4, x5)

inst_137:
    // Test 137:  Test with marching zeros/ones
    // result rd:x1(0x00000000), rs1:x2(0xfffffffd), rs2:x3(0x00000000)
    TEST_RR_OP(sltu, x1, x2, x3, 0x00000000, 0xfffffffd, 0x0, x4, 8, x5)

    

    RVTEST_SIGBASE(x1,signature_47_0)


inst_138:
    // Test 138:  Test with marching zeros/ones
    // result rd:x2(0x00000000), rs1:x3(0xfffffffb), rs2:x4(0x00000000)
    TEST_RR_OP(sltu, x2, x3, x4, 0x00000000, 0xfffffffb, 0x0, x1, 0, x7)

inst_139:
    // Test 139:  Test with marching zeros/ones
    // result rd:x3(0x00000000), rs1:x4(0xfffffff7), rs2:x5(0x00000000)
    TEST_RR_OP(sltu, x3, x4, x5, 0x00000000, 0xfffffff7, 0x0, x1, 4, x7)

inst_140:
    // Test 140:  Test with marching zeros/ones
    // result rd:x4(0x00000000), rs1:x5(0xffffffef), rs2:x6(0x00000000)
    TEST_RR_OP(sltu, x4, x5, x6, 0x00000000, 0xffffffef, 0x0, x1, 8, x7)

    

    RVTEST_SIGBASE(x1,signature_48_0)


inst_141:
    // Test 141:  Test with marching zeros/ones
    // result rd:x5(0x00000000), rs1:x6(0xffffffdf), rs2:x7(0x00000000)
    TEST_RR_OP(sltu, x5, x6, x7, 0x00000000, 0xffffffdf, 0x0, x1, 0, x2)

inst_142:
    // Test 142:  Test with marching zeros/ones
    // result rd:x6(0x00000000), rs1:x7(0xffffffbf), rs2:x8(0x00000000)
    TEST_RR_OP(sltu, x6, x7, x8, 0x00000000, 0xffffffbf, 0x0, x1, 4, x2)

inst_143:
    // Test 143:  Test with marching zeros/ones
    // result rd:x7(0x00000000), rs1:x8(0xffffff7f), rs2:x9(0x00000000)
    TEST_RR_OP(sltu, x7, x8, x9, 0x00000000, 0xffffff7f, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_49_0)


inst_144:
    // Test 144:  Test with marching zeros/ones
    // result rd:x8(0x00000000), rs1:x9(0xfffffeff), rs2:x10(0x00000000)
    TEST_RR_OP(sltu, x8, x9, x10, 0x00000000, 0xfffffeff, 0x0, x1, 0, x2)

inst_145:
    // Test 145:  Test with marching zeros/ones
    // result rd:x9(0x00000000), rs1:x10(0xfffffdff), rs2:x11(0x00000000)
    TEST_RR_OP(sltu, x9, x10, x11, 0x00000000, 0xfffffdff, 0x0, x1, 4, x2)

inst_146:
    // Test 146:  Test with marching zeros/ones
    // result rd:x10(0x00000000), rs1:x11(0xfffffbff), rs2:x12(0x00000000)
    TEST_RR_OP(sltu, x10, x11, x12, 0x00000000, 0xfffffbff, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_50_0)


inst_147:
    // Test 147:  Test with marching zeros/ones
    // result rd:x11(0x00000000), rs1:x12(0xfffff7ff), rs2:x13(0x00000000)
    TEST_RR_OP(sltu, x11, x12, x13, 0x00000000, 0xfffff7ff, 0x0, x1, 0, x2)

inst_148:
    // Test 148:  Test with marching zeros/ones
    // result rd:x12(0x00000000), rs1:x13(0xffffefff), rs2:x14(0x00000000)
    TEST_RR_OP(sltu, x12, x13, x14, 0x00000000, 0xffffefff, 0x0, x1, 4, x2)

inst_149:
    // Test 149:  Test with marching zeros/ones
    // result rd:x13(0x00000000), rs1:x14(0xffffdfff), rs2:x15(0x00000000)
    TEST_RR_OP(sltu, x13, x14, x15, 0x00000000, 0xffffdfff, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_51_0)


inst_150:
    // Test 150:  Test with marching zeros/ones
    // result rd:x14(0x00000000), rs1:x15(0xffffbfff), rs2:x16(0x00000000)
    TEST_RR_OP(sltu, x14, x15, x16, 0x00000000, 0xffffbfff, 0x0, x1, 0, x2)

inst_151:
    // Test 151:  Test with marching zeros/ones
    // result rd:x15(0x00000000), rs1:x16(0xffff7fff), rs2:x17(0x00000000)
    TEST_RR_OP(sltu, x15, x16, x17, 0x00000000, 0xffff7fff, 0x0, x1, 4, x2)

inst_152:
    // Test 152:  Test with marching zeros/ones
    // result rd:x16(0x00000000), rs1:x17(0xfffeffff), rs2:x18(0x00000000)
    TEST_RR_OP(sltu, x16, x17, x18, 0x00000000, 0xfffeffff, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_52_0)


inst_153:
    // Test 153:  Test with marching zeros/ones
    // result rd:x17(0x00000000), rs1:x18(0xfffdffff), rs2:x19(0x00000000)
    TEST_RR_OP(sltu, x17, x18, x19, 0x00000000, 0xfffdffff, 0x0, x1, 0, x2)

inst_154:
    // Test 154:  Test with marching zeros/ones
    // result rd:x18(0x00000000), rs1:x19(0xfffbffff), rs2:x20(0x00000000)
    TEST_RR_OP(sltu, x18, x19, x20, 0x00000000, 0xfffbffff, 0x0, x1, 4, x2)

inst_155:
    // Test 155:  Test with marching zeros/ones
    // result rd:x19(0x00000000), rs1:x20(0xfff7ffff), rs2:x21(0x00000000)
    TEST_RR_OP(sltu, x19, x20, x21, 0x00000000, 0xfff7ffff, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_53_0)


inst_156:
    // Test 156:  Test with marching zeros/ones
    // result rd:x20(0x00000000), rs1:x21(0xffefffff), rs2:x22(0x00000000)
    TEST_RR_OP(sltu, x20, x21, x22, 0x00000000, 0xffefffff, 0x0, x1, 0, x2)

inst_157:
    // Test 157:  Test with marching zeros/ones
    // result rd:x21(0x00000000), rs1:x22(0xffdfffff), rs2:x23(0x00000000)
    TEST_RR_OP(sltu, x21, x22, x23, 0x00000000, 0xffdfffff, 0x0, x1, 4, x2)

inst_158:
    // Test 158:  Test with marching zeros/ones
    // result rd:x22(0x00000000), rs1:x23(0xffbfffff), rs2:x24(0x00000000)
    TEST_RR_OP(sltu, x22, x23, x24, 0x00000000, 0xffbfffff, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_54_0)


inst_159:
    // Test 159:  Test with marching zeros/ones
    // result rd:x23(0x00000000), rs1:x24(0xff7fffff), rs2:x25(0x00000000)
    TEST_RR_OP(sltu, x23, x24, x25, 0x00000000, 0xff7fffff, 0x0, x1, 0, x2)

inst_160:
    // Test 160:  Test with marching zeros/ones
    // result rd:x24(0x00000000), rs1:x25(0xfeffffff), rs2:x26(0x00000000)
    TEST_RR_OP(sltu, x24, x25, x26, 0x00000000, 0xfeffffff, 0x0, x1, 4, x2)

inst_161:
    // Test 161:  Test with marching zeros/ones
    // result rd:x25(0x00000000), rs1:x26(0xfdffffff), rs2:x27(0x00000000)
    TEST_RR_OP(sltu, x25, x26, x27, 0x00000000, 0xfdffffff, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_55_0)


inst_162:
    // Test 162:  Test with marching zeros/ones
    // result rd:x26(0x00000000), rs1:x27(0xfbffffff), rs2:x28(0x00000000)
    TEST_RR_OP(sltu, x26, x27, x28, 0x00000000, 0xfbffffff, 0x0, x1, 0, x2)

inst_163:
    // Test 163:  Test with marching zeros/ones
    // result rd:x27(0x00000000), rs1:x28(0xf7ffffff), rs2:x29(0x00000000)
    TEST_RR_OP(sltu, x27, x28, x29, 0x00000000, 0xf7ffffff, 0x0, x1, 4, x2)

inst_164:
    // Test 164:  Test with marching zeros/ones
    // result rd:x28(0x00000000), rs1:x29(0xefffffff), rs2:x30(0x00000000)
    TEST_RR_OP(sltu, x28, x29, x30, 0x00000000, 0xefffffff, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x3,signature_56_0)


inst_165:
    // Test 165:  Test with marching zeros/ones
    // result rd:x29(0x00000000), rs1:x30(0xdfffffff), rs2:x31(0x00000000)
    TEST_RR_OP(sltu, x29, x30, x31, 0x00000000, 0xdfffffff, 0x0, x3, 0, x4)

inst_166:
    // Test 166:  Test with marching zeros/ones
    // result rd:x30(0x00000000), rs1:x31(0xbfffffff), rs2:x1(0x00000000)
    TEST_RR_OP(sltu, x30, x31, x1, 0x00000000, 0xbfffffff, 0x0, x3, 4, x4)

inst_167:
    // Test 167:  Test with marching zeros/ones
    // result rd:x31(0x00000000), rs1:x1(0x7fffffff), rs2:x2(0x00000000)
    TEST_RR_OP(sltu, x31, x1, x2, 0x00000000, 0x7fffffff, 0x0, x3, 8, x4)

    

    RVTEST_SIGBASE(x1,signature_57_0)


inst_168:
    // Test 168:  Test with rs1 == rs2
    // result rd:x11(0x00000000), rs1:x9(0x316bcec8), rs2:x9(0x382ad819)
    TEST_RR_OP(sltu, x11, x9, x9, 0x00000000, 0x316bcec8, 0x382ad819, x1, 0, x2)

inst_169:
    // Test 169:  Test with rd == x0
    // result rd:x0(0x00000000), rs1:x7(0x1ce2b96b), rs2:x13(0xeec740dd)
    TEST_RR_OP(sltu, x0, x7, x13, 0x00000000, 0x1ce2b96b, 0xeec740dd, x1, 4, x2)

inst_170:
    // Test 170:  Test with rs1 == x0
    // result rd:x7(0x00000001), rs1:x0(0xcd125862), rs2:x13(0xc77cabda)
    TEST_RR_OP(sltu, x7, x0, x13, 0x00000001, 0xcd125862, 0xc77cabda, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_58_0)


inst_171:
    // Test 171:  Test with rs2 == x0
    // result rd:x24(0x00000000), rs1:x12(0x19d1202a), rs2:x0(0x27c3158f)
    TEST_RR_OP(sltu, x24, x12, x0, 0x00000000, 0x19d1202a, 0x27c3158f, x1, 0, x2)
	
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
signature_58_0:
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

