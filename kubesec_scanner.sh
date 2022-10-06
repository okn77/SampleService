#!/bin/bash

#kubesec-scan.sh

# using kubesec v2 api
scan_result=$(curl -sSX POST --data-binary @"students.yaml" https://v2.kubesec.io/scan)
scan_message=$(curl -sSX POST --data-binary @"students.yaml" https://v2.kubesec.io/scan | jq .[0].message -r ) 
scan_score=$(curl -sSX POST --data-binary @"students.yaml" https://v2.kubesec.io/scan | jq .[0].score ) 

	
    # Kubesec scanning result 
   
   echo "Kubesec score : $scan_score"

	if [[ "${scan_score}" -ge 5 ]]; then
	    echo "Score is $scan_score"
	    echo "Kubesec Scan $scan_message"
		exit 0;
	else
	    echo "Score is $scan_score, is >= 6."
	    echo "Scanning Kubernetes Resource has failed!!"
	    exit 1;
	fi;
	
	
# using kubesec docker image for scanning
# scan_result=$(docker run -i kubesec/kubesec:512c5e0 scan /dev/stdin < students.yaml)
# scan_message=$(docker run -i kubesec/kubesec:512c5e0 scan /dev/stdin < students.yaml | jq .[].message -r)
# scan_score=$(docker run -i kubesec/kubesec:512c5e0 scan /dev/stdin < students.yaml | jq .[].score)	