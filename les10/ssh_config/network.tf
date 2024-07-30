resource "yandex_vpc_network" "network" {
  name = "les10-ssh-config-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "les10-ssh-config-subnet"
  v4_cidr_blocks = ["10.3.0.0/16"]
  zone           = var.yc_default_zone
  network_id     = yandex_vpc_network.network.id
}

