resource "aws_route_table" "public_route_table" {
  for_each = aws_subnet.public_subnets
  vpc_id   = aws_vpc.vpc.id

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module"  = "route_table",
      "ops/network" = "public"
      "Name"        = "Public-Route-Table-${each.key}"
    }
  )
}

resource "aws_route_table_association" "public_rt_assoc" {
  count     = length(aws_subnet.public_subnets)
  subnet_id = aws_subnet.public_subnets[count.index].id
  # Trim prefix doesn't seem to work
  # route_table_id = aws_route_table.public_route_table[trimprefix(each.value.availability_zone, "ap-southeast-1")].id
  route_table_id = aws_route_table.public_route_table[count.index].id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "public_igw_route" {
  count                  = length(aws_route_table.public_route_table)
  route_table_id         = aws_route_table.public_route_table[count.index].id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}