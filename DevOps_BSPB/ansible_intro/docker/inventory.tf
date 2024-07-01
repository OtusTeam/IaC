output "ansible_inventory" {
  value = <<-EOT
[webservers]
${yandex_compute_instance.dcr.name} ansible_host=${yandex_compute_instance.dcr.network_interface.0.nat_ip_address} ansible_user=${var.username}
EOT
}
