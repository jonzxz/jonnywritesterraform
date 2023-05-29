resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = merge(local.tags, var.tags)

  force_destroy = false
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = var.versioning
  }
}

resource "aws_s3_bucket_website_configuration" "redirection" {
  count  = local.redirect_bucket
  bucket = aws_s3_bucket.bucket.id

  redirect_all_requests_to {
    host_name = var.redirected_host
    protocol  = "https"
  }
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  count  = local.host_bucket
  bucket = aws_s3_bucket.bucket.id

  dynamic "index_document" {
    for_each = try([var.website["index_doc"]], [])
    content {
      suffix = index_document.value
    }
  }

  dynamic "error_document" {
    for_each = try([var.website["error_doc"]], [])
    content {
      key = error_document.value
    }
  }

  dynamic "routing_rule" {
    for_each = try([var.website["routing_rule"]], [])
    content {
      dynamic "condition" {
        for_each = try(var.website["routing_rule"]["condition"], null)
        content {
          key_prefix_equals = condition.value
        }
      }
      redirect {
        host_name               = try(routing_rule.value.redirect["host_name"], null)
        http_redirect_code      = try(routing_rule.value.redirect["http_redirect_code"], null)
        protocol                = try(routing_rule.value.redirect["protocol"], null)
        replace_key_prefix_with = try(routing_rule.value.redirect["replace_key_prefix_with"], null)
        replace_key_with        = try(routing_rule.value.redirect["replace_key_with"], null)
      }
    }
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

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.cloudflare_dns.json
}

data "aws_iam_policy_document" "cloudflare_dns" {
  statement {
    sid = "CloudflareAllowGetObject"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    condition {
      test     = "IpAddress"
      variable = "aws:sourceIp"
      values = [
        "173.245.48.0/20",
        "103.21.244.0/22",
        "103.22.200.0/22",
        "103.31.4.0/22",
        "141.101.64.0/18",
        "108.162.192.0/18",
        "190.93.240.0/20",
        "188.114.96.0/20",
        "197.234.240.0/22",
        "198.41.128.0/17",
        "162.158.0.0/15",
        "104.16.0.0/13",
        "104.24.0.0/14",
        "172.64.0.0/13",
        "131.0.72.0/22"
      ]
    }
    resources = [
      aws_s3_bucket.bucket.arn,
      "${aws_s3_bucket.bucket.arn}/*"
    ]
  }
}

resource "aws_s3_object" "static_files" {
  for_each = local.host_bucket > 0 ? fileset("${path.module}/../../../", "build/**/*") : []

  bucket             = aws_s3_bucket.bucket.id
  bucket_key_enabled = true
  key                = replace(each.value, "build/", "")
  source             = "${path.module}/../../../${each.value}"
  content_type       = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}