resource "aws_default_network_acl" "nacl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  subnet_ids = local.all_subnet_ids

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "nacl",
      "Name"       = "${var.vpc_name}-NACL"
    }
  )
}

# TODO, decide if NACL should only accept port 80, or just control via SG?
resource "aws_network_acl_rule" "ip4_in" {
  network_acl_id = aws_default_network_acl.nacl.id
  rule_number    = 100
  egress         = false
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "ip4_out" {
  network_acl_id = aws_default_network_acl.nacl.id
  rule_number    = 100
  egress         = true
  protocol       = -1
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

locals {
  all_subnet_ids = concat([for subnet in aws_subnet.private_subnets : subnet.id],
  [for subnet in aws_subnet.public_subnets : subnet.id])
}

