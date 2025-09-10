resource "yandex_compute_disk" "_fhm86a6e84kge31qfili" {
	block_size = 4096
	folder_id = var.folder_id
	image_id = var.image_id
	labels = {
	}
	size = 20
	type = "network-hdd"
	zone = "ru-central1-a"
}
