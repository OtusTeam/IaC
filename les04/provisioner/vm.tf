# провижнер вне ресурса для проверки правильно ли настроена jump-ВМ:
resource "null_resource" "run_command" {

  # команда из файла command.txt будет выполнена локально
  provisioner "local-exec" {
    command = "bash command.txt"
  }

  # провижинер будет выполняться только после завершения создания ВМ и локального файла command.txt:
  depends_on = [yandex_compute_instance.jump, local_file.save_rendered]
}

# создаем ВМ "подскока" для удаленного управления инфраструктурой в облаке:
resource "yandex_compute_instance" "jump" {
  name = "${var.prefix}-provisioner-jump"
  zone = var.yc_default_zone

  # общее описание параметров ssh-подключения для провижнеров ресурса:
  connection {
    host        = self.network_interface.0.nat_ip_address
    type        = "ssh"
    user        = var.username
    private_key = file(var.sec_key_path)
  }

  # чтобы внешние провижнеры могли в нужный момент времени подключаться к ВМ по ssh,
  # в описании ресурса ВМ у вас должен быть хотя бы один провижнер, 
  # подключающийся к ВМ по ssh, например даже такой : 
  #provisioner "remote-exec" {
  #  inline = ["sleep 1"]
  #}

  # скачиваем и устанавливаем terraform:
  provisioner "remote-exec" {
    inline = [
      "sleep 1",
      "sudo apt update",
      "sleep 1",
      "sudo apt install unzip -y",
      "sleep 1",
      "wget https://hashicorp-releases.yandexcloud.net/terraform/${var.tf_version}/terraform_${var.tf_version}_linux_amd64.zip",
      "sudo unzip terraform_${var.tf_version}_linux_amd64.zip terraform -d /usr/local/bin",
      "sudo chmod +x /usr/local/bin/terraform",
      "rm terraform_${var.tf_version}_linux_amd64.zip"
    ] 
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
    destination = "/home/${var.username}/.terraformrc"
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
       ip = yandex_compute_instance.jump.network_interface.0.nat_ip_address
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
