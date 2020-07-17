#!/bin/bash -x
# @script       run.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# The following script runs "app-ingestor" locally.
#
# @usage
# ./run.sh
PROJECT_DIR="$(dirname $0)"

status=0
cd ${PROJECT_DIR} \
  && pip3 install -r requirements.txt \
  && ./main.py || status=1 \
  && cd - \
  && exit "$status"
