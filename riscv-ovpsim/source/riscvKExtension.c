/*
 * Copyright (c) 2005-2023 Imperas Software Ltd., www.imperas.com
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

// standard header files
#include <stdio.h>

// basic types
#include "hostapi/impTypes.h"

// VMI header files
#include "vmi/vmiMessage.h"
#include "vmi/vmiMt.h"

// model header files
#include "riscvBus.h"
#include "riscvCSR.h"
#include "riscvExceptions.h"
#include "riscvKExtension.h"
#include "riscvMessage.h"
#include "riscvMorph.h"
#include "riscvStructure.h"


////////////////////////////////////////////////////////////////////////////////
// VECTOR CRYPTOGRAPHIC UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// 128-bit vector element
//
typedef union v128U {
    Uns8  u8 [16];  // Uns8 view
    Uns32 u32[ 4];  // Uns32 view
    Uns64 u64[ 2];  // Uns64 view
} v128;

//
// 256-bit vector element
//
typedef union v256U {
    Uns8  u8 [32];  // Uns8 view
    Uns32 u32[ 8];  // Uns32 view
    Uns64 u64[ 4];  // Uns64 view
} v256;

//
// Set 128-bit result
//
inline static void setResult128(riscvP riscv, v128 result) {
    riscv->vTmp[0] = result.u64[0];
    riscv->vTmp[1] = result.u64[1];
}

//
// Set 256-bit result
//
inline static void setResult256(riscvP riscv, v256 result) {
    riscv->vTmp[0] = result.u64[0];
    riscv->vTmp[1] = result.u64[1];
    riscv->vTmp[2] = result.u64[2];
    riscv->vTmp[3] = result.u64[3];
}

//
// Rotate 32-bit value right
//
inline static Uns32 ROR32(Uns32 a, Uns32 amt) {
    return ((a << (-amt & (32-1))) | (a >> (amt & (32-1))));
}

//
// Rotate 32-bit value left
//
inline static Uns32 ROL32(Uns32 a, Uns32 amt) {
    return ((a >> (-amt & (32-1))) | (a << (amt & (32-1))));
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION CRC CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Do LUT4LO (32-bit registers)
//
static Uns32 doLUT4LO32(Uns32 rs1, Uns32 rs2) {

    Uns32 x = 0;
    Uns32 i;

    for(i=0; i<8; i++) {

        Uns32 rs1N = rs1&0xf;

        if(rs1N<8) {
            Uns32 rs2N = (rs2>>(rs1N*4))&0xf;
            x |= (rs2N<<(i*4));
        }

        rs1 >>= 4;
    }

    return x;
}

//
// Do LUT4LO (64-bit registers)
//
static Uns64 doLUT4LO64(Uns64 rs1, Uns64 rs2) {
    return doLUT4LO32(rs1, rs2);
}

//
// Do LUT4HI (32-bit registers)
//
static Uns32 doLUT4HI32(Uns32 rs1, Uns32 rs2) {

    Uns32 x = 0;
    Uns32 i;

    for(i=0; i<8; i++) {

        Uns32 rs1N = rs1&0xf;

        if(rs1N>=8) {
            Uns32 rs2N = (rs2>>((rs1N&0x7)*4))&0xf;
            x |= (rs2N<<(i*4));
        }

        rs1 >>= 4;
    }

    return x;
}

//
// Do LUT4LO (64-bit registers)
//
static Uns64 doLUT4HI64(Uns64 rs1, Uns64 rs2) {
    return doLUT4HI32(rs1, rs2);
}

//
// Do LUT4
//
static Uns64 doLUT4(Uns64 rs1, Uns64 rs2) {

    Uns64 x = 0;
    Uns32 i;

    for(i=0; i<16; i++) {

        Uns32 rs1N = rs1&0xf;
        Uns64 rs2N = (rs2>>(rs1N*4))&0xf;

        x |= (rs2N<<(i*4));

        rs1 >>= 4;
    }

    return x;
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION AES CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

static Uns8 AES_ENC_SBOX[]= {
    0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5,
    0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76,
    0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0,
    0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0,
    0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC,
    0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15,
    0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A,
    0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75,
    0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0,
    0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84,
    0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B,
    0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF,
    0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85,
    0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8,
    0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5,
    0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2,
    0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17,
    0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73,
    0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88,
    0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB,
    0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C,
    0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79,
    0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9,
    0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08,
    0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6,
    0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A,
    0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E,
    0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E,
    0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94,
    0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF,
    0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68,
    0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16
};

static Uns8 AES_DEC_SBOX[] = {
    0x52, 0x09, 0x6A, 0xD5, 0x30, 0x36, 0xA5, 0x38,
    0xBF, 0x40, 0xA3, 0x9E, 0x81, 0xF3, 0xD7, 0xFB,
    0x7C, 0xE3, 0x39, 0x82, 0x9B, 0x2F, 0xFF, 0x87,
    0x34, 0x8E, 0x43, 0x44, 0xC4, 0xDE, 0xE9, 0xCB,
    0x54, 0x7B, 0x94, 0x32, 0xA6, 0xC2, 0x23, 0x3D,
    0xEE, 0x4C, 0x95, 0x0B, 0x42, 0xFA, 0xC3, 0x4E,
    0x08, 0x2E, 0xA1, 0x66, 0x28, 0xD9, 0x24, 0xB2,
    0x76, 0x5B, 0xA2, 0x49, 0x6D, 0x8B, 0xD1, 0x25,
    0x72, 0xF8, 0xF6, 0x64, 0x86, 0x68, 0x98, 0x16,
    0xD4, 0xA4, 0x5C, 0xCC, 0x5D, 0x65, 0xB6, 0x92,
    0x6C, 0x70, 0x48, 0x50, 0xFD, 0xED, 0xB9, 0xDA,
    0x5E, 0x15, 0x46, 0x57, 0xA7, 0x8D, 0x9D, 0x84,
    0x90, 0xD8, 0xAB, 0x00, 0x8C, 0xBC, 0xD3, 0x0A,
    0xF7, 0xE4, 0x58, 0x05, 0xB8, 0xB3, 0x45, 0x06,
    0xD0, 0x2C, 0x1E, 0x8F, 0xCA, 0x3F, 0x0F, 0x02,
    0xC1, 0xAF, 0xBD, 0x03, 0x01, 0x13, 0x8A, 0x6B,
    0x3A, 0x91, 0x11, 0x41, 0x4F, 0x67, 0xDC, 0xEA,
    0x97, 0xF2, 0xCF, 0xCE, 0xF0, 0xB4, 0xE6, 0x73,
    0x96, 0xAC, 0x74, 0x22, 0xE7, 0xAD, 0x35, 0x85,
    0xE2, 0xF9, 0x37, 0xE8, 0x1C, 0x75, 0xDF, 0x6E,
    0x47, 0xF1, 0x1A, 0x71, 0x1D, 0x29, 0xC5, 0x89,
    0x6F, 0xB7, 0x62, 0x0E, 0xAA, 0x18, 0xBE, 0x1B,
    0xFC, 0x56, 0x3E, 0x4B, 0xC6, 0xD2, 0x79, 0x20,
    0x9A, 0xDB, 0xC0, 0xFE, 0x78, 0xCD, 0x5A, 0xF4,
    0x1F, 0xDD, 0xA8, 0x33, 0x88, 0x07, 0xC7, 0x31,
    0xB1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xEC, 0x5F,
    0x60, 0x51, 0x7F, 0xA9, 0x19, 0xB5, 0x4A, 0x0D,
    0x2D, 0xE5, 0x7A, 0x9F, 0x93, 0xC9, 0x9C, 0xEF,
    0xA0, 0xE0, 0x3B, 0x4D, 0xAE, 0x2A, 0xF5, 0xB0,
    0xC8, 0xEB, 0xBB, 0x3C, 0x83, 0x53, 0x99, 0x61,
    0x17, 0x2B, 0x04, 0x7E, 0xBA, 0x77, 0xD6, 0x26,
    0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D
};

static const Uns8 round_consts[] = {
    0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80,
    0x1b, 0x36, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

#define AES_UNPACK_BYTES(b0,b1,b2,b3) \
    Uns8 b0 = (RS1 >>  0) & 0xFF; \
    Uns8 b1 = (RS2 >>  8) & 0xFF; \
    Uns8 b2 = (RS1 >> 16) & 0xFF; \
    Uns8 b3 = (RS2 >> 24) & 0xFF; \

#define AES_PACK_BYTES(b0,b1,b2,b3) ( \
    (Uns32)b0 <<  0  | \
    (Uns32)b1 <<  8  | \
    (Uns32)b2 << 16  | \
    (Uns32)b3 << 24  )

#define AES_SBOX(b0, b1, b2, b3) \
    b0 = AES_ENC_SBOX[b0]; \
    b1 = AES_ENC_SBOX[b1]; \
    b2 = AES_ENC_SBOX[b2]; \
    b3 = AES_ENC_SBOX[b3]; \

#define AES_RSBOX(b0, b1, b2, b3) \
    b0 = AES_DEC_SBOX[b0]; \
    b1 = AES_DEC_SBOX[b1]; \
    b2 = AES_DEC_SBOX[b2]; \
    b3 = AES_DEC_SBOX[b3]; \

#define AES_XTIME(a) \
    ((a << 1) ^ ((a&0x80) ? 0x1b : 0))

#define AES_GFMUL(a,b) (( \
    ( ( (b) & 0x1 ) ?                              (a)   : 0 ) ^ \
    ( ( (b) & 0x2 ) ?                     AES_XTIME(a)   : 0 ) ^ \
    ( ( (b) & 0x4 ) ?           AES_XTIME(AES_XTIME(a))  : 0 ) ^ \
    ( ( (b) & 0x8 ) ? AES_XTIME(AES_XTIME(AES_XTIME(a))) : 0 ) )&0xFF)

#define BY(X,I) ((X >> (8*I)) & 0xFF)

#define AES_SHIFROWS_LO(RS1,RS2) ( \
    (((RS1 >> 24) & 0xFF) << 56) | \
    (((RS2 >> 48) & 0xFF) << 48) | \
    (((RS2 >>  8) & 0xFF) << 40) | \
    (((RS1 >> 32) & 0xFF) << 32) | \
    (((RS2 >> 56) & 0xFF) << 24) | \
    (((RS2 >> 16) & 0xFF) << 16) | \
    (((RS1 >> 40) & 0xFF) <<  8) | \
    (((RS1 >>  0) & 0xFF) <<  0) )

#define AES_INVSHIFROWS_LO(RS1,RS2) ( \
    (((RS2 >> 24) & 0xFF) << 56) | \
    (((RS2 >> 48) & 0xFF) << 48) | \
    (((RS1 >>  8) & 0xFF) << 40) | \
    (((RS1 >> 32) & 0xFF) << 32) | \
    (((RS1 >> 56) & 0xFF) << 24) | \
    (((RS2 >> 16) & 0xFF) << 16) | \
    (((RS2 >> 40) & 0xFF) <<  8) | \
    (((RS1 >>  0) & 0xFF) <<  0) )


#define AES_MIXBYTE(COL,B0,B1,B2,B3) ( \
              BY(COL,B3)     ^ \
              BY(COL,B2)     ^ \
    AES_GFMUL(BY(COL,B1), 3) ^ \
    AES_GFMUL(BY(COL,B0), 2)   \
)

#define AES_MIXCOLUMN(COL) ( \
    AES_MIXBYTE(COL,3,0,1,2) << 24 | \
    AES_MIXBYTE(COL,2,3,0,1) << 16 | \
    AES_MIXBYTE(COL,1,2,3,0) <<  8 | \
    AES_MIXBYTE(COL,0,1,2,3) <<  0   \
)


#define AES_INVMIXBYTE(COL,B0,B1,B2,B3) ( \
    AES_GFMUL(BY(COL,B3),0x9) ^ \
    AES_GFMUL(BY(COL,B2),0xd) ^ \
    AES_GFMUL(BY(COL,B1),0xb) ^ \
    AES_GFMUL(BY(COL,B0),0xe)   \
)

#define AES_INVMIXCOLUMN(COL) ( \
    AES_INVMIXBYTE(COL,3,0,1,2) << 24 | \
    AES_INVMIXBYTE(COL,2,3,0,1) << 16 | \
    AES_INVMIXBYTE(COL,1,2,3,0) <<  8 | \
    AES_INVMIXBYTE(COL,0,1,2,3) <<  0   \
)

//
// Do SAES32_ENCS
//
static Uns32 doSAES32_ENCS(Uns32 rs1, Uns32 bs, Uns32 rs2) {

    Uns8  t0 = rs2 >> (8*bs);
    Uns8  x  = AES_ENC_SBOX[t0];
    Uns32 u  = x;

    u = ROL32(u, 8*bs);

    return u ^ rs1;
}

//
// Do SAES32_ENCSM
//
static Uns32 doSAES32_ENCSM(Uns32 rs1, Uns32 bs, Uns32 rs2) {

    Uns8  t0 = rs2 >> (8*bs);
    Uns8  x  = AES_ENC_SBOX[t0];
    Uns32 u;

    u = (AES_GFMUL(x,3) << 24) |
        (          x    << 16) |
        (          x    <<  8) |
        (AES_GFMUL(x,2) <<  0) ;

    u = ROL32(u, 8*bs);

    return u ^ rs1;
}

//
// Do SAES32_DECS
//
static Uns32 doSAES32_DECS(Uns32 rs1, Uns32 bs, Uns32 rs2) {

    Uns8  t0 = rs2 >> (8*bs);
    Uns8  x  = AES_DEC_SBOX[t0];
    Uns32 u  = x;

    u = ROL32(u, 8*bs);

    return u ^ rs1;
}

//
// Do SAES32_DECSM
//
static Uns32 doSAES32_DECSM(Uns32 rs1, Uns32 bs, Uns32 rs2) {

    Uns8  t0 = rs2 >> (8*bs);
    Uns8  x  = AES_DEC_SBOX[t0];
    Uns32 u;

    u = (AES_GFMUL(x,0xb) << 24) |
        (AES_GFMUL(x,0xd) << 16) |
        (AES_GFMUL(x,0x9) <<  8) |
        (AES_GFMUL(x,0xe) <<  0) ;

    u = ROL32(u, 8*bs);

    return u ^ rs1;
}

//
// Do SAES64_KS1
//
static Uns64 doSAES64_KS1(Uns64 rs1, Uns32 rnum) {

    Uns32 temp = (rs1 >> 32);
    Uns8  rcon = 0;

    if(rnum < 0xA) {
        temp = ROR32(temp, 8);
        rcon = round_consts[rnum];
    }

    temp =
        ((Uns32)AES_ENC_SBOX[(temp >> 24) & 0xFF] << 24) |
        ((Uns32)AES_ENC_SBOX[(temp >> 16) & 0xFF] << 16) |
        ((Uns32)AES_ENC_SBOX[(temp >>  8) & 0xFF] <<  8) |
        ((Uns32)AES_ENC_SBOX[(temp >>  0) & 0xFF] <<  0) ;

    temp ^= rcon;

    return ((Uns64)temp << 32) | temp;
}

//
// Do SAES64_KS2
//
static Uns64 doSAES64_KS2(Uns64 rs1, Uns64 rs2) {

    Uns32 rs1_hi = rs1 >> 32;
    Uns32 rs2_lo = rs2;
    Uns32 rs2_hi = rs2 >> 32;

    Uns32 r_lo = (rs1_hi ^ rs2_lo         );
    Uns32 r_hi = (rs1_hi ^ rs2_lo ^ rs2_hi);

    return ((Uns64)r_hi << 32) | r_lo;
}

//
// Do SAES64_IMIX
//
static Uns64 doSAES64_IMIX(Uns64 rs1) {

    Uns32 col_0 = rs1 & 0xFFFFFFFF;
    Uns32 col_1 = rs1 >> 32;

    col_0 = AES_INVMIXCOLUMN(col_0);
    col_1 = AES_INVMIXCOLUMN(col_1);

    return ((Uns64)col_1 << 32) | col_0;
}

//
// Do SAES64_ENCS
//
static Uns64 doSAES64_ENCS(Uns64 rs1, Uns64 rs2) {

    Uns64 temp = AES_SHIFROWS_LO(rs1,rs2);

    temp = (
        ((Uns64)AES_ENC_SBOX[(temp >>  0) & 0xFF] <<  0) |
        ((Uns64)AES_ENC_SBOX[(temp >>  8) & 0xFF] <<  8) |
        ((Uns64)AES_ENC_SBOX[(temp >> 16) & 0xFF] << 16) |
        ((Uns64)AES_ENC_SBOX[(temp >> 24) & 0xFF] << 24) |
        ((Uns64)AES_ENC_SBOX[(temp >> 32) & 0xFF] << 32) |
        ((Uns64)AES_ENC_SBOX[(temp >> 40) & 0xFF] << 40) |
        ((Uns64)AES_ENC_SBOX[(temp >> 48) & 0xFF] << 48) |
        ((Uns64)AES_ENC_SBOX[(temp >> 56) & 0xFF] << 56)
    );

    return temp;
}

//
// Do SAES64_ENCSM
//
static Uns64 doSAES64_ENCSM(Uns64 rs1, Uns64 rs2) {

    Uns64 temp  = doSAES64_ENCS(rs1, rs2);
    Uns32 col_0 = temp;
    Uns32 col_1 = temp >> 32;

    col_0 = AES_MIXCOLUMN(col_0);
    col_1 = AES_MIXCOLUMN(col_1);

    return ((Uns64)col_1 << 32) | col_0;
}

//
// Do SAES64_DECS
//
static Uns64 doSAES64_DECS(Uns64 rs1, Uns64 rs2) {

    Uns64 temp = AES_INVSHIFROWS_LO(rs1,rs2);

    temp = (
        ((Uns64)AES_DEC_SBOX[(temp >>  0) & 0xFF] <<  0) |
        ((Uns64)AES_DEC_SBOX[(temp >>  8) & 0xFF] <<  8) |
        ((Uns64)AES_DEC_SBOX[(temp >> 16) & 0xFF] << 16) |
        ((Uns64)AES_DEC_SBOX[(temp >> 24) & 0xFF] << 24) |
        ((Uns64)AES_DEC_SBOX[(temp >> 32) & 0xFF] << 32) |
        ((Uns64)AES_DEC_SBOX[(temp >> 40) & 0xFF] << 40) |
        ((Uns64)AES_DEC_SBOX[(temp >> 48) & 0xFF] << 48) |
        ((Uns64)AES_DEC_SBOX[(temp >> 56) & 0xFF] << 56)
    );

    return temp;
}

//
// Do SAES64_DECSM
//
static Uns64 doSAES64_DECSM(Uns64 rs1, Uns64 rs2) {

    Uns64 temp  = doSAES64_DECS(rs1, rs2);
    Uns32 col_0 = temp;
    Uns32 col_1 = temp >> 32;

    col_0 = AES_INVMIXCOLUMN(col_0);
    col_1 = AES_INVMIXCOLUMN(col_1);

    return ((Uns64)col_1 << 32) | col_0;
}

//
// Initialize AES LUT element
//
#define AES_LUT_E(_I, _O) [_I] = ((_I)+(_O)) & 15

//
// Initialize AES LUT row
//
#define AES_LUT_R(_I, _O) \
    AES_LUT_E((_I)+0,  _O), \
    AES_LUT_E((_I)+4,  _O), \
    AES_LUT_E((_I)+8,  _O), \
    AES_LUT_E((_I)+12, _O)

//
// Initialize AES LUT
//
#define AES_LUT_T(_O0, _O1, _O2, _O3) \
    AES_LUT_R(0, (_O0*4)),  \
    AES_LUT_R(1, (_O1*4)),  \
    AES_LUT_R(2, (_O2*4)),  \
    AES_LUT_R(3, (_O3*4))   \

//
// AES SubWord function used in the key expansion
// - Applies the forward sbox to each byte in the input word.
//
static Uns32 aes_subword_fwd(Uns32 x) {
    return (
        (AES_ENC_SBOX[(x >>  0) & 0xFF] <<  0) |
        (AES_ENC_SBOX[(x >>  8) & 0xFF] <<  8) |
        (AES_ENC_SBOX[(x >> 16) & 0xFF] << 16) |
        (AES_ENC_SBOX[(x >> 24) & 0xFF] << 24)
    );
}

//
// Clamp rnd value to legal value
//
inline static Uns32 rndClamp(Uns32 rnd, Uns32 lo, Uns32 hi) {

    // ignore bit 4
    rnd &= 15;

    // out-of-range values are dealt with by inverting bit 3
    if((rnd<lo) || (rnd>hi)) {
        rnd ^= 8;
    }

    return rnd;
}

//
// Do VAESKF1
//
static void doVAESKF1(riscvP riscv, Uns64 crkl, Uns64 crkh, Uns32 rnd) {

    // clamp rnd to legal values 1-10
    rnd = rndClamp(rnd, 1, 10);

    Uns32 r   = rnd-1;
    Uns32 rc  = round_consts[r];
    v128  crk = {u64 : {crkl, crkh}};
    v128  w;

    w.u32[0] = crk.u32[0] ^ aes_subword_fwd(ROR32(crk.u32[3],8)) ^ rc;
    w.u32[1] = w.u32[0]   ^ crk.u32[1];
    w.u32[2] = w.u32[1]   ^ crk.u32[2];
    w.u32[3] = w.u32[2]   ^ crk.u32[3];

    // return result
    setResult128(riscv, w);
}

//
// Do VAESKF2
//
static void doVAESKF2(
    riscvP riscv,
    Uns64  rkbl,
    Uns64  rkbh,
    Uns64  crkl,
    Uns64  crkh,
    Uns32  rnd
) {
    // clamp rnd to legal values 2-14
    rnd = rndClamp(rnd, 2, 14);

    v128 rkb = {u64 : {rkbl, rkbh}};
    v128 crk = {u64 : {crkl, crkh}};
    v128 w;

    if(rnd & 1) {
        w.u32[0] = rkb.u32[0] ^ aes_subword_fwd(crk.u32[3]);
    } else {
        Uns32 rc = round_consts[rnd>>1];
        w.u32[0] = rkb.u32[0] ^ aes_subword_fwd(ROR32(crk.u32[3],8)) ^ rc;
    }

    w.u32[1] = w.u32[0] ^ rkb.u32[1];
    w.u32[2] = w.u32[1] ^ rkb.u32[2];
    w.u32[3] = w.u32[2] ^ rkb.u32[3];

    // return result
    setResult128(riscv, w);
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION GHASH CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Table of reversed bits in bytes
//
static const Uns8 brev8[] = {
    0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0,
    0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,
    0x08, 0x88, 0x48, 0xc8, 0x28, 0xa8, 0x68, 0xe8,
    0x18, 0x98, 0x58, 0xd8, 0x38, 0xb8, 0x78, 0xf8,
    0x04, 0x84, 0x44, 0xc4, 0x24, 0xa4, 0x64, 0xe4,
    0x14, 0x94, 0x54, 0xd4, 0x34, 0xb4, 0x74, 0xf4,
    0x0c, 0x8c, 0x4c, 0xcc, 0x2c, 0xac, 0x6c, 0xec,
    0x1c, 0x9c, 0x5c, 0xdc, 0x3c, 0xbc, 0x7c, 0xfc,
    0x02, 0x82, 0x42, 0xc2, 0x22, 0xa2, 0x62, 0xe2,
    0x12, 0x92, 0x52, 0xd2, 0x32, 0xb2, 0x72, 0xf2,
    0x0a, 0x8a, 0x4a, 0xca, 0x2a, 0xaa, 0x6a, 0xea,
    0x1a, 0x9a, 0x5a, 0xda, 0x3a, 0xba, 0x7a, 0xfa,
    0x06, 0x86, 0x46, 0xc6, 0x26, 0xa6, 0x66, 0xe6,
    0x16, 0x96, 0x56, 0xd6, 0x36, 0xb6, 0x76, 0xf6,
    0x0e, 0x8e, 0x4e, 0xce, 0x2e, 0xae, 0x6e, 0xee,
    0x1e, 0x9e, 0x5e, 0xde, 0x3e, 0xbe, 0x7e, 0xfe,
    0x01, 0x81, 0x41, 0xc1, 0x21, 0xa1, 0x61, 0xe1,
    0x11, 0x91, 0x51, 0xd1, 0x31, 0xb1, 0x71, 0xf1,
    0x09, 0x89, 0x49, 0xc9, 0x29, 0xa9, 0x69, 0xe9,
    0x19, 0x99, 0x59, 0xd9, 0x39, 0xb9, 0x79, 0xf9,
    0x05, 0x85, 0x45, 0xc5, 0x25, 0xa5, 0x65, 0xe5,
    0x15, 0x95, 0x55, 0xd5, 0x35, 0xb5, 0x75, 0xf5,
    0x0d, 0x8d, 0x4d, 0xcd, 0x2d, 0xad, 0x6d, 0xed,
    0x1d, 0x9d, 0x5d, 0xdd, 0x3d, 0xbd, 0x7d, 0xfd,
    0x03, 0x83, 0x43, 0xc3, 0x23, 0xa3, 0x63, 0xe3,
    0x13, 0x93, 0x53, 0xd3, 0x33, 0xb3, 0x73, 0xf3,
    0x0b, 0x8b, 0x4b, 0xcb, 0x2b, 0xab, 0x6b, 0xeb,
    0x1b, 0x9b, 0x5b, 0xdb, 0x3b, 0xbb, 0x7b, 0xfb,
    0x07, 0x87, 0x47, 0xc7, 0x27, 0xa7, 0x67, 0xe7,
    0x17, 0x97, 0x57, 0xd7, 0x37, 0xb7, 0x77, 0xf7,
    0x0f, 0x8f, 0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef,
    0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff
};

//
// Reverse order of bytes in 128-bit vector v
//
inline static v128 brev8_128(v128 v) {

    Uns32 i;

    for(i=0; i<16; i++) {
        v.u8[i] = brev8[v.u8[i]];
    }

    return v;
}

//
// Do VGMUL
//
static void doVGMUL(
    riscvP riscv,
    Uns64  vdl,
    Uns64  vdh,
    Uns64  vs2l,
    Uns64  vs2h
) {
    v128  H = {u64 : {vs2l, vs2h}};
    v128  Y = {u64 : {vdl,  vdh}};
    v128  Z = {{0}};
    Uns32 bit;

    // operands are input with bits reversed in each byte
    H = brev8_128(H);
    Y = brev8_128(Y);

    for(bit=0; bit<128; bit++) {

        if(Y.u64[0] & 1) {
            Z.u64[0] ^= H.u64[0];
            Z.u64[1] ^= H.u64[1];
        }

        // right shift Y by 1
        Y.u64[0] >>= 1;
        Y.u64[0]  |= (Y.u64[1]<<63);
        Y.u64[1] >>= 1;

        // left shift H by 1 and reduce using x^7 + x^2 + x^1 + 1 polynomial
        // if required
        Uns8 polynomial = (H.u64[1]>>63) ? 0x87 : 0;
        H.u64[1] <<= 1;
        H.u64[1]  |= (H.u64[0]>>63);
        H.u64[0] <<= 1;
        H.u64[0]  ^= polynomial;
    }

    // bit reverse bytes of product to get back to GCM standard ordering
    v128 result = brev8_128(Z);

    // return result
    setResult128(riscv, result);
}

//
// Do VGHSH
//
static void doVGHSH(
    riscvP riscv,
    Uns64  vdl,
    Uns64  vdh,
    Uns64  vs2l,
    Uns64  vs2h,
    Uns64  vs1l,
    Uns64  vs1h
) {
    doVGMUL(riscv, vdl^vs1l, vdh^vs1h, vs2l, vs2h);
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION SSM3 CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Reverse bytes in 32-bit word
//
inline static Uns32 rev8(Uns32 x) {
    return (
        ((x             ) << 24) |
        ((x & 0x0000FF00) <<  8) |
        ((x & 0x00FF0000) >>  8) |
        ((x             ) >> 24)
    );
}

//
// Do SSM3_P0 (32-bit registers)
//
static Uns32 doSSM3_P032(Uns32 rs1) {
    return rs1 ^ ROL32(rs1,9) ^ ROL32(rs1,17);
}

//
// Do SSM3_P0 (64-bit registers)
//
static Uns64 doSSM3_P064(Uns64 rs1) {
    return doSSM3_P032(rs1);
}

//
// Do SSM3_P1 (32-bit registers)
//
static Uns32 doSSM3_P132(Uns32 rs1) {
    return rs1 ^ ROL32(rs1,15) ^ ROL32(rs1,23);
}

//
// Do SSM3_P1 (64-bit registers)
//
static Uns64 doSSM3_P164(Uns64 rs1) {
    return doSSM3_P132(rs1);
}

//
// VSM3ME helper function P1
//
inline static Uns32 P1(Uns32 X) {
    return X ^ ROL32(X,15) ^ ROL32(X,23);
}

//
// VSM3ME helper function ZVKSH_W
//
inline static Uns32 ZVKSH_W(Uns32 M16, Uns32 M9, Uns32 M3, Uns32 M13, Uns32 M6) {
    return P1(M16 ^ M9 ^ ROL32(M3,15)) ^ ROL32(M13,7) ^ M6;
}

//
// Do VSM3ME
//
static void doVSM3ME(
    riscvP riscv,
    Uns64  vs2a,
    Uns64  vs2b,
    Uns64  vs2c,
    Uns64  vs2d,
    Uns64  vs1a,
    Uns64  vs1b,
    Uns64  vs1c,
    Uns64  vs1d
) {
    Uns32 w[24] = {
        vs1a, vs1a>>32, vs1b, vs1b>>32, vs1c, vs1c>>32, vs1d, vs1d>>32,
        vs2a, vs2a>>32, vs2b, vs2b>>32, vs2c, vs2c>>32, vs2d, vs2d>>32
    };

    v256  result;
    Uns32 i;

    // byte swap inputs from big-endian to little-endian
    for(i=0; i<16; i++) {
        w[i] = rev8(w[i]);
    }

    // Arguments are W[i-16], W[i-9], W[i-3], W[i-13], W[i-6]
    // Note that some of the newly computed words are used in later
    // invocations
    for(i=0; i<8; i++) {
        w[i+16] = ZVKSH_W(w[i+0], w[i+7], w[i+13], w[i+3], w[i+10]);
    }

    // byte swap outputs from little-endian back to big-endian
    for(i=0; i<8; i++) {
        result.u32[i] = rev8(w[i+16]);
    }

    // return result
    setResult256(riscv, result);
}

//
// VSM3C helper function FF1
//
inline static Uns32 FF1(Uns32 X, Uns32 Y, Uns32 Z) {
    return X ^ Y ^ Z;
}

//
// VSM3C helper function FF2
//
inline static Uns32 FF2(Uns32 X, Uns32 Y, Uns32 Z) {
    return (X & Y) | (X & Z) | (Y & Z);
}

//
// VSM3C helper function FF_j
//
inline static Uns32 FF_j(Uns32 X, Uns32 Y, Uns32 Z, Uns32 J) {
    return (J <= 15) ? FF1(X, Y, Z) : FF2(X, Y, Z);
}

//
// VSM3C helper function GG1
//
inline static Uns32 GG1(Uns32 X, Uns32 Y, Uns32 Z) {
    return X ^ Y ^ Z;
}

//
// VSM3C helper function GG2
//
inline static Uns32 GG2(Uns32 X, Uns32 Y, Uns32 Z) {
    return (X & Y) | (~X & Z);
}

//
// VSM3C helper function GG_j
//
inline static Uns32 GG_j(Uns32 X, Uns32 Y, Uns32 Z, Uns32 J) {
    return (J <= 15) ? GG1(X, Y, Z) : GG2(X, Y, Z);
}

//
// VSM3C helper function T_j
//
inline static Uns32 T_j(Uns32 J) {
    return (J <= 15) ? 0x79CC4519 : 0x7A879D8A;
}

//
// VSM3C helper function P_0
//
inline static Uns32 P_0(Uns32 X) {
    return X ^ ROL32(X,9) ^ ROL32(X,17);
}

//
// Do VSM3C
//
static void doVSM3C(
    riscvP riscv,
    Uns64  vda,
    Uns64  vdb,
    Uns64  vdc,
    Uns64  vdd,
    Uns64  vs2a,
    Uns64  vs2b,
    Uns64  vs2c,
    Uns64  vs2d,
    Uns32  rnds
) {
    // load state with swap to little endian
    Uns32 H    = rev8(vdd>>32);
    Uns32 G[3] = {rev8(vdd)};
    Uns32 F    = rev8(vdc>>32);
    Uns32 E[3] = {rev8(vdc)};
    Uns32 D    = rev8(vdb>>32);
    Uns32 C[3] = {rev8(vdb)};
    Uns32 B    = rev8(vda>>32);
    Uns32 A[3] = {rev8(vda)};

    // load message schedule with swap to little endian
    Uns32 w0 = rev8(vs2a);
    Uns32 w1 = rev8(vs2a>>32);
    Uns32 w4 = rev8(vs2c);
    Uns32 w5 = rev8(vs2c>>32);

    Uns32 w[2] = {w0,      w1};
    Uns32 x[2] = {w0 ^ w4, w1 ^ w5};

    Uns32 i;

    for(i=0; i<2; i++) {

        Uns32 j   = (2*rnds)+i;
        Uns32 ss1 = ROL32(ROL32(A[i], 12) + E[i] + ROL32(T_j(j), j % 32), 7);
        Uns32 ss2 = ss1 ^ ROL32(A[i], 12);
        Uns32 tt1 = FF_j(A[i], B, C[i], j) + D + ss2 + x[i];
        Uns32 tt2 = GG_j(E[i], F, G[i], j) + H + ss1 + w[i];

        D      = C[i];
        C[i+1] = ROL32(B, 9);
        B      = A[i];
        A[i+1] = tt1;
        H      = G[i];
        G[i+1] = ROL32(F, 19);
        F      = E[i];
        E[i+1] = P_0(tt2);
    }

    // update the destination register - swap back to big endian
    v256 result = {
        u32 : {
            rev8(A[2]), rev8(A[1]), rev8(C[2]), rev8(C[1]),
            rev8(E[2]), rev8(E[1]), rev8(G[2]), rev8(G[1])
        }
    };

    // return result
    setResult256(riscv, result);
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION SSM4 CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// SM4 forward SBox. SM4 has no inverse sbox.
//
static const Uns8 sm4_sbox[256] = {
    0xD6, 0x90, 0xE9, 0xFE, 0xCC, 0xE1, 0x3D, 0xB7, 0x16, 0xB6, 0x14, 0xC2,
    0x28, 0xFB, 0x2C, 0x05, 0x2B, 0x67, 0x9A, 0x76, 0x2A, 0xBE, 0x04, 0xC3,
    0xAA, 0x44, 0x13, 0x26, 0x49, 0x86, 0x06, 0x99, 0x9C, 0x42, 0x50, 0xF4,
    0x91, 0xEF, 0x98, 0x7A, 0x33, 0x54, 0x0B, 0x43, 0xED, 0xCF, 0xAC, 0x62,
    0xE4, 0xB3, 0x1C, 0xA9, 0xC9, 0x08, 0xE8, 0x95, 0x80, 0xDF, 0x94, 0xFA,
    0x75, 0x8F, 0x3F, 0xA6, 0x47, 0x07, 0xA7, 0xFC, 0xF3, 0x73, 0x17, 0xBA,
    0x83, 0x59, 0x3C, 0x19, 0xE6, 0x85, 0x4F, 0xA8, 0x68, 0x6B, 0x81, 0xB2,
    0x71, 0x64, 0xDA, 0x8B, 0xF8, 0xEB, 0x0F, 0x4B, 0x70, 0x56, 0x9D, 0x35,
    0x1E, 0x24, 0x0E, 0x5E, 0x63, 0x58, 0xD1, 0xA2, 0x25, 0x22, 0x7C, 0x3B,
    0x01, 0x21, 0x78, 0x87, 0xD4, 0x00, 0x46, 0x57, 0x9F, 0xD3, 0x27, 0x52,
    0x4C, 0x36, 0x02, 0xE7, 0xA0, 0xC4, 0xC8, 0x9E, 0xEA, 0xBF, 0x8A, 0xD2,
    0x40, 0xC7, 0x38, 0xB5, 0xA3, 0xF7, 0xF2, 0xCE, 0xF9, 0x61, 0x15, 0xA1,
    0xE0, 0xAE, 0x5D, 0xA4, 0x9B, 0x34, 0x1A, 0x55, 0xAD, 0x93, 0x32, 0x30,
    0xF5, 0x8C, 0xB1, 0xE3, 0x1D, 0xF6, 0xE2, 0x2E, 0x82, 0x66, 0xCA, 0x60,
    0xC0, 0x29, 0x23, 0xAB, 0x0D, 0x53, 0x4E, 0x6F, 0xD5, 0xDB, 0x37, 0x45,
    0xDE, 0xFD, 0x8E, 0x2F, 0x03, 0xFF, 0x6A, 0x72, 0x6D, 0x6C, 0x5B, 0x51,
    0x8D, 0x1B, 0xAF, 0x92, 0xBB, 0xDD, 0xBC, 0x7F, 0x11, 0xD9, 0x5C, 0x41,
    0x1F, 0x10, 0x5A, 0xD8, 0x0A, 0xC1, 0x31, 0x88, 0xA5, 0xCD, 0x7B, 0xBD,
    0x2D, 0x74, 0xD0, 0x12, 0xB8, 0xE5, 0xB4, 0xB0, 0x89, 0x69, 0x97, 0x4A,
    0x0C, 0x96, 0x77, 0x7E, 0x65, 0xB9, 0xF1, 0x09, 0xC5, 0x6E, 0xC6, 0x84,
    0x18, 0xF0, 0x7D, 0xEC, 0x3A, 0xDC, 0x4D, 0x20, 0x79, 0xEE, 0x5F, 0x3E,
    0xD7, 0xCB, 0x39, 0x48
};

//
// Do SSM4_ED (32-bit registers)
//
static Uns32 doSSM4_ED32(Uns32 rs1, Uns32 bs, Uns32 rs2) {

    Uns32 sb_in  = (rs2 >> (8*bs)) & 0xFF;
    Uns32 sb_out = sm4_sbox[sb_in];

    Uns32 linear = sb_out ^ (sb_out         <<  8) ^
                            (sb_out         <<  2) ^
                            (sb_out         << 18) ^
                           ((sb_out & 0x3f) << 26) ^
                           ((sb_out & 0xC0) << 10);

    Uns32 rotl = (linear << (8*bs)) | (linear >> (32-8*bs));

    return rotl ^ rs1;
}

//
// Do SSM4_ED (64-bit registers)
//
static Uns64 doSSM4_ED64(Uns64 rs1, Uns32 bs, Uns64 rs2) {
    return doSSM4_ED32(rs1, bs, rs2);
}

//
// Do SSM4_KS (32-bit registers)
//
static Uns32 doSSM4_KS32(Uns32 rs1, Uns32 bs, Uns32 rs2) {

    Uns32 sb_in  = (rs2 >> (8*bs)) & 0xFF;
    Uns32 sb_out = sm4_sbox[sb_in];

    Uns32 x = sb_out ^
        ((sb_out & 0x07) << 29) ^ ((sb_out & 0xFE) <<  7) ^
        ((sb_out & 0x01) << 23) ^ ((sb_out & 0xF8) << 13) ;

    Uns32 rotl = (x << (8*bs)) | (x >> (32-8*bs));

    return rotl ^ rs1;
}

//
// Do SSM4_KS (64-bit registers)
//
static Uns64 doSSM4_KS64(Uns64 rs1, Uns32 bs, Uns64 rs2) {
    return doSSM4_KS32(rs1, bs, rs2);
}

//
// SM4 Constant Key (CK) - section 7.3.2. of the IETF draft
//
static const Uns32 ck[] = {
  0x00070E15, 0x1C232A31, 0x383F464D, 0x545B6269,
  0x70777E85, 0x8C939AA1, 0xA8AFB6BD, 0xC4CBD2D9,
  0xE0E7EEF5, 0xFC030A11, 0x181F262D, 0x343B4249,
  0x50575E65, 0x6C737A81, 0x888F969D, 0xA4ABB2B9,
  0xC0C7CED5, 0xDCE3EAF1, 0xF8FF060D, 0x141B2229,
  0x30373E45, 0x4C535A61, 0x686F767D, 0x848B9299,
  0xA0A7AEB5, 0xBCC3CAD1, 0xD8DFE6ED, 0xF4FB0209,
  0x10171E25, 0x2C333A41, 0x484F565D, 0x646B7279
};

//
// Generate round key for VSM4K instructions
//
inline static Uns32 ROUND_KEY_VSM4K(Uns32 X, Uns32 S) {
    return X ^ S ^ ROL32(S, 13) ^ ROL32(S, 23);
}

//
// Generate round key for VSM4R instructions
//
inline static Uns32 ROUND_KEY_VSM4R(Uns32 X, Uns32 S) {
    return X ^ S ^ ROL32(S, 2) ^ ROL32(S, 10) ^ ROL32(S, 18) ^ ROL32(S, 24);
}

//
// Perform SM4 forward SBox of word
//
inline static Uns32 sm4_subword(Uns32 x) {
    return (
        (sm4_sbox[(x >>  0) & 0xFF] <<  0) |
        (sm4_sbox[(x >>  8) & 0xFF] <<  8) |
        (sm4_sbox[(x >> 16) & 0xFF] << 16) |
        (sm4_sbox[(x >> 24) & 0xFF] << 24)
    );
}

//
// Do VSM4K
//
static void doVSM4K(riscvP riscv, Uns64 rkl, Uns64 rkh, Uns32 uimm) {

    Uns32 crk[8] = {rkl, rkl>>32, rkh, rkh>>32};
    Uns32 rnd    = uimm & 7;
    v128  nrk;
    Uns32 i;

    for(i=0; i<4; i++) {
        Uns32 B = crk[i+1] ^ crk[i+2] ^ crk[i+3] ^ ck[(4*rnd)+i];
        Uns32 S = sm4_subword(B);
        nrk.u32[i] = crk[i+4] = ROUND_KEY_VSM4K(crk[i], S);
    }

    // return result
    setResult128(riscv, nrk);
}

//
// Do VSM4R
//
static void doVSM4R(riscvP riscv, Uns64 xl, Uns64 xh, Uns64 rkl, Uns64 rkh) {

    Uns32 X[8]   = { xl,  xl>>32,  xh,  xh>>32};
    Uns32 crk[4] = {rkl, rkl>>32, rkh, rkh>>32};
    v128  nrk;
    Uns32 i;

    for(i=0; i<4; i++) {
        Uns32 B = X[i+1] ^ X[i+2] ^ X[i+3] ^ crk[i];
        Uns32 S = sm4_subword(B);
        nrk.u32[i] = X[i+4] = ROUND_KEY_VSM4R(X[i], S);
    }

    // return result
    setResult128(riscv, nrk);
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION SHA256 CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

#define ROR32(a,amt) ((a << (-amt & (32-1))) | (a >> (amt & (32-1))))

//
// SHA256 helper function sig032
//
inline static Uns32 sig032(Uns32 x) {
    return ROR32(x,7) ^ ROR32(x,18) ^ (x>>3);
}

//
// SHA256 helper function sig132
//
inline static Uns32 sig132(Uns32 x) {
    return ROR32(x,17) ^ ROR32(x,19) ^ (x>>10);
}

//
// SHA256 helper function sum032
//
inline static Uns32 sum032(Uns32 x) {
    return ROR32(x,2) ^ ROR32(x,13) ^ ROR32(x,22);
}

//
// SHA256 helper function sum132
//
inline static Uns32 sum132(Uns32 x) {
    return ROR32(x,6) ^ ROR32(x,11) ^ ROR32(x,25);
}

//
// SHA256 helper function ch32
//
inline static Uns32 ch32(Uns32 x, Uns32 y, Uns32 z) {
    return (x & y) ^ ((~x) & z);
}

//
// SHA256 helper function maj32
//
inline static Uns32 maj32(Uns32 x, Uns32 y, Uns32 z) {
    return (x & y) ^ (x & z) ^ (y & z);
}

//
// Do SSHA256_SIG0 (32-bit registers)
//
static Uns32 doSSHA256_SIG032(Uns32 a) {
    return sig032(a);
}

//
// Do SSHA256_SIG0 (64-bit registers)
//
static Uns64 doSSHA256_SIG064(Uns64 a) {
    return sig032(a);
}

//
// Do SSHA256_SIG1 (32-bit registers)
//
static Uns32 doSSHA256_SIG132(Uns32 a) {
    return sig132(a);
}

//
// Do SSHA256_SIG1 (64-bit registers)
//
static Uns64 doSSHA256_SIG164(Uns64 a) {
    return sig132(a);
}

//
// Do SSHA256_SUM0 (32-bit registers)
//
static Uns32 doSSHA256_SUM032(Uns32 a) {
    return sum032(a);
}

//
// Do SSHA256_SUM0 (64-bit registers)
//
static Uns64 doSSHA256_SUM064(Uns64 a) {
    return sum032(a);
}

//
// Do SSHA256_SUM1 (32-bit registers)
//
static Uns32 doSSHA256_SUM132(Uns32 a) {
    return sum132(a);
}

//
// Do SSHA256_SUM1 (64-bit registers)
//
static Uns64 doSSHA256_SUM164(Uns64 a) {
    return sum132(a);
}

//
// Do VSHA2MS (SHA-256)
//
static void doVSHA2MS32(
    riscvP riscv,
    Uns64  vdl,
    Uns64  vdh,
    Uns64  vs2l,
    Uns64  vs2h,
    Uns64  vs1l,
    Uns64  vs1h
) {
    Uns32 W[20] = {
        [0]  = vdl,     [1]  = vdl>>32,     [2]  = vdh,     [3]  = vdh>>32,
        [4]  = vs2l,    [9]  = vs2l>>32,    [10] = vs2h,    [11] = vs2h>>32,
        [12] = vs1l,    [13] = vs1l>>32,    [14] = vs1h,    [15] = vs1h>>32,
    };

    v128  result;
    Uns32 i;

    for(i=0; i<4; i++) {
        result.u32[i] = W[i+16] = sig132(W[i+14]) + W[i+9] + sig032(W[i+1]) + W[i];
    }

    // return result
    setResult128(riscv, result);
}

//
// Do VSHA2C (SHA-256)
//
static void doVSHA2C32(
    riscvP riscv,
    Uns64  vdl,
    Uns64  vdh,
    Uns64  vs2l,
    Uns64  vs2h,
    Uns64  vs1
) {
    Uns32 a    = vs2h>>32;
    Uns32 b    = vs2h;
    Uns32 e    = vs2l>>32;
    Uns32 f    = vs2l;
    Uns32 c    = vdh>>32;
    Uns32 d    = vdh;
    Uns32 g    = vdl>>32;
    Uns32 h    = vdl;
    Uns32 W[2] = {vs1, vs1>>32};
    Uns32 i;

    for(i=0; i<2; i++) {

        Uns32 T1 = h + sum132(e) + ch32(e,f,g) + W[i];
        Uns32 T2 = sum032(a) + maj32(a,b,c);

        h = g;
        g = f;
        f = e;
        e = d + T1;
        d = c;
        c = b;
        b = a;
        a = T1 + T2;
    }

    v128 result = {u32 : {f,e,b,a}};

    // return result
    setResult128(riscv, result);
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION SHA512 CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

#define ROR64(a,amt) ((a << (-amt & (64-1))) | (a >> (amt & (64-1))))

//
// SHA512 helper function sig064
//
inline static Uns64 sig064(Uns64 x) {
    return ROR64(x,1) ^ ROR64(x,8) ^ (x>>7);
}

//
// SHA512 helper function sig164
//
inline static Uns64 sig164(Uns64 x) {
    return ROR64(x,19) ^ ROR64(x,61) ^ (x>>6);
}

//
// SHA512 helper function sum064
//
inline static Uns64 sum064(Uns64 x) {
    return ROR64(x,28) ^ ROR64(x,34) ^ ROR64(x,39);
}

//
// SHA512 helper function sum164
//
inline static Uns64 sum164(Uns64 x) {
    return ROR64(x,14) ^ ROR64(x,18) ^ ROR64(x,41);
}

//
// SHA512 helper function ch64
//
inline static Uns64 ch64(Uns64 x, Uns64 y, Uns64 z) {
    return (x & y) ^ ((~x) & z);
}

//
// SHA512 helper function maj64
//
inline static Uns64 maj64(Uns64 x, Uns64 y, Uns64 z) {
    return (x & y) ^ (x & z) ^ (y & z);
}

//
// Do SSHA512_SIG0L
//
static Uns32 doSSHA512_SIG0L(Uns32 rs1, Uns32 rs2) {
    return (rs1>>1) ^ (rs1>>7) ^ (rs1>>8) ^ (rs2<<31) ^ (rs2<<25) ^ (rs2<<24);
}

//
// Do SSHA512_SIG0H
//
static Uns32 doSSHA512_SIG0H(Uns32 rs1, Uns32 rs2) {
    return (rs1>>1) ^ (rs1>>7) ^ (rs1>>8) ^ (rs2<<31) ^ (rs2<<24);
}

//
// Do SSHA512_SIG1L
//
static Uns32 doSSHA512_SIG1L(Uns32 rs1, Uns32 rs2) {
    return (rs1<<3) ^ (rs1>>6) ^ (rs1>>19) ^ (rs2>>29) ^ (rs2<<26) ^ (rs2<<13);
}

//
// Do SSHA512_SIG1H
//
static Uns32 doSSHA512_SIG1H(Uns32 rs1, Uns32 rs2) {
    return (rs1<<3) ^ (rs1>>6) ^ (rs1>>19) ^ (rs2>>29) ^ (rs2<<13);
}

//
// Do SSHA512_SUM0R
//
static Uns32 doSSHA512_SUM0R(Uns32 rs1, Uns32 rs2) {
    return (rs1<<25) ^ (rs1<<30) ^ (rs1>>28) ^ (rs2>>7) ^ (rs2>>2) ^ (rs2<<4);
}

//
// Do SSHA512_SUM1R
//
static Uns32 doSSHA512_SUM1R(Uns32 rs1, Uns32 rs2) {
    return (rs1<<23) ^ (rs1>>14) ^ (rs1>>18) ^ (rs2>>9) ^ (rs2<<18) ^ (rs2<<14);
}

//
// Do SSHA512_SIG0
//
static Uns64 doSSHA512_SIG0(Uns64 a) {
    return sig064(a);
}

//
// Do SSHA512_SIG1
//
static Uns64 doSSHA512_SIG1(Uns64 a) {
    return sig164(a);
}

//
// Do SSHA512_SUM0
//
static Uns64 doSSHA512_SUM0(Uns64 a) {
    return sum064(a);
}

//
// Do SSHA512_SUM1
//
static Uns64 doSSHA512_SUM1(Uns64 a) {
    return sum164(a);
}

//
// Do VSHA2MS (SHA-512)
//
static void doVSHA2MS64(
    riscvP riscv,
    Uns64  vda,
    Uns64  vdb,
    Uns64  vdc,
    Uns64  vdd,
    Uns64  vs2a,
    Uns64  vs2b,
    Uns64  vs2c,
    Uns64  vs2d,
    Uns64  vs1a,
    Uns64  vs1b,
    Uns64  vs1c,
    Uns64  vs1d
) {
    Uns64 W[20] = {
        [0]  = vda,     [1]  = vdb,     [2]  = vdc,     [3]  = vdd,
        [4]  = vs2a,    [9]  = vs2b,    [10] = vs2c,    [11] = vs2d,
        [12] = vs1a,    [13] = vs1b,    [14] = vs1c,    [15] = vs1d,
    };

    v256  result;
    Uns32 i;

    for(i=0; i<4; i++) {
        result.u64[i] = W[i+16] = sig164(W[i+14]) + W[i+9] + sig064(W[i+1]) + W[i];
    }

    // return result
    setResult256(riscv, result);
}

//
// Do VSHA2C (SHA-512)
//
static void doVSHA2C64(
    riscvP riscv,
    Uns64  vda,
    Uns64  vdb,
    Uns64  vdc,
    Uns64  vdd,
    Uns64  vs2a,
    Uns64  vs2b,
    Uns64  vs2c,
    Uns64  vs2d,
    Uns64  vs1a,
    Uns64  vs1b
) {
    Uns64 a    = vs2d;
    Uns64 b    = vs2c;
    Uns64 e    = vs2b;
    Uns64 f    = vs2a;
    Uns64 c    = vdd;
    Uns64 d    = vdc;
    Uns64 g    = vdb;
    Uns64 h    = vda;
    Uns64 W[2] = {vs1a, vs1b};
    Uns32 i;

    for(i=0; i<2; i++) {

        Uns64 T1 = h + sum164(e) + ch64(e,f,g) + W[i];
        Uns64 T2 = sum064(a) + maj64(a,b,c);

        h = g;
        g = f;
        f = e;
        e = d + T1;
        d = c;
        c = b;
        b = a;
        a = T1 + T2;
    }

    v256 result = {u64 : {f,e,b,a}};

    // return result
    setResult256(riscv, result);
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION POLLENTROPY CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Get cryptographic extension version
//
inline static riscvCryptoVer getCryptoVersion(riscvP riscv) {
    return riscv->configInfo.crypto_version;
}

//
// Do PollEntropy (NOTE: unlike hardware, this is designed to produce a
// deterministic, not-particularly-random sequence, always returning ES16
// status)
//
Uns32 riscvPollEntropy(riscvP riscv) {

    Uns32 result = 0;

    if(!RD_CSR_FIELDC(riscv, mnoise, NOISE_TEST)) {

        // generate entropy value
        Uns32 lfsr = riscv->entropyLFSR;

        // seed lfsr if required
        if(!lfsr) {
            lfsr = (RD_CSRC(riscv, mhartid) ^ 0xdeadbeef) ? : 0xdeadbeef;
        }

        // update lfsr to obtain pseudo-random pollentropy result
        lfsr = ((lfsr >> 1) ^ (-(Int32)(lfsr & 1) & 0x8000000));

        riscv->entropyLFSR = lfsr;

        // ES16 code is 1 prior to 1,0,0-rc1, 2 thereafter
        Uns32 ES16 = ((getCryptoVersion(riscv)>=RVKV_1_0_0_RC1) ? 2 : 1) << 30;

        result = (lfsr&0xffff) | ES16;
    }

    return result;
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION OPERATION DESCRIPTORS
////////////////////////////////////////////////////////////////////////////////

DEFINE_CS(opDesc);

//
// Details of operation
//
typedef struct opDescS {
    vmiCallFn      cb32;        // 32-bit implementation
    vmiCallFn      cb64;        // 64-bit implementation
    riscvCryptoSet subset;      // feature subset per version
} opDesc;


//
// Entry with subset only
//
#define OPENTRY_S(_S) { \
    subset:RVKS_##_S                            \
}

//
// Entry with subset and 32/64 bit callbacks
//
#define OPENTRY_S_CB(_S, _CB) { \
    subset:RVKS_##_S,                           \
    cb32:(vmiCallFn)do##_CB##32,                \
    cb64:(vmiCallFn)do##_CB##64                 \
}

//
// Entry with subset and 32 bit callback only
//
#define OPENTRY_S_CB32(_S, _CB32) { \
    subset:RVKS_##_S,                           \
    cb32:(vmiCallFn)do##_CB32                   \
}

//
// Entry with subset and 64 bit callback only
//
#define OPENTRY_S_CB64(_S, _CB64) { \
    subset:RVKS_##_S,                           \
    cb64:(vmiCallFn)do##_CB64                   \
}

//
// Get description for missing instruction subset
//
static const char* getSubsetDesc(riscvCryptoSet requiredSet) {

    // get feature description
    const char *description = 0;

    // get missing subset description (NOTE: RVKS_Zkr controls presence of CSRs
    // and has no effect here)
    switch(requiredSet) {

        // ALWAYS ABSENT
        case RVKS_Zk_    : description = "always";      break;

        // LEGACY B EXTENSION INSTRUCTIONS
        case RVKS_Zbkb   : description = "Zbkb";        break;

        // INDIVIDUAL SETS
        case RVKS_Zkr    : description = "Zkr";         break; // LCOV_EXCL_LINE
        case RVKS_Zknd   : description = "Zknd";        break;
        case RVKS_Zkne   : description = "Zkne";        break;
        case RVKS_Zknh   : description = "Zknh";        break;
        case RVKS_Zksed  : description = "Zksed";       break;
        case RVKS_Zksh   : description = "Zksh";        break;
        case RVKS_Zvbb   : description = "Zvbb";        break;
        case RVKS_Zvbc   : description = "Zvbc";        break;
        case RVKS_Zvkg   : description = "Zvkg";        break;
        case RVKS_Zvknha : description = "Zvknha";      break;
        case RVKS_Zvknhb : description = "Zvknhb";      break;
        case RVKS_Zvkned : description = "Zvkned";      break;
        case RVKS_Zvksed : description = "Zvksed";      break;
        case RVKS_Zvksh  : description = "Zvksh";       break;
        default          :                              break; // LCOV_EXCL_LINE
    }

    // sanity check known subset
    VMI_ASSERT(description, "unexpected subset 0x%x", requiredSet);

    return description;
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION PUBLIC INTERFACE
////////////////////////////////////////////////////////////////////////////////

//
// Entries with subset only, version-invariant
//
#define KOPENTRYxV_S(_NAME, _S) [RVKOP_##_NAME] = { \
    [RVKV_0_7_2]     = OPENTRY_S(_S),              \
    [RVKV_0_8_1]     = OPENTRY_S(_S),              \
    [RVKV_0_9_0]     = OPENTRY_S(_S),              \
    [RVKV_0_9_2]     = OPENTRY_S(_S),              \
    [RVKV_1_0_0_RC1] = OPENTRY_S(_S),              \
    [RVKV_1_0_0_RC5] = OPENTRY_S(_S),              \
}

//
// Entries with subset and 32/64 bit callbacks, version-invariant
//
#define KOPENTRYxV_S_CB(_NAME, _S, _CB) [RVKOP_##_NAME] = { \
    [RVKV_0_7_2]     = OPENTRY_S_CB(_S, _CB),      \
    [RVKV_0_8_1]     = OPENTRY_S_CB(_S, _CB),      \
    [RVKV_0_9_0]     = OPENTRY_S_CB(_S, _CB),      \
    [RVKV_0_9_2]     = OPENTRY_S_CB(_S, _CB),      \
    [RVKV_1_0_0_RC1] = OPENTRY_S_CB(_S, _CB),      \
    [RVKV_1_0_0_RC5] = OPENTRY_S_CB(_S, _CB),      \
}

//
// Entries with subset and 32 bit callback only, version-invariant
//
#define KOPENTRYxV_S_CB32(_NAME, _S, _CB32) [RVKOP_##_NAME] = { \
    [RVKV_0_7_2]     = OPENTRY_S_CB32(_S, _CB32),  \
    [RVKV_0_8_1]     = OPENTRY_S_CB32(_S, _CB32),  \
    [RVKV_0_9_0]     = OPENTRY_S_CB32(_S, _CB32),  \
    [RVKV_0_9_2]     = OPENTRY_S_CB32(_S, _CB32),  \
    [RVKV_1_0_0_RC1] = OPENTRY_S_CB32(_S, _CB32),  \
    [RVKV_1_0_0_RC5] = OPENTRY_S_CB32(_S, _CB32),  \
}

//
// Entries with subset and 64 bit callback only, version-invariant
//
#define KOPENTRYxV_S_CB64(_NAME, _S, _CB64) [RVKOP_##_NAME] = { \
    [RVKV_0_7_2]     = OPENTRY_S_CB64(_S, _CB64),  \
    [RVKV_0_8_1]     = OPENTRY_S_CB64(_S, _CB64),  \
    [RVKV_0_9_0]     = OPENTRY_S_CB64(_S, _CB64),  \
    [RVKV_0_9_2]     = OPENTRY_S_CB64(_S, _CB64),  \
    [RVKV_1_0_0_RC1] = OPENTRY_S_CB64(_S, _CB64),  \
    [RVKV_1_0_0_RC5] = OPENTRY_S_CB64(_S, _CB64),  \
}

//
// Details of operation per version
//
static const opDesc kopInfo[RVKOP_LAST][RVKV_LAST] = {

    KOPENTRYxV_S      (Zkr,           Zkr                  ),
    KOPENTRYxV_S      (Zknd,          Zknd                 ),
    KOPENTRYxV_S      (Zkne,          Zkne                 ),
    KOPENTRYxV_S      (Zknh,          Zknh                 ),
    KOPENTRYxV_S      (Zksed,         Zksed                ),
    KOPENTRYxV_S      (Zksh,          Zksh                 ),

    KOPENTRYxV_S_CB   (LUT4LO,        Zkb,   LUT4LO        ),
    KOPENTRYxV_S_CB   (LUT4HI,        Zkb,   LUT4HI        ),
    KOPENTRYxV_S_CB64 (LUT4,          Zkb,   LUT4          ),

    KOPENTRYxV_S_CB32 (SAES32_ENCS,   Zkne,  SAES32_ENCS   ),
    KOPENTRYxV_S_CB32 (SAES32_ENCSM,  Zkne,  SAES32_ENCSM  ),
    KOPENTRYxV_S_CB32 (SAES32_DECS,   Zknd,  SAES32_DECS   ),
    KOPENTRYxV_S_CB32 (SAES32_DECSM,  Zknd,  SAES32_DECSM  ),

    KOPENTRYxV_S_CB64 (SAES64_KS1,    Zkne,  SAES64_KS1    ),
    KOPENTRYxV_S_CB64 (SAES64_KS2,    Zkne,  SAES64_KS2    ),
    KOPENTRYxV_S_CB64 (SAES64_IMIX,   Zknd,  SAES64_IMIX   ),
    KOPENTRYxV_S_CB64 (SAES64_ENCS,   Zkne,  SAES64_ENCS   ),
    KOPENTRYxV_S_CB64 (SAES64_ENCSM,  Zkne,  SAES64_ENCSM  ),
    KOPENTRYxV_S_CB64 (SAES64_DECS,   Zknd,  SAES64_DECS   ),
    KOPENTRYxV_S_CB64 (SAES64_DECSM,  Zknd,  SAES64_DECSM  ),

    KOPENTRYxV_S_CB   (SSM3_P0,       Zksh,  SSM3_P0       ),
    KOPENTRYxV_S_CB   (SSM3_P1,       Zksh,  SSM3_P1       ),
    KOPENTRYxV_S_CB   (SSM4_ED,       Zksed, SSM4_ED       ),
    KOPENTRYxV_S_CB   (SSM4_KS,       Zksed, SSM4_KS       ),

    KOPENTRYxV_S_CB   (SSHA256_SIG0,  Zknh,  SSHA256_SIG0  ),
    KOPENTRYxV_S_CB   (SSHA256_SIG1,  Zknh,  SSHA256_SIG1  ),
    KOPENTRYxV_S_CB   (SSHA256_SUM0,  Zknh,  SSHA256_SUM0  ),
    KOPENTRYxV_S_CB   (SSHA256_SUM1,  Zknh,  SSHA256_SUM1  ),

    KOPENTRYxV_S_CB32 (SSHA512_SIG0L, Zknh,  SSHA512_SIG0L ),
    KOPENTRYxV_S_CB32 (SSHA512_SIG0H, Zknh,  SSHA512_SIG0H ),
    KOPENTRYxV_S_CB32 (SSHA512_SIG1L, Zknh,  SSHA512_SIG1L ),
    KOPENTRYxV_S_CB32 (SSHA512_SIG1H, Zknh,  SSHA512_SIG1H ),
    KOPENTRYxV_S_CB32 (SSHA512_SUM0R, Zknh,  SSHA512_SUM0R ),
    KOPENTRYxV_S_CB32 (SSHA512_SUM1R, Zknh,  SSHA512_SUM1R ),
    KOPENTRYxV_S_CB64 (SSHA512_SIG0,  Zknh,  SSHA512_SIG0  ),
    KOPENTRYxV_S_CB64 (SSHA512_SIG1,  Zknh,  SSHA512_SIG1  ),
    KOPENTRYxV_S_CB64 (SSHA512_SUM0,  Zknh,  SSHA512_SUM0  ),
    KOPENTRYxV_S_CB64 (SSHA512_SUM1,  Zknh,  SSHA512_SUM1  ),
};

//
// Get operation description for this operation
//
inline static opDescCP getKOpDesc(riscvP riscv, riscvKExtOp op) {
    return &kopInfo[op][riscv->configInfo.crypto_version];
}

//
// Return implementation callback for K-extension operation and bits
//
vmiCallFn riscvGetKOpCB(riscvP riscv, riscvKExtOp op, Uns32 bits) {

    opDescCP  desc   = getKOpDesc(riscv, op);
    vmiCallFn result = (bits==32) ? desc->cb32 : desc->cb64;

    // sanity check a callback was found
    VMI_ASSERT(result, "missing K-extension callback (op=%u, bits=%u)", op, bits);

    return result;
}

//
// Validate that the K-extension subset is supported and enabled and take an
// Illegal Instruction exception if not
//
Bool riscvValidateKExtSubset(riscvP riscv, riscvKExtOp op) {

    if(op) {

        opDescCP       desc        = getKOpDesc(riscv, op);
        riscvCryptoSet requiredSet = desc->subset;

        // detect absent subset
        if(!(requiredSet&~riscv->configInfo.crypto_absent)) {
            riscvEmitIllegalInstructionAbsentSubset(getSubsetDesc(requiredSet));
            return False;
        }
    }

    return True;
}


////////////////////////////////////////////////////////////////////////////////
// VK-EXTENSION PUBLIC INTERFACE
////////////////////////////////////////////////////////////////////////////////

//
// Entries with subset only, version-invariant
//
#define VKOPENTRYxV_S(_NAME, _S) [RVVKOP_##_NAME] = { \
    [RVKVV_0_3_0]  = OPENTRY_S(_S),             \
    [RVKVV_0_5_2]  = OPENTRY_S(_S),             \
    [RVKVV_MASTER] = OPENTRY_S(_S),             \
}

//
// Entries with subset only, version-dependent
//
#define VKOPENTRYxV_SxV(_NAME, _0_3_0, _0_5_2, _MASTER) [RVVKOP_##_NAME] = { \
    [RVKVV_0_3_0]  = OPENTRY_S(_0_3_0),         \
    [RVKVV_0_5_2]  = OPENTRY_S(_0_5_2),         \
    [RVKVV_MASTER] = OPENTRY_S(_MASTER),        \
}

//
// Entries with subset and 32/64 bit callbacks, version-invariant
//
#define VKOPENTRYxV_S_CB(_NAME, _S, _CB) [RVVKOP_##_NAME] = { \
    [RVKVV_0_3_0]  = OPENTRY_S_CB(_S, _CB),     \
    [RVKVV_0_5_2]  = OPENTRY_S_CB(_S, _CB),     \
    [RVKVV_MASTER] = OPENTRY_S_CB(_S, _CB),     \
}

//
// Entries with subset and 32 bit callback only, version-invariant
//s
#define VKOPENTRYxV_S_CB32(_NAME, _S, _CB32) [RVVKOP_##_NAME] = { \
    [RVKVV_0_3_0]  = OPENTRY_S_CB32(_S, _CB32), \
    [RVKVV_0_5_2]  = OPENTRY_S_CB32(_S, _CB32), \
    [RVKVV_MASTER] = OPENTRY_S_CB32(_S, _CB32), \
}

//
// Details of operation per version
//
static const opDesc vkopInfo[RVVKOP_LAST][RVKVV_LAST] = {

    VKOPENTRYxV_SxV    (Zvbb,       Zvkb, Zvbb, Zvbb),
    VKOPENTRYxV_SxV    (Zvbb_0_4_5, Zk_,  Zvbb, Zvbb),
    VKOPENTRYxV_SxV    (Zvbc,       Zvkb, Zvbc, Zvbc),
    VKOPENTRYxV_SxV    (Zvkg,       Zvkg, Zvkg, Zvkg),
    VKOPENTRYxV_S      (Zvknha,     Zvknha          ),
    VKOPENTRYxV_S      (Zvknhb,     Zvknhb          ),
    VKOPENTRYxV_S      (Zvkned,     Zvkned          ),
    VKOPENTRYxV_S      (Zvksed,     Zvksed          ),
    VKOPENTRYxV_S      (Zvksh,      Zvksh           ),

    // vector operations implemented as callbacks
    VKOPENTRYxV_S_CB32 (VAESKF1,    Zvkned, VAESKF1 ),
    VKOPENTRYxV_S_CB32 (VAESKF2,    Zvkned, VAESKF2 ),
    VKOPENTRYxV_S_CB32 (VGMUL,      Zvkg,   VGMUL   ),
    VKOPENTRYxV_S_CB32 (VGHSH,      Zvkg,   VGHSH   ),
    VKOPENTRYxV_S_CB32 (VSM3ME,     Zvksh,  VSM3ME  ),
    VKOPENTRYxV_S_CB32 (VSM3C,      Zvksh,  VSM3C   ),
    VKOPENTRYxV_S_CB32 (VSM4K,      Zvksed, VSM4K   ),
    VKOPENTRYxV_S_CB32 (VSM4R,      Zvksed, VSM4R   ),
    VKOPENTRYxV_S_CB   (VSHA2MS,    Zvknha, VSHA2MS ),
    VKOPENTRYxV_S_CB   (VSHA2CL,    Zvknha, VSHA2C  ),
    VKOPENTRYxV_S_CB   (VSHA2CH,    Zvknha, VSHA2C  ),
};

//
// Get operation description for this operation
//
inline static opDescCP getVKOpDesc(riscvP riscv, riscvVKExtOp op) {
    return &vkopInfo[op][riscv->configInfo.vcrypto_version];
}

//
// Return implementation callback for VK-extension operation and bits
//
vmiCallFn riscvGetVKOpCB(riscvP riscv, riscvVKExtOp op, Uns32 bits) {

    opDescCP  desc   = getVKOpDesc(riscv, op);
    vmiCallFn result = (bits==32) ? desc->cb32 : desc->cb64;

    // sanity check a callback was found
    VMI_ASSERT(result, "missing VK-extension callback (op=%u, bits=%u)", op, bits);

    return result;
}

//
// Validate that the VK-extension subset is supported and enabled and take an
// Illegal Instruction exception if not
//
Bool riscvValidateVKExtSubset(riscvP riscv, riscvVKExtOp op) {

    if(op) {

        opDescCP       desc        = getVKOpDesc(riscv, op);
        riscvCryptoSet requiredSet = desc->subset;

        // select RVKS_Zvknha or RVKS_Zvknhb based on current SEW
        if((requiredSet==RVKS_Zvknha) && (riscvGetSEWMt(riscv)==SEWMT_64)) {
            requiredSet = RVKS_Zvknhb;
        }

        // detect absent subset
        if(!(requiredSet&~riscv->configInfo.crypto_absent)) {
            riscvEmitIllegalInstructionAbsentSubset(getSubsetDesc(requiredSet));
            return False;
        }
    }

    return True;
}


////////////////////////////////////////////////////////////////////////////////
// SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

//
// Save K-extension state not covered by register read/write API
//
void riscvCryptoSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
) {
    if(phase==SRT_END_CORE) {
        if(cryptoPresent(riscv)) {
            VMIRT_SAVE_FIELD(cxt, riscv, entropyLFSR);
        }
    }
}

//
// Restore K-extension state not covered by register read/write API
//
void riscvCryptoRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
) {
    if(phase==SRT_END_CORE) {
        if(cryptoPresent(riscv)) {
            VMIRT_RESTORE_FIELD(cxt, riscv, entropyLFSR);
        }
    }
}


