resource "aws_lb" "alb" {
  name = var.name

  internal           = var.is_lb_internal
  load_balancer_type = "application"

  security_groups = [module.lb_security_group.id]

  drop_invalid_header_fields = true

  preserve_host_header = false

  subnets = [for subnet in data.aws_subnet.public_subnet : subnet.id]

  idle_timeout = var.idle_timeout_duration


  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "loadbalancer",
      "Name"       = var.name
    }
  )
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Oops, I wasn't ready for this"
      status_code  = "200"
    }
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*Public*"]
  }
}

data "aws_subnet" "public_subnet" {
  for_each = toset(data.aws_subnets.public_subnets.ids)
  id       = each.value
}
