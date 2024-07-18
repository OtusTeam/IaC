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


resource "null_resource" "stop_nginx" {

  connection {
    host        = var.ip
    type        = "ssh"
    user        = var.username
    private_key = file(var.sec_key_path)
    
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl stop nginx",
      "sleep 10"
    ]
  }
}

/*
check "health_check" {
  data "http" "instance" {
    url = "http://${var.ip}"

    depends_on = [null_resource.stop_nginx]
  }

  assert {
    condition = data.http.instance.status_code == 200
    error_message = "${data.http.instance.url} returned an unhealthy status code ${tostring(data.http.instance.status_code)}"
  }
}
*/
