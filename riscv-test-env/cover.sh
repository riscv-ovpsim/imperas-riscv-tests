#!/bin/bash

declare -A map
map[rv32i]=RVI
map[rv32m]=RVM
map[rv32ic]=RVIC,RV32IC
map[rv32Zicsr]=RVZicsr
map[rv32Zifencei]=RVZifencei
map[rv64i]=RVI,RV64I
map[rv64m]=RVM,RV64M
map[rv64ic]=RVIC,RV64IC
map[rv64Zicsr]=RVZicsr
map[rv64Zifencei]=RVZifencei

map[rv32vb]=RVVb
map[rv32vi]=RVVi
map[rv32vp]=RVVp
map[rv32vf]=RVVf
map[rv32vx]=RVVx
map[rv32vm]=RVVm
map[rv32vr]=RVVr

map[rv64vb]=RVVb
map[rv64vi]=RVVi
map[rv64vp]=RVVp
map[rv64vf]=RVVf
map[rv64vx]=RVVx
map[rv64vm]=RVVm
map[rv64vr]=RVVr

map[rv32b]=RVZba,RVZbb,RVZbc,RVZbe,RVZbf,RVZbp,RVZbs,RVZbt
map[rv64b]=RVZba,RVZba64,RVZbb,RVZbb64,RVZbc,RVZbe,RVZbe64,RVZbf,RVZbm64,RVZbp,RVZbp64,RVZbs,RVZbs64,RVZbt,RVZbt64

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



