variable "vpc_name" {
  type = string
  description = "Name of VPC"
  default = "Jonny-Mini-VPC"
}

variable "cidr_block" {
  type = string
  description = "VPC CIDR Range"
  default = "172.31.1.0/24"
}