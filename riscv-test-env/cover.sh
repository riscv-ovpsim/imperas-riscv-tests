#!/bin/bash

declare -A map
map[rv32i]=I
map[rv32m]=M
map[rv32ic]=C
map[rv32Zicsr]=Zicsr
map[rv32Zifencei]=Zifencei
map[rv64i]=I
map[rv64m]=M
map[rv64ic]=C
map[rv64Zicsr]=Zicsr
map[rv64Zifencei]=Zifencei

map[rv32vb]=Vb
map[rv32vi]=Vi
map[rv32vp]=Vp
map[rv32vf]=Vf
map[rv32vx]=Vx
map[rv32vm]=Vm
map[rv32vr]=Vr

map[rv64vb]=Vb
map[rv64vi]=Vi
map[rv64vp]=Vp
map[rv64vf]=Vf
map[rv64vx]=Vx
map[rv64vm]=Vm
map[rv64vr]=Vr

map[rv32b]=B
map[rv64b]=B

map[rv32k]=K
map[rv64k]=K

declare -A varMap
varMap[rv32i]=RV32I
varMap[rv32m]=RV32IM
varMap[rv32ic]=RV32IMC
varMap[rv32Zicsr]=RV32I
varMap[rv32Zifencei]=RV32I
varMap[rv64i]=RV64I
varMap[rv64m]=RV64IM
varMap[rv64ic]=RV64IMC
varMap[rv64Zicsr]=RV64I
varMap[rv64Zifencei]=RV64I

varMap[rv32vb]=RV32GCV
varMap[rv32vi]=RV32GCV
varMap[rv32vp]=RV32GCV
varMap[rv32vr]=RV32GCV
varMap[rv32vx]=RV32GCV
varMap[rv32vf]=RV32GCV
varMap[rv32vm]=RV32GCV

varMap[rv64vb]=RV64GCV
varMap[rv64vi]=RV64GCV
varMap[rv64vp]=RV64GCV
varMap[rv64vr]=RV64GCV
varMap[rv64vx]=RV64GCV
varMap[rv64vf]=RV64GCV
varMap[rv64vm]=RV64GCV

varMap[rv32b]=RV32GCB
varMap[rv64b]=RV64GCB

varMap[rv32k]=RV32GCK
varMap[rv64k]=RV64GCK

if [[ ${COVERTYPE} == "" ]]; then
    COVERTYPE=basic
fi

if [[ ${RISCV_ISA} == "" ]]; then
    ALL_ISA=$(ls -1 work)
else
    ALL_ISA=${RISCV_ISA}
fi

if [[ ${RISCV_TARGET} == "" ]]; then
    RISCV_TARGET=${ROOTDIR}/riscv-ovpsim/bin/Linux64/riscvOVPsim.exe
fi
if [[ ${RISCV_TARGET} == "riscvOVPsim" ]]; then
    RISCV_TARGET=${ROOTDIR}/riscv-ovpsim/bin/Linux64/riscvOVPsim.exe
fi
if [[ ${RISCV_TARGET} == "riscvOVPsimPlus" ]]; then
    RISCV_TARGET=${ROOTDIR}/riscv-ovpsim-plus/bin/Linux64/riscvOVPsimPlus.exe
fi

for ISA in ${ALL_ISA}; do
    echo "Running $ISA"
    RISCV_ISA=${ISA}
    RISCV_CVG=${map[${RISCV_ISA}]}
    RISCV_VARIANT=${varMap[${RISCV_ISA}]}

    if [ -z "${RISCV_CVG}" ]; then
        echo "# Error: Test suite $ISA map not configured in cover.sh" > work/${RISCV_ISA}/${COVERTYPE}.coverage.run.log
        exit 1
    fi
    if [ -z "${RISCV_VARIANT}" ]; then
        echo "# Error: Test suite $ISA varMap not configured in cover.sh" > work/${RISCV_ISA}/${COVERTYPE}.coverage.run.log
        exit 1
    fi
    ${RISCV_TARGET} \
        --variant ${RISCV_VARIANT}  \
        --cover ${COVERTYPE} \
        --countthreshold 1 \
        --showuncovered \
        --nosimulation \
        --extensions ${RISCV_CVG} \
        --inputfiles work/${RISCV_ISA} \
        --outputfile work/${RISCV_ISA}/${COVERTYPE}.coverage.yaml \
        --reportfile work/${RISCV_ISA}/${COVERTYPE}.coverage.txt \
        ${EXTRA_STR} \
        --logfile work/${RISCV_ISA}/${COVERTYPE}.coverage.run.log
    
done



