resource "yandex_vpc_subnet" "default-ru-central1-b_enpjr0b65u0olvuotmdf" {
	description = "Auto-created default subnet for zone ru-central1-b in default"
	folder_id = "b1gmesrdjgklgkvcp704"
	labels = {
	}
	name = "default-ru-central1-b"
	network_id = "enpjr0b65u0olvuotmdf"
	v4_cidr_blocks = ["10.129.0.0/24"]
	zone = "ru-central1-b"
}
