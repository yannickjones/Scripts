#!/bin/bash
for p in `gcloud projects list --format="value(projectId)"`; do
    `gcloud config set project $p && gcloud services enable securitycenter.googleapis.com`
    echo "Project: $p"
done