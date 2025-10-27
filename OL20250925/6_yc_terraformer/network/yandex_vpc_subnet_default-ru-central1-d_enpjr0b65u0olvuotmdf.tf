resource "yandex_vpc_subnet" "default-ru-central1-d_enpjr0b65u0olvuotmdf" {
	description = "Auto-created default subnet for zone ru-central1-d in default"
	folder_id = "b1gmesrdjgklgkvcp704"
	labels = {
	}
	name = "default-ru-central1-d"
	network_id = "enpjr0b65u0olvuotmdf"
	v4_cidr_blocks = ["10.131.0.0/24"]
	zone = "ru-central1-d"
}
