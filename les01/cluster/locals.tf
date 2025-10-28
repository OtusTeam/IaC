locals {
  subnet_ids   = [for s in data.yandex_vpc_subnet.by_id : s.id]
  subnet_zones = [for s in data.yandex_vpc_subnet.by_id : s.zone]
  platform_ids = [for z in local.subnet_zones :  z == "ru-central1-d" ? "standard-v2" : "standard-v1"]
  subnet_count = length(local.subnet_ids)
}