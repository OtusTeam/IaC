import os
import time
import pytest
from pulumi import automation as auto
import uuid	# if you need a unique name
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
    stack.set_config("yandex:zone",auto.ConfigValue(value=os.environ["YC_ZONE"]))

    # prefix (без namespace)
    stack.set_config("prefix",auto.ConfigValue(value=os.environ["PREFIX"]))
    stack.set_config("username",auto.ConfigValue(value=os.environ["YC_USERNAME"]))
    stack.set_config("imageId",auto.ConfigValue(value=os.environ["YC_IMAGE_ID"]))
    stack.set_config("cidr",auto.ConfigValue(value=os.environ["YC_CIDR"]))
    stack.set_config("pub",auto.ConfigValue(value=os.environ["PUB_KEY_PATH"]))

    stack.up(on_output=print)

    yield stack

    try:
        stack.destroy(on_output=print)
    finally:
        stack.workspace.remove_stack(stack.name)


def test_outputs_exists(stack):
    outputs = stack.outputs()
    assert "instance_name" in outputs
    assert "public_ip" in outputs


def test_outputs_values_is_not_null(stack):
    outputs = stack.outputs()
    instance_name = outputs["instance_name"].value
    assert instance_name != None and instance_name != ""
    public_ip = outputs["public_ip"].value
    assert public_ip != None and public_ip != ""


def test_lemp_server_responds(stack):
    outputs = stack.outputs()
    ip = outputs["public_ip"].value

    url = f"http://{ip}/"

    # Параметры: общее ожидание (сек), задержка между попытками (сек), таймаут запроса (сек)
    total_wait = int(os.environ.get("LEMP_TOTAL_WAIT", "300"))  # default 5 minutes
    interval = int(os.environ.get("LEMP_RETRY_INTERVAL", "5"))  # default 5s
    req_timeout = int(os.environ.get("LEMP_REQ_TIMEOUT", "30"))  # default 30s

    deadline = time.time() + total_wait
    last_exc = None

    # Небольшая первая пауза
    time.sleep(10)

    while time.time() < deadline:
        try:
            resp = requests.get(url, timeout=req_timeout)
            resp.raise_for_status()
            # Успех — страница доступна (HTTP 2xx)
            return
        except RequestException as e:
            last_exc = e
            # Если тест запущен в интерактивном режиме и пользователь хочет контролировать,
            # можно читать переменную окружения LEMP_ALLOW_INTERACTIVE=yes
            allow_interactive = os.environ.get("LEMP_ALLOW_INTERACTIVE", "no").lower() in ("1", "yes", "true")
            if allow_interactive and sys.stdin and sys.stdin.isatty():
                ans = input(f"Request to {url} failed: {e}\nCancel (y/N)? ").strip().lower()
                if ans in ("y", "yes"):
                    pytest.skip("Cancelled by user")
            # Иначе ждём и пробуем снова
            time.sleep(interval)

    # Если вышли по таймауту — считаем это провалом, показываем последнее исключение
    pytest.fail(f"LEMP server did not respond within {total_wait} seconds. Last error: {last_exc}")

