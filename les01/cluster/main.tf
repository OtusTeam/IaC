resource "yandex_compute_instance" "lemp" {
  count = var.instance_count

  name = "${var.name_prefix}-backend-lemp-${count.index + 1}"

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }

  connection {
    type        = "ssh"
    host        = self.network_interface[0].nat_ip_address
    user        = var.username
    private_key = file(var.sec_key_path)
    timeout     = "2m"
  }

  provisioner "file" {
    content     = templatefile("${path.module}/templates/index.html.tpl", {
      name       = self.name,
      private_ip = self.network_interface[0].ip_address,
      nat_ip     = self.network_interface[0].nat_ip_address
    })
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo chown root:root /var/www/html/index.html",
      "sudo chmod 644 /var/www/html/index.html",
      "sudo systemctl restart nginx || true"
    ]
  }
}