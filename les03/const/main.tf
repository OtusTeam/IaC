resource "yandex_compute_instance" "use_const" {
  name = "use-const"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
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

  scheduling_policy {
    preemptible = true
  }


  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

}
