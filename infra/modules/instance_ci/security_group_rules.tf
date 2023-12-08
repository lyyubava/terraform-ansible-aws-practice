resource "aws_security_group_rule" "ec2-all-out" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.create_ec2_security_group ? aws_security_group.this[0].id : var.ec2_security_group
}
