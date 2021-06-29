# RISC-V Compliance Tests
#
#
# Copyright (c) 2021 Imperas Software Ltd., www.imperas.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
# either express or implied.
#
# See the License for the specific language governing permissions and
# limitations under the License.
#
#


| Instruction          | Subset          | Tested   | Assembly             | Type            | Flags(s)        | Description                                                   |
| -------------------- |:--------------- |:-------- |:-------------------- |:--------------- |:--------------- |:------------------------------------------------------------- |
| GETNOISE             | K,Zkr           | False    | getnoise             | R               |                 |  Noise Source Test                                            |
| POLLENTROPY          | K,Zkr           | False    | pollentropy          | R               |                 |  Poll Randomness                                              |
| AES32DSI             | K,Zkn           | True     | aes32dsi             | RI              | imm2            |  AES Decrypt SubBytes                                         |
| AES32DSMI            | K,Zkn           | True     | aes32dsmi            | RI              | imm2            |  AES Decrypt SubBytes and MixColumns                          |
| AES32ESI             | K,Zkn           | True     | aes32esi             | RI              | imm2            |  AES Encrypt SubBytes                                         |
| AES32ESMI            | K,Zkn           | True     | aes32esmi            | RI              | imm2            |  AES Encrypt SubBytes and MixColumns                          |
| AES64DS              | K,Zkn           | True     | aes64ds              | R               |                 |  AES Inverse SubBytes and ShiftRows transformation            |
| AES64DSM             | K,Zkn           | True     | aes64dsm             | R               |                 |  AES Inverse SubBytes, ShiftRows, MixColumns transformation   |
| AES64ES              | K,Zkn           | True     | aes64es              | R               |                 |  AES SubBytes and ShiftRows transformation                    |
| AES64ESM             | K,Zkn           | True     | aes64esm             | R               |                 |  AES SubBytes, ShiftRows, MixColumns transformation           |
| AES64IM              | K,Zkn           | True     | aes64im              | R1              |                 |  AES Inverse MixColumns transformation                        |
| AES64KS1I            | K,Zkn           | True     | aes64ks1i            | I               | rcon            |  AES Encrypt KeySchedule - rotate, SubBytes and Tound Constant |
| AES64KS2             | K,Zkn           | True     | aes64ks2             | R               |                 |  AES Encrypt KeySchedule: - XOR summation                     |
| SHA256SIG0           | K,Zkn           | True     | sha256sig0           | R1              |                 |  SHA256 hash function                                         |
| SHA256SIG1           | K,Zkn           | True     | sha256sig1           | R1              |                 |  SHA256 hash function                                         |
| SHA256SUM0           | K,Zkn           | True     | sha256sum0           | R1              |                 |  SHA256 hash function                                         |
| SHA256SUM1           | K,Zkn           | True     | sha256sum1           | R1              |                 |  SHA256 hash function                                         |
| SHA512SIG0           | K,Zkn           | True     | sha512sig0           | R1              |                 |  SHA256 hash function                                         |
| SHA512SIG0H          | K,Zkn           | True     | sha512sig0h          | R               |                 |  SHA512 hash function                                         |
| SHA512SIG0L          | K,Zkn           | True     | sha512sig0l          | R               |                 |  SHA512 hash function                                         |
| SHA512SIG1           | K,Zkn           | True     | sha512sig1           | R1              |                 |  SHA512 hash function                                         |
| SHA512SIG1H          | K,Zkn           | True     | sha512sig1h          | R               |                 |  SHA512 hash function                                         |
| SHA512SIG1L          | K,Zkn           | True     | sha512sig1l          | R               |                 |  SHA512 hash function                                         |
| SHA512SUM0           | K,Zkn           | True     | sha512sum0           | R1              |                 |  SHA512 hash function                                         |
| SHA512SUM0R          | K,Zkn           | True     | sha512sum0r          | R               |                 |  SHA512 hash function                                         |
| SHA512SUM1           | K,Zkn           | True     | sha512sum1           | R1              |                 |  SHA512 hash function                                         |
| SHA512SUM1R          | K,Zkn           | True     | sha512sum1r          | R               |                 |  SHA512 hash function                                         |
| SM3P0                | Zks             | True     | sm3p0                | R1              |                 |  SM3 Secure Hash function                                     |
| SM3P1                | Zks             | True     | sm3p1                | R1              |                 |  SM3 Secure Hash function                                     |
| SM4ED                | Zks             | True     | sm4ed                | RI              | imm2            |  SM4 Block cipher - encrypt/decrypt                           |
| SM4KS                | Zks             | True     | sm4ks                | RI              | imm2            |  SM4 Block cipher - KeySchedule                               |
| ROL                  | K,Zkn,Zks       | True     | rol                  | R               |                 |  Rotate Left                                                  |
| ROR                  | K,Zkn,Zks       | True     | ror                  | R               |                 |  Rotate Right                                                 |
| RORI                 | K,Zkn,Zks       | True     | rori                 | I               | imm5            |  Rotate Right, immediate                                      |
| ROLW                 | K,Zkn,Zks       | True     | rolw                 | R               |                 |  Rotate Left                                                  |
| RORIW                | K,Zkn,Zks       | True     | roriw                | I               | imm5            |  Rotate Right, immediate                                      |
| RORW                 | K,Zkn,Zks       | True     | rorw                 | R               |                 |  Rotate Right                                                 |
| REV-B                | K,Zkn,Zks       | True     | rev.b                | R1              |                 |  Reverse bits in bytes                                        |
| REV8                 | K,Zkn,Zks       | True     | rev8                 | R1              |                 |  Reverse Bytes in Word                                        |
| REV8-W               | K,Zkn,Zks       | True     | rev8.w               | R1              |                 |  Reverse Bytes in Word                                        |
| ZIP                  | K,Zkn,Zks       | True     | zip                  | R1              |                 |  Shuffle, immediate                                           |
| UNZIP                | K,Zkn,Zks       | True     | unzip                | R1              |                 |  Unshuffle, Immediate                                         |
| GORCI                | K,Zkn,Zks       | False    | gorci                | I               | imm3_4_7        |  Generalized OR-combine, immediate                            |
| CLMUL                | K,Zkn,Zks       | True     | clmul                | R               |                 |  Carry-Less Multiply, lower half of product                   |
| CLMULH               | K,Zkn,Zks       | True     | clmulh               | R               |                 |  Carry-Less Multiply, upper half of product                   |
| ANDN                 | K,Zkn,Zks       | True     | andn                 | R               |                 |  AND with rs inverted                                         |
| ORN                  | K,Zkn,Zks       | True     | orn                  | R               |                 |  OR with rs2 inverted                                         |
| XNOR                 | K,Zkn,Zks       | True     | xnor                 | R               |                 |  None                                                         |
| PACK                 | K,Zkn,Zks       | True     | pack                 | R               |                 |  Pack two words into one register, lower half of each         |
| PACKH                | K,Zkn,Zks       | True     | packh                | R               |                 |  Pack two words into one register, lower byte of each         |
| PACKU                | K,Zkn,Zks       | True     | packu                | R               |                 |  Pack two words into one register, upper half of each         |
| PACKUW               | K,Zkn,Zks       | True     | packuw               | R               |                 |  Pack two words into one register, upper half of each         |
| PACKW                | K,Zkn,Zks       | True     | packw                | R               |                 |  Pack two words into one register, lower half of each         |
| XPERM-N              | K,Zkn,Zks       | True     | xperm.n              | R               |                 |  None                                                         |
| XPERM-B              | K,Zkn,Zks       | True     | xperm.b              | R               |                 |  Crossbar Permutation, Byte                                   |



