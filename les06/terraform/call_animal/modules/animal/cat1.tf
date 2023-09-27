
resource "yandex_compute_instance" "test-vm1" {
  name     = "cat1"
  hostname = "cat1"

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
    subnet_id = yandex_vpc_subnet.test-subnet-1.id
    nat       = true
  }

  metadata = { 
    ssh-keys = "ubuntu:${file(var.pub_key_file)}" 
  }

}
