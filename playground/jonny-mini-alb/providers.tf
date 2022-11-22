terraform {
  backend "local" {}

  # TODO, actually make a bucket
  # backend "s3" {
  #   bucket = "jonny-terraform-bucket.jonathankerk.com"
  #   key = "playground/jonny-mini-vpc/terraform.tfstate"
  #   region = "ap-southeast-1"
  # }

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