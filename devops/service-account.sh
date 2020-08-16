#!/bin/bash -e
# @script       service-account.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# Utilities script for GCP Service Account.
#
# @params
# 01 - Service Account Name
#
# @usage
# ./service-account.sh [ --create | --delete ] SA_NAME
BASE_DIR="$(dirname $0)"
OK="\033[1;32m✔︎\033[00m"
ERROR="\033[1;31m✗\033[00m"

cd "$BASE_DIR" && source .env

for arg in "$@"
do
    case $arg in

        --create)
        printf "$OK Creating Service Account '$2'...\n"
        gcloud iam service-accounts create "$2" --display-name="$2" --project "$PROJECT_ID"
        
        printf "$OK Creating Service Account '$2' JSON Key...\n"
        mkdir -p target
        gcloud iam service-accounts keys create "target/$2-key.json" \
            --iam-account "$2@$PROJECT_ID.iam.gserviceaccount.com" \
            --project "$PROJECT_ID"
        
        printf "$OK Granting permissions...\n"
        gcloud projects add-iam-policy-binding "$PROJECT_ID" \
            --member "serviceAccount:$2@$PROJECT_ID.iam.gserviceaccount.com" \
            --role "roles/editor"
        
        shift; shift
        ;;

        --delete)
        printf "$OK Revoking permissions...\n"
        gcloud projects remove-iam-policy-binding "$PROJECT_ID" \
            --member "serviceAccount:$2@$PROJECT_ID.iam.gserviceaccount.com" \
            --role "roles/editor"

        printf "$OK Deleting Service Account '$2'...\n"
        gcloud iam service-accounts delete "$2@$PROJECT_ID.iam.gserviceaccount.com" \
            --project "$PROJECT_ID"

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
