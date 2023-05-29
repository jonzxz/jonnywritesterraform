
---
title: Autoscaling
description: >
  Represents a generic module to create an Autoscaling group and other resources.
kind: infrastructure
tags:
  - aws 
  - terraform
  - autoscaling

github_url: https://github.com/jonzxz/jonnywritesterraform
---

# Autoscaling
  > Represents a module to create a **scoped** autoscaling group. <br/>
  > This module also creates an IAM role and a security group for the autoscaling group. <br/>
  > This module is ported over from a previous work and was created very specifically to host a NGINX backend. <br/>
  > This is **NOT a generic module (yet)**, but can serve as a good reference. 

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
module "autoscaling" {
  # Relative path from root module
  source       = "../autoscaling"

  service_name = "sample-service"
  vpc_id       = "vpc-12345"
  alb_name     = "sample-alb"
}
```

## Resources
| Name | Type |
| ---- | ---- |
| [aws_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data |
| [aws_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data |
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb_listener) | data |
| [module.role](https://github.com/jonzxz/jonnywritesterraform/tree/master/role) | module |
| [module.security-group](https://github.com/jonzxz/jonnywritesterraform/tree/master/security-group) | module |


## Inputs
| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| additional_tags | Additional tags to add to autoscaling | `map(string)` | `{}` | no |
| alb_name | Name of ALB for autoscaling and target group | `string` | `""` | yes |
| desired_capacity | Desired capacity for autoscaling | `number` | `3` | no |
| health_check_grace_period | Health check grace period before failure | `number` | `300` | no |
| health_check_type | Health check type for ALB | `string` | `ELB` | no |
| instance_type | Type of instance to launch for autoscaling | `string` | `t2.micro` | no |
| listener_rule_type | Listener rule type for ALB | `string` | `forward` | no |
| max_size | Maximum capacity for autoscaling | `number` | `3` | no |
| min_size | Minimum capacity for autoscaling | `number` | `1` | no |
| port | Port number in use for ALB target group | `number` | `80` | no |
| protocol | Protocol for target group and health check | `string` | `HTTP` | no |
| service_name | Service name to launch autoscaling group for | `string` | `nginx` | no |
| vpc_id | VPC ID to launch autoscaling group in | `string` | `""` | yes |

## Outputs
| Name | Description |
| ---- | ----------- |
| autoscaling_az | Availability Zone(s) for autoscaling group. |
| autoscaling_id | ID of autoscaling group. |
| autoscaling_name | Name of autoscaling group. |
| role_arn | ARN of role created for autoscaling. |
| role_name | Name of role created for autoscaling. |
| security_group_arn | ARN of security group created for autoscaling. |
| security_group_id | ID of security group created for autoscaling. |