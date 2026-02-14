import pulumi
import pulumi_yandex as yandex

# Конфиг провайдера yandex

ycfg = pulumi.Config("yandex")
zone = ycfg.require("zone")

# Конфиг проекта (без namespace)

cfg = pulumi.Config()
prefix = cfg.require("prefix")
cidr = cfg.require("cidr")
ssh_pub_key_path = cfg.require("pub")
username = cfg.require("username")
image_id = cfg.require("imageId")

# Создаём сеть и подсеть

network = yandex.VpcNetwork(
    prefix+"-network",
)

subnet = yandex.VpcSubnet(
    prefix+"-subnet",
    zone=zone,
    network_id=network.id,
    v4_cidr_blocks=[cidr],
)

# Читаем файл напрямую через Python

try:
    with open(ssh_pub_key_path, "r") as f:
        ssh_pub_key = f.read()
except Exception as e:
    raise RuntimeError(f"Не удалось прочитать SSH-ключ: {e}")

# Создаём Compute Instance

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
            image_id=image_id,  # LEMP
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
)

# Экспортируем публичный IP

pulumi.export("instance_name", instance.name)
pulumi.export("public_ip", instance.network_interfaces[0].nat_ip_address)
