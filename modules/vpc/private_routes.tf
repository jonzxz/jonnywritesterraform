resource "aws_route_table" "private_route_table" {
  for_each = aws_subnet.private_subnets

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module"  = "route_table",
      "ops/network" = "private",
      "Name"        = "Private-Route-Table-${each.key}"
    }
  )
}

resource "aws_route_table_association" "private_rt_assoc" {
  count     = length(aws_subnet.private_subnets)
  subnet_id = aws_subnet.private_subnets[count.index].id
  # Trim prefix doesn't seem to work
  # route_table_id = aws_route_table.private_route_table[trimprefix(each.value.availability_zone, "ap-southeast-1")].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}

resource "aws_eip" "nat_eip" {
  count = length(aws_subnet.public_subnets)
  vpc   = true

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module"  = "eip",
      "ops/network" = "public",
      "Name"        = "Public-EIP-${count.index}"
    }
  )
}

resource "aws_nat_gateway" "public_nat" {
  count             = length(aws_subnet.public_subnets)
  allocation_id     = aws_eip.nat_eip[count.index].id
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnets[count.index].id
}

resource "aws_route" "public_nat_gw" {
  count                  = length(aws_route_table.private_route_table)
  route_table_id         = aws_route_table.private_route_table[count.index].id
  nat_gateway_id         = aws_nat_gateway.public_nat[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}
