output "vm1_public_ip" {
  description = "Public IP address of VM1"
  value = yandex_compute_instance.test-vm1.network_interface.0.nat_ip_address
}

