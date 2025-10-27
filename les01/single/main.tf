resource "yandex_compute_instance" "lemp" {
  name = "les01-auto-lemp"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd89eh9ba36b7cggtan6" # lemp
    }
  }

  network_interface {
    subnet_id = "e9bop98iu12teftg4uj8"  # default-ru-central1-a
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

}
