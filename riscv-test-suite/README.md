# Imperas RISC-V Architecture Tests

    #
    # Copyright (c) 2005-2023 Imperas Software Ltd., www.imperas.com
    #
    # The contents of this file are provided under the Software License
    # Agreement that you accepted before downloading this file.
    #
    # This source forms part of the Software and can be used for educational,
    # training, and demonstration purposes but cannot be used for derivative
    # works except in cases where the derivative works require OVP technology
    # to run.
    #
    # For open source models released under licenses that you can use for
    # derivative works, please visit www.OVPworld.org or www.imperas.com
    # for the location of the open source models.
    #
    

Test Suites : 84
Test Files              : 6,187
Total Instructions      : 9,290,980

| Test Suites           |   Test Files   | Ins. Types | Unique Ins. | Total Ins. | Basic Coverage | Extended Coverage |
| --------------------- | -------------- | ---------- | ----------- | ---------- | -------------- | ----------------- |
| rv32e_m-RVI/C         |             26 |          0 |          23 |     24,094 |         94.60% |             55.94 |
| rv32e_m-RVI/E         |             37 |          0 |          38 |     78,170 |         99.57% |             80.18 |
| rv32e_m-RVI/M         |              8 |          0 |           8 |     27,976 |        100.00% |             83.40 |
| rv32e_m/C             |             25 |          8 |          23 |     23,134 |         94.32% |                   |
| rv32e_m/E             |             37 |         10 |          38 |     40,766 |         99.57% |                   |
| rv32e_m/M             |              8 |          1 |           8 |      7,952 |        100.00% |                   |
| rv32i_m-RVI/C         |             27 |          0 |          24 |     25,632 |         93.41% |             59.55 |
| rv32i_m-RVI/F         |            146 |          0 |          26 |  2,147,792 |         93.53% |                   |
| rv32i_m-RVI/I         |             38 |          0 |          38 |     80,072 |         99.72% |             83.31 |
| rv32i_m-RVI/K         |             62 |          0 |          29 |     49,132 |         92.41% |             57.77 |
| rv32i_m-RVI/M         |              8 |          0 |           8 |     28,140 |        100.00% |             84.84 |
| rv32i_m-RVI/Zifencei  |              1 |          0 |           1 |        103 |        100.00% |            100.00 |
| rv32i_m-RVI/privM     |             16 |          0 |           3 |      3,011 |        100.00% |            100.00 |
| rv32i_m/C             |             27 |          8 |          24 |     24,213 |         95.24% |             51.46 |
| rv32i_m/F             |            143 |          5 |          26 |     57,830 |         92.63% |                   |
| rv32i_m/I             |             48 |         10 |          38 |     43,980 |         99.72% |             90.36 |
| rv32i_m/M             |              8 |          1 |           8 |      8,208 |        100.00% |             84.19 |
| rv32i_m/P             |            247 |          1 |         247 |    263,531 |         94.01% |                   |
| rv32i_m/Vb            |            324 |          2 |          48 |    412,064 |         89.79% |                   |
| rv32i_m/Vf            |            698 |         17 |          91 |    575,164 |         86.86% |                   |
| rv32i_m/Vi            |          1,402 |         12 |         137 |  1,112,780 |         93.54% |                   |
| rv32i_m/Vm            |            180 |          2 |          15 |    160,680 |         99.92% |                   |
| rv32i_m/Vp            |            184 |          4 |          21 |    141,228 |         91.90% |                   |
| rv32i_m/Vr            |            146 |          2 |          16 |    110,676 |         91.67% |                   |
| rv32i_m/Vx            |            348 |          6 |          32 |    277,504 |         96.70% |                   |
| rv32i_m/Zba           |              3 |          1 |           3 |      2,934 |        100.00% |             89.68 |
| rv32i_m/Zbb           |             18 |          6 |          15 |     15,476 |         99.92% |             87.69 |
| rv32i_m/Zbc           |              3 |          1 |           3 |      2,934 |        100.00% |             78.34 |
| rv32i_m/Zbkb          |             11 |          4 |           9 |      9,810 |         99.75% |             90.10 |
| rv32i_m/Zbkc          |              2 |          1 |           2 |      1,956 |        100.00% |             78.23 |
| rv32i_m/Zbkx          |              0 |          1 |           0 |          0 |          0.00% |              0.00 |
| rv32i_m/Zbs           |              8 |          2 |           8 |      6,864 |         99.38% |             78.14 |
| rv32i_m/Zicsr         |              6 |          1 |           6 |      9,372 |        100.00% |             99.43 |
| rv32i_m/Zk            |             31 |          9 |          14 |     30,650 |        100.00% |             98.95 |
| rv32i_m/Zkn           |             31 |          9 |          25 |     30,650 |         99.90% |             92.78 |
| rv32i_m/Zknd          |              4 |          2 |           2 |      5,024 |        100.00% |             99.26 |
| rv32i_m/Zkne          |              4 |          1 |           2 |      5,024 |        100.00% |             99.26 |
| rv32i_m/Zknh          |             10 |          1 |          10 |      8,836 |        100.00% |             98.86 |
| rv32i_m/Zks           |             19 |          8 |          15 |     18,274 |         99.84% |             89.53 |
| rv32i_m/Zksed         |              4 |          1 |           2 |      5,024 |        100.00% |             99.26 |
| rv32i_m/Zksh          |              2 |          1 |           2 |      1,484 |        100.00% |             99.24 |
| rv32i_m/Zmmul         |              4 |          1 |           4 |      4,104 |        100.00% |             79.19 |
| rv32i_m/privEPMP      |             28 |          0 |           1 |     32,248 |         82.02% |                   |
| rv32i_m/privPMP       |             14 |          0 |           1 |     14,053 |         80.18% |                   |
| rv32i_msu/privEPMP    |             84 |          0 |           1 |    100,766 |         82.02% |                   |
| rv32i_msu/privPMP     |             42 |          0 |           1 |     45,829 |         80.18% |                   |
| rv32i_mu/privEPMP     |             56 |          0 |           1 |     66,479 |         82.02% |                   |
| rv32i_mu/privPMP      |             28 |          0 |           1 |     29,927 |         80.18% |                   |
| rv64i_m-RVI/C         |             33 |          0 |          30 |     77,911 |         88.48% |             52.51 |
| rv64i_m-RVI/D         |            170 |          0 |          32 |    601,900 |         92.48% |                   |
| rv64i_m-RVI/I         |             50 |          0 |          50 |    187,418 |         99.77% |             76.07 |
| rv64i_m-RVI/K         |             64 |          0 |          34 |    162,849 |         93.29% |             39.52 |
| rv64i_m-RVI/M         |             13 |          0 |          13 |    104,702 |        100.00% |             80.62 |
| rv64i_m-RVI/Zifencei  |              1 |          0 |           1 |        269 |        100.00% |            100.00 |
| rv64i_m-RVI/privM     |             19 |          0 |           3 |      7,632 |        100.00% |            100.00 |
| rv64i_m/C             |             33 |          8 |          30 |     61,754 |         88.87% |             45.29 |
| rv64i_m/D             |            176 |          5 |          32 |    135,108 |         92.52% |                   |
| rv64i_m/F             |            183 |          5 |          30 |    123,430 |         92.01% |                   |
| rv64i_m/I             |             60 |         10 |          50 |    120,880 |         99.77% |             86.69 |
| rv64i_m/M             |             13 |          1 |          13 |     31,918 |        100.00% |             80.11 |
| rv64i_m/P             |            318 |          1 |         318 |    727,374 |         96.37% |                   |
| rv64i_m/Zba           |              8 |          2 |           8 |     18,572 |         99.86% |             84.79 |
| rv64i_m/Zbb           |             24 |          8 |          21 |     48,956 |         99.88% |             81.54 |
| rv64i_m/Zbc           |              3 |          1 |           3 |      7,218 |        100.00% |             73.80 |
| rv64i_m/Zbkb          |             13 |          4 |          13 |     29,243 |         99.74% |             86.33 |
| rv64i_m/Zbkc          |              2 |          1 |           2 |      4,812 |        100.00% |             73.77 |
| rv64i_m/Zbkx          |              0 |          1 |           0 |          0 |          0.00% |              0.00 |
| rv64i_m/Zbs           |              8 |          2 |           8 |     16,544 |         99.38% |             74.94 |
| rv64i_m/Zicsr         |              6 |          1 |           6 |     20,520 |        100.00% |             99.86 |
| rv64i_m/Zk            |             37 |          9 |          15 |     81,476 |        100.00% |             99.34 |
| rv64i_m/Zkn           |             37 |          9 |          30 |     81,476 |         99.88% |             89.79 |
| rv64i_m/Zknd          |             10 |          2 |           5 |     23,459 |        100.00% |             99.26 |
| rv64i_m/Zkne          |              8 |          1 |           4 |     19,326 |        100.00% |             99.23 |
| rv64i_m/Zknh          |              8 |          1 |           8 |     13,832 |        100.00% |             99.49 |
| rv64i_m/Zks           |             21 |          8 |          19 |     48,803 |         99.81% |             86.09 |
| rv64i_m/Zksed         |              4 |          1 |           2 |     11,290 |        100.00% |             99.50 |
| rv64i_m/Zksh          |              2 |          1 |           2 |      3,458 |        100.00% |             99.49 |
| rv64i_m/Zmmul         |              5 |          1 |           5 |     12,350 |        100.00% |             74.46 |
| rv64i_m/privEPMP      |             28 |          0 |           1 |     37,292 |         81.30% |                   |
| rv64i_m/privPMP       |             14 |          0 |           1 |     16,575 |         79.46% |                   |
| rv64i_msu/privEPMP    |             84 |          0 |           1 |    116,010 |         81.30% |                   |
| rv64i_msu/privPMP     |             42 |          0 |           1 |     53,451 |         79.46% |                   |
| rv64i_mu/privEPMP     |             56 |          0 |           1 |     76,623 |         81.30% |                   |
| rv64i_mu/privPMP      |             28 |          0 |           1 |     34,999 |         79.46% |                   |
| --------------------- | -------------- | ---------- | ----------- | ---------- | -------------- | ----------------- |


