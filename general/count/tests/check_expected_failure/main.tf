variable "const_num_webservers" {
  type = number    
}

check "wrong_const_num_webservers" {
  assert {
    condition   = var.const_num_webservers == 3
    error_message = "The const number of webservers must be 3"
  }
}
