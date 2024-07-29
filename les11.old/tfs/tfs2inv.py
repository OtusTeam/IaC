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
# It is assumed that for study purposes only.
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

    for h in hosts:
        inventory['all']['hosts'].append(h.name)
        inventory['_meta']['hostvars'][h.name] = {}
        if h.nat_ip is not None:
            inventory['_meta']['hostvars'][h.name]["ansible_host"] = h.nat_ip
        if h.ssh_user is not None:
            inventory['_meta']['hostvars'][h.name]["ansible_user"] = h.ssh_user
        if h.key is not None:
            inventory['_meta']['hostvars'][h.name]["ansible_ssh_private_key_file"] = h.key

    if len(hosts) == 0:
        inventory = {}

    print(json.dumps(inventory))


# write hosts to file
def write2file(file, hosts):

    host_file = open(file, "w")

    for h in hosts:
        host = [h.name]
        if h.nat_ip is not None:
            host.append("ansible_host=" + h.nat_ip)
        if h.ssh_user is not None:
            host.append("ansible_user=" + h.ssh_user)
        if h.key is not None:
            host.append("ansible_ssh_private_key_file=" + h.key)
        host_file.write(" ".join(host) + "\n")

    host_file.close()


def parse_tfstate(args, hosts):

    state_file = open('terraform.tfstate')
    tfstate = json.load(state_file)
    state_file.close()

    for resource in tfstate['resources']:
        if resource['type'] == "yandex_compute_instance":
            for instance in resource['instances']:
                attribute = instance['attributes']
                if (args.host and args.host == attribute['name']) or args.list or args.file:
                    host = Host(attribute['name'])
                    if (network_interface := attribute.setdefault('network_interface')) is not None:
                        host.nat_ip = network_interface[0].setdefault('nat_ip_address')
                    if (metadata := attribute.setdefault('metadata')) is not None:
                        if (ssh_keys := metadata.setdefault('ssh-keys')) is not None:
                            if ssh_keys.find(':') > 0:
                                host.ssh_user = ssh_keys.split(':')[0]
                    hosts.append(host)


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

