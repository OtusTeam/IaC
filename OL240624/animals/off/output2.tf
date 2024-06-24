output "vm2_public_ip" {
  description = "Public IP address of VM2"
  value = yandex_compute_instance.test-vm2.network_interface.0.nat_ip_address
}
