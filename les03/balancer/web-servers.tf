resource "yandex_compute_instance" "les03_lamp" {
  name = "les03-lamp"
  zone = yandex_vpc_subnet.les03_subnet_a.zone


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
      image_id = data.yandex_compute_image.lamp.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.les03_subnet_a.id
    nat       = true
  }

}

resource "yandex_compute_instance" "les03_lemp" {
  name = "les03-lemp"
  zone = yandex_vpc_subnet.les03_subnet_b.zone

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
      image_id = data.yandex_compute_image.lemp.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.les03_subnet_b.id
    nat       = true
  }

}
