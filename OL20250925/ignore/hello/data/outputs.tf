output "instances_count" {
  value       = length(local.instance_ids)
  description = "Количество инстансов в каталоге (до ограничения max_instances)"
}

output "instances_summary" {
  value = [
    for id in local.limited_ids : {
      id       = id
      name     = data.yandex_compute_instance.by_id[id].name
      zone     = data.yandex_compute_instance.by_id[id].zone
      status   = data.yandex_compute_instance.by_id[id].status
      cores    = try(data.yandex_compute_instance.by_id[id].resources[0].cores, null)
      memory   = try(data.yandex_compute_instance.by_id[id].resources[0].memory, null)
      image_id = try(data.yandex_compute_instance.by_id[id].boot_disk[0].initialize_params[0].image_id, null)
    }
  ]
  description = "Краткая информация по каждому инстансу"
}
