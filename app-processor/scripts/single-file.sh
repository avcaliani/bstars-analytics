#!/bin/bash -x
# @script       single-file.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# The following script move the generated refined file to analytics folder.
#
# @usage
# ./single-file.sh
PROJECT_PATH="$(dirname $0)"
REFINED_PATH="/lake/refined/users.v1"
ANALYTICS_PATH="/lake/analytics/users.v1"
FILE_NAME="bstars-users.v1.$(date '+%Y%m%d%H%M%S').csv"

cd $PROJECT_PATH \
  && mkdir -p $ANALYTICS_PATH \
  && cp $REFINED_PATH/*.csv "$ANALYTICS_PATH/$FILE_NAME"

cd - && exit 0
