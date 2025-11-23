# Модуль для создания Network Load Balancer в Yandex Cloud
# Источник: https://github.com/terraform-yacloud-modules/terraform-yandex-nlb

# Конфигурация target group с динамическими блоками
resource "yandex_lb_target_group" "nlb_target_group" {
  count = 2
  name      = "nlb-target-group-${count.index}"
  region_id = "ru-central1"

  # Динамический блок для целевых ресурсов
  dynamic "target" {
    for_each = var.target_instances
    content {
      subnet_id  = target.value.subnet_id
      address    = target.value.address
    }
  }
}

resource "yandex_lb_network_load_balancer" "nlb" {
  name = "network-load-balancer"
  type = "external"

  # Динамический блок для аттачмента target group
  dynamic "attached_target_group" {
    for_each = yandex_lb_target_group.nlb_target_group
    content {
      target_group_id = attached_target_group.value.target_group_id
      
      # Вложенный динамический блок для health checks
      dynamic "healthcheck" {
        for_each = local.healthchecks
        content {
          name = "${attached_target_group.value.name}-${healthcheck.key}" 
          http_options {
            port = healthcheck.value.port
            path = healthcheck.value.path
          }
        }
      }
    }
  }

  dynamic "listener" {
    for_each = var.listeners
    content {
      name = listener.value.name
      port = listener.value.port
      external_address_spec {
        ip_version = listener.value.ip_version
      }
    }
  }

}

# Переменные для конфигурации
variable "target_instances" {
  type = list(object({
    subnet_id = string
    address   = string
  }))
  default = [
    {
      subnet_id = "subnet-id-1"
      address   = "192.168.1.10"
    },
    {
      subnet_id = "subnet-id-2" 
      address   = "192.168.2.11"
    }
  ]
}

variable "listeners" {
  type = list(object({
    name       = string
    port       = number
    ip_version = string
  }))
  default = [
    {
      name       = "http-listener"
      port       = 80
      ip_version = "ipv4"
    },
    {
      name       = "https-listener"
      port       = 443
      ip_version = "ipv4"
    }
  ]
}

locals { 
  healthchecks = {
    http = {
      port = 80
      path = "/"
    }
    https = {
      port = 443
      path = "/"
    }
  }
}

