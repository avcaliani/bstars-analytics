#!/bin/bash -e
# @script       app-deploy.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# Deployment script for project Apps.
# PS: The development docker container must be up.
#
# @params
# 01 - App Name
#
# @usage
# ./app-deploy.sh APP_NAME
BASE_DIR="$(dirname $0)"
OK="\033[1;32m✔︎\033[00m"
ERROR="\033[1;31m✗\033[00m"

cd "$BASE_DIR" && source .env

for arg in "$@"
do
    case $arg in

        app-collector)
        printf "$OK Generating initialization script...\n"
        rm -rf target || true
        mkdir -p target \
            && cp compute-engine/vm-init.sh target/ \
            && sed -i -e "s/@@PROJECT_ID@@/$PROJECT_ID/g"                           target/vm-init.sh \
            && sed -i -e "s/@@ZONE@@/$ZONE/g"                                       target/vm-init.sh \
            && sed -i -e "s/@@APP_COLLECTOR_INSTANCE@@/$APP_COLLECTOR_INSTANCE/g"   target/vm-init.sh \
            && sed -i -e "s/@@APP_COLLECTOR_ZIP@@/$APP_COLLECTOR_ZIP/g"             target/vm-init.sh \
            && sed -i -e "s/@@REPO_BUCKET@@/$REPO_BUCKET/g"                         target/vm-init.sh \
            && ls -l target

        printf "\n$OK Compressing...\n"
        cd ..
        tar --exclude='.venv' \
            --exclude='.idea' \
            --exclude='__pycache__' \
            -cvf devops/target/$APP_COLLECTOR_ZIP \
            app-collector
        cd "$BASE_DIR"

        printf "\n$OK Publishing project...\n"
        gsutil -m rm "gs://$REPO_BUCKET/dist/$APP_COLLECTOR_ZIP" || true
        gsutil -m mv "target/$APP_COLLECTOR_ZIP" "gs://$REPO_BUCKET/dist/"

        printf "\n$OK Publishing initialization scripts...\n"
        gsutil -m rm "gs://$REPO_BUCKET/scripts/vm-init.sh" || true
        gsutil -m mv "target/vm-init.sh" "gs://$REPO_BUCKET/scripts/"

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

printf "\n$OK $REPO_BUCKET/dist\n"
gsutil ls -lh "gs://$REPO_BUCKET/dist/"

printf "\n$OK $REPO_BUCKET/scripts\n"
gsutil ls -lh "gs://$REPO_BUCKET/scripts/"

cd - && exit 0
