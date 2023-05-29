
---
title: EC2
description: >
  Represents a generic module to create an EC2 instance.
kind: infrastructure
tags:
  - aws 
  - terraform
  - ec2

github_url: https://github.com/jonzxz/jonnywritesterraform
---

# EC2
  > Represents a module to create a generic EC2 instance. <br/>

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
module "instance" {
  # Relative path from root module
  source                 = "../instance"

  subnet_id              = "subnet-12345"

  vpc_security_group_ids = ["sg-12345", "sg-67890"]
  
  tags = {
    Name = "sample-ec2"
  }
}
```

## Resources
| Name | Type |
| ---- | ---- |
| [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ec2_tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data |

## Inputs
| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| additional_tags | Additional tags to add to instance | `map(string)` | `{}` | no |
| instance_type | Instance type for the server | `string` | `t3.small` | no |
| key_name | SSH Key to attach to instance | `string` | `null` | no |
| subnet_id | ID of subnet to create instance in | `string` | `""` | yes |
| vpc_security_group_ids | List of security group IDs to attach to instance | `list(string)` | `""` | yes |
| iam_instance_profile | Name of IAM instance profile to attach to instance | `string` | `""` | no |
| root_block_volume_size | Size of root EBS block volume | `number` | `8` | no |
| root_block_volume_type | Type of root EBS block volume | `string` | `gp2` | no |
| user_data_base64 | Base64 encoded user data for instance startup | `string` | `null` | no |

## Outputs
| Name | Description |
| ---- | ----------- |
| arn | ARN of instance created. |