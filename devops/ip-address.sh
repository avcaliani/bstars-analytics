#!/bin/bash -e
# @script       ip-address.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# Utilities script for GCP Static IP Address.
#
# @usage
# ./ip-address.sh [ --create | --delete ] 
BASE_DIR="$(dirname $0)"
OK="\033[1;32m✔︎\033[00m"
ERROR="\033[1;31m✗\033[00m"

cd "$BASE_DIR" && source .env

for arg in "$@"
do
    case $arg in

        --create)
        printf "$OK Creating static IP Address '$APP_COLLECTOR_IP'...\n"
        gcloud compute addresses create "$APP_COLLECTOR_IP" \
            --region "$REGION" \
            --project "$PROJECT_ID"
        gcloud compute addresses describe "$APP_COLLECTOR_IP"
        shift
        ;;

        --delete)
        printf "$OK Deleting static IP Address '$APP_COLLECTOR_IP'...\n"
        gcloud compute addresses delete "$APP_COLLECTOR_IP" \
            --region "$REGION" \
            --project "$PROJECT_ID"
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
