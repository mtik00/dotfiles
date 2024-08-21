#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# WARNING: This file is managed by chezmoi.

"""
Generates random UUIDs and writes them to stdout.
"""

import argparse
import sys
import uuid


def get_args(args=sys.argv[1:]):
    parser = argparse.ArgumentParser(description="Create some random UUIDs")
    parser.add_argument(
        "-c",
        "--count",
        type=int,
        help="number of UUIDs to generate",
        default=10,
    )

    return parser.parse_args(args)


def main():
    args = get_args()
    for _ in range(args.count):
        print(uuid.uuid4())


if __name__ == "__main__":
    main()

