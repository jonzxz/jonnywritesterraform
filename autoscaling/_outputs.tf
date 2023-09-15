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
  value       = module.asg_role.arn
}

output "role_id" {
  description = "ID of IAM Role created"
  value       = module.asg_role.id
}

output "security_group_id" {
  description = "ID of security group created"
  value       = module.asg_security_group.id
}
