resource "aws_security_group_rule" "ssh_in_traefik" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.traefik_instance.ec2_security_group_id
}

resource "aws_security_group_rule" "http_in_traefik" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.traefik_instance.ec2_security_group_id
}

resource "aws_security_group_rule" "ssh_in_wordpress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.traefik_instance.ec2_security_group_id
  security_group_id        = module.wordpress_instance.ec2_security_group_id
}

resource "aws_security_group_rule" "mysql_in" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.wordpress_instance.ec2_security_group_id
  security_group_id        = module.db_instance.ec2_security_group_id
}

resource "aws_security_group_rule" "ssh_in_ci" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ci_instance.ec2_security_group_id

}

resource "aws_security_group_rule" "wordpress_in_ci" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.wordpress_instance.ec2_security_group_id
  source_security_group_id = module.ci_instance.ec2_security_group_id
}

resource "aws_security_group_rule" "database_in_ci" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.db_instance.ec2_security_group_id
  source_security_group_id = module.ci_instance.ec2_security_group_id
}


resource "aws_security_group_rule" "traefik_in_ci" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.traefik_instance.ec2_security_group_id
  source_security_group_id = module.ci_instance.ec2_security_group_id
}
