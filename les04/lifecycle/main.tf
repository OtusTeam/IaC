resource "yandex_compute_instance" "les04_lifecycle" {
  name = "les04-lifecycle"

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

  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      boot_disk[0].initialize_params[0].image_id
    ]
  }

}
