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

// Imperas header files
#include "hostapi/impAlloc.h"

// VMI header files
#include "vmi/vmiMessage.h"
#include "vmi/vmiRt.h"

// model header files
#include "riscvBus.h"
#include "riscvCluster.h"
#include "riscvFunctions.h"
#include "riscvStructure.h"
#include "riscvUtils.h"


//
// Structure describing a port
//
typedef struct riscvBusPortS {
    vmiBusPort    desc;
    riscvBusPortP next;
} riscvBusPort;

//
// Return any child of the passed processor
//
inline static riscvP getChild(riscvP riscv) {
    return (riscvP)vmirtGetSMPChild((vmiProcessorP)riscv);
}

//
// Get bus port context processor for the given root (either the root itself,
// if the first child if the root is a cluster)
//
static riscvP getBusPortContext(riscvP root) {
    return riscvIsCluster(root) ? getChild(root) : root;
}

//
// Allocate a new port and append to the tail of the list
//
static riscvBusPortP newBusPort(
    riscvBusPortPP *tailP,
    const char     *name,
    vmiBusPortType  type,
    vmiDomainType   domainType,
    Uns8            min,
    Uns8            max,
    Uns8            unset,
    Bool            mustBeConnected,
    const char     *desc
) {
    riscvBusPortPP tail = *tailP;
    riscvBusPortP  this = STYPE_CALLOC(riscvBusPort);
    vmiBusPortP    info = &this->desc;

    // fill port fields
    info->name            = name;
    info->type            = type;
    info->domainType      = domainType;
    info->addrBits.min    = min;
    info->addrBits.max    = max;
    info->addrBits.unset  = unset;
    info->mustBeConnected = mustBeConnected;
    info->description     = desc;

    // append to list and update tail
    this->next = *tail;
    *tail      = this;
    *tailP     = &this->next;

    // return new port
    return this;
}

//
// Allocate bus port specifications at root level
//
void riscvNewRootBusPorts(riscvP riscv) {

    riscvBusPortPP tail  = &riscv->busPorts;
    riscvP         cxt   = getBusPortContext(riscv);
    Uns32          xlen  = riscvGetXlenArch(cxt);
    Uns32          min   = 32;
    Uns32          unset = (xlen==32) ? RISCV_PMP_BITS_32 : RISCV_PMP_BITS_64;
    Uns32          max   = (xlen==32) ? RISCV_PMP_BITS_32 : 64;

    // instruction port
    newBusPort(
        &tail,
        "INSTRUCTION",
        vmi_BP_MASTER,
        vmi_DOM_CODE,
        min, max, unset,
        True,
        "Instruction bus"
    );

    // data port
    newBusPort(
        &tail,
        "DATA",
        vmi_BP_MASTER,
        vmi_DOM_DATA,
        min, max, unset,
        False,
        "Data bus"
    );
}

//
// Allocate bus port specifications at leaf level
//
void riscvNewLeafBusPorts(riscvP riscv) {

    riscvBusPortPP tail = &riscv->busPorts;

    // add artifact CSR bus allowing external implementation of CSR registers
    // if required
    if(riscv->configInfo.enable_CSR_bus || riscv->configInfo.IMSIC_present) {
        riscv->csrPort = newBusPort(
            &tail,
            "CSR",
            vmi_BP_MASTER,
            vmi_DOM_OTHER,
            16, 16, 16,
            False,
            "Artifact bus allowing external implementation of CSR registers"
        );
    }

    // add artifact IMSIC bus allowing external implementation of IMSIC
    // interrupts if required
    if(riscv->configInfo.IMSIC_present) {
        riscv->IMSICPort = newBusPort(
            &tail,
            "IMSIC",
            vmi_BP_MASTER,
            vmi_DOM_OTHER,
            16, 16, 16,
            True,
            "Artifact bus for external implementation of IMSIC registers"
        );
    }
}

//
// Free bus port specifications
//
void riscvFreeBusPorts(riscvP riscv) {

    riscvBusPortP next = riscv->busPorts;
    riscvBusPortP this;

    while((this=next)) {
        next = this->next;
        STYPE_FREE(this);
    }

    riscv->busPorts = 0;
}

//
// Get the next bus port
//
VMI_BUS_PORT_SPECS_FN(riscvBusPortSpecs) {

    riscvP        riscv = (riscvP)processor;
    riscvBusPortP this;

    if(!prev) {
        this = riscv->busPorts;
    } else {
        this = ((riscvBusPortP)prev)->next;
    }

    return this ? &this->desc : 0;
}

//
// Return any memDomain object for the given port
//
inline static memDomainP portToDomain(riscvBusPortP port) {
    return port ? port->desc.domain : NULL;
}

//
// Return any domain connected to the artifact port implementing CSRs
//
memDomainP riscvGetExternalCSRDomain(riscvP riscv) {
    return portToDomain(riscv->csrPort);
}

//
// Return any domain connected to the artifact port implementing IMSIC registers
//
memDomainP riscvGetExternalIMSICDomain(riscvP riscv) {
    return portToDomain(riscv->IMSICPort);
}


