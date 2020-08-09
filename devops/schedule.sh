#!/bin/bash -e
# @script       scheduler.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# Utilities script for GCP Cloud Scheduler.
#
# @usage
# ./scheduler.sh [ --create | --delete ] 
BASE_DIR="$(dirname $0)"
OK="\033[1;32m✔︎\033[00m"
ERROR="\033[1;31m✗\033[00m"

cd "$BASE_DIR" && source .env

for arg in "$@"
do
    case $arg in

        --create)
        printf "$OK Creating Scheduler '$START_INSTANCE_SCHEDULER'...\n"
        msg="{"
        msg="$msg \"project\":\"$PROJECT_ID\","
        msg="$msg \"zone\":\"$ZONE\","
        msg="$msg \"compute_instance\":\"$APP_COLLECTOR_INSTANCE\","
        msg="$msg \"bucket\":\"$TRANSIENT_BUCKET\","
        msg="$msg \"bucket_dir\":\"$TRANSIENT_BUCKET_DIR\""
        msg="$msg }"
        printf "Pub/Sub Scheduler Topic: $START_INSTANCE_TOPIC\n"
        printf "Pub/Sub Scheduler Message: $msg\n"
        gcloud scheduler jobs create pubsub "$START_INSTANCE_SCHEDULER" \
            --schedule '0 */6 * * *' \
            --time-zone "America/Sao_Paulo" \
            --topic "$START_INSTANCE_TOPIC" \
            --message-body "$msg" \
            --project "$PROJECT_ID"
        shift
        ;;

        --delete)
        printf "$OK Deleting Scheduler '$START_INSTANCE_SCHEDULER'...\n"
        gcloud scheduler jobs delete "$START_INSTANCE_SCHEDULER" --project "$PROJECT_ID"
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
