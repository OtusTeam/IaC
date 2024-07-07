resource "yandex_lb_network_load_balancer" "les03_lb" {
  name = "lb-test"

  listener {
    name = "les03-lb"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.les03-web-servers.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "les03-web-servers" {
  name = "les03-web-servers-target-group"

  target {
    subnet_id = yandex_vpc_subnet.les03_subnet_a.id
    address   = yandex_compute_instance.les03_lamp.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.les03_subnet_b.id
    address   = yandex_compute_instance.les03_lemp.network_interface.0.ip_address
  }
}
