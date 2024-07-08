resource "yandex_compute_instance" "les03_var" {
  name = "les03-var"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
    subnet_id = var.yc_subnet_id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }


  metadata = {
    ssh-keys = "ubuntu:${file(var.pub_key_file)}"
  }

}
