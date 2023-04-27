// RISC-V Architectural Validation Test XORI-01
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
// Description: Testing instruction 'XORI'.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32I")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN







#ifdef TEST_CASE_1

    
    RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*I.*);def TEST_CASE_1=True;",xori)

    RVTEST_SIGBASE(x1,signature_1_0)


inst_0:
    // Test 0:  Test with random values and registers (non-overlapping)
    // result rd:x19(0xab0b53cc), rs1:x28(0x54f4aeeb), imm:0xd27
    TEST_IMM_OP(xori, x19, x28, 0xab0b53cc, 0x54f4aeeb, 0xd27, x1, 0, x2)

inst_1:
    // Test 1:  Test with random values and registers (non-overlapping)
    // result rd:x30(0x1e4ee3ca), rs1:x20(0xe1b1199b), imm:0xa51
    TEST_IMM_OP(xori, x30, x20, 0x1e4ee3ca, 0xe1b1199b, 0xa51, x1, 4, x2)

inst_2:
    // Test 2:  Test with random values and registers (non-overlapping)
    // result rd:x10(0xfffffc65), rs1:x0(0xb26566a0), imm:0xc65
    TEST_IMM_OP(xori, x10, x0, 0xfffffc65, 0xb26566a0, 0xc65, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_2_0)


inst_3:
    // Test 3:  Test with random values and registers (non-overlapping)
    // result rd:x3(0x0d8ff282), rs1:x31(0xf27008e6), imm:0xa64
    TEST_IMM_OP(xori, x3, x31, 0x0d8ff282, 0xf27008e6, 0xa64, x1, 0, x2)

inst_4:
    // Test 4:  Test with random values and registers (non-overlapping)
    // result rd:x29(0xf37b78bd), rs1:x5(0x0c8484a3), imm:0xc1e
    TEST_IMM_OP(xori, x29, x5, 0xf37b78bd, 0xc8484a3, 0xc1e, x1, 4, x2)

inst_5:
    // Test 5:  Test with random values and registers (non-overlapping)
    // result rd:x0(0x00000000), rs1:x13(0xa783d03f), imm:0xadf
    TEST_IMM_OP(xori, x0, x13, 0x00000000, 0xa783d03f, 0xadf, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_3_0)


inst_6:
    // Test 6:  Test with random values and registers (non-overlapping)
    // result rd:x4(0x0284671f), rs1:x11(0xfd7b9df8), imm:0xae7
    TEST_IMM_OP(xori, x4, x11, 0x0284671f, 0xfd7b9df8, 0xae7, x1, 0, x3)

inst_7:
    // Test 7:  Test with random values and registers (non-overlapping)
    // result rd:x25(0x0afaa14c), rs1:x2(0x0afaa29d), imm:0x3d1
    TEST_IMM_OP(xori, x25, x2, 0x0afaa14c, 0xafaa29d, 0x3d1, x1, 4, x3)

inst_8:
    // Test 8:  Test with random values and registers (non-overlapping)
    // result rd:x18(0xbec0d396), rs1:x7(0x413f2c62), imm:0xff4
    TEST_IMM_OP(xori, x18, x7, 0xbec0d396, 0x413f2c62, 0xff4, x1, 8, x3)

    

    RVTEST_SIGBASE(x1,signature_4_0)


inst_9:
    // Test 9:  Test with random values and registers (non-overlapping)
    // result rd:x9(0x2c370e5a), rs1:x31(0x2c370a9a), imm:0x4c0
    TEST_IMM_OP(xori, x9, x31, 0x2c370e5a, 0x2c370a9a, 0x4c0, x1, 0, x2)

inst_10:
    // Test 10:  Test with random values and registers (non-overlapping)
    // result rd:x17(0x2882a68d), rs1:x23(0x2882a0b3), imm:0x63e
    TEST_IMM_OP(xori, x17, x23, 0x2882a68d, 0x2882a0b3, 0x63e, x1, 4, x2)

inst_11:
    // Test 11:  Test with random values and registers (non-overlapping)
    // result rd:x31(0x6e22a378), rs1:x21(0x91dd5ad6), imm:0x9ae
    TEST_IMM_OP(xori, x31, x21, 0x6e22a378, 0x91dd5ad6, 0x9ae, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_5_0)


inst_12:
    // Test 12:  Test with random values and registers (non-overlapping)
    // result rd:x0(0x00000000), rs1:x30(0x42f1d629), imm:0x650
    TEST_IMM_OP(xori, x0, x30, 0x00000000, 0x42f1d629, 0x650, x1, 0, x2)

inst_13:
    // Test 13:  Test with random values and registers (non-overlapping)
    // result rd:x0(0x00000000), rs1:x17(0xcddbdf6f), imm:0x71
    TEST_IMM_OP(xori, x0, x17, 0x00000000, 0xcddbdf6f, 0x71, x1, 4, x2)

inst_14:
    // Test 14:  Test with random values and registers (non-overlapping)
    // result rd:x31(0xb2dc9720), rs1:x6(0x4d236af8), imm:0xdd8
    TEST_IMM_OP(xori, x31, x6, 0xb2dc9720, 0x4d236af8, 0xdd8, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_6_0)


inst_15:
    // Test 15:  Test with random values and registers (non-overlapping)
    // result rd:x11(0x67c4640e), rs1:x22(0x983b9f63), imm:0xb6d
    TEST_IMM_OP(xori, x11, x22, 0x67c4640e, 0x983b9f63, 0xb6d, x1, 0, x3)

inst_16:
    // Test 16:  Test with random values and registers (non-overlapping)
    // result rd:x9(0xe041c403), rs1:x2(0x1fbe3ca6), imm:0x8a5
    TEST_IMM_OP(xori, x9, x2, 0xe041c403, 0x1fbe3ca6, 0x8a5, x1, 4, x3)

inst_17:
    // Test 17:  Test with random values and registers (non-overlapping)
    // result rd:x7(0x353a83b2), rs1:x13(0x353a8593), imm:0x621
    TEST_IMM_OP(xori, x7, x13, 0x353a83b2, 0x353a8593, 0x621, x1, 8, x3)

    

    RVTEST_SIGBASE(x1,signature_7_0)


inst_18:
    // Test 18:  Test with random values and registers (non-overlapping)
    // result rd:x7(0x99d971b2), rs1:x3(0x66268a1a), imm:0xba8
    TEST_IMM_OP(xori, x7, x3, 0x99d971b2, 0x66268a1a, 0xba8, x1, 0, x2)

inst_19:
    // Test 19:  Test with random values and registers (non-overlapping)
    // result rd:x13(0xd753acb8), rs1:x24(0x28ac54a3), imm:0x81b
    TEST_IMM_OP(xori, x13, x24, 0xd753acb8, 0x28ac54a3, 0x81b, x1, 4, x2)

inst_20:
    // Test 20:  Test with random values and registers (non-overlapping)
    // result rd:x12(0x23c8ee2e), rs1:x3(0xdc3713a2), imm:0xd8c
    TEST_IMM_OP(xori, x12, x3, 0x23c8ee2e, 0xdc3713a2, 0xd8c, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_8_0)


inst_21:
    // Test 21:  Test with random values and registers (non-overlapping)
    // result rd:x17(0x8b98bd2c), rs1:x14(0x74674399), imm:0xeb5
    TEST_IMM_OP(xori, x17, x14, 0x8b98bd2c, 0x74674399, 0xeb5, x1, 0, x2)

inst_22:
    // Test 22:  Test with random values and registers (non-overlapping)
    // result rd:x31(0x94226525), rs1:x20(0x6bdd9821), imm:0xd04
    TEST_IMM_OP(xori, x31, x20, 0x94226525, 0x6bdd9821, 0xd04, x1, 4, x2)

inst_23:
    // Test 23:  Test with random values and registers (non-overlapping)
    // result rd:x18(0x82564e62), rs1:x4(0x825648e4), imm:0x686
    TEST_IMM_OP(xori, x18, x4, 0x82564e62, 0x825648e4, 0x686, x1, 8, x2)

    

    RVTEST_SIGBASE(x2,signature_9_0)


inst_24:
    // Test 24:  Test with random values and registers (non-overlapping)
    // result rd:x29(0x840b1630), rs1:x30(0x7bf4ef1c), imm:0x92c
    TEST_IMM_OP(xori, x29, x30, 0x840b1630, 0x7bf4ef1c, 0x92c, x2, 0, x4)

inst_25:
    // Test 25:  Test with random values and registers (non-overlapping)
    // result rd:x17(0x0f49a5e4), rs1:x1(0x0f49a4b2), imm:0x156
    TEST_IMM_OP(xori, x17, x1, 0x0f49a5e4, 0xf49a4b2, 0x156, x2, 4, x4)

inst_26:
    // Test 26:  Test with random values and registers (non-overlapping)
    // result rd:x22(0xfe9b8b6b), rs1:x3(0xfe9b8abf), imm:0x1d4
    TEST_IMM_OP(xori, x22, x3, 0xfe9b8b6b, 0xfe9b8abf, 0x1d4, x2, 8, x4)

    

    RVTEST_SIGBASE(x1,signature_10_0)


inst_27:
    // Test 27:  Test with random values and registers (non-overlapping)
    // result rd:x3(0x347ebaf1), rs1:x19(0x347ebc89), imm:0x678
    TEST_IMM_OP(xori, x3, x19, 0x347ebaf1, 0x347ebc89, 0x678, x1, 0, x2)

inst_28:
    // Test 28:  Test with random values and registers (non-overlapping)
    // result rd:x15(0x0ad5af63), rs1:x13(0xf52a52bf), imm:0xddc
    TEST_IMM_OP(xori, x15, x13, 0x0ad5af63, 0xf52a52bf, 0xddc, x1, 4, x2)

inst_29:
    // Test 29:  Test with random values and registers (non-overlapping)
    // result rd:x28(0xcaa4bd3c), rs1:x6(0xcaa4b80e), imm:0x532
    TEST_IMM_OP(xori, x28, x6, 0xcaa4bd3c, 0xcaa4b80e, 0x532, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_11_0)


inst_30:
    // Test 30:  Test with min, max, and other significant values
    // result rd:x14(0xffffffff), rs1:x6(0xffffffff), imm:0x0
    TEST_IMM_OP(xori, x14, x6, 0xffffffff, 0xffffffff, 0x0, x1, 0, x2)

inst_31:
    // Test 31:  Test with min, max, and other significant values
    // result rd:x9(0x7fffffff), rs1:x17(0x80000000), imm:0xfff
    TEST_IMM_OP(xori, x9, x17, 0x7fffffff, 0x80000000, 0xfff, x1, 4, x2)

inst_32:
    // Test 32:  Test with min, max, and other significant values
    // result rd:x10(0x00000000), rs1:x14(0xffffffff), imm:0xfff
    TEST_IMM_OP(xori, x10, x14, 0x00000000, 0xffffffff, 0xfff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_12_0)


inst_33:
    // Test 33:  Test with min, max, and other significant values
    // result rd:x6(0xffffffff), rs1:x22(0x00000000), imm:0xfff
    TEST_IMM_OP(xori, x6, x22, 0xffffffff, 0x0, 0xfff, x1, 0, x2)

inst_34:
    // Test 34:  Test with min, max, and other significant values
    // result rd:x0(0x00000000), rs1:x19(0xffffffff), imm:0x0
    TEST_IMM_OP(xori, x0, x19, 0x00000000, 0xffffffff, 0x0, x1, 4, x2)

inst_35:
    // Test 35:  Test with min, max, and other significant values
    // result rd:x28(0x7fffffff), rs1:x19(0x80000000), imm:0xfff
    TEST_IMM_OP(xori, x28, x19, 0x7fffffff, 0x80000000, 0xfff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_13_0)


inst_36:
    // Test 36:  Test with min, max, and other significant values
    // result rd:x31(0x00000000), rs1:x30(0xffffffff), imm:0xfff
    TEST_IMM_OP(xori, x31, x30, 0x00000000, 0xffffffff, 0xfff, x1, 0, x2)

inst_37:
    // Test 37:  Test with min, max, and other significant values
    // result rd:x27(0xffffffff), rs1:x21(0x00000000), imm:0xfff
    TEST_IMM_OP(xori, x27, x21, 0xffffffff, 0x0, 0xfff, x1, 4, x2)

inst_38:
    // Test 38:  Test with min, max, and other significant values
    // result rd:x23(0xffffffff), rs1:x16(0xffffffff), imm:0x0
    TEST_IMM_OP(xori, x23, x16, 0xffffffff, 0xffffffff, 0x0, x1, 8, x2)

    

    RVTEST_SIGBASE(x3,signature_14_0)


inst_39:
    // Test 39:  Test with min, max, and other significant values
    // result rd:x24(0x7fffffff), rs1:x28(0x80000000), imm:0xfff
    TEST_IMM_OP(xori, x24, x28, 0x7fffffff, 0x80000000, 0xfff, x3, 0, x4)

inst_40:
    // Test 40:  Test with marching zeros/ones
    // result rd:x1(0x00000000), rs1:x2(0x00000001), imm:0x1
    TEST_IMM_OP(xori, x1, x2, 0x00000000, 0x1, 0x1, x3, 4, x4)

inst_41:
    // Test 41:  Test with marching zeros/ones
    // result rd:x1(0x00000000), rs1:x2(0x00000002), imm:0x2
    TEST_IMM_OP(xori, x1, x2, 0x00000000, 0x2, 0x2, x3, 8, x4)

    

    RVTEST_SIGBASE(x1,signature_15_0)


inst_42:
    // Test 42:  Test with marching zeros/ones
    // result rd:x2(0x00000000), rs1:x3(0x00000004), imm:0x4
    TEST_IMM_OP(xori, x2, x3, 0x00000000, 0x4, 0x4, x1, 0, x6)

inst_43:
    // Test 43:  Test with marching zeros/ones
    // result rd:x3(0x00000000), rs1:x4(0x00000008), imm:0x8
    TEST_IMM_OP(xori, x3, x4, 0x00000000, 0x8, 0x8, x1, 4, x6)

inst_44:
    // Test 44:  Test with marching zeros/ones
    // result rd:x4(0x00000000), rs1:x5(0x00000010), imm:0x10
    TEST_IMM_OP(xori, x4, x5, 0x00000000, 0x10, 0x10, x1, 8, x6)

    

    RVTEST_SIGBASE(x1,signature_16_0)


inst_45:
    // Test 45:  Test with marching zeros/ones
    // result rd:x5(0x00000000), rs1:x6(0x00000020), imm:0x20
    TEST_IMM_OP(xori, x5, x6, 0x00000000, 0x20, 0x20, x1, 0, x2)

inst_46:
    // Test 46:  Test with marching zeros/ones
    // result rd:x6(0x00000000), rs1:x7(0x00000040), imm:0x40
    TEST_IMM_OP(xori, x6, x7, 0x00000000, 0x40, 0x40, x1, 4, x2)

inst_47:
    // Test 47:  Test with marching zeros/ones
    // result rd:x7(0x00000000), rs1:x8(0x00000080), imm:0x80
    TEST_IMM_OP(xori, x7, x8, 0x00000000, 0x80, 0x80, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_17_0)


inst_48:
    // Test 48:  Test with marching zeros/ones
    // result rd:x8(0x00000000), rs1:x9(0x00000100), imm:0x100
    TEST_IMM_OP(xori, x8, x9, 0x00000000, 0x100, 0x100, x1, 0, x2)

inst_49:
    // Test 49:  Test with marching zeros/ones
    // result rd:x9(0x00000000), rs1:x10(0x00000200), imm:0x200
    TEST_IMM_OP(xori, x9, x10, 0x00000000, 0x200, 0x200, x1, 4, x2)

inst_50:
    // Test 50:  Test with marching zeros/ones
    // result rd:x10(0x00000000), rs1:x11(0x00000400), imm:0x400
    TEST_IMM_OP(xori, x10, x11, 0x00000000, 0x400, 0x400, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_18_0)


inst_51:
    // Test 51:  Test with marching zeros/ones
    // result rd:x11(0xfffff000), rs1:x12(0x00000800), imm:0x800
    TEST_IMM_OP(xori, x11, x12, 0xfffff000, 0x800, 0x800, x1, 0, x2)

inst_52:
    // Test 52:  Test with marching zeros/ones
    // result rd:x12(0xffffeffe), rs1:x13(0x00001000), imm:0xffe
    TEST_IMM_OP(xori, x12, x13, 0xffffeffe, 0x1000, 0xffe, x1, 4, x2)

inst_53:
    // Test 53:  Test with marching zeros/ones
    // result rd:x13(0xffffdffd), rs1:x14(0x00002000), imm:0xffd
    TEST_IMM_OP(xori, x13, x14, 0xffffdffd, 0x2000, 0xffd, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_19_0)


inst_54:
    // Test 54:  Test with marching zeros/ones
    // result rd:x14(0xffffbffb), rs1:x15(0x00004000), imm:0xffb
    TEST_IMM_OP(xori, x14, x15, 0xffffbffb, 0x4000, 0xffb, x1, 0, x2)

inst_55:
    // Test 55:  Test with marching zeros/ones
    // result rd:x15(0xffff7ff7), rs1:x16(0x00008000), imm:0xff7
    TEST_IMM_OP(xori, x15, x16, 0xffff7ff7, 0x8000, 0xff7, x1, 4, x2)

inst_56:
    // Test 56:  Test with marching zeros/ones
    // result rd:x16(0xfffeffef), rs1:x17(0x00010000), imm:0xfef
    TEST_IMM_OP(xori, x16, x17, 0xfffeffef, 0x10000, 0xfef, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_20_0)


inst_57:
    // Test 57:  Test with marching zeros/ones
    // result rd:x17(0xfffdffdf), rs1:x18(0x00020000), imm:0xfdf
    TEST_IMM_OP(xori, x17, x18, 0xfffdffdf, 0x20000, 0xfdf, x1, 0, x2)

inst_58:
    // Test 58:  Test with marching zeros/ones
    // result rd:x18(0xfffbffbf), rs1:x19(0x00040000), imm:0xfbf
    TEST_IMM_OP(xori, x18, x19, 0xfffbffbf, 0x40000, 0xfbf, x1, 4, x2)

inst_59:
    // Test 59:  Test with marching zeros/ones
    // result rd:x19(0xfff7ff7f), rs1:x20(0x00080000), imm:0xf7f
    TEST_IMM_OP(xori, x19, x20, 0xfff7ff7f, 0x80000, 0xf7f, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_21_0)


inst_60:
    // Test 60:  Test with marching zeros/ones
    // result rd:x20(0xffeffeff), rs1:x21(0x00100000), imm:0xeff
    TEST_IMM_OP(xori, x20, x21, 0xffeffeff, 0x100000, 0xeff, x1, 0, x2)

inst_61:
    // Test 61:  Test with marching zeros/ones
    // result rd:x21(0xffdffdff), rs1:x22(0x00200000), imm:0xdff
    TEST_IMM_OP(xori, x21, x22, 0xffdffdff, 0x200000, 0xdff, x1, 4, x2)

inst_62:
    // Test 62:  Test with marching zeros/ones
    // result rd:x22(0xffbffbff), rs1:x23(0x00400000), imm:0xbff
    TEST_IMM_OP(xori, x22, x23, 0xffbffbff, 0x400000, 0xbff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_22_0)


inst_63:
    // Test 63:  Test with marching zeros/ones
    // result rd:x23(0x008007ff), rs1:x24(0x00800000), imm:0x7ff
    TEST_IMM_OP(xori, x23, x24, 0x008007ff, 0x800000, 0x7ff, x1, 0, x2)

inst_64:
    // Test 64:  Test with marching zeros/ones
    // result rd:x24(0xfefffffe), rs1:x25(0x01000000), imm:0xffe
    TEST_IMM_OP(xori, x24, x25, 0xfefffffe, 0x1000000, 0xffe, x1, 4, x2)

inst_65:
    // Test 65:  Test with marching zeros/ones
    // result rd:x25(0xfdfffffd), rs1:x26(0x02000000), imm:0xffd
    TEST_IMM_OP(xori, x25, x26, 0xfdfffffd, 0x2000000, 0xffd, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_23_0)


inst_66:
    // Test 66:  Test with marching zeros/ones
    // result rd:x26(0xfbfffffb), rs1:x27(0x04000000), imm:0xffb
    TEST_IMM_OP(xori, x26, x27, 0xfbfffffb, 0x4000000, 0xffb, x1, 0, x2)

inst_67:
    // Test 67:  Test with marching zeros/ones
    // result rd:x27(0xf7fffff7), rs1:x28(0x08000000), imm:0xff7
    TEST_IMM_OP(xori, x27, x28, 0xf7fffff7, 0x8000000, 0xff7, x1, 4, x2)

inst_68:
    // Test 68:  Test with marching zeros/ones
    // result rd:x28(0xefffffef), rs1:x29(0x10000000), imm:0xfef
    TEST_IMM_OP(xori, x28, x29, 0xefffffef, 0x10000000, 0xfef, x1, 8, x2)

    

    RVTEST_SIGBASE(x2,signature_24_0)


inst_69:
    // Test 69:  Test with marching zeros/ones
    // result rd:x29(0xdfffffdf), rs1:x30(0x20000000), imm:0xfdf
    TEST_IMM_OP(xori, x29, x30, 0xdfffffdf, 0x20000000, 0xfdf, x2, 0, x3)

inst_70:
    // Test 70:  Test with marching zeros/ones
    // result rd:x30(0xbfffffbf), rs1:x31(0x40000000), imm:0xfbf
    TEST_IMM_OP(xori, x30, x31, 0xbfffffbf, 0x40000000, 0xfbf, x2, 4, x3)

inst_71:
    // Test 71:  Test with marching zeros/ones
    // result rd:x31(0x7fffff7f), rs1:x1(0x80000000), imm:0xf7f
    TEST_IMM_OP(xori, x31, x1, 0x7fffff7f, 0x80000000, 0xf7f, x2, 8, x3)

    

    RVTEST_SIGBASE(x4,signature_25_0)


inst_72:
    // Test 72:  Test with marching zeros/ones
    // result rd:x1(0x00000101), rs1:x2(0xfffffffe), imm:0xeff
    TEST_IMM_OP(xori, x1, x2, 0x00000101, 0xfffffffe, 0xeff, x4, 0, x5)

inst_73:
    // Test 73:  Test with marching zeros/ones
    // result rd:x1(0x00000202), rs1:x2(0xfffffffd), imm:0xdff
    TEST_IMM_OP(xori, x1, x2, 0x00000202, 0xfffffffd, 0xdff, x4, 4, x5)

inst_74:
    // Test 74:  Test with marching zeros/ones
    // result rd:x2(0x00000404), rs1:x3(0xfffffffb), imm:0xbff
    TEST_IMM_OP(xori, x2, x3, 0x00000404, 0xfffffffb, 0xbff, x4, 8, x5)

    

    RVTEST_SIGBASE(x1,signature_26_0)


inst_75:
    // Test 75:  Test with marching zeros/ones
    // result rd:x3(0xfffff808), rs1:x4(0xfffffff7), imm:0x7ff
    TEST_IMM_OP(xori, x3, x4, 0xfffff808, 0xfffffff7, 0x7ff, x1, 0, x2)

inst_76:
    // Test 76:  Test with marching zeros/ones
    // result rd:x4(0x00000011), rs1:x5(0xffffffef), imm:0xffe
    TEST_IMM_OP(xori, x4, x5, 0x00000011, 0xffffffef, 0xffe, x1, 4, x2)

inst_77:
    // Test 77:  Test with marching zeros/ones
    // result rd:x5(0x00000022), rs1:x6(0xffffffdf), imm:0xffd
    TEST_IMM_OP(xori, x5, x6, 0x00000022, 0xffffffdf, 0xffd, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_27_0)


inst_78:
    // Test 78:  Test with marching zeros/ones
    // result rd:x6(0x00000044), rs1:x7(0xffffffbf), imm:0xffb
    TEST_IMM_OP(xori, x6, x7, 0x00000044, 0xffffffbf, 0xffb, x1, 0, x2)

inst_79:
    // Test 79:  Test with marching zeros/ones
    // result rd:x7(0x00000088), rs1:x8(0xffffff7f), imm:0xff7
    TEST_IMM_OP(xori, x7, x8, 0x00000088, 0xffffff7f, 0xff7, x1, 4, x2)

inst_80:
    // Test 80:  Test with marching zeros/ones
    // result rd:x8(0x00000110), rs1:x9(0xfffffeff), imm:0xfef
    TEST_IMM_OP(xori, x8, x9, 0x00000110, 0xfffffeff, 0xfef, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_28_0)


inst_81:
    // Test 81:  Test with marching zeros/ones
    // result rd:x9(0x00000220), rs1:x10(0xfffffdff), imm:0xfdf
    TEST_IMM_OP(xori, x9, x10, 0x00000220, 0xfffffdff, 0xfdf, x1, 0, x2)

inst_82:
    // Test 82:  Test with marching zeros/ones
    // result rd:x10(0x00000440), rs1:x11(0xfffffbff), imm:0xfbf
    TEST_IMM_OP(xori, x10, x11, 0x00000440, 0xfffffbff, 0xfbf, x1, 4, x2)

inst_83:
    // Test 83:  Test with marching zeros/ones
    // result rd:x11(0x00000880), rs1:x12(0xfffff7ff), imm:0xf7f
    TEST_IMM_OP(xori, x11, x12, 0x00000880, 0xfffff7ff, 0xf7f, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_29_0)


inst_84:
    // Test 84:  Test with marching zeros/ones
    // result rd:x12(0x00001100), rs1:x13(0xffffefff), imm:0xeff
    TEST_IMM_OP(xori, x12, x13, 0x00001100, 0xffffefff, 0xeff, x1, 0, x2)

inst_85:
    // Test 85:  Test with marching zeros/ones
    // result rd:x13(0x00002200), rs1:x14(0xffffdfff), imm:0xdff
    TEST_IMM_OP(xori, x13, x14, 0x00002200, 0xffffdfff, 0xdff, x1, 4, x2)

inst_86:
    // Test 86:  Test with marching zeros/ones
    // result rd:x14(0x00004400), rs1:x15(0xffffbfff), imm:0xbff
    TEST_IMM_OP(xori, x14, x15, 0x00004400, 0xffffbfff, 0xbff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_30_0)


inst_87:
    // Test 87:  Test with marching zeros/ones
    // result rd:x15(0xffff7800), rs1:x16(0xffff7fff), imm:0x7ff
    TEST_IMM_OP(xori, x15, x16, 0xffff7800, 0xffff7fff, 0x7ff, x1, 0, x2)

inst_88:
    // Test 88:  Test with marching zeros/ones
    // result rd:x16(0x00010001), rs1:x17(0xfffeffff), imm:0xffe
    TEST_IMM_OP(xori, x16, x17, 0x00010001, 0xfffeffff, 0xffe, x1, 4, x2)

inst_89:
    // Test 89:  Test with marching zeros/ones
    // result rd:x17(0x00020002), rs1:x18(0xfffdffff), imm:0xffd
    TEST_IMM_OP(xori, x17, x18, 0x00020002, 0xfffdffff, 0xffd, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_31_0)


inst_90:
    // Test 90:  Test with marching zeros/ones
    // result rd:x18(0x00040004), rs1:x19(0xfffbffff), imm:0xffb
    TEST_IMM_OP(xori, x18, x19, 0x00040004, 0xfffbffff, 0xffb, x1, 0, x2)

inst_91:
    // Test 91:  Test with marching zeros/ones
    // result rd:x19(0x00080008), rs1:x20(0xfff7ffff), imm:0xff7
    TEST_IMM_OP(xori, x19, x20, 0x00080008, 0xfff7ffff, 0xff7, x1, 4, x2)

inst_92:
    // Test 92:  Test with marching zeros/ones
    // result rd:x20(0x00100010), rs1:x21(0xffefffff), imm:0xfef
    TEST_IMM_OP(xori, x20, x21, 0x00100010, 0xffefffff, 0xfef, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_32_0)


inst_93:
    // Test 93:  Test with marching zeros/ones
    // result rd:x21(0x00200020), rs1:x22(0xffdfffff), imm:0xfdf
    TEST_IMM_OP(xori, x21, x22, 0x00200020, 0xffdfffff, 0xfdf, x1, 0, x2)

inst_94:
    // Test 94:  Test with marching zeros/ones
    // result rd:x22(0x00400040), rs1:x23(0xffbfffff), imm:0xfbf
    TEST_IMM_OP(xori, x22, x23, 0x00400040, 0xffbfffff, 0xfbf, x1, 4, x2)

inst_95:
    // Test 95:  Test with marching zeros/ones
    // result rd:x23(0x00800080), rs1:x24(0xff7fffff), imm:0xf7f
    TEST_IMM_OP(xori, x23, x24, 0x00800080, 0xff7fffff, 0xf7f, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_33_0)


inst_96:
    // Test 96:  Test with marching zeros/ones
    // result rd:x24(0x01000100), rs1:x25(0xfeffffff), imm:0xeff
    TEST_IMM_OP(xori, x24, x25, 0x01000100, 0xfeffffff, 0xeff, x1, 0, x2)

inst_97:
    // Test 97:  Test with marching zeros/ones
    // result rd:x25(0x02000200), rs1:x26(0xfdffffff), imm:0xdff
    TEST_IMM_OP(xori, x25, x26, 0x02000200, 0xfdffffff, 0xdff, x1, 4, x2)

inst_98:
    // Test 98:  Test with marching zeros/ones
    // result rd:x26(0x04000400), rs1:x27(0xfbffffff), imm:0xbff
    TEST_IMM_OP(xori, x26, x27, 0x04000400, 0xfbffffff, 0xbff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_34_0)


inst_99:
    // Test 99:  Test with marching zeros/ones
    // result rd:x27(0xf7fff800), rs1:x28(0xf7ffffff), imm:0x7ff
    TEST_IMM_OP(xori, x27, x28, 0xf7fff800, 0xf7ffffff, 0x7ff, x1, 0, x2)

inst_100:
    // Test 100:  Test with marching zeros/ones
    // result rd:x28(0x10000001), rs1:x29(0xefffffff), imm:0xffe
    TEST_IMM_OP(xori, x28, x29, 0x10000001, 0xefffffff, 0xffe, x1, 4, x2)

inst_101:
    // Test 101:  Test with marching zeros/ones
    // result rd:x29(0x20000002), rs1:x30(0xdfffffff), imm:0xffd
    TEST_IMM_OP(xori, x29, x30, 0x20000002, 0xdfffffff, 0xffd, x1, 8, x2)

    

    RVTEST_SIGBASE(x3,signature_35_0)


inst_102:
    // Test 102:  Test with marching zeros/ones
    // result rd:x30(0x40000004), rs1:x31(0xbfffffff), imm:0xffb
    TEST_IMM_OP(xori, x30, x31, 0x40000004, 0xbfffffff, 0xffb, x3, 0, x4)

inst_103:
    // Test 103:  Test with marching zeros/ones
    // result rd:x31(0x80000008), rs1:x1(0x7fffffff), imm:0xff7
    TEST_IMM_OP(xori, x31, x1, 0x80000008, 0x7fffffff, 0xff7, x3, 4, x4)

inst_104:
    // Test 104:  Test with marching zeros/ones
    // result rd:x1(0x00000000), rs1:x2(0x00000001), imm:0x1
    TEST_IMM_OP(xori, x1, x2, 0x00000000, 0x1, 0x1, x3, 8, x4)

    

    RVTEST_SIGBASE(x5,signature_36_0)


inst_105:
    // Test 105:  Test with marching zeros/ones
    // result rd:x1(0x00000000), rs1:x2(0x00000002), imm:0x2
    TEST_IMM_OP(xori, x1, x2, 0x00000000, 0x2, 0x2, x5, 0, x6)

inst_106:
    // Test 106:  Test with marching zeros/ones
    // result rd:x2(0x00000000), rs1:x3(0x00000004), imm:0x4
    TEST_IMM_OP(xori, x2, x3, 0x00000000, 0x4, 0x4, x5, 4, x6)

inst_107:
    // Test 107:  Test with marching zeros/ones
    // result rd:x3(0x00000000), rs1:x4(0x00000008), imm:0x8
    TEST_IMM_OP(xori, x3, x4, 0x00000000, 0x8, 0x8, x5, 8, x6)

    

    RVTEST_SIGBASE(x1,signature_37_0)


inst_108:
    // Test 108:  Test with marching zeros/ones
    // result rd:x4(0x00000000), rs1:x5(0x00000010), imm:0x10
    TEST_IMM_OP(xori, x4, x5, 0x00000000, 0x10, 0x10, x1, 0, x2)

inst_109:
    // Test 109:  Test with marching zeros/ones
    // result rd:x5(0x00000000), rs1:x6(0x00000020), imm:0x20
    TEST_IMM_OP(xori, x5, x6, 0x00000000, 0x20, 0x20, x1, 4, x2)

inst_110:
    // Test 110:  Test with marching zeros/ones
    // result rd:x6(0x00000000), rs1:x7(0x00000040), imm:0x40
    TEST_IMM_OP(xori, x6, x7, 0x00000000, 0x40, 0x40, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_38_0)


inst_111:
    // Test 111:  Test with marching zeros/ones
    // result rd:x7(0x00000000), rs1:x8(0x00000080), imm:0x80
    TEST_IMM_OP(xori, x7, x8, 0x00000000, 0x80, 0x80, x1, 0, x2)

inst_112:
    // Test 112:  Test with marching zeros/ones
    // result rd:x8(0x00000000), rs1:x9(0x00000100), imm:0x100
    TEST_IMM_OP(xori, x8, x9, 0x00000000, 0x100, 0x100, x1, 4, x2)

inst_113:
    // Test 113:  Test with marching zeros/ones
    // result rd:x9(0x00000000), rs1:x10(0x00000200), imm:0x200
    TEST_IMM_OP(xori, x9, x10, 0x00000000, 0x200, 0x200, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_39_0)


inst_114:
    // Test 114:  Test with marching zeros/ones
    // result rd:x10(0x00000000), rs1:x11(0x00000400), imm:0x400
    TEST_IMM_OP(xori, x10, x11, 0x00000000, 0x400, 0x400, x1, 0, x2)

inst_115:
    // Test 115:  Test with marching zeros/ones
    // result rd:x11(0xfffff000), rs1:x12(0x00000800), imm:0x800
    TEST_IMM_OP(xori, x11, x12, 0xfffff000, 0x800, 0x800, x1, 4, x2)

inst_116:
    // Test 116:  Test with marching zeros/ones
    // result rd:x12(0xffffeffe), rs1:x13(0x00001000), imm:0xffe
    TEST_IMM_OP(xori, x12, x13, 0xffffeffe, 0x1000, 0xffe, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_40_0)


inst_117:
    // Test 117:  Test with marching zeros/ones
    // result rd:x13(0xffffdffd), rs1:x14(0x00002000), imm:0xffd
    TEST_IMM_OP(xori, x13, x14, 0xffffdffd, 0x2000, 0xffd, x1, 0, x2)

inst_118:
    // Test 118:  Test with marching zeros/ones
    // result rd:x14(0xffffbffb), rs1:x15(0x00004000), imm:0xffb
    TEST_IMM_OP(xori, x14, x15, 0xffffbffb, 0x4000, 0xffb, x1, 4, x2)

inst_119:
    // Test 119:  Test with marching zeros/ones
    // result rd:x15(0xffff7ff7), rs1:x16(0x00008000), imm:0xff7
    TEST_IMM_OP(xori, x15, x16, 0xffff7ff7, 0x8000, 0xff7, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_41_0)


inst_120:
    // Test 120:  Test with marching zeros/ones
    // result rd:x16(0xfffeffef), rs1:x17(0x00010000), imm:0xfef
    TEST_IMM_OP(xori, x16, x17, 0xfffeffef, 0x10000, 0xfef, x1, 0, x2)

inst_121:
    // Test 121:  Test with marching zeros/ones
    // result rd:x17(0xfffdffdf), rs1:x18(0x00020000), imm:0xfdf
    TEST_IMM_OP(xori, x17, x18, 0xfffdffdf, 0x20000, 0xfdf, x1, 4, x2)

inst_122:
    // Test 122:  Test with marching zeros/ones
    // result rd:x18(0xfffbffbf), rs1:x19(0x00040000), imm:0xfbf
    TEST_IMM_OP(xori, x18, x19, 0xfffbffbf, 0x40000, 0xfbf, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_42_0)


inst_123:
    // Test 123:  Test with marching zeros/ones
    // result rd:x19(0xfff7ff7f), rs1:x20(0x00080000), imm:0xf7f
    TEST_IMM_OP(xori, x19, x20, 0xfff7ff7f, 0x80000, 0xf7f, x1, 0, x2)

inst_124:
    // Test 124:  Test with marching zeros/ones
    // result rd:x20(0xffeffeff), rs1:x21(0x00100000), imm:0xeff
    TEST_IMM_OP(xori, x20, x21, 0xffeffeff, 0x100000, 0xeff, x1, 4, x2)

inst_125:
    // Test 125:  Test with marching zeros/ones
    // result rd:x21(0xffdffdff), rs1:x22(0x00200000), imm:0xdff
    TEST_IMM_OP(xori, x21, x22, 0xffdffdff, 0x200000, 0xdff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_43_0)


inst_126:
    // Test 126:  Test with marching zeros/ones
    // result rd:x22(0xffbffbff), rs1:x23(0x00400000), imm:0xbff
    TEST_IMM_OP(xori, x22, x23, 0xffbffbff, 0x400000, 0xbff, x1, 0, x2)

inst_127:
    // Test 127:  Test with marching zeros/ones
    // result rd:x23(0x008007ff), rs1:x24(0x00800000), imm:0x7ff
    TEST_IMM_OP(xori, x23, x24, 0x008007ff, 0x800000, 0x7ff, x1, 4, x2)

inst_128:
    // Test 128:  Test with marching zeros/ones
    // result rd:x24(0xfefffffe), rs1:x25(0x01000000), imm:0xffe
    TEST_IMM_OP(xori, x24, x25, 0xfefffffe, 0x1000000, 0xffe, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_44_0)


inst_129:
    // Test 129:  Test with marching zeros/ones
    // result rd:x25(0xfdfffffd), rs1:x26(0x02000000), imm:0xffd
    TEST_IMM_OP(xori, x25, x26, 0xfdfffffd, 0x2000000, 0xffd, x1, 0, x2)

inst_130:
    // Test 130:  Test with marching zeros/ones
    // result rd:x26(0xfbfffffb), rs1:x27(0x04000000), imm:0xffb
    TEST_IMM_OP(xori, x26, x27, 0xfbfffffb, 0x4000000, 0xffb, x1, 4, x2)

inst_131:
    // Test 131:  Test with marching zeros/ones
    // result rd:x27(0xf7fffff7), rs1:x28(0x08000000), imm:0xff7
    TEST_IMM_OP(xori, x27, x28, 0xf7fffff7, 0x8000000, 0xff7, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_45_0)


inst_132:
    // Test 132:  Test with marching zeros/ones
    // result rd:x28(0xefffffef), rs1:x29(0x10000000), imm:0xfef
    TEST_IMM_OP(xori, x28, x29, 0xefffffef, 0x10000000, 0xfef, x1, 0, x2)

inst_133:
    // Test 133:  Test with marching zeros/ones
    // result rd:x29(0xdfffffdf), rs1:x30(0x20000000), imm:0xfdf
    TEST_IMM_OP(xori, x29, x30, 0xdfffffdf, 0x20000000, 0xfdf, x1, 4, x2)

inst_134:
    // Test 134:  Test with marching zeros/ones
    // result rd:x30(0xbfffffbf), rs1:x31(0x40000000), imm:0xfbf
    TEST_IMM_OP(xori, x30, x31, 0xbfffffbf, 0x40000000, 0xfbf, x1, 8, x2)

    

    RVTEST_SIGBASE(x3,signature_46_0)


inst_135:
    // Test 135:  Test with marching zeros/ones
    // result rd:x31(0x7fffff7f), rs1:x1(0x80000000), imm:0xf7f
    TEST_IMM_OP(xori, x31, x1, 0x7fffff7f, 0x80000000, 0xf7f, x3, 0, x4)

inst_136:
    // Test 136:  Test with marching zeros/ones
    // result rd:x1(0x00000101), rs1:x2(0xfffffffe), imm:0xeff
    TEST_IMM_OP(xori, x1, x2, 0x00000101, 0xfffffffe, 0xeff, x3, 4, x4)

inst_137:
    // Test 137:  Test with marching zeros/ones
    // result rd:x1(0x00000202), rs1:x2(0xfffffffd), imm:0xdff
    TEST_IMM_OP(xori, x1, x2, 0x00000202, 0xfffffffd, 0xdff, x3, 8, x4)

    

    RVTEST_SIGBASE(x1,signature_47_0)


inst_138:
    // Test 138:  Test with marching zeros/ones
    // result rd:x2(0x00000404), rs1:x3(0xfffffffb), imm:0xbff
    TEST_IMM_OP(xori, x2, x3, 0x00000404, 0xfffffffb, 0xbff, x1, 0, x6)

inst_139:
    // Test 139:  Test with marching zeros/ones
    // result rd:x3(0xfffff808), rs1:x4(0xfffffff7), imm:0x7ff
    TEST_IMM_OP(xori, x3, x4, 0xfffff808, 0xfffffff7, 0x7ff, x1, 4, x6)

inst_140:
    // Test 140:  Test with marching zeros/ones
    // result rd:x4(0x00000011), rs1:x5(0xffffffef), imm:0xffe
    TEST_IMM_OP(xori, x4, x5, 0x00000011, 0xffffffef, 0xffe, x1, 8, x6)

    

    RVTEST_SIGBASE(x1,signature_48_0)


inst_141:
    // Test 141:  Test with marching zeros/ones
    // result rd:x5(0x00000022), rs1:x6(0xffffffdf), imm:0xffd
    TEST_IMM_OP(xori, x5, x6, 0x00000022, 0xffffffdf, 0xffd, x1, 0, x2)

inst_142:
    // Test 142:  Test with marching zeros/ones
    // result rd:x6(0x00000044), rs1:x7(0xffffffbf), imm:0xffb
    TEST_IMM_OP(xori, x6, x7, 0x00000044, 0xffffffbf, 0xffb, x1, 4, x2)

inst_143:
    // Test 143:  Test with marching zeros/ones
    // result rd:x7(0x00000088), rs1:x8(0xffffff7f), imm:0xff7
    TEST_IMM_OP(xori, x7, x8, 0x00000088, 0xffffff7f, 0xff7, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_49_0)


inst_144:
    // Test 144:  Test with marching zeros/ones
    // result rd:x8(0x00000110), rs1:x9(0xfffffeff), imm:0xfef
    TEST_IMM_OP(xori, x8, x9, 0x00000110, 0xfffffeff, 0xfef, x1, 0, x2)

inst_145:
    // Test 145:  Test with marching zeros/ones
    // result rd:x9(0x00000220), rs1:x10(0xfffffdff), imm:0xfdf
    TEST_IMM_OP(xori, x9, x10, 0x00000220, 0xfffffdff, 0xfdf, x1, 4, x2)

inst_146:
    // Test 146:  Test with marching zeros/ones
    // result rd:x10(0x00000440), rs1:x11(0xfffffbff), imm:0xfbf
    TEST_IMM_OP(xori, x10, x11, 0x00000440, 0xfffffbff, 0xfbf, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_50_0)


inst_147:
    // Test 147:  Test with marching zeros/ones
    // result rd:x11(0x00000880), rs1:x12(0xfffff7ff), imm:0xf7f
    TEST_IMM_OP(xori, x11, x12, 0x00000880, 0xfffff7ff, 0xf7f, x1, 0, x2)

inst_148:
    // Test 148:  Test with marching zeros/ones
    // result rd:x12(0x00001100), rs1:x13(0xffffefff), imm:0xeff
    TEST_IMM_OP(xori, x12, x13, 0x00001100, 0xffffefff, 0xeff, x1, 4, x2)

inst_149:
    // Test 149:  Test with marching zeros/ones
    // result rd:x13(0x00002200), rs1:x14(0xffffdfff), imm:0xdff
    TEST_IMM_OP(xori, x13, x14, 0x00002200, 0xffffdfff, 0xdff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_51_0)


inst_150:
    // Test 150:  Test with marching zeros/ones
    // result rd:x14(0x00004400), rs1:x15(0xffffbfff), imm:0xbff
    TEST_IMM_OP(xori, x14, x15, 0x00004400, 0xffffbfff, 0xbff, x1, 0, x2)

inst_151:
    // Test 151:  Test with marching zeros/ones
    // result rd:x15(0xffff7800), rs1:x16(0xffff7fff), imm:0x7ff
    TEST_IMM_OP(xori, x15, x16, 0xffff7800, 0xffff7fff, 0x7ff, x1, 4, x2)

inst_152:
    // Test 152:  Test with marching zeros/ones
    // result rd:x16(0x00010001), rs1:x17(0xfffeffff), imm:0xffe
    TEST_IMM_OP(xori, x16, x17, 0x00010001, 0xfffeffff, 0xffe, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_52_0)


inst_153:
    // Test 153:  Test with marching zeros/ones
    // result rd:x17(0x00020002), rs1:x18(0xfffdffff), imm:0xffd
    TEST_IMM_OP(xori, x17, x18, 0x00020002, 0xfffdffff, 0xffd, x1, 0, x2)

inst_154:
    // Test 154:  Test with marching zeros/ones
    // result rd:x18(0x00040004), rs1:x19(0xfffbffff), imm:0xffb
    TEST_IMM_OP(xori, x18, x19, 0x00040004, 0xfffbffff, 0xffb, x1, 4, x2)

inst_155:
    // Test 155:  Test with marching zeros/ones
    // result rd:x19(0x00080008), rs1:x20(0xfff7ffff), imm:0xff7
    TEST_IMM_OP(xori, x19, x20, 0x00080008, 0xfff7ffff, 0xff7, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_53_0)


inst_156:
    // Test 156:  Test with marching zeros/ones
    // result rd:x20(0x00100010), rs1:x21(0xffefffff), imm:0xfef
    TEST_IMM_OP(xori, x20, x21, 0x00100010, 0xffefffff, 0xfef, x1, 0, x2)

inst_157:
    // Test 157:  Test with marching zeros/ones
    // result rd:x21(0x00200020), rs1:x22(0xffdfffff), imm:0xfdf
    TEST_IMM_OP(xori, x21, x22, 0x00200020, 0xffdfffff, 0xfdf, x1, 4, x2)

inst_158:
    // Test 158:  Test with marching zeros/ones
    // result rd:x22(0x00400040), rs1:x23(0xffbfffff), imm:0xfbf
    TEST_IMM_OP(xori, x22, x23, 0x00400040, 0xffbfffff, 0xfbf, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_54_0)


inst_159:
    // Test 159:  Test with marching zeros/ones
    // result rd:x23(0x00800080), rs1:x24(0xff7fffff), imm:0xf7f
    TEST_IMM_OP(xori, x23, x24, 0x00800080, 0xff7fffff, 0xf7f, x1, 0, x2)

inst_160:
    // Test 160:  Test with marching zeros/ones
    // result rd:x24(0x01000100), rs1:x25(0xfeffffff), imm:0xeff
    TEST_IMM_OP(xori, x24, x25, 0x01000100, 0xfeffffff, 0xeff, x1, 4, x2)

inst_161:
    // Test 161:  Test with marching zeros/ones
    // result rd:x25(0x02000200), rs1:x26(0xfdffffff), imm:0xdff
    TEST_IMM_OP(xori, x25, x26, 0x02000200, 0xfdffffff, 0xdff, x1, 8, x2)

    

    RVTEST_SIGBASE(x1,signature_55_0)


inst_162:
    // Test 162:  Test with marching zeros/ones
    // result rd:x26(0x04000400), rs1:x27(0xfbffffff), imm:0xbff
    TEST_IMM_OP(xori, x26, x27, 0x04000400, 0xfbffffff, 0xbff, x1, 0, x2)

inst_163:
    // Test 163:  Test with marching zeros/ones
    // result rd:x27(0xf7fff800), rs1:x28(0xf7ffffff), imm:0x7ff
    TEST_IMM_OP(xori, x27, x28, 0xf7fff800, 0xf7ffffff, 0x7ff, x1, 4, x2)

inst_164:
    // Test 164:  Test with marching zeros/ones
    // result rd:x28(0x10000001), rs1:x29(0xefffffff), imm:0xffe
    TEST_IMM_OP(xori, x28, x29, 0x10000001, 0xefffffff, 0xffe, x1, 8, x2)

    

    RVTEST_SIGBASE(x2,signature_56_0)


inst_165:
    // Test 165:  Test with marching zeros/ones
    // result rd:x29(0x20000002), rs1:x30(0xdfffffff), imm:0xffd
    TEST_IMM_OP(xori, x29, x30, 0x20000002, 0xdfffffff, 0xffd, x2, 0, x3)

inst_166:
    // Test 166:  Test with marching zeros/ones
    // result rd:x30(0x40000004), rs1:x31(0xbfffffff), imm:0xffb
    TEST_IMM_OP(xori, x30, x31, 0x40000004, 0xbfffffff, 0xffb, x2, 4, x3)

inst_167:
    // Test 167:  Test with marching zeros/ones
    // result rd:x31(0x80000008), rs1:x1(0x7fffffff), imm:0xff7
    TEST_IMM_OP(xori, x31, x1, 0x80000008, 0x7fffffff, 0xff7, x2, 8, x3)

    

    RVTEST_SIGBASE(x1,signature_57_0)


inst_168:
    // Test 168:  Test with rd == x0
    // result rd:x0(0x00000000), rs1:x2(0x1ce2b96b), imm:0x497
    TEST_IMM_OP(xori, x0, x2, 0x00000000, 0x1ce2b96b, 0x497, x1, 0, x3)

inst_169:
    // Test 169:  Test with rs1 == x0
    // result rd:x7(0x000006a1), rs1:x0(0xcd125862), imm:0x6a1
    TEST_IMM_OP(xori, x7, x0, 0x000006a1, 0xcd125862, 0x6a1, x1, 4, x3)
	
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

