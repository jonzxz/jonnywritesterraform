output "bucket_arn" {
  description = "ARN of bucket created"
  value       = aws_s3_bucket.bucket.arn
}

output "bucket_id" {
  description = "ID of bucket created"
  value       = aws_s3_bucket.bucket.id
}
