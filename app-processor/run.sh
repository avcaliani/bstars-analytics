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
PROJECT_PATH="$(dirname $0)"

# Building Project
cd $PROJECT_PATH \
  && rm -rf build \
  && gradle clean build test fatJar -Penv="$1" \
  && shift

# Executing Project
status=0
jar_file=$(ls $PROJECT_PATH/build/libs/*-all*.jar)
spark-submit \
  --master local \
  --name "bstars-app-processor" \
  --files log4j.properties \
  --driver-java-options "-Dlog4j.configuration=file:log4j.properties" \
  "$jar_file" "$@" || status=1

cd - && exit "$status"
