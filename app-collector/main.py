#!/usr/bin/env python3
import logging
from sys import exit

from utils import arguments, log

APP_NAME, APP_VERSION = 'app-collector', '1.0.0-ALPHA'


def main():
    args = arguments.get()
    log.init(APP_NAME, APP_VERSION, args.log_path)
    logging.info(f'Arguments: {args}')
    print('App Collector Works!')


if __name__ == "__main__":
    status = 0
    try:
        main()
    except Exception as ex:
        print(f'FATAL! {ex}')
        status = 1
    exit(status)
