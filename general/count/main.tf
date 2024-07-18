
resource "yandex_compute_instance" "les06_webservers" {
  count = var.num_webservers
  name = "les06-ws${count.index + 1}"

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

  connection {
    host        = self.network_interface.0.nat_ip_address
    type        = "ssh"
    user        = var.username
    private_key = file(var.sec_key_path)
  }

  provisioner "remote-exec" {
    inline = ["sleep 1",
              "sudo apt update -y",
              "sleep 10",
              "sudo apt install -y nginx"]
  }

  provisioner "file" {
    content     = templatefile("index.html.tpl", { server_name = self.name })
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = ["sudo mv /tmp/index.html /var/www/html/",
              "sleep 1",
              "sudo systemctl reload nginx"]
#    on_failure = continue
  }


}

output "instances_nat_ips" {
   value = yandex_compute_instance.les06_webservers.*.network_interface.0.nat_ip_address
}
