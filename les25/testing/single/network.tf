resource "yandex_vpc_network" "network" {
  name        = "${var.prefix}-single"
  description = "the net for some single subnet and vm"
}
