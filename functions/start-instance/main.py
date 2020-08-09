import base64
import json
import logging

from google.cloud.storage import Client
from googleapiclient import discovery


def start_instance(project, zone, instance):
    logging.getLogger('googleapiclient.discovery_cache').setLevel(logging.ERROR)
    service = discovery.build('compute', 'v1')
    response = service.instances().start(project=project, zone=zone, instance=instance).execute()
    return response['id']


def count_files(bucket_name, bucket_dir):
    return len(list(Client().list_blobs(bucket_name, prefix=bucket_dir)))


def get_data(event):
    try:
        return json.loads(base64.b64decode(event['data']).decode('utf-8'))
    except Exception as ex:
        print(f'Error while parsing message data: {str(ex)}')
        raise ex


def main(event, context):
    print(f'Message ID: {context.event_id}')
    print(f'Message Timestamp: {context.timestamp}')
    
    data = get_data(event)
    print(f'Message Data: {data}')
    
    bucket, directory = data.get('bucket', ''), data.get('bucket_dir', '')
    if bucket:
        print(f'Bucket "{bucket}/{directory}" has {count_files(bucket, directory)} files')

    exec_id = start_instance(
        project=data.get('project'),
        zone=data.get('zone'),
        instance=data.get('compute_instance')
    )
    print(f'Execution ID: {exec_id}')
