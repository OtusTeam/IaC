resource "yandex_compute_instance" "vm4ans" {
  name = "vm4ans"
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
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible -u ${var.username} -i '${self.network_interface.0.nat_ip_address},' --private-key ${var.sec_key_path} -m ping all" 
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
