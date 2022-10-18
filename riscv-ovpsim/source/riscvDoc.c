/*
 * Copyright (c) 2005-2022 Imperas Software Ltd., www.imperas.com
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
#include <string.h>

// VMI header files
#include "vmi/vmiAttrs.h"
#include "vmi/vmiModelInfo.h"
#include "vmi/vmiDoc.h"
#include "vmi/vmiRt.h"

// model header files
#include "riscvCluster.h"
#include "riscvFunctions.h"
#include "riscvParameters.h"
#include "riscvStructure.h"
#include "riscvUtils.h"
#include "riscvVariant.h"


//
// Define target of snprintf with correct size
//
#define SNPRINTF_TGT(_S) _S, sizeof(_S)

//
// Return any chld of the passed processor
//
inline static riscvP getChild(riscvP riscv) {
    return (riscvP)vmirtGetSMPChild((vmiProcessorP)riscv);
}

//
// Return description of Sv mode
//
static const char *getSvMode(Uns32 index) {

    static const char *map[16] = {
        [VAM_Bare] = "bare",
        [VAM_Sv32] = "Sv32",
        [VAM_Sv39] = "Sv39",
        [VAM_Sv48] = "Sv48",
        [VAM_Sv57] = "Sv57",
        [VAM_Sv64] = "Sv64",
    };

    return map[index] ? : "unknown";
}

//
// Fill result with description string of a single Sv mode
//
static void fillSvMode(char *result, Uns32 mask) {

    Uns32 index = 0;

    while((mask=(mask>>1))) {
        index++;
    }

    sprintf(result, "%u (%s)", index, getSvMode(index));
}

//
// Fill result with description string of supported Sv modes
//
static void fillSvModes(char *result, Uns32 Sv_modes) {

    Bool  first = True;
    Uns32 mask;

    while((mask = (Sv_modes & -Sv_modes))) {

        char SvMode[16];

        Sv_modes &= ~mask;

        if(first) {
            strcpy(result, Sv_modes ? "modes " : "mode ");
        } else {
            strcat(result, Sv_modes ? ", " : " and ");
        }

        fillSvMode(SvMode, mask);
        strcat(result, SvMode);

        first = False;
    }
}

//
// Add documentation of xtvec regiser
//
static void addDocXTVec(
    riscvConfigCP cfg,
    vmiDocNodeP   node,
    Uns64         tvec_mask,
    const char   *rname,
    const char   *pmask
) {
    char string[1024];

    // document mtvec_mask behavior
    snprintf(
        SNPRINTF_TGT(string),
        "Values written to \"%s\" are masked using the value "
        "0x"FMT_Ax". A different mask of writable bits may be "
        "specified using parameter \"%s\" if required. In "
        "addition, when Vectored interrupt mode is enabled, parameter "
        "\"tvec_align\" may be used to specify additional "
        "hardware-enforced base address alignment. In this variant, "
        "\"tvec_align\" defaults to %u%s.",
        rname, tvec_mask, pmask, cfg->tvec_align,
        cfg->tvec_align ? "" : ", implying no alignment constraint"
    );
    vmidocAddText(node, string);
}

//
// Add documentation of sign extension of register
//
static void addDocSExt(
    vmiDocNodeP node,
    Uns32       sext,
    const char *rname,
    const char *pname
) {
    char string[1024];

    if(sext) {

        snprintf(
            SNPRINTF_TGT(string),
            "If parameter \"%s\" is True, values written to \"%s\" are "
            "sign-extended from the most-significant writable bit. In this "
            "variant, \"%s\" is True, indicating that \"%s\" is sign-extended "
            "from bit %u.",
            pname, rname, pname, rname, 64-sext-1
        );

    } else {

        snprintf(
            SNPRINTF_TGT(string),
            "If parameter \"%s\" is True, values written to \"%s\" are "
            "sign-extended from the most-significant writable bit. In this "
            "variant, \"%s\" is False, indicating that \"%s\" is not "
            "sign-extended.",
            pname, rname, pname, rname
        );
    }

    vmidocAddText(node, string);
}

//
// Add documentation using the optional documentation callback
//
inline static void addOptDoc(riscvP riscv, vmiDocNodeP node, riscvDocFn docCB) {
    if(docCB) {
        docCB(riscv, node);
    }
}

//
// Add documentation using an optional null-terminated string list
//
static void addOptDocList(vmiDocNodeP node, const char **specificDocs) {

    if(specificDocs) {

        const char *doc;

        while((doc=*specificDocs++)) {
            vmidocAddText(node, doc);
        }
    }
}

//
// Add documentation of a B-extension subset parameter
//
static void addBFeature(
    riscvConfigCP    cfg,
    vmiDocNodeP      Parameters,
    char            *string,
    Uns32            stringLen,
    riscvBitManipSet feature,
    const char      *name,
    const char      *desc
) {
    Bool ignored_1_0_0 = feature & ~RVBS_1_0_0;
    snprintf(
        string, stringLen,
        "Parameter \"%s\" is used to specify that %s instructions are present. "
        "By default, \"%s\" is set to %u in this variant. Updates to this "
        "parameter require a commercial product license.%s",
        name, desc, name, !(cfg->bitmanip_absent & feature),
        ignored_1_0_0 ?
        " This parameter is ignored for version 1.0.0, which does not "
        "implement that subset." : ""
    );
    vmidocAddText(Parameters, string);
}

//
// Add documentation of a C-extension subset parameter
//
static void addCFeature(
    riscvConfigCP  cfg,
    vmiDocNodeP    Parameters,
    char          *string,
    Uns32          stringLen,
    riscvCryptoSet feature,
    const char    *name,
    const char    *desc
) {
    snprintf(
        string, stringLen,
        "Parameter \"%s\" is used to specify that %s instructions are present. "
        "By default, \"%s\" is set to %u in this variant. Updates to this "
        "parameter require a commercial product license.",
        name, desc, name, (cfg->compress_present & feature) && True
    );
    vmidocAddText(Parameters, string);
}

//
// Add documentation of a C-extension subset parameter
//
static void addLegacyCFeature(
    riscvConfigCP cfg,
    vmiDocNodeP   Parameters,
    char         *string,
    Uns32         stringLen,
    const char   *name,
    const char   *value
) {
    snprintf(
        string, stringLen,
        "Parameter \"%s_version\" is used to specify the version of %s "
        "instructions present. By default, \"%s_version\" is set to \"%s\" in "
        "this variant. Updates to this parameter require a commercial product "
        "license.",
        name, name, name, value
    );
    vmidocAddText(Parameters, string);
}

//
// Add documentation of a K-extension subset parameter
//
static void addKFeature(
    riscvConfigCP  cfg,
    vmiDocNodeP    Parameters,
    char          *string,
    Uns32          stringLen,
    riscvCryptoSet feature,
    const char    *name,
    const char    *desc
) {
    snprintf(
        string, stringLen,
        "Parameter \"%s\" is used to specify that %s instructions are present. "
        "By default, \"%s\" is set to %u in this variant. Updates to this "
        "parameter require a commercial product license.",
        name, desc, name, !(cfg->crypto_absent & feature)
    );
    vmidocAddText(Parameters, string);
}

//
// Add documentation of a deprecated K-extension subset parameter
//
static void addDeprecatedKFeature(
    riscvConfigCP  cfg,
    vmiDocNodeP    Parameters,
    char          *string,
    Uns32          stringLen,
    riscvCryptoSet feature,
    const char    *name,
    const char    *alias,
    const char    *desc
) {
    snprintf(
        string, stringLen,
        "Parameter \"%s\" used to specify that %s instructions are present; it "
        "is a deprecated alias of parameter \"%s\" which should be used "
        "instead. By default, \"%s\" is set to %u in this variant. Updates to "
        "this parameter require a commercial product license.",
        name, desc, alias, name, !(cfg->crypto_absent & feature)
    );
    vmidocAddText(Parameters, string);
}

//
// Add documentation of a P extension subset parameter
//
static void addPFeature(
    riscvConfigCP    cfg,
    vmiDocNodeP      Parameters,
    char            *string,
    Uns32            stringLen,
    riscvBitManipSet feature,
    const char      *name,
    const char      *desc
) {
    snprintf(
        string, stringLen,
        "Parameter \"%s\" is used to specify that %s instructions are present. "
        "By default, \"%s\" is set to %u in this variant. Updates to this "
        "parameter require a commercial product license.",
        name, desc, name, !(cfg->dsp_absent & feature)
    );
    vmidocAddText(Parameters, string);
}

//
// Return bits in raw architecture that have named features associated with them
//
static riscvArchitecture getNamedSet(riscvArchitecture arch) {

    riscvArchitecture result = 0;
    Uns32             featureBit;

    for(featureBit=0; featureBit<=('Z'-'A'); featureBit++) {
        riscvArchitecture feature = 1<<featureBit;
        if((feature & arch) && riscvGetFeatureName(feature, True)) {
           result |= feature;
        }
    }

    return result;
}

//
// Get architecture options that may be enabled but are not by default
//
static riscvArchitecture getCanEnable(riscvConfigCP cfg) {
    return getNamedSet(~cfg->arch & ~cfg->archFixed);
}

//
// Get architecture options that are enabled by default, but can be disabled
// NOTE: E and I are excluded because each is disabled by enabling the other
//
static riscvArchitecture getCanDisable(riscvConfigCP cfg) {
    return getNamedSet(cfg->arch & ~cfg->archFixed & ~(ISA_E|ISA_I));
}

//
// Add nodes listing features for feature letters
//
static void listFeatures(
    vmiDocNodeP       node,
    riscvArchitecture arch,
    char             *string,
    Uns32             stringLen
) {
    Uns32 featureBit;

    for(featureBit = 0; featureBit <= ('Z'-'A'); featureBit++) {

        riscvArchitecture feature = 1 << featureBit;

        // report the extensions that are supported but not enabled
        if(arch & feature) {

            const char *name = riscvGetFeatureName(feature, True);

            snprintf(
                string, stringLen,
                "misa bit %u: %s",
                featureBit,
                name ? name : "unknown feature"
            );

            vmidocAddText(node, string);
        }
    }
}

//
// Return the length of a string required to hold the elements concatenated
// using sep[0] for all but the last pair and sep[1] for the last pair
//
static Uns32 concatLength(
    const char **members,
    const char **sep,
    Uns32        numMembers
) {
    Uns32 result = 1;   // string terminator
    Uns32 i;

    // account for first member
    result += strlen(members[0]);

    // account for remaining members
    for(i=1; i<numMembers; i++) {
        result += strlen(sep[i==(numMembers-1)]);
        result += strlen(members[i]);
    }

    return result;
}

//
// Concatenate the members into result string, separating with sep[0] for all
// but the last pair and sep[1] for the last pair
//
static const char *concat(
    char        *result,
    const char **members,
    const char **sep,
    Uns32        numMembers
) {
    Uns32 i;

    // append first member
    strcpy(result, members[0]);

    // append remaining members
    for(i=1; i<numMembers; i++) {
        strcat(result, sep[i==(numMembers-1)]);
        strcat(result, members[i]);
    }

    return result;
}

//
// Document extension with matching field in configuration
//
#define DOC_EXTENSION(_RISCV, _PARAMS, _STRING, _NAME) \
    snprintf(                                                               \
        SNPRINTF_TGT(_STRING),                                              \
        "Parameter "#_NAME" is used to specify whether the "#_NAME" "       \
        "extension is implemented. By default, "#_NAME" is set to %u in "   \
        "this variant.",                                                    \
        _RISCV->configInfo._NAME                                            \
    );                                                                      \
    vmidocAddText(_PARAMS, _STRING)

//
// Document vector profile option in configuration
//
#define DOC_VPROFILE(_RISCV, _PARAMS, _STRING, _NAME) \
    snprintf(                                                               \
        SNPRINTF_TGT(_STRING),                                              \
        "Parameter "#_NAME" is used to specify whether the "#_NAME" "       \
        "extension is implemented. By default, "#_NAME" is set to %u in "   \
        "this variant.",                                                    \
        _RISCV->configInfo.vect_profile==RVVS_##_NAME                       \
    );                                                                      \
    vmidocAddText(_PARAMS, _STRING)

//
// Document CLIC if required
//
static void docCLIC(riscvP riscv, vmiDocNodeP Root) {

    riscvConfigCP cfg = &riscv->configInfo;
    char string[1024];

    if(riscv->parent) {

        // document at root level only

    } else if(!cfg->CLICLEVELS) {

        vmiDocNodeP CLIC = vmidocAddSection(Root, "CLIC");

        vmidocAddText(
            CLIC,
            "The model can be configured to implement a Core Local Interrupt "
            "Controller (CLIC) using parameter \"CLICLEVELS\"; when non-zero, "
            "the CLIC is present with the specified number of interrupt "
            "levels (2-256), as described in the RISC-V Core-Local Interrupt "
            "Controller specification, and further parameters are made "
            "available to configure other aspects of the CLIC. \"CLICLEVELS\" "
            "is zero in this variant, indicating that a CLIC is not "
            "implemented."
        );

    } else {

        vmiDocNodeP CLIC = vmidocAddSection(Root, "CLIC");

        snprintf(
            SNPRINTF_TGT(string),
            "This model implements a Core Local Interrupt Controller (CLIC) "
            "with %u levels. Parameter \"CLICLEVELS\" can be used to specify "
            "a different number of interrupt levels (2-256), as described in "
            "the RISC-V Core-Local Interrupt Controller specification (see "
            "references). Set \"CLICLEVELS\" to zero to indicate the CLIC "
            "is not implemented.",
            cfg->CLICLEVELS
        );
        vmidocAddText(CLIC, string);

        vmidocAddText(
            CLIC,
            "The model can configured either to use an internal CLIC model "
            "(if parameter \"externalCLIC\" is False) or to present a net "
            "interface to allow the CLIC to be implemented externally in a "
            "platform component (if parameter \"externalCLIC\" is True). "
            "When the CLIC is implemented internally, net ports for standard "
            "interrupts and additional local interrupts are available. When "
            "the CLIC is implemented externally, a net port interface allowing "
            "the highest-priority pending interrupt to be delivered is instead "
            "present. This is described below."
        );

        ////////////////////////////////////////////////////////////////////////
        // CLIC COMMON PARAMETERS
        /////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Parameters = vmidocAddSection(
                CLIC, "CLIC Common Parameters"
            );

            vmidocAddText(
                Parameters,
                "This section describes parameters applicable whether the CLIC "
                "is implemented internally or externally. These are:"
            );

            // document CLICANDBASIC
            snprintf(
                SNPRINTF_TGT(string),
                "\"CLICANDBASIC\": this Boolean parameter indicates whether "
                "both CLIC and basic interrupt controller are present (if "
                "True) or whether only the CLIC is present (if False). The "
                "default value in this variant is %s.",
                riscv->configInfo.CLICANDBASIC ? "True" : "False"
            );
            vmidocAddText(Parameters, string);

            // document CLICXNXTI
            snprintf(
                SNPRINTF_TGT(string),
                "\"CLICXNXTI\": this Boolean parameter indicates whether xnxti "
                "CSRs are implemented (if True) or unimplemented (if False). "
                "The default value in this variant is %s.",
                riscv->configInfo.CLICXNXTI ? "True" : "False"
            );
            vmidocAddText(Parameters, string);

            // document CLICXCSW
            snprintf(
                SNPRINTF_TGT(string),
                "\"CLICXCSW\": this Boolean parameter indicates whether "
                "xscratchcsw and xscratchcswl CSRs registers are implemented "
                "(if True) or unimplemented (if False). The default value in "
                "this variant is %s.",
                riscv->configInfo.CLICXCSW ? "True" : "False"
            );
            vmidocAddText(Parameters, string);

            // document mclicbase
            snprintf(
                SNPRINTF_TGT(string),
                "\"mclicbase\": this parameter specifies the CLIC base address "
                "in physical memory. The default value in this variant is 0x"
                FMT_Ax".",
                cfg->csr.mclicbase.u64.bits
            );
            vmidocAddText(Parameters, string);

            // document tvt_undefined
            snprintf(
                SNPRINTF_TGT(string),
                "\"tvt_undefined\": this Boolean parameter indicates whether "
                "xtvt CSRs registers are implemented (if True) or unimplemented "
                "(if False). If the registers are unimplemented then the model "
                "will use basic mode vectored interrupt semantics based on the "
                "xtvec CSRs instead of Selective Hardware Vectoring semantics "
                "described in the specification. The default value in this "
                "variant is %s.",
                riscv->configInfo.tvt_undefined ? "True" : "False"
            );
            vmidocAddText(Parameters, string);

            // document intthresh_undefined
            snprintf(
                SNPRINTF_TGT(string),
                "\"intthresh_undefined\": this Boolean parameter indicates "
                "whether xintthresh CSRs are implemented (if True) or "
                "unimplemented (if False). The default value in this variant "
                "is %s.",
                riscv->configInfo.intthresh_undefined ? "True" : "False"
            );
            vmidocAddText(Parameters, string);

            // document INTTHRESHBITS
            snprintf(
                SNPRINTF_TGT(string),
                "\"INTTHRESHBITS\": if xintthresh CSRs are implemented, this "
                "parameter indicates the number of implemented bits in the "
                "\"th\" field. The default value in this variant is %u.",
                riscv->configInfo.INTTHRESHBITS
            );
            vmidocAddText(Parameters, string);

            // document mclicbase_undefined
            snprintf(
                SNPRINTF_TGT(string),
                "\"mclicbase_undefined\": this Boolean parameter indicates "
                "whether the mclicbase CSR register is implemented (if True) "
                "or unimplemented (if False). The default value in this "
                "variant is %s.",
                riscv->configInfo.mclicbase_undefined ? "True" : "False"
            );
            vmidocAddText(Parameters, string);

            // document CSIP_present
            snprintf(
                SNPRINTF_TGT(string),
                "\"CSIP_present\": this Boolean parameter indicates whether "
                "the CSIP interrupt is implemented (if True) or unimplemented "
                "(if False). If implemented, the interrupt is positive-edge "
                "triggered, and has id 12 or 16, depending on the CLIC version "
                "selected. The default value in this variant is %s.",
                riscv->configInfo.CSIP_present ? "True" : "False"
            );
            vmidocAddText(Parameters, string);
        }

        ////////////////////////////////////////////////////////////////////////
        // CLIC INTERNAL-IMPLEMENTATION PARAMETERS
        /////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Parameters = vmidocAddSection(
                CLIC, "CLIC Internal-Implementation Parameters"
            );

            vmidocAddText(
                Parameters,
                "This section describes parameters applicable only when the "
                "CLIC is implemented internally. These are:"
            );

            // document CLIC_version
            vmidocAddText(
                Parameters,
                "\"CLIC_version\": this defines the version of the CLIC "
                "specification that is implemented. See the References section "
                "of this document for more information."
            );

            // document CLICCFGMBITS
            snprintf(
                SNPRINTF_TGT(string),
                "\"CLICCFGMBITS\": this Uns32 parameter indicates the maximum "
                "number of bits that can be specified as implemented in "
                "cliccfg.nmbits, and also indirectly defines CLICPRIVMODES. "
                "For cores which implement only Machine mode, or which "
                "implement Machine and User modes but not the N extension, the "
                "parameter is absent (\"CLICCFGMBITS\" must be zero in these "
                "cases). The default value in this variant is %u.",
                riscv->configInfo.CLICCFGMBITS
            );
            vmidocAddText(Parameters, string);

            // document CLICCFGLBITS
            snprintf(
                SNPRINTF_TGT(string),
                "\"CLICCFGLBITS\": this Uns32 parameter indicates the maximum "
                "number of bits that can be specified as implemented in "
                "cliccfg.nlbits. The default value in this variant is %u. See "
                "also parameter \"nlbits_valid\" which allows fine-grain "
                "specification of legal values in cliccfg.nlbits.",
                riscv->configInfo.CLICCFGLBITS
            );
            vmidocAddText(Parameters, string);

            // document nlbits_valid_0_8
            snprintf(
                SNPRINTF_TGT(string),
                "\"nlbits_valid\": this Uns32 parameter is a bitmask of legal "
                "values that can be specified as implemented in the WARL "
                "cliccfg.nlbits field. As an example, a value of 8 in "
                "cliccfg.nlbits is legal only if bit 8 is set in nlbits_valid. "
                "The default value of \"nlbits_valid\" in this variant is "
                "0x%x.",
                riscv->configInfo.nlbits_valid
            );
            vmidocAddText(Parameters, string);

            // document CLICSELHVEC
            snprintf(
                SNPRINTF_TGT(string),
                "\"CLICSELHVEC\": this Boolean parameter indicates whether "
                "Selective Hardware Vectoring is supported (if True) or "
                "unsupported (if False). The default value in this variant is "
                "%s.",
                riscv->configInfo.CLICSELHVEC ? "True" : "False"
            );
            vmidocAddText(Parameters, string);

            // document posedge_0_63
            snprintf(
                SNPRINTF_TGT(string),
                "\"posedge_0_63\": this Uns64 parameter is a mask for "
                "interrupts 0 to 63 indicating whether an interrupt is fixed "
                "positive edge triggered. If the corresponding mask bit for "
                "interrupt N is 1 then the trig value for that interrupt is "
                "hard wired to 1. If the mask bit is zero, then the interrupt "
                "is either fixed level triggered (see below) or may be "
                "configured as either edge or level triggered. The default "
                "value in this variant is 0x"FMT_Ax".",
                riscv->configInfo.posedge_0_63
            );
            vmidocAddText(Parameters, string);

            // document poslevel_0_63
            snprintf(
                SNPRINTF_TGT(string),
                "\"poslevel_0_63\": this Uns64 parameter is a mask for "
                "interrupts 0 to 63 indicating whether an interrupt is fixed "
                "positive level triggered. If the corresponding mask bit for "
                "interrupt N is 1 then the trig value for that interrupt is "
                "hard wired to 0. If the mask bit is zero, then the interrupt "
                "may be configured as either edge or level triggered. The "
                "default value in this variant is 0x"FMT_Ax".",
                riscv->configInfo.poslevel_0_63
            );
            vmidocAddText(Parameters, string);

            // document posedge_other
            snprintf(
                SNPRINTF_TGT(string),
                "\"posedge_other\": this Boolean parameter indicates whether "
                "interrupts 64 and above are fixed positive edge triggered. If "
                "True then the trig value for those interrupts is hard wired "
                "to 1. If False, then those interrupts are either fixed level "
                "triggered (see below) or may be configured as either edge or "
                "level triggered. The default value in this variant is %s.",
                riscv->configInfo.posedge_other ? "True" : "False"
            );
            vmidocAddText(Parameters, string);

            // document poslevel_other
            snprintf(
                SNPRINTF_TGT(string),
                "\"poslevel_other\": this Boolean parameter indicates whether "
                "interrupts 64 and above are fixed positive level triggered. "
                "If True then the trig value for those interrupts is hard "
                "wired to 0. If False, then those interrupts may be configured "
                "as either edge or level triggered. The default value in this "
                "variant is %s.",
                riscv->configInfo.poslevel_other ? "True" : "False"
            );
            vmidocAddText(Parameters, string);
        }

        ////////////////////////////////////////////////////////////////////////
        // CLIC EXTERNAL-IMPLEMENTATION NET PORT INTERFACE
        /////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP External = vmidocAddSection(
                CLIC, "CLIC External-Implementation Net Port Interface"
            );

            vmidocAddText(
                External,
                "When the CLIC is externally implemented, net ports are "
                "present allowing the external CLIC model to supply the "
                "highest-priority pending interrupt and to be notified when "
                "interrupts are handled. These are:"
            );
            vmidocAddText(
                External,
                "\"irq_id_i\": this input should be written with the id of the "
                "highest-priority pending interrupt."
            );
            vmidocAddText(
                External,
                "\"irq_lev_i\": this input should be written with the "
                "highest-priority interrupt level."
            );
            vmidocAddText(
                External,
                "\"irq_sec_i\": this 2-bit input should be written with the "
                "highest-priority interrupt security state (00:User, "
                "01:Supervisor, 11:Machine)."
            );
            vmidocAddText(
                External,
                "\"irq_shv_i\": this input port should be written to indicate "
                "whether the highest-priority interrupt should be direct (0) "
                "or vectored (1). If the \"tvt_undefined parameter\" is False, "
                "vectored interrupts will use selective hardware vectoring, "
                "as described in the CLIC specification. If \"tvt_undefined\" "
                "is True, vectored interrupts will behave like basic mode "
                "vectored interrupts."
            );
            vmidocAddText(
                External,
                "\"irq_i\": this input should be written with 1 to indicate "
                "that the external CLIC is presenting an interrupt, or 0 if "
                "no interrupt is being presented."
            );
            vmidocAddText(
                External,
                "\"irq_ack_o\": this output is written by the model on entry "
                "to the interrupt handler (i.e. when the interrupt is taken). "
                "It will be written as an instantaneous pulse (i.e. written to "
                "1, then immediately 0)."
            );
            vmidocAddText(
                External,
                "\"irq_id_o\": this output is written by the model with the id "
                "of the interrupt currently being handled. It is valid during "
                "the instantaneous irq_ack_o pulse."
            );
            vmidocAddText(
                External,
                "\"sec_lvl_o\": this output signal indicates the current "
                "secure status of the processor, as a 2-bit value (00=User, "
                "01:Supervisor, 11=Machine)."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CLIC VERSIONS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Versions = vmidocAddSection(
                CLIC, "CLIC Versions"
            );

            vmidocAddText(
                Versions,
                "The CLIC specification has been under active development. "
                "To enable simulation of hardware that may be based on an "
                "older version of the specification, the model implements "
                "behavior for a number of previous versions of the "
                "specification. The differing features of these are listed "
                "below, in chronological order."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CLIC VERSION 20180831
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                CLIC, "Version 20180831"
            );

            vmidocAddText(
                Version,
                "Legacy version of August 31 2018, required for SiFive cores."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CLIC VERSION 0.9-draft-20191208
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                CLIC, "Version 0.9-draft-20191208"
            );

            vmidocAddText(
                Version,
                "Stable 0.9 version of December 8 2019."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CLIC VERSION 0.9-draft-20220315
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                CLIC, "Version 0.9-draft-20220315"
            );

            vmidocAddText(
                Version,
                "Stable 0.9 version of March 15 2022, with these changes "
                "compared to version 0.9-draft-20191208:"
            );
            vmidocAddText(
                Version,
                "- level-sensitive interrupts may no longer be set pending "
                "by software;"
            );
            vmidocAddText(
                Version,
                "- if there is an access exception on table load when "
                "Selective Hardware Vectoring is enabled, both xtval and xepc "
                "hold the faulting address;"
            );
            vmidocAddText(
                Version,
                "- if the xinhv bit is set, the target address for an xret "
                "instruction is obtained by a load from address xepc."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CLIC VERSION master
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                CLIC, "Version master"
            );

            vmidocAddText(
                Version,
                "Unstable master version as of "RVCLC_MASTER_DATE" (commit "
                RVCLC_MASTER_TAG"), with these changes compared to version "
                "0.9-draft-20220315:"
            );
            vmidocAddText(
                Version,
                "- vector table reads now require execute permission (not read "
                "permission);"
            );
            vmidocAddText(
                Version,
                "- CSIP now has id 16 and is treated as the first local "
                "interrupt (previously, it had id 12 and was not considered "
                "to be a local interrupt);"
            );
            vmidocAddText(
                Version,
                "- algorithm used for xscratchcsw accesses changed;"
            );
            vmidocAddText(
                Version,
                "- new parameter INTTHRESHBITS allows implemented bits in "
                "xintthresh CSRs to be restricted."
            );
        }
    }
}

//
// Document CLINT if required
//
static void docCLINT(riscvP riscv, vmiDocNodeP Root) {

    riscvConfigCP cfg = &riscv->configInfo;
    char string[1024];

    if(riscv->parent) {

        // document at root level only

    } else if(cfg->CLINT_address) {

        vmiDocNodeP CLINT = vmidocAddSection(
            Root, "CLINT"
        );

        snprintf(
            SNPRINTF_TGT(string),
            "This model implements a SiFive-compatible Core Local Interruptor "
            "(CLINT) block at address 0x"FMT_Ax". Use parameter "
            "\"CLINT_address\" to specify a different address for this block, "
            "or set it to zero to disable the CLINT",
            cfg->CLINT_address
        );
        vmidocAddText(CLINT, string);

        snprintf(
            SNPRINTF_TGT(string),
            "The tick timer in the CLINT (mtime) will increment at %gHz. Use "
            "parameter \"mtime_Hz\" to specify a different timer frequency.",
            cfg->mtime_Hz
        );
        vmidocAddText(CLINT, string);
    }
}

//
// Document a Boolean parameter
//
static vmiDocNodeP docBoolParam(
    vmiDocNodeP  node,
    const char  *name,
    Bool         param,
    const char **meanings
) {
    vmiDocNodeP sub = vmidocAddSection(node, name);
    char        string[1024];

    snprintf(
        SNPRINTF_TGT(string),
        "Parameter \"%s\" is %u on this variant, meaning that "
        "%s. if \"%s\" is set to %u then %s.",
        name, param, meanings[param], name, !param, meanings[!param]
    );

    vmidocAddText(sub, string);

    return sub;
}

//
// Document a Boolean parameter making a CSR undefined
//
static void docUndefinedCSRParam(
    vmiDocNodeP node,
    const char *CSR,
    const char *param,
    Bool        undefined
) {
    char string[1024];

    // add title
    snprintf(SNPRINTF_TGT(string), "%s CSR", CSR);
    vmiDocNodeP sub = vmidocAddSection(node, string);

    if(undefined) {

        snprintf(
            SNPRINTF_TGT(string),
            "The \"%s\" CSR is not implemented in this variant and accesses "
            "will cause Illegal Instruction traps. Set parameter \"%s\" to "
            "False to instead specify that \"%s\" is implemented.",
            CSR, param, CSR
        );

     } else {

         snprintf(
             SNPRINTF_TGT(string),
             "The \"%s\" CSR is implemented in this variant. Set parameter "
             "\"%s\" to True to instead specify that \"%s\" is "
             "unimplemented and accesses should cause Illegal Instruction "
             "traps.",
             CSR, param, CSR
         );
    }

    vmidocAddText(sub, string);
}

//
// Document a Boolean parameter making a set of CSRs undefined
//
static void docUndefinedCSRsParam(
    vmiDocNodeP node,
    const char *CSRs,
    const char *param,
    Bool        undefined
) {
    char string[1024];

    // add title
    snprintf(SNPRINTF_TGT(string), "%s CSR", CSRs);
    vmiDocNodeP sub = vmidocAddSection(node, string);

    if(undefined) {

        snprintf(
            SNPRINTF_TGT(string),
            "The \"%s\" CSRs are not implemented in this variant and accesses "
            "will cause Illegal Instruction traps. Set parameter \"%s\" to "
            "False to instead specify that \"%s\" CSRs are implemented.",
            CSRs, param, CSRs
        );

     } else {

         snprintf(
             SNPRINTF_TGT(string),
             "The \"%s\" CSRs are implemented in this variant. Set parameter "
             "\"%s\" to True to instead specify that \"%s\" CSRs are "
             "unimplemented and accesses should cause Illegal Instruction "
             "traps.",
             CSRs, param, CSRs
         );
    }

    vmidocAddText(sub, string);
}

//
// Does configuration indicate that 64-bit S-mode is present?
//
inline static Bool cfgHas64S(riscvConfigCP cfg) {
    return (cfg->arch&ISA_S) && (cfg->arch&ISA_XLEN_64);
}

//
// Create processor documentation
//
static vmiDocNodeP docSMP(riscvP rootProcessor) {

    vmiDocNodeP   Root     = vmidocAddSection(0, "Root");
    riscvP        riscv    = rootProcessor;
    riscvP        child    = getChild(rootProcessor);
    riscvConfigCP cfg      = &riscv->configInfo;
    Bool          isSMP    = child;
    Uns32         numHarts = cfg->numHarts;
    char          string[1024];

    // move to first child if an SMP object
    if(isSMP) {
        riscv = child;
        cfg   = &riscv->configInfo;
    }

    ////////////////////////////////////////////////////////////////////////////
    // DESCRIPTION
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP Description = vmidocAddSection(Root, "Description");

        snprintf(
            SNPRINTF_TGT(string),
            "RISC-V %s %u-bit processor model",
            riscv->configInfo.name,
            riscvGetXlenArch(riscv)
        );
        vmidocAddText(Description, string);
    }

    ////////////////////////////////////////////////////////////////////////////
    // LICENSING
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP Licensing = vmidocAddSection(Root, "Licensing");

        vmidocAddText(
            Licensing,
            "This Model is released under the Open Source Apache 2.0"
        );
    }

    ////////////////////////////////////////////////////////////////////////////
    // EXTENSIONS
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP       Extensions   = vmidocAddSection(Root, "Extensions");
        riscvArchitecture arch         = cfg->arch;
        riscvArchitecture archImplicit = cfg->archImplicit;
        riscvArchitecture archExplicit = arch & ~archImplicit;
        riscvArchitecture canEnable    = getCanEnable(cfg);
        riscvArchitecture canDisable   = getCanDisable(cfg);

        vmiDocNodeP EnabledExt = vmidocAddSection(
            Extensions, "Extensions Enabled by Default"
        );

        vmidocAddText(
            EnabledExt,
            "The model has the following architectural extensions enabled, "
            "and the corresponding bits in the misa CSR Extensions field will "
            "be set upon reset:"
        );

        // list explicitly-enabled extensions
        listFeatures(EnabledExt, archExplicit, SNPRINTF_TGT(string));

        if(archImplicit) {

            vmidocAddText(
                EnabledExt,
                "In addition, the model has the following architectural "
                "extensions implicitly enabled (not shown in the misa CSR "
                "Extensions field):"
            );

            // list implicitly-enabled extensions
            listFeatures(EnabledExt, archImplicit, SNPRINTF_TGT(string));
        }

        vmidocAddText(
            EnabledExt,
            "To specify features that can be dynamically enabled or disabled "
            "by writes to the misa register in addition to those listed above, "
            "use parameter \"add_Extensions_mask\". This is a string parameter "
            "containing the feature letters to add; for example, value \"DV\" "
            "indicates that double-precision floating point and the Vector "
            "Extension can be enabled or disabled by writes to the misa "
            "register, if supported on this variant. Parameter "
            "\"sub_Extensions_mask\" can be used to disable dynamic update of "
            "features in the same way."
        );

        vmidocAddText(
            EnabledExt,
            "Legacy parameter \"misa_Extensions_mask\" can also be used. This "
            "Uns32-valued parameter specifies all writable bits in the misa "
            "Extensions field, replacing any permitted bits defined "
            "in the base variant."
        );

        vmidocAddText(
            EnabledExt,
            "Note that any features that are indicated as present in the misa "
            "mask but absent in the misa will be ignored. See the next section."
        );

        ////////////////////////////////////////////////////////////////////////////
        // AVAILABLE EXTENSIONS
        ////////////////////////////////////////////////////////////////////////////

        if(canEnable) {

            vmiDocNodeP ExtSubset = vmidocAddSection(
                Extensions, "Enabling Other Extensions"
            );

            vmidocAddText(
                ExtSubset,
                "The following extensions are supported by the model, but not "
                "enabled by default in this variant:"
            );

            // report the extensions that are supported but not enabled
            listFeatures(ExtSubset, canEnable, SNPRINTF_TGT(string));

            vmidocAddText(
                ExtSubset,
                "To add features from this list to the visible set in the misa "
                "register, use parameter \"add_Extensions\". This is a string "
                "containing identification letters of features to enable; for "
                "example, value \"DV\" indicates that double-precision "
                "floating point and the Vector Extension should be enabled, if "
                "they are currently absent and are available on this variant."
            );

            vmidocAddText(
                ExtSubset,
                "Legacy parameter \"misa_Extensions\" can also be used. This "
                "Uns32-valued parameter specifies the reset value for the misa "
                "CSR Extensions field, replacing any permitted bits defined "
                "in the base variant."
            );

            vmidocAddText(
                ExtSubset,
                "To add features from this list to the implicitly-enabled set "
                "(not visible in the misa register), use parameter "
                "\"add_implicit_Extensions\". This is a string parameter in "
                "the same format as the \"add_Extensions\" parameter described "
                "above."
            );
        }

        ////////////////////////////////////////////////////////////////////////////
        // ENABLED EXTENSIONS THAT CAN BE DISABLED
        ////////////////////////////////////////////////////////////////////////////

        if(canDisable) {

            vmiDocNodeP ExtSubset = vmidocAddSection(
                Extensions, "Disabling Extensions"
            );

            vmidocAddText(
                ExtSubset,
                "The following extensions are enabled by default in the model "
                "and can be disabled:"
            );

            // report the extensions that are enabled and can be disabled
            listFeatures(ExtSubset, canDisable, SNPRINTF_TGT(string));

            vmidocAddText(
                ExtSubset,
                "To disable features that are enabled by default, use "
                "parameter \"sub_Extensions\". This is a string containing "
                "identification letters of features to disable; for example, "
                "value \"DF\" indicates that double-precision and "
                "single-precision floating point extensions should be "
                "disabled, if they are enabled by default on this variant."
            );

            vmidocAddText(
                ExtSubset,
                "To remove features from this list from the implicitly-enabled "
                "set (not visible in the misa register), use parameter "
                "\"sub_implicit_Extensions\". This is a string parameter in "
                "the same format as the \"sub_Extensions\" parameter described "
                "above."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // FEATURES
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP Features = vmidocAddSection(Root, "General Features");

        // document multicore behavior
        if(isSMP) {

            vmiDocNodeP sub = vmidocAddSection(Features, "Multicore Features");
            snprintf(
                SNPRINTF_TGT(string),
                "This is a multicore variant with %u harts by default. The "
                "number of harts may be overridden with the \"numHarts\" "
                "parameter.",
                numHarts
            );
            vmidocAddText(sub, string);
        }

        // document mtvec CSR behavior
        {
            vmiDocNodeP sub = vmidocAddSection(Features, "mtvec CSR");

            // document mtvec_is_ro behavior
            if(cfg->mtvec_is_ro) {

                // mtvec is read-only
                vmidocAddText(
                    sub,
                    "On this variant, the Machine trap-vector base-address "
                    "register (mtvec) is read-only. It can instead be "
                    "configured as writable using parameter \"mtvec_is_ro\"."
                );

            } else {

                // mtvec is read/write
                vmidocAddText(
                    sub,
                    "On this variant, the Machine trap-vector base-address "
                    "register (mtvec) is writable. It can instead be "
                    "configured as read-only using parameter \"mtvec_is_ro\"."
                );

                // document mtvec_mask and mtvec_sext behavior
                Uns64 tvec_mask = RD_CSR_MASK_M(riscv, mtvec);
                addDocXTVec(cfg, sub, tvec_mask, "mtvec", "mtvec_mask");
                addDocSExt(sub, cfg->mtvec_sext, "mtvec", "mtvec_sext");
            }

            // document mtvec initial value
            snprintf(
                SNPRINTF_TGT(string),
                "The initial value of \"mtvec\" is 0x"FMT_Ax". A different "
                "value may be specified using parameter \"mtvec\" if required.",
                RD_CSR_M(riscv, mtvec)
            );
            vmidocAddText(sub, string);
        }

        // document stvec CSR behavior
        if(cfg->arch&ISA_S) {

            vmiDocNodeP sub       = vmidocAddSection(Features, "stvec CSR");
            Uns64       tvec_mask = RD_CSR_MASK_S(riscv, stvec);

            addDocXTVec(cfg, sub, tvec_mask, "stvec", "stvec_mask");
            addDocSExt(sub, cfg->stvec_sext, "stvec", "stvec_sext");
        }

        // document utvec_mask and utvec_sext behavior
        if(cfg->arch&ISA_N) {

            vmiDocNodeP sub       = vmidocAddSection(Features, "utvec CSR");
            Uns64       tvec_mask = RD_CSR_MASK_U(riscv, utvec);

            addDocXTVec(cfg, sub, tvec_mask, "utvec", "utvec_mask");
            addDocSExt(sub, cfg->utvec_sext, "utvec", "utvec_sext");
        }

        // document reset behavior
        {
            vmiDocNodeP sub = vmidocAddSection(Features, "Reset");

            snprintf(
                SNPRINTF_TGT(string),
                "On reset, the model will restart at address 0x"FMT_Ax". A "
                "different reset address may be specified using parameter "
                "\"reset_address\" or applied using optional input port "
                "\"reset_addr\" if required.",
                cfg->reset_address
            );
            vmidocAddText(sub, string);
        }

        // document NMI behavior
        {
            vmiDocNodeP sub = vmidocAddSection(Features, "NMI");

            snprintf(
                SNPRINTF_TGT(string),
                "On an NMI, the model will restart at address 0x"FMT_Ax"; a "
                "different NMI address may be specified using parameter "
                "\"nmi_address\" or applied using optional input port "
                "\"nmi_addr\" if required. The cause reported on an NMI is "
                "0x"FMT_Ax" by default; a different cause may be specified "
                "using parameter \"ecode_nmi\" or applied using optional input "
                "port \"nmi_cause\" if required.",
                cfg->nmi_address, cfg->ecode_nmi
            );
            vmidocAddText(sub, string);

            snprintf(
                SNPRINTF_TGT(string),
                "If parameter \"rnmi_version\" is not \"none\", resumable "
                "NMIs are supported, managed by additional CSRs \"mnscratch\", "
                "\"mnepc\", \"mncause\" and \"mnstatus\", following the "
                "indicated version of the Resumable NMI extension proposal. In "
                "this variant, \"rnmi_version\" is \"%s\".",
                riscvGetRNMIVersionName(riscv)
            );
            vmidocAddText(sub, string);

            if(cfg->nmi_is_latched) {
                vmidocAddText(
                    sub,
                    "The NMI input is latched on the rising edge of the NMI "
                    "signal. To instead specify that NMI input is level-"
                    "sensitive, set parameter \"nmi_is_latched\" to False."
                );
            } else {
                vmidocAddText(
                    sub,
                    "The NMI input is level-sensitive. To instead specify that "
                    "the NMI input is latched on the rising edge of the NMI "
                    "signal, set parameter \"nmi_is_latched\" to True."
                );
            }
        }

        // document WFI behavior
        {
            vmiDocNodeP sub = vmidocAddSection(Features, "WFI");

            if(cfg->wfi_is_nop) {
                vmidocAddText(
                    sub,
                    "WFI is implemented as a NOP. It can instead be configured "
                    "to halt the processor until an interrupt occurs using "
                    "parameter \"wfi_is_nop\". WFI timeout wait is implemented "
                    "with a time limit of 0 (i.e. WFI causes an Illegal "
                    "Instruction trap in Supervisor mode when mstatus.TW=1)."
                );
            } else {
                vmidocAddText(
                    sub,
                    "WFI will halt the processor until an interrupt occurs. It "
                    "can instead be configured as a NOP using parameter "
                    "\"wfi_is_nop\". WFI timeout wait is implemented with a "
                    "time limit of 0 (i.e. WFI causes an Illegal Instruction "
                    "trap in Supervisor mode when mstatus.TW=1)."
                );
            }
        }

        // document undefined U-mode CSRs
        if(cfg->arch&ISA_U) {

            // document undefined cycle CSR
            docUndefinedCSRParam(
                Features,
                "cycle",
                "cycle_undefined",
                cfg->cycle_undefined
            );

            // document undefined instret CSR
            docUndefinedCSRParam(
                Features,
                "instret",
                "instret_undefined",
                cfg->instret_undefined
            );

            // document undefined hpmcounter CSRs
            docUndefinedCSRsParam(
                Features,
                "hpmcounter",
                "hpmcounter_undefined",
                cfg->hpmcounter_undefined
            );
        }

        // document whether time CSR is implemented
        {
            vmiDocNodeP sub = vmidocAddSection(Features, "time CSR");

            if(cfg->time_undefined) {
                vmidocAddText(
                    sub,
                    "The \"time\" CSR is not implemented in this variant and "
                    "reads of it will cause Illegal Instruction traps. Set "
                    "parameter \"time_undefined\" to False to instead specify "
                    "that \"time\" is implemented."
                );
            } else {
                vmidocAddText(
                    sub,
                    "The \"time\" CSR is implemented in this variant. Set "
                    "parameter \"time_undefined\" to True to instead specify "
                    "that \"time\" is unimplemented and reads of it should "
                    "cause Illegal Instruction traps. Usually, the value of "
                    "the \"time\" CSR should be provided by the platform - see "
                    "notes below about the artifact \"CSR\" bus for "
                    "information about how this is done."
                );
            }
        }

        // document undefined M-mode CSRs
        {
            // document undefined mcycle CSR
            docUndefinedCSRParam(
                Features,
                "mcycle",
                "mcycle_undefined",
                cfg->mcycle_undefined
            );

            // document undefined minstret CSR
            docUndefinedCSRParam(
                Features,
                "minstret",
                "minstret_undefined",
                cfg->minstret_undefined
            );

            // document undefined mhpmcounter CSRs
            docUndefinedCSRsParam(
                Features,
                "mhpmcounter",
                "mhpmcounter_undefined",
                cfg->mhpmcounter_undefined
            );
        }

        // document address translation
        if(cfg->arch&ISA_S) {

            vmiDocNodeP sub = vmidocAddSection(Features, "Virtual Memory");
            char        svModes[256];

            fillSvModes(svModes, cfg->Sv_modes);
            snprintf(
                SNPRINTF_TGT(string),
                "This variant supports address translation %s. Use parameter "
                "\"Sv_modes\" to specify a bit mask of different implemented "
                "modes if required; for example, setting \"Sv_modes\" to "
                "(1<<0)+(1<<8) indicates that mode 0 (%s) and mode 8 (%s) are "
                "implemented. These indices correspond to writable values in "
                "the satp.MODE CSR field.",
                svModes, getSvMode(0), getSvMode(8)
            );
            vmidocAddText(sub, string);

            snprintf(
                SNPRINTF_TGT(string),
                "A %u-bit ASID is implemented. Use parameter \"ASID_bits\" to "
                "specify a different implemented ASID size if required.",
                cfg->ASID_bits
            );
            vmidocAddText(sub, string);

            snprintf(
                SNPRINTF_TGT(string),
                "TLB behavior is controlled by parameter \"ASIDCacheSize\". If "
                "this parameter is 0, then an unlimited number of TLB entries "
                "will be maintained concurrently. If this parameter is "
                "non-zero, then only TLB entries for up to \"ASIDCacheSize\" "
                "different ASIDs will be maintained concurrently initially; as "
                "new ASIDs are used, TLB entries for less-recently used ASIDs "
                "are deleted, which improves model performance in some cases. "
                "If the model detects that the TLB entry cache is too small "
                "(entry ejections are very frequent), it will increase the "
                "cache size automatically. In this variant, \"ASIDCacheSize\" "
                "is %u.",
                cfg->ASID_cache_size
            );
            vmidocAddText(sub, string);
        }

        // document unaligned access behavior
        {
            vmiDocNodeP sub = vmidocAddSection(Features, "Unaligned Accesses");

            if(cfg->unaligned) {
                vmidocAddText(
                    sub,
                    "Unaligned memory accesses are supported by this variant. "
                    "Set parameter \"unaligned\" to \"F\" to disable such "
                    "accesses."
                );
            } else {
                vmidocAddText(
                    sub,
                    "Unaligned memory accesses are not supported by this "
                    "variant. Set parameter \"unaligned\" to \"T\" to enable "
                    "such accesses."
                );
            }

            // document unaligned access behavior for AMO instructions
            if(!(cfg->arch&ISA_A)) {
                // no action
            } else if(cfg->unalignedAMO) {
                vmidocAddText(
                    sub,
                    "Unaligned memory accesses are supported for AMO "
                    "instructions by this variant. Set parameter "
                    "\"unalignedAMO\" to \"F\" to disable such accesses."
                );
            } else {
                vmidocAddText(
                    sub,
                    "Unaligned memory accesses are not supported for AMO "
                    "instructions by this variant. Set parameter "
                    "\"unalignedAMO\" to \"T\" to enable such accesses."
                );
            }

            // document misaligned exception priority
            snprintf(
                SNPRINTF_TGT(string),
                "Address misaligned exceptions are %s priority than "
                "page fault or access fault exceptions on this variant. "
                "Set parameter \"unaligned_low_pri\" to \"%s\" to specify "
                "that they are %s priority instead.",
                cfg->unaligned_low_pri ? "lower" : "higher",
                cfg->unaligned_low_pri ? "F" : "T",
                cfg->unaligned_low_pri ? "higher" : "lower"
            );
            vmidocAddText(sub, string);
        }

        vmiDocNodeP pmp = vmidocAddSection(Features, "PMP");

        // document PMP regions
        if(cfg->PMP_registers) {

            Uns64 grainBytes = 4ULL<<cfg->PMP_grain;

            snprintf(
                SNPRINTF_TGT(string),
                "%u PMP entries are implemented by this variant. Use parameter "
                "\"PMP_registers\" to specify a different number of PMP "
                "entries; set the parameter to 0 to disable the PMP unit. "
                "The PMP grain size (G) is %u, meaning that PMP regions as "
                "small as "FMT_Au" bytes are implemented. Use parameter "
                "\"PMP_grain\" to specify a different grain size if required. "
                "Unaligned PMP accesses are %sdecomposed into separate aligned "
                "accesses; use parameter \"PMP_decompose\" to modify this "
                "behavior if required. Parameters to change the write masks for "
                "the PMP CSRs are %senabled; use parameter \"PMP_maskparams\" "
                "to modify this behavior if required. Parameters to change the reset values "
                "for the PMP CSRs are %senabled; use parameter \"PMP_initialparams\" "
                "to modify this behavior if required",
                cfg->PMP_registers,
                cfg->PMP_grain,
                grainBytes,
                cfg->PMP_decompose     ? "" : "not ",
                cfg->PMP_maskparams    ? "" : "not ",
                cfg->PMP_initialparams ? "" : "not "
            );

            vmidocAddText(pmp, string);

            if(cfg->Smepmp_version) {
                vmidocAddText(
                    pmp,
                    "This variant implements the Smepmp extension with version "
                    "specified in the References section of this document. "
                    "Note that parameter \"Smepmp_version\" can be used to "
                    "select the required version if required."
                );
            }

        } else {

            vmidocAddText(
                pmp,
                "A PMP unit is not implemented by this variant. Set parameter "
                "\"PMP_registers\" to indicate that the unit should be "
                "implemented with that number of PMP entries."
            );
        }

        if(cfg->PMP_undefined) {
            vmidocAddText(
                pmp,
                "Accesses to unimplemented PMP registers cause Illegal "
                "Instruction exceptions on this variant. Set parameter "
                "\"PMP_undefined\" to False to indicate that these registers "
                "are hard-wired to zero instead."
            );
        } else {
            vmidocAddText(
                pmp,
                "Accesses to unimplemented PMP registers are write-ignored "
                "and read as zero on this variant. Set parameter "
                "\"PMP_undefined\" to True to indicate that such accesses "
                "should cause Illegal Instruction exceptions instead."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // COMPRESSED EXTENSION
    ////////////////////////////////////////////////////////////////////////////

    // floating point configuration
    if(cfg->arch&ISA_C) {

        vmiDocNodeP      extC    = vmidocAddSection(Root, "Compressed Extension");
        riscvCompressVer version = RISCV_COMPRESS_VERSION(riscv);

        if(version) {

            vmidocAddText(
                extC,
                "This variant implements the compressed extension with version "
                "specified in the References section of this document. Note "
                "that parameter \"compress_version\" can be used to select the "
                "required architecture version. See the following sections "
                "for detailed information about differences between each "
                "supported version."
            );

        } else {

            vmidocAddText(
                extC,
                "Standard compressed instructions are present in this variant. "
                "Legacy compressed extension features may also be configured "
                "using parameters described below. Use parameter "
                "\"compress_version\" to enable more recent compressed "
                "extension features if required. See the following sections "
                "for detailed information about differences between each "
                "supported version."
            );
        }

        {
            vmiDocNodeP Parameters = vmidocAddSection(
                extC, "Compressed Extension Parameters"
            );

            if(version) {

                addCFeature(
                    cfg, Parameters, SNPRINTF_TGT(string), RVCS_Zca, "Zca",
                    "basic C extension"
                );
                addCFeature(
                    cfg, Parameters, SNPRINTF_TGT(string), RVCS_Zcf, "Zcf",
                    "floating point load/store"
                );
                addCFeature(
                    cfg, Parameters, SNPRINTF_TGT(string), RVCS_Zcb, "Zcb",
                    "additional simple operation"
                );

                // Zcmb is removed from version 1.0.0
                if(version<RVCV_1_0_0_RC57) {
                    addCFeature(
                        cfg, Parameters, SNPRINTF_TGT(string), RVCS_Zcmb, "Zcmb",
                        "load/store byte/half"
                    );
                }

                addCFeature(
                    cfg, Parameters, SNPRINTF_TGT(string), RVCS_Zcmp, "Zcmp",
                    "push/pop and double move"
                );

                // Zcmpe is removed from version 1.0.0
                if(version<RVCV_1_0_0_RC57) {
                    addCFeature(
                        cfg, Parameters, SNPRINTF_TGT(string), RVCS_Zcmpe, "Zcmpe",
                        "E-extension push/pop"
                    );
                }

                addCFeature(
                    cfg, Parameters, SNPRINTF_TGT(string), RVCS_Zcmt, "Zcmt",
                    "table jump"
                );

                // document jvt_mask
                snprintf(
                    SNPRINTF_TGT(string),
                    "Parameter \"jvt_mask\" is used to specify writable bits "
                    "in the jvt CSR. By default, \"jvt_mask\" is set to "
                    "0x"FMT_Ax" in this variant.",
                    cfg->csrMask.jvt.u64.bits
                );
                vmidocAddText(Parameters, string);

            } else {

                addLegacyCFeature(
                    cfg,
                    Parameters,
                    SNPRINTF_TGT(string),
                    "Zcea",
                    riscvGetZceaVersionName(riscv)
                );

                addLegacyCFeature(
                    cfg,
                    Parameters,
                    SNPRINTF_TGT(string),
                    "Zceb",
                    riscvGetZcebVersionName(riscv)
                );

                addLegacyCFeature(
                    cfg,
                    Parameters,
                    SNPRINTF_TGT(string),
                    "Zcee",
                    riscvGetZceeVersionName(riscv)
                );
            }
        }

        ////////////////////////////////////////////////////////////////////////
        // COMPRESSED EXTENSION VERSION legacy
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extC, "Legacy Version 1.10");

            vmidocAddText(
                Version,
                "Legacy encodings with version specified using Zcea, Zceb and "
                "Zcee parameters."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // COMPRESSED EXTENSION VERSION 0.70.1
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extC, "Version 0.70.1");

            vmidocAddText(
                Version,
                "All instruction encodings changed from legacy version, with "
                "instructions divided into Zca, Zcf, Zcb, Zcmb, Zcmp, Zcmpe "
                "and Zcmt subsets."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // COMPRESSED EXTENSION VERSION 0.70.5
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extC, "Version 0.70.5");

            vmidocAddText(
                Version,
                "Version 0.70.5, with these changes compared to version 0.70.1:"
            );
            vmidocAddText(
                Version,
                "- access to jt and jalt instructions is enabled by Smstateen."
            );
            vmidocAddText(
                Version,
                "- jvt.base is WARL and fewer bits than the maximum can be "
                "implemented"
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // COMPRESSED EXTENSION VERSION 1.0.0-RC5.7
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extC, "Version 1.0.0-RC5.7");

            vmidocAddText(
                Version,
                "Version 1.0.0-RC5.7, with these changes compared to version "
                "0.70.5:"
            );
            vmidocAddText(
                Version,
                "- encodings of jt and jalt instructions changed."
            );
            vmidocAddText(
                Version,
                "- Zcmb and Zcmpe subsets removed."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // FLOATING POINT
    ////////////////////////////////////////////////////////////////////////////

    // floating point configuration
    if(cfg->arch&ISA_DF) {

        vmiDocNodeP Features = vmidocAddSection(Root, "Floating Point Features");

        // document d_requires_f
        if((cfg->archMask&ISA_DF) != ISA_DF) {
            // no action
        } else if(cfg->d_requires_f) {
            vmidocAddText(
                Features,
                "The D extension is enabled in this variant only if the "
                "F extension is also enabled. Set parameter \"d_requires_f\""
                "to \"F\" to allow D and F to be independently enabled."
            );
        } else {
            vmidocAddText(
                Features,
                "The D extension is enabled in this variant independently "
                "of the F extension. Set parameter \"d_requires_f\""
                "to \"T\" to specify that the D extension requires the "
                "F extension to be enabled."
            );
        }

        // document 16-bit floating point support
        if(cfg->fp16_version) {
            snprintf(
                SNPRINTF_TGT(string),
                "16-bit floating point is implemented (%s format). Use "
                "parameter \"Zfh\" to disable this if required.",
                riscvGetFP16VersionDesc(riscv)
            );
            vmidocAddText(Features, string);
        } else {
            vmidocAddText(
                Features,
                "Half precision floating point is not implemented. Use "
                "parameter \"Zfh\" to enable this if required."
            );
        }

        if(cfg->Zfinx_version) {

            // document Zfinx
            snprintf(
                SNPRINTF_TGT(string),
                "%s is implemented, meaning that all floating point operations "
                "that would normally use the floating point register file use "
                "the integer register file instead.",
                riscvGetZfinxVersionDesc(riscv)
            );
            vmidocAddText(Features, string);

        } else {

            // document mstatus_FS
            vmidocAddText(
                Features,
                "By default, the processor starts with floating-point "
                "instructions disabled (mstatus.FS=0). Use parameter "
                "\"mstatus_FS\" to force mstatus.FS to a non-zero value "
                "for floating-point to be enabled from the start."
            );

            // document mstatus_fs_mode options
            vmidocAddText(
                Features,
                "The specification is imprecise regarding the conditions under "
                "which mstatus.FS is set to Dirty state (3). Parameter "
                "\"mstatus_fs_mode\" can be used to specify the required "
                "behavior in this model, as described below."
            );
            vmidocAddText(
                Features,
                "If \"mstatus_fs_mode\" is set to \"always_dirty\" then the "
                "model implements a simplified floating point status view in "
                "which mstatus.FS holds values 0 (Off) and 3 (Dirty) only; "
                "any write of values 1 (Initial) or 2 (Clean) from privileged "
                "code behave as if value 3 was written."
            );
            vmidocAddText(
                Features,
                "If \"mstatus_fs_mode\" is set to \"write_1\" then mstatus.FS "
                "will be set to 3 (Dirty) by any explicit write to the fflags, "
                "frm or fcsr control registers, or by any executed instruction "
                "that writes an FPR, or by any executed floating point "
                "compare or conversion to integer/unsigned that signals "
                "a floating point exception. Floating point compare or "
                "conversion to integer/unsigned instructions that do not "
                "signal an exception will not set mstatus.FS."
            );
            vmidocAddText(
                Features,
                "If \"mstatus_fs_mode\" is set to \"write_any\" then mstatus.FS "
                "will be set to 3 (Dirty) by any explicit write to the fflags, "
                "frm or fcsr control registers, or by any executed instruction "
                "that writes an FPR, or by any executed floating point "
                "compare or conversion even if those instructions do not "
                "signal a floating point exception."
            );

            // document mstatus_fs_mode default
            snprintf(
                SNPRINTF_TGT(string),
                "In this variant, \"mstatus_fs_mode\" is set to \"%s\".",
                riscvGetFSModeName(riscv)
            );
            vmidocAddText(Features, string);
        }

        // document Zfhmin
        if(riscv->configInfo.fp16_version && (cfg->arch&ISA_DF)) {

            Bool param = cfg->Zfhmin;

            static const char *meanings[] = {
                "all half-precision operations are supported",
                "a minimal set of half-precision operations are supported",
            };

            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"Zfhmin\" is %u on this variant, meaning that "
                "%s. if \"Zfhmin\" is set to %u then %s.",
                param, meanings[param], !param, meanings[!param]
            );
            vmidocAddText(Features, string);

            vmidocAddText(
                Features,
                "For Zhinx, specify both \"Zfh\" and \"Zfinx_version\"."
            );
            vmidocAddText(
                Features,
                "For Zhinxmin, specify both \"Zfhmin\" and \"Zfinx_version\"."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // PRIVILEGED ARCHITECTURE
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP priv = vmidocAddSection(Root, "Privileged Architecture");

        vmidocAddText(
            priv,
            "This variant implements the Privileged Architecture with version "
            "specified in the References section of this document. Note that "
            "parameter \"priv_version\" can be used to select the required "
            "architecture version; see the following sections for detailed "
            "information about differences between each supported version."
        );

        ////////////////////////////////////////////////////////////////////////
        // PRIVILEGED ARCHITECTURE VERSION 1.10
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(priv, "Legacy Version 1.10");

            vmidocAddText(
                Version,
                "1.10 version of May 7 2017."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // PRIVILEGED ARCHITECTURE VERSION 20190608
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(priv, "Version 20190608");

            vmidocAddText(
                Version,
                "Stable 1.11 version of June 8 2019, with these changes "
                "compared to version 1.10:"
            );
            vmidocAddText(
                Version,
                "- mcountinhibit CSR defined;"
            );
            vmidocAddText(
                Version,
                "- pages are never executable in Supervisor mode if page table "
                "entry U bit is 1;"
            );
            vmidocAddText(
                Version,
                "- mstatus.TW is writable if any lower-level privilege mode is "
                "implemented (previously, it was just if Supervisor mode was "
                "implemented);"
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // PRIVILEGED ARCHITECTURE VERSION 20211203
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(priv, "Version 20211203");

            vmidocAddText(
                Version,
                "1.12 draft version of December 3 2021, with these changes "
                "compared to version 20190608:"
            );
            vmidocAddText(
                Version,
                "- mstatush, mseccfg, mseccfgh, menvcfg, menvcfgh, senvcfg, "
                "henvcfg, henvcfgh and mconfigptr CSRs defined;"
            );
            vmidocAddText(
                Version,
                "- xret instructions clear mstatus.MPRV when leaving Machine "
                "mode if new mode is less privileged than M-mode;"
            );
            vmidocAddText(
                Version,
                "- maximum number of PMP registers increased to 64;"
            );
            vmidocAddText(
                Version,
                "- data endian is now configurable."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // PRIVILEGED ARCHITECTURE VERSION 1.12
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(priv, "Version 1.12");

            vmidocAddText(
                Version,
                "Official 1.12 version, identical to 20211203."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // PRIVILEGED ARCHITECTURE VERSION master
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(priv, "Version master");

            vmidocAddText(
                Version,
                "Unstable master version, currently identical to 1.12."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // UNPRIVILEGED ARCHITECTURE
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP isa = vmidocAddSection(Root, "Unprivileged Architecture");

        vmidocAddText(
            isa,
            "This variant implements the Unprivileged Architecture with "
            "version specified in the References section of this document. "
            "Note that parameter \"user_version\" can be used to select the "
            "required architecture version; see the following sections for "
            "detailed information about differences between each supported "
            "version."
        );

        ////////////////////////////////////////////////////////////////////////
        // UNPRIVILEGED ARCHITECTURE VERSION 2.2
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(isa, "Legacy Version 2.2");

            vmidocAddText(
                Version,
                "2.2 version of May 7 2017."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // UNPRIVILEGED ARCHITECTURE VERSION 20191213
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(isa, "Version 20191213");

            vmidocAddText(
                Version,
                "Stable 20191213-Base-Ratified version of December 13 2019, "
                "with these changes compared to version 2.2:"
            );
            vmidocAddText(
                Version,
                "- floating point fmin/fmax instruction behavior modified "
                "to comply with IEEE 754-201x."
            );
            vmidocAddText(
                Version,
                "- numerous other optional behaviors can be separately "
                "enabled using Z-prefixed parameters."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // BIT-MANIPULATION EXTENSION
    ////////////////////////////////////////////////////////////////////////////

    if(cfg->arch&ISA_B) {

        vmiDocNodeP extB = vmidocAddSection(Root, "Bit-Manipulation Extension");

        vmidocAddText(
            extB,
            "This variant implements the Bit-Manipulation extension with "
            "version specified in the References section of this document. "
            "Note that parameter \"bitmanip_version\" can be used to select "
            "the required version of this extension. See section "
            "\"Bit-Manipulation Extension Versions\" for detailed information "
            "about differences between each supported version."
        );

        vmiDocNodeP Parameters = vmidocAddSection(
            extB, "Bit-Manipulation Extension Parameters"
        );

        // add subset control parameter description
        addBFeature(
            cfg, Parameters, SNPRINTF_TGT(string), RVBS_Zbb, "Zbb",
            "the base"
        );
        addBFeature(
            cfg, Parameters, SNPRINTF_TGT(string), RVBS_Zba, "Zba",
            "address calculation"
        );
        addBFeature(
            cfg, Parameters, SNPRINTF_TGT(string), RVBS_Zbc, "Zbc",
            "carryless operation"
        );
        addBFeature(
            cfg, Parameters, SNPRINTF_TGT(string), RVBS_Zbe, "Zbe",
            "bit deposit/extract"
        );
        addBFeature(
            cfg, Parameters, SNPRINTF_TGT(string), RVBS_Zbf, "Zbf",
            "bit field place"
        );
        addBFeature(
            cfg, Parameters, SNPRINTF_TGT(string), RVBS_Zbm, "Zbm",
            "bit matrix operation"
        );
        addBFeature(
            cfg, Parameters, SNPRINTF_TGT(string), RVBS_Zbp, "Zbp",
            "permutation"
        );
        addBFeature(
            cfg, Parameters, SNPRINTF_TGT(string), RVBS_Zbr, "Zbr",
            "CRC32"
        );
        addBFeature(
            cfg, Parameters, SNPRINTF_TGT(string), RVBS_Zbs, "Zbs",
            "single bit"
        );
        addBFeature(
            cfg, Parameters, SNPRINTF_TGT(string), RVBS_Zbt, "Zbt",
            "ternary"
        );

        ////////////////////////////////////////////////////////////////////////
        // BIT-MANIPULATION EXTENSION VERSIONS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Versions = vmidocAddSection(
                extB, "Bit-Manipulation Extension Versions"
            );

            vmidocAddText(
                Versions,
                "The Bit-Manipulation Extension specification has been under "
                "active development. To enable simulation of hardware that may "
                "be based on an older version of the specification, the model "
                "implements behavior for a number of previous versions of the "
                "specification. The differing features of these are listed "
                "below, in chronological order."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // BIT-MANIPULATION EXTENSION VERSION 0.90
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extB, "Version 0.90");

            vmidocAddText(
                Version,
                "Stable 0.90 version of June 10 2019."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // BIT-MANIPULATION EXTENSION VERSION 0.91
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extB, "Version 0.91");

            vmidocAddText(
                Version,
                "Stable 0.91 version of August 29 2019, with these changes "
                "compared to version 0.90:"
            );
            vmidocAddText(
                Version,
                "- change encodings of bmatxor, grev, grevw, grevi and greviw;"
            );
            vmidocAddText(
                Version,
                "- add gorc, gorcw, gorci, gorciw, bfp and bfpw instructions."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // BIT-MANIPULATION EXTENSION VERSION 0.92
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extB, "Version 0.92");

            vmidocAddText(
                Version,
                "Stable 0.92 version of November 8 2019, with these changes "
                "compared to version 0.91:"
            );
            vmidocAddText(
                Version,
                "- add packh, packu and packuw instructions;"
            );
            vmidocAddText(
                Version,
                "- add sext.b and sext.h instructions;"
            );
            vmidocAddText(
                Version,
                "- change encoding and behavior of bfp and bfpw instructions;"
            );
            vmidocAddText(
                Version,
                "- change encoding of bdep and bdepw instructions."
            );
        }

         ////////////////////////////////////////////////////////////////////////
        // BIT-MANIPULATION EXTENSION VERSION 0.93-draft
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extB, "Version 0.93-draft");

            vmidocAddText(
                Version,
                "Draft 0.93 version of January 29 2020, with these changes "
                "compared to version 0.92:"
            );
            vmidocAddText(
                Version,
                "- add sh1add, sh2add, sh3add, sh1addu, sh2addu and sh3addu "
                "instructions;"
            );
            vmidocAddText(
                Version,
                "- move slo, sloi, sro and sroi to Zbp subset;"
            );
            vmidocAddText(
                Version,
                "- add orc16 to Zbb subset."
            );
         }
 
        ////////////////////////////////////////////////////////////////////////
        // BIT-MANIPULATION EXTENSION VERSION 0.93
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extB, "Version 0.93");

            vmidocAddText(
                Version,
                "Stable 0.93 version of January 10 2021, with these changes "
                "compared to version 0.93-draft:"
            );
            vmidocAddText(
                Version,
                "- assignments of instructions to Z extension groups changed;"
            );
            vmidocAddText(
                Version,
                "- exchange encodings of max and minu instructions;"
            );
            vmidocAddText(
                Version,
                "- add xperm.[nbhw] instructions;"
            );
            vmidocAddText(
                Version,
                "- instructions named *u.w renamed to *.uw;"
            );
            vmidocAddText(
                Version,
                "- instruction add.uw zero-extends argument rs1, not rs2;"
            );
            vmidocAddText(
                Version,
                "- instructions named sb* renamed to b*;"
            );
            vmidocAddText(
                Version,
                "- instructions named pcnt* renamed to cpop*;"
            );
            vmidocAddText(
                Version,
                "- instructions subu.w, addiwu, addwu, subwu, clmulw, clmulrw "
                "and clmulhw removed;"
            );
            vmidocAddText(
                Version,
                "- instructions slo, sro, sloi, sroi, slow, srow, sloiw and "
                "sroiw removed from all Z extension groups and are therefore "
                "never implemented;"
            );
            vmidocAddText(
                Version,
                "- instructions bext/bdep renamed to bcompress/bdecompress "
                "(this change is documented under the draft 0.94 version but "
                "is required to resolve an instruction name conflict "
                "introduced by instruction renames above);"
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // BIT-MANIPULATION EXTENSION VERSION 0.94
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extB, "Version 0.94");

            vmidocAddText(
                Version,
                "Stable 0.94 version of January 20 2021, with these changes "
                "compared to version 0.93:"
            );
            vmidocAddText(
                Version,
                "- instructions bset[i]w, bclr[i]w, binv[i]w and bextw removed."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // BIT-MANIPULATION EXTENSION VERSION 1.0.0
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extB, "Version 1.0.0");

            vmidocAddText(
                Version,
                "Stable 1.0.0 version of June 6 2021, with these changes "
                "compared to version 0.94:"
            );
            vmidocAddText(
                Version,
                "- instructions with immediate shift operands now follow base "
                "architecture semantics to determine operand legality instead "
                "of masking to XLEN-1;"
            );
            vmidocAddText(
                Version,
                "- only subsets Zba, Zbb, Zbc and Zbs may be enabled;"
            );
            vmidocAddText(
                Version,
                "- if the B extension is present, it is implicitly always "
                "enabled and not subject to control by misa.B, which is zero."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // BIT-MANIPULATION EXTENSION VERSION MASTER
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extB, "Version master");

            vmidocAddText(
                Version,
                "Unstable master version, with these changes compared to "
                "version 1.0.0:"
            );
            vmidocAddText(
                Version,
                "- any subset may be enabled;"
            );
            vmidocAddText(
                Version,
                "- xperm.n, xperm.b, xperm.h and xperm.w instructions "
                "renamed xperm4, xperm8, xperm16 and xperm32."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // HYPERVISOR EXTENSION
    ////////////////////////////////////////////////////////////////////////////

    if(cfg->arch&ISA_H) {

        vmiDocNodeP Hypervisor = vmidocAddSection(Root, "Hypervisor Extension");

        vmidocAddText(
            Hypervisor,
            "This variant implements the RISC-V hypervisor extension with "
            "version specified in the References section of this document."
        );

        ////////////////////////////////////////////////////////////////////////
        // HYPERVISOR EXTENSION PARAMETERS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Parameters = vmidocAddSection(
                Hypervisor, "Hypervisor Extension Parameters"
            );

            snprintf(
                SNPRINTF_TGT(string),
                "A %u-bit VS-mode ASID is implemented. Use parameter "
                "\"ASID_bits\" to specify a different implemented VS-mode ASID "
                "size if required. Note that this parameter also defines "
                "HS-mode ASID size.",
                cfg->ASID_bits
            );
            vmidocAddText(Parameters, string);

            snprintf(
                SNPRINTF_TGT(string),
                "A %u-bit VMID is implemented. Use parameter \"VMID_bits\" to "
                "specify a different implemented VMID size if required.",
                cfg->VMID_bits
            );
            vmidocAddText(Parameters, string);

            // document GEILEN
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"GEILEN\" is used to specify the number of guest "
                "external interrupts. By default, \"GEILEN\" is set to "
                "%u in this variant.",
                riscv->configInfo.GEILEN
            );
            vmidocAddText(Parameters, string);

            // document xtinst_basic
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"xtinst_basic\" is used to specify whether "
                "transformed instructions reported in mtinst/htinst are fully "
                "supported (if False) or whether only basic pseudo-instructions "
                "are reported (if True). If only basic instructions are "
                "reported, the writable bits in mtinst/htinst are restricted "
                "so that only bits 5 and 13 are writable (for RV32) or bits "
                "5, 12 and 13 are writable (for RV64). By default, "
                "\"xtinst_basic\" is set to %s in this variant.",
                riscv->configInfo.xtinst_basic ? "True" : "False"
            );
            vmidocAddText(Parameters, string);
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // CRYPTOGRAPHIC EXTENSION
    ////////////////////////////////////////////////////////////////////////////

    if(cfg->arch&ISA_K) {

        vmiDocNodeP extK = vmidocAddSection(Root, "Cryptographic Extension");

        vmidocAddText(
            extK,
            "This variant implements the RISC-V cryptographic extension with "
            "version specified in the References section of this document."
        );

        ////////////////////////////////////////////////////////////////////////
        // CRYPTOGRAPHIC EXTENSION PARAMETERS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Parameters = vmidocAddSection(
                extK, "Cryptographic Extension Parameters"
            );

            // document mnoise_undefined
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"mnoise_undefined\" is used to specify whether "
                "the \"mnoise\" CSR is undefined, in which case accesses to it "
                "trap to Machine mode. In this variant, \"mnoise_undefined\" "
                "is %u.",
                riscv->configInfo.mnoise_undefined
            );
            vmidocAddText(Parameters, string);

            // add subset control parameter description
            addKFeature(
                cfg, Parameters, SNPRINTF_TGT(string), RVKS_Zbkb, "Zbkb",
                "shared bit manipulation (not Zbkc or Zbkx)"
            );
            addKFeature(
                cfg, Parameters, SNPRINTF_TGT(string), RVKS_Zbkc, "Zbkc",
                "carry-less multiply"
            );
            addKFeature(
                cfg, Parameters, SNPRINTF_TGT(string), RVKS_Zbkx, "Zbkx",
                "crossbar permutation"
            );
            addKFeature(
                cfg, Parameters, SNPRINTF_TGT(string), RVKS_Zkr, "Zkr",
                "entropy source"
            );
            addKFeature(
                cfg, Parameters, SNPRINTF_TGT(string), RVKS_Zknd, "Zknd",
                "NIST AES decryption"
            );
            addKFeature(
                cfg, Parameters, SNPRINTF_TGT(string), RVKS_Zkne, "Zkne",
                "NIST AES encryption"
            );
            addKFeature(
                cfg, Parameters, SNPRINTF_TGT(string), RVKS_Zknh, "Zknh",
                "NIST SHA2 hash function"
            );
            addKFeature(
                cfg, Parameters, SNPRINTF_TGT(string), RVKS_Zksed, "Zksed",
                "SM4 encryption and decryption"
            );
            addKFeature(
                cfg, Parameters, SNPRINTF_TGT(string), RVKS_Zksh, "Zksh",
                "SM3 hash function"
            );

            vmiDocNodeP Deprecated = vmidocAddSection(
                extK, "Cryptographic Extension Deprecated Parameters"
            );

            addDeprecatedKFeature(
                cfg, Deprecated, SNPRINTF_TGT(string), RVKS_Zkb, "Zkb", "Zbkb",
                "shared bit manipulation"
            );
            addDeprecatedKFeature(
                cfg, Deprecated, SNPRINTF_TGT(string), RVKS_Zkg, "Zkg", "Zbkc",
                "carry-less multiply"
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CRYPTOGRAPHIC EXTENSION VERSIONS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Versions = vmidocAddSection(
                extK, "Cryptographic Extension Versions"
            );

            vmidocAddText(
                Versions,
                "The Cryptographic Extension specification has been under "
                "active development. To enable simulation of hardware that may "
                "be based on an older version of the specification, the model "
                "implements behavior for a number of previous versions of the "
                "specification. The differing features of these are listed "
                "below, in chronological order."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CRYPTOGRAPHIC EXTENSION VERSION 0.7.2
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extK, "Version 0.7.2");

            vmidocAddText(
                Version,
                "Stable 0.7.2 version of November 25 2020."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CRYPTOGRAPHIC EXTENSION VERSION 0.8.1
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extK, "Version 0.8.1");

            vmidocAddText(
                Version,
                "Stable 0.8.1 version of December 18 2020, with these changes "
                "compared to version 0.7.2:"
            );
            vmidocAddText(
                Version,
                "- encodings of SM4 instructions changed to source rd from the "
                "rs1 field."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CRYPTOGRAPHIC EXTENSION VERSION 0.9.0
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extK, "Version 0.9.0");

            vmidocAddText(
                Version,
                "Stable 0.9.0 version of March 4 2021, with these changes "
                "compared to version 0.8.1:"
            );
            vmidocAddText(
                Version,
                "- gorci instruction has been removed."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CRYPTOGRAPHIC EXTENSION VERSION 0.9.2
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extK, "Version 0.9.2");

            vmidocAddText(
                Version,
                "Stable 0.9.2 version of June 11 2021, with these changes "
                "compared to version 0.9.0:"
            );
            vmidocAddText(
                Version,
                "- aes32* and sm4* instruction encodings have been changed;"
            );
            vmidocAddText(
                Version,
                "- extensions Zbkx, Zbkc and Zbkb have been implemented;"
            );
            vmidocAddText(
                Version,
                "- packu[w] and rev8.w instructions have been removed from Zbkb;"
            );
            vmidocAddText(
                Version,
                "- mentropy CSR has been removed;"
            );
            vmidocAddText(
                Version,
                "- read-only sentropy CSR has been added at address 0xDBF;"
            );
            vmidocAddText(
                Version,
                "- mseccfg CSR has been added containing SKES field."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CRYPTOGRAPHIC EXTENSION VERSION 1.0.0-rc1
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extK, "Version 1.0.0-rc1");

            vmidocAddText(
                Version,
                "Stable 1.0.0-rc1 version of August 6 2021, with these changes "
                "compared to version 0.9.2:"
            );

            vmidocAddText(
                Version,
                "- aes32* opcodes have changed;"
            );
            vmidocAddText(
                Version,
                "- all scalar crypto specific instructions which produce "
                "32-bit results now sign-extend them to XLEN bits where "
                "relevant (previously they were zero extended);"
            );
            vmidocAddText(
                Version,
                "- encodings for ES16 and WAIT states have changed;"
            );
            vmidocAddText(
                Version,
                "- if the K extension is present, it is implicitly always "
                "enabled and not subject to control by misa.K, which is zero;"
            );
            vmidocAddText(
                Version,
                "- sentropy CSR has been moved to address 0x546 and requires "
                "accesses to be both read and write."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // CRYPTOGRAPHIC EXTENSION VERSION 1.0.0-rc5
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extK, "Version 1.0.0-rc5");

            vmidocAddText(
                Version,
                "Stable 1.0.0-rc5 version of October 8 2021, with these changes "
                "compared to version 1.0.0-rc1:"
            );

            vmidocAddText(
                Version,
                "- sentropy CSR has been removed;"
            );
            vmidocAddText(
                Version,
                "- read/write seed CSR has been added at address 0x015, "
                "requiring accesses to be both read and write;"
            );
            vmidocAddText(
                Version,
                "- mseccfg CSR has been modified to contain useed and sseed "
                "fields controlling access to seed CSR in User and Supervisor "
                "modes, respectively."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // VECTOR EXTENSION
    ////////////////////////////////////////////////////////////////////////////

    if(cfg->arch&ISA_V) {

        vmiDocNodeP Vector = vmidocAddSection(Root, "Vector Extension");

        vmidocAddText(
            Vector,
            "This variant implements the RISC-V base vector extension with "
            "version specified in the References section of this document. "
            "Note that parameter \"vector_version\" can be used to select "
            "the required version, including the unstable \"master\" version "
            "corresponding to the active specification. See section \"Vector "
            "Extension Versions\" for detailed information about differences "
            "between each supported version."
        );

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION PARAMETERS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Parameters = vmidocAddSection(
                Vector, "Vector Extension Parameters"
            );

            // document ELEN
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter ELEN is used to specify the maximum size of a single "
                "vector element in bits (32 or 64). By default, ELEN is set to "
                "%u in this variant.",
                riscv->configInfo.ELEN
            );
            vmidocAddText(Parameters, string);

            // document VLEN
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter VLEN is used to specify the number of bits in a "
                "vector register (a power of two in the range 32 to %u). By "
                "default, VLEN is set to %u in this variant.",
                VLEN_MAX, riscv->configInfo.VLEN
            );
            vmidocAddText(Parameters, string);

            // document SLEN
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter SLEN is used to specify the striping distance (a "
                "power of two in the range 32 to %u). By default, SLEN is set "
                "to %u in this variant.",
                VLEN_MAX, riscv->configInfo.SLEN
            );
            vmidocAddText(Parameters, string);

            // document EEW_index
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter EEW_index is used to specify the maximum supported "
                "EEW for index load/store instructions (a power of two in the "
                "range 8 to ELEN). By default, EEW_index is set to %u in this "
                "variant.",
                riscv->configInfo.EEW_index
            );
            vmidocAddText(Parameters, string);

            // document SEW_min
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter SEW_min is used to specify the minimum supported "
                "SEW (a power of two in the range 8 to ELEN). By default, "
                "SEW_min is set to %u in this variant.",
                riscv->configInfo.SEW_min
            );
            vmidocAddText(Parameters, string);

            // document Zvlsseg and Zvamo
            DOC_EXTENSION(riscv, Parameters, string, Zvlsseg);
            DOC_EXTENSION(riscv, Parameters, string, Zvamo);

            // document Zvediv
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter Zvediv will be used to specify whether the Zvediv "
                "extension is implemented. This is not currently supported."
            );
            vmidocAddText(Parameters, string);

            // document Zvqmac
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter Zvqmac is used to specify whether the Zvqmac "
                "extension is implemented (from version 0.8-draft-20191117 "
                "only). By default, Zvqmac is set to %u in this variant.",
                riscv->configInfo.Zvqmac
            );
            vmidocAddText(Parameters, string);

            // document vector embedded profile parameters
            DOC_VPROFILE(riscv, Parameters, string, Zve32x);
            DOC_VPROFILE(riscv, Parameters, string, Zve32f);
            DOC_VPROFILE(riscv, Parameters, string, Zve64x);
            DOC_VPROFILE(riscv, Parameters, string, Zve64f);
            DOC_VPROFILE(riscv, Parameters, string, Zve64d);

            // document require_vstart0
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter require_vstart0 is used to specify whether non-"
                "interruptible vector instructions require vstart=0. By "
                "default, require_vstart0 is set to %u in this variant.",
                riscv->configInfo.require_vstart0
            );
            vmidocAddText(Parameters, string);

            // document align_whole
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter align_whole is used to specify whether whole-"
                "register load and store instructions require alignment to "
                "the encoded EEW. By default, align_whole is set to %u in this "
                "variant.",
                riscv->configInfo.align_whole
            );
            vmidocAddText(Parameters, string);

            // document vill_trap
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter vill_trap is used to specify whether attempts to "
                "write illegal values to vtype cause an Illegal Instruction "
                "trap. By default, vill_trap is set to %u in this variant.",
                riscv->configInfo.vill_trap
            );
            vmidocAddText(Parameters, string);

            // document agnostic_ones
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter agnostic_ones is used to specify whether agnostic "
                "fields are filled with all-ones (from Vector Extension "
                "version 0.9 only). By default, agnostic_ones is set to %u in "
                "this variant, meaning %s.",
                riscv->configInfo.agnostic_ones,
                riscv->configInfo.agnostic_ones ?
                "this feature is active for all mask tails, for vector tail "
                "elements when vtype.vta=1 and for vector masked-off elements "
                "when vtype.vma=1" :
                "mask tails, vector tail elements and vector masked-off "
                "elements all show undisturbed behavior"
            );
            vmidocAddText(Parameters, string);

            // document unalignedV
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter unalignedV is used to specify whether vector load "
                "and store instructions support unaligned accesses. By "
                "default, unalignedV is set to %u in this variant, meaning "
                "unaligned accesses are %ssupported.",
                riscv->configInfo.unalignedV,
                riscv->configInfo.unalignedV ? "" : "not "
            );
            vmidocAddText(Parameters, string);
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION FEATURES
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Features = vmidocAddSection(
                Vector, "Vector Extension Features"
            );

            vmidocAddText(
                Features,
                "The model implements the base vector extension with a maximum "
                "ELEN of 64. Striping, masking and polymorphism are all fully "
                "supported. Zvlsseg and Zvamo extensions are fully supported. "
                "The Zvediv extension specification is subject to change and "
                "therefore not yet supported."
            );

            vmidocAddText(
                Features,
                "Single precision and double precision floating point types "
                "are supported if those types are also supported in the base "
                "architecture (i.e. the corresponding D and F features must be "
                "present and enabled). Vector floating point operations may "
                "only be executed if the base floating point unit is also "
                "enabled (i.e. mstatus.FS must be non-zero). Attempting to "
                "execute vector floating point instructions when mstatus.FS is "
                "0 will cause an Illegal Instruction exception."
            );

            vmidocAddText(
                Features,
                "The model assumes that all vector memory operations must be "
                "aligned to the memory element size. Unaligned accesses will "
                "cause a Load/Store Address Alignment exception."
            );

            // document mstatus_VS
            if(
                riscvVFSupport(riscv, RVVF_VS_STATUS_8) ||
                riscvVFSupport(riscv, RVVF_VS_STATUS_9)
            ) {
                vmidocAddText(
                    Features,
                    "By default, the processor starts with vector extension "
                    "disabled (mstatus.VS=0). Use parameter \"mstatus_VS\" to "
                    "force mstatus.VS to a non-zero value for the vector "
                    "extension to be enabled from the start."
                );
            }
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSIONS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Versions = vmidocAddSection(
                Vector, "Vector Extension Versions"
            );

            vmidocAddText(
                Versions,
                "The Vector Extension specification has been under active "
                "development. To enable simulation of hardware that may be "
                "based on an older version of the specification, the model "
                "implements behavior for a number of previous versions of the "
                "specification. The differing features of these are listed "
                "below, in chronological order."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 0.7.1-draft-20190605
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 0.7.1-draft-20190605"
            );

            vmidocAddText(
                Version,
                "Stable 0.7.1 version of June 10 2019."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 0.7.1-draft-20190605+
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 0.7.1-draft-20190605+"
            );

            vmidocAddText(
                Version,
                "Version 0.7.1, with some 0.8 and custom features. Not "
                "intended for general use."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 0.8-draft-20190906
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 0.8-draft-20190906"
            );

            vmidocAddText(
                Version,
                "Stable 0.8 draft of September 6 2019, with these changes "
                "compared to version 0.7.1-draft-20190605:"
            );
            vmidocAddText(
                Version,
                "- tail vector and scalar elements preserved, not zeroed;"
            );
            vmidocAddText(
                Version,
                "- vext.s.v, vmford.vv and vmford.vf instructions removed;"
            );
            vmidocAddText(
                Version,
                "- encodings for vfmv.f.s, vfmv.s.f, vmv.s.x, vpopc.m, "
                "vfirst.m, vmsbf.m, vmsif.m, vmsof.m, viota.m and vid.v "
                "instructions changed;"
            );
            vmidocAddText(
                Version,
                "- overlap constraints for slideup and slidedown instructions "
                "relaxed to allow overlap of destination and mask when SEW=1;"
            );
            vmidocAddText(
                Version,
                "- 64-bit vector AMO operations replaced with SEW-width vector "
                "AMO operations;"
            );
            vmidocAddText(
                Version,
                "- vsetvl and vsetvli instructions when rs1 = x0 preserve the "
                "current vl instead of selecting the maximum possible vl;"
            );
            vmidocAddText(
                Version,
                "- instruction vfncvt.rod.f.f.w added (to allow narrowing "
                "floating point conversions with jamming semantics);"
            );
            vmidocAddText(
                Version,
                "- instructions that transfer values between vector registers "
                "and general purpose registers (vmv.s.x and vmv.x.s) "
                "sign-extend the source if required (previously, it was "
                "zero-extended)."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 0.8-draft-20191004
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 0.8-draft-20191004"
            );

            vmidocAddText(
                Version,
                "Stable 0.8 draft of October 4 2019, with these changes "
                "compared to version 0.8-draft-20190906:"
            );
            vmidocAddText(
                Version,
                "- vwmaccsu and vwmaccus instruction encodings exchanged;"
            );
            vmidocAddText(
                Version,
                "- vwsmaccsu and vwsmaccus instruction encodings exchanged."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 0.8-draft-20191117
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 0.8-draft-20191117"
            );

            vmidocAddText(
                Version,
                "Stable 0.8 draft of November 17 2019, with these changes "
                "compared to version 0.8-draft-20191004:"
            );
            vmidocAddText(
                Version,
                "- indexed load/store instructions zero-extend offsets "
                "(previously, they were sign-extended);"
            );
            vmidocAddText(
                Version,
                "- vslide1up/vslide1down instructions sign-extend XLEN values "
                "to SEW length (previously, they were zero-extended);"
            );
            vmidocAddText(
                Version,
                "- vadc/vsbc instruction encodings require vm=0 (previously, "
                "they required vm=1);"
            );
            vmidocAddText(
                Version,
                "- vmadc/vmsbc instruction encodings allow both vm=0, "
                "implying carry input is used, and vm=1, implying carry input "
                "is zero (previously, only vm=1 was permitted, implying carry "
                "input is used);"
            );
            vmidocAddText(
                Version,
                "- vaaddu.vv, vaaddu.vx, vasubu.vv and vasubu.vx instructions "
                "added;"
            );
            vmidocAddText(
                Version,
                "- vaadd.vv and vaadd.vx, instruction encodings changed;"
            );
            vmidocAddText(
                Version,
                "- vaadd.vi instruction removed;"
            );
            vmidocAddText(
                Version,
                "- all widening saturating scaled multiply-add instructions "
                "removed;"
            );
            vmidocAddText(
                Version,
                "- vqmaccu.vv, vqmaccu.vx, vqmacc.vv, vqmacc.vx, vqmacc.vx, "
                "vqmaccsu.vx and vqmaccus.vx instructions added;"
            );
            vmidocAddText(
                Version,
                "- CSR vlenb added (vector register length in bytes);"
            );
            vmidocAddText(
                Version,
                "- load/store whole register instructions added;"
            );
            vmidocAddText(
                Version,
                "- whole register move instructions added."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 0.8-draft-20191118
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 0.8-draft-20191118"
            );

            vmidocAddText(
                Version,
                "Stable 0.8 draft of November 18 2019, with these changes "
                "compared to version 0.8-draft-20191117:"
            );
            vmidocAddText(
                Version,
                "- vsetvl/vsetvli with rd!=zero and rs1=zero sets vl to the "
                "maximum vector length."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 0.8
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 0.8"
            );

            vmidocAddText(
                Version,
                "Stable 0.8 official release (commit 9a65519), with these "
                "changes compared to version 0.8-draft-20191118:"
            );
            vmidocAddText(
                Version,
                "- vector context status in mstatus register is now "
                "implemented;"
            );
            vmidocAddText(
                Version,
                "- whole register load and store operations have been "
                "restricted to a single register only;"
            );
            vmidocAddText(
                Version,
                "- whole register move operations have been restricted to "
                "aligned groups of 1, 2, 4 or 8 registers only."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 0.9
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 0.9"
            );

            vmidocAddText(
                Version,
                "Stable 0.9 official release (commit cb7d225), with these "
                "significant changes compared to version 0.8:"
            );
            vmidocAddText(
                Version,
                "- mstatus.VS and sstatus.VS fields moved to bits 10:9;"
            );
            vmidocAddText(
                Version,
                "- new CSR vcsr added and fields VXSAT and VXRM relocated "
                "there from CSR fcsr;"
            );
            vmidocAddText(
                Version,
                "- vfslide1up.vf, vfslide1down.vf, vfcvt.rtz.xu.f.v, "
                "vfcvt.rtz.x.f.v, vfwcvt.rtz.xu.f.v, vfwcvt.rtz.x.f.v, "
                "vfncvt.rtz.xu.f.v, vfncvt.rtz.x.f.v, vzext.vf2, vsext.vf2, "
                "vzext.vf4, vsext.vf4, vzext.vf8 and vsext.vf8 instructions "
                "added;"
            );
            vmidocAddText(
                Version,
                "- fractional LMUL support added, controlled by an extended "
                "vtype.vlmul CSR field;"
            );
            vmidocAddText(
                Version,
                "- vector tail agnostic and vector mask agnostic fields "
                "added to the vtype CSR;"
            );
            vmidocAddText(
                Version,
                "- all vector load/store instructions replaced with new "
                "instructions that explicitly encode EEW of data or index;"
            );
            vmidocAddText(
                Version,
                "- whole register load and store operation encodings changed;"
            );
            vmidocAddText(
                Version,
                "- VFUNARY0 and VFUNARY1 encodings changed;"
            );
            vmidocAddText(
                Version,
                "- MLEN is always 1;"
            );
            vmidocAddText(
                Version,
                "- for implementations with SLEN != VLEN, striping is applied "
                "horizontally rather than the previous vertical striping;"
            );
            vmidocAddText(
                Version,
                "- vmsbf.m, vmsif.m and vmsof.m no longer allow overlap of "
                "destination with source or mask registers."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 1.0-draft-20210130
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 1.0-draft-20210130"
            );

            vmidocAddText(
                Version,
                "Stable 1.0-draft-20210130 official release (commit 8e768b0), "
                "with these changes compared to version 0.9:"
            );
            vmidocAddText(
                Version,
                "- SLEN=VLEN register layout is mandatory;"
            );
            vmidocAddText(
                Version,
                "- ELEN>VLEN is now supported for LMUL>1;"
            );
            vmidocAddText(
                Version,
                "- whole register moves and load/stores now have element size "
                "hints;"
            );
            vmidocAddText(
                Version,
                "- whole register load and store operations now permit use of "
                "aligned groups of 1, 2, 4 or 8 registers."
            );
            vmidocAddText(
                Version,
                "- overlap constraints for different source/destination EEW "
                "changed;"
            );
            vmidocAddText(
                Version,
                "- instructions vfrsqrt7.v, vfrec7.v and vrgatherei16.vv "
                "added;"
            );
            vmidocAddText(
                Version,
                "- CSR vtype format changed to make vlmul bits contiguous."
            );
            vmidocAddText(
                Version,
                "- vsetvli x0, x0, imm instruction is reserved if it would "
                "cause vl to change;"
            );
            vmidocAddText(
                Version,
                "- ordered/unordered indexed vector memory instructions added;"
            );
            vmidocAddText(
                Version,
                "- instructions vle1.v, vse1.v and vsetivli added."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 1.0-rc1-20210608
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 1.0-rc1-20210608"
            );

            vmidocAddText(
                Version,
                "Stable 1.0-rc1-20210608 official release (commit 795a4dd), "
                "with these changes compared to version 1.0-draft-20210130:"
            );
            vmidocAddText(
                Version,
                "- instructions vle1.v/vse1.v renamed vlm.v/vsm.v;"
            );
            vmidocAddText(
                Version,
                "- instructions vfredsum.vs/vfwredsum.vs renamed "
                "vfredusum.vs/vfwredusum.vs;"
            );
            vmidocAddText(
                Version,
                "- whole-register load/store instructions now use the EEW "
                "encoded in the instruction to determine element size "
                "(previously, this was a hint and element size 8 was used)."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION 1.0
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version 1.0"
            );

            vmidocAddText(
                Version,
                "Stable 1.0 official release (commit 8af318f), with these "
                "changes compared to version 1.0-rc1-20210608:"
            );
            vmidocAddText(
                Version,
                "- instruction vpopc.m renamed vcpop.m;"
            );
            vmidocAddText(
                Version,
                "- instruction vmandnot.mm renamed vmandn.mm;"
            );
            vmidocAddText(
                Version,
                "- instruction vmornot.mm renamed vmorn.mm."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // VECTOR EXTENSION VERSION master
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(
                Vector, "Version master"
            );

            vmidocAddText(
                Version,
                "Unstable master version as of "RVVV_MASTER_DATE" (commit "
                RVVV_MASTER_TAG"), with these changes compared to version 1.0:"
            );
            vmidocAddText(
                Version,
                "- instruction encodings are reserved if the same vector "
                " register would be read with two or more different EEWs."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // DSP EXTENSION
    ////////////////////////////////////////////////////////////////////////////

    if(cfg->arch&ISA_P) {

        vmiDocNodeP extP = vmidocAddSection(Root, "DSP Extension");

        vmidocAddText(
            extP,
            "This variant implements the DSP extension with version specified "
            "in the References section of this document. Note that parameter "
            "\"dsp_version\" can be used to select the required version of "
            "this extension."
        );

        if(cfg->arch&ISA_XLEN_32) {

            vmiDocNodeP Parameters = vmidocAddSection(
                extP, "DSP Extension Parameters"
            );

            // add subset control parameter description
            addPFeature(
                cfg, Parameters, SNPRINTF_TGT(string), RVPS_Zpsfoperand,
                "Zpsfoperand", "register-pair"
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // DSP EXTENSION VERSIONS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Versions = vmidocAddSection(
                extP, "DSP Extension Versions"
            );

            vmidocAddText(
                Versions,
                "The DSP Extension specification has been under active "
                "development. To enable simulation of hardware that may "
                "be based on an older version of the specification, the model "
                "implements behavior for a number of versions of the "
                "specification. The differing features of these are listed "
                "below, in chronological order."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // DSP EXTENSION VERSION 0.5.2
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extP, "Version 0.5.2");

            vmidocAddText(
                Version,
                "Stable 0.5.2 version of July 8 2019."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // DSP EXTENSION VERSION 0.9.6
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Version = vmidocAddSection(extP, "Version 0.9.6");

            vmidocAddText(
                Version,
                "Stable 0.9.6 version of September 8 2021, with these changes "
                "compared to version 0.5.2:"
            );
            vmidocAddText(
                Version,
                "- major opcode is changed from 1111111 to 1110111;"
            );
            vmidocAddText(
                Version,
                " - use of misaligned (odd-numbered) registers for RV32 64-bit "
                "instructions is reserved;"
            );
            vmidocAddText(
                Version,
                " - regardless of endianness, for RV32 64-bit instructions "
                "the lower-numbered register holds the low-order bits, and the "
                "higher-numbered register holds the high-order bits;"
            );
            vmidocAddText(
                Version,
                " - when an RV32 64-bit result is written to x0, the entire "
                "write takes no effect;"
            );
            vmidocAddText(
                Version,
                " - when x0 is used as an RV32 64-bit operand, the entire "
                "operand is zero;"
            );
            vmidocAddText(
                Version,
                " - changed ucode (0x801) CSR to vxsat CSR (0x009);"
            );
            vmidocAddText(
                Version,
                " - CLO and SWAP16 instructions have been removed;"
            );
            vmidocAddText(
                Version,
                " - modified encoding and field layout of BPICK instruction;"
            );
            vmidocAddText(
                Version,
                " - modified minor encodings of STAS16, RSTAS16, KSTAS16, "
                "URSTAS16, UKSTAS16, STSA16, RSTSA16, KSTSA16, URSTSA16, "
                "UKSTSA16, STAS32, RSTAS32, KSTAS32, URSTAS32, UKSTAS32, "
                "STSA32, RSTSA32, KSTSA32, URSTSA32 and UKSTSA32."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////
    // OTHER EXTENSIONS
    ////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP extP = vmidocAddSection(Root, "Other Extensions");

        vmidocAddText(
            extP,
            "Other extensions that can be configured are described in this "
            "section."
        );

        // document Zmmul
        if(cfg->arch&ISA_M) {

            static const char *meanings[] = {
                "all multiply and divide instructions are implemented",
                "multiply instructions are implemented but divide and "
                "remainder instructions are not implemented"
            };

            docBoolParam(extP, "Zmmul", cfg->Zmmul, meanings);
        }

        // document Zicsr
        {
            static const char *meanings[] = {
                "standard CSRs and CSR access instructions are not implemented "
                "and an alternative scheme must be provided as a processor "
                "extension",
                "standard CSRs and CSR access instructions are implemented"
            };

            docBoolParam(extP, "Zicsr", !cfg->noZicsr, meanings);
        }

        // document Zifencei
        {
            static const char *meanings[] = {
                "the fence.i instruction is not implemented",
                "the fence.i instruction is implemented (but treated as a NOP "
                "by the model)"
            };

            docBoolParam(extP, "Zifencei", !cfg->noZifencei, meanings);
        }

        // document Zicbom
        {
            static const char *meanings[] = {
                "code block management instructions are undefined",
                "code block management instructions cbo.clean, cbo.flush and "
                "cbo.inval are defined",
            };

            vmiDocNodeP sub = docBoolParam(extP, "Zicbom", cfg->Zicbom, meanings);

            vmidocAddText(
                sub,
                "If Zicbom is present, the cache block size is given by "
                "parameter \"cmomp_bytes\". The instructions may cause traps "
                "if used illegally but otherwise are NOPs in this model."
            );
        }

        // document Zicbop
        {
            static const char *meanings[] = {
                "prefetch instructions are undefined",
                "prefetch instructions prefetch.i, prefetch.r and prefetch.w "
                "are defined (but behave as NOPs in this model)",
            };

            docBoolParam(extP, "Zicbop", cfg->Zicbop, meanings);
        }

        // document Zicboz
        {
            static const char *meanings[] = {
                "the cbo.zero instruction is undefined",
                "the cbo.zero instruction is defined",
            };

            vmiDocNodeP sub = docBoolParam(extP, "Zicboz", cfg->Zicboz, meanings);

            vmidocAddText(
                sub,
                "If Zicboz is present, the cache block size is given by "
                "parameter \"cmoz_bytes\"."
            );
        }

        // document Svnapot
        if(cfgHas64S(cfg)) {

            static const char *meanings[] = {
                "NAPOT Translation Contiguity is not implemented",
                "NAPOT Translation Contiguity is enabled for page sizes "
                "indicated by that mask value when page table entry bit 63 is "
                "set",
            };
            static const char *zNonZ[] = {"zero", "non-zero"};

            const char *name  = "Svnapot";
            Uns64       param = cfg->Svnapot_page_mask;
            Bool        nonZ  = param;
            vmiDocNodeP sub   = vmidocAddSection(extP, name);
            char        string[1024];

            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"Svnapot_page_mask\" is 0x"FMT_Ax" on this "
                "variant, meaning that %s. if \"Svnapot_page_mask\" is %s then "
                "%s.",
                param, meanings[nonZ], zNonZ[!nonZ], meanings[!nonZ]
            );

            vmidocAddText(sub, string);

            vmidocAddText(
                sub,
                "If Svnapot is present, \"Svnapot_page_mask\" is a mask of "
                "page sizes for which contiguous pages can be created. For "
                "example, a value of 0x10000 implies that 64KiB contiguous "
                "pages are supported."
            );
        }

        // document Svpbmt
        if(cfgHas64S(cfg)) {

            static const char *meanings[] = {
                "page-based memory types are not implemented",
                "page-based memory types are indicated by page table entry "
                "bits 62:61",
            };

            vmiDocNodeP sub = docBoolParam(extP, "Svpbmt", cfg->Svpbmt, meanings);

            vmidocAddText(
                sub,
                "Note that except for their effect on Page Faults, the encoded "
                "memory types do not alter the behavior of this model, which "
                "always implements strongly-ordered non-cacheable semantics."
            );
        }

        // document Svinval
        if(cfgHas64S(cfg)) {

            static const char *meaningsS[] = {
                "fine-grained address-translation cache invalidation "
                "instructions are not implemented",
                "fine-grained address-translation cache invalidation "
                "instructions sinval.vma, sfence.w.inval and sfence.inval.ir "
                "are implemented",
            };

            static const char *meaningsH[] = {
                "fine-grained address-translation cache invalidation "
                "instructions are not implemented",
                "fine-grained address-translation cache invalidation "
                "instructions sinval.vma, sfence.w.inval, sfence.inval.ir, "
                "hinval.vvma and hinval.gvma are implemented",
            };

            docBoolParam(
                extP, "Svinval", cfg->Svinval,
                cfg->arch&ISA_H ? meaningsH : meaningsS
            );
        }

        // document Smstateen
        {
            static const char *meanings[] = {
                "state enable CSRs are undefined",
                "state enable CSRs are defined",
            };

            vmiDocNodeP sub = docBoolParam(
                extP, "Smstateen", cfg->Smstateen, meanings
            );

            vmidocAddText(
                sub,
                "Within the state enable CSRs, only bit 1 (for Zfinx), bit 57 "
                "(for xcontext CSR access), bit 62 (for xenvcfg CSR access) "
                "and bit 63 (for lower-level state enable CSR access) are "
                "currently implemented."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // CLIC
    ////////////////////////////////////////////////////////////////////////////

    docCLIC(riscv, Root);

    ////////////////////////////////////////////////////////////////////////////
    // CLINT
    ////////////////////////////////////////////////////////////////////////////

    docCLINT(riscv, Root);

    ////////////////////////////////////////////////////////////////////////////
    // LR/SC LOCKING
    ////////////////////////////////////////////////////////////////////////////

    if(cfg->arch&ISA_A) {

        vmiDocNodeP LRSC = vmidocAddSection(
            Root, "Load-Reserved/Store-Conditional Locking"
        );

        snprintf(
            SNPRINTF_TGT(string),
            "By default, LR/SC locking is implemented automatically by the "
            "model and simulator, with a reservation granule defined by the "
            "\"lr_sc_grain\" parameter; this variant implements a %u-byte "
            "reservation granule. It is also possible to implement locking "
            "externally to the model in a platform component, using the "
            "\"LR_address\", \"SC_address\" and \"SC_valid\" net ports, as "
            "described below.",
            cfg->lr_sc_grain
        );
        vmidocAddText(LRSC, string);

        vmidocAddText(
            LRSC,
            "The \"LR_address\" output net port is written by the model with "
            "the address used by a load-reserved instruction as it executes. "
            "This port should be connected as an input to the external lock "
            "management component, which should record the address, and also "
            "that an LR/SC transaction is active."
        );
        vmidocAddText(
            LRSC,
            "The \"SC_address\" output net port is written by the model with "
            "the address used by a store-conditional instruction as it "
            "executes. This should be connected as an input to the external "
            "lock management component, which should compare the address with "
            "the previously-recorded load-reserved address, and determine "
            "from this (and other implementation-specific constraints) whether "
            "the store should succeed. It should then immediately write the "
            "Boolean success/fail code to the \"SC_valid\" input net port of "
            "the model. Finally, it should update state to indicate that "
            "an LR/SC transaction is no longer active."
        );
        vmidocAddText(
            LRSC,
            "It is also possible to write zero to the \"SC_valid\" input net "
            "port at any time outside the context of a store-conditional "
            "instruction, which will mark any active LR/SC transaction as "
            "invalid."
        );
        vmidocAddText(
            LRSC,
            "Irrespective of whether LR/SC locking is implemented internally "
            "or externally, taking any exception or interrupt or executing "
            "exception-return instructions (e.g. MRET) will always mark any "
            "active LR/SC transaction as invalid."
        );
        snprintf(
            SNPRINTF_TGT(string),
            "Parameter \"amo_aborts_lr_sc\" is used to specify whether AMO "
            "operations abort any active LR/SC pair. In this variant, "
            "\"amo_aborts_lr_sc\" is %u.",
            riscv->configInfo.amo_aborts_lr_sc
        );
        vmidocAddText(LRSC, string);

        if(cfg->arch&ISA_XLEN_64) {
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"lr_sc_match_size\" is used to specify whether "
                "data sizes of LR and SC instructions must match for the SC "
                "instruction to succeed. In this variant, \"lr_sc_match_size\" "
                "is %s.",
                riscv->configInfo.lr_sc_match_size ? "True" : "False"
            );
            vmidocAddText(LRSC, string);
        }

        vmiDocNodeP ACODE = vmidocAddSection(
            Root, "Active Atomic Operation Indication"
        );
        vmidocAddText(
            ACODE,
            "The \"AMO_active\" output net port is written by the model with "
            "a code indicating any current atomic memory operation while the "
            "instruction is active. The written codes are:"
        );
        vmidocAddText(ACODE, "0: no atomic instruction active");
        vmidocAddText(ACODE, "1: AMOMIN active");
        vmidocAddText(ACODE, "2: AMOMAX active");
        vmidocAddText(ACODE, "3: AMOMINU active");
        vmidocAddText(ACODE, "4: AMOMAXU active");
        vmidocAddText(ACODE, "5: AMOADD active");
        vmidocAddText(ACODE, "6: AMOXOR active");
        vmidocAddText(ACODE, "7: AMOOR active");
        vmidocAddText(ACODE, "8: AMOAND active");
        vmidocAddText(ACODE, "9: AMOSWAP active");
        vmidocAddText(ACODE, "10: LR active");
        vmidocAddText(ACODE, "11: SC active");
    }

    ////////////////////////////////////////////////////////////////////////////
    // INTERRUPTS
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP Interrupts = vmidocAddSection(Root, "Interrupts");

        vmidocAddText(
            Interrupts,
            "The \"reset\" port is an active-high reset input. The processor "
            "is halted when \"reset\" goes high and resumes execution from the "
            "reset address specified using the \"reset_address\" parameter "
            "or \"reset_addr\" port when the signal goes low. The \"mcause\" "
            "register is cleared to zero."
        );
        vmidocAddText(
            Interrupts,
            "The \"nmi\" port is an active-high NMI input. The processor "
            "resumes execution from the address specified using the "
            "\"nmi_address\" parameter or \"nmi_addr\" port when the NMI "
            "signal goes high. The \"mcause\" register is cleared to zero."
        );
        vmidocAddText(
            Interrupts,
            "All other interrupt ports are active high. For each implemented "
            "privileged execution level, there are by default input ports for "
            "software interrupt, timer interrupt and external interrupt; for "
            "example, for Machine mode, these are called \"MSWInterrupt\", "
            "\"MTimerInterrupt\" and \"MExternalInterrupt\", respectively. "
            "When the N extension is implemented, ports are also present for "
            "User mode. Parameter \"unimp_int_mask\" allows the default "
            "behavior to be changed to exclude certain interrupt ports. The "
            "parameter value is a mask in the same format as the \"mip\" "
            "CSR; any interrupt corresponding to a non-zero bit in this mask "
            "will be removed from the processor and read as zero in \"mip\", "
            "\"mie\" and \"mideleg\" CSRs (and Supervisor and User mode "
            "equivalents if implemented)."
        );
        vmidocAddText(
            Interrupts,
            "Parameter \"external_int_id\" can be used to enable extra "
            "interrupt ID input ports on each hart. If the parameter is True "
            "then when an external interrupt is applied the value on the "
            "ID port is sampled and used to fill the Exception Code field "
            "in the \"mcause\" CSR (or the equivalent CSR for other execution "
            "levels). For Machine mode, the extra interrupt ID port is called "
            "\"MExternalInterruptID\"."
        );
        vmidocAddText(
            Interrupts,
            "The \"deferint\" port is an active-high artifact input that, "
            "when written to 1, prevents any pending-and-enabled interrupt "
            "being taken (normally, such an interrupt would be taken on the "
            "next instruction after it becomes pending-and-enabled). The "
            "purpose of this signal is to enable alignment with hardware "
            "models in step-and-compare usage."
        );
    }

    ////////////////////////////////////////////////////////////////////////////
    // DEBUG MODE
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP debugMode = vmidocAddSection(Root, "Debug Mode");

        vmidocAddText(
            debugMode,
            "The model can be configured to implement Debug mode using "
            "parameter \"debug_mode\". This implements features described "
            "in Chapter 4 of the RISC-V External Debug Support specification "
            "with version specified by parameter \"debug_version\" (see "
            "References). Some aspects of this mode are not defined in "
            "the specification because they are implementation-specific; the "
            "model provides infrastructure to allow implementation of a "
            "Debug Module using a custom harness. Features added are described "
            "below."
        );
        vmidocAddText(
            debugMode,
            "Parameter \"debug_mode\" can be used to specify three different "
            "behaviors, as follows:"
        );
        vmidocAddText(
            debugMode,
            "1. If set to value \"vector\", then operations that would cause "
            "entry to Debug mode result in the processor jumping to the "
            "address specified by the \"debug_address\" parameter. It will "
            "execute at this address, in Debug mode, until a \"dret\" "
            "instruction causes return to non-Debug mode. Any exception "
            "generated during this execution will cause a jump to the address "
            "specified by the \"dexc_address\" parameter."
        );
        vmidocAddText(
            debugMode,
            "2. If set to value \"interrupt\", then operations that would "
            "cause entry to Debug mode result in the processor simulation call "
            "(e.g. opProcessorSimulate) returning, with a stop reason of "
            "OP_SR_INTERRUPT. In this usage scenario, the Debug Module is "
            "implemented in the simulation harness."
        );
        vmidocAddText(
            debugMode,
            "3. If set to value \"halt\", then operations that would cause "
            "entry to Debug mode result in the processor halting. Depending on "
            "the simulation environment, this might cause a return from the "
            "simulation call with a stop reason of OP_SR_HALT, or debug mode "
            "might be implemented by another platform component which then "
            "restarts the debugged processor again."
        );

        ////////////////////////////////////////////////////////////////////////
        // DEBUG STATE ENTRY
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP StateEntry = vmidocAddSection(
                debugMode, "Debug State Entry"
            );

            vmidocAddText(
                StateEntry,
                "The specification does not define how Debug mode is "
                "implemented. In this model, Debug mode is enabled by a "
                "Boolean pseudo-register, \"DM\". When \"DM\" is True, the "
                "processor is in Debug mode. When \"DM\" is False, mode is "
                "defined by \"mstatus\" in the usual way."
            );
            vmidocAddText(
                StateEntry,
                "Entry to Debug mode can be performed in any of these ways:"
            );
            vmidocAddText(
                StateEntry,
                "1. By writing True to register \"DM\" (e.g. using "
                "opProcessorRegWrite) followed by simulation of at least one "
                "cycle (e.g. using opProcessorSimulate), "
                "dcsr cause will be reported as trigger;"
            );
            vmidocAddText(
                StateEntry,
                "2. By writing a 1 then 0 to net \"haltreq\" (using "
                "opNetWrite) followed by simulation of at least one  cycle "
                "(e.g. using opProcessorSimulate);"
            );
            vmidocAddText(
                StateEntry,
                "3. By writing a 1 to net \"resethaltreq\" (using "
                "opNetWrite) while the \"reset\" signal undergoes a negedge "
                "transition, followed by simulation of at least one cycle "
                "(e.g. using opProcessorSimulate);"
            );
            vmidocAddText(
                StateEntry,
                "4. By executing an \"ebreak\" instruction when Debug mode "
                "entry for the current processor mode is enabled by "
                "dcsr.ebreakm, dcsr.ebreaks or dcsr.ebreaku."
            );
            vmidocAddText(
                StateEntry,
                "In all cases, the processor will save required state in "
                "\"dpc\" and \"dcsr\" and then perform actions described "
                "above, depending in the value of the \"debug_mode\" parameter."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // DEBUG STATE EXIT
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP StateExit = vmidocAddSection(
                debugMode, "Debug State Exit"
            );

            vmidocAddText(
                StateExit,
                "Exit from Debug mode can be performed in any of these ways:"
            );
            vmidocAddText(
                StateExit,
                "1. By writing False to register \"DM\" (e.g. using "
                "opProcessorRegWrite) followed by simulation of at least one "
                "cycle (e.g. using opProcessorSimulate);"
            );
            vmidocAddText(
                StateExit,
                "2. By executing an \"dret\" instruction when Debug mode."
            );
            vmidocAddText(
                StateExit,
                "In both cases, the processor will perform the steps described "
                "in section 4.6 (Resume) of the Debug specification."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // DEBUG REGISTERS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Registers = vmidocAddSection(
                debugMode, "Debug Registers"
            );

            vmidocAddText(
                Registers,
                "When Debug mode is enabled, registers \"dcsr\", \"dpc\", "
                "\"dscratch0\" and \"dscratch1\" are implemented as described "
                "in the specification. These may be manipulated externally by "
                "a Debug Module using opProcessorRegRead or "
                "opProcessorRegWrite; for example, the Debug Module could "
                "write \"dcsr\" to enable \"ebreak\" instruction behavior as "
                "described above, or read and write \"dpc\" to emulate "
                "stepping over an \"ebreak\" instruction prior to resumption "
                "from Debug mode."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // DEBUG MODE EXECUTION
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP DebugExecution = vmidocAddSection(
                debugMode, "Debug Mode Execution"
            );

            vmidocAddText(
                DebugExecution,
                "The specification allows execution of code fragments in Debug "
                "mode. A Debug Module implementation can cause execution in "
                "Debug mode by the following steps:"
            );
            vmidocAddText(
                DebugExecution,
                "1. Write the address of a Program Buffer to the program "
                "counter using opProcessorPCSet;"
            );
            vmidocAddText(
                DebugExecution,
                "2. If \"debug_mode\" is set to \"halt\", write 0 to "
                "pseudo-register \"DMStall\" (to leave halted state);"
            );
            vmidocAddText(
                DebugExecution,
                "3. If entry to Debug mode was handled by exiting the "
                "simulation callback, call opProcessorSimulate or "
                "opRootModuleSimulate to resume simulation."
            );
            vmidocAddText(
                DebugExecution,
                "Debug mode will be re-entered in these cases:"
            );
            vmidocAddText(
                DebugExecution,
                "1. By execution of an \"ebreak\" instruction; or:"
            );
            vmidocAddText(
                DebugExecution,
                "2. By execution of an instruction that causes an exception."
            );
            vmidocAddText(
                DebugExecution,
                "In both cases, the processor will either jump to the "
                "debug exception address, or return control immediately to the "
                "harness, with stopReason of OP_SR_INTERRUPT, or perform a "
                "halt, depending on the value of the \"debug_mode\" parameter."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // DEBUG SINGLE STEP
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP DebugExecution = vmidocAddSection(
                debugMode, "Debug Single Step"
            );

            vmidocAddText(
                DebugExecution,
                "When in Debug mode, the processor or harness can cause a "
                "single instruction to be executed on return from that mode by "
                "setting dcsr.step. After one non-Debug-mode instruction "
                "has been executed, control will be returned to the harness. "
                "The processor will remain in single-step mode until dcsr.step "
                "is cleared."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // DEBUG EVENT PRIORITIES
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP DebugPriority = vmidocAddSection(
                debugMode, "Debug Event Priorities"
            );

            vmidocAddText(
                DebugPriority,
                "The model supports two different models for determining which "
                "debug exception occurs when multiple debug events are pending:"
            );
            vmidocAddText(
                DebugPriority,
                "1: original mode (when parameter \"debug_priority\"="
                "\"original\");"
            );
            vmidocAddText(
                DebugPriority,
                "2: modified mode, as described in Debug Specification pull "
                "request 693 (when parameter \"debug_priority\"=\"PR693\"). "
                "This mode resolves some anomalous behavior of the original "
                "specification."
            );
        }

        ////////////////////////////////////////////////////////////////////////
        // DEBUG PORTS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP Ports = vmidocAddSection(
                debugMode, "Debug Ports"
            );

            vmidocAddText(
                Ports,
                "Port \"DM\" is an output signal that indicates whether the "
                "processor is in Debug mode"
            );
            vmidocAddText(
                Ports,
                "Port \"haltreq\" is a rising-edge-triggered signal that "
                "triggers entry to Debug mode (see above)."
            );
            vmidocAddText(
                Ports,
                "Port \"resethaltreq\" is a level-sensitive signal that "
                "triggers entry to Debug mode after reset (see above)."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // TRIGGER MODULE
    ////////////////////////////////////////////////////////////////////////////

    if(cfg->trigger_num) {

        vmiDocNodeP trigger = vmidocAddSection(Root, "Trigger Module");

        vmidocAddText(
            trigger,
            "This model is configured with a trigger module, implementing a "
            "subset of the behavior described in Chapter 5 of the RISC-V "
            "External Debug Support specification with version specified by "
            "parameter \"debug_version\" (see References)."
        );

        ////////////////////////////////////////////////////////////////////////
        // RESTRICTIONS
        ////////////////////////////////////////////////////////////////////////

        {
            vmiDocNodeP restrictions = vmidocAddSection(
                trigger, "Trigger Module Restrictions"
            );

            vmidocAddText(
                restrictions,
                "The model currently supports tdata1 of type 0, type 2 "
                "(mcontrol), type 3 (icount), type 4 (itrigger), type 5 "
                "(etrigger) and type 6 (mcontrol6). icount triggers are "
                "implemented for a single instruction only, with count "
                "hard-wired to 1 and automatic zeroing of mode bits when the "
                "trigger fires."
            );
        }

        {
            vmiDocNodeP Parameters = vmidocAddSection(
                trigger, "Trigger Module Parameters"
            );

            // document trigger_num
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"trigger_num\" is used to specify the number of "
                "implemented triggers. In this variant, \"trigger_num\" is %u.",
                riscv->configInfo.trigger_num
            );
            vmidocAddText(Parameters, string);

            // document tinfo
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"tinfo\" is used to specify the value of the "
                "read-only \"tinfo\" register, which indicates the trigger "
                "types supported. In this variant, \"tinfo\" is 0x%02x.",
                riscv->configInfo.tinfo
            );
            vmidocAddText(Parameters, string);

            // document trigger_match
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"trigger_match\" is used to specify the legal "
                "\"match\" values for triggers of types 2 and 6. This "
                "parameter is a bitmask with 1 bits corresponding to legal "
                "values; for example, a \"trigger_match\" of 0xd, means that "
                "triggers of types 0, 2 and 3 are supported. In this variant, "
                "\"trigger_match\" is 0x%04x.",
                riscv->configInfo.trigger_match
            );
            vmidocAddText(Parameters, string);

            // document tinfo_undefined
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"tinfo_undefined\" is used to specify whether the "
                "\"tinfo\" register is undefined, in which case reads of it "
                "trap to Machine mode. In this variant, \"tinfo_undefined\" "
                "is %u.",
                riscv->configInfo.tinfo_undefined
            );
            vmidocAddText(Parameters, string);

            // document tcontrol_undefined
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"tcontrol_undefined\" is used to specify whether "
                "the \"tcontrol\" register is undefined, in which case "
                "accesses to it trap to Machine mode. In this variant, "
                "\"tcontrol_undefined\" is %u.",
                riscv->configInfo.tcontrol_undefined
            );
            vmidocAddText(Parameters, string);

            // document mcontext_undefined
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"mcontext_undefined\" is used to specify whether "
                "the \"mcontext\" register is undefined, in which case "
                "accesses to it trap to Machine mode. In this variant, "
                "\"mcontext_undefined\" is %u.",
                riscv->configInfo.mcontext_undefined
            );
            vmidocAddText(Parameters, string);

            // document scontext_undefined
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"scontext_undefined\" is used to specify whether "
                "the \"scontext\" register is undefined, in which case "
                "accesses to it trap to Machine mode. In this variant, "
                "\"scontext_undefined\" is %u.",
                riscv->configInfo.scontext_undefined
            );
            vmidocAddText(Parameters, string);

            // document mscontext_undefined
            if(RISCV_DBG_VERSION(riscv)>=RVDBG_0_14_0) {
                snprintf(
                    SNPRINTF_TGT(string),
                    "Parameter \"mscontext_undefined\" is used to specify "
                    "whether the \"mscontext\" register is undefined, in which "
                    "case accesses to it trap to Machine mode. In this "
                    "variant, \"mscontext_undefined\" is %u.",
                    riscv->configInfo.mscontext_undefined
                );
                vmidocAddText(Parameters, string);
            }

            // document hcontext_undefined
            if(cfg->arch&ISA_H) {
                snprintf(
                    SNPRINTF_TGT(string),
                    "Parameter \"hcontext_undefined\" is used to specify "
                    "whether the \"hcontext\" register is undefined, in which "
                    "case accesses to it trap to Machine mode. In this "
                    "variant, \"hcontext_undefined\" is %u.",
                    riscv->configInfo.hcontext_undefined
                );
                vmidocAddText(Parameters, string);
            }

            // document amo_trigger
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"amo_trigger\" is used to specify whether load/"
                "store triggers are activated for AMO instructions. In this "
                "variant, \"amo_trigger\" is %u.",
                riscv->configInfo.amo_trigger
            );
            vmidocAddText(Parameters, string);

            // document no_hit
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"no_hit\" is used to specify whether the \"hit\" "
                "bit in tdata1 is unimplemented. In this variant, \"no_hit\" "
                "is %u.",
                riscv->configInfo.no_hit
            );
            vmidocAddText(Parameters, string);

            // document no_sselect_2
            if(cfg->arch&ISA_S) {
                snprintf(
                    SNPRINTF_TGT(string),
                    "Parameter \"no_sselect_2\" is used to specify whether the "
                    "\"sselect\" field in \"textra32\"/\"textra64\" registers is "
                    "unable to hold value 2 (indicating match by ASID is not "
                    "allowed). In this variant, \"no_sselect_2\" is %u.",
                    riscv->configInfo.no_sselect_2
                );
                vmidocAddText(Parameters, string);
            }

            // document mcontext_bits
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"mcontext_bits\" is used to specify the number of "
                "writable bits in the \"mcontext\" register. In this variant, "
                "\"mcontext_bits\" is %u.",
                riscv->configInfo.mcontext_bits
            );
            vmidocAddText(Parameters, string);

            // document scontext_bits
            if(cfg->arch&ISA_S) {
                snprintf(
                    SNPRINTF_TGT(string),
                    "Parameter \"scontext_bits\" is used to specify the number "
                    "of writable bits in the \"scontext\" register. In this "
                    "variant, \"scontext_bits\" is %u.",
                    riscv->configInfo.scontext_bits
                );
                vmidocAddText(Parameters, string);
            }

            // document mvalue_bits
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"mvalue_bits\" is used to specify the number of "
                "writable bits in the \"mvalue\" field in \"textra32\"/"
                "\"textra64\" registers; if zero, the \"mselect\" field is "
                "tied to zero. In this variant, \"mvalue_bits\" is %u.",
                riscv->configInfo.mvalue_bits
            );
            vmidocAddText(Parameters, string);

            // document svalue_bits
            if(cfg->arch&ISA_S) {
                snprintf(
                    SNPRINTF_TGT(string),
                    "Parameter \"svalue_bits\" is used to specify the number of "
                    "writable bits in the \"svalue\" field in \"textra32\"/"
                    "\"textra64\" registers; if zero, the \"sselect\" is tied "
                    "to zero. In this variant, \"svalue_bits\" is %u.",
                    riscv->configInfo.svalue_bits
                );
                vmidocAddText(Parameters, string);
            }

            // document mcontrol_maskmax
            snprintf(
                SNPRINTF_TGT(string),
                "Parameter \"mcontrol_maskmax\" is used to specify the value "
                "of field \"maskmax\" in the \"mcontrol\" register. In this "
                "variant, \"mcontrol_maskmax\" is %u.",
                riscv->configInfo.mcontrol_maskmax
            );
            vmidocAddText(Parameters, string);
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // DEBUG MASK
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP debugMask = vmidocAddSection(Root, "Debug Mask");

        vmidocAddText(
            debugMask,
            "It is possible to enable model debug messages in various "
            "categories. This can be done statically using the \"debugflags\" "
            "parameter, or dynamically using the \"debugflags\" command. "
            "Enabled messages are specified using a bitmask value, as follows:"
        );

        // document memory debug
        snprintf(
            SNPRINTF_TGT(string),
            "Value 0x%03x: enable debugging of PMP and virtual memory state;",
            RISCV_DEBUG_MMU_MASK
        );
        vmidocAddText(debugMask, string);

        // document exception debug
        snprintf(
            SNPRINTF_TGT(string),
            "Value 0x%03x: enable debugging of interrupt state.",
            RISCV_DEBUG_EXCEPT_MASK
        );
        vmidocAddText(debugMask, string);

        vmidocAddText(
            debugMask,
            "All other bits in the debug bitmask are reserved and must not "
            "be set to non-zero values."
        );
    }

    ////////////////////////////////////////////////////////////////////////////
    // INTEGRATION SUPPORT
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP integration = vmidocAddSection(Root, "Integration Support");

        vmidocAddText(
            integration,
            "This model implements a number of non-architectural pseudo-"
            "registers and other features to facilitate integration."
        );

        vmiDocNodeP leafSection = vmidocAddSection(
            integration, "CSR Register External Implementation"
        );

        vmidocAddText(
            leafSection,
            "If parameter \"enable_CSR_bus\" is True, an artifact 16-bit bus "
            "\"CSR\" is enabled. Slave callbacks installed on this bus can "
            "be used to implement modified CSR behavior (use opBusSlaveNew or "
            "icmMapExternalMemory, depending on the client API). A CSR with "
            "index 0xABC is mapped on the bus at address 0xABC0; as a concrete "
            "example, implementing CSR \"time\" (number 0xC01) externally "
            "requires installation of callbacks at address 0xC010 on the CSR "
            "bus."
        );

        if(cfg->arch&ISA_A) {

            vmiDocNodeP leafSection = vmidocAddSection(
                integration, "LR/SC Active Address"
            );

            vmidocAddText(
                leafSection,
                "Artifact register \"LRSCAddress\" shows the active LR/SC "
                "lock address. The register holds all-ones if there is no "
                "LR/SC operation active or if LR/SC locking is implemented "
                "externally as described above. When parameter "
                "\"lr_sc_match_size\" is True and this is a 64-bit access, "
                "the least-significant bit of \"LRSCAddress\" is one (to "
                "indicate a 64-bit access). If parameter \"lr_sc_match_size\" "
                "is False or this is a 32-bit access, the least-significant "
                "bit of \"LRSCAddress\" is zero."
            );
        }

        if(cfg->arch&ISA_S) {

            vmiDocNodeP leafSection = vmidocAddSection(
                integration, "Page Table Walk Introspection"
            );

            vmidocAddText(
                leafSection,
                "Artifact register \"PTWStage\" shows the active page table "
                "translation stage (0 if no stage active, 1 if HS-stage "
                "active, 2 if VS-stage active and 3 if G-stage active). This "
                "register is visibly non-zero only in a memory access callback "
                "triggered by a page table walk event."
            );

            vmidocAddText(
                leafSection,
                "Artifact register \"PTWInputAddr\" shows the input address "
                "of active page table translation. This register is visibly "
                "non-zero only in a memory access callback triggered by a page "
                "table walk event."
            );

            vmidocAddText(
                leafSection,
                "Artifact register \"PTWLevel\" shows the active level of "
                "page table translation (corresponding to index variable \"i\" "
                "in the algorithm described by Virtual Address Translation "
                "Process in the RISC-V Privileged Architecture specification). "
                "This register is visibly non-zero only in a memory access "
                "callback triggered by a page table walk event."
            );
        }

        if(cfg->arch&ISA_DF) {

            vmiDocNodeP leafSection = vmidocAddSection(
                integration, "Artifact Register \"fflags_i\""
            );

            vmidocAddText(
                leafSection,
                "If parameter \"enable_fflags_i\" is True, an 8-bit artifact "
                "register \"fflags_i\" is added to the model. This register "
                "shows the floating point flags set by the current "
                "instruction (unlike the standard \"fflags\" CSR, in which the "
                "flag bits are sticky)."
            );
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // LIMITATIONS
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP Limitations = vmidocAddSection(Root, "Limitations");

        vmidocAddText(
            Limitations,
            "Instruction pipelines are not modeled in any way. All instructions "
            "are assumed to complete immediately. This means that instruction "
            "barrier instructions (e.g. fence.i) are treated as NOPs, with "
            "the exception of any Illegal Instruction behavior, which is "
            "modeled."
        );

        vmidocAddText(
            Limitations,
            "Caches and write buffers are not modeled in any way. All loads, "
            "fetches and stores complete immediately and in order, and are "
            "fully synchronous. Data barrier instructions (e.g. fence) are "
            "treated as NOPs, with the exception of any Illegal Instruction "
            "behavior, which is modeled."
        );

        vmidocAddText(
            Limitations,
            "Real-world timing effects are not modeled: all instructions are "
            "assumed to complete in a single cycle."
        );

        vmidocAddText(
            Limitations,
            "Hardware Performance Monitor registers are not implemented and "
            "hardwired to zero."
        );

        if(cfg->arch&ISA_S) {
            vmidocAddText(
                Limitations,
                "The TLB is architecturally-accurate but not device accurate. "
                "This means that all TLB maintenance and address translation "
                "operations are fully implemented but the cache is larger than "
                "in the real device."
            );
        }

        // add custom restrictions if required
        addOptDoc(riscv, Limitations, cfg->restrictionsCB);

        // add extension-specific restrictions if required
        ITER_EXT_CB(
            riscv, extCB, restrictionsCB,
            extCB->restrictionsCB(riscv, Limitations, extCB->clientData);
        )
    }

    ////////////////////////////////////////////////////////////////////////////
    // VERIFICATION
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP Verification = vmidocAddSection(Root, "Verification");

        vmidocAddText(
            Verification,
            "All instructions have been extensively tested by Imperas, "
            "using tests generated specifically for this model and also "
            "reference tests from https://github.com/riscv/riscv-tests."
        );
        vmidocAddText(
            Verification,
            "Also reference tests have been used from various sources including:"
        );
        vmidocAddText(
            Verification,
            "https://github.com/riscv/riscv-tests"
        );
        vmidocAddText(
           Verification,
            "https://github.com/ucb-bar/riscv-torture"
        );
        vmidocAddText(
            Verification,
            "The Imperas OVPsim RISC-V models are used in the RISC-V "
            "Foundation Compliance Framework as a functional Golden Reference:"
        );
        vmidocAddText(
            Verification,
            "https://github.com/riscv/riscv-compliance"
        );
        vmidocAddText(
            Verification,
            "where the simulated model is used to provide the reference "
            "signatures for compliance testing.  The Imperas OVPsim RISC-V "
            "models are used as reference in both open source and commercial "
            "instruction stream test generators for hardware design "
            "verification, for example:"
        );
        vmidocAddText(
            Verification,
            "http://valtrix.in/sting from Valtrix"
        );
        vmidocAddText(
            Verification,
            "https://github.com/google/riscv-dv from Google"
        );
        vmidocAddText(
            Verification,
            "The Imperas OVPsim RISC-V models are also used by commercial and "
            "open source RISC-V Core RTL developers as a reference to ensure "
            "correct functionality of their IP."
        );
    }

    ////////////////////////////////////////////////////////////////////////////
    // REFERENCES
    ////////////////////////////////////////////////////////////////////////////

    {
        vmiDocNodeP References = vmidocAddSection(Root, "References");

        vmidocAddText(
            References,
            "The Model details are based upon the following specifications:"
        );

        snprintf(
            SNPRINTF_TGT(string),
            "RISC-V Instruction Set Manual, Volume I: "
            "User-Level ISA (%s)",
            riscvGetUserVersionDesc(riscv)
        );
        vmidocAddText(References, string);

        snprintf(
            SNPRINTF_TGT(string),
            "RISC-V Instruction Set Manual, Volume II: Privileged "
            "Architecture (%s)",
            riscvGetPrivVersionDesc(riscv)
        );
        vmidocAddText(References, string);

        if((cfg->arch&ISA_C) && RISCV_COMPRESS_VERSION(riscv)) {
            snprintf(
                SNPRINTF_TGT(string),
                "RISC-V \"C\" Compressed Extension (%s)",
                riscvGetCompressedVersionDesc(riscv)
            );
            vmidocAddText(References, string);
        }

        if(cfg->arch&ISA_B) {
            snprintf(
                SNPRINTF_TGT(string),
                "RISC-V \"B\" Bit Manipulation Extension (%s)",
                riscvGetBitManipVersionDesc(riscv)
            );
            vmidocAddText(References, string);
        }

        if(cfg->arch&ISA_H) {
            snprintf(
                SNPRINTF_TGT(string),
                "RISC-V \"H\" Hypervisor Extension (%s)",
                riscvGetHypervisorVersionDesc(riscv)
            );
            vmidocAddText(References, string);
        }

        if(cfg->arch&ISA_K) {
            snprintf(
                SNPRINTF_TGT(string),
                "RISC-V \"K\" Cryptographic Extension (%s)",
                riscvGetCryptographicVersionDesc(riscv)
            );
            vmidocAddText(References, string);
        }

        if(cfg->arch&ISA_P) {
            snprintf(
                SNPRINTF_TGT(string),
                "RISC-V \"P\" DSP Extension (%s)",
                riscvGetDSPVersionDesc(riscv)
            );
            vmidocAddText(References, string);
        }

        if(cfg->arch&ISA_V) {
            snprintf(
                SNPRINTF_TGT(string),
                "RISC-V \"V\" Vector Extension (%s)",
                riscvGetVectorVersionDesc(riscv)
            );
            vmidocAddText(References, string);
        }

        if(cfg->debug_mode || cfg->trigger_num) {
            snprintf(
                SNPRINTF_TGT(string),
                "RISC-V External Debug Support (%s)",
                riscvGetDebugVersionDesc(riscv)
            );
            vmidocAddText(References, string);
        }

        if(cfg->CLICLEVELS) {
            snprintf(
                SNPRINTF_TGT(string),
                "RISC-V Core-Local Interrupt Controller (%s)",
                riscvGetCLICVersionDesc(riscv)
            );
            vmidocAddText(References, string);
        }

        if(cfg->Smepmp_version) {
            snprintf(
                SNPRINTF_TGT(string),
                "RISC-V Enhancements for memory access and execution "
                "prevention on Machine mode (%s)",
                riscvGetSmepmpVersionName(riscv)
            );
            vmidocAddText(References, string);
        }

        // add custom references if required
        addOptDocList(References, cfg->specificDocs);
    }

    return Root;
}

//
// Emit documentation for an AMP cluster
//
static vmiDocNodeP docAMP(riscvP ampRoot) {

    vmiDocNodeP  Root     = vmidocAddSection(0, "Root");
    vmiDocNodeP  desc     = vmidocAddSection(Root, "Description");
    Uns32        numAMP   = riscvGetClusterNumMembers(ampRoot);
    const char **variants = riscvGetClusterMembers(ampRoot);
    char         string[1024];

    ////////////////////////////////////////////////////////////////////////////
    // DESCRIPTION
    ////////////////////////////////////////////////////////////////////////////

    static const char *sepText[]  = {", ", " and "};
    static const char *sepParam[] = {",", ","};
    char               clusterText [concatLength(variants, sepText,  numAMP)];
    char               clusterParam[concatLength(variants, sepParam, numAMP)];
    snprintf(
        SNPRINTF_TGT(string),
        "This model implements an AMP RISC-V system containing %s members, but "
        "this can be changed using parameter \"clusterVariants\". This "
        "parameter is a comma-separated list of cluster components (e.g. "
        "\"%s\").",
        concat(clusterText,  variants, sepText,  numAMP),
        concat(clusterParam, variants, sepParam, numAMP)
    );
    vmidocAddText(desc, string);

    ////////////////////////////////////////////////////////////////////////////
    // LICENSING
    ////////////////////////////////////////////////////////////////////////////

    vmiDocNodeP lic = vmidocAddSection(Root, "Licensing");

    // refer to cluster documentation for details
    vmidocAddText(
        lic,
        "This document describes the interface to the MultiCluster only. "
        "Refer to documentation of individual clusters for information "
        "regarding implemented features, licensing and limitations."
    );

    ////////////////////////////////////////////////////////////////////////////
    // CLIC
    ////////////////////////////////////////////////////////////////////////////

    docCLIC(ampRoot, Root);

    ////////////////////////////////////////////////////////////////////////////
    // CLINT
    ////////////////////////////////////////////////////////////////////////////

    docCLINT(ampRoot, Root);

    return Root;
}

//
// Create processor documentation
//
VMI_DOC_FN(riscvDoc) {

    // only document from root level
    if(!vmirtGetSMPParent(processor)) {

        riscvP      riscv = (riscvP)processor;
        vmiDocNodeP root;

        // emit AMP or SMP variants
        if(riscvIsCluster(riscv)) {
            root = docAMP(riscv);
        } else {
            root = docSMP(riscv);
        }

        // add documenation to root
        vmidocProcessor(processor, root);
    }
}

