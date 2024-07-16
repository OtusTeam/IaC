
resource "yandex_compute_instance" "animal" {
  name     = var.nickname
  hostname = var.nickname
 
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
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = { 
    ssh-keys = "ubuntu:${file(var.pub_key_file)}" 
  }

}
