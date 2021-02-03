#!/bin/bash

declare -i rc=0

printf "\n\nCompare to reference files ... \n\n";
FAIL=0
RUN=0

for ref in ${SUITEDIR}/references/*.reference_output;
do 
    base=$(basename ${ref})
    stub=${base//".reference_output"/}

    if [ "${stub}" = "*" ]; then
        echo "No Reference Files ${SUITEDIR}/references/*.reference_output"
        break
    fi

    sig=${WORK}/${RISCV_ISA}/${stub}.signature.output
    dif=${WORK}/${RISCV_ISA}/${stub}.diff

    RUN=$((${RUN} + 1))
    
    #
    # Ensure both files exist
    #
    if [ -f ${ref} ] && [ -f ${sig} ]; then 
        echo -n "Check $(printf %-24s ${stub})"
    else
        echo    "Check $(printf %-24s ${stub}) ... IGNORE"
        continue
    fi
    diff --strip-trailing-cr ${ref} ${sig} &> /dev/null
    if [ $? == 0 ]
    then
        echo " ... OK"
    else
        echo " ... FAIL"
        FAIL=$((${FAIL} + 1))
        sdiff ${ref} ${sig} > ${dif}
    fi
done

# warn on missing reverse reference
for sig in ${WORK}/${RISCV_ISA}/*.signature.output; 
do
    base=$(basename ${sig})
    stub=${base//".signature.output"/}
    ref=${SUITEDIR}/references/${stub}.reference_output

    if [ -f $sig ] && [ ! -f ${ref} ]; then
        echo "Error: sig ${sig} no corresponding ${ref}"
        FAIL=$((${FAIL} + 1))
    fi
done

for log in ${WORK}/${RISCV_ISA}/*.log; 
do
    base=$(basename ${log})
    stub=${base//".log"/}
    #echo "Error Check $stub $base $log"
    
    if [ -f ${log} ]; then
        grep "Test FAILED" ${log} > /dev/null
        rc=$?
        if [ $rc -eq 0 ]; then
            echo "Error: ${base} returns Test FAILED - check Signature"
        fi
    fi
done

declare -i status=0
if [ ${FAIL} == 0 ]
then
    echo "--------------------------------"
    echo "OK: ${RUN}/${RUN}"
    status=0
else
    echo "--------------------------------"
    echo "FAIL: ${FAIL}/${RUN}"
    status=1
fi
echo "RISCV_TARGET=${RISCV_TARGET} RISCV_DEVICE=${RISCV_DEVICE} RISCV_ISA=${RISCV_ISA}"
echo
exit ${status}

