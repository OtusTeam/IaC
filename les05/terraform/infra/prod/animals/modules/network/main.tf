
resource "yandex_vpc_network" "animals" {
  name        = "animals"
  description = "cats and dogs are animals"
  labels = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}
