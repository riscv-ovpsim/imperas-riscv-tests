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
#include <string.h>

// Imperas header files
#include "hostapi/impAlloc.h"

// VMI header files
#include "vmi/vmiCxt.h"
#include "vmi/vmiRt.h"
#include "vmi/vmiMessage.h"

// model header files
#include "riscvCluster.h"
#include "riscvStructure.h"
#include "riscvVariant.h"

//
// Prefix for messages from this module
//
#define CPU_PREFIX "RISCV_CLUSTER"


////////////////////////////////////////////////////////////////////////////////
// SMP UTILITIES
////////////////////////////////////////////////////////////////////////////////

//
// Return any parent of the passed processor
//
inline static riscvP getParent(riscvP riscv) {
    return (riscvP)vmirtGetSMPParent((vmiProcessorP)riscv);
}

//
// Get the SMP index of the passed processor
//
inline static Uns32 getSMPIndex(riscvP riscv) {
    return vmirtGetSMPIndex((vmiProcessorP)riscv);
}


////////////////////////////////////////////////////////////////////////////////
// PUBLIC FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

//
// Is the processor a cluster-level object?
//
Bool riscvIsCluster(riscvP riscv) {
    return riscv->configInfo.members;
}

//
// Is the processor a cluster-member-level object?
//
Bool riscvIsClusterMember(riscvP riscv) {
    riscvP parent = getParent(riscv);
    return parent && riscvIsCluster(parent);
}

//
// Return the processor variant to use for the given member of an AMP cluster
//
const char *riscvGetMemberVariant(riscvP member) {
    riscvP cluster = getParent(member);
    return cluster->configInfo.members[getSMPIndex(member)];
}

//
// Return the numHarts override to use for the given member of an AMP cluster
//
Uns32 riscvGetMemberNumHarts(riscvP member) {
    riscvP cluster = getParent(member);
    return cluster->memberNumHarts[getSMPIndex(member)];
}

//
// If this is a cluster variant, return the members
//
const char **riscvGetClusterMembers(riscvP riscv) {
    return riscv->configInfo.members;
}

//
// If this is a cluster variant, return the number of members
//
Uns32 riscvGetClusterNumMembers(riscvP riscv) {

    const char **members = riscv->configInfo.members;
    Uns32        max     = riscv->configInfo.numHarts ? : -1;
    Uns32        result  = 0;

    // if numHarts is specified, this is a maximum number of members; otherwise,
    // the list of members is assumed to be zero-terminated
    if(members) {
        while((result<max) && members[result]) {
            result++;
        }
    }

    return result;
}

//
// Create comma-separated list of variants from cluster list
//
const char *riscvNewClusterVariantString(riscvP riscv) {

    Uns32 numMembers = riscvGetClusterNumMembers(riscv);
    char *result     = 0;

    if(numMembers) {

        const char **members    = riscvGetClusterMembers(riscv);
        Uns32        membersLen = 0;
        Uns32        i;

        // get required size of members string - note each element is either
        // followed by a comma or zero (string terminator)
        for(i=0; i<numMembers; i++) {
            membersLen += strlen(members[i])+1;
        }

        // allocate string to hold comma-separated members string
        result = STYPE_CALLOC_N(char, membersLen);

        // assemble members string
        for(i=0; i<numMembers; i++) {
            if(i) {strcat(result, ",");}
            strcat(result, members[i]);
        }
    }

    return result;
}

//
// Parse the variant name if it is of the form 'base'x'numHarts', filling
// baseP with the base and returning numHarts
//
static Uns32 parseHartNum(const char *variant, char *baseP) {

    Int32 index   = strlen(variant)-1;
    Uns32 hartNum = 0;
    Uns32 result  = 0;
    Uns32 scale   = 1;
    Bool  hasNum  = False;

    while(index>0) {

        char ch = variant[index];

        if((ch>='0') && (ch<='9')) {

            // accumulate trailing hartNum
            hasNum   = True;
            hartNum += (ch-'0')*scale;
            scale   *= 10;
            index--;

        } else {

            // handle trailing hartNum if required
            if((ch=='x') && hasNum) {
                memcpy(baseP, variant, index);
                baseP[index] = 0;
                result       = hartNum;
            }

            // terminate loop
            index = 0;
        }
    }

    return result;
}

//
// Allocate cluster variant string table
//
void riscvNewClusterVariants(riscvP cluster, const char *clusterVariants) {

    Uns32 numVariants = 0;
    Uns32 i, j;
    char  ch;
    char  tmp[strlen(clusterVariants)+1];

    // copy given variants to temporary buffer, stripping whitespace characters
    // and replacing commas with zeros (to tokenize the string)
    for(i=0, j=0; (ch=clusterVariants[i]); i++) {

        switch(ch) {

            case ' ':
            case '\t':
                // strip whitespace
                break;

            case ',':
                // replace ',' with zero, suppressing null entries
                if(j && tmp[j-1]) {
                    tmp[j++] = 0;
                    numVariants++;
                }
                break;

            default:
                // copy character to result string
                tmp[j++] = ch;
                break;
        }
    }

    // terminate last token
    if(j && tmp[j-1]) {
        tmp[j++] = 0;
        numVariants++;
    }

    if(!numVariants) {

        vmiMessage("F", CPU_PREFIX"_EVL",   // LCOV_EXCL_LINE
            "Member variant list for cluster processor is empty - please "
            "give a comma-separated list of member variants"
        );

    } else {

        riscvConfigCP cfgList = riscvGetConfigList(cluster);
        char         *buffer  = tmp;

        // allocate zero-terminated variant list
        cluster->configInfo.members = STYPE_CALLOC_N(const char *, numVariants+1);

        // allocate unique indices list for same-type members
        cluster->uniqueIndices = STYPE_CALLOC_N(Uns32, numVariants);

        // allocate hartNum override list for each member
        cluster->memberNumHarts = STYPE_CALLOC_N(Uns32, numVariants);

        // allocate variant names
        for(i=0; i<numVariants; i++) {

            // get this variant name
            char *variant    = buffer;
            Uns32 variantLen = strlen(buffer);
            char  base[variantLen+1];
            Uns32 numHarts;

            // step buffer to next variant name
            buffer += (variantLen+1);

            // interpret argument as either plain variant or variant and
            // numHarts override
            if(riscvGetNamedConfig(cfgList, variant)) {

                // plain variant

            } else if(
                (numHarts=parseHartNum(variant, base)) &&
                riscvGetNamedConfig(cfgList, base)
            ) {
                // variant and numHarts override
                variant = base;
                cluster->memberNumHarts[i] = numHarts;

            } else {

                // bad member name
                vmiMessage("F", CPU_PREFIX"_VND",
                    "Variant '%s' not defined",
                    base
                );
            }

            // allocate name
            cluster->configInfo.members[i] = strdup(variant);
        }

        // assign unique indices for same-type members
        for(i=0; i<numVariants; i++) {

            Uns32 index = 0;
            Uns32 match = 0;

            for(j=0; j<numVariants; j++) {

                const char *member1 = cluster->configInfo.members[i];
                const char *member2 = cluster->configInfo.members[j];

                // no action unless strings match
                if(!strcmp(member1, member2)) {

                    // get index of match
                    if(i==j) {
                        index = match;
                    }

                    // increment match count
                    match++;
                }
            }

            // assign unique indices if there are multiple members of the same
            // type
            if(match>1) {
                cluster->uniqueIndices[i] = index+1;
            }
        }
    }

    // update number of variants
    cluster->configInfo.numHarts = numVariants;
}

//
// Free cluster variant list, if allocated
//
void riscvFreeClusterVariants(riscvP cluster) {

    // free clusterVariants string
    if(cluster->clusterVariants) {
        STYPE_FREE(cluster->clusterVariants);
        cluster->clusterVariants = 0;
    }

    // free unique indices for same-type members (for naming)
    if(cluster->uniqueIndices) {
        STYPE_FREE(cluster->uniqueIndices);
        cluster->uniqueIndices = 0;
    }

    // free unique indices for same-type members (for naming)
    if(cluster->memberNumHarts) {
        STYPE_FREE(cluster->memberNumHarts);
        cluster->memberNumHarts = 0;
    }

    // free cluster members list
    if(cluster->configInfo.members) {

        Uns32       i;
        const char *member;

        for(i=0; (member=cluster->configInfo.members[i]); i++) {
            STYPE_FREE(member);
        }

        STYPE_FREE(cluster->configInfo.members);
        cluster->configInfo.members = 0;
    }
}

