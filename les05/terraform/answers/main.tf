resource "null_resource" "example" {

  connection {
    host        = "158.160.127.247"
    type        = "ssh"
    user        = var.username
    private_key = file(var.sec_key_path)
    
  }

  provisioner "file" {
    source = "agentsetup"
    destination = "agentsetup"
  }

  provisioner "remote-exec" {
    inline = ["chmod +x agentsetup", "ls -la"]
  }

  provisioner "remote-exec" {
    inline = ["echo '1\n8\nyes\nexit' | ./agentsetup"]
  }

}

