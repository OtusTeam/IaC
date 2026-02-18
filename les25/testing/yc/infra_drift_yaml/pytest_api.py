import os
import time
import subprocess, shlex, sys
import pytest
from pulumi import automation as auto
import uuid	# if you need a unique name
import requests
from requests.exceptions import RequestException

# Глобальные переменные:
folder_id = os.environ["YC_FOLDER_ID"]


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
    stack.set_config("yandex:folderId",auto.ConfigValue(value=folder_id))
    stack.set_config("yandex:zone",auto.ConfigValue(value=os.environ["YC_ZONE"]))

    # prefix (без namespace)
    stack.set_config("prefix",auto.ConfigValue(value=os.environ["PREFIX"]))
    stack.set_config("username",auto.ConfigValue(value=os.environ["YC_USERNAME"]))
    stack.set_config("imageId",auto.ConfigValue(value=os.environ["YC_IMAGE_ID"]))
    stack.set_config("cidr",auto.ConfigValue(value=os.environ["YC_CIDR"]))
    
    ssh_pub_key_path = os.environ["PUB_KEY_PATH"]
    try:
        with open(ssh_pub_key_path, "r") as f:
            ssh_pub_key = f.read()
    except Exception as e:
        raise RuntimeError(f"Не удалось прочитать SSH-ключ: {e}")

    stack.set_config("pub",auto.ConfigValue(ssh_pub_key))

    stack.up(on_output=print)

    yield stack

    try:
        stack.destroy(on_output=print)
    finally:
        stack.workspace.remove_stack(stack.name)


def _checked_output_value(outputs, name):
    value = outputs[name].value
    assert value != None and value != ""
    return value
    

outputs_key = ("instance_id", "instance_name", "instance_nat_ip", "network_id", "network_name", "subnet_id", "subnet_name")


def test_outputs_values(stack):
    outputs = stack.outputs()
    assert all(k in outputs and  _checked_output_value(outputs, k) != None for k in outputs_key)


def test_lemp_server_responds(stack):
    outputs = stack.outputs()
    ip = _checked_output_value(outputs, "instance_nat_ip")

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


def test_pulumi_detects_drift(stack):
    # Подготовка: убедимся, что в outputs есть subnet_id
    outputs 	= stack.outputs()
    subnet_id 	= _checked_output_value(outputs, "subnet_id")
    subnet_name = _checked_output_value(outputs, "subnet_name")

    p = subprocess.run(
        shlex.split(f"yc vpc subnet update --id {subnet_id} --folder-id {folder_id} --new-name {subnet_name+'ed'}"),
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
    )
    assert p.returncode == 0

    # Запускаем refresh preview-only через Automation API, чтобы обнаружить дрифт
    refresh_res = stack.refresh(on_output=print)

    # refresh_res.summary содержит информацию о ресурсных изменениях (create/update/delete)
    summary = getattr(refresh_res, "summary", None)
    if summary is None:
        # Старые версии Automation API возвращают структуру иначе; попытаемся проверить stdout/outputs
        pytest.fail("refresh did not return summary; cannot determine drift")
    else:
        changes = getattr(summary, "resource_changes", None)
        # Ожидаем, что будет обнаружено изменение для подсети (updated)
        assert changes is not None, "No resource_changes in refresh summary"
        # Подход: любой ненулевой суммарный счетчик означает дрифт. Проверим updated > 0.
        updated = int(changes.get('update', 0))
        changed = int(changes.get('change', 0))
        assert (updated + changed) > 0, f"No changes detected by refresh; summary: {changes}"

#    p = subprocess.run(
#        shlex.split(f"yc vpc subnet update --id {subnet_id} --folder-id {folder_id} --new-name {subnet_name}"),
#        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
#    )
#    assert p.returncode == 0

