provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "lemp_vm" {
  ami           = "ami-12345678" # ID образа, созданного с помощью Packer
  instance_type = "t2.micro"
  key_name      = "my-key-pair"

  tags = {
    Name = "LEMP-Server"
  }
}