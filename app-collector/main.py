#!/usr/bin/env python3
from sys import exit


def main():
    print('App Collector Works!')


if __name__ == "__main__":
    status = 0
    try:
        main()
    except Exception as ex:
        print(f'FATAL! {ex}')
        status = 1
    exit(status)
