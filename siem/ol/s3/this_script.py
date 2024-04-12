#!/usr/bin/env python
#-*- coding: utf-8 -*-
import boto3
session = boto3.session.Session()
s3 = session.client(
    service_name='s3',
    endpoint_url='https://storage.yandexcloud.net'
)

my_bucket_name = 'my-very-unical-bucket'

# Создать новый бакет
s3.create_bucket(Bucket=my_bucket_name)

# Загрузить объекты в бакет

## Из строки
s3.put_object(Bucket=my_bucket_name, Key='object_name', Body='TEST', StorageClass='COLD')

## Из файла
s3.upload_file('this_script.py', my_bucket_name, 'py_script.py')
s3.upload_file('this_script.py', my_bucket_name, 'script/py_script.py')

# Получить список объектов в бакете
for key in s3.list_objects(Bucket=my_bucket_name)['Contents']:
    print(key['Key'])

# Удалить несколько объектов
#forDeletion = [{'Key':'object_name'}, {'Key':'script/py_script.py'}]
#response = s3.delete_objects(Bucket=my_bucket_name, Delete={'Objects': forDeletion})

# Получить объект
get_object_response = s3.get_object(Bucket=my_bucket_name,Key='py_script.py')
print(get_object_response['Body'].read())
