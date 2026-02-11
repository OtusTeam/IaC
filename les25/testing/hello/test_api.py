import pytest
from pulumi.automation import create_or_select_stack
import uuid	# if you need a unique name


@pytest.fixture(scope="session")
def stack():

    stack = create_or_select_stack(
#        stack_name="test", 
        stack_name = f"test-{uuid.uuid4()}", 		# if you need a unique name
        work_dir=".",   # где лежит Pulumi.yaml
    )

    # Настроим конфиг (если нужно)
    # stack.set_config("yandex:folderId", {"value": "..."} )

    stack.up(on_output=print)

    yield stack

    try:
        stack.destroy(on_output=print)
    finally:
        stack.workspace.remove_stack(stack.name)

def test_hello_key(stack):
    outputs = stack.outputs()
    assert "helloWorld" in outputs

def test_hello_value(stack):
    outputs = stack.outputs()
    assert outputs["helloWorld"].value == "Hello, World!"
