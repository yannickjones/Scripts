#!/bin/bash
for p in `gcloud projects list --format="value(projectId)"`; do
  pc=`gcloud services list --project $p 2> /dev/null|grep compute`
  echo "Project: $p"
  if [ ! -z "$pc" ]; then
    for network in `gcloud compute networks list --project $p --format=json | jq -r .[].name`; do
      echo "=== Network: $network"
      gcloud compute firewall-rules create cloudops-$network-deny-all-ingress --project $p --direction=INGRESS --priority=65535 --network=$network --action=DENY --rules=all --enable-logging  --description="Used to mimic the implicit deny all ingress firewall rule to allow logging of all ingress traffic."

    done
  fi
done