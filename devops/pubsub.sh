#!/bin/bash -e
# @script       pubsub-topic.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# Utilities script for GCP Pub/Sub Topics.
#
# @usage
# ./pubsub-topic.sh [ --create | --delete ] 
BASE_DIR="$(dirname $0)"
OK="\033[1;32m✔︎\033[00m"
ERROR="\033[1;31m✗\033[00m"

cd "$BASE_DIR" && source .env

for arg in "$@"
do
    case $arg in

        --create)
        printf "$OK Creating Pub/Sub Topic '$START_INSTANCE_TOPIC'...\n"
        gcloud pubsub topics create "$START_INSTANCE_TOPIC" --project "$PROJECT_ID"
        shift
        ;;

        --delete)
        printf "$OK Deleting Pub/Sub Topic '$START_INSTANCE_TOPIC'...\n"
        gcloud pubsub topics delete "$START_INSTANCE_TOPIC" --project "$PROJECT_ID"
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
