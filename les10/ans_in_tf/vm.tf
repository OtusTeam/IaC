resource "yandex_compute_instance" "vm4ans" {
  name = "les10-vm4ans"
  zone = var.yc_default_zone


  provisioner "remote-exec" {
    inline = ["sleep 1"]

    connection {
      host        = self.network_interface.0.nat_ip_address
      type        = "ssh"
      user        = var.username
      private_key = file(var.sec_key_path)
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook -i '${self.network_interface.0.nat_ip_address},' --private-key ${var.sec_key_path} -e 'location=terraform' hello_from.yml
    EOT
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image
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

output "ansible_inventory_of_vm" {
  value = <<-EOT
[vm]
${yandex_compute_instance.vm4ans.name} ansible_host=${yandex_compute_instance.vm4ans.network_interface.0.nat_ip_address}
EOT
}
