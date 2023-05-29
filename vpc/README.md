
```doc
title: VPC
description: >
  Represents a generic module to create a standard 3-tiered VPC with public and private subnets.
kind: infrastructure
tags:
  - aws 
  - terraform
  - vpc

github_url: https://github.com/jonzxz/jonnywritesterraform
```

---

# VPC
  > Represents a module to create a generic 3 tiered VPC. <br/>
  > This module creates a VPC, along with 2 public subnets, 2 private subnets, required NACLs, along with route tables, routes, NAT and IGWs. <br/>
  > The module's main purpose is to create a working VPC that allows instances to be hosted in the private zone while getting Internet access via a NAT and IGW. <br/>
  > Disclaimer: Creating this **will** incur cost due to EIPs and NAT gateways. <br/>

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
module "vpc" {
  # Relative path from root module
  source     = "../vpc"

  name       = "sample-vpc"
  cidr_block = "172.1.2.0/24"
}
```

## Resources
| Name | Type |
| ---- | ---- |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_default_network_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl) | resource |
| [aws_network_acl_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |

## Inputs
| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| additional_tags | Additional tags to add to ALB | `map(string)` | `{}` | no |
| cidr_block | VPC CIDR Range | `string` | `""` | yes |
| enable_dns_hostnames | Toggle flag to enable DNS hostnames | `bool` | `true` | no |
| enable_dns_support | Toggle flag to enable DNS support | `bool` | `true` | no |
| enable_ipv6 | Toggle flag to enable IPv6 | `bool` | `false` | no |
| instance_tenancy | Instance tenancy for EC2 | `string` | `default` | no |
| vpc_name | Name of VPC to create | `string` | `""` | yes |

## Outputs
| Name | Description |
| ---- | ----------- |
| vpc_id | ID of VPC created. |