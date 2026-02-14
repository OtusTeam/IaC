import pulumi
import pulumi_yandex as yandex
import requests
import base64

# Получаем конфигурацию провайдера

ycfg = pulumi.Config("yandex")
folder_id = ycfg.require("folderId")

# Получаем конфигурацию проекта

config = pulumi.Config()
prefix = config.require("prefix")
from_url = config.require("fromUrl")


# Сформируем имя бакета
bucket_name = f"{prefix}-s3-python-{pulumi.get_stack()}"

# Выполняем HTTP-запрос при 'pulumi up'
resp = requests.get(from_url)	# https://jsonplaceholder.typicode.com/posts ?

resp.raise_for_status()
items = resp.json()[:3]

# Создаем сервисный аккаунт для доступа к Object Storage
sa = yandex.IamServiceAccount(
    prefix+"-s3",
    folder_id=folder_id,
    description="Service account for pulumi demo",
)

# Даем сервисному аккаунту роль storage.editor в папке
sa_role = yandex.ResourcemanagerFolderIamMember(
    prefix+"sa-storage-editor",
    folder_id=folder_id,
    role="storage.editor",
    member=sa.id.apply(lambda id: f"serviceAccount:{id}"),
    opts=pulumi.ResourceOptions(depends_on=[sa]),
)

# Создаем статический ключ сервисного аккаунта (используется для доступа к Object Storage)
sa_key = yandex.IamServiceAccountStaticAccessKey(
    prefix+"sa-static-key",
    service_account_id=sa.id,
    description="static key for object storage",
    opts=pulumi.ResourceOptions(depends_on=[sa_role]),
)

# Создаем Storage Bucket (Yandex Object Storage)
bucket = yandex.StorageBucket(
    bucket_name,
    access_key=sa_key.access_key,   # можно передавать ключи для управления бакетом
    secret_key=sa_key.secret_key,
    bucket=bucket_name,
    acl="private",
    opts=pulumi.ResourceOptions(depends_on=[sa_key]),
)

# Динамически создаем объекты в бакете на основании items
objects = []
for it in items:
    key = f"post-{it['id']}.txt"
    content = f"Title: {it['title']}\n\n{it['body']}"
    # StorageObject принимает content_base64 — используем base64 для безопасной передачи
    obj = yandex.StorageObject(
        f"obj-{it['id']}",
        bucket=bucket.bucket,
        key=key,
        content_base64=base64.b64encode(content.encode("utf-8")).decode("utf-8"),
        acl="private",
        access_key=sa_key.access_key,   # ключи для управления бакетом
        secret_key=sa_key.secret_key,
        opts=pulumi.ResourceOptions(depends_on=[bucket]),
    )
    objects.append(obj)

# Экспортируем outputs: имя бакета, список ключей, и секретный static key secret
# Помечаем secret как secret output — Pulumi зашифрует его в стейте
pulumi.export("bucket_name", bucket.bucket)
pulumi.export("created_keys", pulumi.Output.all(*[o.key for o in objects]))
pulumi.export("sa_access_key_id", sa_key.access_key)  # можно не помечать секретом
pulumi.export("sa_secret_key", pulumi.Output.secret(sa_key.secret_key))
