resource "null_resource" "check_sudo_permission" {
  provisioner "local-exec" {
    command = "bash command.txt"
  }

  depends_on = [yandex_compute_instance.vm, local_file.save_rendered]
}

resource "yandex_compute_instance" "vm" {
  name = "${var.prefix}-vm-for-provisioner-example"
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
    when       = destroy
    command    = "rm command.txt"
    on_failure = continue
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
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }
}

locals {
  rendered = templatefile("command.tpl", {
       username = var.username
       ip = yandex_compute_instance.vm.network_interface.0.nat_ip_address
    }
  )
}

resource "local_file" "save_rendered" {
  filename = "command.txt"
  content  = local.rendered
}