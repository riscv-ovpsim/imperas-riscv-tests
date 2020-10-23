/*
 * Copyright (c) 2005-2020 Imperas Software Ltd., www.imperas.com
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
// Return cycle count
//
inline static Uns64 getCycleCount(riscvP riscv) {
    return vmirtGetICount((vmiProcessorP)riscv);
}


////////////////////////////////////////////////////////////////////////////////
// TRIGGER REGISTER UPDATE
////////////////////////////////////////////////////////////////////////////////

//
// Return trigger type
//
inline static triggerType getTriggerType(riscvP riscv, riscvTriggerP trigger) {
    return RD_REG_FIELD_TRIGGER_MODE(riscv, trigger, tdata1, type);
}

//
// Return indication of active trigger types in the current mode
//
riscvArchitecture riscvGetCurrentTriggers(riscvP riscv) {

    riscvMode         mode     = getCurrentMode3(riscv);
    Uns32             modeMask = 1<<mode;
    riscvArchitecture arch     = 0;
    Uns32             i;

    // process all triggers
    for(i=0; i<riscv->configInfo.trigger_num; i++) {

        riscvTriggerP trigger = &riscv->triggers[i];

        if(getTriggerType(riscv, trigger) != TT_ADMATCH) {

            // not an address match trigger

        } else if(!(RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.modes) & modeMask)) {

            // not applicable to this mode

        } else {

            memPriv priv = RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.priv);

            if(priv&MEM_PRIV_W) {
                arch |= ISA_TM_S;
            }
            if(priv&MEM_PRIV_X) {
                arch |= ISA_TM_X;
            }
            if(!(priv&MEM_PRIV_R)) {
                // no action
            } else if(RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.select)) {
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
// Return the configured timing for a trigger
//
static Bool getTriggerAfter(riscvP riscv, riscvTriggerP trigger) {
    if(getTriggerType(riscv, trigger) != TT_ADMATCH) {
        return True;
    } else {
        return RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.timing);
    }
}

//
// Return the configured action for a trigger
//
static Uns32 getTriggerAction(riscvP riscv, riscvTriggerP trigger) {

    Uns32 result = 0;

    switch(getTriggerType(riscv, trigger)) {

        case TT_ADMATCH:
            result = RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.action);
            break;

        case TT_ICOUNT:
            result = RD_REG_FIELD_TRIGGER(trigger, tdata1, icount.action);
            break;

        case TT_INTERRUPT:
            result = RD_REG_FIELD_TRIGGER(trigger, tdata1, itrigger.action);
            break;

        case TT_EXCEPT:
            result = RD_REG_FIELD_TRIGGER(trigger, tdata1, etrigger.action);
            break;

        default:
            VMI_ABORT("unimplemented case"); // LCOV_EXCL_LINE
    }

    return result;
}

//
// Set the hit bit in a trigger
//
static void setTriggerHit(riscvP riscv, riscvTriggerP trigger) {

    switch(getTriggerType(riscv, trigger)) {

        case TT_ADMATCH:
            WR_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.hit, 1);
            break;

        case TT_ICOUNT:
            WR_REG_FIELD_TRIGGER(trigger, tdata1, icount.hit, 1);
            break;

        case TT_INTERRUPT:
            WR_REG_FIELD_TRIGGER_MODE(riscv, trigger, tdata1, itrigger.hit, 1);
            break;

        case TT_EXCEPT:
            WR_REG_FIELD_TRIGGER_MODE(riscv, trigger, tdata1, etrigger.hit, 1);
            break;

        default:
            VMI_ABORT("unimplemented case"); // LCOV_EXCL_LINE
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
static Bool matchTriggerADMATCHSize(
    riscvP        riscv,
    riscvTriggerP trigger,
    Uns32         bytes
) {
    // get base size
    Uns32 size = RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.sizelo);

    // include 64-bit size component
    if(!TRIGGER_IS_32M(riscv)) {
        size += RD_REG_FIELD_TRIGGER64(trigger, tdata1, mcontrol.sizehi)*4;
    }

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
// Is trigger selected by textra.mselect?
//
static Bool matchTriggerMSelect(riscvP riscv, riscvTriggerP trigger) {

    Uns32 mselect = RD_REG_FIELD_TRIGGER_MODE(riscv, trigger, tdata3, mselect);
    Uns32 mvalue  = RD_REG_FIELD_TRIGGER_MODE(riscv, trigger, tdata3, mvalue);

    if(mselect==0) {

        // always match
        return True;

    } else {

        // match if the low bits of mcontext equal mvalue
        Uns32 mask     = getAddressMask(riscv->configInfo.mvalue_bits);
        Uns32 mcontext = RD_REG_TRIGGER(trigger, mcontext);

        return mvalue == (mcontext & mask);
    }
}

//
// Is trigger selected by textra.sselect?
//
static Bool matchTriggerSSelect(riscvP riscv, riscvTriggerP trigger) {

    Uns32 sselect = RD_REG_FIELD_TRIGGER_MODE(riscv, trigger, tdata3, sselect);
    Uns64 svalue  = RD_REG_FIELD_TRIGGER_MODE(riscv, trigger, tdata3, svalue);

    if(sselect==0) {

        // always match
        return True;

    } else if(sselect==1) {

        // match if the low bits of scontext equal svalue
        Uns64 mask     = getAddressMask(riscv->configInfo.svalue_bits);
        Uns64 scontext = RD_REG_TRIGGER(trigger, scontext);

        return svalue == (scontext & mask);

    } else {

        Uns32 mask = getAddressMask(TRIGGER_IS_32M(riscv) ? 9 : 16);
        Uns32 ASID = RD_CSR_FIELD_S(riscv, satp, ASID);

        return (svalue & mask) == ASID;
    }
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
    Uns32 mode   = RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.match);
    Uns64 tdata2 = RD_REG_TRIGGER_MODE(riscv, trigger, tdata2);
    Bool  match  = False;

    // mask value and tdata2 to required bits
    Uns64 maskBits = getAddressMask(bits);
    Uns64 valueM   = value  & maskBits;
    Uns64 tdata2M  = tdata2 & maskBits;

    switch(mode) {

        case 0: case 8:
            match = (valueM==tdata2M);
            break;

        case 1: case 9: {
            Uns64 maskTopM = ~(tdata2M ^ (tdata2M+1));
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

    return match;
}

//
// Mark an activated trigger
//
static void markTriggerMatched(riscvP riscv, riscvTriggerP trigger) {
    trigger->matchICount = getCycleCount(riscv);
}

//
// Is the given trigger linked to the next in a chain?
//
static Bool chainToNext(riscvP riscv, riscvTriggerP this) {
    return (
        (getTriggerType(riscv, this) == TT_ADMATCH) &&
        RD_REG_FIELD_TRIGGER(this, tdata1, mcontrol.chain)
    );
}

//
// Is the given trigger the first in a chain?
//
static Bool firstInChain(riscvP riscv, riscvTriggerP this) {

    Uns32         i    = this-riscv->triggers;
    riscvTriggerP prev = i ? this-1 : 0;

    return !prev || !chainToNext(riscv, prev);
}

//
// Is the given trigger the last in a chain?
//
static Bool lastInChain(riscvP riscv, riscvTriggerP this) {

    Uns32 i = this-riscv->triggers;

    return (i==(riscv->configInfo.trigger_num-1)) || !chainToNext(riscv, this);
}

//
// If all triggers in the chain starting with the given trigger match, return
// the last trigger in the chain
//
static riscvTriggerP matchChain(riscvP riscv, riscvTriggerP this, Uns64 iCount) {

    Bool          after = getTriggerAfter(riscv, this);
    riscvTriggerP hit   = this;
    riscvTriggerP last;

    do {

        // assume no match
        last = 0;

        if(this->matchICount!=iCount) {
            // trigger has not matched
        } else if(after!=getTriggerAfter(riscv, this)) {
            // a chain of triggers that don't all have the same timing
        } else {
            last = this++;
        }

    } while(last && !lastInChain(riscv, last));

    if(!last) {

        // no match

    } else if(!riscv->configInfo.no_hit) {

        // mark all triggers in the chain as hit
        do {
            setTriggerHit(riscv, hit);
        } while(hit++!=last);
    }

    return last;
}

//
// This enumates actions required when a trigger fires
//
typedef enum triggerActionE {
    TA_NONE         = 0x0,    // no pending action
    TA_DEBUG_BEFORE = 0x1,    // enter Debug mode before
    TA_DEBUG_AFTER  = 0x2,    // enter Debug mode after
    TA_BKPT_BEFORE  = 0x4,    // take breakpoint exception before
    TA_BKPT_AFTER   = 0x8,    // take breakpoint exception after
    TA_BKPT         = (TA_BKPT_BEFORE|TA_BKPT_AFTER),
    TA_AFTER        = (TA_DEBUG_AFTER|TA_BKPT_AFTER)
} triggerAction;

//
// Return any active trigger action
//
static triggerAction getActiveAction(riscvP riscv, Bool complete, Uns32 delta) {

    Uns64         iCount = getCycleCount(riscv) - delta;
    triggerAction result = TA_NONE;
    Bool          doBKPT = True;
    Uns32         i;

    for(i=0; i<riscv->configInfo.trigger_num; i++) {

        riscvTriggerP this  = &riscv->triggers[i];
        Bool          after = getTriggerAfter(riscv, this);
        Uns32         action;

        if(!firstInChain(riscv, this)) {
            // no action
        } else if(!(this=matchChain(riscv, this, iCount))) {
            // no action
        } else if(!(action=getTriggerAction(riscv, this))) {
            result |= after ? TA_BKPT_AFTER : TA_BKPT_BEFORE;
        } else if(action==1) {
            result |= after ? TA_DEBUG_AFTER : TA_DEBUG_BEFORE;
        }
    }

    // disable M-mode breakpoint triggers if required
    if(getCurrentMode3(riscv)!=RISCV_MODE_M) {
        // not in M-mode
    } else if(!riscv->configInfo.tcontrol_undefined) {
        doBKPT = RD_CSR_FIELDC(riscv, tcontrol, mte);
    } else {
        doBKPT = RD_CSR_FIELDC(riscv, mstatus, MIE);
    }

    // disable M-mode breakpoint triggers if required
    if(!doBKPT) {
        result &= ~TA_BKPT;
    }

    // return required action
    return result;
}

//
// Take action for a trigger *before* the current instruction if required
// (or schedule action after the instruction completes)
//
static Bool doTriggerBefore(riscvP riscv, Bool complete) {

    triggerAction action = getActiveAction(riscv, complete, 0);

    if(!action) {
        // no action
    } else if(!complete) {
        // no action
    } else if(action & TA_DEBUG_BEFORE) {
        riscvSetDM(riscv, True);
    } else if(action & TA_BKPT_BEFORE) {
        riscvBreakpointException(riscv);
    } else if(action & TA_AFTER) {
        riscv->netValue.triggerAfter = True;
        vmirtDoSynchronousInterrupt((vmiProcessorP)riscv);
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
        // no action
    } else if(!complete) {
        // no action
    } else if(action & TA_DEBUG_AFTER) {
        riscv->netValue.triggerAfter = False;
        riscvSetDM(riscv, True);
    } else if(action & TA_BKPT_AFTER) {
        riscv->netValue.triggerAfter = False;
        riscvBreakpointException(riscv);
    }

    // indicate if some exception is taken
    return action;
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
    Bool    complete,
    Bool    onlyBefore
) {
    riscvMode mode      = getCurrentMode3(riscv);
    Bool      someMatch = False;
    Bool      except    = False;
    Uns32     i;

    if(inDebugMode(riscv)) {

        // triggers do not fire while in debug mode

    } else for(i=0; i<riscv->configInfo.trigger_num; i++) {

        // identify any ADMATCH triggers that have been activated
        riscvTriggerP trigger  = &riscv->triggers[i];
        Uns32         modeMask = 1<<mode;
        Bool          match    = False;

        if(getTriggerType(riscv, trigger) != TT_ADMATCH) {
            // not an address match trigger
        } else if(onlyBefore && getTriggerAfter(riscv, trigger)) {
            // ignore triggers with 'after' timing
        } else if(!(RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.modes) & modeMask)) {
            // not applicable to this mode
        } else if(!(RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.priv) & priv)) {
            // not applicable to this access privilege
        } else if(!matchTriggerADMATCHSize(riscv, trigger, bytes)) {
            // size constraint does not match
        } else if(!matchTriggerMSelect(riscv, trigger)) {
            // failed textra.mselect condition
        } else if(!matchTriggerSSelect(riscv, trigger)) {
            // failed textra.sselect condition
        } else if(!RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.select)) {
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
        except = doTriggerBefore(riscv, complete);
    }

    return except;
}

//
// Handle possible execute trigger for faulting address
//
Bool riscvTriggerX0(riscvP riscv, Addr VA, Bool complete) {
    return doTriggerADMATCH(riscv, VA, 0, 0, MEM_PRIV_X, False, complete, True);
}

//
// Handle possible execute trigger for 2-byte instruction
//
void riscvTriggerX2(riscvP riscv, Addr VA, Uns32 value) {
    doTriggerADMATCH(riscv, VA, value, 2, MEM_PRIV_X, True, True, False);
}

//
// Handle possible execute trigger for 4-byte instruction
//
void riscvTriggerX4(riscvP riscv, Addr VA, Uns32 value) {
    doTriggerADMATCH(riscv, VA, value, 4, MEM_PRIV_X, True, True, False);
}

//
// Handle possible load address trigger
//
void riscvTriggerLA(riscvP riscv, Uns32 bytes) {
    doTriggerADMATCH(
        riscv, riscv->triggerVA, 0, bytes, MEM_PRIV_R, False, True, False
    );
}

//
// Handle possible load value trigger
//
void riscvTriggerLV(riscvP riscv, Uns32 bytes) {
    doTriggerADMATCH(
        riscv, riscv->triggerVA, riscv->triggerLV, bytes, MEM_PRIV_R, True,
        True, False
    );
}

//
// Handle possible store trigger
//
void riscvTriggerS(riscvP riscv, Uns64 value, Uns32 bytes) {
    doTriggerADMATCH(
        riscv, riscv->triggerVA, value, bytes, MEM_PRIV_W, True, True, False
    );
}

//
// Handle any trigger activated after the previous instruction completes
//
Bool riscvTriggerAfter(riscvP riscv, Bool complete) {
    return doTriggerAfter(riscv, complete);
}


////////////////////////////////////////////////////////////////////////////////
// SAVE/RESTORE SUPPORT
////////////////////////////////////////////////////////////////////////////////

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

            for(i=0; i<riscv->configInfo.trigger_num; i++) {

                riscvTriggerP trigger = &riscv->triggers[i];
                char          name[16];

                fillTriggerName(name, i);
                VMIRT_SAVE_REG(cxt, name, trigger);
            }
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

            for(i=0; i<riscv->configInfo.trigger_num; i++) {

                riscvTriggerP trigger = &riscv->triggers[i];
                char          name[16];

                fillTriggerName(name, i);
                VMIRT_RESTORE_REG(cxt, name, trigger);
            }

            riscvSetCurrentArch(riscv);
        }
    }
}



