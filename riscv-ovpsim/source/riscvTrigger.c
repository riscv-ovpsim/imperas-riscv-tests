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

        if(RD_REG_FIELD_TRIGGER(trigger, tdata1, type) != TT_ADMATCH) {

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
// Indicate whether the trigger matches the given value
//
static Bool matchTriggerADMATCHValue(
    riscvP        riscv,
    riscvTriggerP trigger,
    Uns64         value
) {
    // address match
    Uns32 mode   = RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.match);
    Uns64 tdata2 = RD_REG_TRIGGER_MODE(riscv, trigger, tdata2);
    Bool  match  = False;

    switch(mode) {

        case 0: case 8:
            match = (value==tdata2);
            break;

        case 1: case 9: {
            Uns64 mask = ~(tdata2 ^ (tdata2+1));
            match = ((value&mask)==(tdata2&mask));
            break;
        }

        case 2:
            match = (value>=tdata2);
            break;

        case 3:
            match = (value<tdata2);
            break;

        case 4: {
            Uns32 shift = TRIGGER_IS_32M(riscv) ? 16 : 32;
            value &= (tdata2>>shift);
            return ((value<<shift)==(tdata2<<shift));
        }

        case 5: {
            Uns32 shift = TRIGGER_IS_32M(riscv) ? 16 : 32;
            value &= tdata2;
            return ((value>>shift)==(tdata2&((1ULL<<shift)-1)));
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
static Bool chainToNext(riscvTriggerP this) {
    if(RD_REG_FIELD_TRIGGER(this, tdata1, type) != TT_ADMATCH) {
        return False;
    } else {
        return RD_REG_FIELD_TRIGGER(this, tdata1, mcontrol.chain);
    }
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

    return (i==(riscv->configInfo.trigger_num-1)) || !chainToNext(this);
}

//
// If all triggers in the chain starting with the given trigger match, return
// the last trigger in the chain
//
static riscvTriggerP matchChain(riscvP riscv, riscvTriggerP this, Uns64 iCount) {

    Bool match;

    while(
        (match=(this->matchICount==iCount)) &&
        !lastInChain(riscv, this)
    ) {
        this++;
    }

    return match ? this : 0;
}

//
// Return the configured action for a trigger
//
static Uns32 getTriggerAction(riscvTriggerP trigger) {

    Uns32 result = 0;

    switch(RD_REG_FIELD_TRIGGER(trigger, tdata1, type)) {

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
// Take action for a trigger if required
// TODO: handle actions after the current instruction completes
//
static Bool doTriggerAction(riscvP riscv, Bool complete) {

    Uns64 iCount  = getCycleCount(riscv);
    Bool  doBkpt  = False;
    Bool  doDebug = False;
    Uns32 i;

    for(i=0; i<riscv->configInfo.trigger_num; i++) {

        riscvTriggerP this = &riscv->triggers[i];
        Uns32         action;

        if(!firstInChain(riscv, this)) {
            // no action
        } else if(!(this=matchChain(riscv, this, iCount))) {
            // no action
        } else if(!(action=getTriggerAction(this))) {
            doBkpt = True;
        } else if(action==1) {
            doDebug = True;
        }
    }

    if(!complete) {
        // no action
    } else if(doDebug) {
        riscvSetDM(riscv, True);
    } else if(doBkpt) {
        riscvBreakpointException(riscv);
    }

    // indicate if some exception is taken
    return doDebug || doBkpt;
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
    Bool    complete
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

        if(RD_REG_FIELD_TRIGGER(trigger, tdata1, type) != TT_ADMATCH) {
            // not an address match trigger
        } else if(!(RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.modes) & modeMask)) {
            // not applicable to this mode
        } else if(!(RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.priv) & priv)) {
            // not applicable to this access privilege
        } else if(!matchTriggerADMATCHSize(riscv, trigger, bytes)) {
            // size constraint does not match
        } else if(RD_REG_FIELD_TRIGGER(trigger, tdata1, mcontrol.select)) {
            match = valueValid && matchTriggerADMATCHValue(riscv, trigger, value);
        } else {
            match = matchTriggerADMATCHValue(riscv, trigger, VA);
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
        except = doTriggerAction(riscv, complete);
    }

    return except;
}

//
// Handle possible execute trigger for faulting address
//
Bool riscvTriggerX0(riscvP riscv, Addr VA, Bool complete) {
    return doTriggerADMATCH(riscv, VA, 0, 0, MEM_PRIV_X, False, complete);
}

//
// Handle possible execute trigger for 2-byte instruction
//
void riscvTriggerX2(riscvP riscv, Addr VA, Uns32 value) {
    doTriggerADMATCH(riscv, VA, value, 2, MEM_PRIV_X, True, True);
}

//
// Handle possible execute trigger for 4-byte instruction
//
void riscvTriggerX4(riscvP riscv, Addr VA, Uns32 value) {
    doTriggerADMATCH(riscv, VA, value, 4, MEM_PRIV_X, True, True);
}

//
// Handle possible load address trigger
//
void riscvTriggerLA(riscvP riscv, Uns32 bytes) {
    doTriggerADMATCH(
        riscv, riscv->triggerVA, 0, bytes, MEM_PRIV_R, False, True
    );
}

//
// Handle possible load value trigger
//
void riscvTriggerLV(riscvP riscv, Uns32 bytes) {
    doTriggerADMATCH(
        riscv, riscv->triggerVA, riscv->triggerLV, bytes, MEM_PRIV_R, True, True
    );
}

//
// Handle possible store trigger
//
void riscvTriggerS(riscvP riscv, Uns64 value, Uns32 bytes) {
    doTriggerADMATCH(
        riscv, riscv->triggerVA, value, bytes, MEM_PRIV_W, True, True
    );
}


