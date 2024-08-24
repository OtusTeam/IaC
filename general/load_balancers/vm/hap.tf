resource "yandex_compute_instance" "hap_host" {
  name = "hap"

  zone        =  local.inventory_data.all.subnets[values(local.inventory_data.all.hosts)[0].yandex_cloud_subnet].yandex_cloud_zone
# var.yc_default_zone
  folder_id   = var.yc_folder
  platform_id = values(local.inventory_data.all.hosts)[0].yandex_cloud_platform
# "standard-v2"
  labels = {
    group = "haps"
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
    subnet_id = yandex_vpc_subnet.web_sub[values(local.inventory_data.all.hosts)[0].yandex_cloud_subnet].id 
#var.yc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }
}

output "hap_ip_address" {
  value = yandex_compute_instance.hap_host.network_interface.0.nat_ip_address
}
