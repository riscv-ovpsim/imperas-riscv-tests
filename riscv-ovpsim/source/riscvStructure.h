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

#pragma once

// VMI header files
#include "vmi/vmiTypes.h"
#include "vmi/vmiPorts.h"

// common header files
#include "ocl/oclSymbolTyperefs.h"

// model header files
#include "riscvCLICTypes.h"
#include "riscvConfig.h"
#include "riscvCSR.h"
#include "riscvExceptionTypes.h"
#include "riscvFeatures.h"
#include "riscvMode.h"
#include "riscvModelCallbacks.h"
#include "riscvTypes.h"
#include "riscvTypeRefs.h"
#include "riscvVariant.h"


//
// Processor debug flags
//
#define RISCV_DISASSEMBLE_MASK      0x00000001
#define RISCV_DEBUG_MMU_MASK        0x00000002
#define RISCV_DEBUG_EXCEPT_MASK     0x00000004

//
// Processor flag selection macros
//
#define RISCV_DISASSEMBLE(_P)   ((_P)->flags & RISCV_DISASSEMBLE_MASK)
#define RISCV_DEBUG_MMU(_P)     ((_P)->flags & RISCV_DEBUG_MMU_MASK)
#define RISCV_DEBUG_EXCEPT(_P)  ((_P)->flags & RISCV_DEBUG_EXCEPT_MASK)

//
// Debug flags that should be disabled during save/restore
//
#define RISCV_DEBUG_UPDATE_MASK ( \
    RISCV_DEBUG_MMU_MASK |  \
    RISCV_DEBUG_EXCEPT_MASK \
)

//
// Number of temporaries
//
#define NUM_TEMPS 16

//
// Container for net values
//
typedef struct riscvNetValueS {
    Bool reset         : 1; // level of reset signal
    Bool haltreq       : 1; // haltreq (Debug mode)
    Bool stepreq       : 1; // stepreq (Debug mode)
    Bool resethaltreq  : 1; // resethaltreq (Debug mode)
    Bool resethaltreqS : 1; // resethaltreq (Debug mode, sampled at reset)
    Bool deferint      : 1; // defer taking interrupts (artifact)
    Bool enableCLIC    : 1; // is CLIC enabled?
    Uns8 triggerAfter  : 4; // pending trigger after (Trigger module)
} riscvNetValue;

//
// Container for PMP configuration registers
//
typedef union riscvPMPCFGU {
    Uns8  *u8;          // when viewed as bytes
    Uns32 *u32;         // when viewed as words
    Uns64 *u64;         // when viewed as double words
} riscvPMPCFG;

//
// This code indicates no interrupt is pending
//
#define RV_NO_INT -1

//
// This holds information about a pending-and-enabled interrupt
//
typedef struct riscvPendEnabS {
    riscvMode priv;     // mode to which taken
    Int32     id;       // interrupt id
    Uns8      level;    // interrupt level
    Bool      isCLIC;   // whether CLIC mode interrupt
} riscvPendEnab;

//
// This holds all state contributing to a basic mode interrupt (for debug)
//
typedef struct riscvBasicIntStateS {
    Uns64 ip[RISCV_MODE_LAST];  // pending and enabled interrupts per mode
    Bool  hvictl;               // whether hvictl-injected interrupt
} riscvBasicIntState, *riscvBasicIntStateP;

//
// This holds processor and vector information for an interrupt
//
typedef struct riscvInterruptInfoS {
    riscvP hart;
    Uns32  userData;
} riscvInterruptInfo, *riscvInterruptInfoP;

//
// Structure describing a port
//
typedef struct riscvNetPortS {
    vmiNetPort         desc;
    riscvInterruptInfo ii;
    riscvNetPortP      next;
} riscvNetPort;

//
// Set of domains, per processor base mode
//
typedef memDomainP riscvDomainSetBM[RISCV_MODE_LAST_BASE][2];
typedef riscvDomainSetBM *riscvDomainSetBMP;

//
// Set of domains, per processor physical mode
//
typedef memDomainP riscvDomainSetPM[RISCV_MODE_LAST][2];
typedef riscvDomainSetPM *riscvDomainSetPMP;

//
// Set of domains, per processor virtual mode
//
typedef memDomainP riscvDomainSetVM[RISCV_VMMODE_LAST][2];
typedef riscvDomainSetVM *riscvDomainSetVMP;

//
// Trigger tdata1 register in unpacked form (contains fields for all trigger
// types in uniform way)
//
typedef struct riscvTData1UPS {
    triggerType type    :  4;
    Uns32       modes   :  6;
    Uns32       match   :  4;
    Uns32       action  :  4;
    Uns32       size    :  4;
    Uns32       priv    :  3;
    Bool        chain   :  1;
    Bool        timing  :  1;
    Bool        select  :  1;
    Bool        hit     :  1;
    Bool        dmode   :  1;
    Bool        nmi     :  1;
    Bool        pending :  1;
    Bool        icmatch :  1;
    Uns32       count   : 14;
} riscvTData1UP;

//
// Trigger tdata3 register in unpacked form (contains fields for all trigger
// types in uniform way)
//
typedef struct riscvTData3UPS {
    Uns64 sselect   :  2;
    Uns64 mhselect  :  3;
    Uns64 svalue    : 34;
    Uns64 mhvalue   : 13;
    Uns64 sbytemask :  5;
} riscvTData3UP;

//
// Trigger register set
//
typedef struct riscvTriggerS {

    // instruction count when trigger matches
    Uns64 matchICount;

    // management of trigger value
    Uns64 tval;
    Bool  tvalValid;
    Bool  triggered;

    // tdata1 and tdata3 fields in unpacked form
    riscvTData1UP tdata1UP;
    riscvTData3UP tdata3UP;

    // raw trigger fields
    CSR_REG_DECL (tdata2);
    CSR_REG_DECL (tinfo);
    CSR_REG_DECL (mcontext);
    CSR_REG_DECL (scontext);

} riscvTrigger;

//
// Maximum supported value of VLEN and number of vector registers (vector
// extension)
//
#define VLEN_MAX        65536
#define VREG_NUM        32
#define ELEN_MIN        32
#define ELEN_MAX        64
#define SLEN_MIN        32
#define ELEN_DEFAULT    64
#define SLEN_DEFAULT    64
#define VLEN_DEFAULT    512
#define SEW_MIN         8
#define LMUL_MAX        8
#define NUM_BASE_REGS   4

//
// Processor model structure
//
typedef struct riscvS {

    // True processor registers
    Uns64              x[32];           // GPR bank
    Uns64              f[32];           // FPR bank
    riscvCSRs          csr;             // system register values
    riscvCSRMasks      csrMask;         // system register masks

    // Model control
    Uns64              TMP[NUM_TEMPS];  // temporaries
    riscvP             clusterRoot;     // root of cluster
    riscvP             smpRoot;         // smp container
    riscvP             parent;          // parent (if not root)
    riscvArchitecture  currentArch;     // current enabled features
    riscvDMode         mode;            // current processor dictionary mode
    riscvDisableReason disable;         // reason why processor is disabled
    Uns32              numHarts;        // number of hart contexts in container
    Uns32              hartNum;         // index number within cluster
    Bool               verbose       :1;// whether verbose output enabled
    Bool               traceVolatile :1;// whether to trace volatile registers
    Bool               artifactAccess:1;// whether artifact access active
    Bool               artifactLdSt  :1;// whether artifact load/store active
    Bool               externalActive:1;// whether external CSR access active
    Bool               inSaveRestore :1;// is save/restore active?
    Bool               useTMode      :1;// has transaction mode been enabled?
    Bool               rmCheckValid  :1;// whether RM valid check required
    Bool               checkEndian   :1;// whether endian check required
    Bool               checkTriggerLA:1;// whether trigger load address check
    Bool               checkTriggerLV:1;// whether trigger load value check
    Bool               checkTriggerS :1;// whether trigger store check
    Bool               checkTriggerX :1;// whether trigger execute check
    Bool               usingFP       :1;// whether floating point in use
    Bool               usingBF16     :1;// whether BF16 format in use
    Bool               dynamicBF16   :1;// whether dynamic BF16 format
    riscvVTypeFmt      vtypeFormat   :1;// vtype format (vector extension)
    Uns16              pmKey;           // polymorphic key
    Uns8               xlenMask;        // XLEN mask (per mode5)
    Uns8               xlenMaskSR;      // XLEN mask (during save/restore)
    Uns8               fpFlagsMT;       // flags set by JIT instructions
    Uns8               fpFlagsCSR;      // flags set by CSR write
    Uns8               fpFlagsI;        // flags set per instruction (not sticky)
    Uns8               SFMT;            // SF set by JIT instructions
    Uns8               SFCSR;           // SF set by CSR write
    Uns8               SF;              // operation saturation flag
    Uns8               atomic;          // atomic operation code
    Bool               HLVHSV;          // whether HLV, HLVX or HSV active
    Bool               DM;              // whether in Debug mode
    Bool               DMStall;         // whether stalled in Debug mode
    Bool               commercial;      // whether commercial feature in use
    Uns32              flags;           // model control flags
    Uns32              flagsRestore;    // saved flags during restore
    riscvConfig        configInfo;      // model configuration
    riscvMode          dataMode;        // mode in which to access data
    memEndian          dendian;         // data endianness
    Uns64              jumpBase;        // address of jump instruction
    Uns32              writtenXMask;    // mask of written X registers

    // Configuration and parameter definitions
    riscvParamValuesP  paramValues;     // specified parameters (construction only)

    // Interrupt and exception control
    vmiExceptionInfoCP exceptions;      // all exceptions (including extensions)
    Uns64              swip;            // software interrupt pending bits
    Uns64              exceptionMask;   // mask of all implemented exceptions
    Uns64              interruptMask;   // mask of all implemented interrupts
    Uns64              disableMask;     // mask of externally-disabled interrupts
    riscvPendEnab      pendEnab;        // pending and enabled interrupt
    Uns32              extInt[RISCV_MODE_LAST]; // external interrupt override
    riscvAIAP          aia;             // AIA state
    riscvPP            clint;           // CLINT state
    riscvCLIC          clic;            // source interrupt indicated from CLIC
    riscvException     exception;       // last activated exception
    riscvExceptionDtl  exceptionDetail; // exception detail
    Uns32              threshOnes: 8;   // all-ones bits in xintthresh
    riscvICMode        MIMode    : 2;   // custom M interrupt mode
    riscvICMode        SIMode    : 2;   // custom S interrupt mode
    riscvICMode        HIMode    : 2;   // custom H interrupt mode
    riscvICMode        UIMode    : 2;   // custom U interrupt mode
    Bool               inhv      : 1;   // is CLIC vector access active?
    Bool               stimecmp  : 1;   // is stimecmp interrupt pending?
    Bool               vstimecmp : 1;   // is vstimecmp interrupt pending?
    Bool               isFetch   : 1;   // is instruction fetch active?

    // LR/SC support
    Uns64              exclusiveTag;    // tag for active exclusive access
    Uns64              exclusiveTagMask;// mask for active exclusive access

    // Counter/timer support
    riscvNetPortP      mtimePort;       // external mtime source port
    vmiModelTimerP     mtime;           // mtime timer
    Uns64              mtimecmp;        // mtimecmp value (CLINT)
    Uns64              mtimebase;       // mtime base value
    Uns64              baseCycles;      // base cycle count
    Uns64              baseInstructions;// base instruction count

    // Debug and trace
    octSymbolTableP    regNames;        // table of generated register names
    riscvRegListP      extRegHead;      // first extension register
    riscvRegListP      extRegTail;      // last extension register
    vmiRegInfoP        regInfo[2];      // register views (normal and debug)
    char               tmpString[16];   // temporary string

    // Parameters
    vmiEnumParameterP  variantList;     // supported variants
    vmiParameterP      parameters;      // parameter definitions

    // Cluster variants
    const char        *clusterVariants; // comma-separated cluster members
    Uns32             *uniqueIndices;   // unique indices of same-type members
    Uns32             *memberNumHarts;  // numHarts overrides for members

    // Ports
    riscvBusPortP      busPorts;        // bus ports
    riscvBusPortP      IMSICPort;       // IMSIC external interrupts
    riscvNetPortP      netPorts;        // net ports
    riscvNetValue      netValue;        // special net port values
    Uns32              ipDWords;        // size of ip in double words
    Uns64             *ip;              // interrupt port values
    Uns64              svie;            // S-mode virtual interrupt enable
    Uns32              DMPortHandle;    // DM port handle (debug mode)
    Uns32              LRAddressHandle; // LR address port handle (locking)
    Uns32              SCAddressHandle; // SC address port handle (locking)
    Uns32              AMOActiveHandle; // active AMO operation
    Uns32              irq_ack_Handle;  // interrupt acknowledge
    Uns32              irq_id_Handle;   // interrupt id
    Uns32              sec_lvl_Handle;  // security level

    // Timers
    Uns32              stepICount;      // Instructions when single-step set
    vmiModelTimerP     stepTimer;       // Debug mode single-step timer
    vmiModelTimerP     ackTimer;        // Interrupt acknowledge timer
    vmiModelTimerP     twTimer;         // TW timer

    // CSR support
    vmiRangeTableP     csrTable;        // per-CSR lookup table
    vmiRangeTableP     csrUIMessage;    // per-CSR unimplemented messages
    riscvBusPortP      csrPort;         // externally-implemented CSR port
    riscvCSRRemapP     csrRemap;        // CSR remap list

    // Memory management support
    memDomainP         extDomains[2];   // external domains (including CLIC)
    riscvDomainSetBM   pmaDomains;      // pma domains (per base mode)
    riscvDomainSetBM   pmpDomains;      // pmp domains (per base mode)
    riscvDomainSetPM   physDomains;     // physical domains (per physical mode)
    riscvDomainSetVM   vmDomains;       // mapped domains (per virtual mode)
    memDomainP         guestPTWDomain;  // guest page table walk domain
    memDomainP         hlvxDomains[2];  // HLVX mapped domains (S and U)
    memDomainP         tmDomain;        // transaction mode domain
    memDomainP         CLICDomain;      // CLIC domain
    riscvPMPCFG        pmpcfg;          // pmpcfg registers
    riscvPMPCFG        romask_pmpcfg;   // pmpcfg register read-only bit masks
    Uns64             *pmpaddr;         // pmpaddr registers
#if(ENABLE_SSMPU)
    riscvPMPCFG        mpucfg;          // mpucfg registers
    Uns64             *mpuaddr;         // mpuaddr registers
#endif
    riscvTLBP          tlb[RISCV_TLB_LAST];// TLB caches
    memPriv            origPriv   : 8;  // original access privilege (table walk)
    Uns8               extBits    : 8;  // bit size of external domains
    Uns8               s2Offset   : 2;  // stage 2 additional page offset
    riscvTLBId         activeTLB  : 2;  // currently-active TLB context
    Uns8               PTWLevel   : 3;  // page table walk level
    Bool               PTWActive  : 1;  // page table walk active
    Bool               PTWBadAddr : 1;  // page table walk address was bad
    Bool               hlvxActive : 1;  // HLVX access active
    Bool               GVA        : 1;  // is guest virtual address?
    Uns64              GPA;             // faulting guest physical address
    Uns64              tinst;           // pending trap instruction
    Uns64              originalVA;      // VA initiating memory fault
    Uns64              s1VA;            // stage 1 VA in stage 2 context

    // Messages
    riscvBasicIntState intState;        // basic interrupt state
    riscvCLICOutState  clicState;       // CLIC interrupt state

    // JIT code translation control
    riscvBlockStateP   blockState;      // active block state

    // Enhanced model support callbacks
    riscvModelCB       cb;				// implemented by base model
    riscvExtCBP        extCBs;   		// implemented in extension

    // Cryptographic extension
    riscvBusPortP      entropyPort;     // optional bus read to provide entropy
    Uns32              entropyLFSR;     // LFSR for pollentropy instruction

    // Trigger module
    riscvTriggerP      triggers;        // triggers (configurable size)
    Uns64              triggerVA;       // computed VA for load/store
    Uns64              triggerLV;       // load value

    // Vector extension
    Uns8               vFieldMask;          	// vector field mask
    Uns8               vActiveMask;         	// vector active element mask
    Bool               vFirstFault;          	// vector first fault active?
    Bool               vPreserve;               // vsetvl{i} preserving vl?
    Uns32              vlEEW1;                  // effective VL when EEW=1
    Uns64              vTmp[4];               	// vector operation temporaries
    UnsPS              vBase[NUM_BASE_REGS];  	// indexed base registers
    Uns32             *v;                     	// vector registers (configurable size)

    // Decoder support
    vmidDecodeTableP   table16;                 // 16-bit decode table
    vmidDecodeTableP   table32;                 // 32-bit decode table

} riscv;

//
// This tag value is used to specify that there is no active LR/SC
//
#define RISCV_NO_TAG -1

//
// Clear any active exclusive access
//
inline static void clearEA(riscvP riscv) {
    riscv->exclusiveTag = RISCV_NO_TAG;
}

//
// Return current 5-state riscvMode (M, HS, HU, VS or VU)
//
inline static riscvMode getCurrentMode5(riscvP riscv) {
    return dmodeToMode5(riscv->mode);
}

//
// Return current 4-state riscvMode (M, H, S or U)
//
inline static riscvMode getCurrentMode4(riscvP riscv) {
    return dmodeToMode4(riscv->mode);
}

//
// Return current 3-state riscvMode (M, S or U)
//
inline static riscvMode getCurrentMode3(riscvP riscv) {
    return dmodeToMode3(riscv->mode);
}

//
// Is the processor in a virtual mode?
//
inline static Bool inVMode(riscvP riscv) {
    return dmodeIsVirtual(riscv->mode);
}

//
// Is the processor in a virtual mode for a non-artifact access?
//
inline static Bool inVModeNotArtifact(riscvP riscv) {
    return !riscv->artifactAccess && inVMode(riscv);
}

//
// Is the processor in Debug mode?
//
inline static Bool inDebugMode(riscvP riscv) {
    return riscv->DM;
}

//
// Return mask of implemented ASID bits
//
inline static Uns32 getASIDMask(riscvP riscv) {
    return (1<<riscv->configInfo.ASID_bits)-1;
}

//
// Return mask of implemented VMID bits
//
inline static Uns32 getVMIDMask(riscvP riscv) {
    return (1<<riscv->configInfo.VMID_bits)-1;
}

//
// Return address mask for the given number of bits
//
inline static Uns64 getAddressMask(Uns32 bits) {
    return (bits==64) ? -1 : ((1ULL<<bits)-1);
}

//
// Return implemented guest external interrupts
//
inline static Uns32 getGEILEN(riscvP riscv) {
    return riscv->configInfo.GEILEN;
}

//
// Is only basic support available in htinst?
//
inline static Bool xtinstBasic(riscvP riscv) {
    return riscv->configInfo.xtinst_basic;
}

//
// Is CLINT present and implemented internally?
//
inline static Bool CLINTInternal(riscvP riscv) {
    return riscv->configInfo.CLINT_address;
}

//
// Is CLIC interrupt controller present?
//
inline static Bool CLICPresent(riscvP riscv) {
    return riscv->configInfo.CLICLEVELS;
}

//
// Is CLIC interrupt controller present and implemented internally?
//
inline static Bool CLICInternal(riscvP riscv) {
    return CLICPresent(riscv) && !riscv->configInfo.externalCLIC;
}

//
// Is CLIC interrupt controller present and implemented externally?
//
inline static Bool CLICExternal(riscvP riscv) {
    return CLICPresent(riscv) && riscv->configInfo.externalCLIC;
}

//
// Is basic interrupt controller present?
//
inline static Bool basicICPresent(riscvP riscv) {
    return !CLICPresent(riscv) || riscv->configInfo.CLICANDBASIC;
}

//
// Is CLIC/CLINT mode determined entirely by mtvec?
//
inline static Bool mtvecDeterminesCLICMode(riscvP riscv) {
    return riscv->configInfo.CLIC_version>RVCLC_0_9_20220315;
}

//
// Are xintstatus CSRs in read-only location?
//
inline static Bool xintstatusRO(riscvP riscv) {
    return riscv->configInfo.CLIC_version>RVCLC_0_9_20220315;
}

//
// Is mclicbase CSR always absent?
//
inline static Bool mclicbaseAbsent(riscvP riscv) {
    return riscv->configInfo.CLIC_version>RVCLC_0_9_20220315;
}

//
// Is clicinfo memory-mapped register absent?
//
inline static Bool clicinfoAbsent(riscvP riscv) {
    return riscv->configInfo.CLIC_version>RVCLC_0_9_20220315;
}

//
// Is cliccfg.nvbits implemented?
//
inline static Bool haveNVbits(riscvP riscv) {
    return riscv->configInfo.CLIC_version<=RVCLC_0_9_20220315;
}

//
// Should CLIC be used for M-mode interrupts?
//
inline static Bool useCLICM(riscvP riscv) {
    return RD_CSR_FIELD_M(riscv, mtvec, MODE) & riscv_int_CLIC;
}

//
// Should CLIC be used for S-mode interrupts?
//
inline static Bool useCLICS(riscvP riscv) {
    if(mtvecDeterminesCLICMode(riscv)) {
        return RD_CSR_FIELD_M(riscv, mtvec, MODE) & riscv_int_CLIC;
    } else {
        return RD_CSR_FIELD_S(riscv, stvec, MODE) & riscv_int_CLIC;
    }
}

//
// Should CLIC be used for U-mode interrupts?
//
inline static Bool useCLICU(riscvP riscv) {
    if(mtvecDeterminesCLICMode(riscv)) {
        return RD_CSR_FIELD_M(riscv, mtvec, MODE) & riscv_int_CLIC;
    } else {
        return RD_CSR_FIELD_U(riscv, utvec, MODE) & riscv_int_CLIC;
    }
}

//
// Should CLIC be used for H-mode interrupts?
//
inline static Bool useCLICH(riscvP riscv) {
    return False;
}

//
// Should CLIC be used for VS-mode interrupts?
//
inline static Bool useCLICVS(riscvP riscv) {
    return False;
}

//
// Should CLIC be used for VU-mode interrupts?
//
inline static Bool useCLICVU(riscvP riscv) {
    return False;
}

//
// Is CSIP present?
//
inline static Bool haveCSIP(riscvP riscv) {
    return CLICPresent(riscv) && riscv->configInfo.CSIP_present;
}

//
// Is CSIP present with ID 12?
//
inline static Bool useCSIP12(riscvP riscv) {
    return (
        haveCSIP(riscv) &&
        (riscv->configInfo.CLIC_version<=RVCLC_0_9_20220315)
    );
}

//
// Is CSIP present with ID 16?
//
inline static Bool useCSIP16(riscvP riscv) {
    return (
        haveCSIP(riscv) &&
        (riscv->configInfo.CLIC_version>RVCLC_0_9_20220315)
    );
}

//
// Compose vtype
//
inline static riscvVType composeVType(riscvP riscv, Uns32 vtypeBits) {
    riscvVType vtype = {format : riscv->vtypeFormat, u : {u32 : vtypeBits}};
    return vtype;
}

//
// Return current vtype
//
inline static riscvVType getCurrentVType(riscvP riscv) {
    return composeVType(riscv, RD_CSRC(riscv, vtype));
}

//
// Return current SEW
//
inline static Uns32 getCurrentSEW(riscvP riscv) {
    return getVTypeSEW(getCurrentVType(riscv));
}

//
// Return current vector signed vlmul
//
inline static Int32 getCurrentSVLMUL(riscvP riscv) {
    return getVTypeSVLMUL(getCurrentVType(riscv));
}

//
// Is User mode present?
//
inline static Bool userPresent(riscvP riscv) {
    return riscv->configInfo.arch & ISA_U;
}

//
// Is Supervisor mode present?
//
inline static Bool supervisorPresent(riscvP riscv) {
    return riscv->configInfo.arch & ISA_S;
}

//
// Is Hypervisor extension present?
//
inline static Bool hypervisorPresent(riscvP riscv) {
    return riscv->configInfo.arch & ISA_H;
}

//
// Is Hypervisor extension enabled?
//
inline static Bool hypervisorEnabled(riscvP riscv) {
    return riscv->currentArch & ISA_H;
}

//
// Is bit manipulation extension enabled?
//
inline static Bool bitmanipEnabled(riscvP riscv) {
    return riscv->currentArch & ISA_B;
}

//
// Is cryptographic extension enabled?
//
inline static Bool cryptoEnabled(riscvP riscv) {
    return riscv->currentArch & ISA_K;
}

//
// Is atomic extension enabled?
//
inline static Bool atomicEnabled(riscvP riscv) {
    return riscv->currentArch & ISA_A;
}

//
// Is bit manipulation extension present?
//
inline static Bool bitmanipPresent(riscvP riscv) {
    return riscv->configInfo.arch & ISA_B;
}

//
// Is cryptographic extension present?
//
inline static Bool cryptoPresent(riscvP riscv) {
    return riscv->configInfo.arch & ISA_K;
}

//
// Is DSP extension present?
//
inline static Bool DSPPresent(riscvP riscv) {
    return riscv->configInfo.arch & ISA_P;
}

//
// Is Vector extension present?
//
inline static Bool vectorPresent(riscvP riscv) {
    return riscv->configInfo.arch & ISA_V;
}

//
// Return implemented guest external interrupts
//
inline static Uns32 getTriggerNum(riscvP riscv) {
    return riscv->configInfo.trigger_num;
}

//
// Is Zfinx configured?
//
inline static riscvZfinxVer Zfinx(riscvP riscv) {
    return RISCV_ZFINX_VERSION(riscv);
}

//
// Is Zfa configured?
//
inline static riscvZceeVer Zfa(riscvP riscv) {
    return riscv->configInfo.Zfa;
}

//
// Is notional Zcd configured?
//
inline static riscvZceeVer Zcd(riscvP riscv) {
    return riscv->configInfo.compress_present & RVCS_Zcd;
}

//
// Is Zcmt configured?
//
inline static riscvZceeVer Zcmt(riscvP riscv) {
    return riscv->configInfo.compress_present & RVCS_Zcmt;
}

//
// Is legacy Zcea configured?
//
inline static riscvZceaVer Zcea(riscvP riscv) {
    return RISCV_ZCEA_VERSION(riscv);
}

//
// Is legacy Zceb configured?
//
inline static riscvZcebVer Zceb(riscvP riscv) {
    return RISCV_ZCEB_VERSION(riscv);
}

//
// Is legacy Zcee configured?
//
inline static riscvZceeVer Zcee(riscvP riscv) {
    return RISCV_ZCEE_VERSION(riscv);
}

//
// Is Smaia configured?
//
inline static riscvZceeVer Smaia(riscvP riscv) {
    return riscv->configInfo.Smaia;
}

//
// Is Sstc configured?
//
inline static riscvZceeVer Sstc(riscvP riscv) {
    return riscv->configInfo.Sstc;
}

//
// Is this processor a PSE?
//
inline static Bool isPSE(riscvP riscv) {
    return riscv->configInfo.isPSE;
}

//
// Are per-instruction fflags enabled?
//
inline static Bool perInstructionFFlags(riscvP riscv) {
    return riscv->configInfo.enable_fflags_i;
}

//
// Return effective mvien value
//
inline static Uns64 getEffectiveMvien(riscvP riscv) {
    return RD_CSR64(riscv, mvien) & ~RD_CSR64(riscv, mideleg);
}

//
// Return effective hvien value
//
inline static Uns64 getEffectiveHvien(riscvP riscv) {
    Uns64 hideleg = RD_CSR64(riscv, hideleg) & RD_CSR64(riscv, mideleg);
    return RD_CSR64(riscv, hvien) & ~hideleg;
}

//
// Is stimecmp enabled (Sstc extension)
//
inline static Bool stimecmpEnabled(riscvP riscv) {
    return RD_CSR_FIELDC(riscv, menvcfg, STCE);
}

//
// Is vstimecmp enabled (Sstc extension)
//
inline static Bool vstimecmpEnabled(riscvP riscv) {
    return stimecmpEnabled(riscv) && RD_CSR_FIELDC(riscv, henvcfg, STCE);
}

//
// Is some time-related CSR present?
//
inline static Bool timeRelatedCSRPresent(riscvP riscv) {
    return Sstc(riscv) || !riscv->configInfo.time_undefined;
}

//
// Should external mtime source port be created?
//
inline static Bool externalMTIME(riscvP riscv) {
    return !CLINTInternal(riscv) && timeRelatedCSRPresent(riscv);
}

//
// Must internal mtime timer be created?
//
inline static Bool internalMTIME(riscvP riscv) {
    return (
        !(riscv->mtimePort && riscv->mtimePort->desc.handle) &&
        (CLINTInternal(riscv) || timeRelatedCSRPresent(riscv))
    );
}


