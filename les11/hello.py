#!/usr/bin/env python3

########################################################################################################################
#
# (C) 2023 Copyright Aleksei E. Zhuravlev
#
# This code is licensed under the Apache License, Version 2.0. You may
# obtain a copy of this license in the LICENSE-2.0.txt file in the root directory
# of this source tree or at https://www.apache.org/licenses/LICENSE-2.0
#
# Any modifications or derivative works of this code must retain this
# copyright notice, and modified files need to carry a notice indicating
# that they have been altered from the originals.
#
########################################################################################################################
#
# The purpose of this program:
# 	1. Training (at least mine and whoever wants) of
# 	the internal structure and principles of the ansible dynamic inventory script
#	2. Usage in study and work
#
########################################################################################################################

import argparse
import json

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--list', action="store_true", help='list of all hosts')
    parser.add_argument('--host', help='only specified HOST')
#    parser.add_argument('--graph', default action="store_true", help='graph of all hosts or specified group')
    args = parser.parse_args()

    hosts = ['hello', 'world']

    inventory = {
        'all': {
            'hosts': hosts
        },
        '_meta': {
            'hostvars': {}
        }
    }

#    print(f"{inventory=}")

    if args.list:
        print(json.dumps(inventory))
    elif args.host:
        print(hosts[hosts.index(args.host)])
    else:
        print("Call error: at least one argument is required!")

if __name__ == '__main__':
    main()
