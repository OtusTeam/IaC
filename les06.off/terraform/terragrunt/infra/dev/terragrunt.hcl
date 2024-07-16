locals {
  yc_folder_id = get_env("YC_DEV_FOLDER_ID")
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "yandex" {
  folder_id = "${local.yc_folder_id}"
}
EOF
}
