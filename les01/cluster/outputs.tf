output "instance_names" {
  value = [for inst in yandex_compute_instance.lemp : inst.name]
}

output "instance_private_ips" {
  value = [for inst in yandex_compute_instance.lemp : inst.network_interface[0].ip_address]
}

output "instance_nat_ips" {
  value = [for inst in yandex_compute_instance.lemp : inst.network_interface[0].nat_ip_address]
}

output "nlb_external_ip" {
  value = yandex_lb_network_load_balancer.nlb.listener.*.external_address_spec[0].*.address[0]
  description = "External IP of NLB"
}
