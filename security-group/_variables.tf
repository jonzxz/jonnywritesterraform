locals {
  tags = merge(var.additional_tags, {})
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for this resource"
}

variable "description" {
  type        = string
  description = "Description for the security group"
}

variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "rules" {
  type        = any
  description = "Rules for security group"
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC to create security group"
}
