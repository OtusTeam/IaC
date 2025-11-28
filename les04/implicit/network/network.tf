resource "yandex_vpc_subnet" "les04_implicit_subnet" {
  name = "les03-implicit-subnet"
  v4_cidr_blocks = var.subnet_cidr
  zone           = var.yc_default_zone
  network_id     = yandex_vpc_network.les04_implicit_network.id
}

resource "yandex_vpc_network" "les04_implicit_network" {
  name = "les04-implicit-network"
}
