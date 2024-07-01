variable "username" {
  default = "ubuntu"
}

variable "num_webservers" {
  default = 3
}

resource "yandex_compute_instance" "webservers" {
  count = var.num_webservers
  name = "ws${count.index + 1}"

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

output "ansible_inventory" {
  value = <<-EOT
[webservers]
%{ for ws in yandex_compute_instance.webservers ~}
${ws.name} ansible_host=${ws.network_interface.0.nat_ip_address} ansible_user=${var.username}
%{ endfor ~}
EOT
}
