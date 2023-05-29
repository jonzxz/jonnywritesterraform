output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "website_endpoint" {
  value = aws_s3_bucket.bucket.website_endpoint
}