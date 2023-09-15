output "lb_id" {
  description = "ID of Load Balancer created"
  value       = aws_lb.alb.id
}

output "lb_name" {
  description = "Name of Load Balancer created"
  value       = aws_lb.alb.name
}
