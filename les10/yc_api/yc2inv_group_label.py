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
import json
from yandexcloud import SDK
from yandex.cloud.compute.v1.instance_service_pb2_grpc import InstanceServiceStub
from yandex.cloud.compute.v1.instance_service_pb2 import ListInstancesRequest
from google.protobuf.json_format import MessageToDict

def get_hosts(sdk, folder_id):

    self_hosts = []
    self_instance_service = sdk.client(InstanceServiceStub)

    hosts = self_instance_service.List(ListInstancesRequest(folder_id=folder_id))
    dict_ = MessageToDict(hosts)

    if dict_:
       self_hosts += dict_["instances"]

    return self_hosts


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--list', action='store_true', help='Вывести весь список хостов')
    parser.add_argument('--host', help='Указать конкретный хост')
    args = parser.parse_args()

    token = os.getenv('YC_TOKEN')
    if token is None:
       print(f'Error: YC_TOKEN is not set as env variable')
       exit(1)

    sdk = SDK(iam_token=token)

    folder_id = os.getenv('YC_FOLDER_ID')
    if folder_id is None:
       print(f'Error: YC_FOLDER_ID is not set as env variable')
       exit(1)

    hosts = get_hosts(sdk, folder_id)

    inventory = {
        'all': {
            'hosts': []
        },
        '_meta': {
            'hostvars': {}
        }
    }

    for h in hosts:
        name = h['name']
        if h['status'] == 'RUNNING' and (args.host and args.host == name or args.list):
            inventory['all']['hosts'].append(name)
            inventory['_meta']['hostvars'][name] = {}
            if (networkInterfaces := h.setdefault('networkInterfaces')) is not None:
                if len(networkInterfaces) >= 1:
                    if (primaryV4Address := networkInterfaces[0].setdefault('primaryV4Address')) is not None:
                        if (oneToOneNat := primaryV4Address.setdefault('oneToOneNat')) is not None:
                            if (address := oneToOneNat.setdefault('address')) is not None:
                                inventory['_meta']['hostvars'][name]["ansible_host"] = address
            if (labels := h.setdefault('labels')) is not None:
                inventory['_meta']['hostvars'][name]["ansible_labels"] = labels
                if (group := labels["group"]) is not None:
                    inventory['_meta']['hostvars'][name]["ansible_group"] = group

    if len(inventory['all']['hosts']) == 0:
        inventory = {}

    print(json.dumps(inventory))

if __name__ == '__main__':
    main()
