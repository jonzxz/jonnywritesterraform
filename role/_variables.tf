locals {
  tags               = merge(var.additional_tags, {})
  has_policies       = toset(length(var.custom_policies) > 0 ? "true" : [])
  role_description   = length(var.role_description > 0) ? var.role_description : "Role for ${var.role_name}"
  policy_description = length(var.policy_description > 0) ? var.policy_description : "Policy for ${var.role_name} role"
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
  default     = ""
  description = "Description for IAM Role"
}

variable "policy_description" {
  type        = string
  default     = ""
  description = "Description for IAM Policy"
}

variable "aws_service" {
  type        = string
  default     = ""
  description = "AWS Service to allow assume role of the role created"
}