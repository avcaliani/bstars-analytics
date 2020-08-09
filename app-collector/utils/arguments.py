from argparse import ArgumentParser


def get():
    parser = ArgumentParser()
    parser.add_argument('--api-url', required=True, help='API URL.')
    parser.add_argument('--api-token', required=True, help='API Token.')
    parser.add_argument('--api-retry', required=True, help='Times to retry an API call.')
    parser.add_argument('--output-path', required=True, help='Output files path.')
    parser.add_argument('--log-path', required=True, help='Log files path.')
    return parser.parse_args()
