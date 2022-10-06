#!/bin/bash
#trivy-k8s-scan

echo $imageName 

docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.17.2 -q image --exit-code 0 --severity LOW,MEDIUM,HIGH --light $imageName
docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.17.2 -q image --exit-code 1 --severity CRITICAL --light $imageName

    
    exit_code=$?
    echo "Exit Code : $exit_code"

    
    if [[ ${exit_code} == 1 ]]; then
        echo "Failed. Vulnerabilities found"
        exit 1;
    else
        echo "No vulnerabilities found"
    fi;