locals {
  folder_id = var.yc_otus_folder
  prefix    = "les04-explicit-static"
  sa_name   = "${local.prefix}-sa"
  bucket    = "${local.prefix}-web"
}

