provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    key = "instances"
  }
}


data "aws_availability_zones" "available" {
  filter {
    name   = "region-name"
    values = [var.region]
  }
}

data "aws_ami" "debian_10" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-10-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  owners = ["136693071363"]
}

module "wordpress_instance" {
  source                    = "../../modules/instance"
  name                      = var.wordpress_instance.name
  create_ec2_security_group = var.wordpress_instance.create_ec2_security_group
  ec2_subnet                = data.terraform_remote_state.vpc.outputs.vpc_private_subnets[0]
  vpc_id                    = data.terraform_remote_state.vpc.outputs.vpc_id
  ami_id                    = data.aws_ami.debian_10.id
  ssh_keys                  = var.wordpress_instance.ssh_keys
  availability_zone         = data.aws_availability_zones.available.names[0]
  instance_type             = var.wordpress_instance.instance_type
  stateful                  = var.wordpress_instance.stateful
  mountpoint                = var.wordpress_instance.mountpoint
  tags                      = { "Name" : var.wordpress_instance.name }
}

module "traefik_instance" {
  source                    = "../../modules/instance"
  name                      = var.traefik_instance.name
  create_ec2_security_group = var.traefik_instance.create_ec2_security_group
  ec2_subnet                = data.terraform_remote_state.vpc.outputs.vpc_public_subnets[0]
  vpc_id                    = data.terraform_remote_state.vpc.outputs.vpc_id
  ami_id                    = data.aws_ami.debian_10.id
  ssh_keys                  = var.traefik_instance.ssh_keys
  availability_zone         = data.aws_availability_zones.available.names[0]
  instance_type             = var.traefik_instance.instance_type
  stateful                  = var.traefik_instance.stateful
  attach_public_ip          = true
  tags                      = { "Name" : var.traefik_instance.name }
}

module "ci_instance" {
  source                    = "../../modules/instance_ci"
  name                      = var.ci_instance.name
  create_ec2_security_group = var.ci_instance.create_ec2_security_group
  ec2_subnet                = data.terraform_remote_state.vpc.outputs.vpc_public_subnets[0]
  vpc_id                    = data.terraform_remote_state.vpc.outputs.vpc_id
  ami_id                    = data.aws_ami.debian_10.id
  ssh_keys                  = var.ci_instance.ssh_keys
  availability_zone         = data.aws_availability_zones.available.names[0]
  instance_type             = var.ci_instance.instance_type
  stateful                  = var.ci_instance.stateful
  attach_public_ip          = true
  database_private_ip       = module.db_instance.ec2_private_ip
  wordpress_private_ip      = module.wordpress_instance.ec2_private_ip
  traefik_public_ip         = module.traefik_instance.ec2_public_ip
  tags                      = { "Name" : var.ci_instance.name }
}

module "db_instance" {
  source                    = "../../modules/instance"
  name                      = var.db_instance.name
  create_ec2_security_group = var.db_instance.create_ec2_security_group
  ec2_subnet                = data.terraform_remote_state.vpc.outputs.vpc_private_subnets[0]
  vpc_id                    = data.terraform_remote_state.vpc.outputs.vpc_id
  ami_id                    = data.aws_ami.debian_10.id
  ssh_keys                  = var.db_instance.ssh_keys
  availability_zone         = data.aws_availability_zones.available.names[0]
  instance_type             = var.db_instance.instance_type
  stateful                  = var.db_instance.stateful
  mountpoint                = var.db_instance.mountpoint
  tags                      = { "Name" : var.db_instance.name }
}
