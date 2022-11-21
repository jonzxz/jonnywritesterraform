variable "cidr_block" {
  type = string
  description = "VPC CIDR Range"
  default = "172.31.1.0/24"
}

variable "instance_tenancy" {
  type = string
  description = "Instance tenancy for EC2, defaults to default"
  default = "default"
}

variable "enable_dns_hostnames" {
  type = bool
  description = "Toggle flag to enable DNS hostnames, defaults true"
  default = true
}

variable "enable_dns_support" {
  type = bool
  description = "Toggle flag to enable DNS support, defaults true"
  default = true
}

variable "enable_ipv6" {
  type = bool
  description = "Toggle flag to enable IPv6, defaults false"
  default = false
}

variable "additional_tags" {
  type = map(string)
  description = "Additional tags to include for resources"
  default = {}
}

locals {
  tags = {
    "ops/module" = "vpc",
    "ops/managed-by" = "Terraform",
    "ops/module-primary" = "vpc"
  }
}