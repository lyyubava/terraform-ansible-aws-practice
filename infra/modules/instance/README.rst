aws_jenkins_ci
==============

Usage
=====
::

  module "ci" {
    #source             = "git@git.opinov8.com:devops/terraform/modules/aws_jenkins_ci.git?ref=$TAB"
    name               = "ci"
    ec2_security_group = data.terraform_remote_state.security_groups.outputs.security_group_ids["ci-ec2"]
    elb_security_group = data.terraform_remote_state.security_groups.outputs.security_group_ids["ci-elb"]
    ec2_subnet         = data.terraform_remote_state.vpc.outputs.subnet_ids["private_us-east-1a"]
    vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
    domain             = "ci.EXAMPLE.COM"
    ec2_iam_role_name  = "ci-ec2"
    availability_zone  = "us-east-1a"

    # Optional, omit if 3rd party DNS provider in use.
    route53_zone_id    = data.terraform_remote_state.domains.outputs.example-com-zone-id
  
    elb_subnets = [
      data.terraform_remote_state.vpc.outputs.subnet_ids["private_us-east-1a"],
      data.terraform_remote_state.vpc.outputs.subnet_ids["private_us-east-1b"]
    ]
  
    ssh_keys = [
        "key1",
        "key2"
    ]
  }
