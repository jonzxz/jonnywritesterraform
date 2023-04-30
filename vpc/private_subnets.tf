resource "aws_subnet" "private_subnets" {
  for_each = { for idx, az in local.az_names : idx => az }

  vpc_id                          = aws_vpc.vpc.id
  assign_ipv6_address_on_creation = var.enable_ipv6
  availability_zone               = each.value
  cidr_block                      = cidrsubnet(var.cidr_block, 2, each.key + 0)

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module"  = "subnet",
      "ops/network" = "private",
      "Name"        = "Private-Subnet-${each.key}"
    }
  )
}