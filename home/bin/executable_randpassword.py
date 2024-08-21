#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# WARNING: This file is managed by chezmoi.

"""
Generates random passwords and writes them to stdout.
"""

import argparse
import random
import string
import sys


def get_args(args=sys.argv[1:]):
    parser = argparse.ArgumentParser(description="Create some random passwords")
    parser.add_argument(
        "-l", "--length", type=int, help="length of each password to generate", default=32
    )
    parser.add_argument(
        "-c", "--count", type=int, help="number of passwords to generate for each range", default=5
    )

    return parser.parse_args(args)


def main():
    args = get_args()

    shell_no_need_escape = ",._+:@%/-}]"

    ranges = (
        string.ascii_letters + string.digits + string.punctuation,
        string.ascii_letters + string.digits + shell_no_need_escape,
        string.ascii_letters + string.digits,
        string.ascii_lowercase + string.digits,
    )

    print("---- most secure")

    for index, r in enumerate(ranges):
        for _ in range(args.count):
            password = ""
            for _ in range(args.length):
                password += random.choice(r)

            print(password)

        if index < len(ranges) - 1:
            print("---")

    print("---- least secure")


if __name__ == "__main__":
    main()

