data "external" "yc_instances" {
  program = ["bash", "${path.module}/scripts/get_instances.sh", var.yc_folder]
}

locals {
  ids_json_str = try(data.external.yc_instances.result.ids_json, "[]")
  instance_ids = try(jsondecode(local.ids_json_str), [])
  safe_end     = min(length(local.instance_ids), var.max_instances)
  limited_ids  = slice(local.instance_ids, 0, local.safe_end)
}

data "yandex_compute_instance" "by_id" {
  for_each    = toset(local.limited_ids)
  instance_id = each.value
}
