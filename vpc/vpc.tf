resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "vpc",
      "Name"       = var.vpc_name
    }
  )
}

data "aws_availability_zones" "azs" {
  state = "available"
}