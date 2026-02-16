import os
import pytest
from pulumi import automation as auto
import uuid	# if you need a unique name
import boto3
from botocore.client import Config


@pytest.fixture(scope="session")
def stack():

    stack = auto.create_or_select_stack(
    #    stack_name="test", 
        stack_name = f"test-{uuid.uuid4()}", 		# if you need a unique name
        work_dir=".",   # где лежит Pulumi.yaml
    )

    # Установим значения в конфиг (в namespace yandex):
    stack.set_config("yandex:token",auto.ConfigValue(value=os.environ["YC_TOKEN"],secret=True))
    stack.set_config("yandex:cloudId",auto.ConfigValue(value=os.environ["YC_CLOUD_ID"]))
    stack.set_config("yandex:folderId",auto.ConfigValue(value=os.environ["YC_FOLDER_ID"]))
    # prefix (без namespace)
    stack.set_config("prefix",auto.ConfigValue(value=os.environ["PREFIX"]))

    stack.up(on_output=print)

    yield stack

    try:
        stack.destroy(on_output=print)
    finally:
        stack.workspace.remove_stack(stack.name)


def test_bucketName_output_exists(stack):
    outputs = stack.outputs()
    assert "bucketName" in outputs


def test_bucketName_value_is_not_null(stack):
    outputs = stack.outputs()
    value = outputs["bucketName"].value
    assert value != None and value != ""


def test_s3_object_content_matches_expected(stack):
    outputs = stack.outputs()

    bucket = outputs["bucketName"].value
    key = outputs["objectKey"].value

    # Берём ключи доступа из outputs
    access_key = outputs["accessKey"].value
    secret_key = outputs["secretKey"].value

    assert access_key and secret_key, "accessKey and secretKey must be present in Pulumi outputs"

    # Для Yandex Object Storage (измените endpoint при необходимости)
    endpoint = os.environ.get("YC_S3_ENDPOINT", "https://storage.yandexcloud.net")
    region = os.environ.get("YC_ZONE", None)

    s3 = boto3.client(
        "s3",
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key,
        endpoint_url=endpoint,
        config=Config(signature_version="s3v4"),
        region_name=region,
    )

    resp = s3.get_object(Bucket=bucket, Key=key)
    body_bytes = resp["Body"].read()
    # Попробуем декодировать как utf-8, иначе оставить bytes
    try:
        content = body_bytes.decode("utf-8")
    except Exception:
        content = body_bytes

    expected = os.environ.get("EXPECTED_OBJECT_CONTENT", "Hello, World!")
    if expected is not None:
        assert content == expected
    else:
        assert len(body_bytes) > 0
