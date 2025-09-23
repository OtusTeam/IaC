variable "input_file" {
  type    = string
  default = "input.json"
}

locals {
  raw = jsondecode(file(var.input_file))

  # разрешённые символы для label ресурса
  resource_name = join("", regexall("[A-Za-z0-9_]", coalesce(local.raw.name, "instance")))
  resource_name_final = local.resource_name != "" ? local.resource_name : "instance"

  # карта для for_each
  raw_map = { (local.resource_name_final) = local.raw }
  
  # ресурсы CPU/Memory (попытка привести к числам, иначе null)
  resources = {
    cores         = try(tonumber(try(local.raw.resources.cores, null)), null)
#    memory        = try(tonumber(try(local.raw.resources.memory, null)), null)
#    memory = (can(tonumber(local.raw.resources.memory)) ? tonumber(local.raw.resources.memory) :
#              (length(regexall("^([0-9]+)G$", coalesce(tostring(local.raw.resources.memory), ""))) > 0 ?
#               tonumber(regexall("^([0-9]+)G$", tostring(local.raw.resources.memory))[0]) * 1073741824 :
#               null)
#    )
    memory = ceil(tonumber(local.raw.resources.memory) / (1024 * 1024 * 1024))
    core_fraction = try(tonumber(try(local.raw.resources.core_fraction, null)), null)
  }

  network_interfaces = try(local.raw.network_interfaces, [])
  boot_disk          = try(local.raw.boot_disk, {})
  metadata_options   = try(local.raw.metadata_options, {})
  scheduling_policy  = try(local.raw.scheduling_policy, {})
  fqdn               = try(local.raw.fqdn, null)
  folder_id          = coalesce(try(local.raw.folder_id, null), "")
}

resource "yandex_compute_instance" "this" {
  for_each = local.raw_map

  name      = each.value.name
  folder_id = local.folder_id
  zone      = lookup(each.value, "zone_id", null)
  platform_id = lookup(each.value, "platform_id", null)

  # resources block (if present)
  dynamic "resources" {
    for_each = local.resources == {} ? [] : [local.resources]
    content {
      cores         = resources.value.cores
      memory        = resources.value.memory
      core_fraction = resources.value.core_fraction
    }
  }

  # boot_disk -> initialize_params.image_id (по примеру)
  dynamic "boot_disk" {
    for_each = length(keys(local.boot_disk)) == 0 ? [] : [local.boot_disk]
    content {
      # если в JSON есть disk_id — используем disk_id как existing disk (provider-specific),
      # иначе попытка поставить initialize_params.image_id из metadata boot_disk.image_id или из имени образа в raw
      initialize_params {
        image_id = lookup(boot_disk.value, "image_id", "fd8pecdhv50nec1qf9im")
      }
    }
  }

  # network_interface: для каждого интерфейса вставляем subnet_id и nat=true/false
  dynamic "network_interface" {
    for_each = local.network_interfaces
    content {
      subnet_id = lookup(network_interface.value, "subnet_id", null)

      # nat: если в JSON есть primary_v4_address.one_to_one_nat.address -> true, иначе если поле nat задано — используем его, иначе false
      nat = contains(keys(network_interface.value), "primary_v4_address") && contains(keys(lookup(network_interface.value, "primary_v4_address", {})), "one_to_one_nat") ? true : lookup(network_interface.value, "nat", false)
    }
  }

  # scheduling_policy.preemptible
  dynamic "scheduling_policy" {
    for_each = length(keys(local.scheduling_policy)) == 0 ? [] : [local.scheduling_policy]
    content {
      preemptible = lookup(scheduling_policy.value, "preemptible", null)
    }
  }

  # metadata (map of string)
  metadata = length(keys(local.metadata_options)) == 0 ? null : tomap({ for k, v in local.metadata_options : k => tostring(v) })

  # hostname
  hostname = local.fqdn != null ? local.fqdn : null
}

output "instance_ids" {
  value = { for k, v in yandex_compute_instance.this : k => v.id }
}
