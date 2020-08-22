#!/bin/bash -x
# @script       run.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# The following script runs "app-processor" locally through Spark Submit.
#
# @params
# 01 - Environment Name
# 02 - Pipeline Name
#
# @usage
# ./run.sh [ local | prod ] [ raw | trusted ]
PROJECT_DIR="$(dirname $0)"

cd ${PROJECT_DIR} \
  && rm -rf build \
  && ./gradlew clean build test -Penv="$1" \
  && shift

status=0
jar_file=$(ls "$PROJECT_DIR"/build/libs/*.jar)
spark-submit \
  --master local \
  --name "bstars-app-processor" \
  --files log4j.properties \
  --driver-java-options "-Dlog4j.configuration=file:log4j.properties" \
  "$jar_file" "$@" || status=1

cd - && exit "$status"
