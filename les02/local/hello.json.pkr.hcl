
source "null" "autogenerated_1" {
  communicator = "none"
}

build {
  sources = ["source.null.autogenerated_1"]

  provisioner "shell-local" {
    inline = ["echo 'Hello, World!'"]
  }

}
