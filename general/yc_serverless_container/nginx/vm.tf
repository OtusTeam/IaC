  image {
      url = var.yc_registry_image_url
  }
}

resource "yandex_compute_instance" "vm" {
  name = "nginx"

  service_account_id = var.yc_puller_sa

  zone        = var.yc_default_zone
  folder_id   = var.yc_folder
  platform_id = "standard-v2"
  labels = {
    group = "webservers"
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
    }
  }

  network_interface {
    subnet_id = var.yc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }
}

output "vm_ip" {
  value = yandex_compute_instance.vm.network_interface.0.nat_ip_address
}

