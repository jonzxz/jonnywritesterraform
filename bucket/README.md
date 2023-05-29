
---
title: Bucket
description: >
  Represents a generic module to create a S3 Bucket.
kind: infrastructure
tags:
  - aws 
  - terraform
  - bucket

github_url: https://github.com/jonzxz/jonnywritesterraform
---

# Bucket
  > Represents a module to create a generic S3 bucket. <br/>
  > The bucket is created by default to be private and with versioning disabled. <br/>

## Versions
| Item | Version |
| ---- | ------- |
| Terraform | >=1.3.0 |
| AWS Provider | >=4.0.0 |

## Providers
| Name | Version |
| ---- | ------- |
| AWS Provider | >=4.0.0 |

## Examples 
### Basic
```terraform
module "bucket" {
  # Relative path from root module
  source      = "../bucket"

  bucket_name = "sample-bucket"
}
```

## Resources
| Name | Type |
| ---- | ---- |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_server_side_encryption_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |

## Inputs
| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| additional_tags | Additional tags to add to role | `map(string)` | `{}` | no |
| bucket_name | Name of S3 bucket to create | `string` | `""` | yes |
| public_access_config | Public access block configuration | `map(map(bool))` | `{ acl { ...true... }}` | no |
| versioning | Versioning configuration | `string` | `Disabled` | no |

## Outputs
| Name | Description |
| ---- | ----------- |
| bucket_id | ID of bucket created. |
| bucket_arn | ARN of bucket created. |