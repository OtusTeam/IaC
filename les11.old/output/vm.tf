resource "yandex_compute_instance" "vm4ans" {
  name = "vm4ans"
  zone = var.yc_default_zone


  provisioner "local-exec" {
    command = "echo '${self.name} ansible_host=${self.network_interface.0.nat_ip_address} ansible_user=${var.username} ansible_ssh_private_key_file=${var.sec_key_path}' >> inventory"
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
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }
}

output "inventory" {
   value = "${yandex_compute_instance.vm4ans.name} ansible_host=${yandex_compute_instance.vm4ans.network_interface.0.nat_ip_address} ansible_user=${var.username} ansible_ssh_private_key_file=${var.sec_key_path}\n"
}

