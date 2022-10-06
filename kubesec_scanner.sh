#!/bin/bash

#kubesec-scan.sh

# using kubesec v2 api
scan_result=$(curl -sSX POST --data-binary @"${deploymentfilename}" https://v2.kubesec.io/scan)
scan_message=$(curl -sSX POST --data-binary @"${deploymentfilename}" https://v2.kubesec.io/scan | jq .[0].message -r ) 
scan_score=$(curl -sSX POST --data-binary @"${deploymentfilename}" https://v2.kubesec.io/scan | jq .[0].score ) 

	
    # Kubesec scanning result 
   
   echo "Kubesec score : $scan_score"

	if [[ "${scan_score}" -ge 6 ]]; then
	    echo "Score is $scan_score"
	    echo "Kubesec Scan $scan_message"
	else
	    echo "Score is $scan_score, is >= 6."
	    echo "Scanning Kubernetes Resource has failed!!"
	    exit 1;
	fi;