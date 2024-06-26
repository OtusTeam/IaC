resource "yandex_compute_instance" "les01-vm" {
  name = "les01-test-provisioners"
  zone = "ru-central1-a"


  provisioner "local-exec" {
    command = "echo 'The name of our server is ${self.name} and its public IP is ${self.network_interface.0.nat_ip_address}'"
  }


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
      image_id = "fd80viupr3qjr5g6g9du"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.les01-subnet-a.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.pub_key_path)}"
  }
}
