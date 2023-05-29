---
title: AWS Terraform Modules
description: >
  Collection of AWS Terraform modules for personal use.
kind: infrastructure
tags:
  - aws 
  - terraform
github_url: https://github.com/jonzxz/jonnywritesterraform
---

# AWS Terraform Modules
  > Written for practice and previous use-cases. Not all code are "generalized" extensively as some was written with specific purposes. <br/>

## Versions
| Item | Version |
| ---- | ------- |
| Terraform | >=1.3.0 |
| AWS Provider | >=4.0.0 |

## Pre-requisites
This repository and all modules relies on the following pre-requisites:
- Terraform >= v1.3.0

- Terraform can be installed [here](https://learn.hashicorp.com/tutorials/terraform/install-cli)
    - Alternatively, it is strongly recommended to install [Terraform Switcher](https://github.com/warrensbox/terraform-switcher) or [tfenv](https://github.com/tfutils/tfenv) to be able to switch between various versions of Terraform.

## Getting Started
This repository is mainly written as a form of practice and for my own testbed. 

Not all Terraform modules written here will be extensive enough to fit all use cases, and some may even be "scoped" for a particular purpose. **Not all code will work out of the box**.

The modules written here are accumulated over a long period of time, where there may be small differences in how the code is structured.

There may be some issues with the code from time to time, and there will not be active updates as I work on these in my free time.

Disclaimer: The structure of this project is derived from good practices I have learned in my professional capacity. I do not take credit for the project structure, documentation style, etc. However, All code is written by me.

## Project Structure
The repository root contains subdirectories which are Terraform modules (e.g. roles, vpc, security-group) - and in each module's directory will contain a simple README on examples on how to use them.

In each module, there will be the following files -


| Name | Purpose |
| ---- | ------- |
| _variables.tf | Variables supported by the module, including any locals |
| _outputs.tf | Outputs supported by the module |
| providers.tf | Provider configurations indicating minimum Terraform and AWS Provider versions |
| *.tf | Module specific required resources |
| README.md | Overview of the module and what it does |

## Contacts
| Name | Role | Email |
| ---- | ---- | ---- |
| Jonathan Kerk | Owner | contact@jonathankerk.com |
