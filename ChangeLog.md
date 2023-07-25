# Imperas test framework Change Log

Copyright (c) 2005-2023 Imperas Software Ltd., www.imperas.com 

This CHANGELOG contains information for the Imperas RISC-V test framework and tests. 

See the ChangeLog.md files in the simulator directories for their changes. 

---
Date 2023-June-26
Release 20230626.0 

Added new test suites for the Zicsr instructions making use of the mscratch CSR. These tests are for the instructions and not the CSRs themselves.

---
Date 2023-March-01 
Release 20230228.0 

- zvkb is complete with all assertion checks passing.
- zvkg is complete but currently disabled, as the toolchain does not support the latest specification. Previous (lone) instruction (vghmac.vv) was removed from spec and two new instructions added.
- All other zvk* tests are added and passing, but with assertions disabled.  Will wait for a more finalized spec and other supporting libraries/examples before implementing assertions and computing of values.
- Removing existing fp16 (SEW==16) from vector tests and adding as separate extensions.

---
Date 2022-May-30 
Release 20220527.0 

As a service to our users we have now included the RISC-V International Architectural Compliance Tests as test suites.

This includes:
  rv32e_m-RVI/C rv32e_m-RVI/E rv32e_m-RVI/M
  rv32i_m-RVI/C rv32i_m-RVI/F rv32i_m-RVI/I rv32i_m-RVI/K rv32i_m-RVI/M rv32i_m-RVI/Zifencei rv32i_m-RVI/privM 
  rv64i_m-RVI/C rv64i_m-RVI/D rv64i_m-RVI/I rv64i_m-RVI/K rv64i_m-RVI/M rv64i_m-RVI/Zifencei rv64i_m-RVI/privM

Added new test suites for RV32E, RV32EM, RV32EC
These are for version 1.9

---
Date 2022-April-22 
Release 20220421.0 

Additional PMP tests and updates.

---
Date 2022-March-10 
Release 20220310.0 

The initial release of the privilege ISA PMP test suites is now available.
This requires a commercial license and like the vector ISA tests suites
is configured to the users target device. The suites are targeted at:
RV32 priv. versions 1.11, 1.12 (inc. Smepmp)
RV64 priv. versions 1.11, 1.12 (inc. Smepmp)
Contact info@imperas.com for more information.

---
Date 2021-November-16
Release 20211018.0

This release includes some refactorization to support multiple versions.
Current default versions for extensions are:

| Instructions            | Extension | Version |
|:----------------------- |:---------:|:------- | 
| Base instructions       | IMC       | v2.1    |
| Floating Point          |  FD       | v2.2    |
| Bitmanip                |   B       | v1.0.0  |
| Crypto                  |   K       | v1.0.0  |
| Vector XLEN=32 VLEN=256 |   V       | v1.0    |
| SIMD/DSP                |   P       | v0.5.2  |

If you need different extension versions for your current RTL - or require
a different configuration for the Vector tests, please contact info@imperas.com

---
Date 2021-July-02
Release 20210701.0
First release of P-DSP (v0.5.2) architectural tests

---
Date 2021-June-29
Release 20210628.0
Change to support structure v0.2 of the RISC-V Compliance framework

---
Date 2021-February-19
Release 20210218.0
Updates for vector specification

---
Date 2021-February-03
Release 20210202.0
Update of F, D, B and K architectural tests

---
Date 2021-January-08
Release 20210108.0
First release of F and D Single- and Double-Precision Floating Point architectural tests

---
Date 2020-December-12
Release 20201212.0
First release of B-bitmanip and K-crypto architectural tests

---
Date 2020-October-14
Release 20201014.0
First public release of initial test suites


