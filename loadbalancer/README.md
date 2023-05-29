
---
title: Load Balancer
description: >
  Represents a generic module to create an Application Load Balancer.
kind: infrastructure
tags:
  - aws 
  - terraform
  - alb

github_url: https://github.com/jonzxz/jonnywritesterraform
---

# Load Balancer
  > Represents a module to create a generic Application Load Balancer for HTTP traffic only. <br/>
  > The LB will be created in subnets where the subnet name fits the `*Public*` search criteria. This is **not a generic module (yet)**.

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
module "lb" {
  # Relative path from root module
  source = "../loadbalancer"

  name   = "sample-alb"
  vpc_id = "vpc-12345"
}
```

## Resources
| Name | Type |
| ---- | ---- |
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data |


## Inputs
| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| additional_tags | Additional tags to add to role | `map(string)` | `{}` | no |
| idle_timeout_duration | Idle timeout duration for ALB | `string` | `60` | no |
| is_lb_internal | Toggle flag if ALB is internal facing | `bool` | `false` | no |
| name | Name of ALB | `string` | `""` | yes |
| vpc_id | ID of VPC to create ALB in | `string` | `""` | yes |

## Outputs
| Name | Description |
| ---- | ----------- |
| lb_id | ID of ALB created. |