#!/bin/bash -x
# @script       run.sh
# @author       Anthony Vilarim Caliani
# @contact      github.com/avcaliani
#
# @description
# The following script runs "app-collector".
#
# @params
# 01 - Environment Name
#
# @usage
# ./run.sh local
PROJECT_DIR="$(dirname $0)"

env=${1:-'local'}
status=0
cd "$PROJECT_DIR" && source "env/$env.env"

tmp_path=$(mktemp -d)
tmp_output_path="$tmp_path/data"
tmp_log_path="$tmp_path/logs"

mkdir -p "$tmp_output_path" "$tmp_log_path"

pip3 install -q -r requirements.txt \
  && ./main.py --api-url "$API_URL" \
               --api-token "$API_TOKEN" \
               --api-retry "$API_RETRY" \
               --output-path "$tmp_output_path" \
               --log-path "$tmp_log_path" \
  || status=1


if [[ "$env" == "local" ]]; then
  mkdir -p "$OUTPUT_PATH" "$LOG_PATH"
  mv $tmp_output_path/* $OUTPUT_PATH/
  mv $tmp_log_path/* $LOG_PATH/
else
  gsutil -m mv $tmp_output_path/* $OUTPUT_PATH/
  gsutil -m mv $tmp_log_path/* $LOG_PATH/
fi


cd - && exit "$status"
