output "kms_key_arn" {
  value = aws_kms_key.this.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "ec2_security_group_id" {
  value = var.create_ec2_security_group ? aws_security_group.this[0].id : var.create_ec2_security_group
}

