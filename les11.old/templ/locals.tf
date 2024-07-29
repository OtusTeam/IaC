locals {
  inventory_data = yamldecode(file("inventory.yaml"))
}
