#!/bin/bash -x
# @script       run.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# The following script runs "app-collector".
#
# @usage
# ./run.sh
PROJECT_DIR="$(dirname $0)"

status=0
cd ${PROJECT_DIR} \
  && ./main.py || status=1 \
  && cd - \
  && exit "$status"
