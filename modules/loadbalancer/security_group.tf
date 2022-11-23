resource "aws_security_group" "lb_sec_group" {
  name        = "${var.name}-Security-Group"
  description = "Security group for ALB ${var.name}"
  vpc_id      = var.vpc_id

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "security-group",
      "Name"       = "${var.name}-Security-Group",
    }
  )
}

resource "aws_security_group_rule" "inbound_http" {
  description       = "Allow HTTP Inbound"
  security_group_id = aws_security_group.lb_sec_group.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
