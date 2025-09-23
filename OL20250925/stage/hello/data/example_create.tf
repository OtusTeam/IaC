# Пример: создать копии инстансов (внимание: это пример — запуск реальных машин создаст ресурсы и счета)
locals {
  by_id_list        = values(data.yandex_compute_instance.by_id)
  instances_to_copy = slice(local.by_id_list, 0, local.safe_end)
}

resource "yandex_compute_instance" "copied" {
  for_each = { for inst in local.instances_to_copy :
               inst.instance_id => inst if inst.instance_id != "" }

  name        = "${each.value.name}-copy"
  zone        = each.value.zone
  resources {
    cores  = each.value.resources[0].cores
    memory = each.value.resources[0].memory
  }

  boot_disk {
    initialize_params {
      image_id = each.value.boot_disk[0].initialize_params[0].image_id
    }
    auto_delete = true
  }

  network_interface {
    subnet_id = each.value.network_interface[0].subnet_id
    nat       = false
  }

  metadata = each.value.metadata
  scheduling_policy {
    preemptible = false
  }
}
