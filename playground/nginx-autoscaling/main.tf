module "nginx_autoscaling" {
  source = "../../modules/autoscaling"

  service_name = "nginx"
  vpc_id       = data.aws_vpc.vpc.id
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["Jonny-Mini-VPC"]
  }
}