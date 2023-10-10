# see: https://cloud.yandex.ru/docs/functions/lang/python/sdk

import os
import yandexcloud

from yandex.cloud.resourcemanager.v1.cloud_service_pb2 import ListCloudsRequest
from yandex.cloud.resourcemanager.v1.cloud_service_pb2_grpc import CloudServiceStub



def handler(event, context, sdk):
#    cloud_service = yandexcloud.SDK().client(CloudServiceStub)
    cloud_service = sdk.client(CloudServiceStub)
    clouds = {}
    for c in cloud_service.List(ListCloudsRequest()).clouds:
        clouds[c.id] = c.name
    return clouds


def main():
    token = os.getenv('YC_TOKEN')
    tokstart = token[0:4]
    tokend   = token[-4:]
    print (f"{tokstart=}, {tokend=}")
    sdk = yandexcloud.SDK(iam_token=token)

    clouds  = handler("event", "context", sdk)

    print(f"{clouds=}")


if __name__ == '__main__':
    main()

