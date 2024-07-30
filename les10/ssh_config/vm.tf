resource "yandex_compute_instance" "vm" {
  name = "les10-ssh-config-vm"
  zone = var.yc_default_zone


  provisioner "local-exec" {
    command = "./add_host_2_ssh_config.sh ${self.name} ${self.network_interface.0.nat_ip_address} ${var.username} ${var.sec_key_path}"
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
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }
}
