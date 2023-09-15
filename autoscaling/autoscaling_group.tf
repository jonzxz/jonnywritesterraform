resource "aws_autoscaling_group" "autoscaling" {
  name                      = "${var.service_name}-autoscaling"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity

  vpc_zone_identifier = [for subnet in data.aws_subnet.private_subnet : subnet.id]

  target_group_arns = [aws_lb_target_group.target_group.arn]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

}

resource "aws_launch_template" "launch_template" {

  image_id      = data.aws_ami.amzn_linux2_ami.id
  instance_type = var.instance_type

  iam_instance_profile {
    arn = aws_iam_instance_profile.instance_profile.arn
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  vpc_security_group_ids = [module.asg_security_group.id]

  user_data = var.bootstrap_file_name

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "launch-template",
      "Name"       = "${var.service_name}-launch-template"
    }
  )
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.service_name}-target-group"
  target_type = "instance"
  port        = var.port
  protocol    = var.protocol
  vpc_id      = data.aws_vpc.vpc.id

  health_check {
    path     = "/"
    protocol = var.protocol
    matcher  = "200"
  }

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "launch-template",
      "Name"       = "${var.service_name}-launch-template",
    }
  )
}

resource "aws_lb_listener_rule" "listener_rule" {
  listener_arn = data.aws_lb_listener.http_listener.arn

  action {
    type = var.listener_rule_type

    target_group_arn = aws_lb_target_group.target_group.arn
  }

  condition {
    source_ip {
      values = ["0.0.0.0/0"]
    }
  }
}

data "aws_ami" "amzn_linux2_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = ["*Private*"]
  }
}

data "aws_subnet" "private_subnet" {
  for_each = toset(data.aws_subnets.private_subnets.ids)
  id       = each.value
}

data "aws_lb" "loadbalancer" {
  name = var.alb_name
}

data "aws_lb_listener" "http_listener" {
  load_balancer_arn = data.aws_lb.loadbalancer.arn
  port              = 80
}
