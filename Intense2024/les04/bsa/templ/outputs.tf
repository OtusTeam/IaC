output "lb_ip_address" {
  value = yandex_lb_network_load_balancer.my_lb.listener.*.external_address_spec[0].*.address[0]
}
