variable "lamp_stop" {
  type = bool
  default = false
}

locals {
  lamp_status = yandex_compute_instance.les03_lamp.status
}

resource "terraform_data" "lamp_action" {
  input = var.lamp_stop && local.lamp_status != "stopped" ? "stop" : (!var.lamp_stop) && local.lamp_status != "running" ? "start" : "get"
}

resource "null_resource" "do_with_lamp" {

  lifecycle {
    replace_triggered_by = [terraform_data.lamp_action]
  }

  provisioner "local-exec" {
    command = "yc compute instance ${terraform_data.lamp_action.input} ${yandex_compute_instance.les03_lamp.id}"
  } 

  depends_on = [yandex_compute_instance.les03_lamp]

}

/*
check "lamp_stopped" {
  assert {
    condition = var.lamp_stop && yandex_compute_instance.les03_lamp.status != "running"
    error_message = "lamp need to stop but it's running!"
  }
}
*/

/*
data "http" "lamp" {
  url = "http://${yandex_compute_instance.les03_lamp.network_interface.0.nat_ip_address}"

  lifecycle {
    postcondition {
        condition = var.lamp_stop !! ((self.status_code == 200) != var.lamp_stop)
        error_message = "${self.url} returned an unhealthy status code"
    }
  }

  depends_on = [null_resource.do_with_lamp]
}
*/

resource "null_resource" "curl_lamp" {
  provisioner "local-exec" {
    command = "curl -S --connect-timeout 10 http://${yandex_compute_instance.les03_lamp.network_interface.0.nat_ip_address} > /dev/null; echo return code is $?"
    on_failure = continue
  }

  lifecycle {
    replace_triggered_by = [terraform_data.lamp_action]
  }

  depends_on = [null_resource.do_with_lamp]
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
