resource "yandex_vpc_network" "les03_provisioner_network" {
  name = "les03-provisioner-network"
}

resource "yandex_vpc_subnet" "les03_provisioner_subnet" {
  name = "les03-provisioner-subnet"
  v4_cidr_blocks = var.subnet_cidr
  zone           = var.yc_default_zone
  network_id     = yandex_vpc_network.les03_provisioner_network.id
}
