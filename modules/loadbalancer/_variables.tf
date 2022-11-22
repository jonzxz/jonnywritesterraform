variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to include for resources"
  default     = {}
}

variable "name" {
  type = string
  description = "Name for application load balancer"
  default = "Jonny-Mini-ALB"
}

variable "is_lb_internal" {
  type = bool
  description = "Toggle if ALB is internal facing. Defaults false"
  default = false
}

variable "idle_timeout_duration" {
  type = string
  description = "Idle timeout duration for ALB. Defaults 60"
  default = "60"
}

variable "vpc_id" {
  type = string
  description = "ID of VPC for ALB"
  default = "vpc-03fb2a8297c068114"
}

locals {
  tags = {
    "ops/managed-by"     = "Terraform",
    "ops/module-primary" = "loadbalancer"
  }
}