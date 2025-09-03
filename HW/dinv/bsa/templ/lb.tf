resource "yandex_lb_network_load_balancer" "my_lb" {
  name = "les04-test"

  listener {
    name = "les04-listener"
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
  name = "les04-web-servers-target-group"

  dynamic "target" {
    for_each = local.inventory_data.all.hosts 
    content {
#       target {
          subnet_id = yandex_vpc_subnet.my_sub[local.inventory_data.all.hosts[target.key].yandex_cloud_subnet].id
          address   = yandex_compute_instance.my_vm[target.key].network_interface.0.ip_address
#       }
    }
  }      
}
