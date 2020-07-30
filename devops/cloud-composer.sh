#!/bin/bash -e
# @script       cloud-composer.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# Utilities script for GCP Cloud Composer.
#
# @params
# 01 - Service Name or Dag File
# 02 - DAG File (Only applicable for "--dag" flag)
#
# @usage
# ./cloud-composer.sh [ --create | --delete | --dag-import | --dag-delete ] SERVICE_NAME DAG_FILE
BASE_DIR="$(dirname $0)"
OK="\033[1;32m✔︎\033[00m"
ERROR="\033[1;31m✗\033[00m"

cd "$BASE_DIR" && source .env

for arg in "$@"
do
    case $arg in

        --create)
        printf "$OK Creating Cloud Composer '$2'...\n"
        gcloud composer environments create "$2" \
            --location "$REGION" \
            --zone "$ZONE" \
            --machine-type "n1-standard-1" \
            --disk-size "100GB" \
            --node-count "3" \
            --env-variables "PROJECT_ID=$PROJECT_ID,ZONE=$ZONE,APP_COLLECTOR_VM=$APP_COLLECTOR_VM" \
            --project "$PROJECT_ID" 
        
        shift; shift
        ;;

        --delete)
        printf "$OK Deleting Cloud Composer '$2'...\n"
        gcloud composer environments delete "$2" \
            --location "$REGION" \
            --project "$PROJECT_ID" 
        shift; shift
        ;;

        --dag-import)
        printf "$OK Importing DAG '$3' to '$2' environment...\n"
        gcloud composer environments storage dags import \
            --environment "$2"  \
            --location "$REGION" \
            --source "$3" \
            --project "$PROJECT_ID" 
        shift; shift; shift
        ;;

        --dag-delete)
        printf "$OK Removing DAG '$3' from '$2' environment...\n"
        gcloud composer environments storage dags delete "$3" \
            --environment "$2"  \
            --location "$REGION" \
            --project "$PROJECT_ID" 
        shift; shift; shift
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
