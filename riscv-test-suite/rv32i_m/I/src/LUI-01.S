// RISC-V Architectural Validation Test LUI-01
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
// Description: Testing instruction 'LUI'.

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV32I")

.section .text.init
.globl rvtest_entry_point
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN







#ifdef TEST_CASE_1


    
    RVTEST_CASE(0,"//check ISA:=regex(.*32.*);check ISA:=regex(.*I.*I.*);def TEST_CASE_1=True;",lui)

    RVTEST_SIGBASE(x1,signature_1_0)

    # Testcase 0:  imm:0xa01ef, result rd:x19(0xa01ef000)
    lui x19, 0xa01ef
    sw  x19, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x19, 0xa01ef000)
    
    # Testcase 1:  imm:0x69d27, result rd:x28(0x69d27000)
    lui x28, 0x69d27
    sw  x28, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x28, 0x69d27000)
    
    # Testcase 2:  imm:0xede3d, result rd:x30(0xede3d000)
    lui x30, 0xede3d
    sw  x30, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x30, 0xede3d000)
    


    

    RVTEST_SIGBASE(x1,signature_2_0)

    # Testcase 3:  imm:0x19a51, result rd:x20(0x19a51000)
    lui x20, 0x19a51
    sw  x20, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x20, 0x19a51000)
    
    # Testcase 4:  imm:0x8d5fd, result rd:x10(0x8d5fd000)
    lui x10, 0x8d5fd
    sw  x10, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x10, 0x8d5fd000)
    
    # Testcase 5:  imm:0xf6c65, result rd:x0(0x0)
    lui x0, 0xf6c65
    sw  x0, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x0, 0x0)
    


    

    RVTEST_SIGBASE(x1,signature_3_0)

    # Testcase 6:  imm:0x6250f, result rd:x3(0x6250f000)
    lui x3, 0x6250f
    sw  x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x6250f000)
    
    # Testcase 7:  imm:0xffa64, result rd:x31(0xffa64000)
    lui x31, 0xffa64
    sw  x31, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x31, 0xffa64000)
    
    # Testcase 8:  imm:0x7ad3a, result rd:x29(0x7ad3a000)
    lui x29, 0x7ad3a
    sw  x29, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x29, 0x7ad3a000)
    


    

    RVTEST_SIGBASE(x1,signature_4_0)

    # Testcase 9:  imm:0xc8c1e, result rd:x5(0xc8c1e000)
    lui x5, 0xc8c1e
    sw  x5, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x5, 0xc8c1e000)
    
    # Testcase 10:  imm:0x660db, result rd:x0(0x0)
    lui x0, 0x660db
    sw  x0, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x0, 0x0)
    
    # Testcase 11:  imm:0x2dadf, result rd:x13(0x2dadf000)
    lui x13, 0x2dadf
    sw  x13, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x13, 0x2dadf000)
    


    

    RVTEST_SIGBASE(x1,signature_5_0)

    # Testcase 12:  imm:0x3c847, result rd:x4(0x3c847000)
    lui x4, 0x3c847
    sw  x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0x3c847000)
    
    # Testcase 13:  imm:0xa7ae7, result rd:x11(0xa7ae7000)
    lui x11, 0xa7ae7
    sw  x11, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x11, 0xa7ae7000)
    
    # Testcase 14:  imm:0xb62bf, result rd:x25(0xb62bf000)
    lui x25, 0xb62bf
    sw  x25, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x25, 0xb62bf000)
    


    

    RVTEST_SIGBASE(x1,signature_6_0)

    # Testcase 15:  imm:0xa3d1, result rd:x2(0xa3d1000)
    lui x2, 0xa3d1
    sw  x2, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x2, 0xa3d1000)
    
    # Testcase 16:  imm:0x80fd4, result rd:x18(0x80fd4000)
    lui x18, 0x80fd4
    sw  x18, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x18, 0x80fd4000)
    
    # Testcase 17:  imm:0xf5ff4, result rd:x18(0xf5ff4000)
    lui x18, 0xf5ff4
    sw  x18, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x18, 0xf5ff4000)
    


    

    RVTEST_SIGBASE(x1,signature_7_0)

    # Testcase 18:  imm:0x67ad9, result rd:x7(0x67ad9000)
    lui x7, 0x67ad9
    sw  x7, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x7, 0x67ad9000)
    
    # Testcase 19:  imm:0x454c0, result rd:x9(0x454c0000)
    lui x9, 0x454c0
    sw  x9, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x9, 0x454c0000)
    
    # Testcase 20:  imm:0xd3492, result rd:x31(0xd3492000)
    lui x31, 0xd3492
    sw  x31, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x31, 0xd3492000)
    


    

    RVTEST_SIGBASE(x1,signature_8_0)

    # Testcase 21:  imm:0xd663e, result rd:x17(0xd663e000)
    lui x17, 0xd663e
    sw  x17, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x17, 0xd663e000)
    
    # Testcase 22:  imm:0x3f1c5, result rd:x23(0x3f1c5000)
    lui x23, 0x3f1c5
    sw  x23, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x23, 0x3f1c5000)
    
    # Testcase 23:  imm:0xd39ae, result rd:x31(0xd39ae000)
    lui x31, 0xd39ae
    sw  x31, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x31, 0xd39ae000)
    


    

    RVTEST_SIGBASE(x1,signature_9_0)

    # Testcase 24:  imm:0x3a4dd, result rd:x21(0x3a4dd000)
    lui x21, 0x3a4dd
    sw  x21, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x21, 0x3a4dd000)
    
    # Testcase 25:  imm:0x83650, result rd:x0(0x0)
    lui x0, 0x83650
    sw  x0, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x0, 0x0)
    
    # Testcase 26:  imm:0xc88d5, result rd:x30(0xc88d5000)
    lui x30, 0xc88d5
    sw  x30, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x30, 0xc88d5000)
    


    

    RVTEST_SIGBASE(x1,signature_10_0)

    # Testcase 27:  imm:0xf4071, result rd:x0(0x0)
    lui x0, 0xf4071
    sw  x0, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x0, 0x0)
    
    # Testcase 28:  imm:0xb3c30, result rd:x17(0xb3c30000)
    lui x17, 0xb3c30
    sw  x17, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x17, 0xb3c30000)
    
    # Testcase 29:  imm:0xc7dd8, result rd:x31(0xc7dd8000)
    lui x31, 0xc7dd8
    sw  x31, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x31, 0xc7dd8000)
    


    

    RVTEST_SIGBASE(x1,signature_11_0)

    # Testcase 30:  imm:0x0, result rd:x6(0x0)
    lui x6, 0x0
    sw  x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0x0)
    
    # Testcase 31:  imm:0xfffff, result rd:x11(0xfffff000)
    lui x11, 0xfffff
    sw  x11, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x11, 0xfffff000)
    
    # Testcase 32:  imm:0xfffff, result rd:x22(0xfffff000)
    lui x22, 0xfffff
    sw  x22, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x22, 0xfffff000)
    


    

    RVTEST_SIGBASE(x1,signature_12_0)

    # Testcase 33:  imm:0xfffff, result rd:x9(0xfffff000)
    lui x9, 0xfffff
    sw  x9, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x9, 0xfffff000)
    
    # Testcase 34:  imm:0x1, result rd:x2(0x1000)
    lui x2, 0x1
    sw  x2, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x2, 0x1000)
    
    # Testcase 35:  imm:0xfffff, result rd:x7(0xfffff000)
    lui x7, 0xfffff
    sw  x7, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x7, 0xfffff000)
    


    

    RVTEST_SIGBASE(x1,signature_13_0)

    # Testcase 36:  imm:0xfffff, result rd:x13(0xfffff000)
    lui x13, 0xfffff
    sw  x13, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x13, 0xfffff000)
    
    # Testcase 37:  imm:0x0, result rd:x7(0x0)
    lui x7, 0x0
    sw  x7, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x7, 0x0)
    
    # Testcase 38:  imm:0x0, result rd:x3(0x0)
    lui x3, 0x0
    sw  x3, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0x0)
    


    

    RVTEST_SIGBASE(x2,signature_14_0)

    # Testcase 39:  imm:0xfffff, result rd:x13(0xfffff000)
    lui x13, 0xfffff
    sw  x13, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x13, 0xfffff000)
    
    # Testcase 40:  imm:0x1, result rd:x1(0x1000)
    lui x1, 0x1
    sw  x1, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x1, 0x1000)
    
    # Testcase 41:  imm:0x2, result rd:x1(0x2000)
    lui x1, 0x2
    sw  x1, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x1, 0x2000)
    


    

    RVTEST_SIGBASE(x1,signature_15_0)

    # Testcase 42:  imm:0x4, result rd:x2(0x4000)
    lui x2, 0x4
    sw  x2, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x2, 0x4000)
    
    # Testcase 43:  imm:0x8, result rd:x3(0x8000)
    lui x3, 0x8
    sw  x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x3, 0x8000)
    
    # Testcase 44:  imm:0x10, result rd:x4(0x10000)
    lui x4, 0x10
    sw  x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x4, 0x10000)
    


    

    RVTEST_SIGBASE(x1,signature_16_0)

    # Testcase 45:  imm:0x20, result rd:x5(0x20000)
    lui x5, 0x20
    sw  x5, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x5, 0x20000)
    
    # Testcase 46:  imm:0x40, result rd:x6(0x40000)
    lui x6, 0x40
    sw  x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0x40000)
    
    # Testcase 47:  imm:0x80, result rd:x7(0x80000)
    lui x7, 0x80
    sw  x7, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x7, 0x80000)
    


    

    RVTEST_SIGBASE(x1,signature_17_0)

    # Testcase 48:  imm:0x100, result rd:x8(0x100000)
    lui x8, 0x100
    sw  x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x100000)
    
    # Testcase 49:  imm:0x200, result rd:x9(0x200000)
    lui x9, 0x200
    sw  x9, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x9, 0x200000)
    
    # Testcase 50:  imm:0x400, result rd:x10(0x400000)
    lui x10, 0x400
    sw  x10, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x10, 0x400000)
    


    

    RVTEST_SIGBASE(x1,signature_18_0)

    # Testcase 51:  imm:0x800, result rd:x11(0x800000)
    lui x11, 0x800
    sw  x11, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x11, 0x800000)
    
    # Testcase 52:  imm:0x1000, result rd:x12(0x1000000)
    lui x12, 0x1000
    sw  x12, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x12, 0x1000000)
    
    # Testcase 53:  imm:0x2000, result rd:x13(0x2000000)
    lui x13, 0x2000
    sw  x13, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x13, 0x2000000)
    


    

    RVTEST_SIGBASE(x1,signature_19_0)

    # Testcase 54:  imm:0x4000, result rd:x14(0x4000000)
    lui x14, 0x4000
    sw  x14, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x14, 0x4000000)
    
    # Testcase 55:  imm:0x8000, result rd:x15(0x8000000)
    lui x15, 0x8000
    sw  x15, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x15, 0x8000000)
    
    # Testcase 56:  imm:0x10000, result rd:x16(0x10000000)
    lui x16, 0x10000
    sw  x16, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x16, 0x10000000)
    


    

    RVTEST_SIGBASE(x1,signature_20_0)

    # Testcase 57:  imm:0x20000, result rd:x17(0x20000000)
    lui x17, 0x20000
    sw  x17, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x17, 0x20000000)
    
    # Testcase 58:  imm:0x40000, result rd:x18(0x40000000)
    lui x18, 0x40000
    sw  x18, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x18, 0x40000000)
    
    # Testcase 59:  imm:0x80000, result rd:x19(0x80000000)
    lui x19, 0x80000
    sw  x19, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x19, 0x80000000)
    


    

    RVTEST_SIGBASE(x1,signature_21_0)

    # Testcase 60:  imm:0xffffe, result rd:x20(0xffffe000)
    lui x20, 0xffffe
    sw  x20, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x20, 0xffffe000)
    
    # Testcase 61:  imm:0xffffd, result rd:x21(0xffffd000)
    lui x21, 0xffffd
    sw  x21, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x21, 0xffffd000)
    
    # Testcase 62:  imm:0xffffb, result rd:x22(0xffffb000)
    lui x22, 0xffffb
    sw  x22, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x22, 0xffffb000)
    


    

    RVTEST_SIGBASE(x1,signature_22_0)

    # Testcase 63:  imm:0xffff7, result rd:x23(0xffff7000)
    lui x23, 0xffff7
    sw  x23, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x23, 0xffff7000)
    
    # Testcase 64:  imm:0xfffef, result rd:x24(0xfffef000)
    lui x24, 0xfffef
    sw  x24, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x24, 0xfffef000)
    
    # Testcase 65:  imm:0xfffdf, result rd:x25(0xfffdf000)
    lui x25, 0xfffdf
    sw  x25, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x25, 0xfffdf000)
    


    

    RVTEST_SIGBASE(x1,signature_23_0)

    # Testcase 66:  imm:0xfffbf, result rd:x26(0xfffbf000)
    lui x26, 0xfffbf
    sw  x26, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x26, 0xfffbf000)
    
    # Testcase 67:  imm:0xfff7f, result rd:x27(0xfff7f000)
    lui x27, 0xfff7f
    sw  x27, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x27, 0xfff7f000)
    
    # Testcase 68:  imm:0xffeff, result rd:x28(0xffeff000)
    lui x28, 0xffeff
    sw  x28, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x28, 0xffeff000)
    


    

    RVTEST_SIGBASE(x1,signature_24_0)

    # Testcase 69:  imm:0xffdff, result rd:x29(0xffdff000)
    lui x29, 0xffdff
    sw  x29, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x29, 0xffdff000)
    
    # Testcase 70:  imm:0xffbff, result rd:x30(0xffbff000)
    lui x30, 0xffbff
    sw  x30, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x30, 0xffbff000)
    
    # Testcase 71:  imm:0xff7ff, result rd:x31(0xff7ff000)
    lui x31, 0xff7ff
    sw  x31, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x31, 0xff7ff000)
    


    

    RVTEST_SIGBASE(x3,signature_25_0)

    # Testcase 72:  imm:0xfefff, result rd:x1(0xfefff000)
    lui x1, 0xfefff
    sw  x1, 0(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x1, 0xfefff000)
    
    # Testcase 73:  imm:0xfdfff, result rd:x1(0xfdfff000)
    lui x1, 0xfdfff
    sw  x1, 4(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x1, 0xfdfff000)
    
    # Testcase 74:  imm:0xfbfff, result rd:x2(0xfbfff000)
    lui x2, 0xfbfff
    sw  x2, 8(x3)
    RVMODEL_IO_ASSERT_GPR_EQ(x4, x2, 0xfbfff000)
    


    

    RVTEST_SIGBASE(x1,signature_26_0)

    # Testcase 75:  imm:0xf7fff, result rd:x3(0xf7fff000)
    lui x3, 0xf7fff
    sw  x3, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x3, 0xf7fff000)
    
    # Testcase 76:  imm:0xeffff, result rd:x4(0xeffff000)
    lui x4, 0xeffff
    sw  x4, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0xeffff000)
    
    # Testcase 77:  imm:0xdffff, result rd:x5(0xdffff000)
    lui x5, 0xdffff
    sw  x5, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x5, 0xdffff000)
    


    

    RVTEST_SIGBASE(x1,signature_27_0)

    # Testcase 78:  imm:0xbffff, result rd:x6(0xbffff000)
    lui x6, 0xbffff
    sw  x6, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xbffff000)
    
    # Testcase 79:  imm:0x7ffff, result rd:x7(0x7ffff000)
    lui x7, 0x7ffff
    sw  x7, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x7, 0x7ffff000)
    
    # Testcase 80:  imm:0xffffe, result rd:x8(0xffffe000)
    lui x8, 0xffffe
    sw  x8, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xffffe000)
    


    

    RVTEST_SIGBASE(x1,signature_28_0)

    # Testcase 81:  imm:0xffffd, result rd:x9(0xffffd000)
    lui x9, 0xffffd
    sw  x9, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x9, 0xffffd000)
    
    # Testcase 82:  imm:0xffffb, result rd:x10(0xffffb000)
    lui x10, 0xffffb
    sw  x10, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x10, 0xffffb000)
    
    # Testcase 83:  imm:0xffff7, result rd:x11(0xffff7000)
    lui x11, 0xffff7
    sw  x11, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x11, 0xffff7000)
    


    

    RVTEST_SIGBASE(x1,signature_29_0)

    # Testcase 84:  imm:0xfffef, result rd:x12(0xfffef000)
    lui x12, 0xfffef
    sw  x12, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x12, 0xfffef000)
    
    # Testcase 85:  imm:0xfffdf, result rd:x13(0xfffdf000)
    lui x13, 0xfffdf
    sw  x13, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x13, 0xfffdf000)
    
    # Testcase 86:  imm:0xfffbf, result rd:x14(0xfffbf000)
    lui x14, 0xfffbf
    sw  x14, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x14, 0xfffbf000)
    


    

    RVTEST_SIGBASE(x1,signature_30_0)

    # Testcase 87:  imm:0xfff7f, result rd:x15(0xfff7f000)
    lui x15, 0xfff7f
    sw  x15, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x15, 0xfff7f000)
    
    # Testcase 88:  imm:0xffeff, result rd:x16(0xffeff000)
    lui x16, 0xffeff
    sw  x16, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x16, 0xffeff000)
    
    # Testcase 89:  imm:0xffdff, result rd:x17(0xffdff000)
    lui x17, 0xffdff
    sw  x17, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x17, 0xffdff000)
    


    

    RVTEST_SIGBASE(x1,signature_31_0)

    # Testcase 90:  imm:0xffbff, result rd:x18(0xffbff000)
    lui x18, 0xffbff
    sw  x18, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x18, 0xffbff000)
    
    # Testcase 91:  imm:0xff7ff, result rd:x19(0xff7ff000)
    lui x19, 0xff7ff
    sw  x19, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x19, 0xff7ff000)
    
    # Testcase 92:  imm:0xfefff, result rd:x20(0xfefff000)
    lui x20, 0xfefff
    sw  x20, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x20, 0xfefff000)
    


    

    RVTEST_SIGBASE(x1,signature_32_0)

    # Testcase 93:  imm:0xfdfff, result rd:x21(0xfdfff000)
    lui x21, 0xfdfff
    sw  x21, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x21, 0xfdfff000)
    
    # Testcase 94:  imm:0xfbfff, result rd:x22(0xfbfff000)
    lui x22, 0xfbfff
    sw  x22, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x22, 0xfbfff000)
    
    # Testcase 95:  imm:0xf7fff, result rd:x23(0xf7fff000)
    lui x23, 0xf7fff
    sw  x23, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x23, 0xf7fff000)
    


    

    RVTEST_SIGBASE(x1,signature_33_0)

    # Testcase 96:  imm:0xeffff, result rd:x24(0xeffff000)
    lui x24, 0xeffff
    sw  x24, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x24, 0xeffff000)
    
    # Testcase 97:  imm:0xdffff, result rd:x25(0xdffff000)
    lui x25, 0xdffff
    sw  x25, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x25, 0xdffff000)
    
    # Testcase 98:  imm:0xbffff, result rd:x26(0xbffff000)
    lui x26, 0xbffff
    sw  x26, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x26, 0xbffff000)
    


    

    RVTEST_SIGBASE(x1,signature_34_0)

    # Testcase 99:  imm:0x7ffff, result rd:x27(0x7ffff000)
    lui x27, 0x7ffff
    sw  x27, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x27, 0x7ffff000)
    
    # Testcase 100:  imm:0xffffe, result rd:x28(0xffffe000)
    lui x28, 0xffffe
    sw  x28, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x28, 0xffffe000)
    
    # Testcase 101:  imm:0xffffd, result rd:x29(0xffffd000)
    lui x29, 0xffffd
    sw  x29, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x29, 0xffffd000)
    


    

    RVTEST_SIGBASE(x2,signature_35_0)

    # Testcase 102:  imm:0xffffb, result rd:x30(0xffffb000)
    lui x30, 0xffffb
    sw  x30, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x30, 0xffffb000)
    
    # Testcase 103:  imm:0xffff7, result rd:x31(0xffff7000)
    lui x31, 0xffff7
    sw  x31, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x31, 0xffff7000)
    
    # Testcase 104:  imm:0x1, result rd:x1(0x1000)
    lui x1, 0x1
    sw  x1, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x1, 0x1000)
    


    

    RVTEST_SIGBASE(x4,signature_36_0)

    # Testcase 105:  imm:0x2, result rd:x1(0x2000)
    lui x1, 0x2
    sw  x1, 0(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x1, 0x2000)
    
    # Testcase 106:  imm:0x4, result rd:x2(0x4000)
    lui x2, 0x4
    sw  x2, 4(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x2, 0x4000)
    
    # Testcase 107:  imm:0x8, result rd:x3(0x8000)
    lui x3, 0x8
    sw  x3, 8(x4)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x3, 0x8000)
    


    

    RVTEST_SIGBASE(x1,signature_37_0)

    # Testcase 108:  imm:0x10, result rd:x4(0x10000)
    lui x4, 0x10
    sw  x4, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x4, 0x10000)
    
    # Testcase 109:  imm:0x20, result rd:x5(0x20000)
    lui x5, 0x20
    sw  x5, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x5, 0x20000)
    
    # Testcase 110:  imm:0x40, result rd:x6(0x40000)
    lui x6, 0x40
    sw  x6, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0x40000)
    


    

    RVTEST_SIGBASE(x1,signature_38_0)

    # Testcase 111:  imm:0x80, result rd:x7(0x80000)
    lui x7, 0x80
    sw  x7, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x7, 0x80000)
    
    # Testcase 112:  imm:0x100, result rd:x8(0x100000)
    lui x8, 0x100
    sw  x8, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0x100000)
    
    # Testcase 113:  imm:0x200, result rd:x9(0x200000)
    lui x9, 0x200
    sw  x9, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x9, 0x200000)
    


    

    RVTEST_SIGBASE(x1,signature_39_0)

    # Testcase 114:  imm:0x400, result rd:x10(0x400000)
    lui x10, 0x400
    sw  x10, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x10, 0x400000)
    
    # Testcase 115:  imm:0x800, result rd:x11(0x800000)
    lui x11, 0x800
    sw  x11, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x11, 0x800000)
    
    # Testcase 116:  imm:0x1000, result rd:x12(0x1000000)
    lui x12, 0x1000
    sw  x12, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x12, 0x1000000)
    


    

    RVTEST_SIGBASE(x1,signature_40_0)

    # Testcase 117:  imm:0x2000, result rd:x13(0x2000000)
    lui x13, 0x2000
    sw  x13, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x13, 0x2000000)
    
    # Testcase 118:  imm:0x4000, result rd:x14(0x4000000)
    lui x14, 0x4000
    sw  x14, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x14, 0x4000000)
    
    # Testcase 119:  imm:0x8000, result rd:x15(0x8000000)
    lui x15, 0x8000
    sw  x15, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x15, 0x8000000)
    


    

    RVTEST_SIGBASE(x1,signature_41_0)

    # Testcase 120:  imm:0x10000, result rd:x16(0x10000000)
    lui x16, 0x10000
    sw  x16, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x16, 0x10000000)
    
    # Testcase 121:  imm:0x20000, result rd:x17(0x20000000)
    lui x17, 0x20000
    sw  x17, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x17, 0x20000000)
    
    # Testcase 122:  imm:0x40000, result rd:x18(0x40000000)
    lui x18, 0x40000
    sw  x18, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x18, 0x40000000)
    


    

    RVTEST_SIGBASE(x1,signature_42_0)

    # Testcase 123:  imm:0x80000, result rd:x19(0x80000000)
    lui x19, 0x80000
    sw  x19, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x19, 0x80000000)
    
    # Testcase 124:  imm:0xffffe, result rd:x20(0xffffe000)
    lui x20, 0xffffe
    sw  x20, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x20, 0xffffe000)
    
    # Testcase 125:  imm:0xffffd, result rd:x21(0xffffd000)
    lui x21, 0xffffd
    sw  x21, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x21, 0xffffd000)
    


    

    RVTEST_SIGBASE(x1,signature_43_0)

    # Testcase 126:  imm:0xffffb, result rd:x22(0xffffb000)
    lui x22, 0xffffb
    sw  x22, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x22, 0xffffb000)
    
    # Testcase 127:  imm:0xffff7, result rd:x23(0xffff7000)
    lui x23, 0xffff7
    sw  x23, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x23, 0xffff7000)
    
    # Testcase 128:  imm:0xfffef, result rd:x24(0xfffef000)
    lui x24, 0xfffef
    sw  x24, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x24, 0xfffef000)
    


    

    RVTEST_SIGBASE(x1,signature_44_0)

    # Testcase 129:  imm:0xfffdf, result rd:x25(0xfffdf000)
    lui x25, 0xfffdf
    sw  x25, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x25, 0xfffdf000)
    
    # Testcase 130:  imm:0xfffbf, result rd:x26(0xfffbf000)
    lui x26, 0xfffbf
    sw  x26, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x26, 0xfffbf000)
    
    # Testcase 131:  imm:0xfff7f, result rd:x27(0xfff7f000)
    lui x27, 0xfff7f
    sw  x27, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x27, 0xfff7f000)
    


    

    RVTEST_SIGBASE(x1,signature_45_0)

    # Testcase 132:  imm:0xffeff, result rd:x28(0xffeff000)
    lui x28, 0xffeff
    sw  x28, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x28, 0xffeff000)
    
    # Testcase 133:  imm:0xffdff, result rd:x29(0xffdff000)
    lui x29, 0xffdff
    sw  x29, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x29, 0xffdff000)
    
    # Testcase 134:  imm:0xffbff, result rd:x30(0xffbff000)
    lui x30, 0xffbff
    sw  x30, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x30, 0xffbff000)
    


    

    RVTEST_SIGBASE(x2,signature_46_0)

    # Testcase 135:  imm:0xff7ff, result rd:x31(0xff7ff000)
    lui x31, 0xff7ff
    sw  x31, 0(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x31, 0xff7ff000)
    
    # Testcase 136:  imm:0xfefff, result rd:x1(0xfefff000)
    lui x1, 0xfefff
    sw  x1, 4(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x1, 0xfefff000)
    
    # Testcase 137:  imm:0xfdfff, result rd:x1(0xfdfff000)
    lui x1, 0xfdfff
    sw  x1, 8(x2)
    RVMODEL_IO_ASSERT_GPR_EQ(x3, x1, 0xfdfff000)
    


    

    RVTEST_SIGBASE(x1,signature_47_0)

    # Testcase 138:  imm:0xfbfff, result rd:x2(0xfbfff000)
    lui x2, 0xfbfff
    sw  x2, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x2, 0xfbfff000)
    
    # Testcase 139:  imm:0xf7fff, result rd:x3(0xf7fff000)
    lui x3, 0xf7fff
    sw  x3, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x3, 0xf7fff000)
    
    # Testcase 140:  imm:0xeffff, result rd:x4(0xeffff000)
    lui x4, 0xeffff
    sw  x4, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x5, x4, 0xeffff000)
    


    

    RVTEST_SIGBASE(x1,signature_48_0)

    # Testcase 141:  imm:0xdffff, result rd:x5(0xdffff000)
    lui x5, 0xdffff
    sw  x5, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x5, 0xdffff000)
    
    # Testcase 142:  imm:0xbffff, result rd:x6(0xbffff000)
    lui x6, 0xbffff
    sw  x6, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x6, 0xbffff000)
    
    # Testcase 143:  imm:0x7ffff, result rd:x7(0x7ffff000)
    lui x7, 0x7ffff
    sw  x7, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x7, 0x7ffff000)
    


    

    RVTEST_SIGBASE(x1,signature_49_0)

    # Testcase 144:  imm:0xffffe, result rd:x8(0xffffe000)
    lui x8, 0xffffe
    sw  x8, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x8, 0xffffe000)
    
    # Testcase 145:  imm:0xffffd, result rd:x9(0xffffd000)
    lui x9, 0xffffd
    sw  x9, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x9, 0xffffd000)
    
    # Testcase 146:  imm:0xffffb, result rd:x10(0xffffb000)
    lui x10, 0xffffb
    sw  x10, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x10, 0xffffb000)
    


    

    RVTEST_SIGBASE(x1,signature_50_0)

    # Testcase 147:  imm:0xffff7, result rd:x11(0xffff7000)
    lui x11, 0xffff7
    sw  x11, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x11, 0xffff7000)
    
    # Testcase 148:  imm:0xfffef, result rd:x12(0xfffef000)
    lui x12, 0xfffef
    sw  x12, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x12, 0xfffef000)
    
    # Testcase 149:  imm:0xfffdf, result rd:x13(0xfffdf000)
    lui x13, 0xfffdf
    sw  x13, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x13, 0xfffdf000)
    


    

    RVTEST_SIGBASE(x1,signature_51_0)

    # Testcase 150:  imm:0xfffbf, result rd:x14(0xfffbf000)
    lui x14, 0xfffbf
    sw  x14, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x14, 0xfffbf000)
    
    # Testcase 151:  imm:0xfff7f, result rd:x15(0xfff7f000)
    lui x15, 0xfff7f
    sw  x15, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x15, 0xfff7f000)
    
    # Testcase 152:  imm:0xffeff, result rd:x16(0xffeff000)
    lui x16, 0xffeff
    sw  x16, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x16, 0xffeff000)
    


    

    RVTEST_SIGBASE(x1,signature_52_0)

    # Testcase 153:  imm:0xffdff, result rd:x17(0xffdff000)
    lui x17, 0xffdff
    sw  x17, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x17, 0xffdff000)
    
    # Testcase 154:  imm:0xffbff, result rd:x18(0xffbff000)
    lui x18, 0xffbff
    sw  x18, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x18, 0xffbff000)
    
    # Testcase 155:  imm:0xff7ff, result rd:x19(0xff7ff000)
    lui x19, 0xff7ff
    sw  x19, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x19, 0xff7ff000)
    


    

    RVTEST_SIGBASE(x1,signature_53_0)

    # Testcase 156:  imm:0xfefff, result rd:x20(0xfefff000)
    lui x20, 0xfefff
    sw  x20, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x20, 0xfefff000)
    
    # Testcase 157:  imm:0xfdfff, result rd:x21(0xfdfff000)
    lui x21, 0xfdfff
    sw  x21, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x21, 0xfdfff000)
    
    # Testcase 158:  imm:0xfbfff, result rd:x22(0xfbfff000)
    lui x22, 0xfbfff
    sw  x22, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x22, 0xfbfff000)
    


    

    RVTEST_SIGBASE(x1,signature_54_0)

    # Testcase 159:  imm:0xf7fff, result rd:x23(0xf7fff000)
    lui x23, 0xf7fff
    sw  x23, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x23, 0xf7fff000)
    
    # Testcase 160:  imm:0xeffff, result rd:x24(0xeffff000)
    lui x24, 0xeffff
    sw  x24, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x24, 0xeffff000)
    
    # Testcase 161:  imm:0xdffff, result rd:x25(0xdffff000)
    lui x25, 0xdffff
    sw  x25, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x25, 0xdffff000)
    


    

    RVTEST_SIGBASE(x1,signature_55_0)

    # Testcase 162:  imm:0xbffff, result rd:x26(0xbffff000)
    lui x26, 0xbffff
    sw  x26, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x26, 0xbffff000)
    
    # Testcase 163:  imm:0x7ffff, result rd:x27(0x7ffff000)
    lui x27, 0x7ffff
    sw  x27, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x27, 0x7ffff000)
    
    # Testcase 164:  imm:0xffffe, result rd:x28(0xffffe000)
    lui x28, 0xffffe
    sw  x28, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x28, 0xffffe000)
    


    

    RVTEST_SIGBASE(x1,signature_56_0)

    # Testcase 165:  imm:0xffffd, result rd:x29(0xffffd000)
    lui x29, 0xffffd
    sw  x29, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x29, 0xffffd000)
    
    # Testcase 166:  imm:0xffffb, result rd:x30(0xffffb000)
    lui x30, 0xffffb
    sw  x30, 4(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x30, 0xffffb000)
    
    # Testcase 167:  imm:0xffff7, result rd:x31(0xffff7000)
    lui x31, 0xffff7
    sw  x31, 8(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x31, 0xffff7000)
    


    

    RVTEST_SIGBASE(x1,signature_57_0)

    # Testcase 168:  imm:0xa9522, result rd:x0(0x0)
    lui x0, 0xa9522
    sw  x0, 0(x1)
    RVMODEL_IO_ASSERT_GPR_EQ(x2, x0, 0x0)
    
	
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

