#!/bin/bash -e
# @script       storage.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# Utilities script for GCP Storage.
#
# @params
# 01 - Bucket Name
#
# @usage
# ./storage.sh [ --create | --delete ] BUCKET_NAME 
BASE_DIR="$(dirname $0)"
OK="\033[1;32m✔︎\033[00m"
ERROR="\033[1;31m✗\033[00m"

cd "$BASE_DIR" && source .env

for arg in "$@"
do
    case $arg in

        --create)
        printf "$OK Creating Bucket '$2'...\n"
        gsutil mb -p "$PROJECT_ID" -c "STANDARD" -l "US" "gs://$2/"
        shift; shift
        ;;

        --delete)
        printf "$OK Deleting Bucket '$2'...\n"
        gsutil rb -f "gs://$2"
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
