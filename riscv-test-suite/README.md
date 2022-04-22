# Imperas RISC-V Architecture Tests

    #
    # Copyright (c) 2005-2022 Imperas Software Ltd., www.imperas.com
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
    


| Test Suite            |   Test Files   | Ins. Types | Unique Ins. | Total Ins. | Basic Coverage | Extended Coverage |
| --------------------- | -------------- | ---------- | ----------- | ---------- | -------------- | ----------------- |
| rv32i_m/C             |             27 |          8 |          24 |     21,994 |         95.60% |             73.44 |
| rv32i_m/F             |            143 |          5 |          26 |     57,830 |         92.63% |                   |
| rv32i_m/I             |             48 |         10 |          38 |     37,933 |         99.72% |             95.18 |
| rv32i_m/M             |              8 |          1 |           8 |      6,896 |        100.00% |             84.96 |
| rv32i_m/P             |            247 |          1 |         247 |    226,862 |         95.03% |                   |
| rv32i_m/Vb            |            323 |          2 |          47 |    364,494 |         84.85% |                   |
| rv32i_m/Vf            |            563 |         17 |          91 |    367,074 |         80.09% |                   |
| rv32i_m/Vi            |          1,402 |         12 |         137 |    902,264 |         83.09% |                   |
| rv32i_m/Vm            |            180 |          2 |          15 |    150,516 |         98.32% |                   |
| rv32i_m/Vp            |            172 |          4 |          21 |    110,680 |         89.09% |                   |
| rv32i_m/Vr            |            146 |          2 |          16 |     93,420 |         82.29% |                   |
| rv32i_m/Vx            |            348 |          6 |          32 |    222,920 |         87.59% |                   |
| rv32i_m/Zba           |              3 |          1 |           3 |      2,466 |        100.00% |             89.68 |
| rv32i_m/Zbb           |             18 |          6 |          15 |     13,176 |         99.92% |             88.52 |
| rv32i_m/Zbc           |              3 |          1 |           3 |      2,466 |        100.00% |             78.57 |
| rv32i_m/Zbkb          |             11 |          4 |           9 |      8,322 |         99.75% |             91.42 |
| rv32i_m/Zbkc          |              2 |          1 |           2 |      1,644 |        100.00% |             78.57 |
| rv32i_m/Zbkx          |              0 |          1 |           0 |          0 |          0.00% |              0.00 |
| rv32i_m/Zbs           |              8 |          2 |           8 |      5,856 |         99.38% |             78.33 |
| rv32i_m/Zk            |             31 |          9 |          14 |     26,874 |        100.00% |            100.00 |
| rv32i_m/Zkn           |             31 |          9 |          25 |     26,874 |         99.90% |             93.88 |
| rv32i_m/Zknd          |              4 |          2 |           2 |      4,704 |        100.00% |            100.00 |
| rv32i_m/Zkne          |              4 |          1 |           2 |      4,704 |        100.00% |            100.00 |
| rv32i_m/Zknh          |             10 |          1 |          10 |      7,500 |        100.00% |            100.00 |
| rv32i_m/Zks           |             19 |          8 |          15 |     15,954 |         99.84% |             90.61 |
| rv32i_m/Zksed         |              4 |          1 |           2 |      4,704 |        100.00% |            100.00 |
| rv32i_m/Zksh          |              2 |          1 |           2 |      1,284 |        100.00% |            100.00 |
| rv32i_m/Zmmul         |              4 |          1 |           4 |      3,448 |        100.00% |             79.84 |
| rv32i_m/privEPMP      |             28 |          0 |           1 |     32,248 |         82.02% |                   |
| rv32i_m/privPMP       |             14 |          0 |           1 |     14,053 |         80.18% |                   |
| rv32i_msu/privEPMP    |             84 |          0 |           1 |    100,766 |         82.02% |                   |
| rv32i_msu/privPMP     |             42 |          0 |           1 |     45,829 |         80.18% |                   |
| rv32i_mu/privEPMP     |             56 |          0 |           1 |     66,479 |         82.02% |                   |
| rv32i_mu/privPMP      |             28 |          0 |           1 |     29,927 |         80.18% |                   |
| rv64i_m/C             |             33 |          8 |          30 |     61,720 |         90.20% |             69.27 |
| rv64i_m/D             |            176 |          5 |          32 |    135,108 |         92.52% |                   |
| rv64i_m/F             |            183 |          5 |          30 |    123,430 |         92.01% |                   |
| rv64i_m/I             |             60 |         10 |          50 |    105,765 |         99.77% |             91.80 |
| rv64i_m/M             |             13 |          1 |          13 |     26,686 |        100.00% |             80.57 |
| rv64i_m/P             |            318 |          1 |         318 |    609,560 |         96.37% |                   |
| rv64i_m/Zba           |              8 |          2 |           8 |     15,560 |         99.86% |             85.59 |
| rv64i_m/Zbb           |             24 |          8 |          21 |     41,800 |         99.88% |             82.52 |
| rv64i_m/Zbc           |              3 |          1 |           3 |      6,018 |        100.00% |             73.87 |
| rv64i_m/Zbkb          |             13 |          4 |          13 |     24,628 |         99.74% |             87.78 |
| rv64i_m/Zbkc          |              2 |          1 |           2 |      4,014 |        100.00% |             73.87 |
| rv64i_m/Zbkx          |              0 |          1 |           0 |          0 |          0.00% |              0.00 |
| rv64i_m/Zbs           |              8 |          2 |           8 |     14,096 |         99.38% |             75.12 |
| rv64i_m/Zk            |             37 |          9 |          15 |     84,021 |        100.00% |            100.00 |
| rv64i_m/Zkn           |             37 |          9 |          30 |     84,021 |         99.88% |             90.84 |
| rv64i_m/Zknd          |             10 |          2 |           5 |     29,447 |        100.00% |            100.00 |
| rv64i_m/Zkne          |              8 |          1 |           4 |     25,052 |        100.00% |            100.00 |
| rv64i_m/Zknh          |              8 |          1 |           8 |     12,160 |        100.00% |            100.00 |
| rv64i_m/Zks           |             21 |          8 |          19 |     42,126 |         99.81% |             87.28 |
| rv64i_m/Zksed         |              4 |          1 |           2 |     10,444 |        100.00% |            100.00 |
| rv64i_m/Zksh          |              2 |          1 |           2 |      3,040 |        100.00% |            100.00 |
| rv64i_m/Zmmul         |              5 |          1 |           5 |     10,334 |        100.00% |             74.78 |
| rv64i_m/privEPMP      |             28 |          0 |           1 |     37,292 |         81.30% |                   |
| rv64i_m/privPMP       |             14 |          0 |           1 |     16,575 |         79.46% |                   |
| rv64i_msu/privEPMP    |             84 |          0 |           1 |    116,010 |         81.30% |                   |
| rv64i_msu/privPMP     |             42 |          0 |           1 |     53,451 |         79.46% |                   |
| rv64i_mu/privEPMP     |             56 |          0 |           1 |     76,623 |         81.30% |                   |
| rv64i_mu/privPMP      |             28 |          0 |           1 |     34,999 |         79.46% |                   |
| --------------------- | -------------- | ---------- | ----------- | ---------- | -------------- | ----------------- |


