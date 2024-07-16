output "vm_public_ip" {
  description = "Public IP address of animal's VM"
  value = yandex_compute_instance.animal.network_interface.0.nat_ip_address
}
