resource "yandex_compute_instance" "les04_webservers" {
  count = var.num_webservers
  name = "les04-ws${count.index + 1}"

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
      image_id = var.yc_image_id
    }
  }

  network_interface {
    subnet_id = var.yc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }

}

output "ansible_inventory" {
  value = <<-EOT
[webservers]
%{ for ws in yandex_compute_instance.les04_webservers ~}
${ws.name} ansible_host=${ws.network_interface.0.nat_ip_address} ansible_user=${var.username}
%{ endfor ~}
EOT
}
