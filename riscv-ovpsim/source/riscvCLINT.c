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

// standard includes
#include <stdio.h>

// Imperas header files
#include "hostapi/impAlloc.h"

// VMI header files
#include "vmi/vmiMessage.h"
#include "vmi/vmiRt.h"

// model header files
#include "riscvCluster.h"
#include "riscvCLINT.h"
#include "riscvExceptions.h"
#include "riscvMessage.h"
#include "riscvStructure.h"
#include "riscvTypeRefs.h"


//
// Size of memory-mapped CLINT block in bytes
//
#define CLINT_BYTES 0xc000

//
// This enumerates CLINT registers
//
typedef enum CLINTRegTypeE {
    CLINTR_msip,
    CLINTR_mtimecmp,
    CLINTR_mtime,
    CLINTR_LAST
} CLINTRegType;

//
// Definition of CLINT register details
//
typedef struct CLINTRegS {
    const char *name;       // register name
    Uns32       offset;     // offset within CLINT block
    Uns32       bytes;      // register size in bytes
    Bool        perHart;    // whether register per-hart
} CLINTReg;

//
// Define all CLINT registers
//
static const CLINTReg CLINTRegs[] = {
    [CLINTR_msip]     = {name:"msip",     offset:0x0000, bytes:4, perHart:True },
    [CLINTR_mtimecmp] = {name:"mtimecmp", offset:0x4000, bytes:8, perHart:True },
    [CLINTR_mtime]    = {name:"mtime",    offset:0xbff8, bytes:8, perHart:False},
};

//
// Type used to return information about decoded CLINT register
//
typedef struct CLINTRegDecodeS {
    CLINTRegType type;      // register
    Uns32        hart;      // hart index
    Uns32        offset;    // byte offset within register
} CLINTRegDecode, *CLINTRegDecodeP;

//
// Type used to hold CLINT register value
//
typedef union CLINTRegValueU {
    Uns8  u8[8];    // value in bytes
    Uns64 u64;      // value as a word
} CLINTRegValue, *CLINTRegValueP;

//
// Return the number of hart contexts in a cluster
//
inline static Uns32 getNumHarts(riscvP root) {
    return root->numHarts;
}

//
// Return CLINT scope object
//
inline static riscvP getCLINTRoot(riscvP riscv) {
    return riscv->clusterRoot;
}

//
// Return the base address of the cluster CLINT block
//
inline static Uns64 getCLINTLow(riscvP root) {
    return root->configInfo.CLINT_address;
}

//
// Return index of Machine Software Interrupt
//
inline static Uns32 msipInt(void) {
    return exceptionToInt(riscv_E_MSWInterrupt);
}

//
// If the offset corresponds to a CLINT register, fill decode details and return
// True; otherwise, return False
//
static Bool decodeCLINTReg(riscvP root, CLINTRegDecodeP decode, Uns32 offset) {

    Uns32        numHarts = getNumHarts(root);
    CLINTRegType type;

    for(type=0; type<CLINTR_LAST; type++) {

        Uns32 lo    = CLINTRegs[type].offset;
        Uns32 bytes = CLINTRegs[type].bytes;
        Uns32 size  = CLINTRegs[type].perHart ? bytes*numHarts : bytes;
        Uns32 hi    = lo + size - 1;

        if((lo<=offset) && (offset<=hi)) {

            Uns32 regOffset = offset-lo;

            decode->type   = type;
            decode->hart   = regOffset / bytes;
            decode->offset = regOffset % bytes;

            return True;
        }
    }

    return False;
}


////////////////////////////////////////////////////////////////////////////////
// CLINT REGISTER ACCESS
////////////////////////////////////////////////////////////////////////////////

//
// Return the current value of the indexed interrupt
//
inline static Bool getInt(riscvP hart, Uns32 intNum) {
    return hart->ip[0] & (1<<intNum);
}

//
// Read msip[i]
//
Bool riscvReadCLINTMSIP(riscvP hart) {

    return getInt(hart, msipInt());
}

//
// Write msip[i]
//
void riscvWriteCLINTMSIP(riscvP hart, Bool value) {

    riscvUpdateInterrupt(hart, msipInt(), value);
}

//
// Write mtime (common to all harts)
//
void riscvWriteCLINTMTIME(riscvP hart, Uns64 value) {

    riscvP root     = getCLINTRoot(hart);
    Uns32  numHarts = getNumHarts(root);
    Uns32  i;

    for(i=0; i<numHarts; i++) {
        riscvWriteMTIME(root->clint[i], value);
    }
}


////////////////////////////////////////////////////////////////////////////////
// MEMORY-MAPPED CALLBACKS
////////////////////////////////////////////////////////////////////////////////

//
// Do the two register decodes reference different CLINT registers?
//
static Bool distinctCLINTReg(CLINTRegDecodeP prev, CLINTRegDecodeP this) {
    return ((prev->type!=this->type) || (prev->hart!=this->hart));
}

//
// Emit debug for CLINT region access
//
static void debugCLINTAccess(
    CLINTRegDecodeP this,
    Uns64           value,
    const char     *access
) {
    const char *name = CLINTRegs[this->type].name;
    Uns32       hart = this->hart;
    char        valueS[32];

    if(CLINTRegs[this->type].bytes==4) {
        sprintf(valueS, "%08x", (Uns32)value);
    } else {
        sprintf(valueS, FMT_Ax, value);
    }

    if(CLINTRegs[this->type].perHart) {
        vmiMessage("I", CPU_PREFIX"_CLINT",
            "%s %s (hart %u) : 0x%s\n", access, name, hart, valueS
        );
    } else {
        vmiMessage("I", CPU_PREFIX"_CLINT",
            "%s %s : 0x%s\n", access, name, valueS
        );
    }
}

//
// Return hart for the given context processor, or the first CLINT hart if the
// hart is not in this CLINT context
//
riscvP getCLINTForContext(riscvP root, vmiProcessorP context) {

    riscvP hartCxt = (riscvP)context;

    return hartCxt->clint==root->clint ? hartCxt : root->clint[0];
}

//
// Read an entire CLINT register
//
static Uns64 readCLINTInt(
    riscvP          root,
    vmiProcessorP   context,
    CLINTRegDecodeP this,
    Bool            verbose
) {
    riscvP hart = root->clint[this->hart];
    Uns64  result;

    // get register value
    if(this->type==CLINTR_msip) {
        result = riscvReadCLINTMSIP(hart);
    } else if(this->type==CLINTR_mtimecmp) {
        result = riscvReadMTIMECMP(hart);
    } else {
        result = riscvReadMTIME(getCLINTForContext(root, context));
    }

    // debug access if required
    if(verbose && RISCV_DEBUG_EXCEPT(root)) {
        debugCLINTAccess(this, result, "READ");
    }

    return result;
}

//
// Read an entire CLINT register
//
static void writeCLINTInt(riscvP root, CLINTRegDecodeP this, Uns64 value) {

    riscvP hart = root->clint[this->hart];

    // update register value
    if(this->type==CLINTR_msip) {
        riscvWriteCLINTMSIP(hart, value&1);
    } else if(this->type==CLINTR_mtimecmp) {
        riscvWriteMTIMECMP(hart, value);
    } else if(this->type==CLINTR_mtime) {
        riscvWriteCLINTMTIME(hart, value);
    } else {
        return; // illegal register write - ignored here
    }

    // debug access if required
    if(RISCV_DEBUG_EXCEPT(root)) {
        debugCLINTAccess(this, value, "WRITE");
    }
}

//
// If this is a true access, take a memory fault
//
static void clicMemoryFault(
    vmiProcessorP  processor,
    riscvException exception,
    Uns64          address
) {
    if(processor) {
        riscvTakeMemoryException((riscvP)processor, exception, address);
    }
}

//
// Read CLINT register
//
static VMI_MEM_READ_FN(readCLINT) {

    riscvP         root    = userData;
    Uns8          *value8  = value;
    Uns64          lowAddr = getCLINTLow(root);
    CLINTRegDecode prev    = {type:CLINTR_LAST};
    CLINTRegValue  reg;
    Uns32          i;

    for(i=0; i<bytes; i++) {

        Uns32          offset = address+i-lowAddr;
        CLINTRegDecode this;

        if(decodeCLINTReg(root, &this, offset)) {

            // get register value if distinct from any previous one
            if(distinctCLINTReg(&prev, &this)) {
                reg.u64 = readCLINTInt(root, processor, &this, True);
                prev    = this;
            }

            // extract byte from register value
            value8[i] = reg.u8[this.offset];

        } else {

            // handle illegal access
            clicMemoryFault(processor, riscv_E_LoadAccessFault, address);
            break;
        }
    }
}

//
// Write CLINT register
//
static VMI_MEM_WRITE_FN(writeCLINT) {

    riscvP         root    = userData;
    const Uns8    *value8  = value;
    Uns64          lowAddr = getCLINTLow(root);
    CLINTRegDecode prev    = {type:CLINTR_LAST};
    CLINTRegDecode this    = {type:CLINTR_LAST};
    CLINTRegValue  reg     = {{0}};
    Uns32          i;

    for(i=0; i<bytes; i++) {

        Uns32 offset = address+i-lowAddr;

        if(decodeCLINTReg(root, &this, offset)) {

            // write back complete register value and get next raw value
            if(distinctCLINTReg(&prev, &this)) {
                writeCLINTInt(root, &prev, reg.u64);
                reg.u64 = readCLINTInt(root, processor, &this, False);
                prev    = this;
            }

            // update byte from given value
            reg.u8[this.offset] = value8[i];

        } else {

            // write back any previous complete register value
            writeCLINTInt(root, &prev, reg.u64);
            prev.type = CLINTR_LAST;

            // handle illegal access
            clicMemoryFault(processor, riscv_E_StoreAMOAccessFault, address);

            break;
        }
    }

    // write back final complete register value
    writeCLINTInt(root, &prev, reg.u64);
}


////////////////////////////////////////////////////////////////////////////////
// PUBLIC FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Create CLINT memory-mapped block and data structures
//
void riscvMapCLINTDomain(riscvP riscv, memDomainP CLINTDomain) {

    riscvP root     = getCLINTRoot(riscv);
    Uns64  lowAddr  = getCLINTLow(root);
    Uns64  highAddr = lowAddr+CLINT_BYTES-1;

    // install callbacks to implement the CLINT
    vmirtMapCallbacks(
        CLINTDomain, lowAddr, highAddr, readCLINT, writeCLINT, root
    );

    // force aligned access
    vmirtProtectMemory(
        CLINTDomain, lowAddr, highAddr, MEM_PRIV_ALIGN, MEM_PRIV_ADD
    );
}

//
// Copy CLINT configuration setting
//
#define COPY_CLINT_CFG(_DST, _SRC, _NAME) \
    (_DST)->configInfo._NAME = (_SRC)->configInfo._NAME

//
// Allocate CLINT data structures if implemented internally
//
void riscvNewCLINT(riscvP root) {

    // if this is an AMP cluster, copy CLINT configuration from the first child
    if(riscvIsCluster(root)) {

        riscvP child = (riscvP)vmirtGetSMPChild((vmiProcessorP)root);

        COPY_CLINT_CFG(root, child, CLINT_address);
        COPY_CLINT_CFG(root, child, mtime_Hz);
    }

    // allocate CLINT data structures if required
    if(CLINTInternal(root)) {
        root->clint = STYPE_CALLOC_N(riscvP, getNumHarts(root));
    }
}

//
// Fill CLINT entry if required
//
void riscvFillCLINT(riscvP riscv) {

    riscvP  root  = getCLINTRoot(riscv);
    riscvPP clint = root->clint;

    if(clint) {

        Uns32 numHarts = getNumHarts(root);
        Uns32 index    = riscv->hartNum;

        // sanity check hart index and table
        VMI_ASSERT(
            index<numHarts,
            "illegal hart index %u (maximum %u)",
            index, numHarts
        );
        VMI_ASSERT(
            !clint[index],
            "table entry %u already filled",
            index
        );

        // link hart and clint element
        clint[index] = riscv;
        riscv->clint = clint;
    }
}

//
// Free CLINT data structures
//
void riscvFreeCLINT(riscvP root) {

    riscvPP clint = root->clint;

    if(clint) {

        // free CLINT
        STYPE_FREE(clint);

        root->clint = 0;
    }
}

//
// Reset CLINT
//
void riscvResetCLINT(riscvP riscv) {

    if(riscv->clint) {
        riscvWriteCLINTMSIP(riscv, 0);
    }
}

