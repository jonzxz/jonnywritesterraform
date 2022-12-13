output "autoscaling_az" {
  description = "Availability Zone(s) of Autoscaling group"
  value       = module.nginx_autoscaling.autoscaling_az
}

output "autoscaling_id" {
  description = "ID of Auto Scaling group created"
  value       = module.nginx_autoscaling.autoscaling_id
}

output "autoscaling_name" {
  description = "Name of Auto Scaling group created"
  value       = module.nginx_autoscaling.autoscaling_name
}

output "role_arn" {
  description = "ARN of IAM Role created"
  value       = module.nginx_autoscaling.role_arn
}

output "role_name" {
  description = "Name of IAM Role created"
  value       = module.nginx_autoscaling.role_name
}

output "security_group_arn" {
  description = "ARN of security group created"
  value       = module.nginx_autoscaling.security_group_arn
}

output "security_group_id" {
  description = "ID of security group created"
  value       = module.nginx_autoscaling.security_group_id
}
