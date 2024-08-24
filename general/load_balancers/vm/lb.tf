resource "yandex_lb_network_load_balancer" "web_lb" {
  name = "web-lb"

  listener {
    name = "web-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.web_servers.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "web_servers" {
  name = "web-servers-target-group"

  dynamic "target" {
    for_each = local.inventory_data.all.hosts 
    content {
#       target {
          subnet_id = yandex_vpc_subnet.web_sub[local.inventory_data.all.hosts[target.key].yandex_cloud_subnet].id
          address   = yandex_compute_instance.web_host[target.key].network_interface.0.ip_address
#       }
    }
  }      
}

output "lb_ip_address" {
  value = yandex_lb_network_load_balancer.web_lb.listener.*.external_address_spec[0].*.address[0]
}
