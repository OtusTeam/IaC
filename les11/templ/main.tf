locals {
  inventory_data = yamldecode(file("inventory.yaml"))
}

resource "yandex_compute_instance" "vm" {
  count = length(local.inventory_data.all.hosts)

  name = local.inventory_data.all.hosts[count.index].key

  zone        = local.inventory_data.all.vars.yandex_cloud_zone
  folder_id   = var.yc_folder
  subnet_id   = local.inventory_data.all.vars.yandex_cloud_network
//  service_account_id = "<YOUR_SERVICE_ACCOUNT_ID>"
  
  // Другие настройки виртуальной машины
  // ...
}
