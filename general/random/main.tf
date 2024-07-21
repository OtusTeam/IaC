resource "random_integer" "example" {
  min = 1
  max = 100
}

output "random_integer" {
  value = random_integer.example.result
} 
