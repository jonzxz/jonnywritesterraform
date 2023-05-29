locals {
  tags = {
    "ops/managed-by"     = "Terraform",
    "ops/module-primary" = "autoscaling"
  }
  nginx_bucket_name = "jonny-nginx-bucket"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to include for resources"
  default     = {}
}

variable "alb_name" {
  type        = string
  description = "Name of ALB for autoscaling and target group"
}

variable "desired_capacity" {
  type        = number
  description = "Desired capacity for Autoscaling"
  default     = 3
}

variable "health_check_grace_period" {
  type        = number
  description = "Health check grace period before failure"
  default     = 300
}

variable "health_check_type" {
  type        = string
  description = "Health check type for ALB, defaults ELB"
  default     = "ELB"
}

variable "instance_type" {
  type        = string
  description = "Type of instance to launch for Autoscaling"
  default     = "t2.micro"
}

variable "listener_rule_type" {
  type        = string
  description = "Listener Rule Type for ALB, defaults forward"
  default     = "forward"
}

variable "max_size" {
  type        = number
  description = "Maximum size for Autoscaling"
  default     = 3
}

variable "min_size" {
  type        = number
  description = "Minimum size for Autoscaling"
  default     = 1
}

variable "port" {
  type        = number
  description = "Port in use for ALB Target group, default 80"
  default     = 80
}

variable "protocol" {
  type        = string
  description = "Protocol for target group and health check"
  default     = "HTTP"
}

variable "service_name" {
  type        = string
  description = "Service name to launch Autoscaling group for"
  default     = "nginx"
}

variable "vpc_id" {
  type        = string
  description = "VPC to launch autoscaling in"
}
