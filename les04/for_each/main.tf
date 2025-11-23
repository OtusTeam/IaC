terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

locals {
  names_set = toset(["alice", "bob", "carol"])
}

resource "null_resource" "example" {
  for_each = local.names_set

  # используем both each.key and each.value
  triggers = {
    key   = each.key
    value = each.value
  }
}

output "instances" {
  value = { for k, r in null_resource.example : k => r.triggers }
}

locals {
  m = {
    a = "x"
    b = "x"
    c = "y"
  }
}

resource "null_resource" "r" {
  for_each = local.m
  triggers = {
    key   = each.key
    value = each.value
  }
}

output "out" {
  value = { for k, v in null_resource.r : k => v.triggers }
}
