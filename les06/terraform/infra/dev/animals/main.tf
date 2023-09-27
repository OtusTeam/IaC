locals {
  kinds = toset(["cats", "dogs"])
}

module "network" {
  source = "./modules/network"
}

module "subnet" {
  source = "./modules/subnet"
  network_id = module.network.network_id
  for_each = local.kinds
  kind = each.key
  subnet_index = index(tolist(local.kinds), each.key) + 1 
}

module "cats" {
  source = "./modules/animal"
  subnet_id = module.subnet["cats"].subnet_id
  for_each = toset(["casper"])
  nickname = each.key
}

module "dogs" {
  source = "./modules/animal"
  subnet_id = module.subnet["dogs"].subnet_id
  for_each = toset(["lark"])
  nickname = each.key
}

