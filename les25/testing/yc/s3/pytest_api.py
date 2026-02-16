import os
import pytest
from pulumi import automation as auto
import uuid	# if you need a unique name
import boto3
from botocore.client import Config
import requests
from requests.exceptions import RequestException


@pytest.fixture(scope="session")
def stack():

    stack = auto.create_or_select_stack(
        # stack_name="test", 
        stack_name = f"test-{uuid.uuid4()}", 		# if you need a unique name
        work_dir=".",   # где лежит Pulumi.yaml
    )

    # Установим значения в конфиг (в namespace yandex):
    stack.set_config("yandex:token",auto.ConfigValue(value=os.environ["YC_TOKEN"],secret=True))
    stack.set_config("yandex:cloudId",auto.ConfigValue(value=os.environ["YC_CLOUD_ID"]))
    stack.set_config("yandex:folderId",auto.ConfigValue(value=os.environ["YC_FOLDER_ID"]))
    # prefix (без namespace)
    stack.set_config("prefix",auto.ConfigValue(value=os.environ["PREFIX"]))
    stack.set_config("fromUrl",auto.ConfigValue(value=os.environ["FROM_URL"]))

    stack.up(on_output=print)

    yield stack

    try:
        stack.destroy(on_output=print)
    finally:
        stack.workspace.remove_stack(stack.name)


def _make_s3_client(access_key, secret_key):
    endpoint = os.environ.get("YC_S3_ENDPOINT", "https://storage.yandexcloud.net")
    zone = os.environ.get("YC_ZONE", None)
    return boto3.client(
        "s3",
        aws_access_key_id=access_key,
        aws_secret_access_key=secret_key,
        endpoint_url=endpoint,
        config=Config(signature_version="s3v4"),
        region_name=zone,
    )


def _expected_items_from_remote():
    resp = requests.get(os.environ["FROM_URL"])
    resp.raise_for_status()
    items = resp.json()[:3]
    expected_map = {}
    for it in items:
        key = f"post-{it['id']}.txt"
        expected_content = f"Title: {it['title']}\n\n{it['body']}"
        expected_map[key] = expected_content
    return expected_map


def _expected_items_from_remote_or_skip():
    from_url=os.environ["FROM_URL"]
    # print(f"{from_url=}")
    try:
        resp = requests.get(from_url, timeout=10)
        resp.raise_for_status()
    except RequestException as e:
        pytest.skip(f"Skipping remote-dependent test: failed to fetch {url}: {e}")
    try:
        items = resp.json()[:3]
    except ValueError as e:
        pytest.skip(f"Skipping remote-dependent test: invalid JSON from {url}: {e}")
    expected_map = {}
    for it in items:
        key = f"post-{it['id']}.txt"
        expected_content = f"Title: {it['title']}\n\n{it['body']}"
        expected_map[key] = expected_content
    return expected_map


def test_bucketName_output_exists(stack):
    outputs = stack.outputs()
    assert "bucket_name" in outputs


def test_bucketName_value_is_not_null(stack):
    outputs = stack.outputs()
    value = outputs["bucket_name"].value
    assert value != None and value != ""


def test_s3_objects_exist(stack):
    outputs = stack.outputs()
    bucket = outputs["bucket_name"].value
    keys = outputs["created_keys"].value
    access_key = outputs["sa_access_key_id"].value
    secret_key = outputs["sa_secret_key"].value

    assert bucket, "bucket_name missing in outputs"
    assert keys and isinstance(keys, (list, tuple)), "created_keys must be a list"
    assert access_key and secret_key, "service account keys missing"

    s3 = _make_s3_client(access_key, secret_key)

    for key in keys:
        resp = s3.head_object(Bucket=bucket, Key=key)
        assert "ContentLength" in resp and resp["ContentLength"] >= 0, f"object {key} missing or empty"

def test_s3_objects_content_matches_remote(stack):
    outputs = stack.outputs()
    bucket = outputs["bucket_name"].value
    keys = outputs["created_keys"].value
    access_key = outputs["sa_access_key_id"].value
    secret_key = outputs["sa_secret_key"].value

    assert bucket and keys and access_key and secret_key

    s3 = _make_s3_client(access_key, secret_key)
    # expected_map = _expected_items_from_remote()
    expected_map = _expected_items_from_remote_or_skip()

    for key in keys:
        # загрузка объекта в память
        resp = s3.get_object(Bucket=bucket, Key=key)
        body_bytes = resp["Body"].read()
        try:
            content = body_bytes.decode("utf-8")
        except Exception:
            content = body_bytes

        # Если Pulumi сохранял content_base64, в хранилище лежит уже декодированный контент,
        # поэтому сравниваем напрямую с expected_map[key]
        assert key in expected_map, f"unexpected key {key}"
        assert content == expected_map[key], f"content mismatch for {key}"