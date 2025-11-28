terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

# пример составной локальной переменной типа set:
locals {
  names_set = toset(["alice", "bob", "carol"])
}

resource "null_resource" "each_of_set" {
  for_each = local.names_set

  # используем each.key и each.value в качестве значений атрибутов экземпларов each_of_set:
  triggers = {
    key   = each.key
    value = each.value
  }
}

# выводим значения атрибутов экземпляров each_of_set:
output "values_each_of_sets" {
  value = { for k, r in null_resource.each_of_set : k => r.triggers }
}

# пример составной локальной переменной типа map:
locals {
  example_of_map  = {
    a = "x"
    b = "x"
    c = "y"
  }
}

resource "null_resource" "each_of_map" {
  for_each = local.example_of_map

  # используем each.key и each.value в качестве значений атрибутов экземпларов each_of_map:
  triggers = {
    key   = each.key
    value = each.value
  }
}

# выводим значения атрибутов экземпляров each_of_map:
output "values_each_of_map" {
  value = { for k, v in null_resource.each_of_map : k => v.triggers }
}
