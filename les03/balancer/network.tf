resource "yandex_vpc_network" "les03_network" {
  name = "les03_network"
}

resource "yandex_vpc_subnet" "les03_subnet_a" {
  name           = "les03_subnet_a"
  zone           = var.lamp.zone
  network_id     = yandex_vpc_network.les03_network.id
  v4_cidr_blocks = var.lamp.cidr
}

resource "yandex_vpc_subnet" "les03_subnet_b" {
  name           = "les03_subnet_b"
  v4_cidr_blocks = var.lemp.cidr
  zone           = var.lemp.zone
  network_id     = yandex_vpc_network.les03_network.id
}
