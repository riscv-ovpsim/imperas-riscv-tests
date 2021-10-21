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

// Standard header files
#include <stdio.h>

// Imperas header files
#include "hostapi/impAlloc.h"

// VMI header files
#include "vmi/vmiMessage.h"
#include "vmi/vmiRt.h"

// model header files
#include "riscvExceptions.h"
#include "riscvMessage.h"
#include "riscvStructure.h"
#include "riscvTrigger.h"
#include "riscvUtils.h"


////////////////////////////////////////////////////////////////////////////////
// UTILITY FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Return current PC
//
inline static Uns64 getPC(riscvP riscv) {
    return vmirtGetPC((vmiProcessorP)riscv);
}

//
// Return cycle count
//
inline static Uns64 getCycleCount(riscvP riscv) {
    return vmirtGetICount((vmiProcessorP)riscv);
}

//
// Mark an activated trigger
//
static void markTriggerMatched(riscvP riscv, riscvTriggerP trigger) {
    trigger->matchICount = getCycleCount(riscv);
}


////////////////////////////////////////////////////////////////////////////////
// TRIGGER REGISTER UPDATE
////////////////////////////////////////////////////////////////////////////////

//
// Return number opf triggers
//
inline static Uns32 numTriggers(riscvP riscv) {
    return riscv->configInfo.trigger_num;
}

//
// Return trigger type
//
inline static triggerType getTriggerType(riscvTriggerP trigger) {
    return trigger->tdata1UP.type;
}

//
// Is the trigger an ADMATCH trigger (or the MCONTROL6 replacement)?
//
static Bool isTriggerADMATCH(riscvTriggerP trigger) {

    triggerType type = getTriggerType(trigger);

    return ((type==TT_ADMATCH) || (type==TT_MCONTROL6));
}

//
// Is the trigger an ICOUNT trigger active in the given mode?
//
static Bool activeTriggerICOUNT(riscvTriggerP trigger, Uns32 modeMask) {
    return (
        (getTriggerType(trigger) == TT_ICOUNT) &&
        (trigger->tdata1UP.modes & modeMask)
    );
}

//
// Is the trigger an ADMATCH trigger active in the given mode?
//
static Bool activeTriggerADMATCH(riscvTriggerP trigger, Uns32 modeMask) {
    return (
        isTriggerADMATCH(trigger) &&
        (trigger->tdata1UP.modes & modeMask)
    );
}

//
// Return indication of active trigger types in the current mode
//
riscvArchitecture riscvGetCurrentTriggers(riscvP riscv) {

    riscvMode         mode     = getCurrentMode5(riscv);
    Uns32             modeMask = 1<<mode;
    riscvArchitecture arch     = 0;
    Uns32             i;

    // process all triggers
    for(i=0; i<numTriggers(riscv); i++) {

        riscvTriggerP trigger = &riscv->triggers[i];

        if(activeTriggerICOUNT(trigger, modeMask)) {

            // handle ICOUNT trigger as always-active ADMATCH
            arch |= ISA_TM_X;

            // pending triggers should match immediately
            if(trigger->tdata1UP.pending) {
                markTriggerMatched(riscv, trigger);
            }

        } else if(activeTriggerADMATCH(trigger, modeMask)) {

            memPriv priv = trigger->tdata1UP.priv;

            if(priv&MEM_PRIV_W) {
                arch |= ISA_TM_S;
            }
            if(priv&MEM_PRIV_X) {
                arch |= ISA_TM_X;
            }
            if(!(priv&MEM_PRIV_R)) {
                // no action
            } else if(trigger->tdata1UP.select) {
                arch |= ISA_TM_LV;
            } else {
                arch |= ISA_TM_LA;
            }
        }
    }

    // update state if trigger module is activated
    if(arch) {

        Bool doFlush = False;

        // determine whether state changes require dictionaries to be flushed
        if((arch & ISA_TM_LA) && !riscv->checkTriggerLA) {
            doFlush = riscv->checkTriggerLA = True;
        }
        if((arch & ISA_TM_LV) && !riscv->checkTriggerLV) {
            doFlush = riscv->checkTriggerLV = True;
        }
        if((arch & ISA_TM_S) && !riscv->checkTriggerS) {
            doFlush = riscv->checkTriggerS = True;
        }
        if((arch & ISA_TM_X) && !riscv->checkTriggerX) {
            doFlush = riscv->checkTriggerX = True;
        }

        // flush dictionaries if required
        if(doFlush) {
            vmirtFlushAllDicts((vmiProcessorP)riscv);
        }
    }

    return arch;
}


////////////////////////////////////////////////////////////////////////////////
// TRIGGER REGISTER FIELD ACCESS
////////////////////////////////////////////////////////////////////////////////

//
// Return the configured timing for a trigger - note that for ICOUNT
// breakpoints, timing is usually after an instruction conpletes but switches
// to *before* the instruction if the pending bit is set (for breakpoints
// scheduled after instructions that cause exceptions)
//
inline static Bool getTriggerAfter(riscvTriggerP trigger) {
    return !trigger->tdata1UP.pending && trigger->tdata1UP.timing;
}

//
// Return the configured action for a trigger
//
inline static Uns32 getTriggerAction(riscvTriggerP trigger) {
    return trigger->tdata1UP.action;
}

//
// Mark the trigger as hit
//
static void setTriggerHit(riscvP riscv, riscvTriggerP trigger) {

    trigger->triggered = True;

    if(!riscv->configInfo.no_hit) {
        trigger->tdata1UP.hit = 1;
    }
}


////////////////////////////////////////////////////////////////////////////////
// TRIGGER MATCH FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Map from trigger size encoding to bytes
//
static const Uns8 trigBytes[] = {0, 1, 2, 4, 6, 8, 10, 12, 14, 16};

//
// Does the access match the size encoded with the trigger?
//
static Bool matchTriggerADMATCHSize(riscvTriggerP trigger, Uns32 bytes) {

    // get base size
    Uns32 size = trigger->tdata1UP.size;

    // match any size or the size given
    return (
        !size ||
        (
            bytes                    &&
            (size<sizeof(trigBytes)) &&
            (bytes==trigBytes[size])
        )
    );
}

//
// Return value masked to the number of bits
//
inline static Uns64 getMasked(Uns64 value, Uns32 bits) {
    return value & getAddressMask(bits);
}

//
// Is trigger selected by textra.mselect?
//
static Bool matchTriggerMSelect(riscvP riscv, riscvTriggerP trigger) {

    Uns32 mhselect = trigger->tdata3UP.mhselect;
    Uns32 mhvalue  = trigger->tdata3UP.mhvalue;
    Bool  match    = False;

    if(mhselect==0) {

        // always match
        match = True;

    } else if(mhselect==4) {

        // match if the low bits of mcontext equal mvalue
        Uns32 mcontext  = RD_REG_TRIGGER(trigger, mcontext);
        Uns32 mcontextM = getMasked(mcontext, TRIGGER_IS_32M(riscv) ? 6 : 13);

        match = (mhvalue==mcontextM);

    } else if((mhselect&3)==1) {

        // match if the low bits of mcontext equal {mhvalue,mhselect[2]}
        Uns32 mcontext  = RD_REG_TRIGGER(trigger, mcontext);
        Uns32 mcontextM = getMasked(mcontext, TRIGGER_IS_32M(riscv) ? 7 : 14);
        Uns32 mhvalue2  = (mhvalue<<1)+(mhselect>>2);

        match = (mhvalue2==mcontextM);

    } else {

        // match if VMID in hgatp equals the lower VMIDMAX bits of
        // {mhvalue,mhselect[2]}
        Uns32 VMID     = RD_CSR_FIELD(riscv, hgatp, VMID);
        Uns32 mhvalue2 = (mhvalue<<1)+(mhselect>>2);

        match = (VMID==mhvalue2);
    }

    return match;
}

//
// Is trigger selected by textra.sselect?
//
static Bool matchTriggerSSelect(
    riscvP        riscv,
    riscvTriggerP trigger,
    riscvMode     mode
) {
    Uns32 sselect = trigger->tdata3UP.sselect;
    Uns64 svalue  = trigger->tdata3UP.svalue;
    Bool  match   = False;

    if(sselect==0) {

        // always match
        match = True;

    } else if(sselect==1) {

        // match if the low bits of scontext equal svalue
        Uns64 scontext   = RD_REG_TRIGGER(trigger, scontext);
        Uns64 scontextM  = getMasked(scontext, TRIGGER_IS_32M(riscv) ? 16 : 34);
        Uns32 sbytemask  = trigger->tdata3UP.sbytemask;
        Uns64 maskResult = 0;
        Uns64 maskField;

        // construct per-field mask
        for(maskField=0xff; sbytemask; sbytemask>>=1, maskField<<=8) {
            if(sbytemask&1) {
                maskResult |= maskField;
            }
        }

        // apply byte mask
        svalue    &= ~maskResult;
        scontextM &= ~maskResult;

        match = (svalue==scontextM);

    } else {

        // match if ASID in satp/vsatp equals the lower ASIDMAX bits of svalue
        Uns32 ASID    = RD_CSR_FIELD_V(riscv, satp, modeIsVirtual(mode), ASID);
        Uns32 svalueM = getMasked(svalue, TRIGGER_IS_32M(riscv) ? 9 : 16);

        match = (ASID==svalueM);
    }

    return match;
}

//
// Given the effective value of tdata2, return a mask value for comparison of
// values using match=1 mode
//
static Uns64 getMatch1Mask(riscvP riscv, Uns64 tdata2M) {

    Uns32 maskmax = riscv->configInfo.mcontrol_maskmax;
    Uns64 mask    = -1;

    if(maskmax) {
        mask = ~(tdata2M ^ (tdata2M+1));
    }

    return mask;
}

//
// Indicate whether the trigger matches the given value
//
static Bool matchTriggerADMATCHValue(
    riscvP        riscv,
    riscvTriggerP trigger,
    Uns64         value,
    Uns32         bits
) {
    // address match
    Uns32 mode   = trigger->tdata1UP.match;
    Uns64 tdata2 = RD_REG_TRIGGER_MODE(riscv, trigger, tdata2);
    Uns32 xlen   = riscvGetXlenMode(riscv);
    Bool  match  = False;

    // mask value and tdata2 to required bits
    Uns64 maskBits = getAddressMask((bits<xlen) ? bits : xlen);
    Uns64 valueM   = value  & maskBits;
    Uns64 tdata2M  = tdata2 & maskBits;

    switch(mode) {

        case 0: case 8:
            match = (valueM==tdata2M);
            break;

        case 1: case 9: {
            Uns64 maskTopM = getMatch1Mask(riscv, tdata2M);
            match = ((valueM&maskTopM)==(tdata2M&maskTopM));
            break;
        }

        case 2:
            match = (valueM>=tdata2M);
            break;

        case 3:
            match = (valueM<tdata2M);
            break;

        case 4: case 12: {
            Uns32 shift  = TRIGGER_IS_32M(riscv) ? 16 : 32;
            Uns32 maskH  = getAddressMask(shift);
            Uns32 value1 = valueM  & maskH & (tdata2>>shift);
            Uns32 value2 = tdata2M & maskH;
            return (value1==value2);
        }

        case 5: case 13: {
            Uns32 shift  = TRIGGER_IS_32M(riscv) ? 16 : 32;
            Uns32 maskH  = getAddressMask(shift);
            Uns32 value1 = ((value&tdata2)>>shift) & maskBits;
            Uns32 value2 = tdata2M & maskH;
            return (value1==value2);
        }
    }

    // negate match if required
    if((mode==8) || (mode==9) || (mode==12) || (mode==13)) {
        match = !match;
    }

    if(match) {
        trigger->tvalValid = True;
        trigger->tval      = value;
    }

    return match;
}

//
// Is the given trigger linked to the next in a chain?
//
inline static Bool chainToNext(riscvTriggerP this) {
    return this->tdata1UP.chain;
}

//
// Is the given trigger the first in a chain?
//
static Bool firstInChain(riscvP riscv, riscvTriggerP this) {

    Uns32         i    = this-riscv->triggers;
    riscvTriggerP prev = i ? this-1 : 0;

    return !prev || !chainToNext(prev);
}

//
// Is the given trigger the last in a chain?
//
static Bool lastInChain(riscvP riscv, riscvTriggerP this) {

    Uns32 i = this-riscv->triggers;

    return (i==(numTriggers(riscv)-1)) || !chainToNext(this);
}

//
// If all triggers in the chain starting with the given trigger match, return
// the last trigger in the chain
//
static riscvTriggerP matchChain(riscvP riscv, riscvTriggerP this, Uns64 iCount) {

    Bool          after = getTriggerAfter(this);
    riscvTriggerP last;

    do {

        // assume no match
        last = 0;

        if(this->matchICount!=iCount) {
            // trigger has not matched
        } else if(after!=getTriggerAfter(this)) {
            // a chain of triggers that don't all have the same timing
        } else {
            last = this++;
        }

    } while(last && !lastInChain(riscv, last));

    return last;
}

//
// This enumerates actions required when a trigger fires
//
typedef enum triggerActionE {
    TA_NONE         = 0x0,    // no pending action
    TA_DEBUG_BEFORE = 0x1,    // enter Debug mode before
    TA_DEBUG_AFTER  = 0x2,    // enter Debug mode after
    TA_BKPT_BEFORE  = 0x4,    // take breakpoint exception before
    TA_BKPT_AFTER   = 0x8,    // take breakpoint exception after
    TA_DEBUG        = (TA_DEBUG_BEFORE|TA_DEBUG_AFTER),
    TA_BKPT         = (TA_BKPT_BEFORE |TA_BKPT_AFTER),
    TA_BEFORE       = (TA_DEBUG_BEFORE|TA_BKPT_BEFORE),
    TA_AFTER        = (TA_DEBUG_AFTER |TA_BKPT_AFTER)
} triggerAction;

//
// Return any active trigger action
//
static triggerAction getActiveAction(riscvP riscv, Uns32 delta, Bool complete) {

    Uns64         iCount = getCycleCount(riscv) - delta;
    triggerAction result = TA_NONE;
    Bool          doBKPT = True;
    Uns32         i;

    // disable M-mode breakpoint triggers if required
    if(getCurrentMode3(riscv)!=RISCV_MODE_M) {
        // not in M-mode
    } else if(!riscv->configInfo.tcontrol_undefined) {
        doBKPT = RD_CSR_FIELDC(riscv, tcontrol, mte);
    } else {
        doBKPT = RD_CSR_FIELDC(riscv, mstatus, MIE);
    }

    for(i=0; i<numTriggers(riscv); i++) {

        riscvTriggerP this  = &riscv->triggers[i];
        riscvTriggerP last  = 0;
        Bool          after = getTriggerAfter(this);
        Uns32         action;

        // indicate not triggered initially
        this->triggered = False;

        // assume this is not a matching instruction count trigger
        this->tdata1UP.icmatch = False;

        if(!firstInChain(riscv, this)) {
            // no action
        } else if(!(last=matchChain(riscv, this, iCount))) {
            // no action
        } else if((action=getTriggerAction(last))==1) {
            result |= after ? TA_DEBUG_AFTER : TA_DEBUG_BEFORE;
        } else if(!action && doBKPT) {
            result |= after ? TA_BKPT_AFTER : TA_BKPT_BEFORE;
        } else {
            last = 0;
        }

        // do actions if the chain matches
        if(last) {

            // mark all triggers in the chain as hit if required
            if(complete) {
                do {
                    setTriggerHit(riscv, this);
                } while(this++!=last);
            }

            // mark matching instruction count trigger
            if(getTriggerType(last) == TT_ICOUNT) {
                last->tdata1UP.icmatch = True;
            }
        }
    }

    // return required action
    return result;
}

//
// Take action for a trigger
//
static void doTriggerAction(riscvP riscv, triggerAction action, Bool baseValid) {

    Uns64 tval = getPC(riscv);
    Uns32 i;

    for(i=0; i<numTriggers(riscv); i++) {

        riscvTriggerP this = &riscv->triggers[i];

        // reset ICOUNT trigger by clearing modes and pending bit
        if(this->tdata1UP.icmatch) {
            this->tdata1UP.modes   = 0;
            this->tdata1UP.pending = False;
            this->tdata1UP.icmatch = False;
        }

        // use any tval associated with the trigger
        if(this->triggered && this->tvalValid) {
            this->triggered = False;
            tval            = this->tval;
        }
    }

    // adjust base instruction count to allow for instruction retirement
    if(baseValid || riscvInhibitInstret(riscv)) {
        // no action
    } else if(action==TA_DEBUG_BEFORE) {
        riscv->baseInstructions++;
    } else if(action==TA_BKPT_AFTER) {
        riscv->baseInstructions--;
    }

    // either enter Debug mode or take M-mode exception
    if(action & TA_DEBUG) {
        riscvSetDM(riscv, True);
    } else {
        riscvTakeException(riscv, riscv_E_Breakpoint, tval);
    }
}

//
// Schedule action for a trigger after the current instruction
//
inline static void scheduleTriggerAfter(riscvP riscv) {
    riscv->netValue.triggerAfter = True;
    vmirtDoSynchronousInterrupt((vmiProcessorP)riscv);
}

//
// Take action for a trigger *before* the current instruction if required
// (or schedule action after the instruction completes)
//
static Bool doTriggerBefore(riscvP riscv, Bool baseValid) {

    triggerAction action = getActiveAction(riscv, 0, True);

    if(!action) {
        // no action
    } else if(!(action & TA_BEFORE)) {
        scheduleTriggerAfter(riscv);
    } else {
        doTriggerAction(riscv, action, baseValid);
    }

    // indicate if some exception is taken
    return action;
}

//
// Handle any trigger activated *after* the previous instruction completes
//
static Bool doTriggerAfter(riscvP riscv, Bool complete) {

    triggerAction action = getActiveAction(riscv, complete, complete) & TA_AFTER;

    if(!action) {
        // state change disabling previously-scheduled trigger
        riscv->netValue.triggerAfter = False;
    } else if(complete) {
        riscv->netValue.triggerAfter = False;
        doTriggerAction(riscv, action, False);
    }

    // indicate if some exception is taken
    return action;
}

//
// Is the trigger of the given type and selected?
//
inline static Bool selectTrigger(
    riscvP        riscv,
    riscvTriggerP trigger,
    triggerType   type,
    riscvMode     mode
) {
    return (
        (getTriggerType(trigger) == type) &&
        matchTriggerMSelect(riscv, trigger) &&
        matchTriggerSSelect(riscv, trigger, mode)
    );
}

//
// Is the trigger of the given type and selected?
//
inline static Bool selectTriggerADMATCH(
    riscvP        riscv,
    riscvTriggerP trigger,
    riscvMode     mode
) {
    return (
        isTriggerADMATCH(trigger) &&
        matchTriggerMSelect(riscv, trigger) &&
        matchTriggerSSelect(riscv, trigger, mode)
    );
}

//
// Handle possible ADMATCH trigger for the given virtual address and bytes.
// When 'bytes' is zero, this indicates a trigger before an instruction is
// executed on an address that will fault. 'value' is valid only if valueValid
// is True.
//
static Bool doTriggerADMATCH(
    riscvP  riscv,
    Uns64   VA,
    Uns64   value,
    Uns32   bytes,
    memPriv priv,
    Bool    valueValid,
    Bool    onlyBefore
) {
    riscvMode mode      = getCurrentMode5(riscv);
    Bool      someMatch = False;
    Bool      except    = False;
    Uns32     i;

    if(inDebugMode(riscv)) {

        // triggers do not fire while in debug mode

    } else for(i=0; i<numTriggers(riscv); i++) {

        // identify any ADMATCH triggers that have been activated
        riscvTriggerP trigger  = &riscv->triggers[i];
        Uns32         modeMask = 1<<mode;
        Bool          match    = False;

        if(onlyBefore && getTriggerAfter(trigger)) {
            // ignore triggers with 'after' timing
        } else if(!(trigger->tdata1UP.modes & modeMask)) {
            // not applicable to this mode
        } else if(selectTrigger(riscv, trigger, TT_ICOUNT, mode)) {
            match = True;
        } else if(!selectTriggerADMATCH(riscv, trigger, mode)) {
            // trigger not selected
        } else if(!(trigger->tdata1UP.priv & priv)) {
            // not applicable to this access privilege
        } else if(!matchTriggerADMATCHSize(trigger, bytes)) {
            // size constraint does not match
        } else if(!trigger->tdata1UP.select) {
            match = matchTriggerADMATCHValue(riscv, trigger, VA, 64);
        } else if(valueValid) {
            match = matchTriggerADMATCHValue(riscv, trigger, value, bytes*8);
        }

        // indicate the trigger has matched if required
        if(match) {
            markTriggerMatched(riscv, trigger);
            someMatch = True;
        }
    }

    // if some trigger has matched, scan again to see whether action is
    // required
    if(someMatch) {
        except = doTriggerBefore(riscv, onlyBefore);
    }

    return except;
}

//
// Handle any trigger activated by a trap
//
static void triggerTrap(
    riscvP      riscv,
    riscvMode   modeY,
    Uns32       ecode,
    triggerType type
) {
    Uns32 modeMask  = 1<<modeY;
    Bool  someMatch = False;
    Uns32 i;

    for(i=0; i<numTriggers(riscv); i++) {

        // identify any ADMATCH triggers that have been activated
        riscvTriggerP trigger  = &riscv->triggers[i];
        Bool          match    = False;

        if(!(trigger->tdata1UP.modes & modeMask)) {
            // not applicable to this mode
        } else if(selectTrigger(riscv, trigger, TT_ICOUNT, modeY)) {
            // matching ICOUNT must set pending (but otherwise not a match)
            trigger->tdata1UP.pending = 1;
        } else if(!selectTrigger(riscv, trigger, type, modeY)) {
            // trigger not selected
        } else if(ecode<64) {
            match = RD_REG_TRIGGER_MODE(riscv, trigger, tdata2) & (1ULL<<ecode);
        }

        // indicate the trigger has matched if required
        if(match) {
            markTriggerMatched(riscv, trigger);
            someMatch = True;
        }
    }

    // if some trigger has matched, schedule action before the next instruction
    if(someMatch && (getActiveAction(riscv, 0, True) & TA_AFTER)) {
        scheduleTriggerAfter(riscv);
    }
}

//
// Handle any trigger activated by an NMI
//
static void triggerNMI(riscvP riscv) {

    Bool  someMatch = False;
    Uns32 i;

    for(i=0; i<numTriggers(riscv); i++) {

        // identify any ADMATCH triggers that have been activated
        riscvTriggerP trigger = &riscv->triggers[i];

        // indicate the trigger has matched if required
        if((getTriggerType(trigger) == TT_EXCEPTION) && trigger->tdata1UP.nmi) {
            markTriggerMatched(riscv, trigger);
            someMatch = True;
        }
    }

    // if some trigger has matched, schedule action before the next instruction
    if(someMatch && (getActiveAction(riscv, 0, True) & TA_AFTER)) {
        scheduleTriggerAfter(riscv);
    }
}

//
// Handle possible execute trigger for faulting address
//
Bool riscvTriggerX0(riscvP riscv, Addr VA) {
    return doTriggerADMATCH(riscv, VA, 0, 0, MEM_PRIV_X, False, True);
}

//
// Handle possible execute trigger for 2-byte instruction
//
void riscvTriggerX2(riscvP riscv, Addr VA, Uns32 value) {
    doTriggerADMATCH(riscv, VA, value, 2, MEM_PRIV_X, True, False);
}

//
// Handle possible execute trigger for 4-byte instruction
//
void riscvTriggerX4(riscvP riscv, Addr VA, Uns32 value) {
    doTriggerADMATCH(riscv, VA, value, 4, MEM_PRIV_X, True, False);
}

//
// Handle possible load address trigger
//
void riscvTriggerLA(riscvP riscv, Uns32 bytes) {
    doTriggerADMATCH(
        riscv, riscv->triggerVA, 0, bytes, MEM_PRIV_R, False, False
    );
}

//
// Handle possible load value trigger
//
void riscvTriggerLV(riscvP riscv, Uns32 bytes) {
    doTriggerADMATCH(
        riscv, riscv->triggerVA, riscv->triggerLV, bytes, MEM_PRIV_R, True,
        False
    );
}

//
// Handle possible store trigger
//
void riscvTriggerS(riscvP riscv, Uns64 value, Uns32 bytes) {
    doTriggerADMATCH(
        riscv, riscv->triggerVA, value, bytes, MEM_PRIV_W, True, False
    );
}

//
// Handle any trigger activated after the previous instruction completes
//
Bool riscvTriggerAfter(riscvP riscv, Bool complete) {
    return doTriggerAfter(riscv, complete);
}

//
// Handle any trigger activated on an interrupt
//
void riscvTriggerInterrupt(riscvP riscv, riscvMode modeY, Uns32 ecode) {
    triggerTrap(riscv, modeY, ecode, TT_INTERRUPT);
}

//
// Handle any trigger activated on an NMI
//
void riscvTriggerNMI(riscvP riscv) {
    triggerNMI(riscv);
}

//
// Handle any trigger activated on an exception
//
void riscvTriggerException(riscvP riscv, riscvMode modeY, Uns32 ecode) {
    triggerTrap(riscv, modeY, ecode, TT_EXCEPTION);
}


////////////////////////////////////////////////////////////////////////////////
// SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

#define TRIGGER_VA  "TRIGGER_VA"
#define TRIGGER_LV  "TRIGGER_LV"

//
// Fill trigger register name
//
inline static void fillTriggerName(char *name, Uns32 i) {
    sprintf(name, "TRIGGER%u", i);
}

//
// Save Trigger Module state not covered by register read/write API
//
void riscvTriggerSave(
    riscvP              riscv,
    vmiSaveContextP     cxt,
    vmiSaveRestorePhase phase
) {
    if(phase==SRT_END_CORE) {

        if(riscv->triggers) {

            Uns32 i;

            for(i=0; i<numTriggers(riscv); i++) {

                riscvTriggerP trigger = &riscv->triggers[i];
                char          name[32];

                fillTriggerName(name, i);
                VMIRT_SAVE_REG(cxt, name, trigger);
            }

            // save trigger VA and load value
            VMIRT_SAVE_REG(cxt, TRIGGER_VA, &riscv->triggerVA);
            VMIRT_SAVE_REG(cxt, TRIGGER_LV, &riscv->triggerLV);
        }
    }
}

//
// Restore Trigger Module state not covered by register read/write API
//
void riscvTriggerRestore(
    riscvP              riscv,
    vmiRestoreContextP  cxt,
    vmiSaveRestorePhase phase
) {
    if(phase==SRT_END_CORE) {

        if(riscv->triggers) {

            Uns32 i;

            for(i=0; i<numTriggers(riscv); i++) {

                riscvTriggerP trigger = &riscv->triggers[i];
                char          name[32];

                fillTriggerName(name, i);
                VMIRT_RESTORE_REG(cxt, name, trigger);
            }

            // restore trigger VA and load value
            VMIRT_RESTORE_REG(cxt, TRIGGER_VA, &riscv->triggerVA);
            VMIRT_RESTORE_REG(cxt, TRIGGER_LV, &riscv->triggerLV);

            riscvSetCurrentArch(riscv);
        }
    }
}

