variable "ip" {
  type = string
}

variable "username" {
   type = string
   default = "ubuntu"
}

variable "sec_key_path" {
   type = string
   sensitive = true
   default = "~/.ssh/id_rsa"
}


resource "null_resource" "ssh_connect" {

  connection {
    host        = var.ip
    type        = "ssh"
    user        = var.username
    private_key = file(var.sec_key_path)
    
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 10"
    ]
  }
}
