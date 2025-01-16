#!/bin/bash

set -x

loop_count=1;
fail_count=0;
break_on_failure=0

while getopts "r:hb" opt;
do
    case "$opt" in
    r)
        if [[ "$OPTARG" =~ ^[1-9][0-9]*$ ]];
        then
            loop_count="$OPTARG"
        else
            echo "Invalid use of -r flag, requires a following positive number"
            exit 1
        fi
        ;;
    h)
        echo "Run Libsurroundview unit tests"
        echo
        echo "Syntax: $0 [-h|-r|-b]"
        echo "options:"
        echo "h     Print this help."
        echo "r     Repeat the unit test multiple times. Requires a positive number for the number of iterations"
        echo "b     Break on failure"
        exit 0
        ;;
    b)
        break_on_failure=1
        ;;
    *)
        echo "Invalid flag, please type ./multirun.sh -h to see the valid flags"
        exit 1
        ;;
    esac
done

for ((i=1; i<=loop_count; i++));
do
    echo "Starting iteration $i/$loop_count"
    #run tests cmd
    iter_fail_count=$?
    if [ $iter_fail_count -gt 0 ];
    then
    	fail_count=$(($fail_count+1))
    fi
    #stuff to do in case of a fail_count/passed iteration like creating a backup folder for it
    echo "Iteration $i/$loop_count done"
    #break on failure
    if [[ $fail_count -gt 0 && $break_on_failure -ne 0 ]];
    then
        break;
    fi;
done;

if [ $fail_count -eq 0 ];
then
	exit 0
else
	if [ $break_on_failure -eq 0 ];
	then
		echo "Failure rate: $(($fail_count/$loop_count))"
	fi
	exit 1
fi
