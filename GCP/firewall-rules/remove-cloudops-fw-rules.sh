#!/bin/bash
for p in `gcloud projects list --format="value(projectId)"`; do
  pc=`gcloud services list --project $p 2> /dev/null|grep compute`
  echo "Project: $p"
  if [ ! -z "$pc" ]; then
    for network in `gcloud compute networks list --project $p --format=json | jq -r .[].name`; do
      #gcloud compute firewall-rules update $rn --enable-logging --project
      echo "=== Network: $network"
      gcloud compute firewall-rules delete cloudops-$network-deny-all-ingress --project $p --quiet
      gcloud compute firewall-rules delete cloudops-$network-allow-all-egress --project $p --quiet
    done
  fi
done