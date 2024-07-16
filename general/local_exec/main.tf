resource "null_resource" "example" {
/*
  connection {
    host     = "10.25.140.1"
    type     = "ssh"
    user     = "ubuntu"
    password = "ubuntu"
  }
*/


  provisioner "local-exec" {
  command = <<EOF
./agentsetup <<EOA
1
8
yes
exit
EOA
EOF
}

}

