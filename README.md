# README

# What is this?
- This repository contains half-practice, half-online assessment codes. Terraform modules created here like VPC, buckets are most likely to be reused when I am practicing or doing some other online assessments.

## Repository Structure
- Repository contains modules such as `autoscaling`, `bucket`, `loadbalancer` and `autoscaling`.
- These modules are currently invoked by the `nginx-autoscaling` branch to set up a cloud environment stack consisting of VPC, 2 public subnets, 2 private subnets, the relevant route tables (and their entries), NAT, Elastic IPs, bucket for static site and the autoscaling groups.
- Many aspects of this repository / project is extremely barebones, there are **a lot** of missing stuff for now until I work on them again.
- In particular, the `autoscaling` and `loadbalancer` modules were built for an online assessment for a job interview so some variables might not make too much sense. If you are interested, do check [this](https://github.com/jonzxz/jonnywritesterraform/tree/OA-nginx-autoscaling) out 

## Further improvements
### Terraform
1. The Terraform code here is really barebones - the modules written in `modules` aren't completely dynamic, given that there are many optional or dynamic parameters that I did not put in (for now), otherwise the code could've been more versatile.
1. Variable validations - I'm missing some `validation` on some crucial variables. While most likely Terraform will flag during `plan` or `apply`, it's probably better to just validate them pre-execution. 
1. Tagging and naming could use some improvements - there are some resources that are untagged and unnamed, eg. 
    - EBS root device blocks for each autoscaling instance
    - Launch template (default naming to terraformxxxx)
    - Autoscaling instances (missing tag propagations)
    - Again, these can be done, but it does take me some time and does not have functional impact (other than being really, really messy and unidentifiable if there are many things in the account), so I left it be