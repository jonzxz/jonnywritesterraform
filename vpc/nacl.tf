resource "aws_default_network_acl" "nacl" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  subnet_ids = local.all_subnet_ids

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "nacl",
      "Name"       = "${var.vpc_name}-NACL"
    }
  )
}

# This is NOT compatible with aws_default_network_acl
# # TODO, decide if NACL should only accept port 80, or just control via SG?
# resource "aws_network_acl_rule" "ip4_in" {
#   network_acl_id = aws_default_network_acl.nacl.id
#   rule_number    = 100
#   egress         = false
#   protocol       = -1
#   rule_action    = "allow"
#   cidr_block     = "0.0.0.0/0"
# }

# resource "aws_network_acl_rule" "ip4_out" {
#   network_acl_id = aws_default_network_acl.nacl.id
#   rule_number    = 100
#   egress         = true
#   protocol       = -1
#   rule_action    = "allow"
#   cidr_block     = "0.0.0.0/0"
# }
