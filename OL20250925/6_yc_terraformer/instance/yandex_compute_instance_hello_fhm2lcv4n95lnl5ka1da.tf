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
	metadata = {
		ssh-keys = "yc-user:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3HIUrr6iRefESWSlgO8y+zFjJH27t7WO4atyPLGqLAi1GesgJD1zTnzE/KKGUAndumJkbhZN6XbFsbojpxNGONJi+NfocGFgUYdK5fSv+/m7zcLWWqxovUHP0FfLhWjzMFWahBybZDK9p+QKAdnPAgHzmC0Jfn+PM3VrbvfiNnai3rQiIMvxIExMsqn3LSc+BYlliS72nv+BWyufLVCJ3arVh9OsvnvbAKefKkNkTl1G8nQDYowL/57teF+Z53lNZh3ywkWaCgVXYQw+/4H8xcqG38frBrSEtJWcx2E0VGqpoAZ1fwZHp7zgKCsTF5SrGXpd7hX6z+45h2zTRZTFH za@za-Lenovo-IdeaPad-S340-15IWL\n"
		user-data = "#cloud-config\ndatasource:\n Ec2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: yc-user\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3HIUrr6iRefESWSlgO8y+zFjJH27t7WO4atyPLGqLAi1GesgJD1zTnzE/KKGUAndumJkbhZN6XbFsbojpxNGONJi+NfocGFgUYdK5fSv+/m7zcLWWqxovUHP0FfLhWjzMFWahBybZDK9p+QKAdnPAgHzmC0Jfn+PM3VrbvfiNnai3rQiIMvxIExMsqn3LSc+BYlliS72nv+BWyufLVCJ3arVh9OsvnvbAKefKkNkTl1G8nQDYowL/57teF+Z53lNZh3ywkWaCgVXYQw+/4H8xcqG38frBrSEtJWcx2E0VGqpoAZ1fwZHp7zgKCsTF5SrGXpd7hX6z+45h2zTRZTFH za@za-Lenovo-IdeaPad-S340-15IWL\n\n"
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
