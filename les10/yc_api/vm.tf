resource "yandex_compute_instance" "vm" {
  name = "les10-yc-api-vm"
  zone = var.yc_default_zone

  resources {
    cores  = 2
    memory = 2
    core_fraction = 5
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = var.image
    }
  }

  network_interface {
    subnet_id = var.yc_subnet_id
    nat       = true
  }

  labels = {
    group = "yc_api"
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }
}
