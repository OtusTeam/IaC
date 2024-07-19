variables {
  const_num_webservers = 3
}

run "check_instances_number" {
  command = plan

  assert {
    condition   = var.num_webservers == var.const_num_webservers
    error_message = "The number of webservers must be ${tostring(var.const_num_webservers)}"
  } 
}


run "create_instances" {
  command = apply

  assert {
    condition   = length(yandex_compute_instance.les06_webservers) == var.num_webservers
    error_message = "Wrong number of webservers"
  }

  assert {
    condition   = length(yandex_compute_instance.les06_webservers[0].network_interface.0.nat_ip_address) > 0
    error_message = "Empty webserver[0] nat ip address"
  }

  assert {
    condition   = length(yandex_compute_instance.les06_webservers[1].network_interface.0.nat_ip_address) > 0
    error_message = "Empty webserver[1] nat ip address"
  }

  assert {
    condition   = length(yandex_compute_instance.les06_webservers[2].network_interface.0.nat_ip_address) > 0
    error_message = "Empty webserver[2] nat ip address"
  }
}


run "create_website" {
  command = apply

  assert {
    condition   = length(yandex_lb_target_group.les06_web_servers.target) == var.num_webservers
    error_message = "Wrong number of webservers in the target group"
  }

  assert {
    condition   = length(yandex_lb_network_load_balancer.les06_ylb.listener.*.external_address_spec[0].*.address[0]) > 0
    error_message = "Empty load balancer external ip address"
  }
}


run "instances_are_running" {
  command = apply
  
  variables {
     ips = run.create_instances.instances_nat_ips
  }

  assert {
    condition     = length(var.ips) == var.const_num_webservers
     error_message = "The number of instances must be ${tostring(var.const_num_webservers)}"
  }

  module {
    source = "./tests/instances_are_running"
  }
}


run "website_is_running" {
  command = apply

  module {
    source = "./tests/http_get"
  }

  variables {
    endpoint = run.create_website.lb_ip_address
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}


run "stop_nginx_on_instance_0" {
  command = apply

  variables {
     ip = run.create_instances.instances_nat_ips[0]
  }


  module {
    source = "./tests/stop_nginx"
  }

#  expect_failures = [data.http.instance]
}


run "website_is_running_without_one_instance" {
  command = apply

  module {
    source = "./tests/http_get"
  }

  variables {
    endpoint = run.create_website.lb_ip_address
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}

run "stop_nginx_on_instance_2" {
  command = apply

  variables {
     ip = run.create_instances.instances_nat_ips[2]
  }


  module {
    source = "./tests/stop_nginx"
  }

#  expect_failures = [data.http.instance]
}


run "website_is_running_without_two_instances" {
  command = apply

  module {
    source = "./tests/http_get"
  }

  variables {
    endpoint = run.create_website.lb_ip_address
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}
