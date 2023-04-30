locals {
  tags               = merge(var.additional_tags, {})
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

variable "custom_policies" {
  type        = list(string)
  default     = []
  description = "List of custom defined IAM policies"
}

variable "role_description" {
  type        = string
  default     = null
  description = "Description for IAM Role"
}

variable "policy_description" {
  type        = string
  default     = null
  description = "Description for IAM Policy"
}

variable "aws_service" {
  type        = string
  default     = ""
  description = "AWS Service to allow assume role of the role created"
}

variable "role_name" {
  type = string
  description = "Name of role to create"
}

variable "path" {
  type = string
  description = "Path of the role in IAM"
  default = "/"
}