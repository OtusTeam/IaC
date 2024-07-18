run "check_instances_number" {
  command = plan

  assert {
    condition   = var.num_webservers == 3
    error_message = "The number of webservers must be 3"
  } 
}


run "create_instances" {
  command = apply

  assert {
    condition   = length(yandex_compute_instance.les04_webservers) == var.num_webservers
    error_message = "Wrong number of webservers"
  }

  assert {
    condition   = length(yandex_compute_instance.les04_webservers[0].network_interface.0.nat_ip_address) > 0
    error_message = "Empty webserver[0] nat ip address"
  }

  assert {
    condition   = length(yandex_compute_instance.les04_webservers[1].network_interface.0.nat_ip_address) > 0
    error_message = "Empty webserver[1] nat ip address"
  }

  assert {
    condition   = length(yandex_compute_instance.les04_webservers[2].network_interface.0.nat_ip_address) > 0
    error_message = "Empty webserver[2] nat ip address"
  }
}


run "create_website" {
  command = apply

  assert {
    condition   = length(yandex_lb_target_group.les04_web_servers.target) == var.num_webservers
    error_message = "Wrong number of webservers in the target group"
  }

  assert {
    condition   = length(yandex_lb_network_load_balancer.les04_ylb.listener.*.external_address_spec[0].*.address[0]) > 0
    error_message = "Empty load balancer external ip address"
  }
}


run "website_is_running" {
  command = apply

  module {
    source = "./tests/get"
  }

  variables {
    endpoint = run.create_website.lb_ip_address
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}
