resource "yandex_compute_instance" "vm" {
  name     = "${var.prefix}-single"

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = { 
    ssh-keys = "${var.yc_username}:${file(var.pub_key_path)}" 
  }

  scheduling_policy {
    preemptible = true
  }
}
