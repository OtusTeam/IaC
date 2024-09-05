variable "node_count" {
  description = "Количество рабочих узлов"
  type        = number
  default     = 2
}

resource "yandex_vpc_network" "ac_network" {
  name = "ac-network"
}

resource "yandex_vpc_subnet" "ac_subnet" {
  name           = "ac-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.ac_network.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_compute_instance" "ac_k8s_nodes" {
  count = var.node_count

  name = "ac-k8s-node-${count.index + 1}"
  zone = "ru-central1-a"

  labels = {
    group = "k8snodes"
  } 


  resources {
    cores  = 2
    memory = 4
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
    subnet_id = yandex_vpc_subnet.ac_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
    user-data = <<-EOF
                #cloud-config
                package_update: true
                packages:
                  - docker.io
                EOF
  }
}

resource "yandex_compute_instance" "ac_k8s_master" {
  name = "ac-k8s-master"
  zone = "ru-central1-a"

  labels = {
    group = "k8smaster"
  } 

  resources {
    cores  = 2
    memory = 4
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
    subnet_id = yandex_vpc_subnet.ac_subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
    user-data = <<-EOF
                #cloud-config
                package_update: true
                packages:
                  - docker.io
                EOF
  }
}
