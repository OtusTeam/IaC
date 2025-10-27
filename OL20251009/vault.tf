
provider "vault" {address = "https://vault.example.com", token   = var.vault_token}

data "vault_generic_secret" "db_password" {
  path = "secret/data/db"
}

resource "aws_db_instance" "example" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  name                 = "exampledb"
  username             = "admin"
  password             = data.vault_generic_secret.db_password.data["password"]
  parameter_group_name = "default.mysql5.7"
}


provider "vault" {address = "https://vault.example.com", token   = var.vault_token}

data "vault_aws_access_credentials" "creds" {
  backend = "aws"
  role    = "terraform-role"
}

provider "aws" {
  region     = "us-west-2"
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
  session_token = data.vault_aws_access_credentials.creds.security_token
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-secure-bucket"
  acl    = "private"
}


