#!/usr/bin/env python3
import logging
from sys import exit

from utils import arguments, log

APP_NAME, APP_VERSION = 'app-collector', '1.0.0-ALPHA'


def main():
    args = arguments.get()
    log.init(APP_NAME, APP_VERSION, args.log_path)
    logging.info(f'Arguments: {args}')
    logging.info('App Collector Works!')  # FIXME: Remove this log
    exit(0)


if __name__ == "__main__":
    try:
        main()
    except Exception as ex:
        logging.critical(f'Exception: {ex}')
        exit(1)
