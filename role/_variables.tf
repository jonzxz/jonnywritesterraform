locals {
  tags = merge(var.additional_tags, { Name = var.role_name })
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for this resource"
}

variable "aws_policies_arn" {
  type        = list(string)
  default     = []
  description = "List of ARN of AWS managed policies"
}

variable "aws_service" {
  type        = string
  default     = ""
  description = "AWS Service to allow assume role of the role created"
}

variable "custom_policies" {
  type        = list(string)
  default     = []
  description = "List of custom defined IAM policies"
}

variable "path" {
  type        = string
  description = "Path of the role in IAM"
  default     = "/"
}

variable "policy_description" {
  type        = string
  default     = null
  description = "Description for IAM Policy"
}

variable "role_description" {
  type        = string
  default     = null
  description = "Description for IAM Role"
}

variable "role_name" {
  type        = string
  description = "Name of role to create"
}
