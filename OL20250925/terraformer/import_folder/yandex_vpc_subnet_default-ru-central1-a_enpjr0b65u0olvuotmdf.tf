resource "yandex_vpc_subnet" "default-ru-central1-a_enpjr0b65u0olvuotmdf" {
	description = "Auto-created default subnet for zone ru-central1-a in default"
	folder_id = var.folder_id
	labels = {
	}
	name = "default-ru-central1-a"
	network_id = var.network_id
	v4_cidr_blocks = ["10.128.0.0/24"]
	zone = "ru-central1-a"
}
