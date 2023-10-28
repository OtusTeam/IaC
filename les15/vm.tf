resource "yandex_compute_instance" "vm4ans" {
  name = "vm4ans"
  zone = var.yc_default_zone
  labels = {"label":"docker"}

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8pecdhv50nec1qf9im"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sub4ans.id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }
}
