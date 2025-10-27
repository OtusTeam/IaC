
variable "web_count" { type=number default=6 }

locals { web_count=var.web_count }

# create N web instances using module
module "web" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name = "web"
  instance_count = local.web_count
  key_name      = var.key_name
  ...
}

variable "web_count" { type = number default = 3 }
variable "ip_prefix" { type = string default = "10.0.1." }

locals {
  web_ips = [ for i in range(1, var.web_count + 1) : "${var.ip_prefix}${10 + i - 1}" ]
  # пример: для web_count=3 и ip_prefix="10.0.1." создаст ["10.0.1.10","10.0.1.11","10.0.1.12"]
}

resource "aws_instance" "web" {
  for_each     = toset(local.web_ips)
  ami          = var.ami
  instance_type= var.instance_type
  subnet_id    = element(var.subnet_ids, 0)
  private_ip   = each.key
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  ...
}


# LB instance that uses private IPs of web instances
resource "aws_instance" "lb" {
  key_name                    = var.key_name

  user_data = templatefile("${path.module}/lb_user_data.tpl", {
    backend_ips = join(",", module.web.private_ips)
    upstream_port = 80
  })
  ...
}




