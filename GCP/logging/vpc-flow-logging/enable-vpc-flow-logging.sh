#!/bin/bash

for p in `gcloud projects list --format="value(projectId)"`; do
  pc=`gcloud services list --project $p 2> /dev/null|grep compute`
  if [ ! -z "$pc" ]; then
          echo
          echo "Project $p"
          logdis=`gcloud compute networks subnets list --project $p --format=value"(name,region,enableFlowLogs)"|grep -v True|grep .`
          ldcount=`echo "$logdis"|grep -c .`
          if [ "$ldcount" -ne "0" ]; then
                  while read -r line
                  do
                    subnet=`echo "$line"|awk '{ print $1 }'`
                    region=`echo "$line"|awk '{ print $2 }'`
                    gcloud compute networks subnets update $subnet --project $p --region $region --enable-flow-logs
                  done <<< "$logdis"
          fi
  fi
done
