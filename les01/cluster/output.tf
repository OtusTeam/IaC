output "instances" {
  value = [
    for inst in yandex_compute_instance.lemp : {
      name        = inst.name
      zone        = inst.zone
      platform    = inst.platform_id
      private_ip  = inst.network_interface[0].ip_address
      nat_ip      = inst.network_interface[0].nat_ip_address
    }
  ]
}

output "ansible_inventory" {
  value = join("\n", [
    for inst in yandex_compute_instance.lemp : 
    "${inst.name} ansible_host=${inst.network_interface[0].nat_ip_address}"
  ])
}
