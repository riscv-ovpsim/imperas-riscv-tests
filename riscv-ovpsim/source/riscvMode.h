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
// Execution mode
//
typedef enum {

    // normal modes - correspond to encoding of mstatus MPP field
    RISCV_MODE_USER       = 0,
    RISCV_MODE_U          = RISCV_MODE_USER,
    RISCV_MODE_SUPERVISOR = 1,
    RISCV_MODE_S          = RISCV_MODE_SUPERVISOR,
    RISCV_MODE_HYPERVISOR = 2,
    RISCV_MODE_H          = RISCV_MODE_HYPERVISOR,
    RISCV_MODE_MACHINE    = 3,
    RISCV_MODE_M          = RISCV_MODE_MACHINE,

    // for sizing (last base mode)
    RISCV_MODE_LAST_BASE,

    // virtual modes
    RISCV_MODE_V          = RISCV_MODE_LAST_BASE,
    RISCV_MODE_VU         = (RISCV_MODE_V+RISCV_MODE_U),
    RISCV_MODE_VS         = (RISCV_MODE_V+RISCV_MODE_S),

    // for sizing (last mode)
    RISCV_MODE_LAST,

    // debug pseudo-mode
    RISCV_MODE_D          = RISCV_MODE_LAST,

} riscvMode;

//
// Virtual memory mode
//
typedef enum {

    // non-virtualized modes
    RISCV_VMMODE_U = 0,
    RISCV_VMMODE_S = 1,

    // virtualized modes
    RISCV_VMMODE_V  = 0x2,
    RISCV_VMMODE_VU = (RISCV_VMMODE_V|RISCV_VMMODE_U),
    RISCV_VMMODE_VS = (RISCV_VMMODE_V|RISCV_VMMODE_S),

    // KEEP LAST: for sizing
    RISCV_VMMODE_LAST

} riscvVMMode;

//
// Dictionary mode - simulation artifact mode, including virtual memory and
// virtualization enabled status
//
typedef enum {

    RISCV_DMODE_64    = 0x1,   // 64-bit XLEN enabled
    RISCV_DMODE_VM    = 0x4,   // Virtual memory enabled
    RISCV_DMODE_V     = 0x8,   // Virtualization enabled

    // 32-bit User modes
    RISCV_DMODE32_U     = 0x0,
    RISCV_DMODE32_U_VM  = (RISCV_DMODE32_U|RISCV_DMODE_VM              ),
    RISCV_DMODE32_VU    = (RISCV_DMODE32_U               |RISCV_DMODE_V),
    RISCV_DMODE32_VU_VM = (RISCV_DMODE32_U|RISCV_DMODE_VM|RISCV_DMODE_V),

    // 64-bit User modes
    RISCV_DMODE64_U     = (RISCV_DMODE32_U    |RISCV_DMODE_64),
    RISCV_DMODE64_U_VM  = (RISCV_DMODE32_U_VM |RISCV_DMODE_64),
    RISCV_DMODE64_VU    = (RISCV_DMODE32_VU   |RISCV_DMODE_64),
    RISCV_DMODE64_VU_VM = (RISCV_DMODE32_VU_VM|RISCV_DMODE_64),

    // 32-bit Supervisor modes
    RISCV_DMODE32_S     = 0x2,
    RISCV_DMODE32_S_VM  = (RISCV_DMODE32_S|RISCV_DMODE_VM),
    RISCV_DMODE32_VS    = (RISCV_DMODE32_S               |RISCV_DMODE_V),
    RISCV_DMODE32_VS_VM = (RISCV_DMODE32_S|RISCV_DMODE_VM|RISCV_DMODE_V),

    // 64-bit Supervisor modes
    RISCV_DMODE64_S     = (RISCV_DMODE32_S    |RISCV_DMODE_64),
    RISCV_DMODE64_S_VM  = (RISCV_DMODE32_S_VM |RISCV_DMODE_64),
    RISCV_DMODE64_VS    = (RISCV_DMODE32_VS   |RISCV_DMODE_64),
    RISCV_DMODE64_VS_VM = (RISCV_DMODE32_VS_VM|RISCV_DMODE_64),

    // 32-bit Machine mode
    RISCV_DMODE32_M     = 0x10,

    // 64-bit Machine mode
    RISCV_DMODE64_M     = (RISCV_DMODE32_M|RISCV_DMODE_64),

    // KEEP LAST: for sizing
    RISCV_DMODE_LAST

} riscvDMode;

//
// Return base mode for the given mode
//
inline static riscvMode getBaseMode(riscvMode mode) {
    return mode & RISCV_MODE_M;
}

//
// Map riscvDMode to riscvVMMode
//
inline static riscvVMMode dmodeToVMMode(riscvDMode dMode) {

    static const riscvVMMode map[] = {

        // 32-bit User modes
        [RISCV_DMODE32_U]     = RISCV_VMMODE_LAST,
        [RISCV_DMODE32_U_VM]  = RISCV_VMMODE_U,
        [RISCV_DMODE32_VU]    = RISCV_VMMODE_LAST,
        [RISCV_DMODE32_VU_VM] = RISCV_VMMODE_VU,

        // 64-bit User modes
        [RISCV_DMODE64_U]     = RISCV_VMMODE_LAST,
        [RISCV_DMODE64_U_VM]  = RISCV_VMMODE_U,
        [RISCV_DMODE64_VU]    = RISCV_VMMODE_LAST,
        [RISCV_DMODE64_VU_VM] = RISCV_VMMODE_VU,

        // 32-bit Supervisor modes
        [RISCV_DMODE32_S]     = RISCV_VMMODE_LAST,
        [RISCV_DMODE32_S_VM]  = RISCV_VMMODE_S,
        [RISCV_DMODE32_VS]    = RISCV_VMMODE_LAST,
        [RISCV_DMODE32_VS_VM] = RISCV_VMMODE_VS,

        // 64-bit Supervisor modes
        [RISCV_DMODE64_S]     = RISCV_VMMODE_LAST,
        [RISCV_DMODE64_S_VM]  = RISCV_VMMODE_S,
        [RISCV_DMODE64_VS]    = RISCV_VMMODE_LAST,
        [RISCV_DMODE64_VS_VM] = RISCV_VMMODE_VS,

        // 32-bit Machine mode
        [RISCV_DMODE32_M]     = RISCV_VMMODE_LAST,

        // 64-bit Machine mode
        [RISCV_DMODE64_M]     = RISCV_VMMODE_LAST,
    };

    return map[dMode];
}

//
// Map riscvVMMode to riscvMode
//
inline static riscvMode vmmodeToMode(riscvVMMode vmMode) {

    static const riscvMode map[] = {

        // User modes
        [RISCV_VMMODE_U]    = RISCV_MODE_U,
        [RISCV_VMMODE_VU]   = RISCV_MODE_VU,

        // Supervisor modes
        [RISCV_VMMODE_S]    = RISCV_MODE_S,
        [RISCV_VMMODE_VS]   = RISCV_MODE_VS,

        // other modes
        [RISCV_VMMODE_LAST] = RISCV_MODE_LAST,
    };

    return map[vmMode];
}

//
// Map riscvMode to riscvVMMode
//
inline static riscvVMMode modeToVMMode(riscvMode mode) {

    static const riscvVMMode map[] = {

        // normal modes
        [RISCV_MODE_U]  = RISCV_VMMODE_U,
        [RISCV_MODE_S]  = RISCV_VMMODE_S,
        [RISCV_MODE_H]  = RISCV_VMMODE_LAST,
        [RISCV_MODE_M]  = RISCV_VMMODE_LAST,

        // virtualized modes
        [RISCV_MODE_VU] = RISCV_VMMODE_VU,
        [RISCV_MODE_VS] = RISCV_VMMODE_VS,
    };

    return map[mode];
}

//
// Map riscvMode to riscvDMode
//
inline static riscvDMode modeToDMode(riscvMode mode, Bool xlen64) {

    static const riscvDMode map[][2] = {

        // 32-bit normal modes
        [RISCV_MODE_U]  = {RISCV_DMODE32_U,  RISCV_DMODE64_U },
        [RISCV_MODE_S]  = {RISCV_DMODE32_S,  RISCV_DMODE64_S },
        [RISCV_MODE_H]  = {RISCV_DMODE_LAST, RISCV_DMODE_LAST},
        [RISCV_MODE_M]  = {RISCV_DMODE32_M,  RISCV_DMODE64_M },

        // 32-bit virtualized modes
        [RISCV_MODE_VU] = {RISCV_DMODE32_VU, RISCV_DMODE64_VU},
        [RISCV_MODE_VS] = {RISCV_DMODE32_VS, RISCV_DMODE64_VS}
    };

    return map[mode][xlen64];
}

//
// Map riscvDMode to 5-state riscvMode (M, HS, HU, VS or VU)
//
inline static riscvMode dmodeToMode5(riscvDMode dMode) {

    static const riscvMode map[] = {

        // 32-bit User modes
        [RISCV_DMODE32_U]     = RISCV_MODE_U,
        [RISCV_DMODE32_U_VM]  = RISCV_MODE_U,
        [RISCV_DMODE32_VU]    = RISCV_MODE_VU,
        [RISCV_DMODE32_VU_VM] = RISCV_MODE_VU,

        // 64-bit User modes
        [RISCV_DMODE64_U]     = RISCV_MODE_U,
        [RISCV_DMODE64_U_VM]  = RISCV_MODE_U,
        [RISCV_DMODE64_VU]    = RISCV_MODE_VU,
        [RISCV_DMODE64_VU_VM] = RISCV_MODE_VU,

        // 32-bit Supervisor modes
        [RISCV_DMODE32_S]     = RISCV_MODE_S,
        [RISCV_DMODE32_S_VM]  = RISCV_MODE_S,
        [RISCV_DMODE32_VS]    = RISCV_MODE_VS,
        [RISCV_DMODE32_VS_VM] = RISCV_MODE_VS,

        // 64-bit Supervisor modes
        [RISCV_DMODE64_S]     = RISCV_MODE_S,
        [RISCV_DMODE64_S_VM]  = RISCV_MODE_S,
        [RISCV_DMODE64_VS]    = RISCV_MODE_VS,
        [RISCV_DMODE64_VS_VM] = RISCV_MODE_VS,

        // 32-bit Machine mode
        [RISCV_DMODE32_M]     = RISCV_MODE_M,

        // 64-bit Machine mode
        [RISCV_DMODE64_M]     = RISCV_MODE_M,
    };

    return map[dMode];
}

//
// Map riscvDMode to 4-state riscvMode (M, H, S or U)
//
inline static riscvMode dmodeToMode4(riscvDMode dMode) {

    static const riscvMode map[] = {

        // 32-bit User modes
        [RISCV_DMODE32_U]     = RISCV_MODE_U,
        [RISCV_DMODE32_U_VM]  = RISCV_MODE_U,
        [RISCV_DMODE32_VU]    = RISCV_MODE_U,
        [RISCV_DMODE32_VU_VM] = RISCV_MODE_U,

        // 64-bit User modes
        [RISCV_DMODE64_U]     = RISCV_MODE_U,
        [RISCV_DMODE64_U_VM]  = RISCV_MODE_U,
        [RISCV_DMODE64_VU]    = RISCV_MODE_U,
        [RISCV_DMODE64_VU_VM] = RISCV_MODE_U,

        // 32-bit Supervisor modes
        [RISCV_DMODE32_S]     = RISCV_MODE_H,
        [RISCV_DMODE32_S_VM]  = RISCV_MODE_H,
        [RISCV_DMODE32_VS]    = RISCV_MODE_S,
        [RISCV_DMODE32_VS_VM] = RISCV_MODE_S,

        // 64-bit Supervisor modes
        [RISCV_DMODE64_S]     = RISCV_MODE_H,
        [RISCV_DMODE64_S_VM]  = RISCV_MODE_H,
        [RISCV_DMODE64_VS]    = RISCV_MODE_S,
        [RISCV_DMODE64_VS_VM] = RISCV_MODE_S,

        // 32-bit Machine mode
        [RISCV_DMODE32_M]     = RISCV_MODE_M,

        // 64-bit Machine mode
        [RISCV_DMODE64_M]     = RISCV_MODE_M,
    };

    return map[dMode];
}

//
// Map riscvDMode to 3-state riscvMode (M, S or U)
//
inline static riscvMode dmodeToMode3(riscvDMode dMode) {

    static const riscvMode map[] = {

        // 32-bit User modes
        [RISCV_DMODE32_U]     = RISCV_MODE_U,
        [RISCV_DMODE32_U_VM]  = RISCV_MODE_U,
        [RISCV_DMODE32_VU]    = RISCV_MODE_U,
        [RISCV_DMODE32_VU_VM] = RISCV_MODE_U,

        // 64-bit User modes
        [RISCV_DMODE64_U]     = RISCV_MODE_U,
        [RISCV_DMODE64_U_VM]  = RISCV_MODE_U,
        [RISCV_DMODE64_VU]    = RISCV_MODE_U,
        [RISCV_DMODE64_VU_VM] = RISCV_MODE_U,

        // 32-bit Supervisor modes
        [RISCV_DMODE32_S]     = RISCV_MODE_S,
        [RISCV_DMODE32_S_VM]  = RISCV_MODE_S,
        [RISCV_DMODE32_VS]    = RISCV_MODE_S,
        [RISCV_DMODE32_VS_VM] = RISCV_MODE_S,

        // 64-bit Supervisor modes
        [RISCV_DMODE64_S]     = RISCV_MODE_S,
        [RISCV_DMODE64_S_VM]  = RISCV_MODE_S,
        [RISCV_DMODE64_VS]    = RISCV_MODE_S,
        [RISCV_DMODE64_VS_VM] = RISCV_MODE_S,

        // 32-bit Machine modes
        [RISCV_DMODE32_M]     = RISCV_MODE_M,

        // 64-bit Machine modes
        [RISCV_DMODE64_M]     = RISCV_MODE_M,
    };

    return map[dMode];
}

//
// Is the mode a virtualized mode?
//
inline static Bool modeIsVirtual(riscvMode mode) {
    return (mode>=RISCV_MODE_V) && (mode<RISCV_MODE_LAST);
}

//
// Return Supervisor mode for the given mode
//
inline static riscvMode getSMode(riscvMode mode) {
    return modeIsVirtual(mode) ? RISCV_MODE_VS : RISCV_MODE_S;
}

//
// Is the dictionary mode a 32-bit mode?
//
inline static Bool dmodeIsXLEN64(riscvDMode dMode) {
    return dMode&RISCV_DMODE_64;
}

//
// Is the dictionary mode a virtual memory mode?
//
inline static Bool dmodeIsVM(riscvDMode dMode) {
    return dMode&RISCV_DMODE_VM;
}

//
// Is the dictionary mode a virtualized mode?
//
inline static Bool dmodeIsVirtual(riscvDMode dMode) {
    return dMode&RISCV_DMODE_V;
}

//
// Get XLEN for the given dictionary mode
//
inline static Uns32 dmodeToXLEN(riscvDMode dMode) {
    return dmodeIsXLEN64(dMode) ? 64 : 32;
}

//
// Return priority of 5-state riscvMode
//
inline static Uns8 mode5Priority(riscvMode mode5) {

    static const Uns8 map[] = {

        // normal modes (higher priority)
        [RISCV_MODE_U]  = 3,
        [RISCV_MODE_S]  = 4,
        [RISCV_MODE_M]  = 5,

        // virtualized modes (lower priority)
        [RISCV_MODE_VU] = 1,
        [RISCV_MODE_VS] = 2,
    };

    return map[mode5];
}


