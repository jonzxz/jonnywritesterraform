module "asg_security_group" {
  source = "../security-group"

  name        = "${var.service_name}-security-group"
  description = "Security group for autoscaling group ${var.service_name}"
  vpc_id      = var.vpc_id
  rules = {
    inbound_http = {
      type                     = "ingress"
      from_port                = "80"
      to_port                  = "80"
      protocol                 = "tcp"
      description              = "Allow HTTP inbound"
      source_security_group_id = data.aws_security_group.lb_sg.id
    },
    outbound_https = {
      type        = "egress"
      from_port   = "443"
      to_port     = "443"
      protocol    = "tcp"
      description = "Allow HTTPS output"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

# Applied on ALB SG
resource "aws_security_group_rule" "outbound_http" {
  description              = "Allow HTTP Outbound to ${var.service_name}-Security-Group"
  source_security_group_id = module.asg_security_group.id
  security_group_id        = data.aws_security_group.lb_sg.id
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
}

data "aws_security_group" "lb_sg" {
  name = "${var.alb_name}-Security-Group"
}