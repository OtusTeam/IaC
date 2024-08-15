#data "yandex_compute_image" "my_image" {
#  family = "ubuntu-2204-lts"
#}

resource "yandex_compute_instance" "my_vm" {
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
    memory = 2
    core_fraction = 5
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = var.image 
#"${data.yandex_compute_image.my_image.id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.my_sub[local.inventory_data.all.hosts[each.key].yandex_cloud_subnet].id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }
}
