locals {
  folder_id = var.yc_otus_folder
  prefix    = "les04-implicit-static"
  sa_name   = "${local.prefix}-sa"
  bucket    = "${local.prefix}-web"
}

