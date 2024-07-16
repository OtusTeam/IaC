/*
check "health_check" {
  data "http" "ylb" {
    url = "http://${yandex_lb_network_load_balancer.les03_lb.listener.*.external_address_spec[0].*.address[0]}"
  }

  assert {
    condition = data.http.ylb.status_code == 200
    error_message = "${data.http.ylb.url} returned an unhealthy status code"
  }
}
*/

data "http" "lamp" {
  url = "http://${yandex_compute_instance.les03_lamp.network_interface.0.nat_ip_address}"

  lifecycle {
    postcondition {
        condition = self.status_code == 200
        error_message = "${self.url} returned an unhealthy status code"
    }
  }
}

data "http" "lemp" {
  url = "http://${yandex_compute_instance.les03_lemp.network_interface.0.nat_ip_address}"

  lifecycle {
    postcondition {
        condition = self.status_code == 200
        error_message = "${self.url} returned an unhealthy status code"
    }
  }
}


data "http" "ylb" {
  url = "http://${yandex_lb_network_load_balancer.les03_lb.listener.*.external_address_spec[0].*.address[0]}"

  lifecycle {
    postcondition {
        condition = self.status_code == 200
        error_message = "${self.url} returned an unhealthy status code"
    }
  }
}
