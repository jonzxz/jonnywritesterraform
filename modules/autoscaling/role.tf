resource "aws_iam_role" "instance_role" {
  name               = "${var.service_name}-role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role.json

  tags = {
    Name = "role for ${var.service_name}"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.service_name}-instance-profile"
  role = aws_iam_role.instance_role.id
}

resource "aws_iam_role_policy" "policy" {
  name   = "${var.service_name}-inline-policy"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.allow_s3_access.json
}

resource "aws_iam_role_policy_attachment" "ssm_attachment" {
  role       = aws_iam_role.instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
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

data "aws_iam_policy_document" "instance_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_s3_bucket" "nginx_bucket" {
  bucket = local.nginx_bucket_name
}
