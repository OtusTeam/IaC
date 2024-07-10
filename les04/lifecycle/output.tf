output "public_ip" {
  description = "Public IP address of VM"
  value = yandex_compute_instance.les04_db.network_interface.0.nat_ip_address
}
