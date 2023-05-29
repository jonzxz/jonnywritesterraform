
---
title: Security Group
description: >
  Represents a generic module to create a Security Group.
kind: infrastructure
tags:
  - aws 
  - terraform
  - security-group

github_url: https://github.com/jonzxz/jonnywritesterraform
---

# Role
  > Represents a module to create a generic Security Group. <br/>
  > The module takes in a map of map(any) of security group rules to apply to the security group <br/>

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
module "security_group" {
  # Relative path from root module
  source      = "../security-group"
  
  name        = "sample-security-group"
  description = "Sample Security Group"
  vpc_id      = "vpc-12345"

  rules = {
    allow_http_ingress = {
      description = "Allow HTTP in"
      type = "ingress"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    allow_ssh_jumpbox = {
      description = "Allow SSH from jumpbox"
      type = "ingress"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      source_security_group_id = "sg-12345"
    }
  }
}
```

## Resources
| Name | Type |
| ---- | ---- |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs
| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| additional_tags | Additional tags to add to role | `map(string)` | `{}` | no |
| description | Description for the security group | `string` | `""` | yes |
| name | Name of the security group | `string` | `""` | yes |
| rules | Rules for the security group | `any` | `{}` | no |
| vpc_id | ID of the VPC to create security group | `string` | `""` | yes |

## Outputs
| Name | Description |
| ---- | ----------- |
| id | ID of the Security Group. |