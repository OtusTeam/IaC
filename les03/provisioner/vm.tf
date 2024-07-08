resource "yandex_compute_instance" "les03_rp_nginx" {
  name = "les03-rp-nginx"
  zone = "ru-central1-a"


  provisioner "remote-exec" {
    inline = ["sleep 1",
              "sudo apt update -y",
              "sleep 1",
              "sudo apt install -y nginx nano git",
              "sleep 1",
              "sudo systemctl enable nginx"]

    connection {
      host        = self.network_interface.0.nat_ip_address
      type        = "ssh"
      user        = var.username
      private_key = file(var.sec_key_path)
    }
  }

  provisioner "local-exec" {
    command = "curl http://${self.network_interface.0.nat_ip_address}"
  }


  resources {
    cores  = 2
    memory = 2
    core_fraction = 100
  }

  scheduling_policy {
    preemptible = true
  }


  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.les03_provisioner_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.pub_key_path)}"
  }
}
