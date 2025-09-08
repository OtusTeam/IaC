resource "yandex_vpc_network" "les01-network" {
  name = "wp-network"
}

resource "yandex_vpc_subnet" "les01-subnet-a" {
  name = "wp-subnet-a"
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.les01-network.id
}
