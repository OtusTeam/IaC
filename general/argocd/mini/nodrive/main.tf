resource "yandex_compute_instance" "ac_mini_nodrive" {
  name = "ac-mini-nodrive"
  zone = "ru-central1-a"

  labels = {
    group = "mininodrive"
  } 

  resources {
    cores  = 2
    memory = 8
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = var.image # ID образа Ubuntu
      size = 50
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
    user-data = <<-EOF
                #cloud-config
                package_update: true
                packages:
                  - ca-certificates 
                  - curl 
                  - gnupg 
                  - lsb-release
                EOF
  }
}
