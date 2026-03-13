resource "yandex_compute_instance" "vm" {
  name     = "${var.prefix}-vm"

  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.yc_image_id
    }
  }

  network_interface {
    subnet_id = var.yc_subnet_id
    nat       = true
  }

  metadata = { 
    ssh-keys = "${var.yc_username}:${file(var.pub_key_path)}" 
  }

}
