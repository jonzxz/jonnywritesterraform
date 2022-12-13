terraform {
  backend "s3" {
    bucket = "jonny-multi-purpose-bucket"
    key    = "terraform/playground/nginx-autoscaling/terraform.tfstate"
    region = "ap-southeast-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.40.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"

  default_tags {
    tags = {
      "Contact" : "contact@jonathankerk.com"
    }
  }
}