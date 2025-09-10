resource "yandex_vpc_subnet" "default-ru-central1-c_enpjr0b65u0olvuotmdf" {
	description = "Auto-created default subnet for zone ru-central1-c in default"
	folder_id = var.folder_id
	labels = {
	}
	name = "default-ru-central1-c"
	network_id = var.network_id
	v4_cidr_blocks = ["10.130.0.0/24"]
	zone = "ru-central1-c"
}
