variable "username" {
  default = "ubuntu"
}

resource "yandex_compute_instance" "dcr" {
  name = "dcr"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8p8rslnsmtkkqojh50"
    }
  }

  network_interface {
    subnet_id = "e9bop98iu12teftg4uj8"
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file("~/.ssh/id_rsa.pub")}"
  }

}
