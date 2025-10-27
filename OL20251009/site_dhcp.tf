
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

# LB instance that uses private IPs of web instances
resource "aws_instance" "lb" {
  key_name                    = var.key_name

  user_data = templatefile("${path.module}/lb_user_data.tpl", {
    backend_ips = join(",", module.web.private_ips)
    upstream_port = 80
  })
  ...
}




