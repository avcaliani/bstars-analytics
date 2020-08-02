# DEPRECATED
# This approach was temporarily stopped by financial health reasons.
# However, this approach may be restored in the future.
from os import environ
from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.contrib.operators.gcp_compute_operator import GceInstanceStartOperator

PROJECT_ID = environ.get('PROJECT_ID')
ZONE = environ.get('ZONE')
APP_COLLECTOR_INSTANCE = environ.get('APP_COLLECTOR_INSTANCE')

INTERVAL = '@daily'
YESTERDAY = datetime.now() - timedelta(days=1)
ARGS = {
    'owner'            : 'avcaliani',
    'description'      : 'BStars Analytics Pipeline',
    'email'            : ['avcaliani.it@gmail.com'],
    'email_on_failure' : False,
    'email_on_retry'   : False,
    'start_date'       : YESTERDAY,
    'depend_on_past'   : False,
    'retries'          : 1,
    'retry_delay'      : timedelta(minutes=5)
}

with DAG('pipeline', default_args=ARGS, schedule_interval=INTERVAL, catchup=False) as dag:

    app_collector_start = GceInstanceStartOperator(
        task_id='app-collector-start',
        project_id=PROJECT_ID,
        zone=ZONE,
        resource_id=APP_COLLECTOR_INSTANCE
    )
    app_collector_wait = BashOperator(
        task_id='app-collector-wait',
        bash_command=(
            f'gcloud compute instances tail-serial-port-output "{APP_COLLECTOR_INSTANCE}" '
            f'--zone "{ZONE}" '
            f'--project "{PROJECT_ID}" '
            f'|| true'
        )
    )

    app_collector_start >> app_collector_wait
