#!/bin/bash -x
# @script       run.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# The following script runs "app-processor" locally through Spark Submit.
#
# @usage
# ./run.sh
PROJECT_DIR="$(dirname $0)"

cd ${PROJECT_DIR} \
  && rm -rf build \
  && ./gradlew clean build

status=0
jar_file=$(ls "$PROJECT_DIR"/build/libs/*.jar)
spark-submit --master local "$jar_file" || status=1

cd - && exit "$status"
