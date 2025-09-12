resource "yandex_compute_instance" "hello_fhm2lcv4n95lnl5ka1da" {
	boot_disk {
		auto_delete = true
		device_name = "fhmtah90vt5i36d8cr5j"
		disk_id = var.disk_id
		initialize_params {
			block_size = 4096
			image_id = var.image_id
			size = 20
			type = "network-hdd"
		}
		mode = "READ_WRITE"
	}
	folder_id = var.folder_id
	hostname = "hello"
	labels = {
	}
	metadata_options {
		aws_v1_http_endpoint = 1
		aws_v1_http_token = 2
		gce_http_endpoint = 1
		gce_http_token = 1
	}
	name = "hello"
	network_acceleration_type = "standard"
	network_interface {
		index = 0
		ip_address = "10.128.0.23"
		ipv4 = true
		ipv6 = false
		nat = true
		subnet_id = var.subnet_id
	}
	placement_policy {
		placement_group_partition = 0
	}
	platform_id = var.platform_id
	resources {
		core_fraction = 20
		cores = 2
		gpus = 0
		memory = 2
	}
	scheduling_policy {
		preemptible = true
	}
	zone = "ru-central1-a"
}
