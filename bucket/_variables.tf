locals {
  tags = {
    "ops/managed-by" = "Terraform",
  }
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional tags to include for resources"
  default     = {}
}

variable "bucket_name" {
  type        = string
  description = "Bucket name"
}

variable "public_access_config" {
  type        = map(map(bool))
  description = "Public access blocks configuration"
  default = {
    acl = {
      block_public_acls       = true
      block_public_policy     = true
      ignore_public_acls      = true
      restrict_public_buckets = true
    }
  }
}

variable "versioning" {
  type        = string
  description = "Versioning configuration, defaults to disabled"
  default     = "Disabled"

  validation {
    condition     = can(regex("Enabled|Suspended|Disabled", var.versioning))
    error_message = "Versioning must be one of \"Enabled|Suspended|Disabled\"."
  }
}
