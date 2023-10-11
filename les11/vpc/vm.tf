resource "yandex_compute_instance" "vm4ans" {
  name = "vm4ans"
  zone = var.yc_default_zone


  provisioner "local-exec" {
    command = "echo 'The servers name is ${self.name}'"
  }


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
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
