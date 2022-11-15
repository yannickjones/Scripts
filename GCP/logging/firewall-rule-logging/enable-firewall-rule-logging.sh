#!/bin/bash

for p in `gcloud projects list|tail -n +2|awk '{ print $1 }'`; do
  pc=`gcloud services list --project $p 2> /dev/null|grep compute`
  if [ ! -z "$pc" ]; then
    for rn in `gcloud compute firewall-rules list --project $p --format="table(name)"|tail -n +2`; do
      gcloud compute firewall-rules update $rn --enable-logging --project $p
    done
  fi
done



