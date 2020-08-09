import logging
from datetime import datetime


def init(app_name, app_version, log_path):
    date = datetime.utcnow().strftime("%Y%m%d%H%M%S")
    log_file = f'{log_path}/{app_name}-{app_version}-{date}.log'
    logging.basicConfig(
        filename=log_file,
        filemode='a',
        format='[%(asctime)s][%(name)s][%(levelname)s] %(message)s',
        datefmt='%Y-%m-%d %H:%M:%S',
        level=logging.INFO
    )
    logging.info(f'Log file saved at "{log_file}"')
