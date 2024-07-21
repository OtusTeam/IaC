provider "random" {
}

variable "my_list" {
  type = list(string)
  default = ["apple", "banana", "orange", "grape", "kiwi"]
}

resource "random_shuffle" "example" {
  input = var.my_list
}

output "random_element" {
  value = random_shuffle.example.result[0]
}

resource "null_resource" "remove_random_element" {
  provisioner "local-exec" {
    command = "echo 'Removed element: ${random_shuffle.example.result[0]}'"
  }
  provisioner "local-exec" {
    command = "echo 'Updated list: ${join(", ", tolist(setsubtract(toset(var.my_list), [random_shuffle.example.result[0]])))}'"
  }
}

