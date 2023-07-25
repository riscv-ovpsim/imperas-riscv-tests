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

//
// These are placeholders in disassembly decoder
//
#define EMIT_R1         '\001'
#define EMIT_R2         '\002'
#define EMIT_R2NC       '\003'
#define EMIT_R3         '\004'
#define EMIT_R4         '\005'
#define EMIT_CS         '\006'
#define EMIT_CX         '\007'
#define EMIT_CF         '\010'
#define EMIT_UI         '\011'
#define EMIT_TGT        '\012'
#define EMIT_CSR        '\013'
#define EMIT_PRED       '\014'
#define EMIT_SUCC       '\015'
#define EMIT_VTYPE      '\016'
#define EMIT_RM         '\017'
#define EMIT_RMR        '\020'
#define EMIT_RLIST      '\021'
#define EMIT_ALIST      '\022'
#define EMIT_RETVAL     '\023'

//
// These are placeholders in disassembly format strings
//
#define EMIT_R1_S       "\001"
#define EMIT_R2_S       "\002"
#define EMIT_R2NC_S     "\003"
#define EMIT_R3_S       "\004"
#define EMIT_R4_S       "\005"
#define EMIT_CS_S       "\006"
#define EMIT_CX_S       "\007"
#define EMIT_CF_S       "\010"
#define EMIT_UI_S       "\011"
#define EMIT_TGT_S      "\012"
#define EMIT_CSR_S      "\013"
#define EMIT_PRED_S     "\014"
#define EMIT_SUCC_S     "\015"
#define EMIT_VTYPE_S    "\016"
#define EMIT_RM_S       "\017"
#define EMIT_RMR_S      "\020"
#define EMIT_RLIST_S    "\021"
#define EMIT_ALIST_S    "\022"
#define EMIT_RETVAL_S   "\023"

//
// These are disassembly format strings
//
#define FMT_NONE                ""
#define FMT_SIMM                EMIT_CS_S
#define FMT_R1                  EMIT_R1_S
#define FMT_R1_R2               EMIT_R1_S "," EMIT_R2_S
#define FMT_R1_R2NC             EMIT_R1_S "," EMIT_R2NC_S
#define FMT_R3_R4               EMIT_R3_S "," EMIT_R4_S
#define FMT_R1NZ_R2             "*" EMIT_R1_S "," EMIT_R2_S
#define FMT_R1_SIMM             EMIT_R1_S "," EMIT_CS_S
#define FMT_R1_FIMM             EMIT_R1_S "," EMIT_CF_S
#define FMT_R1_R3               EMIT_R1_S "," EMIT_R3_S
#define FMT_R1_R2_R3            EMIT_R1_S "," EMIT_R2_S "," EMIT_R3_S
#define FMT_R1_R2NC_R3          EMIT_R1_S "," EMIT_R2NC_S "," EMIT_R3_S
#define FMT_R1_R2_RMR           EMIT_R1_S "," EMIT_R2_S "," EMIT_RMR_S
#define FMT_R1_R2_R3_R4         EMIT_R1_S "," EMIT_R2_S "," EMIT_R3_S "," EMIT_R4_S
#define FMT_R1_R2_R3_RMR        EMIT_R1_S "," EMIT_R2_S "," EMIT_R3_S "," EMIT_RMR_S
#define FMT_R1_R2_SIMM          EMIT_R1_S "," EMIT_R2_S "," EMIT_CS_S
#define FMT_R1_R2NC_SIMM        EMIT_R1_S "," EMIT_R2NC_S "," EMIT_CS_S
#define FMT_R1_R3_SIMM          EMIT_R1_S "," EMIT_R3_S "," EMIT_CS_S
#define FMT_R1_R2_R3_SIMM       EMIT_R1_S "," EMIT_R2_S "," EMIT_R3_S "," EMIT_CS_S
#define FMT_R1_R2_XIMM          EMIT_R1_S "," EMIT_R2_S "," EMIT_CX_S
#define FMT_R1_R2NC_XIMM        EMIT_R1_S "," EMIT_R2NC_S "," EMIT_CX_S
#define FMT_R1_R2_TGT           EMIT_R1_S "," EMIT_R2_S "," EMIT_TGT_S
#define FMT_R1_SIMM_TGT         EMIT_R1_S "," EMIT_CS_S "," EMIT_TGT_S
#define FMT_R1_R2_VTYPE         EMIT_R1_S "," EMIT_R2_S "," EMIT_VTYPE_S
#define FMT_R1_SIMM_VTYPE       EMIT_R1_S "," EMIT_CS_S "," EMIT_VTYPE_S
#define FMT_R1_MEM2             EMIT_R1_S ",(" EMIT_R2_S ")"
#define FMT_R1_MEM2_RM          EMIT_R1_S ",(" EMIT_R2_S ")," EMIT_RM_S
#define FMT_R1_MEM2_R3_RM       EMIT_R1_S ",(" EMIT_R2_S ")," EMIT_R3_S "," EMIT_RM_S
#define FMT_R1_MEM2_R3_R4_RM    EMIT_R1_S ",(" EMIT_R2_S ")," EMIT_R3_S "," EMIT_R4_S "," EMIT_RM_S
#define FMT_R1_RM               EMIT_R1_S "," EMIT_RM_S
#define FMT_R1_R2_RM            EMIT_R1_S "," EMIT_R2_S "," EMIT_RM_S
#define FMT_R1_R2_R3_RM         EMIT_R1_S "," EMIT_R2_S "," EMIT_R3_S "," EMIT_RM_S
#define FMT_R1_R2_SIMM_RM       EMIT_R1_S "," EMIT_R2_S "," EMIT_CS_S "," EMIT_RM_S
#define FMT_R1_R2_SIMM_RMR      EMIT_R1_S "," EMIT_R2_S "," EMIT_CS_S "," EMIT_RMR_S
#define FMT_R1_R2_XIMM_RM       EMIT_R1_S "," EMIT_R2_S "," EMIT_CX_S "," EMIT_RM_S
#define FMT_R1_R2_MEM3          EMIT_R1_S "," EMIT_R2_S ",(" EMIT_R3_S ")"
#define FMT_R1_OFF_R2           EMIT_R1_S "," EMIT_CS_S "(" EMIT_R2_S ")"
#define FMT_OFF_R1              EMIT_CS_S "(" EMIT_R1_S ")"
#define FMT_OFF_R2              EMIT_CS_S "(" EMIT_R2_S ")"
#define FMT_R2                  EMIT_R2_S
#define FMT_R1_UI               EMIT_R1_S "," EMIT_UI_S
#define FMT_R1_CSR              EMIT_R1_S "," EMIT_CSR_S
#define FMT_R1_CSR_R2           EMIT_R1_S "," EMIT_CSR_S "," EMIT_R2_S
#define FMT_R1_CSR_SIMM         EMIT_R1_S "," EMIT_CSR_S "," EMIT_CS_S
#define FMT_CSR_R2              EMIT_CSR_S "," EMIT_R2_S
#define FMT_CSR_SIMM            EMIT_CSR_S "," EMIT_CS_S
#define FMT_R1_TGT              EMIT_R1_S "," EMIT_TGT_S
#define FMT_R2_TGT              EMIT_R2_S "," EMIT_TGT_S
#define FMT_R1_SIMM_TGT         EMIT_R1_S "," EMIT_CS_S "," EMIT_TGT_S
#define FMT_TGT                 EMIT_TGT_S
#define FMT_PRED_SUCC           EMIT_PRED_S "," EMIT_SUCC_S
#define FMT_RLIST_SIMM          EMIT_RLIST_S "," EMIT_CS_S
#define FMT_RLIST_RETVAL_SIMM   EMIT_RLIST_S "," EMIT_RETVAL_S "," EMIT_CS_S
#define FMT_RLIST_ALIST_SIMM    EMIT_RLIST_S "," EMIT_ALIST_S "," EMIT_CS_S


