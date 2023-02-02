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
#include "riscvBExtension.h"
#include "riscvExceptions.h"
#include "riscvMessage.h"
#include "riscvMorph.h"
#include "riscvStructure.h"


////////////////////////////////////////////////////////////////////////////////
// B-EXTENSION CALLBACK FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Do GORC (32-bit registers)
//
static Uns32 doGORC32(Uns32 rs1, Uns32 rs2) {

    Uns32 x     = rs1;
    Uns32 shamt = rs2 & 31;

    if (shamt & 1)  x |= ((x & 0x55555555) << 1)  | ((x & 0xAAAAAAAA) >> 1);
    if (shamt & 2)  x |= ((x & 0x33333333) << 2)  | ((x & 0xCCCCCCCC) >> 2);
    if (shamt & 4)  x |= ((x & 0x0F0F0F0F) << 4)  | ((x & 0xF0F0F0F0) >> 4);
    if (shamt & 8)  x |= ((x & 0x00FF00FF) << 8)  | ((x & 0xFF00FF00) >> 8);
    if (shamt & 16) x |= ((x & 0x0000FFFF) << 16) | ((x & 0xFFFF0000) >> 16);

    return x;
}

//
// Do GORC (64-bit registers)
//
static Uns64 doGORC64(Uns64 rs1, Uns32 rs2) {

    Uns64 x     = rs1;
    Uns32 shamt = rs2 & 63;

    if (shamt & 1)  x |= ((x & 0x5555555555555555LL) << 1)  | ((x & 0xAAAAAAAAAAAAAAAALL) >> 1);
    if (shamt & 2)  x |= ((x & 0x3333333333333333LL) << 2)  | ((x & 0xCCCCCCCCCCCCCCCCLL) >> 2);
    if (shamt & 4)  x |= ((x & 0x0F0F0F0F0F0F0F0FLL) << 4)  | ((x & 0xF0F0F0F0F0F0F0F0LL) >> 4);
    if (shamt & 8)  x |= ((x & 0x00FF00FF00FF00FFLL) << 8)  | ((x & 0xFF00FF00FF00FF00LL) >> 8);
    if (shamt & 16) x |= ((x & 0x0000FFFF0000FFFFLL) << 16) | ((x & 0xFFFF0000FFFF0000LL) >> 16);
    if (shamt & 32) x |= ((x & 0x00000000FFFFFFFFLL) << 32) | ((x & 0xFFFFFFFF00000000LL) >> 32);

    return x;
}

//
// Do GREV (32-bit registers)
//
static Uns32 doGREV32(Uns32 rs1, Uns32 rs2) {

    Uns32 x     = rs1;
    Uns32 shamt = rs2 & 31;

    if (shamt & 1)  x = ((x & 0x55555555) << 1)  | ((x & 0xAAAAAAAA) >> 1);
    if (shamt & 2)  x = ((x & 0x33333333) << 2)  | ((x & 0xCCCCCCCC) >> 2);
    if (shamt & 4)  x = ((x & 0x0F0F0F0F) << 4)  | ((x & 0xF0F0F0F0) >> 4);
    if (shamt & 8)  x = ((x & 0x00FF00FF) << 8)  | ((x & 0xFF00FF00) >> 8);
    if (shamt & 16) x = ((x & 0x0000FFFF) << 16) | ((x & 0xFFFF0000) >> 16);

    return x;
}

//
// Do GREV (64-bit registers)
//
static Uns64 doGREV64(Uns64 rs1, Uns32 rs2) {

    Uns64 x     = rs1;
    Uns32 shamt = rs2 & 63;

    if (shamt & 1)  x = ((x & 0x5555555555555555LL) << 1)  | ((x & 0xAAAAAAAAAAAAAAAALL) >> 1);
    if (shamt & 2)  x = ((x & 0x3333333333333333LL) << 2)  | ((x & 0xCCCCCCCCCCCCCCCCLL) >> 2);
    if (shamt & 4)  x = ((x & 0x0F0F0F0F0F0F0F0FLL) << 4)  | ((x & 0xF0F0F0F0F0F0F0F0LL) >> 4);
    if (shamt & 8)  x = ((x & 0x00FF00FF00FF00FFLL) << 8)  | ((x & 0xFF00FF00FF00FF00LL) >> 8);
    if (shamt & 16) x = ((x & 0x0000FFFF0000FFFFLL) << 16) | ((x & 0xFFFF0000FFFF0000LL) >> 16);
    if (shamt & 32) x = ((x & 0x00000000FFFFFFFFLL) << 32) | ((x & 0xFFFFFFFF00000000LL) >> 32);

    return x;
}

//
// Do CRC32 (32-bit registers)
//
static Uns32 doCRC32_32(Uns32 x, Uns32 constant, Uns32 nbits) {

    Uns32 i;

    for(i = 0; i < nbits; i++) {
        x = (x >> 1) ^ (constant & ~((x&1)-1));
    }

    return x;
}

//
// Do CRC32 (64-bit registers)
//
static Uns64 doCRC32_64(Uns64 x, Uns32 constant, Uns32 nbits) {

    Uns32 i;

    for(i = 0; i < nbits; i++) {
        x = (x >> 1) ^ (constant & ~((x&1)-1));
    }

    return x;
}

//
// Population count
//
inline static Uns64 doPOPCOUNT64(Uns64 rs1) {
    return __builtin_popcountll(rs1);
}

//
// Do 32-bit shuffle stage
//
static Uns32 doSHFL32Stage(Uns32 src, Uns32 maskL, Uns32 maskR, int N) {

    Uns32 x = src & ~(maskL | maskR);

    x |= ((src << N) & maskL) | ((src >> N) & maskR);

    return x;
}

//
// Do 32-bit shuffle
//
static Uns32 doSHFL32(Uns32 rs1, Uns32 rs2) {

    Uns32 x     = rs1;
    Uns32 shamt = rs2 & 15;

    if (shamt & 8) x = doSHFL32Stage(x, 0x00ff0000, 0x0000ff00, 8);
    if (shamt & 4) x = doSHFL32Stage(x, 0x0f000f00, 0x00f000f0, 4);
    if (shamt & 2) x = doSHFL32Stage(x, 0x30303030, 0x0c0c0c0c, 2);
    if (shamt & 1) x = doSHFL32Stage(x, 0x44444444, 0x22222222, 1);

    return x;
}

//
// Do 32-bit unshuffle
//
static Uns32 doUNSHFL32(Uns32 rs1, Uns32 rs2) {

    Uns32 x     = rs1;
    Uns32 shamt = rs2 & 15;

    if (shamt & 1) x = doSHFL32Stage(x, 0x44444444, 0x22222222, 1);
    if (shamt & 2) x = doSHFL32Stage(x, 0x30303030, 0x0c0c0c0c, 2);
    if (shamt & 4) x = doSHFL32Stage(x, 0x0f000f00, 0x00f000f0, 4);
    if (shamt & 8) x = doSHFL32Stage(x, 0x00ff0000, 0x0000ff00, 8);

    return x;
}

//
// Do 64-bit shuffle stage
//
static Uns64 doSHFL64Stage(Uns64 src, Uns64 maskL, Uns64 maskR, int N) {

    Uns64 x = src & ~(maskL | maskR);

    x |= ((src << N) & maskL) | ((src >> N) & maskR);

    return x;
}

//
// Do 64-bit shuffle
//
static Uns64 doSHFL64(Uns64 rs1, Uns32 rs2) {

    Uns64 x     = rs1;
    Uns32 shamt = rs2 & 31;

    if (shamt & 16) x = doSHFL64Stage(x, 0x0000ffff00000000LL, 0x00000000ffff0000LL, 16);
    if (shamt & 8)  x = doSHFL64Stage(x, 0x00ff000000ff0000LL, 0x0000ff000000ff00LL, 8);
    if (shamt & 4)  x = doSHFL64Stage(x, 0x0f000f000f000f00LL, 0x00f000f000f000f0LL, 4);
    if (shamt & 2)  x = doSHFL64Stage(x, 0x3030303030303030LL, 0x0c0c0c0c0c0c0c0cLL, 2);
    if (shamt & 1)  x = doSHFL64Stage(x, 0x4444444444444444LL, 0x2222222222222222LL, 1);

    return x;
}

//
// Do 64-bit unshuffle
//
static Uns64 doUNSHFL64(Uns64 rs1, Uns64 rs2) {

    Uns64 x     = rs1;
    Uns32 shamt = rs2 & 31;

    if (shamt & 1)  x = doSHFL64Stage(x, 0x4444444444444444LL, 0x2222222222222222LL, 1);
    if (shamt & 2)  x = doSHFL64Stage(x, 0x3030303030303030LL, 0x0c0c0c0c0c0c0c0cLL, 2);
    if (shamt & 4)  x = doSHFL64Stage(x, 0x0f000f000f000f00LL, 0x00f000f000f000f0LL, 4);
    if (shamt & 8)  x = doSHFL64Stage(x, 0x00ff000000ff0000LL, 0x0000ff000000ff00LL, 8);
    if (shamt & 16) x = doSHFL64Stage(x, 0x0000ffff00000000LL, 0x00000000ffff0000LL, 16);

    return x;
}

//
// Do BMATFLIP (64-bit registers)
//
static Uns64 doBMATFLIP(Uns64 rs1) {

    Uns64 x = rs1;

    x = doSHFL64(x, 31);
    x = doSHFL64(x, 31);
    x = doSHFL64(x, 31);

    return x;
}

//
// Do BMATOR (64-bit registers)
//
static Uns64 doBMATOR(Uns64 rs1, Uns64 rs2) {

    Uns8  u[8]; // rows of rs1
    Uns8  v[8]; // cols of rs2
    Uns32 i;

    // transpose of rs2
    Uns64 rs2t = doBMATFLIP(rs2);

    for (i = 0; i < 8; i++) {
        u[i] = rs1 >> (i*8);
        v[i] = rs2t >> (i*8);
    }

    Uns64 x = 0;

    for (i = 0; i < 64; i++) {
        if ((u[i / 8] & v[i % 8]) != 0) {
            x |= 1LL << i;
        }
    }

    return x;
}

//
// Do BMATXOR (64-bit registers)
//
static Uns64 doBMATXOR(Uns64 rs1, Uns64 rs2) {

    Uns8  u[8]; // rows of rs1
    Uns8  v[8]; // cols of rs2
    Uns32 i;

    // transpose of rs2
    Uns64 rs2t = doBMATFLIP(rs2);

    for (i = 0; i < 8; i++) {
        u[i] = rs1 >> (i*8);
        v[i] = rs2t >> (i*8);
    }

    Uns64 x = 0;

    for (i = 0; i < 64; i++) {
        if (doPOPCOUNT64(u[i / 8] & v[i % 8]) & 1) {
            x |= 1LL << i;
        }
    }

    return x;
}

//
// Do BEXT (32-bit registers)
//
static Uns32 doBEXT32(Uns32 rs1, Uns32 rs2) {

    Uns32 r = 0;
    Uns32 i, j;

    for (i = 0, j = 0; i < 32; i++) {
        if ((rs2 >> i) & 1) {
            if ((rs1 >> i) & 1) {
                r |= (Uns32)1 << j;
            }
            j++;
        }
    }

    return r;
}

//
// Do BEXT (64-bit registers)
//
static Uns64 doBEXT64(Uns64 rs1, Uns64 rs2) {

    Uns64 r = 0;
    Uns32 i, j;

    for (i = 0, j = 0; i < 64; i++) {
        if ((rs2 >> i) & 1) {
            if ((rs1 >> i) & 1) {
                r |= (Uns64)1ULL << j;
            }
            j++;
        }
    }

    return r;
}

//
// Do BDEP (32-bit registers)
//
static Uns32 doBDEP32(Uns32 rs1, Uns32 rs2) {

    Uns32 r = 0;
    Uns32 i, j;

    for (i = 0, j = 0; i < 32; i++) {
        if ((rs2 >> i) & 1) {
            if ((rs1 >> j) & 1) {
                r |= (Uns32)1 << i;
            }
            j++;
        }
    }

    return r;
}

//
// Do BDEP (64-bit registers)
//
static Uns64 doBDEP64(Uns64 rs1, Uns64 rs2) {

    Uns64 r = 0;
    Uns32 i, j;

    for (i = 0, j = 0; i < 64; i++) {
        if ((rs2 >> i) & 1) {
            if ((rs1 >> j) & 1) {
                r |= (Uns64)1ULL << i;
            }
            j++;
        }
    }

    return r;
}

//
// Do FSL (32-bit registers)
//
static Uns32 doFSL32(Uns32 rs1, Uns32 rs2, Uns32 rs3) {

    Int32 XLEN  = 32;
    Int32 shamt = rs2 & (2*XLEN - 1);
    Uns32 A     = rs1;
    Uns32 B     = rs3;

    if (shamt >= XLEN) {
        shamt -= XLEN; A = rs3; B = rs1;
    }

    return shamt ? (A << shamt) | (B >> (XLEN-shamt)) : A;
}

//
// Do FSL (64-bit registers)
//
static Uns64 doFSL64(Uns64 rs1, Uns32 rs2, Uns64 rs3) {

    Int32 XLEN  = 64;
    Int32 shamt = rs2 & (2*XLEN - 1);
    Uns64 A     = rs1;
    Uns64 B     = rs3;

    if (shamt >= XLEN) {
        shamt -= XLEN; A = rs3; B = rs1;
    }

    return shamt ? (A << shamt) | (B >> (XLEN-shamt)) : A;
}

//
// Do FSR (32-bit registers)
//
static Uns32 doFSR32(Uns32 rs1, Uns32 rs2, Uns32 rs3) {

    Int32 XLEN  = 32;
    Int32 shamt = rs2 & (2*XLEN - 1);
    Uns32 A     = rs1;
    Uns32 B     = rs3;

    if (shamt >= XLEN) {
        shamt -= XLEN; A = rs3; B = rs1;
    }

    return shamt ? (A >> shamt) | (B << (XLEN-shamt)) : A;
}

//
// Do FSR (64-bit registers)
//
static Uns64 doFSR64(Uns64 rs1, Uns32 rs2, Uns64 rs3) {

    Int32 XLEN  = 64;
    Int32 shamt = rs2 & (2*XLEN - 1);
    Uns64 A     = rs1;
    Uns64 B     = rs3;

    if (shamt >= XLEN) {
        shamt -= XLEN; A = rs3; B = rs1;
    }

    return shamt ? (A >> shamt) | (B << (XLEN-shamt)) : A;
}

//
// Do ROL (32-bit registers)
//
inline static Uns32 doROL32(Uns32 rs1, Uns32 rs2) {

    Int32 XLEN  = 32;
    Int32 shamt = rs2 & (XLEN - 1);

    return (rs1 << shamt) | (rs1 >> ((XLEN - shamt) & (XLEN - 1)));
}

//
// Do SLO (32-bit registers)
//
inline static Uns32 doSLO32(Uns32 rs1, Uns32 rs2) {

    Int32 XLEN  = 32;
    Int32 shamt = rs2 & (XLEN - 1);

    return ~(~rs1 << shamt);
}

//
// Do BFP (32-bit registers, 0.91 semantics)
//
static Uns32 doBFP91_32(Uns32 rs1, Uns32 rs2) {

    Int32 XLEN = 32;
    Int32 len  = (rs2 >> 24) & 15;
    Int32 off  = (rs2 >> 16) & (XLEN-1);

    len = len ? len : 16;

    Uns32 mask = doROL32(doSLO32(0, len), off);
    Uns32 data = doROL32(rs2, off);

    return (data & mask) | (rs1 & ~mask);
}

//
// Do BFP (32-bit registers, 0.92 semantics)
//
static Uns32 doBFP92_32(Uns32 rs1, Uns32 rs2) {

    Int32 XLEN = 32;
    Uns32 cfg  = rs2 >> (XLEN/2);
    Int32 len  = (cfg >> 8) & (XLEN/2-1);
    Int32 off  = cfg & (XLEN-1);

    len = len ? len : XLEN/2;

    Uns32 mask = doSLO32(0, len) << off;
    Uns32 data = rs2 << off;

    return (data & mask) | (rs1 & ~mask);
}

//
// Do ROL (64-bit registers)
//
inline static Uns64 doROL64(Uns64 rs1, Uns64 rs2) {

    Int32 XLEN  = 64;
    Int32 shamt = rs2 & (XLEN - 1);

    return (rs1 << shamt) | (rs1 >> ((XLEN - shamt) & (XLEN - 1)));
}

//
// Do SLO (64-bit registers)
//
inline static Uns64 doSLO64(Uns64 rs1, Uns64 rs2) {

    Int32 XLEN  = 64;
    Int32 shamt = rs2 & (XLEN - 1);

    return ~(~rs1 << shamt);
}

//
// Do BFP (64-bit registers, 0.91 semantics)
//
static Uns64 doBFP91_64(Uns64 rs1, Uns64 rs2) {

    Int32 XLEN = 64;
    Int32 len  = (rs2 >> 24) & 15;
    Int32 off  = (rs2 >> 16) & (XLEN-1);

    len = len ? len : 16;

    Uns64 mask = doROL64(doSLO64(0, len), off);
    Uns64 data = doROL64(rs2, off);

    return (data & mask) | (rs1 & ~mask);
}

//
// Do BFP (64-bit registers, 0.92 semantics)
//
static Uns64 doBFP92_64(Uns64 rs1, Uns64 rs2) {

    Int32 XLEN = 64;
    Uns64 cfg  = rs2 >> (XLEN/2);

    if ((cfg >> 30) == 2) {
        cfg = cfg >> 16;
    }

    Int32 len = (cfg >> 8) & (XLEN/2-1);
    Int32 off = cfg & (XLEN-1);

    len = len ? len : XLEN/2;

    Uns64 mask = doSLO64(0, len) << off;
    Uns64 data = rs2 << off;

    return (data & mask) | (rs1 & ~mask);
}

//
// Do XPERM (32-bit registers)
//
static Uns32 doXPERM32(Uns32 rs1, Uns32 sz, Uns32 rs2) {

    Int32 XLEN = 32;
    Uns32 r    = 0;
    Uns32 mask = (1LL << sz) - 1;
    Uns32 i;

    for (i=0; i < XLEN; i += sz) {
        Uns32 pos = ((rs2 >> i) & mask) * sz;
        if(pos < XLEN) {
            r |= ((rs1 >> pos) & mask) << i;
        }
    }

    return r;
}

//
// Do XPERM (64-bit registers)
//
static Uns64 doXPERM64(Uns64 rs1, Uns32 sz, Uns64 rs2) {

    Int32 XLEN = 64;
    Uns64 r    = 0;
    Uns64 mask = (1LL << sz) - 1;
    Uns32 i;

    for (i=0; i < XLEN; i += sz) {
        Uns64 pos = ((rs2 >> i) & mask) * sz;
        if(pos < XLEN) {
            r |= ((rs1 >> pos) & mask) << i;
        }
    }

    return r;
}


////////////////////////////////////////////////////////////////////////////////
// B-EXTENSION PUBLIC INTERFACE
////////////////////////////////////////////////////////////////////////////////

DEFINE_CS(opDescB);

//
// Details of operation
//
typedef struct opDescBS {
    vmiCallFn        cb32;      // 32-bit implementation
    vmiCallFn        cb64;      // 64-bit implementation
    riscvBitManipSet subset;    // B extension feature subset per version
} opDescB;

//
// Entry with subset only
//
#define OPENTRYB_S(_S) { \
    subset:RVBS_Zb##_S                          \
}

//
// Entry with subset and 32/64 bit callbacks
//
#define OPENTRYB_S_CB(_S, _CB) { \
    subset:RVBS_Zb##_S,                         \
    cb32:(vmiCallFn)do##_CB##32,                \
    cb64:(vmiCallFn)do##_CB##64                 \
}

//
// Entry with subset and 64 bit callback only
//
#define OPENTRYB_S_CB64(_S, _CB64) { \
    subset:RVBS_Zb##_S,                         \
    cb64:(vmiCallFn)do##_CB64                   \
}

//
// Entries with subset only, version-invariant
//
#define OPENTRYBxV_S(_NAME, _S) [RVBOP_##_NAME] = { \
    [RVBV_0_90]       = OPENTRYB_S(_S),             \
    [RVBV_0_91]       = OPENTRYB_S(_S),             \
    [RVBV_0_92]       = OPENTRYB_S(_S),             \
    [RVBV_0_93_DRAFT] = OPENTRYB_S(_S),             \
    [RVBV_0_93]       = OPENTRYB_S(_S),             \
    [RVBV_0_94]       = OPENTRYB_S(_S),             \
    [RVBV_1_0_0]      = OPENTRYB_S(_S),             \
    [RVBV_MASTER]     = OPENTRYB_S(_S),             \
}

//
// Entries with subset and 32/64 bit callbacks, version-invariant
//
#define OPENTRYBxV_S_CB(_NAME, _S, _CB) [RVBOP_##_NAME] = { \
    [RVBV_0_90]       = OPENTRYB_S_CB(_S, _CB),     \
    [RVBV_0_91]       = OPENTRYB_S_CB(_S, _CB),     \
    [RVBV_0_92]       = OPENTRYB_S_CB(_S, _CB),     \
    [RVBV_0_93_DRAFT] = OPENTRYB_S_CB(_S, _CB),     \
    [RVBV_0_93]       = OPENTRYB_S_CB(_S, _CB),     \
    [RVBV_0_94]       = OPENTRYB_S_CB(_S, _CB),     \
    [RVBV_1_0_0]      = OPENTRYB_S_CB(_S, _CB),     \
    [RVBV_MASTER]     = OPENTRYB_S_CB(_S, _CB),     \
}

//
// Entries with subset and 32/64 bit version-dependent callbacks
//
#define OPENTRYBxV_S_CBxV(_NAME, _S, _CB90, _CB91, _CB92, _CB93) [RVBOP_##_NAME] = { \
    [RVBV_0_90]       = OPENTRYB_S_CB(_S, _CB90),   \
    [RVBV_0_91]       = OPENTRYB_S_CB(_S, _CB91),   \
    [RVBV_0_92]       = OPENTRYB_S_CB(_S, _CB92),   \
    [RVBV_0_93_DRAFT] = OPENTRYB_S_CB(_S, _CB93),   \
    [RVBV_0_93]       = OPENTRYB_S_CB(_S, _CB93),   \
    [RVBV_0_94]       = OPENTRYB_S_CB(_S, _CB93),   \
    [RVBV_1_0_0]      = OPENTRYB_S_CB(_S, _CB93),   \
    [RVBV_MASTER]     = OPENTRYB_S_CB(_S, _CB93),   \
}

//
// Entries with version-dependent subset
//
#define OPENTRYBxV_SxV(_NAME, _S90, _S91, _S92, _S93D, _S93) [RVBOP_##_NAME] = { \
    [RVBV_0_90]       = OPENTRYB_S(_S90),           \
    [RVBV_0_91]       = OPENTRYB_S(_S91),           \
    [RVBV_0_92]       = OPENTRYB_S(_S92),           \
    [RVBV_0_93_DRAFT] = OPENTRYB_S(_S93D),          \
    [RVBV_0_93]       = OPENTRYB_S(_S93),           \
    [RVBV_0_94]       = OPENTRYB_S(_S93),           \
    [RVBV_1_0_0]      = OPENTRYB_S(_S93),           \
    [RVBV_MASTER]     = OPENTRYB_S(_S93),           \
}

//
// Entries with version-dependent subset and 32/64 bit callbacks
//
#define OPENTRYBxV_SxV_CB(_NAME, _S90, _S91, _S92, _S93D, _S93, _CB) [RVBOP_##_NAME] = { \
    [RVBV_0_90]       = OPENTRYB_S_CB(_S90,  _CB),  \
    [RVBV_0_91]       = OPENTRYB_S_CB(_S91,  _CB),  \
    [RVBV_0_92]       = OPENTRYB_S_CB(_S92,  _CB),  \
    [RVBV_0_93_DRAFT] = OPENTRYB_S_CB(_S93D, _CB),  \
    [RVBV_0_93]       = OPENTRYB_S_CB(_S93,  _CB),  \
    [RVBV_0_94]       = OPENTRYB_S_CB(_S93,  _CB),  \
    [RVBV_1_0_0]      = OPENTRYB_S_CB(_S93,  _CB),  \
    [RVBV_MASTER]     = OPENTRYB_S_CB(_S93,  _CB),  \
}

//
// Entries with subset and 64 bit callback only, version-invariant
//
#define OPENTRYBxV_S_CB64(_NAME, _S, _CB64) [RVBOP_##_NAME] = { \
    [RVBV_0_90]       = OPENTRYB_S_CB64(_S, _CB64), \
    [RVBV_0_91]       = OPENTRYB_S_CB64(_S, _CB64), \
    [RVBV_0_92]       = OPENTRYB_S_CB64(_S, _CB64), \
    [RVBV_0_93_DRAFT] = OPENTRYB_S_CB64(_S, _CB64), \
    [RVBV_0_93]       = OPENTRYB_S_CB64(_S, _CB64), \
    [RVBV_0_94]       = OPENTRYB_S_CB64(_S, _CB64), \
    [RVBV_1_0_0]      = OPENTRYB_S_CB64(_S, _CB64), \
    [RVBV_MASTER]     = OPENTRYB_S_CB64(_S, _CB64), \
}

//
// Details of operation per version
//
static const opDescB opInfoB[RVBOP_LAST][RVBV_LAST] = {

    OPENTRYBxV_S      (Zba,      a                                                 ),
    OPENTRYBxV_S      (Zbb,      b                                                 ),
    OPENTRYBxV_S      (Zbc,      c                                                 ),
    OPENTRYBxV_S      (Zbe,      e                                                 ),
    OPENTRYBxV_S      (Zbf,      f                                                 ),
    OPENTRYBxV_S      (Zbm,      m                                                 ),
    OPENTRYBxV_S      (Zbp,      p                                                 ),
    OPENTRYBxV_S      (Zbr,      r                                                 ),
    OPENTRYBxV_S      (Zbs,      s                                                 ),
    OPENTRYBxV_S      (Zbt,      t                                                 ),
    OPENTRYBxV_S      (Zbbp,     bp                                                ),
    OPENTRYBxV_S      (Zbmp,     mp                                                ),
    OPENTRYBxV_S      (Zbefmp,   efmp                                              ),
    OPENTRYBxV_S      (Zbefp,    efp                                               ),

    OPENTRYBxV_S_CB   (GORC,     p,                  GORC                          ),
    OPENTRYBxV_S_CB   (ORCB,     bp,                 GORC                          ),
    OPENTRYBxV_SxV_CB (ORC16,    p,  p,  p,  bp, p,  GORC                          ),
    OPENTRYBxV_S_CB   (GREV,     p,                  GREV                          ),
    OPENTRYBxV_S_CB   (REV8,     bp,                 GREV                          ),
    OPENTRYBxV_SxV_CB (REV,      bp, bp, bp, bp, p,  GREV                          ),
    OPENTRYBxV_S_CB   (CRC32,    r,                  CRC32_                        ),
    OPENTRYBxV_S_CB   (SHFL,     p,                  SHFL                          ),
    OPENTRYBxV_S_CB   (UNSHFL,   p,                  UNSHFL                        ),
    OPENTRYBxV_S_CB64 (BMATFLIP, m,                  BMATFLIP                      ),
    OPENTRYBxV_S_CB64 (BMATOR,   m,                  BMATOR                        ),
    OPENTRYBxV_S_CB64 (BMATXOR,  m,                  BMATXOR                       ),
    OPENTRYBxV_S_CB   (BEXT,     e,                  BEXT                          ),
    OPENTRYBxV_S_CB   (BDEP,     e,                  BDEP                          ),
    OPENTRYBxV_SxV    (PACK,     bp, bp, bp, bp, efmp                              ),
    OPENTRYBxV_SxV    (PACKU,    bp, bp, bp, bp, mp                                ),
    OPENTRYBxV_SxV    (PACKH,    bp, bp, bp, bp, efp                               ),
    OPENTRYBxV_SxV    (PACKW,    bp, bp, bp, bp, efp                               ),
    OPENTRYBxV_SxV    (PACKUW,   bp, bp, bp, bp, p                                 ),
    OPENTRYBxV_SxV    (ZEXT32_H, bp, bp, bp, bp, befmp                             ),
    OPENTRYBxV_SxV    (ZEXT64_H, bp, bp, bp, bp, befp                              ),
    OPENTRYBxV_S_CB   (FSL,      t,                  FSL                           ),
    OPENTRYBxV_S_CB   (FSR,      t,                  FSR                           ),
    OPENTRYBxV_S_CBxV (BFP,      f,                  BFP91_, BFP91_, BFP92_, BFP92_),
    OPENTRYBxV_SxV    (ADD_UW,   b,  b,  b,  b,  a                                 ),
    OPENTRYBxV_SxV    (SLLI_UW,  b,  b,  b,  b,  a                                 ),
    OPENTRYBxV_SxV    (SLO_SRO,  b,  b,  b,  p,  _                                 ),
    OPENTRYBxV_S_CB   (XPERM,    p,                  XPERM                         ),
};

//
// Get operation description for this operation
//
inline static opDescBCP getOpDescB(riscvP riscv, riscvBExtOp op) {
    return &opInfoB[op][riscv->configInfo.bitmanip_version];
}

//
// Return implementation callback for B-extension operation and bits
//
vmiCallFn riscvGetBOpCB(riscvP riscv, riscvBExtOp op, Uns32 bits) {

    opDescBCP desc   = getOpDescB(riscv, op);
    vmiCallFn result = (bits==32) ? desc->cb32 : desc->cb64;

    // sanity check a callback was found
    VMI_ASSERT(result, "missing B-extension callback (op=%u, bits=%u)", op, bits);

    return result;
}

//
// Get description for missing B extension instruction subset
//
static const char *getBSubsetDesc(riscvBitManipSet requiredSet) {

    // get feature description
    const char *description = 0;

    // get missing subset description
    switch(requiredSet) {

        // ALWAYS ABSENT
        case RVBS_Zb_ : description = "always"; break;

        // INDIVIDUAL SETS
        case RVBS_Zba : description = "Zba"; break;
        case RVBS_Zbb : description = "Zbb"; break;
        case RVBS_Zbc : description = "Zbc"; break;
        case RVBS_Zbe : description = "Zbe"; break;
        case RVBS_Zbf : description = "Zbf"; break;
        case RVBS_Zbm : description = "Zbm"; break;
        case RVBS_Zbp : description = "Zbp"; break;
        case RVBS_Zbr : description = "Zbr"; break;
        case RVBS_Zbs : description = "Zbs"; break;
        case RVBS_Zbt : description = "Zbt"; break;

        // COMPOSITE SETS
        case RVBS_Zbbp   : description = "Zbb and Zbp";                break;
        case RVBS_Zbmp   : description = "Zbm and Zbp";                break;
        case RVBS_Zbefmp : description = "Zbe, Zbf, Zbm and Zbp";      break;
        case RVBS_Zbefp  : description = "Zbe, Zbf and Zbp";           break;
        case RVBS_Zbbefmp: description = "Zbb, Zbe, Zbf, Zbm and Zbp"; break;
        case RVBS_Zbbefp : description = "Zbb, Zbe, Zbf and Zbp";      break;

        // VERSION 1.0.0 COMBINATION
        case RVBS_1_0_0: break; // LCOV_EXCL_LINE
    }

    // sanity check known subset
    VMI_ASSERT(description, "unexpected subset 0x%x", requiredSet);

    return description;
}


////////////////////////////////////////////////////////////////////////////////
// K-EXTENSION SHARED INSTRUCTIONS PUBLIC INTERFACE
////////////////////////////////////////////////////////////////////////////////

//
// Entry with subset only
//
#define OPENTRYK(_S) RVKS_##_S

//
// Entries with subset only, version-invariant
//
#define OPENTRYKxV_S(_NAME, _S) [RVBOP_##_NAME] = { \
    [RVKV_0_7_2]     = OPENTRYK(_S),    \
    [RVKV_0_8_1]     = OPENTRYK(_S),    \
    [RVKV_0_9_0]     = OPENTRYK(_S),    \
    [RVKV_0_9_2]     = OPENTRYK(_S),    \
    [RVKV_1_0_0_RC1] = OPENTRYK(_S),    \
    [RVKV_1_0_0_RC5] = OPENTRYK(_S),    \
}

//
// Entries with version-dependent subset
//
#define OPENTRYKxV_SxV(_NAME, _S072, _S081, _S090, _S092) [RVBOP_##_NAME] = { \
    [RVKV_0_7_2]     = OPENTRYK(_S072), \
    [RVKV_0_8_1]     = OPENTRYK(_S081), \
    [RVKV_0_9_0]     = OPENTRYK(_S090), \
    [RVKV_0_9_2]     = OPENTRYK(_S092), \
    [RVKV_1_0_0_RC1] = OPENTRYK(_S092), \
    [RVKV_1_0_0_RC5] = OPENTRYK(_S092), \
}

//
// Details of operation per version
//
static const riscvCryptoSet opInfoK[RVBOP_LAST][RVKV_LAST] = {

    OPENTRYKxV_S   (Zbkb,   Zbkb                ),
    OPENTRYKxV_S   (Zbkc,   Zbkc                ),
    OPENTRYKxV_S   (Zbkx,   Zbkx                ),

    OPENTRYKxV_SxV (GORCI,  Zkb, Zkb, Zk_, Zk_  ),
    OPENTRYKxV_SxV (PACKU,  Zkb, Zkb, Zkb, Zk_  ),
    OPENTRYKxV_SxV (PACKUW, Zkb, Zkb, Zkb, Zk_  ),
    OPENTRYKxV_SxV (REV8W,  Zkb, Zkb, Zkb, Zk_  ),
    OPENTRYKxV_SxV (XPERM,  Zkb, Zkb, Zkb, Zbkx ),
};

//
// Get operation description for this operation
//
inline static riscvCryptoSet getRequiredSetK(riscvP riscv, riscvBExtOp op) {
    return opInfoK[op][riscv->configInfo.crypto_version];
}

//
// Get description for missing K extension shared instruction subset
//
static const char *getKSubsetDesc(riscvCryptoSet requiredSet) {

    // get feature description
    const char *description = 0;

    // get missing subset description
    switch(requiredSet) {

        // ALWAYS ABSENT
        case RVKS_Zk_  : description = "always"; break;

        // INDIVIDUAL SETS
        case RVKS_Zbkb : description = "Zbkb"; break;
        case RVKS_Zbkc : description = "Zbkc"; break;
        case RVKS_Zbkx : description = "Zbkx"; break;
        default        :                       break; // LCOV_EXCL_LINE
    }

    // sanity check known subset
    VMI_ASSERT(description, "unexpected subset 0x%x", requiredSet);

    return description;
}


////////////////////////////////////////////////////////////////////////////////
// EXTENSION VALIDITY
////////////////////////////////////////////////////////////////////////////////

//
// Validate that the instruction subset is supported and enabled and take an
// Illegal Instruction exception if not
//
Bool riscvValidateBExtSubset(riscvP riscv, riscvBExtOpSet op) {

    const char *absent  = 0;
    Bool        enabled = False;

    // handle B extension subsets
    if(op.B && bitmanipEnabled(riscv)) {

        opDescBCP        desc        = getOpDescB(riscv, op.B);
        riscvBitManipSet requiredSet = desc->subset;

        enabled = requiredSet & ~riscv->configInfo.bitmanip_absent;

        if(!enabled) {
            absent = getBSubsetDesc(requiredSet);
        }
    }

    // handle K extension shared subsets
    if(!enabled && op.K && cryptoEnabled(riscv)) {

        riscvCryptoSet requiredSet = getRequiredSetK(riscv, op.K);

        enabled = requiredSet & ~riscv->configInfo.crypto_absent;

        if(!enabled) {
            absent = getKSubsetDesc(requiredSet);
        }
    }

    // some extension with shared opcodes is enabled
    if(enabled) {
        absent = 0;
    }

    // take Illegal Instruction for absent subset
    if(absent) {
        riscvEmitIllegalInstructionAbsentSubset(absent);
    }

    return !absent;
}


