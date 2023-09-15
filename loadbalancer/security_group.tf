module "lb_security_group" {
  source = "../security-group"

  name        = "${var.name}-security-group"
  description = "Security group for LB ${var.name}"
  vpc_id      = data.aws_vpc.vpc.id

  additional_tags = merge(local.tags, var.additional_tags)

  rules = {
    inbound_http = {
      type        = "ingress"
      from_port   = "80"
      to_port     = "80"
      protocol    = "tcp"
      description = "Allow HTTP inbound"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}