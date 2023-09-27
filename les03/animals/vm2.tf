resource "yandex_compute_instance" "test-vm2" {
  name = "dog1"

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
    subnet_id = yandex_vpc_subnet.test-subnet-2.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }

}
