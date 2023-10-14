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
# Generate dynamic inventory from YC by its API.
# It is assumed that for study purposes only.
#
########################################################################################################################

import os
import argparse
from yandexcloud import SDK

def get_hosts_by_vpc(sdk, folder_id, vpc_id):

    filter = f'networkInterfaces.subnetId="{vpc_id}"'

    print(f"{filter=}")

    compute = sdk.client('compute')
    hosts = []

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
    sdk = SDK(iam_token=token)


    folder_id = os.getenv('YC_FOLDER_ID')
    print(f"{folder_id=}")


    hosts = get_hosts_by_vpc(sdk, folder_id, args.vpc_id)

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
