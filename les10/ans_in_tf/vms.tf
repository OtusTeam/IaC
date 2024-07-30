variable "vms_count" {
  default = 2
}

resource "yandex_compute_instance" "vms4ans" {
  count = var.vms_count
  name = "les10-vms4ans${tostring(count.index+1)}"
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
      export ANSIBLE_HOST_KEY_CHECKING=False
      ansible -u ${var.username} -i '${self.network_interface.0.nat_ip_address},' --private-key ${var.sec_key_path} -m ping all
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

output "ansible_inventory_of_vms" {
  value = <<-EOT
[vms]
%{ for vm in yandex_compute_instance.vms4ans ~}
${vm.name} ansible_host=${vm.network_interface.0.nat_ip_address} ansible_user=${var.username} ansible_ssh_host_key_checking=False
%{ endfor ~}
EOT
}
