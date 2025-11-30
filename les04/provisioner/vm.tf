# пример провижнера вне ресурса
resource "null_resource" "run_command" {

  # команда из файла command.txt будет выполнена локально
  provisioner "local-exec" {
    command = "bash command.txt"
  }

  # провижинер будет выполняться только после завершения создания ВМ и локального файла command.txt:
  depends_on = [yandex_compute_instance.vm, local_file.save_rendered]
}

resource "yandex_compute_instance" "vm" {
  name = "${var.prefix}-vm-for-provisioner-example"
  zone = var.yc_default_zone

  # общее описание параметров ssh-подключения для провижнеров ресурса:
  connection {
    host        = self.network_interface.0.nat_ip_address
    type        = "ssh"
    user        = var.username
    private_key = file(var.sec_key_path)
  }

  # намеренно задерживает создание ВМ до соединения с ВМ по ssh: 
  provisioner "remote-exec" {
    inline = ["sleep 1"]
  }

  # создаем в удаленной ВМ файл с настройкой терраформ:   
  provisioner "file" {
    content = <<-EOF
    provider_installation {
      network_mirror {
        url = "https://terraform-mirror.yandexcloud.net/"
        include = ["registry.terraform.io/*/*"]
      }
      direct {
        exclude = ["registry.terraform.io/*/*"]
      }
    }
    EOF
    destination = "/home/ubuntu/.terraformrc"
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

# подставляем в шаблон значения параметров (имя пользователя для ssh-подключения, ip создаваемой ВМ):
locals {
  rendered = templatefile("command.tpl", {
       username = var.username
       ip = yandex_compute_instance.vm.network_interface.0.nat_ip_address
    }
  )
}

# провижнер вне ресурса для создания локального файла из заполненного шаблона: 
resource "local_file" "save_rendered" {
  filename = "command.txt"
  content  = local.rendered
}

resource "null_resource" "delete_on_destroy" {
  # при выполнении terraform destroy удалаем файл command.txt с локальной машины:  
  provisioner "local-exec" {
    when       = destroy
    command    = "rm command.txt"
    # продолжаем работу терраформа даже если произойдет ошибка при выполнении команды
    on_failure = continue
  }
}
