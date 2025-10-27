resource "yandex_lb_network_load_balancer" "nlb" {
  name = var.nlb_name

  listener {
    name = "${var.name_prefix}-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.tg.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "tg" {
  name = "${var.name_prefix}-tg"

  dynamic "target" {
    for_each = yandex_compute_instance.lemp 
    content {
          subnet_id = yandex_compute_instance.lemp[target.key].network_interface.0.subnet_id
          address   = yandex_compute_instance.lemp[target.key].network_interface.0.ip_address
    }
  }      
}
