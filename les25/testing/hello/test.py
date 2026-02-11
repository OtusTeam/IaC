import json
import subprocess
import pytest


@pytest.fixture(scope="session")
def outputs():
    result = subprocess.run(
        ["pulumi", "stack", "output", "--json"],
        check=True,
        capture_output=True,
        text=True,
    )
    return json.loads(result.stdout)


def test_hello_output_exists(outputs):
    assert "helloWorld" in outputs


def test_hello_output_value(outputs):
    assert outputs["helloWorld"] == "Hello, World!"
