resource "yandex_vpc_subnet" "default-ru-central1-a_enpjr0b65u0olvuotmdf" {
	description = "Auto-created default subnet for zone ru-central1-a in default"
	folder_id = "b1gmesrdjgklgkvcp704"
	labels = {
	}
	name = "default-ru-central1-a"
	network_id = "enpjr0b65u0olvuotmdf"
	v4_cidr_blocks = ["10.128.0.0/24"]
	zone = "ru-central1-a"
}
