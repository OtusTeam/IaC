resource "yandex_compute_instance" "web_host" {
  for_each = local.inventory_data.all.hosts
  name = each.key

  zone        = local.inventory_data.all.subnets[local.inventory_data.all.hosts[each.key].yandex_cloud_subnet].yandex_cloud_zone
  folder_id   = var.yc_folder
  platform_id = local.inventory_data.all.hosts[each.key].yandex_cloud_platform
  labels = {
    group = local.inventory_data.all.hosts[each.key].yandex_cloud_group
  } 

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = var.image 
      size = 50
#"${data.yandex_compute_image.my_image.id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.web_sub[local.inventory_data.all.hosts[each.key].yandex_cloud_subnet].id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }
}
