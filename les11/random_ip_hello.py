#!/usr/bin/env python3
import random
import json
import argparse

def generate_dynamic_inventory():
    inventory = {
        'all': {
            'hosts': [],
        },
        '_meta': {
            'hostvars': {},
        },
    }

    hosts = ['hello', 'world']
    for host in hosts:
        ip_address = f'{random.randint(1, 255)}.{random.randint(1, 255)}.{random.randint(1, 255)}.{random.randint(1, 255)}'
        inventory['all']['hosts'].append(host)
        inventory['_meta']['hostvars'][host] = {'ansible_host': ip_address}

    return inventory

def get_inventory(args):
    inventory = generate_dynamic_inventory()

    if args.host:
        if args.host in inventory['_meta']['hostvars']:
            host_vars = inventory['_meta']['hostvars'][args.host]
            inventory = {
                '_meta': {
                    'hostvars': host_vars,
                },
            }
        else:
            inventory = {}

    return inventory

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--list', action='store_true', help='Вывести весь список хостов')
    parser.add_argument('--host', help='Указать конкретный хост')
    args = parser.parse_args()

    inventory = get_inventory(args)
    print(json.dumps(inventory))

if __name__ == '__main__':
    main()
