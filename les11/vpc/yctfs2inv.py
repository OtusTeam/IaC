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
# Generate dynamic inventory from YC-provider structure of tfstate-file.
# For study purposes only.
#
########################################################################################################################

import json
import argparse

class Host:
    def __init__(self, name, nat_ip=None, ssh_user=None, key=None):
        self.name = name
        self.nat_ip = nat_ip
        self.ssh_user = ssh_user
        self.key = key


def print_json(hosts):
    inventory = {
        'all': {
            'hosts': [],
        },
        '_meta': {
            'hostvars': {},
        },
    }

    for i in hosts:
        inventory['all']['hosts'].append(i.name)
        # inventory['_meta']['hostvars'][i.name] = {'ansible_host': i.nat_ip, 'ansible_user': i.ssh_user}
        inventory['_meta']['hostvars'][i.name] = {}
        if i.nat_ip is not None:
            inventory['_meta']['hostvars'][i.name]["ansible_host"] = i.nat_ip
        if i.ssh_user is not None:
            inventory['_meta']['hostvars'][i.name]["ansible_user"] = i.ssh_user
        if i.key is not None:
            inventory['_meta']['hostvars'][i.name]["ansible_ssh_private_key_file"] = i.key

    if len(hosts) == 0:
        inventory = {}

    print(json.dumps(inventory))


# write hosts to file
def write2file(file, hosts):

    hostFile = open(file, "w")

    for i in hosts:
        temp = [i.name]
        if i.nat_ip is not None:
            temp.append("ansible_host=" + i.nat_ip)
        if i.ssh_user is not None:
            temp.append("ansible_user=" + i.ssh_user)
        if i.key is not None:
            temp.append("ansible_ssh_private_key_file=" + i.key)
        hostFile.write(" ".join(temp) + "\n")

    hostFile.close()


def parse_tfstate(args, hosts):

    stateFile = open('terraform.tfstate')
    data = json.load(stateFile)
    stateFile.close()

    for i in data['resources']:
        if i['type'] == "yandex_compute_instance":
            for j in i['instances']:
                ja = j['attributes']
                if (args.host and args.host == ja['name']) or args.list or args.file:
                     hosts.append(Host(ja['name'], ja['network_interface'][0]['nat_ip_address'], ja['metadata']['ssh-keys'].split(':')[0]))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--list', action='store_true', help='Вывести весь список хостов')
    parser.add_argument('--host', help='Указать конкретный хост')
    parser.add_argument('--file', help='Указать файл')
    args = parser.parse_args()

    #ansible hosts
    hosts = []
    parse_tfstate(args, hosts)

    if args.file:
        write2file(args.file, hosts)
    else:
        print_json(hosts)

if __name__ == '__main__':
    main()

