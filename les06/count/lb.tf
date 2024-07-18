resource "yandex_lb_network_load_balancer" "les06_ylb" {
  name = "les06-ylb"

  listener {
    name = "les06-listener-web-servers"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.les06_web_servers.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "les06_web_servers" {
  name = "les06-web-servers-target-group"

  dynamic "target" {
    for_each = yandex_compute_instance.les06_webservers
    content {
          subnet_id = var.yc_subnet_id
          address   = yandex_compute_instance.les06_webservers[target.key].network_interface.0.ip_address
    }
  }      
}

output "lb_ip_address" {
  value = yandex_lb_network_load_balancer.les06_ylb.listener.*.external_address_spec[0].*.address[0]
}
