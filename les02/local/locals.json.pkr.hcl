
source "null" "autogenerated_1" {
  communicator = "none"
}

build {
  sources = ["source.null.autogenerated_1"]

  provisioner "shell-local" {
    inline = ["echo 'echo Hello!' > hello.sh", "chmod 755 hello.sh", "./hello.sh"]
  }

}
