output "bucket_arn" {
  description = "ARN of bucket created"
  value       = module.nginx_bucket.bucket_arn
}

output "bucket_id" {
  description = "ID of bucket created"
  value       = module.nginx_bucket.bucket_id
}
