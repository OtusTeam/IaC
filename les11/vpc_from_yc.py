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

import os
import argparse
from yandexcloud import SDK

# sdk = SDK()


def get_hosts_by_vpc(sdk, vpc_id):

#    sdk = SDK()

    folder_id = os.getenv('YC_FOLDER_ID')
    filter = f'networkInterfaces.subnetId="{vpc_id}"'

    print(f"{folder_id=}, {filter=}")

    compute = sdk.client('compute')
    hosts = []

#    folder_id = os.getenv('YC_FOLDER_ID')
#    filter = f'networkInterfaces.subnetId="{vpc_id}"'
#
#    print(f"{folder_id=}, {filter=}")

    # Получаем список всех инстансов в указанной VPC
#    instances = compute.instances().list(folder_id=os.getenv('YC_FOLDER_ID'), filter=f'networkInterfaces.subnetId="{vpc_id}"').result().instances
    instances = compute.instances().list(folder_id=folder_id, filter=filter).result().instances
    for instance in instances:
        # Получаем внутренние IP-адреса инстансов
        internal_ips = [iface.primary_v4_address.address for iface in instance.network_interfaces]
        if internal_ips:
            hosts.append(instance.name)

    return hosts

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--vpc-id', required=True, help='ID VPC в облаке Yandex.Cloud')
    args = parser.parse_args()

    token = os.getenv('YC_TOKEN')
    tokstart = token[0:4]
    tokend   = token[-4:]
    print (f"{tokstart=}, {tokend=}")
    sdk = SDK(token=token)


    hosts = get_hosts_by_vpc(sdk, args.vpc_id)

    inventory = {
        'all': {
            'hosts': hosts
        },
        '_meta': {
            'hostvars': {}
        }
    }

    print(json.dumps(inventory))

if __name__ == '__main__':
    main()
