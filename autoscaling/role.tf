# TODO:
#   1. Make custom_policies modifiable
#     Actually review how we want to modify custom_policies
#     because this is copied from another repository where I wrote
#     this module for a specific usage

module "asg_role" {
  source    = "../role"
  role_name = "${var.service_name}-role"

  aws_policies_arn = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  custom_policies = var.custom_policies

  role_description   = "Role for ${var.service_name}"
  policy_description = "Policy for ${var.service_name}"
  aws_service        = "ec2"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.service_name}-instance-profile"
  role = module.asg_role.id
}