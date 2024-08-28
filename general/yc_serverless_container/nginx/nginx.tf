resource "yandex_compute_instance" "nginx" {
  count = 1

  name = "compute-vm-2-2-15-hdd-1724833002696"
  folder_id = "b1gmesrdjgklgkvcp704"
  platform_id = "standard-v3"
  zone = "ru-central1-a"
  service_account_id = "ajeps61531r8losd5k2d"
#  status = "running"

  boot_disk {
#    auto_delete = true
#    device_name = "fhmn65vrmme3sp3n3v09"
#    disk_id = "fhmn65vrmme3sp3n3v09"

    initialize_params {
      block_size = 4096
      description = ""
      image_id = "fd8qinf7qa7mmmhe6i8g"
#      name = "disk-1724833045545"
      size = 15
#      snapshot_id = ""
      type = "network-hdd"
    }

    mode = "READ_WRITE"
  }

  network_interface {
#    index = 0
#    ip_address = "10.128.0.21"
    nat = true
#    nat_ip_address = "89.169.149.123"
#    nat_ip_version = "IPV4"
#    mac_address = "d0:0d:6a:40:7c:f0"
    subnet_id = "e9bop98iu12teftg4uj8"
  }

  resources {
    cores = 2
    memory = 2
    core_fraction = 100
 #   gpus = 0
  }

  metadata = {
    "docker-container-declaration" = <<-EOT
      spec:
        containers:
        - name: nginx
          image: cr.yandex/crpgqba9ldgbfg8ad8j0/nginx
        restartPolicy: Always
    EOT
    "serial-port-enable" = "0"
    "ssh-keys" = "aleksey:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCewj3O2osKw0rnOybUkYE6OwayOiEU5blxv+HfmATGt2tzcrQPROuILpaMXIlmlcEgPx1BFowQOS+/Ajhtxphd1p0YpLqvZGrUQd9/1kIoKd5E6FnXrG3O7apX0Bjj12MSDwuPMYWLlQ1OR4m7sIw3blzl+Y0RcLqZZpX+xs9u9fguEE34rSC7X9/cfYysTAfZk86W5C6XiXK5twah75Z+Jka02+hPlR3KkNA3ti70rWIbx83RPue3Bx8GNCYeK5h2ah7a3B/0GTxgyzA4WpBizpHygTnfN5lBlIpcYYf2RFzJxG686d6fkJHlWTZgp8Mei2hEukhfkxtZFc1Z5OhRDsY1EeNOXbtkyR9P8BNvCHNQvnZEmVH76DNZ2cdNaz8ANHBrAWO4c2lptPwpELHZVJbafzNRs3aT0QMtK57gES8CF7hmk8J6Gk3PDwmONTLsMIfqmgahLRFEL4Wbgs2eZqQ3suFSJSEHKaY3gzueKDxApVCmmfWs2ZhfkH9xtNM= aleksey@first"
    "user-data" = <<-EOT
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: aleksey
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
        - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCewj3O2osKw0rnOybUkYE6OwayOiEU5blxv+HfmATGt2tzcrQPROuILpaMXIlmlcEgPx1BFowQOS+/Ajhtxphd1p0YpLqvZGrUQd9/1kIoKd5E6FnXrG3O7apX0Bjj12MSDwuPMYWLlQ1OR4m7sIw3blzl+Y0RcLqZZpX+xs9u9fguEE34rSC7X9/cfYysTAfZk86W5C6XiXK5twah75Z+Jka02+hPlR3KkNA3ti70rWIbx83RPue3Bx8GNCYeK5h2ah7a3B/0GTxgyzA4WpBizpHygTnfN5lBlIpcYYf2RFzJxG686d6fkJHlWTZgp8Mei2hEukhfkxtZFc1Z5OhRDsY1EeNOXbtkyR9P8BNvCHNQvnZEmVH76DNZ2cdNaz8ANHBrAWO4c2lptPwpELHZVJbafzNRs3aT0QMtK57gES8CF7hmk8J6Gk3PDwmONTLsMIfqmgahLRFEL4Wbgs2eZqQ3suFSJSEHKaY3gzueKDxApVCmmfWs2ZhfkH9xtNM= aleksey@first
    EOT
  }
}
