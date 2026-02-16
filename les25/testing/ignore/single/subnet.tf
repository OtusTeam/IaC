resource "yandex_vpc_subnet" "subnet" {
  name           = "${var.prefix}-single"
  description    = "the subnet for some single vm"
  v4_cidr_blocks = ["192.168.1.0/24"]
  zone           = var.yc_default_zone
  network_id     = "${yandex_vpc_network.network.id}"
}
