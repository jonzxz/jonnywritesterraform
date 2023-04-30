resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(local.tags, {})

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "rule" {
  for_each          = var.rules
  security_group_id = aws_security_group.this.id

  type                     = lookup(each.value, "type", null)
  from_port                = lookup(each.value, "from_port", -1)
  to_port                  = lookup(each.value, "to_port", -1)
  protocol                 = lookup(each.value, "protocol", "tcp")
  cidr_blocks              = lookup(each.value, "cidr_blocks", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
  self                     = lookup(each.value, "self", null)
  description              = lookup(each.value, "description", "Managed by Terraform")
  ipv6_cidr_blocks         = lookup(each.value, "ipv6_cidr_blocks", null)
  prefix_list_ids          = lookup(each.value, "prefix_list_ids", null)
}