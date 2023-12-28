terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = local.region
}

locals {
  name   = "petadoption-workshop"
  region = "us-east-1"

  vpc_cidr = "11.0.0.0/16"
  azs      = ["us-east-1a", "us-east-1b"]

  public_subnets  = ["11.0.1.0/24", "11.0.2.0/24"]
  private_subnets = ["11.0.3.0/24", "11.0.4.0/24"]
  intra_subnets   = ["11.0.5.0/24", "11.0.6.0/24"]

  tags = {
    Workshop = true
  }
}
