/*
 * Copyright (c) 2005-2021 Imperas Software Ltd., www.imperas.com
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

    u = (u << (8*bs)) | (u >> (32-8*bs));

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

    u = (u << (8*bs)) | (u >> (32-8*bs));

    return u ^ rs1;
}

//
// Do SAES32_DECS
//
static Uns32 doSAES32_DECS(Uns32 rs1, Uns32 bs, Uns32 rs2) {

    Uns8  t0 = rs2 >> (8*bs);
    Uns8  x  = AES_DEC_SBOX[t0];
    Uns32 u  = x;

    u = (u << (8*bs)) | (u >> (32-8*bs));

    return u ^ rs1;
}

//
// Do SAES32_DECSM
//
static Uns32 doSAES32_DECSM(Uns32 rs1, Uns32 bs, Uns32 rs2) {

    Uns8  t0 = rs2 >> (8*bs);
    Uns8  x  = AES_DEC_SBOX[t0];
    Uns32 u ;

    u = (AES_GFMUL(x,0xb) << 24) |
        (AES_GFMUL(x,0xd) << 16) |
        (AES_GFMUL(x,0x9) <<  8) |
        (AES_GFMUL(x,0xe) <<  0) ;

    u = (u << (8*bs)) | (u >> (32-8*bs));

    return u ^ rs1;
}

//
// Do SAES64_KS1
//
static Uns64 doSAES64_KS1(Uns64 rs1, Uns32 rnum) {

    Uns32 temp = (rs1 >> 32);
    Uns8  rcon = 0;

    if(rnum < 0xA) {

        static const Uns8 round_consts[] = {
            0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36
        };

        temp = (temp >> 8) | (temp << 24); // Rotate left by 8
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

    Uns32 col_0 = temp;
    Uns32 col_1 = temp >> 32       ;

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

    Uns32 col_0 = temp;
    Uns32 col_1 = temp >> 32;

    col_0 = AES_INVMIXCOLUMN(col_0);
    col_1 = AES_INVMIXCOLUMN(col_1);

    return ((Uns64)col_1 << 32) | col_0;
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION SSM3 CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

#define ROL32(a,amt) ((a >> (-amt & (32-1))) | (a << (amt & (32-1))))

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


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION SSM4 CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

// SM4 forward SBox. SM4 has no inverse sbox.
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


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION SHA256 CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

#define ROR32(a,amt) ((a << (-amt & (32-1))) | (a >> (amt & (32-1))))

//
// Do SSHA256_SIG0 (32-bit registers)
//
static Uns32 doSSHA256_SIG032(Uns32 a) {
    return ROR32(a,7) ^ ROR32(a,18) ^ (a>>3);
}

//
// Do SSHA256_SIG0 (64-bit registers)
//
static Uns64 doSSHA256_SIG064(Uns64 a) {
    return doSSHA256_SIG032(a);
}

//
// Do SSHA256_SIG1 (32-bit registers)
//
static Uns32 doSSHA256_SIG132(Uns32 a) {
    return ROR32(a,17) ^ ROR32(a,19) ^ (a>>10);
}

//
// Do SSHA256_SIG1 (64-bit registers)
//
static Uns64 doSSHA256_SIG164(Uns64 a) {
    return doSSHA256_SIG132(a);
}

//
// Do SSHA256_SUM0 (32-bit registers)
//
static Uns32 doSSHA256_SUM032(Uns32 a) {
    return ROR32(a,2) ^ ROR32(a,13) ^ ROR32(a,22);
}

//
// Do SSHA256_SUM0 (64-bit registers)
//
static Uns64 doSSHA256_SUM064(Uns64 a) {
    return doSSHA256_SUM032(a);
}

//
// Do SSHA256_SUM1 (32-bit registers)
//
static Uns32 doSSHA256_SUM132(Uns32 a) {
    return ROR32(a,6) ^ ROR32(a,11) ^ ROR32(a,25);
}

//
// Do SSHA256_SUM1 (64-bit registers)
//
static Uns64 doSSHA256_SUM164(Uns64 a) {
    return doSSHA256_SUM132(a);
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION SHA512 CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

#define ROR64(a,amt) ((a << (-amt & (64-1))) | (a >> (amt & (64-1))))

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
    return ROR64(a,1) ^ ROR64(a,8) ^ (a>>7);
}

//
// Do SSHA512_SIG1
//
static Uns64 doSSHA512_SIG1(Uns64 a) {
    return ROR64(a,19) ^ ROR64(a,61) ^ (a>>6);
}

//
// Do SSHA512_SUM0
//
static Uns64 doSSHA512_SUM0(Uns64 a) {
    return ROR64(a,28) ^ ROR64(a,34) ^ ROR64(a,39);
}

//
// Do SSHA512_SUM1
//
static Uns64 doSSHA512_SUM1(Uns64 a) {
    return ROR64(a,14) ^ ROR64(a,18) ^ ROR64(a,41);
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
// K-EXTENSION PUBLIC INTERFACE
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
// Entries with subset only, version-invariant
//
#define OPENTRYxV_S(_NAME, _S) [RVKOP_##_NAME] = { \
    [RVKV_0_7_2]     = OPENTRY_S(_S),               \
    [RVKV_0_8_1]     = OPENTRY_S(_S),               \
    [RVKV_0_9_0]     = OPENTRY_S(_S),               \
    [RVKV_0_9_2]     = OPENTRY_S(_S),               \
    [RVKV_1_0_0_RC1] = OPENTRY_S(_S),               \
    [RVKV_1_0_0_RC5] = OPENTRY_S(_S),               \
}

//
// Entries with subset and 32/64 bit callbacks, version-invariant
//
#define OPENTRYxV_S_CB(_NAME, _S, _CB) [RVKOP_##_NAME] = { \
    [RVKV_0_7_2]     = OPENTRY_S_CB(_S, _CB),       \
    [RVKV_0_8_1]     = OPENTRY_S_CB(_S, _CB),       \
    [RVKV_0_9_0]     = OPENTRY_S_CB(_S, _CB),       \
    [RVKV_0_9_2]     = OPENTRY_S_CB(_S, _CB),       \
    [RVKV_1_0_0_RC1] = OPENTRY_S_CB(_S, _CB),       \
    [RVKV_1_0_0_RC5] = OPENTRY_S_CB(_S, _CB),       \
}

//
// Entries with subset and 32 bit callback only, version-invariant
//
#define OPENTRYxV_S_CB32(_NAME, _S, _CB32) [RVKOP_##_NAME] = { \
    [RVKV_0_7_2]     = OPENTRY_S_CB32(_S, _CB32),   \
    [RVKV_0_8_1]     = OPENTRY_S_CB32(_S, _CB32),   \
    [RVKV_0_9_0]     = OPENTRY_S_CB32(_S, _CB32),   \
    [RVKV_0_9_2]     = OPENTRY_S_CB32(_S, _CB32),   \
    [RVKV_1_0_0_RC1] = OPENTRY_S_CB32(_S, _CB32),   \
    [RVKV_1_0_0_RC5] = OPENTRY_S_CB32(_S, _CB32),   \
}

//
// Entries with subset and 64 bit callback only, version-invariant
//
#define OPENTRYxV_S_CB64(_NAME, _S, _CB64) [RVKOP_##_NAME] = { \
    [RVKV_0_7_2]     = OPENTRY_S_CB64(_S, _CB64),   \
    [RVKV_0_8_1]     = OPENTRY_S_CB64(_S, _CB64),   \
    [RVKV_0_9_0]     = OPENTRY_S_CB64(_S, _CB64),   \
    [RVKV_0_9_2]     = OPENTRY_S_CB64(_S, _CB64),   \
    [RVKV_1_0_0_RC1] = OPENTRY_S_CB64(_S, _CB64),   \
    [RVKV_1_0_0_RC5] = OPENTRY_S_CB64(_S, _CB64),   \
}

//
// Details of operation per version
//
static const opDesc opInfo[RVKOP_LAST][RVKV_LAST] = {

    OPENTRYxV_S      (Zkr,           Zkr                  ),
    OPENTRYxV_S      (Zknd,          Zknd                 ),
    OPENTRYxV_S      (Zkne,          Zkne                 ),
    OPENTRYxV_S      (Zknh,          Zknh                 ),
    OPENTRYxV_S      (Zksed,         Zksed                ),
    OPENTRYxV_S      (Zksh,          Zksh                 ),

    OPENTRYxV_S_CB   (LUT4LO,        Zkb,   LUT4LO        ),
    OPENTRYxV_S_CB   (LUT4HI,        Zkb,   LUT4HI        ),
    OPENTRYxV_S_CB64 (LUT4,          Zkb,   LUT4          ),

    OPENTRYxV_S_CB32 (SAES32_ENCS,   Zkne,  SAES32_ENCS   ),
    OPENTRYxV_S_CB32 (SAES32_ENCSM,  Zkne,  SAES32_ENCSM  ),
    OPENTRYxV_S_CB32 (SAES32_DECS,   Zknd,  SAES32_DECS   ),
    OPENTRYxV_S_CB32 (SAES32_DECSM,  Zknd,  SAES32_DECSM  ),

    OPENTRYxV_S_CB64 (SAES64_KS1,    Zkne,  SAES64_KS1    ),
    OPENTRYxV_S_CB64 (SAES64_KS2,    Zkne,  SAES64_KS2    ),
    OPENTRYxV_S_CB64 (SAES64_IMIX,   Zknd,  SAES64_IMIX   ),
    OPENTRYxV_S_CB64 (SAES64_ENCS,   Zkne,  SAES64_ENCS   ),
    OPENTRYxV_S_CB64 (SAES64_ENCSM,  Zkne,  SAES64_ENCSM  ),
    OPENTRYxV_S_CB64 (SAES64_DECS,   Zknd,  SAES64_DECS   ),
    OPENTRYxV_S_CB64 (SAES64_DECSM,  Zknd,  SAES64_DECSM  ),

    OPENTRYxV_S_CB   (SSM3_P0,       Zksh,  SSM3_P0       ),
    OPENTRYxV_S_CB   (SSM3_P1,       Zksh,  SSM3_P1       ),
    OPENTRYxV_S_CB   (SSM4_ED,       Zksed, SSM4_ED       ),
    OPENTRYxV_S_CB   (SSM4_KS,       Zksed, SSM4_KS       ),

    OPENTRYxV_S_CB   (SSHA256_SIG0,  Zknh,  SSHA256_SIG0  ),
    OPENTRYxV_S_CB   (SSHA256_SIG1,  Zknh,  SSHA256_SIG1  ),
    OPENTRYxV_S_CB   (SSHA256_SUM0,  Zknh,  SSHA256_SUM0  ),
    OPENTRYxV_S_CB   (SSHA256_SUM1,  Zknh,  SSHA256_SUM1  ),

    OPENTRYxV_S_CB32 (SSHA512_SIG0L, Zknh,  SSHA512_SIG0L ),
    OPENTRYxV_S_CB32 (SSHA512_SIG0H, Zknh,  SSHA512_SIG0H ),
    OPENTRYxV_S_CB32 (SSHA512_SIG1L, Zknh,  SSHA512_SIG1L ),
    OPENTRYxV_S_CB32 (SSHA512_SIG1H, Zknh,  SSHA512_SIG1H ),
    OPENTRYxV_S_CB32 (SSHA512_SUM0R, Zknh,  SSHA512_SUM0R ),
    OPENTRYxV_S_CB32 (SSHA512_SUM1R, Zknh,  SSHA512_SUM1R ),
    OPENTRYxV_S_CB64 (SSHA512_SIG0,  Zknh,  SSHA512_SIG0  ),
    OPENTRYxV_S_CB64 (SSHA512_SIG1,  Zknh,  SSHA512_SIG1  ),
    OPENTRYxV_S_CB64 (SSHA512_SUM0,  Zknh,  SSHA512_SUM0  ),
    OPENTRYxV_S_CB64 (SSHA512_SUM1,  Zknh,  SSHA512_SUM1  ),
};

//
// Get operation description for this operation
//
inline static opDescCP getOpDesc(riscvP riscv, riscvKExtOp op) {
    return &opInfo[op][riscv->configInfo.crypto_version];
}

//
// Return implementation callback for K-extension operation and bits
//
vmiCallFn riscvGetKOpCB(riscvP riscv, riscvKExtOp op, Uns32 bits) {

    opDescCP  desc   = getOpDesc(riscv, op);
    vmiCallFn result = (bits==32) ? desc->cb32 : desc->cb64;

    // sanity check a callback was found
    VMI_ASSERT(result, "missing K-extension callback (op=%u, bits=%u)", op, bits);

    return result;
}

//
// Get description for missing instruction subset
//
static const char *getSubsetDesc(riscvCryptoSet requiredSet) {

    // get feature description
    const char *description = 0;

    // get missing subset description (NOTE: RVKS_Zkr controls presence of CSRs
    // and has no effect here)
    switch(requiredSet) {

        // LEGACY B EXTENSION INSTRUCTIONS
        case RVKS_Zbkb  : description = "Zbkb";   break;

        // INDIVIDUAL SETS
        case RVKS_Zkr   : description = "Zkr";    break; // LCOV_EXCL_LINE
        case RVKS_Zknd  : description = "Zknd";   break;
        case RVKS_Zkne  : description = "Zkne";   break;
        case RVKS_Zknh  : description = "Zknh";   break;
        case RVKS_Zksed : description = "Zksed";  break;
        case RVKS_Zksh  : description = "Zksh";   break;
        default         :                         break; // LCOV_EXCL_LINE
    }

    // sanity check known subset
    VMI_ASSERT(description, "unexpected subset 0x%x", requiredSet);

    return description;
}

//
// Validate that the instruction subset is supported and enabled and take an
// Illegal Instruction exception if not
//
Bool riscvValidateKExtSubset(riscvP riscv, riscvKExtOp op) {

    if(op) {

        opDescCP       desc        = getOpDesc(riscv, op);
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


