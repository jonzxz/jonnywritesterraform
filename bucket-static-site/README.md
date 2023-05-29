
```doc
title: Bucket (Static Site)
description: >
  Represents a generic module to create a S3 Bucket for Static website hosting.
kind: infrastructure
tags:
  - aws 
  - terraform
  - bucket

github_url: https://github.com/jonzxz/jonnywritesterraform
```

---

# Bucket (Static Site)
  > Represents a module to create a generic S3 bucket for static site hosting. <br/>
  > This bucket was created for my portfolio [site](https://jonathankerk.com), where this module was initially written. This is a port, things will likely not work because they are not generic enough. <br/>
  > Websites hosted from this bucket **must** be proxied through Cloudflare DNS. <br/>
  > This module assumes code are built in `build/` folder, which probably will **not work** for now because the relative pathing is likely incorrect. <br/>
  > This is **not a generic module (yet)**. <br/>

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
  source          = "../bucket-static-site"

  bucket_name     = "sample-bucket"
  redirected_host = "myactualurl.com"
}
```

## Resources
| Name | Type |
| ---- | ---- |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_ownership_controls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data |

## Inputs
| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| tags | Additional tags to add to bucket | `map(string)` | `{}` | no |
| bucket_name | Name of S3 bucket to create | `string` | `""` | yes |
| public_access_config | Public access block configuration | `map(map(bool))` | `{ acl { ...true... }}` | no |
| versioning | Versioning configuration | `string` | `Disabled` | no |
| website | Static site page configurations | `any` | `{ index_doc...}` | no |
| redirected_host | URL of site to be redicted to | `string` | `null` | no |

## Outputs
| Name | Description |
| ---- | ----------- |
| bucket_id | ID of bucket created. |
| bucket_arn | ARN of bucket created. |