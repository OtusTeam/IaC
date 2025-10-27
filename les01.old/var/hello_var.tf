variable "input_hello" {
  default = "Hello World!"
#  default = "Hello World! From Terraform."
}

output "output_hello" {
  value = var.input_hello
}
