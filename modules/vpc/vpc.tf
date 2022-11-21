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

resource "aws_route_table" "private_route_table" {
  for_each = aws_subnet.private_subnets

  vpc_id = aws_vpc.vpc.id
  
  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "route_table",
      "ops/network" = "private"
    }
  )
}


resource "aws_route_table_association" "private_rt_assoc" {
  count = length(aws_subnet.private_subnets)
  subnet_id = aws_subnet.private_subnets[count.index].id 
  # Trim prefix doesn't seem to work
  # route_table_id = aws_route_table.private_route_table[trimprefix(each.value.availability_zone, "ap-southeast-1")].id
  route_table_id = aws_route_table.private_route_table[count.index].id

}

resource "aws_route_table" "public_route_table" {
  for_each = aws_subnet.public_subnets
  vpc_id = aws_vpc.vpc.id
  
  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "route_table",
      "ops/network" = "public"
    }
  )
}

resource "aws_route_table_association" "public_rt_assoc" {
  count = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.public_subnets[count.index].id 
  # Trim prefix doesn't seem to work
  # route_table_id = aws_route_table.public_route_table[trimprefix(each.value.availability_zone, "ap-southeast-1")].id
  route_table_id = aws_route_table.public_route_table[count.index].id

}

data "aws_region" "current" {}

data "aws_availability_zones" "azs" {
  state = "available"
}