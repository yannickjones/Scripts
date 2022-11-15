#!/bin/bash
for p in `gcloud projects list --format="value(projectId)" | grep "^test"`; do
    `gcloud projects get-iam-policy ${p/$'\r'/} > "${p/$'\r'/}.policy.yaml"`
    if grep -q "auditLogConfigs:" "${p/$'\r'/}.policy.yaml"; then
        echo 'Audit Log config already exists';
    else
    echo -e "auditConfigs: \n auditLogConfigs: \n - logType: ADMIN_READ \n - logType: DATA_READ \n - logType: DATA_WRITE \n service: iap.googleapis.com" >> "${p/$'\r'/}.policy.yaml"
    `gcloud projects set-iam-policy "${p/$'\r'/}" "${p/$'\r'/}.policy.yaml"`
    fi
    echo "Project: $p"
done


## Example Output
# $ ./gcp-audit-logs.sh 
# Updated IAM policy for project [script-test-2-339401].
# Project: script-test-2-339401
# Updated IAM policy for project [script-test-339401].
# Project: script-test-339401
# Audit Log config already exists
# Project: gitlab-test-338220

## Replace line 2 with the following for testing purposes:
# for p in `gcloud projects list --format="value(projectId)" | grep "^test"`; do
## To return to prod:
# for p in `gcloud projects list --format="value(projectId)"`; do
