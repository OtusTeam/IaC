resource "yandex_compute_disk" "_fhm2lcv4n95lnl5ka1da" {
	block_size = 4096
	folder_id = var.folder_id
	image_id = var.image_id
	labels = {
	}
	size = 20
	type = "network-hdd"
	zone = "ru-central1-a"
}
