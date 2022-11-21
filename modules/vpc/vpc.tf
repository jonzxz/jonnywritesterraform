resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support

  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "vpc"
    }
  )
}

resource "aws_subnet" "private_subnets" {
  for_each = { for idx, az in local.az_names: idx => az}

  vpc_id = aws_vpc.vpc.id 
  assign_ipv6_address_on_creation = var.enable_ipv6
  availability_zone = each.value
  cidr_block = cidrsubnet(var.cidr_block, 2, each.key + 0)

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "subnet",
      "ops/network" = "private"
    }
  )
}

resource "aws_subnet" "public_subnets" {
  for_each = { for idx, az in local.az_names: idx => az}

  vpc_id = aws_vpc.vpc.id 
  assign_ipv6_address_on_creation = var.enable_ipv6
  availability_zone = each.value
  cidr_block = cidrsubnet(var.cidr_block, 2, each.key + 2)

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "subnet",
      "ops/network" = "public"
    }
  )
}

data "aws_availability_zones" "azs" {
  state = "available"
}