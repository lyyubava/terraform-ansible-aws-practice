output "ec2_security_group_id" {
  value = var.create_ec2_security_group ? aws_security_group.this[0].id : var.create_ec2_security_group
}

output "ec2_public_ip" {
  value = try(aws_eip.this[0].public_ip, "")
}

output "ec2_private_ip" {
  value = aws_instance.this.private_ip
}
