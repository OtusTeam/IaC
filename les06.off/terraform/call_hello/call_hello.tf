module "hello_module" {
  source = "./hello_dir"
}

output "output_from_hello_module" {
  value =  module.hello_module.output_hello
}
