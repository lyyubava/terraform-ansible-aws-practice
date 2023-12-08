terraform {
  backend "s3" {
    key = "vpc"
  }
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  filter {
    name   = "region-name"
    values = [var.region]
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = var.name
  cidr = var.cidr
  azs                               = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets                   = var.private_subnets
  public_subnets                    = var.public_subnets
  enable_nat_gateway                = true
  create_igw                        = true
  create_database_nat_gateway_route = true
}
