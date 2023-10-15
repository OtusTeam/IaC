#!/usr/bin/env python3
import random
import json
import argparse

def generate_dynamic_inventory():
    inventory = {
        'all': {
            'hosts': [],
        },
        'hello': {
            'hosts': []
        },
        'world': {
            'hosts': []
        },
        '_meta': {
            'hostvars': {},
        },
    }

    hostnames = ['hello', 'world']
    hosts = []
    for i in range(random.randint(2, 10)):
        hosts.append(random.choice(hostnames) + str(random.randint(1, 255)))

    for host in hosts:
        inventory['all']['hosts'].append(host)
        if host[0:5] == 'hello':
            inventory['hello']['hosts'].append(host)
            inventory['_meta']['hostvars'][host] = {'ansible_host': '127.0.0.1', 'ansible_connection': 'local'}
        else:
            inventory['world']['hosts'].append(host)
            ip_address = f'{random.randint(1, 255)}.{random.randint(1, 255)}.{random.randint(1, 255)}.{random.randint(1, 255)}'
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

