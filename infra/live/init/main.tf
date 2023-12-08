provider "aws" {
  region = var.region
}

module "init" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket                  = "terraform-state-aekoow9loo7voh4on5p"
  force_destroy           = true
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = aws_kms_key.state_bucket.id

      }
    }
  }
  versioning = {
    enabled = true
  }
}

resource "aws_kms_key" "state_bucket" {
  description             = "encryption key for the state_bucket ${module.init.s3_bucket_bucket_domain_name}"
  deletion_window_in_days = 30
}
