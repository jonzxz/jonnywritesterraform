# TODO:
#   1. Make custom_policies modifiable
#     Actually review how we want to modify custom_policies
#     because this is copied from another repository where I wrote
#     this module for a specific usage

module "asg_role" {
  source = "../role"

  aws_policies_arn = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  custom_policies = [
    data.aws_iam_policy_document.allow_s3_access.json
  ]

  role_description   = "Role for ${var.service_name}"
  policy_description = "Policy for ${var.service_name}"
  aws_service        = "ec2"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.service_name}-instance-profile"
  role = module.asg_role.id
}

data "aws_iam_policy_document" "allow_s3_access" {
  statement {
    actions = [
      "s3:*"
    ]
    effect = "Allow"
    resources = [
      "${data.aws_s3_bucket.nginx_bucket.arn}",
      "${data.aws_s3_bucket.nginx_bucket.arn}/*",
    ]
  }
}

data "aws_s3_bucket" "nginx_bucket" {
  bucket = local.nginx_bucket_name
}
