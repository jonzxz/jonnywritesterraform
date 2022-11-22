module "alb" {
  source = "../../modules/loadbalancer"
  vpc_id = data.aws_vpc.vpc.id
  name   = var.name
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["Jonny-Mini-VPC"]
  }
}