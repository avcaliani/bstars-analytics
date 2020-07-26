import json
import logging
from datetime import datetime
from os import path
from time import sleep

import requests


def run(args):
    tags = get_user_tags()
    for tag in tags:
        logging.info(f'Requesting user "{tag}" data...')
        data = request(args.api_url, args.api_token, args.api_retry, tag)
        if not data:
            logging.error(f'It was not possible to retrieve user data for tag "{tag}".')
        else:
            save(data, args.output_path, tag)


def get_user_tags():
    tags_file = path.join(path.dirname(__file__), '../resources/tags.txt')
    with open(tags_file) as file:
        tags = list(dict.fromkeys([line.rstrip() for line in file]))
        logging.info(f'"{len(tags)}" user tags found.')
        return tags


def request(api_url, api_token, api_retry, user_tag):
    url = f'{api_url}/%{user_tag}'
    headers = {
        'Accept': 'application/json',
        'authorization': f'Bearer {api_token}'
    }
    for i in range(int(api_retry)):
        response = requests.get(url, headers=headers)
        logging.info(f'[{user_tag}][{i + 1}] Response code: {response.status_code}')
        if response.status_code == 200:
            return response.json()
        else:
            logging.warning(f'[{user_tag}][{i + 1}] Waiting to try again...')
            sleep(5)
    return None


def save(data, output_path, user_tag):
    file_name = f'{output_path}/{user_tag}-{datetime.utcnow().strftime("%Y%m%d%H%M%S")}.json'
    logging.info(f'Writing file "{file_name}"')
    with open(file_name, 'w') as outfile:
        json.dump(data, outfile)
