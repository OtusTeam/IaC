variable "const_num_webservers" {
  type = number
    validation {
      condition = var.const_num_webservers % 2 == 1
      error_message = "The const number of webservers must be odd"
  }    
}

