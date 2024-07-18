variable "ips" {
  type = set(string)
} 

data "http" "instance_check_http" {
  for_each = toset(var.ips)  
  url = "http://${each.value}"
  method = "GET"
  retry {
    attempts = 3
  }

  lifecycle {
    postcondition {
        condition = self.status_code == 200
        error_message = "${self.url} returned an unhealthy status code"
    }
  }
}
