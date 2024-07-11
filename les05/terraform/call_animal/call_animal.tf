module "animal_module" {
  source = "./modules/animal"

  yc_token	  = var.yc_token
  yc_cloud	  = var.yc_cloud
  yc_folder	  = var.yc_folder
  yc_default_zone = var.yc_default_zone
}

output "output_from_animal_module" {
  value =  module.animal_module.vm1_public_ip
}
