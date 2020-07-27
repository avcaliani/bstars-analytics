from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.bash_operator import BashOperator

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

    first_task = BashOperator(
        task_id='first_task',
        bash_command='echo {{ dag_run.id }}'
    )

    second_task = BashOperator(
        task_id='second_task',
        bash_command='echo {{ dag_run.id }}'
    )

    first_task >> second_task
