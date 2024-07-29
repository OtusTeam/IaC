output "vm4ans_public_ip" {
  description = "Public IP address of vm4ans"
  value = yandex_compute_instance.vm4ans.network_interface.0.nat_ip_address
}
