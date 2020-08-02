#!/bin/bash -e
# @script       function.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# Utilities script for GCP Cloud Function.
#
# @params
# 01 - Function Name
#
# @usage
# ./function.sh [ --create | --delete ] FUNCTION_NAME
BASE_DIR="$(dirname $0)"
OK="\033[1;32m✔︎\033[00m"
ERROR="\033[1;31m✗\033[00m"

cd "$BASE_DIR" && source .env

for arg in "$@"
do
    case $arg in

        --create)
        printf "$OK Deploying function '$2'...\n"
        cd "../functions/$2/"
        gcloud functions deploy "$2" \
            --region "$REGION" \
            --runtime "python37" \
            --trigger-topic "$START_INSTANCE_TOPIC"\
            --entry-point "main" \
            --project "$PROJECT_ID"
        cd -
        shift; shift
        ;;

        --delete)
        printf "$OK Deleting Scheduler '$2'...\n"
        gcloud functions delete "$2" --region "$REGION" --project "$PROJECT_ID"
        shift; shift
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
