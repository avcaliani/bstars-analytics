#!/bin/bash -x
# @script       get-files.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# The following script gets files from GCloud and bring them to the Data Lake.
#
# @usage
# ./get-files.sh
PROJECT_PATH="$(dirname $0)"
TRANSIENT_PATH="/lake/transient/users.v1/"

cd $PROJECT_PATH \
  && rm -rf $TRANSIENT_PATH \
  && mkdir -p $TRANSIENT_PATH \
  && gsutil -m cp gs://bstars-transient/users.v1/* $TRANSIENT_PATH || exit 1

cd - && exit 0
