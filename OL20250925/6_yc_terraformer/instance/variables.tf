variable "disk_id" {
  description = "ID of the existing disk to attach to the instance."
  type        = string
}

variable "image_id" {
  description = "ID of the OS image to use for the instance."
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID where the instance will be created."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the instance's network interface."
  type        = string
}

variable "platform_id" {
  description = "Platform ID (zone/host type) for the instance, e.g. \"standard-v1\" or zone-specific platform."
  type        = string
}
