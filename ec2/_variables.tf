locals {
  tags = merge(var.additional_tags, {})
}

variable "instance_type" {
  type        = string
  default     = "t3.small"
  description = "Instance type for the instance"
}

variable "key_name" {
  type        = string
  default     = null
  description = "SSH Key to attach to instance. Defaults to none as SSM is preferrable."
}

variable "subnet_id" {
  type        = string
  description = "ID of subnet to create the instance in"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to attach to instance"
}

variable "additional_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for this resource"
}

variable "iam_instance_profile" {
  type        = string
  default     = ""
  description = "Name of the IAM instance profile to attach to this instance"
}

variable "root_block_volume_size" {
  type        = number
  default     = 8
  description = "Size of the root EBS block volume"
}

variable "root_block_volume_type" {
  type        = string
  default     = "gp2"
  description = "Type of the root EBS block volume"
}

variable "user_data_base64" {
  type = string
  default = null
  description = "Base64 encoded user data for instance startup"
}