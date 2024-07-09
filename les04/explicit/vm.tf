resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = <<-EOT
      export ANSIBLE_HOST_KEY_CHECKING=False &&
      ansible -u ${var.username} -i hosts --private-key ${var.sec_key_path} -m ping all
    EOT
  }

  depends_on = [yandex_compute_instance.les04_explicit]
}


resource "yandex_compute_instance" "les04_explicit" {
  name = "les04-explicit"
  zone = var.yc_default_zone

  provisioner "local-exec" {
    command = "echo '${self.name} ansible_host=${self.network_interface.0.nat_ip_address}' > hosts"
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

  resources {
    cores  = 2
    memory = 2
    core_fraction = 100
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
