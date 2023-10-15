resource "yandex_vpc_network" "my_net" {
  name = local.inventory_data.all.vars.net_name
}

resource "yandex_vpc_subnet" "my_sub" {
  name = local.inventory_data.all.vars.sub_name
  v4_cidr_blocks = [local.inventory_data.all.vars.sub_cidr]
  zone           = local.inventory_data.all.vars.sub_zone
  network_id     = yandex_vpc_network.my_net.id
}

