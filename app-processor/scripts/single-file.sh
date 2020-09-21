#!/bin/bash -x
# @script       single-file.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# The following script move the generated refined file to other folder.
#
# @usage
# ./single-file.sh
PROJECT_PATH="$(dirname $0)"
REFINED_PATH="/lake/refined/users.v1"
FILE_NAME="brawl-stars-users.v1.$(date '+%Y%m%d%H%M%S').csv"

cd $PROJECT_PATH \
  && mkdir -p "$REFINED_PATH.csv/" \
  && mv $REFINED_PATH/*.csv "$REFINED_PATH.csv/$FILE_NAME" \
  && rm -rf $REFINED_PATH/*

cd - && exit 0
