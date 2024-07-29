resource "yandex_vpc_network" "net4ans" {
  name = "net4ans"
}

resource "yandex_vpc_subnet" "sub4ans" {
  name = "sub4ans"
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = var.yc_default_zone
  network_id     = yandex_vpc_network.net4ans.id
}

