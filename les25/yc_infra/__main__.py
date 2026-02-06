import pulumi
import pulumi_yandex as yandex

# 1. Получаем конфигурацию
config = pulumi.Config("yandex")
prefix = config.require("prefix")
token = config.require("token")
cloud_id = config.require("cloudId")
folder_id = config.require("folderId")
zone = config.require("zone")
cidr = config.require("cidr")
ssh_pub_key_path = config.require("pub")
image_id = config.require("imageId")
username = config.require("username")

# 2. Создаём провайдер
provider = yandex.Provider(
    "yandex",
    token=token,
    cloud_id=cloud_id,
    folder_id=folder_id,
)

# 3. Создаём сеть и подсеть
network = yandex.VpcNetwork(
    prefix+"-network",
    opts=pulumi.ResourceOptions(provider=provider),
)

subnet = yandex.VpcSubnet(
    prefix+"-subnet",
    zone=zone,
    network_id=network.id,
    v4_cidr_blocks=[cidr],
    opts=pulumi.ResourceOptions(provider=provider),
)

# 4. Читаем файл напрямую через Python

try:
    with open(ssh_pub_key_path, "r") as f:
        ssh_pub_key = f.read()
except Exception as e:
    raise RuntimeError(f"Не удалось прочитать SSH-ключ: {e}")

# 5. Создаём Compute Instance
instance = yandex.ComputeInstance(
    prefix+"-instance",
    zone=zone,
    resources=yandex.ComputeInstanceResourcesArgs(
        core_fraction=5,
        cores=2,
        memory=2,
    ),
    boot_disk=yandex.ComputeInstanceBootDiskArgs(
        initialize_params=yandex.ComputeInstanceBootDiskInitializeParamsArgs(
            image_id=image_id,  # Ubuntu 22.04 LTS?
        ),
    ),
    network_interfaces=[
        yandex.ComputeInstanceNetworkInterfaceArgs(
            subnet_id=subnet.id,
            nat=True,  # чтобы был публичный IP
        )
    ],
    metadata={
        "ssh-keys": pulumi.Output.format(username+":{0}", ssh_pub_key),
    },
    scheduling_policy={
        "preemptible": True,
    },
    opts=pulumi.ResourceOptions(provider=provider),
)

# 6. Экспортируем публичный IP
public_ip = instance.network_interfaces[0].nat_ip_address

pulumi.export("instance_name", instance.name)
pulumi.export("public_ip", public_ip)
