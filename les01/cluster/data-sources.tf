# получаем сеть по имени
data "yandex_vpc_network" "default" {
  name = var.network_name
}

# получаем каждую подсеть по id из сети
data "yandex_vpc_subnet" "by_id" {
  for_each = toset(data.yandex_vpc_network.default.subnet_ids)
  subnet_id = each.value
}