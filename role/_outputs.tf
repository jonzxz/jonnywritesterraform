output "id" {
  value = aws_iam_role.this.id
  description = "Name of IAM Role"
}

output "arn" {
  value = aws_iam_role.this.arn
  description = "ARN of IAM Role"
}