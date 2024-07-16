resource "yandex_vpc_subnet" "kind_of_animals" {
  name           = var.kind
  description    = "${var.kind} are animals"
  v4_cidr_blocks = ["192.168.${var.subnet_index}.0/24"]
  zone           = var.yc_default_zone
  network_id     = var.network_id
}
