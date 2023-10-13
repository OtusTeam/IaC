#!/usr/bin/env python3

# source from https://github.com/awh0ll/ansible-inventory-population/blob/master/main.py
# changed by Aleksei E. Zhuravlev for accepting YC-provider stucture of tfstate-file

import json
import argparse

class Host:
    def __init__(self, hostName, nat_ip=None, ssh_user=None, keyPath = None):
        self.name = hostName
        self.nat_ip = nat_ip
        self.ssh_user = ssh_user
        self.key = keyPath

#Take in a list of hosts, output it to a file name "hosts" in the execution directory.
def print_hosts(hostList):

    for i in hostList:
        temp = [i.name]
        if i.nat_ip is not None:
            temp.append("ansible_host=" + i.nat_ip)
        if i.ssh_user is not None:
            temp.append("ansible_user=" + i.ssh_user)
        if i.key is not None:
            temp.append("ansible_ssh_private_key_file=" + i.key)

        print(" ".join(temp))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--list', action='store_true', help='Вывести весь список хостов')
    parser.add_argument('--host', help='Указать конкретный хост')
    args = parser.parse_args()


    stateFile = open('terraform.tfstate')
    data = json.load(stateFile)
    stateFile.close()

    #ansible hosts
    hosts = []

    #Iterate through the resources in tfstate
    for i in data['resources']:
        #We only care about AWS instances
        if i['type'] == "yandex_compute_instance":
            for j in i['instances']:
                ja = j['attributes']
                if (args.host and args.host == ja['name']) or args.list:
                     hosts.append(Host(ja['name'], ja['network_interface'][0]['nat_ip_address'], ja['metadata']['ssh-keys'].split(':')[0]))

    print_hosts(hosts)


if __name__ == '__main__':
    main()
