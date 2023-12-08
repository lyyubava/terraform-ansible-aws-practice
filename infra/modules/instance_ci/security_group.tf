resource "aws_security_group" "this" {
  count  = var.create_ec2_security_group ? 1 : 0
  name   = var.name
  vpc_id = var.vpc_id
}
