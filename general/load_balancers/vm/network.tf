resource "yandex_vpc_network" "web_net" {
  name = local.inventory_data.all.vars.net_name
}

resource "yandex_vpc_subnet" "web_sub" {
  for_each = local.inventory_data.all.subnets
  name = each.key  
 
  v4_cidr_blocks = [local.inventory_data.all.subnets[each.key].yandex_cloud_cidr]
  zone           = local.inventory_data.all.subnets[each.key].yandex_cloud_zone
  network_id     = yandex_vpc_network.web_net.id
}

