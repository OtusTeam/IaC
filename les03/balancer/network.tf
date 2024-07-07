resource "yandex_vpc_network" "les03_network" {
  name = "les03_network"
}

resource "yandex_vpc_subnet" "les03_subnet_a" {
  name           = "les03_subnet_a"
  zone           = var.yc_default_zone
  network_id     = yandex_vpc_network.les03_network.id
  v4_cidr_blocks = ["192.168.15.0/24"]
}

resource "yandex_vpc_subnet" "les03_subnet_b" {
  name = "les03_subnet_b"
  v4_cidr_blocks = ["192.168.16.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.les03_network.id
}
