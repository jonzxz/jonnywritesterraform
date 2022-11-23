resource "aws_security_group" "autoscaling_security_group" {
  name        = "${var.service_name}-Security-Group"
  description = "Security group for autoscaling group ${var.service_name}"
  vpc_id      = var.vpc_id

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "security-group",
      "Name"       = "${var.service_name}-Security-Group",
    }
  )
}

resource "aws_security_group_rule" "inbound_http" {
  description              = "Allow HTTP Inbound"
  security_group_id        = aws_security_group.autoscaling_security_group.id
  source_security_group_id = data.aws_security_group.lb_sg.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "outbound_https" {
  description       = "Allow HTTPS Outbound"
  security_group_id = aws_security_group.autoscaling_security_group.id
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
}

# Applied on ALB SG
resource "aws_security_group_rule" "outbound_http" {
  description              = "Allow HTTP Outbound to ${var.service_name}-Security-Group"
  source_security_group_id = aws_security_group.autoscaling_security_group.id
  security_group_id        = data.aws_security_group.lb_sg.id
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
}

data "aws_security_group" "lb_sg" {
  name = "${var.alb_name}-Security-Group"
}