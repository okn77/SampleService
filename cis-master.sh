#!/bin/bash
#cis-master.sh

total_fail=$(sudo ./kube-bench --config-dir cfg --config cfg/config.yaml master --version 1.20 --check 1.2.7 --json |jq .Totals.total_fail)

if [[ "$total_fail" -ne 0 ]];
        then
                echo "CIS Benchmark Failed MASTER while testing for 1.2.7"
                exit 1;
        else
                echo "CIS Benchmark Passed for MASTER - 1.2.7"
fi;