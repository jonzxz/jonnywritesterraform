resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = merge(
    local.tags,
    var.additional_tags,
    {
      "ops/module" = "bucket",
      "Name"       = var.bucket_name
    }
  )
}


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_config" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.bucket.id

  for_each                = var.public_access_config
  block_public_acls       = each.value.block_public_acls
  block_public_policy     = each.value.block_public_policy
  ignore_public_acls      = each.value.ignore_public_acls
  restrict_public_buckets = each.value.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "ownership_control" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
