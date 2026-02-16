import os
import pytest
from pulumi import automation as auto
import uuid	# if you need a unique name


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
