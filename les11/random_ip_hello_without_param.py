#!/usr/bin/python3
import random
import json

def generate_dynamic_inventory():
    inventory = {
        'all': {
            'hosts': []
        },
        '_meta': {
            'hostvars': {}
        }
    }

    hosts = ['hello', 'world']
    for host in hosts:
        ip_address = f'{random.randint(1, 255)}.{random.randint(1, 255)}.{random.randint(1, 255)}.{random.randint(1, 255)}'
        inventory['all']['hosts'].append(host)
        inventory['_meta']['hostvars'][host] = {'ansible_host': ip_address}

    return inventory

def main():
    inventory = generate_dynamic_inventory()
    print(json.dumps(inventory))

if __name__ == '__main__':
    main()
