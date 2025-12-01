# создаем ВМ на основе образа ubuntu lts:
resource "yandex_compute_instance" "ubuntu_lts" {
  name = "${var.prefix}-lifecycle"

  resources {
    cores  = 2
    memory = 2
    core_fraction = 20
  }

  # используем найденный по имени образ ubuntu lts 
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
    subnet_id = var.yc_subnet_id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }
  
  # раскомментарить, чтобы ВМ не пересоздавалась, если образ поменяется:
  # lifecycle {
  #   prevent_destroy = false
  #   ignore_changes = [
  #     boot_disk[0].initialize_params[0].image_id
  #   ]
  # }

}