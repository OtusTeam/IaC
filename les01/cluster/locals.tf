locals {
  default_subnet_ids = [for s in data.yandex_vpc_subnet.by_id : s.id]
  default_subnet_zones = [for s in data.yandex_vpc_subnet.by_id : s.zone]
  subnet_count       = length(local.default_subnet_ids)
}