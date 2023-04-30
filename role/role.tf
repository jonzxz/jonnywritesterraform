# IAM Role
resource "aws_iam_role" "this" {
  name               = var.role_name
  path               = var.path
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  description        = local.role_description

  tags = merge(local.tags, {
    "Description" = "Role for ${var.role_name}"
  })
}

# Attachment of AWS managed policies to role
resource "aws_iam_role_policy_attachment" "aws_managed_policies" {
  for_each   = toset(var.aws_policies_arn)
  role       = aws_iam_role.this.id
  policy_arn = each.key
}

# Attachment of custom policies to r ole
resource "aws_iam_role_policy_attachment" "custom_policy" {
  for_each   = toset(var.custom_policies)
  role       = aws_iam_role.this.id
  policy_arn = each.key.arn
}

# Custom policy, creates one if var.custom_policies is defined
# Takes the policy of merged_custom_policies
resource "aws_iam_policy" "custom_policy" {
  for_each    = toset(length(var.custom_policies) > 0 ? ["1"] : [])
  name        = var.role_name
  path        = "/"
  policy      = data.aws_iam_policy_document.merged_custom_policies.json
  description = local.policy_description
  tags = merge(local.tags, {
    "Description" = "IAM Policy for ${var.role_name}"
  })
}

# Data for var.custom_policies which contains a list of json policy statements
# This merges all the custom policies into a single one which is then used by
# custom_policy to create an all-in-one policy for each role 
data "aws_iam_policy_document" "merged_custom_policies" {
  source_policy_documents = var.custom_policies
}

# Assume role policy JSON
data "aws_iam_policy_document" "assume_role_json" {
  statement {
    sid     = "AllowAWSAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["${var.aws_service}.amazonaws.com"]
    }
  }
}

# Assume role policy to be used by the role
data "aws_iam_policy_document" "assume_role" {
  source_json = data.aws_iam_policy_document.assume_role_json.json
}