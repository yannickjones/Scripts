#!/bin/bash
for p in `gcloud projects list --format="value(projectId)"`; do
  pc=`gcloud services list --project $p 2> /dev/null|grep compute`
  if [ ! -z "$pc" ]; then
    echo "Project $p"
    base="gcloud compute routers list --project $p --format=json"
    routers=$($base | jq -r '.[].name')
    for r in $routers; do
      echo "== router: $r"
      nats=$($base | jq  -r ".[] | select(.name==\"$r\") |.nats[].name")
      
      for n in $nats; do
        region=$($base |  jq -r ".[] | select(.name==\"$r\") |.region")
        echo "------ nat: $n"
        echo "------ region: $(basename $region)"
        gcloud compute routers nats update $n --router=$r --project=$p --region $(basename $region) --enable-logging
      done
    done
  fi
done