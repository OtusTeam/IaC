import pytest
from pulumi.automation import create_or_select_stack


@pytest.fixture(scope="session")
def stack():

    stack = create_or_select_stack(
        stack_name="test",
        work_dir=".",   # где лежит Pulumi.yaml
    )

    stack.up(on_output=print)

    yield stack

    stack.destroy(on_output=print)
    stack.workspace.remove_stack("test")

def test_hello_key(stack):
    outputs = stack.outputs()
    assert "helloWorld" in outputs

def test_hello_value(stack):
    outputs = stack.outputs()
    assert outputs["helloWorld"].value == "Hello, World!"
