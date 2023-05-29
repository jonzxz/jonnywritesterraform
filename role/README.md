
```doc
title: Role
description: >
  Represents a generic module to create a IAM Role.
kind: infrastructure
tags:
  - aws 
  - terraform
  - role

github_url: https://github.com/jonzxz/jonnywritesterraform
```

---

# Role
  > Represents a module to create a generic IAM Role. <br/>
  > The module takes in a list of Amazon managed policies ARN, as well as a list of custom policies' `json` data which is flattened into a single inline policy for the role. <br/>

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
module "role" {
  # Relative path from root module
  source = "../role"
}
```

### EC2
```terraform
module "role" {
  # Relative path from root module
  source           = "../role"

  role_name        = "my-sample-role"
  aws_service      = "ec2"

  aws_policies_arn = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]

  custom_policy    = [data.aws_iam_policy_document.sample_policy.json]

}

data "aws_iam_policy_document "sample_policy" {
  statement {

  }
  ...
}

```
## Resources
| Name | Type |
| ---- | ---- |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data |

## Inputs
| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| additional_tags | Additional tags to add to role | `map(string)` | `{}` | no |
| aws_policies_arn | ARN of AWS managed policies | `list(string)` | `[]` | no |
| custom_policies | JSON data of custom policies in a list | `list(string)` | `[]` | no |
| role_description | Description of IAM role | `string` | `""` | no |
| policy_description | Description of flattented IAM policy for role | `string` | `""` | no |
| aws_service | AWS service to allow assume role of the role | `string` | `""` | no |
| role_name | Name of role to create, used in `tag:Name` | `string` | `""` | yes |
| path | Path of role in IAM | `string` | `/` | no |

## Outputs
| Name | Description |
| ---- | ----------- |
| id | ID of the role. |
| arn | Amazon Resource Name (ARN) of the role. |