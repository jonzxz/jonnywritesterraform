output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}

output "website_endpoint" {
  value = aws_s3_bucket.bucket.website_endpoint
}
