locals {
  tags = {
    "ops/managed-by"     = "Terraform",
    "ops/module-primary" = "vpc"
  }

  # Only need 2 AZs to simulate HA, no need 3
  az_names = slice(data.aws_availability_zones.azs.names, 0, 2)
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to include for resources"
  default     = {}
}

variable "cidr_block" {
  type        = string
  description = "VPC CIDR Range"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Toggle flag to enable DNS hostnames, defaults true"
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = "Toggle flag to enable DNS support, defaults true"
  default     = true
}

variable "enable_ipv6" {
  type        = bool
  description = "Toggle flag to enable IPv6, defaults false"
  default     = false
}

variable "instance_tenancy" {
  type        = string
  description = "Instance tenancy for EC2, defaults to default"
  default     = "default"
}

variable "vpc_name" {
  type        = string
  description = "Name of VPC"
}
