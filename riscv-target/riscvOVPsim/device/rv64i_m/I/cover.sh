#!/bin/bash

if [[ ${COVERTYPE} == "" ]]; then
    COVERTYPE=basic
fi

if [[ ${TARGET_SIM} == "" ]]; then
    if [[ ${RISCV_TARGET} == "" ]]; then
        TARGET_SIM=${ROOTDIR}/riscv-ovpsim/bin/Linux64/riscvOVPsim.exe
    fi
    if [[ ${RISCV_TARGET} == "riscvOVPsim" ]]; then
        TARGET_SIM=${ROOTDIR}/riscv-ovpsim/bin/Linux64/riscvOVPsim.exe
    fi
    if [[ ${RISCV_TARGET} == "riscvOVPsimPlus" ]]; then
        TARGET_SIM=${ROOTDIR}/riscv-ovpsim-plus/bin/Linux64/riscvOVPsimPlus.exe
    fi
fi

echo "Running ${XLEN} ${RISCV_DEVICE}"
RISCV_ISA=rv${XLEN}i_m/${RISCV_DEVICE}
RISCV_CVG=${RISCV_DEVICE}

${TARGET_SIM} \
    --variant RV64I  \
    --cover ${COVERTYPE} \
    --countthreshold 1 \
    --showuncovered \
    --nosimulation \
    --extensions ${RISCV_CVG} \
    --inputfiles work/${RISCV_ISA} \
    --outputfile work/${RISCV_ISA}/${COVERTYPE}.coverage.yaml \
    --reportfile work/${RISCV_ISA}/${COVERTYPE}.coverage.txt \
    --logfile work/${RISCV_ISA}/${COVERTYPE}.coverage.run.log

