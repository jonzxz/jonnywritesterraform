# README

## Repository Structure
- Repository contains modules such as `autoscaling`, `bucket`, `loadbalancer` and `autoscaling`.
- These modules are invoked by `playground` to set up a cloud environment stack consisting of VPC, 2 public subnets, 2 private subnets, the relevant route tables (and their entries), NAT, Elastic IPs, bucket for static site and the autoscaling groups.
- Many aspects of this repository / project is extremely barebones, there are **a lot** of quality-of-life components that are missing, but this fulfills the minimum requirements for the submission.

## Further improvements

### Architecture / Infrastructure
1. Since the instances are hosted behind Autoscaling groups with >= 3 instances, it is probably meant to have high availability. In that case, the autoscaling group fleet should **span over 2 subnets** over 2 availability zones
    - Instead of 1 AZ / Subnet, the ASG should declare 2 subnets that is in 2 different AZs in `vpc_security_group_ids`
    - For this project submission, this is actually already modified, which can be seen in `autoscaling_group.tf`.
1. Or actually, since it is a static site, the site can also be hosted in a S3 bucket like done [here](https://github.com/jonzxz/portfolio). It's probably more cost-efficient.
1. It is also a feasible option to make a Dockerfile from the base nginx image and push it to AWS ECR and have the instances pull the image on deploy time and run them. Not really necessary but probably good to have to make the site hosting platform agnostic. 

### CICD Pipeline
1. There is a lot more to be desired for the CI pipelines (I figured I'd need more time for scenario 2, so I didn't do much on this)
1. The first is, we could probably do more with infrastructure in CI. There's some steps that are missing here - which can possibly be `terraform apply` for some of these resources so they can be deployed automatically, or `terraform destroy` to teardown.
1. Secondly, there are some good-to-haves that are missing as well in the CI pipeline, for example a Terraform scan job using `aquasec/tfsec` for validation of Terraform code security
1. The `upload` and `instance-refresh` should have really been in 2 different `job`, or even `stage` - but it's a fairly simple requirement on the CI part so I just left it in the same block. 

### Others
#### Terraform
1. The Terraform code here is really barebones - the modules written in `modules` aren't completely dynamic, given that there are many optional or dynamic parameters that I did not put in (due to time constraint), otherwise the code could've been more versatile.
1. ~~`_outputs.tf` is empty - I'd usually export the important outputs such as `name`, `arn`, `id` for important resources and I `touch _outputs.tf` by default, but in this case it's blank. (I probably need more time for scenario 2)~~
1. Variable validations - I'm missing some `validation` on some crucial variables. While most likely Terraform will flag during `plan` or `apply`, it's probably better to just validate them pre-execution. 
1. ~~I'm missing some cool `pre-commit` I use personally, such as `terraform fmt` and a custom `awk` script that re-orders the variables in `_variables.tf` alphabetically.~~
1. Tagging and naming could use some improvements - there are some resources that are untagged and unnamed, eg. 
    - EBS root device blocks for each autoscaling instance
    - Launch template (default naming to terraformxxxx)
    - Autoscaling instances (missing tag propagations)
    - Again, these can be done, but it does take me some time and does not have functional impact (other than being really, really messy and unidentifiable if there are many things in the account), so I left it be