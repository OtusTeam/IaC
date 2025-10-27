output "instance_names" {
  value = [for inst in yandex_compute_instance.lemp : inst.name]
}

output "nat_ip_addresses" {
  value = [for inst in yandex_compute_instance.lemp : inst.network_interface[0].nat_ip_address]
  sensitive = false
}
