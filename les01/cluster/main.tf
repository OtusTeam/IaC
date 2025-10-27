resource "yandex_compute_instance" "lemp" {
  count = var.instance_count

  name = "${var.name_prefix}-backend-lemp-${count.index + 1}"

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.pub_key_path)}"
  }

}