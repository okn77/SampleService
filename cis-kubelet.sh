#!/bin/bash
#cis-kubelet.sh

total_fail=$(sudo ./kube-bench --config-dir cfg --config cfg/config.yaml master  --version 1.15 --check 4.2.1,4.2.2 --json | jq .[].total_fail)

if [[ "$total_fail" -ne 0 ]];
        then
                echo "CIS Benchmark Failed Kubelet while testing for 4.2.1, 4.2.2"
                exit 1;
        else
                echo "CIS Benchmark Passed Kubelet for 4.2.1, 4.2.2"
fi;
