#!/bin/bash
# Shell script to iterate through projects and service accounts
# If running locally, login first with "gcloud auth login" and "gcloud auth application-default login"

echo "PROJECT NAME, SERVICE ACCOUNT NAME , KEY NAME , VALID FROM , VALID UNTIL , KEY ORIGIN, KEY TYPE" > serviceaccounts.csv
prjs=( $(gcloud projects list | tail -n +2 | awk {'print $1'}) ) 
for i in "${prjs[@]}"
    do
        echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" >> list.txt
        echo "Setting Project: $i" >> list.txt
        echo $(gcloud config set project $i)
        echo $(gcloud iam service-accounts list | tail -n +2 | grep -E -o "\b[A-Za-z0-9._%+-]{0,50}@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" | while read line; do echo "$line"; done | python python-serviceaccount-keys-extraction.py $i>> serviceaccounts.csv)
    done


