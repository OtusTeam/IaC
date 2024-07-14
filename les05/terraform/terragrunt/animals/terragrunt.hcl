locals {
  yc_folder_id = get_env("YC_SAND_FOLDER_ID")
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "yandex" {
  folder_id = "${local.yc_folder_id}"
}

/*
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
*/

EOF
}
