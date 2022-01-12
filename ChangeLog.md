# Imperas test framework Change Log

Copyright (c) 2005-2021 Imperas Software Ltd., www.imperas.com

This CHANGELOG contains information for the Imperas RISC-V test framework and tests.

See the ChangeLog.md files in the simulator directories for their changes.

---
Date 2022-January-12
Release 20220111.0


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

Date 2021-July-02
Release 20210701.0
First release of P-DSP (v0.5.2) architectural tests

Date 2021-June-29
Release 20210628.0
Change to support structure v0.2 of the RISC-V Compliance framework

Date 2021-February-19
Release 20210218.0
Updates for vector specification

Date 2021-February-03
Release 20210202.0
Update of F, D, B and K architectural tests

Date 2021-January-08
Release 20210108.0
First release of F and D Single- and Double-Precision Floating Point architectural tests

Date 2020-December-12
Release 20201212.0
First release of B-bitmanip and K-crypto architectural tests

Date 2020-October-14
Release 20201014.0
First public release of initial test suites


