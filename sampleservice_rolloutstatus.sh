#!/bin/bash




sleep 10s

if [[ $(kubectl -n ${namespace} rollout status deploy ${deploymentName} --timeout 5s) != *"successfully rolled out"* ]]; 
then     
	echo "Deployment ${deploymentName} Rollout has Failed"
    kubectl -n ${namespace} rollout undo deploy ${deploymentName}
    exit 1;
else
	echo "Deployment ${deploymentName} Rollout is Success"
fi