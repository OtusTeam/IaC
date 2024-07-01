resource "yandex_lb_network_load_balancer" "ylb" {
  name = "ylb"

  listener {
    name = "listener-web-servers"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.web-servers.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "web-servers" {
  name = "web-servers-target-group"

  dynamic "target" {
    for_each = yandex_compute_instance.webservers
#local.inventory_data.all.hosts 
    content {
#       target {
          subnet_id = "e9bop98iu12teftg4uj8"
#          subnet_id = yandex_vpc_subnet.my_sub[local.inventory_data.all.hosts[target.key].yandex_cloud_subnet].id

          address   = yandex_compute_instance.webservers[target.key].network_interface.0.ip_address
#       }
    }
  }      
}

output "lb_ip_address" {
  value = yandex_lb_network_load_balancer.ylb.listener.*.external_address_spec[0].*.address[0]
}
