
output "ip_of_cats" {
  value =  {for k, v in module.cats: k => module.cats[k].vm_public_ip}
}

output "ip_of_dogs" {
  value =  {for k, v in module.dogs: k => module.dogs[k].vm_public_ip}
}

