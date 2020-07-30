#!/bin/bash -e
# @script       compute.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# Utilities script for GCP Compute Engine.
#
# @params
# 01 - IP Address (Only applied when using 'create' operation)
#
# @usage
# ./compute.sh [ --create | --delete | --start | --stop | --ssh | --serial-output ] IP_ADDRESS
BASE_DIR="$(dirname $0)"
OK="\033[1;32m✔︎\033[00m"
ERROR="\033[1;31m✗\033[00m"

cd "$BASE_DIR" && source .env

for arg in "$@"
do
    case $arg in

        --create)
        printf "$OK Creating VM '$APP_COLLECTOR_VM'...\n"
        gcloud compute instances create "$APP_COLLECTOR_VM" \
            --machine-type "n1-standard-1" \
            --image-family "ubuntu-2004-lts" \
            --image-project "ubuntu-os-cloud" \
            --boot-disk-size "100GB" \
            --boot-disk-type "pd-standard" \
            --address "$2" \
            --scopes "cloud-platform" \
            --metadata startup-script-url="gs://$REPO_BUCKET/scripts/vm-init.sh" \
            --zone "$ZONE" \
            --project "$PROJECT_ID"
        shift; shift
        ;;

        --delete)
        printf "$OK Deleting VM '$APP_COLLECTOR_VM'...\n"
        gcloud compute instances delete "$APP_COLLECTOR_VM" --zone "$ZONE" --project "$PROJECT_ID"
        shift
        ;;

        --start)
        printf "$OK Starting VM '$APP_COLLECTOR_VM'...\n"
        gcloud compute instances start "$APP_COLLECTOR_VM" --zone "$ZONE" --project "$PROJECT_ID"
        shift
        ;;

        --stop)
        printf "$OK Stopping VM '$APP_COLLECTOR_VM'...\n"
        gcloud compute instances stop "$APP_COLLECTOR_VM" --zone "$ZONE" --project "$PROJECT_ID"
        shift
        ;;

        --ssh)
        gcloud compute ssh "$APP_COLLECTOR_VM" --zone "$ZONE" --project "$PROJECT_ID"
        shift
        ;;

        --serial-output)
        gcloud compute instances tail-serial-port-output "$APP_COLLECTOR_VM" --zone "$ZONE" --project "$PROJECT_ID"
        shift
        ;;

        *)
        if [[ "$1" != "" ]]; then
            printf "$ERROR Invalid argument '$1'\n"
        fi
        shift
        ;;
    esac
done

cd - && exit 0
