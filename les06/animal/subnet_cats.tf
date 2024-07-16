resource "yandex_vpc_subnet" "test-subnet-1" {
  name           = "cats"
  description    = "cats are animals"
  v4_cidr_blocks = ["192.168.1.0/24"]
  zone           = var.yc_default_zone
  network_id     = "${yandex_vpc_network.test-net.id}"
}
