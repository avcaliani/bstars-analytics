#!/bin/bash -x
# @script       vm-init.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# Compute Engine initialization script to execute "app-collector" project.
#
# @usage
# ./vm-init.sh
PROJECT_ID="@@PROJECT_ID@@"
ZONE="@@ZONE@@"
APP_COLLECTOR_INSTANCE="@@APP_COLLECTOR_INSTANCE@@"
APP_COLLECTOR_ZIP="@@APP_COLLECTOR_ZIP@@"
REPO_BUCKET="@@REPO_BUCKET@@"

sudo apt-get update && sudo apt-get -y install python3-pip

rm -rf /app \
    && mkdir -p /app \
    && cd /app \
    && gsutil -m cp "gs://$REPO_BUCKET/dist/$APP_COLLECTOR_ZIP" . \
    && tar -xvf "$APP_COLLECTOR_ZIP" \
    && cd app-collector \
    && ./run.sh prod \
    || true

echo "Shutting down..." \
    && sleep 60 \
    && gcloud compute instances stop "$APP_COLLECTOR_INSTANCE" \
        --zone "$ZONE" \
        --project "$PROJECT_ID"

exit 0
