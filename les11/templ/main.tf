data "yandex_compute_image" "image_id" {
  for_each = local.inventory_data.all.hosts
  name = each.key
  
  family = local.inventory_data.all.hosts[each.key].yandex_cloud_image
#  family = "ubuntu-2204-lts"
}



resource "yandex_compute_instance" "my_vm" {
  for_each = local.inventory_data.all.hosts
  name = each.key

  zone        = local.inventory_data.all.vars.sub_zone
  folder_id   = var.yc_folder

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image_id[each.key].image_id
#"fd8pecdhv50nec1qf9im"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.my_sub.id
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.pub_key_path)}"
  }
}
