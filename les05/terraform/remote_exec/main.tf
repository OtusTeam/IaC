resource "yandex_compute_instance" "re" {
  name = "re"
  zone = var.yc_default_zone

  connection {
    host        = self.network_interface.0.nat_ip_address
    type        = "ssh"
    user        = var.username
    private_key = file(var.sec_key_path)
  }

  provisioner "file" {
    source = "agentsetup"
    destination = "agentsetup"
  }

  provisioner "remote-exec" {
    inline = ["chmod +x agentsetup", "ls -la"]
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
      image_id = var.yc_image_id
    }
  }

  network_interface {
    subnet_id = var.yc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.pub_key_path)}"
  }
}
