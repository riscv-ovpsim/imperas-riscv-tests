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

WORK_DIR=work/rv${XLEN}${RISCV_BASE}_${RISCV_MODE}/${RISCV_DEVICE}

${TARGET_SIM} \
    --variant RV32EC  \
    --cover ${COVERTYPE} \
    --countthreshold 1 \
    --showuncovered \
    --nosimulation \
    --extensions ${RISCV_DEVICE} \
    --inputfiles ${WORK_DIR} \
    --outputfile ${WORK_DIR}/${COVERTYPE}.coverage.yaml \
    --reportfile ${WORK_DIR}/${COVERTYPE}.coverage.txt \
    --logfile ${WORK_DIR}/${COVERTYPE}.coverage.run.log

