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

// Imperas header files
#include "hostapi/impTypes.h"

// model header files
#include "riscvTypeRefs.h"

//
// Is the processor a cluster-level object?
//
Bool riscvIsCluster(riscvP riscv);

//
// Is the processor a cluster-member-level object?
//
Bool riscvIsClusterMember(riscvP riscv);

//
// Return the processor variant to use for the given member of an AMP cluster
//
const char *riscvGetMemberVariant(riscvP member);

//
// Return the numHarts override to use for the given member of an AMP cluster
//
Uns32 riscvGetMemberNumHarts(riscvP member);

//
// If this is a cluster variant, return the members
//
const char **riscvGetClusterMembers(riscvP riscv);

//
// If this is a cluster variant, return the number of members
//
Uns32 riscvGetClusterNumMembers(riscvP riscv);

//
// Create comma-separated list of variants from cluster list
//
const char *riscvNewClusterVariantString(riscvP riscv);

//
// Allocate cluster variant string table
//
void riscvNewClusterVariants(riscvP cluster, const char *clusterVariants);

//
// Free cluster variant list, if allocated
//
void riscvFreeClusterVariants(riscvP cluster);

