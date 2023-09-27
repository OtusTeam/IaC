resource "yandex_vpc_network" "test-net" {
  name        = "animals"
  description = "cats and dogs are animals"
  labels = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}
