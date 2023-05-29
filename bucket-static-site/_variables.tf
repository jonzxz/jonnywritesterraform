locals {
  tags = {
    Name       = var.bucket_name
    Domain     = var.bucket_name
    Repository = "https://github.com/jonzxz/portfolio"
    Terraform  = true
  }
  mime_types = {
    htm  = "text/html"
    html = "text/html"
    css  = "text/css"
    ttf  = "font/ttf"
    js   = "application/javascript"
    map  = "application/javascript"
    json = "application/json"
    ico  = "image/x-icon"
    pdf  = "application/pdf"
    txt  = "text/plain"
    png  = "image/png"
    md   = "binary/octet-stream"
    svg  = "image/svg+xml"
  }
  redirect_bucket = var.redirected_host != null ? 1 : 0
  host_bucket     = var.redirected_host == null ? 1 : 0
}

variable "bucket_name" {
  type        = string
  description = "Bucket name, must be the same as hosted domain name for websites"
  validation {
    condition     = can(regex("^([a-z0-9]+(-[a-z0-9]+)*\\.)+[a-z]{2,}$", var.bucket_name))
    error_message = "Variable bucket_name must be a valid domain name eg. example.com or www.example.com."
  }
}

variable "public_access_config" {
  type        = map(map(bool))
  description = "Public access blocks configuration"
  default = {
    acl = {
      block_public_acls       = false
      block_public_policy     = false
      ignore_public_acls      = false
      restrict_public_buckets = false
    }
  }
}

variable "redirected_host" {
  type = string
  # default = "jonathankerk.com.s3-website-ap-southeast-1.amazonaws.com"
  description = "URL of site to be redirected to"
  default     = null
}

variable "tags" {
  type        = map(any)
  description = "Additional tags"
  default     = {}
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

# Example
# {
#   index_doc = "index.html"
#   error_doc = ""
#   routing_rule = {
#     condition = {
#       key_prefix_equals = null
#     }
#     redirect = {
#       host_name = ""
#       http_redirect_code = ""
#       protocol = "https"
#       replace_key_prefix_with = ""
#       replace_key_prefix = ""
#     }
#   }
# }

variable "website" {
  type = any
  default = {
    index_doc = "index.html"
    # hack: redirect to homepage
    error_doc = "index.html"
  }
}
