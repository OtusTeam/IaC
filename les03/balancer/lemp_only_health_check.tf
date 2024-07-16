resource "terraform_data" "lamp_stop" {
  input = var.lamp_stop
}

resource "null_resource" "stop_lamp" {

  lifecycle {
    replace_triggered_by = [terraform_data.lamp_stop]
  }

  provisioner "local-exec" {
    command = var.lamp_stop ? "yc compute instance stop ${yandex_compute_instance.les03_lamp.id}" : "echo 'not need to stop lamp!'"
  } 

  depends_on = [yandex_compute_instance.les03_lamp]

}

check "lamp_stopped" {
  assert {
    condition = var.lamp_stop && yandex_compute_instance.les03_lamp.status != "running"
    error_message = "lamp need to stop but it's running!"
  }

#  depends_on = [null_resource.stop_lamp]
}

/*
data "http" "lamp" {
  url = "http://${yandex_compute_instance.les03_lamp.network_interface.0.nat_ip_address}"

  lifecycle {
    postcondition {
        condition = (var.lamp_stop && yandex_compute_instance.les03_lamp.status != "running") !! ((self.status_code == 200) != var.lamp_stop)
        error_message = "${self.url} returned an unhealthy status code"
    }
  }

  depends_on = [null_resource.stop_lamp]

}
*/

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
