output "autoscaling_az" {
  description = "Availability Zone(s) of Autoscaling group"
  value       = aws_autoscaling_group.autoscaling.availability_zones
}

output "autoscaling_id" {
  description = "ID of Auto Scaling group created"
  value       = aws_autoscaling_group.autoscaling.id
}

output "autoscaling_name" {
  description = "Name of Auto Scaling group created"
  value       = aws_autoscaling_group.autoscaling.name
}

output "role_arn" {
  description = "ARN of IAM Role created"
  value       = aws_iam_role.instance_role.arn
}

output "role_name" {
  description = "Name of IAM Role created"
  value       = aws_iam_role.instance_role.name
}

output "security_group_arn" {
  description = "ARN of security group created"
  value       = aws_security_group.autoscaling_security_group.arn
}

output "security_group_id" {
  description = "ID of security group created"
  value       = aws_security_group.autoscaling_security_group.id
}
